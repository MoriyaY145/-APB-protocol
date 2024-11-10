module hw_top;
   logic clk;
   logic reset_n;

    // Clock generation
    clkgen my_clkgen(.clock(clk));

    // Reset generation
    //resetgen my_resetgen(.reset_n(reset_n));

   apb_if apb_if(.PCLK(clk), .PRESETn(reset_n));

   apb_slave dut(
    .pclk(apb_if.PCLK),
    .rst_n(apb_if.PRESETn),
    .paddr(apb_if.PADDR),
    .psel(apb_if.PSEL),
    .penable(apb_if.PENABLE),
    .pwrite(apb_if.PWRITE),
    .pwdata(apb_if.PWDATA),
    .pready(apb_if.PREADY),
    .prdata(apb_if.PRDATA)
   );

   initial begin
    reset_n <= 1'b1;
    @(negedge clk)
      #1 reset_n <= 1'b0;
    @(negedge clk)
      #1 reset_n <= 1'b1;
  end

endmodule : hw_top