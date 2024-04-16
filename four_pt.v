module four_pt(
    input clk_100MHz,       // Basy_pts 3 oscillator
    input video_on_pt,
    input [9:0] x_pt,      // from VGA controller
    input [9:0] y_pt,      // from VGA controller
    input enable_dots,
    input shift_pt,
    input shift_l,    
    output dots  // to VGA port
);

    reg signed [9:0]x_pt0_coordinate = -50;//bottom left
    reg signed [9:0]y_pt0_coordinate = -50;
    reg signed [9:0]x_pt1_coordinate = 50;//bottom right
    reg signed [9:0]y_pt1_coordinate = -50;
    reg signed [9:0]x_pt2_coordinate = -50;//top left
    reg signed [9:0]y_pt2_coordinate = 50;
    reg signed [9:0]x_pt3_coordinate = 50;//top right
    reg signed [9:0]y_pt3_coordinate = 50;
    
    reg signed [9:0]z_pt0_coordinate = 0;
    reg signed [9:0]z_pt1_coordinate = 0;
    reg signed [9:0]z_pt2_coordinate = 0;
    reg signed [9:0]z_pt3_coordinate = 0;

    
    reg signed [9:0]x_out_pt4_coordinate = 190;//bottom left
    reg signed [9:0]y_out_pt4_coordinate = 270;
    reg signed [9:0]x_out_pt0_coordinate = 190;//bottom left
    reg signed [9:0]y_out_pt0_coordinate = 270;
    reg signed [9:0]x_out_pt1_coordinate = 290;//bottom right
    reg signed [9:0]y_out_pt1_coordinate = 270;
    reg signed [9:0]x_out_pt2_coordinate = 190;//top left
    reg signed [9:0]y_out_pt2_coordinate = 370;
    reg signed [9:0]x_out_pt3_coordinate = 290;//top right
    reg signed [9:0]y_out_pt3_coordinate = 370;
    
    
    //Given to roatate
    reg signed [9:0]x_in_pt0_coordinate;//bottom left
    reg signed [9:0]y_in_pt0_coordinate;
    reg signed [9:0]x_in_pt1_coordinate;//bottom right
    reg signed [9:0]y_in_pt1_coordinate;
    reg signed [9:0]x_in_pt2_coordinate;//top left
    reg signed [9:0]y_in_pt2_coordinate;
    reg signed [9:0]x_in_pt3_coordinate;//top right
    reg signed [9:0]y_in_pt3_coordinate;
    reg signed [9:0]x_in_pt4_coordinate;//top right
    reg signed [9:0]y_in_pt4_coordinate;
 
     
    reg signed [9:0]z_in_pt0_coordinate = 0;
    reg signed [9:0]z_in_pt1_coordinate = 0;
    reg signed [9:0]z_in_pt2_coordinate = 0;
    reg signed [9:0]z_in_pt3_coordinate = 0;
    
    
    wire signed [9:0]x0_coordinate;
    wire signed [9:0]y0_coordinate;
    wire signed [9:0]x1_coordinate;
    wire signed [9:0]y1_coordinate;
    wire signed [9:0]x2_coordinate;
    wire signed [9:0]y2_coordinate;
    wire signed [9:0]x3_coordinate;
    wire signed [9:0]y3_coordinate;

    reg signed [9:0]z0_coordinate = 0;
    reg signed [9:0]z1_coordinate = 0;
    reg signed [9:0]z2_coordinate = 0;
    reg signed [9:0]z3_coordinate = 0;


    reg [2:0] angle_z = 0; // Corresponds to deg_15 parameter
    
    rotate_z pt0(
        .clk_100MHz(clk_100MHz),
        .x_pt(x_in_pt0_coordinate),
        .y_pt(y_in_pt0_coordinate),
        .angle_val(angle_z),
        .rotated_x(x0_coordinate),
        .rotated_y(y0_coordinate)
    );

    rotate_z pt1(
        .clk_100MHz(clk_100MHz),
        .x_pt(x_in_pt1_coordinate),
        .y_pt(y_in_pt1_coordinate),
        .angle_val(angle_z),
        .rotated_x(x1_coordinate),
        .rotated_y(y1_coordinate)
    );

    rotate_z pt2(
        .clk_100MHz(clk_100MHz),
        .x_pt(x_in_pt2_coordinate),
        .y_pt(y_in_pt2_coordinate),
        .angle_val(angle_z),
        .rotated_x(x2_coordinate),
        .rotated_y(y2_coordinate)
    );

    rotate_z pt3(
        .clk_100MHz(clk_100MHz),
        .x_pt(x_in_pt3_coordinate),
        .y_pt(y_in_pt3_coordinate),
        .angle_val(angle_z),
        .rotated_x(x3_coordinate),
        .rotated_y(y3_coordinate)
    );






always @ (posedge clk_100MHz) begin
    if (shift_pt) begin
            angle_z<=1;
            x_in_pt0_coordinate <= x_pt0_coordinate;
            x_in_pt1_coordinate <= x_pt1_coordinate;
            x_in_pt2_coordinate <= x_pt2_coordinate;
            x_in_pt3_coordinate <= x_pt3_coordinate;
            y_in_pt0_coordinate <= y_pt0_coordinate;
            y_in_pt1_coordinate <= y_pt1_coordinate;
            y_in_pt2_coordinate <= y_pt2_coordinate;
            y_in_pt3_coordinate <= y_pt3_coordinate;

    end
    else if (shift_l) begin
            angle_z<=3;
            x_in_pt0_coordinate <= x_pt0_coordinate;
            x_in_pt1_coordinate <= x_pt1_coordinate;
            x_in_pt2_coordinate <= x_pt2_coordinate;
            x_in_pt3_coordinate <= x_pt3_coordinate;
            y_in_pt0_coordinate <= y_pt0_coordinate;
            y_in_pt1_coordinate <= y_pt1_coordinate;
            y_in_pt2_coordinate <= y_pt2_coordinate;
            y_in_pt3_coordinate <= y_pt3_coordinate;

    end
    
    else angle_z<=0;
end

   always @(*)
   begin

            
            // Update output coordinates with offset
        if(angle_z > 0)   begin 
        
                       // Update input coordinates for rotation

            x_pt0_coordinate <= x0_coordinate;
            y_pt0_coordinate <= y0_coordinate;
            x_pt1_coordinate <= x1_coordinate;
            y_pt1_coordinate <= y1_coordinate;
            x_pt2_coordinate <= x2_coordinate;
            y_pt2_coordinate <= y2_coordinate;
            x_pt3_coordinate <= x3_coordinate;
            y_pt3_coordinate <= y3_coordinate;

            x_out_pt0_coordinate <= x0_coordinate + 320;
            y_out_pt0_coordinate <= y0_coordinate + 240;
            x_out_pt1_coordinate <= x1_coordinate + 320;
            y_out_pt1_coordinate <= y1_coordinate + 240;
            x_out_pt2_coordinate <= x2_coordinate + 320;
            y_out_pt2_coordinate <= y2_coordinate + 240;
            x_out_pt3_coordinate <= x3_coordinate + 320;
            y_out_pt3_coordinate <= y3_coordinate + 240;
            end
   end
    
   
    
    // RGB Color Values        
    parameter RED    = 12'h00F;
    parameter YELLOW = 12'h5FF;
    parameter BLACK  = 12'h000;

    wire dot0, dot1, dot2, dot3;
    assign dot0 = ((x_pt >= (x_out_pt0_coordinate - 1)) && (x_pt < (x_out_pt0_coordinate + 1)) && (y_pt >= (y_out_pt0_coordinate - 1)) && (y_pt < (y_out_pt0_coordinate + 1)));
    assign dot1 = ((x_pt >= (x_out_pt1_coordinate - 1)) && (x_pt < (x_out_pt1_coordinate + 1)) && (y_pt >= (y_out_pt1_coordinate - 1)) && (y_pt < (y_out_pt1_coordinate + 1)));
    assign dot2 = ((x_pt >= (x_out_pt2_coordinate - 1)) && (x_pt < (x_out_pt2_coordinate + 1)) && (y_pt >= (y_out_pt2_coordinate - 1)) && (y_pt < (y_out_pt2_coordinate + 1)));
    assign dot3 = ((x_pt >= (x_out_pt3_coordinate - 1)) && (x_pt < (x_out_pt3_coordinate + 1)) && (y_pt >= (y_out_pt3_coordinate - 1)) && (y_pt < (y_out_pt3_coordinate + 1)));
   

   
   
   
    assign dots = (enable_dots) ? 0 : dot0 | dot1 | dot2 | dot3 ;


//    always @* begin
//        if (~video_on_pt)
//            rgb_pt = BLACK;
//        else if (dots)
//            rgb_pt = RED;
//        else
//            rgb_pt = YELLOW;
//    end

endmodule
