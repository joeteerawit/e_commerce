defmodule ECommerce.Payment do
  alias Ecto.Changeset

  use Ecto.Schema

  @required [:amount, :payment_channel, :reference_id, :order_id, :user_id]
  @attributes @required ++ [:status, :transaction_id, :network_name, :coin_name, :wallet_address]

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "payments" do
    field :amount, :decimal
    field :network_name, :string
    field :coin_name, :string
    field :wallet_address, :string
    field :status, Ecto.Enum, values: [:submited, :success, :failed], default: :submited
    field :payment_channel
    field :reference_id, :string
    field :transaction_id, :string

    belongs_to :order, ECommerce.Shopping.Order
    belongs_to :user, ECommerce.User

    timestamps(type: :utc_datetime)
  end

  def changeset(payment, attrs) do
    payment
    |> Changeset.cast(attrs, @attributes)
    |> Changeset.validate_required(@required)
  end
end
