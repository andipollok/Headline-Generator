class Line {
  String str;
  float textsize;
  color textcolor;
  float linewidth;
  float xPos, yPos;
  boolean important;
  float rotation;
  int number;

  Line () {
    update("");
  }

  void update(String _str) {

    str = _str;

    textsize = random(135, 150);
    textcolor = color(0);
    
    important = false;

    if (random(1)>0.8) { // bigger text and red
      important = true;
    }

    linewidth = textWidth (str);
    textSize(textsize);
    while (textWidth (str) > width*0.85) { // fit it into width
      textsize--;
      linewidth = textWidth (str);
      textSize(textsize);
    }

    rotation = random(radians(-4), radians(4));
    
  }
  
  void calculatePosition() {
    xPos = random(-30,10);
    yPos = -lineheight*(lines.length+1)/2+(lineheight*(number+1)) - height*0.05;
  }

  void render() {

    noStroke();
    fill(textcolor);
    textSize(textsize);

    pushMatrix();
    translate(width/2 + xPos, height/2 + yPos);
    rotate(rotation);

    text(str, 0, 0);

    if (important) { // underline for text
      stroke(0);
      //if (important) stroke(0, 100, 100);
      strokeWeight(15);
      line(-textWidth(str)/2*0.9, textsize*0.4+10, textWidth(str)/2, textsize*0.4*0.95+10);
    }

    popMatrix();
  }
}

