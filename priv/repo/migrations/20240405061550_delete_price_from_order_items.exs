defmodule ECommerce.Repo.Migrations.DeletePriceFromOrderItems do
  use Ecto.Migration

  def change do
    alter table(:order_items) do
      remove :price
    end
  end
end
