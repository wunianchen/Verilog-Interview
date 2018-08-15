`timescale 1ns/1ns
typedef enum logic {READ, WRITE} COMMAND;


module CAM #(parameter SIZE=8)(
	input 							clock, reset,
	input 							enable,
	input COMMAND 					command,
	input[31:0]						data,
	input[$clog2(SIZE)-1:0]			write_idx,

	output logic[$clog2(SIZE)-1:0]	read_idx,
	output logic					hit
);

	logic[SIZE-1:0][31:0]			mem;	
	logic[SIZE-1:0]					mem_valid, next_mem_valid;

	logic[$clog2(SIZE)-1:0]			next_read_idx;
	logic							next_hit;

	always@* begin
		next_mem_valid	= mem_valid;
		next_hit 		= 0;
		next_read_idx	= 0;
		if(enable && command == WRITE & write_idx <= SIZE-1)begin
			next_mem_valid[write_idx] = 1;
		end
		else if(enable && command == READ)begin
			for(int i = SIZE - 1; i >= 0; i--)begin
				if(mem[i] == data && mem_valid[i])begin
					next_hit		= 1;
					next_read_idx	= i;
				end
			end
		end
	end

	always@(posedge clock)begin
		if(reset)begin
			read_idx	<= 0;
			hit			<= 0;
			mem_valid	<= 0;
		end
		else begin
			read_idx	<= next_read_idx;
			hit			<= next_hit;
			mem_valid	<= next_mem_valid;
			if(enable && command == WRITE & write_idx <= SIZE-1)begin
				mem[write_idx] <= data;
			end
		end
	end
endmodule
