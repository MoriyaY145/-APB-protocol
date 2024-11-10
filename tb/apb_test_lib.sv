class base_test extends uvm_test;

   // component macro
   `uvm_component_utils(base_test)

    apb_tb tb;

    // Constructor
    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction : new


    // UVM build_phase() method
    function void build_phase(uvm_phase phase);
       uvm_config_int::set(this, "*", "recording_detail", 1);
       super.build_phase(phase);
      tb = apb_tb::type_id::create("tb", this);
    endfunction : build_phase

    function void end_of_elaboration_phase(uvm_phase phase);
     uvm_top.print_topology();
   endfunction

   task run_phase(uvm_phase phase);
     uvm_objection obj = phase.get_objection();
     obj.set_drain_time(this, 200ns);
   endtask


    function void check_phase(uvm_phase phase);
        // configuration checker
        check_config_usage();
    endfunction


endclass : base_test

class simple_test extends base_test;

    // component macro
    `uvm_component_utils(simple_test)
  
    // component constructor
    function new(string name, uvm_component parent);
      super.new(name, parent);
    endfunction : new
  
    function void build_phase(uvm_phase phase);
    uvm_config_wrapper::set(this, "tb.apb.tx_agent.sequencer.run_phase",
                                     "default_sequence",
                                     apb_write_read_pkt::get_type());                                                    
      super.build_phase(phase);
    endfunction  
  
  endclass : simple_test