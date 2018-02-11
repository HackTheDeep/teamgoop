ArrayList load_micrographs() {
  ArrayList my_micrographs = new ArrayList();
  PImage img;
  /// we'll have a look in the data folder
  java.io.File folder = new java.io.File(dataPath(""));
  String[] filenames = folder.list();
  // display the filenames
  for (int i = 0; i < filenames.length; i++) {
    String path = filenames[i];
    if (path.endsWith(".jpeg")) {
      println("loading: " + path);
      my_micrographs.add(new MicroGraph(path));
    }
  }
  return my_micrographs;
}


void pppvector(String n, PVector p) {
  if (p == null) {
    println(n + ": NULL");
  } else {
    println(n + ": (" + p.x + ", " + p.y + ")");
  }
}

int find_closest_index(PVector new_point, ArrayList this_frame_points) {
  int closest_index = -1;
  float min_distance = 100000;
  float dist;
  for (int index = 1; index < this_frame_points.size(); index++) {
    PVector a = (PVector)this_frame_points.get(index);
    PVector b = (PVector)this_frame_points.get(index-1);
    PVector midpoint = (a.add(b)).div(2);
    fill(255, 0, 0);
    ellipse(midpoint.x, midpoint.y, 8, 8);
    dist = new_point.dist(midpoint);
    println("distance to " + index + " is " + dist); 
    if (dist < min_distance) {
      println("new record!");
      closest_index = index;
      min_distance = dist;
    }
  }
  return closest_index;
}