const express = require("express");
const path = require("path");
const router = express.Router();
const itemController = require("../controllers/item.controller");

router.get("/getAllItems", itemController.getAllItems);

router.post("/addItem", itemController.addItem);

module.exports = router;
