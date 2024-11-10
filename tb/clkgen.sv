module clkgen(output logic clock=0);
  always begin
    #10;
    clock = ~clock;
  end
endmodule




