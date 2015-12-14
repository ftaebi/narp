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
        function = unquote fun_name
        args = unquote args_ast
        policy_module = 
          __MODULE__ 
          |> to_string 
          |> Kernel.<>("Policy") 
          |> String.to_atom
        unless {function, length(args)} in policy_module.__info__(:functions) do
          function = :default_policy
        end
        case apply(policy_module, function, args) do
          unquote body[:do]
        end
      end
    end
  end
end
