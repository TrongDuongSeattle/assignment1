#include <stdio.h> 
#include <stdlib.h>
#include <time.h>

int randomNumberGenerator();

int main () {
	int userGuess = 0;
	int randomNum = randomNumberGenerator();
	int guessCount = 0;
	printf("Guess the number: ");
	scanf("%d", &userGuess);
	while (userGuess != randomNum) {
		if (userGuess > randomNum) {
			printf("Too high. Guess again. ");
		} else { 
			printf("Too low. Guess again. ");	
		}
		scanf("%d", &userGuess);
		guessCount++;
	}
	printf("You guess correctly in %d tries!", guessCount);
	return 0;
}
/**
 * Generates random number between 1 and 10 based on current time.
 */
int randomNumberGenerator() {
	int random_num = 0;
	srand(time(NULL));
	random_num = rand() % 10 + 1;
	return random_num;
}
