# ---------------------------------------------------
# conf.coffee
# ---------------------------------------------------

# ---------------------------------------------------
# FrameWork定数クラス
# ---------------------------------------------------
class root.MY_CLASS.conf

	# コンストラクタ
	constructor: ->
		
		# ----------------------
		# プロジェクトID 
		# コンテンツはこのIDの要素で包括されてる
		@ID = "sample"
		# ----------------------
		
		
		# Stats表示
		@STATS = true;
		
		# FPS
		@FPS = 40;
		
		# iOS
		@IS_IOS = root.MY.util.isIos();
		
		# Android
		@IS_ADR = root.MY.util.isAndroid();

		# iOS or Android端末
		@IS_SMT = (@IS_IOS || @IS_ADR);
		
		# PS3,VITA
		@IS_PS = (root.MY.util.isPs3() || root.MY.util.isVita());

		# windows
		@IS_WIN = root.MY.util.isWin();

		# iPad
		@IS_IPAD = root.MY.util.isIpad();

		# IE8以下
		@IS_IE8 = root.MY.util.isIe8Under();
		
		# IE9以下
		@IS_IE9 = root.MY.util.isIe9Under();
		
		# IE
		@IS_IE = root.MY.util.isIe();
		
		# FireFox
		@IS_FF = root.MY.util.isFF();

		# Retinaディスプレイ
		@IS_RATINA = (window.devicePixelRatio? && window.devicePixelRatio > 1);
		
		


