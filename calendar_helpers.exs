defmodule CalendarHelpers do
  def days do
    [:monday, :tuesday, :wednesday, :thursday, :friday, :saturday, :sunday]
  end
  def name_of_day(num) do
    # complies with Erlang's day_of_week function which returns 1 for monday, 2 for tuesday and so on ...
    # ours days names above are 0 based so shift it over one.
    Enum.at(days, num - 1)
  end
  def calendar(year, month) do
    Enum.map(1..:calendar.last_day_of_the_month(year,month), fn(day) -> {day, name_of_day(:calendar.day_of_the_week(year, month, day))} end)
  end
end
