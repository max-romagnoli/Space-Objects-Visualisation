class PopUp extends Widget {
  
  float alpha;
  float textRot=0;
  int textColour = color(255,255,255);
  
  public PopUp(PVector _pos, PVector _dim, int _event, color _colour, color _stroke, String _label) {
    super(_pos,_dim,_label,_colour,_event,null);
    alpha = alpha(baseColour);
    strokeColour = _stroke;
    isHoverable = false;
  }
  public PopUp(PVector _pos, PVector _dim, int _event, color _colour, color _stroke, color _textColour, String _label) {
    super(_pos,_dim,_label,_colour,_event,null);
    alpha = alpha(baseColour);
    strokeColour = _stroke;
    textColour = _textColour;
    isHoverable = false;
  }
  public PopUp(PVector _pos, PVector _dim, int _event, color _colour, color _stroke, String _label, float textRot) {
    super(_pos,_dim,_label,_colour,_event,null);
    alpha = alpha(baseColour);
    strokeColour = _stroke;
    isHoverable = false;
    this.textRot = textRot;
  }
  
  //public void hover(){}
  //public void resetDynamicHover(){}
  //public void resetStaticHover(){}
  
  public void logic(float mX, float mY) {
    
    if (alpha<100) {
      alpha*=1.1;
    } else {
      alpha=100;
    }
    setColour(color(red(baseColour),green(baseColour),blue(baseColour),alpha));
    pos.x=mX+dim.x/2+10;
    pos.y=mY+dim.y/2+10;
    if (pos.x+dim.x/2>SCREENX) pos.x=SCREENX-dim.x/2;
    if (pos.y+dim.y/2>SCREENY) pos.y=SCREENY-dim.y/2;
    noStroke();
  }
  
  public void draw(){
    noStroke();
    fill(colour);
    rectMode(CENTER);
    rect(pos.x,pos.y,dim.x*size,dim.y*size);
    noStroke();
    fill(red(textColour),green(textColour),blue(textColour),255);
    textAlign(CENTER,CENTER);
    if (textRot!=0) {
      pushMatrix();
      translate(pos.x, pos.y);
      rotate(radians(textRot));
      if (customTextSize!=0)textSize(size*customTextSize);
      else textSize(30*size);
      text(label,0,0-textAscent()*.0); //original: .13
      popMatrix();
    } else {
      if (customTextSize!=0)textSize(size*customTextSize);
      else textSize(30*size);
      text(label,pos.x,pos.y-textAscent()*.0); //original: .13
    }
    
  }
  
}
