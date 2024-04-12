// This code is for the ESP32 microcontroller. It generates a PWM signal with a frequency for concept testing.
// The code is based on the example code provided by the ESP32 Arduino library.


#include <Arduino.h>

int freq = 10; // Change this value to change the frequency of the PWM signal
int dutyCycle = 50; // Change this value to change the duty cycle of the PWM signal
const int outputPin = 2;
const int channel = 0;
const int resolution = 8;



void setup() {
ledcSetup(channel, freq, resolution);
ledcAttachPin(outputPin, channel);
ledcWrite(channel, dutyCycle);  
}

void loop() {
}
