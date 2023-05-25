

import processing.serial.*;

PImage centerImage;

ArrayList<String> chinaImages = new ArrayList<PImage>();
ArrayList<String> purdueImages = new ArrayList<String>();
ArrayList<String> medellinImages = new ArrayList<String>();

import java.io.File;
import processing.serial.*;

float chinaPercent, indianaPercent, medellinPercent;


int readSerial;
int tam;
Serial myPort;



void setup()
{
  size(400, 400);
  String portName = Serial.list()[0];
  myPort = new Serial(this, portName, 115200);
  for (int i = 0; i < 3; ++i) {
    for (int j = 0; j < 2; ++j) {
    String imageName = i+"-"+j;
    chinaImages.add(imageName);
    println(imageName);
    }
  }
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
}
