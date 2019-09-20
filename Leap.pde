
public class LEAP {
  private LeapMotion leap;
  String msg="";                                    //送信メッセージ
  private boolean start=false;
  PVector old_position=new PVector(0, 0);
  private boolean change=false;
  private boolean gesture=false;
  private boolean test=false;

  private int t=0;


  private boolean gesture_left=false;
  private boolean gesture_right=false;
  private boolean gesture_up=false;
  private boolean gesture_down=false;
  private boolean gesture_zoom=false;
  private float movePos=0;

  private float mFrame;
  private PVector leftPosition;
  private PVector rightPosition;
  private PVector leftRePosition;
  private PVector rightRePosition;

  private float zoom=1;
  private float smallestV=1.45;
  private float deltaV=1;



  public LEAP(LeapMotion leap) {
    this.leap=leap;
  }

  //処理
  public void update() {
    HandDraw();
    //   println(this.leap.getHands().size());
    //if (this.leap.getHands().size()>1) {
    for (Hand hand : this.leap.getHands()) {
      if (hand.isRight()) {
        this.mFrame=hand.getTimeVisible();
        print(this.mFrame);
      }
    }

    if (this.leap.getHands().size()>0) {
      if (this.leap.getHands().size()==2) {
        zoom=CalcuateDistance(this.mFrame);
      }
      if (this.leap.getHands().size()==1) {
        LRUDGestures(this.mFrame, movePos);
      }
    }
    if (this.gesture) {
      this.t++;
      check();
    }
    if (gui.getFlag()&&CheckStop()) {
      gui.getController("PLAY").setValue(0);
    } else if (!gui.getFlag()&&CheckStart()) {
      gui.getController("PLAY").setValue(1);
    }
  }

  private float CalcuateDistance(float mFrame) {
    gesture_zoom=true;
    gesture_left=false;
    gesture_right=false;

    float distance=0;
    for (Hand hand : this.leap.getHands()) {
      if (hand.isLeft()) {
        leftPosition=hand.getPosition();
      }
      if (hand.isRight()) {
        rightPosition=hand.getPosition();
      }
    }
    if (!leftPosition.equals(new PVector(0, 0))&&!rightPosition.equals(new PVector(0, 0))) {
      PVector leftPos= new PVector(leftPosition.x, leftPosition.y);
      PVector rightPos= new PVector(rightPosition.x, rightPosition.y);
      distance=10*PVector.dist(leftPos, rightPos);
      println("distance" + distance);
    }
    if (distance!=0) {
      return distance;
    }

    return distance=1;
  }
  void LRUDGestures(float mFrame, float movePos) {
    this.gesture_zoom=false;
    for (Hand hand : this.leap.getHands()) {
      if (hand.getGrabStrength()==1) {
        println("close");
      } else if (hand.getGrabStrength()==0) {
        println("open");
        PVector v=getV(hand);
        movePos=hand.getPosition().x;
        if (isMoveLeft(hand, v)) {
          this.gesture_left=true;
          this.gesture_right=false;
          println("move Left");
        } else if (isMoveRight(hand, v)) {
          this.gesture_left=false;
          this.gesture_right=true;
          println("move Right");
        } else if (isMoveUp(hand, v)) {
          this.gesture_left=false;
          this.gesture_right=false;
          println("move Up");
        } else if (isMoveDown(hand, v)) {
          this.gesture_left=false;
          this.gesture_right=false;
          println("move Down");
        }
      }
    }
  }

  //get hand v
  private PVector getV(Hand hand) {
   // return new PVector(0, 0, 0);
    return hand.getPosition();
  }
  //hand move 4 direction
  private boolean isMoveRight(Hand hand, PVector v) {
    return v.x>deltaV&&!isNoMove(hand,v);
  }
  private boolean isMoveLeft(Hand hand, PVector v) {
    return v.x<-deltaV&&!isNoMove(hand,v);
  }
  private boolean isMoveDown(Hand hand, PVector v) {
    return v.y>deltaV&&!isNoMove(hand,v);
  }
  private boolean isMoveUp(Hand hand, PVector v) {
    return v.y<-deltaV&&!isNoMove(hand,v);
  }

  //no move
  private boolean isNoMove(Hand hand, PVector v) {
    println("nomove");
    return v.x<smallestV&&v.y<smallestV&&v.z<smallestV;
  }

    //ジャスチャーの検出
    void check() {

    for (Hand hand : this.leap.getHands ()) {
      //ジャスチャーの検出
      if (this.t/60==1) {
        this.t=0;

        String finger="";
        String s="";
        int n=0;

        for (Finger f : hand.getFingers())finger+=f.isExtended()?1:0;
        switch(finger) {
        case "00000":
          msg="0\nrock";
          s="MUSICNUM";
          n=-1;

          break;
        case "01000":
          s="MUSICNUM";
          n=1;
          msg="1";
          break;

        case "01100":
          s="VOLUME";
          n=-1;
          msg="2\nscissors";
          break;

        case "00111":
          s="VOLUME";
          n=1;
          msg="3";
          break;

        case "01111":
          s="SCALE";
          n=-1;

          msg="4";
          break;

        case "11111":
          s="SCALE";
          n=1;

          msg="5\npaper";
          break;

        case "10001":
          s="TIME";
          n=-1;


          msg="6";
          break;

        case "11000":
          s="TIME";
          n=1;
          msg="7";
          break;

        default:
          msg="?";
          return;
        }
        //writeMsg(msg);
        osc.sendMessage(s, n);
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
  public boolean CheckSlide() {
    if (this.leap.getHands().size()!=2)return false;
    String finger="";
    for (Hand hand : this.leap.getHands ()) {
      for (Finger f : hand.getFingers())finger+=f.isExtended()?1:0;
    }
    //  println(finger, finger.substring(0, 5));
    return finger.substring(0, 5).equals("00000");
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
