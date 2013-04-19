# Anemoi

Anemoiに日本語で天気を聞くと天気予報を教えてくれます。
天気予報は Livedoor Weather Web Service ( [http://weather.livedoor.com/weather_hacks/](http://weather.livedoor.com/weather_hacks/) )からお借りしています。

## Installation

Add this line to your application's Gemfile:

    gem 'anemoi'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install anemoi

## Usage

```
$ anemoi 明日の天気
```

or

```ruby
require 'anemoi'
require 'awesome_print'

ap Anemoi.get_weather('明日の群馬の天気ください')

{
       :specified => {
        :date => :tomorrow,
        :city => {
              :id => 58,
            :name => "前橋"
        }
    },
     :forecastday => :tomorrow,
    :forecastdate => "Sun, 22 Jul 2012 00:00:00 +0900",
             :day => "Sunday",
        :location => {
        :area => "関東",
        :pref => "群馬県",
        :city => "前橋"
    },
         :weather => "曇時々雨",
     :description => "北部では、22日朝まで土砂災害に注意して下さい。群馬県では、22日朝まで濃霧による視程障害に注意して下さい。\n\nオホーツク海高気圧が東日本に張り出しています...",
     :temperature => {
        :max => {
               :celsius => "25",
            :fahrenheit => "77"
        },
        :min => {
               :celsius => "19",
            :fahrenheit => "66.2"
        }
    }
}

ac = Anemoi::Client.new(default_city: "京都")
ap ac.get_weather('明日のお天気お願いします〜〜')

{
       :specified => {
        :date => :tomorrow,
        :city => nil
    },
     :forecastday => :tomorrow,
    :forecastdate => "Sun, 22 Jul 2012 00:00:00 +0900",
             :day => "Sunday",
        :location => {
        :area => "近畿",
        :pref => "京都府",
        :city => "京都"
    },
         :weather => "曇のち雨",
     :description => "京都府では、21日夜遅くまで急な強い雨や落雷に注意して下さい。\n\n近畿地方は、湿った空気の影響で、雲が広がり、中部では非常に激しい雨の降っているところがあ...",
     :temperature => {
        :max => {
               :celsius => "29",
            :fahrenheit => "84.2"
        },
        :min => {
               :celsius => "23",
            :fahrenheit => "73.4"
        }
    }
}
```

Livedoor Weather Web Service に依存しているため、取得できる地域は [RSSフィード一覧](http://weather.livedoor.com/weather_hacks/rss_feed_list.html) の142箇所に限られます。
今日、明日、明後日の３日間に対応。

## Dependency

    gem 'horai'
    gem 'httparty'
    gem 'nokogiri'
