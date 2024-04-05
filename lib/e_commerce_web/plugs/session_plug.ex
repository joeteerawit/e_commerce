defmodule ECommerceWeb.Plugs.SessionPlug do
  import Plug.Conn

  alias ECommerce.Users
  def init(defalut), do: defalut

  def call(conn, _opts) do
    session_id = conn |> get_session(:session_id)
    {:ok, user} = Users.find_by_session_id(session_id)

    conn
    |> put_session(:session_id, user.session_id)
  end
end
