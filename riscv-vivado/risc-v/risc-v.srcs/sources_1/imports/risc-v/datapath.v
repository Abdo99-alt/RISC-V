module datapath (
    clk, reset, RegWrite, ALUSrc, PCSrc, ResultSrc, Jump, 
    Instr, ALUCtrl, ImmSrc, RD, PC, ALUResult, RD2, Zero  
);
    input clk, reset, RegWrite, ALUSrc, PCSrc, ResultSrc, Jump;
    input [31:0] Instr;
    input [1:0] ALUCtrl, ImmSrc;
    input [31:0] RD;
    output wire [31:0] PC;
    output wire [31:0] ALUResult;
    output wire [31:0] RD2;
    output wire Zero;
    /////////////////////////////////////////////
    wire [31:0] RD1, WD3, PCTarget, PCPlus4, PCNext, ImmExt, TmpResult, TmpPC;
    wire [31:0] SrcB;
    //Instantiate building blocks 
    add_by_4 add_by_4 (.PC(PC), .PCPlus4(PCPlus4));
    ///////////////////////////////////////////////////////////////////////////
    add_to_ImmExt add_to_ImmExt (PC, ImmExt, TmpPC);
    ///////////////////////////////////////////////////////////////////////////
    PC pc (.clk(clk), .reset(reset), .PC(PC), .PCNext(PCNext));
    ///////////////////////////////////////////////////////////////////////////
    reg_file reg_file (.A1(Instr[19:15]), .A2(Instr[24:20]), .A3(Instr[11:7]),
                        .WE3(RegWrite), .RD1(RD1), .RD2(RD2), .WD3(WD3), .clk(clk));
    ///////////////////////////////////////////////////////////////////////////
    imm_ext imm_ext (Instr, ImmSrc, ImmExt);
    ///////////////////////////////////////////////////////////////////////////
    mux_2 i1 (RD2, ImmExt, ALUSrc, SrcB);
    ///////////////////////////////////////////////////////////////////////////
    alu alu (.A(RD1), .B(SrcB), .ALUCtrl(ALUCtrl), .ALUResult(ALUResult), .Zero(Zero));
    ///////////////////////////////////////////////////////////////////////////
    mux_2 i2 (ALUResult, RD, ResultSrc, TmpResult);
    ///////////////////////////////////////////////////////////////////////////
    mux_2 i3 (TmpResult, PCPlus4, Jump, WD3);
    ///////////////////////////////////////////////////////////////////////////
    mux_2 i4 (TmpPC, ALUResult, (Jump & ALUSrc), PCTarget);
    ///////////////////////////////////////////////////////////////////////////
    mux_2 i5 (PCPlus4, PCTarget, PCSrc, PCNext);
    ///////////////////////////////////////////////////////////////////////////
    
endmodule