`include "uP.vh"

module testbench();
  logic clk = 0, reset;
  logic [3:0] PUSHBUTTONS;
  wire PHASE, C_FLAG, Z_FLAG;
  wire [3:0] INSTR, OPERAND, DATA_BUS, FF_OUT, ACCU, instr;
  wire  [7:0] PROGRAM_BYTE;
  wire  [11:0] PC, ADDRESS_RAM;

  uP dut(.clk(clk), .reset(reset), .PHASE(PHASE), .C_FLAG(C_FLAG), .Z_FLAG(Z_FLAG), .INSTR(INSTR), .OPERAND(OPERAND),
        .DATA_BUS(DATA_BUS), .FF_OUT(FF_OUT), .ACCU(ACCU), .PROGRAM_BYTE(PROGRAM_BYTE), .PC(PC), .ADDRESS_RAM(ADDRESS_RAM), .instr(instr));

  initial begin
    reset = 1;
    #1 reset = 0;
     $display("\t\ttime\tclk\treset\tphase:\tPC:\tinstr\tProgramByte:\tInstr:\tOprnd:\tRAM Addr:\tData Bus:\tAccu:\tC:\tZ:\tOut:\tIn:\t");
    $monitor("%d\t%b\t%b\t%b\t%d\t%b\t%b\t%b\t%b\t%b\t%b\t\t%b\t%b\t%b\t%b\t%b",$time, clk, reset, PHASE, PC, instr, PROGRAM_BYTE, INSTR, OPERAND, ADDRESS_RAM, DATA_BUS, ACCU, C_FLAG, Z_FLAG, FF_OUT, PUSHBUTTONS);
  end

  initial
    #300 $finish;

  always
    #5 clk = ~clk;
endmodule