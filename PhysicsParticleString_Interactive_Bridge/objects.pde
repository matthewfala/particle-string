        
                    ////////////////////////////////////////////
                    //                                        //
                    //               OBJECTS!                 //
                    //  Component of Physics Chain Simulation //
                    //                                        //
                    ////////////////////////////////////////////

class particle {
  
  // values
  float dist, screenHeight, k, m, fullM;
  PVector v, r, f, displacement, normalDisplacement, tension,vNormalized, airRes, vNormal;
  PVector fAir = new PVector(0,0,0);
  color renderColor;
  
  // initiator
  particle(float x,float y, float tempscreenHeight, color tempRenderColor) {
    v = new PVector(0, 0);
    r = new PVector(x,y);
    f = new PVector(0,0);
    
    renderColor = tempRenderColor;
    
    m = .01; // kg
    fullM = m;
    screenHeight = tempscreenHeight;
  }
  
  // draw command
  void render () {
    stroke(0,0,0);
    fill(renderColor);
    ellipse(r.x * pixelspermeter, (screenHeight - r.y )* pixelspermeter, .2 * pixelspermeter, .2 * pixelspermeter);
  }
  
  void update (particle[] neighbors) {
    // force calculations
    f.x = 0;
    f.y = 0;
        
    // Gravity
    f.add(0, -9.8*fullM);
    
    
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
    fAir.mult(-KAir * v.mag() + -KAir2 * v.mag() * v.mag() ); 
    f.add(fAir);
      
    // Update velocity and postion
    v.add(PVector.mult( PVector.div(f, fullM), dt ));
    r.add(PVector.mult(v, dt));
      
  }
}

class doc {
  PVector r;
  PVector v; 
  PVector f;
  PVector offset;
  float m = .5;
  float radius = .5;
  int stuck = 100;
  
  doc(float x, float y) {
    r = new PVector(x,y);
    v = new PVector(0,0);
    f = new PVector(0,0);
  }
  
  void update() {
    f = new PVector(0,0);
    
    // g
    f.add(0, m * -9.8);
    
    // handel collision
    if (stuck == 100) {
      for (int i = 0; i < chain.length; i++ ) {
        if (r.dist(chain[i].r) < radius) {
          chain[i].fullM = chain[i].m + m;
          offset = PVector.sub(r, chain[i].r);
          stuck = i;
          chain[stuck].v = v;
  
        }
      } 
    }
    
    if (stuck != 100) {
      r = PVector.add(chain[stuck].r, offset);
    }
    
    v.add( PVector.mult(PVector.div(f, m), dt));
    r.add( PVector.mult(v, dt) );
    
  } 
  void render() {
    image(img, r.x * pixelspermeter, (scrHeight - r.y) * pixelspermeter, .4 * pixelspermeter,.4 * pixelspermeter);
   // rect(r.x * pixelspermeter, (scrHeight - r.y) * pixelspermeter, 30,30);
  }
}