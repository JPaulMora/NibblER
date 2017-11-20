`include "../outFF.vh"
module testOutFF();
    // Definiendo funciones
    logic clk, reset, loadOut   ;   // inputs
    logic [3:0] data_bus        ;   // input del bus
    wire [3:0]  FF_OUT          ;   // output del OUT_FF
    // Crear coneccion
    out_FF ffs(.clk(clk), .reset(reset), .enable(loadOut), .D(data_bus), .Q(FF_OUT));

    always
        #5 clk = ~clk;
    initial
        #35 $finish;
    initial begin          // iniciando valores
        data_bus = 'b0001  ;
        clk      = 0       ;
        loadOut  = 0       ;
        reset = 0;
    end

    //Empieza a Probar desde aqui
    initial begin
        $display("clk\treset\tloadOut\tD\tQ");
        $monitor("%b\t%b\t%b\t%b\t%b", clk, reset, loadOut, data_bus, FF_OUT);
        
        #10 reset = 1;
        #10 reset = 0;
        #5 loadOut = 1;
        #5 data_bus = 4'b1111;
        
    end

endmodule