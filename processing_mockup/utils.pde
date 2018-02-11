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


void pppvector(String n, PVector p){
   println(n + ": (" + p.x + ", " + p.y + ")"); 
}