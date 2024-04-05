defmodule ECommerce.Shopping.Carts do
  alias ECommerce.Shopping.Cart
  alias ECommerce.Repo

  import Ecto.Query, warn: false

  def create(params) do
    Cart
    |> where(session_id: ^params.session_id)
    |> Repo.one()
    |> case do
      nil ->
        %Cart{}
        |> Cart.changeset(params)
        |> Repo.insert()

      cart ->
        {:ok, cart}
    end
  end

  def find_by_session_id(session_id), do: Repo.get_by(Cart, session_id: session_id)
end
