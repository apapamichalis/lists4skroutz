module ApplicationHelper

  def skroutz_client
    Skroutz::Client.new(Figaro.env.skroutz_id, Figaro.env.skroutz_secret)
  end

  def sortable(column, title = nil)
    title ||= column.titleize
    direction = (column == sort_column && sort_direction == "asc") ? "desc" : "asc"
    link_to title, sort: column, direction: direction
  end

end
