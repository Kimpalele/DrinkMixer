
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
  for (int i = 2; i < 8; i++) {
    digitalWrite(i, HIGH);
    delay(15000);
    digitalWrite(i, LOW);
    delay(timeBetweenPours);
  }
}
