defmodule Helpers.AocProblem do
  defmacro __using__(_) do
    quote do
      use Mix.Task

      def run(args) do
        case args do
              ["input"] ->
                input()

              ["sample"] ->
                sample()

              _ ->
                IO.puts("Usage: mix aoc2024.day<n> [input|sample]")
            end
      end

      # Function to be used by the extending module to read from a file
      def input do
        file_name = String.downcase("inputs/#{module_name()}-input.txt")

        file_content = read_file(file_name)

        IO.puts(solve(file_content))
      end

      # Function to be used by the extending module to get a sample from the file
      def sample do
        file_name = String.downcase("inputs/#{module_name()}-sample.txt")

        file_content = read_file(file_name)

        IO.puts(solve(file_content))
      end

      defp module_name do
      __MODULE__
        |> to_string()
        |> String.downcase()        # Convert module to string
        |> String.replace("elixir.mix.tasks.aoc2024.", "")  # Remove the "Elixir." prefix
      end

      defp read_file(file_name) do
        case File.read(file_name) do
          {:ok, file}  -> file
          {:error, msg} -> raise "Cannot Read file: #{msg}"
        end
      end
    end
  end
end
