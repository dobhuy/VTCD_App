const express = require("express");
const path = require("path");
const router = express.Router();
const homeController = require("../controllers/home.controller");

// router.get("/", homeController.getHomePage);

router.get("/", (req, res) => {
  const { spawn } = require("child_process");
  const pyProg = spawn("python3", [
    "backend.py",
    "data/BanhCay/Banh_cay_1.jpg",
  ]);

  console.log("running");

  // const pyProg = spawn("python3", ["test.py", 2, 3]);

  pyProg.stdout.on("data", function (data) {
    console.log("Data received from python script: ", data.toString());
    // res.write(data);
    // res.end("end");
  });
});

module.exports = router;
