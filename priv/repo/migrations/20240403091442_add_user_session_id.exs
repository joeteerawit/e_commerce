defmodule ECommerce.Repo.Migrations.AddUserSessionId do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :session_id, :string
    end

    create unique_index(:users, [:session_id])
  end
end
