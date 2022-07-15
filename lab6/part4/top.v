module top (
	
	input		start,
	input		reset,
	input 	clk,
	
	output 									done,
	output			[10:0]				clock_count
	
	);

	parameter 								DATA_WIDTH = 8;
	parameter 								ADDR_WIDTH = 6;
	
	//reg and wire declarations
	reg 			[(ADDR_WIDTH - 1):0]	address_a_7;
	reg 			[(ADDR_WIDTH - 1):0]	address_a_6;
	reg 			[(ADDR_WIDTH - 1):0]	address_a_5;
	reg 			[(ADDR_WIDTH - 1):0]	address_a_4;
	reg 			[(ADDR_WIDTH - 1):0]	address_a_3;
	reg 			[(ADDR_WIDTH - 1):0]	address_a_2;
	reg 			[(ADDR_WIDTH - 1):0]	address_a_1;
	reg 			[(ADDR_WIDTH - 1):0]	address_a_0;
	reg 			[(ADDR_WIDTH - 1):0]	address_b;
	reg 			[(ADDR_WIDTH - 1):0]	address_c;
	
	
	
	wire			[(DATA_WIDTH - 1):0]	data_in_a;
	wire			[(DATA_WIDTH - 1):0] data_in_b;
	wire			[(DATA_WIDTH - 1):0] data_out_a_7;
	wire			[(DATA_WIDTH - 1):0] data_out_a_6;
	wire			[(DATA_WIDTH - 1):0] data_out_a_5;
	wire			[(DATA_WIDTH - 1):0] data_out_a_4;
	wire			[(DATA_WIDTH - 1):0] data_out_a_3;
	wire			[(DATA_WIDTH - 1):0] data_out_a_2;
	wire			[(DATA_WIDTH - 1):0] data_out_a_1;
	wire			[(DATA_WIDTH - 1):0] data_out_a_0;
	wire			[(DATA_WIDTH - 1):0] data_out_b;
	
	
	reg			write_enable_a;
	reg 			write_enable_b;
	reg			write_enable_c;
	reg			clear_mac;
	
	wire			[18:0]			mac_out_7;
	wire			[18:0]			mac_out_6;
	wire			[18:0]			mac_out_5;
	wire			[18:0]			mac_out_4;
	wire			[18:0]			mac_out_3;
	wire			[18:0]			mac_out_2;
	wire			[18:0]			mac_out_1;
	wire			[18:0]			mac_out_0;
	wire			[18:0]			buffer_out;
	wire			[18:0]			data_out_c;
	
	reg			[10:0]					clock_count_in;
	reg			[18:0]					clock_value;
	reg			[18:0]					matrix_val;
	controlFSM	control(
		start, 
		reset, 
		clk, 
		clock_count_in, 
		done, 
		clock_count
	);
	dualPortRam 	#(DATA_WIDTH, ADDR_WIDTH, "ram_a_init.txt")	
	ram_a76(
		address_a_7, 
		address_a_6, 
		data_in_a, 
		write_enable_a, 
		write_enable_a, 
		clk, 
		data_out_a_7, 
		data_out_a_6
	);
	dualPortRam 	#(DATA_WIDTH, ADDR_WIDTH, "ram_a_init.txt")	
	ram_a54(
		address_a_5, 
		address_a_4, 
		data_in_a, 
		write_enable_a, 
		write_enable_a, 
		clk, 
		data_out_a_5, 
		data_out_a_4
	);
	dualPortRam 	#(DATA_WIDTH, ADDR_WIDTH, "ram_a_init.txt")	
	ram_a32(
		address_a_3, 
		address_a_2, 
		data_in_a, 
		write_enable_a, 
		write_enable_a, 
		clk, 
		data_out_a_3, 
		data_out_a_2
	);
	dualPortRam 	#(DATA_WIDTH, ADDR_WIDTH, "ram_a_init.txt")	
	ram_a01(
		address_a_1, 
		address_a_0, 
		data_in_a, 
		write_enable_a, 
		write_enable_a, 
		clk, 
		data_out_a_1, 
		data_out_a_0
	);
	singlePortRam 	#(DATA_WIDTH, ADDR_WIDTH, "ram_b_init.txt")	
	ram_b(
		address_b, 
		data_in_b, 
		write_enable_b, 
		clk, 
		data_out_b
	);
	MAC	mac7(
		data_out_a_7, 
		data_out_b, 
		clear_mac, 
		clk, 
		mac_out_7
	);
	MAC	mac6(
		data_out_a_6, 
		data_out_b, 
		clear_mac, 
		clk, 
		mac_out_6
	);
	MAC	mac5(
		data_out_a_5, 
		data_out_b, 
		clear_mac, 
		clk, 
		mac_out_5
	);
	MAC	mac4(
		data_out_a_4, 
		data_out_b, 
		clear_mac, 
		clk, 
		mac_out_4
	);
	MAC	mac3(
		data_out_a_3, 
		data_out_b, 
		clear_mac, 
		clk, 
		mac_out_3
	);
	MAC	mac2(
		data_out_a_2, 
		data_out_b, 
		clear_mac, 
		clk, 
		mac_out_2
	);
	MAC	mac1(
		data_out_a_1, 
		data_out_b, 
		clear_mac, 
		clk, 
		mac_out_1
	);
	MAC	mac0(
		data_out_a_0, 
		data_out_b, 
		clear_mac, 
		clk, 
		mac_out_0
	);
	
	eightBuffer		macbuffer(
		mac_out_7, 
		mac_out_6, 
		mac_out_5, 
		mac_out_4, 
		mac_out_3, 
		mac_out_2, 
		mac_out_1, 
		mac_out_0, 
		clk, 
		clock_count, 
		buffer_out
	);
	singlePortRam	#(19, ADDR_WIDTH)	
	
	RAMOUTPUT(
		address_c, 
		buffer_out, 
		write_enable_c, 
		clk, 
		data_out_c
	);
	
	//address, clear, enable logics
	always @(clock_count)
	begin
		clock_count_in = clock_count;
		clock_value = (2*((clock_count - 1) % 8) * 4) ;
		address_a_7 = clock_value +  2 * ((clock_count - 1) / 64) + (clock_count_in - clock_count) + 7 ;
		address_a_6 = clock_value +  2 * ((clock_count - 1) / 64) + (clock_count_in - clock_count) + 6;
		address_a_5 = clock_value +  2 * ((clock_count - 1) / 64) + (clock_count_in - clock_count) + 5;
		address_a_4 = clock_value +  2 * ((clock_count - 1) / 64) + (clock_count_in - clock_count) + 4;
		address_a_3 = clock_value +  2 * ((clock_count - 1) / 64) + (clock_count_in - clock_count) + 3;
		address_a_2 = clock_value +  2 * ((clock_count - 1) / 64) + (clock_count_in - clock_count) + 2;
		address_a_1 = clock_value +  2 * ((clock_count - 1) / 64) + (clock_count_in - clock_count) + 1;
		address_a_0 = clock_value +  2 * ((clock_count - 1) / 64) + (clock_count_in - clock_count);
		address_b = ((clock_count - 1) % 64);
		
		if (clock_count >= 2)
		begin
			clear_mac = ((clock_count - 2) % 8 == 0);
		end
		
		address_c = clock_count - 11;
		
		write_enable_c = (clock_count > 10) ;

	end

endmodule