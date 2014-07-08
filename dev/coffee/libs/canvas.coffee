


# canvas.coffee

root = this;
if !root._LIBS?
	root._LIBS = {};


# ---------------------------------------------------
# 表示要素クラス canvasのWrapperClass
# ---------------------------------------------------
class root._LIBS.canvas extends root._LIBS.display
	
	
	# コンストラクタ
	# -----------------------------------------------
	constructor: (elm, option) ->
		
		super(elm, option);
		
		# canvas要素ID
		@_canvasId;
		
		# canvas要素
		@_canvasElm;
		
		# canvasコンテキスト
		@_ctx;
		
	
		
	# -----------------------------------
	# 削除
	# オーバーライド用
	# -----------------------------------
	dispose2: =>
		
		@_ctx = null;
		
		if @_canvasElm?
			root.MY.util.stop(@_canvasElm);
			@_canvasElm.unbind();
			@_canvasElm.remove();
			@_canvasElm = null;
		
		
	# -----------------------------------
	# canvas設定
	# -----------------------------------
	setupCanvas: (w, h) =>
		
		if @_elm?
			@size(w,h);
			@_canvasId = @id() + "_canvas";
			if $("#" + @_canvasId).length > 0 then $("#" + @_canvasId).remove();
			@_elm.append("<canvas id='" + @_canvasId + "' width='" + @width() + "' height='" + @height() + "'></canvas>");
			@_canvasElm = $("#" + @_canvasId);
			@_canvasElm.css({
				position:"absolute",
				top:0,
				left:0
			});
			@_ctx = @_canvasElm[0].getContext("2d");
			
			
	# -----------------------------------
	# canvasのコンテキスト取得
	# -----------------------------------
	ctx: =>
		
		return @_ctx;
		
		
	# -----------------------------------
	# canvasID
	# -----------------------------------
	canvasId: =>
		
		return @_canvasId;
		
	
	# -----------------------------------
	# canvas要素
	# -----------------------------------
	canvasElm: =>
		
		return @_canvasElm;
		
	
			