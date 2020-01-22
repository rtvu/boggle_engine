defmodule BoggleEngine.Neighbor do
  @moduledoc false

  alias BoggleEngine.Neighbor.Transform.CornerFilter
  alias BoggleEngine.Neighbor.Transform.EdgeFilter
  alias BoggleEngine.Neighbor.Transform.StandardMap
  alias BoggleEngine.Neighbor.Transform.WrapMap

  @preset_rules [:standard, :edge, :corner, :wrap, :edge_wrap, :corner_wrap]

  # Gets list of neighbor positions.
  def get_neighbors(position, size, rules) do
    transform =
      cond do
        is_function(rules) -> rules
        rules in @preset_rules -> get_rules(rules)
        true -> nil
      end

    case transform do
      nil ->
        []
      _ ->
        for i <- [-1, 0, 1],
            j <- [-1, 0, 1],
            abs(i) + abs(j) > 0,
            {:ok, neighbor, _} <- [transform.({:ok, nil, {position, i, j, size}})] do
          neighbor
        end
    end
  end

  # Gets rules based on key.
  #
  # Anonymous functions cannot be defined during compile time. So function
  # call is necessary to generate and retrieve the rules transform.
  defp get_rules(key) do
    case key do
      :standard -> &(&1 |> StandardMap.transform())
      :edge -> &(&1 |> EdgeFilter.transform() |> StandardMap.transform())
      :corner -> &(&1 |> CornerFilter.transform() |> StandardMap.transform())
      :wrap -> &(&1 |> WrapMap.transform())
      :edge_wrap -> &(&1 |> EdgeFilter.transform() |> WrapMap.transform())
      :corner_wrap -> &(&1 |> CornerFilter.transform() |> WrapMap.transform())
    end
  end
end
