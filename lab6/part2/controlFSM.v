module controlFSM( 
	input 						start,
	input 						reset,
	input 						clk,
	
	input			[10:0]		clock_count_in,
	
	output reg					done,
	output reg	[10:0]		clock_count_out

	);
	
	reg			[1:0]			current_state;
	reg			[1:0]			next_state;
	reg			[10:0]			tempclock;
	reg						tempdone;
	

	
	//output logic
	always @ ( posedge clk )
	begin
		if (reset)
		begin
			current_state <= 0;
			clock_count_out <= 0;
			done <= 0;
		end
		else
		begin
			current_state <= next_state;
			clock_count_out <= tempclock;
			done <= tempdone;
		end
	end
	
	//next state logic
	always @(start, reset, clock_count_in)
	begin

		if (current_state == 0)
			begin
				if (start == 0)
				begin
					next_state <= 0;
					tempdone <= 0;
					tempclock <= 0;
				end
				else
				begin
					next_state <= 1;
					tempdone <= 0;
					tempclock <= 1;
				end
			end
			
		else if (current_state == 1)
			begin
				if (clock_count_in != 516)
				begin
					next_state <= 1;
					tempdone <= 0;
					tempclock <= clock_count_in + 1;
				end
				else
				begin
					next_state <= 2;
					tempdone <= 1;
					tempclock <= clock_count_in;
				end
			end
			
		else if (current_state == 2)

				begin
					next_state <= 2;
					tempdone <= 1;
					tempclock <= clock_count_in;
				end
		else
			begin
				next_state <= next_state;
			end
	end
endmodule

