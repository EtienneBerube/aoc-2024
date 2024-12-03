defmodule Mix.Tasks.Aoc2024.Day3 do
  use Helpers.AocProblem

  @mul_regex ~r/mul\(\d{1,3},\d{1,3}\)/U
  @mul_regex_with_capture ~r/^mul\((\d{1,3}),(\d{1,3})\)/

  def solve(file) do
    line = file
    |> String.trim

    Regex.scan(@mul_regex, line)
    |> Enum.map(fn [match] -> Regex.scan(@mul_regex_with_capture, match, capture: :all_but_first) end)
    |> Enum.map(&List.first(&1))
    |> Enum.map(fn [x, y] -> [String.to_integer(x), String.to_integer(y)] end)
    |> Enum.map(fn [x,y] -> x * y end)
    |> Enum.sum
  end
end
