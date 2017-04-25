
_lab1:     file format elf32-i386


Disassembly of section .text:

00000000 <PScheduler>:
      
      return 0;
  }
      
      
     int PScheduler(void){
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	53                   	push   %ebx
   4:	83 ec 24             	sub    $0x24,%esp
    // 0 is the highest priority. All processes have a default priority of 20 

  int pid, ret_pid, exit_status;
  int i,j,k;
  
    printf(1, "\n  Step 2: testing the priority scheduler and set_priority(int priority)) systemcall:\n");
   7:	c7 44 24 04 78 0c 00 	movl   $0xc78,0x4(%esp)
   e:	00 
   f:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  16:	e8 f5 08 00 00       	call   910 <printf>
    printf(1, "\n  Step 2: Assuming that the priorities range between range between 0 to 63\n");
  1b:	c7 44 24 04 d0 0c 00 	movl   $0xcd0,0x4(%esp)
  22:	00 
  23:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  2a:	e8 e1 08 00 00       	call   910 <printf>
    printf(1, "\n  Step 2: 0 is the highest priority. All processes have a default priority of 20\n");
  2f:	c7 44 24 04 20 0d 00 	movl   $0xd20,0x4(%esp)
  36:	00 
  37:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  3e:	e8 cd 08 00 00       	call   910 <printf>
    printf(1, "\n  Step 2: The parent processes will switch to priority 0\n");
  43:	c7 44 24 04 74 0d 00 	movl   $0xd74,0x4(%esp)
  4a:	00 
  4b:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  52:	e8 b9 08 00 00       	call   910 <printf>
    setpriority(getpid(), 0);
  57:	e8 ec 07 00 00       	call   848 <getpid>
  5c:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  63:	00 
  64:	89 04 24             	mov    %eax,(%esp)
  67:	e8 0c 08 00 00       	call   878 <setpriority>
    for (i = 0; i <  3; i++) {
	pid = fork();
  6c:	e8 4f 07 00 00       	call   7c0 <fork>
	if (pid > 0 ) {
  71:	31 d2                	xor    %edx,%edx
  73:	85 c0                	test   %eax,%eax
  75:	7e 3f                	jle    b6 <PScheduler+0xb6>
    printf(1, "\n  Step 2: Assuming that the priorities range between range between 0 to 63\n");
    printf(1, "\n  Step 2: 0 is the highest priority. All processes have a default priority of 20\n");
    printf(1, "\n  Step 2: The parent processes will switch to priority 0\n");
    setpriority(getpid(), 0);
    for (i = 0; i <  3; i++) {
	pid = fork();
  77:	e8 44 07 00 00       	call   7c0 <fork>
	if (pid > 0 ) {
  7c:	ba 01 00 00 00       	mov    $0x1,%edx
  81:	85 c0                	test   %eax,%eax
  83:	7e 31                	jle    b6 <PScheduler+0xb6>
    printf(1, "\n  Step 2: Assuming that the priorities range between range between 0 to 63\n");
    printf(1, "\n  Step 2: 0 is the highest priority. All processes have a default priority of 20\n");
    printf(1, "\n  Step 2: The parent processes will switch to priority 0\n");
    setpriority(getpid(), 0);
    for (i = 0; i <  3; i++) {
	pid = fork();
  85:	e8 36 07 00 00       	call   7c0 <fork>
	if (pid > 0 ) {
  8a:	85 c0                	test   %eax,%eax
  8c:	7e 23                	jle    b1 <PScheduler+0xb1>
        }
	}

	if(pid > 0) {
		for (i = 0; i <  3; i++) {
			ret_pid = wait(&exit_status);
  8e:	8d 5d f4             	lea    -0xc(%ebp),%ebx
  91:	89 1c 24             	mov    %ebx,(%esp)
  94:	e8 37 07 00 00       	call   7d0 <wait>
  99:	89 1c 24             	mov    %ebx,(%esp)
  9c:	e8 2f 07 00 00       	call   7d0 <wait>
  a1:	89 1c 24             	mov    %ebx,(%esp)
  a4:	e8 27 07 00 00       	call   7d0 <wait>
			//printf(1,"\n This is the parent: child with PID# %d has finished with status %d \n",ret_pid,exit_status);
			}}
			
	return 0;}
  a9:	83 c4 24             	add    $0x24,%esp
  ac:	31 c0                	xor    %eax,%eax
  ae:	5b                   	pop    %ebx
  af:	5d                   	pop    %ebp
  b0:	c3                   	ret    
        }
	}

	if(pid > 0) {
		for (i = 0; i <  3; i++) {
			ret_pid = wait(&exit_status);
  b1:	ba 02 00 00 00       	mov    $0x2,%edx
    setpriority(getpid(), 0);
    for (i = 0; i <  3; i++) {
	pid = fork();
	if (pid > 0 ) {
		continue;}
	else if ( pid == 0) {
  b6:	85 c0                	test   %eax,%eax
  b8:	0f 85 85 00 00 00    	jne    143 <PScheduler+0x143>
		printf(1, "\n Hello! this is child# %d and I will change my priority to %d \n",getpid(),60-20*i);
  be:	6b d2 ec             	imul   $0xffffffec,%edx,%edx
  c1:	8d 5a 3c             	lea    0x3c(%edx),%ebx
  c4:	e8 7f 07 00 00       	call   848 <getpid>
  c9:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
  cd:	c7 44 24 04 b0 0d 00 	movl   $0xdb0,0x4(%esp)
  d4:	00 
  d5:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  dc:	89 44 24 08          	mov    %eax,0x8(%esp)
  e0:	e8 2b 08 00 00       	call   910 <printf>
		setpriority(getpid(),60-20*i);	
  e5:	e8 5e 07 00 00       	call   848 <getpid>
  ea:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  ee:	89 04 24             	mov    %eax,(%esp)
  f1:	e8 82 07 00 00       	call   878 <setpriority>
  f6:	31 d2                	xor    %edx,%edx
		for (j=0;j<50000;j++) {
  f8:	31 c0                	xor    %eax,%eax
  fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
			for(k=0;k<10000;k++) {
				asm("nop"); }}
 100:	90                   	nop
		continue;}
	else if ( pid == 0) {
		printf(1, "\n Hello! this is child# %d and I will change my priority to %d \n",getpid(),60-20*i);
		setpriority(getpid(),60-20*i);	
		for (j=0;j<50000;j++) {
			for(k=0;k<10000;k++) {
 101:	83 c0 01             	add    $0x1,%eax
 104:	3d 10 27 00 00       	cmp    $0x2710,%eax
 109:	75 f5                	jne    100 <PScheduler+0x100>
	if (pid > 0 ) {
		continue;}
	else if ( pid == 0) {
		printf(1, "\n Hello! this is child# %d and I will change my priority to %d \n",getpid(),60-20*i);
		setpriority(getpid(),60-20*i);	
		for (j=0;j<50000;j++) {
 10b:	83 c2 01             	add    $0x1,%edx
 10e:	81 fa 50 c3 00 00    	cmp    $0xc350,%edx
 114:	75 e2                	jne    f8 <PScheduler+0xf8>
			for(k=0;k<10000;k++) {
				asm("nop"); }}
		printf(1, "\n child# %d with priority has finished! \n",getpid(),60-20*i);		
 116:	e8 2d 07 00 00       	call   848 <getpid>
 11b:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
 11f:	c7 44 24 04 f4 0d 00 	movl   $0xdf4,0x4(%esp)
 126:	00 
 127:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 12e:	89 44 24 08          	mov    %eax,0x8(%esp)
 132:	e8 d9 07 00 00       	call   910 <printf>
		exit(0);
 137:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 13e:	e8 85 06 00 00       	call   7c8 <exit>
        }
        else {
			printf(2," \n Error \n");
 143:	c7 44 24 04 74 10 00 	movl   $0x1074,0x4(%esp)
 14a:	00 
 14b:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
 152:	e8 b9 07 00 00       	call   910 <printf>
			exit(-1);
 157:	c7 04 24 ff ff ff ff 	movl   $0xffffffff,(%esp)
 15e:	e8 65 06 00 00       	call   7c8 <exit>
 163:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 169:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000170 <exitWait>:
    // End of test
	 exit(0);
 }
  
  
int exitWait(void) {
 170:	55                   	push   %ebp
 171:	89 e5                	mov    %esp,%ebp
 173:	53                   	push   %ebx
 174:	83 ec 24             	sub    $0x24,%esp
	  int pid, ret_pid, exit_status;
       int i;
  // use this part to test exit(int status) and wait(int* status)
 
  printf(1, "\n  Step 1: testing exit(int status) and wait(int* status):\n");
 177:	c7 44 24 04 20 0e 00 	movl   $0xe20,0x4(%esp)
 17e:	00 
 17f:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 186:	e8 85 07 00 00       	call   910 <printf>

  for (i = 0; i < 2; i++) {
    pid = fork();
 18b:	e8 30 06 00 00       	call   7c0 <fork>
    if (pid == 0) { // only the child executed this code
 190:	83 f8 00             	cmp    $0x0,%eax
 193:	74 73                	je     208 <exitWait+0x98>
      else
      {
	 printf(1, "\nThis is child with PID# %d and I will exit with status %d\n" ,getpid(), -1);
      exit(-1);
  } 
    } else if (pid > 0) { // only the parent exeecutes this code
 195:	0f 8e d6 00 00 00    	jle    271 <exitWait+0x101>
      ret_pid = wait(&exit_status);
 19b:	8d 5d f4             	lea    -0xc(%ebp),%ebx
 19e:	89 1c 24             	mov    %ebx,(%esp)
 1a1:	e8 2a 06 00 00       	call   7d0 <wait>
      printf(1, "\n This is the parent: child with PID# %d has exited with status %d\n", ret_pid, exit_status);
 1a6:	8b 55 f4             	mov    -0xc(%ebp),%edx
 1a9:	c7 44 24 04 5c 0e 00 	movl   $0xe5c,0x4(%esp)
 1b0:	00 
 1b1:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 1b8:	89 54 24 0c          	mov    %edx,0xc(%esp)
 1bc:	89 44 24 08          	mov    %eax,0x8(%esp)
 1c0:	e8 4b 07 00 00       	call   910 <printf>
  // use this part to test exit(int status) and wait(int* status)
 
  printf(1, "\n  Step 1: testing exit(int status) and wait(int* status):\n");

  for (i = 0; i < 2; i++) {
    pid = fork();
 1c5:	e8 f6 05 00 00       	call   7c0 <fork>
    if (pid == 0) { // only the child executed this code
 1ca:	83 f8 00             	cmp    $0x0,%eax
 1cd:	74 71                	je     240 <exitWait+0xd0>
 1cf:	90                   	nop
      else
      {
	 printf(1, "\nThis is child with PID# %d and I will exit with status %d\n" ,getpid(), -1);
      exit(-1);
  } 
    } else if (pid > 0) { // only the parent exeecutes this code
 1d0:	0f 8e 9b 00 00 00    	jle    271 <exitWait+0x101>
      ret_pid = wait(&exit_status);
 1d6:	89 1c 24             	mov    %ebx,(%esp)
 1d9:	e8 f2 05 00 00       	call   7d0 <wait>
      printf(1, "\n This is the parent: child with PID# %d has exited with status %d\n", ret_pid, exit_status);
 1de:	8b 55 f4             	mov    -0xc(%ebp),%edx
 1e1:	c7 44 24 04 5c 0e 00 	movl   $0xe5c,0x4(%esp)
 1e8:	00 
 1e9:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 1f0:	89 54 24 0c          	mov    %edx,0xc(%esp)
 1f4:	89 44 24 08          	mov    %eax,0x8(%esp)
 1f8:	e8 13 07 00 00       	call   910 <printf>
	  printf(2, "\nError using fork\n");
      exit(-1);
    }
  }
  return 0;
}
 1fd:	83 c4 24             	add    $0x24,%esp
 200:	31 c0                	xor    %eax,%eax
 202:	5b                   	pop    %ebx
 203:	5d                   	pop    %ebp
 204:	c3                   	ret    
 205:	8d 76 00             	lea    0x0(%esi),%esi
  for (i = 0; i < 2; i++) {
    pid = fork();
    if (pid == 0) { // only the child executed this code
      if (i == 0)
      {
      printf(1, "\nThis is child with PID# %d and I will exit with status %d\n", getpid(), 0);
 208:	e8 3b 06 00 00       	call   848 <getpid>
 20d:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
 214:	00 
 215:	c7 44 24 04 a0 0e 00 	movl   $0xea0,0x4(%esp)
 21c:	00 
 21d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 224:	89 44 24 08          	mov    %eax,0x8(%esp)
 228:	e8 e3 06 00 00       	call   910 <printf>
      exit(0);
 22d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 234:	e8 8f 05 00 00       	call   7c8 <exit>
 239:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  }
      else
      {
	 printf(1, "\nThis is child with PID# %d and I will exit with status %d\n" ,getpid(), -1);
 240:	e8 03 06 00 00       	call   848 <getpid>
 245:	c7 44 24 0c ff ff ff 	movl   $0xffffffff,0xc(%esp)
 24c:	ff 
 24d:	c7 44 24 04 a0 0e 00 	movl   $0xea0,0x4(%esp)
 254:	00 
 255:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 25c:	89 44 24 08          	mov    %eax,0x8(%esp)
 260:	e8 ab 06 00 00       	call   910 <printf>
      exit(-1);
 265:	c7 04 24 ff ff ff ff 	movl   $0xffffffff,(%esp)
 26c:	e8 57 05 00 00       	call   7c8 <exit>
    } else if (pid > 0) { // only the parent exeecutes this code
      ret_pid = wait(&exit_status);
      printf(1, "\n This is the parent: child with PID# %d has exited with status %d\n", ret_pid, exit_status);
    } else  // something went wrong with fork system call
    {  
	  printf(2, "\nError using fork\n");
 271:	c7 44 24 04 7f 10 00 	movl   $0x107f,0x4(%esp)
 278:	00 
 279:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
 280:	e8 8b 06 00 00       	call   910 <printf>
      exit(-1);
 285:	c7 04 24 ff ff ff ff 	movl   $0xffffffff,(%esp)
 28c:	e8 37 05 00 00       	call   7c8 <exit>
 291:	eb 0d                	jmp    2a0 <waitPid>
 293:	90                   	nop
 294:	90                   	nop
 295:	90                   	nop
 296:	90                   	nop
 297:	90                   	nop
 298:	90                   	nop
 299:	90                   	nop
 29a:	90                   	nop
 29b:	90                   	nop
 29c:	90                   	nop
 29d:	90                   	nop
 29e:	90                   	nop
 29f:	90                   	nop

000002a0 <waitPid>:
    }
  }
  return 0;
}

int waitPid(void){
 2a0:	55                   	push   %ebp
 2a1:	89 e5                	mov    %esp,%ebp
 2a3:	56                   	push   %esi
 2a4:	53                   	push   %ebx
  int ret_pid, exit_status;
  int i;
  int pid_a[5]={0, 0, 0, 0, 0};
 // use this part to test wait(int pid, int* status, int options)

 printf(1, "\n  Step 2: testing waitpid(int pid, int* status, int options):\n");
 2a5:	31 db                	xor    %ebx,%ebx
    }
  }
  return 0;
}

int waitPid(void){
 2a7:	83 ec 30             	sub    $0x30,%esp
  int ret_pid, exit_status;
  int i;
  int pid_a[5]={0, 0, 0, 0, 0};
 // use this part to test wait(int pid, int* status, int options)

 printf(1, "\n  Step 2: testing waitpid(int pid, int* status, int options):\n");
 2aa:	c7 44 24 04 dc 0e 00 	movl   $0xedc,0x4(%esp)
 2b1:	00 

  for (i = 0; i <5; i++) {
    pid_a[i] = fork();
 2b2:	8d 75 e0             	lea    -0x20(%ebp),%esi

int waitPid(void){
	
  int ret_pid, exit_status;
  int i;
  int pid_a[5]={0, 0, 0, 0, 0};
 2b5:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
 2bc:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
 2c3:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
 2ca:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
 2d1:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 // use this part to test wait(int pid, int* status, int options)

 printf(1, "\n  Step 2: testing waitpid(int pid, int* status, int options):\n");
 2d8:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 2df:	e8 2c 06 00 00       	call   910 <printf>

  for (i = 0; i <5; i++) {
    pid_a[i] = fork();
 2e4:	e8 d7 04 00 00       	call   7c0 <fork>
	
    if (pid_a[i] == 0) { // only the child executed this code
 2e9:	85 c0                	test   %eax,%eax
 2eb:	0f 84 d9 01 00 00    	je     4ca <waitPid+0x22a>
 // use this part to test wait(int pid, int* status, int options)

 printf(1, "\n  Step 2: testing waitpid(int pid, int* status, int options):\n");

  for (i = 0; i <5; i++) {
    pid_a[i] = fork();
 2f1:	89 04 9e             	mov    %eax,(%esi,%ebx,4)
  int pid_a[5]={0, 0, 0, 0, 0};
 // use this part to test wait(int pid, int* status, int options)

 printf(1, "\n  Step 2: testing waitpid(int pid, int* status, int options):\n");

  for (i = 0; i <5; i++) {
 2f4:	83 c3 01             	add    $0x1,%ebx
 2f7:	83 fb 05             	cmp    $0x5,%ebx
 2fa:	75 e8                	jne    2e4 <waitPid+0x44>
     
      
      printf(1, "\n The is child with PID# %d and I will exit with status %d\n", getpid(), 0);
      exit(0);}}
       
      sleep(5);
 2fc:	c7 04 24 05 00 00 00 	movl   $0x5,(%esp)
      printf(1, "\n This is the parent: Now waiting for child with PID# %d\n",pid_a[3]);
      ret_pid = waitpid(pid_a[3], &exit_status, 0);
 303:	8d 5d f4             	lea    -0xc(%ebp),%ebx
     
      
      printf(1, "\n The is child with PID# %d and I will exit with status %d\n", getpid(), 0);
      exit(0);}}
       
      sleep(5);
 306:	e8 4d 05 00 00       	call   858 <sleep>
      printf(1, "\n This is the parent: Now waiting for child with PID# %d\n",pid_a[3]);
 30b:	8b 75 ec             	mov    -0x14(%ebp),%esi
 30e:	c7 44 24 04 58 0f 00 	movl   $0xf58,0x4(%esp)
 315:	00 
 316:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 31d:	89 74 24 08          	mov    %esi,0x8(%esp)
 321:	e8 ea 05 00 00       	call   910 <printf>
      ret_pid = waitpid(pid_a[3], &exit_status, 0);
 326:	89 5c 24 04          	mov    %ebx,0x4(%esp)
 32a:	89 34 24             	mov    %esi,(%esp)
 32d:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
 334:	00 
 335:	e8 36 05 00 00       	call   870 <waitpid>
      printf(1, "\n This is the partent: Child# %d has exited with status %d\n",ret_pid, exit_status);
 33a:	8b 55 f4             	mov    -0xc(%ebp),%edx
 33d:	c7 44 24 04 94 0f 00 	movl   $0xf94,0x4(%esp)
 344:	00 
 345:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 34c:	89 54 24 0c          	mov    %edx,0xc(%esp)
 350:	89 44 24 08          	mov    %eax,0x8(%esp)
 354:	e8 b7 05 00 00       	call   910 <printf>
      sleep(5);
 359:	c7 04 24 05 00 00 00 	movl   $0x5,(%esp)
 360:	e8 f3 04 00 00       	call   858 <sleep>
      printf(1, "\n This is the parent: Now waiting for child with PID# %d\n",pid_a[1]);
 365:	8b 75 e4             	mov    -0x1c(%ebp),%esi
 368:	c7 44 24 04 58 0f 00 	movl   $0xf58,0x4(%esp)
 36f:	00 
 370:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 377:	89 74 24 08          	mov    %esi,0x8(%esp)
 37b:	e8 90 05 00 00       	call   910 <printf>
      ret_pid = waitpid(pid_a[1], &exit_status, 0);
 380:	89 5c 24 04          	mov    %ebx,0x4(%esp)
 384:	89 34 24             	mov    %esi,(%esp)
 387:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
 38e:	00 
 38f:	e8 dc 04 00 00       	call   870 <waitpid>
      printf(1, "\n This is the partent: Child# %d has exited with status %d\n",ret_pid, exit_status);
 394:	8b 55 f4             	mov    -0xc(%ebp),%edx
 397:	c7 44 24 04 94 0f 00 	movl   $0xf94,0x4(%esp)
 39e:	00 
 39f:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 3a6:	89 54 24 0c          	mov    %edx,0xc(%esp)
 3aa:	89 44 24 08          	mov    %eax,0x8(%esp)
 3ae:	e8 5d 05 00 00       	call   910 <printf>
      sleep(5);
 3b3:	c7 04 24 05 00 00 00 	movl   $0x5,(%esp)
 3ba:	e8 99 04 00 00       	call   858 <sleep>
      printf(1, "\n This is the parent: Now waiting for child with PID# %d\n",pid_a[2]);
 3bf:	8b 75 e8             	mov    -0x18(%ebp),%esi
 3c2:	c7 44 24 04 58 0f 00 	movl   $0xf58,0x4(%esp)
 3c9:	00 
 3ca:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 3d1:	89 74 24 08          	mov    %esi,0x8(%esp)
 3d5:	e8 36 05 00 00       	call   910 <printf>
      ret_pid = waitpid(pid_a[2], &exit_status, 0);
 3da:	89 5c 24 04          	mov    %ebx,0x4(%esp)
 3de:	89 34 24             	mov    %esi,(%esp)
 3e1:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
 3e8:	00 
 3e9:	e8 82 04 00 00       	call   870 <waitpid>
      printf(1, "\n This is the partent: Child# %d has exited with status %d\n",ret_pid, exit_status);
 3ee:	8b 55 f4             	mov    -0xc(%ebp),%edx
 3f1:	c7 44 24 04 94 0f 00 	movl   $0xf94,0x4(%esp)
 3f8:	00 
 3f9:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 400:	89 54 24 0c          	mov    %edx,0xc(%esp)
 404:	89 44 24 08          	mov    %eax,0x8(%esp)
 408:	e8 03 05 00 00       	call   910 <printf>
      sleep(5);
 40d:	c7 04 24 05 00 00 00 	movl   $0x5,(%esp)
 414:	e8 3f 04 00 00       	call   858 <sleep>
      printf(1, "\n This is the parent: Now waiting for child with PID# %d\n",pid_a[0]);
 419:	8b 75 e0             	mov    -0x20(%ebp),%esi
 41c:	c7 44 24 04 58 0f 00 	movl   $0xf58,0x4(%esp)
 423:	00 
 424:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 42b:	89 74 24 08          	mov    %esi,0x8(%esp)
 42f:	e8 dc 04 00 00       	call   910 <printf>
      ret_pid = waitpid(pid_a[0], &exit_status, 0);
 434:	89 5c 24 04          	mov    %ebx,0x4(%esp)
 438:	89 34 24             	mov    %esi,(%esp)
 43b:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
 442:	00 
 443:	e8 28 04 00 00       	call   870 <waitpid>
      printf(1, "\n This is the partent: Child# %d has exited with status %d\n",ret_pid, exit_status);
 448:	8b 55 f4             	mov    -0xc(%ebp),%edx
 44b:	c7 44 24 04 94 0f 00 	movl   $0xf94,0x4(%esp)
 452:	00 
 453:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 45a:	89 54 24 0c          	mov    %edx,0xc(%esp)
 45e:	89 44 24 08          	mov    %eax,0x8(%esp)
 462:	e8 a9 04 00 00       	call   910 <printf>
      sleep(5);
 467:	c7 04 24 05 00 00 00 	movl   $0x5,(%esp)
 46e:	e8 e5 03 00 00       	call   858 <sleep>
      printf(1, "\n This is the parent: Now waiting for child with PID# %d\n",pid_a[4]);
 473:	8b 75 f0             	mov    -0x10(%ebp),%esi
 476:	c7 44 24 04 58 0f 00 	movl   $0xf58,0x4(%esp)
 47d:	00 
 47e:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 485:	89 74 24 08          	mov    %esi,0x8(%esp)
 489:	e8 82 04 00 00       	call   910 <printf>
      ret_pid = waitpid(pid_a[4], &exit_status, 0);
 48e:	89 5c 24 04          	mov    %ebx,0x4(%esp)
 492:	89 34 24             	mov    %esi,(%esp)
 495:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
 49c:	00 
 49d:	e8 ce 03 00 00       	call   870 <waitpid>
      printf(1, "\n This is the partent: Child# %d has exited with status %d\n",ret_pid, exit_status);
 4a2:	8b 55 f4             	mov    -0xc(%ebp),%edx
 4a5:	c7 44 24 04 94 0f 00 	movl   $0xf94,0x4(%esp)
 4ac:	00 
 4ad:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 4b4:	89 54 24 0c          	mov    %edx,0xc(%esp)
 4b8:	89 44 24 08          	mov    %eax,0x8(%esp)
 4bc:	e8 4f 04 00 00       	call   910 <printf>
      
      return 0;
  }
 4c1:	83 c4 30             	add    $0x30,%esp
 4c4:	31 c0                	xor    %eax,%eax
 4c6:	5b                   	pop    %ebx
 4c7:	5e                   	pop    %esi
 4c8:	5d                   	pop    %ebp
 4c9:	c3                   	ret    
    pid_a[i] = fork();
	
    if (pid_a[i] == 0) { // only the child executed this code
     
      
      printf(1, "\n The is child with PID# %d and I will exit with status %d\n", getpid(), 0);
 4ca:	e8 79 03 00 00       	call   848 <getpid>
 4cf:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
 4d6:	00 
 4d7:	c7 44 24 04 1c 0f 00 	movl   $0xf1c,0x4(%esp)
 4de:	00 
 4df:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 4e6:	89 44 24 08          	mov    %eax,0x8(%esp)
 4ea:	e8 21 04 00 00       	call   910 <printf>
      exit(0);}}
 4ef:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 4f6:	e8 cd 02 00 00       	call   7c8 <exit>
 4fb:	90                   	nop
 4fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000500 <main>:
#include "types.h"
#include "user.h"

int main(int argc, char *argv[])
{
 500:	55                   	push   %ebp
 501:	89 e5                	mov    %esp,%ebp
 503:	83 e4 f0             	and    $0xfffffff0,%esp
 506:	53                   	push   %ebx
 507:	83 ec 1c             	sub    $0x1c,%esp
 50a:	8b 5d 0c             	mov    0xc(%ebp),%ebx
	
	int exitWait(void);
	int waitPid(void);
	int PScheduler(void);

  printf(1, "\n This program tests the correctness of your lab#1\n");
 50d:	c7 44 24 04 d0 0f 00 	movl   $0xfd0,0x4(%esp)
 514:	00 
 515:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 51c:	e8 ef 03 00 00       	call   910 <printf>
  
  if (atoi(argv[1]) == 1)
 521:	8b 43 04             	mov    0x4(%ebx),%eax
 524:	89 04 24             	mov    %eax,(%esp)
 527:	e8 74 01 00 00       	call   6a0 <atoi>
 52c:	83 f8 01             	cmp    $0x1,%eax
 52f:	74 47                	je     578 <main+0x78>
	exitWait();
  else if (atoi(argv[1]) == 2)
 531:	8b 43 04             	mov    0x4(%ebx),%eax
 534:	89 04 24             	mov    %eax,(%esp)
 537:	e8 64 01 00 00       	call   6a0 <atoi>
 53c:	83 f8 02             	cmp    $0x2,%eax
 53f:	74 3f                	je     580 <main+0x80>
	waitPid();
  else if (atoi(argv[1]) == 3)
 541:	8b 43 04             	mov    0x4(%ebx),%eax
 544:	89 04 24             	mov    %eax,(%esp)
 547:	e8 54 01 00 00       	call   6a0 <atoi>
 54c:	83 f8 03             	cmp    $0x3,%eax
 54f:	74 37                	je     588 <main+0x88>
	PScheduler();
  else 
   printf(1, "\ntype \"lab1 1\" to test exit and wait, \"lab1 2\" to test waitpid and \"lab1 3\" to test the priority scheduler \n");
 551:	c7 44 24 04 04 10 00 	movl   $0x1004,0x4(%esp)
 558:	00 
 559:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 560:	e8 ab 03 00 00       	call   910 <printf>
  
    // End of test
	 exit(0);
 565:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 56c:	e8 57 02 00 00       	call   7c8 <exit>
 571:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
	int PScheduler(void);

  printf(1, "\n This program tests the correctness of your lab#1\n");
  
  if (atoi(argv[1]) == 1)
	exitWait();
 578:	e8 f3 fb ff ff       	call   170 <exitWait>
 57d:	eb e6                	jmp    565 <main+0x65>
 57f:	90                   	nop
  else if (atoi(argv[1]) == 2)
	waitPid();
 580:	e8 1b fd ff ff       	call   2a0 <waitPid>
 585:	eb de                	jmp    565 <main+0x65>
 587:	90                   	nop
 588:	90                   	nop
 589:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  else if (atoi(argv[1]) == 3)
	PScheduler();
 590:	e8 6b fa ff ff       	call   0 <PScheduler>
 595:	eb ce                	jmp    565 <main+0x65>
 597:	90                   	nop
 598:	90                   	nop
 599:	90                   	nop
 59a:	90                   	nop
 59b:	90                   	nop
 59c:	90                   	nop
 59d:	90                   	nop
 59e:	90                   	nop
 59f:	90                   	nop

000005a0 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 5a0:	55                   	push   %ebp
 5a1:	31 d2                	xor    %edx,%edx
 5a3:	89 e5                	mov    %esp,%ebp
 5a5:	8b 45 08             	mov    0x8(%ebp),%eax
 5a8:	53                   	push   %ebx
 5a9:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 5ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 5b0:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
 5b4:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 5b7:	83 c2 01             	add    $0x1,%edx
 5ba:	84 c9                	test   %cl,%cl
 5bc:	75 f2                	jne    5b0 <strcpy+0x10>
    ;
  return os;
}
 5be:	5b                   	pop    %ebx
 5bf:	5d                   	pop    %ebp
 5c0:	c3                   	ret    
 5c1:	eb 0d                	jmp    5d0 <strcmp>
 5c3:	90                   	nop
 5c4:	90                   	nop
 5c5:	90                   	nop
 5c6:	90                   	nop
 5c7:	90                   	nop
 5c8:	90                   	nop
 5c9:	90                   	nop
 5ca:	90                   	nop
 5cb:	90                   	nop
 5cc:	90                   	nop
 5cd:	90                   	nop
 5ce:	90                   	nop
 5cf:	90                   	nop

000005d0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 5d0:	55                   	push   %ebp
 5d1:	89 e5                	mov    %esp,%ebp
 5d3:	8b 4d 08             	mov    0x8(%ebp),%ecx
 5d6:	53                   	push   %ebx
 5d7:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(*p && *p == *q)
 5da:	0f b6 01             	movzbl (%ecx),%eax
 5dd:	84 c0                	test   %al,%al
 5df:	75 14                	jne    5f5 <strcmp+0x25>
 5e1:	eb 25                	jmp    608 <strcmp+0x38>
 5e3:	90                   	nop
 5e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    p++, q++;
 5e8:	83 c1 01             	add    $0x1,%ecx
 5eb:	83 c2 01             	add    $0x1,%edx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 5ee:	0f b6 01             	movzbl (%ecx),%eax
 5f1:	84 c0                	test   %al,%al
 5f3:	74 13                	je     608 <strcmp+0x38>
 5f5:	0f b6 1a             	movzbl (%edx),%ebx
 5f8:	38 d8                	cmp    %bl,%al
 5fa:	74 ec                	je     5e8 <strcmp+0x18>
 5fc:	0f b6 db             	movzbl %bl,%ebx
 5ff:	0f b6 c0             	movzbl %al,%eax
 602:	29 d8                	sub    %ebx,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
 604:	5b                   	pop    %ebx
 605:	5d                   	pop    %ebp
 606:	c3                   	ret    
 607:	90                   	nop
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 608:	0f b6 1a             	movzbl (%edx),%ebx
 60b:	31 c0                	xor    %eax,%eax
 60d:	0f b6 db             	movzbl %bl,%ebx
 610:	29 d8                	sub    %ebx,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
 612:	5b                   	pop    %ebx
 613:	5d                   	pop    %ebp
 614:	c3                   	ret    
 615:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 619:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000620 <strlen>:

uint
strlen(char *s)
{
 620:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
 621:	31 d2                	xor    %edx,%edx
  return (uchar)*p - (uchar)*q;
}

uint
strlen(char *s)
{
 623:	89 e5                	mov    %esp,%ebp
  int n;

  for(n = 0; s[n]; n++)
 625:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
}

uint
strlen(char *s)
{
 627:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 62a:	80 39 00             	cmpb   $0x0,(%ecx)
 62d:	74 0c                	je     63b <strlen+0x1b>
 62f:	90                   	nop
 630:	83 c2 01             	add    $0x1,%edx
 633:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 637:	89 d0                	mov    %edx,%eax
 639:	75 f5                	jne    630 <strlen+0x10>
    ;
  return n;
}
 63b:	5d                   	pop    %ebp
 63c:	c3                   	ret    
 63d:	8d 76 00             	lea    0x0(%esi),%esi

00000640 <memset>:

void*
memset(void *dst, int c, uint n)
{
 640:	55                   	push   %ebp
 641:	89 e5                	mov    %esp,%ebp
 643:	8b 55 08             	mov    0x8(%ebp),%edx
 646:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 647:	8b 4d 10             	mov    0x10(%ebp),%ecx
 64a:	8b 45 0c             	mov    0xc(%ebp),%eax
 64d:	89 d7                	mov    %edx,%edi
 64f:	fc                   	cld    
 650:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 652:	89 d0                	mov    %edx,%eax
 654:	5f                   	pop    %edi
 655:	5d                   	pop    %ebp
 656:	c3                   	ret    
 657:	89 f6                	mov    %esi,%esi
 659:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000660 <strchr>:

char*
strchr(const char *s, char c)
{
 660:	55                   	push   %ebp
 661:	89 e5                	mov    %esp,%ebp
 663:	8b 45 08             	mov    0x8(%ebp),%eax
 666:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 66a:	0f b6 10             	movzbl (%eax),%edx
 66d:	84 d2                	test   %dl,%dl
 66f:	75 11                	jne    682 <strchr+0x22>
 671:	eb 15                	jmp    688 <strchr+0x28>
 673:	90                   	nop
 674:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 678:	83 c0 01             	add    $0x1,%eax
 67b:	0f b6 10             	movzbl (%eax),%edx
 67e:	84 d2                	test   %dl,%dl
 680:	74 06                	je     688 <strchr+0x28>
    if(*s == c)
 682:	38 ca                	cmp    %cl,%dl
 684:	75 f2                	jne    678 <strchr+0x18>
      return (char*)s;
  return 0;
}
 686:	5d                   	pop    %ebp
 687:	c3                   	ret    
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 688:	31 c0                	xor    %eax,%eax
    if(*s == c)
      return (char*)s;
  return 0;
}
 68a:	5d                   	pop    %ebp
 68b:	90                   	nop
 68c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 690:	c3                   	ret    
 691:	eb 0d                	jmp    6a0 <atoi>
 693:	90                   	nop
 694:	90                   	nop
 695:	90                   	nop
 696:	90                   	nop
 697:	90                   	nop
 698:	90                   	nop
 699:	90                   	nop
 69a:	90                   	nop
 69b:	90                   	nop
 69c:	90                   	nop
 69d:	90                   	nop
 69e:	90                   	nop
 69f:	90                   	nop

000006a0 <atoi>:
  return r;
}

int
atoi(const char *s)
{
 6a0:	55                   	push   %ebp
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 6a1:	31 c0                	xor    %eax,%eax
  return r;
}

int
atoi(const char *s)
{
 6a3:	89 e5                	mov    %esp,%ebp
 6a5:	8b 4d 08             	mov    0x8(%ebp),%ecx
 6a8:	53                   	push   %ebx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 6a9:	0f b6 11             	movzbl (%ecx),%edx
 6ac:	8d 5a d0             	lea    -0x30(%edx),%ebx
 6af:	80 fb 09             	cmp    $0x9,%bl
 6b2:	77 1c                	ja     6d0 <atoi+0x30>
 6b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    n = n*10 + *s++ - '0';
 6b8:	0f be d2             	movsbl %dl,%edx
 6bb:	83 c1 01             	add    $0x1,%ecx
 6be:	8d 04 80             	lea    (%eax,%eax,4),%eax
 6c1:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 6c5:	0f b6 11             	movzbl (%ecx),%edx
 6c8:	8d 5a d0             	lea    -0x30(%edx),%ebx
 6cb:	80 fb 09             	cmp    $0x9,%bl
 6ce:	76 e8                	jbe    6b8 <atoi+0x18>
    n = n*10 + *s++ - '0';
  return n;
}
 6d0:	5b                   	pop    %ebx
 6d1:	5d                   	pop    %ebp
 6d2:	c3                   	ret    
 6d3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 6d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000006e0 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 6e0:	55                   	push   %ebp
 6e1:	89 e5                	mov    %esp,%ebp
 6e3:	56                   	push   %esi
 6e4:	8b 45 08             	mov    0x8(%ebp),%eax
 6e7:	53                   	push   %ebx
 6e8:	8b 5d 10             	mov    0x10(%ebp),%ebx
 6eb:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 6ee:	85 db                	test   %ebx,%ebx
 6f0:	7e 14                	jle    706 <memmove+0x26>
    n = n*10 + *s++ - '0';
  return n;
}

void*
memmove(void *vdst, void *vsrc, int n)
 6f2:	31 d2                	xor    %edx,%edx
 6f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    *dst++ = *src++;
 6f8:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 6fc:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 6ff:	83 c2 01             	add    $0x1,%edx
{
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 702:	39 da                	cmp    %ebx,%edx
 704:	75 f2                	jne    6f8 <memmove+0x18>
    *dst++ = *src++;
  return vdst;
}
 706:	5b                   	pop    %ebx
 707:	5e                   	pop    %esi
 708:	5d                   	pop    %ebp
 709:	c3                   	ret    
 70a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000710 <stat>:
  return buf;
}

int
stat(char *n, struct stat *st)
{
 710:	55                   	push   %ebp
 711:	89 e5                	mov    %esp,%ebp
 713:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 716:	8b 45 08             	mov    0x8(%ebp),%eax
  return buf;
}

int
stat(char *n, struct stat *st)
{
 719:	89 5d f8             	mov    %ebx,-0x8(%ebp)
 71c:	89 75 fc             	mov    %esi,-0x4(%ebp)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
 71f:	be ff ff ff ff       	mov    $0xffffffff,%esi
stat(char *n, struct stat *st)
{
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 724:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 72b:	00 
 72c:	89 04 24             	mov    %eax,(%esp)
 72f:	e8 d4 00 00 00       	call   808 <open>
  if(fd < 0)
 734:	85 c0                	test   %eax,%eax
stat(char *n, struct stat *st)
{
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 736:	89 c3                	mov    %eax,%ebx
  if(fd < 0)
 738:	78 19                	js     753 <stat+0x43>
    return -1;
  r = fstat(fd, st);
 73a:	8b 45 0c             	mov    0xc(%ebp),%eax
 73d:	89 1c 24             	mov    %ebx,(%esp)
 740:	89 44 24 04          	mov    %eax,0x4(%esp)
 744:	e8 d7 00 00 00       	call   820 <fstat>
  close(fd);
 749:	89 1c 24             	mov    %ebx,(%esp)
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
  r = fstat(fd, st);
 74c:	89 c6                	mov    %eax,%esi
  close(fd);
 74e:	e8 9d 00 00 00       	call   7f0 <close>
  return r;
}
 753:	89 f0                	mov    %esi,%eax
 755:	8b 5d f8             	mov    -0x8(%ebp),%ebx
 758:	8b 75 fc             	mov    -0x4(%ebp),%esi
 75b:	89 ec                	mov    %ebp,%esp
 75d:	5d                   	pop    %ebp
 75e:	c3                   	ret    
 75f:	90                   	nop

00000760 <gets>:
  return 0;
}

char*
gets(char *buf, int max)
{
 760:	55                   	push   %ebp
 761:	89 e5                	mov    %esp,%ebp
 763:	57                   	push   %edi
 764:	56                   	push   %esi
 765:	31 f6                	xor    %esi,%esi
 767:	53                   	push   %ebx
 768:	83 ec 2c             	sub    $0x2c,%esp
 76b:	8b 7d 08             	mov    0x8(%ebp),%edi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 76e:	eb 06                	jmp    776 <gets+0x16>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 770:	3c 0a                	cmp    $0xa,%al
 772:	74 39                	je     7ad <gets+0x4d>
 774:	89 de                	mov    %ebx,%esi
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 776:	8d 5e 01             	lea    0x1(%esi),%ebx
 779:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 77c:	7d 31                	jge    7af <gets+0x4f>
    cc = read(0, &c, 1);
 77e:	8d 45 e7             	lea    -0x19(%ebp),%eax
 781:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 788:	00 
 789:	89 44 24 04          	mov    %eax,0x4(%esp)
 78d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 794:	e8 47 00 00 00       	call   7e0 <read>
    if(cc < 1)
 799:	85 c0                	test   %eax,%eax
 79b:	7e 12                	jle    7af <gets+0x4f>
      break;
    buf[i++] = c;
 79d:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 7a1:	88 44 1f ff          	mov    %al,-0x1(%edi,%ebx,1)
    if(c == '\n' || c == '\r')
 7a5:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 7a9:	3c 0d                	cmp    $0xd,%al
 7ab:	75 c3                	jne    770 <gets+0x10>
 7ad:	89 de                	mov    %ebx,%esi
      break;
  }
  buf[i] = '\0';
 7af:	c6 04 37 00          	movb   $0x0,(%edi,%esi,1)
  return buf;
}
 7b3:	89 f8                	mov    %edi,%eax
 7b5:	83 c4 2c             	add    $0x2c,%esp
 7b8:	5b                   	pop    %ebx
 7b9:	5e                   	pop    %esi
 7ba:	5f                   	pop    %edi
 7bb:	5d                   	pop    %ebp
 7bc:	c3                   	ret    
 7bd:	90                   	nop
 7be:	90                   	nop
 7bf:	90                   	nop

000007c0 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 7c0:	b8 01 00 00 00       	mov    $0x1,%eax
 7c5:	cd 40                	int    $0x40
 7c7:	c3                   	ret    

000007c8 <exit>:
SYSCALL(exit)
 7c8:	b8 02 00 00 00       	mov    $0x2,%eax
 7cd:	cd 40                	int    $0x40
 7cf:	c3                   	ret    

000007d0 <wait>:
SYSCALL(wait)
 7d0:	b8 03 00 00 00       	mov    $0x3,%eax
 7d5:	cd 40                	int    $0x40
 7d7:	c3                   	ret    

000007d8 <pipe>:
SYSCALL(pipe)
 7d8:	b8 04 00 00 00       	mov    $0x4,%eax
 7dd:	cd 40                	int    $0x40
 7df:	c3                   	ret    

000007e0 <read>:
SYSCALL(read)
 7e0:	b8 05 00 00 00       	mov    $0x5,%eax
 7e5:	cd 40                	int    $0x40
 7e7:	c3                   	ret    

000007e8 <write>:
SYSCALL(write)
 7e8:	b8 10 00 00 00       	mov    $0x10,%eax
 7ed:	cd 40                	int    $0x40
 7ef:	c3                   	ret    

000007f0 <close>:
SYSCALL(close)
 7f0:	b8 15 00 00 00       	mov    $0x15,%eax
 7f5:	cd 40                	int    $0x40
 7f7:	c3                   	ret    

000007f8 <kill>:
SYSCALL(kill)
 7f8:	b8 06 00 00 00       	mov    $0x6,%eax
 7fd:	cd 40                	int    $0x40
 7ff:	c3                   	ret    

00000800 <exec>:
SYSCALL(exec)
 800:	b8 07 00 00 00       	mov    $0x7,%eax
 805:	cd 40                	int    $0x40
 807:	c3                   	ret    

00000808 <open>:
SYSCALL(open)
 808:	b8 0f 00 00 00       	mov    $0xf,%eax
 80d:	cd 40                	int    $0x40
 80f:	c3                   	ret    

00000810 <mknod>:
SYSCALL(mknod)
 810:	b8 11 00 00 00       	mov    $0x11,%eax
 815:	cd 40                	int    $0x40
 817:	c3                   	ret    

00000818 <unlink>:
SYSCALL(unlink)
 818:	b8 12 00 00 00       	mov    $0x12,%eax
 81d:	cd 40                	int    $0x40
 81f:	c3                   	ret    

00000820 <fstat>:
SYSCALL(fstat)
 820:	b8 08 00 00 00       	mov    $0x8,%eax
 825:	cd 40                	int    $0x40
 827:	c3                   	ret    

00000828 <link>:
SYSCALL(link)
 828:	b8 13 00 00 00       	mov    $0x13,%eax
 82d:	cd 40                	int    $0x40
 82f:	c3                   	ret    

00000830 <mkdir>:
SYSCALL(mkdir)
 830:	b8 14 00 00 00       	mov    $0x14,%eax
 835:	cd 40                	int    $0x40
 837:	c3                   	ret    

00000838 <chdir>:
SYSCALL(chdir)
 838:	b8 09 00 00 00       	mov    $0x9,%eax
 83d:	cd 40                	int    $0x40
 83f:	c3                   	ret    

00000840 <dup>:
SYSCALL(dup)
 840:	b8 0a 00 00 00       	mov    $0xa,%eax
 845:	cd 40                	int    $0x40
 847:	c3                   	ret    

00000848 <getpid>:
SYSCALL(getpid)
 848:	b8 0b 00 00 00       	mov    $0xb,%eax
 84d:	cd 40                	int    $0x40
 84f:	c3                   	ret    

00000850 <sbrk>:
SYSCALL(sbrk)
 850:	b8 0c 00 00 00       	mov    $0xc,%eax
 855:	cd 40                	int    $0x40
 857:	c3                   	ret    

00000858 <sleep>:
SYSCALL(sleep)
 858:	b8 0d 00 00 00       	mov    $0xd,%eax
 85d:	cd 40                	int    $0x40
 85f:	c3                   	ret    

00000860 <uptime>:
SYSCALL(uptime)
 860:	b8 0e 00 00 00       	mov    $0xe,%eax
 865:	cd 40                	int    $0x40
 867:	c3                   	ret    

00000868 <hello>:
SYSCALL(hello) 			// added for Lab0
 868:	b8 16 00 00 00       	mov    $0x16,%eax
 86d:	cd 40                	int    $0x40
 86f:	c3                   	ret    

00000870 <waitpid>:
SYSCALL(waitpid) 		// lab1 part 1: c
 870:	b8 17 00 00 00       	mov    $0x17,%eax
 875:	cd 40                	int    $0x40
 877:	c3                   	ret    

00000878 <setpriority>:
SYSCALL(setpriority) 	// lab1 part 2: define syscall
 878:	b8 18 00 00 00       	mov    $0x18,%eax
 87d:	cd 40                	int    $0x40
 87f:	c3                   	ret    

00000880 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 880:	55                   	push   %ebp
 881:	89 e5                	mov    %esp,%ebp
 883:	57                   	push   %edi
 884:	89 cf                	mov    %ecx,%edi
 886:	56                   	push   %esi
 887:	89 c6                	mov    %eax,%esi
 889:	53                   	push   %ebx
 88a:	83 ec 4c             	sub    $0x4c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 88d:	8b 4d 08             	mov    0x8(%ebp),%ecx
 890:	85 c9                	test   %ecx,%ecx
 892:	74 04                	je     898 <printint+0x18>
 894:	85 d2                	test   %edx,%edx
 896:	78 68                	js     900 <printint+0x80>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 898:	89 d0                	mov    %edx,%eax
 89a:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 8a1:	31 c9                	xor    %ecx,%ecx
 8a3:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 8a6:	66 90                	xchg   %ax,%ax
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
 8a8:	31 d2                	xor    %edx,%edx
 8aa:	f7 f7                	div    %edi
 8ac:	0f b6 92 99 10 00 00 	movzbl 0x1099(%edx),%edx
 8b3:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
 8b6:	83 c1 01             	add    $0x1,%ecx
  }while((x /= base) != 0);
 8b9:	85 c0                	test   %eax,%eax
 8bb:	75 eb                	jne    8a8 <printint+0x28>
  if(neg)
 8bd:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 8c0:	85 c0                	test   %eax,%eax
 8c2:	74 08                	je     8cc <printint+0x4c>
    buf[i++] = '-';
 8c4:	c6 44 0d d7 2d       	movb   $0x2d,-0x29(%ebp,%ecx,1)
 8c9:	83 c1 01             	add    $0x1,%ecx

  while(--i >= 0)
 8cc:	8d 79 ff             	lea    -0x1(%ecx),%edi
 8cf:	90                   	nop
 8d0:	0f b6 04 3b          	movzbl (%ebx,%edi,1),%eax
 8d4:	83 ef 01             	sub    $0x1,%edi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 8d7:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 8de:	00 
 8df:	89 34 24             	mov    %esi,(%esp)
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 8e2:	88 45 e7             	mov    %al,-0x19(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 8e5:	8d 45 e7             	lea    -0x19(%ebp),%eax
 8e8:	89 44 24 04          	mov    %eax,0x4(%esp)
 8ec:	e8 f7 fe ff ff       	call   7e8 <write>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 8f1:	83 ff ff             	cmp    $0xffffffff,%edi
 8f4:	75 da                	jne    8d0 <printint+0x50>
    putc(fd, buf[i]);
}
 8f6:	83 c4 4c             	add    $0x4c,%esp
 8f9:	5b                   	pop    %ebx
 8fa:	5e                   	pop    %esi
 8fb:	5f                   	pop    %edi
 8fc:	5d                   	pop    %ebp
 8fd:	c3                   	ret    
 8fe:	66 90                	xchg   %ax,%ax
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 900:	89 d0                	mov    %edx,%eax
 902:	f7 d8                	neg    %eax
 904:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
 90b:	eb 94                	jmp    8a1 <printint+0x21>
 90d:	8d 76 00             	lea    0x0(%esi),%esi

00000910 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 910:	55                   	push   %ebp
 911:	89 e5                	mov    %esp,%ebp
 913:	57                   	push   %edi
 914:	56                   	push   %esi
 915:	53                   	push   %ebx
 916:	83 ec 3c             	sub    $0x3c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 919:	8b 45 0c             	mov    0xc(%ebp),%eax
 91c:	0f b6 10             	movzbl (%eax),%edx
 91f:	84 d2                	test   %dl,%dl
 921:	0f 84 c1 00 00 00    	je     9e8 <printf+0xd8>
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
 927:	8d 4d 10             	lea    0x10(%ebp),%ecx
 92a:	31 ff                	xor    %edi,%edi
 92c:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
 92f:	31 db                	xor    %ebx,%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 931:	8d 75 e7             	lea    -0x19(%ebp),%esi
 934:	eb 1e                	jmp    954 <printf+0x44>
 936:	66 90                	xchg   %ax,%ax
  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 938:	83 fa 25             	cmp    $0x25,%edx
 93b:	0f 85 af 00 00 00    	jne    9f0 <printf+0xe0>
 941:	66 bf 25 00          	mov    $0x25,%di
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 945:	83 c3 01             	add    $0x1,%ebx
 948:	0f b6 14 18          	movzbl (%eax,%ebx,1),%edx
 94c:	84 d2                	test   %dl,%dl
 94e:	0f 84 94 00 00 00    	je     9e8 <printf+0xd8>
    c = fmt[i] & 0xff;
    if(state == 0){
 954:	85 ff                	test   %edi,%edi
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
 956:	0f b6 d2             	movzbl %dl,%edx
    if(state == 0){
 959:	74 dd                	je     938 <printf+0x28>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 95b:	83 ff 25             	cmp    $0x25,%edi
 95e:	75 e5                	jne    945 <printf+0x35>
      if(c == 'd'){
 960:	83 fa 64             	cmp    $0x64,%edx
 963:	0f 84 3f 01 00 00    	je     aa8 <printf+0x198>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 969:	83 fa 70             	cmp    $0x70,%edx
 96c:	0f 84 a6 00 00 00    	je     a18 <printf+0x108>
 972:	83 fa 78             	cmp    $0x78,%edx
 975:	0f 84 9d 00 00 00    	je     a18 <printf+0x108>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 97b:	83 fa 73             	cmp    $0x73,%edx
 97e:	66 90                	xchg   %ax,%ax
 980:	0f 84 ba 00 00 00    	je     a40 <printf+0x130>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 986:	83 fa 63             	cmp    $0x63,%edx
 989:	0f 84 41 01 00 00    	je     ad0 <printf+0x1c0>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 98f:	83 fa 25             	cmp    $0x25,%edx
 992:	0f 84 00 01 00 00    	je     a98 <printf+0x188>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 998:	8b 4d 08             	mov    0x8(%ebp),%ecx
 99b:	89 55 cc             	mov    %edx,-0x34(%ebp)
 99e:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 9a2:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 9a9:	00 
 9aa:	89 74 24 04          	mov    %esi,0x4(%esp)
 9ae:	89 0c 24             	mov    %ecx,(%esp)
 9b1:	e8 32 fe ff ff       	call   7e8 <write>
 9b6:	8b 55 cc             	mov    -0x34(%ebp),%edx
 9b9:	88 55 e7             	mov    %dl,-0x19(%ebp)
 9bc:	8b 45 08             	mov    0x8(%ebp),%eax
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 9bf:	83 c3 01             	add    $0x1,%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 9c2:	31 ff                	xor    %edi,%edi
 9c4:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 9cb:	00 
 9cc:	89 74 24 04          	mov    %esi,0x4(%esp)
 9d0:	89 04 24             	mov    %eax,(%esp)
 9d3:	e8 10 fe ff ff       	call   7e8 <write>
 9d8:	8b 45 0c             	mov    0xc(%ebp),%eax
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 9db:	0f b6 14 18          	movzbl (%eax,%ebx,1),%edx
 9df:	84 d2                	test   %dl,%dl
 9e1:	0f 85 6d ff ff ff    	jne    954 <printf+0x44>
 9e7:	90                   	nop
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 9e8:	83 c4 3c             	add    $0x3c,%esp
 9eb:	5b                   	pop    %ebx
 9ec:	5e                   	pop    %esi
 9ed:	5f                   	pop    %edi
 9ee:	5d                   	pop    %ebp
 9ef:	c3                   	ret    
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 9f0:	8b 45 08             	mov    0x8(%ebp),%eax
  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 9f3:	88 55 e7             	mov    %dl,-0x19(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 9f6:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 9fd:	00 
 9fe:	89 74 24 04          	mov    %esi,0x4(%esp)
 a02:	89 04 24             	mov    %eax,(%esp)
 a05:	e8 de fd ff ff       	call   7e8 <write>
 a0a:	8b 45 0c             	mov    0xc(%ebp),%eax
 a0d:	e9 33 ff ff ff       	jmp    945 <printf+0x35>
 a12:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 a18:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 a1b:	b9 10 00 00 00       	mov    $0x10,%ecx
        ap++;
 a20:	31 ff                	xor    %edi,%edi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 a22:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 a29:	8b 10                	mov    (%eax),%edx
 a2b:	8b 45 08             	mov    0x8(%ebp),%eax
 a2e:	e8 4d fe ff ff       	call   880 <printint>
 a33:	8b 45 0c             	mov    0xc(%ebp),%eax
        ap++;
 a36:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
 a3a:	e9 06 ff ff ff       	jmp    945 <printf+0x35>
 a3f:	90                   	nop
      } else if(c == 's'){
        s = (char*)*ap;
 a40:	8b 55 d4             	mov    -0x2c(%ebp),%edx
        ap++;
        if(s == 0)
 a43:	b9 92 10 00 00       	mov    $0x1092,%ecx
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
        s = (char*)*ap;
 a48:	8b 3a                	mov    (%edx),%edi
        ap++;
 a4a:	83 c2 04             	add    $0x4,%edx
 a4d:	89 55 d4             	mov    %edx,-0x2c(%ebp)
        if(s == 0)
 a50:	85 ff                	test   %edi,%edi
 a52:	0f 44 f9             	cmove  %ecx,%edi
          s = "(null)";
        while(*s != 0){
 a55:	0f b6 17             	movzbl (%edi),%edx
 a58:	84 d2                	test   %dl,%dl
 a5a:	74 33                	je     a8f <printf+0x17f>
 a5c:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 a5f:	8b 5d 08             	mov    0x8(%ebp),%ebx
 a62:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
          putc(fd, *s);
          s++;
 a68:	83 c7 01             	add    $0x1,%edi
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 a6b:	88 55 e7             	mov    %dl,-0x19(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 a6e:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 a75:	00 
 a76:	89 74 24 04          	mov    %esi,0x4(%esp)
 a7a:	89 1c 24             	mov    %ebx,(%esp)
 a7d:	e8 66 fd ff ff       	call   7e8 <write>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 a82:	0f b6 17             	movzbl (%edi),%edx
 a85:	84 d2                	test   %dl,%dl
 a87:	75 df                	jne    a68 <printf+0x158>
 a89:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 a8c:	8b 45 0c             	mov    0xc(%ebp),%eax
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 a8f:	31 ff                	xor    %edi,%edi
 a91:	e9 af fe ff ff       	jmp    945 <printf+0x35>
 a96:	66 90                	xchg   %ax,%ax
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 a98:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 a9c:	e9 1b ff ff ff       	jmp    9bc <printf+0xac>
 aa1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 aa8:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 aab:	b9 0a 00 00 00       	mov    $0xa,%ecx
        ap++;
 ab0:	66 31 ff             	xor    %di,%di
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 ab3:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 aba:	8b 10                	mov    (%eax),%edx
 abc:	8b 45 08             	mov    0x8(%ebp),%eax
 abf:	e8 bc fd ff ff       	call   880 <printint>
 ac4:	8b 45 0c             	mov    0xc(%ebp),%eax
        ap++;
 ac7:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
 acb:	e9 75 fe ff ff       	jmp    945 <printf+0x35>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 ad0:	8b 55 d4             	mov    -0x2c(%ebp),%edx
        putc(fd, *ap);
        ap++;
 ad3:	31 ff                	xor    %edi,%edi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 ad5:	8b 4d 08             	mov    0x8(%ebp),%ecx
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 ad8:	8b 02                	mov    (%edx),%eax
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 ada:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 ae1:	00 
 ae2:	89 74 24 04          	mov    %esi,0x4(%esp)
 ae6:	89 0c 24             	mov    %ecx,(%esp)
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 ae9:	88 45 e7             	mov    %al,-0x19(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 aec:	e8 f7 fc ff ff       	call   7e8 <write>
 af1:	8b 45 0c             	mov    0xc(%ebp),%eax
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
        ap++;
 af4:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
 af8:	e9 48 fe ff ff       	jmp    945 <printf+0x35>
 afd:	90                   	nop
 afe:	90                   	nop
 aff:	90                   	nop

00000b00 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 b00:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 b01:	a1 b4 10 00 00       	mov    0x10b4,%eax
static Header base;
static Header *freep;

void
free(void *ap)
{
 b06:	89 e5                	mov    %esp,%ebp
 b08:	57                   	push   %edi
 b09:	56                   	push   %esi
 b0a:	53                   	push   %ebx
 b0b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
 b0e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 b11:	39 c8                	cmp    %ecx,%eax
 b13:	73 1d                	jae    b32 <free+0x32>
 b15:	8d 76 00             	lea    0x0(%esi),%esi
 b18:	8b 10                	mov    (%eax),%edx
 b1a:	39 d1                	cmp    %edx,%ecx
 b1c:	72 1a                	jb     b38 <free+0x38>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 b1e:	39 d0                	cmp    %edx,%eax
 b20:	72 08                	jb     b2a <free+0x2a>
 b22:	39 c8                	cmp    %ecx,%eax
 b24:	72 12                	jb     b38 <free+0x38>
 b26:	39 d1                	cmp    %edx,%ecx
 b28:	72 0e                	jb     b38 <free+0x38>
 b2a:	89 d0                	mov    %edx,%eax
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 b2c:	39 c8                	cmp    %ecx,%eax
 b2e:	66 90                	xchg   %ax,%ax
 b30:	72 e6                	jb     b18 <free+0x18>
 b32:	8b 10                	mov    (%eax),%edx
 b34:	eb e8                	jmp    b1e <free+0x1e>
 b36:	66 90                	xchg   %ax,%ax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 b38:	8b 71 04             	mov    0x4(%ecx),%esi
 b3b:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 b3e:	39 d7                	cmp    %edx,%edi
 b40:	74 19                	je     b5b <free+0x5b>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 b42:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 b45:	8b 50 04             	mov    0x4(%eax),%edx
 b48:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 b4b:	39 ce                	cmp    %ecx,%esi
 b4d:	74 23                	je     b72 <free+0x72>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 b4f:	89 08                	mov    %ecx,(%eax)
  freep = p;
 b51:	a3 b4 10 00 00       	mov    %eax,0x10b4
}
 b56:	5b                   	pop    %ebx
 b57:	5e                   	pop    %esi
 b58:	5f                   	pop    %edi
 b59:	5d                   	pop    %ebp
 b5a:	c3                   	ret    
  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 b5b:	03 72 04             	add    0x4(%edx),%esi
 b5e:	89 71 04             	mov    %esi,0x4(%ecx)
    bp->s.ptr = p->s.ptr->s.ptr;
 b61:	8b 10                	mov    (%eax),%edx
 b63:	8b 12                	mov    (%edx),%edx
 b65:	89 53 f8             	mov    %edx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 b68:	8b 50 04             	mov    0x4(%eax),%edx
 b6b:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 b6e:	39 ce                	cmp    %ecx,%esi
 b70:	75 dd                	jne    b4f <free+0x4f>
    p->s.size += bp->s.size;
 b72:	03 51 04             	add    0x4(%ecx),%edx
 b75:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 b78:	8b 53 f8             	mov    -0x8(%ebx),%edx
 b7b:	89 10                	mov    %edx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
 b7d:	a3 b4 10 00 00       	mov    %eax,0x10b4
}
 b82:	5b                   	pop    %ebx
 b83:	5e                   	pop    %esi
 b84:	5f                   	pop    %edi
 b85:	5d                   	pop    %ebp
 b86:	c3                   	ret    
 b87:	89 f6                	mov    %esi,%esi
 b89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000b90 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 b90:	55                   	push   %ebp
 b91:	89 e5                	mov    %esp,%ebp
 b93:	57                   	push   %edi
 b94:	56                   	push   %esi
 b95:	53                   	push   %ebx
 b96:	83 ec 2c             	sub    $0x2c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 b99:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if((prevp = freep) == 0){
 b9c:	8b 0d b4 10 00 00    	mov    0x10b4,%ecx
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 ba2:	83 c3 07             	add    $0x7,%ebx
 ba5:	c1 eb 03             	shr    $0x3,%ebx
 ba8:	83 c3 01             	add    $0x1,%ebx
  if((prevp = freep) == 0){
 bab:	85 c9                	test   %ecx,%ecx
 bad:	0f 84 9b 00 00 00    	je     c4e <malloc+0xbe>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 bb3:	8b 01                	mov    (%ecx),%eax
    if(p->s.size >= nunits){
 bb5:	8b 50 04             	mov    0x4(%eax),%edx
 bb8:	39 d3                	cmp    %edx,%ebx
 bba:	76 27                	jbe    be3 <malloc+0x53>
        p->s.size -= nunits;
        p += p->s.size;
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
 bbc:	8d 3c dd 00 00 00 00 	lea    0x0(,%ebx,8),%edi
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < 4096)
 bc3:	be 00 80 00 00       	mov    $0x8000,%esi
 bc8:	89 7d e4             	mov    %edi,-0x1c(%ebp)
 bcb:	90                   	nop
 bcc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 bd0:	3b 05 b4 10 00 00    	cmp    0x10b4,%eax
 bd6:	74 30                	je     c08 <malloc+0x78>
 bd8:	89 c1                	mov    %eax,%ecx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 bda:	8b 01                	mov    (%ecx),%eax
    if(p->s.size >= nunits){
 bdc:	8b 50 04             	mov    0x4(%eax),%edx
 bdf:	39 d3                	cmp    %edx,%ebx
 be1:	77 ed                	ja     bd0 <malloc+0x40>
      if(p->s.size == nunits)
 be3:	39 d3                	cmp    %edx,%ebx
 be5:	74 61                	je     c48 <malloc+0xb8>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 be7:	29 da                	sub    %ebx,%edx
 be9:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 bec:	8d 04 d0             	lea    (%eax,%edx,8),%eax
        p->s.size = nunits;
 bef:	89 58 04             	mov    %ebx,0x4(%eax)
      }
      freep = prevp;
 bf2:	89 0d b4 10 00 00    	mov    %ecx,0x10b4
      return (void*)(p + 1);
 bf8:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 bfb:	83 c4 2c             	add    $0x2c,%esp
 bfe:	5b                   	pop    %ebx
 bff:	5e                   	pop    %esi
 c00:	5f                   	pop    %edi
 c01:	5d                   	pop    %ebp
 c02:	c3                   	ret    
 c03:	90                   	nop
 c04:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < 4096)
 c08:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 c0b:	81 fb 00 10 00 00    	cmp    $0x1000,%ebx
 c11:	bf 00 10 00 00       	mov    $0x1000,%edi
 c16:	0f 43 fb             	cmovae %ebx,%edi
 c19:	0f 42 c6             	cmovb  %esi,%eax
    nu = 4096;
  p = sbrk(nu * sizeof(Header));
 c1c:	89 04 24             	mov    %eax,(%esp)
 c1f:	e8 2c fc ff ff       	call   850 <sbrk>
  if(p == (char*)-1)
 c24:	83 f8 ff             	cmp    $0xffffffff,%eax
 c27:	74 18                	je     c41 <malloc+0xb1>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
 c29:	89 78 04             	mov    %edi,0x4(%eax)
  free((void*)(hp + 1));
 c2c:	83 c0 08             	add    $0x8,%eax
 c2f:	89 04 24             	mov    %eax,(%esp)
 c32:	e8 c9 fe ff ff       	call   b00 <free>
  return freep;
 c37:	8b 0d b4 10 00 00    	mov    0x10b4,%ecx
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
 c3d:	85 c9                	test   %ecx,%ecx
 c3f:	75 99                	jne    bda <malloc+0x4a>
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 c41:	31 c0                	xor    %eax,%eax
 c43:	eb b6                	jmp    bfb <malloc+0x6b>
 c45:	8d 76 00             	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
 c48:	8b 10                	mov    (%eax),%edx
 c4a:	89 11                	mov    %edx,(%ecx)
 c4c:	eb a4                	jmp    bf2 <malloc+0x62>
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 c4e:	c7 05 b4 10 00 00 ac 	movl   $0x10ac,0x10b4
 c55:	10 00 00 
    base.s.size = 0;
 c58:	b9 ac 10 00 00       	mov    $0x10ac,%ecx
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 c5d:	c7 05 ac 10 00 00 ac 	movl   $0x10ac,0x10ac
 c64:	10 00 00 
    base.s.size = 0;
 c67:	c7 05 b0 10 00 00 00 	movl   $0x0,0x10b0
 c6e:	00 00 00 
 c71:	e9 3d ff ff ff       	jmp    bb3 <malloc+0x23>
