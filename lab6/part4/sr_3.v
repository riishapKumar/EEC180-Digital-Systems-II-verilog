module sr_3 (mac_in_3, ff_3_2_out, ff_3_1_out, ff_3_0_out, clk, out_3);

	input				[18:0] mac_in_3;
	input 				[18:0] ff_3_2_out, ff_3_1_out, ff_3_0_out;
	input				clk;
	
	output			[18:0]	out_3;
	
	
	dff			bufferdff_3_2(mac_in_3, clk, ff_3_2_out);
	dff			bufferdff_3_1(ff_3_2_out, clk, ff_3_1_out);
	dff			bufferdff_3_0(ff_3_1_out, clk, ff_3_0_out);
	
	
	assign out_3 = ff_3_0_out;
	
	
endmodule