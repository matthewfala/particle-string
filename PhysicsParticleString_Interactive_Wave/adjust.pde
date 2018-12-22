
void adjustBar(float len, float x, float y) {
  
  // Draw Bar
  rect(  x, y, len, 20);
  ellR = new PVector((watchValue / watchRange * len + x), y + 10, 0);
  ellipse(ellR.x, ellR.y, 50, 50);

  if ( mousePressed && mouseX > x && mouseX < x + len && (PVector.dist(new PVector(mouseX, mouseY), ellR) < 100)) {
     watchValue = (mouseX - x )/ len * watchRange;
  } 
  textSize(30);
  text("Frequency: " + watchValue + " Hz" , x, y + 80 );
  text("Time: " + t + " s", x, y+ 120 );
}