`timescale 1ns / 1ps

module tb_encoder;
    
  reg [10:0]data_in;
  wire [15:0]c_h;
  reg enable;
  
  encoder_hamming encoder(
    .data_in(data_in),
    .c_h(c_h),
    .enable(enable)
  );
  
  	
  
  	initial begin
    	//$dumpfile("dump.vcd");
   		//$dumpvars(1,test);
    	
      	enable = 1'b1;
      	data_in = 11'b11010101101;
      		
		#1
        //$display("%b",c_h);		
		$finish;
    
 	end
  	
  
  
endmodule
