//Code for master module//

#include <ESP8266WiFi.h>  
#include <string.h>               
#include <FirebaseArduino.h>      
#define FIREBASE_HOST "icu-monitor-a5719-default-rtdb.firebaseio.com"      
#define FIREBASE_AUTH "Fld8iF6gLwkNdSZGf98PqEEDHYtrjXld5ikCMsDO"            
#define WIFI_SSID "STUDBME2"                                  
#define WIFI_PASSWORD "BME2Stud"


int LEDP = 16;
int LEDT = 5;
int h=0;
int  n=33;
int t=0;


void setup() {

  Serial.begin(9600); // Default baud rate of the Bluetooth module
  
pinMode(LEDP, OUTPUT);

pinMode(LEDT, OUTPUT);
 WiFi.begin(WIFI_SSID, WIFI_PASSWORD);                                  
  while (WiFi.status() != WL_CONNECTED) {
    Serial.print("Connecting");    
    delay(500);
  }
   
  Serial.println();
  Serial.print("Connected");
  Serial.print("IP Address: ");
  Serial.println(WiFi.localIP());                               //prints local IP address
  Firebase.begin(FIREBASE_HOST, FIREBASE_AUTH);                 // connect to the firebase

//  Firebase.set("status",0); 
}
void loop() {
   n=Firebase.getInt("/control/state"); 
  Serial.print("Here");   
  Serial.print(F("status "));
  Serial.println(n);  
  if (n==1) { 
   Serial.write("1");
   digitalWrite(LEDP, HIGH); // turn the LED on
delay(1000); // wait for a second
digitalWrite(LEDP, LOW); // turn the LED off
delay(1000); // wait for a second
     
  }  
    else if(n==2){
       Serial.write("0");
   digitalWrite(LEDT, HIGH); // turn the LED on
delay(1000); // wait for a second
digitalWrite(LEDT, LOW); // turn the LED off
delay(1000); // wait for a second
     
  }

   if(Serial.available() > 0){     // Checks whether data is comming from the serial port

   delay(1000);  
   h= Serial.read(); // Reads the data from the serial port and store it in dataFromSlave variable
   Firebase.setFloat("/ICU/ROOMS/0/patients/0/pressure",h);
   t= Serial.read();
   Firebase.setFloat("/ICU/ROOMS/0/patients/0/temp",t);
  Serial.print(F(" Humidity: "));
  Serial.println(h);
  Serial.print(F("%  Temperature: "));
  Serial.println(t);   
       
   if (Firebase.failed()) 
    {
      Serial.print("pushing /logs failed:");
      Serial.println(Firebase.error()); 
  }  
 }

  
  
  
 }
//}
