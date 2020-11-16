#include "LedFlashDisplay.h"

LedFlashDisplay::LedFlashDisplay() {
  brightness = 0;
  fadeAmount = 5;
  ledOnOff = true;
  lastSwitch = 0;
  flashSequenceIndex = 0;
}

void LedFlashDisplay::setupFlashDisplay() {
  ledcSetup(LEDC_CHANNEL_0, LEDC_BASE_FREQ, LEDC_TIMER_13_BIT);
  ledcAttachPin(LED_BUILTIN, LEDC_CHANNEL_0);
}
void LedFlashDisplay::flash1() {
  displayLedSequence((int*)&flash1Sequence, ARRAY_SIZE(flash1Sequence));
}
void LedFlashDisplay::flash2() {
  displayLedSequence((int*)&flash2Sequence, ARRAY_SIZE(flash2Sequence));
}
void LedFlashDisplay::flash3() {
  displayLedSequence((int*)&flash3Sequence, ARRAY_SIZE(flash3Sequence));
}
void LedFlashDisplay::flashSlow() {
  displayLedSequence((int*)&flashSlowSequence, ARRAY_SIZE(flashSlowSequence));
}
void LedFlashDisplay::flashFast() {
  displayLedSequence((int*)&flashFastSequence, ARRAY_SIZE(flashFastSequence));
}
void LedFlashDisplay::pulse() {
  ledcAnalogWrite(LEDC_CHANNEL_0, brightness);
  brightness = brightness + fadeAmount;
  if (brightness <= 0 || brightness >= 255) {
    fadeAmount = -fadeAmount;
  }
}

// Arduino like analogWrite
// value has to be between 0 and valueMax
void LedFlashDisplay::ledcAnalogWrite(uint8_t channel, uint32_t value, uint32_t valueMax /* =255 */) {
  // calculate duty, 8191 from 2 ^ 13 - 1
  uint32_t duty = (8191 / valueMax) * min(value, valueMax);

  // write duty to LEDC
  ledcWrite(channel, duty);
}

void LedFlashDisplay::displayLedSequence(int *sequence, int length) {
  if (millis() - lastSwitch > sequence[flashSequenceIndex]) {
    ledOnOff = !ledOnOff;
    //    digitalWrite(LED_BUILTIN, ledOnOff ? HIGH : LOW);
    ledcAnalogWrite(LEDC_CHANNEL_0, ledOnOff ? 255 : 0);
    lastSwitch = millis();
    flashSequenceIndex = (flashSequenceIndex + 1) % length;
  }
}

void LedFlashDisplay::changeMode() {
  ledOnOff = true;
  flashSequenceIndex = 0;
}
