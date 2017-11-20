`include "../PC.vh"
`include "../ROM.vh"

module test();

//PC
logic [11:0] newaddr = 'hD;
logic loadPC, incPC, clk, Rst;
wire [11:0] address;

// ROM
wire [7:0] data;

initial begin
  loadPC = 0;
  incPC = 0;
  clk = 0;
  Rst = 1;
end

PC pc(.newaddr(newaddr), .loadPC(loadPC), .incPC(incPC), .clk(clk), .Rst(Rst), .addr(address));
rom r(.address(address), .data(data));

initial begin
  $display("Test PC + ROM");
  $display("clk\tRst\tincPC\tloadPC\taddress\t\tdata");
  $monitor("%b\t%b\t%b\t%b\t%d\t%b",clk, Rst, incPC, loadPC, address, data);
  #1 Rst = 0;
  #4 incPC = 1;

end

always
  #2 clk = ~clk;

initial
  #58 $finish;
endmodule

