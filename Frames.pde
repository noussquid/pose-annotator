/**
 * Frames 
 * by Andres Colubri. 
 * 
 * Moves through the video one frame at the time by using the
 * arrow keys. It estimates the frame counts using the framerate
 * of the movie file, so it might not be exact in some cases.
 */
 
import processing.video.*;

Movie mov;
int newFrame = 0;
PImage img; 

int pressX, pressY;
int releaseX, releaseY;
int moveX, moveY;
int dragX, dragY;

float cx;
float cy;

int circleSize = 25;
boolean overCircle = false;
boolean locked = false; 
float xOffset = 0.0;
float yOffset = 0.0;

int currentKey = -1;

ArrayList<PVector> circles = new ArrayList<PVector>();


 void setup() {
  //size(640, 360);
  size(1200, 637);
  background(0);
  // Load and set the video to play. Setting the video 
  // in play mode is needed so at least one frame is read
  // and we can get duration, size and other information from
  // the video stream. 
  mov = new Movie(this, "sophie1.mp4");  
  img = loadImage("keypoints_pose.png");
  
  // Pausing the video at the first frame. 
  mov.play();
  mov.jump(0);
  mov.pause();
  
  PVector key0 = new PVector(879, 64);
  PVector key1 = new PVector(884, 133);
  PVector key2 = new PVector(817, 130);
  PVector key3 = new PVector(795, 242);
  PVector key4 = new PVector(778, 336);
  PVector key5 = new PVector(953, 130);
  PVector key6 = new PVector(979, 238);
  PVector key7 = new PVector(987, 342);
  PVector key8 = new PVector(840, 345);
  PVector key9 = new PVector(829, 493);
  PVector key10 = new PVector(825, 621);
  PVector key11 = new PVector(932, 354);
  PVector key12 = new PVector(927, 498);
  PVector key13 = new PVector(919, 616);
  PVector key14 = new PVector(868, 39);
  PVector key15 = new PVector(890, 37); 
  PVector key16 = new PVector(844, 51);
  PVector key17 = new PVector(914, 92);

  circles.add(key0);
  circles.add(key1);
  circles.add(key2);
  circles.add(key3);
  circles.add(key4);
 
  circles.add(key5);
  circles.add(key6);
  circles.add(key7);
  circles.add(key8);
  circles.add(key9);
  circles.add(key10);
  circles.add(key11);
  circles.add(key12);
  circles.add(key13);
  circles.add(key14);
  circles.add(key15);
  circles.add(key16);
  circles.add(key17);
 
}

void movieEvent(Movie m) {
  m.read();
}

void draw() {
  background(0);
  image(mov, 0, 0, 640, 360);
  
  image(img, 645, 0, 480, 637);
  
  fill(255);
  text(getFrame() + " / " + (getLength() - 1), 10, 30);
  
  //for (PVector circle : circles) {
    for (int i = 0; i < circles.size(); i++) {
      PVector circle = circles.get(i);
      
      if (mouseX > circle.x - circleSize && mouseX < circle.x + circleSize &&
        mouseY > circle.y - circleSize && mouseY < circle.y + circleSize) {
          overCircle = true;
          if (!locked) {
            stroke(255);
            fill(153);
            ellipse(circle.x, circle.y, circleSize, circleSize);
            currentKey = i;
            println("Current key is: " + currentKey);
          }
        } else {
          stroke(153);
          fill(153);
          overCircle = false;
        }
        
  }
  
}

void keyPressed() {
  if (key == CODED) {
    if (keyCode == LEFT) {
      if (0 < newFrame) newFrame--; 
    } else if (keyCode == RIGHT) {
      if (newFrame < getLength() - 1) newFrame++;
    }
  } 
  setFrame(newFrame);  
}
  
int getFrame() {    
  return ceil(mov.time() * 30) - 1;
}

void setFrame(int n) {
  mov.play();
    
  // The duration of a single frame:
  float frameDuration = 1.0 / mov.frameRate;
    
  // We move to the middle of the frame by adding 0.5:
  float where = (n + 0.5) * frameDuration; 
    
  // Taking into account border effects:
  float diff = mov.duration() - where;
  if (diff < 0) {
    where += diff - 0.25 * frameDuration;
  }
    
  mov.jump(where);
  mov.pause();  
}  

int getLength() {
  return int(mov.duration() * mov.frameRate);
}

void mousePressed() {
  println("Mouse Pressed");
  pressX = mouseX;
  pressY = mouseY;
  
  if (overCircle) {
    locked = true;
    fill(0, 0, 0);
  } else {
    locked = false;
  }
  
  xOffset = mouseX - cx;
  yOffset = mouseX - cy;
  
}

void mouseDragged() {
  println("Mouse Dragged");
  dragX = mouseX;
  dragY = mouseY;
}

void mouseReleased() {
  println("Mouse Relased");
  releaseX = mouseX;
  releaseY = mouseY;
}