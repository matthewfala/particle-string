  
        ////////////////////////////////////////////
        //                                        //
        //                Mouse                   //
        //  Component of Physics Chain Simulation //
        //                                        //
        ////////////////////////////////////////////
        


PVector mousePos = new PVector(0,0,0);

void updateMouse() {
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
}