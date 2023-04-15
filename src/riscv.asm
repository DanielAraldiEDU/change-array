.data
	
	anunciado: .asciz "Entre com o tamanho dos vetores (máx. = 8 e mín. = 2): "
	tamanhoInvalido: .asciz "Valor inválido, digite novamente: "
	vetoresTrocados: .asciz "\nVetor A e B trocados:"
	
	quebraLinha: .asciz "\n"
	finalVetorMensagem: .asciz "] = "
	
	Vetor_A: .word 0, 0, 0, 0, 0, 0, 0, 0
	vetorAMensagem: .asciz "Vetor A["
	
	Vetor_B: .word 0, 0, 0, 0, 0, 0, 0, 0
	vetorBMensagem: .asciz "Vetor B["
	
	VetorAuxiliar: .word 0, 0, 0, 0, 0, 0, 0, 0
	
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
  
  la s1, Vetor_A
  la s6, VetorAuxiliar
  
  add t0, zero, zero
  
  forA:
  	bge t0, s11, endForA
			addi a7, zero, 4
			la a0, vetorAMensagem
			ecall
				
			addi a7, zero, 1
			add a0, zero, t0
			ecall 
				
			addi a7, zero, 4
			la a0, finalVetorMensagem
			ecall
				
			addi a7, zero, 5
			ecall
			add s0, zero, a0
				
			slli t1, t0, 2
			add s2, s1, t1
			sw s0, 0(s2)
			add s2, s6, t1
			sw s0, 0(s2)
				
			addi t0, t0, 1
			
			jal forA
  endForA:
  
  la s4, Vetor_B 
  
  add t0, zero, zero
  
  forB:
  	bge t0, s11, endForB
			addi a7, zero, 4
			la a0, vetorBMensagem
			ecall
				
			addi a7, zero, 1
			add a0, zero, t0
			ecall 
				
			addi a7, zero, 4
			la a0, finalVetorMensagem
			ecall
				
			addi a7, zero, 5
			ecall
			add s3, zero, a0
				
			slli t1, t0, 2
			add s5, s4, t1
			sw s3, 0(s5)
			add s5, s1, t1
			sw s3, 0(s5)
				
			addi t0, t0, 1
			
			jal forB
  endForB:
  
  add t0, zero, zero
  
  addi a7, zero, 4
	la a0, vetoresTrocados
	ecall
	
	showForA: 
		bge t0, s11, endShowForA
			addi a7, zero, 4
			la a0, quebraLinha
			ecall
			
			addi a7, zero, 4
			la a0, vetorAMensagem
			ecall
			
			addi a7, zero, 1
			add a0, zero, t0
			ecall 
			
			addi a7, zero, 4
			la a0, finalVetorMensagem
			ecall
			
			slli t1, t0, 2
			add s8, s1, t1
			lw a0, 0(s8)
			
			addi a7, zero, 1
			ecall 
			
			addi t0, t0, 1
		
			jal showForA
	endShowForA:
	
	add t0, zero, zero
	
	showForB: 
		bge t0, s11, endShowForB
			addi a7, zero, 4
			la a0, quebraLinha
			ecall
			
			addi a7, zero, 4
			la a0, vetorBMensagem
			ecall
			
			addi a7, zero, 1
			add a0, zero, t0
			ecall 
			
			addi a7, zero, 4
			la a0, finalVetorMensagem
			ecall
			
			slli t1, t0, 2
			add s8, s4, t1
			lw a0, 0(s8)
			
			addi a7, zero, 1
			ecall 
			
			addi t0, t0, 1
		
			jal showForB
	endShowForB: