// Project by Colm Buttimer, Massimiliano Romagnoli, David Mockler, Liam Malone, Dario Cipani

Table dataset;
String lines [];
PFont font; PFont lightFont; PFont boldFont;
float mouseDir;
ArrayList<Screen> screens = new ArrayList();
ArrayList<Widget> widgets = new ArrayList();
Map<String, Integer> widgetMap = new HashMap<String, Integer>();
ArrayList<Integer> events; 
ArrayList<String> labels; 
public String osType;
Screen s1,s2,s3,currentScreen;
SearchBarEnvironment searchSystem;
SearchBar fromBar, toBar, fromYearBar, toYearBar, countryBar, focus, objSearch, minBar, maxBar;
Chart barChart,barChart2,barChart3;
PieWidget pw;
Backdrop kineticBg = new Backdrop();

void settings() {             
  size(SCREENX,SCREENY);
}

void setup(){
  focus=null;
  earthpic = loadImage("earth.gif");
  flag = loadImage("flag2.gif");
  earth1 = new Earth(earthpic);
  osSetup();  
  lightFont = createFont("Voyager Light.otf", 20);
  boldFont = createFont("Voyager Heavy.otf", 20);
  font = loadFont("MS-PGothic-48.vlw"); textFont(font); textSize(25); textAlign(CENTER,CENTER);
  init_tables();
  init_state_map();
  init_lists(); 
  init_screens();
  init_widgets();
  setDisplayObjByInd(0);
  init_screen_text(displayObj);
  set_earth_satellite(displayObj, s2);
  test_date();
  mouseDir = 0.0; 
  init_FileSortedByMass(spaceObjects);
} //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>//

void draw() {
  currentScreen.loop(mouseX,mouseY, mouseDir*scrollMultiplier); //<>// //<>//
  currentScreen.draw(); //<>// //<>// //<>// //<>// //<>//
}  //<>// //<>// //<>// //<>//
 //<>// //<>//
public void mousePressed() { //<>// //<>//
  currentScreen.parseEvent(); //<>// //<>//
} //<>// //<>// //<>// //<>//
 //<>// //<>//
public void mouseReleased() { //<>// //<>//
  currentScreen.checkReleaseEvents(); //<>// //<>//
}  //<>// //<>//
 //<>// //<>//
void mouseWheel(MouseEvent event){ //<>// //<>// //<>// //<>//
  if (event.getCount() >= 1) //<>// //<>//
    mouseDir = 1; //<>// //<>//
  else if (event.getCount() <= -1) //<>// //<>//
    mouseDir = -1; //<>// //<>//
  else mouseDir = 0; //<>// //<>//
} //<>// //<>//
 //<>// //<>//
public void mouseDragged() { //<>// //<>//
  if(prevChartCap != chartCap) { //<>// //<>//
   prevChartCap = chartCap; //<>// //<>//
   setCharts(-15); //<>// //<>//
  } //<>// //<>//
   segmentNumber.updateLabel("Segments Displayed: " + chartCap); //<>// //<>//
  } //<>// //<>//
 //<>// //<>//
void keyPressed() { //<>// //<>//
  if(focus!=null) //<>// //<>//
  { //<>// //<>//
    if(key!=CODED) //<>// //<>//
      focus.append(key); //<>// //<>//
    } //<>// //<>//
} //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>//
