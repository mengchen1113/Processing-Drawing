class Field {
  // each member is a point
  PVector[] loc;
  int dim = 1;
  
  Field(PVector[] loc) {
    this.loc = loc;  
  }  
      
  void 
  display(PVector atom0) {
    noStroke();    
    float tempShade; // based on distance from atom 0
    int n = loc.length;
    for (int i = 0; i < loc.length; i++) {
      tempShade = random(255-loc[i].dist(atom0));
      fill(tempShade);
      ellipse(loc[i].x, loc[i].y, dim, dim);
    }
  }
  
  
  // drifts toward mouse click
  void drift() {
    
    float xdiff, ydiff, magnitude;
    int gridnum = pos.length;
    
    for (int i = 0; i < gridnum; i++) { 
      xdiff = mouseX - loc[i].x;
      ydiff = mouseY - loc[i].y;
      magnitude =  sqrt(xdiff*xdiff + ydiff*ydiff);// for normalizing
      loc[i].x += 200*xdiff/magnitude;
      loc[i].y += ydiff/magnitude;
    }
  } 
  
  
}
