defmodule NarpTest do
  use ExUnit.Case

  test "guards functions" do
    assert Testmod.everything_ok?("Michael") == :yarp
    assert Testmod.everything_ok?("Agent") == :narp
    assert Testmod.apply(fn(x) -> :math.exp(x) end, 3) === :math.exp(3) 
    assert Testmod.apply(&:math.exp/1, "x") ==  {:error, "only numbers allowed"}
  end

  test "uses default policy if no policy specified" do
    assert Testmod.no_policy == :ok
  end

  test "uses a custom policy function if provided" do
    assert Foo.bar(fn(x) -> :math.exp(x) end, 3) === :math.exp(3) 
  end
end
