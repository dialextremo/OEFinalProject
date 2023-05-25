import processing.serial.*;
import java.io.File;
import processing.sound.*;

PImage centerImage;
PImage sideImages;
SoundFile testMusic;

ArrayList<String> chinaImages = new ArrayList<String>();
ArrayList<String> purdueImages = new ArrayList<String>();
ArrayList<String> medellinImages = new ArrayList<String>();

float tempVar = 0.0;
float r;

final int windowX = 1000;
final int windowY = 1000;

float chinaPercent, indianaPercent, medellinPercent;

int readSerial;
int tam;
int frameChecker = 0;
Serial myPort;



void setup()
{
  size(1000, 1000);
  imageMode(CENTER);
  frameRate(24);
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

      println(imageName);
    }
  }
  testMusic = new SoundFile(this, "exSong.mp3");
  testMusic.loop();
}

void draw()
{
  background(64);
  
  /*
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
*/
  if (frameChecker%12 == 0){
    chinaPercent = (tempVar - 100)/100;
    if (tempVar >= 100) {
      medellinPercent = abs(tempVar - 200)/100;
      indianaPercent = 0;
    }
    else {
      indianaPercent = abs(tempVar - 100)/100;
      medellinPercent = tempVar/100;
    }
    centerImage = loadImage(calculatePImage());
    sideImages = loadImage(calculatePImage());
  }

  //centerImage = loadImage(purdueImages.get(int(random(purdueImages.size()))));
  centerImage.resize(((frameChecker%24)*6+600), 0);
  image(centerImage, windowX/2, windowY/2);
  ellipse(tempVar, height/2, 20,20);
  tempVar += 1;
  frameChecker += 1;
}

String calculatePImage(){
  int listGrabber = int(random(2));
  if (chinaPercent > 0) {
    r = random(1);
    if (r < chinaPercent) {
      return(chinaImages.get(listGrabber));
    } else {
      return(medellinImages.get(listGrabber));
    }
  } else if (indianaPercent > 0) {
    r = random(1);
    if (r < indianaPercent) {
      return(purdueImages.get(listGrabber));
    } else {
      return(medellinImages.get(listGrabber));
    }
  } else{
    return(medellinImages.get(listGrabber));
  }
}
