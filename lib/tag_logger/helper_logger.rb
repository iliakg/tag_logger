module TagLogger
  class HelperLogger
    attr_reader :tags, :logger

    def initialize(tags)
      if tags.empty?
        raise 'Tags for `tag_logger` are empty!'
      else
        @tags = tags
      end

      if TagLogger.configuration&.output_path.blank?
        raise 'TagLogger configuration `output_path` is blank!'
      else
        @logger ||= Logger.new(TagLogger.configuration.output_path)
      end
    end

    def write_log(type, text)
      types = {
        warn: WarnLogger,
        info: InfoLogger,
        debug: DebugLogger,
        fatal: FatalLogger,
        error: ErrorLogger
      }

      log_text = prepared_text(text)
      logger_class = types.fetch(type)
      logger_class.log(logger, log_text)
    end

    private

    def prepared_text(text)
      ''.tap do |s|
        tags.each do |t|
          s << ("[#{t}]" + ' ')
          s << text if tags.last == t
        end
      end
    end

    class ErrorLogger
      def self.log(logger, text)
        logger.error(text)
      end
    end

    class InfoLogger
      def self.log(logger, text)
        logger.info(text)
      end
    end

    class WarnLogger
      def self.log(logger, text)
        logger.warn(text)
      end
    end

    class DebugLogger
      def self.log(logger, text)
        logger.debug(text)
      end
    end

    class FatalLogger
      def self.log(logger, text)
        logger.fatal(text)
      end
    end
  end
end
