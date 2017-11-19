`include "../RAM.vh"
module testRAM();
logic weRAM, csRAM       ;        //weRam if we are writing or reading
logic [11:00] address;          // were the info is going to go
logic [3:0] data_going_in;      //input data to write
wire [3:0] data;                //output data from read

RAM ram(.we(weRAM), .cs(csRAM), .address(address), .data(data));

initial
 # 200 $finish;

assign data = weRAM ? data_going_in : 4'bz;

initial
 begin
 $display ("address:\tdata:");
 $monitor("%h\t\t%b", address, data);
 csRAM = 1;
 weRAM = 0;
 #1 $display ("reading...");
 #1 address = 12'h000;
 #1 address = 12'h001;
 #1 address = 12'h002;
 #1 $display ("writing...");
 #1 address = 12'h000; weRAM = 1;  data_going_in = 4'b0011;
 #1 address = 12'h001; data_going_in =  4'b1100;
 #1 address = 12'h002; data_going_in =  4'b0110;
 #1 $display("reading...");
 #1 weRAM = 0; address = 12'h000;
 #1 address = 12'h001; 
 #1 address = 12'h002;
 end
 endmodule