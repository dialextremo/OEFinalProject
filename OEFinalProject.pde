

import processing.serial.*;

PImage centerImage;

ArrayList<String> chinaImages = new ArrayList<String>();
ArrayList<String> purdueImages = new ArrayList<String>();
ArrayList<String> medellinImages = new ArrayList<String>();

final int windowX = 400;
final int windowY = 400;

import java.io.File;
import processing.serial.*;

float chinaPercent, indianaPercent, medellinPercent;


int readSerial;
int tam;
Serial myPort;

void setup()
{
  size(400, 400);
  imageMode(CENTER);

  String portName = Serial.list()[0];
  myPort = new Serial(this, portName, 115200);
  chinaImages.add("amogus.png");
  purdueImages.add("spiderman.png");
  medellinImages.add("flags.png");


}

void draw()
{
  background(64);
  if (myPort.available()>0)
  {
    readSerial = myPort.read();
    println(readSerial);
    if (readSerial>10)
    {
      tam=readSerial;
    }
  }
  ellipse(width/2, height/2, tam, tam);
  
  chinaPercent = (tam - 100)/100;
  indianaPercent = abs(tam - 200)/100;
  medellinPercent = (tam + 100)/100;
  
  
  
  centerImage = loadImage(purdueImages.get(int(random(purdueImages.size()))));
  image(centerImage, windowX/2, windowY/2);
  
  
  
  
  
  
}
