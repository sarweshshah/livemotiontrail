import processing.video.*;

static final int WINDOW_WIDTH = 1280;
static final int WINDOW_HEIGHT = 960;
static final int NO_OF_TRAILS = 5;

Capture video;
ArrayList<PImage> history = new ArrayList<PImage>();

void settings() {
  size(WINDOW_WIDTH, WINDOW_HEIGHT);
}

void setup() {
  video = new Capture(this, WINDOW_WIDTH, WINDOW_HEIGHT);
  video.start();
}

void captureEvent(Capture video) {
  video.read();

  ////Stack operations in real time
  if (history.size() < NO_OF_TRAILS) {
    history.add(video.get());
  } else {
    history.remove(0);
    history.add(video.get());
  }
}

void draw() {
  image(video.get(), 0, 0);

  if (history.size() > 0) {
    for (int i = 0; i < history.size(); i++) {
      superimposeImages(i);
    }
  }
  
  filter(INVERT);
  
  //saveFrame("output/#####.png");
}

void superimposeImages(int i) {
  blend(history.get(i), 
    0, 0, WINDOW_WIDTH, WINDOW_HEIGHT, 
    0, 0, WINDOW_WIDTH, WINDOW_HEIGHT, 
    LIGHTEST); //LIGHEST, OVERLAY, SOFT_LIGHT
}

void keyPressed() {
  noLoop();
}

void keyReleased() {
  loop();
}