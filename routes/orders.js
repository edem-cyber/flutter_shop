const express = require("express");
const Order = require("../models/orders");

const router = express.Router();

router.get("/", (req, res, next) => {
  Order.find()
    .select("product quantity _id date")
    .exec()
    .then((docs) => {
      const respone = {
        count: docs.length,
        orders: docs.map((doc) => {
          return {
            id: doc._id,
            date: doc.date,
            product: doc.product,
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
    product: req.body.productId,
    quantity: req.body.quantity,
  });
  order
    .save()
    .then((result) => {
      res.status(201).json({
        message: "Order created!",
        product: result,
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
    .populate("product")
    .exec()
    .then((res) => {
      res.status(200).json(res);
    })
    .catch((err) => {
      res.status(500).json(err);
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
