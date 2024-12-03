defmodule Mix.Tasks.Aoc2024.Day1 do
  use Helpers.AocProblem

  def solve(file) do
    lines = file
    |> String.trim
    |> String.split("\n")

    first_list = lines
    |> Enum.map(&(String.split(&1," ")))
    |> Enum.map(&(List.first(&1)))
    |> Enum.map(&(String.to_integer(&1)))
    |> Enum.sort

    second_list = lines
    |> Enum.map(&(String.split(&1," ")))
    |> Enum.map(&(List.last(&1)))
    |> Enum.map(&(String.to_integer(&1)))
    |> Enum.sort

    result = Enum.zip(first_list, second_list)
    |> Enum.map(fn {first, second} -> abs(first - second) end)
    |> Enum.sum

    result
  end
end
