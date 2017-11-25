// 3 bottles of beer on the wall, 3 bottles of beer.
// Take one down and pass it around, 2 bottles of beer on the wall.

// 2 bottles of beer on the wall, 2 bottles of beer.
// Take one down and pass it around, 1 bottle of beer on the wall.

// 1 bottle of beer on the wall, 1 bottle of beer.
// Take one down and pass it around, no more bottles of beer on the wall.

// No more bottles of beer on the wall, no more bottles of beer.
// Go to the store and buy some more, 99 bottles of beer on the wall.

const bottles = (n) =>
    n === 0 ? 'no more bottles'
  : n === 1 ? 'one bottle'
  :           `${n} bottles`

const start = 99;

for (let i=start; i >= 0; i--) {
  console.log(`${bottles(i)} of beer on the wall, ${bottles(i)} of beer.`)
  if (i > 0) {
    console.log(`Take one down and pass it around, ${bottles(i-1)} of beer on the wall.`)
  } else {
    console.log(`Go to the store and buy some more, ${bottles(start)} of beer on the wall.`)
  }
}
