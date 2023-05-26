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

float centerX = windowX/2.0;
float centerY = windowY/2.0;
float chinaPercent, indianaPercent, medellinPercent;

int tam;
int frameChecker = 0;
Serial myPort;

int joystickX, joystickY, joystickB;
String joystickReading;

void setup()
{
  size(1000, 1000);

  imageMode(CENTER);
  frameRate(12);
  oscP5 = new OscP5(this, 12000);
  /*
  String portName = Serial.list()[0];
  myPort = new Serial(this, portName, 115200);
  */

  //myPort = new Serial(this, Serial.list()[0], 9600);
  //myPort.bufferUntil('\n'); 

  createPImages();

}
void draw()
{

  background((frameChecker*20)+colorRandomness, abs((frameChecker*5)-colorRandomness), (frameChecker*3)+colorRandomness);
  
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
*/

  if (frameChecker%12 == 0){
    beatHits();
  }
  translate(centerX, centerY);
  angle = sin(frameChecker*0.1);
  image(centerImage, 0, 0, map(angle, -1, 1, 400, 1000), map(angle, -1, 1, 400, 1000));
  
  imageScaler = map(angle, -1, 1, 300, 800);
  pushMatrix();
  rotate(2*tempVar);
  //scale(((tempVar%50)+0.1)/100, 1);
  //tint((((frameChecker%6)*8)+colorRandomness), abs(((frameChecker%40)*5)-colorRandomness), ((frameChecker%13)*3)+colorRandomness, 80);
  image(sideImages, (centerX/4), (centerY/4), imageScaler, imageScaler);
  image(sideImages, -(centerX/4), (centerY/4), imageScaler, imageScaler);
  image(sideImages, (centerX/4), -(centerY/4), imageScaler, imageScaler);
  image(sideImages, -(centerX/4), -(centerY/4), imageScaler, imageScaler);
  popMatrix();
  
  imageScaler = map(angle, -1, 1, 400, 1200);
  pushMatrix();
  rotate(-3*tempVar);
  //tint((((frameChecker%4)*12)+colorRandomness), abs(((frameChecker%14)*8)-colorRandomness), ((frameChecker%13)*3)+colorRandomness, 70);
  image(siderImages, (centerX/3), (centerY/3), imageScaler, imageScaler);
  image(siderImages, -(centerX/3), (centerY/3), imageScaler, imageScaler);
  image(siderImages, (centerX/3), -(centerY/3), imageScaler, imageScaler);
  image(siderImages, -(centerX/3), -(centerY/3), imageScaler, imageScaler);
  popMatrix();


  if (frameChecker == 0){
   goingUp = 1;
  }
  else if (frameChecker == 12) {
    goingUp = -1;
  }
  frameChecker += goingUp;

  //ellipse(joystickX, joystickY, 20,20);

  tempVar = map(angle, -1, 1, 0, 1);

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
    
  }
  
  for (int i=0; i < purdueimages.length; i++){
    String imageName = "0-" + i+".png"; //image loaders
    purdueimages[i]= loadImage(imageName);
    
  }
  
    for (int i=0; i < medellinimages.length; i++){
    String imageName = "1-" + i+".png"; //image loaders
    medellinimages[i]= loadImage(imageName);
    
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
