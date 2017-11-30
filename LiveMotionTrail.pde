import processing.video.*;

static final int WINDOW_WIDTH = 1280;
static final int WINDOW_HEIGHT = 960;

static final int REFRESH_RATE = 100;
static final int NO_OF_TRAILS = 10;

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

  if (history.size() == NO_OF_TRAILS) {
    blend(history.get(0), 0, 0, WINDOW_WIDTH, WINDOW_HEIGHT, 0, 0, WINDOW_WIDTH, WINDOW_HEIGHT, LIGHTEST);
  }
}

void draw() {
  ////Stack operations in real time
  if (history.size() < NO_OF_TRAILS) {
    history.add(video.get());
  } else {
    history.remove(0);
    history.add(video.get());
  }

  image(history.get(0), 0, 0);
}

void keyPressed() {
  noLoop();
}

void keyReleased() {
  loop();
}