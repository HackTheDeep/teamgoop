// TODO: copy neighboring tracker
// Shapes should exist independently from micrographs!

class MicroGraph { 
  PImage img;
  String path;
  ArrayList trackers;
  ArrayList shapes;

  MicroGraph(String path) {  
    this.path = path;  
    this.img = loadImage(path);
    trackers = new ArrayList();
  } 

  void draw() {
    // draw image
    image(img, 0, 0, img.width/2, img.height/2);
    if (INVERT_IMAGES) filter(INVERT); 
    draw_trackers();
    if (VERBOSE) {
      fill(255, 0, 0);
      // label overlay
      text(this.path, 10, 30);
    }
  }

  void draw_trackers() {
    PVector t;
    if (mode == "COMMAND" || mode == "ALIGN") {
      for (int i=0; i < trackers.size(); i++) {
        t = (PVector)trackers.get(i);
        fill(0, 128, 0, 128);
        rect(t.x-10, t.y-10, 20, 20);
      }
    }
  }

  void add_tracker() {
    trackers.add(new PVector(mouseX, mouseY));
  }
}