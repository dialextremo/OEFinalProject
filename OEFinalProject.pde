import processing.serial.*;

int readSerial;
int tam;
char myKey;
int op =0;
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
    //map (lecturaUltrasonido, 0,20,20,200);
    println(readSerial);

    if (readSerial>100)
    {
      tam=readSerial;
    } else { 
      op= readSerial;
      println("OP= "+op);
    }
  }
  ellipse(width/2, height/2, tam, tam);
}