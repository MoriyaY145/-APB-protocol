class apb_master_driver extends uvm_driver #(apb_seq_item);

    virtual interface apb_if vif;

  // component macro
  `uvm_component_utils(apb_master_driver)

   // Constructor
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction : new

  // UVM connect_phase() 
  function void connect_phase(uvm_phase phase); 
     if(!uvm_config_db#(virtual apb_if)::get(this, "", "vif", vif))
        `uvm_error("connect_phase", {"virtual interface must be set for: ",get_full_name(),".vif"})
  endfunction : connect_phase

   function void start_of_simulation_phase(uvm_phase phase);
      `uvm_info(get_type_name(), {"start of simulation for ", get_full_name()}, UVM_HIGH)
   endfunction : start_of_simulation_phase

 // UVM run_phase
  task run_phase(uvm_phase phase);
    fork
      get_and_drive();
      reset_signals();
    join
  endtask : run_phase

  task get_and_drive();
      @(negedge vif.PRESETn);
      @(posedge vif.PRESETn);

     forever begin
        seq_item_port.get_next_item(req);
         `uvm_info("DRIVER", $sformatf("PADDR: 0x%0h, PWDATA: 0x%0h, PWRITE: %0d, PRDATA: 0x%0h",
               req.PADDR, req.PWDATA, req.PWRITE, req.PRDATA), UVM_LOW)
    
        fork
        // send transaction
        begin
          vif.send_to_dut(req.PADDR, req.PWDATA, req.PWRITE, req.PRDATA);
        end
        // trigger transaction at start of transaction (trigger signal from interface)
        @(posedge vif.drvstart) void'(begin_tr(req, "Driver_APB_Transaction"));
       join
      // End transaction recording
      end_tr(req);        
      seq_item_port.item_done();
     end
  endtask
  

  // Reset all  signals
  task reset_signals();
    forever 
     vif.apb_reset();
  endtask : reset_signals



endclass