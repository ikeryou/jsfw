


# image.coffee

root = this;
if !root._LIBS?
	root._LIBS = {};


# ---------------------------------------------------
# imageオブジェクトラッパー
# ---------------------------------------------------
class root._LIBS.image
	
	
	# コンストラクタ
	# -----------------------------------------------
	# @src    : 画像URL
	# @width  : 幅
	# @height : 高さ
	# -----------------------------------------------
	constructor: (src, width, height, alt) ->
		
		# ファイル名
		@src    = src;
		@orgSrc = src;
		
		# サイズ
		@width     = width;
		@height    = height;
		@orgWidth  = width;
		@orgHeight = height;
		
		# Retina対応
		if root.MY.conf.IS_RETINA && root.MY.conf.IS_IMG_RETINA
			@width  = ~~(width * 0.5);
			@height = ~~(height * 0.5);
		
		# Alt
		@alt = alt;
		
		# imageオブジェクト (オリジナル)
		@_image;
		
		# コールバック imageオブジェクトの生成完了
		@onMakeData;
		
		
		# 初期化
		@_init();
		
	
	# -----------------------------------
	# 初期化
	# -----------------------------------
	_init: =>
		
		
		
		
	
	# -----------------------------------
	# 削除
	# -----------------------------------
	dispose: =>
		
		@_image = null;
		@onMakeData = null;
		
		
	# -----------------------------------
	# imageオブジェクト取得
	# -----------------------------------
	data: =>
		
		return @_image;

	
	# -----------------------------------
	# imageオブジェクトの生成
	# -----------------------------------
	makeData: =>
		
		@_image = new Image();
		@_image.onload = @_eMakedData;
		@_image.src = @src;

	
	# -----------------------------------
	# イベント imageオブジェクトの生成完了
	# -----------------------------------
	_eMakedData: =>
		
		if @_image?
			if @onMakeData? then @onMakeData();
			
		
		
		
		
		
		
		
		
		