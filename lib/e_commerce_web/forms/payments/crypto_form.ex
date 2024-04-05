defmodule ECommerceWeb.Forms.Payments.CryptoForm do
  use Ecto.Schema
  alias Ecto.Changeset

  @attributes [:network_name, :coin_name, :wallet_address]

  embedded_schema do
    field :network_name, :string
    field :coin_name, :string
    field :wallet_address, :string
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
