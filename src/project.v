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
  wire gpio4_out;
  wire gpio5_out;
  wire gpio6_out;
  wire gpio7_out;
  wire miso_out;
  wire gpio0_dir;
  wire gpio1_dir;
  wire gpio2_dir;
  wire gpio3_dir;
  wire gpio4_dir;
  wire gpio5_dir;
  wire gpio6_dir;
  wire gpio7_dir;

  top emulator (
      .rst(rst),
      .clk(clk),
      .gpio0_out(gpio0_out),
      .gpio1_out(gpio1_out),
      .gpio2_out(gpio2_out),
      .gpio3_out(gpio3_out),
      .gpio4_out(gpio4_out),
      .gpio5_out(gpio5_out),
      .gpio6_out(gpio6_out),
      .gpio7_out(gpio7_out),
      .gpio0_in(uio_in[0]),
      .gpio1_in(uio_in[1]),
      .gpio2_in(uio_in[2]),
      .gpio3_in(uio_in[3]),
      .gpio4_in(uio_in[4]),
      .gpio5_in(uio_in[5]),
      .gpio6_in(uio_in[6]),
      .gpio7_in(uio_in[7]),
      .gpio0_dir(gpio0_dir),
      .gpio1_dir(gpio1_dir),
      .gpio2_dir(gpio2_dir),
      .gpio3_dir(gpio3_dir),
      .gpio4_dir(gpio4_dir),
      .gpio5_dir(gpio5_dir),
      .gpio6_dir(gpio6_dir),
      .gpio7_dir(gpio7_dir),

      .miso(miso_out),
      .mosi(ui_in[0]),
      .ss(ui_in[1]),
      .sclk(ui_in[2])
  );

  assign uo_out  = {7'b0, miso_out};
  assign uio_out = {gpio7_out, gpio6_out, gpio5_out, gpio4_out, gpio3_out, gpio2_out, gpio1_out, gpio0_out};
  assign uio_oe  = {gpio7_dir, gpio6_dir, gpio5_dir, gpio4_dir, gpio3_dir, gpio2_dir, gpio1_dir, gpio0_dir};

  // List all unused inputs to prevent warnings
  wire _unused = &{ena, ui_in, uio_in, 1'b0};

endmodule
