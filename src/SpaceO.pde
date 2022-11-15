import java.util.Date;
class SpaceO {

  private int satcat;
  private String piece;
  private String type;
  private String plName;
  private String status;
  private String owner;

  private String objectName;
  private String state;
  private String launchDate;
  private int mass;
  private double diameter;
  private int perigee;
  private int apogee;
  
  private int ypos;

  private String launchMonthString;
  int dryMass; 
  int totMass; 
  String oDate;
  
  private Calendar dateOfLaunch;


  SpaceO(int satcat, String piece, String type, String objectName, String status, String state, int mass, double diameter, int perigee, 
  int apogee, String launchDate, int ypos, Table monthTable, int dryMass, int totMass, String oDate) {
    this.satcat = satcat;
    this.piece = piece;
    this.type = type;
    
    this.objectName = objectName;
    this.status = status;
    this.state = state;
    this.mass = mass;
    this.diameter = diameter;
    this.perigee = perigee;
    this.apogee = apogee;
    this.launchDate = launchDate;
    this.dryMass = dryMass;
    this.totMass = totMass;
    this.oDate = oDate;
    
    this.ypos = ypos;

    convertDate(monthTable);
  }
  
  void convertDate(Table monthTable){               //Colm Buttimer 24/3/22 15:05 Replaced day,month,year int varaibles with calendar object 
    String split[] = launchDate.split("\\s+");
    int launchYear;
    int launchMonthInt;
    int launchDay;
    try {
      launchYear = Integer.parseInt(split[0]);
      launchMonthString = split[1];
      launchMonthInt= monthTable.getInt(0, split[1]);
      launchDay= Integer.parseInt(split[2]);
      
    }
    catch (Exception e){
      launchYear = -1;
      launchMonthInt = -1;
      launchDay = -1;
    }
    dateOfLaunch = convertToDate(launchDay, launchMonthInt, launchYear);   
  }
  
  public String toString() {
    String string = "Satcat: " + satcat +" Name: "+ objectName + "Apogee: " +apogee + " Perigee: " + perigee;
    
    
   return string; 
  }
  
  public Date dateOfLaunch() {
   return dateOfLaunch.getTime(); 
  }
/*    
  public int ypos(){
    return int(-(theSB.ypos-SB_HEIGHT+1)*theSB.ratio+3*theSB.ratio);
  }
  */
  
  public int dryMass() {
    return dryMass;
  }
  public int totMass() {
    return totMass;
  }
  public String oDate() {
    return oDate;
  }
  
  
  public int launchYear() {
    return dateOfLaunch.get(Calendar.YEAR);
  }
  
  public String launchMonthString() {
    return launchMonthString;
  }
  public int launchMonthInt() {
    return dateOfLaunch.get(Calendar.MONTH) + 1;
  }
  public int launchDay() {
    return dateOfLaunch.get(Calendar.DAY_OF_MONTH);
  }
  public int satcat() {
    return satcat;
  }
  public String launchDateString() {
    return launchDate;
  }
  public String piece() {
    return piece;
  }
  public String type() {
    return type;
  }
  public String objectName() {
    return objectName;
  }
  public String status() {
    return status;
  }
  public String state() {
    return state;
  }
  public int mass() {
    return mass;
  }
  public double diameter() {
    return diameter;
  }
  public int perigee() {
    return perigee;
  }
  public int apogee() {
    return apogee;
  }
}
