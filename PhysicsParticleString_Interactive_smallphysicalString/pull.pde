  
        ////////////////////////////////////////////
        //                                        //
        //                Pull                    //
        //  Component of Physics Chain Simulation //
        //                                        //
        ////////////////////////////////////////////


int mouseStatus = 0;
// mouseStatus 0 - not clicked
//             1 - moment clicked
//             2 - held
//             3 - mouse held nothing selected

// variables
float minDist;
int minI, selectedParticle;
PVector offset;
PVector mousePos = new PVector(0,0,0);
float threshold = 10;

void pullChain()
{
  // Update mouseStatus
  mousePos.x = mouseX / pixelspermeter;
  mousePos.y = scrHeight - mouseY / pixelspermeter;
  
  println("mouse = " + mousePos );
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
      // print("Particle Selected: " + selectedParticle );
     }
     else {
       mouseStatus = 3;
       //print("Particle Not Selected");
     }
   }
   
   // MOUSE HELD
   else if ( mouseStatus == 2 ) {
     chain[selectedParticle].r = PVector.add(mousePos, offset);
   }
     
   
}