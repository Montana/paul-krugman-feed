# Paul Krugman RSS Feed 
![Krugman](krugman.jpg)
>Economist Paul Krugman's feed in RSS format.

# Usage 

Just start a rack server: 

```bash
bundle install
bundle exec rackup -p 9292 config.ru &
open http://localhost:9292/feed.rss
``` 

This will display economist Paul Krugman's feed in RSS. 

https://en.wikipedia.org/wiki/Paul_Krugman

# Changelog 

* Added "The Krugman Build" (just a Travis CI instance) 
* Updated by Montana Mendy for current working use (Oct, 2020) 
