


# rectangle.coffee

root = this;
if !root._LIBS?
	root._LIBS = {};


# ---------------------------------------------------
# rectangleクラス
# ---------------------------------------------------
class root._LIBS.rectangle
	
	
	# コンストラクタ
	# -----------------------------------------------
	constructor: (x, y, width, height) ->
	
		@x = x;
		@y = y;
		@width = width;
		@height = height;
				
	
	# -----------------------------------
	# 削除
	# -----------------------------------
	dispose: =>
		
		
	
	# -----------------------------------
	# 右端
	# -----------------------------------
	right: =>
		
		return @x + @width;
		
	
	# -----------------------------------
	# 下
	# -----------------------------------
	bottom: =>
		
		return @y + @height;

	
	# -----------------------------------
	# 矩形領域内にあるか
	# -----------------------------------
	contains: (chkX, chkY) =>
		
		return (chkX >= @x && chkX <= @right() && chkY >= @y && chkY <= @bottom());
		

		
		
		
		
		
		
		
		
		
		
		