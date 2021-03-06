module sr_5 (mac_in_5, ff_5_4_out, ff_5_3_out, ff_5_2_out, ff_5_1_out, ff_5_0_out, clk, out_5);

	input				[18:0] mac_in_5;
	input 				[18:0] ff_5_4_out, ff_5_3_out, ff_5_2_out, ff_5_1_out, ff_5_0_out;
	input				clk;
	
	output			[18:0]	out_5;
	
	
	dff			bufferdff_5_4(mac_in_5, clk, ff_5_4_out);
	dff    		bufferdff_5_3(ff_5_4_out, clk, ff_5_3_out);
	dff			bufferdff_5_2(ff_5_3_out, clk, ff_5_2_out);
	dff			bufferdff_5_1(ff_5_2_out, clk, ff_5_1_out);
	dff			bufferdff_5_0(ff_5_1_out, clk, ff_5_0_out);
	
	
	assign out_5 = ff_5_0_out;
	
	
endmodule