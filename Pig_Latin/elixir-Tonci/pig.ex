defmodule Pig do
  @vowels ~w(a e i o u)

  def latin(string) do
    string
    |> String.split(~r{\W}, include_captures: true)
    |> Enum.map(&latin_word/1)
    |> Enum.join("")
  end

  defp latin_word(""), do: ""

  defp latin_word(<< first :: binary-size(1), _rest :: binary >> = word) when first in @vowels do
    word <> "way"
  end

  defp latin_word(<< first :: binary-size(1), rest :: binary >> = word) do
    cond do
      String.match?(word, ~r{\W}) ->
        word
      String.upcase(first) == first ->
        String.capitalize(move_consonants(rest <> String.downcase(first))) <> "ay"
      true ->
       move_consonants(rest <> first) <> "ay"
    end
  end

  defp move_consonants(<< first :: binary-size(1), _rest :: binary >> = word) when first in @vowels, do: word
  defp move_consonants(<< first :: binary-size(1), rest :: binary >> ) do
    move_consonants(rest <> first)
  end
end
