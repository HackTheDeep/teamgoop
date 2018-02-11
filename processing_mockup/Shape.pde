// TODO
// Pick shape color somehow... https://forum.processing.org/one/topic/processing-color-picker.html
// Set name
// 
// choose type of shape!
// draw with onion skinning!

final int HANDLE_SIZE = 5;
final color HANDLE_COLOR = color(0, 0, 255);

class Shape {
  ArrayList points;
  color mycolor;
  int id;

  Shape(int id) {
    points = new ArrayList();
    mycolor = color(0, 255, 0);
    this.id = id;
  }

  void add_point(PVector p) {
    points.add(p);
  }

  void draw(int opacity) {
    PVector p, prev, cp1, cp2;

    // First, draw points
    stroke(0, opacity);
    strokeWeight(1);
    fill(mycolor, opacity);
    for (int i=0; i < points.size(); i++) {
      p = (PVector)points.get(i);
      ellipse(p.x, p.y, 10, 10);
    }

    // If we have at least 3 points, draw curves
    float sum_x = 0;
    float sum_y = 0;
    if (points.size() > 3) {
      sum_x += ((PVector)points.get(0)).x;
      sum_y += ((PVector)points.get(0)).y;
      for (int i=1; i < points.size(); i++) {
        draw_bezier(i-1, i, opacity);
        sum_x += ((PVector)points.get(i)).x;
        sum_y += ((PVector)points.get(i)).y;
      }
      draw_bezier(points.size() - 1, 0, opacity);

    // Draw the centroid!
    fill(128, 0, 0, opacity);
    ellipse(sum_x /= points.size(), sum_y /= points.size(), 20, 20);
    }


  }

  void draw_bezier(int p1_index, int p2_index, int opacity) {

    // find the previous and next points...
    int p0_index = p1_index - 1;
    if (p0_index < 0) p0_index = points.size() - 1;
    int p3_index = (p2_index + 1) % points.size();


    PVector p0 = (PVector)points.get(p0_index);
    PVector p1 = (PVector)points.get(p1_index);
    PVector p2 = (PVector)points.get(p2_index);
    PVector p3 = (PVector)points.get(p3_index);

    PVector p1_tan = new PVector(p2.x - p0.x, p2.y - p0.y);
    PVector p2_tan = new PVector(p3.x - p1.x, p3.y - p1.y);
    p1_tan.normalize();
    p2_tan.normalize();

    float handle_length = PVector.dist(p1, p2) / 4;

    PVector cp1 = new PVector(p1.x + handle_length*p1_tan.x, p1.y + handle_length*p1_tan.y);
    PVector cp2 = new PVector(p2.x - handle_length*p2_tan.x, p2.y - handle_length*p2_tan.y);

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