module Convertable
  def date_formatter(datetime)
    return nil if datetime.nil?
    Date
      .parse(datetime)
      .strftime("%d/%m")
  end
end
