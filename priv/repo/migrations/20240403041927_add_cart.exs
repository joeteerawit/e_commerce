defmodule ECommerce.Repo.Migrations.AddCart do
  use Ecto.Migration

  def change do
    create table(:carts, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :session_id, :string
      add :user_id, references(:users, type: :binary_id)

      timestamps(type: :utc_datetime)
    end
  end
end
