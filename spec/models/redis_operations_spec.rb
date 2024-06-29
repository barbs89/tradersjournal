# Testing basic Redis operations, including setting, getting, and deleting keys.

require 'rails_helper'

RSpec.describe "Redis Operations", type: :model do
  it "allows setting and getting values" do
		with_redis do |conn|
			conn.set("test_key", "test_value")
			expect(conn.get("test_key")).to eq("test_value")
		end
  end

  it "allows deleting keys" do
		with_redis do |conn|
			conn.set("test_key", "test_value")
			conn.del("test_key")
			expect(conn.get("test_key")).to be_nil
		end
  end
end
