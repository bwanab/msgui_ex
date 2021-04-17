defmodule MsguiWeb.PlayController do
  use MsguiWeb, :controller
  import Logger

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def play(conn, %{"example" => example}) do
    examples_dir = Application.get_env(:msgui, :examples_dir)
    filename = Path.join(examples_dir, example <> ".json")
    Logger.info("filename = #{filename}")
    {controls, node_map, connections} = Modsynth.Rand.play(filename)
    json(conn, %{playing: example, node_map: node_map, connections: connections})
  end

  def list(conn, _param) do
    examples_dir = Application.get_env(:msgui, :examples_dir)
    circuits = File.ls!(examples_dir) |> Enum.filter(&(String.ends_with?(&1, ".json"))) |> Enum.sort
    json(conn, circuits)
  end

  def stop(conn, _) do
    Modsynth.Rand.stop_playing()
    # render(conn, "stop.html")
    json(conn, %{playing: "stopped"})
  end

  def bus_vals(conn, %{"bus_ids" => bus_ids_string}) do
    bus_ids = Enum.map(String.split(bus_ids_string, ","), fn bus_id_string -> String.to_integer(bus_id_string) end)
    Logger.info("bus_ids: #{inspect(bus_ids)}")
    json(conn, %{bus_map:
                 Enum.map(bus_ids, fn bus_id ->
                   %{bus_id: bus_id, bus_val: if bus_id != 0 do ScClient.get_bus_val(bus_id) else 0 end}
                 end )
                })
  end
end
