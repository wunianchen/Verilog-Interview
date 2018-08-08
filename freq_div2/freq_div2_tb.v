module freq_div2_tb();
	logic clk_in;
	wire clk_out;

	freq_div2 div2(
		.clk_100(clk_in),
		.clk_out(clk_out)
	);

	initial begin
		clk_in 	= 0;
		#100 $finish;
	end

	always begin
		#5 clk_in = ~clk_in;
	end

	initial begin
	$dumpfile("wave.vcd");
	$dumpvars(0,freq_div2_tb);
	end
endmodule
