Vue.component("uuid", {
    data: function () {
        return {
            isBusy: false,
            sources: {},
            uuid_files: [],
            uuid_table: [],
            fields: [ 
                {key: 'version', label: 'Version'},
                {key: 'location', label: 'Spreadsheet'},
                {key: 'code', label: 'Item Code'},
                {key: 'item_id', label: 'Itemd ID'},
                {key: 'uuid', label: 'UUID'},
                {key:'eCertis', label:'eCertis'}
            ],
            filter: null,
            totalRows: 1,
            currentPage: 1,
            perPage: 25,
            pageOptions: [25, 50, 100, 500],
        }
    },

    created(){
        const dataURL = ['ESPD/uuid'] 
        this.isBusy = true
        const getData = async () => {
            try {
                let thecall = await fetch(`${dataURL}/uuid.json`)
                let data = await thecall.json()
                if (thecall.ok) {
                    this.uuid_files = data.uuid_files
                    //console.log(data)

                    //get the rest of the files
                    for (const elm of this.uuid_files) {
                        if (!Object.hasOwn(this.sources, elm.version)) this.sources[elm.version] = {}
                        thecall = await fetch(`${dataURL}/${elm.filename}`)
                        data = await thecall.text()
                        if (thecall.ok) {
                            this.sources[elm.version] = data
                            //console.log(data);
                            //Populate the table data source
                            data.split('\n').map(line => {
                                let cols = line.split('\t')
                                //filter only criteria
                                if( (cols[2].trim().startsWith('SC') || cols[2].trim().startsWith('EC') || !cols[2].trim().startsWith('OT') || cols[2].trim().startsWith('CRITERION') ) &&
                                     (cols[2].trim().indexOf('/') == -1 && cols[2].trim().indexOf('_') == -1 && ['LEGISLATION', 'SUBCRITERION', 'QUESTION'].indexOf(cols[2].trim()) == -1) && 
                                    !cols[1].trim().startsWith('CRITERION.OTHER') && 
                                    !cols[0].trim().startsWith('OTHER') 
                                  ){
                                        this.uuid_table.push({
                                        version: elm.version,
                                        location: cols[0],
                                        code: cols[1],
                                        item_id: cols[2],
                                        uuid: cols[3]
                                    })
                                }
                            })
                        }
                    }
                    this.totalRows = this.uuid_table.length

                    this.isBusy = false

                }
            } catch (error) {
                this.isBusy = false
                console.log("Error!", error)
            }
        }

        getData()
    },

    methods: {
        onFiltered(filteredItems) {
          // Trigger pagination to update the number of buttons/pages due to filtering
            this.totalRows = filteredItems.length
            this.currentPage = 1
        },
        checkeCertis(item){
            //console.log(item);

            const eCertis_URL="https://ec.europa.eu/growth/tools-databases/ecertisrest/criteria/espd"
            const checkURL = async() => {
                try {
                    showToast('Cheking UUID in eCertis ... this may take a couple of minutes.','eCertis check','info','')
                    let thecall = await fetch(`${eCertis_URL}/${item.uuid.replace('\r','').trim()}`)
                    let thedata = await thecall.text()
                    if (thecall.ok){
                        if(thedata.length > 0){
                            showToast(`The UUID:${item.uuid.replace('\r','').trim()} is in eCertis`, 'eCertis check successfully', 'success', `${eCertis_URL}/${item.uuid.replace('\r','').trim()}`)
                            //console.log(thedata)
                            
                        }else{
                            showToast(`The UUID::${item.uuid.replace('\r','').trim()} not forund in eCertis!`, 'eCertis check error', 'danger','')
                            
                        }
                    }
                } catch (error) {
                    
                    console.log(error);
                }
            }

            checkURL()
        }
    },

    template: `
    <b-card title="ESPD UUID search">
        <b-row>
            <b-col sm="4" lg="4" md="4" class="mb-3">
                <b-form-group label="Filter" label-for="filter-input" label-cols-sm="3" label-align-sm="right" label-size="sm" class="mb-0">
                    <b-input-group size="sm">
                        <b-form-input id="filter-input" v-model="filter" type="search" placeholder="Type UUID to Search"></b-form-input>

                    <b-input-group-append>
                        <b-button :disabled="!filter" @click="filter = ''">Clear</b-button>
                    </b-input-group-append>
                    </b-input-group>
                </b-form-group>
            </b-col>
            <b-col sm="2" md="2" class="mb-3">
                <b-form-group label="Per page" label-for="per-page-select"
                label-cols-sm="6" label-cols-md="4" label-cols-lg="3" label-align-sm="right" label-size="sm"
                class="mb-0">
                <b-form-select id="per-page-select" v-model="perPage" :options="pageOptions" size="sm"></b-form-select>
                </b-form-group>
            </b-col>

            <b-col sm="6" md="6" class="mb-3">
                <b-pagination v-model="currentPage" :total-rows="totalRows" :per-page="perPage"
                align="fill" size="sm" class="my-0"></b-pagination>
            </b-col>
        </b-row>
        <b-row>
            <b-table :items="uuid_table" :fields="fields" :filter="filter" :current-page="currentPage" :per-page="perPage" 
            striped hover show-empty small @filtered="onFiltered">
            <template #table-busy>
                <div class="text-center text-danger my-2">
                    <b-spinner class="align-middle"></b-spinner>
                    <strong>Loading...</strong>
                </div>
            </template>
            <template #cell(eCertis)="row">
            <b-button pill variant="warning" size="sm" @click="checkeCertis(row.item)" class="mr-2">
                Check eCertis
            </b-button>
        </template>
            </b-table>
        </b-row>
        </b-card>
    `
})