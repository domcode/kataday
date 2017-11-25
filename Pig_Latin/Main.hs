import Data.Char

isClosePunctuation :: Char -> Bool
isClosePunctuation c = elem c "!?.,"

isVowel :: Char -> Bool
isVowel x = elem x "aeouiAEOUI"

isConsonant x = not (isVowel x)

pigWord :: [Char] -> [Char]
pigWord str = 
  let
    (c:str') = reverse str
    strBuilder blah =
      let
        (foo, c:fooRest) = span isConsonant blah
        bar = 
          if isUpper (head blah)
            then toUpper c : fooRest
            else c : fooRest
        appendix =
          if isVowel (head blah)
            then "way"
            else "ay"
      in
        bar ++ map toLower foo ++ appendix
    in
    if isClosePunctuation c
    then
      strBuilder (reverse str') ++ [c]
    else
      strBuilder str

pigSentence :: [Char] -> [Char]
pigSentence x = unwords (map pigWord (words x))

helloTest :: Bool
helloTest = pigWord "hello" == "ellohay"

creatingTest :: Bool
creatingTest = pigWord "creating" == "eatingcray"

algorithmTest :: Bool
algorithmTest = pigWord "algorithm" == "algorithmway"

appelsTest :: Bool
appelsTest = pigWord "Apple" == "Appleway"

tupleTest :: Bool
tupleTest = pigWord "Tuple" == "Upletay"

pizzaTest :: Bool
pizzaTest = pigSentence "Pizza? Yes please!" == "Izzapay? Esyay easeplay!"

test :: Bool
test = and [helloTest, creatingTest, algorithmTest, appelsTest, tupleTest, pizzaTest]



