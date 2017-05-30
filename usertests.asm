
_usertests:     file format elf32-i386


Disassembly of section .text:

00000000 <validateint>:
  printf(stdout, "sbrk test OK\n");
}

void
validateint(int *p)
{
       0:	55                   	push   %ebp
       1:	89 e5                	mov    %esp,%ebp
      "int %2\n\t"
      "mov %%ebx, %%esp" :
      "=a" (res) :
      "a" (SYS_sleep), "n" (T_SYSCALL), "c" (p) :
      "ebx");
}
       3:	5d                   	pop    %ebp
       4:	c3                   	ret    
       5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
       9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000010 <rand>:

unsigned long randstate = 1;
unsigned int
rand()
{
  randstate = randstate * 1664525 + 1013904223;
      10:	69 05 20 5c 00 00 0d 	imul   $0x19660d,0x5c20,%eax
      17:	66 19 00 
}

unsigned long randstate = 1;
unsigned int
rand()
{
      1a:	55                   	push   %ebp
      1b:	89 e5                	mov    %esp,%ebp
  randstate = randstate * 1664525 + 1013904223;
  return randstate;
}
      1d:	5d                   	pop    %ebp

unsigned long randstate = 1;
unsigned int
rand()
{
  randstate = randstate * 1664525 + 1013904223;
      1e:	05 5f f3 6e 3c       	add    $0x3c6ef35f,%eax
      23:	a3 20 5c 00 00       	mov    %eax,0x5c20
  return randstate;
}
      28:	c3                   	ret    
      29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000030 <bsstest>:

// does unintialized data start out zero?
char uninit[10000];
void
bsstest(void)
{
      30:	55                   	push   %ebp
      31:	89 e5                	mov    %esp,%ebp
      33:	83 ec 18             	sub    $0x18,%esp
  int i;

  printf(stdout, "bss test\n");
      36:	a1 1c 5c 00 00       	mov    0x5c1c,%eax
      3b:	c7 44 24 04 58 44 00 	movl   $0x4458,0x4(%esp)
      42:	00 
      43:	89 04 24             	mov    %eax,(%esp)
      46:	e8 a5 40 00 00       	call   40f0 <printf>
  for(i = 0; i < sizeof(uninit); i++){
    if(uninit[i] != '\0'){
      4b:	80 3d e0 5c 00 00 00 	cmpb   $0x0,0x5ce0
      52:	75 36                	jne    8a <bsstest+0x5a>
      54:	b8 01 00 00 00       	mov    $0x1,%eax
      59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      60:	80 b8 e0 5c 00 00 00 	cmpb   $0x0,0x5ce0(%eax)
      67:	75 21                	jne    8a <bsstest+0x5a>
bsstest(void)
{
  int i;

  printf(stdout, "bss test\n");
  for(i = 0; i < sizeof(uninit); i++){
      69:	83 c0 01             	add    $0x1,%eax
      6c:	3d 10 27 00 00       	cmp    $0x2710,%eax
      71:	75 ed                	jne    60 <bsstest+0x30>
    if(uninit[i] != '\0'){
      printf(stdout, "bss test failed\n");
      exit(0);
    }
  }
  printf(stdout, "bss test ok\n");
      73:	a1 1c 5c 00 00       	mov    0x5c1c,%eax
      78:	c7 44 24 04 73 44 00 	movl   $0x4473,0x4(%esp)
      7f:	00 
      80:	89 04 24             	mov    %eax,(%esp)
      83:	e8 68 40 00 00       	call   40f0 <printf>
}
      88:	c9                   	leave  
      89:	c3                   	ret    
  int i;

  printf(stdout, "bss test\n");
  for(i = 0; i < sizeof(uninit); i++){
    if(uninit[i] != '\0'){
      printf(stdout, "bss test failed\n");
      8a:	a1 1c 5c 00 00       	mov    0x5c1c,%eax
      8f:	c7 44 24 04 62 44 00 	movl   $0x4462,0x4(%esp)
      96:	00 
      97:	89 04 24             	mov    %eax,(%esp)
      9a:	e8 51 40 00 00       	call   40f0 <printf>
      exit(0);
      9f:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
      a6:	e8 fd 3e 00 00       	call   3fa8 <exit>
      ab:	90                   	nop
      ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000000b0 <opentest>:

// simple file system tests

void
opentest(void)
{
      b0:	55                   	push   %ebp
      b1:	89 e5                	mov    %esp,%ebp
      b3:	83 ec 18             	sub    $0x18,%esp
  int fd;

  printf(stdout, "open test\n");
      b6:	a1 1c 5c 00 00       	mov    0x5c1c,%eax
      bb:	c7 44 24 04 80 44 00 	movl   $0x4480,0x4(%esp)
      c2:	00 
      c3:	89 04 24             	mov    %eax,(%esp)
      c6:	e8 25 40 00 00       	call   40f0 <printf>
  fd = open("echo", 0);
      cb:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
      d2:	00 
      d3:	c7 04 24 8b 44 00 00 	movl   $0x448b,(%esp)
      da:	e8 09 3f 00 00       	call   3fe8 <open>
  if(fd < 0){
      df:	85 c0                	test   %eax,%eax
      e1:	78 37                	js     11a <opentest+0x6a>
    printf(stdout, "open echo failed!\n");
    exit(0);
  }
  close(fd);
      e3:	89 04 24             	mov    %eax,(%esp)
      e6:	e8 e5 3e 00 00       	call   3fd0 <close>
  fd = open("doesnotexist", 0);
      eb:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
      f2:	00 
      f3:	c7 04 24 a3 44 00 00 	movl   $0x44a3,(%esp)
      fa:	e8 e9 3e 00 00       	call   3fe8 <open>
  if(fd >= 0){
      ff:	85 c0                	test   %eax,%eax
     101:	79 38                	jns    13b <opentest+0x8b>
    printf(stdout, "open doesnotexist succeeded!\n");
    exit(0);
  }
  printf(stdout, "open test ok\n");
     103:	a1 1c 5c 00 00       	mov    0x5c1c,%eax
     108:	c7 44 24 04 ce 44 00 	movl   $0x44ce,0x4(%esp)
     10f:	00 
     110:	89 04 24             	mov    %eax,(%esp)
     113:	e8 d8 3f 00 00       	call   40f0 <printf>
}
     118:	c9                   	leave  
     119:	c3                   	ret    
  int fd;

  printf(stdout, "open test\n");
  fd = open("echo", 0);
  if(fd < 0){
    printf(stdout, "open echo failed!\n");
     11a:	c7 44 24 04 90 44 00 	movl   $0x4490,0x4(%esp)
     121:	00 
    exit(0);
  }
  close(fd);
  fd = open("doesnotexist", 0);
  if(fd >= 0){
    printf(stdout, "open doesnotexist succeeded!\n");
     122:	a1 1c 5c 00 00       	mov    0x5c1c,%eax
     127:	89 04 24             	mov    %eax,(%esp)
     12a:	e8 c1 3f 00 00       	call   40f0 <printf>
    exit(0);
     12f:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     136:	e8 6d 3e 00 00       	call   3fa8 <exit>
    exit(0);
  }
  close(fd);
  fd = open("doesnotexist", 0);
  if(fd >= 0){
    printf(stdout, "open doesnotexist succeeded!\n");
     13b:	c7 44 24 04 b0 44 00 	movl   $0x44b0,0x4(%esp)
     142:	00 
     143:	eb dd                	jmp    122 <opentest+0x72>
     145:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     149:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000150 <argptest>:
  wait(0);
  printf(1, "uio test done\n");
}

void argptest()
{
     150:	55                   	push   %ebp
     151:	89 e5                	mov    %esp,%ebp
     153:	53                   	push   %ebx
     154:	83 ec 14             	sub    $0x14,%esp
  int fd;
  fd = open("init", O_RDONLY);
     157:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
     15e:	00 
     15f:	c7 04 24 dc 44 00 00 	movl   $0x44dc,(%esp)
     166:	e8 7d 3e 00 00       	call   3fe8 <open>
  if (fd < 0) {
     16b:	85 c0                	test   %eax,%eax
}

void argptest()
{
  int fd;
  fd = open("init", O_RDONLY);
     16d:	89 c3                	mov    %eax,%ebx
  if (fd < 0) {
     16f:	78 45                	js     1b6 <argptest+0x66>
    printf(2, "open failed\n");
    exit(0);
  }
  read(fd, sbrk(0) - 1, -1);
     171:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     178:	e8 b3 3e 00 00       	call   4030 <sbrk>
     17d:	89 1c 24             	mov    %ebx,(%esp)
     180:	c7 44 24 08 ff ff ff 	movl   $0xffffffff,0x8(%esp)
     187:	ff 
     188:	83 e8 01             	sub    $0x1,%eax
     18b:	89 44 24 04          	mov    %eax,0x4(%esp)
     18f:	e8 2c 3e 00 00       	call   3fc0 <read>
  close(fd);
     194:	89 1c 24             	mov    %ebx,(%esp)
     197:	e8 34 3e 00 00       	call   3fd0 <close>
  printf(1, "arg test passed\n");
     19c:	c7 44 24 04 ee 44 00 	movl   $0x44ee,0x4(%esp)
     1a3:	00 
     1a4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     1ab:	e8 40 3f 00 00       	call   40f0 <printf>
}
     1b0:	83 c4 14             	add    $0x14,%esp
     1b3:	5b                   	pop    %ebx
     1b4:	5d                   	pop    %ebp
     1b5:	c3                   	ret    
void argptest()
{
  int fd;
  fd = open("init", O_RDONLY);
  if (fd < 0) {
    printf(2, "open failed\n");
     1b6:	c7 44 24 04 e1 44 00 	movl   $0x44e1,0x4(%esp)
     1bd:	00 
     1be:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
     1c5:	e8 26 3f 00 00       	call   40f0 <printf>
    exit(0);
     1ca:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     1d1:	e8 d2 3d 00 00       	call   3fa8 <exit>
     1d6:	8d 76 00             	lea    0x0(%esi),%esi
     1d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000001e0 <uio>:
  printf(1, "fsfull test finished\n");
}

void
uio()
{
     1e0:	55                   	push   %ebp
     1e1:	89 e5                	mov    %esp,%ebp
     1e3:	83 ec 18             	sub    $0x18,%esp

  ushort port = 0;
  uchar val = 0;
  int pid;

  printf(1, "uio test\n");
     1e6:	c7 44 24 04 ff 44 00 	movl   $0x44ff,0x4(%esp)
     1ed:	00 
     1ee:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     1f5:	e8 f6 3e 00 00       	call   40f0 <printf>
  pid = fork();
     1fa:	e8 a1 3d 00 00       	call   3fa0 <fork>
  if(pid == 0){
     1ff:	83 f8 00             	cmp    $0x0,%eax
     202:	74 24                	je     228 <uio+0x48>
    asm volatile("outb %0,%1"::"a"(val), "d" (port));
    port = RTC_DATA;
    asm volatile("inb %1,%0" : "=a" (val) : "d" (port));
    printf(1, "uio: uio succeeded; test FAILED\n");
    exit(0);
  } else if(pid < 0){
     204:	7c 50                	jl     256 <uio+0x76>
    printf (1, "fork failed\n");
    exit(0);
  }
  wait(0);
     206:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     20d:	e8 9e 3d 00 00       	call   3fb0 <wait>
  printf(1, "uio test done\n");
     212:	c7 44 24 04 09 45 00 	movl   $0x4509,0x4(%esp)
     219:	00 
     21a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     221:	e8 ca 3e 00 00       	call   40f0 <printf>
}
     226:	c9                   	leave  
     227:	c3                   	ret    
  pid = fork();
  if(pid == 0){
    port = RTC_ADDR;
    val = 0x09;  /* year */
    /* http://wiki.osdev.org/Inline_Assembly/Examples */
    asm volatile("outb %0,%1"::"a"(val), "d" (port));
     228:	ba 70 00 00 00       	mov    $0x70,%edx
     22d:	b8 09 00 00 00       	mov    $0x9,%eax
     232:	ee                   	out    %al,(%dx)
    port = RTC_DATA;
    asm volatile("inb %1,%0" : "=a" (val) : "d" (port));
     233:	b2 71                	mov    $0x71,%dl
     235:	ec                   	in     (%dx),%al
    printf(1, "uio: uio succeeded; test FAILED\n");
     236:	c7 44 24 04 7c 54 00 	movl   $0x547c,0x4(%esp)
     23d:	00 
     23e:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     245:	e8 a6 3e 00 00       	call   40f0 <printf>
    exit(0);
     24a:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     251:	e8 52 3d 00 00       	call   3fa8 <exit>
  } else if(pid < 0){
    printf (1, "fork failed\n");
     256:	c7 44 24 04 cf 48 00 	movl   $0x48cf,0x4(%esp)
     25d:	00 
     25e:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     265:	e8 86 3e 00 00       	call   40f0 <printf>
    exit(0);
     26a:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     271:	e8 32 3d 00 00       	call   3fa8 <exit>
     276:	8d 76 00             	lea    0x0(%esi),%esi
     279:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000280 <forktest>:
// test that fork fails gracefully
// the forktest binary also does this, but it runs out of proc entries first.
// inside the bigger usertests binary, we run out of memory first.
void
forktest(void)
{
     280:	55                   	push   %ebp
     281:	89 e5                	mov    %esp,%ebp
     283:	53                   	push   %ebx
  int n, pid;

  printf(1, "fork test\n");
     284:	31 db                	xor    %ebx,%ebx
// test that fork fails gracefully
// the forktest binary also does this, but it runs out of proc entries first.
// inside the bigger usertests binary, we run out of memory first.
void
forktest(void)
{
     286:	83 ec 14             	sub    $0x14,%esp
  int n, pid;

  printf(1, "fork test\n");
     289:	c7 44 24 04 18 45 00 	movl   $0x4518,0x4(%esp)
     290:	00 
     291:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     298:	e8 53 3e 00 00       	call   40f0 <printf>
     29d:	eb 0e                	jmp    2ad <forktest+0x2d>
     29f:	90                   	nop

  for(n=0; n<1000; n++){
    pid = fork();
    if(pid < 0)
      break;
    if(pid == 0)
     2a0:	74 72                	je     314 <forktest+0x94>
{
  int n, pid;

  printf(1, "fork test\n");

  for(n=0; n<1000; n++){
     2a2:	83 c3 01             	add    $0x1,%ebx
     2a5:	81 fb e8 03 00 00    	cmp    $0x3e8,%ebx
     2ab:	74 53                	je     300 <forktest+0x80>
    pid = fork();
     2ad:	e8 ee 3c 00 00       	call   3fa0 <fork>
    if(pid < 0)
     2b2:	83 f8 00             	cmp    $0x0,%eax
     2b5:	7d e9                	jge    2a0 <forktest+0x20>
  if(n == 1000){
    printf(1, "fork claimed to work 1000 times!\n");
    exit(0);
  }

  for(; n > 0; n--){
     2b7:	85 db                	test   %ebx,%ebx
     2b9:	74 1a                	je     2d5 <forktest+0x55>
     2bb:	90                   	nop
     2bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(wait(0) < 0){
     2c0:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     2c7:	e8 e4 3c 00 00       	call   3fb0 <wait>
     2cc:	85 c0                	test   %eax,%eax
     2ce:	78 50                	js     320 <forktest+0xa0>
  if(n == 1000){
    printf(1, "fork claimed to work 1000 times!\n");
    exit(0);
  }

  for(; n > 0; n--){
     2d0:	83 eb 01             	sub    $0x1,%ebx
     2d3:	75 eb                	jne    2c0 <forktest+0x40>
      printf(1, "wait stopped early\n");
      exit(0);
    }
  }

  if(wait(0) != -1){
     2d5:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     2dc:	e8 cf 3c 00 00       	call   3fb0 <wait>
     2e1:	83 f8 ff             	cmp    $0xffffffff,%eax
     2e4:	75 5a                	jne    340 <forktest+0xc0>
    printf(1, "wait got too many\n");
    exit(0);
  }

  printf(1, "fork test OK\n");
     2e6:	c7 44 24 04 4a 45 00 	movl   $0x454a,0x4(%esp)
     2ed:	00 
     2ee:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     2f5:	e8 f6 3d 00 00       	call   40f0 <printf>
}
     2fa:	83 c4 14             	add    $0x14,%esp
     2fd:	5b                   	pop    %ebx
     2fe:	5d                   	pop    %ebp
     2ff:	c3                   	ret    
    if(pid == 0)
      exit(0);
  }

  if(n == 1000){
    printf(1, "fork claimed to work 1000 times!\n");
     300:	c7 44 24 04 a0 54 00 	movl   $0x54a0,0x4(%esp)
     307:	00 
     308:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     30f:	e8 dc 3d 00 00       	call   40f0 <printf>
    exit(0);
     314:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     31b:	e8 88 3c 00 00       	call   3fa8 <exit>
  }

  for(; n > 0; n--){
    if(wait(0) < 0){
      printf(1, "wait stopped early\n");
     320:	c7 44 24 04 23 45 00 	movl   $0x4523,0x4(%esp)
     327:	00 
     328:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     32f:	e8 bc 3d 00 00       	call   40f0 <printf>
      exit(0);
     334:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     33b:	e8 68 3c 00 00       	call   3fa8 <exit>
    }
  }

  if(wait(0) != -1){
    printf(1, "wait got too many\n");
     340:	c7 44 24 04 37 45 00 	movl   $0x4537,0x4(%esp)
     347:	00 
     348:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     34f:	e8 9c 3d 00 00       	call   40f0 <printf>
    exit(0);
     354:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     35b:	e8 48 3c 00 00       	call   3fa8 <exit>

00000360 <exitwait>:
}

// try to find any races between exit and wait
void
exitwait(void)
{
     360:	55                   	push   %ebp
     361:	89 e5                	mov    %esp,%ebp
     363:	56                   	push   %esi
     364:	31 f6                	xor    %esi,%esi
     366:	53                   	push   %ebx
     367:	83 ec 10             	sub    $0x10,%esp
     36a:	eb 22                	jmp    38e <exitwait+0x2e>
     36c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    pid = fork();
    if(pid < 0){
      printf(1, "fork failed\n");
      return;
    }
    if(pid){
     370:	0f 84 7d 00 00 00    	je     3f3 <exitwait+0x93>
      if(wait(0) != pid){
     376:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     37d:	e8 2e 3c 00 00       	call   3fb0 <wait>
     382:	39 c3                	cmp    %eax,%ebx
     384:	75 32                	jne    3b8 <exitwait+0x58>
void
exitwait(void)
{
  int i, pid;

  for(i = 0; i < 100; i++){
     386:	83 c6 01             	add    $0x1,%esi
     389:	83 fe 64             	cmp    $0x64,%esi
     38c:	74 4a                	je     3d8 <exitwait+0x78>
    pid = fork();
     38e:	e8 0d 3c 00 00       	call   3fa0 <fork>
    if(pid < 0){
     393:	83 f8 00             	cmp    $0x0,%eax
exitwait(void)
{
  int i, pid;

  for(i = 0; i < 100; i++){
    pid = fork();
     396:	89 c3                	mov    %eax,%ebx
    if(pid < 0){
     398:	7d d6                	jge    370 <exitwait+0x10>
      printf(1, "fork failed\n");
     39a:	c7 44 24 04 cf 48 00 	movl   $0x48cf,0x4(%esp)
     3a1:	00 
     3a2:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     3a9:	e8 42 3d 00 00       	call   40f0 <printf>
    } else {
      exit(0);
    }
  }
  printf(1, "exitwait ok\n");
}
     3ae:	83 c4 10             	add    $0x10,%esp
     3b1:	5b                   	pop    %ebx
     3b2:	5e                   	pop    %esi
     3b3:	5d                   	pop    %ebp
     3b4:	c3                   	ret    
     3b5:	8d 76 00             	lea    0x0(%esi),%esi
      printf(1, "fork failed\n");
      return;
    }
    if(pid){
      if(wait(0) != pid){
        printf(1, "wait wrong pid\n");
     3b8:	c7 44 24 04 58 45 00 	movl   $0x4558,0x4(%esp)
     3bf:	00 
     3c0:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     3c7:	e8 24 3d 00 00       	call   40f0 <printf>
    } else {
      exit(0);
    }
  }
  printf(1, "exitwait ok\n");
}
     3cc:	83 c4 10             	add    $0x10,%esp
     3cf:	5b                   	pop    %ebx
     3d0:	5e                   	pop    %esi
     3d1:	5d                   	pop    %ebp
     3d2:	c3                   	ret    
     3d3:	90                   	nop
     3d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      }
    } else {
      exit(0);
    }
  }
  printf(1, "exitwait ok\n");
     3d8:	c7 44 24 04 68 45 00 	movl   $0x4568,0x4(%esp)
     3df:	00 
     3e0:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     3e7:	e8 04 3d 00 00       	call   40f0 <printf>
}
     3ec:	83 c4 10             	add    $0x10,%esp
     3ef:	5b                   	pop    %ebx
     3f0:	5e                   	pop    %esi
     3f1:	5d                   	pop    %ebp
     3f2:	c3                   	ret    
      if(wait(0) != pid){
        printf(1, "wait wrong pid\n");
        return;
      }
    } else {
      exit(0);
     3f3:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     3fa:	e8 a9 3b 00 00       	call   3fa8 <exit>
     3ff:	90                   	nop

00000400 <fsfull>:

// what happens when the file system runs out of blocks?
// answer: balloc panics, so this test is not useful.
void
fsfull()
{
     400:	55                   	push   %ebp
     401:	89 e5                	mov    %esp,%ebp
     403:	57                   	push   %edi
     404:	56                   	push   %esi
     405:	53                   	push   %ebx
  int nfiles;
  int fsblocks = 0;

  printf(1, "fsfull test\n");
     406:	31 db                	xor    %ebx,%ebx

// what happens when the file system runs out of blocks?
// answer: balloc panics, so this test is not useful.
void
fsfull()
{
     408:	83 ec 5c             	sub    $0x5c,%esp
  int nfiles;
  int fsblocks = 0;

  printf(1, "fsfull test\n");
     40b:	c7 44 24 04 75 45 00 	movl   $0x4575,0x4(%esp)
     412:	00 
     413:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     41a:	e8 d1 3c 00 00       	call   40f0 <printf>
     41f:	90                   	nop

  for(nfiles = 0; ; nfiles++){
    char name[64];
    name[0] = 'f';
    name[1] = '0' + nfiles / 1000;
     420:	b8 d3 4d 62 10       	mov    $0x10624dd3,%eax
     425:	89 d9                	mov    %ebx,%ecx
     427:	f7 eb                	imul   %ebx
     429:	c1 f9 1f             	sar    $0x1f,%ecx

  printf(1, "fsfull test\n");

  for(nfiles = 0; ; nfiles++){
    char name[64];
    name[0] = 'f';
     42c:	c6 45 a8 66          	movb   $0x66,-0x58(%ebp)
    name[1] = '0' + nfiles / 1000;
    name[2] = '0' + (nfiles % 1000) / 100;
    name[3] = '0' + (nfiles % 100) / 10;
    name[4] = '0' + (nfiles % 10);
    name[5] = '\0';
     430:	c6 45 ad 00          	movb   $0x0,-0x53(%ebp)
  printf(1, "fsfull test\n");

  for(nfiles = 0; ; nfiles++){
    char name[64];
    name[0] = 'f';
    name[1] = '0' + nfiles / 1000;
     434:	c1 fa 06             	sar    $0x6,%edx
     437:	29 ca                	sub    %ecx,%edx
    name[2] = '0' + (nfiles % 1000) / 100;
     439:	69 f2 e8 03 00 00    	imul   $0x3e8,%edx,%esi
  printf(1, "fsfull test\n");

  for(nfiles = 0; ; nfiles++){
    char name[64];
    name[0] = 'f';
    name[1] = '0' + nfiles / 1000;
     43f:	8d 42 30             	lea    0x30(%edx),%eax
    name[2] = '0' + (nfiles % 1000) / 100;
     442:	89 da                	mov    %ebx,%edx
  printf(1, "fsfull test\n");

  for(nfiles = 0; ; nfiles++){
    char name[64];
    name[0] = 'f';
    name[1] = '0' + nfiles / 1000;
     444:	88 45 a9             	mov    %al,-0x57(%ebp)
    name[2] = '0' + (nfiles % 1000) / 100;
     447:	b8 1f 85 eb 51       	mov    $0x51eb851f,%eax
    name[3] = '0' + (nfiles % 100) / 10;
    name[4] = '0' + (nfiles % 10);
    name[5] = '\0';
    printf(1, "writing %s\n", name);
     44c:	c7 44 24 04 82 45 00 	movl   $0x4582,0x4(%esp)
     453:	00 

  for(nfiles = 0; ; nfiles++){
    char name[64];
    name[0] = 'f';
    name[1] = '0' + nfiles / 1000;
    name[2] = '0' + (nfiles % 1000) / 100;
     454:	29 f2                	sub    %esi,%edx
     456:	89 d6                	mov    %edx,%esi
     458:	f7 ea                	imul   %edx
    name[3] = '0' + (nfiles % 100) / 10;
     45a:	b8 1f 85 eb 51       	mov    $0x51eb851f,%eax

  for(nfiles = 0; ; nfiles++){
    char name[64];
    name[0] = 'f';
    name[1] = '0' + nfiles / 1000;
    name[2] = '0' + (nfiles % 1000) / 100;
     45f:	c1 fe 1f             	sar    $0x1f,%esi
    name[3] = '0' + (nfiles % 100) / 10;
    name[4] = '0' + (nfiles % 10);
    name[5] = '\0';
    printf(1, "writing %s\n", name);
     462:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)

  for(nfiles = 0; ; nfiles++){
    char name[64];
    name[0] = 'f';
    name[1] = '0' + nfiles / 1000;
    name[2] = '0' + (nfiles % 1000) / 100;
     469:	c1 fa 05             	sar    $0x5,%edx
     46c:	29 f2                	sub    %esi,%edx
    name[3] = '0' + (nfiles % 100) / 10;
     46e:	be 67 66 66 66       	mov    $0x66666667,%esi

  for(nfiles = 0; ; nfiles++){
    char name[64];
    name[0] = 'f';
    name[1] = '0' + nfiles / 1000;
    name[2] = '0' + (nfiles % 1000) / 100;
     473:	83 c2 30             	add    $0x30,%edx
     476:	88 55 aa             	mov    %dl,-0x56(%ebp)
    name[3] = '0' + (nfiles % 100) / 10;
     479:	f7 eb                	imul   %ebx
     47b:	c1 fa 05             	sar    $0x5,%edx
     47e:	29 ca                	sub    %ecx,%edx
     480:	6b fa 64             	imul   $0x64,%edx,%edi
     483:	89 da                	mov    %ebx,%edx
     485:	29 fa                	sub    %edi,%edx
     487:	89 d0                	mov    %edx,%eax
     489:	89 d7                	mov    %edx,%edi
     48b:	f7 ee                	imul   %esi
    name[4] = '0' + (nfiles % 10);
     48d:	89 d8                	mov    %ebx,%eax
  for(nfiles = 0; ; nfiles++){
    char name[64];
    name[0] = 'f';
    name[1] = '0' + nfiles / 1000;
    name[2] = '0' + (nfiles % 1000) / 100;
    name[3] = '0' + (nfiles % 100) / 10;
     48f:	c1 ff 1f             	sar    $0x1f,%edi
     492:	c1 fa 02             	sar    $0x2,%edx
     495:	29 fa                	sub    %edi,%edx
     497:	83 c2 30             	add    $0x30,%edx
     49a:	88 55 ab             	mov    %dl,-0x55(%ebp)
    name[4] = '0' + (nfiles % 10);
     49d:	f7 ee                	imul   %esi
     49f:	c1 fa 02             	sar    $0x2,%edx
     4a2:	29 ca                	sub    %ecx,%edx
     4a4:	8d 04 92             	lea    (%edx,%edx,4),%eax
     4a7:	89 da                	mov    %ebx,%edx
     4a9:	01 c0                	add    %eax,%eax
     4ab:	29 c2                	sub    %eax,%edx
     4ad:	89 d0                	mov    %edx,%eax
     4af:	83 c0 30             	add    $0x30,%eax
     4b2:	88 45 ac             	mov    %al,-0x54(%ebp)
    name[5] = '\0';
    printf(1, "writing %s\n", name);
     4b5:	8d 45 a8             	lea    -0x58(%ebp),%eax
     4b8:	89 44 24 08          	mov    %eax,0x8(%esp)
     4bc:	e8 2f 3c 00 00       	call   40f0 <printf>
    int fd = open(name, O_CREATE|O_RDWR);
     4c1:	8d 55 a8             	lea    -0x58(%ebp),%edx
     4c4:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
     4cb:	00 
     4cc:	89 14 24             	mov    %edx,(%esp)
     4cf:	e8 14 3b 00 00       	call   3fe8 <open>
    if(fd < 0){
     4d4:	85 c0                	test   %eax,%eax
    name[2] = '0' + (nfiles % 1000) / 100;
    name[3] = '0' + (nfiles % 100) / 10;
    name[4] = '0' + (nfiles % 10);
    name[5] = '\0';
    printf(1, "writing %s\n", name);
    int fd = open(name, O_CREATE|O_RDWR);
     4d6:	89 c7                	mov    %eax,%edi
    if(fd < 0){
     4d8:	78 53                	js     52d <fsfull+0x12d>
      printf(1, "open %s failed\n", name);
      break;
     4da:	31 f6                	xor    %esi,%esi
     4dc:	eb 04                	jmp    4e2 <fsfull+0xe2>
     4de:	66 90                	xchg   %ax,%ax
    int total = 0;
    while(1){
      int cc = write(fd, buf, 512);
      if(cc < 512)
        break;
      total += cc;
     4e0:	01 c6                	add    %eax,%esi
      printf(1, "open %s failed\n", name);
      break;
    }
    int total = 0;
    while(1){
      int cc = write(fd, buf, 512);
     4e2:	c7 44 24 08 00 02 00 	movl   $0x200,0x8(%esp)
     4e9:	00 
     4ea:	c7 44 24 04 00 84 00 	movl   $0x8400,0x4(%esp)
     4f1:	00 
     4f2:	89 3c 24             	mov    %edi,(%esp)
     4f5:	e8 ce 3a 00 00       	call   3fc8 <write>
      if(cc < 512)
     4fa:	3d ff 01 00 00       	cmp    $0x1ff,%eax
     4ff:	7f df                	jg     4e0 <fsfull+0xe0>
        break;
      total += cc;
      fsblocks++;
    }
    printf(1, "wrote %d bytes\n", total);
     501:	89 74 24 08          	mov    %esi,0x8(%esp)
     505:	c7 44 24 04 9e 45 00 	movl   $0x459e,0x4(%esp)
     50c:	00 
     50d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     514:	e8 d7 3b 00 00       	call   40f0 <printf>
    close(fd);
     519:	89 3c 24             	mov    %edi,(%esp)
     51c:	e8 af 3a 00 00       	call   3fd0 <close>
    if(total == 0)
     521:	85 f6                	test   %esi,%esi
     523:	74 23                	je     548 <fsfull+0x148>
  int nfiles;
  int fsblocks = 0;

  printf(1, "fsfull test\n");

  for(nfiles = 0; ; nfiles++){
     525:	83 c3 01             	add    $0x1,%ebx
    }
    printf(1, "wrote %d bytes\n", total);
    close(fd);
    if(total == 0)
      break;
  }
     528:	e9 f3 fe ff ff       	jmp    420 <fsfull+0x20>
    name[4] = '0' + (nfiles % 10);
    name[5] = '\0';
    printf(1, "writing %s\n", name);
    int fd = open(name, O_CREATE|O_RDWR);
    if(fd < 0){
      printf(1, "open %s failed\n", name);
     52d:	8d 45 a8             	lea    -0x58(%ebp),%eax
     530:	89 44 24 08          	mov    %eax,0x8(%esp)
     534:	c7 44 24 04 8e 45 00 	movl   $0x458e,0x4(%esp)
     53b:	00 
     53c:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     543:	e8 a8 3b 00 00       	call   40f0 <printf>
  }

  while(nfiles >= 0){
    char name[64];
    name[0] = 'f';
    name[1] = '0' + nfiles / 1000;
     548:	b8 d3 4d 62 10       	mov    $0x10624dd3,%eax
     54d:	89 d9                	mov    %ebx,%ecx
     54f:	f7 eb                	imul   %ebx
     551:	c1 f9 1f             	sar    $0x1f,%ecx
      break;
  }

  while(nfiles >= 0){
    char name[64];
    name[0] = 'f';
     554:	c6 45 a8 66          	movb   $0x66,-0x58(%ebp)
    name[1] = '0' + nfiles / 1000;
    name[2] = '0' + (nfiles % 1000) / 100;
    name[3] = '0' + (nfiles % 100) / 10;
    name[4] = '0' + (nfiles % 10);
    name[5] = '\0';
     558:	c6 45 ad 00          	movb   $0x0,-0x53(%ebp)
  }

  while(nfiles >= 0){
    char name[64];
    name[0] = 'f';
    name[1] = '0' + nfiles / 1000;
     55c:	c1 fa 06             	sar    $0x6,%edx
     55f:	29 ca                	sub    %ecx,%edx
    name[2] = '0' + (nfiles % 1000) / 100;
     561:	69 f2 e8 03 00 00    	imul   $0x3e8,%edx,%esi
  }

  while(nfiles >= 0){
    char name[64];
    name[0] = 'f';
    name[1] = '0' + nfiles / 1000;
     567:	8d 42 30             	lea    0x30(%edx),%eax
    name[2] = '0' + (nfiles % 1000) / 100;
     56a:	89 da                	mov    %ebx,%edx
  }

  while(nfiles >= 0){
    char name[64];
    name[0] = 'f';
    name[1] = '0' + nfiles / 1000;
     56c:	88 45 a9             	mov    %al,-0x57(%ebp)
    name[2] = '0' + (nfiles % 1000) / 100;
     56f:	b8 1f 85 eb 51       	mov    $0x51eb851f,%eax
     574:	29 f2                	sub    %esi,%edx
     576:	89 d6                	mov    %edx,%esi
     578:	f7 ea                	imul   %edx
    name[3] = '0' + (nfiles % 100) / 10;
     57a:	b8 1f 85 eb 51       	mov    $0x51eb851f,%eax

  while(nfiles >= 0){
    char name[64];
    name[0] = 'f';
    name[1] = '0' + nfiles / 1000;
    name[2] = '0' + (nfiles % 1000) / 100;
     57f:	c1 fe 1f             	sar    $0x1f,%esi
     582:	c1 fa 05             	sar    $0x5,%edx
     585:	29 f2                	sub    %esi,%edx
    name[3] = '0' + (nfiles % 100) / 10;
     587:	be 67 66 66 66       	mov    $0x66666667,%esi

  while(nfiles >= 0){
    char name[64];
    name[0] = 'f';
    name[1] = '0' + nfiles / 1000;
    name[2] = '0' + (nfiles % 1000) / 100;
     58c:	83 c2 30             	add    $0x30,%edx
     58f:	88 55 aa             	mov    %dl,-0x56(%ebp)
    name[3] = '0' + (nfiles % 100) / 10;
     592:	f7 eb                	imul   %ebx
     594:	c1 fa 05             	sar    $0x5,%edx
     597:	29 ca                	sub    %ecx,%edx
     599:	6b fa 64             	imul   $0x64,%edx,%edi
     59c:	89 da                	mov    %ebx,%edx
     59e:	29 fa                	sub    %edi,%edx
     5a0:	89 d0                	mov    %edx,%eax
     5a2:	89 d7                	mov    %edx,%edi
     5a4:	f7 ee                	imul   %esi
    name[4] = '0' + (nfiles % 10);
     5a6:	89 d8                	mov    %ebx,%eax
  while(nfiles >= 0){
    char name[64];
    name[0] = 'f';
    name[1] = '0' + nfiles / 1000;
    name[2] = '0' + (nfiles % 1000) / 100;
    name[3] = '0' + (nfiles % 100) / 10;
     5a8:	c1 ff 1f             	sar    $0x1f,%edi
     5ab:	c1 fa 02             	sar    $0x2,%edx
     5ae:	29 fa                	sub    %edi,%edx
     5b0:	83 c2 30             	add    $0x30,%edx
     5b3:	88 55 ab             	mov    %dl,-0x55(%ebp)
    name[4] = '0' + (nfiles % 10);
     5b6:	f7 ee                	imul   %esi
     5b8:	c1 fa 02             	sar    $0x2,%edx
     5bb:	29 ca                	sub    %ecx,%edx
     5bd:	8d 04 92             	lea    (%edx,%edx,4),%eax
     5c0:	89 da                	mov    %ebx,%edx
     5c2:	01 c0                	add    %eax,%eax
    name[5] = '\0';
    unlink(name);
    nfiles--;
     5c4:	83 eb 01             	sub    $0x1,%ebx
    char name[64];
    name[0] = 'f';
    name[1] = '0' + nfiles / 1000;
    name[2] = '0' + (nfiles % 1000) / 100;
    name[3] = '0' + (nfiles % 100) / 10;
    name[4] = '0' + (nfiles % 10);
     5c7:	29 c2                	sub    %eax,%edx
     5c9:	89 d0                	mov    %edx,%eax
     5cb:	83 c0 30             	add    $0x30,%eax
     5ce:	88 45 ac             	mov    %al,-0x54(%ebp)
    name[5] = '\0';
    unlink(name);
     5d1:	8d 45 a8             	lea    -0x58(%ebp),%eax
     5d4:	89 04 24             	mov    %eax,(%esp)
     5d7:	e8 1c 3a 00 00       	call   3ff8 <unlink>
    close(fd);
    if(total == 0)
      break;
  }

  while(nfiles >= 0){
     5dc:	83 fb ff             	cmp    $0xffffffff,%ebx
     5df:	0f 85 63 ff ff ff    	jne    548 <fsfull+0x148>
    name[5] = '\0';
    unlink(name);
    nfiles--;
  }

  printf(1, "fsfull test finished\n");
     5e5:	c7 44 24 04 ae 45 00 	movl   $0x45ae,0x4(%esp)
     5ec:	00 
     5ed:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     5f4:	e8 f7 3a 00 00       	call   40f0 <printf>
}
     5f9:	83 c4 5c             	add    $0x5c,%esp
     5fc:	5b                   	pop    %ebx
     5fd:	5e                   	pop    %esi
     5fe:	5f                   	pop    %edi
     5ff:	5d                   	pop    %ebp
     600:	c3                   	ret    
     601:	eb 0d                	jmp    610 <bigwrite>
     603:	90                   	nop
     604:	90                   	nop
     605:	90                   	nop
     606:	90                   	nop
     607:	90                   	nop
     608:	90                   	nop
     609:	90                   	nop
     60a:	90                   	nop
     60b:	90                   	nop
     60c:	90                   	nop
     60d:	90                   	nop
     60e:	90                   	nop
     60f:	90                   	nop

00000610 <bigwrite>:
}

// test writes that are larger than the log.
void
bigwrite(void)
{
     610:	55                   	push   %ebp
     611:	89 e5                	mov    %esp,%ebp
     613:	56                   	push   %esi
     614:	53                   	push   %ebx
  int fd, sz;

  printf(1, "bigwrite test\n");

  unlink("bigwrite");
     615:	bb f3 01 00 00       	mov    $0x1f3,%ebx
}

// test writes that are larger than the log.
void
bigwrite(void)
{
     61a:	83 ec 10             	sub    $0x10,%esp
  int fd, sz;

  printf(1, "bigwrite test\n");
     61d:	c7 44 24 04 c4 45 00 	movl   $0x45c4,0x4(%esp)
     624:	00 
     625:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     62c:	e8 bf 3a 00 00       	call   40f0 <printf>

  unlink("bigwrite");
     631:	c7 04 24 d3 45 00 00 	movl   $0x45d3,(%esp)
     638:	e8 bb 39 00 00       	call   3ff8 <unlink>
     63d:	8d 76 00             	lea    0x0(%esi),%esi
  for(sz = 499; sz < 12*512; sz += 471){
    fd = open("bigwrite", O_CREATE | O_RDWR);
     640:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
     647:	00 
     648:	c7 04 24 d3 45 00 00 	movl   $0x45d3,(%esp)
     64f:	e8 94 39 00 00       	call   3fe8 <open>
    if(fd < 0){
     654:	85 c0                	test   %eax,%eax

  printf(1, "bigwrite test\n");

  unlink("bigwrite");
  for(sz = 499; sz < 12*512; sz += 471){
    fd = open("bigwrite", O_CREATE | O_RDWR);
     656:	89 c6                	mov    %eax,%esi
    if(fd < 0){
     658:	0f 88 95 00 00 00    	js     6f3 <bigwrite+0xe3>
      printf(1, "cannot create bigwrite\n");
      exit(0);
    }
    int i;
    for(i = 0; i < 2; i++){
      int cc = write(fd, buf, sz);
     65e:	89 5c 24 08          	mov    %ebx,0x8(%esp)
     662:	c7 44 24 04 00 84 00 	movl   $0x8400,0x4(%esp)
     669:	00 
     66a:	89 04 24             	mov    %eax,(%esp)
     66d:	e8 56 39 00 00       	call   3fc8 <write>
      if(cc != sz){
     672:	39 c3                	cmp    %eax,%ebx
     674:	75 55                	jne    6cb <bigwrite+0xbb>
      printf(1, "cannot create bigwrite\n");
      exit(0);
    }
    int i;
    for(i = 0; i < 2; i++){
      int cc = write(fd, buf, sz);
     676:	89 5c 24 08          	mov    %ebx,0x8(%esp)
     67a:	c7 44 24 04 00 84 00 	movl   $0x8400,0x4(%esp)
     681:	00 
     682:	89 34 24             	mov    %esi,(%esp)
     685:	e8 3e 39 00 00       	call   3fc8 <write>
      if(cc != sz){
     68a:	39 d8                	cmp    %ebx,%eax
     68c:	75 3d                	jne    6cb <bigwrite+0xbb>
  int fd, sz;

  printf(1, "bigwrite test\n");

  unlink("bigwrite");
  for(sz = 499; sz < 12*512; sz += 471){
     68e:	81 c3 d7 01 00 00    	add    $0x1d7,%ebx
      if(cc != sz){
        printf(1, "write(%d) ret %d\n", sz, cc);
        exit(0);
      }
    }
    close(fd);
     694:	89 34 24             	mov    %esi,(%esp)
     697:	e8 34 39 00 00       	call   3fd0 <close>
    unlink("bigwrite");
     69c:	c7 04 24 d3 45 00 00 	movl   $0x45d3,(%esp)
     6a3:	e8 50 39 00 00       	call   3ff8 <unlink>
  int fd, sz;

  printf(1, "bigwrite test\n");

  unlink("bigwrite");
  for(sz = 499; sz < 12*512; sz += 471){
     6a8:	81 fb 07 18 00 00    	cmp    $0x1807,%ebx
     6ae:	75 90                	jne    640 <bigwrite+0x30>
    }
    close(fd);
    unlink("bigwrite");
  }

  printf(1, "bigwrite ok\n");
     6b0:	c7 44 24 04 06 46 00 	movl   $0x4606,0x4(%esp)
     6b7:	00 
     6b8:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     6bf:	e8 2c 3a 00 00       	call   40f0 <printf>
}
     6c4:	83 c4 10             	add    $0x10,%esp
     6c7:	5b                   	pop    %ebx
     6c8:	5e                   	pop    %esi
     6c9:	5d                   	pop    %ebp
     6ca:	c3                   	ret    
    }
    int i;
    for(i = 0; i < 2; i++){
      int cc = write(fd, buf, sz);
      if(cc != sz){
        printf(1, "write(%d) ret %d\n", sz, cc);
     6cb:	89 44 24 0c          	mov    %eax,0xc(%esp)
     6cf:	89 5c 24 08          	mov    %ebx,0x8(%esp)
     6d3:	c7 44 24 04 f4 45 00 	movl   $0x45f4,0x4(%esp)
     6da:	00 
     6db:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     6e2:	e8 09 3a 00 00       	call   40f0 <printf>
        exit(0);
     6e7:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     6ee:	e8 b5 38 00 00       	call   3fa8 <exit>

  unlink("bigwrite");
  for(sz = 499; sz < 12*512; sz += 471){
    fd = open("bigwrite", O_CREATE | O_RDWR);
    if(fd < 0){
      printf(1, "cannot create bigwrite\n");
     6f3:	c7 44 24 04 dc 45 00 	movl   $0x45dc,0x4(%esp)
     6fa:	00 
     6fb:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     702:	e8 e9 39 00 00       	call   40f0 <printf>
      exit(0);
     707:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     70e:	e8 95 38 00 00       	call   3fa8 <exit>
     713:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     719:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000720 <unlinkread>:
}

// can I unlink a file and still read it?
void
unlinkread(void)
{
     720:	55                   	push   %ebp
     721:	89 e5                	mov    %esp,%ebp
     723:	56                   	push   %esi
     724:	53                   	push   %ebx
     725:	83 ec 10             	sub    $0x10,%esp
  int fd, fd1;

  printf(1, "unlinkread test\n");
     728:	c7 44 24 04 13 46 00 	movl   $0x4613,0x4(%esp)
     72f:	00 
     730:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     737:	e8 b4 39 00 00       	call   40f0 <printf>
  fd = open("unlinkread", O_CREATE | O_RDWR);
     73c:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
     743:	00 
     744:	c7 04 24 24 46 00 00 	movl   $0x4624,(%esp)
     74b:	e8 98 38 00 00       	call   3fe8 <open>
  if(fd < 0){
     750:	85 c0                	test   %eax,%eax
unlinkread(void)
{
  int fd, fd1;

  printf(1, "unlinkread test\n");
  fd = open("unlinkread", O_CREATE | O_RDWR);
     752:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
     754:	0f 88 02 01 00 00    	js     85c <unlinkread+0x13c>
    printf(1, "create unlinkread failed\n");
    exit(0);
  }
  write(fd, "hello", 5);
     75a:	c7 44 24 08 05 00 00 	movl   $0x5,0x8(%esp)
     761:	00 
     762:	c7 44 24 04 49 46 00 	movl   $0x4649,0x4(%esp)
     769:	00 
     76a:	89 04 24             	mov    %eax,(%esp)
     76d:	e8 56 38 00 00       	call   3fc8 <write>
  close(fd);
     772:	89 1c 24             	mov    %ebx,(%esp)
     775:	e8 56 38 00 00       	call   3fd0 <close>

  fd = open("unlinkread", O_RDWR);
     77a:	c7 44 24 04 02 00 00 	movl   $0x2,0x4(%esp)
     781:	00 
     782:	c7 04 24 24 46 00 00 	movl   $0x4624,(%esp)
     789:	e8 5a 38 00 00       	call   3fe8 <open>
  if(fd < 0){
     78e:	85 c0                	test   %eax,%eax
    exit(0);
  }
  write(fd, "hello", 5);
  close(fd);

  fd = open("unlinkread", O_RDWR);
     790:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
     792:	0f 88 64 01 00 00    	js     8fc <unlinkread+0x1dc>
    printf(1, "open unlinkread failed\n");
    exit(0);
  }
  if(unlink("unlinkread") != 0){
     798:	c7 04 24 24 46 00 00 	movl   $0x4624,(%esp)
     79f:	e8 54 38 00 00       	call   3ff8 <unlink>
     7a4:	85 c0                	test   %eax,%eax
     7a6:	0f 85 30 01 00 00    	jne    8dc <unlinkread+0x1bc>
    printf(1, "unlink unlinkread failed\n");
    exit(0);
  }

  fd1 = open("unlinkread", O_CREATE | O_RDWR);
     7ac:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
     7b3:	00 
     7b4:	c7 04 24 24 46 00 00 	movl   $0x4624,(%esp)
     7bb:	e8 28 38 00 00       	call   3fe8 <open>
  write(fd1, "yyy", 3);
     7c0:	c7 44 24 08 03 00 00 	movl   $0x3,0x8(%esp)
     7c7:	00 
     7c8:	c7 44 24 04 81 46 00 	movl   $0x4681,0x4(%esp)
     7cf:	00 
  if(unlink("unlinkread") != 0){
    printf(1, "unlink unlinkread failed\n");
    exit(0);
  }

  fd1 = open("unlinkread", O_CREATE | O_RDWR);
     7d0:	89 c6                	mov    %eax,%esi
  write(fd1, "yyy", 3);
     7d2:	89 04 24             	mov    %eax,(%esp)
     7d5:	e8 ee 37 00 00       	call   3fc8 <write>
  close(fd1);
     7da:	89 34 24             	mov    %esi,(%esp)
     7dd:	e8 ee 37 00 00       	call   3fd0 <close>

  if(read(fd, buf, sizeof(buf)) != 5){
     7e2:	c7 44 24 08 00 20 00 	movl   $0x2000,0x8(%esp)
     7e9:	00 
     7ea:	c7 44 24 04 00 84 00 	movl   $0x8400,0x4(%esp)
     7f1:	00 
     7f2:	89 1c 24             	mov    %ebx,(%esp)
     7f5:	e8 c6 37 00 00       	call   3fc0 <read>
     7fa:	83 f8 05             	cmp    $0x5,%eax
     7fd:	0f 85 b9 00 00 00    	jne    8bc <unlinkread+0x19c>
    printf(1, "unlinkread read failed");
    exit(0);
  }
  if(buf[0] != 'h'){
     803:	80 3d 00 84 00 00 68 	cmpb   $0x68,0x8400
     80a:	0f 85 8c 00 00 00    	jne    89c <unlinkread+0x17c>
    printf(1, "unlinkread wrong data\n");
    exit(0);
  }
  if(write(fd, buf, 10) != 10){
     810:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
     817:	00 
     818:	c7 44 24 04 00 84 00 	movl   $0x8400,0x4(%esp)
     81f:	00 
     820:	89 1c 24             	mov    %ebx,(%esp)
     823:	e8 a0 37 00 00       	call   3fc8 <write>
     828:	83 f8 0a             	cmp    $0xa,%eax
     82b:	75 4f                	jne    87c <unlinkread+0x15c>
    printf(1, "unlinkread write failed\n");
    exit(0);
  }
  close(fd);
     82d:	89 1c 24             	mov    %ebx,(%esp)
     830:	e8 9b 37 00 00       	call   3fd0 <close>
  unlink("unlinkread");
     835:	c7 04 24 24 46 00 00 	movl   $0x4624,(%esp)
     83c:	e8 b7 37 00 00       	call   3ff8 <unlink>
  printf(1, "unlinkread ok\n");
     841:	c7 44 24 04 cc 46 00 	movl   $0x46cc,0x4(%esp)
     848:	00 
     849:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     850:	e8 9b 38 00 00       	call   40f0 <printf>
}
     855:	83 c4 10             	add    $0x10,%esp
     858:	5b                   	pop    %ebx
     859:	5e                   	pop    %esi
     85a:	5d                   	pop    %ebp
     85b:	c3                   	ret    
  int fd, fd1;

  printf(1, "unlinkread test\n");
  fd = open("unlinkread", O_CREATE | O_RDWR);
  if(fd < 0){
    printf(1, "create unlinkread failed\n");
     85c:	c7 44 24 04 2f 46 00 	movl   $0x462f,0x4(%esp)
     863:	00 
     864:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     86b:	e8 80 38 00 00       	call   40f0 <printf>
    exit(0);
     870:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     877:	e8 2c 37 00 00       	call   3fa8 <exit>
  if(buf[0] != 'h'){
    printf(1, "unlinkread wrong data\n");
    exit(0);
  }
  if(write(fd, buf, 10) != 10){
    printf(1, "unlinkread write failed\n");
     87c:	c7 44 24 04 b3 46 00 	movl   $0x46b3,0x4(%esp)
     883:	00 
     884:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     88b:	e8 60 38 00 00       	call   40f0 <printf>
    exit(0);
     890:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     897:	e8 0c 37 00 00       	call   3fa8 <exit>
  if(read(fd, buf, sizeof(buf)) != 5){
    printf(1, "unlinkread read failed");
    exit(0);
  }
  if(buf[0] != 'h'){
    printf(1, "unlinkread wrong data\n");
     89c:	c7 44 24 04 9c 46 00 	movl   $0x469c,0x4(%esp)
     8a3:	00 
     8a4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     8ab:	e8 40 38 00 00       	call   40f0 <printf>
    exit(0);
     8b0:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     8b7:	e8 ec 36 00 00       	call   3fa8 <exit>
  fd1 = open("unlinkread", O_CREATE | O_RDWR);
  write(fd1, "yyy", 3);
  close(fd1);

  if(read(fd, buf, sizeof(buf)) != 5){
    printf(1, "unlinkread read failed");
     8bc:	c7 44 24 04 85 46 00 	movl   $0x4685,0x4(%esp)
     8c3:	00 
     8c4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     8cb:	e8 20 38 00 00       	call   40f0 <printf>
    exit(0);
     8d0:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     8d7:	e8 cc 36 00 00       	call   3fa8 <exit>
  if(fd < 0){
    printf(1, "open unlinkread failed\n");
    exit(0);
  }
  if(unlink("unlinkread") != 0){
    printf(1, "unlink unlinkread failed\n");
     8dc:	c7 44 24 04 67 46 00 	movl   $0x4667,0x4(%esp)
     8e3:	00 
     8e4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     8eb:	e8 00 38 00 00       	call   40f0 <printf>
    exit(0);
     8f0:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     8f7:	e8 ac 36 00 00       	call   3fa8 <exit>
  write(fd, "hello", 5);
  close(fd);

  fd = open("unlinkread", O_RDWR);
  if(fd < 0){
    printf(1, "open unlinkread failed\n");
     8fc:	c7 44 24 04 4f 46 00 	movl   $0x464f,0x4(%esp)
     903:	00 
     904:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     90b:	e8 e0 37 00 00       	call   40f0 <printf>
    exit(0);
     910:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     917:	e8 8c 36 00 00       	call   3fa8 <exit>
     91c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000920 <createdelete>:
}

// four processes create and delete different files in same directory
void
createdelete(void)
{
     920:	55                   	push   %ebp
     921:	89 e5                	mov    %esp,%ebp
     923:	57                   	push   %edi
     924:	56                   	push   %esi
     925:	53                   	push   %ebx
  enum { N = 20 };
  int pid, i, fd, pi;
  char name[32];

  printf(1, "createdelete test\n");
     926:	31 db                	xor    %ebx,%ebx
}

// four processes create and delete different files in same directory
void
createdelete(void)
{
     928:	83 ec 4c             	sub    $0x4c,%esp
  enum { N = 20 };
  int pid, i, fd, pi;
  char name[32];

  printf(1, "createdelete test\n");
     92b:	c7 44 24 04 db 46 00 	movl   $0x46db,0x4(%esp)
     932:	00 
     933:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     93a:	e8 b1 37 00 00       	call   40f0 <printf>

  for(pi = 0; pi < 4; pi++){
    pid = fork();
     93f:	e8 5c 36 00 00       	call   3fa0 <fork>
    if(pid < 0){
     944:	83 f8 00             	cmp    $0x0,%eax
     947:	0f 8c 00 02 00 00    	jl     b4d <createdelete+0x22d>
     94d:	8d 76 00             	lea    0x0(%esi),%esi
      printf(1, "fork failed\n");
      exit(0);
    }

    if(pid == 0){
     950:	0f 84 09 01 00 00    	je     a5f <createdelete+0x13f>
  int pid, i, fd, pi;
  char name[32];

  printf(1, "createdelete test\n");

  for(pi = 0; pi < 4; pi++){
     956:	83 c3 01             	add    $0x1,%ebx
     959:	83 fb 04             	cmp    $0x4,%ebx
     95c:	75 e1                	jne    93f <createdelete+0x1f>
     95e:	8d 75 c8             	lea    -0x38(%ebp),%esi

  for(pi = 0; pi < 4; pi++){
    wait(0);
  }

  name[0] = name[1] = name[2] = 0;
     961:	31 ff                	xor    %edi,%edi
      exit(0);
    }
  }

  for(pi = 0; pi < 4; pi++){
    wait(0);
     963:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     96a:	e8 41 36 00 00       	call   3fb0 <wait>
     96f:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     976:	e8 35 36 00 00       	call   3fb0 <wait>
     97b:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     982:	e8 29 36 00 00       	call   3fb0 <wait>
     987:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     98e:	e8 1d 36 00 00       	call   3fb0 <wait>
  }

  name[0] = name[1] = name[2] = 0;
     993:	c6 45 ca 00          	movb   $0x0,-0x36(%ebp)
     997:	89 75 c0             	mov    %esi,-0x40(%ebp)
     99a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(i = 0; i < N; i++){
     9a0:	8d 47 30             	lea    0x30(%edi),%eax
     9a3:	85 ff                	test   %edi,%edi
     9a5:	88 45 c4             	mov    %al,-0x3c(%ebp)
     9a8:	0f 94 c0             	sete   %al
     9ab:	83 ff 09             	cmp    $0x9,%edi
     9ae:	0f 9f c2             	setg   %dl
     9b1:	bb 70 00 00 00       	mov    $0x70,%ebx
     9b6:	89 d6                	mov    %edx,%esi
     9b8:	09 c6                	or     %eax,%esi
      name[1] = '0' + i;
      fd = open(name, 0);
      if((i == 0 || i >= N/2) && fd < 0){
        printf(1, "oops createdelete %s didn't exist\n", name);
        exit(0);
      } else if((i >= 1 && i < N/2) && fd >= 0){
     9ba:	8d 47 ff             	lea    -0x1(%edi),%eax
     9bd:	89 45 bc             	mov    %eax,-0x44(%ebp)
  name[0] = name[1] = name[2] = 0;
  for(i = 0; i < N; i++){
    for(pi = 0; pi < 4; pi++){
      name[0] = 'p' + pi;
      name[1] = '0' + i;
      fd = open(name, 0);
     9c0:	8b 55 c0             	mov    -0x40(%ebp),%edx

  name[0] = name[1] = name[2] = 0;
  for(i = 0; i < N; i++){
    for(pi = 0; pi < 4; pi++){
      name[0] = 'p' + pi;
      name[1] = '0' + i;
     9c3:	0f b6 45 c4          	movzbl -0x3c(%ebp),%eax
  }

  name[0] = name[1] = name[2] = 0;
  for(i = 0; i < N; i++){
    for(pi = 0; pi < 4; pi++){
      name[0] = 'p' + pi;
     9c7:	88 5d c8             	mov    %bl,-0x38(%ebp)
      name[1] = '0' + i;
      fd = open(name, 0);
     9ca:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
     9d1:	00 
     9d2:	89 14 24             	mov    %edx,(%esp)

  name[0] = name[1] = name[2] = 0;
  for(i = 0; i < N; i++){
    for(pi = 0; pi < 4; pi++){
      name[0] = 'p' + pi;
      name[1] = '0' + i;
     9d5:	88 45 c9             	mov    %al,-0x37(%ebp)
      fd = open(name, 0);
     9d8:	e8 0b 36 00 00       	call   3fe8 <open>
      if((i == 0 || i >= N/2) && fd < 0){
     9dd:	89 f2                	mov    %esi,%edx
     9df:	84 d2                	test   %dl,%dl
     9e1:	74 08                	je     9eb <createdelete+0xcb>
     9e3:	85 c0                	test   %eax,%eax
     9e5:	0f 88 01 01 00 00    	js     aec <createdelete+0x1cc>
        printf(1, "oops createdelete %s didn't exist\n", name);
        exit(0);
      } else if((i >= 1 && i < N/2) && fd >= 0){
     9eb:	85 c0                	test   %eax,%eax
     9ed:	8d 76 00             	lea    0x0(%esi),%esi
     9f0:	0f 89 1d 01 00 00    	jns    b13 <createdelete+0x1f3>
        printf(1, "oops createdelete %s did exist\n", name);
        exit(0);
      }
      if(fd >= 0)
        close(fd);
     9f6:	83 c3 01             	add    $0x1,%ebx
    wait(0);
  }

  name[0] = name[1] = name[2] = 0;
  for(i = 0; i < N; i++){
    for(pi = 0; pi < 4; pi++){
     9f9:	80 fb 74             	cmp    $0x74,%bl
     9fc:	75 c2                	jne    9c0 <createdelete+0xa0>
  for(pi = 0; pi < 4; pi++){
    wait(0);
  }

  name[0] = name[1] = name[2] = 0;
  for(i = 0; i < N; i++){
     9fe:	83 c7 01             	add    $0x1,%edi
     a01:	83 ff 14             	cmp    $0x14,%edi
     a04:	75 9a                	jne    9a0 <createdelete+0x80>
     a06:	8b 75 c0             	mov    -0x40(%ebp),%esi
     a09:	bf 70 00 00 00       	mov    $0x70,%edi
     a0e:	89 75 c4             	mov    %esi,-0x3c(%ebp)
     a11:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      if(fd >= 0)
        close(fd);
    }
  }

  for(i = 0; i < N; i++){
     a18:	8d 77 c0             	lea    -0x40(%edi),%esi
     a1b:	31 db                	xor    %ebx,%ebx
    for(pi = 0; pi < 4; pi++){
      name[0] = 'p' + i;
     a1d:	89 fa                	mov    %edi,%edx
      name[1] = '0' + i;
     a1f:	89 f0                	mov    %esi,%eax
    }
  }

  for(i = 0; i < N; i++){
    for(pi = 0; pi < 4; pi++){
      name[0] = 'p' + i;
     a21:	88 55 c8             	mov    %dl,-0x38(%ebp)
      name[1] = '0' + i;
      unlink(name);
     a24:	8b 55 c4             	mov    -0x3c(%ebp),%edx
        close(fd);
    }
  }

  for(i = 0; i < N; i++){
    for(pi = 0; pi < 4; pi++){
     a27:	83 c3 01             	add    $0x1,%ebx
      name[0] = 'p' + i;
      name[1] = '0' + i;
     a2a:	88 45 c9             	mov    %al,-0x37(%ebp)
      unlink(name);
     a2d:	89 14 24             	mov    %edx,(%esp)
     a30:	e8 c3 35 00 00       	call   3ff8 <unlink>
        close(fd);
    }
  }

  for(i = 0; i < N; i++){
    for(pi = 0; pi < 4; pi++){
     a35:	83 fb 04             	cmp    $0x4,%ebx
     a38:	75 e3                	jne    a1d <createdelete+0xfd>
     a3a:	83 c7 01             	add    $0x1,%edi
      if(fd >= 0)
        close(fd);
    }
  }

  for(i = 0; i < N; i++){
     a3d:	89 f8                	mov    %edi,%eax
     a3f:	3c 84                	cmp    $0x84,%al
     a41:	75 d5                	jne    a18 <createdelete+0xf8>
      name[1] = '0' + i;
      unlink(name);
    }
  }

  printf(1, "createdelete ok\n");
     a43:	c7 44 24 04 fd 46 00 	movl   $0x46fd,0x4(%esp)
     a4a:	00 
     a4b:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     a52:	e8 99 36 00 00       	call   40f0 <printf>
}
     a57:	83 c4 4c             	add    $0x4c,%esp
     a5a:	5b                   	pop    %ebx
     a5b:	5e                   	pop    %esi
     a5c:	5f                   	pop    %edi
     a5d:	5d                   	pop    %ebp
     a5e:	c3                   	ret    
      printf(1, "fork failed\n");
      exit(0);
    }

    if(pid == 0){
      name[0] = 'p' + pi;
     a5f:	83 c3 70             	add    $0x70,%ebx
      name[2] = '\0';
     a62:	bf 01 00 00 00       	mov    $0x1,%edi
      printf(1, "fork failed\n");
      exit(0);
    }

    if(pid == 0){
      name[0] = 'p' + pi;
     a67:	88 5d c8             	mov    %bl,-0x38(%ebp)
     a6a:	8d 75 c8             	lea    -0x38(%ebp),%esi
      name[2] = '\0';
     a6d:	31 db                	xor    %ebx,%ebx
     a6f:	c6 45 ca 00          	movb   $0x0,-0x36(%ebp)
     a73:	eb 12                	jmp    a87 <createdelete+0x167>
     a75:	8d 76 00             	lea    0x0(%esi),%esi
      for(i = 0; i < N; i++){
     a78:	83 ff 13             	cmp    $0x13,%edi
     a7b:	0f 8f 86 00 00 00    	jg     b07 <createdelete+0x1e7>
      exit(0);
    }

    if(pid == 0){
      name[0] = 'p' + pi;
      name[2] = '\0';
     a81:	83 c3 01             	add    $0x1,%ebx
     a84:	83 c7 01             	add    $0x1,%edi
      for(i = 0; i < N; i++){
        name[1] = '0' + i;
     a87:	8d 43 30             	lea    0x30(%ebx),%eax
     a8a:	88 45 c9             	mov    %al,-0x37(%ebp)
        fd = open(name, O_CREATE | O_RDWR);
     a8d:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
     a94:	00 
     a95:	89 34 24             	mov    %esi,(%esp)
     a98:	e8 4b 35 00 00       	call   3fe8 <open>
        if(fd < 0){
     a9d:	85 c0                	test   %eax,%eax
     a9f:	0f 88 c8 00 00 00    	js     b6d <createdelete+0x24d>
          printf(1, "create failed\n");
          exit(0);
        }
        close(fd);
     aa5:	89 04 24             	mov    %eax,(%esp)
     aa8:	e8 23 35 00 00       	call   3fd0 <close>
        if(i > 0 && (i % 2 ) == 0){
     aad:	85 db                	test   %ebx,%ebx
     aaf:	74 d0                	je     a81 <createdelete+0x161>
     ab1:	f6 c3 01             	test   $0x1,%bl
     ab4:	75 c2                	jne    a78 <createdelete+0x158>
          name[1] = '0' + (i / 2);
     ab6:	89 d8                	mov    %ebx,%eax
     ab8:	d1 f8                	sar    %eax
     aba:	83 c0 30             	add    $0x30,%eax
     abd:	88 45 c9             	mov    %al,-0x37(%ebp)
          if(unlink(name) < 0){
     ac0:	89 34 24             	mov    %esi,(%esp)
     ac3:	e8 30 35 00 00       	call   3ff8 <unlink>
     ac8:	85 c0                	test   %eax,%eax
     aca:	79 ac                	jns    a78 <createdelete+0x158>
            printf(1, "unlink failed\n");
     acc:	c7 44 24 04 ee 46 00 	movl   $0x46ee,0x4(%esp)
     ad3:	00 
     ad4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     adb:	e8 10 36 00 00       	call   40f0 <printf>
            exit(0);
     ae0:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     ae7:	e8 bc 34 00 00       	call   3fa8 <exit>
     aec:	8b 75 c0             	mov    -0x40(%ebp),%esi
    for(pi = 0; pi < 4; pi++){
      name[0] = 'p' + pi;
      name[1] = '0' + i;
      fd = open(name, 0);
      if((i == 0 || i >= N/2) && fd < 0){
        printf(1, "oops createdelete %s didn't exist\n", name);
     aef:	c7 44 24 04 c4 54 00 	movl   $0x54c4,0x4(%esp)
     af6:	00 
     af7:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     afe:	89 74 24 08          	mov    %esi,0x8(%esp)
     b02:	e8 e9 35 00 00       	call   40f0 <printf>
        exit(0);
     b07:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     b0e:	e8 95 34 00 00       	call   3fa8 <exit>
      } else if((i >= 1 && i < N/2) && fd >= 0){
     b13:	83 7d bc 08          	cmpl   $0x8,-0x44(%ebp)
     b17:	76 0d                	jbe    b26 <createdelete+0x206>
        printf(1, "oops createdelete %s did exist\n", name);
        exit(0);
      }
      if(fd >= 0)
        close(fd);
     b19:	89 04 24             	mov    %eax,(%esp)
     b1c:	e8 af 34 00 00       	call   3fd0 <close>
     b21:	e9 d0 fe ff ff       	jmp    9f6 <createdelete+0xd6>
     b26:	8b 75 c0             	mov    -0x40(%ebp),%esi
      fd = open(name, 0);
      if((i == 0 || i >= N/2) && fd < 0){
        printf(1, "oops createdelete %s didn't exist\n", name);
        exit(0);
      } else if((i >= 1 && i < N/2) && fd >= 0){
        printf(1, "oops createdelete %s did exist\n", name);
     b29:	c7 44 24 04 e8 54 00 	movl   $0x54e8,0x4(%esp)
     b30:	00 
     b31:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     b38:	89 74 24 08          	mov    %esi,0x8(%esp)
     b3c:	e8 af 35 00 00       	call   40f0 <printf>
        exit(0);
     b41:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     b48:	e8 5b 34 00 00       	call   3fa8 <exit>
  printf(1, "createdelete test\n");

  for(pi = 0; pi < 4; pi++){
    pid = fork();
    if(pid < 0){
      printf(1, "fork failed\n");
     b4d:	c7 44 24 04 cf 48 00 	movl   $0x48cf,0x4(%esp)
     b54:	00 
     b55:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     b5c:	e8 8f 35 00 00       	call   40f0 <printf>
      exit(0);
     b61:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     b68:	e8 3b 34 00 00       	call   3fa8 <exit>
      name[2] = '\0';
      for(i = 0; i < N; i++){
        name[1] = '0' + i;
        fd = open(name, O_CREATE | O_RDWR);
        if(fd < 0){
          printf(1, "create failed\n");
     b6d:	c7 44 24 04 65 49 00 	movl   $0x4965,0x4(%esp)
     b74:	00 
     b75:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     b7c:	e8 6f 35 00 00       	call   40f0 <printf>
          exit(0);
     b81:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     b88:	e8 1b 34 00 00       	call   3fa8 <exit>
     b8d:	8d 76 00             	lea    0x0(%esi),%esi

00000b90 <createtest>:
  printf(stdout, "big files ok\n");
}

void
createtest(void)
{
     b90:	55                   	push   %ebp
     b91:	89 e5                	mov    %esp,%ebp
     b93:	53                   	push   %ebx
  int i, fd;

  printf(stdout, "many creates, followed by unlink test\n");

  name[0] = 'a';
  name[2] = '\0';
     b94:	bb 30 00 00 00       	mov    $0x30,%ebx
  printf(stdout, "big files ok\n");
}

void
createtest(void)
{
     b99:	83 ec 14             	sub    $0x14,%esp
  int i, fd;

  printf(stdout, "many creates, followed by unlink test\n");
     b9c:	a1 1c 5c 00 00       	mov    0x5c1c,%eax
     ba1:	c7 44 24 04 08 55 00 	movl   $0x5508,0x4(%esp)
     ba8:	00 
     ba9:	89 04 24             	mov    %eax,(%esp)
     bac:	e8 3f 35 00 00       	call   40f0 <printf>

  name[0] = 'a';
     bb1:	c6 05 00 a4 00 00 61 	movb   $0x61,0xa400
  name[2] = '\0';
     bb8:	c6 05 02 a4 00 00 00 	movb   $0x0,0xa402
     bbf:	90                   	nop
  for(i = 0; i < 52; i++){
    name[1] = '0' + i;
     bc0:	88 1d 01 a4 00 00    	mov    %bl,0xa401
    fd = open(name, O_CREATE|O_RDWR);
    close(fd);
     bc6:	83 c3 01             	add    $0x1,%ebx

  name[0] = 'a';
  name[2] = '\0';
  for(i = 0; i < 52; i++){
    name[1] = '0' + i;
    fd = open(name, O_CREATE|O_RDWR);
     bc9:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
     bd0:	00 
     bd1:	c7 04 24 00 a4 00 00 	movl   $0xa400,(%esp)
     bd8:	e8 0b 34 00 00       	call   3fe8 <open>
    close(fd);
     bdd:	89 04 24             	mov    %eax,(%esp)
     be0:	e8 eb 33 00 00       	call   3fd0 <close>

  printf(stdout, "many creates, followed by unlink test\n");

  name[0] = 'a';
  name[2] = '\0';
  for(i = 0; i < 52; i++){
     be5:	80 fb 64             	cmp    $0x64,%bl
     be8:	75 d6                	jne    bc0 <createtest+0x30>
    name[1] = '0' + i;
    fd = open(name, O_CREATE|O_RDWR);
    close(fd);
  }
  name[0] = 'a';
     bea:	c6 05 00 a4 00 00 61 	movb   $0x61,0xa400
  name[2] = '\0';
     bf1:	bb 30 00 00 00       	mov    $0x30,%ebx
     bf6:	c6 05 02 a4 00 00 00 	movb   $0x0,0xa402
     bfd:	8d 76 00             	lea    0x0(%esi),%esi
  for(i = 0; i < 52; i++){
    name[1] = '0' + i;
     c00:	88 1d 01 a4 00 00    	mov    %bl,0xa401
    unlink(name);
     c06:	83 c3 01             	add    $0x1,%ebx
     c09:	c7 04 24 00 a4 00 00 	movl   $0xa400,(%esp)
     c10:	e8 e3 33 00 00       	call   3ff8 <unlink>
    fd = open(name, O_CREATE|O_RDWR);
    close(fd);
  }
  name[0] = 'a';
  name[2] = '\0';
  for(i = 0; i < 52; i++){
     c15:	80 fb 64             	cmp    $0x64,%bl
     c18:	75 e6                	jne    c00 <createtest+0x70>
    name[1] = '0' + i;
    unlink(name);
  }
  printf(stdout, "many creates, followed by unlink; ok\n");
     c1a:	a1 1c 5c 00 00       	mov    0x5c1c,%eax
     c1f:	c7 44 24 04 30 55 00 	movl   $0x5530,0x4(%esp)
     c26:	00 
     c27:	89 04 24             	mov    %eax,(%esp)
     c2a:	e8 c1 34 00 00       	call   40f0 <printf>
}
     c2f:	83 c4 14             	add    $0x14,%esp
     c32:	5b                   	pop    %ebx
     c33:	5d                   	pop    %ebp
     c34:	c3                   	ret    
     c35:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     c39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000c40 <writetest1>:
  printf(stdout, "small file test ok\n");
}

void
writetest1(void)
{
     c40:	55                   	push   %ebp
     c41:	89 e5                	mov    %esp,%ebp
     c43:	56                   	push   %esi
     c44:	53                   	push   %ebx
     c45:	83 ec 10             	sub    $0x10,%esp
  int i, fd, n;

  printf(stdout, "big files test\n");
     c48:	a1 1c 5c 00 00       	mov    0x5c1c,%eax
     c4d:	c7 44 24 04 0e 47 00 	movl   $0x470e,0x4(%esp)
     c54:	00 
     c55:	89 04 24             	mov    %eax,(%esp)
     c58:	e8 93 34 00 00       	call   40f0 <printf>

  fd = open("big", O_CREATE|O_RDWR);
     c5d:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
     c64:	00 
     c65:	c7 04 24 88 47 00 00 	movl   $0x4788,(%esp)
     c6c:	e8 77 33 00 00       	call   3fe8 <open>
  if(fd < 0){
     c71:	85 c0                	test   %eax,%eax
{
  int i, fd, n;

  printf(stdout, "big files test\n");

  fd = open("big", O_CREATE|O_RDWR);
     c73:	89 c6                	mov    %eax,%esi
  if(fd < 0){
     c75:	0f 88 6f 01 00 00    	js     dea <writetest1+0x1aa>
    printf(stdout, "error: creat big failed!\n");
    exit(0);
     c7b:	31 db                	xor    %ebx,%ebx
     c7d:	8d 76 00             	lea    0x0(%esi),%esi
  }

  for(i = 0; i < MAXFILE; i++){
    ((int*)buf)[0] = i;
     c80:	89 1d 00 84 00 00    	mov    %ebx,0x8400
    if(write(fd, buf, 512) != 512){
     c86:	c7 44 24 08 00 02 00 	movl   $0x200,0x8(%esp)
     c8d:	00 
     c8e:	c7 44 24 04 00 84 00 	movl   $0x8400,0x4(%esp)
     c95:	00 
     c96:	89 34 24             	mov    %esi,(%esp)
     c99:	e8 2a 33 00 00       	call   3fc8 <write>
     c9e:	3d 00 02 00 00       	cmp    $0x200,%eax
     ca3:	0f 85 b2 00 00 00    	jne    d5b <writetest1+0x11b>
  if(fd < 0){
    printf(stdout, "error: creat big failed!\n");
    exit(0);
  }

  for(i = 0; i < MAXFILE; i++){
     ca9:	83 c3 01             	add    $0x1,%ebx
     cac:	81 fb 8c 00 00 00    	cmp    $0x8c,%ebx
     cb2:	75 cc                	jne    c80 <writetest1+0x40>
      printf(stdout, "error: write big file failed\n", i);
      exit(0);
    }
  }

  close(fd);
     cb4:	89 34 24             	mov    %esi,(%esp)
     cb7:	e8 14 33 00 00       	call   3fd0 <close>

  fd = open("big", O_RDONLY);
     cbc:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
     cc3:	00 
     cc4:	c7 04 24 88 47 00 00 	movl   $0x4788,(%esp)
     ccb:	e8 18 33 00 00       	call   3fe8 <open>
  if(fd < 0){
     cd0:	85 c0                	test   %eax,%eax
    }
  }

  close(fd);

  fd = open("big", O_RDONLY);
     cd2:	89 c6                	mov    %eax,%esi
  if(fd < 0){
     cd4:	0f 88 ef 00 00 00    	js     dc9 <writetest1+0x189>
    printf(stdout, "error: open big failed!\n");
    exit(0);
     cda:	31 db                	xor    %ebx,%ebx
     cdc:	eb 1d                	jmp    cfb <writetest1+0xbb>
     cde:	66 90                	xchg   %ax,%ax
      if(n == MAXFILE - 1){
        printf(stdout, "read only %d blocks from big", n);
        exit(0);
      }
      break;
    } else if(i != 512){
     ce0:	3d 00 02 00 00       	cmp    $0x200,%eax
     ce5:	0f 85 be 00 00 00    	jne    da9 <writetest1+0x169>
      printf(stdout, "read failed %d\n", i);
      exit(0);
    }
    if(((int*)buf)[0] != n){
     ceb:	a1 00 84 00 00       	mov    0x8400,%eax
     cf0:	39 d8                	cmp    %ebx,%eax
     cf2:	0f 85 88 00 00 00    	jne    d80 <writetest1+0x140>
      printf(stdout, "read content of block %d is %d\n",
             n, ((int*)buf)[0]);
      exit(0);
    }
    n++;
     cf8:	83 c3 01             	add    $0x1,%ebx
    exit(0);
  }

  n = 0;
  for(;;){
    i = read(fd, buf, 512);
     cfb:	c7 44 24 08 00 02 00 	movl   $0x200,0x8(%esp)
     d02:	00 
     d03:	c7 44 24 04 00 84 00 	movl   $0x8400,0x4(%esp)
     d0a:	00 
     d0b:	89 34 24             	mov    %esi,(%esp)
     d0e:	e8 ad 32 00 00       	call   3fc0 <read>
    if(i == 0){
     d13:	85 c0                	test   %eax,%eax
     d15:	75 c9                	jne    ce0 <writetest1+0xa0>
      if(n == MAXFILE - 1){
     d17:	81 fb 8b 00 00 00    	cmp    $0x8b,%ebx
     d1d:	0f 84 94 00 00 00    	je     db7 <writetest1+0x177>
             n, ((int*)buf)[0]);
      exit(0);
    }
    n++;
  }
  close(fd);
     d23:	89 34 24             	mov    %esi,(%esp)
     d26:	e8 a5 32 00 00       	call   3fd0 <close>
  if(unlink("big") < 0){
     d2b:	c7 04 24 88 47 00 00 	movl   $0x4788,(%esp)
     d32:	e8 c1 32 00 00       	call   3ff8 <unlink>
     d37:	85 c0                	test   %eax,%eax
     d39:	0f 88 b5 00 00 00    	js     df4 <writetest1+0x1b4>
    printf(stdout, "unlink big failed\n");
    exit(0);
  }
  printf(stdout, "big files ok\n");
     d3f:	a1 1c 5c 00 00       	mov    0x5c1c,%eax
     d44:	c7 44 24 04 af 47 00 	movl   $0x47af,0x4(%esp)
     d4b:	00 
     d4c:	89 04 24             	mov    %eax,(%esp)
     d4f:	e8 9c 33 00 00       	call   40f0 <printf>
}
     d54:	83 c4 10             	add    $0x10,%esp
     d57:	5b                   	pop    %ebx
     d58:	5e                   	pop    %esi
     d59:	5d                   	pop    %ebp
     d5a:	c3                   	ret    
  }

  for(i = 0; i < MAXFILE; i++){
    ((int*)buf)[0] = i;
    if(write(fd, buf, 512) != 512){
      printf(stdout, "error: write big file failed\n", i);
     d5b:	89 5c 24 08          	mov    %ebx,0x8(%esp)
     d5f:	c7 44 24 04 38 47 00 	movl   $0x4738,0x4(%esp)
     d66:	00 
  n = 0;
  for(;;){
    i = read(fd, buf, 512);
    if(i == 0){
      if(n == MAXFILE - 1){
        printf(stdout, "read only %d blocks from big", n);
     d67:	a1 1c 5c 00 00       	mov    0x5c1c,%eax
     d6c:	89 04 24             	mov    %eax,(%esp)
     d6f:	e8 7c 33 00 00       	call   40f0 <printf>
        exit(0);
     d74:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     d7b:	e8 28 32 00 00       	call   3fa8 <exit>
    } else if(i != 512){
      printf(stdout, "read failed %d\n", i);
      exit(0);
    }
    if(((int*)buf)[0] != n){
      printf(stdout, "read content of block %d is %d\n",
     d80:	89 44 24 0c          	mov    %eax,0xc(%esp)
     d84:	a1 1c 5c 00 00       	mov    0x5c1c,%eax
     d89:	89 5c 24 08          	mov    %ebx,0x8(%esp)
     d8d:	c7 44 24 04 58 55 00 	movl   $0x5558,0x4(%esp)
     d94:	00 
     d95:	89 04 24             	mov    %eax,(%esp)
     d98:	e8 53 33 00 00       	call   40f0 <printf>
             n, ((int*)buf)[0]);
      exit(0);
     d9d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     da4:	e8 ff 31 00 00       	call   3fa8 <exit>
        printf(stdout, "read only %d blocks from big", n);
        exit(0);
      }
      break;
    } else if(i != 512){
      printf(stdout, "read failed %d\n", i);
     da9:	89 44 24 08          	mov    %eax,0x8(%esp)
     dad:	c7 44 24 04 8c 47 00 	movl   $0x478c,0x4(%esp)
     db4:	00 
     db5:	eb b0                	jmp    d67 <writetest1+0x127>
  n = 0;
  for(;;){
    i = read(fd, buf, 512);
    if(i == 0){
      if(n == MAXFILE - 1){
        printf(stdout, "read only %d blocks from big", n);
     db7:	c7 44 24 08 8b 00 00 	movl   $0x8b,0x8(%esp)
     dbe:	00 
     dbf:	c7 44 24 04 6f 47 00 	movl   $0x476f,0x4(%esp)
     dc6:	00 
     dc7:	eb 9e                	jmp    d67 <writetest1+0x127>

  close(fd);

  fd = open("big", O_RDONLY);
  if(fd < 0){
    printf(stdout, "error: open big failed!\n");
     dc9:	c7 44 24 04 56 47 00 	movl   $0x4756,0x4(%esp)
     dd0:	00 
     dd1:	a1 1c 5c 00 00       	mov    0x5c1c,%eax
     dd6:	89 04 24             	mov    %eax,(%esp)
     dd9:	e8 12 33 00 00       	call   40f0 <printf>
    exit(0);
     dde:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     de5:	e8 be 31 00 00       	call   3fa8 <exit>

  printf(stdout, "big files test\n");

  fd = open("big", O_CREATE|O_RDWR);
  if(fd < 0){
    printf(stdout, "error: creat big failed!\n");
     dea:	c7 44 24 04 1e 47 00 	movl   $0x471e,0x4(%esp)
     df1:	00 
     df2:	eb dd                	jmp    dd1 <writetest1+0x191>
    }
    n++;
  }
  close(fd);
  if(unlink("big") < 0){
    printf(stdout, "unlink big failed\n");
     df4:	c7 44 24 04 9c 47 00 	movl   $0x479c,0x4(%esp)
     dfb:	00 
     dfc:	eb d3                	jmp    dd1 <writetest1+0x191>
     dfe:	66 90                	xchg   %ax,%ax

00000e00 <writetest>:
  printf(stdout, "open test ok\n");
}

void
writetest(void)
{
     e00:	55                   	push   %ebp
     e01:	89 e5                	mov    %esp,%ebp
     e03:	56                   	push   %esi
     e04:	53                   	push   %ebx
     e05:	83 ec 10             	sub    $0x10,%esp
  int fd;
  int i;

  printf(stdout, "small file test\n");
     e08:	a1 1c 5c 00 00       	mov    0x5c1c,%eax
     e0d:	c7 44 24 04 bd 47 00 	movl   $0x47bd,0x4(%esp)
     e14:	00 
     e15:	89 04 24             	mov    %eax,(%esp)
     e18:	e8 d3 32 00 00       	call   40f0 <printf>
  fd = open("small", O_CREATE|O_RDWR);
     e1d:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
     e24:	00 
     e25:	c7 04 24 ce 47 00 00 	movl   $0x47ce,(%esp)
     e2c:	e8 b7 31 00 00       	call   3fe8 <open>
  if(fd >= 0){
     e31:	85 c0                	test   %eax,%eax
{
  int fd;
  int i;

  printf(stdout, "small file test\n");
  fd = open("small", O_CREATE|O_RDWR);
     e33:	89 c6                	mov    %eax,%esi
  if(fd >= 0){
     e35:	0f 88 8b 01 00 00    	js     fc6 <writetest+0x1c6>
    printf(stdout, "creat small succeeded; ok\n");
     e3b:	a1 1c 5c 00 00       	mov    0x5c1c,%eax
     e40:	31 db                	xor    %ebx,%ebx
     e42:	c7 44 24 04 d4 47 00 	movl   $0x47d4,0x4(%esp)
     e49:	00 
     e4a:	89 04 24             	mov    %eax,(%esp)
     e4d:	e8 9e 32 00 00       	call   40f0 <printf>
     e52:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  } else {
    printf(stdout, "error: creat small failed!\n");
    exit(0);
  }
  for(i = 0; i < 100; i++){
    if(write(fd, "aaaaaaaaaa", 10) != 10){
     e58:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
     e5f:	00 
     e60:	c7 44 24 04 0b 48 00 	movl   $0x480b,0x4(%esp)
     e67:	00 
     e68:	89 34 24             	mov    %esi,(%esp)
     e6b:	e8 58 31 00 00       	call   3fc8 <write>
     e70:	83 f8 0a             	cmp    $0xa,%eax
     e73:	0f 85 e5 00 00 00    	jne    f5e <writetest+0x15e>
      printf(stdout, "error: write aa %d new file failed\n", i);
      exit(0);
    }
    if(write(fd, "bbbbbbbbbb", 10) != 10){
     e79:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
     e80:	00 
     e81:	c7 44 24 04 16 48 00 	movl   $0x4816,0x4(%esp)
     e88:	00 
     e89:	89 34 24             	mov    %esi,(%esp)
     e8c:	e8 37 31 00 00       	call   3fc8 <write>
     e91:	83 f8 0a             	cmp    $0xa,%eax
     e94:	0f 85 e9 00 00 00    	jne    f83 <writetest+0x183>
    printf(stdout, "creat small succeeded; ok\n");
  } else {
    printf(stdout, "error: creat small failed!\n");
    exit(0);
  }
  for(i = 0; i < 100; i++){
     e9a:	83 c3 01             	add    $0x1,%ebx
     e9d:	83 fb 64             	cmp    $0x64,%ebx
     ea0:	75 b6                	jne    e58 <writetest+0x58>
    if(write(fd, "bbbbbbbbbb", 10) != 10){
      printf(stdout, "error: write bb %d new file failed\n", i);
      exit(0);
    }
  }
  printf(stdout, "writes ok\n");
     ea2:	a1 1c 5c 00 00       	mov    0x5c1c,%eax
     ea7:	c7 44 24 04 21 48 00 	movl   $0x4821,0x4(%esp)
     eae:	00 
     eaf:	89 04 24             	mov    %eax,(%esp)
     eb2:	e8 39 32 00 00       	call   40f0 <printf>
  close(fd);
     eb7:	89 34 24             	mov    %esi,(%esp)
     eba:	e8 11 31 00 00       	call   3fd0 <close>
  fd = open("small", O_RDONLY);
     ebf:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
     ec6:	00 
     ec7:	c7 04 24 ce 47 00 00 	movl   $0x47ce,(%esp)
     ece:	e8 15 31 00 00       	call   3fe8 <open>
  if(fd >= 0){
     ed3:	85 c0                	test   %eax,%eax
      exit(0);
    }
  }
  printf(stdout, "writes ok\n");
  close(fd);
  fd = open("small", O_RDONLY);
     ed5:	89 c3                	mov    %eax,%ebx
  if(fd >= 0){
     ed7:	0f 88 b4 00 00 00    	js     f91 <writetest+0x191>
    printf(stdout, "open small succeeded ok\n");
     edd:	a1 1c 5c 00 00       	mov    0x5c1c,%eax
     ee2:	c7 44 24 04 2c 48 00 	movl   $0x482c,0x4(%esp)
     ee9:	00 
     eea:	89 04 24             	mov    %eax,(%esp)
     eed:	e8 fe 31 00 00       	call   40f0 <printf>
  } else {
    printf(stdout, "error: open small failed!\n");
    exit(0);
  }
  i = read(fd, buf, 2000);
     ef2:	c7 44 24 08 d0 07 00 	movl   $0x7d0,0x8(%esp)
     ef9:	00 
     efa:	c7 44 24 04 00 84 00 	movl   $0x8400,0x4(%esp)
     f01:	00 
     f02:	89 1c 24             	mov    %ebx,(%esp)
     f05:	e8 b6 30 00 00       	call   3fc0 <read>
  if(i == 2000){
     f0a:	3d d0 07 00 00       	cmp    $0x7d0,%eax
     f0f:	0f 85 9d 00 00 00    	jne    fb2 <writetest+0x1b2>
    printf(stdout, "read succeeded ok\n");
     f15:	a1 1c 5c 00 00       	mov    0x5c1c,%eax
     f1a:	c7 44 24 04 60 48 00 	movl   $0x4860,0x4(%esp)
     f21:	00 
     f22:	89 04 24             	mov    %eax,(%esp)
     f25:	e8 c6 31 00 00       	call   40f0 <printf>
  } else {
    printf(stdout, "read failed\n");
    exit(0);
  }
  close(fd);
     f2a:	89 1c 24             	mov    %ebx,(%esp)
     f2d:	e8 9e 30 00 00       	call   3fd0 <close>

  if(unlink("small") < 0){
     f32:	c7 04 24 ce 47 00 00 	movl   $0x47ce,(%esp)
     f39:	e8 ba 30 00 00       	call   3ff8 <unlink>
     f3e:	85 c0                	test   %eax,%eax
     f40:	78 7a                	js     fbc <writetest+0x1bc>
    printf(stdout, "unlink small failed\n");
    exit(0);
  }
  printf(stdout, "small file test ok\n");
     f42:	a1 1c 5c 00 00       	mov    0x5c1c,%eax
     f47:	c7 44 24 04 88 48 00 	movl   $0x4888,0x4(%esp)
     f4e:	00 
     f4f:	89 04 24             	mov    %eax,(%esp)
     f52:	e8 99 31 00 00       	call   40f0 <printf>
}
     f57:	83 c4 10             	add    $0x10,%esp
     f5a:	5b                   	pop    %ebx
     f5b:	5e                   	pop    %esi
     f5c:	5d                   	pop    %ebp
     f5d:	c3                   	ret    
    printf(stdout, "error: creat small failed!\n");
    exit(0);
  }
  for(i = 0; i < 100; i++){
    if(write(fd, "aaaaaaaaaa", 10) != 10){
      printf(stdout, "error: write aa %d new file failed\n", i);
     f5e:	89 5c 24 08          	mov    %ebx,0x8(%esp)
     f62:	c7 44 24 04 78 55 00 	movl   $0x5578,0x4(%esp)
     f69:	00 
      exit(0);
    }
    if(write(fd, "bbbbbbbbbb", 10) != 10){
      printf(stdout, "error: write bb %d new file failed\n", i);
     f6a:	a1 1c 5c 00 00       	mov    0x5c1c,%eax
     f6f:	89 04 24             	mov    %eax,(%esp)
     f72:	e8 79 31 00 00       	call   40f0 <printf>
      exit(0);
     f77:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     f7e:	e8 25 30 00 00       	call   3fa8 <exit>
    if(write(fd, "aaaaaaaaaa", 10) != 10){
      printf(stdout, "error: write aa %d new file failed\n", i);
      exit(0);
    }
    if(write(fd, "bbbbbbbbbb", 10) != 10){
      printf(stdout, "error: write bb %d new file failed\n", i);
     f83:	89 5c 24 08          	mov    %ebx,0x8(%esp)
     f87:	c7 44 24 04 9c 55 00 	movl   $0x559c,0x4(%esp)
     f8e:	00 
     f8f:	eb d9                	jmp    f6a <writetest+0x16a>
  close(fd);
  fd = open("small", O_RDONLY);
  if(fd >= 0){
    printf(stdout, "open small succeeded ok\n");
  } else {
    printf(stdout, "error: open small failed!\n");
     f91:	c7 44 24 04 45 48 00 	movl   $0x4845,0x4(%esp)
     f98:	00 
     f99:	a1 1c 5c 00 00       	mov    0x5c1c,%eax
     f9e:	89 04 24             	mov    %eax,(%esp)
     fa1:	e8 4a 31 00 00       	call   40f0 <printf>
    exit(0);
     fa6:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     fad:	e8 f6 2f 00 00       	call   3fa8 <exit>
  }
  i = read(fd, buf, 2000);
  if(i == 2000){
    printf(stdout, "read succeeded ok\n");
  } else {
    printf(stdout, "read failed\n");
     fb2:	c7 44 24 04 3c 46 00 	movl   $0x463c,0x4(%esp)
     fb9:	00 
     fba:	eb dd                	jmp    f99 <writetest+0x199>
    exit(0);
  }
  close(fd);

  if(unlink("small") < 0){
    printf(stdout, "unlink small failed\n");
     fbc:	c7 44 24 04 73 48 00 	movl   $0x4873,0x4(%esp)
     fc3:	00 
     fc4:	eb d3                	jmp    f99 <writetest+0x199>
  printf(stdout, "small file test\n");
  fd = open("small", O_CREATE|O_RDWR);
  if(fd >= 0){
    printf(stdout, "creat small succeeded; ok\n");
  } else {
    printf(stdout, "error: creat small failed!\n");
     fc6:	c7 44 24 04 ef 47 00 	movl   $0x47ef,0x4(%esp)
     fcd:	00 
     fce:	eb c9                	jmp    f99 <writetest+0x199>

00000fd0 <bigargtest>:
// does exec return an error if the arguments
// are larger than a page? or does it write
// below the stack and wreck the instructions/data?
void
bigargtest(void)
{
     fd0:	55                   	push   %ebp
     fd1:	89 e5                	mov    %esp,%ebp
     fd3:	83 ec 18             	sub    $0x18,%esp
  int pid, fd;

  unlink("bigarg-ok");
     fd6:	c7 04 24 9c 48 00 00 	movl   $0x489c,(%esp)
     fdd:	e8 16 30 00 00       	call   3ff8 <unlink>
  pid = fork();
     fe2:	e8 b9 2f 00 00       	call   3fa0 <fork>
  if(pid == 0){
     fe7:	83 f8 00             	cmp    $0x0,%eax
     fea:	74 4c                	je     1038 <bigargtest+0x68>
     fec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    exec("echo", args);
    printf(stdout, "bigarg test ok\n");
    fd = open("bigarg-ok", O_CREATE);
    close(fd);
    exit(0);
  } else if(pid < 0){
     ff0:	0f 8c e6 00 00 00    	jl     10dc <bigargtest+0x10c>
    printf(stdout, "bigargtest: fork failed\n");
    exit(0);
  }
  wait(0);
     ff6:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     ffd:	e8 ae 2f 00 00       	call   3fb0 <wait>
  fd = open("bigarg-ok", 0);
    1002:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1009:	00 
    100a:	c7 04 24 9c 48 00 00 	movl   $0x489c,(%esp)
    1011:	e8 d2 2f 00 00       	call   3fe8 <open>
  if(fd < 0){
    1016:	85 c0                	test   %eax,%eax
    1018:	0f 88 9d 00 00 00    	js     10bb <bigargtest+0xeb>
    printf(stdout, "bigarg test failed!\n");
    exit(0);
  }
  close(fd);
    101e:	89 04 24             	mov    %eax,(%esp)
    1021:	e8 aa 2f 00 00       	call   3fd0 <close>
  unlink("bigarg-ok");
    1026:	c7 04 24 9c 48 00 00 	movl   $0x489c,(%esp)
    102d:	e8 c6 2f 00 00       	call   3ff8 <unlink>
}
    1032:	c9                   	leave  
    1033:	c3                   	ret    
    1034:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  pid = fork();
  if(pid == 0){
    static char *args[MAXARG];
    int i;
    for(i = 0; i < MAXARG-1; i++)
      args[i] = "bigargs test: failed\n                                                                                                                                                                                                       ";
    1038:	c7 04 85 40 5c 00 00 	movl   $0x55c0,0x5c40(,%eax,4)
    103f:	c0 55 00 00 
  unlink("bigarg-ok");
  pid = fork();
  if(pid == 0){
    static char *args[MAXARG];
    int i;
    for(i = 0; i < MAXARG-1; i++)
    1043:	83 c0 01             	add    $0x1,%eax
    1046:	83 f8 1f             	cmp    $0x1f,%eax
    1049:	75 ed                	jne    1038 <bigargtest+0x68>
      args[i] = "bigargs test: failed\n                                                                                                                                                                                                       ";
    args[MAXARG-1] = 0;
    printf(stdout, "bigarg test\n");
    104b:	a1 1c 5c 00 00       	mov    0x5c1c,%eax
  if(pid == 0){
    static char *args[MAXARG];
    int i;
    for(i = 0; i < MAXARG-1; i++)
      args[i] = "bigargs test: failed\n                                                                                                                                                                                                       ";
    args[MAXARG-1] = 0;
    1050:	c7 05 bc 5c 00 00 00 	movl   $0x0,0x5cbc
    1057:	00 00 00 
    printf(stdout, "bigarg test\n");
    105a:	c7 44 24 04 a6 48 00 	movl   $0x48a6,0x4(%esp)
    1061:	00 
    1062:	89 04 24             	mov    %eax,(%esp)
    1065:	e8 86 30 00 00       	call   40f0 <printf>
    exec("echo", args);
    106a:	c7 44 24 04 40 5c 00 	movl   $0x5c40,0x4(%esp)
    1071:	00 
    1072:	c7 04 24 8b 44 00 00 	movl   $0x448b,(%esp)
    1079:	e8 62 2f 00 00       	call   3fe0 <exec>
    printf(stdout, "bigarg test ok\n");
    107e:	a1 1c 5c 00 00       	mov    0x5c1c,%eax
    1083:	c7 44 24 04 b3 48 00 	movl   $0x48b3,0x4(%esp)
    108a:	00 
    108b:	89 04 24             	mov    %eax,(%esp)
    108e:	e8 5d 30 00 00       	call   40f0 <printf>
    fd = open("bigarg-ok", O_CREATE);
    1093:	c7 44 24 04 00 02 00 	movl   $0x200,0x4(%esp)
    109a:	00 
    109b:	c7 04 24 9c 48 00 00 	movl   $0x489c,(%esp)
    10a2:	e8 41 2f 00 00       	call   3fe8 <open>
    close(fd);
    10a7:	89 04 24             	mov    %eax,(%esp)
    10aa:	e8 21 2f 00 00       	call   3fd0 <close>
    exit(0);
    10af:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    10b6:	e8 ed 2e 00 00       	call   3fa8 <exit>
    exit(0);
  }
  wait(0);
  fd = open("bigarg-ok", 0);
  if(fd < 0){
    printf(stdout, "bigarg test failed!\n");
    10bb:	c7 44 24 04 dc 48 00 	movl   $0x48dc,0x4(%esp)
    10c2:	00 
    10c3:	a1 1c 5c 00 00       	mov    0x5c1c,%eax
    10c8:	89 04 24             	mov    %eax,(%esp)
    10cb:	e8 20 30 00 00       	call   40f0 <printf>
    exit(0);
    10d0:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    10d7:	e8 cc 2e 00 00       	call   3fa8 <exit>
    printf(stdout, "bigarg test ok\n");
    fd = open("bigarg-ok", O_CREATE);
    close(fd);
    exit(0);
  } else if(pid < 0){
    printf(stdout, "bigargtest: fork failed\n");
    10dc:	c7 44 24 04 c3 48 00 	movl   $0x48c3,0x4(%esp)
    10e3:	00 
    10e4:	eb dd                	jmp    10c3 <bigargtest+0xf3>
    10e6:	8d 76 00             	lea    0x0(%esi),%esi
    10e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000010f0 <exectest>:
  printf(stdout, "mkdir test ok\n");
}

void
exectest(void)
{
    10f0:	55                   	push   %ebp
    10f1:	89 e5                	mov    %esp,%ebp
    10f3:	83 ec 18             	sub    $0x18,%esp
  printf(stdout, "exec test\n");
    10f6:	a1 1c 5c 00 00       	mov    0x5c1c,%eax
    10fb:	c7 44 24 04 f1 48 00 	movl   $0x48f1,0x4(%esp)
    1102:	00 
    1103:	89 04 24             	mov    %eax,(%esp)
    1106:	e8 e5 2f 00 00       	call   40f0 <printf>
  if(exec("echo", echoargv) < 0){
    110b:	c7 44 24 04 08 5c 00 	movl   $0x5c08,0x4(%esp)
    1112:	00 
    1113:	c7 04 24 8b 44 00 00 	movl   $0x448b,(%esp)
    111a:	e8 c1 2e 00 00       	call   3fe0 <exec>
    111f:	85 c0                	test   %eax,%eax
    1121:	78 02                	js     1125 <exectest+0x35>
    printf(stdout, "exec echo failed\n");
    exit(0);
  }
}
    1123:	c9                   	leave  
    1124:	c3                   	ret    
void
exectest(void)
{
  printf(stdout, "exec test\n");
  if(exec("echo", echoargv) < 0){
    printf(stdout, "exec echo failed\n");
    1125:	a1 1c 5c 00 00       	mov    0x5c1c,%eax
    112a:	c7 44 24 04 fc 48 00 	movl   $0x48fc,0x4(%esp)
    1131:	00 
    1132:	89 04 24             	mov    %eax,(%esp)
    1135:	e8 b6 2f 00 00       	call   40f0 <printf>
    exit(0);
    113a:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1141:	e8 62 2e 00 00       	call   3fa8 <exit>
    1146:	8d 76 00             	lea    0x0(%esi),%esi
    1149:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001150 <validatetest>:
      "ebx");
}

void
validatetest(void)
{
    1150:	55                   	push   %ebp
    1151:	89 e5                	mov    %esp,%ebp
    1153:	56                   	push   %esi
    1154:	53                   	push   %ebx
  int hi, pid;
  uint p;

  printf(stdout, "validate test\n");
    1155:	31 db                	xor    %ebx,%ebx
      "ebx");
}

void
validatetest(void)
{
    1157:	83 ec 10             	sub    $0x10,%esp
  int hi, pid;
  uint p;

  printf(stdout, "validate test\n");
    115a:	a1 1c 5c 00 00       	mov    0x5c1c,%eax
    115f:	c7 44 24 04 0e 49 00 	movl   $0x490e,0x4(%esp)
    1166:	00 
    1167:	89 04 24             	mov    %eax,(%esp)
    116a:	e8 81 2f 00 00       	call   40f0 <printf>
    116f:	90                   	nop
  hi = 1100*1024;

  for(p = 0; p <= (uint)hi; p += 4096){
    if((pid = fork()) == 0){
    1170:	e8 2b 2e 00 00       	call   3fa0 <fork>
    1175:	85 c0                	test   %eax,%eax
    1177:	89 c6                	mov    %eax,%esi
    1179:	0f 84 80 00 00 00    	je     11ff <validatetest+0xaf>
      // try to crash the kernel by passing in a badly placed integer
      validateint((int*)p);
      exit(0);
    }
    sleep(0);
    117f:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1186:	e8 ad 2e 00 00       	call   4038 <sleep>
    sleep(0);
    118b:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1192:	e8 a1 2e 00 00       	call   4038 <sleep>
    kill(pid);
    1197:	89 34 24             	mov    %esi,(%esp)
    119a:	e8 39 2e 00 00       	call   3fd8 <kill>
    wait(0);
    119f:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    11a6:	e8 05 2e 00 00       	call   3fb0 <wait>

    // try to crash the kernel by passing in a bad string pointer
    if(link("nosuchfile", (char*)p) != -1){
    11ab:	89 5c 24 04          	mov    %ebx,0x4(%esp)
    11af:	c7 04 24 1d 49 00 00 	movl   $0x491d,(%esp)
    11b6:	e8 4d 2e 00 00       	call   4008 <link>
    11bb:	83 f8 ff             	cmp    $0xffffffff,%eax
    11be:	75 2a                	jne    11ea <validatetest+0x9a>
  uint p;

  printf(stdout, "validate test\n");
  hi = 1100*1024;

  for(p = 0; p <= (uint)hi; p += 4096){
    11c0:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    11c6:	81 fb 00 40 11 00    	cmp    $0x114000,%ebx
    11cc:	75 a2                	jne    1170 <validatetest+0x20>
      printf(stdout, "link should not succeed\n");
      exit(0);
    }
  }

  printf(stdout, "validate ok\n");
    11ce:	a1 1c 5c 00 00       	mov    0x5c1c,%eax
    11d3:	c7 44 24 04 41 49 00 	movl   $0x4941,0x4(%esp)
    11da:	00 
    11db:	89 04 24             	mov    %eax,(%esp)
    11de:	e8 0d 2f 00 00       	call   40f0 <printf>
}
    11e3:	83 c4 10             	add    $0x10,%esp
    11e6:	5b                   	pop    %ebx
    11e7:	5e                   	pop    %esi
    11e8:	5d                   	pop    %ebp
    11e9:	c3                   	ret    
    kill(pid);
    wait(0);

    // try to crash the kernel by passing in a bad string pointer
    if(link("nosuchfile", (char*)p) != -1){
      printf(stdout, "link should not succeed\n");
    11ea:	a1 1c 5c 00 00       	mov    0x5c1c,%eax
    11ef:	c7 44 24 04 28 49 00 	movl   $0x4928,0x4(%esp)
    11f6:	00 
    11f7:	89 04 24             	mov    %eax,(%esp)
    11fa:	e8 f1 2e 00 00       	call   40f0 <printf>
      exit(0);
    11ff:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1206:	e8 9d 2d 00 00       	call   3fa8 <exit>
    120b:	90                   	nop
    120c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00001210 <bigdir>:
}

// directory that uses indirect blocks
void
bigdir(void)
{
    1210:	55                   	push   %ebp
    1211:	89 e5                	mov    %esp,%ebp
    1213:	56                   	push   %esi
    1214:	53                   	push   %ebx
    1215:	83 ec 20             	sub    $0x20,%esp
  int i, fd;
  char name[10];

  printf(1, "bigdir test\n");
    1218:	c7 44 24 04 4e 49 00 	movl   $0x494e,0x4(%esp)
    121f:	00 
    1220:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1227:	e8 c4 2e 00 00       	call   40f0 <printf>
  unlink("bd");
    122c:	c7 04 24 5b 49 00 00 	movl   $0x495b,(%esp)
    1233:	e8 c0 2d 00 00       	call   3ff8 <unlink>

  fd = open("bd", O_CREATE);
    1238:	c7 44 24 04 00 02 00 	movl   $0x200,0x4(%esp)
    123f:	00 
    1240:	c7 04 24 5b 49 00 00 	movl   $0x495b,(%esp)
    1247:	e8 9c 2d 00 00       	call   3fe8 <open>
  if(fd < 0){
    124c:	85 c0                	test   %eax,%eax
    124e:	0f 88 f4 00 00 00    	js     1348 <bigdir+0x138>
    printf(1, "bigdir create failed\n");
    exit(0);
  }
  close(fd);
    1254:	89 04 24             	mov    %eax,(%esp)
    1257:	31 db                	xor    %ebx,%ebx
    1259:	e8 72 2d 00 00       	call   3fd0 <close>
    125e:	8d 75 ee             	lea    -0x12(%ebp),%esi
    1261:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

  for(i = 0; i < 500; i++){
    name[0] = 'x';
    name[1] = '0' + (i / 64);
    1268:	89 d8                	mov    %ebx,%eax
    126a:	c1 f8 06             	sar    $0x6,%eax
    126d:	83 c0 30             	add    $0x30,%eax
    1270:	88 45 ef             	mov    %al,-0x11(%ebp)
    name[2] = '0' + (i % 64);
    1273:	89 d8                	mov    %ebx,%eax
    1275:	83 e0 3f             	and    $0x3f,%eax
    1278:	83 c0 30             	add    $0x30,%eax
    exit(0);
  }
  close(fd);

  for(i = 0; i < 500; i++){
    name[0] = 'x';
    127b:	c6 45 ee 78          	movb   $0x78,-0x12(%ebp)
    name[1] = '0' + (i / 64);
    name[2] = '0' + (i % 64);
    127f:	88 45 f0             	mov    %al,-0x10(%ebp)
    name[3] = '\0';
    1282:	c6 45 f1 00          	movb   $0x0,-0xf(%ebp)
    if(link("bd", name) != 0){
    1286:	89 74 24 04          	mov    %esi,0x4(%esp)
    128a:	c7 04 24 5b 49 00 00 	movl   $0x495b,(%esp)
    1291:	e8 72 2d 00 00       	call   4008 <link>
    1296:	85 c0                	test   %eax,%eax
    1298:	75 6e                	jne    1308 <bigdir+0xf8>
    printf(1, "bigdir create failed\n");
    exit(0);
  }
  close(fd);

  for(i = 0; i < 500; i++){
    129a:	83 c3 01             	add    $0x1,%ebx
    129d:	81 fb f4 01 00 00    	cmp    $0x1f4,%ebx
    12a3:	75 c3                	jne    1268 <bigdir+0x58>
      printf(1, "bigdir link failed\n");
      exit(0);
    }
  }

  unlink("bd");
    12a5:	c7 04 24 5b 49 00 00 	movl   $0x495b,(%esp)
    12ac:	66 31 db             	xor    %bx,%bx
    12af:	e8 44 2d 00 00       	call   3ff8 <unlink>
    12b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(i = 0; i < 500; i++){
    name[0] = 'x';
    name[1] = '0' + (i / 64);
    12b8:	89 d8                	mov    %ebx,%eax
    12ba:	c1 f8 06             	sar    $0x6,%eax
    12bd:	83 c0 30             	add    $0x30,%eax
    12c0:	88 45 ef             	mov    %al,-0x11(%ebp)
    name[2] = '0' + (i % 64);
    12c3:	89 d8                	mov    %ebx,%eax
    12c5:	83 e0 3f             	and    $0x3f,%eax
    12c8:	83 c0 30             	add    $0x30,%eax
    }
  }

  unlink("bd");
  for(i = 0; i < 500; i++){
    name[0] = 'x';
    12cb:	c6 45 ee 78          	movb   $0x78,-0x12(%ebp)
    name[1] = '0' + (i / 64);
    name[2] = '0' + (i % 64);
    12cf:	88 45 f0             	mov    %al,-0x10(%ebp)
    name[3] = '\0';
    12d2:	c6 45 f1 00          	movb   $0x0,-0xf(%ebp)
    if(unlink(name) != 0){
    12d6:	89 34 24             	mov    %esi,(%esp)
    12d9:	e8 1a 2d 00 00       	call   3ff8 <unlink>
    12de:	85 c0                	test   %eax,%eax
    12e0:	75 46                	jne    1328 <bigdir+0x118>
      exit(0);
    }
  }

  unlink("bd");
  for(i = 0; i < 500; i++){
    12e2:	83 c3 01             	add    $0x1,%ebx
    12e5:	81 fb f4 01 00 00    	cmp    $0x1f4,%ebx
    12eb:	75 cb                	jne    12b8 <bigdir+0xa8>
      printf(1, "bigdir unlink failed");
      exit(0);
    }
  }

  printf(1, "bigdir ok\n");
    12ed:	c7 44 24 04 9d 49 00 	movl   $0x499d,0x4(%esp)
    12f4:	00 
    12f5:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    12fc:	e8 ef 2d 00 00       	call   40f0 <printf>
}
    1301:	83 c4 20             	add    $0x20,%esp
    1304:	5b                   	pop    %ebx
    1305:	5e                   	pop    %esi
    1306:	5d                   	pop    %ebp
    1307:	c3                   	ret    
    name[0] = 'x';
    name[1] = '0' + (i / 64);
    name[2] = '0' + (i % 64);
    name[3] = '\0';
    if(link("bd", name) != 0){
      printf(1, "bigdir link failed\n");
    1308:	c7 44 24 04 74 49 00 	movl   $0x4974,0x4(%esp)
    130f:	00 
    1310:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1317:	e8 d4 2d 00 00       	call   40f0 <printf>
      exit(0);
    131c:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1323:	e8 80 2c 00 00       	call   3fa8 <exit>
    name[0] = 'x';
    name[1] = '0' + (i / 64);
    name[2] = '0' + (i % 64);
    name[3] = '\0';
    if(unlink(name) != 0){
      printf(1, "bigdir unlink failed");
    1328:	c7 44 24 04 88 49 00 	movl   $0x4988,0x4(%esp)
    132f:	00 
    1330:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1337:	e8 b4 2d 00 00       	call   40f0 <printf>
      exit(0);
    133c:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1343:	e8 60 2c 00 00       	call   3fa8 <exit>
  printf(1, "bigdir test\n");
  unlink("bd");

  fd = open("bd", O_CREATE);
  if(fd < 0){
    printf(1, "bigdir create failed\n");
    1348:	c7 44 24 04 5e 49 00 	movl   $0x495e,0x4(%esp)
    134f:	00 
    1350:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1357:	e8 94 2d 00 00       	call   40f0 <printf>
    exit(0);
    135c:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1363:	e8 40 2c 00 00       	call   3fa8 <exit>
    1368:	90                   	nop
    1369:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00001370 <linkunlink>:

// another concurrent link/unlink/create test,
// to look for deadlocks.
void
linkunlink()
{
    1370:	55                   	push   %ebp
    1371:	89 e5                	mov    %esp,%ebp
    1373:	57                   	push   %edi
    1374:	56                   	push   %esi
    1375:	53                   	push   %ebx
    1376:	83 ec 2c             	sub    $0x2c,%esp
  int pid, i;

  printf(1, "linkunlink test\n");
    1379:	c7 44 24 04 a8 49 00 	movl   $0x49a8,0x4(%esp)
    1380:	00 
    1381:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1388:	e8 63 2d 00 00       	call   40f0 <printf>

  unlink("x");
    138d:	c7 04 24 85 50 00 00 	movl   $0x5085,(%esp)
    1394:	e8 5f 2c 00 00       	call   3ff8 <unlink>
  pid = fork();
    1399:	e8 02 2c 00 00       	call   3fa0 <fork>
  if(pid < 0){
    139e:	85 c0                	test   %eax,%eax
  int pid, i;

  printf(1, "linkunlink test\n");

  unlink("x");
  pid = fork();
    13a0:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(pid < 0){
    13a3:	0f 88 c0 00 00 00    	js     1469 <linkunlink+0xf9>
    printf(1, "fork failed\n");
    exit(0);
  }

  unsigned int x = (pid ? 1 : 97);
    13a9:	83 7d e4 01          	cmpl   $0x1,-0x1c(%ebp)
  for(i = 0; i < 100; i++){
    x = x * 1103515245 + 12345;
    if((x % 3) == 0){
    13ad:	bf ab aa aa aa       	mov    $0xaaaaaaab,%edi
  if(pid < 0){
    printf(1, "fork failed\n");
    exit(0);
  }

  unsigned int x = (pid ? 1 : 97);
    13b2:	19 db                	sbb    %ebx,%ebx
    13b4:	31 f6                	xor    %esi,%esi
    13b6:	83 e3 60             	and    $0x60,%ebx
    13b9:	83 c3 01             	add    $0x1,%ebx
    13bc:	eb 1f                	jmp    13dd <linkunlink+0x6d>
    13be:	66 90                	xchg   %ax,%ax
  for(i = 0; i < 100; i++){
    x = x * 1103515245 + 12345;
    if((x % 3) == 0){
      close(open("x", O_RDWR | O_CREATE));
    } else if((x % 3) == 1){
    13c0:	83 f8 01             	cmp    $0x1,%eax
    13c3:	0f 84 87 00 00 00    	je     1450 <linkunlink+0xe0>
      link("cat", "x");
    } else {
      unlink("x");
    13c9:	c7 04 24 85 50 00 00 	movl   $0x5085,(%esp)
    13d0:	e8 23 2c 00 00       	call   3ff8 <unlink>
    printf(1, "fork failed\n");
    exit(0);
  }

  unsigned int x = (pid ? 1 : 97);
  for(i = 0; i < 100; i++){
    13d5:	83 c6 01             	add    $0x1,%esi
    13d8:	83 fe 64             	cmp    $0x64,%esi
    13db:	74 3f                	je     141c <linkunlink+0xac>
    x = x * 1103515245 + 12345;
    13dd:	69 db 6d 4e c6 41    	imul   $0x41c64e6d,%ebx,%ebx
    13e3:	81 c3 39 30 00 00    	add    $0x3039,%ebx
    if((x % 3) == 0){
    13e9:	89 d8                	mov    %ebx,%eax
    13eb:	f7 e7                	mul    %edi
    13ed:	89 d8                	mov    %ebx,%eax
    13ef:	d1 ea                	shr    %edx
    13f1:	8d 14 52             	lea    (%edx,%edx,2),%edx
    13f4:	29 d0                	sub    %edx,%eax
    13f6:	75 c8                	jne    13c0 <linkunlink+0x50>
      close(open("x", O_RDWR | O_CREATE));
    13f8:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
    13ff:	00 
    printf(1, "fork failed\n");
    exit(0);
  }

  unsigned int x = (pid ? 1 : 97);
  for(i = 0; i < 100; i++){
    1400:	83 c6 01             	add    $0x1,%esi
    x = x * 1103515245 + 12345;
    if((x % 3) == 0){
      close(open("x", O_RDWR | O_CREATE));
    1403:	c7 04 24 85 50 00 00 	movl   $0x5085,(%esp)
    140a:	e8 d9 2b 00 00       	call   3fe8 <open>
    140f:	89 04 24             	mov    %eax,(%esp)
    1412:	e8 b9 2b 00 00       	call   3fd0 <close>
    printf(1, "fork failed\n");
    exit(0);
  }

  unsigned int x = (pid ? 1 : 97);
  for(i = 0; i < 100; i++){
    1417:	83 fe 64             	cmp    $0x64,%esi
    141a:	75 c1                	jne    13dd <linkunlink+0x6d>
    } else {
      unlink("x");
    }
  }

  if(pid)
    141c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    141f:	85 c0                	test   %eax,%eax
    1421:	74 66                	je     1489 <linkunlink+0x119>
    wait(0);
    1423:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    142a:	e8 81 2b 00 00       	call   3fb0 <wait>
  else
    exit(0);

  printf(1, "linkunlink ok\n");
    142f:	c7 44 24 04 bd 49 00 	movl   $0x49bd,0x4(%esp)
    1436:	00 
    1437:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    143e:	e8 ad 2c 00 00       	call   40f0 <printf>
}
    1443:	83 c4 2c             	add    $0x2c,%esp
    1446:	5b                   	pop    %ebx
    1447:	5e                   	pop    %esi
    1448:	5f                   	pop    %edi
    1449:	5d                   	pop    %ebp
    144a:	c3                   	ret    
    144b:	90                   	nop
    144c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(i = 0; i < 100; i++){
    x = x * 1103515245 + 12345;
    if((x % 3) == 0){
      close(open("x", O_RDWR | O_CREATE));
    } else if((x % 3) == 1){
      link("cat", "x");
    1450:	c7 44 24 04 85 50 00 	movl   $0x5085,0x4(%esp)
    1457:	00 
    1458:	c7 04 24 b9 49 00 00 	movl   $0x49b9,(%esp)
    145f:	e8 a4 2b 00 00       	call   4008 <link>
    1464:	e9 6c ff ff ff       	jmp    13d5 <linkunlink+0x65>
  printf(1, "linkunlink test\n");

  unlink("x");
  pid = fork();
  if(pid < 0){
    printf(1, "fork failed\n");
    1469:	c7 44 24 04 cf 48 00 	movl   $0x48cf,0x4(%esp)
    1470:	00 
    1471:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1478:	e8 73 2c 00 00       	call   40f0 <printf>
    exit(0);
    147d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1484:	e8 1f 2b 00 00       	call   3fa8 <exit>
  }

  if(pid)
    wait(0);
  else
    exit(0);
    1489:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1490:	e8 13 2b 00 00       	call   3fa8 <exit>
    1495:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1499:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000014a0 <linktest>:
  printf(1, "unlinkread ok\n");
}

void
linktest(void)
{
    14a0:	55                   	push   %ebp
    14a1:	89 e5                	mov    %esp,%ebp
    14a3:	53                   	push   %ebx
    14a4:	83 ec 14             	sub    $0x14,%esp
  int fd;

  printf(1, "linktest\n");
    14a7:	c7 44 24 04 cc 49 00 	movl   $0x49cc,0x4(%esp)
    14ae:	00 
    14af:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    14b6:	e8 35 2c 00 00       	call   40f0 <printf>

  unlink("lf1");
    14bb:	c7 04 24 d6 49 00 00 	movl   $0x49d6,(%esp)
    14c2:	e8 31 2b 00 00       	call   3ff8 <unlink>
  unlink("lf2");
    14c7:	c7 04 24 da 49 00 00 	movl   $0x49da,(%esp)
    14ce:	e8 25 2b 00 00       	call   3ff8 <unlink>

  fd = open("lf1", O_CREATE|O_RDWR);
    14d3:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
    14da:	00 
    14db:	c7 04 24 d6 49 00 00 	movl   $0x49d6,(%esp)
    14e2:	e8 01 2b 00 00       	call   3fe8 <open>
  if(fd < 0){
    14e7:	85 c0                	test   %eax,%eax
  printf(1, "linktest\n");

  unlink("lf1");
  unlink("lf2");

  fd = open("lf1", O_CREATE|O_RDWR);
    14e9:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    14eb:	0f 88 26 01 00 00    	js     1617 <linktest+0x177>
    printf(1, "create lf1 failed\n");
    exit(0);
  }
  if(write(fd, "hello", 5) != 5){
    14f1:	c7 44 24 08 05 00 00 	movl   $0x5,0x8(%esp)
    14f8:	00 
    14f9:	c7 44 24 04 49 46 00 	movl   $0x4649,0x4(%esp)
    1500:	00 
    1501:	89 04 24             	mov    %eax,(%esp)
    1504:	e8 bf 2a 00 00       	call   3fc8 <write>
    1509:	83 f8 05             	cmp    $0x5,%eax
    150c:	0f 85 05 02 00 00    	jne    1717 <linktest+0x277>
    printf(1, "write lf1 failed\n");
    exit(0);
  }
  close(fd);
    1512:	89 1c 24             	mov    %ebx,(%esp)
    1515:	e8 b6 2a 00 00       	call   3fd0 <close>

  if(link("lf1", "lf2") < 0){
    151a:	c7 44 24 04 da 49 00 	movl   $0x49da,0x4(%esp)
    1521:	00 
    1522:	c7 04 24 d6 49 00 00 	movl   $0x49d6,(%esp)
    1529:	e8 da 2a 00 00       	call   4008 <link>
    152e:	85 c0                	test   %eax,%eax
    1530:	0f 88 c1 01 00 00    	js     16f7 <linktest+0x257>
    printf(1, "link lf1 lf2 failed\n");
    exit(0);
  }
  unlink("lf1");
    1536:	c7 04 24 d6 49 00 00 	movl   $0x49d6,(%esp)
    153d:	e8 b6 2a 00 00       	call   3ff8 <unlink>

  if(open("lf1", 0) >= 0){
    1542:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1549:	00 
    154a:	c7 04 24 d6 49 00 00 	movl   $0x49d6,(%esp)
    1551:	e8 92 2a 00 00       	call   3fe8 <open>
    1556:	85 c0                	test   %eax,%eax
    1558:	0f 89 79 01 00 00    	jns    16d7 <linktest+0x237>
    printf(1, "unlinked lf1 but it is still there!\n");
    exit(0);
  }

  fd = open("lf2", 0);
    155e:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1565:	00 
    1566:	c7 04 24 da 49 00 00 	movl   $0x49da,(%esp)
    156d:	e8 76 2a 00 00       	call   3fe8 <open>
  if(fd < 0){
    1572:	85 c0                	test   %eax,%eax
  if(open("lf1", 0) >= 0){
    printf(1, "unlinked lf1 but it is still there!\n");
    exit(0);
  }

  fd = open("lf2", 0);
    1574:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    1576:	0f 88 3b 01 00 00    	js     16b7 <linktest+0x217>
    printf(1, "open lf2 failed\n");
    exit(0);
  }
  if(read(fd, buf, sizeof(buf)) != 5){
    157c:	c7 44 24 08 00 20 00 	movl   $0x2000,0x8(%esp)
    1583:	00 
    1584:	c7 44 24 04 00 84 00 	movl   $0x8400,0x4(%esp)
    158b:	00 
    158c:	89 04 24             	mov    %eax,(%esp)
    158f:	e8 2c 2a 00 00       	call   3fc0 <read>
    1594:	83 f8 05             	cmp    $0x5,%eax
    1597:	0f 85 fa 00 00 00    	jne    1697 <linktest+0x1f7>
    printf(1, "read lf2 failed\n");
    exit(0);
  }
  close(fd);
    159d:	89 1c 24             	mov    %ebx,(%esp)
    15a0:	e8 2b 2a 00 00       	call   3fd0 <close>

  if(link("lf2", "lf2") >= 0){
    15a5:	c7 44 24 04 da 49 00 	movl   $0x49da,0x4(%esp)
    15ac:	00 
    15ad:	c7 04 24 da 49 00 00 	movl   $0x49da,(%esp)
    15b4:	e8 4f 2a 00 00       	call   4008 <link>
    15b9:	85 c0                	test   %eax,%eax
    15bb:	0f 89 b6 00 00 00    	jns    1677 <linktest+0x1d7>
    printf(1, "link lf2 lf2 succeeded! oops\n");
    exit(0);
  }

  unlink("lf2");
    15c1:	c7 04 24 da 49 00 00 	movl   $0x49da,(%esp)
    15c8:	e8 2b 2a 00 00       	call   3ff8 <unlink>
  if(link("lf2", "lf1") >= 0){
    15cd:	c7 44 24 04 d6 49 00 	movl   $0x49d6,0x4(%esp)
    15d4:	00 
    15d5:	c7 04 24 da 49 00 00 	movl   $0x49da,(%esp)
    15dc:	e8 27 2a 00 00       	call   4008 <link>
    15e1:	85 c0                	test   %eax,%eax
    15e3:	79 72                	jns    1657 <linktest+0x1b7>
    printf(1, "link non-existant succeeded! oops\n");
    exit(0);
  }

  if(link(".", "lf1") >= 0){
    15e5:	c7 44 24 04 d6 49 00 	movl   $0x49d6,0x4(%esp)
    15ec:	00 
    15ed:	c7 04 24 a2 4f 00 00 	movl   $0x4fa2,(%esp)
    15f4:	e8 0f 2a 00 00       	call   4008 <link>
    15f9:	85 c0                	test   %eax,%eax
    15fb:	79 3a                	jns    1637 <linktest+0x197>
    printf(1, "link . lf1 succeeded! oops\n");
    exit(0);
  }

  printf(1, "linktest ok\n");
    15fd:	c7 44 24 04 74 4a 00 	movl   $0x4a74,0x4(%esp)
    1604:	00 
    1605:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    160c:	e8 df 2a 00 00       	call   40f0 <printf>
}
    1611:	83 c4 14             	add    $0x14,%esp
    1614:	5b                   	pop    %ebx
    1615:	5d                   	pop    %ebp
    1616:	c3                   	ret    
  unlink("lf1");
  unlink("lf2");

  fd = open("lf1", O_CREATE|O_RDWR);
  if(fd < 0){
    printf(1, "create lf1 failed\n");
    1617:	c7 44 24 04 de 49 00 	movl   $0x49de,0x4(%esp)
    161e:	00 
    161f:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1626:	e8 c5 2a 00 00       	call   40f0 <printf>
    exit(0);
    162b:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1632:	e8 71 29 00 00       	call   3fa8 <exit>
    printf(1, "link non-existant succeeded! oops\n");
    exit(0);
  }

  if(link(".", "lf1") >= 0){
    printf(1, "link . lf1 succeeded! oops\n");
    1637:	c7 44 24 04 58 4a 00 	movl   $0x4a58,0x4(%esp)
    163e:	00 
    163f:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1646:	e8 a5 2a 00 00       	call   40f0 <printf>
    exit(0);
    164b:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1652:	e8 51 29 00 00       	call   3fa8 <exit>
    exit(0);
  }

  unlink("lf2");
  if(link("lf2", "lf1") >= 0){
    printf(1, "link non-existant succeeded! oops\n");
    1657:	c7 44 24 04 c8 56 00 	movl   $0x56c8,0x4(%esp)
    165e:	00 
    165f:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1666:	e8 85 2a 00 00       	call   40f0 <printf>
    exit(0);
    166b:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1672:	e8 31 29 00 00       	call   3fa8 <exit>
    exit(0);
  }
  close(fd);

  if(link("lf2", "lf2") >= 0){
    printf(1, "link lf2 lf2 succeeded! oops\n");
    1677:	c7 44 24 04 3a 4a 00 	movl   $0x4a3a,0x4(%esp)
    167e:	00 
    167f:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1686:	e8 65 2a 00 00       	call   40f0 <printf>
    exit(0);
    168b:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1692:	e8 11 29 00 00       	call   3fa8 <exit>
  if(fd < 0){
    printf(1, "open lf2 failed\n");
    exit(0);
  }
  if(read(fd, buf, sizeof(buf)) != 5){
    printf(1, "read lf2 failed\n");
    1697:	c7 44 24 04 29 4a 00 	movl   $0x4a29,0x4(%esp)
    169e:	00 
    169f:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    16a6:	e8 45 2a 00 00       	call   40f0 <printf>
    exit(0);
    16ab:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    16b2:	e8 f1 28 00 00       	call   3fa8 <exit>
    exit(0);
  }

  fd = open("lf2", 0);
  if(fd < 0){
    printf(1, "open lf2 failed\n");
    16b7:	c7 44 24 04 18 4a 00 	movl   $0x4a18,0x4(%esp)
    16be:	00 
    16bf:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    16c6:	e8 25 2a 00 00       	call   40f0 <printf>
    exit(0);
    16cb:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    16d2:	e8 d1 28 00 00       	call   3fa8 <exit>
    exit(0);
  }
  unlink("lf1");

  if(open("lf1", 0) >= 0){
    printf(1, "unlinked lf1 but it is still there!\n");
    16d7:	c7 44 24 04 a0 56 00 	movl   $0x56a0,0x4(%esp)
    16de:	00 
    16df:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    16e6:	e8 05 2a 00 00       	call   40f0 <printf>
    exit(0);
    16eb:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    16f2:	e8 b1 28 00 00       	call   3fa8 <exit>
    exit(0);
  }
  close(fd);

  if(link("lf1", "lf2") < 0){
    printf(1, "link lf1 lf2 failed\n");
    16f7:	c7 44 24 04 03 4a 00 	movl   $0x4a03,0x4(%esp)
    16fe:	00 
    16ff:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1706:	e8 e5 29 00 00       	call   40f0 <printf>
    exit(0);
    170b:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1712:	e8 91 28 00 00       	call   3fa8 <exit>
  if(fd < 0){
    printf(1, "create lf1 failed\n");
    exit(0);
  }
  if(write(fd, "hello", 5) != 5){
    printf(1, "write lf1 failed\n");
    1717:	c7 44 24 04 f1 49 00 	movl   $0x49f1,0x4(%esp)
    171e:	00 
    171f:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1726:	e8 c5 29 00 00       	call   40f0 <printf>
    exit(0);
    172b:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1732:	e8 71 28 00 00       	call   3fa8 <exit>
    1737:	89 f6                	mov    %esi,%esi
    1739:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001740 <sbrktest>:
  printf(1, "fork test OK\n");
}

void
sbrktest(void)
{
    1740:	55                   	push   %ebp
    1741:	89 e5                	mov    %esp,%ebp
    1743:	57                   	push   %edi
    1744:	56                   	push   %esi

  printf(stdout, "sbrk test\n");
  oldbrk = sbrk(0);

  // can one sbrk() less than a page?
  a = sbrk(0);
    1745:	31 f6                	xor    %esi,%esi
  printf(1, "fork test OK\n");
}

void
sbrktest(void)
{
    1747:	53                   	push   %ebx
    1748:	83 ec 7c             	sub    $0x7c,%esp
  int fds[2], pid, pids[10], ppid;
  char *a, *b, *c, *lastaddr, *oldbrk, *p, scratch;
  uint amt;

  printf(stdout, "sbrk test\n");
    174b:	a1 1c 5c 00 00       	mov    0x5c1c,%eax
    1750:	c7 44 24 04 81 4a 00 	movl   $0x4a81,0x4(%esp)
    1757:	00 
    1758:	89 04 24             	mov    %eax,(%esp)
    175b:	e8 90 29 00 00       	call   40f0 <printf>
  oldbrk = sbrk(0);
    1760:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1767:	e8 c4 28 00 00       	call   4030 <sbrk>

  // can one sbrk() less than a page?
  a = sbrk(0);
    176c:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  int fds[2], pid, pids[10], ppid;
  char *a, *b, *c, *lastaddr, *oldbrk, *p, scratch;
  uint amt;

  printf(stdout, "sbrk test\n");
  oldbrk = sbrk(0);
    1773:	89 45 a4             	mov    %eax,-0x5c(%ebp)

  // can one sbrk() less than a page?
  a = sbrk(0);
    1776:	e8 b5 28 00 00       	call   4030 <sbrk>
    177b:	89 c3                	mov    %eax,%ebx
    177d:	8d 76 00             	lea    0x0(%esi),%esi
  int i;
  for(i = 0; i < 5000; i++){
    b = sbrk(1);
    1780:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1787:	e8 a4 28 00 00       	call   4030 <sbrk>
    if(b != a){
    178c:	39 c3                	cmp    %eax,%ebx
    178e:	0f 85 9a 02 00 00    	jne    1a2e <sbrktest+0x2ee>
  oldbrk = sbrk(0);

  // can one sbrk() less than a page?
  a = sbrk(0);
  int i;
  for(i = 0; i < 5000; i++){
    1794:	83 c6 01             	add    $0x1,%esi
    b = sbrk(1);
    if(b != a){
      printf(stdout, "sbrk test failed %d %x %x\n", i, a, b);
      exit(0);
    }
    *b = 1;
    1797:	c6 03 01             	movb   $0x1,(%ebx)
    a = b + 1;
    179a:	83 c3 01             	add    $0x1,%ebx
  oldbrk = sbrk(0);

  // can one sbrk() less than a page?
  a = sbrk(0);
  int i;
  for(i = 0; i < 5000; i++){
    179d:	81 fe 88 13 00 00    	cmp    $0x1388,%esi
    17a3:	75 db                	jne    1780 <sbrktest+0x40>
      exit(0);
    }
    *b = 1;
    a = b + 1;
  }
  pid = fork();
    17a5:	e8 f6 27 00 00       	call   3fa0 <fork>
  if(pid < 0){
    17aa:	85 c0                	test   %eax,%eax
      exit(0);
    }
    *b = 1;
    a = b + 1;
  }
  pid = fork();
    17ac:	89 c6                	mov    %eax,%esi
  if(pid < 0){
    17ae:	0f 88 b4 03 00 00    	js     1b68 <sbrktest+0x428>
    printf(stdout, "sbrk test fork failed\n");
    exit(0);
  }
  c = sbrk(1);
    17b4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  c = sbrk(1);
  if(c != a + 1){
    17bb:	83 c3 01             	add    $0x1,%ebx
  pid = fork();
  if(pid < 0){
    printf(stdout, "sbrk test fork failed\n");
    exit(0);
  }
  c = sbrk(1);
    17be:	e8 6d 28 00 00       	call   4030 <sbrk>
  c = sbrk(1);
    17c3:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    17ca:	e8 61 28 00 00       	call   4030 <sbrk>
  if(c != a + 1){
    17cf:	39 d8                	cmp    %ebx,%eax
    17d1:	0f 85 84 03 00 00    	jne    1b5b <sbrktest+0x41b>
    printf(stdout, "sbrk test failed post-fork\n");
    exit(0);
  }
  if(pid == 0)
    17d7:	85 f6                	test   %esi,%esi
    17d9:	0f 84 b1 02 00 00    	je     1a90 <sbrktest+0x350>
    exit(0);
  wait(0);
    17df:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    17e6:	e8 c5 27 00 00       	call   3fb0 <wait>

  // can one grow address space to something big?
#define BIG (100*1024*1024)
  a = sbrk(0);
    17eb:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    17f2:	e8 39 28 00 00       	call   4030 <sbrk>
    17f7:	89 c3                	mov    %eax,%ebx
  amt = (BIG) - (uint)a;
  p = sbrk(amt);
    17f9:	b8 00 00 40 06       	mov    $0x6400000,%eax
    17fe:	29 d8                	sub    %ebx,%eax
    1800:	89 04 24             	mov    %eax,(%esp)
    1803:	e8 28 28 00 00       	call   4030 <sbrk>
  if (p != a) {
    1808:	39 c3                	cmp    %eax,%ebx
    180a:	0f 85 08 03 00 00    	jne    1b18 <sbrktest+0x3d8>
    printf(stdout, "sbrk test failed to grow big address space; enough phys mem?\n");
    exit(0);
  }
  lastaddr = (char*) (BIG-1);
  *lastaddr = 99;
    1810:	c6 05 ff ff 3f 06 63 	movb   $0x63,0x63fffff

  // can one de-allocate?
  a = sbrk(0);
    1817:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    181e:	e8 0d 28 00 00       	call   4030 <sbrk>
  c = sbrk(-4096);
    1823:	c7 04 24 00 f0 ff ff 	movl   $0xfffff000,(%esp)
  }
  lastaddr = (char*) (BIG-1);
  *lastaddr = 99;

  // can one de-allocate?
  a = sbrk(0);
    182a:	89 c3                	mov    %eax,%ebx
  c = sbrk(-4096);
    182c:	e8 ff 27 00 00       	call   4030 <sbrk>
  if(c == (char*)0xffffffff){
    1831:	83 f8 ff             	cmp    $0xffffffff,%eax
    1834:	0f 84 14 03 00 00    	je     1b4e <sbrktest+0x40e>
    printf(stdout, "sbrk could not deallocate\n");
    exit(0);
  }
  c = sbrk(0);
    183a:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1841:	e8 ea 27 00 00       	call   4030 <sbrk>
  if(c != a - 4096){
    1846:	8d 93 00 f0 ff ff    	lea    -0x1000(%ebx),%edx
    184c:	39 d0                	cmp    %edx,%eax
    184e:	0f 85 d1 02 00 00    	jne    1b25 <sbrktest+0x3e5>
    printf(stdout, "sbrk deallocation produced wrong address, a %x c %x\n", a, c);
    exit(0);
  }

  // can one re-allocate that page?
  a = sbrk(0);
    1854:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    185b:	e8 d0 27 00 00       	call   4030 <sbrk>
  c = sbrk(4096);
    1860:	c7 04 24 00 10 00 00 	movl   $0x1000,(%esp)
    printf(stdout, "sbrk deallocation produced wrong address, a %x c %x\n", a, c);
    exit(0);
  }

  // can one re-allocate that page?
  a = sbrk(0);
    1867:	89 c3                	mov    %eax,%ebx
  c = sbrk(4096);
    1869:	e8 c2 27 00 00       	call   4030 <sbrk>
  if(c != a || sbrk(0) != a + 4096){
    186e:	39 c3                	cmp    %eax,%ebx
    exit(0);
  }

  // can one re-allocate that page?
  a = sbrk(0);
  c = sbrk(4096);
    1870:	89 c6                	mov    %eax,%esi
  if(c != a || sbrk(0) != a + 4096){
    1872:	0f 85 8e 02 00 00    	jne    1b06 <sbrktest+0x3c6>
    1878:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    187f:	e8 ac 27 00 00       	call   4030 <sbrk>
    1884:	8d 93 00 10 00 00    	lea    0x1000(%ebx),%edx
    188a:	39 d0                	cmp    %edx,%eax
    188c:	0f 85 74 02 00 00    	jne    1b06 <sbrktest+0x3c6>
    printf(stdout, "sbrk re-allocation failed, a %x c %x\n", a, c);
    exit(0);
  }
  if(*lastaddr == 99){
    1892:	80 3d ff ff 3f 06 63 	cmpb   $0x63,0x63fffff
    1899:	0f 84 5a 02 00 00    	je     1af9 <sbrktest+0x3b9>
    // should be zero
    printf(stdout, "sbrk de-allocation didn't really deallocate\n");
    exit(0);
  }

  a = sbrk(0);
    189f:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  c = sbrk(-(sbrk(0) - oldbrk));
  if(c != a){
    printf(stdout, "sbrk downsize failed, a %x c %x\n", a, c);
    exit(0);
    18a6:	bb 00 00 00 80       	mov    $0x80000000,%ebx
    // should be zero
    printf(stdout, "sbrk de-allocation didn't really deallocate\n");
    exit(0);
  }

  a = sbrk(0);
    18ab:	e8 80 27 00 00       	call   4030 <sbrk>
  c = sbrk(-(sbrk(0) - oldbrk));
    18b0:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    // should be zero
    printf(stdout, "sbrk de-allocation didn't really deallocate\n");
    exit(0);
  }

  a = sbrk(0);
    18b7:	89 c6                	mov    %eax,%esi
  c = sbrk(-(sbrk(0) - oldbrk));
    18b9:	e8 72 27 00 00       	call   4030 <sbrk>
    18be:	8b 55 a4             	mov    -0x5c(%ebp),%edx
    18c1:	29 c2                	sub    %eax,%edx
    18c3:	89 14 24             	mov    %edx,(%esp)
    18c6:	e8 65 27 00 00       	call   4030 <sbrk>
  if(c != a){
    18cb:	39 c6                	cmp    %eax,%esi
    18cd:	0f 85 07 02 00 00    	jne    1ada <sbrktest+0x39a>
    18d3:	90                   	nop
    18d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    exit(0);
  }

  // can we read the kernel's memory?
  for(a = (char*)(KERNBASE); a < (char*) (KERNBASE+2000000); a += 50000){
    ppid = getpid();
    18d8:	e8 4b 27 00 00       	call   4028 <getpid>
    18dd:	89 c6                	mov    %eax,%esi
    pid = fork();
    18df:	e8 bc 26 00 00       	call   3fa0 <fork>
    if(pid < 0){
    18e4:	83 f8 00             	cmp    $0x0,%eax
    18e7:	0f 8c e3 01 00 00    	jl     1ad0 <sbrktest+0x390>
    18ed:	8d 76 00             	lea    0x0(%esi),%esi
      printf(stdout, "fork failed\n");
      exit(0);
    }
    if(pid == 0){
    18f0:	0f 84 a6 01 00 00    	je     1a9c <sbrktest+0x35c>
    printf(stdout, "sbrk downsize failed, a %x c %x\n", a, c);
    exit(0);
  }

  // can we read the kernel's memory?
  for(a = (char*)(KERNBASE); a < (char*) (KERNBASE+2000000); a += 50000){
    18f6:	81 c3 50 c3 00 00    	add    $0xc350,%ebx
    if(pid == 0){
      printf(stdout, "oops could read %x = %x\n", a, *a);
      kill(ppid);
      exit(0);
    }
    wait(0);
    18fc:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1903:	e8 a8 26 00 00       	call   3fb0 <wait>
    printf(stdout, "sbrk downsize failed, a %x c %x\n", a, c);
    exit(0);
  }

  // can we read the kernel's memory?
  for(a = (char*)(KERNBASE); a < (char*) (KERNBASE+2000000); a += 50000){
    1908:	81 fb 80 84 1e 80    	cmp    $0x801e8480,%ebx
    190e:	75 c8                	jne    18d8 <sbrktest+0x198>
    wait(0);
  }

  // if we run the system out of memory, does it clean up the last
  // failed allocation?
  if(pipe(fds) != 0){
    1910:	8d 45 dc             	lea    -0x24(%ebp),%eax
    1913:	89 04 24             	mov    %eax,(%esp)
    1916:	e8 9d 26 00 00       	call   3fb8 <pipe>
    191b:	85 c0                	test   %eax,%eax
    191d:	0f 85 59 01 00 00    	jne    1a7c <sbrktest+0x33c>
    printf(1, "pipe() failed\n");
    exit(0);
    1923:	31 db                	xor    %ebx,%ebx
    1925:	8d 7d b4             	lea    -0x4c(%ebp),%edi
  }
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    if((pids[i] = fork()) == 0){
    1928:	e8 73 26 00 00       	call   3fa0 <fork>
    192d:	85 c0                	test   %eax,%eax
    192f:	89 c6                	mov    %eax,%esi
    1931:	0f 84 ae 00 00 00    	je     19e5 <sbrktest+0x2a5>
      sbrk(BIG - (uint)sbrk(0));
      write(fds[1], "x", 1);
      // sit around until killed
      for(;;) sleep(1000);
    }
    if(pids[i] != -1)
    1937:	83 f8 ff             	cmp    $0xffffffff,%eax
    193a:	74 1a                	je     1956 <sbrktest+0x216>
      read(fds[0], &scratch, 1);
    193c:	8d 45 e7             	lea    -0x19(%ebp),%eax
    193f:	89 44 24 04          	mov    %eax,0x4(%esp)
    1943:	8b 45 dc             	mov    -0x24(%ebp),%eax
    1946:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    194d:	00 
    194e:	89 04 24             	mov    %eax,(%esp)
    1951:	e8 6a 26 00 00       	call   3fc0 <read>
  if(pipe(fds) != 0){
    printf(1, "pipe() failed\n");
    exit(0);
  }
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    if((pids[i] = fork()) == 0){
    1956:	89 34 9f             	mov    %esi,(%edi,%ebx,4)
  // failed allocation?
  if(pipe(fds) != 0){
    printf(1, "pipe() failed\n");
    exit(0);
  }
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    1959:	83 c3 01             	add    $0x1,%ebx
    195c:	83 fb 0a             	cmp    $0xa,%ebx
    195f:	75 c7                	jne    1928 <sbrktest+0x1e8>
    if(pids[i] != -1)
      read(fds[0], &scratch, 1);
  }
  // if those failed allocations freed up the pages they did allocate,
  // we'll be able to allocate here
  c = sbrk(4096);
    1961:	c7 04 24 00 10 00 00 	movl   $0x1000,(%esp)
    1968:	30 db                	xor    %bl,%bl
    196a:	e8 c1 26 00 00       	call   4030 <sbrk>
    196f:	89 c6                	mov    %eax,%esi
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    if(pids[i] == -1)
    1971:	8b 04 9f             	mov    (%edi,%ebx,4),%eax
    1974:	83 f8 ff             	cmp    $0xffffffff,%eax
    1977:	74 14                	je     198d <sbrktest+0x24d>
      continue;
    kill(pids[i]);
    1979:	89 04 24             	mov    %eax,(%esp)
    197c:	e8 57 26 00 00       	call   3fd8 <kill>
    wait(0);
    1981:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1988:	e8 23 26 00 00       	call   3fb0 <wait>
      read(fds[0], &scratch, 1);
  }
  // if those failed allocations freed up the pages they did allocate,
  // we'll be able to allocate here
  c = sbrk(4096);
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    198d:	83 c3 01             	add    $0x1,%ebx
    1990:	83 fb 0a             	cmp    $0xa,%ebx
    1993:	75 dc                	jne    1971 <sbrktest+0x231>
    if(pids[i] == -1)
      continue;
    kill(pids[i]);
    wait(0);
  }
  if(c == (char*)0xffffffff){
    1995:	83 fe ff             	cmp    $0xffffffff,%esi
    1998:	0f 84 bd 00 00 00    	je     1a5b <sbrktest+0x31b>
    printf(stdout, "failed sbrk leaked memory\n");
    exit(0);
  }

  if(sbrk(0) > oldbrk)
    199e:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    19a5:	e8 86 26 00 00       	call   4030 <sbrk>
    19aa:	39 45 a4             	cmp    %eax,-0x5c(%ebp)
    19ad:	73 19                	jae    19c8 <sbrktest+0x288>
    sbrk(-(sbrk(0) - oldbrk));
    19af:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    19b6:	e8 75 26 00 00       	call   4030 <sbrk>
    19bb:	8b 55 a4             	mov    -0x5c(%ebp),%edx
    19be:	29 c2                	sub    %eax,%edx
    19c0:	89 14 24             	mov    %edx,(%esp)
    19c3:	e8 68 26 00 00       	call   4030 <sbrk>

  printf(stdout, "sbrk test OK\n");
    19c8:	a1 1c 5c 00 00       	mov    0x5c1c,%eax
    19cd:	c7 44 24 04 38 4b 00 	movl   $0x4b38,0x4(%esp)
    19d4:	00 
    19d5:	89 04 24             	mov    %eax,(%esp)
    19d8:	e8 13 27 00 00       	call   40f0 <printf>
}
    19dd:	83 c4 7c             	add    $0x7c,%esp
    19e0:	5b                   	pop    %ebx
    19e1:	5e                   	pop    %esi
    19e2:	5f                   	pop    %edi
    19e3:	5d                   	pop    %ebp
    19e4:	c3                   	ret    
    exit(0);
  }
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    if((pids[i] = fork()) == 0){
      // allocate a lot of memory
      sbrk(BIG - (uint)sbrk(0));
    19e5:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    19ec:	e8 3f 26 00 00       	call   4030 <sbrk>
    19f1:	ba 00 00 40 06       	mov    $0x6400000,%edx
    19f6:	29 c2                	sub    %eax,%edx
    19f8:	89 14 24             	mov    %edx,(%esp)
    19fb:	e8 30 26 00 00       	call   4030 <sbrk>
      write(fds[1], "x", 1);
    1a00:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1a03:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    1a0a:	00 
    1a0b:	c7 44 24 04 85 50 00 	movl   $0x5085,0x4(%esp)
    1a12:	00 
    1a13:	89 04 24             	mov    %eax,(%esp)
    1a16:	e8 ad 25 00 00       	call   3fc8 <write>
    1a1b:	90                   	nop
    1a1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      // sit around until killed
      for(;;) sleep(1000);
    1a20:	c7 04 24 e8 03 00 00 	movl   $0x3e8,(%esp)
    1a27:	e8 0c 26 00 00       	call   4038 <sleep>
    1a2c:	eb f2                	jmp    1a20 <sbrktest+0x2e0>
  a = sbrk(0);
  int i;
  for(i = 0; i < 5000; i++){
    b = sbrk(1);
    if(b != a){
      printf(stdout, "sbrk test failed %d %x %x\n", i, a, b);
    1a2e:	89 44 24 10          	mov    %eax,0x10(%esp)
    1a32:	a1 1c 5c 00 00       	mov    0x5c1c,%eax
    1a37:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
    1a3b:	89 74 24 08          	mov    %esi,0x8(%esp)
    1a3f:	c7 44 24 04 8c 4a 00 	movl   $0x4a8c,0x4(%esp)
    1a46:	00 
    1a47:	89 04 24             	mov    %eax,(%esp)
    1a4a:	e8 a1 26 00 00       	call   40f0 <printf>
      exit(0);
    1a4f:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1a56:	e8 4d 25 00 00       	call   3fa8 <exit>
      continue;
    kill(pids[i]);
    wait(0);
  }
  if(c == (char*)0xffffffff){
    printf(stdout, "failed sbrk leaked memory\n");
    1a5b:	c7 44 24 04 1d 4b 00 	movl   $0x4b1d,0x4(%esp)
    1a62:	00 
    exit(0);
  }
  c = sbrk(1);
  c = sbrk(1);
  if(c != a + 1){
    printf(stdout, "sbrk test failed post-fork\n");
    1a63:	a1 1c 5c 00 00       	mov    0x5c1c,%eax
    1a68:	89 04 24             	mov    %eax,(%esp)
    1a6b:	e8 80 26 00 00       	call   40f0 <printf>
    exit(0);
    1a70:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1a77:	e8 2c 25 00 00       	call   3fa8 <exit>
  }

  // if we run the system out of memory, does it clean up the last
  // failed allocation?
  if(pipe(fds) != 0){
    printf(1, "pipe() failed\n");
    1a7c:	c7 44 24 04 0e 4b 00 	movl   $0x4b0e,0x4(%esp)
    1a83:	00 
    1a84:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1a8b:	e8 60 26 00 00       	call   40f0 <printf>

  a = sbrk(0);
  c = sbrk(-(sbrk(0) - oldbrk));
  if(c != a){
    printf(stdout, "sbrk downsize failed, a %x c %x\n", a, c);
    exit(0);
    1a90:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1a97:	e8 0c 25 00 00       	call   3fa8 <exit>
    if(pid < 0){
      printf(stdout, "fork failed\n");
      exit(0);
    }
    if(pid == 0){
      printf(stdout, "oops could read %x = %x\n", a, *a);
    1a9c:	0f be 03             	movsbl (%ebx),%eax
    1a9f:	89 5c 24 08          	mov    %ebx,0x8(%esp)
    1aa3:	c7 44 24 04 f5 4a 00 	movl   $0x4af5,0x4(%esp)
    1aaa:	00 
    1aab:	89 44 24 0c          	mov    %eax,0xc(%esp)
    1aaf:	a1 1c 5c 00 00       	mov    0x5c1c,%eax
    1ab4:	89 04 24             	mov    %eax,(%esp)
    1ab7:	e8 34 26 00 00       	call   40f0 <printf>
      kill(ppid);
    1abc:	89 34 24             	mov    %esi,(%esp)
    1abf:	e8 14 25 00 00       	call   3fd8 <kill>
      exit(0);
    1ac4:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1acb:	e8 d8 24 00 00       	call   3fa8 <exit>
  // can we read the kernel's memory?
  for(a = (char*)(KERNBASE); a < (char*) (KERNBASE+2000000); a += 50000){
    ppid = getpid();
    pid = fork();
    if(pid < 0){
      printf(stdout, "fork failed\n");
    1ad0:	c7 44 24 04 cf 48 00 	movl   $0x48cf,0x4(%esp)
    1ad7:	00 
    1ad8:	eb 89                	jmp    1a63 <sbrktest+0x323>
  }

  a = sbrk(0);
  c = sbrk(-(sbrk(0) - oldbrk));
  if(c != a){
    printf(stdout, "sbrk downsize failed, a %x c %x\n", a, c);
    1ada:	89 44 24 0c          	mov    %eax,0xc(%esp)
    1ade:	89 74 24 08          	mov    %esi,0x8(%esp)
    1ae2:	c7 44 24 04 bc 57 00 	movl   $0x57bc,0x4(%esp)
    1ae9:	00 
    1aea:	a1 1c 5c 00 00       	mov    0x5c1c,%eax
    1aef:	89 04 24             	mov    %eax,(%esp)
    1af2:	e8 f9 25 00 00       	call   40f0 <printf>
    1af7:	eb 97                	jmp    1a90 <sbrktest+0x350>
    printf(stdout, "sbrk re-allocation failed, a %x c %x\n", a, c);
    exit(0);
  }
  if(*lastaddr == 99){
    // should be zero
    printf(stdout, "sbrk de-allocation didn't really deallocate\n");
    1af9:	c7 44 24 04 8c 57 00 	movl   $0x578c,0x4(%esp)
    1b00:	00 
    1b01:	e9 5d ff ff ff       	jmp    1a63 <sbrktest+0x323>

  // can one re-allocate that page?
  a = sbrk(0);
  c = sbrk(4096);
  if(c != a || sbrk(0) != a + 4096){
    printf(stdout, "sbrk re-allocation failed, a %x c %x\n", a, c);
    1b06:	89 74 24 0c          	mov    %esi,0xc(%esp)
    1b0a:	89 5c 24 08          	mov    %ebx,0x8(%esp)
    1b0e:	c7 44 24 04 64 57 00 	movl   $0x5764,0x4(%esp)
    1b15:	00 
    1b16:	eb d2                	jmp    1aea <sbrktest+0x3aa>
#define BIG (100*1024*1024)
  a = sbrk(0);
  amt = (BIG) - (uint)a;
  p = sbrk(amt);
  if (p != a) {
    printf(stdout, "sbrk test failed to grow big address space; enough phys mem?\n");
    1b18:	c7 44 24 04 ec 56 00 	movl   $0x56ec,0x4(%esp)
    1b1f:	00 
    1b20:	e9 3e ff ff ff       	jmp    1a63 <sbrktest+0x323>
    printf(stdout, "sbrk could not deallocate\n");
    exit(0);
  }
  c = sbrk(0);
  if(c != a - 4096){
    printf(stdout, "sbrk deallocation produced wrong address, a %x c %x\n", a, c);
    1b25:	89 44 24 0c          	mov    %eax,0xc(%esp)
    1b29:	a1 1c 5c 00 00       	mov    0x5c1c,%eax
    1b2e:	89 5c 24 08          	mov    %ebx,0x8(%esp)
    1b32:	c7 44 24 04 2c 57 00 	movl   $0x572c,0x4(%esp)
    1b39:	00 
    1b3a:	89 04 24             	mov    %eax,(%esp)
    1b3d:	e8 ae 25 00 00       	call   40f0 <printf>
    exit(0);
    1b42:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1b49:	e8 5a 24 00 00       	call   3fa8 <exit>

  // can one de-allocate?
  a = sbrk(0);
  c = sbrk(-4096);
  if(c == (char*)0xffffffff){
    printf(stdout, "sbrk could not deallocate\n");
    1b4e:	c7 44 24 04 da 4a 00 	movl   $0x4ada,0x4(%esp)
    1b55:	00 
    1b56:	e9 08 ff ff ff       	jmp    1a63 <sbrktest+0x323>
    exit(0);
  }
  c = sbrk(1);
  c = sbrk(1);
  if(c != a + 1){
    printf(stdout, "sbrk test failed post-fork\n");
    1b5b:	c7 44 24 04 be 4a 00 	movl   $0x4abe,0x4(%esp)
    1b62:	00 
    1b63:	e9 fb fe ff ff       	jmp    1a63 <sbrktest+0x323>
    *b = 1;
    a = b + 1;
  }
  pid = fork();
  if(pid < 0){
    printf(stdout, "sbrk test fork failed\n");
    1b68:	c7 44 24 04 a7 4a 00 	movl   $0x4aa7,0x4(%esp)
    1b6f:	00 
    1b70:	e9 ee fe ff ff       	jmp    1a63 <sbrktest+0x323>
    1b75:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1b79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001b80 <preempt>:
}

// meant to be run w/ at most two CPUs
void
preempt(void)
{
    1b80:	55                   	push   %ebp
    1b81:	89 e5                	mov    %esp,%ebp
    1b83:	57                   	push   %edi
    1b84:	56                   	push   %esi
    1b85:	53                   	push   %ebx
    1b86:	83 ec 2c             	sub    $0x2c,%esp
  int pid1, pid2, pid3;
  int pfds[2];

  printf(1, "preempt: ");
    1b89:	c7 44 24 04 46 4b 00 	movl   $0x4b46,0x4(%esp)
    1b90:	00 
    1b91:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1b98:	e8 53 25 00 00       	call   40f0 <printf>
  pid1 = fork();
    1b9d:	e8 fe 23 00 00       	call   3fa0 <fork>
  if(pid1 == 0)
    1ba2:	85 c0                	test   %eax,%eax
{
  int pid1, pid2, pid3;
  int pfds[2];

  printf(1, "preempt: ");
  pid1 = fork();
    1ba4:	89 c7                	mov    %eax,%edi
  if(pid1 == 0)
    1ba6:	75 02                	jne    1baa <preempt+0x2a>
    1ba8:	eb fe                	jmp    1ba8 <preempt+0x28>
    1baa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    for(;;)
      ;

  pid2 = fork();
    1bb0:	e8 eb 23 00 00       	call   3fa0 <fork>
  if(pid2 == 0)
    1bb5:	85 c0                	test   %eax,%eax
  pid1 = fork();
  if(pid1 == 0)
    for(;;)
      ;

  pid2 = fork();
    1bb7:	89 c6                	mov    %eax,%esi
  if(pid2 == 0)
    1bb9:	75 02                	jne    1bbd <preempt+0x3d>
    1bbb:	eb fe                	jmp    1bbb <preempt+0x3b>
    for(;;)
      ;

  pipe(pfds);
    1bbd:	8d 45 e0             	lea    -0x20(%ebp),%eax
    1bc0:	89 04 24             	mov    %eax,(%esp)
    1bc3:	e8 f0 23 00 00       	call   3fb8 <pipe>
  pid3 = fork();
    1bc8:	e8 d3 23 00 00       	call   3fa0 <fork>
  if(pid3 == 0){
    1bcd:	85 c0                	test   %eax,%eax
  if(pid2 == 0)
    for(;;)
      ;

  pipe(pfds);
  pid3 = fork();
    1bcf:	89 c3                	mov    %eax,%ebx
  if(pid3 == 0){
    1bd1:	75 4c                	jne    1c1f <preempt+0x9f>
    close(pfds[0]);
    1bd3:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1bd6:	89 04 24             	mov    %eax,(%esp)
    1bd9:	e8 f2 23 00 00       	call   3fd0 <close>
    if(write(pfds[1], "x", 1) != 1)
    1bde:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1be1:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    1be8:	00 
    1be9:	c7 44 24 04 85 50 00 	movl   $0x5085,0x4(%esp)
    1bf0:	00 
    1bf1:	89 04 24             	mov    %eax,(%esp)
    1bf4:	e8 cf 23 00 00       	call   3fc8 <write>
    1bf9:	83 f8 01             	cmp    $0x1,%eax
    1bfc:	74 14                	je     1c12 <preempt+0x92>
      printf(1, "preempt write error");
    1bfe:	c7 44 24 04 50 4b 00 	movl   $0x4b50,0x4(%esp)
    1c05:	00 
    1c06:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1c0d:	e8 de 24 00 00       	call   40f0 <printf>
    close(pfds[1]);
    1c12:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1c15:	89 04 24             	mov    %eax,(%esp)
    1c18:	e8 b3 23 00 00       	call   3fd0 <close>
    1c1d:	eb fe                	jmp    1c1d <preempt+0x9d>
    for(;;)
      ;
  }

  close(pfds[1]);
    1c1f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1c22:	89 04 24             	mov    %eax,(%esp)
    1c25:	e8 a6 23 00 00       	call   3fd0 <close>
  if(read(pfds[0], buf, sizeof(buf)) != 1){
    1c2a:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1c2d:	c7 44 24 08 00 20 00 	movl   $0x2000,0x8(%esp)
    1c34:	00 
    1c35:	c7 44 24 04 00 84 00 	movl   $0x8400,0x4(%esp)
    1c3c:	00 
    1c3d:	89 04 24             	mov    %eax,(%esp)
    1c40:	e8 7b 23 00 00       	call   3fc0 <read>
    1c45:	83 f8 01             	cmp    $0x1,%eax
    1c48:	74 1c                	je     1c66 <preempt+0xe6>
    printf(1, "preempt read error");
    1c4a:	c7 44 24 04 64 4b 00 	movl   $0x4b64,0x4(%esp)
    1c51:	00 
    1c52:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1c59:	e8 92 24 00 00       	call   40f0 <printf>
  printf(1, "wait... ");
  wait(0);
  wait(0);
  wait(0);
  printf(1, "preempt ok\n");
}
    1c5e:	83 c4 2c             	add    $0x2c,%esp
    1c61:	5b                   	pop    %ebx
    1c62:	5e                   	pop    %esi
    1c63:	5f                   	pop    %edi
    1c64:	5d                   	pop    %ebp
    1c65:	c3                   	ret    
  close(pfds[1]);
  if(read(pfds[0], buf, sizeof(buf)) != 1){
    printf(1, "preempt read error");
    return;
  }
  close(pfds[0]);
    1c66:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1c69:	89 04 24             	mov    %eax,(%esp)
    1c6c:	e8 5f 23 00 00       	call   3fd0 <close>
  printf(1, "kill... ");
    1c71:	c7 44 24 04 77 4b 00 	movl   $0x4b77,0x4(%esp)
    1c78:	00 
    1c79:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1c80:	e8 6b 24 00 00       	call   40f0 <printf>
  kill(pid1);
    1c85:	89 3c 24             	mov    %edi,(%esp)
    1c88:	e8 4b 23 00 00       	call   3fd8 <kill>
  kill(pid2);
    1c8d:	89 34 24             	mov    %esi,(%esp)
    1c90:	e8 43 23 00 00       	call   3fd8 <kill>
  kill(pid3);
    1c95:	89 1c 24             	mov    %ebx,(%esp)
    1c98:	e8 3b 23 00 00       	call   3fd8 <kill>
  printf(1, "wait... ");
    1c9d:	c7 44 24 04 80 4b 00 	movl   $0x4b80,0x4(%esp)
    1ca4:	00 
    1ca5:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1cac:	e8 3f 24 00 00       	call   40f0 <printf>
  wait(0);
    1cb1:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1cb8:	e8 f3 22 00 00       	call   3fb0 <wait>
  wait(0);
    1cbd:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1cc4:	e8 e7 22 00 00       	call   3fb0 <wait>
  wait(0);
    1cc9:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1cd0:	e8 db 22 00 00       	call   3fb0 <wait>
  printf(1, "preempt ok\n");
    1cd5:	c7 44 24 04 89 4b 00 	movl   $0x4b89,0x4(%esp)
    1cdc:	00 
    1cdd:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1ce4:	e8 07 24 00 00       	call   40f0 <printf>
    1ce9:	e9 70 ff ff ff       	jmp    1c5e <preempt+0xde>
    1cee:	66 90                	xchg   %ax,%ax

00001cf0 <pipe1>:

// simple fork and pipe read/write

void
pipe1(void)
{
    1cf0:	55                   	push   %ebp
    1cf1:	89 e5                	mov    %esp,%ebp
    1cf3:	57                   	push   %edi
    1cf4:	56                   	push   %esi
    1cf5:	53                   	push   %ebx
    1cf6:	83 ec 2c             	sub    $0x2c,%esp
  int fds[2], pid;
  int seq, i, n, cc, total;

  if(pipe(fds) != 0){
    1cf9:	8d 45 e0             	lea    -0x20(%ebp),%eax
    1cfc:	89 04 24             	mov    %eax,(%esp)
    1cff:	e8 b4 22 00 00       	call   3fb8 <pipe>
    1d04:	85 c0                	test   %eax,%eax
    1d06:	0f 85 49 01 00 00    	jne    1e55 <pipe1+0x165>
    printf(1, "pipe() failed\n");
    exit(0);
  }
  pid = fork();
    1d0c:	e8 8f 22 00 00       	call   3fa0 <fork>
  seq = 0;
  if(pid == 0){
    1d11:	83 f8 00             	cmp    $0x0,%eax
    1d14:	0f 84 80 00 00 00    	je     1d9a <pipe1+0xaa>
        printf(1, "pipe1 oops 1\n");
        exit(0);
      }
    }
    exit(0);
  } else if(pid > 0){
    1d1a:	0f 8e 55 01 00 00    	jle    1e75 <pipe1+0x185>
    close(fds[1]);
    1d20:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1d23:	31 ff                	xor    %edi,%edi
    1d25:	be 01 00 00 00       	mov    $0x1,%esi
    1d2a:	31 db                	xor    %ebx,%ebx
    1d2c:	89 04 24             	mov    %eax,(%esp)
    1d2f:	e8 9c 22 00 00       	call   3fd0 <close>
    total = 0;
    cc = 1;
    while((n = read(fds[0], buf, cc)) > 0){
    1d34:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1d37:	89 74 24 08          	mov    %esi,0x8(%esp)
    1d3b:	c7 44 24 04 00 84 00 	movl   $0x8400,0x4(%esp)
    1d42:	00 
    1d43:	89 04 24             	mov    %eax,(%esp)
    1d46:	e8 75 22 00 00       	call   3fc0 <read>
    1d4b:	85 c0                	test   %eax,%eax
    1d4d:	0f 8e b0 00 00 00    	jle    1e03 <pipe1+0x113>
    1d53:	31 d2                	xor    %edx,%edx
    1d55:	8d 76 00             	lea    0x0(%esi),%esi
      for(i = 0; i < n; i++){
        if((buf[i] & 0xff) != (seq++ & 0xff)){
    1d58:	38 9a 00 84 00 00    	cmp    %bl,0x8400(%edx)
    1d5e:	75 1e                	jne    1d7e <pipe1+0x8e>
  } else if(pid > 0){
    close(fds[1]);
    total = 0;
    cc = 1;
    while((n = read(fds[0], buf, cc)) > 0){
      for(i = 0; i < n; i++){
    1d60:	83 c2 01             	add    $0x1,%edx
        if((buf[i] & 0xff) != (seq++ & 0xff)){
    1d63:	83 c3 01             	add    $0x1,%ebx
  } else if(pid > 0){
    close(fds[1]);
    total = 0;
    cc = 1;
    while((n = read(fds[0], buf, cc)) > 0){
      for(i = 0; i < n; i++){
    1d66:	39 d0                	cmp    %edx,%eax
    1d68:	7f ee                	jg     1d58 <pipe1+0x68>
          printf(1, "pipe1 oops 2\n");
          return;
        }
      }
      total += n;
      cc = cc * 2;
    1d6a:	01 f6                	add    %esi,%esi
      if(cc > sizeof(buf))
    1d6c:	ba 00 20 00 00       	mov    $0x2000,%edx
    1d71:	81 fe 01 20 00 00    	cmp    $0x2001,%esi
    1d77:	0f 43 f2             	cmovae %edx,%esi
        if((buf[i] & 0xff) != (seq++ & 0xff)){
          printf(1, "pipe1 oops 2\n");
          return;
        }
      }
      total += n;
    1d7a:	01 c7                	add    %eax,%edi
    1d7c:	eb b6                	jmp    1d34 <pipe1+0x44>
    total = 0;
    cc = 1;
    while((n = read(fds[0], buf, cc)) > 0){
      for(i = 0; i < n; i++){
        if((buf[i] & 0xff) != (seq++ & 0xff)){
          printf(1, "pipe1 oops 2\n");
    1d7e:	c7 44 24 04 a3 4b 00 	movl   $0x4ba3,0x4(%esp)
    1d85:	00 
    1d86:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1d8d:	e8 5e 23 00 00       	call   40f0 <printf>
  } else {
    printf(1, "fork() failed\n");
    exit(0);
  }
  printf(1, "pipe1 ok\n");
}
    1d92:	83 c4 2c             	add    $0x2c,%esp
    1d95:	5b                   	pop    %ebx
    1d96:	5e                   	pop    %esi
    1d97:	5f                   	pop    %edi
    1d98:	5d                   	pop    %ebp
    1d99:	c3                   	ret    
    exit(0);
  }
  pid = fork();
  seq = 0;
  if(pid == 0){
    close(fds[0]);
    1d9a:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1d9d:	31 db                	xor    %ebx,%ebx
    1d9f:	89 04 24             	mov    %eax,(%esp)
    1da2:	e8 29 22 00 00       	call   3fd0 <close>
    for(n = 0; n < 5; n++){
    1da7:	31 c0                	xor    %eax,%eax
    1da9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      for(i = 0; i < 1033; i++)
        buf[i] = seq++;
    1db0:	8d 14 03             	lea    (%ebx,%eax,1),%edx
    1db3:	88 90 00 84 00 00    	mov    %dl,0x8400(%eax)
  pid = fork();
  seq = 0;
  if(pid == 0){
    close(fds[0]);
    for(n = 0; n < 5; n++){
      for(i = 0; i < 1033; i++)
    1db9:	83 c0 01             	add    $0x1,%eax
    1dbc:	3d 09 04 00 00       	cmp    $0x409,%eax
    1dc1:	75 ed                	jne    1db0 <pipe1+0xc0>
        buf[i] = seq++;
      if(write(fds[1], buf, 1033) != 1033){
    1dc3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  pid = fork();
  seq = 0;
  if(pid == 0){
    close(fds[0]);
    for(n = 0; n < 5; n++){
      for(i = 0; i < 1033; i++)
    1dc6:	81 c3 09 04 00 00    	add    $0x409,%ebx
        buf[i] = seq++;
      if(write(fds[1], buf, 1033) != 1033){
    1dcc:	c7 44 24 08 09 04 00 	movl   $0x409,0x8(%esp)
    1dd3:	00 
    1dd4:	c7 44 24 04 00 84 00 	movl   $0x8400,0x4(%esp)
    1ddb:	00 
    1ddc:	89 04 24             	mov    %eax,(%esp)
    1ddf:	e8 e4 21 00 00       	call   3fc8 <write>
    1de4:	3d 09 04 00 00       	cmp    $0x409,%eax
    1de9:	0f 85 a6 00 00 00    	jne    1e95 <pipe1+0x1a5>
  }
  pid = fork();
  seq = 0;
  if(pid == 0){
    close(fds[0]);
    for(n = 0; n < 5; n++){
    1def:	81 fb 2d 14 00 00    	cmp    $0x142d,%ebx
    1df5:	75 b0                	jne    1da7 <pipe1+0xb7>
      if(cc > sizeof(buf))
        cc = sizeof(buf);
    }
    if(total != 5 * 1033){
      printf(1, "pipe1 oops 3 total %d\n", total);
      exit(0);
    1df7:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1dfe:	e8 a5 21 00 00       	call   3fa8 <exit>
      total += n;
      cc = cc * 2;
      if(cc > sizeof(buf))
        cc = sizeof(buf);
    }
    if(total != 5 * 1033){
    1e03:	81 ff 2d 14 00 00    	cmp    $0x142d,%edi
    1e09:	75 30                	jne    1e3b <pipe1+0x14b>
      printf(1, "pipe1 oops 3 total %d\n", total);
      exit(0);
    }
    close(fds[0]);
    1e0b:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1e0e:	89 04 24             	mov    %eax,(%esp)
    1e11:	e8 ba 21 00 00       	call   3fd0 <close>
    wait(0);
    1e16:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1e1d:	e8 8e 21 00 00       	call   3fb0 <wait>
  } else {
    printf(1, "fork() failed\n");
    exit(0);
  }
  printf(1, "pipe1 ok\n");
    1e22:	c7 44 24 04 c8 4b 00 	movl   $0x4bc8,0x4(%esp)
    1e29:	00 
    1e2a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1e31:	e8 ba 22 00 00       	call   40f0 <printf>
    1e36:	e9 57 ff ff ff       	jmp    1d92 <pipe1+0xa2>
      cc = cc * 2;
      if(cc > sizeof(buf))
        cc = sizeof(buf);
    }
    if(total != 5 * 1033){
      printf(1, "pipe1 oops 3 total %d\n", total);
    1e3b:	89 7c 24 08          	mov    %edi,0x8(%esp)
    1e3f:	c7 44 24 04 b1 4b 00 	movl   $0x4bb1,0x4(%esp)
    1e46:	00 
    1e47:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1e4e:	e8 9d 22 00 00       	call   40f0 <printf>
    1e53:	eb a2                	jmp    1df7 <pipe1+0x107>
{
  int fds[2], pid;
  int seq, i, n, cc, total;

  if(pipe(fds) != 0){
    printf(1, "pipe() failed\n");
    1e55:	c7 44 24 04 0e 4b 00 	movl   $0x4b0e,0x4(%esp)
    1e5c:	00 
    1e5d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1e64:	e8 87 22 00 00       	call   40f0 <printf>
    exit(0);
    1e69:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1e70:	e8 33 21 00 00       	call   3fa8 <exit>
      exit(0);
    }
    close(fds[0]);
    wait(0);
  } else {
    printf(1, "fork() failed\n");
    1e75:	c7 44 24 04 d2 4b 00 	movl   $0x4bd2,0x4(%esp)
    1e7c:	00 
    1e7d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1e84:	e8 67 22 00 00       	call   40f0 <printf>
    exit(0);
    1e89:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1e90:	e8 13 21 00 00       	call   3fa8 <exit>
    close(fds[0]);
    for(n = 0; n < 5; n++){
      for(i = 0; i < 1033; i++)
        buf[i] = seq++;
      if(write(fds[1], buf, 1033) != 1033){
        printf(1, "pipe1 oops 1\n");
    1e95:	c7 44 24 04 95 4b 00 	movl   $0x4b95,0x4(%esp)
    1e9c:	00 
    1e9d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1ea4:	e8 47 22 00 00       	call   40f0 <printf>
        exit(0);
    1ea9:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1eb0:	e8 f3 20 00 00       	call   3fa8 <exit>
    1eb5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1eb9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001ec0 <fourteen>:
  printf(1, "bigfile test ok\n");
}

void
fourteen(void)
{
    1ec0:	55                   	push   %ebp
    1ec1:	89 e5                	mov    %esp,%ebp
    1ec3:	83 ec 18             	sub    $0x18,%esp
  int fd;

  // DIRSIZ is 14.
  printf(1, "fourteen test\n");
    1ec6:	c7 44 24 04 e1 4b 00 	movl   $0x4be1,0x4(%esp)
    1ecd:	00 
    1ece:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1ed5:	e8 16 22 00 00       	call   40f0 <printf>

  if(mkdir("12345678901234") != 0){
    1eda:	c7 04 24 1c 4c 00 00 	movl   $0x4c1c,(%esp)
    1ee1:	e8 2a 21 00 00       	call   4010 <mkdir>
    1ee6:	85 c0                	test   %eax,%eax
    1ee8:	0f 85 92 00 00 00    	jne    1f80 <fourteen+0xc0>
    printf(1, "mkdir 12345678901234 failed\n");
    exit(0);
  }
  if(mkdir("12345678901234/123456789012345") != 0){
    1eee:	c7 04 24 e0 57 00 00 	movl   $0x57e0,(%esp)
    1ef5:	e8 16 21 00 00       	call   4010 <mkdir>
    1efa:	85 c0                	test   %eax,%eax
    1efc:	0f 85 1e 01 00 00    	jne    2020 <fourteen+0x160>
    printf(1, "mkdir 12345678901234/123456789012345 failed\n");
    exit(0);
  }
  fd = open("123456789012345/123456789012345/123456789012345", O_CREATE);
    1f02:	c7 44 24 04 00 02 00 	movl   $0x200,0x4(%esp)
    1f09:	00 
    1f0a:	c7 04 24 30 58 00 00 	movl   $0x5830,(%esp)
    1f11:	e8 d2 20 00 00       	call   3fe8 <open>
  if(fd < 0){
    1f16:	85 c0                	test   %eax,%eax
    1f18:	0f 88 e2 00 00 00    	js     2000 <fourteen+0x140>
    printf(1, "create 123456789012345/123456789012345/123456789012345 failed\n");
    exit(0);
  }
  close(fd);
    1f1e:	89 04 24             	mov    %eax,(%esp)
    1f21:	e8 aa 20 00 00       	call   3fd0 <close>
  fd = open("12345678901234/12345678901234/12345678901234", 0);
    1f26:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1f2d:	00 
    1f2e:	c7 04 24 a0 58 00 00 	movl   $0x58a0,(%esp)
    1f35:	e8 ae 20 00 00       	call   3fe8 <open>
  if(fd < 0){
    1f3a:	85 c0                	test   %eax,%eax
    1f3c:	0f 88 9e 00 00 00    	js     1fe0 <fourteen+0x120>
    printf(1, "open 12345678901234/12345678901234/12345678901234 failed\n");
    exit(0);
  }
  close(fd);
    1f42:	89 04 24             	mov    %eax,(%esp)
    1f45:	e8 86 20 00 00       	call   3fd0 <close>

  if(mkdir("12345678901234/12345678901234") == 0){
    1f4a:	c7 04 24 0d 4c 00 00 	movl   $0x4c0d,(%esp)
    1f51:	e8 ba 20 00 00       	call   4010 <mkdir>
    1f56:	85 c0                	test   %eax,%eax
    1f58:	74 66                	je     1fc0 <fourteen+0x100>
    printf(1, "mkdir 12345678901234/12345678901234 succeeded!\n");
    exit(0);
  }
  if(mkdir("123456789012345/12345678901234") == 0){
    1f5a:	c7 04 24 3c 59 00 00 	movl   $0x593c,(%esp)
    1f61:	e8 aa 20 00 00       	call   4010 <mkdir>
    1f66:	85 c0                	test   %eax,%eax
    1f68:	74 36                	je     1fa0 <fourteen+0xe0>
    printf(1, "mkdir 12345678901234/123456789012345 succeeded!\n");
    exit(0);
  }

  printf(1, "fourteen ok\n");
    1f6a:	c7 44 24 04 2b 4c 00 	movl   $0x4c2b,0x4(%esp)
    1f71:	00 
    1f72:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1f79:	e8 72 21 00 00       	call   40f0 <printf>
}
    1f7e:	c9                   	leave  
    1f7f:	c3                   	ret    

  // DIRSIZ is 14.
  printf(1, "fourteen test\n");

  if(mkdir("12345678901234") != 0){
    printf(1, "mkdir 12345678901234 failed\n");
    1f80:	c7 44 24 04 f0 4b 00 	movl   $0x4bf0,0x4(%esp)
    1f87:	00 
    1f88:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1f8f:	e8 5c 21 00 00       	call   40f0 <printf>
    exit(0);
    1f94:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1f9b:	e8 08 20 00 00       	call   3fa8 <exit>
  if(mkdir("12345678901234/12345678901234") == 0){
    printf(1, "mkdir 12345678901234/12345678901234 succeeded!\n");
    exit(0);
  }
  if(mkdir("123456789012345/12345678901234") == 0){
    printf(1, "mkdir 12345678901234/123456789012345 succeeded!\n");
    1fa0:	c7 44 24 04 5c 59 00 	movl   $0x595c,0x4(%esp)
    1fa7:	00 
    1fa8:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1faf:	e8 3c 21 00 00       	call   40f0 <printf>
    exit(0);
    1fb4:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1fbb:	e8 e8 1f 00 00       	call   3fa8 <exit>
    exit(0);
  }
  close(fd);

  if(mkdir("12345678901234/12345678901234") == 0){
    printf(1, "mkdir 12345678901234/12345678901234 succeeded!\n");
    1fc0:	c7 44 24 04 0c 59 00 	movl   $0x590c,0x4(%esp)
    1fc7:	00 
    1fc8:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1fcf:	e8 1c 21 00 00       	call   40f0 <printf>
    exit(0);
    1fd4:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1fdb:	e8 c8 1f 00 00       	call   3fa8 <exit>
    exit(0);
  }
  close(fd);
  fd = open("12345678901234/12345678901234/12345678901234", 0);
  if(fd < 0){
    printf(1, "open 12345678901234/12345678901234/12345678901234 failed\n");
    1fe0:	c7 44 24 04 d0 58 00 	movl   $0x58d0,0x4(%esp)
    1fe7:	00 
    1fe8:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1fef:	e8 fc 20 00 00       	call   40f0 <printf>
    exit(0);
    1ff4:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1ffb:	e8 a8 1f 00 00       	call   3fa8 <exit>
    printf(1, "mkdir 12345678901234/123456789012345 failed\n");
    exit(0);
  }
  fd = open("123456789012345/123456789012345/123456789012345", O_CREATE);
  if(fd < 0){
    printf(1, "create 123456789012345/123456789012345/123456789012345 failed\n");
    2000:	c7 44 24 04 60 58 00 	movl   $0x5860,0x4(%esp)
    2007:	00 
    2008:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    200f:	e8 dc 20 00 00       	call   40f0 <printf>
    exit(0);
    2014:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    201b:	e8 88 1f 00 00       	call   3fa8 <exit>
  if(mkdir("12345678901234") != 0){
    printf(1, "mkdir 12345678901234 failed\n");
    exit(0);
  }
  if(mkdir("12345678901234/123456789012345") != 0){
    printf(1, "mkdir 12345678901234/123456789012345 failed\n");
    2020:	c7 44 24 04 00 58 00 	movl   $0x5800,0x4(%esp)
    2027:	00 
    2028:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    202f:	e8 bc 20 00 00       	call   40f0 <printf>
    exit(0);
    2034:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    203b:	e8 68 1f 00 00       	call   3fa8 <exit>

00002040 <openiputtest>:
//      for(i = 0; i < 10000; i++)
//        yield();
//    }
void
openiputtest(void)
{
    2040:	55                   	push   %ebp
    2041:	89 e5                	mov    %esp,%ebp
    2043:	83 ec 18             	sub    $0x18,%esp
  int pid;

  printf(stdout, "openiput test\n");
    2046:	a1 1c 5c 00 00       	mov    0x5c1c,%eax
    204b:	c7 44 24 04 38 4c 00 	movl   $0x4c38,0x4(%esp)
    2052:	00 
    2053:	89 04 24             	mov    %eax,(%esp)
    2056:	e8 95 20 00 00       	call   40f0 <printf>
  if(mkdir("oidir") < 0){
    205b:	c7 04 24 47 4c 00 00 	movl   $0x4c47,(%esp)
    2062:	e8 a9 1f 00 00       	call   4010 <mkdir>
    2067:	85 c0                	test   %eax,%eax
    2069:	0f 88 90 00 00 00    	js     20ff <openiputtest+0xbf>
    printf(stdout, "mkdir oidir failed\n");
    exit(0);
  }
  pid = fork();
    206f:	e8 2c 1f 00 00       	call   3fa0 <fork>
  if(pid < 0){
    2074:	83 f8 00             	cmp    $0x0,%eax
    2077:	0f 8c a7 00 00 00    	jl     2124 <openiputtest+0xe4>
    207d:	8d 76 00             	lea    0x0(%esi),%esi
    printf(stdout, "fork failed\n");
    exit(0);
  }
  if(pid == 0){
    2080:	75 3e                	jne    20c0 <openiputtest+0x80>
    int fd = open("oidir", O_RDWR);
    2082:	c7 44 24 04 02 00 00 	movl   $0x2,0x4(%esp)
    2089:	00 
    208a:	c7 04 24 47 4c 00 00 	movl   $0x4c47,(%esp)
    2091:	e8 52 1f 00 00       	call   3fe8 <open>
    if(fd >= 0){
    2096:	85 c0                	test   %eax,%eax
    2098:	78 7e                	js     2118 <openiputtest+0xd8>
      printf(stdout, "open directory for write succeeded\n");
    209a:	a1 1c 5c 00 00       	mov    0x5c1c,%eax
    209f:	c7 44 24 04 90 59 00 	movl   $0x5990,0x4(%esp)
    20a6:	00 
    20a7:	89 04 24             	mov    %eax,(%esp)
    20aa:	e8 41 20 00 00       	call   40f0 <printf>
      exit(0);
    20af:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    20b6:	e8 ed 1e 00 00       	call   3fa8 <exit>
    20bb:	90                   	nop
    20bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    }
    exit(0);
  }
  sleep(1);
    20c0:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    20c7:	e8 6c 1f 00 00       	call   4038 <sleep>
  if(unlink("oidir") != 0){
    20cc:	c7 04 24 47 4c 00 00 	movl   $0x4c47,(%esp)
    20d3:	e8 20 1f 00 00       	call   3ff8 <unlink>
    20d8:	85 c0                	test   %eax,%eax
    20da:	75 52                	jne    212e <openiputtest+0xee>
    printf(stdout, "unlink failed\n");
    exit(0);
  }
  wait(0);
    20dc:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    20e3:	e8 c8 1e 00 00       	call   3fb0 <wait>
  printf(stdout, "openiput test ok\n");
    20e8:	a1 1c 5c 00 00       	mov    0x5c1c,%eax
    20ed:	c7 44 24 04 61 4c 00 	movl   $0x4c61,0x4(%esp)
    20f4:	00 
    20f5:	89 04 24             	mov    %eax,(%esp)
    20f8:	e8 f3 1f 00 00       	call   40f0 <printf>
}
    20fd:	c9                   	leave  
    20fe:	c3                   	ret    
{
  int pid;

  printf(stdout, "openiput test\n");
  if(mkdir("oidir") < 0){
    printf(stdout, "mkdir oidir failed\n");
    20ff:	c7 44 24 04 4d 4c 00 	movl   $0x4c4d,0x4(%esp)
    2106:	00 
    exit(0);
  }
  pid = fork();
  if(pid < 0){
    printf(stdout, "fork failed\n");
    2107:	a1 1c 5c 00 00       	mov    0x5c1c,%eax
    210c:	89 04 24             	mov    %eax,(%esp)
    210f:	e8 dc 1f 00 00       	call   40f0 <printf>
    2114:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    exit(0);
    2118:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    211f:	e8 84 1e 00 00       	call   3fa8 <exit>
    printf(stdout, "mkdir oidir failed\n");
    exit(0);
  }
  pid = fork();
  if(pid < 0){
    printf(stdout, "fork failed\n");
    2124:	c7 44 24 04 cf 48 00 	movl   $0x48cf,0x4(%esp)
    212b:	00 
    212c:	eb d9                	jmp    2107 <openiputtest+0xc7>
    }
    exit(0);
  }
  sleep(1);
  if(unlink("oidir") != 0){
    printf(stdout, "unlink failed\n");
    212e:	c7 44 24 04 ee 46 00 	movl   $0x46ee,0x4(%esp)
    2135:	00 
    2136:	eb cf                	jmp    2107 <openiputtest+0xc7>
    2138:	90                   	nop
    2139:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00002140 <iref>:
}

// test that iput() is called at the end of _namei()
void
iref(void)
{
    2140:	55                   	push   %ebp
    2141:	89 e5                	mov    %esp,%ebp
    2143:	53                   	push   %ebx
  int i, fd;

  printf(1, "empty file name\n");
    2144:	31 db                	xor    %ebx,%ebx
}

// test that iput() is called at the end of _namei()
void
iref(void)
{
    2146:	83 ec 14             	sub    $0x14,%esp
  int i, fd;

  printf(1, "empty file name\n");
    2149:	c7 44 24 04 73 4c 00 	movl   $0x4c73,0x4(%esp)
    2150:	00 
    2151:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2158:	e8 93 1f 00 00       	call   40f0 <printf>
    215d:	8d 76 00             	lea    0x0(%esi),%esi

  // the 50 is NINODE
  for(i = 0; i < 50 + 1; i++){
    if(mkdir("irefd") != 0){
    2160:	c7 04 24 84 4c 00 00 	movl   $0x4c84,(%esp)
    2167:	e8 a4 1e 00 00       	call   4010 <mkdir>
    216c:	85 c0                	test   %eax,%eax
    216e:	0f 85 b2 00 00 00    	jne    2226 <iref+0xe6>
      printf(1, "mkdir irefd failed\n");
      exit(0);
    }
    if(chdir("irefd") != 0){
    2174:	c7 04 24 84 4c 00 00 	movl   $0x4c84,(%esp)
    217b:	e8 98 1e 00 00       	call   4018 <chdir>
    2180:	85 c0                	test   %eax,%eax
    2182:	0f 85 be 00 00 00    	jne    2246 <iref+0x106>
      printf(1, "chdir irefd failed\n");
      exit(0);
    }

    mkdir("");
    2188:	c7 04 24 3d 54 00 00 	movl   $0x543d,(%esp)
    218f:	e8 7c 1e 00 00       	call   4010 <mkdir>
    link("README", "");
    2194:	c7 44 24 04 3d 54 00 	movl   $0x543d,0x4(%esp)
    219b:	00 
    219c:	c7 04 24 b2 4c 00 00 	movl   $0x4cb2,(%esp)
    21a3:	e8 60 1e 00 00       	call   4008 <link>
    fd = open("", O_CREATE);
    21a8:	c7 44 24 04 00 02 00 	movl   $0x200,0x4(%esp)
    21af:	00 
    21b0:	c7 04 24 3d 54 00 00 	movl   $0x543d,(%esp)
    21b7:	e8 2c 1e 00 00       	call   3fe8 <open>
    if(fd >= 0)
    21bc:	85 c0                	test   %eax,%eax
    21be:	78 08                	js     21c8 <iref+0x88>
      close(fd);
    21c0:	89 04 24             	mov    %eax,(%esp)
    21c3:	e8 08 1e 00 00       	call   3fd0 <close>
    fd = open("xx", O_CREATE);
    21c8:	c7 44 24 04 00 02 00 	movl   $0x200,0x4(%esp)
    21cf:	00 
    21d0:	c7 04 24 84 50 00 00 	movl   $0x5084,(%esp)
    21d7:	e8 0c 1e 00 00       	call   3fe8 <open>
    if(fd >= 0)
    21dc:	85 c0                	test   %eax,%eax
    21de:	78 08                	js     21e8 <iref+0xa8>
      close(fd);
    21e0:	89 04 24             	mov    %eax,(%esp)
    21e3:	e8 e8 1d 00 00       	call   3fd0 <close>
  int i, fd;

  printf(1, "empty file name\n");

  // the 50 is NINODE
  for(i = 0; i < 50 + 1; i++){
    21e8:	83 c3 01             	add    $0x1,%ebx
    if(fd >= 0)
      close(fd);
    fd = open("xx", O_CREATE);
    if(fd >= 0)
      close(fd);
    unlink("xx");
    21eb:	c7 04 24 84 50 00 00 	movl   $0x5084,(%esp)
    21f2:	e8 01 1e 00 00       	call   3ff8 <unlink>
  int i, fd;

  printf(1, "empty file name\n");

  // the 50 is NINODE
  for(i = 0; i < 50 + 1; i++){
    21f7:	83 fb 33             	cmp    $0x33,%ebx
    21fa:	0f 85 60 ff ff ff    	jne    2160 <iref+0x20>
    if(fd >= 0)
      close(fd);
    unlink("xx");
  }

  chdir("/");
    2200:	c7 04 24 b9 4c 00 00 	movl   $0x4cb9,(%esp)
    2207:	e8 0c 1e 00 00       	call   4018 <chdir>
  printf(1, "empty file name OK\n");
    220c:	c7 44 24 04 bb 4c 00 	movl   $0x4cbb,0x4(%esp)
    2213:	00 
    2214:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    221b:	e8 d0 1e 00 00       	call   40f0 <printf>
}
    2220:	83 c4 14             	add    $0x14,%esp
    2223:	5b                   	pop    %ebx
    2224:	5d                   	pop    %ebp
    2225:	c3                   	ret    
  printf(1, "empty file name\n");

  // the 50 is NINODE
  for(i = 0; i < 50 + 1; i++){
    if(mkdir("irefd") != 0){
      printf(1, "mkdir irefd failed\n");
    2226:	c7 44 24 04 8a 4c 00 	movl   $0x4c8a,0x4(%esp)
    222d:	00 
    222e:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2235:	e8 b6 1e 00 00       	call   40f0 <printf>
      exit(0);
    223a:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2241:	e8 62 1d 00 00       	call   3fa8 <exit>
    }
    if(chdir("irefd") != 0){
      printf(1, "chdir irefd failed\n");
    2246:	c7 44 24 04 9e 4c 00 	movl   $0x4c9e,0x4(%esp)
    224d:	00 
    224e:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2255:	e8 96 1e 00 00       	call   40f0 <printf>
      exit(0);
    225a:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2261:	e8 42 1d 00 00       	call   3fa8 <exit>
    2266:	8d 76 00             	lea    0x0(%esi),%esi
    2269:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00002270 <dirfile>:
  printf(1, "rmdot ok\n");
}

void
dirfile(void)
{
    2270:	55                   	push   %ebp
    2271:	89 e5                	mov    %esp,%ebp
    2273:	53                   	push   %ebx
    2274:	83 ec 14             	sub    $0x14,%esp
  int fd;

  printf(1, "dir vs file\n");
    2277:	c7 44 24 04 cf 4c 00 	movl   $0x4ccf,0x4(%esp)
    227e:	00 
    227f:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2286:	e8 65 1e 00 00       	call   40f0 <printf>

  fd = open("dirfile", O_CREATE);
    228b:	c7 44 24 04 00 02 00 	movl   $0x200,0x4(%esp)
    2292:	00 
    2293:	c7 04 24 dc 4c 00 00 	movl   $0x4cdc,(%esp)
    229a:	e8 49 1d 00 00       	call   3fe8 <open>
  if(fd < 0){
    229f:	85 c0                	test   %eax,%eax
    22a1:	0f 88 60 01 00 00    	js     2407 <dirfile+0x197>
    printf(1, "create dirfile failed\n");
    exit(0);
  }
  close(fd);
    22a7:	89 04 24             	mov    %eax,(%esp)
    22aa:	e8 21 1d 00 00       	call   3fd0 <close>
  if(chdir("dirfile") == 0){
    22af:	c7 04 24 dc 4c 00 00 	movl   $0x4cdc,(%esp)
    22b6:	e8 5d 1d 00 00       	call   4018 <chdir>
    22bb:	85 c0                	test   %eax,%eax
    22bd:	0f 84 24 01 00 00    	je     23e7 <dirfile+0x177>
    printf(1, "chdir dirfile succeeded!\n");
    exit(0);
  }
  fd = open("dirfile/xx", 0);
    22c3:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    22ca:	00 
    22cb:	c7 04 24 15 4d 00 00 	movl   $0x4d15,(%esp)
    22d2:	e8 11 1d 00 00       	call   3fe8 <open>
  if(fd >= 0){
    22d7:	85 c0                	test   %eax,%eax
    22d9:	0f 89 e8 00 00 00    	jns    23c7 <dirfile+0x157>
    printf(1, "create dirfile/xx succeeded!\n");
    exit(0);
  }
  fd = open("dirfile/xx", O_CREATE);
    22df:	c7 44 24 04 00 02 00 	movl   $0x200,0x4(%esp)
    22e6:	00 
    22e7:	c7 04 24 15 4d 00 00 	movl   $0x4d15,(%esp)
    22ee:	e8 f5 1c 00 00       	call   3fe8 <open>
  if(fd >= 0){
    22f3:	85 c0                	test   %eax,%eax
    22f5:	0f 89 cc 00 00 00    	jns    23c7 <dirfile+0x157>
    printf(1, "create dirfile/xx succeeded!\n");
    exit(0);
  }
  if(mkdir("dirfile/xx") == 0){
    22fb:	c7 04 24 15 4d 00 00 	movl   $0x4d15,(%esp)
    2302:	e8 09 1d 00 00       	call   4010 <mkdir>
    2307:	85 c0                	test   %eax,%eax
    2309:	0f 84 b8 01 00 00    	je     24c7 <dirfile+0x257>
    printf(1, "mkdir dirfile/xx succeeded!\n");
    exit(0);
  }
  if(unlink("dirfile/xx") == 0){
    230f:	c7 04 24 15 4d 00 00 	movl   $0x4d15,(%esp)
    2316:	e8 dd 1c 00 00       	call   3ff8 <unlink>
    231b:	85 c0                	test   %eax,%eax
    231d:	0f 84 84 01 00 00    	je     24a7 <dirfile+0x237>
    printf(1, "unlink dirfile/xx succeeded!\n");
    exit(0);
  }
  if(link("README", "dirfile/xx") == 0){
    2323:	c7 44 24 04 15 4d 00 	movl   $0x4d15,0x4(%esp)
    232a:	00 
    232b:	c7 04 24 b2 4c 00 00 	movl   $0x4cb2,(%esp)
    2332:	e8 d1 1c 00 00       	call   4008 <link>
    2337:	85 c0                	test   %eax,%eax
    2339:	0f 84 48 01 00 00    	je     2487 <dirfile+0x217>
    printf(1, "link to dirfile/xx succeeded!\n");
    exit(0);
  }
  if(unlink("dirfile") != 0){
    233f:	c7 04 24 dc 4c 00 00 	movl   $0x4cdc,(%esp)
    2346:	e8 ad 1c 00 00       	call   3ff8 <unlink>
    234b:	85 c0                	test   %eax,%eax
    234d:	0f 85 14 01 00 00    	jne    2467 <dirfile+0x1f7>
    printf(1, "unlink dirfile failed!\n");
    exit(0);
  }

  fd = open(".", O_RDWR);
    2353:	c7 44 24 04 02 00 00 	movl   $0x2,0x4(%esp)
    235a:	00 
    235b:	c7 04 24 a2 4f 00 00 	movl   $0x4fa2,(%esp)
    2362:	e8 81 1c 00 00       	call   3fe8 <open>
  if(fd >= 0){
    2367:	85 c0                	test   %eax,%eax
    2369:	0f 89 d8 00 00 00    	jns    2447 <dirfile+0x1d7>
    printf(1, "open . for writing succeeded!\n");
    exit(0);
  }
  fd = open(".", 0);
    236f:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    2376:	00 
    2377:	c7 04 24 a2 4f 00 00 	movl   $0x4fa2,(%esp)
    237e:	e8 65 1c 00 00       	call   3fe8 <open>
  if(write(fd, "x", 1) > 0){
    2383:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    238a:	00 
    238b:	c7 44 24 04 85 50 00 	movl   $0x5085,0x4(%esp)
    2392:	00 
  fd = open(".", O_RDWR);
  if(fd >= 0){
    printf(1, "open . for writing succeeded!\n");
    exit(0);
  }
  fd = open(".", 0);
    2393:	89 c3                	mov    %eax,%ebx
  if(write(fd, "x", 1) > 0){
    2395:	89 04 24             	mov    %eax,(%esp)
    2398:	e8 2b 1c 00 00       	call   3fc8 <write>
    239d:	85 c0                	test   %eax,%eax
    239f:	0f 8f 82 00 00 00    	jg     2427 <dirfile+0x1b7>
    printf(1, "write . succeeded!\n");
    exit(0);
  }
  close(fd);
    23a5:	89 1c 24             	mov    %ebx,(%esp)
    23a8:	e8 23 1c 00 00       	call   3fd0 <close>

  printf(1, "dir vs file OK\n");
    23ad:	c7 44 24 04 a5 4d 00 	movl   $0x4da5,0x4(%esp)
    23b4:	00 
    23b5:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    23bc:	e8 2f 1d 00 00       	call   40f0 <printf>
}
    23c1:	83 c4 14             	add    $0x14,%esp
    23c4:	5b                   	pop    %ebx
    23c5:	5d                   	pop    %ebp
    23c6:	c3                   	ret    
    printf(1, "create dirfile/xx succeeded!\n");
    exit(0);
  }
  fd = open("dirfile/xx", O_CREATE);
  if(fd >= 0){
    printf(1, "create dirfile/xx succeeded!\n");
    23c7:	c7 44 24 04 20 4d 00 	movl   $0x4d20,0x4(%esp)
    23ce:	00 
    23cf:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    23d6:	e8 15 1d 00 00       	call   40f0 <printf>
    exit(0);
    23db:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    23e2:	e8 c1 1b 00 00       	call   3fa8 <exit>
    printf(1, "create dirfile failed\n");
    exit(0);
  }
  close(fd);
  if(chdir("dirfile") == 0){
    printf(1, "chdir dirfile succeeded!\n");
    23e7:	c7 44 24 04 fb 4c 00 	movl   $0x4cfb,0x4(%esp)
    23ee:	00 
    23ef:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    23f6:	e8 f5 1c 00 00       	call   40f0 <printf>
    exit(0);
    23fb:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2402:	e8 a1 1b 00 00       	call   3fa8 <exit>

  printf(1, "dir vs file\n");

  fd = open("dirfile", O_CREATE);
  if(fd < 0){
    printf(1, "create dirfile failed\n");
    2407:	c7 44 24 04 e4 4c 00 	movl   $0x4ce4,0x4(%esp)
    240e:	00 
    240f:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2416:	e8 d5 1c 00 00       	call   40f0 <printf>
    exit(0);
    241b:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2422:	e8 81 1b 00 00       	call   3fa8 <exit>
    printf(1, "open . for writing succeeded!\n");
    exit(0);
  }
  fd = open(".", 0);
  if(write(fd, "x", 1) > 0){
    printf(1, "write . succeeded!\n");
    2427:	c7 44 24 04 91 4d 00 	movl   $0x4d91,0x4(%esp)
    242e:	00 
    242f:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2436:	e8 b5 1c 00 00       	call   40f0 <printf>
    exit(0);
    243b:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2442:	e8 61 1b 00 00       	call   3fa8 <exit>
    exit(0);
  }

  fd = open(".", O_RDWR);
  if(fd >= 0){
    printf(1, "open . for writing succeeded!\n");
    2447:	c7 44 24 04 d4 59 00 	movl   $0x59d4,0x4(%esp)
    244e:	00 
    244f:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2456:	e8 95 1c 00 00       	call   40f0 <printf>
    exit(0);
    245b:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2462:	e8 41 1b 00 00       	call   3fa8 <exit>
  if(link("README", "dirfile/xx") == 0){
    printf(1, "link to dirfile/xx succeeded!\n");
    exit(0);
  }
  if(unlink("dirfile") != 0){
    printf(1, "unlink dirfile failed!\n");
    2467:	c7 44 24 04 79 4d 00 	movl   $0x4d79,0x4(%esp)
    246e:	00 
    246f:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2476:	e8 75 1c 00 00       	call   40f0 <printf>
    exit(0);
    247b:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2482:	e8 21 1b 00 00       	call   3fa8 <exit>
  if(unlink("dirfile/xx") == 0){
    printf(1, "unlink dirfile/xx succeeded!\n");
    exit(0);
  }
  if(link("README", "dirfile/xx") == 0){
    printf(1, "link to dirfile/xx succeeded!\n");
    2487:	c7 44 24 04 b4 59 00 	movl   $0x59b4,0x4(%esp)
    248e:	00 
    248f:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2496:	e8 55 1c 00 00       	call   40f0 <printf>
    exit(0);
    249b:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    24a2:	e8 01 1b 00 00       	call   3fa8 <exit>
  if(mkdir("dirfile/xx") == 0){
    printf(1, "mkdir dirfile/xx succeeded!\n");
    exit(0);
  }
  if(unlink("dirfile/xx") == 0){
    printf(1, "unlink dirfile/xx succeeded!\n");
    24a7:	c7 44 24 04 5b 4d 00 	movl   $0x4d5b,0x4(%esp)
    24ae:	00 
    24af:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    24b6:	e8 35 1c 00 00       	call   40f0 <printf>
    exit(0);
    24bb:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    24c2:	e8 e1 1a 00 00       	call   3fa8 <exit>
  if(fd >= 0){
    printf(1, "create dirfile/xx succeeded!\n");
    exit(0);
  }
  if(mkdir("dirfile/xx") == 0){
    printf(1, "mkdir dirfile/xx succeeded!\n");
    24c7:	c7 44 24 04 3e 4d 00 	movl   $0x4d3e,0x4(%esp)
    24ce:	00 
    24cf:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    24d6:	e8 15 1c 00 00       	call   40f0 <printf>
    exit(0);
    24db:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    24e2:	e8 c1 1a 00 00       	call   3fa8 <exit>
    24e7:	89 f6                	mov    %esi,%esi
    24e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000024f0 <rmdot>:
  printf(1, "fourteen ok\n");
}

void
rmdot(void)
{
    24f0:	55                   	push   %ebp
    24f1:	89 e5                	mov    %esp,%ebp
    24f3:	83 ec 18             	sub    $0x18,%esp
  printf(1, "rmdot test\n");
    24f6:	c7 44 24 04 b5 4d 00 	movl   $0x4db5,0x4(%esp)
    24fd:	00 
    24fe:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2505:	e8 e6 1b 00 00       	call   40f0 <printf>
  if(mkdir("dots") != 0){
    250a:	c7 04 24 c1 4d 00 00 	movl   $0x4dc1,(%esp)
    2511:	e8 fa 1a 00 00       	call   4010 <mkdir>
    2516:	85 c0                	test   %eax,%eax
    2518:	0f 85 9a 00 00 00    	jne    25b8 <rmdot+0xc8>
    printf(1, "mkdir dots failed\n");
    exit(0);
  }
  if(chdir("dots") != 0){
    251e:	c7 04 24 c1 4d 00 00 	movl   $0x4dc1,(%esp)
    2525:	e8 ee 1a 00 00       	call   4018 <chdir>
    252a:	85 c0                	test   %eax,%eax
    252c:	0f 85 66 01 00 00    	jne    2698 <rmdot+0x1a8>
    printf(1, "chdir dots failed\n");
    exit(0);
  }
  if(unlink(".") == 0){
    2532:	c7 04 24 a2 4f 00 00 	movl   $0x4fa2,(%esp)
    2539:	e8 ba 1a 00 00       	call   3ff8 <unlink>
    253e:	85 c0                	test   %eax,%eax
    2540:	0f 84 32 01 00 00    	je     2678 <rmdot+0x188>
    printf(1, "rm . worked!\n");
    exit(0);
  }
  if(unlink("..") == 0){
    2546:	c7 04 24 a1 4f 00 00 	movl   $0x4fa1,(%esp)
    254d:	e8 a6 1a 00 00       	call   3ff8 <unlink>
    2552:	85 c0                	test   %eax,%eax
    2554:	0f 84 fe 00 00 00    	je     2658 <rmdot+0x168>
    printf(1, "rm .. worked!\n");
    exit(0);
  }
  if(chdir("/") != 0){
    255a:	c7 04 24 b9 4c 00 00 	movl   $0x4cb9,(%esp)
    2561:	e8 b2 1a 00 00       	call   4018 <chdir>
    2566:	85 c0                	test   %eax,%eax
    2568:	0f 85 ca 00 00 00    	jne    2638 <rmdot+0x148>
    printf(1, "chdir / failed\n");
    exit(0);
  }
  if(unlink("dots/.") == 0){
    256e:	c7 04 24 19 4e 00 00 	movl   $0x4e19,(%esp)
    2575:	e8 7e 1a 00 00       	call   3ff8 <unlink>
    257a:	85 c0                	test   %eax,%eax
    257c:	0f 84 96 00 00 00    	je     2618 <rmdot+0x128>
    printf(1, "unlink dots/. worked!\n");
    exit(0);
  }
  if(unlink("dots/..") == 0){
    2582:	c7 04 24 37 4e 00 00 	movl   $0x4e37,(%esp)
    2589:	e8 6a 1a 00 00       	call   3ff8 <unlink>
    258e:	85 c0                	test   %eax,%eax
    2590:	74 66                	je     25f8 <rmdot+0x108>
    printf(1, "unlink dots/.. worked!\n");
    exit(0);
  }
  if(unlink("dots") != 0){
    2592:	c7 04 24 c1 4d 00 00 	movl   $0x4dc1,(%esp)
    2599:	e8 5a 1a 00 00       	call   3ff8 <unlink>
    259e:	85 c0                	test   %eax,%eax
    25a0:	75 36                	jne    25d8 <rmdot+0xe8>
    printf(1, "unlink dots failed!\n");
    exit(0);
  }
  printf(1, "rmdot ok\n");
    25a2:	c7 44 24 04 6c 4e 00 	movl   $0x4e6c,0x4(%esp)
    25a9:	00 
    25aa:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    25b1:	e8 3a 1b 00 00       	call   40f0 <printf>
}
    25b6:	c9                   	leave  
    25b7:	c3                   	ret    
void
rmdot(void)
{
  printf(1, "rmdot test\n");
  if(mkdir("dots") != 0){
    printf(1, "mkdir dots failed\n");
    25b8:	c7 44 24 04 c6 4d 00 	movl   $0x4dc6,0x4(%esp)
    25bf:	00 
    25c0:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    25c7:	e8 24 1b 00 00       	call   40f0 <printf>
    exit(0);
    25cc:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    25d3:	e8 d0 19 00 00       	call   3fa8 <exit>
  if(unlink("dots/..") == 0){
    printf(1, "unlink dots/.. worked!\n");
    exit(0);
  }
  if(unlink("dots") != 0){
    printf(1, "unlink dots failed!\n");
    25d8:	c7 44 24 04 57 4e 00 	movl   $0x4e57,0x4(%esp)
    25df:	00 
    25e0:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    25e7:	e8 04 1b 00 00       	call   40f0 <printf>
    exit(0);
    25ec:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    25f3:	e8 b0 19 00 00       	call   3fa8 <exit>
  if(unlink("dots/.") == 0){
    printf(1, "unlink dots/. worked!\n");
    exit(0);
  }
  if(unlink("dots/..") == 0){
    printf(1, "unlink dots/.. worked!\n");
    25f8:	c7 44 24 04 3f 4e 00 	movl   $0x4e3f,0x4(%esp)
    25ff:	00 
    2600:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2607:	e8 e4 1a 00 00       	call   40f0 <printf>
    exit(0);
    260c:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2613:	e8 90 19 00 00       	call   3fa8 <exit>
  if(chdir("/") != 0){
    printf(1, "chdir / failed\n");
    exit(0);
  }
  if(unlink("dots/.") == 0){
    printf(1, "unlink dots/. worked!\n");
    2618:	c7 44 24 04 20 4e 00 	movl   $0x4e20,0x4(%esp)
    261f:	00 
    2620:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2627:	e8 c4 1a 00 00       	call   40f0 <printf>
    exit(0);
    262c:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2633:	e8 70 19 00 00       	call   3fa8 <exit>
  if(unlink("..") == 0){
    printf(1, "rm .. worked!\n");
    exit(0);
  }
  if(chdir("/") != 0){
    printf(1, "chdir / failed\n");
    2638:	c7 44 24 04 09 4e 00 	movl   $0x4e09,0x4(%esp)
    263f:	00 
    2640:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2647:	e8 a4 1a 00 00       	call   40f0 <printf>
    exit(0);
    264c:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2653:	e8 50 19 00 00       	call   3fa8 <exit>
  if(unlink(".") == 0){
    printf(1, "rm . worked!\n");
    exit(0);
  }
  if(unlink("..") == 0){
    printf(1, "rm .. worked!\n");
    2658:	c7 44 24 04 fa 4d 00 	movl   $0x4dfa,0x4(%esp)
    265f:	00 
    2660:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2667:	e8 84 1a 00 00       	call   40f0 <printf>
    exit(0);
    266c:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2673:	e8 30 19 00 00       	call   3fa8 <exit>
  if(chdir("dots") != 0){
    printf(1, "chdir dots failed\n");
    exit(0);
  }
  if(unlink(".") == 0){
    printf(1, "rm . worked!\n");
    2678:	c7 44 24 04 ec 4d 00 	movl   $0x4dec,0x4(%esp)
    267f:	00 
    2680:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2687:	e8 64 1a 00 00       	call   40f0 <printf>
    exit(0);
    268c:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2693:	e8 10 19 00 00       	call   3fa8 <exit>
  if(mkdir("dots") != 0){
    printf(1, "mkdir dots failed\n");
    exit(0);
  }
  if(chdir("dots") != 0){
    printf(1, "chdir dots failed\n");
    2698:	c7 44 24 04 d9 4d 00 	movl   $0x4dd9,0x4(%esp)
    269f:	00 
    26a0:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    26a7:	e8 44 1a 00 00       	call   40f0 <printf>
    exit(0);
    26ac:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    26b3:	e8 f0 18 00 00       	call   3fa8 <exit>
    26b8:	90                   	nop
    26b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000026c0 <subdir>:
  printf(1, "bigdir ok\n");
}

void
subdir(void)
{
    26c0:	55                   	push   %ebp
    26c1:	89 e5                	mov    %esp,%ebp
    26c3:	53                   	push   %ebx
    26c4:	83 ec 14             	sub    $0x14,%esp
  int fd, cc;

  printf(1, "subdir test\n");
    26c7:	c7 44 24 04 76 4e 00 	movl   $0x4e76,0x4(%esp)
    26ce:	00 
    26cf:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    26d6:	e8 15 1a 00 00       	call   40f0 <printf>

  unlink("ff");
    26db:	c7 04 24 ff 4e 00 00 	movl   $0x4eff,(%esp)
    26e2:	e8 11 19 00 00       	call   3ff8 <unlink>
  if(mkdir("dd") != 0){
    26e7:	c7 04 24 9c 4f 00 00 	movl   $0x4f9c,(%esp)
    26ee:	e8 1d 19 00 00       	call   4010 <mkdir>
    26f3:	85 c0                	test   %eax,%eax
    26f5:	0f 85 a1 06 00 00    	jne    2d9c <subdir+0x6dc>
    printf(1, "subdir mkdir dd failed\n");
    exit(0);
  }

  fd = open("dd/ff", O_CREATE | O_RDWR);
    26fb:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
    2702:	00 
    2703:	c7 04 24 d5 4e 00 00 	movl   $0x4ed5,(%esp)
    270a:	e8 d9 18 00 00       	call   3fe8 <open>
  if(fd < 0){
    270f:	85 c0                	test   %eax,%eax
  if(mkdir("dd") != 0){
    printf(1, "subdir mkdir dd failed\n");
    exit(0);
  }

  fd = open("dd/ff", O_CREATE | O_RDWR);
    2711:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    2713:	0f 88 63 06 00 00    	js     2d7c <subdir+0x6bc>
    printf(1, "create dd/ff failed\n");
    exit(0);
  }
  write(fd, "ff", 2);
    2719:	c7 44 24 08 02 00 00 	movl   $0x2,0x8(%esp)
    2720:	00 
    2721:	c7 44 24 04 ff 4e 00 	movl   $0x4eff,0x4(%esp)
    2728:	00 
    2729:	89 04 24             	mov    %eax,(%esp)
    272c:	e8 97 18 00 00       	call   3fc8 <write>
  close(fd);
    2731:	89 1c 24             	mov    %ebx,(%esp)
    2734:	e8 97 18 00 00       	call   3fd0 <close>

  if(unlink("dd") >= 0){
    2739:	c7 04 24 9c 4f 00 00 	movl   $0x4f9c,(%esp)
    2740:	e8 b3 18 00 00       	call   3ff8 <unlink>
    2745:	85 c0                	test   %eax,%eax
    2747:	0f 89 0f 06 00 00    	jns    2d5c <subdir+0x69c>
    printf(1, "unlink dd (non-empty dir) succeeded!\n");
    exit(0);
  }

  if(mkdir("/dd/dd") != 0){
    274d:	c7 04 24 b0 4e 00 00 	movl   $0x4eb0,(%esp)
    2754:	e8 b7 18 00 00       	call   4010 <mkdir>
    2759:	85 c0                	test   %eax,%eax
    275b:	0f 85 db 05 00 00    	jne    2d3c <subdir+0x67c>
    printf(1, "subdir mkdir dd/dd failed\n");
    exit(0);
  }

  fd = open("dd/dd/ff", O_CREATE | O_RDWR);
    2761:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
    2768:	00 
    2769:	c7 04 24 d2 4e 00 00 	movl   $0x4ed2,(%esp)
    2770:	e8 73 18 00 00       	call   3fe8 <open>
  if(fd < 0){
    2775:	85 c0                	test   %eax,%eax
  if(mkdir("/dd/dd") != 0){
    printf(1, "subdir mkdir dd/dd failed\n");
    exit(0);
  }

  fd = open("dd/dd/ff", O_CREATE | O_RDWR);
    2777:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    2779:	0f 88 5d 04 00 00    	js     2bdc <subdir+0x51c>
    printf(1, "create dd/dd/ff failed\n");
    exit(0);
  }
  write(fd, "FF", 2);
    277f:	c7 44 24 08 02 00 00 	movl   $0x2,0x8(%esp)
    2786:	00 
    2787:	c7 44 24 04 f3 4e 00 	movl   $0x4ef3,0x4(%esp)
    278e:	00 
    278f:	89 04 24             	mov    %eax,(%esp)
    2792:	e8 31 18 00 00       	call   3fc8 <write>
  close(fd);
    2797:	89 1c 24             	mov    %ebx,(%esp)
    279a:	e8 31 18 00 00       	call   3fd0 <close>

  fd = open("dd/dd/../ff", 0);
    279f:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    27a6:	00 
    27a7:	c7 04 24 f6 4e 00 00 	movl   $0x4ef6,(%esp)
    27ae:	e8 35 18 00 00       	call   3fe8 <open>
  if(fd < 0){
    27b3:	85 c0                	test   %eax,%eax
    exit(0);
  }
  write(fd, "FF", 2);
  close(fd);

  fd = open("dd/dd/../ff", 0);
    27b5:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    27b7:	0f 88 ff 03 00 00    	js     2bbc <subdir+0x4fc>
    printf(1, "open dd/dd/../ff failed\n");
    exit(0);
  }
  cc = read(fd, buf, sizeof(buf));
    27bd:	c7 44 24 08 00 20 00 	movl   $0x2000,0x8(%esp)
    27c4:	00 
    27c5:	c7 44 24 04 00 84 00 	movl   $0x8400,0x4(%esp)
    27cc:	00 
    27cd:	89 04 24             	mov    %eax,(%esp)
    27d0:	e8 eb 17 00 00       	call   3fc0 <read>
  if(cc != 2 || buf[0] != 'f'){
    27d5:	83 f8 02             	cmp    $0x2,%eax
    27d8:	0f 85 fe 02 00 00    	jne    2adc <subdir+0x41c>
    27de:	80 3d 00 84 00 00 66 	cmpb   $0x66,0x8400
    27e5:	0f 85 f1 02 00 00    	jne    2adc <subdir+0x41c>
    printf(1, "dd/dd/../ff wrong content\n");
    exit(0);
  }
  close(fd);
    27eb:	89 1c 24             	mov    %ebx,(%esp)
    27ee:	e8 dd 17 00 00       	call   3fd0 <close>

  if(link("dd/dd/ff", "dd/dd/ffff") != 0){
    27f3:	c7 44 24 04 36 4f 00 	movl   $0x4f36,0x4(%esp)
    27fa:	00 
    27fb:	c7 04 24 d2 4e 00 00 	movl   $0x4ed2,(%esp)
    2802:	e8 01 18 00 00       	call   4008 <link>
    2807:	85 c0                	test   %eax,%eax
    2809:	0f 85 0d 04 00 00    	jne    2c1c <subdir+0x55c>
    printf(1, "link dd/dd/ff dd/dd/ffff failed\n");
    exit(0);
  }

  if(unlink("dd/dd/ff") != 0){
    280f:	c7 04 24 d2 4e 00 00 	movl   $0x4ed2,(%esp)
    2816:	e8 dd 17 00 00       	call   3ff8 <unlink>
    281b:	85 c0                	test   %eax,%eax
    281d:	0f 85 f9 02 00 00    	jne    2b1c <subdir+0x45c>
    printf(1, "unlink dd/dd/ff failed\n");
    exit(0);
  }
  if(open("dd/dd/ff", O_RDONLY) >= 0){
    2823:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    282a:	00 
    282b:	c7 04 24 d2 4e 00 00 	movl   $0x4ed2,(%esp)
    2832:	e8 b1 17 00 00       	call   3fe8 <open>
    2837:	85 c0                	test   %eax,%eax
    2839:	0f 89 dd 04 00 00    	jns    2d1c <subdir+0x65c>
    printf(1, "open (unlinked) dd/dd/ff succeeded\n");
    exit(0);
  }

  if(chdir("dd") != 0){
    283f:	c7 04 24 9c 4f 00 00 	movl   $0x4f9c,(%esp)
    2846:	e8 cd 17 00 00       	call   4018 <chdir>
    284b:	85 c0                	test   %eax,%eax
    284d:	0f 85 a9 04 00 00    	jne    2cfc <subdir+0x63c>
    printf(1, "chdir dd failed\n");
    exit(0);
  }
  if(chdir("dd/../../dd") != 0){
    2853:	c7 04 24 6a 4f 00 00 	movl   $0x4f6a,(%esp)
    285a:	e8 b9 17 00 00       	call   4018 <chdir>
    285f:	85 c0                	test   %eax,%eax
    2861:	0f 85 95 02 00 00    	jne    2afc <subdir+0x43c>
    printf(1, "chdir dd/../../dd failed\n");
    exit(0);
  }
  if(chdir("dd/../../../dd") != 0){
    2867:	c7 04 24 90 4f 00 00 	movl   $0x4f90,(%esp)
    286e:	e8 a5 17 00 00       	call   4018 <chdir>
    2873:	85 c0                	test   %eax,%eax
    2875:	0f 85 81 02 00 00    	jne    2afc <subdir+0x43c>
    printf(1, "chdir dd/../../dd failed\n");
    exit(0);
  }
  if(chdir("./..") != 0){
    287b:	c7 04 24 9f 4f 00 00 	movl   $0x4f9f,(%esp)
    2882:	e8 91 17 00 00       	call   4018 <chdir>
    2887:	85 c0                	test   %eax,%eax
    2889:	0f 85 6d 03 00 00    	jne    2bfc <subdir+0x53c>
    printf(1, "chdir ./.. failed\n");
    exit(0);
  }

  fd = open("dd/dd/ffff", 0);
    288f:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    2896:	00 
    2897:	c7 04 24 36 4f 00 00 	movl   $0x4f36,(%esp)
    289e:	e8 45 17 00 00       	call   3fe8 <open>
  if(fd < 0){
    28a3:	85 c0                	test   %eax,%eax
  if(chdir("./..") != 0){
    printf(1, "chdir ./.. failed\n");
    exit(0);
  }

  fd = open("dd/dd/ffff", 0);
    28a5:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    28a7:	0f 88 6f 06 00 00    	js     2f1c <subdir+0x85c>
    printf(1, "open dd/dd/ffff failed\n");
    exit(0);
  }
  if(read(fd, buf, sizeof(buf)) != 2){
    28ad:	c7 44 24 08 00 20 00 	movl   $0x2000,0x8(%esp)
    28b4:	00 
    28b5:	c7 44 24 04 00 84 00 	movl   $0x8400,0x4(%esp)
    28bc:	00 
    28bd:	89 04 24             	mov    %eax,(%esp)
    28c0:	e8 fb 16 00 00       	call   3fc0 <read>
    28c5:	83 f8 02             	cmp    $0x2,%eax
    28c8:	0f 85 2e 06 00 00    	jne    2efc <subdir+0x83c>
    printf(1, "read dd/dd/ffff wrong len\n");
    exit(0);
  }
  close(fd);
    28ce:	89 1c 24             	mov    %ebx,(%esp)
    28d1:	e8 fa 16 00 00       	call   3fd0 <close>

  if(open("dd/dd/ff", O_RDONLY) >= 0){
    28d6:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    28dd:	00 
    28de:	c7 04 24 d2 4e 00 00 	movl   $0x4ed2,(%esp)
    28e5:	e8 fe 16 00 00       	call   3fe8 <open>
    28ea:	85 c0                	test   %eax,%eax
    28ec:	0f 89 6a 02 00 00    	jns    2b5c <subdir+0x49c>
    printf(1, "open (unlinked) dd/dd/ff succeeded!\n");
    exit(0);
  }

  if(open("dd/ff/ff", O_CREATE|O_RDWR) >= 0){
    28f2:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
    28f9:	00 
    28fa:	c7 04 24 ea 4f 00 00 	movl   $0x4fea,(%esp)
    2901:	e8 e2 16 00 00       	call   3fe8 <open>
    2906:	85 c0                	test   %eax,%eax
    2908:	0f 89 2e 02 00 00    	jns    2b3c <subdir+0x47c>
    printf(1, "create dd/ff/ff succeeded!\n");
    exit(0);
  }
  if(open("dd/xx/ff", O_CREATE|O_RDWR) >= 0){
    290e:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
    2915:	00 
    2916:	c7 04 24 0f 50 00 00 	movl   $0x500f,(%esp)
    291d:	e8 c6 16 00 00       	call   3fe8 <open>
    2922:	85 c0                	test   %eax,%eax
    2924:	0f 89 b2 03 00 00    	jns    2cdc <subdir+0x61c>
    printf(1, "create dd/xx/ff succeeded!\n");
    exit(0);
  }
  if(open("dd", O_CREATE) >= 0){
    292a:	c7 44 24 04 00 02 00 	movl   $0x200,0x4(%esp)
    2931:	00 
    2932:	c7 04 24 9c 4f 00 00 	movl   $0x4f9c,(%esp)
    2939:	e8 aa 16 00 00       	call   3fe8 <open>
    293e:	85 c0                	test   %eax,%eax
    2940:	0f 89 76 03 00 00    	jns    2cbc <subdir+0x5fc>
    printf(1, "create dd succeeded!\n");
    exit(0);
  }
  if(open("dd", O_RDWR) >= 0){
    2946:	c7 44 24 04 02 00 00 	movl   $0x2,0x4(%esp)
    294d:	00 
    294e:	c7 04 24 9c 4f 00 00 	movl   $0x4f9c,(%esp)
    2955:	e8 8e 16 00 00       	call   3fe8 <open>
    295a:	85 c0                	test   %eax,%eax
    295c:	0f 89 3a 03 00 00    	jns    2c9c <subdir+0x5dc>
    printf(1, "open dd rdwr succeeded!\n");
    exit(0);
  }
  if(open("dd", O_WRONLY) >= 0){
    2962:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
    2969:	00 
    296a:	c7 04 24 9c 4f 00 00 	movl   $0x4f9c,(%esp)
    2971:	e8 72 16 00 00       	call   3fe8 <open>
    2976:	85 c0                	test   %eax,%eax
    2978:	0f 89 fe 02 00 00    	jns    2c7c <subdir+0x5bc>
    printf(1, "open dd wronly succeeded!\n");
    exit(0);
  }
  if(link("dd/ff/ff", "dd/dd/xx") == 0){
    297e:	c7 44 24 04 7e 50 00 	movl   $0x507e,0x4(%esp)
    2985:	00 
    2986:	c7 04 24 ea 4f 00 00 	movl   $0x4fea,(%esp)
    298d:	e8 76 16 00 00       	call   4008 <link>
    2992:	85 c0                	test   %eax,%eax
    2994:	0f 84 c2 02 00 00    	je     2c5c <subdir+0x59c>
    printf(1, "link dd/ff/ff dd/dd/xx succeeded!\n");
    exit(0);
  }
  if(link("dd/xx/ff", "dd/dd/xx") == 0){
    299a:	c7 44 24 04 7e 50 00 	movl   $0x507e,0x4(%esp)
    29a1:	00 
    29a2:	c7 04 24 0f 50 00 00 	movl   $0x500f,(%esp)
    29a9:	e8 5a 16 00 00       	call   4008 <link>
    29ae:	85 c0                	test   %eax,%eax
    29b0:	0f 84 86 02 00 00    	je     2c3c <subdir+0x57c>
    printf(1, "link dd/xx/ff dd/dd/xx succeeded!\n");
    exit(0);
  }
  if(link("dd/ff", "dd/dd/ffff") == 0){
    29b6:	c7 44 24 04 36 4f 00 	movl   $0x4f36,0x4(%esp)
    29bd:	00 
    29be:	c7 04 24 d5 4e 00 00 	movl   $0x4ed5,(%esp)
    29c5:	e8 3e 16 00 00       	call   4008 <link>
    29ca:	85 c0                	test   %eax,%eax
    29cc:	0f 84 ca 01 00 00    	je     2b9c <subdir+0x4dc>
    printf(1, "link dd/ff dd/dd/ffff succeeded!\n");
    exit(0);
  }
  if(mkdir("dd/ff/ff") == 0){
    29d2:	c7 04 24 ea 4f 00 00 	movl   $0x4fea,(%esp)
    29d9:	e8 32 16 00 00       	call   4010 <mkdir>
    29de:	85 c0                	test   %eax,%eax
    29e0:	0f 84 96 01 00 00    	je     2b7c <subdir+0x4bc>
    printf(1, "mkdir dd/ff/ff succeeded!\n");
    exit(0);
  }
  if(mkdir("dd/xx/ff") == 0){
    29e6:	c7 04 24 0f 50 00 00 	movl   $0x500f,(%esp)
    29ed:	e8 1e 16 00 00       	call   4010 <mkdir>
    29f2:	85 c0                	test   %eax,%eax
    29f4:	0f 84 e2 04 00 00    	je     2edc <subdir+0x81c>
    printf(1, "mkdir dd/xx/ff succeeded!\n");
    exit(0);
  }
  if(mkdir("dd/dd/ffff") == 0){
    29fa:	c7 04 24 36 4f 00 00 	movl   $0x4f36,(%esp)
    2a01:	e8 0a 16 00 00       	call   4010 <mkdir>
    2a06:	85 c0                	test   %eax,%eax
    2a08:	0f 84 ae 04 00 00    	je     2ebc <subdir+0x7fc>
    printf(1, "mkdir dd/dd/ffff succeeded!\n");
    exit(0);
  }
  if(unlink("dd/xx/ff") == 0){
    2a0e:	c7 04 24 0f 50 00 00 	movl   $0x500f,(%esp)
    2a15:	e8 de 15 00 00       	call   3ff8 <unlink>
    2a1a:	85 c0                	test   %eax,%eax
    2a1c:	0f 84 7a 04 00 00    	je     2e9c <subdir+0x7dc>
    printf(1, "unlink dd/xx/ff succeeded!\n");
    exit(0);
  }
  if(unlink("dd/ff/ff") == 0){
    2a22:	c7 04 24 ea 4f 00 00 	movl   $0x4fea,(%esp)
    2a29:	e8 ca 15 00 00       	call   3ff8 <unlink>
    2a2e:	85 c0                	test   %eax,%eax
    2a30:	0f 84 46 04 00 00    	je     2e7c <subdir+0x7bc>
    printf(1, "unlink dd/ff/ff succeeded!\n");
    exit(0);
  }
  if(chdir("dd/ff") == 0){
    2a36:	c7 04 24 d5 4e 00 00 	movl   $0x4ed5,(%esp)
    2a3d:	e8 d6 15 00 00       	call   4018 <chdir>
    2a42:	85 c0                	test   %eax,%eax
    2a44:	0f 84 12 04 00 00    	je     2e5c <subdir+0x79c>
    printf(1, "chdir dd/ff succeeded!\n");
    exit(0);
  }
  if(chdir("dd/xx") == 0){
    2a4a:	c7 04 24 81 50 00 00 	movl   $0x5081,(%esp)
    2a51:	e8 c2 15 00 00       	call   4018 <chdir>
    2a56:	85 c0                	test   %eax,%eax
    2a58:	0f 84 de 03 00 00    	je     2e3c <subdir+0x77c>
    printf(1, "chdir dd/xx succeeded!\n");
    exit(0);
  }

  if(unlink("dd/dd/ffff") != 0){
    2a5e:	c7 04 24 36 4f 00 00 	movl   $0x4f36,(%esp)
    2a65:	e8 8e 15 00 00       	call   3ff8 <unlink>
    2a6a:	85 c0                	test   %eax,%eax
    2a6c:	0f 85 aa 00 00 00    	jne    2b1c <subdir+0x45c>
    printf(1, "unlink dd/dd/ff failed\n");
    exit(0);
  }
  if(unlink("dd/ff") != 0){
    2a72:	c7 04 24 d5 4e 00 00 	movl   $0x4ed5,(%esp)
    2a79:	e8 7a 15 00 00       	call   3ff8 <unlink>
    2a7e:	85 c0                	test   %eax,%eax
    2a80:	0f 85 96 03 00 00    	jne    2e1c <subdir+0x75c>
    printf(1, "unlink dd/ff failed\n");
    exit(0);
  }
  if(unlink("dd") == 0){
    2a86:	c7 04 24 9c 4f 00 00 	movl   $0x4f9c,(%esp)
    2a8d:	e8 66 15 00 00       	call   3ff8 <unlink>
    2a92:	85 c0                	test   %eax,%eax
    2a94:	0f 84 62 03 00 00    	je     2dfc <subdir+0x73c>
    printf(1, "unlink non-empty dd succeeded!\n");
    exit(0);
  }
  if(unlink("dd/dd") < 0){
    2a9a:	c7 04 24 b1 4e 00 00 	movl   $0x4eb1,(%esp)
    2aa1:	e8 52 15 00 00       	call   3ff8 <unlink>
    2aa6:	85 c0                	test   %eax,%eax
    2aa8:	0f 88 2e 03 00 00    	js     2ddc <subdir+0x71c>
    printf(1, "unlink dd/dd failed\n");
    exit(0);
  }
  if(unlink("dd") < 0){
    2aae:	c7 04 24 9c 4f 00 00 	movl   $0x4f9c,(%esp)
    2ab5:	e8 3e 15 00 00       	call   3ff8 <unlink>
    2aba:	85 c0                	test   %eax,%eax
    2abc:	0f 88 fa 02 00 00    	js     2dbc <subdir+0x6fc>
    printf(1, "unlink dd failed\n");
    exit(0);
  }

  printf(1, "subdir ok\n");
    2ac2:	c7 44 24 04 7e 51 00 	movl   $0x517e,0x4(%esp)
    2ac9:	00 
    2aca:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2ad1:	e8 1a 16 00 00       	call   40f0 <printf>
}
    2ad6:	83 c4 14             	add    $0x14,%esp
    2ad9:	5b                   	pop    %ebx
    2ada:	5d                   	pop    %ebp
    2adb:	c3                   	ret    
    printf(1, "open dd/dd/../ff failed\n");
    exit(0);
  }
  cc = read(fd, buf, sizeof(buf));
  if(cc != 2 || buf[0] != 'f'){
    printf(1, "dd/dd/../ff wrong content\n");
    2adc:	c7 44 24 04 1b 4f 00 	movl   $0x4f1b,0x4(%esp)
    2ae3:	00 
    2ae4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2aeb:	e8 00 16 00 00       	call   40f0 <printf>
    exit(0);
    2af0:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2af7:	e8 ac 14 00 00       	call   3fa8 <exit>
  if(chdir("dd/../../dd") != 0){
    printf(1, "chdir dd/../../dd failed\n");
    exit(0);
  }
  if(chdir("dd/../../../dd") != 0){
    printf(1, "chdir dd/../../dd failed\n");
    2afc:	c7 44 24 04 76 4f 00 	movl   $0x4f76,0x4(%esp)
    2b03:	00 
    2b04:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2b0b:	e8 e0 15 00 00       	call   40f0 <printf>
    exit(0);
    2b10:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2b17:	e8 8c 14 00 00       	call   3fa8 <exit>
    printf(1, "chdir dd/xx succeeded!\n");
    exit(0);
  }

  if(unlink("dd/dd/ffff") != 0){
    printf(1, "unlink dd/dd/ff failed\n");
    2b1c:	c7 44 24 04 41 4f 00 	movl   $0x4f41,0x4(%esp)
    2b23:	00 
    2b24:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2b2b:	e8 c0 15 00 00       	call   40f0 <printf>
    exit(0);
    2b30:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2b37:	e8 6c 14 00 00       	call   3fa8 <exit>
    printf(1, "open (unlinked) dd/dd/ff succeeded!\n");
    exit(0);
  }

  if(open("dd/ff/ff", O_CREATE|O_RDWR) >= 0){
    printf(1, "create dd/ff/ff succeeded!\n");
    2b3c:	c7 44 24 04 f3 4f 00 	movl   $0x4ff3,0x4(%esp)
    2b43:	00 
    2b44:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2b4b:	e8 a0 15 00 00       	call   40f0 <printf>
    exit(0);
    2b50:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2b57:	e8 4c 14 00 00       	call   3fa8 <exit>
    exit(0);
  }
  close(fd);

  if(open("dd/dd/ff", O_RDONLY) >= 0){
    printf(1, "open (unlinked) dd/dd/ff succeeded!\n");
    2b5c:	c7 44 24 04 64 5a 00 	movl   $0x5a64,0x4(%esp)
    2b63:	00 
    2b64:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2b6b:	e8 80 15 00 00       	call   40f0 <printf>
    exit(0);
    2b70:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2b77:	e8 2c 14 00 00       	call   3fa8 <exit>
  if(link("dd/ff", "dd/dd/ffff") == 0){
    printf(1, "link dd/ff dd/dd/ffff succeeded!\n");
    exit(0);
  }
  if(mkdir("dd/ff/ff") == 0){
    printf(1, "mkdir dd/ff/ff succeeded!\n");
    2b7c:	c7 44 24 04 87 50 00 	movl   $0x5087,0x4(%esp)
    2b83:	00 
    2b84:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2b8b:	e8 60 15 00 00       	call   40f0 <printf>
    exit(0);
    2b90:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2b97:	e8 0c 14 00 00       	call   3fa8 <exit>
  if(link("dd/xx/ff", "dd/dd/xx") == 0){
    printf(1, "link dd/xx/ff dd/dd/xx succeeded!\n");
    exit(0);
  }
  if(link("dd/ff", "dd/dd/ffff") == 0){
    printf(1, "link dd/ff dd/dd/ffff succeeded!\n");
    2b9c:	c7 44 24 04 d4 5a 00 	movl   $0x5ad4,0x4(%esp)
    2ba3:	00 
    2ba4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2bab:	e8 40 15 00 00       	call   40f0 <printf>
    exit(0);
    2bb0:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2bb7:	e8 ec 13 00 00       	call   3fa8 <exit>
  write(fd, "FF", 2);
  close(fd);

  fd = open("dd/dd/../ff", 0);
  if(fd < 0){
    printf(1, "open dd/dd/../ff failed\n");
    2bbc:	c7 44 24 04 02 4f 00 	movl   $0x4f02,0x4(%esp)
    2bc3:	00 
    2bc4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2bcb:	e8 20 15 00 00       	call   40f0 <printf>
    exit(0);
    2bd0:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2bd7:	e8 cc 13 00 00       	call   3fa8 <exit>
    exit(0);
  }

  fd = open("dd/dd/ff", O_CREATE | O_RDWR);
  if(fd < 0){
    printf(1, "create dd/dd/ff failed\n");
    2bdc:	c7 44 24 04 db 4e 00 	movl   $0x4edb,0x4(%esp)
    2be3:	00 
    2be4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2beb:	e8 00 15 00 00       	call   40f0 <printf>
    exit(0);
    2bf0:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2bf7:	e8 ac 13 00 00       	call   3fa8 <exit>
  if(chdir("dd/../../../dd") != 0){
    printf(1, "chdir dd/../../dd failed\n");
    exit(0);
  }
  if(chdir("./..") != 0){
    printf(1, "chdir ./.. failed\n");
    2bfc:	c7 44 24 04 a4 4f 00 	movl   $0x4fa4,0x4(%esp)
    2c03:	00 
    2c04:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2c0b:	e8 e0 14 00 00       	call   40f0 <printf>
    exit(0);
    2c10:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2c17:	e8 8c 13 00 00       	call   3fa8 <exit>
    exit(0);
  }
  close(fd);

  if(link("dd/dd/ff", "dd/dd/ffff") != 0){
    printf(1, "link dd/dd/ff dd/dd/ffff failed\n");
    2c1c:	c7 44 24 04 1c 5a 00 	movl   $0x5a1c,0x4(%esp)
    2c23:	00 
    2c24:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2c2b:	e8 c0 14 00 00       	call   40f0 <printf>
    exit(0);
    2c30:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2c37:	e8 6c 13 00 00       	call   3fa8 <exit>
  if(link("dd/ff/ff", "dd/dd/xx") == 0){
    printf(1, "link dd/ff/ff dd/dd/xx succeeded!\n");
    exit(0);
  }
  if(link("dd/xx/ff", "dd/dd/xx") == 0){
    printf(1, "link dd/xx/ff dd/dd/xx succeeded!\n");
    2c3c:	c7 44 24 04 b0 5a 00 	movl   $0x5ab0,0x4(%esp)
    2c43:	00 
    2c44:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2c4b:	e8 a0 14 00 00       	call   40f0 <printf>
    exit(0);
    2c50:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2c57:	e8 4c 13 00 00       	call   3fa8 <exit>
  if(open("dd", O_WRONLY) >= 0){
    printf(1, "open dd wronly succeeded!\n");
    exit(0);
  }
  if(link("dd/ff/ff", "dd/dd/xx") == 0){
    printf(1, "link dd/ff/ff dd/dd/xx succeeded!\n");
    2c5c:	c7 44 24 04 8c 5a 00 	movl   $0x5a8c,0x4(%esp)
    2c63:	00 
    2c64:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2c6b:	e8 80 14 00 00       	call   40f0 <printf>
    exit(0);
    2c70:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2c77:	e8 2c 13 00 00       	call   3fa8 <exit>
  if(open("dd", O_RDWR) >= 0){
    printf(1, "open dd rdwr succeeded!\n");
    exit(0);
  }
  if(open("dd", O_WRONLY) >= 0){
    printf(1, "open dd wronly succeeded!\n");
    2c7c:	c7 44 24 04 63 50 00 	movl   $0x5063,0x4(%esp)
    2c83:	00 
    2c84:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2c8b:	e8 60 14 00 00       	call   40f0 <printf>
    exit(0);
    2c90:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2c97:	e8 0c 13 00 00       	call   3fa8 <exit>
  if(open("dd", O_CREATE) >= 0){
    printf(1, "create dd succeeded!\n");
    exit(0);
  }
  if(open("dd", O_RDWR) >= 0){
    printf(1, "open dd rdwr succeeded!\n");
    2c9c:	c7 44 24 04 4a 50 00 	movl   $0x504a,0x4(%esp)
    2ca3:	00 
    2ca4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2cab:	e8 40 14 00 00       	call   40f0 <printf>
    exit(0);
    2cb0:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2cb7:	e8 ec 12 00 00       	call   3fa8 <exit>
  if(open("dd/xx/ff", O_CREATE|O_RDWR) >= 0){
    printf(1, "create dd/xx/ff succeeded!\n");
    exit(0);
  }
  if(open("dd", O_CREATE) >= 0){
    printf(1, "create dd succeeded!\n");
    2cbc:	c7 44 24 04 34 50 00 	movl   $0x5034,0x4(%esp)
    2cc3:	00 
    2cc4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2ccb:	e8 20 14 00 00       	call   40f0 <printf>
    exit(0);
    2cd0:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2cd7:	e8 cc 12 00 00       	call   3fa8 <exit>
  if(open("dd/ff/ff", O_CREATE|O_RDWR) >= 0){
    printf(1, "create dd/ff/ff succeeded!\n");
    exit(0);
  }
  if(open("dd/xx/ff", O_CREATE|O_RDWR) >= 0){
    printf(1, "create dd/xx/ff succeeded!\n");
    2cdc:	c7 44 24 04 18 50 00 	movl   $0x5018,0x4(%esp)
    2ce3:	00 
    2ce4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2ceb:	e8 00 14 00 00       	call   40f0 <printf>
    exit(0);
    2cf0:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2cf7:	e8 ac 12 00 00       	call   3fa8 <exit>
    printf(1, "open (unlinked) dd/dd/ff succeeded\n");
    exit(0);
  }

  if(chdir("dd") != 0){
    printf(1, "chdir dd failed\n");
    2cfc:	c7 44 24 04 59 4f 00 	movl   $0x4f59,0x4(%esp)
    2d03:	00 
    2d04:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2d0b:	e8 e0 13 00 00       	call   40f0 <printf>
    exit(0);
    2d10:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2d17:	e8 8c 12 00 00       	call   3fa8 <exit>
  if(unlink("dd/dd/ff") != 0){
    printf(1, "unlink dd/dd/ff failed\n");
    exit(0);
  }
  if(open("dd/dd/ff", O_RDONLY) >= 0){
    printf(1, "open (unlinked) dd/dd/ff succeeded\n");
    2d1c:	c7 44 24 04 40 5a 00 	movl   $0x5a40,0x4(%esp)
    2d23:	00 
    2d24:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2d2b:	e8 c0 13 00 00       	call   40f0 <printf>
    exit(0);
    2d30:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2d37:	e8 6c 12 00 00       	call   3fa8 <exit>
    printf(1, "unlink dd (non-empty dir) succeeded!\n");
    exit(0);
  }

  if(mkdir("/dd/dd") != 0){
    printf(1, "subdir mkdir dd/dd failed\n");
    2d3c:	c7 44 24 04 b7 4e 00 	movl   $0x4eb7,0x4(%esp)
    2d43:	00 
    2d44:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2d4b:	e8 a0 13 00 00       	call   40f0 <printf>
    exit(0);
    2d50:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2d57:	e8 4c 12 00 00       	call   3fa8 <exit>
  }
  write(fd, "ff", 2);
  close(fd);

  if(unlink("dd") >= 0){
    printf(1, "unlink dd (non-empty dir) succeeded!\n");
    2d5c:	c7 44 24 04 f4 59 00 	movl   $0x59f4,0x4(%esp)
    2d63:	00 
    2d64:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2d6b:	e8 80 13 00 00       	call   40f0 <printf>
    exit(0);
    2d70:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2d77:	e8 2c 12 00 00       	call   3fa8 <exit>
    exit(0);
  }

  fd = open("dd/ff", O_CREATE | O_RDWR);
  if(fd < 0){
    printf(1, "create dd/ff failed\n");
    2d7c:	c7 44 24 04 9b 4e 00 	movl   $0x4e9b,0x4(%esp)
    2d83:	00 
    2d84:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2d8b:	e8 60 13 00 00       	call   40f0 <printf>
    exit(0);
    2d90:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2d97:	e8 0c 12 00 00       	call   3fa8 <exit>

  printf(1, "subdir test\n");

  unlink("ff");
  if(mkdir("dd") != 0){
    printf(1, "subdir mkdir dd failed\n");
    2d9c:	c7 44 24 04 83 4e 00 	movl   $0x4e83,0x4(%esp)
    2da3:	00 
    2da4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2dab:	e8 40 13 00 00       	call   40f0 <printf>
    exit(0);
    2db0:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2db7:	e8 ec 11 00 00       	call   3fa8 <exit>
  if(unlink("dd/dd") < 0){
    printf(1, "unlink dd/dd failed\n");
    exit(0);
  }
  if(unlink("dd") < 0){
    printf(1, "unlink dd failed\n");
    2dbc:	c7 44 24 04 6c 51 00 	movl   $0x516c,0x4(%esp)
    2dc3:	00 
    2dc4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2dcb:	e8 20 13 00 00       	call   40f0 <printf>
    exit(0);
    2dd0:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2dd7:	e8 cc 11 00 00       	call   3fa8 <exit>
  if(unlink("dd") == 0){
    printf(1, "unlink non-empty dd succeeded!\n");
    exit(0);
  }
  if(unlink("dd/dd") < 0){
    printf(1, "unlink dd/dd failed\n");
    2ddc:	c7 44 24 04 57 51 00 	movl   $0x5157,0x4(%esp)
    2de3:	00 
    2de4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2deb:	e8 00 13 00 00       	call   40f0 <printf>
    exit(0);
    2df0:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2df7:	e8 ac 11 00 00       	call   3fa8 <exit>
  if(unlink("dd/ff") != 0){
    printf(1, "unlink dd/ff failed\n");
    exit(0);
  }
  if(unlink("dd") == 0){
    printf(1, "unlink non-empty dd succeeded!\n");
    2dfc:	c7 44 24 04 f8 5a 00 	movl   $0x5af8,0x4(%esp)
    2e03:	00 
    2e04:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2e0b:	e8 e0 12 00 00       	call   40f0 <printf>
    exit(0);
    2e10:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2e17:	e8 8c 11 00 00       	call   3fa8 <exit>
  if(unlink("dd/dd/ffff") != 0){
    printf(1, "unlink dd/dd/ff failed\n");
    exit(0);
  }
  if(unlink("dd/ff") != 0){
    printf(1, "unlink dd/ff failed\n");
    2e1c:	c7 44 24 04 42 51 00 	movl   $0x5142,0x4(%esp)
    2e23:	00 
    2e24:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2e2b:	e8 c0 12 00 00       	call   40f0 <printf>
    exit(0);
    2e30:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2e37:	e8 6c 11 00 00       	call   3fa8 <exit>
  if(chdir("dd/ff") == 0){
    printf(1, "chdir dd/ff succeeded!\n");
    exit(0);
  }
  if(chdir("dd/xx") == 0){
    printf(1, "chdir dd/xx succeeded!\n");
    2e3c:	c7 44 24 04 2a 51 00 	movl   $0x512a,0x4(%esp)
    2e43:	00 
    2e44:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2e4b:	e8 a0 12 00 00       	call   40f0 <printf>
    exit(0);
    2e50:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2e57:	e8 4c 11 00 00       	call   3fa8 <exit>
  if(unlink("dd/ff/ff") == 0){
    printf(1, "unlink dd/ff/ff succeeded!\n");
    exit(0);
  }
  if(chdir("dd/ff") == 0){
    printf(1, "chdir dd/ff succeeded!\n");
    2e5c:	c7 44 24 04 12 51 00 	movl   $0x5112,0x4(%esp)
    2e63:	00 
    2e64:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2e6b:	e8 80 12 00 00       	call   40f0 <printf>
    exit(0);
    2e70:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2e77:	e8 2c 11 00 00       	call   3fa8 <exit>
  if(unlink("dd/xx/ff") == 0){
    printf(1, "unlink dd/xx/ff succeeded!\n");
    exit(0);
  }
  if(unlink("dd/ff/ff") == 0){
    printf(1, "unlink dd/ff/ff succeeded!\n");
    2e7c:	c7 44 24 04 f6 50 00 	movl   $0x50f6,0x4(%esp)
    2e83:	00 
    2e84:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2e8b:	e8 60 12 00 00       	call   40f0 <printf>
    exit(0);
    2e90:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2e97:	e8 0c 11 00 00       	call   3fa8 <exit>
  if(mkdir("dd/dd/ffff") == 0){
    printf(1, "mkdir dd/dd/ffff succeeded!\n");
    exit(0);
  }
  if(unlink("dd/xx/ff") == 0){
    printf(1, "unlink dd/xx/ff succeeded!\n");
    2e9c:	c7 44 24 04 da 50 00 	movl   $0x50da,0x4(%esp)
    2ea3:	00 
    2ea4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2eab:	e8 40 12 00 00       	call   40f0 <printf>
    exit(0);
    2eb0:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2eb7:	e8 ec 10 00 00       	call   3fa8 <exit>
  if(mkdir("dd/xx/ff") == 0){
    printf(1, "mkdir dd/xx/ff succeeded!\n");
    exit(0);
  }
  if(mkdir("dd/dd/ffff") == 0){
    printf(1, "mkdir dd/dd/ffff succeeded!\n");
    2ebc:	c7 44 24 04 bd 50 00 	movl   $0x50bd,0x4(%esp)
    2ec3:	00 
    2ec4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2ecb:	e8 20 12 00 00       	call   40f0 <printf>
    exit(0);
    2ed0:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2ed7:	e8 cc 10 00 00       	call   3fa8 <exit>
  if(mkdir("dd/ff/ff") == 0){
    printf(1, "mkdir dd/ff/ff succeeded!\n");
    exit(0);
  }
  if(mkdir("dd/xx/ff") == 0){
    printf(1, "mkdir dd/xx/ff succeeded!\n");
    2edc:	c7 44 24 04 a2 50 00 	movl   $0x50a2,0x4(%esp)
    2ee3:	00 
    2ee4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2eeb:	e8 00 12 00 00       	call   40f0 <printf>
    exit(0);
    2ef0:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2ef7:	e8 ac 10 00 00       	call   3fa8 <exit>
  if(fd < 0){
    printf(1, "open dd/dd/ffff failed\n");
    exit(0);
  }
  if(read(fd, buf, sizeof(buf)) != 2){
    printf(1, "read dd/dd/ffff wrong len\n");
    2efc:	c7 44 24 04 cf 4f 00 	movl   $0x4fcf,0x4(%esp)
    2f03:	00 
    2f04:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2f0b:	e8 e0 11 00 00       	call   40f0 <printf>
    exit(0);
    2f10:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2f17:	e8 8c 10 00 00       	call   3fa8 <exit>
    exit(0);
  }

  fd = open("dd/dd/ffff", 0);
  if(fd < 0){
    printf(1, "open dd/dd/ffff failed\n");
    2f1c:	c7 44 24 04 b7 4f 00 	movl   $0x4fb7,0x4(%esp)
    2f23:	00 
    2f24:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2f2b:	e8 c0 11 00 00       	call   40f0 <printf>
    exit(0);
    2f30:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2f37:	e8 6c 10 00 00       	call   3fa8 <exit>
    2f3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00002f40 <dirtest>:
  }
  printf(stdout, "many creates, followed by unlink; ok\n");
}

void dirtest(void)
{
    2f40:	55                   	push   %ebp
    2f41:	89 e5                	mov    %esp,%ebp
    2f43:	83 ec 18             	sub    $0x18,%esp
  printf(stdout, "mkdir test\n");
    2f46:	a1 1c 5c 00 00       	mov    0x5c1c,%eax
    2f4b:	c7 44 24 04 89 51 00 	movl   $0x5189,0x4(%esp)
    2f52:	00 
    2f53:	89 04 24             	mov    %eax,(%esp)
    2f56:	e8 95 11 00 00       	call   40f0 <printf>

  if(mkdir("dir0") < 0){
    2f5b:	c7 04 24 95 51 00 00 	movl   $0x5195,(%esp)
    2f62:	e8 a9 10 00 00       	call   4010 <mkdir>
    2f67:	85 c0                	test   %eax,%eax
    2f69:	78 47                	js     2fb2 <dirtest+0x72>
    printf(stdout, "mkdir failed\n");
    exit(0);
  }

  if(chdir("dir0") < 0){
    2f6b:	c7 04 24 95 51 00 00 	movl   $0x5195,(%esp)
    2f72:	e8 a1 10 00 00       	call   4018 <chdir>
    2f77:	85 c0                	test   %eax,%eax
    2f79:	78 6c                	js     2fe7 <dirtest+0xa7>
    printf(stdout, "chdir dir0 failed\n");
    exit(0);
  }

  if(chdir("..") < 0){
    2f7b:	c7 04 24 a1 4f 00 00 	movl   $0x4fa1,(%esp)
    2f82:	e8 91 10 00 00       	call   4018 <chdir>
    2f87:	85 c0                	test   %eax,%eax
    2f89:	78 52                	js     2fdd <dirtest+0x9d>
    printf(stdout, "chdir .. failed\n");
    exit(0);
  }

  if(unlink("dir0") < 0){
    2f8b:	c7 04 24 95 51 00 00 	movl   $0x5195,(%esp)
    2f92:	e8 61 10 00 00       	call   3ff8 <unlink>
    2f97:	85 c0                	test   %eax,%eax
    2f99:	78 38                	js     2fd3 <dirtest+0x93>
    printf(stdout, "unlink dir0 failed\n");
    exit(0);
  }
  printf(stdout, "mkdir test ok\n");
    2f9b:	a1 1c 5c 00 00       	mov    0x5c1c,%eax
    2fa0:	c7 44 24 04 e0 51 00 	movl   $0x51e0,0x4(%esp)
    2fa7:	00 
    2fa8:	89 04 24             	mov    %eax,(%esp)
    2fab:	e8 40 11 00 00       	call   40f0 <printf>
}
    2fb0:	c9                   	leave  
    2fb1:	c3                   	ret    
void dirtest(void)
{
  printf(stdout, "mkdir test\n");

  if(mkdir("dir0") < 0){
    printf(stdout, "mkdir failed\n");
    2fb2:	c7 44 24 04 9a 51 00 	movl   $0x519a,0x4(%esp)
    2fb9:	00 
    exit(0);
  }

  if(chdir("dir0") < 0){
    printf(stdout, "chdir dir0 failed\n");
    2fba:	a1 1c 5c 00 00       	mov    0x5c1c,%eax
    2fbf:	89 04 24             	mov    %eax,(%esp)
    2fc2:	e8 29 11 00 00       	call   40f0 <printf>
    exit(0);
    2fc7:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2fce:	e8 d5 0f 00 00       	call   3fa8 <exit>
    printf(stdout, "chdir .. failed\n");
    exit(0);
  }

  if(unlink("dir0") < 0){
    printf(stdout, "unlink dir0 failed\n");
    2fd3:	c7 44 24 04 cc 51 00 	movl   $0x51cc,0x4(%esp)
    2fda:	00 
    2fdb:	eb dd                	jmp    2fba <dirtest+0x7a>
    printf(stdout, "chdir dir0 failed\n");
    exit(0);
  }

  if(chdir("..") < 0){
    printf(stdout, "chdir .. failed\n");
    2fdd:	c7 44 24 04 bb 51 00 	movl   $0x51bb,0x4(%esp)
    2fe4:	00 
    2fe5:	eb d3                	jmp    2fba <dirtest+0x7a>
    printf(stdout, "mkdir failed\n");
    exit(0);
  }

  if(chdir("dir0") < 0){
    printf(stdout, "chdir dir0 failed\n");
    2fe7:	c7 44 24 04 a8 51 00 	movl   $0x51a8,0x4(%esp)
    2fee:	00 
    2fef:	eb c9                	jmp    2fba <dirtest+0x7a>
    2ff1:	eb 0d                	jmp    3000 <exitiputtest>
    2ff3:	90                   	nop
    2ff4:	90                   	nop
    2ff5:	90                   	nop
    2ff6:	90                   	nop
    2ff7:	90                   	nop
    2ff8:	90                   	nop
    2ff9:	90                   	nop
    2ffa:	90                   	nop
    2ffb:	90                   	nop
    2ffc:	90                   	nop
    2ffd:	90                   	nop
    2ffe:	90                   	nop
    2fff:	90                   	nop

00003000 <exitiputtest>:
}

// does exit(0) call iput(p->cwd) in a transaction?
void
exitiputtest(void)
{
    3000:	55                   	push   %ebp
    3001:	89 e5                	mov    %esp,%ebp
    3003:	83 ec 18             	sub    $0x18,%esp
  int pid;

  printf(stdout, "exitiput test\n");
    3006:	a1 1c 5c 00 00       	mov    0x5c1c,%eax
    300b:	c7 44 24 04 ef 51 00 	movl   $0x51ef,0x4(%esp)
    3012:	00 
    3013:	89 04 24             	mov    %eax,(%esp)
    3016:	e8 d5 10 00 00       	call   40f0 <printf>

  pid = fork();
    301b:	e8 80 0f 00 00       	call   3fa0 <fork>
  if(pid < 0){
    3020:	83 f8 00             	cmp    $0x0,%eax
    3023:	0f 8c 90 00 00 00    	jl     30b9 <exitiputtest+0xb9>
    printf(stdout, "fork failed\n");
    exit(0);
  }
  if(pid == 0){
    3029:	75 45                	jne    3070 <exitiputtest+0x70>
    if(mkdir("iputdir") < 0){
    302b:	c7 04 24 15 52 00 00 	movl   $0x5215,(%esp)
    3032:	e8 d9 0f 00 00       	call   4010 <mkdir>
    3037:	85 c0                	test   %eax,%eax
    3039:	0f 88 8e 00 00 00    	js     30cd <exitiputtest+0xcd>
      printf(stdout, "mkdir failed\n");
      exit(0);
    }
    if(chdir("iputdir") < 0){
    303f:	c7 04 24 15 52 00 00 	movl   $0x5215,(%esp)
    3046:	e8 cd 0f 00 00       	call   4018 <chdir>
    304b:	85 c0                	test   %eax,%eax
    304d:	78 74                	js     30c3 <exitiputtest+0xc3>
      printf(stdout, "child chdir failed\n");
      exit(0);
    }
    if(unlink("../iputdir") < 0){
    304f:	c7 04 24 12 52 00 00 	movl   $0x5212,(%esp)
    3056:	e8 9d 0f 00 00       	call   3ff8 <unlink>
    305b:	85 c0                	test   %eax,%eax
    305d:	78 39                	js     3098 <exitiputtest+0x98>
      printf(stdout, "unlink ../iputdir failed\n");
      exit(0);
    305f:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3066:	e8 3d 0f 00 00       	call   3fa8 <exit>
    306b:	90                   	nop
    306c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    }
    exit(0);
  }
  wait(0);
    3070:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3077:	e8 34 0f 00 00       	call   3fb0 <wait>
  printf(stdout, "exitiput test ok\n");
    307c:	a1 1c 5c 00 00       	mov    0x5c1c,%eax
    3081:	c7 44 24 04 37 52 00 	movl   $0x5237,0x4(%esp)
    3088:	00 
    3089:	89 04 24             	mov    %eax,(%esp)
    308c:	e8 5f 10 00 00       	call   40f0 <printf>
}
    3091:	c9                   	leave  
    3092:	c3                   	ret    
    3093:	90                   	nop
    3094:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(chdir("iputdir") < 0){
      printf(stdout, "child chdir failed\n");
      exit(0);
    }
    if(unlink("../iputdir") < 0){
      printf(stdout, "unlink ../iputdir failed\n");
    3098:	c7 44 24 04 1d 52 00 	movl   $0x521d,0x4(%esp)
    309f:	00 
    30a0:	a1 1c 5c 00 00       	mov    0x5c1c,%eax
    30a5:	89 04 24             	mov    %eax,(%esp)
    30a8:	e8 43 10 00 00       	call   40f0 <printf>
      exit(0);
    30ad:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    30b4:	e8 ef 0e 00 00       	call   3fa8 <exit>

  printf(stdout, "exitiput test\n");

  pid = fork();
  if(pid < 0){
    printf(stdout, "fork failed\n");
    30b9:	c7 44 24 04 cf 48 00 	movl   $0x48cf,0x4(%esp)
    30c0:	00 
    30c1:	eb dd                	jmp    30a0 <exitiputtest+0xa0>
    if(mkdir("iputdir") < 0){
      printf(stdout, "mkdir failed\n");
      exit(0);
    }
    if(chdir("iputdir") < 0){
      printf(stdout, "child chdir failed\n");
    30c3:	c7 44 24 04 fe 51 00 	movl   $0x51fe,0x4(%esp)
    30ca:	00 
    30cb:	eb d3                	jmp    30a0 <exitiputtest+0xa0>
    printf(stdout, "fork failed\n");
    exit(0);
  }
  if(pid == 0){
    if(mkdir("iputdir") < 0){
      printf(stdout, "mkdir failed\n");
    30cd:	c7 44 24 04 9a 51 00 	movl   $0x519a,0x4(%esp)
    30d4:	00 
    30d5:	eb c9                	jmp    30a0 <exitiputtest+0xa0>
    30d7:	89 f6                	mov    %esi,%esi
    30d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000030e0 <iputtest>:
int stdout = 1;

// does chdir() call iput(p->cwd) in a transaction?
void
iputtest(void)
{
    30e0:	55                   	push   %ebp
    30e1:	89 e5                	mov    %esp,%ebp
    30e3:	83 ec 18             	sub    $0x18,%esp
  printf(stdout, "iput test\n");
    30e6:	a1 1c 5c 00 00       	mov    0x5c1c,%eax
    30eb:	c7 44 24 04 3c 4c 00 	movl   $0x4c3c,0x4(%esp)
    30f2:	00 
    30f3:	89 04 24             	mov    %eax,(%esp)
    30f6:	e8 f5 0f 00 00       	call   40f0 <printf>

  if(mkdir("iputdir") < 0){
    30fb:	c7 04 24 15 52 00 00 	movl   $0x5215,(%esp)
    3102:	e8 09 0f 00 00       	call   4010 <mkdir>
    3107:	85 c0                	test   %eax,%eax
    3109:	78 47                	js     3152 <iputtest+0x72>
    printf(stdout, "mkdir failed\n");
    exit(0);
  }
  if(chdir("iputdir") < 0){
    310b:	c7 04 24 15 52 00 00 	movl   $0x5215,(%esp)
    3112:	e8 01 0f 00 00       	call   4018 <chdir>
    3117:	85 c0                	test   %eax,%eax
    3119:	78 6c                	js     3187 <iputtest+0xa7>
    printf(stdout, "chdir iputdir failed\n");
    exit(0);
  }
  if(unlink("../iputdir") < 0){
    311b:	c7 04 24 12 52 00 00 	movl   $0x5212,(%esp)
    3122:	e8 d1 0e 00 00       	call   3ff8 <unlink>
    3127:	85 c0                	test   %eax,%eax
    3129:	78 52                	js     317d <iputtest+0x9d>
    printf(stdout, "unlink ../iputdir failed\n");
    exit(0);
  }
  if(chdir("/") < 0){
    312b:	c7 04 24 b9 4c 00 00 	movl   $0x4cb9,(%esp)
    3132:	e8 e1 0e 00 00       	call   4018 <chdir>
    3137:	85 c0                	test   %eax,%eax
    3139:	78 38                	js     3173 <iputtest+0x93>
    printf(stdout, "chdir / failed\n");
    exit(0);
  }
  printf(stdout, "iput test ok\n");
    313b:	a1 1c 5c 00 00       	mov    0x5c1c,%eax
    3140:	c7 44 24 04 65 4c 00 	movl   $0x4c65,0x4(%esp)
    3147:	00 
    3148:	89 04 24             	mov    %eax,(%esp)
    314b:	e8 a0 0f 00 00       	call   40f0 <printf>
}
    3150:	c9                   	leave  
    3151:	c3                   	ret    
iputtest(void)
{
  printf(stdout, "iput test\n");

  if(mkdir("iputdir") < 0){
    printf(stdout, "mkdir failed\n");
    3152:	c7 44 24 04 9a 51 00 	movl   $0x519a,0x4(%esp)
    3159:	00 
    exit(0);
  }
  if(chdir("iputdir") < 0){
    printf(stdout, "chdir iputdir failed\n");
    315a:	a1 1c 5c 00 00       	mov    0x5c1c,%eax
    315f:	89 04 24             	mov    %eax,(%esp)
    3162:	e8 89 0f 00 00       	call   40f0 <printf>
    exit(0);
    3167:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    316e:	e8 35 0e 00 00       	call   3fa8 <exit>
  if(unlink("../iputdir") < 0){
    printf(stdout, "unlink ../iputdir failed\n");
    exit(0);
  }
  if(chdir("/") < 0){
    printf(stdout, "chdir / failed\n");
    3173:	c7 44 24 04 09 4e 00 	movl   $0x4e09,0x4(%esp)
    317a:	00 
    317b:	eb dd                	jmp    315a <iputtest+0x7a>
  if(chdir("iputdir") < 0){
    printf(stdout, "chdir iputdir failed\n");
    exit(0);
  }
  if(unlink("../iputdir") < 0){
    printf(stdout, "unlink ../iputdir failed\n");
    317d:	c7 44 24 04 1d 52 00 	movl   $0x521d,0x4(%esp)
    3184:	00 
    3185:	eb d3                	jmp    315a <iputtest+0x7a>
  if(mkdir("iputdir") < 0){
    printf(stdout, "mkdir failed\n");
    exit(0);
  }
  if(chdir("iputdir") < 0){
    printf(stdout, "chdir iputdir failed\n");
    3187:	c7 44 24 04 49 52 00 	movl   $0x5249,0x4(%esp)
    318e:	00 
    318f:	eb c9                	jmp    315a <iputtest+0x7a>
    3191:	eb 0d                	jmp    31a0 <bigfile>
    3193:	90                   	nop
    3194:	90                   	nop
    3195:	90                   	nop
    3196:	90                   	nop
    3197:	90                   	nop
    3198:	90                   	nop
    3199:	90                   	nop
    319a:	90                   	nop
    319b:	90                   	nop
    319c:	90                   	nop
    319d:	90                   	nop
    319e:	90                   	nop
    319f:	90                   	nop

000031a0 <bigfile>:
  printf(1, "bigwrite ok\n");
}

void
bigfile(void)
{
    31a0:	55                   	push   %ebp
    31a1:	89 e5                	mov    %esp,%ebp
    31a3:	57                   	push   %edi
    31a4:	56                   	push   %esi
    31a5:	53                   	push   %ebx
    31a6:	83 ec 1c             	sub    $0x1c,%esp
  int fd, i, total, cc;

  printf(1, "bigfile test\n");
    31a9:	c7 44 24 04 5f 52 00 	movl   $0x525f,0x4(%esp)
    31b0:	00 
    31b1:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    31b8:	e8 33 0f 00 00       	call   40f0 <printf>

  unlink("bigfile");
    31bd:	c7 04 24 7b 52 00 00 	movl   $0x527b,(%esp)
    31c4:	e8 2f 0e 00 00       	call   3ff8 <unlink>
  fd = open("bigfile", O_CREATE | O_RDWR);
    31c9:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
    31d0:	00 
    31d1:	c7 04 24 7b 52 00 00 	movl   $0x527b,(%esp)
    31d8:	e8 0b 0e 00 00       	call   3fe8 <open>
  if(fd < 0){
    31dd:	85 c0                	test   %eax,%eax
  int fd, i, total, cc;

  printf(1, "bigfile test\n");

  unlink("bigfile");
  fd = open("bigfile", O_CREATE | O_RDWR);
    31df:	89 c6                	mov    %eax,%esi
  if(fd < 0){
    31e1:	0f 88 a2 01 00 00    	js     3389 <bigfile+0x1e9>
    printf(1, "cannot create bigfile");
    exit(0);
    31e7:	31 db                	xor    %ebx,%ebx
    31e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  }
  for(i = 0; i < 20; i++){
    memset(buf, i, 600);
    31f0:	c7 44 24 08 58 02 00 	movl   $0x258,0x8(%esp)
    31f7:	00 
    31f8:	89 5c 24 04          	mov    %ebx,0x4(%esp)
    31fc:	c7 04 24 00 84 00 00 	movl   $0x8400,(%esp)
    3203:	e8 18 0c 00 00       	call   3e20 <memset>
    if(write(fd, buf, 600) != 600){
    3208:	c7 44 24 08 58 02 00 	movl   $0x258,0x8(%esp)
    320f:	00 
    3210:	c7 44 24 04 00 84 00 	movl   $0x8400,0x4(%esp)
    3217:	00 
    3218:	89 34 24             	mov    %esi,(%esp)
    321b:	e8 a8 0d 00 00       	call   3fc8 <write>
    3220:	3d 58 02 00 00       	cmp    $0x258,%eax
    3225:	0f 85 1e 01 00 00    	jne    3349 <bigfile+0x1a9>
  fd = open("bigfile", O_CREATE | O_RDWR);
  if(fd < 0){
    printf(1, "cannot create bigfile");
    exit(0);
  }
  for(i = 0; i < 20; i++){
    322b:	83 c3 01             	add    $0x1,%ebx
    322e:	83 fb 14             	cmp    $0x14,%ebx
    3231:	75 bd                	jne    31f0 <bigfile+0x50>
    if(write(fd, buf, 600) != 600){
      printf(1, "write bigfile failed\n");
      exit(0);
    }
  }
  close(fd);
    3233:	89 34 24             	mov    %esi,(%esp)
    3236:	e8 95 0d 00 00       	call   3fd0 <close>

  fd = open("bigfile", 0);
    323b:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    3242:	00 
    3243:	c7 04 24 7b 52 00 00 	movl   $0x527b,(%esp)
    324a:	e8 99 0d 00 00       	call   3fe8 <open>
  if(fd < 0){
    324f:	85 c0                	test   %eax,%eax
      exit(0);
    }
  }
  close(fd);

  fd = open("bigfile", 0);
    3251:	89 c7                	mov    %eax,%edi
  if(fd < 0){
    3253:	0f 88 10 01 00 00    	js     3369 <bigfile+0x1c9>
    printf(1, "cannot open bigfile\n");
    exit(0);
    3259:	31 f6                	xor    %esi,%esi
    325b:	31 db                	xor    %ebx,%ebx
    325d:	eb 2f                	jmp    328e <bigfile+0xee>
    325f:	90                   	nop
      printf(1, "read bigfile failed\n");
      exit(0);
    }
    if(cc == 0)
      break;
    if(cc != 300){
    3260:	3d 2c 01 00 00       	cmp    $0x12c,%eax
    3265:	0f 85 9e 00 00 00    	jne    3309 <bigfile+0x169>
      printf(1, "short read bigfile\n");
      exit(0);
    }
    if(buf[0] != i/2 || buf[299] != i/2){
    326b:	0f be 05 00 84 00 00 	movsbl 0x8400,%eax
    3272:	89 da                	mov    %ebx,%edx
    3274:	d1 fa                	sar    %edx
    3276:	39 d0                	cmp    %edx,%eax
    3278:	75 6f                	jne    32e9 <bigfile+0x149>
    327a:	0f be 15 2b 85 00 00 	movsbl 0x852b,%edx
    3281:	39 d0                	cmp    %edx,%eax
    3283:	75 64                	jne    32e9 <bigfile+0x149>
      printf(1, "read bigfile wrong data\n");
      exit(0);
    }
    total += cc;
    3285:	81 c6 2c 01 00 00    	add    $0x12c,%esi
  if(fd < 0){
    printf(1, "cannot open bigfile\n");
    exit(0);
  }
  total = 0;
  for(i = 0; ; i++){
    328b:	83 c3 01             	add    $0x1,%ebx
    cc = read(fd, buf, 300);
    328e:	c7 44 24 08 2c 01 00 	movl   $0x12c,0x8(%esp)
    3295:	00 
    3296:	c7 44 24 04 00 84 00 	movl   $0x8400,0x4(%esp)
    329d:	00 
    329e:	89 3c 24             	mov    %edi,(%esp)
    32a1:	e8 1a 0d 00 00       	call   3fc0 <read>
    if(cc < 0){
    32a6:	83 f8 00             	cmp    $0x0,%eax
    32a9:	7c 7e                	jl     3329 <bigfile+0x189>
      printf(1, "read bigfile failed\n");
      exit(0);
    }
    if(cc == 0)
    32ab:	75 b3                	jne    3260 <bigfile+0xc0>
      printf(1, "read bigfile wrong data\n");
      exit(0);
    }
    total += cc;
  }
  close(fd);
    32ad:	89 3c 24             	mov    %edi,(%esp)
    32b0:	e8 1b 0d 00 00       	call   3fd0 <close>
  if(total != 20*600){
    32b5:	81 fe e0 2e 00 00    	cmp    $0x2ee0,%esi
    32bb:	0f 85 e8 00 00 00    	jne    33a9 <bigfile+0x209>
    printf(1, "read bigfile wrong total\n");
    exit(0);
  }
  unlink("bigfile");
    32c1:	c7 04 24 7b 52 00 00 	movl   $0x527b,(%esp)
    32c8:	e8 2b 0d 00 00       	call   3ff8 <unlink>

  printf(1, "bigfile test ok\n");
    32cd:	c7 44 24 04 0a 53 00 	movl   $0x530a,0x4(%esp)
    32d4:	00 
    32d5:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    32dc:	e8 0f 0e 00 00       	call   40f0 <printf>
}
    32e1:	83 c4 1c             	add    $0x1c,%esp
    32e4:	5b                   	pop    %ebx
    32e5:	5e                   	pop    %esi
    32e6:	5f                   	pop    %edi
    32e7:	5d                   	pop    %ebp
    32e8:	c3                   	ret    
    if(cc != 300){
      printf(1, "short read bigfile\n");
      exit(0);
    }
    if(buf[0] != i/2 || buf[299] != i/2){
      printf(1, "read bigfile wrong data\n");
    32e9:	c7 44 24 04 d7 52 00 	movl   $0x52d7,0x4(%esp)
    32f0:	00 
    32f1:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    32f8:	e8 f3 0d 00 00       	call   40f0 <printf>
      exit(0);
    32fd:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3304:	e8 9f 0c 00 00       	call   3fa8 <exit>
      exit(0);
    }
    if(cc == 0)
      break;
    if(cc != 300){
      printf(1, "short read bigfile\n");
    3309:	c7 44 24 04 c3 52 00 	movl   $0x52c3,0x4(%esp)
    3310:	00 
    3311:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    3318:	e8 d3 0d 00 00       	call   40f0 <printf>
      exit(0);
    331d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3324:	e8 7f 0c 00 00       	call   3fa8 <exit>
  }
  total = 0;
  for(i = 0; ; i++){
    cc = read(fd, buf, 300);
    if(cc < 0){
      printf(1, "read bigfile failed\n");
    3329:	c7 44 24 04 ae 52 00 	movl   $0x52ae,0x4(%esp)
    3330:	00 
    3331:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    3338:	e8 b3 0d 00 00       	call   40f0 <printf>
      exit(0);
    333d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3344:	e8 5f 0c 00 00       	call   3fa8 <exit>
    exit(0);
  }
  for(i = 0; i < 20; i++){
    memset(buf, i, 600);
    if(write(fd, buf, 600) != 600){
      printf(1, "write bigfile failed\n");
    3349:	c7 44 24 04 83 52 00 	movl   $0x5283,0x4(%esp)
    3350:	00 
    3351:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    3358:	e8 93 0d 00 00       	call   40f0 <printf>
      exit(0);
    335d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3364:	e8 3f 0c 00 00       	call   3fa8 <exit>
  }
  close(fd);

  fd = open("bigfile", 0);
  if(fd < 0){
    printf(1, "cannot open bigfile\n");
    3369:	c7 44 24 04 99 52 00 	movl   $0x5299,0x4(%esp)
    3370:	00 
    3371:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    3378:	e8 73 0d 00 00       	call   40f0 <printf>
    exit(0);
    337d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3384:	e8 1f 0c 00 00       	call   3fa8 <exit>
  printf(1, "bigfile test\n");

  unlink("bigfile");
  fd = open("bigfile", O_CREATE | O_RDWR);
  if(fd < 0){
    printf(1, "cannot create bigfile");
    3389:	c7 44 24 04 6d 52 00 	movl   $0x526d,0x4(%esp)
    3390:	00 
    3391:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    3398:	e8 53 0d 00 00       	call   40f0 <printf>
    exit(0);
    339d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    33a4:	e8 ff 0b 00 00       	call   3fa8 <exit>
    }
    total += cc;
  }
  close(fd);
  if(total != 20*600){
    printf(1, "read bigfile wrong total\n");
    33a9:	c7 44 24 04 f0 52 00 	movl   $0x52f0,0x4(%esp)
    33b0:	00 
    33b1:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    33b8:	e8 33 0d 00 00       	call   40f0 <printf>
    exit(0);
    33bd:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    33c4:	e8 df 0b 00 00       	call   3fa8 <exit>
    33c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000033d0 <concreate>:
}

// test concurrent create/link/unlink of the same file
void
concreate(void)
{
    33d0:	55                   	push   %ebp
    33d1:	89 e5                	mov    %esp,%ebp
    33d3:	57                   	push   %edi
    33d4:	56                   	push   %esi
    33d5:	53                   	push   %ebx
    char name[14];
  } de;

  printf(1, "concreate test\n");
  file[0] = 'C';
  file[2] = '\0';
    33d6:	31 db                	xor    %ebx,%ebx
}

// test concurrent create/link/unlink of the same file
void
concreate(void)
{
    33d8:	83 ec 6c             	sub    $0x6c,%esp
  struct {
    ushort inum;
    char name[14];
  } de;

  printf(1, "concreate test\n");
    33db:	c7 44 24 04 1b 53 00 	movl   $0x531b,0x4(%esp)
    33e2:	00 
    33e3:	8d 75 e5             	lea    -0x1b(%ebp),%esi
    33e6:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    33ed:	e8 fe 0c 00 00       	call   40f0 <printf>
  file[0] = 'C';
    33f2:	c6 45 e5 43          	movb   $0x43,-0x1b(%ebp)
  file[2] = '\0';
    33f6:	c6 45 e7 00          	movb   $0x0,-0x19(%ebp)
    33fa:	eb 5a                	jmp    3456 <concreate+0x86>
    33fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(i = 0; i < 40; i++){
    file[1] = '0' + i;
    unlink(file);
    pid = fork();
    if(pid && (i % 3) == 1){
    3400:	b8 56 55 55 55       	mov    $0x55555556,%eax
    3405:	f7 eb                	imul   %ebx
    3407:	89 d8                	mov    %ebx,%eax
    3409:	c1 f8 1f             	sar    $0x1f,%eax
    340c:	29 c2                	sub    %eax,%edx
    340e:	8d 04 52             	lea    (%edx,%edx,2),%eax
    3411:	89 da                	mov    %ebx,%edx
    3413:	29 c2                	sub    %eax,%edx
    3415:	83 fa 01             	cmp    $0x1,%edx
    3418:	0f 84 8a 00 00 00    	je     34a8 <concreate+0xd8>
      link("C0", file);
    } else if(pid == 0 && (i % 5) == 1){
      link("C0", file);
    } else {
      fd = open(file, O_CREATE | O_RDWR);
    341e:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
    3425:	00 
    3426:	89 34 24             	mov    %esi,(%esp)
    3429:	e8 ba 0b 00 00       	call   3fe8 <open>
      if(fd < 0){
    342e:	85 c0                	test   %eax,%eax
    3430:	0f 88 66 02 00 00    	js     369c <concreate+0x2cc>
        printf(1, "concreate create %s failed\n", file);
        exit(0);
      }
      close(fd);
    3436:	89 04 24             	mov    %eax,(%esp)
    3439:	e8 92 0b 00 00       	call   3fd0 <close>
    }
    if(pid == 0)
    343e:	85 ff                	test   %edi,%edi
    3440:	74 59                	je     349b <concreate+0xcb>
  } de;

  printf(1, "concreate test\n");
  file[0] = 'C';
  file[2] = '\0';
  for(i = 0; i < 40; i++){
    3442:	83 c3 01             	add    $0x1,%ebx
      close(fd);
    }
    if(pid == 0)
      exit(0);
    else
      wait(0);
    3445:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    344c:	e8 5f 0b 00 00       	call   3fb0 <wait>
  } de;

  printf(1, "concreate test\n");
  file[0] = 'C';
  file[2] = '\0';
  for(i = 0; i < 40; i++){
    3451:	83 fb 28             	cmp    $0x28,%ebx
    3454:	74 6a                	je     34c0 <concreate+0xf0>
    file[1] = '0' + i;
    3456:	8d 43 30             	lea    0x30(%ebx),%eax
    3459:	88 45 e6             	mov    %al,-0x1a(%ebp)
    unlink(file);
    345c:	89 34 24             	mov    %esi,(%esp)
    345f:	e8 94 0b 00 00       	call   3ff8 <unlink>
    pid = fork();
    3464:	e8 37 0b 00 00       	call   3fa0 <fork>
    if(pid && (i % 3) == 1){
    3469:	85 c0                	test   %eax,%eax
  file[0] = 'C';
  file[2] = '\0';
  for(i = 0; i < 40; i++){
    file[1] = '0' + i;
    unlink(file);
    pid = fork();
    346b:	89 c7                	mov    %eax,%edi
    if(pid && (i % 3) == 1){
    346d:	75 91                	jne    3400 <concreate+0x30>
      link("C0", file);
    } else if(pid == 0 && (i % 5) == 1){
    346f:	b8 67 66 66 66       	mov    $0x66666667,%eax
    3474:	f7 eb                	imul   %ebx
    3476:	89 d8                	mov    %ebx,%eax
    3478:	c1 f8 1f             	sar    $0x1f,%eax
    347b:	d1 fa                	sar    %edx
    347d:	29 c2                	sub    %eax,%edx
    347f:	8d 04 92             	lea    (%edx,%edx,4),%eax
    3482:	89 da                	mov    %ebx,%edx
    3484:	29 c2                	sub    %eax,%edx
    3486:	83 fa 01             	cmp    $0x1,%edx
    3489:	75 93                	jne    341e <concreate+0x4e>
      link("C0", file);
    348b:	89 74 24 04          	mov    %esi,0x4(%esp)
    348f:	c7 04 24 2b 53 00 00 	movl   $0x532b,(%esp)
    3496:	e8 6d 0b 00 00       	call   4008 <link>
      continue;
    if(de.name[0] == 'C' && de.name[2] == '\0'){
      i = de.name[1] - '0';
      if(i < 0 || i >= sizeof(fa)){
        printf(1, "concreate weird file %s\n", de.name);
        exit(0);
    349b:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    34a2:	e8 01 0b 00 00       	call   3fa8 <exit>
    34a7:	90                   	nop
  for(i = 0; i < 40; i++){
    file[1] = '0' + i;
    unlink(file);
    pid = fork();
    if(pid && (i % 3) == 1){
      link("C0", file);
    34a8:	89 74 24 04          	mov    %esi,0x4(%esp)
    34ac:	c7 04 24 2b 53 00 00 	movl   $0x532b,(%esp)
    34b3:	e8 50 0b 00 00       	call   4008 <link>
    34b8:	eb 88                	jmp    3442 <concreate+0x72>
    34ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      exit(0);
    else
      wait(0);
  }

  memset(fa, 0, sizeof(fa));
    34c0:	8d 45 ac             	lea    -0x54(%ebp),%eax
    34c3:	c7 44 24 08 28 00 00 	movl   $0x28,0x8(%esp)
    34ca:	00 
    34cb:	8d 7d d4             	lea    -0x2c(%ebp),%edi
    34ce:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    34d5:	00 
    34d6:	89 04 24             	mov    %eax,(%esp)
    34d9:	e8 42 09 00 00       	call   3e20 <memset>
  fd = open(".", 0);
    34de:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    34e5:	00 
    34e6:	c7 04 24 a2 4f 00 00 	movl   $0x4fa2,(%esp)
    34ed:	e8 f6 0a 00 00       	call   3fe8 <open>
    34f2:	c7 45 a4 00 00 00 00 	movl   $0x0,-0x5c(%ebp)
    34f9:	89 c3                	mov    %eax,%ebx
    34fb:	90                   	nop
    34fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  n = 0;
  while(read(fd, &de, sizeof(de)) > 0){
    3500:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
    3507:	00 
    3508:	89 7c 24 04          	mov    %edi,0x4(%esp)
    350c:	89 1c 24             	mov    %ebx,(%esp)
    350f:	e8 ac 0a 00 00       	call   3fc0 <read>
    3514:	85 c0                	test   %eax,%eax
    3516:	7e 40                	jle    3558 <concreate+0x188>
    if(de.inum == 0)
    3518:	66 83 7d d4 00       	cmpw   $0x0,-0x2c(%ebp)
    351d:	74 e1                	je     3500 <concreate+0x130>
      continue;
    if(de.name[0] == 'C' && de.name[2] == '\0'){
    351f:	80 7d d6 43          	cmpb   $0x43,-0x2a(%ebp)
    3523:	75 db                	jne    3500 <concreate+0x130>
    3525:	80 7d d8 00          	cmpb   $0x0,-0x28(%ebp)
    3529:	75 d5                	jne    3500 <concreate+0x130>
      i = de.name[1] - '0';
    352b:	0f be 45 d7          	movsbl -0x29(%ebp),%eax
    352f:	83 e8 30             	sub    $0x30,%eax
      if(i < 0 || i >= sizeof(fa)){
    3532:	83 f8 27             	cmp    $0x27,%eax
    3535:	0f 87 85 01 00 00    	ja     36c0 <concreate+0x2f0>
        printf(1, "concreate weird file %s\n", de.name);
        exit(0);
      }
      if(fa[i]){
    353b:	80 7c 05 ac 00       	cmpb   $0x0,-0x54(%ebp,%eax,1)
    3540:	0f 85 ba 01 00 00    	jne    3700 <concreate+0x330>
        printf(1, "concreate duplicate file %s\n", de.name);
        exit(0);
      }
      fa[i] = 1;
    3546:	c6 44 05 ac 01       	movb   $0x1,-0x54(%ebp,%eax,1)
      n++;
    354b:	83 45 a4 01          	addl   $0x1,-0x5c(%ebp)
    354f:	eb af                	jmp    3500 <concreate+0x130>
    3551:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    }
  }
  close(fd);
    3558:	89 1c 24             	mov    %ebx,(%esp)
    355b:	e8 70 0a 00 00       	call   3fd0 <close>

  if(n != 40){
    3560:	83 7d a4 28          	cmpl   $0x28,-0x5c(%ebp)
    3564:	0f 85 76 01 00 00    	jne    36e0 <concreate+0x310>
    printf(1, "concreate not enough files in directory listing\n");
    exit(0);
    356a:	31 db                	xor    %ebx,%ebx
    356c:	e9 94 00 00 00       	jmp    3605 <concreate+0x235>
    3571:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    pid = fork();
    if(pid < 0){
      printf(1, "fork failed\n");
      exit(0);
    }
    if(((i % 3) == 0 && pid == 0) ||
    3578:	83 f8 01             	cmp    $0x1,%eax
    357b:	0f 85 b8 00 00 00    	jne    3639 <concreate+0x269>
    3581:	85 ff                	test   %edi,%edi
    3583:	0f 84 b0 00 00 00    	je     3639 <concreate+0x269>
       ((i % 3) == 1 && pid != 0)){
      close(open(file, 0));
    3589:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    3590:	00 
    3591:	89 34 24             	mov    %esi,(%esp)
    3594:	e8 4f 0a 00 00       	call   3fe8 <open>
    3599:	89 04 24             	mov    %eax,(%esp)
    359c:	e8 2f 0a 00 00       	call   3fd0 <close>
      close(open(file, 0));
    35a1:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    35a8:	00 
    35a9:	89 34 24             	mov    %esi,(%esp)
    35ac:	e8 37 0a 00 00       	call   3fe8 <open>
    35b1:	89 04 24             	mov    %eax,(%esp)
    35b4:	e8 17 0a 00 00       	call   3fd0 <close>
      close(open(file, 0));
    35b9:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    35c0:	00 
    35c1:	89 34 24             	mov    %esi,(%esp)
    35c4:	e8 1f 0a 00 00       	call   3fe8 <open>
    35c9:	89 04 24             	mov    %eax,(%esp)
    35cc:	e8 ff 09 00 00       	call   3fd0 <close>
      close(open(file, 0));
    35d1:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    35d8:	00 
    35d9:	89 34 24             	mov    %esi,(%esp)
    35dc:	e8 07 0a 00 00       	call   3fe8 <open>
    35e1:	89 04 24             	mov    %eax,(%esp)
    35e4:	e8 e7 09 00 00       	call   3fd0 <close>
      unlink(file);
      unlink(file);
      unlink(file);
      unlink(file);
    }
    if(pid == 0)
    35e9:	85 ff                	test   %edi,%edi
    35eb:	0f 84 aa fe ff ff    	je     349b <concreate+0xcb>
  if(n != 40){
    printf(1, "concreate not enough files in directory listing\n");
    exit(0);
  }

  for(i = 0; i < 40; i++){
    35f1:	83 c3 01             	add    $0x1,%ebx
      unlink(file);
    }
    if(pid == 0)
      exit(0);
    else
      wait(0);
    35f4:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    35fb:	e8 b0 09 00 00       	call   3fb0 <wait>
  if(n != 40){
    printf(1, "concreate not enough files in directory listing\n");
    exit(0);
  }

  for(i = 0; i < 40; i++){
    3600:	83 fb 28             	cmp    $0x28,%ebx
    3603:	74 5b                	je     3660 <concreate+0x290>
    file[1] = '0' + i;
    3605:	8d 43 30             	lea    0x30(%ebx),%eax
    3608:	88 45 e6             	mov    %al,-0x1a(%ebp)
    pid = fork();
    360b:	e8 90 09 00 00       	call   3fa0 <fork>
    if(pid < 0){
    3610:	85 c0                	test   %eax,%eax
    exit(0);
  }

  for(i = 0; i < 40; i++){
    file[1] = '0' + i;
    pid = fork();
    3612:	89 c7                	mov    %eax,%edi
    if(pid < 0){
    3614:	78 66                	js     367c <concreate+0x2ac>
      printf(1, "fork failed\n");
      exit(0);
    }
    if(((i % 3) == 0 && pid == 0) ||
    3616:	b8 56 55 55 55       	mov    $0x55555556,%eax
    361b:	f7 eb                	imul   %ebx
    361d:	89 d8                	mov    %ebx,%eax
    361f:	c1 f8 1f             	sar    $0x1f,%eax
    3622:	29 c2                	sub    %eax,%edx
    3624:	89 d8                	mov    %ebx,%eax
    3626:	8d 14 52             	lea    (%edx,%edx,2),%edx
    3629:	29 d0                	sub    %edx,%eax
    362b:	0f 85 47 ff ff ff    	jne    3578 <concreate+0x1a8>
    3631:	85 ff                	test   %edi,%edi
    3633:	0f 84 50 ff ff ff    	je     3589 <concreate+0x1b9>
      close(open(file, 0));
      close(open(file, 0));
      close(open(file, 0));
      close(open(file, 0));
    } else {
      unlink(file);
    3639:	89 34 24             	mov    %esi,(%esp)
    363c:	e8 b7 09 00 00       	call   3ff8 <unlink>
      unlink(file);
    3641:	89 34 24             	mov    %esi,(%esp)
    3644:	e8 af 09 00 00       	call   3ff8 <unlink>
      unlink(file);
    3649:	89 34 24             	mov    %esi,(%esp)
    364c:	e8 a7 09 00 00       	call   3ff8 <unlink>
      unlink(file);
    3651:	89 34 24             	mov    %esi,(%esp)
    3654:	e8 9f 09 00 00       	call   3ff8 <unlink>
    3659:	eb 8e                	jmp    35e9 <concreate+0x219>
    365b:	90                   	nop
    365c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      exit(0);
    else
      wait(0);
  }

  printf(1, "concreate ok\n");
    3660:	c7 44 24 04 80 53 00 	movl   $0x5380,0x4(%esp)
    3667:	00 
    3668:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    366f:	e8 7c 0a 00 00       	call   40f0 <printf>
}
    3674:	83 c4 6c             	add    $0x6c,%esp
    3677:	5b                   	pop    %ebx
    3678:	5e                   	pop    %esi
    3679:	5f                   	pop    %edi
    367a:	5d                   	pop    %ebp
    367b:	c3                   	ret    

  for(i = 0; i < 40; i++){
    file[1] = '0' + i;
    pid = fork();
    if(pid < 0){
      printf(1, "fork failed\n");
    367c:	c7 44 24 04 cf 48 00 	movl   $0x48cf,0x4(%esp)
    3683:	00 
    3684:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    368b:	e8 60 0a 00 00       	call   40f0 <printf>
      exit(0);
    3690:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3697:	e8 0c 09 00 00       	call   3fa8 <exit>
    } else if(pid == 0 && (i % 5) == 1){
      link("C0", file);
    } else {
      fd = open(file, O_CREATE | O_RDWR);
      if(fd < 0){
        printf(1, "concreate create %s failed\n", file);
    369c:	89 74 24 08          	mov    %esi,0x8(%esp)
    36a0:	c7 44 24 04 2e 53 00 	movl   $0x532e,0x4(%esp)
    36a7:	00 
    36a8:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    36af:	e8 3c 0a 00 00       	call   40f0 <printf>
        exit(0);
    36b4:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    36bb:	e8 e8 08 00 00       	call   3fa8 <exit>
    if(de.inum == 0)
      continue;
    if(de.name[0] == 'C' && de.name[2] == '\0'){
      i = de.name[1] - '0';
      if(i < 0 || i >= sizeof(fa)){
        printf(1, "concreate weird file %s\n", de.name);
    36c0:	8d 45 d6             	lea    -0x2a(%ebp),%eax
    36c3:	89 44 24 08          	mov    %eax,0x8(%esp)
    36c7:	c7 44 24 04 4a 53 00 	movl   $0x534a,0x4(%esp)
    36ce:	00 
    36cf:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    36d6:	e8 15 0a 00 00       	call   40f0 <printf>
    36db:	e9 bb fd ff ff       	jmp    349b <concreate+0xcb>
    }
  }
  close(fd);

  if(n != 40){
    printf(1, "concreate not enough files in directory listing\n");
    36e0:	c7 44 24 04 18 5b 00 	movl   $0x5b18,0x4(%esp)
    36e7:	00 
    36e8:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    36ef:	e8 fc 09 00 00       	call   40f0 <printf>
    exit(0);
    36f4:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    36fb:	e8 a8 08 00 00       	call   3fa8 <exit>
      if(i < 0 || i >= sizeof(fa)){
        printf(1, "concreate weird file %s\n", de.name);
        exit(0);
      }
      if(fa[i]){
        printf(1, "concreate duplicate file %s\n", de.name);
    3700:	8d 45 d6             	lea    -0x2a(%ebp),%eax
    3703:	89 44 24 08          	mov    %eax,0x8(%esp)
    3707:	c7 44 24 04 63 53 00 	movl   $0x5363,0x4(%esp)
    370e:	00 
    370f:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    3716:	e8 d5 09 00 00       	call   40f0 <printf>
        exit(0);
    371b:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3722:	e8 81 08 00 00       	call   3fa8 <exit>
    3727:	89 f6                	mov    %esi,%esi
    3729:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00003730 <fourfiles>:

// four processes write different files at the same
// time, to test block allocation.
void
fourfiles(void)
{
    3730:	55                   	push   %ebp
    3731:	89 e5                	mov    %esp,%ebp
    3733:	57                   	push   %edi
    3734:	56                   	push   %esi
  int fd, pid, i, j, n, total, pi;
  char *names[] = { "f0", "f1", "f2", "f3" };
  char *fname;

  printf(1, "fourfiles test\n");
    3735:	be 8e 53 00 00       	mov    $0x538e,%esi

// four processes write different files at the same
// time, to test block allocation.
void
fourfiles(void)
{
    373a:	53                   	push   %ebx
  int fd, pid, i, j, n, total, pi;
  char *names[] = { "f0", "f1", "f2", "f3" };
  char *fname;

  printf(1, "fourfiles test\n");
    373b:	31 db                	xor    %ebx,%ebx

// four processes write different files at the same
// time, to test block allocation.
void
fourfiles(void)
{
    373d:	83 ec 3c             	sub    $0x3c,%esp
  int fd, pid, i, j, n, total, pi;
  char *names[] = { "f0", "f1", "f2", "f3" };
  char *fname;

  printf(1, "fourfiles test\n");
    3740:	c7 44 24 04 94 53 00 	movl   $0x5394,0x4(%esp)
    3747:	00 

  for(pi = 0; pi < 4; pi++){
    3748:	8d 7d d8             	lea    -0x28(%ebp),%edi
// time, to test block allocation.
void
fourfiles(void)
{
  int fd, pid, i, j, n, total, pi;
  char *names[] = { "f0", "f1", "f2", "f3" };
    374b:	c7 45 d8 8e 53 00 00 	movl   $0x538e,-0x28(%ebp)
    3752:	c7 45 dc d7 49 00 00 	movl   $0x49d7,-0x24(%ebp)
    3759:	c7 45 e0 db 49 00 00 	movl   $0x49db,-0x20(%ebp)
    3760:	c7 45 e4 91 53 00 00 	movl   $0x5391,-0x1c(%ebp)
  char *fname;

  printf(1, "fourfiles test\n");
    3767:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    376e:	e8 7d 09 00 00       	call   40f0 <printf>

  for(pi = 0; pi < 4; pi++){
    fname = names[pi];
    unlink(fname);
    3773:	89 34 24             	mov    %esi,(%esp)
    3776:	e8 7d 08 00 00       	call   3ff8 <unlink>

    pid = fork();
    377b:	e8 20 08 00 00       	call   3fa0 <fork>
    if(pid < 0){
    3780:	83 f8 00             	cmp    $0x0,%eax
    3783:	0f 8c b6 01 00 00    	jl     393f <fourfiles+0x20f>
      printf(1, "fork failed\n");
      exit(0);
    }

    if(pid == 0){
    3789:	0f 84 07 01 00 00    	je     3896 <fourfiles+0x166>
  char *names[] = { "f0", "f1", "f2", "f3" };
  char *fname;

  printf(1, "fourfiles test\n");

  for(pi = 0; pi < 4; pi++){
    378f:	83 c3 01             	add    $0x1,%ebx
    3792:	83 fb 04             	cmp    $0x4,%ebx
    3795:	74 05                	je     379c <fourfiles+0x6c>
    3797:	8b 34 9f             	mov    (%edi,%ebx,4),%esi
    379a:	eb d7                	jmp    3773 <fourfiles+0x43>
      exit(0);
    }
  }

  for(pi = 0; pi < 4; pi++){
    wait(0);
    379c:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    37a3:	bb 30 00 00 00       	mov    $0x30,%ebx
    37a8:	e8 03 08 00 00       	call   3fb0 <wait>
    37ad:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    37b4:	e8 f7 07 00 00       	call   3fb0 <wait>
    37b9:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    37c0:	e8 eb 07 00 00       	call   3fb0 <wait>
    37c5:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    37cc:	e8 df 07 00 00       	call   3fb0 <wait>
    37d1:	c7 45 d4 8e 53 00 00 	movl   $0x538e,-0x2c(%ebp)
  }

  for(i = 0; i < 2; i++){
    fname = names[i];
    fd = open(fname, 0);
    37d8:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    37db:	31 f6                	xor    %esi,%esi
    37dd:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    37e4:	00 
    37e5:	89 04 24             	mov    %eax,(%esp)
    37e8:	e8 fb 07 00 00       	call   3fe8 <open>
    37ed:	89 c7                	mov    %eax,%edi
    37ef:	90                   	nop
    total = 0;
    while((n = read(fd, buf, sizeof(buf))) > 0){
    37f0:	c7 44 24 08 00 20 00 	movl   $0x2000,0x8(%esp)
    37f7:	00 
    37f8:	c7 44 24 04 00 84 00 	movl   $0x8400,0x4(%esp)
    37ff:	00 
    3800:	89 3c 24             	mov    %edi,(%esp)
    3803:	e8 b8 07 00 00       	call   3fc0 <read>
    3808:	85 c0                	test   %eax,%eax
    380a:	7e 1a                	jle    3826 <fourfiles+0xf6>
    380c:	31 d2                	xor    %edx,%edx
    380e:	66 90                	xchg   %ax,%ax
      for(j = 0; j < n; j++){
        if(buf[j] != '0'+i){
    3810:	0f be 8a 00 84 00 00 	movsbl 0x8400(%edx),%ecx
    3817:	39 d9                	cmp    %ebx,%ecx
    3819:	75 5b                	jne    3876 <fourfiles+0x146>
  for(i = 0; i < 2; i++){
    fname = names[i];
    fd = open(fname, 0);
    total = 0;
    while((n = read(fd, buf, sizeof(buf))) > 0){
      for(j = 0; j < n; j++){
    381b:	83 c2 01             	add    $0x1,%edx
    381e:	39 d0                	cmp    %edx,%eax
    3820:	7f ee                	jg     3810 <fourfiles+0xe0>
        if(buf[j] != '0'+i){
          printf(1, "wrong char\n");
          exit(0);
        }
      }
      total += n;
    3822:	01 c6                	add    %eax,%esi
    3824:	eb ca                	jmp    37f0 <fourfiles+0xc0>
    }
    close(fd);
    3826:	89 3c 24             	mov    %edi,(%esp)
    3829:	e8 a2 07 00 00       	call   3fd0 <close>
    if(total != 12*500){
    382e:	81 fe 70 17 00 00    	cmp    $0x1770,%esi
    3834:	0f 85 e1 00 00 00    	jne    391b <fourfiles+0x1eb>
      printf(1, "wrong length %d\n", total);
      exit(0);
    }
    unlink(fname);
    383a:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    383d:	89 04 24             	mov    %eax,(%esp)
    3840:	e8 b3 07 00 00       	call   3ff8 <unlink>

  for(pi = 0; pi < 4; pi++){
    wait(0);
  }

  for(i = 0; i < 2; i++){
    3845:	83 fb 31             	cmp    $0x31,%ebx
    3848:	75 1c                	jne    3866 <fourfiles+0x136>
      exit(0);
    }
    unlink(fname);
  }

  printf(1, "fourfiles ok\n");
    384a:	c7 44 24 04 d2 53 00 	movl   $0x53d2,0x4(%esp)
    3851:	00 
    3852:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    3859:	e8 92 08 00 00       	call   40f0 <printf>
}
    385e:	83 c4 3c             	add    $0x3c,%esp
    3861:	5b                   	pop    %ebx
    3862:	5e                   	pop    %esi
    3863:	5f                   	pop    %edi
    3864:	5d                   	pop    %ebp
    3865:	c3                   	ret    

  for(pi = 0; pi < 4; pi++){
    wait(0);
  }

  for(i = 0; i < 2; i++){
    3866:	8b 45 dc             	mov    -0x24(%ebp),%eax
    3869:	bb 31 00 00 00       	mov    $0x31,%ebx
    386e:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    3871:	e9 62 ff ff ff       	jmp    37d8 <fourfiles+0xa8>
    fd = open(fname, 0);
    total = 0;
    while((n = read(fd, buf, sizeof(buf))) > 0){
      for(j = 0; j < n; j++){
        if(buf[j] != '0'+i){
          printf(1, "wrong char\n");
    3876:	c7 44 24 04 b5 53 00 	movl   $0x53b5,0x4(%esp)
    387d:	00 
    387e:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    3885:	e8 66 08 00 00       	call   40f0 <printf>
          exit(0);
    388a:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3891:	e8 12 07 00 00       	call   3fa8 <exit>
      printf(1, "fork failed\n");
      exit(0);
    }

    if(pid == 0){
      fd = open(fname, O_CREATE | O_RDWR);
    3896:	89 34 24             	mov    %esi,(%esp)
    3899:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
    38a0:	00 
    38a1:	e8 42 07 00 00       	call   3fe8 <open>
      if(fd < 0){
    38a6:	85 c0                	test   %eax,%eax
      printf(1, "fork failed\n");
      exit(0);
    }

    if(pid == 0){
      fd = open(fname, O_CREATE | O_RDWR);
    38a8:	89 c6                	mov    %eax,%esi
      if(fd < 0){
    38aa:	0f 88 af 00 00 00    	js     395f <fourfiles+0x22f>
        printf(1, "create failed\n");
        exit(0);
      }

      memset(buf, '0'+pi, 512);
    38b0:	83 c3 30             	add    $0x30,%ebx
    38b3:	89 5c 24 04          	mov    %ebx,0x4(%esp)
    38b7:	31 db                	xor    %ebx,%ebx
    38b9:	c7 44 24 08 00 02 00 	movl   $0x200,0x8(%esp)
    38c0:	00 
    38c1:	c7 04 24 00 84 00 00 	movl   $0x8400,(%esp)
    38c8:	e8 53 05 00 00       	call   3e20 <memset>
    38cd:	eb 09                	jmp    38d8 <fourfiles+0x1a8>
    38cf:	90                   	nop
      for(i = 0; i < 12; i++){
    38d0:	83 c3 01             	add    $0x1,%ebx
    38d3:	83 fb 0c             	cmp    $0xc,%ebx
    38d6:	74 b2                	je     388a <fourfiles+0x15a>
        if((n = write(fd, buf, 500)) != 500){
    38d8:	c7 44 24 08 f4 01 00 	movl   $0x1f4,0x8(%esp)
    38df:	00 
    38e0:	c7 44 24 04 00 84 00 	movl   $0x8400,0x4(%esp)
    38e7:	00 
    38e8:	89 34 24             	mov    %esi,(%esp)
    38eb:	e8 d8 06 00 00       	call   3fc8 <write>
    38f0:	3d f4 01 00 00       	cmp    $0x1f4,%eax
    38f5:	74 d9                	je     38d0 <fourfiles+0x1a0>
          printf(1, "write failed %d\n", n);
    38f7:	89 44 24 08          	mov    %eax,0x8(%esp)
    38fb:	c7 44 24 04 a4 53 00 	movl   $0x53a4,0x4(%esp)
    3902:	00 
    3903:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    390a:	e8 e1 07 00 00       	call   40f0 <printf>
          exit(0);
    390f:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3916:	e8 8d 06 00 00       	call   3fa8 <exit>
      }
      total += n;
    }
    close(fd);
    if(total != 12*500){
      printf(1, "wrong length %d\n", total);
    391b:	89 74 24 08          	mov    %esi,0x8(%esp)
    391f:	c7 44 24 04 c1 53 00 	movl   $0x53c1,0x4(%esp)
    3926:	00 
    3927:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    392e:	e8 bd 07 00 00       	call   40f0 <printf>
      exit(0);
    3933:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    393a:	e8 69 06 00 00       	call   3fa8 <exit>
    fname = names[pi];
    unlink(fname);

    pid = fork();
    if(pid < 0){
      printf(1, "fork failed\n");
    393f:	c7 44 24 04 cf 48 00 	movl   $0x48cf,0x4(%esp)
    3946:	00 
    3947:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    394e:	e8 9d 07 00 00       	call   40f0 <printf>
      exit(0);
    3953:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    395a:	e8 49 06 00 00       	call   3fa8 <exit>
    }

    if(pid == 0){
      fd = open(fname, O_CREATE | O_RDWR);
      if(fd < 0){
        printf(1, "create failed\n");
    395f:	c7 44 24 04 65 49 00 	movl   $0x4965,0x4(%esp)
    3966:	00 
    3967:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    396e:	e8 7d 07 00 00       	call   40f0 <printf>
        exit(0);
    3973:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    397a:	e8 29 06 00 00       	call   3fa8 <exit>
    397f:	90                   	nop

00003980 <sharedfd>:

// two processes write to the same file descriptor
// is the offset shared? does inode locking work?
void
sharedfd(void)
{
    3980:	55                   	push   %ebp
    3981:	89 e5                	mov    %esp,%ebp
    3983:	57                   	push   %edi
    3984:	56                   	push   %esi
    3985:	53                   	push   %ebx
    3986:	83 ec 3c             	sub    $0x3c,%esp
  int fd, pid, i, n, nc, np;
  char buf[10];

  printf(1, "sharedfd test\n");
    3989:	c7 44 24 04 e0 53 00 	movl   $0x53e0,0x4(%esp)
    3990:	00 
    3991:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    3998:	e8 53 07 00 00       	call   40f0 <printf>

  unlink("sharedfd");
    399d:	c7 04 24 ef 53 00 00 	movl   $0x53ef,(%esp)
    39a4:	e8 4f 06 00 00       	call   3ff8 <unlink>
  fd = open("sharedfd", O_CREATE|O_RDWR);
    39a9:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
    39b0:	00 
    39b1:	c7 04 24 ef 53 00 00 	movl   $0x53ef,(%esp)
    39b8:	e8 2b 06 00 00       	call   3fe8 <open>
  if(fd < 0){
    39bd:	85 c0                	test   %eax,%eax
  char buf[10];

  printf(1, "sharedfd test\n");

  unlink("sharedfd");
  fd = open("sharedfd", O_CREATE|O_RDWR);
    39bf:	89 c7                	mov    %eax,%edi
  if(fd < 0){
    39c1:	0f 88 35 01 00 00    	js     3afc <sharedfd+0x17c>
    printf(1, "fstests: cannot open sharedfd for writing");
    return;
  }
  pid = fork();
    39c7:	e8 d4 05 00 00       	call   3fa0 <fork>
  memset(buf, pid==0?'c':'p', sizeof(buf));
    39cc:	8d 75 de             	lea    -0x22(%ebp),%esi
    39cf:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
    39d6:	00 
    39d7:	89 34 24             	mov    %esi,(%esp)
    39da:	83 f8 01             	cmp    $0x1,%eax
  fd = open("sharedfd", O_CREATE|O_RDWR);
  if(fd < 0){
    printf(1, "fstests: cannot open sharedfd for writing");
    return;
  }
  pid = fork();
    39dd:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  memset(buf, pid==0?'c':'p', sizeof(buf));
    39e0:	19 c0                	sbb    %eax,%eax
    39e2:	31 db                	xor    %ebx,%ebx
    39e4:	83 e0 f3             	and    $0xfffffff3,%eax
    39e7:	83 c0 70             	add    $0x70,%eax
    39ea:	89 44 24 04          	mov    %eax,0x4(%esp)
    39ee:	e8 2d 04 00 00       	call   3e20 <memset>
    39f3:	eb 0e                	jmp    3a03 <sharedfd+0x83>
    39f5:	8d 76 00             	lea    0x0(%esi),%esi
  for(i = 0; i < 1000; i++){
    39f8:	83 c3 01             	add    $0x1,%ebx
    39fb:	81 fb e8 03 00 00    	cmp    $0x3e8,%ebx
    3a01:	74 2d                	je     3a30 <sharedfd+0xb0>
    if(write(fd, buf, sizeof(buf)) != sizeof(buf)){
    3a03:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
    3a0a:	00 
    3a0b:	89 74 24 04          	mov    %esi,0x4(%esp)
    3a0f:	89 3c 24             	mov    %edi,(%esp)
    3a12:	e8 b1 05 00 00       	call   3fc8 <write>
    3a17:	83 f8 0a             	cmp    $0xa,%eax
    3a1a:	74 dc                	je     39f8 <sharedfd+0x78>
      printf(1, "fstests: write sharedfd failed\n");
    3a1c:	c7 44 24 04 78 5b 00 	movl   $0x5b78,0x4(%esp)
    3a23:	00 
    3a24:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    3a2b:	e8 c0 06 00 00       	call   40f0 <printf>
      break;
    }
  }
  if(pid == 0)
    3a30:	8b 55 d4             	mov    -0x2c(%ebp),%edx
    3a33:	85 d2                	test   %edx,%edx
    3a35:	0f 84 0f 01 00 00    	je     3b4a <sharedfd+0x1ca>
    exit(0);
  else
    wait(0);
    3a3b:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  close(fd);
  fd = open("sharedfd", 0);
  if(fd < 0){
    3a42:	31 db                	xor    %ebx,%ebx
    }
  }
  if(pid == 0)
    exit(0);
  else
    wait(0);
    3a44:	e8 67 05 00 00       	call   3fb0 <wait>
  close(fd);
    3a49:	89 3c 24             	mov    %edi,(%esp)
  fd = open("sharedfd", 0);
  if(fd < 0){
    3a4c:	31 ff                	xor    %edi,%edi
  }
  if(pid == 0)
    exit(0);
  else
    wait(0);
  close(fd);
    3a4e:	e8 7d 05 00 00       	call   3fd0 <close>
  fd = open("sharedfd", 0);
    3a53:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    3a5a:	00 
    3a5b:	c7 04 24 ef 53 00 00 	movl   $0x53ef,(%esp)
    3a62:	e8 81 05 00 00       	call   3fe8 <open>
  if(fd < 0){
    3a67:	85 c0                	test   %eax,%eax
  if(pid == 0)
    exit(0);
  else
    wait(0);
  close(fd);
  fd = open("sharedfd", 0);
    3a69:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  if(fd < 0){
    3a6c:	0f 88 a6 00 00 00    	js     3b18 <sharedfd+0x198>
    3a72:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    printf(1, "fstests: cannot open sharedfd for reading\n");
    return;
  }
  nc = np = 0;
  while((n = read(fd, buf, sizeof(buf))) > 0){
    3a78:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    3a7b:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
    3a82:	00 
    3a83:	89 74 24 04          	mov    %esi,0x4(%esp)
    3a87:	89 04 24             	mov    %eax,(%esp)
    3a8a:	e8 31 05 00 00       	call   3fc0 <read>
    3a8f:	85 c0                	test   %eax,%eax
    3a91:	7e 26                	jle    3ab9 <sharedfd+0x139>
    wait(0);
  close(fd);
  fd = open("sharedfd", 0);
  if(fd < 0){
    printf(1, "fstests: cannot open sharedfd for reading\n");
    return;
    3a93:	31 c0                	xor    %eax,%eax
    3a95:	eb 14                	jmp    3aab <sharedfd+0x12b>
    3a97:	90                   	nop
  while((n = read(fd, buf, sizeof(buf))) > 0){
    for(i = 0; i < sizeof(buf); i++){
      if(buf[i] == 'c')
        nc++;
      if(buf[i] == 'p')
        np++;
    3a98:	80 fa 70             	cmp    $0x70,%dl
    3a9b:	0f 94 c2             	sete   %dl
    3a9e:	0f b6 d2             	movzbl %dl,%edx
    3aa1:	01 d3                	add    %edx,%ebx
    printf(1, "fstests: cannot open sharedfd for reading\n");
    return;
  }
  nc = np = 0;
  while((n = read(fd, buf, sizeof(buf))) > 0){
    for(i = 0; i < sizeof(buf); i++){
    3aa3:	83 c0 01             	add    $0x1,%eax
    3aa6:	83 f8 0a             	cmp    $0xa,%eax
    3aa9:	74 cd                	je     3a78 <sharedfd+0xf8>
      if(buf[i] == 'c')
    3aab:	0f b6 14 06          	movzbl (%esi,%eax,1),%edx
    3aaf:	80 fa 63             	cmp    $0x63,%dl
    3ab2:	75 e4                	jne    3a98 <sharedfd+0x118>
        nc++;
    3ab4:	83 c7 01             	add    $0x1,%edi
    3ab7:	eb ea                	jmp    3aa3 <sharedfd+0x123>
      if(buf[i] == 'p')
        np++;
    }
  }
  close(fd);
    3ab9:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    3abc:	89 04 24             	mov    %eax,(%esp)
    3abf:	e8 0c 05 00 00       	call   3fd0 <close>
  unlink("sharedfd");
    3ac4:	c7 04 24 ef 53 00 00 	movl   $0x53ef,(%esp)
    3acb:	e8 28 05 00 00       	call   3ff8 <unlink>
  if(nc == 10000 && np == 10000){
    3ad0:	81 fb 10 27 00 00    	cmp    $0x2710,%ebx
    3ad6:	75 56                	jne    3b2e <sharedfd+0x1ae>
    3ad8:	81 ff 10 27 00 00    	cmp    $0x2710,%edi
    3ade:	75 4e                	jne    3b2e <sharedfd+0x1ae>
    printf(1, "sharedfd ok\n");
    3ae0:	c7 44 24 04 f8 53 00 	movl   $0x53f8,0x4(%esp)
    3ae7:	00 
    3ae8:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    3aef:	e8 fc 05 00 00       	call   40f0 <printf>
  } else {
    printf(1, "sharedfd oops %d %d\n", nc, np);
    exit(0);
  }
}
    3af4:	83 c4 3c             	add    $0x3c,%esp
    3af7:	5b                   	pop    %ebx
    3af8:	5e                   	pop    %esi
    3af9:	5f                   	pop    %edi
    3afa:	5d                   	pop    %ebp
    3afb:	c3                   	ret    
  printf(1, "sharedfd test\n");

  unlink("sharedfd");
  fd = open("sharedfd", O_CREATE|O_RDWR);
  if(fd < 0){
    printf(1, "fstests: cannot open sharedfd for writing");
    3afc:	c7 44 24 04 4c 5b 00 	movl   $0x5b4c,0x4(%esp)
    3b03:	00 
    3b04:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    3b0b:	e8 e0 05 00 00       	call   40f0 <printf>
    printf(1, "sharedfd ok\n");
  } else {
    printf(1, "sharedfd oops %d %d\n", nc, np);
    exit(0);
  }
}
    3b10:	83 c4 3c             	add    $0x3c,%esp
    3b13:	5b                   	pop    %ebx
    3b14:	5e                   	pop    %esi
    3b15:	5f                   	pop    %edi
    3b16:	5d                   	pop    %ebp
    3b17:	c3                   	ret    
  else
    wait(0);
  close(fd);
  fd = open("sharedfd", 0);
  if(fd < 0){
    printf(1, "fstests: cannot open sharedfd for reading\n");
    3b18:	c7 44 24 04 98 5b 00 	movl   $0x5b98,0x4(%esp)
    3b1f:	00 
    3b20:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    3b27:	e8 c4 05 00 00       	call   40f0 <printf>
    return;
    3b2c:	eb c6                	jmp    3af4 <sharedfd+0x174>
  close(fd);
  unlink("sharedfd");
  if(nc == 10000 && np == 10000){
    printf(1, "sharedfd ok\n");
  } else {
    printf(1, "sharedfd oops %d %d\n", nc, np);
    3b2e:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
    3b32:	89 7c 24 08          	mov    %edi,0x8(%esp)
    3b36:	c7 44 24 04 05 54 00 	movl   $0x5405,0x4(%esp)
    3b3d:	00 
    3b3e:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    3b45:	e8 a6 05 00 00       	call   40f0 <printf>
    exit(0);
    3b4a:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3b51:	e8 52 04 00 00       	call   3fa8 <exit>
    3b56:	8d 76 00             	lea    0x0(%esi),%esi
    3b59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00003b60 <mem>:
  printf(1, "exitwait ok\n");
}

void
mem(void)
{
    3b60:	55                   	push   %ebp
    3b61:	89 e5                	mov    %esp,%ebp
    3b63:	57                   	push   %edi
    3b64:	56                   	push   %esi
    3b65:	53                   	push   %ebx
  void *m1, *m2;
  int pid, ppid;

  printf(1, "mem test\n");
  ppid = getpid();
  if((pid = fork()) == 0){
    3b66:	31 db                	xor    %ebx,%ebx
  printf(1, "exitwait ok\n");
}

void
mem(void)
{
    3b68:	83 ec 1c             	sub    $0x1c,%esp
  void *m1, *m2;
  int pid, ppid;

  printf(1, "mem test\n");
    3b6b:	c7 44 24 04 1a 54 00 	movl   $0x541a,0x4(%esp)
    3b72:	00 
    3b73:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    3b7a:	e8 71 05 00 00       	call   40f0 <printf>
  ppid = getpid();
    3b7f:	e8 a4 04 00 00       	call   4028 <getpid>
    3b84:	89 c6                	mov    %eax,%esi
  if((pid = fork()) == 0){
    3b86:	e8 15 04 00 00       	call   3fa0 <fork>
    3b8b:	85 c0                	test   %eax,%eax
    3b8d:	74 0d                	je     3b9c <mem+0x3c>
    3b8f:	90                   	nop
    3b90:	eb 66                	jmp    3bf8 <mem+0x98>
    3b92:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    m1 = 0;
    while((m2 = malloc(10001)) != 0){
      *(char**)m2 = m1;
    3b98:	89 18                	mov    %ebx,(%eax)
    3b9a:	89 c3                	mov    %eax,%ebx

  printf(1, "mem test\n");
  ppid = getpid();
  if((pid = fork()) == 0){
    m1 = 0;
    while((m2 = malloc(10001)) != 0){
    3b9c:	c7 04 24 11 27 00 00 	movl   $0x2711,(%esp)
    3ba3:	e8 c8 07 00 00       	call   4370 <malloc>
    3ba8:	85 c0                	test   %eax,%eax
    3baa:	75 ec                	jne    3b98 <mem+0x38>
      *(char**)m2 = m1;
      m1 = m2;
    }
    while(m1){
    3bac:	85 db                	test   %ebx,%ebx
    3bae:	74 10                	je     3bc0 <mem+0x60>
      m2 = *(char**)m1;
    3bb0:	8b 3b                	mov    (%ebx),%edi
      free(m1);
    3bb2:	89 1c 24             	mov    %ebx,(%esp)
    3bb5:	e8 26 07 00 00       	call   42e0 <free>
    3bba:	89 fb                	mov    %edi,%ebx
    m1 = 0;
    while((m2 = malloc(10001)) != 0){
      *(char**)m2 = m1;
      m1 = m2;
    }
    while(m1){
    3bbc:	85 db                	test   %ebx,%ebx
    3bbe:	75 f0                	jne    3bb0 <mem+0x50>
      m2 = *(char**)m1;
      free(m1);
      m1 = m2;
    }
    m1 = malloc(1024*20);
    3bc0:	c7 04 24 00 50 00 00 	movl   $0x5000,(%esp)
    3bc7:	e8 a4 07 00 00       	call   4370 <malloc>
    if(m1 == 0){
    3bcc:	85 c0                	test   %eax,%eax
    3bce:	74 40                	je     3c10 <mem+0xb0>
      printf(1, "couldn't allocate mem?!!\n");
      kill(ppid);
      exit(0);
    }
    free(m1);
    3bd0:	89 04 24             	mov    %eax,(%esp)
    3bd3:	e8 08 07 00 00       	call   42e0 <free>
    printf(1, "mem ok\n");
    3bd8:	c7 44 24 04 3e 54 00 	movl   $0x543e,0x4(%esp)
    3bdf:	00 
    3be0:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    3be7:	e8 04 05 00 00       	call   40f0 <printf>
    exit(0);
    3bec:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3bf3:	e8 b0 03 00 00       	call   3fa8 <exit>
  } else {
    wait(0);
    3bf8:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3bff:	e8 ac 03 00 00       	call   3fb0 <wait>
  }
}
    3c04:	83 c4 1c             	add    $0x1c,%esp
    3c07:	5b                   	pop    %ebx
    3c08:	5e                   	pop    %esi
    3c09:	5f                   	pop    %edi
    3c0a:	5d                   	pop    %ebp
    3c0b:	c3                   	ret    
    3c0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      free(m1);
      m1 = m2;
    }
    m1 = malloc(1024*20);
    if(m1 == 0){
      printf(1, "couldn't allocate mem?!!\n");
    3c10:	c7 44 24 04 24 54 00 	movl   $0x5424,0x4(%esp)
    3c17:	00 
    3c18:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    3c1f:	e8 cc 04 00 00       	call   40f0 <printf>
      kill(ppid);
    3c24:	89 34 24             	mov    %esi,(%esp)
    3c27:	e8 ac 03 00 00       	call   3fd8 <kill>
      exit(0);
    3c2c:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3c33:	e8 70 03 00 00       	call   3fa8 <exit>
    3c38:	90                   	nop
    3c39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00003c40 <main>:
  return randstate;
}

int
main(int argc, char *argv[])
{
    3c40:	55                   	push   %ebp
    3c41:	89 e5                	mov    %esp,%ebp
    3c43:	83 e4 f0             	and    $0xfffffff0,%esp
    3c46:	83 ec 10             	sub    $0x10,%esp
  printf(1, "usertests starting\n");
    3c49:	c7 44 24 04 46 54 00 	movl   $0x5446,0x4(%esp)
    3c50:	00 
    3c51:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    3c58:	e8 93 04 00 00       	call   40f0 <printf>

  if(open("usertests.ran", 0) >= 0){
    3c5d:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    3c64:	00 
    3c65:	c7 04 24 5a 54 00 00 	movl   $0x545a,(%esp)
    3c6c:	e8 77 03 00 00       	call   3fe8 <open>
    3c71:	85 c0                	test   %eax,%eax
    3c73:	78 23                	js     3c98 <main+0x58>
    printf(1, "already ran user tests -- rebuild fs.img\n");
    3c75:	c7 44 24 04 c4 5b 00 	movl   $0x5bc4,0x4(%esp)
    3c7c:	00 
    3c7d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    3c84:	e8 67 04 00 00       	call   40f0 <printf>
    exit(0);
    3c89:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3c90:	e8 13 03 00 00       	call   3fa8 <exit>
    3c95:	8d 76 00             	lea    0x0(%esi),%esi
  }
  close(open("usertests.ran", O_CREATE));
    3c98:	c7 44 24 04 00 02 00 	movl   $0x200,0x4(%esp)
    3c9f:	00 
    3ca0:	c7 04 24 5a 54 00 00 	movl   $0x545a,(%esp)
    3ca7:	e8 3c 03 00 00       	call   3fe8 <open>
    3cac:	89 04 24             	mov    %eax,(%esp)
    3caf:	e8 1c 03 00 00       	call   3fd0 <close>

  argptest();
    3cb4:	e8 97 c4 ff ff       	call   150 <argptest>
  createdelete();
    3cb9:	e8 62 cc ff ff       	call   920 <createdelete>
    3cbe:	66 90                	xchg   %ax,%ax
  linkunlink();
    3cc0:	e8 ab d6 ff ff       	call   1370 <linkunlink>
  concreate();
    3cc5:	e8 06 f7 ff ff       	call   33d0 <concreate>
  fourfiles();
    3cca:	e8 61 fa ff ff       	call   3730 <fourfiles>
    3ccf:	90                   	nop
  sharedfd();
    3cd0:	e8 ab fc ff ff       	call   3980 <sharedfd>

  bigargtest();
    3cd5:	e8 f6 d2 ff ff       	call   fd0 <bigargtest>
  bigwrite();
    3cda:	e8 31 c9 ff ff       	call   610 <bigwrite>
    3cdf:	90                   	nop
  bigargtest();
    3ce0:	e8 eb d2 ff ff       	call   fd0 <bigargtest>
  bsstest();
    3ce5:	e8 46 c3 ff ff       	call   30 <bsstest>
  sbrktest();
    3cea:	e8 51 da ff ff       	call   1740 <sbrktest>
    3cef:	90                   	nop
  validatetest();
    3cf0:	e8 5b d4 ff ff       	call   1150 <validatetest>

  opentest();
    3cf5:	e8 b6 c3 ff ff       	call   b0 <opentest>
  writetest();
    3cfa:	e8 01 d1 ff ff       	call   e00 <writetest>
    3cff:	90                   	nop
  writetest1();
    3d00:	e8 3b cf ff ff       	call   c40 <writetest1>
  createtest();
    3d05:	e8 86 ce ff ff       	call   b90 <createtest>

  openiputtest();
    3d0a:	e8 31 e3 ff ff       	call   2040 <openiputtest>
    3d0f:	90                   	nop
  exitiputtest();
    3d10:	e8 eb f2 ff ff       	call   3000 <exitiputtest>
  iputtest();
    3d15:	e8 c6 f3 ff ff       	call   30e0 <iputtest>

  mem();
    3d1a:	e8 41 fe ff ff       	call   3b60 <mem>
    3d1f:	90                   	nop
  pipe1();
    3d20:	e8 cb df ff ff       	call   1cf0 <pipe1>
  preempt();
    3d25:	e8 56 de ff ff       	call   1b80 <preempt>
  exitwait();
    3d2a:	e8 31 c6 ff ff       	call   360 <exitwait>
    3d2f:	90                   	nop

  rmdot();
    3d30:	e8 bb e7 ff ff       	call   24f0 <rmdot>
  fourteen();
    3d35:	e8 86 e1 ff ff       	call   1ec0 <fourteen>
  bigfile();
    3d3a:	e8 61 f4 ff ff       	call   31a0 <bigfile>
    3d3f:	90                   	nop
  subdir();
    3d40:	e8 7b e9 ff ff       	call   26c0 <subdir>
  linktest();
    3d45:	e8 56 d7 ff ff       	call   14a0 <linktest>
  unlinkread();
    3d4a:	e8 d1 c9 ff ff       	call   720 <unlinkread>
    3d4f:	90                   	nop
  dirfile();
    3d50:	e8 1b e5 ff ff       	call   2270 <dirfile>
  iref();
    3d55:	e8 e6 e3 ff ff       	call   2140 <iref>
  forktest();
    3d5a:	e8 21 c5 ff ff       	call   280 <forktest>
    3d5f:	90                   	nop
  bigdir(); // slow
    3d60:	e8 ab d4 ff ff       	call   1210 <bigdir>

  uio();
    3d65:	e8 76 c4 ff ff       	call   1e0 <uio>

  exectest();
    3d6a:	e8 81 d3 ff ff       	call   10f0 <exectest>

  exit(0);
    3d6f:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3d76:	e8 2d 02 00 00       	call   3fa8 <exit>
    3d7b:	90                   	nop
    3d7c:	90                   	nop
    3d7d:	90                   	nop
    3d7e:	90                   	nop
    3d7f:	90                   	nop

00003d80 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
    3d80:	55                   	push   %ebp
    3d81:	31 d2                	xor    %edx,%edx
    3d83:	89 e5                	mov    %esp,%ebp
    3d85:	8b 45 08             	mov    0x8(%ebp),%eax
    3d88:	53                   	push   %ebx
    3d89:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    3d8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
    3d90:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
    3d94:	88 0c 10             	mov    %cl,(%eax,%edx,1)
    3d97:	83 c2 01             	add    $0x1,%edx
    3d9a:	84 c9                	test   %cl,%cl
    3d9c:	75 f2                	jne    3d90 <strcpy+0x10>
    ;
  return os;
}
    3d9e:	5b                   	pop    %ebx
    3d9f:	5d                   	pop    %ebp
    3da0:	c3                   	ret    
    3da1:	eb 0d                	jmp    3db0 <strcmp>
    3da3:	90                   	nop
    3da4:	90                   	nop
    3da5:	90                   	nop
    3da6:	90                   	nop
    3da7:	90                   	nop
    3da8:	90                   	nop
    3da9:	90                   	nop
    3daa:	90                   	nop
    3dab:	90                   	nop
    3dac:	90                   	nop
    3dad:	90                   	nop
    3dae:	90                   	nop
    3daf:	90                   	nop

00003db0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    3db0:	55                   	push   %ebp
    3db1:	89 e5                	mov    %esp,%ebp
    3db3:	8b 4d 08             	mov    0x8(%ebp),%ecx
    3db6:	53                   	push   %ebx
    3db7:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(*p && *p == *q)
    3dba:	0f b6 01             	movzbl (%ecx),%eax
    3dbd:	84 c0                	test   %al,%al
    3dbf:	75 14                	jne    3dd5 <strcmp+0x25>
    3dc1:	eb 25                	jmp    3de8 <strcmp+0x38>
    3dc3:	90                   	nop
    3dc4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    p++, q++;
    3dc8:	83 c1 01             	add    $0x1,%ecx
    3dcb:	83 c2 01             	add    $0x1,%edx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
    3dce:	0f b6 01             	movzbl (%ecx),%eax
    3dd1:	84 c0                	test   %al,%al
    3dd3:	74 13                	je     3de8 <strcmp+0x38>
    3dd5:	0f b6 1a             	movzbl (%edx),%ebx
    3dd8:	38 d8                	cmp    %bl,%al
    3dda:	74 ec                	je     3dc8 <strcmp+0x18>
    3ddc:	0f b6 db             	movzbl %bl,%ebx
    3ddf:	0f b6 c0             	movzbl %al,%eax
    3de2:	29 d8                	sub    %ebx,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
    3de4:	5b                   	pop    %ebx
    3de5:	5d                   	pop    %ebp
    3de6:	c3                   	ret    
    3de7:	90                   	nop
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
    3de8:	0f b6 1a             	movzbl (%edx),%ebx
    3deb:	31 c0                	xor    %eax,%eax
    3ded:	0f b6 db             	movzbl %bl,%ebx
    3df0:	29 d8                	sub    %ebx,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
    3df2:	5b                   	pop    %ebx
    3df3:	5d                   	pop    %ebp
    3df4:	c3                   	ret    
    3df5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    3df9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00003e00 <strlen>:

uint
strlen(char *s)
{
    3e00:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
    3e01:	31 d2                	xor    %edx,%edx
  return (uchar)*p - (uchar)*q;
}

uint
strlen(char *s)
{
    3e03:	89 e5                	mov    %esp,%ebp
  int n;

  for(n = 0; s[n]; n++)
    3e05:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
}

uint
strlen(char *s)
{
    3e07:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
    3e0a:	80 39 00             	cmpb   $0x0,(%ecx)
    3e0d:	74 0c                	je     3e1b <strlen+0x1b>
    3e0f:	90                   	nop
    3e10:	83 c2 01             	add    $0x1,%edx
    3e13:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
    3e17:	89 d0                	mov    %edx,%eax
    3e19:	75 f5                	jne    3e10 <strlen+0x10>
    ;
  return n;
}
    3e1b:	5d                   	pop    %ebp
    3e1c:	c3                   	ret    
    3e1d:	8d 76 00             	lea    0x0(%esi),%esi

00003e20 <memset>:

void*
memset(void *dst, int c, uint n)
{
    3e20:	55                   	push   %ebp
    3e21:	89 e5                	mov    %esp,%ebp
    3e23:	8b 55 08             	mov    0x8(%ebp),%edx
    3e26:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
    3e27:	8b 4d 10             	mov    0x10(%ebp),%ecx
    3e2a:	8b 45 0c             	mov    0xc(%ebp),%eax
    3e2d:	89 d7                	mov    %edx,%edi
    3e2f:	fc                   	cld    
    3e30:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
    3e32:	89 d0                	mov    %edx,%eax
    3e34:	5f                   	pop    %edi
    3e35:	5d                   	pop    %ebp
    3e36:	c3                   	ret    
    3e37:	89 f6                	mov    %esi,%esi
    3e39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00003e40 <strchr>:

char*
strchr(const char *s, char c)
{
    3e40:	55                   	push   %ebp
    3e41:	89 e5                	mov    %esp,%ebp
    3e43:	8b 45 08             	mov    0x8(%ebp),%eax
    3e46:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
    3e4a:	0f b6 10             	movzbl (%eax),%edx
    3e4d:	84 d2                	test   %dl,%dl
    3e4f:	75 11                	jne    3e62 <strchr+0x22>
    3e51:	eb 15                	jmp    3e68 <strchr+0x28>
    3e53:	90                   	nop
    3e54:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    3e58:	83 c0 01             	add    $0x1,%eax
    3e5b:	0f b6 10             	movzbl (%eax),%edx
    3e5e:	84 d2                	test   %dl,%dl
    3e60:	74 06                	je     3e68 <strchr+0x28>
    if(*s == c)
    3e62:	38 ca                	cmp    %cl,%dl
    3e64:	75 f2                	jne    3e58 <strchr+0x18>
      return (char*)s;
  return 0;
}
    3e66:	5d                   	pop    %ebp
    3e67:	c3                   	ret    
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
    3e68:	31 c0                	xor    %eax,%eax
    if(*s == c)
      return (char*)s;
  return 0;
}
    3e6a:	5d                   	pop    %ebp
    3e6b:	90                   	nop
    3e6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    3e70:	c3                   	ret    
    3e71:	eb 0d                	jmp    3e80 <atoi>
    3e73:	90                   	nop
    3e74:	90                   	nop
    3e75:	90                   	nop
    3e76:	90                   	nop
    3e77:	90                   	nop
    3e78:	90                   	nop
    3e79:	90                   	nop
    3e7a:	90                   	nop
    3e7b:	90                   	nop
    3e7c:	90                   	nop
    3e7d:	90                   	nop
    3e7e:	90                   	nop
    3e7f:	90                   	nop

00003e80 <atoi>:
  return r;
}

int
atoi(const char *s)
{
    3e80:	55                   	push   %ebp
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    3e81:	31 c0                	xor    %eax,%eax
  return r;
}

int
atoi(const char *s)
{
    3e83:	89 e5                	mov    %esp,%ebp
    3e85:	8b 4d 08             	mov    0x8(%ebp),%ecx
    3e88:	53                   	push   %ebx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    3e89:	0f b6 11             	movzbl (%ecx),%edx
    3e8c:	8d 5a d0             	lea    -0x30(%edx),%ebx
    3e8f:	80 fb 09             	cmp    $0x9,%bl
    3e92:	77 1c                	ja     3eb0 <atoi+0x30>
    3e94:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    n = n*10 + *s++ - '0';
    3e98:	0f be d2             	movsbl %dl,%edx
    3e9b:	83 c1 01             	add    $0x1,%ecx
    3e9e:	8d 04 80             	lea    (%eax,%eax,4),%eax
    3ea1:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    3ea5:	0f b6 11             	movzbl (%ecx),%edx
    3ea8:	8d 5a d0             	lea    -0x30(%edx),%ebx
    3eab:	80 fb 09             	cmp    $0x9,%bl
    3eae:	76 e8                	jbe    3e98 <atoi+0x18>
    n = n*10 + *s++ - '0';
  return n;
}
    3eb0:	5b                   	pop    %ebx
    3eb1:	5d                   	pop    %ebp
    3eb2:	c3                   	ret    
    3eb3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    3eb9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00003ec0 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
    3ec0:	55                   	push   %ebp
    3ec1:	89 e5                	mov    %esp,%ebp
    3ec3:	56                   	push   %esi
    3ec4:	8b 45 08             	mov    0x8(%ebp),%eax
    3ec7:	53                   	push   %ebx
    3ec8:	8b 5d 10             	mov    0x10(%ebp),%ebx
    3ecb:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    3ece:	85 db                	test   %ebx,%ebx
    3ed0:	7e 14                	jle    3ee6 <memmove+0x26>
    n = n*10 + *s++ - '0';
  return n;
}

void*
memmove(void *vdst, void *vsrc, int n)
    3ed2:	31 d2                	xor    %edx,%edx
    3ed4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    *dst++ = *src++;
    3ed8:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
    3edc:	88 0c 10             	mov    %cl,(%eax,%edx,1)
    3edf:	83 c2 01             	add    $0x1,%edx
{
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    3ee2:	39 da                	cmp    %ebx,%edx
    3ee4:	75 f2                	jne    3ed8 <memmove+0x18>
    *dst++ = *src++;
  return vdst;
}
    3ee6:	5b                   	pop    %ebx
    3ee7:	5e                   	pop    %esi
    3ee8:	5d                   	pop    %ebp
    3ee9:	c3                   	ret    
    3eea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00003ef0 <stat>:
  return buf;
}

int
stat(char *n, struct stat *st)
{
    3ef0:	55                   	push   %ebp
    3ef1:	89 e5                	mov    %esp,%ebp
    3ef3:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    3ef6:	8b 45 08             	mov    0x8(%ebp),%eax
  return buf;
}

int
stat(char *n, struct stat *st)
{
    3ef9:	89 5d f8             	mov    %ebx,-0x8(%ebp)
    3efc:	89 75 fc             	mov    %esi,-0x4(%ebp)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    3eff:	be ff ff ff ff       	mov    $0xffffffff,%esi
stat(char *n, struct stat *st)
{
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    3f04:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    3f0b:	00 
    3f0c:	89 04 24             	mov    %eax,(%esp)
    3f0f:	e8 d4 00 00 00       	call   3fe8 <open>
  if(fd < 0)
    3f14:	85 c0                	test   %eax,%eax
stat(char *n, struct stat *st)
{
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    3f16:	89 c3                	mov    %eax,%ebx
  if(fd < 0)
    3f18:	78 19                	js     3f33 <stat+0x43>
    return -1;
  r = fstat(fd, st);
    3f1a:	8b 45 0c             	mov    0xc(%ebp),%eax
    3f1d:	89 1c 24             	mov    %ebx,(%esp)
    3f20:	89 44 24 04          	mov    %eax,0x4(%esp)
    3f24:	e8 d7 00 00 00       	call   4000 <fstat>
  close(fd);
    3f29:	89 1c 24             	mov    %ebx,(%esp)
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
  r = fstat(fd, st);
    3f2c:	89 c6                	mov    %eax,%esi
  close(fd);
    3f2e:	e8 9d 00 00 00       	call   3fd0 <close>
  return r;
}
    3f33:	89 f0                	mov    %esi,%eax
    3f35:	8b 5d f8             	mov    -0x8(%ebp),%ebx
    3f38:	8b 75 fc             	mov    -0x4(%ebp),%esi
    3f3b:	89 ec                	mov    %ebp,%esp
    3f3d:	5d                   	pop    %ebp
    3f3e:	c3                   	ret    
    3f3f:	90                   	nop

00003f40 <gets>:
  return 0;
}

char*
gets(char *buf, int max)
{
    3f40:	55                   	push   %ebp
    3f41:	89 e5                	mov    %esp,%ebp
    3f43:	57                   	push   %edi
    3f44:	56                   	push   %esi
    3f45:	31 f6                	xor    %esi,%esi
    3f47:	53                   	push   %ebx
    3f48:	83 ec 2c             	sub    $0x2c,%esp
    3f4b:	8b 7d 08             	mov    0x8(%ebp),%edi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    3f4e:	eb 06                	jmp    3f56 <gets+0x16>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
    3f50:	3c 0a                	cmp    $0xa,%al
    3f52:	74 39                	je     3f8d <gets+0x4d>
    3f54:	89 de                	mov    %ebx,%esi
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    3f56:	8d 5e 01             	lea    0x1(%esi),%ebx
    3f59:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
    3f5c:	7d 31                	jge    3f8f <gets+0x4f>
    cc = read(0, &c, 1);
    3f5e:	8d 45 e7             	lea    -0x19(%ebp),%eax
    3f61:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    3f68:	00 
    3f69:	89 44 24 04          	mov    %eax,0x4(%esp)
    3f6d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3f74:	e8 47 00 00 00       	call   3fc0 <read>
    if(cc < 1)
    3f79:	85 c0                	test   %eax,%eax
    3f7b:	7e 12                	jle    3f8f <gets+0x4f>
      break;
    buf[i++] = c;
    3f7d:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
    3f81:	88 44 1f ff          	mov    %al,-0x1(%edi,%ebx,1)
    if(c == '\n' || c == '\r')
    3f85:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
    3f89:	3c 0d                	cmp    $0xd,%al
    3f8b:	75 c3                	jne    3f50 <gets+0x10>
    3f8d:	89 de                	mov    %ebx,%esi
      break;
  }
  buf[i] = '\0';
    3f8f:	c6 04 37 00          	movb   $0x0,(%edi,%esi,1)
  return buf;
}
    3f93:	89 f8                	mov    %edi,%eax
    3f95:	83 c4 2c             	add    $0x2c,%esp
    3f98:	5b                   	pop    %ebx
    3f99:	5e                   	pop    %esi
    3f9a:	5f                   	pop    %edi
    3f9b:	5d                   	pop    %ebp
    3f9c:	c3                   	ret    
    3f9d:	90                   	nop
    3f9e:	90                   	nop
    3f9f:	90                   	nop

00003fa0 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    3fa0:	b8 01 00 00 00       	mov    $0x1,%eax
    3fa5:	cd 40                	int    $0x40
    3fa7:	c3                   	ret    

00003fa8 <exit>:
SYSCALL(exit)
    3fa8:	b8 02 00 00 00       	mov    $0x2,%eax
    3fad:	cd 40                	int    $0x40
    3faf:	c3                   	ret    

00003fb0 <wait>:
SYSCALL(wait)
    3fb0:	b8 03 00 00 00       	mov    $0x3,%eax
    3fb5:	cd 40                	int    $0x40
    3fb7:	c3                   	ret    

00003fb8 <pipe>:
SYSCALL(pipe)
    3fb8:	b8 04 00 00 00       	mov    $0x4,%eax
    3fbd:	cd 40                	int    $0x40
    3fbf:	c3                   	ret    

00003fc0 <read>:
SYSCALL(read)
    3fc0:	b8 05 00 00 00       	mov    $0x5,%eax
    3fc5:	cd 40                	int    $0x40
    3fc7:	c3                   	ret    

00003fc8 <write>:
SYSCALL(write)
    3fc8:	b8 10 00 00 00       	mov    $0x10,%eax
    3fcd:	cd 40                	int    $0x40
    3fcf:	c3                   	ret    

00003fd0 <close>:
SYSCALL(close)
    3fd0:	b8 15 00 00 00       	mov    $0x15,%eax
    3fd5:	cd 40                	int    $0x40
    3fd7:	c3                   	ret    

00003fd8 <kill>:
SYSCALL(kill)
    3fd8:	b8 06 00 00 00       	mov    $0x6,%eax
    3fdd:	cd 40                	int    $0x40
    3fdf:	c3                   	ret    

00003fe0 <exec>:
SYSCALL(exec)
    3fe0:	b8 07 00 00 00       	mov    $0x7,%eax
    3fe5:	cd 40                	int    $0x40
    3fe7:	c3                   	ret    

00003fe8 <open>:
SYSCALL(open)
    3fe8:	b8 0f 00 00 00       	mov    $0xf,%eax
    3fed:	cd 40                	int    $0x40
    3fef:	c3                   	ret    

00003ff0 <mknod>:
SYSCALL(mknod)
    3ff0:	b8 11 00 00 00       	mov    $0x11,%eax
    3ff5:	cd 40                	int    $0x40
    3ff7:	c3                   	ret    

00003ff8 <unlink>:
SYSCALL(unlink)
    3ff8:	b8 12 00 00 00       	mov    $0x12,%eax
    3ffd:	cd 40                	int    $0x40
    3fff:	c3                   	ret    

00004000 <fstat>:
SYSCALL(fstat)
    4000:	b8 08 00 00 00       	mov    $0x8,%eax
    4005:	cd 40                	int    $0x40
    4007:	c3                   	ret    

00004008 <link>:
SYSCALL(link)
    4008:	b8 13 00 00 00       	mov    $0x13,%eax
    400d:	cd 40                	int    $0x40
    400f:	c3                   	ret    

00004010 <mkdir>:
SYSCALL(mkdir)
    4010:	b8 14 00 00 00       	mov    $0x14,%eax
    4015:	cd 40                	int    $0x40
    4017:	c3                   	ret    

00004018 <chdir>:
SYSCALL(chdir)
    4018:	b8 09 00 00 00       	mov    $0x9,%eax
    401d:	cd 40                	int    $0x40
    401f:	c3                   	ret    

00004020 <dup>:
SYSCALL(dup)
    4020:	b8 0a 00 00 00       	mov    $0xa,%eax
    4025:	cd 40                	int    $0x40
    4027:	c3                   	ret    

00004028 <getpid>:
SYSCALL(getpid)
    4028:	b8 0b 00 00 00       	mov    $0xb,%eax
    402d:	cd 40                	int    $0x40
    402f:	c3                   	ret    

00004030 <sbrk>:
SYSCALL(sbrk)
    4030:	b8 0c 00 00 00       	mov    $0xc,%eax
    4035:	cd 40                	int    $0x40
    4037:	c3                   	ret    

00004038 <sleep>:
SYSCALL(sleep)
    4038:	b8 0d 00 00 00       	mov    $0xd,%eax
    403d:	cd 40                	int    $0x40
    403f:	c3                   	ret    

00004040 <uptime>:
SYSCALL(uptime)
    4040:	b8 0e 00 00 00       	mov    $0xe,%eax
    4045:	cd 40                	int    $0x40
    4047:	c3                   	ret    

00004048 <hello>:
SYSCALL(hello) 			// added for Lab0
    4048:	b8 16 00 00 00       	mov    $0x16,%eax
    404d:	cd 40                	int    $0x40
    404f:	c3                   	ret    

00004050 <waitpid>:
SYSCALL(waitpid) 		// lab1 part 1: c
    4050:	b8 17 00 00 00       	mov    $0x17,%eax
    4055:	cd 40                	int    $0x40
    4057:	c3                   	ret    

00004058 <setpriority>:
SYSCALL(setpriority) 	// lab1 part 2: define syscall
    4058:	b8 18 00 00 00       	mov    $0x18,%eax
    405d:	cd 40                	int    $0x40
    405f:	c3                   	ret    

00004060 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
    4060:	55                   	push   %ebp
    4061:	89 e5                	mov    %esp,%ebp
    4063:	57                   	push   %edi
    4064:	89 cf                	mov    %ecx,%edi
    4066:	56                   	push   %esi
    4067:	89 c6                	mov    %eax,%esi
    4069:	53                   	push   %ebx
    406a:	83 ec 4c             	sub    $0x4c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    406d:	8b 4d 08             	mov    0x8(%ebp),%ecx
    4070:	85 c9                	test   %ecx,%ecx
    4072:	74 04                	je     4078 <printint+0x18>
    4074:	85 d2                	test   %edx,%edx
    4076:	78 68                	js     40e0 <printint+0x80>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
    4078:	89 d0                	mov    %edx,%eax
    407a:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
    4081:	31 c9                	xor    %ecx,%ecx
    4083:	8d 5d d7             	lea    -0x29(%ebp),%ebx
    4086:	66 90                	xchg   %ax,%ax
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
    4088:	31 d2                	xor    %edx,%edx
    408a:	f7 f7                	div    %edi
    408c:	0f b6 92 f7 5b 00 00 	movzbl 0x5bf7(%edx),%edx
    4093:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
    4096:	83 c1 01             	add    $0x1,%ecx
  }while((x /= base) != 0);
    4099:	85 c0                	test   %eax,%eax
    409b:	75 eb                	jne    4088 <printint+0x28>
  if(neg)
    409d:	8b 45 c4             	mov    -0x3c(%ebp),%eax
    40a0:	85 c0                	test   %eax,%eax
    40a2:	74 08                	je     40ac <printint+0x4c>
    buf[i++] = '-';
    40a4:	c6 44 0d d7 2d       	movb   $0x2d,-0x29(%ebp,%ecx,1)
    40a9:	83 c1 01             	add    $0x1,%ecx

  while(--i >= 0)
    40ac:	8d 79 ff             	lea    -0x1(%ecx),%edi
    40af:	90                   	nop
    40b0:	0f b6 04 3b          	movzbl (%ebx,%edi,1),%eax
    40b4:	83 ef 01             	sub    $0x1,%edi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    40b7:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    40be:	00 
    40bf:	89 34 24             	mov    %esi,(%esp)
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
    40c2:	88 45 e7             	mov    %al,-0x19(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    40c5:	8d 45 e7             	lea    -0x19(%ebp),%eax
    40c8:	89 44 24 04          	mov    %eax,0x4(%esp)
    40cc:	e8 f7 fe ff ff       	call   3fc8 <write>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
    40d1:	83 ff ff             	cmp    $0xffffffff,%edi
    40d4:	75 da                	jne    40b0 <printint+0x50>
    putc(fd, buf[i]);
}
    40d6:	83 c4 4c             	add    $0x4c,%esp
    40d9:	5b                   	pop    %ebx
    40da:	5e                   	pop    %esi
    40db:	5f                   	pop    %edi
    40dc:	5d                   	pop    %ebp
    40dd:	c3                   	ret    
    40de:	66 90                	xchg   %ax,%ax
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
    40e0:	89 d0                	mov    %edx,%eax
    40e2:	f7 d8                	neg    %eax
    40e4:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
    40eb:	eb 94                	jmp    4081 <printint+0x21>
    40ed:	8d 76 00             	lea    0x0(%esi),%esi

000040f0 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
    40f0:	55                   	push   %ebp
    40f1:	89 e5                	mov    %esp,%ebp
    40f3:	57                   	push   %edi
    40f4:	56                   	push   %esi
    40f5:	53                   	push   %ebx
    40f6:	83 ec 3c             	sub    $0x3c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    40f9:	8b 45 0c             	mov    0xc(%ebp),%eax
    40fc:	0f b6 10             	movzbl (%eax),%edx
    40ff:	84 d2                	test   %dl,%dl
    4101:	0f 84 c1 00 00 00    	je     41c8 <printf+0xd8>
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
    4107:	8d 4d 10             	lea    0x10(%ebp),%ecx
    410a:	31 ff                	xor    %edi,%edi
    410c:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
    410f:	31 db                	xor    %ebx,%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    4111:	8d 75 e7             	lea    -0x19(%ebp),%esi
    4114:	eb 1e                	jmp    4134 <printf+0x44>
    4116:	66 90                	xchg   %ax,%ax
  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
    4118:	83 fa 25             	cmp    $0x25,%edx
    411b:	0f 85 af 00 00 00    	jne    41d0 <printf+0xe0>
    4121:	66 bf 25 00          	mov    $0x25,%di
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    4125:	83 c3 01             	add    $0x1,%ebx
    4128:	0f b6 14 18          	movzbl (%eax,%ebx,1),%edx
    412c:	84 d2                	test   %dl,%dl
    412e:	0f 84 94 00 00 00    	je     41c8 <printf+0xd8>
    c = fmt[i] & 0xff;
    if(state == 0){
    4134:	85 ff                	test   %edi,%edi
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    4136:	0f b6 d2             	movzbl %dl,%edx
    if(state == 0){
    4139:	74 dd                	je     4118 <printf+0x28>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
    413b:	83 ff 25             	cmp    $0x25,%edi
    413e:	75 e5                	jne    4125 <printf+0x35>
      if(c == 'd'){
    4140:	83 fa 64             	cmp    $0x64,%edx
    4143:	0f 84 3f 01 00 00    	je     4288 <printf+0x198>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
    4149:	83 fa 70             	cmp    $0x70,%edx
    414c:	0f 84 a6 00 00 00    	je     41f8 <printf+0x108>
    4152:	83 fa 78             	cmp    $0x78,%edx
    4155:	0f 84 9d 00 00 00    	je     41f8 <printf+0x108>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
    415b:	83 fa 73             	cmp    $0x73,%edx
    415e:	66 90                	xchg   %ax,%ax
    4160:	0f 84 ba 00 00 00    	je     4220 <printf+0x130>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    4166:	83 fa 63             	cmp    $0x63,%edx
    4169:	0f 84 41 01 00 00    	je     42b0 <printf+0x1c0>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
    416f:	83 fa 25             	cmp    $0x25,%edx
    4172:	0f 84 00 01 00 00    	je     4278 <printf+0x188>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    4178:	8b 4d 08             	mov    0x8(%ebp),%ecx
    417b:	89 55 cc             	mov    %edx,-0x34(%ebp)
    417e:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
    4182:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    4189:	00 
    418a:	89 74 24 04          	mov    %esi,0x4(%esp)
    418e:	89 0c 24             	mov    %ecx,(%esp)
    4191:	e8 32 fe ff ff       	call   3fc8 <write>
    4196:	8b 55 cc             	mov    -0x34(%ebp),%edx
    4199:	88 55 e7             	mov    %dl,-0x19(%ebp)
    419c:	8b 45 08             	mov    0x8(%ebp),%eax
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    419f:	83 c3 01             	add    $0x1,%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    41a2:	31 ff                	xor    %edi,%edi
    41a4:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    41ab:	00 
    41ac:	89 74 24 04          	mov    %esi,0x4(%esp)
    41b0:	89 04 24             	mov    %eax,(%esp)
    41b3:	e8 10 fe ff ff       	call   3fc8 <write>
    41b8:	8b 45 0c             	mov    0xc(%ebp),%eax
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    41bb:	0f b6 14 18          	movzbl (%eax,%ebx,1),%edx
    41bf:	84 d2                	test   %dl,%dl
    41c1:	0f 85 6d ff ff ff    	jne    4134 <printf+0x44>
    41c7:	90                   	nop
        putc(fd, c);
      }
      state = 0;
    }
  }
}
    41c8:	83 c4 3c             	add    $0x3c,%esp
    41cb:	5b                   	pop    %ebx
    41cc:	5e                   	pop    %esi
    41cd:	5f                   	pop    %edi
    41ce:	5d                   	pop    %ebp
    41cf:	c3                   	ret    
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    41d0:	8b 45 08             	mov    0x8(%ebp),%eax
  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
    41d3:	88 55 e7             	mov    %dl,-0x19(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    41d6:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    41dd:	00 
    41de:	89 74 24 04          	mov    %esi,0x4(%esp)
    41e2:	89 04 24             	mov    %eax,(%esp)
    41e5:	e8 de fd ff ff       	call   3fc8 <write>
    41ea:	8b 45 0c             	mov    0xc(%ebp),%eax
    41ed:	e9 33 ff ff ff       	jmp    4125 <printf+0x35>
    41f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
    41f8:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    41fb:	b9 10 00 00 00       	mov    $0x10,%ecx
        ap++;
    4200:	31 ff                	xor    %edi,%edi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
    4202:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    4209:	8b 10                	mov    (%eax),%edx
    420b:	8b 45 08             	mov    0x8(%ebp),%eax
    420e:	e8 4d fe ff ff       	call   4060 <printint>
    4213:	8b 45 0c             	mov    0xc(%ebp),%eax
        ap++;
    4216:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
    421a:	e9 06 ff ff ff       	jmp    4125 <printf+0x35>
    421f:	90                   	nop
      } else if(c == 's'){
        s = (char*)*ap;
    4220:	8b 55 d4             	mov    -0x2c(%ebp),%edx
        ap++;
        if(s == 0)
    4223:	b9 f0 5b 00 00       	mov    $0x5bf0,%ecx
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
        s = (char*)*ap;
    4228:	8b 3a                	mov    (%edx),%edi
        ap++;
    422a:	83 c2 04             	add    $0x4,%edx
    422d:	89 55 d4             	mov    %edx,-0x2c(%ebp)
        if(s == 0)
    4230:	85 ff                	test   %edi,%edi
    4232:	0f 44 f9             	cmove  %ecx,%edi
          s = "(null)";
        while(*s != 0){
    4235:	0f b6 17             	movzbl (%edi),%edx
    4238:	84 d2                	test   %dl,%dl
    423a:	74 33                	je     426f <printf+0x17f>
    423c:	89 5d d0             	mov    %ebx,-0x30(%ebp)
    423f:	8b 5d 08             	mov    0x8(%ebp),%ebx
    4242:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
          putc(fd, *s);
          s++;
    4248:	83 c7 01             	add    $0x1,%edi
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
    424b:	88 55 e7             	mov    %dl,-0x19(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    424e:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    4255:	00 
    4256:	89 74 24 04          	mov    %esi,0x4(%esp)
    425a:	89 1c 24             	mov    %ebx,(%esp)
    425d:	e8 66 fd ff ff       	call   3fc8 <write>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
    4262:	0f b6 17             	movzbl (%edi),%edx
    4265:	84 d2                	test   %dl,%dl
    4267:	75 df                	jne    4248 <printf+0x158>
    4269:	8b 5d d0             	mov    -0x30(%ebp),%ebx
    426c:	8b 45 0c             	mov    0xc(%ebp),%eax
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    426f:	31 ff                	xor    %edi,%edi
    4271:	e9 af fe ff ff       	jmp    4125 <printf+0x35>
    4276:	66 90                	xchg   %ax,%ax
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
    4278:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
    427c:	e9 1b ff ff ff       	jmp    419c <printf+0xac>
    4281:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
    4288:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    428b:	b9 0a 00 00 00       	mov    $0xa,%ecx
        ap++;
    4290:	66 31 ff             	xor    %di,%di
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
    4293:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    429a:	8b 10                	mov    (%eax),%edx
    429c:	8b 45 08             	mov    0x8(%ebp),%eax
    429f:	e8 bc fd ff ff       	call   4060 <printint>
    42a4:	8b 45 0c             	mov    0xc(%ebp),%eax
        ap++;
    42a7:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
    42ab:	e9 75 fe ff ff       	jmp    4125 <printf+0x35>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    42b0:	8b 55 d4             	mov    -0x2c(%ebp),%edx
        putc(fd, *ap);
        ap++;
    42b3:	31 ff                	xor    %edi,%edi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    42b5:	8b 4d 08             	mov    0x8(%ebp),%ecx
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    42b8:	8b 02                	mov    (%edx),%eax
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    42ba:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    42c1:	00 
    42c2:	89 74 24 04          	mov    %esi,0x4(%esp)
    42c6:	89 0c 24             	mov    %ecx,(%esp)
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    42c9:	88 45 e7             	mov    %al,-0x19(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    42cc:	e8 f7 fc ff ff       	call   3fc8 <write>
    42d1:	8b 45 0c             	mov    0xc(%ebp),%eax
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
        ap++;
    42d4:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
    42d8:	e9 48 fe ff ff       	jmp    4125 <printf+0x35>
    42dd:	90                   	nop
    42de:	90                   	nop
    42df:	90                   	nop

000042e0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    42e0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    42e1:	a1 c8 5c 00 00       	mov    0x5cc8,%eax
static Header base;
static Header *freep;

void
free(void *ap)
{
    42e6:	89 e5                	mov    %esp,%ebp
    42e8:	57                   	push   %edi
    42e9:	56                   	push   %esi
    42ea:	53                   	push   %ebx
    42eb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
    42ee:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    42f1:	39 c8                	cmp    %ecx,%eax
    42f3:	73 1d                	jae    4312 <free+0x32>
    42f5:	8d 76 00             	lea    0x0(%esi),%esi
    42f8:	8b 10                	mov    (%eax),%edx
    42fa:	39 d1                	cmp    %edx,%ecx
    42fc:	72 1a                	jb     4318 <free+0x38>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    42fe:	39 d0                	cmp    %edx,%eax
    4300:	72 08                	jb     430a <free+0x2a>
    4302:	39 c8                	cmp    %ecx,%eax
    4304:	72 12                	jb     4318 <free+0x38>
    4306:	39 d1                	cmp    %edx,%ecx
    4308:	72 0e                	jb     4318 <free+0x38>
    430a:	89 d0                	mov    %edx,%eax
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    430c:	39 c8                	cmp    %ecx,%eax
    430e:	66 90                	xchg   %ax,%ax
    4310:	72 e6                	jb     42f8 <free+0x18>
    4312:	8b 10                	mov    (%eax),%edx
    4314:	eb e8                	jmp    42fe <free+0x1e>
    4316:	66 90                	xchg   %ax,%ax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    4318:	8b 71 04             	mov    0x4(%ecx),%esi
    431b:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    431e:	39 d7                	cmp    %edx,%edi
    4320:	74 19                	je     433b <free+0x5b>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
    4322:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    4325:	8b 50 04             	mov    0x4(%eax),%edx
    4328:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    432b:	39 ce                	cmp    %ecx,%esi
    432d:	74 23                	je     4352 <free+0x72>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
    432f:	89 08                	mov    %ecx,(%eax)
  freep = p;
    4331:	a3 c8 5c 00 00       	mov    %eax,0x5cc8
}
    4336:	5b                   	pop    %ebx
    4337:	5e                   	pop    %esi
    4338:	5f                   	pop    %edi
    4339:	5d                   	pop    %ebp
    433a:	c3                   	ret    
  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
    433b:	03 72 04             	add    0x4(%edx),%esi
    433e:	89 71 04             	mov    %esi,0x4(%ecx)
    bp->s.ptr = p->s.ptr->s.ptr;
    4341:	8b 10                	mov    (%eax),%edx
    4343:	8b 12                	mov    (%edx),%edx
    4345:	89 53 f8             	mov    %edx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    4348:	8b 50 04             	mov    0x4(%eax),%edx
    434b:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    434e:	39 ce                	cmp    %ecx,%esi
    4350:	75 dd                	jne    432f <free+0x4f>
    p->s.size += bp->s.size;
    4352:	03 51 04             	add    0x4(%ecx),%edx
    4355:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    4358:	8b 53 f8             	mov    -0x8(%ebx),%edx
    435b:	89 10                	mov    %edx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
    435d:	a3 c8 5c 00 00       	mov    %eax,0x5cc8
}
    4362:	5b                   	pop    %ebx
    4363:	5e                   	pop    %esi
    4364:	5f                   	pop    %edi
    4365:	5d                   	pop    %ebp
    4366:	c3                   	ret    
    4367:	89 f6                	mov    %esi,%esi
    4369:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00004370 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    4370:	55                   	push   %ebp
    4371:	89 e5                	mov    %esp,%ebp
    4373:	57                   	push   %edi
    4374:	56                   	push   %esi
    4375:	53                   	push   %ebx
    4376:	83 ec 2c             	sub    $0x2c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    4379:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if((prevp = freep) == 0){
    437c:	8b 0d c8 5c 00 00    	mov    0x5cc8,%ecx
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    4382:	83 c3 07             	add    $0x7,%ebx
    4385:	c1 eb 03             	shr    $0x3,%ebx
    4388:	83 c3 01             	add    $0x1,%ebx
  if((prevp = freep) == 0){
    438b:	85 c9                	test   %ecx,%ecx
    438d:	0f 84 9b 00 00 00    	je     442e <malloc+0xbe>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    4393:	8b 01                	mov    (%ecx),%eax
    if(p->s.size >= nunits){
    4395:	8b 50 04             	mov    0x4(%eax),%edx
    4398:	39 d3                	cmp    %edx,%ebx
    439a:	76 27                	jbe    43c3 <malloc+0x53>
        p->s.size -= nunits;
        p += p->s.size;
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    439c:	8d 3c dd 00 00 00 00 	lea    0x0(,%ebx,8),%edi
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < 4096)
    43a3:	be 00 80 00 00       	mov    $0x8000,%esi
    43a8:	89 7d e4             	mov    %edi,-0x1c(%ebp)
    43ab:	90                   	nop
    43ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    43b0:	3b 05 c8 5c 00 00    	cmp    0x5cc8,%eax
    43b6:	74 30                	je     43e8 <malloc+0x78>
    43b8:	89 c1                	mov    %eax,%ecx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    43ba:	8b 01                	mov    (%ecx),%eax
    if(p->s.size >= nunits){
    43bc:	8b 50 04             	mov    0x4(%eax),%edx
    43bf:	39 d3                	cmp    %edx,%ebx
    43c1:	77 ed                	ja     43b0 <malloc+0x40>
      if(p->s.size == nunits)
    43c3:	39 d3                	cmp    %edx,%ebx
    43c5:	74 61                	je     4428 <malloc+0xb8>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
    43c7:	29 da                	sub    %ebx,%edx
    43c9:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
    43cc:	8d 04 d0             	lea    (%eax,%edx,8),%eax
        p->s.size = nunits;
    43cf:	89 58 04             	mov    %ebx,0x4(%eax)
      }
      freep = prevp;
    43d2:	89 0d c8 5c 00 00    	mov    %ecx,0x5cc8
      return (void*)(p + 1);
    43d8:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
    43db:	83 c4 2c             	add    $0x2c,%esp
    43de:	5b                   	pop    %ebx
    43df:	5e                   	pop    %esi
    43e0:	5f                   	pop    %edi
    43e1:	5d                   	pop    %ebp
    43e2:	c3                   	ret    
    43e3:	90                   	nop
    43e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < 4096)
    43e8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    43eb:	81 fb 00 10 00 00    	cmp    $0x1000,%ebx
    43f1:	bf 00 10 00 00       	mov    $0x1000,%edi
    43f6:	0f 43 fb             	cmovae %ebx,%edi
    43f9:	0f 42 c6             	cmovb  %esi,%eax
    nu = 4096;
  p = sbrk(nu * sizeof(Header));
    43fc:	89 04 24             	mov    %eax,(%esp)
    43ff:	e8 2c fc ff ff       	call   4030 <sbrk>
  if(p == (char*)-1)
    4404:	83 f8 ff             	cmp    $0xffffffff,%eax
    4407:	74 18                	je     4421 <malloc+0xb1>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
    4409:	89 78 04             	mov    %edi,0x4(%eax)
  free((void*)(hp + 1));
    440c:	83 c0 08             	add    $0x8,%eax
    440f:	89 04 24             	mov    %eax,(%esp)
    4412:	e8 c9 fe ff ff       	call   42e0 <free>
  return freep;
    4417:	8b 0d c8 5c 00 00    	mov    0x5cc8,%ecx
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
    441d:	85 c9                	test   %ecx,%ecx
    441f:	75 99                	jne    43ba <malloc+0x4a>
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
    4421:	31 c0                	xor    %eax,%eax
    4423:	eb b6                	jmp    43db <malloc+0x6b>
    4425:	8d 76 00             	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
    4428:	8b 10                	mov    (%eax),%edx
    442a:	89 11                	mov    %edx,(%ecx)
    442c:	eb a4                	jmp    43d2 <malloc+0x62>
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    442e:	c7 05 c8 5c 00 00 c0 	movl   $0x5cc0,0x5cc8
    4435:	5c 00 00 
    base.s.size = 0;
    4438:	b9 c0 5c 00 00       	mov    $0x5cc0,%ecx
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    443d:	c7 05 c0 5c 00 00 c0 	movl   $0x5cc0,0x5cc0
    4444:	5c 00 00 
    base.s.size = 0;
    4447:	c7 05 c4 5c 00 00 00 	movl   $0x0,0x5cc4
    444e:	00 00 00 
    4451:	e9 3d ff ff ff       	jmp    4393 <malloc+0x23>
