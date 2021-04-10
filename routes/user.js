const express = require("express");
const jwt = require("jsonwebtoken");
const bcrypt = require("bcryptjs");

const User = require("../models/user");
const auth = require("../middleware/auth");

const router = express.Router();

router.get("/", (req, res, next) => {
  console.log("connected");
  res.status(200).json({ message: "Connected" });
});

router.post("/signup", (req, res, next) => {
  bcrypt.hash(req.body.password, 10).then((hash) => {
    const user = new User({
      email: req.body.email,
      password: hash,
    });
    user
      .save()
      .then((result) => {
        res.status(201).json({
          message: "User Created",
          user: result,
        });
      })
      .catch((err) => {
        res.status(500).json({
          err: err,
        });
      });
  });
});

router.post("/login", (req, res, next) => {
  let userSave;
  User.findOne({ email: req.body.email })
    .then((user) => {
      if (!user) {
        return res.status(404).json({
          message: "Invalid email-id or password",
        });
      }
      userSave = user;
      return bcrypt
        .compare(req.body.password, user.password)
        .then((result) => {
          console.log(result);
          if (!result) {
            return res.status(404).json({
              message: "Invalid email-id or password",
            });
          }
          const token = jwt.sign(
            {
              email: userSave.email,
              userId: userSave._id,
            },
            "this_is_a_secret_key_by_@man_Sr1vastava",
            {
              expiresIn: "1h",
            }
          );
          res.status(200).json({
            token: token,
            expiresIn: 1,
            userId: userSave._id,
            isAdmim:
              userSave.email ==
              "aman.srivastava101@gmail.com",
          });
        })
        .catch((err) => {
          res.json({ err: err });
        });
    })
    .catch((err) => {
      res.json({ err: err });
    });
});

module.exports = router;
