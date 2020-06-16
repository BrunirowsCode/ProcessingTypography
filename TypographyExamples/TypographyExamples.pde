import processing.video.*;

int actualCamera= 0;
Particle[] particles;
Capture cam;
final int COLS = 100;
final int ROWS = 50;
final char[] fxos = {'F', 'X', 'O', 'S'};


void setup() {
  fullScreen();
  noStroke();

  particles = new Particle[COLS * ROWS];
  String[] cameras = Capture.list();
  
  float xoff = width / COLS;
  float yoff = height / ROWS;
  for(int i = 0; i < COLS * ROWS; ++i)
  {
    int col = i % COLS;
    int row = i / COLS;
    particles[i] = new Particle(new PVector(col * xoff, row * yoff));
  }
  
  if (cameras.length == 0) {
    println("There are no cameras available for capture.");
    exit();
  } else {
    println("Available cameras:");
    for (int i = 0; i < cameras.length; i++) {
      println(i);
      println(cameras[i]);
    }
    
    // The camera can be initialized directly using an 
    // element from the array returned by list():
    cam = new Capture(this, cameras[actualCamera]);
    cam.start();     
  }      
}

void draw() {
  float xmp = (float)mouseX / width;
  float ts = (xmp * 100)+1;
    textSize(ts);
  if (cam.available() == true) {
    cam.read();
  }
  image(cam, 0, 0,width, height);
  for(Particle p : particles)
  {
    p.col = get((int)p.pos.x, (int)p.pos.y);
    p.update();
  }
  background(0);
  for(Particle p : particles)
  {
    p.draw();
  }
  fill(0);
  rect(0,0,100,100);
  fill(255);
  text(actualCamera,10,50);
  
  
}

void keyPressed()
{
  if(key == 'm')
  {
    if(actualCamera < Capture.list().length - 1)
    {
      ++actualCamera;
      setup();
    }
  }else if(key == 'l')
  {
    if(actualCamera > 0)
    {
      --actualCamera;
      setup();
    }
  }
}
