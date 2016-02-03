class DailyCurrencyRate < ActiveRecord::Base

  validates :day, presence: true
  validates :currency, presence: true

  def self.fetch_by_currency_date(currency, date)
    {"USD" => 1.5 - rand}
  end
end
