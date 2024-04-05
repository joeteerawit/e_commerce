defmodule ECommerceWeb.Shopping.CartLive do
  use ECommerceWeb, :live_view

  alias ECommerce.Shopping.Carts
  alias ECommerce.Shopping.CartItems
  alias ECommerce.Shopping.Orders
  alias ECommerce.Shopping.OrderItems
  alias ECommerce.Users
  alias ECommerceWeb.Forms.CartCheckoutForm

  @impl true
  def mount(_param, %{"session_id" => session_id}, socket) do
    cart = Carts.find_by_session_id(session_id)
    form = CartCheckoutForm.form() |> to_form()

    {:ok, user} = Users.find_by_session_id(session_id)

    total_items_in_cart = CartItems.find_total_items_in_cart(cart)
    total_price = calculate_total_prices(total_items_in_cart)

    case total_items_in_cart do
      [] ->
        new_socket =
          socket
          |> redirect(to: "/")

        {:ok, new_socket}

      _ ->
        new_socket =
          socket
          |> assign(session_id: session_id)
          |> assign(user: user)
          |> assign(form: form)
          |> assign(cart: cart)
          |> assign(total_items_in_cart: total_items_in_cart)
          |> assign(total_price: total_price)

        {:ok, new_socket}
    end
  end

  def handle_event(
        "save",
        %{
          "delivery_address" => delivery_address,
          "payment_channel" => payment_channel
        } = params,
        socket
      ) do
    user = socket.assigns.user
    cart = socket.assigns.cart
    total_price = socket.assigns.total_price
    total_items_in_cart = socket.assigns.total_items_in_cart

    changeset =
      CartCheckoutForm.form(params)
      |> CartCheckoutForm.validate()

    form = to_form(%{changeset | action: :validate})

    case form do
      %Phoenix.HTML.Form{errors: []} ->
        with {:ok, order} <-
               Orders.create(%{
                 user_id: user.id,
                 total_price: total_price,
                 delivery_address: delivery_address
               }),
             {:ok, _} <- OrderItems.create(total_items_in_cart, order.id),
             {_, _} <- CartItems.update_inactive_items(cart.id) do
          new_socket =
            socket
            |> redirect(to: get_redirect_url(payment_channel))

          {:noreply, new_socket}
        end

      _ ->
        new_socket =
          socket
          |> assign(form: form)

        {:noreply, new_socket}
    end
  end

  @impl true
  def handle_event("delete_product_from_cart", %{"value" => cart_item_id}, socket) do
    cart = socket.assigns.cart
    metch_cart_item = find_items_in_cart_by_id(socket.assigns.total_items_in_cart, cart_item_id)

    with {:ok, _} <- CartItems.delete(metch_cart_item),
         total_items_in_cart <- CartItems.find_total_items_in_cart(cart) do
      Process.send_after(self(), :clear_flash, 3000)

      new_socket =
        socket
        |> put_flash(:info, "Delete Product from Cart Successfully!")
        |> assign(total_items_in_cart: total_items_in_cart)
        |> assign(total_price: calculate_total_prices(total_items_in_cart))

      {:noreply, new_socket}
    else
      {:error, _} ->
        {:noreply, socket}
    end
  end

  defp find_items_in_cart_by_id(cart_items, cart_id),
    do: Enum.find(cart_items, &(&1.id == cart_id))

  def sum_product_price(price, quantity) do
    Decimal.mult(price, Decimal.new(quantity))
  end

  defp calculate_total_prices(cart_items) do
    cart_items
    |> Enum.reduce(Decimal.new(0), fn cart_item, acc ->
      Decimal.add(acc, Decimal.mult(cart_item.product.price, cart_item.quantity))
    end)
  end

  defp get_redirect_url(payment_channel) do
    case payment_channel do
      "Credit Card" ->
        "/payments/credit-card"

      "Crypto" ->
        "/payments/crypto"

      "Prompt Pay" ->
        "/payments/prompt-pay"
    end
  end
end
