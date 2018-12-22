        
                    ////////////////////////////////////////////
                    //                                        //
                    //               OBJECTS!                 //
                    //  Component of Physics Chain Simulation //
                    //                                        //
                    ////////////////////////////////////////////

class particle {
  
  // values
  float dist, screenHeight, k, m;
  PVector v, r, f, displacement, normalDisplacement, tension,vNormalized, airRes, vNormal;
  PVector fAir = new PVector(0,0,0);
  color renderColor;
  
  // initiator
  particle(float x,float y, float tempscreenHeight, color tempRenderColor) {
    v = new PVector(0, 0);
    r = new PVector(x,y);
    f = new PVector(0,0);
    renderColor = tempRenderColor;
    
    m = .1; // kg
    screenHeight = tempscreenHeight;
  }
  
  // draw command
  void render () {
    stroke(255,255,255);
    fill(renderColor);
    ellipse((r.x-3) * pixelspermeter, (screenHeight - r.y-3) * pixelspermeter, 60, 60);
  }
  
  void update (particle[] neighbors) {
    // force calculations
    f.x = 0;
    f.y = 0;
        
    // Gravity
    f.add(0, -9.8*m);
    
    // Neighbors
    for (int i=0; i < neighbors.length; i++)
    {
      dist = PVector.dist(neighbors[i].r, r);
      if (dist > relaxDist) {
        displacement = PVector.sub(neighbors[i].r, r);
        normalDisplacement = displacement;
        normalDisplacement.normalize();
        tension = PVector.mult( normalDisplacement, (dist - relaxDist) * KString );
        f.add(tension);
      }
    }
      
    // Air
    fAir.x = v.x;
    fAir.y = v.y;
    fAir.z = v.z;
    fAir.normalize();
    fAir.mult(-KAir * v.mag()); 
    f.add(fAir);
      
    // Update velocity and postion
    v.add(PVector.mult( PVector.div(f, m), dt ));
    r.add(PVector.mult(v, dt));
      
  }
}