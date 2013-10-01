Code.load_file("calendar_helpers.exs")
Code.load_file("calendar_macros.exs")
defmodule Meetup do
  require CalendarHelpers
  require CalendarMacros
  CalendarMacros.defteenth([monteenth: :monday, tuesteenth: :tuesday, wednesteenth: :wednesday, thursteenth: :thursday, friteenth: :friday, saturteenth: :saturday, sunteenth: :sunday])
  CalendarMacros.defordinals(CalendarMacros.ordinals, CalendarHelpers.days)

  def calendar_filter(year,month,filter, :last) do
    {num, _} = Enum.filter(CalendarHelpers.calendar(year,month), filter ) |> Enum.reverse |> hd
    {year, month, num}
  end
  def calendar_filter(year,month,filter, position) do
    {num, _} = Enum.filter(CalendarHelpers.calendar(year,month), filter ) |> Enum.at position
    {year, month, num}
  end
end
