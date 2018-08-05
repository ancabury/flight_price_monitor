module FlightsHelper
  def convert_to_date(date)
    date.to_date
  end

  def full_name(airport)
    airport.name
  end
end
