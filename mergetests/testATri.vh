`include "../busDriver.vh"
`include "../ALU.vh"

module testAconBus();
logic clk, Rst, oeALU;
wire carry, zero;
wire [3:0] data_bus, aluOut;
logic [2:0] aluopcode;
logic [3:0] A, from_fetch;

busDriver aluBuffer(.enable(oeALU), .A(from_fetch), .Y(data_bus));
ALU alu(.opcode(aluopcode), .A(A), .B(data_bus), .Out(aluOut), .carry(C), .zero(Z));

initial begin
    oeALU = 0;
    A = 'b0001;
    from_fetch = 'b0101;
    aluopcode = 'b011;
    
end

initial begin
$display("oeALU\tfrom_fetch\tdata_bus\taluop\tA\taluOut\tC\tZ");
$monitor("%b\t%b\t\t%b\t\t%b\t%b\t%b\t%b\t%b",oeALU,  from_fetch, data_bus, aluopcode, A, aluOut, C, Z);
#5 Rst = 1;
#5 Rst = 0;
#5 oeALU = 1;
#5  from_fetch = 'b1111;
end

endmodule