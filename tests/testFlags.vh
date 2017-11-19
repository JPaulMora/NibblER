
//Testbench Flags
`include "../Flags.vh"

module testffD();

    //Initialize Connections
    logic clk, reset, enable, zero, carry;
    wire zero_out, carry_out;

    initial
        begin
        enable = 0;
        clk = 0;
        reset = 0;
        zero= 1;
        carry = 0;
    end
    //Connect to Flags module
    Flags fl(.clk(clk), .reset(reset), .enable(enable), .zero(zero), .carry(carry), .zero_out(zero_out), .carry_out(carry_out));

    initial
        begin
        //Print table headers 
        $display("\nTesting Flags logic\n\n");
        $display("\t\ttime\tclk\treset\tenable\tzero\tcarry\tzero_out\tcarry_out");

        //Start monitor
        $monitor("%d\t%b\t%b\t%b\t%b\t%b\t%b\t\t%b",$time, clk, reset, enable, zero, carry, zero_out, carry_out);
        #4 reset = 1;
        #2 reset = 0;
        #2 enable = 1;
        #2 carry = 1;
        #3 carry = 0;
        #3 zero = 0;
    end

    always
        #2 clk = ~clk;

    initial
        #25 $finish;
    
endmodule