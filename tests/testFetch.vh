
//Testbench Fetch
`include "../Fetch.vh"

module testffD();

    //Initialize Connections
    logic clk, Rst, enable;
    logic [7:0] D;
    wire [7:0] Q;

    initial
        begin
        D = 8'b0;
        clk = 0;
        Rst = 0;
        enable = 0;
    end
    //Connect to Fetch module
    Fetch f(.D(D),.clk(clk),.Q(Q),.reset(Rst), .enable(enable));

    initial
        begin
        //Print table headers 
        $display("\nTesting Fetch\n\n");
        $display("\t\ttime\tenable\tclk\tRst\tD\t\tQ");

        //Start monitor
        $monitor("%d\t%b\t%b\t%b\t%b\t%b",$time, enable, clk, Rst, D, Q);
        #2 D = 8'h82;
        #2 D = 8'hFF;
        #2 D = 8'h8A;
        #5 Rst = 1;
        #1 Rst = 0;
        #2 D = 8'b10000010;
        #2 D = 8'hFF;
        #2 D = 8'h8A;
        #2 enable = 1;
        #2 D = 8'h82;
        #2 D = 8'hFF;
        #2 D = 8'h8A;
    end

    always
        #2 clk = ~clk;

    initial
        #30 $finish;
    
endmodule