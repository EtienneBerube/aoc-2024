defmodule Mix.Tasks.Aoc2024.Day4 do
  use Helpers.AocProblem

  @xmas_regex ~r/XMAS/U
  @xmas_regex_reverse ~r/SAMX/U

  def solve(file) do
    lines =
      file
      |> String.split("\n", trim: true)

    nums_per_h_line =
      lines
      |> Enum.map(&xmas_num_in_line/1)
      |> Enum.sum()
      |> IO.inspect(label: "Found Horizontal")

    nums_per_v_line =
      lines
      # Transpose
      |> transpose_list_of_strings()
      |> Enum.map(&xmas_num_in_line/1)
      |> Enum.sum()
      |> IO.inspect(label: "Found vertical")

    nums_per_d_line_left =
      lines
      |> build_diagonal_lines_left()
      |> Enum.map(&xmas_num_in_line/1)
      |> Enum.sum()
      |> IO.inspect(label: "Found diag")

    nums_per_d_line_right =
      lines
      |> build_diagonal_lines_right()
      |> Enum.map(&xmas_num_in_line/1)
      |> Enum.sum()
      |> IO.inspect(label: "Found diag")

    nums_per_h_line +
      nums_per_v_line +
      nums_per_d_line_left +
      nums_per_d_line_right
  end

  defp xmas_num_in_line(line) do
    length(Regex.scan(@xmas_regex, line) ++ Regex.scan(@xmas_regex_reverse, line))
  end

  defp transpose_list_of_strings(lines) do
    lines
    |> Enum.map(fn line -> String.split(line, "", trim: true) end)
    |> Enum.zip_with(&Function.identity/1)
    |> Enum.map(fn list_of_char -> Enum.join(list_of_char, "") end)
  end

  defp build_diagonal_lines_left(lines) do
    depth = length(lines)

    wideness =
      Enum.at(lines, 0)
      |> String.length()

    Enum.map((-1 * depth + 1)..(wideness - 1), fn start_col ->
      {_, new_line} =
        Enum.reduce_while(0..(depth - 1), {start_col, []}, fn
          _, {j, new_line} when j < 0 ->
            {:cont, {j + 1, new_line}}

          i, {j, new_line} when j >= 0 and j < wideness ->
            new_char = String.at(Enum.at(lines, i), j)
            {:cont, {j + 1, [new_line | [new_char]]}}

          _, {j, new_line} when j >= wideness ->
            {:halt, {j, new_line}}

          _, _ ->
            IO.puts("Errored out")
            {:halt, nil}
        end)

      new_line
      |> Enum.join("")
    end)
  end

  defp build_diagonal_lines_right(lines) do
    depth = length(lines)

    wideness =
      Enum.at(lines, 0)
      |> String.length()

    # Go backwards
    Enum.map((wideness + depth)..0//-1, fn start_col ->
      {_, new_line} =
        Enum.reduce_while(0..(depth - 1), {start_col, []}, fn
          _, {j, new_line} when j >= wideness ->
            {:cont, {j - 1, new_line}}

          i, {j, new_line} when j >= 0 and j < wideness ->
            new_char = String.at(Enum.at(lines, i), j)
            {:cont, {j - 1, [new_line | [new_char]]}}

          _, {j, new_line} when j < 0 ->
            {:halt, {j, new_line}}

          _, _ ->
            IO.puts("Errored out")
            {:halt, nil}
        end)

      new_line
      |> Enum.join("")
    end)
  end
end
