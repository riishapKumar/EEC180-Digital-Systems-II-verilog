module top(

	//////////// Inputs //////////
	input		start,
	input		reset,
	input 	clk,
	
	//////////// Outputs //////////
	output 							done,
	output			[10:0]				clock_count
	
	
	
);



//=======================================================
//  REG/WIRE declarations
//=======================================================

	parameter 								DATA_WIDTH = 8;
	parameter 								ADDR_WIDTH = 6;
	
	
	reg 			[(ADDR_WIDTH - 1):0]	address_a_1;
	reg 			[(ADDR_WIDTH - 1):0]	address_a_0;
	reg 			[(ADDR_WIDTH - 1):0]	address_b;
	reg 			[(ADDR_WIDTH - 1):0]	address_c;
	
	wire			[(DATA_WIDTH - 1):0]	data_in_a;
	wire			[(DATA_WIDTH - 1):0] data_in_b;
	wire			[(DATA_WIDTH - 1):0] data_out_a_1;
	wire			[(DATA_WIDTH - 1):0] data_out_a_0;
	wire			[(DATA_WIDTH - 1):0] data_out_b;
	
	reg			write_enable_a;
	reg 			write_enable_b;
	reg			write_enable_c;
	reg			clear_mac;
	
	wire			[18:0]			mac_out_1;
	wire			[18:0]			mac_out_0;
	wire			[18:0]			buffer_out;
	wire			[18:0]			data_out_c;
	
	reg			[10:0]			clock_count_in;	
	reg			[10:0]			temp_val;

//=======================================================
//  Structural coding
//=======================================================

//instantiation
	dualPortRam 	#(DATA_WIDTH, ADDR_WIDTH, "ram_a_init.txt")	ram_a(
		address_a_1, 
		address_a_0, 
		data_in_a, 
		write_enable_a, 
		write_enable_a, 
		clk, 
		data_out_a_1, 
		data_out_a_0
	
	);
	
	singlePortRam 	#(DATA_WIDTH, ADDR_WIDTH, "ram_b_init.txt") ram_b(
		address_b, 
		data_in_b, 
		write_enable_b, 
		clk, 
		data_out_b
	
	);
	
	MAC			mac1(
		data_out_a_1, 
		data_out_b, 
		clear_mac, 
		clk, 
		mac_out_1
	
	);
	MAC			mac0(
	data_out_a_0, 
	data_out_b, 
	clear_mac, 
	clk, 
	mac_out_0
	
	);
	
	buffer		macbuffer(
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
	
	controlFSM			control(
		start, 
		reset, 
		clk, 
		clock_count_in, 
		done, 
		clock_count
	);

	always @(clock_count)
	begin
		clock_count_in = clock_count;
		temp_val = (2 * ((clock_count - 1) / 64)) + (clock_count_in - clock_count);
		address_a_1 = (2*((clock_count - 1) % 8) * 4) + temp_val + (clock_count_in - clock_count);
		address_a_0 = (2*((clock_count - 1) % 8) * 4) +  temp_val + (clock_count_in - clock_count)  + 1;
		address_b = ((clock_count - 1) % 64);
		//clear_mac = (((clock_count - 2) % 8 == 0) & clock_count > 2) | clock_count == 2;
		if (clock_count >= 2)
		begin
			clear_mac = ((clock_count - 2) % 8 == 0);
		end
		//write_enable_c = (((clock_count - 3) % 8 == 0) || (((clock_count - 4) % 8 == 0))) && clock_count > 4;
		if ( clock_count > 4 )
		begin
			write_enable_c = (((clock_count - 3) % 8 == 0) || (((clock_count - 4) % 8 == 0)));
		end	

		if (clock_count > 1)
		begin
			if (((clock_count - 3) % 8 == 0) )
			begin
				address_c = ((((clock_count - 11) / 8) * 8) % 64) + 2*((clock_count - 11)/64);
			end
		end
		if (clock_count > 2)
		begin
			if (((clock_count - 4) % 8 == 0) )
			begin
				address_c = ((((clock_count - 11) / 8) * 8) % 64) + 2*((clock_count - 11)/64) + 1;
			end
		end
	end



endmodule