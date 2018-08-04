var webpack = require('webpack');
var WebpackDevServer = require('webpack-dev-server');
var config = require('./webpack.config.js');

new WebpackDevServer(webpack(config), {
	inline: true,
	historyApiFallback: true,
	hot: true,
	stats: { colors: true },
	quiet: false,
	overlay: true,
	port: 8080,
	publicPath: "http://localhost:8080/",

	contentBase: config.output.path,
	watchContentBase: true,
	watchOptions: {
		ignored: "/node_modules/"
	},
}).listen(8080, 'localhost', function (err, result) {
	if (err) {
		console.log(err);
	}

	console.log('Listening at localhost:8080');
});
