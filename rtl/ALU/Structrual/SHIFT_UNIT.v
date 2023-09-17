module SHIFT_UNIT #(
    parameter A_width = 16,
    parameter B_width = 16,
    parameter SHIFT_OUT_width = 16
) (
    input wire [A_width- 1:0] A_IN_SHIFT,
    input wire [B_width- 1:0] B_IN_SHIFT,
    input wire CLK_SHIFT,
    input wire RST_SHIFT,
    input wire [1:0] ALU_FUN_SHIFT,
    input wire Shift_EN,
    output reg SHIFT_FLAG,
    output reg [SHIFT_OUT_width- 1:0] SHIFT_OUT
);

  localparam LeftA = 2'b00;
  localparam RightA = 2'b01;
  localparam LeftB = 2'b10;
  localparam RightB = 2'b11;


  always @(posedge CLK_SHIFT or negedge RST_SHIFT) begin
    if (!RST_SHIFT) begin
      SHIFT_OUT  <= 0;
      SHIFT_FLAG <= 0;
    end else begin
      if (Shift_EN) begin
        SHIFT_FLAG <= 1;
        case (ALU_FUN_SHIFT)
          LeftA:  SHIFT_OUT <= A_IN_SHIFT >> 1;
          RightA: SHIFT_OUT <= A_IN_SHIFT << 1;
          LeftA:  SHIFT_OUT <= B_IN_SHIFT >> 1;
          RightB: SHIFT_OUT <= B_IN_SHIFT << 1;
        endcase
      end else begin
        SHIFT_OUT <= 0;
        SHIFT_FLAG <= 0;
      end
    end
  end
endmodule

