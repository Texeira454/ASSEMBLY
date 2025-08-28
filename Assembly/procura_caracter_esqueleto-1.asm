.data
    S1: .asciiz "\nTeste para busca de caracteres"
    encontrou: .asciiz "\nEncontrou o caracter "
    nao_encontrou: .asciiz "\nNao encontrou"
    vezes: .asciiz " vez(es)"
    digite: .asciiz "Digite um caracter: "

# lembrar que caracteres ocupam apenas 1 byte na mem�ria

.text
main:
    
    la $a0, digite 
    li $v0, 4 	 
    syscall
    
    li $v0, 12
    syscall
    
    move $a0, $v0
    la $a1, S1  
    
    jal encontra_caracter
    
    # se $v0=0 indica que n�o encontrou o caracter
    # se $v0=1 indica que encontrou o caracter
    beq $v0, $zero, nao  # testa se n�o encontrou
    
    la $a0, encontrou 
    li $v0, 4 	 
    syscall
    
    # $v1 contem o n�mero de incid�ncias
    move $a0, $v1
    li $v0, 1 	 
    syscall
    
    la $a0, vezes 
    li $v0, 4 	 
    syscall
   
    la $a0, S1
    li $v0, 4 	 
    syscall
   
    j feito
nao: 
    la $a0, nao_encontrou 
    li $v0, 4 	 
    syscall
feito:    
    li $v0, 10
    syscall # feito!

# procedimento "encontra_caracter"
# Argumentos
# 1) $a0 conter� o caracter a ser procurado na string
# 2) $a1: endere�o base de S1 
#Retornos
# 1) $v0 ser� 0 se n�o encontrar o caracter, e 1 se encontrar
# 2) $v1 contabiliza o n�mero de incid�ncias do caracter procurado
encontra_caracter: 
#...
	LOOP: 	lb $t0, 0($a1)
		beq $t0, $zero , SAI
	
		bne $t0, $a0, NAO_CONTA
		addi $v1, $v1, 1
		li $v0, 1
        
        	li $a3, 'x'
		sb $a3, 0($a1)
        	
        NAO_CONTA: addi $a1, $a1, 1
        	   j LOOP
        
        SAI: jr   $ra                 # termina o procedimento
        
.end main
