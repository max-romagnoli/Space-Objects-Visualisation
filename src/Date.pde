public Calendar convertToDate(int day, int month, int year) {   //Colm Buttimer 23/3/22 13:50 added convert date ints to Date type, used with 
  Calendar rightNow = Calendar.getInstance();               // search by date method. + 24/3/22 15:07 changed to Calendar object + 30/3/22 applying
                                                           //  multiple search parameters (top 5 masses between two dates).
  rightNow.clear();
  rightNow.set(year, month - 1 , day);          //month is 0 based, so -1 from table number.
  return rightNow;
}

public void test_date() {
  testing = filterByDate(spaceObjects, 4, 10, 1959, 4, 10, 1965);  //from and to dates.
  
  ArrayList<Float> bigInts = new ArrayList<Float>();
  bigInts = getTopMass(testing, 66);
  for(Float mass: bigInts) {
    biggestMassBetweenDates.add((float)mass);
  }

}
