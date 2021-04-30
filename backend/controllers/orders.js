const Order = require("../models/orders");
const Product = require("../models/product");

exports.orders_get_orders = (req, res, next) => {
  Order.find({ user: req.userData.userId })
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
};

exports.orders_place_order = (req, res, next) => {
      
      const order = new Order({
        user: req.body.user,
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
    
};

exports.orders_get_order = (req, res, next) => {
  Order.findById(req.params.id)
    .populate("products")
    .exec()
    .then((result) => {
      if (result && result.user == req.userData.userId) {
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

exports.orders_delete_order = (req, res, next) => {
  Order.deleteOne({
    _id: req.params.id,
    user: req.userData.userId,
  })
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
};
