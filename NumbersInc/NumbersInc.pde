int scn;

PImage back1, title;
PImage gear;
PImage back2, over, clear;

BackB backB;
SceneB startB, setupB;
Parameter speed, step, quota, time, num;
Mode mode;
Game game;
Truck[] trucks = new Truck[8];

void setup() {
  frameRate(30);
  size(1280, 720);
  textFont(createFont("MS Gothic", 1));
  scn = 1;
  back1 = loadImage("back1.jpeg");
  title = loadImage("title.png");
  gear = loadImage("gear.png");
  back2 = loadImage("back2.jpeg");
  over = loadImage("over.png");
  clear = loadImage("clear.png");
  backB = new BackB("戻る", color(200, 250, 250), height / 12);
  startB = new SceneB("出勤", color(150, 250, 250), height / 8, 3);
  setupB = new SceneB("設定", color(150, 250, 250), height / 8, 2);
  step = new Parameter(2, 9, 9, width / 3, height / 8, "", "の段まで");
  quota = new Parameter(1, 100, 1000, width / 3, height / 8, "ノルマまで", "pt");
  time = new Parameter(1, 100, 1000, width / 3, height / 8, "納期まで", "日");
  num = new Parameter(2, 20, 40, width / 3, height / 8, "数字", "個まで");
  speed = new Parameter(50, 100, 150, width / 3, height / 8, "数字の速度", "%");
  mode = new Mode(0, 0, 2, width / 3, height / 8, "", "");
  for (int i = 0; i < trucks.length; i++) {
    trucks[i] = new Truck(width * i / (trucks.length - 1), 5 * height / 6, width / trucks.length, height / 6, 8);
  }
}

void draw() {
  background(250);
  switch (scn) {
  case 0:
    exit();
    break;
  case 1: //スタート
    image(back1, 0, 0, width, height);
    image(title, width / 2 - width / 4, height / 3, width / 2, height / 6);
    for (int i = 0; i < trucks.length; i++) {
      trucks[i].update();
      trucks[i].display();
    }
    startB.update();
    startB.output(width / 2, 2 * height / 3);
    setupB.update();
    setupB.output(width / 2, 5 * height / 6);
    break;
  case 2: //設定
    //image(gear, 0, 0, width, height);
    step.update();
    step.display(width / 2, height / 7);
    quota.update();
    quota.display(width / 2, 2 * height / 7);
    time.update();
    time.display(width / 2, 3 * height / 7);
    num.update();
    num.display(width / 2, 4 * height / 7);
    speed.update();
    speed.display(width / 2, 5 * height / 7);
    mode.update();
    mode.display(width / 2, 6 * height / 7);
    break;
  case 3: //ゲーム
    //image(gear, 0, 0, width, height);
    game.update();
    game.display();
    break;
  case 4: //ゲームオーバー
    image(back2, 0, 0, width, height);
    image(over, width / 2 - width / 4, height / 3, width / 2, height / 6);
    for (int i = 0; i < trucks.length; i++) {
      trucks[i].update();
      trucks[i].display();
    }
    break;
  case 5: //ゲームクリア
    image(back2, 0, 0, width, height);
    image(clear, width / 2 - width / 4, height / 3, width / 2, height / 6);
    for (int i = 0; i < trucks.length; i++) {
      trucks[i].update();
      trucks[i].display();
    }
    break;
  }
  backB.update();
  backB.output(width / 9, 8 * height / 9);
}

void mousePressed() {
  switch (scn) {
  case 0:
    exit();
    break;
  case 1: //スタート
    startB.press(width / 2, 2 * height / 3);
    setupB.press(width / 2, 5 * height / 6);
    break;
  case 2: //設定
    step.press(width / 2, height / 7);
    quota.press(width / 2, 2 * height / 7);
    time.press(width / 2, 3 * height / 7);
    num.press(width / 2, 4 * height / 7);
    speed.press(width / 2, 5 * height / 7);
    mode.press(width / 2, 6 * height / 7);
    break;
  case 3: //ゲーム
    game.press();
    break;
  case 4: //ゲームオーバー
    break;
  case 5: //ゲームクリア
    break;
  }
  backB.press(width / 9, 8 * height / 9);
}

void mouseReleased() {
  switch (scn) {
  case 3: //ゲーム
    game.release();
    break;
  }
}

boolean isIn(float xx, float yy, float x, float y, float w, float h) {
  if (x < xx && xx < x + w && y < yy && yy < y + h) {
    return true;
  } else {
    return false;
  }
}
