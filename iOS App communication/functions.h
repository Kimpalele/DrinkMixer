
const int pump1 = 2;    //VODKA
const int pump2 = 3;    //CRANBERRY
const int pump3 = 4;    //REDBULL
const int pump4 = 5;    //etc
const int pump5 = 6;
const int pump6 = 7;

int TimeBetweenPours = 500;

//shorter time for demo purposes
void VodkaCranberry(){
  digitalWrite(pump1, HIGH);
  delay(4000);
  digitalWrite(pump1, LOW);
  delay(TimeBetweenPours);
  digitalWrite(pump2, HIGH);
  delay(8000);
  digitalWrite(pump2, LOW);
}

//shorter time for demo purposes
void VodkaRedbull(){
  digitalWrite(pump1, HIGH);
  delay(4000);
  digitalWrite(pump1, LOW);
  delay(TimeBetweenPours);
  digitalWrite(pump3, HIGH);
  delay(8000);
  digitalWrite(pump3, LOW);
}

//shorter time for demo purposes
void Screwdriver(){
  digitalWrite(pump1, HIGH);
  delay(4000);
  digitalWrite(pump1, LOW);
  delay(TimeBetweenPours);
  digitalWrite(pump4, HIGH);
  delay(8000);
  digitalWrite(pump4, LOW);
}

//shorter time for demo purposes
void prepareSpecific(int pump){

  digitalWrite(pump, HIGH);
  delay(3000);
  digitalWrite(pump, LOW);
  delay(TimeBetweenPours);
}

//shorter time for demo purposes
void prepareAll(){

  digitalWrite(pump1, HIGH);
  delay(2000);
  digitalWrite(pump1, LOW);
  delay(TimeBetweenPours);

  digitalWrite(pump2, HIGH);
  delay(2000);
  digitalWrite(pump2, LOW);
  delay(TimeBetweenPours);

  digitalWrite(pump3, HIGH);
  delay(2000);
  digitalWrite(pump3, LOW);
  delay(TimeBetweenPours);

  digitalWrite(pump4, HIGH);
  delay(2000);
  digitalWrite(pump4, LOW);
  delay(TimeBetweenPours);

  digitalWrite(pump5, HIGH);
  delay(2000);
  digitalWrite(pump5, LOW);
  delay(TimeBetweenPours);

  digitalWrite(pump6, HIGH);
  delay(2000);
  digitalWrite(pump6, LOW);
}
//shorter time for demo purposes
void Cleaning(){
  digitalWrite(pump1, HIGH);
  delay(2000);
  digitalWrite(pump1, LOW);
  delay(TimeBetweenPours);

  digitalWrite(pump2, HIGH);
  delay(2000);
  digitalWrite(pump2, LOW);
  delay(TimeBetweenPours);

  digitalWrite(pump3, HIGH);
  delay(2000);
  digitalWrite(pump3, LOW);
  delay(TimeBetweenPours);

  digitalWrite(pump4, HIGH);
  delay(2000);
  digitalWrite(pump4, LOW);
  delay(TimeBetweenPours);

  digitalWrite(pump5, HIGH);
  delay(2000);
  digitalWrite(pump5, LOW);
  delay(TimeBetweenPours);

  digitalWrite(pump6, HIGH);
  delay(2000);
  digitalWrite(pump6, LOW);
}