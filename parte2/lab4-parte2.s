.equ SLIDERS, 0x10000040
.equ LEDVERDE, 0x10000010   
.equ PUSH_BU, 0x10000050  
.equ MASK_SETE, 0x8F
.equ MASK_PB1, 0b0010

.global _start
_start: 

	movia r8, SLIDERS 		/*Obtem endereco sliders*/
	movia r9, LEDVERDE 		/*Obtem endereco leds verdes*/      	
	movia r11, MASK_SETE	/*Obtem mascara*/
	movia r15, PUSH_BU		/*Obtem endereco push button*/
	movia r13, MASK_PB1		/*Obtem mascara do push button 1*/
	mov r12, r0				/*Zera Soma*/
PUSH_BUTTON:	
	ldwio r14, 12(r15)		/*Obtem captura de borda - evento do botao*/	
	and r16, r14, r13 		/* check KEY1 */
	beq r16, zero, PUSH_BUTTON	/*Verifica se pressionou PB1*/	
	ldwio r10, 0(r8)		/*Obtem valor dos sliders*/	
	and r10, r10, r11		/*Obtem 7 bits menos significativos*/
	add r12, r12, r10		/*r12 += r10 */
	stwio r12, 0(r9)		/*Escreve led verde*/
	stwio r0, 12(r15)		/*Zera captura de borda */	
	br PUSH_BUTTON
	