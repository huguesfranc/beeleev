class Pack < ActiveRecord::Base
  KINDS = {
    free_access: {
      value: 1,
      name: 'Free access',
      price_in_cents: 0,
      duration: 1.year,
      connection_demands_per_month: 3
    },
    premium: {
      value: 2,
      name: 'Premium',
      price_in_cents: 25000,
      duration: 1.year,
      connection_demands_per_month: Float::INFINITY
    },
    plus: {
      value: 3,
      name: 'Plus',
      price_in_cents: 35000,
      duration: 1.year,
      connection_demands_per_month: Float::INFINITY
    },
    expert: {
      value: 4,
      name: 'Expert pack',
      price_in_cents: 50000,
      duration: 1.year,
      connection_demands_per_month: Float::INFINITY
    }
  }

  belongs_to :user

  enum kind: KINDS.map { |key, properties| [key, properties[:value]] }.to_h

  def properties
    KINDS[kind.to_s.to_sym]
  end

  def name
    properties[:name]
  end

  def price_in_cents
    properties[:price_in_cents]
  end

  def duration
    properties[:duration]
  end

  def connection_demands_per_month
    properties[:connection_demands_per_month]
  end

  def operating?
    Time.now - created_at <= duration
  end
end
