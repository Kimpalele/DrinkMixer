
const int vodka = 2;    //vodka
const int cranberry = 3;    //cranberry
const int redbull = 4;    //redbull
const int sprite = 5;    //etc
const int gin = 6;
const int juice = 7;
const int six = 12000; //12 sec for 6 cL
const int eight = 16000; //16 sec for 8 cL

int timeBetweenPours = 500;

void MixDrink(int booze, int dilution, int strength){

  digitalWrite(booze, HIGH);
  delay(strength);            
  digitalWrite(booze, LOW);
  delay(timeBetweenPours);
  digitalWrite(dilution, HIGH);
  delay((strength * 2) + 8000);             
  digitalWrite(dilution, LOW);

}

//shorter time for demo purposes
void CleanSpecific(int pump){
  digitalWrite(pump, HIGH);
  delay(6000);
  digitalWrite(pump, LOW);
  delay(timeBetweenPours);
}

//shorter time for demo purposes
void CleanAll(){
  digitalWrite(vodka, HIGH);
  delay(20000);
  digitalWrite(vodka, LOW);
  delay(timeBetweenPours);

  digitalWrite(cranberry, HIGH);
  delay(20000);
  digitalWrite(cranberry, LOW);
  delay(timeBetweenPours);

  digitalWrite(redbull, HIGH);
  delay(20000);
  digitalWrite(redbull, LOW);
  delay(timeBetweenPours);

  digitalWrite(sprite, HIGH);
  delay(20000);
  digitalWrite(sprite, LOW);
  delay(timeBetweenPours);

  digitalWrite(gin, HIGH);
  delay(20000);
  digitalWrite(gin, LOW);
  delay(timeBetweenPours);

  digitalWrite(juice, HIGH);
  delay(20000);
  digitalWrite(juice, LOW);
}
