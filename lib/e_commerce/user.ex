defmodule ECommerce.User do
  alias Ecto.Changeset

  use Ecto.Schema

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "users" do
    field :session_id, :string
    field :type, Ecto.Enum, values: [:customer, :anonymous], default: :anonymous

    has_many :carts, ECommerce.Shopping.Cart
    has_many :cart_items, ECommerce.Shopping.CartItem
    has_many :orders, ECommerce.Shopping.Order
    has_many :order_items, ECommerce.Shopping.OrderItem
    has_many :payments, ECommerce.Payment

    timestamps(type: :utc_datetime)
  end

  def changeset(user \\ %__MODULE__{}, params) do
    user
    |> Changeset.cast(params, [:type, :session_id])
    |> Changeset.validate_required([:session_id])
    |> Changeset.unique_constraint(:session_id)
  end
end
