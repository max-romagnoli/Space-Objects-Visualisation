abstract class TextWidget extends Widget {
  
  int maxlen;
  boolean sorted;
  Screen screen;
  boolean hasButton;
  boolean numerical;
  int customDistance=0;
  String queryLabel;
  
  TextWidget(){
  }
  
  TextWidget(int _ID, PVector _pos, PVector _dim, String _label, boolean _numerical, color _colour, color _labelColour, int _eventType, ArrayList<Widget> _linkedWidgets, Screen _screen, int _searchType) {
    super(_pos,_dim,_label,_colour,_eventType,_linkedWidgets);
    ID=_ID;
    searchType=_searchType;
    numerical=_numerical;
    labelColour=_labelColour;
    screen=_screen;
    maxlen=6;
    sorted=false;
    hoverType=COLOUR_FADE;
    setLabelAlign(LEFT);
    setQueryType(_searchType);
  }  

  public void setQueryType(int searchType) {
    switch(searchType)
    {
      case NAME_SORT:
        queryLabel="name";
        break;
      case MASS_SORT:
        queryLabel="mass";
        break;
      case DATE_SORT:
        queryLabel="date";
        break;
      case COUNTRY_SORT:
        queryLabel="country";
        break;
      case STATUS_SORT:
        queryLabel="status";
        break;
      default:
        break;
    }    
  }

  public void append(char s){
   // println(s);
    if(s!=ENTER)
    {
      if(s==BACKSPACE )
      {
        if(label.length()!=0)
          label=label.substring(0,label.length()-1);
      }
      else if (label.length()<maxlen)
      {

        if(!numerical)
          label+=str(s);
        else 
        {
          if(s>='0'&& s<='9')
          {
            label+=str(s);
            println(label);
          }      
        }
                      println("Text width: " + textWidth(label));
      }
    }
    else if(s==ENTER&&label.length()>0)
    {
      focus=null;
      if (currentScreen==s2)s2PageNumber=0;
      if(isYears)
        searchSystem.sortYears();
		  if(searchType==NAME_SORT)
      {
        objList.sortList(searchType);
      }
      else
      {
        s1List.sortList(searchType);      
      }
	} 
  }    
    
  public abstract void startSearch();
  public abstract void compare_label(ArrayList<SpaceO> objs, int sortType);
  public abstract void createSearchUI(Screen s, String searchLabel);
  
  public void setCustomDistance(int dist) {
    customDistance=dist;
  }
  
}

class SearchBar extends TextWidget {

  ArrayList<String> objNames;
  ArrayList<SpaceO> objects;

  
  public SearchBar() {}
  
  public SearchBar(int _ID, PVector _pos, PVector _dim, String _label, boolean _numerical, color _colour, color _labelColour, int _eventType, ArrayList<Widget> _linkedWidgets, ArrayList<SpaceO> _objects, Screen _screen, boolean _hasButton, String _searchLabel, int _searchType) {
      super(_ID,_pos,_dim,_label,_numerical,_colour,_labelColour,_eventType,_linkedWidgets, _screen, _searchType);
      super.hasButton=_hasButton;
      objects=_objects;
      createSearchUI(_screen, _searchLabel);
      hasButton=_hasButton;
  }
  
  @Override
  void startSearch() {
    objList.sortList(searchType);
  }
  
  @Override
  void compare_label(ArrayList<SpaceO> objs, int sortType) {}
 
  void sortNames(ArrayList<SpaceO> objs) {
    
    for(SpaceO obj:objs)
    {
      if(obj.objectName.toLowerCase().contains(label.toLowerCase()))
      {
        sortedSpaceObjects.add(obj);
        searchSystem.sorted=true;
      }
    }
    
  }
  
  
  @Override
  void createSearchUI(Screen s, String searchLabel) {
    if(hasButton)
    {
      searchButton = new RectangleWidget(new PVector(pos.x+(dim.x/2)+60,pos.y), new PVector(120,dim.y), searchLabel, color(200,200,200), color(0,0,0), TEXT_WIDGET_SEARCH, widgets);
      searchButton.customTextSize=35;
      searchButton.hoverType=COLOUR_FADE;
      widgets.add(searchButton);
      s.widgets.add(searchButton);
    }
    
  }
  
  public void adjustDistance() {
    if(customDistance!=0)
    {
      searchButton.pos.x+=customDistance;
    }
  }
       
}

class SearchBarEnvironment extends TextWidget {
  
  Screen envScreen;
  
  ArrayList<Widget> environmentWidgets = new ArrayList();
  ArrayList<ArrayList> widgetLists = new ArrayList();
  ArrayList<Widget> massWidgets = new ArrayList();
  ArrayList<Widget> dateWidgets = new ArrayList();
  ArrayList<Widget> countryWidgets = new ArrayList();
  ArrayList<Widget> yearWidgets = new ArrayList();
  ArrayList<Widget> parametersWidgets = new ArrayList();
  Map<Integer, PVector> environmentMap = new HashMap();
  ArrayList<String> objNames;
  ArrayList<SpaceO> objects;
  
  public SearchBarEnvironment() {
  }
  
  public SearchBarEnvironment(int _ID, PVector _pos, PVector _dim, String _label, boolean _numerical, color _colour, color _labelColour, int _eventType, ArrayList<Widget> _linkedWidgets, ArrayList<SpaceO> _objects, Screen _screen) {
      super(_ID,_pos,_dim,_label,_numerical,_colour,_labelColour,_eventType,_linkedWidgets, _screen, NAME_SORT);
      envScreen=_screen;
      initLists();
      initEnvironment();
      objects=_objects;
      searchBy.updateLabel("Search by year");
  }
  
  void initLists() {
    {
      Collections.addAll(widgetLists, massWidgets, dateWidgets, countryWidgets, parametersWidgets);
    }
  }
  
  void initEnvironment() {
    createStaticUI();
    initYearBar();
    initMassBar();
    initDateBar();
    load(s1, yearWidgets);
  }
  
  void mergeEnvironmentWidgets() {
    for(ArrayList list:widgetLists)
    {
      if(list!=null)
      {
        for(Widget w:widgets)
          environmentWidgets.add(w);
      }
    }
  }
  
  void initEnvironmentMap() {
    if(environmentWidgets!=null)
    {
      for(Widget w:environmentWidgets)
        environmentMap.put(w.ID,w.pos);
    }
  }
  
  void initMassBar() {
    
    // change minBar.pos.x to update x position of both search bars + search button
    minBar = new SearchBar(getID("minBar"),new PVector(searchBy.pos.x+240,700), new PVector(150,45), "", true, color(101,30,32,150), color(255,255,255), TEXT_WIDGET_FOCUS, widgets, objects, s1, false, "", MASS_SORT);
    minBar.labelAlign=CENTER;
    minBar.customTextSize=35;
    minBar.hoverType=FADE;
    massWidgets.add(minBar);

 //     searchBy = new PopUp(new PVector(125, 640), new PVector(200,50), -1, color(67,117,140,150), color(255,255,0), "");
    maxBar = new SearchBar(getID("maxBar"),new PVector(minBar.pos.x+155,minBar.pos.y), new PVector(150,minBar.dim.y), "", true, minBar.colour, minBar.labelColour, TEXT_WIDGET_FOCUS, widgets, objects, s1, false, "Plot", MASS_SORT);
    maxBar.labelAlign=CENTER;
    maxBar.customTextSize=35;
    massWidgets.add(maxBar);
    maxBar.hoverType=FADE;
    
    PopUp minPopUp = new PopUp(new PVector(fromYearBar.pos.x, fromYearBar.pos.y-fromYearBar.dim.y), new PVector(fromYearBar.dim.x, fromYearBar.dim.y), -1, color(67,117,140,0), color(67,117,140), color(200), "min");
    minPopUp.clickable=false;
    massWidgets.add(minPopUp);
    PopUp maxPopUp = new PopUp(new PVector(toYearBar.pos.x, toYearBar.pos.y-toYearBar.dim.y), new PVector(toYearBar.dim.x, toYearBar.dim.y), -1, color(67,117,140,0), color(67,117,140), color(200), "max");
    maxPopUp.clickable=false;
    massWidgets.add(maxPopUp);
           
  }
  
  void initDateBar() {
    
    // change minBar.pos.x to update x position of both search bars + search button
    fromBar = new SearchBar(getID("fromBar"),new PVector(minBar.pos.x,700), new PVector(150,minBar.dim.y), "", true, color(101,30,32,150), color(255,255,255), TEXT_WIDGET_FOCUS, widgets, objects, s1, false, "", DATE_SORT);
    fromBar.labelAlign=CENTER;
    fromBar.customTextSize=35;
    fromBar.maxlen=4;
    fromBar.hoverType=FADE;
    dateWidgets.add(fromBar);
    
 
    toBar = new SearchBar(getID("toBar"),new PVector(minBar.pos.x+155,minBar.pos.y), new PVector(150,minBar.dim.y), "", true, minBar.colour, minBar.labelColour, TEXT_WIDGET_FOCUS, widgets, objects, s1, false, "Plot", DATE_SORT);
    toBar.labelAlign=CENTER;
    toBar.customTextSize=35;
    toBar.maxlen=4;
    toBar.setCustomDistance(5);    // change this parameter to change distance of search bar button from rightmost search bar
    toBar.adjustDistance();
    dateWidgets.add(toBar);
    toBar.hoverType=FADE;
    
           
  }

  void initYearBar() {
    
    fromYearBar = new SearchBar(getID("fromYearBar"),new PVector(searchBy.pos.x+240,700), new PVector(150,45), "", true, color(101,30,32,150), color(255,255,255), TEXT_WIDGET_FOCUS, widgets, objects, s1, false, "", YEAR_SORT);
    fromYearBar.labelAlign=CENTER;
    fromYearBar.customTextSize=35;
    fromYearBar.maxlen=4;
    fromYearBar.hoverType=FADE;
    yearWidgets.add(fromYearBar);
    
    toYearBar = new SearchBar(getID("toYearBar"),new PVector(fromYearBar.pos.x+155,fromYearBar.pos.y), new PVector(150,fromYearBar.dim.y), "", true, color(101,30,32,150), color(255,255,255), TEXT_WIDGET_FOCUS, widgets, objects, s1, true, "Plot", YEAR_SORT);
    toYearBar.labelAlign=CENTER;
    toYearBar.customTextSize=35;
    toYearBar.maxlen=4;
    toYearBar.hoverType=FADE;
    yearWidgets.add(toYearBar); 
    
    fromYearBar.setCustomDistance(5);    // change this parameter to change distance of search bar button from rightmost search bar
    fromYearBar.adjustDistance();
    // new PVector(190-165+125, 700), new PVector(250,30), -1, color(67,117,140,150), color(255,255,0), ""
    PopUp fromPopUp = new PopUp(new PVector(fromYearBar.pos.x, fromYearBar.pos.y-fromYearBar.dim.y), new PVector(fromYearBar.dim.x, fromYearBar.dim.y), -1, color(67,117,140,0), color(67,117,140), color(200), "from");
    fromPopUp.clickable=false;
    yearWidgets.add(fromPopUp);
    dateWidgets.add(fromPopUp);
    PopUp toPopUp = new PopUp(new PVector(toYearBar.pos.x, toYearBar.pos.y-toYearBar.dim.y), new PVector(toYearBar.dim.x, toYearBar.dim.y), -1, color(67,117,140,0), color(67,117,140), color(200), "to");
    toPopUp.clickable=false;
    yearWidgets.add(toPopUp);
    dateWidgets.add(toPopUp);
           
  }
  
  void sortMasses(ArrayList<SpaceO> objs) {
    if(float(minBar.label)<=float(maxBar.label))
    {
      s1SortedObjects = sortByMass(filterByMass(objs,float(minBar.label),float(maxBar.label)));
      Collections.reverse(s1SortedObjects);
      sorted=true;
      updateMass(s1SortedObjects);
        setCharts(MASS_QUERY);
    }
    else
    {
      minBar.label=""; maxBar.label="";
    }
  }
  
  void sortDates(ArrayList <SpaceO> objs) {
    if(int(fromBar.label)<=int(toBar.label))
    {
      s1SortedObjects = sortByMass(findBetweenYear(objs,int(fromBar.label), int(toBar.label)));
      Collections.reverse(s1SortedObjects);
      sorted=true;
      updateDate(s1SortedObjects);
        setCharts(DATE_QUERY);
    }
    else
    {
      fromBar.label=""; toBar.label="";
    }
  }
  
  void sortYears() {
    if(int(fromYearBar.label)<= int(toYearBar.label) && int(fromYearBar.label)>=1957)
    {
      defaultLaunchYears = totalLaunchesInYearRange(spaceObjects, int(fromYearBar.label), int(toYearBar.label));
      println(defaultLaunchYears);
      setCharts(YEARS_QUERY);
    }
    else
    {
      fromYearBar.label=""; toYearBar.label="";
    }
  }
  
  void sortCountries(ArrayList <SpaceO> objs) {
  }
  
  public void load(Screen s, ArrayList<Widget> widgets) {
    if(widgets!=null)
    {
      for(Widget w:widgets) {
        s.widgets.add(w);
      }
    }
  }
  
  public void unLoad(Screen s) {
    if(massWidgets!=null)
    {
      for(Widget w:massWidgets) {
        s.widgets.remove(w);
      }
    }
    if(dateWidgets!=null)
    {
      for(Widget w:dateWidgets) {
        s.widgets.remove(w);
      }
    }
    if(countryWidgets!=null)
    {
      for(Widget w:countryWidgets) {
        s.widgets.remove(w);
      }
    }
    if(yearWidgets!=null)
    {
      for(Widget w:yearWidgets) {
        s.widgets.remove(w);
      }
    }
  }  
  
  @Override
  void compare_label(ArrayList<SpaceO> objs, int sortQuery) {
    switch(sortQuery)
    {
      case MASS_SORT:
        sortMasses(objs);
        break;
      case NAME_SORT:
        objSearch.sortNames(objs);
        s2PageNumber = 0;
        break;
      case DATE_SORT:
        sortDates(objs);
        break;
      case COUNTRY_SORT:
        sortCountries(objs);
        break;
      default:
        break;
    }
  }
  
  void createStaticUI() {
    searchBy = new PopUp(new PVector(190-165+125, 700), new PVector(250,30), -1, color(67,117,140,150), color(255,255,0), "");
    searchBy.customTextSize=30;
    s1.widgets.add(searchBy);
    
    chartBackground = new PopUp(new PVector(1200, 400), new PVector(SCREENX/2, SCREENY), -1, color(67,117,140,50), color(255,255,0), "");
    chartBackground.clickable=false;
    s1.widgets.add(chartBackground);
  }
  
  @Override
  void createSearchUI(Screen s, String searchLabel) {
    
    asListButton = new RectangleWidget(new PVector(SCREENX/2-75,700), new PVector(150,50), "List", color(67,117,140), color(255,255,255), SHOW_LIST, null);
    asListButton.customTextSize=35;
    asListButton.hoverType=COLOUR_FADE;
    widgets.add(asListButton);
    s.widgets.add(asListButton);
    
    asChartButton = new RectangleWidget(new PVector(asListButton.pos.x,asListButton.pos.y-asListButton.dim.y-10), new PVector(150,50), "Charts", color(67,117,140), color(255,255,255), SHOW_CHARTS, null);
    asChartButton.customTextSize=35;
    asChartButton.hoverType=COLOUR_FADE;
    s.widgets.add(asChartButton);
  }
     
       
  @Override
  void startSearch() {
  }
  
}
