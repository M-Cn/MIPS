.globl		main

.data
string:		.asciiz	"abcdef0123456789 @#[]"
num_digit:	.asciiz	"Digits: "
num_char:		.asciiz	"Characters: "
num_other:	.asciiz	"Others: "
vector:		.word	0, 0, 0

.text
main:
			la		$a0, string
			jal		contalettere
			lw		$t0, ($v0)				#copy buffer to a permanent memory location (vector)
			sw		$t0, vector			#vector[0] = buf[0]
			lw		$t0, 4($v0)		
			sw		$t0, vector+4			#vector[1] = buf[1]
			lw		$t0, 8($v0)
			sw		$t0, vector+8			#vector[2] =  buf[2]
			move	$a0, $s0
			la		$a1, 	num_digit
			jal		print_lab_int			#print_int(vector[0], num_digit)
			move	$a0, $s1			
			la		$a1, 	num_char	
			jal		print_lab_int			#print_int(vector[1], num_char)
			move	$a0, $s2
			la		$a1, 	num_other
			jal		print_lab_int			#print_int(vector[2], num_other)
			xor		$a0, $a0, $a0
			jal 		exit2					#exit2(0)

contalettere:								#addr contalettere(addr string)
			sw		$ra, ($sp)
			subi		$sp, $sp, 16
			addi		$fp, $sp, 12			#allocate 12 bytes to store the sum of digits, alphabet characters and special characters (int buffer[3])
for:
			lb		$t0, ($a0)				#t0 = string[0]
			beqz		$t0, end				#if (string[0] = 0) goto end
			jal		check_alpha		
			beqz		$v0, num				#if (check_alpha(string[0]) == 0) goto num
			addi		$t1, $0, 1
			beq		$v0, $t1, char			#if (check_alpha(string[0]) == 1) goto char
			addi		$s2, $s2, 1			#else num_other++	
next:
			addi		$a0, $a0, 1			#increment the string index by 1. A char is a single byte
			j 		for
num:
			addi		$s0, $s0, 1			#num_digit++
			j		next
char:					
			addi		$s1, $s1, 1			#num_char++
			j 		next
end:
			sw		$s0, ($fp)				#vector[0] = num_digit
			sw		$s1, -4($fp)			#vector[1] = num_char
			sw		$s2, -8($fp)			#vector[2] = num_other
			move	$v0, $fp			
			addi		$sp, $sp, 16			#restore stack
			lw		$ra, ($sp)
			jr		$ra					#return &vector

check_alpha:								#int check_alpha(addr string)
			sw		$ra, ($sp)
			lb		$t0, ($a0)				#t0 = *string
			bge		$t0, 0x39, check_char	#if (0x30 <= t0 <= 0x39) goto ret_num	
			bge		$t0, 0x30, ret_num
check_char:
			bge		$t0, 0x7B, ret_other		#else if(0x61 <= t0 <= 0x7B) goto ret_char
			bge		$t0, 0x61, ret_char
			j		ret_other				#else goto ret_other
ret_num:
			xor		$v0, $v0, $v0
			lw		$ra, ($sp)
			jr		$ra					#return 0
ret_char:
			addi		$v0, $0, 1
			lw		$ra, ($sp)
			jr		$ra					#return 1
ret_other:
			addi		$v0, $0, 2
			lw		$ra, ($sp)
			jr		$ra					#return 2
