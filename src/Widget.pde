final int LIST = 1;

class Widget {
  int ID=-1;                        
  Screen widgetScreen;
  PVector pos,dim,basePos;
  boolean clickable=true;
  boolean isCheckable=false;
  boolean isChecked=false;
  boolean isSuppressable=true;
  boolean isHoverable=true;  
  boolean isColliding=false;
  int event;
  //For use with hover effects:
  boolean dynamicHoverReset = true;
  boolean staticHoverReset = true;
  boolean isDynamicSuppressed = false;
  boolean isStaticSuppressed = false;
  boolean isRender = true;
  PVector yBounds = null;  
  int hoverType=DEFAULT;
  float size=1;
  float maxSize=1.2;
  //To account for different screen dimensions:
  float scale=1;
  color colour = 255;
  int alpha=0;
  //useful for effects that change the Widgets's colour:
  final int baseColour;
  color strokeColour = color(255,255,0);
  String label;
  int numericalLabel;
  int customTextSize=0;
  int labelAlign=CENTER;
  int posMode=CENTER;
  color labelColour=255;
  //For use with dynamic hover effects e.g spwaning a popup:
  boolean hasPopUp=false;
  PopUp popUp = null;
  String popUpLabel="Sample\nText";
  float hoverTimer = 0;
  int searchType=-1;
  boolean hasStroke = false;
  //for use with ScrollBar, p represents how far along the scroller is on the scrollbar from 0 to 1
  float p;
  float yOffset=0;  
  //For use with charts etc.
  ArrayList<Widget> linkedWidgets;
  
  public Widget() {
    baseColour = 0;
  }

  public Widget(PVector _pos, PVector _dim, String _label, color _colour, int eventType, ArrayList<Widget> _linkedWidgets) {
    pos=_pos;
    dim=_dim;
    event=eventType;
    label = _label;
    colour = _colour;
    baseColour = colour;
    linkedWidgets = _linkedWidgets;
    if(pos!=null)
      basePos = new PVector(pos.x,pos.y);
  }
  
  public void updateLabel(String updatedLabel){
    label = updatedLabel;
  }
  

  public void setEvent(int newEvent) {
    this.event = newEvent;
  }

  public void setID(int id) {ID=id;}
  
  public int getWidgetID() {
   return ID; 
  }
  
  public Boolean colliding(){return isColliding;}
  
  public color getColour() {return colour;}
  public void setColour(color c) {colour = c;}
  
  public PVector basePos() {return basePos;}
  
  public boolean clickable() {return clickable;}
  
  public boolean collide(float mX, float mY) {
    if (pos.x-dim.x*size/2<mX && pos.x+dim.x*size/2>mX && pos.y-dim.y*size/2<mY && pos.y+dim.y*size/2>mY)
      return true;
    else
      return false;
  }
  
  //hover functions
  public void spawnPopUp() {
    hoverTimer+=.01;
    if (hoverTimer>.2 && popUp==null) {
      popUp = new PopUp(new PVector(mouseX+1,mouseY+1), new PVector(330,130),-1,color(100,100,0,20),color(0,0,0,0),popUpLabel);
    }
  }
  
  //below functions are for if a linked widget is being highlighted, and for restoring them if not:
  public void dynamicSuppress(){
    //println(pos.x, "dynamically being suppressed");
  }
  public void staticSuppress(){
    //println(pos.x, "statically being suppressed");
  }
  public void suppress(){
    dynamicSuppress();
    staticSuppress();
  }
  public void dynamicDesuppress(){
    //println(pos.x, "dynamically being desuppressed");
  }
  public void staticDesuppress(){
    //println(pos.x, "statically being desuppressed");
  }
  public void desuppress(){
    dynamicDesuppress();
    if (isStaticSuppressed) staticDesuppress();
  }
  
  public void suppressionLogic(boolean staticSuppressed, boolean dynamicSuppressed) {
    boolean isSomeWidgetHovering = false;
    //Fixes visual artifact to do with the order in which the widgets' logic is performed 
    if (linkedWidgets!=null) {
      for(Widget w:linkedWidgets) {
        if (w.colliding() && w!=this)
          isSomeWidgetHovering = true;
      }
    }
    if (staticSuppressed)
      staticSuppress();
    else if (!isSomeWidgetHovering)
      staticDesuppress();
    
    if (dynamicSuppressed)
      dynamicSuppress();
    else if (!isSomeWidgetHovering)
      dynamicDesuppress();
  }
  
  //default dynamicHover type: grow+outline
  public void dynamicHover() {
    if (hasPopUp) spawnPopUp();

    
    switch (hoverType) {
      case 0:
        
        if (size<maxSize)
          size*=1.05;
        strokeWeight(size*3);
        stroke(strokeColour);
        break;
      
      case 1:
        if (red(colour)>MEDIUM_GREY) {
          float newGrey = red(colour)*.95;
          colour = color(newGrey,newGrey,newGrey);
        }
        break;
      case 2:
        if (alpha(colour)<230) {
          float newAlpha = alpha(colour)*1.1;
          colour = color(red(colour),green(colour),blue(colour),newAlpha);
        }
        break;
      default:
        break;
    }
    
    dynamicHoverReset=false;
    //Deaccentuates unhighlighted linked widgets
    if (linkedWidgets!=null) {
      for (Widget w:linkedWidgets) {
        if (w!=this) w.isDynamicSuppressed=true;
        //println(w.pos.x,w.isDynamicSuppressed);
      }
        //if (w!=this) w.dynamicSuppress();
    }
  }
  //default staticHover type: change colour
  public void staticHover() {
    switch (hoverType) {
      case 0:
        colour = color(0,255,0);
        break;
      
      default:
        break;
    }
    staticHoverReset=false;
    //Deaccentuates unhighlighted linked widgets
    if (linkedWidgets!=null) {
      for (Widget w:linkedWidgets)
        if (w!=this) w.isStaticSuppressed=true;
        //if (w!=this) w.staticSuppress();
    }
  }
  public void hover() {
    dynamicHover();
    //ensures function is only called if necessary
    if (staticHoverReset) staticHover();
  }

  public void resetDynamicHover() {
    switch (hoverType) {
      case 0:
        if (size>1)
          size*=.95;
        else {
          size=1;
          dynamicHoverReset=true;
        }
        break;
      case 1:
        if (red(colour)<red(baseColour)) {
          float newGrey = red(colour)*1.1;
          colour = color(newGrey,newGrey,newGrey);
        }
        else {
          colour=baseColour;
          dynamicHoverReset=true;
        }
        noStroke();
        break;
      case 2:
        if (alpha(colour)>alpha(baseColour)) {
          //println(alpha(colour));
          float newAlpha = alpha(colour)*.95;
          colour = color(red(colour),green(colour),blue(colour),newAlpha);
        }
        else {
          colour=baseColour;
          dynamicHoverReset=true;
        }
        noStroke();
        break;
      default:
        break;
    }
        
    if (hasPopUp) hoverTimer = 0;
    //Reaccentuates linked widgets, if no Widget is highlighted
    if (linkedWidgets!=null) {
      for (Widget w:linkedWidgets)
        if (w!=this&&!dynamicHoverReset) w.isDynamicSuppressed=false;
        //if (w!=this && (dynamicHoverReset||w.isDynamicSuppressed)) w.dynamicDesuppress();
    }
    noStroke();
  }
  public void resetStaticHover() {
    switch (hoverType) {
      case 0:
        colour = baseColour;
        break;
      
      default:
        break;
    }
    staticHoverReset=true;
    if (hasPopUp) popUp = null;
    //Reaccentuates linked widgets if no Widget is highlighted
    if (linkedWidgets!=null) {
      for (Widget w:linkedWidgets)
        if (w!=this&&!staticHoverReset) w.isStaticSuppressed=false;
        //if (w!=this) w.staticDesuppress();
    }
  }
  public void resetHover() {
    resetDynamicHover();
    if (!staticHoverReset) resetStaticHover();
  }
  
  public void fade() {
    if(alpha(alpha)>100)
      color(alpha(alpha)*0.9);
    if(alpha(colour)<255)
      color(alpha(colour)*1.1);
  }
  
  public void hoverLogic(boolean colliding) {
    if (colliding)
      hover();
    else
      resetHover();
    noStroke();
  }
  
  public boolean inBounds() {
    if (yBounds==null)
      return true;
    else if (pos.y+dim.y/2>yBounds.x && pos.y-dim.y/2<yBounds.y)
      return true;
    else
      return false;
  }
  
  public void updatePos() {
    pos.y=basePos.y-yOffset;
  }
  
  public void setLabelAlign(int align) {
    labelAlign=align;
  }
  
  public float adjustAlign() {
    if(labelAlign==RIGHT)
      return dim.x/2-5;
    else if (labelAlign==LEFT)
      return -dim.x/2+5;
    else
      return 0;
  }
  
  public void setRectMode(int mode) {
    posMode=mode;
  }
  
  public void logic(float mX, float mY, float mouseDir) {
    rectMode(posMode);
    updatePos();
    isColliding = collide(mX,mY);
    if (isHoverable) hoverLogic(isColliding);
    if (isSuppressable) suppressionLogic(isStaticSuppressed, isDynamicSuppressed);
    if (!inBounds() && yBounds!=null) {
      isRender = false;
      clickable = false;
    } else if (yBounds!=null) {
      isRender=true;
      clickable = true;
    }
  }
  
  public void managePopUp() {
    if (popUp!=null) {
      popUp.logic(mouseX,mouseY);
      popUp.draw();
    }
  }
  
  public void draw() {
    if (isRender) {
      textAlign(labelAlign,CENTER);
      rectMode(posMode);
      if (isChecked)//fill(color(MEDIUM_GREY-50,MEDIUM_GREY-50,MEDIUM_GREY-50));
        fill(color(red(baseColour)-50,green(baseColour)-50,blue(baseColour)-50,255));
      else
        fill(colour);
      rect(pos.x,pos.y,dim.x*size*scale,dim.y*size*scale);
      fill(labelColour);
      setTextSize(customTextSize);
      if (label!=null) text(label,pos.x+adjustAlign(),pos.y-textAscent()*.0);
      if (hasPopUp) managePopUp();
    }
  }
  
  public void setTextSize(int textSize) {
    if(customTextSize==0)
      textSize(dim.y*size);
    else
      textSize(textSize);
  }

  public int clicked() {return event;}
  public void released() {}
 
}
