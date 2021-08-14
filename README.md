<h1 align="center">Remote Button</h1>

<div align="center">

[![CircleCI](https://circleci.com/gh/failure-driven/remote-button.svg?style=svg)](https://circleci.com/gh/failure-driven/remote-button)

</div>

For every home needs at least 1 internet connected button.

# TL;DR

```
make
make setup
make build
```

```
rails server
bin/webpack-dev-server
sidekiq -q mailers -q default
open http://localhost:3000
```

## Next Steps

- [./SETUP_INSTRUCTIONS.md](./SETUP_INSTRUCTIONS.md)
- [./TODO.md](./TODO.md)
- [./USER_STORIES.md](./USER_STORIES.md)

## Arduino/ESP32

Arduino for familiarity but ESP32 in reality as needs WiFi.

[arduino_button/arduino_button.ino](arduino_button/arduino_button.ino)

can connect via serial monitor or

```
screen /dev/cu.SLAB_USBtoUART 115200
```

**Note:** _exit screen typing `CTRL-A CTRL-\`_

and on reset be told the mac address of the attached ESP32

```
Remote Button
mac address: 7C:9E:BD:07:43:F4
```

## Docker

somewhat experimental ...

```
docker build .
# or
docker-compose build

docker-compose up
# brings up web/postgres/webpack/webdriver-chrome

# update yarn fingerprint which is different on local vs docker
docker-compose run --rm web yarn
# and run db migrations
docker-compose run --rm web bin/rails db:create db:migrate

# now hit the dev server
http://0.0.0.0:3000/software_buttons/new

# or run the specs
docker-compose exec web bundle exec rspec
# TODO which currently errors with
#   Errno::ENOENT:
#     No such file or directory - --product-version

# and view the specs with VNC on localhost:5900

# use VNC localhost:5900 to view the site in Docker
-> right click Desktop -> Application -> Network -> Chrome Browser
got to http://172.19.0.1:3000/
and    http://172.19.0.1:3000/software_buttons/new
```

**Note:** currently after running rails the yarn integrity check is out :( should work out how to keep the integrity separate for the dockerized web.

## Original Rails README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

- Ruby version

- System dependencies

- Configuration

- Database creation

- Database initialization

- How to run the test suite

- Services (job queues, cache servers, search engines, etc.)

- Deployment instructions

- ...
