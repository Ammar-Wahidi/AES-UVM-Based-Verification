interface AES_interface (clk) ;
input bit clk    ;
bit       reset  ;

logic   [127:0]     plan_text_128   ;
logic   [127:0]     cipher_key_128  ;
logic               valid_in        ;  
logic   [127:0]     cipher_text_128 ;
logic               valid_out       ;

// Clocking block at posedge clk
clocking cb_dr @(posedge clk);
    default input #1 output #1;   // skew for avoiding race
    output reset, plan_text_128, cipher_key_128, valid_in;     // driven by TB
    input cipher_text_128,valid_out;
endclocking

// Clocking block at posedge clk
clocking cb_mon @(posedge clk);
    default input #1 output #1;   
    input reset, plan_text_128, cipher_key_128, valid_in,cipher_text_128,valid_out;              
endclocking

endinterface