import java.util.List;
import java.util.Collections;

ArrayList<Integer> colours = new ArrayList<Integer>();

{
  Collections.addAll(colours, color(255,255,0),color(0,255,255),color(200,100,200),color(255,140,0),color(0,255,0));
}


class Chart {
  
  PVector pos,dim;
  
  ArrayList<SpaceO> objects;
  
  int numWidgets;
  float thickness, offset, padding;
  color labelColour;
  String yAxisLabel = null;
  String xAxisLabel = null;
  int widgetCap=-1;
  PVector bounds=null;
  
  boolean loaded;
  Screen chartScreen;
  
  float totalValue=0;
  
  ArrayList<Float> data;
  ArrayList<Integer> events = new ArrayList();
  ArrayList<Widget> widgets = new ArrayList();
      
  //Actual probable parameters:
  public Chart(PVector _pos, PVector _dim, ArrayList<Float> _data, ArrayList<Integer> _events, color _labelColour, int _thickness, float _offset, float _padding, Screen _chartScreen) {
    labelColour = _labelColour;
    pos = _pos;
    dim = _dim;
    data = _data;
    events = _events;
    thickness = _thickness;
    offset = _offset;
    padding = _padding;
    loaded=true;
    chartScreen=_chartScreen;
  }
 
  public void setData(ArrayList<Float> data) {
   this.data = data; 
   if(chartScreen==s1)
     this.objects = s1SortedObjects;
   else
     this.objects = sortedSpaceObjects;
  }
  
  public void setAxisLabels(String xAxis, String yAxis) {
    xAxisLabel=xAxis;
    yAxisLabel=yAxis;
  }
  
  public Widget getWidget(int index) {
    return widgets.get(index);
  }

  public void init() {
    float currentHighest=0;
    for (int i=0;i<data.size();i++) {
      totalValue+=data.get(i);
      if (data.get(i)>currentHighest) currentHighest = data.get(i);
    }
    float t = (dim.x-padding*2)*thickness/(offset*data.size());
    //divides viable area into 3
    float wAlign = (dim.x-(2*padding))/data.size();
    for (int i=0;i<data.size();i++) {
      int c = i%colours.size();//(int) colours.size()-2/(i+1);
      int event = events.get(i);
      //makes the highest value in the dataset the tallest bar in the chart
      float hAlign = data.get(i)*(dim.y-padding*2)/(currentHighest);
      Widget w = new RectangleWidget(new PVector((pos.x-dim.x/2+padding)+wAlign/2+i*wAlign,pos.y+dim.y/2-hAlign/2-padding),new PVector(t,hAlign),"",colours.get(c), color(labelColour),event,widgets);
      //to allign the bars to the bottom of the chart.      
      widgets.add(w);
    }
  }
  
  public void add(Widget w) {
    widgets.add(w);
  }

  public void load(Screen s) {
    numWidgets = widgets.size();
    for (Widget w:widgets) {
      s.widgets.add(w);
    }
  }
  
  public void unLoad(Screen s) {
    for(Widget w: widgets) {
     s.widgets.remove(w);   //clears widgets from the screen and the chart.
    }
    widgets.clear();
  }
  
  public void clearWidgets(Screen s) {
    s.widgets.clear();
  }
  
  public void testRender(PVector _pos, PVector _dim) {
    fill(0);
    noStroke();
    rect(_pos.x,_pos.y,_dim.x,_dim.y);
  }
  
  public Widget getWidgetById(int id) {
    return null;
  }
  
}

class HorizontalChart extends Chart{
  int ID;
  boolean isCheckable, isClickable;
  
  public HorizontalChart(int _ID, PVector _pos, PVector _dim, ArrayList<String> _labels, color _labelColour, boolean _isCheckable, boolean _isClickable, ArrayList<Integer> _events, int _thickness, float _offset, float _padding, Screen s) {
    super(_pos,_dim,null,_events, _labelColour,_thickness,_offset,_padding, s);
    ID = _ID;
    labels=_labels;
    isCheckable=_isCheckable;
    isClickable=_isClickable;
  }
  
  public void init() {
    for (int i=0;i<labels.size();i++) {
      int c = color(101,30,32,150);
      int event = events.get(i);
      Widget w = new RectangleWidget(new PVector(padding+pos.x+(offset+thickness)*i,pos.y),new PVector(thickness,dim.y),labels.get(i),c,color(labelColour),event,widgets);
      if (isCheckable) {
        w.isCheckable=true;
        w.isSuppressable=false;
        if (i==0) w.isChecked=true;
      }
      w.hoverType=2;
      widgets.add(w); 
    }
  }
}

class FowardBack extends HorizontalChart{  //Colm Buttimer 20:35 9/4/22 added forwardBack class (implemented David Mockler's code) to work with buttons on s3 
  
  public FowardBack(int _ID, PVector _pos, PVector _dim, ArrayList<String> _labels, color _labelColour, boolean _isCheckable, boolean _isClickable, ArrayList<Integer> _events, int _thickness, float _offset, float _padding, Screen s) {
    super(_ID, _pos, _dim, _labels, _labelColour, _isCheckable, _isClickable, _events, _thickness, _offset, _padding, s);
  }
 
  public void init() {
    super.init();
    for (int i=0;i<labels.size();i++) {
      int event = events.get(i);     
      Widget w = widgets.get(i);
      w.setID(event); 
    }
  }
}


class VerticalChart extends Chart {
  
  int pNumber; 
  ArrayList<SpaceO> listObjects = new ArrayList();
  ArrayList<String> labels = new ArrayList();
  ArrayList<String> subLabels = new ArrayList();
  boolean isCheckable, isClickable;
  int ID;
  
  public VerticalChart(int _ID, PVector _pos, PVector _dim, color _labelColour, ArrayList<String> _labels, ArrayList<SpaceO> _listObjects, boolean _isCheckable, boolean _isClickable, ArrayList<Integer> _events, int _thickness, float _offset, float _padding, Screen s) {  //<>//
    super(_pos,_dim,null,_events, _labelColour,_thickness,_offset,_padding, s);
    ID=_ID;
    isCheckable=_isCheckable;
    isClickable=_isClickable;
    listObjects=_listObjects; //<>//
    if(_labels!=null) //<>//
      labels=_labels;
    subLabels = labels;
  }
  
  public VerticalChart(int _ID, PVector _pos, PVector _dim, PVector _bounds, color _labelColour, ArrayList<String> _labels, ArrayList<SpaceO> _listObjects, boolean _isCheckable, boolean _isClickable, ArrayList<Integer> _events, int _thickness, float _offset, float _padding, Screen s) {  //<>//
    super(_pos,_dim,null,_events, _labelColour,_thickness,_offset,_padding, s); //<>//
    ID=_ID;
    isCheckable=_isCheckable; //<>//
    isClickable=_isClickable;
    listObjects=_listObjects;
    if(_labels!=null) //<>//
      labels=_labels; //<>//
    subLabels = labels; //<>//
    bounds = _bounds;
  }
  
  public void sortList(int sortType) {                                                            
     if(this.equals(objList))
     {
       sortedSpaceObjects.clear();
     }
     else
       s1SortedObjects.clear();
     searchSystem.compare_label(spaceObjects, sortType);
     println(sortType);
     if(searchSystem.sorted)
     { //<>//
       labels.clear();
       events.clear();
       if(this.equals(s1List))
       {
         println("s1List"); //<>//
       }
       else
         getLabels(sortedSpaceObjects,s2, sb1);
       
     }
     //So that the box borders always overlay:
     for (PopUp pu:searchBorders) {
       s2.widgets.remove(pu); //<>//
     } //<>//
     for (int i=0;i<searchBorders.size();i++) {
       s2.widgets.add(searchBorders.get(i));
     }
  }
  
  public ArrayList<String> updateWorkingObjects(List<SpaceO> objects,int page) {     //<>//
    ArrayList<String> newLabels = new ArrayList<String>();   
    int cap = min(objects.size(),(page+1)*50);
    for (int i=page*50;i<cap;i++) {
      if (i<labels.size()) {
        newLabels.add(labels.get(i));
        int objEvent = OBJECT_DISPLAY_OFFSET + objects.get(i).satcat();
        events.add(objEvent);
      }
    }
    return newLabels;
  }
  
  public void getLabels(List<SpaceO> objects, Screen s, ScrollBar sb) {
    getLabelsNoLoad(objects, sb);
    load(s);
  }
  
   public void getLabelsNoLoad(List<SpaceO> objects, ScrollBar sb) {
    for(int index = 0; index <objects.size(); index++)
    {
      SpaceO obj = objects.get(index);
      labels.add(obj.objectName);
      int objEvent;
      if(searchSystem.sorted) {
        objEvent = SORTED_OBJECT_DISPLAY_OFFSET + index;
      }else {
       objEvent = OBJECT_DISPLAY_OFFSET + obj.satcat(); 
      }
      events.add(objEvent);
    }
    subLabels = updateWorkingObjects(objects, s2PageNumber);
    init();
    if(this.equals(s1List))
    {
      maxPageNumber = (int) Math.floor(objects.size()/ 50);
      pNumber=s1PageNumber;
      pageNumber1.updateLabel(s2PageNumber+1 +"/"+(maxPageNumber+1));
    }
    else
    {
      maxPageNumber = (int) Math.floor(objects.size()/ 50);
      pNumber=s2PageNumber;
      pageNumber.updateLabel(s2PageNumber+1 +"/"+(maxPageNumber+1));
    }
    if(searchSystem.sorted)
      sb.updateProportion();
  }
   



  public void init() {
	  float t = thickness;
    s2.removeWidget(widgets);
    widgets.clear();   
    for (int i=0;i<subLabels.size();i++) {
      int c = color(101,30,32,150);
      int event = events.get(i);
      Widget w = new RectangleWidget(new PVector(pos.x,(pos.y-dim.y/2+((thickness+padding)*i))),new PVector(dim.x,t),subLabels.get(i),c, color(labelColour),event,widgets);
      //to allign the bars to the bottom of the chart.
      if (isCheckable) {
        w.isCheckable=true;
        w.isSuppressable=false;
        if (i==0) w.isChecked=true;
      }
      w.setID(ID);
      if (bounds!=null) w.yBounds = bounds;
      w.hoverType=2;   
      widgets.add(w); 
    } 
  }
}

class BarChart extends Chart{
  
  int ID;
  
  public BarChart(int _ID, PVector _pos, PVector _dim, ArrayList<Float> _data, ArrayList<Integer> _events, color _labelColour, int _thickness, float _offset, float _padding, Screen s) {
    super(_pos,_dim,_data,_events,_labelColour,_thickness,_offset,_padding, s);
    ID=_ID;
  }
  public BarChart(int _ID, PVector _pos, PVector _dim, ArrayList<Float> _data, ArrayList<SpaceO> _objects, ArrayList<Integer> _events, color _labelColour, int _thickness, float _offset, float _padding, String xLabel, String yLabel, Screen s) {
    super(_pos,_dim,_data,_events,_labelColour,_thickness,_offset,_padding, s);
    ID=_ID;
    super.objects=_objects;
    setAxisLabels(xLabel, yLabel);
  }
  public BarChart(int _ID, PVector _pos, PVector _dim, ArrayList<Float> _data, ArrayList<Integer> _events, color _labelColour, int _thickness, float _offset, float _padding, String xLabel, String yLabel, int widgetCap, Screen s) {
    super(_pos,_dim,_data,_events,_labelColour,_thickness,_offset,_padding, s);
    ID=_ID;
    setAxisLabels(xLabel, yLabel);
    this.widgetCap = widgetCap;
  }

  public void init() {
        
    Widget xLegend = new Widget(new PVector(pos.x,pos.y+dim.y/2-padding+5), new PVector(dim.x-padding/2,10),"",color(100,100,140),-1,null);
    xLegend.isHoverable=false;
    widgets.add(xLegend);
    Widget yLegend = new Widget(new PVector(pos.x-dim.x/2+padding-5,pos.y), new PVector(10,dim.y-padding/2),"",color(100,100,140),-1,null);
    yLegend.isHoverable=false;
    widgets.add(yLegend);
    
    if (xAxisLabel!=null&&yAxisLabel!=null) {
      PopUp xLegendLabel = new PopUp(new PVector(pos.x,pos.y+dim.y/2+5),new PVector(10,100),-1,color(0,255,255,0),color(255,255,0),xAxisLabel);
      widgets.add(xLegendLabel);
      PopUp yLegendLabel = new PopUp(new PVector(pos.x-dim.x/2-12,pos.y),new PVector(10,100),-1,color(0,255,255,0),color(255,255,0),yAxisLabel,270);
      widgets.add(yLegendLabel);
    }
       
    if (widgetCap<=0)
      widgetCap=objects.size();
    else if(widgetCap>objects.size())
      widgetCap=objects.size();
    else if (objects.size()<=0)
      widgetCap = objects.size();
    
    //To make the horizontal scaling accurate
    int counter=0;
    for (float f:data) {
      if (f!=0)counter++;
    }
    if (counter<widgetCap)widgetCap=counter;
   
    println("Size: " + objects.size());
    println("Data size: " + data.size());
    println(widgetCap);
    float currentHighest=0;
    for (int i=0;i<widgetCap;i++) {
      totalValue+=data.get(i);
      if (data.get(i)>currentHighest) currentHighest = data.get(i);
    }
    //just added
    float t = (dim.x-padding*2)*thickness/(offset*widgetCap);
    //divides viable area into 3
    float wAlign = (dim.x-(2*padding))/widgetCap;
    
    for(int i=0; i<widgetCap; i++) {
      SpaceO obj = super.objects.get(i);
      int c = i%colours.size();
      int event = OBJECT_DISPLAY_OFFSET + obj.satcat();
      //makes the highest value in the dataset the tallest bar in the chart
      float hAlign = data.get(i)*(dim.y-padding*2)/(currentHighest);
      if (data.get(i)==currentHighest) {
        Widget scaleMarker = new Widget(new PVector(pos.x-dim.x/2+padding/1.5,pos.y+dim.y/2-hAlign-padding), new PVector(20,10),"",color(100,100,140),-1,null);
        scaleMarker.isHoverable=false;
        widgets.add(scaleMarker);
        int highest = (int)currentHighest;
        PopUp scaleMarkerText = new PopUp(new PVector(scaleMarker.pos.x-20,scaleMarker.pos.y), new PVector(5,5),-1,color(0,0,0,0),color(0,0,0,0),(Integer.toString(highest)),270);
        scaleMarkerText.size=.75;
        widgets.add(scaleMarkerText);
      }
      Widget w = new RectangleWidget(new PVector((pos.x-dim.x/2+padding)+wAlign/2+i*wAlign,pos.y+dim.y/2-hAlign/2-padding),new PVector(t,hAlign),"",colours.get(c),color(labelColour),event,widgets);
      w.hasPopUp=true;
      float popUpData = data.get(i);
      //Apogee, Perigee
      if(!(s1WorkingData.equals(numOfStateObjData)||(s1WorkingData.equals(statusData))||(s1WorkingData.equals(launchDateData))))
        w.popUpLabel="Satcat: \n" + obj.objectName() +"\n"+ yAxisLabel+": \n" + (int)popUpData;
      else if (s1WorkingData.equals(launchDateData))
        w.popUpLabel=("Year:\n" + defaultLaunchYears.get(popUpData) + "\nNumber of Objects:\n"+ (int)popUpData);
      else if (s1WorkingData.equals(numOfStateObjData)) {
        w.popUpLabel=("Country:\n" + statesHMCountryNames.get(i) + "\nNumber of Objects:\n"+ (int)popUpData);
      }
      else
        w.popUpLabel=yAxisLabel+": \n" + (int)popUpData;
      widgets.add(w);
      w.setID(ID);
    }
  }
  
  public void add(Widget w) {
    widgets.add(w);
  }

  public void load(ArrayList<Widget> _ws) {
    //init();
    numWidgets = widgets.size();
    for (Widget w:widgets) {
      _ws.add(w);
    }
  }
  
  public void testRender(PVector _pos, PVector _dim) {
    fill(0);
    noStroke();
    rect(_pos.x,_pos.y,_dim.x,_dim.y);
  }
}

class PieChart extends Chart{
  
  ArrayList<Integer> colours = new ArrayList<Integer>();
  
  {
    Collections.addAll(colours, 10,50,90);
  }
  
  float r;
  int ID;
  ArrayList<Float> percentages;
  
  PieChart(int _ID, PVector _pos, float radius, ArrayList<Float> _data, ArrayList<Integer> _events, color _labelColour, Screen s) {
    super(_pos,null,_data,_events,_labelColour,0,0,0, s);
    percentages = numbersToPercentages(data);
    r=radius;
    ID=_ID;
    if (widgetCap<=0)
      widgetCap=data.size();
    else if (data.size()<=0)
      widgetCap = data.size();
  }
  PieChart(int _ID, PVector _pos, float radius, ArrayList<Float> _data, ArrayList<SpaceO> _objects, ArrayList<Integer> _events, color _labelColour, String xLabel, String yLabel, Screen s) {
    super(_pos,null,_data,_events,_labelColour,0,0,0, s);
    super.objects=_objects;
    percentages = numbersToPercentages(data);
    r=radius;
    ID=_ID;
    setAxisLabels(xLabel, yLabel);
    if (widgetCap<=0)
      widgetCap=data.size();
    else if (data.size()<=0)
      widgetCap = data.size();
  }
  
  public void init() { 
    this.setData(data);
    ArrayList<PVector> points = new ArrayList<PVector>();
    float startSlice = 0;
    for (int i=0;i<widgetCap;i++) {
      SpaceO obj = objects.get(i);
      points.add(new PVector(pos.x + r*cos(startSlice),pos.y + r*sin(startSlice)));
      //int index = i%3;
      int c=color(i*30,i*10,0);
      Widget w = new PieWidget(pos, r,startSlice,percentages.get(i)*TWO_PI+startSlice,null,c ,1,points.get(i),widgets);
      w.hasPopUp = true;
      //Apogee, Perigee
      float popUpData = data.get(i);
      if (!(s1WorkingData.equals(launchDateData))) {
        w.popUpLabel= "Satcat: \n" + obj.objectName() +"\n"+ yAxisLabel+": \n" + (int)popUpData;
      } else if (s1WorkingData.equals(launchDateData)) {
        w.popUpLabel=("Year:\n" + defaultLaunchYears.get(popUpData) + "\nNumber of Objects:\n"+ (int)popUpData);
      }
      widgets.add(w);   
      startSlice += percentages.get(i)*TWO_PI;
      w.setID(ID);
    }
    PopUp xLegendLabel = new PopUp(new PVector(pos.x,pos.y-r-15), new PVector(100,100),-1,color(255,255,255,0),color(0,0,0,0),yAxisLabel + "/" + xAxisLabel);
    widgets.add(xLegendLabel);
  }
  public void setData(ArrayList<Float> data) {
   this.data=data;
   this.objects=s1SortedObjects;
   if (widgetCap<=0)
      widgetCap=data.size();
    if (objects.size()<=0)
      widgetCap = objects.size();
    else if (data.size()<widgetCap)
      widgetCap = data.size();
   ArrayList<Float> updatedData = new ArrayList<Float>();
   for (int i=0;i<widgetCap;i++) {
     updatedData.add(data.get(i));
   }
   percentages = numbersToPercentages(updatedData);
  }
}

class PieWidget extends Widget {
  
  float r,angle1,angle2;
  PVector point;
  
  public PieWidget(PVector _pos, float radius, float _angle1, float _angle2, String _label, color _colour, int eventType, PVector _point, ArrayList<Widget> _linkedWidgets) {
    super(_pos,null,_label,_colour,eventType,_linkedWidgets);
    r=radius;
    angle1=_angle1;
    angle2=_angle2;
    isSuppressable = true;
    point=_point;
  }
  
  public boolean collide(float mX, float mY) {
    PVector mousePos = new PVector(mX, mY);
    PVector difference = mousePos.sub(pos);
    float heading = difference.heading();
    if (heading < 0) 
      heading += TWO_PI;
    if (dist(mX, mY, pos.x, pos.y) < r*size 
    && heading > angle1 && heading < angle2)
      return true;
    else
      return false;
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
    if (alpha(colour)>100) {
      colour=color(red(colour),green(colour),blue(colour),alpha(colour)*.9);
    }
  }
  
  public void staticSuppress(){}
  
  public void dynamicDesuppress(){
    if (alpha(colour)<255)
      colour=color(red(colour),green(colour),blue(colour),alpha(colour)*1.1);
    else {
      colour=baseColour;
      isDynamicSuppressed=false;
    }
  }
  
  public void staticDesuppress(){}
  
  void draw() {
    fill(colour);
    arc(pos.x, pos.y, 2*r*size, 2*r*size, angle1, angle2);
    if (hasPopUp) managePopUp();
  }
}
