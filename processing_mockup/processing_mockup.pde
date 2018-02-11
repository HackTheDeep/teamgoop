import processing.svg.*;

// assertions:
// all images are the same width and height

// TODOS
// move selection to indivdual points
// draw keyframes differently
// Shape active on each frame
// don't calculate tangents when drawing!
// Editable shapes
// add multiple shapes / shape list
// Shape inspector
//    name
//    color
//    type
//    frames it's on
//    display!
// Fix onion Skinning!

// real vector export!

// Global options
// invert images
// onion skinning


// CBBS
// UNDOS
// MAKE 3D mode preview!
// Load jpgs, not tiffs
// Save and open a set of shapes / micrographs

//import controlP5.*;
//import static controlP5.ControlP5.*;
//import java.util.*;
//import java.util.Map.Entry;

//ControlP5 cp5;

int WIDTH = 1280;
int HEIGHT = 1024;
ArrayList micrographs = new ArrayList();
int current_frame_number = 0;
MicroGraph current_mg, prev_mg, next_mg;
Boolean VERBOSE = true;
Boolean ONION_SKINNING = true;
Boolean INVERT_IMAGES = false;
String mode = "COMMAND";
PFont f1, f2;
int current_shape_index = 0;
Shape s;
Boolean export = false;
String export_filename;
int point_index;

ArrayList shapes = new ArrayList();

void setup() {
  frameRate(30);
  size(640, 512);
  textSize(20);
  micrographs = load_micrographs();

  // shapelist stuff
  f1 = createFont("Helvetica", 20);
  f2 = createFont("Helvetica", 12);
  //cp5 = new ControlP5( this );

  // Make a default shape
  shapes.add(new Shape(0, micrographs.size()));

  /*
  // register 'menu' as the callback for clicks!
   ShapeList shapelist = new ShapeList(cp5, "menu", 200, 400);
   
   shapelist.setPosition(40, 40);
   // add some items to our shapelist
   for (int i=0; i<5; i++) {
   shapelist.addItem(makeItem("headline-"+i, "subline", "some copy lorem ipsum "));
   }
   */
}

void draw() {
  // draw current micrograph
  current_mg = (MicroGraph)(micrographs.get(current_frame_number));
  current_mg.draw();

  if (export) {
    for (int export_frame = 0; export_frame < micrographs.size(); export_frame++) {
      export_filename = "export/output_"+export_frame+".svg";
      beginRaw(SVG, export_filename);
      for (int i=0; i < shapes.size(); i++) {
        s = (Shape)shapes.get(i);
        s.draw(255, current_frame_number, export);
      }
      endRaw();
      println("Exported " + export_filename);
    }
    export = false;
    ONION_SKINNING = true;
  }

  // draw all shapes w/ optional onion skinning
  if (mode == "COMMAND" || mode == "DRAW") {

    // Draw all shapes
    for (int i=0; i < shapes.size(); i++) {
      s = (Shape)shapes.get(i);
      s.draw(255, current_frame_number, export);

      // Onion Skinning
      if (ONION_SKINNING) {
        int prev_frame_index = current_frame_number - 1;
        if (prev_frame_index >= 0) {
          s.draw(64, prev_frame_index, export);
        }

        int next_frame_index = current_frame_number + 1;
        if (next_frame_index < micrographs.size()) {
          s.draw(64, next_frame_index, export);
        }
      }
    }
  }

  // display mode
  fill(255, 0, 0);
  if (mode == "DRAW") {
    text(mode + " " + ((Shape)shapes.get(current_shape_index)).id, width-150, 30);
  } else {
    text(mode, width-150, 30);
  }
}


// reading the frames with the arrow keys
void keyPressed() {
  // Special keys!
  if (key == CODED) {
    if (keyCode == UP || keyCode == RIGHT) {
      current_frame_number = min(current_frame_number + 1, micrographs.size()-1);
    } else if (keyCode == DOWN || keyCode == LEFT) {
      current_frame_number = max(current_frame_number - 1, 0);
    }
    // Regular keys
  } else { 
    if (key == 'd') {
      mode = "DRAW";
    } else if (key == 'a') {
      mode = "ALIGN";
    } else if (key == 'c') {
      int last_id = ((Shape)shapes.get(shapes.size()-1)).id;
      shapes.add(new Shape(last_id+1, micrographs.size()));
      current_shape_index = last_id+1;
    } else if (key == 'i') {
      INVERT_IMAGES = !INVERT_IMAGES;
    } else if (key == 'o') {
      ONION_SKINNING = !ONION_SKINNING; 

      // delete!
    } else if (key == DELETE || key == BACKSPACE) {
      s = ((Shape)shapes.get(current_shape_index));
      s.delete_selected();

      // export!
    } else if (key == 'e') {
      export = true;
      ONION_SKINNING = false;
    }
  }
}

int hit_a_centroid(int frame) {
  Shape s;
  for (int i=0; i < shapes.size(); i++) {
    s = ((Shape)shapes.get(i));
    if (s.hit_centroid(frame)) {
      return i;
    }
  }
  return -1;
}

void mouseClicked() {
  if (mode == "DRAW") {
    s = ((Shape)shapes.get(current_shape_index));
    AnimatedPoint ap = s.point_at(current_frame_number);

    int shape_index = hit_a_centroid(current_frame_number);
    // if the point index is a real point, set it to selected
    if (ap != null) {
      s.clear_all_selected();
      ap.selected = true;

      // if we hit the centroid, change the selection to be this shape.
    } else if (shape_index != -1) {
      current_shape_index = shape_index;

      // otherwise clear the selection but add a new point
    } else {
      Boolean anything_selected = s.clear_all_selected();
      if (!anything_selected) {
        s.add_point();
      }
    }
  } else if (mode == "ALIGN") {
    current_mg.add_tracker();
  }
}

void mouseDragged() {
  if (mode == "DRAW") {
    s = ((Shape)shapes.get(current_shape_index));
    s.move_points(current_frame_number);
  }
}

void mouseRelease() {
  s = ((Shape)shapes.get(current_shape_index));
  s.clear_all_selected();
}