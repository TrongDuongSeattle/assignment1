#include <stdio.h> 

int main() {
	int userNum = 0;
	printf("Enter a number: ");
	scanf("%d", &userNum);
	for (int i = 1; i <= userNum; i++) {
		for (int j = 1; j <= i; j++) {
			printf("%d", j);	
		}
		printf("\n");
	}
	return 0;
}
