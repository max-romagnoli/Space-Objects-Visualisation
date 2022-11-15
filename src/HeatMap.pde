class HeatMap {
  PImage russia;
  PImage usa;
  PImage china;
  PImage france;
  PImage japan;
  PImage india;
  
  PVector pos;
  float size;
  float w;
  float h;
  
  public final static float NUM_US = 164.26;
  public final static float NUM_RU = 86.04;
  public final static float NUM_CN = 61.07;
  public final static float NUM_F = 14.13;
  public final static float NUM_J = 7.39;
  public final static float NUM_IN = 7.15;
  
  public final static float COUNTRY_WIDTH = 450;
  
  public final static float US_HEIGHT = 363;
  public final static float RU_HEIGHT = 212;
  public final static float CN_HEIGHT = 306;
  public final static float F_HEIGHT = 422;
  public final static float J_HEIGHT = 518;
  public final static float IN_HEIGHT = 490;
  
 public final float COLOR_SCALE = 1.25;

  HeatMap(float x, float y, float h) {
    russia = loadImage("russia.png");
    usa = loadImage("usa.png");
    china = loadImage("china.png");
    france = loadImage("france.png");
    japan = loadImage("japan.png");
    india = loadImage("india.png");
    pos = new PVector(x, y);
    this.h = h;
    w = 3*h/2;
    size = h*6/5;
  }
  
  void draw() {
    push();
    strokeWeight(1); stroke(20);
    fill(170, 170, 170);
    rectMode(CENTER);
    rect(pos.x, pos.y, w, h);
    
    
    noStroke(); fill(0, 0, 255-(COLOR_SCALE*NUM_US));
    rect(pos.x-w/3, pos.y-h/4, COUNTRY_WIDTH*size/1600, US_HEIGHT*size/1600);
    
    fill(0, 0, 255-(COLOR_SCALE*+NUM_RU));
    rect(pos.x, pos.y-h/4, COUNTRY_WIDTH*size/1600, RU_HEIGHT*size/1600);
    
    fill(0, 0, 255-(COLOR_SCALE*+NUM_CN));
    rect(pos.x+w/3, pos.y-h/4, COUNTRY_WIDTH*size/1600, CN_HEIGHT*size/1600);
    
    fill(0, 0, 255-(COLOR_SCALE*+NUM_F));
    rect(pos.x-w/3, pos.y+h/4, COUNTRY_WIDTH*size/1600, F_HEIGHT*size/1600);
    
    fill(0, 0, 255-(COLOR_SCALE*+NUM_J));
    rect(pos.x, pos.y+h/4, COUNTRY_WIDTH*size/1600, J_HEIGHT*size/1600);
    
    fill(0, 0, 255-(COLOR_SCALE*+NUM_J));
    rect(pos.x+w/3, pos.y+h/4, COUNTRY_WIDTH*size/1600, IN_HEIGHT*size/1600);
    
    strokeWeight(1); stroke(20); fill(180, 0, 17, 200);
   // rect(pos.x, pos.y-9*h/16, w, h/8);
    
    imageMode(CENTER);
    image(usa, pos.x-w/3, pos.y-h/4, COUNTRY_WIDTH*size/1500, US_HEIGHT*size/1500);
    image(russia, pos.x, pos.y-h/4, COUNTRY_WIDTH*size/1500, RU_HEIGHT*size/1500);
    image(china, pos.x+w/3, pos.y-h/4, COUNTRY_WIDTH*size/1500, CN_HEIGHT*size/1500);
    image(france, pos.x-w/3, pos.y+h/4, COUNTRY_WIDTH*size/1500, F_HEIGHT*size/1500);
    image(japan, pos.x, pos.y+h/4, COUNTRY_WIDTH*size/1500, J_HEIGHT*size/1500);
    image(india, pos.x+w/3, pos.y+h/4, COUNTRY_WIDTH*size/1500, IN_HEIGHT*size/1500);
    noStroke();
    fill(67,117,140,100);
    rect(pos.x,pos.y,w,h);
    pop();
  }
  
  
}
