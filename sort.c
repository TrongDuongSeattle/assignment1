#include <stdio.h>
#include <stdlib.h>
#include <time.h>

void selectionSort(int array[], int n);
void swap (int *px, int *py);
void printArray(int array[], int n);
int randomNumberGenerator();

int main() {
	int array[10];	
	srand(time(NULL));
	for (int i = 0; i < 10; i++) {
		array[i] = randomNumberGenerator();
	}
	printf("Unsorted array:\n");
	printArray(array, 10);
	printf("Sorted array:\n");
	selectionSort(array, 10);
	printArray(array, 10);	
		return 0;
}

void selectionSort(int array[], int n) {
	int minimum;
	for (int i = 0; i < n; i++) {
		minimum = i;
		for (int j = i+1; j < n; j++) {
			if (array[j] < array[minimum]) {	
				minimum = j;
			}
		}
		swap(&array[minimum],&array[i]);
	}
}
void swap (int *px, int *py) {
	int temp;
	temp = *px;
	*px = *py;
	*py = temp;
}

void printArray(int array[], int n) {
	for (int i = 0; i < n; i++) {
		printf("%d ", array[i]);
	}
	printf("\n");
}

int randomNumberGenerator() {
	int random_num = 0;
	random_num = rand() % 99 + 1;
	return random_num;
}
