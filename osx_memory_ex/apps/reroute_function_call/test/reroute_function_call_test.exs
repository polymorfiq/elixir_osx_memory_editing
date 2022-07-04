defmodule RerouteFunctionCallTest do
  use ExUnit.Case
  doctest RerouteFunctionCall

  test "greets the world" do
    assert RerouteFunctionCall.hello() == :world
  end
end
