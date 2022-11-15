import java.util.*;

//Colm Buttimer 12:54 13/4/2022 added apogee and perigee range methods

public ArrayList<SpaceO> apogeeRange(ArrayList<SpaceO> list, int minApogee, int maxApogee) {
  
  ArrayList<SpaceO> returnList = new ArrayList<SpaceO>();
  for(SpaceO o : list) {
   if(o.apogee() > 0 && o.apogee() >= minApogee && o.apogee() <= maxApogee ) {
     returnList.add(o);
   }
  }
  return returnList;
}

public ArrayList<SpaceO> perigeeRange(ArrayList<SpaceO> list, int minPerigee, int maxPerigee) {
  
  ArrayList<SpaceO> returnList = new ArrayList<SpaceO>();
  for(SpaceO o : list) {
   if(o.perigee() > 0 && o.perigee() >= minPerigee && o.perigee() <= maxPerigee ) {
     returnList.add(o);
   }
  }
  return returnList;
}

public SpaceO findObjBySatcat(ArrayList<SpaceO> list, int satcat) {
   
  SpaceO returnObj = null;
  for(SpaceO o : list) {
   if(o.satcat() == satcat) {
     returnObj = o; 
   }
  }
  return returnObj;  //Colm Buttimer 17:55 11/4/2022 added satcat search, findNumberOfEachStatus, sort by diameter, and diameter comparator
}

public ArrayList<Float> findNumberOfEachStatus(ArrayList<SpaceO> list, String status1, String status2, 
       String status3, String status4, String status5) {
  
  ArrayList<Float> returnList = new ArrayList<Float>();
  float counter1 = findStatus(list, status1);
  float counter2 = findStatus(list, status2);
  float counter3 = findStatus(list, status3);
  float counter4 = findStatus(list, status4);
  float counter5 = findStatus(list, status5);
  returnList.add(counter1);
  returnList.add(counter2);
  returnList.add(counter3);
  returnList.add(counter4);
  returnList.add(counter5);
  return returnList;
}

public float findStatus(ArrayList<SpaceO> list, String status) {
 
  float counter = 0; 
  for(SpaceO o : list) {
   if(o.status() == status) {
    counter++; 
   }
  }
  return counter;
}

public ArrayList<SpaceO> findBetweenYear(ArrayList<SpaceO> list, int fromYear, int toYear) {
  
  ArrayList<SpaceO> returnList = new ArrayList<SpaceO>();
  for(SpaceO obj : list) {
    if(obj.launchYear() >= fromYear && obj.launchYear() <= toYear) {
     returnList.add(obj); 
    }
  }
  return returnList;
}

public ArrayList<SpaceO> findBetweenMass(ArrayList<SpaceO> list, int minMass, int maxMass) { 
 
   ArrayList<SpaceO> returnList = new ArrayList<SpaceO>();
   for(SpaceO obj : list) {
    if(obj.mass() >= minMass && obj.mass() <= maxMass) {
     returnList.add(obj); 
    }
   }
   return returnList;
}

public ArrayList<SpaceO> filterByCountry(ArrayList<SpaceO> list, String countryCode) { 
  
  ArrayList<SpaceO> returnList = new ArrayList<SpaceO>();
  for(SpaceO obj: list) {
     if(obj.state().equals(countryCode)) {  //Colm Buttimer 12:24 30/3/22 added filterByCountry and totalLaunchesPerYear + 12:36 10/4/22 added findBetweenMass 
       returnList.add(obj);                 // and findBetweenYear and updated SpaceO object
     }
  }  
  return returnList;
}

public int totalLaunchesPerYear(ArrayList<SpaceO> list, int launchYear) {
  
 int counter = 0;
 for(SpaceO obj: list) {
  String split[] = obj.launchDate.split("\\s+");
  try {
    int objYear = Integer.parseInt(split[0]);
    if(objYear == launchYear) {
      counter++; 
    }
  }
  catch (Exception e) {
    counter++;
  }
 }
 
  return counter;
}

public LinkedHashMap<Float,String> totalLaunchesInYearRange(ArrayList<SpaceO> list, int startingLaunchYear, int finalLaunchYear) {
  LinkedHashMap<Float,String> launchDataAndYears = new LinkedHashMap<Float,String>();
  for (int i = startingLaunchYear;i<=finalLaunchYear;i++)
    launchDataAndYears.put((float)totalLaunchesPerYear(list,i),Integer.toString(i));
  return launchDataAndYears;
}

public LinkedHashMap<String,Integer> objectCountryMap(ArrayList<SpaceO> list) {   //counts total number of objects from each different state.
  
  LinkedHashMap<String,Integer> hm = new LinkedHashMap<String,Integer>();
  for(SpaceO obj: list) {
    String state = obj.state();                            //Colm Buttimer 24/3/22 18:46 added hashmap with number of objects per state. Ability to pass
    int value = hm.getOrDefault(state, 0);                 // number of objects per state and 5 buggest masses to a barchart.
     hm.put(state, value + 1); 
  }
  println(hm.size());
 return hm; 
}
public ArrayList<Integer> numOfSpaceObj(HashMap<String,Integer> hm) {    //needs improvement. gets number of space objects owned by each state from hashmap.
      //SU*, US*, CA* F, I-INT, UK, J, I-ESRO, D, I*, NL, IN, CN, D, I-ESA  //country codes, probably more in data set. * are in the 1k set
      for (Map.Entry<String,Integer> entry : hm.entrySet()) {
        numOfStateObj.add(entry.getValue());
      }
      return numOfStateObj;
}

public ArrayList<Float> extractData(ArrayList<SpaceO> list) {  
  
  ArrayList<Float> newList = new ArrayList<Float>();
  for(SpaceO obj: list) {
    float mass = obj.mass();
    newList.add(mass); 
  }
  return newList;
}

public ArrayList<SpaceO> filterByDate(ArrayList<SpaceO> list, int fromDay, int fromMonth, int fromYear, int toDay, int toMonth, int toYear) {

  ArrayList<SpaceO> newList = new ArrayList<SpaceO>();
  Date from = convertToDate(fromDay, fromMonth, fromYear).getTime();
  Date to = convertToDate(toDay, toMonth, toYear).getTime();
  
  for(SpaceO obj : list) {
    
    if(obj.dateOfLaunch().before(from)) {         //Colm Buttimer 23/03/22 13:40 fixed method to search by date. + 24/3/22 15:05 fixed bug.
      continue;
    }
    if(obj.dateOfLaunch().after(to)) {           
     continue; 
    }
    newList.add(obj);
  }
  return newList;   
}

public ArrayList<SpaceO> filterByMass(ArrayList<SpaceO> list, float minMass, float maxMass) {   

  ArrayList<SpaceO> newList = new ArrayList<SpaceO>();         //Colm Buttimer 23/03/22 13:40 added filterByMass, getTop, getTopLessThan, sortByMass 
                                                               // and mass comparator.
  for (SpaceO obj : list) {
    if (obj.mass() >= minMass && obj.mass() <= maxMass ) {
      newList.add(obj);
    }
  }
  return newList;
}

public ArrayList<Float> getTopMass(ArrayList<SpaceO> list, int numberOfTops) {

  ArrayList<Float> newList = new ArrayList<Float>();
  float lessThanMass = Integer.MAX_VALUE;
  for (int i = 1; i <= numberOfTops; i++) {
    lessThanMass = getTopLessThan(list, lessThanMass);
    newList.add(lessThanMass);
  }

  return newList;
}

public float getTopLessThan(ArrayList<SpaceO> list, float lessThanMass) {
  float currentMax = 0;
  for (SpaceO obj : list) {
    if (obj.mass() < lessThanMass && obj.mass() > currentMax) {
      currentMax = obj.mass();
    }
  }
  return currentMax;
}

public ArrayList<SpaceO> sortByMass(ArrayList<SpaceO> list) {
  ArrayList<SpaceO> returnList = new ArrayList<SpaceO>(list);
  //Collections.copy(returnList, list);
  Collections.sort(returnList, new MassComparator());
  return returnList;
}

public ArrayList<Float> numbersToPercentages(ArrayList<Float> numbers){
  float sum = 0;
  for (float number : numbers)
    sum += number;
   ArrayList<Float>floats = new ArrayList<Float>();
  for (int i=0; i<numbers.size(); i++)
    floats.add(numbers.get(i)/sum);
  return floats;
}

class MassComparator implements Comparator<SpaceO> {
  public int compare(SpaceO o1, SpaceO o2) {

    if (o1.mass() < o2.mass()) {
      return -1;
    } else if (o1.mass() == o2.mass()) {
      return 0;
    } else {
      return 1;
    }
  }
}
public ArrayList<Float> getTopDiameter(ArrayList<SpaceO> list, int numberOfTops) {  

  ArrayList<Float> newList = new ArrayList<Float>();
  float lessThanDiameter = Integer.MAX_VALUE;
  for (int i = 1; i <= numberOfTops; i++) {
    lessThanDiameter = getTopLessThan(list, lessThanDiameter);
    newList.add(lessThanDiameter);
  }

  return newList;
}

public int getTopLessThanDiameter(ArrayList<SpaceO> list, float lessThanDiameter) {
  int currentMaxDiameter = 0;
  for (SpaceO obj : list) {
    if (obj.diameter() < lessThanDiameter && obj.diameter() > currentMaxDiameter) {
      currentMaxDiameter = (int) obj.diameter();
    }
  }
  return currentMaxDiameter;
}

public ArrayList<SpaceO> sortByDiameter(ArrayList<SpaceO> list) {
  ArrayList<SpaceO> returnList = new ArrayList<SpaceO>(list);
  Collections.sort(returnList, new diameterComparator());
  return returnList;
}

class diameterComparator implements Comparator<SpaceO> {
  public int compare(SpaceO o1, SpaceO o2) {

    if (o1.diameter() < o2.diameter()) {
      return -1;
    } else if (o1.diameter() == o2.diameter()) {
      return 0;
    } else {
      return 1;
    }
  }
}
