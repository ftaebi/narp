defmodule NarpTest do
  use ExUnit.Case

  test "guards functions" do
    assert Testmod.everything_ok?("Michael") == :yarp
    assert Testmod.everything_ok?("Agent") == :narp
    assert Testmod.everything_ok?(1) == :yarp
    assert Testmod.everything_ok?(0) == :narp
    assert Testmod.apply(fn(x) -> :math.exp(x) end, 3) === :math.exp(3) 
    assert Testmod.apply(fn(x) -> :math.exp(x) end, "x") ==  {:error, "only numbers allowed"}
  end

end
