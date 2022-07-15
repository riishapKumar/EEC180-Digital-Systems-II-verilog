module tb_counter1;

reg reset;
reg enable;
reg [5:0] divideby;
wire go;
reg clk;
wire [5:0] countTB;

counter1 UUT (.reset(reset), .enable(enable), .divideby(divideby), .go(go), .clk(clk), .countTB(countTB) );
  
  initial begin
		#50 clk = 0; #50 clk = 1;
		reset = 1'b0; // To initialize count1 and set it to 0
		enable = 1'b1; // Allows for us to test
		divideby = 6'b00101; //A random test case
		
		#50 clk = 0; #50 clk = 1;
		
		repeat (10) begin
			$display("Reset = %b, divideby = %b, count = %b. ", reset, divideby, countTB);
			#50 clk = 0; #50 clk = 1; #50 clk = 0; #50 clk = 1; 
		end
		
		$display(" ");
		enable = 0; // Enable set off, so should keep same value and therefore same display value
		#50 clk = 0; #50 clk = 1; 
		repeat (4) begin
			$display("Reset = %b, divideby = %b, count = %b. ", reset, divideby, countTB);
			#50 clk = 0; #50 clk = 1; #50 clk = 0; #50 clk = 1; 
		end
		
		
		$display(" ");
		enable = 1;
		#50 clk = 0; #50 clk = 1;
		repeat (3) begin
			$display("Reset = %b, divideby = %b, count = %b. ", reset, divideby, countTB);
			#50 clk = 0; #50 clk = 1; #50 clk = 0; #50 clk = 1; 
		end
		
		reset = 1'b1; // Testing reset
		#50 clk = 0; #50 clk = 1;
		repeat (3) begin
			$display("Reset = %b, divideby = %b, count = %b. ", reset, divideby, countTB);
			#50 clk = 0; #50 clk = 1; #50 clk = 0; #50 clk = 1; 
		end
		
		
		
	end

endmodule