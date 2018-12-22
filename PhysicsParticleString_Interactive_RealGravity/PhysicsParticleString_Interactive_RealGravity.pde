// Physics Particle String //

void setup()
{
  size(2000, 1200);
  background( 230,230,230);
  
  // particles
  for ( int i = 0; i < chain.length; i++ ) 
  {
     chain[i] = new particle( scrWidth/2, scrHeight -10, scrHeight, color(0,0,0));
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

int mouseStatus = 0;
// mouseStatus 0 - not clicked
//             1 - moment clicked
//             2 - held
//             3 - mouse held nothing selected

// constants
float minDist;
int minI;
int selectedParticle;
PVector offset;
PVector mousePos = new PVector(0,0,0);
float threshold = 10;

void pullChain()
{
  // Update mouseStatus
  mousePos.x = mouseX / pixelspermeter;
  mousePos.y = scrHeight - mouseY / pixelspermeter;
  if (mousePressed)
   {
     if (mouseStatus == 0) { mouseStatus = 1; }
     else if (mouseStatus == 1) 
     {
       mouseStatus = 2;
     }
   }
   else { mouseStatus = 0; }
   
   // mouse options
   if (mouseStatus == 0) {
     
   }
   
   if (mouseStatus == 1) {
     // find closest particle
     minDist = PVector.dist(chain[0].r, mousePos);
     minI = 0;
     for ( int i = 1; i < chain.length; i++ ) {
       if ( PVector.dist(chain[i].r, mousePos) < minDist ) {
         minDist = PVector.dist(chain[i].r, mousePos);
         minI = i;
         println( "minDist = " + minDist);
       }
       println( "minDist = " + minDist);
     }
     
     // select particle if within threshold
     if ( minDist < threshold ) {
       selectedParticle = minI;
       offset = PVector.sub(chain[selectedParticle].r, mousePos);
       print("Particle Selected: " + selectedParticle );
     }
     else {
       mouseStatus = 3;
       print("Particle Not Selected");
     }
   }
   
   // MOUSE HELD
   else if ( mouseStatus == 2 ) {
     chain[selectedParticle].r = PVector.add(mousePos, offset);
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
  neighborlist1[0] = chain[chain.length - 2];
  chain[(chain.length - 1)].update(neighborlist1);
  chain[(chain.length - 1)].render(); 
}