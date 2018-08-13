/*Frequency Divider by Any Odd Number N*/

`timescale 1ns/1ns

module freq_div_odd(
	input			clk_in,
	input			reset,
	output logic	clk_out
);
	parameter N = 9;
	logic					clk1_out, clk2_out, next_clk1_out, next_clk2_out;
	logic[$clog2(N)+1:0]	pos_count, neg_count, next_pos_count, next_neg_count;
	
	always@(pos_count)begin
		next_pos_count	= (pos_count == (N-1)) ? 0 : pos_count + 1;
		
		if(pos_count == (N-1))begin
			next_clk1_out = 1;
		end
		else if(pos_count == (N-1)/2 - 1)begin
			next_clk1_out = 0;
		end
	end
	
	always@(neg_count)begin
		next_neg_count	= (neg_count == (N-1)) ? 0 : neg_count + 1;
		
		if(neg_count == (N-1))begin
			next_clk2_out = 1;
		end
		else if(neg_count == (N-1)/2 - 1)begin
			next_clk2_out = 0;
		end
	end

	always@(pos_count or neg_count)begin
		clk_out = clk1_out || clk2_out;
	end

	always@(posedge clk_in)begin
		if(reset)begin
			clk1_out	<= 1'b0;
			pos_count	<= 0;
		end
		else begin
			pos_count	<= next_pos_count;
			clk1_out	<= next_clk1_out;
		end
	end
	
	always@(negedge clk_in)begin
		if(reset)begin
			clk2_out	<= 1'b0;
			neg_count	<= 0;
		end
		else begin
			neg_count	<= next_neg_count;
			clk2_out	<= next_clk2_out;
		end
	end
endmodule
