module dff(D, clk, Q);

	input 		[18:0]		D;
	input							clk;
	output reg	[18:0]		Q;
	
	always @ (posedge clk)
	begin
		Q <= D;
	end
endmodule
