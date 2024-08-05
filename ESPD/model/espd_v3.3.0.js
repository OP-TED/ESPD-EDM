/**
 * VueJS components for ESDP-EDM 
 * generated on 2024-06-27T10:19:51.384Z 
 */



/**
 * Component - C1 - EG - Participation in a criminal organisation
 */
Vue.component("C1 - EG",
                    { 
                        data(){
                            return {
 "options": [
  {
   "text": "Yes",
   "value": "yes"
  },
  {
   "text": "No",
   "value": "no"
  }
 ],
 "selected01": "yes",
 "selected02": "yes",
 "selected03": "yes",
 "selected04": "yes"
}
                        },
                        template: `<div>
                        <b-card title="C1 - EG - Participation in a criminal organisation">
                            <b-card-text>Has the economic operator itself or any person who is a member of its administrative, management or supervisory body or has powers of representation, decision or control therein been the subject of a conviction by final judgment for participation in a criminal organisation, by a conviction rendered at the most five years ago or in which an exclusion period set out directly in the conviction continues to be applicable? As defined in Article 2 of Council Framework Decision 2008/841/JHA of 24 October 2008 on the fight against organised crime (OJ L 300, 11.11.2008, p. 42).</b-card-text>
                        <b-card><p>[Name of the National Criterion] <em>[Description of the National Criterion ]</em> [<em>0..n</em>]</p>
                    <b-card class="my-1"> <p>Cardinality [<em>1</em>]</p><b-card-text>CAPTION - [Additional information; e.g. no evidences online]</b-card-text>
                                        <b-form-group label="QUESTION - Your Answer [1]">
                                            <b-form-radio-group id="radio-group-01" v-model="selected01" :options="options" name="radio-options01">
                                            </b-form-radio-group>
                                        </b-form-group>
                    </b-card></b-card><b-card-text class="my-1">LEGISLATION [<em>0..n</em>]</b-card-text>
                    <b-card class="my-1"> <p>Cardinality [<em>1</em>]</p>
                                        <b-form-group label="QUESTION - Your answer [1]">
                                            <b-form-radio-group id="radio-group-02" v-model="selected02" :options="options" name="radio-options02">
                                            </b-form-radio-group>
                                        </b-form-group>
                                    <div v-if="selected02 ==='yes'">
                                    <b-card class="my-1"> <p>Cardinality [<em>0..n</em>]</p>
                                            <b-form-group label="QUESTION - Date of conviction [1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="DATE"></b-form-input>
                                            </b-form-group>
                                            <b-form-group label="QUESTION - Reason [1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="DESCRIPTION"></b-form-input>
                                            </b-form-group>
                                            <b-form-group label="QUESTION - Who has been convicted [1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="DESCRIPTION"></b-form-input>
                                            </b-form-group>
                                            <b-form-group label="QUESTION - Length of the period of exclusion [1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="PERIOD"></b-form-input>
                                            </b-form-group><b-card class="my-1"> <p>Cardinality [<em>1</em>]</p>
                                            <b-form-group label="QUESTION - Have you taken measures to demonstrate your reliability (Self-Cleaning)? [1]">
                                                <b-form-radio-group id="radio-group-03" v-model="selected03" :options="options" name="radio-options03">
                                                </b-form-radio-group>
                                            </b-form-group>
                                        <div v-if="selected03 ==='yes'">
                                        <b-card class="my-1"> <p>Cardinality [<em>0..1</em>]</p>
                                            <b-form-group label="QUESTION - Please describe them [1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="DESCRIPTION"></b-form-input>
                                            </b-form-group>
                                        </b-card>
                                        </div></b-card>
                                    </b-card>
                                    </div>
                    </b-card>
                    <b-card class="my-1"> <p>Cardinality [<em>1</em>]</p>
                                        <b-form-group label="QUESTION - Is this information available electronically? [1]">
                                            <b-form-radio-group id="radio-group-04" v-model="selected04" :options="options" name="radio-options04">
                                            </b-form-radio-group>
                                        </b-form-group>
                                    <div v-if="selected04 ==='yes'">
                                    <b-card class="my-1"> <p>Cardinality [<em>0..1</em>]</p>
                                            <b-form-group label="QUESTION - Evidence Supplied [1..n]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="EVIDENCE_IDENTIFIER"></b-form-input>
                                            </b-form-group>
                                    </b-card>
                                    </div>
                    </b-card></b-card>
                    </div>`
                    })

/**
 * Component - C2 - EG - Corruption
 */
Vue.component("C2 - EG",
                    { 
                        data(){
                            return {
 "options": [
  {
   "text": "Yes",
   "value": "yes"
  },
  {
   "text": "No",
   "value": "no"
  }
 ],
 "selected05": "yes",
 "selected06": "yes",
 "selected07": "yes",
 "selected08": "yes"
}
                        },
                        template: `<div>
                        <b-card title="C2 - EG - Corruption">
                            <b-card-text>Has the economic operator itself or any person who is a member of its administrative, management or supervisory body or has powers of representation, decision or control therein been the subject of a conviction by final judgment for corruption, by a conviction rendered at the most five years ago or in which an exclusion period set out directly in the conviction continues to be applicable? As defined in Article 3 of the Convention on the fight against corruption involving officials of the European Communities or officials of Member States of the European Union, OJ C 195, 25.6.1997, p. 1, and in Article 2(1) of Council Framework Decision 2003/568/JHA of 22 July 2003 on combating corruption in the private sector (OJ L 192, 31.7.2003, p. 54). This exclusion ground also includes corruption as defined in the national law of the contracting authority (contracting entity) or the economic operator.</b-card-text>
                        <b-card><p>[Name of the National Criterion] <em>[Description of the National Criterion ]</em> [<em>0..n</em>]</p>
                    <b-card class="my-1"> <p>Cardinality [<em>1</em>]</p><b-card-text>CAPTION - [Additional information; e.g. no evidences online]</b-card-text>
                                        <b-form-group label="QUESTION - Your Answer [1]">
                                            <b-form-radio-group id="radio-group-05" v-model="selected05" :options="options" name="radio-options05">
                                            </b-form-radio-group>
                                        </b-form-group>
                    </b-card></b-card><b-card-text class="my-1">LEGISLATION [<em>0..n</em>]</b-card-text>
                    <b-card class="my-1"> <p>Cardinality [<em>1</em>]</p>
                                        <b-form-group label="QUESTION - Your answer [1]">
                                            <b-form-radio-group id="radio-group-06" v-model="selected06" :options="options" name="radio-options06">
                                            </b-form-radio-group>
                                        </b-form-group>
                                    <div v-if="selected06 ==='yes'">
                                    <b-card class="my-1"> <p>Cardinality [<em>0..n</em>]</p>
                                            <b-form-group label="QUESTION - Date of conviction [1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="DATE"></b-form-input>
                                            </b-form-group>
                                            <b-form-group label="QUESTION - Reason [1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="DESCRIPTION"></b-form-input>
                                            </b-form-group>
                                            <b-form-group label="QUESTION - Who has been convicted [1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="DESCRIPTION"></b-form-input>
                                            </b-form-group>
                                            <b-form-group label="QUESTION - Length of the period of exclusion [1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="PERIOD"></b-form-input>
                                            </b-form-group><b-card class="my-1"> <p>Cardinality [<em>1</em>]</p>
                                            <b-form-group label="QUESTION - Have you taken measures to demonstrate your reliability (Self-Cleaning)? [1]">
                                                <b-form-radio-group id="radio-group-07" v-model="selected07" :options="options" name="radio-options07">
                                                </b-form-radio-group>
                                            </b-form-group>
                                        <div v-if="selected07 ==='yes'">
                                        <b-card class="my-1"> <p>Cardinality [<em>0..1</em>]</p>
                                            <b-form-group label="QUESTION - Please describe them [1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="DESCRIPTION"></b-form-input>
                                            </b-form-group>
                                        </b-card>
                                        </div></b-card>
                                    </b-card>
                                    </div>
                    </b-card>
                    <b-card class="my-1"> <p>Cardinality [<em>1</em>]</p>
                                        <b-form-group label="QUESTION - Is this information available electronically? [1]">
                                            <b-form-radio-group id="radio-group-08" v-model="selected08" :options="options" name="radio-options08">
                                            </b-form-radio-group>
                                        </b-form-group>
                                    <div v-if="selected08 ==='yes'">
                                    <b-card class="my-1"> <p>Cardinality [<em>0..1</em>]</p>
                                            <b-form-group label="QUESTION - Evidence Supplied [1..n]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="EVIDENCE_IDENTIFIER"></b-form-input>
                                            </b-form-group>
                                    </b-card>
                                    </div>
                    </b-card></b-card>
                    </div>`
                    })

/**
 * Component - C3 - EG - Fraud
 */
Vue.component("C3 - EG",
                    { 
                        data(){
                            return {
 "options": [
  {
   "text": "Yes",
   "value": "yes"
  },
  {
   "text": "No",
   "value": "no"
  }
 ],
 "selected09": "yes",
 "selected10": "yes",
 "selected11": "yes",
 "selected12": "yes"
}
                        },
                        template: `<div>
                        <b-card title="C3 - EG - Fraud">
                            <b-card-text>Has the economic operator itself or any person who is a member of its administrative, management or supervisory body or has powers of representation, decision or control therein been the subject of a conviction by final judgment for fraud, by a conviction rendered at the most five years ago or in which an exclusion period set out directly in the conviction continues to be applicable? Within the meaning of Article 1 of the Convention on the protection of the European Communities' financial interests (OJ C 316, 27.11.1995, p. 48).</b-card-text>
                        <b-card><p>[Name of the National Criterion] <em>[Description of the National Criterion ]</em> [<em>0..n</em>]</p>
                    <b-card class="my-1"> <p>Cardinality [<em>1</em>]</p><b-card-text>CAPTION - [Additional information; e.g. no evidences online]</b-card-text>
                                        <b-form-group label="QUESTION - Your Answer [1]">
                                            <b-form-radio-group id="radio-group-09" v-model="selected09" :options="options" name="radio-options09">
                                            </b-form-radio-group>
                                        </b-form-group>
                    </b-card></b-card><b-card-text class="my-1">LEGISLATION [<em>0..n</em>]</b-card-text>
                    <b-card class="my-1"> <p>Cardinality [<em>1</em>]</p>
                                        <b-form-group label="QUESTION - Your answer [1]">
                                            <b-form-radio-group id="radio-group-10" v-model="selected10" :options="options" name="radio-options10">
                                            </b-form-radio-group>
                                        </b-form-group>
                                    <div v-if="selected10 ==='yes'">
                                    <b-card class="my-1"> <p>Cardinality [<em>0..n</em>]</p>
                                            <b-form-group label="QUESTION - Date of conviction [1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="DATE"></b-form-input>
                                            </b-form-group>
                                            <b-form-group label="QUESTION - Reason [1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="DESCRIPTION"></b-form-input>
                                            </b-form-group>
                                            <b-form-group label="QUESTION - Who has been convicted [1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="DESCRIPTION"></b-form-input>
                                            </b-form-group>
                                            <b-form-group label="QUESTION - Length of the period of exclusion [1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="PERIOD"></b-form-input>
                                            </b-form-group><b-card class="my-1"> <p>Cardinality [<em>1</em>]</p>
                                            <b-form-group label="QUESTION - Have you taken measures to demonstrate your reliability (Self-Cleaning)? [1]">
                                                <b-form-radio-group id="radio-group-11" v-model="selected11" :options="options" name="radio-options11">
                                                </b-form-radio-group>
                                            </b-form-group>
                                        <div v-if="selected11 ==='yes'">
                                        <b-card class="my-1"> <p>Cardinality [<em>0..1</em>]</p>
                                            <b-form-group label="QUESTION - Please describe them [1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="DESCRIPTION"></b-form-input>
                                            </b-form-group>
                                        </b-card>
                                        </div></b-card>
                                    </b-card>
                                    </div>
                    </b-card>
                    <b-card class="my-1"> <p>Cardinality [<em>1</em>]</p>
                                        <b-form-group label="QUESTION - Is this information available electronically? [1]">
                                            <b-form-radio-group id="radio-group-12" v-model="selected12" :options="options" name="radio-options12">
                                            </b-form-radio-group>
                                        </b-form-group>
                                    <div v-if="selected12 ==='yes'">
                                    <b-card class="my-1"> <p>Cardinality [<em>0..1</em>]</p>
                                            <b-form-group label="QUESTION - Evidence Supplied [1..n]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="EVIDENCE_IDENTIFIER"></b-form-input>
                                            </b-form-group>
                                    </b-card>
                                    </div>
                    </b-card></b-card>
                    </div>`
                    })

/**
 * Component - C4 - EG - Terrorist offences or offences linked to terrorist activities
 */
Vue.component("C4 - EG",
                    { 
                        data(){
                            return {
 "options": [
  {
   "text": "Yes",
   "value": "yes"
  },
  {
   "text": "No",
   "value": "no"
  }
 ],
 "selected13": "yes",
 "selected14": "yes",
 "selected15": "yes",
 "selected16": "yes"
}
                        },
                        template: `<div>
                        <b-card title="C4 - EG - Terrorist offences or offences linked to terrorist activities">
                            <b-card-text>Has the economic operator itself or any person who is a member of its administrative, management or supervisory body or has powers of representation, decision or control therein been the subject of a conviction by final judgment for terrorist offences or offences linked to terrorist activities, by a conviction rendered at the most five years ago or in which an exclusion period set out directly in the conviction continues to be applicable? As defined in Articles 1 and 3 of Council Framework Decision of 13 June 2002 on combating terrorism (OJ L 164, 22.6.2002, p. 3). This exclusion ground also includes inciting or aiding or abetting or attempting to commit an offence, as referred to in Article 4 of that Framework Decision.</b-card-text>
                        <b-card><p>[Name of the National Criterion] <em>[Description of the National Criterion ]</em> [<em>0..n</em>]</p>
                    <b-card class="my-1"> <p>Cardinality [<em>1</em>]</p><b-card-text>CAPTION - [Additional information; e.g. no evidences online]</b-card-text>
                                        <b-form-group label="QUESTION - Your Answer [1]">
                                            <b-form-radio-group id="radio-group-13" v-model="selected13" :options="options" name="radio-options13">
                                            </b-form-radio-group>
                                        </b-form-group>
                    </b-card></b-card><b-card-text class="my-1">LEGISLATION [<em>0..n</em>]</b-card-text>
                    <b-card class="my-1"> <p>Cardinality [<em>1</em>]</p>
                                        <b-form-group label="QUESTION - Your answer [1]">
                                            <b-form-radio-group id="radio-group-14" v-model="selected14" :options="options" name="radio-options14">
                                            </b-form-radio-group>
                                        </b-form-group>
                                    <div v-if="selected14 ==='yes'">
                                    <b-card class="my-1"> <p>Cardinality [<em>0..n</em>]</p>
                                            <b-form-group label="QUESTION - Date of conviction [1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="DATE"></b-form-input>
                                            </b-form-group>
                                            <b-form-group label="QUESTION - Reason [1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="DESCRIPTION"></b-form-input>
                                            </b-form-group>
                                            <b-form-group label="QUESTION - Who has been convicted [1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="DESCRIPTION"></b-form-input>
                                            </b-form-group>
                                            <b-form-group label="QUESTION - Length of the period of exclusion [1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="PERIOD"></b-form-input>
                                            </b-form-group><b-card class="my-1"> <p>Cardinality [<em>1</em>]</p>
                                            <b-form-group label="QUESTION - Have you taken measures to demonstrate your reliability (Self-Cleaning)? [1]">
                                                <b-form-radio-group id="radio-group-15" v-model="selected15" :options="options" name="radio-options15">
                                                </b-form-radio-group>
                                            </b-form-group>
                                        <div v-if="selected15 ==='yes'">
                                        <b-card class="my-1"> <p>Cardinality [<em>0..1</em>]</p>
                                            <b-form-group label="QUESTION - Please describe them [1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="DESCRIPTION"></b-form-input>
                                            </b-form-group>
                                        </b-card>
                                        </div></b-card>
                                    </b-card>
                                    </div>
                    </b-card>
                    <b-card class="my-1"> <p>Cardinality [<em>1</em>]</p>
                                        <b-form-group label="QUESTION - Is this information available electronically? [1]">
                                            <b-form-radio-group id="radio-group-16" v-model="selected16" :options="options" name="radio-options16">
                                            </b-form-radio-group>
                                        </b-form-group>
                                    <div v-if="selected16 ==='yes'">
                                    <b-card class="my-1"> <p>Cardinality [<em>0..1</em>]</p>
                                            <b-form-group label="QUESTION - Evidence Supplied [1..n]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="EVIDENCE_IDENTIFIER"></b-form-input>
                                            </b-form-group>
                                    </b-card>
                                    </div>
                    </b-card></b-card>
                    </div>`
                    })

/**
 * Component - C5 - EG - Money laundering or terrorist financing
 */
Vue.component("C5 - EG",
                    { 
                        data(){
                            return {
 "options": [
  {
   "text": "Yes",
   "value": "yes"
  },
  {
   "text": "No",
   "value": "no"
  }
 ],
 "selected17": "yes",
 "selected18": "yes",
 "selected19": "yes",
 "selected20": "yes"
}
                        },
                        template: `<div>
                        <b-card title="C5 - EG - Money laundering or terrorist financing">
                            <b-card-text>Has the economic operator itself or any person who is a member of its administrative, management or supervisory body or has powers of representation, decision or control therein been the subject of a conviction by final judgment for money laundering or terrorist financing, by a conviction rendered at the most five years ago or in which an exclusion period set out directly in the conviction continues to be applicable? As defined in Article 1 of Directive 2005/60/EC of the European Parliament and of the Council of 26 October 2005 on the prevention of the use of the financial system for the purpose of money laundering and terrorist financing (OJ L 309, 25.11.2005, p. 15).</b-card-text>
                        <b-card><p>[Name of the National Criterion] <em>[Description of the National Criterion ]</em> [<em>0..n</em>]</p>
                    <b-card class="my-1"> <p>Cardinality [<em>1</em>]</p><b-card-text>CAPTION - [Additional information; e.g. no evidences online]</b-card-text>
                                        <b-form-group label="QUESTION - Your Answer [1]">
                                            <b-form-radio-group id="radio-group-17" v-model="selected17" :options="options" name="radio-options17">
                                            </b-form-radio-group>
                                        </b-form-group>
                    </b-card></b-card><b-card-text class="my-1">LEGISLATION [<em>0..n</em>]</b-card-text>
                    <b-card class="my-1"> <p>Cardinality [<em>1</em>]</p>
                                        <b-form-group label="QUESTION - Your answer [1]">
                                            <b-form-radio-group id="radio-group-18" v-model="selected18" :options="options" name="radio-options18">
                                            </b-form-radio-group>
                                        </b-form-group>
                                    <div v-if="selected18 ==='yes'">
                                    <b-card class="my-1"> <p>Cardinality [<em>0..n</em>]</p>
                                            <b-form-group label="QUESTION - Date of conviction [1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="DATE"></b-form-input>
                                            </b-form-group>
                                            <b-form-group label="QUESTION - Reason [1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="DESCRIPTION"></b-form-input>
                                            </b-form-group>
                                            <b-form-group label="QUESTION - Who has been convicted [1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="DESCRIPTION"></b-form-input>
                                            </b-form-group>
                                            <b-form-group label="QUESTION - Length of the period of exclusion [1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="PERIOD"></b-form-input>
                                            </b-form-group><b-card class="my-1"> <p>Cardinality [<em>1</em>]</p>
                                            <b-form-group label="QUESTION - Have you taken measures to demonstrate your reliability (Self-Cleaning)? [1]">
                                                <b-form-radio-group id="radio-group-19" v-model="selected19" :options="options" name="radio-options19">
                                                </b-form-radio-group>
                                            </b-form-group>
                                        <div v-if="selected19 ==='yes'">
                                        <b-card class="my-1"> <p>Cardinality [<em>0..1</em>]</p>
                                            <b-form-group label="QUESTION - Please describe them [1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="DESCRIPTION"></b-form-input>
                                            </b-form-group>
                                        </b-card>
                                        </div></b-card>
                                    </b-card>
                                    </div>
                    </b-card>
                    <b-card class="my-1"> <p>Cardinality [<em>1</em>]</p>
                                        <b-form-group label="QUESTION - Is this information available electronically? [1]">
                                            <b-form-radio-group id="radio-group-20" v-model="selected20" :options="options" name="radio-options20">
                                            </b-form-radio-group>
                                        </b-form-group>
                                    <div v-if="selected20 ==='yes'">
                                    <b-card class="my-1"> <p>Cardinality [<em>0..1</em>]</p>
                                            <b-form-group label="QUESTION - Evidence Supplied [1..n]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="EVIDENCE_IDENTIFIER"></b-form-input>
                                            </b-form-group>
                                    </b-card>
                                    </div>
                    </b-card></b-card>
                    </div>`
                    })

/**
 * Component - C6 - EG - Child labour and other forms of trafficking in human beings
 */
Vue.component("C6 - EG",
                    { 
                        data(){
                            return {
 "options": [
  {
   "text": "Yes",
   "value": "yes"
  },
  {
   "text": "No",
   "value": "no"
  }
 ],
 "selected21": "yes",
 "selected22": "yes",
 "selected23": "yes",
 "selected24": "yes"
}
                        },
                        template: `<div>
                        <b-card title="C6 - EG - Child labour and other forms of trafficking in human beings">
                            <b-card-text>Has the economic operator itself or any person who is a member of its administrative, management or supervisory body or has powers of representation, decision or control therein been the subject of a conviction by final judgment for child labour and other forms of trafficking in human beings, by a conviction rendered at the most five years ago or in which an exclusion period set out directly in the conviction continues to be applicable? As defined in Article 2 of Directive 2011/36/EU of the European Parliament and of the Council of 5 April 2011 on preventing and combating trafficking in human beings and protecting its victims, and replacing Council Framework Decision 2002/629/JHA (OJ L 101, 15.4.2011, p. 1).</b-card-text>
                        <b-card><p>[Name of the National Criterion] <em>[Description of the National Criterion ]</em> [<em>0..n</em>]</p>
                    <b-card class="my-1"> <p>Cardinality [<em>1</em>]</p><b-card-text>CAPTION - [Additional information; e.g. no evidences online]</b-card-text>
                                        <b-form-group label="QUESTION - Your Answer [1]">
                                            <b-form-radio-group id="radio-group-21" v-model="selected21" :options="options" name="radio-options21">
                                            </b-form-radio-group>
                                        </b-form-group>
                    </b-card></b-card><b-card-text class="my-1">LEGISLATION [<em>0..n</em>]</b-card-text>
                    <b-card class="my-1"> <p>Cardinality [<em>1</em>]</p>
                                        <b-form-group label="QUESTION - Your answer [1]">
                                            <b-form-radio-group id="radio-group-22" v-model="selected22" :options="options" name="radio-options22">
                                            </b-form-radio-group>
                                        </b-form-group>
                                    <div v-if="selected22 ==='yes'">
                                    <b-card class="my-1"> <p>Cardinality [<em>0..n</em>]</p>
                                            <b-form-group label="QUESTION - Date of conviction [1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="DATE"></b-form-input>
                                            </b-form-group>
                                            <b-form-group label="QUESTION - Reason [1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="DESCRIPTION"></b-form-input>
                                            </b-form-group>
                                            <b-form-group label="QUESTION - Who has been convicted [1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="DESCRIPTION"></b-form-input>
                                            </b-form-group>
                                            <b-form-group label="QUESTION - Length of the period of exclusion [1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="PERIOD"></b-form-input>
                                            </b-form-group><b-card class="my-1"> <p>Cardinality [<em>1</em>]</p>
                                            <b-form-group label="QUESTION - Have you taken measures to demonstrate your reliability (Self-Cleaning)? [1]">
                                                <b-form-radio-group id="radio-group-23" v-model="selected23" :options="options" name="radio-options23">
                                                </b-form-radio-group>
                                            </b-form-group>
                                        <div v-if="selected23 ==='yes'">
                                        <b-card class="my-1"> <p>Cardinality [<em>0..1</em>]</p>
                                            <b-form-group label="QUESTION - Please describe them [1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="DESCRIPTION"></b-form-input>
                                            </b-form-group>
                                        </b-card>
                                        </div></b-card>
                                    </b-card>
                                    </div>
                    </b-card>
                    <b-card class="my-1"> <p>Cardinality [<em>1</em>]</p>
                                        <b-form-group label="QUESTION - Is this information available electronically? [1]">
                                            <b-form-radio-group id="radio-group-24" v-model="selected24" :options="options" name="radio-options24">
                                            </b-form-radio-group>
                                        </b-form-group>
                                    <div v-if="selected24 ==='yes'">
                                    <b-card class="my-1"> <p>Cardinality [<em>0..1</em>]</p>
                                            <b-form-group label="QUESTION - Evidence Supplied [1..n]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="EVIDENCE_IDENTIFIER"></b-form-input>
                                            </b-form-group>
                                    </b-card>
                                    </div>
                    </b-card></b-card>
                    </div>`
                    })

/**
 * Component - C7 - EG - Payment of taxes
 */
Vue.component("C7 - EG",
                    { 
                        data(){
                            return {
 "options": [
  {
   "text": "Yes",
   "value": "yes"
  },
  {
   "text": "No",
   "value": "no"
  }
 ],
 "selected25": "yes",
 "selected26": "yes",
 "selected27": "yes",
 "selected28": "yes",
 "selected29": "yes",
 "selected30": "yes"
}
                        },
                        template: `<div>
                        <b-card title="C7 - EG - Payment of taxes">
                            <b-card-text>Has the economic operator breached its obligations relating to the payment of taxes, both in the country in which it is established and in Member State of the contracting authority or contracting entity if other than the country of establishment?</b-card-text>
                        <b-card><p>[Name of the National Criterion] <em>[Description of the National Criterion ]</em> [<em>0..n</em>]</p>
                    <b-card class="my-1"> <p>Cardinality [<em>1</em>]</p><b-card-text>CAPTION - [Additional information; e.g. no evidences online]</b-card-text>
                                        <b-form-group label="QUESTION - Your Answer [1]">
                                            <b-form-radio-group id="radio-group-25" v-model="selected25" :options="options" name="radio-options25">
                                            </b-form-radio-group>
                                        </b-form-group>
                    </b-card></b-card><b-card-text class="my-1">LEGISLATION [<em>0..n</em>]</b-card-text><b-card>
                    <b-form-group label="REQUIREMENT - Threshold [1]"
                    label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                    <b-form-input placeholder="AMOUNT"></b-form-input>
                    </b-form-group>
                    
                    <b-form-group label="REQUIREMENT - Additional Information [1]"
                    label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                    <b-form-input placeholder="DESCRIPTION"></b-form-input>
                    </b-form-group>
                    
                                            <b-form-group label="QUESTION - Your answer [1]">
                                                <b-form-radio-group id="radio-group-26" v-model="selected26" :options="options" name="radio-options26">
                                                </b-form-radio-group>
                                            </b-form-group>
                                        <div v-if="selected26 ==='yes'">
                                        <b-card class="my-1"> <p>Cardinality [<em>0..1</em>]</p>
                                            <b-form-group label="QUESTION - Country or member state concerned [1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="CODE_COUNTRY"></b-form-input>
                                            </b-form-group>
                                            <b-form-group label="QUESTION - Amount concerned [1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="AMOUNT"></b-form-input>
                                            </b-form-group><b-card class="my-1"> <p>Cardinality [<em>1</em>]</p>
                                            <b-form-group label="QUESTION - Has this breach of obligations been established by means other than a judicial or administrative decision? [1]">
                                                <b-form-radio-group id="radio-group-27" v-model="selected27" :options="options" name="radio-options27">
                                                </b-form-radio-group>
                                            </b-form-group>
                                        <div v-if="selected27 ==='yes'">
                                        <b-card class="my-1"> <p>Cardinality [<em>0..1</em>]</p>
                                            <b-form-group label="QUESTION - Please describe which means were used [1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="DESCRIPTION"></b-form-input>
                                            </b-form-group>
                                        </b-card>
                                        </div><b-card class="my-1"> <p>Cardinality [<em>0..1</em>]</p>
                                            <b-form-group label="QUESTION - Has the economic operator fulfilled its obligations by paying or entering into a binding arrangement with a view to paying the taxes contributions due, including, where applicable, any interest accrued or fines? [1]">
                                                <b-form-radio-group id="radio-group-28" v-model="selected28" :options="options" name="radio-options28">
                                                </b-form-radio-group>
                                            </b-form-group>
                                        <div v-if="selected28 ==='yes'">
                                        <b-card class="my-1"> <p>Cardinality [<em>0..1</em>]</p>
                                            <b-form-group label="QUESTION - Please describe them [1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="DESCRIPTION"></b-form-input>
                                            </b-form-group>
                                        </b-card>
                                        </div></b-card>
                                        <div v-if="selected27 ==='no'">
                                        <b-card class="my-1"> <p>Cardinality [<em>0..1</em>]</p>
                                            <b-form-group label="QUESTION - If this breach of obligations was established through a judicial or administrative decision, was this decision final and binding? [1]">
                                                <b-form-radio-group id="radio-group-29" v-model="selected29" :options="options" name="radio-options29">
                                                </b-form-radio-group>
                                            </b-form-group>
                                        <div v-if="selected29 ==='yes'">
                                        <b-card class="my-1"> <p>Cardinality [<em>0..1</em>]</p>
                                            <b-form-group label="QUESTION - Please indicate the date of conviction or decision [1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="DATE"></b-form-input>
                                            </b-form-group>
                                            <b-form-group label="QUESTION - In case of a conviction insofar as established directly therein, the length of the period of exclusion [1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="PERIOD"></b-form-input>
                                            </b-form-group>
                                        </b-card>
                                        </div>
                                        </b-card>
                                        </div></b-card>
                                        </b-card>
                                        </div>
                                            <b-form-group label="QUESTION - Is this information available electronically? [1]">
                                                <b-form-radio-group id="radio-group-30" v-model="selected30" :options="options" name="radio-options30">
                                                </b-form-radio-group>
                                            </b-form-group>
                                        <div v-if="selected30 ==='yes'">
                                        <b-card class="my-1"> <p>Cardinality [<em>0..1</em>]</p>
                                            <b-form-group label="QUESTION - Evidence Supplied [1..n]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="EVIDENCE_IDENTIFIER"></b-form-input>
                                            </b-form-group>
                                        </b-card>
                                        </div></b-card></b-card>
                    </div>`
                    })

/**
 * Component - C8 - EG - Payment of social security contributions
 */
Vue.component("C8 - EG",
                    { 
                        data(){
                            return {
 "options": [
  {
   "text": "Yes",
   "value": "yes"
  },
  {
   "text": "No",
   "value": "no"
  }
 ],
 "selected31": "yes",
 "selected32": "yes",
 "selected33": "yes",
 "selected34": "yes",
 "selected35": "yes",
 "selected36": "yes"
}
                        },
                        template: `<div>
                        <b-card title="C8 - EG - Payment of social security contributions">
                            <b-card-text>Has the economic operator breached its obligations relating to the payment of social security contributions, both in the country in which it is established and in Member State of the contracting authority or contracting entity if other than the country of establishment?</b-card-text>
                        <b-card><p>[Name of the National Criterion] <em>[Description of the National Criterion ]</em> [<em>0..n</em>]</p>
                    <b-card class="my-1"> <p>Cardinality [<em>1</em>]</p><b-card-text>CAPTION - [Additional information; e.g. no evidences online]</b-card-text>
                                        <b-form-group label="QUESTION - Your Answer [1]">
                                            <b-form-radio-group id="radio-group-31" v-model="selected31" :options="options" name="radio-options31">
                                            </b-form-radio-group>
                                        </b-form-group>
                    </b-card></b-card><b-card-text class="my-1">LEGISLATION [<em>0..n</em>]</b-card-text><b-card>
                    <b-form-group label="REQUIREMENT - Threshold [1]"
                    label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                    <b-form-input placeholder="AMOUNT"></b-form-input>
                    </b-form-group>
                    
                    <b-form-group label="REQUIREMENT - Additional Information [1]"
                    label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                    <b-form-input placeholder="DESCRIPTION"></b-form-input>
                    </b-form-group>
                    
                                            <b-form-group label="QUESTION - Your answer [1]">
                                                <b-form-radio-group id="radio-group-32" v-model="selected32" :options="options" name="radio-options32">
                                                </b-form-radio-group>
                                            </b-form-group>
                                        <div v-if="selected32 ==='yes'">
                                        <b-card class="my-1"> <p>Cardinality [<em>0..1</em>]</p>
                                            <b-form-group label="QUESTION - Country or member state concerned [1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="CODE_COUNTRY"></b-form-input>
                                            </b-form-group>
                                            <b-form-group label="QUESTION - Amount concerned [1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="AMOUNT"></b-form-input>
                                            </b-form-group><b-card class="my-1"> <p>Cardinality [<em>1</em>]</p>
                                            <b-form-group label="QUESTION - Has this breach of obligations been established by means other than a judicial or administrative decision? [1]">
                                                <b-form-radio-group id="radio-group-33" v-model="selected33" :options="options" name="radio-options33">
                                                </b-form-radio-group>
                                            </b-form-group>
                                        <div v-if="selected33 ==='yes'">
                                        <b-card class="my-1"> <p>Cardinality [<em>0..1</em>]</p>
                                            <b-form-group label="QUESTION - Please describe which means were used [1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="DESCRIPTION"></b-form-input>
                                            </b-form-group>
                                        </b-card>
                                        </div><b-card class="my-1"> <p>Cardinality [<em>0..1</em>]</p>
                                            <b-form-group label="QUESTION - Has the economic operator fulfilled its obligations by paying or entering into a binding arrangement with a view to paying the social security contributions due, including, where applicable, any interest accrued or fines? [1]">
                                                <b-form-radio-group id="radio-group-34" v-model="selected34" :options="options" name="radio-options34">
                                                </b-form-radio-group>
                                            </b-form-group>
                                        <div v-if="selected34 ==='yes'">
                                        <b-card class="my-1"> <p>Cardinality [<em>0..1</em>]</p>
                                            <b-form-group label="QUESTION - Please describe them [1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="DESCRIPTION"></b-form-input>
                                            </b-form-group>
                                        </b-card>
                                        </div></b-card>
                                        <div v-if="selected33 ==='no'">
                                        <b-card class="my-1"> <p>Cardinality [<em>0..1</em>]</p>
                                            <b-form-group label="QUESTION - If this breach of obligations was established through a judicial or administrative decision, was this decision final and binding? [1]">
                                                <b-form-radio-group id="radio-group-35" v-model="selected35" :options="options" name="radio-options35">
                                                </b-form-radio-group>
                                            </b-form-group>
                                        <div v-if="selected35 ==='yes'">
                                        <b-card class="my-1"> <p>Cardinality [<em>0..1</em>]</p>
                                            <b-form-group label="QUESTION - Please indicate the date of conviction or decision [1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="DATE"></b-form-input>
                                            </b-form-group>
                                            <b-form-group label="QUESTION - In case of a conviction insofar as established directly therein, the length of the period of exclusion [1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="PERIOD"></b-form-input>
                                            </b-form-group>
                                        </b-card>
                                        </div>
                                        </b-card>
                                        </div></b-card>
                                        </b-card>
                                        </div>
                                            <b-form-group label="QUESTION - Is this information available electronically? [1]">
                                                <b-form-radio-group id="radio-group-36" v-model="selected36" :options="options" name="radio-options36">
                                                </b-form-radio-group>
                                            </b-form-group>
                                        <div v-if="selected36 ==='yes'">
                                        <b-card class="my-1"> <p>Cardinality [<em>0..1</em>]</p>
                                            <b-form-group label="QUESTION - Evidence Supplied [1..n]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="EVIDENCE_IDENTIFIER"></b-form-input>
                                            </b-form-group>
                                        </b-card>
                                        </div></b-card></b-card>
                    </div>`
                    })

/**
 * Component - C9 - EG - Breaching of obligations in the fields of environmental law
 */
Vue.component("C9 - EG",
                    { 
                        data(){
                            return {
 "options": [
  {
   "text": "Yes",
   "value": "yes"
  },
  {
   "text": "No",
   "value": "no"
  }
 ],
 "selected37": "yes",
 "selected38": "yes",
 "selected39": "yes",
 "selected40": "yes"
}
                        },
                        template: `<div>
                        <b-card title="C9 - EG - Breaching of obligations in the fields of environmental law">
                            <b-card-text>Has the economic operator, to its knowledge, breached its obligations in the fields of environmental law? As referred to for the purposes of this procurement in national law, in the ESPD, the relevant notice or the in the ESPD, the relevant notice or , in Article 18(2) of Directive 2014/24/EU or in the ESPD.</b-card-text>
                        <b-card><p>[Name of the National Criterion] <em>[Description of the National Criterion ]</em> [<em>0..n</em>]</p>
                    <b-card class="my-1"> <p>Cardinality [<em>1</em>]</p><b-card-text>CAPTION - [Additional information; e.g. no evidences online]</b-card-text>
                                        <b-form-group label="QUESTION - Your Answer [1]">
                                            <b-form-radio-group id="radio-group-37" v-model="selected37" :options="options" name="radio-options37">
                                            </b-form-radio-group>
                                        </b-form-group>
                    </b-card></b-card><b-card-text class="my-1">LEGISLATION [<em>0..n</em>]</b-card-text>
                    <b-card class="my-1"> <p>Cardinality [<em>1</em>]</p>
                                        <b-form-group label="QUESTION - Your answer [1]">
                                            <b-form-radio-group id="radio-group-38" v-model="selected38" :options="options" name="radio-options38">
                                            </b-form-radio-group>
                                        </b-form-group>
                                    <div v-if="selected38 ==='yes'">
                                    <b-card class="my-1"> <p>Cardinality [<em>0..1</em>]</p>
                                            <b-form-group label="QUESTION - Have you taken measures to demonstrate your reliability (Self-Cleaning)? [1]">
                                                <b-form-radio-group id="radio-group-39" v-model="selected39" :options="options" name="radio-options39">
                                                </b-form-radio-group>
                                            </b-form-group>
                                        <div v-if="selected39 ==='yes'">
                                        <b-card class="my-1"> <p>Cardinality [<em>0..1</em>]</p>
                                            <b-form-group label="QUESTION - Please describe them [1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="DESCRIPTION"></b-form-input>
                                            </b-form-group>
                                        </b-card>
                                        </div>
                                    </b-card>
                                    </div>
                    </b-card>
                    <b-card class="my-1"> <p>Cardinality [<em>1</em>]</p>
                                        <b-form-group label="QUESTION - Is this information available electronically? [1]">
                                            <b-form-radio-group id="radio-group-40" v-model="selected40" :options="options" name="radio-options40">
                                            </b-form-radio-group>
                                        </b-form-group>
                                    <div v-if="selected40 ==='yes'">
                                    <b-card class="my-1"> <p>Cardinality [<em>0..1</em>]</p>
                                            <b-form-group label="QUESTION - Evidence Supplied [1..n]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="EVIDENCE_IDENTIFIER"></b-form-input>
                                            </b-form-group>
                                    </b-card>
                                    </div>
                    </b-card></b-card>
                    </div>`
                    })

/**
 * Component - C10 - EG - Breaching of obligations in the fields of social law
 */
Vue.component("C10 - EG",
                    { 
                        data(){
                            return {
 "options": [
  {
   "text": "Yes",
   "value": "yes"
  },
  {
   "text": "No",
   "value": "no"
  }
 ],
 "selected41": "yes",
 "selected42": "yes",
 "selected43": "yes",
 "selected44": "yes"
}
                        },
                        template: `<div>
                        <b-card title="C10 - EG - Breaching of obligations in the fields of social law">
                            <b-card-text>Has the economic operator, to its knowledge, breached its obligations in the fields of social law? As referred to for the purposes of this procurement in national law, in the ESPD, the relevant notice or the in the ESPD, the relevant notice or in Article 18(2) of Directive 2014/24/EU.</b-card-text>
                        <b-card><p>[Name of the National Criterion] <em>[Description of the National Criterion ]</em> [<em>0..n</em>]</p>
                    <b-card class="my-1"> <p>Cardinality [<em>1</em>]</p><b-card-text>CAPTION - [Additional information; e.g. no evidences online]</b-card-text>
                                        <b-form-group label="QUESTION - Your Answer [1]">
                                            <b-form-radio-group id="radio-group-41" v-model="selected41" :options="options" name="radio-options41">
                                            </b-form-radio-group>
                                        </b-form-group>
                    </b-card></b-card><b-card-text class="my-1">LEGISLATION [<em>0..n</em>]</b-card-text>
                    <b-card class="my-1"> <p>Cardinality [<em>1</em>]</p>
                                        <b-form-group label="QUESTION - Your answer [1]">
                                            <b-form-radio-group id="radio-group-42" v-model="selected42" :options="options" name="radio-options42">
                                            </b-form-radio-group>
                                        </b-form-group>
                                    <div v-if="selected42 ==='yes'">
                                    <b-card class="my-1"> <p>Cardinality [<em>0..1</em>]</p>
                                            <b-form-group label="QUESTION - Have you taken measures to demonstrate your reliability (Self-Cleaning)? [1]">
                                                <b-form-radio-group id="radio-group-43" v-model="selected43" :options="options" name="radio-options43">
                                                </b-form-radio-group>
                                            </b-form-group>
                                        <div v-if="selected43 ==='yes'">
                                        <b-card class="my-1"> <p>Cardinality [<em>0..1</em>]</p>
                                            <b-form-group label="QUESTION - Please describe them [1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="DESCRIPTION"></b-form-input>
                                            </b-form-group>
                                        </b-card>
                                        </div>
                                    </b-card>
                                    </div>
                    </b-card>
                    <b-card class="my-1"> <p>Cardinality [<em>1</em>]</p>
                                        <b-form-group label="QUESTION - Is this information available electronically? [1]">
                                            <b-form-radio-group id="radio-group-44" v-model="selected44" :options="options" name="radio-options44">
                                            </b-form-radio-group>
                                        </b-form-group>
                                    <div v-if="selected44 ==='yes'">
                                    <b-card class="my-1"> <p>Cardinality [<em>0..1</em>]</p>
                                            <b-form-group label="QUESTION - Evidence Supplied [1..n]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="EVIDENCE_IDENTIFIER"></b-form-input>
                                            </b-form-group>
                                    </b-card>
                                    </div>
                    </b-card></b-card>
                    </div>`
                    })

/**
 * Component - C11 - EG - Breaching of obligations in the fields of labour law
 */
Vue.component("C11 - EG",
                    { 
                        data(){
                            return {
 "options": [
  {
   "text": "Yes",
   "value": "yes"
  },
  {
   "text": "No",
   "value": "no"
  }
 ],
 "selected45": "yes",
 "selected46": "yes",
 "selected47": "yes",
 "selected48": "yes"
}
                        },
                        template: `<div>
                        <b-card title="C11 - EG - Breaching of obligations in the fields of labour law">
                            <b-card-text>Has the economic operator, to its knowledge, breached its obligations in the fields of labour law? As referred to for the purposes of this procurement in national law, in the relevant notice or the in the ESPD, the relevant notice or in Article 18(2) of Directive 2014/24/EU.</b-card-text>
                        <b-card><p>[Name of the National Criterion] <em>[Description of the National Criterion ]</em> [<em>0..n</em>]</p>
                    <b-card class="my-1"> <p>Cardinality [<em>1</em>]</p><b-card-text>CAPTION - [Additional information; e.g. no evidences online]</b-card-text>
                                        <b-form-group label="QUESTION - Your Answer [1]">
                                            <b-form-radio-group id="radio-group-45" v-model="selected45" :options="options" name="radio-options45">
                                            </b-form-radio-group>
                                        </b-form-group>
                    </b-card></b-card><b-card-text class="my-1">LEGISLATION [<em>0..n</em>]</b-card-text>
                    <b-card class="my-1"> <p>Cardinality [<em>1</em>]</p>
                                        <b-form-group label="QUESTION - Your answer [1]">
                                            <b-form-radio-group id="radio-group-46" v-model="selected46" :options="options" name="radio-options46">
                                            </b-form-radio-group>
                                        </b-form-group>
                                    <div v-if="selected46 ==='yes'">
                                    <b-card class="my-1"> <p>Cardinality [<em>0..1</em>]</p>
                                            <b-form-group label="QUESTION - Have you taken measures to demonstrate your reliability (Self-Cleaning)? [1]">
                                                <b-form-radio-group id="radio-group-47" v-model="selected47" :options="options" name="radio-options47">
                                                </b-form-radio-group>
                                            </b-form-group>
                                        <div v-if="selected47 ==='yes'">
                                        <b-card class="my-1"> <p>Cardinality [<em>0..1</em>]</p>
                                            <b-form-group label="QUESTION - Please describe them [1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="DESCRIPTION"></b-form-input>
                                            </b-form-group>
                                        </b-card>
                                        </div>
                                    </b-card>
                                    </div>
                    </b-card>
                    <b-card class="my-1"> <p>Cardinality [<em>1</em>]</p>
                                        <b-form-group label="QUESTION - Is this information available electronically? [1]">
                                            <b-form-radio-group id="radio-group-48" v-model="selected48" :options="options" name="radio-options48">
                                            </b-form-radio-group>
                                        </b-form-group>
                                    <div v-if="selected48 ==='yes'">
                                    <b-card class="my-1"> <p>Cardinality [<em>0..1</em>]</p>
                                            <b-form-group label="QUESTION - Evidence Supplied [1..n]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="EVIDENCE_IDENTIFIER"></b-form-input>
                                            </b-form-group>
                                    </b-card>
                                    </div>
                    </b-card></b-card>
                    </div>`
                    })

/**
 * Component - C12 - EG - Bankruptcy
 */
Vue.component("C12 - EG",
                    { 
                        data(){
                            return {
 "options": [
  {
   "text": "Yes",
   "value": "yes"
  },
  {
   "text": "No",
   "value": "no"
  }
 ],
 "selected49": "yes",
 "selected50": "yes",
 "selected51": "yes"
}
                        },
                        template: `<div>
                        <b-card title="C12 - EG - Bankruptcy">
                            <b-card-text>Is the economic operator bankrupt? This information needs not be given if exclusion of economic operators in this case has been made mandatory under the applicable national law without any possibility of derogation where the economic operator is nevertheless able to perform the contract.</b-card-text>
                        <b-card><p>[Name of the National Criterion] <em>[Description of the National Criterion ]</em> [<em>0..n</em>]</p>
                    <b-card class="my-1"> <p>Cardinality [<em>1</em>]</p><b-card-text>CAPTION - [Additional information; e.g. no evidences online]</b-card-text>
                                        <b-form-group label="QUESTION - Your Answer [1]">
                                            <b-form-radio-group id="radio-group-49" v-model="selected49" :options="options" name="radio-options49">
                                            </b-form-radio-group>
                                        </b-form-group>
                    </b-card></b-card><b-card-text class="my-1">LEGISLATION [<em>0..n</em>]</b-card-text>
                    <b-card class="my-1"> <p>Cardinality [<em>1</em>]</p>
                                        <b-form-group label="QUESTION - Your answer [1]">
                                            <b-form-radio-group id="radio-group-50" v-model="selected50" :options="options" name="radio-options50">
                                            </b-form-radio-group>
                                        </b-form-group>
                                    <div v-if="selected50 ==='yes'">
                                    <b-card class="my-1"> <p>Cardinality [<em>0..1</em>]</p>
                                            <b-form-group label="QUESTION - Please describe them [1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="DESCRIPTION"></b-form-input>
                                            </b-form-group>
                                            <b-form-group label="QUESTION - Indicate reasons for being nevertheless to perform the contract [1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="DESCRIPTION"></b-form-input>
                                            </b-form-group>
                                    </b-card>
                                    </div>
                    </b-card>
                    <b-card class="my-1"> <p>Cardinality [<em>1</em>]</p>
                                        <b-form-group label="QUESTION - Is this information available electronically? [1]">
                                            <b-form-radio-group id="radio-group-51" v-model="selected51" :options="options" name="radio-options51">
                                            </b-form-radio-group>
                                        </b-form-group>
                                    <div v-if="selected51 ==='yes'">
                                    <b-card class="my-1"> <p>Cardinality [<em>0..1</em>]</p>
                                            <b-form-group label="QUESTION - Evidence Supplied [1..n]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="EVIDENCE_IDENTIFIER"></b-form-input>
                                            </b-form-group>
                                    </b-card>
                                    </div>
                    </b-card></b-card>
                    </div>`
                    })

/**
 * Component - C13 - EG - Insolvency
 */
Vue.component("C13 - EG",
                    { 
                        data(){
                            return {
 "options": [
  {
   "text": "Yes",
   "value": "yes"
  },
  {
   "text": "No",
   "value": "no"
  }
 ],
 "selected52": "yes",
 "selected53": "yes",
 "selected54": "yes"
}
                        },
                        template: `<div>
                        <b-card title="C13 - EG - Insolvency">
                            <b-card-text>Is the economic operator the subject of insolvency or winding-up? This information needs not be given if exclusion of economic operators in this case has been made mandatory under the applicable national law without any possibility of derogation where the economic operator is nevertheless able to perform the contract.</b-card-text>
                        <b-card><p>[Name of the National Criterion] <em>[Description of the National Criterion ]</em> [<em>0..n</em>]</p>
                    <b-card class="my-1"> <p>Cardinality [<em>1</em>]</p><b-card-text>CAPTION - [Additional information; e.g. no evidences online]</b-card-text>
                                        <b-form-group label="QUESTION - Your Answer [1]">
                                            <b-form-radio-group id="radio-group-52" v-model="selected52" :options="options" name="radio-options52">
                                            </b-form-radio-group>
                                        </b-form-group>
                    </b-card></b-card><b-card-text class="my-1">LEGISLATION [<em>0..n</em>]</b-card-text>
                    <b-card class="my-1"> <p>Cardinality [<em>1</em>]</p>
                                        <b-form-group label="QUESTION - Your answer [1]">
                                            <b-form-radio-group id="radio-group-53" v-model="selected53" :options="options" name="radio-options53">
                                            </b-form-radio-group>
                                        </b-form-group>
                                    <div v-if="selected53 ==='yes'">
                                    <b-card class="my-1"> <p>Cardinality [<em>0..1</em>]</p>
                                            <b-form-group label="QUESTION - Please describe them [1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="DESCRIPTION"></b-form-input>
                                            </b-form-group>
                                            <b-form-group label="QUESTION - Indicate reasons for being nevertheless to perform the contract [1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="DESCRIPTION"></b-form-input>
                                            </b-form-group>
                                    </b-card>
                                    </div>
                    </b-card>
                    <b-card class="my-1"> <p>Cardinality [<em>1</em>]</p>
                                        <b-form-group label="QUESTION - Is this information available electronically? [1]">
                                            <b-form-radio-group id="radio-group-54" v-model="selected54" :options="options" name="radio-options54">
                                            </b-form-radio-group>
                                        </b-form-group>
                                    <div v-if="selected54 ==='yes'">
                                    <b-card class="my-1"> <p>Cardinality [<em>0..1</em>]</p>
                                            <b-form-group label="QUESTION - Evidence Supplied [1..n]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="EVIDENCE_IDENTIFIER"></b-form-input>
                                            </b-form-group>
                                    </b-card>
                                    </div>
                    </b-card></b-card>
                    </div>`
                    })

/**
 * Component - C14 - EG - Arrangement with creditors
 */
Vue.component("C14 - EG",
                    { 
                        data(){
                            return {
 "options": [
  {
   "text": "Yes",
   "value": "yes"
  },
  {
   "text": "No",
   "value": "no"
  }
 ],
 "selected55": "yes",
 "selected56": "yes",
 "selected57": "yes"
}
                        },
                        template: `<div>
                        <b-card title="C14 - EG - Arrangement with creditors">
                            <b-card-text>Is the economic operator in arrangement with creditors? This information needs not be given if exclusion of economic operators in this case has been made mandatory under the applicable national law without any possibility of derogation where the economic operator is nevertheless able to perform the contract.</b-card-text>
                        <b-card><p>[Name of the National Criterion] <em>[Description of the National Criterion ]</em> [<em>0..n</em>]</p>
                    <b-card class="my-1"> <p>Cardinality [<em>1</em>]</p><b-card-text>CAPTION - [Additional information; e.g. no evidences online]</b-card-text>
                                        <b-form-group label="QUESTION - Your Answer [1]">
                                            <b-form-radio-group id="radio-group-55" v-model="selected55" :options="options" name="radio-options55">
                                            </b-form-radio-group>
                                        </b-form-group>
                    </b-card></b-card><b-card-text class="my-1">LEGISLATION [<em>0..n</em>]</b-card-text>
                    <b-card class="my-1"> <p>Cardinality [<em>1</em>]</p>
                                        <b-form-group label="QUESTION - Your answer [1]">
                                            <b-form-radio-group id="radio-group-56" v-model="selected56" :options="options" name="radio-options56">
                                            </b-form-radio-group>
                                        </b-form-group>
                                    <div v-if="selected56 ==='yes'">
                                    <b-card class="my-1"> <p>Cardinality [<em>0..1</em>]</p>
                                            <b-form-group label="QUESTION - Please describe them [1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="DESCRIPTION"></b-form-input>
                                            </b-form-group>
                                            <b-form-group label="QUESTION - Indicate reasons for being nevertheless to perform the contract [1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="DESCRIPTION"></b-form-input>
                                            </b-form-group>
                                    </b-card>
                                    </div>
                    </b-card>
                    <b-card class="my-1"> <p>Cardinality [<em>1</em>]</p>
                                        <b-form-group label="QUESTION - Is this information available electronically? [1]">
                                            <b-form-radio-group id="radio-group-57" v-model="selected57" :options="options" name="radio-options57">
                                            </b-form-radio-group>
                                        </b-form-group>
                                    <div v-if="selected57 ==='yes'">
                                    <b-card class="my-1"> <p>Cardinality [<em>0..1</em>]</p>
                                            <b-form-group label="QUESTION - Evidence Supplied [1..n]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="EVIDENCE_IDENTIFIER"></b-form-input>
                                            </b-form-group>
                                    </b-card>
                                    </div>
                    </b-card></b-card>
                    </div>`
                    })

/**
 * Component - C15 - EG - Analogous situation like bankruptcy under national law
 */
Vue.component("C15 - EG",
                    { 
                        data(){
                            return {
 "options": [
  {
   "text": "Yes",
   "value": "yes"
  },
  {
   "text": "No",
   "value": "no"
  }
 ],
 "selected58": "yes",
 "selected59": "yes",
 "selected60": "yes"
}
                        },
                        template: `<div>
                        <b-card title="C15 - EG - Analogous situation like bankruptcy under national law">
                            <b-card-text>Is the economic operator in any analogous situation like bankruptcy arising from a similar procedure under national laws and regulations? This information needs not be given if exclusion of economic operators in this case has been made mandatory under the applicable national law without any possibility of derogation where the economic operator is nevertheless able to perform the contract.</b-card-text>
                        <b-card><p>[Name of the National Criterion] <em>[Description of the National Criterion ]</em> [<em>0..n</em>]</p>
                    <b-card class="my-1"> <p>Cardinality [<em>1</em>]</p><b-card-text>CAPTION - [Additional information; e.g. no evidences online]</b-card-text>
                                        <b-form-group label="QUESTION - Your Answer [1]">
                                            <b-form-radio-group id="radio-group-58" v-model="selected58" :options="options" name="radio-options58">
                                            </b-form-radio-group>
                                        </b-form-group>
                    </b-card></b-card><b-card-text class="my-1">LEGISLATION [<em>0..n</em>]</b-card-text>
                    <b-card class="my-1"> <p>Cardinality [<em>1</em>]</p>
                                        <b-form-group label="QUESTION - Your answer [1]">
                                            <b-form-radio-group id="radio-group-59" v-model="selected59" :options="options" name="radio-options59">
                                            </b-form-radio-group>
                                        </b-form-group>
                                    <div v-if="selected59 ==='yes'">
                                    <b-card class="my-1"> <p>Cardinality [<em>0..1</em>]</p>
                                            <b-form-group label="QUESTION - Please describe them [1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="DESCRIPTION"></b-form-input>
                                            </b-form-group>
                                            <b-form-group label="QUESTION - Indicate reasons for being nevertheless to perform the contract [1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="DESCRIPTION"></b-form-input>
                                            </b-form-group>
                                    </b-card>
                                    </div>
                    </b-card>
                    <b-card class="my-1"> <p>Cardinality [<em>1</em>]</p>
                                        <b-form-group label="QUESTION - Is this information available electronically? [1]">
                                            <b-form-radio-group id="radio-group-60" v-model="selected60" :options="options" name="radio-options60">
                                            </b-form-radio-group>
                                        </b-form-group>
                                    <div v-if="selected60 ==='yes'">
                                    <b-card class="my-1"> <p>Cardinality [<em>0..1</em>]</p>
                                            <b-form-group label="QUESTION - Evidence Supplied [1..n]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="EVIDENCE_IDENTIFIER"></b-form-input>
                                            </b-form-group>
                                    </b-card>
                                    </div>
                    </b-card></b-card>
                    </div>`
                    })

/**
 * Component - C16 - EG - Assets being administered by liquidator
 */
Vue.component("C16 - EG",
                    { 
                        data(){
                            return {
 "options": [
  {
   "text": "Yes",
   "value": "yes"
  },
  {
   "text": "No",
   "value": "no"
  }
 ],
 "selected61": "yes",
 "selected62": "yes",
 "selected63": "yes"
}
                        },
                        template: `<div>
                        <b-card title="C16 - EG - Assets being administered by liquidator">
                            <b-card-text>Are the assets of the economic operator being administered by a liquidator or by the court? This information needs not be given if exclusion of economic operators in this case has been made mandatory under the applicable national law without any possibility of derogation where the economic operator is nevertheless able to perform the contract.</b-card-text>
                        <b-card><p>[Name of the National Criterion] <em>[Description of the National Criterion ]</em> [<em>0..n</em>]</p>
                    <b-card class="my-1"> <p>Cardinality [<em>1</em>]</p><b-card-text>CAPTION - [Additional information; e.g. no evidences online]</b-card-text>
                                        <b-form-group label="QUESTION - Your Answer [1]">
                                            <b-form-radio-group id="radio-group-61" v-model="selected61" :options="options" name="radio-options61">
                                            </b-form-radio-group>
                                        </b-form-group>
                    </b-card></b-card><b-card-text class="my-1">LEGISLATION [<em>0..n</em>]</b-card-text>
                    <b-card class="my-1"> <p>Cardinality [<em>1</em>]</p>
                                        <b-form-group label="QUESTION - Your answer [1]">
                                            <b-form-radio-group id="radio-group-62" v-model="selected62" :options="options" name="radio-options62">
                                            </b-form-radio-group>
                                        </b-form-group>
                                    <div v-if="selected62 ==='yes'">
                                    <b-card class="my-1"> <p>Cardinality [<em>0..1</em>]</p>
                                            <b-form-group label="QUESTION - Please describe them [1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="DESCRIPTION"></b-form-input>
                                            </b-form-group>
                                            <b-form-group label="QUESTION - Indicate reasons for being nevertheless to perform the contract [1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="DESCRIPTION"></b-form-input>
                                            </b-form-group>
                                    </b-card>
                                    </div>
                    </b-card>
                    <b-card class="my-1"> <p>Cardinality [<em>1</em>]</p>
                                        <b-form-group label="QUESTION - Is this information available electronically? [1]">
                                            <b-form-radio-group id="radio-group-63" v-model="selected63" :options="options" name="radio-options63">
                                            </b-form-radio-group>
                                        </b-form-group>
                                    <div v-if="selected63 ==='yes'">
                                    <b-card class="my-1"> <p>Cardinality [<em>0..1</em>]</p>
                                            <b-form-group label="QUESTION - Evidence Supplied [1..n]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="EVIDENCE_IDENTIFIER"></b-form-input>
                                            </b-form-group>
                                    </b-card>
                                    </div>
                    </b-card></b-card>
                    </div>`
                    })

/**
 * Component - C17 - EG - Business activities are suspended
 */
Vue.component("C17 - EG",
                    { 
                        data(){
                            return {
 "options": [
  {
   "text": "Yes",
   "value": "yes"
  },
  {
   "text": "No",
   "value": "no"
  }
 ],
 "selected64": "yes",
 "selected65": "yes",
 "selected66": "yes"
}
                        },
                        template: `<div>
                        <b-card title="C17 - EG - Business activities are suspended">
                            <b-card-text>Are the business activities of the economic operator suspended? This information needs not be given if exclusion of economic operators in this case has been made mandatory under the applicable national law without any possibility of derogation where the economic operator is nevertheless able to perform the contract.</b-card-text>
                        <b-card><p>[Name of the National Criterion] <em>[Description of the National Criterion ]</em> [<em>0..n</em>]</p>
                    <b-card class="my-1"> <p>Cardinality [<em>1</em>]</p><b-card-text>CAPTION - [Additional information; e.g. no evidences online]</b-card-text>
                                        <b-form-group label="QUESTION - Your Answer [1]">
                                            <b-form-radio-group id="radio-group-64" v-model="selected64" :options="options" name="radio-options64">
                                            </b-form-radio-group>
                                        </b-form-group>
                    </b-card></b-card><b-card-text class="my-1">LEGISLATION [<em>0..n</em>]</b-card-text>
                    <b-card class="my-1"> <p>Cardinality [<em>1</em>]</p>
                                        <b-form-group label="QUESTION - Your answer [1]">
                                            <b-form-radio-group id="radio-group-65" v-model="selected65" :options="options" name="radio-options65">
                                            </b-form-radio-group>
                                        </b-form-group>
                                    <div v-if="selected65 ==='yes'">
                                    <b-card class="my-1"> <p>Cardinality [<em>0..1</em>]</p>
                                            <b-form-group label="QUESTION - Please describe them [1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="DESCRIPTION"></b-form-input>
                                            </b-form-group>
                                            <b-form-group label="QUESTION - Indicate reasons for being nevertheless to perform the contract [1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="DESCRIPTION"></b-form-input>
                                            </b-form-group>
                                    </b-card>
                                    </div>
                    </b-card>
                    <b-card class="my-1"> <p>Cardinality [<em>1</em>]</p>
                                        <b-form-group label="QUESTION - Is this information available electronically? [1]">
                                            <b-form-radio-group id="radio-group-66" v-model="selected66" :options="options" name="radio-options66">
                                            </b-form-radio-group>
                                        </b-form-group>
                                    <div v-if="selected66 ==='yes'">
                                    <b-card class="my-1"> <p>Cardinality [<em>0..1</em>]</p>
                                            <b-form-group label="QUESTION - Evidence Supplied [1..n]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="EVIDENCE_IDENTIFIER"></b-form-input>
                                            </b-form-group>
                                    </b-card>
                                    </div>
                    </b-card></b-card>
                    </div>`
                    })

/**
 * Component - C18 - EG - Guilty of grave professional misconduct
 */
Vue.component("C18 - EG",
                    { 
                        data(){
                            return {
 "options": [
  {
   "text": "Yes",
   "value": "yes"
  },
  {
   "text": "No",
   "value": "no"
  }
 ],
 "selected67": "yes",
 "selected68": "yes",
 "selected69": "yes",
 "selected70": "yes"
}
                        },
                        template: `<div>
                        <b-card title="C18 - EG - Guilty of grave professional misconduct">
                            <b-card-text>Is the economic operator guilty of grave professional misconduct? Where applicable, see definitions in national law, the relevant notice or the procurement documents.</b-card-text>
                        <b-card><p>[Name of the National Criterion] <em>[Description of the National Criterion ]</em> [<em>0..n</em>]</p>
                    <b-card class="my-1"> <p>Cardinality [<em>1</em>]</p><b-card-text>CAPTION - [Additional information; e.g. no evidences online]</b-card-text>
                                        <b-form-group label="QUESTION - Your Answer [1]">
                                            <b-form-radio-group id="radio-group-67" v-model="selected67" :options="options" name="radio-options67">
                                            </b-form-radio-group>
                                        </b-form-group>
                    </b-card></b-card><b-card-text class="my-1">LEGISLATION [<em>0..n</em>]</b-card-text>
                    <b-card class="my-1"> <p>Cardinality [<em>1</em>]</p>
                                        <b-form-group label="QUESTION - Your answer [1]">
                                            <b-form-radio-group id="radio-group-68" v-model="selected68" :options="options" name="radio-options68">
                                            </b-form-radio-group>
                                        </b-form-group>
                                    <div v-if="selected68 ==='yes'">
                                    <b-card class="my-1"> <p>Cardinality [<em>0..1</em>]</p>
                                            <b-form-group label="QUESTION - Please describe them [1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="DESCRIPTION"></b-form-input>
                                            </b-form-group><b-card class="my-1"> <p>Cardinality [<em>1</em>]</p>
                                            <b-form-group label="QUESTION - Have you taken measures to demonstrate your reliability [1]">
                                                <b-form-radio-group id="radio-group-69" v-model="selected69" :options="options" name="radio-options69">
                                                </b-form-radio-group>
                                            </b-form-group>
                                        <div v-if="selected69 ==='yes'">
                                        <b-card class="my-1"> <p>Cardinality [<em>1</em>]</p>
                                            <b-form-group label="QUESTION - Please describe them [1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="DESCRIPTION"></b-form-input>
                                            </b-form-group>
                                        </b-card>
                                        </div></b-card>
                                    </b-card>
                                    </div>
                    </b-card>
                    <b-card class="my-1"> <p>Cardinality [<em>1</em>]</p>
                                        <b-form-group label="QUESTION - Is this information available electronically? [1]">
                                            <b-form-radio-group id="radio-group-70" v-model="selected70" :options="options" name="radio-options70">
                                            </b-form-radio-group>
                                        </b-form-group>
                                    <div v-if="selected70 ==='yes'">
                                    <b-card class="my-1"> <p>Cardinality [<em>0..1</em>]</p>
                                            <b-form-group label="QUESTION - Evidence Supplied [1..n]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="EVIDENCE_IDENTIFIER"></b-form-input>
                                            </b-form-group>
                                    </b-card>
                                    </div>
                    </b-card></b-card>
                    </div>`
                    })

/**
 * Component - C19 - EG - Agreements with other economic operators aimed at distorting competition
 */
Vue.component("C19 - EG",
                    { 
                        data(){
                            return {
 "options": [
  {
   "text": "Yes",
   "value": "yes"
  },
  {
   "text": "No",
   "value": "no"
  }
 ],
 "selected71": "yes",
 "selected72": "yes",
 "selected73": "yes",
 "selected74": "yes"
}
                        },
                        template: `<div>
                        <b-card title="C19 - EG - Agreements with other economic operators aimed at distorting competition">
                            <b-card-text>Has the economic operator entered into agreements with other economic operators aimed at distorting competition?</b-card-text>
                        <b-card><p>[Name of the National Criterion] <em>[Description of the National Criterion ]</em> [<em>0..n</em>]</p>
                    <b-card class="my-1"> <p>Cardinality [<em>1</em>]</p><b-card-text>CAPTION - [Additional information; e.g. no evidences online]</b-card-text>
                                        <b-form-group label="QUESTION - Your Answer [1]">
                                            <b-form-radio-group id="radio-group-71" v-model="selected71" :options="options" name="radio-options71">
                                            </b-form-radio-group>
                                        </b-form-group>
                    </b-card></b-card><b-card-text class="my-1">LEGISLATION [<em>0..n</em>]</b-card-text>
                    <b-card class="my-1"> <p>Cardinality [<em>1</em>]</p>
                                        <b-form-group label="QUESTION - Your answer [1]">
                                            <b-form-radio-group id="radio-group-72" v-model="selected72" :options="options" name="radio-options72">
                                            </b-form-radio-group>
                                        </b-form-group>
                                    <div v-if="selected72 ==='yes'">
                                    <b-card class="my-1"> <p>Cardinality [<em>0..1</em>]</p>
                                            <b-form-group label="QUESTION - Please describe them [1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="DESCRIPTION"></b-form-input>
                                            </b-form-group><b-card class="my-1"> <p>Cardinality [<em>1</em>]</p>
                                            <b-form-group label="QUESTION - Have you taken measures to demonstrate your reliability [1]">
                                                <b-form-radio-group id="radio-group-73" v-model="selected73" :options="options" name="radio-options73">
                                                </b-form-radio-group>
                                            </b-form-group>
                                        <div v-if="selected73 ==='yes'">
                                        <b-card class="my-1"> <p>Cardinality [<em>1</em>]</p>
                                            <b-form-group label="QUESTION - Please describe them [1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="DESCRIPTION"></b-form-input>
                                            </b-form-group>
                                        </b-card>
                                        </div></b-card>
                                    </b-card>
                                    </div>
                    </b-card>
                    <b-card class="my-1"> <p>Cardinality [<em>1</em>]</p>
                                        <b-form-group label="QUESTION - Is this information available electronically? [1]">
                                            <b-form-radio-group id="radio-group-74" v-model="selected74" :options="options" name="radio-options74">
                                            </b-form-radio-group>
                                        </b-form-group>
                                    <div v-if="selected74 ==='yes'">
                                    <b-card class="my-1"> <p>Cardinality [<em>0..1</em>]</p>
                                            <b-form-group label="QUESTION - Evidence Supplied [1..n]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="EVIDENCE_IDENTIFIER"></b-form-input>
                                            </b-form-group>
                                    </b-card>
                                    </div>
                    </b-card></b-card>
                    </div>`
                    })

/**
 * Component - C20 - EG - Conflict of interest due to its participation in the procurement procedure
 */
Vue.component("C20 - EG",
                    { 
                        data(){
                            return {
 "options": [
  {
   "text": "Yes",
   "value": "yes"
  },
  {
   "text": "No",
   "value": "no"
  }
 ],
 "selected75": "yes",
 "selected76": "yes",
 "selected77": "yes"
}
                        },
                        template: `<div>
                        <b-card title="C20 - EG - Conflict of interest due to its participation in the procurement procedure">
                            <b-card-text>Is the economic operator aware of any conflict of interest, as indicated in national law, the relevant notice or in the ESPD, the relevant notice or due to its participation in the procurement procedure?</b-card-text>
                        <b-card><p>[Name of the National Criterion] <em>[Description of the National Criterion ]</em> [<em>0..n</em>]</p>
                    <b-card class="my-1"> <p>Cardinality [<em>1</em>]</p><b-card-text>CAPTION - [Additional information; e.g. no evidences online]</b-card-text>
                                        <b-form-group label="QUESTION - Your Answer [1]">
                                            <b-form-radio-group id="radio-group-75" v-model="selected75" :options="options" name="radio-options75">
                                            </b-form-radio-group>
                                        </b-form-group>
                    </b-card></b-card><b-card-text class="my-1">LEGISLATION [<em>0..n</em>]</b-card-text>
                    <b-card class="my-1"> <p>Cardinality [<em>1</em>]</p>
                                        <b-form-group label="QUESTION - Your answer [1]">
                                            <b-form-radio-group id="radio-group-76" v-model="selected76" :options="options" name="radio-options76">
                                            </b-form-radio-group>
                                        </b-form-group>
                                    <div v-if="selected76 ==='yes'">
                                    <b-card class="my-1"> <p>Cardinality [<em>0..1</em>]</p>
                                            <b-form-group label="QUESTION - Please describe them [1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="DESCRIPTION"></b-form-input>
                                            </b-form-group>
                                    </b-card>
                                    </div>
                    </b-card>
                    <b-card class="my-1"> <p>Cardinality [<em>1</em>]</p>
                                        <b-form-group label="QUESTION - Is this information available electronically? [1]">
                                            <b-form-radio-group id="radio-group-77" v-model="selected77" :options="options" name="radio-options77">
                                            </b-form-radio-group>
                                        </b-form-group>
                                    <div v-if="selected77 ==='yes'">
                                    <b-card class="my-1"> <p>Cardinality [<em>0..1</em>]</p>
                                            <b-form-group label="QUESTION - Evidence Supplied [1..n]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="EVIDENCE_IDENTIFIER"></b-form-input>
                                            </b-form-group>
                                    </b-card>
                                    </div>
                    </b-card></b-card>
                    </div>`
                    })

/**
 * Component - C21 - EG - Direct or indirect involvement in the preparation of this procurement procedure
 */
Vue.component("C21 - EG",
                    { 
                        data(){
                            return {
 "options": [
  {
   "text": "Yes",
   "value": "yes"
  },
  {
   "text": "No",
   "value": "no"
  }
 ],
 "selected78": "yes",
 "selected79": "yes",
 "selected80": "yes"
}
                        },
                        template: `<div>
                        <b-card title="C21 - EG - Direct or indirect involvement in the preparation of this procurement procedure">
                            <b-card-text>Has the economic operator or an undertaking related to it advised the contracting authority or contracting entity or otherwise been involved in the preparation of the procurement procedure?</b-card-text>
                        <b-card><p>[Name of the National Criterion] <em>[Description of the National Criterion ]</em> [<em>0..n</em>]</p>
                    <b-card class="my-1"> <p>Cardinality [<em>1</em>]</p><b-card-text>CAPTION - [Additional information; e.g. no evidences online]</b-card-text>
                                        <b-form-group label="QUESTION - Your Answer [1]">
                                            <b-form-radio-group id="radio-group-78" v-model="selected78" :options="options" name="radio-options78">
                                            </b-form-radio-group>
                                        </b-form-group>
                    </b-card></b-card><b-card-text class="my-1">LEGISLATION [<em>0..n</em>]</b-card-text>
                    <b-card class="my-1"> <p>Cardinality [<em>1</em>]</p>
                                        <b-form-group label="QUESTION - Your answer [1]">
                                            <b-form-radio-group id="radio-group-79" v-model="selected79" :options="options" name="radio-options79">
                                            </b-form-radio-group>
                                        </b-form-group>
                                    <div v-if="selected79 ==='yes'">
                                    <b-card class="my-1"> <p>Cardinality [<em>0..1</em>]</p>
                                            <b-form-group label="QUESTION - Please describe them [1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="DESCRIPTION"></b-form-input>
                                            </b-form-group>
                                    </b-card>
                                    </div>
                    </b-card>
                    <b-card class="my-1"> <p>Cardinality [<em>1</em>]</p>
                                        <b-form-group label="QUESTION - Is this information available electronically? [1]">
                                            <b-form-radio-group id="radio-group-80" v-model="selected80" :options="options" name="radio-options80">
                                            </b-form-radio-group>
                                        </b-form-group>
                                    <div v-if="selected80 ==='yes'">
                                    <b-card class="my-1"> <p>Cardinality [<em>0..1</em>]</p>
                                            <b-form-group label="QUESTION - Evidence Supplied [1..n]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="EVIDENCE_IDENTIFIER"></b-form-input>
                                            </b-form-group>
                                    </b-card>
                                    </div>
                    </b-card></b-card>
                    </div>`
                    })

/**
 * Component - C22 - EG - Early termination, damages or other comparable sanctions
 */
Vue.component("C22 - EG",
                    { 
                        data(){
                            return {
 "options": [
  {
   "text": "Yes",
   "value": "yes"
  },
  {
   "text": "No",
   "value": "no"
  }
 ],
 "selected81": "yes",
 "selected82": "yes",
 "selected83": "yes",
 "selected84": "yes"
}
                        },
                        template: `<div>
                        <b-card title="C22 - EG - Early termination, damages or other comparable sanctions">
                            <b-card-text>Has the economic operator experienced that a prior public contract, a prior contract with a contracting entity or a prior concession contract was terminated early, or that damages or other comparable sanctions were imposed in connection with that prior contract?</b-card-text>
                        <b-card><p>[Name of the National Criterion] <em>[Description of the National Criterion ]</em> [<em>0..n</em>]</p>
                    <b-card class="my-1"> <p>Cardinality [<em>1</em>]</p><b-card-text>CAPTION - [Additional information; e.g. no evidences online]</b-card-text>
                                        <b-form-group label="QUESTION - Your Answer [1]">
                                            <b-form-radio-group id="radio-group-81" v-model="selected81" :options="options" name="radio-options81">
                                            </b-form-radio-group>
                                        </b-form-group>
                    </b-card></b-card><b-card-text class="my-1">LEGISLATION [<em>0..n</em>]</b-card-text>
                    <b-card class="my-1"> <p>Cardinality [<em>1</em>]</p>
                                        <b-form-group label="QUESTION - Your answer [1]">
                                            <b-form-radio-group id="radio-group-82" v-model="selected82" :options="options" name="radio-options82">
                                            </b-form-radio-group>
                                        </b-form-group>
                                    <div v-if="selected82 ==='yes'">
                                    <b-card class="my-1"> <p>Cardinality [<em>0..1</em>]</p>
                                            <b-form-group label="QUESTION - Please describe them [1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="DESCRIPTION"></b-form-input>
                                            </b-form-group><b-card class="my-1"> <p>Cardinality [<em>0..1</em>]</p>
                                            <b-form-group label="QUESTION - Have you taken measures to demonstrate your reliability (Self-Cleaning)? [1]">
                                                <b-form-radio-group id="radio-group-83" v-model="selected83" :options="options" name="radio-options83">
                                                </b-form-radio-group>
                                            </b-form-group>
                                        <div v-if="selected83 ==='yes'">
                                        <b-card class="my-1"> <p>Cardinality [<em>0..1</em>]</p>
                                            <b-form-group label="QUESTION - Please describe them [1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="DESCRIPTION"></b-form-input>
                                            </b-form-group>
                                        </b-card>
                                        </div></b-card>
                                    </b-card>
                                    </div>
                    </b-card>
                    <b-card class="my-1"> <p>Cardinality [<em>1</em>]</p>
                                        <b-form-group label="QUESTION - Is this information available electronically? [1]">
                                            <b-form-radio-group id="radio-group-84" v-model="selected84" :options="options" name="radio-options84">
                                            </b-form-radio-group>
                                        </b-form-group>
                                    <div v-if="selected84 ==='yes'">
                                    <b-card class="my-1"> <p>Cardinality [<em>0..1</em>]</p>
                                            <b-form-group label="QUESTION - Evidence Supplied [1..n]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="EVIDENCE_IDENTIFIER"></b-form-input>
                                            </b-form-group>
                                    </b-card>
                                    </div>
                    </b-card></b-card>
                    </div>`
                    })

/**
 * Component - C23 - EG - Guilty of misrepresentation, withheld information, unable to provide required documents and obtained confidential information of this procedure
 */
Vue.component("C23 - EG",
                    { 
                        data(){
                            return {
 "options": [
  {
   "text": "Yes",
   "value": "yes"
  },
  {
   "text": "No",
   "value": "no"
  }
 ],
 "selected85": "yes",
 "selected86": "yes",
 "selected87": "yes"
}
                        },
                        template: `<div>
                        <b-card title="C23 - EG - Guilty of misrepresentation, withheld information, unable to provide required documents and obtained confidential information of this procedure">
                            <b-card-text>Can the economic operator confirm that:</b-card-text>
                        <b-card-text>ADDITIONAL_DESCRIPTION_LINE - a) It has been guilty of serious misrepresentation in supplying the information required for the verification of the absence of grounds for exclusion or the fulfilment of the selection criteria,</b-card-text><b-card-text>ADDITIONAL_DESCRIPTION_LINE - b) It has withheld such information,</b-card-text><b-card-text>ADDITIONAL_DESCRIPTION_LINE - c) It has not been able, without delay, to submit the supporting documents required by a contracting authority or contracting entity, and</b-card-text><b-card-text>ADDITIONAL_DESCRIPTION_LINE - d) It has undertaken to unduly influence the decision making process of the contracting authority or contracting entity, to obtain confidential information that may confer upon it undue advantages in the procurement procedure or to negligently provide misleading information that may have a material influence on decisions concerning exclusion, selection or award?</b-card-text><b-card><p>[Name of the National Criterion] <em>[Description of the National Criterion ]</em> [<em>0..n</em>]</p>
                    <b-card class="my-1"> <p>Cardinality [<em>1</em>]</p><b-card-text>CAPTION - [Additional information; e.g. no evidences online]</b-card-text>
                                        <b-form-group label="QUESTION - Your Answer [1]">
                                            <b-form-radio-group id="radio-group-85" v-model="selected85" :options="options" name="radio-options85">
                                            </b-form-radio-group>
                                        </b-form-group>
                    </b-card></b-card><b-card-text class="my-1">LEGISLATION [<em>0..n</em>]</b-card-text>
                    <b-card class="my-1"> <p>Cardinality [<em>1</em>]</p>
                                        <b-form-group label="QUESTION - Your answer [1]">
                                            <b-form-radio-group id="radio-group-86" v-model="selected86" :options="options" name="radio-options86">
                                            </b-form-radio-group>
                                        </b-form-group>
                    </b-card>
                    <b-card class="my-1"> <p>Cardinality [<em>1</em>]</p>
                                        <b-form-group label="QUESTION - Is this information available electronically? [1]">
                                            <b-form-radio-group id="radio-group-87" v-model="selected87" :options="options" name="radio-options87">
                                            </b-form-radio-group>
                                        </b-form-group>
                                    <div v-if="selected87 ==='yes'">
                                    <b-card class="my-1"> <p>Cardinality [<em>0..1</em>]</p>
                                            <b-form-group label="QUESTION - Evidence Supplied [1..n]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="EVIDENCE_IDENTIFIER"></b-form-input>
                                            </b-form-group>
                                    </b-card>
                                    </div>
                    </b-card></b-card>
                    </div>`
                    })

/**
 * Component - C24 - EG - Purely national exclusion grounds
 */
Vue.component("C24 - EG",
                    { 
                        data(){
                            return {
 "options": [
  {
   "text": "Yes",
   "value": "yes"
  },
  {
   "text": "No",
   "value": "no"
  }
 ],
 "selected88": "yes",
 "selected89": "yes"
}
                        },
                        template: `<div>
                        <b-card title="C24 - EG - Purely national exclusion grounds">
                            <b-card-text>Other exclusion grounds that may be foreseen in the national legislation of the contracting authority's or contracting entity's Member State. Has the economic operator breached its obligations relating to the purely national grounds of exclusion, which are specified in the relevant notice or in the procurement documents?</b-card-text>
                        <b-card-text class="my-1">LEGISLATION [<em>0..n</em>]</b-card-text>
                    <b-card class="my-1"> <p>Cardinality [<em>1</em>]</p><b-card-text>CAPTION - undefined</b-card-text><b-card class="my-1"> <p>Cardinality [<em>1..n</em>]</p><b-card-text>CAPTION - [Text describing the national criterion]</b-card-text><b-card-text>CAPTION - [Type of evidence from e-Certis]</b-card-text>
                                            <b-form-group label="QUESTION - Your answer? [1]">
                                                <b-form-radio-group id="radio-group-88" v-model="selected88" :options="options" name="radio-options88">
                                                </b-form-radio-group>
                                            </b-form-group></b-card>
                    </b-card>
                    <b-card class="my-1"> <p>Cardinality [<em>1</em>]</p>
                                        <b-form-group label="QUESTION - Is this information available electronically? [1]">
                                            <b-form-radio-group id="radio-group-89" v-model="selected89" :options="options" name="radio-options89">
                                            </b-form-radio-group>
                                        </b-form-group>
                                    <div v-if="selected89 ==='yes'">
                                    <b-card class="my-1"> <p>Cardinality [<em>0..1</em>]</p>
                                            <b-form-group label="QUESTION - Evidence Supplied [1..n]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="EVIDENCE_IDENTIFIER"></b-form-input>
                                            </b-form-group>
                                    </b-card>
                                    </div>
                    </b-card></b-card>
                    </div>`
                    })

/**
 * Component - C25 - SC - Enrolment in a relevant professional register
 */
Vue.component("C25 - SC",
                    { 
                        data(){
                            return {
 "options": [
  {
   "text": "Yes",
   "value": "yes"
  },
  {
   "text": "No",
   "value": "no"
  }
 ],
 "selected90": "yes",
 "selected91": "yes",
 "selected92": "yes",
 "selected93": "yes",
 "selected94": "yes"
}
                        },
                        template: `<div>
                        <b-card title="C25 - SC - Enrolment in a relevant professional register">
                            <b-card-text>It is enrolled in relevant professional registers kept in the Member State of its establishment as described in Annex XI of Directive 2014/24/EU; economic operators from certain Member States may have to comply with other requirements set out in that Annex.</b-card-text>
                        <b-card><p>[Name of the National Criterion] <em>[Description of the National Criterion ]</em> [<em>0..n</em>]</p>
                    <b-card class="my-1"> <p>Cardinality [<em>1</em>]</p><b-card-text>CAPTION - [Additional information; e.g. no evidences online]</b-card-text>
                                        <b-form-group label="QUESTION - Your Answer [1]">
                                            <b-form-radio-group id="radio-group-90" v-model="selected90" :options="options" name="radio-options90">
                                            </b-form-radio-group>
                                        </b-form-group>
                    </b-card></b-card><b-card-text class="my-1">LEGISLATION [<em>0..n</em>]</b-card-text><b-card>
                    <b-form-group label="REQUIREMENT - occupation [1]"
                    label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                    <b-form-input placeholder="CODE"></b-form-input>
                    </b-form-group>
                    
                                            <b-form-group label="QUESTION - Does the EO fulfil the criteria by itself? [1]">
                                                <b-form-radio-group id="radio-group-91" v-model="selected91" :options="options" name="radio-options91">
                                                </b-form-radio-group>
                                            </b-form-group>
                                        <div v-if="selected91 ==='no'">
                                        <b-card class="my-1"> <p>Cardinality [<em>1</em>]</p>
                                            <b-form-group label="QUESTION - In the case of no – Relied upon or not [1]">
                                                <b-form-radio-group id="radio-group-92" v-model="selected92" :options="options" name="radio-options92">
                                                </b-form-radio-group>
                                            </b-form-group>
                                        <div v-if="selected92 ==='yes'">
                                        <b-card class="my-1"> <p>Cardinality [<em>1</em>]</p>
                                            <b-form-group label="QUESTION - Name of the entity [1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="DESCRIPTION"></b-form-input>
                                            </b-form-group>
                                            <b-form-group label="QUESTION - ID of the entity [1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="ECONOMIC_OPERATOR_IDENTIFIER"></b-form-input>
                                            </b-form-group>
                                        </b-card>
                                        </div>
                                        </b-card>
                                        </div>
                                            <b-form-group label="QUESTION - Your Answer [1]">
                                                <b-form-radio-group id="radio-group-93" v-model="selected93" :options="options" name="radio-options93">
                                                </b-form-radio-group>
                                            </b-form-group>
                                        <div v-if="selected93 ==='yes'">
                                        <b-card class="my-1"> <p>Cardinality [<em>0..1</em>]</p>
                                            <b-form-group label="QUESTION - Registration number [0..1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="DESCRIPTION"></b-form-input>
                                            </b-form-group>
                                        </b-card>
                                        </div>
                                        <div v-if="selected93 ==='no'">
                                        <b-card class="my-1"> <p>Cardinality [<em>0..1</em>]</p>
                                            <b-form-group label="QUESTION - Reasons why your are not registered [1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="DESCRIPTION"></b-form-input>
                                            </b-form-group>
                                        </b-card>
                                        </div><b-card class="my-1"> <p>Cardinality [<em>1</em>]</p>
                                            <b-form-group label="QUESTION - Is this information available electronically? [1]">
                                                <b-form-radio-group id="radio-group-94" v-model="selected94" :options="options" name="radio-options94">
                                                </b-form-radio-group>
                                            </b-form-group>
                                        <div v-if="selected94 ==='yes'">
                                        <b-card class="my-1"> <p>Cardinality [<em>0..1</em>]</p>
                                            <b-form-group label="QUESTION - Evidence Supplied [1..n]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="EVIDENCE_IDENTIFIER"></b-form-input>
                                            </b-form-group>
                                        </b-card>
                                        </div></b-card></b-card></b-card>
                    </div>`
                    })

/**
 * Component - C26 - SC - Enrolment in a trade register
 */
Vue.component("C26 - SC",
                    { 
                        data(){
                            return {
 "options": [
  {
   "text": "Yes",
   "value": "yes"
  },
  {
   "text": "No",
   "value": "no"
  }
 ],
 "selected95": "yes",
 "selected96": "yes",
 "selected97": "yes",
 "selected98": "yes",
 "selected99": "yes"
}
                        },
                        template: `<div>
                        <b-card title="C26 - SC - Enrolment in a trade register">
                            <b-card-text>It is enrolled in trade registers kept in the Member State of its establishment as described in Annex XI of Directive 2014/24/EU; economic operators from certain Member States may have to comply with other requirements set out in that Annex.</b-card-text>
                        <b-card><p>[Name of the National Criterion] <em>[Description of the National Criterion ]</em> [<em>0..n</em>]</p>
                    <b-card class="my-1"> <p>Cardinality [<em>1</em>]</p><b-card-text>CAPTION - [Additional information; e.g. no evidences online]</b-card-text>
                                        <b-form-group label="QUESTION - Your Answer [1]">
                                            <b-form-radio-group id="radio-group-95" v-model="selected95" :options="options" name="radio-options95">
                                            </b-form-radio-group>
                                        </b-form-group>
                    </b-card></b-card><b-card-text class="my-1">LEGISLATION [<em>0..n</em>]</b-card-text><b-card>
                    <b-form-group label="REQUIREMENT - Register name [1]"
                    label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                    <b-form-input placeholder="DESCRIPTION"></b-form-input>
                    </b-form-group>
                    
                    <b-form-group label="REQUIREMENT - URL [1]"
                    label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                    <b-form-input placeholder="URL"></b-form-input>
                    </b-form-group>
                    
                                            <b-form-group label="QUESTION - Does the EO fulfil the criteria by itself? [1]">
                                                <b-form-radio-group id="radio-group-96" v-model="selected96" :options="options" name="radio-options96">
                                                </b-form-radio-group>
                                            </b-form-group>
                                        <div v-if="selected96 ==='no'">
                                        <b-card class="my-1"> <p>Cardinality [<em>1</em>]</p>
                                            <b-form-group label="QUESTION - In the case of no – Relied upon or not [1]">
                                                <b-form-radio-group id="radio-group-97" v-model="selected97" :options="options" name="radio-options97">
                                                </b-form-radio-group>
                                            </b-form-group>
                                        <div v-if="selected97 ==='yes'">
                                        <b-card class="my-1"> <p>Cardinality [<em>1</em>]</p>
                                            <b-form-group label="QUESTION - Name of the entity [1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="DESCRIPTION"></b-form-input>
                                            </b-form-group>
                                            <b-form-group label="QUESTION - ID of the entity [1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="ECONOMIC_OPERATOR_IDENTIFIER"></b-form-input>
                                            </b-form-group>
                                        </b-card>
                                        </div>
                                        </b-card>
                                        </div>
                                            <b-form-group label="QUESTION - Your Answer [1]">
                                                <b-form-radio-group id="radio-group-98" v-model="selected98" :options="options" name="radio-options98">
                                                </b-form-radio-group>
                                            </b-form-group>
                                        <div v-if="selected98 ==='yes'">
                                        <b-card class="my-1"> <p>Cardinality [<em>0..1</em>]</p>
                                            <b-form-group label="QUESTION - Registration number [0..1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="DESCRIPTION"></b-form-input>
                                            </b-form-group>
                                        </b-card>
                                        </div>
                                        <div v-if="selected98 ==='no'">
                                        <b-card class="my-1"> <p>Cardinality [<em>0..1</em>]</p>
                                            <b-form-group label="QUESTION - Reasons why your are not registered [1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="DESCRIPTION"></b-form-input>
                                            </b-form-group>
                                        </b-card>
                                        </div><b-card class="my-1"> <p>Cardinality [<em>1</em>]</p>
                                            <b-form-group label="QUESTION - Is this information available electronically? [1]">
                                                <b-form-radio-group id="radio-group-99" v-model="selected99" :options="options" name="radio-options99">
                                                </b-form-radio-group>
                                            </b-form-group>
                                        <div v-if="selected99 ==='yes'">
                                        <b-card class="my-1"> <p>Cardinality [<em>0..1</em>]</p>
                                            <b-form-group label="QUESTION - Evidence Supplied [1..n]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="EVIDENCE_IDENTIFIER"></b-form-input>
                                            </b-form-group>
                                        </b-card>
                                        </div></b-card></b-card></b-card>
                    </div>`
                    })

/**
 * Component - C27 - SC - For service contracts: authorisation of particular organisation needed
 */
Vue.component("C27 - SC",
                    { 
                        data(){
                            return {
 "options": [
  {
   "text": "Yes",
   "value": "yes"
  },
  {
   "text": "No",
   "value": "no"
  }
 ],
 "selected100": "yes",
 "selected101": "yes",
 "selected102": "yes",
 "selected103": "yes",
 "selected104": "yes",
 "selected105": "yes"
}
                        },
                        template: `<div>
                        <b-card title="C27 - SC - For service contracts: authorisation of particular organisation needed">
                            <b-card-text>Is a particular authorisation of a particular organisation needed in order to be able to perform the service in question in the country of establishment of the economic operator?</b-card-text>
                        <b-card><p>[Name of the National Criterion] <em>[Description of the National Criterion ]</em> [<em>0..n</em>]</p>
                    <b-card class="my-1"> <p>Cardinality [<em>1</em>]</p><b-card-text>CAPTION - [Additional information; e.g. no evidences online]</b-card-text>
                                        <b-form-group label="QUESTION - Your Answer [1]">
                                            <b-form-radio-group id="radio-group-100" v-model="selected100" :options="options" name="radio-options100">
                                            </b-form-radio-group>
                                        </b-form-group>
                                    <div v-if="selected100 ==='yes'">
                                    <b-card class="my-1"> <p>Cardinality [<em>0..n</em>]</p>
                                            <b-form-group label="QUESTION - If yes, please describe them [1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="DESCRIPTION"></b-form-input>
                                            </b-form-group>
                                            <b-form-group label="QUESTION - Indicate whether the economic operator has it [0..1]">
                                                <b-form-radio-group id="radio-group-101" v-model="selected101" :options="options" name="radio-options101">
                                                </b-form-radio-group>
                                            </b-form-group>
                                    </b-card>
                                    </div>
                    </b-card></b-card><b-card-text class="my-1">LEGISLATION [<em>0..n</em>]</b-card-text><b-card>
                    <b-form-group label="REQUIREMENT - Register name [0..1]"
                    label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                    <b-form-input placeholder="DESCRIPTION"></b-form-input>
                    </b-form-group>
                    
                    <b-form-group label="REQUIREMENT - URL [0..1]"
                    label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                    <b-form-input placeholder="URL"></b-form-input>
                    </b-form-group>
                    
                                            <b-form-group label="QUESTION - Does the EO fulfil the criteria by itself? [1]">
                                                <b-form-radio-group id="radio-group-102" v-model="selected102" :options="options" name="radio-options102">
                                                </b-form-radio-group>
                                            </b-form-group>
                                        <div v-if="selected102 ==='no'">
                                        <b-card class="my-1"> <p>Cardinality [<em>1</em>]</p>
                                            <b-form-group label="QUESTION - In the case of no – Relied upon or not [1]">
                                                <b-form-radio-group id="radio-group-103" v-model="selected103" :options="options" name="radio-options103">
                                                </b-form-radio-group>
                                            </b-form-group>
                                        <div v-if="selected103 ==='yes'">
                                        <b-card class="my-1"> <p>Cardinality [<em>1</em>]</p>
                                            <b-form-group label="QUESTION - Name of the entity [1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="DESCRIPTION"></b-form-input>
                                            </b-form-group>
                                            <b-form-group label="QUESTION - ID of the entity [1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="ECONOMIC_OPERATOR_IDENTIFIER"></b-form-input>
                                            </b-form-group>
                                        </b-card>
                                        </div>
                                        </b-card>
                                        </div>
                                            <b-form-group label="QUESTION - Your Answer [1]">
                                                <b-form-radio-group id="radio-group-104" v-model="selected104" :options="options" name="radio-options104">
                                                </b-form-radio-group>
                                            </b-form-group>
                                        <div v-if="selected104 ==='yes'">
                                        <b-card class="my-1"> <p>Cardinality [<em>0..1</em>]</p>
                                            <b-form-group label="QUESTION - Registration number [0..1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="DESCRIPTION"></b-form-input>
                                            </b-form-group>
                                        </b-card>
                                        </div>
                                        <div v-if="selected104 ==='no'">
                                        <b-card class="my-1"> <p>Cardinality [<em>0..1</em>]</p>
                                            <b-form-group label="QUESTION - Reasons why your are not registered [1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="DESCRIPTION"></b-form-input>
                                            </b-form-group>
                                        </b-card>
                                        </div><b-card class="my-1"> <p>Cardinality [<em>1</em>]</p>
                                            <b-form-group label="QUESTION - Is this information available electronically? [1]">
                                                <b-form-radio-group id="radio-group-105" v-model="selected105" :options="options" name="radio-options105">
                                                </b-form-radio-group>
                                            </b-form-group>
                                        <div v-if="selected105 ==='yes'">
                                        <b-card class="my-1"> <p>Cardinality [<em>0..1</em>]</p>
                                            <b-form-group label="QUESTION - Evidence Supplied [1..n]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="EVIDENCE_IDENTIFIER"></b-form-input>
                                            </b-form-group>
                                        </b-card>
                                        </div></b-card></b-card></b-card>
                    </div>`
                    })

/**
 * Component - C28 - SC - For service contracts: membership of particular organisation needed
 */
Vue.component("C28 - SC",
                    { 
                        data(){
                            return {
 "options": [
  {
   "text": "Yes",
   "value": "yes"
  },
  {
   "text": "No",
   "value": "no"
  }
 ],
 "selected106": "yes",
 "selected107": "yes",
 "selected108": "yes",
 "selected109": "yes",
 "selected110": "yes",
 "selected111": "yes"
}
                        },
                        template: `<div>
                        <b-card title="C28 - SC - For service contracts: membership of particular organisation needed">
                            <b-card-text>Is a particular membership of a particular organisation needed in order to be able to perform the service in question in the country of establishment of the economic operator?</b-card-text>
                        <b-card><p>[Name of the National Criterion] <em>[Description of the National Criterion ]</em> [<em>0..n</em>]</p>
                    <b-card class="my-1"> <p>Cardinality [<em>1</em>]</p><b-card-text>CAPTION - [Additional information; e.g. no evidences online]</b-card-text>
                                        <b-form-group label="QUESTION - Your Answer [1]">
                                            <b-form-radio-group id="radio-group-106" v-model="selected106" :options="options" name="radio-options106">
                                            </b-form-radio-group>
                                        </b-form-group>
                                    <div v-if="selected106 ==='yes'">
                                    <b-card class="my-1"> <p>Cardinality [<em>0..n</em>]</p>
                                            <b-form-group label="QUESTION - If yes, please describe them [1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="DESCRIPTION"></b-form-input>
                                            </b-form-group>
                                            <b-form-group label="QUESTION - Indicate whether the economic operator has it [0..1]">
                                                <b-form-radio-group id="radio-group-107" v-model="selected107" :options="options" name="radio-options107">
                                                </b-form-radio-group>
                                            </b-form-group>
                                    </b-card>
                                    </div>
                    </b-card></b-card><b-card-text class="my-1">LEGISLATION [<em>0..n</em>]</b-card-text><b-card>
                    <b-form-group label="REQUIREMENT - Register name [0..1]"
                    label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                    <b-form-input placeholder="DESCRIPTION"></b-form-input>
                    </b-form-group>
                    
                    <b-form-group label="REQUIREMENT - URL [0..1]"
                    label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                    <b-form-input placeholder="URL"></b-form-input>
                    </b-form-group>
                    
                                            <b-form-group label="QUESTION - Does the EO fulfil the criteria by itself? [1]">
                                                <b-form-radio-group id="radio-group-108" v-model="selected108" :options="options" name="radio-options108">
                                                </b-form-radio-group>
                                            </b-form-group>
                                        <div v-if="selected108 ==='no'">
                                        <b-card class="my-1"> <p>Cardinality [<em>1</em>]</p>
                                            <b-form-group label="QUESTION - In the case of no – Relied upon or not [1]">
                                                <b-form-radio-group id="radio-group-109" v-model="selected109" :options="options" name="radio-options109">
                                                </b-form-radio-group>
                                            </b-form-group>
                                        <div v-if="selected109 ==='yes'">
                                        <b-card class="my-1"> <p>Cardinality [<em>1</em>]</p>
                                            <b-form-group label="QUESTION - Name of the entity [1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="DESCRIPTION"></b-form-input>
                                            </b-form-group>
                                            <b-form-group label="QUESTION - ID of the entity [1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="ECONOMIC_OPERATOR_IDENTIFIER"></b-form-input>
                                            </b-form-group>
                                        </b-card>
                                        </div>
                                        </b-card>
                                        </div>
                                            <b-form-group label="QUESTION - Your Answer [1]">
                                                <b-form-radio-group id="radio-group-110" v-model="selected110" :options="options" name="radio-options110">
                                                </b-form-radio-group>
                                            </b-form-group>
                                        <div v-if="selected110 ==='yes'">
                                        <b-card class="my-1"> <p>Cardinality [<em>0..1</em>]</p>
                                            <b-form-group label="QUESTION - Registration number [0..1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="DESCRIPTION"></b-form-input>
                                            </b-form-group>
                                        </b-card>
                                        </div>
                                        <div v-if="selected110 ==='no'">
                                        <b-card class="my-1"> <p>Cardinality [<em>0..1</em>]</p>
                                            <b-form-group label="QUESTION - Reasons why your are not registered [1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="DESCRIPTION"></b-form-input>
                                            </b-form-group>
                                        </b-card>
                                        </div><b-card class="my-1"> <p>Cardinality [<em>1</em>]</p>
                                            <b-form-group label="QUESTION - Is this information available electronically? [1]">
                                                <b-form-radio-group id="radio-group-111" v-model="selected111" :options="options" name="radio-options111">
                                                </b-form-radio-group>
                                            </b-form-group>
                                        <div v-if="selected111 ==='yes'">
                                        <b-card class="my-1"> <p>Cardinality [<em>0..1</em>]</p>
                                            <b-form-group label="QUESTION - Evidence Supplied [1..n]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="EVIDENCE_IDENTIFIER"></b-form-input>
                                            </b-form-group>
                                        </b-card>
                                        </div></b-card></b-card></b-card>
                    </div>`
                    })

/**
 * Component - C29 - SC - General yearly turnover
 */
Vue.component("C29 - SC",
                    { 
                        data(){
                            return {
 "options": [
  {
   "text": "Yes",
   "value": "yes"
  },
  {
   "text": "No",
   "value": "no"
  }
 ],
 "selected112": "yes",
 "selected113": "yes",
 "selected114": "yes",
 "selected115": "yes",
 "selected116": "yes"
}
                        },
                        template: `<div>
                        <b-card title="C29 - SC - General yearly turnover">
                            <b-card-text>Its general yearly turnover for the number of financial years required in the relevant notice, the in the ESPD, the relevant notice or the ESPD is as follows:</b-card-text>
                        <b-card><p>[Name of the National Criterion] <em>[Description of the National Criterion ]</em> [<em>0..n</em>]</p>
                    <b-card class="my-1"> <p>Cardinality [<em>1</em>]</p><b-card-text>CAPTION - [Additional information; e.g. no evidences online]</b-card-text>
                                        <b-form-group label="QUESTION - Your Answer [1]">
                                            <b-form-radio-group id="radio-group-112" v-model="selected112" :options="options" name="radio-options112">
                                            </b-form-radio-group>
                                        </b-form-group>
                    </b-card></b-card><b-card-text class="my-1">LEGISLATION [<em>0..n</em>]</b-card-text><b-card>
                    <b-form-group label="REQUIREMENT - Number of fiscal years [1]"
                    label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                    <b-form-input placeholder="QUANTITY_YEAR"></b-form-input>
                    </b-form-group>
                    
                    <b-form-group label="REQUIREMENT - Threshold per year [1]"
                    label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                    <b-form-input placeholder="CODE_BOOLEAN"></b-form-input>
                    </b-form-group>
                    
                    <b-form-group label="REQUIREMENT - Minimum requirement [1..n]"
                    label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                    <b-form-input placeholder="AMOUNT"></b-form-input>
                    </b-form-group>
                    
                                            <b-form-group label="QUESTION - Does the EO fulfil the criteria by itself? [1]">
                                                <b-form-radio-group id="radio-group-113" v-model="selected113" :options="options" name="radio-options113">
                                                </b-form-radio-group>
                                            </b-form-group>
                                        <div v-if="selected113 ==='no'">
                                        <b-card class="my-1"> <p>Cardinality [<em>1</em>]</p>
                                            <b-form-group label="QUESTION - In the case of no – Relied upon or not [1]">
                                                <b-form-radio-group id="radio-group-114" v-model="selected114" :options="options" name="radio-options114">
                                                </b-form-radio-group>
                                            </b-form-group>
                                        <div v-if="selected114 ==='yes'">
                                        <b-card class="my-1"> <p>Cardinality [<em>1</em>]</p>
                                            <b-form-group label="QUESTION - Name of the entity [1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="DESCRIPTION"></b-form-input>
                                            </b-form-group>
                                            <b-form-group label="QUESTION - ID of the entity [1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="ECONOMIC_OPERATOR_IDENTIFIER"></b-form-input>
                                            </b-form-group>
                                        </b-card>
                                        </div>
                                        </b-card>
                                        </div>
                                            <b-form-group label="QUESTION - Amount [1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="AMOUNT"></b-form-input>
                                            </b-form-group>
                                            <b-form-group label="QUESTION - Start date; End date [1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="PERIOD"></b-form-input>
                                            </b-form-group>
                                            <b-form-group label="QUESTION - Is this information available electronically? [1]">
                                                <b-form-radio-group id="radio-group-115" v-model="selected115" :options="options" name="radio-options115">
                                                </b-form-radio-group>
                                            </b-form-group>
                                        <div v-if="selected115 ==='yes'">
                                        <b-card class="my-1"> <p>Cardinality [<em>0..1</em>]</p>
                                            <b-form-group label="QUESTION - Evidence Supplied [1..n]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="EVIDENCE_IDENTIFIER"></b-form-input>
                                            </b-form-group>
                                        </b-card>
                                        </div>
                                            <b-form-group label="QUESTION - In case the information concerning turnover (general or specific) is not available for the entire period required, please state the date on which the economic operator was set up or started trading: [0..1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="DATE"></b-form-input>
                                            </b-form-group>
                                            <b-form-group label="QUESTION - Is this information available electronically? [1]">
                                                <b-form-radio-group id="radio-group-116" v-model="selected116" :options="options" name="radio-options116">
                                                </b-form-radio-group>
                                            </b-form-group>
                                        <div v-if="selected116 ==='yes'">
                                        <b-card class="my-1"> <p>Cardinality [<em>0..1</em>]</p>
                                            <b-form-group label="QUESTION - Evidence Supplied [1..n]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="EVIDENCE_IDENTIFIER"></b-form-input>
                                            </b-form-group>
                                        </b-card>
                                        </div></b-card></b-card>
                    </div>`
                    })

/**
 * Component - C30 - SC - Average yearly turnover
 */
Vue.component("C30 - SC",
                    { 
                        data(){
                            return {
 "options": [
  {
   "text": "Yes",
   "value": "yes"
  },
  {
   "text": "No",
   "value": "no"
  }
 ],
 "selected117": "yes",
 "selected118": "yes",
 "selected119": "yes",
 "selected120": "yes",
 "selected121": "yes"
}
                        },
                        template: `<div>
                        <b-card title="C30 - SC - Average yearly turnover">
                            <b-card-text>Its average yearly turnover for the number of years required in the relevant notice, the procurement documents or the ESPD is as follows:</b-card-text>
                        <b-card><p>[Name of the National Criterion] <em>[Description of the National Criterion ]</em> [<em>0..n</em>]</p>
                    <b-card class="my-1"> <p>Cardinality [<em>1</em>]</p><b-card-text>CAPTION - [Additional information; e.g. no evidences online]</b-card-text>
                                        <b-form-group label="QUESTION - Your Answer [1]">
                                            <b-form-radio-group id="radio-group-117" v-model="selected117" :options="options" name="radio-options117">
                                            </b-form-radio-group>
                                        </b-form-group>
                    </b-card></b-card><b-card-text class="my-1">LEGISLATION [<em>0..n</em>]</b-card-text><b-card>
                    <b-form-group label="REQUIREMENT - Number of fiscal years [1]"
                    label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                    <b-form-input placeholder="QUANTITY_YEAR"></b-form-input>
                    </b-form-group>
                    
                    <b-form-group label="REQUIREMENT - Minimum requirement [1]"
                    label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                    <b-form-input placeholder="AMOUNT"></b-form-input>
                    </b-form-group>
                    
                                            <b-form-group label="QUESTION - Does the EO fulfil the criteria by itself? [1]">
                                                <b-form-radio-group id="radio-group-118" v-model="selected118" :options="options" name="radio-options118">
                                                </b-form-radio-group>
                                            </b-form-group>
                                        <div v-if="selected118 ==='no'">
                                        <b-card class="my-1"> <p>Cardinality [<em>1</em>]</p>
                                            <b-form-group label="QUESTION - In the case of no – Relied upon or not [1]">
                                                <b-form-radio-group id="radio-group-119" v-model="selected119" :options="options" name="radio-options119">
                                                </b-form-radio-group>
                                            </b-form-group>
                                        <div v-if="selected119 ==='yes'">
                                        <b-card class="my-1"> <p>Cardinality [<em>1</em>]</p>
                                            <b-form-group label="QUESTION - Name of the entity [1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="DESCRIPTION"></b-form-input>
                                            </b-form-group>
                                            <b-form-group label="QUESTION - ID of the entity [1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="ECONOMIC_OPERATOR_IDENTIFIER"></b-form-input>
                                            </b-form-group>
                                        </b-card>
                                        </div>
                                        </b-card>
                                        </div>
                                            <b-form-group label="QUESTION - Average for the required period [1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="AMOUNT"></b-form-input>
                                            </b-form-group>
                                            <b-form-group label="QUESTION - Additional information [1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="DESCRIPTION"></b-form-input>
                                            </b-form-group>
                                            <b-form-group label="QUESTION - Is this information available electronically? [1]">
                                                <b-form-radio-group id="radio-group-120" v-model="selected120" :options="options" name="radio-options120">
                                                </b-form-radio-group>
                                            </b-form-group>
                                        <div v-if="selected120 ==='yes'">
                                        <b-card class="my-1"> <p>Cardinality [<em>0..1</em>]</p>
                                            <b-form-group label="QUESTION - Evidence Supplied [1..n]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="EVIDENCE_IDENTIFIER"></b-form-input>
                                            </b-form-group>
                                        </b-card>
                                        </div>
                                            <b-form-group label="QUESTION - In case the information concerning turnover (general or specific) is not available for the entire period required, please state the date on which the economic operator was set up or started trading: [1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="DATE"></b-form-input>
                                            </b-form-group>
                                            <b-form-group label="QUESTION - Is this information available electronically? [1]">
                                                <b-form-radio-group id="radio-group-121" v-model="selected121" :options="options" name="radio-options121">
                                                </b-form-radio-group>
                                            </b-form-group>
                                        <div v-if="selected121 ==='yes'">
                                        <b-card class="my-1"> <p>Cardinality [<em>0..1</em>]</p>
                                            <b-form-group label="QUESTION - Evidence Supplied [1..n]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="EVIDENCE_IDENTIFIER"></b-form-input>
                                            </b-form-group>
                                        </b-card>
                                        </div></b-card></b-card>
                    </div>`
                    })

/**
 * Component - C31 - SC - Specific average turnover
 */
Vue.component("C31 - SC",
                    { 
                        data(){
                            return {
 "options": [
  {
   "text": "Yes",
   "value": "yes"
  },
  {
   "text": "No",
   "value": "no"
  }
 ],
 "selected122": "yes",
 "selected123": "yes",
 "selected124": "yes",
 "selected125": "yes",
 "selected126": "yes"
}
                        },
                        template: `<div>
                        <b-card title="C31 - SC - Specific average turnover">
                            <b-card-text>Its specific average yearly turnover in the business area covered by the contract for the number of years required in the relevant notice, the in the ESPD, the relevant notice or the ESPD is as follows:</b-card-text>
                        <b-card><p>[Name of the National Criterion] <em>[Description of the National Criterion ]</em> [<em>0..n</em>]</p>
                    <b-card class="my-1"> <p>Cardinality [<em>1</em>]</p><b-card-text>CAPTION - [Additional information; e.g. no evidences online]</b-card-text>
                                        <b-form-group label="QUESTION - Your Answer [1]">
                                            <b-form-radio-group id="radio-group-122" v-model="selected122" :options="options" name="radio-options122">
                                            </b-form-radio-group>
                                        </b-form-group>
                    </b-card></b-card><b-card-text class="my-1">LEGISLATION [<em>0..n</em>]</b-card-text><b-card>
                    <b-form-group label="REQUIREMENT - Number of fiscal years [1]"
                    label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                    <b-form-input placeholder="QUANTITY_YEAR"></b-form-input>
                    </b-form-group>
                    
                    <b-form-group label="REQUIREMENT - Business domain description [1]"
                    label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                    <b-form-input placeholder="DESCRIPTION"></b-form-input>
                    </b-form-group>
                    
                    <b-form-group label="REQUIREMENT - Minimum requirement [1]"
                    label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                    <b-form-input placeholder="AMOUNT"></b-form-input>
                    </b-form-group>
                    
                                            <b-form-group label="QUESTION - Does the EO fulfil the criteria by itself? [1]">
                                                <b-form-radio-group id="radio-group-123" v-model="selected123" :options="options" name="radio-options123">
                                                </b-form-radio-group>
                                            </b-form-group>
                                        <div v-if="selected123 ==='no'">
                                        <b-card class="my-1"> <p>Cardinality [<em>1</em>]</p>
                                            <b-form-group label="QUESTION - In the case of no – Relied upon or not [1]">
                                                <b-form-radio-group id="radio-group-124" v-model="selected124" :options="options" name="radio-options124">
                                                </b-form-radio-group>
                                            </b-form-group>
                                        <div v-if="selected124 ==='yes'">
                                        <b-card class="my-1"> <p>Cardinality [<em>1</em>]</p>
                                            <b-form-group label="QUESTION - Name of the entity [1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="DESCRIPTION"></b-form-input>
                                            </b-form-group>
                                            <b-form-group label="QUESTION - ID of the entity [1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="ECONOMIC_OPERATOR_IDENTIFIER"></b-form-input>
                                            </b-form-group>
                                        </b-card>
                                        </div>
                                        </b-card>
                                        </div>
                                            <b-form-group label="QUESTION - Start date; End date [1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="PERIOD"></b-form-input>
                                            </b-form-group>
                                            <b-form-group label="QUESTION - Amount [1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="AMOUNT"></b-form-input>
                                            </b-form-group>
                                            <b-form-group label="QUESTION - Is this information available electronically? [1]">
                                                <b-form-radio-group id="radio-group-125" v-model="selected125" :options="options" name="radio-options125">
                                                </b-form-radio-group>
                                            </b-form-group>
                                        <div v-if="selected125 ==='yes'">
                                        <b-card class="my-1"> <p>Cardinality [<em>0..1</em>]</p>
                                            <b-form-group label="QUESTION - Evidence Supplied [1..n]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="EVIDENCE_IDENTIFIER"></b-form-input>
                                            </b-form-group>
                                        </b-card>
                                        </div>
                                            <b-form-group label="QUESTION - In case the information concerning turnover (general or specific) is not available for the entire period required, please state the date on which the economic operator was set up or started trading: [1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="DATE"></b-form-input>
                                            </b-form-group>
                                            <b-form-group label="QUESTION - Is this information available electronically? [1]">
                                                <b-form-radio-group id="radio-group-126" v-model="selected126" :options="options" name="radio-options126">
                                                </b-form-radio-group>
                                            </b-form-group>
                                        <div v-if="selected126 ==='yes'">
                                        <b-card class="my-1"> <p>Cardinality [<em>0..1</em>]</p>
                                            <b-form-group label="QUESTION - Evidence Supplied [1..n]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="EVIDENCE_IDENTIFIER"></b-form-input>
                                            </b-form-group>
                                        </b-card>
                                        </div></b-card></b-card>
                    </div>`
                    })

/**
 * Component - C32 - SC - Specific yearly turnover
 */
Vue.component("C32 - SC",
                    { 
                        data(){
                            return {
 "options": [
  {
   "text": "Yes",
   "value": "yes"
  },
  {
   "text": "No",
   "value": "no"
  }
 ],
 "selected127": "yes",
 "selected128": "yes",
 "selected129": "yes",
 "selected130": "yes",
 "selected131": "yes"
}
                        },
                        template: `<div>
                        <b-card title="C32 - SC - Specific yearly turnover">
                            <b-card-text>Its specific yearly turnover in the business area covered by the contract for the number of financial years required in the relevant notice, in the ESPD, the relevant notice or the ESPD is as follows:</b-card-text>
                        <b-card><p>[Name of the National Criterion] <em>[Description of the National Criterion ]</em> [<em>0..n</em>]</p>
                    <b-card class="my-1"> <p>Cardinality [<em>1</em>]</p><b-card-text>CAPTION - [Additional information; e.g. no evidences online]</b-card-text>
                                        <b-form-group label="QUESTION - Your Answer [1]">
                                            <b-form-radio-group id="radio-group-127" v-model="selected127" :options="options" name="radio-options127">
                                            </b-form-radio-group>
                                        </b-form-group>
                    </b-card></b-card><b-card-text class="my-1">LEGISLATION [<em>0..n</em>]</b-card-text><b-card>
                    <b-form-group label="REQUIREMENT - Number of fiscal years [1]"
                    label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                    <b-form-input placeholder="QUANTITY_YEAR"></b-form-input>
                    </b-form-group>
                    
                    <b-form-group label="REQUIREMENT - Business domain description [1]"
                    label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                    <b-form-input placeholder="DESCRIPTION"></b-form-input>
                    </b-form-group>
                    
                    <b-form-group label="REQUIREMENT - Minimum requirement [1]"
                    label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                    <b-form-input placeholder="AMOUNT"></b-form-input>
                    </b-form-group>
                    
                                            <b-form-group label="QUESTION - Does the EO fulfil the criteria by itself? [1]">
                                                <b-form-radio-group id="radio-group-128" v-model="selected128" :options="options" name="radio-options128">
                                                </b-form-radio-group>
                                            </b-form-group>
                                        <div v-if="selected128 ==='no'">
                                        <b-card class="my-1"> <p>Cardinality [<em>1</em>]</p>
                                            <b-form-group label="QUESTION - In the case of no – Relied upon or not [1]">
                                                <b-form-radio-group id="radio-group-129" v-model="selected129" :options="options" name="radio-options129">
                                                </b-form-radio-group>
                                            </b-form-group>
                                        <div v-if="selected129 ==='yes'">
                                        <b-card class="my-1"> <p>Cardinality [<em>1</em>]</p>
                                            <b-form-group label="QUESTION - Name of the entity [1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="DESCRIPTION"></b-form-input>
                                            </b-form-group>
                                            <b-form-group label="QUESTION - ID of the entity [1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="ECONOMIC_OPERATOR_IDENTIFIER"></b-form-input>
                                            </b-form-group>
                                        </b-card>
                                        </div>
                                        </b-card>
                                        </div>
                                            <b-form-group label="QUESTION - Start date; End date [1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="PERIOD"></b-form-input>
                                            </b-form-group>
                                            <b-form-group label="QUESTION - Amount [1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="AMOUNT"></b-form-input>
                                            </b-form-group>
                                            <b-form-group label="QUESTION - Is this information available electronically? [1]">
                                                <b-form-radio-group id="radio-group-130" v-model="selected130" :options="options" name="radio-options130">
                                                </b-form-radio-group>
                                            </b-form-group>
                                        <div v-if="selected130 ==='yes'">
                                        <b-card class="my-1"> <p>Cardinality [<em>0..1</em>]</p>
                                            <b-form-group label="QUESTION - Evidence Supplied [1..n]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="EVIDENCE_IDENTIFIER"></b-form-input>
                                            </b-form-group>
                                        </b-card>
                                        </div>
                                            <b-form-group label="QUESTION - In case the information concerning turnover (general or specific) is not available for the entire period required, please state the date on which the economic operator was set up or started trading: [1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="DATE"></b-form-input>
                                            </b-form-group>
                                            <b-form-group label="QUESTION - Is this information available electronically? [1]">
                                                <b-form-radio-group id="radio-group-131" v-model="selected131" :options="options" name="radio-options131">
                                                </b-form-radio-group>
                                            </b-form-group>
                                        <div v-if="selected131 ==='yes'">
                                        <b-card class="my-1"> <p>Cardinality [<em>0..1</em>]</p>
                                            <b-form-group label="QUESTION - Evidence Supplied [1..n]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="EVIDENCE_IDENTIFIER"></b-form-input>
                                            </b-form-group>
                                        </b-card>
                                        </div></b-card></b-card>
                    </div>`
                    })

/**
 * Component - C34 - SC - Financial ratio
 */
Vue.component("C34 - SC",
                    { 
                        data(){
                            return {
 "options": [
  {
   "text": "Yes",
   "value": "yes"
  },
  {
   "text": "No",
   "value": "no"
  }
 ],
 "selected132": "yes",
 "selected133": "yes",
 "selected134": "yes"
}
                        },
                        template: `<div>
                        <b-card title="C34 - SC - Financial ratio">
                            <b-card-text>Concerning the financial ratios specified in the relevant notice, the procurement documents or the ESPD, the economic operator declares that the actual values for the required ratios are as follows:</b-card-text>
                        <b-card-text class="my-1">LEGISLATION [<em>0..n</em>]</b-card-text><b-card>
                    <b-form-group label="REQUIREMENT - Select the periods applicable for all ratios [1]"
                    label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                    <b-form-input placeholder="PERIOD"></b-form-input>
                    </b-form-group>
                    <b-card>
                    <b-form-group label="REQUIREMENT - Ratio Type [1]"
                    label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                    <b-form-input placeholder="CODE"></b-form-input>
                    </b-form-group>
                    
                    <b-form-group label="REQUIREMENT - Definition [1]"
                    label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                    <b-form-input placeholder="DESCRIPTION"></b-form-input>
                    </b-form-group>
                    
                    <b-form-group label="REQUIREMENT - Minimum requirement [1]"
                    label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                    <b-form-input placeholder="QUANTITY"></b-form-input>
                    </b-form-group>
                    </b-card>
                                            <b-form-group label="QUESTION - Does the EO fulfil the criteria by itself? [1]">
                                                <b-form-radio-group id="radio-group-132" v-model="selected132" :options="options" name="radio-options132">
                                                </b-form-radio-group>
                                            </b-form-group>
                                        <div v-if="selected132 ==='no'">
                                        <b-card class="my-1"> <p>Cardinality [<em>1</em>]</p>
                                            <b-form-group label="QUESTION - In the case of no – Relied upon or not [1]">
                                                <b-form-radio-group id="radio-group-133" v-model="selected133" :options="options" name="radio-options133">
                                                </b-form-radio-group>
                                            </b-form-group>
                                        <div v-if="selected133 ==='yes'">
                                        <b-card class="my-1"> <p>Cardinality [<em>1</em>]</p>
                                            <b-form-group label="QUESTION - Name of the entity [1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="DESCRIPTION"></b-form-input>
                                            </b-form-group>
                                            <b-form-group label="QUESTION - ID of the entity [1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="ECONOMIC_OPERATOR_IDENTIFIER"></b-form-input>
                                            </b-form-group>
                                        </b-card>
                                        </div>
                                        </b-card>
                                        </div>
                                            <b-form-group label="QUESTION - Please provide your ratio [1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="QUANTITY"></b-form-input>
                                            </b-form-group>
                                            <b-form-group label="QUESTION - Is this information available electronically? [1]">
                                                <b-form-radio-group id="radio-group-134" v-model="selected134" :options="options" name="radio-options134">
                                                </b-form-radio-group>
                                            </b-form-group>
                                        <div v-if="selected134 ==='yes'">
                                        <b-card class="my-1"> <p>Cardinality [<em>0..1</em>]</p>
                                            <b-form-group label="QUESTION - Evidence Supplied [1..n]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="EVIDENCE_IDENTIFIER"></b-form-input>
                                            </b-form-group>
                                        </b-card>
                                        </div></b-card></b-card>
                    </div>`
                    })

/**
 * Component - C35 - SC - Professional risk indemnity insurance
 */
Vue.component("C35 - SC",
                    { 
                        data(){
                            return {
 "options": [
  {
   "text": "Yes",
   "value": "yes"
  },
  {
   "text": "No",
   "value": "no"
  }
 ],
 "selected135": "yes",
 "selected136": "yes",
 "selected137": "yes",
 "selected138": "yes",
 "selected139": "yes",
 "selected140": "yes"
}
                        },
                        template: `<div>
                        <b-card title="C35 - SC - Professional risk indemnity insurance">
                            <b-card-text>The insured amount in its professional risk indemnity insurance is the following:</b-card-text>
                        <b-card><p>[Name of the National Criterion] <em>[Description of the National Criterion ]</em> [<em>0..n</em>]</p>
                    <b-card class="my-1"> <p>Cardinality [<em>1</em>]</p><b-card-text>CAPTION - [Additional information; e.g. no evidences online]</b-card-text>
                                        <b-form-group label="QUESTION - Your Answer [1]">
                                            <b-form-radio-group id="radio-group-135" v-model="selected135" :options="options" name="radio-options135">
                                            </b-form-radio-group>
                                        </b-form-group>
                    </b-card></b-card><b-card-text class="my-1">LEGISLATION [<em>0..n</em>]</b-card-text><b-card>
                    <b-form-group label="REQUIREMENT - Type of insurance [1]"
                    label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                    <b-form-input placeholder="DESCRIPTION"></b-form-input>
                    </b-form-group>
                    
                    <b-form-group label="REQUIREMENT - Minimum amount [1]"
                    label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                    <b-form-input placeholder="AMOUNT"></b-form-input>
                    </b-form-group>
                    
                                            <b-form-group label="QUESTION - Does the EO fulfil the criteria by itself? [1]">
                                                <b-form-radio-group id="radio-group-136" v-model="selected136" :options="options" name="radio-options136">
                                                </b-form-radio-group>
                                            </b-form-group>
                                        <div v-if="selected136 ==='no'">
                                        <b-card class="my-1"> <p>Cardinality [<em>1</em>]</p>
                                            <b-form-group label="QUESTION - In the case of no – Relied upon or not [1]">
                                                <b-form-radio-group id="radio-group-137" v-model="selected137" :options="options" name="radio-options137">
                                                </b-form-radio-group>
                                            </b-form-group>
                                        <div v-if="selected137 ==='yes'">
                                        <b-card class="my-1"> <p>Cardinality [<em>1</em>]</p>
                                            <b-form-group label="QUESTION - Name of the entity [1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="DESCRIPTION"></b-form-input>
                                            </b-form-group>
                                            <b-form-group label="QUESTION - ID of the entity [1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="ECONOMIC_OPERATOR_IDENTIFIER"></b-form-input>
                                            </b-form-group>
                                        </b-card>
                                        </div>
                                        </b-card>
                                        </div>
                                            <b-form-group label="QUESTION - Amount [1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="AMOUNT"></b-form-input>
                                            </b-form-group>
                                            <b-form-group label="QUESTION - As an EO I will commit to obtain the minimum amount required [1]">
                                                <b-form-radio-group id="radio-group-138" v-model="selected138" :options="options" name="radio-options138">
                                                </b-form-radio-group>
                                            </b-form-group>
                                            <b-form-group label="QUESTION - I am exempt [1]">
                                                <b-form-radio-group id="radio-group-139" v-model="selected139" :options="options" name="radio-options139">
                                                </b-form-radio-group>
                                            </b-form-group>
                                            <b-form-group label="QUESTION - Is this information available electronically? [1]">
                                                <b-form-radio-group id="radio-group-140" v-model="selected140" :options="options" name="radio-options140">
                                                </b-form-radio-group>
                                            </b-form-group>
                                        <div v-if="selected140 ==='yes'">
                                        <b-card class="my-1"> <p>Cardinality [<em>0..1</em>]</p>
                                            <b-form-group label="QUESTION - Evidence Supplied [1..n]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="EVIDENCE_IDENTIFIER"></b-form-input>
                                            </b-form-group>
                                        </b-card>
                                        </div></b-card></b-card>
                    </div>`
                    })

/**
 * Component - C36 - SC - Other economic or financial requirements
 */
Vue.component("C36 - SC",
                    { 
                        data(){
                            return {
 "options": [
  {
   "text": "Yes",
   "value": "yes"
  },
  {
   "text": "No",
   "value": "no"
  }
 ],
 "selected141": "yes",
 "selected142": "yes"
}
                        },
                        template: `<div>
                        <b-card title="C36 - SC - Other economic or financial requirements">
                            <b-card-text>Concerning the other economic or financial requirements, if any, that may have been specified in the relevant notice or in the ESPD, the economic operator declares that:</b-card-text>
                        <b-card><p>[Name of the National Criterion] <em>[Description of the National Criterion ]</em> [<em>0..n</em>]</p>
                    <b-card class="my-1"> <p>Cardinality [<em>1</em>]</p><b-card-text>CAPTION - [Additional information; e.g. no evidences online]</b-card-text>
                                        <b-form-group label="QUESTION - Your Answer [1]">
                                            <b-form-radio-group id="radio-group-141" v-model="selected141" :options="options" name="radio-options141">
                                            </b-form-radio-group>
                                        </b-form-group>
                    </b-card></b-card><b-card-text class="my-1">LEGISLATION [<em>0..n</em>]</b-card-text><b-card><b-card-text>CAPTION - undefined</b-card-text><b-card>
                    <b-form-group label="REQUIREMENT - Select the type of requirement [1]"
                    label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                    <b-form-input placeholder="CODE_BOOLEAN"></b-form-input>
                    </b-form-group>
                    <b-card>
                    <b-form-group label="REQUIREMENT - Description of the economic or financial requirement [1]"
                    label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                    <b-form-input placeholder="DESCRIPTION"></b-form-input>
                    </b-form-group>
                    
                    <b-form-group label="REQUIREMENT - Minimum amount [1]"
                    label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                    <b-form-input placeholder="AMOUNT"></b-form-input>
                    </b-form-group>
                    
                    <b-form-group label="REQUIREMENT - Start date; End date [1]"
                    label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                    <b-form-input placeholder="PERIOD"></b-form-input>
                    </b-form-group>
                    
                                            <b-form-group label="QUESTION - Amount [1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="AMOUNT"></b-form-input>
                                            </b-form-group></b-card><b-card>
                    <b-form-group label="REQUIREMENT - Minimum rating [1]"
                    label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                    <b-form-input placeholder="QUANTITY"></b-form-input>
                    </b-form-group>
                    
                    <b-form-group label="REQUIREMENT - Rating scheme [1]"
                    label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                    <b-form-input placeholder="DESCRIPTION"></b-form-input>
                    </b-form-group>
                    
                                            <b-form-group label="QUESTION - Rating [1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="QUANTITY"></b-form-input>
                                            </b-form-group></b-card>
                                            <b-form-group label="QUESTION - Is this information available electronically? [1]">
                                                <b-form-radio-group id="radio-group-142" v-model="selected142" :options="options" name="radio-options142">
                                                </b-form-radio-group>
                                            </b-form-group>
                                        <div v-if="selected142 ==='yes'">
                                        <b-card class="my-1"> <p>Cardinality [<em>0..1</em>]</p>
                                            <b-form-group label="QUESTION - Evidence Supplied [1..n]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="EVIDENCE_IDENTIFIER"></b-form-input>
                                            </b-form-group>
                                        </b-card>
                                        </div></b-card></b-card></b-card>
                    </div>`
                    })

/**
 * Component - C37 - SC - For works contracts: performance of works of the specified type
 */
Vue.component("C37 - SC",
                    { 
                        data(){
                            return {
 "options": [
  {
   "text": "Yes",
   "value": "yes"
  },
  {
   "text": "No",
   "value": "no"
  }
 ],
 "selected143": "yes",
 "selected144": "yes",
 "selected145": "yes"
}
                        },
                        template: `<div>
                        <b-card title="C37 - SC - For works contracts: performance of works of the specified type">
                            <b-card-text>For public works contracts only: During the reference period, the economic operator has performed the following works of the specified type. Contracting authorities may require up to five years and allow experience dating from more than five years.</b-card-text>
                        <b-card><p>[Name of the National Criterion] <em>[Description of the National Criterion ]</em> [<em>0..n</em>]</p>
                    <b-card class="my-1"> <p>Cardinality [<em>1</em>]</p><b-card-text>CAPTION - [Additional information; e.g. no evidences online]</b-card-text>
                                        <b-form-group label="QUESTION - Your Answer [1]">
                                            <b-form-radio-group id="radio-group-143" v-model="selected143" :options="options" name="radio-options143">
                                            </b-form-radio-group>
                                        </b-form-group>
                    </b-card></b-card><b-card-text class="my-1">LEGISLATION [<em>0..n</em>]</b-card-text><b-card>
                    <b-form-group label="REQUIREMENT - Minimum number of references [1]"
                    label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                    <b-form-input placeholder="QUANTITY_INTEGER"></b-form-input>
                    </b-form-group>
                    <b-card><b-card-text>CAPTION - undefined</b-card-text><b-card>
                    <b-form-group label="REQUIREMENT - Requirement [1..n]"
                    label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                    <b-form-input placeholder="DESCRIPTION"></b-form-input>
                    </b-form-group>
                    </b-card></b-card><b-card-text>CAPTION - undefined</b-card-text><b-card class="my-1"> <p>Cardinality [<em>1..n</em>]</p>
                                            <b-form-group label="QUESTION - Reference description [0..1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="DESCRIPTION"></b-form-input>
                                            </b-form-group>
                                            <b-form-group label="QUESTION - Total amount [0..1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="AMOUNT"></b-form-input>
                                            </b-form-group>
                                            <b-form-group label="QUESTION - Activity of the economic operator [0..1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="DESCRIPTION"></b-form-input>
                                            </b-form-group>
                                            <b-form-group label="QUESTION - Specific amount [0..1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="AMOUNT"></b-form-input>
                                            </b-form-group>
                                            <b-form-group label="QUESTION - Period (Start and End dates) [0..1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="PERIOD"></b-form-input>
                                            </b-form-group>
                                            <b-form-group label="QUESTION - Confidential [0..1]">
                                                <b-form-radio-group id="radio-group-144" v-model="selected144" :options="options" name="radio-options144">
                                                </b-form-radio-group>
                                            </b-form-group><b-card class="my-1"> <p>Cardinality [<em>0..n</em>]</p>
                                            <b-form-group label="QUESTION - Recipient name [0..1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="DESCRIPTION"></b-form-input>
                                            </b-form-group>
                                            <b-form-group label="QUESTION - Contact person name [0..1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="DESCRIPTION"></b-form-input>
                                            </b-form-group>
                                            <b-form-group label="QUESTION - Contact email [0..1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="DESCRIPTION"></b-form-input>
                                            </b-form-group>
                                            <b-form-group label="QUESTION - Contact telephone [0..1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="DESCRIPTION"></b-form-input>
                                            </b-form-group></b-card><b-card class="my-1"> <p>Cardinality [<em>1</em>]</p>
                                            <b-form-group label="QUESTION - Is this information available online? [1]">
                                                <b-form-radio-group id="radio-group-145" v-model="selected145" :options="options" name="radio-options145">
                                                </b-form-radio-group>
                                            </b-form-group>
                                        <div v-if="selected145 ==='yes'">
                                        <b-card class="my-1"> <p>Cardinality [<em>0..1</em>]</p>
                                            <b-form-group label="QUESTION - Evidence Supplied [1..n]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="EVIDENCE_IDENTIFIER"></b-form-input>
                                            </b-form-group>
                                        </b-card>
                                        </div></b-card></b-card></b-card></b-card>
                    </div>`
                    })

/**
 * Component - C38 - SC - For supply contracts: performance of deliveries of the specified type
 */
Vue.component("C38 - SC",
                    { 
                        data(){
                            return {
 "options": [
  {
   "text": "Yes",
   "value": "yes"
  },
  {
   "text": "No",
   "value": "no"
  }
 ],
 "selected146": "yes",
 "selected147": "yes",
 "selected148": "yes"
}
                        },
                        template: `<div>
                        <b-card title="C38 - SC - For supply contracts: performance of deliveries of the specified type">
                            <b-card-text>For public supply contracts only: During the reference period, the economic operator has delivered the following principal deliveries of the type specified. Contracting authorities may require up to three years and allow experience dating from more than three years.</b-card-text>
                        <b-card><p>[Name of the National Criterion] <em>[Description of the National Criterion ]</em> [<em>0..n</em>]</p>
                    <b-card class="my-1"> <p>Cardinality [<em>1</em>]</p><b-card-text>CAPTION - [Additional information; e.g. no evidences online]</b-card-text>
                                        <b-form-group label="QUESTION - Your Answer [1]">
                                            <b-form-radio-group id="radio-group-146" v-model="selected146" :options="options" name="radio-options146">
                                            </b-form-radio-group>
                                        </b-form-group>
                    </b-card></b-card><b-card-text class="my-1">LEGISLATION [<em>0..n</em>]</b-card-text><b-card>
                    <b-form-group label="REQUIREMENT - Minimum number of references [1]"
                    label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                    <b-form-input placeholder="QUANTITY_INTEGER"></b-form-input>
                    </b-form-group>
                    <b-card><b-card-text>CAPTION - undefined</b-card-text><b-card>
                    <b-form-group label="REQUIREMENT - Requirement [1..n]"
                    label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                    <b-form-input placeholder="DESCRIPTION"></b-form-input>
                    </b-form-group>
                    </b-card></b-card><b-card-text>CAPTION - undefined</b-card-text><b-card class="my-1"> <p>Cardinality [<em>1..n</em>]</p>
                                            <b-form-group label="QUESTION - Reference description [0..1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="DESCRIPTION"></b-form-input>
                                            </b-form-group>
                                            <b-form-group label="QUESTION - Total amount [0..1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="AMOUNT"></b-form-input>
                                            </b-form-group>
                                            <b-form-group label="QUESTION - Activity of the economic operator [0..1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="DESCRIPTION"></b-form-input>
                                            </b-form-group>
                                            <b-form-group label="QUESTION - Specific amount [0..1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="AMOUNT"></b-form-input>
                                            </b-form-group>
                                            <b-form-group label="QUESTION - Period (Start and End dates) [0..1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="PERIOD"></b-form-input>
                                            </b-form-group>
                                            <b-form-group label="QUESTION - Confidential [0..1]">
                                                <b-form-radio-group id="radio-group-147" v-model="selected147" :options="options" name="radio-options147">
                                                </b-form-radio-group>
                                            </b-form-group><b-card class="my-1"> <p>Cardinality [<em>0..n</em>]</p>
                                            <b-form-group label="QUESTION - Recipient name [0..1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="DESCRIPTION"></b-form-input>
                                            </b-form-group>
                                            <b-form-group label="QUESTION - Contact person name [0..1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="DESCRIPTION"></b-form-input>
                                            </b-form-group>
                                            <b-form-group label="QUESTION - Contact email [0..1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="DESCRIPTION"></b-form-input>
                                            </b-form-group>
                                            <b-form-group label="QUESTION - Contact telephone [0..1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="DESCRIPTION"></b-form-input>
                                            </b-form-group></b-card><b-card class="my-1"> <p>Cardinality [<em>1</em>]</p>
                                            <b-form-group label="QUESTION - Is this information available online? [1]">
                                                <b-form-radio-group id="radio-group-148" v-model="selected148" :options="options" name="radio-options148">
                                                </b-form-radio-group>
                                            </b-form-group>
                                        <div v-if="selected148 ==='yes'">
                                        <b-card class="my-1"> <p>Cardinality [<em>0..1</em>]</p>
                                            <b-form-group label="QUESTION - Evidence Supplied [1..n]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="EVIDENCE_IDENTIFIER"></b-form-input>
                                            </b-form-group>
                                        </b-card>
                                        </div></b-card></b-card></b-card></b-card>
                    </div>`
                    })

/**
 * Component - C39 - SC - For service contracts: performance of services of the specified type
 */
Vue.component("C39 - SC",
                    { 
                        data(){
                            return {
 "options": [
  {
   "text": "Yes",
   "value": "yes"
  },
  {
   "text": "No",
   "value": "no"
  }
 ],
 "selected149": "yes",
 "selected150": "yes",
 "selected151": "yes"
}
                        },
                        template: `<div>
                        <b-card title="C39 - SC - For service contracts: performance of services of the specified type">
                            <b-card-text>For public service contracts only: During the reference period, the economic operator has provided the following main services of the type specified. Contracting authorities may require up to three years and allow experience dating from more than three years.</b-card-text>
                        <b-card><p>[Name of the National Criterion] <em>[Description of the National Criterion ]</em> [<em>0..n</em>]</p>
                    <b-card class="my-1"> <p>Cardinality [<em>1</em>]</p><b-card-text>CAPTION - [Additional information; e.g. no evidences online]</b-card-text>
                                        <b-form-group label="QUESTION - Your Answer [1]">
                                            <b-form-radio-group id="radio-group-149" v-model="selected149" :options="options" name="radio-options149">
                                            </b-form-radio-group>
                                        </b-form-group>
                    </b-card></b-card><b-card-text class="my-1">LEGISLATION [<em>0..n</em>]</b-card-text><b-card>
                    <b-form-group label="REQUIREMENT - Minimum number of references [1]"
                    label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                    <b-form-input placeholder="QUANTITY_INTEGER"></b-form-input>
                    </b-form-group>
                    <b-card><b-card-text>CAPTION - undefined</b-card-text><b-card>
                    <b-form-group label="REQUIREMENT - Requirement [1..n]"
                    label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                    <b-form-input placeholder="DESCRIPTION"></b-form-input>
                    </b-form-group>
                    </b-card></b-card><b-card-text>CAPTION - undefined</b-card-text><b-card class="my-1"> <p>Cardinality [<em>1..n</em>]</p>
                                            <b-form-group label="QUESTION - Reference description [0..1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="DESCRIPTION"></b-form-input>
                                            </b-form-group>
                                            <b-form-group label="QUESTION - Total amount [0..1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="AMOUNT"></b-form-input>
                                            </b-form-group>
                                            <b-form-group label="QUESTION - Activity of the economic operator [0..1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="DESCRIPTION"></b-form-input>
                                            </b-form-group>
                                            <b-form-group label="QUESTION - Specific amount [0..1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="AMOUNT"></b-form-input>
                                            </b-form-group>
                                            <b-form-group label="QUESTION - Period (Start and End dates) [0..1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="PERIOD"></b-form-input>
                                            </b-form-group>
                                            <b-form-group label="QUESTION - Confidential [0..1]">
                                                <b-form-radio-group id="radio-group-150" v-model="selected150" :options="options" name="radio-options150">
                                                </b-form-radio-group>
                                            </b-form-group><b-card class="my-1"> <p>Cardinality [<em>0..n</em>]</p>
                                            <b-form-group label="QUESTION - Recipient name [0..1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="DESCRIPTION"></b-form-input>
                                            </b-form-group>
                                            <b-form-group label="QUESTION - Contact person name [0..1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="DESCRIPTION"></b-form-input>
                                            </b-form-group>
                                            <b-form-group label="QUESTION - Contact email [0..1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="DESCRIPTION"></b-form-input>
                                            </b-form-group>
                                            <b-form-group label="QUESTION - Contact telephone [0..1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="DESCRIPTION"></b-form-input>
                                            </b-form-group></b-card><b-card class="my-1"> <p>Cardinality [<em>1</em>]</p>
                                            <b-form-group label="QUESTION - Is this information available online? [1]">
                                                <b-form-radio-group id="radio-group-151" v-model="selected151" :options="options" name="radio-options151">
                                                </b-form-radio-group>
                                            </b-form-group>
                                        <div v-if="selected151 ==='yes'">
                                        <b-card class="my-1"> <p>Cardinality [<em>0..1</em>]</p>
                                            <b-form-group label="QUESTION - Evidence Supplied [1..n]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="EVIDENCE_IDENTIFIER"></b-form-input>
                                            </b-form-group>
                                        </b-card>
                                        </div></b-card></b-card></b-card></b-card>
                    </div>`
                    })

/**
 * Component - C40 - SC - Technicians or technical bodies for quality control
 */
Vue.component("C40 - SC",
                    { 
                        data(){
                            return {
 "options": [
  {
   "text": "Yes",
   "value": "yes"
  },
  {
   "text": "No",
   "value": "no"
  }
 ],
 "selected152": "yes",
 "selected153": "yes",
 "selected154": "yes",
 "selected155": "yes",
 "selected156": "yes"
}
                        },
                        template: `<div>
                        <b-card title="C40 - SC - Technicians or technical bodies for quality control">
                            <b-card-text>It can call upon the following technicians or technical bodies, especially those responsible for quality control. For technicians or technical bodies not belonging directly to the economic operator's undertaking but on whose capacities the economic operator relies as set out under Part II, Section C, separate ESPD forms must be filled in.</b-card-text>
                        <b-card><p>[Name of the National Criterion] <em>[Description of the National Criterion ]</em> [<em>0..n</em>]</p>
                    <b-card class="my-1"> <p>Cardinality [<em>1</em>]</p><b-card-text>CAPTION - [Additional information; e.g. no evidences online]</b-card-text>
                                        <b-form-group label="QUESTION - Your Answer [1]">
                                            <b-form-radio-group id="radio-group-152" v-model="selected152" :options="options" name="radio-options152">
                                            </b-form-radio-group>
                                        </b-form-group>
                    </b-card></b-card><b-card-text class="my-1">LEGISLATION [<em>0..n</em>]</b-card-text><b-card><b-card-text>CAPTION - [Additional information; e.g. no evidences online]</b-card-text><b-card>
                    <b-form-group label="REQUIREMENT - Requirement [1]"
                    label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                    <b-form-input placeholder="DESCRIPTION"></b-form-input>
                    </b-form-group>
                    
                                            <b-form-group label="QUESTION - Does the EO fulfil the criteria by itself? [1]">
                                                <b-form-radio-group id="radio-group-153" v-model="selected153" :options="options" name="radio-options153">
                                                </b-form-radio-group>
                                            </b-form-group>
                                        <div v-if="selected153 ==='no'">
                                        <b-card class="my-1"> <p>Cardinality [<em>1</em>]</p>
                                            <b-form-group label="QUESTION - In the case of no – Relied upon or not [1]">
                                                <b-form-radio-group id="radio-group-154" v-model="selected154" :options="options" name="radio-options154">
                                                </b-form-radio-group>
                                            </b-form-group>
                                        <div v-if="selected154 ==='yes'">
                                        <b-card class="my-1"> <p>Cardinality [<em>1</em>]</p>
                                            <b-form-group label="QUESTION - Name of the entity [1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="DESCRIPTION"></b-form-input>
                                            </b-form-group>
                                            <b-form-group label="QUESTION - ID of the entity [1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="ECONOMIC_OPERATOR_IDENTIFIER"></b-form-input>
                                            </b-form-group>
                                        </b-card>
                                        </div>
                                        </b-card>
                                        </div><b-card-text>CAPTION - undefined</b-card-text><b-card class="my-1"> <p>Cardinality [<em>0..n</em>]</p>
                                            <b-form-group label="QUESTION - First name [0..1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="DESCRIPTION"></b-form-input>
                                            </b-form-group>
                                            <b-form-group label="QUESTION - Last name [0..1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="DESCRIPTION"></b-form-input>
                                            </b-form-group>
                                            <b-form-group label="QUESTION - Profession [1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="DESCRIPTION"></b-form-input>
                                            </b-form-group>
                                            <b-form-group label="QUESTION - Experience [0..1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="DESCRIPTION"></b-form-input>
                                            </b-form-group>
                                            <b-form-group label="QUESTION - Other information [0..1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="DESCRIPTION"></b-form-input>
                                            </b-form-group>
                                            <b-form-group label="QUESTION - How long with EO [0..1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="QUANTITY_YEAR"></b-form-input>
                                            </b-form-group><b-card class="my-1"> <p>Cardinality [<em>0..1</em>]</p>
                                            <b-form-group label="QUESTION - Is this information available online? [1]">
                                                <b-form-radio-group id="radio-group-155" v-model="selected155" :options="options" name="radio-options155">
                                                </b-form-radio-group>
                                            </b-form-group>
                                        <div v-if="selected155 ==='yes'">
                                        <b-card class="my-1"> <p>Cardinality [<em>0..1</em>]</p>
                                            <b-form-group label="QUESTION - Evidence supplied [1..n]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="EVIDENCE_IDENTIFIER"></b-form-input>
                                            </b-form-group>
                                        </b-card>
                                        </div></b-card></b-card><b-card-text>CAPTION - undefined</b-card-text><b-card class="my-1"> <p>Cardinality [<em>0..n</em>]</p>
                                            <b-form-group label="QUESTION - Name [1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="DESCRIPTION"></b-form-input>
                                            </b-form-group>
                                            <b-form-group label="QUESTION - Experience area [0..1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="DESCRIPTION"></b-form-input>
                                            </b-form-group>
                                            <b-form-group label="QUESTION - Other information [0..1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="DESCRIPTION"></b-form-input>
                                            </b-form-group><b-card class="my-1"> <p>Cardinality [<em>1</em>]</p>
                                            <b-form-group label="QUESTION - Is this information available online? [1]">
                                                <b-form-radio-group id="radio-group-156" v-model="selected156" :options="options" name="radio-options156">
                                                </b-form-radio-group>
                                            </b-form-group>
                                        <div v-if="selected156 ==='yes'">
                                        <b-card class="my-1"> <p>Cardinality [<em>0..1</em>]</p>
                                            <b-form-group label="QUESTION - Evidence Supplied [1..n]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="EVIDENCE_IDENTIFIER"></b-form-input>
                                            </b-form-group>
                                        </b-card>
                                        </div></b-card></b-card></b-card></b-card></b-card>
                    </div>`
                    })

/**
 * Component - C41 - SC - In the case of public works contracts, the economic operator will be able to call on the following technicians or technical bodies to carry out the work:
 */
Vue.component("C41 - SC",
                    { 
                        data(){
                            return {
 "options": [
  {
   "text": "Yes",
   "value": "yes"
  },
  {
   "text": "No",
   "value": "no"
  }
 ],
 "selected157": "yes",
 "selected158": "yes",
 "selected159": "yes",
 "selected160": "yes",
 "selected161": "yes"
}
                        },
                        template: `<div>
                        <b-card title="C41 - SC - In the case of public works contracts, the economic operator will be able to call on the following technicians or technical bodies to carry out the work:">
                            <b-card-text>In the case of public works contracts, the economic operator will be able to call on the following technicians or technical bodies to carry out the work:</b-card-text>
                        <b-card><p>[Description of the National Criterion ] <em>[Description of the National Criterion ]</em> [<em>0..n</em>]</p>
                    <b-card class="my-1"> <p>Cardinality [<em>1</em>]</p><b-card-text>CAPTION - [Additional information; e.g. no evidences online]</b-card-text>
                                        <b-form-group label="QUESTION - Your Answer [1]">
                                            <b-form-radio-group id="radio-group-157" v-model="selected157" :options="options" name="radio-options157">
                                            </b-form-radio-group>
                                        </b-form-group>
                    </b-card></b-card><b-card-text class="my-1">LEGISLATION [<em>0..n</em>]</b-card-text><b-card><b-card-text>CAPTION - [Additional information; e.g. no evidences online]</b-card-text><b-card>
                    <b-form-group label="REQUIREMENT - Requirement [1]"
                    label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                    <b-form-input placeholder="DESCRIPTION"></b-form-input>
                    </b-form-group>
                    
                                            <b-form-group label="QUESTION - Does the EO fulfil the criteria by itself? [1]">
                                                <b-form-radio-group id="radio-group-158" v-model="selected158" :options="options" name="radio-options158">
                                                </b-form-radio-group>
                                            </b-form-group>
                                        <div v-if="selected158 ==='no'">
                                        <b-card class="my-1"> <p>Cardinality [<em>1</em>]</p>
                                            <b-form-group label="QUESTION - In the case of no – Relied upon or not [1]">
                                                <b-form-radio-group id="radio-group-159" v-model="selected159" :options="options" name="radio-options159">
                                                </b-form-radio-group>
                                            </b-form-group>
                                        <div v-if="selected159 ==='yes'">
                                        <b-card class="my-1"> <p>Cardinality [<em>1</em>]</p>
                                            <b-form-group label="QUESTION - Name of the entity [1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="DESCRIPTION"></b-form-input>
                                            </b-form-group>
                                            <b-form-group label="QUESTION - ID of the entity [1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="ECONOMIC_OPERATOR_IDENTIFIER"></b-form-input>
                                            </b-form-group>
                                        </b-card>
                                        </div>
                                        </b-card>
                                        </div><b-card-text>CAPTION - undefined</b-card-text><b-card class="my-1"> <p>Cardinality [<em>0..n</em>]</p>
                                            <b-form-group label="QUESTION - First name [0..1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="DESCRIPTION"></b-form-input>
                                            </b-form-group>
                                            <b-form-group label="QUESTION - Last name [0..1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="DESCRIPTION"></b-form-input>
                                            </b-form-group>
                                            <b-form-group label="QUESTION - Profession [1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="DESCRIPTION"></b-form-input>
                                            </b-form-group>
                                            <b-form-group label="QUESTION - Experience [0..1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="DESCRIPTION"></b-form-input>
                                            </b-form-group>
                                            <b-form-group label="QUESTION - Other information [0..1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="DESCRIPTION"></b-form-input>
                                            </b-form-group>
                                            <b-form-group label="QUESTION - How long with EO [0..1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="QUANTITY_YEAR"></b-form-input>
                                            </b-form-group><b-card class="my-1"> <p>Cardinality [<em>0..1</em>]</p>
                                            <b-form-group label="QUESTION - Is this information available online? [1]">
                                                <b-form-radio-group id="radio-group-160" v-model="selected160" :options="options" name="radio-options160">
                                                </b-form-radio-group>
                                            </b-form-group>
                                        <div v-if="selected160 ==='yes'">
                                        <b-card class="my-1"> <p>Cardinality [<em>0..1</em>]</p>
                                            <b-form-group label="QUESTION - Evidence supplied [1..n]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="EVIDENCE_IDENTIFIER"></b-form-input>
                                            </b-form-group>
                                        </b-card>
                                        </div></b-card></b-card><b-card-text>CAPTION - undefined</b-card-text><b-card class="my-1"> <p>Cardinality [<em>0..n</em>]</p>
                                            <b-form-group label="QUESTION - Name [1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="DESCRIPTION"></b-form-input>
                                            </b-form-group>
                                            <b-form-group label="QUESTION - Experience area [0..1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="DESCRIPTION"></b-form-input>
                                            </b-form-group>
                                            <b-form-group label="QUESTION - Other information [0..1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="DESCRIPTION"></b-form-input>
                                            </b-form-group><b-card class="my-1"> <p>Cardinality [<em>1</em>]</p>
                                            <b-form-group label="QUESTION - Is this information available online? [1]">
                                                <b-form-radio-group id="radio-group-161" v-model="selected161" :options="options" name="radio-options161">
                                                </b-form-radio-group>
                                            </b-form-group>
                                        <div v-if="selected161 ==='yes'">
                                        <b-card class="my-1"> <p>Cardinality [<em>0..1</em>]</p>
                                            <b-form-group label="QUESTION - Evidence Supplied [1..n]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="EVIDENCE_IDENTIFIER"></b-form-input>
                                            </b-form-group>
                                        </b-card>
                                        </div></b-card></b-card></b-card></b-card></b-card>
                    </div>`
                    })

/**
 * Component - C42 - SC - Technical facilities and measures for ensuring quality
 */
Vue.component("C42 - SC",
                    { 
                        data(){
                            return {
 "options": [
  {
   "text": "Yes",
   "value": "yes"
  },
  {
   "text": "No",
   "value": "no"
  }
 ],
 "selected162": "yes",
 "selected163": "yes",
 "selected164": "yes",
 "selected165": "yes"
}
                        },
                        template: `<div>
                        <b-card title="C42 - SC - Technical facilities and measures for ensuring quality">
                            <b-card-text>It uses the following technical facilities and measures for ensuring quality and its study and research facilities are as follows:</b-card-text>
                        <b-card><p>[Name of the National Criterion] <em>[Description of the National Criterion ]</em> [<em>0..n</em>]</p>
                    <b-card class="my-1"> <p>Cardinality [<em>1</em>]</p><b-card-text>CAPTION - [Additional information; e.g. no evidences online]</b-card-text>
                                        <b-form-group label="QUESTION - Your Answer [1]">
                                            <b-form-radio-group id="radio-group-162" v-model="selected162" :options="options" name="radio-options162">
                                            </b-form-radio-group>
                                        </b-form-group>
                    </b-card></b-card><b-card-text class="my-1">LEGISLATION [<em>0..n</em>]</b-card-text><b-card><b-card-text>CAPTION - [Additional information; e.g. no evidences online]</b-card-text><b-card>
                    <b-form-group label="REQUIREMENT - Requirement [1]"
                    label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                    <b-form-input placeholder="DESCRIPTION"></b-form-input>
                    </b-form-group>
                    
                                            <b-form-group label="QUESTION - Does the EO fulfil the criteria by itself? [1]">
                                                <b-form-radio-group id="radio-group-163" v-model="selected163" :options="options" name="radio-options163">
                                                </b-form-radio-group>
                                            </b-form-group>
                                        <div v-if="selected163 ==='no'">
                                        <b-card class="my-1"> <p>Cardinality [<em>1</em>]</p>
                                            <b-form-group label="QUESTION - In the case of no – Relied upon or not [1]">
                                                <b-form-radio-group id="radio-group-164" v-model="selected164" :options="options" name="radio-options164">
                                                </b-form-radio-group>
                                            </b-form-group>
                                        <div v-if="selected164 ==='yes'">
                                        <b-card class="my-1"> <p>Cardinality [<em>1</em>]</p>
                                            <b-form-group label="QUESTION - Name of the entity [1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="DESCRIPTION"></b-form-input>
                                            </b-form-group>
                                            <b-form-group label="QUESTION - ID of the entity [1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="ECONOMIC_OPERATOR_IDENTIFIER"></b-form-input>
                                            </b-form-group>
                                        </b-card>
                                        </div>
                                        </b-card>
                                        </div>
                                            <b-form-group label="QUESTION - Please describe them [1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="DESCRIPTION"></b-form-input>
                                            </b-form-group>
                                            <b-form-group label="QUESTION - Is this information available electronically? [1]">
                                                <b-form-radio-group id="radio-group-165" v-model="selected165" :options="options" name="radio-options165">
                                                </b-form-radio-group>
                                            </b-form-group>
                                        <div v-if="selected165 ==='yes'">
                                        <b-card class="my-1"> <p>Cardinality [<em>0..1</em>]</p>
                                            <b-form-group label="QUESTION - Evidence Supplied [1..n]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="EVIDENCE_IDENTIFIER"></b-form-input>
                                            </b-form-group>
                                        </b-card>
                                        </div></b-card></b-card></b-card>
                    </div>`
                    })

/**
 * Component - C43 - SC - Study and research facilities
 */
Vue.component("C43 - SC",
                    { 
                        data(){
                            return {
 "options": [
  {
   "text": "Yes",
   "value": "yes"
  },
  {
   "text": "No",
   "value": "no"
  }
 ],
 "selected166": "yes",
 "selected167": "yes",
 "selected168": "yes",
 "selected169": "yes"
}
                        },
                        template: `<div>
                        <b-card title="C43 - SC - Study and research facilities">
                            <b-card-text>It uses the following study and research facilities are as follows:</b-card-text>
                        <b-card><p>[Name of the National Criterion] <em>[Description of the National Criterion ]</em> [<em>0..n</em>]</p>
                    <b-card class="my-1"> <p>Cardinality [<em>1</em>]</p><b-card-text>CAPTION - [Additional information; e.g. no evidences online]</b-card-text>
                                        <b-form-group label="QUESTION - Your Answer [1]">
                                            <b-form-radio-group id="radio-group-166" v-model="selected166" :options="options" name="radio-options166">
                                            </b-form-radio-group>
                                        </b-form-group>
                    </b-card></b-card><b-card-text class="my-1">LEGISLATION [<em>0..n</em>]</b-card-text><b-card><b-card-text>CAPTION - [Additional information; e.g. no evidences online]</b-card-text><b-card>
                    <b-form-group label="REQUIREMENT - Requirement [1]"
                    label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                    <b-form-input placeholder="DESCRIPTION"></b-form-input>
                    </b-form-group>
                    
                                            <b-form-group label="QUESTION - Does the EO fulfil the criteria by itself? [1]">
                                                <b-form-radio-group id="radio-group-167" v-model="selected167" :options="options" name="radio-options167">
                                                </b-form-radio-group>
                                            </b-form-group>
                                        <div v-if="selected167 ==='no'">
                                        <b-card class="my-1"> <p>Cardinality [<em>1</em>]</p>
                                            <b-form-group label="QUESTION - In the case of no – Relied upon or not [1]">
                                                <b-form-radio-group id="radio-group-168" v-model="selected168" :options="options" name="radio-options168">
                                                </b-form-radio-group>
                                            </b-form-group>
                                        <div v-if="selected168 ==='yes'">
                                        <b-card class="my-1"> <p>Cardinality [<em>1</em>]</p>
                                            <b-form-group label="QUESTION - Name of the entity [1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="DESCRIPTION"></b-form-input>
                                            </b-form-group>
                                            <b-form-group label="QUESTION - ID of the entity [1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="ECONOMIC_OPERATOR_IDENTIFIER"></b-form-input>
                                            </b-form-group>
                                        </b-card>
                                        </div>
                                        </b-card>
                                        </div>
                                            <b-form-group label="QUESTION - Please describe them [1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="DESCRIPTION"></b-form-input>
                                            </b-form-group>
                                            <b-form-group label="QUESTION - Is this information available electronically? [1]">
                                                <b-form-radio-group id="radio-group-169" v-model="selected169" :options="options" name="radio-options169">
                                                </b-form-radio-group>
                                            </b-form-group>
                                        <div v-if="selected169 ==='yes'">
                                        <b-card class="my-1"> <p>Cardinality [<em>0..1</em>]</p>
                                            <b-form-group label="QUESTION - Evidence Supplied [1..n]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="EVIDENCE_IDENTIFIER"></b-form-input>
                                            </b-form-group>
                                        </b-card>
                                        </div></b-card></b-card></b-card>
                    </div>`
                    })

/**
 * Component - C44 - SC - Supply chain management
 */
Vue.component("C44 - SC",
                    { 
                        data(){
                            return {
 "options": [
  {
   "text": "Yes",
   "value": "yes"
  },
  {
   "text": "No",
   "value": "no"
  }
 ],
 "selected170": "yes",
 "selected171": "yes",
 "selected172": "yes",
 "selected173": "yes"
}
                        },
                        template: `<div>
                        <b-card title="C44 - SC - Supply chain management">
                            <b-card-text>It will be able to apply the following supply chain management and tracking systems when performing the contract:</b-card-text>
                        <b-card><p>[Name of the National Criterion] <em>[Description of the National Criterion ]</em> [<em>0..n</em>]</p>
                    <b-card class="my-1"> <p>Cardinality [<em>1</em>]</p><b-card-text>CAPTION - [Additional information; e.g. no evidences online]</b-card-text>
                                        <b-form-group label="QUESTION - Your Answer [1]">
                                            <b-form-radio-group id="radio-group-170" v-model="selected170" :options="options" name="radio-options170">
                                            </b-form-radio-group>
                                        </b-form-group>
                    </b-card></b-card><b-card-text class="my-1">LEGISLATION [<em>0..n</em>]</b-card-text><b-card><b-card-text>CAPTION - [Additional information; e.g. no evidences online]</b-card-text><b-card>
                    <b-form-group label="REQUIREMENT - Requirement [1]"
                    label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                    <b-form-input placeholder="DESCRIPTION"></b-form-input>
                    </b-form-group>
                    
                                            <b-form-group label="QUESTION - Does the EO fulfil the criteria by itself? [1]">
                                                <b-form-radio-group id="radio-group-171" v-model="selected171" :options="options" name="radio-options171">
                                                </b-form-radio-group>
                                            </b-form-group>
                                        <div v-if="selected171 ==='no'">
                                        <b-card class="my-1"> <p>Cardinality [<em>1</em>]</p>
                                            <b-form-group label="QUESTION - In the case of no – Relied upon or not [1]">
                                                <b-form-radio-group id="radio-group-172" v-model="selected172" :options="options" name="radio-options172">
                                                </b-form-radio-group>
                                            </b-form-group>
                                        <div v-if="selected172 ==='yes'">
                                        <b-card class="my-1"> <p>Cardinality [<em>1</em>]</p>
                                            <b-form-group label="QUESTION - Name of the entity [1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="DESCRIPTION"></b-form-input>
                                            </b-form-group>
                                            <b-form-group label="QUESTION - ID of the entity [1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="ECONOMIC_OPERATOR_IDENTIFIER"></b-form-input>
                                            </b-form-group>
                                        </b-card>
                                        </div>
                                        </b-card>
                                        </div>
                                            <b-form-group label="QUESTION - Please describe them [1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="DESCRIPTION"></b-form-input>
                                            </b-form-group>
                                            <b-form-group label="QUESTION - Is this information available electronically? [1]">
                                                <b-form-radio-group id="radio-group-173" v-model="selected173" :options="options" name="radio-options173">
                                                </b-form-radio-group>
                                            </b-form-group>
                                        <div v-if="selected173 ==='yes'">
                                        <b-card class="my-1"> <p>Cardinality [<em>0..1</em>]</p>
                                            <b-form-group label="QUESTION - Evidence Supplied [1..n]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="EVIDENCE_IDENTIFIER"></b-form-input>
                                            </b-form-group>
                                        </b-card>
                                        </div></b-card></b-card></b-card>
                    </div>`
                    })

/**
 * Component - C45 - SC - Environmental management measures
 */
Vue.component("C45 - SC",
                    { 
                        data(){
                            return {
 "options": [
  {
   "text": "Yes",
   "value": "yes"
  },
  {
   "text": "No",
   "value": "no"
  }
 ],
 "selected174": "yes",
 "selected175": "yes",
 "selected176": "yes",
 "selected177": "yes"
}
                        },
                        template: `<div>
                        <b-card title="C45 - SC - Environmental management measures">
                            <b-card-text>The economic operator will be able to apply the following environmental management measures when performing the contract:</b-card-text>
                        <b-card><p>[Name of the National Criterion] <em>[Description of the National Criterion ]</em> [<em>0..n</em>]</p>
                    <b-card class="my-1"> <p>Cardinality [<em>1</em>]</p><b-card-text>CAPTION - [Additional information; e.g. no evidences online]</b-card-text>
                                        <b-form-group label="QUESTION - Your Answer [1]">
                                            <b-form-radio-group id="radio-group-174" v-model="selected174" :options="options" name="radio-options174">
                                            </b-form-radio-group>
                                        </b-form-group>
                    </b-card></b-card><b-card-text class="my-1">LEGISLATION [<em>0..n</em>]</b-card-text><b-card><b-card-text>CAPTION - [Additional information; e.g. no evidences online]</b-card-text><b-card>
                    <b-form-group label="REQUIREMENT - Requirement [1]"
                    label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                    <b-form-input placeholder="DESCRIPTION"></b-form-input>
                    </b-form-group>
                    
                                            <b-form-group label="QUESTION - Does the EO fulfil the criteria by itself? [1]">
                                                <b-form-radio-group id="radio-group-175" v-model="selected175" :options="options" name="radio-options175">
                                                </b-form-radio-group>
                                            </b-form-group>
                                        <div v-if="selected175 ==='no'">
                                        <b-card class="my-1"> <p>Cardinality [<em>1</em>]</p>
                                            <b-form-group label="QUESTION - In the case of no – Relied upon or not [1]">
                                                <b-form-radio-group id="radio-group-176" v-model="selected176" :options="options" name="radio-options176">
                                                </b-form-radio-group>
                                            </b-form-group>
                                        <div v-if="selected176 ==='yes'">
                                        <b-card class="my-1"> <p>Cardinality [<em>1</em>]</p>
                                            <b-form-group label="QUESTION - Name of the entity [1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="DESCRIPTION"></b-form-input>
                                            </b-form-group>
                                            <b-form-group label="QUESTION - ID of the entity [1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="ECONOMIC_OPERATOR_IDENTIFIER"></b-form-input>
                                            </b-form-group>
                                        </b-card>
                                        </div>
                                        </b-card>
                                        </div>
                                            <b-form-group label="QUESTION - Please describe them [1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="DESCRIPTION"></b-form-input>
                                            </b-form-group>
                                            <b-form-group label="QUESTION - Is this information available electronically? [1]">
                                                <b-form-radio-group id="radio-group-177" v-model="selected177" :options="options" name="radio-options177">
                                                </b-form-radio-group>
                                            </b-form-group>
                                        <div v-if="selected177 ==='yes'">
                                        <b-card class="my-1"> <p>Cardinality [<em>0..1</em>]</p>
                                            <b-form-group label="QUESTION - Evidence Supplied [1..n]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="EVIDENCE_IDENTIFIER"></b-form-input>
                                            </b-form-group>
                                        </b-card>
                                        </div></b-card></b-card></b-card>
                    </div>`
                    })

/**
 * Component - C46 - SC - Tools, plant or technical equipment
 */
Vue.component("C46 - SC",
                    { 
                        data(){
                            return {
 "options": [
  {
   "text": "Yes",
   "value": "yes"
  },
  {
   "text": "No",
   "value": "no"
  }
 ],
 "selected178": "yes",
 "selected179": "yes",
 "selected180": "yes",
 "selected181": "yes"
}
                        },
                        template: `<div>
                        <b-card title="C46 - SC - Tools, plant or technical equipment">
                            <b-card-text>The following tools, plant or technical equipment will be available to it for performing the contract:</b-card-text>
                        <b-card><p>[Name of the National Criterion] <em>[Description of the National Criterion ]</em> [<em>0..n</em>]</p>
                    <b-card class="my-1"> <p>Cardinality [<em>1</em>]</p><b-card-text>CAPTION - [Additional information; e.g. no evidences online]</b-card-text>
                                        <b-form-group label="QUESTION - Your Answer [1]">
                                            <b-form-radio-group id="radio-group-178" v-model="selected178" :options="options" name="radio-options178">
                                            </b-form-radio-group>
                                        </b-form-group>
                    </b-card></b-card><b-card-text class="my-1">LEGISLATION [<em>0..n</em>]</b-card-text><b-card><b-card-text>CAPTION - [Additional information; e.g. no evidences online]</b-card-text><b-card>
                    <b-form-group label="REQUIREMENT - Requirement [1]"
                    label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                    <b-form-input placeholder="DESCRIPTION"></b-form-input>
                    </b-form-group>
                    
                                            <b-form-group label="QUESTION - Does the EO fulfil the criteria by itself? [1]">
                                                <b-form-radio-group id="radio-group-179" v-model="selected179" :options="options" name="radio-options179">
                                                </b-form-radio-group>
                                            </b-form-group>
                                        <div v-if="selected179 ==='no'">
                                        <b-card class="my-1"> <p>Cardinality [<em>1</em>]</p>
                                            <b-form-group label="QUESTION - In the case of no – Relied upon or not [1]">
                                                <b-form-radio-group id="radio-group-180" v-model="selected180" :options="options" name="radio-options180">
                                                </b-form-radio-group>
                                            </b-form-group>
                                        <div v-if="selected180 ==='yes'">
                                        <b-card class="my-1"> <p>Cardinality [<em>1</em>]</p>
                                            <b-form-group label="QUESTION - Name of the entity [1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="DESCRIPTION"></b-form-input>
                                            </b-form-group>
                                            <b-form-group label="QUESTION - ID of the entity [1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="ECONOMIC_OPERATOR_IDENTIFIER"></b-form-input>
                                            </b-form-group>
                                        </b-card>
                                        </div>
                                        </b-card>
                                        </div>
                                            <b-form-group label="QUESTION - Please describe them [1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="DESCRIPTION"></b-form-input>
                                            </b-form-group>
                                            <b-form-group label="QUESTION - Is this information available electronically? [1]">
                                                <b-form-radio-group id="radio-group-181" v-model="selected181" :options="options" name="radio-options181">
                                                </b-form-radio-group>
                                            </b-form-group>
                                        <div v-if="selected181 ==='yes'">
                                        <b-card class="my-1"> <p>Cardinality [<em>0..1</em>]</p>
                                            <b-form-group label="QUESTION - Evidence Supplied [1..n]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="EVIDENCE_IDENTIFIER"></b-form-input>
                                            </b-form-group>
                                        </b-card>
                                        </div></b-card></b-card></b-card>
                    </div>`
                    })

/**
 * Component - C47 - SC - Educational and professional qualifications
 */
Vue.component("C47 - SC",
                    { 
                        data(){
                            return {
 "options": [
  {
   "text": "Yes",
   "value": "yes"
  },
  {
   "text": "No",
   "value": "no"
  }
 ],
 "selected182": "yes",
 "selected183": "yes",
 "selected184": "yes",
 "selected185": "yes"
}
                        },
                        template: `<div>
                        <b-card title="C47 - SC - Educational and professional qualifications">
                            <b-card-text>The following educational and professional qualifications are held by the service provider or the contractor itself, and/or (depending on the requirements set out in the relevant notice or the in the ESPD, the relevant notice or by its managerial staff.</b-card-text>
                        <b-card><p>[Name of the National Criterion] <em>[Description of the National Criterion ]</em> [<em>0..n</em>]</p>
                    <b-card class="my-1"> <p>Cardinality [<em>1</em>]</p><b-card-text>CAPTION - [Additional information; e.g. no evidences online]</b-card-text>
                                        <b-form-group label="QUESTION - Your Answer [1]">
                                            <b-form-radio-group id="radio-group-182" v-model="selected182" :options="options" name="radio-options182">
                                            </b-form-radio-group>
                                        </b-form-group>
                    </b-card></b-card><b-card-text class="my-1">LEGISLATION [<em>0..n</em>]</b-card-text><b-card><b-card-text>CAPTION - [Additional information; e.g. no evidences online]</b-card-text><b-card>
                    <b-form-group label="REQUIREMENT - Requirement [1]"
                    label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                    <b-form-input placeholder="DESCRIPTION"></b-form-input>
                    </b-form-group>
                    
                                            <b-form-group label="QUESTION - Does the EO fulfil the criteria by itself? [1]">
                                                <b-form-radio-group id="radio-group-183" v-model="selected183" :options="options" name="radio-options183">
                                                </b-form-radio-group>
                                            </b-form-group>
                                        <div v-if="selected183 ==='no'">
                                        <b-card class="my-1"> <p>Cardinality [<em>1</em>]</p>
                                            <b-form-group label="QUESTION - In the case of no – Relied upon or not [1]">
                                                <b-form-radio-group id="radio-group-184" v-model="selected184" :options="options" name="radio-options184">
                                                </b-form-radio-group>
                                            </b-form-group>
                                        <div v-if="selected184 ==='yes'">
                                        <b-card class="my-1"> <p>Cardinality [<em>1</em>]</p>
                                            <b-form-group label="QUESTION - Name of the entity [1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="DESCRIPTION"></b-form-input>
                                            </b-form-group>
                                            <b-form-group label="QUESTION - ID of the entity [1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="ECONOMIC_OPERATOR_IDENTIFIER"></b-form-input>
                                            </b-form-group>
                                        </b-card>
                                        </div>
                                        </b-card>
                                        </div><b-card-text>CAPTION - undefined</b-card-text><b-card class="my-1"> <p>Cardinality [<em>0..n</em>]</p>
                                            <b-form-group label="QUESTION - First name [0..1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="DESCRIPTION"></b-form-input>
                                            </b-form-group>
                                            <b-form-group label="QUESTION - Last name [0..1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="DESCRIPTION"></b-form-input>
                                            </b-form-group>
                                            <b-form-group label="QUESTION - Please describe the educational or professional qualification [1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="DESCRIPTION"></b-form-input>
                                            </b-form-group>
                                            <b-form-group label="QUESTION - If possible please indicate the ESCO identifier for this qualification [0..1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="URL"></b-form-input>
                                            </b-form-group>
                                            <b-form-group label="QUESTION - If possible please describe the ESCO qualification [0..1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="DESCRIPTION"></b-form-input>
                                            </b-form-group>
                                            <b-form-group label="QUESTION - Qualification name [0..1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="DESCRIPTION"></b-form-input>
                                            </b-form-group>
                                            <b-form-group label="QUESTION - Qualification number [0..1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="QUAL_IDENTIFIER"></b-form-input>
                                            </b-form-group>
                                            <b-form-group label="QUESTION - Qualification issuing date [0..1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="DATE"></b-form-input>
                                            </b-form-group>
                                            <b-form-group label="QUESTION - Qualification issuing body [0..1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="DESCRIPTION"></b-form-input>
                                            </b-form-group><b-card class="my-1"> <p>Cardinality [<em>1</em>]</p>
                                            <b-form-group label="QUESTION - Is this information available online? [1]">
                                                <b-form-radio-group id="radio-group-185" v-model="selected185" :options="options" name="radio-options185">
                                                </b-form-radio-group>
                                            </b-form-group>
                                        <div v-if="selected185 ==='yes'">
                                        <b-card class="my-1"> <p>Cardinality [<em>0..1</em>]</p>
                                            <b-form-group label="QUESTION - Evidence Supplied [1..n]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="EVIDENCE_IDENTIFIER"></b-form-input>
                                            </b-form-group>
                                        </b-card>
                                        </div></b-card></b-card></b-card></b-card></b-card>
                    </div>`
                    })

/**
 * Component - C48 - SC - Special requierements check
 */
Vue.component("C48 - SC",
                    { 
                        data(){
                            return {
 "options": [
  {
   "text": "Yes",
   "value": "yes"
  },
  {
   "text": "No",
   "value": "no"
  }
 ],
 "selected186": "yes",
 "selected187": "yes",
 "selected188": "yes",
 "selected189": "yes",
 "selected190": "yes"
}
                        },
                        template: `<div>
                        <b-card title="C48 - SC - Special requierements check">
                            <b-card-text>For complex products or services to be supplied or, exceptionally, for products or services which are required for a special purpose: The economic operator will allow checks to be conducted on the production capacities or the technical capacity of the economic operator and, where necessary, on the means of study and research which are available to it and on the quality control measures? The check is to be performed by the contracting authority or, in case the latter consents to this, on its behalf by a competent official body of the country in which the supplier or service provider is established.</b-card-text>
                        <b-card><p>[Name of the National Criterion] <em>[Description of the National Criterion ]</em> [<em>0..n</em>]</p>
                    <b-card class="my-1"> <p>Cardinality [<em>1</em>]</p><b-card-text>CAPTION - [Additional information; e.g. no evidences online]</b-card-text>
                                        <b-form-group label="QUESTION - Your Answer [1]">
                                            <b-form-radio-group id="radio-group-186" v-model="selected186" :options="options" name="radio-options186">
                                            </b-form-radio-group>
                                        </b-form-group>
                    </b-card></b-card><b-card-text class="my-1">LEGISLATION [<em>0..n</em>]</b-card-text><b-card>
                    <b-form-group label="REQUIREMENT - Requirement [1]"
                    label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                    <b-form-input placeholder="DESCRIPTION"></b-form-input>
                    </b-form-group>
                    
                                            <b-form-group label="QUESTION - Does the EO fulfil the criteria by itself? [1]">
                                                <b-form-radio-group id="radio-group-187" v-model="selected187" :options="options" name="radio-options187">
                                                </b-form-radio-group>
                                            </b-form-group>
                                        <div v-if="selected187 ==='no'">
                                        <b-card class="my-1"> <p>Cardinality [<em>1</em>]</p>
                                            <b-form-group label="QUESTION - In the case of no – Relied upon or not [1]">
                                                <b-form-radio-group id="radio-group-188" v-model="selected188" :options="options" name="radio-options188">
                                                </b-form-radio-group>
                                            </b-form-group>
                                        <div v-if="selected188 ==='yes'">
                                        <b-card class="my-1"> <p>Cardinality [<em>1</em>]</p>
                                            <b-form-group label="QUESTION - Name of the entity [1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="DESCRIPTION"></b-form-input>
                                            </b-form-group>
                                            <b-form-group label="QUESTION - ID of the entity [1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="ECONOMIC_OPERATOR_IDENTIFIER"></b-form-input>
                                            </b-form-group>
                                        </b-card>
                                        </div>
                                        </b-card>
                                        </div>
                                            <b-form-group label="QUESTION - Do you allow checks? [1]">
                                                <b-form-radio-group id="radio-group-189" v-model="selected189" :options="options" name="radio-options189">
                                                </b-form-radio-group>
                                            </b-form-group>
                                            <b-form-group label="QUESTION - Is this information available online? [1]">
                                                <b-form-radio-group id="radio-group-190" v-model="selected190" :options="options" name="radio-options190">
                                                </b-form-radio-group>
                                            </b-form-group>
                                        <div v-if="selected190 ==='yes'">
                                        <b-card class="my-1"> <p>Cardinality [<em>0..1</em>]</p>
                                            <b-form-group label="QUESTION - Evidence Supplied [1..n]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="EVIDENCE_IDENTIFIER"></b-form-input>
                                            </b-form-group>
                                        </b-card>
                                        </div></b-card></b-card>
                    </div>`
                    })

/**
 * Component - C49 - SC - Number of managerial staff
 */
Vue.component("C49 - SC",
                    { 
                        data(){
                            return {
 "options": [
  {
   "text": "Yes",
   "value": "yes"
  },
  {
   "text": "No",
   "value": "no"
  }
 ],
 "selected191": "yes",
 "selected192": "yes",
 "selected193": "yes",
 "selected194": "yes"
}
                        },
                        template: `<div>
                        <b-card title="C49 - SC - Number of managerial staff">
                            <b-card-text>The economic operator’s number of managerial staff for the last three years were as follows:</b-card-text>
                        <b-card><p>[Name of the National Criterion] <em>[Description of the National Criterion ]</em> [<em>0..n</em>]</p>
                    <b-card class="my-1"> <p>Cardinality [<em>1</em>]</p><b-card-text>CAPTION - [Additional information; e.g. no evidences online]</b-card-text>
                                        <b-form-group label="QUESTION - Your Answer [1]">
                                            <b-form-radio-group id="radio-group-191" v-model="selected191" :options="options" name="radio-options191">
                                            </b-form-radio-group>
                                        </b-form-group>
                    </b-card></b-card><b-card-text class="my-1">LEGISLATION [<em>0..n</em>]</b-card-text><b-card>
                    <b-form-group label="REQUIREMENT - Minimum number of years [1]"
                    label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                    <b-form-input placeholder="QUANTITY_YEAR"></b-form-input>
                    </b-form-group>
                    
                    <b-form-group label="REQUIREMENT - Additional information [0..1]"
                    label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                    <b-form-input placeholder="DESCRIPTION"></b-form-input>
                    </b-form-group>
                    
                                            <b-form-group label="QUESTION - Does the EO fulfil the criteria by itself? [1]">
                                                <b-form-radio-group id="radio-group-192" v-model="selected192" :options="options" name="radio-options192">
                                                </b-form-radio-group>
                                            </b-form-group>
                                        <div v-if="selected192 ==='no'">
                                        <b-card class="my-1"> <p>Cardinality [<em>1</em>]</p>
                                            <b-form-group label="QUESTION - In the case of no – Relied upon or not [1]">
                                                <b-form-radio-group id="radio-group-193" v-model="selected193" :options="options" name="radio-options193">
                                                </b-form-radio-group>
                                            </b-form-group>
                                        <div v-if="selected193 ==='yes'">
                                        <b-card class="my-1"> <p>Cardinality [<em>1</em>]</p>
                                            <b-form-group label="QUESTION - Name of the entity [1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="DESCRIPTION"></b-form-input>
                                            </b-form-group>
                                            <b-form-group label="QUESTION - ID of the entity [1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="ECONOMIC_OPERATOR_IDENTIFIER"></b-form-input>
                                            </b-form-group>
                                        </b-card>
                                        </div>
                                        </b-card>
                                        </div>
                                            <b-form-group label="QUESTION - Year [1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="QUANTITY_YEAR"></b-form-input>
                                            </b-form-group>
                                            <b-form-group label="QUESTION - Number [1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="QUANTITY_YEAR"></b-form-input>
                                            </b-form-group>
                                            <b-form-group label="QUESTION - Is this information available online? [1]">
                                                <b-form-radio-group id="radio-group-194" v-model="selected194" :options="options" name="radio-options194">
                                                </b-form-radio-group>
                                            </b-form-group>
                                        <div v-if="selected194 ==='yes'">
                                        <b-card class="my-1"> <p>Cardinality [<em>0..1</em>]</p>
                                            <b-form-group label="QUESTION - Evidence Supplied [1..n]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="EVIDENCE_IDENTIFIER"></b-form-input>
                                            </b-form-group>
                                        </b-card>
                                        </div></b-card></b-card>
                    </div>`
                    })

/**
 * Component - C50 - SC - Average annual manpower
 */
Vue.component("C50 - SC",
                    { 
                        data(){
                            return {
 "options": [
  {
   "text": "Yes",
   "value": "yes"
  },
  {
   "text": "No",
   "value": "no"
  }
 ],
 "selected195": "yes",
 "selected196": "yes",
 "selected197": "yes",
 "selected198": "yes"
}
                        },
                        template: `<div>
                        <b-card title="C50 - SC - Average annual manpower">
                            <b-card-text>The economic operator’s average annual manpower for the last three years were as follows:</b-card-text>
                        <b-card><p>[Name of the National Criterion] <em>[Description of the National Criterion ]</em> [<em>0..n</em>]</p>
                    <b-card class="my-1"> <p>Cardinality [<em>1</em>]</p><b-card-text>CAPTION - [Additional information; e.g. no evidences online]</b-card-text>
                                        <b-form-group label="QUESTION - Your Answer [1]">
                                            <b-form-radio-group id="radio-group-195" v-model="selected195" :options="options" name="radio-options195">
                                            </b-form-radio-group>
                                        </b-form-group>
                    </b-card></b-card><b-card-text class="my-1">LEGISLATION [<em>0..n</em>]</b-card-text><b-card>
                    <b-form-group label="REQUIREMENT - Minimum number of years [1]"
                    label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                    <b-form-input placeholder="QUANTITY_YEAR"></b-form-input>
                    </b-form-group>
                    
                    <b-form-group label="REQUIREMENT - Additional information [0..1]"
                    label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                    <b-form-input placeholder="DESCRIPTION"></b-form-input>
                    </b-form-group>
                    
                                            <b-form-group label="QUESTION - Does the EO fulfil the criteria by itself? [1]">
                                                <b-form-radio-group id="radio-group-196" v-model="selected196" :options="options" name="radio-options196">
                                                </b-form-radio-group>
                                            </b-form-group>
                                        <div v-if="selected196 ==='no'">
                                        <b-card class="my-1"> <p>Cardinality [<em>1</em>]</p>
                                            <b-form-group label="QUESTION - In the case of no – Relied upon or not [1]">
                                                <b-form-radio-group id="radio-group-197" v-model="selected197" :options="options" name="radio-options197">
                                                </b-form-radio-group>
                                            </b-form-group>
                                        <div v-if="selected197 ==='yes'">
                                        <b-card class="my-1"> <p>Cardinality [<em>1</em>]</p>
                                            <b-form-group label="QUESTION - Name of the entity [1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="DESCRIPTION"></b-form-input>
                                            </b-form-group>
                                            <b-form-group label="QUESTION - ID of the entity [1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="ECONOMIC_OPERATOR_IDENTIFIER"></b-form-input>
                                            </b-form-group>
                                        </b-card>
                                        </div>
                                        </b-card>
                                        </div>
                                            <b-form-group label="QUESTION - Year [1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="QUANTITY_YEAR"></b-form-input>
                                            </b-form-group>
                                            <b-form-group label="QUESTION - Number [1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="QUANTITY_YEAR"></b-form-input>
                                            </b-form-group>
                                            <b-form-group label="QUESTION - Is this information available online? [1]">
                                                <b-form-radio-group id="radio-group-198" v-model="selected198" :options="options" name="radio-options198">
                                                </b-form-radio-group>
                                            </b-form-group>
                                        <div v-if="selected198 ==='yes'">
                                        <b-card class="my-1"> <p>Cardinality [<em>0..1</em>]</p>
                                            <b-form-group label="QUESTION - Evidence Supplied [1..n]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="EVIDENCE_IDENTIFIER"></b-form-input>
                                            </b-form-group>
                                        </b-card>
                                        </div></b-card></b-card>
                    </div>`
                    })

/**
 * Component - C51 - SC - Subcontracting proportion
 */
Vue.component("C51 - SC",
                    { 
                        data(){
                            return {
 "options": [
  {
   "text": "Yes",
   "value": "yes"
  },
  {
   "text": "No",
   "value": "no"
  }
 ],
 "selected199": "yes",
 "selected200": "yes",
 "selected201": "yes",
 "selected202": "yes"
}
                        },
                        template: `<div>
                        <b-card title="C51 - SC - Subcontracting proportion">
                            <b-card-text>The economic operator intends possibly to subcontract the following proportion (i.e. percentage) of the contract. Please note that if the economic operator has decided to subcontract a part of the contract and relies on the subcontractor’s capacities to perform that part, then please fill in a separate ESPD for such subcontractors, see Part II, Section C above.</b-card-text>
                        <b-card><p>[Name of the National Criterion] <em>[Description of the National Criterion ]</em> [<em>0..n</em>]</p>
                    <b-card class="my-1"> <p>Cardinality [<em>1</em>]</p><b-card-text>CAPTION - [Additional information; e.g. no evidences online]</b-card-text>
                                        <b-form-group label="QUESTION - Your Answer [1]">
                                            <b-form-radio-group id="radio-group-199" v-model="selected199" :options="options" name="radio-options199">
                                            </b-form-radio-group>
                                        </b-form-group>
                    </b-card></b-card><b-card-text class="my-1">LEGISLATION [<em>0..n</em>]</b-card-text>
                    <b-card class="my-1"> <p>Cardinality [<em>1</em>]</p>
                                        <b-form-group label="QUESTION - Does the EO fulfil the criteria by itself? [1]">
                                            <b-form-radio-group id="radio-group-200" v-model="selected200" :options="options" name="radio-options200">
                                            </b-form-radio-group>
                                        </b-form-group>
                                    <div v-if="selected200 ==='no'">
                                    <b-card class="my-1"> <p>Cardinality [<em>1</em>]</p>
                                            <b-form-group label="QUESTION - In the case of no – Relied upon or not [1]">
                                                <b-form-radio-group id="radio-group-201" v-model="selected201" :options="options" name="radio-options201">
                                                </b-form-radio-group>
                                            </b-form-group>
                                        <div v-if="selected201 ==='yes'">
                                        <b-card class="my-1"> <p>Cardinality [<em>1</em>]</p>
                                            <b-form-group label="QUESTION - Name of the entity [1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="DESCRIPTION"></b-form-input>
                                            </b-form-group>
                                            <b-form-group label="QUESTION - ID of the entity [1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="ECONOMIC_OPERATOR_IDENTIFIER"></b-form-input>
                                            </b-form-group>
                                        </b-card>
                                        </div>
                                    </b-card>
                                    </div>
                    </b-card>
                    <b-card class="my-1"> <p>Cardinality [<em>1</em>]</p>
                                        <b-form-group label="QUESTION - Please specify [1]" 
                                        label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                        <b-form-input placeholder="DESCRIPTION"></b-form-input>
                                        </b-form-group>
                    </b-card>
                    <b-card class="my-1"> <p>Cardinality [<em>1</em>]</p>
                                        <b-form-group label="QUESTION - Is this information available electronically? [1]">
                                            <b-form-radio-group id="radio-group-202" v-model="selected202" :options="options" name="radio-options202">
                                            </b-form-radio-group>
                                        </b-form-group>
                                    <div v-if="selected202 ==='yes'">
                                    <b-card class="my-1"> <p>Cardinality [<em>0..1</em>]</p>
                                            <b-form-group label="QUESTION - Evidence Supplied [1..n]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="EVIDENCE_IDENTIFIER"></b-form-input>
                                            </b-form-group>
                                    </b-card>
                                    </div>
                    </b-card></b-card>
                    </div>`
                    })

/**
 * Component - C52 - SC - For supply contracts: samples, descriptions or photographs without certification of authenticity
 */
Vue.component("C52 - SC",
                    { 
                        data(){
                            return {
 "options": [
  {
   "text": "Yes",
   "value": "yes"
  },
  {
   "text": "No",
   "value": "no"
  }
 ],
 "selected203": "yes",
 "selected204": "yes",
 "selected205": "yes",
 "selected206": "yes",
 "selected207": "yes"
}
                        },
                        template: `<div>
                        <b-card title="C52 - SC - For supply contracts: samples, descriptions or photographs without certification of authenticity">
                            <b-card-text>For public supply contracts: The economic operator will supply the required samples, descriptions or photographs of the products to be supplied, which do not need to be accompanied by certifications of authenticity.</b-card-text>
                        <b-card><p>[Name of the National Criterion] <em>[Description of the National Criterion ]</em> [<em>0..n</em>]</p>
                    <b-card class="my-1"> <p>Cardinality [<em>1</em>]</p><b-card-text>CAPTION - [Additional information; e.g. no evidences online]</b-card-text>
                                        <b-form-group label="QUESTION - Your Answer [1]">
                                            <b-form-radio-group id="radio-group-203" v-model="selected203" :options="options" name="radio-options203">
                                            </b-form-radio-group>
                                        </b-form-group>
                    </b-card></b-card><b-card-text class="my-1">LEGISLATION [<em>0..n</em>]</b-card-text>
                    <b-card class="my-1"> <p>Cardinality [<em>1</em>]</p>
                                        <b-form-group label="QUESTION - Does the EO fulfil the criteria by itself? [1]">
                                            <b-form-radio-group id="radio-group-204" v-model="selected204" :options="options" name="radio-options204">
                                            </b-form-radio-group>
                                        </b-form-group>
                                    <div v-if="selected204 ==='no'">
                                    <b-card class="my-1"> <p>Cardinality [<em>1</em>]</p>
                                            <b-form-group label="QUESTION - In the case of no – Relied upon or not [1]">
                                                <b-form-radio-group id="radio-group-205" v-model="selected205" :options="options" name="radio-options205">
                                                </b-form-radio-group>
                                            </b-form-group>
                                        <div v-if="selected205 ==='yes'">
                                        <b-card class="my-1"> <p>Cardinality [<em>1</em>]</p>
                                            <b-form-group label="QUESTION - Name of the entity [1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="DESCRIPTION"></b-form-input>
                                            </b-form-group>
                                            <b-form-group label="QUESTION - ID of the entity [1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="ECONOMIC_OPERATOR_IDENTIFIER"></b-form-input>
                                            </b-form-group>
                                        </b-card>
                                        </div>
                                    </b-card>
                                    </div>
                    </b-card>
                    <b-card class="my-1"> <p>Cardinality [<em>1</em>]</p>
                                        <b-form-group label="QUESTION - Your answer? [1]">
                                            <b-form-radio-group id="radio-group-206" v-model="selected206" :options="options" name="radio-options206">
                                            </b-form-radio-group>
                                        </b-form-group>
                    </b-card>
                    <b-card class="my-1"> <p>Cardinality [<em>1</em>]</p>
                                        <b-form-group label="QUESTION - Is this information available electronically? [1]">
                                            <b-form-radio-group id="radio-group-207" v-model="selected207" :options="options" name="radio-options207">
                                            </b-form-radio-group>
                                        </b-form-group>
                                    <div v-if="selected207 ==='yes'">
                                    <b-card class="my-1"> <p>Cardinality [<em>0..1</em>]</p>
                                            <b-form-group label="QUESTION - Evidence Supplied [1..n]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="EVIDENCE_IDENTIFIER"></b-form-input>
                                            </b-form-group>
                                    </b-card>
                                    </div>
                    </b-card></b-card>
                    </div>`
                    })

/**
 * Component - C53 - SC - For supply contracts: samples, descriptions or photographs with certification of authenticity
 */
Vue.component("C53 - SC",
                    { 
                        data(){
                            return {
 "options": [
  {
   "text": "Yes",
   "value": "yes"
  },
  {
   "text": "No",
   "value": "no"
  }
 ],
 "selected208": "yes",
 "selected209": "yes",
 "selected210": "yes",
 "selected211": "yes",
 "selected212": "yes"
}
                        },
                        template: `<div>
                        <b-card title="C53 - SC - For supply contracts: samples, descriptions or photographs with certification of authenticity">
                            <b-card-text>For public supply contracts: The economic operator will supply the required samples, descriptions or photographs of the products to be supplied and will provide certifications of authenticity where applicable.</b-card-text>
                        <b-card><p>[Name of the National Criterion] <em>[Description of the National Criterion ]</em> [<em>0..n</em>]</p>
                    <b-card class="my-1"> <p>Cardinality [<em>1</em>]</p><b-card-text>CAPTION - [Additional information; e.g. no evidences online]</b-card-text>
                                        <b-form-group label="QUESTION - Your Answer [1]">
                                            <b-form-radio-group id="radio-group-208" v-model="selected208" :options="options" name="radio-options208">
                                            </b-form-radio-group>
                                        </b-form-group>
                    </b-card></b-card><b-card-text class="my-1">LEGISLATION [<em>0..n</em>]</b-card-text>
                    <b-card class="my-1"> <p>Cardinality [<em>1</em>]</p>
                                        <b-form-group label="QUESTION - Does the EO fulfil the criteria by itself? [1]">
                                            <b-form-radio-group id="radio-group-209" v-model="selected209" :options="options" name="radio-options209">
                                            </b-form-radio-group>
                                        </b-form-group>
                                    <div v-if="selected209 ==='no'">
                                    <b-card class="my-1"> <p>Cardinality [<em>1</em>]</p>
                                            <b-form-group label="QUESTION - In the case of no – Relied upon or not [1]">
                                                <b-form-radio-group id="radio-group-210" v-model="selected210" :options="options" name="radio-options210">
                                                </b-form-radio-group>
                                            </b-form-group>
                                        <div v-if="selected210 ==='yes'">
                                        <b-card class="my-1"> <p>Cardinality [<em>1</em>]</p>
                                            <b-form-group label="QUESTION - Name of the entity [1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="DESCRIPTION"></b-form-input>
                                            </b-form-group>
                                            <b-form-group label="QUESTION - ID of the entity [1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="ECONOMIC_OPERATOR_IDENTIFIER"></b-form-input>
                                            </b-form-group>
                                        </b-card>
                                        </div>
                                    </b-card>
                                    </div>
                    </b-card>
                    <b-card class="my-1"> <p>Cardinality [<em>1</em>]</p>
                                        <b-form-group label="QUESTION - Your answer? [1]">
                                            <b-form-radio-group id="radio-group-211" v-model="selected211" :options="options" name="radio-options211">
                                            </b-form-radio-group>
                                        </b-form-group>
                    </b-card>
                    <b-card class="my-1"> <p>Cardinality [<em>1</em>]</p>
                                        <b-form-group label="QUESTION - Is this information available electronically? [1]">
                                            <b-form-radio-group id="radio-group-212" v-model="selected212" :options="options" name="radio-options212">
                                            </b-form-radio-group>
                                        </b-form-group>
                                    <div v-if="selected212 ==='yes'">
                                    <b-card class="my-1"> <p>Cardinality [<em>0..1</em>]</p>
                                            <b-form-group label="QUESTION - Evidence Supplied [1..n]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="EVIDENCE_IDENTIFIER"></b-form-input>
                                            </b-form-group>
                                    </b-card>
                                    </div>
                    </b-card></b-card>
                    </div>`
                    })

/**
 * Component - C54 - SC - For supply contracts: certificates by quality control institutes
 */
Vue.component("C54 - SC",
                    { 
                        data(){
                            return {
 "options": [
  {
   "text": "Yes",
   "value": "yes"
  },
  {
   "text": "No",
   "value": "no"
  }
 ],
 "selected213": "yes",
 "selected214": "yes",
 "selected215": "yes",
 "selected216": "yes",
 "selected217": "yes"
}
                        },
                        template: `<div>
                        <b-card title="C54 - SC - For supply contracts: certificates by quality control institutes">
                            <b-card-text>Can the economic operator provide the required certificates drawn up by official quality control institutes or agencies of recognised competence attesting the conformity of products clearly identified by references to the technical specifications or standards, which are set out in the relevant notice or the in the ESPD, the relevant notice or ?</b-card-text>
                        <b-card><p>[Name of the National Criterion] <em>[Description of the National Criterion ]</em> [<em>0..n</em>]</p>
                    <b-card class="my-1"> <p>Cardinality [<em>1</em>]</p><b-card-text>CAPTION - [Additional information; e.g. no evidences online]</b-card-text>
                                        <b-form-group label="QUESTION - Your Answer [1]">
                                            <b-form-radio-group id="radio-group-213" v-model="selected213" :options="options" name="radio-options213">
                                            </b-form-radio-group>
                                        </b-form-group>
                    </b-card></b-card><b-card-text class="my-1">LEGISLATION [<em>0..n</em>]</b-card-text><b-card>
                    <b-form-group label="REQUIREMENT - Requirement [1]"
                    label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                    <b-form-input placeholder="DESCRIPTION"></b-form-input>
                    </b-form-group>
                    
                                            <b-form-group label="QUESTION - Does the EO fulfil the criteria by itself? [1]">
                                                <b-form-radio-group id="radio-group-214" v-model="selected214" :options="options" name="radio-options214">
                                                </b-form-radio-group>
                                            </b-form-group>
                                        <div v-if="selected214 ==='no'">
                                        <b-card class="my-1"> <p>Cardinality [<em>1</em>]</p>
                                            <b-form-group label="QUESTION - In the case of no – Relied upon or not [1]">
                                                <b-form-radio-group id="radio-group-215" v-model="selected215" :options="options" name="radio-options215">
                                                </b-form-radio-group>
                                            </b-form-group>
                                        <div v-if="selected215 ==='yes'">
                                        <b-card class="my-1"> <p>Cardinality [<em>1</em>]</p>
                                            <b-form-group label="QUESTION - Name of the entity [1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="DESCRIPTION"></b-form-input>
                                            </b-form-group>
                                            <b-form-group label="QUESTION - ID of the entity [1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="ECONOMIC_OPERATOR_IDENTIFIER"></b-form-input>
                                            </b-form-group>
                                        </b-card>
                                        </div>
                                        </b-card>
                                        </div>
                                            <b-form-group label="QUESTION - Your answer? [1]">
                                                <b-form-radio-group id="radio-group-216" v-model="selected216" :options="options" name="radio-options216">
                                                </b-form-radio-group>
                                            </b-form-group>
                                        <div v-if="selected216 ==='no'">
                                        <b-card class="my-1"> <p>Cardinality [<em>1</em>]</p>
                                            <b-form-group label="QUESTION - If not, please explain why and state which other means of proof can be provided: [1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="DESCRIPTION"></b-form-input>
                                            </b-form-group>
                                        </b-card>
                                        </div>
                                            <b-form-group label="QUESTION - Is this information available online? [1]">
                                                <b-form-radio-group id="radio-group-217" v-model="selected217" :options="options" name="radio-options217">
                                                </b-form-radio-group>
                                            </b-form-group>
                                        <div v-if="selected217 ==='yes'">
                                        <b-card class="my-1"> <p>Cardinality [<em>0..1</em>]</p>
                                            <b-form-group label="QUESTION - Evidence Supplied [1..n]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="EVIDENCE_IDENTIFIER"></b-form-input>
                                            </b-form-group>
                                        </b-card>
                                        </div></b-card></b-card>
                    </div>`
                    })

/**
 * Component - C55 - SC - Certificates by independent bodies about quality assurance standards
 */
Vue.component("C55 - SC",
                    { 
                        data(){
                            return {
 "options": [
  {
   "text": "Yes",
   "value": "yes"
  },
  {
   "text": "No",
   "value": "no"
  }
 ],
 "selected218": "yes",
 "selected219": "yes",
 "selected220": "yes",
 "selected221": "yes",
 "selected222": "yes"
}
                        },
                        template: `<div>
                        <b-card title="C55 - SC - Certificates by independent bodies about quality assurance standards">
                            <b-card-text>Will the economic operator be able to produce certificates drawn up by independent bodies attesting that the economic operator complies with the required quality assurance standards, including accessibility for disabled persons?</b-card-text>
                        <b-card><p>[Name of the National Criterion] <em>[Description of the National Criterion ]</em> [<em>0..n</em>]</p>
                    <b-card class="my-1"> <p>Cardinality [<em>1</em>]</p><b-card-text>CAPTION - [Additional information; e.g. no evidences online]</b-card-text>
                                        <b-form-group label="QUESTION - Your Answer [1]">
                                            <b-form-radio-group id="radio-group-218" v-model="selected218" :options="options" name="radio-options218">
                                            </b-form-radio-group>
                                        </b-form-group>
                    </b-card></b-card><b-card-text class="my-1">LEGISLATION [<em>0..n</em>]</b-card-text><b-card>
                    <b-form-group label="REQUIREMENT - Requirement [1]"
                    label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                    <b-form-input placeholder="DESCRIPTION"></b-form-input>
                    </b-form-group>
                    
                                            <b-form-group label="QUESTION - Does the EO fulfil the criteria by itself? [1]">
                                                <b-form-radio-group id="radio-group-219" v-model="selected219" :options="options" name="radio-options219">
                                                </b-form-radio-group>
                                            </b-form-group>
                                        <div v-if="selected219 ==='no'">
                                        <b-card class="my-1"> <p>Cardinality [<em>1</em>]</p>
                                            <b-form-group label="QUESTION - In the case of no – Relied upon or not [1]">
                                                <b-form-radio-group id="radio-group-220" v-model="selected220" :options="options" name="radio-options220">
                                                </b-form-radio-group>
                                            </b-form-group>
                                        <div v-if="selected220 ==='yes'">
                                        <b-card class="my-1"> <p>Cardinality [<em>1</em>]</p>
                                            <b-form-group label="QUESTION - Name of the entity [1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="DESCRIPTION"></b-form-input>
                                            </b-form-group>
                                            <b-form-group label="QUESTION - ID of the entity [1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="ECONOMIC_OPERATOR_IDENTIFIER"></b-form-input>
                                            </b-form-group>
                                        </b-card>
                                        </div>
                                        </b-card>
                                        </div>
                                            <b-form-group label="QUESTION - Your answer? [1]">
                                                <b-form-radio-group id="radio-group-221" v-model="selected221" :options="options" name="radio-options221">
                                                </b-form-radio-group>
                                            </b-form-group>
                                        <div v-if="selected221 ==='no'">
                                        <b-card class="my-1"> <p>Cardinality [<em>1</em>]</p>
                                            <b-form-group label="QUESTION - If not, please explain why and state which other means of proof can be provided: [1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="DESCRIPTION"></b-form-input>
                                            </b-form-group>
                                        </b-card>
                                        </div>
                                            <b-form-group label="QUESTION - Is this information available online? [1]">
                                                <b-form-radio-group id="radio-group-222" v-model="selected222" :options="options" name="radio-options222">
                                                </b-form-radio-group>
                                            </b-form-group>
                                        <div v-if="selected222 ==='yes'">
                                        <b-card class="my-1"> <p>Cardinality [<em>0..1</em>]</p>
                                            <b-form-group label="QUESTION - Evidence Supplied [1..n]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="EVIDENCE_IDENTIFIER"></b-form-input>
                                            </b-form-group>
                                        </b-card>
                                        </div></b-card></b-card>
                    </div>`
                    })

/**
 * Component - C56 - SC - Certificates by independent bodies about environmental management systems or standards
 */
Vue.component("C56 - SC",
                    { 
                        data(){
                            return {
 "options": [
  {
   "text": "Yes",
   "value": "yes"
  },
  {
   "text": "No",
   "value": "no"
  }
 ],
 "selected223": "yes",
 "selected224": "yes",
 "selected225": "yes",
 "selected226": "yes",
 "selected227": "yes"
}
                        },
                        template: `<div>
                        <b-card title="C56 - SC - Certificates by independent bodies about environmental management systems or standards">
                            <b-card-text>Will the economic operator be able to produce certificates drawn up by independent bodies attesting that the economic operator complies with the required environmental management systems or standards?</b-card-text>
                        <b-card><p>[Name of the National Criterion] <em>[Description of the National Criterion ]</em> [<em>0..n</em>]</p>
                    <b-card class="my-1"> <p>Cardinality [<em>1</em>]</p><b-card-text>CAPTION - [Additional information; e.g. no evidences online]</b-card-text>
                                        <b-form-group label="QUESTION - Your Answer [1]">
                                            <b-form-radio-group id="radio-group-223" v-model="selected223" :options="options" name="radio-options223">
                                            </b-form-radio-group>
                                        </b-form-group>
                    </b-card></b-card><b-card-text class="my-1">LEGISLATION [<em>0..n</em>]</b-card-text><b-card>
                    <b-form-group label="REQUIREMENT - Requirement [1]"
                    label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                    <b-form-input placeholder="DESCRIPTION"></b-form-input>
                    </b-form-group>
                    
                                            <b-form-group label="QUESTION - Does the EO fulfil the criteria by itself? [1]">
                                                <b-form-radio-group id="radio-group-224" v-model="selected224" :options="options" name="radio-options224">
                                                </b-form-radio-group>
                                            </b-form-group>
                                        <div v-if="selected224 ==='no'">
                                        <b-card class="my-1"> <p>Cardinality [<em>1</em>]</p>
                                            <b-form-group label="QUESTION - In the case of no – Relied upon or not [1]">
                                                <b-form-radio-group id="radio-group-225" v-model="selected225" :options="options" name="radio-options225">
                                                </b-form-radio-group>
                                            </b-form-group>
                                        <div v-if="selected225 ==='yes'">
                                        <b-card class="my-1"> <p>Cardinality [<em>1</em>]</p>
                                            <b-form-group label="QUESTION - Name of the entity [1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="DESCRIPTION"></b-form-input>
                                            </b-form-group>
                                            <b-form-group label="QUESTION - ID of the entity [1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="ECONOMIC_OPERATOR_IDENTIFIER"></b-form-input>
                                            </b-form-group>
                                        </b-card>
                                        </div>
                                        </b-card>
                                        </div>
                                            <b-form-group label="QUESTION - Your answer? [1]">
                                                <b-form-radio-group id="radio-group-226" v-model="selected226" :options="options" name="radio-options226">
                                                </b-form-radio-group>
                                            </b-form-group>
                                        <div v-if="selected226 ==='no'">
                                        <b-card class="my-1"> <p>Cardinality [<em>1</em>]</p>
                                            <b-form-group label="QUESTION - If not, please explain why and state which other means of proof can be provided: [1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="DESCRIPTION"></b-form-input>
                                            </b-form-group>
                                        </b-card>
                                        </div>
                                            <b-form-group label="QUESTION - Is this information available online? [1]">
                                                <b-form-radio-group id="radio-group-227" v-model="selected227" :options="options" name="radio-options227">
                                                </b-form-radio-group>
                                            </b-form-group>
                                        <div v-if="selected227 ==='yes'">
                                        <b-card class="my-1"> <p>Cardinality [<em>0..1</em>]</p>
                                            <b-form-group label="QUESTION - Evidence Supplied [1..n]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="EVIDENCE_IDENTIFIER"></b-form-input>
                                            </b-form-group>
                                        </b-card>
                                        </div></b-card></b-card>
                    </div>`
                    })

/**
 * Component - C57 - OT - Economic operator is a sheltered workshop
 */
Vue.component("C57 - OT",
                    { 
                        data(){
                            return {
 "options": [
  {
   "text": "Yes",
   "value": "yes"
  },
  {
   "text": "No",
   "value": "no"
  }
 ],
 "selected228": "yes",
 "selected229": "yes"
}
                        },
                        template: `<div>
                        <b-card title="C57 - OT - Economic operator is a sheltered workshop">
                            <b-card-text>Only in case the procurement is reserved: is the economic operator a sheltered workshop, a 'social business' or will it provide for the performance of the contract in the context of sheltered employment programmes?</b-card-text>
                        
                    <b-card class="my-1"> <p>Cardinality [<em>1</em>]</p>
                                        <b-form-group label="QUESTION - Your answer? [1]">
                                            <b-form-radio-group id="radio-group-228" v-model="selected228" :options="options" name="radio-options228">
                                            </b-form-radio-group>
                                        </b-form-group>
                                    <div v-if="selected228 ==='yes'">
                                    <b-card class="my-1"> <p>Cardinality [<em>1</em>]</p>
                                            <b-form-group label="QUESTION - What is the corresponding percentage of disabled or disadvantaged workers? [0..1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="PERCENTAGE"></b-form-input>
                                            </b-form-group>
                                            <b-form-group label="QUESTION - If required, please provide details on whether the employees concerned belong to a specific category of disabled or disadvantaged workers? [0..1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="DESCRIPTION"></b-form-input>
                                            </b-form-group>
                                    </b-card>
                                    </div>
                    </b-card>
                    <b-card class="my-1"> <p>Cardinality [<em>1</em>]</p>
                                        <b-form-group label="QUESTION - Is this information available electronically? [1]">
                                            <b-form-radio-group id="radio-group-229" v-model="selected229" :options="options" name="radio-options229">
                                            </b-form-radio-group>
                                        </b-form-group>
                                    <div v-if="selected229 ==='yes'">
                                    <b-card class="my-1"> <p>Cardinality [<em>0..1</em>]</p>
                                            <b-form-group label="QUESTION - Evidence Supplied [1..n]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="EVIDENCE_IDENTIFIER"></b-form-input>
                                            </b-form-group>
                                    </b-card>
                                    </div>
                    </b-card></b-card>
                    </div>`
                    })

/**
 * Component - C58 - OT - Economic operator registered in a pre qualification system
 */
Vue.component("C58 - OT",
                    { 
                        data(){
                            return {
 "options": [
  {
   "text": "Yes",
   "value": "yes"
  },
  {
   "text": "No",
   "value": "no"
  }
 ],
 "selected230": "yes",
 "selected231": "yes",
 "selected232": "yes",
 "selected233": "yes"
}
                        },
                        template: `<div>
                        <b-card title="C58 - OT - Economic operator registered in a pre qualification system">
                            <b-card-text>If applicable, is the economic operator registered on an official list of approved economic operators or does it have an equivalent certificate (e.g. under a national (pre)qualification system)?</b-card-text>
                        
                    <b-card class="my-1"> <p>Cardinality [<em>1</em>]</p>
                                        <b-form-group label="QUESTION - Your answer? [1]">
                                            <b-form-radio-group id="radio-group-230" v-model="selected230" :options="options" name="radio-options230">
                                            </b-form-radio-group>
                                        </b-form-group>
                                    <div v-if="selected230 ==='yes'">
                                    <b-card class="my-1"> <p>Cardinality [<em>1</em>]</p>
                                            <b-form-group label="QUESTION - Please provide the name of the list or certificate and the relevant registration or certification number, if applicable [1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="DESCRIPTION"></b-form-input>
                                            </b-form-group>
                                            <b-form-group label="QUESTION - If the certificate of registration or certification is available electronically, please state where [0..1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="URL"></b-form-input>
                                            </b-form-group>
                                            <b-form-group label="QUESTION - Please state the references on which the registration or certification is based, and, where applicable, the classification obtained in the official list [0..1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="DESCRIPTION"></b-form-input>
                                            </b-form-group><b-card class="my-1"> <p>Cardinality [<em>1</em>]</p>
                                            <b-form-group label="QUESTION - Does the registration or certification cover all of the required selection criteria? [1]">
                                                <b-form-radio-group id="radio-group-231" v-model="selected231" :options="options" name="radio-options231">
                                                </b-form-radio-group>
                                            </b-form-group></b-card>
                                    </b-card>
                                    </div>
                                    <div v-if="selected230 ==='no'">
                                    <b-card class="my-1"> <p>Cardinality [<em>1</em>]</p>
                                            <b-form-group label="QUESTION - Will the economic operator be able to provide a certificate with regard to the payment of social security contributions and taxes or provide information enabling the contracting authority or contracting entity to obtaining it directly by accessing a national database in any Member State that is available free of charge? [1]">
                                                <b-form-radio-group id="radio-group-232" v-model="selected232" :options="options" name="radio-options232">
                                                </b-form-radio-group>
                                            </b-form-group>
                                    </b-card>
                                    </div>
                    </b-card>
                    <b-card class="my-1"> <p>Cardinality [<em>1</em>]</p>
                                        <b-form-group label="QUESTION - Is this information available electronically? [1]">
                                            <b-form-radio-group id="radio-group-233" v-model="selected233" :options="options" name="radio-options233">
                                            </b-form-radio-group>
                                        </b-form-group>
                                    <div v-if="selected233 ==='yes'">
                                    <b-card class="my-1"> <p>Cardinality [<em>0..1</em>]</p>
                                            <b-form-group label="QUESTION - Evidence Supplied [1..n]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="EVIDENCE_IDENTIFIER"></b-form-input>
                                            </b-form-group>
                                    </b-card>
                                    </div>
                    </b-card></b-card>
                    </div>`
                    })

/**
 * Component - C59 - OT - Economic Operator together with others
 */
Vue.component("C59 - OT",
                    { 
                        data(){
                            return {
 "options": [
  {
   "text": "Yes",
   "value": "yes"
  },
  {
   "text": "No",
   "value": "no"
  }
 ],
 "selected234": "yes",
 "selected235": "yes"
}
                        },
                        template: `<div>
                        <b-card title="C59 - OT - Economic Operator together with others">
                            <b-card-text>Is the economic operator participating in the procurement procedure together with others?</b-card-text>
                        
                    <b-card class="my-1"> <p>Cardinality [<em>1</em>]</p>
                                        <b-form-group label="QUESTION - Your answer? [1]">
                                            <b-form-radio-group id="radio-group-234" v-model="selected234" :options="options" name="radio-options234">
                                            </b-form-radio-group>
                                        </b-form-group>
                                    <div v-if="selected234 ==='yes'">
                                    <b-card class="my-1"> <p>Cardinality [<em>1</em>]</p>
                                            <b-form-group label="QUESTION - Please indicate the role of the economic operator in the group (leader, responsible for specific tasks...) [1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="CODE"></b-form-input>
                                            </b-form-group>
                                            <b-form-group label="QUESTION - Please identify the other economic operators participating in the procurement procedure together [0..1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="DESCRIPTION"></b-form-input>
                                            </b-form-group>
                                            <b-form-group label="QUESTION - Where applicable, name of the participating group: [0..1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="DESCRIPTION"></b-form-input>
                                            </b-form-group>
                                    </b-card>
                                    </div>
                    </b-card>
                    <b-card class="my-1"> <p>Cardinality [<em>1</em>]</p>
                                        <b-form-group label="QUESTION - Is this information available electronically? [1]">
                                            <b-form-radio-group id="radio-group-235" v-model="selected235" :options="options" name="radio-options235">
                                            </b-form-radio-group>
                                        </b-form-group>
                                    <div v-if="selected235 ==='yes'">
                                    <b-card class="my-1"> <p>Cardinality [<em>0..1</em>]</p>
                                            <b-form-group label="QUESTION - Evidence Supplied [1..n]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="EVIDENCE_IDENTIFIER"></b-form-input>
                                            </b-form-group>
                                    </b-card>
                                    </div>
                    </b-card></b-card>
                    </div>`
                    })

/**
 * Component - C60 - OT - Relied on entities
 */
Vue.component("C60 - OT",
                    { 
                        data(){
                            return {
 "options": [
  {
   "text": "Yes",
   "value": "yes"
  },
  {
   "text": "No",
   "value": "no"
  }
 ],
 "selected236": "yes",
 "selected237": "yes"
}
                        },
                        template: `<div>
                        <b-card title="C60 - OT - Relied on entities">
                            <b-card-text>Does the economic operator rely on the capacities of other entities in order to meet the selection criteria set out under Part IV and the criteria and rules (if any) set out under Part V below?</b-card-text>
                        
                    <b-card class="my-1"> <p>Cardinality [<em>1</em>]</p>
                                        <b-form-group label="QUESTION - Your answer? [1]">
                                            <b-form-radio-group id="radio-group-236" v-model="selected236" :options="options" name="radio-options236">
                                            </b-form-radio-group>
                                        </b-form-group>
                                    <div v-if="selected236 ==='yes'">
                                    <b-card class="my-1"> <p>Cardinality [<em>0..n</em>]</p>
                                            <b-form-group label="QUESTION - Name of the entity [1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="DESCRIPTION"></b-form-input>
                                            </b-form-group>
                                            <b-form-group label="QUESTION - ID of the entity [1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="ECONOMIC_OPERATOR_IDENTIFIER"></b-form-input>
                                            </b-form-group>
                                    </b-card>
                                    </div>
                    </b-card>
                    <b-card class="my-1"> <p>Cardinality [<em>1</em>]</p>
                                        <b-form-group label="QUESTION - Is this information available electronically? [1]">
                                            <b-form-radio-group id="radio-group-237" v-model="selected237" :options="options" name="radio-options237">
                                            </b-form-radio-group>
                                        </b-form-group>
                                    <div v-if="selected237 ==='yes'">
                                    <b-card class="my-1"> <p>Cardinality [<em>0..1</em>]</p>
                                            <b-form-group label="QUESTION - Evidence Supplied [1..n]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="EVIDENCE_IDENTIFIER"></b-form-input>
                                            </b-form-group>
                                    </b-card>
                                    </div>
                    </b-card></b-card>
                    </div>`
                    })

/**
 * Component - C61 - OT - Not relied on entities
 */
Vue.component("C61 - OT",
                    { 
                        data(){
                            return {
 "options": [
  {
   "text": "Yes",
   "value": "yes"
  },
  {
   "text": "No",
   "value": "no"
  }
 ],
 "selected238": "yes",
 "selected239": "yes"
}
                        },
                        template: `<div>
                        <b-card title="C61 - OT - Not relied on entities">
                            <b-card-text>Does the economic operator intend to subcontract any share of the contract to third parties?</b-card-text>
                        
                    <b-card class="my-1"> <p>Cardinality [<em>1</em>]</p>
                                        <b-form-group label="QUESTION - Your answer? [1]">
                                            <b-form-radio-group id="radio-group-238" v-model="selected238" :options="options" name="radio-options238">
                                            </b-form-radio-group>
                                        </b-form-group>
                                    <div v-if="selected238 ==='yes'">
                                    <b-card class="my-1"> <p>Cardinality [<em>0..n</em>]</p>
                                            <b-form-group label="QUESTION - Name of the entity [1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="DESCRIPTION"></b-form-input>
                                            </b-form-group>
                                            <b-form-group label="QUESTION - ID of the subcontractor [1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="ECONOMIC_OPERATOR_IDENTIFIER"></b-form-input>
                                            </b-form-group>
                                    </b-card>
                                    </div>
                    </b-card>
                    <b-card class="my-1"> <p>Cardinality [<em>1</em>]</p>
                                        <b-form-group label="QUESTION - Is this information available electronically? [1]">
                                            <b-form-radio-group id="radio-group-239" v-model="selected239" :options="options" name="radio-options239">
                                            </b-form-radio-group>
                                        </b-form-group>
                                    <div v-if="selected239 ==='yes'">
                                    <b-card class="my-1"> <p>Cardinality [<em>0..1</em>]</p>
                                            <b-form-group label="QUESTION - Evidence Supplied [1..n]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="EVIDENCE_IDENTIFIER"></b-form-input>
                                            </b-form-group>
                                    </b-card>
                                    </div>
                    </b-card></b-card>
                    </div>`
                    })

/**
 * Component - C63 - OT - Reduction of the number of qualified candidates
 */
Vue.component("C63 - OT",
                    { 
                        data(){
                            return {
 "options": [
  {
   "text": "Yes",
   "value": "yes"
  },
  {
   "text": "No",
   "value": "no"
  }
 ],
 "selected240": "yes",
 "selected241": "yes"
}
                        },
                        template: `<div>
                        <b-card title="C63 - OT - Reduction of the number of qualified candidates">
                            <b-card-text>The economic operator declares that It meets the objective and non discriminatory criteria or rules to be applied in order to limit the number of candidates in the following way:</b-card-text>
                        
                    <b-card class="my-1"> <p>Cardinality [<em>1</em>]</p>
                                        <b-form-group label="QUESTION - Your answer? [1]">
                                            <b-form-radio-group id="radio-group-240" v-model="selected240" :options="options" name="radio-options240">
                                            </b-form-radio-group>
                                        </b-form-group>
                                    <div v-if="selected240 ==='yes'">
                                    <b-card class="my-1"> <p>Cardinality [<em>0..1</em>]</p>
                                            <b-form-group label="QUESTION - Please describe them [1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="DESCRIPTION"></b-form-input>
                                            </b-form-group>
                                    </b-card>
                                    </div>
                    </b-card>
                    <b-card class="my-1"> <p>Cardinality [<em>1</em>]</p>
                                        <b-form-group label="QUESTION - Is this information available electronically? [1]">
                                            <b-form-radio-group id="radio-group-241" v-model="selected241" :options="options" name="radio-options241">
                                            </b-form-radio-group>
                                        </b-form-group>
                                    <div v-if="selected241 ==='yes'">
                                    <b-card class="my-1"> <p>Cardinality [<em>0..1</em>]</p>
                                            <b-form-group label="QUESTION - Evidence Supplied [1..n]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="EVIDENCE_IDENTIFIER"></b-form-input>
                                            </b-form-group>
                                    </b-card>
                                    </div>
                    </b-card></b-card>
                    </div>`
                    })

/**
 * Component - C65 - OT - Economic Operator Micro, Small or Medium-sized Enterprise
 */
Vue.component("C65 - OT",
                    { 
                        data(){
                            return {
 "options": [
  {
   "text": "Yes",
   "value": "yes"
  },
  {
   "text": "No",
   "value": "no"
  }
 ],
 "selected242": "yes"
}
                        },
                        template: `<div>
                        <b-card title="C65 - OT - Economic Operator Micro, Small or Medium-sized Enterprise">
                            <b-card-text>Is the economic operator a Micro, a Small or Medium-sized Enterprise?</b-card-text>
                        
                    <b-card class="my-1"> <p>Cardinality [<em>1</em>]</p>
                                        <b-form-group label="QUESTION - Your answer? [1]">
                                            <b-form-radio-group id="radio-group-242" v-model="selected242" :options="options" name="radio-options242">
                                            </b-form-radio-group>
                                        </b-form-group>
                                    <div v-if="selected242 ==='yes'">
                                    <b-card class="my-1"> <p>Cardinality [<em>1</em>]</p>
                                            <b-form-group label="QUESTION - Number of employees [1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="QUANTITY_INTEGER"></b-form-input>
                                            </b-form-group>
                                            <b-form-group label="QUESTION - Turnover [1]" 
                                            label-cols-sm="6" label-cols-lg="8" content-cols-sm content-cols-lg="4">
                                            <b-form-input placeholder="AMOUNT"></b-form-input>
                                            </b-form-group>
                                    </b-card>
                                    </div>
                    </b-card></b-card>
                    </div>`
                    })