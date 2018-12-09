//exception.v
//Huaqiang Wang (c) 2018
`include "cp0def.v"
module exception_pipe_reg(

);
    wire set_CP0;//1
    wire read_CP0;//1
    wire [4:0]addr_CP0;//5
    wire [31:0]badaddr;//32
    wire exception_int;//1
    wire exception_fetch;//1
    wire exception_reserved;//1
    wire exception_instruction;//1
    // wire exception_overflow;//1
    // wire exception_trap;//1
    // wire exception_syscall;//1
    // wire overflow_exception;//1
    wire exception_data;//1
    wire AdEL;
    wire AdES;
    wire Sys;
    wire Bp;
    wire RI;
    wire OV;
    wire BD;//1
    wire eret;//1
    wire [4:0]ExcCode;
    wire detect_OF;

    reg [63:0]data;
    assign {
        set_CP0,//1
        read_CP0,//1
        addr_CP0,//5
        badaddr,//32
        exception_int,//1
        exception_fetch,//1
        exception_reserved,//1
        exception_instruction,//1
        exception_data,//1
        AdEL,
        AdES,
        Sys,
        Bp,
        RI,
        OV,
        BD,//1
        eret,//1
        ExcCode,
        detect_OF
    }=data;
endmodule

module exception_pass(
    input clk,
    input resetn,
    input [31:0]CP0_wdata,
    input [31:0]MEM_PC,
    input [7:0]IP,
    output [31:0]CP0_rdata,
    input mem_valid
);

//IF------------------------------------------------
// exception_pipe_reg IF_ID_exception_pipe_reg();
//ID------------------------------------------------
exception_pipe_reg ID_EX_exception_pipe_reg();
//EX------------------------------------------------
exception_pipe_reg EX_MEM_exception_pipe_reg();
//MEM-----------------------------------------------

//INT
reg TI;//time int

wire ERET=EX_MEM_exception_pipe_reg.eret;

wire IP7;
wire IP6;
wire IP5;
wire IP4;
wire IP3;
wire IP2;
reg IP1;
reg IP0;

assign {IP7,IP6,IP5,IP4,IP3,IP2}=IP[7:2];

reg IM7;
reg IM6;
reg IM5;
reg IM4;
reg IM3;
reg IM2;
reg IM1;
reg IM0;

wire HW5=(IP7|TI)&IM7;
wire HW4=IP6&IM6;
wire HW3=IP5&IM5;
wire HW2=IP4&IM4;
wire HW1=IP3&IM3;
wire HW0=IP2&IM2;
wire SW1=IP1&IM1;
wire SW0=IP0&IM0;


//CP0
wire [31:0]CP0_Status;
wire [31:0]CP0_Cause;
reg [31:0]CP0_BadVaddr;
reg [31:0]CP0_EPC;
reg [31:0]CP0_Count;
reg [31:0]CP0_Compare;

//MTC0
wire Status_wen=EX_MEM_exception_pipe_reg.set_CP0&(EX_MEM_exception_pipe_reg.addr_CP0==`CP0_STATUS);
wire BadVaddr_wen=1'b0;//Software write disabled.
wire Cause_wen=EX_MEM_exception_pipe_reg.set_CP0&(EX_MEM_exception_pipe_reg.addr_CP0==`CP0_CAUSE);
wire EPC_wen=EX_MEM_exception_pipe_reg.set_CP0&(EX_MEM_exception_pipe_reg.addr_CP0==`CP0_EPC);
wire Count_wen=EX_MEM_exception_pipe_reg.set_CP0&(EX_MEM_exception_pipe_reg.addr_CP0==`CP0_COUNT);
wire Compare_wen=EX_MEM_exception_pipe_reg.set_CP0&(EX_MEM_exception_pipe_reg.addr_CP0==`CP0_COMPARE);

//EXCEPTION
wire have_exception=(exception_int|exception_fetch|exception_reserved|exception_instruction|exception_data)&mem_valid;
wire exception_int=(HW5|HW4|HW3|HW2|HW1|HW0|SW1|SW0)&(!EXL)&EX_MEM_exception_pipe_reg.exception_int;
wire int_detect=(HW5|HW4|HW3|HW2|HW1|HW0|SW1|SW0);//for ID to setup exception_int
wire exception_fetch=
    EX_MEM_exception_pipe_reg.exception_fetch&
    (!exception_int);
wire exception_reserved=
    EX_MEM_exception_pipe_reg.exception_reserved&
    (!exception_fetch)&
    (!exception_int);
wire exception_instruction=
    EX_MEM_exception_pipe_reg.exception_instruction&
    (!exception_reserved)&
    (!exception_fetch)&
    (!exception_int);
// Which contains:
// wire exception_overflow;
// wire exception_trap;
// wire exception_syscall;
wire exception_data=
    EX_MEM_exception_pipe_reg.exception_data&
    (!exception_instruction)&
    (!exception_reserved)&
    (!exception_fetch)&
    (!exception_int);

wire [31:0]Status_wdata=CP0_wdata;
wire [31:0]BadVaddr_wdata=CP0_wdata;
wire [31:0]Cause_wdata=CP0_wdata;
wire [31:0]EPC_wdata=CP0_wdata;
wire [31:0]Count_wdata=CP0_wdata;
wire [31:0]Compare_wdata=CP0_wdata;

//clear_pipeline
wire clear_pipeline=have_exception|ERET;
wire [31:0]clear_pipeline_PC=ERET?CP0_EPC:32'hBFC00380;


//CP0_Status
wire BEV=1'b1;
reg EXL;
reg IE;
assign CP0_Status[31:23]=9'b0;
assign CP0_Status[22]=BEV;
assign CP0_Status[21:16]=6'b0;
assign CP0_Status[15]=IM7;
assign CP0_Status[14]=IM6;
assign CP0_Status[13]=IM5;
assign CP0_Status[12]=IM4;
assign CP0_Status[11]=IM3;
assign CP0_Status[10]=IM2;
assign CP0_Status[9]=IM1;
assign CP0_Status[8]=IM0;
assign CP0_Status[7:2]=6'b0;
assign CP0_Status[1]=EXL;
assign CP0_Status[0]=IE;

wire set_status=EX_MEM_exception_pipe_reg.set_CP0&&(EX_MEM_exception_pipe_reg.addr_CP0==`CP0_STATUS);

//TODO
always@(posedge clk)begin
    if(!resetn)begin
        EXL<=1'b0;
    end else
    if(have_exception)begin
        EXL<=1'b1;
    end else
    if(ERET)begin
        EXL<=1'b0;
    end
    if(set_status)begin
        EXL<=CP0_wdata[1];
    end
end

always@(posedge clk)begin
    if(!resetn)begin
        IE<=1'b0;
        IM7<=1'b0;
        IM6<=1'b0;
        IM5<=1'b0;
        IM4<=1'b0;
        IM3<=1'b0;
        IM2<=1'b0;
        IM1<=1'b0;
        IM0<=1'b0;
    end else
    if(set_status)begin
        IE<= CP0_wdata[0];
        IM7<=CP0_wdata[15];
        IM6<=CP0_wdata[14];
        IM5<=CP0_wdata[13];
        IM4<=CP0_wdata[12];
        IM3<=CP0_wdata[11];
        IM2<=CP0_wdata[10];
        IM1<=CP0_wdata[9];
        IM0<=CP0_wdata[8];
    end
end

//CP0_Count
wire set_compare=EX_MEM_exception_pipe_reg.set_CP0&&(EX_MEM_exception_pipe_reg.addr_CP0==`CP0_COMPARE);
wire set_count=EX_MEM_exception_pipe_reg.set_CP0&&(EX_MEM_exception_pipe_reg.addr_CP0==`CP0_COUNT);
reg time_flip;

always@(posedge clk)begin
    if(!resetn)begin
        time_flip<=1'b0;
    end else 
    begin
        time_flip<=~time_flip;
    end
end

always@(posedge clk)begin
    if(!resetn)begin
        CP0_Count<=32'b0;
    end else 
    begin
        CP0_Count<=
            {32{set_compare}}&32'b0|
            {32{set_count}}&CP0_wdata|
            {32{(!set_compare)&(!set_count)}}&(time_flip?CP0_Count:CP0_Count+1'b1);
    end
end

//CP0_Compare
always@(posedge clk)begin
    if(!resetn)begin
        CP0_Compare<=32'b0;
    end else 
    if(set_compare)
    begin
        CP0_Compare<=CP0_wdata;
    end
end

//CP0_BadVaddr
always@(posedge clk)begin
    if(!resetn)begin
        CP0_BadVaddr<=32'b0;
    end else begin
        CP0_BadVaddr<=(exception_fetch|exception_data)?EX_MEM_exception_pipe_reg.badaddr:CP0_BadVaddr;
    end
end

//CP0_Cause
wire [4:0]ExcCode_gen=
    exception_int?5'h00:(
    {5{EX_MEM_exception_pipe_reg.AdEL}}&5'h04|
    {5{EX_MEM_exception_pipe_reg.AdES}}&5'h05|
    {5{EX_MEM_exception_pipe_reg.Sys}}&5'h08|
    {5{EX_MEM_exception_pipe_reg.Bp}}&5'h09|
    {5{EX_MEM_exception_pipe_reg.RI}}&5'h0a|
    {5{EX_MEM_exception_pipe_reg.OV}}&5'h0c);
reg [4:0]ExcCode;

always@(posedge clk)begin
    if(!resetn)begin
            ExcCode<=5'b0;
    end else begin
        if(have_exception)begin
            ExcCode<=ExcCode_gen;
        end
    end
end


// wire BD=EX_MEM_exception_pipe_reg.BD;
reg BD;
assign CP0_Cause[31]=BD;
assign CP0_Cause[30]=TI&IM7;//TODO: TO PASS THE TEST
assign CP0_Cause[29:16]=14'b0;
assign CP0_Cause[15]=IP7|TI&IM7;
assign CP0_Cause[14]=IP6;
assign CP0_Cause[13]=IP5;
assign CP0_Cause[12]=IP4;
assign CP0_Cause[11]=IP3;
assign CP0_Cause[10]=IP2;
assign CP0_Cause[9]=IP1;//
assign CP0_Cause[8]=IP0;//
assign CP0_Cause[7]=1'b0;
assign CP0_Cause[6:2]=ExcCode;
assign CP0_Cause[1]=1'b0;
assign CP0_Cause[0]=1'b0;

wire set_cause=EX_MEM_exception_pipe_reg.set_CP0&&(EX_MEM_exception_pipe_reg.addr_CP0==`CP0_CAUSE);

//IP1
always@(posedge clk)begin
    if(!resetn)begin
        IP1<=1'b0;
    end else 
    if(set_cause)
    begin
        IP1<=CP0_wdata[9];
    end
end

//IP0
always@(posedge clk)begin
    if(!resetn)begin
        IP0<=1'b0;
    end else 
    if(set_cause)
    begin
        IP0<=CP0_wdata[8];
    end
end

//TI
always@(posedge clk)begin
    if(!resetn)begin
        TI<=1'b0;
    end else 
    if(set_compare)
    begin
        TI<=1'b0;
    end else
    if((CP0_Count==CP0_Compare)&&(CP0_Compare!=32'b0))//12.9 added
    begin
        TI<=1'b1;
    end
end

//BD
always@(posedge clk)begin
    if(!resetn)begin
        BD<=1'b0;
    end else 
    if(have_exception&&(!EXL))
    begin
        BD<=EX_MEM_exception_pipe_reg.BD;
    end
end

//CP0_EPC

wire set_EPC=EX_MEM_exception_pipe_reg.set_CP0&&(EX_MEM_exception_pipe_reg.addr_CP0==`CP0_EPC);

always@(posedge clk)begin
    if(!resetn)begin
        CP0_EPC<=32'b0;
    end else 
    if(have_exception&(!EXL))
    begin
        CP0_EPC<=(EX_MEM_exception_pipe_reg.BD?(MEM_PC-4):MEM_PC);
        // CP0_EPC<=MEM_PC;
    end else 
    if(set_EPC)begin
        CP0_EPC<=CP0_wdata;
    end
end

//CP0_rdata

assign CP0_rdata=
    {32{EX_MEM_exception_pipe_reg.addr_CP0==`CP0_STATUS}}&CP0_Status|
    {32{EX_MEM_exception_pipe_reg.addr_CP0==`CP0_CAUSE}}&CP0_Cause|
    {32{EX_MEM_exception_pipe_reg.addr_CP0==`CP0_BADVADDR}}&CP0_BadVaddr|
    {32{EX_MEM_exception_pipe_reg.addr_CP0==`CP0_EPC}}&CP0_EPC|
    {32{EX_MEM_exception_pipe_reg.addr_CP0==`CP0_COUNT}}&CP0_Count|
    {32{EX_MEM_exception_pipe_reg.addr_CP0==`CP0_COMPARE}}&CP0_Compare;

endmodule


// TODO: 

// CP0; 1
// DATA_reg 1

// ID: new inst 1
// ID: All Badaddr: l/s i/d 1
// ID: reserved 1 
// ID: sys 1
// ID: trap 1
// ID: breakpoint 1
// EX: All overflow 1

// clear pipeline 1

// data_sram_wen 1
// div_resetn 1
// mfc0: 1
// mtc0: 1

// pypass mtc0: 1
// reg_a_valid: mthi 1

// BD IF
// MEM deal int 1
// ID: fix inst 1
