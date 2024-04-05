defmodule ECommerce.Repo.Migrations.AddUserIntoOrderItems do
  use Ecto.Migration

  def change do
    alter table(:order_items) do
      add :user_id, references(:users, type: :binary_id)
    end
  end
end
