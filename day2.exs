defmodule Day1 do

  def input do
    {:ok, file} = File.read("day2-input.txt")

    IO.inspect(run(file))
  end

  def sample do
    {:ok, file} = File.read("day2-sample.txt")

    IO.puts(run(file))
  end

  def run(file) do
    lines = file
    |> String.trim
    |> String.split("\n")

    lines
    |> Enum.map(&(String.split(&1," ")))
    |> Enum.map(fn s_elems ->
        Enum.map(s_elems, &(String.to_integer(&1)))
      end)
    |> Enum.filter(&safe?(&1))
    |> length
  end

  def safe?(list) do

    dir = if (Enum.at(list, 0) - Enum.at(list, 1)) < 0, do: :asc, else: :desc

    safe = Enum.reduce_while(tl(list), List.first(list), fn
      x, prev when dir == :asc and x - prev < 1 -> {:halt, false}
      x, prev when dir == :asc and x - prev > 3 -> {:halt, false}
      x, prev when dir == :desc and prev - x < 1 -> {:halt, false}
      x, prev when dir == :desc and prev - x > 3 -> {:halt, false}
      x, _ -> {:cont, x}
    end)

    !!safe
  end
end

Day1.input
