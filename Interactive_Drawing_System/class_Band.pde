class Band {
  // each member is a point
  PVector[] pos;
  int dim = 0;
  float und = 20; 
  
  Band(PVector[] pos) {
    this.pos = pos;
  }
  
  // drifts toward mouse click
  void drift() {
    
    float xdiff, ydiff, magnitude;
    
    for (int i = 0; i < numAtoms; i++) { 
      xdiff = mouseX - pos[i].x;
      ydiff = mouseY - pos[i].y;
      magnitude =  sqrt(xdiff*xdiff + ydiff*ydiff);// for normalizing
      pos[i].x += 10*xdiff/magnitude;
      pos[i].y += 20*ydiff/magnitude;
    }
  } 
    
  void display(Field field) {
    stroke(0);
    fill(255);
    int bandleng = pos.length;
    int fieldsize = field.loc.length;
    float absdist;  
    
    for (int i = 0; i < bandleng; i++) { 
      // checks distance btwn all pts of band and all pts on grid
      for (int j = 0; j < fieldsize; j++) {
        absdist = abs(band.pos[i].dist(field.loc[j]));
        if (absdist < 50 && absdist > 25){
          stroke(color(band.pos[i].x,band.pos[i].y,random(0,255), absdist)); 
          strokeWeight(exp(-absdist));
          line(band.pos[i].x, band.pos[i].y, field.loc[j].x, field.loc[j].y);
        }
      }
      
      noFill();
      noStroke();
      // draws band 
      ellipse(pos[i].x, pos[i].y, dim, dim);
      
      if (i > 0) {
        line(pos[i-1].x, pos[i-1].y, pos[i].x, pos[i].y);
      }
    }
  }
  
  
  
  
  /* changes period and amplitude of band- then moves it
   */
  void moveBand() {

     float a = .2; // period = 2_PI/a
     float amp = 20; // amplitude of wave
     float Xt = 20; // initial coords of band
     float Yt = 200;  
     
     int n = pos.length; 
        
     for (int i = 0; i < n; i++) { // parametrize a curve
     
       und = sin(i/5);
       
       pos[i].x += und+5; // change parametrization
       if (pos[i].x > width) { // wrap around screen
         pos[i].x = 0;
       }
      
       if( pos[i].y > height*7/8 ) {
         pos[i].y = height/5;
       } else
       if ( pos[i].y < height/8 ) {
         pos[i].y = height/3;
       } else {
         pos[i].y += und*sin(a*i); // translate and scale amplitude
       }
       
       print("x,y: "+ pos[i].x + "," + pos[i].y);
     }
  }
  
  
}

