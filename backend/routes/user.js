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

router.get("/:id",checkAuth,(req,res,next)=>{
  User.findOne({_id: req.params.id}).populate('favorite').select('-password').then((result)=>{
    if(!result){
      return res.status(404).json({
        error: "Not Found!"
      });
    }
    if(result.id != req.userData.userId){
      return res.status(403).json({
        error: "You're not authorized"
      })
    }
    res.status(200).json({
      user: result
    });
  }).catch();
});

router.delete("/:id",checkAuth,UserController.user_delete);

module.exports = router;
