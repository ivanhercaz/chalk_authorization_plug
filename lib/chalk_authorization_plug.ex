defmodule ChalkAuthorization.Plug do
  import Plug.Conn
  import Phoenix.Controller

  defp unauthorize(conn, opts \\ []),
    do: conn
    |> put_flash(:error, opts[:message] || "You don't have permission to access that page.")
    |> redirect(to: opts[:bounce_to] || "/")
    |> halt()

  @doc """
  Checks if the user is authorized.

  Returns `conn` or halt the plug pipeline.
  """
  def require_authorization(conn, opts \\ [])

  def require_authorization(%{assigns: %{current_user: %{superuser: true}}} = conn, _opts),
    do: conn

  def require_authorization(%{assigns: %{current_user: %{__struct__: struct} = user}} = conn, [permission: {action, element}, message: message, bounce_to: bounce_to]),
    do: if(struct.can?(user, action, element), do: conn, else: unauthorize(conn, [message: message, bounce_to: bounce_to]))

  def require_authorization(%{assigns: %{current_user: %{__struct__: struct} = user}} = conn, [group: group, message: message, bounce_to: bounce_to]),
    do: if(struct.is_a?(user, group), do: conn, else: unauthorize(conn, [message: message, bounce_to: bounce_to]))

  def require_authorization(conn, _opts),
    do: unauthorize(conn)
end
