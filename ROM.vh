module rom (
input  wire [11:0] address , // Address input
output wire [7:0] data      // Data output
);
  
reg [7:0]    mem [0:30] ;

assign data = mem[address];

initial begin
  $readmemb("./ROM.list",mem);
end

endmodule