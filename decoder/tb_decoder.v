`timescale 1ns / 1ps

module tb_decoder;
    
  reg [15:0]c_h;
  wire [10:0]data_out;
  reg enable;
  wire error_incorrigible;
  wire error;
  
  decoder_hamming decoder(
    .data_out(data_out),
    .c_h(c_h),
    .enable(enable),
    .error(error),
    .error_incorrigible(error_incorrigible)
  );
  
  	
  
  	initial begin
    	//$dumpfile("dump.vcd");
   		//$dumpvars(1,test);
    	
      	enable = 1'b1;
                                 
      	c_h = 16'b101110100101101_1; // o bit LSB é o bit de paridade 
      		
        #1
      //$display("data_out: %b",data_out);
      //$display("error: %b",error);
      //$display("error_incorrigible: %b",error_incorrigible);
      
      
		$finish;
    
 	end
  	//10101010101
  
  
endmodule
