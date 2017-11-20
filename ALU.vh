
`define OUT 3'b000 // ST / OUT
`define CMP 3'b001 // CMPI / CMPM
`define LD 3'b010  // LIT / IN / LD
`define ADD 3'b011 // ADDI ADDM
`define NOR 3'b100 // NORI NORM

module ALU(
  input [2:0] opcode,
  input logic [3:0] A, 
  input [3:0] B,
  output logic [3:0] Out,
  output logic carry, zero
);

always @(*)
begin
  if (opcode == `OUT)
  begin
    carry = 0;
    Out = A;
  end
  else if (opcode == `CMP)
  begin
    {carry, Out} = A - B;
  end
  else if (opcode == `LD)
  begin
    carry = 0;
    Out = B;
  end
  else if (opcode == `ADD)
  begin
    {carry, Out} = A + B;
  end
  else if (opcode == `NOR)
  begin
    {carry, Out} = A ~| B;
  end
  zero = (Out == 0);
end
endmodule