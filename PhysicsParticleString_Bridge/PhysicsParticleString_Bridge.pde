// Physics Particle String //

// global measurements
float pixelspermeter = 10;
float scrWidth = 200; // meters
float scrHeight = 120; // meters
float dt = 0.01;


// constants
float stringLen; // lenght of chain
float KString = 10;
float KAir = .1;

// chain
particle[] chain = new particle[25];

// particle assets
particle[] neighborlist1 = new particle[1];
particle[] neighborlist2 = new particle[2];

void setup() {
  size(2000, 1200);
  
  // String size
  stringLen = scrWidth - 20;
  background( 230,230,230);
  
  // Particles
  for ( int i = 0; i < chain.length; i++ ) {
     chain[i] = new particle( stringLen * i/(chain.length-1) + 10, scrHeight / 2, scrHeight, color(0,0,0));
  }
  frameRate(1/dt);
}

void draw()
{
  // clear
  background(230,230,230);
  
  // first link
  chain[0].render();
  
  // middle links
  // for (int i = 1; i<chain.length-1; i++)
  for (int i = chain.length-2 ; i > 0; i--)
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

class particle {
  
  // values
  float relaxDist, dist, screenHeight, k, m;
  PVector v, r, f, displacement, normalDisplacement, tension,vNormalized, airRes, vNormal;
  PVector fAir = new PVector(0,0,0);
  color renderColor;
  
  // initiator
  particle(float x,float y, float tempscreenHeight, color tempRenderColor) {
    v = new PVector(0, 0);
    r = new PVector(x,y);
    f = new PVector(0,0);
    renderColor = tempRenderColor;
    relaxDist = stringLen / chain.length * .7;
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
    //for (int i=neighbors.length-1; i > -1; i--)
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