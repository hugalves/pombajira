module Utilizable
  def date_formatter(datetime)
    return '' if datetime.nil?
    Date
      .parse(datetime)
      .strftime("%d/%m")
  end
end
