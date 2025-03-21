`timescale 10ns/1ps

module new_test();
    reg clk, reset, door_close, start, filled, detergent_added, cycle_timeout, drained, spin_timeout;
    wire door_lock, motor_on, fill_value_on, drain_value_on, done, soap_wash, water_wash; 

    // Instance of the automatic washing machine module (DUT)
    automatic_washing_machine uut(
        .clk(clk),
        .reset(reset),
        .door_close(door_close),
        .start(start),
        .filled(filled),
        .detergent_added(detergent_added),
        .cycle_timeout(cycle_timeout),
        .drained(drained),
        .spin_timeout(spin_timeout),
        .door_lock(door_lock),
        .motor_on(motor_on),
        .fill_value_on(fill_value_on),
        .drain_value_on(drain_value_on),
        .done(done),
        .soap_wash(soap_wash),
        .water_wash(water_wash)
    );

    // Initialize all the signals and apply stimulus
    initial begin
        clk = 0;
        reset = 1;
        start = 0;
        door_close = 0;
        filled = 0;
        drained = 0;
        detergent_added = 0;
        cycle_timeout = 0;
        spin_timeout = 0;
        
        // Apply stimulus with delays
        #5 reset = 0;
        #5 start = 1; door_close = 1;
        #10 filled = 1;
        #10 detergent_added = 1;
        #10 cycle_timeout = 1;
        #10 drained = 1;
        #10 spin_timeout = 1;
    end

    // Clock generation: Toggle clock every 5ns
    always begin
        #5 clk = ~clk;
    end

    // Dump signals to a VCD file for GTKWave
    initial begin
        $dumpfile("dump.vcd");    // Name of the VCD file
        $dumpvars(1, uut, new_test);   // Dump all signals from the testbench and the DUT
    end

    initial begin
        $monitor("Time=%d, Clock=%b, Reset=%b, Start=%b, Door_Close=%b, Filled=%b, Detergent_Added=%b, Cycle_Timeout=%b, Drained=%b, Spin_Timeout=%b, Door_Lock=%b, Motor_On=%b, Fill_Value_On=%b, Drain_Value_On=%b, Soap_Wash=%b, Water_Wash=%b, Done=%b",
                 $time, clk, reset, start, door_close, filled, detergent_added, cycle_timeout, drained, spin_timeout, door_lock, motor_on, fill_value_on, drain_value_on, soap_wash, water_wash, done);
    end

    initial begin
        #1500;
        $finish;
    end

endmodule
