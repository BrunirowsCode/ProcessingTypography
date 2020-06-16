class Particle
{
  PVector pos;
  PVector initPos;
  color col;
  int randValue;
  
  Particle(PVector pos)
  {
    this.pos = pos;
    initPos = new PVector(pos.x, pos.y);
    col = color(0);
    randValue = (int)random(0,360);
  }
  void draw()
  {
    pushMatrix();
    translate(pos.x, pos.y);
    fill(col);
    text(fxos[(int)random(0,4)], 0, 0);
    popMatrix();
  }
  
  void update()
  {
    pos.y = initPos.y + sin(radians(frameCount + randValue) * 10) * 50;
  }
}
