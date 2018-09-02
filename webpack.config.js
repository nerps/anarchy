//var webpack = require('webpack');
var path = require("path");

module.exports = {
	mode: 'development',
	entry: {
		app: [
			'./src/index.js'
		]
	},

	output: {
		path: path.resolve(__dirname + '/dist'),
		filename: '[name].js',
		publicPath: '/',
		//contentBase: path.resolve(__dirname + '/src')
	},
	/*plugins: [
		new webpack.HotModuleReplacementPlugin()//,
	],*/
	devServer: {
		inline: true,
		stats: 'errors-only'
	},
	module: {
		rules: [
			{
				test: /\.(css)$/,
				use: [
					'style-loader',
					'css-loader',
				]
			},
			{
				test: /\.(scss)$/,
				use: [
					'style-loader',
					'css-loader',
					'sass-loader',
				]
			},
			{
				test: /\.html$/,
				exclude: /node_modules/,
				loader: 'file-loader?name=[name].[ext]',
			},
			{
				test: /\.elm$/,
				exclude: [/elm-stuff/, /node_modules/],
				use: {				
					loader: 'elm-webpack-loader',
					options: {
						debug: true,
						cache: false,
						verbose: true,
						forceWatch: true,
					},
				},
			},
			{
				test: /\.woff(2)?(\?v=[0-9]\.[0-9]\.[0-9])?$/,
				loader: 'url-loader?limit=10000&mimetype=application/font-woff',
			},
			{
				test: /\.(ttf|eot|svg)(\?v=[0-9]\.[0-9]\.[0-9])?$/,
				loader: 'file-loader',
			}/*,
			{
				test: /\.(png|jpg|gif)$/,
				use: [
					{
						loader: 'file-loader',
						options: {}
					}
				]
			}*/
		],

		noParse: /\.elm$/,
	}

};
