defmodule ECommerce.Repo.Migrations.AddPaymentChannel do
  use Ecto.Migration

  def change do
    alter table(:payments) do
      add :payment_channel, :string
      add :user_id, references(:users, type: :binary_id)
    end
  end
end
