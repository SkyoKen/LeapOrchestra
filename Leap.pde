
public class LEAP {
  private LeapMotion leap;
  String msg="";                                    //送信メッセージ
  private boolean start=false;
  PVector old_position=new PVector(0, 0);
  private boolean change=false;
  private boolean gesture=false;
  private boolean test=false;

  private int t=0;
  public LEAP(LeapMotion leap) {
    this.leap=leap;
  }

  //処理
  public void update() {
    HandDraw();
    if (this.gesture) {
      this.t++;
      check();
    }
    if (gui.getFlag()&&CheckStop()) {
      gui.getController("PLAY").setValue(0);
    } else if (!gui.getFlag()&&CheckStart()) {
      gui.getController("PLAY").setValue(1);
    }

    PVector hand_position=new PVector(0, 0);
    boolean abc=false;
    for (Hand hand : this.leap.getHands ()) {

      //手の座標を取る
      //* 
      hand_position   = hand.getPosition();

      //  println("right", hand_position.x - old_position.x);


      //*
      if (!test) { 
        //abc=true;
        test=true;
        if (hand_position.y - old_position.y>20) {
          //println("down", (hand_position.y - old_position.y));
        } else if (hand_position.y - old_position.y<-20) {
          // println("up", (hand_position.y - old_position.y));
        } else if (hand_position.x - old_position.x>20) {
          println("right", hand_position.x - old_position.x);
          //int cnt=0;
          //for(;;){
          //cnt++;
          //if(cnt/60==1)break;
        } /*else if (hand_position.x - old_position.x<-20) {
        //println("left", hand_position.x - old_position.x);
        test=false;
      }*/
        //abc=false;
        // abc=true;
         
      }
    
  
    old_position = hand_position;
   
  }//*/
}


//ジャスチャーの検出
void check() {

  for (Hand hand : this.leap.getHands ()) {
    //ジャスチャーの検出
    if (this.t/60==1) {
      this.t=0;

      String finger="";
      for (Finger f : hand.getFingers())finger+=f.isExtended()?1:0;
      switch(finger) {
      case "00000":
        msg="0\nrock";
        osc.sendMessage("MUSICNUM", -1);
        break;
      case "01000":
       osc.sendMessage("MUSICNUM", 1);
        msg="1";
        break;

      case "01100":
      osc.sendMessage("VOLUME", -1);
        msg="2\nscissors";
        break;

      case "00111":
      osc.sendMessage("VOLUME", 1);
        msg="3";
        break;

      case "01111":
      osc.sendMessage("SCALE", -1);
        msg="4";
        break;

      case "11111":
       osc.sendMessage("SCALE", 1);
        msg="5\npaper";
        break;

      case "10001":
       osc.sendMessage("TIME", -0.25);
        msg="6";
        break;

      case "11000":
       osc.sendMessage("TIME", 0.25);
        msg="7";
        break;

      default:
        msg="?";
        return;
      }
      writeMsg(msg);
    }
  }
}
private void HandDraw() {
  for (Hand hand : this.leap.getHands ()) {
    for (Finger finger : hand.getFingers()) {
      strokeWeight(10);
      finger.drawBones();
      finger.drawJoints();
    }
  }
}
public boolean CheckStop() {
  if (this.leap.getHands().size()!=2)return false;
  String finger="";
  for (Hand hand : this.leap.getHands ()) {
    for (Finger f : hand.getFingers())finger+=f.isExtended()?1:0;
  }
  return finger.equals("0000000000");
}
public boolean CheckStart() {
  if (this.leap.getHands().size()!=2)return false;
  String finger="";
  for (Hand hand : this.leap.getHands ()) {
    for (Finger f : hand.getFingers())finger+=f.isExtended()?1:0;
  }
  return finger.equals("1111111111");
}
public  boolean isExist() {
  return this.leap.getHands().size()>0;
}
public boolean isRight() {
  for (Hand hand : this.leap.getHands ()) {
    return hand.isRight();
  }
  return false;
}
public PVector getPos() {
  for (Hand hand : this.leap.getHands ()) {
    return hand.isRight()?hand.getPosition():new PVector(width/2, height/2);
    // return hand.getPosition();
  }
  return null;
}

public boolean getClick() {
  for (Hand hand : this.leap.getHands ()) {
    if (hand.isRight()) {
      String finger="";
      for (Finger f : hand.getFingers())finger+=f.isExtended()?1:0;
      return finger.equals("00000");
    }
  }
  return false;
}
public boolean CheckChange() {
  return !change&&getClick();
}
public boolean getChange() {
  return this.change;
}
public void setChange(boolean change) {
  this.change=change;
}
public void setGesture(boolean gesture) {
  this.gesture=gesture;
}
}

public  void leapOnInit() {
  println("Leap Motion Init");
}
public  void leapOnConnect() {
  println("Leap Motion Connect");
}
public  void leapOnDisconnect() {
  println("Leap Motion Disconnect");
}
public  void leapOnExit() {
  println("Leap Motion Exit");
}
