# ---------------------------------------------------
# imagesMgr.coffee
# ---------------------------------------------------

# ---------------------------------------------------
# 画像管理クラス
# ---------------------------------------------------
class root.MY_CLASS.imagesMgr
	
	
	# -----------------------------------------------
	# コンストラクタ
	# @imgList : 扱う画像ファイルリスト
	# -----------------------------------------------
	constructor: (imgList, path) ->
		
		
		# プリロード用画像リスト
		@_preImgList = [
			"miku0.png",
			"miku0_l.png",
			"pkg.png"
		];			
		
		# ローダー プリロード用
		@_loaderForPreImg;
		
		# コールバック 読み込み中 0~100
		@onProgress;
		
		# コールバック 写真情報読み込み完了
		@onComplete;
		
				
		# 初期化
		@_init();
		
		
	# -----------------------------------------------
	# init
	# -----------------------------------------------
	_init: ->
		
		
	
	# -----------------------------------------------
	# データ読み込み
	# -----------------------------------------------
	load: =>
		
		# プリロード
		@_preloadImg();
		

	# -----------------------------------------------
	# プリロード用の画像の読み込み
	# -----------------------------------------------
	_preloadImg: =>
		
		imgList = [];
		len = @_preImgList.length;
		i = 0;
		while i < len
			
			url = root.MY.conf.PATH_IMG + @_preImgList[i];
			
			# IE8はキャッシュ対策のためユニークIDをつける
			if root.MY.conf.IS_IE8
				url = root.MY.util.addUnique(url);
			
			imgList.push({url:url, id:i});
			i++;
		
		@_loaderForImg = new root._LIBS.imagesLoader(imgList, 5);
		@_loaderForImg.onComplete = @_eCompletePreloadImg;
		@_loaderForImg.onProgress = @_eProgressPreloadImg;
		@_loaderForImg.start();
		
	
	# -----------------------------------------------
	# プリロード用の画像 読み込み中
	# @val : 0~100
	# -----------------------------------------------
	_eProgressPreloadImg: (val) =>
		
		if @onProgress?
			pct = val / 100;
			@onProgress(100 * pct);
			
			
	# -----------------------------------------------
	# プリロード用の画像 読み込み完了
	# -----------------------------------------------
	_eCompletePreloadImg: =>
		
		if @onProgress? then @onProgress(100);
		if @onComplete? then @onComplete();
		
		
	