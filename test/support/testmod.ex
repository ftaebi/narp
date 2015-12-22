defmodule Testmod do
  import  Narp

  defg everything_ok?(arg) when is_binary(arg) do
    {:ok, msg} -> msg
    {:error, msg} -> msg
  end

  defg apply(lambda, arg) do
    :ok -> lambda.(arg)
    {:error, msg} -> {:error, msg}
  end

  defg no_policy do
    {:ok, :yarp} -> :ok
  end
end

defmodule Foo do
  import  Narp

  defg bar(lambda, arg), with: {TestmodPolicy, :apply} do
    :ok -> lambda.(arg)
    {:error, msg} -> {:error, msg}
  end 
end
