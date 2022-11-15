class ScreenText {
 
  int xpos;
  int ypos;
  String text;
  int fontSize;
  int align;
  
  ScreenText(int xpos, int ypos, String text, int fontSize, int align) {
   this.xpos = xpos;
   this.ypos = ypos;
   this.text = text;
   this.fontSize = fontSize;
   this.align = align;
  }
  
  public void load(Screen s) {
   for (ScreenText t: texts)
      s.texts.add(t);
  } 
    
  public void setXpos(int xpos) {
    this.xpos = xpos;
  }
  public void setYpos(int ypos) {
    this.ypos = ypos;
  }
  public void setText(String text) {
    this.text = text;
  }
  public int getAlign() {
    return align;
  }
  public int getSize() {
    return fontSize;
  }
  public int getXpos() {
    return xpos;
  }
  public int getYpos() {
    return ypos;
  }
  public String getText() {
    return text;
  }
}
