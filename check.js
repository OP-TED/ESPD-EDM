#!/usr/bin/env node

/*
 * NodeJS application to check UUID generated in Excel for ESPD v4.0.0
 *
 * 1. Check that the tags created for each element are correct and the numbering corresponds to nesting level
 * 2. Check that the generated path is valid according to the UUID generation algorithm
 * 3. Other functionalities to extact information from the Excel file
 *
 */

var XLSX = require("xlsx");
var chalk = require("chalk");
const axios = require("axios");
const { HttpsProxyAgent } = require("https-proxy-agent");

var proxy_user = "",
    proxy_password = "",
    proxy_server = "proxy-t2-lu.welcome.ec.europa.eu",
    proxy_port = "8012";

var fs = require("fs");

const { program } = require("@caporal/core");

const {
    cols,
    tag_map,
    namespace_map,
    invalid_criterion,
} = require("./modules/espd_constants.cjs");

var in_excel_we_trust = ["./criterion/ESPD-criterion_v4.0.0.xlsx"];

const log = console.log;

var counter = {
    C: 0,
    ADL: 1,
    SBC: 1,
    L: 1,
    RG: 1,
    QG: 1,
    RSG: 1,
    QSG: 1,
    CA: 1,
    RQ: 1,
    Q: 1,
    R: 1,
    RV: 1,
    RES: 1,
    RAP: 1,
},
    element_children = {},
    pdt_list = [];

XLSX.set_fs(fs);

program
    .version("1.0.0")
    .name("checkjs")
    .description("Tool to handle Criterion Excel files")

    .command("all_JSON", "Print all spreadsheets as JSON")
    .argument("<excelfile>", "Excel Criterion file to be processed")
    .action(({ logger, args, options }) => {
        // Combine styled and normal strings
        log(chalk.bold(`Processing ${args.excelfile}`), "\n\n");
        in_excel_we_trust = [args.excelfile];

        in_excel_we_trust.forEach((xcl) => {
            var wbk = XLSX.readFile(xcl),
                what = xcl.indexOf("-request-") != -1;
            log(chalk.bold(xcl));

            var sheet_name_list = wbk.SheetNames;
            counter[tag_map["CRITERION"]] = 0;

            for (const i in sheet_name_list) {
                log("".padStart(80, "_"));
                log(chalk.bold(sheet_name_list[i]));
                print_all(wbk.Sheets[sheet_name_list[i]]);
                log("\n\n");
            }
        });
    })

    .command("full_structures", "Print full structure of each spreadsheet")
    .argument("<excelfile>", "Excel Criterion file to be processed")
    .action(({ logger, args, options }) => {
        // Combine styled and normal strings
        log(chalk.bold(`Processing ${args.excelfile} :: full_structure`), "\n\n");
        in_excel_we_trust = [args.excelfile];

        in_excel_we_trust.forEach((xcl) => {
            var wbk = XLSX.readFile(xcl);
            log(chalk.bold(xcl));

            var sheet_name_list = wbk.SheetNames;
            counter[tag_map["CRITERION"]] = 0;

            for (const i in sheet_name_list) {
                log("".padStart(80, "_"));
                log(chalk.bold(sheet_name_list[i]));
                print_structures(wbk.Sheets[sheet_name_list[i]]);
                log("\n\n");
            }
        });
    })

    .command("each_structure", "Print the element and child structure")
    .argument("<excelfile>", "Excel Criterion file to be processed")
    .action(({ logger, args, options }) => {
        // Combine styled and normal strings
        log(chalk.bold(`Processing ${args.excelfile}`), "\n\n");
        in_excel_we_trust = [args.excelfile];

        element_children = {};

        in_excel_we_trust.forEach((xcl) => {
            var wbk = XLSX.readFile(xcl);
            log(chalk.bold(xcl));

            var sheet_name_list = wbk.SheetNames;

            for (const i in sheet_name_list) {
                //log(''.padStart(80, '_'))
                //log(chalk.bold(sheet_name_list[i]))
                //detect elements structure
                detect_structure(wbk.Sheets[sheet_name_list[i]]);
                //log('\n\n')
            }

            //print the structure
            for (const elm in element_children) {
                log(chalk.greenBright(elm));
                for (const child of element_children[elm].sort()) {
                    log("\t", chalk.blue(child));
                }
            }
        });
    })

    .command("check_tag", "Check the TAGS for each element")
    .argument("<excelfile>", "Excel Criterion file to be processed")
    .action(({ logger, args, options }) => {
        // Combine styled and normal strings
        log(chalk.bold(`Processing ${args.excelfile}`), "\n\n");
        in_excel_we_trust = [args.excelfile];

        in_excel_we_trust.forEach((xcl) => {
            var wbk = XLSX.readFile(xcl),
                what = xcl.indexOf("-request-") != -1;
            log(chalk.bold(xcl));

            var sheet_name_list = wbk.SheetNames;
            counter[tag_map["CRITERION"]] = 0;

            for (const i in sheet_name_list) {
                log("".padStart(80, "_"));
                log(chalk.bold(sheet_name_list[i]));
                check_tags(wbk.Sheets[sheet_name_list[i]], what);
                log("\n\n");
            }
        });
    })

    .command("check_UUID", "Check the XML like path IDs for each element")
    .argument("<excelfile>", "Excel Criterion file to be processed")
    .action(({ logger, args, options }) => {
        // Combine styled and normal strings
        log(chalk.bold(`Processing ${args.excelfile}`), "\n\n");
        in_excel_we_trust = [args.excelfile];

        in_excel_we_trust.forEach((xcl) => {
            var wbk = XLSX.readFile(xcl),
                what = xcl.indexOf("-request-") != -1;
            log(chalk.bold(xcl));

            var sheet_name_list = wbk.SheetNames;
            counter[tag_map["CRITERION"]] = 0;

            for (const i in sheet_name_list) {
                log("".padStart(80, "_"));
                log(chalk.bold(sheet_name_list[i]));
                check_UUID_path(
                    wbk.Sheets[sheet_name_list[i]],
                    what,
                    sheet_name_list[i]
                );
                log("\n\n");
            }
        });
    })

    .command("extract_codelists","List elements that have a Code List associated with")
    .argument("<excelfile>", "Excel Criterion file to be processed")
    .action(({ logger, args, options }) => {
        // Combine styled and normal strings
        log(chalk.bold(`Processing ${args.excelfile}`), "\n\n");
        in_excel_we_trust = [args.excelfile];

        in_excel_we_trust.forEach((xcl) => {
            var wbk = XLSX.readFile(xcl);
            log(chalk.bold(xcl));

            var sheet_name_list = wbk.SheetNames;
            counter[tag_map["CRITERION"]] = 0;

            for (const i in sheet_name_list) {
                log("".padStart(80, "_"));
                log(chalk.bold(sheet_name_list[i]));
                extract_codelists(wbk.Sheets[sheet_name_list[i]]);
                log("\n\n");
            }
        });
    })

    .command("extract_pdt","Extract Property Data Type from Excel Criterion file")
    .argument("<excelfile>", "Excel Criterion file to be processed")
    .action(({ logger, args, options }) => {
        log(chalk.bold(`Processing ${args.excelfile}`), "\n\n");

        in_excel_we_trust = [args.excelfile];

        in_excel_we_trust.forEach((xcl) => {
            var wbk = XLSX.readFile(xcl);
            log(chalk.bold(xcl));

            var sheet_name_list = wbk.SheetNames;
            for (const key in sheet_name_list) {
                if (Object.hasOwn(sheet_name_list, key)) {
                    extract_propertydatatype(wbk.Sheets[sheet_name_list[key]]);
                }
            }
        });

        log(chalk.blue(pdt_list.sort().join("\n")));
    })

    .command("eCERTIS_UUIDs","Check the existence of record in eCERTIS associated with a given UUID")
    .option("--user [user]", "proxy server user", { default: "" })
    .option("--password [password]", "proxy server password", { default: "" })
    .argument("<excelfile>", "Excel file with eCERTIS UUIDs to be processed")
    .action(({ logger, args, options }) => {
        log(chalk.bold(`Processing ${args.excelfile}`), "\n\n");

        in_excel_we_trust = [args.excelfile];
        proxy_user = options.user;
        proxy_password = options.password;

        in_excel_we_trust.forEach((xcl) => {
            var wbk = XLSX.readFile(xcl);
            log(chalk.bold(xcl));

            var sheet_name_list = wbk.SheetNames;

            for (const key in sheet_name_list) {
                if (Object.hasOwn(sheet_name_list, key)) {
                    fetch_eCERTIS(wbk.Sheets[sheet_name_list[key]]);
                }
            }
        });
    });

// launch the main loop
program.run();

/**
 * Fetch the UUID from eCERTIS in order to check it this exists or not
 *
 * @param {*} sph - spreadsheet Object
 */
function fetch_eCERTIS(sph) {
    const eCertis_URL =
    //"https://webgate.acceptance.ec.europa.eu/tools3/ecertis2/criteria";
        "https://ec.europa.eu/growth/tools-databases/ecertisrest/criteria/espd";

    var xlData = XLSX.utils.sheet_to_json(sph);
    var agent = new HttpsProxyAgent(
        `http://${proxy_user}:${proxy_password}@${proxy_server}:${proxy_port}`
    );
    var unique_UUIDs = xlData.reduce((acc, crtV) => {
        if (acc.indexOf(crtV.uuid) == -1) acc.push(crtV.uuid);
        return acc;
    }, []);

    log(unique_UUIDs);

    async function fetchDataFromUrls(urls, currentIndex = 0) {
        if (currentIndex >= urls.length) {
            log("All requests completed!");
            return;
        }

        try {
            const response = await axios.get(`${eCertis_URL}/${urls[currentIndex]}`, {
                httpsAgent: agent,
                timeout: 60000,
            });
            log(`Data from ${urls[currentIndex]}:`, response.status);
        } catch (error) {
            log(`Error fetching data from ${urls[currentIndex]}:`, error.message);
        }

        // Make the next request
        await fetchDataFromUrls(urls, currentIndex + 1);
    }

    // Call the function with your array of URLs
    fetchDataFromUrls(unique_UUIDs);
}

//check the green label before each element in the Excel file
//tags are unique per level
//the numbering of same tags on the same level is continuous
//CRITERION numbering is continuous over the entire workbook --- exceptions to be taken into account from invalid_criterion
function check_tags(sph, IS_REQUEST) {
    var xlData = XLSX.utils.sheet_to_json(sph);
    var crt_structure = {};

    //Column names are in row 1 and row 0 is consider to contain header keys
    let hdr = xlData[0];
    //Detect the column for each label
    for (const key in cols) {
        let lbl = cols[key].label;
        if (Object.values(hdr).indexOf(lbl) != -1) {
            cols[key].column = Object.keys(hdr)[Object.values(hdr).indexOf(lbl)];
        }
    }

    xlData.forEach((element) => {
        //get the tag
        let col_idx = 1;
        let tag = "";

        do {
            //no entry
            if (typeof element[col_idx] === "undefined") {
                col_idx++;
                continue;
            }
            //empty entry
            if (element[col_idx].trim().length == 0) {
                col_idx++;
                continue;
            }
            //tag
            if (
                element[col_idx].trim().startsWith("{") ||
                element[col_idx].trim().endsWith("}")
            ) {
                tag = element[col_idx].trim().replace("{", "").replace("}", "");

                //start tag
                if (
                    element[col_idx].trim().startsWith("{") &&
                    !element[col_idx].trim().endsWith("}")
                ) {
                    if (tag == "CRITERION") {
                        counter[tag_map[tag]]++;
                        //skip the invalid CRITERION numbers
                        if (invalid_criterion.indexOf(counter[tag_map[tag]]) != -1) {
                            counter[tag_map[tag]]++;
                        }
                    }
                    //for the other elements have to compute the corresponding level
                    if (typeof crt_structure[col_idx - 2] === "undefined")
                        crt_structure[col_idx - 2] = {};

                    if (typeof crt_structure[col_idx - 2][tag_map[tag]] === "undefined") {
                        crt_structure[col_idx - 2][tag_map[tag]] = 1;
                    } else {
                        //process the cardinality
                        if (` ${element[cols.cardinality.column]}`.indexOf("(") != -1) {
                            let card = element[cols.cardinality.column]
                                .match(/\([\d]\)/g)[0]
                                .replace("(", "")
                                .replace(")", "");
                            if (card == 1) crt_structure[col_idx - 2][tag_map[tag]]++;
                        } else {
                            crt_structure[col_idx - 2][tag_map[tag]]++;
                        }
                    }

                    crt_structure[0][tag_map["CRITERION"]] =
                        counter[tag_map["CRITERION"]];

                    const tag_ok =
                        element[col_idx - 1] ==
                        `${tag_map[tag]}${crt_structure[col_idx - 2][tag_map[tag]]}`;

                    if (!tag_ok)
                        log(`${tag_map[tag]}${crt_structure[col_idx - 2][tag_map[tag]]}`);
                    //print the result
                    log(
                        tag_ok ? chalk.bold.green("[OK]\t") : chalk.bold.red("[NOK]\t"),
                        chalk.green(element[col_idx - 1]),
                        "\t",
                        "".padStart(col_idx - 2, "\t"),
                        chalk.bgWhite.black(tag)
                    );
                }

                //one line tag
                if (
                    element[col_idx].trim().startsWith("{") &&
                    element[col_idx].trim().endsWith("}")
                ) {
                    if (typeof crt_structure[col_idx - 2] === "undefined")
                        crt_structure[col_idx - 2] = {};
                    if (typeof crt_structure[col_idx - 2][tag_map[tag]] === "undefined") {
                        crt_structure[col_idx - 2][tag_map[tag]] = 1;
                    } else {
                        if (` ${element[cols.cardinality.column]}`.indexOf("(") == -1) {
                            crt_structure[col_idx - 2][tag_map[tag]]++;
                        }
                    }
                    const tag_ok =
                        element[col_idx - 1] ==
                        `${tag_map[tag]}${crt_structure[col_idx - 2][tag_map[tag]]}`;

                    //print the result
                    log(
                        tag_ok ? chalk.bold.green("[OK]\t") : chalk.bold.red("[NOK]\t"),
                        chalk.green(element[col_idx - 1]),
                        "\t",
                        "".padStart(col_idx - 2, "\t"),
                        chalk.bgWhite.black(tag)
                    );
                }

                //end tag
                if (
                    !element[col_idx].trim().startsWith("{") &&
                    element[col_idx].trim().endsWith("}")
                ) {
                    if (tag == "CRITERION") crt_structure = {};
                    delete crt_structure[col_idx - 1];
                }

                //log(tag)
                break;
            }
            //some other text
            col_idx++;
        } while (col_idx <= 17);

        if (col_idx == 18 && tag == "") {
            //empty line or does not contain any tag
            //log(chalk.bgRed.white('Empty row'))
            return;
        }
    });
}

/**
 * check the XML like path that is generated for each element
 * the path for Request is in the column 23 and is only for opening tags or one line tags
 * the path for Response is in the columns 24 as Request and for each variant of response in cols: 26, 27, 28, 29
 * the namespace is composed from: CRITERION-NUMBER::namespace_map::Element Code (Crierion line, column 25 for Reques and column 30 for Response)
 * the other rules:
 *   - concatenate the path for each child element
 */
function check_UUID_path(sph, IS_REQUEST, sheetname) {
    //IS_REQUEST = true -> Request Excel file, otehrwise Response Excel file

    var xlData = XLSX.utils.sheet_to_json(sph);
    let crt_structure = {};
    let root_element = "";
    let path_structure = [];
    let end_path = [],
        res_end_path = [];
    let tag_path = [],
        res_tag_path = [];

    //Column names are in row 1 and row 0 is consider to contain header keys
    let hdr = xlData[0];
    //Detect the column for each label
    for (const key in cols) {
        let lbl = cols[key].label;
        if (Object.values(hdr).indexOf(lbl) != -1) {
            cols[key].column = Object.keys(hdr)[Object.values(hdr).indexOf(lbl)];
        }
    }

    xlData.forEach((element) => {
        //get the tag
        let col_idx = 1;
        let tag = "";

        do {
            //no entry
            if (!Object.hasOwn(element, col_idx)) {
                col_idx++;
                continue;
            }
            //empty entry
            if (element[col_idx].trim().length == 0) {
                col_idx++;
                continue;
            }
            //tag
            if (
                element[col_idx].trim().startsWith("{") ||
                element[col_idx].trim().endsWith("}")
            ) {
                tag = element[col_idx].trim().replace("{", "").replace("}", "");

                //start tag
                if (
                    element[col_idx].trim().startsWith("{") &&
                    !element[col_idx].trim().endsWith("}")
                ) {
                    if (tag == "CRITERION") {
                        counter[tag_map[tag]]++;
                        //skip the invalid CRITERION numbers
                        if (invalid_criterion.indexOf(counter[tag_map[tag]]) != -1) {
                            counter[tag_map[tag]]++;
                        }
                        //create root element
                        var ns = "";
                        for (const p in namespace_map) {
                            if (sheetname.startsWith(p)) {
                                ns = namespace_map[p];
                                break;
                            }
                        }

                        root_element = `${tag_map[tag]}${counter[tag_map[tag]]}${ns}${element[cols.elementcode.column]
                            }`;

                        path_structure.push(root_element);
                    }

                    //for the other elements have to compute the corresponding level
                    if (typeof crt_structure[col_idx - 2] === "undefined")
                        crt_structure[col_idx - 2] = {};

                    if (typeof crt_structure[col_idx - 2][tag_map[tag]] === "undefined") {
                        crt_structure[col_idx - 2][tag_map[tag]] = 1;
                    } else {
                        if (!IS_REQUEST) {
                            //process the cardinality
                            if (` ${element[cols.cardinality.column]}`.indexOf("(") != -1) {
                                let card = element[cols.cardinality.column]
                                    .match(/\([\d]\)/g)[0]
                                    .replace("(", "")
                                    .replace(")", "");
                                if (card == 1) crt_structure[col_idx - 2][tag_map[tag]]++;
                            } else {
                                crt_structure[col_idx - 2][tag_map[tag]]++;
                            }
                        } else if (
                            ` ${element[cols.cardinality.column]}`.indexOf("(") == -1
                        ) {
                            crt_structure[col_idx - 2][tag_map[tag]]++;
                        }
                    }

                    crt_structure[0][tag_map["CRITERION"]] =
                        counter[tag_map["CRITERION"]];

                    if (tag != "CRITERION") {
                        path_structure.push(
                            `${tag_map[tag]}${crt_structure[col_idx - 2][tag_map[tag]]}`
                        );
                    }

                    let tag_ok = false,
                        computed_path = path_structure.join("/");

                    if (tag == "REQUIREMENT_GROUP" || tag == "REQUIREMENT_SUBGROUP") {
                        if (` ${element[cols.cardinality.column]}`.indexOf("(") != -1) {
                            let card = element[cols.cardinality.column]
                                .match(/\([\d]\)/g)[0]
                                .replace("(", "")
                                .replace(")", "");
                            end_path.push(`/R${card}`);
                        } else if (
                            ` ${element[cols.cardinality.column]}`.indexOf("..n") != -1
                        ) {
                            end_path.push("/R1");
                        } else if (
                            ` ${element[cols.cardinality.column]}`.indexOf("0..1") != -1 ||
                            `${element[cols.cardinality.column]}` == "1"
                        ) {
                            end_path.push("");
                        }
                        tag_path.push(tag);

                        //log(end_path.reduce((acc, crtval) => crtval.length==0?acc:acc+crtval, ''), tag, tag_path.join(':'))
                    }

                    //Response processing
                    if (!IS_REQUEST) {
                        //if(tag == 'QUESTION_GROUP' || tag == 'QUESTION_SUBGROUP'){

                        if (` ${element[cols.cardinality.column]}`.indexOf("(") != -1) {
                            let card = element[cols.cardinality.column]
                                .match(/\([\d]\)/g)[0]
                                .replace("(", "")
                                .replace(")", "");
                            res_end_path.push(`/R${card}`);
                        } else if (
                            ` ${element[cols.cardinality.column]}`.indexOf("..n") != -1
                        ) {
                            res_end_path.push("/R1");
                        } else if (
                            ` ${element[cols.cardinality.column]}`.indexOf("0..1") != -1 ||
                            `${element[cols.cardinality.column]}` == "1"
                        ) {
                            res_end_path.push("");
                        }
                        res_tag_path.push(tag);
                        //log(res_end_path.reduce((acc, crtval) => crtval.length==0?acc:acc+crtval, ''), tag, ' -> ', res_tag_path.join(':'))
                        //}
                    }

                    tag_ok = element[cols.requestpath.column].trim() == computed_path;

                    //print the result
                    log(
                        tag_ok ? chalk.bold.green("[OK]\t") : chalk.bold.red("[NOK]\t"),
                        chalk.green(element[col_idx - 1]),
                        "\t",
                        chalk.green(element[cols.requestpath.column].trim().padEnd(60)),
                        "\t",
                        chalk.blue(computed_path.padEnd(60)),
                        "\t",
                        "".padStart(col_idx - 2, "\t"),
                        chalk.bgWhite.black(tag)
                    );
                }

                //one line tag
                if (
                    element[col_idx].trim().startsWith("{") &&
                    element[col_idx].trim().endsWith("}")
                ) {
                    if (typeof crt_structure[col_idx - 2] === "undefined")
                        crt_structure[col_idx - 2] = {};

                    if (typeof crt_structure[col_idx - 2][tag_map[tag]] === "undefined") {
                        crt_structure[col_idx - 2][tag_map[tag]] = 1;
                    } else {
                        if (` ${element[cols.cardinality.column]}`.indexOf("(") == -1) {
                            crt_structure[col_idx - 2][tag_map[tag]]++;
                        }
                    }

                    if (tag != "CRITERION") {
                        path_structure.push(
                            `${tag_map[tag]}${crt_structure[col_idx - 2][tag_map[tag]]}`
                        );
                    }

                    let computed_path = path_structure.join("/"),
                        res_computed_path = path_structure.join("/");

                    if (tag == "REQUIREMENT") {
                        if (` ${element[cols.cardinality.column]}`.indexOf("(") != -1) {
                            let card = element[cols.cardinality.column]
                                .match(/\([\d]\)/g)[0]
                                .replace("(", "")
                                .replace(")", "");
                            end_path.push(`/R${card}`);
                        } else {
                            end_path.push("/R1");
                        }
                        //log(end_path.reduce((acc, crtval) => crtval.length==0?acc:acc+crtval, ''), tag)
                        computed_path = computed_path.concat(
                            end_path.reduce(
                                (acc, crtval) => (crtval.length == 0 ? acc : acc + crtval),
                                ""
                            )
                        );
                        end_path.pop();
                    }

                    //Response QUESTION tag
                    if (!IS_REQUEST) {
                        if (tag == "QUESTION") {
                            res_end_path.push("/R1");
                            let val_path =
                                element[cols.propertydatatype.column] == "PERIOD"
                                    ? "/RAP"
                                    : element[cols.propertydatatype.column] ==
                                        "EVIDENCE_IDENTIFIER"
                                        ? "/RES"
                                        : "/RV";

                            //log(res_end_path.reduce((acc, crtval) => crtval.length==0?acc:acc+crtval, ''), tag)
                            res_computed_path = res_computed_path.concat(
                                res_end_path.reduce(
                                    (acc, crtval) => (crtval.length == 0 ? acc : acc + crtval),
                                    ""
                                )
                            );
                            res_end_path.pop();

                            let check1 =
                                res_computed_path == element[cols.responsecontent1.column],
                                check3 =
                                    res_computed_path.concat(val_path) ==
                                    element[cols.responsecontent3.column];

                            log(
                                check1 ? chalk.bold.green("[OK]\t") : chalk.bold.red("[NOK]\t"),
                                chalk.green(element[col_idx - 1]),
                                "\t",
                                chalk.green(
                                    element[cols.responsecontent1.column].trim().padEnd(60)
                                ),
                                "\t",
                                chalk.blue(res_computed_path.padEnd(60)),
                                "\t",
                                "".padStart(col_idx - 2, "\t"),
                                chalk.bgWhite.black(tag)
                            );

                            log(
                                check3 ? chalk.bold.green("[OK]\t") : chalk.bold.red("[NOK]\t"),
                                chalk.green(element[col_idx - 1]),
                                "\t",
                                chalk.green(
                                    element[cols.responsecontent3.column].trim().padEnd(60)
                                ),
                                "\t",
                                chalk.blue(res_computed_path.concat(val_path).padEnd(60)),
                                "\t",
                                "".padStart(col_idx - 2, "\t"),
                                chalk.bgWhite.black(tag)
                            );
                        }
                    }

                    let tag_ok = element[cols.requestpath.column].trim() == computed_path;

                    //print the result
                    log(
                        tag_ok ? chalk.bold.green("[OK]\t") : chalk.bold.red("[NOK]\t"),
                        chalk.green(element[col_idx - 1]),
                        "\t",
                        chalk.green(element[cols.requestpath.column].trim().padEnd(60)),
                        "\t",
                        chalk.blue(computed_path.padEnd(60)),
                        "\t",
                        "".padStart(col_idx - 2, "\t"),
                        chalk.bgWhite.black(tag)
                    );

                    path_structure.pop();
                }

                //end tag
                if (
                    !element[col_idx].trim().startsWith("{") &&
                    element[col_idx].trim().endsWith("}")
                ) {
                    if (tag == "CRITERION") {
                        crt_structure = {};
                        path_structure = [];
                        end_path = [];
                        tag_path = [];
                        res_end_path = [];
                        res_tag_path = [];
                    }
                    delete crt_structure[col_idx - 1];
                    path_structure.pop();

                    if (tag == tag_path[tag_path.length - 1]) {
                        end_path.pop();
                        tag_path.pop();
                    }

                    if (tag == res_tag_path[res_tag_path.length - 1]) {
                        res_end_path.pop();
                        res_tag_path.pop();
                    }
                }

                //log(tag)
                break;
            }
            //some other text
            col_idx++;
        } while (col_idx <= 17);

        if (col_idx == 18 && tag == "") {
            //empty line or does not contain any tag
            //log(chalk.bgRed.white('Empty row'))
            return;
        }
    });
}

//detect and print the structure of the objects
//as described in col2-col17
function print_structures(sph) {
    var xlData = XLSX.utils.sheet_to_json(sph);

    //Column names are in row 1 and row 0 is consider to contain header keys
    let hdr = xlData[0];
    //Detect the column for each label
    for (const key in cols) {
        let lbl = cols[key].label;
        if (Object.values(hdr).indexOf(lbl) != -1) {
            cols[key].column = Object.keys(hdr)[Object.values(hdr).indexOf(lbl)];
        }
    }

    xlData.forEach((element) => {
        //get the tag
        let col_idx = 1;
        let tag = "";

        do {
            //no entry
            if (!Object.hasOwn(element, col_idx)) {
                col_idx++;
                continue;
            }
            //empty entry
            if (element[col_idx].trim().length == 0) {
                col_idx++;
                continue;
            }
            //tag
            if (
                element[col_idx].trim().startsWith("{") ||
                element[col_idx].trim().endsWith("}")
            ) {
                tag = element[col_idx].trim().replace("{", "").replace("}", "");
                //log(tag)
                break;
            }
            //some other text
            col_idx++;
        } while (col_idx <= 17);

        if (col_idx == 18 && tag == "") {
            //empty line or does not contain any tag
            //log(chalk.bgRed.white('Empty row'))
            return;
        }

        log(
            "".padStart(col_idx - 2, "\t"),
            chalk.blueBright(tag),
            "\t",
            element[cols["cardinality"].column] ? element[cols["cardinality"].column] : ""
        );
    });
}

/**
 * Detect elemets structure only the 1st level
 * root -> child elements
 *
 * @param {*} sph - spreadsheet to be processed
 */
function detect_structure(sph) {
    var xlData = XLSX.utils.sheet_to_json(sph);
    var parent = "";
    let path_structure = [];
    //Column names are in row 1 and row 0 is consider to contain header keys
    let hdr = xlData[0];
    //Detect the column for each label
    for (const key in cols) {
        let lbl = cols[key].label;
        if (Object.values(hdr).indexOf(lbl) != -1) {
            cols[key].column = Object.keys(hdr)[Object.values(hdr).indexOf(lbl)];
        }
    }

    xlData.forEach((element) => {
        //get the tag
        let col_idx = 1;
        let tag = "";

        do {
            //no entry
            if (!Object.hasOwn(element, col_idx)) {
                col_idx++;
                continue;
            }
            //empty entry
            if (element[col_idx].trim().length == 0) {
                col_idx++;
                continue;
            }
            //tag
            //open tag that may contain sub tags
            let elm = element[col_idx].toString().trim(),
                tag = elm.replace("{", "").replace("}", "");
            if (elm.startsWith("{") && !elm.endsWith("}")) {
                if (tag == "CRITERION") {
                    path_structure = [];
                    parent = "";
                } else {
                    parent = path_structure.at(-1) ?? "";
                }

                path_structure.push(tag);
                //log(tag)
                if (!Object.hasOwn(element_children, tag)) element_children[tag] = [];
                if (
                    parent.length > 0 &&
                    element_children[parent].indexOf(
                        `${tag}  ${element[cols["cardinality"].column]
                            ? `${element[cols["cardinality"].column]}`.trim()
                            : "?!?"
                        }`
                    ) == -1
                )
                    element_children[parent].push(
                        `${tag}  ${element[cols["cardinality"].column]
                            ? `${element[cols["cardinality"].column]}`.trim()
                            : "?!?"
                        }`
                    );

                if (
                    tag != "CRITERION" &&
                    (!element[cols["cardinality"].column] ||
                        (element[cols["cardinality"].column] &&
                            `${element[cols["cardinality"].column]}`.trim() == ""))
                )
                    log(
                        `No cardinality ${parent}:${tag} __ ${typeof element[
                        cols["cardinality"].column
                        ]}`
                    );
                break;
            }
            //one line tag - most probably the leaf
            if (elm.startsWith("{") && elm.endsWith("}")) {
                //log(tag)
                //if (typeof element_children[tag] === 'undefined') element_children[tag] = []
                parent = path_structure.at(-1) ?? "";
                if (
                    parent.length > 0 &&
                    element_children[parent].indexOf(
                        `${tag}  ${element[cols["cardinality"].column]
                            ? `${element[cols["cardinality"].column]}`.trim()
                            : "?!?"
                        }`
                    ) == -1
                )
                    element_children[parent].push(
                        `${tag}  ${element[cols["cardinality"].column]
                            ? `${element[cols["cardinality"].column]}`.trim()
                            : "?!?"
                        }`
                    );
                if (!Object.hasOwn(element_children, "$TERMINAL_NODE$"))
                    element_children["$TERMINAL_NODE$"] = [];
                if (element_children["$TERMINAL_NODE$"].indexOf(tag) == -1)
                    element_children["$TERMINAL_NODE$"].push(tag);

                if (
                    !element[cols["cardinality"].column] ||
                    (element[cols["cardinality"].column] &&
                        `${element[cols["cardinality"].column]}`.trim() == "")
                )
                    log(
                        `No cardinality ${parent}:${tag} __ ${typeof element[
                        cols["cardinality"].column
                        ]}`
                    );
                break;
            }
            //end of tag
            if (!elm.startsWith("{") && elm.endsWith("}")) {
                path_structure.pop();
                if (tag == "CRITERION") path_structure = [];
                break;
            }

            //some other text
            col_idx++;
        } while (col_idx <= 17);

        if (col_idx == 18 && tag == "") {
            //empty line or does not contain any tag
            //log(chalk.bgRed.white('Empty row'))
            return;
        }
    });
}

/**
 * Extract Code Lists from Excel
 * Not all Code Lists are present in Excel
 */
function extract_codelists(sph) {
    var xlData = XLSX.utils.sheet_to_json(sph);

    //Column names are in row 1 and row 0 is consider to contain header keys
    let hdr = xlData[0];
    //Detect the column for each label
    for (const key in cols) {
        let lbl = cols[key].label;
        if (Object.values(hdr).indexOf(lbl) != -1) {
            cols[key].column = Object.keys(hdr)[Object.values(hdr).indexOf(lbl)];
        }
    }

    xlData.forEach((element) => {
        //get the tag
        let col_idx = 1;
        let tag = "";

        do {
            //no entry
            if (!Object.hasOwn(element, col_idx)) {
                col_idx++;
                continue;
            }
            //empty entry
            if (element[col_idx].trim().length == 0) {
                col_idx++;
                continue;
            }
            //tag
            if (
                element[col_idx].trim().startsWith("{") ||
                element[col_idx].trim().endsWith("}")
            ) {
                tag = element[col_idx].trim().replace("{", "").replace("}", "");
                //log(tag)
                break;
            }
            //some other text
            col_idx++;
        } while (col_idx <= 17);

        if (col_idx == 18 && tag == "") {
            //empty line or does not contain any tag
            //log(chalk.bgRed.white('Empty row'))
            return;
        }

        if (
            typeof element[cols["codelist"].column] !== "undefined" &&
            element[cols["codelist"].column].trim().length > 0
        )
            log(
                "".padStart(col_idx - 2, "\t"),
                chalk.blueBright(tag),
                "\t",
                element[cols["codelist"].column]
            );
    });
}

/**
 * Extract Propety Data Type from Excel
 * PDT have to be translated to UBL elements
 */
function extract_propertydatatype(sph) {
    var xlData = XLSX.utils.sheet_to_json(sph);

    //Column names are in row 1 and row 0 is consider to contain header keys
    let hdr = xlData[0];
    //Detect the column for each label
    for (const key in cols) {
        let lbl = cols[key].label;
        if (Object.values(hdr).indexOf(lbl) != -1) {
            cols[key].column = Object.keys(hdr)[Object.values(hdr).indexOf(lbl)];
        }
    }

    xlData.forEach((element) => {
        //get the tag
        let col_idx = 1,
            tag = "";
        do {
            //no entry
            if (!Object.hasOwn(element, col_idx)) {
                col_idx++;
                continue;
            }
            //empty entry
            if (element[col_idx].trim().length == 0) {
                col_idx++;
                continue;
            }
            //tag
            if (
                element[col_idx].trim().startsWith("{") ||
                element[col_idx].trim().endsWith("}")
            ) {
                tag = element[col_idx].trim().replace("{", "").replace("}", "");
                //log(tag)
                if (
                    Object.hasOwn(element, cols["propertydatatype"].column) &&
                    element[cols["propertydatatype"].column].trim().length > 0
                ) {
                    if (element[cols["propertydatatype"].column] == "CODE") {
                        if (
                            Object.hasOwn(element, cols["codelist"].column) &&
                            element[cols["propertydatatype"].column].trim().length > 0 &&
                            pdt_list.indexOf(
                                `${tag}::${element[
                                    cols["propertydatatype"].column
                                ].trim()} - ${element[cols["codelist"].column].trim()}`
                            ) == -1
                        )
                            pdt_list.push(
                                `${tag}::${element[
                                    cols["propertydatatype"].column
                                ].trim()} - ${element[cols["codelist"].column].trim()}`
                            );
                    } else {
                        if (
                            pdt_list.indexOf(
                                `${tag}::${element[cols["propertydatatype"].column].trim()}`
                            ) == -1
                        )
                            pdt_list.push(
                                `${tag}::${element[cols["propertydatatype"].column].trim()}`
                            );
                    }
                }

                break;
            }
            //some other text
            col_idx++;
        } while (col_idx <= 17);

        if (col_idx == 18 && tag == "") {
            //empty line or does not contain any tag
            //log(chalk.bgRed.white('Empty row'))
            return;
        }
    });
}

//dump Excel to JSON
function print_all(sph) {
    var xlData = XLSX.utils.sheet_to_json(sph);
    log(xlData);
}
