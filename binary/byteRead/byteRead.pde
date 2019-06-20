//binaryデータの読み込み

byte b[] = loadBytes("byte.dat");

int line = 1;

//出力　binaryデータからintデータへの変換
for (int i = 0; i < b.length; i++) { 
  //8個データずつ
  if ((i % 8) == 0) { 
    println(); 
    print(line + ": ");
    line++;
  } 
  //bytes->int
  print((b[i] & 0xff) + " ");
} 
println(); 

//出力　binaryデータから文字列への変換
//println(new String(b));
