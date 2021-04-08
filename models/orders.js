const mongoose = require("mongoose");

const orderSchema = mongoose.Schema({
  date: { type: String, required: true },
  products: [
    {
      type: mongoose.Schema.Types.ObjectId(),
      ref: "Product",
    },
  ],
});

module.exports = mongoose.model("Order", orderSchema);
