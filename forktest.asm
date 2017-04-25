
_forktest:     file format elf32-i386


Disassembly of section .text:

00000000 <printf>:

#define N  1000

void
printf(int fd, char *s, ...)
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	53                   	push   %ebx
   4:	83 ec 14             	sub    $0x14,%esp
   7:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  write(fd, s, strlen(s));
   a:	89 1c 24             	mov    %ebx,(%esp)
   d:	e8 ae 01 00 00       	call   1c0 <strlen>
  12:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  16:	89 44 24 08          	mov    %eax,0x8(%esp)
  1a:	8b 45 08             	mov    0x8(%ebp),%eax
  1d:	89 04 24             	mov    %eax,(%esp)
  20:	e8 63 03 00 00       	call   388 <write>
}
  25:	83 c4 14             	add    $0x14,%esp
  28:	5b                   	pop    %ebx
  29:	5d                   	pop    %ebp
  2a:	c3                   	ret    
  2b:	90                   	nop
  2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000030 <forktest>:

void
forktest(void)
{
  30:	55                   	push   %ebp
  31:	89 e5                	mov    %esp,%ebp
  33:	53                   	push   %ebx
  int n, pid;

  printf(1, "fork test\n");
  34:	31 db                	xor    %ebx,%ebx
  write(fd, s, strlen(s));
}

void
forktest(void)
{
  36:	83 ec 14             	sub    $0x14,%esp
  int n, pid;

  printf(1, "fork test\n");
  39:	c7 44 24 04 10 04 00 	movl   $0x410,0x4(%esp)
  40:	00 
  41:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  48:	e8 b3 ff ff ff       	call   0 <printf>
  4d:	eb 0e                	jmp    5d <forktest+0x2d>
  4f:	90                   	nop

  for(n=0; n<N; n++){
    pid = fork();
    if(pid < 0)
      break;
    if(pid == 0)
  50:	74 7a                	je     cc <forktest+0x9c>
{
  int n, pid;

  printf(1, "fork test\n");

  for(n=0; n<N; n++){
  52:	83 c3 01             	add    $0x1,%ebx
  55:	81 fb e8 03 00 00    	cmp    $0x3e8,%ebx
  5b:	74 53                	je     b0 <forktest+0x80>
    pid = fork();
  5d:	e8 fe 02 00 00       	call   360 <fork>
    if(pid < 0)
  62:	83 f8 00             	cmp    $0x0,%eax
  65:	7d e9                	jge    50 <forktest+0x20>
  if(n == N){
    printf(1, "fork claimed to work N times!\n", N);
    exit(0);
  }

  for(; n > 0; n--){
  67:	85 db                	test   %ebx,%ebx
  69:	74 1a                	je     85 <forktest+0x55>
  6b:	90                   	nop
  6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(wait(0) < 0){
  70:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  77:	e8 f4 02 00 00       	call   370 <wait>
  7c:	85 c0                	test   %eax,%eax
  7e:	78 58                	js     d8 <forktest+0xa8>
  if(n == N){
    printf(1, "fork claimed to work N times!\n", N);
    exit(0);
  }

  for(; n > 0; n--){
  80:	83 eb 01             	sub    $0x1,%ebx
  83:	75 eb                	jne    70 <forktest+0x40>
      printf(1, "wait stopped early\n");
      exit(0);
    }
  }

  if(wait(0) != -1){
  85:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  8c:	e8 df 02 00 00       	call   370 <wait>
  91:	83 f8 ff             	cmp    $0xffffffff,%eax
  94:	75 62                	jne    f8 <forktest+0xc8>
    printf(1, "wait got too many\n");
    exit(0);
  }

  printf(1, "fork test OK\n");
  96:	c7 44 24 04 42 04 00 	movl   $0x442,0x4(%esp)
  9d:	00 
  9e:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  a5:	e8 56 ff ff ff       	call   0 <printf>
}
  aa:	83 c4 14             	add    $0x14,%esp
  ad:	5b                   	pop    %ebx
  ae:	5d                   	pop    %ebp
  af:	c3                   	ret    
    if(pid == 0)
      exit(0);
  }

  if(n == N){
    printf(1, "fork claimed to work N times!\n", N);
  b0:	c7 44 24 08 e8 03 00 	movl   $0x3e8,0x8(%esp)
  b7:	00 
  b8:	c7 44 24 04 50 04 00 	movl   $0x450,0x4(%esp)
  bf:	00 
  c0:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  c7:	e8 34 ff ff ff       	call   0 <printf>
    exit(0);
  cc:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  d3:	e8 90 02 00 00       	call   368 <exit>
  }

  for(; n > 0; n--){
    if(wait(0) < 0){
      printf(1, "wait stopped early\n");
  d8:	c7 44 24 04 1b 04 00 	movl   $0x41b,0x4(%esp)
  df:	00 
  e0:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  e7:	e8 14 ff ff ff       	call   0 <printf>
      exit(0);
  ec:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  f3:	e8 70 02 00 00       	call   368 <exit>
    }
  }

  if(wait(0) != -1){
    printf(1, "wait got too many\n");
  f8:	c7 44 24 04 2f 04 00 	movl   $0x42f,0x4(%esp)
  ff:	00 
 100:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 107:	e8 f4 fe ff ff       	call   0 <printf>
    exit(0);
 10c:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 113:	e8 50 02 00 00       	call   368 <exit>
 118:	90                   	nop
 119:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000120 <main>:
  printf(1, "fork test OK\n");
}

int
main(void)
{
 120:	55                   	push   %ebp
 121:	89 e5                	mov    %esp,%ebp
 123:	83 e4 f0             	and    $0xfffffff0,%esp
 126:	83 ec 10             	sub    $0x10,%esp
  forktest();
 129:	e8 02 ff ff ff       	call   30 <forktest>
  exit(0);
 12e:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 135:	e8 2e 02 00 00       	call   368 <exit>
 13a:	90                   	nop
 13b:	90                   	nop
 13c:	90                   	nop
 13d:	90                   	nop
 13e:	90                   	nop
 13f:	90                   	nop

00000140 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 140:	55                   	push   %ebp
 141:	31 d2                	xor    %edx,%edx
 143:	89 e5                	mov    %esp,%ebp
 145:	8b 45 08             	mov    0x8(%ebp),%eax
 148:	53                   	push   %ebx
 149:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 14c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 150:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
 154:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 157:	83 c2 01             	add    $0x1,%edx
 15a:	84 c9                	test   %cl,%cl
 15c:	75 f2                	jne    150 <strcpy+0x10>
    ;
  return os;
}
 15e:	5b                   	pop    %ebx
 15f:	5d                   	pop    %ebp
 160:	c3                   	ret    
 161:	eb 0d                	jmp    170 <strcmp>
 163:	90                   	nop
 164:	90                   	nop
 165:	90                   	nop
 166:	90                   	nop
 167:	90                   	nop
 168:	90                   	nop
 169:	90                   	nop
 16a:	90                   	nop
 16b:	90                   	nop
 16c:	90                   	nop
 16d:	90                   	nop
 16e:	90                   	nop
 16f:	90                   	nop

00000170 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 170:	55                   	push   %ebp
 171:	89 e5                	mov    %esp,%ebp
 173:	8b 4d 08             	mov    0x8(%ebp),%ecx
 176:	53                   	push   %ebx
 177:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(*p && *p == *q)
 17a:	0f b6 01             	movzbl (%ecx),%eax
 17d:	84 c0                	test   %al,%al
 17f:	75 14                	jne    195 <strcmp+0x25>
 181:	eb 25                	jmp    1a8 <strcmp+0x38>
 183:	90                   	nop
 184:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    p++, q++;
 188:	83 c1 01             	add    $0x1,%ecx
 18b:	83 c2 01             	add    $0x1,%edx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 18e:	0f b6 01             	movzbl (%ecx),%eax
 191:	84 c0                	test   %al,%al
 193:	74 13                	je     1a8 <strcmp+0x38>
 195:	0f b6 1a             	movzbl (%edx),%ebx
 198:	38 d8                	cmp    %bl,%al
 19a:	74 ec                	je     188 <strcmp+0x18>
 19c:	0f b6 db             	movzbl %bl,%ebx
 19f:	0f b6 c0             	movzbl %al,%eax
 1a2:	29 d8                	sub    %ebx,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
 1a4:	5b                   	pop    %ebx
 1a5:	5d                   	pop    %ebp
 1a6:	c3                   	ret    
 1a7:	90                   	nop
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 1a8:	0f b6 1a             	movzbl (%edx),%ebx
 1ab:	31 c0                	xor    %eax,%eax
 1ad:	0f b6 db             	movzbl %bl,%ebx
 1b0:	29 d8                	sub    %ebx,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
 1b2:	5b                   	pop    %ebx
 1b3:	5d                   	pop    %ebp
 1b4:	c3                   	ret    
 1b5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 1b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000001c0 <strlen>:

uint
strlen(char *s)
{
 1c0:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
 1c1:	31 d2                	xor    %edx,%edx
  return (uchar)*p - (uchar)*q;
}

uint
strlen(char *s)
{
 1c3:	89 e5                	mov    %esp,%ebp
  int n;

  for(n = 0; s[n]; n++)
 1c5:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
}

uint
strlen(char *s)
{
 1c7:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 1ca:	80 39 00             	cmpb   $0x0,(%ecx)
 1cd:	74 0c                	je     1db <strlen+0x1b>
 1cf:	90                   	nop
 1d0:	83 c2 01             	add    $0x1,%edx
 1d3:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 1d7:	89 d0                	mov    %edx,%eax
 1d9:	75 f5                	jne    1d0 <strlen+0x10>
    ;
  return n;
}
 1db:	5d                   	pop    %ebp
 1dc:	c3                   	ret    
 1dd:	8d 76 00             	lea    0x0(%esi),%esi

000001e0 <memset>:

void*
memset(void *dst, int c, uint n)
{
 1e0:	55                   	push   %ebp
 1e1:	89 e5                	mov    %esp,%ebp
 1e3:	8b 55 08             	mov    0x8(%ebp),%edx
 1e6:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 1e7:	8b 4d 10             	mov    0x10(%ebp),%ecx
 1ea:	8b 45 0c             	mov    0xc(%ebp),%eax
 1ed:	89 d7                	mov    %edx,%edi
 1ef:	fc                   	cld    
 1f0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 1f2:	89 d0                	mov    %edx,%eax
 1f4:	5f                   	pop    %edi
 1f5:	5d                   	pop    %ebp
 1f6:	c3                   	ret    
 1f7:	89 f6                	mov    %esi,%esi
 1f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000200 <strchr>:

char*
strchr(const char *s, char c)
{
 200:	55                   	push   %ebp
 201:	89 e5                	mov    %esp,%ebp
 203:	8b 45 08             	mov    0x8(%ebp),%eax
 206:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 20a:	0f b6 10             	movzbl (%eax),%edx
 20d:	84 d2                	test   %dl,%dl
 20f:	75 11                	jne    222 <strchr+0x22>
 211:	eb 15                	jmp    228 <strchr+0x28>
 213:	90                   	nop
 214:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 218:	83 c0 01             	add    $0x1,%eax
 21b:	0f b6 10             	movzbl (%eax),%edx
 21e:	84 d2                	test   %dl,%dl
 220:	74 06                	je     228 <strchr+0x28>
    if(*s == c)
 222:	38 ca                	cmp    %cl,%dl
 224:	75 f2                	jne    218 <strchr+0x18>
      return (char*)s;
  return 0;
}
 226:	5d                   	pop    %ebp
 227:	c3                   	ret    
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 228:	31 c0                	xor    %eax,%eax
    if(*s == c)
      return (char*)s;
  return 0;
}
 22a:	5d                   	pop    %ebp
 22b:	90                   	nop
 22c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 230:	c3                   	ret    
 231:	eb 0d                	jmp    240 <atoi>
 233:	90                   	nop
 234:	90                   	nop
 235:	90                   	nop
 236:	90                   	nop
 237:	90                   	nop
 238:	90                   	nop
 239:	90                   	nop
 23a:	90                   	nop
 23b:	90                   	nop
 23c:	90                   	nop
 23d:	90                   	nop
 23e:	90                   	nop
 23f:	90                   	nop

00000240 <atoi>:
  return r;
}

int
atoi(const char *s)
{
 240:	55                   	push   %ebp
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 241:	31 c0                	xor    %eax,%eax
  return r;
}

int
atoi(const char *s)
{
 243:	89 e5                	mov    %esp,%ebp
 245:	8b 4d 08             	mov    0x8(%ebp),%ecx
 248:	53                   	push   %ebx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 249:	0f b6 11             	movzbl (%ecx),%edx
 24c:	8d 5a d0             	lea    -0x30(%edx),%ebx
 24f:	80 fb 09             	cmp    $0x9,%bl
 252:	77 1c                	ja     270 <atoi+0x30>
 254:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    n = n*10 + *s++ - '0';
 258:	0f be d2             	movsbl %dl,%edx
 25b:	83 c1 01             	add    $0x1,%ecx
 25e:	8d 04 80             	lea    (%eax,%eax,4),%eax
 261:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 265:	0f b6 11             	movzbl (%ecx),%edx
 268:	8d 5a d0             	lea    -0x30(%edx),%ebx
 26b:	80 fb 09             	cmp    $0x9,%bl
 26e:	76 e8                	jbe    258 <atoi+0x18>
    n = n*10 + *s++ - '0';
  return n;
}
 270:	5b                   	pop    %ebx
 271:	5d                   	pop    %ebp
 272:	c3                   	ret    
 273:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 279:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000280 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 280:	55                   	push   %ebp
 281:	89 e5                	mov    %esp,%ebp
 283:	56                   	push   %esi
 284:	8b 45 08             	mov    0x8(%ebp),%eax
 287:	53                   	push   %ebx
 288:	8b 5d 10             	mov    0x10(%ebp),%ebx
 28b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 28e:	85 db                	test   %ebx,%ebx
 290:	7e 14                	jle    2a6 <memmove+0x26>
    n = n*10 + *s++ - '0';
  return n;
}

void*
memmove(void *vdst, void *vsrc, int n)
 292:	31 d2                	xor    %edx,%edx
 294:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    *dst++ = *src++;
 298:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 29c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 29f:	83 c2 01             	add    $0x1,%edx
{
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 2a2:	39 da                	cmp    %ebx,%edx
 2a4:	75 f2                	jne    298 <memmove+0x18>
    *dst++ = *src++;
  return vdst;
}
 2a6:	5b                   	pop    %ebx
 2a7:	5e                   	pop    %esi
 2a8:	5d                   	pop    %ebp
 2a9:	c3                   	ret    
 2aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000002b0 <stat>:
  return buf;
}

int
stat(char *n, struct stat *st)
{
 2b0:	55                   	push   %ebp
 2b1:	89 e5                	mov    %esp,%ebp
 2b3:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 2b6:	8b 45 08             	mov    0x8(%ebp),%eax
  return buf;
}

int
stat(char *n, struct stat *st)
{
 2b9:	89 5d f8             	mov    %ebx,-0x8(%ebp)
 2bc:	89 75 fc             	mov    %esi,-0x4(%ebp)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
 2bf:	be ff ff ff ff       	mov    $0xffffffff,%esi
stat(char *n, struct stat *st)
{
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 2c4:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 2cb:	00 
 2cc:	89 04 24             	mov    %eax,(%esp)
 2cf:	e8 d4 00 00 00       	call   3a8 <open>
  if(fd < 0)
 2d4:	85 c0                	test   %eax,%eax
stat(char *n, struct stat *st)
{
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 2d6:	89 c3                	mov    %eax,%ebx
  if(fd < 0)
 2d8:	78 19                	js     2f3 <stat+0x43>
    return -1;
  r = fstat(fd, st);
 2da:	8b 45 0c             	mov    0xc(%ebp),%eax
 2dd:	89 1c 24             	mov    %ebx,(%esp)
 2e0:	89 44 24 04          	mov    %eax,0x4(%esp)
 2e4:	e8 d7 00 00 00       	call   3c0 <fstat>
  close(fd);
 2e9:	89 1c 24             	mov    %ebx,(%esp)
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
  r = fstat(fd, st);
 2ec:	89 c6                	mov    %eax,%esi
  close(fd);
 2ee:	e8 9d 00 00 00       	call   390 <close>
  return r;
}
 2f3:	89 f0                	mov    %esi,%eax
 2f5:	8b 5d f8             	mov    -0x8(%ebp),%ebx
 2f8:	8b 75 fc             	mov    -0x4(%ebp),%esi
 2fb:	89 ec                	mov    %ebp,%esp
 2fd:	5d                   	pop    %ebp
 2fe:	c3                   	ret    
 2ff:	90                   	nop

00000300 <gets>:
  return 0;
}

char*
gets(char *buf, int max)
{
 300:	55                   	push   %ebp
 301:	89 e5                	mov    %esp,%ebp
 303:	57                   	push   %edi
 304:	56                   	push   %esi
 305:	31 f6                	xor    %esi,%esi
 307:	53                   	push   %ebx
 308:	83 ec 2c             	sub    $0x2c,%esp
 30b:	8b 7d 08             	mov    0x8(%ebp),%edi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 30e:	eb 06                	jmp    316 <gets+0x16>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 310:	3c 0a                	cmp    $0xa,%al
 312:	74 39                	je     34d <gets+0x4d>
 314:	89 de                	mov    %ebx,%esi
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 316:	8d 5e 01             	lea    0x1(%esi),%ebx
 319:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 31c:	7d 31                	jge    34f <gets+0x4f>
    cc = read(0, &c, 1);
 31e:	8d 45 e7             	lea    -0x19(%ebp),%eax
 321:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 328:	00 
 329:	89 44 24 04          	mov    %eax,0x4(%esp)
 32d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 334:	e8 47 00 00 00       	call   380 <read>
    if(cc < 1)
 339:	85 c0                	test   %eax,%eax
 33b:	7e 12                	jle    34f <gets+0x4f>
      break;
    buf[i++] = c;
 33d:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 341:	88 44 1f ff          	mov    %al,-0x1(%edi,%ebx,1)
    if(c == '\n' || c == '\r')
 345:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 349:	3c 0d                	cmp    $0xd,%al
 34b:	75 c3                	jne    310 <gets+0x10>
 34d:	89 de                	mov    %ebx,%esi
      break;
  }
  buf[i] = '\0';
 34f:	c6 04 37 00          	movb   $0x0,(%edi,%esi,1)
  return buf;
}
 353:	89 f8                	mov    %edi,%eax
 355:	83 c4 2c             	add    $0x2c,%esp
 358:	5b                   	pop    %ebx
 359:	5e                   	pop    %esi
 35a:	5f                   	pop    %edi
 35b:	5d                   	pop    %ebp
 35c:	c3                   	ret    
 35d:	90                   	nop
 35e:	90                   	nop
 35f:	90                   	nop

00000360 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 360:	b8 01 00 00 00       	mov    $0x1,%eax
 365:	cd 40                	int    $0x40
 367:	c3                   	ret    

00000368 <exit>:
SYSCALL(exit)
 368:	b8 02 00 00 00       	mov    $0x2,%eax
 36d:	cd 40                	int    $0x40
 36f:	c3                   	ret    

00000370 <wait>:
SYSCALL(wait)
 370:	b8 03 00 00 00       	mov    $0x3,%eax
 375:	cd 40                	int    $0x40
 377:	c3                   	ret    

00000378 <pipe>:
SYSCALL(pipe)
 378:	b8 04 00 00 00       	mov    $0x4,%eax
 37d:	cd 40                	int    $0x40
 37f:	c3                   	ret    

00000380 <read>:
SYSCALL(read)
 380:	b8 05 00 00 00       	mov    $0x5,%eax
 385:	cd 40                	int    $0x40
 387:	c3                   	ret    

00000388 <write>:
SYSCALL(write)
 388:	b8 10 00 00 00       	mov    $0x10,%eax
 38d:	cd 40                	int    $0x40
 38f:	c3                   	ret    

00000390 <close>:
SYSCALL(close)
 390:	b8 15 00 00 00       	mov    $0x15,%eax
 395:	cd 40                	int    $0x40
 397:	c3                   	ret    

00000398 <kill>:
SYSCALL(kill)
 398:	b8 06 00 00 00       	mov    $0x6,%eax
 39d:	cd 40                	int    $0x40
 39f:	c3                   	ret    

000003a0 <exec>:
SYSCALL(exec)
 3a0:	b8 07 00 00 00       	mov    $0x7,%eax
 3a5:	cd 40                	int    $0x40
 3a7:	c3                   	ret    

000003a8 <open>:
SYSCALL(open)
 3a8:	b8 0f 00 00 00       	mov    $0xf,%eax
 3ad:	cd 40                	int    $0x40
 3af:	c3                   	ret    

000003b0 <mknod>:
SYSCALL(mknod)
 3b0:	b8 11 00 00 00       	mov    $0x11,%eax
 3b5:	cd 40                	int    $0x40
 3b7:	c3                   	ret    

000003b8 <unlink>:
SYSCALL(unlink)
 3b8:	b8 12 00 00 00       	mov    $0x12,%eax
 3bd:	cd 40                	int    $0x40
 3bf:	c3                   	ret    

000003c0 <fstat>:
SYSCALL(fstat)
 3c0:	b8 08 00 00 00       	mov    $0x8,%eax
 3c5:	cd 40                	int    $0x40
 3c7:	c3                   	ret    

000003c8 <link>:
SYSCALL(link)
 3c8:	b8 13 00 00 00       	mov    $0x13,%eax
 3cd:	cd 40                	int    $0x40
 3cf:	c3                   	ret    

000003d0 <mkdir>:
SYSCALL(mkdir)
 3d0:	b8 14 00 00 00       	mov    $0x14,%eax
 3d5:	cd 40                	int    $0x40
 3d7:	c3                   	ret    

000003d8 <chdir>:
SYSCALL(chdir)
 3d8:	b8 09 00 00 00       	mov    $0x9,%eax
 3dd:	cd 40                	int    $0x40
 3df:	c3                   	ret    

000003e0 <dup>:
SYSCALL(dup)
 3e0:	b8 0a 00 00 00       	mov    $0xa,%eax
 3e5:	cd 40                	int    $0x40
 3e7:	c3                   	ret    

000003e8 <getpid>:
SYSCALL(getpid)
 3e8:	b8 0b 00 00 00       	mov    $0xb,%eax
 3ed:	cd 40                	int    $0x40
 3ef:	c3                   	ret    

000003f0 <sbrk>:
SYSCALL(sbrk)
 3f0:	b8 0c 00 00 00       	mov    $0xc,%eax
 3f5:	cd 40                	int    $0x40
 3f7:	c3                   	ret    

000003f8 <sleep>:
SYSCALL(sleep)
 3f8:	b8 0d 00 00 00       	mov    $0xd,%eax
 3fd:	cd 40                	int    $0x40
 3ff:	c3                   	ret    

00000400 <uptime>:
SYSCALL(uptime)
 400:	b8 0e 00 00 00       	mov    $0xe,%eax
 405:	cd 40                	int    $0x40
 407:	c3                   	ret    

00000408 <hello>:
SYSCALL(hello)
 408:	b8 16 00 00 00       	mov    $0x16,%eax
 40d:	cd 40                	int    $0x40
 40f:	c3                   	ret    
