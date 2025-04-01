import path from 'path';
import { readFileSync } from 'fs'
import MDBReader from 'mdb-reader'


const buffer = readFileSync(path.resolve('ESPD_CM.eapx'))
const reader = new MDBReader(buffer)
console.log(reader.getTableNames());

console.log('t_object'.padStart(20, '-'))
console.log(JSON.stringify(reader.getTable('t_object').getData(), null, 2));

console.log('t_objectproperties'.padStart(20, '-'))
console.log(JSON.stringify(reader.getTable('t_objectproperties').getData(), null, 2));

console.log('t_attribute'.padStart(20, '-'))
console.log(JSON.stringify(reader.getTable('t_attribute').getData(), null, 2));

console.log('t_connector'.padStart(20, '-'))
console.log(JSON.stringify(reader.getTable('t_connector').getData(), null, 2));



