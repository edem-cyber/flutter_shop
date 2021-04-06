const mongoose = require("mongoose");
const emailValidator = require("mongoose-unique-validator");

const userSchema = mongoose.Schema({
  email: { type: String, required: true, unique: true },
  password: { type: String, required: true },
  firstname: { type: String, required: true },
  lastname: { type: String, required: true },
  address: { type: String },
  phone: { type: String },
});

userSchema.plugin(emailValidator, {
  message: "Email-id already exists",
});
module.exports = mongoose.model("User", userSchema);
