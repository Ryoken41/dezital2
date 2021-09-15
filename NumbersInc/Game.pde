class Game {
  int m, n;
  int x, y, w, h, k = 10;
  int speed, step, quota, time, num, mode;
  float q = 0, t;

  int[] nums = new int[10];
  Number[] number = new Number[80];

  Game(int _step, int _quota, int _time, int _num, int _speed, int _mode) {
    step = _step;
    quota = _quota;
    t = time = _time;
    num = _num;
    speed = _speed;
    mode = _mode;
    for (int i = 0; i < num; i++) {
      number[i] = new Number(true);
    }
    for (int i = num; i < 2 * num; i++) {
      number[i] = new Number(false);
    }
    reset();
  }

  void update() {
    if (t < 0) scn = 4;
    if (quota < q) scn = 5;
    for (int i = 0; i < 2 * num; i++) {
      number[i].update();
    }
    t -= 0.01;
  }

  void display() {
    gauge();
    info();
    for (int i = 0; i < 2 * num; i++) {
      number[i].display();
    }
    mouse();
  }

  void press() {
    x = mouseX;
    y = mouseY;
  }

  void release() {
    w = abs(mouseX - x);
    h = abs(mouseY - y);
    if (mouseX < x) x = mouseX;
    if (mouseY < y) y = mouseY;
    int cnt = 0, ans = 1;
    int[] tmps = new int[10], cols = new int[6];
    for (int i = 0; i < 2 * num; i++) {
      if (number[i].n != -1 && isIn(number[i].x, number[i].y, x, y, w, h)) {
        cnt++;
        ans *= number[i].n;
        tmps[number[i].n]++;
        cols[number[i].c]++;
        number[i].reset();
      }
    }
    if (1 < cnt) {
      if (ans == m) {
        n--;
        q += abs(k * (mouseX - x) / height) * abs(k * (mouseY - y) / height) + 1;
        for (int i = 0; i < nums.length; i++) {
          nums[i] += tmps[i];
        }
        if (n == 0) reset();
        red(true, cols[1]);
        green(true, cols[2]);
        blue(true, cols[3]);
        purple(true, cols[4]);
      } else {
        q -= abs(k * (mouseX - x) / height) * abs(k * (mouseY - y) / height) + 1;
        if (q < 0) q = 0;
        red(false, cols[1]);
        green(false, cols[2]);
        blue(false, cols[3]);
        purple(false, cols[4]);
      }
    }
  }

  void reset() {
    m = int(random(2, step + 1)) * int(random(2, 10));
    n = 10 < m ? 0 : -1;
    nums = new int[10];
    for (int i = 2; i < step + 1; i++) {
      if (m % i == 0 && m / i < 10) n++;
    }
  }

  void gauge() {
    stroke(0);
    strokeWeight(2);
    fill(250, 250, 0);
    rectMode(CORNER);
    rect(17 * width / 20, height / 20, width / 10, 9 * height / 10);
    stroke(150);
    fill(250);
    rect(87 * width / 100, height / 10, width / 50, 7 * height / 10);
    fill(250, 0, 0);
    rect(87 * width / 100, 4 * height / 5 - (7 * height * t) / (10 * time), width / 50, (7 * height * t) / (10 * time));
    stroke(150);
    fill(250);
    rect(91 * width / 100, height / 10, width / 50, 7 * height / 10);
    fill(250, 0, 0);
    rect(91 * width / 100, 4 * height / 5 - (7 * height * q) / (10 * quota), width / 50, (7 * height * q) / (10 * quota));
    fill(0);
    textSize(width / 60);
    textAlign(CORNER, CORNER);
    text("納\n期", 87 * width / 100, 17 * height / 20);
    textSize(width / 60);
    textAlign(CORNER, CORNER);
    text("ノ\nル\nマ", 91 * width / 100, 17 * height / 20);
  }

  void info() {
    String s = "  " + m + "を" + n + "個納品  ";
    noStroke();
    fill(150);
    textSize(height / 10);
    textAlign(CENTER, CENTER);
    rectMode(CENTER);
    rect(width / 2, height / 10, textWidth(s), height / 10);
    fill(0);
    textSize(height / 12);
    rect(width / 2, height / 10, textWidth(s), height / 12);
    fill(250, 0, 0);
    text(s, width / 2, height / 11);
  }

  void mouse() {
    if (mousePressed) {
      stroke(1);
      strokeWeight(1);
      noFill();
      rectMode(CORNER);
      rect(x, y, mouseX - x, mouseY - y);
      fill(100);
      textSize(height / 50);
      textAlign(CENTER, CENTER);
      text(abs(k * (mouseX - x) / height), x + (mouseX - x) / 2, y - height / 50);
      text(abs(k * (mouseY - y) / height), x - height / 50, y + (mouseY - y) / 2);
    }
  }

  void red(boolean b, int cnt) {
    if (b && 1 < cnt) {
      for (int i = num; i < 2 * num; i++) {
        do {
          number[i].n = int(random(2, step + 1));
        } while (m % number[i].n != 0);
      }
    } else if (!b && 0 < cnt) {
      for (int i = num; i < 2 * num; i++) {
        number[i].n = 0;
      }
    }
  }

  void green(boolean b, int cnt) {
    if (b && 1 < cnt) {
      t += random(time / 8, time / 4);
      if (time < t) t = time;
    } else if (!b && 0 < cnt) {
      t -= random(time / 8, time / 4);
    }
  }

  void blue(boolean b, int cnt) {
    if (b && 1 < cnt) {
      for (int i = 0; i < num; i++) {
        number[i].vx *= 0.5;
        number[i].vy *= 0.5;
      }
    } else if (!b && 0 < cnt) {
      for (int i = 0; i < num; i++) {
        number[i].vx *= 2.0;
        number[i].vy *= 2.0;
      }
    }
  }

  void purple(boolean b, int cnt) {
    if (b && 1 < cnt) { 
      for (int i = 0; i < num; i++) {
        do {
          number[i].n = int(random(2, step + 1));
        } while (m % number[i].n != 0);
      }
    } else if (!b && 0 < cnt) {
      for (int i = 0; i < num; i++) {
        if (m % number[i].n == 0) number[i].n = 0;
      }
    }
  }

  class Number {
    int n, c;
    float x, y, z;
    float vx, vy;
    boolean b;
    color[] cols = {color(0), color(250, 0, 0), color(0, 250, 0), color(0, 0, 250), color(200, 0, 250), color(0)};

    Number(boolean _b) {
      b = _b;
      reset();
    }

    void update() {
      if (n != -1) {
        if (x < -z || width + z < x || y < -z || height + z < y) {
          reset();
        }
        x += vx;
        y += vy;
      }
    }

    void display() {
      if (n != -1) {
        fill(cols[c]);
        textSize(z);
        text(n, x, y);
      }
    }

    void reset() {
      n = getNum();
      c = getCol();
      z = random(height / 20, height / 10);
      if (1 < random(2)) {
        x = random(-z, width + z);
        y = 1 < random(2) ? -z : height + z;
      } else {
        x = 1 < random(2) ? -z : width + z;
        y = random(-z, height + z);
      }
      vx = (x < width / 2 ? 1 : -1) * speed * random(0.8, 1.8) / 100;
      vy = (y < height / 2 ? 1 : -1) * speed * random(0.8, 1.8) / 100;
    }

    int getNum() {
      if (b) {
        int x;
        if (1 < random(2)) {
          do {
            x = int(random(2, step + 1));
          } while (1 < nums[x]);
        } else {
          do {
            x = int(random(2, 10));
          } while (1 < nums[x]);
        }
        return x;
      } else {
        return -1;
      }
    }

    int getCol() {
      if (b) {
        switch (mode) {
        case 1:
          return int(random(6));
        case 2:
          if (isPrime(n)) {
            return int(random(1, 5));
          } else {
            return 0;
          }
        }
        return 0;
      } else {
        return 0;
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
}
