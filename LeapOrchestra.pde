//LeapMotoin
import de.voidplus.leapmotion.*;
LeapMotion leap;

//UDP
import hypermedia.net.*;
import controlP5.*;
UDP udp;
ControlP5 cp5;
final String IP = "255.255.255.255";
final int PORT =53131;
String msg = "test_messege";   //UDPで送るコマンド


PVector old_position;
boolean init=false;
int size=0;
//RECT
color a=color(255, 0, 0);
color b=color(255, 0, 0);
color c=color(255, 0, 0);
color d=color(255, 0, 0);

// ======================================================
// Table of Contents:
// ├─ 1. Callbacks
// ├─ 2. Hand
// ├─ 3. Arms
// ├─ 4. Fingers
// ├─ 5. Bones
// ├─ 6. Tools
// └─ 7. Devices
// ======================================================




void setup() {

  size(800, 500);
  background(255);

  this.old_position = new PVector(0, 0, 0);

  //Leap
  leap = new LeapMotion(this);

  //UDP
  cp5 = new ControlP5(this);
  udp = new UDP( this, 2333);
  ControlFont cf = new ControlFont(createFont("メイリオ", 20));
  cp5.addButton("UDP_Msg")
    .setFont(cf)
    .setLabel("送信")
    .setPosition(50, 50)
    .setSize(100, 100);
}


void UDP_Msg() {
  udp.send(msg, IP, PORT);
}

// ======================================================
// 1. Callbacks

void leapOnInit() {
  println("Leap Motion Init");
}
void leapOnConnect() {
  println("Leap Motion Connect");
}
void leapOnDisconnect() {
  println("Leap Motion Disconnect");
}
void leapOnExit() {
  println("Leap Motion Exit");
}

void drawRect() {

  rectMode(CENTER);
  strokeWeight(10);
  strokeJoin(BEVEL);

  textSize(32);
  textAlign(CENTER, CENTER);
  strokeWeight(10);
  pushMatrix();
  stroke(a);
  fill(255);

  translate(width/2, height/2-height/3);
  //fill(255);
  rect(0, 0, width/8, width/8);
  fill(a);
  text("1", 0, 0);

  popMatrix();

  pushMatrix();
  stroke(b);
  translate(width/2-width/3, height/2+height/4);
  fill(255);
  rect(0, 0, width/8, width/8);
  fill(b);
  text("3", 0, 0);
  popMatrix();

  pushMatrix();
  stroke(c);
  translate(width/2, height/2+height/4);
  fill(255);
  rect(0, 0, width/8, width/8);
  fill(c);
  text("2", 0, 0);
  popMatrix();

  pushMatrix();
  stroke(d);
  translate(width/2+width/3, height/2+height/4);
  fill(255);
  rect(0, 0, width/8, width/8);
  fill(d);
  text("4", 0, 0);
  popMatrix();
}
void draw() {

  background(255);
//-------------------------------------------------------
  PVector hand_position=new PVector(0, 0, 0);
  boolean abc=false;
  for (Hand hand : this.leap.getHands ()) {

    //手の座標を取る
    hand_position   = hand.getPosition();
    if (init) {
      old_position = hand_position;
      init = false;
    } else {
      if (old_position != hand_position) {
        init=true;
      }
    }
    
    //abs
    /*up down
    if (abs(hand_position.y - old_position.y)>5) {
      abc=true;
      println((hand_position.y - old_position.y));
    }
    //*/
    //left rignh
    //*
    //change?
    // println((hand_position.x - old_position.x));
     if ((hand_position.x - old_position.x)>60) {
      abc=true;
      println((hand_position.x - old_position.x));
    }
    //add 
    else if((hand_position.x - old_position.x)>3&&(hand_position.x - old_position.x)>5){
       abc=true;
   //   println("right",millis());
    }
    else if((hand_position.x - old_position.x)<-3&&(hand_position.x - old_position.x)>-5){
     abc=true;
     // println("left",millis());
    }
     else if((hand_position.x - old_position.x)<-60){
     abc=true;
    // println((hand_position.x - old_position.x));
    }
    //*/
  }
//---------------------------------------------------------
  int fps = leap.getFrameRate();
  for (Hand hand : leap.getHands ()) {


    // ==================================================
    // 2. Hand

    int     handId             = hand.getId();
    PVector handPosition       = hand.getPosition();
    PVector handStabilized     = hand.getStabilizedPosition();
    PVector handDirection      = hand.getDirection();
    PVector handDynamics       = hand.getDynamics();
    float   handRoll           = hand.getRoll();
    float   handPitch          = hand.getPitch();
    float   handYaw            = hand.getYaw();
    boolean handIsLeft         = hand.isLeft();
    boolean handIsRight        = hand.isRight();
    float   handGrab           = hand.getGrabStrength();
    float   handPinch          = hand.getPinchStrength();
    float   handTime           = hand.getTimeVisible();
    PVector spherePosition     = hand.getSpherePosition();
    float   sphereRadius       = hand.getSphereRadius();

    // --------------------------------------------------
    // Drawing
    drawRect();

    // hand.draw();

    if (handPosition.x>width/2-width/8&&handPosition.x<width/2+width/8&&handPosition.y<height/2-height/3+width/8&&handPosition.y>height/2-height/3-width/8) {
      a=color(0, 255, 0);
      msg="1";
    } else {
      a=color(255, 0, 0);
    }
    if (handPosition.x>width/2-width/3-width/8&&handPosition.x<width/2-width/3+width/8&&handPosition.y<height/2+height/4+width/8&&handPosition.y>height/2+height/4-width/8) {
      b=color(0, 255, 0);
      msg="2";
    } else {
      b=color(255, 0, 0);
    }
    if (handPosition.x>width/2-width/8&&handPosition.x<width/2+width/8&&handPosition.y<height/2+height/4+width/8&&handPosition.y>height/2+height/4-width/8) {
      c=color(0, 255, 0);
      msg="3";
    } else {
      c=color(255, 0, 0);
    }
    if (handPosition.x>width/2+width/3-width/8&&handPosition.x<width/2*width/3+width/8&&handPosition.y<height/2+height/4+width/8&&handPosition.y>height/2+height/4-width/8) {
      d=color(0, 255, 0);
      msg="4";
    } else {
      d=color(255, 0, 0);
    }
    /*   
     a=(handPosition.x>width/2-width/8&&handPosition.x<width/2+width/8&&handPosition.y<height/2-height/3+width/8&&handPosition.y>height/2-height/3-width/8)?color(0, 255, 0):color(255, 0, 0);
     b=(handPosition.x>width/2-width/3-width/8&&handPosition.x<width/2-width/3+width/8&&handPosition.y<height/2+height/4+width/8&&handPosition.y>height/2+height/4-width/8)?color(0, 255, 0):color(255, 0, 0);
     c=(handPosition.x>width/2-width/8&&handPosition.x<width/2+width/8&&handPosition.y<height/2+height/4+width/8&&handPosition.y>height/2+height/4-width/8)?color(0, 255, 0):color(255, 0, 0);
     d=(handPosition.x>width/2+width/3-width/8&&handPosition.x<width/2*width/3+width/8&&handPosition.y<height/2+height/4+width/8&&handPosition.y>height/2+height/4-width/8)?color(0, 255, 0):color(255, 0, 0);
     //*/
    // ==================================================
    // 3. Arm

    if (hand.hasArm()) {
      Arm     arm              = hand.getArm();
      float   armWidth         = arm.getWidth();
      PVector armWristPos      = arm.getWristPosition();
      PVector armElbowPos      = arm.getElbowPosition();
      arm.draw();
    }


    // ==================================================
    // 4. Finger
    Finger  fingerThumb        = hand.getThumb();
    Finger  fingerIndex        = hand.getIndexFinger();
    Finger  fingerMiddle       = hand.getMiddleFinger();
    Finger  fingerRing         = hand.getRingFinger();
    Finger  fingerPink         = hand.getPinkyFinger();
    //指で抓む
    if (handPinch==1) {
      msg="指で抓む";
    }
    //グー
    if (!fingerThumb.isExtended()&&!fingerIndex.isExtended()&&!fingerMiddle.isExtended()&&!fingerRing.isExtended()&&!fingerPink.isExtended()) {
      msg="グー";
    }
    //チョキ
    if (!fingerThumb.isExtended()&&fingerIndex.isExtended()&&fingerMiddle.isExtended()&&!fingerRing.isExtended()&&!fingerPink.isExtended()) {
      msg="チョキ";
    }
    //パー
    if (fingerThumb.isExtended()&&fingerIndex.isExtended()&&fingerMiddle.isExtended()&&fingerRing.isExtended()&&fingerPink.isExtended()) {
      msg="パー";
    }
    for (Finger finger : hand.getFingers()) {
      // or              hand.getOutstretchedFingers();
      // or              hand.getOutstretchedFingersByAngle();

      int     fingerId         = finger.getId();
      PVector fingerPosition   = finger.getPosition();
      PVector fingerStabilized = finger.getStabilizedPosition();
      PVector fingerVelocity   = finger.getVelocity();
      PVector fingerDirection  = finger.getDirection();
      float   fingerTime       = finger.getTimeVisible();

      // ------------------------------------------------
      // Drawing

      // Drawing:
      finger.draw();  // Executes drawBones() and drawJoints()
      finger.drawBones();
      finger.drawJoints();

      // ------------------------------------------------
      // Selection

      switch(finger.getType()) {
      case 0:
        // System.out.println("thumb");
        break;
      case 1:
        // System.out.println("index");
        break;
      case 2:
        // System.out.println("middle");
        break;
      case 3:
        // System.out.println("ring");
        break;
      case 4:
        // System.out.println("pinky");
        break;
      }


      // ================================================
      // 5. Bones
      // --------
      // https://developer.leapmotion.com/documentation/java/devguide/Leap_Overview.html#Layer_1

      Bone    boneDistal       = finger.getDistalBone();
      // or                      finger.get("distal");
      // or                      finger.getBone(0);

      Bone    boneIntermediate = finger.getIntermediateBone();
      // or                      finger.get("intermediate");
      // or                      finger.getBone(1);

      Bone    boneProximal     = finger.getProximalBone();
      // or                      finger.get("proximal");
      // or                      finger.getBone(2);

      Bone    boneMetacarpal   = finger.getMetacarpalBone();
      // or                      finger.get("metacarpal");
      // or                      finger.getBone(3);

      // ------------------------------------------------
      // Touch emulation

      int     touchZone        = finger.getTouchZone();
      float   touchDistance    = finger.getTouchDistance();

      switch(touchZone) {
      case -1: // None
        break;
      case 0: // Hovering
        // println("Hovering (#" + fingerId + "): " + touchDistance);
        break;
      case 1: // Touching
        // println("Touching (#" + fingerId + ")");
        break;
      }
    }


    // ==================================================
    // 6. Tools

    for (Tool tool : hand.getTools()) {
      int     toolId           = tool.getId();
      PVector toolPosition     = tool.getPosition();
      PVector toolStabilized   = tool.getStabilizedPosition();
      PVector toolVelocity     = tool.getVelocity();
      PVector toolDirection    = tool.getDirection();
      float   toolTime         = tool.getTimeVisible();

      // ------------------------------------------------
      // Drawing:
      tool.draw();

      // ------------------------------------------------
      // Touch emulation

      int     touchZone        = tool.getTouchZone();
      float   touchDistance    = tool.getTouchDistance();

      switch(touchZone) {
      case -1: // None
        break;
      case 0: // Hovering
        // println("Hovering (#" + toolId + "): " + touchDistance);
        break;
      case 1: // Touching
        // println("Touching (#" + toolId + ")");
        break;
      }
    }
  }


  // ====================================================
  // 7. Devices

  for (Device device : leap.getDevices()) {
    float deviceHorizontalViewAngle = device.getHorizontalViewAngle();
    float deviceVericalViewAngle = device.getVerticalViewAngle();
    float deviceRange = device.getRange();
  }
}
