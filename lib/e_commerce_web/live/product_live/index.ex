defmodule ECommerceWeb.ProductLive.Index do
  use ECommerceWeb, :live_view

  alias ECommerce.Products.Product

  @impl true
  def mount(_params, _session, socket) do
    products =
      [
        %Product{
          id: "1",
          name: "Product 1",
          price: 10.99,
          details: "Lorem ipsum dolor sit amet.",
          image_url: "https://source.unsplash.com/random"
        },
        %Product{
          id: "2",
          name: "Product 2",
          price: 19.99,
          details: "Consectetur adipiscing elit.",
          image_url: "https://source.unsplash.com/random"
        },
        %Product{
          id: "3",
          name: "Product 3",
          price: 7.99,
          details: "Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
          image_url: "https://source.unsplash.com/random"
        },
        %Product{
          id: "4",
          name: "Product 4",
          price: 14.99,
          details: "Ut enim ad minim veniam.",
          image_url: "https://source.unsplash.com/random"
        },
        %Product{
          id: "5",
          name: "Product 5",
          price: 8.99,
          details: "Quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
          image_url: "https://source.unsplash.com/random"
        },
        %Product{
          id: "6",
          name: "Product 6",
          price: 12.99,
          details: "Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.",
          image_url: "https://source.unsplash.com/random"
        },
        %Product{
          id: "7",
          name: "Product 7",
          price: 9.99,
          details: "Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
          image_url: "https://source.unsplash.com/random"
        },
        %Product{
          id: "8",
          name: "Product 8",
          price: 16.99,
          details: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
          image_url: "https://source.unsplash.com/random"
        },
        %Product{
          id: "9",
          name: "Product 9",
          price: 11.99,
          details: "Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
          image_url: "https://source.unsplash.com/random"
        },
        %Product{
          id: "10",
          name: "Product 10",
          price: 13.99,
          details: "Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.",
          image_url: "https://source.unsplash.com/random"
        }
      ]

    new_socket =
      socket
      |> assign(products: products)

    {:ok, new_socket}
  end
end
