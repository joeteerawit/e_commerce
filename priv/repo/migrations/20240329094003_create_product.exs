defmodule ECommerce.Repo.Migrations.CreateProduct do
  use Ecto.Migration

  def change do
    create table(:products, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string
      add :price, :integer
      add :image_url, :string
      add :description, :string

      add :merchant_id, references(:merchants, type: :binary_id, on_delete: :delete_all)
      timestamps(type: :utc_datetime)
    end
  end
end
