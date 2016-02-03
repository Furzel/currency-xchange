class Calculation < ActiveRecord::Base
  belongs_to :user

  @@available_currencies = 
  ["AUD", "BGN", "BRL", "CAD", "CHF", "CNY", "CZK", "DKK", "EUR", "GBP",
   "HKD", "HRK", "HUF", "IDR", "ILS", "INR","JPY", "KRW", "MXN", "MYR",
   "NOK", "NZD", "PHP", "PLN", "RON", "RUB", "SEK", "SGD", "THB", "TRY", "USD", "ZAR"]

  validates :base_currency, inclusion: {in: @@available_currencies}
  validates :target_currency, inclusion: {in: @@available_currencies}
  validates :amount, presence: true
  validates :nb_weeks, presence: true
  validates :user_id, presence: true

  def table_weekly_rates
    rates = self.daily_rates_for_weeks
    weekly_rates = rates.keys.map do |week_number|
      weekly_rate = rates[week_number].inject(0) { |sum, daily_rates| sum + daily_rates[self.target_currency] }
      weekly_rate /= rates[week_number].length 

      {
       "week" => (week_number + self.nb_weeks) % 53,
       "rate" => weekly_rate,
       "sum" => self.amount * weekly_rate,
       "profit" => weekly_rate > 1.0 ? (weekly_rate - 1) * 100 : nil,
       "loss" => weekly_rate < 1.0 ? (1 - weekly_rate) * 100 : nil,
       "rank" => nil
      }
    end

    rank = 0

    weekly_rates.sort_by { |week| -week["sum"] }
                .first(3)
                .each { |week| week["rank"] = rank = rank + 1 }

    return weekly_rates
  end

  def daily_rates_for_weeks
    day = self.first_day_of_data_range
    daily_rates_for_weeks = {}
    # fetch from DB or API all the daily rates for the time range
    while day < self.first_day_of_creation_week do
      week = get_week(day)
      daily_rates = DailyCurrencyRate.fetch_by_currency_date(self.base_currency,  day)
      if daily_rates_for_weeks[week]
        daily_rates_for_weeks[week].push(daily_rates)
      else
        daily_rates_for_weeks[week] = [daily_rates]
      end

      day += 1.days
    end
    return daily_rates_for_weeks
  end

  def first_day_of_creation_week
    @first_day_of_creation_week ||= self.updated_at.to_date.beginning_of_week - 1.days # beginning of the week is monday, we need sunday
  end

  def first_day_of_data_range
    @first_day_of_data_range ||= self.first_day_of_creation_week - self.nb_weeks.weeks
  end

  def last_day_of_previsional_range
    @last_day_of_previsional_range ||= self.first_day_of_creation_week + self.nb_weeks.weeks
  end

  private 
    def get_week(day)
      week_number = day.strftime("%U").to_i
      week_number = 52 if week_number == 0
      return week_number
    end
end
