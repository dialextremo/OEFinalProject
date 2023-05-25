
import processing.serial.*;

PImage centerImage;

ArrayList<String> chinaImages = new ArrayList<String>();
ArrayList<String> purdueImages = new ArrayList<String>();
ArrayList<String> medellinImages = new ArrayList<String>();

float chinaPercent, indianaPercent, medellinPercent;

int chinaSize = chinaImages.size();

int readSerial;
int tam;
Serial myPort;

void setup()
{
  size(400, 400);

  String portName = Serial.list()[0];
  myPort = new Serial(this, portName, 115200);


}

void draw()
{
  background(64);
  tam= myPort.readSerial();
  ellipse(width/2, height/2, tam, tam);
  
  chinaPercent = (tam - 100)/100;
  indianaPercent = abs(tam - 200)/100;
  medellinPercent = (tam + 100)/100
  
  
  
}
