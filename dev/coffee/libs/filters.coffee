


# filters.coffee

root = this;
if !root._LIBS?
	root._LIBS = {};


# ---------------------------------------------------
# フィルタークラス
# ---------------------------------------------------
class root._LIBS.filters
	
	
	# -----------------------------------------------
	# コンストラクタ
	# -----------------------------------------------
	constructor: ->
		
		



	# -----------------------------------------------
	# 着色
	# -----------------------------------------------
	color: (id, r, g, b) ->
		
		canvas = document.getElementById(id);
		ctx = canvas.getContext("2d");
		
		imgData = ctx.getImageData(0, 0, canvas.width, canvas.height);
		data = imgData.data;
		
		i = 0;
		while i < data.length
			
			data[i] = r;
			data[i + 1] = g;
			data[i + 2] = b;
		
			i += 4
		
		ctx.putImageData(imgData, 0, 0);
		
		
	