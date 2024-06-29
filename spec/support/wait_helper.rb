# The wait_until method retries the block of code 
# until the condition is met or the timeout occurs.

module WaitHelper
  def wait_until(max_wait_time = 10, interval = 0.1)
    start_time = Time.now
    loop do
      return if yield
      raise "Timeout waiting for condition" if Time.now - start_time > max_wait_time
      sleep interval
    end
  end
end
