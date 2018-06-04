// extender.v

//extender and merger
//modify data output by memory

`include"define.v"

module extender(
    input[12:0]extender_control,
    input [31:0]mem_input,//from mem
    input [31:0]reg_input,//from reg
    input [15:0]ins_input,//from ins
    input [1:0]ea,
    output reg[31:0] extender_output,
    output reg[3:0] strb
);

    always@*
    begin
      case(extender_control)
        `lw:
        begin
            extender_output=mem_input;
            strb=4'b1111;
        end  

        `lb:
        begin
            strb=4'b1111;
            case(ea)
                2'b00:
                begin
                    extender_output=mem_input[7]?{24'b111111_111111_111111_111111,mem_input[7:0]}:{24'b0,mem_input[7:0]};
                end
                2'b01:
                begin
                    extender_output=mem_input[15]?{24'b111111_111111_111111_111111,mem_input[15:8]}:{24'b0,mem_input[15:8]};                    
                end
                2'b10:
                begin
                    extender_output=mem_input[23]?{24'b111111_111111_111111_111111,mem_input[23:16]}:{24'b0,mem_input[23:16]};                    
                end
                2'b11:
                begin
                    extender_output=mem_input[31]?{24'b111111_111111_111111_111111,mem_input[31:24]}:{24'b0,mem_input[31:24]};                    
                end
                default:
                begin
                    extender_output=mem_input[31]?{24'b111111_111111_111111_111111,mem_input[31:24]}:{24'b0,mem_input[31:24]};                    
                end

            endcase
        end

        `lh:
        begin
            strb=4'b1111;
            case(ea[1])
                1'b0:
                begin
                    extender_output=mem_input[15]?{16'b11111111_11111111,mem_input[15:0]}:{16'b0,mem_input[15:0]};
                end
                1'b1:
                begin
                    extender_output=mem_input[15]?{16'b11111111_11111111,mem_input[31:16]}:{16'b0,mem_input[31:16]};                    
                end
                default:
                begin
                    extender_output=mem_input[15]?{16'b11111111_11111111,mem_input[31:16]}:{16'b0,mem_input[31:16]};                    
                end
            endcase
        end
            
            // extender_output=(mem_input[7]?
            // {24'b1111_1111_1111_1111_1111_1111,mem_input[7:0]}:            
            // {24'b0000_0000_0000_0000_0000_0000,mem_input[7:0]});
        
            // extender_output=mem_input[7:0];        

        `lbu:
        begin
            strb=4'b1111;
            case(ea)
                2'b00:
                begin
                    extender_output={24'b0,mem_input[7:0]};
                end
                2'b01:
                begin
                    extender_output={24'b0,mem_input[15:8]};
                end
                2'b10:
                begin
                    extender_output={24'b0,mem_input[23:16]};
                end
                2'b11:
                begin
                    extender_output={24'b0,mem_input[31:24]};
                end
                default:
                begin
                    extender_output={24'b0,mem_input[31:24]};
                end
            endcase
            // extender_output={24'b0000_0000_0000_0000_0000_0000,mem_input[7:0]};
        end

        `lhu:
        begin
            strb=4'b1111;
            case(ea[1])
                1'b0:
                begin
                    extender_output={16'b0,mem_input[15:0]};
                end
                1'b1:
                begin
                    extender_output={16'b0,mem_input[31:16]};
                end
                default:
                begin
                    extender_output={16'b0,mem_input[31:16]};
                end
            endcase
            // extender_output={24'b0000_0000_0000_0000_0000_0000,mem_input[7:0]};
        end

        `lwl:
        begin
            strb=4'b1111;
            
            case(ea)
                2'b00:
                begin
                    extender_output={mem_input[7:0],reg_input[23:0]};
                end
                2'b01:
                begin
                    extender_output={mem_input[15:0],reg_input[15:0]};                    
                end
                2'b10:
                begin
                    extender_output={mem_input[23:0],reg_input[7:0]};                
                end
                2'b11:
                begin
                    extender_output={mem_input[31:0]};                
                end
                default:
                begin
                    extender_output={mem_input[31:0]};                
                end
            endcase
        end

        `lwr:
        begin
            strb=4'b1111;
            
            case(ea)
                2'b00:
                begin
                    extender_output={mem_input[31:0]};
                end
                2'b01:
                begin
                    extender_output={reg_input[31:24],mem_input[31:8]};
                end
                2'b10:
                begin
                    extender_output={reg_input[31:16],mem_input[31:16]};
                end
                2'b11:
                begin
                    extender_output={reg_input[31:8],mem_input[31:24]};
                end
                default:
                begin
                    extender_output={reg_input[31:8],mem_input[31:24]};
                end
            endcase    
        end

        `swl:
        begin        
            case(ea)
                2'b00:
                begin
                    extender_output={24'b0,reg_input[31:24]};
                    strb=4'b0001;
                end
                2'b01:
                begin
                    extender_output={16'b0,reg_input[31:16]};
                    strb=4'b0011;
                end
                2'b10:
                begin
                    extender_output={8'b0,reg_input[31:8]};
                    strb=4'b0111;
                end
                2'b11:
                begin
                    extender_output={reg_input[31:0]};
                    strb=4'b1111;
                end
                default:
                begin
                    extender_output={reg_input[31:0]};
                    strb=4'b1111;
                end
            endcase
        end
        
        `swr:
        begin        
            case(ea)
                2'b00:
                begin
                    extender_output={reg_input[31:0]};
                    strb=4'b1111;
                end
                2'b01:
                begin
                    extender_output={reg_input[23:0],8'b0};
                    strb=4'b1110;
                end
                2'b10:
                begin
                    extender_output={reg_input[15:0],16'b0};
                    strb=4'b1100;
                end
                2'b11:
                begin
                    extender_output={reg_input[7:0],24'b0};
                    strb=4'b1000;
                end
                default:
                begin
                    extender_output={reg_input[7:0],24'b0};
                    strb=4'b1000;
                end
            endcase
        end

        `sb:
        begin   
            case(ea)
                2'b00:
                begin
                    strb=4'b0001;
                    extender_output={24'b0,reg_input[7:0]};
                end
                2'b01:
                begin
                    strb=4'b0010;
                    extender_output={16'b0,reg_input[7:0],8'b0};
                end
                2'b10:
                begin
                    strb=4'b0100;
                    extender_output={8'b0,reg_input[7:0],16'b0};
                end
                2'b11:
                begin
                    strb=4'b1000;
                    extender_output={reg_input[7:0],24'b0};
                end
                default:
                begin
                    strb=4'b1000;
                    extender_output={reg_input[7:0],24'b0};
                end
            endcase
        end

        `sh:
        begin   
            case(ea[1])
                1'b1:
                begin
                    strb=4'b1100;
                    extender_output={reg_input[15:0],16'b0};
                end
                1'b0:
                begin
                    strb=4'b0011;
                    extender_output={16'b0,reg_input[15:0]};
                end
                default:
                begin
                    strb=4'b0011;
                    extender_output={16'b0,reg_input[15:0]};
                end
            endcase
        end

        `sw:
        begin 
            strb=4'b1111;
            extender_output={reg_input};
        end

        `lui:
        begin
            strb=4'b0000;
            extender_output={ins_input,16'b0};
        end

        default:
        begin
            extender_output=mem_input;
            strb=4'b1111;
        end        

      endcase


    end

endmodule
