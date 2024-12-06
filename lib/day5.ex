defmodule Mix.Tasks.Aoc2024.Day5 do
  use Helpers.AocProblem

  def solve(file) do
    [dependencies, updates] =
      file
      |> String.split("\n\n", trim: true)

    dep_map =
      dependencies
      |> String.split("\n")
      |> Enum.map(&String.split(&1, "|"))
      |> build_page_to_dep_map()

    updates
    |> String.split("\n", trim: true)
    |> Enum.map(&String.split(&1, ",", trim: true))
    |> Enum.filter(&legal_update?(&1, dep_map))
    |> Enum.map(&median_page_num/1)
    |> Enum.sum()
  end

  defp median_page_num(list) do
    index = trunc(Float.floor(length(list) / 2))

    list
    |> Enum.at(index)
    |> String.to_integer()
  end

  defp legal_update?(list, dependencies_map) do
    all_indexes = 0..(length(list) - 1)

    num_index_map =
      Enum.reduce(all_indexes, %{}, fn i, acc ->
        Map.put(acc, Enum.at(list, i), i)
      end)

    Enum.all?(all_indexes, fn i ->
      page_num = Enum.at(list, i)

      deps = dependencies_map[page_num]
      if deps, do: Enum.all?(deps, fn dep -> i < num_index_map[dep] end), else: true
    end)
  end

  defp build_page_to_dep_map(dependencies) do
    Enum.reduce(dependencies, %{}, fn [page, has_to_be_before], acc ->
      Map.update(acc, page, [has_to_be_before], fn existing_deps ->
        existing_deps ++ [has_to_be_before]
      end)
    end)
  end
end
