
#include "functions.h"

void setup() {
  Serial.begin(9600);

  while (!Serial) {
    ; // wait for serial port to connect. Needed for native USB port only
  }

  pinMode(pump1, OUTPUT); 
  pinMode(pump2, OUTPUT); 
  pinMode(pump3, OUTPUT);
  pinMode(pump4, OUTPUT);
  pinMode(pump5, OUTPUT);
  pinMode(pump6, OUTPUT);

  //Make sure all pumps are off, current relay board is "high true".  
  digitalWrite(pump1,LOW);
  digitalWrite(pump2,LOW);
  digitalWrite(pump3,LOW);
  digitalWrite(pump4,LOW);
  digitalWrite(pump5,LOW);
  digitalWrite(pump6,LOW);

}

void loop() { // run over and over
  
  if(Serial.available()){ //Checks if we got any input

      //Reads the received string and adds it into our string to be compared
      String drink = Serial.readString(); 

      //We have to remove the trailing newline for the comparison to work
      //We could add \n to every string comparison but this is better
      drink.trim();
      
      if (drink == "Cranberry"){
        VodkaCranberry();
        Serial.println(drink);
      } else if (drink == "Redbull"){
        //VodkaRedbull();
        Serial.println(drink);
      } else if (drink == "Screwdriver"){
        //Screwdriver();
      } else if (drink == "Pump1"){
        //prepareSpecific(pump1);
        Serial.println("Done");
      } else if (drink == "Pump2"){
        //prepareSpecific(pump2);
        Serial.println("Done");
      } else if (drink == "Pump3"){
        //prepareSpecific(pump3);
        Serial.println("Done");
      } else if (drink == "Pump4"){
        //prepareSpecific(pump4);
        Serial.println("Done");
      } else if (drink == "Pump5"){
        //prepareSpecific(pump5);
        Serial.println("Done");
      } else if (drink == "Pump6"){
        //prepareSpecific(pump6);
        Serial.println("Done");
      } else if (drink == "prepareAll") {
        //prepareAll();
        Serial.println("Done");
      } else if (drink == "cleanAll") {
        //Cleaning();
        Serial.println("Done");
      } else {
        Serial.println("Unrecognizeable string ! ! !");
      }
      
    //Some trailing whitespace are interfering with some of the comparisons
    //So we flush the serial port to get rid of it
    Serial.flush();      
  }

}


