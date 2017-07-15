defmodule Myapp.Router do
  use Plug.Router

  plug :match
  plug :dispatch

  def start_link() do
    {:ok, _} = Plug.Adapters.Cowboy.http(Myapp.Router, [], [port: 4000])
  end

  get "/hello" do
    conn
    |> put_resp_header("content-type", "text/html")
    |> send_resp(200, "Hello!")
  end

  get "/" do
    {:ok, pokemon} = Myapp.ApiServer.get_pokemon(1)

    page = EEx.eval_file("templates/home.html", name: ["Heather"])
    conn
    |> put_resp_header("content-type", "text/html")
    |> send_resp(200, page)
  end

  match _ do
    conn
    |> send_resp(404, "Not found")
    |> halt
  end
end
