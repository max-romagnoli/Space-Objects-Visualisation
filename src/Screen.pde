final int NEXT_SCREEN = 0;
Screen previousScreen=s1;
int searchType;

class Screen {
  
  ArrayList<ScreenText> texts = new ArrayList<ScreenText>();
  Earth earth;
  ArrayList<Widget> widgets = new ArrayList<Widget>();
  color backColour;
  boolean visible = false;
  
  public Screen() {}
  
  public Screen(color _background, boolean visible) {
    backColour = _background;
    this.earth = earth1;
    this.visible = visible;
  }
  
  public void loop(float mX, float mY, float mouseDir) {
    for (Widget w:widgets) {
      w.logic(mX,mY, mouseDir);
    }
  }

  public void draw() {

    background(backColour);
            kineticBg.draw();
    for (Widget w:widgets) {
    {
      w.draw();
      w.widgetScreen=this;
    }
      
      //checkToggleLabels(w);
    }
    for (PopUp pu:searchBorders) {
       s2.widgets.remove(pu);
    }
    for (int i=0;i<searchBorders.size();i++) {
         s2.widgets.add(searchBorders.get(i));
    }
    
    for(ScreenText t: texts) {  //Colm Buttimer 11:17 11/4/2022 screen's screenText draw
      push();
      if(t.align==CENTER)
        textFont(boldFont);
      else
        textFont(lightFont);
      textSize(t.getSize());
      textAlign(t.getAlign());
      text(t.getText(), t.getXpos(), t.getYpos()); 
      pop();
    }
    if(earth != null && visible) {
    earth.draw();
    }
    if(currentScreen.equals(s1)&&isCountry)
    {
      h.draw(); 

      PopUp heatMask = new PopUp(new PVector(600, 685), new PVector(200, 150), -1, color(67,117,140,1), color(255,255,0), "");
      heatMask.clickable=false;
   //   s1.widgets.add(heatMask);
    }
  }
 /* 
  public void checkToggleLabels(Widget w) {
    if(w instanceof TextWidget && !w.equals(focus))
    {
   //   println(w.pos.x, true);
      if (w.label.equals("")) {
        w.label=w.defaultLabel;
        w.labelColour=color(150,150,150);
      }
      w.hasStroke=false;
    }
  }
*/  
  public int checkClickEvents() {
    //focus = null;
    for (Widget w:widgets) {
       //<>// //<>// //<>//
      if (w.isColliding && w.clickable()) {
        if(w instanceof TextWidget) //<>// //<>// //<>//
        { //<>// //<>// //<>// //<>//
          searchType = w.searchType;
          focus=(SearchBar)w; //<>// //<>// //<>// //<>//
          /* //<>// //<>//
          if(w.label.equals(w.defaultLabel))
          { //<>// //<>//
            w.label="";
            w.labelColour=color(255,255,255); //<>// //<>// //<>// //<>//
          }
          */ //<>// //<>// //<>// //<>// //<>// //<>//
          //w.hasStroke=true; //<>// //<>// //<>// //<>//
          //w.strokeColour=color(101,30,32,255); //<>// //<>// //<>//
        } //<>// //<>// //<>// //<>// //<>//
        return w.clicked(); //<>// //<>// //<>//
      } //<>// //<>// //<>// //<>//
    }
    return -1; //<>// //<>// //<>// //<>//
  } //<>// //<>//
  
  public void checkReleaseEvents() { //<>// //<>// //<>// //<>//
    for (Widget w:widgets) //<>// //<>// //<>//
        w.released(); //<>// //<>// //<>//
  }
   //<>// //<>// //<>// //<>// //<>// //<>//
  public void parseEvent() {           //Colm Buttimer 10:52 4/4/22 Updated switch event to rework menu and add start of S3 + + 12:37 12/4/22 changed orbit to s2  //<>// //<>// //<>// //<>// //<>//
    int event = checkClickEvents();   
    int currentScreenInd = screenInd; //<>// //<>// //<>// //<>// //<>// //<>// //<>//
    switch (event) { //<>// //<>// //<>// //<>//
      case STATS_SCREEN:
        screenInd = SCREEN1_IND; //<>// //<>// //<>// //<>//
        break; //<>// //<>// //<>// //<>//
      case OBJECTS_SCREEN:
        screenInd = SCREEN2_IND; //<>// //<>//
        break; //<>// //<>// //<>//
      case BACK_BUTTON: //<>// //<>// //<>// //<>// //<>//
        //currentScreen = previousScreen;
        int ind=0; //<>// //<>// //<>//
        for (int i=0;i<screens.size();i++) //<>// //<>// //<>// //<>//
          if (screens.get(i)==previousScreen) {ind=i;}
        screenInd = ind; //<>// //<>// //<>//
        break;
      case TEXT_WIDGET_SEARCH:
        if(isYears)
        {
          println(isYears);
          searchSystem.sortYears();
        }
        else
        {
          focus=null; //<>// //<>// //<>//
          if(currentScreen==s1)
            s1List.sortList(searchType); //<>// //<>//
          else //<>// //<>//
            objList.sortList(searchType);
          //maxPageNumber = (int) Math.floor(sortedSpaceObjects.size() * 50);
        }
        break; //<>// //<>//
      case SHOW_LIST:
        displayMode=LIST_MODE;
        loadList();
        break;
      case SHOW_CHARTS: //<>//
        displayMode=CHART_MODE;
        loadCharts(); //<>// //<>//
        break; //<>//
      case UPDATE_YEAR:
        searchSystem.sortYears();
        break;
      case LIST_BACK: //-999 //<>// //<>//
        if(s2PageNumber!=0) //<>// //<>// //<>//
        {
          try { //<>//
          println("backward"); //<>//
          s2PageNumber--; //<>//
          pageNumber.updateLabel(s2PageNumber+1 +"/"+(maxPageNumber+1));
          objList.unLoad(s2);
          objList.getLabels(sortedSpaceObjects, s2, sb1); //<>//
          int objInd = 50 * s2PageNumber;
          setDisplayObjByInd(objInd);
          objList.init(); //<>//
          for(int i = 0; i < 50 ; i++) { //<>//
              objList.getWidget(i).setEvent(sortedSpaceObjects.get(s2PageNumber * 50 +i).satcat() + OBJECT_DISPLAY_OFFSET);    //<>//
          } //<>//
          objList.load(s2); //<>//
           //<>// //<>//
          } catch (Exception e) {
           
          } //<>//
        }
        break;
      case LIST_FORW: //-998             Colm Buttimer 17:31 12/4/22 implemented object list buttons //<>//
        if(s2PageNumber<sortedSpaceObjects.size()/50 )
        {
           //<>//
		//try {
          println("forward");
          s2PageNumber++;
          pageNumber.updateLabel(s2PageNumber+1 +"/"+(maxPageNumber+1));
          objList.unLoad(s2);
          objList.getLabels(sortedSpaceObjects, s2, sb1);
          //sb1.init();
          
          int objInd = 50 * s2PageNumber;
          setDisplayObjByInd(objInd);
                  
          objList.init();
          int cap = min(objList.widgets.size(),50);
          for(int i = 0; i < cap ; i++) {
              objList.getWidget(i).setEvent(sortedSpaceObjects.get(s2PageNumber * 50 +i).satcat() + OBJECT_DISPLAY_OFFSET);   
          }
          objList.load(s2);
                   
          //}
          //catch (Exception e) {
           
          //}
          
        }
        break;
      default:
        if(event >= SORTED_OBJECT_DISPLAY_OFFSET) {
         //process object display on sorted list 
         screenInd = SCREEN2_IND;
         int objIndex = event - SORTED_OBJECT_DISPLAY_OFFSET;
         setDisplayObjByInd(objIndex);  //setting display object 
        } else if(event > OBJECT_DISPLAY_OFFSET) {
         //process object display 
         screenInd = SCREEN2_IND;
         int objId = event - OBJECT_DISPLAY_OFFSET;
         setDisplayObjById(objId);  //setting display object 
        }
        break;
    }
    if(currentScreenInd != screenInd) {
      previousScreen = currentScreen;
      currentScreen = screens.get(screenInd);
    }
    
    //Sample code for queries
    if (event<=-9&&event>=-14) {
      setCharts(event);
    }
    
  }
  
  public void loadList() {
        if(!s1List.loaded)
        {
          s1Chart.unLoad(s1);
         // objList.pos.y-=800;
        //  s1VBar.init();
         // s1VBar.load(s1);
         // s1List.init();
          //s1List.getLabels(s1SortedObjects, s1, s1VBar);
          //s1List.loaded=true;
          //s1Chart.loaded=false;
        //  s1VBar.isRender=false;
        }
        
  }
  
  public void loadCharts() {
        if(!s1Chart.loaded)
        {
          s1List.unLoad(s1);
          s1Chart.init();
          s1Chart.load(s1);
          s1Chart.loaded=true;
          s1List.loaded=false;
        }
  }
/*  
  public void restoreList() {
    objList.unLoad(s1);
    objList.pos.x-=800;
    objList.init();
    objList.load(s2);
    removeWidget(sb1.widgets);
    sb1.pos.x-=800;
    sb1.init();
    sb1.load(s2);
  }
*/  
  public void removeWidget(ArrayList<Widget> widgetsToRemove)
  {
    for(Widget w : widgetsToRemove)
      widgets.remove(w);
  }
  
  public Widget getWidgetById(int id) {
    Widget returnWidget = null;
    for(Widget w : widgets) {
      if (w.getWidgetID() == id) {
       returnWidget = w;
       break;
      }
    }
    return returnWidget;
  }
}
