//control.v
//Huaqiang Wang (c) 2018

`include "define.v"

module control(
    input [31:0]inst,
    output jump_short,//1
    output jump_long,//1
    output jump_alu,//1
    output alu_a_src,//1
    output [3:0]alu_b_src,//4
    output [15:0] aluop,//16
    output [4:0]mem_wen_pick,//5
    output reg_a_valid,//1
    output reg_b_valid,//1
    output mem_read,//1
    output reg_write,//1
    output [15:0]reg_write_src,//16
    output [5:0]reg_write_tgt,//6
    output [3:0]mul_control,//4
    output beq,
    output bgez,
    output blez,
    output bltz,
    output bne,
    output bgtz,
    output bgezal,
    output bltzal,
    output r_type,
    output [4:0]regfile_waddr
    //54 bit in total
);

wire [5:0]opcode=inst[31:26];
wire [4:0]inst2016=inst[20:16];
wire [5:0]function_op=inst[5:0];

wire [4:0] rs=inst[25:21];
wire [4:0] rt=inst[20:16];
wire [4:0] rd=inst[15:11];

//decoder
//---------------------------------

wire beq_op= opcode==6'b000100;
wire bgez_op= (opcode==6'b000001)&(inst2016==5'b00001);
wire blez_op= (opcode==6'b000110)&(inst2016==5'b00000);
wire bltz_op= (opcode==6'b000001)&(inst2016==5'b00000);
wire bne_op= opcode==6'b000101;
wire bgtz_op= (opcode==6'b000111)&(inst2016==5'b00000);
wire bgezal_op= (opcode==6'b000001)&(inst2016==5'b10001);
wire bltzal_op= (opcode==6'b000001)&(inst2016==5'b10000);
wire addiu_op= opcode==6'b001001;
wire andi_op= opcode==6'b001100;
wire lb_op= opcode==6'b100000;
wire lbu_op= opcode==6'b100100;
wire lh_op= opcode==6'b100001;
wire lhu_op= opcode==6'b100101;
wire lui_op= opcode==6'b001111;
wire lw_op= opcode==6'b100011;
wire lwl_op= opcode==6'b100010;
wire lwr_op= opcode==6'b100110;
wire ori_op= opcode==6'b001101;
wire sb_op= opcode==6'b101000;
wire sh_op= opcode==6'b101001;
wire sw_op= opcode==6'b101011;
wire swl_op= opcode==6'b101010;
wire swr_op= opcode==6'b101110;
wire xori_op= opcode==6'b001110;
wire j_op= opcode==6'b000010;
wire jal_op= opcode==6'b000011;
wire slti_op= opcode==6'b001010;
wire sltiu_op= opcode==6'b001011;
wire addi_op= opcode==6'b001000;
wire eret_op= inst==32'b010000_1_000_0000_0000_0000_0000_011000;
wire mfc0_op= (opcode==6'b001000)&(rs==5'b00000)&(inst[10:3]==8'b0000000);
wire mtc0_op= (opcode==6'b001000)&(rs==5'b00100)&(inst[10:3]==8'b0000000);
wire r_op= opcode==6'b000000;

assign r_type=r_op;

wire addu_sop=r_type&(function_op==6'b100001)&(inst[10:6]==5'b00000);
wire and_sop=r_type&(function_op==6'b100100)&(inst[10:6]==5'b00000);
wire jalr_sop=r_type&(function_op==6'b001001)&(inst[20:16]==5'b00000)&(inst[10:6]==5'b00000);
wire jr_sop=r_type&(function_op==6'b001000)&(inst[20:11]==10'b00000_00000)&(inst[10:6]==5'b00000);
// wire movn_sop=r_type&(function_op==6'b001011);//not implemented
// wire movz_sop=r_type&(function_op==6'b001010);//not implemented
wire nor_sop=r_type&(function_op==6'b100111)&(inst[10:6]==5'b00000);
wire or_sop=r_type&(function_op==6'b100101)&(inst[10:6]==5'b00000);
wire sll_sop=r_type&(function_op==6'b000000)&(rs==5'b00000);
wire sllv_sop=r_type&(function_op==6'b000100)&(inst[10:6]==5'b00000);
wire slt_sop=r_type&(function_op==6'b101010)&(inst[10:6]==5'b00000);
wire sltu_sop=r_type&(function_op==6'b101011)&(inst[10:6]==5'b00000);
wire sra_sop=r_type&(function_op==6'b000011)&(rs==5'b00000);
wire srav_sop=r_type&(function_op==6'b000111)&(inst[10:6]==5'b00000);
wire srl_sop=r_type&(function_op==6'b000010)&(rs==5'b00000);
wire srlv_sop=r_type&(function_op==6'b000110)&(inst[10:6]==5'b00000);
wire subu_sop=r_type&(function_op==6'b100011)&(inst[10:6]==5'b00000);
wire xor_sop=r_type&(function_op==6'b100110)&(inst[10:6]==5'b00000);
wire add_sop=r_type&(function_op==6'b100000)&(inst[10:6]==5'b00000);
wire sub_sop=r_type&(function_op==6'b100010)&(inst[10:6]==5'b00000);
wire div_sop=r_type&(function_op==6'b011010)&(inst[15:6]==10'b00000_00000);
wire divu_sop=r_type&(function_op==6'b011011)&(inst[15:6]==10'b00000_00000);
wire mult_sop=r_type&(function_op==6'b011000)&(inst[15:6]==10'b00000_00000);
wire multu_sop=r_type&(function_op==6'b011001)&(inst[15:6]==10'b00000_00000);
wire mfhi_sop=r_type&(function_op==6'b010000)&(inst[25:16==10'b00000_00000])&(inst[10:6]==5'b00000);
wire mflo_sop=r_type&(function_op==6'b010010)&(inst[25:16==10'b00000_00000])&(inst[10:6]==5'b00000);
wire mthi_sop=r_type&(function_op==6'b010001)&(inst[20:6]==15'b000_0000_0000_0000);
wire mtlo_sop=r_type&(function_op==6'b010011)&(inst[20:6]==15'b000_0000_0000_0000);
wire break_sop=r_type&(function_op==6'b001101);
wire syscall_sop=r_type&(function_op==6'b001100);


// assign jump_short=
// beq_op&(A==B)|
// bgez_op&(!A[31])|
// blez_op&(A[31]|(A==0))|
// bltz_op&(A[31])|
// bne_op&(A!=B)|
// bgtz_op&((!A[31])&(A!=0))|
// bgezal_op&(!A[31])|
// bltzal_op&(A[31]);
assign beq=beq_op;
assign bgez=bgez_op;
assign blez=blez_op;
assign bltz=bltz_op;
assign bne=bne_op;
assign bgtz=bgtz_op;
assign bgezal=bgezal_op;
assign bltzal=bltzal_op;

//may not jump
assign jump_short=beq_op|bgez_op|blez_op|bltz_op|bne_op|bgtz_op|bgezal_op|bltzal_op;
assign jump_long=j_op|jal_op;
assign jump_alu=jalr_sop|jr_sop;

wire alu_b_src_immsigned=addiu_op|slti_op|sltiu_op|addi_op;

wire alu_b_src_a_immunsigned=andi_op|ori_op|xori_op|lui_op;

wire alu_b_src_PC_8=jal_op;
wire alu_b_src_reg=r_op|beq_op|bgez_op|blez_op|bltz_op|bne_op|bgtz_op|bgezal_op|bltzal_op|lb_op|lbu_op|lh_op|lhu_op|lw_op|lwl_op|lwr_op|sb_op|sh_op|sw_op|swl_op|swr_op;

assign alu_b_src[0]=alu_b_src_immsigned;
assign alu_b_src[1]=alu_b_src_a_immunsigned;
assign alu_b_src[2]=alu_b_src_PC_8;
assign alu_b_src[3]=alu_b_src_reg;


// assign aluop=

wire and_alu=andi_op|and_sop;
wire or_alu=ori_op|or_sop;
wire sub_alu=subu_sop|sub_sop;
wire slt_alu=slti_op|slt_sop;
wire xor_alu=xori_op|xor_sop;
wire nor_alu=nor_sop;
wire sltu_alu=sltiu_op|sltu_sop;
wire sll_alu=sll_sop|sllv_sop;
wire srl_alu=srl_sop|srlv_sop;
wire sra_alu=sra_sop|srav_sop;
wire lui_alu=lui_op;
wire a_alu=mthi_sop|mtlo_sop;
wire b_alu=jal_op|sb_op|sh_op|sw_op|swl_op|swr_op;
wire add_alu=add_sop|addu_sop|addiu_op|lb_op|lbu_op|lh_op|lhu_op|lw_op|lwl_op|lwr_op|sb_op|sh_op|sw_op|swl_op|swr_op|addi_op;

assign aluop[0] = and_alu;
assign aluop[1] = or_alu;
assign aluop[2] = add_alu;
assign aluop[3] = sub_alu;
assign aluop[4] = slt_alu;
assign aluop[5] = xor_alu;
assign aluop[6] = nor_alu;
assign aluop[7] = sltu_alu;
assign aluop[8] = sll_alu;
assign aluop[9] = srl_alu;
assign aluop[10] = sra_alu;
assign aluop[11] = lui_alu;
assign aluop[12] = a_alu;
assign aluop[13] = b_alu;

assign aluop[15:14]=0;//reserved


// output [4:0]mem_wen_pick,

 
assign mul_control= ({4{mult_sop}}&`mult_mc)|
                    ({4{multu_sop}}&`multu_mc)|
                    ({4{div_sop}}&`div_mc)|
                    ({4{divu_sop}}&`divu_mc);

assign mem_wen_pick[0]=sw_op;
assign mem_wen_pick[1]=sh_op;
assign mem_wen_pick[2]=sb_op;
assign mem_wen_pick[3]=swl_op;
assign mem_wen_pick[4]=swr_op;

assign mem_read=lb_op|lbu_op|lh_op|lhu_op|lw_op|lwl_op|lwr_op;

    // output [15:0]reg_write_src,

wire regw_fsrc_alu=lui_op|xori_op|sltiu_op|slti_op|ori_op|andi_op|addiu_op|addi_op|addu_sop|and_sop|nor_sop|or_sop|slt_sop|sltu_sop|subu_sop|xor_sop|add_sop|sub_sop|sll_sop|sllv_sop|sra_sop|srav_sop|srl_sop|srlv_sop|mthi_sop|mtlo_sop;
wire regw_fsrc_pc=jal_op|bgezal_op|bltzal_op|jalr_sop;
// wire regw_fsrc_rs=movn_sop|movz_sop;
wire regw_fsrc_rs=1'b0;
wire regw_fsrc_hi=mfhi_sop;
wire regw_fsrc_lo=mflo_sop;
// assign regw_fsrc_imm16=lui;
wire regw_fsrc_imm16=0;//changed into lui
wire regw_fsrc_pc8=0;
wire regw_fsrc_memb=lb_op;
wire regw_fsrc_membu=lbu_op;
wire regw_fsrc_memh=lh_op;
wire regw_fsrc_memhu=lhu_op;
wire regw_fsrc_meml=lwl_op;
wire regw_fsrc_memr=lwr_op;
wire regw_fsrc_mem=lw_op;
wire regw_fsrc_lui=0;//use alu instead. so we can do bypass on lui


assign reg_write_src[0]= regw_fsrc_alu;
assign reg_write_src[1]= regw_fsrc_pc;
assign reg_write_src[2]= regw_fsrc_rs;
assign reg_write_src[3]= regw_fsrc_hi;
assign reg_write_src[4]= regw_fsrc_lo;
assign reg_write_src[5]= regw_fsrc_imm16;
assign reg_write_src[6]= regw_fsrc_pc8;
assign reg_write_src[7]= regw_fsrc_memb;
assign reg_write_src[8]= regw_fsrc_membu;
assign reg_write_src[9]= regw_fsrc_memh;
assign reg_write_src[10]= regw_fsrc_memhu;
assign reg_write_src[11]= regw_fsrc_meml;
assign reg_write_src[12]= regw_fsrc_memr;
assign reg_write_src[13]= regw_fsrc_mem;
assign reg_write_src[14]= regw_fsrc_lui;
assign reg_write_src[15]=1'b0;

// output [3:0]reg_write_tgt
wire regw_ftgt_rd=addu_sop|and_sop|jalr_sop|nor_sop|or_sop|sll_sop|sllv_sop|slt_sop|sltu_sop|sra_sop|srav_sop|srl_sop|srlv_sop|subu_sop|xor_sop|add_sop|sub_sop|mfhi_sop|mflo_sop;
wire regw_ftgt_hi=mthi_sop;
wire regw_ftgt_lo=mtlo_sop;
wire regw_ftgt_nop=jr_sop;
wire regw_ftgt_rt=mfc0_op|lwr_op|lwl_op|lh_op|lhu_op|lbu_op|lb_op|lw_op|lui_op|xori_op|sltiu_op|slti_op|ori_op|addi_op|andi_op|addiu_op;
wire regw_ftgt_31=bgezal_op|bltzal_op|jal_op;

assign reg_write_tgt[0]= regw_ftgt_rd;
assign reg_write_tgt[1]= regw_ftgt_hi;
assign reg_write_tgt[2]= regw_ftgt_lo;
assign reg_write_tgt[3]= regw_ftgt_nop;
assign reg_write_tgt[4]= regw_ftgt_rt;
assign reg_write_tgt[5]= regw_ftgt_31;

// assign reg_write=xori_op|lui_op|sltiu_op|slti_op|ori_op|jal_op|andi_op|addiu_op|lb_op|lbu_op|lh_op|lhu_op|lw_op|lwl_op|lwr_op|addi_op|r_op|bgezal_op|bltzal_op;
assign reg_write=regw_ftgt_rd|regw_ftgt_rt|regw_ftgt_31|mfc0_op;

assign alu_a_src = sll_sop|sra_sop|srl_sop;

assign reg_a_valid=//rs
    xori_op|sltiu_op|slti_op|ori_op|andi_op|addiu_op|lb_op|lbu_op|lh_op|lhu_op|lw_op|lwl_op|lwr_op|addi_op|sb_op|sh_op|sw_op|swl_op|swr_op|beq_op|bgez_op|blez_op|bltz_op|bne_op|bgezal_op|bltzal_op|bgtz_op|r_op
    |addu_sop|and_sop|jalr_sop|jr_sop|nor_sop|or_sop|sllv_sop|slt_sop|sltu_sop|srav_sop|srlv_sop|subu_sop|xor_sop|add_sop|sub_sop|div_sop|divu_sop|mult_sop|multu_sop|mthi_sop|mtlo_sop;

assign reg_b_valid=//rt
    beq_op|bne_op|lwl_op|lwr_op|sw_op|swl_op|swr_op|sb_op|sh_op|r_op|
    addu_sop|and_sop|nor_sop|or_sop|sllv_sop|slt_sop|sltu_sop|srav_sop|srlv_sop|subu_sop|xor_sop|add_sop|sll_sop|sra_sop|srl_sop|sub_sop|div_sop|divu_sop|mult_sop|multu_sop|
    mtc0_op;//Exception

assign regfile_waddr=
    ({5{reg_write_tgt[0]}}&rd)|
    ({5{reg_write_tgt[4]}}&rt)|
    ({5{reg_write_tgt[5]}}&5'd31);

wire mem_write=
    mem_wen_pick!=0;

//Exception
wire set_CP0=mtc0_op;
wire read_CP0=mfc0_op;
wire [4:0]addr_CP0=rd;
wire overflow_exception=add_sop|addi_op|sub_sop;

// deal in EX
// wire exception_int;//1

// deal in ID, outof control
// wire [31:0]badaddr;//32
// wire exception_fetch;//1
// wire exception_data;//1
wire exception_reserved=
    (!beq_op)&(!bgez_op)&(!blez_op)&(!bltz_op)&(!bne_op)&(!bgtz_op)&(!bgezal_op)&(!bltzal_op)&(!addiu_op)&(!andi_op)&(!lb_op)&(!lbu_op)&(!lh_op)&(!lhu_op)&(!lui_op)&
    (!lw_op)&(!lwl_op)&(!lwr_op)&(!ori_op)&(!sb_op)&(!sh_op)&(!sw_op)&(!swl_op)&(!swr_op)&(!xori_op)&(!j_op)&(!jal_op)&(!slti_op)&(!sltiu_op)&(!addi_op)&
    (!eret_op)&(!mfc0_op)&(!mtc0_op)&(!addu_sop)&(!and_sop)&(!jalr_sop)&(!jr_sop)&(!nor_sop)&(!or_sop)&(!sll_sop)&(!sllv_sop)&(!slt_sop)&(!sltu_sop)&(!sra_sop)&(!srav_sop)&
    (!srl_sop)&(!srlv_sop)&(!subu_sop)&(!xor_sop)&(!add_sop)&(!sub_sop)&(!div_sop)&(!divu_sop)&(!mult_sop)&(!multu_sop)&(!mfhi_sop)&(!mflo_sop)&(!mthi_sop)&(!mtlo_sop)&(!break_sop)&(!syscall_sop)
;
wire exception_instruction=syscall_sop|break_sop|eret_op;//1
// wire AdEL;
// wire AdES;
wire Sys=syscall_sop;
wire Bp=break_sop;
wire RI;
// wire OV;

//IF
wire BD;//1
wire eret=eret_op;//1

endmodule