


# point3d.coffee

root = this;
if !root._LIBS?
	root._LIBS = {};


# ---------------------------------------------------
# 三角形管理クラス
# ---------------------------------------------------
class root._LIBS.triangle
	
	
	# コンストラクタ
	# -----------------------------------------------
	constructor: (a, b, c, color, light) ->
	
		@pointA = a;
		@pointB = b;
		@pointC = c;
		
		@depth = 0;
		
		@color = color;
		@light = light;
		
		@_isFill = true;
		@_isLine = false;
		@_isDraw = true;
	
	
	# -----------------------------------
	# 削除
	# -----------------------------------
	dispose: =>
		
		@pointA = null;
		@pointB = null;
		@pointC = null;
		@light = null;
		
	
	# -----------------------------------
	# 色の設定 16進数で
	# -----------------------------------
	setColor: (color) =>
		
		@color = color;
	
	
	# -----------------------------------
	# 描画設定
	# -----------------------------------
	setDrawInfo: (isFill, isLine, isDraw) =>
		
		@_isFill = isFill;
		@_isLine = isLine;
		@_isDraw = isDraw;
		
	
	# -----------------------------------
	# canvasコンテキストに描画
	# -----------------------------------
	draw: (ctx) =>
		
		@_depth();
		if !@_isDraw || @_isBackFace() then return;
		
# 		color = "#" + @_adjustedColor().toString(16);
		color = "#" + @_initColor(@_adjustedColor());
		ctx.beginPath();
		if @_isFill then ctx.fillStyle = color;
		if @_isLine then ctx.strokeStyle = color;
		ctx.moveTo(@pointA.screenX(), @pointA.screenY());
		ctx.lineTo(@pointB.screenX(), @pointB.screenY());
		ctx.lineTo(@pointC.screenX(), @pointC.screenY());
		ctx.lineTo(@pointA.screenX(), @pointA.screenY());
		ctx.closePath();
		if @_isLine then ctx.stroke();
		if @_isFill then ctx.fill();
		
	
	# -----------------------------------
	# 16進数カラーを整える
	# @color : 16進数カラー
	# -----------------------------------
	_initColor: (color) =>
		
		colorStr = color.toString(16);
		i = colorStr.length;
		while i < 6
			colorStr = "0" + colorStr;
			i++;
		
		return colorStr;
		
	
	# -----------------------------------
	# 時計回りかどうか
	# -----------------------------------
	_isBackFace: =>
		
		#return false;
		
		cax = @pointC.screenX() - @pointA.screenX();
		cay = @pointC.screenY() - @pointA.screenY();
		
		bcx = @pointB.screenX() - @pointC.screenX();
		bcy = @pointB.screenY() - @pointC.screenY();
		
		return cax * bcy > cay * bcx;
		
		
	# -----------------------------------
	# 深度
	# -----------------------------------
	_depth: =>
		
		zpos = Math.min( @pointA.z,  @pointB.z);
		zpos = Math.min(zpos, @pointC.z);
		@depth = zpos;
		
	
	# -----------------------------------
	# 
	# -----------------------------------
	_adjustedColor: =>
		
		lightFactor = @_getLightFactor();
		
		r = @color >> 16;
		g = @color >> 8 & 0xff;
		b = @color & 0xff;
		
		r *= lightFactor;	
		g *= lightFactor;	
		b *= lightFactor;	
		
		return r << 16 | g << 8 | b;
		
		
	# -----------------------------------
	# 
	# -----------------------------------
	_getLightFactor: =>
		
		if !@light? then return 1;
		
		ab = {};
		ab.x = @pointA.x - @pointB.x;
		ab.y = @pointA.y - @pointB.y;
		ab.z = @pointA.z - @pointB.z;
		
		bc = {};
		bc.x = @pointB.x - @pointC.x;
		bc.y = @pointB.y - @pointC.y;
		bc.z = @pointB.z - @pointC.z;
		
		norm = {};
		norm.x = (ab.y * bc.z) - (ab.z * bc.y);
		norm.y = -((ab.x * bc.z) - (ab.z * bc.x));
		norm.z = (ab.x * bc.y) - (ab.y * bc.x);
		
		dotProd = norm.x * @light.x + norm.y * @light.y + norm.z * @light.z;
		
		normMag = Math.sqrt(norm.x * norm.x + norm.y * norm.y + norm.z * norm.z);
		
		lightMag = Math.sqrt(@light.x * @light.x + @light.y * @light.y + @light.z * @light.z);
		
		return (Math.acos(dotProd / (normMag * lightMag)) / Math.PI) * @light.brightness();
		
		
	# -----------------------------------
	# 
	# -----------------------------------
	_toRgb: (color) =>
		
		r = color >> 16;
		g = color >> 8 & 0xff;
		b = color & 0xff;

		return "rgb(" + r + ", " + g + ", " + b + ")";
		
		
		
		
		
		