# NME-SHOOT  
  
##**Hexe**と**NME**をもちいた、縦スクロールシューティングゲーム  
  
###必要なもの
Haxe [>= 2.10]  
NME  [>= 3.4.0]  

###ビルド & 実行
-Mac OS X の場合  

    nme setup mac  
    nme test Shoot.nmml mac  
  
-iOS の場合  

    nme setup ios
    nme test Shoot.nmml ios -simulator  
  
-Windows の場合  

    nme setup windows  
    nme test Shoot.nmml windows  
  
-HTML5 の場合  

    nme setup html5  
    nme test Shoot.nmml html5  
  
-Flash の場合  

    nme build Shoot.nmml flash

Export/flash/bin以下のShoot.swfファイルを実行

###サンプル  
次のページにflashバージョンがあります。  
  
http://naokirin.github.com/nme-shoot/

十字キー : 移動  
zキー    : 弾の発射  
xキー    : コンティニュー

###License
Copyright 2012- naokirin  

Licensed under the MIT License  
http://www.opensource.org/licenses/mit-license.php
