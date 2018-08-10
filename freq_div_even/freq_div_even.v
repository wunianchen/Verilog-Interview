`timescale 1ns/1ns

module freq_div_even(
	input 			clk_in,
	input 			reset,
	output logic 	clk_out
);
	parameter 	N = 4'd2;
	logic[3:0] 	cnt = 4'd0;
	logic		next_clk_out;
	logic[3:0] 	next_cnt;

	// always_comb part
	always@(cnt)begin
		if(cnt == N-1) 		next_cnt = 4'd0;
		else				next_cnt = cnt + 1'b1;

		if(cnt == 4'd0) 	next_clk_out = 1'b1;
		else if(cnt == N/2) next_clk_out = 1'b0;
		else				next_clk_out = clk_out;
	end


	// always_ff part
	always@(posedge clk_in)begin
		if(reset)begin
			clk_out <= 1'b0;
			cnt		<= 4'd0;
		end
		else begin
			cnt 	<= next_cnt;
			clk_out <= next_clk_out;
		end
	end
endmodule
