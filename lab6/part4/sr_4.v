module sr_4 (mac_in_4, ff_4_3_out, ff_4_2_out, ff_4_1_out, ff_4_0_out, clk, out_4);

	input				[18:0] mac_in_4;
	input 				[18:0] ff_4_3_out, ff_4_2_out, ff_4_1_out, ff_4_0_out;
	input				clk;
	
	output			[18:0]	out_4;
	
	
	dff       		bufferdff_4_3(mac_in_4, clk, ff_4_3_out);
	dff	   		bufferdff_4_2(ff_4_3_out, clk, ff_4_2_out);
	dff	    		bufferdff_4_1(ff_4_2_out, clk, ff_4_1_out);
	dff	   		bufferdff_4_0(ff_4_1_out, clk, ff_4_0_out);
	
	
	assign out_4 = ff_4_0_out;
	
	
endmodule