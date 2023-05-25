import processing.serial.*;
public class SonicA {

  private int read;
  private Serial myPort;
  private String portName;
  public SonicA(PApplet p)
  {
    String portName = Serial.list()[0];
    myPort = new Serial(p, portName, 115200);
  }

  public int readSerial() {
    if (myPort.available()>0)
    {
      read = myPort.read();
      println(read);
      if (readSerial>10)
      {
        return read;
      }
    }return 0;
  }
}
