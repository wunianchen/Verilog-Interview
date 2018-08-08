// Exercise 1: Sequence Detector of 11011 with overlap

`timescale 1s/1ns

module seq_detect(
	input 			clk,
	input 			reset,
	input			din,
	output logic 	z
);

	logic[2:0] 		state, next_state;
	
	// Declare all states
	parameter	S0 = 3'b000,
				S1 = 3'b001,
				S2 = 3'b010,
				S3 = 3'b011,
				S4 = 3'b100;

	// Define all states
	always@(din or state) begin
		case(state)
				S0: if(din == 1'b1)begin
						z = 1'b0;
						next_state = S1;
					end
					else begin
						z = 1'b0;
						next_state = S0;
					end

				S1: if(din == 1'b1)begin
						z = 1'b0;
						next_state = S2;
					end
					else begin
						z = 1'b0;
						next_state = S1;
					end

				S2: if(din == 1'b0)begin
						z = 1'b0;
						next_state = S3;
					end
					else begin
						z = 1'b0;
						next_state = S2;
					end

				S3: if(din == 1'b1)begin
						z = 1'b0;
						next_state = S4;
					end
					else begin
						z = 1'b0;
						next_state = S1;
					end

				S4: if(din == 1'b1)begin
						z = 1'b1;
						next_state = S2;
					end
					else begin
						z = 1'b0;
						next_state = S1;
					end
				default: next_state = S1;
		endcase
	end
			
	always@(posedge clk) begin
		if(reset) begin
			state <= S1;
		end
		else begin
			state <= next_state;
		end
		$display("input:%01b\t\toutput:%01b\t\t", din, z);
	end

endmodule
