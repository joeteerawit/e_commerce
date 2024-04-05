defmodule ECommerceWeb.Router do
  use ECommerceWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {ECommerceWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug ECommerceWeb.Plugs.SessionPlug
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", ECommerceWeb do
    pipe_through :browser

    # get "/", PageController, :home
    live "/", Shopping.Index
    live "/carts", Shopping.CartLive, :carts

    scope "/payments", Payments do
      live "/credit-card", CreditCardLive, :credit_card
      live "/crypto", CryptoLive, :crypto
      live "/prompt-pay", PromptPayLive, :prompt_pay
      live "/completed", CompletedLive, :completed
    end
  end

  scope "/api/webhook", ECommerceWeb.Controllers do
    pipe_through :api

    post "/", PaymentWebHookController, :create
  end

  # Other scopes may use custom stacks.
  # scope "/api", ECommerceWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:e_commerce, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: ECommerceWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
