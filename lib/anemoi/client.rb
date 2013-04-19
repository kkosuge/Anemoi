# encoding: utf-8

module Anemoi
  class Client
    include HTTParty

    WEATHER_URL    = "http://weather.livedoor.com/forecast/webservice/json/v1"

    def initialize(options={})
      options[:default_city] ||= "東京"
      @default_city = AreaParser.parse(options[:default_city])
      @default_date = options[:default_date] || :today
    end

    def get_weather(text, opts = {})
      specified_city = AreaParser.parse(text)
      specified_date = horai_date_parse(text)
      city  = specified_city || @default_city
      date  = specified_date || @default_date
      query = { :city => city[:id] }.merge(opts)
      hash  = get WEATHER_URL, :query => query
      hash_by_date = case date
                     when :tomorrow then hash["forecasts"].values_at(1)
                     when :day_after_tomorrow then hash["forecasts"].values_at(2)
                     else hash["forecasts"].values_at(0)
                     end.first

      {
        :specified => {
          :date => specified_date,
          :city => specified_city
        },
        :forecastday  => date,
        :forecastdate => hash["publicTime"],
        :day          => hash_by_date["date"],
        :location     => hash["location"],
        :weather      => hash_by_date["telop"],
        :description  => hash["description"]["text"],
        :temperature  => hash_by_date["temperature"]
      }.deep_symbolize_keys
    rescue
      nil
    end

    def horai_date_parse(text)
      @jajp ||= Horai::JaJP.new
      date = @jajp.parse(text)
      now = Date.today
      case date
      when now + 0; :today
      when now + 1; :tomorrow
      when now + 2; :day_after_tomorrow
      else nil
      end
    end

    private

    # use HTTParty.get
    def get(*args)
      self.class.get(*args)
    end
  end
end
