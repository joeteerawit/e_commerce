defmodule ECommerce.Shopping.Product do
  use Ecto.Schema
  import Ecto.Changeset

  @attributes [:name, :price, :image_url, :description]

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "products" do
    field :name, :string
    field :price, :decimal
    field :image_url, :string
    field :description, :string

    belongs_to :merchant, ECommerce.Merchant

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(product, attrs) do
    product
    |> cast(attrs, @attributes)
    |> validate_required(@attributes)
  end
end
