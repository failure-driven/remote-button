const { environment } = require("@rails/webpacker");
const svelte = require('./loaders/svelte')

const webpack = require("webpack");

environment.plugins.prepend(
  "Provide",
  new webpack.ProvidePlugin({
    $: "jquery",
    jQuery: "jquery",
    jquery: "jquery",
    "window.jQuery": "jquery",
    Popper: ["popper.js", "default"],
  })
);

environment.loaders.prepend('svelte', svelte)
module.exports = environment;
