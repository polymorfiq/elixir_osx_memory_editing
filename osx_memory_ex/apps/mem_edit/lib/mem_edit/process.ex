defmodule MemEdit.Process do
  use Rustler, otp_app: :mem_edit, crate: "memedit_process"
  defstruct [:pid, :base_addr, name: "Unknown Process"]

  @spec new(pid :: integer, base_addr :: integer) :: {:ok, Process} | {:error, String}
  def new(pid, name) do
    case get_base_address(pid) do
      {true, base_addr} -> {:ok, %__MODULE__{pid: pid, name: name, base_addr: base_addr}}
      {false, err} -> {:error, "Error getting base address: #{err}"}
    end
  end

  @spec find_process(name :: String) :: {:ok, Process} | {:error, String}
  def find_process(qry) do
    matches = get_processes()
    |> Enum.filter(fn {_pid, name} -> String.downcase(name) |> String.contains?(String.downcase(qry)) end)
    |> Enum.at(0)

    case matches do
      {pid, name} -> __MODULE__.new(pid, name)
      _ -> {:error, "Could not find process '#{qry}'"}
    end
  end

  def read_address(proc, addr, num_bytes) do
    read_memory(proc.pid, addr, num_bytes)
  end

  def read_offset(proc, offset, num_bytes) do
    read_address(proc, proc.base_addr + offset, num_bytes)
  end

  def write_address(proc, addr, bytes) do
    write_memory(proc.pid, addr, bytes)
  end

  def write_offset(proc, offset, bytes) do
    write_address(proc, proc.base_addr + offset, bytes)
  end

  # Defined via Rustler (see `native/memedit_process/lib.rs`)
  defp get_processes, do: :erlang.nif_error(:nif_not_loaded)
  defp read_memory(_pid, _addr, _size), do: :erlang.nif_error(:nif_not_loaded)
  defp write_memory(_pid, _addr, _data), do: :erlang.nif_error(:nif_not_loaded)
  defp get_base_address(_pid), do: :erlang.nif_error(:nif_not_loaded)
end
