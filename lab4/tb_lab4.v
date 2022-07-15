module tb_lab4();
    reg clock;
    reg initialize;
    reg SW0, SW1, SW2, SW3, SW4, SW5, SW6, SW7, SW8, SW9;
    wire LED0, LED1, LED2, LED3, LED4, LED5, LED6, LED7, LED8, LED9;
    
    shift_register MY_REG (clock,initialize,
    SW0, SW1, SW2, SW3, SW4, SW5, SW6, SW7, SW8, SW9,
    LED0, LED1, LED2, LED3, LED4, LED5, LED6, LED7, LED8, LED9);
    
    initial begin
        clock = 1'b0;
        forever #5 clock = ~clock;
    end
    
    initial begin
        initialize = 1'b1;
        {SW9,SW8,SW7,SW6,SW5,SW4,SW3,SW2,SW1,SW0} = 10'b00_0000_0000;
        repeat(2)@(posedge clock);
        initialize = 1'b0;
        SW9 = 1'b1;
        repeat(15)@(posedge clock);
		  
		  initialize = 1'b1;
        {SW9,SW8,SW7,SW6,SW5,SW4,SW3,SW2,SW1,SW0} = 10'b11_1111_1111;
        repeat(2)@(posedge clock);
        initialize = 1'b0;
        SW9 = 1'b0;
        repeat(15)@(posedge clock);
		  
        initialize = 1'b1;
        {SW9,SW8,SW7,SW6,SW5,SW4,SW3,SW2,SW1,SW0} = 10'b10_1010_1010;
        repeat(2)@(posedge clock);
        initialize = 1'b0;
        SW9 = 1'b1;
        repeat(15)@(posedge clock);
        SW9 = 1'b0;
        repeat(10)@(posedge clock);
        $finish;
    end
endmodule