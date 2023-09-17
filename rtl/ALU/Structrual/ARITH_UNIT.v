module ARITH_UNIT #(
    parameter A_width = 16,
    parameter B_width = 16,
    parameter ARITH_OUT_width = 16
) (
    input wire [A_width- 1:0] A_IN_ARITH,
    input wire [B_width- 1:0] B_IN_ARITH,
    input wire CLK_ARITH,
    input wire RST_ARITH,
    input wire [1:0] ALU_FUN_ARITH,
    input wire ARITH_EN,
    output reg ARITH_FLAG,
    output reg Carry_out,
    output reg [ARITH_OUT_width- 1:0] ARITH_OUT
);

  localparam Addition = 2'b00;
  localparam Subtraction = 2'b01;
  localparam Multiplication = 2'b10;
  localparam Division = 2'b11;

  always @(posedge CLK_ARITH or negedge RST_ARITH) begin
    if (!RST_ARITH) begin
      ARITH_OUT  <= 0;
      Carry_out  <= 0;
      ARITH_FLAG <= 0;
    end else if (ARITH_EN) begin
        ARITH_FLAG <= 1;
        case (ALU_FUN_ARITH)
          Addition: {Carry_out, ARITH_OUT} <= A_IN_ARITH + B_IN_ARITH;
          Subtraction: {Carry_out, ARITH_OUT} <= A_IN_ARITH - B_IN_ARITH;
          Multiplication: {Carry_out, ARITH_OUT} <= A_IN_ARITH * B_IN_ARITH;
          Division: {Carry_out, ARITH_OUT} <= A_IN_ARITH / B_IN_ARITH;
        endcase
      end else begin
        ARITH_OUT <= 0;
        ARITH_FLAG <= 0;
      end
    end

endmodule

