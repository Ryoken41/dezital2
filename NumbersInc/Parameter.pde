class Parameter {
  int min, n, max;
  float w, h;
  String s, t;
  
  Buttun2 up, down;

  Parameter(int _min, int _n, int _max, float _w, float _h, String _s, String _t) {
    min = _min;
    n = _n;
    max = _max;
    w = _w;
    h = _h;
    s = _s;
    t = _t;
    up = new Buttun2(2 * h / 3, color(250, 0, 0), "↑");
    down = new Buttun2(2 * h / 3, color(0, 0, 250), "↓");
  }
  
  void update() {
    up.update();
    down.update();
  }
  
  void display(float x, float y) {
    noStroke();
    fill(200);
    textSize(h / 2);
    triangle(x - w / 2, y - h / 2, x - w / 2, y + h / 2, x - w / 2 - textWidth("   "), y);
    triangle(x + w / 2, y - h / 2, x + w / 2, y + h / 2, x + w / 2 + textWidth("   "), y);
    rect(x, y, w, h);
    fill(0);
    textAlign(CENTER, CENTER);
    text(s + n + t, x, y);
    up.display(x + w / 2, y);
    down.display(x - w / 2, y);
  }
  
  void press(float x, float y) {
    if (up.press(x + w / 2, y) && n < max) n++;
    if (down.press(x - w / 2, y) && min < n) n--;
  }
}

class Mode extends Parameter {
  String[] mode = {"ノーマルモード", "ランダムモード", "素数モード"};
  Mode(int _n, int _min, int _max, float _w, float _h, String _s, String _t ) {
    super(_n, _min, _max, _w, _h, _s, _t);
  }
  void display(float x, float y) {
    noStroke();
    fill(200);
    textSize(h / 2);
    triangle(x - w / 2, y - h / 2, x - w / 2, y + h / 2, x - w / 2 - textWidth("   "), y);
    triangle(x + w / 2, y - h / 2, x + w / 2, y + h / 2, x + w / 2 + textWidth("   "), y);
    rect(x, y, w, h);
    fill(0);
    textAlign(CENTER, CENTER);
    text(mode[n], x, y);
    up.display(x + w / 2, y);
    down.display(x - w / 2, y);
  }
}
