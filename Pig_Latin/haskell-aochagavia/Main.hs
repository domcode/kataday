module Main where

import Data.Char (isUpper, toLower, toUpper)

-- Helper function
mapHead :: (a -> a) -> [a] -> [a]
mapHead f [] = []
mapHead f (x : xs) = f x : xs

-- Basic building blocks
vowel :: Char -> Bool
vowel x = elem (toLower x) ['a', 'e', 'i', 'o', 'u']

consonant :: Char -> Bool
consonant = not . vowel

letter :: Char -> Bool
letter x = ('a' <= x && x <= 'z') || ('A' <= x && x <= 'Z')

punctuation :: Char -> Bool
punctuation = not . letter

-- Handle punctuation at the end
toPigLatin :: String -> String
toPigLatin xs =
    let endPunctuation = dropWhile (not . punctuation) xs
        rest = takeWhile (not . punctuation) xs
    in (toPigLatin' rest) ++ endPunctuation

-- Does not take punctuation into account
toPigLatin' :: String -> String
toPigLatin' word =
    let upper = isUpper (head word)
        consonants = takeWhile consonant word
        rest = dropWhile consonant word
        newBegin = if upper then mapHead toUpper rest else rest
        newTail = mapHead toLower consonants
    in newBegin ++ newTail ++ "ay"

translate :: String -> String
translate = unwords . map toPigLatin . words

main :: IO ()
main = putStrLn $ translate "Pizza? Yes please!"
