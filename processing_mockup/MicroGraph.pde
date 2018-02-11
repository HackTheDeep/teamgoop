// TODO: copy neighboring tracker
// Shapes should exist independently from micrographs!

class MicroGraph { 
  PImage img;
  String path;
  ArrayList trackers;
  ArrayList shapes;
  int current_shape_index;

  MicroGraph(String path) {  
    this.path = path;  
    this.img = loadImage(path);
    trackers = new ArrayList();
    shapes = new ArrayList();

    // Make  a default shape
    shapes.add(new Shape(0));
    current_shape_index = 0;
  } 

  void draw() {
    // draw image
    image(img, 0, 0, img.width/2, img.height/2);
    filter(INVERT); 
    draw_trackers();
    draw_shapes(255);
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

  void draw_shapes(int opacity) {
    // draw shapes
    Shape s;
    if (mode == "COMMAND" || mode == "DRAW") {
      // Draw all shapes
      for (int i=0; i < shapes.size(); i++) {
        s = (Shape)shapes.get(i);
        s.draw(opacity);
      }
    }
  }

  void add_point() {
    if (mode == "ALIGN") {
      trackers.add(new PVector(mouseX, mouseY));
    } else if (mode == "DRAW") {
      ((Shape)shapes.get(current_shape_index)).add_point(new PVector(mouseX, mouseY));
    }
  }
}