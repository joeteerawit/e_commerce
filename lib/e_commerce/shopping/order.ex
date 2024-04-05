defmodule ECommerce.Shopping.Order do
  alias Ecto.Changeset

  use Ecto.Schema

  @attributes [:status, :total_price, :delivery_address, :user_id]
  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "orders" do
    field :status, Ecto.Enum, values: [:created, :paid], default: :created
    field :total_price, :decimal
    field :delivery_address, :string

    belongs_to :user, ECommerce.User

    timestamps(type: :utc_datetime)
  end

  def changeset(order \\ %__MODULE__{}, params) do
    order
    |> Changeset.cast(params, @attributes)
    |> Changeset.validate_required(@attributes)
  end
end
