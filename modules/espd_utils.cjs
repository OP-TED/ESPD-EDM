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


module.exports = { JSON2file } 
