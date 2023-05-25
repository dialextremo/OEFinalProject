import processing.serial.*;
import java.io.File;
import oscP5.*;
import netP5.*;


PImage centerImage;
OscP5 oscP5;
NetAddress chuckAddress;

ArrayList<String> chinaImages = new ArrayList<String>();
ArrayList<String> purdueImages = new ArrayList<String>();
ArrayList<String> medellinImages = new ArrayList<String>();


float tempVar = 0.0;
float r;

final int windowX = 400;
final int windowY = 400;
float chinaPercent, indianaPercent, medellinPercent;

int readSerial;
int tam;
Serial myPort;
float r;


void setup()
{

  size(400, 400);
  imageMode(CENTER);
  /*
  String portName = Serial.list()[0];
  myPort = new Serial(this, portName, 115200);
  */
  for (int i = 0; i < 3; ++i) {
    for (int j = 0; j < 2; ++j) {
      String imageName = i+"-"+j+".png";
      switch (i) {
      case 0:
        chinaImages.add(imageName);
        break;
      case 1:
        medellinImages.add(imageName);
        break;
      case 2:
        purdueImages.add(imageName);
        break;
      }
    }
    oscP5 = new OscP5(this, 12000);
  }
}
void draw()
{
  background(64);
  
  /*
  if (myPort.available()>0)
  {
    readSerial = myPort.read();
    println(readSerial);
    if (readSerial > 10)
    {
      tam = readSerial;
    }
  }

  ellipse(width/2, height/2, tam, tam);
*/

  chinaPercent = (tempVar - 100)/100; // this one is right
  if (tempVar >= 100) {
    medellinPercent = abs(tempVar - 200)/100;
    indianaPercent = 0;
  }
  else {
    indianaPercent = abs(tempVar - 100)/100;
    medellinPercent = tempVar/100;
  }
  calculatePImage(centerImage);

  //centerImage = loadImage(purdueImages.get(int(random(purdueImages.size()))));
  image(centerImage, windowX/2, windowY/2);
  ellipse(tempVar, height/2, 20,20);
  tempVar += 1;
}

void calculatePImage(PImage myImage){
  if (chinaPercent > 0) {
    r = random(1);
    if (r < chinaPercent) {
      myImage = loadImage(chinaImages.get(0));
    } else {
      myImage = loadImage(medellinImages.get(0));
    }
  } else if (indianaPercent > 0) {
    r = random(1);
    if (r < indianaPercent) {
      myImage = loadImage(purdueImages.get(0));
    } else {
      myImage = loadImage(medellinImages.get(0));
    }
  } else{
    myImage = loadImage(medellinImages.get(0));
  }

  //centerImage = loadImage(purdueImages.get(int(random(purdueImages.size()))));
  //image(centerImage, windowX/2, windowY/2);



  //OscMessage message = new OscMessage("/chuck/crossFade");
  //message.add(0.5); // Frecuencia
  //oscP5.send(message, chuckAddress);
  centerImage = myImage;
  
}
