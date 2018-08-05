module seq_detect_tb();

	logic clk, din, reset;
	wire z;

	seq_detect sq_det(
		.clk(clk),
		.reset(reset),
		.din(din),
		.z(z)
	);

	initial begin
		clk 	= 0;
		din 	= 0;
		reset 	= 0;

		#10 din = 1;
		#10 din = 1;
		#10 din = 0;
		#10 din = 1;
		#10 din = 1;
		#10 din = 0;
		#10 din = 1;
		#10 din = 1;
		#10 din = 0;
		#10 din = 1;
		#10 din = 1;
		#10 din = 0;
		#10 $finish;
	end

	// dump wave
	initial begin
		$dumpfile("wave.vcd");
		$dumpvars(0,seq_detect_tb);
	end
	
	always begin
		#5 clk = ~clk;
	end
endmodule
