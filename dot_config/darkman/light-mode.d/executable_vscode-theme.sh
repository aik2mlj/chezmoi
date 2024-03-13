#!/bin/node

/*
  Set the theme for visual studio code
  based on the given argument.
*/

var path = "/home/aik2/.config/Code/User/settings.json";
var settings = require(path);

settings["workbench.colorTheme"] = "Default Light Modern";

const fs = require('fs');
try {
  fs.writeFileSync(path, JSON.stringify(settings, null, 4));
} catch (err) {
  console.error(err);
}
