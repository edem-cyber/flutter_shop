module.exports = (req, res, next) => {
  if (req.userData.role == 2) {
    next();
  } else {
    res.status(401).json({
      message: "You are not authenticated",
    });
  }
};
