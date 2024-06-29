require 'rails_helper'

RSpec.describe "Redis Connection Pool", type: :model do
  it "maintains a stable connection pool" do
		with_redis do |conn| 
			pool = REDIS.size
			expect(pool.size).to be >= 5
		end
  end
end
