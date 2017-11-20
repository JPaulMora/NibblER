`include "testingEverything.vh"
module testingAll();
    logic clk, reset        ;   // inputs
    logic [3:0] PUSHBUTTONS ;   //botones
    //outputs
    wire PHASE, C_FLAG, Z_FLAG; 
    wire [3:0] INSTR, OPERAND, DATA_BUS, FF_OUT, ACCU;
    wire [7:0] PROGRAM_BYTE;
    wire [11:0] PC, ADDRESS_RAM ;
    uP newUP(clk, reset, PUSHBUTTONS, PHASE, C_FLAG, Z_FLAG, INSTR, OPERAND, DATA_BUS, FF_OUT, ACCU, PROGRAM_BYTE, PC, ADDRESS_RAM);
    initial
        #105 $finish;
    initial begin
        clk          =    0   ;
        reset        =    1   ;
    end
    always
        #5 clk = ~clk;
    initial begin
        $display("phase\tPC\tPrgBy\tInstr\tOPR\tRAMA\tDaBus\tAccu\tC\tZ\tOUT\tIN");
        $monitor("%b    %d     %b   %b\t%b\t%h\t%b\t%b\t%b\t%b\t%b\t%b", PHASE, PC, PROGRAM_BYTE, INSTR, OPERAND, ADDRESS_RAM, DATA_BUS, ACCU, C_FLAG,  Z_FLAG, FF_OUT, PUSHBUTTONS); 
        #10 reset = 0;
        
    end
endmodule