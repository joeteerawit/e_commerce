defmodule ECommerce.Payment do
  use Ecto.Schema

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "payments" do
    field :amount, :decimal
    field :status, :string
    field :payment_channel, :string

    belongs_to :order, ECommerce.Shopping.Order

    timestamps(type: :utc_datetime)
  end
end
