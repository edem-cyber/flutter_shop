const express = require("express");
const multer = require("multer");

const checkAuth = require("../middleware/auth");
const Product = require("../models/product");

// setting up storage location and filename pattern
const stroage = multer.diskStorage({
  destination: function (req, file, cb) {
    cb(null, "uploads/");
  },
  filename: function (req, file, cb) {
    cb(null, Date.now() + file.originalname);
  },
});

// setting up file filter using mimetype
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

// returns the list of products when successful request is made
router.get("/", (req, res, next) => {
  Product.find()
    .exec()
    .then((docs) => {
      const response = {
        count: docs.length,
        products: docs.map((doc) => {
          return {
            id: doc._id,
            name: doc.name,
            price: doc.price,
            description: doc.description,
            seller: doc.seller,
            productImage:
              "192.168.0.195:3000/" + doc.productImage,
          };
        }),
      };
      res.status(200).json(response);
    })
    .catch((error) => {
      res.status(500).json({ error: error });
    });
});

// request is in form-data type (contains key value pair wher value can be text or file) which
// is different from json to upload image file
router.post(
  "/",
  checkAuth,
  upload.single("productImage"),
  (req, res, next) => {
    const product = new Product({
      name: req.body.name,
      price: req.body.price,
      description: req.body.description,
      seller: req.body.seller,
      productImage:
        req.file.destination + req.file.filename,
    });
    product
      .save()
      .then((result) => {
        res.status(201).json({
          message: "Product created!",
          product: result,
        });
      })
      .catch((error) => {
        res
          .status(error.status || 500)
          .json({ error: error });
      });
  }
);

//return the detail of requested product
router.get("/:id", (req, res, next) => {
  Product.findById(req.params.id)
    .exec()
    .then((result) => {
      if (result) {
        res.status(200).json(result);
      } else {
        res.status(404).json({
          message: "No valid entry found",
        });
      }
    })
    .catch((error) => {
      res.status(500).json({ error: error });
    });
});

// patch the requested properties in the given product
router.patch("/:id", checkAuth, (req, res, next) => {
  Product.updateOne(
    { _id: req.params.id },
    { $set: req.body }
  )
    .exec()
    .then((result) => {
      res.status(200).json({
        message: "Product updated successfully",
      });
    })
    .catch((err) => {
      res.status(500).json({
        error: err,
      });
    });
});

// delete the product
router.delete("/:id", checkAuth, (req, res, next) => {
  Product.deleteOne({ _id: req.params.id })
    .then((result) => {
      res.status(200).json({
        message: "Product deleted successfully",
      });
    })
    .catch((err) => {
      res.status(500).json(err);
    });
});

module.exports = router;
