


# float.coffee

root = this;
if !root._LIBS?
	root._LIBS = {};


# ---------------------------------------------------
# ふわふわさせるアニメーション
# ---------------------------------------------------
class root._LIBS.float
	
	
	# コンストラクタ
	# -----------------------------------------------
	# @target : アニメーションさせるオブジェクト
	# @para   : [].target 変化させるパラメータ名
	#         : [].range 変化の幅
	#         : [].speed 変化の速度
	#         : [].start 動きの開始値 0~1
	#         : [].delay アニメーション遅延
	# -----------------------------------------------
	constructor: (target, para) ->
	
		# ターゲット
		@_target = target;
		
		# パラメータリスト
		@_para = para;
		
		@_sinList1 = [];
		@_sinList2 = {};
		
		# 初期化
		@_init();
				
		
		
	# 初期化
	# -----------------------------------
	_init: ->
		
		len = @_para.length;
		for val,i in @_para
			
			start = if !val.start? then 0 else val.start;
			s = new root._LIBS.sin(@_target[val.target], -val.range * 0.5, val.range * 0.5, val.speed, start);
			
			val.delayCnt = 0;
			if !val.delay? then val.delay = 0;
			
			@_sinList1.push(s);
			@_sinList2[val.target] = s;
			
			
	# 更新
	# -----------------------------------
	update: =>
		
		for val,i in @_sinList1
			o = @_para[i];
			if o.delayCnt >= o.delay
				@_target[o.target] = @_sinList1[i].update();
			else
				o.delayCnt++;
		
	
	# 削除
	# -----------------------------------
	dispose: =>
		
		@_target = null;
		@_para = null;
		@_sinList1 = null;
		@_sinList2 = null;
	
	
			

# ---------------------------------------------------
# サインカーブオブジェクト
# ---------------------------------------------------
class root._LIBS.sin
	
	
	# コンストラクタ
	# -----------------------------------------------
	# @target :
	# -----------------------------------------------
	constructor: (base, min, max, speed, angle) ->

		
		@base = base;
		@min = min;
		@max = max;
		@speed = speed;
		@angle = angle
		
		@val = 0;
		
		
		
	# 更新
	# -----------------------------------
	update: ->
		
		u = root.MY.util;
		
		@angle += @speed;
		if @angle > 360 then @angle = @angle - 360;
		@val = @base + u.map(Math.sin(u.radian(@angle)), @min, @max, -1, 1);
		
		return @val;
		
		
		
		
		
		
		
		