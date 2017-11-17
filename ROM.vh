module rom (
input  wire [7:0] address , // Address input
output wire [7:0] data      // Data output
);
  
reg [7:0]    mem [0:13] ;

assign data = mem[address];

initial begin
  $readmemb("/home/eclipse/uvg/ElectronicaDigital/NibblER/ROM.list",mem);
end

endmodule