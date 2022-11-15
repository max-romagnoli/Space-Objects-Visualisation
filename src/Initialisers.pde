int displayMode=CHART_MODE; //<>//
Table monthTable;
ArrayList<String> queryTitles;ArrayList<Integer> queryEvents;ArrayList<Integer> screenEvents;
ArrayList<String> pageButtonsText;ArrayList<Integer> chartEvents;ArrayList<String> chartType;
ArrayList<String> sortTypeText;ArrayList<Integer> sortTypeEvents; ArrayList<Integer> page2Events;
ArrayList<String> statesHMCountryNames;
int screenInd = 0;
ArrayList<SpaceO> spaceObjects = new ArrayList<SpaceO>(); ArrayList<SpaceO> sortedSpaceObjects; ArrayList<SpaceO> s1SortedObjects;
ArrayList<Float> testData = new ArrayList<Float>();           
ArrayList<Float> massData = new ArrayList<Float>();           
ArrayList<Float> numOfStateObjData = new ArrayList<Float>();
ArrayList<Float> statusData = new ArrayList<Float>();
ArrayList<Float> launchDateData = new ArrayList<Float>();
LinkedHashMap<Float,String> defaultLaunchYears = new LinkedHashMap<Float,String>();
ArrayList<Float> s1WorkingData = new ArrayList<Float>(); HeatMap h;
ArrayList<SpaceO> testing = new ArrayList<SpaceO>();       
ArrayList<Float> biggestMassBetweenDates = new ArrayList<Float>();
ArrayList<Integer> numOfStateObj = new ArrayList<Integer>();
ArrayList<Float> currentBarChart = new ArrayList<Float>();
ArrayList<String> headerLabels; ArrayList<String> sortedLabels; ArrayList<String> subLabels;
LinkedHashMap<String, Integer> statesHM = new LinkedHashMap<String, Integer>();
boolean isYears = true;
boolean isCountry = false;
ArrayList<ScreenText> texts = new ArrayList<ScreenText>();
color blue = color(0,0,200);
PImage earthpic; 
PImage flag;
Earth earth1;
public String queryType = "masses";
public String sortType = "biggest";
public int chartCap;
public int prevChartCap;
public int s2PageNumber, s1PageNumber;
public int maxPageNumber = 1000;
Widget asListButton; Widget asChartButton; Widget yearButton;
SpaceO displayObj;
ScrollBar sb1, s1VBar;
Chart s1Chart;
VerticalChart vChart, objList, s1List;
Chart pc;
TextWidget s1Search; RectangleWidget searchButton;
int time;
int scrollMultiplier;

PopUp upperBorder,lowerBorder,upperBorderOutline,lowerBorderOutline, pageNumber, pageNumber1;
PopUp searchBy, chartBackground;
PopUp minPop, maxPop, fromPop, toPop, yearPop, searchPop;

ArrayList<PopUp> searchBorders; //<>//
 //<>// //<>// //<>//
PopUp info,segmentNumber; //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>//
 //<>// //<>// //<>// //<>// //<>// //<>//
public void init_screens() {  //<>// //<>// //<>// //<>// //<>// //<>//
  //s1 = new Screen(color(100,100,100,255)); s2 = new Screen(color(220,220,220,255)); //<>// //<>// //<>// //<>//
  s1 = new Screen(color(255,255,255,255), false);  //<>// //<>//
  s2 = new Screen(color(255,255,255,255), true); // boolean - quick fix for displaying orbit. //<>// //<>// //<>// //<>// //<>// //<>// //<>//
  s3 = new Screen(color(255,255,255,255), true); //<>// //<>//
  screens.add(s1); //<>// //<>// //<>// //<>// //<>//
  screens.add(s2);  //<>// //<>//
  screens.add(s3); //<>// //<>// //<>//
  currentScreen=s1; //<>//
} //<>// //<>//
 //<>// //<>// //<>// //<>// //<>// //<>//
public void init_state_map() { //<>// //<>//
  statesHM = objectCountryMap(spaceObjects);             //assigning map of number of objects from each state. //<>// //<>// //<>// //<>// //<>// //<>//
  //ArrayList<String> tmp = new ArrayList<String>();
  statesHMCountryNames = new ArrayList<String>(statesHM.keySet());
}

public int getID(String wName) {                          // Massimiliano Romagnoli, added unique ID generator for widgets mapped onto each widget String, 29/03/2022 14:25 
  UUID id = UUID.randomUUID();
  widgetMap.put(wName, id.hashCode());
  return widgetMap.get(wName);
}

public void init_lists() {
  
    h = new HeatMap(600, 675, 200);
    //h = new HeatMap(1400, 150, 200);
    
    events = new ArrayList(); testData = new ArrayList();
    labels = new ArrayList(); headerLabels = new ArrayList(); sortedLabels = new ArrayList(); subLabels = new ArrayList();
    queryTitles = new ArrayList<String>();
    chartEvents = new ArrayList<Integer>(); //<>//
    chartType = new ArrayList<String>(); //<>// //<>//
    queryEvents = new ArrayList<Integer>(); //<>// //<>// //<>// //<>//
    screenEvents = new ArrayList<Integer>(); //<>// //<>// //<>// //<>//
    pageButtonsText = new ArrayList<String>(); //<>// //<>// //<>// //<>// //<>//
    sortTypeEvents = new ArrayList<Integer>(); //<>// //<>// //<>// //<>// //<>//
    sortTypeText = new ArrayList<String>(); //<>// //<>// //<>//
    page2Events = new ArrayList<Integer>(); //<>// //<>//
    { //<>// //<>//
    //Collections.addAll(headerLabels, "Statistics", "Objects"); //<>// //<>//
      //Collections.addAll(queryTitles, "biggestMass", "first5", "mass/dates"); //<>// //<>// //<>// //<>// //<>// //<>//
      Collections.addAll(queryTitles, "year", "country", "date","mass"); //<>// //<>// //<>// //<>// //<>//
      Collections.addAll(queryEvents, -9,-11, -12, -10); //<>// //<>// //<>// //<>// //<>// //<>// //<>//
      Collections.addAll(page2Events, -999, -998); //<>//
      Collections.addAll(headerLabels, "Statistics", "Objects"); //<>// //<>// //<>// //<>// //<>//      
      Collections.addAll(screenEvents, STATS_SCREEN, OBJECTS_SCREEN);
      Collections.addAll(testData, .20f,.20f,.30f,.10f,.20f);   
      Collections.addAll(pageButtonsText,"<",">");
      Collections.addAll(chartEvents,-13,-14);
      Collections.addAll(chartType, "||", "O");
      Collections.addAll(sortTypeEvents,-1,-1);
      Collections.addAll(sortTypeText,"h/l","l/h");
      for(SpaceO obj: spaceObjects) {
        int objEvent = OBJECT_DISPLAY_OFFSET + obj.satcat();
        events.add(objEvent);
      }
      updateMass(s1SortedObjects);
      updateCountry();
      println("New: 2 "+ numOfStateObjData.size());
      defaultLaunchYears = totalLaunchesInYearRange(spaceObjects,1957,2022);
    }   
 //***********************************************************************
 
      
      
    }      

public void updateMass(ArrayList<SpaceO> objects) {
  massData.clear();
  ArrayList<Float> topMasses = getTopMass(objects, 66);             //getting top 5 object masses to pass to barchart3.
    for (float mass : topMasses) {
      massData.add(mass);
    }
}

public void updateCountry() {
  numOfSpaceObj(statesHM);                                          //objects by state, passed to barchart3.
    for(int count : numOfStateObj) {
      numOfStateObjData.add((float)count); 
    }
}

public void updateDate(ArrayList<SpaceO> objects) {
  biggestMassBetweenDates.clear();                                          //objects by state, passed to barchart3.
  ArrayList<Float> topMasses = getTopMass(objects, 66);
    for(float count : topMasses) {
      biggestMassBetweenDates.add(count); 
    }
}
      
 //*************************************************************************     
   //setting first individual display object
    


public void init_screen_text(SpaceO obj) {                                   
  ScreenText name = new ScreenText(1200 , 50, obj.objectName(), 40, CENTER);
  ScreenText satcat = new ScreenText((SCREENX/2)+60, 100, "Satcat: " +obj.satcat(), 18,LEFT);
  ScreenText state = new ScreenText((SCREENX/2)+60, satcat.ypos+40, "State: " +obj.state(), 18,LEFT);
  ScreenText launchDate = new ScreenText((SCREENX/2)+60, state.ypos+40, "Launch Date: " +obj.launchDateString(), 18, LEFT);
  ScreenText status = new ScreenText((SCREENX/2)+60, launchDate.ypos+40, "Status: " +obj.status(), 18, LEFT);
  
  ScreenText mass = new ScreenText((SCREENX/2)+450, 100, "Mass (Kg): " +obj.mass(), 18, LEFT);
  ScreenText perigee = new ScreenText((SCREENX/2)+450, mass.ypos+40, "Perigee: " +obj.perigee(), 18, LEFT);
  ScreenText apogee = new ScreenText((SCREENX/2)+450, perigee.ypos+40, "Apogee: " +obj.apogee(), 18, LEFT);
  
  texts.add(name);
  texts.add(satcat);                //Colm Buttimer 4/4/22 13:05 added ScreenText class, init_screen_text, set_screen_text to display selected space obj info. +
  texts.add(state);                 // 7/4/22 10:44 added set_earth_satellite + 11:17 11/4/2022 updated screenText class for more versatility
  texts.add(launchDate);
  texts.add(status);
  texts.add(mass);
  texts.add(perigee);
  texts.add(apogee);
  for (ScreenText t : texts) {
    t.load(s2);
  }
}

public void set_earth_satellite(SpaceO obj, Screen s) {
 float apogee = obj.apogee();
 int diameter = (int) obj.diameter();
 s.earth.addSatellite(diameter, apogee, 255, obj);  
}

public void set_screen_text(SpaceO obj) {
  for (int index = 0; index < texts.size(); ++index) {
    ScreenText text = texts.get(index);
    switch (index) {
      case 0:
        text.setText(obj.objectName());
        break;
      case 1:
        text.setText("Satcat: " +obj.satcat());
        break;
      case 2:
        text.setText("State: " +obj.state());
        break;
      case 3:
        text.setText("Launch Date: " +obj.launchDateString());
        break;
      case 4:
        text.setText("Status: " +obj.status());
        break;
      case 5:
        text.setText("Mass (Kg): " +obj.mass());
        break;
      case 6:
        text.setText("Perigee: " +obj.perigee());
        break;
      case 7:
        text.setText("Apogee: " +obj.apogee());
        break;
    }
  }
}


public void init_widgets() {
  

  
    // Massimiliano Romagnoli, added search bar environment that handles every search bar and search bar user interfaces. 8/04/2022
    // Keep here
    searchSystem = new SearchBarEnvironment(getID("searchEnv"), null, null, "", false, 0,0,0, null, spaceObjects, s1);
    
    pageNumber1 = new PopUp(new PVector(400,640), new PVector(200,40),-1,color(67,117,140,150),color(0,0,0), s1PageNumber+1 +"/"+1);
  
    float s1BarYPos = 400-375/2;
    s1List = new VerticalChart(getID("s1List"), new PVector(1200,s1BarYPos-2+OBJ_DISPLAYED*11), new PVector(725,2200),new PVector(200,550),color(255,255,255),null, s1SortedObjects, false,true,events,30,40,10, s1);
    s1List.loaded=false;
    s1List.init();
   // s1List.init();
   // s1List.load(s1); 
    
   // s1.widgets.add(pageNumber);

    
    //s1VBar = new ScrollBar(new PVector(1200+(s1List.dim.x/2)+10,375),new PVector(25,356.5),s1List.widgets);
   // s1VBar.init();
   // s1VBar.load(s1);

  
    HorizontalChart testHlist = new HorizontalChart(getID("testHlist"), new PVector(100,50), new PVector(100,50),headerLabels,color(255,255,255),true,true,screenEvents,200,20,20, s1);
    testHlist.init();
    testHlist.load(s1);
    testHlist.load(s2);
    
    //Default query
    launchDateData = new ArrayList<Float>(defaultLaunchYears.keySet());
    s1WorkingData = launchDateData;
    
    barChart3 = new BarChart(getID("barChart3"), new PVector(1200,400), new PVector(600,600),s1WorkingData,s1SortedObjects,events,color(255,255,255),10,15,40,"Objects","Mass (kg)", s1);           // objects to barchart3 and loading barchart to screen1
    barChart3.widgetCap=20;
    barChart3.init();                                            
    pc = new PieChart(getID("pc"), new PVector(barChart3.pos.x,400),250,s1WorkingData,s1SortedObjects,events, color(255,255,255),"Objects","Mass (kg)", s1);
    
    //Important: The starting chart type (the one displayed by default) should be initialised here, the other chart type should not
    s1Chart = barChart3;                                           
    s1Chart.load(s1);
    
    PopUp queryInfo = new PopUp(new PVector(25+100,300),new PVector(200,30),-1,color(67,117,140,150),color(255,255,0),"Query Type: ");
    s1.widgets.add(queryInfo);
    
    VerticalChart sortQueries = new VerticalChart(getID("queryButons"), new PVector(320,300+20), new PVector(130,40),color(255,255,255),queryTitles,null,true,true,queryEvents,40,0,10,s1);
    sortQueries.init();
    sortQueries.load(s1);
    
    //PopUp dividor1 = new PopUp(new PVector(112.5,437.5),new PVector(160,10),-1,color(67,117,140,150),color(255,255,0),"");
    //s1.widgets.add(dividor1);
    
    PopUp chartInfo = new PopUp(new PVector(25+100,550),new PVector(200,30),-1,color(67,117,140,150),color(255,255,0),"Chart Type: ");
    s1.widgets.add(chartInfo);
    
    HorizontalChart testChartType = new HorizontalChart(getID("queryButons"), new PVector(287.5,550), new PVector(50,50),chartType,color(255,255,255),true,true,chartEvents,50,20,0, s1);
    testChartType.init();
    testChartType.load(s1);
    
    info = new PopUp(new PVector(600,375),new PVector(300,200),-1,color(67,117,140,150),color(255,255,0),"Query Function:\n\nSorts the objects by\nnumber between a given\nrange of years");
    s1.widgets.add(info);
    
    /*
    PopUp searchText = new PopUp(new PVector(125,650),new PVector(175,50),-1,color(101-50,30-50,32-50,255),color(255,255,0),"Search range:");
    s1.widgets.add(searchText);
    */
    
    PopUp capInfoLeft = new PopUp(new PVector(50,180), new PVector(50,40),-1,color(67,117,140,255),color(0,0,0),"II");
    capInfoLeft.customTextSize=23;
    capInfoLeft.setTextSize(5);
    capInfoLeft.clickable=false;
    s1.widgets.add(capInfoLeft);
    
    PopUp capInfoRight = new PopUp(new PVector(330,180), new PVector(50,40),-1,color(67,117,140,255),color(0,0,0),"LXVI");
    capInfoRight.customTextSize=23;
    capInfoRight.setTextSize(5);
    capInfoRight.clickable=false;
    s1.widgets.add(capInfoRight);
    
    segmentNumber = new PopUp(new PVector(190,130), new PVector(330,30),-1,color(67,117,140,150),color(0,0,0),"Segments Displayed: " + 20);
    s1.widgets.add(segmentNumber);
    
    HorizontalScrollBar hsb1 = new HorizontalScrollBar(new PVector(190,180),new PVector(200,20),2,66);
    hsb1.init();
    hsb1.hs.mappedPToP(20);
    hsb1.hs.pToPos();
    hsb1.load(s1);
    chartCap = (int) floor(hsb1.hs.getMappedP());
    prevChartCap = chartCap;
    
    //PopUp sortedByText = new PopUp(new PVector(190,130), new PVector(300,30),-1,color(67,117,140,150),color(0,0,0),"Sorted By: " + "Biggest");
    //s1.widgets.add(sortedByText);
    
    HorizontalChart sortType = new HorizontalChart(getID("queryButons"),new PVector(125,180), new PVector(50,40),sortTypeText,color(255,255,255),true,true,sortTypeEvents,70,50,0, s1);
    
    //*********************************************************************************************************
    
    // Massimiliano Romagnoli, this is the old s2 textWidget. It is now an instance of ObjectSearchBar, subclass of abstract TextWidget, with same functionalities as the old one.
    objSearch = new SearchBar(getID("searchBarS2"), new PVector(345,130), new PVector(650, 50), "", false, color(101,30,32,150), color(255,255,255),TEXT_WIDGET_FOCUS,widgets,sortedSpaceObjects, s2, true, "Search", NAME_SORT);   
    objSearch.maxlen=25;    
    objSearch.hoverType=2;
    widgets.add(objSearch);
    s2.widgets.add(objSearch);
    
    pageNumber = new PopUp(new PVector(400,640), new PVector(200,40),-1,color(67,117,140,150),color(0,0,0), s2PageNumber+1 +"/"+(maxPageNumber+1));
    s2.widgets.add(pageNumber);
    
    searchBorders = new ArrayList<PopUp>();
    
    upperBorder = new PopUp(new PVector(400,180), new PVector(800,30),-1,color(#051e3e),color(0,0,0),"");
    s2.widgets.add(upperBorder);
    lowerBorder = new PopUp(new PVector(400,570), new PVector(800,30),-1,color(#051e3e),color(0,0,0),"");
    s2.widgets.add(lowerBorder);
    
    upperBorderOutline = new PopUp(new PVector(382.5,194), new PVector(725,4),-1,color(67,117,140,150),color(0,0,0,0),"");
    s2.widgets.add(upperBorderOutline);
    lowerBorderOutline = new PopUp(new PVector(382.5,556), new PVector(725,4),-1,color(67,117,140,150),color(0,0,0,0),"");
    s2.widgets.add(lowerBorderOutline);
    
    searchBorders.add(upperBorder);
    searchBorders.add(lowerBorder);
    searchBorders.add(upperBorderOutline);
    searchBorders.add(lowerBorderOutline);
    
    for (int i=0;i<searchBorders.size();i++) {
      s2.widgets.add(searchBorders.get(i));
    }
   
    
    float sb1YPos = 400-375/2;
    objList = new VerticalChart(getID("objList"), new PVector(382.5,sb1YPos-2+OBJ_DISPLAYED*11), new PVector(725,2200),new PVector(200,550),color(255,255,255),null, sortedSpaceObjects, false,true,events,30,40,10, s2);
    objList.getLabels(sortedSpaceObjects, s2, sb1);
    objList.init();
    objList.load(s2); objList.loaded=false;
    
    sb1 = new ScrollBar(new PVector(775,375),new PVector(25,356.5),objList.widgets);
    sb1.init();
    sb1.load(s2);
    
    
    
 //*****   
    HorizontalChart s2PageButtons = new HorizontalChart(0, new PVector(260,640), new PVector(50,50), pageButtonsText,color(255,255,255),false,true,page2Events,50,230,0.1, s2);
    s2PageButtons.init();
    s2PageButtons.load(s2);
//*****    
    
    
    queryEvents.clear();
    queryEvents.add(OBJECT_FWRD_OFFSET);
    queryEvents.add(OBJECT_BACK_OFFSET);
    
    //Colm Buttimer + 12:37 12/4/22 changed pageButtons (forwardBack) to s2
    FowardBack pageButtons = new FowardBack(getID("fwrdBack"), new PVector(1000,650), new PVector(50,50), pageButtonsText,color(255,255,255),false,true,queryEvents,50,350,0, s2);
    pageButtons.init();
    pageButtons.load(s2);
    
    Widget backButton = new Widget(new PVector(75,50), new PVector(100,50), "<-", color(101,30,32,150), 3, null);
    backButton.hoverType=2;
    s3.widgets.add(backButton);
    
}

public void init_tables() {

    monthTable = new Table();
    monthTable.addColumn("Jan", Table.INT);
    monthTable.addColumn("Feb", Table.INT);
    monthTable.addColumn("Mar", Table.INT);
    monthTable.addColumn("Apr", Table.INT);
    monthTable.addColumn("May", Table.INT);
    monthTable.addColumn("Jun", Table.INT);
    monthTable.addColumn("Jul", Table.INT);
    monthTable.addColumn("Aug", Table.INT);
    monthTable.addColumn("Sep", Table.INT);
    monthTable.addColumn("Oct", Table.INT);
    monthTable.addColumn("Nov", Table.INT);
    monthTable.addColumn("Dec", Table.INT);
    monthTable.addRow();
    monthTable.setInt(0, "Jan", 1);
    monthTable.setInt(0, "Feb", 2);
    monthTable.setInt(0, "Mar", 3);
    monthTable.setInt(0, "Apr", 4);
    monthTable.setInt(0, "May", 5);
    monthTable.setInt(0, "Jun", 6);
    monthTable.setInt(0, "Jul", 7);
    monthTable.setInt(0, "Aug", 8);
    monthTable.setInt(0, "Sep", 9);
    monthTable.setInt(0, "Oct", 10);
    monthTable.setInt(0, "Nov", 11);
    monthTable.setInt(0, "Dec", 12);

    dataset = loadTable("gcat.tsv", "header, tsv");
    int yrow=HEADER_SPACE;
    for(int r = 0; r < dataset.getRowCount(); r++) {        //Colm Buttimer 18/3/2022 10:15 improved table access 
      yrow += LINE_SPACING;
      int satcat = dataset.getInt(r,"Satcat");
      String piece = dataset.getString(r, "Piece");
      String type = dataset.getString(r, "Type");
      
      String name = dataset.getString(r, "Name");
      String status = dataset.getString(r, "Status");
      String state = dataset.getString(r, "State");
      int mass = dataset.getInt(r, "Mass");
      double diameter = dataset.getDouble(r, "Diameter");
      int perigee = dataset.getInt(r, "Perigee");
      int apogee = dataset.getInt(r, "Apogee");
      String launchDate = dataset.getString(r, "LDate");
      
      int dryMass = dataset.getInt(r, "DryMass");
      int totMass = dataset.getInt(r, "TotMass");
      String oDate = dataset.getString(r, "ODate");
      
      SpaceO obj = new SpaceO(satcat, piece, type, name, status, state, mass, diameter, perigee, apogee, launchDate, yrow, monthTable, dryMass, totMass, oDate);
      spaceObjects.add(obj);
    }
    sortedSpaceObjects = new ArrayList(spaceObjects);
    s1SortedObjects = new ArrayList(spaceObjects);
    Collections.reverse(s1SortedObjects);
  
}

//Liam Malone added OS Check 16:50 22/03/2022
public void osSetup () {
  String os = System.getProperty("os.name");
  if (os.contains("Windows")) {
    scrollMultiplier = 1;
    osType = "win";
    return;
  } else if (os.contains("Mac")) {
    scrollMultiplier = -1;
    osType = "mac";
    return;
  } else if (os.contains("Linux")) {
    scrollMultiplier = 1;
    osType = "linux";
    return;
  } else {
    scrollMultiplier = 1;
    osType = "other";
    return;
  }
}

public void setDisplayObjByInd(int index) {
  if (index >= 0 && index < sortedSpaceObjects.size() ) {
    displayObj = sortedSpaceObjects.get(index);
    setFB(displayObj, SORTED_OBJECT_DISPLAY_OFFSET, index);
  }  
}

public void setFB(SpaceO current, int type, int index) {            
    Widget forward = s2.getWidgetById(OBJECT_FWRD_OFFSET);   
    Widget back = s2.getWidgetById(OBJECT_BACK_OFFSET);
    
    int identifier = -1;
    if(type==SORTED_OBJECT_DISPLAY_OFFSET) {
      identifier=index;
    }else if( type == OBJECT_DISPLAY_OFFSET) {
      identifier = current.satcat();
      
    }
    if(identifier >= 0) {
      back.setEvent(type + identifier + 1);
      forward.setEvent(type + identifier - 1);
    }
    set_screen_text(current);
    set_earth_satellite(current, s2);
}

public void setDisplayObjById(int id) {
  
  for (SpaceO obj : sortedSpaceObjects) {
    if (obj.satcat() == id ) {
      displayObj = obj;

      setFB(displayObj, OBJECT_DISPLAY_OFFSET, -1);
    
      break;
    }
  }  
}

//David Mockler, Altered set charts function to work with multiple queries 09:43 31/03/2022
public void setCharts(int event) {                       
  String xLabel,yLabel;
  
  switch (event) {
    case YEARS_QUERY:
      isYears=true;
      isCountry=false;
      launchDateData = new ArrayList<Float>(defaultLaunchYears.keySet());
      println("csamkcakms: " + launchDateData);
      s1WorkingData = launchDateData;
      print(s1WorkingData.get(0));
      s1Chart.unLoad(s1);
      s1Chart.setData(s1WorkingData);
      s1Chart.widgetCap = chartCap;
      s1Chart.setAxisLabels("Launch Years","Number of Objects");
      if(displayMode==CHART_MODE)
      {
        s1Chart.init();
        s1Chart.load(s1);
      }
      searchSystem.unLoad(s1);
      searchSystem.load(s1, searchSystem.yearWidgets);
      searchBy.updateLabel("Search by year");
      queryType = "year";
      break;
    case MASS_QUERY:
      isYears=false;
      isCountry=false;
      s1WorkingData=massData;      
      s1Chart.unLoad(s1);
      s1Chart.setData(s1WorkingData);
      s1Chart.widgetCap = chartCap;
      //Apogee, Perigee
      s1Chart.setAxisLabels("Objects","Mass (kg)");
      if(displayMode==CHART_MODE)
      {
        s1Chart.init();
        s1Chart.load(s1);
      }
      searchSystem.unLoad(s1);
      searchSystem.load(s1, searchSystem.massWidgets);
      searchBy.updateLabel("Search by mass");
      //Apogee, Perigee
      queryType = "mass";
      sortType = "biggest";
      break;
    case COUNTRY_QUERY:
      isYears=false;
      isCountry=true;
      s1WorkingData = numOfStateObjData;
      s1Chart.unLoad(s1);
      s1Chart.setData(s1WorkingData);
      s1Chart.widgetCap = chartCap;
      s1Chart.setAxisLabels("Countries", "Number of Objects");
      if(displayMode==CHART_MODE)
      {
        s1Chart.init();
        s1Chart.load(s1);
      }
      searchSystem.unLoad(s1);
      searchBy.updateLabel("Top countries: ");
      queryType = "country";
      sortType = "most";
      break;
    case DATE_QUERY:
      isYears=false;
      isCountry=false;
      s1WorkingData = biggestMassBetweenDates;
      s1Chart.unLoad(s1);
      s1Chart.setData(s1WorkingData);
      s1Chart.widgetCap = chartCap;
      s1Chart.setAxisLabels("Objects","Mass (kg)");
      if(displayMode==CHART_MODE)
      {
        s1Chart.init();
        s1Chart.load(s1);
      }
      searchSystem.unLoad(s1);
      searchSystem.load(s1, searchSystem.dateWidgets);    
      searchBy.updateLabel("Search by date");
      queryType = "date";
      sortType = "biggest";
      break;
    case -13:
      xLabel = s1Chart.xAxisLabel;
      yLabel = s1Chart.yAxisLabel;
      s1Chart.unLoad(s1);
      s1Chart=barChart3;
      s1Chart.widgetCap = chartCap;
      s1Chart.setData(s1WorkingData); 
      s1Chart.setAxisLabels(xLabel,yLabel);
      s1Chart.init();
      s1Chart.load(s1);
      break;
    case -14:
      xLabel = s1Chart.xAxisLabel;
      yLabel = s1Chart.yAxisLabel;
      s1Chart.unLoad(s1);
      s1Chart=pc;
      s1Chart.widgetCap = chartCap;
      s1Chart.setData(s1WorkingData);
      s1Chart.setAxisLabels(xLabel,yLabel);
      s1Chart.init();
      s1Chart.load(s1);
      break;
    case -15:
      s1Chart.unLoad(s1);
      s1Chart.widgetCap = chartCap;
      s1Chart.init();
      s1Chart.load(s1);
      break;
    default:
      break;
  }
  //Apogee, Perigee
  if (queryType.equals("mass"))
    info.updateLabel("Query Function:\n\nSorts the objects by\nmass between a given\nrange");
  else if (queryType.equals("date"))
    info.updateLabel("Query Function:\n\nSorts the objects by\nmass between a given\nlaunch date range");
  else if (queryType.equals("year"))
    info.updateLabel("Query Function:\n\nSorts the objects by\nnumber between a given\nrange of years");
  else if (queryType.equals("country"))
    info.updateLabel("Query Function:\n\nSorts the objects by\nnumber per country\n");
}
