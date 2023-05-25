import java.io.File;
import processing.serial.*;

ArrayList<PImage> chinaImages = new ArrayList<PImage>();
ArrayList<PImage> purdueImages = new ArrayList<PImage>();
ArrayList<PImage> medellinImages = new ArrayList<PImage>();


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
}
