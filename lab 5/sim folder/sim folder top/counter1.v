module counter1(
	input 			reset,
	input			enable,
	input 		[5:0] divideby,
	output reg			go,
	input					clk,
   output   [5:0] countTB
);
	reg		[5:0] count1 = 6'b000000;

assign countTB=count1;
always @(posedge clk )
 begin

	if(reset)
		begin
			count1<=0;
			
		end
	else if(enable)
		begin
			if((count1== divideby-1) && (divideby !=0) )
				begin
					go<=1;
					count1<=6'd0;
				end
			else
				begin				
					go<=0;
					if(divideby==0) begin
						count1<=0;
					end	
					else begin
						count1<=count1+1;
					end	
				end
				
		end
		else begin
			count1<=count1;
        end			
end
endmodule		