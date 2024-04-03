defmodule ECommerceWeb.Shopping.Index do
  use ECommerceWeb, :live_view

  alias ECommerce.Shopping.Products

  @impl true
  def mount(_params, %{"session_id" => session_id} = _session, socket) do
    products = Products.all()

    new_socket =
      socket
      |> assign(session_id: session_id)
      |> assign(products: products)

    {:ok, new_socket}
  end

  @impl true
  def handle_event("add_to_cart", %{"value" => product_id}, socket) do
    match_product =
      socket.assigns.products
      |> Enum.find(&(&1.id == product_id))

    IO.inspect(match_product)
    r = Products.add_product_into_cart(match_product, socket.assigns.session_id)
    IO.inspect(r, label: "add_product_into_cart")

    new_socket =
      socket
      |> put_flash(:info, "Add Product to Cart Successfully!")

    {:noreply, new_socket}
  end
end
