

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
	# @id : ID名
	# @sliderPara : 
	# 	sliderPara.list : 各スライダーの設定値       
	#                     [].min..最小値
	#                     [].max..最大値
	#                     [].def..デフォルト値
	#                     [].name..パラメータ名
	# 	sliderPara.width    : スライダーの幅 def..200
	# 	sliderPara.height   : スライダーの高さ def..20
	# 	sliderPara.bgColor  : スライダー背景色 def.."#FFFFFF"
	# 	sliderPara.btnColor : スライダーボタン色 def.."#888888"
	# -----------------------------------------------
	constructor: (id, sliderPara) ->
		
		@_sliderPara = sliderPara;
		if !@_sliderPara.width? then @_sliderPara.width = 200;
		if !@_sliderPara.height? then @_sliderPara.height = 20;
		if !@_sliderPara.bgColor? then @_sliderPara.bgColor = "#FFFFFF";
		if !@_sliderPara.btnColor? then @_sliderPara.btnColor = "#888888";
		
		@_slider = [];
		
		# 表示切り替えボタン
		@_toggle;
		
		# コールバック スライダ−の値が変更された
		@onChangeSlider;
		
		super(id, {resize:false, update:false});
		
		
		
	# -----------------------------------------------
	# イベント 要素作成
	# -----------------------------------------------
	addStage: ->	
		
		@elm().css({
			position:"fixed",
			zIndex:9999
		});
		
		# スライダー作成
		for val,i in @_sliderPara.list
			
			slider = new root._LIBS.slider(@id() + "_slider_" + i, val.min, val.max, val.def, val.name);
			@addChild(slider);
			slider.setSlider(@_sliderPara.width, @_sliderPara.height, @_sliderPara.bgColor, @_sliderPara.btnColor);
			slider.y((i + 1) * (@_sliderPara.height + 25));
			slider.onChange = @_eChangeSlider;
			@_slider.push(slider);
		
		# 表示切り替えボタン
		@_toggle = new root._LIBS.btnAreaView(@id() + "_toggle", @_sliderPara.height, @_sliderPara.height);
		@addChild(@_toggle);
		@_toggle.elm().css({
			backgroundColor:@_sliderPara.bgColor,
			opacity:1
		});
		@_toggle.onClick = @_eClickToggle;
		@_toggle.elm().bind("touchstart", @_eClickToggle);
	
	
	# -----------------------------------------------
	# イベント 表示切り替えボタンクリック
	# -----------------------------------------------
	_eClickToggle: =>
		
		for val,i in @_slider
			val.alpha(if val.alpha() == 1 then 0 else 1);
	
		
	# -----------------------------------------------
	# イベント スライダーの値が変更された
	# -----------------------------------------------
	_eChangeSlider: (id) =>
		
		if @onChangeSlider?
			@onChangeSlider(id.split("_")[2]);
	
	
	# -----------------------------------------------
	# パラメータ取得
	# -----------------------------------------------
	sliderVal: (key) =>
		
		return @_slider[key].sliderVal();
		
		
	# -----------------------------------------------
	# 削除
	# -----------------------------------------------
	dispose2: =>
		
		
	
	
		
		
	