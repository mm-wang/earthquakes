// LIBRARIES
import processing.pdf.*;

// GLOBAL VARIABLES
PShape baseMap;
String csv[];
String myData[][];
PFont f;

// SETUP
void setup() {
  size(1800,900); //equirectangular canvas is 2:1 ratio
  noLoop();
  f = createFont("GothamNarrow-Medium", 12);
  baseMap = loadShape("WorldMap.svg");
  csv = loadStrings("earthquakes.csv");
  myData = new String[csv.length][15];
  for(int i=0; i<csv.length; i++){
    myData[i] = csv[i].split(",");
  }
}

// DRAW
void draw() {
  beginRecord(PDF,"earthquakes.pdf");

  shape(baseMap,0,0,width,height);
  noStroke(); 
  
  for(int i=0; i<myData.length; i++){
    textMode(MODEL);
    float graphLong = map(float(myData[i][2]), -180, 180, 0, width);
    float graphLat = map(float(myData[i][1]), 90, -90, 0, height);
    float markerSize = (float(myData[i][4]))*(float(myData[i][4]))*(float(myData[i][4]))/30;
    float magnitude = 9;
    
    if(float(myData[i][4])>=magnitude){
      fill(60);
      textFont(f);
      String time = myData[i][0];
      String label = time.substring(0,4) + ": " + myData[i][4];
      text(label, graphLong+markerSize/2+20+4, graphLat + 4);
      noFill();
      stroke(60);
      //fill(0,145,87,80); // green fill for the circles
      fill(155,80,117,85);
      ellipse(graphLong,graphLat,markerSize,markerSize);
      stroke(40); // stroke for the lines
      strokeWeight(0.5);
      line(graphLong+markerSize/2, graphLat, graphLong+markerSize/2+20, graphLat);
    }
    
    if(float(myData[i][4])<magnitude && float(myData[i][4])>8){ // all less than magnitudde
    //fill(77,191,183,60); turquoise
    fill(233,96,38,60);
    stroke(233,96,38,100); 
    ellipse(graphLong,graphLat,markerSize,markerSize);
    }

    if(float(myData[i][4])<8 && float(myData[i][4])>7){ // all less than magnitudde
    fill(192,203,48,60);
    stroke(192,203,48,100); 
    ellipse(graphLong,graphLat,markerSize,markerSize);
    }

    if(float(myData[i][4])<7){ // all less than magnitudde
    fill(247,175,25,60);
    stroke(247,175,25,100); 
    ellipse(graphLong,graphLat,markerSize,markerSize);
    }

  }

  endRecord();
  println("PDF Saved");
}

