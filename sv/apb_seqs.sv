class apb_sequence extends uvm_sequence #(apb_seq_item);
  
    // Required macro for sequences automation
    `uvm_object_utils(apb_sequence)
  
    // Constructor
    function new(string name="apb_sequence");
      super.new(name);
    endfunction
  
    task pre_body();
        uvm_phase phase;
        `ifdef UVM_VERSION_1_2
          // in UVM1.2, get starting phase from method
          phase = get_starting_phase();
        `else
          phase = starting_phase;
        `endif
        if (phase != null) begin
          phase.raise_objection(this, get_type_name());
          `uvm_info(get_type_name(), "raise objection", UVM_MEDIUM)
        end
    endtask : pre_body
    
    task post_body();
        uvm_phase phase;
        `ifdef UVM_VERSION_1_2
          // in UVM1.2, get starting phase from method
          phase = get_starting_phase();
        `else
          phase = starting_phase;
        `endif
        if (phase != null) begin
          phase.drop_objection(this, get_type_name());
          `uvm_info(get_type_name(), "drop objection", UVM_MEDIUM)
        end
    endtask : post_body

endclass : apb_sequence

class single_pkt_seq extends apb_sequence;

  `uvm_object_utils(single_pkt_seq)
  
  function new(string name = "single_pkt_seq");
      super.new(name);
  endfunction: new

  virtual task body();
      `uvm_info(get_type_name(), "Executing single_pkt_seq sequence", UVM_LOW)
      `uvm_do_with( req, {PADDR == 2;} )
    endtask

endclass

class apb_3_pkt extends apb_sequence;
  // Required macro for sequences automation
  `uvm_object_utils(apb_3_pkt)

  // Constructor
  function new(string name="apb_3_pkt");
    super.new(name);
  endfunction

  // Sequence body definition
  virtual task body();
    `uvm_info(get_type_name(), "Executing apb_3_pkt sequence", UVM_LOW)
     repeat(3) //begin
      `uvm_do(req)
  endtask
  
endclass : apb_3_pkt
  



class apb_write_read_pkt extends apb_sequence;
  
  // Required macro for sequences automation
  `uvm_object_utils(apb_write_read_pkt)

  // Constructor
  function new(string name="apb_write_read_pkt");
    super.new(name);
  endfunction

  // Sequence body definition
  virtual task body();
    `uvm_info(get_type_name(), "Executing apb_write_read_pkt sequence", UVM_LOW)
      `uvm_do_with(req,{req.PWRITE == 1;})
      `uvm_do_with(req,{req.PWRITE == 0;})
  endtask
  
endclass