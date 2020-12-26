.equ SLIDERS, 0x10000040
.equ LEDVERDE, 0x10000010   
.equ MASK_SETE, 0x8F

.global _start
_start: 

	movia r8, SLIDERS 		/*Obtem endereco sliders*/
	movia r9, LEDVERDE 		/*Obtem endereco leds verdes*/      	
	movia r11, MASK_SETE	/*Obtem mascara*/
	mov r12, r0				/*Zera Soma*/
LOOP:	
	ldwio r10, 0(r8)		/*Obtem valor dos sliders*/	
	and r10, r10, r11		/*Obtem 7 bits menos significativos*/
	add r12, r12, r10		/*r12 += r10 */
	stwio r12, 0(r9)		/*Escreve led verde*/	

	br LOOP