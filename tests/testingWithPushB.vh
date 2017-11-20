`include "testingEverything.vh"
module pressingPushButtons();
    logic clk, reset        ;   // inputs
    logic [3:0] PUSHBUTTONS ;   //botones
    //outputs
    wire PHASE, C_FLAG, Z_FLAG; 
    wire [3:0] INSTR, OPERAND, DATA_BUS, FF_OUT, ACCU;
    wire [7:0] PROGRAM_BYTE;
    wire [11:0] PC, ADDRESS_RAM ;
    uP newUP(clk, reset, PUSHBUTTONS, PHASE, C_FLAG, Z_FLAG, INSTR, OPERAND, DATA_BUS, FF_OUT, ACCU, PROGRAM_BYTE, PC, ADDRESS_RAM);
    initial
        #200 $finish;
    initial begin
        clk          =    0   ;
        PUSHBUTTONS  =    0   ;
        reset        =    0   ;
    end
    always
        #5 clk = ~clk;
    initial begin
        $display("clk\tPUSH\treset\tPHASE\tC_F\tZ_F\tINSTR\tOPR\tDAB\tFFO\tACU\tPROBY\tPC\tADRAM");
        $monitor("%b\t%b\t%b\t%b\t%b\t%b\t%b\t%b\t%b\t%b\t%b\t%h\t%h\t%h", clk, reset, PUSHBUTTONS,PHASE, C_FLAG, Z_FLAG, INSTR, OPERAND, DATA_BUS, FF_OUT, ACCU, PROGRAM_BYTE, PC, ADDRESS_RAM);
        #10 reset = 1;
        #10 reset = 0;
        #5  PUSHBUTTONS = 'b0000;
        #5  PUSHBUTTONS = 'b0001;
        #5  PUSHBUTTONS = 'b0010;
        #5  PUSHBUTTONS = 'b0011;
        #5  PUSHBUTTONS = 'b0100;
        #5  PUSHBUTTONS = 'b0101;
        #5  PUSHBUTTONS = 'b0110;
        #5  PUSHBUTTONS = 'b0111;
        
    end
endmodule