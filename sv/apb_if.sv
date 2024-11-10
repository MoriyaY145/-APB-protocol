interface apb_if #(int ADDR_WIDTH = 32, int DATA_WIDTH = 32) (input PCLK, PRESETn);
    // Signal
    logic [ADDR_WIDTH-1:0] PADDR;
    bit PSEL;
    bit PENABLE;
    bit PWRITE;
    logic [DATA_WIDTH-1:0] PWDATA;
    bit PREADY;
    logic [DATA_WIDTH-1:0] PRDATA;

    bit monstart, drvstart;

    task apb_reset();
      @(negedge PRESETn);
      PADDR <= 'hz;
      PSEL <= 'b0;
      PENABLE <= 'b0;
      PWRITE <= 'hz;
      PWDATA <= 'hz;
    endtask

task send_to_dut(bit [ADDR_WIDTH-1:0] paddr, bit [DATA_WIDTH-1:0] pwdata, bit pwrite, bit [DATA_WIDTH-1:0] prdata);

    @(posedge PCLK)

    // trigger for transaction recording
    drvstart = 1'b1;
    
    PADDR <= paddr;
    PWRITE <=  pwrite;
    PSEL <= 1'b1;
    PENABLE <= 1'b0;
    PWDATA <= pwdata;
    @(posedge PCLK)
    PENABLE <= 1'b1;

    //wait for ready signal
    @(posedge PCLK iff(PREADY)) 

    PENABLE <= 1'b0;    
    PSEL <= 1'b0; 
    // reset trigger
    drvstart = 1'b0;
    
  endtask


    task collect_packet(output bit [ADDR_WIDTH-1:0] paddr, bit [DATA_WIDTH-1:0] pwdata, bit [DATA_WIDTH-1:0] prdata, bit pwrite); 
     @(posedge PSEL);

      @(posedge PREADY iff (PENABLE))
      // trigger for transaction recording
      monstart = 1'b1;
      paddr <= PADDR;
      pwrite <= PWRITE;
      pwdata <= PWDATA;
      prdata <= PRDATA;
      @(negedge PREADY)
      monstart <= 1'b0;
          $display("send to monitor: Received request - PADDR: %h, PWDATA: %h, PWRITE: %b, PRDATA: %h", paddr, pwdata, pwrite, prdata);
    endtask : collect_packet


endinterface