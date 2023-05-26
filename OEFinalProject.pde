import processing.serial.*;
import java.io.File;
import processing.sound.*;
import oscP5.*;
import netP5.*;

PImage centerImage;
PImage sideImages;
PImage siderImages;
SoundFile testMusic;

OscP5 oscP5;
NetAddress chuckAddress;

PImage []chinaimages = new PImage [5];
PImage []medellinimages = new PImage [6];
PImage []purdueimages = new PImage [5];

float tempVar = 0.0;
float imageScaler;
float angle;
float r;
float colorRandomness = random(200);

int goingUp = 1;

final int windowX = 1000;
final int windowY = 1000;

float centerX;
float centerY;
float chinaPercent, indianaPercent, medellinPercent;

int tam;
int frameChecker = 0;
Serial myPort;

int joystickX, joystickY, joystickB;
String joystickReading;

void setup()
{
  //size(1000, 1000);
  fullScreen();
  centerX = width/2.0;
  centerY = height/2.0;

  imageMode(CENTER);
  frameRate(24);
  oscP5 = new OscP5(this, 12000);

  myPort = new Serial(this, Serial.list()[0], 9600);
  myPort.bufferUntil('\n'); 

  createPImages();
  beatHits();
}
void draw()
{
  background(200, 0, 200);
  background(angle*colorRandomness + 100, -colorRandomness*angle, angle*colorRandomness + 100);

  serialEvent(myPort);
  tempVar = map(joystickX, 0, 1023, -1,1);
  if (frameChecker%12 == 0){
   beatHits();
  }
  
  translate(width/2, height/2);
  angle = sin(frameChecker*0.1);
  image(centerImage, 0, 0, map(angle, -1, 1, 400, 800), map(angle, -1, 1, 400, 1000));
  
  //imageScaler = map(angle, -1, 1, 300, 600);
  pushMatrix();
  rotate(2*angle);
  image(sideImages, (centerX/4), (centerY/4));
  image(sideImages, -(centerX/4), (centerY/4));
  image(sideImages, (centerX/4), -(centerY/4));
  image(sideImages, -(centerX/4), -(centerY/4));
  popMatrix();
  
  //imageScaler = map(angle, -1, 1, 400, 500);
  pushMatrix();
  rotate(-3*tempVar);
  image(siderImages, (centerX/3), (centerY/3));
  image(siderImages, -(centerX/3), (centerY/3));
  image(siderImages, (centerX/3), -(centerY/3));
  image(siderImages, -(centerX/3), -(centerY/3));
  popMatrix();



  frameChecker += 1;
  ellipse(joystickX, joystickY, 20, 20);

  //tempVar = map(angle, -1, 1, 0, 1);

}

PImage calculatePImage(){
  if (chinaPercent > 0) {
    r = random(1);
    if (r < chinaPercent) {
      return(chinaimages[int(random(chinaimages.length))]);
    } else {
      return(medellinimages[int(random(medellinimages.length))]);
    }
  } else {
    r = random(1);
    if (r < indianaPercent) {
      return(purdueimages[int(random(purdueimages.length))]);
    } else {
      return(medellinimages[int(random(medellinimages.length))]);
    }
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


void createPImages(){
  for (int i=0; i < chinaimages.length; i++){
    String imageName = "2-" + i+".png"; //image loaders
    chinaimages[i]= loadImage(imageName);
    chinaimages[i].resize(300,0);
    
  }
  
  for (int i=0; i < purdueimages.length; i++){
    String imageName = "0-" + i+".png"; //image loaders
    purdueimages[i]= loadImage(imageName);
    purdueimages[i].resize(300,0);
    
  }
  
    for (int i=0; i < medellinimages.length; i++){
    String imageName = "1-" + i+".png"; //image loaders
    medellinimages[i]= loadImage(imageName);
    medellinimages[i].resize(300,0);
    
  }
}

void beatHits(){
  
    if (tempVar >= 0.5) {
      medellinPercent = (1 - tempVar)*2;
      indianaPercent = 0;
      chinaPercent = 2*(tempVar - 0.5);
    }
    else {
      indianaPercent = 2*abs(0.5 - tempVar);
      medellinPercent = tempVar*2;
      chinaPercent = 0;
    }
    colorRandomness = random(200);
    centerImage = calculatePImage();
    sideImages = calculatePImage();
    siderImages = calculatePImage();  
}
