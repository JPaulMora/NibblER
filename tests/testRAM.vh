`include "../RAM.vh"
module testRAM();
logic csRAM, weRAM;
logic [11:00] address;
logic [3:0] data_going_in;
wire [3:0] data;

RAM ram(.csRAM(csRAM), .weRAM(weRAM), .address(address), .data(data));

initial
 # 200 $finish;

assign data = weRAM ? data_going_in : 4'bz;

initial
 begin
 $display ("address:\tdata:");
 $monitor("%h\t\t%b", address, data);
 csRAM = 1;
 weRAM = 0;
 $display ("reading...");
 #1 address = 12'h000;
 #1 address = 12'h001;
 #1 address = 12'h002;
 $display ("writing...");
 #1 weRAM = 1; address = 12'h000; data_going_in = 4'b0011;
 #1 address = 12'h001; data_going_in =  4'b1100;
 #1 address = 12'h002; data_going_in =  4'b0110;
 $display("reading...");
 #1 weRAM = 0; address = 12'h000;
 #1 address = 12'h001; 
 #1 address = 12'h002;
 end
 endmodule