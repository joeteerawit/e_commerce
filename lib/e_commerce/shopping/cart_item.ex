defmodule ECommerce.Shopping.CartItem do
  alias Ecto.Changeset

  use Ecto.Schema

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "cart_items" do
    field :quantity, :integer
    field :status, Ecto.Enum, values: [:active, :inactive], default: :active

    belongs_to :cart, ECommerce.Shopping.Cart
    belongs_to :product, ECommerce.Shopping.Product

    timestamps(type: :utc_datetime)
  end

  def changeset(cart \\ %__MODULE__{}, params) do
    cart
    |> Changeset.cast(params, [:quantity, :status])
    |> Changeset.cast_assoc(:cart, with: &ECommerce.Shopping.Cart.changeset/2)
    |> Changeset.cast_assoc(:product, with: &ECommerce.Shopping.Product.changeset/2)
    |> Changeset.validate_required([:quantity])
  end
end
