require 'tag_logger/helper_logger'
require 'tag_logger/configuration'

module TagLogger
  FILTERED_TEXT = '[FILTERED]'.freeze

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

  def sanitize_log(data)
    raise '`sanitize_log` only for Hash' unless data.is_a?(Hash)

    filter_parameters = TagLogger.configuration.filter_parameters
    filter_parameters.each do |key|
      next if data[key].nil?
      data[key] = FILTERED_TEXT
    end

    data
  end
end
