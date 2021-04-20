const path = require("path");
const CopyWebpackPlugin = require("copy-webpack-plugin");

module.exports = {
  mode: 'development',
  entry: "./src/index.js",
  output: {
    filename: "index.js",
    path: path.resolve(__dirname, "dist"),
  },
  
  plugins: [
    new CopyWebpackPlugin([
      { from: "./src/index.html", to: "index.html" },
      { from: "./src/Mainpage.html", to: "Mainpage.html" },
      { from: "./src/style.css", to: "style.css" },
      { from: "./src/Patient.html", to: "Patient.html" },
      { from: "./src/Doctors.html", to: "Doctors.html" },
      { from: "./src/Insurance.html", to: "Insurance.html" }
    ]),
  ],
  devServer: { contentBase: path.join(__dirname, "dist"), compress: true },
};
