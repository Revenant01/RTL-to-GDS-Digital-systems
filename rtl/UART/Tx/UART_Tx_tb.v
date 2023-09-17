`timescale 1ns / 1ps

module UART_Tx_tb ();

  parameter CLK_freq_tb = 200_000_000;
  parameter BAUD_RATE_tb = 9600;
  parameter P_data_width_tb = 8;


  parameter CLK_Ticks = CLK_freq_tb / BAUD_RATE_tb;

  reg CLK_tb;
  reg RST_tb;
  reg PAR_TYP_tb;
  reg PAR_EN_tb;
  reg [P_data_width_tb-1:0] P_data_tb;
  reg DATA_VALID_tb;
  wire TX_OUT_tb;
  wire Busy_tb;




  ////////////////////////////////////////////////////////
  ////////////////// initial block /////////////////////// 
  ////////////////////////////////////////////////////////


  initial begin

    // Save Waveform
    $dumpfile("UART_Tx.vcd");
    $dumpvars;


    // initialization
    initialize();



    send_Data_then_Valid();

    // Check won't receive any data while another data begin processed (Busy)   
    #(5 * CLK_Ticks);
    #(5 * CLK_Ticks);
    #(5 * CLK_Ticks);
    DATA_VALID_tb = 'b1;

    #(5 * CLK_Ticks);
    DATA_VALID_tb = 'b0;

    // to wait for the entire frame to be delivered
    #(5 * CLK_Ticks);
    #(5 * CLK_Ticks);
    #(5 * CLK_Ticks);
    #(5 * CLK_Ticks);
    Reset();
    #(5 * CLK_Ticks);
    #(5 * CLK_Ticks);
    #(5 * CLK_Ticks);

    send_Data_then_Valid2();

  end


  task initialize;
    begin
      CLK_tb = 'b0;
      DATA_VALID_tb = 'b0;
      P_data_tb = 'b0;
      PAR_EN_tb = 'b0;
      PAR_TYP_tb = 'b0;  //EVEN parity
      RST_tb = 'b1;
      #(4 * CLK_Ticks);
    end
  endtask

  task Reset;
    begin
      RST_tb = 'b0;
      #(5 * CLK_Ticks);

      RST_tb = 'b1;
      #(5 * CLK_Ticks);
    end
  endtask

  task send_Data_then_Valid();
    begin
      P_data_tb  = 'h87;

      PAR_EN_tb  = 'b1;
      PAR_TYP_tb = 'b0;  //EVEN parity

      #(5 * CLK_Ticks);
      DATA_VALID_tb = 'b1;

      #(5 * CLK_Ticks);
      DATA_VALID_tb = 'b0;
    end
  endtask

  task send_Data_then_Valid2();
    begin
      P_data_tb  = 'h55;

      PAR_EN_tb  = 'b1;
      PAR_TYP_tb = 'b1;

      #(5 * CLK_Ticks);
      DATA_VALID_tb = 'b1;

      #(5 * CLK_Ticks);
      DATA_VALID_tb = 'b0;
    end
  endtask




  ////////////////////////////////////////////////////////
  ////////////////// Clock Generator  ////////////////////
  ////////////////////////////////////////////////////////

  parameter CLK_period = 5;  //master clock 


  always #(CLK_period / 2.0) CLK_tb = ~CLK_tb;



  ////////////////////////////////////////////////////////
  /////////////////// DUT Instantation ///////////////////
  ////////////////////////////////////////////////////////
  UART_Tx #(
      .CLK_freq(CLK_freq_tb),
      .BAUD_RATE(BAUD_RATE_tb),
      .P_data_width(P_data_width_tb)
  ) DUT (

      .CLK(CLK_tb),
      .RST(RST_tb),
      .PAR_EN(PAR_EN_tb),
      .PAR_TYP(PAR_TYP_tb),
      .P_data(P_data_tb),
      .DATA_VALID(DATA_VALID_tb),
      .TX_OUT(TX_OUT_tb),
      .Busy(Busy_tb)
  );
endmodule
