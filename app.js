const express = require("express");

const bodyParser = require("body-parser");
const mongoose = require("mongoose");

const userRoute = require("./routes/user");
const productsRoute = require("./routes/products");
const ordersRoute = require("./routes/orders");

const app = express();
mongoose
  .connect(
    "mongodb+srv://aman:aman@flutterdb.qau8e.mongodb.net/FlutterDB?retryWrites=true&w=majority",
    {
      useNewUrlParser: true,
      useUnifiedTopology: true,
      useCreateIndex: true,
    }
  )
  .then(() => {
    console.log("Connected to the database");
  })
  .catch(() => {
    console.log("Failed");
  });

app.use(express.json());
app.use(express.urlencoded({ extended: false }));

app.use((req, res, next) => {
  res.header("Access-Control-Allow-Origin", "*");
  res.header(
    "Access-Control-Allow-Methods",
    "GET,HEAD,OPTIONS,POST,PUT,DELETE"
  );
  res.header(
    "Access-Control-Allow-Headers",
    "Origin, X-Requested-With, Content-Type, Accept, Authorization"
  );
  next();
});

app.use("/api", userRoute);
app.use("/products", productsRoute);
app.use("/orders", ordersRoute);

app.use((req, res, next) => {
  let err = new Error("Not Found");
  err.status = 404;
  next(err);
});

module.exports = app;
