module sr_2 (mac_in_2, ff_2_1_out, ff_2_0_out,clk, out_2);

	input				[18:0] mac_in_2;
	input 				[18:0] ff_2_1_out, ff_2_0_out;
	input				clk;
	
	output			[18:0]	out_2;
	
	
	dff			bufferdff_2_1(mac_in_2, clk, ff_2_1_out);
	dff			bufferdff_2_0(ff_2_1_out, clk, ff_2_0_out);
	
	assign out_2 = ff_2_0_out;
	
	
endmodule