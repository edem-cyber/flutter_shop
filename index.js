const express = require("express");
const http = require("http");
const bodyParser = require("body-parser");
const mongoose = require("mongoose");

const userRoute = require("./routes/user");

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

app.use((req, res, next) => {
  let err = new Error("Not Found");
  err.status = 404;
  next(err);
});

// app.use((err, req, res, next) => {
//   // set locals, only providing error in development

//   res.locals.message = err.message;
//   res.locals.error =
//     req.app.get("env") === "development" ? err : {};

//   // render the error page

//   res.status(err.status || 500);
//   res.json({ error: "error", message: err.message });
// });

const port = process.env.PORT || "3000";
app.set("port", port);
let httpServer = http.createServer(app);
let server = httpServer.listen(port, () => {
  // successLogger(`API running on port ${port}, DateTime : ${new Date()}`);
  console.log("API running on port", port);
});
