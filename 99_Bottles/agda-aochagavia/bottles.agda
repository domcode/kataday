open import Data.Fin using (Fin; toℕ)
open import Data.Nat using (ℕ; suc)
open import Data.Nat.Show using (show)
open import Data.String using (String; _++_)
open import Data.Vec using (Vec; _∷_; []; map; tabulate; reverse)

-- It is impossible to pass a negative number to this function 
verse : ℕ → String
verse 0 = "No more bottles of beer on the wall, no more bottles of beer. Go to the store and buy some more, 99 bottles of beer on the wall."
verse 1 = "1 bottle of beer on the wall, 1 bottle of beer. Take one down and pass it around, no more bottles of beer on the wall."
verse 2 = "2 bottles of beer on the wall, 2 bottles of beer. Take one down and pass it around, 1 bottle of beer on the wall."
verse n@(suc k) = show n ++ " bottles of beer on the wall, " ++ show n ++ " bottles of beer. Take one down and pass it around, " ++ show k ++ " bottles of beer on the wall."

-- Boilerplate. Turns a list of strings in a single string separated by newlines.
unlines : ∀ {n} → Vec String n → String
unlines []       = ""
unlines (x ∷ xs) = x ++ "\n" ++ unlines xs

-- The length of the range is guaranteed to be size
range : (size : ℕ) → Vec ℕ size
range x = tabulate fun
  where fun : Fin x → ℕ
        fun f = toℕ f

-- We cannot print to stdout, therefore we just return the string
main : String
main = unlines (map verse (reverse (range 100)))
