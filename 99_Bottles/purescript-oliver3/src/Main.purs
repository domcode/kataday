module Main where

import Prelude

import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Console (CONSOLE, log)
import Data.Array (foldMap, reverse, (..))

lines :: Int -> String
lines 0 =
  "No more bottles of beer on the wall, no more bottles of beer.\n" <>
  "Go to the store and buy some more, 99 bottles of beer on the wall.\n"
lines 1 =
  "1 bottle of beer on the wall, 1 bottle of beer.\n" <>
  "Take one down and pass it around, no more bottles of beer on the wall.\n"
lines n =
  show n <> " bottle of beer on the wall, " <> show n <> " bottle of beer.\n" <>
  "Take one down and pass it around, " <> show (n-1) <> " bottles of beer on the wall.\n"


main :: forall e. Eff (console :: CONSOLE | e) Unit
main = log $ foldMap lines $ reverse (0 .. 99)
