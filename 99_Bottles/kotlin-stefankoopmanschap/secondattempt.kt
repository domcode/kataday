package org.domcode.kata 

fun main(args: Array<String>) {    
    for (i in 0..99) {
        val bottleAmount: Int = getAmount(i)
        val oneLess: Int = subtractOne(bottleAmount)
        
        when {
            bottleAmount > 1 -> println("$bottleAmount bottles of beer on the wall, $bottleAmount bottles of beer.")
			bottleAmount == 1 -> println("$bottleAmount bottle of beer on the wall, $bottleAmount bottle of beer.")
            else -> println("0 bottles of beer on the wall, 0 bottles of beer.")
        }
        
        when {
            oneLess == 1 -> println("Take one down, pass it around, $oneLess bottle of beer on the wall.")
            oneLess == -1 -> println("Go to the store, buy some more, 99 bottles of beer on the wall.")
            else -> println("Take one down, pass it around, $oneLess bottles of beer on the wall.")
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