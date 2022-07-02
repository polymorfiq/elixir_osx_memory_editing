defmodule HelloWorldTweak do
  @moduledoc """
  For use with the `toy_apps/hello_world` example application, which prints a static message at an interval.

  Modifies memory in the TEXT section of the application, changing what it prints.

  Notes:
    - @hello_text_offset was found via using Bit Slicer on the toy app
  """
  use Application
  alias MemEdit.Process

  @process_name "hello_world"
  @hello_text_offset 0x31C10
  @expected_text 'Hello, world!'
  @replacement_text 'Hi, world!\0\0\0'

  def start(_type, _args) do

    mem_size = Enum.count(@expected_text)
    new_mem_size = Enum.count(@replacement_text)

    if mem_size != new_mem_size do
      raise "Sanity check: Replacement text must be the same size as the original text."
    end

    IO.puts("Finding process....")
    proc =
      case Process.find_process(@process_name) do
        {:ok, proc} -> proc
        _ -> raise "Sanity check: Could not find process '#{@process_name}' - is the toy app running?"
      end

    IO.puts("Double-checking that process looks correct....")
    case proc |> Process.read_offset(@hello_text_offset, Enum.count(@expected_text)) do
      {true, @expected_text} ->
        true

      {true, found} ->
        raise "Sanity check: Found data '#{found}' did not match expect '#{@expected_text}'"

      {false, _} ->
        raise "Sanity check: Could not read data from process '#{@process_name}'"
    end

    IO.puts("Writing to process memory....")
    case proc |> Process.write_offset(@hello_text_offset, @replacement_text) do
      {true, _} -> true
      {false, err} -> raise "Write failed! Error code #{err}"
    end

    {:ok, spawn(fn -> IO.puts("Done! The process should now print the new text!\n") end)}
  end
end
