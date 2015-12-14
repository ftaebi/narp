defmodule TestmodPolicy do

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

  def default_policy() do
    {:ok, :yarp}
  end
end
