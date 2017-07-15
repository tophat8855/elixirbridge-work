defmodule Myapp.ApiServer do
  use GenServer

  require Poison
  require HTTPoison

  def init(_) do
    {:ok, []}
  end

  @doc """
  A method for calling the pokemon api
  """
  def get_pokemon(id_or_name) do
    GenServer.call(__MODULE__, {:get_pokemon, id_or_name})
  end

  def start_link(_, _) do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def handle_call({:get_pokemon, id_or_name}, _pid, state) do
    response = get_pokemon_request(id_or_name)
    {:reply, response, state}
  end

  def handle_call(_term, _pid, state) do
    {:reply, [], state}
  end

  def handle_cast(_term, state) do
    {:noreply, state}
  end

  def terminate do
    :ok
  end

  def get_pokemon_request(id_or_name) do
    url = api_route("pokemon/#{id_or_name}/")

    case HTTPoison.get(url, [], [])  do
      {:error, %HTTPoison.Error{reason: reason}} ->
        {:error, reason}
      {:ok, %HTTPoison.Response{body: body}} ->
        {:ok, process(body)}
    end
  end

  defp api_route(path) do
    "http://pokeapi.co/api/v2/#{path}"
  end

  defp process(body) do
    body |> Poison.decode!
  end
end
