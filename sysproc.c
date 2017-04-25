#include "types.h"
#include "x86.h"
#include "defs.h"
#include "date.h"
#include "param.h"
#include "memlayout.h"
#include "mmu.h"
#include "proc.h"

int
sys_fork(void)
{
  return fork();
}

int
sys_exit(void) // modified exit to handle a exit status (lab1 part1: a)
{
  int exitstat;
  argint(0, &exitstat);
  if (exitstat < 0) {
	  return -1;  
  }
  else{
	 exit(exitstat);   
  }
  return 0;  // not reached
}

int
sys_wait(void) // update sys_wait to wiat for a process with a pod that equals the one provided by the waitStatus argument (lab1 part1b)
{
  int waitStatus;
  int checkStatus;
  checkStatus = (argptr(0, (char**)&waitStatus,sizeof(int*))  );
  if (checkStatus > 0) {
	  return -1;
  }
  return wait(&waitStatus);
}

int
sys_waitpid(void) //  Added waitpid sstem call which waits for a process with a pid that is equal to the pid provided by the argumet handles errors
{
	int pid;
	int* waitStatus;
	int arg;
	
	if(argint(0, &pid) < 0) {
		return -1;
	}
	if(argptr(0, (char**)&waitStatus, sizeof(int*)) < 0){
		return -1;
	}
	if(argint(1, &arg) < 0) {
		return -1;
	}

	return(waitpid(pid,waitStatus,arg));
}

int 
sys_setpriority(void) {
	int pid;
	int priority;
	if(argint(1, &priority) < 0 || argint(0, &pid) < 0 || priority < 0 || priority > 63 || pid < 0){
		return -1;
	return (setpriority(pid, priority));
}
	
}

int
sys_kill(void)
{
  int pid;

  if(argint(0, &pid) < 0)
    return -1;
  return kill(pid);
}

int
sys_getpid(void)
{
  return proc->pid;
}

int
sys_sbrk(void)
{
  int addr;
  int n;

  if(argint(0, &n) < 0)
    return -1;
  addr = proc->sz;
  if(growproc(n) < 0)
    return -1;
  return addr;
}

int
sys_sleep(void)
{
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
    return -1;
  acquire(&tickslock);
  ticks0 = ticks;
  while(ticks - ticks0 < n){
    if(proc->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
  }
  release(&tickslock);
  return 0;
}

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
  uint xticks;

  acquire(&tickslock);
  xticks = ticks;
  release(&tickslock);
  return xticks;
}
int
sys_hello(void)
{
  hello();
  return 0;
}




