module tb_top;

reg KEY0;
reg [9:0] SW;
wire goWire;
reg clk;
wire [23:0] display;
wire [7:0]		HEX0;
wire [7:0]		HEX1;
wire [7:0]		HEX2;
wire [7:0]		HEX3;
wire [7:0]		HEX4;
wire [7:0]		HEX5;
wire [9:0]     LEDR;
wire [9:0]		LEDRs;

top UUT (.KEY0(KEY0), .SW(SW), .MAX10_CLK1_50(clk), .displayTB(display), .HEX0(HEX0), .HEX1(HEX1), .HEX2(HEX2), .HEX3(HEX3), .HEX4(HEX4), .HEX5(HEX5), .LEDR(LEDR), .LEDRs(LEDRs) );
  
  initial begin
		#50 clk = 0; #50 clk = 1;
		SW[9:4] = 6'b000011; // Sets divideby to 3
		SW[3] = 1'b0; //Not needed but defined anyways
		SW[2] = 1'b0; SW[1] = 1; SW[0] = 1; //Free-run, Up-down, and enable set to 1

		KEY0 = 1'b1; //allow the counting to begin
		#50 clk = 0; #50 clk = 1;
		repeat (2) begin
			$display("~Reset = %b, divideby = %b, display = %b. ", KEY0, SW[9:4], display);
			#50 clk = 0; #50 clk = 1;
		end

		
		$display(" ");
		SW[0] = 0; // Enable set off, so should keep same value and therefore same display value
		#50 clk = 0; #50 clk = 1; 
		repeat (7) begin
			$display("~Reset = %b, divideby = %b, display = %b, HEX0 = %b ", KEY0, SW[9:4], display, HEX0);
			#50 clk = 0; #50 clk = 1; 
		end
		
		KEY0 = 1'b0; SW[0] = 1;// Reseting
		#50 clk = 0; #50 clk = 1; #50 clk = 0; #50 clk = 1; 
		$display(" ");
		$display("~Reset = %b, divideby = %b, display = %b, HEX0 = %b ", KEY0, SW[9:4], display, HEX0);
		
		#50 clk = 0; #50 clk = 1; 
		SW[9:4] = 6'b000000; KEY0 = 1'b1; // Setting divide by to zero to show LEDRs
		#50 clk = 0; #50 clk = 1; #50 clk = 0; #50 clk = 1; 
		$display(" ");
		$display("divideby = %b, LEDR = %b. ", SW[9:4], LEDR);
		
		#50 clk = 0; #50 clk = 1;
		SW[9:4] = 6'b000010;
		#50 clk = 0; #50 clk = 1; #50 clk = 0; #50 clk = 1; #50 clk = 0; #50 clk = 1; #50 clk = 0; #50 clk = 1; #50 clk = 0; #50 clk = 1; 
		SW[1] = 1'b0; // For subracting insead of adding
		repeat(6) begin
		$display(" ");
		$display("divideby = %b, display = %b, HEX0 = %b. ", SW[9:4], display, HEX0);
		#50 clk = 0; #50 clk = 1; 
		end
		
		SW[1] = 1'b1; SW[2] = 1'b0;
		repeat(167772510) begin
		#50 clk = 0; #50 clk = 1; 
		end
		
		repeat(6) begin
		$display(" ");
		$display("display = %b", display);
		#50 clk = 0; #50 clk = 1; 
		end
		
		
	end

endmodule