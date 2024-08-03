defmodule ChalkAuthorization.Plug do
  @moduledoc """
  This module ease the use of [ChalkAuthorization](https://hex.pm/packages/chalk_authorization)
  in your Phoenix application.

  ## Usage

  First, you have to add the required dependencies, `ChalkAuthorization` and the plug
  itself:

  ```elixir
  def deps do
    [
      #...
      {:chalk_authorization, "~> 0.1.1"},
      {:chalk_authorization_plug, "~> 0.1.1"}
    ]
  end
  ```

  Then, import `ChalkAuthorization.Plug` into your Phoenix router (`your_app_web/router.ex`):application

  ```elixir
  import ChalkAuthorization.Plug
  ```

  Once it is imported, you can plug the function `require_authorization/3` in an already defined pipeline
  or you can build a new pipeline:

  ```elixir
  pipeline :require_administrator do
    plug :require_authorization, group: "administrator", message: "Warning! You are not authorized!", bounce_to: "/unauthorized_area"
  end
  ```
  """
  import Plug.Conn
  import Phoenix.Controller

  defp unauthorize(conn, opts \\ []),
    do:
      conn
      |> put_flash(:error, opts[:message] || "You don't have permission to access that page.")
      |> redirect(to: opts[:bounce_to] || "/")
      |> halt()

  @doc """
  Checks if the user is authorized.

  Returns `conn` or halt the plug pipeline.

  ## Options
  * `group` - A string representing the group the user must be a member of.
  * `permission` - A tuple representing the action and the element the user must have permission to.
  * `message` - The message to be displayed in a flash when the user is not authorized.
  * `bounce_to` - The path to redirect the unauthorized user.
  """
  def require_authorization(conn, opts \\ [])

  def require_authorization(%{assigns: %{current_user: %{superuser: true}}} = conn, _opts),
    do: conn

  def require_authorization(%{assigns: %{current_user: %{__struct__: struct} = user}} = conn,
        permission: {action, element},
        message: message,
        bounce_to: bounce_to
      ),
      do:
        if(struct.can?(user, action, element),
          do: conn,
          else: unauthorize(conn, message: message, bounce_to: bounce_to)
        )

  def require_authorization(%{assigns: %{current_user: %{__struct__: struct} = user}} = conn,
        group: group,
        message: message,
        bounce_to: bounce_to
      ),
      do:
        if(struct.is_a?(user, group),
          do: conn,
          else: unauthorize(conn, message: message, bounce_to: bounce_to)
        )

  def require_authorization(conn, _opts),
    do: unauthorize(conn)
end
