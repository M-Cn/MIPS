.globl			print_int, print_float, print_double, print_string, read_int, read_float, read_double, read_string, sbrk, exit, print_char, read_char, exit2, print_lab_int

.data
newline:			.asciiz 	"\n"

.text
print_int:			
				addi $v0, $0, 1
				syscall
				la	$a0, newline
				addi	$v0, $0, 4
				syscall
				jr	$ra

print_float:
				addi $v0, $0, 2
				syscall
				la	$a0, newline
				addi	$v0, $0, 4
				syscall
				jr	$ra

print_double:
				addi $v0, $0, 3
				syscall
				la	$a0, newline
				addi	$v0, $0, 4
				syscall
				jr	$ra

print_string:
				addi $v0, $0, 4
				syscall
				jr $ra
read_int:
				addi, $v0, $0, 5
				syscall	
				jr	$ra

read_float:
				addi $v0, $0, 6
				syscall
				jr	$ra

read_double:
				addi $v0, $0, 7
				syscall
				jr	$ra

read_string:
				addi $v0, $0, 8
				syscall
				jr	$ra

sbrk:
				addi $v0, $0, 9
				syscall
				jr	$ra

exit:
				addi $v0, $0, 10
				syscall
				jr	$ra

print_char:
				addi $v0, $0, 11
				syscall
				la	$a0, newline
				addi	$v0, $0, 4
				syscall
				jr	$ra

read_char:
				addi $v0, $0, 12
				syscall
				jr	$ra

exit2:
				addi $v0, $0, 17
				syscall
				jr	$ra

print_lab_int:		#print_lab_int(int, string)
				sw		$ra, ($sp)
				subi		$sp, $sp, 4
				sw		$a0, ($sp)
				move	$a0, $a1
				jal		print_string
				lw		$a0, ($sp)
				jal		print_int
				addi		$sp, $sp, 4
				lw		$ra, ($sp)
				jr		$ra
