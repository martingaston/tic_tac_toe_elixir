defmodule Log do
  @default_dir "log"
  @default_log "log.txt"

  def out(contents, dir \\ @default_dir, log_file \\ @default_log) do
    open(dir, log_file)
    |> append(contents)
    |> close()
    |> case do
      :ok -> contents
      error -> error
    end
  end

  defp open(dir, log) do
    with :ok <- check_directory(dir),
         {:ok, file} <- Path.join([dir, log]) |> File.open([:read, :append, :utf8]) do
      file
    end
  end

  defp append(file, contents) do
    IO.write(file, contents)
    file
  end

  defp close(file), do: File.close(file)

  defp check_directory(dir) do
    unless File.exists?(dir), do: File.mkdir_p(dir), else: :ok
  end
end
