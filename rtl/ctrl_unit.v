module ctrl_unit (
    opcode, funct3, funct7_5, Zero, ImmSrc, ALUCtrl, 
    RegWrite, ALUSrc, MemWrite, ResultSrc, PCSrc, Jump
);
    input [6:0] opcode;
    input [2:0] funct3;
    input funct7_5, Zero;
    output wire [1:0] ImmSrc, ALUCtrl;
    output wire RegWrite, ALUSrc, MemWrite, ResultSrc, PCSrc, Jump;
    //////////////////////////////////////////////////////////
    wire [1:0] ALUOp;
    wire Branch;
    //////////////////////////////////////////////////////////
    assign PCSrc = (Zero & Branch & ~funct3[0]) | (~Zero & Branch & funct3[0]) | Jump;
    //Instantiate building blocks
    main_decoder main_decoder (opcode, RegWrite, ImmSrc, ALUSrc, Branch, MemWrite, ResultSrc, ALUOp, Jump);
    alu_decoder alu_decoder (ALUOp, funct3, opcode[5], funct7_5, ALUCtrl);
endmodule