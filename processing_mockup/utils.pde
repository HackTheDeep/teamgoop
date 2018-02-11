ArrayList load_micrographs(var filenames) {
  ArrayList my_micrographs = new ArrayList();
  PImage img;
  // display the filenames
 if(!filenames) return;
  for (int i = 0; i < filenames.length; i++) {
    String path = filenames[i];
    if (path.endsWith(".jpeg")) {
      println("loading: " + path);
      MicroGraph micro = new MicroGraph(path);
      my_micrographs.add(micro);
    }
  }
 return my_micrographs;
}


void pppvector(String n, PVector p){
   println(n + ": (" + p.x + ", " + p.y + ")"); 
}