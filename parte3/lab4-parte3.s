# SLIDERS, 0x10000040 
# PUSH_BU, 0x10000050
# LED_VERDE, 0x10000010
# DISPLAY, 0x10000020
# MASK_PB1, 0b0010
.equ LIST, 0x500
.global _start
_start: 

	movia r8, 0x10000040 		/*Obtem endereco sliders*/  	
	movia r15, 0x10000050		/*Obtem endereco push button*/
	movia r9, 0x10000010		/*Obtem endereco leds verdes*/
	movia r17, 0x10000020		/*Obtem endereco display*/
	movia r11, LIST				/*Obtem endereco vetor*/
	mov r12, r0				/*Zera Soma*/
PUSH_BUTTON:	
	ldwio r14, 12(r15)		/*Obtem captura de borda - evento do botao*/	
	andi r16, r14, 0b0010 		/* check KEY1 */
	beq r16, zero, PUSH_BUTTON	/*Verifica se pressionou PB1*/	
	
	ldwio r10, 0(r8)		/*Obtem valor dos sliders*/		
	add r12, r12, r10		/*r12 += r10 */
	stwio r12, 0(r9)		/*Escreve led verde*/
	stwio r0, 12(r15)		/*Zera captura de borda */	
	
	mov r16, r0				/*Zera r16*/
	
	andi r18, r12, 0x0F		/*Obtem 4 bits menos significativos = 1o numero do display*/
	slli r18, r18, 0x02		/* Calculate the number of 2s by shifting the number */
	add r18, r18, r11		/* Soma para multiplar por 4*/
	ldw r18, 0(r18)			/* Obtem valor do display correspondente*/
	andi r18, r18, 0xFF		/* aplica mascara para 1 numero do display*/
	
	or r16, r16, r18
	
	andi r19, r12, 0xF0		/*Obtem 2o numero do display*/
	srli r19, r19, 0x02		/* Calculate the number of 2s by shifting the number */
	add r19, r19, r11		/* Soma para multiplar por 4*/
	ldw r19, 0(r19)			/* Obtem valor do display correspondente*/
	andi r19, r19, 0xFF		/* aplica mascara para 1 numero do display*/
	slli r19, r19, 0x08		/* Calculate the number of 2s by shifting the number */
	
	or r16, r16, r19
	
	andi r19, r12, 0xF00		/*Obtem 3o numero do display*/
	srli r19, r19, 0x06		/* Calculate the number of 2s by shifting the number */
	add r19, r19, r11		/* Soma para multiplar por 4*/
	ldw r19, 0(r19)			/* Obtem valor do display correspondente*/
	andi r19, r19, 0xFF		/* aplica mascara para 1 numero do display*/
	slli r19, r19, 0x10		/* Calculate the number of 2s by shifting the number */
	
	or r16, r16, r19
	
	andi r19, r12, 0xF000		/*Obtem 3o numero do display*/
	srli r19, r19, 0x0A		/* Calculate the number of 2s by shifting the number */
	add r19, r19, r11		/* Soma para multiplar por 4*/
	ldw r19, 0(r19)			/* Obtem valor do display correspondente*/
	andi r19, r19, 0xFF		/* aplica mascara para 1 numero do display*/
	slli r19, r19, 0x18		/* Calculate the number of 2s by shifting the number */
	
	or r16, r16, r19	
	
	stwio r16, 0(r17)		/*Escreve no display*/

	
	br PUSH_BUTTON
	
.org 0x500	
DISPLAY:					/* Vetor com valores do display*/
.word 0x3F, 0x06, 0x5B, 0x4F, 0x66, 0x6D, 0x7D, 0x07, 0xFF, 0x6F, 0x77, 0x7C, 0x39, 0x5E, 0x79, 0x71
.end