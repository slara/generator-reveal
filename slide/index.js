'use strict';
var util = require('util');
var yeoman = require('yeoman-generator');
var fs = require('fs');
var path = require('path');


var SlideGenerator = module.exports = function SlideGenerator() {
  // By calling `NamedBase` here, we get the argument to the subgenerator call
  // as `this.name`.
  yeoman.generators.NamedBase.apply(this, arguments);

  console.log('You called the slide subgenerator with the argument ' + this.name + '.');

  if (this.options.markdown) {
    this.useMarkdown = true;
    this.filename = this._.slugify(this.name) + '.md';
    console.log('Using Markdown!', this.filename);
  } else {
    this.useMarkdown = false;
    this.filename = this._.slugify(this.name) + '.html';
    console.log('Using HTML!', this.filename);
  }
};

util.inherits(SlideGenerator, yeoman.generators.NamedBase);

SlideGenerator.prototype.files = function files() {
  var appPath = process.cwd();
  var fullfilename = path.join(appPath, '/slides/' + this.filename);
  if (this.useMarkdown) {
    if (this.options.notes) {
      this.template('slide-withnotes.md', fullfilename);
    } else {
      this.template('slide.md', fullfilename);
    }
  } else {
    if (this.options.notes) {
      this.template('slide-withnotes.html', fullfilename);
    } else {
      this.template('slide.html', fullfilename);
    }
  }
  var fullPath = path.join(appPath, '/slides/list.json');
  var list = require(fullPath);
  list.push(this.filename);
  fs.writeFileSync(fullPath, JSON.stringify(list, null, 4));
};
