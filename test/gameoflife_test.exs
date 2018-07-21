defmodule GameoflifeTest do
  use ExUnit.Case
  doctest Gameoflife

  test "one alive cell advance to empty board" do
  	boardPattern = "*oo\nooo\nooo"
  	aliveCells = generateAliveCells(boardPattern)
  	assert length(aliveCells) == 1
  	
  	nextGeneration = Gameoflife.advance(aliveCells)
  	nextGeneration |> IO.puts 
  	assert length(nextGeneration) == 0
  end

  test "block" do
  	boardPattern = "**\n**"
  	nextGeneration = Gameoflife.advance(generateAliveCells(boardPattern))
  	assert length(nextGeneration) == 4
  end

  test "oscillator" do
  	boardPattern = "ooo\n***\nooo"
  	nextGeneration = Gameoflife.advance(generateAliveCells(boardPattern))
  	assert length(nextGeneration) == 3
  	assert Enum.member?(nextGeneration, %Point{x: 1, y: 0})
  	assert Enum.member?(nextGeneration, %Point{x: 1, y: 1})
  	assert Enum.member?(nextGeneration, %Point{x: 1, y: 2})
  end

  defp generateAliveCells(boardPattern) do
  	aliveCells(String.codepoints(boardPattern), [], 0, 0)
  end

  defp aliveCells([h | t], aliveCells, x, y) do
  	case h do
  		"\n" ->
  			aliveCells(t, aliveCells, 0, y+1)
		"*" ->
			aliveCells(t, aliveCells ++ [%Point{x: x, y: y}], x+1, y)
	  	_ ->
  			aliveCells(t, aliveCells, x+1, y)
	end
  end

  defp aliveCells([], aliveCells, x, y) do
  	aliveCells
  end
end
