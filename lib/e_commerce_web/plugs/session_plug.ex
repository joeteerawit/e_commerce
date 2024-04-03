defmodule ECommerceWeb.Plugs.SessionPlug do
  import Plug.Conn

  def init(defalut), do: defalut

  def call(conn, _opts) do
    user_id = "d0751a6c-14dd-4d73-ac33-397fadbfda74"

    conn
    |> put_session(:user_id, user_id)
    |> put_session(:session_id, unique_session_id())
  end

  # defp unique_session_id(), do: :crypto.strong_rand_bytes(16) |> Base.encode16()
  defp unique_session_id(), do: "a6626887-2884-49cd-87bb-9617cb08f991"
end
