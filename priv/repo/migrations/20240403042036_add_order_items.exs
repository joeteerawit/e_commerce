defmodule ECommerce.Repo.Migrations.AddOrderItems do
  use Ecto.Migration

  def change do
    create table(:order_items, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :quantity, :integer
      add :price, :decimal
      add :order_id, references(:orders, type: :binary_id, on_delete: :delete_all)
      add :product_id, references(:products, type: :binary_id)

      timestamps(type: :utc_datetime)
    end
  end
end
