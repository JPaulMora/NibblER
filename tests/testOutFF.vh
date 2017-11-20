`include "../outFF.vh"
module testOutFF();
    // Definiendo funciones
    logic clk, reset, loadOut   ;   // inputs
    logic [3:0] data_bus        ;   // input del bus
    wire [3:0]  FF_OUT          ;   // output del OUT_FF
    // Crear coneccion
    out_FF ffs(.clk(clk), .reset(reset), .enable(loadOut), .D(data_bus), .Q(FF_OUT));
    
    initial
        #5 clk = ~clk;
    initial
        #200 $finish;
    initial begin          // iniciando valores
        data_bus = 'b0000  ;
        clk      = 'b0     ;
        loadOut  = 'b0     ;
    end

    //Empieza a Probar desde aqui
    initial begin
        $display("D\tQ");
        $monitor("%b\t%b", data_bus, FF_OUT);
        $display("enable = 0");
        #1 data_bus = 'b0001;
        #1 loadOut  = 'b1;
        #1 $display("enable = 1");
        #1 data_bus = 'b0001;
        #1 data_bus = 'b0010;
        #1 data_bus = 'b0011;
        
    end

endmodule