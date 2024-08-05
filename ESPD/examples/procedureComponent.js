Vue.component('procedureComponent', {
    data() {
        return {
            publication: {
                received_notice_number: '',
                OJS_notice_number: '',
                OJS_URL: '',
                national_official_journal: ''
            },
            procurer: {
                name: '',
                country: '',
                website: '',
                vat: '',
                city: '',
                street_and_number: '',
                postcode: '',
                contact_person: '',
                telephone: '',
                email: ''
            },
            procedure: {
                title: '',
                short_description: '',
                file_reference: '',
                number_of_lots: 1
            },
            seller: {
                name: '',
                country: '',
                website: '',
                vat: '',
                city: '',
                street_and_number: '',
                postcode: '',
                contact_person: '',
                telephone: '',
                email: ''
            },
            poa: {
                name: '',
                familyname: '',
                dateofbirth: '',
                placeofbirth: '',
                country: '',
                website: '',
                role: '',
                details: '',
                city: '',
                street_and_number: '',
                postcode: '',
                telephone: '',
                email: ''
            },
            espd_structure: {
                partII: {
                    A: [],
                    B: [],
                    C: [],
                    D: []
                }
            },
            country_list: [
                { value: 'EUR', text: 'European Union' }
            ],
            meta_espd_doc: window.raw_data[window.espd_doc.espd_version],
            espd_model: window.espd_model,
            show: true
        }
    },

    watch: {
        procurer: [function (oldV, newV) {
            window.espd_doc.procurer = this.procurer
        }],
        procedure: [function (oldV, newV) {
            window.espd_doc.procedure = this.procedure
        }],
        publication: [function (oldV, newV) {
            window.espd_doc.publication = this.publication
        }],
        seller: [function (oldV, newV) {
            window.espd_doc.seller = this.seller
        }],
        poa: [function (oldV, newV) {
            window.espd_doc.poa = this.poa
        }]
    },

    created() {

        this.procurer.country = window.espd_doc.country
        this.seller.country = window.espd_doc.country
        this.poa.country = window.espd_doc.country

        window.espd_doc.publication = this.publication
        window.espd_doc.procurer = this.procurer
        window.espd_doc.procedure = this.procedure
        window.espd_doc.seller = this.seller
        window.espd_doc.poa = this.poa


        //Initialize form data
        this.publication.received_notice_number = 'EU1234'
        this.publication.OJS_notice_number = '2024/S001-123123'
        this.publication.OJS_URL = 'https://docs.ted.europa.eu/ESPD-EDM/latest/index.html'
        this.publication.national_official_journal = 'EU0001'

        this.procurer.name = 'TED-OP'
        this.procurer.website = 'https://ted.europa.eu/en/'
        this.procurer.vat = 'EU0123456789'
        this.procurer.city = 'Luxembourg'
        this.procurer.street_and_number = '20 Rue de Reims'
        this.procurer.postcode = '2417'
        this.procurer.contact_person = 'Help Desk'
        this.procurer.telephone = '0080067891011'
        this.procurer.email = 'OPESPD@publications.europa.eu'

        this.procedure.title = 'Example of ESPD Request'
        this.procedure.short_description = 'This is an example ESPD Request created with ESPD Demo application.'
        this.procedure.file_reference = 'REF0001'

        //Build the UI part for each Criteria
        if(window.espd_doc.role == 'eo'){
            for (const key in this.meta_espd_doc.partII) {
                if (Object.hasOwn(this.meta_espd_doc.partII, key)) {
                    for (const el of this.meta_espd_doc.partII[key]) {
                        this.espd_structure.partII[key].push(`${window.espd_doc.espd_version}-${el}`)                    
                    }
                }
            }
        }

    },

    template: `
    <template>
    <b-conatiner>
    <b-row>
    <b-col>
    <div>
    <h6>Part I: Information concerning the procurement procedure and the contracting authority or contracting entity</h6>
    </div>
    </b-col>
    </b-row>
    <b-row>
    <b-col>
    <div class="accordion" role="tablist">
        <b-card no-body class="mb-1">
        <b-card-header header-tag="header" class="p-1" role="tab">
            <b-button block v-b-toggle.accordion-p1 variant="info">A. Information about publication</b-button>
        </b-card-header>
        <b-collapse id="accordion-p1" visible accordion="my-accordion" role="tabpanel">
            <b-card-body>
            <b-form-group id="flds-ron" label-cols-sm="4" label-cols-lg="3" description="Please specify the received notice number." label="Received notice number" label-for="inp-received_notice_number">
                <b-form-input id="inp-received_notice_number" v-model="publication.received_notice_number"></b-form-input>
            </b-form-group>
            <b-form-group id="flds-ojs_number" label-cols-sm="4" label-cols-lg="3" description="[][][][]/S [][][]-[][][][][][]." label="Notice number in the OJS" label-for="inp-OJS_notice_number">
                <b-form-input id="inp-OJS_notice_number" v-model="publication.OJS_notice_number"></b-form-input>
            </b-form-group>
            <b-form-group id="flds-ojs_url" label-cols-sm="4" label-cols-lg="3" description="Please specify the OJS URL." label="OJS URL" label-for="inp-OJS_url">
                <b-form-input id="inp-OJS_url" v-model="publication.OJS_URL"></b-form-input>
            </b-form-group>
            <b-form-group id="flds-noj" label-cols-sm="4" label-cols-lg="3" description="Please specify the national government official journal number" label="National Official Journal" label-for="inp-noj">
                <b-form-input id="inp-noj" v-model="publication.national_official_journal"></b-form-input>
            </b-form-group>
            </b-card-body>
        </b-collapse>
        </b-card>

        <b-card no-body class="mb-1">
        <b-card-header header-tag="header" class="p-1" role="tab">
            <b-button block v-b-toggle.accordion-p2 variant="info">B. Identity of the procurer</b-button>
        </b-card-header>
        <b-collapse id="accordion-p2" accordion="my-accordion" role="tabpanel">
            <b-card-body>
            <b-form-group id="flds-caname" label-cols-sm="4" label-cols-lg="3" description="Please specify Procurer's name" label="Official name" label-for="inp-caname">
                <b-form-input id="inp-caname" v-model="procurer.name"></b-form-input>
            </b-form-group>
            <b-form-group id="flds-cacountry" label-cols-sm="4" label-cols-lg="3" description="Procurer's country." label="Country" label-for="inp-cacountry">
                <b-form-select id="inp-cacountry" v-model="procurer.country" :options="country_list"></b-form-select>
            </b-form-group>
            <b-form-group id="flds-caweb" label-cols-sm="4" label-cols-lg="3" description="Please specify Procurer's URL (if applicable)" label="Website" label-for="inp-caweb">
                <b-form-input id="inp-caweb" v-model="procurer.website"></b-form-input>
            </b-form-group>
            </b-form-group>
            <b-form-group id="flds-cavat" label-cols-sm="4" label-cols-lg="3" description="Please specify Procurer's V.A.T number (if applicable)" label="V.A.T number" label-for="inp-cavat">
                <b-form-input id="inp-cavat" v-model="procurer.vat"></b-form-input>
            </b-form-group>
            <b-form-group id="flds-cacity" label-cols-sm="4" label-cols-lg="3" description="Please specify Procurer's city" label="City" label-for="inp-cacity">
                <b-form-input id="inp-cacity" v-model="procurer.city"></b-form-input>
            </b-form-group>
            <b-form-group id="flds-castreetandnumber" label-cols-sm="4" label-cols-lg="3" description="Please specify Procurer's street and number" label="Street and Number" label-for="inp-castreetandnumber">
                <b-form-input id="inp-castreetandnumber" v-model="procurer.street_and_number"></b-form-input>
            </b-form-group>
            <b-form-group id="flds-capostcode" label-cols-sm="4" label-cols-lg="3" description="Please specify Procurer's post code" label="Post code" label-for="inp-capostcode">
                <b-form-input id="inp-capostcode" v-model="procurer.postcode"></b-form-input>
            </b-form-group>
            <b-form-group id="flds-contactperson" label-cols-sm="4" label-cols-lg="3" description="Please specify Procurer's contact person" label="Contact person" label-for="inp-contactperson">
                <b-form-input id="inp-contactperson" v-model="procurer.contact_person"></b-form-input>
            </b-form-group>
            <b-form-group id="flds-catelephone" label-cols-sm="4" label-cols-lg="3" description="Please specify Procurer's contact phone" label="Telephone" label-for="inp-catelephone">
                <b-form-input id="inp-catelephone" v-model="procurer.telephone"></b-form-input>
            </b-form-group>
            <b-form-group id="flds-caemail" label-cols-sm="4" label-cols-lg="3" description="Please specify Procurer's contact email" label="E-mail" label-for="inp-caemail">
                <b-form-input id="inp-caemail" v-model="procurer.email"></b-form-input>
            </b-form-group>
            </b-card-body>
        </b-collapse>
        </b-card>

        <b-card no-body class="mb-1">
        <b-card-header header-tag="header" class="p-1" role="tab">
            <b-button block v-b-toggle.accordion-p3 variant="info">C. Information about the procurement procedure</b-button>
        </b-card-header>
        <b-collapse id="accordion-p3" accordion="my-accordion" role="tabpanel">
            <b-card-body>
            <b-form-group id="flds-ptitle" label-cols-sm="4" label-cols-lg="3" description="Procurement procedure title." label="Title" label-for="inp-ptitle">
                <b-form-input id="inp-ptitle" v-model="procedure.title"></b-form-input>
            </b-form-group>
            <b-form-group id="flds-pshort_description" label-cols-sm="4" label-cols-lg="3" description="Please specify procurement procedure short description." label="Short description" label-for="inp-pshort_description">
                <b-form-input id="inp-pshort_description" v-model="procedure.short_description"></b-form-input>
            </b-form-group>
            <b-form-group id="flds-pfile_reference" label-cols-sm="4" label-cols-lg="3" description="File reference number attributed by the contracting authority or contracting entity (if applicable)" label="File reference number" label-for="inp-pfile_reference">
                <b-form-input id="inp-pfile_reference" v-model="procedure.file_reference"></b-form-input>
            </b-form-group>
            <b-form-group id="flds-pnumber_of_lots" label-cols-sm="4" label-cols-lg="3" description="Number of lots (if applicable)" label="Number of lots" label-for="inp-pnumber_of_lots">
                <b-form-input id="inp-pnumber_of_lots" v-model="procedure.number_of_lots" type="number" min=1></b-form-input>
            </b-form-group>
            </b-card-body>
        </b-collapse>
        </b-card>
    </div>
    </b-col>
    </b-row>
    <b-row v-if="window.espd_doc.role=='eo'">
        <b-col>
        <div>
        <h6>Part II: Information concerning the economic operator</h6>
        </div>
        </b-col>
    </b-row>
    <b-row v-if="window.espd_doc.role=='eo'">
        <b-col>
        <div class="accordion" role="tablist">
            <b-card no-body class="mb-1">
            <b-card-header header-tag="header" class="p-1" role="tab">
                <b-button block v-b-toggle.accordion-p4 variant="info">A: Information about the economic operator</b-button>
            </b-card-header>
            <b-collapse id="accordion-p4" accordion="my-accordion" role="tabpanel">

            <b-card-body>
            <b-form-group id="flds-eoname" label-cols-sm="4" label-cols-lg="3" description="Please specify Seller's name" label="Official name" label-for="inp-eoname">
                <b-form-input id="inp-eoname" v-model="seller.name"></b-form-input>
            </b-form-group>
            <b-form-group id="flds-eocountry" label-cols-sm="4" label-cols-lg="3" description="Seller's Country." label="Country" label-for="inp-eocountry">
                <b-form-select id="inp-eocountry" v-model="seller.country" :options="country_list"></b-form-select>
            </b-form-group>
            <b-form-group id="flds-eoweb" label-cols-sm="4" label-cols-lg="3" description="Please specify Seller's URL (if applicable)" label="Website" label-for="inp-eoweb">
                <b-form-input id="inp-eoweb" v-model="seller.website"></b-form-input>
            </b-form-group>
            </b-form-group>
            <b-form-group id="flds-eovat" label-cols-sm="4" label-cols-lg="3" description="Please specify Seller's V.A.T number (if applicable)" label="V.A.T number" label-for="inp-eovat">
                <b-form-input id="inp-eovat" v-model="seller.vat"></b-form-input>
            </b-form-group>
            <b-form-group id="flds-eocity" label-cols-sm="4" label-cols-lg="3" description="Please specify Seller's city" label="City" label-for="inp-eocity">
                <b-form-input id="inp-eocity" v-model="seller.city"></b-form-input>
            </b-form-group>
            <b-form-group id="flds-eostreetandnumber" label-cols-sm="4" label-cols-lg="3" description="Please specify Seller's street and number" label="Street and Number" label-for="inp-eostreetandnumber">
                <b-form-input id="inp-eostreetandnumber" v-model="seller.street_and_number"></b-form-input>
            </b-form-group>
            <b-form-group id="flds-eopostcode" label-cols-sm="4" label-cols-lg="3" description="Please specify Seller's post code" label="Post code" label-for="inp-eopostcode">
                <b-form-input id="inp-eopostcode" v-model="seller.postcode"></b-form-input>
            </b-form-group>
            <b-form-group id="flds-eontactperson" label-cols-sm="4" label-cols-lg="3" description="Please specify Seller's contact person" label="Contact person" label-for="inp-eontactperson">
                <b-form-input id="inp-eontactperson" v-model="seller.contact_person"></b-form-input>
            </b-form-group>
            <b-form-group id="flds-eotelephone" label-cols-sm="4" label-cols-lg="3" description="Please specify Seller's contact phone" label="Telephone" label-for="inp-eotelephone">
                <b-form-input id="inp-eotelephone" v-model="seller.telephone"></b-form-input>
            </b-form-group>
            <b-form-group id="flds-eoemail" label-cols-sm="4" label-cols-lg="3" description="Please specify Seller's contact email" label="E-mail" label-for="inp-eoemail">
                <b-form-input id="inp-eoemail" v-model="seller.email"></b-form-input>
            </b-form-group>
            </b-card-body> 
                   
            <b-card-body v-for="item in espd_structure['partII']['A']">
                <component v-bind:is="item"></component>
            </b-card-body>

            </b-collapse>
            </b-card>

            <b-card no-body class="mb-1">
            <b-card-header header-tag="header" class="p-1" role="tab">
                <b-button block v-b-toggle.accordion-p5 variant="info">B: Information about representatives of the economic operator</b-button>
            </b-card-header>
            <b-collapse id="accordion-p5" accordion="my-accordion" role="tabpanel">
                
            <b-card-body>
            <b-form-group id="flds-poaname" label-cols-sm="4" label-cols-lg="3" description="Please specify Seller's representative name" label="First Name" label-for="inp-poaname">
                <b-form-input id="inp-poaname" v-model="poa.name"></b-form-input>
            </b-form-group>
            <b-form-group id="flds-poafname" label-cols-sm="4" label-cols-lg="3" description="Please specify Seller's representative family name" label="Last Name" label-for="inp-poafname">
            <b-form-input id="inp-poafname" v-model="poa.familyname"></b-form-input>
            </b-form-group>
            <b-form-group id="flds-poadateofbirth" label-cols-sm="4" label-cols-lg="3" description="Seller's representative date of birth." label="Date of Birth" label-for="inp-poadateofbirth">
                <b-form-input id="inp-poadateofbirth" type='date' v-model="poa.dateofbirth"></b-form-input>
            </b-form-group>
            <b-form-group id="flds-poaplaceofbirth" label-cols-sm="4" label-cols-lg="3" description="Seller's representative place of birth." label="Place of Birth" label-for="inp-poaplaceofbirth">
                <b-form-input id="inp-poaplaceofbirth" v-model="poa.placeofbirth"></b-form-input>
            </b-form-group>
            <b-form-group id="flds-poacountry" label-cols-sm="4" label-cols-lg="3" description="Seller's representative Country." label="Country" label-for="inp-poacountry">
                <b-form-select id="inp-poacountry" v-model="poa.country" :options="country_list"></b-form-select>
            </b-form-group>
            <b-form-group id="flds-poaweb" label-cols-sm="4" label-cols-lg="3" description="Please specify Seller's representative URL (if applicable)" label="Website" label-for="inp-poaweb">
                <b-form-input id="inp-poaweb" v-model="poa.website"></b-form-input>
            </b-form-group>
            </b-form-group>
            <b-form-group id="flds-poarole" label-cols-sm="4" label-cols-lg="3" description="Position/Acting in the capacity of" label="Role" label-for="inp-poarole">
                <b-form-input id="inp-poarole" v-model="poa.role"></b-form-input>
            </b-form-group>
            <b-form-group id="flds-poacity" label-cols-sm="4" label-cols-lg="3" description="Please specify Seller's representative city" label="City" label-for="inp-poacity">
                <b-form-input id="inp-poacity" v-model="poa.city"></b-form-input>
            </b-form-group>
            <b-form-group id="flds-poastreetandnumber" label-cols-sm="4" label-cols-lg="3" description="Please specify Seller's representative street and number" label="Street and Number" label-for="inp-poastreetandnumber">
                <b-form-input id="inp-poastreetandnumber" v-model="poa.street_and_number"></b-form-input>
            </b-form-group>
            <b-form-group id="flds-poapostcode" label-cols-sm="4" label-cols-lg="3" description="Please specify Seller's representative post code" label="Post code" label-for="inp-poapostcode">
                <b-form-input id="inp-poapostcode" v-model="poa.postcode"></b-form-input>
            </b-form-group>
            <b-form-group id="flds-poatelephone" label-cols-sm="4" label-cols-lg="3" description="Please specify Seller's representative contact phone" label="Telephone" label-for="inp-poatelephone">
            <b-form-input id="inp-poatelephone" v-model="poa.telephone"></b-form-input>
            </b-form-group>
            <b-form-group id="flds-poaemail" label-cols-sm="4" label-cols-lg="3" description="Please specify Seller's representative contact email" label="E-mail" label-for="inp-poaemail">
                <b-form-input id="inp-poaemail" v-model="poa.email"></b-form-input>
            </b-form-group>
            <b-form-group id="flds-poadetails" label-cols-sm="4" label-cols-lg="3" description="Please specify Seller's representative detailed information (if needed)" label="Detailed information" label-for="inp-poadetails">
                <b-form-input id="inp-poadetails" v-model="poa.details"></b-form-input>
            </b-form-group>

            </b-card-body>


            </b-collapse>
            </b-card>

            <b-card no-body class="mb-1">
            <b-card-header header-tag="header" class="p-1" role="tab">
                <b-button block v-b-toggle.accordion-p6 variant="info">C: Information about reliance on the capacities of other entities</b-button>
            </b-card-header>
            <b-collapse id="accordion-p6" accordion="my-accordion" role="tabpanel">
                <b-card-body v-for="item in espd_structure['partII']['C']">
                    <component v-bind:is="item"></component>
                </b-card-body>
            </b-collapse>
            </b-card>

            <b-card no-body class="mb-1">
            <b-card-header header-tag="header" class="p-1" role="tab">
                <b-button block v-b-toggle.accordion-p7 variant="info">D: Information concerning subcontractors on whose capacity the economic operator does not rely</b-button>
            </b-card-header>
            <b-collapse id="accordion-p7" accordion="my-accordion" role="tabpanel">
                <b-card-body v-for="item in espd_structure['partII']['D']">
                    <component v-bind:is="item"></component>
                </b-card-body>
            </b-collapse>
            </b-card>
        </div>
        </b-col>
    </b-row>
    </b-container>
    </template>
    `
})