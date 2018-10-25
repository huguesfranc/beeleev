# == Schema Information
#
# Table name: packs
#
#  id               :integer          not null, primary key
#  user_id          :integer
#  stripe_charge_id :integer
#  kind             :integer
#  created_at       :datetime
#  updated_at       :datetime
#

class Pack < ActiveRecord::Base
  LAUNCHING_OFFER_LIMIT_DATE = Time.zone.parse '2018-05-09 15:00:00'

  KINDS = {
    free_access: {
      value: 1,
      name: 'Free access',
      price_in_cents: 0,
      deleted_price_in_cents: 0,
      duration: 1.year,
      connection_credits: 0,
      connection_demands_per_month: Float::INFINITY
    },
    premium: {
      value: 2,
      name: 'Premium',
      price_in_cents: 42900,
      deleted_price_in_cents: 42900,
      duration: 1.year,
      connection_credits: 4,
      connection_demands_per_month: Float::INFINITY
    },
    plus: {
      value: 3,
      name: 'Business',
      price_in_cents: 209900,
      deleted_price_in_cents: 53900,
      duration: 1.year,
      connection_credits: 50,
      connection_demands_per_month: Float::INFINITY
    },
    expert: {
      value: 4,
      name: 'Expert pack',
      price_in_cents: 82900,
      deleted_price_in_cents: 82900,
      duration: 1.year,
      connection_credits: 0,
      connection_demands_per_month: 0
    }
  }

  belongs_to :user

  enum kind: KINDS.map { |key, properties| [key, properties[:value]] }.to_h

  class << self
    KINDS.each { |kind, _| define_method(kind) { |options = {}| new options.merge(kind: kind) } }
  end

  before_save :create_connection_credits

  def properties
    KINDS[kind.to_s.to_sym]
  end

  [
    :name,
    :duration,
    :deleted_price_in_cents,
    :connection_demands_per_month,
    :connection_credits
  ].each { |property| define_method(property) { properties[property] } }

  def operating?
    Time.zone.now - updated_at <= duration
  end

  def reduction_in_cents
    return 0 unless user.present? && user.eligible_for_pack_launching_offer?

    case :"#{kind}"
    when :premium
      6400
    when :plus
      7000
    else
      0
    end
  end

  def price_in_cents
    properties[:price_in_cents] - reduction_in_cents
  end

  def price
    price = price_in_cents.to_f/100.0
    floor_price = price.floor

    if floor_price != price
      printf "%.2f", price_in_cents.to_f/100.0
    else
      floor_price.to_s
    end
  end

  def deleted_price
    deleted_price = deleted_price_in_cents.to_f/100.0
    floor_deleted_price = deleted_price.floor

    if floor_deleted_price != deleted_price
      printf "%.2f", deleted_price_in_cents.to_f/100.0
    else
      floor_deleted_price.to_s
    end
  end

  def money
    Money.new price_in_cents, 'usd'
  end

  def euro_money
    MoneyService.update_rates
    money.exchange_to 'eur'
  end

  protected

  def create_connection_credits
    in_one_year = Time.zone.now + 1.year
    connection_credits.times { user.connection_credits.create expires_on: in_one_year }
  end
end
