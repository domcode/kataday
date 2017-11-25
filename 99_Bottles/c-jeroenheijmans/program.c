#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAXBOTTLES 9999

#define MAX_NR_OF_DIGIT_OCCURENCES 2 // Max nr of placeholders in any of the sentence formats
#define SENTENCE_FORMAT_BASE "%i bottles of beer on the wall, %i bottles of beer\nTake one down, pass it around, %i bottles of beer on the wall...\n"
#define SENTENCE_FORMAT_1 "1 bottle of beer on the wall, 1 bottle of beer\nTake one down, pass it around, no more bottles of beer on the wall...\n"
#define SENTENCE_FORMAT_0 "No more bottles of beer on the wall, no more bottles of beer.\nGo to the store and buy some more, %i bottles of beer on the wall..."

int getNumberOfDigits(int number) {
    int numberWidth = 0;

    while (number) {
      numberWidth++;
      number /= 10;
    }

    return numberWidth;
}

char* createCouplet(const int i, char* format) {
    int length = getNumberOfDigits(i) * MAX_NR_OF_DIGIT_OCCURENCES + strlen(format);
    char* coupletBuffer = malloc(length * sizeof(char));
  
    sprintf(coupletBuffer, format, i, i, i-1);

    return coupletBuffer;
}

int main(int argc, char *argv[]) {
    int songSize = 13; // TODO: Retrieve from argv
    int limit = songSize + 1;

    if (songSize >= MAXBOTTLES) {
        return 42;
    }

    char* song[limit];

    for (int i = 2; i < limit; i++) {
        song[limit - i - 1] = createCouplet(i, SENTENCE_FORMAT_BASE);
    }

    song[limit - 2] = malloc(2500 * sizeof(char));
    strcpy(song[limit - 2], SENTENCE_FORMAT_1);

    song[limit - 1] = createCouplet(songSize, SENTENCE_FORMAT_0);

    for (int i = 0; i < limit; i++) {
        printf("%s\n", song[i]);
        free(song[i]);
    }

    return 0;
}
