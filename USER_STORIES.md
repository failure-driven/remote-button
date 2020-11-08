# User Stories

## Hardware

- assuming an ESP32 with an RGB LED and a push button and "the code
  loaded"

- STATE 1 - Setup
  - light flashing (1 way)
  - WiFi AP "REMOTE-BUTTON-123"
  - connect phone to AP and browse to any site
  - a setup page is presented asking for
    - access point:
    - password:
    - SUBMIT
  - write access point and password to EEPROM
  - -> move to STATE 2
- STATE 2 - WiFi connect
  - ligth flashing (a different way)
  - attempt to connect
  - if connected -> move to STATE 3
  - if cannot connect flash light to show trying again
  - if SWITCH 1 reset -> move to STATE 1
- STATE 3 - Register
  - connect to the master site
  - register with a unique id
  - light flashing (3rd way)
- User visits "new button registered" page
  - name button
  - name is sent to button -> move to STATE 4
- STATE 4 - active
  - wait for command
  - button press -> move to STATE 5
  - server sends command - move to STATE 6
- STATE 5 - button pressed
  - gather any timer data
  - send to server -> move to STATE 4
- STATE 6 - command received
  - perform acetion -> light color or flashing
  - start timer
  - -> move to STATE 4

