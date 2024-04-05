defmodule ECommerce.Shopping.CartItem do
  alias Ecto.Changeset

  use Ecto.Schema

  @attributes [:quantity, :status, :cart_id, :product_id, :user_id]
  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "cart_items" do
    field :quantity, :integer
    field :status, Ecto.Enum, values: [:active, :inactive], default: :active

    belongs_to :cart, ECommerce.Shopping.Cart
    belongs_to :product, ECommerce.Shopping.Product
    belongs_to :user, ECommerce.User

    timestamps(type: :utc_datetime)
  end

  def changeset(cart \\ %__MODULE__{}, params) do
    cart
    |> Changeset.cast(params, @attributes ++ [:status])
    |> Changeset.validate_required(@attributes)
  end
end
