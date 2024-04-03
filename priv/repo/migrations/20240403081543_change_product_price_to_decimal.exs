defmodule ECommerce.Repo.Migrations.ChangeProductPriceToDecimal do
  use Ecto.Migration

  def change do
    alter table(:products) do
      modify :price, :decimal
    end
  end
end
