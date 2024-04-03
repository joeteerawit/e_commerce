defmodule ECommerce.Shopping.Cart do
  alias Ecto.Changeset

  use Ecto.Schema

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "carts" do
    field :session_id, :string
    belongs_to :user, ECommerce.User

    timestamps(type: :utc_datetime)
  end

  def changeset(cart \\ %__MODULE__{}, params) do
    cart
    |> Changeset.cast(params, [:session_id, :user_id])
    |> Changeset.validate_required([:session_id, :user_id])
  end
end
