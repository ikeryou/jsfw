
# contentsView.coffee

# ---------------------------------------------------
# コンテンツ
# ---------------------------------------------------
class root.MY_CLASS.contentsView extends root._LIBS.display
	
	
	# コンストラクタ
	# -----------------------------------------------
	constructor: (elm) ->
		
		# 画像管理
		@_imgData;
				
		super(elm);


		
	# -----------------------------------------------
	# セットアップ
	# -----------------------------------------------
	setup: =>	
		
		#@set3d();
		
		
		test1 = new root._LIBS.display();
		@addChild(test1);
		test1.size(300, 300);
		test1.bgColor("#ff0000");
		test1.xy(0, 0);
		
		test1.set3d(0, 0);
		test1.rotate(0, 0, 45);
		test1.translate(0, 0);
		test1.scale(1.5, 1.5);
		test1.setTransform();
		
		
		#console.log($("body").html());
		
		testCon = new root._LIBS.display();
		@addChild(testCon);
		testCon.xy(200, 200);
		
		test2 = new root._LIBS.display("test2");
		testCon.addChild(test2);
		
		test3 = new root._LIBS.display("test3", {update:true, resize:true});
		testCon.addChild(test3);
		
		#console.log(test1); 
		#console.log(test3); 
		
		#console.log($("body").html());
		
		
		test4 = new root._LIBS.borderView(200, 200, "#00FF00", 5);
		testCon.addChild(test4);
		
		btn1 = new root._LIBS.btnAreaView(50, 50);
		testCon.addChild(btn1);
		btn1.onClick = =>
			console.log("unko");
		;
		
		
		# toggle = new root._LIBS.toggle(true, "TEST");
# 		@addChild(toggle);
# 		toggle.xy(200, 20);
		
		# slider = new root._LIBS.slider(0, 100, 50, "TEST");
# 		@addChild(slider);
# 		slider.xy(200, 20);


		debug = new root._LIBS.debugView([
			{type:0, name:"SLIDER01", def:50, min:0, max:100},
			{type:0, name:"SLIDER02", def:20, min:0, max:200},
			{type:1, name:"TOGGLE01", def:true},
			{type:0, name:"SLIDER03", def:20, min:0, max:300},
			{type:1, name:"TOGGLE02", def:false}
		]);
		@addChild(debug);
		debug.xy(200, 20);
		
		
		
				
		# 画像管理
		@_imgData = new root._LIBS.imagesMgr(
			[
				"dummy0.jpg",
				"dummy1.jpg",
				"dummy2.jpg",
				"dummy3.jpg"
			], 
			root.MY.conf.PATH_IMG, 
			root.MY.conf.IS_U_IE8
		);
		@_imgData.onComplete = @_eCompleteImages;
		@_imgData.onProgress = @_eProgressImages;
		@_imgData.load();
	
	
	# -----------------------------------
	# イベント 画像読み込み完了
	# -----------------------------------
	_eCompleteImages: =>
		
		console.log("_eCompleteImages");
		
		console.log(@_imgData.get(3));
			
	
	# -----------------------------------
	# イベント 画像読み込み中
	# -----------------------------------
	_eProgressImages: (pct) =>
		
		console.log("_eProgressImages", pct);
		
	
	
		
	# -----------------------------------
	# updateイベント
	# -----------------------------------
	update: =>
		
				
	
	# -----------------------------------
	# resizeイベント
	# -----------------------------------
	resize: =>
		
				
	
			
		
		
	