.globl		main

.data
MATRIX: 		.word 	1, 2, 3, 4, 5, 6, 7, 8, 9
N:			.word 	3
index:		.asciiz 	"Index: "
result:		.asciiz	"Result: "
matrix_elem:	.asciiz	"Matrix[]: "
newline:		.asciiz 	"\n"
x:			.asciiz	"x: "
y:			.asciiz	"y: "
	
.text
main:	
			xor 		$s0, $s0, $s0		#sum	
			lw		$s1, N			#N
			xor 		$s2, $s2, $s2		#matrix[offset]
			xor 		$t8, $t8, $t8		#offset
			xor		$t0, $t0, $t0		#x
for_outer:
			bge		$t0, $s1, end_outer	
			xor		$t1, $t1, $t1		#y
for_inner:
			bge 		$t1, $s1, end_inner
			move	$a0, $t0
			move	$a1, $t1
			lw		$a2, N
			jal		is_main_diag
			bnez		$v0, sum
			move	$a0, $t0
			move	$a1, $t1
			lw		$a2, N
			jal		is_secondary_diag
			bnez		$v0, sum
			j		next
sum:
			move	$t8, $t0
			move 	$t3, $t1
			move	$t4, $s1
			sub		$t4, $t4, 1
			mul		$t3, $t3, $t4
			add		$t8, $t8, $t3
			move	$a0, $t8
			la		$a1, index
			jal		print_lab_int
			sll		$t8, $t8, 2
			lw		$s2, MATRIX($t8)
			move	$a0, $s2
			la		$a1, matrix_elem
			jal		print_lab_int
			move	$a0, $s2
			add		$s0, $s0, $s2
next:
			addi		$t1, $t1, 1
			j		for_inner
end_inner:	
			addi		$t0, $t0, 1
			j		for_outer					
end_outer:
			move	$a0, $s0
			la		$a1, result
			jal 		print_lab_int
			addi		$a0, $0, 0
			jal 		exit2
