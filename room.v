module room(
    input clk_100MHz,       // Basys 3 oscillator
    input video_on,
    input [9:0] x,      // from VGA controller
    input [9:0] y,      // from VGA controller
    input shift_r, 
    input shift_l,
    output window,
    output window_2,
    output corner
    );
    
    // RGB Color Values
    parameter RED    = 12'h00F;
    parameter GREEN  = 12'h2A6;
    parameter BLUE   = 12'hA21;
    parameter YELLOW = 12'h5FF; 
    parameter BLACK  = 12'h000;
    parameter BROWN    = 12'hA22;
    parameter SKY_BLUE = 12'h6CF;
    parameter PINK     = 12'hF6C;
    parameter PURPLE   = 12'h91D;
    parameter ORANGE   = 12'hFA0;
    //Room face1
    
    //Corner formation
    wire corner_pos;
    reg signed [11:0]check_n;

reg signed [11:0]x_corner = 520;
reg signed [11:0]x_corner_mid = 320;
reg signed [11:0]x_corner_n = 360;
reg signed [11:0]pos_check;
wire corner_p,corner_n,corner_s;

always @(*)
begin
check_n <= y+(x>>>2);
pos_check <= y-(x>>>2);
end


always @(posedge clk_100MHz )
begin
if(shift_r)
begin
x_corner <= x_corner - 2;
x_corner_n <= x_corner_n + 2;
if(x_corner_mid >8)
x_corner_mid <= x_corner_mid - 8;
else
x_corner_mid <= 0;
end
else if(shift_l)
begin
x_corner <= x_corner + 2;
x_corner_n <= x_corner_n - 2;
if(x_corner_mid >8)
x_corner_mid <= x_corner_mid + 8;
else
x_corner_mid <= 0;
end
end
 
assign corner_p = ((check_n>0)&&(check_n>x_corner)&&(x<x_corner_mid)&&(y>440));
assign corner_n = ((pos_check>0)&&(pos_check>x_corner_n)&&(y>440)&&(x>x_corner_mid));
assign corner_s = ((x>=x_corner_mid-2)&&(x<x_corner_mid+1));
assign corner_pos = corner_p | corner_n | corner_s;
    
    //Window formation
    parameter window1 = 640;
    
     
    reg signed [11:0] window_start_x_reg;
    reg signed [11:0] window_stop_x_reg;
    reg signed [11:0] window_centre1 = window1;
    reg signed [11:0] window_start_y_reg = 100;
    reg signed [11:0] window_stop_y_reg = 300;

always @(*)
begin

if(window_centre1>165)
//start window
window_start_x_reg <= window_centre1 - 160;
else 
window_start_x_reg <= 0;
//Stop window
window_stop_x_reg <= window_centre1 + 160;
//end
end

always @(posedge clk_100MHz) begin
    if (shift_r) begin
        window_centre1 <= window_centre1 - 8;
    end
    else if (shift_l) begin
        window_centre1 <= window_centre1 + 8;
    end
end

assign window = ((x >= window_start_x_reg) && (x < window_stop_x_reg) && (y >= window_start_y_reg) && (y < window_stop_y_reg) && (window_stop_x_reg>0));
    
//FACE 1 Done
//Corner 2    
      //Corner formation
    wire corner_p_2os2;
    reg signed [11:0]check_n_2;

reg signed [11:0]x_corner_2 = 680;
reg signed [11:0]x_corner_2_mid = 960;
reg signed [11:0]x_corner_2_n = 200;
reg signed [11:0]pos_check_2;
wire corner_p_2,corner_n_2,corner_s_2;

always @(*)
begin
check_n_2 <= y+(x>>>2);
pos_check_2 <= y-(x>>>2);
end


always @(posedge clk_100MHz )
begin
if(shift_r)
begin
x_corner_2 <= x_corner_2 - 2;
x_corner_2_n <= x_corner_2_n + 2;
if(x_corner_2_mid >8)
x_corner_2_mid <= x_corner_2_mid - 8;
else
x_corner_2_mid <= 0;
end
else if(shift_l)
begin
x_corner_2 <= x_corner_2 + 2;
x_corner_2_n <= x_corner_2_n - 2;
if(x_corner_2_mid >8)
x_corner_2_mid <= x_corner_2_mid + 8;
else
x_corner_2_mid <= 0;
end
end
 
assign corner_p_2 = ((check_n_2>0)&&(check_n_2>x_corner_2)&&(x<x_corner_2_mid)&&(y>440));
assign corner_n_2 = ((pos_check_2>0)&&(pos_check_2>x_corner_2_n)&&(y>440)&&(x>x_corner_2_mid));
assign corner_s_2 = ((x>=x_corner_2_mid-2)&&(x<x_corner_2_mid+1));
assign corner_p_2os2 = corner_p_2 | corner_n_2 | corner_s_2;  
    
    
//DOOR formation
        //window_2 formation
    parameter window_22 = 1280;
    
     
    reg signed [11:0] window_2_start_x_reg;
    reg signed [11:0] window_2_stop_x_reg;
    reg signed [11:0] window_2_centre1 = window_22;
    reg signed [11:0] window_2_start_y_reg = 100;
    reg signed [11:0] window_2_stop_y_reg = 480;

always @(*)
begin

if(window_2_centre1>85)
//start window_2
window_2_start_x_reg <= window_2_centre1 - 80;
else 
window_2_start_x_reg <= 0;
//Stop window_2
window_2_stop_x_reg <= window_2_centre1 + 80;
//end
end

always @(posedge clk_100MHz) begin
    if (shift_r) begin
        window_2_centre1 <= window_2_centre1 - 8;
    end
    else  if (shift_l) begin
        window_2_centre1 <= window_2_centre1 + 8;
    end
end

assign window_2 = ((x >= window_2_start_x_reg) && (x < window_2_stop_x_reg) && (y >= window_2_start_y_reg) && (y < window_2_stop_y_reg) && (window_2_stop_x_reg>0));
    
    
      //Corner formation
    wire corner_p_3_print;
    reg signed [12:0]check_N_3;

reg signed [12:0]X_corner_3 = 840;
reg signed [12:0]X_corner_3_mid = 1600;
reg signed [12:0]X_corner_3_n = 40;
reg signed [12:0]Pos_check_3;
wire Corner_p_3,Corner_n_3,Corner_s_3;

always @(*)
begin
check_N_3 <= y+(x>>>2);
Pos_check_3 <= y-(x>>>2);
end


always @(posedge clk_100MHz )
begin
if(shift_r)
begin
X_corner_3 <= X_corner_3 - 2;
X_corner_3_n <= X_corner_3_n + 2;
if(X_corner_3_mid >8)
X_corner_3_mid <= X_corner_3_mid - 8;
else
X_corner_3_mid <= 0;
end
else if(shift_l)
begin
X_corner_3 <= X_corner_3 + 2;
X_corner_3_n <= X_corner_3_n - 2;
if(X_corner_3_mid >8)
X_corner_3_mid <= X_corner_3_mid + 8;
else
X_corner_3_mid <= 0;
end
end
 
assign Corner_p_3 = ((check_N_3>0)&&(check_N_3>X_corner_3)&&(x<X_corner_3_mid)&&(y>440));
assign Corner_n_3 = ((Pos_check_3>0)&&(Pos_check_3>X_corner_3_n)&&(y>440)&&(x>X_corner_3_mid));
assign Corner_s_3 = ((x>=X_corner_3_mid-2)&&(x<X_corner_3_mid+1));
assign corner_p_3_print = Corner_p_3 | Corner_n_3 | Corner_s_3;      
    
    
 

      //Corner formation
    wire corner_p_4_print;
    reg signed [13:0]check_N_4;

reg signed [13:0]X_corner_4 = 1000;
reg signed [13:0]X_corner_4_mid = 2240;
reg signed [13:0]X_corner_4_n = 120;
reg signed [13:0]Pos_check_4;
wire Corner_p_4,Corner_n_4,Corner_s_4;

always @(*)
begin
check_N_4 <= y+(x>>>2);
Pos_check_4 <= y-(x>>>2);
end


always @(posedge clk_100MHz )
begin
if(shift_r)
begin
X_corner_4 <= X_corner_4 - 2;
X_corner_4_n <= X_corner_4_n + 2;
if(X_corner_4_mid >8)
X_corner_4_mid <= X_corner_4_mid - 8;
else
X_corner_4_mid <= 0;
end
else if(shift_l)
begin
X_corner_4 <= X_corner_4 + 2;
X_corner_4_n <= X_corner_4_n - 2;
if(X_corner_4_mid >8)
X_corner_4_mid <= X_corner_4_mid + 8;
else
X_corner_4_mid <= 0;
end
end
 
assign Corner_p_4 = ((check_N_4>0)&&(check_N_4>X_corner_4)&&(x<X_corner_4_mid)&&(y>440));
assign Corner_n_4 = ((Pos_check_4>0)&&(Pos_check_4>X_corner_4_n)&&(y>440)&&(x>X_corner_4_mid));
assign Corner_s_4 = ((x>=X_corner_4_mid-2)&&(x<X_corner_4_mid+1));
assign corner_p_4_print = Corner_p_4 | Corner_n_4 | Corner_s_4;


assign corner = corner_pos|corner_p_2os2|corner_p_3_print|corner_p_4_print;

     endmodule
                
                