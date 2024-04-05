defmodule ECommerceWeb.Shopping.Index do
  use ECommerceWeb, :live_view

  alias ECommerce.Shopping.Carts
  alias ECommerce.Shopping.CartItems
  alias ECommerce.Shopping.Products

  @impl true
  def mount(_params, %{"session_id" => session_id} = _session, socket) do
    products = Products.all()
    cart = Carts.find_by_session_id(session_id)

    total_items_in_cart =
      CartItems.find_total_items_in_cart(cart)
      |> calculate_total_items_in_cart()

    new_socket =
      socket
      |> assign(session_id: session_id)
      |> assign(cart: cart)
      |> assign(products: products)
      |> assign(total_items_in_cart: total_items_in_cart)

    {:ok, new_socket}
  end

  @impl true
  def handle_event("add_to_cart", %{"value" => product_id}, socket) do
    session_id = socket.assigns.session_id

    match_product =
      socket.assigns.products
      |> Enum.find(&(&1.id == product_id))

    {:ok, :added} = Products.add_product_into_cart(match_product, session_id)

    cart = Carts.find_by_session_id(session_id)

    Process.send_after(self(), :clear_flash, 3000)

    total_items_in_cart =
      CartItems.find_total_items_in_cart(cart)
      |> calculate_total_items_in_cart()

    new_socket =
      socket
      |> put_flash(:info, "Add Product to Cart Successfully!")
      |> assign(total_items_in_cart: total_items_in_cart)

    {:noreply, new_socket}
  end

  def handle_event("go_to_carts", _params, socket) do
    socket.assigns.total_items_in_cart
    |> case do
      0 ->
        {:noreply, socket}

      _ ->
        new_socket =
          socket
          |> redirect(to: "/carts")

        {:noreply, new_socket}
    end
  end

  @impl true
  def handle_info(:clear_flash, socket) do
    {:noreply, clear_flash(socket)}
  end

  defp calculate_total_items_in_cart([]), do: 0

  defp calculate_total_items_in_cart(items),
    do:
      items
      |> Enum.reduce(0, fn cart_item, acc -> cart_item.quantity + acc end)
end
