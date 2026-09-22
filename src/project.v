/*
 * Copyright (c) 2024 Your Name
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module tt_um_example (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // always 1 when the design is powered, so you can ignore it
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);

  wire rst = ~rst_n;

  wire gpio0_out;
  wire gpio1_out;
  wire gpio2_out;
  wire gpio3_out;
  wire miso;

  top emulator (
      .rst(rst),
      .clk(clk),
      .gpio0_out(gpio0_out),
      .gpio1_out(gpio1_out),
      .gpio2_out(gpio2_out),
      .gpio3_out(gpio3_out),
      .gpio0_in(ui_in[0]),
      .gpio1_in(ui_in[1]),
      .gpio2_in(ui_in[2]),
      .gpio3_in(ui_in[3]),

      // spi
      .miso(miso),
      .mosi(ui_in[4]),
      .ss(ui_in[5]),
      .sclk(ui_in[6]),
  );

  assign uo_out  = {3'b0, miso, gpio3_out, gpio2_out, gpio1_out, gpio0_out};
  assign uio_out = 0;
  assign uio_oe  = 0;

  // List all unused inputs to prevent warnings
  wire _unused = &{ena, ui_in, uio_in, 1'b0};

endmodule
