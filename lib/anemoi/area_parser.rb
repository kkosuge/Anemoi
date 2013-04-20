# encoding: utf-8
require 'open-uri'

module Anemoi
  class AreaParser
    AREA_TABLE_URL = "http://weather.livedoor.com/forecast/rss/primary_area.xml"

    CITY_BY_PREF = {
      "北海"   => "札幌",
      "岩手"   => "盛岡",
      "宮城"   => "仙台",
      "茨城"   => "水戸",
      "栃木"   => "宇都宮",
      "群馬"   => "前橋",
      "埼玉"   => "さいたま",
      "神奈川" => "横浜",
      "山梨"   => "甲府",
      "富山"   => "富山",
      "石川"   => "金沢",
      "長野"   => "長野",
      "愛知"   => "名古屋",
      "三重"   => "津",
      "滋賀"   => "大津",
      "兵庫"   => "神戸",
      "島根"   => "松江",
      "香川"   => "高松",
      "愛媛"   => "松山",
      "沖縄"   => "那覇"
    }

    @@pref_regexp = /#{CITY_BY_PREF.keys.join('|')}/

    class << self
      def parse(text)
        text = canonical_city(text)
        info_by_city(city_by_pref(text))
      end

      def city_by_pref(text)
        if city = text.match(@@pref_regexp)
          city = city.values_at(0).first
          text.gsub! city, CITY_BY_PREF[city]
        end
        text
      end

      def info_by_city(text)
        doc = Nokogiri::HTML(open(AREA_TABLE_URL))
        id_by_city = Hash.new
        doc.xpath('//city').each do |node|
          city = node.attributes["title"].value
          id = node.attributes["id"].value
          if text == city
            return { :id => id, :name => city }
          end
          id_by_city[city] = id
        end

        if city = text.match(/#{id_by_city.keys.join('|')}/)
          name = city.values_at(0).first
          return { :id => id_by_city[name], :name => name }
        end
        nil
      end

      def canonical_city(text)
        text = text.gsub("東京都","東京")
        text
      end
    end
  end
end
