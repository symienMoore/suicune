defmodule ServerWeb.Router do
  use ServerWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  #? /messages the route
  #? MessageController the controller
  #? :index the function from the controller (what the route should do when called)
  scope "/api", ServerWeb do
    pipe_through :api
    get "/messages", MessageController, :index, except: [:new, :edit]
  end

  scope "/api", ServerWeb do
    pipe_through :api
    post "/messages", MessageController, :create
  end

  scope "/api", ServerWeb do
    pipe_through :api
    get "/messages/:id", MessageController, :show
  end
  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:server, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through [:fetch_session, :protect_from_forgery]
      live_dashboard "/dashboard", metrics: ServerWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
