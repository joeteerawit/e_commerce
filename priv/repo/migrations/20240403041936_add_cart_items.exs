defmodule ECommerce.Repo.Migrations.AddCartItems do
  use Ecto.Migration

  def change do
    create table(:cart_items, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :quantity, :integer
      add :status, :string, default: "active"
      add :cart_id, references(:carts, type: :binary_id)
      add :product_id, references(:products, type: :binary_id)

      timestamps(type: :utc_datetime)
    end
  end
end
