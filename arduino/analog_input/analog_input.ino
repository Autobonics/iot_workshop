int ledPin = 13;
int ldrPin = 35;

void setup()
{
  Serial.begin(9600);
  pinMode(ledPin, OUTPUT);
  pinMode(ldrPin, INPUT);
}

void loop()
{
  int ldrValue = analogRead(ldrPin);
  Serial.println(ldrValue);
  if(ldrValue < 500){
   digitalWrite(ledPin, HIGH);
  } else {
   digitalWrite(ledPin, LOW);
  }
}