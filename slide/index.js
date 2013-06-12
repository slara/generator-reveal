'use strict';
var util = require('util');
var yeoman = require('yeoman-generator');
var fs = require('fs');
var path = require('path');

var SlideGenerator = module.exports = function SlideGenerator(args, options, config) {
  // By calling `NamedBase` here, we get the argument to the subgenerator call
  // as `this.name`.
  yeoman.generators.NamedBase.apply(this, arguments);

  console.log('You called the slide subgenerator with the argument ' + this.name + '.');
};

util.inherits(SlideGenerator, yeoman.generators.NamedBase);

SlideGenerator.prototype.files = function files() {
  var filename = this._.slugify(this.name) + '.md';
  var fullfilename = 'slides/' + filename;
  this.template('slide.md', fullfilename);
  var appPath = process.cwd();
  var fullPath = path.join(appPath, '/slides/list.json');
  var list = require(fullPath);
  list.push(filename);
  fs.writeFileSync(fullPath, JSON.stringify(list))
};
