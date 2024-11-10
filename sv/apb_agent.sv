class apb_agent extends uvm_agent;

    apb_master_driver master_driver;
    //apb_slave_driver slave_driver;
    apb_monitor monitor;
    apb_sequencer sequencer;

    // component macro
    `uvm_component_utils_begin(apb_agent)
       `uvm_field_enum(uvm_active_passive_enum, is_active, UVM_ALL_ON)
    `uvm_component_utils_end

    // Constructor
    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction : new
    
    // UVM build_phase() method 
    function void build_phase(uvm_phase phase);
       super.build_phase(phase);
       monitor = apb_monitor::type_id::create("monitor", this);
       if(is_active==UVM_ACTIVE) begin
          master_driver = apb_master_driver::type_id::create("master_driver", this);
          //slave_driver = apb_slave_driver::type_id::create("slave_driver", this);
          sequencer = apb_sequencer::type_id::create("sequencer", this);
       end
    endfunction : build_phase

    // UVM connect_phase() method 
    function void connect_phase(uvm_phase phase);
       if(is_active==UVM_ACTIVE) 
          master_driver.seq_item_port.connect(sequencer.seq_item_export);
          //slave_driver.seq_item_port.connect(sequencer.seq_item_export);
    endfunction : connect_phase

    function void start_of_simulation_phase(uvm_phase phase);
      `uvm_info(get_type_name(), {"start of simulation for ", get_full_name()}, UVM_HIGH)
    endfunction : start_of_simulation_phase

endclass : apb_agent