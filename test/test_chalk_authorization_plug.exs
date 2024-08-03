defmodule ChalkAuthorizationPlugTest do
  @moduledoc """
  It isn't documentation, just a note.

  This tests only checks if a user can access depending of being or not being
  a superuser. The tests and the test cases must be rewritten to handle all possible
  cases.
  """

  use ExUnit.Case, async: true

  alias ChalkAuthorizationPlug.UserCase, as: User

  use Plug.Test
  use Phoenix.Controller

  test "should allow authorization if user is a superuser" do
    user = %User{superuser: true}

    conn = conn(:get, "/")
    conn = Plug.Test.init_test_session(conn, user_name: "test_user")
    conn = conn |> assign(:current_user, user) |> fetch_flash()

    result = ChalkAuthorization.Plug.require_authorization(conn)

    assert result.halted == false
  end

  test "should deny authorization if user is not a superuser" do
    user = %User{superuser: false}

    conn = conn(:get, "/")
    conn = Plug.Test.init_test_session(conn, user_id: 1)
    conn = conn |> assign(:curren_user, user) |> fetch_flash()

    result = ChalkAuthorization.Plug.require_authorization(conn)

    assert result.halted == true
    assert result.private.phoenix_flash["error"] == "You don't have permission to access that page."
  end
end
