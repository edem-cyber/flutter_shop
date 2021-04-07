const mongoose = require("mongoose");

const orderSchema = mongoose.Schema({
  date: { type: String, required: true },
});

module.exports = mongoose.model("Order", orderSchema);
