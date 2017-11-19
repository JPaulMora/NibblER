
//Testbench PC
`include "../PC.vh"

module testPC();

    //Initialize Connections
    logic [11:0] newaddr;
    logic clk, enable, Rst, inc;
    wire [11:0] PC;
    wire phase;

    initial
        begin
        newaddr = 12'b000000000000;
        clk = 0;
        enable = 0;
        Rst = 0;
        inc = 0;
    end
    //Connect to PC module
    PC pc(.newaddr(newaddr), .loadPC(enable), .incPC(inc), .clk(clk), .Rst(Rst), .addr(PC));

    initial
        begin
        //Print table headers 
        $display("\nTesting PC functionality\n\n");
        $display("\t\ttime\tclk\tincPC\tRst\tloadPC\tnewaddr\t\tPC");

        //Start monitor
        $monitor("%d\t%b\t%b\t%b\t%b\t%d %d %d\t%d %d %d",$time, clk, inc, Rst, enable, newaddr[11:8],newaddr[7:4],newaddr[3:0], PC[11:8],PC[7:4],PC[3:0]);
        inc = 1;
        #4 Rst = 1;
        #4 Rst = 0;
        #5 enable = 1;
           newaddr = 12'h359;
        #4 enable = 0;
           newaddr = 12'h000; 
        #6 Rst = 1;
        #2 Rst = 0;
        #16 inc = 0;
        #6 inc = 1;

    end

    always
        #2 clk = ~clk;

    initial
        #60 $finish;
    
endmodule