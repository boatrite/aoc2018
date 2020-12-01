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

    stuff =
      Stream.transform(frequencies, [{0, false}], fn(frequency, acc) ->
        # Get all the previous frequencies and see if the next one is a match for
        # any of the previous ones
        frequencies_to_check_against = Enum.map(acc, fn x -> elem(x, 0) end)
        is_repeat = Enum.member?(frequencies_to_check_against, frequency)
        next_acc = acc ++ [{frequency, is_repeat}]
        if is_repeat, do: {:halt, next_acc}, else: {frequency, next_acc}
      end)

    Enum.take(stuff, 1)

    # Stream.filter(stuff, fn x -> require IEx; IEx.pry; x end) |>
    # Enum.take(10) #|> Enum.at(0) |> elem(0)
  end
end
