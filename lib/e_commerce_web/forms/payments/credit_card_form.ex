defmodule ECommerceWeb.Forms.Payments.CreditCardForm do
  use Ecto.Schema
  alias Ecto.Changeset

  @attributes [:card_number, :expiry_date, :cvv, :holder_name]

  embedded_schema do
    field :card_number, :string
    field :expiry_date, :string
    field :cvv, :string
    field :holder_name, :string
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
    |> Changeset.validate_format(:card_number, ~r/^\d{16}$/u,
      message: "Invalid card number, should be 16 digits"
    )
    |> Changeset.validate_format(:expiry_date, ~r/^\d{2}\/\d{2}$/u,
      message: "Invalid expiry date, should be in the format MM/YY"
    )
    |> Changeset.validate_format(:cvv, ~r/^\d{3}$/u, message: "Invalid CVV, should be 3 digits")
  end

  def changeset(struct, attributes) do
    struct
    |> Changeset.cast(attributes, @attributes)
  end
end
