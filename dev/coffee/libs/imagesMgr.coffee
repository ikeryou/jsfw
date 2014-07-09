# ---------------------------------------------------
# imagesMgr.coffee
# ---------------------------------------------------

root = this;
if !root._LIBS?
	root._LIBS = {};
	
# ---------------------------------------------------
# 画像管理クラス
# ---------------------------------------------------
class root._LIBS.imagesMgr
	
	
	# -----------------------------------------------
	# コンストラクタ
	# @imgList : 画像ファイルリスト [] 順番がそのままIDになる
	# @path    : 共通画像パス def..""
	# @cache   : キャッシュ対策を行うかどうか def..false
	# -----------------------------------------------
	constructor: (imgList, path, cache) ->
		
		if !path? then path = "";
		if !cache? then cache = false;
		
		# 画像ファイルリスト
		@_imgList = [];			
		for val,i in imgList
			@_imgList.push(path + val);
		
		# フラグ キャッシュ対策を行うかどうか
		@_isCache = cache;
		
		# ローダー
		@_loaderForPreImg;
		
		
		# コールバック 読み込み中 0~100の値を返す
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
	# 画像読み込み
	# -----------------------------------------------
	load: =>
		
		u = root.MY.util;
		imgList = [];
		len = @_imgList.length;
		i = 0;
		while i < len
			
			url = @_imgList[i];
			if @_isCache
				url = u.addUnique(url);
			
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
		
	
	# -----------------------------------------------
	# imageオブジェクト取得(root._LIBS.image)
	# @id : @_imgListで渡した際のID
	# -----------------------------------------------
	get: (id) =>
		
		data = @_loaderForImg.getImg(id);
		return new root._LIBS.image(data.src, data.width, data.height);
	
	
	
	
	
	
	
	
	
	
	
	
	