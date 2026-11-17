// Sensor de estacionamento — HC-SR04 + 3 LEDs + buzzer
// Versão inicial (exatamente como veio do planejamento).

const int TRIG = 9, ECHO = 10, BUZZER = 8;
const int VERDE = 2, AMARELO = 3, VERMELHO = 4;

void setup() {
  pinMode(TRIG, OUTPUT); pinMode(ECHO, INPUT);
  pinMode(VERDE, OUTPUT); pinMode(AMARELO, OUTPUT); pinMode(VERMELHO, OUTPUT);
  Serial.begin(9600);
}

long medirCm() {
  digitalWrite(TRIG, LOW);  delayMicroseconds(2);
  digitalWrite(TRIG, HIGH); delayMicroseconds(10);
  digitalWrite(TRIG, LOW);
  long t = pulseIn(ECHO, HIGH, 30000);   // 0 = nada à frente
  return t * 0.034 / 2;
}

void loop() {
  long cm = medirCm();
  Serial.println(cm);
  digitalWrite(VERDE, LOW); digitalWrite(AMARELO, LOW); digitalWrite(VERMELHO, LOW);

  if (cm == 0 || cm > 30) {
    digitalWrite(VERDE, HIGH); noTone(BUZZER); delay(100);
  } else if (cm > 15) {
    digitalWrite(AMARELO, HIGH); tone(BUZZER, 1500, 80); delay(400);
  } else if (cm > 5) {
    digitalWrite(VERMELHO, HIGH); tone(BUZZER, 1500, 80); delay(150);
  } else {
    digitalWrite(VERMELHO, HIGH); tone(BUZZER, 1500); delay(50);
  }
}
