
_usertests:     file format elf32-i386


Disassembly of section .text:

00001000 <validateint>:
  printf(stdout, "sbrk test OK\n");
}

void
validateint(int *p)
{
    1000:	55                   	push   %ebp
    1001:	89 e5                	mov    %esp,%ebp
      "int %2\n\t"
      "mov %%ebx, %%esp" :
      "=a" (res) :
      "a" (SYS_sleep), "n" (T_SYSCALL), "c" (p) :
      "ebx");
}
    1003:	5d                   	pop    %ebp
    1004:	c3                   	ret    
    1005:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1009:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001010 <rand>:

unsigned long randstate = 1;
unsigned int
rand()
{
  randstate = randstate * 1664525 + 1013904223;
    1010:	69 05 30 6c 00 00 0d 	imul   $0x19660d,0x6c30,%eax
    1017:	66 19 00 
}

unsigned long randstate = 1;
unsigned int
rand()
{
    101a:	55                   	push   %ebp
    101b:	89 e5                	mov    %esp,%ebp
  randstate = randstate * 1664525 + 1013904223;
  return randstate;
}
    101d:	5d                   	pop    %ebp

unsigned long randstate = 1;
unsigned int
rand()
{
  randstate = randstate * 1664525 + 1013904223;
    101e:	05 5f f3 6e 3c       	add    $0x3c6ef35f,%eax
    1023:	a3 30 6c 00 00       	mov    %eax,0x6c30
  return randstate;
}
    1028:	c3                   	ret    
    1029:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00001030 <bsstest>:

// does unintialized data start out zero?
char uninit[10000];
void
bsstest(void)
{
    1030:	55                   	push   %ebp
    1031:	89 e5                	mov    %esp,%ebp
    1033:	83 ec 18             	sub    $0x18,%esp
  int i;

  printf(stdout, "bss test\n");
    1036:	a1 2c 6c 00 00       	mov    0x6c2c,%eax
    103b:	c7 44 24 04 68 54 00 	movl   $0x5468,0x4(%esp)
    1042:	00 
    1043:	89 04 24             	mov    %eax,(%esp)
    1046:	e8 b5 40 00 00       	call   5100 <printf>
  for(i = 0; i < sizeof(uninit); i++){
    if(uninit[i] != '\0'){
    104b:	80 3d 00 6d 00 00 00 	cmpb   $0x0,0x6d00
    1052:	75 36                	jne    108a <bsstest+0x5a>
    1054:	b8 01 00 00 00       	mov    $0x1,%eax
    1059:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    1060:	80 b8 00 6d 00 00 00 	cmpb   $0x0,0x6d00(%eax)
    1067:	75 21                	jne    108a <bsstest+0x5a>
bsstest(void)
{
  int i;

  printf(stdout, "bss test\n");
  for(i = 0; i < sizeof(uninit); i++){
    1069:	83 c0 01             	add    $0x1,%eax
    106c:	3d 10 27 00 00       	cmp    $0x2710,%eax
    1071:	75 ed                	jne    1060 <bsstest+0x30>
    if(uninit[i] != '\0'){
      printf(stdout, "bss test failed\n");
      exit(0);
    }
  }
  printf(stdout, "bss test ok\n");
    1073:	a1 2c 6c 00 00       	mov    0x6c2c,%eax
    1078:	c7 44 24 04 83 54 00 	movl   $0x5483,0x4(%esp)
    107f:	00 
    1080:	89 04 24             	mov    %eax,(%esp)
    1083:	e8 78 40 00 00       	call   5100 <printf>
}
    1088:	c9                   	leave  
    1089:	c3                   	ret    
  int i;

  printf(stdout, "bss test\n");
  for(i = 0; i < sizeof(uninit); i++){
    if(uninit[i] != '\0'){
      printf(stdout, "bss test failed\n");
    108a:	a1 2c 6c 00 00       	mov    0x6c2c,%eax
    108f:	c7 44 24 04 72 54 00 	movl   $0x5472,0x4(%esp)
    1096:	00 
    1097:	89 04 24             	mov    %eax,(%esp)
    109a:	e8 61 40 00 00       	call   5100 <printf>
      exit(0);
    109f:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    10a6:	e8 fd 3e 00 00       	call   4fa8 <exit>
    10ab:	90                   	nop
    10ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000010b0 <opentest>:

// simple file system tests

void
opentest(void)
{
    10b0:	55                   	push   %ebp
    10b1:	89 e5                	mov    %esp,%ebp
    10b3:	83 ec 18             	sub    $0x18,%esp
  int fd;

  printf(stdout, "open test\n");
    10b6:	a1 2c 6c 00 00       	mov    0x6c2c,%eax
    10bb:	c7 44 24 04 90 54 00 	movl   $0x5490,0x4(%esp)
    10c2:	00 
    10c3:	89 04 24             	mov    %eax,(%esp)
    10c6:	e8 35 40 00 00       	call   5100 <printf>
  fd = open("echo", 0);
    10cb:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    10d2:	00 
    10d3:	c7 04 24 9b 54 00 00 	movl   $0x549b,(%esp)
    10da:	e8 09 3f 00 00       	call   4fe8 <open>
  if(fd < 0){
    10df:	85 c0                	test   %eax,%eax
    10e1:	78 37                	js     111a <opentest+0x6a>
    printf(stdout, "open echo failed!\n");
    exit(0);
  }
  close(fd);
    10e3:	89 04 24             	mov    %eax,(%esp)
    10e6:	e8 e5 3e 00 00       	call   4fd0 <close>
  fd = open("doesnotexist", 0);
    10eb:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    10f2:	00 
    10f3:	c7 04 24 b3 54 00 00 	movl   $0x54b3,(%esp)
    10fa:	e8 e9 3e 00 00       	call   4fe8 <open>
  if(fd >= 0){
    10ff:	85 c0                	test   %eax,%eax
    1101:	79 38                	jns    113b <opentest+0x8b>
    printf(stdout, "open doesnotexist succeeded!\n");
    exit(0);
  }
  printf(stdout, "open test ok\n");
    1103:	a1 2c 6c 00 00       	mov    0x6c2c,%eax
    1108:	c7 44 24 04 de 54 00 	movl   $0x54de,0x4(%esp)
    110f:	00 
    1110:	89 04 24             	mov    %eax,(%esp)
    1113:	e8 e8 3f 00 00       	call   5100 <printf>
}
    1118:	c9                   	leave  
    1119:	c3                   	ret    
  int fd;

  printf(stdout, "open test\n");
  fd = open("echo", 0);
  if(fd < 0){
    printf(stdout, "open echo failed!\n");
    111a:	c7 44 24 04 a0 54 00 	movl   $0x54a0,0x4(%esp)
    1121:	00 
    exit(0);
  }
  close(fd);
  fd = open("doesnotexist", 0);
  if(fd >= 0){
    printf(stdout, "open doesnotexist succeeded!\n");
    1122:	a1 2c 6c 00 00       	mov    0x6c2c,%eax
    1127:	89 04 24             	mov    %eax,(%esp)
    112a:	e8 d1 3f 00 00       	call   5100 <printf>
    exit(0);
    112f:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1136:	e8 6d 3e 00 00       	call   4fa8 <exit>
    exit(0);
  }
  close(fd);
  fd = open("doesnotexist", 0);
  if(fd >= 0){
    printf(stdout, "open doesnotexist succeeded!\n");
    113b:	c7 44 24 04 c0 54 00 	movl   $0x54c0,0x4(%esp)
    1142:	00 
    1143:	eb dd                	jmp    1122 <opentest+0x72>
    1145:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1149:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001150 <argptest>:
  wait(&exit_status);
  printf(1, "uio test done\n");
}

void argptest()
{
    1150:	55                   	push   %ebp
    1151:	89 e5                	mov    %esp,%ebp
    1153:	53                   	push   %ebx
    1154:	83 ec 14             	sub    $0x14,%esp
  int fd;
  fd = open("init", O_RDONLY);
    1157:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    115e:	00 
    115f:	c7 04 24 ec 54 00 00 	movl   $0x54ec,(%esp)
    1166:	e8 7d 3e 00 00       	call   4fe8 <open>
  if (fd < 0) {
    116b:	85 c0                	test   %eax,%eax
}

void argptest()
{
  int fd;
  fd = open("init", O_RDONLY);
    116d:	89 c3                	mov    %eax,%ebx
  if (fd < 0) {
    116f:	78 45                	js     11b6 <argptest+0x66>
    printf(2, "open failed\n");
    exit(0);
  }
  read(fd, sbrk(0) - 1, -1);
    1171:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1178:	e8 b3 3e 00 00       	call   5030 <sbrk>
    117d:	89 1c 24             	mov    %ebx,(%esp)
    1180:	c7 44 24 08 ff ff ff 	movl   $0xffffffff,0x8(%esp)
    1187:	ff 
    1188:	83 e8 01             	sub    $0x1,%eax
    118b:	89 44 24 04          	mov    %eax,0x4(%esp)
    118f:	e8 2c 3e 00 00       	call   4fc0 <read>
  close(fd);
    1194:	89 1c 24             	mov    %ebx,(%esp)
    1197:	e8 34 3e 00 00       	call   4fd0 <close>
  printf(1, "arg test passed\n");
    119c:	c7 44 24 04 fe 54 00 	movl   $0x54fe,0x4(%esp)
    11a3:	00 
    11a4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    11ab:	e8 50 3f 00 00       	call   5100 <printf>
}
    11b0:	83 c4 14             	add    $0x14,%esp
    11b3:	5b                   	pop    %ebx
    11b4:	5d                   	pop    %ebp
    11b5:	c3                   	ret    
void argptest()
{
  int fd;
  fd = open("init", O_RDONLY);
  if (fd < 0) {
    printf(2, "open failed\n");
    11b6:	c7 44 24 04 f1 54 00 	movl   $0x54f1,0x4(%esp)
    11bd:	00 
    11be:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
    11c5:	e8 36 3f 00 00       	call   5100 <printf>
    exit(0);
    11ca:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    11d1:	e8 d2 3d 00 00       	call   4fa8 <exit>
    11d6:	8d 76 00             	lea    0x0(%esi),%esi
    11d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000011e0 <uio>:
  printf(1, "fsfull test finished\n");
}

void
uio()
{
    11e0:	55                   	push   %ebp
    11e1:	89 e5                	mov    %esp,%ebp
    11e3:	83 ec 18             	sub    $0x18,%esp

  ushort port = 0;
  uchar val = 0;
  int pid;

  printf(1, "uio test\n");
    11e6:	c7 44 24 04 0f 55 00 	movl   $0x550f,0x4(%esp)
    11ed:	00 
    11ee:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    11f5:	e8 06 3f 00 00       	call   5100 <printf>
  pid = fork();
    11fa:	e8 a1 3d 00 00       	call   4fa0 <fork>
  if(pid == 0){
    11ff:	83 f8 00             	cmp    $0x0,%eax
    1202:	74 24                	je     1228 <uio+0x48>
    asm volatile("outb %0,%1"::"a"(val), "d" (port));
    port = RTC_DATA;
    asm volatile("inb %1,%0" : "=a" (val) : "d" (port));
    printf(1, "uio: uio succeeded; test FAILED\n");
    exit(0);
  } else if(pid < 0){
    1204:	7c 50                	jl     1256 <uio+0x76>
    printf (1, "fork failed\n");
    exit(0);
  }
  wait(&exit_status);
    1206:	c7 04 24 e0 6c 00 00 	movl   $0x6ce0,(%esp)
    120d:	e8 9e 3d 00 00       	call   4fb0 <wait>
  printf(1, "uio test done\n");
    1212:	c7 44 24 04 19 55 00 	movl   $0x5519,0x4(%esp)
    1219:	00 
    121a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1221:	e8 da 3e 00 00       	call   5100 <printf>
}
    1226:	c9                   	leave  
    1227:	c3                   	ret    
  pid = fork();
  if(pid == 0){
    port = RTC_ADDR;
    val = 0x09;  /* year */
    /* http://wiki.osdev.org/Inline_Assembly/Examples */
    asm volatile("outb %0,%1"::"a"(val), "d" (port));
    1228:	ba 70 00 00 00       	mov    $0x70,%edx
    122d:	b8 09 00 00 00       	mov    $0x9,%eax
    1232:	ee                   	out    %al,(%dx)
    port = RTC_DATA;
    asm volatile("inb %1,%0" : "=a" (val) : "d" (port));
    1233:	b2 71                	mov    $0x71,%dl
    1235:	ec                   	in     (%dx),%al
    printf(1, "uio: uio succeeded; test FAILED\n");
    1236:	c7 44 24 04 8c 64 00 	movl   $0x648c,0x4(%esp)
    123d:	00 
    123e:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1245:	e8 b6 3e 00 00       	call   5100 <printf>
    exit(0);
    124a:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1251:	e8 52 3d 00 00       	call   4fa8 <exit>
  } else if(pid < 0){
    printf (1, "fork failed\n");
    1256:	c7 44 24 04 df 58 00 	movl   $0x58df,0x4(%esp)
    125d:	00 
    125e:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1265:	e8 96 3e 00 00       	call   5100 <printf>
    exit(0);
    126a:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1271:	e8 32 3d 00 00       	call   4fa8 <exit>
    1276:	8d 76 00             	lea    0x0(%esi),%esi
    1279:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001280 <forktest>:
// test that fork fails gracefully
// the forktest binary also does this, but it runs out of proc entries first.
// inside the bigger usertests binary, we run out of memory first.
void
forktest(void)
{
    1280:	55                   	push   %ebp
    1281:	89 e5                	mov    %esp,%ebp
    1283:	53                   	push   %ebx
  int n, pid;

  printf(1, "fork test\n");
    1284:	31 db                	xor    %ebx,%ebx
// test that fork fails gracefully
// the forktest binary also does this, but it runs out of proc entries first.
// inside the bigger usertests binary, we run out of memory first.
void
forktest(void)
{
    1286:	83 ec 14             	sub    $0x14,%esp
  int n, pid;

  printf(1, "fork test\n");
    1289:	c7 44 24 04 28 55 00 	movl   $0x5528,0x4(%esp)
    1290:	00 
    1291:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1298:	e8 63 3e 00 00       	call   5100 <printf>
    129d:	eb 0e                	jmp    12ad <forktest+0x2d>
    129f:	90                   	nop

  for(n=0; n<1000; n++){
    pid = fork();
    if(pid < 0)
      break;
    if(pid == 0)
    12a0:	74 72                	je     1314 <forktest+0x94>
{
  int n, pid;

  printf(1, "fork test\n");

  for(n=0; n<1000; n++){
    12a2:	83 c3 01             	add    $0x1,%ebx
    12a5:	81 fb e8 03 00 00    	cmp    $0x3e8,%ebx
    12ab:	74 53                	je     1300 <forktest+0x80>
    pid = fork();
    12ad:	e8 ee 3c 00 00       	call   4fa0 <fork>
    if(pid < 0)
    12b2:	83 f8 00             	cmp    $0x0,%eax
    12b5:	7d e9                	jge    12a0 <forktest+0x20>
  if(n == 1000){
    printf(1, "fork claimed to work 1000 times!\n");
    exit(0);
  }

  for(; n > 0; n--){
    12b7:	85 db                	test   %ebx,%ebx
    12b9:	74 1a                	je     12d5 <forktest+0x55>
    12bb:	90                   	nop
    12bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(wait(&exit_status) < 0){
    12c0:	c7 04 24 e0 6c 00 00 	movl   $0x6ce0,(%esp)
    12c7:	e8 e4 3c 00 00       	call   4fb0 <wait>
    12cc:	85 c0                	test   %eax,%eax
    12ce:	78 50                	js     1320 <forktest+0xa0>
  if(n == 1000){
    printf(1, "fork claimed to work 1000 times!\n");
    exit(0);
  }

  for(; n > 0; n--){
    12d0:	83 eb 01             	sub    $0x1,%ebx
    12d3:	75 eb                	jne    12c0 <forktest+0x40>
      printf(1, "wait stopped early\n");
      exit(0);
    }
  }

  if(wait(&exit_status) != -1){
    12d5:	c7 04 24 e0 6c 00 00 	movl   $0x6ce0,(%esp)
    12dc:	e8 cf 3c 00 00       	call   4fb0 <wait>
    12e1:	83 f8 ff             	cmp    $0xffffffff,%eax
    12e4:	75 5a                	jne    1340 <forktest+0xc0>
    printf(1, "wait got too many\n");
    exit(0);
  }

  printf(1, "fork test OK\n");
    12e6:	c7 44 24 04 5a 55 00 	movl   $0x555a,0x4(%esp)
    12ed:	00 
    12ee:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    12f5:	e8 06 3e 00 00       	call   5100 <printf>
}
    12fa:	83 c4 14             	add    $0x14,%esp
    12fd:	5b                   	pop    %ebx
    12fe:	5d                   	pop    %ebp
    12ff:	c3                   	ret    
    if(pid == 0)
      exit(0);
  }

  if(n == 1000){
    printf(1, "fork claimed to work 1000 times!\n");
    1300:	c7 44 24 04 b0 64 00 	movl   $0x64b0,0x4(%esp)
    1307:	00 
    1308:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    130f:	e8 ec 3d 00 00       	call   5100 <printf>
    exit(0);
    1314:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    131b:	e8 88 3c 00 00       	call   4fa8 <exit>
  }

  for(; n > 0; n--){
    if(wait(&exit_status) < 0){
      printf(1, "wait stopped early\n");
    1320:	c7 44 24 04 33 55 00 	movl   $0x5533,0x4(%esp)
    1327:	00 
    1328:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    132f:	e8 cc 3d 00 00       	call   5100 <printf>
      exit(0);
    1334:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    133b:	e8 68 3c 00 00       	call   4fa8 <exit>
    }
  }

  if(wait(&exit_status) != -1){
    printf(1, "wait got too many\n");
    1340:	c7 44 24 04 47 55 00 	movl   $0x5547,0x4(%esp)
    1347:	00 
    1348:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    134f:	e8 ac 3d 00 00       	call   5100 <printf>
    exit(0);
    1354:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    135b:	e8 48 3c 00 00       	call   4fa8 <exit>

00001360 <exitwait>:
}

// try to find any races between exit and wait
void
exitwait(void)
{
    1360:	55                   	push   %ebp
    1361:	89 e5                	mov    %esp,%ebp
    1363:	56                   	push   %esi
    1364:	31 f6                	xor    %esi,%esi
    1366:	53                   	push   %ebx
    1367:	83 ec 10             	sub    $0x10,%esp
    136a:	eb 22                	jmp    138e <exitwait+0x2e>
    136c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    pid = fork();
    if(pid < 0){
      printf(1, "fork failed\n");
      return;
    }
    if(pid){
    1370:	0f 84 7d 00 00 00    	je     13f3 <exitwait+0x93>
      if(wait(&exit_status) != pid){
    1376:	c7 04 24 e0 6c 00 00 	movl   $0x6ce0,(%esp)
    137d:	e8 2e 3c 00 00       	call   4fb0 <wait>
    1382:	39 c3                	cmp    %eax,%ebx
    1384:	75 32                	jne    13b8 <exitwait+0x58>
void
exitwait(void)
{
  int i, pid;

  for(i = 0; i < 100; i++){
    1386:	83 c6 01             	add    $0x1,%esi
    1389:	83 fe 64             	cmp    $0x64,%esi
    138c:	74 4a                	je     13d8 <exitwait+0x78>
    pid = fork();
    138e:	e8 0d 3c 00 00       	call   4fa0 <fork>
    if(pid < 0){
    1393:	83 f8 00             	cmp    $0x0,%eax
exitwait(void)
{
  int i, pid;

  for(i = 0; i < 100; i++){
    pid = fork();
    1396:	89 c3                	mov    %eax,%ebx
    if(pid < 0){
    1398:	7d d6                	jge    1370 <exitwait+0x10>
      printf(1, "fork failed\n");
    139a:	c7 44 24 04 df 58 00 	movl   $0x58df,0x4(%esp)
    13a1:	00 
    13a2:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    13a9:	e8 52 3d 00 00       	call   5100 <printf>
    } else {
      exit(0);
    }
  }
  printf(1, "exitwait ok\n");
}
    13ae:	83 c4 10             	add    $0x10,%esp
    13b1:	5b                   	pop    %ebx
    13b2:	5e                   	pop    %esi
    13b3:	5d                   	pop    %ebp
    13b4:	c3                   	ret    
    13b5:	8d 76 00             	lea    0x0(%esi),%esi
      printf(1, "fork failed\n");
      return;
    }
    if(pid){
      if(wait(&exit_status) != pid){
        printf(1, "wait wrong pid\n");
    13b8:	c7 44 24 04 68 55 00 	movl   $0x5568,0x4(%esp)
    13bf:	00 
    13c0:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    13c7:	e8 34 3d 00 00       	call   5100 <printf>
    } else {
      exit(0);
    }
  }
  printf(1, "exitwait ok\n");
}
    13cc:	83 c4 10             	add    $0x10,%esp
    13cf:	5b                   	pop    %ebx
    13d0:	5e                   	pop    %esi
    13d1:	5d                   	pop    %ebp
    13d2:	c3                   	ret    
    13d3:	90                   	nop
    13d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      }
    } else {
      exit(0);
    }
  }
  printf(1, "exitwait ok\n");
    13d8:	c7 44 24 04 78 55 00 	movl   $0x5578,0x4(%esp)
    13df:	00 
    13e0:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    13e7:	e8 14 3d 00 00       	call   5100 <printf>
}
    13ec:	83 c4 10             	add    $0x10,%esp
    13ef:	5b                   	pop    %ebx
    13f0:	5e                   	pop    %esi
    13f1:	5d                   	pop    %ebp
    13f2:	c3                   	ret    
      if(wait(&exit_status) != pid){
        printf(1, "wait wrong pid\n");
        return;
      }
    } else {
      exit(0);
    13f3:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    13fa:	e8 a9 3b 00 00       	call   4fa8 <exit>
    13ff:	90                   	nop

00001400 <fsfull>:

// what happens when the file system runs out of blocks?
// answer: balloc panics, so this test is not useful.
void
fsfull()
{
    1400:	55                   	push   %ebp
    1401:	89 e5                	mov    %esp,%ebp
    1403:	57                   	push   %edi
    1404:	56                   	push   %esi
    1405:	53                   	push   %ebx
  int nfiles;
  int fsblocks = 0;

  printf(1, "fsfull test\n");
    1406:	31 db                	xor    %ebx,%ebx

// what happens when the file system runs out of blocks?
// answer: balloc panics, so this test is not useful.
void
fsfull()
{
    1408:	83 ec 5c             	sub    $0x5c,%esp
  int nfiles;
  int fsblocks = 0;

  printf(1, "fsfull test\n");
    140b:	c7 44 24 04 85 55 00 	movl   $0x5585,0x4(%esp)
    1412:	00 
    1413:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    141a:	e8 e1 3c 00 00       	call   5100 <printf>
    141f:	90                   	nop

  for(nfiles = 0; ; nfiles++){
    char name[64];
    name[0] = 'f';
    name[1] = '0' + nfiles / 1000;
    1420:	b8 d3 4d 62 10       	mov    $0x10624dd3,%eax
    1425:	89 d9                	mov    %ebx,%ecx
    1427:	f7 eb                	imul   %ebx
    1429:	c1 f9 1f             	sar    $0x1f,%ecx

  printf(1, "fsfull test\n");

  for(nfiles = 0; ; nfiles++){
    char name[64];
    name[0] = 'f';
    142c:	c6 45 a8 66          	movb   $0x66,-0x58(%ebp)
    name[1] = '0' + nfiles / 1000;
    name[2] = '0' + (nfiles % 1000) / 100;
    name[3] = '0' + (nfiles % 100) / 10;
    name[4] = '0' + (nfiles % 10);
    name[5] = '\0';
    1430:	c6 45 ad 00          	movb   $0x0,-0x53(%ebp)
  printf(1, "fsfull test\n");

  for(nfiles = 0; ; nfiles++){
    char name[64];
    name[0] = 'f';
    name[1] = '0' + nfiles / 1000;
    1434:	c1 fa 06             	sar    $0x6,%edx
    1437:	29 ca                	sub    %ecx,%edx
    name[2] = '0' + (nfiles % 1000) / 100;
    1439:	69 f2 e8 03 00 00    	imul   $0x3e8,%edx,%esi
  printf(1, "fsfull test\n");

  for(nfiles = 0; ; nfiles++){
    char name[64];
    name[0] = 'f';
    name[1] = '0' + nfiles / 1000;
    143f:	8d 42 30             	lea    0x30(%edx),%eax
    name[2] = '0' + (nfiles % 1000) / 100;
    1442:	89 da                	mov    %ebx,%edx
  printf(1, "fsfull test\n");

  for(nfiles = 0; ; nfiles++){
    char name[64];
    name[0] = 'f';
    name[1] = '0' + nfiles / 1000;
    1444:	88 45 a9             	mov    %al,-0x57(%ebp)
    name[2] = '0' + (nfiles % 1000) / 100;
    1447:	b8 1f 85 eb 51       	mov    $0x51eb851f,%eax
    name[3] = '0' + (nfiles % 100) / 10;
    name[4] = '0' + (nfiles % 10);
    name[5] = '\0';
    printf(1, "writing %s\n", name);
    144c:	c7 44 24 04 92 55 00 	movl   $0x5592,0x4(%esp)
    1453:	00 

  for(nfiles = 0; ; nfiles++){
    char name[64];
    name[0] = 'f';
    name[1] = '0' + nfiles / 1000;
    name[2] = '0' + (nfiles % 1000) / 100;
    1454:	29 f2                	sub    %esi,%edx
    1456:	89 d6                	mov    %edx,%esi
    1458:	f7 ea                	imul   %edx
    name[3] = '0' + (nfiles % 100) / 10;
    145a:	b8 1f 85 eb 51       	mov    $0x51eb851f,%eax

  for(nfiles = 0; ; nfiles++){
    char name[64];
    name[0] = 'f';
    name[1] = '0' + nfiles / 1000;
    name[2] = '0' + (nfiles % 1000) / 100;
    145f:	c1 fe 1f             	sar    $0x1f,%esi
    name[3] = '0' + (nfiles % 100) / 10;
    name[4] = '0' + (nfiles % 10);
    name[5] = '\0';
    printf(1, "writing %s\n", name);
    1462:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)

  for(nfiles = 0; ; nfiles++){
    char name[64];
    name[0] = 'f';
    name[1] = '0' + nfiles / 1000;
    name[2] = '0' + (nfiles % 1000) / 100;
    1469:	c1 fa 05             	sar    $0x5,%edx
    146c:	29 f2                	sub    %esi,%edx
    name[3] = '0' + (nfiles % 100) / 10;
    146e:	be 67 66 66 66       	mov    $0x66666667,%esi

  for(nfiles = 0; ; nfiles++){
    char name[64];
    name[0] = 'f';
    name[1] = '0' + nfiles / 1000;
    name[2] = '0' + (nfiles % 1000) / 100;
    1473:	83 c2 30             	add    $0x30,%edx
    1476:	88 55 aa             	mov    %dl,-0x56(%ebp)
    name[3] = '0' + (nfiles % 100) / 10;
    1479:	f7 eb                	imul   %ebx
    147b:	c1 fa 05             	sar    $0x5,%edx
    147e:	29 ca                	sub    %ecx,%edx
    1480:	6b fa 64             	imul   $0x64,%edx,%edi
    1483:	89 da                	mov    %ebx,%edx
    1485:	29 fa                	sub    %edi,%edx
    1487:	89 d0                	mov    %edx,%eax
    1489:	89 d7                	mov    %edx,%edi
    148b:	f7 ee                	imul   %esi
    name[4] = '0' + (nfiles % 10);
    148d:	89 d8                	mov    %ebx,%eax
  for(nfiles = 0; ; nfiles++){
    char name[64];
    name[0] = 'f';
    name[1] = '0' + nfiles / 1000;
    name[2] = '0' + (nfiles % 1000) / 100;
    name[3] = '0' + (nfiles % 100) / 10;
    148f:	c1 ff 1f             	sar    $0x1f,%edi
    1492:	c1 fa 02             	sar    $0x2,%edx
    1495:	29 fa                	sub    %edi,%edx
    1497:	83 c2 30             	add    $0x30,%edx
    149a:	88 55 ab             	mov    %dl,-0x55(%ebp)
    name[4] = '0' + (nfiles % 10);
    149d:	f7 ee                	imul   %esi
    149f:	c1 fa 02             	sar    $0x2,%edx
    14a2:	29 ca                	sub    %ecx,%edx
    14a4:	8d 04 92             	lea    (%edx,%edx,4),%eax
    14a7:	89 da                	mov    %ebx,%edx
    14a9:	01 c0                	add    %eax,%eax
    14ab:	29 c2                	sub    %eax,%edx
    14ad:	89 d0                	mov    %edx,%eax
    14af:	83 c0 30             	add    $0x30,%eax
    14b2:	88 45 ac             	mov    %al,-0x54(%ebp)
    name[5] = '\0';
    printf(1, "writing %s\n", name);
    14b5:	8d 45 a8             	lea    -0x58(%ebp),%eax
    14b8:	89 44 24 08          	mov    %eax,0x8(%esp)
    14bc:	e8 3f 3c 00 00       	call   5100 <printf>
    int fd = open(name, O_CREATE|O_RDWR);
    14c1:	8d 55 a8             	lea    -0x58(%ebp),%edx
    14c4:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
    14cb:	00 
    14cc:	89 14 24             	mov    %edx,(%esp)
    14cf:	e8 14 3b 00 00       	call   4fe8 <open>
    if(fd < 0){
    14d4:	85 c0                	test   %eax,%eax
    name[2] = '0' + (nfiles % 1000) / 100;
    name[3] = '0' + (nfiles % 100) / 10;
    name[4] = '0' + (nfiles % 10);
    name[5] = '\0';
    printf(1, "writing %s\n", name);
    int fd = open(name, O_CREATE|O_RDWR);
    14d6:	89 c7                	mov    %eax,%edi
    if(fd < 0){
    14d8:	78 53                	js     152d <fsfull+0x12d>
      printf(1, "open %s failed\n", name);
      break;
    14da:	31 f6                	xor    %esi,%esi
    14dc:	eb 04                	jmp    14e2 <fsfull+0xe2>
    14de:	66 90                	xchg   %ax,%ax
    int total = 0;
    while(1){
      int cc = write(fd, buf, 512);
      if(cc < 512)
        break;
      total += cc;
    14e0:	01 c6                	add    %eax,%esi
      printf(1, "open %s failed\n", name);
      break;
    }
    int total = 0;
    while(1){
      int cc = write(fd, buf, 512);
    14e2:	c7 44 24 08 00 02 00 	movl   $0x200,0x8(%esp)
    14e9:	00 
    14ea:	c7 44 24 04 20 94 00 	movl   $0x9420,0x4(%esp)
    14f1:	00 
    14f2:	89 3c 24             	mov    %edi,(%esp)
    14f5:	e8 ce 3a 00 00       	call   4fc8 <write>
      if(cc < 512)
    14fa:	3d ff 01 00 00       	cmp    $0x1ff,%eax
    14ff:	7f df                	jg     14e0 <fsfull+0xe0>
        break;
      total += cc;
      fsblocks++;
    }
    printf(1, "wrote %d bytes\n", total);
    1501:	89 74 24 08          	mov    %esi,0x8(%esp)
    1505:	c7 44 24 04 ae 55 00 	movl   $0x55ae,0x4(%esp)
    150c:	00 
    150d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1514:	e8 e7 3b 00 00       	call   5100 <printf>
    close(fd);
    1519:	89 3c 24             	mov    %edi,(%esp)
    151c:	e8 af 3a 00 00       	call   4fd0 <close>
    if(total == 0)
    1521:	85 f6                	test   %esi,%esi
    1523:	74 23                	je     1548 <fsfull+0x148>
  int nfiles;
  int fsblocks = 0;

  printf(1, "fsfull test\n");

  for(nfiles = 0; ; nfiles++){
    1525:	83 c3 01             	add    $0x1,%ebx
    }
    printf(1, "wrote %d bytes\n", total);
    close(fd);
    if(total == 0)
      break;
  }
    1528:	e9 f3 fe ff ff       	jmp    1420 <fsfull+0x20>
    name[4] = '0' + (nfiles % 10);
    name[5] = '\0';
    printf(1, "writing %s\n", name);
    int fd = open(name, O_CREATE|O_RDWR);
    if(fd < 0){
      printf(1, "open %s failed\n", name);
    152d:	8d 45 a8             	lea    -0x58(%ebp),%eax
    1530:	89 44 24 08          	mov    %eax,0x8(%esp)
    1534:	c7 44 24 04 9e 55 00 	movl   $0x559e,0x4(%esp)
    153b:	00 
    153c:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1543:	e8 b8 3b 00 00       	call   5100 <printf>
  }

  while(nfiles >= 0){
    char name[64];
    name[0] = 'f';
    name[1] = '0' + nfiles / 1000;
    1548:	b8 d3 4d 62 10       	mov    $0x10624dd3,%eax
    154d:	89 d9                	mov    %ebx,%ecx
    154f:	f7 eb                	imul   %ebx
    1551:	c1 f9 1f             	sar    $0x1f,%ecx
      break;
  }

  while(nfiles >= 0){
    char name[64];
    name[0] = 'f';
    1554:	c6 45 a8 66          	movb   $0x66,-0x58(%ebp)
    name[1] = '0' + nfiles / 1000;
    name[2] = '0' + (nfiles % 1000) / 100;
    name[3] = '0' + (nfiles % 100) / 10;
    name[4] = '0' + (nfiles % 10);
    name[5] = '\0';
    1558:	c6 45 ad 00          	movb   $0x0,-0x53(%ebp)
  }

  while(nfiles >= 0){
    char name[64];
    name[0] = 'f';
    name[1] = '0' + nfiles / 1000;
    155c:	c1 fa 06             	sar    $0x6,%edx
    155f:	29 ca                	sub    %ecx,%edx
    name[2] = '0' + (nfiles % 1000) / 100;
    1561:	69 f2 e8 03 00 00    	imul   $0x3e8,%edx,%esi
  }

  while(nfiles >= 0){
    char name[64];
    name[0] = 'f';
    name[1] = '0' + nfiles / 1000;
    1567:	8d 42 30             	lea    0x30(%edx),%eax
    name[2] = '0' + (nfiles % 1000) / 100;
    156a:	89 da                	mov    %ebx,%edx
  }

  while(nfiles >= 0){
    char name[64];
    name[0] = 'f';
    name[1] = '0' + nfiles / 1000;
    156c:	88 45 a9             	mov    %al,-0x57(%ebp)
    name[2] = '0' + (nfiles % 1000) / 100;
    156f:	b8 1f 85 eb 51       	mov    $0x51eb851f,%eax
    1574:	29 f2                	sub    %esi,%edx
    1576:	89 d6                	mov    %edx,%esi
    1578:	f7 ea                	imul   %edx
    name[3] = '0' + (nfiles % 100) / 10;
    157a:	b8 1f 85 eb 51       	mov    $0x51eb851f,%eax

  while(nfiles >= 0){
    char name[64];
    name[0] = 'f';
    name[1] = '0' + nfiles / 1000;
    name[2] = '0' + (nfiles % 1000) / 100;
    157f:	c1 fe 1f             	sar    $0x1f,%esi
    1582:	c1 fa 05             	sar    $0x5,%edx
    1585:	29 f2                	sub    %esi,%edx
    name[3] = '0' + (nfiles % 100) / 10;
    1587:	be 67 66 66 66       	mov    $0x66666667,%esi

  while(nfiles >= 0){
    char name[64];
    name[0] = 'f';
    name[1] = '0' + nfiles / 1000;
    name[2] = '0' + (nfiles % 1000) / 100;
    158c:	83 c2 30             	add    $0x30,%edx
    158f:	88 55 aa             	mov    %dl,-0x56(%ebp)
    name[3] = '0' + (nfiles % 100) / 10;
    1592:	f7 eb                	imul   %ebx
    1594:	c1 fa 05             	sar    $0x5,%edx
    1597:	29 ca                	sub    %ecx,%edx
    1599:	6b fa 64             	imul   $0x64,%edx,%edi
    159c:	89 da                	mov    %ebx,%edx
    159e:	29 fa                	sub    %edi,%edx
    15a0:	89 d0                	mov    %edx,%eax
    15a2:	89 d7                	mov    %edx,%edi
    15a4:	f7 ee                	imul   %esi
    name[4] = '0' + (nfiles % 10);
    15a6:	89 d8                	mov    %ebx,%eax
  while(nfiles >= 0){
    char name[64];
    name[0] = 'f';
    name[1] = '0' + nfiles / 1000;
    name[2] = '0' + (nfiles % 1000) / 100;
    name[3] = '0' + (nfiles % 100) / 10;
    15a8:	c1 ff 1f             	sar    $0x1f,%edi
    15ab:	c1 fa 02             	sar    $0x2,%edx
    15ae:	29 fa                	sub    %edi,%edx
    15b0:	83 c2 30             	add    $0x30,%edx
    15b3:	88 55 ab             	mov    %dl,-0x55(%ebp)
    name[4] = '0' + (nfiles % 10);
    15b6:	f7 ee                	imul   %esi
    15b8:	c1 fa 02             	sar    $0x2,%edx
    15bb:	29 ca                	sub    %ecx,%edx
    15bd:	8d 04 92             	lea    (%edx,%edx,4),%eax
    15c0:	89 da                	mov    %ebx,%edx
    15c2:	01 c0                	add    %eax,%eax
    name[5] = '\0';
    unlink(name);
    nfiles--;
    15c4:	83 eb 01             	sub    $0x1,%ebx
    char name[64];
    name[0] = 'f';
    name[1] = '0' + nfiles / 1000;
    name[2] = '0' + (nfiles % 1000) / 100;
    name[3] = '0' + (nfiles % 100) / 10;
    name[4] = '0' + (nfiles % 10);
    15c7:	29 c2                	sub    %eax,%edx
    15c9:	89 d0                	mov    %edx,%eax
    15cb:	83 c0 30             	add    $0x30,%eax
    15ce:	88 45 ac             	mov    %al,-0x54(%ebp)
    name[5] = '\0';
    unlink(name);
    15d1:	8d 45 a8             	lea    -0x58(%ebp),%eax
    15d4:	89 04 24             	mov    %eax,(%esp)
    15d7:	e8 1c 3a 00 00       	call   4ff8 <unlink>
    close(fd);
    if(total == 0)
      break;
  }

  while(nfiles >= 0){
    15dc:	83 fb ff             	cmp    $0xffffffff,%ebx
    15df:	0f 85 63 ff ff ff    	jne    1548 <fsfull+0x148>
    name[5] = '\0';
    unlink(name);
    nfiles--;
  }

  printf(1, "fsfull test finished\n");
    15e5:	c7 44 24 04 be 55 00 	movl   $0x55be,0x4(%esp)
    15ec:	00 
    15ed:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    15f4:	e8 07 3b 00 00       	call   5100 <printf>
}
    15f9:	83 c4 5c             	add    $0x5c,%esp
    15fc:	5b                   	pop    %ebx
    15fd:	5e                   	pop    %esi
    15fe:	5f                   	pop    %edi
    15ff:	5d                   	pop    %ebp
    1600:	c3                   	ret    
    1601:	eb 0d                	jmp    1610 <bigwrite>
    1603:	90                   	nop
    1604:	90                   	nop
    1605:	90                   	nop
    1606:	90                   	nop
    1607:	90                   	nop
    1608:	90                   	nop
    1609:	90                   	nop
    160a:	90                   	nop
    160b:	90                   	nop
    160c:	90                   	nop
    160d:	90                   	nop
    160e:	90                   	nop
    160f:	90                   	nop

00001610 <bigwrite>:
}

// test writes that are larger than the log.
void
bigwrite(void)
{
    1610:	55                   	push   %ebp
    1611:	89 e5                	mov    %esp,%ebp
    1613:	56                   	push   %esi
    1614:	53                   	push   %ebx
  int fd, sz;

  printf(1, "bigwrite test\n");

  unlink("bigwrite");
    1615:	bb f3 01 00 00       	mov    $0x1f3,%ebx
}

// test writes that are larger than the log.
void
bigwrite(void)
{
    161a:	83 ec 10             	sub    $0x10,%esp
  int fd, sz;

  printf(1, "bigwrite test\n");
    161d:	c7 44 24 04 d4 55 00 	movl   $0x55d4,0x4(%esp)
    1624:	00 
    1625:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    162c:	e8 cf 3a 00 00       	call   5100 <printf>

  unlink("bigwrite");
    1631:	c7 04 24 e3 55 00 00 	movl   $0x55e3,(%esp)
    1638:	e8 bb 39 00 00       	call   4ff8 <unlink>
    163d:	8d 76 00             	lea    0x0(%esi),%esi
  for(sz = 499; sz < 12*512; sz += 471){
    fd = open("bigwrite", O_CREATE | O_RDWR);
    1640:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
    1647:	00 
    1648:	c7 04 24 e3 55 00 00 	movl   $0x55e3,(%esp)
    164f:	e8 94 39 00 00       	call   4fe8 <open>
    if(fd < 0){
    1654:	85 c0                	test   %eax,%eax

  printf(1, "bigwrite test\n");

  unlink("bigwrite");
  for(sz = 499; sz < 12*512; sz += 471){
    fd = open("bigwrite", O_CREATE | O_RDWR);
    1656:	89 c6                	mov    %eax,%esi
    if(fd < 0){
    1658:	0f 88 95 00 00 00    	js     16f3 <bigwrite+0xe3>
      printf(1, "cannot create bigwrite\n");
      exit(0);
    }
    int i;
    for(i = 0; i < 2; i++){
      int cc = write(fd, buf, sz);
    165e:	89 5c 24 08          	mov    %ebx,0x8(%esp)
    1662:	c7 44 24 04 20 94 00 	movl   $0x9420,0x4(%esp)
    1669:	00 
    166a:	89 04 24             	mov    %eax,(%esp)
    166d:	e8 56 39 00 00       	call   4fc8 <write>
      if(cc != sz){
    1672:	39 c3                	cmp    %eax,%ebx
    1674:	75 55                	jne    16cb <bigwrite+0xbb>
      printf(1, "cannot create bigwrite\n");
      exit(0);
    }
    int i;
    for(i = 0; i < 2; i++){
      int cc = write(fd, buf, sz);
    1676:	89 5c 24 08          	mov    %ebx,0x8(%esp)
    167a:	c7 44 24 04 20 94 00 	movl   $0x9420,0x4(%esp)
    1681:	00 
    1682:	89 34 24             	mov    %esi,(%esp)
    1685:	e8 3e 39 00 00       	call   4fc8 <write>
      if(cc != sz){
    168a:	39 d8                	cmp    %ebx,%eax
    168c:	75 3d                	jne    16cb <bigwrite+0xbb>
  int fd, sz;

  printf(1, "bigwrite test\n");

  unlink("bigwrite");
  for(sz = 499; sz < 12*512; sz += 471){
    168e:	81 c3 d7 01 00 00    	add    $0x1d7,%ebx
      if(cc != sz){
        printf(1, "write(%d) ret %d\n", sz, cc);
        exit(0);
      }
    }
    close(fd);
    1694:	89 34 24             	mov    %esi,(%esp)
    1697:	e8 34 39 00 00       	call   4fd0 <close>
    unlink("bigwrite");
    169c:	c7 04 24 e3 55 00 00 	movl   $0x55e3,(%esp)
    16a3:	e8 50 39 00 00       	call   4ff8 <unlink>
  int fd, sz;

  printf(1, "bigwrite test\n");

  unlink("bigwrite");
  for(sz = 499; sz < 12*512; sz += 471){
    16a8:	81 fb 07 18 00 00    	cmp    $0x1807,%ebx
    16ae:	75 90                	jne    1640 <bigwrite+0x30>
    }
    close(fd);
    unlink("bigwrite");
  }

  printf(1, "bigwrite ok\n");
    16b0:	c7 44 24 04 16 56 00 	movl   $0x5616,0x4(%esp)
    16b7:	00 
    16b8:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    16bf:	e8 3c 3a 00 00       	call   5100 <printf>
}
    16c4:	83 c4 10             	add    $0x10,%esp
    16c7:	5b                   	pop    %ebx
    16c8:	5e                   	pop    %esi
    16c9:	5d                   	pop    %ebp
    16ca:	c3                   	ret    
    }
    int i;
    for(i = 0; i < 2; i++){
      int cc = write(fd, buf, sz);
      if(cc != sz){
        printf(1, "write(%d) ret %d\n", sz, cc);
    16cb:	89 44 24 0c          	mov    %eax,0xc(%esp)
    16cf:	89 5c 24 08          	mov    %ebx,0x8(%esp)
    16d3:	c7 44 24 04 04 56 00 	movl   $0x5604,0x4(%esp)
    16da:	00 
    16db:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    16e2:	e8 19 3a 00 00       	call   5100 <printf>
        exit(0);
    16e7:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    16ee:	e8 b5 38 00 00       	call   4fa8 <exit>

  unlink("bigwrite");
  for(sz = 499; sz < 12*512; sz += 471){
    fd = open("bigwrite", O_CREATE | O_RDWR);
    if(fd < 0){
      printf(1, "cannot create bigwrite\n");
    16f3:	c7 44 24 04 ec 55 00 	movl   $0x55ec,0x4(%esp)
    16fa:	00 
    16fb:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1702:	e8 f9 39 00 00       	call   5100 <printf>
      exit(0);
    1707:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    170e:	e8 95 38 00 00       	call   4fa8 <exit>
    1713:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    1719:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001720 <unlinkread>:
}

// can I unlink a file and still read it?
void
unlinkread(void)
{
    1720:	55                   	push   %ebp
    1721:	89 e5                	mov    %esp,%ebp
    1723:	56                   	push   %esi
    1724:	53                   	push   %ebx
    1725:	83 ec 10             	sub    $0x10,%esp
  int fd, fd1;

  printf(1, "unlinkread test\n");
    1728:	c7 44 24 04 23 56 00 	movl   $0x5623,0x4(%esp)
    172f:	00 
    1730:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1737:	e8 c4 39 00 00       	call   5100 <printf>
  fd = open("unlinkread", O_CREATE | O_RDWR);
    173c:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
    1743:	00 
    1744:	c7 04 24 34 56 00 00 	movl   $0x5634,(%esp)
    174b:	e8 98 38 00 00       	call   4fe8 <open>
  if(fd < 0){
    1750:	85 c0                	test   %eax,%eax
unlinkread(void)
{
  int fd, fd1;

  printf(1, "unlinkread test\n");
  fd = open("unlinkread", O_CREATE | O_RDWR);
    1752:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    1754:	0f 88 02 01 00 00    	js     185c <unlinkread+0x13c>
    printf(1, "create unlinkread failed\n");
    exit(0);
  }
  write(fd, "hello", 5);
    175a:	c7 44 24 08 05 00 00 	movl   $0x5,0x8(%esp)
    1761:	00 
    1762:	c7 44 24 04 59 56 00 	movl   $0x5659,0x4(%esp)
    1769:	00 
    176a:	89 04 24             	mov    %eax,(%esp)
    176d:	e8 56 38 00 00       	call   4fc8 <write>
  close(fd);
    1772:	89 1c 24             	mov    %ebx,(%esp)
    1775:	e8 56 38 00 00       	call   4fd0 <close>

  fd = open("unlinkread", O_RDWR);
    177a:	c7 44 24 04 02 00 00 	movl   $0x2,0x4(%esp)
    1781:	00 
    1782:	c7 04 24 34 56 00 00 	movl   $0x5634,(%esp)
    1789:	e8 5a 38 00 00       	call   4fe8 <open>
  if(fd < 0){
    178e:	85 c0                	test   %eax,%eax
    exit(0);
  }
  write(fd, "hello", 5);
  close(fd);

  fd = open("unlinkread", O_RDWR);
    1790:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    1792:	0f 88 64 01 00 00    	js     18fc <unlinkread+0x1dc>
    printf(1, "open unlinkread failed\n");
    exit(0);
  }
  if(unlink("unlinkread") != 0){
    1798:	c7 04 24 34 56 00 00 	movl   $0x5634,(%esp)
    179f:	e8 54 38 00 00       	call   4ff8 <unlink>
    17a4:	85 c0                	test   %eax,%eax
    17a6:	0f 85 30 01 00 00    	jne    18dc <unlinkread+0x1bc>
    printf(1, "unlink unlinkread failed\n");
    exit(0);
  }

  fd1 = open("unlinkread", O_CREATE | O_RDWR);
    17ac:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
    17b3:	00 
    17b4:	c7 04 24 34 56 00 00 	movl   $0x5634,(%esp)
    17bb:	e8 28 38 00 00       	call   4fe8 <open>
  write(fd1, "yyy", 3);
    17c0:	c7 44 24 08 03 00 00 	movl   $0x3,0x8(%esp)
    17c7:	00 
    17c8:	c7 44 24 04 91 56 00 	movl   $0x5691,0x4(%esp)
    17cf:	00 
  if(unlink("unlinkread") != 0){
    printf(1, "unlink unlinkread failed\n");
    exit(0);
  }

  fd1 = open("unlinkread", O_CREATE | O_RDWR);
    17d0:	89 c6                	mov    %eax,%esi
  write(fd1, "yyy", 3);
    17d2:	89 04 24             	mov    %eax,(%esp)
    17d5:	e8 ee 37 00 00       	call   4fc8 <write>
  close(fd1);
    17da:	89 34 24             	mov    %esi,(%esp)
    17dd:	e8 ee 37 00 00       	call   4fd0 <close>

  if(read(fd, buf, sizeof(buf)) != 5){
    17e2:	c7 44 24 08 00 20 00 	movl   $0x2000,0x8(%esp)
    17e9:	00 
    17ea:	c7 44 24 04 20 94 00 	movl   $0x9420,0x4(%esp)
    17f1:	00 
    17f2:	89 1c 24             	mov    %ebx,(%esp)
    17f5:	e8 c6 37 00 00       	call   4fc0 <read>
    17fa:	83 f8 05             	cmp    $0x5,%eax
    17fd:	0f 85 b9 00 00 00    	jne    18bc <unlinkread+0x19c>
    printf(1, "unlinkread read failed");
    exit(0);
  }
  if(buf[0] != 'h'){
    1803:	80 3d 20 94 00 00 68 	cmpb   $0x68,0x9420
    180a:	0f 85 8c 00 00 00    	jne    189c <unlinkread+0x17c>
    printf(1, "unlinkread wrong data\n");
    exit(0);
  }
  if(write(fd, buf, 10) != 10){
    1810:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
    1817:	00 
    1818:	c7 44 24 04 20 94 00 	movl   $0x9420,0x4(%esp)
    181f:	00 
    1820:	89 1c 24             	mov    %ebx,(%esp)
    1823:	e8 a0 37 00 00       	call   4fc8 <write>
    1828:	83 f8 0a             	cmp    $0xa,%eax
    182b:	75 4f                	jne    187c <unlinkread+0x15c>
    printf(1, "unlinkread write failed\n");
    exit(0);
  }
  close(fd);
    182d:	89 1c 24             	mov    %ebx,(%esp)
    1830:	e8 9b 37 00 00       	call   4fd0 <close>
  unlink("unlinkread");
    1835:	c7 04 24 34 56 00 00 	movl   $0x5634,(%esp)
    183c:	e8 b7 37 00 00       	call   4ff8 <unlink>
  printf(1, "unlinkread ok\n");
    1841:	c7 44 24 04 dc 56 00 	movl   $0x56dc,0x4(%esp)
    1848:	00 
    1849:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1850:	e8 ab 38 00 00       	call   5100 <printf>
}
    1855:	83 c4 10             	add    $0x10,%esp
    1858:	5b                   	pop    %ebx
    1859:	5e                   	pop    %esi
    185a:	5d                   	pop    %ebp
    185b:	c3                   	ret    
  int fd, fd1;

  printf(1, "unlinkread test\n");
  fd = open("unlinkread", O_CREATE | O_RDWR);
  if(fd < 0){
    printf(1, "create unlinkread failed\n");
    185c:	c7 44 24 04 3f 56 00 	movl   $0x563f,0x4(%esp)
    1863:	00 
    1864:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    186b:	e8 90 38 00 00       	call   5100 <printf>
    exit(0);
    1870:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1877:	e8 2c 37 00 00       	call   4fa8 <exit>
  if(buf[0] != 'h'){
    printf(1, "unlinkread wrong data\n");
    exit(0);
  }
  if(write(fd, buf, 10) != 10){
    printf(1, "unlinkread write failed\n");
    187c:	c7 44 24 04 c3 56 00 	movl   $0x56c3,0x4(%esp)
    1883:	00 
    1884:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    188b:	e8 70 38 00 00       	call   5100 <printf>
    exit(0);
    1890:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1897:	e8 0c 37 00 00       	call   4fa8 <exit>
  if(read(fd, buf, sizeof(buf)) != 5){
    printf(1, "unlinkread read failed");
    exit(0);
  }
  if(buf[0] != 'h'){
    printf(1, "unlinkread wrong data\n");
    189c:	c7 44 24 04 ac 56 00 	movl   $0x56ac,0x4(%esp)
    18a3:	00 
    18a4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    18ab:	e8 50 38 00 00       	call   5100 <printf>
    exit(0);
    18b0:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    18b7:	e8 ec 36 00 00       	call   4fa8 <exit>
  fd1 = open("unlinkread", O_CREATE | O_RDWR);
  write(fd1, "yyy", 3);
  close(fd1);

  if(read(fd, buf, sizeof(buf)) != 5){
    printf(1, "unlinkread read failed");
    18bc:	c7 44 24 04 95 56 00 	movl   $0x5695,0x4(%esp)
    18c3:	00 
    18c4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    18cb:	e8 30 38 00 00       	call   5100 <printf>
    exit(0);
    18d0:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    18d7:	e8 cc 36 00 00       	call   4fa8 <exit>
  if(fd < 0){
    printf(1, "open unlinkread failed\n");
    exit(0);
  }
  if(unlink("unlinkread") != 0){
    printf(1, "unlink unlinkread failed\n");
    18dc:	c7 44 24 04 77 56 00 	movl   $0x5677,0x4(%esp)
    18e3:	00 
    18e4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    18eb:	e8 10 38 00 00       	call   5100 <printf>
    exit(0);
    18f0:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    18f7:	e8 ac 36 00 00       	call   4fa8 <exit>
  write(fd, "hello", 5);
  close(fd);

  fd = open("unlinkread", O_RDWR);
  if(fd < 0){
    printf(1, "open unlinkread failed\n");
    18fc:	c7 44 24 04 5f 56 00 	movl   $0x565f,0x4(%esp)
    1903:	00 
    1904:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    190b:	e8 f0 37 00 00       	call   5100 <printf>
    exit(0);
    1910:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1917:	e8 8c 36 00 00       	call   4fa8 <exit>
    191c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00001920 <createdelete>:
}

// four processes create and delete different files in same directory
void
createdelete(void)
{
    1920:	55                   	push   %ebp
    1921:	89 e5                	mov    %esp,%ebp
    1923:	57                   	push   %edi
    1924:	56                   	push   %esi
    1925:	53                   	push   %ebx
  enum { N = 20 };
  int pid, i, fd, pi;
  char name[32];

  printf(1, "createdelete test\n");
    1926:	31 db                	xor    %ebx,%ebx
}

// four processes create and delete different files in same directory
void
createdelete(void)
{
    1928:	83 ec 4c             	sub    $0x4c,%esp
  enum { N = 20 };
  int pid, i, fd, pi;
  char name[32];

  printf(1, "createdelete test\n");
    192b:	c7 44 24 04 eb 56 00 	movl   $0x56eb,0x4(%esp)
    1932:	00 
    1933:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    193a:	e8 c1 37 00 00       	call   5100 <printf>

  for(pi = 0; pi < 4; pi++){
    pid = fork();
    193f:	e8 5c 36 00 00       	call   4fa0 <fork>
    if(pid < 0){
    1944:	83 f8 00             	cmp    $0x0,%eax
    1947:	0f 8c 00 02 00 00    	jl     1b4d <createdelete+0x22d>
    194d:	8d 76 00             	lea    0x0(%esi),%esi
      printf(1, "fork failed\n");
      exit(0);
    }

    if(pid == 0){
    1950:	0f 84 09 01 00 00    	je     1a5f <createdelete+0x13f>
  int pid, i, fd, pi;
  char name[32];

  printf(1, "createdelete test\n");

  for(pi = 0; pi < 4; pi++){
    1956:	83 c3 01             	add    $0x1,%ebx
    1959:	83 fb 04             	cmp    $0x4,%ebx
    195c:	75 e1                	jne    193f <createdelete+0x1f>
    195e:	8d 75 c8             	lea    -0x38(%ebp),%esi

  for(pi = 0; pi < 4; pi++){
    wait(&exit_status);
  }

  name[0] = name[1] = name[2] = 0;
    1961:	31 ff                	xor    %edi,%edi
      exit(0);
    }
  }

  for(pi = 0; pi < 4; pi++){
    wait(&exit_status);
    1963:	c7 04 24 e0 6c 00 00 	movl   $0x6ce0,(%esp)
    196a:	e8 41 36 00 00       	call   4fb0 <wait>
    196f:	c7 04 24 e0 6c 00 00 	movl   $0x6ce0,(%esp)
    1976:	e8 35 36 00 00       	call   4fb0 <wait>
    197b:	c7 04 24 e0 6c 00 00 	movl   $0x6ce0,(%esp)
    1982:	e8 29 36 00 00       	call   4fb0 <wait>
    1987:	c7 04 24 e0 6c 00 00 	movl   $0x6ce0,(%esp)
    198e:	e8 1d 36 00 00       	call   4fb0 <wait>
  }

  name[0] = name[1] = name[2] = 0;
    1993:	c6 45 ca 00          	movb   $0x0,-0x36(%ebp)
    1997:	89 75 c0             	mov    %esi,-0x40(%ebp)
    199a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(i = 0; i < N; i++){
    19a0:	85 ff                	test   %edi,%edi
    19a2:	bb 70 00 00 00       	mov    $0x70,%ebx
    19a7:	8d 47 30             	lea    0x30(%edi),%eax
    19aa:	0f 94 c2             	sete   %dl
    19ad:	83 ff 09             	cmp    $0x9,%edi
    19b0:	89 d6                	mov    %edx,%esi
    19b2:	88 45 c4             	mov    %al,-0x3c(%ebp)
    19b5:	0f 9f c0             	setg   %al
    19b8:	09 c6                	or     %eax,%esi
      name[1] = '0' + i;
      fd = open(name, 0);
      if((i == 0 || i >= N/2) && fd < 0){
        printf(1, "oops createdelete %s didn't exist\n", name);
        exit(0);
      } else if((i >= 1 && i < N/2) && fd >= 0){
    19ba:	8d 47 ff             	lea    -0x1(%edi),%eax
    19bd:	89 45 bc             	mov    %eax,-0x44(%ebp)
  name[0] = name[1] = name[2] = 0;
  for(i = 0; i < N; i++){
    for(pi = 0; pi < 4; pi++){
      name[0] = 'p' + pi;
      name[1] = '0' + i;
      fd = open(name, 0);
    19c0:	8b 55 c0             	mov    -0x40(%ebp),%edx

  name[0] = name[1] = name[2] = 0;
  for(i = 0; i < N; i++){
    for(pi = 0; pi < 4; pi++){
      name[0] = 'p' + pi;
      name[1] = '0' + i;
    19c3:	0f b6 45 c4          	movzbl -0x3c(%ebp),%eax
  }

  name[0] = name[1] = name[2] = 0;
  for(i = 0; i < N; i++){
    for(pi = 0; pi < 4; pi++){
      name[0] = 'p' + pi;
    19c7:	88 5d c8             	mov    %bl,-0x38(%ebp)
      name[1] = '0' + i;
      fd = open(name, 0);
    19ca:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    19d1:	00 
    19d2:	89 14 24             	mov    %edx,(%esp)

  name[0] = name[1] = name[2] = 0;
  for(i = 0; i < N; i++){
    for(pi = 0; pi < 4; pi++){
      name[0] = 'p' + pi;
      name[1] = '0' + i;
    19d5:	88 45 c9             	mov    %al,-0x37(%ebp)
      fd = open(name, 0);
    19d8:	e8 0b 36 00 00       	call   4fe8 <open>
      if((i == 0 || i >= N/2) && fd < 0){
    19dd:	89 f2                	mov    %esi,%edx
    19df:	84 d2                	test   %dl,%dl
    19e1:	74 08                	je     19eb <createdelete+0xcb>
    19e3:	85 c0                	test   %eax,%eax
    19e5:	0f 88 01 01 00 00    	js     1aec <createdelete+0x1cc>
        printf(1, "oops createdelete %s didn't exist\n", name);
        exit(0);
      } else if((i >= 1 && i < N/2) && fd >= 0){
    19eb:	85 c0                	test   %eax,%eax
    19ed:	8d 76 00             	lea    0x0(%esi),%esi
    19f0:	0f 89 1d 01 00 00    	jns    1b13 <createdelete+0x1f3>
        printf(1, "oops createdelete %s did exist\n", name);
        exit(0);
      }
      if(fd >= 0)
        close(fd);
    19f6:	83 c3 01             	add    $0x1,%ebx
    wait(&exit_status);
  }

  name[0] = name[1] = name[2] = 0;
  for(i = 0; i < N; i++){
    for(pi = 0; pi < 4; pi++){
    19f9:	80 fb 74             	cmp    $0x74,%bl
    19fc:	75 c2                	jne    19c0 <createdelete+0xa0>
  for(pi = 0; pi < 4; pi++){
    wait(&exit_status);
  }

  name[0] = name[1] = name[2] = 0;
  for(i = 0; i < N; i++){
    19fe:	83 c7 01             	add    $0x1,%edi
    1a01:	83 ff 14             	cmp    $0x14,%edi
    1a04:	75 9a                	jne    19a0 <createdelete+0x80>
    1a06:	8b 75 c0             	mov    -0x40(%ebp),%esi
    1a09:	bf 70 00 00 00       	mov    $0x70,%edi
    1a0e:	89 75 c4             	mov    %esi,-0x3c(%ebp)
    1a11:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      if(fd >= 0)
        close(fd);
    }
  }

  for(i = 0; i < N; i++){
    1a18:	8d 77 c0             	lea    -0x40(%edi),%esi
    1a1b:	31 db                	xor    %ebx,%ebx
    for(pi = 0; pi < 4; pi++){
      name[0] = 'p' + i;
    1a1d:	89 fa                	mov    %edi,%edx
      name[1] = '0' + i;
    1a1f:	89 f0                	mov    %esi,%eax
    }
  }

  for(i = 0; i < N; i++){
    for(pi = 0; pi < 4; pi++){
      name[0] = 'p' + i;
    1a21:	88 55 c8             	mov    %dl,-0x38(%ebp)
      name[1] = '0' + i;
      unlink(name);
    1a24:	8b 55 c4             	mov    -0x3c(%ebp),%edx
        close(fd);
    }
  }

  for(i = 0; i < N; i++){
    for(pi = 0; pi < 4; pi++){
    1a27:	83 c3 01             	add    $0x1,%ebx
      name[0] = 'p' + i;
      name[1] = '0' + i;
    1a2a:	88 45 c9             	mov    %al,-0x37(%ebp)
      unlink(name);
    1a2d:	89 14 24             	mov    %edx,(%esp)
    1a30:	e8 c3 35 00 00       	call   4ff8 <unlink>
        close(fd);
    }
  }

  for(i = 0; i < N; i++){
    for(pi = 0; pi < 4; pi++){
    1a35:	83 fb 04             	cmp    $0x4,%ebx
    1a38:	75 e3                	jne    1a1d <createdelete+0xfd>
    1a3a:	83 c7 01             	add    $0x1,%edi
      if(fd >= 0)
        close(fd);
    }
  }

  for(i = 0; i < N; i++){
    1a3d:	89 f8                	mov    %edi,%eax
    1a3f:	3c 84                	cmp    $0x84,%al
    1a41:	75 d5                	jne    1a18 <createdelete+0xf8>
      name[1] = '0' + i;
      unlink(name);
    }
  }

  printf(1, "createdelete ok\n");
    1a43:	c7 44 24 04 0d 57 00 	movl   $0x570d,0x4(%esp)
    1a4a:	00 
    1a4b:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1a52:	e8 a9 36 00 00       	call   5100 <printf>
}
    1a57:	83 c4 4c             	add    $0x4c,%esp
    1a5a:	5b                   	pop    %ebx
    1a5b:	5e                   	pop    %esi
    1a5c:	5f                   	pop    %edi
    1a5d:	5d                   	pop    %ebp
    1a5e:	c3                   	ret    
      printf(1, "fork failed\n");
      exit(0);
    }

    if(pid == 0){
      name[0] = 'p' + pi;
    1a5f:	83 c3 70             	add    $0x70,%ebx
      name[2] = '\0';
    1a62:	bf 01 00 00 00       	mov    $0x1,%edi
      printf(1, "fork failed\n");
      exit(0);
    }

    if(pid == 0){
      name[0] = 'p' + pi;
    1a67:	88 5d c8             	mov    %bl,-0x38(%ebp)
    1a6a:	8d 75 c8             	lea    -0x38(%ebp),%esi
      name[2] = '\0';
    1a6d:	31 db                	xor    %ebx,%ebx
    1a6f:	c6 45 ca 00          	movb   $0x0,-0x36(%ebp)
    1a73:	eb 12                	jmp    1a87 <createdelete+0x167>
    1a75:	8d 76 00             	lea    0x0(%esi),%esi
      for(i = 0; i < N; i++){
    1a78:	83 ff 13             	cmp    $0x13,%edi
    1a7b:	0f 8f 86 00 00 00    	jg     1b07 <createdelete+0x1e7>
      exit(0);
    }

    if(pid == 0){
      name[0] = 'p' + pi;
      name[2] = '\0';
    1a81:	83 c3 01             	add    $0x1,%ebx
    1a84:	83 c7 01             	add    $0x1,%edi
      for(i = 0; i < N; i++){
        name[1] = '0' + i;
    1a87:	8d 43 30             	lea    0x30(%ebx),%eax
    1a8a:	88 45 c9             	mov    %al,-0x37(%ebp)
        fd = open(name, O_CREATE | O_RDWR);
    1a8d:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
    1a94:	00 
    1a95:	89 34 24             	mov    %esi,(%esp)
    1a98:	e8 4b 35 00 00       	call   4fe8 <open>
        if(fd < 0){
    1a9d:	85 c0                	test   %eax,%eax
    1a9f:	0f 88 c8 00 00 00    	js     1b6d <createdelete+0x24d>
          printf(1, "create failed\n");
          exit(0);
        }
        close(fd);
    1aa5:	89 04 24             	mov    %eax,(%esp)
    1aa8:	e8 23 35 00 00       	call   4fd0 <close>
        if(i > 0 && (i % 2 ) == 0){
    1aad:	85 db                	test   %ebx,%ebx
    1aaf:	74 d0                	je     1a81 <createdelete+0x161>
    1ab1:	f6 c3 01             	test   $0x1,%bl
    1ab4:	75 c2                	jne    1a78 <createdelete+0x158>
          name[1] = '0' + (i / 2);
    1ab6:	89 d8                	mov    %ebx,%eax
    1ab8:	d1 f8                	sar    %eax
    1aba:	83 c0 30             	add    $0x30,%eax
    1abd:	88 45 c9             	mov    %al,-0x37(%ebp)
          if(unlink(name) < 0){
    1ac0:	89 34 24             	mov    %esi,(%esp)
    1ac3:	e8 30 35 00 00       	call   4ff8 <unlink>
    1ac8:	85 c0                	test   %eax,%eax
    1aca:	79 ac                	jns    1a78 <createdelete+0x158>
            printf(1, "unlink failed\n");
    1acc:	c7 44 24 04 fe 56 00 	movl   $0x56fe,0x4(%esp)
    1ad3:	00 
    1ad4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1adb:	e8 20 36 00 00       	call   5100 <printf>
            exit(0);
    1ae0:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1ae7:	e8 bc 34 00 00       	call   4fa8 <exit>
    1aec:	8b 75 c0             	mov    -0x40(%ebp),%esi
    for(pi = 0; pi < 4; pi++){
      name[0] = 'p' + pi;
      name[1] = '0' + i;
      fd = open(name, 0);
      if((i == 0 || i >= N/2) && fd < 0){
        printf(1, "oops createdelete %s didn't exist\n", name);
    1aef:	c7 44 24 04 d4 64 00 	movl   $0x64d4,0x4(%esp)
    1af6:	00 
    1af7:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1afe:	89 74 24 08          	mov    %esi,0x8(%esp)
    1b02:	e8 f9 35 00 00       	call   5100 <printf>
        exit(0);
    1b07:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1b0e:	e8 95 34 00 00       	call   4fa8 <exit>
      } else if((i >= 1 && i < N/2) && fd >= 0){
    1b13:	83 7d bc 08          	cmpl   $0x8,-0x44(%ebp)
    1b17:	76 0d                	jbe    1b26 <createdelete+0x206>
        printf(1, "oops createdelete %s did exist\n", name);
        exit(0);
      }
      if(fd >= 0)
        close(fd);
    1b19:	89 04 24             	mov    %eax,(%esp)
    1b1c:	e8 af 34 00 00       	call   4fd0 <close>
    1b21:	e9 d0 fe ff ff       	jmp    19f6 <createdelete+0xd6>
    1b26:	8b 75 c0             	mov    -0x40(%ebp),%esi
      fd = open(name, 0);
      if((i == 0 || i >= N/2) && fd < 0){
        printf(1, "oops createdelete %s didn't exist\n", name);
        exit(0);
      } else if((i >= 1 && i < N/2) && fd >= 0){
        printf(1, "oops createdelete %s did exist\n", name);
    1b29:	c7 44 24 04 f8 64 00 	movl   $0x64f8,0x4(%esp)
    1b30:	00 
    1b31:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1b38:	89 74 24 08          	mov    %esi,0x8(%esp)
    1b3c:	e8 bf 35 00 00       	call   5100 <printf>
        exit(0);
    1b41:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1b48:	e8 5b 34 00 00       	call   4fa8 <exit>
  printf(1, "createdelete test\n");

  for(pi = 0; pi < 4; pi++){
    pid = fork();
    if(pid < 0){
      printf(1, "fork failed\n");
    1b4d:	c7 44 24 04 df 58 00 	movl   $0x58df,0x4(%esp)
    1b54:	00 
    1b55:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1b5c:	e8 9f 35 00 00       	call   5100 <printf>
      exit(0);
    1b61:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1b68:	e8 3b 34 00 00       	call   4fa8 <exit>
      name[2] = '\0';
      for(i = 0; i < N; i++){
        name[1] = '0' + i;
        fd = open(name, O_CREATE | O_RDWR);
        if(fd < 0){
          printf(1, "create failed\n");
    1b6d:	c7 44 24 04 75 59 00 	movl   $0x5975,0x4(%esp)
    1b74:	00 
    1b75:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1b7c:	e8 7f 35 00 00       	call   5100 <printf>
          exit(0);
    1b81:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1b88:	e8 1b 34 00 00       	call   4fa8 <exit>
    1b8d:	8d 76 00             	lea    0x0(%esi),%esi

00001b90 <createtest>:
  printf(stdout, "big files ok\n");
}

void
createtest(void)
{
    1b90:	55                   	push   %ebp
    1b91:	89 e5                	mov    %esp,%ebp
    1b93:	53                   	push   %ebx
  int i, fd;

  printf(stdout, "many creates, followed by unlink test\n");

  name[0] = 'a';
  name[2] = '\0';
    1b94:	bb 30 00 00 00       	mov    $0x30,%ebx
  printf(stdout, "big files ok\n");
}

void
createtest(void)
{
    1b99:	83 ec 14             	sub    $0x14,%esp
  int i, fd;

  printf(stdout, "many creates, followed by unlink test\n");
    1b9c:	a1 2c 6c 00 00       	mov    0x6c2c,%eax
    1ba1:	c7 44 24 04 18 65 00 	movl   $0x6518,0x4(%esp)
    1ba8:	00 
    1ba9:	89 04 24             	mov    %eax,(%esp)
    1bac:	e8 4f 35 00 00       	call   5100 <printf>

  name[0] = 'a';
    1bb1:	c6 05 20 b4 00 00 61 	movb   $0x61,0xb420
  name[2] = '\0';
    1bb8:	c6 05 22 b4 00 00 00 	movb   $0x0,0xb422
    1bbf:	90                   	nop
  for(i = 0; i < 52; i++){
    name[1] = '0' + i;
    1bc0:	88 1d 21 b4 00 00    	mov    %bl,0xb421
    fd = open(name, O_CREATE|O_RDWR);
    close(fd);
    1bc6:	83 c3 01             	add    $0x1,%ebx

  name[0] = 'a';
  name[2] = '\0';
  for(i = 0; i < 52; i++){
    name[1] = '0' + i;
    fd = open(name, O_CREATE|O_RDWR);
    1bc9:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
    1bd0:	00 
    1bd1:	c7 04 24 20 b4 00 00 	movl   $0xb420,(%esp)
    1bd8:	e8 0b 34 00 00       	call   4fe8 <open>
    close(fd);
    1bdd:	89 04 24             	mov    %eax,(%esp)
    1be0:	e8 eb 33 00 00       	call   4fd0 <close>

  printf(stdout, "many creates, followed by unlink test\n");

  name[0] = 'a';
  name[2] = '\0';
  for(i = 0; i < 52; i++){
    1be5:	80 fb 64             	cmp    $0x64,%bl
    1be8:	75 d6                	jne    1bc0 <createtest+0x30>
    name[1] = '0' + i;
    fd = open(name, O_CREATE|O_RDWR);
    close(fd);
  }
  name[0] = 'a';
    1bea:	c6 05 20 b4 00 00 61 	movb   $0x61,0xb420
  name[2] = '\0';
    1bf1:	bb 30 00 00 00       	mov    $0x30,%ebx
    1bf6:	c6 05 22 b4 00 00 00 	movb   $0x0,0xb422
    1bfd:	8d 76 00             	lea    0x0(%esi),%esi
  for(i = 0; i < 52; i++){
    name[1] = '0' + i;
    1c00:	88 1d 21 b4 00 00    	mov    %bl,0xb421
    unlink(name);
    1c06:	83 c3 01             	add    $0x1,%ebx
    1c09:	c7 04 24 20 b4 00 00 	movl   $0xb420,(%esp)
    1c10:	e8 e3 33 00 00       	call   4ff8 <unlink>
    fd = open(name, O_CREATE|O_RDWR);
    close(fd);
  }
  name[0] = 'a';
  name[2] = '\0';
  for(i = 0; i < 52; i++){
    1c15:	80 fb 64             	cmp    $0x64,%bl
    1c18:	75 e6                	jne    1c00 <createtest+0x70>
    name[1] = '0' + i;
    unlink(name);
  }
  printf(stdout, "many creates, followed by unlink; ok\n");
    1c1a:	a1 2c 6c 00 00       	mov    0x6c2c,%eax
    1c1f:	c7 44 24 04 40 65 00 	movl   $0x6540,0x4(%esp)
    1c26:	00 
    1c27:	89 04 24             	mov    %eax,(%esp)
    1c2a:	e8 d1 34 00 00       	call   5100 <printf>
}
    1c2f:	83 c4 14             	add    $0x14,%esp
    1c32:	5b                   	pop    %ebx
    1c33:	5d                   	pop    %ebp
    1c34:	c3                   	ret    
    1c35:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1c39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001c40 <writetest1>:
  printf(stdout, "small file test ok\n");
}

void
writetest1(void)
{
    1c40:	55                   	push   %ebp
    1c41:	89 e5                	mov    %esp,%ebp
    1c43:	56                   	push   %esi
    1c44:	53                   	push   %ebx
    1c45:	83 ec 10             	sub    $0x10,%esp
  int i, fd, n;

  printf(stdout, "big files test\n");
    1c48:	a1 2c 6c 00 00       	mov    0x6c2c,%eax
    1c4d:	c7 44 24 04 1e 57 00 	movl   $0x571e,0x4(%esp)
    1c54:	00 
    1c55:	89 04 24             	mov    %eax,(%esp)
    1c58:	e8 a3 34 00 00       	call   5100 <printf>

  fd = open("big", O_CREATE|O_RDWR);
    1c5d:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
    1c64:	00 
    1c65:	c7 04 24 98 57 00 00 	movl   $0x5798,(%esp)
    1c6c:	e8 77 33 00 00       	call   4fe8 <open>
  if(fd < 0){
    1c71:	85 c0                	test   %eax,%eax
{
  int i, fd, n;

  printf(stdout, "big files test\n");

  fd = open("big", O_CREATE|O_RDWR);
    1c73:	89 c6                	mov    %eax,%esi
  if(fd < 0){
    1c75:	0f 88 6f 01 00 00    	js     1dea <writetest1+0x1aa>
    printf(stdout, "error: creat big failed!\n");
    exit(0);
    1c7b:	31 db                	xor    %ebx,%ebx
    1c7d:	8d 76 00             	lea    0x0(%esi),%esi
  }

  for(i = 0; i < MAXFILE; i++){
    ((int*)buf)[0] = i;
    1c80:	89 1d 20 94 00 00    	mov    %ebx,0x9420
    if(write(fd, buf, 512) != 512){
    1c86:	c7 44 24 08 00 02 00 	movl   $0x200,0x8(%esp)
    1c8d:	00 
    1c8e:	c7 44 24 04 20 94 00 	movl   $0x9420,0x4(%esp)
    1c95:	00 
    1c96:	89 34 24             	mov    %esi,(%esp)
    1c99:	e8 2a 33 00 00       	call   4fc8 <write>
    1c9e:	3d 00 02 00 00       	cmp    $0x200,%eax
    1ca3:	0f 85 b2 00 00 00    	jne    1d5b <writetest1+0x11b>
  if(fd < 0){
    printf(stdout, "error: creat big failed!\n");
    exit(0);
  }

  for(i = 0; i < MAXFILE; i++){
    1ca9:	83 c3 01             	add    $0x1,%ebx
    1cac:	81 fb 8c 00 00 00    	cmp    $0x8c,%ebx
    1cb2:	75 cc                	jne    1c80 <writetest1+0x40>
      printf(stdout, "error: write big file failed\n", i);
      exit(0);
    }
  }

  close(fd);
    1cb4:	89 34 24             	mov    %esi,(%esp)
    1cb7:	e8 14 33 00 00       	call   4fd0 <close>

  fd = open("big", O_RDONLY);
    1cbc:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1cc3:	00 
    1cc4:	c7 04 24 98 57 00 00 	movl   $0x5798,(%esp)
    1ccb:	e8 18 33 00 00       	call   4fe8 <open>
  if(fd < 0){
    1cd0:	85 c0                	test   %eax,%eax
    }
  }

  close(fd);

  fd = open("big", O_RDONLY);
    1cd2:	89 c6                	mov    %eax,%esi
  if(fd < 0){
    1cd4:	0f 88 ef 00 00 00    	js     1dc9 <writetest1+0x189>
    printf(stdout, "error: open big failed!\n");
    exit(0);
    1cda:	31 db                	xor    %ebx,%ebx
    1cdc:	eb 1d                	jmp    1cfb <writetest1+0xbb>
    1cde:	66 90                	xchg   %ax,%ax
      if(n == MAXFILE - 1){
        printf(stdout, "read only %d blocks from big", n);
        exit(0);
      }
      break;
    } else if(i != 512){
    1ce0:	3d 00 02 00 00       	cmp    $0x200,%eax
    1ce5:	0f 85 be 00 00 00    	jne    1da9 <writetest1+0x169>
      printf(stdout, "read failed %d\n", i);
      exit(0);
    }
    if(((int*)buf)[0] != n){
    1ceb:	a1 20 94 00 00       	mov    0x9420,%eax
    1cf0:	39 d8                	cmp    %ebx,%eax
    1cf2:	0f 85 88 00 00 00    	jne    1d80 <writetest1+0x140>
      printf(stdout, "read content of block %d is %d\n",
             n, ((int*)buf)[0]);
      exit(0);
    }
    n++;
    1cf8:	83 c3 01             	add    $0x1,%ebx
    exit(0);
  }

  n = 0;
  for(;;){
    i = read(fd, buf, 512);
    1cfb:	c7 44 24 08 00 02 00 	movl   $0x200,0x8(%esp)
    1d02:	00 
    1d03:	c7 44 24 04 20 94 00 	movl   $0x9420,0x4(%esp)
    1d0a:	00 
    1d0b:	89 34 24             	mov    %esi,(%esp)
    1d0e:	e8 ad 32 00 00       	call   4fc0 <read>
    if(i == 0){
    1d13:	85 c0                	test   %eax,%eax
    1d15:	75 c9                	jne    1ce0 <writetest1+0xa0>
      if(n == MAXFILE - 1){
    1d17:	81 fb 8b 00 00 00    	cmp    $0x8b,%ebx
    1d1d:	0f 84 94 00 00 00    	je     1db7 <writetest1+0x177>
             n, ((int*)buf)[0]);
      exit(0);
    }
    n++;
  }
  close(fd);
    1d23:	89 34 24             	mov    %esi,(%esp)
    1d26:	e8 a5 32 00 00       	call   4fd0 <close>
  if(unlink("big") < 0){
    1d2b:	c7 04 24 98 57 00 00 	movl   $0x5798,(%esp)
    1d32:	e8 c1 32 00 00       	call   4ff8 <unlink>
    1d37:	85 c0                	test   %eax,%eax
    1d39:	0f 88 b5 00 00 00    	js     1df4 <writetest1+0x1b4>
    printf(stdout, "unlink big failed\n");
    exit(0);
  }
  printf(stdout, "big files ok\n");
    1d3f:	a1 2c 6c 00 00       	mov    0x6c2c,%eax
    1d44:	c7 44 24 04 bf 57 00 	movl   $0x57bf,0x4(%esp)
    1d4b:	00 
    1d4c:	89 04 24             	mov    %eax,(%esp)
    1d4f:	e8 ac 33 00 00       	call   5100 <printf>
}
    1d54:	83 c4 10             	add    $0x10,%esp
    1d57:	5b                   	pop    %ebx
    1d58:	5e                   	pop    %esi
    1d59:	5d                   	pop    %ebp
    1d5a:	c3                   	ret    
  }

  for(i = 0; i < MAXFILE; i++){
    ((int*)buf)[0] = i;
    if(write(fd, buf, 512) != 512){
      printf(stdout, "error: write big file failed\n", i);
    1d5b:	89 5c 24 08          	mov    %ebx,0x8(%esp)
    1d5f:	c7 44 24 04 48 57 00 	movl   $0x5748,0x4(%esp)
    1d66:	00 
  n = 0;
  for(;;){
    i = read(fd, buf, 512);
    if(i == 0){
      if(n == MAXFILE - 1){
        printf(stdout, "read only %d blocks from big", n);
    1d67:	a1 2c 6c 00 00       	mov    0x6c2c,%eax
    1d6c:	89 04 24             	mov    %eax,(%esp)
    1d6f:	e8 8c 33 00 00       	call   5100 <printf>
        exit(0);
    1d74:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1d7b:	e8 28 32 00 00       	call   4fa8 <exit>
    } else if(i != 512){
      printf(stdout, "read failed %d\n", i);
      exit(0);
    }
    if(((int*)buf)[0] != n){
      printf(stdout, "read content of block %d is %d\n",
    1d80:	89 44 24 0c          	mov    %eax,0xc(%esp)
    1d84:	a1 2c 6c 00 00       	mov    0x6c2c,%eax
    1d89:	89 5c 24 08          	mov    %ebx,0x8(%esp)
    1d8d:	c7 44 24 04 68 65 00 	movl   $0x6568,0x4(%esp)
    1d94:	00 
    1d95:	89 04 24             	mov    %eax,(%esp)
    1d98:	e8 63 33 00 00       	call   5100 <printf>
             n, ((int*)buf)[0]);
      exit(0);
    1d9d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1da4:	e8 ff 31 00 00       	call   4fa8 <exit>
        printf(stdout, "read only %d blocks from big", n);
        exit(0);
      }
      break;
    } else if(i != 512){
      printf(stdout, "read failed %d\n", i);
    1da9:	89 44 24 08          	mov    %eax,0x8(%esp)
    1dad:	c7 44 24 04 9c 57 00 	movl   $0x579c,0x4(%esp)
    1db4:	00 
    1db5:	eb b0                	jmp    1d67 <writetest1+0x127>
  n = 0;
  for(;;){
    i = read(fd, buf, 512);
    if(i == 0){
      if(n == MAXFILE - 1){
        printf(stdout, "read only %d blocks from big", n);
    1db7:	c7 44 24 08 8b 00 00 	movl   $0x8b,0x8(%esp)
    1dbe:	00 
    1dbf:	c7 44 24 04 7f 57 00 	movl   $0x577f,0x4(%esp)
    1dc6:	00 
    1dc7:	eb 9e                	jmp    1d67 <writetest1+0x127>

  close(fd);

  fd = open("big", O_RDONLY);
  if(fd < 0){
    printf(stdout, "error: open big failed!\n");
    1dc9:	c7 44 24 04 66 57 00 	movl   $0x5766,0x4(%esp)
    1dd0:	00 
    1dd1:	a1 2c 6c 00 00       	mov    0x6c2c,%eax
    1dd6:	89 04 24             	mov    %eax,(%esp)
    1dd9:	e8 22 33 00 00       	call   5100 <printf>
    exit(0);
    1dde:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1de5:	e8 be 31 00 00       	call   4fa8 <exit>

  printf(stdout, "big files test\n");

  fd = open("big", O_CREATE|O_RDWR);
  if(fd < 0){
    printf(stdout, "error: creat big failed!\n");
    1dea:	c7 44 24 04 2e 57 00 	movl   $0x572e,0x4(%esp)
    1df1:	00 
    1df2:	eb dd                	jmp    1dd1 <writetest1+0x191>
    }
    n++;
  }
  close(fd);
  if(unlink("big") < 0){
    printf(stdout, "unlink big failed\n");
    1df4:	c7 44 24 04 ac 57 00 	movl   $0x57ac,0x4(%esp)
    1dfb:	00 
    1dfc:	eb d3                	jmp    1dd1 <writetest1+0x191>
    1dfe:	66 90                	xchg   %ax,%ax

00001e00 <writetest>:
  printf(stdout, "open test ok\n");
}

void
writetest(void)
{
    1e00:	55                   	push   %ebp
    1e01:	89 e5                	mov    %esp,%ebp
    1e03:	56                   	push   %esi
    1e04:	53                   	push   %ebx
    1e05:	83 ec 10             	sub    $0x10,%esp
  int fd;
  int i;

  printf(stdout, "small file test\n");
    1e08:	a1 2c 6c 00 00       	mov    0x6c2c,%eax
    1e0d:	c7 44 24 04 cd 57 00 	movl   $0x57cd,0x4(%esp)
    1e14:	00 
    1e15:	89 04 24             	mov    %eax,(%esp)
    1e18:	e8 e3 32 00 00       	call   5100 <printf>
  fd = open("small", O_CREATE|O_RDWR);
    1e1d:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
    1e24:	00 
    1e25:	c7 04 24 de 57 00 00 	movl   $0x57de,(%esp)
    1e2c:	e8 b7 31 00 00       	call   4fe8 <open>
  if(fd >= 0){
    1e31:	85 c0                	test   %eax,%eax
{
  int fd;
  int i;

  printf(stdout, "small file test\n");
  fd = open("small", O_CREATE|O_RDWR);
    1e33:	89 c6                	mov    %eax,%esi
  if(fd >= 0){
    1e35:	0f 88 8b 01 00 00    	js     1fc6 <writetest+0x1c6>
    printf(stdout, "creat small succeeded; ok\n");
    1e3b:	a1 2c 6c 00 00       	mov    0x6c2c,%eax
    1e40:	31 db                	xor    %ebx,%ebx
    1e42:	c7 44 24 04 e4 57 00 	movl   $0x57e4,0x4(%esp)
    1e49:	00 
    1e4a:	89 04 24             	mov    %eax,(%esp)
    1e4d:	e8 ae 32 00 00       	call   5100 <printf>
    1e52:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  } else {
    printf(stdout, "error: creat small failed!\n");
    exit(0);
  }
  for(i = 0; i < 100; i++){
    if(write(fd, "aaaaaaaaaa", 10) != 10){
    1e58:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
    1e5f:	00 
    1e60:	c7 44 24 04 1b 58 00 	movl   $0x581b,0x4(%esp)
    1e67:	00 
    1e68:	89 34 24             	mov    %esi,(%esp)
    1e6b:	e8 58 31 00 00       	call   4fc8 <write>
    1e70:	83 f8 0a             	cmp    $0xa,%eax
    1e73:	0f 85 e5 00 00 00    	jne    1f5e <writetest+0x15e>
      printf(stdout, "error: write aa %d new file failed\n", i);
      exit(0);
    }
    if(write(fd, "bbbbbbbbbb", 10) != 10){
    1e79:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
    1e80:	00 
    1e81:	c7 44 24 04 26 58 00 	movl   $0x5826,0x4(%esp)
    1e88:	00 
    1e89:	89 34 24             	mov    %esi,(%esp)
    1e8c:	e8 37 31 00 00       	call   4fc8 <write>
    1e91:	83 f8 0a             	cmp    $0xa,%eax
    1e94:	0f 85 e9 00 00 00    	jne    1f83 <writetest+0x183>
    printf(stdout, "creat small succeeded; ok\n");
  } else {
    printf(stdout, "error: creat small failed!\n");
    exit(0);
  }
  for(i = 0; i < 100; i++){
    1e9a:	83 c3 01             	add    $0x1,%ebx
    1e9d:	83 fb 64             	cmp    $0x64,%ebx
    1ea0:	75 b6                	jne    1e58 <writetest+0x58>
    if(write(fd, "bbbbbbbbbb", 10) != 10){
      printf(stdout, "error: write bb %d new file failed\n", i);
      exit(0);
    }
  }
  printf(stdout, "writes ok\n");
    1ea2:	a1 2c 6c 00 00       	mov    0x6c2c,%eax
    1ea7:	c7 44 24 04 31 58 00 	movl   $0x5831,0x4(%esp)
    1eae:	00 
    1eaf:	89 04 24             	mov    %eax,(%esp)
    1eb2:	e8 49 32 00 00       	call   5100 <printf>
  close(fd);
    1eb7:	89 34 24             	mov    %esi,(%esp)
    1eba:	e8 11 31 00 00       	call   4fd0 <close>
  fd = open("small", O_RDONLY);
    1ebf:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1ec6:	00 
    1ec7:	c7 04 24 de 57 00 00 	movl   $0x57de,(%esp)
    1ece:	e8 15 31 00 00       	call   4fe8 <open>
  if(fd >= 0){
    1ed3:	85 c0                	test   %eax,%eax
      exit(0);
    }
  }
  printf(stdout, "writes ok\n");
  close(fd);
  fd = open("small", O_RDONLY);
    1ed5:	89 c3                	mov    %eax,%ebx
  if(fd >= 0){
    1ed7:	0f 88 b4 00 00 00    	js     1f91 <writetest+0x191>
    printf(stdout, "open small succeeded ok\n");
    1edd:	a1 2c 6c 00 00       	mov    0x6c2c,%eax
    1ee2:	c7 44 24 04 3c 58 00 	movl   $0x583c,0x4(%esp)
    1ee9:	00 
    1eea:	89 04 24             	mov    %eax,(%esp)
    1eed:	e8 0e 32 00 00       	call   5100 <printf>
  } else {
    printf(stdout, "error: open small failed!\n");
    exit(0);
  }
  i = read(fd, buf, 2000);
    1ef2:	c7 44 24 08 d0 07 00 	movl   $0x7d0,0x8(%esp)
    1ef9:	00 
    1efa:	c7 44 24 04 20 94 00 	movl   $0x9420,0x4(%esp)
    1f01:	00 
    1f02:	89 1c 24             	mov    %ebx,(%esp)
    1f05:	e8 b6 30 00 00       	call   4fc0 <read>
  if(i == 2000){
    1f0a:	3d d0 07 00 00       	cmp    $0x7d0,%eax
    1f0f:	0f 85 9d 00 00 00    	jne    1fb2 <writetest+0x1b2>
    printf(stdout, "read succeeded ok\n");
    1f15:	a1 2c 6c 00 00       	mov    0x6c2c,%eax
    1f1a:	c7 44 24 04 70 58 00 	movl   $0x5870,0x4(%esp)
    1f21:	00 
    1f22:	89 04 24             	mov    %eax,(%esp)
    1f25:	e8 d6 31 00 00       	call   5100 <printf>
  } else {
    printf(stdout, "read failed\n");
    exit(0);
  }
  close(fd);
    1f2a:	89 1c 24             	mov    %ebx,(%esp)
    1f2d:	e8 9e 30 00 00       	call   4fd0 <close>

  if(unlink("small") < 0){
    1f32:	c7 04 24 de 57 00 00 	movl   $0x57de,(%esp)
    1f39:	e8 ba 30 00 00       	call   4ff8 <unlink>
    1f3e:	85 c0                	test   %eax,%eax
    1f40:	78 7a                	js     1fbc <writetest+0x1bc>
    printf(stdout, "unlink small failed\n");
    exit(0);
  }
  printf(stdout, "small file test ok\n");
    1f42:	a1 2c 6c 00 00       	mov    0x6c2c,%eax
    1f47:	c7 44 24 04 98 58 00 	movl   $0x5898,0x4(%esp)
    1f4e:	00 
    1f4f:	89 04 24             	mov    %eax,(%esp)
    1f52:	e8 a9 31 00 00       	call   5100 <printf>
}
    1f57:	83 c4 10             	add    $0x10,%esp
    1f5a:	5b                   	pop    %ebx
    1f5b:	5e                   	pop    %esi
    1f5c:	5d                   	pop    %ebp
    1f5d:	c3                   	ret    
    printf(stdout, "error: creat small failed!\n");
    exit(0);
  }
  for(i = 0; i < 100; i++){
    if(write(fd, "aaaaaaaaaa", 10) != 10){
      printf(stdout, "error: write aa %d new file failed\n", i);
    1f5e:	89 5c 24 08          	mov    %ebx,0x8(%esp)
    1f62:	c7 44 24 04 88 65 00 	movl   $0x6588,0x4(%esp)
    1f69:	00 
      exit(0);
    }
    if(write(fd, "bbbbbbbbbb", 10) != 10){
      printf(stdout, "error: write bb %d new file failed\n", i);
    1f6a:	a1 2c 6c 00 00       	mov    0x6c2c,%eax
    1f6f:	89 04 24             	mov    %eax,(%esp)
    1f72:	e8 89 31 00 00       	call   5100 <printf>
      exit(0);
    1f77:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1f7e:	e8 25 30 00 00       	call   4fa8 <exit>
    if(write(fd, "aaaaaaaaaa", 10) != 10){
      printf(stdout, "error: write aa %d new file failed\n", i);
      exit(0);
    }
    if(write(fd, "bbbbbbbbbb", 10) != 10){
      printf(stdout, "error: write bb %d new file failed\n", i);
    1f83:	89 5c 24 08          	mov    %ebx,0x8(%esp)
    1f87:	c7 44 24 04 ac 65 00 	movl   $0x65ac,0x4(%esp)
    1f8e:	00 
    1f8f:	eb d9                	jmp    1f6a <writetest+0x16a>
  close(fd);
  fd = open("small", O_RDONLY);
  if(fd >= 0){
    printf(stdout, "open small succeeded ok\n");
  } else {
    printf(stdout, "error: open small failed!\n");
    1f91:	c7 44 24 04 55 58 00 	movl   $0x5855,0x4(%esp)
    1f98:	00 
    1f99:	a1 2c 6c 00 00       	mov    0x6c2c,%eax
    1f9e:	89 04 24             	mov    %eax,(%esp)
    1fa1:	e8 5a 31 00 00       	call   5100 <printf>
    exit(0);
    1fa6:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1fad:	e8 f6 2f 00 00       	call   4fa8 <exit>
  }
  i = read(fd, buf, 2000);
  if(i == 2000){
    printf(stdout, "read succeeded ok\n");
  } else {
    printf(stdout, "read failed\n");
    1fb2:	c7 44 24 04 4c 56 00 	movl   $0x564c,0x4(%esp)
    1fb9:	00 
    1fba:	eb dd                	jmp    1f99 <writetest+0x199>
    exit(0);
  }
  close(fd);

  if(unlink("small") < 0){
    printf(stdout, "unlink small failed\n");
    1fbc:	c7 44 24 04 83 58 00 	movl   $0x5883,0x4(%esp)
    1fc3:	00 
    1fc4:	eb d3                	jmp    1f99 <writetest+0x199>
  printf(stdout, "small file test\n");
  fd = open("small", O_CREATE|O_RDWR);
  if(fd >= 0){
    printf(stdout, "creat small succeeded; ok\n");
  } else {
    printf(stdout, "error: creat small failed!\n");
    1fc6:	c7 44 24 04 ff 57 00 	movl   $0x57ff,0x4(%esp)
    1fcd:	00 
    1fce:	eb c9                	jmp    1f99 <writetest+0x199>

00001fd0 <bigargtest>:
// does exec return an error if the arguments
// are larger than a page? or does it write
// below the stack and wreck the instructions/data?
void
bigargtest(void)
{
    1fd0:	55                   	push   %ebp
    1fd1:	89 e5                	mov    %esp,%ebp
    1fd3:	83 ec 18             	sub    $0x18,%esp
  int pid, fd;

  unlink("bigarg-ok");
    1fd6:	c7 04 24 ac 58 00 00 	movl   $0x58ac,(%esp)
    1fdd:	e8 16 30 00 00       	call   4ff8 <unlink>
  pid = fork();
    1fe2:	e8 b9 2f 00 00       	call   4fa0 <fork>
  if(pid == 0){
    1fe7:	83 f8 00             	cmp    $0x0,%eax
    1fea:	74 4c                	je     2038 <bigargtest+0x68>
    1fec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    exec("echo", args);
    printf(stdout, "bigarg test ok\n");
    fd = open("bigarg-ok", O_CREATE);
    close(fd);
    exit(0);
  } else if(pid < 0){
    1ff0:	0f 8c e6 00 00 00    	jl     20dc <bigargtest+0x10c>
    printf(stdout, "bigargtest: fork failed\n");
    exit(0);
  }
  wait(&exit_status);
    1ff6:	c7 04 24 e0 6c 00 00 	movl   $0x6ce0,(%esp)
    1ffd:	e8 ae 2f 00 00       	call   4fb0 <wait>
  fd = open("bigarg-ok", 0);
    2002:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    2009:	00 
    200a:	c7 04 24 ac 58 00 00 	movl   $0x58ac,(%esp)
    2011:	e8 d2 2f 00 00       	call   4fe8 <open>
  if(fd < 0){
    2016:	85 c0                	test   %eax,%eax
    2018:	0f 88 9d 00 00 00    	js     20bb <bigargtest+0xeb>
    printf(stdout, "bigarg test failed!\n");
    exit(0);
  }
  close(fd);
    201e:	89 04 24             	mov    %eax,(%esp)
    2021:	e8 aa 2f 00 00       	call   4fd0 <close>
  unlink("bigarg-ok");
    2026:	c7 04 24 ac 58 00 00 	movl   $0x58ac,(%esp)
    202d:	e8 c6 2f 00 00       	call   4ff8 <unlink>
}
    2032:	c9                   	leave  
    2033:	c3                   	ret    
    2034:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  pid = fork();
  if(pid == 0){
    static char *args[MAXARG];
    int i;
    for(i = 0; i < MAXARG-1; i++)
      args[i] = "bigargs test: failed\n                                                                                                                                                                                                       ";
    2038:	c7 04 85 40 6c 00 00 	movl   $0x65d0,0x6c40(,%eax,4)
    203f:	d0 65 00 00 
  unlink("bigarg-ok");
  pid = fork();
  if(pid == 0){
    static char *args[MAXARG];
    int i;
    for(i = 0; i < MAXARG-1; i++)
    2043:	83 c0 01             	add    $0x1,%eax
    2046:	83 f8 1f             	cmp    $0x1f,%eax
    2049:	75 ed                	jne    2038 <bigargtest+0x68>
      args[i] = "bigargs test: failed\n                                                                                                                                                                                                       ";
    args[MAXARG-1] = 0;
    printf(stdout, "bigarg test\n");
    204b:	a1 2c 6c 00 00       	mov    0x6c2c,%eax
  if(pid == 0){
    static char *args[MAXARG];
    int i;
    for(i = 0; i < MAXARG-1; i++)
      args[i] = "bigargs test: failed\n                                                                                                                                                                                                       ";
    args[MAXARG-1] = 0;
    2050:	c7 05 bc 6c 00 00 00 	movl   $0x0,0x6cbc
    2057:	00 00 00 
    printf(stdout, "bigarg test\n");
    205a:	c7 44 24 04 b6 58 00 	movl   $0x58b6,0x4(%esp)
    2061:	00 
    2062:	89 04 24             	mov    %eax,(%esp)
    2065:	e8 96 30 00 00       	call   5100 <printf>
    exec("echo", args);
    206a:	c7 44 24 04 40 6c 00 	movl   $0x6c40,0x4(%esp)
    2071:	00 
    2072:	c7 04 24 9b 54 00 00 	movl   $0x549b,(%esp)
    2079:	e8 62 2f 00 00       	call   4fe0 <exec>
    printf(stdout, "bigarg test ok\n");
    207e:	a1 2c 6c 00 00       	mov    0x6c2c,%eax
    2083:	c7 44 24 04 c3 58 00 	movl   $0x58c3,0x4(%esp)
    208a:	00 
    208b:	89 04 24             	mov    %eax,(%esp)
    208e:	e8 6d 30 00 00       	call   5100 <printf>
    fd = open("bigarg-ok", O_CREATE);
    2093:	c7 44 24 04 00 02 00 	movl   $0x200,0x4(%esp)
    209a:	00 
    209b:	c7 04 24 ac 58 00 00 	movl   $0x58ac,(%esp)
    20a2:	e8 41 2f 00 00       	call   4fe8 <open>
    close(fd);
    20a7:	89 04 24             	mov    %eax,(%esp)
    20aa:	e8 21 2f 00 00       	call   4fd0 <close>
    exit(0);
    20af:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    20b6:	e8 ed 2e 00 00       	call   4fa8 <exit>
    exit(0);
  }
  wait(&exit_status);
  fd = open("bigarg-ok", 0);
  if(fd < 0){
    printf(stdout, "bigarg test failed!\n");
    20bb:	c7 44 24 04 ec 58 00 	movl   $0x58ec,0x4(%esp)
    20c2:	00 
    20c3:	a1 2c 6c 00 00       	mov    0x6c2c,%eax
    20c8:	89 04 24             	mov    %eax,(%esp)
    20cb:	e8 30 30 00 00       	call   5100 <printf>
    exit(0);
    20d0:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    20d7:	e8 cc 2e 00 00       	call   4fa8 <exit>
    printf(stdout, "bigarg test ok\n");
    fd = open("bigarg-ok", O_CREATE);
    close(fd);
    exit(0);
  } else if(pid < 0){
    printf(stdout, "bigargtest: fork failed\n");
    20dc:	c7 44 24 04 d3 58 00 	movl   $0x58d3,0x4(%esp)
    20e3:	00 
    20e4:	eb dd                	jmp    20c3 <bigargtest+0xf3>
    20e6:	8d 76 00             	lea    0x0(%esi),%esi
    20e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000020f0 <exectest>:
  printf(stdout, "mkdir test ok\n");
}

void
exectest(void)
{
    20f0:	55                   	push   %ebp
    20f1:	89 e5                	mov    %esp,%ebp
    20f3:	83 ec 18             	sub    $0x18,%esp
  printf(stdout, "exec test\n");
    20f6:	a1 2c 6c 00 00       	mov    0x6c2c,%eax
    20fb:	c7 44 24 04 01 59 00 	movl   $0x5901,0x4(%esp)
    2102:	00 
    2103:	89 04 24             	mov    %eax,(%esp)
    2106:	e8 f5 2f 00 00       	call   5100 <printf>
  if(exec("echo", echoargv) < 0){
    210b:	c7 44 24 04 18 6c 00 	movl   $0x6c18,0x4(%esp)
    2112:	00 
    2113:	c7 04 24 9b 54 00 00 	movl   $0x549b,(%esp)
    211a:	e8 c1 2e 00 00       	call   4fe0 <exec>
    211f:	85 c0                	test   %eax,%eax
    2121:	78 02                	js     2125 <exectest+0x35>
    printf(stdout, "exec echo failed\n");
    exit(0);
  }
}
    2123:	c9                   	leave  
    2124:	c3                   	ret    
void
exectest(void)
{
  printf(stdout, "exec test\n");
  if(exec("echo", echoargv) < 0){
    printf(stdout, "exec echo failed\n");
    2125:	a1 2c 6c 00 00       	mov    0x6c2c,%eax
    212a:	c7 44 24 04 0c 59 00 	movl   $0x590c,0x4(%esp)
    2131:	00 
    2132:	89 04 24             	mov    %eax,(%esp)
    2135:	e8 c6 2f 00 00       	call   5100 <printf>
    exit(0);
    213a:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2141:	e8 62 2e 00 00       	call   4fa8 <exit>
    2146:	8d 76 00             	lea    0x0(%esi),%esi
    2149:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00002150 <validatetest>:
      "ebx");
}

void
validatetest(void)
{
    2150:	55                   	push   %ebp
    2151:	89 e5                	mov    %esp,%ebp
    2153:	56                   	push   %esi
    2154:	53                   	push   %ebx
  int hi, pid;
  uint p;

  printf(stdout, "validate test\n");
    2155:	31 db                	xor    %ebx,%ebx
      "ebx");
}

void
validatetest(void)
{
    2157:	83 ec 10             	sub    $0x10,%esp
  int hi, pid;
  uint p;

  printf(stdout, "validate test\n");
    215a:	a1 2c 6c 00 00       	mov    0x6c2c,%eax
    215f:	c7 44 24 04 1e 59 00 	movl   $0x591e,0x4(%esp)
    2166:	00 
    2167:	89 04 24             	mov    %eax,(%esp)
    216a:	e8 91 2f 00 00       	call   5100 <printf>
    216f:	90                   	nop
  hi = 1100*1024;

  for(p = 0; p <= (uint)hi; p += 4096){
    if((pid = fork()) == 0){
    2170:	e8 2b 2e 00 00       	call   4fa0 <fork>
    2175:	85 c0                	test   %eax,%eax
    2177:	89 c6                	mov    %eax,%esi
    2179:	0f 84 80 00 00 00    	je     21ff <validatetest+0xaf>
      // try to crash the kernel by passing in a badly placed integer
      validateint((int*)p);
      exit(0);
    }
    sleep(0);
    217f:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2186:	e8 ad 2e 00 00       	call   5038 <sleep>
    sleep(0);
    218b:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2192:	e8 a1 2e 00 00       	call   5038 <sleep>
    kill(pid);
    2197:	89 34 24             	mov    %esi,(%esp)
    219a:	e8 39 2e 00 00       	call   4fd8 <kill>
    wait(&exit_status);
    219f:	c7 04 24 e0 6c 00 00 	movl   $0x6ce0,(%esp)
    21a6:	e8 05 2e 00 00       	call   4fb0 <wait>

    // try to crash the kernel by passing in a bad string pointer
    if(link("nosuchfile", (char*)p) != -1){
    21ab:	89 5c 24 04          	mov    %ebx,0x4(%esp)
    21af:	c7 04 24 2d 59 00 00 	movl   $0x592d,(%esp)
    21b6:	e8 4d 2e 00 00       	call   5008 <link>
    21bb:	83 f8 ff             	cmp    $0xffffffff,%eax
    21be:	75 2a                	jne    21ea <validatetest+0x9a>
  uint p;

  printf(stdout, "validate test\n");
  hi = 1100*1024;

  for(p = 0; p <= (uint)hi; p += 4096){
    21c0:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    21c6:	81 fb 00 40 11 00    	cmp    $0x114000,%ebx
    21cc:	75 a2                	jne    2170 <validatetest+0x20>
      printf(stdout, "link should not succeed\n");
      exit(0);
    }
  }

  printf(stdout, "validate ok\n");
    21ce:	a1 2c 6c 00 00       	mov    0x6c2c,%eax
    21d3:	c7 44 24 04 51 59 00 	movl   $0x5951,0x4(%esp)
    21da:	00 
    21db:	89 04 24             	mov    %eax,(%esp)
    21de:	e8 1d 2f 00 00       	call   5100 <printf>
}
    21e3:	83 c4 10             	add    $0x10,%esp
    21e6:	5b                   	pop    %ebx
    21e7:	5e                   	pop    %esi
    21e8:	5d                   	pop    %ebp
    21e9:	c3                   	ret    
    kill(pid);
    wait(&exit_status);

    // try to crash the kernel by passing in a bad string pointer
    if(link("nosuchfile", (char*)p) != -1){
      printf(stdout, "link should not succeed\n");
    21ea:	a1 2c 6c 00 00       	mov    0x6c2c,%eax
    21ef:	c7 44 24 04 38 59 00 	movl   $0x5938,0x4(%esp)
    21f6:	00 
    21f7:	89 04 24             	mov    %eax,(%esp)
    21fa:	e8 01 2f 00 00       	call   5100 <printf>
      exit(0);
    21ff:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2206:	e8 9d 2d 00 00       	call   4fa8 <exit>
    220b:	90                   	nop
    220c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00002210 <bigdir>:
}

// directory that uses indirect blocks
void
bigdir(void)
{
    2210:	55                   	push   %ebp
    2211:	89 e5                	mov    %esp,%ebp
    2213:	56                   	push   %esi
    2214:	53                   	push   %ebx
    2215:	83 ec 20             	sub    $0x20,%esp
  int i, fd;
  char name[10];

  printf(1, "bigdir test\n");
    2218:	c7 44 24 04 5e 59 00 	movl   $0x595e,0x4(%esp)
    221f:	00 
    2220:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2227:	e8 d4 2e 00 00       	call   5100 <printf>
  unlink("bd");
    222c:	c7 04 24 6b 59 00 00 	movl   $0x596b,(%esp)
    2233:	e8 c0 2d 00 00       	call   4ff8 <unlink>

  fd = open("bd", O_CREATE);
    2238:	c7 44 24 04 00 02 00 	movl   $0x200,0x4(%esp)
    223f:	00 
    2240:	c7 04 24 6b 59 00 00 	movl   $0x596b,(%esp)
    2247:	e8 9c 2d 00 00       	call   4fe8 <open>
  if(fd < 0){
    224c:	85 c0                	test   %eax,%eax
    224e:	0f 88 f4 00 00 00    	js     2348 <bigdir+0x138>
    printf(1, "bigdir create failed\n");
    exit(0);
  }
  close(fd);
    2254:	89 04 24             	mov    %eax,(%esp)
    2257:	31 db                	xor    %ebx,%ebx
    2259:	e8 72 2d 00 00       	call   4fd0 <close>
    225e:	8d 75 ee             	lea    -0x12(%ebp),%esi
    2261:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

  for(i = 0; i < 500; i++){
    name[0] = 'x';
    name[1] = '0' + (i / 64);
    2268:	89 d8                	mov    %ebx,%eax
    226a:	c1 f8 06             	sar    $0x6,%eax
    226d:	83 c0 30             	add    $0x30,%eax
    2270:	88 45 ef             	mov    %al,-0x11(%ebp)
    name[2] = '0' + (i % 64);
    2273:	89 d8                	mov    %ebx,%eax
    2275:	83 e0 3f             	and    $0x3f,%eax
    2278:	83 c0 30             	add    $0x30,%eax
    exit(0);
  }
  close(fd);

  for(i = 0; i < 500; i++){
    name[0] = 'x';
    227b:	c6 45 ee 78          	movb   $0x78,-0x12(%ebp)
    name[1] = '0' + (i / 64);
    name[2] = '0' + (i % 64);
    227f:	88 45 f0             	mov    %al,-0x10(%ebp)
    name[3] = '\0';
    2282:	c6 45 f1 00          	movb   $0x0,-0xf(%ebp)
    if(link("bd", name) != 0){
    2286:	89 74 24 04          	mov    %esi,0x4(%esp)
    228a:	c7 04 24 6b 59 00 00 	movl   $0x596b,(%esp)
    2291:	e8 72 2d 00 00       	call   5008 <link>
    2296:	85 c0                	test   %eax,%eax
    2298:	75 6e                	jne    2308 <bigdir+0xf8>
    printf(1, "bigdir create failed\n");
    exit(0);
  }
  close(fd);

  for(i = 0; i < 500; i++){
    229a:	83 c3 01             	add    $0x1,%ebx
    229d:	81 fb f4 01 00 00    	cmp    $0x1f4,%ebx
    22a3:	75 c3                	jne    2268 <bigdir+0x58>
      printf(1, "bigdir link failed\n");
      exit(0);
    }
  }

  unlink("bd");
    22a5:	c7 04 24 6b 59 00 00 	movl   $0x596b,(%esp)
    22ac:	66 31 db             	xor    %bx,%bx
    22af:	e8 44 2d 00 00       	call   4ff8 <unlink>
    22b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(i = 0; i < 500; i++){
    name[0] = 'x';
    name[1] = '0' + (i / 64);
    22b8:	89 d8                	mov    %ebx,%eax
    22ba:	c1 f8 06             	sar    $0x6,%eax
    22bd:	83 c0 30             	add    $0x30,%eax
    22c0:	88 45 ef             	mov    %al,-0x11(%ebp)
    name[2] = '0' + (i % 64);
    22c3:	89 d8                	mov    %ebx,%eax
    22c5:	83 e0 3f             	and    $0x3f,%eax
    22c8:	83 c0 30             	add    $0x30,%eax
    }
  }

  unlink("bd");
  for(i = 0; i < 500; i++){
    name[0] = 'x';
    22cb:	c6 45 ee 78          	movb   $0x78,-0x12(%ebp)
    name[1] = '0' + (i / 64);
    name[2] = '0' + (i % 64);
    22cf:	88 45 f0             	mov    %al,-0x10(%ebp)
    name[3] = '\0';
    22d2:	c6 45 f1 00          	movb   $0x0,-0xf(%ebp)
    if(unlink(name) != 0){
    22d6:	89 34 24             	mov    %esi,(%esp)
    22d9:	e8 1a 2d 00 00       	call   4ff8 <unlink>
    22de:	85 c0                	test   %eax,%eax
    22e0:	75 46                	jne    2328 <bigdir+0x118>
      exit(0);
    }
  }

  unlink("bd");
  for(i = 0; i < 500; i++){
    22e2:	83 c3 01             	add    $0x1,%ebx
    22e5:	81 fb f4 01 00 00    	cmp    $0x1f4,%ebx
    22eb:	75 cb                	jne    22b8 <bigdir+0xa8>
      printf(1, "bigdir unlink failed");
      exit(0);
    }
  }

  printf(1, "bigdir ok\n");
    22ed:	c7 44 24 04 ad 59 00 	movl   $0x59ad,0x4(%esp)
    22f4:	00 
    22f5:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    22fc:	e8 ff 2d 00 00       	call   5100 <printf>
}
    2301:	83 c4 20             	add    $0x20,%esp
    2304:	5b                   	pop    %ebx
    2305:	5e                   	pop    %esi
    2306:	5d                   	pop    %ebp
    2307:	c3                   	ret    
    name[0] = 'x';
    name[1] = '0' + (i / 64);
    name[2] = '0' + (i % 64);
    name[3] = '\0';
    if(link("bd", name) != 0){
      printf(1, "bigdir link failed\n");
    2308:	c7 44 24 04 84 59 00 	movl   $0x5984,0x4(%esp)
    230f:	00 
    2310:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2317:	e8 e4 2d 00 00       	call   5100 <printf>
      exit(0);
    231c:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2323:	e8 80 2c 00 00       	call   4fa8 <exit>
    name[0] = 'x';
    name[1] = '0' + (i / 64);
    name[2] = '0' + (i % 64);
    name[3] = '\0';
    if(unlink(name) != 0){
      printf(1, "bigdir unlink failed");
    2328:	c7 44 24 04 98 59 00 	movl   $0x5998,0x4(%esp)
    232f:	00 
    2330:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2337:	e8 c4 2d 00 00       	call   5100 <printf>
      exit(0);
    233c:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2343:	e8 60 2c 00 00       	call   4fa8 <exit>
  printf(1, "bigdir test\n");
  unlink("bd");

  fd = open("bd", O_CREATE);
  if(fd < 0){
    printf(1, "bigdir create failed\n");
    2348:	c7 44 24 04 6e 59 00 	movl   $0x596e,0x4(%esp)
    234f:	00 
    2350:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2357:	e8 a4 2d 00 00       	call   5100 <printf>
    exit(0);
    235c:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2363:	e8 40 2c 00 00       	call   4fa8 <exit>
    2368:	90                   	nop
    2369:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00002370 <linkunlink>:

// another concurrent link/unlink/create test,
// to look for deadlocks.
void
linkunlink()
{
    2370:	55                   	push   %ebp
    2371:	89 e5                	mov    %esp,%ebp
    2373:	57                   	push   %edi
    2374:	56                   	push   %esi
    2375:	53                   	push   %ebx
    2376:	83 ec 2c             	sub    $0x2c,%esp
  int pid, i;

  printf(1, "linkunlink test\n");
    2379:	c7 44 24 04 b8 59 00 	movl   $0x59b8,0x4(%esp)
    2380:	00 
    2381:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2388:	e8 73 2d 00 00       	call   5100 <printf>

  unlink("x");
    238d:	c7 04 24 95 60 00 00 	movl   $0x6095,(%esp)
    2394:	e8 5f 2c 00 00       	call   4ff8 <unlink>
  pid = fork();
    2399:	e8 02 2c 00 00       	call   4fa0 <fork>
  if(pid < 0){
    239e:	85 c0                	test   %eax,%eax
  int pid, i;

  printf(1, "linkunlink test\n");

  unlink("x");
  pid = fork();
    23a0:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(pid < 0){
    23a3:	0f 88 c0 00 00 00    	js     2469 <linkunlink+0xf9>
    printf(1, "fork failed\n");
    exit(0);
  }

  unsigned int x = (pid ? 1 : 97);
    23a9:	83 7d e4 01          	cmpl   $0x1,-0x1c(%ebp)
  for(i = 0; i < 100; i++){
    x = x * 1103515245 + 12345;
    if((x % 3) == 0){
    23ad:	bf ab aa aa aa       	mov    $0xaaaaaaab,%edi
  if(pid < 0){
    printf(1, "fork failed\n");
    exit(0);
  }

  unsigned int x = (pid ? 1 : 97);
    23b2:	19 db                	sbb    %ebx,%ebx
    23b4:	31 f6                	xor    %esi,%esi
    23b6:	83 e3 60             	and    $0x60,%ebx
    23b9:	83 c3 01             	add    $0x1,%ebx
    23bc:	eb 1f                	jmp    23dd <linkunlink+0x6d>
    23be:	66 90                	xchg   %ax,%ax
  for(i = 0; i < 100; i++){
    x = x * 1103515245 + 12345;
    if((x % 3) == 0){
      close(open("x", O_RDWR | O_CREATE));
    } else if((x % 3) == 1){
    23c0:	83 f8 01             	cmp    $0x1,%eax
    23c3:	0f 84 87 00 00 00    	je     2450 <linkunlink+0xe0>
      link("cat", "x");
    } else {
      unlink("x");
    23c9:	c7 04 24 95 60 00 00 	movl   $0x6095,(%esp)
    23d0:	e8 23 2c 00 00       	call   4ff8 <unlink>
    printf(1, "fork failed\n");
    exit(0);
  }

  unsigned int x = (pid ? 1 : 97);
  for(i = 0; i < 100; i++){
    23d5:	83 c6 01             	add    $0x1,%esi
    23d8:	83 fe 64             	cmp    $0x64,%esi
    23db:	74 3f                	je     241c <linkunlink+0xac>
    x = x * 1103515245 + 12345;
    23dd:	69 db 6d 4e c6 41    	imul   $0x41c64e6d,%ebx,%ebx
    23e3:	81 c3 39 30 00 00    	add    $0x3039,%ebx
    if((x % 3) == 0){
    23e9:	89 d8                	mov    %ebx,%eax
    23eb:	f7 e7                	mul    %edi
    23ed:	89 d8                	mov    %ebx,%eax
    23ef:	d1 ea                	shr    %edx
    23f1:	8d 14 52             	lea    (%edx,%edx,2),%edx
    23f4:	29 d0                	sub    %edx,%eax
    23f6:	75 c8                	jne    23c0 <linkunlink+0x50>
      close(open("x", O_RDWR | O_CREATE));
    23f8:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
    23ff:	00 
    printf(1, "fork failed\n");
    exit(0);
  }

  unsigned int x = (pid ? 1 : 97);
  for(i = 0; i < 100; i++){
    2400:	83 c6 01             	add    $0x1,%esi
    x = x * 1103515245 + 12345;
    if((x % 3) == 0){
      close(open("x", O_RDWR | O_CREATE));
    2403:	c7 04 24 95 60 00 00 	movl   $0x6095,(%esp)
    240a:	e8 d9 2b 00 00       	call   4fe8 <open>
    240f:	89 04 24             	mov    %eax,(%esp)
    2412:	e8 b9 2b 00 00       	call   4fd0 <close>
    printf(1, "fork failed\n");
    exit(0);
  }

  unsigned int x = (pid ? 1 : 97);
  for(i = 0; i < 100; i++){
    2417:	83 fe 64             	cmp    $0x64,%esi
    241a:	75 c1                	jne    23dd <linkunlink+0x6d>
    } else {
      unlink("x");
    }
  }

  if(pid)
    241c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    241f:	85 c0                	test   %eax,%eax
    2421:	74 66                	je     2489 <linkunlink+0x119>
    wait(&exit_status);
    2423:	c7 04 24 e0 6c 00 00 	movl   $0x6ce0,(%esp)
    242a:	e8 81 2b 00 00       	call   4fb0 <wait>
  else
    exit(0);

  printf(1, "linkunlink ok\n");
    242f:	c7 44 24 04 cd 59 00 	movl   $0x59cd,0x4(%esp)
    2436:	00 
    2437:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    243e:	e8 bd 2c 00 00       	call   5100 <printf>
}
    2443:	83 c4 2c             	add    $0x2c,%esp
    2446:	5b                   	pop    %ebx
    2447:	5e                   	pop    %esi
    2448:	5f                   	pop    %edi
    2449:	5d                   	pop    %ebp
    244a:	c3                   	ret    
    244b:	90                   	nop
    244c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(i = 0; i < 100; i++){
    x = x * 1103515245 + 12345;
    if((x % 3) == 0){
      close(open("x", O_RDWR | O_CREATE));
    } else if((x % 3) == 1){
      link("cat", "x");
    2450:	c7 44 24 04 95 60 00 	movl   $0x6095,0x4(%esp)
    2457:	00 
    2458:	c7 04 24 c9 59 00 00 	movl   $0x59c9,(%esp)
    245f:	e8 a4 2b 00 00       	call   5008 <link>
    2464:	e9 6c ff ff ff       	jmp    23d5 <linkunlink+0x65>
  printf(1, "linkunlink test\n");

  unlink("x");
  pid = fork();
  if(pid < 0){
    printf(1, "fork failed\n");
    2469:	c7 44 24 04 df 58 00 	movl   $0x58df,0x4(%esp)
    2470:	00 
    2471:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2478:	e8 83 2c 00 00       	call   5100 <printf>
    exit(0);
    247d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2484:	e8 1f 2b 00 00       	call   4fa8 <exit>
  }

  if(pid)
    wait(&exit_status);
  else
    exit(0);
    2489:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2490:	e8 13 2b 00 00       	call   4fa8 <exit>
    2495:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    2499:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000024a0 <linktest>:
  printf(1, "unlinkread ok\n");
}

void
linktest(void)
{
    24a0:	55                   	push   %ebp
    24a1:	89 e5                	mov    %esp,%ebp
    24a3:	53                   	push   %ebx
    24a4:	83 ec 14             	sub    $0x14,%esp
  int fd;

  printf(1, "linktest\n");
    24a7:	c7 44 24 04 dc 59 00 	movl   $0x59dc,0x4(%esp)
    24ae:	00 
    24af:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    24b6:	e8 45 2c 00 00       	call   5100 <printf>

  unlink("lf1");
    24bb:	c7 04 24 e6 59 00 00 	movl   $0x59e6,(%esp)
    24c2:	e8 31 2b 00 00       	call   4ff8 <unlink>
  unlink("lf2");
    24c7:	c7 04 24 ea 59 00 00 	movl   $0x59ea,(%esp)
    24ce:	e8 25 2b 00 00       	call   4ff8 <unlink>

  fd = open("lf1", O_CREATE|O_RDWR);
    24d3:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
    24da:	00 
    24db:	c7 04 24 e6 59 00 00 	movl   $0x59e6,(%esp)
    24e2:	e8 01 2b 00 00       	call   4fe8 <open>
  if(fd < 0){
    24e7:	85 c0                	test   %eax,%eax
  printf(1, "linktest\n");

  unlink("lf1");
  unlink("lf2");

  fd = open("lf1", O_CREATE|O_RDWR);
    24e9:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    24eb:	0f 88 26 01 00 00    	js     2617 <linktest+0x177>
    printf(1, "create lf1 failed\n");
    exit(0);
  }
  if(write(fd, "hello", 5) != 5){
    24f1:	c7 44 24 08 05 00 00 	movl   $0x5,0x8(%esp)
    24f8:	00 
    24f9:	c7 44 24 04 59 56 00 	movl   $0x5659,0x4(%esp)
    2500:	00 
    2501:	89 04 24             	mov    %eax,(%esp)
    2504:	e8 bf 2a 00 00       	call   4fc8 <write>
    2509:	83 f8 05             	cmp    $0x5,%eax
    250c:	0f 85 05 02 00 00    	jne    2717 <linktest+0x277>
    printf(1, "write lf1 failed\n");
    exit(0);
  }
  close(fd);
    2512:	89 1c 24             	mov    %ebx,(%esp)
    2515:	e8 b6 2a 00 00       	call   4fd0 <close>

  if(link("lf1", "lf2") < 0){
    251a:	c7 44 24 04 ea 59 00 	movl   $0x59ea,0x4(%esp)
    2521:	00 
    2522:	c7 04 24 e6 59 00 00 	movl   $0x59e6,(%esp)
    2529:	e8 da 2a 00 00       	call   5008 <link>
    252e:	85 c0                	test   %eax,%eax
    2530:	0f 88 c1 01 00 00    	js     26f7 <linktest+0x257>
    printf(1, "link lf1 lf2 failed\n");
    exit(0);
  }
  unlink("lf1");
    2536:	c7 04 24 e6 59 00 00 	movl   $0x59e6,(%esp)
    253d:	e8 b6 2a 00 00       	call   4ff8 <unlink>

  if(open("lf1", 0) >= 0){
    2542:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    2549:	00 
    254a:	c7 04 24 e6 59 00 00 	movl   $0x59e6,(%esp)
    2551:	e8 92 2a 00 00       	call   4fe8 <open>
    2556:	85 c0                	test   %eax,%eax
    2558:	0f 89 79 01 00 00    	jns    26d7 <linktest+0x237>
    printf(1, "unlinked lf1 but it is still there!\n");
    exit(0);
  }

  fd = open("lf2", 0);
    255e:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    2565:	00 
    2566:	c7 04 24 ea 59 00 00 	movl   $0x59ea,(%esp)
    256d:	e8 76 2a 00 00       	call   4fe8 <open>
  if(fd < 0){
    2572:	85 c0                	test   %eax,%eax
  if(open("lf1", 0) >= 0){
    printf(1, "unlinked lf1 but it is still there!\n");
    exit(0);
  }

  fd = open("lf2", 0);
    2574:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    2576:	0f 88 3b 01 00 00    	js     26b7 <linktest+0x217>
    printf(1, "open lf2 failed\n");
    exit(0);
  }
  if(read(fd, buf, sizeof(buf)) != 5){
    257c:	c7 44 24 08 00 20 00 	movl   $0x2000,0x8(%esp)
    2583:	00 
    2584:	c7 44 24 04 20 94 00 	movl   $0x9420,0x4(%esp)
    258b:	00 
    258c:	89 04 24             	mov    %eax,(%esp)
    258f:	e8 2c 2a 00 00       	call   4fc0 <read>
    2594:	83 f8 05             	cmp    $0x5,%eax
    2597:	0f 85 fa 00 00 00    	jne    2697 <linktest+0x1f7>
    printf(1, "read lf2 failed\n");
    exit(0);
  }
  close(fd);
    259d:	89 1c 24             	mov    %ebx,(%esp)
    25a0:	e8 2b 2a 00 00       	call   4fd0 <close>

  if(link("lf2", "lf2") >= 0){
    25a5:	c7 44 24 04 ea 59 00 	movl   $0x59ea,0x4(%esp)
    25ac:	00 
    25ad:	c7 04 24 ea 59 00 00 	movl   $0x59ea,(%esp)
    25b4:	e8 4f 2a 00 00       	call   5008 <link>
    25b9:	85 c0                	test   %eax,%eax
    25bb:	0f 89 b6 00 00 00    	jns    2677 <linktest+0x1d7>
    printf(1, "link lf2 lf2 succeeded! oops\n");
    exit(0);
  }

  unlink("lf2");
    25c1:	c7 04 24 ea 59 00 00 	movl   $0x59ea,(%esp)
    25c8:	e8 2b 2a 00 00       	call   4ff8 <unlink>
  if(link("lf2", "lf1") >= 0){
    25cd:	c7 44 24 04 e6 59 00 	movl   $0x59e6,0x4(%esp)
    25d4:	00 
    25d5:	c7 04 24 ea 59 00 00 	movl   $0x59ea,(%esp)
    25dc:	e8 27 2a 00 00       	call   5008 <link>
    25e1:	85 c0                	test   %eax,%eax
    25e3:	79 72                	jns    2657 <linktest+0x1b7>
    printf(1, "link non-existant succeeded! oops\n");
    exit(0);
  }

  if(link(".", "lf1") >= 0){
    25e5:	c7 44 24 04 e6 59 00 	movl   $0x59e6,0x4(%esp)
    25ec:	00 
    25ed:	c7 04 24 b2 5f 00 00 	movl   $0x5fb2,(%esp)
    25f4:	e8 0f 2a 00 00       	call   5008 <link>
    25f9:	85 c0                	test   %eax,%eax
    25fb:	79 3a                	jns    2637 <linktest+0x197>
    printf(1, "link . lf1 succeeded! oops\n");
    exit(0);
  }

  printf(1, "linktest ok\n");
    25fd:	c7 44 24 04 84 5a 00 	movl   $0x5a84,0x4(%esp)
    2604:	00 
    2605:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    260c:	e8 ef 2a 00 00       	call   5100 <printf>
}
    2611:	83 c4 14             	add    $0x14,%esp
    2614:	5b                   	pop    %ebx
    2615:	5d                   	pop    %ebp
    2616:	c3                   	ret    
  unlink("lf1");
  unlink("lf2");

  fd = open("lf1", O_CREATE|O_RDWR);
  if(fd < 0){
    printf(1, "create lf1 failed\n");
    2617:	c7 44 24 04 ee 59 00 	movl   $0x59ee,0x4(%esp)
    261e:	00 
    261f:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2626:	e8 d5 2a 00 00       	call   5100 <printf>
    exit(0);
    262b:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2632:	e8 71 29 00 00       	call   4fa8 <exit>
    printf(1, "link non-existant succeeded! oops\n");
    exit(0);
  }

  if(link(".", "lf1") >= 0){
    printf(1, "link . lf1 succeeded! oops\n");
    2637:	c7 44 24 04 68 5a 00 	movl   $0x5a68,0x4(%esp)
    263e:	00 
    263f:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2646:	e8 b5 2a 00 00       	call   5100 <printf>
    exit(0);
    264b:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2652:	e8 51 29 00 00       	call   4fa8 <exit>
    exit(0);
  }

  unlink("lf2");
  if(link("lf2", "lf1") >= 0){
    printf(1, "link non-existant succeeded! oops\n");
    2657:	c7 44 24 04 d8 66 00 	movl   $0x66d8,0x4(%esp)
    265e:	00 
    265f:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2666:	e8 95 2a 00 00       	call   5100 <printf>
    exit(0);
    266b:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2672:	e8 31 29 00 00       	call   4fa8 <exit>
    exit(0);
  }
  close(fd);

  if(link("lf2", "lf2") >= 0){
    printf(1, "link lf2 lf2 succeeded! oops\n");
    2677:	c7 44 24 04 4a 5a 00 	movl   $0x5a4a,0x4(%esp)
    267e:	00 
    267f:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2686:	e8 75 2a 00 00       	call   5100 <printf>
    exit(0);
    268b:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2692:	e8 11 29 00 00       	call   4fa8 <exit>
  if(fd < 0){
    printf(1, "open lf2 failed\n");
    exit(0);
  }
  if(read(fd, buf, sizeof(buf)) != 5){
    printf(1, "read lf2 failed\n");
    2697:	c7 44 24 04 39 5a 00 	movl   $0x5a39,0x4(%esp)
    269e:	00 
    269f:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    26a6:	e8 55 2a 00 00       	call   5100 <printf>
    exit(0);
    26ab:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    26b2:	e8 f1 28 00 00       	call   4fa8 <exit>
    exit(0);
  }

  fd = open("lf2", 0);
  if(fd < 0){
    printf(1, "open lf2 failed\n");
    26b7:	c7 44 24 04 28 5a 00 	movl   $0x5a28,0x4(%esp)
    26be:	00 
    26bf:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    26c6:	e8 35 2a 00 00       	call   5100 <printf>
    exit(0);
    26cb:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    26d2:	e8 d1 28 00 00       	call   4fa8 <exit>
    exit(0);
  }
  unlink("lf1");

  if(open("lf1", 0) >= 0){
    printf(1, "unlinked lf1 but it is still there!\n");
    26d7:	c7 44 24 04 b0 66 00 	movl   $0x66b0,0x4(%esp)
    26de:	00 
    26df:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    26e6:	e8 15 2a 00 00       	call   5100 <printf>
    exit(0);
    26eb:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    26f2:	e8 b1 28 00 00       	call   4fa8 <exit>
    exit(0);
  }
  close(fd);

  if(link("lf1", "lf2") < 0){
    printf(1, "link lf1 lf2 failed\n");
    26f7:	c7 44 24 04 13 5a 00 	movl   $0x5a13,0x4(%esp)
    26fe:	00 
    26ff:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2706:	e8 f5 29 00 00       	call   5100 <printf>
    exit(0);
    270b:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2712:	e8 91 28 00 00       	call   4fa8 <exit>
  if(fd < 0){
    printf(1, "create lf1 failed\n");
    exit(0);
  }
  if(write(fd, "hello", 5) != 5){
    printf(1, "write lf1 failed\n");
    2717:	c7 44 24 04 01 5a 00 	movl   $0x5a01,0x4(%esp)
    271e:	00 
    271f:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2726:	e8 d5 29 00 00       	call   5100 <printf>
    exit(0);
    272b:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2732:	e8 71 28 00 00       	call   4fa8 <exit>
    2737:	89 f6                	mov    %esi,%esi
    2739:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00002740 <sbrktest>:
  printf(1, "fork test OK\n");
}

void
sbrktest(void)
{
    2740:	55                   	push   %ebp
    2741:	89 e5                	mov    %esp,%ebp
    2743:	57                   	push   %edi
    2744:	56                   	push   %esi

  printf(stdout, "sbrk test\n");
  oldbrk = sbrk(0);

  // can one sbrk() less than a page?
  a = sbrk(0);
    2745:	31 f6                	xor    %esi,%esi
  printf(1, "fork test OK\n");
}

void
sbrktest(void)
{
    2747:	53                   	push   %ebx
    2748:	83 ec 7c             	sub    $0x7c,%esp
  int fds[2], pid, pids[10], ppid;
  char *a, *b, *c, *lastaddr, *oldbrk, *p, scratch;
  uint amt;

  printf(stdout, "sbrk test\n");
    274b:	a1 2c 6c 00 00       	mov    0x6c2c,%eax
    2750:	c7 44 24 04 91 5a 00 	movl   $0x5a91,0x4(%esp)
    2757:	00 
    2758:	89 04 24             	mov    %eax,(%esp)
    275b:	e8 a0 29 00 00       	call   5100 <printf>
  oldbrk = sbrk(0);
    2760:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2767:	e8 c4 28 00 00       	call   5030 <sbrk>

  // can one sbrk() less than a page?
  a = sbrk(0);
    276c:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  int fds[2], pid, pids[10], ppid;
  char *a, *b, *c, *lastaddr, *oldbrk, *p, scratch;
  uint amt;

  printf(stdout, "sbrk test\n");
  oldbrk = sbrk(0);
    2773:	89 45 a4             	mov    %eax,-0x5c(%ebp)

  // can one sbrk() less than a page?
  a = sbrk(0);
    2776:	e8 b5 28 00 00       	call   5030 <sbrk>
    277b:	89 c3                	mov    %eax,%ebx
    277d:	8d 76 00             	lea    0x0(%esi),%esi
  int i;
  for(i = 0; i < 5000; i++){
    b = sbrk(1);
    2780:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2787:	e8 a4 28 00 00       	call   5030 <sbrk>
    if(b != a){
    278c:	39 c3                	cmp    %eax,%ebx
    278e:	0f 85 9a 02 00 00    	jne    2a2e <sbrktest+0x2ee>
  oldbrk = sbrk(0);

  // can one sbrk() less than a page?
  a = sbrk(0);
  int i;
  for(i = 0; i < 5000; i++){
    2794:	83 c6 01             	add    $0x1,%esi
    b = sbrk(1);
    if(b != a){
      printf(stdout, "sbrk test failed %d %x %x\n", i, a, b);
      exit(0);
    }
    *b = 1;
    2797:	c6 03 01             	movb   $0x1,(%ebx)
    a = b + 1;
    279a:	83 c3 01             	add    $0x1,%ebx
  oldbrk = sbrk(0);

  // can one sbrk() less than a page?
  a = sbrk(0);
  int i;
  for(i = 0; i < 5000; i++){
    279d:	81 fe 88 13 00 00    	cmp    $0x1388,%esi
    27a3:	75 db                	jne    2780 <sbrktest+0x40>
      exit(0);
    }
    *b = 1;
    a = b + 1;
  }
  pid = fork();
    27a5:	e8 f6 27 00 00       	call   4fa0 <fork>
  if(pid < 0){
    27aa:	85 c0                	test   %eax,%eax
      exit(0);
    }
    *b = 1;
    a = b + 1;
  }
  pid = fork();
    27ac:	89 c6                	mov    %eax,%esi
  if(pid < 0){
    27ae:	0f 88 b4 03 00 00    	js     2b68 <sbrktest+0x428>
    printf(stdout, "sbrk test fork failed\n");
    exit(0);
  }
  c = sbrk(1);
    27b4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  c = sbrk(1);
  if(c != a + 1){
    27bb:	83 c3 01             	add    $0x1,%ebx
  pid = fork();
  if(pid < 0){
    printf(stdout, "sbrk test fork failed\n");
    exit(0);
  }
  c = sbrk(1);
    27be:	e8 6d 28 00 00       	call   5030 <sbrk>
  c = sbrk(1);
    27c3:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    27ca:	e8 61 28 00 00       	call   5030 <sbrk>
  if(c != a + 1){
    27cf:	39 d8                	cmp    %ebx,%eax
    27d1:	0f 85 84 03 00 00    	jne    2b5b <sbrktest+0x41b>
    printf(stdout, "sbrk test failed post-fork\n");
    exit(0);
  }
  if(pid == 0)
    27d7:	85 f6                	test   %esi,%esi
    27d9:	0f 84 b1 02 00 00    	je     2a90 <sbrktest+0x350>
    exit(0);
  wait(&exit_status);
    27df:	c7 04 24 e0 6c 00 00 	movl   $0x6ce0,(%esp)
    27e6:	e8 c5 27 00 00       	call   4fb0 <wait>

  // can one grow address space to something big?
#define BIG (100*1024*1024)
  a = sbrk(0);
    27eb:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    27f2:	e8 39 28 00 00       	call   5030 <sbrk>
    27f7:	89 c3                	mov    %eax,%ebx
  amt = (BIG) - (uint)a;
  p = sbrk(amt);
    27f9:	b8 00 00 40 06       	mov    $0x6400000,%eax
    27fe:	29 d8                	sub    %ebx,%eax
    2800:	89 04 24             	mov    %eax,(%esp)
    2803:	e8 28 28 00 00       	call   5030 <sbrk>
  if (p != a) {
    2808:	39 c3                	cmp    %eax,%ebx
    280a:	0f 85 08 03 00 00    	jne    2b18 <sbrktest+0x3d8>
    printf(stdout, "sbrk test failed to grow big address space; enough phys mem?\n");
    exit(0);
  }
  lastaddr = (char*) (BIG-1);
  *lastaddr = 99;
    2810:	c6 05 ff ff 3f 06 63 	movb   $0x63,0x63fffff

  // can one de-allocate?
  a = sbrk(0);
    2817:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    281e:	e8 0d 28 00 00       	call   5030 <sbrk>
  c = sbrk(-4096);
    2823:	c7 04 24 00 f0 ff ff 	movl   $0xfffff000,(%esp)
  }
  lastaddr = (char*) (BIG-1);
  *lastaddr = 99;

  // can one de-allocate?
  a = sbrk(0);
    282a:	89 c3                	mov    %eax,%ebx
  c = sbrk(-4096);
    282c:	e8 ff 27 00 00       	call   5030 <sbrk>
  if(c == (char*)0xffffffff){
    2831:	83 f8 ff             	cmp    $0xffffffff,%eax
    2834:	0f 84 14 03 00 00    	je     2b4e <sbrktest+0x40e>
    printf(stdout, "sbrk could not deallocate\n");
    exit(0);
  }
  c = sbrk(0);
    283a:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2841:	e8 ea 27 00 00       	call   5030 <sbrk>
  if(c != a - 4096){
    2846:	8d 93 00 f0 ff ff    	lea    -0x1000(%ebx),%edx
    284c:	39 d0                	cmp    %edx,%eax
    284e:	0f 85 d1 02 00 00    	jne    2b25 <sbrktest+0x3e5>
    printf(stdout, "sbrk deallocation produced wrong address, a %x c %x\n", a, c);
    exit(0);
  }

  // can one re-allocate that page?
  a = sbrk(0);
    2854:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    285b:	e8 d0 27 00 00       	call   5030 <sbrk>
  c = sbrk(4096);
    2860:	c7 04 24 00 10 00 00 	movl   $0x1000,(%esp)
    printf(stdout, "sbrk deallocation produced wrong address, a %x c %x\n", a, c);
    exit(0);
  }

  // can one re-allocate that page?
  a = sbrk(0);
    2867:	89 c3                	mov    %eax,%ebx
  c = sbrk(4096);
    2869:	e8 c2 27 00 00       	call   5030 <sbrk>
  if(c != a || sbrk(0) != a + 4096){
    286e:	39 c3                	cmp    %eax,%ebx
    exit(0);
  }

  // can one re-allocate that page?
  a = sbrk(0);
  c = sbrk(4096);
    2870:	89 c6                	mov    %eax,%esi
  if(c != a || sbrk(0) != a + 4096){
    2872:	0f 85 8e 02 00 00    	jne    2b06 <sbrktest+0x3c6>
    2878:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    287f:	e8 ac 27 00 00       	call   5030 <sbrk>
    2884:	8d 93 00 10 00 00    	lea    0x1000(%ebx),%edx
    288a:	39 d0                	cmp    %edx,%eax
    288c:	0f 85 74 02 00 00    	jne    2b06 <sbrktest+0x3c6>
    printf(stdout, "sbrk re-allocation failed, a %x c %x\n", a, c);
    exit(0);
  }
  if(*lastaddr == 99){
    2892:	80 3d ff ff 3f 06 63 	cmpb   $0x63,0x63fffff
    2899:	0f 84 5a 02 00 00    	je     2af9 <sbrktest+0x3b9>
    // should be zero
    printf(stdout, "sbrk de-allocation didn't really deallocate\n");
    exit(0);
  }

  a = sbrk(0);
    289f:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  c = sbrk(-(sbrk(0) - oldbrk));
  if(c != a){
    printf(stdout, "sbrk downsize failed, a %x c %x\n", a, c);
    exit(0);
    28a6:	bb 00 00 00 80       	mov    $0x80000000,%ebx
    // should be zero
    printf(stdout, "sbrk de-allocation didn't really deallocate\n");
    exit(0);
  }

  a = sbrk(0);
    28ab:	e8 80 27 00 00       	call   5030 <sbrk>
  c = sbrk(-(sbrk(0) - oldbrk));
    28b0:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    // should be zero
    printf(stdout, "sbrk de-allocation didn't really deallocate\n");
    exit(0);
  }

  a = sbrk(0);
    28b7:	89 c6                	mov    %eax,%esi
  c = sbrk(-(sbrk(0) - oldbrk));
    28b9:	e8 72 27 00 00       	call   5030 <sbrk>
    28be:	8b 55 a4             	mov    -0x5c(%ebp),%edx
    28c1:	29 c2                	sub    %eax,%edx
    28c3:	89 14 24             	mov    %edx,(%esp)
    28c6:	e8 65 27 00 00       	call   5030 <sbrk>
  if(c != a){
    28cb:	39 c6                	cmp    %eax,%esi
    28cd:	0f 85 07 02 00 00    	jne    2ada <sbrktest+0x39a>
    28d3:	90                   	nop
    28d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    exit(0);
  }

  // can we read the kernel's memory?
  for(a = (char*)(KERNBASE); a < (char*) (KERNBASE+2000000); a += 50000){
    ppid = getpid();
    28d8:	e8 4b 27 00 00       	call   5028 <getpid>
    28dd:	89 c6                	mov    %eax,%esi
    pid = fork();
    28df:	e8 bc 26 00 00       	call   4fa0 <fork>
    if(pid < 0){
    28e4:	83 f8 00             	cmp    $0x0,%eax
    28e7:	0f 8c e3 01 00 00    	jl     2ad0 <sbrktest+0x390>
    28ed:	8d 76 00             	lea    0x0(%esi),%esi
      printf(stdout, "fork failed\n");
      exit(0);
    }
    if(pid == 0){
    28f0:	0f 84 a6 01 00 00    	je     2a9c <sbrktest+0x35c>
    printf(stdout, "sbrk downsize failed, a %x c %x\n", a, c);
    exit(0);
  }

  // can we read the kernel's memory?
  for(a = (char*)(KERNBASE); a < (char*) (KERNBASE+2000000); a += 50000){
    28f6:	81 c3 50 c3 00 00    	add    $0xc350,%ebx
    if(pid == 0){
      printf(stdout, "oops could read %x = %x\n", a, *a);
      kill(ppid);
      exit(0);
    }
    wait(&exit_status);
    28fc:	c7 04 24 e0 6c 00 00 	movl   $0x6ce0,(%esp)
    2903:	e8 a8 26 00 00       	call   4fb0 <wait>
    printf(stdout, "sbrk downsize failed, a %x c %x\n", a, c);
    exit(0);
  }

  // can we read the kernel's memory?
  for(a = (char*)(KERNBASE); a < (char*) (KERNBASE+2000000); a += 50000){
    2908:	81 fb 80 84 1e 80    	cmp    $0x801e8480,%ebx
    290e:	75 c8                	jne    28d8 <sbrktest+0x198>
    wait(&exit_status);
  }

  // if we run the system out of memory, does it clean up the last
  // failed allocation?
  if(pipe(fds) != 0){
    2910:	8d 45 dc             	lea    -0x24(%ebp),%eax
    2913:	89 04 24             	mov    %eax,(%esp)
    2916:	e8 9d 26 00 00       	call   4fb8 <pipe>
    291b:	85 c0                	test   %eax,%eax
    291d:	0f 85 59 01 00 00    	jne    2a7c <sbrktest+0x33c>
    printf(1, "pipe() failed\n");
    exit(0);
    2923:	31 db                	xor    %ebx,%ebx
    2925:	8d 7d b4             	lea    -0x4c(%ebp),%edi
  }
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    if((pids[i] = fork()) == 0){
    2928:	e8 73 26 00 00       	call   4fa0 <fork>
    292d:	85 c0                	test   %eax,%eax
    292f:	89 c6                	mov    %eax,%esi
    2931:	0f 84 ae 00 00 00    	je     29e5 <sbrktest+0x2a5>
      sbrk(BIG - (uint)sbrk(0));
      write(fds[1], "x", 1);
      // sit around until killed
      for(;;) sleep(1000);
    }
    if(pids[i] != -1)
    2937:	83 f8 ff             	cmp    $0xffffffff,%eax
    293a:	74 1a                	je     2956 <sbrktest+0x216>
      read(fds[0], &scratch, 1);
    293c:	8d 45 e7             	lea    -0x19(%ebp),%eax
    293f:	89 44 24 04          	mov    %eax,0x4(%esp)
    2943:	8b 45 dc             	mov    -0x24(%ebp),%eax
    2946:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    294d:	00 
    294e:	89 04 24             	mov    %eax,(%esp)
    2951:	e8 6a 26 00 00       	call   4fc0 <read>
  if(pipe(fds) != 0){
    printf(1, "pipe() failed\n");
    exit(0);
  }
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    if((pids[i] = fork()) == 0){
    2956:	89 34 9f             	mov    %esi,(%edi,%ebx,4)
  // failed allocation?
  if(pipe(fds) != 0){
    printf(1, "pipe() failed\n");
    exit(0);
  }
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    2959:	83 c3 01             	add    $0x1,%ebx
    295c:	83 fb 0a             	cmp    $0xa,%ebx
    295f:	75 c7                	jne    2928 <sbrktest+0x1e8>
    if(pids[i] != -1)
      read(fds[0], &scratch, 1);
  }
  // if those failed allocations freed up the pages they did allocate,
  // we'll be able to allocate here
  c = sbrk(4096);
    2961:	c7 04 24 00 10 00 00 	movl   $0x1000,(%esp)
    2968:	30 db                	xor    %bl,%bl
    296a:	e8 c1 26 00 00       	call   5030 <sbrk>
    296f:	89 c6                	mov    %eax,%esi
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    if(pids[i] == -1)
    2971:	8b 04 9f             	mov    (%edi,%ebx,4),%eax
    2974:	83 f8 ff             	cmp    $0xffffffff,%eax
    2977:	74 14                	je     298d <sbrktest+0x24d>
      continue;
    kill(pids[i]);
    2979:	89 04 24             	mov    %eax,(%esp)
    297c:	e8 57 26 00 00       	call   4fd8 <kill>
    wait(&exit_status);
    2981:	c7 04 24 e0 6c 00 00 	movl   $0x6ce0,(%esp)
    2988:	e8 23 26 00 00       	call   4fb0 <wait>
      read(fds[0], &scratch, 1);
  }
  // if those failed allocations freed up the pages they did allocate,
  // we'll be able to allocate here
  c = sbrk(4096);
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    298d:	83 c3 01             	add    $0x1,%ebx
    2990:	83 fb 0a             	cmp    $0xa,%ebx
    2993:	75 dc                	jne    2971 <sbrktest+0x231>
    if(pids[i] == -1)
      continue;
    kill(pids[i]);
    wait(&exit_status);
  }
  if(c == (char*)0xffffffff){
    2995:	83 fe ff             	cmp    $0xffffffff,%esi
    2998:	0f 84 bd 00 00 00    	je     2a5b <sbrktest+0x31b>
    printf(stdout, "failed sbrk leaked memory\n");
    exit(0);
  }

  if(sbrk(0) > oldbrk)
    299e:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    29a5:	e8 86 26 00 00       	call   5030 <sbrk>
    29aa:	39 45 a4             	cmp    %eax,-0x5c(%ebp)
    29ad:	73 19                	jae    29c8 <sbrktest+0x288>
    sbrk(-(sbrk(0) - oldbrk));
    29af:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    29b6:	e8 75 26 00 00       	call   5030 <sbrk>
    29bb:	8b 55 a4             	mov    -0x5c(%ebp),%edx
    29be:	29 c2                	sub    %eax,%edx
    29c0:	89 14 24             	mov    %edx,(%esp)
    29c3:	e8 68 26 00 00       	call   5030 <sbrk>

  printf(stdout, "sbrk test OK\n");
    29c8:	a1 2c 6c 00 00       	mov    0x6c2c,%eax
    29cd:	c7 44 24 04 48 5b 00 	movl   $0x5b48,0x4(%esp)
    29d4:	00 
    29d5:	89 04 24             	mov    %eax,(%esp)
    29d8:	e8 23 27 00 00       	call   5100 <printf>
}
    29dd:	83 c4 7c             	add    $0x7c,%esp
    29e0:	5b                   	pop    %ebx
    29e1:	5e                   	pop    %esi
    29e2:	5f                   	pop    %edi
    29e3:	5d                   	pop    %ebp
    29e4:	c3                   	ret    
    exit(0);
  }
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    if((pids[i] = fork()) == 0){
      // allocate a lot of memory
      sbrk(BIG - (uint)sbrk(0));
    29e5:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    29ec:	e8 3f 26 00 00       	call   5030 <sbrk>
    29f1:	ba 00 00 40 06       	mov    $0x6400000,%edx
    29f6:	29 c2                	sub    %eax,%edx
    29f8:	89 14 24             	mov    %edx,(%esp)
    29fb:	e8 30 26 00 00       	call   5030 <sbrk>
      write(fds[1], "x", 1);
    2a00:	8b 45 e0             	mov    -0x20(%ebp),%eax
    2a03:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    2a0a:	00 
    2a0b:	c7 44 24 04 95 60 00 	movl   $0x6095,0x4(%esp)
    2a12:	00 
    2a13:	89 04 24             	mov    %eax,(%esp)
    2a16:	e8 ad 25 00 00       	call   4fc8 <write>
    2a1b:	90                   	nop
    2a1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      // sit around until killed
      for(;;) sleep(1000);
    2a20:	c7 04 24 e8 03 00 00 	movl   $0x3e8,(%esp)
    2a27:	e8 0c 26 00 00       	call   5038 <sleep>
    2a2c:	eb f2                	jmp    2a20 <sbrktest+0x2e0>
  a = sbrk(0);
  int i;
  for(i = 0; i < 5000; i++){
    b = sbrk(1);
    if(b != a){
      printf(stdout, "sbrk test failed %d %x %x\n", i, a, b);
    2a2e:	89 44 24 10          	mov    %eax,0x10(%esp)
    2a32:	a1 2c 6c 00 00       	mov    0x6c2c,%eax
    2a37:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
    2a3b:	89 74 24 08          	mov    %esi,0x8(%esp)
    2a3f:	c7 44 24 04 9c 5a 00 	movl   $0x5a9c,0x4(%esp)
    2a46:	00 
    2a47:	89 04 24             	mov    %eax,(%esp)
    2a4a:	e8 b1 26 00 00       	call   5100 <printf>
      exit(0);
    2a4f:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2a56:	e8 4d 25 00 00       	call   4fa8 <exit>
      continue;
    kill(pids[i]);
    wait(&exit_status);
  }
  if(c == (char*)0xffffffff){
    printf(stdout, "failed sbrk leaked memory\n");
    2a5b:	c7 44 24 04 2d 5b 00 	movl   $0x5b2d,0x4(%esp)
    2a62:	00 
    exit(0);
  }
  c = sbrk(1);
  c = sbrk(1);
  if(c != a + 1){
    printf(stdout, "sbrk test failed post-fork\n");
    2a63:	a1 2c 6c 00 00       	mov    0x6c2c,%eax
    2a68:	89 04 24             	mov    %eax,(%esp)
    2a6b:	e8 90 26 00 00       	call   5100 <printf>
    exit(0);
    2a70:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2a77:	e8 2c 25 00 00       	call   4fa8 <exit>
  }

  // if we run the system out of memory, does it clean up the last
  // failed allocation?
  if(pipe(fds) != 0){
    printf(1, "pipe() failed\n");
    2a7c:	c7 44 24 04 1e 5b 00 	movl   $0x5b1e,0x4(%esp)
    2a83:	00 
    2a84:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2a8b:	e8 70 26 00 00       	call   5100 <printf>

  a = sbrk(0);
  c = sbrk(-(sbrk(0) - oldbrk));
  if(c != a){
    printf(stdout, "sbrk downsize failed, a %x c %x\n", a, c);
    exit(0);
    2a90:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2a97:	e8 0c 25 00 00       	call   4fa8 <exit>
    if(pid < 0){
      printf(stdout, "fork failed\n");
      exit(0);
    }
    if(pid == 0){
      printf(stdout, "oops could read %x = %x\n", a, *a);
    2a9c:	0f be 03             	movsbl (%ebx),%eax
    2a9f:	89 5c 24 08          	mov    %ebx,0x8(%esp)
    2aa3:	c7 44 24 04 05 5b 00 	movl   $0x5b05,0x4(%esp)
    2aaa:	00 
    2aab:	89 44 24 0c          	mov    %eax,0xc(%esp)
    2aaf:	a1 2c 6c 00 00       	mov    0x6c2c,%eax
    2ab4:	89 04 24             	mov    %eax,(%esp)
    2ab7:	e8 44 26 00 00       	call   5100 <printf>
      kill(ppid);
    2abc:	89 34 24             	mov    %esi,(%esp)
    2abf:	e8 14 25 00 00       	call   4fd8 <kill>
      exit(0);
    2ac4:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2acb:	e8 d8 24 00 00       	call   4fa8 <exit>
  // can we read the kernel's memory?
  for(a = (char*)(KERNBASE); a < (char*) (KERNBASE+2000000); a += 50000){
    ppid = getpid();
    pid = fork();
    if(pid < 0){
      printf(stdout, "fork failed\n");
    2ad0:	c7 44 24 04 df 58 00 	movl   $0x58df,0x4(%esp)
    2ad7:	00 
    2ad8:	eb 89                	jmp    2a63 <sbrktest+0x323>
  }

  a = sbrk(0);
  c = sbrk(-(sbrk(0) - oldbrk));
  if(c != a){
    printf(stdout, "sbrk downsize failed, a %x c %x\n", a, c);
    2ada:	89 44 24 0c          	mov    %eax,0xc(%esp)
    2ade:	89 74 24 08          	mov    %esi,0x8(%esp)
    2ae2:	c7 44 24 04 cc 67 00 	movl   $0x67cc,0x4(%esp)
    2ae9:	00 
    2aea:	a1 2c 6c 00 00       	mov    0x6c2c,%eax
    2aef:	89 04 24             	mov    %eax,(%esp)
    2af2:	e8 09 26 00 00       	call   5100 <printf>
    2af7:	eb 97                	jmp    2a90 <sbrktest+0x350>
    printf(stdout, "sbrk re-allocation failed, a %x c %x\n", a, c);
    exit(0);
  }
  if(*lastaddr == 99){
    // should be zero
    printf(stdout, "sbrk de-allocation didn't really deallocate\n");
    2af9:	c7 44 24 04 9c 67 00 	movl   $0x679c,0x4(%esp)
    2b00:	00 
    2b01:	e9 5d ff ff ff       	jmp    2a63 <sbrktest+0x323>

  // can one re-allocate that page?
  a = sbrk(0);
  c = sbrk(4096);
  if(c != a || sbrk(0) != a + 4096){
    printf(stdout, "sbrk re-allocation failed, a %x c %x\n", a, c);
    2b06:	89 74 24 0c          	mov    %esi,0xc(%esp)
    2b0a:	89 5c 24 08          	mov    %ebx,0x8(%esp)
    2b0e:	c7 44 24 04 74 67 00 	movl   $0x6774,0x4(%esp)
    2b15:	00 
    2b16:	eb d2                	jmp    2aea <sbrktest+0x3aa>
#define BIG (100*1024*1024)
  a = sbrk(0);
  amt = (BIG) - (uint)a;
  p = sbrk(amt);
  if (p != a) {
    printf(stdout, "sbrk test failed to grow big address space; enough phys mem?\n");
    2b18:	c7 44 24 04 fc 66 00 	movl   $0x66fc,0x4(%esp)
    2b1f:	00 
    2b20:	e9 3e ff ff ff       	jmp    2a63 <sbrktest+0x323>
    printf(stdout, "sbrk could not deallocate\n");
    exit(0);
  }
  c = sbrk(0);
  if(c != a - 4096){
    printf(stdout, "sbrk deallocation produced wrong address, a %x c %x\n", a, c);
    2b25:	89 44 24 0c          	mov    %eax,0xc(%esp)
    2b29:	a1 2c 6c 00 00       	mov    0x6c2c,%eax
    2b2e:	89 5c 24 08          	mov    %ebx,0x8(%esp)
    2b32:	c7 44 24 04 3c 67 00 	movl   $0x673c,0x4(%esp)
    2b39:	00 
    2b3a:	89 04 24             	mov    %eax,(%esp)
    2b3d:	e8 be 25 00 00       	call   5100 <printf>
    exit(0);
    2b42:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2b49:	e8 5a 24 00 00       	call   4fa8 <exit>

  // can one de-allocate?
  a = sbrk(0);
  c = sbrk(-4096);
  if(c == (char*)0xffffffff){
    printf(stdout, "sbrk could not deallocate\n");
    2b4e:	c7 44 24 04 ea 5a 00 	movl   $0x5aea,0x4(%esp)
    2b55:	00 
    2b56:	e9 08 ff ff ff       	jmp    2a63 <sbrktest+0x323>
    exit(0);
  }
  c = sbrk(1);
  c = sbrk(1);
  if(c != a + 1){
    printf(stdout, "sbrk test failed post-fork\n");
    2b5b:	c7 44 24 04 ce 5a 00 	movl   $0x5ace,0x4(%esp)
    2b62:	00 
    2b63:	e9 fb fe ff ff       	jmp    2a63 <sbrktest+0x323>
    *b = 1;
    a = b + 1;
  }
  pid = fork();
  if(pid < 0){
    printf(stdout, "sbrk test fork failed\n");
    2b68:	c7 44 24 04 b7 5a 00 	movl   $0x5ab7,0x4(%esp)
    2b6f:	00 
    2b70:	e9 ee fe ff ff       	jmp    2a63 <sbrktest+0x323>
    2b75:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    2b79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00002b80 <preempt>:
}

// meant to be run w/ at most two CPUs
void
preempt(void)
{
    2b80:	55                   	push   %ebp
    2b81:	89 e5                	mov    %esp,%ebp
    2b83:	57                   	push   %edi
    2b84:	56                   	push   %esi
    2b85:	53                   	push   %ebx
    2b86:	83 ec 2c             	sub    $0x2c,%esp
  int pid1, pid2, pid3;
  int pfds[2];

  printf(1, "preempt: ");
    2b89:	c7 44 24 04 56 5b 00 	movl   $0x5b56,0x4(%esp)
    2b90:	00 
    2b91:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2b98:	e8 63 25 00 00       	call   5100 <printf>
  pid1 = fork();
    2b9d:	e8 fe 23 00 00       	call   4fa0 <fork>
  if(pid1 == 0)
    2ba2:	85 c0                	test   %eax,%eax
{
  int pid1, pid2, pid3;
  int pfds[2];

  printf(1, "preempt: ");
  pid1 = fork();
    2ba4:	89 c7                	mov    %eax,%edi
  if(pid1 == 0)
    2ba6:	75 02                	jne    2baa <preempt+0x2a>
    2ba8:	eb fe                	jmp    2ba8 <preempt+0x28>
    2baa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    for(;;)
      ;

  pid2 = fork();
    2bb0:	e8 eb 23 00 00       	call   4fa0 <fork>
  if(pid2 == 0)
    2bb5:	85 c0                	test   %eax,%eax
  pid1 = fork();
  if(pid1 == 0)
    for(;;)
      ;

  pid2 = fork();
    2bb7:	89 c6                	mov    %eax,%esi
  if(pid2 == 0)
    2bb9:	75 02                	jne    2bbd <preempt+0x3d>
    2bbb:	eb fe                	jmp    2bbb <preempt+0x3b>
    for(;;)
      ;

  pipe(pfds);
    2bbd:	8d 45 e0             	lea    -0x20(%ebp),%eax
    2bc0:	89 04 24             	mov    %eax,(%esp)
    2bc3:	e8 f0 23 00 00       	call   4fb8 <pipe>
  pid3 = fork();
    2bc8:	e8 d3 23 00 00       	call   4fa0 <fork>
  if(pid3 == 0){
    2bcd:	85 c0                	test   %eax,%eax
  if(pid2 == 0)
    for(;;)
      ;

  pipe(pfds);
  pid3 = fork();
    2bcf:	89 c3                	mov    %eax,%ebx
  if(pid3 == 0){
    2bd1:	75 4c                	jne    2c1f <preempt+0x9f>
    close(pfds[0]);
    2bd3:	8b 45 e0             	mov    -0x20(%ebp),%eax
    2bd6:	89 04 24             	mov    %eax,(%esp)
    2bd9:	e8 f2 23 00 00       	call   4fd0 <close>
    if(write(pfds[1], "x", 1) != 1)
    2bde:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2be1:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    2be8:	00 
    2be9:	c7 44 24 04 95 60 00 	movl   $0x6095,0x4(%esp)
    2bf0:	00 
    2bf1:	89 04 24             	mov    %eax,(%esp)
    2bf4:	e8 cf 23 00 00       	call   4fc8 <write>
    2bf9:	83 f8 01             	cmp    $0x1,%eax
    2bfc:	74 14                	je     2c12 <preempt+0x92>
      printf(1, "preempt write error");
    2bfe:	c7 44 24 04 60 5b 00 	movl   $0x5b60,0x4(%esp)
    2c05:	00 
    2c06:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2c0d:	e8 ee 24 00 00       	call   5100 <printf>
    close(pfds[1]);
    2c12:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2c15:	89 04 24             	mov    %eax,(%esp)
    2c18:	e8 b3 23 00 00       	call   4fd0 <close>
    2c1d:	eb fe                	jmp    2c1d <preempt+0x9d>
    for(;;)
      ;
  }

  close(pfds[1]);
    2c1f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2c22:	89 04 24             	mov    %eax,(%esp)
    2c25:	e8 a6 23 00 00       	call   4fd0 <close>
  if(read(pfds[0], buf, sizeof(buf)) != 1){
    2c2a:	8b 45 e0             	mov    -0x20(%ebp),%eax
    2c2d:	c7 44 24 08 00 20 00 	movl   $0x2000,0x8(%esp)
    2c34:	00 
    2c35:	c7 44 24 04 20 94 00 	movl   $0x9420,0x4(%esp)
    2c3c:	00 
    2c3d:	89 04 24             	mov    %eax,(%esp)
    2c40:	e8 7b 23 00 00       	call   4fc0 <read>
    2c45:	83 f8 01             	cmp    $0x1,%eax
    2c48:	74 1c                	je     2c66 <preempt+0xe6>
    printf(1, "preempt read error");
    2c4a:	c7 44 24 04 74 5b 00 	movl   $0x5b74,0x4(%esp)
    2c51:	00 
    2c52:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2c59:	e8 a2 24 00 00       	call   5100 <printf>
  printf(1, "wait... ");
  wait(&exit_status);
  wait(&exit_status);
  wait(&exit_status);
  printf(1, "preempt ok\n");
}
    2c5e:	83 c4 2c             	add    $0x2c,%esp
    2c61:	5b                   	pop    %ebx
    2c62:	5e                   	pop    %esi
    2c63:	5f                   	pop    %edi
    2c64:	5d                   	pop    %ebp
    2c65:	c3                   	ret    
  close(pfds[1]);
  if(read(pfds[0], buf, sizeof(buf)) != 1){
    printf(1, "preempt read error");
    return;
  }
  close(pfds[0]);
    2c66:	8b 45 e0             	mov    -0x20(%ebp),%eax
    2c69:	89 04 24             	mov    %eax,(%esp)
    2c6c:	e8 5f 23 00 00       	call   4fd0 <close>
  printf(1, "kill... ");
    2c71:	c7 44 24 04 87 5b 00 	movl   $0x5b87,0x4(%esp)
    2c78:	00 
    2c79:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2c80:	e8 7b 24 00 00       	call   5100 <printf>
  kill(pid1);
    2c85:	89 3c 24             	mov    %edi,(%esp)
    2c88:	e8 4b 23 00 00       	call   4fd8 <kill>
  kill(pid2);
    2c8d:	89 34 24             	mov    %esi,(%esp)
    2c90:	e8 43 23 00 00       	call   4fd8 <kill>
  kill(pid3);
    2c95:	89 1c 24             	mov    %ebx,(%esp)
    2c98:	e8 3b 23 00 00       	call   4fd8 <kill>
  printf(1, "wait... ");
    2c9d:	c7 44 24 04 90 5b 00 	movl   $0x5b90,0x4(%esp)
    2ca4:	00 
    2ca5:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2cac:	e8 4f 24 00 00       	call   5100 <printf>
  wait(&exit_status);
    2cb1:	c7 04 24 e0 6c 00 00 	movl   $0x6ce0,(%esp)
    2cb8:	e8 f3 22 00 00       	call   4fb0 <wait>
  wait(&exit_status);
    2cbd:	c7 04 24 e0 6c 00 00 	movl   $0x6ce0,(%esp)
    2cc4:	e8 e7 22 00 00       	call   4fb0 <wait>
  wait(&exit_status);
    2cc9:	c7 04 24 e0 6c 00 00 	movl   $0x6ce0,(%esp)
    2cd0:	e8 db 22 00 00       	call   4fb0 <wait>
  printf(1, "preempt ok\n");
    2cd5:	c7 44 24 04 99 5b 00 	movl   $0x5b99,0x4(%esp)
    2cdc:	00 
    2cdd:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2ce4:	e8 17 24 00 00       	call   5100 <printf>
    2ce9:	e9 70 ff ff ff       	jmp    2c5e <preempt+0xde>
    2cee:	66 90                	xchg   %ax,%ax

00002cf0 <pipe1>:

// simple fork and pipe read/write

void
pipe1(void)
{
    2cf0:	55                   	push   %ebp
    2cf1:	89 e5                	mov    %esp,%ebp
    2cf3:	57                   	push   %edi
    2cf4:	56                   	push   %esi
    2cf5:	53                   	push   %ebx
    2cf6:	83 ec 2c             	sub    $0x2c,%esp
  int fds[2], pid;
  int seq, i, n, cc, total;

  if(pipe(fds) != 0){
    2cf9:	8d 45 e0             	lea    -0x20(%ebp),%eax
    2cfc:	89 04 24             	mov    %eax,(%esp)
    2cff:	e8 b4 22 00 00       	call   4fb8 <pipe>
    2d04:	85 c0                	test   %eax,%eax
    2d06:	0f 85 49 01 00 00    	jne    2e55 <pipe1+0x165>
    printf(1, "pipe() failed\n");
    exit(0);
  }
  pid = fork();
    2d0c:	e8 8f 22 00 00       	call   4fa0 <fork>
  seq = 0;
  if(pid == 0){
    2d11:	83 f8 00             	cmp    $0x0,%eax
    2d14:	0f 84 80 00 00 00    	je     2d9a <pipe1+0xaa>
        printf(1, "pipe1 oops 1\n");
        exit(0);
      }
    }
    exit(0);
  } else if(pid > 0){
    2d1a:	0f 8e 55 01 00 00    	jle    2e75 <pipe1+0x185>
    close(fds[1]);
    2d20:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2d23:	31 ff                	xor    %edi,%edi
    2d25:	be 01 00 00 00       	mov    $0x1,%esi
    2d2a:	31 db                	xor    %ebx,%ebx
    2d2c:	89 04 24             	mov    %eax,(%esp)
    2d2f:	e8 9c 22 00 00       	call   4fd0 <close>
    total = 0;
    cc = 1;
    while((n = read(fds[0], buf, cc)) > 0){
    2d34:	8b 45 e0             	mov    -0x20(%ebp),%eax
    2d37:	89 74 24 08          	mov    %esi,0x8(%esp)
    2d3b:	c7 44 24 04 20 94 00 	movl   $0x9420,0x4(%esp)
    2d42:	00 
    2d43:	89 04 24             	mov    %eax,(%esp)
    2d46:	e8 75 22 00 00       	call   4fc0 <read>
    2d4b:	85 c0                	test   %eax,%eax
    2d4d:	0f 8e b0 00 00 00    	jle    2e03 <pipe1+0x113>
    2d53:	31 d2                	xor    %edx,%edx
    2d55:	8d 76 00             	lea    0x0(%esi),%esi
      for(i = 0; i < n; i++){
        if((buf[i] & 0xff) != (seq++ & 0xff)){
    2d58:	38 9a 20 94 00 00    	cmp    %bl,0x9420(%edx)
    2d5e:	75 1e                	jne    2d7e <pipe1+0x8e>
  } else if(pid > 0){
    close(fds[1]);
    total = 0;
    cc = 1;
    while((n = read(fds[0], buf, cc)) > 0){
      for(i = 0; i < n; i++){
    2d60:	83 c2 01             	add    $0x1,%edx
        if((buf[i] & 0xff) != (seq++ & 0xff)){
    2d63:	83 c3 01             	add    $0x1,%ebx
  } else if(pid > 0){
    close(fds[1]);
    total = 0;
    cc = 1;
    while((n = read(fds[0], buf, cc)) > 0){
      for(i = 0; i < n; i++){
    2d66:	39 d0                	cmp    %edx,%eax
    2d68:	7f ee                	jg     2d58 <pipe1+0x68>
          printf(1, "pipe1 oops 2\n");
          return;
        }
      }
      total += n;
      cc = cc * 2;
    2d6a:	01 f6                	add    %esi,%esi
      if(cc > sizeof(buf))
    2d6c:	ba 00 20 00 00       	mov    $0x2000,%edx
    2d71:	81 fe 01 20 00 00    	cmp    $0x2001,%esi
    2d77:	0f 43 f2             	cmovae %edx,%esi
        if((buf[i] & 0xff) != (seq++ & 0xff)){
          printf(1, "pipe1 oops 2\n");
          return;
        }
      }
      total += n;
    2d7a:	01 c7                	add    %eax,%edi
    2d7c:	eb b6                	jmp    2d34 <pipe1+0x44>
    total = 0;
    cc = 1;
    while((n = read(fds[0], buf, cc)) > 0){
      for(i = 0; i < n; i++){
        if((buf[i] & 0xff) != (seq++ & 0xff)){
          printf(1, "pipe1 oops 2\n");
    2d7e:	c7 44 24 04 b3 5b 00 	movl   $0x5bb3,0x4(%esp)
    2d85:	00 
    2d86:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2d8d:	e8 6e 23 00 00       	call   5100 <printf>
  } else {
    printf(1, "fork() failed\n");
    exit(0);
  }
  printf(1, "pipe1 ok\n");
}
    2d92:	83 c4 2c             	add    $0x2c,%esp
    2d95:	5b                   	pop    %ebx
    2d96:	5e                   	pop    %esi
    2d97:	5f                   	pop    %edi
    2d98:	5d                   	pop    %ebp
    2d99:	c3                   	ret    
    exit(0);
  }
  pid = fork();
  seq = 0;
  if(pid == 0){
    close(fds[0]);
    2d9a:	8b 45 e0             	mov    -0x20(%ebp),%eax
    2d9d:	31 db                	xor    %ebx,%ebx
    2d9f:	89 04 24             	mov    %eax,(%esp)
    2da2:	e8 29 22 00 00       	call   4fd0 <close>
    for(n = 0; n < 5; n++){
    2da7:	31 c0                	xor    %eax,%eax
    2da9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      for(i = 0; i < 1033; i++)
        buf[i] = seq++;
    2db0:	8d 14 18             	lea    (%eax,%ebx,1),%edx
    2db3:	88 90 20 94 00 00    	mov    %dl,0x9420(%eax)
  pid = fork();
  seq = 0;
  if(pid == 0){
    close(fds[0]);
    for(n = 0; n < 5; n++){
      for(i = 0; i < 1033; i++)
    2db9:	83 c0 01             	add    $0x1,%eax
    2dbc:	3d 09 04 00 00       	cmp    $0x409,%eax
    2dc1:	75 ed                	jne    2db0 <pipe1+0xc0>
        buf[i] = seq++;
      if(write(fds[1], buf, 1033) != 1033){
    2dc3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  pid = fork();
  seq = 0;
  if(pid == 0){
    close(fds[0]);
    for(n = 0; n < 5; n++){
      for(i = 0; i < 1033; i++)
    2dc6:	81 c3 09 04 00 00    	add    $0x409,%ebx
        buf[i] = seq++;
      if(write(fds[1], buf, 1033) != 1033){
    2dcc:	c7 44 24 08 09 04 00 	movl   $0x409,0x8(%esp)
    2dd3:	00 
    2dd4:	c7 44 24 04 20 94 00 	movl   $0x9420,0x4(%esp)
    2ddb:	00 
    2ddc:	89 04 24             	mov    %eax,(%esp)
    2ddf:	e8 e4 21 00 00       	call   4fc8 <write>
    2de4:	3d 09 04 00 00       	cmp    $0x409,%eax
    2de9:	0f 85 a6 00 00 00    	jne    2e95 <pipe1+0x1a5>
  }
  pid = fork();
  seq = 0;
  if(pid == 0){
    close(fds[0]);
    for(n = 0; n < 5; n++){
    2def:	81 fb 2d 14 00 00    	cmp    $0x142d,%ebx
    2df5:	75 b0                	jne    2da7 <pipe1+0xb7>
      if(cc > sizeof(buf))
        cc = sizeof(buf);
    }
    if(total != 5 * 1033){
      printf(1, "pipe1 oops 3 total %d\n", total);
      exit(0);
    2df7:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2dfe:	e8 a5 21 00 00       	call   4fa8 <exit>
      total += n;
      cc = cc * 2;
      if(cc > sizeof(buf))
        cc = sizeof(buf);
    }
    if(total != 5 * 1033){
    2e03:	81 ff 2d 14 00 00    	cmp    $0x142d,%edi
    2e09:	75 30                	jne    2e3b <pipe1+0x14b>
      printf(1, "pipe1 oops 3 total %d\n", total);
      exit(0);
    }
    close(fds[0]);
    2e0b:	8b 45 e0             	mov    -0x20(%ebp),%eax
    2e0e:	89 04 24             	mov    %eax,(%esp)
    2e11:	e8 ba 21 00 00       	call   4fd0 <close>
    wait(&exit_status);
    2e16:	c7 04 24 e0 6c 00 00 	movl   $0x6ce0,(%esp)
    2e1d:	e8 8e 21 00 00       	call   4fb0 <wait>
  } else {
    printf(1, "fork() failed\n");
    exit(0);
  }
  printf(1, "pipe1 ok\n");
    2e22:	c7 44 24 04 d8 5b 00 	movl   $0x5bd8,0x4(%esp)
    2e29:	00 
    2e2a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2e31:	e8 ca 22 00 00       	call   5100 <printf>
    2e36:	e9 57 ff ff ff       	jmp    2d92 <pipe1+0xa2>
      cc = cc * 2;
      if(cc > sizeof(buf))
        cc = sizeof(buf);
    }
    if(total != 5 * 1033){
      printf(1, "pipe1 oops 3 total %d\n", total);
    2e3b:	89 7c 24 08          	mov    %edi,0x8(%esp)
    2e3f:	c7 44 24 04 c1 5b 00 	movl   $0x5bc1,0x4(%esp)
    2e46:	00 
    2e47:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2e4e:	e8 ad 22 00 00       	call   5100 <printf>
    2e53:	eb a2                	jmp    2df7 <pipe1+0x107>
{
  int fds[2], pid;
  int seq, i, n, cc, total;

  if(pipe(fds) != 0){
    printf(1, "pipe() failed\n");
    2e55:	c7 44 24 04 1e 5b 00 	movl   $0x5b1e,0x4(%esp)
    2e5c:	00 
    2e5d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2e64:	e8 97 22 00 00       	call   5100 <printf>
    exit(0);
    2e69:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2e70:	e8 33 21 00 00       	call   4fa8 <exit>
      exit(0);
    }
    close(fds[0]);
    wait(&exit_status);
  } else {
    printf(1, "fork() failed\n");
    2e75:	c7 44 24 04 e2 5b 00 	movl   $0x5be2,0x4(%esp)
    2e7c:	00 
    2e7d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2e84:	e8 77 22 00 00       	call   5100 <printf>
    exit(0);
    2e89:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2e90:	e8 13 21 00 00       	call   4fa8 <exit>
    close(fds[0]);
    for(n = 0; n < 5; n++){
      for(i = 0; i < 1033; i++)
        buf[i] = seq++;
      if(write(fds[1], buf, 1033) != 1033){
        printf(1, "pipe1 oops 1\n");
    2e95:	c7 44 24 04 a5 5b 00 	movl   $0x5ba5,0x4(%esp)
    2e9c:	00 
    2e9d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2ea4:	e8 57 22 00 00       	call   5100 <printf>
        exit(0);
    2ea9:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2eb0:	e8 f3 20 00 00       	call   4fa8 <exit>
    2eb5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    2eb9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00002ec0 <fourteen>:
  printf(1, "bigfile test ok\n");
}

void
fourteen(void)
{
    2ec0:	55                   	push   %ebp
    2ec1:	89 e5                	mov    %esp,%ebp
    2ec3:	83 ec 18             	sub    $0x18,%esp
  int fd;

  // DIRSIZ is 14.
  printf(1, "fourteen test\n");
    2ec6:	c7 44 24 04 f1 5b 00 	movl   $0x5bf1,0x4(%esp)
    2ecd:	00 
    2ece:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2ed5:	e8 26 22 00 00       	call   5100 <printf>

  if(mkdir("12345678901234") != 0){
    2eda:	c7 04 24 2c 5c 00 00 	movl   $0x5c2c,(%esp)
    2ee1:	e8 2a 21 00 00       	call   5010 <mkdir>
    2ee6:	85 c0                	test   %eax,%eax
    2ee8:	0f 85 92 00 00 00    	jne    2f80 <fourteen+0xc0>
    printf(1, "mkdir 12345678901234 failed\n");
    exit(0);
  }
  if(mkdir("12345678901234/123456789012345") != 0){
    2eee:	c7 04 24 f0 67 00 00 	movl   $0x67f0,(%esp)
    2ef5:	e8 16 21 00 00       	call   5010 <mkdir>
    2efa:	85 c0                	test   %eax,%eax
    2efc:	0f 85 1e 01 00 00    	jne    3020 <fourteen+0x160>
    printf(1, "mkdir 12345678901234/123456789012345 failed\n");
    exit(0);
  }
  fd = open("123456789012345/123456789012345/123456789012345", O_CREATE);
    2f02:	c7 44 24 04 00 02 00 	movl   $0x200,0x4(%esp)
    2f09:	00 
    2f0a:	c7 04 24 40 68 00 00 	movl   $0x6840,(%esp)
    2f11:	e8 d2 20 00 00       	call   4fe8 <open>
  if(fd < 0){
    2f16:	85 c0                	test   %eax,%eax
    2f18:	0f 88 e2 00 00 00    	js     3000 <fourteen+0x140>
    printf(1, "create 123456789012345/123456789012345/123456789012345 failed\n");
    exit(0);
  }
  close(fd);
    2f1e:	89 04 24             	mov    %eax,(%esp)
    2f21:	e8 aa 20 00 00       	call   4fd0 <close>
  fd = open("12345678901234/12345678901234/12345678901234", 0);
    2f26:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    2f2d:	00 
    2f2e:	c7 04 24 b0 68 00 00 	movl   $0x68b0,(%esp)
    2f35:	e8 ae 20 00 00       	call   4fe8 <open>
  if(fd < 0){
    2f3a:	85 c0                	test   %eax,%eax
    2f3c:	0f 88 9e 00 00 00    	js     2fe0 <fourteen+0x120>
    printf(1, "open 12345678901234/12345678901234/12345678901234 failed\n");
    exit(0);
  }
  close(fd);
    2f42:	89 04 24             	mov    %eax,(%esp)
    2f45:	e8 86 20 00 00       	call   4fd0 <close>

  if(mkdir("12345678901234/12345678901234") == 0){
    2f4a:	c7 04 24 1d 5c 00 00 	movl   $0x5c1d,(%esp)
    2f51:	e8 ba 20 00 00       	call   5010 <mkdir>
    2f56:	85 c0                	test   %eax,%eax
    2f58:	74 66                	je     2fc0 <fourteen+0x100>
    printf(1, "mkdir 12345678901234/12345678901234 succeeded!\n");
    exit(0);
  }
  if(mkdir("123456789012345/12345678901234") == 0){
    2f5a:	c7 04 24 4c 69 00 00 	movl   $0x694c,(%esp)
    2f61:	e8 aa 20 00 00       	call   5010 <mkdir>
    2f66:	85 c0                	test   %eax,%eax
    2f68:	74 36                	je     2fa0 <fourteen+0xe0>
    printf(1, "mkdir 12345678901234/123456789012345 succeeded!\n");
    exit(0);
  }

  printf(1, "fourteen ok\n");
    2f6a:	c7 44 24 04 3b 5c 00 	movl   $0x5c3b,0x4(%esp)
    2f71:	00 
    2f72:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2f79:	e8 82 21 00 00       	call   5100 <printf>
}
    2f7e:	c9                   	leave  
    2f7f:	c3                   	ret    

  // DIRSIZ is 14.
  printf(1, "fourteen test\n");

  if(mkdir("12345678901234") != 0){
    printf(1, "mkdir 12345678901234 failed\n");
    2f80:	c7 44 24 04 00 5c 00 	movl   $0x5c00,0x4(%esp)
    2f87:	00 
    2f88:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2f8f:	e8 6c 21 00 00       	call   5100 <printf>
    exit(0);
    2f94:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2f9b:	e8 08 20 00 00       	call   4fa8 <exit>
  if(mkdir("12345678901234/12345678901234") == 0){
    printf(1, "mkdir 12345678901234/12345678901234 succeeded!\n");
    exit(0);
  }
  if(mkdir("123456789012345/12345678901234") == 0){
    printf(1, "mkdir 12345678901234/123456789012345 succeeded!\n");
    2fa0:	c7 44 24 04 6c 69 00 	movl   $0x696c,0x4(%esp)
    2fa7:	00 
    2fa8:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2faf:	e8 4c 21 00 00       	call   5100 <printf>
    exit(0);
    2fb4:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2fbb:	e8 e8 1f 00 00       	call   4fa8 <exit>
    exit(0);
  }
  close(fd);

  if(mkdir("12345678901234/12345678901234") == 0){
    printf(1, "mkdir 12345678901234/12345678901234 succeeded!\n");
    2fc0:	c7 44 24 04 1c 69 00 	movl   $0x691c,0x4(%esp)
    2fc7:	00 
    2fc8:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2fcf:	e8 2c 21 00 00       	call   5100 <printf>
    exit(0);
    2fd4:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2fdb:	e8 c8 1f 00 00       	call   4fa8 <exit>
    exit(0);
  }
  close(fd);
  fd = open("12345678901234/12345678901234/12345678901234", 0);
  if(fd < 0){
    printf(1, "open 12345678901234/12345678901234/12345678901234 failed\n");
    2fe0:	c7 44 24 04 e0 68 00 	movl   $0x68e0,0x4(%esp)
    2fe7:	00 
    2fe8:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2fef:	e8 0c 21 00 00       	call   5100 <printf>
    exit(0);
    2ff4:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2ffb:	e8 a8 1f 00 00       	call   4fa8 <exit>
    printf(1, "mkdir 12345678901234/123456789012345 failed\n");
    exit(0);
  }
  fd = open("123456789012345/123456789012345/123456789012345", O_CREATE);
  if(fd < 0){
    printf(1, "create 123456789012345/123456789012345/123456789012345 failed\n");
    3000:	c7 44 24 04 70 68 00 	movl   $0x6870,0x4(%esp)
    3007:	00 
    3008:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    300f:	e8 ec 20 00 00       	call   5100 <printf>
    exit(0);
    3014:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    301b:	e8 88 1f 00 00       	call   4fa8 <exit>
  if(mkdir("12345678901234") != 0){
    printf(1, "mkdir 12345678901234 failed\n");
    exit(0);
  }
  if(mkdir("12345678901234/123456789012345") != 0){
    printf(1, "mkdir 12345678901234/123456789012345 failed\n");
    3020:	c7 44 24 04 10 68 00 	movl   $0x6810,0x4(%esp)
    3027:	00 
    3028:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    302f:	e8 cc 20 00 00       	call   5100 <printf>
    exit(0);
    3034:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    303b:	e8 68 1f 00 00       	call   4fa8 <exit>

00003040 <openiputtest>:
//      for(i = 0; i < 10000; i++)
//        yield();
//    }
void
openiputtest(void)
{
    3040:	55                   	push   %ebp
    3041:	89 e5                	mov    %esp,%ebp
    3043:	83 ec 18             	sub    $0x18,%esp
  int pid;

  printf(stdout, "openiput test\n");
    3046:	a1 2c 6c 00 00       	mov    0x6c2c,%eax
    304b:	c7 44 24 04 48 5c 00 	movl   $0x5c48,0x4(%esp)
    3052:	00 
    3053:	89 04 24             	mov    %eax,(%esp)
    3056:	e8 a5 20 00 00       	call   5100 <printf>
  if(mkdir("oidir") < 0){
    305b:	c7 04 24 57 5c 00 00 	movl   $0x5c57,(%esp)
    3062:	e8 a9 1f 00 00       	call   5010 <mkdir>
    3067:	85 c0                	test   %eax,%eax
    3069:	0f 88 90 00 00 00    	js     30ff <openiputtest+0xbf>
    printf(stdout, "mkdir oidir failed\n");
    exit(0);
  }
  pid = fork();
    306f:	e8 2c 1f 00 00       	call   4fa0 <fork>
  if(pid < 0){
    3074:	83 f8 00             	cmp    $0x0,%eax
    3077:	0f 8c a7 00 00 00    	jl     3124 <openiputtest+0xe4>
    307d:	8d 76 00             	lea    0x0(%esi),%esi
    printf(stdout, "fork failed\n");
    exit(0);
  }
  if(pid == 0){
    3080:	75 3e                	jne    30c0 <openiputtest+0x80>
    int fd = open("oidir", O_RDWR);
    3082:	c7 44 24 04 02 00 00 	movl   $0x2,0x4(%esp)
    3089:	00 
    308a:	c7 04 24 57 5c 00 00 	movl   $0x5c57,(%esp)
    3091:	e8 52 1f 00 00       	call   4fe8 <open>
    if(fd >= 0){
    3096:	85 c0                	test   %eax,%eax
    3098:	78 7e                	js     3118 <openiputtest+0xd8>
      printf(stdout, "open directory for write succeeded\n");
    309a:	a1 2c 6c 00 00       	mov    0x6c2c,%eax
    309f:	c7 44 24 04 a0 69 00 	movl   $0x69a0,0x4(%esp)
    30a6:	00 
    30a7:	89 04 24             	mov    %eax,(%esp)
    30aa:	e8 51 20 00 00       	call   5100 <printf>
      exit(0);
    30af:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    30b6:	e8 ed 1e 00 00       	call   4fa8 <exit>
    30bb:	90                   	nop
    30bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    }
    exit(0);
  }
  sleep(1);
    30c0:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    30c7:	e8 6c 1f 00 00       	call   5038 <sleep>
  if(unlink("oidir") != 0){
    30cc:	c7 04 24 57 5c 00 00 	movl   $0x5c57,(%esp)
    30d3:	e8 20 1f 00 00       	call   4ff8 <unlink>
    30d8:	85 c0                	test   %eax,%eax
    30da:	75 52                	jne    312e <openiputtest+0xee>
    printf(stdout, "unlink failed\n");
    exit(0);
  }
  wait(&exit_status);
    30dc:	c7 04 24 e0 6c 00 00 	movl   $0x6ce0,(%esp)
    30e3:	e8 c8 1e 00 00       	call   4fb0 <wait>
  printf(stdout, "openiput test ok\n");
    30e8:	a1 2c 6c 00 00       	mov    0x6c2c,%eax
    30ed:	c7 44 24 04 71 5c 00 	movl   $0x5c71,0x4(%esp)
    30f4:	00 
    30f5:	89 04 24             	mov    %eax,(%esp)
    30f8:	e8 03 20 00 00       	call   5100 <printf>
}
    30fd:	c9                   	leave  
    30fe:	c3                   	ret    
{
  int pid;

  printf(stdout, "openiput test\n");
  if(mkdir("oidir") < 0){
    printf(stdout, "mkdir oidir failed\n");
    30ff:	c7 44 24 04 5d 5c 00 	movl   $0x5c5d,0x4(%esp)
    3106:	00 
    exit(0);
  }
  pid = fork();
  if(pid < 0){
    printf(stdout, "fork failed\n");
    3107:	a1 2c 6c 00 00       	mov    0x6c2c,%eax
    310c:	89 04 24             	mov    %eax,(%esp)
    310f:	e8 ec 1f 00 00       	call   5100 <printf>
    3114:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    exit(0);
    3118:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    311f:	e8 84 1e 00 00       	call   4fa8 <exit>
    printf(stdout, "mkdir oidir failed\n");
    exit(0);
  }
  pid = fork();
  if(pid < 0){
    printf(stdout, "fork failed\n");
    3124:	c7 44 24 04 df 58 00 	movl   $0x58df,0x4(%esp)
    312b:	00 
    312c:	eb d9                	jmp    3107 <openiputtest+0xc7>
    }
    exit(0);
  }
  sleep(1);
  if(unlink("oidir") != 0){
    printf(stdout, "unlink failed\n");
    312e:	c7 44 24 04 fe 56 00 	movl   $0x56fe,0x4(%esp)
    3135:	00 
    3136:	eb cf                	jmp    3107 <openiputtest+0xc7>
    3138:	90                   	nop
    3139:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00003140 <iref>:
}

// test that iput() is called at the end of _namei()
void
iref(void)
{
    3140:	55                   	push   %ebp
    3141:	89 e5                	mov    %esp,%ebp
    3143:	53                   	push   %ebx
  int i, fd;

  printf(1, "empty file name\n");
    3144:	31 db                	xor    %ebx,%ebx
}

// test that iput() is called at the end of _namei()
void
iref(void)
{
    3146:	83 ec 14             	sub    $0x14,%esp
  int i, fd;

  printf(1, "empty file name\n");
    3149:	c7 44 24 04 83 5c 00 	movl   $0x5c83,0x4(%esp)
    3150:	00 
    3151:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    3158:	e8 a3 1f 00 00       	call   5100 <printf>
    315d:	8d 76 00             	lea    0x0(%esi),%esi

  // the 50 is NINODE
  for(i = 0; i < 50 + 1; i++){
    if(mkdir("irefd") != 0){
    3160:	c7 04 24 94 5c 00 00 	movl   $0x5c94,(%esp)
    3167:	e8 a4 1e 00 00       	call   5010 <mkdir>
    316c:	85 c0                	test   %eax,%eax
    316e:	0f 85 b2 00 00 00    	jne    3226 <iref+0xe6>
      printf(1, "mkdir irefd failed\n");
      exit(0);
    }
    if(chdir("irefd") != 0){
    3174:	c7 04 24 94 5c 00 00 	movl   $0x5c94,(%esp)
    317b:	e8 98 1e 00 00       	call   5018 <chdir>
    3180:	85 c0                	test   %eax,%eax
    3182:	0f 85 be 00 00 00    	jne    3246 <iref+0x106>
      printf(1, "chdir irefd failed\n");
      exit(0);
    }

    mkdir("");
    3188:	c7 04 24 4d 64 00 00 	movl   $0x644d,(%esp)
    318f:	e8 7c 1e 00 00       	call   5010 <mkdir>
    link("README", "");
    3194:	c7 44 24 04 4d 64 00 	movl   $0x644d,0x4(%esp)
    319b:	00 
    319c:	c7 04 24 c2 5c 00 00 	movl   $0x5cc2,(%esp)
    31a3:	e8 60 1e 00 00       	call   5008 <link>
    fd = open("", O_CREATE);
    31a8:	c7 44 24 04 00 02 00 	movl   $0x200,0x4(%esp)
    31af:	00 
    31b0:	c7 04 24 4d 64 00 00 	movl   $0x644d,(%esp)
    31b7:	e8 2c 1e 00 00       	call   4fe8 <open>
    if(fd >= 0)
    31bc:	85 c0                	test   %eax,%eax
    31be:	78 08                	js     31c8 <iref+0x88>
      close(fd);
    31c0:	89 04 24             	mov    %eax,(%esp)
    31c3:	e8 08 1e 00 00       	call   4fd0 <close>
    fd = open("xx", O_CREATE);
    31c8:	c7 44 24 04 00 02 00 	movl   $0x200,0x4(%esp)
    31cf:	00 
    31d0:	c7 04 24 94 60 00 00 	movl   $0x6094,(%esp)
    31d7:	e8 0c 1e 00 00       	call   4fe8 <open>
    if(fd >= 0)
    31dc:	85 c0                	test   %eax,%eax
    31de:	78 08                	js     31e8 <iref+0xa8>
      close(fd);
    31e0:	89 04 24             	mov    %eax,(%esp)
    31e3:	e8 e8 1d 00 00       	call   4fd0 <close>
  int i, fd;

  printf(1, "empty file name\n");

  // the 50 is NINODE
  for(i = 0; i < 50 + 1; i++){
    31e8:	83 c3 01             	add    $0x1,%ebx
    if(fd >= 0)
      close(fd);
    fd = open("xx", O_CREATE);
    if(fd >= 0)
      close(fd);
    unlink("xx");
    31eb:	c7 04 24 94 60 00 00 	movl   $0x6094,(%esp)
    31f2:	e8 01 1e 00 00       	call   4ff8 <unlink>
  int i, fd;

  printf(1, "empty file name\n");

  // the 50 is NINODE
  for(i = 0; i < 50 + 1; i++){
    31f7:	83 fb 33             	cmp    $0x33,%ebx
    31fa:	0f 85 60 ff ff ff    	jne    3160 <iref+0x20>
    if(fd >= 0)
      close(fd);
    unlink("xx");
  }

  chdir("/");
    3200:	c7 04 24 c9 5c 00 00 	movl   $0x5cc9,(%esp)
    3207:	e8 0c 1e 00 00       	call   5018 <chdir>
  printf(1, "empty file name OK\n");
    320c:	c7 44 24 04 cb 5c 00 	movl   $0x5ccb,0x4(%esp)
    3213:	00 
    3214:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    321b:	e8 e0 1e 00 00       	call   5100 <printf>
}
    3220:	83 c4 14             	add    $0x14,%esp
    3223:	5b                   	pop    %ebx
    3224:	5d                   	pop    %ebp
    3225:	c3                   	ret    
  printf(1, "empty file name\n");

  // the 50 is NINODE
  for(i = 0; i < 50 + 1; i++){
    if(mkdir("irefd") != 0){
      printf(1, "mkdir irefd failed\n");
    3226:	c7 44 24 04 9a 5c 00 	movl   $0x5c9a,0x4(%esp)
    322d:	00 
    322e:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    3235:	e8 c6 1e 00 00       	call   5100 <printf>
      exit(0);
    323a:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3241:	e8 62 1d 00 00       	call   4fa8 <exit>
    }
    if(chdir("irefd") != 0){
      printf(1, "chdir irefd failed\n");
    3246:	c7 44 24 04 ae 5c 00 	movl   $0x5cae,0x4(%esp)
    324d:	00 
    324e:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    3255:	e8 a6 1e 00 00       	call   5100 <printf>
      exit(0);
    325a:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3261:	e8 42 1d 00 00       	call   4fa8 <exit>
    3266:	8d 76 00             	lea    0x0(%esi),%esi
    3269:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00003270 <dirfile>:
  printf(1, "rmdot ok\n");
}

void
dirfile(void)
{
    3270:	55                   	push   %ebp
    3271:	89 e5                	mov    %esp,%ebp
    3273:	53                   	push   %ebx
    3274:	83 ec 14             	sub    $0x14,%esp
  int fd;

  printf(1, "dir vs file\n");
    3277:	c7 44 24 04 df 5c 00 	movl   $0x5cdf,0x4(%esp)
    327e:	00 
    327f:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    3286:	e8 75 1e 00 00       	call   5100 <printf>

  fd = open("dirfile", O_CREATE);
    328b:	c7 44 24 04 00 02 00 	movl   $0x200,0x4(%esp)
    3292:	00 
    3293:	c7 04 24 ec 5c 00 00 	movl   $0x5cec,(%esp)
    329a:	e8 49 1d 00 00       	call   4fe8 <open>
  if(fd < 0){
    329f:	85 c0                	test   %eax,%eax
    32a1:	0f 88 60 01 00 00    	js     3407 <dirfile+0x197>
    printf(1, "create dirfile failed\n");
    exit(0);
  }
  close(fd);
    32a7:	89 04 24             	mov    %eax,(%esp)
    32aa:	e8 21 1d 00 00       	call   4fd0 <close>
  if(chdir("dirfile") == 0){
    32af:	c7 04 24 ec 5c 00 00 	movl   $0x5cec,(%esp)
    32b6:	e8 5d 1d 00 00       	call   5018 <chdir>
    32bb:	85 c0                	test   %eax,%eax
    32bd:	0f 84 24 01 00 00    	je     33e7 <dirfile+0x177>
    printf(1, "chdir dirfile succeeded!\n");
    exit(0);
  }
  fd = open("dirfile/xx", 0);
    32c3:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    32ca:	00 
    32cb:	c7 04 24 25 5d 00 00 	movl   $0x5d25,(%esp)
    32d2:	e8 11 1d 00 00       	call   4fe8 <open>
  if(fd >= 0){
    32d7:	85 c0                	test   %eax,%eax
    32d9:	0f 89 e8 00 00 00    	jns    33c7 <dirfile+0x157>
    printf(1, "create dirfile/xx succeeded!\n");
    exit(0);
  }
  fd = open("dirfile/xx", O_CREATE);
    32df:	c7 44 24 04 00 02 00 	movl   $0x200,0x4(%esp)
    32e6:	00 
    32e7:	c7 04 24 25 5d 00 00 	movl   $0x5d25,(%esp)
    32ee:	e8 f5 1c 00 00       	call   4fe8 <open>
  if(fd >= 0){
    32f3:	85 c0                	test   %eax,%eax
    32f5:	0f 89 cc 00 00 00    	jns    33c7 <dirfile+0x157>
    printf(1, "create dirfile/xx succeeded!\n");
    exit(0);
  }
  if(mkdir("dirfile/xx") == 0){
    32fb:	c7 04 24 25 5d 00 00 	movl   $0x5d25,(%esp)
    3302:	e8 09 1d 00 00       	call   5010 <mkdir>
    3307:	85 c0                	test   %eax,%eax
    3309:	0f 84 b8 01 00 00    	je     34c7 <dirfile+0x257>
    printf(1, "mkdir dirfile/xx succeeded!\n");
    exit(0);
  }
  if(unlink("dirfile/xx") == 0){
    330f:	c7 04 24 25 5d 00 00 	movl   $0x5d25,(%esp)
    3316:	e8 dd 1c 00 00       	call   4ff8 <unlink>
    331b:	85 c0                	test   %eax,%eax
    331d:	0f 84 84 01 00 00    	je     34a7 <dirfile+0x237>
    printf(1, "unlink dirfile/xx succeeded!\n");
    exit(0);
  }
  if(link("README", "dirfile/xx") == 0){
    3323:	c7 44 24 04 25 5d 00 	movl   $0x5d25,0x4(%esp)
    332a:	00 
    332b:	c7 04 24 c2 5c 00 00 	movl   $0x5cc2,(%esp)
    3332:	e8 d1 1c 00 00       	call   5008 <link>
    3337:	85 c0                	test   %eax,%eax
    3339:	0f 84 48 01 00 00    	je     3487 <dirfile+0x217>
    printf(1, "link to dirfile/xx succeeded!\n");
    exit(0);
  }
  if(unlink("dirfile") != 0){
    333f:	c7 04 24 ec 5c 00 00 	movl   $0x5cec,(%esp)
    3346:	e8 ad 1c 00 00       	call   4ff8 <unlink>
    334b:	85 c0                	test   %eax,%eax
    334d:	0f 85 14 01 00 00    	jne    3467 <dirfile+0x1f7>
    printf(1, "unlink dirfile failed!\n");
    exit(0);
  }

  fd = open(".", O_RDWR);
    3353:	c7 44 24 04 02 00 00 	movl   $0x2,0x4(%esp)
    335a:	00 
    335b:	c7 04 24 b2 5f 00 00 	movl   $0x5fb2,(%esp)
    3362:	e8 81 1c 00 00       	call   4fe8 <open>
  if(fd >= 0){
    3367:	85 c0                	test   %eax,%eax
    3369:	0f 89 d8 00 00 00    	jns    3447 <dirfile+0x1d7>
    printf(1, "open . for writing succeeded!\n");
    exit(0);
  }
  fd = open(".", 0);
    336f:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    3376:	00 
    3377:	c7 04 24 b2 5f 00 00 	movl   $0x5fb2,(%esp)
    337e:	e8 65 1c 00 00       	call   4fe8 <open>
  if(write(fd, "x", 1) > 0){
    3383:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    338a:	00 
    338b:	c7 44 24 04 95 60 00 	movl   $0x6095,0x4(%esp)
    3392:	00 
  fd = open(".", O_RDWR);
  if(fd >= 0){
    printf(1, "open . for writing succeeded!\n");
    exit(0);
  }
  fd = open(".", 0);
    3393:	89 c3                	mov    %eax,%ebx
  if(write(fd, "x", 1) > 0){
    3395:	89 04 24             	mov    %eax,(%esp)
    3398:	e8 2b 1c 00 00       	call   4fc8 <write>
    339d:	85 c0                	test   %eax,%eax
    339f:	0f 8f 82 00 00 00    	jg     3427 <dirfile+0x1b7>
    printf(1, "write . succeeded!\n");
    exit(0);
  }
  close(fd);
    33a5:	89 1c 24             	mov    %ebx,(%esp)
    33a8:	e8 23 1c 00 00       	call   4fd0 <close>

  printf(1, "dir vs file OK\n");
    33ad:	c7 44 24 04 b5 5d 00 	movl   $0x5db5,0x4(%esp)
    33b4:	00 
    33b5:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    33bc:	e8 3f 1d 00 00       	call   5100 <printf>
}
    33c1:	83 c4 14             	add    $0x14,%esp
    33c4:	5b                   	pop    %ebx
    33c5:	5d                   	pop    %ebp
    33c6:	c3                   	ret    
    printf(1, "create dirfile/xx succeeded!\n");
    exit(0);
  }
  fd = open("dirfile/xx", O_CREATE);
  if(fd >= 0){
    printf(1, "create dirfile/xx succeeded!\n");
    33c7:	c7 44 24 04 30 5d 00 	movl   $0x5d30,0x4(%esp)
    33ce:	00 
    33cf:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    33d6:	e8 25 1d 00 00       	call   5100 <printf>
    exit(0);
    33db:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    33e2:	e8 c1 1b 00 00       	call   4fa8 <exit>
    printf(1, "create dirfile failed\n");
    exit(0);
  }
  close(fd);
  if(chdir("dirfile") == 0){
    printf(1, "chdir dirfile succeeded!\n");
    33e7:	c7 44 24 04 0b 5d 00 	movl   $0x5d0b,0x4(%esp)
    33ee:	00 
    33ef:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    33f6:	e8 05 1d 00 00       	call   5100 <printf>
    exit(0);
    33fb:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3402:	e8 a1 1b 00 00       	call   4fa8 <exit>

  printf(1, "dir vs file\n");

  fd = open("dirfile", O_CREATE);
  if(fd < 0){
    printf(1, "create dirfile failed\n");
    3407:	c7 44 24 04 f4 5c 00 	movl   $0x5cf4,0x4(%esp)
    340e:	00 
    340f:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    3416:	e8 e5 1c 00 00       	call   5100 <printf>
    exit(0);
    341b:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3422:	e8 81 1b 00 00       	call   4fa8 <exit>
    printf(1, "open . for writing succeeded!\n");
    exit(0);
  }
  fd = open(".", 0);
  if(write(fd, "x", 1) > 0){
    printf(1, "write . succeeded!\n");
    3427:	c7 44 24 04 a1 5d 00 	movl   $0x5da1,0x4(%esp)
    342e:	00 
    342f:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    3436:	e8 c5 1c 00 00       	call   5100 <printf>
    exit(0);
    343b:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3442:	e8 61 1b 00 00       	call   4fa8 <exit>
    exit(0);
  }

  fd = open(".", O_RDWR);
  if(fd >= 0){
    printf(1, "open . for writing succeeded!\n");
    3447:	c7 44 24 04 e4 69 00 	movl   $0x69e4,0x4(%esp)
    344e:	00 
    344f:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    3456:	e8 a5 1c 00 00       	call   5100 <printf>
    exit(0);
    345b:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3462:	e8 41 1b 00 00       	call   4fa8 <exit>
  if(link("README", "dirfile/xx") == 0){
    printf(1, "link to dirfile/xx succeeded!\n");
    exit(0);
  }
  if(unlink("dirfile") != 0){
    printf(1, "unlink dirfile failed!\n");
    3467:	c7 44 24 04 89 5d 00 	movl   $0x5d89,0x4(%esp)
    346e:	00 
    346f:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    3476:	e8 85 1c 00 00       	call   5100 <printf>
    exit(0);
    347b:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3482:	e8 21 1b 00 00       	call   4fa8 <exit>
  if(unlink("dirfile/xx") == 0){
    printf(1, "unlink dirfile/xx succeeded!\n");
    exit(0);
  }
  if(link("README", "dirfile/xx") == 0){
    printf(1, "link to dirfile/xx succeeded!\n");
    3487:	c7 44 24 04 c4 69 00 	movl   $0x69c4,0x4(%esp)
    348e:	00 
    348f:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    3496:	e8 65 1c 00 00       	call   5100 <printf>
    exit(0);
    349b:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    34a2:	e8 01 1b 00 00       	call   4fa8 <exit>
  if(mkdir("dirfile/xx") == 0){
    printf(1, "mkdir dirfile/xx succeeded!\n");
    exit(0);
  }
  if(unlink("dirfile/xx") == 0){
    printf(1, "unlink dirfile/xx succeeded!\n");
    34a7:	c7 44 24 04 6b 5d 00 	movl   $0x5d6b,0x4(%esp)
    34ae:	00 
    34af:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    34b6:	e8 45 1c 00 00       	call   5100 <printf>
    exit(0);
    34bb:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    34c2:	e8 e1 1a 00 00       	call   4fa8 <exit>
  if(fd >= 0){
    printf(1, "create dirfile/xx succeeded!\n");
    exit(0);
  }
  if(mkdir("dirfile/xx") == 0){
    printf(1, "mkdir dirfile/xx succeeded!\n");
    34c7:	c7 44 24 04 4e 5d 00 	movl   $0x5d4e,0x4(%esp)
    34ce:	00 
    34cf:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    34d6:	e8 25 1c 00 00       	call   5100 <printf>
    exit(0);
    34db:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    34e2:	e8 c1 1a 00 00       	call   4fa8 <exit>
    34e7:	89 f6                	mov    %esi,%esi
    34e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000034f0 <rmdot>:
  printf(1, "fourteen ok\n");
}

void
rmdot(void)
{
    34f0:	55                   	push   %ebp
    34f1:	89 e5                	mov    %esp,%ebp
    34f3:	83 ec 18             	sub    $0x18,%esp
  printf(1, "rmdot test\n");
    34f6:	c7 44 24 04 c5 5d 00 	movl   $0x5dc5,0x4(%esp)
    34fd:	00 
    34fe:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    3505:	e8 f6 1b 00 00       	call   5100 <printf>
  if(mkdir("dots") != 0){
    350a:	c7 04 24 d1 5d 00 00 	movl   $0x5dd1,(%esp)
    3511:	e8 fa 1a 00 00       	call   5010 <mkdir>
    3516:	85 c0                	test   %eax,%eax
    3518:	0f 85 9a 00 00 00    	jne    35b8 <rmdot+0xc8>
    printf(1, "mkdir dots failed\n");
    exit(0);
  }
  if(chdir("dots") != 0){
    351e:	c7 04 24 d1 5d 00 00 	movl   $0x5dd1,(%esp)
    3525:	e8 ee 1a 00 00       	call   5018 <chdir>
    352a:	85 c0                	test   %eax,%eax
    352c:	0f 85 66 01 00 00    	jne    3698 <rmdot+0x1a8>
    printf(1, "chdir dots failed\n");
    exit(0);
  }
  if(unlink(".") == 0){
    3532:	c7 04 24 b2 5f 00 00 	movl   $0x5fb2,(%esp)
    3539:	e8 ba 1a 00 00       	call   4ff8 <unlink>
    353e:	85 c0                	test   %eax,%eax
    3540:	0f 84 32 01 00 00    	je     3678 <rmdot+0x188>
    printf(1, "rm . worked!\n");
    exit(0);
  }
  if(unlink("..") == 0){
    3546:	c7 04 24 b1 5f 00 00 	movl   $0x5fb1,(%esp)
    354d:	e8 a6 1a 00 00       	call   4ff8 <unlink>
    3552:	85 c0                	test   %eax,%eax
    3554:	0f 84 fe 00 00 00    	je     3658 <rmdot+0x168>
    printf(1, "rm .. worked!\n");
    exit(0);
  }
  if(chdir("/") != 0){
    355a:	c7 04 24 c9 5c 00 00 	movl   $0x5cc9,(%esp)
    3561:	e8 b2 1a 00 00       	call   5018 <chdir>
    3566:	85 c0                	test   %eax,%eax
    3568:	0f 85 ca 00 00 00    	jne    3638 <rmdot+0x148>
    printf(1, "chdir / failed\n");
    exit(0);
  }
  if(unlink("dots/.") == 0){
    356e:	c7 04 24 29 5e 00 00 	movl   $0x5e29,(%esp)
    3575:	e8 7e 1a 00 00       	call   4ff8 <unlink>
    357a:	85 c0                	test   %eax,%eax
    357c:	0f 84 96 00 00 00    	je     3618 <rmdot+0x128>
    printf(1, "unlink dots/. worked!\n");
    exit(0);
  }
  if(unlink("dots/..") == 0){
    3582:	c7 04 24 47 5e 00 00 	movl   $0x5e47,(%esp)
    3589:	e8 6a 1a 00 00       	call   4ff8 <unlink>
    358e:	85 c0                	test   %eax,%eax
    3590:	74 66                	je     35f8 <rmdot+0x108>
    printf(1, "unlink dots/.. worked!\n");
    exit(0);
  }
  if(unlink("dots") != 0){
    3592:	c7 04 24 d1 5d 00 00 	movl   $0x5dd1,(%esp)
    3599:	e8 5a 1a 00 00       	call   4ff8 <unlink>
    359e:	85 c0                	test   %eax,%eax
    35a0:	75 36                	jne    35d8 <rmdot+0xe8>
    printf(1, "unlink dots failed!\n");
    exit(0);
  }
  printf(1, "rmdot ok\n");
    35a2:	c7 44 24 04 7c 5e 00 	movl   $0x5e7c,0x4(%esp)
    35a9:	00 
    35aa:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    35b1:	e8 4a 1b 00 00       	call   5100 <printf>
}
    35b6:	c9                   	leave  
    35b7:	c3                   	ret    
void
rmdot(void)
{
  printf(1, "rmdot test\n");
  if(mkdir("dots") != 0){
    printf(1, "mkdir dots failed\n");
    35b8:	c7 44 24 04 d6 5d 00 	movl   $0x5dd6,0x4(%esp)
    35bf:	00 
    35c0:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    35c7:	e8 34 1b 00 00       	call   5100 <printf>
    exit(0);
    35cc:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    35d3:	e8 d0 19 00 00       	call   4fa8 <exit>
  if(unlink("dots/..") == 0){
    printf(1, "unlink dots/.. worked!\n");
    exit(0);
  }
  if(unlink("dots") != 0){
    printf(1, "unlink dots failed!\n");
    35d8:	c7 44 24 04 67 5e 00 	movl   $0x5e67,0x4(%esp)
    35df:	00 
    35e0:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    35e7:	e8 14 1b 00 00       	call   5100 <printf>
    exit(0);
    35ec:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    35f3:	e8 b0 19 00 00       	call   4fa8 <exit>
  if(unlink("dots/.") == 0){
    printf(1, "unlink dots/. worked!\n");
    exit(0);
  }
  if(unlink("dots/..") == 0){
    printf(1, "unlink dots/.. worked!\n");
    35f8:	c7 44 24 04 4f 5e 00 	movl   $0x5e4f,0x4(%esp)
    35ff:	00 
    3600:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    3607:	e8 f4 1a 00 00       	call   5100 <printf>
    exit(0);
    360c:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3613:	e8 90 19 00 00       	call   4fa8 <exit>
  if(chdir("/") != 0){
    printf(1, "chdir / failed\n");
    exit(0);
  }
  if(unlink("dots/.") == 0){
    printf(1, "unlink dots/. worked!\n");
    3618:	c7 44 24 04 30 5e 00 	movl   $0x5e30,0x4(%esp)
    361f:	00 
    3620:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    3627:	e8 d4 1a 00 00       	call   5100 <printf>
    exit(0);
    362c:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3633:	e8 70 19 00 00       	call   4fa8 <exit>
  if(unlink("..") == 0){
    printf(1, "rm .. worked!\n");
    exit(0);
  }
  if(chdir("/") != 0){
    printf(1, "chdir / failed\n");
    3638:	c7 44 24 04 19 5e 00 	movl   $0x5e19,0x4(%esp)
    363f:	00 
    3640:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    3647:	e8 b4 1a 00 00       	call   5100 <printf>
    exit(0);
    364c:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3653:	e8 50 19 00 00       	call   4fa8 <exit>
  if(unlink(".") == 0){
    printf(1, "rm . worked!\n");
    exit(0);
  }
  if(unlink("..") == 0){
    printf(1, "rm .. worked!\n");
    3658:	c7 44 24 04 0a 5e 00 	movl   $0x5e0a,0x4(%esp)
    365f:	00 
    3660:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    3667:	e8 94 1a 00 00       	call   5100 <printf>
    exit(0);
    366c:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3673:	e8 30 19 00 00       	call   4fa8 <exit>
  if(chdir("dots") != 0){
    printf(1, "chdir dots failed\n");
    exit(0);
  }
  if(unlink(".") == 0){
    printf(1, "rm . worked!\n");
    3678:	c7 44 24 04 fc 5d 00 	movl   $0x5dfc,0x4(%esp)
    367f:	00 
    3680:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    3687:	e8 74 1a 00 00       	call   5100 <printf>
    exit(0);
    368c:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3693:	e8 10 19 00 00       	call   4fa8 <exit>
  if(mkdir("dots") != 0){
    printf(1, "mkdir dots failed\n");
    exit(0);
  }
  if(chdir("dots") != 0){
    printf(1, "chdir dots failed\n");
    3698:	c7 44 24 04 e9 5d 00 	movl   $0x5de9,0x4(%esp)
    369f:	00 
    36a0:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    36a7:	e8 54 1a 00 00       	call   5100 <printf>
    exit(0);
    36ac:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    36b3:	e8 f0 18 00 00       	call   4fa8 <exit>
    36b8:	90                   	nop
    36b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000036c0 <subdir>:
  printf(1, "bigdir ok\n");
}

void
subdir(void)
{
    36c0:	55                   	push   %ebp
    36c1:	89 e5                	mov    %esp,%ebp
    36c3:	53                   	push   %ebx
    36c4:	83 ec 14             	sub    $0x14,%esp
  int fd, cc;

  printf(1, "subdir test\n");
    36c7:	c7 44 24 04 86 5e 00 	movl   $0x5e86,0x4(%esp)
    36ce:	00 
    36cf:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    36d6:	e8 25 1a 00 00       	call   5100 <printf>

  unlink("ff");
    36db:	c7 04 24 0f 5f 00 00 	movl   $0x5f0f,(%esp)
    36e2:	e8 11 19 00 00       	call   4ff8 <unlink>
  if(mkdir("dd") != 0){
    36e7:	c7 04 24 ac 5f 00 00 	movl   $0x5fac,(%esp)
    36ee:	e8 1d 19 00 00       	call   5010 <mkdir>
    36f3:	85 c0                	test   %eax,%eax
    36f5:	0f 85 a1 06 00 00    	jne    3d9c <subdir+0x6dc>
    printf(1, "subdir mkdir dd failed\n");
    exit(0);
  }

  fd = open("dd/ff", O_CREATE | O_RDWR);
    36fb:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
    3702:	00 
    3703:	c7 04 24 e5 5e 00 00 	movl   $0x5ee5,(%esp)
    370a:	e8 d9 18 00 00       	call   4fe8 <open>
  if(fd < 0){
    370f:	85 c0                	test   %eax,%eax
  if(mkdir("dd") != 0){
    printf(1, "subdir mkdir dd failed\n");
    exit(0);
  }

  fd = open("dd/ff", O_CREATE | O_RDWR);
    3711:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    3713:	0f 88 63 06 00 00    	js     3d7c <subdir+0x6bc>
    printf(1, "create dd/ff failed\n");
    exit(0);
  }
  write(fd, "ff", 2);
    3719:	c7 44 24 08 02 00 00 	movl   $0x2,0x8(%esp)
    3720:	00 
    3721:	c7 44 24 04 0f 5f 00 	movl   $0x5f0f,0x4(%esp)
    3728:	00 
    3729:	89 04 24             	mov    %eax,(%esp)
    372c:	e8 97 18 00 00       	call   4fc8 <write>
  close(fd);
    3731:	89 1c 24             	mov    %ebx,(%esp)
    3734:	e8 97 18 00 00       	call   4fd0 <close>

  if(unlink("dd") >= 0){
    3739:	c7 04 24 ac 5f 00 00 	movl   $0x5fac,(%esp)
    3740:	e8 b3 18 00 00       	call   4ff8 <unlink>
    3745:	85 c0                	test   %eax,%eax
    3747:	0f 89 0f 06 00 00    	jns    3d5c <subdir+0x69c>
    printf(1, "unlink dd (non-empty dir) succeeded!\n");
    exit(0);
  }

  if(mkdir("/dd/dd") != 0){
    374d:	c7 04 24 c0 5e 00 00 	movl   $0x5ec0,(%esp)
    3754:	e8 b7 18 00 00       	call   5010 <mkdir>
    3759:	85 c0                	test   %eax,%eax
    375b:	0f 85 db 05 00 00    	jne    3d3c <subdir+0x67c>
    printf(1, "subdir mkdir dd/dd failed\n");
    exit(0);
  }

  fd = open("dd/dd/ff", O_CREATE | O_RDWR);
    3761:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
    3768:	00 
    3769:	c7 04 24 e2 5e 00 00 	movl   $0x5ee2,(%esp)
    3770:	e8 73 18 00 00       	call   4fe8 <open>
  if(fd < 0){
    3775:	85 c0                	test   %eax,%eax
  if(mkdir("/dd/dd") != 0){
    printf(1, "subdir mkdir dd/dd failed\n");
    exit(0);
  }

  fd = open("dd/dd/ff", O_CREATE | O_RDWR);
    3777:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    3779:	0f 88 5d 04 00 00    	js     3bdc <subdir+0x51c>
    printf(1, "create dd/dd/ff failed\n");
    exit(0);
  }
  write(fd, "FF", 2);
    377f:	c7 44 24 08 02 00 00 	movl   $0x2,0x8(%esp)
    3786:	00 
    3787:	c7 44 24 04 03 5f 00 	movl   $0x5f03,0x4(%esp)
    378e:	00 
    378f:	89 04 24             	mov    %eax,(%esp)
    3792:	e8 31 18 00 00       	call   4fc8 <write>
  close(fd);
    3797:	89 1c 24             	mov    %ebx,(%esp)
    379a:	e8 31 18 00 00       	call   4fd0 <close>

  fd = open("dd/dd/../ff", 0);
    379f:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    37a6:	00 
    37a7:	c7 04 24 06 5f 00 00 	movl   $0x5f06,(%esp)
    37ae:	e8 35 18 00 00       	call   4fe8 <open>
  if(fd < 0){
    37b3:	85 c0                	test   %eax,%eax
    exit(0);
  }
  write(fd, "FF", 2);
  close(fd);

  fd = open("dd/dd/../ff", 0);
    37b5:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    37b7:	0f 88 ff 03 00 00    	js     3bbc <subdir+0x4fc>
    printf(1, "open dd/dd/../ff failed\n");
    exit(0);
  }
  cc = read(fd, buf, sizeof(buf));
    37bd:	c7 44 24 08 00 20 00 	movl   $0x2000,0x8(%esp)
    37c4:	00 
    37c5:	c7 44 24 04 20 94 00 	movl   $0x9420,0x4(%esp)
    37cc:	00 
    37cd:	89 04 24             	mov    %eax,(%esp)
    37d0:	e8 eb 17 00 00       	call   4fc0 <read>
  if(cc != 2 || buf[0] != 'f'){
    37d5:	83 f8 02             	cmp    $0x2,%eax
    37d8:	0f 85 fe 02 00 00    	jne    3adc <subdir+0x41c>
    37de:	80 3d 20 94 00 00 66 	cmpb   $0x66,0x9420
    37e5:	0f 85 f1 02 00 00    	jne    3adc <subdir+0x41c>
    printf(1, "dd/dd/../ff wrong content\n");
    exit(0);
  }
  close(fd);
    37eb:	89 1c 24             	mov    %ebx,(%esp)
    37ee:	e8 dd 17 00 00       	call   4fd0 <close>

  if(link("dd/dd/ff", "dd/dd/ffff") != 0){
    37f3:	c7 44 24 04 46 5f 00 	movl   $0x5f46,0x4(%esp)
    37fa:	00 
    37fb:	c7 04 24 e2 5e 00 00 	movl   $0x5ee2,(%esp)
    3802:	e8 01 18 00 00       	call   5008 <link>
    3807:	85 c0                	test   %eax,%eax
    3809:	0f 85 0d 04 00 00    	jne    3c1c <subdir+0x55c>
    printf(1, "link dd/dd/ff dd/dd/ffff failed\n");
    exit(0);
  }

  if(unlink("dd/dd/ff") != 0){
    380f:	c7 04 24 e2 5e 00 00 	movl   $0x5ee2,(%esp)
    3816:	e8 dd 17 00 00       	call   4ff8 <unlink>
    381b:	85 c0                	test   %eax,%eax
    381d:	0f 85 f9 02 00 00    	jne    3b1c <subdir+0x45c>
    printf(1, "unlink dd/dd/ff failed\n");
    exit(0);
  }
  if(open("dd/dd/ff", O_RDONLY) >= 0){
    3823:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    382a:	00 
    382b:	c7 04 24 e2 5e 00 00 	movl   $0x5ee2,(%esp)
    3832:	e8 b1 17 00 00       	call   4fe8 <open>
    3837:	85 c0                	test   %eax,%eax
    3839:	0f 89 dd 04 00 00    	jns    3d1c <subdir+0x65c>
    printf(1, "open (unlinked) dd/dd/ff succeeded\n");
    exit(0);
  }

  if(chdir("dd") != 0){
    383f:	c7 04 24 ac 5f 00 00 	movl   $0x5fac,(%esp)
    3846:	e8 cd 17 00 00       	call   5018 <chdir>
    384b:	85 c0                	test   %eax,%eax
    384d:	0f 85 a9 04 00 00    	jne    3cfc <subdir+0x63c>
    printf(1, "chdir dd failed\n");
    exit(0);
  }
  if(chdir("dd/../../dd") != 0){
    3853:	c7 04 24 7a 5f 00 00 	movl   $0x5f7a,(%esp)
    385a:	e8 b9 17 00 00       	call   5018 <chdir>
    385f:	85 c0                	test   %eax,%eax
    3861:	0f 85 95 02 00 00    	jne    3afc <subdir+0x43c>
    printf(1, "chdir dd/../../dd failed\n");
    exit(0);
  }
  if(chdir("dd/../../../dd") != 0){
    3867:	c7 04 24 a0 5f 00 00 	movl   $0x5fa0,(%esp)
    386e:	e8 a5 17 00 00       	call   5018 <chdir>
    3873:	85 c0                	test   %eax,%eax
    3875:	0f 85 81 02 00 00    	jne    3afc <subdir+0x43c>
    printf(1, "chdir dd/../../dd failed\n");
    exit(0);
  }
  if(chdir("./..") != 0){
    387b:	c7 04 24 af 5f 00 00 	movl   $0x5faf,(%esp)
    3882:	e8 91 17 00 00       	call   5018 <chdir>
    3887:	85 c0                	test   %eax,%eax
    3889:	0f 85 6d 03 00 00    	jne    3bfc <subdir+0x53c>
    printf(1, "chdir ./.. failed\n");
    exit(0);
  }

  fd = open("dd/dd/ffff", 0);
    388f:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    3896:	00 
    3897:	c7 04 24 46 5f 00 00 	movl   $0x5f46,(%esp)
    389e:	e8 45 17 00 00       	call   4fe8 <open>
  if(fd < 0){
    38a3:	85 c0                	test   %eax,%eax
  if(chdir("./..") != 0){
    printf(1, "chdir ./.. failed\n");
    exit(0);
  }

  fd = open("dd/dd/ffff", 0);
    38a5:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    38a7:	0f 88 6f 06 00 00    	js     3f1c <subdir+0x85c>
    printf(1, "open dd/dd/ffff failed\n");
    exit(0);
  }
  if(read(fd, buf, sizeof(buf)) != 2){
    38ad:	c7 44 24 08 00 20 00 	movl   $0x2000,0x8(%esp)
    38b4:	00 
    38b5:	c7 44 24 04 20 94 00 	movl   $0x9420,0x4(%esp)
    38bc:	00 
    38bd:	89 04 24             	mov    %eax,(%esp)
    38c0:	e8 fb 16 00 00       	call   4fc0 <read>
    38c5:	83 f8 02             	cmp    $0x2,%eax
    38c8:	0f 85 2e 06 00 00    	jne    3efc <subdir+0x83c>
    printf(1, "read dd/dd/ffff wrong len\n");
    exit(0);
  }
  close(fd);
    38ce:	89 1c 24             	mov    %ebx,(%esp)
    38d1:	e8 fa 16 00 00       	call   4fd0 <close>

  if(open("dd/dd/ff", O_RDONLY) >= 0){
    38d6:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    38dd:	00 
    38de:	c7 04 24 e2 5e 00 00 	movl   $0x5ee2,(%esp)
    38e5:	e8 fe 16 00 00       	call   4fe8 <open>
    38ea:	85 c0                	test   %eax,%eax
    38ec:	0f 89 6a 02 00 00    	jns    3b5c <subdir+0x49c>
    printf(1, "open (unlinked) dd/dd/ff succeeded!\n");
    exit(0);
  }

  if(open("dd/ff/ff", O_CREATE|O_RDWR) >= 0){
    38f2:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
    38f9:	00 
    38fa:	c7 04 24 fa 5f 00 00 	movl   $0x5ffa,(%esp)
    3901:	e8 e2 16 00 00       	call   4fe8 <open>
    3906:	85 c0                	test   %eax,%eax
    3908:	0f 89 2e 02 00 00    	jns    3b3c <subdir+0x47c>
    printf(1, "create dd/ff/ff succeeded!\n");
    exit(0);
  }
  if(open("dd/xx/ff", O_CREATE|O_RDWR) >= 0){
    390e:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
    3915:	00 
    3916:	c7 04 24 1f 60 00 00 	movl   $0x601f,(%esp)
    391d:	e8 c6 16 00 00       	call   4fe8 <open>
    3922:	85 c0                	test   %eax,%eax
    3924:	0f 89 b2 03 00 00    	jns    3cdc <subdir+0x61c>
    printf(1, "create dd/xx/ff succeeded!\n");
    exit(0);
  }
  if(open("dd", O_CREATE) >= 0){
    392a:	c7 44 24 04 00 02 00 	movl   $0x200,0x4(%esp)
    3931:	00 
    3932:	c7 04 24 ac 5f 00 00 	movl   $0x5fac,(%esp)
    3939:	e8 aa 16 00 00       	call   4fe8 <open>
    393e:	85 c0                	test   %eax,%eax
    3940:	0f 89 76 03 00 00    	jns    3cbc <subdir+0x5fc>
    printf(1, "create dd succeeded!\n");
    exit(0);
  }
  if(open("dd", O_RDWR) >= 0){
    3946:	c7 44 24 04 02 00 00 	movl   $0x2,0x4(%esp)
    394d:	00 
    394e:	c7 04 24 ac 5f 00 00 	movl   $0x5fac,(%esp)
    3955:	e8 8e 16 00 00       	call   4fe8 <open>
    395a:	85 c0                	test   %eax,%eax
    395c:	0f 89 3a 03 00 00    	jns    3c9c <subdir+0x5dc>
    printf(1, "open dd rdwr succeeded!\n");
    exit(0);
  }
  if(open("dd", O_WRONLY) >= 0){
    3962:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
    3969:	00 
    396a:	c7 04 24 ac 5f 00 00 	movl   $0x5fac,(%esp)
    3971:	e8 72 16 00 00       	call   4fe8 <open>
    3976:	85 c0                	test   %eax,%eax
    3978:	0f 89 fe 02 00 00    	jns    3c7c <subdir+0x5bc>
    printf(1, "open dd wronly succeeded!\n");
    exit(0);
  }
  if(link("dd/ff/ff", "dd/dd/xx") == 0){
    397e:	c7 44 24 04 8e 60 00 	movl   $0x608e,0x4(%esp)
    3985:	00 
    3986:	c7 04 24 fa 5f 00 00 	movl   $0x5ffa,(%esp)
    398d:	e8 76 16 00 00       	call   5008 <link>
    3992:	85 c0                	test   %eax,%eax
    3994:	0f 84 c2 02 00 00    	je     3c5c <subdir+0x59c>
    printf(1, "link dd/ff/ff dd/dd/xx succeeded!\n");
    exit(0);
  }
  if(link("dd/xx/ff", "dd/dd/xx") == 0){
    399a:	c7 44 24 04 8e 60 00 	movl   $0x608e,0x4(%esp)
    39a1:	00 
    39a2:	c7 04 24 1f 60 00 00 	movl   $0x601f,(%esp)
    39a9:	e8 5a 16 00 00       	call   5008 <link>
    39ae:	85 c0                	test   %eax,%eax
    39b0:	0f 84 86 02 00 00    	je     3c3c <subdir+0x57c>
    printf(1, "link dd/xx/ff dd/dd/xx succeeded!\n");
    exit(0);
  }
  if(link("dd/ff", "dd/dd/ffff") == 0){
    39b6:	c7 44 24 04 46 5f 00 	movl   $0x5f46,0x4(%esp)
    39bd:	00 
    39be:	c7 04 24 e5 5e 00 00 	movl   $0x5ee5,(%esp)
    39c5:	e8 3e 16 00 00       	call   5008 <link>
    39ca:	85 c0                	test   %eax,%eax
    39cc:	0f 84 ca 01 00 00    	je     3b9c <subdir+0x4dc>
    printf(1, "link dd/ff dd/dd/ffff succeeded!\n");
    exit(0);
  }
  if(mkdir("dd/ff/ff") == 0){
    39d2:	c7 04 24 fa 5f 00 00 	movl   $0x5ffa,(%esp)
    39d9:	e8 32 16 00 00       	call   5010 <mkdir>
    39de:	85 c0                	test   %eax,%eax
    39e0:	0f 84 96 01 00 00    	je     3b7c <subdir+0x4bc>
    printf(1, "mkdir dd/ff/ff succeeded!\n");
    exit(0);
  }
  if(mkdir("dd/xx/ff") == 0){
    39e6:	c7 04 24 1f 60 00 00 	movl   $0x601f,(%esp)
    39ed:	e8 1e 16 00 00       	call   5010 <mkdir>
    39f2:	85 c0                	test   %eax,%eax
    39f4:	0f 84 e2 04 00 00    	je     3edc <subdir+0x81c>
    printf(1, "mkdir dd/xx/ff succeeded!\n");
    exit(0);
  }
  if(mkdir("dd/dd/ffff") == 0){
    39fa:	c7 04 24 46 5f 00 00 	movl   $0x5f46,(%esp)
    3a01:	e8 0a 16 00 00       	call   5010 <mkdir>
    3a06:	85 c0                	test   %eax,%eax
    3a08:	0f 84 ae 04 00 00    	je     3ebc <subdir+0x7fc>
    printf(1, "mkdir dd/dd/ffff succeeded!\n");
    exit(0);
  }
  if(unlink("dd/xx/ff") == 0){
    3a0e:	c7 04 24 1f 60 00 00 	movl   $0x601f,(%esp)
    3a15:	e8 de 15 00 00       	call   4ff8 <unlink>
    3a1a:	85 c0                	test   %eax,%eax
    3a1c:	0f 84 7a 04 00 00    	je     3e9c <subdir+0x7dc>
    printf(1, "unlink dd/xx/ff succeeded!\n");
    exit(0);
  }
  if(unlink("dd/ff/ff") == 0){
    3a22:	c7 04 24 fa 5f 00 00 	movl   $0x5ffa,(%esp)
    3a29:	e8 ca 15 00 00       	call   4ff8 <unlink>
    3a2e:	85 c0                	test   %eax,%eax
    3a30:	0f 84 46 04 00 00    	je     3e7c <subdir+0x7bc>
    printf(1, "unlink dd/ff/ff succeeded!\n");
    exit(0);
  }
  if(chdir("dd/ff") == 0){
    3a36:	c7 04 24 e5 5e 00 00 	movl   $0x5ee5,(%esp)
    3a3d:	e8 d6 15 00 00       	call   5018 <chdir>
    3a42:	85 c0                	test   %eax,%eax
    3a44:	0f 84 12 04 00 00    	je     3e5c <subdir+0x79c>
    printf(1, "chdir dd/ff succeeded!\n");
    exit(0);
  }
  if(chdir("dd/xx") == 0){
    3a4a:	c7 04 24 91 60 00 00 	movl   $0x6091,(%esp)
    3a51:	e8 c2 15 00 00       	call   5018 <chdir>
    3a56:	85 c0                	test   %eax,%eax
    3a58:	0f 84 de 03 00 00    	je     3e3c <subdir+0x77c>
    printf(1, "chdir dd/xx succeeded!\n");
    exit(0);
  }

  if(unlink("dd/dd/ffff") != 0){
    3a5e:	c7 04 24 46 5f 00 00 	movl   $0x5f46,(%esp)
    3a65:	e8 8e 15 00 00       	call   4ff8 <unlink>
    3a6a:	85 c0                	test   %eax,%eax
    3a6c:	0f 85 aa 00 00 00    	jne    3b1c <subdir+0x45c>
    printf(1, "unlink dd/dd/ff failed\n");
    exit(0);
  }
  if(unlink("dd/ff") != 0){
    3a72:	c7 04 24 e5 5e 00 00 	movl   $0x5ee5,(%esp)
    3a79:	e8 7a 15 00 00       	call   4ff8 <unlink>
    3a7e:	85 c0                	test   %eax,%eax
    3a80:	0f 85 96 03 00 00    	jne    3e1c <subdir+0x75c>
    printf(1, "unlink dd/ff failed\n");
    exit(0);
  }
  if(unlink("dd") == 0){
    3a86:	c7 04 24 ac 5f 00 00 	movl   $0x5fac,(%esp)
    3a8d:	e8 66 15 00 00       	call   4ff8 <unlink>
    3a92:	85 c0                	test   %eax,%eax
    3a94:	0f 84 62 03 00 00    	je     3dfc <subdir+0x73c>
    printf(1, "unlink non-empty dd succeeded!\n");
    exit(0);
  }
  if(unlink("dd/dd") < 0){
    3a9a:	c7 04 24 c1 5e 00 00 	movl   $0x5ec1,(%esp)
    3aa1:	e8 52 15 00 00       	call   4ff8 <unlink>
    3aa6:	85 c0                	test   %eax,%eax
    3aa8:	0f 88 2e 03 00 00    	js     3ddc <subdir+0x71c>
    printf(1, "unlink dd/dd failed\n");
    exit(0);
  }
  if(unlink("dd") < 0){
    3aae:	c7 04 24 ac 5f 00 00 	movl   $0x5fac,(%esp)
    3ab5:	e8 3e 15 00 00       	call   4ff8 <unlink>
    3aba:	85 c0                	test   %eax,%eax
    3abc:	0f 88 fa 02 00 00    	js     3dbc <subdir+0x6fc>
    printf(1, "unlink dd failed\n");
    exit(0);
  }

  printf(1, "subdir ok\n");
    3ac2:	c7 44 24 04 8e 61 00 	movl   $0x618e,0x4(%esp)
    3ac9:	00 
    3aca:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    3ad1:	e8 2a 16 00 00       	call   5100 <printf>
}
    3ad6:	83 c4 14             	add    $0x14,%esp
    3ad9:	5b                   	pop    %ebx
    3ada:	5d                   	pop    %ebp
    3adb:	c3                   	ret    
    printf(1, "open dd/dd/../ff failed\n");
    exit(0);
  }
  cc = read(fd, buf, sizeof(buf));
  if(cc != 2 || buf[0] != 'f'){
    printf(1, "dd/dd/../ff wrong content\n");
    3adc:	c7 44 24 04 2b 5f 00 	movl   $0x5f2b,0x4(%esp)
    3ae3:	00 
    3ae4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    3aeb:	e8 10 16 00 00       	call   5100 <printf>
    exit(0);
    3af0:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3af7:	e8 ac 14 00 00       	call   4fa8 <exit>
  if(chdir("dd/../../dd") != 0){
    printf(1, "chdir dd/../../dd failed\n");
    exit(0);
  }
  if(chdir("dd/../../../dd") != 0){
    printf(1, "chdir dd/../../dd failed\n");
    3afc:	c7 44 24 04 86 5f 00 	movl   $0x5f86,0x4(%esp)
    3b03:	00 
    3b04:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    3b0b:	e8 f0 15 00 00       	call   5100 <printf>
    exit(0);
    3b10:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3b17:	e8 8c 14 00 00       	call   4fa8 <exit>
    printf(1, "chdir dd/xx succeeded!\n");
    exit(0);
  }

  if(unlink("dd/dd/ffff") != 0){
    printf(1, "unlink dd/dd/ff failed\n");
    3b1c:	c7 44 24 04 51 5f 00 	movl   $0x5f51,0x4(%esp)
    3b23:	00 
    3b24:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    3b2b:	e8 d0 15 00 00       	call   5100 <printf>
    exit(0);
    3b30:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3b37:	e8 6c 14 00 00       	call   4fa8 <exit>
    printf(1, "open (unlinked) dd/dd/ff succeeded!\n");
    exit(0);
  }

  if(open("dd/ff/ff", O_CREATE|O_RDWR) >= 0){
    printf(1, "create dd/ff/ff succeeded!\n");
    3b3c:	c7 44 24 04 03 60 00 	movl   $0x6003,0x4(%esp)
    3b43:	00 
    3b44:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    3b4b:	e8 b0 15 00 00       	call   5100 <printf>
    exit(0);
    3b50:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3b57:	e8 4c 14 00 00       	call   4fa8 <exit>
    exit(0);
  }
  close(fd);

  if(open("dd/dd/ff", O_RDONLY) >= 0){
    printf(1, "open (unlinked) dd/dd/ff succeeded!\n");
    3b5c:	c7 44 24 04 74 6a 00 	movl   $0x6a74,0x4(%esp)
    3b63:	00 
    3b64:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    3b6b:	e8 90 15 00 00       	call   5100 <printf>
    exit(0);
    3b70:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3b77:	e8 2c 14 00 00       	call   4fa8 <exit>
  if(link("dd/ff", "dd/dd/ffff") == 0){
    printf(1, "link dd/ff dd/dd/ffff succeeded!\n");
    exit(0);
  }
  if(mkdir("dd/ff/ff") == 0){
    printf(1, "mkdir dd/ff/ff succeeded!\n");
    3b7c:	c7 44 24 04 97 60 00 	movl   $0x6097,0x4(%esp)
    3b83:	00 
    3b84:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    3b8b:	e8 70 15 00 00       	call   5100 <printf>
    exit(0);
    3b90:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3b97:	e8 0c 14 00 00       	call   4fa8 <exit>
  if(link("dd/xx/ff", "dd/dd/xx") == 0){
    printf(1, "link dd/xx/ff dd/dd/xx succeeded!\n");
    exit(0);
  }
  if(link("dd/ff", "dd/dd/ffff") == 0){
    printf(1, "link dd/ff dd/dd/ffff succeeded!\n");
    3b9c:	c7 44 24 04 e4 6a 00 	movl   $0x6ae4,0x4(%esp)
    3ba3:	00 
    3ba4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    3bab:	e8 50 15 00 00       	call   5100 <printf>
    exit(0);
    3bb0:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3bb7:	e8 ec 13 00 00       	call   4fa8 <exit>
  write(fd, "FF", 2);
  close(fd);

  fd = open("dd/dd/../ff", 0);
  if(fd < 0){
    printf(1, "open dd/dd/../ff failed\n");
    3bbc:	c7 44 24 04 12 5f 00 	movl   $0x5f12,0x4(%esp)
    3bc3:	00 
    3bc4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    3bcb:	e8 30 15 00 00       	call   5100 <printf>
    exit(0);
    3bd0:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3bd7:	e8 cc 13 00 00       	call   4fa8 <exit>
    exit(0);
  }

  fd = open("dd/dd/ff", O_CREATE | O_RDWR);
  if(fd < 0){
    printf(1, "create dd/dd/ff failed\n");
    3bdc:	c7 44 24 04 eb 5e 00 	movl   $0x5eeb,0x4(%esp)
    3be3:	00 
    3be4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    3beb:	e8 10 15 00 00       	call   5100 <printf>
    exit(0);
    3bf0:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3bf7:	e8 ac 13 00 00       	call   4fa8 <exit>
  if(chdir("dd/../../../dd") != 0){
    printf(1, "chdir dd/../../dd failed\n");
    exit(0);
  }
  if(chdir("./..") != 0){
    printf(1, "chdir ./.. failed\n");
    3bfc:	c7 44 24 04 b4 5f 00 	movl   $0x5fb4,0x4(%esp)
    3c03:	00 
    3c04:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    3c0b:	e8 f0 14 00 00       	call   5100 <printf>
    exit(0);
    3c10:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3c17:	e8 8c 13 00 00       	call   4fa8 <exit>
    exit(0);
  }
  close(fd);

  if(link("dd/dd/ff", "dd/dd/ffff") != 0){
    printf(1, "link dd/dd/ff dd/dd/ffff failed\n");
    3c1c:	c7 44 24 04 2c 6a 00 	movl   $0x6a2c,0x4(%esp)
    3c23:	00 
    3c24:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    3c2b:	e8 d0 14 00 00       	call   5100 <printf>
    exit(0);
    3c30:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3c37:	e8 6c 13 00 00       	call   4fa8 <exit>
  if(link("dd/ff/ff", "dd/dd/xx") == 0){
    printf(1, "link dd/ff/ff dd/dd/xx succeeded!\n");
    exit(0);
  }
  if(link("dd/xx/ff", "dd/dd/xx") == 0){
    printf(1, "link dd/xx/ff dd/dd/xx succeeded!\n");
    3c3c:	c7 44 24 04 c0 6a 00 	movl   $0x6ac0,0x4(%esp)
    3c43:	00 
    3c44:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    3c4b:	e8 b0 14 00 00       	call   5100 <printf>
    exit(0);
    3c50:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3c57:	e8 4c 13 00 00       	call   4fa8 <exit>
  if(open("dd", O_WRONLY) >= 0){
    printf(1, "open dd wronly succeeded!\n");
    exit(0);
  }
  if(link("dd/ff/ff", "dd/dd/xx") == 0){
    printf(1, "link dd/ff/ff dd/dd/xx succeeded!\n");
    3c5c:	c7 44 24 04 9c 6a 00 	movl   $0x6a9c,0x4(%esp)
    3c63:	00 
    3c64:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    3c6b:	e8 90 14 00 00       	call   5100 <printf>
    exit(0);
    3c70:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3c77:	e8 2c 13 00 00       	call   4fa8 <exit>
  if(open("dd", O_RDWR) >= 0){
    printf(1, "open dd rdwr succeeded!\n");
    exit(0);
  }
  if(open("dd", O_WRONLY) >= 0){
    printf(1, "open dd wronly succeeded!\n");
    3c7c:	c7 44 24 04 73 60 00 	movl   $0x6073,0x4(%esp)
    3c83:	00 
    3c84:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    3c8b:	e8 70 14 00 00       	call   5100 <printf>
    exit(0);
    3c90:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3c97:	e8 0c 13 00 00       	call   4fa8 <exit>
  if(open("dd", O_CREATE) >= 0){
    printf(1, "create dd succeeded!\n");
    exit(0);
  }
  if(open("dd", O_RDWR) >= 0){
    printf(1, "open dd rdwr succeeded!\n");
    3c9c:	c7 44 24 04 5a 60 00 	movl   $0x605a,0x4(%esp)
    3ca3:	00 
    3ca4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    3cab:	e8 50 14 00 00       	call   5100 <printf>
    exit(0);
    3cb0:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3cb7:	e8 ec 12 00 00       	call   4fa8 <exit>
  if(open("dd/xx/ff", O_CREATE|O_RDWR) >= 0){
    printf(1, "create dd/xx/ff succeeded!\n");
    exit(0);
  }
  if(open("dd", O_CREATE) >= 0){
    printf(1, "create dd succeeded!\n");
    3cbc:	c7 44 24 04 44 60 00 	movl   $0x6044,0x4(%esp)
    3cc3:	00 
    3cc4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    3ccb:	e8 30 14 00 00       	call   5100 <printf>
    exit(0);
    3cd0:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3cd7:	e8 cc 12 00 00       	call   4fa8 <exit>
  if(open("dd/ff/ff", O_CREATE|O_RDWR) >= 0){
    printf(1, "create dd/ff/ff succeeded!\n");
    exit(0);
  }
  if(open("dd/xx/ff", O_CREATE|O_RDWR) >= 0){
    printf(1, "create dd/xx/ff succeeded!\n");
    3cdc:	c7 44 24 04 28 60 00 	movl   $0x6028,0x4(%esp)
    3ce3:	00 
    3ce4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    3ceb:	e8 10 14 00 00       	call   5100 <printf>
    exit(0);
    3cf0:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3cf7:	e8 ac 12 00 00       	call   4fa8 <exit>
    printf(1, "open (unlinked) dd/dd/ff succeeded\n");
    exit(0);
  }

  if(chdir("dd") != 0){
    printf(1, "chdir dd failed\n");
    3cfc:	c7 44 24 04 69 5f 00 	movl   $0x5f69,0x4(%esp)
    3d03:	00 
    3d04:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    3d0b:	e8 f0 13 00 00       	call   5100 <printf>
    exit(0);
    3d10:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3d17:	e8 8c 12 00 00       	call   4fa8 <exit>
  if(unlink("dd/dd/ff") != 0){
    printf(1, "unlink dd/dd/ff failed\n");
    exit(0);
  }
  if(open("dd/dd/ff", O_RDONLY) >= 0){
    printf(1, "open (unlinked) dd/dd/ff succeeded\n");
    3d1c:	c7 44 24 04 50 6a 00 	movl   $0x6a50,0x4(%esp)
    3d23:	00 
    3d24:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    3d2b:	e8 d0 13 00 00       	call   5100 <printf>
    exit(0);
    3d30:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3d37:	e8 6c 12 00 00       	call   4fa8 <exit>
    printf(1, "unlink dd (non-empty dir) succeeded!\n");
    exit(0);
  }

  if(mkdir("/dd/dd") != 0){
    printf(1, "subdir mkdir dd/dd failed\n");
    3d3c:	c7 44 24 04 c7 5e 00 	movl   $0x5ec7,0x4(%esp)
    3d43:	00 
    3d44:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    3d4b:	e8 b0 13 00 00       	call   5100 <printf>
    exit(0);
    3d50:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3d57:	e8 4c 12 00 00       	call   4fa8 <exit>
  }
  write(fd, "ff", 2);
  close(fd);

  if(unlink("dd") >= 0){
    printf(1, "unlink dd (non-empty dir) succeeded!\n");
    3d5c:	c7 44 24 04 04 6a 00 	movl   $0x6a04,0x4(%esp)
    3d63:	00 
    3d64:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    3d6b:	e8 90 13 00 00       	call   5100 <printf>
    exit(0);
    3d70:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3d77:	e8 2c 12 00 00       	call   4fa8 <exit>
    exit(0);
  }

  fd = open("dd/ff", O_CREATE | O_RDWR);
  if(fd < 0){
    printf(1, "create dd/ff failed\n");
    3d7c:	c7 44 24 04 ab 5e 00 	movl   $0x5eab,0x4(%esp)
    3d83:	00 
    3d84:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    3d8b:	e8 70 13 00 00       	call   5100 <printf>
    exit(0);
    3d90:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3d97:	e8 0c 12 00 00       	call   4fa8 <exit>

  printf(1, "subdir test\n");

  unlink("ff");
  if(mkdir("dd") != 0){
    printf(1, "subdir mkdir dd failed\n");
    3d9c:	c7 44 24 04 93 5e 00 	movl   $0x5e93,0x4(%esp)
    3da3:	00 
    3da4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    3dab:	e8 50 13 00 00       	call   5100 <printf>
    exit(0);
    3db0:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3db7:	e8 ec 11 00 00       	call   4fa8 <exit>
  if(unlink("dd/dd") < 0){
    printf(1, "unlink dd/dd failed\n");
    exit(0);
  }
  if(unlink("dd") < 0){
    printf(1, "unlink dd failed\n");
    3dbc:	c7 44 24 04 7c 61 00 	movl   $0x617c,0x4(%esp)
    3dc3:	00 
    3dc4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    3dcb:	e8 30 13 00 00       	call   5100 <printf>
    exit(0);
    3dd0:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3dd7:	e8 cc 11 00 00       	call   4fa8 <exit>
  if(unlink("dd") == 0){
    printf(1, "unlink non-empty dd succeeded!\n");
    exit(0);
  }
  if(unlink("dd/dd") < 0){
    printf(1, "unlink dd/dd failed\n");
    3ddc:	c7 44 24 04 67 61 00 	movl   $0x6167,0x4(%esp)
    3de3:	00 
    3de4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    3deb:	e8 10 13 00 00       	call   5100 <printf>
    exit(0);
    3df0:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3df7:	e8 ac 11 00 00       	call   4fa8 <exit>
  if(unlink("dd/ff") != 0){
    printf(1, "unlink dd/ff failed\n");
    exit(0);
  }
  if(unlink("dd") == 0){
    printf(1, "unlink non-empty dd succeeded!\n");
    3dfc:	c7 44 24 04 08 6b 00 	movl   $0x6b08,0x4(%esp)
    3e03:	00 
    3e04:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    3e0b:	e8 f0 12 00 00       	call   5100 <printf>
    exit(0);
    3e10:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3e17:	e8 8c 11 00 00       	call   4fa8 <exit>
  if(unlink("dd/dd/ffff") != 0){
    printf(1, "unlink dd/dd/ff failed\n");
    exit(0);
  }
  if(unlink("dd/ff") != 0){
    printf(1, "unlink dd/ff failed\n");
    3e1c:	c7 44 24 04 52 61 00 	movl   $0x6152,0x4(%esp)
    3e23:	00 
    3e24:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    3e2b:	e8 d0 12 00 00       	call   5100 <printf>
    exit(0);
    3e30:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3e37:	e8 6c 11 00 00       	call   4fa8 <exit>
  if(chdir("dd/ff") == 0){
    printf(1, "chdir dd/ff succeeded!\n");
    exit(0);
  }
  if(chdir("dd/xx") == 0){
    printf(1, "chdir dd/xx succeeded!\n");
    3e3c:	c7 44 24 04 3a 61 00 	movl   $0x613a,0x4(%esp)
    3e43:	00 
    3e44:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    3e4b:	e8 b0 12 00 00       	call   5100 <printf>
    exit(0);
    3e50:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3e57:	e8 4c 11 00 00       	call   4fa8 <exit>
  if(unlink("dd/ff/ff") == 0){
    printf(1, "unlink dd/ff/ff succeeded!\n");
    exit(0);
  }
  if(chdir("dd/ff") == 0){
    printf(1, "chdir dd/ff succeeded!\n");
    3e5c:	c7 44 24 04 22 61 00 	movl   $0x6122,0x4(%esp)
    3e63:	00 
    3e64:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    3e6b:	e8 90 12 00 00       	call   5100 <printf>
    exit(0);
    3e70:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3e77:	e8 2c 11 00 00       	call   4fa8 <exit>
  if(unlink("dd/xx/ff") == 0){
    printf(1, "unlink dd/xx/ff succeeded!\n");
    exit(0);
  }
  if(unlink("dd/ff/ff") == 0){
    printf(1, "unlink dd/ff/ff succeeded!\n");
    3e7c:	c7 44 24 04 06 61 00 	movl   $0x6106,0x4(%esp)
    3e83:	00 
    3e84:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    3e8b:	e8 70 12 00 00       	call   5100 <printf>
    exit(0);
    3e90:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3e97:	e8 0c 11 00 00       	call   4fa8 <exit>
  if(mkdir("dd/dd/ffff") == 0){
    printf(1, "mkdir dd/dd/ffff succeeded!\n");
    exit(0);
  }
  if(unlink("dd/xx/ff") == 0){
    printf(1, "unlink dd/xx/ff succeeded!\n");
    3e9c:	c7 44 24 04 ea 60 00 	movl   $0x60ea,0x4(%esp)
    3ea3:	00 
    3ea4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    3eab:	e8 50 12 00 00       	call   5100 <printf>
    exit(0);
    3eb0:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3eb7:	e8 ec 10 00 00       	call   4fa8 <exit>
  if(mkdir("dd/xx/ff") == 0){
    printf(1, "mkdir dd/xx/ff succeeded!\n");
    exit(0);
  }
  if(mkdir("dd/dd/ffff") == 0){
    printf(1, "mkdir dd/dd/ffff succeeded!\n");
    3ebc:	c7 44 24 04 cd 60 00 	movl   $0x60cd,0x4(%esp)
    3ec3:	00 
    3ec4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    3ecb:	e8 30 12 00 00       	call   5100 <printf>
    exit(0);
    3ed0:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3ed7:	e8 cc 10 00 00       	call   4fa8 <exit>
  if(mkdir("dd/ff/ff") == 0){
    printf(1, "mkdir dd/ff/ff succeeded!\n");
    exit(0);
  }
  if(mkdir("dd/xx/ff") == 0){
    printf(1, "mkdir dd/xx/ff succeeded!\n");
    3edc:	c7 44 24 04 b2 60 00 	movl   $0x60b2,0x4(%esp)
    3ee3:	00 
    3ee4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    3eeb:	e8 10 12 00 00       	call   5100 <printf>
    exit(0);
    3ef0:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3ef7:	e8 ac 10 00 00       	call   4fa8 <exit>
  if(fd < 0){
    printf(1, "open dd/dd/ffff failed\n");
    exit(0);
  }
  if(read(fd, buf, sizeof(buf)) != 2){
    printf(1, "read dd/dd/ffff wrong len\n");
    3efc:	c7 44 24 04 df 5f 00 	movl   $0x5fdf,0x4(%esp)
    3f03:	00 
    3f04:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    3f0b:	e8 f0 11 00 00       	call   5100 <printf>
    exit(0);
    3f10:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3f17:	e8 8c 10 00 00       	call   4fa8 <exit>
    exit(0);
  }

  fd = open("dd/dd/ffff", 0);
  if(fd < 0){
    printf(1, "open dd/dd/ffff failed\n");
    3f1c:	c7 44 24 04 c7 5f 00 	movl   $0x5fc7,0x4(%esp)
    3f23:	00 
    3f24:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    3f2b:	e8 d0 11 00 00       	call   5100 <printf>
    exit(0);
    3f30:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3f37:	e8 6c 10 00 00       	call   4fa8 <exit>
    3f3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00003f40 <dirtest>:
  }
  printf(stdout, "many creates, followed by unlink; ok\n");
}

void dirtest(void)
{
    3f40:	55                   	push   %ebp
    3f41:	89 e5                	mov    %esp,%ebp
    3f43:	83 ec 18             	sub    $0x18,%esp
  printf(stdout, "mkdir test\n");
    3f46:	a1 2c 6c 00 00       	mov    0x6c2c,%eax
    3f4b:	c7 44 24 04 99 61 00 	movl   $0x6199,0x4(%esp)
    3f52:	00 
    3f53:	89 04 24             	mov    %eax,(%esp)
    3f56:	e8 a5 11 00 00       	call   5100 <printf>

  if(mkdir("dir0") < 0){
    3f5b:	c7 04 24 a5 61 00 00 	movl   $0x61a5,(%esp)
    3f62:	e8 a9 10 00 00       	call   5010 <mkdir>
    3f67:	85 c0                	test   %eax,%eax
    3f69:	78 47                	js     3fb2 <dirtest+0x72>
    printf(stdout, "mkdir failed\n");
    exit(0);
  }

  if(chdir("dir0") < 0){
    3f6b:	c7 04 24 a5 61 00 00 	movl   $0x61a5,(%esp)
    3f72:	e8 a1 10 00 00       	call   5018 <chdir>
    3f77:	85 c0                	test   %eax,%eax
    3f79:	78 6c                	js     3fe7 <dirtest+0xa7>
    printf(stdout, "chdir dir0 failed\n");
    exit(0);
  }

  if(chdir("..") < 0){
    3f7b:	c7 04 24 b1 5f 00 00 	movl   $0x5fb1,(%esp)
    3f82:	e8 91 10 00 00       	call   5018 <chdir>
    3f87:	85 c0                	test   %eax,%eax
    3f89:	78 52                	js     3fdd <dirtest+0x9d>
    printf(stdout, "chdir .. failed\n");
    exit(0);
  }

  if(unlink("dir0") < 0){
    3f8b:	c7 04 24 a5 61 00 00 	movl   $0x61a5,(%esp)
    3f92:	e8 61 10 00 00       	call   4ff8 <unlink>
    3f97:	85 c0                	test   %eax,%eax
    3f99:	78 38                	js     3fd3 <dirtest+0x93>
    printf(stdout, "unlink dir0 failed\n");
    exit(0);
  }
  printf(stdout, "mkdir test ok\n");
    3f9b:	a1 2c 6c 00 00       	mov    0x6c2c,%eax
    3fa0:	c7 44 24 04 f0 61 00 	movl   $0x61f0,0x4(%esp)
    3fa7:	00 
    3fa8:	89 04 24             	mov    %eax,(%esp)
    3fab:	e8 50 11 00 00       	call   5100 <printf>
}
    3fb0:	c9                   	leave  
    3fb1:	c3                   	ret    
void dirtest(void)
{
  printf(stdout, "mkdir test\n");

  if(mkdir("dir0") < 0){
    printf(stdout, "mkdir failed\n");
    3fb2:	c7 44 24 04 aa 61 00 	movl   $0x61aa,0x4(%esp)
    3fb9:	00 
    exit(0);
  }

  if(chdir("dir0") < 0){
    printf(stdout, "chdir dir0 failed\n");
    3fba:	a1 2c 6c 00 00       	mov    0x6c2c,%eax
    3fbf:	89 04 24             	mov    %eax,(%esp)
    3fc2:	e8 39 11 00 00       	call   5100 <printf>
    exit(0);
    3fc7:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3fce:	e8 d5 0f 00 00       	call   4fa8 <exit>
    printf(stdout, "chdir .. failed\n");
    exit(0);
  }

  if(unlink("dir0") < 0){
    printf(stdout, "unlink dir0 failed\n");
    3fd3:	c7 44 24 04 dc 61 00 	movl   $0x61dc,0x4(%esp)
    3fda:	00 
    3fdb:	eb dd                	jmp    3fba <dirtest+0x7a>
    printf(stdout, "chdir dir0 failed\n");
    exit(0);
  }

  if(chdir("..") < 0){
    printf(stdout, "chdir .. failed\n");
    3fdd:	c7 44 24 04 cb 61 00 	movl   $0x61cb,0x4(%esp)
    3fe4:	00 
    3fe5:	eb d3                	jmp    3fba <dirtest+0x7a>
    printf(stdout, "mkdir failed\n");
    exit(0);
  }

  if(chdir("dir0") < 0){
    printf(stdout, "chdir dir0 failed\n");
    3fe7:	c7 44 24 04 b8 61 00 	movl   $0x61b8,0x4(%esp)
    3fee:	00 
    3fef:	eb c9                	jmp    3fba <dirtest+0x7a>
    3ff1:	eb 0d                	jmp    4000 <exitiputtest>
    3ff3:	90                   	nop
    3ff4:	90                   	nop
    3ff5:	90                   	nop
    3ff6:	90                   	nop
    3ff7:	90                   	nop
    3ff8:	90                   	nop
    3ff9:	90                   	nop
    3ffa:	90                   	nop
    3ffb:	90                   	nop
    3ffc:	90                   	nop
    3ffd:	90                   	nop
    3ffe:	90                   	nop
    3fff:	90                   	nop

00004000 <exitiputtest>:
}

// does exit(0) call iput(p->cwd) in a transaction?
void
exitiputtest(void)
{
    4000:	55                   	push   %ebp
    4001:	89 e5                	mov    %esp,%ebp
    4003:	83 ec 18             	sub    $0x18,%esp
  int pid;

  printf(stdout, "exitiput test\n");
    4006:	a1 2c 6c 00 00       	mov    0x6c2c,%eax
    400b:	c7 44 24 04 ff 61 00 	movl   $0x61ff,0x4(%esp)
    4012:	00 
    4013:	89 04 24             	mov    %eax,(%esp)
    4016:	e8 e5 10 00 00       	call   5100 <printf>

  pid = fork();
    401b:	e8 80 0f 00 00       	call   4fa0 <fork>
  if(pid < 0){
    4020:	83 f8 00             	cmp    $0x0,%eax
    4023:	0f 8c 90 00 00 00    	jl     40b9 <exitiputtest+0xb9>
    printf(stdout, "fork failed\n");
    exit(0);
  }
  if(pid == 0){
    4029:	75 45                	jne    4070 <exitiputtest+0x70>
    if(mkdir("iputdir") < 0){
    402b:	c7 04 24 25 62 00 00 	movl   $0x6225,(%esp)
    4032:	e8 d9 0f 00 00       	call   5010 <mkdir>
    4037:	85 c0                	test   %eax,%eax
    4039:	0f 88 8e 00 00 00    	js     40cd <exitiputtest+0xcd>
      printf(stdout, "mkdir failed\n");
      exit(0);
    }
    if(chdir("iputdir") < 0){
    403f:	c7 04 24 25 62 00 00 	movl   $0x6225,(%esp)
    4046:	e8 cd 0f 00 00       	call   5018 <chdir>
    404b:	85 c0                	test   %eax,%eax
    404d:	78 74                	js     40c3 <exitiputtest+0xc3>
      printf(stdout, "child chdir failed\n");
      exit(0);
    }
    if(unlink("../iputdir") < 0){
    404f:	c7 04 24 22 62 00 00 	movl   $0x6222,(%esp)
    4056:	e8 9d 0f 00 00       	call   4ff8 <unlink>
    405b:	85 c0                	test   %eax,%eax
    405d:	78 39                	js     4098 <exitiputtest+0x98>
      printf(stdout, "unlink ../iputdir failed\n");
      exit(0);
    405f:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    4066:	e8 3d 0f 00 00       	call   4fa8 <exit>
    406b:	90                   	nop
    406c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    }
    exit(0);
  }
  wait(&exit_status);
    4070:	c7 04 24 e0 6c 00 00 	movl   $0x6ce0,(%esp)
    4077:	e8 34 0f 00 00       	call   4fb0 <wait>
  printf(stdout, "exitiput test ok\n");
    407c:	a1 2c 6c 00 00       	mov    0x6c2c,%eax
    4081:	c7 44 24 04 47 62 00 	movl   $0x6247,0x4(%esp)
    4088:	00 
    4089:	89 04 24             	mov    %eax,(%esp)
    408c:	e8 6f 10 00 00       	call   5100 <printf>
}
    4091:	c9                   	leave  
    4092:	c3                   	ret    
    4093:	90                   	nop
    4094:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(chdir("iputdir") < 0){
      printf(stdout, "child chdir failed\n");
      exit(0);
    }
    if(unlink("../iputdir") < 0){
      printf(stdout, "unlink ../iputdir failed\n");
    4098:	c7 44 24 04 2d 62 00 	movl   $0x622d,0x4(%esp)
    409f:	00 
    40a0:	a1 2c 6c 00 00       	mov    0x6c2c,%eax
    40a5:	89 04 24             	mov    %eax,(%esp)
    40a8:	e8 53 10 00 00       	call   5100 <printf>
      exit(0);
    40ad:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    40b4:	e8 ef 0e 00 00       	call   4fa8 <exit>

  printf(stdout, "exitiput test\n");

  pid = fork();
  if(pid < 0){
    printf(stdout, "fork failed\n");
    40b9:	c7 44 24 04 df 58 00 	movl   $0x58df,0x4(%esp)
    40c0:	00 
    40c1:	eb dd                	jmp    40a0 <exitiputtest+0xa0>
    if(mkdir("iputdir") < 0){
      printf(stdout, "mkdir failed\n");
      exit(0);
    }
    if(chdir("iputdir") < 0){
      printf(stdout, "child chdir failed\n");
    40c3:	c7 44 24 04 0e 62 00 	movl   $0x620e,0x4(%esp)
    40ca:	00 
    40cb:	eb d3                	jmp    40a0 <exitiputtest+0xa0>
    printf(stdout, "fork failed\n");
    exit(0);
  }
  if(pid == 0){
    if(mkdir("iputdir") < 0){
      printf(stdout, "mkdir failed\n");
    40cd:	c7 44 24 04 aa 61 00 	movl   $0x61aa,0x4(%esp)
    40d4:	00 
    40d5:	eb c9                	jmp    40a0 <exitiputtest+0xa0>
    40d7:	89 f6                	mov    %esi,%esi
    40d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000040e0 <iputtest>:
int exit_status;

// does chdir() call iput(p->cwd) in a transaction?
void
iputtest(void)
{
    40e0:	55                   	push   %ebp
    40e1:	89 e5                	mov    %esp,%ebp
    40e3:	83 ec 18             	sub    $0x18,%esp
  printf(stdout, "iput test\n");
    40e6:	a1 2c 6c 00 00       	mov    0x6c2c,%eax
    40eb:	c7 44 24 04 4c 5c 00 	movl   $0x5c4c,0x4(%esp)
    40f2:	00 
    40f3:	89 04 24             	mov    %eax,(%esp)
    40f6:	e8 05 10 00 00       	call   5100 <printf>

  if(mkdir("iputdir") < 0){
    40fb:	c7 04 24 25 62 00 00 	movl   $0x6225,(%esp)
    4102:	e8 09 0f 00 00       	call   5010 <mkdir>
    4107:	85 c0                	test   %eax,%eax
    4109:	78 47                	js     4152 <iputtest+0x72>
    printf(stdout, "mkdir failed\n");
    exit(0);
  }
  if(chdir("iputdir") < 0){
    410b:	c7 04 24 25 62 00 00 	movl   $0x6225,(%esp)
    4112:	e8 01 0f 00 00       	call   5018 <chdir>
    4117:	85 c0                	test   %eax,%eax
    4119:	78 6c                	js     4187 <iputtest+0xa7>
    printf(stdout, "chdir iputdir failed\n");
    exit(0);
  }
  if(unlink("../iputdir") < 0){
    411b:	c7 04 24 22 62 00 00 	movl   $0x6222,(%esp)
    4122:	e8 d1 0e 00 00       	call   4ff8 <unlink>
    4127:	85 c0                	test   %eax,%eax
    4129:	78 52                	js     417d <iputtest+0x9d>
    printf(stdout, "unlink ../iputdir failed\n");
    exit(0);
  }
  if(chdir("/") < 0){
    412b:	c7 04 24 c9 5c 00 00 	movl   $0x5cc9,(%esp)
    4132:	e8 e1 0e 00 00       	call   5018 <chdir>
    4137:	85 c0                	test   %eax,%eax
    4139:	78 38                	js     4173 <iputtest+0x93>
    printf(stdout, "chdir / failed\n");
    exit(0);
  }
  printf(stdout, "iput test ok\n");
    413b:	a1 2c 6c 00 00       	mov    0x6c2c,%eax
    4140:	c7 44 24 04 75 5c 00 	movl   $0x5c75,0x4(%esp)
    4147:	00 
    4148:	89 04 24             	mov    %eax,(%esp)
    414b:	e8 b0 0f 00 00       	call   5100 <printf>
}
    4150:	c9                   	leave  
    4151:	c3                   	ret    
iputtest(void)
{
  printf(stdout, "iput test\n");

  if(mkdir("iputdir") < 0){
    printf(stdout, "mkdir failed\n");
    4152:	c7 44 24 04 aa 61 00 	movl   $0x61aa,0x4(%esp)
    4159:	00 
    exit(0);
  }
  if(chdir("iputdir") < 0){
    printf(stdout, "chdir iputdir failed\n");
    415a:	a1 2c 6c 00 00       	mov    0x6c2c,%eax
    415f:	89 04 24             	mov    %eax,(%esp)
    4162:	e8 99 0f 00 00       	call   5100 <printf>
    exit(0);
    4167:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    416e:	e8 35 0e 00 00       	call   4fa8 <exit>
  if(unlink("../iputdir") < 0){
    printf(stdout, "unlink ../iputdir failed\n");
    exit(0);
  }
  if(chdir("/") < 0){
    printf(stdout, "chdir / failed\n");
    4173:	c7 44 24 04 19 5e 00 	movl   $0x5e19,0x4(%esp)
    417a:	00 
    417b:	eb dd                	jmp    415a <iputtest+0x7a>
  if(chdir("iputdir") < 0){
    printf(stdout, "chdir iputdir failed\n");
    exit(0);
  }
  if(unlink("../iputdir") < 0){
    printf(stdout, "unlink ../iputdir failed\n");
    417d:	c7 44 24 04 2d 62 00 	movl   $0x622d,0x4(%esp)
    4184:	00 
    4185:	eb d3                	jmp    415a <iputtest+0x7a>
  if(mkdir("iputdir") < 0){
    printf(stdout, "mkdir failed\n");
    exit(0);
  }
  if(chdir("iputdir") < 0){
    printf(stdout, "chdir iputdir failed\n");
    4187:	c7 44 24 04 59 62 00 	movl   $0x6259,0x4(%esp)
    418e:	00 
    418f:	eb c9                	jmp    415a <iputtest+0x7a>
    4191:	eb 0d                	jmp    41a0 <bigfile>
    4193:	90                   	nop
    4194:	90                   	nop
    4195:	90                   	nop
    4196:	90                   	nop
    4197:	90                   	nop
    4198:	90                   	nop
    4199:	90                   	nop
    419a:	90                   	nop
    419b:	90                   	nop
    419c:	90                   	nop
    419d:	90                   	nop
    419e:	90                   	nop
    419f:	90                   	nop

000041a0 <bigfile>:
  printf(1, "bigwrite ok\n");
}

void
bigfile(void)
{
    41a0:	55                   	push   %ebp
    41a1:	89 e5                	mov    %esp,%ebp
    41a3:	57                   	push   %edi
    41a4:	56                   	push   %esi
    41a5:	53                   	push   %ebx
    41a6:	83 ec 1c             	sub    $0x1c,%esp
  int fd, i, total, cc;

  printf(1, "bigfile test\n");
    41a9:	c7 44 24 04 6f 62 00 	movl   $0x626f,0x4(%esp)
    41b0:	00 
    41b1:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    41b8:	e8 43 0f 00 00       	call   5100 <printf>

  unlink("bigfile");
    41bd:	c7 04 24 8b 62 00 00 	movl   $0x628b,(%esp)
    41c4:	e8 2f 0e 00 00       	call   4ff8 <unlink>
  fd = open("bigfile", O_CREATE | O_RDWR);
    41c9:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
    41d0:	00 
    41d1:	c7 04 24 8b 62 00 00 	movl   $0x628b,(%esp)
    41d8:	e8 0b 0e 00 00       	call   4fe8 <open>
  if(fd < 0){
    41dd:	85 c0                	test   %eax,%eax
  int fd, i, total, cc;

  printf(1, "bigfile test\n");

  unlink("bigfile");
  fd = open("bigfile", O_CREATE | O_RDWR);
    41df:	89 c6                	mov    %eax,%esi
  if(fd < 0){
    41e1:	0f 88 a2 01 00 00    	js     4389 <bigfile+0x1e9>
    printf(1, "cannot create bigfile");
    exit(0);
    41e7:	31 db                	xor    %ebx,%ebx
    41e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  }
  for(i = 0; i < 20; i++){
    memset(buf, i, 600);
    41f0:	c7 44 24 08 58 02 00 	movl   $0x258,0x8(%esp)
    41f7:	00 
    41f8:	89 5c 24 04          	mov    %ebx,0x4(%esp)
    41fc:	c7 04 24 20 94 00 00 	movl   $0x9420,(%esp)
    4203:	e8 18 0c 00 00       	call   4e20 <memset>
    if(write(fd, buf, 600) != 600){
    4208:	c7 44 24 08 58 02 00 	movl   $0x258,0x8(%esp)
    420f:	00 
    4210:	c7 44 24 04 20 94 00 	movl   $0x9420,0x4(%esp)
    4217:	00 
    4218:	89 34 24             	mov    %esi,(%esp)
    421b:	e8 a8 0d 00 00       	call   4fc8 <write>
    4220:	3d 58 02 00 00       	cmp    $0x258,%eax
    4225:	0f 85 1e 01 00 00    	jne    4349 <bigfile+0x1a9>
  fd = open("bigfile", O_CREATE | O_RDWR);
  if(fd < 0){
    printf(1, "cannot create bigfile");
    exit(0);
  }
  for(i = 0; i < 20; i++){
    422b:	83 c3 01             	add    $0x1,%ebx
    422e:	83 fb 14             	cmp    $0x14,%ebx
    4231:	75 bd                	jne    41f0 <bigfile+0x50>
    if(write(fd, buf, 600) != 600){
      printf(1, "write bigfile failed\n");
      exit(0);
    }
  }
  close(fd);
    4233:	89 34 24             	mov    %esi,(%esp)
    4236:	e8 95 0d 00 00       	call   4fd0 <close>

  fd = open("bigfile", 0);
    423b:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    4242:	00 
    4243:	c7 04 24 8b 62 00 00 	movl   $0x628b,(%esp)
    424a:	e8 99 0d 00 00       	call   4fe8 <open>
  if(fd < 0){
    424f:	85 c0                	test   %eax,%eax
      exit(0);
    }
  }
  close(fd);

  fd = open("bigfile", 0);
    4251:	89 c7                	mov    %eax,%edi
  if(fd < 0){
    4253:	0f 88 10 01 00 00    	js     4369 <bigfile+0x1c9>
    printf(1, "cannot open bigfile\n");
    exit(0);
    4259:	31 f6                	xor    %esi,%esi
    425b:	31 db                	xor    %ebx,%ebx
    425d:	eb 2f                	jmp    428e <bigfile+0xee>
    425f:	90                   	nop
      printf(1, "read bigfile failed\n");
      exit(0);
    }
    if(cc == 0)
      break;
    if(cc != 300){
    4260:	3d 2c 01 00 00       	cmp    $0x12c,%eax
    4265:	0f 85 9e 00 00 00    	jne    4309 <bigfile+0x169>
      printf(1, "short read bigfile\n");
      exit(0);
    }
    if(buf[0] != i/2 || buf[299] != i/2){
    426b:	0f be 05 20 94 00 00 	movsbl 0x9420,%eax
    4272:	89 da                	mov    %ebx,%edx
    4274:	d1 fa                	sar    %edx
    4276:	39 d0                	cmp    %edx,%eax
    4278:	75 6f                	jne    42e9 <bigfile+0x149>
    427a:	0f be 15 4b 95 00 00 	movsbl 0x954b,%edx
    4281:	39 d0                	cmp    %edx,%eax
    4283:	75 64                	jne    42e9 <bigfile+0x149>
      printf(1, "read bigfile wrong data\n");
      exit(0);
    }
    total += cc;
    4285:	81 c6 2c 01 00 00    	add    $0x12c,%esi
  if(fd < 0){
    printf(1, "cannot open bigfile\n");
    exit(0);
  }
  total = 0;
  for(i = 0; ; i++){
    428b:	83 c3 01             	add    $0x1,%ebx
    cc = read(fd, buf, 300);
    428e:	c7 44 24 08 2c 01 00 	movl   $0x12c,0x8(%esp)
    4295:	00 
    4296:	c7 44 24 04 20 94 00 	movl   $0x9420,0x4(%esp)
    429d:	00 
    429e:	89 3c 24             	mov    %edi,(%esp)
    42a1:	e8 1a 0d 00 00       	call   4fc0 <read>
    if(cc < 0){
    42a6:	83 f8 00             	cmp    $0x0,%eax
    42a9:	7c 7e                	jl     4329 <bigfile+0x189>
      printf(1, "read bigfile failed\n");
      exit(0);
    }
    if(cc == 0)
    42ab:	75 b3                	jne    4260 <bigfile+0xc0>
      printf(1, "read bigfile wrong data\n");
      exit(0);
    }
    total += cc;
  }
  close(fd);
    42ad:	89 3c 24             	mov    %edi,(%esp)
    42b0:	e8 1b 0d 00 00       	call   4fd0 <close>
  if(total != 20*600){
    42b5:	81 fe e0 2e 00 00    	cmp    $0x2ee0,%esi
    42bb:	0f 85 e8 00 00 00    	jne    43a9 <bigfile+0x209>
    printf(1, "read bigfile wrong total\n");
    exit(0);
  }
  unlink("bigfile");
    42c1:	c7 04 24 8b 62 00 00 	movl   $0x628b,(%esp)
    42c8:	e8 2b 0d 00 00       	call   4ff8 <unlink>

  printf(1, "bigfile test ok\n");
    42cd:	c7 44 24 04 1a 63 00 	movl   $0x631a,0x4(%esp)
    42d4:	00 
    42d5:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    42dc:	e8 1f 0e 00 00       	call   5100 <printf>
}
    42e1:	83 c4 1c             	add    $0x1c,%esp
    42e4:	5b                   	pop    %ebx
    42e5:	5e                   	pop    %esi
    42e6:	5f                   	pop    %edi
    42e7:	5d                   	pop    %ebp
    42e8:	c3                   	ret    
    if(cc != 300){
      printf(1, "short read bigfile\n");
      exit(0);
    }
    if(buf[0] != i/2 || buf[299] != i/2){
      printf(1, "read bigfile wrong data\n");
    42e9:	c7 44 24 04 e7 62 00 	movl   $0x62e7,0x4(%esp)
    42f0:	00 
    42f1:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    42f8:	e8 03 0e 00 00       	call   5100 <printf>
      exit(0);
    42fd:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    4304:	e8 9f 0c 00 00       	call   4fa8 <exit>
      exit(0);
    }
    if(cc == 0)
      break;
    if(cc != 300){
      printf(1, "short read bigfile\n");
    4309:	c7 44 24 04 d3 62 00 	movl   $0x62d3,0x4(%esp)
    4310:	00 
    4311:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    4318:	e8 e3 0d 00 00       	call   5100 <printf>
      exit(0);
    431d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    4324:	e8 7f 0c 00 00       	call   4fa8 <exit>
  }
  total = 0;
  for(i = 0; ; i++){
    cc = read(fd, buf, 300);
    if(cc < 0){
      printf(1, "read bigfile failed\n");
    4329:	c7 44 24 04 be 62 00 	movl   $0x62be,0x4(%esp)
    4330:	00 
    4331:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    4338:	e8 c3 0d 00 00       	call   5100 <printf>
      exit(0);
    433d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    4344:	e8 5f 0c 00 00       	call   4fa8 <exit>
    exit(0);
  }
  for(i = 0; i < 20; i++){
    memset(buf, i, 600);
    if(write(fd, buf, 600) != 600){
      printf(1, "write bigfile failed\n");
    4349:	c7 44 24 04 93 62 00 	movl   $0x6293,0x4(%esp)
    4350:	00 
    4351:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    4358:	e8 a3 0d 00 00       	call   5100 <printf>
      exit(0);
    435d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    4364:	e8 3f 0c 00 00       	call   4fa8 <exit>
  }
  close(fd);

  fd = open("bigfile", 0);
  if(fd < 0){
    printf(1, "cannot open bigfile\n");
    4369:	c7 44 24 04 a9 62 00 	movl   $0x62a9,0x4(%esp)
    4370:	00 
    4371:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    4378:	e8 83 0d 00 00       	call   5100 <printf>
    exit(0);
    437d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    4384:	e8 1f 0c 00 00       	call   4fa8 <exit>
  printf(1, "bigfile test\n");

  unlink("bigfile");
  fd = open("bigfile", O_CREATE | O_RDWR);
  if(fd < 0){
    printf(1, "cannot create bigfile");
    4389:	c7 44 24 04 7d 62 00 	movl   $0x627d,0x4(%esp)
    4390:	00 
    4391:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    4398:	e8 63 0d 00 00       	call   5100 <printf>
    exit(0);
    439d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    43a4:	e8 ff 0b 00 00       	call   4fa8 <exit>
    }
    total += cc;
  }
  close(fd);
  if(total != 20*600){
    printf(1, "read bigfile wrong total\n");
    43a9:	c7 44 24 04 00 63 00 	movl   $0x6300,0x4(%esp)
    43b0:	00 
    43b1:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    43b8:	e8 43 0d 00 00       	call   5100 <printf>
    exit(0);
    43bd:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    43c4:	e8 df 0b 00 00       	call   4fa8 <exit>
    43c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000043d0 <concreate>:
}

// test concurrent create/link/unlink of the same file
void
concreate(void)
{
    43d0:	55                   	push   %ebp
    43d1:	89 e5                	mov    %esp,%ebp
    43d3:	57                   	push   %edi
    43d4:	56                   	push   %esi
    43d5:	53                   	push   %ebx
    char name[14];
  } de;

  printf(1, "concreate test\n");
  file[0] = 'C';
  file[2] = '\0';
    43d6:	31 db                	xor    %ebx,%ebx
}

// test concurrent create/link/unlink of the same file
void
concreate(void)
{
    43d8:	83 ec 6c             	sub    $0x6c,%esp
  struct {
    ushort inum;
    char name[14];
  } de;

  printf(1, "concreate test\n");
    43db:	c7 44 24 04 2b 63 00 	movl   $0x632b,0x4(%esp)
    43e2:	00 
    43e3:	8d 75 e5             	lea    -0x1b(%ebp),%esi
    43e6:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    43ed:	e8 0e 0d 00 00       	call   5100 <printf>
  file[0] = 'C';
    43f2:	c6 45 e5 43          	movb   $0x43,-0x1b(%ebp)
  file[2] = '\0';
    43f6:	c6 45 e7 00          	movb   $0x0,-0x19(%ebp)
    43fa:	eb 5a                	jmp    4456 <concreate+0x86>
    43fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(i = 0; i < 40; i++){
    file[1] = '0' + i;
    unlink(file);
    pid = fork();
    if(pid && (i % 3) == 1){
    4400:	b8 56 55 55 55       	mov    $0x55555556,%eax
    4405:	f7 eb                	imul   %ebx
    4407:	89 d8                	mov    %ebx,%eax
    4409:	c1 f8 1f             	sar    $0x1f,%eax
    440c:	29 c2                	sub    %eax,%edx
    440e:	8d 04 52             	lea    (%edx,%edx,2),%eax
    4411:	89 da                	mov    %ebx,%edx
    4413:	29 c2                	sub    %eax,%edx
    4415:	83 fa 01             	cmp    $0x1,%edx
    4418:	0f 84 8a 00 00 00    	je     44a8 <concreate+0xd8>
      link("C0", file);
    } else if(pid == 0 && (i % 5) == 1){
      link("C0", file);
    } else {
      fd = open(file, O_CREATE | O_RDWR);
    441e:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
    4425:	00 
    4426:	89 34 24             	mov    %esi,(%esp)
    4429:	e8 ba 0b 00 00       	call   4fe8 <open>
      if(fd < 0){
    442e:	85 c0                	test   %eax,%eax
    4430:	0f 88 66 02 00 00    	js     469c <concreate+0x2cc>
        printf(1, "concreate create %s failed\n", file);
        exit(0);
      }
      close(fd);
    4436:	89 04 24             	mov    %eax,(%esp)
    4439:	e8 92 0b 00 00       	call   4fd0 <close>
    }
    if(pid == 0)
    443e:	85 ff                	test   %edi,%edi
    4440:	74 59                	je     449b <concreate+0xcb>
  } de;

  printf(1, "concreate test\n");
  file[0] = 'C';
  file[2] = '\0';
  for(i = 0; i < 40; i++){
    4442:	83 c3 01             	add    $0x1,%ebx
      close(fd);
    }
    if(pid == 0)
      exit(0);
    else
      wait(&exit_status);
    4445:	c7 04 24 e0 6c 00 00 	movl   $0x6ce0,(%esp)
    444c:	e8 5f 0b 00 00       	call   4fb0 <wait>
  } de;

  printf(1, "concreate test\n");
  file[0] = 'C';
  file[2] = '\0';
  for(i = 0; i < 40; i++){
    4451:	83 fb 28             	cmp    $0x28,%ebx
    4454:	74 6a                	je     44c0 <concreate+0xf0>
    file[1] = '0' + i;
    4456:	8d 43 30             	lea    0x30(%ebx),%eax
    4459:	88 45 e6             	mov    %al,-0x1a(%ebp)
    unlink(file);
    445c:	89 34 24             	mov    %esi,(%esp)
    445f:	e8 94 0b 00 00       	call   4ff8 <unlink>
    pid = fork();
    4464:	e8 37 0b 00 00       	call   4fa0 <fork>
    if(pid && (i % 3) == 1){
    4469:	85 c0                	test   %eax,%eax
  file[0] = 'C';
  file[2] = '\0';
  for(i = 0; i < 40; i++){
    file[1] = '0' + i;
    unlink(file);
    pid = fork();
    446b:	89 c7                	mov    %eax,%edi
    if(pid && (i % 3) == 1){
    446d:	75 91                	jne    4400 <concreate+0x30>
      link("C0", file);
    } else if(pid == 0 && (i % 5) == 1){
    446f:	b8 67 66 66 66       	mov    $0x66666667,%eax
    4474:	f7 eb                	imul   %ebx
    4476:	89 d8                	mov    %ebx,%eax
    4478:	c1 f8 1f             	sar    $0x1f,%eax
    447b:	d1 fa                	sar    %edx
    447d:	29 c2                	sub    %eax,%edx
    447f:	8d 04 92             	lea    (%edx,%edx,4),%eax
    4482:	89 da                	mov    %ebx,%edx
    4484:	29 c2                	sub    %eax,%edx
    4486:	83 fa 01             	cmp    $0x1,%edx
    4489:	75 93                	jne    441e <concreate+0x4e>
      link("C0", file);
    448b:	89 74 24 04          	mov    %esi,0x4(%esp)
    448f:	c7 04 24 3b 63 00 00 	movl   $0x633b,(%esp)
    4496:	e8 6d 0b 00 00       	call   5008 <link>
      continue;
    if(de.name[0] == 'C' && de.name[2] == '\0'){
      i = de.name[1] - '0';
      if(i < 0 || i >= sizeof(fa)){
        printf(1, "concreate weird file %s\n", de.name);
        exit(0);
    449b:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    44a2:	e8 01 0b 00 00       	call   4fa8 <exit>
    44a7:	90                   	nop
  for(i = 0; i < 40; i++){
    file[1] = '0' + i;
    unlink(file);
    pid = fork();
    if(pid && (i % 3) == 1){
      link("C0", file);
    44a8:	89 74 24 04          	mov    %esi,0x4(%esp)
    44ac:	c7 04 24 3b 63 00 00 	movl   $0x633b,(%esp)
    44b3:	e8 50 0b 00 00       	call   5008 <link>
    44b8:	eb 88                	jmp    4442 <concreate+0x72>
    44ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      exit(0);
    else
      wait(&exit_status);
  }

  memset(fa, 0, sizeof(fa));
    44c0:	8d 45 ac             	lea    -0x54(%ebp),%eax
    44c3:	c7 44 24 08 28 00 00 	movl   $0x28,0x8(%esp)
    44ca:	00 
    44cb:	8d 7d d4             	lea    -0x2c(%ebp),%edi
    44ce:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    44d5:	00 
    44d6:	89 04 24             	mov    %eax,(%esp)
    44d9:	e8 42 09 00 00       	call   4e20 <memset>
  fd = open(".", 0);
    44de:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    44e5:	00 
    44e6:	c7 04 24 b2 5f 00 00 	movl   $0x5fb2,(%esp)
    44ed:	e8 f6 0a 00 00       	call   4fe8 <open>
    44f2:	c7 45 a4 00 00 00 00 	movl   $0x0,-0x5c(%ebp)
    44f9:	89 c3                	mov    %eax,%ebx
    44fb:	90                   	nop
    44fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  n = 0;
  while(read(fd, &de, sizeof(de)) > 0){
    4500:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
    4507:	00 
    4508:	89 7c 24 04          	mov    %edi,0x4(%esp)
    450c:	89 1c 24             	mov    %ebx,(%esp)
    450f:	e8 ac 0a 00 00       	call   4fc0 <read>
    4514:	85 c0                	test   %eax,%eax
    4516:	7e 40                	jle    4558 <concreate+0x188>
    if(de.inum == 0)
    4518:	66 83 7d d4 00       	cmpw   $0x0,-0x2c(%ebp)
    451d:	74 e1                	je     4500 <concreate+0x130>
      continue;
    if(de.name[0] == 'C' && de.name[2] == '\0'){
    451f:	80 7d d6 43          	cmpb   $0x43,-0x2a(%ebp)
    4523:	75 db                	jne    4500 <concreate+0x130>
    4525:	80 7d d8 00          	cmpb   $0x0,-0x28(%ebp)
    4529:	75 d5                	jne    4500 <concreate+0x130>
      i = de.name[1] - '0';
    452b:	0f be 45 d7          	movsbl -0x29(%ebp),%eax
    452f:	83 e8 30             	sub    $0x30,%eax
      if(i < 0 || i >= sizeof(fa)){
    4532:	83 f8 27             	cmp    $0x27,%eax
    4535:	0f 87 85 01 00 00    	ja     46c0 <concreate+0x2f0>
        printf(1, "concreate weird file %s\n", de.name);
        exit(0);
      }
      if(fa[i]){
    453b:	80 7c 05 ac 00       	cmpb   $0x0,-0x54(%ebp,%eax,1)
    4540:	0f 85 ba 01 00 00    	jne    4700 <concreate+0x330>
        printf(1, "concreate duplicate file %s\n", de.name);
        exit(0);
      }
      fa[i] = 1;
    4546:	c6 44 05 ac 01       	movb   $0x1,-0x54(%ebp,%eax,1)
      n++;
    454b:	83 45 a4 01          	addl   $0x1,-0x5c(%ebp)
    454f:	eb af                	jmp    4500 <concreate+0x130>
    4551:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    }
  }
  close(fd);
    4558:	89 1c 24             	mov    %ebx,(%esp)
    455b:	e8 70 0a 00 00       	call   4fd0 <close>

  if(n != 40){
    4560:	83 7d a4 28          	cmpl   $0x28,-0x5c(%ebp)
    4564:	0f 85 76 01 00 00    	jne    46e0 <concreate+0x310>
    printf(1, "concreate not enough files in directory listing\n");
    exit(0);
    456a:	31 db                	xor    %ebx,%ebx
    456c:	e9 94 00 00 00       	jmp    4605 <concreate+0x235>
    4571:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    pid = fork();
    if(pid < 0){
      printf(1, "fork failed\n");
      exit(0);
    }
    if(((i % 3) == 0 && pid == 0) ||
    4578:	83 f8 01             	cmp    $0x1,%eax
    457b:	0f 85 b8 00 00 00    	jne    4639 <concreate+0x269>
    4581:	85 ff                	test   %edi,%edi
    4583:	0f 84 b0 00 00 00    	je     4639 <concreate+0x269>
       ((i % 3) == 1 && pid != 0)){
      close(open(file, 0));
    4589:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    4590:	00 
    4591:	89 34 24             	mov    %esi,(%esp)
    4594:	e8 4f 0a 00 00       	call   4fe8 <open>
    4599:	89 04 24             	mov    %eax,(%esp)
    459c:	e8 2f 0a 00 00       	call   4fd0 <close>
      close(open(file, 0));
    45a1:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    45a8:	00 
    45a9:	89 34 24             	mov    %esi,(%esp)
    45ac:	e8 37 0a 00 00       	call   4fe8 <open>
    45b1:	89 04 24             	mov    %eax,(%esp)
    45b4:	e8 17 0a 00 00       	call   4fd0 <close>
      close(open(file, 0));
    45b9:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    45c0:	00 
    45c1:	89 34 24             	mov    %esi,(%esp)
    45c4:	e8 1f 0a 00 00       	call   4fe8 <open>
    45c9:	89 04 24             	mov    %eax,(%esp)
    45cc:	e8 ff 09 00 00       	call   4fd0 <close>
      close(open(file, 0));
    45d1:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    45d8:	00 
    45d9:	89 34 24             	mov    %esi,(%esp)
    45dc:	e8 07 0a 00 00       	call   4fe8 <open>
    45e1:	89 04 24             	mov    %eax,(%esp)
    45e4:	e8 e7 09 00 00       	call   4fd0 <close>
      unlink(file);
      unlink(file);
      unlink(file);
      unlink(file);
    }
    if(pid == 0)
    45e9:	85 ff                	test   %edi,%edi
    45eb:	0f 84 aa fe ff ff    	je     449b <concreate+0xcb>
  if(n != 40){
    printf(1, "concreate not enough files in directory listing\n");
    exit(0);
  }

  for(i = 0; i < 40; i++){
    45f1:	83 c3 01             	add    $0x1,%ebx
      unlink(file);
    }
    if(pid == 0)
      exit(0);
    else
      wait(&exit_status);
    45f4:	c7 04 24 e0 6c 00 00 	movl   $0x6ce0,(%esp)
    45fb:	e8 b0 09 00 00       	call   4fb0 <wait>
  if(n != 40){
    printf(1, "concreate not enough files in directory listing\n");
    exit(0);
  }

  for(i = 0; i < 40; i++){
    4600:	83 fb 28             	cmp    $0x28,%ebx
    4603:	74 5b                	je     4660 <concreate+0x290>
    file[1] = '0' + i;
    4605:	8d 43 30             	lea    0x30(%ebx),%eax
    4608:	88 45 e6             	mov    %al,-0x1a(%ebp)
    pid = fork();
    460b:	e8 90 09 00 00       	call   4fa0 <fork>
    if(pid < 0){
    4610:	85 c0                	test   %eax,%eax
    exit(0);
  }

  for(i = 0; i < 40; i++){
    file[1] = '0' + i;
    pid = fork();
    4612:	89 c7                	mov    %eax,%edi
    if(pid < 0){
    4614:	78 66                	js     467c <concreate+0x2ac>
      printf(1, "fork failed\n");
      exit(0);
    }
    if(((i % 3) == 0 && pid == 0) ||
    4616:	b8 56 55 55 55       	mov    $0x55555556,%eax
    461b:	f7 eb                	imul   %ebx
    461d:	89 d8                	mov    %ebx,%eax
    461f:	c1 f8 1f             	sar    $0x1f,%eax
    4622:	29 c2                	sub    %eax,%edx
    4624:	89 d8                	mov    %ebx,%eax
    4626:	8d 14 52             	lea    (%edx,%edx,2),%edx
    4629:	29 d0                	sub    %edx,%eax
    462b:	0f 85 47 ff ff ff    	jne    4578 <concreate+0x1a8>
    4631:	85 ff                	test   %edi,%edi
    4633:	0f 84 50 ff ff ff    	je     4589 <concreate+0x1b9>
      close(open(file, 0));
      close(open(file, 0));
      close(open(file, 0));
      close(open(file, 0));
    } else {
      unlink(file);
    4639:	89 34 24             	mov    %esi,(%esp)
    463c:	e8 b7 09 00 00       	call   4ff8 <unlink>
      unlink(file);
    4641:	89 34 24             	mov    %esi,(%esp)
    4644:	e8 af 09 00 00       	call   4ff8 <unlink>
      unlink(file);
    4649:	89 34 24             	mov    %esi,(%esp)
    464c:	e8 a7 09 00 00       	call   4ff8 <unlink>
      unlink(file);
    4651:	89 34 24             	mov    %esi,(%esp)
    4654:	e8 9f 09 00 00       	call   4ff8 <unlink>
    4659:	eb 8e                	jmp    45e9 <concreate+0x219>
    465b:	90                   	nop
    465c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      exit(0);
    else
      wait(&exit_status);
  }

  printf(1, "concreate ok\n");
    4660:	c7 44 24 04 90 63 00 	movl   $0x6390,0x4(%esp)
    4667:	00 
    4668:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    466f:	e8 8c 0a 00 00       	call   5100 <printf>
}
    4674:	83 c4 6c             	add    $0x6c,%esp
    4677:	5b                   	pop    %ebx
    4678:	5e                   	pop    %esi
    4679:	5f                   	pop    %edi
    467a:	5d                   	pop    %ebp
    467b:	c3                   	ret    

  for(i = 0; i < 40; i++){
    file[1] = '0' + i;
    pid = fork();
    if(pid < 0){
      printf(1, "fork failed\n");
    467c:	c7 44 24 04 df 58 00 	movl   $0x58df,0x4(%esp)
    4683:	00 
    4684:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    468b:	e8 70 0a 00 00       	call   5100 <printf>
      exit(0);
    4690:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    4697:	e8 0c 09 00 00       	call   4fa8 <exit>
    } else if(pid == 0 && (i % 5) == 1){
      link("C0", file);
    } else {
      fd = open(file, O_CREATE | O_RDWR);
      if(fd < 0){
        printf(1, "concreate create %s failed\n", file);
    469c:	89 74 24 08          	mov    %esi,0x8(%esp)
    46a0:	c7 44 24 04 3e 63 00 	movl   $0x633e,0x4(%esp)
    46a7:	00 
    46a8:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    46af:	e8 4c 0a 00 00       	call   5100 <printf>
        exit(0);
    46b4:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    46bb:	e8 e8 08 00 00       	call   4fa8 <exit>
    if(de.inum == 0)
      continue;
    if(de.name[0] == 'C' && de.name[2] == '\0'){
      i = de.name[1] - '0';
      if(i < 0 || i >= sizeof(fa)){
        printf(1, "concreate weird file %s\n", de.name);
    46c0:	8d 45 d6             	lea    -0x2a(%ebp),%eax
    46c3:	89 44 24 08          	mov    %eax,0x8(%esp)
    46c7:	c7 44 24 04 5a 63 00 	movl   $0x635a,0x4(%esp)
    46ce:	00 
    46cf:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    46d6:	e8 25 0a 00 00       	call   5100 <printf>
    46db:	e9 bb fd ff ff       	jmp    449b <concreate+0xcb>
    }
  }
  close(fd);

  if(n != 40){
    printf(1, "concreate not enough files in directory listing\n");
    46e0:	c7 44 24 04 28 6b 00 	movl   $0x6b28,0x4(%esp)
    46e7:	00 
    46e8:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    46ef:	e8 0c 0a 00 00       	call   5100 <printf>
    exit(0);
    46f4:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    46fb:	e8 a8 08 00 00       	call   4fa8 <exit>
      if(i < 0 || i >= sizeof(fa)){
        printf(1, "concreate weird file %s\n", de.name);
        exit(0);
      }
      if(fa[i]){
        printf(1, "concreate duplicate file %s\n", de.name);
    4700:	8d 45 d6             	lea    -0x2a(%ebp),%eax
    4703:	89 44 24 08          	mov    %eax,0x8(%esp)
    4707:	c7 44 24 04 73 63 00 	movl   $0x6373,0x4(%esp)
    470e:	00 
    470f:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    4716:	e8 e5 09 00 00       	call   5100 <printf>
        exit(0);
    471b:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    4722:	e8 81 08 00 00       	call   4fa8 <exit>
    4727:	89 f6                	mov    %esi,%esi
    4729:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00004730 <fourfiles>:

// four processes write different files at the same
// time, to test block allocation.
void
fourfiles(void)
{
    4730:	55                   	push   %ebp
    4731:	89 e5                	mov    %esp,%ebp
    4733:	57                   	push   %edi
    4734:	56                   	push   %esi
  int fd, pid, i, j, n, total, pi;
  char *names[] = { "f0", "f1", "f2", "f3" };
  char *fname;

  printf(1, "fourfiles test\n");
    4735:	be 9e 63 00 00       	mov    $0x639e,%esi

// four processes write different files at the same
// time, to test block allocation.
void
fourfiles(void)
{
    473a:	53                   	push   %ebx
  int fd, pid, i, j, n, total, pi;
  char *names[] = { "f0", "f1", "f2", "f3" };
  char *fname;

  printf(1, "fourfiles test\n");
    473b:	31 db                	xor    %ebx,%ebx

// four processes write different files at the same
// time, to test block allocation.
void
fourfiles(void)
{
    473d:	83 ec 3c             	sub    $0x3c,%esp
  int fd, pid, i, j, n, total, pi;
  char *names[] = { "f0", "f1", "f2", "f3" };
  char *fname;

  printf(1, "fourfiles test\n");
    4740:	c7 44 24 04 a4 63 00 	movl   $0x63a4,0x4(%esp)
    4747:	00 

  for(pi = 0; pi < 4; pi++){
    4748:	8d 7d d8             	lea    -0x28(%ebp),%edi
// time, to test block allocation.
void
fourfiles(void)
{
  int fd, pid, i, j, n, total, pi;
  char *names[] = { "f0", "f1", "f2", "f3" };
    474b:	c7 45 d8 9e 63 00 00 	movl   $0x639e,-0x28(%ebp)
    4752:	c7 45 dc e7 59 00 00 	movl   $0x59e7,-0x24(%ebp)
    4759:	c7 45 e0 eb 59 00 00 	movl   $0x59eb,-0x20(%ebp)
    4760:	c7 45 e4 a1 63 00 00 	movl   $0x63a1,-0x1c(%ebp)
  char *fname;

  printf(1, "fourfiles test\n");
    4767:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    476e:	e8 8d 09 00 00       	call   5100 <printf>

  for(pi = 0; pi < 4; pi++){
    fname = names[pi];
    unlink(fname);
    4773:	89 34 24             	mov    %esi,(%esp)
    4776:	e8 7d 08 00 00       	call   4ff8 <unlink>

    pid = fork();
    477b:	e8 20 08 00 00       	call   4fa0 <fork>
    if(pid < 0){
    4780:	83 f8 00             	cmp    $0x0,%eax
    4783:	0f 8c b6 01 00 00    	jl     493f <fourfiles+0x20f>
      printf(1, "fork failed\n");
      exit(0);
    }

    if(pid == 0){
    4789:	0f 84 07 01 00 00    	je     4896 <fourfiles+0x166>
  char *names[] = { "f0", "f1", "f2", "f3" };
  char *fname;

  printf(1, "fourfiles test\n");

  for(pi = 0; pi < 4; pi++){
    478f:	83 c3 01             	add    $0x1,%ebx
    4792:	83 fb 04             	cmp    $0x4,%ebx
    4795:	74 05                	je     479c <fourfiles+0x6c>
    4797:	8b 34 9f             	mov    (%edi,%ebx,4),%esi
    479a:	eb d7                	jmp    4773 <fourfiles+0x43>
      exit(0);
    }
  }

  for(pi = 0; pi < 4; pi++){
    wait(&exit_status);
    479c:	c7 04 24 e0 6c 00 00 	movl   $0x6ce0,(%esp)
    47a3:	bb 30 00 00 00       	mov    $0x30,%ebx
    47a8:	e8 03 08 00 00       	call   4fb0 <wait>
    47ad:	c7 04 24 e0 6c 00 00 	movl   $0x6ce0,(%esp)
    47b4:	e8 f7 07 00 00       	call   4fb0 <wait>
    47b9:	c7 04 24 e0 6c 00 00 	movl   $0x6ce0,(%esp)
    47c0:	e8 eb 07 00 00       	call   4fb0 <wait>
    47c5:	c7 04 24 e0 6c 00 00 	movl   $0x6ce0,(%esp)
    47cc:	e8 df 07 00 00       	call   4fb0 <wait>
    47d1:	c7 45 d4 9e 63 00 00 	movl   $0x639e,-0x2c(%ebp)
  }

  for(i = 0; i < 2; i++){
    fname = names[i];
    fd = open(fname, 0);
    47d8:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    47db:	31 f6                	xor    %esi,%esi
    47dd:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    47e4:	00 
    47e5:	89 04 24             	mov    %eax,(%esp)
    47e8:	e8 fb 07 00 00       	call   4fe8 <open>
    47ed:	89 c7                	mov    %eax,%edi
    47ef:	90                   	nop
    total = 0;
    while((n = read(fd, buf, sizeof(buf))) > 0){
    47f0:	c7 44 24 08 00 20 00 	movl   $0x2000,0x8(%esp)
    47f7:	00 
    47f8:	c7 44 24 04 20 94 00 	movl   $0x9420,0x4(%esp)
    47ff:	00 
    4800:	89 3c 24             	mov    %edi,(%esp)
    4803:	e8 b8 07 00 00       	call   4fc0 <read>
    4808:	85 c0                	test   %eax,%eax
    480a:	7e 1a                	jle    4826 <fourfiles+0xf6>
    480c:	31 d2                	xor    %edx,%edx
    480e:	66 90                	xchg   %ax,%ax
      for(j = 0; j < n; j++){
        if(buf[j] != '0'+i){
    4810:	0f be 8a 20 94 00 00 	movsbl 0x9420(%edx),%ecx
    4817:	39 d9                	cmp    %ebx,%ecx
    4819:	75 5b                	jne    4876 <fourfiles+0x146>
  for(i = 0; i < 2; i++){
    fname = names[i];
    fd = open(fname, 0);
    total = 0;
    while((n = read(fd, buf, sizeof(buf))) > 0){
      for(j = 0; j < n; j++){
    481b:	83 c2 01             	add    $0x1,%edx
    481e:	39 d0                	cmp    %edx,%eax
    4820:	7f ee                	jg     4810 <fourfiles+0xe0>
        if(buf[j] != '0'+i){
          printf(1, "wrong char\n");
          exit(0);
        }
      }
      total += n;
    4822:	01 c6                	add    %eax,%esi
    4824:	eb ca                	jmp    47f0 <fourfiles+0xc0>
    }
    close(fd);
    4826:	89 3c 24             	mov    %edi,(%esp)
    4829:	e8 a2 07 00 00       	call   4fd0 <close>
    if(total != 12*500){
    482e:	81 fe 70 17 00 00    	cmp    $0x1770,%esi
    4834:	0f 85 e1 00 00 00    	jne    491b <fourfiles+0x1eb>
      printf(1, "wrong length %d\n", total);
      exit(0);
    }
    unlink(fname);
    483a:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    483d:	89 04 24             	mov    %eax,(%esp)
    4840:	e8 b3 07 00 00       	call   4ff8 <unlink>

  for(pi = 0; pi < 4; pi++){
    wait(&exit_status);
  }

  for(i = 0; i < 2; i++){
    4845:	83 fb 31             	cmp    $0x31,%ebx
    4848:	75 1c                	jne    4866 <fourfiles+0x136>
      exit(0);
    }
    unlink(fname);
  }

  printf(1, "fourfiles ok\n");
    484a:	c7 44 24 04 e2 63 00 	movl   $0x63e2,0x4(%esp)
    4851:	00 
    4852:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    4859:	e8 a2 08 00 00       	call   5100 <printf>
}
    485e:	83 c4 3c             	add    $0x3c,%esp
    4861:	5b                   	pop    %ebx
    4862:	5e                   	pop    %esi
    4863:	5f                   	pop    %edi
    4864:	5d                   	pop    %ebp
    4865:	c3                   	ret    

  for(pi = 0; pi < 4; pi++){
    wait(&exit_status);
  }

  for(i = 0; i < 2; i++){
    4866:	8b 45 dc             	mov    -0x24(%ebp),%eax
    4869:	bb 31 00 00 00       	mov    $0x31,%ebx
    486e:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    4871:	e9 62 ff ff ff       	jmp    47d8 <fourfiles+0xa8>
    fd = open(fname, 0);
    total = 0;
    while((n = read(fd, buf, sizeof(buf))) > 0){
      for(j = 0; j < n; j++){
        if(buf[j] != '0'+i){
          printf(1, "wrong char\n");
    4876:	c7 44 24 04 c5 63 00 	movl   $0x63c5,0x4(%esp)
    487d:	00 
    487e:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    4885:	e8 76 08 00 00       	call   5100 <printf>
          exit(0);
    488a:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    4891:	e8 12 07 00 00       	call   4fa8 <exit>
      printf(1, "fork failed\n");
      exit(0);
    }

    if(pid == 0){
      fd = open(fname, O_CREATE | O_RDWR);
    4896:	89 34 24             	mov    %esi,(%esp)
    4899:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
    48a0:	00 
    48a1:	e8 42 07 00 00       	call   4fe8 <open>
      if(fd < 0){
    48a6:	85 c0                	test   %eax,%eax
      printf(1, "fork failed\n");
      exit(0);
    }

    if(pid == 0){
      fd = open(fname, O_CREATE | O_RDWR);
    48a8:	89 c6                	mov    %eax,%esi
      if(fd < 0){
    48aa:	0f 88 af 00 00 00    	js     495f <fourfiles+0x22f>
        printf(1, "create failed\n");
        exit(0);
      }

      memset(buf, '0'+pi, 512);
    48b0:	83 c3 30             	add    $0x30,%ebx
    48b3:	89 5c 24 04          	mov    %ebx,0x4(%esp)
    48b7:	31 db                	xor    %ebx,%ebx
    48b9:	c7 44 24 08 00 02 00 	movl   $0x200,0x8(%esp)
    48c0:	00 
    48c1:	c7 04 24 20 94 00 00 	movl   $0x9420,(%esp)
    48c8:	e8 53 05 00 00       	call   4e20 <memset>
    48cd:	eb 09                	jmp    48d8 <fourfiles+0x1a8>
    48cf:	90                   	nop
      for(i = 0; i < 12; i++){
    48d0:	83 c3 01             	add    $0x1,%ebx
    48d3:	83 fb 0c             	cmp    $0xc,%ebx
    48d6:	74 b2                	je     488a <fourfiles+0x15a>
        if((n = write(fd, buf, 500)) != 500){
    48d8:	c7 44 24 08 f4 01 00 	movl   $0x1f4,0x8(%esp)
    48df:	00 
    48e0:	c7 44 24 04 20 94 00 	movl   $0x9420,0x4(%esp)
    48e7:	00 
    48e8:	89 34 24             	mov    %esi,(%esp)
    48eb:	e8 d8 06 00 00       	call   4fc8 <write>
    48f0:	3d f4 01 00 00       	cmp    $0x1f4,%eax
    48f5:	74 d9                	je     48d0 <fourfiles+0x1a0>
          printf(1, "write failed %d\n", n);
    48f7:	89 44 24 08          	mov    %eax,0x8(%esp)
    48fb:	c7 44 24 04 b4 63 00 	movl   $0x63b4,0x4(%esp)
    4902:	00 
    4903:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    490a:	e8 f1 07 00 00       	call   5100 <printf>
          exit(0);
    490f:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    4916:	e8 8d 06 00 00       	call   4fa8 <exit>
      }
      total += n;
    }
    close(fd);
    if(total != 12*500){
      printf(1, "wrong length %d\n", total);
    491b:	89 74 24 08          	mov    %esi,0x8(%esp)
    491f:	c7 44 24 04 d1 63 00 	movl   $0x63d1,0x4(%esp)
    4926:	00 
    4927:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    492e:	e8 cd 07 00 00       	call   5100 <printf>
      exit(0);
    4933:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    493a:	e8 69 06 00 00       	call   4fa8 <exit>
    fname = names[pi];
    unlink(fname);

    pid = fork();
    if(pid < 0){
      printf(1, "fork failed\n");
    493f:	c7 44 24 04 df 58 00 	movl   $0x58df,0x4(%esp)
    4946:	00 
    4947:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    494e:	e8 ad 07 00 00       	call   5100 <printf>
      exit(0);
    4953:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    495a:	e8 49 06 00 00       	call   4fa8 <exit>
    }

    if(pid == 0){
      fd = open(fname, O_CREATE | O_RDWR);
      if(fd < 0){
        printf(1, "create failed\n");
    495f:	c7 44 24 04 75 59 00 	movl   $0x5975,0x4(%esp)
    4966:	00 
    4967:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    496e:	e8 8d 07 00 00       	call   5100 <printf>
        exit(0);
    4973:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    497a:	e8 29 06 00 00       	call   4fa8 <exit>
    497f:	90                   	nop

00004980 <sharedfd>:

// two processes write to the same file descriptor
// is the offset shared? does inode locking work?
void
sharedfd(void)
{
    4980:	55                   	push   %ebp
    4981:	89 e5                	mov    %esp,%ebp
    4983:	57                   	push   %edi
    4984:	56                   	push   %esi
    4985:	53                   	push   %ebx
    4986:	83 ec 3c             	sub    $0x3c,%esp
  int fd, pid, i, n, nc, np;
  char buf[10];

  printf(1, "sharedfd test\n");
    4989:	c7 44 24 04 f0 63 00 	movl   $0x63f0,0x4(%esp)
    4990:	00 
    4991:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    4998:	e8 63 07 00 00       	call   5100 <printf>

  unlink("sharedfd");
    499d:	c7 04 24 ff 63 00 00 	movl   $0x63ff,(%esp)
    49a4:	e8 4f 06 00 00       	call   4ff8 <unlink>
  fd = open("sharedfd", O_CREATE|O_RDWR);
    49a9:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
    49b0:	00 
    49b1:	c7 04 24 ff 63 00 00 	movl   $0x63ff,(%esp)
    49b8:	e8 2b 06 00 00       	call   4fe8 <open>
  if(fd < 0){
    49bd:	85 c0                	test   %eax,%eax
  char buf[10];

  printf(1, "sharedfd test\n");

  unlink("sharedfd");
  fd = open("sharedfd", O_CREATE|O_RDWR);
    49bf:	89 c7                	mov    %eax,%edi
  if(fd < 0){
    49c1:	0f 88 35 01 00 00    	js     4afc <sharedfd+0x17c>
    printf(1, "fstests: cannot open sharedfd for writing");
    return;
  }
  pid = fork();
    49c7:	e8 d4 05 00 00       	call   4fa0 <fork>
  memset(buf, pid==0?'c':'p', sizeof(buf));
    49cc:	8d 75 de             	lea    -0x22(%ebp),%esi
    49cf:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
    49d6:	00 
    49d7:	89 34 24             	mov    %esi,(%esp)
    49da:	83 f8 01             	cmp    $0x1,%eax
  fd = open("sharedfd", O_CREATE|O_RDWR);
  if(fd < 0){
    printf(1, "fstests: cannot open sharedfd for writing");
    return;
  }
  pid = fork();
    49dd:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  memset(buf, pid==0?'c':'p', sizeof(buf));
    49e0:	19 c0                	sbb    %eax,%eax
    49e2:	31 db                	xor    %ebx,%ebx
    49e4:	83 e0 f3             	and    $0xfffffff3,%eax
    49e7:	83 c0 70             	add    $0x70,%eax
    49ea:	89 44 24 04          	mov    %eax,0x4(%esp)
    49ee:	e8 2d 04 00 00       	call   4e20 <memset>
    49f3:	eb 0e                	jmp    4a03 <sharedfd+0x83>
    49f5:	8d 76 00             	lea    0x0(%esi),%esi
  for(i = 0; i < 1000; i++){
    49f8:	83 c3 01             	add    $0x1,%ebx
    49fb:	81 fb e8 03 00 00    	cmp    $0x3e8,%ebx
    4a01:	74 2d                	je     4a30 <sharedfd+0xb0>
    if(write(fd, buf, sizeof(buf)) != sizeof(buf)){
    4a03:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
    4a0a:	00 
    4a0b:	89 74 24 04          	mov    %esi,0x4(%esp)
    4a0f:	89 3c 24             	mov    %edi,(%esp)
    4a12:	e8 b1 05 00 00       	call   4fc8 <write>
    4a17:	83 f8 0a             	cmp    $0xa,%eax
    4a1a:	74 dc                	je     49f8 <sharedfd+0x78>
      printf(1, "fstests: write sharedfd failed\n");
    4a1c:	c7 44 24 04 88 6b 00 	movl   $0x6b88,0x4(%esp)
    4a23:	00 
    4a24:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    4a2b:	e8 d0 06 00 00       	call   5100 <printf>
      break;
    }
  }
  if(pid == 0)
    4a30:	8b 55 d4             	mov    -0x2c(%ebp),%edx
    4a33:	85 d2                	test   %edx,%edx
    4a35:	0f 84 0f 01 00 00    	je     4b4a <sharedfd+0x1ca>
    exit(0);
  else
    wait(&exit_status);
    4a3b:	c7 04 24 e0 6c 00 00 	movl   $0x6ce0,(%esp)
  close(fd);
  fd = open("sharedfd", 0);
  if(fd < 0){
    4a42:	31 db                	xor    %ebx,%ebx
    }
  }
  if(pid == 0)
    exit(0);
  else
    wait(&exit_status);
    4a44:	e8 67 05 00 00       	call   4fb0 <wait>
  close(fd);
    4a49:	89 3c 24             	mov    %edi,(%esp)
  fd = open("sharedfd", 0);
  if(fd < 0){
    4a4c:	31 ff                	xor    %edi,%edi
  }
  if(pid == 0)
    exit(0);
  else
    wait(&exit_status);
  close(fd);
    4a4e:	e8 7d 05 00 00       	call   4fd0 <close>
  fd = open("sharedfd", 0);
    4a53:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    4a5a:	00 
    4a5b:	c7 04 24 ff 63 00 00 	movl   $0x63ff,(%esp)
    4a62:	e8 81 05 00 00       	call   4fe8 <open>
  if(fd < 0){
    4a67:	85 c0                	test   %eax,%eax
  if(pid == 0)
    exit(0);
  else
    wait(&exit_status);
  close(fd);
  fd = open("sharedfd", 0);
    4a69:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  if(fd < 0){
    4a6c:	0f 88 a6 00 00 00    	js     4b18 <sharedfd+0x198>
    4a72:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    printf(1, "fstests: cannot open sharedfd for reading\n");
    return;
  }
  nc = np = 0;
  while((n = read(fd, buf, sizeof(buf))) > 0){
    4a78:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    4a7b:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
    4a82:	00 
    4a83:	89 74 24 04          	mov    %esi,0x4(%esp)
    4a87:	89 04 24             	mov    %eax,(%esp)
    4a8a:	e8 31 05 00 00       	call   4fc0 <read>
    4a8f:	85 c0                	test   %eax,%eax
    4a91:	7e 26                	jle    4ab9 <sharedfd+0x139>
    wait(&exit_status);
  close(fd);
  fd = open("sharedfd", 0);
  if(fd < 0){
    printf(1, "fstests: cannot open sharedfd for reading\n");
    return;
    4a93:	31 c0                	xor    %eax,%eax
    4a95:	eb 14                	jmp    4aab <sharedfd+0x12b>
    4a97:	90                   	nop
  while((n = read(fd, buf, sizeof(buf))) > 0){
    for(i = 0; i < sizeof(buf); i++){
      if(buf[i] == 'c')
        nc++;
      if(buf[i] == 'p')
        np++;
    4a98:	80 fa 70             	cmp    $0x70,%dl
    4a9b:	0f 94 c2             	sete   %dl
    4a9e:	0f b6 d2             	movzbl %dl,%edx
    4aa1:	01 d3                	add    %edx,%ebx
    printf(1, "fstests: cannot open sharedfd for reading\n");
    return;
  }
  nc = np = 0;
  while((n = read(fd, buf, sizeof(buf))) > 0){
    for(i = 0; i < sizeof(buf); i++){
    4aa3:	83 c0 01             	add    $0x1,%eax
    4aa6:	83 f8 0a             	cmp    $0xa,%eax
    4aa9:	74 cd                	je     4a78 <sharedfd+0xf8>
      if(buf[i] == 'c')
    4aab:	0f b6 14 06          	movzbl (%esi,%eax,1),%edx
    4aaf:	80 fa 63             	cmp    $0x63,%dl
    4ab2:	75 e4                	jne    4a98 <sharedfd+0x118>
        nc++;
    4ab4:	83 c7 01             	add    $0x1,%edi
    4ab7:	eb ea                	jmp    4aa3 <sharedfd+0x123>
      if(buf[i] == 'p')
        np++;
    }
  }
  close(fd);
    4ab9:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    4abc:	89 04 24             	mov    %eax,(%esp)
    4abf:	e8 0c 05 00 00       	call   4fd0 <close>
  unlink("sharedfd");
    4ac4:	c7 04 24 ff 63 00 00 	movl   $0x63ff,(%esp)
    4acb:	e8 28 05 00 00       	call   4ff8 <unlink>
  if(nc == 10000 && np == 10000){
    4ad0:	81 fb 10 27 00 00    	cmp    $0x2710,%ebx
    4ad6:	75 56                	jne    4b2e <sharedfd+0x1ae>
    4ad8:	81 ff 10 27 00 00    	cmp    $0x2710,%edi
    4ade:	75 4e                	jne    4b2e <sharedfd+0x1ae>
    printf(1, "sharedfd ok\n");
    4ae0:	c7 44 24 04 08 64 00 	movl   $0x6408,0x4(%esp)
    4ae7:	00 
    4ae8:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    4aef:	e8 0c 06 00 00       	call   5100 <printf>
  } else {
    printf(1, "sharedfd oops %d %d\n", nc, np);
    exit(0);
  }
}
    4af4:	83 c4 3c             	add    $0x3c,%esp
    4af7:	5b                   	pop    %ebx
    4af8:	5e                   	pop    %esi
    4af9:	5f                   	pop    %edi
    4afa:	5d                   	pop    %ebp
    4afb:	c3                   	ret    
  printf(1, "sharedfd test\n");

  unlink("sharedfd");
  fd = open("sharedfd", O_CREATE|O_RDWR);
  if(fd < 0){
    printf(1, "fstests: cannot open sharedfd for writing");
    4afc:	c7 44 24 04 5c 6b 00 	movl   $0x6b5c,0x4(%esp)
    4b03:	00 
    4b04:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    4b0b:	e8 f0 05 00 00       	call   5100 <printf>
    printf(1, "sharedfd ok\n");
  } else {
    printf(1, "sharedfd oops %d %d\n", nc, np);
    exit(0);
  }
}
    4b10:	83 c4 3c             	add    $0x3c,%esp
    4b13:	5b                   	pop    %ebx
    4b14:	5e                   	pop    %esi
    4b15:	5f                   	pop    %edi
    4b16:	5d                   	pop    %ebp
    4b17:	c3                   	ret    
  else
    wait(&exit_status);
  close(fd);
  fd = open("sharedfd", 0);
  if(fd < 0){
    printf(1, "fstests: cannot open sharedfd for reading\n");
    4b18:	c7 44 24 04 a8 6b 00 	movl   $0x6ba8,0x4(%esp)
    4b1f:	00 
    4b20:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    4b27:	e8 d4 05 00 00       	call   5100 <printf>
    return;
    4b2c:	eb c6                	jmp    4af4 <sharedfd+0x174>
  close(fd);
  unlink("sharedfd");
  if(nc == 10000 && np == 10000){
    printf(1, "sharedfd ok\n");
  } else {
    printf(1, "sharedfd oops %d %d\n", nc, np);
    4b2e:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
    4b32:	89 7c 24 08          	mov    %edi,0x8(%esp)
    4b36:	c7 44 24 04 15 64 00 	movl   $0x6415,0x4(%esp)
    4b3d:	00 
    4b3e:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    4b45:	e8 b6 05 00 00       	call   5100 <printf>
    exit(0);
    4b4a:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    4b51:	e8 52 04 00 00       	call   4fa8 <exit>
    4b56:	8d 76 00             	lea    0x0(%esi),%esi
    4b59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00004b60 <mem>:
  printf(1, "exitwait ok\n");
}

void
mem(void)
{
    4b60:	55                   	push   %ebp
    4b61:	89 e5                	mov    %esp,%ebp
    4b63:	57                   	push   %edi
    4b64:	56                   	push   %esi
    4b65:	53                   	push   %ebx
  void *m1, *m2;
  int pid, ppid;

  printf(1, "mem test\n");
  ppid = getpid();
  if((pid = fork()) == 0){
    4b66:	31 db                	xor    %ebx,%ebx
  printf(1, "exitwait ok\n");
}

void
mem(void)
{
    4b68:	83 ec 1c             	sub    $0x1c,%esp
  void *m1, *m2;
  int pid, ppid;

  printf(1, "mem test\n");
    4b6b:	c7 44 24 04 2a 64 00 	movl   $0x642a,0x4(%esp)
    4b72:	00 
    4b73:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    4b7a:	e8 81 05 00 00       	call   5100 <printf>
  ppid = getpid();
    4b7f:	e8 a4 04 00 00       	call   5028 <getpid>
    4b84:	89 c6                	mov    %eax,%esi
  if((pid = fork()) == 0){
    4b86:	e8 15 04 00 00       	call   4fa0 <fork>
    4b8b:	85 c0                	test   %eax,%eax
    4b8d:	74 0d                	je     4b9c <mem+0x3c>
    4b8f:	90                   	nop
    4b90:	eb 66                	jmp    4bf8 <mem+0x98>
    4b92:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    m1 = 0;
    while((m2 = malloc(10001)) != 0){
      *(char**)m2 = m1;
    4b98:	89 18                	mov    %ebx,(%eax)
    4b9a:	89 c3                	mov    %eax,%ebx

  printf(1, "mem test\n");
  ppid = getpid();
  if((pid = fork()) == 0){
    m1 = 0;
    while((m2 = malloc(10001)) != 0){
    4b9c:	c7 04 24 11 27 00 00 	movl   $0x2711,(%esp)
    4ba3:	e8 d8 07 00 00       	call   5380 <malloc>
    4ba8:	85 c0                	test   %eax,%eax
    4baa:	75 ec                	jne    4b98 <mem+0x38>
      *(char**)m2 = m1;
      m1 = m2;
    }
    while(m1){
    4bac:	85 db                	test   %ebx,%ebx
    4bae:	74 10                	je     4bc0 <mem+0x60>
      m2 = *(char**)m1;
    4bb0:	8b 3b                	mov    (%ebx),%edi
      free(m1);
    4bb2:	89 1c 24             	mov    %ebx,(%esp)
    4bb5:	e8 36 07 00 00       	call   52f0 <free>
    4bba:	89 fb                	mov    %edi,%ebx
    m1 = 0;
    while((m2 = malloc(10001)) != 0){
      *(char**)m2 = m1;
      m1 = m2;
    }
    while(m1){
    4bbc:	85 db                	test   %ebx,%ebx
    4bbe:	75 f0                	jne    4bb0 <mem+0x50>
      m2 = *(char**)m1;
      free(m1);
      m1 = m2;
    }
    m1 = malloc(1024*20);
    4bc0:	c7 04 24 00 50 00 00 	movl   $0x5000,(%esp)
    4bc7:	e8 b4 07 00 00       	call   5380 <malloc>
    if(m1 == 0){
    4bcc:	85 c0                	test   %eax,%eax
    4bce:	74 40                	je     4c10 <mem+0xb0>
      printf(1, "couldn't allocate mem?!!\n");
      kill(ppid);
      exit(0);
    }
    free(m1);
    4bd0:	89 04 24             	mov    %eax,(%esp)
    4bd3:	e8 18 07 00 00       	call   52f0 <free>
    printf(1, "mem ok\n");
    4bd8:	c7 44 24 04 4e 64 00 	movl   $0x644e,0x4(%esp)
    4bdf:	00 
    4be0:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    4be7:	e8 14 05 00 00       	call   5100 <printf>
    exit(0);
    4bec:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    4bf3:	e8 b0 03 00 00       	call   4fa8 <exit>
  } else {
    wait(&exit_status);
    4bf8:	c7 04 24 e0 6c 00 00 	movl   $0x6ce0,(%esp)
    4bff:	e8 ac 03 00 00       	call   4fb0 <wait>
  }
}
    4c04:	83 c4 1c             	add    $0x1c,%esp
    4c07:	5b                   	pop    %ebx
    4c08:	5e                   	pop    %esi
    4c09:	5f                   	pop    %edi
    4c0a:	5d                   	pop    %ebp
    4c0b:	c3                   	ret    
    4c0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      free(m1);
      m1 = m2;
    }
    m1 = malloc(1024*20);
    if(m1 == 0){
      printf(1, "couldn't allocate mem?!!\n");
    4c10:	c7 44 24 04 34 64 00 	movl   $0x6434,0x4(%esp)
    4c17:	00 
    4c18:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    4c1f:	e8 dc 04 00 00       	call   5100 <printf>
      kill(ppid);
    4c24:	89 34 24             	mov    %esi,(%esp)
    4c27:	e8 ac 03 00 00       	call   4fd8 <kill>
      exit(0);
    4c2c:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    4c33:	e8 70 03 00 00       	call   4fa8 <exit>
    4c38:	90                   	nop
    4c39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00004c40 <main>:
  return randstate;
}

int
main(int argc, char *argv[])
{
    4c40:	55                   	push   %ebp
    4c41:	89 e5                	mov    %esp,%ebp
    4c43:	83 e4 f0             	and    $0xfffffff0,%esp
    4c46:	83 ec 10             	sub    $0x10,%esp
  printf(1, "usertests starting\n");
    4c49:	c7 44 24 04 56 64 00 	movl   $0x6456,0x4(%esp)
    4c50:	00 
    4c51:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    4c58:	e8 a3 04 00 00       	call   5100 <printf>

  if(open("usertests.ran", 0) >= 0){
    4c5d:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    4c64:	00 
    4c65:	c7 04 24 6a 64 00 00 	movl   $0x646a,(%esp)
    4c6c:	e8 77 03 00 00       	call   4fe8 <open>
    4c71:	85 c0                	test   %eax,%eax
    4c73:	78 23                	js     4c98 <main+0x58>
    printf(1, "already ran user tests -- rebuild fs.img\n");
    4c75:	c7 44 24 04 d4 6b 00 	movl   $0x6bd4,0x4(%esp)
    4c7c:	00 
    4c7d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    4c84:	e8 77 04 00 00       	call   5100 <printf>
    exit(0);
    4c89:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    4c90:	e8 13 03 00 00       	call   4fa8 <exit>
    4c95:	8d 76 00             	lea    0x0(%esi),%esi
  }
  close(open("usertests.ran", O_CREATE));
    4c98:	c7 44 24 04 00 02 00 	movl   $0x200,0x4(%esp)
    4c9f:	00 
    4ca0:	c7 04 24 6a 64 00 00 	movl   $0x646a,(%esp)
    4ca7:	e8 3c 03 00 00       	call   4fe8 <open>
    4cac:	89 04 24             	mov    %eax,(%esp)
    4caf:	e8 1c 03 00 00       	call   4fd0 <close>

  argptest();
    4cb4:	e8 97 c4 ff ff       	call   1150 <argptest>
  createdelete();
    4cb9:	e8 62 cc ff ff       	call   1920 <createdelete>
    4cbe:	66 90                	xchg   %ax,%ax
  linkunlink();
    4cc0:	e8 ab d6 ff ff       	call   2370 <linkunlink>
  concreate();
    4cc5:	e8 06 f7 ff ff       	call   43d0 <concreate>
  fourfiles();
    4cca:	e8 61 fa ff ff       	call   4730 <fourfiles>
    4ccf:	90                   	nop
  sharedfd();
    4cd0:	e8 ab fc ff ff       	call   4980 <sharedfd>

  bigargtest();
    4cd5:	e8 f6 d2 ff ff       	call   1fd0 <bigargtest>
  bigwrite();
    4cda:	e8 31 c9 ff ff       	call   1610 <bigwrite>
    4cdf:	90                   	nop
  bigargtest();
    4ce0:	e8 eb d2 ff ff       	call   1fd0 <bigargtest>
  bsstest();
    4ce5:	e8 46 c3 ff ff       	call   1030 <bsstest>
  sbrktest();
    4cea:	e8 51 da ff ff       	call   2740 <sbrktest>
    4cef:	90                   	nop
  validatetest();
    4cf0:	e8 5b d4 ff ff       	call   2150 <validatetest>

  opentest();
    4cf5:	e8 b6 c3 ff ff       	call   10b0 <opentest>
  writetest();
    4cfa:	e8 01 d1 ff ff       	call   1e00 <writetest>
    4cff:	90                   	nop
  writetest1();
    4d00:	e8 3b cf ff ff       	call   1c40 <writetest1>
  createtest();
    4d05:	e8 86 ce ff ff       	call   1b90 <createtest>

  openiputtest();
    4d0a:	e8 31 e3 ff ff       	call   3040 <openiputtest>
    4d0f:	90                   	nop
  exitiputtest();
    4d10:	e8 eb f2 ff ff       	call   4000 <exitiputtest>
  iputtest();
    4d15:	e8 c6 f3 ff ff       	call   40e0 <iputtest>

  mem();
    4d1a:	e8 41 fe ff ff       	call   4b60 <mem>
    4d1f:	90                   	nop
  pipe1();
    4d20:	e8 cb df ff ff       	call   2cf0 <pipe1>
  preempt();
    4d25:	e8 56 de ff ff       	call   2b80 <preempt>
  exitwait();
    4d2a:	e8 31 c6 ff ff       	call   1360 <exitwait>
    4d2f:	90                   	nop

  rmdot();
    4d30:	e8 bb e7 ff ff       	call   34f0 <rmdot>
  fourteen();
    4d35:	e8 86 e1 ff ff       	call   2ec0 <fourteen>
  bigfile();
    4d3a:	e8 61 f4 ff ff       	call   41a0 <bigfile>
    4d3f:	90                   	nop
  subdir();
    4d40:	e8 7b e9 ff ff       	call   36c0 <subdir>
  linktest();
    4d45:	e8 56 d7 ff ff       	call   24a0 <linktest>
  unlinkread();
    4d4a:	e8 d1 c9 ff ff       	call   1720 <unlinkread>
    4d4f:	90                   	nop
  dirfile();
    4d50:	e8 1b e5 ff ff       	call   3270 <dirfile>
  iref();
    4d55:	e8 e6 e3 ff ff       	call   3140 <iref>
  forktest();
    4d5a:	e8 21 c5 ff ff       	call   1280 <forktest>
    4d5f:	90                   	nop
  bigdir(); // slow
    4d60:	e8 ab d4 ff ff       	call   2210 <bigdir>

  uio();
    4d65:	e8 76 c4 ff ff       	call   11e0 <uio>

  exectest();
    4d6a:	e8 81 d3 ff ff       	call   20f0 <exectest>

  exit(0);
    4d6f:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    4d76:	e8 2d 02 00 00       	call   4fa8 <exit>
    4d7b:	90                   	nop
    4d7c:	90                   	nop
    4d7d:	90                   	nop
    4d7e:	90                   	nop
    4d7f:	90                   	nop

00004d80 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
    4d80:	55                   	push   %ebp
    4d81:	31 d2                	xor    %edx,%edx
    4d83:	89 e5                	mov    %esp,%ebp
    4d85:	8b 45 08             	mov    0x8(%ebp),%eax
    4d88:	53                   	push   %ebx
    4d89:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    4d8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
    4d90:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
    4d94:	88 0c 10             	mov    %cl,(%eax,%edx,1)
    4d97:	83 c2 01             	add    $0x1,%edx
    4d9a:	84 c9                	test   %cl,%cl
    4d9c:	75 f2                	jne    4d90 <strcpy+0x10>
    ;
  return os;
}
    4d9e:	5b                   	pop    %ebx
    4d9f:	5d                   	pop    %ebp
    4da0:	c3                   	ret    
    4da1:	eb 0d                	jmp    4db0 <strcmp>
    4da3:	90                   	nop
    4da4:	90                   	nop
    4da5:	90                   	nop
    4da6:	90                   	nop
    4da7:	90                   	nop
    4da8:	90                   	nop
    4da9:	90                   	nop
    4daa:	90                   	nop
    4dab:	90                   	nop
    4dac:	90                   	nop
    4dad:	90                   	nop
    4dae:	90                   	nop
    4daf:	90                   	nop

00004db0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    4db0:	55                   	push   %ebp
    4db1:	89 e5                	mov    %esp,%ebp
    4db3:	8b 4d 08             	mov    0x8(%ebp),%ecx
    4db6:	53                   	push   %ebx
    4db7:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(*p && *p == *q)
    4dba:	0f b6 01             	movzbl (%ecx),%eax
    4dbd:	84 c0                	test   %al,%al
    4dbf:	75 14                	jne    4dd5 <strcmp+0x25>
    4dc1:	eb 25                	jmp    4de8 <strcmp+0x38>
    4dc3:	90                   	nop
    4dc4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    p++, q++;
    4dc8:	83 c1 01             	add    $0x1,%ecx
    4dcb:	83 c2 01             	add    $0x1,%edx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
    4dce:	0f b6 01             	movzbl (%ecx),%eax
    4dd1:	84 c0                	test   %al,%al
    4dd3:	74 13                	je     4de8 <strcmp+0x38>
    4dd5:	0f b6 1a             	movzbl (%edx),%ebx
    4dd8:	38 d8                	cmp    %bl,%al
    4dda:	74 ec                	je     4dc8 <strcmp+0x18>
    4ddc:	0f b6 db             	movzbl %bl,%ebx
    4ddf:	0f b6 c0             	movzbl %al,%eax
    4de2:	29 d8                	sub    %ebx,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
    4de4:	5b                   	pop    %ebx
    4de5:	5d                   	pop    %ebp
    4de6:	c3                   	ret    
    4de7:	90                   	nop
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
    4de8:	0f b6 1a             	movzbl (%edx),%ebx
    4deb:	31 c0                	xor    %eax,%eax
    4ded:	0f b6 db             	movzbl %bl,%ebx
    4df0:	29 d8                	sub    %ebx,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
    4df2:	5b                   	pop    %ebx
    4df3:	5d                   	pop    %ebp
    4df4:	c3                   	ret    
    4df5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    4df9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00004e00 <strlen>:

uint
strlen(char *s)
{
    4e00:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
    4e01:	31 d2                	xor    %edx,%edx
  return (uchar)*p - (uchar)*q;
}

uint
strlen(char *s)
{
    4e03:	89 e5                	mov    %esp,%ebp
  int n;

  for(n = 0; s[n]; n++)
    4e05:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
}

uint
strlen(char *s)
{
    4e07:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
    4e0a:	80 39 00             	cmpb   $0x0,(%ecx)
    4e0d:	74 0c                	je     4e1b <strlen+0x1b>
    4e0f:	90                   	nop
    4e10:	83 c2 01             	add    $0x1,%edx
    4e13:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
    4e17:	89 d0                	mov    %edx,%eax
    4e19:	75 f5                	jne    4e10 <strlen+0x10>
    ;
  return n;
}
    4e1b:	5d                   	pop    %ebp
    4e1c:	c3                   	ret    
    4e1d:	8d 76 00             	lea    0x0(%esi),%esi

00004e20 <memset>:

void*
memset(void *dst, int c, uint n)
{
    4e20:	55                   	push   %ebp
    4e21:	89 e5                	mov    %esp,%ebp
    4e23:	8b 55 08             	mov    0x8(%ebp),%edx
    4e26:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
    4e27:	8b 4d 10             	mov    0x10(%ebp),%ecx
    4e2a:	8b 45 0c             	mov    0xc(%ebp),%eax
    4e2d:	89 d7                	mov    %edx,%edi
    4e2f:	fc                   	cld    
    4e30:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
    4e32:	89 d0                	mov    %edx,%eax
    4e34:	5f                   	pop    %edi
    4e35:	5d                   	pop    %ebp
    4e36:	c3                   	ret    
    4e37:	89 f6                	mov    %esi,%esi
    4e39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00004e40 <strchr>:

char*
strchr(const char *s, char c)
{
    4e40:	55                   	push   %ebp
    4e41:	89 e5                	mov    %esp,%ebp
    4e43:	8b 45 08             	mov    0x8(%ebp),%eax
    4e46:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
    4e4a:	0f b6 10             	movzbl (%eax),%edx
    4e4d:	84 d2                	test   %dl,%dl
    4e4f:	75 11                	jne    4e62 <strchr+0x22>
    4e51:	eb 15                	jmp    4e68 <strchr+0x28>
    4e53:	90                   	nop
    4e54:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    4e58:	83 c0 01             	add    $0x1,%eax
    4e5b:	0f b6 10             	movzbl (%eax),%edx
    4e5e:	84 d2                	test   %dl,%dl
    4e60:	74 06                	je     4e68 <strchr+0x28>
    if(*s == c)
    4e62:	38 ca                	cmp    %cl,%dl
    4e64:	75 f2                	jne    4e58 <strchr+0x18>
      return (char*)s;
  return 0;
}
    4e66:	5d                   	pop    %ebp
    4e67:	c3                   	ret    
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
    4e68:	31 c0                	xor    %eax,%eax
    if(*s == c)
      return (char*)s;
  return 0;
}
    4e6a:	5d                   	pop    %ebp
    4e6b:	90                   	nop
    4e6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    4e70:	c3                   	ret    
    4e71:	eb 0d                	jmp    4e80 <atoi>
    4e73:	90                   	nop
    4e74:	90                   	nop
    4e75:	90                   	nop
    4e76:	90                   	nop
    4e77:	90                   	nop
    4e78:	90                   	nop
    4e79:	90                   	nop
    4e7a:	90                   	nop
    4e7b:	90                   	nop
    4e7c:	90                   	nop
    4e7d:	90                   	nop
    4e7e:	90                   	nop
    4e7f:	90                   	nop

00004e80 <atoi>:
  return r;
}

int
atoi(const char *s)
{
    4e80:	55                   	push   %ebp
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    4e81:	31 c0                	xor    %eax,%eax
  return r;
}

int
atoi(const char *s)
{
    4e83:	89 e5                	mov    %esp,%ebp
    4e85:	8b 4d 08             	mov    0x8(%ebp),%ecx
    4e88:	53                   	push   %ebx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    4e89:	0f b6 11             	movzbl (%ecx),%edx
    4e8c:	8d 5a d0             	lea    -0x30(%edx),%ebx
    4e8f:	80 fb 09             	cmp    $0x9,%bl
    4e92:	77 1c                	ja     4eb0 <atoi+0x30>
    4e94:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    n = n*10 + *s++ - '0';
    4e98:	0f be d2             	movsbl %dl,%edx
    4e9b:	83 c1 01             	add    $0x1,%ecx
    4e9e:	8d 04 80             	lea    (%eax,%eax,4),%eax
    4ea1:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    4ea5:	0f b6 11             	movzbl (%ecx),%edx
    4ea8:	8d 5a d0             	lea    -0x30(%edx),%ebx
    4eab:	80 fb 09             	cmp    $0x9,%bl
    4eae:	76 e8                	jbe    4e98 <atoi+0x18>
    n = n*10 + *s++ - '0';
  return n;
}
    4eb0:	5b                   	pop    %ebx
    4eb1:	5d                   	pop    %ebp
    4eb2:	c3                   	ret    
    4eb3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    4eb9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00004ec0 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
    4ec0:	55                   	push   %ebp
    4ec1:	89 e5                	mov    %esp,%ebp
    4ec3:	56                   	push   %esi
    4ec4:	8b 45 08             	mov    0x8(%ebp),%eax
    4ec7:	53                   	push   %ebx
    4ec8:	8b 5d 10             	mov    0x10(%ebp),%ebx
    4ecb:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    4ece:	85 db                	test   %ebx,%ebx
    4ed0:	7e 14                	jle    4ee6 <memmove+0x26>
    n = n*10 + *s++ - '0';
  return n;
}

void*
memmove(void *vdst, void *vsrc, int n)
    4ed2:	31 d2                	xor    %edx,%edx
    4ed4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    *dst++ = *src++;
    4ed8:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
    4edc:	88 0c 10             	mov    %cl,(%eax,%edx,1)
    4edf:	83 c2 01             	add    $0x1,%edx
{
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    4ee2:	39 da                	cmp    %ebx,%edx
    4ee4:	75 f2                	jne    4ed8 <memmove+0x18>
    *dst++ = *src++;
  return vdst;
}
    4ee6:	5b                   	pop    %ebx
    4ee7:	5e                   	pop    %esi
    4ee8:	5d                   	pop    %ebp
    4ee9:	c3                   	ret    
    4eea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00004ef0 <stat>:
  return buf;
}

int
stat(char *n, struct stat *st)
{
    4ef0:	55                   	push   %ebp
    4ef1:	89 e5                	mov    %esp,%ebp
    4ef3:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    4ef6:	8b 45 08             	mov    0x8(%ebp),%eax
  return buf;
}

int
stat(char *n, struct stat *st)
{
    4ef9:	89 5d f8             	mov    %ebx,-0x8(%ebp)
    4efc:	89 75 fc             	mov    %esi,-0x4(%ebp)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    4eff:	be ff ff ff ff       	mov    $0xffffffff,%esi
stat(char *n, struct stat *st)
{
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    4f04:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    4f0b:	00 
    4f0c:	89 04 24             	mov    %eax,(%esp)
    4f0f:	e8 d4 00 00 00       	call   4fe8 <open>
  if(fd < 0)
    4f14:	85 c0                	test   %eax,%eax
stat(char *n, struct stat *st)
{
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    4f16:	89 c3                	mov    %eax,%ebx
  if(fd < 0)
    4f18:	78 19                	js     4f33 <stat+0x43>
    return -1;
  r = fstat(fd, st);
    4f1a:	8b 45 0c             	mov    0xc(%ebp),%eax
    4f1d:	89 1c 24             	mov    %ebx,(%esp)
    4f20:	89 44 24 04          	mov    %eax,0x4(%esp)
    4f24:	e8 d7 00 00 00       	call   5000 <fstat>
  close(fd);
    4f29:	89 1c 24             	mov    %ebx,(%esp)
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
  r = fstat(fd, st);
    4f2c:	89 c6                	mov    %eax,%esi
  close(fd);
    4f2e:	e8 9d 00 00 00       	call   4fd0 <close>
  return r;
}
    4f33:	89 f0                	mov    %esi,%eax
    4f35:	8b 5d f8             	mov    -0x8(%ebp),%ebx
    4f38:	8b 75 fc             	mov    -0x4(%ebp),%esi
    4f3b:	89 ec                	mov    %ebp,%esp
    4f3d:	5d                   	pop    %ebp
    4f3e:	c3                   	ret    
    4f3f:	90                   	nop

00004f40 <gets>:
  return 0;
}

char*
gets(char *buf, int max)
{
    4f40:	55                   	push   %ebp
    4f41:	89 e5                	mov    %esp,%ebp
    4f43:	57                   	push   %edi
    4f44:	56                   	push   %esi
    4f45:	31 f6                	xor    %esi,%esi
    4f47:	53                   	push   %ebx
    4f48:	83 ec 2c             	sub    $0x2c,%esp
    4f4b:	8b 7d 08             	mov    0x8(%ebp),%edi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    4f4e:	eb 06                	jmp    4f56 <gets+0x16>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
    4f50:	3c 0a                	cmp    $0xa,%al
    4f52:	74 39                	je     4f8d <gets+0x4d>
    4f54:	89 de                	mov    %ebx,%esi
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    4f56:	8d 5e 01             	lea    0x1(%esi),%ebx
    4f59:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
    4f5c:	7d 31                	jge    4f8f <gets+0x4f>
    cc = read(0, &c, 1);
    4f5e:	8d 45 e7             	lea    -0x19(%ebp),%eax
    4f61:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    4f68:	00 
    4f69:	89 44 24 04          	mov    %eax,0x4(%esp)
    4f6d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    4f74:	e8 47 00 00 00       	call   4fc0 <read>
    if(cc < 1)
    4f79:	85 c0                	test   %eax,%eax
    4f7b:	7e 12                	jle    4f8f <gets+0x4f>
      break;
    buf[i++] = c;
    4f7d:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
    4f81:	88 44 1f ff          	mov    %al,-0x1(%edi,%ebx,1)
    if(c == '\n' || c == '\r')
    4f85:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
    4f89:	3c 0d                	cmp    $0xd,%al
    4f8b:	75 c3                	jne    4f50 <gets+0x10>
    4f8d:	89 de                	mov    %ebx,%esi
      break;
  }
  buf[i] = '\0';
    4f8f:	c6 04 37 00          	movb   $0x0,(%edi,%esi,1)
  return buf;
}
    4f93:	89 f8                	mov    %edi,%eax
    4f95:	83 c4 2c             	add    $0x2c,%esp
    4f98:	5b                   	pop    %ebx
    4f99:	5e                   	pop    %esi
    4f9a:	5f                   	pop    %edi
    4f9b:	5d                   	pop    %ebp
    4f9c:	c3                   	ret    
    4f9d:	90                   	nop
    4f9e:	90                   	nop
    4f9f:	90                   	nop

00004fa0 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    4fa0:	b8 01 00 00 00       	mov    $0x1,%eax
    4fa5:	cd 40                	int    $0x40
    4fa7:	c3                   	ret    

00004fa8 <exit>:
SYSCALL(exit)
    4fa8:	b8 02 00 00 00       	mov    $0x2,%eax
    4fad:	cd 40                	int    $0x40
    4faf:	c3                   	ret    

00004fb0 <wait>:
SYSCALL(wait)
    4fb0:	b8 03 00 00 00       	mov    $0x3,%eax
    4fb5:	cd 40                	int    $0x40
    4fb7:	c3                   	ret    

00004fb8 <pipe>:
SYSCALL(pipe)
    4fb8:	b8 04 00 00 00       	mov    $0x4,%eax
    4fbd:	cd 40                	int    $0x40
    4fbf:	c3                   	ret    

00004fc0 <read>:
SYSCALL(read)
    4fc0:	b8 05 00 00 00       	mov    $0x5,%eax
    4fc5:	cd 40                	int    $0x40
    4fc7:	c3                   	ret    

00004fc8 <write>:
SYSCALL(write)
    4fc8:	b8 10 00 00 00       	mov    $0x10,%eax
    4fcd:	cd 40                	int    $0x40
    4fcf:	c3                   	ret    

00004fd0 <close>:
SYSCALL(close)
    4fd0:	b8 15 00 00 00       	mov    $0x15,%eax
    4fd5:	cd 40                	int    $0x40
    4fd7:	c3                   	ret    

00004fd8 <kill>:
SYSCALL(kill)
    4fd8:	b8 06 00 00 00       	mov    $0x6,%eax
    4fdd:	cd 40                	int    $0x40
    4fdf:	c3                   	ret    

00004fe0 <exec>:
SYSCALL(exec)
    4fe0:	b8 07 00 00 00       	mov    $0x7,%eax
    4fe5:	cd 40                	int    $0x40
    4fe7:	c3                   	ret    

00004fe8 <open>:
SYSCALL(open)
    4fe8:	b8 0f 00 00 00       	mov    $0xf,%eax
    4fed:	cd 40                	int    $0x40
    4fef:	c3                   	ret    

00004ff0 <mknod>:
SYSCALL(mknod)
    4ff0:	b8 11 00 00 00       	mov    $0x11,%eax
    4ff5:	cd 40                	int    $0x40
    4ff7:	c3                   	ret    

00004ff8 <unlink>:
SYSCALL(unlink)
    4ff8:	b8 12 00 00 00       	mov    $0x12,%eax
    4ffd:	cd 40                	int    $0x40
    4fff:	c3                   	ret    

00005000 <fstat>:
SYSCALL(fstat)
    5000:	b8 08 00 00 00       	mov    $0x8,%eax
    5005:	cd 40                	int    $0x40
    5007:	c3                   	ret    

00005008 <link>:
SYSCALL(link)
    5008:	b8 13 00 00 00       	mov    $0x13,%eax
    500d:	cd 40                	int    $0x40
    500f:	c3                   	ret    

00005010 <mkdir>:
SYSCALL(mkdir)
    5010:	b8 14 00 00 00       	mov    $0x14,%eax
    5015:	cd 40                	int    $0x40
    5017:	c3                   	ret    

00005018 <chdir>:
SYSCALL(chdir)
    5018:	b8 09 00 00 00       	mov    $0x9,%eax
    501d:	cd 40                	int    $0x40
    501f:	c3                   	ret    

00005020 <dup>:
SYSCALL(dup)
    5020:	b8 0a 00 00 00       	mov    $0xa,%eax
    5025:	cd 40                	int    $0x40
    5027:	c3                   	ret    

00005028 <getpid>:
SYSCALL(getpid)
    5028:	b8 0b 00 00 00       	mov    $0xb,%eax
    502d:	cd 40                	int    $0x40
    502f:	c3                   	ret    

00005030 <sbrk>:
SYSCALL(sbrk)
    5030:	b8 0c 00 00 00       	mov    $0xc,%eax
    5035:	cd 40                	int    $0x40
    5037:	c3                   	ret    

00005038 <sleep>:
SYSCALL(sleep)
    5038:	b8 0d 00 00 00       	mov    $0xd,%eax
    503d:	cd 40                	int    $0x40
    503f:	c3                   	ret    

00005040 <uptime>:
SYSCALL(uptime)
    5040:	b8 0e 00 00 00       	mov    $0xe,%eax
    5045:	cd 40                	int    $0x40
    5047:	c3                   	ret    

00005048 <hello>:
SYSCALL(hello)
    5048:	b8 16 00 00 00       	mov    $0x16,%eax
    504d:	cd 40                	int    $0x40
    504f:	c3                   	ret    

00005050 <waitpid>:
SYSCALL(waitpid)
    5050:	b8 17 00 00 00       	mov    $0x17,%eax
    5055:	cd 40                	int    $0x40
    5057:	c3                   	ret    

00005058 <setpriority>:
SYSCALL(setpriority)
    5058:	b8 18 00 00 00       	mov    $0x18,%eax
    505d:	cd 40                	int    $0x40
    505f:	c3                   	ret    

00005060 <v2p>:
SYSCALL(v2p)
    5060:	b8 19 00 00 00       	mov    $0x19,%eax
    5065:	cd 40                	int    $0x40
    5067:	c3                   	ret    
    5068:	90                   	nop
    5069:	90                   	nop
    506a:	90                   	nop
    506b:	90                   	nop
    506c:	90                   	nop
    506d:	90                   	nop
    506e:	90                   	nop
    506f:	90                   	nop

00005070 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
    5070:	55                   	push   %ebp
    5071:	89 e5                	mov    %esp,%ebp
    5073:	57                   	push   %edi
    5074:	89 cf                	mov    %ecx,%edi
    5076:	56                   	push   %esi
    5077:	89 c6                	mov    %eax,%esi
    5079:	53                   	push   %ebx
    507a:	83 ec 4c             	sub    $0x4c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    507d:	8b 4d 08             	mov    0x8(%ebp),%ecx
    5080:	85 c9                	test   %ecx,%ecx
    5082:	74 04                	je     5088 <printint+0x18>
    5084:	85 d2                	test   %edx,%edx
    5086:	78 68                	js     50f0 <printint+0x80>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
    5088:	89 d0                	mov    %edx,%eax
    508a:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
    5091:	31 c9                	xor    %ecx,%ecx
    5093:	8d 5d d7             	lea    -0x29(%ebp),%ebx
    5096:	66 90                	xchg   %ax,%ax
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
    5098:	31 d2                	xor    %edx,%edx
    509a:	f7 f7                	div    %edi
    509c:	0f b6 92 07 6c 00 00 	movzbl 0x6c07(%edx),%edx
    50a3:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
    50a6:	83 c1 01             	add    $0x1,%ecx
  }while((x /= base) != 0);
    50a9:	85 c0                	test   %eax,%eax
    50ab:	75 eb                	jne    5098 <printint+0x28>
  if(neg)
    50ad:	8b 45 c4             	mov    -0x3c(%ebp),%eax
    50b0:	85 c0                	test   %eax,%eax
    50b2:	74 08                	je     50bc <printint+0x4c>
    buf[i++] = '-';
    50b4:	c6 44 0d d7 2d       	movb   $0x2d,-0x29(%ebp,%ecx,1)
    50b9:	83 c1 01             	add    $0x1,%ecx

  while(--i >= 0)
    50bc:	8d 79 ff             	lea    -0x1(%ecx),%edi
    50bf:	90                   	nop
    50c0:	0f b6 04 3b          	movzbl (%ebx,%edi,1),%eax
    50c4:	83 ef 01             	sub    $0x1,%edi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    50c7:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    50ce:	00 
    50cf:	89 34 24             	mov    %esi,(%esp)
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
    50d2:	88 45 e7             	mov    %al,-0x19(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    50d5:	8d 45 e7             	lea    -0x19(%ebp),%eax
    50d8:	89 44 24 04          	mov    %eax,0x4(%esp)
    50dc:	e8 e7 fe ff ff       	call   4fc8 <write>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
    50e1:	83 ff ff             	cmp    $0xffffffff,%edi
    50e4:	75 da                	jne    50c0 <printint+0x50>
    putc(fd, buf[i]);
}
    50e6:	83 c4 4c             	add    $0x4c,%esp
    50e9:	5b                   	pop    %ebx
    50ea:	5e                   	pop    %esi
    50eb:	5f                   	pop    %edi
    50ec:	5d                   	pop    %ebp
    50ed:	c3                   	ret    
    50ee:	66 90                	xchg   %ax,%ax
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
    50f0:	89 d0                	mov    %edx,%eax
    50f2:	f7 d8                	neg    %eax
    50f4:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
    50fb:	eb 94                	jmp    5091 <printint+0x21>
    50fd:	8d 76 00             	lea    0x0(%esi),%esi

00005100 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
    5100:	55                   	push   %ebp
    5101:	89 e5                	mov    %esp,%ebp
    5103:	57                   	push   %edi
    5104:	56                   	push   %esi
    5105:	53                   	push   %ebx
    5106:	83 ec 3c             	sub    $0x3c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    5109:	8b 45 0c             	mov    0xc(%ebp),%eax
    510c:	0f b6 10             	movzbl (%eax),%edx
    510f:	84 d2                	test   %dl,%dl
    5111:	0f 84 c1 00 00 00    	je     51d8 <printf+0xd8>
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
    5117:	8d 4d 10             	lea    0x10(%ebp),%ecx
    511a:	31 ff                	xor    %edi,%edi
    511c:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
    511f:	31 db                	xor    %ebx,%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    5121:	8d 75 e7             	lea    -0x19(%ebp),%esi
    5124:	eb 1e                	jmp    5144 <printf+0x44>
    5126:	66 90                	xchg   %ax,%ax
  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
    5128:	83 fa 25             	cmp    $0x25,%edx
    512b:	0f 85 af 00 00 00    	jne    51e0 <printf+0xe0>
    5131:	66 bf 25 00          	mov    $0x25,%di
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    5135:	83 c3 01             	add    $0x1,%ebx
    5138:	0f b6 14 18          	movzbl (%eax,%ebx,1),%edx
    513c:	84 d2                	test   %dl,%dl
    513e:	0f 84 94 00 00 00    	je     51d8 <printf+0xd8>
    c = fmt[i] & 0xff;
    if(state == 0){
    5144:	85 ff                	test   %edi,%edi
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    5146:	0f b6 d2             	movzbl %dl,%edx
    if(state == 0){
    5149:	74 dd                	je     5128 <printf+0x28>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
    514b:	83 ff 25             	cmp    $0x25,%edi
    514e:	75 e5                	jne    5135 <printf+0x35>
      if(c == 'd'){
    5150:	83 fa 64             	cmp    $0x64,%edx
    5153:	0f 84 3f 01 00 00    	je     5298 <printf+0x198>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
    5159:	83 fa 70             	cmp    $0x70,%edx
    515c:	0f 84 a6 00 00 00    	je     5208 <printf+0x108>
    5162:	83 fa 78             	cmp    $0x78,%edx
    5165:	0f 84 9d 00 00 00    	je     5208 <printf+0x108>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
    516b:	83 fa 73             	cmp    $0x73,%edx
    516e:	66 90                	xchg   %ax,%ax
    5170:	0f 84 ba 00 00 00    	je     5230 <printf+0x130>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    5176:	83 fa 63             	cmp    $0x63,%edx
    5179:	0f 84 41 01 00 00    	je     52c0 <printf+0x1c0>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
    517f:	83 fa 25             	cmp    $0x25,%edx
    5182:	0f 84 00 01 00 00    	je     5288 <printf+0x188>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    5188:	8b 4d 08             	mov    0x8(%ebp),%ecx
    518b:	89 55 cc             	mov    %edx,-0x34(%ebp)
    518e:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
    5192:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    5199:	00 
    519a:	89 74 24 04          	mov    %esi,0x4(%esp)
    519e:	89 0c 24             	mov    %ecx,(%esp)
    51a1:	e8 22 fe ff ff       	call   4fc8 <write>
    51a6:	8b 55 cc             	mov    -0x34(%ebp),%edx
    51a9:	88 55 e7             	mov    %dl,-0x19(%ebp)
    51ac:	8b 45 08             	mov    0x8(%ebp),%eax
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    51af:	83 c3 01             	add    $0x1,%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    51b2:	31 ff                	xor    %edi,%edi
    51b4:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    51bb:	00 
    51bc:	89 74 24 04          	mov    %esi,0x4(%esp)
    51c0:	89 04 24             	mov    %eax,(%esp)
    51c3:	e8 00 fe ff ff       	call   4fc8 <write>
    51c8:	8b 45 0c             	mov    0xc(%ebp),%eax
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    51cb:	0f b6 14 18          	movzbl (%eax,%ebx,1),%edx
    51cf:	84 d2                	test   %dl,%dl
    51d1:	0f 85 6d ff ff ff    	jne    5144 <printf+0x44>
    51d7:	90                   	nop
        putc(fd, c);
      }
      state = 0;
    }
  }
}
    51d8:	83 c4 3c             	add    $0x3c,%esp
    51db:	5b                   	pop    %ebx
    51dc:	5e                   	pop    %esi
    51dd:	5f                   	pop    %edi
    51de:	5d                   	pop    %ebp
    51df:	c3                   	ret    
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    51e0:	8b 45 08             	mov    0x8(%ebp),%eax
  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
    51e3:	88 55 e7             	mov    %dl,-0x19(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    51e6:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    51ed:	00 
    51ee:	89 74 24 04          	mov    %esi,0x4(%esp)
    51f2:	89 04 24             	mov    %eax,(%esp)
    51f5:	e8 ce fd ff ff       	call   4fc8 <write>
    51fa:	8b 45 0c             	mov    0xc(%ebp),%eax
    51fd:	e9 33 ff ff ff       	jmp    5135 <printf+0x35>
    5202:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
    5208:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    520b:	b9 10 00 00 00       	mov    $0x10,%ecx
        ap++;
    5210:	31 ff                	xor    %edi,%edi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
    5212:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    5219:	8b 10                	mov    (%eax),%edx
    521b:	8b 45 08             	mov    0x8(%ebp),%eax
    521e:	e8 4d fe ff ff       	call   5070 <printint>
    5223:	8b 45 0c             	mov    0xc(%ebp),%eax
        ap++;
    5226:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
    522a:	e9 06 ff ff ff       	jmp    5135 <printf+0x35>
    522f:	90                   	nop
      } else if(c == 's'){
        s = (char*)*ap;
    5230:	8b 55 d4             	mov    -0x2c(%ebp),%edx
        ap++;
        if(s == 0)
    5233:	b9 00 6c 00 00       	mov    $0x6c00,%ecx
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
        s = (char*)*ap;
    5238:	8b 3a                	mov    (%edx),%edi
        ap++;
    523a:	83 c2 04             	add    $0x4,%edx
    523d:	89 55 d4             	mov    %edx,-0x2c(%ebp)
        if(s == 0)
    5240:	85 ff                	test   %edi,%edi
    5242:	0f 44 f9             	cmove  %ecx,%edi
          s = "(null)";
        while(*s != 0){
    5245:	0f b6 17             	movzbl (%edi),%edx
    5248:	84 d2                	test   %dl,%dl
    524a:	74 33                	je     527f <printf+0x17f>
    524c:	89 5d d0             	mov    %ebx,-0x30(%ebp)
    524f:	8b 5d 08             	mov    0x8(%ebp),%ebx
    5252:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
          putc(fd, *s);
          s++;
    5258:	83 c7 01             	add    $0x1,%edi
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
    525b:	88 55 e7             	mov    %dl,-0x19(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    525e:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    5265:	00 
    5266:	89 74 24 04          	mov    %esi,0x4(%esp)
    526a:	89 1c 24             	mov    %ebx,(%esp)
    526d:	e8 56 fd ff ff       	call   4fc8 <write>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
    5272:	0f b6 17             	movzbl (%edi),%edx
    5275:	84 d2                	test   %dl,%dl
    5277:	75 df                	jne    5258 <printf+0x158>
    5279:	8b 5d d0             	mov    -0x30(%ebp),%ebx
    527c:	8b 45 0c             	mov    0xc(%ebp),%eax
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    527f:	31 ff                	xor    %edi,%edi
    5281:	e9 af fe ff ff       	jmp    5135 <printf+0x35>
    5286:	66 90                	xchg   %ax,%ax
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
    5288:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
    528c:	e9 1b ff ff ff       	jmp    51ac <printf+0xac>
    5291:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
    5298:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    529b:	b9 0a 00 00 00       	mov    $0xa,%ecx
        ap++;
    52a0:	66 31 ff             	xor    %di,%di
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
    52a3:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    52aa:	8b 10                	mov    (%eax),%edx
    52ac:	8b 45 08             	mov    0x8(%ebp),%eax
    52af:	e8 bc fd ff ff       	call   5070 <printint>
    52b4:	8b 45 0c             	mov    0xc(%ebp),%eax
        ap++;
    52b7:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
    52bb:	e9 75 fe ff ff       	jmp    5135 <printf+0x35>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    52c0:	8b 55 d4             	mov    -0x2c(%ebp),%edx
        putc(fd, *ap);
        ap++;
    52c3:	31 ff                	xor    %edi,%edi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    52c5:	8b 4d 08             	mov    0x8(%ebp),%ecx
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    52c8:	8b 02                	mov    (%edx),%eax
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    52ca:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    52d1:	00 
    52d2:	89 74 24 04          	mov    %esi,0x4(%esp)
    52d6:	89 0c 24             	mov    %ecx,(%esp)
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    52d9:	88 45 e7             	mov    %al,-0x19(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    52dc:	e8 e7 fc ff ff       	call   4fc8 <write>
    52e1:	8b 45 0c             	mov    0xc(%ebp),%eax
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
        ap++;
    52e4:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
    52e8:	e9 48 fe ff ff       	jmp    5135 <printf+0x35>
    52ed:	90                   	nop
    52ee:	90                   	nop
    52ef:	90                   	nop

000052f0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    52f0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    52f1:	a1 c8 6c 00 00       	mov    0x6cc8,%eax
static Header base;
static Header *freep;

void
free(void *ap)
{
    52f6:	89 e5                	mov    %esp,%ebp
    52f8:	57                   	push   %edi
    52f9:	56                   	push   %esi
    52fa:	53                   	push   %ebx
    52fb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
    52fe:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    5301:	39 c8                	cmp    %ecx,%eax
    5303:	73 1d                	jae    5322 <free+0x32>
    5305:	8d 76 00             	lea    0x0(%esi),%esi
    5308:	8b 10                	mov    (%eax),%edx
    530a:	39 d1                	cmp    %edx,%ecx
    530c:	72 1a                	jb     5328 <free+0x38>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    530e:	39 d0                	cmp    %edx,%eax
    5310:	72 08                	jb     531a <free+0x2a>
    5312:	39 c8                	cmp    %ecx,%eax
    5314:	72 12                	jb     5328 <free+0x38>
    5316:	39 d1                	cmp    %edx,%ecx
    5318:	72 0e                	jb     5328 <free+0x38>
    531a:	89 d0                	mov    %edx,%eax
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    531c:	39 c8                	cmp    %ecx,%eax
    531e:	66 90                	xchg   %ax,%ax
    5320:	72 e6                	jb     5308 <free+0x18>
    5322:	8b 10                	mov    (%eax),%edx
    5324:	eb e8                	jmp    530e <free+0x1e>
    5326:	66 90                	xchg   %ax,%ax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    5328:	8b 71 04             	mov    0x4(%ecx),%esi
    532b:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    532e:	39 d7                	cmp    %edx,%edi
    5330:	74 19                	je     534b <free+0x5b>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
    5332:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    5335:	8b 50 04             	mov    0x4(%eax),%edx
    5338:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    533b:	39 ce                	cmp    %ecx,%esi
    533d:	74 23                	je     5362 <free+0x72>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
    533f:	89 08                	mov    %ecx,(%eax)
  freep = p;
    5341:	a3 c8 6c 00 00       	mov    %eax,0x6cc8
}
    5346:	5b                   	pop    %ebx
    5347:	5e                   	pop    %esi
    5348:	5f                   	pop    %edi
    5349:	5d                   	pop    %ebp
    534a:	c3                   	ret    
  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
    534b:	03 72 04             	add    0x4(%edx),%esi
    534e:	89 71 04             	mov    %esi,0x4(%ecx)
    bp->s.ptr = p->s.ptr->s.ptr;
    5351:	8b 10                	mov    (%eax),%edx
    5353:	8b 12                	mov    (%edx),%edx
    5355:	89 53 f8             	mov    %edx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    5358:	8b 50 04             	mov    0x4(%eax),%edx
    535b:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    535e:	39 ce                	cmp    %ecx,%esi
    5360:	75 dd                	jne    533f <free+0x4f>
    p->s.size += bp->s.size;
    5362:	03 51 04             	add    0x4(%ecx),%edx
    5365:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    5368:	8b 53 f8             	mov    -0x8(%ebx),%edx
    536b:	89 10                	mov    %edx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
    536d:	a3 c8 6c 00 00       	mov    %eax,0x6cc8
}
    5372:	5b                   	pop    %ebx
    5373:	5e                   	pop    %esi
    5374:	5f                   	pop    %edi
    5375:	5d                   	pop    %ebp
    5376:	c3                   	ret    
    5377:	89 f6                	mov    %esi,%esi
    5379:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00005380 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    5380:	55                   	push   %ebp
    5381:	89 e5                	mov    %esp,%ebp
    5383:	57                   	push   %edi
    5384:	56                   	push   %esi
    5385:	53                   	push   %ebx
    5386:	83 ec 2c             	sub    $0x2c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    5389:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if((prevp = freep) == 0){
    538c:	8b 0d c8 6c 00 00    	mov    0x6cc8,%ecx
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    5392:	83 c3 07             	add    $0x7,%ebx
    5395:	c1 eb 03             	shr    $0x3,%ebx
    5398:	83 c3 01             	add    $0x1,%ebx
  if((prevp = freep) == 0){
    539b:	85 c9                	test   %ecx,%ecx
    539d:	0f 84 9b 00 00 00    	je     543e <malloc+0xbe>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    53a3:	8b 01                	mov    (%ecx),%eax
    if(p->s.size >= nunits){
    53a5:	8b 50 04             	mov    0x4(%eax),%edx
    53a8:	39 d3                	cmp    %edx,%ebx
    53aa:	76 27                	jbe    53d3 <malloc+0x53>
        p->s.size -= nunits;
        p += p->s.size;
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    53ac:	8d 3c dd 00 00 00 00 	lea    0x0(,%ebx,8),%edi
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < 4096)
    53b3:	be 00 80 00 00       	mov    $0x8000,%esi
    53b8:	89 7d e4             	mov    %edi,-0x1c(%ebp)
    53bb:	90                   	nop
    53bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    53c0:	3b 05 c8 6c 00 00    	cmp    0x6cc8,%eax
    53c6:	74 30                	je     53f8 <malloc+0x78>
    53c8:	89 c1                	mov    %eax,%ecx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    53ca:	8b 01                	mov    (%ecx),%eax
    if(p->s.size >= nunits){
    53cc:	8b 50 04             	mov    0x4(%eax),%edx
    53cf:	39 d3                	cmp    %edx,%ebx
    53d1:	77 ed                	ja     53c0 <malloc+0x40>
      if(p->s.size == nunits)
    53d3:	39 d3                	cmp    %edx,%ebx
    53d5:	74 61                	je     5438 <malloc+0xb8>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
    53d7:	29 da                	sub    %ebx,%edx
    53d9:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
    53dc:	8d 04 d0             	lea    (%eax,%edx,8),%eax
        p->s.size = nunits;
    53df:	89 58 04             	mov    %ebx,0x4(%eax)
      }
      freep = prevp;
    53e2:	89 0d c8 6c 00 00    	mov    %ecx,0x6cc8
      return (void*)(p + 1);
    53e8:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
    53eb:	83 c4 2c             	add    $0x2c,%esp
    53ee:	5b                   	pop    %ebx
    53ef:	5e                   	pop    %esi
    53f0:	5f                   	pop    %edi
    53f1:	5d                   	pop    %ebp
    53f2:	c3                   	ret    
    53f3:	90                   	nop
    53f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < 4096)
    53f8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    53fb:	81 fb 00 10 00 00    	cmp    $0x1000,%ebx
    5401:	bf 00 10 00 00       	mov    $0x1000,%edi
    5406:	0f 43 fb             	cmovae %ebx,%edi
    5409:	0f 42 c6             	cmovb  %esi,%eax
    nu = 4096;
  p = sbrk(nu * sizeof(Header));
    540c:	89 04 24             	mov    %eax,(%esp)
    540f:	e8 1c fc ff ff       	call   5030 <sbrk>
  if(p == (char*)-1)
    5414:	83 f8 ff             	cmp    $0xffffffff,%eax
    5417:	74 18                	je     5431 <malloc+0xb1>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
    5419:	89 78 04             	mov    %edi,0x4(%eax)
  free((void*)(hp + 1));
    541c:	83 c0 08             	add    $0x8,%eax
    541f:	89 04 24             	mov    %eax,(%esp)
    5422:	e8 c9 fe ff ff       	call   52f0 <free>
  return freep;
    5427:	8b 0d c8 6c 00 00    	mov    0x6cc8,%ecx
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
    542d:	85 c9                	test   %ecx,%ecx
    542f:	75 99                	jne    53ca <malloc+0x4a>
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
    5431:	31 c0                	xor    %eax,%eax
    5433:	eb b6                	jmp    53eb <malloc+0x6b>
    5435:	8d 76 00             	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
    5438:	8b 10                	mov    (%eax),%edx
    543a:	89 11                	mov    %edx,(%ecx)
    543c:	eb a4                	jmp    53e2 <malloc+0x62>
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    543e:	c7 05 c8 6c 00 00 c0 	movl   $0x6cc0,0x6cc8
    5445:	6c 00 00 
    base.s.size = 0;
    5448:	b9 c0 6c 00 00       	mov    $0x6cc0,%ecx
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    544d:	c7 05 c0 6c 00 00 c0 	movl   $0x6cc0,0x6cc0
    5454:	6c 00 00 
    base.s.size = 0;
    5457:	c7 05 c4 6c 00 00 00 	movl   $0x0,0x6cc4
    545e:	00 00 00 
    5461:	e9 3d ff ff ff       	jmp    53a3 <malloc+0x23>
