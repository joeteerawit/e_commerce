defmodule ECommerce.Shopping.OrderItem do
  use Ecto.Schema

  @attributes [:quantity, :price]
  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "order_items" do
    field :quantity, :integer
    field :price, :decimal
    belongs_to :order, ECommerce.Shopping.Order
    belongs_to :product, ECommerce.Shopping.Product

    timestamps(type: :utc_datetime)
  end

  def changeset(order_item \\ %__MODULE__{}, params) do
    order_item
    |> Ecto.Changeset.cast(params, @attributes)
    |> Ecto.Changeset.cast_assoc(:order, with: &ECommerce.Shopping.Order.changeset/2)
    |> Ecto.Changeset.cast_assoc(:product, with: &ECommerce.Shopping.Product.changeset/2)
    |> Ecto.Changeset.validate_required(@attributes)
  end
end
