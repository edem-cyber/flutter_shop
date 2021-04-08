const mongoose = require("mongoose");

const orderSchema = mongoose.Schema({
  date: { type: String, required: true },
  products: [
    {
      product: {
        type: mongoose.Schema.Types.ObjectId,
        ref: "Product",
      },
      quantity: { type: Number, default: 1 },
    },
  ],
});

module.exports = mongoose.model("Order", orderSchema);
