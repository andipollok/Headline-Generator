import rita.*;

import processing.pdf.*;

import java.io.*;  
import javax.print.*;  
import javax.print.attribute.*;   
import javax.print.attribute.standard.*;  
import java.net.MalformedURLException;
import java.util.Calendar;
import java.util.Map;
import java.util.Iterator;

RiGrammar grammar;
PFont myFont;

String templateFile = "template.txt";
String dataFile = "data.txt";

String PDFFileName = "";

String[] databaseFiles = {
};
String databaseFilesLocation = "words";

String[] backgrounds = { 
  "background1.svg",
  "background2.svg",
  "background3.svg"
};
String backgroundFilesLocation = "backgrounds";

PShape[] backgroundShapes;
int currentBackground = 0;

boolean savePDF = false;
boolean printPDF = false;
String filename = timestamp();
int filenameCounterTIF = 0;
int filenameCounterPDF = 0;

Line[] lines;
float lineheightBase = 150;
float lineheight;

void setup()
{
  //  String[] fontList = PFont.list(); 
  //  println(fontList);

  size(600, 800);

  myFont = createFont("KTF-Roadbrush", 40);

  initDrawing();

  lines = new Line[0];

  backgroundShapes = new PShape[backgrounds.length];
  for (int i=0; i<backgrounds.length;i++) {
    backgroundShapes[i] = loadShape(backgroundFilesLocation + "/" + backgrounds[i]);
  }

  loadDataFiles();

  generateNewText();
}

void draw()
{

  if (savePDF) {  
    PDFFileName = "screenshots/"+filename+"_"+nf(filenameCounterPDF, 4)+".pdf";
    beginRecord(PDF, PDFFileName);
    println("Recording PDF: "+PDFFileName);
    initDrawing();
  }
  background(0, 0, 100);

  shape(backgroundShapes[currentBackground], 0, 0, width, height);

  for (int i=0; i<lines.length;i++) {
    lines[i].render();
  }

  if (savePDF) {
    endRecord();
    print("PDF recording finished.");
    savePDF = false;
    saveFrame("screenshots/"+filename+"_"+nf(filenameCounterPDF, 4)+".tif");
    filenameCounterPDF++;
    stroke(0, 100, 100);
    noFill();
    strokeWeight(2);
    rect(0, 0, width, height);
    if (printPDF) printPDF(PDFFileName);
  }
}

void generateNewText()
{ 

  loadDataFiles();

  String result = grammar.expand();
  String[] linesString = result.split("%");

  lines = new Line[0]; // delete old lines

  for (int i=0; i<min(linesString.length,5);i++) {
    if (!linesString[i].contains("X")) {
      Line newLine = new Line();
      lines = (Line[]) append(lines, newLine);
      lines[lines.length-1].number = lines.length-1;
      lines[lines.length-1].update(linesString[i].toUpperCase());
    }
  }

  if (lines.length > 4) lineheight = lineheightBase*0.85;
  else if (lines.length < 4) lineheight = lineheightBase*1.05;
  else lineheight = lineheightBase;
  
  for (int i=0; i<lines.length; i++) {
    lines[i].calculatePosition();
  }

  currentBackground = int(random(0, backgroundShapes.length));
}

void keyPressed() {
  if (key == ' ') generateNewText();
  if (key == 's' || key == 'S') { 
    savePDF = true;
  }
  if (key == 'p' || key == 'P') { 
    savePDF = true;
    printPDF = true;
  }
}

void mousePressed() {
  loop();
}

void printPDF(String filename) {
  
  println("Printing "+filename);
  
  PrintService defaultPrintService = PrintServiceLookup.lookupDefaultPrintService();  
  DocPrintJob printerJob = defaultPrintService.createPrintJob();  
  File pdfFile = new File(sketchPath(filename));  
  SimpleDoc simpleDoc = null;  

  try {  
    simpleDoc = new SimpleDoc(pdfFile.toURL(), DocFlavor.URL.AUTOSENSE, null);
  } 
  catch (MalformedURLException ex) {  
    ex.printStackTrace();
  }  
  try {  
    printerJob.print(simpleDoc, null);
  } 
  catch (PrintException ex) {
    ex.printStackTrace();
  }
}

String pluralize (String str) {
   return str + "s"; 
}
