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
$ gem install tag_logger
```

## Usage
First need to add configuration:
```ruby
TagLogger.configure do |config|
  config.output_path = 'log/tag_logger.log'
  config.filter_parameters = [:password]
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

    # if data has sensitive information, it must be sanitized
    # INFO -- : [tag_name] Log information {:email=>"test@email.com", :password=>"[FILTERED]"}
    data = {email: 'test@email.com', password: '123456'}
    log :info, "Log information #{sanitize_log(data)}"
  end
end
```
