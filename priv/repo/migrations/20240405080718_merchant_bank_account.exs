defmodule ECommerce.Repo.Migrations.MerchantBankAccount do
  use Ecto.Migration

  def change do
    create table(:merchant_bank_accounts, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :account_number, :string
      add :account_name, :string
      add :bank_name, :string
      add :bank_branch, :string
      add :account_type, :string

      timestamps()
    end

    alter table(:merchants) do
      add :merchant_bank_account, references(:merchant_bank_accounts, type: :binary_id)
    end
  end
end
