`include "config.sv"

module mod_exp_tb_2();

// DATA_WIDTH is chosen for 64-bit input of RSA encryption, where in the 65-bit
// logic [64:0] c: (1'b0 == c[64]) so c[64:0] < n always, where 1'b1 == n[64].
// Output m[64:0] is up to full 65 effective bits.
parameter DATA_WIDTH = (64+1);

logic clk;
logic ce;
logic rst;
logic start;
logic [(DATA_WIDTH-1):0] c;
logic [(DATA_WIDTH-1):0] d;
logic [($clog2(DATA_WIDTH)-1):0] t_sub_1;
logic [(DATA_WIDTH-1):0] r2_mod_n;
logic [(DATA_WIDTH-1):0] n;
logic ready;
logic [(DATA_WIDTH-1):0] m;
logic done;

mod_exp #(DATA_WIDTH) dut
(
    .clk(clk),
    .ce(ce),
    .rst(rst),
    .start(start),
    .c(c),
    .d(d),
    .t_sub_1(t_sub_1),
    .r2_mod_n(r2_mod_n),
    .n(n),
    .ready(ready),
    .m(m),
    .done(done)
);

always #(`CLK_PERIOD/2) clk = ~clk;

initial
begin

    clk = 1'b1;
    ce = 1'b1;
    start = 1'b0;

    rst = 1'b0;
    @(posedge clk);
    rst = 1'b1;
    @(posedge clk);
    rst = 1'b0;


    // mod_exp processes m = (c ^ d) mod n.

    // K = 2 + DATA_WIDTH = (64 + 1 + 2).

    // 1.
    // As n <= 2^65-1 and n is odd, let n = 2^65-1.
    n = 65'h_1_FFFF_FFFF_FFFF_FFFF;
    // As c<n let this value of c.
    c = 64'h_FFFF_FFFF_FFFF_FFFF;
    // Set d and t_sub_1.
    d = 2'd_3;
    t_sub_1 = 1;
    // r2_mod_n = (r^2) mod n = ((2^K)^2) mod n.
    // r2_mod_n = ((2^67)^2) mod 65'h_1_FFFF_FFFF_FFFF_FFFF.
    // mod(((2^67)^2),(2^65-0x1)) = 0x10 = 65'h_10.
    r2_mod_n = 65'h_10;

    // N is the number of cycles, required to process m after start is set 1.
    // N = (K+1)*(t_sub_1+1+3) = (64+1+2+1)*(1+1+3) = 340.
    start = 1'b1;
    @(posedge clk);
    start = 1'b0;
    @(posedge clk);

    // m = (64'h_FFFF_FFFF_FFFF_FFFF ^ 2'd_3) mod 65'h_1_FFFF_FFFF_FFFF_FFFF.
    // Check: mod((0xFFFFFFFFFFFFFFFF ^ 3), 0x1FFFFFFFFFFFFFFFF) = 0x1BFFFFFFFFFFFFFFF =
    // = 65'h_1_BFFF_FFFF_FFFF_FFFF.
    // Output m of dut is 65'h_1_BFFF_FFFF_FFFF_FFFF.




    // 2.
    @(ready);
    @(posedge clk);

    // As n <= 2^65-1 and n is odd, let this value of n.
    n = 65'h_1_FFBF_FFAF_FFFF_FCFF;
    // As c<n let this value of c.
    c = 64'h_FBFF_FAFF_FFFC_FF3F;
    // Set d and t_sub_1.
    d = 3'd_5;
    t_sub_1 = 2;
    // r2_mod_n = (r^2) mod n = ((2^K)^2) mod n.
    // r2_mod_n = ((2^67)^2) mod 65'h_1_FFBF_FFAF_FFFF_FCFF.
    // Check: mod(((2^67)^2),(0x1FFBFFFAFFFFFFCFF)) = 0x154B47BD7FA049270 =
    // = 65'h_1_54B4_7BD7_FA04_9270.
    r2_mod_n = 65'h_1_54B4_7BD7_FA04_9270;

    // N is the number of cycles, required to process m after start is set 1.
    // N = (K+1)*(t_sub_1+1+3) = (64+1+2+1)*(2+1+3) = 408.
    start = 1'b1;
    @(posedge clk);
    start = 1'b0;
    @(posedge clk);

    // m = (64'h_FBFF_FAFF_FFFC_FF3F ^ 3'd_5) mod 65'h_1_FFBF_FFAF_FFFF_FCFF.
    // Check: mod((0xFBFFFAFFFFFCFF3F ^ 5), 0x1FFBFFFAFFFFFFCFF) = 0x75101EEA011D4B47 =
    // = 65'h_0_7510_1EEA_011D_4B47.
    // Output m of dut is 65'h_0_7510_1EEA_011D_4B47.




    // 3.
    @(ready);
    @(posedge clk);

    // As n <= 2^65-1 and n is odd, let this value of n.
    n = 65'h_1_A5FF_F6FF_BF1F_FFC1;
    // As c<n let this value of c.
    c = 64'h_0FFA_34FF_FF4C_F230;
    // Set d and t_sub_1.
    d = 2'd_3;
    t_sub_1 = 1;
    // r2_mod_n = (r^2) mod n = ((2^K)^2) mod n.
    // r2_mod_n = ((2^67)^2) mod 65'h_1_A5FF_F6FF_BF1F_FFC1.
    // mod(((2^67)^2),(h_1_A5FF_F6FF_BF1F_FFC1)) = 0xD25B02328D8C65B =
    // = 65'h_0D25_B023_28D8_C65B.
    r2_mod_n = 65'h_0D25_B023_28D8_C65B;

    // N is the number of cycles, required to process m after start is set 1.
    // N = (K+1)*(t_sub_1+1+3) = (64+1+2+1)*(1+1+3) = 340.
    start = 1'b1;
    @(posedge clk);
    start = 1'b0;
    @(posedge clk);

    // m = (64'h_0FFA_34FF_FF4C_F230 ^ 2'd_3) mod 65'h_1_A5FF_F6FF_BF1F_FFC1.
    // Check: mod((0x0FFA34FFFF4CF230 ^ 3), 0x1A5FFF6FFBF1FFFC1) =
    // = 0x11133288DE07E7C07 = 65'h_1_1133_288D_E07E_7C07.
    // Output m of dut is 65'h_1_1133_288D_E07E_7C07.




    // 4.
    @(ready);
    @(posedge clk);

    // As n <= 2^65-1 and n is odd, let this value of n.
    n = 65'h_1_1CEB_00DA_1CEB_00DD;
    // As c<n let this value of c.
    c = 64'h_BAAD_F00D_BAAD_F00D;
    // Set d and t_sub_1.
    d = 2'd_3;
    t_sub_1 = 1;
    // r2_mod_n = (r^2) mod n = ((2^K)^2) mod n.
    // r2_mod_n = ((2^67)^2) mod 65'h_1_1CEB_00DA_1CEB_00DD.
    // mod(((2^67)^2),(h_1_1CEB_00DA_1CEB_00DD)) = 0xC28D495579D830AA =
    // = 65'h_C28D_4955_79D8_30AA.
    r2_mod_n = 65'h_C28D_4955_79D8_30AA;

    // N is the number of cycles, required to process m after start is set 1.
    // N = (K+1)*(t_sub_1+1+3) = (64+1+2+1)*(1+1+3) = 340.
    start = 1'b1;
    @(posedge clk);
    start = 1'b0;
    @(posedge clk);

    // m = (64'h_BAAD_F00D_BAAD_F00D ^ 2'd_3) mod 65'h_1_1CEB_00DA_1CEB_00DD.
    // Check: mod((0xBAADF00DBAADF00D ^ 3), 0x11CEB00DA1CEB00DD) =
    // = 0x57DF720DD7B9B1F6 = 65'h_0_57DF_720D_D7B9_B1F6.
    // Output m of dut is 65'h_0_57DF_720D_D7B9_B1F6.




    // 5.
    @(ready);
    @(posedge clk);

    // As n <= 2^65-1 and n is odd, let this value of n.
    n = 65'h_1_FFFF_CAFE_D00D_FFFF;
    // As c<n let this value of c.
    c = 65'h_1_FFFF_CAFE_D00D_FFFE;
    // Set d and t_sub_1.
    d = 2'd_3;
    t_sub_1 = 1;
    // r2_mod_n = (r^2) mod n = ((2^K)^2) mod n.
    // r2_mod_n = ((2^67)^2) mod 65'h_1_FFFF_CAFE_D00D_FFFF.
    // mod(((2^67)^2),(h_1_FFFF_CAFE_D00D_FFFF)) = 0x1708564AF56C1F803 =
    // = 65'h_1_7085_64AF_56C1_F803.
    r2_mod_n = 65'h_1_7085_64AF_56C1_F803;

    // N is the number of cycles, required to process m after start is set 1.
    // N = (K+1)*(t_sub_1+1+3) = (64+1+2+1)*(1+1+3) = 340.
    start = 1'b1;
    @(posedge clk);
    start = 1'b0;
    @(posedge clk);

    // m = (65'h_1_FFFF_CAFE_D00D_FFFE ^ 2'd_3) mod 65'h_1_FFFF_CAFE_D00D_FFFF.
    // Check: mod((0x1FFFFCAFED00DFFFE ^ 3), 0x1FFFFCAFED00DFFFF) =
    // = 0x1FFFFCAFED00DFFFE = 65'h_1_FFFF_CAFE_D00D_FFFE.
    // Output m of dut is 65'h_1_FFFF_CAFE_D00D_FFFE.




    // 6.
    @(ready);
    @(posedge clk);

    // As n <= 2^65-1 and n is odd, let this value of n.
    n = 65'h_1_FACE_FEED_FACE_FEED;
    // As c<n let this value of c.
    c = 64'h_DEAD_FEED_DEAD_FEED;
    // Set d and t_sub_1.
    d = 3'd_4;
    t_sub_1 = 2;
    // r2_mod_n = (r^2) mod n = ((2^K)^2) mod n.
    // r2_mod_n = ((2^67)^2) mod 65'h_1_FACE_FEED_FACE_FEED.
    // mod(((2^67)^2),(h_1_FACE_FEED_FACE_FEED)) = 0x1950C4939D45AE939 =
    // = 65'h_1_950C_4939_D45A_E939.
    r2_mod_n = 65'h_1_950C_4939_D45A_E939;

    // N is the number of cycles, required to process m after start is set 1.
    // N = (K+1)*(t_sub_1+1+3) = (64+1+2+1)*(2+1+3) = 408.
    start = 1'b1;
    @(posedge clk);
    start = 1'b0;
    @(posedge clk);

    // m = (64'h_DEAD_FEED_DEAD_FEED ^ 3'd_4) mod 65'h_1_FACE_FEED_FACE_FEED.
    // Check: mod((0xDEADFEEDDEADFEED ^ 4), 0x1FACEFEEDFACEFEED) =
    // = 0x1525F7F6995612A53 = 65'h_1_525F_7F69_9561_2A53.
    // Output m of dut is 65'h_1_525F_7F69_9561_2A53.




    // 7.
    @(ready);
    @(posedge clk);

    // As n <= 2^65-1 and n is odd, let this value of n.
    n = 65'h_1_1BAD_B002_1BAD_B001;
    // As c<n let this value of c.
    c = 64'h_000F_F1CE_000F_F1CE;
    // Set d and t_sub_1.
    d = 2'd_3;
    t_sub_1 = 1;
    // r2_mod_n = (r^2) mod n = ((2^K)^2) mod n.
    // r2_mod_n = ((2^67)^2) mod 65'h_1_1BAD_B002_1BAD_B001.
    // mod(((2^67)^2),(h_1_1BAD_B002_1BAD_B001)) = 0x1008B527F008B52BE =
    // = 65'h_1_008B_527F_008B_52BE.
    r2_mod_n = 65'h_1_008B_527F_008B_52BE;

    // N is the number of cycles, required to process m after start is set 1.
    // N = (K+1)*(t_sub_1+1+3) = (64+1+2+1)*(1+1+3) = 340.
    start = 1'b1;
    @(posedge clk);
    start = 1'b0;
    @(posedge clk);

    // m = (64'h_000F_F1CE_000F_F1CE ^ 2'd_3) mod 65'h_1_1BAD_B002_1BAD_B001.
    // Check: mod((0x000FF1CE000FF1CE ^ 3), 0x11BADB0021BADB001) =
    // = mod(0xFD58FBD57CC9EEFA8647E5F88B95EE5284BEFB8, 0x11BADB0021BADB001) =
    // = 0x818EAFD0818EAFD0 = 65'h_0_818E_AFD0_818E_AFD0.
    // Output m of dut is 65'h_0_818E_AFD0_818E_AFD0.




    // 8.
    @(ready);
    @(posedge clk);

    // As n <= 2^65-1 and n is odd, let this value of n.
    n = 65'h_1_0101_0101_0101_0101;
    // As c<n let this value of c.
    c = 64'h_1010_1010_1010_1010;
    // Set d and t_sub_1.
    d = 2'd_3;
    t_sub_1 = 1;
    // r2_mod_n = (r^2) mod n = ((2^K)^2) mod n.
    // r2_mod_n = ((2^67)^2) mod 65'h_1_0101_0101_0101_0101.
    // mod(((2^67)^2),(h_1_0101_0101_0101_0101)) = 0x4000000000000000 =
    // = 65'h_4000_0000_0000_0000.
    r2_mod_n = 65'h_4000_0000_0000_0000;

    // N is the number of cycles, required to process m after start is set 1.
    // N = (K+1)*(t_sub_1+1+3) = (64+1+2+1)*(1+1+3) = 340.
    start = 1'b1;
    @(posedge clk);
    start = 1'b0;
    @(posedge clk);

    // m = (64'h_1010_1010_1010_1010 ^ 2'd_3) mod 65'h_1_0101_0101_0101_0101.
    // Check: mod((0x1010101010101010 ^ 3), 0x10101010101010101) =
    // = 0xF101010101010101 = 65'h_0_F101_0101_0101_0101.
    // Output m of dut is 65'h_0_F101_0101_0101_0101.




    // 9.
    @(ready);
    @(posedge clk);

    // As n <= 2^65-1 and n is odd, let this value of n.
    n = 65'h_0_0000_01F1_A1F1_A1F1;
    // As c<n let this value of c.
    c = 64'h_00FF_0FF1_01F1;
    // Set d and t_sub_1.
    d = 3'd_5;
    t_sub_1 = 2;
    // r2_mod_n = (r^2) mod n = ((2^K)^2) mod n.
    // r2_mod_n = ((2^67)^2) mod 65'h_0_0000_01F1_A1F1_A1F1.
    // mod(((2^67)^2),(h_0_0000_01F1_A1F1_A1F1)) = 0x1C01054F7AD =
    // = 65'h_01C0_1054_F7AD.
    r2_mod_n = 65'h_01C0_1054_F7AD;

    // N is the number of cycles, required to process m after start is set 1.
    // N = (K+1)*(t_sub_1+1+3) = (64+1+2+1)*(2+1+3) = 408.
    start = 1'b1;
    @(posedge clk);
    start = 1'b0;
    @(posedge clk);

    // m = (64'h_0_0000_00FF_0FF1_01F1 ^ 3'd_5) mod 65'h_0_0000_01F1_A1F1_A1F1.
    // Check: mod((0x000000FF0FF101F1 ^ 5), 0x0000001F1A1F1A1F1) =
    // = 0xDD239FDBE5 = 65'h_0_0000_00DD_239F_DBE5.
    // Output m of dut is 65'h_0_0000_00DD_239F_DBE5.




    // 10.
    @(ready);
    @(posedge clk);

    // As n <= 2^65-1 and n is odd, let this value of n.
    n = 65'h_1_CAFE_BABE_BADD_BEAF;
    // As c<n let this value of c.
    c = 64'h_00BA_B10C_FEE1_FA11;
    // Set d and t_sub_1.
    d = 3'd_7;
    t_sub_1 = 2;
    // r2_mod_n = (r^2) mod n = ((2^K)^2) mod n.
    // r2_mod_n = ((2^67)^2) mod 65'h_1_CAFE_BABE_BADD_BEAF.
    // mod(((2^67)^2),(h_1_CAFE_BABE_BADD_BEAF)) = 0x1565FB04A9B597FFB =
    // = 65'h_1_565F_B04A_9B59_7FFB.
    r2_mod_n = 65'h_1_565F_B04A_9B59_7FFB;

    // N is the number of cycles, required to process m after start is set 1.
    // N = (K+1)*(t_sub_1+1+3) = (64+1+2+1)*(2+1+3) = 408.
    start = 1'b1;
    @(posedge clk);
    start = 1'b0;
    @(posedge clk);

    // m = (64'h_00BA_B10C_FEE1_FA11 ^ 3'd_7) mod 65'h_1_CAFE_BABE_BADD_BEAF.
    // Check: mod((0x00BAB10CFEE1FA11 ^ 7), 0x1CAFEBABEBADDBEAF) =
    // = 0x172AC78398A86C805 = 65'h_1_72AC_7839_8A86_C805.
    // Output m of dut is 65'h_1_72AC_7839_8A86_C805.


end  // initial

endmodule: mod_exp_tb_2
