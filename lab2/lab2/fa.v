//=======================================================
//  This code is generated by Terasic System Builder
//=======================================================

module fa(


   //////////// fa //////////
	input 		     a,
	input				  b,
	input				  ci,
	
	output			  s,
	output			  co
	
	
);



//=======================================================
//  REG/WIRE declarations
//=======================================================
assign s = a ^ b ^ ci;
assign co = (a&b) | (a&ci) | (b&ci);



//=======================================================
//  Structural coding
//=======================================================




endmodule
