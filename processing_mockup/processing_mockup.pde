import processing.svg.*;

// assertions:
// all images are the same width and height

// TODOS
// Editable shapes
// Shape inspector
//    name
//    color
//    type
//    frames it's on
//    display!
// shape list
// Shape active on each frame
// Export curves as SVG --> Blender

// CBBS
// UNDOS
// MAKE 3D mode preview!
// Load jpgs, not tiffs
// Save and open a set of shapes / micrographs

int WIDTH = 1280;
int HEIGHT = 1024;
ArrayList micrographs; //= new ArrayList();
int current_frame_number = 0;
MicroGraph current_mg, prev_mg, next_mg;
Boolean VERBOSE = true;
String mode = "COMMAND";

void setup() {
  frameRate(30);
  size(1250, 680, P3D);
  textSize(20);
}

void set_micrographs(String[] files){
  micrographs = load_micrographs(files);  
}

void draw() {
  // draw frame w/ overlay  
  if(!micrographs) return;
  current_mg = (MicroGraph)(micrographs.get(current_frame_number));
  current_mg.draw();
  println("Drawing frame: " + current_frame_number);

  // Onion Skining!
  onion_skinning();

  // draw mode
  fill(255, 0, 0);
  if (mode == "DRAW") {
    text(mode + " " + get_current_mg_shape().id, width-150, 30);
  } else {
    text(mode, width-150, 30);
  }
}

Shape get_current_mg_shape() {
  return ((Shape)current_mg.shapes.get(current_mg.current_shape_index));
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
      mode = "COMMAND";
    }
  }
}

void mouseClicked() {
  current_mg.add_point();
}

void onion_skinning() {
  int prev_frame_index = current_frame_number - 1;
  if (prev_frame_index >= 0) {
    prev_mg = (MicroGraph)(micrographs.get(prev_frame_index));
    prev_mg.draw_shapes(128);
  }
  int next_frame_index = current_frame_number + 1;
  if (next_frame_index < micrographs.size()) {
    next_mg = (MicroGraph)(micrographs.get(next_frame_index));
    next_mg.draw_shapes(128);
  }
}