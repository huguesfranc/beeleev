class Pack < ActiveRecord::Base
  KINDS = {
    free_access: {
      value: 1,
      name: 'Free access',
      price_in_cents: 0,
      duration: 1.year,
      connection_credits: 0,
      connection_demands_per_month: 3
    },
    premium: {
      value: 2,
      name: 'Premium',
      price_in_cents: 29900,
      duration: 1.year,
      connection_credits: 4,
      connection_demands_per_month: Float::INFINITY
    },
    plus: {
      value: 3,
      name: 'Plus',
      price_in_cents: 35900,
      duration: 1.year,
      connection_credits: 4,
      connection_demands_per_month: Float::INFINITY
    },
    expert: {
      value: 4,
      name: 'Expert pack',
      price_in_cents: 59900,
      duration: 1.year,
      connection_credits: 0,
      connection_demands_per_month: Float::INFINITY
    }
  }

  belongs_to :user

  enum kind: KINDS.map { |key, properties| [key, properties[:value]] }.to_h

  before_save :create_connection_credits, on: :create

  def properties
    KINDS[kind.to_s.to_sym]
  end

  [
    :name,
    :price_in_cents,
    :duration,
    :connection_demands_per_month,
    :connection_credits
  ].each { |property| define_method(property) { properties[property] } }

  def operating?
    Time.zone.now - updated_at <= duration
  end

  protected

  def create_connection_credits
    in_one_year = Time.zone.now + 1.year
    connection_credits.times { user.connection_credits.create expires_on: in_one_year }
  end
end
