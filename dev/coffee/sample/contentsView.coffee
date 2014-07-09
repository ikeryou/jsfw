
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
		
				
	
			
		
		
	