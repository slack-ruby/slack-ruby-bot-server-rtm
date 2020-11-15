Slack Ruby Bot Server RealTime (RTM) Extension
==============================================

[![Gem Version](https://badge.fury.io/rb/slack-ruby-bot-server-rtm.svg)](https://badge.fury.io/rb/slack-ruby-bot-server-rtm)
[![Build Status](https://travis-ci.org/slack-ruby/slack-ruby-bot-server-rtm.svg?branch=master)](https://travis-ci.org/slack-ruby/slack-ruby-bot-server-rtm)

An extension to [slack-ruby-bot-server](https://github.com/slack-ruby/slack-ruby-bot-server) that makes it easy to implement Slack RTM bots.

### Samples

You can use one of the [sample applications](sample_apps) that use MongoDB or ActiveRecord to bootstrap your project and start adding slack command handlers on top of this code.

### Usage

#### Gemfile

Add 'slack-ruby-bot-server-rtm' to Gemfile.

```ruby
gem 'slack-ruby-bot-server-rtm'
```

#### Configure

```ruby
SlackRubyBotServer::RealTime.configure do |config|
  config.server_class = ...
end
```

The following settings are supported.

setting               | description
----------------------|------------------------------------------------------------------
server_class          | Handler class for additional events.

##### Server Class

You can override the server class to handle additional events, and configure the service to use it.

```ruby
class MyServer < SlackRubyBotServer::Server
  on :hello do |client, data|
    # connected to Slack
  end

  on :channel_joined do |client, data|
    # the bot joined a channel in data.channel['id']
  end
end

SlackRubyBotServer::RealTime.configure do |config|
  config.server_class = MyServer
end
```

### Copyright & License

Copyright [Daniel Doubrovkine](http://code.dblock.org) and Contributors, 2020

[MIT License](LICENSE)
