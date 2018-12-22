// Physics Particle String //

void setup()
{
  size(2000, 1200);
  background( 230,230,230);
  
  // particles
  for ( int i = 0; i < chain.length; i++ ) 
  {
     chain[i] = new particle( scrWidth/2, scrHeight -2, scrHeight, color(0,0,0));
  }
  
  // frame
  frameRate(1/dt);
}

void draw()
{
  // clear
  background(230,230,230);
  
  rect(10,10, pixelspermeter, pixelspermeter);
  updateChain();
  pullChain();
  
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
  neighborlist1[0] = chain[chain.length - 2];
  chain[(chain.length - 1)].update(neighborlist1);
  chain[(chain.length - 1)].render(); 
}