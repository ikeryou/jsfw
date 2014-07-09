

# borderView.coffee

root = this;
if !root._LIBS?
	root._LIBS = {};

# ---------------------------------------------------
# 矩形ボーダー
# ---------------------------------------------------
class root._LIBS.borderView extends root._LIBS.display
	
	
	# コンストラクタ
	# -----------------------------------------------
	constructor: (width, height, color, weight) ->
		
		super();
		
		# 色
		@_color = color;
		
		# 太さ
		@_weight = weight;
		
		@_width2 = width;
		@_height2 = height;
		
		@_top;
		@_left;
		@_bottom;
		@_right;
		

	# -----------------------------------------------
	# イベント 要素作成
	# -----------------------------------------------
	addStage: ->	
		
		@size(@_width2, @_height2);
		
		@_top = new root._LIBS.display();
		@addChild(@_top);
		
		@_left = new root._LIBS.display();
		@addChild(@_left);
		
		@_bottom = new root._LIBS.display();
		@addChild(@_bottom);
		
		@_right = new root._LIBS.display();
		@addChild(@_right);
		
		@changeBorder(@width(), @height());
		
	
	# -----------------------------------
	# 削除
	# -----------------------------------
	dispose2: =>
		
		if @_top?
			@_top.dispose();
			@_top = null;
		
		if @_left?
			@_left.dispose();
			@_left = null;
		
		if @_bottom?
			@_bottom.dispose();
			@_bottom = null;
		
		if @_right?
			@_right.dispose();
			@_right = null;
			
		
	# -----------------------------------
	# サイズの変更
	# -----------------------------------
	changeBorder: (width, height, color, weight) =>
		
		@size(width, height);
		
		if color? then @_color = color;
		if weight? then @_weight = weight;
		
		@_top.elm().css("backgroundColor", @_color);
		@_left.elm().css("backgroundColor", @_color);
		@_bottom.elm().css("backgroundColor", @_color);
		@_right.elm().css("backgroundColor", @_color);
		
		@_top.xy(0, 0);
		@_top.size(@width(), @_weight);
		
		@_left.xy(0, 0);
		@_left.size(@_weight, @height());
		
		@_bottom.xy(0, @height() - @_weight);
		@_bottom.size(@width(), @_weight);
		
		@_right.xy(@width() - @_weight, 0);
		@_right.size(@_weight, @height());
		
		
		
	
	
		
	