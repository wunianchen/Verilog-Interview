module seq_detect_tb();
	logic clk, reset, x_in;
	wire z_out;

	seq_detect seq_1(
		.clk(clk),
		.reset(reset),
		.x_in(x_in),
		.z_out(z_out)
	);

	initial begin
		reset 	= 1;
		clk 	= 0;
		x_in 	= 0;

		#10 reset 	= 0;
		#10 x_in	= 0;
		#10 x_in 	= 1;
		#10 x_in 	= 1;
		#10 x_in 	= 0;
		#10 x_in 	= 1;
		#10 x_in 	= 1;
		#10 x_in 	= 0;
		#10 x_in 	= 1;
		#10 x_in 	= 0;
		#10 x_in 	= 1;
		#10 x_in 	= 0;
		#10 $finish;
	end

	always begin
		#5 clk = ~clk;
	end

	// dump wave
	initial begin
		$dumpfile("wave.vcd");
		$dumpvars(0,seq_detect_tb);
	end
endmodule
