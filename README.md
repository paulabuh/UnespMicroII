# UnespMicroII
Micro II – Laboratório IV

Parte 1)

Foi feito um programa que lê o conteúdo das 8 primeiras chaves, acumulando esse valor em um registrador e mostrando-o nos leds verdes.
Basicamente, o programa consiste de um loop responsável pela captura dos dados das chaves e escrita desses dados nos leds. Para a captura dos dados, antes de tudo foi necessário conhecer o endereço base no qual o registrador de dados das chaves está mapeado na memória, por ser uma arquitetura RISC. Esse endereço será utilizado juntamente com a instrução ldwio para a captura dos dados. Observe que estamos usando uma versão diferente de ldw, isso é necessário pois as versões de ldw e stw com sufixo io desconsideram a memória cache, desta forma o acesso aos dispositivos é mais rápido e mais importante, se usássemos a memória cachê nessas operações, possivelmente estaríamos acessando dados desatualizados armazenados na cache. Após armazenarmos os valores das chaves no registrador, foi necessário o uso de uma máscara para obter apenas os 7 primeiros bits. Somados esses  bits com o valor obtido anteriormente (acumulador), realizamos em seguida, um simples stwio, passando a soma para o endereço base onde os leds verds estão mapeados na memória. Assim os leds verdes se acendem e resultado pode ser visto.
Esse programa teve sua execução feita em modo de depuração, para capturar corretamente o valor das chaves.


Parte 2)

Nesta segunda parte foi reaproveitado o código da primeira parte para implementar  a técnica de polling que nada mais é do que a espera ociosa da cpu por um evento ou condição. Para seu uso, incluímos um botão que auxilia nessa tarefa. 
Com o endereço onde estão mapeados os botões, carregamos para um registrador os dados presentes no registrador de captura de borda e usamos uma máscara para isolar o bit correspondente ao segundo botão. Apesar dos botões oferecerem o registrador de dados, usamos esse outro registrador porque sua precisão é maior, pois ele captura o evento do botão. Com esse bit verificamos se o botão foi pressionado ou não. Se não foi pressionado, repetimos o processo através de um loop e o programa fica aguardando, o que seria o polling. Caso o botão tenha sido pressionado, executamos a soma e mostramos o valor acumulado nos leds verdes.
Diferentemente do registrador de dados, após o registrador de captura de borda capturar um evento no botão, o valor de seu bit não retornará ao valor zero. Por essa razão, antes de reiniciarmos todo o processo anterior, precisamos zerar o valor de seu bit através de um store (stwio).
Foi lido apenas os 4-bits menos significativos das chaves para acumular no registrador da soma e os 4-bits menos significativos da soma foram exibidos no último número do display de 7 segmentos em forma hexadecimal. Para isso criamos um vetor de palavras na posição de memória 0x500, em que cada posição representada por um valor hexadecimal: 
.word 0x3F, 0x06, 0x5B, 0x4F, 0x66, 0x6D, 0x7D, 0x07, 0xFF, 0x6F, 0x77, 0x7C, 0x39, 0x5E, 0x79, 0x71
Para lermos corretamente esses valores do vetor, após a soma, separamos os 4-bits menos significativos que terão o valor em decimal de 0 a 15 e multiplicamos ele por 4, utilizando dois shifts para esquerda, para termos a posição correta do vetor, já que cada palavra possui 1 byte. Para ler o vetor necessita apenas somar a posição obtida a posição de memória em que o vetor começa que é 0x500, e ler o valor correspondente.
Para exibir o valor no display de sete segmentos, primeiro foi necessário saber em que posição de memória o dispositivo se encontra e carregar em um registrador. Após isso, foi feita uma máscara isolando os 4-bits menos significativos para eliminar possíveis “sujeiras” e em seguida é feito um store (stwio) com o valor obtido no vetor e o número é exibido no display.



Parte 3)

Na terceira parte o objetivo era mostrar a soma acumulada nas 4 últimas posições do display, para isso foi reaproveitado o código da parte 2 e as instruções relativas ao display de sete segmentos foi replicada para cada posição do display.
Também foi alterada a máscara que obtém o valor das chaves para obter valores de 16-bits.
Esse valor foi acumulado no registrador que guarda a soma e aplicado a ele uma máscara de 16-bits para eliminar possíveis “sujeiras”. Assim foram criadas outras 4 máscara para obter cada 4-bits desse número: 0-3, 4-7, 8-11 e 12-15. 
Para cada um desses números foi aplicado mesmo tratamento, conforme parte 2, para obter o valor correspondente do display no vetor utilizando 2 shifts e somando com a posição de memória do vetor.
Após ter todos os 4 números correspondentes ao display, cada um em sua posição correta foi realizado a instrução or para agrupar todos em um único valor. Com esse valor de 16-bits com os 4 números correspondentes ao display foi realizado um store (stwio) na posição de memória correspondente ao display para exibição do número.


