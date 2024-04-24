Code.v 
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:33:45 04/24/2024 
// Design Name: 
// Module Name:    Code 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module lift_controller(
    input clk,
    input ground,
    input first,
    input second,
    input bottom,
    input middle_minus,
    input middle_plus,
    input top,
	output reg curr1,
    output reg curr2,
    output reg curr3,
    output reg up,
    output reg down,
    output reg idle,
    output reg motor_up,
	output reg motor_down
);

reg target1 = 0, target2 = 0, target3 = 0;

always @(posedge clk or posedge clk) begin

if(ground && !first && !second) begin
target1 <= 1;
target2 <= 0;
target3 <= 0;
end

else if(!ground && first && !second) begin
target1 <= 0;
target2 <= 1;
target3 <= 0;
end

else if(!ground && !first && second) begin
target1 <= 0;
target2 <= 0;
target3 <= 1;
end

else if(reset) begin
target1 <= 1;
target2 <= 0;
target3 <= 0;
end

if(top && !middle_minus && !middle_plus && !bottom) begin
curr1 <= 0;
curr2 <= 0;
curr3 <= 1;

if ( target1 == curr1  && target2 == curr2 && target3 == curr3) begin
 up <= 0;
 down <= 0;
 motor_up <= 0;
 motor_down <= 0;
 idle <= 1;
 end
 else begin
 down <= 1;
 motor_down <= 1;
 end
end

end  
 
if(!top && middle_minus && middle_plus && !bottom) begin
curr1 <= 0;
curr2 <= 1;
curr3 <= 0;

   if ( target1 == curr1  && target2 == curr2 && target3 == curr3) begin
 up <= 0;
 down <= 0;
 motor_up <= 0;
 motor_down <= 0;
 idle <= 1;
 end
 else if (target1)begin
 down <= 1;
 motor_down <= 1;
 end
 else if (target3) begin
 up <= 1;
 motor_up <= 1;
 end
 end
 
end

if(!top && !middle_minus && !middle_plus && bottom) begin
curr1 <= 1;
curr2 <= 0;
curr3 <= 0;

if ( target1 == curr1  && target2 == curr2 && target3 == curr3) begin
 up <= 0;
 down <= 0;
 motor_up <= 0;
 motor_down <= 0;
 idle <= 1;
 end
 else begin
 up <= 1;
 motor_up <= 1;
 end
 
 end
 
end 
endmodule