defmodule Oped.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the PubSub system
      {Phoenix.PubSub, name: Oped.PubSub}
      # Start a worker by calling: Oped.Worker.start_link(arg)
      # {Oped.Worker, arg}
    ]

    Supervisor.start_link(children, strategy: :one_for_one, name: Oped.Supervisor)
  end
end
