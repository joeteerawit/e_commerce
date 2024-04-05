defmodule ECommerce.Repo.Migrations.AddMoreFieldsIntoPayments do
  use Ecto.Migration

  def change do

    alter table(:payments) do
      add :network_name, :string
      add :coin_name, :string
      add :wallet_address, :string
    end
  end
end
