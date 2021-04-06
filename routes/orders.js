const express = require("express");

const router = express.Router();

router.get("/", (req, res, next) => {
  res.status(200).json({
    message: "Inside orders get request",
  });
});

router.post("/", (req, res, next) => {
  res.status(200).json({
    message: "Inside orders get request",
  });
});

router.get("/:id", (req, res, next) => {
  res.status(200).json({
    message:
      "Inside order " + req.params.id + " get request",
  });
});

router.delete("/:id", (req, res, next) => {
  res.status(200).json({
    message: "order cancelled",
  });
});

module.exports = router;
