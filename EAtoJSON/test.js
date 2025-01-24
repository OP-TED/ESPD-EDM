import path from 'path';
import { readFileSync } from 'fs'
import MDBReader from 'mdb-reader'


const buffer = readFileSync(path.resolve('ESPD_CM.eapx'))
const reader = new MDBReader(buffer)
console.log(reader.getTableNames());
