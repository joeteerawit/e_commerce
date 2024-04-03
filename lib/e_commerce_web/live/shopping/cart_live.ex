defmodule ECommerceWeb.Shopping.CartLive do
  use ECommerceWeb, :live_view

  @impl true
  def mount(_param, _session, socket) do
    cart_items =
      Enum.map(1..10, fn i ->
        %{
          id: "#{i}",
          name: "Product #{i}",
          price: 10.99,
          quantity: 2,
          image_url: "https://source.unsplash.com/random"
        }
      end)

    new_socket =
      socket
      |> assign(cart_items: cart_items)
      |> assign(total_price: "1,000.00")

    {:ok, new_socket}
  end
end
