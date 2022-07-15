
//=======================================================
//  This code is generated by Terasic System Builder
//=======================================================
// A more complicated counter with additional elements
module top(

	//////////// CLOCK //////////
	input 		          		MAX10_CLK1_50,

	//////////// SEG7 //////////
	output		     [7:0]		HEX0,
	output		     [7:0]		HEX1,
	output		     [7:0]		HEX2,
	output		     [7:0]		HEX3,
	output		     [7:0]		HEX4,
	output		     [7:0]		HEX5,
	output			  [9:0]     LEDR,

	//////////// KEY //////////
	input 		     		KEY0,

	//////////// LED //////////

	//////////// SW //////////
	input 		     [9:0]		SW,
	output reg [9:0]		 LEDRs,
	output			[23:0] displayTB
);
wire [5:0] countTB;
wire [23:0] display;
wire			goWire;

always @(posedge MAX10_CLK1_50) begin
	if (SW[9:4] == 6'b000000)begin
		LEDRs <= 10'b1111111111;
	end
	
	else begin
		LEDRs <= 10'b0000000000;
	end
end
counter1 ctr1(
	.reset(~KEY0),
	.enable(SW[0]),
	.go(goWire),
	.divideby(SW[9:4]),
	.clk(MAX10_CLK1_50),
	.countTB(countTB)
);


counter2 ctr2(
	.reset(~KEY0),
	.enable1(SW[0]),
	.enable2(goWire),
	.up_down(SW[1]),
	.free_run(SW[2]),
	.display(display),
	.clk(MAX10_CLK1_50)
);

assign LEDR[9:0] = LEDRs;

 seg7 u_0(
 .bit4(display[3:0]),
 .hexOutput(HEX0)
 );

 seg7 u_1(
 .bit4(display[7:4]),
 .hexOutput(HEX1)
 );

  seg7 u_2(
 .bit4(display[11:8]),
 .hexOutput(HEX2)
 );

 seg7 u_3(
 .bit4(display[15:12]),
 .hexOutput(HEX3)
 );
 
  seg7 u_4(
 .bit4(display[19:16]),
 .hexOutput(HEX4)
 );

 seg7 u_5(
 .bit4(display[23:20]),
 .hexOutput(HEX5)
 );
assign displayTB = display;

endmodule