defmodule ECommerce.Repo.Migrations.AddPayments do
  use Ecto.Migration

  def change do
    create table(:payments, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :amount, :decimal
      add :status, :string, default: "pending"
      add :order_id, references(:orders, type: :binary_id)

      timestamps(type: :utc_datetime)
    end
  end
end
