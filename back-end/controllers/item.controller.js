const itemController = {
  getAllItems: (req, res, next) => {
    console.log("abc");
    res.status(200).json({ message: "success" });
  },
  addItem: (req, res, next) => {
    console.log(res.body.name);
  },
};

module.exports = itemController;
