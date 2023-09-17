module ALU_TOP #(
    parameter A_width_TOP = 16,
    parameter B_width_TOP = 16,
    parameter ARITH_OUT_width_TOP = 16,
    parameter LOGIC_OUT_width_TOP = 16,
    parameter CMP_OUT_width_TOP = 16,
    parameter SHIFT_OUT_width_TOP = 16
) (
    input wire CLK_TOP,
    input wire RST_TOP,
    input wire [A_width_TOP-1 : 0] A_IN_TOP,
    input wire [B_width_TOP-1 : 0] B_IN_TOP,
    input wire [3:0] ALU_FUN_TOP,
    output wire ARITH_Flag_TOP,
    output wire LOGIC_Flag_TOP,
    output wire CMP_Flag_TOP,
    output wire SHIFT_Flag_TOP,
    output wire [ARITH_OUT_width_TOP-1 : 0] ARITH_OUT_TOP,
    output wire Carry_out_TOP,
    output wire [LOGIC_OUT_width_TOP-1 : 0] LOGIC_OUT_TOP,
    output wire [CMP_OUT_width_TOP-1 : 0] CMP_OUT_TOP,
    output wire [SHIFT_OUT_width_TOP-1 : 0] SHIFT_OUT_TOP
);

  wire ARITH_ENABLE_SIGNAL;
  wire LOGIC_ENABLE_SIGNAL;
  wire CMP_ENABLE_SIGNAL;
  wire SHIFT_ENABLE_SIGNAL;

  DECODER_UNIT D_unit (
      .ALU_FUN_DEC(ALU_FUN_TOP[3:2]),
      .CLK_DEC(CLK_TOP),
      .RST_DEC(RST_TOP),
      .ARITH_EN_DEC(ARITH_ENABLE_SIGNAL),
      .LOGIC_EN_DEC(LOGIC_ENABLE_SIGNAL),
      .CMP_EN_DEC(CMP_ENABLE_SIGNAL),
      .SHIFT_EN_DEC(SHIFT_ENABLE_SIGNAL)
  );
  ARITH_UNIT #(
      .A_width(A_width_TOP),
      .B_width(B_width_TOP),
      .ARITH_OUT_width(ARITH_OUT_width_TOP)
  ) A_unit (
      .A_IN_ARITH(A_IN_TOP),
      .B_IN_ARITH(B_IN_TOP),
      .CLK_ARITH(CLK_TOP),
      .RST_ARITH(RST_TOP),
      .ALU_FUN_ARITH(ALU_FUN_TOP[1:0]),
      .ARITH_EN(ARITH_ENABLE_SIGNAL),
      .ARITH_FLAG(ARITH_Flag_TOP),
      .Carry_out(Carry_out_TOP),
      .ARITH_OUT(ARITH_OUT_TOP)
  );
  LOGIC_UNIT #(
      .A_width(A_width_TOP),
      .B_width(B_width_TOP),
      .LOGIC_OUT_width(LOGIC_OUT_width_TOP)
  ) L_unit (
      .A_IN_LOGIC(A_IN_TOP),
      .B_IN_LOGIC(B_IN_TOP),
      .CLK_LOGIC(CLK_TOP),
      .RST_LOGIC(RST_TOP),
      .ALU_FUN_LOGIC(ALU_FUN_TOP[1:0]),
      .LOGIC_EN(LOGIC_ENABLE_SIGNAL),
      .LOGIC_FLAG(LOGIC_Flag_TOP),
      .LOGIC_OUT(LOGIC_OUT_TOP)
  );
  CMP_UNIT #(
      .A_width(A_width_TOP),
      .B_width(B_width_TOP),
      .CMP_OUT_width(CMP_OUT_width_TOP)
  ) C_unit (
      .A_IN_CMP(A_IN_TOP),
      .B_IN_CMP(B_IN_TOP),
      .CLK_CMP(CLK_TOP),
      .RST_CMP(RST_TOP),
      .ALU_FUN_CPM(ALU_FUN_TOP[1:0]),
      .CMP_EN(CMP_ENABLE_SIGNAL),
      .CMP_Flag(CMP_Flag_TOP),
      .CMP_OUT(CMP_OUT_TOP)
  );
  SHIFT_UNIT #(
      .A_width(A_width_TOP),
      .B_width(B_width_TOP),
      .SHIFT_OUT_width(SHIFT_OUT_width_TOP)
  ) S_unit (
      .A_IN_SHIFT(A_IN_TOP),
      .B_IN_SHIFT(B_IN_TOP),
      .CLK_SHIFT(CLK_TOP),
      .RST_SHIFT(RST_TOP),
      .ALU_FUN_SHIFT(ALU_FUN_TOP[1:0]),
      .Shift_EN(SHIFT_ENABLE_SIGNAL),
      .SHIFT_FLAG(SHIFT_Flag_TOP),
      .SHIFT_OUT(SHIFT_OUT_TOP)
  );

endmodule

