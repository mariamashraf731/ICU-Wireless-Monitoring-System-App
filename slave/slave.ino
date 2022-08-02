//Code for Slave module//

#define ledPin 13
#include "DHT.h"

#define DHTPIN 5     // Digital pin connected to the DHT sensor
#define DHTTYPE DHT11   // DHT 11
DHT dht(DHTPIN, DHTTYPE);
//#define slaveSwitchPin 7
int dataFromMaster = 0;

void setup() {
  pinMode(ledPin, OUTPUT);
  digitalWrite(ledPin, LOW);
//  pinMode(slaveSwitchPin, INPUT);
//  digitalWrite(slaveSwitchPin,LOW);
  Serial.begin(9600); // Default baud rate of the Bluetooth module
  dht.begin();
}
void loop() {
  delay(1000);
  int h = dht.readHumidity();
  int t = dht.readTemperature();
  Serial.write(h);
  Serial.write(t);
  //Serial.print(F(" Humidity: "));
  //Serial.println(h);
  //Serial.print(F("%  Temperature: "));
  //Serial.println(t);
  

 if(Serial.available() > 0){ // Checks whether data is comming from the serial port
   dataFromMaster = Serial.read(); // Reads the data from the serial port and store it in dataFromMaster variable   
 }
 //Serial.print(F(" dataFromMaster "));
 //Serial.println(dataFromMaster);
 // Controlling the led
 if (dataFromMaster == 0) {
  
  digitalWrite(ledPin, HIGH); // LED ON
  
 }
 else {
  digitalWrite(ledPin, LOW); // LED    OFF
 }
}
