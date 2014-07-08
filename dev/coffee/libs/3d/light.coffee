


# light.coffee

root = this;
if !root._LIBS?
	root._LIBS = {};


# ---------------------------------------------------
# ライト管理クラス
# ---------------------------------------------------
class root._LIBS.light
	
	
	# コンストラクタ
	# -----------------------------------------------
	constructor: (x, y, z, brightness) ->
	
		@x = x;
		@y = y;
		@z = z;
		
		@_brightness = brightness;
		
	
	# -----------------------------------
	# 削除
	# -----------------------------------
	dispose: =>
		
	
	
	# -----------------------------------
	# 明るさ
	# -----------------------------------
	brightness: (val) =>
		
		if !val?
			return @_brightness;
		else
			@_brightness = Math.max(val, 0);
			@_brightness = Math.min(@_brightness, 1);
			
	