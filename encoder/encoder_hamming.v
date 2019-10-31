/*
 Hamming Encoder + bit paridade
 
 Autor: Ricardo Aguiar
 Data:  21/06/2019
 Descrição: Hamming Encoder(15,11) 
 
 Código de hamming é capaz de detectar e corrigir apenas um bit errado.
 A extensão de hamming apresentado no código abaixo utiliza a codificação
 de hamming + bit de paridade.
 
 INPUT/OUTPUT
 - data_in: dados a ser codificada;
 - c_h: código de hamming(c_h[0:14]) + 1 bit de paridade(c_h[15]);
 - enable: enable do sistema.

*/
module encoder_hamming(
    input wire [0:10] data_in,
    output reg [0:15] c_h,
	input wire enable
	);

  reg [3:0]p;
  reg bit_parity; //bit de paridade
 
  always @(*) begin
    if(enable == 1'b1) begin
     	p[0] = ((data_in[0] ^ data_in[1]) ^ (data_in[3] ^ data_in[4])) ^ ((data_in[6] ^ data_in[8]) ^ data_in[10]);  
      	p[1] = ((data_in[0] ^ data_in[2]) ^ (data_in[3] ^ data_in[5])) ^ ((data_in[6] ^ data_in[9]) ^ data_in[10]);
        p[2] = ((data_in[1] ^ data_in[2]) ^ (data_in[3] ^ data_in[7])) ^ ((data_in[8] ^ data_in[9]) ^ data_in[10]);
        p[3] = ((data_in[4] ^ data_in[5]) ^ (data_in[6] ^ data_in[7])) ^ ((data_in[8] ^ data_in[9]) ^ data_in[10]);
    
    
    	c_h[0] = p[0];
    	c_h[1] = p[1];
    	c_h[2] = data_in[0];
    	c_h[3] = p[2];
    	c_h[4] = data_in[1];
    	c_h[5] = data_in[2];
    	c_h[6] = data_in[3];
    	c_h[7] = p[3];
    	c_h[8] = data_in[4];
    	c_h[9] = data_in[5];
    	c_h[10] = data_in[6];
    	c_h[11] = data_in[7];
    	c_h[12] = data_in[8];
    	c_h[13] = data_in[9];
    	c_h[14] = data_in[10];
      	
      	bit_parity =  c_h[0] ^ c_h[1] ^ c_h[2] ^ c_h[3] ^ c_h[4] ^ c_h[5] ^ c_h[6] ^ c_h[7] ^ c_h[8] ^ c_h[9] ^ c_h[10] ^ c_h[11] ^ c_h[12] ^ c_h[13] ^ c_h[14]; 
      	
        c_h[15] = bit_parity; // bit de paridade
      	
    end
  end

endmodule
