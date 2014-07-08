


# hsvColor.coffee

root = this;
if !root._LIBS?
	root._LIBS = {};


# ---------------------------------------------------
# カラー値をHSVで管理
# ---------------------------------------------------
class root._LIBS.hsvColor
	
	
	# コンストラクタ
	# -----------------------------------------------
	# @h : 色相 角度
	# @s : 彩度 0-1
	# @v : 明度 0-1
	# @a : アルファ 0-1
	# -----------------------------------------------
	constructor: (h, s, v, a) ->
	
		h = if !h? then 0 else h;
		s = if !s? then 1 else s;
		v = if !v? then 1 else v;
		
		@h = h;
		@s = Math.min(1, Math.max(s, 0));
		@v = Math.min(1, Math.max(v, 0));
		@a = if !a? then 1 else a;
		
	
	# -----------------------------------
	# 0xRRGGBB形式で返す
	# -----------------------------------
	getColor: =>
		
		if @s > 0 
		
			h2 = if @h < 0 then (@h % 360 + 360) else (@h % 360);
			h2 = h2 / 60;
			if h2 < 1 
				r = Math.round(255 * @v);
				g = Math.round(255 * @v * (1 - @s * (1 - h2)));
				b = Math.round(255 * @v * (1 - @s));
			else if h2 < 2 
				r = Math.round(255 * @v * (1 - @s * (h2 - 1)));
				g = Math.round(255 * @v);
				b = Math.round(255 * @v * (1 - @s));
			else if h2 < 3 
				r = Math.round(255 * @v * (1 - @s));
				g = Math.round(255 * @v);
				b = Math.round(255 * @v * (1 - @s * (3 - h2)));
			else if h2 < 4 
				r = Math.round(255 * @v * (1 - @s));
				g = Math.round(255 * @v * (1 - @s * (h2 - 3)));
				b = Math.round(255 * @v);
			else if h2 < 5 
				r = Math.round(255 * @v * (1 - @s * (5 - h2)));
				g = Math.round(255 * @v * (1 - @s));
				b = Math.round(255 * @v);
			else
				r = Math.round(255 * @v );
				g = Math.round(255 * @v * (1 - @s));
				b = Math.round(255 * @v * (1 - @s * (h2 - 5)));
		
		else
		
			r = g = b = Math.round(255 * @v);
		
		return r << 16 | g << 8 | b;
		
		
		
	# -----------------------------------
	# "#RRGGBB"形式で返す
	# -----------------------------------
	getHexColor: =>
			
			return "#" + @getColor().toString(16);
			
	
	# -----------------------------------
	# カラー値セット
	# @color : カラー (0xRRGGBB)
	# -----------------------------------
	setColor: (color) =>
	
		r = color >> 16 & 0xff;
		g = color >> 8 & 0xff;
		b = color & 0xff;
		
		if (r!=g || r!=b)
			if g > b
				if r > g
					@v = r/255;  
					@s = (r - b) / r;
					@h = 60 * (g - b) / (r - b);
				else if r < b
					@v = g / 255;
					@s = (g - r) / g;
					@h = 60 * (b - r) / (g - r) + 120;
				else
					@v = g/255;
					@s = (g - b)/g;
					@h = 60 * (b - r) / (g - b) + 120;
			else
				if r > b
					@v = r/255;
					@s = (r - g) / r;
					@h = 60 * (g - b) / (r - g);
					if @h < 0
						@h += 360;
				else if r < g
					@v = b/255;
					@s = (b - r) / b;
					@h = 60 * (r - g)/(b - r) + 240;
				else
					@v = b/255;
					@s = (b - g) / b;
					@h = 60 * (r - g)/(b - g) + 240;
		else
			@h = @s = 0;
			@v = r / 255;
		

		
		
		
		
		