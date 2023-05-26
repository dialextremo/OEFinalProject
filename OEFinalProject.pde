import processing.serial.*;
import java.io.File;
import processing.sound.*;

PImage centerImage;
PImage sideImages;
PImage siderImages;
SoundFile testMusic;

import oscP5.*;
import netP5.*;


OscP5 oscP5;
NetAddress chuckAddress;

ArrayList<String> chinaImages = new ArrayList<String>();
ArrayList<String> purdueImages = new ArrayList<String>();
ArrayList<String> medellinImages = new ArrayList<String>();

float tempVar = 0.0;
float r;
float colorRandomness = random(200);

int goingUp = 1;


final int windowX = 1000;
final int windowY = 1000;

float centerX = windowX/2.0;
float centerY = windowY/2.0;
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
    for (int j = 0; j < 3; ++j) {
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
  testMusic = new SoundFile(this, "exSong.mp3");
  testMusic.loop();
}
void draw()
{
  background(((frameChecker%10)*20)+colorRandomness, abs(((frameChecker%70)*5)-colorRandomness), ((frameChecker%40)*3)+colorRandomness);
  
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
  if (frameChecker%48 == 0){
    chinaPercent = (tempVar - 100)/100;
    if (tempVar >= 100) {
      medellinPercent = abs(tempVar - 200)/100;
      indianaPercent = 0;
    }
    else {
      indianaPercent = abs(tempVar - 100)/100;
      medellinPercent = tempVar/100;
    }
    colorRandomness = random(200);
    centerImage = loadImage(calculatePImage());
    sideImages = loadImage(calculatePImage());
    siderImages = loadImage(calculatePImage());
  }

  //centerImage = loadImage(purdueImages.get(int(random(purdueImages.size()))));
  centerImage.resize(((frameChecker%12)*12+int(centerX*2)), 0);
  sideImages.resize(((-frameChecker%12)*12+int(centerX)), 0);
  siderImages.resize(((frameChecker%12)*12+int(centerX*1.5)), 0);
  
  translate(centerX, centerY);
  
  tint(((255 - (frameChecker%10)*20)+colorRandomness), 255 - abs(((frameChecker%70)*5)-colorRandomness), 255 - ((frameChecker%40)*3)+colorRandomness, 80);
  rotate(-0.1*tempVar);
  image(centerImage, 0, 0);
  rotate(0.2*tempVar);
  scale(((tempVar%12)+0.1)/12, 1);
  tint((((frameChecker%6)*8)+colorRandomness), abs(((frameChecker%40)*5)-colorRandomness), ((frameChecker%13)*3)+colorRandomness, 80);
  image(sideImages,(windowX/4), (windowY/4));
  image(sideImages, -(windowX/4), (windowY/4));
  image(sideImages, (windowX/4), -(windowY/4));
  image(sideImages, -(windowX/4), -(windowY/4));
  scale(12/((tempVar%12)+0.1), 1);
  rotate(-0.3*tempVar);
  tint((((frameChecker%4)*12)+colorRandomness), abs(((frameChecker%14)*8)-colorRandomness), ((frameChecker%13)*3)+colorRandomness, 70);
  image(siderImages, (windowX/3), (windowY/3));
  image(siderImages, -(windowX/3), (windowY/3));
  image(siderImages, (windowX/3), -(windowY/3));
  image(siderImages, -(windowX/3), -(windowY/3));

  tempVar += 1;
  if (frameChecker == 0){
   goingUp = 1;
  }
  else if (frameChecker == 12) {
    goingUp = -1;
  }
  frameChecker += goingUp;
    
}

String calculatePImage(){
  int listGrabber = int(random(3));
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



  //OscMessage message = new OscMessage("/chuck/crossFade");
  //message.add(0.5); // Frecuencia
  //oscP5.send(message, chuckAddress);

}
