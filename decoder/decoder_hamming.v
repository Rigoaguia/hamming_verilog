/*
 Hamming Encoder + bit paridade
 
 Autor: Ricardo Aguiar
 Data:  21/06/2019
 Descrição: Hamming Decoder(15,11) 
 
 Código de hamming é capaz de detectar e corrigir apenas um bit errado.
 A extensão de hamming apresentado no código abaixo utiliza a codificação
 de hamming + bit de paridade.
 
 INPUT/OUTPUT
 - data_out: dados decodificados;
 - c_h: código de hamming(c_h[0:14]) + 1 bit de paridade(c_h[15]);
 - enable: enable do sistema;
 - error: (1 -> ocorreu erros) e (0 -> não ocorreu erros);
 - error_incorrigible: (0 -> erro corrigido) e (1-> não foi possível corrigir o erro).
 
 Se 'incorrigible' for igual a 0 e 'error' for igual a 1, ocorreu um erro,mas o erro
 foi corrigido. Se 'incorrigible' for igual a 1 não é possível corrigir o erro !! Nesse  
 caso(incorrigible = 1) é necessário que o transmissor reenvie a informação.

 */

module decoder_hamming(
    input wire [0:15] c_h,
    output reg [0:10] data_out,
	input wire enable,
    output reg error,
    output reg error_incorrigible
	);

  reg [3:0] error_index; // index do bit errado
  reg [0:15]data_aux;
  reg bit_parity; // bit de paridade
  
  always @(*) begin
    if(enable == 1'b1) begin
      
      error_index[0] = c_h[0] + c_h[2] + c_h[4] + c_h[6] + c_h[8] + c_h[10] + c_h[12] + c_h[14];  
      error_index[1] = c_h[1] + c_h[2] + c_h[5] + c_h[6] + c_h[9] + c_h[10] + c_h[13] + c_h[14];
      error_index[2] = c_h[3] + c_h[4] + c_h[5] + c_h[6] + c_h[11] + c_h[12] + c_h[13] + c_h[14];
      error_index[3] = c_h[7] + c_h[8] + c_h[9] + c_h[10] + c_h[11] + c_h[12] + c_h[13] + c_h[14];
      
      bit_parity =  c_h[0] ^ c_h[1] ^ c_h[2] ^ c_h[3] ^ c_h[4] ^ c_h[5] ^ c_h[6] ^ c_h[7] ^ c_h[8] ^ c_h[9] ^ c_h[10] ^ c_h[11] ^ c_h[12] ^ c_h[13] ^ c_h[14]; 
    
      if(error_index == 4'b0000)begin // nao ocorreu erros
         
        if(bit_parity == c_h[15])begin // compara se os bits de paridade são iguais
        	
          	error = 0;
            error_incorrigible = 0;
          
        	data_out[0] = c_h[2];
        	data_out[1] = c_h[4];
        	data_out[2] = c_h[5];
        	data_out[3] = c_h[6];
        	data_out[4] = c_h[8];
        	data_out[5] = c_h[9];
        	data_out[6] = c_h[10];
        	data_out[7] = c_h[11];
        	data_out[8] = c_h[12];
        	data_out[9] = c_h[13];
        	data_out[10] = c_h[14];
        end else begin // se os bits de paridades nao forem iguais é porque ocorreu um erro
         
          	error = 1;
            error_incorrigible = 0;
          
            data_out[0] = c_h[2];
        	data_out[1] = c_h[4];
        	data_out[2] = c_h[5];
        	data_out[3] = c_h[6];
        	data_out[4] = c_h[8];
        	data_out[5] = c_h[9];
        	data_out[6] = c_h[10];
        	data_out[7] = c_h[11];
        	data_out[8] = c_h[12];
        	data_out[9] = c_h[13];
        	data_out[10] = c_h[14];
        end
        
      end else begin // ocorreu erros
        
        if(bit_parity == c_h[15])begin
        
        	error = 1;
            error_incorrigible = 1;
          
          	data_out[0] = c_h[2];
        	data_out[1] = c_h[4];
        	data_out[2] = c_h[5];
        	data_out[3] = c_h[6];
        	data_out[4] = c_h[8];
        	data_out[5] = c_h[9];
        	data_out[6] = c_h[10];
        	data_out[7] = c_h[11];
        	data_out[8] = c_h[12];
        	data_out[9] = c_h[13];
        	data_out[10] = c_h[14];
          
        end else begin
         
          	error = 1;
            error_incorrigible = 0;
          
          	data_aux = c_h;
         
            data_aux[(error_index - 1)] = !data_aux[(error_index - 1)]; //altera o bit errado. 
        
        	data_out[0] = data_aux[2];
        	data_out[1] = data_aux[4];
        	data_out[2] = data_aux[5];
        	data_out[3] = data_aux[6];
        	data_out[4] = data_aux[8];
        	data_out[5] = data_aux[9];
        	data_out[6] = data_aux[10];
        	data_out[7] = data_aux[11];
        	data_out[8] = data_aux[12];
        	data_out[9] = data_aux[13];
        	data_out[10] = data_aux[14];
         
        end // else2
        
      end // else1
    end
  
  end// always

endmodule
