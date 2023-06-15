//2000 mS ≈ 1 cL
//relayPin 1 = arduinoPin 2
//. . . . .
//relayPin 6 = arduinoPin 7

#include "functions.h"

void setup() {
  Serial.begin(9600);

  while (!Serial) {
    ; // wait for serial port to connect. Needed for native USB port only
  }

  pinMode(vodka, OUTPUT); 
  pinMode(cranberry, OUTPUT); 
  pinMode(redbull, OUTPUT);
  pinMode(sprite, OUTPUT);
  pinMode(gin, OUTPUT);
  pinMode(juice, OUTPUT);

  //Make sure all pumps are off, current relay board is "high true".  
  digitalWrite(vodka,LOW);
  digitalWrite(cranberry,LOW);
  digitalWrite(redbull,LOW);
  digitalWrite(sprite,LOW);
  digitalWrite(gin,LOW);
  digitalWrite(juice,LOW);

}

void loop() { // run over and over
  
  if(Serial.available()){ //Checks if we got any input

    //Reads the received string and adds it into our string to be compared
    String drink = Serial.readString(); 

    //We have to remove the trailing newline for the comparison to work
    //We could add \n to every string comparison but this is better
    drink.trim();
    
    if (drink == "vodkacranberry6"){
      MixDrink(vodka, cranberry, six);
    } else if (drink == "redbull6"){
      MixDrink(vodka, redbull, six);
    } else if (drink == "screwdriver6"){
      MixDrink(vodka, juice, six);
    } else if (drink == "ginsprite6"){
      MixDrink(gin, sprite, six);
    } else if (drink == "vodkasprite6"){
      MixDrink(vodka, sprite, six);
    } else if (drink == "gincranberry6"){
      MixDrink(gin, cranberry, six);
    } else if (drink == "vodkacranberry8"){
      MixDrink(vodka, cranberry, eight);
    } else if (drink == "redbull8"){
      MixDrink(vodka, redbull, eight);
    } else if (drink == "screwdriver8"){
      MixDrink(vodka, juice, eight);
    } else if (drink == "ginsprite8"){
      MixDrink(gin, sprite, eight);
    } else if (drink == "vodkasprite8"){
      MixDrink(vodka, sprite, eight);
    } else if (drink == "gincranberry8"){
      MixDrink(gin, cranberry, eight);
    } else if (drink == "ginjuice6") {
      MixDrink(gin, juice, six);
    } else if (drink == "ginjuice8") {
      MixDrink(gin, juice, eight);
    } else if (drink == "1") {
      CleanSpecific(vodka);
    } else if (drink == "2") {
      CleanSpecific(cranberry);
    } else if (drink == "3") {
      CleanSpecific(redbull);
    } else if (drink == "4") {
      CleanSpecific(sprite);
    } else if (drink == "5") {
      CleanSpecific(gin);
    } else if (drink == "6") {
      CleanSpecific(juice);
    } else if (drink == "10") {
      CleanAll();
    } else {
      Serial.println("Unrecognizeable string ! ! !");
    }
    
    //Some trailing whitespace are interfering with some of the comparisons
    //So we flush the serial port to get rid of it
    Serial.flush();      
  }

}


