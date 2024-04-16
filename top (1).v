module top(
    input clk_100MHz,       // Basys 3 oscillator
    input shift_right,             // Button Shift
    input shift_left,
    input shift_top,
    input shift_down,
    input enable_dots,
    input mid_btn,
    output hsync,           // to VGA port
    output vsync,           // to VGA port
    output [11:0] rgb       // to DAC, to VGA port
);

// Internal Signals
wire [9:0] w_x, w_y;
wire shift_pressed,shift_pressed2,shift_pressed3,shift_pressed4,shift_pressed5;
wire w_p_tick, w_video_on, w_reset;
wire brown,sky_blue,corner;
reg [11:0] rgb_reg;
wire [11:0] rgb_next;
//wire dot_out_z0;
//wire dot_out_z50;
wire dot_out;
// Instantiate Inner Modules
vga_controller vga(
    .clk_100MHz(clk_100MHz),
    .reset(w_reset),
    .video_on(w_video_on),
    .p_tick(w_p_tick),
    .hsync(hsync),
    .vsync(vsync),
    .x(w_x),
    .y(w_y)
);
//LINE FORMATION OF FIXED POINTS.
room room1(
    .clk_100MHz(clk_100MHz),
    .video_on(w_video_on),
    .x(w_x),
    .y(w_y),
    .shift_r(shift_pressed),
    .shift_l(shift_pressed2),
    .window(brown),
    .window_2(sky_blue),
    .corner(corner)
);
//TRY THIS FOR ROTATION_____________________
four_pt down(
    .clk_100MHz(clk_100MHz),
    .video_on_pt(w_video_on),
    .x_pt(w_x),
    .y_pt(w_y),
    .enable_dots(enable_dots),
    .shift_pt(shift_pressed3),
    .shift_l(shift_pressed4),
    .dots(dot_out)
);

debounce btnC_debounce1(
    .clk(clk_100MHz),
    .btn_in(shift_right),
    .btn_out(shift_pressed)
);

debounce btnC_debounce2(
    .clk(clk_100MHz),
    .btn_in(shift_left),
    .btn_out(shift_pressed2)
);
debounce btnC_debounce3(
    .clk(clk_100MHz),
    .btn_in(shift_top),
    .btn_out(shift_pressed3)
);
debounce btnC_debounce4(
    .clk(clk_100MHz),
    .btn_in(shift_down),
    .btn_out(shift_pressed4)
);

debounce btnC_debounce5(
    .clk(clk_100MHz),
    .btn_in(mid_btn),
    .btn_out(shift_pressed5)
);

    // RGB Color Values        
    reg [11:0] RED    = 12'h00F;
    reg [11:0] YELLOW = 12'h5FF;
    reg [11:0] BLACK  = 12'h000;
    reg [11:0] BLUE    = 12'hF00;
    reg [11:0] GREEN  = 12'h0F0;
    reg [11:0] CONTRAST = 12'h111;
    
  
  // Update RGB contrast output
always @(posedge clk_100MHz) begin
    if (shift_pressed5) begin
        YELLOW <= YELLOW - CONTRAST;
        end
end
    

assign rgb_next = (~w_video_on) ? BLACK :
                  (dot_out) ? RED :
                  (brown) ? BLUE :
                  (sky_blue) ? BLUE :
                  (corner) ? BLACK :
                  YELLOW;


// Update RGB output
always @(posedge clk_100MHz) begin
    if (w_p_tick)
        rgb_reg <= rgb_next;
end

assign rgb = rgb_reg;

endmodule
