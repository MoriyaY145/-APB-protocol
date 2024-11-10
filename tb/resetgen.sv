module  resetgen(output logic reset_n);
  initial begin
    reset_n = 0;
    #20;
    reset_n = 1;
  end
endmodule