final color SET_KEYFRAME = color(255, 200, 255);
final color INTERPOLATED_KEYFRAME = color(100, 120, 100);

class AnimatedPoint {
  ArrayList keyframes;
  Boolean selected;

  AnimatedPoint(PVector p) {
    keyframes = new ArrayList();
    selected = false;

    // initalize to a null set
    for (int i=0; i< micrographs.size(); i++) {
      keyframes.add(null);
    }
    keyframes.set(current_frame_number, p);
  }

  int find_prev_index(int frame) {
    int pointer = frame;
    PVector value = (PVector)(keyframes).get(pointer);
    while (value == null) {
      pointer -= 1;
      if (pointer < 0) {
        return -1;
      }
      value = (PVector)(keyframes).get(pointer);
    }
    return pointer;
  }

  int find_next_index(int frame) {
    int pointer = frame;
    PVector value = (PVector)(keyframes).get(pointer);
    while (value == null) {
      pointer += 1;
      if (pointer > micrographs.size()-1) {
        return -1;
      }
      value = (PVector)(keyframes).get(pointer);
    }
    return pointer;
  }

  PVector calculated_position(int frame) {
    PVector real_value = (PVector)keyframes.get(frame);
    if (real_value != null) {
      return real_value;
    } else {
      // Find the previous and next frames that have keys (or set to -1)
      int prev_index = find_prev_index(frame);
      int next_index = find_next_index(frame);

      // if we didn't find something ahead, return the value on the previous key
      if (next_index == -1) {
        return (PVector)keyframes.get(prev_index);
        // if we didn't find something before, return the value on the next key
      } else if (prev_index == -1) {
        return (PVector)keyframes.get(next_index);

        // ellllssse interpolate between the previous and next keys to find calculated value;
      } else {
        PVector prev_key = (PVector)keyframes.get(prev_index);
        PVector next_key = (PVector)keyframes.get(next_index);
        float lerpval = map(frame, prev_index, next_index, 0, 1);
        return new PVector(
          lerp(prev_key.x, next_key.x, lerpval), 
          lerp(prev_key.y, next_key.y, lerpval));
      }
    }
  }

  void set_value_at_frame(PVector p, int frame) {
    keyframes.set(frame, p);
  }

  void draw_on_this_frame(int frame) {
    if (export) {
      return;
    }
    stroke(0);
    strokeWeight(1);
    if (keyframes.get(frame) != null) {
      fill(SET_KEYFRAME);
    } else {
      fill(INTERPOLATED_KEYFRAME);
    }
    PVector pos = calculated_position(frame);
    if (selected) {
      ellipse(pos.x, pos.y, 15, 15);
    } else {
      ellipse(pos.x, pos.y, 10, 10);
    }
  }
}