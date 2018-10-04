#include<stdio.h>
#include<stdlib.h>

int  main()
{
     pid_t  pid;
     int  i;
     for  (i=0;  i<3;  i++)
      {
           /* fork  another  process  */
           pid = fork();
           if  (pid < 0) { /*error  occurred  */
                fprintf(stderr, "Fork Failed");
                exit(-1);
           }
           else if (pid == 0) { /* child process */
                fprintf(stdout,  "i=%d,  pid=%d,  parent  pid=%d\n",i,      
                getpid() ,getppid());
           }   
      }
      wait(NULL);
      exit(0);
} 
