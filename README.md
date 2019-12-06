# LeapOrchestra
Leap Motionを用いたジェスチャ操作による、再生や停止などの命令をraspberry piに送る
## 目次
1. [環境構築](#環境構築)  
    1. [Leap Motion](#leapmotion)
    2. [Processing](#processing)
2. [指揮ジェスチャーの設計](#ジェスチャーの設計)
    
## 環境構築
### LeapMotion
* [Leap_Motion_Developer_Kitのダウンロード（Leap_Motion_Setup.exe）](https://developer.leapmotion.com/get-started)
* [Leap Motion SDKのダウンロード（Leap_Motion_Developer_Kit.zip）](https://developer.leapmotion.com/get-started)

### Processing
* [Processingのダウンロード](https://processing.org/download/)
* [LeapJavaライブラリのインポート(com.leapmotion.leap)](https://developer-archive.leapmotion.com/documentation/java/devguide/Leap_Processing.html)
* Leap Motion for processingライブラリのインポート
* ControlP5ライブラリのインポート

## ジェスチャーの設計
|  1 | 1  | 1 |
|  ----  | ----   | ----  | 
| 2 |   ![Tempo2](https://github.com/SkyoKen/LeapOrchestra/blob/master/image/Tempo2.png)  | ![Tempo2](https://github.com/SkyoKen/LeapOrchestra/blob/master/image/Tempo2_.png)| 
| 3 |   ![Tempo3](https://github.com/SkyoKen/LeapOrchestra/blob/master/image/Tempo3.png)  | ![Tempo2](https://github.com/SkyoKen/LeapOrchestra/blob/master/image/Tempo3_.png)| 
| 4 |   ![Tempo4](https://github.com/SkyoKen/LeapOrchestra/blob/master/image/Tempo4.png)  | ![Tempo2](https://github.com/SkyoKen/LeapOrchestra/blob/master/image/Tempo4_.png)| 


|0|1|2|3|4|
|  ----  | ----   | ----  |  ----  | ----  | 
|2|1|2|3|4|
|3|1|2|3|4|
|4|1|2|3|4|
