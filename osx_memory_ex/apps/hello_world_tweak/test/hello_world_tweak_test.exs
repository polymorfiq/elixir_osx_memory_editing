defmodule HelloWorldTweakTest do
  use ExUnit.Case
  doctest HelloWorldTweak

  test "greets the world" do
    assert HelloWorldTweak.hello() == :world
  end
end
