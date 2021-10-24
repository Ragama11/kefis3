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


  def sell(conn, ) do
    
  end

end
