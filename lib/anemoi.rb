require "httparty"
require "horai"
require "date"

require "anemoi/version"
require "anemoi/hash"
require "anemoi/area_parser"
require "anemoi/client"

module Anemoi
  def self.get_weather(text)
    @@instance ||= Client.new
    @@instance.get_weather(text)
  end
end
