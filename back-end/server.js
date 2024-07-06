const express = require("express");
const app = express();
const cors = require("cors");
require("dotenv").config();

const homeRoute = require("./routes/home.route");
const itemRoute = require("./routes/item.route");
const programRoute = require("./routes/program.route");

app.use(homeRoute);
app.use("/v1/item", itemRoute);
app.use("/v1/program", programRoute);

app.listen(process.env.PORT, () => {
  console.log(`Server is running on http://localhost:${process.env.PORT}/`);
});
