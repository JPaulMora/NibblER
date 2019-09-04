`include "UPFinal.vh"

module testbench();
  logic clk = 1, reset;
  logic [3:0] PUSHBUTTONS;
  wire  PHASE, C_FLAG, Z_FLAG;
  wire [3:0] INSTR, OPERAND, DATA_BUS, FF_OUT, ACCU;
  wire [7:0] PROGRAM_BYTE;
  wire [11:0] PC, ADDRESS_RAM;
  real points = 0;

  uP dut(.clk(clk), .reset(reset), .PUSHBUTTONS(PUSHBUTTONS), .PHASE(PHASE), .C_FLAG(C_FLAG), .Z_FLAG(Z_FLAG), .INSTR(INSTR), .OPERAND(OPERAND),
        .DATA_BUS(DATA_BUS), .FF_OUT(FF_OUT), .ACCU(ACCU), .PROGRAM_BYTE(PROGRAM_BYTE), .PC(PC), .ADDRESS_RAM(ADDRESS_RAM));

  /*always @ (PHASE) begin
    //$display($time);
    case ($time)
      20: begin
        if (ACCU === 4'b1001) begin
          points = points + 5; $display("LIT funciona bien. Nota: %d", points); end
        else
          $display("LIT NO funciona bien. Nota: %d", points);
      end
      40: begin
        if (ACCU === PUSHBUTTONS) begin
          points = points + 5; $display(" IN funciona bien. Nota: %d", points); end
        else
          $display(" IN NO funciona bien. Nota: %d", points);
      end
      60: begin
        if (FF_OUT === ACCU) begin
          points = points + 5; $display("OUT funciona bien. Nota: %d", points); end
        else begin
          $display("OUT NO funciona bien. Nota: %d", points); end
      end
      80: begin
        if (ACCU === 4'b1111) begin
          points = points + 2.5; $display("ADDI funciona bien. (sin overflow) (1/2). Nota: %f", points); end
        else begin
          $display("ADDI NO funciona bien. (sin overflow) (1/2)"); end
      end
      100: begin
        if (C_FLAG === 1'b1) begin
          points = points + 2.5; $display("ADDI funciona bien. (con overflow) (2/2) Nota: %f", points); end
        else
          $display("ADDI NO funciona bien. (con overflow) (2/2)");
      end
      140: begin
        if (ACCU === (~(4'b0000 | 4'b0101))) begin
          points = points + 2.5; $display("NORI funciona bien. (sin banderas) (1/2). Nota: %f", points); end
        else
          $display("NORI NO funciona bien. (sin banderas) (2/2)");
      end
      160: begin
        if (Z_FLAG) begin
          points = points + 2.5; $display("NORI funciona bien. (con bandera Z) (2/2). Nota: %f", points); end
        else
          $display("NORI NO funciona bien. (con bandera Z) (2/2)");
      end
      200: begin
        if (Z_FLAG) begin
          points = points + 5; $display("CMPI funciona bien. (con bandera Z). Nota: %f", points); end
        else
          $display("CMPI NO funciona bien. (con bandera Z)");
      end
      220: begin
        if (PC === 13) begin
          points = points + 3; $display("JMP funciona bien. Nota: %f", points); end
        else
          $display("JMP NO funciona bien.");
      end
      280: begin
        if (PC === 19) begin
          points = points + 3; $display("JC funciona bien (con bandera C). Nota: %f", points); end
        else
          $display("JC NO funciona bien (con bandera C).");
      end
      340: begin
        if (PC === 25) begin
          points = points + 3; $display("JNC funciona bien (sin bandera C). Nota: %f", points); end
        else
          $display("JNC NO funciona bien (sin bandera C).");
      end
      400: begin
        if (PC === 32) begin
          points = points + 3; $display("JZ funciona bien (con bandera Z = 1). Nota: %f", points); end
        else
          $display("JZ NO funciona bien (con bandera Z = 1).");
      end
      440: begin
        if (PC === 10) begin
          points = points + 3; $display("JNZ funciona bien (con bandera Z = 0). Nota: %f", points); end
        else
          $display("JNZ NO funciona bien (con bandera Z = 0).");
      end
  endcase
  end*/

  initial begin
    reset = 0;
    #1 reset = 1;
    #1 reset = 0;
    PUSHBUTTONS = 4'b0110;
    $display("\t\ttime:\tphase:\tPC:\tProgramByte:\tInstr:\tOprnd:\tRAM Addr:\tData Bus:\tAccu:\tC:\tZ:\tOut:\tIn:\t");
    $monitor("%d\t%b\t%d\t%b\t%b\t%b\t%b\t%b\t\t%b\t%b\t%b\t%b\t%b", $time, PHASE, PC, PROGRAM_BYTE, INSTR, OPERAND, ADDRESS_RAM, DATA_BUS, ACCU, C_FLAG, Z_FLAG, FF_OUT, PUSHBUTTONS);

  end

  initial
    #400 $finish;

  always
    #5 clk = ~clk;
endmodule