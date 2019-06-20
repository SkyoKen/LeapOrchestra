//binaryデータの書き込み

String s="test";
byte[] b=s.getBytes();

//出力　binaryデータ
//println(b);

//出力　binaryデータから文字列への変換
//println(new String(b));

//binaryデータの保存
saveBytes("write.dat", b);
