const Product = require("../models/product");

exports.products_get_all = (req, res, next) => {
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
};

exports.products_add_product = (req, res, next) => {
  if (req.userData.role == 0) {
    const product = new Product({
      name: req.body.name,
      price: req.body.price,
      description: req.body.description,
      seller: req.body.seller,
      sellerId: req.userData.userId,
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
  } else {
    res.status(401).json({
      message: "You are not authenticated",
    });
  }
};

exports.products_get_one = (req, res, next) => {
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
};

exports.products_patch_product = (req, res, next) => {
  Product.updateOne(
    { _id: req.params.id, sellerId: req.userData.userId },
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
};

exports.products_delete_product = (req, res, next) => {
  Product.deleteOne({
    _id: req.params.id,
    sellerId: req.userData.userId,
  })
    .then((result) => {
      res.status(200).json({
        message: "Product deleted successfully",
      });
    })
    .catch((err) => {
      res.status(500).json(err);
    });
};