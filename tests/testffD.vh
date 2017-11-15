
//Testbench Flip-Flop D
`include "../ffD.vh"

//Test ADD
module testffD();

    //Initialize Connections
    logic D;
    logic clk;
    logic Rst;
    wire Q;

    initial
        begin
        D = 0;
        clk = 0;
        Rst = 0;
    end
    //Connect to FF module
    ffD fd(.D(D),.clk(clk),.Q(Q),.Rst(Rst));

    initial
        begin
        //Print table headers 
        $display("\nTesting D FF logic\n\n");
        $display("\t\ttime\tclk\tRst\tD\tQ");

        //Start monitor
        $monitor("%d\t%b\t%b\t%b\t%b",$time, clk, Rst, D, Q);
        #5 D = 1;
        #3 D = 0;
        #2 D = 1;
        #5 Rst = 1;
        #5 Rst = 0;
        #3 D = 1;
        #5 D = 0;
    end

    always
        #2 clk = ~clk;

    initial
        #30 $finish;
    
endmodule