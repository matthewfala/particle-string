// Physics Particle String //

void setup()
{
  size(2400, 1500);
  stroke(0,0,0);
  fill(0,0,0);
  
  background( 230,230,230);
  
  // particles
  for ( int i = 0; i < chain.length; i++ ) 
  {
     chain[i] = new particle(  4 * stringLen * i / (chain.length-1), scrHeight /2 , scrHeight, color(0,0,0));
  }
  //chain[chain.length-1].m = .1;
  
   PFont bigJohn;
   bigJohn = loadFont("BigJohn-48.vlw");
   textFont(bigJohn);
   textSize(90);
 
  // frame
  frameRate(1/dt);
}

// Adjust bar variables
float watchRange = 5;
float watchValue = 0;
PVector watchOffset, ellR, mouseR;

void draw()
{
  // clear
  background(230,230,230);
  stroke(0,0,0);
  fill(0,0,0);
  rect(10,10, pixelspermeter, pixelspermeter);
  
  adjustBar(width/2, width/4, 50);
  updateChain();
  pullChain();
  textOverlay();
  
  // Modifications
  // Oscillate
  chain[chain.length-1].r.y = sin(t * 2 * PI * watchValue ) + scrHeight/2;
  t = (t + dt );
  
}

void textOverlay() {
 text("STANDING WAVE",  width/2 - 410, height - 80);
}
void adjustBar(float len, float x, float y) {
  
  // Draw Bar
  rect(  x, y, len, 20);
  ellR = new PVector((watchValue / watchRange * len + x), y + 10, 0);
  ellipse(ellR.x, ellR.y, 50, 50);

  if ( mousePressed && mouseX > x && mouseX < x + len && (PVector.dist(new PVector(mouseX, mouseY), ellR) < 100)) {
     watchValue = (mouseX - x )/ len * watchRange;
  } 
}

void updateChain()
{
  // first link
  chain[0].render();
  
  // middle links
  for (int i = 1; i<chain.length-1; i++)
  //for (int i = chain.length-2 ; i > 0; i--)
  {
    //// println("updating particle" + i );
    neighborlist2[0] = chain[i-1];
    neighborlist2[1] = chain[i+1];
    chain[i].update(neighborlist2);
    chain[i].render();
  }
  
  // last link
  //neighborlist1[0] = chain[chain.length - 2];
  //chain[(chain.length - 1)].update(neighborlist1);
  chain[(chain.length - 1)].render(); 
}