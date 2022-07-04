defmodule RerouteFunctionCall do
  @moduledoc """
  Documentation for `RerouteFunctionCall`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> RerouteFunctionCall.hello()
      :world

  """
  use Application
  alias MemEdit.Process

  @process_name "function_caller"

  @bl_offset 0x1988 # The offset of the `bl` ARM instruction that calls do_nothing();
  @new_bl_bytes [0x11, 0x00, 0x00, 0x94] # Will replace the `bl` instruction with one that points to print_message();
  @orig_bl_bytes [0x24, 0x00, 0x00, 0x94] # What did the `bl` (Branch and Link) ARM instruction used to look like?

  def start(_type, _args) do
    IO.puts("Finding process....")

    proc =
      case Process.find_process(@process_name) do
        {:ok, proc} ->
          proc

        _ ->
          raise "Sanity check: Could not find process '#{@process_name}' - is the toy app running?"
      end

    IO.puts("Double-checking that process looks correct....")

    {true, data} = proc |> Process.read_offset(@bl_offset, 4)
    case proc |> Process.read_offset(@bl_offset, Enum.count(@orig_bl_bytes)) do
      {true, @orig_bl_bytes} ->
        true

      {true, found} ->
        raise "Sanity check: Found data '#{found}' did not match expect '#{@orig_bl_bytes}'"

      {false, _} ->
        raise "Sanity check: Could not read data from process '#{@process_name}'"
    end

    IO.puts("Writing to process memory....")

    case proc |> Process.write_offset(@bl_offset, @new_bl_bytes) do
      {true, _} -> true
      {false, err} -> raise "Write failed! Error code #{err}"
    end

    {:ok, spawn(fn -> IO.puts("Done! The process should now call print_message() each loop, instead of do_nothing()!\n") end)}
  end
end
