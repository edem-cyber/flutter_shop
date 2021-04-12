const express = require("express");
const Order = require("../models/orders");
const Product = require("../models/product");

const router = express.Router();

router.get("/", (req, res, next) => {
  Order.find()
    .select("products quantity _id date")
    .exec()
    .then((docs) => {
      const respone = {
        count: docs.length,
        orders: docs.map((doc) => {
          return {
            id: doc._id,
            date: doc.date,
            products: doc.products,
            quantity: doc.quantity,
          };
        }),
      };
      res.status(200).json(respone);
    })
    .catch((error) => {
      res.status(500).json({
        error: error,
      });
    });
});

router.post("/", (req, res, next) => {
  const list = req.body.products; //...an array filled with values
  var flag = true;

  const functionWithPromise = (item) => {
    //a function that returns a promise
    return Product.findOne(
      { _id: item },
      "_id",
      (err, doc) => {
        if (!doc) {
          flag = false;
          return false;
        }
        return true;
      }
    );
  };

  const anAsyncFunction = async (item) => {
    return functionWithPromise(item);
  };

  const getData = async () => {
    return Promise.all(
      list.map((item) => anAsyncFunction(item))
    );
  };

  getData().then((data) => {
    // const index = data.find(null);
    if (flag) {
      const order = new Order({
        date: req.body.date,
        products: req.body.products,
        quantity: req.body.quantity,
      });
      order
        .save()
        .then((result) => {
          res.status(201).json({
            message: "Order created!",
            result: result,
          });
        })
        .catch((error) => {
          res
            .status(error.status || 500)
            .json({ error: error });
        });
    } else {
      res.status(500).json({
        message: "Order made for invalid product(s)",
      });
    }
  });
  // if (products.length > 0) {
  // }
});

router.get("/:id", (req, res, next) => {
  Order.findById(req.params.id)
    .populate("products")
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

router.delete("/:id", (req, res, next) => {
  Order.deleteOne({ _id: req.params.id })
    .exec()
    .then((result) => {
      res.status(200).json({
        message: "Order Cancelled",
      });
    })
    .catch((err) => {
      res.status(500).json({
        error: err,
      });
    });
});

module.exports = router;
