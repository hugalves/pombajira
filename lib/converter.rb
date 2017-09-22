class Converter
  def self.format(datetime)
    return nil if datetime.nil?
    Date
      .parse(datetime)
      .strftime("%d/%m")
  end
end
