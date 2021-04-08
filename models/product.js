const mongoose = require("mongoose");

const productSchema = mongoose.Schema({
  name: { type: String, required: true },
  description: { type: String, required: true },
  seller: { type: String, required: true },
  productImage: { type: String, required: true },
});

module.exports = mongoose.model("Product", productSchema);
