package org.domcode.kata 

fun main(args: Array<String>) {    
    for (i in 0..99) {
        val bottleAmount: Int = getAmount(i)
        val oneLess: Int = subtractOne(bottleAmount)
        if (bottleAmount > 1) {
            println("$bottleAmount bottles of beer on the wall, $bottleAmount bottles of beer.")
            if (oneLess == 1) {
                println("Take one down, pass it around, $oneLess bottle of beer on the wall.")
            } else {
                println("Take one down, pass it around, $oneLess bottles of beer on the wall.")
            }
        } else {
            if (bottleAmount == 1) {
                println("$bottleAmount bottle of beer on the wall, $bottleAmount bottle of beer.")
                println("Take one down, pass it around, $oneLess bottles of beer on the wall.")
            } else {
                println("0 bottles of beer on the wall, 0 bottles of beer.")
                println("Go to the store, buy some more, 99 bottles of beer on the wall.")
            }
        }
        println()
    }

}

fun subtractOne(number: Int): Int {
    return number - 1
}

fun getAmount(number: Int): Int {
    return 99 - number
}