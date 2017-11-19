`include "../ROM.vh"
// Testbench code
module rom_tb;
 reg [11:0] address;
 wire [7:0] data;
 integer i;
 
 initial begin
   address = 0;
   #10 $monitor ("address = %h, data = %h", address, data);
   for (i = 0; i <14; i = i +1 )begin
     #5 address = i;
   end
 end
 
rom rom_test(address, data);

endmodule