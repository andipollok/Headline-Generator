void initDrawing() {

  colorMode(HSB, 360, 100, 100);
  ellipseMode(CENTER);

  fill(0);
  noStroke();

  textFont(myFont);
  textAlign(CENTER, CENTER);
  textSize(60);

  strokeCap(SQUARE);
}

// timestamp
String timestamp() {
  Calendar now = Calendar.getInstance();
  return String.format("%1$ty%1$tm%1$td_%1$tH%1$tM%1$tS", now);
}

