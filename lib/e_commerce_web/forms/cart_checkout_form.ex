defmodule ECommerceWeb.Forms.CartCheckoutForm do
  use Ecto.Schema
  alias Ecto.Changeset

  @attributes [:delivery_address, :payment_channel]

  embedded_schema do
    field :delivery_address, :string
    field :payment_channel, :string
  end

  def form do
    form(%__MODULE__{}, %{})
  end

  def form(attributes) do
    changeset(%__MODULE__{}, attributes)
  end

  def form(struct, attributes) do
    changeset(struct, attributes)
  end

  def validate(changeset) do
    changeset
    |> Changeset.validate_required(@attributes)
  end

  def changeset(struct, attributes) do
    struct
    |> Changeset.cast(attributes, @attributes)
  end
end
