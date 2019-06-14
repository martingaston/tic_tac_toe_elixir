defmodule Log do
  @default_dir "log"
  @default_log "log.txt"

  def out(contents, dir \\ @default_dir, log_file \\ @default_log)

  def out(contents, dir, log_file) when is_list(contents) do
    open(dir, log_file)
    |> append(Enum.join(contents, "\n") <> "\n")
    |> close()
    contents
  end

  def out(contents, dir, log_file) do
    open(dir, log_file)
    |> append(contents)
    |> close()
    contents
  end

  defp open(dir, log) do
    unless File.exists?(dir), do: File.mkdir_p(dir)

    Path.join([dir, log])
    |> File.open([:read, :append, :utf8])
    |> case do
      {:ok, file} -> file
      {:error, reason} -> {:error, reason}
    end
  end

  defp append(file, contents) do
    IO.write(file, contents)
    file
  end

  defp close(file), do: File.close(file)
end
