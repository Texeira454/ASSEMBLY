# Este programa escreve um arquivo com o conte�do de um buffer
# O arquivo � criado na pasta de instala��o do Mars
#
.data
arquivo_origem:   .asciiz "arquivo.txt"      # nome do arquivo para escrita
arquivo_destino:   .asciiz "arquivo_destino.txt"      # nome do arquivo para escrita
buffer: .space 1024

.text
#abre arquivo_origem para leitura
	li   $v0, 13       # chamada de sistema para abrir arquivo
	la   $a0, arquivo_origem      
	li   $a1, 0        # abrir para leitura
	li   $a2, 0
	syscall            # abre arquivo! (descritor do arquivo retornado em $v0)
	move $s0, $v0      # salva o descritor de arquivo 
	
# Abre arquivo_destino para escrita	
 	li   $v0, 13       # chamada de sistema para abrir arquivo
  	la   $a0, arquivo_destino  # arquivo de sa�da
	li   $a1, 1        # abertura para escrita (flags s�o 0: read, 1: write)
  	li   $a2, 0        # modo ignorado
  	syscall            # abre arquivo! (descritor do arquivo retornado em $v0)
  	move $s1, $v0      # guarda o descritor do arquivo em $s6
  
#Loop
copiar_loop:

	li   $v0, 14                     # syscall para ler arquivo
 	move $a0, $s0                    # descritor do arquivo de origem
	la   $a1, buffer                 # endereço do buffer (1 byte)
 	li   $a2, 1                      # ler apenas 1 byte
 	syscall 			 # executa a leitura
 	
 	beqz $v0, end_copiar
 	
 	li   $v0, 15                     # syscall para escrever em arquivo
    	move $a0, $s1                    # descritor do arquivo de destino
    	la   $a1, buffer                 # endereço do buffer (o byte lido)
    	li   $a2, 1                      # escrever 1 byte
    	syscall
    	
    	j copiar_loop
    	
end_copiar:
    li   $v0, 16                     # syscall para fechar arquivo
    move $a0, $s0                    # descritor do arquivo de origem
    syscall                          # fecha o arquivo

    li   $v0, 16                     # syscall para fechar arquivo
    move $a0, $s1                    # descritor do arquivo de destino
    syscall                          # fecha o arquivo

    li   $v0, 10                     # syscall para sair
    syscall  