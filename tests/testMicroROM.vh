`include "../microROM.vh"
module testMicroROM();
    wire [2:0] S;
    wire incPC, loadPC, loadA, loadFlags, csRAM, weRAM, oeALU, oeIN, oeOperand, loadOut;
    logic Z_alu, Z_FF, C_out_FF, phase;
    logic [3:0] instr;

    decode dc(.phase(phase), .C(C_out_FF), .Z(Z_FF), .i(instr), .out_data({incPC, loadPC, loadA, loadFlags, S,csRAM, weRAM, oeALU, oeIN, oeOperand, loadOut}));
    
    initial 
  	#100 $finish;

    //no dejamos altas impedancias
    initial
    begin
        C_out_FF = 'b0;
        Z_FF = 'b0;
        phase = 'b0;
        instr = 'b0000;
    end
    initial begin
        #1 $display("OUT_DATA");
        #1 $monitor("%b%b%b%b%b%b%b%b%b%b%b", incPC, loadPC, loadA, loadFlags, S,csRAM, weRAM, oeALU, oeIN, oeOperand, loadOut);

        //RESULTS
        $display("phase = 0")               ;
        #1 phase = 1'b0                     ;
        #1 C_out_FF = 'b0; instr = 'b0000   ;

        #1 $display("phase = 1")            ;
        #1 phase = 'b1                      ;

        #1 $display("instr = 0, depende de c");
        #1 C_out_FF = 'b1; instr = 'b0000     ; 
        #1 C_out_FF = 'b0; instr = 'b0000     ; 
        
        #1 $display("instr = 1, depende de c");
        #1 C_out_FF = 'b0; instr = 'b0001     ; 
        #1 C_out_FF = 'b1; instr = 'b0001     ;

        #1 $display("instr = 2")              ;
        #1 instr = 'b0010                     ;
        #1 $display("instr = 3")              ;
        #1 instr = 'b0011                     ;
        #1 $display("instr = 4")              ;
        #1 instr = 'b0100                     ;
        #1 $display("instr = 5")              ;
        #1 instr = 'b0101                     ;
        #1 $display("instr = 6")              ;
        #1 instr = 'b0110                     ;
        #1 $display("instr = 7")              ;
        #1 instr = 'b0111                     ;

        #1 $display("instr = 8, depende de z");
        #1 Z_FF = 'b0; instr = 'b1000         ; 
        #1 Z_FF = 'b1; instr = 'b1000         ;
        
        #1 $display("instr = 9, depende de z");
        #1 Z_FF = 'b1; instr = 'b1001         ; 
        #1 Z_FF = 'b0; instr = 'b1001         ;

        #1 $display("instr = 10")             ;
        #1 instr = 'b1010                     ;
        #1 $display("instr = 11")             ;
        #1 instr = 'b1011                     ; 
        #1 $display("instr = 12")             ;
        #1 instr = 'b1100                     ;
        #1 $display("instr = 13")             ;
        #1 instr = 'b1101                     ;
        #1 $display("instr = 14")             ;
        #1 instr = 'b1110                     ;
        #1 $display("instr = 15")             ;
        #1 instr = 'b1111                     ;       

  end
endmodule