defmodule ECommerce.Products.Product do
  use Ecto.Schema
  import Ecto.Changeset

  schema "product" do
    field :name, :string
    field :price, :integer
    field :image_url, :string
    field :details, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(product, attrs) do
    product
    |> cast(attrs, [:name, :price, :image_url, :details])
    |> validate_required([:name, :price, :image_url, :details])
  end
end
