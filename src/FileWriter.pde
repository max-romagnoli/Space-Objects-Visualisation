public void init_FileSortedByMass(ArrayList<SpaceO> list) {   //Colm Buttimer 14:05 30/3/22 Added file writing of objects sorted in ascending mass order
  
  list = sortByMass(list);
  PrintWriter output;
  output = createWriter("massSorted.tsv");
  if(output == null) {
   println("Can't open file massSprted.tsv for writting");
   exit();
  }
  output.println("Mass  Name  Status  State  Satcat  Diameter  Perigee  Apogee  Launch Date");
  for(SpaceO obj: list) {
    
    output.println(obj.mass()+"\t"+obj.objectName()+"\t"+obj.status()+"\t"
                  +obj.state()+"\t"+obj.satcat()+"\t"+obj.diameter()+"\t"+obj.perigee()+"\t"+obj.apogee()+"\t"+obj.launchDateString());
  }
  output.flush();
  output.close();
  
  
}
