
_test:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "stat.h"
#include "user.h"

int
main(int argc, char **argv)
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	83 e4 f0             	and    $0xfffffff0,%esp
   6:	83 ec 10             	sub    $0x10,%esp
	hello();
   9:	e8 da 02 00 00       	call   2e8 <hello>
	exit(6);
   e:	c7 04 24 06 00 00 00 	movl   $0x6,(%esp)
  15:	e8 2e 02 00 00       	call   248 <exit>
  1a:	90                   	nop
  1b:	90                   	nop
  1c:	90                   	nop
  1d:	90                   	nop
  1e:	90                   	nop
  1f:	90                   	nop

00000020 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
  20:	55                   	push   %ebp
  21:	31 d2                	xor    %edx,%edx
  23:	89 e5                	mov    %esp,%ebp
  25:	8b 45 08             	mov    0x8(%ebp),%eax
  28:	53                   	push   %ebx
  29:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  30:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
  34:	88 0c 10             	mov    %cl,(%eax,%edx,1)
  37:	83 c2 01             	add    $0x1,%edx
  3a:	84 c9                	test   %cl,%cl
  3c:	75 f2                	jne    30 <strcpy+0x10>
    ;
  return os;
}
  3e:	5b                   	pop    %ebx
  3f:	5d                   	pop    %ebp
  40:	c3                   	ret    
  41:	eb 0d                	jmp    50 <strcmp>
  43:	90                   	nop
  44:	90                   	nop
  45:	90                   	nop
  46:	90                   	nop
  47:	90                   	nop
  48:	90                   	nop
  49:	90                   	nop
  4a:	90                   	nop
  4b:	90                   	nop
  4c:	90                   	nop
  4d:	90                   	nop
  4e:	90                   	nop
  4f:	90                   	nop

00000050 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  50:	55                   	push   %ebp
  51:	89 e5                	mov    %esp,%ebp
  53:	8b 4d 08             	mov    0x8(%ebp),%ecx
  56:	53                   	push   %ebx
  57:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(*p && *p == *q)
  5a:	0f b6 01             	movzbl (%ecx),%eax
  5d:	84 c0                	test   %al,%al
  5f:	75 14                	jne    75 <strcmp+0x25>
  61:	eb 25                	jmp    88 <strcmp+0x38>
  63:	90                   	nop
  64:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    p++, q++;
  68:	83 c1 01             	add    $0x1,%ecx
  6b:	83 c2 01             	add    $0x1,%edx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
  6e:	0f b6 01             	movzbl (%ecx),%eax
  71:	84 c0                	test   %al,%al
  73:	74 13                	je     88 <strcmp+0x38>
  75:	0f b6 1a             	movzbl (%edx),%ebx
  78:	38 d8                	cmp    %bl,%al
  7a:	74 ec                	je     68 <strcmp+0x18>
  7c:	0f b6 db             	movzbl %bl,%ebx
  7f:	0f b6 c0             	movzbl %al,%eax
  82:	29 d8                	sub    %ebx,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
  84:	5b                   	pop    %ebx
  85:	5d                   	pop    %ebp
  86:	c3                   	ret    
  87:	90                   	nop
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
  88:	0f b6 1a             	movzbl (%edx),%ebx
  8b:	31 c0                	xor    %eax,%eax
  8d:	0f b6 db             	movzbl %bl,%ebx
  90:	29 d8                	sub    %ebx,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
  92:	5b                   	pop    %ebx
  93:	5d                   	pop    %ebp
  94:	c3                   	ret    
  95:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000000a0 <strlen>:

uint
strlen(char *s)
{
  a0:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
  a1:	31 d2                	xor    %edx,%edx
  return (uchar)*p - (uchar)*q;
}

uint
strlen(char *s)
{
  a3:	89 e5                	mov    %esp,%ebp
  int n;

  for(n = 0; s[n]; n++)
  a5:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
}

uint
strlen(char *s)
{
  a7:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
  aa:	80 39 00             	cmpb   $0x0,(%ecx)
  ad:	74 0c                	je     bb <strlen+0x1b>
  af:	90                   	nop
  b0:	83 c2 01             	add    $0x1,%edx
  b3:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
  b7:	89 d0                	mov    %edx,%eax
  b9:	75 f5                	jne    b0 <strlen+0x10>
    ;
  return n;
}
  bb:	5d                   	pop    %ebp
  bc:	c3                   	ret    
  bd:	8d 76 00             	lea    0x0(%esi),%esi

000000c0 <memset>:

void*
memset(void *dst, int c, uint n)
{
  c0:	55                   	push   %ebp
  c1:	89 e5                	mov    %esp,%ebp
  c3:	8b 55 08             	mov    0x8(%ebp),%edx
  c6:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
  c7:	8b 4d 10             	mov    0x10(%ebp),%ecx
  ca:	8b 45 0c             	mov    0xc(%ebp),%eax
  cd:	89 d7                	mov    %edx,%edi
  cf:	fc                   	cld    
  d0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
  d2:	89 d0                	mov    %edx,%eax
  d4:	5f                   	pop    %edi
  d5:	5d                   	pop    %ebp
  d6:	c3                   	ret    
  d7:	89 f6                	mov    %esi,%esi
  d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000000e0 <strchr>:

char*
strchr(const char *s, char c)
{
  e0:	55                   	push   %ebp
  e1:	89 e5                	mov    %esp,%ebp
  e3:	8b 45 08             	mov    0x8(%ebp),%eax
  e6:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
  ea:	0f b6 10             	movzbl (%eax),%edx
  ed:	84 d2                	test   %dl,%dl
  ef:	75 11                	jne    102 <strchr+0x22>
  f1:	eb 15                	jmp    108 <strchr+0x28>
  f3:	90                   	nop
  f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  f8:	83 c0 01             	add    $0x1,%eax
  fb:	0f b6 10             	movzbl (%eax),%edx
  fe:	84 d2                	test   %dl,%dl
 100:	74 06                	je     108 <strchr+0x28>
    if(*s == c)
 102:	38 ca                	cmp    %cl,%dl
 104:	75 f2                	jne    f8 <strchr+0x18>
      return (char*)s;
  return 0;
}
 106:	5d                   	pop    %ebp
 107:	c3                   	ret    
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 108:	31 c0                	xor    %eax,%eax
    if(*s == c)
      return (char*)s;
  return 0;
}
 10a:	5d                   	pop    %ebp
 10b:	90                   	nop
 10c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 110:	c3                   	ret    
 111:	eb 0d                	jmp    120 <atoi>
 113:	90                   	nop
 114:	90                   	nop
 115:	90                   	nop
 116:	90                   	nop
 117:	90                   	nop
 118:	90                   	nop
 119:	90                   	nop
 11a:	90                   	nop
 11b:	90                   	nop
 11c:	90                   	nop
 11d:	90                   	nop
 11e:	90                   	nop
 11f:	90                   	nop

00000120 <atoi>:
  return r;
}

int
atoi(const char *s)
{
 120:	55                   	push   %ebp
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 121:	31 c0                	xor    %eax,%eax
  return r;
}

int
atoi(const char *s)
{
 123:	89 e5                	mov    %esp,%ebp
 125:	8b 4d 08             	mov    0x8(%ebp),%ecx
 128:	53                   	push   %ebx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 129:	0f b6 11             	movzbl (%ecx),%edx
 12c:	8d 5a d0             	lea    -0x30(%edx),%ebx
 12f:	80 fb 09             	cmp    $0x9,%bl
 132:	77 1c                	ja     150 <atoi+0x30>
 134:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    n = n*10 + *s++ - '0';
 138:	0f be d2             	movsbl %dl,%edx
 13b:	83 c1 01             	add    $0x1,%ecx
 13e:	8d 04 80             	lea    (%eax,%eax,4),%eax
 141:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 145:	0f b6 11             	movzbl (%ecx),%edx
 148:	8d 5a d0             	lea    -0x30(%edx),%ebx
 14b:	80 fb 09             	cmp    $0x9,%bl
 14e:	76 e8                	jbe    138 <atoi+0x18>
    n = n*10 + *s++ - '0';
  return n;
}
 150:	5b                   	pop    %ebx
 151:	5d                   	pop    %ebp
 152:	c3                   	ret    
 153:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 159:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000160 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 160:	55                   	push   %ebp
 161:	89 e5                	mov    %esp,%ebp
 163:	56                   	push   %esi
 164:	8b 45 08             	mov    0x8(%ebp),%eax
 167:	53                   	push   %ebx
 168:	8b 5d 10             	mov    0x10(%ebp),%ebx
 16b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 16e:	85 db                	test   %ebx,%ebx
 170:	7e 14                	jle    186 <memmove+0x26>
    n = n*10 + *s++ - '0';
  return n;
}

void*
memmove(void *vdst, void *vsrc, int n)
 172:	31 d2                	xor    %edx,%edx
 174:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    *dst++ = *src++;
 178:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 17c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 17f:	83 c2 01             	add    $0x1,%edx
{
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 182:	39 da                	cmp    %ebx,%edx
 184:	75 f2                	jne    178 <memmove+0x18>
    *dst++ = *src++;
  return vdst;
}
 186:	5b                   	pop    %ebx
 187:	5e                   	pop    %esi
 188:	5d                   	pop    %ebp
 189:	c3                   	ret    
 18a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000190 <stat>:
  return buf;
}

int
stat(char *n, struct stat *st)
{
 190:	55                   	push   %ebp
 191:	89 e5                	mov    %esp,%ebp
 193:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 196:	8b 45 08             	mov    0x8(%ebp),%eax
  return buf;
}

int
stat(char *n, struct stat *st)
{
 199:	89 5d f8             	mov    %ebx,-0x8(%ebp)
 19c:	89 75 fc             	mov    %esi,-0x4(%ebp)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
 19f:	be ff ff ff ff       	mov    $0xffffffff,%esi
stat(char *n, struct stat *st)
{
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1a4:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 1ab:	00 
 1ac:	89 04 24             	mov    %eax,(%esp)
 1af:	e8 d4 00 00 00       	call   288 <open>
  if(fd < 0)
 1b4:	85 c0                	test   %eax,%eax
stat(char *n, struct stat *st)
{
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1b6:	89 c3                	mov    %eax,%ebx
  if(fd < 0)
 1b8:	78 19                	js     1d3 <stat+0x43>
    return -1;
  r = fstat(fd, st);
 1ba:	8b 45 0c             	mov    0xc(%ebp),%eax
 1bd:	89 1c 24             	mov    %ebx,(%esp)
 1c0:	89 44 24 04          	mov    %eax,0x4(%esp)
 1c4:	e8 d7 00 00 00       	call   2a0 <fstat>
  close(fd);
 1c9:	89 1c 24             	mov    %ebx,(%esp)
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
  r = fstat(fd, st);
 1cc:	89 c6                	mov    %eax,%esi
  close(fd);
 1ce:	e8 9d 00 00 00       	call   270 <close>
  return r;
}
 1d3:	89 f0                	mov    %esi,%eax
 1d5:	8b 5d f8             	mov    -0x8(%ebp),%ebx
 1d8:	8b 75 fc             	mov    -0x4(%ebp),%esi
 1db:	89 ec                	mov    %ebp,%esp
 1dd:	5d                   	pop    %ebp
 1de:	c3                   	ret    
 1df:	90                   	nop

000001e0 <gets>:
  return 0;
}

char*
gets(char *buf, int max)
{
 1e0:	55                   	push   %ebp
 1e1:	89 e5                	mov    %esp,%ebp
 1e3:	57                   	push   %edi
 1e4:	56                   	push   %esi
 1e5:	31 f6                	xor    %esi,%esi
 1e7:	53                   	push   %ebx
 1e8:	83 ec 2c             	sub    $0x2c,%esp
 1eb:	8b 7d 08             	mov    0x8(%ebp),%edi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1ee:	eb 06                	jmp    1f6 <gets+0x16>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 1f0:	3c 0a                	cmp    $0xa,%al
 1f2:	74 39                	je     22d <gets+0x4d>
 1f4:	89 de                	mov    %ebx,%esi
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1f6:	8d 5e 01             	lea    0x1(%esi),%ebx
 1f9:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 1fc:	7d 31                	jge    22f <gets+0x4f>
    cc = read(0, &c, 1);
 1fe:	8d 45 e7             	lea    -0x19(%ebp),%eax
 201:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 208:	00 
 209:	89 44 24 04          	mov    %eax,0x4(%esp)
 20d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 214:	e8 47 00 00 00       	call   260 <read>
    if(cc < 1)
 219:	85 c0                	test   %eax,%eax
 21b:	7e 12                	jle    22f <gets+0x4f>
      break;
    buf[i++] = c;
 21d:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 221:	88 44 1f ff          	mov    %al,-0x1(%edi,%ebx,1)
    if(c == '\n' || c == '\r')
 225:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 229:	3c 0d                	cmp    $0xd,%al
 22b:	75 c3                	jne    1f0 <gets+0x10>
 22d:	89 de                	mov    %ebx,%esi
      break;
  }
  buf[i] = '\0';
 22f:	c6 04 37 00          	movb   $0x0,(%edi,%esi,1)
  return buf;
}
 233:	89 f8                	mov    %edi,%eax
 235:	83 c4 2c             	add    $0x2c,%esp
 238:	5b                   	pop    %ebx
 239:	5e                   	pop    %esi
 23a:	5f                   	pop    %edi
 23b:	5d                   	pop    %ebp
 23c:	c3                   	ret    
 23d:	90                   	nop
 23e:	90                   	nop
 23f:	90                   	nop

00000240 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 240:	b8 01 00 00 00       	mov    $0x1,%eax
 245:	cd 40                	int    $0x40
 247:	c3                   	ret    

00000248 <exit>:
SYSCALL(exit)
 248:	b8 02 00 00 00       	mov    $0x2,%eax
 24d:	cd 40                	int    $0x40
 24f:	c3                   	ret    

00000250 <wait>:
SYSCALL(wait)
 250:	b8 03 00 00 00       	mov    $0x3,%eax
 255:	cd 40                	int    $0x40
 257:	c3                   	ret    

00000258 <pipe>:
SYSCALL(pipe)
 258:	b8 04 00 00 00       	mov    $0x4,%eax
 25d:	cd 40                	int    $0x40
 25f:	c3                   	ret    

00000260 <read>:
SYSCALL(read)
 260:	b8 05 00 00 00       	mov    $0x5,%eax
 265:	cd 40                	int    $0x40
 267:	c3                   	ret    

00000268 <write>:
SYSCALL(write)
 268:	b8 10 00 00 00       	mov    $0x10,%eax
 26d:	cd 40                	int    $0x40
 26f:	c3                   	ret    

00000270 <close>:
SYSCALL(close)
 270:	b8 15 00 00 00       	mov    $0x15,%eax
 275:	cd 40                	int    $0x40
 277:	c3                   	ret    

00000278 <kill>:
SYSCALL(kill)
 278:	b8 06 00 00 00       	mov    $0x6,%eax
 27d:	cd 40                	int    $0x40
 27f:	c3                   	ret    

00000280 <exec>:
SYSCALL(exec)
 280:	b8 07 00 00 00       	mov    $0x7,%eax
 285:	cd 40                	int    $0x40
 287:	c3                   	ret    

00000288 <open>:
SYSCALL(open)
 288:	b8 0f 00 00 00       	mov    $0xf,%eax
 28d:	cd 40                	int    $0x40
 28f:	c3                   	ret    

00000290 <mknod>:
SYSCALL(mknod)
 290:	b8 11 00 00 00       	mov    $0x11,%eax
 295:	cd 40                	int    $0x40
 297:	c3                   	ret    

00000298 <unlink>:
SYSCALL(unlink)
 298:	b8 12 00 00 00       	mov    $0x12,%eax
 29d:	cd 40                	int    $0x40
 29f:	c3                   	ret    

000002a0 <fstat>:
SYSCALL(fstat)
 2a0:	b8 08 00 00 00       	mov    $0x8,%eax
 2a5:	cd 40                	int    $0x40
 2a7:	c3                   	ret    

000002a8 <link>:
SYSCALL(link)
 2a8:	b8 13 00 00 00       	mov    $0x13,%eax
 2ad:	cd 40                	int    $0x40
 2af:	c3                   	ret    

000002b0 <mkdir>:
SYSCALL(mkdir)
 2b0:	b8 14 00 00 00       	mov    $0x14,%eax
 2b5:	cd 40                	int    $0x40
 2b7:	c3                   	ret    

000002b8 <chdir>:
SYSCALL(chdir)
 2b8:	b8 09 00 00 00       	mov    $0x9,%eax
 2bd:	cd 40                	int    $0x40
 2bf:	c3                   	ret    

000002c0 <dup>:
SYSCALL(dup)
 2c0:	b8 0a 00 00 00       	mov    $0xa,%eax
 2c5:	cd 40                	int    $0x40
 2c7:	c3                   	ret    

000002c8 <getpid>:
SYSCALL(getpid)
 2c8:	b8 0b 00 00 00       	mov    $0xb,%eax
 2cd:	cd 40                	int    $0x40
 2cf:	c3                   	ret    

000002d0 <sbrk>:
SYSCALL(sbrk)
 2d0:	b8 0c 00 00 00       	mov    $0xc,%eax
 2d5:	cd 40                	int    $0x40
 2d7:	c3                   	ret    

000002d8 <sleep>:
SYSCALL(sleep)
 2d8:	b8 0d 00 00 00       	mov    $0xd,%eax
 2dd:	cd 40                	int    $0x40
 2df:	c3                   	ret    

000002e0 <uptime>:
SYSCALL(uptime)
 2e0:	b8 0e 00 00 00       	mov    $0xe,%eax
 2e5:	cd 40                	int    $0x40
 2e7:	c3                   	ret    

000002e8 <hello>:
SYSCALL(hello)
 2e8:	b8 16 00 00 00       	mov    $0x16,%eax
 2ed:	cd 40                	int    $0x40
 2ef:	c3                   	ret    

000002f0 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 2f0:	55                   	push   %ebp
 2f1:	89 e5                	mov    %esp,%ebp
 2f3:	57                   	push   %edi
 2f4:	89 cf                	mov    %ecx,%edi
 2f6:	56                   	push   %esi
 2f7:	89 c6                	mov    %eax,%esi
 2f9:	53                   	push   %ebx
 2fa:	83 ec 4c             	sub    $0x4c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 2fd:	8b 4d 08             	mov    0x8(%ebp),%ecx
 300:	85 c9                	test   %ecx,%ecx
 302:	74 04                	je     308 <printint+0x18>
 304:	85 d2                	test   %edx,%edx
 306:	78 68                	js     370 <printint+0x80>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 308:	89 d0                	mov    %edx,%eax
 30a:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 311:	31 c9                	xor    %ecx,%ecx
 313:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 316:	66 90                	xchg   %ax,%ax
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
 318:	31 d2                	xor    %edx,%edx
 31a:	f7 f7                	div    %edi
 31c:	0f b6 92 ed 06 00 00 	movzbl 0x6ed(%edx),%edx
 323:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
 326:	83 c1 01             	add    $0x1,%ecx
  }while((x /= base) != 0);
 329:	85 c0                	test   %eax,%eax
 32b:	75 eb                	jne    318 <printint+0x28>
  if(neg)
 32d:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 330:	85 c0                	test   %eax,%eax
 332:	74 08                	je     33c <printint+0x4c>
    buf[i++] = '-';
 334:	c6 44 0d d7 2d       	movb   $0x2d,-0x29(%ebp,%ecx,1)
 339:	83 c1 01             	add    $0x1,%ecx

  while(--i >= 0)
 33c:	8d 79 ff             	lea    -0x1(%ecx),%edi
 33f:	90                   	nop
 340:	0f b6 04 3b          	movzbl (%ebx,%edi,1),%eax
 344:	83 ef 01             	sub    $0x1,%edi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 347:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 34e:	00 
 34f:	89 34 24             	mov    %esi,(%esp)
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 352:	88 45 e7             	mov    %al,-0x19(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 355:	8d 45 e7             	lea    -0x19(%ebp),%eax
 358:	89 44 24 04          	mov    %eax,0x4(%esp)
 35c:	e8 07 ff ff ff       	call   268 <write>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 361:	83 ff ff             	cmp    $0xffffffff,%edi
 364:	75 da                	jne    340 <printint+0x50>
    putc(fd, buf[i]);
}
 366:	83 c4 4c             	add    $0x4c,%esp
 369:	5b                   	pop    %ebx
 36a:	5e                   	pop    %esi
 36b:	5f                   	pop    %edi
 36c:	5d                   	pop    %ebp
 36d:	c3                   	ret    
 36e:	66 90                	xchg   %ax,%ax
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 370:	89 d0                	mov    %edx,%eax
 372:	f7 d8                	neg    %eax
 374:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
 37b:	eb 94                	jmp    311 <printint+0x21>
 37d:	8d 76 00             	lea    0x0(%esi),%esi

00000380 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 380:	55                   	push   %ebp
 381:	89 e5                	mov    %esp,%ebp
 383:	57                   	push   %edi
 384:	56                   	push   %esi
 385:	53                   	push   %ebx
 386:	83 ec 3c             	sub    $0x3c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 389:	8b 45 0c             	mov    0xc(%ebp),%eax
 38c:	0f b6 10             	movzbl (%eax),%edx
 38f:	84 d2                	test   %dl,%dl
 391:	0f 84 c1 00 00 00    	je     458 <printf+0xd8>
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
 397:	8d 4d 10             	lea    0x10(%ebp),%ecx
 39a:	31 ff                	xor    %edi,%edi
 39c:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
 39f:	31 db                	xor    %ebx,%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 3a1:	8d 75 e7             	lea    -0x19(%ebp),%esi
 3a4:	eb 1e                	jmp    3c4 <printf+0x44>
 3a6:	66 90                	xchg   %ax,%ax
  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 3a8:	83 fa 25             	cmp    $0x25,%edx
 3ab:	0f 85 af 00 00 00    	jne    460 <printf+0xe0>
 3b1:	66 bf 25 00          	mov    $0x25,%di
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 3b5:	83 c3 01             	add    $0x1,%ebx
 3b8:	0f b6 14 18          	movzbl (%eax,%ebx,1),%edx
 3bc:	84 d2                	test   %dl,%dl
 3be:	0f 84 94 00 00 00    	je     458 <printf+0xd8>
    c = fmt[i] & 0xff;
    if(state == 0){
 3c4:	85 ff                	test   %edi,%edi
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
 3c6:	0f b6 d2             	movzbl %dl,%edx
    if(state == 0){
 3c9:	74 dd                	je     3a8 <printf+0x28>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 3cb:	83 ff 25             	cmp    $0x25,%edi
 3ce:	75 e5                	jne    3b5 <printf+0x35>
      if(c == 'd'){
 3d0:	83 fa 64             	cmp    $0x64,%edx
 3d3:	0f 84 3f 01 00 00    	je     518 <printf+0x198>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 3d9:	83 fa 70             	cmp    $0x70,%edx
 3dc:	0f 84 a6 00 00 00    	je     488 <printf+0x108>
 3e2:	83 fa 78             	cmp    $0x78,%edx
 3e5:	0f 84 9d 00 00 00    	je     488 <printf+0x108>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 3eb:	83 fa 73             	cmp    $0x73,%edx
 3ee:	66 90                	xchg   %ax,%ax
 3f0:	0f 84 ba 00 00 00    	je     4b0 <printf+0x130>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 3f6:	83 fa 63             	cmp    $0x63,%edx
 3f9:	0f 84 41 01 00 00    	je     540 <printf+0x1c0>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 3ff:	83 fa 25             	cmp    $0x25,%edx
 402:	0f 84 00 01 00 00    	je     508 <printf+0x188>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 408:	8b 4d 08             	mov    0x8(%ebp),%ecx
 40b:	89 55 cc             	mov    %edx,-0x34(%ebp)
 40e:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 412:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 419:	00 
 41a:	89 74 24 04          	mov    %esi,0x4(%esp)
 41e:	89 0c 24             	mov    %ecx,(%esp)
 421:	e8 42 fe ff ff       	call   268 <write>
 426:	8b 55 cc             	mov    -0x34(%ebp),%edx
 429:	88 55 e7             	mov    %dl,-0x19(%ebp)
 42c:	8b 45 08             	mov    0x8(%ebp),%eax
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 42f:	83 c3 01             	add    $0x1,%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 432:	31 ff                	xor    %edi,%edi
 434:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 43b:	00 
 43c:	89 74 24 04          	mov    %esi,0x4(%esp)
 440:	89 04 24             	mov    %eax,(%esp)
 443:	e8 20 fe ff ff       	call   268 <write>
 448:	8b 45 0c             	mov    0xc(%ebp),%eax
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 44b:	0f b6 14 18          	movzbl (%eax,%ebx,1),%edx
 44f:	84 d2                	test   %dl,%dl
 451:	0f 85 6d ff ff ff    	jne    3c4 <printf+0x44>
 457:	90                   	nop
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 458:	83 c4 3c             	add    $0x3c,%esp
 45b:	5b                   	pop    %ebx
 45c:	5e                   	pop    %esi
 45d:	5f                   	pop    %edi
 45e:	5d                   	pop    %ebp
 45f:	c3                   	ret    
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 460:	8b 45 08             	mov    0x8(%ebp),%eax
  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 463:	88 55 e7             	mov    %dl,-0x19(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 466:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 46d:	00 
 46e:	89 74 24 04          	mov    %esi,0x4(%esp)
 472:	89 04 24             	mov    %eax,(%esp)
 475:	e8 ee fd ff ff       	call   268 <write>
 47a:	8b 45 0c             	mov    0xc(%ebp),%eax
 47d:	e9 33 ff ff ff       	jmp    3b5 <printf+0x35>
 482:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 488:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 48b:	b9 10 00 00 00       	mov    $0x10,%ecx
        ap++;
 490:	31 ff                	xor    %edi,%edi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 492:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 499:	8b 10                	mov    (%eax),%edx
 49b:	8b 45 08             	mov    0x8(%ebp),%eax
 49e:	e8 4d fe ff ff       	call   2f0 <printint>
 4a3:	8b 45 0c             	mov    0xc(%ebp),%eax
        ap++;
 4a6:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
 4aa:	e9 06 ff ff ff       	jmp    3b5 <printf+0x35>
 4af:	90                   	nop
      } else if(c == 's'){
        s = (char*)*ap;
 4b0:	8b 55 d4             	mov    -0x2c(%ebp),%edx
        ap++;
        if(s == 0)
 4b3:	b9 e6 06 00 00       	mov    $0x6e6,%ecx
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
        s = (char*)*ap;
 4b8:	8b 3a                	mov    (%edx),%edi
        ap++;
 4ba:	83 c2 04             	add    $0x4,%edx
 4bd:	89 55 d4             	mov    %edx,-0x2c(%ebp)
        if(s == 0)
 4c0:	85 ff                	test   %edi,%edi
 4c2:	0f 44 f9             	cmove  %ecx,%edi
          s = "(null)";
        while(*s != 0){
 4c5:	0f b6 17             	movzbl (%edi),%edx
 4c8:	84 d2                	test   %dl,%dl
 4ca:	74 33                	je     4ff <printf+0x17f>
 4cc:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 4cf:	8b 5d 08             	mov    0x8(%ebp),%ebx
 4d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
          putc(fd, *s);
          s++;
 4d8:	83 c7 01             	add    $0x1,%edi
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 4db:	88 55 e7             	mov    %dl,-0x19(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 4de:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 4e5:	00 
 4e6:	89 74 24 04          	mov    %esi,0x4(%esp)
 4ea:	89 1c 24             	mov    %ebx,(%esp)
 4ed:	e8 76 fd ff ff       	call   268 <write>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 4f2:	0f b6 17             	movzbl (%edi),%edx
 4f5:	84 d2                	test   %dl,%dl
 4f7:	75 df                	jne    4d8 <printf+0x158>
 4f9:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 4fc:	8b 45 0c             	mov    0xc(%ebp),%eax
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 4ff:	31 ff                	xor    %edi,%edi
 501:	e9 af fe ff ff       	jmp    3b5 <printf+0x35>
 506:	66 90                	xchg   %ax,%ax
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 508:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 50c:	e9 1b ff ff ff       	jmp    42c <printf+0xac>
 511:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 518:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 51b:	b9 0a 00 00 00       	mov    $0xa,%ecx
        ap++;
 520:	66 31 ff             	xor    %di,%di
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 523:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 52a:	8b 10                	mov    (%eax),%edx
 52c:	8b 45 08             	mov    0x8(%ebp),%eax
 52f:	e8 bc fd ff ff       	call   2f0 <printint>
 534:	8b 45 0c             	mov    0xc(%ebp),%eax
        ap++;
 537:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
 53b:	e9 75 fe ff ff       	jmp    3b5 <printf+0x35>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 540:	8b 55 d4             	mov    -0x2c(%ebp),%edx
        putc(fd, *ap);
        ap++;
 543:	31 ff                	xor    %edi,%edi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 545:	8b 4d 08             	mov    0x8(%ebp),%ecx
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 548:	8b 02                	mov    (%edx),%eax
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 54a:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 551:	00 
 552:	89 74 24 04          	mov    %esi,0x4(%esp)
 556:	89 0c 24             	mov    %ecx,(%esp)
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 559:	88 45 e7             	mov    %al,-0x19(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 55c:	e8 07 fd ff ff       	call   268 <write>
 561:	8b 45 0c             	mov    0xc(%ebp),%eax
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
        ap++;
 564:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
 568:	e9 48 fe ff ff       	jmp    3b5 <printf+0x35>
 56d:	90                   	nop
 56e:	90                   	nop
 56f:	90                   	nop

00000570 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 570:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 571:	a1 08 07 00 00       	mov    0x708,%eax
static Header base;
static Header *freep;

void
free(void *ap)
{
 576:	89 e5                	mov    %esp,%ebp
 578:	57                   	push   %edi
 579:	56                   	push   %esi
 57a:	53                   	push   %ebx
 57b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
 57e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 581:	39 c8                	cmp    %ecx,%eax
 583:	73 1d                	jae    5a2 <free+0x32>
 585:	8d 76 00             	lea    0x0(%esi),%esi
 588:	8b 10                	mov    (%eax),%edx
 58a:	39 d1                	cmp    %edx,%ecx
 58c:	72 1a                	jb     5a8 <free+0x38>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 58e:	39 d0                	cmp    %edx,%eax
 590:	72 08                	jb     59a <free+0x2a>
 592:	39 c8                	cmp    %ecx,%eax
 594:	72 12                	jb     5a8 <free+0x38>
 596:	39 d1                	cmp    %edx,%ecx
 598:	72 0e                	jb     5a8 <free+0x38>
 59a:	89 d0                	mov    %edx,%eax
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 59c:	39 c8                	cmp    %ecx,%eax
 59e:	66 90                	xchg   %ax,%ax
 5a0:	72 e6                	jb     588 <free+0x18>
 5a2:	8b 10                	mov    (%eax),%edx
 5a4:	eb e8                	jmp    58e <free+0x1e>
 5a6:	66 90                	xchg   %ax,%ax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 5a8:	8b 71 04             	mov    0x4(%ecx),%esi
 5ab:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 5ae:	39 d7                	cmp    %edx,%edi
 5b0:	74 19                	je     5cb <free+0x5b>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 5b2:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 5b5:	8b 50 04             	mov    0x4(%eax),%edx
 5b8:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 5bb:	39 ce                	cmp    %ecx,%esi
 5bd:	74 23                	je     5e2 <free+0x72>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 5bf:	89 08                	mov    %ecx,(%eax)
  freep = p;
 5c1:	a3 08 07 00 00       	mov    %eax,0x708
}
 5c6:	5b                   	pop    %ebx
 5c7:	5e                   	pop    %esi
 5c8:	5f                   	pop    %edi
 5c9:	5d                   	pop    %ebp
 5ca:	c3                   	ret    
  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 5cb:	03 72 04             	add    0x4(%edx),%esi
 5ce:	89 71 04             	mov    %esi,0x4(%ecx)
    bp->s.ptr = p->s.ptr->s.ptr;
 5d1:	8b 10                	mov    (%eax),%edx
 5d3:	8b 12                	mov    (%edx),%edx
 5d5:	89 53 f8             	mov    %edx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 5d8:	8b 50 04             	mov    0x4(%eax),%edx
 5db:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 5de:	39 ce                	cmp    %ecx,%esi
 5e0:	75 dd                	jne    5bf <free+0x4f>
    p->s.size += bp->s.size;
 5e2:	03 51 04             	add    0x4(%ecx),%edx
 5e5:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 5e8:	8b 53 f8             	mov    -0x8(%ebx),%edx
 5eb:	89 10                	mov    %edx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
 5ed:	a3 08 07 00 00       	mov    %eax,0x708
}
 5f2:	5b                   	pop    %ebx
 5f3:	5e                   	pop    %esi
 5f4:	5f                   	pop    %edi
 5f5:	5d                   	pop    %ebp
 5f6:	c3                   	ret    
 5f7:	89 f6                	mov    %esi,%esi
 5f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000600 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 600:	55                   	push   %ebp
 601:	89 e5                	mov    %esp,%ebp
 603:	57                   	push   %edi
 604:	56                   	push   %esi
 605:	53                   	push   %ebx
 606:	83 ec 2c             	sub    $0x2c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 609:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if((prevp = freep) == 0){
 60c:	8b 0d 08 07 00 00    	mov    0x708,%ecx
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 612:	83 c3 07             	add    $0x7,%ebx
 615:	c1 eb 03             	shr    $0x3,%ebx
 618:	83 c3 01             	add    $0x1,%ebx
  if((prevp = freep) == 0){
 61b:	85 c9                	test   %ecx,%ecx
 61d:	0f 84 9b 00 00 00    	je     6be <malloc+0xbe>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 623:	8b 01                	mov    (%ecx),%eax
    if(p->s.size >= nunits){
 625:	8b 50 04             	mov    0x4(%eax),%edx
 628:	39 d3                	cmp    %edx,%ebx
 62a:	76 27                	jbe    653 <malloc+0x53>
        p->s.size -= nunits;
        p += p->s.size;
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
 62c:	8d 3c dd 00 00 00 00 	lea    0x0(,%ebx,8),%edi
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < 4096)
 633:	be 00 80 00 00       	mov    $0x8000,%esi
 638:	89 7d e4             	mov    %edi,-0x1c(%ebp)
 63b:	90                   	nop
 63c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 640:	3b 05 08 07 00 00    	cmp    0x708,%eax
 646:	74 30                	je     678 <malloc+0x78>
 648:	89 c1                	mov    %eax,%ecx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 64a:	8b 01                	mov    (%ecx),%eax
    if(p->s.size >= nunits){
 64c:	8b 50 04             	mov    0x4(%eax),%edx
 64f:	39 d3                	cmp    %edx,%ebx
 651:	77 ed                	ja     640 <malloc+0x40>
      if(p->s.size == nunits)
 653:	39 d3                	cmp    %edx,%ebx
 655:	74 61                	je     6b8 <malloc+0xb8>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 657:	29 da                	sub    %ebx,%edx
 659:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 65c:	8d 04 d0             	lea    (%eax,%edx,8),%eax
        p->s.size = nunits;
 65f:	89 58 04             	mov    %ebx,0x4(%eax)
      }
      freep = prevp;
 662:	89 0d 08 07 00 00    	mov    %ecx,0x708
      return (void*)(p + 1);
 668:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 66b:	83 c4 2c             	add    $0x2c,%esp
 66e:	5b                   	pop    %ebx
 66f:	5e                   	pop    %esi
 670:	5f                   	pop    %edi
 671:	5d                   	pop    %ebp
 672:	c3                   	ret    
 673:	90                   	nop
 674:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < 4096)
 678:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 67b:	81 fb 00 10 00 00    	cmp    $0x1000,%ebx
 681:	bf 00 10 00 00       	mov    $0x1000,%edi
 686:	0f 43 fb             	cmovae %ebx,%edi
 689:	0f 42 c6             	cmovb  %esi,%eax
    nu = 4096;
  p = sbrk(nu * sizeof(Header));
 68c:	89 04 24             	mov    %eax,(%esp)
 68f:	e8 3c fc ff ff       	call   2d0 <sbrk>
  if(p == (char*)-1)
 694:	83 f8 ff             	cmp    $0xffffffff,%eax
 697:	74 18                	je     6b1 <malloc+0xb1>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
 699:	89 78 04             	mov    %edi,0x4(%eax)
  free((void*)(hp + 1));
 69c:	83 c0 08             	add    $0x8,%eax
 69f:	89 04 24             	mov    %eax,(%esp)
 6a2:	e8 c9 fe ff ff       	call   570 <free>
  return freep;
 6a7:	8b 0d 08 07 00 00    	mov    0x708,%ecx
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
 6ad:	85 c9                	test   %ecx,%ecx
 6af:	75 99                	jne    64a <malloc+0x4a>
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 6b1:	31 c0                	xor    %eax,%eax
 6b3:	eb b6                	jmp    66b <malloc+0x6b>
 6b5:	8d 76 00             	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
 6b8:	8b 10                	mov    (%eax),%edx
 6ba:	89 11                	mov    %edx,(%ecx)
 6bc:	eb a4                	jmp    662 <malloc+0x62>
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 6be:	c7 05 08 07 00 00 00 	movl   $0x700,0x708
 6c5:	07 00 00 
    base.s.size = 0;
 6c8:	b9 00 07 00 00       	mov    $0x700,%ecx
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 6cd:	c7 05 00 07 00 00 00 	movl   $0x700,0x700
 6d4:	07 00 00 
    base.s.size = 0;
 6d7:	c7 05 04 07 00 00 00 	movl   $0x0,0x704
 6de:	00 00 00 
 6e1:	e9 3d ff ff ff       	jmp    623 <malloc+0x23>
