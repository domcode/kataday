package main

import (
	"fmt"
	"math/rand"
	"strings"
	"time"
)

type special int

const (
	jack special = 1 + iota
	queen
	king
	ace
)

type card struct {
	value   int
	special special
}

const limit int = 21
const maxCards int = 5

func main() {
	// Generate some hands!
	players := []string{"bob", "carol", "daniel", "emma", "fred", "george", "harold", "jane", "karen"}
	hands := make(map[string][]card)
	deck := generateDeck()

	// Make some players
	rand.Seed(time.Now().UnixNano())
	for i := 0; i < 2+rand.Intn(len(players)-3); i++ {
		numcards := 2 + rand.Intn(3)
		hands[players[i]] = make([]card, numcards)

		// Add cards to the hand...
		for j := 0; j < numcards; j++ {
			deckIndex := rand.Intn(len(deck) - 1)
			hands[players[i]][j] = deck[deckIndex]

			// Remove that card from the deck.
			deck = remove(deck, deckIndex)
		}
	}

	// Keep track of the highscores
	highest := 0
	winners := make([]string, 0)

	// We find the value of each hand and whether that score (and the number of cards) is legal
	for player, hand := range hands {
		value, legal := getValue(hand)
		if legal {
			if value > highest {
				highest = value
				winners = []string{
					player,
				}
			} else if value == highest {
				winners = append(winners, player)
			}

			fmt.Printf("%s got %d points with %s\n", player, value, format(hand))
		} else {
			fmt.Printf("%s fails (hand %s, %d points)\n", player, format(hand), value)
		}
	}

	fmt.Println()
	switch len(winners) {
	case 0:
		fmt.Println("Nobody wins...")
	case 1:
		fmt.Printf("%s wins!\n", winners[0])
	case 2:
		fmt.Printf("Tie between: %s", strings.Join(winners, ", "))
	}
}

func remove(slice []card, index int) []card {
	slice[len(slice)-1], slice[index] = slice[index], slice[len(slice)-1]
	return slice[:len(slice)-1]
}

func generateDeck() []card {
	deck := make([]card, 52)
	counter := 0

	for i := 0; i < 4; i++ {
		for j := 2; j <= 10; j++ {
			deck[counter] = card{value: j}
			counter++
		}
		for j := jack; j <= ace; j++ {
			deck[counter] = card{special: j}
			counter++
		}
	}

	return deck
}

func getValue(hand []card) (int, bool) {
	sum := 0
	aces := 0

	// Loop over the cards...
	for _, card := range hand {
		if card.value > 0 {
			sum += card.value
			continue
		}

		switch card.special {
		case jack, queen, king:
			sum += 10
			break
		case ace:
			aces++
		}
	}

	// Special handling for the aces...
	for aces > 0 {
		if sum+11+aces-1 <= limit {
			sum += 11
		} else {
			sum++
		}

		aces--
	}

	return sum, (sum <= limit && len(hand) <= maxCards)
}

func format(hand []card) string {
	cards := make([]string, 0)

	for _, card := range hand {
		if card.value > 0 {
			cards = append(cards, fmt.Sprint(card.value))
		} else {
			switch card.special {
			case jack:
				cards = append(cards, "J")
			case queen:
				cards = append(cards, "Q")
			case king:
				cards = append(cards, "K")
			case ace:
				cards = append(cards, "A")
			}
		}
	}

	return strings.Join(cards, ", ")
}
