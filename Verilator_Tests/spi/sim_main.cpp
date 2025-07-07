#include "Vtop.h"
#include "verilated.h"
#include "verilated_vcd_c.h"

int main(int argc, char** argv) {
    Verilated::commandArgs(argc, argv);
    Verilated::traceEverOn(true);

    Vtop* top = new Vtop;

    VerilatedVcdC* tfp = new VerilatedVcdC;
    top->trace(tfp, 99);
    tfp->open("wave.vcd");

    int clk = 0;
    for (int time = 0; time < 5000; time++) {
        // Toggle clk every 20 time units (simulate 25 MHz)
        if ((time % 20) == 0)
            clk = !clk;

        top->clk_25mhz = clk;
        top->eval();
        tfp->dump(time);
    }

    tfp->close();
    delete top;
    return 0;
}
