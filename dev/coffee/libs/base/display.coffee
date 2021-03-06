


# display.coffee

root = this;
if !root._LIBS?
	root._LIBS = {};


# ---------------------------------------------------
# 表示要素クラス
# ---------------------------------------------------
class root._LIBS.display
	
	
	# コンストラクタ
	# -----------------------------------------------
	# @elm : jQueryエレメント、ID名、省略した場合optionに
	# @option : update..updateイベントを実行させるかどうか(デフォルトfalse) 
	#           resize..resizeイベントを実行させるかどうか(デフォルトfalse)
	# -----------------------------------------------
	constructor: (elm, option) ->
		
		if !option? && elm? && !elm.attr? && typeof elm != "string"
			option = elm;
				
		# ID名
		if typeof elm == "string"
			@_id = elm;
		else
			@_id = if elm? && elm.attr? then elm.attr("id") else root.MY.conf.ID + "Elm" + root.MY.main.makeElmCnt++;
		
		# 要素
		@_elm = if elm? && elm.attr? then elm else null;
		
		# utilオブジェクト(参照)
		@_u = root.MY.util;
		
		# transform3Dを使えるかどうか
		@_isUse3D = !root.MY.conf.IS_U_IE9;
		
		# updateイベント実行
		@_isUpdate = if option? && option.update? then option.update else false;
		
		# resizeイベント実行
		@_isResize = if option? && option.resize? then option.resize else false;
		
		# 画像セットした場合のimage
		@_image;
		
		# 位置
		@_position = {x:0, y:0};
		
		# サイズ
		@_size = {width:0, height:0};
		
		# TransForm値
		@_transform = {
			dx:0,
			dy:0,
			dz:0,
			scaleX:1,
			scaleY:1,
			scaleZ:1,
			rotX:0,
			rotY:0,
			rotZ:0
		};
		
		# 透明度
		@_alpha = 1;
		
		# マウス座標
		@_mouse = {x:0, y:0, oldX:0, oldY:0};
		
		# テキスト
		@_text = "";
		
		# タイマー
		@_tm = [];
		
		# 画像データ
		@_imgData = [];
		
		
		# 初期化
		@init();
	
	
	# -----------------------------------
	# 初期化
	# -----------------------------------
	init: =>
		
		if @_elm?
		
			@_elm.css({
				position:"absolute",
				top:0,
				left:0
			});
		
			@addStage();
		
			if @_isUpdate
				root.MY.main.addUpdate(@update);
			
			if @_isResize
				root.MY.main.addResize(@resize, true);
		
		
	
	# -----------------------------------
	# 要素作成イベント
	# -----------------------------------
	addStage: =>
	
	
	
	
	# -----------------------------------
	# updateイベント
	# -----------------------------------
	update: =>
	
	
	
	# -----------------------------------
	# resizeイベント
	# -----------------------------------
	resize: =>
	
	
	
	# -----------------------------------
	# 削除
	# -----------------------------------
	dispose: =>
		
		@dispose2();
		
		if @_tm?
			for val,i in @_tm
				if val?
					clearTimeout(val);
					@_tm[i] = null;
			@_tm = null;
		
		if @_imgData?
			for val,i in @_imgData
				if val?
					val.dispose();
					@_imgData[i] = null;
			@_imgData = null;
		
		if @_isUpdate
			root.MY.main.delUpdate(@update);
		
		if @_isResize
			root.MY.main.delResize(@resize);
		
		if @_elm?
			if $("#" + @id() + " img").length > 0
				root.MY.util.stop($("#" + @id() + " img"));
			
			root.MY.util.stop(@_elm);
			@_elm.unbind();
			@_elm.remove();
			@_elm = null;
			
		if @_image?
			@_image.dispose();
			@_image = null;
		
		@_position = null;
		@_size = null;
		@_mouse = null;
		@_transform = null;
		@_u = null;
		
	
	# -----------------------------------
	# 削除
	# オーバーライド用
	# -----------------------------------
	dispose2: =>
		
	
	
	# -----------------------------------
	# 要素を追加
	# @view : viewオブジェクト
	# -----------------------------------
	addChild: (view) =>
		
		if @_elm?
			
			if $("#" + view.id()).length > 0
				
				# 存在してたら移動
# 				@_elm.appendTo($("#" + view.id()));
				$("#" + view.id()).appendTo(@_elm);
				
			else
				
				# 新規に作成
				@_elm.append("<div id='" + view.id() + "'></div>");
			
			view.setupElm();
			view.init();
			
			
	# -----------------------------------
	# 要素を先頭に追加
	# @view : viewオブジェクト
	# -----------------------------------
	unshiftChild: (view) =>
		
		if @_elm?
			
			@_elm.prepend("<div id='" + view.id() + "'></div>");
			view.setupElm();
			view.init();
		
		
	# -----------------------------------
	# テキスト
	# -----------------------------------
	text: (val, f) =>
		
		if !val? && !f?
			return @_text;
		else
			if @_elm?
				@_elm.html(val);
				if f? && f != ""
					@_elm.addClass(f);
				@_text = val;
		
	
	# -----------------------------------
	# テキストの色
	# -----------------------------------
	textColor: (color) =>
		
		if @_elm?
			@_elm.css({
				color:color
			});
			
			
	# -----------------------------------
	# テキストの幅
	# -----------------------------------
	textWidth: =>
		
		if @_elm?
			return @_elm.width();
			
			
	# -----------------------------------
	# テキストの高さ
	# -----------------------------------
	textHeight: =>
		
		if @_elm?
			return @_elm.height();
		
	
	# -----------------------------------
	# マスク設定
	# -----------------------------------
	mask: =>
		
		if @_elm?
			@_elm.css("overflow", "hidden");
				
	
	# -----------------------------------
	# マスク解除
	# -----------------------------------
	delMask: =>
		
		if @_elm?
			@_elm.css("overflow", "visible");	
			
			
	# -----------------------------------
	# 背景色
	# -----------------------------------
	bgColor: (color) =>
		
		if @_elm?
			@_elm.css("backgroundColor", color);
			
			
	# -----------------------------------
	# 画像を追加
	# @カスタムimageオブジェクト
	# -----------------------------------
	setImg: (image) =>
		
		if @_elm?
			
			if @imgElm()? && @imgElm().length > 0
				@imgElm().remove();
			
			@_image = image;
			@_elm.append("<img src='" + @_image.src + "' width='" + @_image.width + "' height='" + @_image.height + "' alt='" + @_image.alt + "'>");
			$("#" + @_id + " img").css({
				position:"absolute",
				top:0,
				left:0
			});
			
			# サイズを画像サイズに
			@size(@_image.width, @_image.height);
			
	
	# -----------------------------------
	# 画像要素
	# -----------------------------------
	imgElm: =>
		
		return $("#" + @_id + " img");
	
			
	# -----------------------------------
	# 背景に画像を設定
	# @カスタムimageオブジェクト
	# -----------------------------------
	setBg: (image) =>
		
		if @_image? then return;
		
		if @_elm?
			@_image = image;
			@_elm.css({
				backgroundImage:"url('" + @_image.src + "')"
			});
			
			# サイズを画像サイズに
			@size(@_image.width, @_image.height);
			
	
	# -----------------------------------
	# 要素の初期化
	# -----------------------------------
	setupElm: =>
		
		@_elm = $("#" + @_id);
	
	
	# -----------------------------------
	# ID名取得
	# -----------------------------------
	id: =>
		
		return @_id;
		
	
	# -----------------------------------
	# 表示要素取得
	# -----------------------------------
	elm: =>
		
		return @_elm;
		
		
	# -----------------------------------
	# 幅設定 
	# 引数なしの場合値を取得
	# -----------------------------------
	width: (val) =>
		
		if !val?
			return @_size.width;
			
		@_size.width = val;
		@_elm.css("width", @_size.width);
		
		
	# -----------------------------------
	# 高さ設定 
	# 引数なしの場合値を取得
	# -----------------------------------
	height: (val) =>
		
		if !val?
			return @_size.height;
			
		@_size.height = val;
		@_elm.css("height", @_size.height);
		
		
	# -----------------------------------
	# 右端の座標
	# -----------------------------------
	right: =>
		
		return @_position.x + @_size.width;
		
		
	# -----------------------------------
	# 下端の座標
	# -----------------------------------
	bottom: =>
		
		return @_position.y + @_size.height;
		
		
	# -----------------------------------
	# サイズ設定 
	# -----------------------------------
	size: (w, h) =>
		
		@_size.width = w;
		@_size.height = h;
		@_elm.css({
			width:@_size.width,
			height:@_size.height
		});
		
		
	
	
	# -----------------------------------
	# X位置変更 
	# 引数なしの場合値を取得
	# -----------------------------------
	x: (val) =>
		
		if !val?
			return @_position.x;
			
		if @_elm?
			@_elm.css("left", val);
			@_position.x = val;
	
	
	# -----------------------------------
	# Y位置変更
	# 引数なしの場合値を取得
	# -----------------------------------
	y: (val) =>
		
		if !val?
			return @_position.y;
		
		if @_elm?
			@_elm.css("top", val);
			@_position.y = val;


	# -----------------------------------
	# XY位置変更
	# -----------------------------------
	xy: (val1, val2) =>
		
		if @_elm?
			@_elm.css({
				top:val2,
				left:val1
			});
			@_position.x = val1;
			@_position.y = val2;
	
	
	# -----------------------------------
	# 3D設定
	# -----------------------------------
	set3d: (orginX, orginY, orginZ) =>
	
		if @_elm?
				
			@_elm.css(
				@_u.getVendorCss(
					"transform-style",
					"preserve-3d"
				)
			);
			
			if orginX? || orginY? || orginZ?
				if !orginX? then orginX = @_size.width * 0.5;
				if !orginY? then orginY = @_size.height * 0.5;
				if !orginZ? then orginZ = 0;
				@_elm.css(
					@_u.getVendorCss(
						"transform-origin",
						orginX + "px " + orginY + "px " + orginZ + "px"
					)
				);
				
			
	# -----------------------------------
	# translate設定
	# -----------------------------------
	translate: (val1, val2, val3) =>
		
		if !val1? && !val2? && !val3? 
			
			return @_transform;
	
		else
		
			if !val2? then val2 = 0;
			if !val3? then val3 = 0;
			
			@_transform.dx = val1;
			@_transform.dy = val2;
			@_transform.dz = val3;
	
	
	# -----------------------------------
	# rotate設定
	# -----------------------------------
	rotate: (val1, val2, val3) =>
		
		if !val1? && !val2? && !val3? 
			
			return @_transform;
	
		else
		
			if !val2? then val2 = 0;
			if !val3? then val3 = 0;
			
			@_transform.rotX = val1;
			@_transform.rotY = val2;
			@_transform.rotZ = val3;
			
	
	# -----------------------------------
	# scale設定
	# -----------------------------------
	scale: (val1, val2, val3) =>
		
		if !val1? && !val2? && !val3? 
			
			return @_transform;
	
		else
		
			if !val2? then val2 = 1;
			if !val3? then val3 = 1;
			
			@_transform.scaleX = val1;
			@_transform.scaleY = val2;
			@_transform.scaleZ = val3;
				
	
	# -----------------------------------
	# TransForm設定
	# -----------------------------------
	setTransform: =>
		
		if @_elm?
				
			@_elm.css(
				@_u.getVendorCss(
					"transform",
					@_u.translate3d(@_transform.dx, @_transform.dy, @_transform.dz, @_isUse3D) + " " + @_u.rotateX(@_transform.rotX) + " " + @_u.rotateY(@_transform.rotY) + " " + @_u.rotateZ(@_transform.rotZ) + " " + @_u.scaleX(@_transform.scaleX) + " " + @_u.scaleY(@_transform.scaleY);
				)
			);
	
	
	# -----------------------------------
	# 透明度
	# -----------------------------------
	alpha: (val) =>
		
		if !val?
			return @_alpha;
		else
			if @_elm?
				@_elm.css("opacity", val);
				@_alpha = val;

	
	# -----------------------------------
	# ボタンイベントの設定
	# [0]..関数 [1]..オブジェクト
	# @f1 : ロールオーバー用
	# @f2 : ロールアウト用
	# @f3 : クリック用
	# -----------------------------------
	setBtn: (f1, f2, f3) =>
		
		if @_elm?
			if !f1[1]? then f1[1] = {};
			if !f2[1]? then f2[1] = {};
			if !f3[1]? then f3[1] = {};
			@_elm.bind("mouseover", f1[1], f1[0]).bind("mouseout", f2[1], f2[0]).bind("click", f3[1], f3[0]);
		
	
	# -----------------------------------
	# マウス位置を取得できるように設定
	# -----------------------------------
	setMousePos: (option) =>
		
		if option?
			@_mouse.x = @_mouse.oldX = option.x;
			@_mouse.y = @_mouse.oldY = option.y;
		
		if @_elm? 
			@_elm.bind("mousemove", @_eMouseMove);
		
		
	# -----------------------------------
	# イベント MouseMove
	# -----------------------------------
	_eMouseMove: (e) =>
		
			x = e.pageX;
			y = e.pageY;			
			
			@_mouse.oldX = @_mouse.x;
			@_mouse.oldY = @_mouse.y;
			@_mouse.x = x;
			@_mouse.y = y;
			
	
	# -----------------------------------
	# マウス位置
	# -----------------------------------
	mouse: (p) =>
		
		if !p? 
			return @_mouse;
		else
			@_mouse.oldX = @_mouse.x;
			@_mouse.oldY = @_mouse.y;
			@_mouse.x = p.x;
			@_mouse.y = p.y;
		
		
	# -----------------------------------
	# 遅延実行
	# -----------------------------------
	delay: (f, time, key) =>
		
		@delayClear(key);
		@_tm[key] = setTimeout(f, time);
		
	
	# -----------------------------------
	# 遅延実行 クリア
	# -----------------------------------
	delayClear: (key) =>
		
		if @_tm[key]?
			clearTimeout(@_tm[key]);
			@_tm[key] = null;	
		