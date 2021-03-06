////// MAIN INPUTS ///////
String inputFile = "../data/output/bay_area.csv"; // works!
String scenario = "Bay Area";
boolean recording = false;
boolean HQ = false;
//////////////////////////

// Import Unfolding Maps
import de.fhpotsdam.unfolding.*;
import de.fhpotsdam.unfolding.core.*;
import de.fhpotsdam.unfolding.data.*;
import de.fhpotsdam.unfolding.events.*;
import de.fhpotsdam.unfolding.geo.*;
import de.fhpotsdam.unfolding.interactions.*;
import de.fhpotsdam.unfolding.mapdisplay.*;
import de.fhpotsdam.unfolding.mapdisplay.shaders.*;
import de.fhpotsdam.unfolding.marker.*;
import de.fhpotsdam.unfolding.providers.*;
import de.fhpotsdam.unfolding.texture.*;
import de.fhpotsdam.unfolding.tiles.*;
import de.fhpotsdam.unfolding.ui.*;
import de.fhpotsdam.unfolding.utils.*;
import de.fhpotsdam.utils.*;

// Import some Java utilities
import java.util.Date;
import java.text.SimpleDateFormat;

// Import video export
import com.hamoid.*;
VideoExport videoExport;

// Declare Global Variables
UnfoldingMap map;

// MAKES A 60 SECOND ANIMAION
int totalFrames = 3600;
// Statistics input files (for stacked area chart)
String vehicleCountFile = "../data/output/bay_area_vehicle_counts_3600.csv";
String busCountFile = "../data/output/bay_area_buses_count_3600.csv";
String tramCountFile = "../data/output/bay_area_trams_count_3600.csv";
String cablecarCountFile = "../data/output/bay_area_cablecars_count_3600.csv";
String metroCountFile = "../data/output/bay_area_metros_count_3600.csv";
String trainCountFile = "../data/output/bay_area_trains_count_3600.csv";
String ferryCountFile = "../data/output/bay_area_ferries_count_3600.csv";

/* // MAKES A 15 SECOND ANIMATION
int totalFrames = 900;
// Statistics input files (for stacked area chart)
String vehicleCountFile = "../data/output/bay_area_vehicle_counts_900.csv";
String busCountFile = "../data/output/bay_area_buses_count_900.csv";
String tramCountFile = "../.data/output/bay_area_trams_count_900.csv";
String cablecarCountFile = "../data/output/bay_area_cablecars_count_900.csv";
String metroCountFile = "../data/output/bay_area_metros_count_900.csv";
String trainCountFile = "../data/output/bay_area_trains_count_900.csv";
String ferryCountFile = "../data/output/bay_area_ferries_count_900.csv";
*/

int totalSeconds;
Table tripTable;

ArrayList<Trips> trips = new ArrayList<Trips>();
ArrayList<String> operators = new ArrayList<String>();
ArrayList<String> vehicle_types = new ArrayList<String>();

Table busCount;
ArrayList<Line> busLines = new ArrayList<Line>();
ArrayList<Line> busXAxis = new ArrayList<Line>();
ArrayList<Line> busTrails = new ArrayList<Line>();
int busTrailsLength = 10;
ArrayList<String> busXAxisLabels = new ArrayList<String>();
ArrayList<Integer> busFrames = new ArrayList<Integer>();
ArrayList<Integer> busCounts = new ArrayList<Integer>();
ArrayList<String> busLabels = new ArrayList<String>();
ArrayList<Float> busHeights = new ArrayList<Float>();

Table tramCount;
ArrayList<Line> tramLines = new ArrayList<Line>();
ArrayList<Line> tramXAxis = new ArrayList<Line>();
ArrayList<Line> tramTrails = new ArrayList<Line>();
int tramTrailsLength = 10;
ArrayList<String> tramXAxisLabels = new ArrayList<String>();
ArrayList<Integer> tramFrames = new ArrayList<Integer>();
ArrayList<Integer> tramCounts = new ArrayList<Integer>();
ArrayList<String> tramLabels = new ArrayList<String>();
ArrayList<Float> tramHeights = new ArrayList<Float>();

Table metroCount;
ArrayList<Line> metroLines = new ArrayList<Line>();
ArrayList<Line> metroXAxis = new ArrayList<Line>();
ArrayList<Line> metroTrails = new ArrayList<Line>();
int metroTrailsLength = 10;
ArrayList<String> metroXAxisLabels = new ArrayList<String>();
ArrayList<Integer> metroFrames = new ArrayList<Integer>();
ArrayList<Integer> metroCounts = new ArrayList<Integer>();
ArrayList<String> metroLabels = new ArrayList<String>();
ArrayList<Float> metroHeights = new ArrayList<Float>();

Table cablecarCount;
ArrayList<Line> cablecarLines = new ArrayList<Line>();
ArrayList<Line> cablecarXAxis = new ArrayList<Line>();
ArrayList<Line> cablecarTrails = new ArrayList<Line>();
int cablecarTrailsLength = 10;
ArrayList<String> cablecarXAxisLabels = new ArrayList<String>();
ArrayList<Integer> cablecarFrames = new ArrayList<Integer>();
ArrayList<Integer> cablecarCounts = new ArrayList<Integer>();
ArrayList<String> cablecarLabels = new ArrayList<String>();
ArrayList<Float> cablecarHeights = new ArrayList<Float>();

Table trainCount;
ArrayList<Line> trainLines = new ArrayList<Line>();
ArrayList<Line> trainXAxis = new ArrayList<Line>();
ArrayList<Line> trainTrails = new ArrayList<Line>();
int trainTrailsLength = 10;
ArrayList<String> trainXAxisLabels = new ArrayList<String>();
ArrayList<Integer> trainFrames = new ArrayList<Integer>();
ArrayList<Integer> trainCounts = new ArrayList<Integer>();
ArrayList<String> trainLabels = new ArrayList<String>();
ArrayList<Float> trainHeights = new ArrayList<Float>();

Table ferryCount;
ArrayList<Line> ferryLines = new ArrayList<Line>();
ArrayList<Line> ferryXAxis = new ArrayList<Line>();
ArrayList<Line> ferryTrails = new ArrayList<Line>();
int ferryTrailsLength = 10;
ArrayList<String> ferryXAxisLabels = new ArrayList<String>();
ArrayList<Integer> ferryFrames = new ArrayList<Integer>();
ArrayList<Integer> ferryCounts = new ArrayList<Integer>();
ArrayList<String> ferryLabels = new ArrayList<String>();
ArrayList<Float> ferryHeights = new ArrayList<Float>();

ScreenPosition startPos;
ScreenPosition endPos;
Location startLocation;
Location endLocation;
Date minDate;
Date maxDate;
Date startDate;
Date endDate;
Date thisStartDate;
Date thisEndDate;
PImage clock; 
PImage calendar;
PImage airport;
PFont raleway;
PFont ralewayBold;
Integer screenfillalpha = 100;

Location place_start;
Float firstLat;
Float firstLon;
Integer zoom_start;
color c;

// define date format of raw data
SimpleDateFormat myDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
SimpleDateFormat hour = new SimpleDateFormat("h:mm a");
//SimpleDateFormat day = new SimpleDateFormat("MMMM dd, yyyy");
SimpleDateFormat weekday = new SimpleDateFormat("EEEE");

// Basemap providers
AbstractMapProvider provider1;
AbstractMapProvider provider2;
AbstractMapProvider provider3;
AbstractMapProvider provider4;
AbstractMapProvider provider5;
AbstractMapProvider provider6;
AbstractMapProvider provider7;
AbstractMapProvider provider8;
AbstractMapProvider provider9;
AbstractMapProvider provider0;
AbstractMapProvider providerq;
AbstractMapProvider providerw;
AbstractMapProvider providere;
AbstractMapProvider providerr;
AbstractMapProvider providert;
AbstractMapProvider providery;
AbstractMapProvider provideru;
AbstractMapProvider provideri;

boolean monday = false;
boolean tuesday = false;
boolean wednesday = false;
boolean thursday = false;
boolean friday = false;
boolean saturday = false;
boolean sunday = false;

void setup() {
  size(1000, 960, P3D);
  //fullScreen(P3D);

  provider1 = new OpenStreetMap.OpenStreetMapProvider();
  provider2 = new OpenStreetMap.OSMGrayProvider();
  provider3 = new EsriProvider.WorldStreetMap();
  provider4 = new EsriProvider.DeLorme();
  provider5 = new EsriProvider.WorldShadedRelief();
  provider6 = new EsriProvider.NatGeoWorldMap();
  provider7 = new EsriProvider.OceanBasemap();
  provider8 = new EsriProvider.WorldGrayCanvas();
  provider9 = new EsriProvider.WorldPhysical();
  provider0 = new EsriProvider.WorldStreetMap();
  providerq = new EsriProvider.WorldTerrain();
  providerw = new EsriProvider.WorldTopoMap();
  providere = new Google.GoogleMapProvider();
  providerr = new StamenMapProvider.TonerLite();
  providert = new CartoDB.Positron();
  providery = new StamenMapProvider.TonerBackground();
  provideru = new Microsoft.AerialProvider();
  provideri = new StamenMapProvider.TonerBackground();

  smooth();

  loadData();

  map = new UnfoldingMap(this, providert);
  MapUtils.createDefaultEventDispatcher(this, map);
  println("Scenario: " + scenario);

  switch(scenario) {
  case "Dynamic":
    place_start = new Location(firstLat, firstLon);
    zoom_start = 9;
    break;
  case "USA":
    Location USA = new Location(41, -98);
    place_start = USA;
    zoom_start = 4;
    break;
  case "California":
    Location california = new Location(37.93, -122.23);
    place_start = california;
    zoom_start = 6;
    break;
  case "LA":
    Location LA = new Location(34.5522, -118.2437);
    place_start = LA;
    zoom_start = 9;
    break;
  case "SF downtown":
    Location SF_downtown = new Location(37.7749, -122.4194);
    place_start = SF_downtown;
    zoom_start = 11;
    break;
  case "Bay Area":
    Location bay_area = new Location(37.8749, -122.0094);
    place_start = bay_area;
    zoom_start = 9;
    break;
  }  

  map.zoomAndPanTo(zoom_start, place_start);

  // Fonts and icons
  raleway  = createFont("Raleway-Heavy", 32);
  ralewayBold  = createFont("Raleway-Bold", 28);
  clock = loadImage("../data/google_clock.png");
  clock.resize(0, 35);
  calendar = loadImage("../data/google_calendar.png");
  calendar.resize(0, 35);

  videoExport = new VideoExport(this);
  videoExport.setFrameRate(60);
  if (recording == true) videoExport.startMovie();
}

float h_offset;

void loadData() {
  tripTable = loadTable(inputFile, "header");
  println(str(tripTable.getRowCount()) + " records loaded...");

  // calculate min start time and max end time (must be sorted ascending)
  String first = tripTable.getString(0, "start_time");
  String last = tripTable.getString(tripTable.getRowCount()-1, "end_time");

  println("Min departure time: ", first);
  println("Max departure time: ", last);

  try {
    minDate = myDateFormat.parse(first); //first "2017-07-17 9:59:00"
    maxDate = myDateFormat.parse(last); //last
    totalSeconds = int(maxDate.getTime()/1000) - int(minDate.getTime()/1000);
  } 
  catch (Exception e) {
    println("Unable to parse date stamp");
  }
  println("Min starttime:", minDate, ". In epoch:", minDate.getTime()/1000);
  println("Max starttime:", maxDate, ". In epoch:", maxDate.getTime()/1000);
  println("Total seconds in dataset:", totalSeconds);
  println("Total frames:", totalFrames);

  firstLat = tripTable.getFloat(0, "start_lat");
  firstLon = tripTable.getFloat(0, "start_lon");

  for (TableRow row : tripTable.rows()) {
    String vehicle_type = row.getString("route_type");
    vehicle_types.add(vehicle_type); 

    int tripduration = row.getInt("duration");
    int duration = round(map(tripduration, 0, totalSeconds, 0, totalFrames));

    try {
      thisStartDate = myDateFormat.parse(row.getString("start_time"));
      thisEndDate = myDateFormat.parse(row.getString("end_time"));
    } 
    catch (Exception e) {
      println("Unable to parse destination");
    }

    int startFrame = floor(map(thisStartDate.getTime()/1000, minDate.getTime()/1000, maxDate.getTime()/1000, 0, totalFrames));
    int endFrame = floor(map(thisEndDate.getTime()/1000, minDate.getTime()/1000, maxDate.getTime()/1000, 0, totalFrames));

    float startLat = row.getFloat("start_lat");
    float startLon = row.getFloat("start_lon");
    float endLat = row.getFloat("end_lat");
    float endLon = row.getFloat("end_lon");
    startLocation = new Location(startLat, startLon);
    endLocation = new Location(endLat, endLon);
    trips.add(new Trips(duration, startFrame, endFrame, startLocation, endLocation));
  }
  
  
  int lineAlpha = 30;
  // bus stacked bar
  busCount = loadTable(busCountFile, "header");
  for (int i = 0; i < busCount.getRowCount(); i++) {
    TableRow row = busCount.getRow(i);
    int frame = row.getInt("frame");
    int count = row.getInt("count");
    busFrames.add(frame);
    busCounts.add(count);
    float h = busCounts.get(i);
    busHeights.add(h);
    c = color(0, 173, 253, lineAlpha);
    int xmargin = 50;
    int ymargin = 40;
    int xaxisoffset = 5;
    Line line = new Line(xmargin + i/hscale, height-ymargin, xmargin + i/hscale, height-ymargin-h/vscale, c);
    c = color(255);
    Line xaxis = new Line(xmargin, height-ymargin+xaxisoffset, xmargin + i/hscale+1, height-ymargin+xaxisoffset, c);
    busLines.add(line);
    busXAxis.add(xaxis);
  }
  
  // tram stacked bar
  tramCount = loadTable(tramCountFile, "header");
  for (int i = 0; i < tramCount.getRowCount(); i++) {
    TableRow row = tramCount.getRow(i);
    int frame = row.getInt("frame");
    int count = row.getInt("count");
    tramFrames.add(frame);
    tramCounts.add(count);
    float h = tramCounts.get(i);
    tramHeights.add(h);
    h_offset = busHeights.get(i);
    c = color(124, 252, 0, lineAlpha); 
    int xmargin = 50;
    int ymargin = 40;
    Line line = new Line(xmargin + i/hscale, height-ymargin-(h_offset)/vscale, xmargin + i/hscale, height-ymargin-(h+h_offset)/vscale, c);
    tramLines.add(line);
  }

  // Metro stacked bar
  metroCount = loadTable(metroCountFile, "header");
  for (int i = 0; i < metroCount.getRowCount(); i++) {
    TableRow row = metroCount.getRow(i);
    int frame = row.getInt("frame");
    int count = row.getInt("count");
    metroFrames.add(frame);
    metroCounts.add(count);
    float h = metroCounts.get(i);
    metroHeights.add(h);
    h_offset = busHeights.get(i) + tramHeights.get(i);
    c = color(255, 0, 0, lineAlpha); 
    int xmargin = 50;
    int ymargin = 40;
    Line line = new Line(xmargin + i/hscale, height-ymargin-(h_offset)/vscale, xmargin + i/hscale, height-ymargin-(h+h_offset)/vscale, c);
    metroLines.add(line);
  }
  
  // Train stacked bar
  trainCount = loadTable(trainCountFile, "header");
  for (int i = 0; i < trainCount.getRowCount(); i++) {
    TableRow row = trainCount.getRow(i);
    int frame = row.getInt("frame");
    int count = row.getInt("count");
    trainFrames.add(frame);
    trainCounts.add(count);
    float h = trainCounts.get(i);
    trainHeights.add(h);
    h_offset = busHeights.get(i)+ tramHeights.get(i)+ metroHeights.get(i);
    c = color(255, 215, 0, lineAlpha); 
    int xmargin = 50;
    int ymargin = 40;
    Line line = new Line(xmargin + i/hscale, height-ymargin-(h_offset)/vscale, xmargin + i/hscale, height-ymargin-(h+h_offset)/vscale, c);
    trainLines.add(line);
  }
  
  // Cablecar stacked bar
  cablecarCount = loadTable(cablecarCountFile, "header");
  for (int i = 0; i < cablecarCount.getRowCount(); i++) {
    TableRow row = cablecarCount.getRow(i);
    int frame = row.getInt("frame");
    int count = row.getInt("count");
    cablecarFrames.add(frame);
    cablecarCounts.add(count);
    float h = cablecarCounts.get(i);
    cablecarHeights.add(h);
    h_offset = busHeights.get(i) + tramHeights.get(i) + metroHeights.get(i) + trainHeights.get(i);
    c = color(238, 130, 238, lineAlpha); 
    int xmargin = 50;
    int ymargin = 40;
    Line line = new Line(xmargin + i/hscale, height-ymargin-(h_offset)/vscale, xmargin + i/hscale, height-ymargin-(h+h_offset)/vscale, c);
    cablecarLines.add(line);
  }
  
  // Ferry stacked bar
  ferryCount = loadTable(ferryCountFile, "header");
  for (int i = 0; i < ferryCount.getRowCount(); i++) {
    TableRow row = ferryCount.getRow(i);
    int frame = row.getInt("frame");
    int count = row.getInt("count");
    ferryFrames.add(frame);
    ferryCounts.add(count);
    float h = ferryCounts.get(i);
    ferryHeights.add(h);
    h_offset = busHeights.get(i) + tramHeights.get(i) + metroHeights.get(i) + cablecarHeights.get(i) + trainHeights.get(i);
    c = color(255, 105, 180, lineAlpha); 
    int xmargin = 50;
    int ymargin = 40;
    Line line = new Line(xmargin + i/hscale, height-ymargin-(h_offset)/vscale, xmargin + i/hscale, height-ymargin-(h+h_offset)/vscale, c);
    ferryLines.add(line);
  }
}

float hscale = float(totalFrames) / float(width)*0.12; //*0.78
float vscale = 20;

void draw() {

  if (frameCount < totalFrames) {



    map.draw();
    noStroke();
    fill(0, screenfillalpha);
    rect(0, 0, width, height);

    // draw stacked area chart with a bunch of skinny lines
    for (int i = 0; i < frameCount; i++) {
      Line busLine = busLines.get(i);
      Line xaxis = busXAxis.get(i);
      busLine.plot();
      xaxis.plot();
  
      Line trainLine = trainLines.get(i);
      trainLine.plot();
      
      Line tramLine = tramLines.get(i);
      tramLine.plot();
      
      Line metroLine = metroLines.get(i);
      metroLine.plot();
      
      Line cablecarLine = cablecarLines.get(i);
      cablecarLine.plot();
      
      Line ferryLine = ferryLines.get(i);
      ferryLine.plot();
    }

    // handle time
    float epoch_float = map(frameCount, 0, totalFrames, int(minDate.getTime()/1000), int(maxDate.getTime()/1000));
    int epoch = int(epoch_float);

    //String date = new java.text.SimpleDateFormat("MM/dd/yyyy hh:mm:ss").format(new java.util.Date(epoch * 1000L));
    String day = new java.text.SimpleDateFormat("EEEE").format(new java.util.Date(epoch * 1000L));
    String time = new java.text.SimpleDateFormat("h:mm a").format(new java.util.Date(epoch * 1000L));

    // draw labels
    textFont(ralewayBold, 12);
    int xmargin = 60;
    int ymargin = 40;
    
    //fill(255, 255, 255);
    
   fill(0,150);
   noStroke();
   rect(xmargin + frameCount/hscale-5, height-ymargin-120, 110, 115,7);
   c = color(255,255,255,255);
   strokeWeight(1);
   stroke(c);
   line(xmargin + frameCount/hscale, height-ymargin-24, xmargin + frameCount/hscale+100, height-ymargin-24);
   noStroke();
    
    int h_bus = busCounts.get(frameCount);
    fill(0, 173, 253, 255);
    text("Buses: ", xmargin + frameCount/hscale, height - ymargin-105);
    textAlign(RIGHT);
    text(nfc(h_bus), xmargin + frameCount/hscale + 100, height - ymargin-105);
    textAlign(LEFT);

    int h_tram = tramCounts.get(frameCount);
    fill(124, 252, 0, 255);
    text("Light Rail: ", xmargin + frameCount/hscale, height-ymargin-90);
    textAlign(RIGHT);
    text(h_tram, xmargin + frameCount/hscale + 100, height-ymargin-90);
    textAlign(LEFT);
    
    int h_metro = metroCounts.get(frameCount);
    fill(255,51,51, 255);
    text("Subways: ", xmargin + frameCount/hscale, height-ymargin-75);
    textAlign(RIGHT);
    text(h_metro, xmargin + frameCount/hscale + 100, height-ymargin-75);
    textAlign(LEFT);
    
    int h_train = trainCounts.get(frameCount);
    fill(255, 215, 0, 255);
    text("Trains: ", xmargin + frameCount/hscale, height-ymargin-60);
    textAlign(RIGHT);
    text(h_train, xmargin + frameCount/hscale + 100, height-ymargin-60);
    textAlign(LEFT);
    
    int h_cablecar = cablecarCounts.get(frameCount);
    fill(238, 130, 238, 255);
    text("Cable Cars: ", xmargin + frameCount/hscale, height-ymargin-45);
    textAlign(RIGHT);
    text(h_cablecar, xmargin + frameCount/hscale + 100, height-ymargin-45);
    textAlign(LEFT);
    
    int h_ferry = ferryCounts.get(frameCount);
    fill(255, 105, 180, 255);
    text("Ferries: ", xmargin + frameCount/hscale, height-ymargin-30);
    textAlign(RIGHT);
    text(h_ferry, xmargin + frameCount/hscale + 100, height-ymargin-30);
    textAlign(LEFT);
    
    fill(255);
    text("Total: ", xmargin + frameCount/hscale, height-ymargin-10);
    textAlign(RIGHT);
    text(nfc(h_bus + h_train + h_tram + h_metro + h_cablecar + h_ferry), xmargin + frameCount/hscale + 100, height-ymargin-10);
    textAlign(LEFT);
    
    if (day.equals("Monday")) monday = true;
    if (day.equals("Tuesday")) tuesday = true;
    if (day.equals("Wednesday")) wednesday = true;
    if (day.equals("Thursday")) thursday = true;
    if (day.equals("Friday")) friday = true;
    if (day.equals("Saturday")) saturday = true;
    if (day.equals("Sunday")) sunday = true;

    int xlabeloffset = 15;
    //int xlabeldist = 120;
    int xlabelmargin = 50;

    fill(255);
    if (monday == true) text("Monday", xlabelmargin, height-xlabeloffset);
   
    text(time, xmargin + frameCount/hscale, height - xlabeloffset-15);
    
    textFont(ralewayBold, 14);
    text("Number of Transit Vehicles in Motion", xlabelmargin, height-xlabeloffset-170);
    
    fill(0, screenfillalpha);

    // draw trips
    noStroke();
    for (int i=0; i < trips.size(); i++) {

      Trips trip = trips.get(i);
      String vehicle_type = vehicle_types.get(i);

      switch(vehicle_type) {
      case "bus":
        c = color(0, 173, 253);
        fill(c, 200);
        trip.plotBus();
        break;
      case "bus_service":
        c = color(0, 173, 253);
        fill(c, 200);
        trip.plotBus();
        break;
      case("tram"):
        c = color(124, 252, 0);
        fill(c, 245);
        trip.plotTram();
        break;
      case("metro"):
        c = color(255, 0, 0);
        fill(c, 245);
        trip.plotSubway();
        break;
      case("rail"):
        c = color(255, 215, 0);
        fill(c, 200);
        trip.plotTrain();
        break;
      case("ferry"):
        c = color(255, 105, 180);
        fill(c, 200);
        trip.plotRide();
        break;
      case("cablecar"):
        c = color(238, 130, 238);
        fill(c, 200);
        trip.plotRide();
      case("gondola"):
        c = color(255, 127, 80);
        fill(c, 200);
        trip.plotRide();
      case("funicular"):
        c = color(0, 173, 253);
        fill(c, 255);
        trip.plotRide();
      }
    }
    // Time and icons
    textSize(32);
    fill(255, 255, 255, 255);
    image(clock, 30, 25);
    stroke(255, 255, 255, 255);
    line(30, 70, 210, 70);
    image(calendar, 30, 80 );

    textFont(raleway);
    noStroke();
    text(time, 75, 55);
    textFont(ralewayBold);
    text(day, 75, 108);

    if (recording == true) {
      if (frameCount < totalFrames) {
        if (HQ == true) {
          saveFrame("frames/######.tiff");
        } else if (HQ == false) {
          videoExport.saveFrame();
          return;
        }
      } else {
        if (HQ == true) exit(); 
        if (HQ == false) videoExport.endMovie(); 
        exit();
      }
    }
  }
}

void keyPressed() {
  if (key == '1') {
    map.mapDisplay.setProvider(provider1);
  } else if (key == '2') {
    map.mapDisplay.setProvider(provider2);
  } else if (key == '3') {
    map.mapDisplay.setProvider(provider3);
  } else if (key == '4') {
    map.mapDisplay.setProvider(provider4);
  } else if (key == '5') {
    map.mapDisplay.setProvider(provider5);
  } else if (key == '6') {
    map.mapDisplay.setProvider(provider6);
  } else if (key == '7') {
    map.mapDisplay.setProvider(provider7);
  } else if (key == '8') {
    map.mapDisplay.setProvider(provider8);
  } else if (key == '9') {
    map.mapDisplay.setProvider(provider9);
  } else if (key == '0') {
    map.mapDisplay.setProvider(provider0);
  } else if (key == 'q') {
    map.mapDisplay.setProvider(providerq);
  } else if (key == 'w') {
    map.mapDisplay.setProvider(providerw);
  } else if (key == 'e') {
    map.mapDisplay.setProvider(providere);
  } else if (key == 'r') {
    map.mapDisplay.setProvider(providerr);
  } else if (key == 't') {
    map.mapDisplay.setProvider(providert);
    screenfillalpha = 150;
  } else if (key == 'y') {
    map.mapDisplay.setProvider(providery);
  } else if (key == 'u') {
    map.mapDisplay.setProvider(provideru);
    screenfillalpha = 50;
  } else if (key == 'i') {
    map.mapDisplay.setProvider(provideri);
  }
}