class AES_scoreboard extends uvm_scoreboard ;
`uvm_component_utils(AES_scoreboard)
AES_sequence_item item ;
int fd ;
logic   [127:0] exp_out ;

logic   [127:0] in_text[$] ;
logic   [127:0] in_key [$] ;

logic   [127:0] text;
logic   [127:0] key;

int right_count ;
int wrong_count ;

uvm_analysis_imp#(AES_sequence_item,AES_scoreboard) AI_score ;

function new(string name = "AES_scoreboard", uvm_component parent = null);
super.new(name,parent);
endfunction


function void build_phase (uvm_phase phase);
    super.build_phase(phase);
    $display("build Scoreboard = [%0t]",$time);
    item = AES_sequence_item::type_id::create("item");
    AI_score = new("AI_score",this);
endfunction

function void connect_phase (uvm_phase phase);
    super.connect_phase(phase);
    $display("connect Scoreboard = [%0t]",$time);
endfunction

extern function void write (AES_sequence_item t) ;

task run_phase (uvm_phase phase);
    super.run_phase(phase);
    $display("run Scoreboard = [%0t]",$time);
endtask

function void report_phase (uvm_phase phase);
    $display("Report Subscriber = [%0t]",$time);
    $display("Right Counts = %0d , Wrong counts = %0d",right_count,wrong_count);
    if(wrong_count>0)
        $display("Output Logic of the design in wrong: Design has Bugs");
endfunction

endclass


function void AES_scoreboard::write (AES_sequence_item t);
    item = t ;
    
    if(item.valid_in == 1 && item.reset == 1)
    begin
        in_text.push_back(item.plan_text_128);
        in_key.push_back(item.cipher_key_128);
    end

    if(item.reset == 0)
    begin
        in_text = {};  
        in_key = {} ;
    end

    if (item.valid_out == 1 && item.reset == 1 )
        begin
        `uvm_info ("Scoreboard", $sformatf ("Write Function in Scoreboard"), UVM_MEDIUM)

        text=in_text.pop_front();
        key=in_key.pop_front();
        
        // NOTE: MAKE SURE THE PATH TO CODE AND FILES ARE RIGHT 
        // TIP : RUN THE PYTHON CODE ON TERMINAL FROM THE DIRECTORY 
        //       OF THE UVM SCOREBOARD TO CHECK NO ERRORS

        // Open file "key.txt" for writing

        fd = $fopen("D:/Quista/Questasim/examples/proj_aes/Python_code/key.txt","w");

        // Writing to file : First line writing the data , Second line writing the key

        $fdisplay(fd,"%032h\n%032h",text , key);

        // Close the "key.txt"

        $fclose(fd);

        // "$system" task to run the python code and interact with SCOREBOARD through I/O files

        $system($sformatf("python D:/Quista/Questasim/examples/proj_aes/Python_code/aes_enc.py"));

        // Open file "output.txt" for reading

        fd = $fopen("D:/Quista/Questasim/examples/proj_aes/Python_code/output.txt","r");

        // Reading the output of python code through "output.txt" file

        $fscanf(fd,"%h",exp_out);

        // Close the "output.txt"

        $fclose(fd);

        // COMPARE THE ACTUAL OUTPUT AND EXPECTED OUTPUT

        if(exp_out == item.cipher_text_128)
        begin
            $display("SUCCESS , OUT IS %h and EXP OUT IS %h ", item.cipher_text_128 , exp_out);
            right_count ++ ;
        end
        else 
        begin 
            $display("FAILURE , OUT IS %h and EXP OUT IS %h ", item.cipher_text_128 , exp_out);
            wrong_count ++ ;
        end  
    end
    

endfunction

