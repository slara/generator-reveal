'use strict';
var util = require('util');
var path = require('path');
var yeoman = require('yeoman-generator');


var RevealGenerator = module.exports = function RevealGenerator(args, options, config) {
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
  var welcome =
  '\n     _-----_' +
  '\n    |       |' +
  '\n    |' + '--(o)--'.red + '|   .--------------------------.' +
  '\n   `---------´  |    ' + 'Welcome to Yeoman,'.yellow.bold + '    |' +
  '\n    ' + '( '.yellow + '_' + '´U`'.yellow + '_' + ' )'.yellow + '   |   ' + 'ladies and gentlemen!'.yellow.bold + '  |' +
  '\n    /___A___\\   \'__________________________\'' +
  '\n     |  ~  |'.yellow +
  '\n   __' + '\'.___.\''.yellow + '__' +
  '\n ´   ' + '`  |'.red + '° ' + '´ Y'.red + ' `\n';

  console.log(welcome);

  var prompts = [{
    name: 'presentationTitle',
    message: "What are you going to talk about?"
  },{
    name: 'packageVersion',
    message: "What version should we put in the package.json file?",
    default: '0.0.0'
  }];

  this.prompt(prompts, function (err, props) {
    if (err) {
      return this.emit('error', err);
    }
    this.presentationTitle = props.presentationTitle;
    this.packageVersion = props.packageVersion
    cb();
  }.bind(this));
};

RevealGenerator.prototype.app = function app() {
  this.mkdir('slides');
  this.template('_index.md', 'slides/index.md');

  this.template('Gruntfile.js', 'Gruntfile.js');
  this.template('index.html', 'index.html');

  this.template('_package.json', 'package.json');
  this.template('_bower.json', 'bower.json');
  this.template('_config.json', 'config.json');
  this.copy('loadtemplates.js', 'js/loadtemplates.js');
  this.copy('main.js', 'js/main.js');
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
