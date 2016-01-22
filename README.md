## Narp

_(Nuclear Access Restriction Policies)_

![image](narp.jpg)

Narp is an easy and flexible way to authorize function calls in elixir. It has partly been inspired by the pundit project and can be used with plain elixir or beneath a phoenix project.

### Features

* Authorize function calls easily
* Convention based syntax for clean and neat function definitions
* More complex definitions and centralized authorization policies possible
* Default policies, when no matching policy was found

### Installation

Add

```
{:narp, git: "https://github.com/ftaebi/narp.git"},
```

to the deps section of your projects mix file.
Alternatively you can use the available hex package by using.


```
{:narp, "~> 0.1.0"},
```


Narp can now be enabled by importing the Narp module.


_Plain Elixir:_

```
defmodule YourModule do
  import  Narp
  ...
end
```


_Phoenix:_ import in WebController module to make Narp accessible in every controller:

```
defmodule YourProject.Web do
  def controller do
    quote do
      import Narp
        ...
    end
  end
end
```


### Guarded functions and policies

In order to guard a function Narp provides the **defg** _(define guarded)_ keyword. A guarded function would be defined like this:

```
defmodule YourProject.YourModule
  defg your_function(params) do
    ...
  end
end
```


In this case Narp will look for a policy module called **YourModulePolicy** and call a function with the same name as the guarded function: **YourModulePolicy.your_function(params)**. Guard functions in policy modules should return matchable data which you can use to implement conditional behavior in your guarded function.

_Example:_

```
defmodule YourProject.YourRessourceController do
  defg show(conn, %{"user_id" => user_id}) do
    :valid_user_id ->
      render conn, "show.json", data: %{hello: "World"}
    :invalid_user_id ->
      conn
      |> put_status(:forbidden)
      |> put_error("Viewing or editing other users data is not allowed.")
  end
end

defmodule YourProject.YourRessourcePolicy do
  def show(conn, %{"user_id" => user_id}) do
    if valid_user_id?(user_id) do
      :valid_user_id
    else
      :invalid_user_id
    end
  end

  defp valid_user_id?(user_id) do
    user_id == 15
  end
end
```


Sometimes you may want to use a single policy module to guard multiple functions in different modules. In this case you can tell Narp wich policy module and wich policy function to use:

```
defmodule YourProject.YourModule
  defg your_function(params), with: {YourAwesomePolicyModule, :your_awesome_policy_function}  do
    ...
  end
end
```

_Example:_

```
defmodule YourProject.YourRessourceController do
  defg show(conn, %{"user_id" => user_id}), with: {YourAwesomePolicyModule, :user_has_id_15} do
    :valid_user_id ->
      render conn, "show.json", data: %{hello: "World"}
    :invalid_user_id ->
      conn
      |> put_status(:forbidden)
      |> put_error("Viewing or editing other users data is not allowed.")
  end
end

defmodule YourProject.YourOtherRessourceController do
  defg get(conn, %{"user_id" => user_id}), with: {YourAwesomePolicyModule, :user_has_id_15} do
    :valid_user_id ->
      render conn, "get.json", data: %{hello: "World"}
    :invalid_user_id ->
      conn
      |> put_status(:forbidden)
      |> put_error("Viewing or editing other users data is not allowed.")
  end
end

defmodule YourProject.YourAwesomePolicy do
  def user_has_id_15(conn, %{"user_id" => user_id}) do
    if valid_user_id?(user_id) do
      :valid_user_id
    else
      :invalid_user_id
    end
  end

  defp valid_user_id?(user_id) do
    user_id == 15
  end
end
```

Sometimes you may want to use one policy to guard many functions by default. In this cases you can define a default policy by using the function name **default_policy()** in the  corresponding policy module. It is called, whenever no matching policy function could be found.

_Example:_

```
defmodule YourProject.YourRessourceController do
  defg show(conn, %{"user_id" => user_id}) do
    :ok ->
      render conn, "show.json", data: %{hello: "World"}
    {:error, msg} ->
      conn
      |> put_status(:forbidden)
      |> put_error(msg)
  end
end

defmodule YourProject.YourRessourcePolicy do
  def default_policy(conn, %{"user_id" => user_id}) do
    case user_id do
      15 -> :ok
      _ -> {:error, "only 15 allowed"}
    end
  end
end
```

### Credits

Special thanks to:

* Slawomir Dabek
* Matthias Lindhorst
