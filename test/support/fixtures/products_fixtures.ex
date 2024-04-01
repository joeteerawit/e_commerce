defmodule ECommerce.ProductsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `ECommerce.Products` context.
  """

  @doc """
  Generate a product.
  """
  def product_fixture(attrs \\ %{}) do
    {:ok, product} =
      attrs
      |> Enum.into(%{
        details: "some details",
        name: "some name",
        price: 42
      })
      |> ECommerce.Products.create_product()

    product
  end
end
