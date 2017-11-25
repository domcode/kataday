defmodule BottlesSong do
  def verse(0) do
    """
No more bottles of beer on the wall, no more bottles of beer.
Go to the store and buy some more, 99 bottles of beer on the wall.
  """
  end

  def verse(num) do
    """
#{bottles(num)} of beer on the wall, #{bottles(num)} of beer.
Take one down and pass it around, #{bottles(num - 1)} of beer on the wall.
    """
  end

  def bottles(n) do
    case n do
      0 -> "no more bottles"
      1 -> "1 bottle"
      num -> "#{num} bottles"
    end

  end

  def verse(first, last) do
    (for n <- first..last, do: verse(n))
    |> Enum.join("\n\n")
  end
end
