module rotate_z(
    input clk_100MHz,       // Basys 3 oscillator
    input wire signed [9:0] x_pt,      // from VGA controller
    input wire signed [9:0] y_pt,      // from VGA controller
    input [2:0] angle_val,   
    output reg signed [9:0] rotated_x,   
    output reg signed [9:0] rotated_y
    );

    always @(posedge clk_100MHz)
    if(angle_val == 1)
    begin
    rotated_x <= x_pt - (x_pt >>> 5)- (y_pt >>> 2) - (y_pt >>> 7);
    rotated_y <= (x_pt>>>2) + (x_pt >>> 7) + y_pt - (y_pt >>> 5);
    end
    else if(angle_val == 3)
    begin
    rotated_x <= x_pt - (x_pt >>> 5)+ (y_pt >>> 2) + (y_pt >>> 7);
    rotated_y <= y_pt - (y_pt >>> 5)- (x_pt >>>2) - (x_pt >>> 7);
    end
    

    endmodule
    