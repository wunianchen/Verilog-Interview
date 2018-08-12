module freq_div3_tb();
	logic clk_in, reset;
	wire clk_out;

	freq_div3 div3(
		.clk_in(clk_in),
		.reset(reset),
		.clk_out(clk_out)
	);

	initial begin
		clk_in 	= 0;
		reset	= 1;

		#10
		reset	= 0;

		#50
		reset	= 1;
		#60
		reset	= 0;

		#120 $finish;
	end

	always begin
		#5 clk_in = ~clk_in;
	end

	initial begin
	$dumpfile("wave.vcd");
	$dumpvars(0,freq_div3_tb);
	end
endmodule
