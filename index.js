const config = require("./config/config");
const express = require("express");
const cors = require("cors");
const mysql = require("mysql2/promise");

const app = express();
const conn = mysql.createPool(config);
exports.createconn = conn;

app.use(cors());
app.use(express.json());

const order = require("./routes/order");
app.use("/order", order);

const useraccount = require("./routes/useraccount");
app.use("/useraccount", useraccount);

app.listen(7000, "127.0.0.1", () => {
  console.log("running on port 7000");
});
