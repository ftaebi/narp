defmodule Narp do
  defp name_and_args({:when, _, [function_head | _]}) do
    name_and_args(function_head)
  end

  defp name_and_args(function_head) do
    Macro.decompose_call(function_head)
  end

  defmacro defg(head, [with: module_and_function], body) do
    {_policy_function_ast, args_ast} = name_and_args(head)
    {policy_module_ast, policy_function_ast} = module_and_function
    quote do
      def unquote(head) do
        args = unquote args_ast
        policy_function = unquote(policy_function_ast)
        policy_module = unquote(policy_module_ast)
        case apply(policy_module, policy_function, args) do
          unquote body[:do]
        end
      end
    end
  end

  defmacro defg(head, body) do
    {policy_function_ast, args_ast} = name_and_args(head)
    quote do
      def unquote(head) do
        args = unquote args_ast
        function = unquote policy_function_ast
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
