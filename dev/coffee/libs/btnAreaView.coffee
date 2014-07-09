

# btnAreaView.coffee

root = this;
if !root._LIBS?
	root._LIBS = {};

# ---------------------------------------------------
# ボタンエリア
# ---------------------------------------------------
class root._LIBS.btnAreaView extends root._LIBS.display
	
	
	# コンストラクタ
	# -----------------------------------------------
	constructor: (width, height) ->
		
		super();
		
		# サイズ
		@_width = width;
		@_height = height;
		
		# コールバック
		@onClick;
		@onRollOver;
		@onRollOut;
		

	# -----------------------------------------------
	# イベント 要素作成
	# -----------------------------------------------
	addStage: ->	
		
		@size(@_width, @_height);
		@elm().css({
			backgroundColor:"#FF0000",
			opacity:0
		});
		@setBtn([@_eRollOver], [@_eRollOut], [@_eClick]);
		
		if root.MY.conf.IS_V_BTNAREA
			@visible(true);
		
	
	# -----------------------------------
	# 削除
	# -----------------------------------
	dispose2: =>
		
		@onClick = null;
		@onRollOver = null;
		@onRollOut = null;
	
	
	# -----------------------------------
	# 表示設定
	# -----------------------------------
	visible: (flg) =>
		
		if flg
			@elm().css({
				opacity:0.5
			});
		else
			@elm().css({
				opacity:0
			});
	
	
	# -----------------------------------
	# イベント ロールオーバー
	# -----------------------------------
	_eRollOver: =>
		
		root.MY.util.buttonMode(true);
		if @onRollOver? then @onRollOver();
		
	
	# -----------------------------------
	# イベント ロールアウト
	# -----------------------------------
	_eRollOut: =>
		
		root.MY.util.buttonMode(false);
		if @onRollOut? then @onRollOut();
		
	
	# -----------------------------------
	# イベント クリック
	# -----------------------------------
	_eClick: =>
		
		if @onClick? then @onClick();
		
		
	
	
		
	