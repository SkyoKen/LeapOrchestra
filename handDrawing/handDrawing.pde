import de.voidplus.leapmotion.*;

ArrayList<PVector> old;
boolean init;
PVector old_position, old_velocity, center, target;
color bg = 125; 
LeapMotion leap;

void setup() {
  size(800, 500);
  background(bg);
  leap = new LeapMotion(this);

  init = true;
  old = new ArrayList<PVector>();
  old_position = new PVector(0, 0, 0);
  old_velocity = new PVector(0, 0, 0);
  strokeWeight(1);
  stroke(0);

  center = new PVector(width/2, height, 50);
  target = new PVector();
  noFill();
}

void draw() {
  handDraw();
}
void handDraw(){
  // ========= HANDS =========

  if (leap.getHands().size() == 0) {
    //No hand
    init = true; // reset coordinates for the drawing
  }

  for (Hand hand : leap.getHands ()) {

    PVector hand_position   = hand.getPosition();

    if (init) {
      old_position = hand_position;
      old.clear(); // Empties the ArrayList
      for (int i=0; i < 3; i++) {
        old.add(old_position);
      }
      init = false;
    }

    if ( hand_position.z > 45 ) {
      stroke(0);
    } else {
      stroke(255);
    }

    strokeWeight(abs(hand_position.z - old_position.z));


    curve (
      old.get(0).x, old.get(0).y, 
      old.get(1).x, old.get(1).y, 
      old.get(2).x, old.get(2).y, 
      hand_position.x, hand_position.y
      );

 
    // Store actual finger position for next round.
    old_position = hand_position;
    old.remove(0);
    old.add(old_position);

    // ========= FINGER =========
    Finger  fingerThumb        = hand.getThumb();
    Finger  fingerIndex        = hand.getIndexFinger();
    Finger  fingerMiddle       = hand.getMiddleFinger();
    Finger  fingerRing         = hand.getRingFinger();
    Finger  fingerPink         = hand.getPinkyFinger();
    if (!fingerThumb.isExtended()&& !fingerIndex.isExtended()&&!fingerMiddle.isExtended()&&!fingerRing.isExtended()&&!fingerPink.isExtended()) {
       background(bg);
    }
  }
}

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
