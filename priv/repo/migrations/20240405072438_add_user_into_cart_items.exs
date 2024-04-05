defmodule ECommerce.Repo.Migrations.AddUserIntoCartItems do
  use Ecto.Migration

  def change do
    alter table(:cart_items) do
      add :user_id, references(:users, type: :binary_id)
    end
  end
end
