const NUMBER : &str = "    _  _     _  _  _  _  _
  | _| _||_||_ |_   ||_||_|
  ||_  _|  | _||_|  ||_| _|";

const PRIMES : [u64; 9] = [2, 3, 5, 7, 11, 13, 17, 19, 23];
const HASHES : [u64; 10] = [2028117, 299, 138567, 187473, 23023, 100947, 1716099, 897, 22309287, 1312311];

fn get_number(hash: u64) -> u64 {
    // Note: we assume we get a correct hash
    HASHES.iter().position(|&x| x == hash).unwrap() as u64
}

// Generates a hash for each number in the sequence
fn hash(s : &str) -> Vec<u64> {
    let mut hashes = vec![1; 9];
    for (line_nr, line) in s.lines().enumerate() {
        let line = line.trim_right();

        assert!(line_nr <= 2);

        for (i, &byte) in line.as_bytes().into_iter().enumerate() {
            assert!(i <= 27);
            let index = i % 3;
            let prime = PRIMES[index + 3 * line_nr];
            if byte != b' ' {
                hashes[i / 3] *= prime;
            }
        }
    }

    hashes
}

// Returns the hash of each digit as a single entry in the vector
fn parse(s : &str) -> Vec<u64> {
    let hashes = hash(s);
    hashes.into_iter().map(get_number).collect()
}

fn main() {
    println!("{:?}", parse(NUMBER));
}
