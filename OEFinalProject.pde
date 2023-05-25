
import processing.serial.*;


PImage amogus = loadImage("amogus.png");
PImage spiderman = loadImage("spiderman.png");
PImage flags = loadImage("flags.png");

ArrayList<PImage> chinaImages = new ArrayList<PImage>();
ArrayList<PImage> purdueImages = new ArrayList<PImage>();
ArrayList<PImage> medellinImages = new ArrayList<PImage>();

int chinaSize = chinaImages.size();



int readSerial;
int tam;
SonicA myPort;

void setup()
{
  size(400, 400);

  String portName = Serial.list()[0];
  myPort = new Serial(this, portName, 115200);
  chinaImages.add(amogus);
  purdueImages.add(spiderman);
  medellinImages.add(flags);
   

}

void draw()
{
  background(64);
  tam= myPort.readSerial();
  ellipse(width/2, height/2, tam, tam);
  if (tam > 66){
    image(chinaImages<random(chinaImages.size())>, 200, 200);
  }
}
