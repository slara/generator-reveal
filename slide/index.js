'use strict';
var util = require('util');
var yeoman = require('yeoman-generator');
var fs = require('fs');
var path = require('path');


var SlideGenerator = module.exports = function SlideGenerator() {
  // By calling `NamedBase` here, we get the argument to the subgenerator call
  // as `this.name`.
  yeoman.generators.NamedBase.apply(this, arguments);
};

util.inherits(SlideGenerator, yeoman.generators.NamedBase);

SlideGenerator.prototype.files = function files() {
  var appPath = process.cwd();
  var fullPath = path.join(appPath, '/slides/list.json');
  var list = require(fullPath);

  if (this.options.markdown) {
    this.filename = this._.slugify(this.name) + '.md';
    this.log.info('Using Markdown.');
  } else {
    this.filename = this._.slugify(this.name) + '.html';
    this.log.info('Using HTML.');
  }


  if (this.options.markdown) {
    if (this.options.notes) {
      this.template('slide-withnotes.md', 'slides/' + this.filename);
    } else {
      this.template('slide.md', 'slides/' + this.filename);
    }
  } else {
    if (this.options.notes) {
      this.template('slide-withnotes.html', 'slides/' + this.filename);
    } else {
      this.template('slide.html', 'slides/' + this.filename);
    }
  }

  list.push(this.filename);
  fs.writeFileSync(fullPath, JSON.stringify(list, null, 4));
};
