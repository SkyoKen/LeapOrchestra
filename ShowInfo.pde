class ShowInfo {
  String version;
  String webAddress;
  PImage logo;  //logo
  PFont font;
  float alpha = 255;
  ShowInfo(String version,String webAddress,int size) {
    this.version=version;
    this.webAddress=webAddress;
    this.logo=loadImage("icon.png");
    this.font=createFont("consolas", size);
  }
  void update() {
    pushMatrix();
    translate(this.logo.width*1.5, height-36);
    scale(0.4);
    image(this.logo,this.logo.width ,0);
    popMatrix();
    
    this.alpha+=random(0.02, 0.09);
    fill(255, 255, 255, map(sin(this.alpha), -1, 1, 40, 255));
    textFont(this.font);
    textAlign(CENTER, CENTER);
    text(this.version+"   "+this.webAddress, width/2, height-24);
  }
}
