
import processing.serial.*;
import java.io.File;



ArrayList<PImage> chinaImages = new ArrayList<PImage>();
ArrayList<PImage> purdueImages = new ArrayList<PImage>();
ArrayList<PImage> medellinImages = new ArrayList<PImage>();


int readSerial;
int tam;
SonicA myPort;

void setup()
{
  size(400, 400);

  myPort = new SonicA(this);
 

}

void draw()
{
  background(64);
  tam= myPort.readSerial();
  ellipse(width/2, height/2, tam, tam);
}
