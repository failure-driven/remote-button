/*
  Remote Button

  https://github.com/failure-driven/remote-button

  Copyright (c) Michael Milewski <saramic@gmail.com>
  Copyright (c) Bence Fulop <fbence90@gmail.com>
  Copyright (c) Lily Tan <lilyt2995@gmail.com>
  Copyright (c) Mathieu Longe <mathieu.longe@orange.fr>
*/

#include "esp_system.h"

String getMacAddress() {
  uint8_t baseMac[6];
  // Get MAC address for WiFi station
  esp_read_mac(baseMac, ESP_MAC_WIFI_STA);
  char baseMacChr[18] = {0};
  sprintf(
    baseMacChr,
    "%02X:%02X:%02X:%02X:%02X:%02X",
    baseMac[0],
    baseMac[1],
    baseMac[2],
    baseMac[3],
    baseMac[4],
    baseMac[5]
  );
  return String(baseMacChr);
}

void setup() {
  Serial.begin(115200);
  Serial.println("Remote Button");
  Serial.print("mac address: ");
  Serial.println(getMacAddress());
}

void loop() {
}
