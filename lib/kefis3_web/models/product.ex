defmodule Kefis3Web.Product do
  use Kefis3Web, :model

  schema "products" do
    field :name, :string
    field :price, :integer
    field :quantity, :integer

    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :price, :quantity])
    |> validate_required([:name, :price, :quantity])
  end
end
