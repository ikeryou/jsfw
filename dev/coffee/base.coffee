# ---------------------------------------------------
# base.coffee
# ---------------------------------------------------


# 全てのオブジェクトはここに追加
root = this;
root.MY = {};
root.MY_CLASS = {};

		
# ---------------------------------------------------
# FrameWork baseクラス
# ---------------------------------------------------
class root.MY_CLASS.base
	
	
	# -----------------------------------------------
	# コンストラクタ
	# -----------------------------------------------
	constructor: ->
	
		
		# 毎フレーム実行させる関数を保持
		@_updateList = [];
		
		# リサイズ時に実行させる関数を保持
		@_resizeList = [];
		
		# STATS
		@_stats;
		
		# リサイズ用タイマー
		@_rTimer;
		
		# ウィンドウサイズ
		@ws = {w:0, h:0, oldW:-1, oldH:-1};
		
		# 初期化
		@_init();
		
		
	# -----------------------------------------------
	# init
	# -----------------------------------------------
	_init: ->
		
		# 登録してある関数を毎フレーム実行させる
		setInterval(@_update, 1000 / root.MY.conf.FPS);

		# 登録してある関数をリサイズ時に実行させる
		$(window).bind("resize", @_resize);
		@_resize();
		
		# stats
		if root.MY.conf.STATS
			@setStats();
		
	
	# -----------------------------------------------
	# 更新
	# -----------------------------------------------
	_update: =>
		
		# 登録してる関数を実行
		for val, i in @_updateList
			val();
		
		# STATSの更新
		if @_stats? then @_stats.update();
		
		# TWEEN
		if TWEEN? then TWEEN.update();
			

	# -----------------------------------------------
	# 毎フレーム実行したい関数を登録
	# @func:実行したい関数
	# -----------------------------------------------
	addUpdate: (func) ->

		@_updateList.push(func);


	# -----------------------------------------------
	# 毎フレーム実行する関数を削除
	# @func:登録済み関数
	# -----------------------------------------------
	delUpdate: (func) ->

		arr = [];
		for val, i in @_updateList
			if val != func
				arr.push(val);
		@_updateList = arr;


	# -----------------------------------------------
	# リサイズ
	# -----------------------------------------------
	_resize: (e) =>
		
		w = $(window).width();
		h = $(window).height();
		
		@ws.w = w;
		@ws.h = h;
		
		# 登録してある関数を実行
		for val, i in @_resizeList
			val(w, h);
							
		@ws.oldW = w;
		@ws.oldH = h;
			

	# -----------------------------------------------
	# リサイズ時に実行したい関数を登録
	# @func:実行したい関数
	# @isCall:すぐに実行するかどうか
	# -----------------------------------------------
	addResize: (func, isCall) ->

		@_resizeList.push(func);
		if isCall? && isCall
			func(@ws.w, @ws.h);


	# -----------------------------------------------
	# リサイズ時に実行したい関数を削除
	# @func:登録済み関数
	# -----------------------------------------------
	delResize: (func) ->

		arr = [];
		for val, i in @_resizeList
			if val != func
				arr.push(val);
		@_resizeList = arr;
		
		
	# -----------------------------------------------
	# STATS表示
	# -----------------------------------------------
	setStats: ->
	
		@_stats = new Stats();
		@_stats.domElement.style.position = "fixed";
		@_stats.domElement.style.left     = "0px";
		@_stats.domElement.style.top      = "0px";
		document.body.appendChild(@_stats.domElement);
		
		
	# -----------------------------------------------
	# セットアップ
	# アプリケーション毎に関数の中身を作成する
	# 各Mainでオーバーライドする
	# -----------------------------------------------
	setup: ->

		
							

# --------------------------------------------------------------------------------------


# ページの読み込み完了
$(window).load(->
	
	# util
	root.MY.util = new root._LIBS.utils();

	# conf
	root.MY.conf = new root.MY_CLASS.conf();
	
	# main
	root.MY.main = new root.MY_CLASS.main();
	root.MY.main.setup();
);


		
		
		
		
		


