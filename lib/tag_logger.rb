require 'tag_logger/helper_logger'
require 'tag_logger/configuration'

module TagLogger
  FILTERED_TEXT = '[FILTERED]'.freeze

  def tag_logger(*tags)
    @tag_logger ||= HelperLogger.new(tags)
  end

  def log(type, text)
    tag_logger if @tag_logger.nil?

    @tag_logger.write_log(type, text)
  end

  def sanitize_log(data)
    data = data.to_hash.transform_keys(&:to_sym)

    filter_parameters = TagLogger.configuration.filter_parameters
    filter_parameters.each do |key|
      next if data[key.to_sym].nil?
      data[key.to_sym] = FILTERED_TEXT
    end

    data
  end
end
