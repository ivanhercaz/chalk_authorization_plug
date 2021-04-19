defmodule ChalkAuthorization.Plug do
  import Plug.Conn
  import Phoenix.Controller

  defp unauthorize(conn, opts \\ []),
    do: conn
    |> put_flash(:error, opts[:message] || "You don't have permission to access that page.")
    |> redirect(to: opts[:bounce_to] || "/")
    |> halt()

  def require_authorization(%{assigns: %{current_user: %{superuser: true}}} = conn, _opts \\ []),
    do: conn

  def require_authorization(%{assigns: %{current_user: %{__struct__: struct} = user}} = conn, [permission: {action, element}] = opts),
    do: if(struct.can?(user, action, element), do: conn, else: unauthorize(conn))

  def require_authorization(%{assigns: %{current_user: %{__struct__: struct} = user}} = conn, [group: group] = opts),
    do: if(struct.is_a?(user, group), do: conn, else: unauthorize(conn))

  def require_authorization(conn, _opts),
    do: unauthorize(conn)
end
