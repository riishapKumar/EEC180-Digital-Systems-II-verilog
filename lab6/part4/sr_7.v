module sr_7 (mac_in_7, ff_7_6_out, ff_7_5_out, ff_7_4_out, ff_7_3_out, ff_7_2_out, ff_7_1_out, ff_7_0_out, clk, out_7);

	input				[18:0] mac_in_7;
	input 				[18:0] ff_7_6_out, ff_7_5_out, ff_7_4_out, ff_7_3_out, ff_7_2_out, ff_7_1_out, ff_7_0_out;
	input				clk;
	
	output			[18:0]	out_7;
	
	
	dff			bufferdff_7_6(mac_in_7, clk, ff_7_6_out);
	dff			bufferdff_7_5(ff_7_6_out, clk, ff_7_5_out);
	dff		   bufferdff_7_4(ff_7_5_out, clk, ff_7_4_out);
	dff		   bufferdff_7_3(ff_7_4_out, clk, ff_7_3_out);
	dff			bufferdff_7_2(ff_7_3_out, clk, ff_7_2_out);
	dff			bufferdff_7_1(ff_7_2_out, clk, ff_7_1_out);
	dff			bufferdff_7_0(ff_7_1_out, clk, ff_7_0_out);
	
	
	assign out_7 = ff_7_0_out;
	
	
endmodule