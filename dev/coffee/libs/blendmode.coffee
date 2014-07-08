


# blendmode.coffee

root = this;
if !root._LIBS?
	root._LIBS = {};


# ---------------------------------------------------
# ブレンドモード適応クラス
# ---------------------------------------------------
class root._LIBS.blendmode
	
	
	# -----------------------------------------------
	# コンストラクタ
	# -----------------------------------------------
	constructor: ->
		
		
		# プロパティ
		 
		# ブレンドモードの種類
		@DIFFERENCE = 0; # 差の絶対値
		@LINEARDODGE = 1; # 覆い焼き（リニア）- 加算
		@MULTIPLY = 2; # 乗算
		@SCREEN = 3; # スクリーン
		
		
		
		
	
	
	
	
	# -----------------------------------------------
	# ブレンドモード適応
	# @canvasA : 適応するcanvasID
	# @canvasB : 適応させるcanvasID
	# @type    : ブレンドモードの種類 プロパティ参照
	# -----------------------------------------------
	apply: (canvasAID, canvasBID, type) ->
		
		canvasA = document.getElementById(canvasAID);
		canvasB = document.getElementById(canvasBID);
		
		contextA = canvasA.getContext("2d");
		contextB = canvasB.getContext("2d");
		
		imageDataA = contextA.getImageData(0, 0, canvasA.width, canvasA.height);
		imageDataB = contextB.getImageData(0, 0, canvasA.width, canvasA.height);
		
		outputImageData;
		
		switch type
			
			when @DIFFERENCE
				outputImageData = @_difference(imageDataA, imageDataB);
		
			when @LINEARDODGE
				outputImageData = @_lineardodge(imageDataA, imageDataB);
				
			when @MULTIPLY
				outputImageData = @_multiply(imageDataA, imageDataB);
			
			when @SCREEN
				outputImageData = @_screen(imageDataA, imageDataB);
		
		
		contextA.putImageData(outputImageData, 0, 0);
	
	
	# -----------------------------------------------
	# 焼き込み (リニア)
	# -----------------------------------------------
	_linearburn: (imageDataA, imageDataB) ->
		
		dataA = imageDataA.data;
		dataB = imageDataB.data;
		
		i = 0;
		while i < dataA.length
		
			rA = dataA[i];
			gA = dataA[i + 1];
			bA = dataA[i + 2];
			
			rB = dataB[i];
			gB = dataB[i + 1];
			bB = dataB[i + 2];
			
			
			
			#channelBlend('(v = #a + #b) < 255 ? 0 : v - 255;'),
			
			dataA[i] = rC;
			dataA[i + 1] = gC;
			dataA[i + 2] = bC;
		
			i += 4;
		
		return imageDataA;
		
	
	# -----------------------------------------------
	# 焼き込みカラー
	# -----------------------------------------------
	_colorburn: (imageDataA, imageDataB) ->
		
		dataA = imageDataA.data;
		dataB = imageDataB.data;
		
		i = 0;
		while i < dataA.length
		
			rA = dataA[i];
			gA = dataA[i + 1];
			bA = dataA[i + 2];
			
			rB = dataB[i];
			gB = dataB[i + 1];
			bB = dataB[i + 2];
			
			rC = if rB == 0 then 0 else if (rC = 255 - ((255 - rA) * 255) / rB) > 0 then rC else 0;
			gC = if gB == 0 then 0 else if (gC = 255 - ((255 - gA) * 255) / gB) > 0 then gC else 0;
			bC = if bB == 0 then 0 else if (bC = 255 - ((255 - bA) * 255) / bB) > 0 then bC else 0;
			
			dataA[i] = rC;
			dataA[i + 1] = gC;
			dataA[i + 2] = bC;
		
			i += 4;
		
		return imageDataA;
	
	
	# -----------------------------------------------
	# 比較 (暗)
	# -----------------------------------------------
	_darken: (imageDataA, imageDataB) ->
		
		dataA = imageDataA.data;
		dataB = imageDataB.data;
		
		i = 0;
		while i < dataA.length
		
			rA = dataA[i];
			gA = dataA[i + 1];
			bA = dataA[i + 2];
			
			rB = dataB[i];
			gB = dataB[i + 1];
			bB = dataB[i + 2];
			
			rC = if rA < rB then rA else rB;
			gC = if gA < gB then gA else gB;
			bC = if bA < bB then bA else bB;
			
			dataA[i] = rC;
			dataA[i + 1] = gC;
			dataA[i + 2] = bC;
		
			i += 4;
		
		return imageDataA;
	
	
	# -----------------------------------------------
	# スクリーン
	# -----------------------------------------------
	_screen: (imageDataA, imageDataB) ->
		
		dataA = imageDataA.data;
		dataB = imageDataB.data;
		
		i = 0;
		while i < dataA.length
		
			rA = dataA[i];
			gA = dataA[i + 1];
			bA = dataA[i + 2];
			
			rB = dataB[i];
			gB = dataB[i + 1];
			bB = dataB[i + 2];
			
			rC = rB + rA - (rB * rA) / 255;
			gC = gB + gA - (gB * gA) / 255;
			bC = bB + bA - (bB * bA) / 255;

			dataA[i] = rC;
			dataA[i + 1] = gC;
			dataA[i + 2] = bC;
		
			i += 4;
		
		return imageDataA;
	
	
	# -----------------------------------------------
	# 覆い焼き（リニア）- 加算
	# 基本色+合成色 0以上255以下
	# -----------------------------------------------
	_lineardodge: (imageDataA, imageDataB) ->
		
		dataA = imageDataA.data;
		dataB = imageDataB.data;
		
		i = 0;
		while i < dataA.length
		
			rA = dataA[i];
			gA = dataA[i + 1];
			bA = dataA[i + 2];
			
			rB = dataB[i];
			gB = dataB[i + 1];
			bB = dataB[i + 2];
			
			rC = if (rC = rA + rB) > 255 then 255 else rC;
			gC = if (gC = gA + gB) > 255 then 255 else gC;
			bC = if (bC = bA + bB) > 255 then 255 else bC;
						
			dataA[i] = rC;
			dataA[i + 1] = gC;
			dataA[i + 2] = bC;
		
			i += 4;
		
		return imageDataA;
	
	
	# -----------------------------------------------
	# 乗算
	# 基本色×合成色=結果
	# -----------------------------------------------
	_multiply: (imageDataA, imageDataB) ->
		
		dataA = imageDataA.data;
		dataB = imageDataB.data;
		
		i = 0;
		while i < dataA.length
		
			rA = dataA[i];
			gA = dataA[i + 1];
			bA = dataA[i + 2];
			
			rB = dataB[i];
			gB = dataB[i + 1];
			bB = dataB[i + 2];
			
			rC = rA * (rB / 255);
			gC = gA * (gB / 255);
			bC = bA * (bB / 255);
						
			dataA[i] = rC;
			dataA[i + 1] = gC;
			dataA[i + 2] = bC;
		
			i += 4;
		
		return imageDataA;
	

	# -----------------------------------------------
	# 差の絶対値
	# -----------------------------------------------
	_difference: (imageDataA, imageDataB) ->
		
		dataA = imageDataA.data;
		dataB = imageDataB.data;
		
		i = 0;
		while i < dataA.length
			
			rA = dataA[i];
			gA = dataA[i + 1];
			bA = dataA[i + 2];
			
			rB = dataB[i];
			gB = dataB[i + 1];
			bB = dataB[i + 2];
			
			rC = if (rC = rA - rB) < 0 then -rC else rC;
			gC = if (gC = gA - gB) < 0 then -gC else gC;
			bC = if (bC = bA - bB) < 0 then -bC else bC;
			
			dataA[i] = rC;
			dataA[i + 1] = gC;
			dataA[i + 2] = bC;
					
			i += 4;
		
		return imageDataA;
		
		
		
		
	