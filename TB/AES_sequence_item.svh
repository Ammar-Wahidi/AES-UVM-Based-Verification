class AES_sequence_item extends uvm_sequence_item ;
`uvm_object_utils(AES_sequence_item)
rand bit       reset  ;

rand logic   [127:0]     plan_text_128   ;
rand logic   [127:0]     cipher_key_128  ;
rand logic               valid_in        ;  
logic   [127:0]     cipher_text_128 ;
logic               valid_out       ;

function new(string name = "AES_sequence_item");
super.new(name) ;
endfunction

constraint constr1 {
    reset dist {1:=90,0:=10};
    valid_in inside {1} ;
}

 constraint constr2 {
    plan_text_128 dist {
      128'h0 := 25,
      128'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF := 25,
      128'hAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA := 25,
      128'h55555555555555555555555555555555 := 25,
      128'h000102030405060708090a0b0c0d0e0f := 25
    };

    cipher_key_128 dist {
      128'h0 := 25,
      128'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF := 25,
      128'hAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA := 25,
      128'h55555555555555555555555555555555 := 25,
      128'h000102030405060708090a0b0c0d0e0f := 25
    };
  }

endclass