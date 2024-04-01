defmodule ECommerceWeb.ProductLive.Checkout do
  use ECommerceWeb, :live_view

  @impl true
  def mount(_param, _session, socket) do
    cart_items = [
      %{
        id: "1",
        name: "Product 1",
        price: 10.99,
        quantity: 1,
        image_url: "https://source.unsplash.com/random"
      },
      %{
        id: "2",
        name: "Product 2",
        price: 19.99,
        quantity: 1,
        image_url: "https://source.unsplash.com/random"
      }
    ]

    new_socket =
      socket
      |> assign(cart_items: cart_items)
      |> assign(total_price: 1000.00)

    {:ok, new_socket}
  end
end
