class apb_monitor extends uvm_monitor;
    
    virtual interface apb_if vif;

    apb_seq_item trans;

    // component macro
    `uvm_component_utils(apb_monitor)

    // Constructor
    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction : new

    // UVM connect_phase() 
    function void connect_phase(uvm_phase phase);
       if(!uvm_config_db#(virtual apb_if)::get(this, get_full_name(), "vif", vif))
          `uvm_error("connect_phase", {"virtual interface must be set for: ",get_full_name(),".vif"})
    endfunction : connect_phase

    function void start_of_simulation_phase(uvm_phase phase);
      `uvm_info(get_type_name(), {"start of simulation for ", get_full_name()}, UVM_HIGH)
    endfunction : start_of_simulation_phase

   // UVM run() phase
    task run_phase(uvm_phase phase);
        @(negedge vif.PRESETn)
        @(posedge vif.PRESETn)
        forever begin 
           // Create collected packet instance
           trans = apb_seq_item::type_id::create("trans", this);
           // concurrent blocks for packet collection and transaction recording
           fork
               // collect packet
               vif.collect_packet(trans.PADDR, trans.PWDATA, trans.PRDATA, trans.PWRITE);
               @(posedge vif.monstart) void'(begin_tr(trans, "Monitor_APB_Transaction"));
           join
          // End transaction recording
           end_tr(trans);
           `uvm_info(get_type_name(), $sformatf("Transaction Collected :\n%s", trans.sprint()), UVM_LOW)
        end
    endtask : run_phase
endclass : apb_monitor