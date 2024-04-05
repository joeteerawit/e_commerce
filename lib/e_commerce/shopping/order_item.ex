defmodule ECommerce.Shopping.OrderItem do
  use Ecto.Schema

  @attributes [:quantity, :order_id, :product_id, :user_id]
  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "order_items" do
    field :quantity, :integer

    belongs_to :order, ECommerce.Shopping.Order
    belongs_to :product, ECommerce.Shopping.Product
    belongs_to :user, ECommerce.User

    timestamps(type: :utc_datetime)
  end

  def changeset(order_item \\ %__MODULE__{}, params) do
    order_item
    |> Ecto.Changeset.cast(params, @attributes)
    |> Ecto.Changeset.validate_required(@attributes)
  end
end
