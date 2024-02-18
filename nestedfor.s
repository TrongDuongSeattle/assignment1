/* #include <stdio.h> 

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
*/

.data
prompt1: 
	.asciz "Enter a number: "
numberFormat:
	.asciz "%d"
userNum: 
	.word 0
return:
	.word 0

.text
.global main
main:
	ldr r1, =address_of_return //: 
	str lr, [r1]
	
	ldr r0, =adress_of_p1 
	bl printf	
	
	bx lr
address_of_p1:.word prompt1		//i wonder if this increases or decrease speed rather than just calling with = 
address_of_number:.word number
adress_of_return:.word return
.global printf
/*
 pyrex
 plastic bag of full of meat, thit bo xao
	-possibly bottom floor
 8845 
 nestbackup */
 
