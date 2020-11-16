#ifndef AP_SETUP_H_
#define AP_SETUP_H_

#include <WiFi.h>
#include "esp_system.h"

class ApSetup {
  private:
    String header;
    WiFiServer server;
    char ssid[15] = {0};
    String mac_address;

  public:
    ApSetup();
    String getMacAddress();
    void start();
    void processRequests();
};

#endif /* AP_SETUP_H_ */
