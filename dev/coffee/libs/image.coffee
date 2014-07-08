


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
	
		@src = src;
		@orgSrc = src;
		@width = width;
		@height = height;
		@alt = alt;
		
		# 半分にしたやつ
		@width05 = ~~(width * 0.5);
		@height05 = ~~(height * 0.5);
		
		# imageオブジェクト
		@_image;
		
		# コールバック imageオブジェクトの生成完了
		@onMakeData;
		
	
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
			
		
		
		
		
		
		
		
		
		