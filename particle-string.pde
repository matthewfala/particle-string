// Physics Particle String //
// constants
//float relaxDist = 10; // pixels
float scrWidth = 1000;
float scrHeight = 600;
float dt = 0.01;
particle[] neighbors = new particle[10];

void setup() {
  
  size(1000, 600);
  background( 230,230,230);
  
  for ( int i = 0; i < neighbors.length; i++ ) {
     neighbors[i] = new particle( float(width) * i/(neighbors.length-1)+ 100, float(height-20), float(height), color(255*i/(neighbors.length-1), 255*i/(neighbors.length-1),color(255*i/(neighbors.length-1)) ));
  }
  frameRate(1/dt);
}

particle[] neighborlist1 = new particle[1];
particle[] neighborlist2 = new particle[2];

void draw() {
  background(230,230,230);
  neighbors[0].render();
  for (int i = 1; i<neighbors.length-1; i++) {
    println("updating particle" + i );
    neighborlist2[0] = neighbors[i-1];
    neighborlist2[1] = neighbors[i+1];
    neighbors[i].update(neighborlist2);
    neighbors[i].render();
  }
  neighborlist1[0] = neighbors[neighbors.length - 2];
  //neighbors[(neighbors.length - 1)].update(neighborlist1);
  neighbors[(neighbors.length - 1)].render();
}

class particle {
  float relaxDist, dist, screenHeight, k, m;
  PVector v, r, f, displacement, normalDisplacement, tension,vNormalized, airRes, vNormal; 
  color renderColor;
  
  particle(float x,float y, float tempscreenHeight, color tempRenderColor) {
    v = new PVector(0, 0);
    r = new PVector(x,y);
    f = new PVector(0,0);
    renderColor = tempRenderColor;
    relaxDist = 0;
    k = 10;
    m = .2; // kg
    screenHeight = tempscreenHeight;
  }  
  void render () {
    stroke(255,255,255);
    fill(renderColor);
    //fill(0,0,0);
    println( (r.x-5) + "," + (screenHeight - r.y-5) );
     ellipse(r.x-5, screenHeight - r.y-5, 10, 10);
  }
  
  void update (particle[] neighbors) {
    // force calculations
    f.x = 0;
    f.y = 0;
        
    // gravity
    f.add(0, -9.8*m);
    
    // tensions
    
    // add neighbors
    for (int i=0; i < neighbors.length; i++) {
      dist = PVector.dist(neighbors[i].r, r);
      println("distance to neighbor " + i + " :" + dist);
      if (dist > relaxDist) {
        displacement = PVector.sub(neighbors[i].r, r);
        normalDisplacement = displacement;
        normalDisplacement.normalize();
        
        //displacement = PVector.sub(displacement, PVector.mult( normalDisplacement, relaxDist) );
        displacement = PVector.mult( normalDisplacement, (displacement.mag() - relaxDist) );
        
        tension = displacement.mult(k); 
        println(tension);
        f.add(tension);
        println("tension: " + tension);
      }
      
      println("Force on particle: " + f);
           
      
      // air resistance
      
      vNormal = new PVector();
      vNormal.x = v.x;
      vNormal.y = v.y;
      vNormal.z = v.z;
      
      vNormal.normalize();
      airRes = PVector.mult( vNormal, ( -.01 * v.mag() * v.mag()) );

      f.add( new PVector(0,0)); //airRes);

      v.add(PVector.mult( PVector.div(f, m), dt ));
      println( "moved from " + r );
      r.add(PVector.mult(v, dt));
      print( " to " + r );
      
    }
     
  }
}