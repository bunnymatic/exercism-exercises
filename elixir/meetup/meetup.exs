defmodule Meetup do
  @moduledoc """
  Calculate meetup dates.
  """

  @type weekday ::
      :monday | :tuesday | :wednesday
    | :thursday | :friday | :saturday | :sunday

  @type schedule :: :first | :second | :third | :fourth | :last | :teenth

  @doc """
  Calculate a meetup date.

  The schedule is in which week (1..4, last or "teenth") the meetup date should
  fall.
  """
  @spec meetup(pos_integer, pos_integer, weekday, schedule) :: :calendar.date
  def meetup(year, month, weekday, schedule) do
    date = get_date({year, month, 1})
    weekday_number = weekday |> numbered_day_of_week
    date
    |> move_to_day_of_week(weekday_number)
    |> move_to_scheduled(schedule)
  end

  def get_date({year, month, day}) do
    d = Date.new(year, month, day)
    case d do
      {:ok, date} ->
        date
      {:error,_} ->
        IO.puts("ACK")
    end
  end

  defp move_to_day_of_week(date, weekday) do
    erl_date = date |> Date.to_erl
    move_to_day_of_week(erl_date, date |> Date.day_of_week, weekday)
  end

  defp move_to_day_of_week(erl_date, current_day_of_week_number, desired_day_of_week_number) when current_day_of_week_number == desired_day_of_week_number do
    get_date(erl_date)
  end

  defp move_to_day_of_week(erl_date, _, desired_day_of_week_number) do
    date = add_day(erl_date)
    erl_date = date |> Date.to_erl
    dow = date |> Date.day_of_week
    move_to_day_of_week(erl_date, dow, desired_day_of_week_number)
  end

  defp move_to_scheduled(date, schedule) when schedule == :last do
    date = date |> add_weeks(3)
    {_,_,day} = date |> Date.to_erl
    if (((date |> Date.days_in_month) - day) >= 7) do
      date |> add_weeks(1) |> Date.to_erl
    else
      date |> Date.to_erl
    end
  end

  defp move_to_scheduled({year, month, day}, schedule) when (schedule == :teenth) and (not (day in 13..19)) do
    date = add_week({year, month, day}) |> Date.to_erl
    move_to_scheduled(date, schedule)
  end

  defp move_to_scheduled({year, month, day}, _), do: {year, month, day}

  defp move_to_scheduled(date, schedule) when schedule == :teenth do
    move_to_scheduled(date |> Date.to_erl, schedule)
  end

  defp move_to_scheduled(date, schedule) do
    case schedule do
      :first ->
        date
      :second ->
        date |> add_weeks(1)
      :third ->
        date |> add_weeks(2)
      :fourth ->
        date |> add_weeks(3)
    end |> Date.to_erl
  end

  defp add_day({year, month, day}), do: get_date({year, month, day+1})
  defp add_week({year, month, day}), do: get_date({year, month, day+7})

  defp add_weeks(date, num) do
    {year, month, day} = date |> Date.to_erl
    get_date({year, month, day + num * 7})
  end

  defp index_of(list, element) do
    list
    |> Enum.with_index
    |> Enum.filter_map(fn {x, _} -> x == element end, fn {_, i} -> i end)
    |> Enum.at(0)
  end

  defp numbered_day_of_week(named_weekday) do
    idx = [:monday, :tuesday, :wednesday, :thursday, :friday, :saturday, :sunday]
    |> index_of(named_weekday)
    idx + 1
  end


end
