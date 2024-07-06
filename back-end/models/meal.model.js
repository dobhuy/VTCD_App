const { log } = require("console");
const fs = require("fs");
const path = require("path");

const mealDataPath = path.join(
  path.dirname(require.main.filename),
  "data",
  "meals.json"
); // path.dirname(require.main.filename) is root directory

const getMealsFromFile = (callback) => {
  fs.readFile(mealDataPath, (err, fileContent) => {
    if (err) {
      return callback([]);
    }
    callback(JSON.parse(fileContent));
  });
};

module.exports = class Meal {
  constructor(id, name, imageURL, price) {
    this.id = id;
    this.name = name;
    this.imageURL = imageURL;
    this.price = price;
  }

  save() {
    getMealsFromFile((meals) => {
      meals.push(this);
      fs.writeFile(mealDataPath, JSON.stringify(meals), (err) => {
        console.log(err);
      });
    });
  }

  static fetchAll(callback) {
    getMealsFromFile(callback);
  }

  static deleteById(id) {
    getMealsFromFile((meals) => {
      const updatedMeals = meals.filter((meal) => meal.id !== id);
      fs.writeFile(mealDataPath, JSON.stringify(updatedMeals), (err) => {
        if (!err) {
        }
      });
    });
  }
};
