`timescale 1ns/1ns

module freq_div2(
	input			clk_100,
	output 			clk_out
);   

	parameter N	 = 4'd8;
	reg[3:0] cnt = 4'd0;
	
	always@(posedge clk_100)
	begin
	    if(cnt == (N-1))
	       cnt <= 4'd0;
	    else
	       cnt <= cnt + 1'b1;
	end
	
	reg clkout =1'b0;
	always@(posedge clk_100)
	begin
	  if(cnt == 4'd0)
	    clkout <= 1'b1;
	  else if(cnt == (N/2))
	    clkout <= 1'b0;
	  else
	    clkout <= clkout;
	end
	assign clk_out =clkout;
endmodule
