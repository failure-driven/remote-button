#ifndef LED_FLASH_DISPLAY_H_
#define LED_FLASH_DISPLAY_H_

#define ARRAY_SIZE(array) ((sizeof(array))/(sizeof(array[0])))
#include "esp_system.h"
#include <Arduino.h>

#define LED_BUILTIN 2

#define LEDC_CHANNEL_0      0
#define LEDC_TIMER_13_BIT   13
#define LEDC_BASE_FREQ      5000

class LedFlashDisplay {
  private:
    const int flashSlowSequence[2] = {1000, 1000};
    const int flashFastSequence[2] = {100, 100};
    const int flash1Sequence[2] = {100, 1000};
    const int flash2Sequence[4] = {100, 100, 100, 1000};
    const int flash3Sequence[6] = {100, 100, 100, 100, 100, 1000};

    int brightness;
    int fadeAmount;

    bool ledOnOff;
    long lastSwitch;

    int flashSequenceIndex;

  public:
    LedFlashDisplay();
    void setupFlashDisplay();
    void flash1();
    void flash2();
    void flash3();
    void flashSlow();
    void flashFast();
    void pulse();
    void ledcAnalogWrite(uint8_t channel, uint32_t value, uint32_t valueMax = 255);
    void displayLedSequence(int *sequence, int length);
    void changeMode();
};

#endif /* LED_FLASH_DISPLAY_H_ */
