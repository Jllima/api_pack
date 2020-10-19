module TimeHelper
  def days_from_now(value)
    (Time.now + value * 86_400).to_i
  end

  def days_ago(value)
    (Time.now - value * 86_400).to_i
  end
end