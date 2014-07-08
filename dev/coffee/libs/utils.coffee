


# utils.coffee 


root = this;
if !root._LIBS?
	root._LIBS = {};


# ---------------------------------------------------
# 便利関数クラス
# ---------------------------------------------------
class root._LIBS.utils
	
	
	# -----------------------------------------------
	# コンストラクタ
	# -----------------------------------------------
	constructor: ->
	
		# private ------
		
		@_A = Math.PI / 180;
		
	
		
	# ランダムな整数を取得
	# -----------------------------------
	# @min : 最小値(int)
	# @max : 最大値(int)
	# return : minからmaxまでのランダムな整数(int)
	# -----------------------------------
	random: (min, max) ->
		
		if min < 0 then min--;
		return ~~(Math.random() * ((max + 1) - min) + min);
	
	
	
	# 1/@rangeの確率でtrueを取得
	# -----------------------------------
	# @range : 母数(int)
	# return : true or false(boolean)
	# -----------------------------------
	hit: (range) -> 
		
		return (@random(0, range-1) == 0);
	
	
	
	# 0から範囲内でランダムな整数を取得
	# -----------------------------------
	# @val : 範囲(int)
	# return : ランダムな整数(int)
	# -----------------------------------
	range: (val) ->
		
		return @random(-val, val);
	
	
	# 配列内のランダムな値をひとつ取得
	# -----------------------------------
	# @arr : 配列
	# return : 配列内の値
	# -----------------------------------
	arrRand: (arr) -> 
		
		return arr[@random(0, arr.length - 1)];
	
	
	# 値をマッピング
	# -----------------------------------
	# @num : マッピングする値(Number)
	# @resMin : 結果となる値の最小値(Number)
	# @resMax : 結果となる値の最大値(Number)
	# @baseMin : 元となる値の最小値(Number)
	# @baseMax : 元となる値の最大値(Number)
	# return : マッピングされた値(Number)
	# -----------------------------------
	map: (num, resMin, resMax, baseMin, baseMax) ->
		
		if num < baseMin then return resMin;
		if num > baseMax then return resMax;
		p = (resMax - resMin) / (baseMax - baseMin);
		return ((num - baseMin) * p) + resMin;
	
	
	
	# 角度をラジアンに変換
	# -----------------------------------
	# @degree : 角度(Number)
	# return : ラジアン(Number)
	# -----------------------------------
	radian: (degree) ->
	
		return degree * @_A;
	
	
	
	# ラジアンを角度に変換
	# -----------------------------------
	# @radian : ラジアン(Number)
	# return : 角度(Number)
	# -----------------------------------
	degree: (radian) ->
	
		return radian / @_A;
	
	
	
	# 数値に小数点第@n位までをつけた文字列を返す
	# -----------------------------------
	# @num : 値(Number)
	# @n : 小数点の位(int)
	# return : 変換された値(String)
	# -----------------------------------
	decimal: (num, n) ->
	
		num = String(num);
		pos = num.indexOf(".");
		if n == 0 then return num.split(".")[0];
		if pos == -1
			num += ".";
			i = 0;
			while i < n
				num += "0";
				i++;
			return num;
		
		num = num.substr(0, pos) + num.substr(pos, n+1);
		return num;
	
	
	
	# 値を範囲内におさめる
	# -----------------------------------
	# @num : 値(Number)
	# @min : 最小値(Number)
	# @max : 最大値(Number)
	# -----------------------------------
	floor: (num, min, max) ->
	
		return Math.min(max, Math.max(num, min));
	


	# 文字列を反転
	# -----------------------------------
	# @str : 文字列(String)
	# return : 文字列(String)
	# -----------------------------------
	strReverse: (str) ->
	
		res = "";
		len = str.length;
		
		i = 1;
		while i <= len
			res += str.substr(-i, 1);
			i++;
			
		return res;
		


	# 配列をランダムに並べ替え
	# -----------------------------------
	# @arr : 配列(Array)
	# -----------------------------------
	shuffle: (arr) ->
	
		i = arr.length;
		while --i 
			j = Math.floor(Math.random() * (i + 1));
			if i == j then continue;
			k = arr[i];
			arr[i] = arr[j];
			arr[j] = k;
			


	# nullを削除した配列を返す
	# -----------------------------------
	# @arr : 配列(Array)
	# return : null削除した配列(Array)
	# -----------------------------------
	sliceNull: (arr) ->
	
		newArr = [];
		for val,i in arr
			if val != null
				newArr.push(val);
				
		return newArr;
	


	# 配列内のパラメータを比較してソート
	# -----------------------------------
	# @arr : 配列(Array)
	# @para : パラメーター名
	# @desc : 降順かどうか(boolean) デフォルトは昇順
	# -----------------------------------
	sort: (arr, para, desc) ->
	
		if desc == undefined then desc = false;
		if desc
			arr.sort((a, b) ->
				return b[para] - a[para];
			);
		else
			arr.sort((a, b) ->
				return a[para] - b[para]
			);
		
	

	# ファイル名の末尾にユニークIDを追加
	# -----------------------------------
	# @file : ファイル名
	# return : @file + "?date=○○○○○○○○○"
	# -----------------------------------
	addUnique: (file) ->
	
		return file + "?date=" + new Date().getTime();
	


	# 色をランダムに取得
	# -----------------------------------
	# return : #000000~#FFFFFFでランダムな色
	# -----------------------------------
	getRandomColor: ->
	
		color = Math.floor(Math.random() * 0xFFFFFF).toString(16);
		count = color.length;
		while count < 6
			color = "0" + color;
			count++;
		color = "#" + color;
		return color;
	
	
	# 数値を文字列に変換
	# -----------------------------------
	numStr: (num, keta) =>
		
		str = String(num);
		
		if str.length >= keta 
			return str;
		
		len = keta - str.length;
		i = 0;
		while i < len
			str = "0" + str;
			i++;
		
		return str;
	
	
	# **jquary使用
	# 実行中のjquaryアニメーションを全て停止
	# -----------------------------------
	# @con : $(selecter)で取得した値
	# -----------------------------------
	stop: (con) ->
	
		if con.length == 0 then return;
		
		i = 0;
		len = con.queue().length;
		while i < len
			con.stop();
			i++;
		

	
	# **jquary使用
	# ボタンモード変更
	# trueならカーソルがポインターの形に
	# falseならデフォルトのカーソルに
	# -----------------------------------
	# @flg : 適用するかどうか(boolean)
	# -----------------------------------
	buttonMode: (flg) ->
		
		if flg
			$("body").css("cursor", "pointer");
		else
			$("body").css("cursor", "default");


	# クエリ抜き出し
	# -----------------------------------
	# @key : 抜き出すパラメータ名(String)
	# -----------------------------------
	getQuery: (key) -> 
	
		key = key.replace(/[€[]/,"€€€[").replace(/[€]]/,"€€€]");
		regex = new RegExp("[€€?&]"+key+"=([^&#]*)");
		qs = regex.exec(window.location.href);
		if qs == null
			return "";
		else
			return qs[1];
	
	
	
	# ハッシュ取得
	# -----------------------------------
	# return : location.hashの#を削除したやつ
	# -----------------------------------
	hash: -> 
	
		return location.hash.replace("#", "");
	


	# スマフォ判定
	# -----------------------------------
	# return : true or false(boolean)
	# -----------------------------------
	isSmt: -> 
		return (
			navigator.userAgent.indexOf('iPad') > 0 ||
			navigator.userAgent.indexOf('iPhone') > 0 ||
			navigator.userAgent.indexOf('iPod') > 0 ||
			navigator.userAgent.indexOf('Android') > 0
		);
	

	# Android判定
	# -----------------------------------
	# return : true or false(boolean)
	# -----------------------------------
	isAndroid: -> 
		
		u = navigator.userAgent;
		return (u.indexOf('iPhone') > 0 || u.indexOf('iPod') > 0 || u.indexOf('BlackBerry') > 0 || u.indexOf('Android') > 0 && u.indexOf('Mobile') > 0 || u.indexOf('Windows Phone') > 0 );
		#return navigator.userAgent.indexOf('Android') > 0;
		
		
	# iOS判定
	# -----------------------------------
	# return : true or false(boolean)
	# -----------------------------------
	isIos: -> 
	
		return (
			navigator.userAgent.indexOf('iPad') > 0 ||
			navigator.userAgent.indexOf('iPhone') > 0 ||
			navigator.userAgent.indexOf('iPod') > 0
		);
	
		
	# PS3判定
	# -----------------------------------
	# return : true or false(boolean)
	# -----------------------------------
	isPs3: ->
		
		u = navigator.userAgent;
		return u.indexOf('PLAYSTATION 3') > 0;
		
		
	# VITA判定
	# -----------------------------------
	# return : true or false(boolean)
	# -----------------------------------
	isVita: ->
		
		u = navigator.userAgent;
		return u.indexOf('PlayStation Vita') > 0;
		

	# IE8以下かどうか
	# -----------------------------------
	# return : true or false(boolean)
	# -----------------------------------
	isIe8Under: -> 

		msie = navigator.appVersion.toLowerCase();
		msie = if msie.indexOf('msie') >-1 then parseInt(msie.replace(/.*msie[ ]/,'').match(/^[0-9]+/)) else 0;

		return (msie <= 8 && msie != 0);
		
		
	# IE9以下かどうか
	# -----------------------------------
	# return : true or false(boolean)
	# -----------------------------------
	isIe9Under: -> 

		msie = navigator.appVersion.toLowerCase();
		msie = if msie.indexOf('msie') >-1 then parseInt(msie.replace(/.*msie[ ]/,'').match(/^[0-9]+/)) else 0;

		return (msie <= 9 && msie != 0);
		
		
	# IEかどうか
	# -----------------------------------
	# return : true or false(boolean)
	# -----------------------------------
	isIe: -> 
	
		ua = window.navigator.userAgent.toLowerCase();
		return (ua.indexOf('msie') != -1 || ua.indexOf('trident/7') != -1);


	# iPad判定
	# -----------------------------------
	# return : true or false(boolean)
	# -----------------------------------
	isIpad: -> 
	
		return (navigator.userAgent.indexOf('iPad') > 0);
	
	
	
	# WINかどうか
	# -----------------------------------
	# return : true or false(boolean)
	# -----------------------------------
	isWin: -> 
		
		return (navigator.platform.indexOf("Win") != -1);
		
		
		
	# googleChromeかどうか
	# -----------------------------------
	# return : true or false(boolean)
	# -----------------------------------
	isChrome: -> 
	
		return (navigator.userAgent.indexOf('Chrome') > 0);
	
	
	# FireFoxかどうか
	# -----------------------------------
	# return : true or false(boolean)
	# -----------------------------------
	isFF: -> 
	
		return (window.navigator.userAgent.toLowerCase().indexOf('firefox') != -1);


	# cookie取得
	# -----------------------------------
	# @key : パラメータ名
	# -----------------------------------
	getCookie: (key) ->

		if (document.cookie == undefined || document.cookie == null) then return null;

		arr = document.cookie.split("; ");
		for val,i in arr
			a = val.split("=");
			if a[0] == key
				return a[1];
		
		return null;
		


	# cookie設定
	# -----------------------------------
	# @key : パラメータ名
	# @val : 値
	# -----------------------------------
	setCookie: (key, val) ->

		document.cookie = key + "=" + val;
	


	# position:fixedが使用できるか
	# -----------------------------------
	# return : true or false(boolean)
	# -----------------------------------
	useFixed: ->
	
		container = document.body;
		if (document.createElement && container && container.appendChild && container.removeChild)
			el = document.createElement('div');
		
			if (!el.getBoundingClientRect) then return null;
			
			el.innerHTML = 'x';
			el.style.cssText = 'position:fixed;top:100px;';
			container.appendChild(el);
			
			originalHeight = container.style.height;
			originalScrollTop = container.scrollTop;
			
			container.style.height = '3000px';
			container.scrollTop = 500;
			
			elementTop = el.getBoundingClientRect().top;
			container.style.height = originalHeight;
			
			isSupported = (elementTop == 100);
			container.removeChild(el);
			container.scrollTop = originalScrollTop;
			
			return isSupported;
		
		return false;
	
	
	
	# HTMLタグ作成
	# -----------------------------------
	# @tag : タグ名 
	# @para[].name : 要素名(String)
	# @para[].val : 値(*)
	# @close : 閉じタグつけるかどうか(boolean)
	# return : HTMLタグ(String)
	# -----------------------------------
	tag: (tag, para, close) ->
	
		if para == undefined then para = [];
		if close == undefined then close = true;
		
		res = "<" + tag;
		for val,i in para
			res += " " + val.name + "=" + val.val; 
		res += ">";
		
		if close then res += "</" + tag + ">";
		
		return res;
	
	

	# translate()
	# -----------------------------------
	translate: (x, y) ->
	
		if x == undefined then x = 0;
		if y == undefined then y = 0;
		
		return 'translate(' + x + 'px,' + y + 'px)';
	


	# translateX()
	# -----------------------------------
	translateX: (x) ->
	
		if x == undefined then x = 0;
		return 'translateX(' + x + 'px)';
	


	# translateY()
	# -----------------------------------
	translateY: (y) ->
	
		if y == undefined then y = 0;
		return 'translateY(' + y + 'px)';
	


	# translate3d()
	# -----------------------------------
	translate3d: (x, y, z, use3d) ->
	
		if x == undefined then x = 0;
		if y == undefined then y = 0;
		if z == undefined then z = 0;
		if use3d == undefined then use3d = true;
		
		if use3d
			return 'translate3d(' + x + 'px,' + y + 'px,' + z + 'px)';
		else
			return 'translate(' + x + 'px,' + y + 'px)';
	


	# rotate()
	# -----------------------------------
	rotate: (val) ->
	
		if val == undefined then val = 0;
		return 'rotate(' + val + 'deg)';
	


	# rotateX()
	# -----------------------------------
	rotateX: (val) ->
	
		if val == undefined then val = 0;
		return 'rotateX(' + val + 'deg)';
	


	# rotateY()
	# -----------------------------------
	rotateY: (val) ->
	
		if val == undefined then val = 0;
		return 'rotateY(' + val + 'deg)';
	


	# rotateZ()
	# -----------------------------------
	rotateZ: (val) ->
		
		if val == undefined then val = 0;
		return 'rotateZ(' + val + 'deg)';
	


	# scale3d()
	# -----------------------------------
	scale3d: (x, y, z) ->
	
		if x == undefined then x = 1;
		if y == undefined then y = 1;
		if z == undefined then z = 1;
		return 'scale3d(' + x + ',' + y + ',' + z + ')';
	


	# scaleX()
	# -----------------------------------
	scaleX: (x) ->
		
		if x == undefined then x = 1;
		return 'scaleX(' + x + ')';
	


	# scaleY()
	# -----------------------------------
	scaleY: (y) ->
	
		if y == undefined then y = 1;
		return 'scaleY(' + y + ')';
		
		
	# skew
	# -----------------------------------
	skew: (val) ->
	
		if val == undefined then val = 0;
		return 'skew(' + val + 'deg)';
	


	# ベンダープレフィックス付きのCSS設定
	# -----------------------------------
	getVendorCss: (prop, val) ->
	
		res = {};
		res["-moz-" + prop]    = val;
		res["-webkit-" + prop] = val;
		res["-o-" + prop]      = val;
		res["-ms-" + prop]     = val;
		res[prop]              = val;

		return res;

	
	# div要素追加
	# -----------------------------------
	addDiv: (parent, id, x, y) ->
		
		parent.append(@tag("div", [
			{name:"id", val:id}
		]));
				
		if x != undefined && y != undefined
			return $("#" + id).css({
				position:"absolute",
				top:y,
				left:x
			});
		else
			return $("#" + id);

		
		
	# canvas要素追加
	# -----------------------------------
	addCanvas: (parent, id, width, height, x, y) ->
		
		parent.append(@tag("canvas", [
			{name:"id", val:id},
			{name:"width", val:width},
			{name:"height", val:height}
		]));
		
		if x != undefined && y != undefined
			return $("#" + id).css({
				position:"absolute",
				top:y,
				left:x
			});
		else
			return $("#" + id);
		
		
	# img要素追加
	# -----------------------------------
	addImg: (parent, id, src, width, height) ->
		
		parent.append(@tag("img", [
			{name:"id", val:id},
			{name:"src", val:src},
			{name:"width", val:width},
			{name:"height", val:height}
		]), false);
		return $("#" + id);
		
		
	# サイト全体の高さ
	# -----------------------------------
	windowHeight: =>
	
		return $(document).height();
		
		
	# スクロール量 縦
	# -----------------------------------
	scrollTop: =>
	
		return Math.max($(window).scrollTop(), $(document).scrollTop());



		
		


