require 'tag_logger/helper_logger'
require 'tag_logger/configuration'

module TagLogger
  def tag_logger(*tags)
    @tag_logger ||= HelperLogger.new(tags)
  end

  def log(type, text)
    if @tag_logger.nil?
      raise 'Initialize `tag_logger` method with tags name'
    else
      @tag_logger.write_log(type, text)
    end
  end
end
