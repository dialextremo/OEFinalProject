

ArrayList<PImage> chinaImages = new ArrayList<PImage>();
ArrayList<PImage> purdueImages = new ArrayList<PImage>();
ArrayList<PImage> medellinImages = new ArrayList<PImage>();

String[] filenames;
String fullPath = "C:/Users/Garrett Rodgers/Pictures/backgrounds";

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
