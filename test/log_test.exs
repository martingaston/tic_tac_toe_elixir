defmodule LogTest do
  @test_dir "test_log"
  use ExUnit.Case

  setup_all do
    on_exit(fn ->
      File.rm_rf(@test_dir)
    end)

    :ok
  end

  test "Log.out/3 can write to a file" do
    test_output = "this is a utf8 string to test output"
    :ok = Log.out(test_output, @test_dir, "test_log.txt")
    {:ok, file} = File.open(Path.join(@test_dir, "test_log.txt"), [:read, :utf8])
    assert test_output == IO.read(file, :all)
  end
end
