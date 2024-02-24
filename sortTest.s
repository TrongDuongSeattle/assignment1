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
.asciz "%d\n"
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
.ascii "in selectionSort"
printValue:
.asciz "%d "
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
ldr r1, =array
ldr r2, =i

push {r0 - r2}
ldr r0, =unsorted
bl printf
pop {r0 -r2}
b test

loop:
ldr r2, =i
ldr r3, [r2] //get value of i
add r4, r1, r3, lsl #2
bl randomNumberGenerator

continue:
ldr r5, =randInt
ldr r6, [r5]
str r6, [r4]
add r3, r3, #1
str r3, [r2]

test: 
ldr r2, =i
ldr r3, [r2]
cmp r3, #5
blt loop
mov r4, #0
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
str r2, [r1] //str the final value back to r1, randInt
pop {r0 - r5}
bl continue

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

ldr r0, =i		
ldr r1, [r0]
mov r1, #0
str r1, [r0]
ldr r0, =j
ldr r1, [r0]
mov r1, #0
str r1, [r0]	//reset i and j to 0
mov r4, #0		//minimum, should i make this global?
b selectionTest		// branch to test

innerbody:
//test print
push {r0 - r3}
ldr r0, =testJ
bl printf
pop {r0 - r3}

ldr r2, =j
ldr r3, [r2]
mov r4, r3		//minimum = j

//incrementing j		
add r3, r3, #1
str r3, [r2]	//

cmp r3, #5		//compare j and 5, 
blt innerbody 

body:
push {r0 - r3}
ldr r0, =testI
ldr r1, =i
ldr r1, [r1]
bl printf
pop {r0 - r3}
ldr r0, =i
ldr r1, [r0]	//loading to r1, the value at [r0] 
add r2, r1, #1	//incrementing i
str r2, [r0]	//store to r1, the value at r0

ldr r2, =j		//load to r2, the adress of j
ldr r3, [r2]	//load to r3, the value at r2 from main memory
add r3, r1, #1  //j = i + 1
str r3, [r2]

cmp r1, #5		//compare i and 5, 
blt innerbody 



ldr r2, =j		//resetting j to 0
ldr r3, [r2]
mov r3, #0
str r3, [r2]

selectionTest: 
ldr r0, =i
ldr r1, [r0]	//load into r1 value of i from r0
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
ldr r0,=getNum
bl scanf

ldr lr, [sp], #4
bx lr
.global printf
.global rand
.global srand
.global time
.global scanf
