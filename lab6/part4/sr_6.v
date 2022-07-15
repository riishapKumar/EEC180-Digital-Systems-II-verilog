module sr_6 (mac_in_6, ff_6_5_out, ff_6_4_out, ff_6_3_out, ff_6_2_out, ff_6_1_out, ff_6_0_out, clk, out_6);

	input				[18:0] mac_in_6;
	input 				[18:0] ff_6_5_out, ff_6_4_out, ff_6_3_out, ff_6_2_out, ff_6_1_out, ff_6_0_out;
	input				clk;
	
	output			[18:0]	out_6;
	
	
	dff			bufferdff_6_5(mac_in_6, clk, ff_6_5_out);
	dff			bufferdff_6_4(ff_6_5_out, clk, ff_6_4_out);
	dff			bufferdff_6_3(ff_6_4_out, clk, ff_6_3_out);
	dff			bufferdff_6_2(ff_6_3_out, clk, ff_6_2_out);
	dff			bufferdff_6_1(ff_6_2_out, clk, ff_6_1_out);
	dff			bufferdff_6_0(ff_6_1_out, clk, ff_6_0_out);
	
	
	assign out_6 = ff_6_0_out;
	
	
endmodule