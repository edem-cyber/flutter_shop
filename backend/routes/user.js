const express = require("express");
const jwt = require("jsonwebtoken");
const bcrypt = require("bcrypt");
const User = require("../models/user");

const checkAuth = require("../middleware/auth");
const adminCheck = require("../middleware/adminCheck");

const router = express.Router();

router.get("/", checkAuth, adminCheck, (req, res, next) => {
  User.find()
    .select("email firstname lastname role")
    .exec()
    .then((docs) => {
      res.status(200).json({
        message: "All Users",
        users: docs,
      });
    })
    .catch((err) => {
      res.status(500).json({
        error: err,
      });
    });
});

router.post("/signup", (req, res, next) => {
  User.find({ email: req.body.email })
    .exec()
    .then((doc) => {
      if (doc.length >= 1) {
        res.status(409).json({
          error: "Email-ID already exists!",
        });
      } else {
        bcrypt
          .hash(req.body.password, 10, (err, hash) => {
            if (err)
              return res.status(500).json({ error: err });
            const user = new User({
              email: req.body.email,
              password: hash,
              firstname: req.body.firstname,
              lastname: req.body.lastname,
              role: req.body.role,
            });
            user
              .save()
              .then((result) => {
                res.status(201).json({
                  message: "Account successfully created!",
                  user: user,
                });
              })
              .catch((err) => {
                res.status(500).json({
                  error: err,
                });
              });
          })
          .catch((err) => {
            res.status(500).json({
              error: err,
            });
          });
      }
    })
    .catch((err) => {
      res.status(500).json({
        error: err,
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
          if (!result) {
            return res.status(404).json({
              message: "Invalid email-id or password",
            });
          }
          const token = jwt.sign(
            {
              email: userSave.email,
              userId: userSave._id,
              role: userSave.role,
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
            role: userSave.role,
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
