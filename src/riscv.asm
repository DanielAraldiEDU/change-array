.data
	
	anunciado: .asciz "Entre com o tamanho dos vetores (máx. = 8 e mín. = 2): "
	tamanhoInvalido: .ascii "Valor inválido, Digite novamente!\n"
	Vetor_A: .word 0, 0, 0, 0, 0, 0, 0, 0
	Vetor_B: .word 0, 0, 0, 0, 0, 0, 0, 0
	
.text

  addi a7, zero, 4
  la a0, anunciado 
  ecall
  
  addi t5, zero, 2
  addi t6, zero, 9
    
  verificador:
	  addi a7, zero, 5
	  ecall
	  
	  add s11, zero, a0
	  
	  jal endDigitoInvalido
    
    digitoInvalido:
    		addi a7, zero, 4
	    la a0, tamanhoInvalido
	    ecall
	    
	    jal verificador
    endDigitoInvalido:
    
  		blt s11, t5, digitoInvalido
	  bge s11, t6, digitoInvalido
  endVerificador: