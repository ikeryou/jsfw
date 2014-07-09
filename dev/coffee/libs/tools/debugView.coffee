

# debugView.coffee

root = this;
if !root._LIBS?
	root._LIBS = {};

# ---------------------------------------------------
# デバッグ用View
# ---------------------------------------------------
class root._LIBS.debugView extends root._LIBS.display
	
	
	# コンストラクタ
	# -----------------------------------------------
	# @list : 項目リスト[]
	#					{type:種類(0..スライダー 1..トグル), name:名前, def:デフォルト値, min:最小値(スライダーのみ), max:最大値(スライダーのみ)}
	# -----------------------------------------------
	constructor: (list) ->
		
		@_list = list;
		@_parts = [];
		
		# 表示切り替えボタン
		@_vBtn;
		
		# コンテナ
		@_con;
		
		# 背景
		@_bg;
		
		# コールバック 値が変更された
		@onChange;
		
		super();
		
		
	# -----------------------------------------------
	# イベント 要素作成
	# -----------------------------------------------
	addStage: ->	
		
		@elm().css({
			position:"fixed",
			zIndex:9999
		});
		
		# コンテナ
		@_con = new root._LIBS.display();
		@addChild(@_con);
		
		# 背景
		@_bg = new root._LIBS.display();
		@_con.addChild(@_bg);
		@_bg.bgColor("#fff");
		@_bg.alpha(0.8);
		
		# パーツ作成
		for val,i in @_list
			
			if val.type == 0
				# スライダー
				parts = new root._LIBS.slider(val.min, val.max, val.def, val.name);
			else
				# トグル
				parts = new root._LIBS.toggle(val.def, val.name);
				
			@_con.addChild(parts);
			parts.y((i + 1) * 50);
			parts.onChange = @_eChange;
			
			@_parts.push(parts);
		
		@_bg.size(250, parts.y() + 70);
		@_bg.xy(-25, 0);
		
		# 表示切り替えボタン
		@_toggle = new root._LIBS.btnAreaView(20, 20);
		@addChild(@_toggle);
		@_toggle.elm().css({
			backgroundColor:"#FF0000"
			opacity:1
		});
		@_toggle.onClick = @_eClickToggle;
		@_toggle.elm().bind("touchstart", @_eClickToggle);
	
	
	# -----------------------------------------------
	# イベント 表示切り替えボタンクリック
	# -----------------------------------------------
	_eClickToggle: =>
		
		@_con.alpha(if @_con.alpha() == 1 then 0 else 1);
	
		
	# -----------------------------------------------
	# イベント スライダーの値が変更された
	# -----------------------------------------------
	_eChange: =>
		
		if @onChange?
			@onChange();
	
	
	# -----------------------------------------------
	# パラメータ取得
	# @key : 最初に渡したlistの順番
	# -----------------------------------------------
	val: (key) =>
		
		return @_parts[key].val();
		
		
	# -----------------------------------------------
	# 削除
	# -----------------------------------------------
	dispose2: =>
		
		
	
	
		
		
	