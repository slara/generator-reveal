'use strict';
var util = require('util');
var path = require('path');
var yeoman = require('yeoman-generator');
var semver = require('semver');

var RevealGenerator = module.exports = function RevealGenerator(args, options) {
  yeoman.generators.Base.apply(this, arguments);

  this.on('end', function () {
    this.installDependencies({ skipInstall: options['skip-install'] });
  });

  this.pkg = JSON.parse(this.readFileAsString(path.join(__dirname, '../package.json')));
};

util.inherits(RevealGenerator, yeoman.generators.Base);

RevealGenerator.prototype.askFor = function askFor() {
  var cb = this.async();

  // welcome message
  console.log(this.yeoman);

  var prompts = [{
    name: 'presentationTitle',
    message: 'What are you going to talk about?'
  },
  {
    name: 'packageVersion',
    message: 'What version should we put in the package.json file?',
    default: '0.0.0',
    validate: function (input) {
      if (!semver.valid(input)) {
        return 'Please enter a correct semver version, i.e. MAJOR.MINOR.PATCH.';
      } else {
        return true;
      }
    }
  }];

  this.prompt(prompts, function (props) {
    this.presentationTitle = props.presentationTitle;
    this.packageVersion = props.packageVersion;
    cb();
  }.bind(this));
};

RevealGenerator.prototype.app = function app() {
  this.mkdir('slides');
  this.template('_index.md', 'slides/index.md');

  this.template('Gruntfile.coffee', 'Gruntfile.coffee');
  this.template('index.tpl', 'index.tpl');

  this.template('_package.json', 'package.json');
  this.template('_bower.json', 'bower.json');
  this.template('_config.json', 'config.json');
  this.copy('loadhtmlslides.js', 'js/loadhtmlslides.js');
  this.copy('list.json', 'slides/list.json');
};

RevealGenerator.prototype.projectfiles = function projectfiles() {
  this.copy('editorconfig', '.editorconfig');
  this.copy('jshintrc', '.jshintrc');
};

RevealGenerator.prototype.runtime = function runtime() {
  this.copy('bowerrc', '.bowerrc');
  this.copy('gitignore', '.gitignore');
};
