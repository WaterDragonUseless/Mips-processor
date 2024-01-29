module decoder_5to32_tb;

    // Inputs
    reg [4:0] in;
    
    // Outputs
    wire [31:0] out;
    
    // Instantiate the decoder
    decoder_5to32 uut (
        .in(in),
        .out(out)
    );

    // Clock generation
    reg clk = 0;
    always begin
        #5 clk = ~clk;
    end

    // Stimulus generation
    initial begin
        // Initialize inputs and observe outputs
        in = 5'b00000; // Test input 0
        #10; // Wait for a few clock cycles
        $display("Input: %b, Output: %b", in, out);
        
        in = 5'b00001; // Test input 1
        #10;
        $display("Input: %b, Output: %b", in, out);
        
        in = 5'b00010; // Test input 2
        #10;
        $display("Input: %b, Output: %b", in, out);
        
        in = 5'b10000; // Test input 16
        #10;
        $display("Input: %b, Output: %b", in, out);

        // Add more test cases
        in = 5'b11111; // Test input 31
        #10;
        $display("Input: %b, Output: %b", in, out);

        in = 5'b01010; // Test input 10
        #10;
        $display("Input: %b, Output: %b", in, out);

        in = 5'b10101; // Test input 21
        #10;
        $display("Input: %b, Output: %b", in, out);

        // Finish simulation
        $finish;
    end

endmodule