#### 操作系统研讨课实验

# Project3

* 王华强
* 2016K8009929035
* wanghuaqiang16@mails.ucas.ac.cn

---

## Which commands can be supported or will be supported by your shell?

* ps
* echo
* exec
* kill
* ......

---

## What to do for spawn, kill, wait, and exit?

```c
void do_spawn(struct task_info * task)
{
    int i=-1;
    i=find_free_pcb();
    if(i==-1)error("PCB_FULL");

    pcb[i].valid=1;
    pcb[i].pid=new_pid();
    pcb[i].type=task->type;
    pcb[i].status=TASK_READY;
    pcb[i].entry=task->entry_point;
    pcb[i].first_run=1;
    pcb[i].priority_level_set=priority_set[i];
    pcb[i].timeslice_set=timeslice_set[i];
    queue_push(&ready_queue,(void*)&(pcb[i]));
}
```

--

```c
void do_kill(pid_t pid)
{
    pcb_t * tgt_pcb=0;
    int i;
    for(i=0;i<NUM_MAX_TASK;i++)
    {
        if(pcb[i].pid==pid)tgt_pcb=&pcb[i];
    }
    if(tgt_pcb)
    {
        free_proc_resource(tgt_pcb);
        wakeup_wait(pid);
    }
    else
        printk("DO_KILL FAILED.\n");
}
```

--

```c
void do_exit()
{
    free_proc_resource(current_running);
    wakeup_wait(current_running->pid);
    do_scheduler();
}
```

--

```c
void do_wait(pid_t pid)
{
    //If pid not running: just run;
    int i;
    for(i=0;i<NUM_MAX_TASK;i++)
    {
        if(pcb[i].valid&&(pcb[i].pid==pid))
        {
            return;
        }
    }
    current_running->wait_pid=pid;
    do_block(&wait_queue);
    current_running->wait_pid=NULL;
}
```

---

### How do you handle synchronization when executing kill?

Just recycle all the locks it possesses.

---

### How about tasks in sleeping/blocking status when dealing with kill? 

* Maintain points in pcb;
* Points contains: queue_t*, lock_t* 