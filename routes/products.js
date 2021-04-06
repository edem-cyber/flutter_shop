const express = require("express");

const router = express.Router();

router.get("/", (req, res, next) => {
  res.status(200).json({
    message: "Inside products get request",
  });
});

router.post("/", (req, res, next) => {
  res.status(200).json({
    message: "Inside products post request",
  });
});

router.get("/:id", (req, res, next) => {
  var id = req.params.id;
  if (id === "aman") {
    res.status(200).json({
      message: "You got special",
    });
  } else {
    res.status(200).json({
      message: "Your product id is " + id,
    });
  }
});

router.patch("/:id", (req, res, next) => {
  res.status(200).json({
    message: "product updated successfully",
  });
});

router.delete("/:id", (req, res, next) => {
  res.status(200).json({
    message: "product deleted successfully",
  });
});

module.exports = router;
