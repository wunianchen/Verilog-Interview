module seq_detect(
	input			clk,
	input			reset,
	input			x_in,
	output logic	z_out
);

	logic[1:0] state, next_state;

	parameter S0 = 2'b00, S1 = 2'b01, S2 = 2'b10;

	always@(x_in or state)begin
		case(state)
			S0: if(x_in == 1)begin
					next_state = S1;
					z_out = 0;
				end
				else begin
					next_state = S0;
					z_out = 0;
				end
			S1: if(x_in == 0)begin
					next_state = S2;
					z_out = 0;
				end
				else begin
					next_state = S1;
					z_out = 0;
				end
			S2: if(x_in == 1)begin
					next_state = S1;
					z_out = 1;
				end
				else begin
					next_state = S0;
					z_out = 0;
				end
		endcase
	end

	always@(posedge clk)begin
		if(reset)begin
			state <= S0;
		end
		else begin
			state <= next_state;
		end
	end
endmodule
