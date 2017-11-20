//                ---      uROM     ---
// INPUTS: 7 bits - 4 del fetch, 2 del flag y 1 del phase
// OUPUTS: 16 bits - csRAM, weRAM, OEALU, OEIN, OEOPRND, LOADOUT, S0-S3, M_ALU, CARRYIN, LOADFLAG, LOADA, LOADPC, INCPC
// Toma los inputs y actua como controlador, afectando a la ALU, RAM, Registro A, PC, los dos OUTS  ,

`define J 'b0100000001000 //JUMP
`define JN 'b1000000001000 //JUMP NOT (dont jump)
`define CMPI 'b0001001000010
`define CMPM 'b1001001100000
`define LIT 'b0011010000010
`define IN 'b0011010000100
`define LD 'b1011010100000
`define ST 'b1000000111000
`define ADDI 'b0011011000010
`define ADDM 'b1011011100000
`define OUT 'b0000000001001
`define NORI 'b0011100000010
`define NORM 'b1011100100000


module decode(
    //------- INPUTS ----------//
    input [3:0] i         ,
    input C, Z            , 
    input phase           ,
    //------- OUTPUTS ---------//
    output logic [12:0] out_data
    );
    
    //------- CODE ------------//
    
    always @(*)
    if (phase) begin
        case (i)
            0 : out_data = (C == 'b1) ? `J : `JN; //JC
            1 : out_data = (C == 'b1) ? `JN : `J; //JNC
            2 : out_data = `CMPI;
            3 : out_data = `CMPM; 
            4 : out_data = `LIT;
            5 : out_data = `IN;
            6 : out_data = `LD; 
            7 : out_data = `ST; 
            8 : out_data = (Z == 'b1) ? `J : `JN; // JZ
            9 : out_data = (Z == 'b1) ? `JN : `J; // JNZ
            10: out_data = `ADDI;
            11: out_data = `ADDM;
            12: out_data = `J; // JMP 
            13: out_data = `OUT;
            14: out_data = `NORI;
            15: out_data = `NORM;
            default : out_data = 'bxxxxxxxxxxxxx;
        endcase
    end                 //termina el if phase
    else begin
        out_data = `JN;
    end                 //termina el else
endmodule