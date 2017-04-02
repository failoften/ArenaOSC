/**
 * oscP5sendreceive by andreas schlegel
 * example shows how to send and receive osc messages.
 * oscP5 website at http://www.sojamo.de/oscP5
 */

import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress myRemoteLocation;

String clipNum;

void setup() {
  size(400, 400);
  frameRate(25);


  /* create a new osc properties object */
  OscProperties properties = new OscProperties();

  /* set a default NetAddress. sending osc messages with no NetAddress parameter 
   * in oscP5.send() will be sent to the default NetAddress.
   */
  properties.setRemoteAddress("127.0.0.1", 7000);

  /* the port number you are listening for incoming osc packets. */
  properties.setListeningPort(7001);


  /* Send Receive Same Port is an option where the sending and receiving port are the same.
   * this is sometimes necessary for example when sending osc packets to supercolider server.
   * while both port numbers are the same, the receiver can simply send an osc packet back to
   * the host and port the message came from.
   */
  properties.setSRSP(OscProperties.OFF);

  /* set the datagram byte buffer size. this can be useful when you send/receive
   * huge amounts of data, but keep in mind, that UDP is limited to 64k
   */
  properties.setDatagramSize(1024);

  /* initialize oscP5 with our osc properties */
  oscP5 = new OscP5(this, properties);    


  /* print your osc properties */
  println(properties.toString());

  background(0);
}


void draw() {
  //somethin'
}


void oscEvent(OscMessage theOscMessage) {


  if (theOscMessage.checkAddrPattern("/layer1/clip16/audio/beatmark/direction")==true) {

    String firstValue = theOscMessage.get(0).stringValue();
    String secondValue = theOscMessage.get(1).stringValue();
    // String thirdValue = theOscMessage.get(2).stringValue();

    //println(theOscMessage.addrPattern());

    println(" values: "+firstValue+", "+secondValue);

    clip = "14";

    /* SET CLIP */
    OscMessage myMessage = new OscMessage("/layer2/clip" + clipNum + "/connect");

    /* add an int to the osc message */
    myMessage.add(1); 

    /* send the message */
    oscP5.send(myMessage);

    return;
  }
} 

