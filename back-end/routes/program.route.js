// import { unlink } from 'node:fs';
const unlink = require("node:fs").unlink;
const express = require("express");
const path = require("path");
const router = express.Router();
const upload = require("../middleware/multer.middleware");
const programController = require("../controllers/program.controller");

// post image and get data
router.post("/getImageName", upload.single("image"), programController.getImageName);

module.exports = router;
