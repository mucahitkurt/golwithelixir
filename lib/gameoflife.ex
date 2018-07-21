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
    Enum.map(&(getCellWithNeigbours(&1, [-1, 0, 1], []))) |>
    List.flatten |>
    Enum.map(&(nextGeneration(&1, aliveCells))) |>
    List.flatten |>
    Enum.uniq
  end

  defp nextGeneration(point, aliveCells) do
    nextGeneration = []
    aliveCount = aliveCount(point, aliveCells)
    case aliveCount do
       3 ->
          nextGeneration = [point | nextGeneration]                        
       4 ->
          if Enum.member?(aliveCells, point) do
            nextGeneration = [point | nextGeneration]
          else
            nextGeneration
          end
        _ ->
          nextGeneration
    end
  end

  defp getCellWithNeigbours(point, y, cellWithNeigbours) do
    getCellWithNeigbours(point, -1, y, cellWithNeigbours) ++
    getCellWithNeigbours(point, 0, y, cellWithNeigbours) ++
    getCellWithNeigbours(point, 1, y, cellWithNeigbours)
  end

  defp getCellWithNeigbours(point, x, [hy | ty], cellWithNeigbours) do
    getCellWithNeigbours(point, x, ty, [%Point{x: point.x + x, y: point.y + hy} | cellWithNeigbours])
  end

  defp getCellWithNeigbours(point, x, y, cellWithNeigbours) when length(y) === 0 do
    cellWithNeigbours
  end

  defp aliveCount(point, aliveCells) do
    getCellWithNeigbours(point, [-1,0,1], []) |> Enum.filter(&(Enum.member?(aliveCells, &1))) |> Enum.count()
  end

end