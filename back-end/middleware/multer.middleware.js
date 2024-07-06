const multer = require("multer");
const path = require("path");
const fs = require("fs");

const storage = multer.diskStorage({
    destination: async (req, file, cb) => {
        const uploadDir = "./assets";
        if ( !fs.existsSync(uploadDir)) {
             fs.mkdirSync(uploadDir, {recursive: true});
        }
        cb(null, uploadDir);
    },
    filename: (req, file, cb) => {
        // console.log(file)
        cb(null, "temp" + path.extname(file.originalname));
    },
});

  module.exports = multer({ storage : storage})