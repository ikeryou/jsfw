
# -----------------------
# ONDO
# -----------------------

module.exports = (grunt) ->

	
	pkg = grunt.file.readJSON('package.json');
	
	# メタ情報
	meta = require('./meta.json');
	
	# 開発環境パス
	devPath = "dev/";
	
	# カレントパス
	currentPath = "current/";
	
	# jsファイル出力パス
	currentJsPath = "current/";
	
	# coffeeファイルパス
	coffeePath = devPath + "coffee/";
	
	# templateファイルパス
	templatePath = devPath + "template/";
		
	# jsファイルパス
	jsPath = devPath + "js/";
	
	# 使用するjsファイル
	jsLibs = [
		jsPath + "jquery-1.11.1.min.js",
		jsPath + "Stats.js"
	];
	
	# 各ページjsファイル
	pageJsFiles = [
		currentJsPath + "assets/js/main.js"
	];
	
	# 各ページで使用するcoffoeeファイル
	pageCoffeeFile = [
		[
			coffeePath + "libs/base/*.coffee",
			coffeePath + "libs/3d/*.coffee",
			coffeePath + "libs/tools/*.coffee",
			coffeePath + "libs/*.coffee",
			coffeePath + "base.coffee",
			coffeePath + "conf.coffee",
			coffeePath + "main.coffee",
			coffeePath + "sample/**/*.coffee"
		]
	];
	

	# coffeeコンパイル用
	coffeeCompileFiles = {};
	for val, i in pageJsFiles
		coffeeCompileFiles[val] = pageCoffeeFile[i];
	
	# jsファイル結合用
	concatFiles = {};
	for val, i in pageJsFiles
		concatFiles[i] = {dest:val, src:jsLibs.concat(val)};

	# jsファイル圧縮用
	compressJsFiles = {};
	for val, i in pageJsFiles
		compressFiles = {files:{}};
		compressFiles.files[val] = val;
		compressJsFiles[i] = compressFiles;

		
	
	# -------------------------------------------------------
	# config
	# -------------------------------------------------------
	grunt.initConfig({
		ect:{
			options:{
				root:templatePath
			},
			index:{
				src:"index.ect",
				dest:currentPath + "index.html",
				variables:{
					keywords:meta.keywords,
					description:meta.description,
					title:meta.title,
					url:meta.url,
					ogImg:meta.ogImg
				}
			}
		},
		coffee:{
			compile:{
				options:{
					bare:false,
					join:true
				},
				files:coffeeCompileFiles
			}
		},
		concat:concatFiles,
		uglify:compressJsFiles,
		img:{
			dist:{
				src:[currentPath + "**/*.jpg", currentPath + "**/*.png", currentPath + "**/*.jpeg"]
			}
		},
		optipng: {
	    args: ['-o5']
	  },
		watch:{
			files:[devPath + "**/*.coffee", devPath + "**/*.ect", "Gruntfile.coffee"],
			tasks:["default"]
		}
	});
	
	# プラグイン
	for val of pkg.devDependencies
		if val.substring(0, 6) == "grunt-" then grunt.loadNpmTasks(val);
			
	# タスク登録
	grunt.registerTask("default", ["ect","coffee","concat","watch"]);
	