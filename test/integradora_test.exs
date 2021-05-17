defmodule IntegradoraTest do
  use ExUnit.Case
  doctest Integradora

  test "greets the world" do
    assert Integradora.hello() == :world
  end
end
