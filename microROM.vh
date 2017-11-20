//                ---      uROM     ---
// INPUTS: 7 bits - 4 del fetch, 2 del flag y 1 del phase
// OUPUTS: 16 bits - csRAM, weRAM, OEALU, OEIN, OEOPRND, LOADOUT, S0-S3, M_ALU, CARRYIN, LOADFLAG, LOADA, LOADPC, INCPC
// Toma los inputs y actua como controlador, afectando a la ALU, RAM, Registro A, PC, los dos OUTS  ,

module decode(
    C           ,
    Z           ,
    i           ,
    phase       ,
    out_data
    );

    //------- INPUTS ----------//
    input [3:0] i         ;
    input C, Z            ; 
    input phase           ;
    //------- OUTPUTS ---------//
    output reg [12:0] out_data;
    //------- INTERNAL VAR ----//
    
    //------- CODE ------------//
    
    always @ (phase or i or C or Z)
    begin 
        if (phase) begin
            case (i)
                0 : out_data = (C == 'b1) ? 'b0100000001000 : 'b1000000001000; //CJ
                1 : out_data = (C == 'b1) ? 'b1000000001000 : 'b0100000001000; //JNC
                2 : out_data = 'b0001001000010; // CMPI
                3 : out_data = 'b1001001100000; // CMPM
                4 : out_data = 'b00110100000010; // LIT
                5 : out_data = 'b0011010000100; // IN
                6 : out_data = 'b1011010100000; // LD
                7 : out_data = 'b1000000111000; // ST
                8 : out_data = (Z == 'b1) ? 'b0100000001000 : 'b1000000001000; // JZ
                9 : out_data = (Z == 'b1) ? 'b1000000001000 : 'b0100000001000; // JNZ
                10: out_data = 'b0011011000010; // ADDI
                11: out_data = 'b1011011100000; // ADDM
                12: out_data = 'b0100000001000; // JMP 
                13: out_data = 'b0000000001001; // OUT
                14: out_data = 'b0011100000010; // NORI
                15: out_data = 'b1011100100000; // NORM
                default : $display("Error in i");
            endcase
        end                 //termina el if phase
        else begin
            out_data = 'b1000001000;
        end                 //termina el else
    end //termina el always
endmodule