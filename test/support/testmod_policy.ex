defmodule TestmodPolicy do

  def everything_ok?(arg) when is_number(arg) do
    case arg do
      1 -> {:ok, :yarp}
      0 -> {:error, :narp}
    end
  end

  def everything_ok?(arg) when is_binary(arg) do
    case arg do
      "Michael" -> {:ok, :yarp}
      "Agent" -> {:error, :narp}
    end
  end

  def apply(_lambda, arg) when is_number(arg) do
    :ok
  end

  def apply(_lambda, arg) do
    {:error, "only numbers allowed"}
  end

end
