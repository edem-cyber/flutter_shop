const express = require("express");

const User = require("../models/user");

const checkAuth = require("../middleware/auth");
const adminCheck = require("../middleware/adminCheck");

const UserController = require("../controllers/user");

const router = express.Router();

router.get(
  "/",
  checkAuth,
  adminCheck,
  UserController.user_admin_get
);

router.post("/signup", UserController.user_signup);

router.post("/login", UserController.user_login);

router.get("/:id",checkAuth, UserController.user_detail);

router.delete("/:id",checkAuth,UserController.user_delete);

module.exports = router;
