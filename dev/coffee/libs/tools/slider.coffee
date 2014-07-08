

# slider.coffee

root = this;
if !root._LIBS?
	root._LIBS = {};

# ---------------------------------------------------
# デバッグ用スライダー
# ---------------------------------------------------
class root._LIBS.slider extends root._LIBS.display
	
	
	# コンストラクタ
	# -----------------------------------------------
	constructor: (id, min, max, def, name) ->
		
		super(id, {resize:false});
		
		# 背景
		@_bgElm;
		
		# ボタン
		@_btnElm;
		
		# ボタン位置パラメータ
		@_btnPara = {
			x:0,
			offsetX:0,
			min:0,
			max:0
		};
		
		# 名前
		@_name = name;
		@_nameElm;
		
		# 数値パラメータ
		@_numPara = {
			min:min,
			max:max,
			def:def,
			old:def,
			now:def
		};
		
		# スライド用マウスパラメータ
		@_mouse = {
			x:0,
			startX:0,
			isDown:false
		};
		
		# フラグ 機能させるかどうか
		@_isOnSlider = false;
		
		# フラグ スマホかどうか
		@_isSmt = (
			navigator.userAgent.indexOf('iPad') > 0 ||
			navigator.userAgent.indexOf('iPhone') > 0 ||
			navigator.userAgent.indexOf('iPod') > 0 ||
			navigator.userAgent.indexOf('Android') > 0
		);
		
		# コールバック 値変更された
		@onChange;
		
		
	# -----------------------------------------------
	# イベント 要素作成
	# -----------------------------------------------
	addStage: ->	
		
		# 名前
		@_nameElm = new root._LIBS.display(@id() + "_name", {resize:false, update:false});
		@addChild(@_nameElm);
		@_updateNum(@_numPara.def);
		@_nameElm.elm().css({
			fontSize:"80%"
		});
		
		# 背景
		@_bgElm = new root._LIBS.display(@id() + "_bg", {resize:false, update:false});
		@addChild(@_bgElm);
		
		# ボタン
		@_btnElm = new root._LIBS.display(@id() + "_btn", {resize:false, update:false});
		@addChild(@_btnElm);
		
		# ボタンイベント設定
		if @_isSmt
			@_btnElm.elm().bind("touchstart", @_eMouseDown).bind("touchend", @_eMouseUp).bind("touchmove", @_eMouseMove);
		else
			@elm().bind("mousedown", @_eMouseDown).bind("mouseup", @_eMouseUp).bind("mousemove", @_eMouseMove);
		
	
	# -----------------------------------------------
	# イベント マウスダウン
	# -----------------------------------------------
	_eMouseDown: (e) =>
		
		if @_mouse.isDown then return;
		
		touches = event.touches;
		if touches? && touches.length > 0
			@_mouse.x = @_mouse.startX = touches[0].pageX;
			@_mouse.isDown = true;
			@_btnPara.offsetX = root.MY.util.floor(@_btnPara.x, @_btnPara.min, @_btnPara.max);
			@_numPara.old = @_numPara.now;
		
		if !@_isSmt
			@_mouse.x = @_mouse.startX = e.clientX;
			@_mouse.isDown = true;
			@_btnPara.offsetX = root.MY.util.floor(@_btnPara.x, @_btnPara.min, @_btnPara.max);
			@_numPara.old = @_numPara.now;
		
	
	# -----------------------------------------------
	# イベント マウスアップ
	# -----------------------------------------------
	_eMouseUp: (e) =>
		
		@_mouse.isDown = false;
		if @_numPara.old != @_numPara.now
			if @onChange?
				@onChange(@id());
		
	
	# -----------------------------------------------
	# イベント マウスムーブ
	# -----------------------------------------------
	_eMouseMove: (e) =>
		
		if @_mouse.isDown
			
			touches = event.touches;
			if touches? && touches.length > 0
				@_mouse.x = touches[0].pageX;	
			else
				@_mouse.x = e.clientX;
				
				
	# -----------------------------------
	# 数値更新
	# -----------------------------------
	_updateNum: (num) =>
		
		@_nameElm.text(@_name + "::" + num);

	
	# -----------------------------------------------
	# スライダーのデザイン設定
	# -----------------------------------------------
	setSlider: (width, height, bgColor, btnColor) =>
		
		@_isOnSlider = true;
		
		@_bgElm.size(width, height);
		@_bgElm.bgColor(bgColor);
		
		@_btnElm.size(height, height);
		@_btnElm.bgColor(btnColor);
		
		@_nameElm.width(width);
		@_nameElm.textColor(bgColor);
		
		@_bgElm.xy(0, @_nameElm.textHeight() + 3);
		@_btnElm.y(@_bgElm.y());
		
		@_btnPara.min = 0;
		@_btnPara.max = width - height;
		
		@_btnPara.x = root.MY.util.map(@_numPara.def, @_btnPara.min, @_btnPara.max, @_numPara.min, @_numPara.max);
		@_btnElm.x(@_btnPara.x);
		
		
		
	# -----------------------------------
	# updateイベント
	# -----------------------------------
	update: =>
		
		u = root.MY.util;
		
		if @_mouse.isDown 
			
			@_btnPara.x = @_btnPara.offsetX - (@_mouse.startX - @_mouse.x);
			@_btnPara.x = root.MY.util.floor(@_btnPara.x, @_btnPara.min, @_btnPara.max);
			@_btnElm.x(@_btnPara.x);
			
			num = u.map(@_btnPara.x, @_numPara.min, @_numPara.max, @_btnPara.min, @_btnPara.max);
			@_numPara.now = ~~num;
			@_updateNum(@_numPara.now);
		
	
	# -----------------------------------
	# 現在の値
	# -----------------------------------
	sliderVal: =>
		
		return @_numPara.now;
	
	
	# -----------------------------------
	# 削除
	# -----------------------------------
	dispose2: =>
		
		
	
	
		
		
	