# Paul Krugman RSS Feed 
![Krugman](krugman.jpg)
>Economist Paul Krugman's feed in RSS format.

# Usage 

Just start a rack server, the rack server isn't apart of this repo, but you can easily set it up via putting this into your `Gemfile`:

```ruby
gem 'rack'
gem 'puma' # You can use webrick or another server if you prefer
```

Create a basic rack app:

```ruby
require 'rack'

app (etc etc)
```

Then run:

```bash
rackup -p 9292
```
Then you'll see: 

```bash
[2024-07-30 12:00:00] INFO  WEBrick 1.4.2
[2024-07-30 12:00:00] INFO  ruby 3.1.2 (2023-04-23) [x86_64-linux]
[2024-07-30 12:00:00] INFO  WEBrick::HTTPServer#start: pid=12345 port=9292
``` 
This will display economist Paul Krugman's feed in RSS. 

https://en.wikipedia.org/wiki/Paul_Krugman

# Changelog 

* Added "The Krugman Build" (just a Travis CI instance) 
* Updated by Montana Mendy for current working use (Oct, 2020) 

## Krugman's Past Predicitions

![image](https://github.com/user-attachments/assets/69a2ca86-9d7a-4be3-8b8e-d87d28403631)
