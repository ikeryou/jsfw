


# point3d.coffee

root = this;
if !root._LIBS?
	root._LIBS = {};


# ---------------------------------------------------
# x,y,zの管理クラス
# ---------------------------------------------------
class root._LIBS.point3d
	
	
	# コンストラクタ
	# -----------------------------------------------
	constructor: (x, y, z, option) ->
	
		@fl = if option? && option.fl? then option.fl else 800;
		
		@vpX = 0;
		@vpY = 0;
		
		@cX = 0;
		@cY = 0;
		@cZ = 0;
		
		@x = x;
		@y = y;
		@z = z;
		
	
	# -----------------------------------
	# 削除
	# -----------------------------------
	dispose: =>
		
	
	
	# -----------------------------------
	# 消失点の設定
	# -----------------------------------
	setVanishingPoint: (vpX, vpY) =>
		
		@vpX = vpX;
		@vpY = vpY;
		
	
	# -----------------------------------
	# 中心点の設定
	# -----------------------------------
	setCenter: (cX, cY, cZ) =>
		
		@cX = cX;
		@cY = cY;
		@cZ = cZ;
		
	
	# -----------------------------------
	# 画面上のXを取得
	# -----------------------------------
	screenX: =>
		
		scale = @fl / (@fl + @z + @cZ);
		return @vpX + @cX + @x * scale;
		
	
	# -----------------------------------
	# 画面上のYを取得
	# -----------------------------------
	screenY: =>
		
		scale = @fl / (@fl + @z + @cZ);
		return @vpY + @cY + @y * scale;
	
	
	# -----------------------------------
	# X軸回転
	# -----------------------------------
	rotateX: (angleX) =>
		
		cosX = Math.cos(angleX);
		sinX = Math.sin(angleX);
		
		y1 = @y * cosX - @z * sinX;
		z1 = @z * cosX + @y * sinX;
		
		@y = y1;
		@z = z1;
		
	
	# -----------------------------------
	# Y軸回転
	# -----------------------------------
	rotateY: (angleY) =>
		
		cosY = Math.cos(angleY);
		sinY = Math.sin(angleY);
		
		x1 = @x * cosY - @z * sinY;
		z1 = @z * cosY + @x * sinY;
		
		@x = x1;
		@z = z1;
	
	
	# -----------------------------------
	# Z軸回転
	# -----------------------------------
	rotateZ: (angleZ) =>
		
		cosZ = Math.cos(angleZ);
		sinZ = Math.sin(angleZ);
		
		x1 = @x * cosZ - @y * sinZ;
		y1 = @y * cosZ + @x * sinZ;
		
		@x = x1;
		@y = y1;
	

		
		
		
		
		
		
		