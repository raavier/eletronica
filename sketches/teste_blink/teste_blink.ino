// Teste básico: pisca o LED da placa (pino 13) e manda mensagens pela serial.
// Se o LED piscar e o monitor serial mostrar "tick N", placa + upload estão OK.

const int LED = LED_BUILTIN;  // pino 13 no Uno/Nano
unsigned long contador = 0;

void setup() {
  pinMode(LED, OUTPUT);
  Serial.begin(9600);
  Serial.println("Arduino vivo!");
}

void loop() {
  digitalWrite(LED, HIGH);
  delay(500);
  digitalWrite(LED, LOW);
  delay(500);
  Serial.print("tick ");
  Serial.println(contador++);
}
