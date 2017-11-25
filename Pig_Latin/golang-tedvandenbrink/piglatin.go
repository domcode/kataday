package main

import (
	"fmt"
	"strings"
	"unicode"
	"unicode/utf8"
)

var vowel string = "aeoui"

func main() {	
	var input string = "hello world! pizza Please? Algorithm aart!"
	var words []string = strings.Split(input," ")
	var result []string = []string{}
	
	for _, word := range words {
		firstchar, _ := utf8.DecodeRuneInString(word)
		lastchar, _ := utf8.DecodeLastRuneInString(word)
				
		var ucfirst = false
		if unicode.IsUpper(firstchar) {
			ucfirst = true
		}

		word = strings.ToLower(word)
		
		var processedword string

		if(!unicode.IsLetter(lastchar)) {
			word = strings.TrimRight(word, string(lastchar))
		}

		if strings.Contains(vowel,string(word[0])) { //starts with vowel
			processedword = fmt.Sprint(word,"way")			
		} else {
			processedword = Shuffle(word)
			processedword = fmt.Sprint(processedword,"ay")	
		}

		if(ucfirst) {
			processedword = strings.Title(processedword)
		}

		if(!unicode.IsLetter(lastchar)) {	
			processedword = fmt.Sprint(processedword,string(lastchar))	
		}

		result = append(result, processedword)
	}

	fmt.Println(strings.Join(words, " "))
	fmt.Println(strings.Join(result, " "))

}

func Shuffle(s string) string {
	runes := []rune(s)
	var i = 0
    for i=0; i < len(runes)-1; i++ {
        if strings.Contains(vowel,string(runes[i])) {
			break;
		}
	}
	
	before := string(runes[0:i])
	after := string(runes[i:len(runes)])
	
    return fmt.Sprint(after,before)
}