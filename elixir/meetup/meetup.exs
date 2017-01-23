defmodule MeetupDate do
  defstruct year: 0, month: 0, day: 0, day_of_week: 0

  def new( year, month, day ) do
    get_date( year, month, day )
  end

  def to_erl_date(mdate) do
    { mdate.year, mdate.month, mdate.day }
  end

  def days_in_month(mdate) do
    Date.new(mdate.year, mdate.month, mdate.day)
    |> elem(1)
    |> Date.days_in_month
  end

  def add_days(mdate, days), do: get_date(%MeetupDate{ mdate | day: mdate.day + days})
  def add_day(mdate), do: mdate |> add_days(1)
  def add_week(mdate), do: mdate |> add_days(7)
  def add_weeks(mdate, num), do: mdate |> add_days(num * 7)

  defp get_date(mdate), do: get_date(mdate.year, mdate.month, mdate.day)
  defp get_date(year, month, day) do
    d = Date.new(year, month, day)
    case d do
      {:ok, date} ->
        %MeetupDate{ year: year, month: month, day: day, day_of_week: date |> Date.day_of_week }
      {:error,_} ->
        IO.puts("ACK")
    end
  end

end

defmodule Meetup do
  @moduledoc """
  Calculate meetup dates.
  """

  @type weekday ::
      :monday | :tuesday | :wednesday
    | :thursday | :friday | :saturday | :sunday

  @type schedule :: :first | :second | :third | :fourth | :last | :teenth

  require MeetupDate

  @doc """
  Calculate a meetup date.

  The schedule is in which week (1..4, last or "teenth") the meetup date should
  fall.
  """
  @spec meetup(pos_integer, pos_integer, weekday, schedule) :: :calendar.date
  def meetup(year, month, weekday, schedule) do
    weekday_number = weekday |> numbered_day_of_week

    # start at the first of the month
    MeetupDate.new(year, month, 1)
    |> move_to_day_of_week(weekday_number)
    |> move_to_schedule(schedule)
    |> MeetupDate.to_erl_date
  end


  defp move_to_day_of_week(mdate, weekday) do
    cond do
      (weekday == mdate.day_of_week) ->
        mdate
      true ->
        mdate |> MeetupDate.add_day |> move_to_day_of_week(weekday)
    end
  end

  defp move_to_schedule(mdate, schedule) when schedule == :teenth do
    cond do
      (mdate.day in 13..19) ->
        mdate
      true ->
        mdate |> MeetupDate.add_week |> move_to_schedule(schedule)
    end
  end

  defp move_to_schedule(mdate, schedule) when schedule == :last do
    date = mdate |> MeetupDate.add_weeks(3)
    if (((mdate |> MeetupDate.days_in_month) - date.day) >= 7) do
      date |> MeetupDate.add_week
    else
      date
    end
  end

  defp move_to_schedule(date, schedule) do
    case schedule do
      :first ->
        date
      :second ->
        date |> MeetupDate.add_weeks(1)
      :third ->
        date |> MeetupDate.add_weeks(2)
      :fourth ->
        date |> MeetupDate.add_weeks(3)
    end
  end

  defp numbered_day_of_week(named_weekday) do
    idx = [:monday, :tuesday, :wednesday, :thursday, :friday, :saturday, :sunday]
    |> index_of(named_weekday)
    idx + 1
  end

  defp index_of(list, element) do
    list
    |> Enum.with_index
    |> Enum.filter_map(fn {x, _} -> x == element end, fn {_, i} -> i end)
    |> Enum.at(0)
  end



end
