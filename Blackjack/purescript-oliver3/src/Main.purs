module Main where

import Prelude

import Data.Array (filter, foldl, head, nub, sort)
import Data.Maybe (Maybe(..))
import Test.Spec (describe, it)
import Test.Spec.Assertions (shouldEqual)
import Test.Spec.Reporter (consoleReporter)
import Test.Spec.Runner (run)

data Card = A | K | Q | J | Val Int

someHand :: Array Card
someHand = [K, Q, A, Val 5]

scoreCard :: Card -> Array Int
scoreCard (Val n) = [n]
scoreCard A = [11, 1]
scoreCard _ = [10]

scores :: Array Card -> Array Int
scores = map scoreCard >>> foldl foldScores [0]
  where
    foldScores :: Array Int -> Array Int -> Array Int
    foldScores totals scores = do
      total <- totals
      score <- scores
      pure $ total + score

bestScore :: Array Card -> Maybe Int
bestScore = scores >>> nub >>> filter (_ <= 21) >>> sort >>> head

main = run [consoleReporter] do
  describe "Blackjack" do
    it "should calculate the possible scores" do
      scores [K, A, Val 4] `shouldEqual` [25, 15]

    it "should calculate the best score" do
      bestScore [K, A, Val 4] `shouldEqual` Just 15

    it "should calculate the best score" do
      bestScore [K, A, Val 4, Q] `shouldEqual` Nothing
