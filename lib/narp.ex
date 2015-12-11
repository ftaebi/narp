defmodule Narp do
  defp name_and_args({:when, _, [function_head | _]}) do
    name_and_args(function_head)
  end

  defp name_and_args(function_head) do
    Macro.decompose_call(function_head)
  end

  defmacro defguarded(head, body) do
    {fun_name, args_ast} = name_and_args(head)
    quote do
      def unquote(head) do
        policy_module = __MODULE__ |> to_string |> Kernel.<>("Policy") |> String.to_atom
        case apply(policy_module, unquote(fun_name), unquote(args_ast)) do
           unquote body[:do]
        end
      end
    end
  end
end
