//David Mockler, Started work on integrating and redeveloping the rectangle widget 21:24 18/03/2022
class RectangleWidget extends Widget{
  public RectangleWidget(PVector _pos, PVector _dim, String _label, color _colour, color _labelColour, int eventType, ArrayList<Widget> _linkedWidgets) {
    super(_pos,_dim,_label,_colour,eventType,_linkedWidgets);
    labelColour = _labelColour;
    //colour = _colour;
    //**popUpLabel is set in by the chart
    
    //hasPopUp = true;
    //linkedWidgets = _linkedWidgets;
  }
  
  public void hover() {
    dynamicHover();
    if (staticHoverReset) staticHover();
  }
  
  public void staticHover() {
    staticHoverReset = false;
  }
  public void resetStaticHover() {
    if (hasPopUp) popUp = null;
    staticHoverReset = true;
  }
  
  public void dynamicSuppress(){
    switch (hoverType) {
      case 0:
        if (alpha(colour)>100) {
          colour=color(red(colour),green(colour),blue(colour),alpha(colour)*.9);
          //isDynamicSuppressed=true;
        }
      default:
        break;
    }
  }
  public void staticSuppress(){
    //colour=color(red(200),green(200),blue(200),alpha(colour));
    //isStaticSuppressed=false;
  }
  public void dynamicDesuppress(){
    switch (hoverType) {
      case 0:
        if (alpha(colour)<255)
          colour=color(red(colour),green(colour),blue(colour),alpha(colour)*1.1);
        else {
          colour=baseColour;
          isDynamicSuppressed=false;
        }
        break;
      default:
        break;
    }
  }
  public void staticDesuppress(){
    //colour=color(red(baseColour),green(baseColour),blue(baseColour),alpha(colour));
  }
  
  public int clicked() {
    if (isCheckable) {
      if (!isChecked) {
        isChecked = true;
        for (Widget w:linkedWidgets) 
          if (w!=this)
            w.isChecked=false;
         return event;
      }
      return -1;
    }
    //may change:
    return event;
  }
}
