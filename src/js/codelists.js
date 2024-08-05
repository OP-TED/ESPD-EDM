Vue.component("codelists", {
    data() {
        return {
            raw_data: {},
            codelist: null,
            codelists: [],
            sources: {},
            versions: [],
            version: null,
            crt_list: {
                'ShortName': '',
                'LongName': '',
                'ListID': '',
                'Version': '',
                'CanonicalUri': '',
                'CanonicalVersionUri': '',
                'LocationUri': '',
                'AgencyLongName': '',
                'AgencyIdentifier': '',
                'type': '',
                'name': '',
                'table': [],
                'fields': {}
            },
            details_fields: [
                { key: 'Code', label: 'Code' },
                { key: 'Name', label: 'Name' },
                { key: 'Description', label: 'Description' },
                { key: 'Status', label: 'Status' },
                'show_details'
            ],
            language_fields: [
                "bul",
                "spa",
                "ces",
                "dan",
                "deu",
                "est",
                "ell",
                "eng",
                "fra",
                "gle",
                "hrv",
                "ita",
                "lav",
                "lit",
                "hun",
                "mlt",
                "nld",
                "pol",
                "por",
                "ron",
                "slk",
                "slv",
                "fin",
                "swe"
            ],
            scl_fileds: [
                'Code', 'Status'
            ],
            theFile: '',
            show: true
        }
    },

    methods: {
        selectCodeList(event) {
            //transform XML to JSON
            this.crt_list = {
                'ShortName': '',
                'LongName': '',
                'ListID': '',
                'Version': '',
                'CanonicalUri': '',
                'CanonicalVersionUri': '',
                'LocationUri': '',
                'AgencyLongName': '',
                'AgencyIdentifier': '',
                'type': '',
                'name': '',
                'table': [],
                'fields': {}
            }
            const parser = new DOMParser();
            function nsResolver(prefix) {
                const ns = {
                    xs: "http://www.w3.org/2001/XMLSchema",
                    fn: "http://www.w3.org/2005/xpath-functions",
                    ss: "urn:schemas-microsoft-com:office:spreadsheet",
                    gc: "http://docs.oasis-open.org/codelist/ns/genericode/1.0/",
                    xsi: "http://www.w3.org/2001/XMLSchema-instance"
                };
                return ns[prefix] || null;
            }
            const gcXML = parser.parseFromString(this.sources[event], "text/xml");
            this.crt_list.ShortName = gcXML.evaluate('/gc:CodeList/Identification/ShortName', gcXML, nsResolver, XPathResult.STRING_TYPE, null).stringValue
            this.crt_list.LongName = gcXML.evaluate('/gc:CodeList/Identification/LongName', gcXML, nsResolver, XPathResult.STRING_TYPE, null).stringValue
            this.crt_list.ListID = gcXML.evaluate('/gc:CodeList/Identification/LongName[@Identifier="listId"]', gcXML, nsResolver, XPathResult.STRING_TYPE, null).stringValue
            this.crt_list.Version = gcXML.evaluate('/gc:CodeList/Identification/Version', gcXML, nsResolver, XPathResult.STRING_TYPE, null).stringValue
            this.crt_list.CanonicalUri = gcXML.evaluate('/gc:CodeList/Identification/CanonicalUri', gcXML, nsResolver, XPathResult.STRING_TYPE, null).stringValue
            this.crt_list.CanonicalVersionUri = gcXML.evaluate('/gc:CodeList/Identification/CanonicalVersionUri', gcXML, nsResolver, XPathResult.STRING_TYPE, null).stringValue
            this.crt_list.LocationUri = gcXML.evaluate('/gc:CodeList/Identification/LocationUri', gcXML, nsResolver, XPathResult.STRING_TYPE, null).stringValue
            this.crt_list.AgencyLongName = gcXML.evaluate('/gc:CodeList/Identification/Agency/LongName', gcXML, nsResolver, XPathResult.STRING_TYPE, null).stringValue
            this.crt_list.AgencyIdentifier = gcXML.evaluate('/gc:CodeList/Identification/Agency/Identifier/@Identifier', gcXML, nsResolver, XPathResult.STRING_TYPE, null).stringValue
            this.crt_list.type = (this.crt_list.LocationUri.startsWith('https://github.com/ESPD/ESPD-EDM/')) ? 'technical' : 'external'
            this.crt_list.name = (this.crt_list.type == 'external') ? this.crt_list.LongName : this.crt_list.ListID

            //get SimpleCodeList and populate fields
            const scl = gcXML.evaluate('/gc:CodeList/SimpleCodeList/Row', gcXML, nsResolver, XPathResult.ANY_TYPE, null)
            let node = null
            while (node = scl.iterateNext()) {
                if (node.hasChildNodes()) {
                    let children = node.childNodes, nodename = ''
                    for (const n of children) {
                        if (n.nextSibling && n.nextSibling.attributes) {
                            let key = n.nextSibling.getAttribute('ColumnRef'), val = n.nextSibling.getElementsByTagName('SimpleValue')[0].textContent
                            switch (key.toLowerCase()) {
                                case 'code':
                                    nodename = val
                                    if (!Object.hasOwn(this.crt_list.fields, nodename)) this.crt_list.fields[val] = {}
                                    this.crt_list.fields[nodename]["Code"] = val
                                    break;
                                case 'status':
                                    this.crt_list.fields[nodename]["Status"] = val
                                    break;
                                default:
                                    this.crt_list.fields[nodename][key.replace('name-', '').replace('_label', '')] = val
                                    break;
                            }
                        }
                    }
                }
            }

            this.crt_list.table = []
            for (const fld in this.crt_list.fields) {
                this.crt_list.table.push(this.crt_list.fields[fld])
            }

        },

        selectVersion(event) {
            //console.log(event);
            //load the lista data from server
            const dataURL = ['ESPD/codelists/']
            this.version = event
            this.sources = {}

            const getData = async () => {
                this.codelists = this.raw_data[this.version]

                //load only the 1st version lists
                //each time when the version or lists are changed 
                for (const elm of this.codelists) {
                    if (!Object.hasOwn(this.sources, elm)) this.sources[elm] = {}
                    thecall = await fetch(`${dataURL}/${this.version}/${elm}.gc`)
                    data = await thecall.text()
                    if (thecall.ok) {
                        this.sources[elm] = data
                        //console.log(data);
                    }
                }

                this.codelist = this.codelists[0]
                const toplevelfields = ['ShortName', 'LongName', 'ListID', 'Version',
                    'CanonicalUri', 'CanonicalVersionUri', 'LocaltionUri',
                    'AgencyLongName', 'AgencyIdentifier', 'type', 'name']
                //transform XML to JSON
                this.crt_list = {
                    'ShortName': '',
                    'LongName': '',
                    'ListID': '',
                    'Version': '',
                    'CanonicalUri': '',
                    'CanonicalVersionUri': '',
                    'LocationUri': '',
                    'AgencyLongName': '',
                    'AgencyIdentifier': '',
                    'type': '',
                    'name': '',
                    'table': [],
                    'fields': {}
                }
                const parser = new DOMParser();
                function nsResolver(prefix) {
                    const ns = {
                        xs: "http://www.w3.org/2001/XMLSchema",
                        fn: "http://www.w3.org/2005/xpath-functions",
                        ss: "urn:schemas-microsoft-com:office:spreadsheet",
                        gc: "http://docs.oasis-open.org/codelist/ns/genericode/1.0/",
                        xsi: "http://www.w3.org/2001/XMLSchema-instance"
                    };
                    return ns[prefix] || null;
                }
                const gcXML = parser.parseFromString(this.sources[this.codelist], "text/xml");
                this.crt_list.ShortName = gcXML.evaluate('/gc:CodeList/Identification/ShortName', gcXML, nsResolver, XPathResult.STRING_TYPE, null).stringValue
                this.crt_list.LongName = gcXML.evaluate('/gc:CodeList/Identification/LongName', gcXML, nsResolver, XPathResult.STRING_TYPE, null).stringValue
                this.crt_list.ListID = gcXML.evaluate('/gc:CodeList/Identification/LongName[@Identifier="listId"]', gcXML, nsResolver, XPathResult.STRING_TYPE, null).stringValue
                this.crt_list.Version = gcXML.evaluate('/gc:CodeList/Identification/Version', gcXML, nsResolver, XPathResult.STRING_TYPE, null).stringValue
                this.crt_list.CanonicalUri = gcXML.evaluate('/gc:CodeList/Identification/CanonicalUri', gcXML, nsResolver, XPathResult.STRING_TYPE, null).stringValue
                this.crt_list.CanonicalVersionUri = gcXML.evaluate('/gc:CodeList/Identification/CanonicalVersionUri', gcXML, nsResolver, XPathResult.STRING_TYPE, null).stringValue
                this.crt_list.LocationUri = gcXML.evaluate('/gc:CodeList/Identification/LocationUri', gcXML, nsResolver, XPathResult.STRING_TYPE, null).stringValue
                this.crt_list.AgencyLongName = gcXML.evaluate('/gc:CodeList/Identification/Agency/LongName', gcXML, nsResolver, XPathResult.STRING_TYPE, null).stringValue
                this.crt_list.AgencyIdentifier = gcXML.evaluate('/gc:CodeList/Identification/Agency/Identifier/@Identifier', gcXML, nsResolver, XPathResult.STRING_TYPE, null).stringValue
                this.crt_list.type = (this.crt_list.LocationUri.startsWith('https://github.com/ESPD/ESPD-EDM/')) ? 'technical' : 'external'
                this.crt_list.name = (this.crt_list.type == 'external') ? this.crt_list.LongName : this.crt_list.ListID

                //get SimpleCodeList and populate fields
                const scl = gcXML.evaluate('/gc:CodeList/SimpleCodeList/Row', gcXML, nsResolver, XPathResult.ANY_TYPE, null)
                let node = null
                while (node = scl.iterateNext()) {
                    if (node.hasChildNodes()) {
                        let children = node.childNodes, nodename = ''
                        for (const n of children) {
                            if (n.nextSibling && n.nextSibling.attributes) {
                                let key = n.nextSibling.getAttribute('ColumnRef'), val = n.nextSibling.getElementsByTagName('SimpleValue')[0].textContent
                                switch (key) {
                                    case 'code':
                                        nodename = val
                                        if (!Object.hasOwn(this.crt_list.fields, nodename)) this.crt_list.fields[val] = {}
                                        this.crt_list.fields[nodename]["Code"] = val
                                        break;
                                    case 'status':
                                        this.crt_list.fields[nodename]["Status"] = val
                                        break;
                                    default:
                                        this.crt_list.fields[nodename][key.replace('name-', '').replace('_label', '')] = val
                                        break;
                                }
                            }
                        }
                    }
                }

                this.crt_list.table = []
                for (const fld in this.crt_list.fields) {
                    this.crt_list.table.push(this.crt_list.fields[fld])
                }

            }
            getData()
        },

        ViewXML() {
            let item = this.crt_list
            //fetch the file and show it
            //technical code lists should be fetched from the site the others from their remote locaitons
            if (item.type == 'technical') {
                fetch(`ESPD/codelists/${this.version}/${item.ShortName}.gc`)
                    .then(res => res.text()) // Gets the response and returns it as a blob
                    .then(txt => {
                        let blob = new Blob([txt], { type: 'text/xml' });
                        let url = URL.createObjectURL(blob);
                        window.open(url, "_blank");
                        URL.revokeObjectURL(url);
                    })
            } else {
                window.open(item.LocationUri, "_blank")
            }
        }
    },

    created() {
        const dataURL = ['ESPD/codelists/']

        const getData = async () => {
            try {
                let thecall = await fetch(`${dataURL}/codelist.json`)
                let data = await thecall.json()
                if (thecall.ok) {
                    this.raw_data = data.code_lists

                    //console.log(data)
                    this.versions = []
                    //get the rest of the files
                    for (const ver in this.raw_data) {
                        if (Object.hasOwnProperty.call(this.raw_data, ver)) {
                            const v = this.raw_data[ver];
                            this.versions.push(ver)
                            //console.log(v);
                        }
                    }
                    this.versions.sort().reverse()
                    this.version = this.versions[0]
                    this.codelists = this.raw_data[this.versions[0]]

                    //load only the 1st version lists
                    //each time when the version or lists are changed 
                    for (const elm of this.codelists) {
                        if (!Object.hasOwn(this.sources, elm)) this.sources[elm] = {}
                        thecall = await fetch(`${dataURL}/${this.version}/${elm}.gc`)
                        //data is in XML format
                        data = await thecall.text()
                        if (thecall.ok) {
                            this.sources[elm] = data
                            //console.log(data);
                        }
                    }

                    this.codelist = this.codelists[0]
                    const toplevelfields = ['ShortName', 'LongName', 'ListID', 'Version',
                        'CanonicalUri', 'CanonicalVersionUri', 'LocaltionUri',
                        'AgencyLongName', 'AgencyIdentifier', 'type', 'name']
                    //transform XML to JSON
                    this.crt_list = {
                        'ShortName': '',
                        'LongName': '',
                        'ListID': '',
                        'Version': '',
                        'CanonicalUri': '',
                        'CanonicalVersionUri': '',
                        'LocationUri': '',
                        'AgencyLongName': '',
                        'AgencyIdentifier': '',
                        'type': '',
                        'name': '',
                        'table': [],
                        'fields': {}
                    }
                    const parser = new DOMParser();
                    function nsResolver(prefix) {
                        const ns = {
                            xs: "http://www.w3.org/2001/XMLSchema",
                            fn: "http://www.w3.org/2005/xpath-functions",
                            ss: "urn:schemas-microsoft-com:office:spreadsheet",
                            gc: "http://docs.oasis-open.org/codelist/ns/genericode/1.0/",
                            xsi: "http://www.w3.org/2001/XMLSchema-instance"
                        };
                        return ns[prefix] || null;
                    }
                    const gcXML = parser.parseFromString(this.sources[this.codelist], "text/xml");
                    this.crt_list.ShortName = gcXML.evaluate('/gc:CodeList/Identification/ShortName', gcXML, nsResolver, XPathResult.STRING_TYPE, null).stringValue
                    this.crt_list.LongName = gcXML.evaluate('/gc:CodeList/Identification/LongName', gcXML, nsResolver, XPathResult.STRING_TYPE, null).stringValue
                    this.crt_list.ListID = gcXML.evaluate('/gc:CodeList/Identification/LongName[@Identifier="listId"]', gcXML, nsResolver, XPathResult.STRING_TYPE, null).stringValue
                    this.crt_list.Version = gcXML.evaluate('/gc:CodeList/Identification/Version', gcXML, nsResolver, XPathResult.STRING_TYPE, null).stringValue
                    this.crt_list.CanonicalUri = gcXML.evaluate('/gc:CodeList/Identification/CanonicalUri', gcXML, nsResolver, XPathResult.STRING_TYPE, null).stringValue
                    this.crt_list.CanonicalVersionUri = gcXML.evaluate('/gc:CodeList/Identification/CanonicalVersionUri', gcXML, nsResolver, XPathResult.STRING_TYPE, null).stringValue
                    this.crt_list.LocationUri = gcXML.evaluate('/gc:CodeList/Identification/LocationUri', gcXML, nsResolver, XPathResult.STRING_TYPE, null).stringValue
                    this.crt_list.AgencyLongName = gcXML.evaluate('/gc:CodeList/Identification/Agency/LongName', gcXML, nsResolver, XPathResult.STRING_TYPE, null).stringValue
                    this.crt_list.AgencyIdentifier = gcXML.evaluate('/gc:CodeList/Identification/Agency/Identifier/@Identifier', gcXML, nsResolver, XPathResult.STRING_TYPE, null).stringValue
                    this.crt_list.type = (this.crt_list.LocationUri.startsWith('https://github.com/ESPD/ESPD-EDM/')) ? 'technical' : 'external'
                    this.crt_list.name = (this.crt_list.type == 'external') ? this.crt_list.LongName : this.crt_list.ListID

                    //get SimpleCodeList and populate fields
                    const scl = gcXML.evaluate('/gc:CodeList/SimpleCodeList/Row', gcXML, nsResolver, XPathResult.ANY_TYPE, null)
                    let node = null
                    while (node = scl.iterateNext()) {
                        if (node.hasChildNodes()) {
                            let children = node.childNodes, nodename = ''
                            for (const n of children) {
                                if (n.nextSibling && n.nextSibling.attributes) {
                                    let key = n.nextSibling.getAttribute('ColumnRef'), val = n.nextSibling.getElementsByTagName('SimpleValue')[0].textContent
                                    switch (key.toLowerCase()) {
                                        case 'code':
                                            nodename = val
                                            if (!Object.hasOwn(this.crt_list.fields, nodename)) this.crt_list.fields[val] = {}
                                            this.crt_list.fields[nodename]["Code"] = val
                                            break;
                                        case 'status':
                                            this.crt_list.fields[nodename]["Status"] = val
                                            break;
                                        default:
                                            this.crt_list.fields[nodename][key.replace('name-', '').replace('_label', '')] = val
                                            break;
                                    }
                                }
                            }
                        }
                    }

                    this.crt_list.table = []
                    for (const fld in this.crt_list.fields) {
                        this.crt_list.table.push(this.crt_list.fields[fld])
                    }


                }
            } catch (error) {
                console.log("Error!", error)
            }
        }

        getData()
    },

    template: `

    <b-card title="ESPD Code Lists" footer-tag="footer">

        <b-form-group label-cols="4" label-cols-lg="2" label-size="sm" label="ESPD version" label-for="input-espdversion">
            <b-form-select id="input-espdversion" v-model="version" :options="versions" @change="selectVersion($event)"></b-form-select>
        </b-form-group>

        <b-form-group label-cols="4" label-cols-lg="2" label-size="sm" label="Code list" label-for="input-codelist">
            <b-form-select id="input-codelist" v-model="codelist" :options="codelists" @change="selectCodeList($event)"></b-form-select>
        </b-form-group>

        <b-form-group label-cols="4" label-cols-lg="2" label-size="sm" label="Short Name" label-for="input-shortname">
            <b-form-input id="input-shortname" v-model="crt_list.ShortName"></b-form-input>
        </b-form-group>
        <b-form-group label-cols="4" label-cols-lg="2" label-size="sm" label="Long Name" label-for="input-longname">
            <b-form-input id="input-longname" v-model="crt_list.LongName"></b-form-input>
        </b-form-group>
        <b-form-group label-cols="4" label-cols-lg="2" label-size="sm" label="List ID" label-for="input-listid">
            <b-form-input id="input-listid" v-model="crt_list.ListID"></b-form-input>
        </b-form-group>
        <b-form-group label-cols="4" label-cols-lg="2" label-size="sm" label="Version" label-for="input-version">
            <b-form-input id="input-version" v-model="crt_list.Version"></b-form-input>
        </b-form-group>
        <b-form-group label-cols="4" label-cols-lg="2" label-size="sm" label="Canonical URI" label-for="input-canonicaluri">
            <b-form-input id="input-canonicaluri" v-model="crt_list.CanonicalUri"></b-form-input>
        </b-form-group>
        <b-form-group label-cols="4" label-cols-lg="2" label-size="sm" label="Canonical Version URI" label-for="input-canonicalversionuri">
            <b-form-input id="input-canonicalversionuri" v-model="crt_list.CanonicalVersionUri"></b-form-input>
        </b-form-group>
        <b-form-group label-cols="4" label-cols-lg="2" label-size="sm" label="Location URI" label-for="input-locationuri">
            <b-form-input id="input-lsocationuri" v-model="crt_list.LocationUri"></b-form-input>
        </b-form-group>
        <b-form-group label-cols="4" label-cols-lg="2" label-size="sm" label="Agency Long Name" label-for="input-agencylongname">
            <b-form-input id="input-agencylongname" v-model="crt_list.AgencyLongName"></b-form-input>
        </b-form-group>
        <b-form-group label-cols="4" label-cols-lg="2" label-size="sm" label="Agency Identifier" label-for="input-agencyidentifier">
            <b-form-input id="input-agencyidentifier" v-model="crt_list.AgencyIdentifier"></b-form-input>
        </b-form-group>
        <b-form-group label-cols="4" label-cols-lg="2" label-size="sm" label="Name" label-for="input-name">
            <b-form-input id="input-name" v-model="crt_list.name"></b-form-input>
        </b-form-group>
        <b-form-group label-cols="4" label-cols-lg="2" label-size="sm" label="Type" label-for="input-type">
            <b-form-input id="input-type" v-model="crt_list.type"></b-form-input>
        </b-form-group>

        <b-table striped hover responsive :items="crt_list.table" :fields="details_fields">
        <template #cell(show_details)="row">
            <b-button pill variant="warning" size="sm" @click="row.toggleDetails" class="mr-2">
                {{ row.detailsShowing ? 'Close' : 'Details'}}
            </b-button>
        </template>
        <template #row-details="row">
            <b-card>
                <b-table stacked :items="[row.item]" :fields="language_fields"></b-table>
            </b-card>
        </template>
        </b-table>

        <template #footer>
            <b-row>
                <b-col class="pb-2">
                    <b-button pill @click="ViewXML" variant="primary">View XML file</b-button>
                </b-col>
            </b-row>
        </template>
    </b-card>

    `
});