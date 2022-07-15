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

	
	

assign display=count2;
always @(posedge clk )
 begin

	if(reset)
		begin
			count2<=0;
			
		end
	else if(enable1 && enable2)
			begin
				if(free_run)
					begin
						if(up_down )
							count2<=count2+1;
						else
							count2<=count2-1;
					end
					
				else
					begin
						if(count2[23:0] == 8388607)
								count2<=count2;
							
						else
							begin
								if(up_down)
									count2<=count2+1;
								else
									count2<=count2-1;
							end	

						
					end
				
				
			end
		
		else
			count2<=count2;
			
end
		


// <= see this in always block posedge, sequential
endmodule