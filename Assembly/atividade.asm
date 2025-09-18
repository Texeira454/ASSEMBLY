# Este programa escreve um arquivo com o conte�do de um buffer
# O arquivo � criado na pasta de instala��o do Mars
#
.data
arquivo_origem:   .asciiz "arquivo.txt"      # nome do arquivo para escrita
arquivo_destino:   .asciiz "arquivo_destino.txt"      # nome do arquivo para escrita
buffer: .space 1024

.text
# $s0: descritor do arquivo aberto
# $s1: endere�o do bloco de dados do arquivo lido
#abre arquivo para leitura
	li   $v0, 13       # chamada de sistema para abrir arquivo
	la   $a0, arquivo_origem      
	li   $a1, 0        # abrir para leitura
	li   $a2, 0
	syscall            # abre arquivo! (descritor do arquivo retornado em $v0)
	move $s0, $v0      # salva o descritor de arquivo 

#l� do arquivo
	li   $v0, 14       # chamada de sistema para ler arquivo
	move $a0, $s0      # descritor do arquivo 
	la   $a1, buffer   # endere�o do buffer para receber a leitura
	move $s1, $a1      # salva ponteiro para buffer em $s1
	li   $a2, 1024     # n�mero m�ximo de caracters a serem lidos
	syscall            # executa leitura do arquivo!
  
  # Fecha o arquivo 
	li   $v0, 16       # chamada de sistema para fechar arquivo
	move $a0, $s0      # descritor do arquivo a ser fechado
	syscall    

# Abre arquivo
  li   $v0, 13       # chamada de sistema para abrir arquivo
  la   $a0, arquivo_destino  # arquivo de sa�da
  li   $a1, 1        # abertura para escrita (flags s�o 0: read, 1: write)
  li   $a2, 0        # modo ignorado
  syscall            # abre arquivo! (descritor do arquivo retornado em $v0)
  move $s6, $v0      # guarda o descritor do arquivo em $s6
  
  # Escreve no arquivo aberto
  li   $v0, 15       # chamada de sistema para abrir arquivo
  move $a0, $s6      # descritor do arquivo
  la   $a1, buffer   # endere�o do buffer com conte�do a escrever no arquivo
  li   $a2, 100      # n�mero de caracteres a serem escritos
  syscall            # escreve!

feito:  
  li $v0, 10
  syscall      	     # feito!