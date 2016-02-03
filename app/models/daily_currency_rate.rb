require "http"

class DailyCurrencyRate < ActiveRecord::Base

  validates :day, presence: true
  validates :currency, presence: true
  validates :rates, presence: true

  serialize :rates, Hash

  def self.fetch_by_currency_date(currency, date)
    daily_currency_rate = DailyCurrencyRate.find_by(currency: currency, day: date)
    
    # rates already exists in DB
    return daily_currency_rate.rates if !daily_currency_rate.nil?

    # fetch rates from API
    url = "http://api.fixer.io/" + date.strftime("%Y-%m-%d") + "?base=" + currency

    # @TODO: check if JSON.parse can fail / how it fails 
    fixer_json = JSON.parse HTTP.get(url).to_s
    rates = fixer_json["rates"]

    daily_currency_rate = DailyCurrencyRate.new(currency: currency, day: date, rates: rates)

    daily_currency_rate.save

    return daily_currency_rate.rates
  end
end
