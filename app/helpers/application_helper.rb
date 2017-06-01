module ApplicationHelper

  def skroutz_client
    Skroutz::Client.new(Figaro.env.skroutz_id, Figaro.env.skroutz_secret)
  end
end
