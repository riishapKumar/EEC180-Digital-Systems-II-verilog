module top(

	//////////// Inputs //////////
	input		start,
	input		reset,
	input 	clk,
	
	//////////// Outputs //////////
	output 									done,
	output			[10:0]				clock_count
	
	
	
);
	parameter 								DATA_WIDTH = 8;
	parameter 								ADDR_WIDTH = 6;
	
	//reg and wire declarations
	reg 			[(ADDR_WIDTH - 1):0]	address_a;
	reg 			[(ADDR_WIDTH - 1):0]	address_b;
	reg 			[(ADDR_WIDTH - 1):0]	address_c;

	wire			[(DATA_WIDTH - 1):0]	data_in_a;
	wire			[(DATA_WIDTH - 1):0]	data_in_b;
	wire			[(DATA_WIDTH - 1):0]	data_out_a;
	wire			[(DATA_WIDTH - 1):0]	data_out_b;

	reg			write_enable_a;
	reg 			write_enable_b;
	reg			write_enable_c;
	reg			clear_mac;

	wire			[18:0]					mac_out;
	wire			[18:0]					data_out_c;

	reg			[10:0]					clock_count_in;
	//reg			[10:0]					clock_temp;
	reg			[10:0]					value_a;
	reg			[10:0]					value_b;
	reg			[10:0]					value_c;

	
	//instantiation
	singlePortRam 	#(DATA_WIDTH, ADDR_WIDTH, "ram_a_init.txt")	
	ram_a(
		address_a, 
		data_in_a, 
		write_enable_a, 
		clk, 
		data_out_a
	);

	singlePortRam 	#(DATA_WIDTH, ADDR_WIDTH, "ram_b_init.txt")	
	ram_b(
		address_b, 
		data_in_b, 
		write_enable_b, 
		clk, 
		data_out_b
	);

	MAC	mac(
		data_out_a, 
		data_out_b, 
		clear_mac, 
		clk, 
		mac_out
	);

	singlePortRam	#(19, ADDR_WIDTH)
	RAMOUTPUT(
		address_c, 
		mac_out, 
		write_enable_c, 
		clk, 
		data_out_c
	);

	controlFSM	control(
		start, 
		reset, 
		clk, 
		clock_count_in, 
		done, 
		clock_count
	);

	//address, clear, enable logics
	always @(*)
	begin
		clock_count_in = clock_count;
		value_a = (2*((clock_count - 1) % 8) * 4) ;
		address_a = value_a +  ((clock_count - 1) / 64) + (clock_count_in - clock_count);
		address_b = ((clock_count - 1) % 64);

		if (clock_count > 2 || reset)
		begin
			clear_mac = ((clock_count - 2) % 8 == 0);
		end

		value_c = ((2*((clock_count - 3) / 8) * 4) % 64);
		address_c = value_c + (clock_count - 3)/64 + (clock_count_in - clock_count);
		write_enable_c = clear_mac;
	end
	
endmodule
	