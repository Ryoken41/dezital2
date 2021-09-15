class Buttun1 {
  int cnt = 0;
  float w, h;
  boolean press = false;
  String s;
  color[] cols = {color(0), color(250)};

  Buttun1(String _s, color _col, float _h) {
    s = _s;
    cols[0] = _col;
    h = _h;
    textSize(h / 2);
    w = textWidth("  " + s + "  ");
  }

  void update() {
    if (press) {
      cnt++;
      if (6 < cnt) {
        cnt = 0;
        press = false;
        effect();
      }
    }
  }

  void output(float x, float y) {
    noStroke();
    fill(cols[cnt%2]);
    rectMode(CENTER);
    rect(x, y, w, h);
    fill(0);
    textSize(h / 2);
    textAlign(CENTER, CENTER);
    text(s, x, y);
  }

  void press(float x, float y) {
    press = isIn(mouseX, mouseY, x - w / 2, y - h / 2, w, h);
  }

  void effect() {
    //override
  }
}

class BackB extends Buttun1 {
  BackB(String _msg, color _col, float _h) {
    super(_msg, _col, _h);
  }
  void effect() {
    switch (scn) {
    case 1: //タイトル
      scn = 0; //ゲームをやめる
      break;
    default: //その他
      scn = 1; //タイトルに戻る
      break;
    }
  }
}

class SceneB extends Buttun1 {
  int n;
  SceneB(String _msg, color _col, float _h, int _n) {
    super(_msg, _col, _h);
    n = _n;
  }
  void effect() {
    scn = n; //シーンをnにする
    if (scn == 3) game = new Game(step.n, quota.n, time.n, num.n, speed.n, mode.n);
  }
}
