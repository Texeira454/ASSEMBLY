.data
# A palavra (word) de 32 bits a ser impressa.
# Exemplo dado: 0x8000000F
variavel: .word 0x8000000F 

# Constantes para a syscall de impressão de caractere
# $v0 = 11 (print character)
.eqv PRINT_CHAR_SYSCALL 11

.text
.globl main

main:
    # 1. Carregar a palavra de 32 bits
    la      $t0, variavel       
    lw      $t1, 0($t0)        

    # 2. Inicializar o contador de bits (de 31 a 0)
    li      $t2, 31             

    # 3. Inicializar a máscara (1 com 31 zeros, para o bit 31)
    li      $t3, 1              
    sll     $t3, $t3, 31        

    # --- Loop principal ---
loop_print_bit:
    # 4. Verificar se a contagem de bits terminou (32 bits impressos)
    bltz    $t2, fim_programa   

    # 5. Isolar o bit atual usando a máscara
    and     $t4, $t1, $t3       

    # 6. Decidir qual caractere imprimir ('1' ou '0')
    beqz    $t4, print_zero     

    # --- Imprimir '1' ---
    li      $a0, '1'            
    b       print_char          

    # --- Imprimir '0' ---
print_zero:
    li      $a0, '0'           
    
    
    
print_char:
    li      $v0, PRINT_CHAR_SYSCALL 
    syscall                     

    # 7. Preparar para o próximo bit

    # Deslocar a máscara para a direita (para o próximo bit)
    srl     $t3, $t3, 1         

    # Decrementar o contador
    addi    $t2, $t2, -1        

    # Voltar ao início do loop
    j       loop_print_bit

    
fim_programa:

    li      $v0, 10             
    syscall                     