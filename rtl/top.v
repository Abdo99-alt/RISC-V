module top (
    clk, reset//, Instr, PC
);
    input clk, reset;
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //input [31:0] Instr;
    //output [31:0] PC;
    wire [31:0] Instr, PC;
    wire [31:0] ALUResult, RD, WD;
    wire RegWrite, Zero, MemWrite, ResultSrc, ALUSrc, PCSrc, Jump;
    wire [1:0] ImmSrc, ALUCtrl;
    reg [8*4 : 1] op_literal;
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    datapath datapath (clk, reset, RegWrite, ALUSrc, PCSrc, ResultSrc, Jump, Instr, ALUCtrl, ImmSrc, RD, PC, ALUResult, WD, Zero);
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ctrl_unit ctrl_unit (Instr[6:0], Instr[14:12], Instr[30], Zero, ImmSrc, ALUCtrl, RegWrite, ALUSrc, MemWrite, ResultSrc, PCSrc, Jump);
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    instr_mem instr_mem (PC, Instr);
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    data_mem data_mem (clk, MemWrite, WD, ALUResult, RD);
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
endmodule