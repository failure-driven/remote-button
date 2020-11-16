#include "ApSetup.h"

ApSetup::ApSetup() {
  Serial.print("mac address: ");
  mac_address = getMacAddress();
  Serial.println(mac_address);
  sprintf(ssid, "BUTTON_%s", mac_address.substring(0, 7));
}

String ApSetup::getMacAddress() {
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

void ApSetup::start() {
  WiFi.softAP(ssid);

  IPAddress IP = WiFi.softAPIP();
  Serial.print("AP IP address: ");
  Serial.println(IP);

  server.begin();
}

void ApSetup::processRequests() {
  WiFiClient client = server.available();   // Listen for incoming clients

  if (client) {                             // If a new client connects,
    Serial.println("New Client.");          // print a message out in the serial port
    String currentLine = "";                // make a String to hold incoming data from the client
    while (client.connected()) {            // loop while the client's connected
      if (client.available()) {             // if there's bytes to read from the client,
        char c = client.read();             // read a byte, then
        Serial.write(c);                    // print it out the serial monitor
        header += c;
        if (c == '\n') {                    // if the byte is a newline character
          // if the current line is blank, you got two newline characters in a row.
          // that's the end of the client HTTP request, so send a response:
          if (currentLine.length() == 0) {
            // HTTP headers always start with a response code (e.g. HTTP/1.1 200 OK)
            // and a content-type so the client knows what's coming, then a blank line:
            client.println("HTTP/1.1 200 OK");
            client.println("Content-type:text/html");
            client.println("Connection: close");
            client.println();

            if (header.indexOf("POST /request") >= 0) {
              Serial.println("request");
              Serial.println(header);
            }
            // Display the HTML web page
            client.println("<!DOCTYPE html><html><head>");
            client.println("<title>RemoteButton</title>");
            client.println("<meta name='viewport' content='width=device-width, initial-scale=1'>");
            client.println("<style>html { font-family: Helvetica}");
            client.println(".form-control { width: 100%; padding: 0.375rem 0.75rem; font-size: 1rem; line-height: 1.5;");
            client.println("background-clip: padding-box; border: 1px solid #ced4da; border-radius: 0.25rem; }");
            client.println("label { display: inline-block; margin-bottom: 0.5rem; }");
            client.println("*, *::before, *::after { box-sizing: border-box; }");
            client.println(".form-group { margin-bottom: 1rem; }");
            client.println(".btn-primary { color: #fff; background-color: #007bff; }");
            client.print("</style></head><body><h1>Register Button: ");
            client.print(mac_address);
            client.println("</h1>");
            client.println("<form action='/register' data-remote='true' method='post'>");
            client.println("<div class='form-group'><label for='button_email'>Email</label>");
            client.println("<input class='form-control' type='text' name='button[email]'/></div>");
            client.println("<div class='form-group'>");
            client.println("<label for='button_site'>Site</label>");
            client.println("<input class='form-control' type='text' name='button[site]'/></div>");
            client.println("<p>Home WiFi</p>");
            client.println("<div class='form-group'><label for='button_ssid'>SSID</label>");
            client.println("<input class='form-control' type='text' name='button[ssid]'/> </div>");
            client.println("<div class='form-group'><label for='button_password'>Password</label>");
            client.println("<input class='form-control' type='text' name='button[password]'/></div>");
            client.println("<input type='submit' name='commit' value='register' class='btn btn-primary form-control'/>");
            client.println("</form></main></body></html>");

            // The HTTP response ends with another blank line
            client.println();
            // Break out of the while loop
            break;
          } else { // if you got a newline, then clear currentLine
            currentLine = "";
          }
        } else if (c != '\r') {  // if you got anything else but a carriage return character,
          currentLine += c;      // add it to the end of the currentLine
        }
      }
    }
    // Clear the header variable
    header = "";
    // Close the connection
    client.stop();
    Serial.println("Client disconnected.");
    Serial.println("");
  }
}
