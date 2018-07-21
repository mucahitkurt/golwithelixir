defmodule Gameoflife do
  @moduledoc """
  Generate new generation for game of life
  """

  @doc """
  advance to next generation according to alive cells
    - find neigbours for each alive cell
    - find alive count for each alive cells and their neigbours
    - decide next generation alive or dead for each cell
  """
  def advance(aliveCells) do
    aliveCells |>
    Enum.map(&(getCellWithNeighbours(&1))) |>
    List.flatten |>
    Enum.map(&(nextGeneration(&1, aliveCells))) |>
    List.flatten |>
    Enum.uniq
  end

  defp nextGeneration(point, aliveCells) do
    nextGeneration =
      case aliveCount(point, aliveCells) do
         3 -> [point]
         4 -> if Enum.member?(aliveCells, point), do: [point], else: []
         _ -> []
      end
  end

  defp getCellWithNeighbours(point) do
    for x <- -1..1, y <- -1..1, do: %Point{x: point.x + x, y: point.y + y}
  end

  defp aliveCount(point, aliveCells) do
    getCellWithNeighbours(point) |> Enum.filter(&(Enum.member?(aliveCells, &1))) |> Enum.count()
  end

end