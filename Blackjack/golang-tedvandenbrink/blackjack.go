/*A, J => 21
A, 10, A => 12
8, A, A => 20
5, 3, 7 => 15
K, Q, J => went over 21!*/

package main

import (
	"fmt"
	"strings"
	"strconv"
	"math/rand"
	"time"
)

func main() {
	rand.Seed(time.Now().UnixNano())
	onecardset :=  []string{"1","2","3","4","5","6","7","8","9","10","J","Q","K","A"}
	var allcards = onecardset
	allcards = append(allcards,onecardset...)
	allcards = append(allcards,onecardset...)
	allcards = append(allcards,onecardset...)
	allcards = shuffleCards(allcards)

	var cardpointer = 0
	hands := []string{} 
	for numplayers := 0; numplayers < 10; numplayers++ {
		var mycards = []string{}
		var mypoints int64 = 0
		for mypoints > -1 && mypoints < 17  {
			mycards = append(mycards,allcards[cardpointer])
			cardpointer++
			mypoints = getpoints(strings.Join(mycards, ","))
		}
		hands = append(hands,strings.Join(mycards, ","))
	}


	var highesthand string = ""
	var highestscore int64 = -1

	for _, hand := range hands {
		fmt.Printf("Calculating hand %s\n",hand)
		var points = getpoints(hand)
		fmt.Printf("Points: %d\n",points)
		if points > highestscore {
			highestscore = points
			highesthand = hand
		}
	}

	fmt.Printf("=================================\nWinner: %s wtih %d points!\n=================================\n", highesthand ,highestscore)
}

func getpoints(hand string) (int64) {
	var cards []string = strings.Split(hand,",")
	if len(cards) > 5 {
		return -1
	}

	var acecount int = 0
	var score int64 = 0
	for _, card := range cards {
		var nummericcard, err = strconv.ParseInt(card,10,0)
		if(err==nil) {
			score += nummericcard
		} else {
			if card=="A" {
				acecount++
				score += 11
			} else {
				score+= 10
			}
		}
	}
	for score > 21 && acecount > 0 {
		score = score-10
		acecount--
	}
	if(score > 21) {
		score = -1
	}
	return score
}

func shuffleCards(cards []string) ([]string) {
	for i := range cards {
		j := rand.Intn(i + 1)
		cards[i], cards[j] = cards[j], cards[i]
	}
	return cards
}