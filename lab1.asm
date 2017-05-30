
_lab1:     file format elf32-i386


Disassembly of section .text:

00001000 <PScheduler>:
      
      return 0;
  }
      
      
     int PScheduler(void){
    1000:	55                   	push   %ebp
    1001:	89 e5                	mov    %esp,%ebp
    1003:	53                   	push   %ebx
    1004:	83 ec 24             	sub    $0x24,%esp
    // 0 is the highest priority. All processes have a default priority of 20 

  int pid, ret_pid, exit_status;
  int i,j,k;
  
    printf(1, "\n  Step 2: testing the priority scheduler and setpriority(int priority)) systema call:\n");
    1007:	c7 44 24 04 68 1c 00 	movl   $0x1c68,0x4(%esp)
    100e:	00 
    100f:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1016:	e8 e5 08 00 00       	call   1900 <printf>
    printf(1, "\n  Step 2: Assuming that the priorities range between range between 0 to 63\n");
    101b:	c7 44 24 04 c0 1c 00 	movl   $0x1cc0,0x4(%esp)
    1022:	00 
    1023:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    102a:	e8 d1 08 00 00       	call   1900 <printf>
    printf(1, "\n  Step 2: 0 is the highest priority. All processes have a default priority of 20\n");
    102f:	c7 44 24 04 10 1d 00 	movl   $0x1d10,0x4(%esp)
    1036:	00 
    1037:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    103e:	e8 bd 08 00 00       	call   1900 <printf>
    printf(1, "\n  Step 2: The parent processes will switch to priority 0\n");
    1043:	c7 44 24 04 64 1d 00 	movl   $0x1d64,0x4(%esp)
    104a:	00 
    104b:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1052:	e8 a9 08 00 00       	call   1900 <printf>
    setpriority(0);
    1057:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    105e:	e8 f5 07 00 00       	call   1858 <setpriority>
    for (i = 0; i <  3; i++) {
	pid = fork();
    1063:	e8 38 07 00 00       	call   17a0 <fork>
	if (pid > 0 ) {
    1068:	31 d2                	xor    %edx,%edx
    106a:	85 c0                	test   %eax,%eax
    106c:	7e 53                	jle    10c1 <PScheduler+0xc1>
    printf(1, "\n  Step 2: Assuming that the priorities range between range between 0 to 63\n");
    printf(1, "\n  Step 2: 0 is the highest priority. All processes have a default priority of 20\n");
    printf(1, "\n  Step 2: The parent processes will switch to priority 0\n");
    setpriority(0);
    for (i = 0; i <  3; i++) {
	pid = fork();
    106e:	e8 2d 07 00 00       	call   17a0 <fork>
	if (pid > 0 ) {
    1073:	ba 01 00 00 00       	mov    $0x1,%edx
    1078:	85 c0                	test   %eax,%eax
    107a:	7e 45                	jle    10c1 <PScheduler+0xc1>
    printf(1, "\n  Step 2: Assuming that the priorities range between range between 0 to 63\n");
    printf(1, "\n  Step 2: 0 is the highest priority. All processes have a default priority of 20\n");
    printf(1, "\n  Step 2: The parent processes will switch to priority 0\n");
    setpriority(0);
    for (i = 0; i <  3; i++) {
	pid = fork();
    107c:	e8 1f 07 00 00       	call   17a0 <fork>
	if (pid > 0 ) {
    1081:	85 c0                	test   %eax,%eax
    1083:	7e 37                	jle    10bc <PScheduler+0xbc>
        }
	}

	if(pid > 0) {
		for (i = 0; i <  3; i++) {
			ret_pid = wait(&exit_status);
    1085:	8d 5d f4             	lea    -0xc(%ebp),%ebx
    1088:	89 1c 24             	mov    %ebx,(%esp)
    108b:	e8 20 07 00 00       	call   17b0 <wait>
    1090:	89 1c 24             	mov    %ebx,(%esp)
    1093:	e8 18 07 00 00       	call   17b0 <wait>
    1098:	89 1c 24             	mov    %ebx,(%esp)
    109b:	e8 10 07 00 00       	call   17b0 <wait>
			//printf(1,"\n This is the parent: child with PID# %d has finished with status %d \n",ret_pid,exit_status);
			}
                     printf(1,"\n if processes with highest priority finished first then its correct \n");
    10a0:	c7 44 24 04 a0 1d 00 	movl   $0x1da0,0x4(%esp)
    10a7:	00 
    10a8:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    10af:	e8 4c 08 00 00       	call   1900 <printf>
}
			
	return 0;}
    10b4:	83 c4 24             	add    $0x24,%esp
    10b7:	31 c0                	xor    %eax,%eax
    10b9:	5b                   	pop    %ebx
    10ba:	5d                   	pop    %ebp
    10bb:	c3                   	ret    
	if(pid > 0) {
		for (i = 0; i <  3; i++) {
			ret_pid = wait(&exit_status);
			//printf(1,"\n This is the parent: child with PID# %d has finished with status %d \n",ret_pid,exit_status);
			}
                     printf(1,"\n if processes with highest priority finished first then its correct \n");
    10bc:	ba 02 00 00 00       	mov    $0x2,%edx
    setpriority(0);
    for (i = 0; i <  3; i++) {
	pid = fork();
	if (pid > 0 ) {
		continue;}
	else if ( pid == 0) {
    10c1:	85 c0                	test   %eax,%eax
    10c3:	75 5e                	jne    1123 <PScheduler+0x123>
//		printf(1, "\n Hello! this is child# %d and I will change my priority to %d \n",getpid(),60-20*i);
		setpriority(60-20*i);	
    10c5:	6b d2 ec             	imul   $0xffffffec,%edx,%edx
    10c8:	8d 5a 3c             	lea    0x3c(%edx),%ebx
    10cb:	89 1c 24             	mov    %ebx,(%esp)
    10ce:	e8 85 07 00 00       	call   1858 <setpriority>
    10d3:	31 d2                	xor    %edx,%edx
    10d5:	8d 76 00             	lea    0x0(%esi),%esi
		for (j=0;j<50000;j++) {
    10d8:	31 c0                	xor    %eax,%eax
    10da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
			for(k=0;k<10000;k++) {
				asm("nop"); }}
    10e0:	90                   	nop
		continue;}
	else if ( pid == 0) {
//		printf(1, "\n Hello! this is child# %d and I will change my priority to %d \n",getpid(),60-20*i);
		setpriority(60-20*i);	
		for (j=0;j<50000;j++) {
			for(k=0;k<10000;k++) {
    10e1:	83 c0 01             	add    $0x1,%eax
    10e4:	3d 10 27 00 00       	cmp    $0x2710,%eax
    10e9:	75 f5                	jne    10e0 <PScheduler+0xe0>
	if (pid > 0 ) {
		continue;}
	else if ( pid == 0) {
//		printf(1, "\n Hello! this is child# %d and I will change my priority to %d \n",getpid(),60-20*i);
		setpriority(60-20*i);	
		for (j=0;j<50000;j++) {
    10eb:	83 c2 01             	add    $0x1,%edx
    10ee:	81 fa 50 c3 00 00    	cmp    $0xc350,%edx
    10f4:	75 e2                	jne    10d8 <PScheduler+0xd8>
			for(k=0;k<10000;k++) {
				asm("nop"); }}
		printf(1, "\n child# %d with priority %d has finished! \n",getpid(),60-20*i);		
    10f6:	e8 2d 07 00 00       	call   1828 <getpid>
    10fb:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
    10ff:	c7 44 24 04 e8 1d 00 	movl   $0x1de8,0x4(%esp)
    1106:	00 
    1107:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    110e:	89 44 24 08          	mov    %eax,0x8(%esp)
    1112:	e8 e9 07 00 00       	call   1900 <printf>
		exit(0);
    1117:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    111e:	e8 85 06 00 00       	call   17a8 <exit>
        }
        else {
			printf(2," \n Error \n");
    1123:	c7 44 24 04 6c 20 00 	movl   $0x206c,0x4(%esp)
    112a:	00 
    112b:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
    1132:	e8 c9 07 00 00       	call   1900 <printf>
			exit(-1);
    1137:	c7 04 24 ff ff ff ff 	movl   $0xffffffff,(%esp)
    113e:	e8 65 06 00 00       	call   17a8 <exit>
    1143:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    1149:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001150 <exitWait>:
    // End of test
	 exit(0);
 }
  
  
int exitWait(void) {
    1150:	55                   	push   %ebp
    1151:	89 e5                	mov    %esp,%ebp
    1153:	53                   	push   %ebx
    1154:	83 ec 24             	sub    $0x24,%esp
	  int pid, ret_pid, exit_status;
       int i;
  // use this part to test exit(int status) and wait(int* status)
 
  printf(1, "\n  Step 1: testing exit(int status) and wait(int* status):\n");
    1157:	c7 44 24 04 18 1e 00 	movl   $0x1e18,0x4(%esp)
    115e:	00 
    115f:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1166:	e8 95 07 00 00       	call   1900 <printf>

  for (i = 0; i < 2; i++) {
    pid = fork();
    116b:	e8 30 06 00 00       	call   17a0 <fork>
    if (pid == 0) { // only the child executed this code
    1170:	83 f8 00             	cmp    $0x0,%eax
    1173:	74 73                	je     11e8 <exitWait+0x98>
      else
      {
	 printf(1, "\nThis is child with PID# %d and I will exit with status %d\n" ,getpid(), -1);
      exit(-1);
  } 
    } else if (pid > 0) { // only the parent exeecutes this code
    1175:	0f 8e d6 00 00 00    	jle    1251 <exitWait+0x101>
      ret_pid = wait(&exit_status);
    117b:	8d 5d f4             	lea    -0xc(%ebp),%ebx
    117e:	89 1c 24             	mov    %ebx,(%esp)
    1181:	e8 2a 06 00 00       	call   17b0 <wait>
      printf(1, "\n This is the parent: child with PID# %d has exited with status %d\n", ret_pid, exit_status);
    1186:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1189:	c7 44 24 04 54 1e 00 	movl   $0x1e54,0x4(%esp)
    1190:	00 
    1191:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1198:	89 54 24 0c          	mov    %edx,0xc(%esp)
    119c:	89 44 24 08          	mov    %eax,0x8(%esp)
    11a0:	e8 5b 07 00 00       	call   1900 <printf>
  // use this part to test exit(int status) and wait(int* status)
 
  printf(1, "\n  Step 1: testing exit(int status) and wait(int* status):\n");

  for (i = 0; i < 2; i++) {
    pid = fork();
    11a5:	e8 f6 05 00 00       	call   17a0 <fork>
    if (pid == 0) { // only the child executed this code
    11aa:	83 f8 00             	cmp    $0x0,%eax
    11ad:	74 71                	je     1220 <exitWait+0xd0>
    11af:	90                   	nop
      else
      {
	 printf(1, "\nThis is child with PID# %d and I will exit with status %d\n" ,getpid(), -1);
      exit(-1);
  } 
    } else if (pid > 0) { // only the parent exeecutes this code
    11b0:	0f 8e 9b 00 00 00    	jle    1251 <exitWait+0x101>
      ret_pid = wait(&exit_status);
    11b6:	89 1c 24             	mov    %ebx,(%esp)
    11b9:	e8 f2 05 00 00       	call   17b0 <wait>
      printf(1, "\n This is the parent: child with PID# %d has exited with status %d\n", ret_pid, exit_status);
    11be:	8b 55 f4             	mov    -0xc(%ebp),%edx
    11c1:	c7 44 24 04 54 1e 00 	movl   $0x1e54,0x4(%esp)
    11c8:	00 
    11c9:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    11d0:	89 54 24 0c          	mov    %edx,0xc(%esp)
    11d4:	89 44 24 08          	mov    %eax,0x8(%esp)
    11d8:	e8 23 07 00 00       	call   1900 <printf>
	  printf(2, "\nError using fork\n");
      exit(-1);
    }
  }
  return 0;
}
    11dd:	83 c4 24             	add    $0x24,%esp
    11e0:	31 c0                	xor    %eax,%eax
    11e2:	5b                   	pop    %ebx
    11e3:	5d                   	pop    %ebp
    11e4:	c3                   	ret    
    11e5:	8d 76 00             	lea    0x0(%esi),%esi
  for (i = 0; i < 2; i++) {
    pid = fork();
    if (pid == 0) { // only the child executed this code
      if (i == 0)
      {
      printf(1, "\nThis is child with PID# %d and I will exit with status %d\n", getpid(), 0);
    11e8:	e8 3b 06 00 00       	call   1828 <getpid>
    11ed:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
    11f4:	00 
    11f5:	c7 44 24 04 98 1e 00 	movl   $0x1e98,0x4(%esp)
    11fc:	00 
    11fd:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1204:	89 44 24 08          	mov    %eax,0x8(%esp)
    1208:	e8 f3 06 00 00       	call   1900 <printf>
      exit(0);
    120d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1214:	e8 8f 05 00 00       	call   17a8 <exit>
    1219:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  }
      else
      {
	 printf(1, "\nThis is child with PID# %d and I will exit with status %d\n" ,getpid(), -1);
    1220:	e8 03 06 00 00       	call   1828 <getpid>
    1225:	c7 44 24 0c ff ff ff 	movl   $0xffffffff,0xc(%esp)
    122c:	ff 
    122d:	c7 44 24 04 98 1e 00 	movl   $0x1e98,0x4(%esp)
    1234:	00 
    1235:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    123c:	89 44 24 08          	mov    %eax,0x8(%esp)
    1240:	e8 bb 06 00 00       	call   1900 <printf>
      exit(-1);
    1245:	c7 04 24 ff ff ff ff 	movl   $0xffffffff,(%esp)
    124c:	e8 57 05 00 00       	call   17a8 <exit>
    } else if (pid > 0) { // only the parent exeecutes this code
      ret_pid = wait(&exit_status);
      printf(1, "\n This is the parent: child with PID# %d has exited with status %d\n", ret_pid, exit_status);
    } else  // something went wrong with fork system call
    {  
	  printf(2, "\nError using fork\n");
    1251:	c7 44 24 04 77 20 00 	movl   $0x2077,0x4(%esp)
    1258:	00 
    1259:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
    1260:	e8 9b 06 00 00       	call   1900 <printf>
      exit(-1);
    1265:	c7 04 24 ff ff ff ff 	movl   $0xffffffff,(%esp)
    126c:	e8 37 05 00 00       	call   17a8 <exit>
    1271:	eb 0d                	jmp    1280 <waitPid>
    1273:	90                   	nop
    1274:	90                   	nop
    1275:	90                   	nop
    1276:	90                   	nop
    1277:	90                   	nop
    1278:	90                   	nop
    1279:	90                   	nop
    127a:	90                   	nop
    127b:	90                   	nop
    127c:	90                   	nop
    127d:	90                   	nop
    127e:	90                   	nop
    127f:	90                   	nop

00001280 <waitPid>:
    }
  }
  return 0;
}

int waitPid(void){
    1280:	55                   	push   %ebp
    1281:	89 e5                	mov    %esp,%ebp
    1283:	56                   	push   %esi
    1284:	53                   	push   %ebx
  int ret_pid, exit_status;
  int i;
  int pid_a[5]={0, 0, 0, 0, 0};
 // use this part to test wait(int pid, int* status, int options)

 printf(1, "\n  Step 2: testing waitpid(int pid, int* status, int options):\n");
    1285:	31 db                	xor    %ebx,%ebx
    }
  }
  return 0;
}

int waitPid(void){
    1287:	83 ec 30             	sub    $0x30,%esp
  int ret_pid, exit_status;
  int i;
  int pid_a[5]={0, 0, 0, 0, 0};
 // use this part to test wait(int pid, int* status, int options)

 printf(1, "\n  Step 2: testing waitpid(int pid, int* status, int options):\n");
    128a:	c7 44 24 04 d4 1e 00 	movl   $0x1ed4,0x4(%esp)
    1291:	00 

  for (i = 0; i <5; i++) {
    pid_a[i] = fork();
    1292:	8d 75 e0             	lea    -0x20(%ebp),%esi

int waitPid(void){
	
  int ret_pid, exit_status;
  int i;
  int pid_a[5]={0, 0, 0, 0, 0};
    1295:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    129c:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    12a3:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    12aa:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    12b1:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 // use this part to test wait(int pid, int* status, int options)

 printf(1, "\n  Step 2: testing waitpid(int pid, int* status, int options):\n");
    12b8:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    12bf:	e8 3c 06 00 00       	call   1900 <printf>

  for (i = 0; i <5; i++) {
    pid_a[i] = fork();
    12c4:	e8 d7 04 00 00       	call   17a0 <fork>
	
    if (pid_a[i] == 0) { // only the child executed this code
    12c9:	85 c0                	test   %eax,%eax
    12cb:	0f 84 d9 01 00 00    	je     14aa <waitPid+0x22a>
 // use this part to test wait(int pid, int* status, int options)

 printf(1, "\n  Step 2: testing waitpid(int pid, int* status, int options):\n");

  for (i = 0; i <5; i++) {
    pid_a[i] = fork();
    12d1:	89 04 9e             	mov    %eax,(%esi,%ebx,4)
  int pid_a[5]={0, 0, 0, 0, 0};
 // use this part to test wait(int pid, int* status, int options)

 printf(1, "\n  Step 2: testing waitpid(int pid, int* status, int options):\n");

  for (i = 0; i <5; i++) {
    12d4:	83 c3 01             	add    $0x1,%ebx
    12d7:	83 fb 05             	cmp    $0x5,%ebx
    12da:	75 e8                	jne    12c4 <waitPid+0x44>
     
      
      printf(1, "\n The is child with PID# %d and I will exit with status %d\n", getpid(), 0);
      exit(0);}}
       
      sleep(5);
    12dc:	c7 04 24 05 00 00 00 	movl   $0x5,(%esp)
      printf(1, "\n This is the parent: Now waiting for child with PID# %d\n",pid_a[3]);
      ret_pid = waitpid(pid_a[3], &exit_status, 0);
    12e3:	8d 5d f4             	lea    -0xc(%ebp),%ebx
     
      
      printf(1, "\n The is child with PID# %d and I will exit with status %d\n", getpid(), 0);
      exit(0);}}
       
      sleep(5);
    12e6:	e8 4d 05 00 00       	call   1838 <sleep>
      printf(1, "\n This is the parent: Now waiting for child with PID# %d\n",pid_a[3]);
    12eb:	8b 75 ec             	mov    -0x14(%ebp),%esi
    12ee:	c7 44 24 04 50 1f 00 	movl   $0x1f50,0x4(%esp)
    12f5:	00 
    12f6:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    12fd:	89 74 24 08          	mov    %esi,0x8(%esp)
    1301:	e8 fa 05 00 00       	call   1900 <printf>
      ret_pid = waitpid(pid_a[3], &exit_status, 0);
    1306:	89 5c 24 04          	mov    %ebx,0x4(%esp)
    130a:	89 34 24             	mov    %esi,(%esp)
    130d:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
    1314:	00 
    1315:	e8 36 05 00 00       	call   1850 <waitpid>
      printf(1, "\n This is the partent: Child# %d has exited with status %d\n",ret_pid, exit_status);
    131a:	8b 55 f4             	mov    -0xc(%ebp),%edx
    131d:	c7 44 24 04 8c 1f 00 	movl   $0x1f8c,0x4(%esp)
    1324:	00 
    1325:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    132c:	89 54 24 0c          	mov    %edx,0xc(%esp)
    1330:	89 44 24 08          	mov    %eax,0x8(%esp)
    1334:	e8 c7 05 00 00       	call   1900 <printf>
      sleep(5);
    1339:	c7 04 24 05 00 00 00 	movl   $0x5,(%esp)
    1340:	e8 f3 04 00 00       	call   1838 <sleep>
      printf(1, "\n This is the parent: Now waiting for child with PID# %d\n",pid_a[1]);
    1345:	8b 75 e4             	mov    -0x1c(%ebp),%esi
    1348:	c7 44 24 04 50 1f 00 	movl   $0x1f50,0x4(%esp)
    134f:	00 
    1350:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1357:	89 74 24 08          	mov    %esi,0x8(%esp)
    135b:	e8 a0 05 00 00       	call   1900 <printf>
      ret_pid = waitpid(pid_a[1], &exit_status, 0);
    1360:	89 5c 24 04          	mov    %ebx,0x4(%esp)
    1364:	89 34 24             	mov    %esi,(%esp)
    1367:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
    136e:	00 
    136f:	e8 dc 04 00 00       	call   1850 <waitpid>
      printf(1, "\n This is the partent: Child# %d has exited with status %d\n",ret_pid, exit_status);
    1374:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1377:	c7 44 24 04 8c 1f 00 	movl   $0x1f8c,0x4(%esp)
    137e:	00 
    137f:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1386:	89 54 24 0c          	mov    %edx,0xc(%esp)
    138a:	89 44 24 08          	mov    %eax,0x8(%esp)
    138e:	e8 6d 05 00 00       	call   1900 <printf>
      sleep(5);
    1393:	c7 04 24 05 00 00 00 	movl   $0x5,(%esp)
    139a:	e8 99 04 00 00       	call   1838 <sleep>
      printf(1, "\n This is the parent: Now waiting for child with PID# %d\n",pid_a[2]);
    139f:	8b 75 e8             	mov    -0x18(%ebp),%esi
    13a2:	c7 44 24 04 50 1f 00 	movl   $0x1f50,0x4(%esp)
    13a9:	00 
    13aa:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    13b1:	89 74 24 08          	mov    %esi,0x8(%esp)
    13b5:	e8 46 05 00 00       	call   1900 <printf>
      ret_pid = waitpid(pid_a[2], &exit_status, 0);
    13ba:	89 5c 24 04          	mov    %ebx,0x4(%esp)
    13be:	89 34 24             	mov    %esi,(%esp)
    13c1:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
    13c8:	00 
    13c9:	e8 82 04 00 00       	call   1850 <waitpid>
      printf(1, "\n This is the partent: Child# %d has exited with status %d\n",ret_pid, exit_status);
    13ce:	8b 55 f4             	mov    -0xc(%ebp),%edx
    13d1:	c7 44 24 04 8c 1f 00 	movl   $0x1f8c,0x4(%esp)
    13d8:	00 
    13d9:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    13e0:	89 54 24 0c          	mov    %edx,0xc(%esp)
    13e4:	89 44 24 08          	mov    %eax,0x8(%esp)
    13e8:	e8 13 05 00 00       	call   1900 <printf>
      sleep(5);
    13ed:	c7 04 24 05 00 00 00 	movl   $0x5,(%esp)
    13f4:	e8 3f 04 00 00       	call   1838 <sleep>
      printf(1, "\n This is the parent: Now waiting for child with PID# %d\n",pid_a[0]);
    13f9:	8b 75 e0             	mov    -0x20(%ebp),%esi
    13fc:	c7 44 24 04 50 1f 00 	movl   $0x1f50,0x4(%esp)
    1403:	00 
    1404:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    140b:	89 74 24 08          	mov    %esi,0x8(%esp)
    140f:	e8 ec 04 00 00       	call   1900 <printf>
      ret_pid = waitpid(pid_a[0], &exit_status, 0);
    1414:	89 5c 24 04          	mov    %ebx,0x4(%esp)
    1418:	89 34 24             	mov    %esi,(%esp)
    141b:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
    1422:	00 
    1423:	e8 28 04 00 00       	call   1850 <waitpid>
      printf(1, "\n This is the partent: Child# %d has exited with status %d\n",ret_pid, exit_status);
    1428:	8b 55 f4             	mov    -0xc(%ebp),%edx
    142b:	c7 44 24 04 8c 1f 00 	movl   $0x1f8c,0x4(%esp)
    1432:	00 
    1433:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    143a:	89 54 24 0c          	mov    %edx,0xc(%esp)
    143e:	89 44 24 08          	mov    %eax,0x8(%esp)
    1442:	e8 b9 04 00 00       	call   1900 <printf>
      sleep(5);
    1447:	c7 04 24 05 00 00 00 	movl   $0x5,(%esp)
    144e:	e8 e5 03 00 00       	call   1838 <sleep>
      printf(1, "\n This is the parent: Now waiting for child with PID# %d\n",pid_a[4]);
    1453:	8b 75 f0             	mov    -0x10(%ebp),%esi
    1456:	c7 44 24 04 50 1f 00 	movl   $0x1f50,0x4(%esp)
    145d:	00 
    145e:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1465:	89 74 24 08          	mov    %esi,0x8(%esp)
    1469:	e8 92 04 00 00       	call   1900 <printf>
      ret_pid = waitpid(pid_a[4], &exit_status, 0);
    146e:	89 5c 24 04          	mov    %ebx,0x4(%esp)
    1472:	89 34 24             	mov    %esi,(%esp)
    1475:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
    147c:	00 
    147d:	e8 ce 03 00 00       	call   1850 <waitpid>
      printf(1, "\n This is the partent: Child# %d has exited with status %d\n",ret_pid, exit_status);
    1482:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1485:	c7 44 24 04 8c 1f 00 	movl   $0x1f8c,0x4(%esp)
    148c:	00 
    148d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1494:	89 54 24 0c          	mov    %edx,0xc(%esp)
    1498:	89 44 24 08          	mov    %eax,0x8(%esp)
    149c:	e8 5f 04 00 00       	call   1900 <printf>
      
      return 0;
  }
    14a1:	83 c4 30             	add    $0x30,%esp
    14a4:	31 c0                	xor    %eax,%eax
    14a6:	5b                   	pop    %ebx
    14a7:	5e                   	pop    %esi
    14a8:	5d                   	pop    %ebp
    14a9:	c3                   	ret    
    pid_a[i] = fork();
	
    if (pid_a[i] == 0) { // only the child executed this code
     
      
      printf(1, "\n The is child with PID# %d and I will exit with status %d\n", getpid(), 0);
    14aa:	e8 79 03 00 00       	call   1828 <getpid>
    14af:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
    14b6:	00 
    14b7:	c7 44 24 04 14 1f 00 	movl   $0x1f14,0x4(%esp)
    14be:	00 
    14bf:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    14c6:	89 44 24 08          	mov    %eax,0x8(%esp)
    14ca:	e8 31 04 00 00       	call   1900 <printf>
      exit(0);}}
    14cf:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    14d6:	e8 cd 02 00 00       	call   17a8 <exit>
    14db:	90                   	nop
    14dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000014e0 <main>:
#include "types.h"
#include "user.h"

int main(int argc, char *argv[])
{
    14e0:	55                   	push   %ebp
    14e1:	89 e5                	mov    %esp,%ebp
    14e3:	83 e4 f0             	and    $0xfffffff0,%esp
    14e6:	53                   	push   %ebx
    14e7:	83 ec 1c             	sub    $0x1c,%esp
    14ea:	8b 5d 0c             	mov    0xc(%ebp),%ebx
	
	int exitWait(void);
	int waitPid(void);
	int PScheduler(void);

  printf(1, "\n This program tests the correctness of your lab#1\n");
    14ed:	c7 44 24 04 c8 1f 00 	movl   $0x1fc8,0x4(%esp)
    14f4:	00 
    14f5:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    14fc:	e8 ff 03 00 00       	call   1900 <printf>
  
  if (atoi(argv[1]) == 1)
    1501:	8b 43 04             	mov    0x4(%ebx),%eax
    1504:	89 04 24             	mov    %eax,(%esp)
    1507:	e8 74 01 00 00       	call   1680 <atoi>
    150c:	83 f8 01             	cmp    $0x1,%eax
    150f:	74 47                	je     1558 <main+0x78>
	exitWait();
  else if (atoi(argv[1]) == 2)
    1511:	8b 43 04             	mov    0x4(%ebx),%eax
    1514:	89 04 24             	mov    %eax,(%esp)
    1517:	e8 64 01 00 00       	call   1680 <atoi>
    151c:	83 f8 02             	cmp    $0x2,%eax
    151f:	74 3f                	je     1560 <main+0x80>
	waitPid();
  else if (atoi(argv[1]) == 3)
    1521:	8b 43 04             	mov    0x4(%ebx),%eax
    1524:	89 04 24             	mov    %eax,(%esp)
    1527:	e8 54 01 00 00       	call   1680 <atoi>
    152c:	83 f8 03             	cmp    $0x3,%eax
    152f:	74 37                	je     1568 <main+0x88>
	PScheduler();
  else 
   printf(1, "\ntype \"lab1 1\" to test exit and wait, \"lab1 2\" to test waitpid and \"lab1 3\" to test the priority scheduler \n");
    1531:	c7 44 24 04 fc 1f 00 	movl   $0x1ffc,0x4(%esp)
    1538:	00 
    1539:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1540:	e8 bb 03 00 00       	call   1900 <printf>
  
    // End of test
	 exit(0);
    1545:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    154c:	e8 57 02 00 00       	call   17a8 <exit>
    1551:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
	int PScheduler(void);

  printf(1, "\n This program tests the correctness of your lab#1\n");
  
  if (atoi(argv[1]) == 1)
	exitWait();
    1558:	e8 f3 fb ff ff       	call   1150 <exitWait>
    155d:	eb e6                	jmp    1545 <main+0x65>
    155f:	90                   	nop
  else if (atoi(argv[1]) == 2)
	waitPid();
    1560:	e8 1b fd ff ff       	call   1280 <waitPid>
    1565:	eb de                	jmp    1545 <main+0x65>
    1567:	90                   	nop
    1568:	90                   	nop
    1569:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  else if (atoi(argv[1]) == 3)
	PScheduler();
    1570:	e8 8b fa ff ff       	call   1000 <PScheduler>
    1575:	eb ce                	jmp    1545 <main+0x65>
    1577:	90                   	nop
    1578:	90                   	nop
    1579:	90                   	nop
    157a:	90                   	nop
    157b:	90                   	nop
    157c:	90                   	nop
    157d:	90                   	nop
    157e:	90                   	nop
    157f:	90                   	nop

00001580 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
    1580:	55                   	push   %ebp
    1581:	31 d2                	xor    %edx,%edx
    1583:	89 e5                	mov    %esp,%ebp
    1585:	8b 45 08             	mov    0x8(%ebp),%eax
    1588:	53                   	push   %ebx
    1589:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    158c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
    1590:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
    1594:	88 0c 10             	mov    %cl,(%eax,%edx,1)
    1597:	83 c2 01             	add    $0x1,%edx
    159a:	84 c9                	test   %cl,%cl
    159c:	75 f2                	jne    1590 <strcpy+0x10>
    ;
  return os;
}
    159e:	5b                   	pop    %ebx
    159f:	5d                   	pop    %ebp
    15a0:	c3                   	ret    
    15a1:	eb 0d                	jmp    15b0 <strcmp>
    15a3:	90                   	nop
    15a4:	90                   	nop
    15a5:	90                   	nop
    15a6:	90                   	nop
    15a7:	90                   	nop
    15a8:	90                   	nop
    15a9:	90                   	nop
    15aa:	90                   	nop
    15ab:	90                   	nop
    15ac:	90                   	nop
    15ad:	90                   	nop
    15ae:	90                   	nop
    15af:	90                   	nop

000015b0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    15b0:	55                   	push   %ebp
    15b1:	89 e5                	mov    %esp,%ebp
    15b3:	8b 4d 08             	mov    0x8(%ebp),%ecx
    15b6:	53                   	push   %ebx
    15b7:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(*p && *p == *q)
    15ba:	0f b6 01             	movzbl (%ecx),%eax
    15bd:	84 c0                	test   %al,%al
    15bf:	75 14                	jne    15d5 <strcmp+0x25>
    15c1:	eb 25                	jmp    15e8 <strcmp+0x38>
    15c3:	90                   	nop
    15c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    p++, q++;
    15c8:	83 c1 01             	add    $0x1,%ecx
    15cb:	83 c2 01             	add    $0x1,%edx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
    15ce:	0f b6 01             	movzbl (%ecx),%eax
    15d1:	84 c0                	test   %al,%al
    15d3:	74 13                	je     15e8 <strcmp+0x38>
    15d5:	0f b6 1a             	movzbl (%edx),%ebx
    15d8:	38 d8                	cmp    %bl,%al
    15da:	74 ec                	je     15c8 <strcmp+0x18>
    15dc:	0f b6 db             	movzbl %bl,%ebx
    15df:	0f b6 c0             	movzbl %al,%eax
    15e2:	29 d8                	sub    %ebx,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
    15e4:	5b                   	pop    %ebx
    15e5:	5d                   	pop    %ebp
    15e6:	c3                   	ret    
    15e7:	90                   	nop
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
    15e8:	0f b6 1a             	movzbl (%edx),%ebx
    15eb:	31 c0                	xor    %eax,%eax
    15ed:	0f b6 db             	movzbl %bl,%ebx
    15f0:	29 d8                	sub    %ebx,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
    15f2:	5b                   	pop    %ebx
    15f3:	5d                   	pop    %ebp
    15f4:	c3                   	ret    
    15f5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    15f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001600 <strlen>:

uint
strlen(char *s)
{
    1600:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
    1601:	31 d2                	xor    %edx,%edx
  return (uchar)*p - (uchar)*q;
}

uint
strlen(char *s)
{
    1603:	89 e5                	mov    %esp,%ebp
  int n;

  for(n = 0; s[n]; n++)
    1605:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
}

uint
strlen(char *s)
{
    1607:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
    160a:	80 39 00             	cmpb   $0x0,(%ecx)
    160d:	74 0c                	je     161b <strlen+0x1b>
    160f:	90                   	nop
    1610:	83 c2 01             	add    $0x1,%edx
    1613:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
    1617:	89 d0                	mov    %edx,%eax
    1619:	75 f5                	jne    1610 <strlen+0x10>
    ;
  return n;
}
    161b:	5d                   	pop    %ebp
    161c:	c3                   	ret    
    161d:	8d 76 00             	lea    0x0(%esi),%esi

00001620 <memset>:

void*
memset(void *dst, int c, uint n)
{
    1620:	55                   	push   %ebp
    1621:	89 e5                	mov    %esp,%ebp
    1623:	8b 55 08             	mov    0x8(%ebp),%edx
    1626:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
    1627:	8b 4d 10             	mov    0x10(%ebp),%ecx
    162a:	8b 45 0c             	mov    0xc(%ebp),%eax
    162d:	89 d7                	mov    %edx,%edi
    162f:	fc                   	cld    
    1630:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
    1632:	89 d0                	mov    %edx,%eax
    1634:	5f                   	pop    %edi
    1635:	5d                   	pop    %ebp
    1636:	c3                   	ret    
    1637:	89 f6                	mov    %esi,%esi
    1639:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001640 <strchr>:

char*
strchr(const char *s, char c)
{
    1640:	55                   	push   %ebp
    1641:	89 e5                	mov    %esp,%ebp
    1643:	8b 45 08             	mov    0x8(%ebp),%eax
    1646:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
    164a:	0f b6 10             	movzbl (%eax),%edx
    164d:	84 d2                	test   %dl,%dl
    164f:	75 11                	jne    1662 <strchr+0x22>
    1651:	eb 15                	jmp    1668 <strchr+0x28>
    1653:	90                   	nop
    1654:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1658:	83 c0 01             	add    $0x1,%eax
    165b:	0f b6 10             	movzbl (%eax),%edx
    165e:	84 d2                	test   %dl,%dl
    1660:	74 06                	je     1668 <strchr+0x28>
    if(*s == c)
    1662:	38 ca                	cmp    %cl,%dl
    1664:	75 f2                	jne    1658 <strchr+0x18>
      return (char*)s;
  return 0;
}
    1666:	5d                   	pop    %ebp
    1667:	c3                   	ret    
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
    1668:	31 c0                	xor    %eax,%eax
    if(*s == c)
      return (char*)s;
  return 0;
}
    166a:	5d                   	pop    %ebp
    166b:	90                   	nop
    166c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1670:	c3                   	ret    
    1671:	eb 0d                	jmp    1680 <atoi>
    1673:	90                   	nop
    1674:	90                   	nop
    1675:	90                   	nop
    1676:	90                   	nop
    1677:	90                   	nop
    1678:	90                   	nop
    1679:	90                   	nop
    167a:	90                   	nop
    167b:	90                   	nop
    167c:	90                   	nop
    167d:	90                   	nop
    167e:	90                   	nop
    167f:	90                   	nop

00001680 <atoi>:
  return r;
}

int
atoi(const char *s)
{
    1680:	55                   	push   %ebp
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    1681:	31 c0                	xor    %eax,%eax
  return r;
}

int
atoi(const char *s)
{
    1683:	89 e5                	mov    %esp,%ebp
    1685:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1688:	53                   	push   %ebx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    1689:	0f b6 11             	movzbl (%ecx),%edx
    168c:	8d 5a d0             	lea    -0x30(%edx),%ebx
    168f:	80 fb 09             	cmp    $0x9,%bl
    1692:	77 1c                	ja     16b0 <atoi+0x30>
    1694:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    n = n*10 + *s++ - '0';
    1698:	0f be d2             	movsbl %dl,%edx
    169b:	83 c1 01             	add    $0x1,%ecx
    169e:	8d 04 80             	lea    (%eax,%eax,4),%eax
    16a1:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    16a5:	0f b6 11             	movzbl (%ecx),%edx
    16a8:	8d 5a d0             	lea    -0x30(%edx),%ebx
    16ab:	80 fb 09             	cmp    $0x9,%bl
    16ae:	76 e8                	jbe    1698 <atoi+0x18>
    n = n*10 + *s++ - '0';
  return n;
}
    16b0:	5b                   	pop    %ebx
    16b1:	5d                   	pop    %ebp
    16b2:	c3                   	ret    
    16b3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    16b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000016c0 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
    16c0:	55                   	push   %ebp
    16c1:	89 e5                	mov    %esp,%ebp
    16c3:	56                   	push   %esi
    16c4:	8b 45 08             	mov    0x8(%ebp),%eax
    16c7:	53                   	push   %ebx
    16c8:	8b 5d 10             	mov    0x10(%ebp),%ebx
    16cb:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    16ce:	85 db                	test   %ebx,%ebx
    16d0:	7e 14                	jle    16e6 <memmove+0x26>
    n = n*10 + *s++ - '0';
  return n;
}

void*
memmove(void *vdst, void *vsrc, int n)
    16d2:	31 d2                	xor    %edx,%edx
    16d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    *dst++ = *src++;
    16d8:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
    16dc:	88 0c 10             	mov    %cl,(%eax,%edx,1)
    16df:	83 c2 01             	add    $0x1,%edx
{
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    16e2:	39 da                	cmp    %ebx,%edx
    16e4:	75 f2                	jne    16d8 <memmove+0x18>
    *dst++ = *src++;
  return vdst;
}
    16e6:	5b                   	pop    %ebx
    16e7:	5e                   	pop    %esi
    16e8:	5d                   	pop    %ebp
    16e9:	c3                   	ret    
    16ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000016f0 <stat>:
  return buf;
}

int
stat(char *n, struct stat *st)
{
    16f0:	55                   	push   %ebp
    16f1:	89 e5                	mov    %esp,%ebp
    16f3:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    16f6:	8b 45 08             	mov    0x8(%ebp),%eax
  return buf;
}

int
stat(char *n, struct stat *st)
{
    16f9:	89 5d f8             	mov    %ebx,-0x8(%ebp)
    16fc:	89 75 fc             	mov    %esi,-0x4(%ebp)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    16ff:	be ff ff ff ff       	mov    $0xffffffff,%esi
stat(char *n, struct stat *st)
{
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    1704:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    170b:	00 
    170c:	89 04 24             	mov    %eax,(%esp)
    170f:	e8 d4 00 00 00       	call   17e8 <open>
  if(fd < 0)
    1714:	85 c0                	test   %eax,%eax
stat(char *n, struct stat *st)
{
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    1716:	89 c3                	mov    %eax,%ebx
  if(fd < 0)
    1718:	78 19                	js     1733 <stat+0x43>
    return -1;
  r = fstat(fd, st);
    171a:	8b 45 0c             	mov    0xc(%ebp),%eax
    171d:	89 1c 24             	mov    %ebx,(%esp)
    1720:	89 44 24 04          	mov    %eax,0x4(%esp)
    1724:	e8 d7 00 00 00       	call   1800 <fstat>
  close(fd);
    1729:	89 1c 24             	mov    %ebx,(%esp)
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
  r = fstat(fd, st);
    172c:	89 c6                	mov    %eax,%esi
  close(fd);
    172e:	e8 9d 00 00 00       	call   17d0 <close>
  return r;
}
    1733:	89 f0                	mov    %esi,%eax
    1735:	8b 5d f8             	mov    -0x8(%ebp),%ebx
    1738:	8b 75 fc             	mov    -0x4(%ebp),%esi
    173b:	89 ec                	mov    %ebp,%esp
    173d:	5d                   	pop    %ebp
    173e:	c3                   	ret    
    173f:	90                   	nop

00001740 <gets>:
  return 0;
}

char*
gets(char *buf, int max)
{
    1740:	55                   	push   %ebp
    1741:	89 e5                	mov    %esp,%ebp
    1743:	57                   	push   %edi
    1744:	56                   	push   %esi
    1745:	31 f6                	xor    %esi,%esi
    1747:	53                   	push   %ebx
    1748:	83 ec 2c             	sub    $0x2c,%esp
    174b:	8b 7d 08             	mov    0x8(%ebp),%edi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    174e:	eb 06                	jmp    1756 <gets+0x16>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
    1750:	3c 0a                	cmp    $0xa,%al
    1752:	74 39                	je     178d <gets+0x4d>
    1754:	89 de                	mov    %ebx,%esi
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    1756:	8d 5e 01             	lea    0x1(%esi),%ebx
    1759:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
    175c:	7d 31                	jge    178f <gets+0x4f>
    cc = read(0, &c, 1);
    175e:	8d 45 e7             	lea    -0x19(%ebp),%eax
    1761:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    1768:	00 
    1769:	89 44 24 04          	mov    %eax,0x4(%esp)
    176d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1774:	e8 47 00 00 00       	call   17c0 <read>
    if(cc < 1)
    1779:	85 c0                	test   %eax,%eax
    177b:	7e 12                	jle    178f <gets+0x4f>
      break;
    buf[i++] = c;
    177d:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
    1781:	88 44 1f ff          	mov    %al,-0x1(%edi,%ebx,1)
    if(c == '\n' || c == '\r')
    1785:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
    1789:	3c 0d                	cmp    $0xd,%al
    178b:	75 c3                	jne    1750 <gets+0x10>
    178d:	89 de                	mov    %ebx,%esi
      break;
  }
  buf[i] = '\0';
    178f:	c6 04 37 00          	movb   $0x0,(%edi,%esi,1)
  return buf;
}
    1793:	89 f8                	mov    %edi,%eax
    1795:	83 c4 2c             	add    $0x2c,%esp
    1798:	5b                   	pop    %ebx
    1799:	5e                   	pop    %esi
    179a:	5f                   	pop    %edi
    179b:	5d                   	pop    %ebp
    179c:	c3                   	ret    
    179d:	90                   	nop
    179e:	90                   	nop
    179f:	90                   	nop

000017a0 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    17a0:	b8 01 00 00 00       	mov    $0x1,%eax
    17a5:	cd 40                	int    $0x40
    17a7:	c3                   	ret    

000017a8 <exit>:
SYSCALL(exit)
    17a8:	b8 02 00 00 00       	mov    $0x2,%eax
    17ad:	cd 40                	int    $0x40
    17af:	c3                   	ret    

000017b0 <wait>:
SYSCALL(wait)
    17b0:	b8 03 00 00 00       	mov    $0x3,%eax
    17b5:	cd 40                	int    $0x40
    17b7:	c3                   	ret    

000017b8 <pipe>:
SYSCALL(pipe)
    17b8:	b8 04 00 00 00       	mov    $0x4,%eax
    17bd:	cd 40                	int    $0x40
    17bf:	c3                   	ret    

000017c0 <read>:
SYSCALL(read)
    17c0:	b8 05 00 00 00       	mov    $0x5,%eax
    17c5:	cd 40                	int    $0x40
    17c7:	c3                   	ret    

000017c8 <write>:
SYSCALL(write)
    17c8:	b8 10 00 00 00       	mov    $0x10,%eax
    17cd:	cd 40                	int    $0x40
    17cf:	c3                   	ret    

000017d0 <close>:
SYSCALL(close)
    17d0:	b8 15 00 00 00       	mov    $0x15,%eax
    17d5:	cd 40                	int    $0x40
    17d7:	c3                   	ret    

000017d8 <kill>:
SYSCALL(kill)
    17d8:	b8 06 00 00 00       	mov    $0x6,%eax
    17dd:	cd 40                	int    $0x40
    17df:	c3                   	ret    

000017e0 <exec>:
SYSCALL(exec)
    17e0:	b8 07 00 00 00       	mov    $0x7,%eax
    17e5:	cd 40                	int    $0x40
    17e7:	c3                   	ret    

000017e8 <open>:
SYSCALL(open)
    17e8:	b8 0f 00 00 00       	mov    $0xf,%eax
    17ed:	cd 40                	int    $0x40
    17ef:	c3                   	ret    

000017f0 <mknod>:
SYSCALL(mknod)
    17f0:	b8 11 00 00 00       	mov    $0x11,%eax
    17f5:	cd 40                	int    $0x40
    17f7:	c3                   	ret    

000017f8 <unlink>:
SYSCALL(unlink)
    17f8:	b8 12 00 00 00       	mov    $0x12,%eax
    17fd:	cd 40                	int    $0x40
    17ff:	c3                   	ret    

00001800 <fstat>:
SYSCALL(fstat)
    1800:	b8 08 00 00 00       	mov    $0x8,%eax
    1805:	cd 40                	int    $0x40
    1807:	c3                   	ret    

00001808 <link>:
SYSCALL(link)
    1808:	b8 13 00 00 00       	mov    $0x13,%eax
    180d:	cd 40                	int    $0x40
    180f:	c3                   	ret    

00001810 <mkdir>:
SYSCALL(mkdir)
    1810:	b8 14 00 00 00       	mov    $0x14,%eax
    1815:	cd 40                	int    $0x40
    1817:	c3                   	ret    

00001818 <chdir>:
SYSCALL(chdir)
    1818:	b8 09 00 00 00       	mov    $0x9,%eax
    181d:	cd 40                	int    $0x40
    181f:	c3                   	ret    

00001820 <dup>:
SYSCALL(dup)
    1820:	b8 0a 00 00 00       	mov    $0xa,%eax
    1825:	cd 40                	int    $0x40
    1827:	c3                   	ret    

00001828 <getpid>:
SYSCALL(getpid)
    1828:	b8 0b 00 00 00       	mov    $0xb,%eax
    182d:	cd 40                	int    $0x40
    182f:	c3                   	ret    

00001830 <sbrk>:
SYSCALL(sbrk)
    1830:	b8 0c 00 00 00       	mov    $0xc,%eax
    1835:	cd 40                	int    $0x40
    1837:	c3                   	ret    

00001838 <sleep>:
SYSCALL(sleep)
    1838:	b8 0d 00 00 00       	mov    $0xd,%eax
    183d:	cd 40                	int    $0x40
    183f:	c3                   	ret    

00001840 <uptime>:
SYSCALL(uptime)
    1840:	b8 0e 00 00 00       	mov    $0xe,%eax
    1845:	cd 40                	int    $0x40
    1847:	c3                   	ret    

00001848 <hello>:
SYSCALL(hello) 			// added for Lab0
    1848:	b8 16 00 00 00       	mov    $0x16,%eax
    184d:	cd 40                	int    $0x40
    184f:	c3                   	ret    

00001850 <waitpid>:
SYSCALL(waitpid) 		// lab1 part 1: c
    1850:	b8 17 00 00 00       	mov    $0x17,%eax
    1855:	cd 40                	int    $0x40
    1857:	c3                   	ret    

00001858 <setpriority>:
SYSCALL(setpriority) 	// lab1 part 2: define syscall
    1858:	b8 18 00 00 00       	mov    $0x18,%eax
    185d:	cd 40                	int    $0x40
    185f:	c3                   	ret    

00001860 <v2p>:
SYSCALL(v2p)			// lab2
    1860:	b8 19 00 00 00       	mov    $0x19,%eax
    1865:	cd 40                	int    $0x40
    1867:	c3                   	ret    
    1868:	90                   	nop
    1869:	90                   	nop
    186a:	90                   	nop
    186b:	90                   	nop
    186c:	90                   	nop
    186d:	90                   	nop
    186e:	90                   	nop
    186f:	90                   	nop

00001870 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
    1870:	55                   	push   %ebp
    1871:	89 e5                	mov    %esp,%ebp
    1873:	57                   	push   %edi
    1874:	89 cf                	mov    %ecx,%edi
    1876:	56                   	push   %esi
    1877:	89 c6                	mov    %eax,%esi
    1879:	53                   	push   %ebx
    187a:	83 ec 4c             	sub    $0x4c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    187d:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1880:	85 c9                	test   %ecx,%ecx
    1882:	74 04                	je     1888 <printint+0x18>
    1884:	85 d2                	test   %edx,%edx
    1886:	78 68                	js     18f0 <printint+0x80>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
    1888:	89 d0                	mov    %edx,%eax
    188a:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
    1891:	31 c9                	xor    %ecx,%ecx
    1893:	8d 5d d7             	lea    -0x29(%ebp),%ebx
    1896:	66 90                	xchg   %ax,%ax
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
    1898:	31 d2                	xor    %edx,%edx
    189a:	f7 f7                	div    %edi
    189c:	0f b6 92 91 20 00 00 	movzbl 0x2091(%edx),%edx
    18a3:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
    18a6:	83 c1 01             	add    $0x1,%ecx
  }while((x /= base) != 0);
    18a9:	85 c0                	test   %eax,%eax
    18ab:	75 eb                	jne    1898 <printint+0x28>
  if(neg)
    18ad:	8b 45 c4             	mov    -0x3c(%ebp),%eax
    18b0:	85 c0                	test   %eax,%eax
    18b2:	74 08                	je     18bc <printint+0x4c>
    buf[i++] = '-';
    18b4:	c6 44 0d d7 2d       	movb   $0x2d,-0x29(%ebp,%ecx,1)
    18b9:	83 c1 01             	add    $0x1,%ecx

  while(--i >= 0)
    18bc:	8d 79 ff             	lea    -0x1(%ecx),%edi
    18bf:	90                   	nop
    18c0:	0f b6 04 3b          	movzbl (%ebx,%edi,1),%eax
    18c4:	83 ef 01             	sub    $0x1,%edi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    18c7:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    18ce:	00 
    18cf:	89 34 24             	mov    %esi,(%esp)
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
    18d2:	88 45 e7             	mov    %al,-0x19(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    18d5:	8d 45 e7             	lea    -0x19(%ebp),%eax
    18d8:	89 44 24 04          	mov    %eax,0x4(%esp)
    18dc:	e8 e7 fe ff ff       	call   17c8 <write>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
    18e1:	83 ff ff             	cmp    $0xffffffff,%edi
    18e4:	75 da                	jne    18c0 <printint+0x50>
    putc(fd, buf[i]);
}
    18e6:	83 c4 4c             	add    $0x4c,%esp
    18e9:	5b                   	pop    %ebx
    18ea:	5e                   	pop    %esi
    18eb:	5f                   	pop    %edi
    18ec:	5d                   	pop    %ebp
    18ed:	c3                   	ret    
    18ee:	66 90                	xchg   %ax,%ax
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
    18f0:	89 d0                	mov    %edx,%eax
    18f2:	f7 d8                	neg    %eax
    18f4:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
    18fb:	eb 94                	jmp    1891 <printint+0x21>
    18fd:	8d 76 00             	lea    0x0(%esi),%esi

00001900 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
    1900:	55                   	push   %ebp
    1901:	89 e5                	mov    %esp,%ebp
    1903:	57                   	push   %edi
    1904:	56                   	push   %esi
    1905:	53                   	push   %ebx
    1906:	83 ec 3c             	sub    $0x3c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    1909:	8b 45 0c             	mov    0xc(%ebp),%eax
    190c:	0f b6 10             	movzbl (%eax),%edx
    190f:	84 d2                	test   %dl,%dl
    1911:	0f 84 c1 00 00 00    	je     19d8 <printf+0xd8>
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
    1917:	8d 4d 10             	lea    0x10(%ebp),%ecx
    191a:	31 ff                	xor    %edi,%edi
    191c:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
    191f:	31 db                	xor    %ebx,%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    1921:	8d 75 e7             	lea    -0x19(%ebp),%esi
    1924:	eb 1e                	jmp    1944 <printf+0x44>
    1926:	66 90                	xchg   %ax,%ax
  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
    1928:	83 fa 25             	cmp    $0x25,%edx
    192b:	0f 85 af 00 00 00    	jne    19e0 <printf+0xe0>
    1931:	66 bf 25 00          	mov    $0x25,%di
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    1935:	83 c3 01             	add    $0x1,%ebx
    1938:	0f b6 14 18          	movzbl (%eax,%ebx,1),%edx
    193c:	84 d2                	test   %dl,%dl
    193e:	0f 84 94 00 00 00    	je     19d8 <printf+0xd8>
    c = fmt[i] & 0xff;
    if(state == 0){
    1944:	85 ff                	test   %edi,%edi
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    1946:	0f b6 d2             	movzbl %dl,%edx
    if(state == 0){
    1949:	74 dd                	je     1928 <printf+0x28>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
    194b:	83 ff 25             	cmp    $0x25,%edi
    194e:	75 e5                	jne    1935 <printf+0x35>
      if(c == 'd'){
    1950:	83 fa 64             	cmp    $0x64,%edx
    1953:	0f 84 3f 01 00 00    	je     1a98 <printf+0x198>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
    1959:	83 fa 70             	cmp    $0x70,%edx
    195c:	0f 84 a6 00 00 00    	je     1a08 <printf+0x108>
    1962:	83 fa 78             	cmp    $0x78,%edx
    1965:	0f 84 9d 00 00 00    	je     1a08 <printf+0x108>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
    196b:	83 fa 73             	cmp    $0x73,%edx
    196e:	66 90                	xchg   %ax,%ax
    1970:	0f 84 ba 00 00 00    	je     1a30 <printf+0x130>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    1976:	83 fa 63             	cmp    $0x63,%edx
    1979:	0f 84 41 01 00 00    	je     1ac0 <printf+0x1c0>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
    197f:	83 fa 25             	cmp    $0x25,%edx
    1982:	0f 84 00 01 00 00    	je     1a88 <printf+0x188>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    1988:	8b 4d 08             	mov    0x8(%ebp),%ecx
    198b:	89 55 cc             	mov    %edx,-0x34(%ebp)
    198e:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
    1992:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    1999:	00 
    199a:	89 74 24 04          	mov    %esi,0x4(%esp)
    199e:	89 0c 24             	mov    %ecx,(%esp)
    19a1:	e8 22 fe ff ff       	call   17c8 <write>
    19a6:	8b 55 cc             	mov    -0x34(%ebp),%edx
    19a9:	88 55 e7             	mov    %dl,-0x19(%ebp)
    19ac:	8b 45 08             	mov    0x8(%ebp),%eax
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    19af:	83 c3 01             	add    $0x1,%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    19b2:	31 ff                	xor    %edi,%edi
    19b4:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    19bb:	00 
    19bc:	89 74 24 04          	mov    %esi,0x4(%esp)
    19c0:	89 04 24             	mov    %eax,(%esp)
    19c3:	e8 00 fe ff ff       	call   17c8 <write>
    19c8:	8b 45 0c             	mov    0xc(%ebp),%eax
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    19cb:	0f b6 14 18          	movzbl (%eax,%ebx,1),%edx
    19cf:	84 d2                	test   %dl,%dl
    19d1:	0f 85 6d ff ff ff    	jne    1944 <printf+0x44>
    19d7:	90                   	nop
        putc(fd, c);
      }
      state = 0;
    }
  }
}
    19d8:	83 c4 3c             	add    $0x3c,%esp
    19db:	5b                   	pop    %ebx
    19dc:	5e                   	pop    %esi
    19dd:	5f                   	pop    %edi
    19de:	5d                   	pop    %ebp
    19df:	c3                   	ret    
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    19e0:	8b 45 08             	mov    0x8(%ebp),%eax
  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
    19e3:	88 55 e7             	mov    %dl,-0x19(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    19e6:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    19ed:	00 
    19ee:	89 74 24 04          	mov    %esi,0x4(%esp)
    19f2:	89 04 24             	mov    %eax,(%esp)
    19f5:	e8 ce fd ff ff       	call   17c8 <write>
    19fa:	8b 45 0c             	mov    0xc(%ebp),%eax
    19fd:	e9 33 ff ff ff       	jmp    1935 <printf+0x35>
    1a02:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
    1a08:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    1a0b:	b9 10 00 00 00       	mov    $0x10,%ecx
        ap++;
    1a10:	31 ff                	xor    %edi,%edi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
    1a12:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1a19:	8b 10                	mov    (%eax),%edx
    1a1b:	8b 45 08             	mov    0x8(%ebp),%eax
    1a1e:	e8 4d fe ff ff       	call   1870 <printint>
    1a23:	8b 45 0c             	mov    0xc(%ebp),%eax
        ap++;
    1a26:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
    1a2a:	e9 06 ff ff ff       	jmp    1935 <printf+0x35>
    1a2f:	90                   	nop
      } else if(c == 's'){
        s = (char*)*ap;
    1a30:	8b 55 d4             	mov    -0x2c(%ebp),%edx
        ap++;
        if(s == 0)
    1a33:	b9 8a 20 00 00       	mov    $0x208a,%ecx
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
        s = (char*)*ap;
    1a38:	8b 3a                	mov    (%edx),%edi
        ap++;
    1a3a:	83 c2 04             	add    $0x4,%edx
    1a3d:	89 55 d4             	mov    %edx,-0x2c(%ebp)
        if(s == 0)
    1a40:	85 ff                	test   %edi,%edi
    1a42:	0f 44 f9             	cmove  %ecx,%edi
          s = "(null)";
        while(*s != 0){
    1a45:	0f b6 17             	movzbl (%edi),%edx
    1a48:	84 d2                	test   %dl,%dl
    1a4a:	74 33                	je     1a7f <printf+0x17f>
    1a4c:	89 5d d0             	mov    %ebx,-0x30(%ebp)
    1a4f:	8b 5d 08             	mov    0x8(%ebp),%ebx
    1a52:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
          putc(fd, *s);
          s++;
    1a58:	83 c7 01             	add    $0x1,%edi
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
    1a5b:	88 55 e7             	mov    %dl,-0x19(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    1a5e:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    1a65:	00 
    1a66:	89 74 24 04          	mov    %esi,0x4(%esp)
    1a6a:	89 1c 24             	mov    %ebx,(%esp)
    1a6d:	e8 56 fd ff ff       	call   17c8 <write>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
    1a72:	0f b6 17             	movzbl (%edi),%edx
    1a75:	84 d2                	test   %dl,%dl
    1a77:	75 df                	jne    1a58 <printf+0x158>
    1a79:	8b 5d d0             	mov    -0x30(%ebp),%ebx
    1a7c:	8b 45 0c             	mov    0xc(%ebp),%eax
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    1a7f:	31 ff                	xor    %edi,%edi
    1a81:	e9 af fe ff ff       	jmp    1935 <printf+0x35>
    1a86:	66 90                	xchg   %ax,%ax
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
    1a88:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
    1a8c:	e9 1b ff ff ff       	jmp    19ac <printf+0xac>
    1a91:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
    1a98:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    1a9b:	b9 0a 00 00 00       	mov    $0xa,%ecx
        ap++;
    1aa0:	66 31 ff             	xor    %di,%di
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
    1aa3:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1aaa:	8b 10                	mov    (%eax),%edx
    1aac:	8b 45 08             	mov    0x8(%ebp),%eax
    1aaf:	e8 bc fd ff ff       	call   1870 <printint>
    1ab4:	8b 45 0c             	mov    0xc(%ebp),%eax
        ap++;
    1ab7:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
    1abb:	e9 75 fe ff ff       	jmp    1935 <printf+0x35>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    1ac0:	8b 55 d4             	mov    -0x2c(%ebp),%edx
        putc(fd, *ap);
        ap++;
    1ac3:	31 ff                	xor    %edi,%edi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    1ac5:	8b 4d 08             	mov    0x8(%ebp),%ecx
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    1ac8:	8b 02                	mov    (%edx),%eax
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    1aca:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    1ad1:	00 
    1ad2:	89 74 24 04          	mov    %esi,0x4(%esp)
    1ad6:	89 0c 24             	mov    %ecx,(%esp)
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    1ad9:	88 45 e7             	mov    %al,-0x19(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    1adc:	e8 e7 fc ff ff       	call   17c8 <write>
    1ae1:	8b 45 0c             	mov    0xc(%ebp),%eax
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
        ap++;
    1ae4:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
    1ae8:	e9 48 fe ff ff       	jmp    1935 <printf+0x35>
    1aed:	90                   	nop
    1aee:	90                   	nop
    1aef:	90                   	nop

00001af0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    1af0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1af1:	a1 ac 20 00 00       	mov    0x20ac,%eax
static Header base;
static Header *freep;

void
free(void *ap)
{
    1af6:	89 e5                	mov    %esp,%ebp
    1af8:	57                   	push   %edi
    1af9:	56                   	push   %esi
    1afa:	53                   	push   %ebx
    1afb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
    1afe:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1b01:	39 c8                	cmp    %ecx,%eax
    1b03:	73 1d                	jae    1b22 <free+0x32>
    1b05:	8d 76 00             	lea    0x0(%esi),%esi
    1b08:	8b 10                	mov    (%eax),%edx
    1b0a:	39 d1                	cmp    %edx,%ecx
    1b0c:	72 1a                	jb     1b28 <free+0x38>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1b0e:	39 d0                	cmp    %edx,%eax
    1b10:	72 08                	jb     1b1a <free+0x2a>
    1b12:	39 c8                	cmp    %ecx,%eax
    1b14:	72 12                	jb     1b28 <free+0x38>
    1b16:	39 d1                	cmp    %edx,%ecx
    1b18:	72 0e                	jb     1b28 <free+0x38>
    1b1a:	89 d0                	mov    %edx,%eax
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1b1c:	39 c8                	cmp    %ecx,%eax
    1b1e:	66 90                	xchg   %ax,%ax
    1b20:	72 e6                	jb     1b08 <free+0x18>
    1b22:	8b 10                	mov    (%eax),%edx
    1b24:	eb e8                	jmp    1b0e <free+0x1e>
    1b26:	66 90                	xchg   %ax,%ax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    1b28:	8b 71 04             	mov    0x4(%ecx),%esi
    1b2b:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    1b2e:	39 d7                	cmp    %edx,%edi
    1b30:	74 19                	je     1b4b <free+0x5b>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
    1b32:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    1b35:	8b 50 04             	mov    0x4(%eax),%edx
    1b38:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    1b3b:	39 ce                	cmp    %ecx,%esi
    1b3d:	74 23                	je     1b62 <free+0x72>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
    1b3f:	89 08                	mov    %ecx,(%eax)
  freep = p;
    1b41:	a3 ac 20 00 00       	mov    %eax,0x20ac
}
    1b46:	5b                   	pop    %ebx
    1b47:	5e                   	pop    %esi
    1b48:	5f                   	pop    %edi
    1b49:	5d                   	pop    %ebp
    1b4a:	c3                   	ret    
  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
    1b4b:	03 72 04             	add    0x4(%edx),%esi
    1b4e:	89 71 04             	mov    %esi,0x4(%ecx)
    bp->s.ptr = p->s.ptr->s.ptr;
    1b51:	8b 10                	mov    (%eax),%edx
    1b53:	8b 12                	mov    (%edx),%edx
    1b55:	89 53 f8             	mov    %edx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    1b58:	8b 50 04             	mov    0x4(%eax),%edx
    1b5b:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    1b5e:	39 ce                	cmp    %ecx,%esi
    1b60:	75 dd                	jne    1b3f <free+0x4f>
    p->s.size += bp->s.size;
    1b62:	03 51 04             	add    0x4(%ecx),%edx
    1b65:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    1b68:	8b 53 f8             	mov    -0x8(%ebx),%edx
    1b6b:	89 10                	mov    %edx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
    1b6d:	a3 ac 20 00 00       	mov    %eax,0x20ac
}
    1b72:	5b                   	pop    %ebx
    1b73:	5e                   	pop    %esi
    1b74:	5f                   	pop    %edi
    1b75:	5d                   	pop    %ebp
    1b76:	c3                   	ret    
    1b77:	89 f6                	mov    %esi,%esi
    1b79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001b80 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    1b80:	55                   	push   %ebp
    1b81:	89 e5                	mov    %esp,%ebp
    1b83:	57                   	push   %edi
    1b84:	56                   	push   %esi
    1b85:	53                   	push   %ebx
    1b86:	83 ec 2c             	sub    $0x2c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1b89:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if((prevp = freep) == 0){
    1b8c:	8b 0d ac 20 00 00    	mov    0x20ac,%ecx
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1b92:	83 c3 07             	add    $0x7,%ebx
    1b95:	c1 eb 03             	shr    $0x3,%ebx
    1b98:	83 c3 01             	add    $0x1,%ebx
  if((prevp = freep) == 0){
    1b9b:	85 c9                	test   %ecx,%ecx
    1b9d:	0f 84 9b 00 00 00    	je     1c3e <malloc+0xbe>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1ba3:	8b 01                	mov    (%ecx),%eax
    if(p->s.size >= nunits){
    1ba5:	8b 50 04             	mov    0x4(%eax),%edx
    1ba8:	39 d3                	cmp    %edx,%ebx
    1baa:	76 27                	jbe    1bd3 <malloc+0x53>
        p->s.size -= nunits;
        p += p->s.size;
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    1bac:	8d 3c dd 00 00 00 00 	lea    0x0(,%ebx,8),%edi
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < 4096)
    1bb3:	be 00 80 00 00       	mov    $0x8000,%esi
    1bb8:	89 7d e4             	mov    %edi,-0x1c(%ebp)
    1bbb:	90                   	nop
    1bbc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    1bc0:	3b 05 ac 20 00 00    	cmp    0x20ac,%eax
    1bc6:	74 30                	je     1bf8 <malloc+0x78>
    1bc8:	89 c1                	mov    %eax,%ecx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1bca:	8b 01                	mov    (%ecx),%eax
    if(p->s.size >= nunits){
    1bcc:	8b 50 04             	mov    0x4(%eax),%edx
    1bcf:	39 d3                	cmp    %edx,%ebx
    1bd1:	77 ed                	ja     1bc0 <malloc+0x40>
      if(p->s.size == nunits)
    1bd3:	39 d3                	cmp    %edx,%ebx
    1bd5:	74 61                	je     1c38 <malloc+0xb8>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
    1bd7:	29 da                	sub    %ebx,%edx
    1bd9:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
    1bdc:	8d 04 d0             	lea    (%eax,%edx,8),%eax
        p->s.size = nunits;
    1bdf:	89 58 04             	mov    %ebx,0x4(%eax)
      }
      freep = prevp;
    1be2:	89 0d ac 20 00 00    	mov    %ecx,0x20ac
      return (void*)(p + 1);
    1be8:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
    1beb:	83 c4 2c             	add    $0x2c,%esp
    1bee:	5b                   	pop    %ebx
    1bef:	5e                   	pop    %esi
    1bf0:	5f                   	pop    %edi
    1bf1:	5d                   	pop    %ebp
    1bf2:	c3                   	ret    
    1bf3:	90                   	nop
    1bf4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < 4096)
    1bf8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1bfb:	81 fb 00 10 00 00    	cmp    $0x1000,%ebx
    1c01:	bf 00 10 00 00       	mov    $0x1000,%edi
    1c06:	0f 43 fb             	cmovae %ebx,%edi
    1c09:	0f 42 c6             	cmovb  %esi,%eax
    nu = 4096;
  p = sbrk(nu * sizeof(Header));
    1c0c:	89 04 24             	mov    %eax,(%esp)
    1c0f:	e8 1c fc ff ff       	call   1830 <sbrk>
  if(p == (char*)-1)
    1c14:	83 f8 ff             	cmp    $0xffffffff,%eax
    1c17:	74 18                	je     1c31 <malloc+0xb1>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
    1c19:	89 78 04             	mov    %edi,0x4(%eax)
  free((void*)(hp + 1));
    1c1c:	83 c0 08             	add    $0x8,%eax
    1c1f:	89 04 24             	mov    %eax,(%esp)
    1c22:	e8 c9 fe ff ff       	call   1af0 <free>
  return freep;
    1c27:	8b 0d ac 20 00 00    	mov    0x20ac,%ecx
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
    1c2d:	85 c9                	test   %ecx,%ecx
    1c2f:	75 99                	jne    1bca <malloc+0x4a>
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
    1c31:	31 c0                	xor    %eax,%eax
    1c33:	eb b6                	jmp    1beb <malloc+0x6b>
    1c35:	8d 76 00             	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
    1c38:	8b 10                	mov    (%eax),%edx
    1c3a:	89 11                	mov    %edx,(%ecx)
    1c3c:	eb a4                	jmp    1be2 <malloc+0x62>
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    1c3e:	c7 05 ac 20 00 00 a4 	movl   $0x20a4,0x20ac
    1c45:	20 00 00 
    base.s.size = 0;
    1c48:	b9 a4 20 00 00       	mov    $0x20a4,%ecx
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    1c4d:	c7 05 a4 20 00 00 a4 	movl   $0x20a4,0x20a4
    1c54:	20 00 00 
    base.s.size = 0;
    1c57:	c7 05 a8 20 00 00 00 	movl   $0x0,0x20a8
    1c5e:	00 00 00 
    1c61:	e9 3d ff ff ff       	jmp    1ba3 <malloc+0x23>
