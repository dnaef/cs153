
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
  
    printf(1, "\n  Step 2: testing the priority scheduler and setpriority(int priority)) systema call:\n");
   7:	c7 44 24 04 58 0c 00 	movl   $0xc58,0x4(%esp)
   e:	00 
   f:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  16:	e8 d5 08 00 00       	call   8f0 <printf>
    printf(1, "\n  Step 2: Assuming that the priorities range between range between 0 to 63\n");
  1b:	c7 44 24 04 b0 0c 00 	movl   $0xcb0,0x4(%esp)
  22:	00 
  23:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  2a:	e8 c1 08 00 00       	call   8f0 <printf>
    printf(1, "\n  Step 2: 0 is the highest priority. All processes have a default priority of 20\n");
  2f:	c7 44 24 04 00 0d 00 	movl   $0xd00,0x4(%esp)
  36:	00 
  37:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  3e:	e8 ad 08 00 00       	call   8f0 <printf>
    printf(1, "\n  Step 2: The parent processes will switch to priority 0\n");
  43:	c7 44 24 04 54 0d 00 	movl   $0xd54,0x4(%esp)
  4a:	00 
  4b:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  52:	e8 99 08 00 00       	call   8f0 <printf>
    setpriority(0);
  57:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  5e:	e8 f5 07 00 00       	call   858 <setpriority>
    for (i = 0; i <  3; i++) {
	pid = fork();
  63:	e8 38 07 00 00       	call   7a0 <fork>
	if (pid > 0 ) {
  68:	31 d2                	xor    %edx,%edx
  6a:	85 c0                	test   %eax,%eax
  6c:	7e 53                	jle    c1 <PScheduler+0xc1>
    printf(1, "\n  Step 2: Assuming that the priorities range between range between 0 to 63\n");
    printf(1, "\n  Step 2: 0 is the highest priority. All processes have a default priority of 20\n");
    printf(1, "\n  Step 2: The parent processes will switch to priority 0\n");
    setpriority(0);
    for (i = 0; i <  3; i++) {
	pid = fork();
  6e:	e8 2d 07 00 00       	call   7a0 <fork>
	if (pid > 0 ) {
  73:	ba 01 00 00 00       	mov    $0x1,%edx
  78:	85 c0                	test   %eax,%eax
  7a:	7e 45                	jle    c1 <PScheduler+0xc1>
    printf(1, "\n  Step 2: Assuming that the priorities range between range between 0 to 63\n");
    printf(1, "\n  Step 2: 0 is the highest priority. All processes have a default priority of 20\n");
    printf(1, "\n  Step 2: The parent processes will switch to priority 0\n");
    setpriority(0);
    for (i = 0; i <  3; i++) {
	pid = fork();
  7c:	e8 1f 07 00 00       	call   7a0 <fork>
	if (pid > 0 ) {
  81:	85 c0                	test   %eax,%eax
  83:	7e 37                	jle    bc <PScheduler+0xbc>
        }
	}

	if(pid > 0) {
		for (i = 0; i <  3; i++) {
			ret_pid = wait(&exit_status);
  85:	8d 5d f4             	lea    -0xc(%ebp),%ebx
  88:	89 1c 24             	mov    %ebx,(%esp)
  8b:	e8 20 07 00 00       	call   7b0 <wait>
  90:	89 1c 24             	mov    %ebx,(%esp)
  93:	e8 18 07 00 00       	call   7b0 <wait>
  98:	89 1c 24             	mov    %ebx,(%esp)
  9b:	e8 10 07 00 00       	call   7b0 <wait>
			//printf(1,"\n This is the parent: child with PID# %d has finished with status %d \n",ret_pid,exit_status);
			}
                     printf(1,"\n if processes with highest priority finished first then its correct \n");
  a0:	c7 44 24 04 90 0d 00 	movl   $0xd90,0x4(%esp)
  a7:	00 
  a8:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  af:	e8 3c 08 00 00       	call   8f0 <printf>
}
			
	return 0;}
  b4:	83 c4 24             	add    $0x24,%esp
  b7:	31 c0                	xor    %eax,%eax
  b9:	5b                   	pop    %ebx
  ba:	5d                   	pop    %ebp
  bb:	c3                   	ret    
	if(pid > 0) {
		for (i = 0; i <  3; i++) {
			ret_pid = wait(&exit_status);
			//printf(1,"\n This is the parent: child with PID# %d has finished with status %d \n",ret_pid,exit_status);
			}
                     printf(1,"\n if processes with highest priority finished first then its correct \n");
  bc:	ba 02 00 00 00       	mov    $0x2,%edx
    setpriority(0);
    for (i = 0; i <  3; i++) {
	pid = fork();
	if (pid > 0 ) {
		continue;}
	else if ( pid == 0) {
  c1:	85 c0                	test   %eax,%eax
  c3:	75 5e                	jne    123 <PScheduler+0x123>
//		printf(1, "\n Hello! this is child# %d and I will change my priority to %d \n",getpid(),60-20*i);
		setpriority(60-20*i);	
  c5:	6b d2 ec             	imul   $0xffffffec,%edx,%edx
  c8:	8d 5a 3c             	lea    0x3c(%edx),%ebx
  cb:	89 1c 24             	mov    %ebx,(%esp)
  ce:	e8 85 07 00 00       	call   858 <setpriority>
  d3:	31 d2                	xor    %edx,%edx
  d5:	8d 76 00             	lea    0x0(%esi),%esi
		for (j=0;j<50000;j++) {
  d8:	31 c0                	xor    %eax,%eax
  da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
			for(k=0;k<10000;k++) {
				asm("nop"); }}
  e0:	90                   	nop
		continue;}
	else if ( pid == 0) {
//		printf(1, "\n Hello! this is child# %d and I will change my priority to %d \n",getpid(),60-20*i);
		setpriority(60-20*i);	
		for (j=0;j<50000;j++) {
			for(k=0;k<10000;k++) {
  e1:	83 c0 01             	add    $0x1,%eax
  e4:	3d 10 27 00 00       	cmp    $0x2710,%eax
  e9:	75 f5                	jne    e0 <PScheduler+0xe0>
	if (pid > 0 ) {
		continue;}
	else if ( pid == 0) {
//		printf(1, "\n Hello! this is child# %d and I will change my priority to %d \n",getpid(),60-20*i);
		setpriority(60-20*i);	
		for (j=0;j<50000;j++) {
  eb:	83 c2 01             	add    $0x1,%edx
  ee:	81 fa 50 c3 00 00    	cmp    $0xc350,%edx
  f4:	75 e2                	jne    d8 <PScheduler+0xd8>
			for(k=0;k<10000;k++) {
				asm("nop"); }}
		printf(1, "\n child# %d with priority %d has finished! \n",getpid(),60-20*i);		
  f6:	e8 2d 07 00 00       	call   828 <getpid>
  fb:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
  ff:	c7 44 24 04 d8 0d 00 	movl   $0xdd8,0x4(%esp)
 106:	00 
 107:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 10e:	89 44 24 08          	mov    %eax,0x8(%esp)
 112:	e8 d9 07 00 00       	call   8f0 <printf>
		exit(0);
 117:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 11e:	e8 85 06 00 00       	call   7a8 <exit>
        }
        else {
			printf(2," \n Error \n");
 123:	c7 44 24 04 5c 10 00 	movl   $0x105c,0x4(%esp)
 12a:	00 
 12b:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
 132:	e8 b9 07 00 00       	call   8f0 <printf>
			exit(-1);
 137:	c7 04 24 ff ff ff ff 	movl   $0xffffffff,(%esp)
 13e:	e8 65 06 00 00       	call   7a8 <exit>
 143:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 149:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000150 <exitWait>:
    // End of test
	 exit(0);
 }
  
  
int exitWait(void) {
 150:	55                   	push   %ebp
 151:	89 e5                	mov    %esp,%ebp
 153:	53                   	push   %ebx
 154:	83 ec 24             	sub    $0x24,%esp
	  int pid, ret_pid, exit_status;
       int i;
  // use this part to test exit(int status) and wait(int* status)
 
  printf(1, "\n  Step 1: testing exit(int status) and wait(int* status):\n");
 157:	c7 44 24 04 08 0e 00 	movl   $0xe08,0x4(%esp)
 15e:	00 
 15f:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 166:	e8 85 07 00 00       	call   8f0 <printf>

  for (i = 0; i < 2; i++) {
    pid = fork();
 16b:	e8 30 06 00 00       	call   7a0 <fork>
    if (pid == 0) { // only the child executed this code
 170:	83 f8 00             	cmp    $0x0,%eax
 173:	74 73                	je     1e8 <exitWait+0x98>
      else
      {
	 printf(1, "\nThis is child with PID# %d and I will exit with status %d\n" ,getpid(), -1);
      exit(-1);
  } 
    } else if (pid > 0) { // only the parent exeecutes this code
 175:	0f 8e d6 00 00 00    	jle    251 <exitWait+0x101>
      ret_pid = wait(&exit_status);
 17b:	8d 5d f4             	lea    -0xc(%ebp),%ebx
 17e:	89 1c 24             	mov    %ebx,(%esp)
 181:	e8 2a 06 00 00       	call   7b0 <wait>
      printf(1, "\n This is the parent: child with PID# %d has exited with status %d\n", ret_pid, exit_status);
 186:	8b 55 f4             	mov    -0xc(%ebp),%edx
 189:	c7 44 24 04 44 0e 00 	movl   $0xe44,0x4(%esp)
 190:	00 
 191:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 198:	89 54 24 0c          	mov    %edx,0xc(%esp)
 19c:	89 44 24 08          	mov    %eax,0x8(%esp)
 1a0:	e8 4b 07 00 00       	call   8f0 <printf>
  // use this part to test exit(int status) and wait(int* status)
 
  printf(1, "\n  Step 1: testing exit(int status) and wait(int* status):\n");

  for (i = 0; i < 2; i++) {
    pid = fork();
 1a5:	e8 f6 05 00 00       	call   7a0 <fork>
    if (pid == 0) { // only the child executed this code
 1aa:	83 f8 00             	cmp    $0x0,%eax
 1ad:	74 71                	je     220 <exitWait+0xd0>
 1af:	90                   	nop
      else
      {
	 printf(1, "\nThis is child with PID# %d and I will exit with status %d\n" ,getpid(), -1);
      exit(-1);
  } 
    } else if (pid > 0) { // only the parent exeecutes this code
 1b0:	0f 8e 9b 00 00 00    	jle    251 <exitWait+0x101>
      ret_pid = wait(&exit_status);
 1b6:	89 1c 24             	mov    %ebx,(%esp)
 1b9:	e8 f2 05 00 00       	call   7b0 <wait>
      printf(1, "\n This is the parent: child with PID# %d has exited with status %d\n", ret_pid, exit_status);
 1be:	8b 55 f4             	mov    -0xc(%ebp),%edx
 1c1:	c7 44 24 04 44 0e 00 	movl   $0xe44,0x4(%esp)
 1c8:	00 
 1c9:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 1d0:	89 54 24 0c          	mov    %edx,0xc(%esp)
 1d4:	89 44 24 08          	mov    %eax,0x8(%esp)
 1d8:	e8 13 07 00 00       	call   8f0 <printf>
	  printf(2, "\nError using fork\n");
      exit(-1);
    }
  }
  return 0;
}
 1dd:	83 c4 24             	add    $0x24,%esp
 1e0:	31 c0                	xor    %eax,%eax
 1e2:	5b                   	pop    %ebx
 1e3:	5d                   	pop    %ebp
 1e4:	c3                   	ret    
 1e5:	8d 76 00             	lea    0x0(%esi),%esi
  for (i = 0; i < 2; i++) {
    pid = fork();
    if (pid == 0) { // only the child executed this code
      if (i == 0)
      {
      printf(1, "\nThis is child with PID# %d and I will exit with status %d\n", getpid(), 0);
 1e8:	e8 3b 06 00 00       	call   828 <getpid>
 1ed:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
 1f4:	00 
 1f5:	c7 44 24 04 88 0e 00 	movl   $0xe88,0x4(%esp)
 1fc:	00 
 1fd:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 204:	89 44 24 08          	mov    %eax,0x8(%esp)
 208:	e8 e3 06 00 00       	call   8f0 <printf>
      exit(0);
 20d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 214:	e8 8f 05 00 00       	call   7a8 <exit>
 219:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  }
      else
      {
	 printf(1, "\nThis is child with PID# %d and I will exit with status %d\n" ,getpid(), -1);
 220:	e8 03 06 00 00       	call   828 <getpid>
 225:	c7 44 24 0c ff ff ff 	movl   $0xffffffff,0xc(%esp)
 22c:	ff 
 22d:	c7 44 24 04 88 0e 00 	movl   $0xe88,0x4(%esp)
 234:	00 
 235:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 23c:	89 44 24 08          	mov    %eax,0x8(%esp)
 240:	e8 ab 06 00 00       	call   8f0 <printf>
      exit(-1);
 245:	c7 04 24 ff ff ff ff 	movl   $0xffffffff,(%esp)
 24c:	e8 57 05 00 00       	call   7a8 <exit>
    } else if (pid > 0) { // only the parent exeecutes this code
      ret_pid = wait(&exit_status);
      printf(1, "\n This is the parent: child with PID# %d has exited with status %d\n", ret_pid, exit_status);
    } else  // something went wrong with fork system call
    {  
	  printf(2, "\nError using fork\n");
 251:	c7 44 24 04 67 10 00 	movl   $0x1067,0x4(%esp)
 258:	00 
 259:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
 260:	e8 8b 06 00 00       	call   8f0 <printf>
      exit(-1);
 265:	c7 04 24 ff ff ff ff 	movl   $0xffffffff,(%esp)
 26c:	e8 37 05 00 00       	call   7a8 <exit>
 271:	eb 0d                	jmp    280 <waitPid>
 273:	90                   	nop
 274:	90                   	nop
 275:	90                   	nop
 276:	90                   	nop
 277:	90                   	nop
 278:	90                   	nop
 279:	90                   	nop
 27a:	90                   	nop
 27b:	90                   	nop
 27c:	90                   	nop
 27d:	90                   	nop
 27e:	90                   	nop
 27f:	90                   	nop

00000280 <waitPid>:
    }
  }
  return 0;
}

int waitPid(void){
 280:	55                   	push   %ebp
 281:	89 e5                	mov    %esp,%ebp
 283:	56                   	push   %esi
 284:	53                   	push   %ebx
  int ret_pid, exit_status;
  int i;
  int pid_a[5]={0, 0, 0, 0, 0};
 // use this part to test wait(int pid, int* status, int options)

 printf(1, "\n  Step 2: testing waitpid(int pid, int* status, int options):\n");
 285:	31 db                	xor    %ebx,%ebx
    }
  }
  return 0;
}

int waitPid(void){
 287:	83 ec 30             	sub    $0x30,%esp
  int ret_pid, exit_status;
  int i;
  int pid_a[5]={0, 0, 0, 0, 0};
 // use this part to test wait(int pid, int* status, int options)

 printf(1, "\n  Step 2: testing waitpid(int pid, int* status, int options):\n");
 28a:	c7 44 24 04 c4 0e 00 	movl   $0xec4,0x4(%esp)
 291:	00 

  for (i = 0; i <5; i++) {
    pid_a[i] = fork();
 292:	8d 75 e0             	lea    -0x20(%ebp),%esi

int waitPid(void){
	
  int ret_pid, exit_status;
  int i;
  int pid_a[5]={0, 0, 0, 0, 0};
 295:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
 29c:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
 2a3:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
 2aa:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
 2b1:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 // use this part to test wait(int pid, int* status, int options)

 printf(1, "\n  Step 2: testing waitpid(int pid, int* status, int options):\n");
 2b8:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 2bf:	e8 2c 06 00 00       	call   8f0 <printf>

  for (i = 0; i <5; i++) {
    pid_a[i] = fork();
 2c4:	e8 d7 04 00 00       	call   7a0 <fork>
	
    if (pid_a[i] == 0) { // only the child executed this code
 2c9:	85 c0                	test   %eax,%eax
 2cb:	0f 84 d9 01 00 00    	je     4aa <waitPid+0x22a>
 // use this part to test wait(int pid, int* status, int options)

 printf(1, "\n  Step 2: testing waitpid(int pid, int* status, int options):\n");

  for (i = 0; i <5; i++) {
    pid_a[i] = fork();
 2d1:	89 04 9e             	mov    %eax,(%esi,%ebx,4)
  int pid_a[5]={0, 0, 0, 0, 0};
 // use this part to test wait(int pid, int* status, int options)

 printf(1, "\n  Step 2: testing waitpid(int pid, int* status, int options):\n");

  for (i = 0; i <5; i++) {
 2d4:	83 c3 01             	add    $0x1,%ebx
 2d7:	83 fb 05             	cmp    $0x5,%ebx
 2da:	75 e8                	jne    2c4 <waitPid+0x44>
     
      
      printf(1, "\n The is child with PID# %d and I will exit with status %d\n", getpid(), 0);
      exit(0);}}
       
      sleep(5);
 2dc:	c7 04 24 05 00 00 00 	movl   $0x5,(%esp)
      printf(1, "\n This is the parent: Now waiting for child with PID# %d\n",pid_a[3]);
      ret_pid = waitpid(pid_a[3], &exit_status, 0);
 2e3:	8d 5d f4             	lea    -0xc(%ebp),%ebx
     
      
      printf(1, "\n The is child with PID# %d and I will exit with status %d\n", getpid(), 0);
      exit(0);}}
       
      sleep(5);
 2e6:	e8 4d 05 00 00       	call   838 <sleep>
      printf(1, "\n This is the parent: Now waiting for child with PID# %d\n",pid_a[3]);
 2eb:	8b 75 ec             	mov    -0x14(%ebp),%esi
 2ee:	c7 44 24 04 40 0f 00 	movl   $0xf40,0x4(%esp)
 2f5:	00 
 2f6:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 2fd:	89 74 24 08          	mov    %esi,0x8(%esp)
 301:	e8 ea 05 00 00       	call   8f0 <printf>
      ret_pid = waitpid(pid_a[3], &exit_status, 0);
 306:	89 5c 24 04          	mov    %ebx,0x4(%esp)
 30a:	89 34 24             	mov    %esi,(%esp)
 30d:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
 314:	00 
 315:	e8 36 05 00 00       	call   850 <waitpid>
      printf(1, "\n This is the partent: Child# %d has exited with status %d\n",ret_pid, exit_status);
 31a:	8b 55 f4             	mov    -0xc(%ebp),%edx
 31d:	c7 44 24 04 7c 0f 00 	movl   $0xf7c,0x4(%esp)
 324:	00 
 325:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 32c:	89 54 24 0c          	mov    %edx,0xc(%esp)
 330:	89 44 24 08          	mov    %eax,0x8(%esp)
 334:	e8 b7 05 00 00       	call   8f0 <printf>
      sleep(5);
 339:	c7 04 24 05 00 00 00 	movl   $0x5,(%esp)
 340:	e8 f3 04 00 00       	call   838 <sleep>
      printf(1, "\n This is the parent: Now waiting for child with PID# %d\n",pid_a[1]);
 345:	8b 75 e4             	mov    -0x1c(%ebp),%esi
 348:	c7 44 24 04 40 0f 00 	movl   $0xf40,0x4(%esp)
 34f:	00 
 350:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 357:	89 74 24 08          	mov    %esi,0x8(%esp)
 35b:	e8 90 05 00 00       	call   8f0 <printf>
      ret_pid = waitpid(pid_a[1], &exit_status, 0);
 360:	89 5c 24 04          	mov    %ebx,0x4(%esp)
 364:	89 34 24             	mov    %esi,(%esp)
 367:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
 36e:	00 
 36f:	e8 dc 04 00 00       	call   850 <waitpid>
      printf(1, "\n This is the partent: Child# %d has exited with status %d\n",ret_pid, exit_status);
 374:	8b 55 f4             	mov    -0xc(%ebp),%edx
 377:	c7 44 24 04 7c 0f 00 	movl   $0xf7c,0x4(%esp)
 37e:	00 
 37f:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 386:	89 54 24 0c          	mov    %edx,0xc(%esp)
 38a:	89 44 24 08          	mov    %eax,0x8(%esp)
 38e:	e8 5d 05 00 00       	call   8f0 <printf>
      sleep(5);
 393:	c7 04 24 05 00 00 00 	movl   $0x5,(%esp)
 39a:	e8 99 04 00 00       	call   838 <sleep>
      printf(1, "\n This is the parent: Now waiting for child with PID# %d\n",pid_a[2]);
 39f:	8b 75 e8             	mov    -0x18(%ebp),%esi
 3a2:	c7 44 24 04 40 0f 00 	movl   $0xf40,0x4(%esp)
 3a9:	00 
 3aa:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 3b1:	89 74 24 08          	mov    %esi,0x8(%esp)
 3b5:	e8 36 05 00 00       	call   8f0 <printf>
      ret_pid = waitpid(pid_a[2], &exit_status, 0);
 3ba:	89 5c 24 04          	mov    %ebx,0x4(%esp)
 3be:	89 34 24             	mov    %esi,(%esp)
 3c1:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
 3c8:	00 
 3c9:	e8 82 04 00 00       	call   850 <waitpid>
      printf(1, "\n This is the partent: Child# %d has exited with status %d\n",ret_pid, exit_status);
 3ce:	8b 55 f4             	mov    -0xc(%ebp),%edx
 3d1:	c7 44 24 04 7c 0f 00 	movl   $0xf7c,0x4(%esp)
 3d8:	00 
 3d9:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 3e0:	89 54 24 0c          	mov    %edx,0xc(%esp)
 3e4:	89 44 24 08          	mov    %eax,0x8(%esp)
 3e8:	e8 03 05 00 00       	call   8f0 <printf>
      sleep(5);
 3ed:	c7 04 24 05 00 00 00 	movl   $0x5,(%esp)
 3f4:	e8 3f 04 00 00       	call   838 <sleep>
      printf(1, "\n This is the parent: Now waiting for child with PID# %d\n",pid_a[0]);
 3f9:	8b 75 e0             	mov    -0x20(%ebp),%esi
 3fc:	c7 44 24 04 40 0f 00 	movl   $0xf40,0x4(%esp)
 403:	00 
 404:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 40b:	89 74 24 08          	mov    %esi,0x8(%esp)
 40f:	e8 dc 04 00 00       	call   8f0 <printf>
      ret_pid = waitpid(pid_a[0], &exit_status, 0);
 414:	89 5c 24 04          	mov    %ebx,0x4(%esp)
 418:	89 34 24             	mov    %esi,(%esp)
 41b:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
 422:	00 
 423:	e8 28 04 00 00       	call   850 <waitpid>
      printf(1, "\n This is the partent: Child# %d has exited with status %d\n",ret_pid, exit_status);
 428:	8b 55 f4             	mov    -0xc(%ebp),%edx
 42b:	c7 44 24 04 7c 0f 00 	movl   $0xf7c,0x4(%esp)
 432:	00 
 433:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 43a:	89 54 24 0c          	mov    %edx,0xc(%esp)
 43e:	89 44 24 08          	mov    %eax,0x8(%esp)
 442:	e8 a9 04 00 00       	call   8f0 <printf>
      sleep(5);
 447:	c7 04 24 05 00 00 00 	movl   $0x5,(%esp)
 44e:	e8 e5 03 00 00       	call   838 <sleep>
      printf(1, "\n This is the parent: Now waiting for child with PID# %d\n",pid_a[4]);
 453:	8b 75 f0             	mov    -0x10(%ebp),%esi
 456:	c7 44 24 04 40 0f 00 	movl   $0xf40,0x4(%esp)
 45d:	00 
 45e:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 465:	89 74 24 08          	mov    %esi,0x8(%esp)
 469:	e8 82 04 00 00       	call   8f0 <printf>
      ret_pid = waitpid(pid_a[4], &exit_status, 0);
 46e:	89 5c 24 04          	mov    %ebx,0x4(%esp)
 472:	89 34 24             	mov    %esi,(%esp)
 475:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
 47c:	00 
 47d:	e8 ce 03 00 00       	call   850 <waitpid>
      printf(1, "\n This is the partent: Child# %d has exited with status %d\n",ret_pid, exit_status);
 482:	8b 55 f4             	mov    -0xc(%ebp),%edx
 485:	c7 44 24 04 7c 0f 00 	movl   $0xf7c,0x4(%esp)
 48c:	00 
 48d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 494:	89 54 24 0c          	mov    %edx,0xc(%esp)
 498:	89 44 24 08          	mov    %eax,0x8(%esp)
 49c:	e8 4f 04 00 00       	call   8f0 <printf>
      
      return 0;
  }
 4a1:	83 c4 30             	add    $0x30,%esp
 4a4:	31 c0                	xor    %eax,%eax
 4a6:	5b                   	pop    %ebx
 4a7:	5e                   	pop    %esi
 4a8:	5d                   	pop    %ebp
 4a9:	c3                   	ret    
    pid_a[i] = fork();
	
    if (pid_a[i] == 0) { // only the child executed this code
     
      
      printf(1, "\n The is child with PID# %d and I will exit with status %d\n", getpid(), 0);
 4aa:	e8 79 03 00 00       	call   828 <getpid>
 4af:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
 4b6:	00 
 4b7:	c7 44 24 04 04 0f 00 	movl   $0xf04,0x4(%esp)
 4be:	00 
 4bf:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 4c6:	89 44 24 08          	mov    %eax,0x8(%esp)
 4ca:	e8 21 04 00 00       	call   8f0 <printf>
      exit(0);}}
 4cf:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 4d6:	e8 cd 02 00 00       	call   7a8 <exit>
 4db:	90                   	nop
 4dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000004e0 <main>:
#include "types.h"
#include "user.h"

int main(int argc, char *argv[])
{
 4e0:	55                   	push   %ebp
 4e1:	89 e5                	mov    %esp,%ebp
 4e3:	83 e4 f0             	and    $0xfffffff0,%esp
 4e6:	53                   	push   %ebx
 4e7:	83 ec 1c             	sub    $0x1c,%esp
 4ea:	8b 5d 0c             	mov    0xc(%ebp),%ebx
	
	int exitWait(void);
	int waitPid(void);
	int PScheduler(void);

  printf(1, "\n This program tests the correctness of your lab#1\n");
 4ed:	c7 44 24 04 b8 0f 00 	movl   $0xfb8,0x4(%esp)
 4f4:	00 
 4f5:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 4fc:	e8 ef 03 00 00       	call   8f0 <printf>
  
  if (atoi(argv[1]) == 1)
 501:	8b 43 04             	mov    0x4(%ebx),%eax
 504:	89 04 24             	mov    %eax,(%esp)
 507:	e8 74 01 00 00       	call   680 <atoi>
 50c:	83 f8 01             	cmp    $0x1,%eax
 50f:	74 47                	je     558 <main+0x78>
	exitWait();
  else if (atoi(argv[1]) == 2)
 511:	8b 43 04             	mov    0x4(%ebx),%eax
 514:	89 04 24             	mov    %eax,(%esp)
 517:	e8 64 01 00 00       	call   680 <atoi>
 51c:	83 f8 02             	cmp    $0x2,%eax
 51f:	74 3f                	je     560 <main+0x80>
	waitPid();
  else if (atoi(argv[1]) == 3)
 521:	8b 43 04             	mov    0x4(%ebx),%eax
 524:	89 04 24             	mov    %eax,(%esp)
 527:	e8 54 01 00 00       	call   680 <atoi>
 52c:	83 f8 03             	cmp    $0x3,%eax
 52f:	74 37                	je     568 <main+0x88>
	PScheduler();
  else 
   printf(1, "\ntype \"lab1 1\" to test exit and wait, \"lab1 2\" to test waitpid and \"lab1 3\" to test the priority scheduler \n");
 531:	c7 44 24 04 ec 0f 00 	movl   $0xfec,0x4(%esp)
 538:	00 
 539:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 540:	e8 ab 03 00 00       	call   8f0 <printf>
  
    // End of test
	 exit(0);
 545:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 54c:	e8 57 02 00 00       	call   7a8 <exit>
 551:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
	int PScheduler(void);

  printf(1, "\n This program tests the correctness of your lab#1\n");
  
  if (atoi(argv[1]) == 1)
	exitWait();
 558:	e8 f3 fb ff ff       	call   150 <exitWait>
 55d:	eb e6                	jmp    545 <main+0x65>
 55f:	90                   	nop
  else if (atoi(argv[1]) == 2)
	waitPid();
 560:	e8 1b fd ff ff       	call   280 <waitPid>
 565:	eb de                	jmp    545 <main+0x65>
 567:	90                   	nop
 568:	90                   	nop
 569:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  else if (atoi(argv[1]) == 3)
	PScheduler();
 570:	e8 8b fa ff ff       	call   0 <PScheduler>
 575:	eb ce                	jmp    545 <main+0x65>
 577:	90                   	nop
 578:	90                   	nop
 579:	90                   	nop
 57a:	90                   	nop
 57b:	90                   	nop
 57c:	90                   	nop
 57d:	90                   	nop
 57e:	90                   	nop
 57f:	90                   	nop

00000580 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 580:	55                   	push   %ebp
 581:	31 d2                	xor    %edx,%edx
 583:	89 e5                	mov    %esp,%ebp
 585:	8b 45 08             	mov    0x8(%ebp),%eax
 588:	53                   	push   %ebx
 589:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 58c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 590:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
 594:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 597:	83 c2 01             	add    $0x1,%edx
 59a:	84 c9                	test   %cl,%cl
 59c:	75 f2                	jne    590 <strcpy+0x10>
    ;
  return os;
}
 59e:	5b                   	pop    %ebx
 59f:	5d                   	pop    %ebp
 5a0:	c3                   	ret    
 5a1:	eb 0d                	jmp    5b0 <strcmp>
 5a3:	90                   	nop
 5a4:	90                   	nop
 5a5:	90                   	nop
 5a6:	90                   	nop
 5a7:	90                   	nop
 5a8:	90                   	nop
 5a9:	90                   	nop
 5aa:	90                   	nop
 5ab:	90                   	nop
 5ac:	90                   	nop
 5ad:	90                   	nop
 5ae:	90                   	nop
 5af:	90                   	nop

000005b0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 5b0:	55                   	push   %ebp
 5b1:	89 e5                	mov    %esp,%ebp
 5b3:	8b 4d 08             	mov    0x8(%ebp),%ecx
 5b6:	53                   	push   %ebx
 5b7:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(*p && *p == *q)
 5ba:	0f b6 01             	movzbl (%ecx),%eax
 5bd:	84 c0                	test   %al,%al
 5bf:	75 14                	jne    5d5 <strcmp+0x25>
 5c1:	eb 25                	jmp    5e8 <strcmp+0x38>
 5c3:	90                   	nop
 5c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    p++, q++;
 5c8:	83 c1 01             	add    $0x1,%ecx
 5cb:	83 c2 01             	add    $0x1,%edx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 5ce:	0f b6 01             	movzbl (%ecx),%eax
 5d1:	84 c0                	test   %al,%al
 5d3:	74 13                	je     5e8 <strcmp+0x38>
 5d5:	0f b6 1a             	movzbl (%edx),%ebx
 5d8:	38 d8                	cmp    %bl,%al
 5da:	74 ec                	je     5c8 <strcmp+0x18>
 5dc:	0f b6 db             	movzbl %bl,%ebx
 5df:	0f b6 c0             	movzbl %al,%eax
 5e2:	29 d8                	sub    %ebx,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
 5e4:	5b                   	pop    %ebx
 5e5:	5d                   	pop    %ebp
 5e6:	c3                   	ret    
 5e7:	90                   	nop
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 5e8:	0f b6 1a             	movzbl (%edx),%ebx
 5eb:	31 c0                	xor    %eax,%eax
 5ed:	0f b6 db             	movzbl %bl,%ebx
 5f0:	29 d8                	sub    %ebx,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
 5f2:	5b                   	pop    %ebx
 5f3:	5d                   	pop    %ebp
 5f4:	c3                   	ret    
 5f5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 5f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000600 <strlen>:

uint
strlen(char *s)
{
 600:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
 601:	31 d2                	xor    %edx,%edx
  return (uchar)*p - (uchar)*q;
}

uint
strlen(char *s)
{
 603:	89 e5                	mov    %esp,%ebp
  int n;

  for(n = 0; s[n]; n++)
 605:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
}

uint
strlen(char *s)
{
 607:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 60a:	80 39 00             	cmpb   $0x0,(%ecx)
 60d:	74 0c                	je     61b <strlen+0x1b>
 60f:	90                   	nop
 610:	83 c2 01             	add    $0x1,%edx
 613:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 617:	89 d0                	mov    %edx,%eax
 619:	75 f5                	jne    610 <strlen+0x10>
    ;
  return n;
}
 61b:	5d                   	pop    %ebp
 61c:	c3                   	ret    
 61d:	8d 76 00             	lea    0x0(%esi),%esi

00000620 <memset>:

void*
memset(void *dst, int c, uint n)
{
 620:	55                   	push   %ebp
 621:	89 e5                	mov    %esp,%ebp
 623:	8b 55 08             	mov    0x8(%ebp),%edx
 626:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 627:	8b 4d 10             	mov    0x10(%ebp),%ecx
 62a:	8b 45 0c             	mov    0xc(%ebp),%eax
 62d:	89 d7                	mov    %edx,%edi
 62f:	fc                   	cld    
 630:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 632:	89 d0                	mov    %edx,%eax
 634:	5f                   	pop    %edi
 635:	5d                   	pop    %ebp
 636:	c3                   	ret    
 637:	89 f6                	mov    %esi,%esi
 639:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000640 <strchr>:

char*
strchr(const char *s, char c)
{
 640:	55                   	push   %ebp
 641:	89 e5                	mov    %esp,%ebp
 643:	8b 45 08             	mov    0x8(%ebp),%eax
 646:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 64a:	0f b6 10             	movzbl (%eax),%edx
 64d:	84 d2                	test   %dl,%dl
 64f:	75 11                	jne    662 <strchr+0x22>
 651:	eb 15                	jmp    668 <strchr+0x28>
 653:	90                   	nop
 654:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 658:	83 c0 01             	add    $0x1,%eax
 65b:	0f b6 10             	movzbl (%eax),%edx
 65e:	84 d2                	test   %dl,%dl
 660:	74 06                	je     668 <strchr+0x28>
    if(*s == c)
 662:	38 ca                	cmp    %cl,%dl
 664:	75 f2                	jne    658 <strchr+0x18>
      return (char*)s;
  return 0;
}
 666:	5d                   	pop    %ebp
 667:	c3                   	ret    
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 668:	31 c0                	xor    %eax,%eax
    if(*s == c)
      return (char*)s;
  return 0;
}
 66a:	5d                   	pop    %ebp
 66b:	90                   	nop
 66c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 670:	c3                   	ret    
 671:	eb 0d                	jmp    680 <atoi>
 673:	90                   	nop
 674:	90                   	nop
 675:	90                   	nop
 676:	90                   	nop
 677:	90                   	nop
 678:	90                   	nop
 679:	90                   	nop
 67a:	90                   	nop
 67b:	90                   	nop
 67c:	90                   	nop
 67d:	90                   	nop
 67e:	90                   	nop
 67f:	90                   	nop

00000680 <atoi>:
  return r;
}

int
atoi(const char *s)
{
 680:	55                   	push   %ebp
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 681:	31 c0                	xor    %eax,%eax
  return r;
}

int
atoi(const char *s)
{
 683:	89 e5                	mov    %esp,%ebp
 685:	8b 4d 08             	mov    0x8(%ebp),%ecx
 688:	53                   	push   %ebx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 689:	0f b6 11             	movzbl (%ecx),%edx
 68c:	8d 5a d0             	lea    -0x30(%edx),%ebx
 68f:	80 fb 09             	cmp    $0x9,%bl
 692:	77 1c                	ja     6b0 <atoi+0x30>
 694:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    n = n*10 + *s++ - '0';
 698:	0f be d2             	movsbl %dl,%edx
 69b:	83 c1 01             	add    $0x1,%ecx
 69e:	8d 04 80             	lea    (%eax,%eax,4),%eax
 6a1:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 6a5:	0f b6 11             	movzbl (%ecx),%edx
 6a8:	8d 5a d0             	lea    -0x30(%edx),%ebx
 6ab:	80 fb 09             	cmp    $0x9,%bl
 6ae:	76 e8                	jbe    698 <atoi+0x18>
    n = n*10 + *s++ - '0';
  return n;
}
 6b0:	5b                   	pop    %ebx
 6b1:	5d                   	pop    %ebp
 6b2:	c3                   	ret    
 6b3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 6b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000006c0 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 6c0:	55                   	push   %ebp
 6c1:	89 e5                	mov    %esp,%ebp
 6c3:	56                   	push   %esi
 6c4:	8b 45 08             	mov    0x8(%ebp),%eax
 6c7:	53                   	push   %ebx
 6c8:	8b 5d 10             	mov    0x10(%ebp),%ebx
 6cb:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 6ce:	85 db                	test   %ebx,%ebx
 6d0:	7e 14                	jle    6e6 <memmove+0x26>
    n = n*10 + *s++ - '0';
  return n;
}

void*
memmove(void *vdst, void *vsrc, int n)
 6d2:	31 d2                	xor    %edx,%edx
 6d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    *dst++ = *src++;
 6d8:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 6dc:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 6df:	83 c2 01             	add    $0x1,%edx
{
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 6e2:	39 da                	cmp    %ebx,%edx
 6e4:	75 f2                	jne    6d8 <memmove+0x18>
    *dst++ = *src++;
  return vdst;
}
 6e6:	5b                   	pop    %ebx
 6e7:	5e                   	pop    %esi
 6e8:	5d                   	pop    %ebp
 6e9:	c3                   	ret    
 6ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000006f0 <stat>:
  return buf;
}

int
stat(char *n, struct stat *st)
{
 6f0:	55                   	push   %ebp
 6f1:	89 e5                	mov    %esp,%ebp
 6f3:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 6f6:	8b 45 08             	mov    0x8(%ebp),%eax
  return buf;
}

int
stat(char *n, struct stat *st)
{
 6f9:	89 5d f8             	mov    %ebx,-0x8(%ebp)
 6fc:	89 75 fc             	mov    %esi,-0x4(%ebp)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
 6ff:	be ff ff ff ff       	mov    $0xffffffff,%esi
stat(char *n, struct stat *st)
{
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 704:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 70b:	00 
 70c:	89 04 24             	mov    %eax,(%esp)
 70f:	e8 d4 00 00 00       	call   7e8 <open>
  if(fd < 0)
 714:	85 c0                	test   %eax,%eax
stat(char *n, struct stat *st)
{
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 716:	89 c3                	mov    %eax,%ebx
  if(fd < 0)
 718:	78 19                	js     733 <stat+0x43>
    return -1;
  r = fstat(fd, st);
 71a:	8b 45 0c             	mov    0xc(%ebp),%eax
 71d:	89 1c 24             	mov    %ebx,(%esp)
 720:	89 44 24 04          	mov    %eax,0x4(%esp)
 724:	e8 d7 00 00 00       	call   800 <fstat>
  close(fd);
 729:	89 1c 24             	mov    %ebx,(%esp)
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
  r = fstat(fd, st);
 72c:	89 c6                	mov    %eax,%esi
  close(fd);
 72e:	e8 9d 00 00 00       	call   7d0 <close>
  return r;
}
 733:	89 f0                	mov    %esi,%eax
 735:	8b 5d f8             	mov    -0x8(%ebp),%ebx
 738:	8b 75 fc             	mov    -0x4(%ebp),%esi
 73b:	89 ec                	mov    %ebp,%esp
 73d:	5d                   	pop    %ebp
 73e:	c3                   	ret    
 73f:	90                   	nop

00000740 <gets>:
  return 0;
}

char*
gets(char *buf, int max)
{
 740:	55                   	push   %ebp
 741:	89 e5                	mov    %esp,%ebp
 743:	57                   	push   %edi
 744:	56                   	push   %esi
 745:	31 f6                	xor    %esi,%esi
 747:	53                   	push   %ebx
 748:	83 ec 2c             	sub    $0x2c,%esp
 74b:	8b 7d 08             	mov    0x8(%ebp),%edi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 74e:	eb 06                	jmp    756 <gets+0x16>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 750:	3c 0a                	cmp    $0xa,%al
 752:	74 39                	je     78d <gets+0x4d>
 754:	89 de                	mov    %ebx,%esi
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 756:	8d 5e 01             	lea    0x1(%esi),%ebx
 759:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 75c:	7d 31                	jge    78f <gets+0x4f>
    cc = read(0, &c, 1);
 75e:	8d 45 e7             	lea    -0x19(%ebp),%eax
 761:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 768:	00 
 769:	89 44 24 04          	mov    %eax,0x4(%esp)
 76d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 774:	e8 47 00 00 00       	call   7c0 <read>
    if(cc < 1)
 779:	85 c0                	test   %eax,%eax
 77b:	7e 12                	jle    78f <gets+0x4f>
      break;
    buf[i++] = c;
 77d:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 781:	88 44 1f ff          	mov    %al,-0x1(%edi,%ebx,1)
    if(c == '\n' || c == '\r')
 785:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 789:	3c 0d                	cmp    $0xd,%al
 78b:	75 c3                	jne    750 <gets+0x10>
 78d:	89 de                	mov    %ebx,%esi
      break;
  }
  buf[i] = '\0';
 78f:	c6 04 37 00          	movb   $0x0,(%edi,%esi,1)
  return buf;
}
 793:	89 f8                	mov    %edi,%eax
 795:	83 c4 2c             	add    $0x2c,%esp
 798:	5b                   	pop    %ebx
 799:	5e                   	pop    %esi
 79a:	5f                   	pop    %edi
 79b:	5d                   	pop    %ebp
 79c:	c3                   	ret    
 79d:	90                   	nop
 79e:	90                   	nop
 79f:	90                   	nop

000007a0 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 7a0:	b8 01 00 00 00       	mov    $0x1,%eax
 7a5:	cd 40                	int    $0x40
 7a7:	c3                   	ret    

000007a8 <exit>:
SYSCALL(exit)
 7a8:	b8 02 00 00 00       	mov    $0x2,%eax
 7ad:	cd 40                	int    $0x40
 7af:	c3                   	ret    

000007b0 <wait>:
SYSCALL(wait)
 7b0:	b8 03 00 00 00       	mov    $0x3,%eax
 7b5:	cd 40                	int    $0x40
 7b7:	c3                   	ret    

000007b8 <pipe>:
SYSCALL(pipe)
 7b8:	b8 04 00 00 00       	mov    $0x4,%eax
 7bd:	cd 40                	int    $0x40
 7bf:	c3                   	ret    

000007c0 <read>:
SYSCALL(read)
 7c0:	b8 05 00 00 00       	mov    $0x5,%eax
 7c5:	cd 40                	int    $0x40
 7c7:	c3                   	ret    

000007c8 <write>:
SYSCALL(write)
 7c8:	b8 10 00 00 00       	mov    $0x10,%eax
 7cd:	cd 40                	int    $0x40
 7cf:	c3                   	ret    

000007d0 <close>:
SYSCALL(close)
 7d0:	b8 15 00 00 00       	mov    $0x15,%eax
 7d5:	cd 40                	int    $0x40
 7d7:	c3                   	ret    

000007d8 <kill>:
SYSCALL(kill)
 7d8:	b8 06 00 00 00       	mov    $0x6,%eax
 7dd:	cd 40                	int    $0x40
 7df:	c3                   	ret    

000007e0 <exec>:
SYSCALL(exec)
 7e0:	b8 07 00 00 00       	mov    $0x7,%eax
 7e5:	cd 40                	int    $0x40
 7e7:	c3                   	ret    

000007e8 <open>:
SYSCALL(open)
 7e8:	b8 0f 00 00 00       	mov    $0xf,%eax
 7ed:	cd 40                	int    $0x40
 7ef:	c3                   	ret    

000007f0 <mknod>:
SYSCALL(mknod)
 7f0:	b8 11 00 00 00       	mov    $0x11,%eax
 7f5:	cd 40                	int    $0x40
 7f7:	c3                   	ret    

000007f8 <unlink>:
SYSCALL(unlink)
 7f8:	b8 12 00 00 00       	mov    $0x12,%eax
 7fd:	cd 40                	int    $0x40
 7ff:	c3                   	ret    

00000800 <fstat>:
SYSCALL(fstat)
 800:	b8 08 00 00 00       	mov    $0x8,%eax
 805:	cd 40                	int    $0x40
 807:	c3                   	ret    

00000808 <link>:
SYSCALL(link)
 808:	b8 13 00 00 00       	mov    $0x13,%eax
 80d:	cd 40                	int    $0x40
 80f:	c3                   	ret    

00000810 <mkdir>:
SYSCALL(mkdir)
 810:	b8 14 00 00 00       	mov    $0x14,%eax
 815:	cd 40                	int    $0x40
 817:	c3                   	ret    

00000818 <chdir>:
SYSCALL(chdir)
 818:	b8 09 00 00 00       	mov    $0x9,%eax
 81d:	cd 40                	int    $0x40
 81f:	c3                   	ret    

00000820 <dup>:
SYSCALL(dup)
 820:	b8 0a 00 00 00       	mov    $0xa,%eax
 825:	cd 40                	int    $0x40
 827:	c3                   	ret    

00000828 <getpid>:
SYSCALL(getpid)
 828:	b8 0b 00 00 00       	mov    $0xb,%eax
 82d:	cd 40                	int    $0x40
 82f:	c3                   	ret    

00000830 <sbrk>:
SYSCALL(sbrk)
 830:	b8 0c 00 00 00       	mov    $0xc,%eax
 835:	cd 40                	int    $0x40
 837:	c3                   	ret    

00000838 <sleep>:
SYSCALL(sleep)
 838:	b8 0d 00 00 00       	mov    $0xd,%eax
 83d:	cd 40                	int    $0x40
 83f:	c3                   	ret    

00000840 <uptime>:
SYSCALL(uptime)
 840:	b8 0e 00 00 00       	mov    $0xe,%eax
 845:	cd 40                	int    $0x40
 847:	c3                   	ret    

00000848 <hello>:
SYSCALL(hello) 			// added for Lab0
 848:	b8 16 00 00 00       	mov    $0x16,%eax
 84d:	cd 40                	int    $0x40
 84f:	c3                   	ret    

00000850 <waitpid>:
SYSCALL(waitpid) 		// lab1 part 1: c
 850:	b8 17 00 00 00       	mov    $0x17,%eax
 855:	cd 40                	int    $0x40
 857:	c3                   	ret    

00000858 <setpriority>:
SYSCALL(setpriority) 	// lab1 part 2: define syscall
 858:	b8 18 00 00 00       	mov    $0x18,%eax
 85d:	cd 40                	int    $0x40
 85f:	c3                   	ret    

00000860 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 860:	55                   	push   %ebp
 861:	89 e5                	mov    %esp,%ebp
 863:	57                   	push   %edi
 864:	89 cf                	mov    %ecx,%edi
 866:	56                   	push   %esi
 867:	89 c6                	mov    %eax,%esi
 869:	53                   	push   %ebx
 86a:	83 ec 4c             	sub    $0x4c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 86d:	8b 4d 08             	mov    0x8(%ebp),%ecx
 870:	85 c9                	test   %ecx,%ecx
 872:	74 04                	je     878 <printint+0x18>
 874:	85 d2                	test   %edx,%edx
 876:	78 68                	js     8e0 <printint+0x80>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 878:	89 d0                	mov    %edx,%eax
 87a:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 881:	31 c9                	xor    %ecx,%ecx
 883:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 886:	66 90                	xchg   %ax,%ax
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
 888:	31 d2                	xor    %edx,%edx
 88a:	f7 f7                	div    %edi
 88c:	0f b6 92 81 10 00 00 	movzbl 0x1081(%edx),%edx
 893:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
 896:	83 c1 01             	add    $0x1,%ecx
  }while((x /= base) != 0);
 899:	85 c0                	test   %eax,%eax
 89b:	75 eb                	jne    888 <printint+0x28>
  if(neg)
 89d:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 8a0:	85 c0                	test   %eax,%eax
 8a2:	74 08                	je     8ac <printint+0x4c>
    buf[i++] = '-';
 8a4:	c6 44 0d d7 2d       	movb   $0x2d,-0x29(%ebp,%ecx,1)
 8a9:	83 c1 01             	add    $0x1,%ecx

  while(--i >= 0)
 8ac:	8d 79 ff             	lea    -0x1(%ecx),%edi
 8af:	90                   	nop
 8b0:	0f b6 04 3b          	movzbl (%ebx,%edi,1),%eax
 8b4:	83 ef 01             	sub    $0x1,%edi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 8b7:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 8be:	00 
 8bf:	89 34 24             	mov    %esi,(%esp)
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 8c2:	88 45 e7             	mov    %al,-0x19(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 8c5:	8d 45 e7             	lea    -0x19(%ebp),%eax
 8c8:	89 44 24 04          	mov    %eax,0x4(%esp)
 8cc:	e8 f7 fe ff ff       	call   7c8 <write>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 8d1:	83 ff ff             	cmp    $0xffffffff,%edi
 8d4:	75 da                	jne    8b0 <printint+0x50>
    putc(fd, buf[i]);
}
 8d6:	83 c4 4c             	add    $0x4c,%esp
 8d9:	5b                   	pop    %ebx
 8da:	5e                   	pop    %esi
 8db:	5f                   	pop    %edi
 8dc:	5d                   	pop    %ebp
 8dd:	c3                   	ret    
 8de:	66 90                	xchg   %ax,%ax
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 8e0:	89 d0                	mov    %edx,%eax
 8e2:	f7 d8                	neg    %eax
 8e4:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
 8eb:	eb 94                	jmp    881 <printint+0x21>
 8ed:	8d 76 00             	lea    0x0(%esi),%esi

000008f0 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 8f0:	55                   	push   %ebp
 8f1:	89 e5                	mov    %esp,%ebp
 8f3:	57                   	push   %edi
 8f4:	56                   	push   %esi
 8f5:	53                   	push   %ebx
 8f6:	83 ec 3c             	sub    $0x3c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 8f9:	8b 45 0c             	mov    0xc(%ebp),%eax
 8fc:	0f b6 10             	movzbl (%eax),%edx
 8ff:	84 d2                	test   %dl,%dl
 901:	0f 84 c1 00 00 00    	je     9c8 <printf+0xd8>
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
 907:	8d 4d 10             	lea    0x10(%ebp),%ecx
 90a:	31 ff                	xor    %edi,%edi
 90c:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
 90f:	31 db                	xor    %ebx,%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 911:	8d 75 e7             	lea    -0x19(%ebp),%esi
 914:	eb 1e                	jmp    934 <printf+0x44>
 916:	66 90                	xchg   %ax,%ax
  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 918:	83 fa 25             	cmp    $0x25,%edx
 91b:	0f 85 af 00 00 00    	jne    9d0 <printf+0xe0>
 921:	66 bf 25 00          	mov    $0x25,%di
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 925:	83 c3 01             	add    $0x1,%ebx
 928:	0f b6 14 18          	movzbl (%eax,%ebx,1),%edx
 92c:	84 d2                	test   %dl,%dl
 92e:	0f 84 94 00 00 00    	je     9c8 <printf+0xd8>
    c = fmt[i] & 0xff;
    if(state == 0){
 934:	85 ff                	test   %edi,%edi
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
 936:	0f b6 d2             	movzbl %dl,%edx
    if(state == 0){
 939:	74 dd                	je     918 <printf+0x28>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 93b:	83 ff 25             	cmp    $0x25,%edi
 93e:	75 e5                	jne    925 <printf+0x35>
      if(c == 'd'){
 940:	83 fa 64             	cmp    $0x64,%edx
 943:	0f 84 3f 01 00 00    	je     a88 <printf+0x198>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 949:	83 fa 70             	cmp    $0x70,%edx
 94c:	0f 84 a6 00 00 00    	je     9f8 <printf+0x108>
 952:	83 fa 78             	cmp    $0x78,%edx
 955:	0f 84 9d 00 00 00    	je     9f8 <printf+0x108>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 95b:	83 fa 73             	cmp    $0x73,%edx
 95e:	66 90                	xchg   %ax,%ax
 960:	0f 84 ba 00 00 00    	je     a20 <printf+0x130>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 966:	83 fa 63             	cmp    $0x63,%edx
 969:	0f 84 41 01 00 00    	je     ab0 <printf+0x1c0>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 96f:	83 fa 25             	cmp    $0x25,%edx
 972:	0f 84 00 01 00 00    	je     a78 <printf+0x188>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 978:	8b 4d 08             	mov    0x8(%ebp),%ecx
 97b:	89 55 cc             	mov    %edx,-0x34(%ebp)
 97e:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 982:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 989:	00 
 98a:	89 74 24 04          	mov    %esi,0x4(%esp)
 98e:	89 0c 24             	mov    %ecx,(%esp)
 991:	e8 32 fe ff ff       	call   7c8 <write>
 996:	8b 55 cc             	mov    -0x34(%ebp),%edx
 999:	88 55 e7             	mov    %dl,-0x19(%ebp)
 99c:	8b 45 08             	mov    0x8(%ebp),%eax
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 99f:	83 c3 01             	add    $0x1,%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 9a2:	31 ff                	xor    %edi,%edi
 9a4:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 9ab:	00 
 9ac:	89 74 24 04          	mov    %esi,0x4(%esp)
 9b0:	89 04 24             	mov    %eax,(%esp)
 9b3:	e8 10 fe ff ff       	call   7c8 <write>
 9b8:	8b 45 0c             	mov    0xc(%ebp),%eax
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 9bb:	0f b6 14 18          	movzbl (%eax,%ebx,1),%edx
 9bf:	84 d2                	test   %dl,%dl
 9c1:	0f 85 6d ff ff ff    	jne    934 <printf+0x44>
 9c7:	90                   	nop
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 9c8:	83 c4 3c             	add    $0x3c,%esp
 9cb:	5b                   	pop    %ebx
 9cc:	5e                   	pop    %esi
 9cd:	5f                   	pop    %edi
 9ce:	5d                   	pop    %ebp
 9cf:	c3                   	ret    
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 9d0:	8b 45 08             	mov    0x8(%ebp),%eax
  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 9d3:	88 55 e7             	mov    %dl,-0x19(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 9d6:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 9dd:	00 
 9de:	89 74 24 04          	mov    %esi,0x4(%esp)
 9e2:	89 04 24             	mov    %eax,(%esp)
 9e5:	e8 de fd ff ff       	call   7c8 <write>
 9ea:	8b 45 0c             	mov    0xc(%ebp),%eax
 9ed:	e9 33 ff ff ff       	jmp    925 <printf+0x35>
 9f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 9f8:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 9fb:	b9 10 00 00 00       	mov    $0x10,%ecx
        ap++;
 a00:	31 ff                	xor    %edi,%edi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 a02:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 a09:	8b 10                	mov    (%eax),%edx
 a0b:	8b 45 08             	mov    0x8(%ebp),%eax
 a0e:	e8 4d fe ff ff       	call   860 <printint>
 a13:	8b 45 0c             	mov    0xc(%ebp),%eax
        ap++;
 a16:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
 a1a:	e9 06 ff ff ff       	jmp    925 <printf+0x35>
 a1f:	90                   	nop
      } else if(c == 's'){
        s = (char*)*ap;
 a20:	8b 55 d4             	mov    -0x2c(%ebp),%edx
        ap++;
        if(s == 0)
 a23:	b9 7a 10 00 00       	mov    $0x107a,%ecx
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
        s = (char*)*ap;
 a28:	8b 3a                	mov    (%edx),%edi
        ap++;
 a2a:	83 c2 04             	add    $0x4,%edx
 a2d:	89 55 d4             	mov    %edx,-0x2c(%ebp)
        if(s == 0)
 a30:	85 ff                	test   %edi,%edi
 a32:	0f 44 f9             	cmove  %ecx,%edi
          s = "(null)";
        while(*s != 0){
 a35:	0f b6 17             	movzbl (%edi),%edx
 a38:	84 d2                	test   %dl,%dl
 a3a:	74 33                	je     a6f <printf+0x17f>
 a3c:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 a3f:	8b 5d 08             	mov    0x8(%ebp),%ebx
 a42:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
          putc(fd, *s);
          s++;
 a48:	83 c7 01             	add    $0x1,%edi
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 a4b:	88 55 e7             	mov    %dl,-0x19(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 a4e:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 a55:	00 
 a56:	89 74 24 04          	mov    %esi,0x4(%esp)
 a5a:	89 1c 24             	mov    %ebx,(%esp)
 a5d:	e8 66 fd ff ff       	call   7c8 <write>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 a62:	0f b6 17             	movzbl (%edi),%edx
 a65:	84 d2                	test   %dl,%dl
 a67:	75 df                	jne    a48 <printf+0x158>
 a69:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 a6c:	8b 45 0c             	mov    0xc(%ebp),%eax
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 a6f:	31 ff                	xor    %edi,%edi
 a71:	e9 af fe ff ff       	jmp    925 <printf+0x35>
 a76:	66 90                	xchg   %ax,%ax
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 a78:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 a7c:	e9 1b ff ff ff       	jmp    99c <printf+0xac>
 a81:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 a88:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 a8b:	b9 0a 00 00 00       	mov    $0xa,%ecx
        ap++;
 a90:	66 31 ff             	xor    %di,%di
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 a93:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 a9a:	8b 10                	mov    (%eax),%edx
 a9c:	8b 45 08             	mov    0x8(%ebp),%eax
 a9f:	e8 bc fd ff ff       	call   860 <printint>
 aa4:	8b 45 0c             	mov    0xc(%ebp),%eax
        ap++;
 aa7:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
 aab:	e9 75 fe ff ff       	jmp    925 <printf+0x35>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 ab0:	8b 55 d4             	mov    -0x2c(%ebp),%edx
        putc(fd, *ap);
        ap++;
 ab3:	31 ff                	xor    %edi,%edi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 ab5:	8b 4d 08             	mov    0x8(%ebp),%ecx
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 ab8:	8b 02                	mov    (%edx),%eax
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 aba:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 ac1:	00 
 ac2:	89 74 24 04          	mov    %esi,0x4(%esp)
 ac6:	89 0c 24             	mov    %ecx,(%esp)
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 ac9:	88 45 e7             	mov    %al,-0x19(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 acc:	e8 f7 fc ff ff       	call   7c8 <write>
 ad1:	8b 45 0c             	mov    0xc(%ebp),%eax
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
        ap++;
 ad4:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
 ad8:	e9 48 fe ff ff       	jmp    925 <printf+0x35>
 add:	90                   	nop
 ade:	90                   	nop
 adf:	90                   	nop

00000ae0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 ae0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 ae1:	a1 9c 10 00 00       	mov    0x109c,%eax
static Header base;
static Header *freep;

void
free(void *ap)
{
 ae6:	89 e5                	mov    %esp,%ebp
 ae8:	57                   	push   %edi
 ae9:	56                   	push   %esi
 aea:	53                   	push   %ebx
 aeb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
 aee:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 af1:	39 c8                	cmp    %ecx,%eax
 af3:	73 1d                	jae    b12 <free+0x32>
 af5:	8d 76 00             	lea    0x0(%esi),%esi
 af8:	8b 10                	mov    (%eax),%edx
 afa:	39 d1                	cmp    %edx,%ecx
 afc:	72 1a                	jb     b18 <free+0x38>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 afe:	39 d0                	cmp    %edx,%eax
 b00:	72 08                	jb     b0a <free+0x2a>
 b02:	39 c8                	cmp    %ecx,%eax
 b04:	72 12                	jb     b18 <free+0x38>
 b06:	39 d1                	cmp    %edx,%ecx
 b08:	72 0e                	jb     b18 <free+0x38>
 b0a:	89 d0                	mov    %edx,%eax
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 b0c:	39 c8                	cmp    %ecx,%eax
 b0e:	66 90                	xchg   %ax,%ax
 b10:	72 e6                	jb     af8 <free+0x18>
 b12:	8b 10                	mov    (%eax),%edx
 b14:	eb e8                	jmp    afe <free+0x1e>
 b16:	66 90                	xchg   %ax,%ax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 b18:	8b 71 04             	mov    0x4(%ecx),%esi
 b1b:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 b1e:	39 d7                	cmp    %edx,%edi
 b20:	74 19                	je     b3b <free+0x5b>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 b22:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 b25:	8b 50 04             	mov    0x4(%eax),%edx
 b28:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 b2b:	39 ce                	cmp    %ecx,%esi
 b2d:	74 23                	je     b52 <free+0x72>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 b2f:	89 08                	mov    %ecx,(%eax)
  freep = p;
 b31:	a3 9c 10 00 00       	mov    %eax,0x109c
}
 b36:	5b                   	pop    %ebx
 b37:	5e                   	pop    %esi
 b38:	5f                   	pop    %edi
 b39:	5d                   	pop    %ebp
 b3a:	c3                   	ret    
  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 b3b:	03 72 04             	add    0x4(%edx),%esi
 b3e:	89 71 04             	mov    %esi,0x4(%ecx)
    bp->s.ptr = p->s.ptr->s.ptr;
 b41:	8b 10                	mov    (%eax),%edx
 b43:	8b 12                	mov    (%edx),%edx
 b45:	89 53 f8             	mov    %edx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 b48:	8b 50 04             	mov    0x4(%eax),%edx
 b4b:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 b4e:	39 ce                	cmp    %ecx,%esi
 b50:	75 dd                	jne    b2f <free+0x4f>
    p->s.size += bp->s.size;
 b52:	03 51 04             	add    0x4(%ecx),%edx
 b55:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 b58:	8b 53 f8             	mov    -0x8(%ebx),%edx
 b5b:	89 10                	mov    %edx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
 b5d:	a3 9c 10 00 00       	mov    %eax,0x109c
}
 b62:	5b                   	pop    %ebx
 b63:	5e                   	pop    %esi
 b64:	5f                   	pop    %edi
 b65:	5d                   	pop    %ebp
 b66:	c3                   	ret    
 b67:	89 f6                	mov    %esi,%esi
 b69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000b70 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 b70:	55                   	push   %ebp
 b71:	89 e5                	mov    %esp,%ebp
 b73:	57                   	push   %edi
 b74:	56                   	push   %esi
 b75:	53                   	push   %ebx
 b76:	83 ec 2c             	sub    $0x2c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 b79:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if((prevp = freep) == 0){
 b7c:	8b 0d 9c 10 00 00    	mov    0x109c,%ecx
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 b82:	83 c3 07             	add    $0x7,%ebx
 b85:	c1 eb 03             	shr    $0x3,%ebx
 b88:	83 c3 01             	add    $0x1,%ebx
  if((prevp = freep) == 0){
 b8b:	85 c9                	test   %ecx,%ecx
 b8d:	0f 84 9b 00 00 00    	je     c2e <malloc+0xbe>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 b93:	8b 01                	mov    (%ecx),%eax
    if(p->s.size >= nunits){
 b95:	8b 50 04             	mov    0x4(%eax),%edx
 b98:	39 d3                	cmp    %edx,%ebx
 b9a:	76 27                	jbe    bc3 <malloc+0x53>
        p->s.size -= nunits;
        p += p->s.size;
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
 b9c:	8d 3c dd 00 00 00 00 	lea    0x0(,%ebx,8),%edi
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < 4096)
 ba3:	be 00 80 00 00       	mov    $0x8000,%esi
 ba8:	89 7d e4             	mov    %edi,-0x1c(%ebp)
 bab:	90                   	nop
 bac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 bb0:	3b 05 9c 10 00 00    	cmp    0x109c,%eax
 bb6:	74 30                	je     be8 <malloc+0x78>
 bb8:	89 c1                	mov    %eax,%ecx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 bba:	8b 01                	mov    (%ecx),%eax
    if(p->s.size >= nunits){
 bbc:	8b 50 04             	mov    0x4(%eax),%edx
 bbf:	39 d3                	cmp    %edx,%ebx
 bc1:	77 ed                	ja     bb0 <malloc+0x40>
      if(p->s.size == nunits)
 bc3:	39 d3                	cmp    %edx,%ebx
 bc5:	74 61                	je     c28 <malloc+0xb8>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 bc7:	29 da                	sub    %ebx,%edx
 bc9:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 bcc:	8d 04 d0             	lea    (%eax,%edx,8),%eax
        p->s.size = nunits;
 bcf:	89 58 04             	mov    %ebx,0x4(%eax)
      }
      freep = prevp;
 bd2:	89 0d 9c 10 00 00    	mov    %ecx,0x109c
      return (void*)(p + 1);
 bd8:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 bdb:	83 c4 2c             	add    $0x2c,%esp
 bde:	5b                   	pop    %ebx
 bdf:	5e                   	pop    %esi
 be0:	5f                   	pop    %edi
 be1:	5d                   	pop    %ebp
 be2:	c3                   	ret    
 be3:	90                   	nop
 be4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < 4096)
 be8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 beb:	81 fb 00 10 00 00    	cmp    $0x1000,%ebx
 bf1:	bf 00 10 00 00       	mov    $0x1000,%edi
 bf6:	0f 43 fb             	cmovae %ebx,%edi
 bf9:	0f 42 c6             	cmovb  %esi,%eax
    nu = 4096;
  p = sbrk(nu * sizeof(Header));
 bfc:	89 04 24             	mov    %eax,(%esp)
 bff:	e8 2c fc ff ff       	call   830 <sbrk>
  if(p == (char*)-1)
 c04:	83 f8 ff             	cmp    $0xffffffff,%eax
 c07:	74 18                	je     c21 <malloc+0xb1>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
 c09:	89 78 04             	mov    %edi,0x4(%eax)
  free((void*)(hp + 1));
 c0c:	83 c0 08             	add    $0x8,%eax
 c0f:	89 04 24             	mov    %eax,(%esp)
 c12:	e8 c9 fe ff ff       	call   ae0 <free>
  return freep;
 c17:	8b 0d 9c 10 00 00    	mov    0x109c,%ecx
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
 c1d:	85 c9                	test   %ecx,%ecx
 c1f:	75 99                	jne    bba <malloc+0x4a>
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 c21:	31 c0                	xor    %eax,%eax
 c23:	eb b6                	jmp    bdb <malloc+0x6b>
 c25:	8d 76 00             	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
 c28:	8b 10                	mov    (%eax),%edx
 c2a:	89 11                	mov    %edx,(%ecx)
 c2c:	eb a4                	jmp    bd2 <malloc+0x62>
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 c2e:	c7 05 9c 10 00 00 94 	movl   $0x1094,0x109c
 c35:	10 00 00 
    base.s.size = 0;
 c38:	b9 94 10 00 00       	mov    $0x1094,%ecx
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 c3d:	c7 05 94 10 00 00 94 	movl   $0x1094,0x1094
 c44:	10 00 00 
    base.s.size = 0;
 c47:	c7 05 98 10 00 00 00 	movl   $0x0,0x1098
 c4e:	00 00 00 
 c51:	e9 3d ff ff ff       	jmp    b93 <malloc+0x23>
