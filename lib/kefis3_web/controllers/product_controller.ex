defmodule Kefis3Web.ProductController do
  use Kefis3Web, :controller

  alias Kefis3Web.Product
  alias Kefis3.Repo

  def inventory(conn, _params) do
    products = Repo.all(Product)

    render conn, "inventory.html", products: products
  end

  def new(conn, _params) do
    changeset = Product.changeset(%Product{}, %{})

    render conn, "new.html", changeset: changeset
  end

  def create(conn, %{"product" => product}) do
    changeset = Product.changeset(%Product{}, product)

    case Repo.insert(changeset) do
      {:ok, _product} ->
        conn
        |> put_flash(:info, "Product Created")
        |> redirect(to: Routes.product_path(conn, :inventory))
      {:error, changeset} ->
        render conn, "new.html", changeset: changeset
    end
  end

  def edit(conn, %{"id" => product_id}) do
    product = Repo.get(Product, product_id)
    changeset = Product.changeset(product)

    render conn, "edit.html", changeset: changeset, product: product
  end
  def update(conn, %{"id" => product_id, "product" => product}) do
    old_product = Repo.get(Product, product_id)
    changeset = Product.changeset(old_product, product)

   case Repo.update(changeset) do
   {:ok, _product} ->
    conn
    |> put_flash(:info, "Product Updated succesfully")
    |> redirect(to: Routes.product_path(conn, :inventory))
    {:error, changeset} ->
      render conn, "edit.html", changeset: changeset, product: old_product
   end
  end


  def sell(conn, %{"id" => product_id}) do
    product = Repo.get(Product, product_id)
    changeset = Product.changeset(product)
    render conn, "sell.html", changeset: changeset, product: product
  end


  @doc """
  A product map is submitted by the form, pattern match to get the amount sold value
  Change the amount sold value to an integer then perform the calculation and update the value

  """
  def sold(conn, %{"id" => product_id, "product" => product}) do

    %{"amount_sold" => amount_sold} = product
    amount_sold = amount_sold
      |> String.to_integer

    old_product = Repo.get(Product, product_id)

    changeset = Product.sell_changeset(old_product, %{quantity: old_product.quantity - amount_sold})

    case Repo.update(changeset) do
    {:ok, _product} ->
      conn
      |> put_flash(:info, "Sold #{amount_sold} item(s).")
      |> redirect(to: Routes.product_path(conn, :inventory))
      {:error, changeset} ->
        render conn, "sell.html", changeset: changeset, product: old_product
    end
  end



end
