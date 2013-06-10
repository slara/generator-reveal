'use strict';
var util = require('util');
var yeoman = require('yeoman-generator');

var SlideGenerator = module.exports = function SlideGenerator(args, options, config) {
  // By calling `NamedBase` here, we get the argument to the subgenerator call
  // as `this.name`.
  yeoman.generators.NamedBase.apply(this, arguments);

  console.log('You called the slide subgenerator with the argument ' + this.name + '.');
};

util.inherits(SlideGenerator, yeoman.generators.NamedBase);

SlideGenerator.prototype.files = function files() {
  var filename = 'slides/' + this._.slugify(this.name) + '.md';
  this.template('slide.md', filename);
};
