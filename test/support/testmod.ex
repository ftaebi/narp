defmodule Testmod do
  import  Narp

  defguarded everything_ok?(arg) when is_number(arg) do
    {:ok, msg} -> msg
    {:error, msg} -> msg
  end

  defguarded everything_ok?(arg) when is_binary(arg) do
    {:ok, msg} -> msg
    {:error, msg} -> msg
  end

  defguarded apply(lambda, arg) do
    :ok -> lambda.(arg)
    {:error, msg} -> {:error, msg}
  end

end
