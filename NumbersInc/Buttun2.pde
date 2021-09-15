class Buttun2 {
  int cnt;
  float z;
  color[] cols = {color(250), color(250)};
  String s;

  Buttun2(float _z, color _col, String _s) {
    z = _z;
    cols[0] = _col;
    s = _s;
  }

  void update() {
    if (0 < cnt) {
      cnt--;
    }
  }

  void display(float x, float y) {
    fill(cols[cnt%2]);
    textSize(z);
    textAlign(CENTER, CENTER);
    text(s, x, y);
  }

  boolean press(float x, float y) {
    textSize(z);
    if(isIn(mouseX, mouseY, x - textWidth(s) / 2, y - z / 2, textWidth(s), z)) {
      cnt = 3;
      return true;
    } else {
      return false;
    }
  }
}
