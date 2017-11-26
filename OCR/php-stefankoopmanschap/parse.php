<?php

/**
 * parsing "old-school" numbers into actual numbers
 *     _  _     _  _  _  _  _
 *  | _| _||_||_ |_   ||_||_|
 *  ||_  _|  | _||_|  ||_| _|
 */

$characterMapping = [
    '     |  |' => 1,
    ' _  _||_ ' => 2,
    ' _  _| _|' => 3,
    '   |_|  |' => 4,
    ' _ |_  _|' => 5,
    ' _ |_ |_|' => 6,
    ' _   |  |' => 7,
    ' _ |_||_|' => 8,
    ' _ |_| _|' => 9,
    ' _ | ||_|' => 0,
];

$content = file('./file1.txt');

$lines = [];

$i = 1;
$line = [];
foreach ($content as $singleLine) {
    if ($i <= 3) {
        $line[] = $singleLine;
        $i++;
    } else {
        $lines[] = $line;
        $line = [];
        $i = 1;
    }
}
$lines[] = $line;

$parsedLines = [];
// parse the line into individual characters
foreach ($lines as $lineNumber => $line) {
    $amountOfChars = strlen($line[0])/3;
    // parse each character in the line
    $chars = [];
    for ($i = 0;$i<$amountOfChars;$i++) {
        $char = '';
        foreach ($line as $individualLine) {
            $start = $i * 3;
            $char .= str_replace("\n", "", substr($individualLine, $start, 3));
        }
        $parsedLines[$lineNumber][] = $char;
    }
}

// echo content in actual numbers;
foreach($parsedLines as $lineNumber => $characters) {
    echo $lineNumber . ': ';
    foreach($characters as $character) {
        if (strlen($character) === 9) {
            echo $characterMapping[$character];
        }
    }
    echo "\n";
}
