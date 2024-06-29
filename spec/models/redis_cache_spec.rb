# Testing cache behavior, including setting values with expiration and checking for expiration.

require 'rails_helper'

RSpec.describe "Redis Cache", type: :model do
  it "caches values and retrieves them correctly" do
    with_redis do |conn|
      conn.set("cache_key", "cache_value")
      expect(conn.get("cache_key")).to eq("cache_value")
    end
  end

  it "expires cache values" do
    with_redis do |conn|
      conn.set("cache_key", "cache_value", ex: 60) # ex sets expiration time in seconds
      expect(conn.get("cache_key")).to eq("cache_value")

      travel_to 2.minutes.from_now do
        wait_until { with_redis { |c| c.get("cache_key").nil? } }
        expect(with_redis { |c| c.get("cache_key") }).to be_nil
      end
    end
  end
end