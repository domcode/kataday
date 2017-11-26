import Data.Char
import Data.List

testSet = [
   ("Dennis", [1,2,3]),
   ("Arian", [4,5,6]),
   ("Ross", [0,0,0,0]),
   ("Aisha", [9,9,0,1,1,1,1]),
   ("Lucas", [0, 10,1])
 ]

-- Given a set of cards

-- If the set has no Ace, it's simply the sum
-- If the set _has_ an Ace, see if the value is over 21 when counted as eleven
-- 

isOverTwentyone :: Integer -> Bool
isOverTwentyone sum = sum > 21

isAce card = card == 0

sumSetOfCards :: [Integer] -> Integer
sumSetOfCards cards =
  let sortedCards = sort cards
  in
  if any isAce sortedCards
  then
    deriveMinimumScoreOfCards sortedCards
  else
    sum sortedCards

replaceFirstIfAce :: [Integer] -> [Integer]
replaceFirstIfAce (head:cards) =
  if head == 11
  then
    1 : cards
  else
    head : cards

deriveMinimumScoreOfCards :: [Integer] -> Integer
deriveMinimumScoreOfCards cards =
  let maxList = map (\i -> if isAce i then 11 else i) cards 
  --let newList = delete 11 cards
  in
    if isOverTwentyone (sum maxList)
    then
      -- Do remind to re replace and sort.
      deriveMinimumScoreOfCards (sort (map (\i -> if i == 11 then 0 else i) (replaceFirstIfAce maxList))) 
    else
      sum maxList

hasTooManyCards :: [Integer] -> Bool
hasTooManyCards cards = length cards > 5 

-- has too many cards implementeren (filter)
stillPlaying = filter (\(name, cards) -> not (hasTooManyCards cards)) testSet


testSetWithSum = map (\(name, cards) -> (name, sumSetOfCards cards)) stillPlaying


winner = fst (head (reverse (sortOn snd testSetWithSum)))



main = putStrLn ("Winner winner chicken dinner: " ++ winner ++ "\n" ++ show testSetWithSum)





