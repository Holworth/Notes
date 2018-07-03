    pure_asm:

    //using linux x64 abi

    push %rbx 

    //前6个参数通过寄存器传递(rdi, rsi, rdx, rcx ,r8, r9)

    mov $0,%rax
    //"mov 16(rsp), %rdi\n" //fd
    //"mov 24(rsp), %rsi\n" //buffer
    //"mov 32(rsp), %rdx\n" //count
    syscall


    //set %rdi to %rax
    mov (%rsi,%rax),%rdi
    //%rdi is the loop end

    //%rax,%rdi as accumulater
    mov $0,%rax
    mov $0,%rdx
    //%rdi as counter
    //%rbx as sign
    //%rcx as char reached

    //getchar
    mov (%rsi),% rcx
    
    sign:
    mov $(1),%rbx
    cmp %rcx,'+'
    jne 1b
    inc rsi
    j   num

    1:
    cmp %rcx,'-'
    jne num
    //neg
    mov $(-1),%rbx
    inc %rsi

    num:
    //while %rax<%rdx
    //getchar()
    cmp %rdi,%rsi
    jae end 
    mov (%rsi),% rcx
    //cmp 0-9
    cmp $'0',%rcx
    jb end
    cmp $'9',%rcx
    ja end
    //is 0-9

    mul $10
    add %rcx,%rax
    sub $'0',%rax
    inc %rsi

    j num

    end:
    //result is in %rax
    mul %rbx
    pop %rbx




