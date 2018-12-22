// Physics Particle String //
// By Matthew Fala

doc myDoc;
void setup()
{
  size(2400, 1500);
  stroke(0,0,0);
  fill(0,0,0);
  
   img = loadImage("Doc.jpg");
  
  background( 230,230,230);
  
  // particles
  for ( int i = 0; i < chain.length; i++ ) 
  {
     chain[i] = new particle(   scrWidth * i / (chain.length-1),  scrHeight * 2 / 3, scrHeight, color(0,0,0));
  }
  
  // Doc
  
  myDoc = new doc(5, 4);
  
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

  updateMouse();
  updateChain();
  pullChain();
  textOverlay();
  
  
  // Add Doc
  
  myDoc.update();
  myDoc.render();
  // Modifications
  
  t = (t + dt );
  
}

void textOverlay() {
 text("STRING SIMULATOR",  width/2 - 410, height - 80);
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
 // neighborlist1[0] = chain[chain.length - 2];
//  chain[(chain.length - 1)].update(neighborlist1);
  chain[(chain.length - 1)].render(); 
}
