defmodule ECommerce.Repo.Migrations.AddReferenceIdIntoPayments do
  use Ecto.Migration

  def change do
    alter table(:payments) do
      add :reference_id, :string
    end
  end
end
