
module counter2(
	input wire			reset,
	input wire			enable1,
	input wire			enable2,
	input wire			up_down,
	input wire			free_run,
	input					clk,

	output  			[23:0] display

);
	reg					[23:0] count2 ;

// max value is 16777216 / 2 = 8388608 d 	

assign display=count2;
always @(posedge clk )
 begin

	if(reset)
	begin
			count2<= 24'd0;
	end
	else if(enable1 && enable2) // && based on description but count2 will work only for one cycle by the end of counter1
	begin
				if(free_run)
				begin
						if(up_down) begin
						    if(count2 == 24'd16777216) begin
							  count2 <=24'd0;							  
							end
							else begin
								count2<=count2+1;
							end
						end	
						else begin
							if(count2 == 24'd0) begin
							  count2 <=24'd0;							  
							end
							else begin						
								count2<=count2-1;
							end
						end	
				end	
				else
				begin
						if(up_down) begin
						    if(count2 == 24'd8388608) begin
							  count2 <=24'd0;							  
							end
							else begin
								count2<=count2+1;
							end
						end	
						else begin
							if(count2 == 24'd0) begin
							  count2 <=24'd0;							  
							end
							else begin						
								count2<=count2-1;
							end
						end	
						
				end			
	end
	else begin
			count2<=count2;
    end			
end
		
//when go = 0 ---> counter 2 is disabled

// <= see this in always block posedge, sequential
endmodule