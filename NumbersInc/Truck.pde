class Truck {
  int n, c;
  PImage img;
  float x, y, w, h;
  float vx;
  color[] cols = {color(0), color(250, 0, 0), color(0, 250, 0), color(0, 0, 250), color(200, 0, 250), color(0)};

  Truck(float _x, float _y, float _w, float _h, float _vx) {
    img = loadImage("truck.png");
    x = _x;
    y = _y;
    w = _w;
    h = _h;
    vx = _vx;
    reset();
  }

  void update() {
    if (width < x) reset();
    x += vx;
  }

  void display() {
    image(img, x, y, w, h);
    fill(cols[c]);
    textSize(h / 2);
    textAlign(LEFT, BASELINE);
    if (scn != 4) text(n, x + w / 8, y + h / 2);
  }

  void reset() {
    if (width < x) x = -w;
    n = 0;
    switch (scn) {
    case 1:
      n = int(random(2, 10));
      break;
    case 5:
      n = int(random(2, step.n + 1)) * int(random(2, 10));
      break;
    default:
      n = 0;
      break;
    }
    switch (mode.n) {
    case 1:
      c = int(random(6));
      break;
    case 2:
      if (isPrime(n)) {
        c =  int(random(1, 5));
      } else {
        c = 0;
      }
      break;
    default:
      c = 0;
      break;
    }
  }
  
  boolean isPrime(int n) {
    for (int i = 2; i < n; i++) {
      if (n % i == 0) {
        return false;
      }
    }
    return true;
  }
}
