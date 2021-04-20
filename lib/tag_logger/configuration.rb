module TagLogger
  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration)
  end

  class Configuration
    attr_accessor :output_path, :use_stdout, :filter_parameters

    def initialize
      @filter_parameters = Array.new
    end
  end
end
