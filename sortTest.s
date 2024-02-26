.data
.balign 4
array: 
.skip 40
i: 
.word 0
j: 
.word 0
randInt: 
.word 0
getNum: 
.asciz "getNum: %d\n"
unsorted:
.asciz "Unsorted array: \n"
sorted:
.asciz "Sorted array: \n"
testPrompt:
.asciz "array[%d] =  %d\n"
testI:
.asciz "IN i LOOP %d \n"
testJ:
.asciz "in j loop "
testSelSort:
.ascii "in selectionSort\n"

printValue:
.asciz "printValue: %d "
.text
.global main
main:
str lr, [sp, #4]!
//generating time seed
ldr r0, =randInt
ldr r1, [r0]
bl time
bl srand			//rand returns random number to r0

//populate array with random values
ldr r1, =array		//loading adress of array, r1 contains address of array
ldr r2, =i			//loading address of i, r2 contains address of i

//print unsorted array
push {r0 - r2}
ldr r0, =unsorted
bl printf
pop {r0 -r2}		//assuming it pops' correctly
b test				//begin outer loop, i

loop:
ldr r2, =i
ldr r3, [r2] //get value of i
add r4, r1, r3, lsl #2
b randomNumberGenerator

continue:
ldr r5, =randInt
ldr r6, [r5]
str r6, [r4]
add r3, r3, #1
str r3, [r2]

test: 
ldr r2, =i		//loading adresss of i, r2 contians of address of i
ldr r3, [r2]	//loading value at i, r3 == i
cmp r3, #5		
blt loop		//r3 < 5? ie i < 5?
mov r4, #0		//r4 == minimum
b readloop

randomNumberGenerator: 
push {r0 - r5}

ldr r0, =randInt
ldr r1, [r0]
bl rand
mov r1, r0		//move to r1, the value at r0

ldr r2, =randInt//load r2 with address of randInt
str r1, [r2]	//str to register 1, the value at register 2

// % 99 = (n -  (n/m)*m)
mov r4, #99
ldr r1, =randInt
ldr r2, [r1]
udiv r3, r2,r4 
mul r5, r3, r4 
sub r2, r2, r5
// todo: add 1 here
str r2, [r1] //str the final value back to r1, randInt
pop {r0 - r5}
b continue

readloop:
cmp r4, #5		//using r4 as incrementor
beq end			//branch if equal to size of array
ldr r1, =array	//r1 contains address of array
lsl r2, r4, #2	//calculating offset
add r2, r1, r2	//r2 now contains memory address of array[i]
ldr r1, [r2]	//r1 contains VALUE off array[i], r1 = array[i] 
push {r0 - r2}
ldr r0, =printValue 
bl printf
pop {r0 - r2}
add r4, r4, #1
b readloop

selectionSort:
push {r0 - r3}
ldr r0, =testSelSort
bl printf
pop {r0 - r3}	

push {r0 - r3}

// initilize i to 0
ldr r0, =i		
ldr r1, [r0]
mov r1, #0
str r1, [r0]

// initilize j to 0
ldr r0, =j
ldr r1, [r0]
mov r1, #0
str r1, [r0]	//reset i and j to 0

//init minimum to 0
mov r4, #0		//minimum, should i make this global?
b selectionTest		// branch to test

innerbody:
ldr r2, =j
ldr r3, [r2]
mov r4, r3		//minimum = j

push {r0 - r3}
ldr r0, =testJ
bl printf
pop {r0 - r3}

//incrementing j		
add r3, r3, #1
str r3, [r2]	//

//b return

cmp r3, #5		//
blt innerbody 

b	increment_i

increment_i:
ldr r0, =i
ldr r1, [r0]	//loading to r1, the value at [r0] 
add r2, r1, #1	//incrementing i
str r2, [r0]	//store to r1, the value at r0		

reset_j_to_0:
ldr r2, =j		//resetting j to 0
ldr r3, [r2]
mov r3, #0
str r3, [r2]					

b	selectionTest


body:
ldr r2, =j		//load to r2, the adress of j
ldr r3, [r2]	//load to r3, the value at r2 from main memory
add r3, r1, #1  //j = i + 1
str r3, [r2]

//if statement
ldr r5, =array
lsl r6, r3, #2	//r6 offset
add r6, r5, r6
//str	r3, [r6]    //I JUST WANT ARRAY [J]

push {r0 - r3}
ldr r0, =getNum 

ldr r3, =array
lsl r2, r4, #2
add r3, r3, r2		//hoping this means array[minimum index]
ldr r1, [r3]
add r1, #100
bl printf
pop {r0 - r3}

cmp r3, #5		//compare i and 5, 
blt innerbody 
b increment_i 

selectionTest: 
ldr r0, =i
ldr r1, [r0]	//load into r1 value of i from r0
mov r4, r1		//minimum = i

// end cond
push {r0 - r3}
ldr r0, =printValue
bl printf
pop {r0 - r3}

cmp r1, #5		//cmp to 5
blt body		// branch if less than to body
pop {r0 - r3}
b return

//swap:
//your code here

end:
ldr r0, =sorted
bl printf
b selectionSort
return:
//ldr r0,=getNum
//bl scanf

ldr lr, [sp], #4
bx lr
.global printf
.global rand
.global srand
.global time
.global scanf
