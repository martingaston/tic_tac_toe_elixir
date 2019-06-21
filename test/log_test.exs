defmodule LogTest do
  @test_dir "test_log"
  use ExUnit.Case

  setup do
    on_exit(fn ->
      File.rm_rf(@test_dir)
    end)

    :ok
  end

  test "Log.out/3 can write to a file" do
    test_output = "this is a utf8 string to test output"
    Log.out(test_output, @test_dir, "test_log.txt")
    {:ok, file} = File.open(Path.join(@test_dir, "test_log.txt"), [:read, :utf8])
    assert test_output == IO.read(file, :all)
  end

  test "Log.out/3 appends to a file and does not overwrite" do
    test_output = "this is a utf8 string to test output"
    Log.out(test_output, @test_dir, "test_log.txt")
    Log.out("\n", @test_dir, "test_log.txt")
    Log.out(test_output, @test_dir, "test_log.txt")
    {:ok, file} = File.open(Path.join(@test_dir, "test_log.txt"), [:read, :utf8])

    assert "this is a utf8 string to test output\nthis is a utf8 string to test output" ==
             IO.read(file, :all)
  end
end
