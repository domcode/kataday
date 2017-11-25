module Main where

import Data.List (intersperse, maximumBy)

type Points = Int

data Card = Two | Three | Four | Five | Six | Seven | Eight | Nine | Ten | Jack | Queen | King | Ace
  deriving (Show)

type Name = String

type Hand = [Card]

data Player = Player Name Hand
  deriving (Show)

type RatedPlayer = (Player, Points)

cardValues :: Card -> [Points]
cardValues Two   = [2]
cardValues Three = [3]
cardValues Four  = [4]
cardValues Five  = [5]
cardValues Six   = [6]
cardValues Seven = [7]
cardValues Eight = [8]
cardValues Nine  = [9]
cardValues Ten   = [10]
cardValues Jack  = [10]
cardValues Queen = [10]
cardValues King  = [10]
cardValues Ace   = [1, 11]

players :: [Player]
players =
  [ Player "Player 1" [ Ace  , Jack         ] -- => 21
  , Player "Player 2" [ Ace  , Ten  , Ace   ] -- => 12
  , Player "Player 3" [ Eight, Ace  , Ace   ] -- => 20
  , Player "Player 4" [ Five , Three, Seven ] -- => 15
  , Player "Player 5" [ King , Queen, Jack  ] -- => went over 21!]
  ]

safeMaximum :: Ord a => [a] -> Maybe a
safeMaximum [] = Nothing
safeMaximum xs = Just $ maximum xs

withoutTooManyCards :: Player -> Bool
withoutTooManyCards (Player _ hand) = length hand <= 5

ratePlayer :: Player -> Maybe RatedPlayer
ratePlayer p@(Player _ hand) = case getHandValue hand of
                                 Nothing     -> Nothing
                                 Just points -> Just (p, points)
  where -- the magic is in sequence https://stackoverflow.com/a/32476604/1833322
        getHandValue :: Hand -> Maybe Points
        getHandValue hand = safeMaximum $ filter (<= 21) $ map sum $ sequence $ map cardValues hand

compareRatedPlayer :: Maybe RatedPlayer -> Maybe RatedPlayer -> Ordering
compareRatedPlayer Nothing             b                   = LT
compareRatedPlayer a                   Nothing             = GT
compareRatedPlayer (Just (_, points1)) (Just (_, points2)) = compare points1 points2

kata4 :: Maybe (Player, Points)
kata4 = case filter withoutTooManyCards players of
          []      -> Nothing
          players -> maximumBy compareRatedPlayer $ map ratePlayer players

printWinner :: Maybe (Player, Points) -> String
printWinner Nothing                             = "The house takes all."
printWinner (Just ((Player name hand), points)) = name ++ " won with " ++ (show points) ++ " points, " ++
                                                  "holding: " ++ (concat $ intersperse ", " $ map show hand)

main :: IO ()
main = putStrLn $ printWinner kata4
-- "Player 1 won with 21 points, holding: Ace, Jack"
