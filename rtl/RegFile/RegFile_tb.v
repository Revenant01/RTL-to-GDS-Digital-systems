`timescale 1ns / 1ps
module RegFile_tb ();

  reg clk_tb;
  reg rst_tb;
  reg [15:0] WrData_tb;
  reg [2:0] address_tb;
  reg WrEn_tb, RdEn_tb;
  wire [15:0] RdData_tb;

  RegFile Rfile (
      .clk(clk_tb),
      .rst(rst_tb),
      .WrData(WrData_tb),
      .address(address_tb),
      .WrEn(WrEn_tb),
      .RdEn(RdEn_tb),
      .RdData(RdData_tb)
  );

  always #5 clk_tb = ~clk_tb;

  initial begin
    $dumpfile("RegFile.vcd");
    $dumpvars;
    // $monitor ("At Time:%0t RdEn=%0b ,WrEn=%b ,Address=%0h ,WrData=%h , RdData=%h",
    //  $time,RdEn_tb , WrData_tb , address_tb , WrData_tb , RdData_tb );
  end

  initial begin
    clk_tb  = 1'b0;
    rst_tb  = 1'b0;  //Active low Asynch 
    WrEn_tb = 1'b0;
    RdEn_tb = 1'b0;
  end

  initial begin
    #150;
    $stop;
  end


  initial begin

    #10;
    rst_tb = 1'b1;

    #10;
    $display("-----------------------------------------------");
    $display("Test1: Attemping to Read from an empty location ");
    $display("-----------------------------------------------");
    address_tb = 4'h0;
    RdEn_tb = 1'b1;

    #10;
    if (RdData_tb == 0) begin
      $display("******************** Test 1 Passed! **********************");
    end else begin
      $display("################### Test 1 Failed! ######################");
    end
    $display("<<At Time:%0t RdEn=%0b ,WrEn=%1b ,Address=%0h ,WrData=%0h , RdData=%0h>>", $time,
             RdEn_tb, WrEn_tb, address_tb, WrData_tb, RdData_tb);

    $display("-----------------------------------------------");
    $display("Test2: Attemping to write with WrEn not high");
    $display("-----------------------------------------------");
    address_tb = 4'h5;
    WrData_tb = 16'hAE55;

    RdEn_tb = 1'b1;




    #10;
    if (RdData_tb == 0) begin
      $display("******************** Test 2 Passed! **********************");
    end else begin
      $display("################### Test 2 Failed! ######################");
    end
    $display("<<At Time:%0t RdEn=%0b ,WrEn=%b ,Address=%0h ,WrData=%h , RdData=%h>>", $time,
             RdEn_tb, WrEn_tb, address_tb, WrData_tb, RdData_tb);


    $display("------------------------------------------------------------------------------");
    $display("Test3: Attemping to write in location 5 while both RdEn and WrEn are both high");
    $display("------------------------------------------------------------------------------");

    WrEn_tb = 1'b1;





    #10;
    if (RdData_tb == 0) begin
      $display("******************** Test 3 Passed! **********************");
    end else begin
      $display("################### Test 3 Failed! ######################");
    end

    $display("<<At Time:%0t RdEn=%0b ,WrEn=%b ,Address=%0h ,WrData=%h , RdData=%h>>", $time,
             RdEn_tb, WrEn_tb, address_tb, WrData_tb, RdData_tb);

    $display("---------------------------------------------------------");
    $display("Test4: Attemping to write in location 5 with RdEn not high");
    $display("---------------------------------------------------------");
    WrEn_tb = 1'b1;
    RdEn_tb = 1'b0;




    #10;
    if (RdData_tb == 0) begin
      $display("******************** Test 4 Passed! **********************");
    end else begin
      $display("################### Test 4 Failed! ######################");
    end

    $display("<<At Time:%0t RdEn=%0b ,WrEn=%b ,Address=%0h ,WrData=%h , RdData=%h>>", $time,
             RdEn_tb, WrEn_tb, address_tb, WrData_tb, RdData_tb);

    $display("----------------------------------------");
    $display("Test5: Attemping to read from location 5 ");
    $display("----------------------------------------");
    RdEn_tb = 1'b1;
    WrEn_tb = 1'b0;



    #10;

    if (RdData_tb == 16'hAE55) begin
      $display("******************** Test 5 Passed! **********************");
    end else begin
      $display("################### Test 5 Failed! ######################");
    end

    $display("<<At Time:%0t RdEn=%0b ,WrEn=%b ,Address=%0h ,WrData=%h , RdData=%h>>", $time,
             RdEn_tb, WrEn_tb, address_tb, WrData_tb, RdData_tb);

    $display(
        "--------------------------------------------------------------------------------------");
    $display(
        "Test6: Attemping to write multiple statement within one clock Tic to the same location ");
    $display(
        "--------------------------------------------------------------------------------------");

    RdEn_tb = 1'b0;
    WrEn_tb = 1'b1;

    address_tb = 4'h6;
    WrData_tb = 16'hABCD;
    #2;
    address_tb = 4'h6;
    WrData_tb  = 16'h1234;
    #2 address_tb = 4'h6;
    WrData_tb = 16'h5467;

    #6;  //Ensuring the last data wirtten is the kept on
    WrEn_tb = 1'b0;
    RdEn_tb = 1'b1;




    #10;
    if (RdData_tb == 16'h5467) begin
      $display("******************** Test 6 Passed! **********************");
    end else begin
      $display("################### Test 6 Failed! ######################");
    end

    $display("<<At Time:%0t RdEn=%0b ,WrEn=%b ,Address=%0h ,WrData=%h , RdData=%h>>", $time,
             RdEn_tb, WrEn_tb, address_tb, WrData_tb, RdData_tb);

    $display("-------------------------------------------------------------");
    $display("Test7: Writing in multiple location within the same clock Tic");
    $display("-------------------------------------------------------------");
    RdEn_tb = 1'b0;
    WrEn_tb = 1'b1;
    #1;
    address_tb = 4'h2;
    WrData_tb  = 16'hAD59;
    #1;
    address_tb = 4'h3;
    WrData_tb  = 16'h4589;

    #1;
    address_tb = 4'h4;
    WrData_tb  = 16'h0025;

    #7;  // Ensuring the only location RCVD data is the last one was written on
    WrEn_tb = 1'b0;
    RdEn_tb = 1'b1;

    #10;
    if (RdData_tb == 16'h0025) begin
      $display("******************** Test 7_A Passed! **********************");
    end else begin
      $display("#################### Test 7_A Failed! ######################");
    end
    $display("<<At Time:%0t RdEn=%0b ,WrEn=%b ,Address=%0h ,WrData=%h , RdData=%h>>", $time,
             RdEn_tb, WrEn_tb, address_tb, WrData_tb, RdData_tb);

    address_tb = 4'h3;

    #10;
    if (RdData_tb == 16'h0000) begin
      $display("******************** Test 7_B Passed! **********************");
    end else begin
      $display("#################### Test 7_B Failed! ######################");
    end
    $display("<<At Time:%0t RdEn=%0b ,WrEn=%b ,Address=%0h ,WrData=%h , RdData=%h>>", $time,
             RdEn_tb, WrEn_tb, address_tb, WrData_tb, RdData_tb);

    address_tb = 4'h2;

    #10;
    if (RdData_tb == 16'h0000) begin
      $display("******************** Test 7_C Passed! **********************");
    end else begin
      $display("#################### Test 7_C Failed! ######################");
    end
    $display("<<At Time:%0t RdEn=%0b ,WrEn=%b ,Address=%0h ,WrData=%h , RdData=%h>>", $time,
             RdEn_tb, WrEn_tb, address_tb, WrData_tb, RdData_tb);

    #10;
    rst_tb = 1'b0;

  end
endmodule
