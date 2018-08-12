`timescale 1ns/1ns

module freq_div3(
	input			clk_in,
	input			reset,
	output logic	clk_out
);

	logic			clk1_out, clk2_out, next_clk1_out, next_clk2_out;
	logic[1:0]		pos_count = 2'd0, neg_count = 2'd0;
	logic[1:0] 		next_pos_count, next_neg_count;

	always@(pos_count)begin
		next_pos_count	= (pos_count == 2'd2) ? 2'd0 : pos_count + 2'd1;
		next_clk1_out	= (pos_count == 2'd0) ? 1'b1 : 1'b0;
	end

	always@(neg_count)begin
		next_neg_count	= (neg_count == 2'd2) ? 2'd0 : neg_count + 2'd1;
		next_clk2_out 	= (neg_count == 2'd0) ? 1'b1 : 1'b0;
	end

	always@(pos_count or neg_count)begin
		clk_out = clk1_out || clk2_out;
	end

	always@(posedge clk_in)begin
		if(reset)begin
			pos_count	<= 2'd0;
			clk1_out	<= 1'b0;
		end
		else begin
			pos_count	<= next_pos_count;
			clk1_out	<= next_clk1_out;
		end
	end

	always@(negedge clk_in)begin
		if(reset)begin
			neg_count	<= 2'd0;
			clk2_out	<= 1'b0;
		end
		else begin
			neg_count 	<= next_neg_count;
			clk2_out	<= next_clk2_out;
		end
	end 
endmodule
