`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/15/2022 12:04:49 PM
// Design Name: 
// Module Name: mult_fsm
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: top module
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module mult_fsm(
    input [3:0] mult_b,
    input mult_enter,
    input mult_clk,
    output logic [1:0] mult_sr_sel,
    output logic mult_acc_ld, mult_acc_clr
    );
    
    parameter [2:0] hold=3'b000, start=3'b001, bit0=3'b010, bit1=3'b011, bit2=3'b100, bit3=3'b101;
    
    logic [2:0] NS;
    logic [2:0] PS = hold;
    
    always_ff @ (posedge mult_clk)
        PS <= NS;
    
    always_comb
        begin
            mult_sr_sel = 0;
            mult_acc_ld = 0;
            mult_acc_clr = 0;
        case (PS)
            hold:
                begin
                mult_sr_sel = 0;
                mult_acc_ld = 0;
                mult_acc_clr = 0;
                if (mult_enter != 1)
                    begin
                    NS = hold;
                    end
                else
                    begin
                    NS = start;
                    end
                end
                
             start:
                begin
                mult_sr_sel = 1;
                mult_acc_ld = 0;
                mult_acc_clr = 1;
                
                NS = bit0;
                end
                
            bit0:
                begin
                mult_sr_sel = 2;
                mult_acc_clr = 0;
                if ((mult_b[0] == 1 && mult_acc_ld == 1)
                    && (mult_b[0] == 0 && mult_acc_ld == 0))
                    begin
                    NS = bit1;
                    end
                else
                    begin
                    NS = hold;
                    end
                end
                    
            bit1:
                begin
                mult_sr_sel = 3;
                mult_acc_clr = 0;
                if ((mult_b[1] == 1 && mult_acc_ld == 1)
                    && (mult_b[1] == 0 && mult_acc_ld == 0))
                    begin
                    NS = bit2;
                    end
                else
                    begin
                    NS = hold;
                    end
                end
                
            bit2:
                begin
                mult_sr_sel = 4;
                mult_acc_clr = 0;
                if ((mult_b[2] == 1 && mult_acc_ld == 1)
                    && (mult_b[2] == 0 && mult_acc_ld == 0))
                    begin
                    NS = bit3;
                    end
                else
                    begin
                    NS = hold;
                    end
                end
            
            bit3:
                begin
                mult_acc_clr = 1;
                mult_acc_ld = 1;
                if ((mult_b[3] == 1 && mult_acc_ld == 1)
                    && (mult_b[3] == 0 && mult_acc_ld == 0))
                    begin
                    NS = hold;
                    end
                else
                    begin
                    NS = hold;
                    end
                end
                         
            default: 
                NS = hold;
            endcase
    end    
endmodule
