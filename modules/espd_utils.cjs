var fs = require("fs")

const JSON2file = function(where, what) {
    //log(where)
    //log(JSON.stringify(what, null, 4))
    fs.writeFile(where, JSON.stringify(what, null, 4), (err) => {
        if (err) {
            console.log('Error writing to file:', err);
        } else {
            console.log(`JSON data written to ${where}`);
        }
    });
};


module.exports = { JSON2file } 
