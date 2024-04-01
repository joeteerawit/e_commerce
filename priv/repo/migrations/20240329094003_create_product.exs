defmodule ECommerce.Repo.Migrations.CreateProduct do
  use Ecto.Migration

  def change do
    create table(:product) do
      add :name, :string
      add :price, :integer
      add :details, :string

      timestamps(type: :utc_datetime)
    end
  end
end
