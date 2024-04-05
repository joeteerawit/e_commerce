defmodule ECommerce.Shopping.Cart do
  alias Ecto.Changeset

  use Ecto.Schema

  @attributes [:session_id, :user_id]
  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "carts" do
    field :session_id, :string
    belongs_to :user, ECommerce.User

    timestamps(type: :utc_datetime)
  end

  def changeset(cart \\ %__MODULE__{}, params) do
    cart
    |> Changeset.cast(params, @attributes)
    |> Changeset.validate_required(@attributes)
    |> Changeset.unique_constraint(:session_id)
  end
end
