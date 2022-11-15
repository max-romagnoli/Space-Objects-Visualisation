class ScrollBar {
  
  PVector pos,dim;
  float scale=1;
  float multiplier;
  
  ArrayList<Widget> widgets = new ArrayList();
  ArrayList<Widget> linkedWidgets=null;
  Scroller s;
  
  //Yet to be implemented or fully thought out, but maybe have an ArrayList with the widgets that are affected by the ScrollBar ?
  //ArrayList<Widget> affectedWidgets = new ArrayList();
  
  public ScrollBar(PVector _pos, PVector _dim, ArrayList<Widget> _linkedWidgets) {
    pos=_pos;
    dim=_dim;
    linkedWidgets=_linkedWidgets;
  }
  
  public void updateProportion() {
    s.setMultiplier();
  }
 
  public void init() {
    widgets.add(new ScrollArea(pos,dim,color(242,243,243),3,linkedWidgets));
    //may change linkedWidgets below to null?
    s = new Scroller(new PVector(pos.x,pos.y),new PVector(dim.x,30),new PVector(pos.y-dim.y/2,pos.y+dim.y/2),170,-100000,linkedWidgets);
    widgets.add(s);
    //multiplier = widgets.get(1).multiplier();
  }
  
  //public void load(Screen s) {
  public void load(Screen s) {
    //init();
    //umWidgets = widgets.size();
    for (Widget w:widgets) {
      //w.pos.y-=w.dim.y*w.size/2;
      s.widgets.add(w);
    }
  }
}

class ScrollArea extends RectangleWidget {
  
  //The ScrollArea PVectors pos and dim are its bounds
  //final PVector bounds;
  
  
  public ScrollArea(PVector _pos, PVector _dim, int shade, int eventType, ArrayList<Widget> _linkedWidgets) {
    super(_pos,_dim,null,color(67,117,140,150),color(0,0,0),eventType,_linkedWidgets);
    isSuppressable=false;
    clickable=false;
  }
  
  //To remove any hover effects
  public void hover(){}
  public void resetHover(){noStroke();}
}

//can be adjusted
final int MEDIUM_GREY = 130;
final int DARK_GREY = 90;
final int MINIMUM_HEIGHT = 20;

class Scroller extends RectangleWidget {
  
  boolean isDragged = false;
  //may not necessarily have to be final
  float upperY,lowerY;
  float multiplier;
  
  public Scroller(PVector _pos, PVector _dim, PVector _bounds, int shade, int eventType, ArrayList<Widget> _linkedWidgets) {
    super(_pos, _dim, null,color(101,30,32,190),color(0,0,0),eventType, _linkedWidgets);
    isSuppressable=false;
    hoverType = 2;
    //for testing
    if (linkedWidgets!=null) {
      lowerY = _bounds.x;
      upperY = _bounds.y;
      setMultiplier();
    }
    
    //println(multiplier);
    //multiplier=100;
    //Makes the height of the scroller proportional to the height of the "page"
    //30 is a random integer value that can be changed
    //fairly hacky code below, will eventually be refactored:
    
    //works for 1st test case
    //multiplier=greatestY()-upperY+lowerY;
    
  }
  
  public float getP() {return p;}
  
  public void setMultiplier() {
    multiplier=greatestY()-upperY;
    //println(greatestY(), " ", upperY, " ", multiplier);
    dim.y=(upperY-lowerY)*20/(multiplier);   
    if (multiplier<=20 && multiplier>0) dim.y=upperY-lowerY-multiplier;
    if (multiplier==0 || upperY-lowerY==0) dim.y=upperY-lowerY;
    if (dim.y<MINIMUM_HEIGHT) dim.y=MINIMUM_HEIGHT;
    dim.y+=10;
    pos.y = lowerY+dim.y/2;
    p=0;
    
  }
  
  public float greatestY() {
    float currentGreatestY=0;
    for(Widget w:linkedWidgets) {
      //functions precisely right now but padding should probably be added in the future
      if (w.pos.y+dim.y>currentGreatestY) {
        currentGreatestY=w.pos.y+w.dim.y/2;
      }
    }
    if (currentGreatestY<upperY) currentGreatestY=upperY;
    return currentGreatestY;
  }
  
  /*public void dynamicHover() {
    if (red(colour)>MEDIUM_GREY) {
      float newGrey = red(colour)*.95;
      colour = color(newGrey,newGrey,newGrey);
    }
  }
  public void resetDynamicHover() {
    if (red(colour)<red(baseColour)) {
      float newGrey = red(colour)*1.1;
      colour = color(newGrey,newGrey,newGrey);
    }
    else {
      colour=baseColour;
      dynamicHoverReset=true;
    }
    noStroke();
  }*/
  //public void staticHover(){}
  //public void staticHoverReset(){}

  public void logic(float mX, float mY, float mouseDir) {
    isColliding = collide(mX,mY);
    
    for (Widget w:linkedWidgets) {
      if (w.pos.y+dim.y/2<lowerY || w.pos.y-dim.y/2>upperY) {
        //w.clickable=false;
        //w.isRender=false;
      } else {
        //w.clickable=true;
        //w.isRender=true;
      }
    }
  
    //Add check event to ensure scroll value has to be set with screen open and within bounds
    if (mY >= lowerY && mY <= upperY){
      if (pos.y+mouseDir-dim.y/2 >= lowerY && pos.y+mouseDir+dim.y/2 <= upperY){
       //println(mouseDir);
        pos.y += mouseDir*0.3;
        for (Widget w:linkedWidgets) {
          if (w!=this) w.yOffset=p*multiplier;
        }
      }
    }
      
    if (isDragged) {
      //colour = color(DARK_GREY,DARK_GREY,DARK_GREY);
      colour = color(101-50,30-50,32-50,255);
      if (mY<lowerY+dim.y/2)
        pos.y = lowerY+dim.y/2;
      else if (mY>upperY-dim.y/2)
        pos.y = upperY-dim.y/2;
      else
        pos.y = mY;
      for (Widget w:linkedWidgets) {
        //1000 will be replaced with someValue which represents the height of the "page"
        //if (w!=this) w.pos.y=w.basePos().y-p*multiplier;
        if (w!=this) w.yOffset=p*multiplier;
      }
    }
    else
      hoverLogic(isColliding);
    //works completely as far as I can tell:
    if (upperY-dim.y-lowerY==0)
      p=0;
    else
      p = (pos.y-lowerY-dim.y/2)/(upperY-dim.y-lowerY);
    //println(isColliding);
    if (isSuppressable) suppressionLogic(isStaticSuppressed, isDynamicSuppressed);
  }
  
  public int clicked() {
    isDragged=true;
    return event;
  }
  
  public void released() {
    isDragged=false;
  }
  
}




class HorizontalScrollBar extends ScrollBar {
  
  int minValue, maxValue;
  HorizontalScroller hs;
  
  public HorizontalScrollBar(PVector _pos, PVector _dim, int minValue, int maxValue) {
    super(_pos,_dim,null);
    this.minValue = minValue;
    this.maxValue = maxValue;
  }
  
  public void init() {
    widgets.add(new ScrollArea(pos,dim,220,3,linkedWidgets));
    //may change linkedWidgets below to null?
    hs = new HorizontalScroller(new PVector(pos.x,pos.y),new PVector(dim.x,dim.y),new PVector(pos.x-dim.x/2,pos.x+dim.x/2),170,-100000,minValue,maxValue);
    widgets.add(hs);
    //multiplier = widgets.get(1).multiplier();
  }
}

class HorizontalScroller extends Scroller {
  
  float lowerX,upperX;
  int minValue,maxValue;
  
  public HorizontalScroller(PVector _pos, PVector _dim, PVector _bounds, int shade, int eventType, int minValue, int maxValue) {
    super(_pos,_dim,_bounds,shade,eventType,null);
    lowerX = _bounds.x;
    upperX = _bounds.y;
    dim.x=40;
    pos.x = lowerX+dim.x/2;
    p=0;
    this.minValue = minValue;
    this.maxValue = maxValue;
  }
  
  public void logic(float mX, float mY, float mouseDir) {
    isColliding = collide(mX,mY);
    
    /*for (Widget w:linkedWidgets) {
      if (w.pos.y+dim.y/2<lowerY || w.pos.y-dim.y/2>upperY) {
        w.clickable=false;
        w.isRender=false;
      } else {
        w.clickable=true;
        w.isRender=true;
      }
    }*/
  
    //Add check event to ensure scroll value has to be set with screen open and within bounds
    /*if (mX >= lowerX && mX <= upperX){
      if (pos.x+mouseDir-dim.x/2 >= lowerX && pos.x+mouseDir+dim.x/2 <= upperX){
       //println(mouseDir);
        pos.y += mouseDir*0.3;
        for (Widget w:linkedWidgets) {
          if (w!=this) w.yOffset=p*multiplier;
        }
      }
    }*/
      
    if (isDragged) {
      //colour = color(DARK_GREY,DARK_GREY,DARK_GREY);
      colour = color(101-50,30-50,32-50,255);
      if (mX<lowerX+dim.x/2)
        pos.x = lowerX+dim.x/2;
      else if (mX>upperX-dim.x/2)
        pos.x = upperX-dim.x/2;
      else
        pos.x = mX;
      /*for (Widget w:linkedWidgets) {
        //1000 will be replaced with someValue which represents the height of the "page"
        //if (w!=this) w.pos.y=w.basePos().y-p*multiplier;
        if (w!=this) w.yOffset=p*multiplier;
      }*/
      
      chartCap = (int) floor(this.getMappedP());
    //  println(chartCap);
    }
    else
      hoverLogic(isColliding);
    //works completely as far as I can tell:
    if (upperX-dim.x-lowerX==0)
      p=0;
    else
      p = (pos.x-lowerX-dim.x/2)/(upperX-dim.x-lowerX);
    //println(isColliding);
    if (isSuppressable) suppressionLogic(isStaticSuppressed, isDynamicSuppressed);
  }
  
  //needs refactoring
  public float getMappedP() {return (minValue+p*(maxValue-minValue));}
  public void mappedPToP(float mappedP) {p = ((mappedP-minValue)/(maxValue-minValue));}
  public void pToPos() {pos.x += ((upperX-dim.x/2)-(lowerX+dim.x/2))*p;}
  public void setPos(){}
}
