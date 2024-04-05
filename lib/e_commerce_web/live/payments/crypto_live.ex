defmodule ECommerceWeb.Payments.CryptoLive do
  use ECommerceWeb, :live_view

  alias ECommerce.Shopping.Orders
  alias ECommerce.Payments
  alias ECommerce.Users
  alias ECommerceWeb.Forms.Payments.CryptoForm

  @impl true
  def mount(_params, %{"session_id" => session_id}, socket) do
    {:ok, user} = Users.find_by_session_id(session_id)

    order = Orders.find_by_user_id(user.id)
    form = CryptoForm.form() |> to_form()

    new_socket =
      socket
      |> assign(user: user)
      |> assign(order: order)
      |> assign(form: form)

    {:ok, new_socket}
  end

  @impl true
  def handle_event(
        "submit",
        %{
          "network_name" => network_name,
          "coin_name" => coin_name,
          "wallet_address" => wallet_address
        } = params,
        socket
      ) do
    user = socket.assigns.user
    order = socket.assigns.order
    changeset = CryptoForm.form(params) |> CryptoForm.validate()

    to_form(%{changeset | action: :validate})
    |> case do
      %Phoenix.HTML.Form{errors: []} ->
        with {:ok, payment} <-
               Payments.create(%{
                 amount: order.total_price,
                 order_id: order.id,
                 user_id: user.id,
                 reference_id: Ecto.UUID.generate(),
                 network_name: network_name,
                 coin_name: coin_name,
                 wallet_address: wallet_address,
                 payment_channel: "crypto"
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
