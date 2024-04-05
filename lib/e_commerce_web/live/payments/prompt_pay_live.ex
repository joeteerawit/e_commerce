defmodule ECommerceWeb.Payments.PromptPayLive do
  use ECommerceWeb, :live_view

  alias ECommerce.Shopping.Orders
  alias ECommerce.Payments
  alias ECommerce.Users

  @impl true
  def mount(_params, %{"session_id" => session_id}, socket) do
    {:ok, user} = Users.find_by_session_id(session_id)
    order = Orders.find_by_user_id(user.id)

    new_socket =
      socket
      |> assign(user: user)
      |> assign(order: order)

    {:ok, new_socket}
  end

  @impl true
  def handle_event("done", _params, socket) do
    user = socket.assigns.user
    order = socket.assigns.order

    with {:ok, payment} <-
           Payments.create(%{
             amount: order.total_price,
             payment_channel: "prompt_pay",
             reference_id: Ecto.UUID.generate(),
             user_id: user.id,
             order_id: order.id
           }),
         {:ok, _} <- Orders.update_to_paid_status(order.id) do
      new_socket =
        socket
        |> redirect(to: "/payments/completed?payment_id=#{payment.id}")

      {:noreply, new_socket}
    end
  end
end
