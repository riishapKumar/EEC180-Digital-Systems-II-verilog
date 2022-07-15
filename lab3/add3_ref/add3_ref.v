
module add3_ref(
	
	input [2:0] a,b,
	
	input cin,

	output reg [3:0] sum
);

	always@(*)
		begin
			sum= a+b+cin;
		end
		
endmodule

