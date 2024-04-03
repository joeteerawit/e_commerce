defmodule ECommerce.Repo.Migrations.AddUser do
  use Ecto.Migration

  def change do
    create table(:users, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :type, :string, default: "anonymous"

      timestamps(type: :utc_datetime)
    end
  end
end
