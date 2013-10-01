defmodule CalendarMacros do
  def ordinals do
    [:first, :second, :third, :fourth, :last]
  end
  def ordinal_position(:last) do
    :last
  end
  def ordinal_position(pos) do
    Enum.find_index ordinals, fn(x) -> x == pos end
  end
  defmacro defteenth(kv) do
    quote bind_quoted: [kv: kv] do
      Enum.each kv, fn { k, v } ->
        def unquote(k)(month, year) do
          calendar_filter(year, month, fn({num, name}) -> (name == unquote(v) && num > 12 && num < 20) end, 0)
        end
      end
    end
  end
  defmacro defordinals(ordinals, days) do
    quote bind_quoted: [ordinals: ordinals, days: days] do
      Enum.each(ordinals, fn(ordinal) ->
        pos = CalendarMacros.ordinal_position(ordinal)
        Enum.each(days, fn(day) ->
          fn_name = binary_to_atom("#{ordinal}_#{day}") 
          def unquote(fn_name)(month,year) do
            calendar_filter(year, month, fn({_num, name}) -> (name == unquote(day)) end, unquote(pos))
          end
        end)
      end)
    end
  end
end
