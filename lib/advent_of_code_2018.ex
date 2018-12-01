defmodule A do

  #
  ### DAY 1
  #

  def day_1(input) do
    frequencies =
      # `input` is a string of space delimited list of integers
      String.split(input, " ") |>
      # Convert array of strings into array of integers
      Enum.map(&String.to_integer(&1)) |>
      # Once we reach the end we need to start back at the beginning
      Stream.cycle |>
      # Create the list of frequencies
      Stream.scan(&(&1 + &2))

    Stream.with_index(frequencies) |>
    Stream.filter(fn {frequency, i} ->
      # Get all the previous frequencies and see if the next one is a match for
      # any of the previous ones
      Enum.take(frequencies, i) |> Enum.member?(frequency) || (i != 0 && frequency == 0)
      end) |>
    Enum.take(1) |> Enum.at(0) |> elem(0)
  end
end
