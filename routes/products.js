const express = require("express");
const multer = require("multer");
const Product = require("../models/product");

const stroage = multer.diskStorage({
  destination: function (req, file, cb) {
    cb(null, "./uploads/");
  },
  filename: function (req, file, cb) {
    cb(null, new Date().toISOString + file.filename);
  },
});

const fileFilter = (req, file, cb) => {
  if (
    file.mimetype === "image/jpeg" ||
    file.mimetype === "image/jpg" ||
    file.mimetype === "image/png"
  ) {
    cb(null, true);
  } else {
    cb(null, false);
  }
};

const upload = multer({
  storage: stroage,
  limits: {
    fileSize: 1024 * 1024 * 2,
  },
  fileFilter: fileFilter,
});

const router = express.Router();

router.get("/", (req, res, next) => {
  res.status(200).json({
    message: "Inside products get request",
  });
});

router.post("/", (req, res, next) => {
  res.status(201).json({
    message: "Inside products post request",
  });
});

router.get("/:id", (req, res, next) => {
  var id = req.params.id;
  if (id === "aman") {
    res.status(200).json({
      message: "You got special",
    });
  } else {
    res.status(200).json({
      message: "Your product id is " + id,
    });
  }
});

router.patch("/:id", (req, res, next) => {
  res.status(200).json({
    message: "product updated successfully",
  });
});

router.delete("/:id", (req, res, next) => {
  res.status(200).json({
    message: "product deleted successfully",
  });
});

module.exports = router;
