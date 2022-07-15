module tb_add3_error();
// constants                                           
// general purpose registers
reg [2:0] a;
reg [2:0] b;
reg cin;
// wires                                               
wire [3:0] sum;

wire sampler;                             

// assign statements (if any)                          
add3_error i1 (
// port map - connection between master ports and signals/registers   
	.a(a),
	.b(b),
	.cin(cin),
	.sum(sum)
);

add3_ref w1 (
// port map - connection between master ports and signals/registers   
	.a(a),
	.b(b),
	.cin(cin),
	.sum(sum)
);
// a[ 2 ]
initial
begin
	a[2] = 1'b1;
	a[2] = #160000 1'b1;
	a[2] = #160000 1'b0;
	a[2] = #80000 1'b1;
	a[2] = #40000 1'b0;
	a[2] = #40000 1'b1;
	a[2] = #160000 1'b0;
	a[2] = #160000 1'b1;
	a[2] = #160000 1'b0;
end 
// a[ 1 ]
initial
begin
	a[1] = 1'b1;
	a[1] = #120000 1'b0;
	a[1] = #40000 1'b0;
	a[1] = #80000 1'b1;
	a[1] = #80000 1'b0;
	a[1] = #120000 1'b1;
	a[1] = #40000 1'b0;
	a[1] = #80000 1'b1;
	# 80000;
	repeat(2)
	begin
		a[1] = 1'b0;
		a[1] = #80000 1'b1;
		# 80000;
	end
	a[1] = 1'b0;
end 
// a[ 0 ]
initial
begin
	a[0] = 1'b1;
	a[0] = #40000 1'b0;
	a[0] = #40000 1'b0;
	a[0] = #40000 1'b1;
	# 40000;
	repeat(2)
	begin
		a[0] = 1'b0;
		a[0] = #40000 1'b1;
		# 40000;
	end
	a[0] = 1'b0;
	a[0] = #40000 1'b1;
	a[0] = #120000 1'b0;
	a[0] = #40000 1'b1;
	# 40000;
	repeat(5)
	begin
		a[0] = 1'b0;
		a[0] = #40000 1'b1;
		# 40000;
	end
	a[0] = 1'b0;
end 
// b[ 2 ]
initial
begin
	b[2] = 1'b1;
	b[2] = #160000 1'b1;
	b[2] = #40000 1'b0;
	b[2] = #40000 1'b1;
	b[2] = #40000 1'b0;
	b[2] = #40000 1'b1;
	b[2] = #120000 1'b0;
	b[2] = #120000 1'b1;
	b[2] = #120000 1'b0;
	b[2] = #80000 1'b1;
	b[2] = #40000 1'b0;
end 
// b[ 1 ]
initial
begin
	b[1] = 1'b0;
	b[1] = #200000 1'b1;
	b[1] = #40000 1'b0;
	b[1] = #80000 1'b1;
	b[1] = #80000 1'b0;
	b[1] = #80000 1'b1;
	b[1] = #80000 1'b0;
	b[1] = #40000 1'b1;
	b[1] = #80000 1'b0;
	b[1] = #160000 1'b1;
	b[1] = #40000 1'b0;
end 
// b[ 0 ]
initial
begin
	b[0] = 1'b0;
	b[0] = #80000 1'b1;
	b[0] = #80000 1'b1;
	b[0] = #40000 1'b0;
	b[0] = #40000 1'b1;
	b[0] = #40000 1'b0;
	b[0] = #40000 1'b1;
	b[0] = #120000 1'b0;
	b[0] = #120000 1'b1;
	b[0] = #120000 1'b0;
	b[0] = #40000 1'b1;
	b[0] = #80000 1'b0;
	b[0] = #40000 1'b1;
	b[0] = #40000 1'b0;
	b[0] = #80000 1'b1;
end 

// cin
initial
begin
	cin = 1'b0;
end 

/*initial
 begin
		 $monitor("t=%3d a=%d,b=%d,cin=%d,sum=%d pass\n",$time,a,b,cin,sum, );
		 if(A==7 & B== 4 | A==4 & B==7)
			$monitor("t=%3d a=%d,b=%d,cin=%d,sum=%d \n fail",$time,a,b,cin,sum, );	
		 end


endmodule */

	always@(*)
		begin
			if(a==7 & b== 4 | a==4 & b==7)
				$monitor("t=%3d a=%d,b=%d,cin=%d,sum=%d \n fail",$time,a,b,cin,sum, );
			else
				$monitor("t=%3d a=%d,b=%d,cin=%d,sum=%d pass\n",$time,a,b,cin,sum, );
		end
		
endmodule

