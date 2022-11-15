class Earth {   //Colm Buttimer 7/4/22 updated earth class, removed move and changed draw function + 12:30 9/4/22 added earth picture. + 12:37 12/4/22 fixed draw after
                //resolution change.
  float radius;
  color colour;
  ArrayList<Satellite> mySatellites;
  int time = millis();
  PImage pic;
  boolean deepSpace = false;
  
  Earth(PImage pic) {
   
   this.pic = pic;
   mySatellites = new ArrayList<Satellite>();
 }
 
 void draw() {
     
    image(pic, width/2 + 350,height/2 - 40);
    for(Satellite sat : mySatellites) {
     if(millis() > time + 300)
     {
     sat.makeDot(sat.getXpos(), sat.getYpos());
     time = millis();
     }
     sat.draw();
    }

 }
 
 void addSatellite(int radius, float apogee, color c, SpaceO obj) {
  Satellite sat = new Satellite(radius, apogee, c, obj);
  mySatellites.clear();
  mySatellites.add(sat);
 }
 
}

class Dot { //(dots dropped by orbitting satellite)
  
 float ypos;    //Colm Buttimer 9: 20 7/4/22 added Dot class
 float xpos;
 
 int life = 150;
 int delay = life - 10;
 
 Dot(float xpos, float ypos) {
  
   this.xpos = xpos;
   this.ypos = ypos;
 }
 
 void draw() {
    if(life >= 0 ) {
    fill(255);
    noStroke();
    ellipse(xpos, ypos, 10, 10);
    life--;
    }
 }

}

class Satellite {  //Colm Buttimer 09:20 7/4/22 updated satellite + 12:37 12/4/22 fixed sat draw positions after resolution change.
 
 static final float option1 = 90;
 static final float option2 = 140;
 static final float option3 = 190;
 
 static final int radiusOption1 = 30;
 static final int radiusOption2 = 40;
 static final int radiusOption3 = 50;
 
 int radius;
 float distance;
 float diameter;
 float orbit = HALF_PI;
 color colour;
 float orbitSpeed = 0.01;
 ArrayList<Dot> myDots;
 float xpos = 1300;
 float ypos = height/2 - 100;
 float angle;
 float apogee;
 float perigee;
 SpaceO obj;
 
 boolean see = true;
 
 
 Satellite(int diameter, float apogee, color colour, SpaceO obj) {
   
   if(diameter <= 1 ) {
     diameter = radiusOption1;
   }else if(diameter > 1 && diameter <= 2) {
      diameter = radiusOption2;
   }else {
       diameter = radiusOption3;
   }
   this.radius = diameter;
   
   this.colour = colour;
   myDots = new ArrayList<Dot>();
   
   if(apogee <= 1000) {
     apogee = option1;
   }else if(apogee > 1000 && apogee <= 3000) {
    apogee = option2; 
   }else {
    apogee = option3; 
   }
   this.apogee = apogee;
   this.perigee = apogee;
   this.obj = obj;
 }
 
 int time = millis();
  
 void draw() {  //Colm Buttimer 14:04 10/4/2022 updated satellite draw to display orbit message accurate to satellite status + 11/4/22 10:40 added flag image
                // + 15:23 11/4/2022 added shrinking satellite
                
                
   //if(apogee == option3) {
   //  push();
   //  colorMode(RGB);
   //  fill(200,0,0);
   //  rect(602, height/2, 320, 5);
   //  pop();
   //  push();
   //  fill(255,255,0);
   //  rect(width/2 , height/2 - 108, 5, 135);
   //  pop();
   //}
   
   if(obj.status().equals("C") || obj.status().equals("E") || obj.status().equals("F") || obj.status().equals("AF")) {
     //earth1.deepSpace = false;
     textAlign(RIGHT);
     textSize(25);
     text("Satellite was destroyed", 1295, 660); 
   }else if(obj.status().equals("DSO") || obj.status().equals("DSA") || obj.status().equals("DSA IN")) {
    // earth1.deepSpace = true;
     fill(colour);
     if(see) {
       ellipse(xpos++, ypos--, radius, radius);
       if(millis() > time + 100) {
       radius--;
       time = millis();
       }
       if(radius < 0 ) {
        see = false; 
       }
     }
     textSize(25);
     textAlign(RIGHT);
     text("Satellite is in deep space", 1330, 660); 
     
   }else if(obj.status().equals("R") || obj.status().equals("D") || obj.status().equals("L") || obj.status().equals("AR") || obj.status().equals("R?")) {
     //earth1.deepSpace = false;
     textAlign(RIGHT);
     textSize(25);
     text("Satellite has reentered", 1320, 660);
     image(flag, width/2 + 390, height/2 - 108);
   }
   else{
    // earth1.deepSpace = false;
     textAlign(RIGHT);
     textSize(25);
     text("Satellite is in orbit", 1295, 660);
     angle += 0.01;
     xpos = ((apogee + perigee) * cos(angle)) + width/2 + 380 ;
     ypos = perigee * sin(angle) + height/2  ;
     fill(colour);
     ellipse(xpos, ypos, radius, radius);
     drawDots(myDots);
     
     //width/2 + 350,height/2 - 40
   }
   
 }
 
 public void setApogee(float apogee) {
    if(apogee <= 1000) {
     apogee = option1;
   }else if(apogee > 1000 && apogee <= 3000) {
    apogee = option2; 
   }else {
    apogee = option3; 
   }
    this.apogee = apogee;
  }
 
 
 float getXpos() {
  return xpos; 
 }
 
 float getOrbit() {
  return orbit; 
 }
 
 float getYpos() {
  return ypos; 
 }
 
 void makeDot(float xpos, float ypos) {
   Dot dot = new Dot(xpos, ypos);
   myDots.add(dot);
 }
 
 void drawDots(ArrayList<Dot> myDots) {
   for(Dot dot : myDots) {
    dot.draw(); 
   }
 }
  
}
