/* draws a band of points that can shift based on mouse location
 */
 
import processing.pdf.*;
 
/**** BAND parameters ****/ 
Band band;
PVector[] pos; // coordinate for band
int numAtoms = 300; // # points in band

/**** FIELD parameters ****/
 Field field;
 PVector[] loc;
 int gridDist = 20;
 
/*** PDF File No ***/
 int IMGNO = 0;

void setup() {
   size(1000, 700);
   frameRate(30);   
   background(0); 
   fill(255);
   
   /***initialize field***/
   float ptX = 20;
   float ptY = 20;
   int rows = floor( width/gridDist);
   int cols = floor( height/gridDist);
   int numPoints = rows*cols;  
   int index = 0; 
   
   loc = new PVector[numPoints];
   
   for (int i=0; i< rows; i++) { 
       loc[index] = new PVector(ptX, ptY);
       print("index "+i+"i: " +index);
       print("\n");
       index++;
       ptX += random(gridDist-15, gridDist+15);
       if (ptX > width) {
         ptX = random(gridDist-15, gridDist+15);
       }    
     for (int j=0; j < cols-1; j++) {
       loc[index] = new PVector(ptX, ptY); // <-- assigns coordinates       
       print("index "+j+"j: " +index);
       index++;
       ptY += random(gridDist-15, gridDist+15);
       if (ptY > height){
         ptY = random(gridDist-15, gridDist+15);
       }
     }
   } 
   field = new Field(loc);

   /***initialize band***/
   float Xt = 20; // initial coords of band
   float Yt = 200; // initial coords of band
   float a = .2; // period = 2_PI/a
   float amp = 20; // amplitude of wave
   
   pos = new PVector[numAtoms];
   print(pos.length);
    
   for (int i = 0; i < numAtoms; i++) { // parametrize a curve
     Xt += 10; // change parametrization
     Yt += amp*sin(a*i);
     pos[i] = new PVector(Xt, Yt);
     print("index: "+i+"coords" + Xt + "," + Yt);
   }
   band = new Band(pos);
}

void draw() {
  beginRecord(PDF, "Drawing"+ IMGNO + ".pdf"); 
  background(0); 
  band.moveBand(); // takes key input and undulates
  if (mousePressed) {
    band.drift();
    field.drift();
  }
  band.display(field);
  if (frameCount > 50) {
     field.display(pos[0]);
  }
 }
 
 void mouseDragged() {
   stroke(255); 
 }
 
 
 // saves pdf
 void keyPressed() {
   if (key == 'c') {
     endRecord();
     IMGNO++;
   }
   
   if (key == 'q') {
     exit();
   }
  
 }
 
