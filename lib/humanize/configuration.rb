module Humanize

  class << self
    attr_accessor :conf
  end

  def self.configure
    self.conf ||= Configuration.new
    yield(conf) if block_given?
  end

  class Configuration
    attr_accessor :language,
                  :rounding

    def initialize
      @language = :fr
      @rounding = 2
    end
  end
end