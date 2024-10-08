.data
str1: .string "Please enter the strokes of the second character of the last name="
str5: .string "Please enter the strokes of the first character of the last name="
str3: .string "Please enter the strokes of the first character of the first name ="
str4: .string "Please enter the strokes of the second character of the first name ="
here: .string "here"

sky: .string "Sky="
people: .string "People="
land: .string "Land="
outside: .string "Outside="
total: .string "Total="

skystr: .string "Sky "
peoplestr: .string "People "
landstr: .string "Land "
outsidestr: .string "Outside "
totalstr: .string "Total "
printfstr: .string "\n"

str2: .string "s1111514\n"
wood: .string " Wood\n"
fire: .string " Fire\n"
earth: .string " Earth\n"
metal: .string " Metal\n"
water: .string " Water\n"

restraint: .string "restraint "
equal: .string "equal "
generate: .string "generate " 


result_array: .space 20

.text
main:	
#程式解說:我這邊有四個輸入，分別是第一個姓氏第二個姓氏第一個名字第二個名字，如果是三個字的姓名，第一個姓氏的筆劃數就輸入0
#如果是兩個字的姓名，第一個姓氏和第二個名字的筆劃數就輸入0，四個字的姓名就全部輸入即可
    li s9,0
    jal printMsg2
    jal printMsg5
    jal inputA 
  
    add s9,s9,a0
    beq a0,zero,addone
    
    mv s11,a0 
    
    jal printMsg1
    jal inputM    # return the result a0
    
   
    mv t0,a0
    mv s2,a0
    mv s1, a0    # Store M in s1
    mv a0, s1
    jal printsky
    mv a0,s1
    
   
    add a0,a0,s11

    mv s5,a0 #別存到s5~s9 
    jal printNumber
    jal computeWuXin # computeWuXin(M=a0), return a0 
    jal printResult # printResult(a0)

    jal printMsg3
    jal inputN    # return the result a0
   
    mv t1,a0
    mv s3,a0
    mv s1, a0    # Store M in s1
    mv a0, s1
    jal printpeople
    mv a0,s1
    
    add a0, a0, s2
    mv s6,a0 #別存到s5~s9  
    jal printNumber
    jal computeWuXin # computeWuXin(M=a0), return a0
    
    jal printResult # printResult(a0)
    #block 3
    jal printMsg4
    jal inputO    # return the result a0
    
    add s9,s9,a0
    beq a0,zero,addone
    
    mv t2,a0
    mv s4,a0
    mv s1, a0    # Store M in s1
    mv a0, s1
    jal printland
    mv a0,s1
    
   
    add a0, a0, s3
   
    mv s7,a0 #別存到s5~s9
    jal printNumber
    jal computeWuXin # computeWuXin(M=a0), return a0
    mv s8,a0 #別存到s5~s9  
    jal printResult # printResult(a0)
    
    jal printoutside
    
    add a0,s4,s11
    
    
    mv s8,a0 #別存到s5~s9
    jal printNumber
    jal computeWuXin # computeWuXin(M=a0), return a0  
    jal printResult # printResult(a0)
    
    jal printtotal
   
    
    add a0,s2,s3
    add a0,a0,s9

    mv s9,a0 #別存到s5~s9
    jal printNumber
    jal computeWuXin # computeWuXin(M=a0), return a0  
    jal printResult # printResult(a0)
    li s2,1
    li t3,2
    li t4,3
    li t5,4
    li t6,5
    
    mv a0,s5
    jal identify_0
    mv a1,s6
    jal identify_1
    jal relation
    jal printResult
    
 
    j end
    
relation:
	addi sp,sp,-4
	sw ra,0(sp)

	beq a0,s2,verify_relation1 #if a0 is wood		
	beq a0,t3,verify_relation2
	beq a0,t4,verify_relation3
	beq a0,t5,verify_relation4
	beq a0,t6,verify_relation5
	
verify_relation1:
        
	addi sp,sp,-4
	sw ra,0(sp)
	
	beq a1,t3,generate_word
	beq a1,t4,restraint_word
	beq a1,s2,equal_word

verify_relation2:
	
	addi sp,sp,-4
	sw ra,0(sp)
	
	beq a1,t4,generate_word
	beq a1,t5,restraint_word
	beq a1,t3,equal_word
	
verify_relation3:
	addi sp,sp,-4
	sw ra,0(sp)
	
	beq a1,t5,generate_word
	beq a1,t6,restraint_word
	beq a1,t4,equal_word
verify_relation4:
	addi sp,sp,-4
	sw ra,0(sp)
	
	beq a1,t6,generate_word
	beq a1,s2,restraint_word
	beq a1,t5,equal_word
verify_relation5:
	addi sp,sp,-4
	sw ra,0(sp)
	
	beq a1,s2,generate_word
	beq a1,t3,restraint_word
	beq a1,t6,equal_word
	
		
generate_word:
	la a0,generate
	j endcomputeWuXin 
restraint_word:
	la a0,restraint
	j endcomputeWuXin 
equal_word:
	la a0,equal
	j endcomputeWuXin
    
identify_0:
	mv t1,a0

	addi sp,sp,-4
	sw ra,0(sp)
	
	li t2,10
	rem t1,t1,t2
	
	blez t1,watermode #12(Wood),34(Fire),56(Earth),78(Metal),90(Water)	
	li a2,2	 
	ble t1,a2,woodmode 
	li a2,4
	ble t1,a2,firemode
	li a2,6	 
	ble t1,a2,earthmode
	li a2,8
	ble t1,a2,metalmode
	li a2,9
	ble t1,a2,watermode
	
identify_1:
	mv t1,a1

	addi sp,sp,-4
	sw ra,0(sp)
	
	li t2,10
	rem t1,t1,t2
	
	blez t1,water2 #12(Wood),34(Fire),56(Earth),78(Metal),90(Water)	
	li a2,2	 
	ble t1,a2,wood2
	li a2,4
	ble t1,a2,fire2
	li a2,6	 
	ble t1,a2,earth2
	li a2,8
	ble t1,a2,metal2
	li a2,9
	ble t1,a2,water2	
water2:
	li a1,5
	j endcomputeWuXin
wood2:
	li a1,1
	j endcomputeWuXin
fire2:
	li a1,2
	j endcomputeWuXin
earth2:
	li a1,3
	j endcomputeWuXin
metal2:
	li a1,4
	j endcomputeWuXin
	
	

watermode:
	li a0,5
	j endcomputeWuXin
woodmode:
	li a0,1
	j endcomputeWuXin
firemode:
	li a0,2
	j endcomputeWuXin
earthmode:
	li a0,3
	j endcomputeWuXin
metalmode:
	li a0,4
	j endcomputeWuXin	

	

addone:
	addi a0,a0,1
	addi s9,s9,-1
	ret
	

	
	
computeWuXin: 
	mv t1,a0

	addi sp,sp,-4
	sw ra,0(sp)
	
	li t2,10
	rem t1,t1,t2
	
	blez t1,ModeWater #12(Wood),34(Fire),56(Earth),78(Metal),90(Water)	
	li a2,2	 
	ble t1,a2,ModeWood
	li a2,4
	ble t1,a2,ModeFire
	li a2,6	 
	ble t1,a2,ModeEarth
	li a2,8
	ble t1,a2,ModeMetal
	li a2,9
	ble t1,a2,ModeWater


endcomputeWuXin: 
	lw ra,0(sp)
	addi sp,sp,4
	ret  #return (a0)

ModeWood:
	la a0,wood
	j endcomputeWuXin
	
ModeFire:
	la a0,fire
	j endcomputeWuXin

ModeEarth:
	la a0,earth
	j endcomputeWuXin

ModeMetal:
	la a0,metal
	j endcomputeWuXin

ModeWater:
	la a0,water
	j endcomputeWuXin

printResult:
	li a7, 4			# print string
 	ecall
 	ret
printNumber:
	li a7, 1			# print Number
 	ecall
 	ret
 	
inputM:
	li a7,5
	ecall
	ret
inputN:
	li a7,5
	ecall
	ret
inputO:
	li a7,5
	ecall
	ret	
inputA:
	li a7,5
	ecall
	ret	
printMsg1:
	la a0, str1			# prepare to print string 1
	li a7, 4			# print string
 	ecall
 	ret
printMsg2:
	la a0, str2			# prepare to print string 1
	li a7, 4			# print string
 	ecall
 	ret
printMsg3:
	la a0, str3			# prepare to print string 1
	li a7, 4			# print string
 	ecall
 	ret
printMsg4:
	la a0, str4			# prepare to print string 1
	li a7, 4			# print string
 	ecall
 	ret
printMsg5:
	la a0, str5			# prepare to print string 1
	li a7, 4			# print string
 	ecall
 	ret
printsky:
	la a0, sky			# prepare to print string 1
	li a7, 4			# print string
 	ecall
 	ret
printpeople:
	la a0, people			# prepare to print string 1
	li a7, 4			# print string
 	ecall
 	ret
printland:
	la a0, land			# prepare to print string 1
	li a7, 4			# print string
 	ecall
 	ret
printoutside:
	la a0, outside			# prepare to print string 1
	li a7, 4			# print string
 	ecall
 	ret
printtotal:
	la a0, total			# prepare to print string 1
	li a7, 4			# print string
 	ecall
 	ret
end:
	li a7, 10			
 	ecall
