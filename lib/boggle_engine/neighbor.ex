defmodule BoggleEngine.Neighbor do
  @moduledoc """
  Functions to determine neighbors.
  """

  alias BoggleEngine.Neighbor.Transform
  alias BoggleEngine.Neighbor.Transform.CornerFilter
  alias BoggleEngine.Neighbor.Transform.EdgeFilter
  alias BoggleEngine.Neighbor.Transform.StandardMap
  alias BoggleEngine.Neighbor.Transform.WrapMap

  @preset_rules [:standard, :edge, :corner, :wrap, :edge_wrap, :corner_wrap]

  @type rule :: :standard | :edge | :corner | :wrap | :edge_wrap | :corner_wrap | (state -> state)
  @type state :: Transform.state
  @type position :: integer
  @type size :: 4 | 5 | 6

  @typedoc false
  @type key :: :standard | :edge | :corner | :wrap | :edge_wrap | :corner_wrap

  @doc """
  Gets list of neighbor positions.
  """
  @spec get_neighbors(position, size, rule) :: [position]
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
  @spec get_rules(key) :: rule
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
