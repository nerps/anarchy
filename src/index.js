'use strict';

require('ace-css/css/ace.min.css');
require('font-awesome/css/font-awesome.css');

require('./selectize.scss'); // elm selectize drop-down
require('./elm-styles.css'); // custom styles

require('../node_modules/bootstrap/dist/css/bootstrap.min.css');

// Require index.html so it gets copied to dist
require('./index.html');

var pdfjsLib = require('pdfjs-dist');
// Setting worker path to worker bundle.
pdfjsLib.GlobalWorkerOptions.workerSrc = '../../build/webpack/pdf.worker.bundle.js';

var DEBUG_PDF = './Shadowrun_Anarchy.pdf';
var loadingTask = pdfjsLib.getDocument(DEBUG_PDF);
var canvas;
loadingTask.promise.then(function (pdfDocument) {
	// Request a first page
	return pdfDocument.getPage(216).then(function (pdfPage) {
		// Display page on the existing canvas with 100% scale.
		var viewport = pdfPage.getViewport(2.0);
		canvas = document.createElement("canvas");
		canvas.width = viewport.width;
		canvas.height = viewport.height;
		var ctx = canvas.getContext('2d');
		var renderTask = pdfPage.render({
			canvasContext: ctx,
			viewport: viewport
		});
		return renderTask.promise;
	});
}).then(function () {
	var dataUrl = canvas.toDataURL();
	var div = document.getElementsByClassName('container-fluid')[0];
	div.style.background = 'url('+dataUrl+')';
	return;
})
.catch(function (reason) {
	console.error('Error: ' + reason);
});


function readSingleFile(e) {
	var file = e.target.files[0];
	if (!file) {
		return;
	}
	var reader = new FileReader();
	reader.onload = function(e) {
		var contents = e.target.result;

		var loadingTask = pdfjsLib.getDocument(contents);
		loadingTask.promise.then(function (pdfDocument) {
			// Request a first page
			return pdfDocument.getPage(216).then(function (pdfPage) {
				// Display page on the existing canvas with 100% scale.
				var viewport = pdfPage.getViewport(2.0);
				var canvas = document.getElementById('theCanvas');
				canvas.width = viewport.width;
				canvas.height = viewport.height;
				canvas.style.width = '1110px';
				canvas.style.position = 'absolute';
				canvas.style['z-index'] = -99999;
				canvas.style.top = 0;
				var ctx = canvas.getContext('2d');
				var renderTask = pdfPage.render({
					canvasContext: ctx,
					viewport: viewport
				});
				return renderTask.promise;
			});
		}).catch(function (reason) {
			console.error('Error: ' + reason);
		});
	};
	reader.readAsDataURL(file);
}

document.getElementById('file-input')
	.addEventListener('change', readSingleFile, false);


var Elm = require('./Main.elm');
var mountNode = document.getElementById('main');
mountNode.children[0].remove();

// .embed() can take an optional second argument. This would be an object describing the data we need to start a program, i.e. a userID or some token
var app = Elm.Main.embed(mountNode);