defmodule ECommerce.User do
  alias Ecto.Changeset

  use Ecto.Schema

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "users" do
    field :session_id, :string
    field :type, Ecto.Enum, values: [:customer, :anonymous], default: :anonymous

    timestamps(type: :utc_datetime)
  end

  def changeset(user \\ %__MODULE__{}, params) do
    user
    |> Changeset.cast(params, [:type, :session_id])
    |> Changeset.validate_required([:session_id])
    |> Changeset.unique_constraint(:session_id)
  end
end
