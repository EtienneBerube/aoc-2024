defmodule Helpers.AocProblem do
  defmacro __using__(_) do
    quote do
      # Function to be used by the extending module to read from a file
      def input do
        file_name = String.downcase("#{module_name()}-input.txt")

        IO.puts(file_name)

        {:ok, file} = File.read(file_name)

        run(file)
      end

      # Function to be used by the extending module to get a sample from the file
      def sample do
        file_name = String.downcase("#{module_name()}-sample.txt")

        {:ok, file} = File.read(file_name)

        run(file)
      end

      defp module_name do
      __MODULE__
        |> to_string()                # Convert module to string
        |> String.replace("Elixir.", "")  # Remove the "Elixir." prefix
        |> String.downcase()
      end
    end
  end
end
