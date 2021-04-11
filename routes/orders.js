const express = require("express");
const Order = require("../models/orders");

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
