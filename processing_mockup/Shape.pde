// TODO
// Pick shape color somehow... https://forum.processing.org/one/topic/processing-color-picker.html
// Set name
// 
// choose type of shape!
// draw with onion skinning!

final int HANDLE_SIZE = 5;
final color HANDLE_COLOR = color(0, 0, 255);

float sum_x = 0;
float sum_y = 0;

class Shape {
  ArrayList<AnimatedPoint> points;
  int id;
  int num_micrographs;
  int selected_index = -1;

  Shape(int id, int num_micrographs) {
    points = new ArrayList();
    this.id = id;
    this.num_micrographs = num_micrographs;
    points = new ArrayList<AnimatedPoint>();
  }

  void set_selected(int index) {
    selected_index = index;
  }

  int hittest(int current_frame_number) {
    println("hittest!");
    PVector p;
    AnimatedPoint animatedpoint;
    for (int i=0; i < points.size(); i++) {
      animatedpoint = (AnimatedPoint)points.get(i);
      p = animatedpoint.calculated_position(current_frame_number);
      if (mouseX > p.x - 5 && mouseX < p.x + 5 && mouseY > p.y - 5 && mouseY < p.y + 5) {
        println("hit worked!");
        return i;
      }
    }
    println("hit failed!");
    return -1;
  }

  int point_at(int current_frame_number) {
    Integer result = hittest(current_frame_number);
    if (result != -1) {
    }
    return result;
  }

  void add_point() {
    // TODO: get the ordering right.
    AnimatedPoint ap = new AnimatedPoint(new PVector(mouseX, mouseY));
    points.add(ap);
  }

  void delete_selected() {
    if (selected_index == -1) {
      return;
    }
    points.remove(selected_index);

    selected_index = -1;
  }

  void move_point(int current_frame, int point_index) {
    AnimatedPoint ap = (AnimatedPoint)points.get(point_index);
    ap.set_value_at_frame(new PVector(mouseX, mouseY), current_frame);
  }

  ArrayList get_values_on_this_frame(int frame) {
    ArrayList values_on_this_frame = new ArrayList();
    PVector p;

    for (int i = 0; i < points.size(); i++) {
      println("Fframe: " + frame);
      AnimatedPoint ap = (AnimatedPoint)points.get(i);
      p = ap.calculated_position(frame);
      values_on_this_frame.add(p);
    }

    return values_on_this_frame;
  }

  void draw(int opacity, int frame, boolean export) {
    PVector p, prev, cp1, cp2;

    sum_x = 0;
    sum_y = 0;

   for (int i = 0; i < points.size(); i++) {
      AnimatedPoint ap = (AnimatedPoint)points.get(i);
      ap.draw_on_this_frame(frame);
   }

    ArrayList values_on_this_frame = get_values_on_this_frame(frame);

    // If we have at least 3 points, draw curves
    if (values_on_this_frame.size() > 3) {
      sum_x += ((PVector)values_on_this_frame.get(0)).x;
      sum_y += ((PVector)values_on_this_frame.get(0)).y;
      for (int i=1; i < values_on_this_frame.size(); i++) {
        draw_bezier(values_on_this_frame, i-1, i, opacity, export);
        sum_x += ((PVector)values_on_this_frame.get(i)).x;
        sum_y += ((PVector)values_on_this_frame.get(i)).y;
      }
      draw_bezier(values_on_this_frame, values_on_this_frame.size() - 1, 0, opacity, export);

      // Draw the centroid!
      if (!export) {
        fill(128, 0, 0, opacity);
        ellipse(sum_x /= values_on_this_frame.size(), sum_y /= values_on_this_frame.size(), 20, 20);
      }
    }
  }

  int safe_prev_index(int index, int size) {
    int prev = index - 1;
    if (prev < 0) prev = size - 1;
    return prev;
  }

  int safe_next_index(int index, int size) {
    return (index + 1) % size;
  }

  void draw_bezier(ArrayList this_frame_points, int p1_index, int p2_index, int opacity, boolean export) {

    // find the previous and next points...
    int p0_index = safe_prev_index(p1_index, this_frame_points.size());
    int p3_index = safe_next_index(p2_index, this_frame_points.size());


    PVector p0 = (PVector)this_frame_points.get(p0_index);
    PVector p1 = (PVector)this_frame_points.get(p1_index);
    PVector p2 = (PVector)this_frame_points.get(p2_index);
    PVector p3 = (PVector)this_frame_points.get(p3_index);

    PVector p1_tan = new PVector(p2.x - p0.x, p2.y - p0.y);
    PVector p2_tan = new PVector(p3.x - p1.x, p3.y - p1.y);
    p1_tan.normalize();
    p2_tan.normalize();

    float handle_length = PVector.dist(p1, p2) / 4;

    PVector cp1 = new PVector(p1.x + handle_length*p1_tan.x, p1.y + handle_length*p1_tan.y);
    PVector cp2 = new PVector(p2.x - handle_length*p2_tan.x, p2.y - handle_length*p2_tan.y);

    if (export) {
      noFill();
      stroke(0);
      bezier(p1.x, p1.y, cp1.x, cp1.y, cp2.x, cp2.y, p2.x, p2.y);
    } else { 
      noFill();
      stroke(255, opacity);
      strokeWeight(2);
      bezier(p1.x, p1.y, cp1.x, cp1.y, cp2.x, cp2.y, p2.x, p2.y);

      noStroke();
      // Draw the handles in blue
      fill(HANDLE_COLOR, opacity);
      ellipse(cp1.x, cp1.y, HANDLE_SIZE, HANDLE_SIZE);
      ellipse(cp2.x, cp2.y, HANDLE_SIZE, HANDLE_SIZE);

      stroke(128, opacity);
      strokeWeight(1);
      line(p1.x, p1.y, cp1.x, cp1.y);
      line(cp2.x, cp2.y, p2.x, p2.y);
      noStroke();
    }
  }
}