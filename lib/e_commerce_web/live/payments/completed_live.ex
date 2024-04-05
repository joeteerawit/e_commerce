defmodule ECommerceWeb.Payments.CompletedLive do
  use ECommerceWeb, :live_view

  alias ECommerce.Shopping.OrderItems
  alias ECommerce.Users
  alias ECommerce.Payments

  @impl true
  def mount(params, %{"session_id" => session_id}, socket) do
    payment_id = params["payment_id"]
    {:ok, user} = Users.find_by_session_id(session_id)
    {:ok, payment} = Payments.find_by_id(payment_id)
    orders = OrderItems.find_by_user_id(user.id)

    new_socket =
      socket
      |> assign(user: user)
      |> assign(payment: payment)
      |> assign(orders: orders)

    {:ok, new_socket}
  end
end
