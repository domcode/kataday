defmodule BJ do

  def value(cards) do
    num_aces = Enum.count(cards, &(&1 == "A"))

    [num_aces | cards]
    |> Enum.map(&translate_value/1)
    |> Enum.reduce(&Kernel.+/2)
    |> best_hand(num_aces)
    |> normalize_result(cards)
  end

  def winner(hands) do
    score = Enum.map(hands, fn({name, hand}) -> {name, value(hand)} end)
    {_, max_score} = Enum.max_by(score, fn({_name, value}) -> value end)

    Enum.filter(score, fn({_, value}) -> value == max_score end)
    |> Enum.map(fn({name, _}) -> to_string(name) end)
  end

  def best_hand(acc, 0), do: acc
  def best_hand(result, aces) do
    new_score = cond do
      result + 10 < 22 ->
        result + 10
      true ->
        result + 0
    end
    best_hand(new_score, aces - 1)
  end

  defp normalize_result(result, cards) do
    cond do
      result > 21 ->
        0
      Enum.count(cards) > 4 ->
        0
      true ->
        result
    end
  end

  @pics ~w(K Q J)

  defp translate_value(card) when card in @pics, do: 10
  defp translate_value("A"), do: 0
  defp translate_value(card), do: card
end
