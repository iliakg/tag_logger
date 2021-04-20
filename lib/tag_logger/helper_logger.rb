module TagLogger
  class HelperLogger
    attr_reader :tag_id, :tags, :path_logger, :stdout_logger

    def initialize(tags = [])
      raise 'TagLogger configuration is nil!' if TagLogger.configuration.nil?

      @tag_id = rand(36**8).to_s(36)
      @tags = tags

      output_path = TagLogger.configuration.output_path
      use_stdout = TagLogger.configuration.use_stdout

      unless output_path.nil? || output_path.empty?
        @path_logger ||= Logger.new(output_path)
        path_logger.formatter = log_format
      end

      if TagLogger.configuration.use_stdout == true
        @stdout_logger ||= Logger.new(STDOUT)
        stdout_logger.formatter = log_format
      end

      raise 'TagLogger output is blank!' if path_logger.nil? && stdout_logger.nil?
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

      logger_class.log(path_logger, log_text) if path_logger
      logger_class.log(stdout_logger, log_text) if stdout_logger
    end

    private

    def prepared_text(text)
      return text if tags.empty?

      ''.tap do |s|
        tags.each do |t|
          s << ("[#{t}]" + ' ')
          s << text if tags.last == t
        end
      end
    end

    def log_format
      proc do |severity, time, _program_name, message|
        "#{time.utc.iso8601(3)} ##{Process.pid} TID-#{Thread.current.object_id.to_s(36)} TAG-#{tag_id} #{severity}: #{message}\n"
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
