package main

import (
	"fmt"
	"os"
	"regexp"
	"strings"
	"unicode"
)

var letters = regexp.MustCompile("[a-zA-Z]")
var vowels = regexp.MustCompile("[aeiou]")

func main() {
	input := strings.Join(os.Args[1:], " ")
	regex := regexp.MustCompile("\\b")

	result := make([]string, 0)
	for _, word := range regex.Split(input, -1) {
		result = append(result, pigLatinize(word))
	}

	fmt.Println(strings.Join(result, ""))
}

func pigLatinize(word string) string {
	startingConsonants := ""
	firstLetterWasCapital := false

	for i, v := range word {
		if i == 0 {
			if !unicode.IsLetter(v) {
				// Not a word but punctation, spacing...
				return word
			}

			firstLetterWasCapital = unicode.IsUpper(v)
		}

		if vowels.MatchString(string(v)) {
			break
		}

		startingConsonants += string(v)
	}

	if len(startingConsonants) == 0 {
		return word + "way"
	}

	var firstLetter = ""
	if len(startingConsonants) < len(word)-1 {
		firstLetter = string(word[len(startingConsonants)])
	}
	if firstLetterWasCapital {
		firstLetter = strings.ToUpper(firstLetter)
	}

	return firstLetter + word[len(startingConsonants)+1:] + strings.ToLower(startingConsonants) + "ay"
}
