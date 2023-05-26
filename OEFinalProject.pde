import processing.serial.*;
import java.io.File;
import processing.sound.*;
import oscP5.*;
import netP5.*;

PImage centerImage;
PImage sideImages;
SoundFile testMusic;

OscP5 oscP5;
NetAddress chuckAddress;

ArrayList<String> chinaImages = new ArrayList<String>();
ArrayList<String> purdueImages = new ArrayList<String>();
ArrayList<String> medellinImages = new ArrayList<String>();


float r;

final int windowX = 1000;
final int windowY = 1000;

float chinaPercent, indianaPercent, medellinPercent;

int tam;
int frameChecker = 0;
Serial myPort;
float tempVar = 0.0;
int joystickX, joystickY, joystickB;
String joystickReading;

void setup()
{
  size(1000, 1000);

  imageMode(CENTER);
  frameRate(24);

   myPort = new Serial(this, Serial.list()[0], 9600);
  myPort.bufferUntil('\n'); 

  getImages();


  oscP5 = new OscP5(this, 12000);
  testMusic = new SoundFile(this, "exSong.mp3");
  testMusic.loop();
}
void draw()
{
  background(64);

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

  ellipse(joystickX, joystickY, 20,20);

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

  //OscMessage message = new OscMessage("/chuck/crossFade");
  //message.add(0.5); // Frecuencia
  //oscP5.send(message, chuckAddress);

}

void serialEvent( Serial myPort) 
{
  // read the data until the newline n appears
  joystickReading = myPort.readStringUntil('\n');
  
  if (joystickReading != null)
  {
        joystickReading = trim(joystickReading);
        
    // break up the decimal and new line reading
    int[] vals = int(splitTokens(joystickReading, ","));
    
    // we assign to variables
    joystickX = vals[0];
    joystickY= vals[1] ;
    joystickB= vals[2];

  }
}  
void getImages()
{

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
  }
}