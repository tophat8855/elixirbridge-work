defmodule Myapp do
  use Application

  @doc """
  Start Myapp here with arguments

  Examples:

    Myapp.start([], [])
  """
  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      worker(Myapp.Router, [])
    ]

    opts = [
      strategy: :one_for_one, name: Myapp.Supervisor
    ]
    Supervisor.start_link(children, opts)
  end
end
