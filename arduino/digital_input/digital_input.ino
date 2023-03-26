int irPin = 2;

// the setup routine runs once when you press reset:
void setup() {
  // initialize serial communication at 9600 bits per second:
  Serial.begin(9600);
  // make the irPin's pin an input:
  pinMode(irPin, INPUT);
}

// the loop routine runs over and over again forever:
void loop() {
  // read the input pin:
  int irState = digitalRead(irPin);
  // print out the state of the button:
  Serial.println(irState);
  delay(100);  // delay in between reads for stability
}
