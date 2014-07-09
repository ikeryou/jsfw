
# contentsView.coffee

# ---------------------------------------------------
# コンテンツ
# ---------------------------------------------------
class root.MY_CLASS.contentsView extends root._LIBS.display
	
	
	# コンストラクタ
	# -----------------------------------------------
	constructor: (elm) ->
		
		# データ管理
		@_data;
				
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
		
		
		console.log($("body").html());
		
		testCon = new root._LIBS.display();
		@addChild(testCon);
		testCon.xy(200, 200);
		
		test2 = new root._LIBS.display("test2");
		testCon.addChild(test2);
		
		test3 = new root._LIBS.display("test3", {update:true, resize:true});
		testCon.addChild(test3);
		
		#console.log(test1); 
		#console.log(test3); 
		
		console.log($("body").html());
	
		
	# -----------------------------------
	# updateイベント
	# -----------------------------------
	update: =>
		
				
	
	# -----------------------------------
	# resizeイベント
	# -----------------------------------
	resize: =>
		
				
	
			
		
		
	