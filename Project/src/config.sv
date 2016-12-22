//% Global configuration file for RSA processor module.

`timescale 1ns / 1ps

`define CLK_PERIOD 20

`define ASYNCHRONOUS_RESET

`ifdef ASYNCHRONOUS_RESET
    // Asynchronous reset.
    `define SYNC_OR_ASYNC_RESET , posedge rst
`else
    // Synchronous reset.
    `define SYNC_OR_ASYNC_RESET
`endif

//% Input width setup.
//% CONFIG_DATA_WIDTH >= 4 only.
//% For RSA encryption effective input width must be (CONFIG_DATA_WIDTH-1), i. e.
//% the highest-value bit of input must always be 0.
//% Output width is the same as CONFIG_DATA_WIDTH. Effective output width for
//% encryption is also equal to CONFIG_DATA_WIDTH.
//% For RSA decryption CONFIG_DATA_WIDTH corresponds to effective input width, but
//% may or may not correspond to the effective output bit-width. See mod_exp
//% documentation for further explanations.
`define CONFIG_DATA_WIDTH (1024+1)
