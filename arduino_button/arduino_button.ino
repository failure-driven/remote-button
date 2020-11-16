/*
  Remote Button

  https://github.com/failure-driven/remote-button

  Copyright (c) Michael Milewski <saramic@gmail.com>
  Copyright (c) Bence Fulop <fbence90@gmail.com>
  Copyright (c) Lily Tan <lilyt2995@gmail.com>
  Copyright (c) Mathieu Longe <mathieu.longe@orange.fr>
*/

enum {
  FLASH_1,    // FRESH,
  FLASH_2,    // REGISTER,
  FLASH_3,    // REGISTERING,
  FLASH_FAST, // ERROR,
  FLASH_SLOW, // REGISTERED,
  PULSE,      // READY
} mode;

#include "LedFlashDisplay.h"
#include "ApSetup.h"

LedFlashDisplay led_flash_display;
ApSetup ap_setup;

int lastModeChangeTime = 0;
const int modeChangeTime = 5000;

// demo to switch between flashing modes every 5 seconds
// in future modes will be switched between by actual actions
void changeMode() {
  if (millis() - lastModeChangeTime > modeChangeTime) {
    led_flash_display.changeMode();

    switch (mode) {
      case FLASH_1:
        mode = FLASH_2;
        break;
      case FLASH_2:
        mode = FLASH_3;
        break;
      case FLASH_3:
        mode = FLASH_SLOW;
        break;
      case FLASH_SLOW:
        mode = FLASH_FAST;
        break;
      case FLASH_FAST:
        mode = PULSE;
        break;
      case PULSE:
        mode = FLASH_1;
        break;
    }
    lastModeChangeTime = millis();
  }
}

void displayLed() {
  switch (mode) {
    case FLASH_1:
      led_flash_display.flash1();
      break;
    case FLASH_2:
      led_flash_display.flash2();
      break;
    case FLASH_3:
      led_flash_display.flash3();
      break;
    case FLASH_SLOW:
      led_flash_display.flashSlow();
      break;
    case FLASH_FAST:
      led_flash_display.flashFast();
      break;
    case PULSE:
      led_flash_display.pulse();
      break;
  }
}

void setup() {
  Serial.begin(115200);
  Serial.println("Remote Button");

  led_flash_display.setupFlashDisplay();
  ap_setup.start();
}

void loop() {
  ap_setup.processRequests();
  displayLed();
  changeMode();
  delay(20);
}
