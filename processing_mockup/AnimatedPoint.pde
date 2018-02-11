class AnimatedPoint {
  ArrayList keyframes;
  Boolean selected;

  AnimatedPoint(PVector p) {
    keyframes = new ArrayList();

    // initalize to a null set
    for (int i=0; i< micrographs.size(); i++) {
      keyframes.add(null);
    }
    keyframes.set(current_frame_number, p);
  }

  int find_prev_index(int frame) {
    println("Finding prev value...");
    int pointer = frame;
    PVector value = (PVector)(keyframes).get(pointer);
    while (value == null) {
      pointer -= 1;
      if (pointer < 0) {
        println("\tdidn't find anything!");
        return -1;
      }
      value = (PVector)(keyframes).get(pointer);
    }
    println("\twe got one on frame " + pointer);
    return pointer;
  }

  int find_next_index(int frame) {
    println("Finding next value...");
    int pointer = frame;
    PVector value = (PVector)(keyframes).get(pointer);
    while (value == null) {
      pointer += 1;
      if (pointer > micrographs.size()-1) {
        println("\tdidn't find anything!");
        return -1;
      }
      value = (PVector)(keyframes).get(pointer);
    }
    println("\twe got one on frame " + pointer);
    return pointer;
  }

  PVector calculated_position(int frame) {
    println("called to calc the value for frame: " + frame);
    PVector real_value = (PVector)keyframes.get(frame);
    if (real_value != null) {
      return real_value;
    } else {
      println("No defined value for this find -- finding nearest keyframes!");
      int prev_index = find_prev_index(frame);
      int next_index = find_next_index(frame);
      if (next_index == -1) {
        return (PVector)keyframes.get(prev_index);
      } else if (prev_index == -1) {
        return (PVector)keyframes.get(next_index);
      } else {
         PVector prev_key = (PVector)keyframes.get(prev_index);
         PVector next_key = (PVector)keyframes.get(next_index);
         return new PVector(
             lerp(prev_key.x, next_key.x, map(frame, prev_index, next_index, 0, 1)), 
             lerp(prev_key.y, next_key.y, map(frame, prev_index, next_index, 0, 1)));
      }
 
    }
  }

  void set_value_at_frame(PVector p, int frame) {
    keyframes.set(frame, p);
  }
}