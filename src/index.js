'use strict';

require('ace-css/css/ace.min.css');
require('font-awesome/css/font-awesome.css');

require('./selectize.scss'); // elm selectize drop-down
require('./elm-styles.css'); // custom styles

require('../node_modules/bootstrap/dist/css/bootstrap.min.css');

// Require index.html so it gets copied to dist
require('./index.html');

var Elm = require('./Main.elm');
var mountNode = document.getElementById('main');
mountNode.children[0].remove();

// .embed() can take an optional second argument. This would be an object describing the data we need to start a program, i.e. a userID or some token
var app = Elm.Main.embed(mountNode);