
//Testbench Flip-Flop D
`include "../PC.vh"

//Test ADD
module testPC();

    //Initialize Connections
    logic [11:0] newaddr;
    logic clk;
    logic enable;
    logic Rst;
    wire [11:0] PC;

    initial
        begin
        newaddr = 12'b000000000000;
        clk = 0;
        enable = 0;
        Rst = 0;
    end
    //Connect to FF module
    PC pc(.newaddr(newaddr), .clk(clk), .enable(enable), .Rst(Rst), .addr(PC));

    initial
        begin
        //Print table headers 
        $display("\nTesting PC functionality\n\n");
        $display("\t\ttime\tclk\tRst\tenable\tnewaddr\t\tPC");

        //Start monitor
        $monitor("%d\t%b\t%b\t%b\t%b %b %b\t%b %b %b",$time, clk, Rst, enable, newaddr[11:8],newaddr[7:4],newaddr[3:0], PC[11:8],PC[7:4],PC[3:0]);
        #2 Rst = 1;
        #3 Rst = 0;
        #4 enable = 1;
           newaddr = 12'b001101011001;
        #4 enable = 0;
           newaddr = 12'b000000000000; 
        #15 Rst = 1;
        #1 Rst = 0;

    end

    always
        #2 clk = ~clk;

    initial
        #30 $finish;
    
endmodule