.data

mensagem_ola:.asciiz "Digite um valor inteiro: "
leitor_int:.asciiz "\nResultado: "

.text 

#imprime uma mensagem
li $v0, 4
la $a0, mensagem_ola 
syscall

li $v0, 5
syscall

move $t0, $v0

#ler um valor inteiro
li $v0, 4
la $a0, leitor_int
syscall

li $v0, 1
move $a0, $t0
syscall