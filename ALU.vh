
`define OUT 3'b000
`define CMP 3'b001
`define LD 3'b010
`define ADD 3'b011
`define NOR 3'b100

module ALU(
  input [2:0] opcode,
  input [3:0] A, B,
  output logic [3:0] Out,
  output logic carry, zero
);

always @(*)
begin
  if (opcode == `OUT)
  begin
    carry = 0;
    zero = 0;
    Out = A;
  end
  else if (opcode == `CMP)
  begin
    {carry, Out} = A - B;
    zero = (Out == 0);
  end
  else if (opcode == `ADD)
  begin
    {carry, Out} = A + B;
    zero = (Out == 0);
  end
end
endmodule