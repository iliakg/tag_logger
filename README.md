TagLogger
===========

TagLogger is a simple tool for tag logging.

## Installation
Add this line to your application's Gemfile:
```ruby
gem 'tag_logger'
```

Or install it yourself as:
```bash
$ gem install sample_filter
```

## Usage
First need to add configuration:
```ruby
TagLogger.configure do |config|
  config.output_path = 'log/tag_logger.log'
end
```

and then use logger:
```ruby
class MyClass
  include TagLogger

  def my_method
    # start logging with tags
    tag_logger 'tag_name'

    # then log with levels: [:warn, :info, :debug, :fatal, :error]
    log :info, 'Log information'
  end
end
```
