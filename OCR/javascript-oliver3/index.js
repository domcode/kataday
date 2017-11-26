const { readFileSync } = require('fs')

function toSegments(lines) {
  const segments = []
  const maxLen = Math.max(...lines.map((line) => line.length))

  for (let chr = 0; chr < maxLen; chr += 3) {
    segments[chr / 3] = (
      lines[0].substring(chr, chr + 3).trimRight() +
      lines[1].substring(chr, chr + 3).trimRight() +
      lines[2].substring(chr, chr + 3).trimRight()
    ).replace(/\S/g, 'X')
  }

  return segments
}

const numberSegments = toSegments([
  ' _     _  _     _  _  _  _  _ ',
  '| |  | _| _||_||_ |_   ||_||_|',
  '|_|  ||_  _|  | _||_|  ||_| _|'
])

const lines = readFileSync('./ocr.txt', 'utf-8').split('\n')

for (let i = 0; i < lines.length; i += 5) {
  const ocrLines = lines.slice(i, i + 3)
  const answerLine = lines[i + 4]

  let numbers = toSegments(ocrLines)
    .map((segment) => numberSegments.indexOf(segment))
    .join('')

  console.log(`${numbers}    should be    ${answerLine}`)
}

