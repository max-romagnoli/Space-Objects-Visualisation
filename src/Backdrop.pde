//dario cipani 8:05pm April 2
class Backdrop {
  PVector[] starPoints;
  float[] starRadii;
  Trail t;

  Backdrop() {
    starPoints = new PVector[250];
    starRadii = new float[250];
      for(int i=0; i<starPoints.length; i++) {
        starPoints[i] = new PVector(random(0, SCREENX), random(0, SCREENY));
        starRadii[i] = random(1.5, 5);
      }
    t = new Trail();
  }
  
  void draw() {
    
    //background(51, 0, 153);
    //background(#032538);
    background(#051e3e);
    ellipseMode(CENTER); noStroke(); 
    for(int i=0; i<starPoints.length; i++) {
      fill(random(245, 255), random(245, 255), random(200));
      float displacementX = 0;
      float displacementY = 0;
      if(random(20)<=1) {
        displacementX = random(-3.5, 3.5);
        displacementY = random(-3.5, 3.5);
      }
      ellipse(starPoints[i].x + displacementX/starRadii[i], starPoints[i].y + displacementY/starRadii[i], starRadii[i], starRadii[i]);
    }
    t.follow();
    t.draw();
  }
}

//Dario Cipani 8:05pm April 2
class Trail {
  PVector[] particlePoints;
  float[] particleVelocities;
  float[] particleRadii;
  boolean[] particleVisibility;
  
  Trail() {
    particlePoints = new PVector[200];
    particleRadii = new float[200];
    particleVelocities = new float[200];
    particleVisibility = new boolean[200];
      for(int i=0; i<particlePoints.length; i++) {
        particlePoints[i] = new PVector(mouseX, mouseY);
        particleVelocities[i] = random(16, 19); //14, 18
        particleRadii[i] = particleVelocities[i]*particleVelocities[i]/19; 
        particleVisibility[i] = false;
      }
  }
  void follow() {
    for(int i=0; i<particlePoints.length; i++) {
        if(dist(particlePoints[i].x, particlePoints[i].y, mouseX, mouseY) > 50) {
          particleVisibility[i] = true;
          PVector heading = new PVector(mouseX-particlePoints[i].x, mouseY-particlePoints[i].y);
          particlePoints[i].add(heading.normalize().mult(particleVelocities[i]));
        } else {
          particlePoints[i].x = mouseX; 
          particlePoints[i].y = mouseY;
          particleVisibility[i] = false;
        }
     }
  }
  void draw() {
    ellipseMode(CENTER); fill(random(210, 250), random(210, 255), random(100, 175));
    for(int i=0; i<particlePoints.length; i++) {
         if (particleVisibility[i])
             ellipse(particlePoints[i].x, particlePoints[i].y, particleRadii[i], particleRadii[i]);
     }
  }
  void reset() {
    for (int i=0; i<particlePoints.length; i++) {
      particlePoints[i].x = mouseX; 
      particlePoints[i].y = mouseY;
    }
  }
}
