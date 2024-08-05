Vue.component("distribution", {
    data: function () {
        return {
            version: '',
            versions: [],
            raw_data: {},
            show: true
        }
    },

    methods: {
        selectVersion(event) {
            console.log(event);
        },
        ExportExcel(what) {
            console.log(what);
            if (what == 'codelist') {
                const wb = new ExcelJS.Workbook();

                //Excelify the XMLs from this.sources

                const exportKeys = ['ShortName', 'LongName', 'ListID',
                    'Version', 'CanonicalUri', 'CanonicalVersionUri',
                    'LocationUri', 'AgencyLongName', 'AgencyIdentifier']
                for (const key in this.sources) {
                    let ws = wb.addWorksheet(this.sources[key].ShortName)
                    let row = 1, maxAColWidth = 0
                    for (const elm of exportKeys) {
                        if (Object.hasOwn(this.sources[key], elm)) {
                            ws.getCell(`A${row}`).value = elm
                            maxAColWidth = Math.max(maxAColWidth, elm.length + 1)
                            ws.getCell(`A${row}`).font = { bold: true }
                            ws.getCell(`B${row}`).value = this.sources[key][elm]
                            row++
                        }
                        //Set the width for Column A
                        ws.getColumn('A').width = maxAColWidth

                    }
                    //Export the table part after the mandatory fields
                    const tableKeys = ['Code', 'Name', 'Description', 'Status'].concat(this.language_fields)

                    if (Object.hasOwn(this.sources[key], 'fields')) {
                        //Add table
                        let cols = [], rows = []

                        tableKeys.forEach(elm => {
                            cols.push({
                                name: elm,
                                filterButton: true
                            })
                        })

                        for (const elm in this.sources[key]['fields']) {
                            let crt_row = []
                            tableKeys.forEach(val => {
                                crt_row.push(this.sources[key]['fields'][elm][val])
                            })
                            rows.push(crt_row)
                        }

                        ws.addTable({
                            name: `${this.sources[key].ShortName}_tbl`,
                            ref: `A${row}`,
                            headerRow: true,
                            totalsRow: false,
                            style: {
                                theme: 'TableStyleMedium9',
                                showRowStripes: true,
                            },
                            columns: cols,
                            rows: rows,
                        })
                    }
                }

                let fn_version = this.version
                //wrap up the file and send it to the browser
                wb.xlsx.writeBuffer({ base64: true })
                    .then(function (xls64) {
                        var data = new Blob([xls64], { type: "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" });
                        var url = URL.createObjectURL(data);
                        //the name of the file can not be setup programatically :( you will get some randomly generated name
                        //window.open(url, "_blank");
                        let a = document.getElementById('excel_file_codelist')
                        a.href = url
                        a.download = `CodeList_${fn_version}.xlsx`
                        a.click()
                        URL.revokeObjectURL(url);
                    })
                    .catch(function (error) {
                        console.log(error.message);
                    });
            }
        },
        DownloadZIP(what) {
            if (what == 'codelist') {
                //type == external => fetch; type == technical => build XML
                var XMLzip = new JSZip()
                XMLzip.file("codelists/README.md", `Code List GC files version ${this.version}`)

                const getAllXMLFiles = async () => {
                    try {

                        let thecall = await fetch(this.raw_data[this.version].codelists.source)
                        let data = await thecall.json()
                        if (thecall.ok) {
                            for (const fn of data.code_lists[this.version]) {
                                XMLzip.file(`codelists/${this.version}/${fn}.gc`,
                                    urlToPromise(`ESPD/codelists/${this.version}/${fn}.gc`),
                                    { binary: true })
                            }
                        }

                        let fn_version = this.version
                        XMLzip.generateAsync({ type: "blob" })
                            .then(function (blob) {
                                saveAs(blob, `codelist_${fn_version}.zip`);
                            });
                    } catch (error) {
                        console.log(error);
                    }
                }
                getAllXMLFiles()
            }

        }
    },

    created() {
        const dataURL = ['ESPD/excel/']

        const getData = async () => {
            try {
                let thecall = await fetch(`${dataURL}/excel.json`)
                let data = await thecall.json()
                if (thecall.ok) {
                    this.raw_data = data.versions

                    for (const key in this.raw_data) {
                        if (Object.hasOwn(this.raw_data, key)) {
                            this.versions.push(key)
                        }
                    }
                    this.version = this.versions[0]
                }

            } catch (error) {
                console.log("Error!", error)
            }
        }

        getData()

    },

    template: `
  <b-card title="ESPD Distribution">
    <b-card-text>
    Select the ESPD version and generate the ESPD Distribution ZIP files. The archives contain Code Lists and Model files. The Excel files can be downloaded separately.
    </b-card-text>

    <b-form-group label-cols="4" label-cols-lg="2" label-size="sm" label="ESPD version" label-for="input-espdversion">
            <b-form-select id="input-espdversion" v-model="version" :options="versions" @change="selectVersion($event)"></b-form-select>
        </b-form-group>
    
    <b-row>
        <b-col >
        Code Lists
        </b-col>
        <b-col  cols="10">
        <a href="#" id='excel_file_codelist' name='excel_file_codelist' class="card-link"></a>
        <b-button class="mb-3 mr-sm-2" pill @click="ExportExcel('codelist')" variant="warning">Download Excel</b-button>
        <b-button class="mb-3" pill @click="DownloadZIP('codelist')" variant="success">Download all XML files as ZIP archive</b-button>
        </b-col>
    </b-row>
    <b-row>
        <b-col >
        Model and Data structure
        </b-col>
        <b-col  cols="10">
        <a href="#" id='excel_file_criterion' name='excel_file_criterion' class="card-link"></a>
        <b-button class="mb-3 mr-sm-2" pill @click="ExportExcel('model')" variant="warning">Download Excel</b-button>
        </b-col>
    </b-row>   

  </b-card> 
    `
});