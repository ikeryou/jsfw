

# toggle.coffee

root = this;
if !root._LIBS?
	root._LIBS = {};

# ---------------------------------------------------
# デバッグ用トグルボタン
# ---------------------------------------------------
class root._LIBS.toggle extends root._LIBS.display
	
	
	# コンストラクタ
	# -----------------------------------------------
	# @def  : true or false
	# @name : 名前
	# -----------------------------------------------
	constructor: (def, name) ->
		
		super();
		
		# 現在の値
		@_val = def;
		
		# チェックボックス
		@_checkBox;
		
		# チェックボックス マーク
		@_checkBoxMark;
		
		# ボタンエリア
		@_btnArea;
				
		# 名前
		@_name = name;
		@_toggleName;
		
				
		# コールバック 値変更された
		@onChange;
		
		
	# -----------------------------------------------
	# イベント 要素作成
	# -----------------------------------------------
	addStage: ->	
		
		# 名前
		@_toggleName = new root._LIBS.display();
		@addChild(@_toggleName);
		@_updateVal();
		@_toggleName.elm().css({
			fontSize:"80%",
			fontWeight:"bold"
		});
		
		# チェックボックス
		@_checkBox = new root._LIBS.display();
		@addChild(@_checkBox);
		@_checkBox.size(20, 20);
		@_checkBox.bgColor(root.MY.conf.DEBUG_MAIN_COLOR1);
		@_checkBox.y(@_toggleName.textHeight());
		
		# チェックボックス マーク
		@_checkBoxMark = new root._LIBS.display();
		@addChild(@_checkBoxMark);
		@_checkBoxMark.size(12, 12);
		@_checkBoxMark.bgColor(root.MY.conf.DEBUG_MAIN_COLOR2);
		@_checkBoxMark.xy(@_checkBox.x() + 4, @_checkBox.y() + 4);
		if !@_val then @_checkBoxMark.alpha(0);
		
		# ボタンエリア
		@_btnArea = new root._LIBS.btnAreaView(20, 20);
		@addChild(@_btnArea);
		@_btnArea.onClick = @_eClick;
		@_btnArea.xy(@_checkBox.x(), @_checkBox.y());
				
	
	# -----------------------------------------------
	# イベント クリック
	# -----------------------------------------------
	_eClick: (e) =>
		
		@_val = !@_val;
		@_updateVal();
	
				
	# -----------------------------------
	# 値更新
	# -----------------------------------
	_updateVal: =>
		
		@_toggleName.text(@_name + "::" + @_val);
		if @_checkBoxMark? then @_checkBoxMark.alpha(if @_val then 1 else 0);

	
	# -----------------------------------
	# 値取得
	# -----------------------------------
	val: =>
		
		return @_val;
	
	
	# -----------------------------------
	# 削除
	# -----------------------------------
	dispose2: =>
		
		
	
	
		
		
	