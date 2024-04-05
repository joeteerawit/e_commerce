defmodule ECommerceWeb.Payments.CreditCardLive do
  use ECommerceWeb, :live_view

  alias ECommerce.Shopping.Orders
  alias ECommerce.Users
  alias ECommerce.Payments
  alias ECommerceWeb.Forms.Payments.CreditCardForm

  @impl true
  def mount(_params, %{"session_id" => session_id}, socket) do
    {:ok, user} = Users.find_by_session_id(session_id)

    order = Orders.find_by_user_id(user.id)
    form = CreditCardForm.form() |> to_form()

    new_socket =
      socket
      |> assign(user: user)
      |> assign(order: order)
      |> assign(form: form)

    {:ok, new_socket}
  end

  @impl true
  def handle_event("submit", params, socket) do
    user = socket.assigns.user
    order = socket.assigns.order
    changeset = CreditCardForm.form(params) |> CreditCardForm.validate()

    to_form(%{changeset | action: :validate})
    |> case do
      %Phoenix.HTML.Form{errors: []} ->
        with {:ok, payment} <-
               Payments.create(%{
                 amount: order.total_price,
                 payment_channel: "credit_card",
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

      form ->
        new_socket =
          socket
          |> assign(form: form)

        {:noreply, new_socket}
    end
  end
end
