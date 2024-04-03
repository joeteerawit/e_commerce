defmodule ECommerce.Repo.Migrations.AddOrder do
  use Ecto.Migration

  def change do
    create table(:orders, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :status, :string, default: "created"
      add :total_price, :decimal
      add :delivery_address, :string

      add :user_id, references(:users, type: :binary_id)

      timestamps(type: :utc_datetime)
    end
  end
end
