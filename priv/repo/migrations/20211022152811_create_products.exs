defmodule Kefis3.Repo.Migrations.CreateProducts do
  use Ecto.Migration

  def change do
    create table(:products)do
      add :name, :string
      add :price, :integer
      add :quantity, :integer

      timestamps()
    end
  end
end
