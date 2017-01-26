defmodule Gigasecond do
  @doc """
  Calculate a date one billion seconds after an input date.
  """
  @spec from({{pos_integer, pos_integer, pos_integer}, {pos_integer, pos_integer, pos_integer}}) :: :calendar.datetime
  def from({{year, month, day}, {hours, minutes, seconds}}) do
    { year, month, day, hours, minutes, seconds }
    |> to_unix_time
    |> add_gigasecond
    |> DateTime.from_unix()

    |> elem(1)
    |> to_ymd_hms
  end

  defp to_unix_time({ year, month, day, hours, minutes, seconds }) do
    %DateTime{
      year: year,
      month: month,
      day: day,
      hour: hours,
      minute: minutes,
      second: seconds,
      time_zone: "Etc/UTC",
      utc_offset: 0,
      std_offset: 0,
      zone_abbr: "UTC"
    } |> DateTime.to_unix
  end

  defp add_gigasecond(unix_time) do
    unix_time + giga() |> round
  end

  defp to_ymd_hms(dt) do
    { {dt.year, dt.month, dt.day}, {dt.hour, dt.minute, dt.second} }
  end

  defp giga, do: (10 |> :math.pow(9))

end
