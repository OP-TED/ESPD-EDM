var fs = require("fs")

const JSON2file = function (where, what) {
    //log(where)
    //log(JSON.stringify(what, null, 4))
    if (fs.existsSync(where)) {
        try {
            fs.unlinkSync(where)
        } catch (error) {
            console.log(error)
        }
    }

    fs.writeFileSync(where, JSON.stringify(what, null, 4))
    console.log(`File ${where} successfuly saved to disk!`)


};

/**
 *  Transofrom a string into a JavaScript Property
 *  JavaScript identfier can nontain Unicode letters, $, _ and digits, and may not start with a digit
 */
var stringToProperty = function(str){

    const dict = [
        { what_to_replace: '-', to_replace_with: '__'},
        { what_to_replace: '/', to_replace_with: '$'},
        { what_to_replace: '@', to_replace_with: '$$'}
    ]

    let result= str

    for (const element of dict) {
        result = result.replaceAll(element.what_to_replace, element.to_replace_with)
    }

    return result
}

module.exports = { JSON2file, stringToProperty } 
