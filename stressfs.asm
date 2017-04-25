
_stressfs:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "fs.h"
#include "fcntl.h"

int
main(int argc, char *argv[])
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	83 e4 f0             	and    $0xfffffff0,%esp
   6:	57                   	push   %edi
   7:	56                   	push   %esi
   8:	53                   	push   %ebx

  printf(1, "stressfs starting\n");
  memset(data, 'a', sizeof(data));

  for(i = 0; i < 4; i++)
    if(fork() > 0)
   9:	31 db                	xor    %ebx,%ebx
#include "fs.h"
#include "fcntl.h"

int
main(int argc, char *argv[])
{
   b:	81 ec 24 02 00 00    	sub    $0x224,%esp
  int fd, i;
  char path[] = "stressfs0";
  char data[512];

  printf(1, "stressfs starting\n");
  memset(data, 'a', sizeof(data));
  11:	8d 74 24 16          	lea    0x16(%esp),%esi

int
main(int argc, char *argv[])
{
  int fd, i;
  char path[] = "stressfs0";
  15:	c7 84 24 16 02 00 00 	movl   $0x65727473,0x216(%esp)
  1c:	73 74 72 65 
  20:	c7 84 24 1a 02 00 00 	movl   $0x73667373,0x21a(%esp)
  27:	73 73 66 73 
  2b:	66 c7 84 24 1e 02 00 	movw   $0x30,0x21e(%esp)
  32:	00 30 00 
  char data[512];

  printf(1, "stressfs starting\n");
  35:	c7 44 24 04 36 08 00 	movl   $0x836,0x4(%esp)
  3c:	00 
  3d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  44:	e8 87 04 00 00       	call   4d0 <printf>
  memset(data, 'a', sizeof(data));
  49:	c7 44 24 08 00 02 00 	movl   $0x200,0x8(%esp)
  50:	00 
  51:	c7 44 24 04 61 00 00 	movl   $0x61,0x4(%esp)
  58:	00 
  59:	89 34 24             	mov    %esi,(%esp)
  5c:	e8 af 01 00 00       	call   210 <memset>

  for(i = 0; i < 4; i++)
    if(fork() > 0)
  61:	e8 2a 03 00 00       	call   390 <fork>
  66:	85 c0                	test   %eax,%eax
  68:	7f 2b                	jg     95 <main+0x95>
  6a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  70:	e8 1b 03 00 00       	call   390 <fork>
  75:	b3 01                	mov    $0x1,%bl
  77:	85 c0                	test   %eax,%eax
  79:	7f 1a                	jg     95 <main+0x95>
  7b:	e8 10 03 00 00       	call   390 <fork>
  80:	b3 02                	mov    $0x2,%bl
  82:	85 c0                	test   %eax,%eax
  84:	7f 0f                	jg     95 <main+0x95>
  86:	e8 05 03 00 00       	call   390 <fork>
  8b:	31 db                	xor    %ebx,%ebx
  8d:	85 c0                	test   %eax,%eax
  8f:	0f 9e c3             	setle  %bl
  92:	83 c3 03             	add    $0x3,%ebx
      break;

  printf(1, "write %d\n", i);
  95:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  99:	c7 44 24 04 49 08 00 	movl   $0x849,0x4(%esp)
  a0:	00 
  a1:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  a8:	e8 23 04 00 00       	call   4d0 <printf>

  path[8] += i;
  fd = open(path, O_CREATE | O_RDWR);
  ad:	8d 84 24 16 02 00 00 	lea    0x216(%esp),%eax
    if(fork() > 0)
      break;

  printf(1, "write %d\n", i);

  path[8] += i;
  b4:	00 9c 24 1e 02 00 00 	add    %bl,0x21e(%esp)
  fd = open(path, O_CREATE | O_RDWR);
  bb:	31 db                	xor    %ebx,%ebx
  bd:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
  c4:	00 
  c5:	89 04 24             	mov    %eax,(%esp)
  c8:	e8 0b 03 00 00       	call   3d8 <open>
  cd:	89 c7                	mov    %eax,%edi
  cf:	90                   	nop
  for(i = 0; i < 20; i++)
  d0:	83 c3 01             	add    $0x1,%ebx
//    printf(fd, "%d\n", i);
    write(fd, data, sizeof(data));
  d3:	c7 44 24 08 00 02 00 	movl   $0x200,0x8(%esp)
  da:	00 
  db:	89 74 24 04          	mov    %esi,0x4(%esp)
  df:	89 3c 24             	mov    %edi,(%esp)
  e2:	e8 d1 02 00 00       	call   3b8 <write>

  printf(1, "write %d\n", i);

  path[8] += i;
  fd = open(path, O_CREATE | O_RDWR);
  for(i = 0; i < 20; i++)
  e7:	83 fb 14             	cmp    $0x14,%ebx
  ea:	75 e4                	jne    d0 <main+0xd0>
//    printf(fd, "%d\n", i);
    write(fd, data, sizeof(data));
  close(fd);
  ec:	89 3c 24             	mov    %edi,(%esp)

  printf(1, "read\n");

  fd = open(path, O_RDONLY);
  ef:	30 db                	xor    %bl,%bl
  path[8] += i;
  fd = open(path, O_CREATE | O_RDWR);
  for(i = 0; i < 20; i++)
//    printf(fd, "%d\n", i);
    write(fd, data, sizeof(data));
  close(fd);
  f1:	e8 ca 02 00 00       	call   3c0 <close>

  printf(1, "read\n");
  f6:	c7 44 24 04 53 08 00 	movl   $0x853,0x4(%esp)
  fd:	00 
  fe:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 105:	e8 c6 03 00 00       	call   4d0 <printf>

  fd = open(path, O_RDONLY);
 10a:	8d 84 24 16 02 00 00 	lea    0x216(%esp),%eax
 111:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 118:	00 
 119:	89 04 24             	mov    %eax,(%esp)
 11c:	e8 b7 02 00 00       	call   3d8 <open>
 121:	89 c7                	mov    %eax,%edi
 123:	90                   	nop
 124:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for (i = 0; i < 20; i++)
 128:	83 c3 01             	add    $0x1,%ebx
    read(fd, data, sizeof(data));
 12b:	c7 44 24 08 00 02 00 	movl   $0x200,0x8(%esp)
 132:	00 
 133:	89 74 24 04          	mov    %esi,0x4(%esp)
 137:	89 3c 24             	mov    %edi,(%esp)
 13a:	e8 71 02 00 00       	call   3b0 <read>
  close(fd);

  printf(1, "read\n");

  fd = open(path, O_RDONLY);
  for (i = 0; i < 20; i++)
 13f:	83 fb 14             	cmp    $0x14,%ebx
 142:	75 e4                	jne    128 <main+0x128>
    read(fd, data, sizeof(data));
  close(fd);
 144:	89 3c 24             	mov    %edi,(%esp)
 147:	e8 74 02 00 00       	call   3c0 <close>

  wait(0);
 14c:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 153:	e8 48 02 00 00       	call   3a0 <wait>

  exit(0);
 158:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 15f:	e8 34 02 00 00       	call   398 <exit>
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

00000170 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 170:	55                   	push   %ebp
 171:	31 d2                	xor    %edx,%edx
 173:	89 e5                	mov    %esp,%ebp
 175:	8b 45 08             	mov    0x8(%ebp),%eax
 178:	53                   	push   %ebx
 179:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 17c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 180:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
 184:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 187:	83 c2 01             	add    $0x1,%edx
 18a:	84 c9                	test   %cl,%cl
 18c:	75 f2                	jne    180 <strcpy+0x10>
    ;
  return os;
}
 18e:	5b                   	pop    %ebx
 18f:	5d                   	pop    %ebp
 190:	c3                   	ret    
 191:	eb 0d                	jmp    1a0 <strcmp>
 193:	90                   	nop
 194:	90                   	nop
 195:	90                   	nop
 196:	90                   	nop
 197:	90                   	nop
 198:	90                   	nop
 199:	90                   	nop
 19a:	90                   	nop
 19b:	90                   	nop
 19c:	90                   	nop
 19d:	90                   	nop
 19e:	90                   	nop
 19f:	90                   	nop

000001a0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 1a0:	55                   	push   %ebp
 1a1:	89 e5                	mov    %esp,%ebp
 1a3:	8b 4d 08             	mov    0x8(%ebp),%ecx
 1a6:	53                   	push   %ebx
 1a7:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(*p && *p == *q)
 1aa:	0f b6 01             	movzbl (%ecx),%eax
 1ad:	84 c0                	test   %al,%al
 1af:	75 14                	jne    1c5 <strcmp+0x25>
 1b1:	eb 25                	jmp    1d8 <strcmp+0x38>
 1b3:	90                   	nop
 1b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    p++, q++;
 1b8:	83 c1 01             	add    $0x1,%ecx
 1bb:	83 c2 01             	add    $0x1,%edx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 1be:	0f b6 01             	movzbl (%ecx),%eax
 1c1:	84 c0                	test   %al,%al
 1c3:	74 13                	je     1d8 <strcmp+0x38>
 1c5:	0f b6 1a             	movzbl (%edx),%ebx
 1c8:	38 d8                	cmp    %bl,%al
 1ca:	74 ec                	je     1b8 <strcmp+0x18>
 1cc:	0f b6 db             	movzbl %bl,%ebx
 1cf:	0f b6 c0             	movzbl %al,%eax
 1d2:	29 d8                	sub    %ebx,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
 1d4:	5b                   	pop    %ebx
 1d5:	5d                   	pop    %ebp
 1d6:	c3                   	ret    
 1d7:	90                   	nop
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 1d8:	0f b6 1a             	movzbl (%edx),%ebx
 1db:	31 c0                	xor    %eax,%eax
 1dd:	0f b6 db             	movzbl %bl,%ebx
 1e0:	29 d8                	sub    %ebx,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
 1e2:	5b                   	pop    %ebx
 1e3:	5d                   	pop    %ebp
 1e4:	c3                   	ret    
 1e5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 1e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000001f0 <strlen>:

uint
strlen(char *s)
{
 1f0:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
 1f1:	31 d2                	xor    %edx,%edx
  return (uchar)*p - (uchar)*q;
}

uint
strlen(char *s)
{
 1f3:	89 e5                	mov    %esp,%ebp
  int n;

  for(n = 0; s[n]; n++)
 1f5:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
}

uint
strlen(char *s)
{
 1f7:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 1fa:	80 39 00             	cmpb   $0x0,(%ecx)
 1fd:	74 0c                	je     20b <strlen+0x1b>
 1ff:	90                   	nop
 200:	83 c2 01             	add    $0x1,%edx
 203:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 207:	89 d0                	mov    %edx,%eax
 209:	75 f5                	jne    200 <strlen+0x10>
    ;
  return n;
}
 20b:	5d                   	pop    %ebp
 20c:	c3                   	ret    
 20d:	8d 76 00             	lea    0x0(%esi),%esi

00000210 <memset>:

void*
memset(void *dst, int c, uint n)
{
 210:	55                   	push   %ebp
 211:	89 e5                	mov    %esp,%ebp
 213:	8b 55 08             	mov    0x8(%ebp),%edx
 216:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 217:	8b 4d 10             	mov    0x10(%ebp),%ecx
 21a:	8b 45 0c             	mov    0xc(%ebp),%eax
 21d:	89 d7                	mov    %edx,%edi
 21f:	fc                   	cld    
 220:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 222:	89 d0                	mov    %edx,%eax
 224:	5f                   	pop    %edi
 225:	5d                   	pop    %ebp
 226:	c3                   	ret    
 227:	89 f6                	mov    %esi,%esi
 229:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000230 <strchr>:

char*
strchr(const char *s, char c)
{
 230:	55                   	push   %ebp
 231:	89 e5                	mov    %esp,%ebp
 233:	8b 45 08             	mov    0x8(%ebp),%eax
 236:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 23a:	0f b6 10             	movzbl (%eax),%edx
 23d:	84 d2                	test   %dl,%dl
 23f:	75 11                	jne    252 <strchr+0x22>
 241:	eb 15                	jmp    258 <strchr+0x28>
 243:	90                   	nop
 244:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 248:	83 c0 01             	add    $0x1,%eax
 24b:	0f b6 10             	movzbl (%eax),%edx
 24e:	84 d2                	test   %dl,%dl
 250:	74 06                	je     258 <strchr+0x28>
    if(*s == c)
 252:	38 ca                	cmp    %cl,%dl
 254:	75 f2                	jne    248 <strchr+0x18>
      return (char*)s;
  return 0;
}
 256:	5d                   	pop    %ebp
 257:	c3                   	ret    
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 258:	31 c0                	xor    %eax,%eax
    if(*s == c)
      return (char*)s;
  return 0;
}
 25a:	5d                   	pop    %ebp
 25b:	90                   	nop
 25c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 260:	c3                   	ret    
 261:	eb 0d                	jmp    270 <atoi>
 263:	90                   	nop
 264:	90                   	nop
 265:	90                   	nop
 266:	90                   	nop
 267:	90                   	nop
 268:	90                   	nop
 269:	90                   	nop
 26a:	90                   	nop
 26b:	90                   	nop
 26c:	90                   	nop
 26d:	90                   	nop
 26e:	90                   	nop
 26f:	90                   	nop

00000270 <atoi>:
  return r;
}

int
atoi(const char *s)
{
 270:	55                   	push   %ebp
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 271:	31 c0                	xor    %eax,%eax
  return r;
}

int
atoi(const char *s)
{
 273:	89 e5                	mov    %esp,%ebp
 275:	8b 4d 08             	mov    0x8(%ebp),%ecx
 278:	53                   	push   %ebx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 279:	0f b6 11             	movzbl (%ecx),%edx
 27c:	8d 5a d0             	lea    -0x30(%edx),%ebx
 27f:	80 fb 09             	cmp    $0x9,%bl
 282:	77 1c                	ja     2a0 <atoi+0x30>
 284:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    n = n*10 + *s++ - '0';
 288:	0f be d2             	movsbl %dl,%edx
 28b:	83 c1 01             	add    $0x1,%ecx
 28e:	8d 04 80             	lea    (%eax,%eax,4),%eax
 291:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 295:	0f b6 11             	movzbl (%ecx),%edx
 298:	8d 5a d0             	lea    -0x30(%edx),%ebx
 29b:	80 fb 09             	cmp    $0x9,%bl
 29e:	76 e8                	jbe    288 <atoi+0x18>
    n = n*10 + *s++ - '0';
  return n;
}
 2a0:	5b                   	pop    %ebx
 2a1:	5d                   	pop    %ebp
 2a2:	c3                   	ret    
 2a3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 2a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000002b0 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 2b0:	55                   	push   %ebp
 2b1:	89 e5                	mov    %esp,%ebp
 2b3:	56                   	push   %esi
 2b4:	8b 45 08             	mov    0x8(%ebp),%eax
 2b7:	53                   	push   %ebx
 2b8:	8b 5d 10             	mov    0x10(%ebp),%ebx
 2bb:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 2be:	85 db                	test   %ebx,%ebx
 2c0:	7e 14                	jle    2d6 <memmove+0x26>
    n = n*10 + *s++ - '0';
  return n;
}

void*
memmove(void *vdst, void *vsrc, int n)
 2c2:	31 d2                	xor    %edx,%edx
 2c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    *dst++ = *src++;
 2c8:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 2cc:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 2cf:	83 c2 01             	add    $0x1,%edx
{
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 2d2:	39 da                	cmp    %ebx,%edx
 2d4:	75 f2                	jne    2c8 <memmove+0x18>
    *dst++ = *src++;
  return vdst;
}
 2d6:	5b                   	pop    %ebx
 2d7:	5e                   	pop    %esi
 2d8:	5d                   	pop    %ebp
 2d9:	c3                   	ret    
 2da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000002e0 <stat>:
  return buf;
}

int
stat(char *n, struct stat *st)
{
 2e0:	55                   	push   %ebp
 2e1:	89 e5                	mov    %esp,%ebp
 2e3:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 2e6:	8b 45 08             	mov    0x8(%ebp),%eax
  return buf;
}

int
stat(char *n, struct stat *st)
{
 2e9:	89 5d f8             	mov    %ebx,-0x8(%ebp)
 2ec:	89 75 fc             	mov    %esi,-0x4(%ebp)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
 2ef:	be ff ff ff ff       	mov    $0xffffffff,%esi
stat(char *n, struct stat *st)
{
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 2f4:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 2fb:	00 
 2fc:	89 04 24             	mov    %eax,(%esp)
 2ff:	e8 d4 00 00 00       	call   3d8 <open>
  if(fd < 0)
 304:	85 c0                	test   %eax,%eax
stat(char *n, struct stat *st)
{
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 306:	89 c3                	mov    %eax,%ebx
  if(fd < 0)
 308:	78 19                	js     323 <stat+0x43>
    return -1;
  r = fstat(fd, st);
 30a:	8b 45 0c             	mov    0xc(%ebp),%eax
 30d:	89 1c 24             	mov    %ebx,(%esp)
 310:	89 44 24 04          	mov    %eax,0x4(%esp)
 314:	e8 d7 00 00 00       	call   3f0 <fstat>
  close(fd);
 319:	89 1c 24             	mov    %ebx,(%esp)
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
  r = fstat(fd, st);
 31c:	89 c6                	mov    %eax,%esi
  close(fd);
 31e:	e8 9d 00 00 00       	call   3c0 <close>
  return r;
}
 323:	89 f0                	mov    %esi,%eax
 325:	8b 5d f8             	mov    -0x8(%ebp),%ebx
 328:	8b 75 fc             	mov    -0x4(%ebp),%esi
 32b:	89 ec                	mov    %ebp,%esp
 32d:	5d                   	pop    %ebp
 32e:	c3                   	ret    
 32f:	90                   	nop

00000330 <gets>:
  return 0;
}

char*
gets(char *buf, int max)
{
 330:	55                   	push   %ebp
 331:	89 e5                	mov    %esp,%ebp
 333:	57                   	push   %edi
 334:	56                   	push   %esi
 335:	31 f6                	xor    %esi,%esi
 337:	53                   	push   %ebx
 338:	83 ec 2c             	sub    $0x2c,%esp
 33b:	8b 7d 08             	mov    0x8(%ebp),%edi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 33e:	eb 06                	jmp    346 <gets+0x16>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 340:	3c 0a                	cmp    $0xa,%al
 342:	74 39                	je     37d <gets+0x4d>
 344:	89 de                	mov    %ebx,%esi
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 346:	8d 5e 01             	lea    0x1(%esi),%ebx
 349:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 34c:	7d 31                	jge    37f <gets+0x4f>
    cc = read(0, &c, 1);
 34e:	8d 45 e7             	lea    -0x19(%ebp),%eax
 351:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 358:	00 
 359:	89 44 24 04          	mov    %eax,0x4(%esp)
 35d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 364:	e8 47 00 00 00       	call   3b0 <read>
    if(cc < 1)
 369:	85 c0                	test   %eax,%eax
 36b:	7e 12                	jle    37f <gets+0x4f>
      break;
    buf[i++] = c;
 36d:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 371:	88 44 1f ff          	mov    %al,-0x1(%edi,%ebx,1)
    if(c == '\n' || c == '\r')
 375:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 379:	3c 0d                	cmp    $0xd,%al
 37b:	75 c3                	jne    340 <gets+0x10>
 37d:	89 de                	mov    %ebx,%esi
      break;
  }
  buf[i] = '\0';
 37f:	c6 04 37 00          	movb   $0x0,(%edi,%esi,1)
  return buf;
}
 383:	89 f8                	mov    %edi,%eax
 385:	83 c4 2c             	add    $0x2c,%esp
 388:	5b                   	pop    %ebx
 389:	5e                   	pop    %esi
 38a:	5f                   	pop    %edi
 38b:	5d                   	pop    %ebp
 38c:	c3                   	ret    
 38d:	90                   	nop
 38e:	90                   	nop
 38f:	90                   	nop

00000390 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 390:	b8 01 00 00 00       	mov    $0x1,%eax
 395:	cd 40                	int    $0x40
 397:	c3                   	ret    

00000398 <exit>:
SYSCALL(exit)
 398:	b8 02 00 00 00       	mov    $0x2,%eax
 39d:	cd 40                	int    $0x40
 39f:	c3                   	ret    

000003a0 <wait>:
SYSCALL(wait)
 3a0:	b8 03 00 00 00       	mov    $0x3,%eax
 3a5:	cd 40                	int    $0x40
 3a7:	c3                   	ret    

000003a8 <pipe>:
SYSCALL(pipe)
 3a8:	b8 04 00 00 00       	mov    $0x4,%eax
 3ad:	cd 40                	int    $0x40
 3af:	c3                   	ret    

000003b0 <read>:
SYSCALL(read)
 3b0:	b8 05 00 00 00       	mov    $0x5,%eax
 3b5:	cd 40                	int    $0x40
 3b7:	c3                   	ret    

000003b8 <write>:
SYSCALL(write)
 3b8:	b8 10 00 00 00       	mov    $0x10,%eax
 3bd:	cd 40                	int    $0x40
 3bf:	c3                   	ret    

000003c0 <close>:
SYSCALL(close)
 3c0:	b8 15 00 00 00       	mov    $0x15,%eax
 3c5:	cd 40                	int    $0x40
 3c7:	c3                   	ret    

000003c8 <kill>:
SYSCALL(kill)
 3c8:	b8 06 00 00 00       	mov    $0x6,%eax
 3cd:	cd 40                	int    $0x40
 3cf:	c3                   	ret    

000003d0 <exec>:
SYSCALL(exec)
 3d0:	b8 07 00 00 00       	mov    $0x7,%eax
 3d5:	cd 40                	int    $0x40
 3d7:	c3                   	ret    

000003d8 <open>:
SYSCALL(open)
 3d8:	b8 0f 00 00 00       	mov    $0xf,%eax
 3dd:	cd 40                	int    $0x40
 3df:	c3                   	ret    

000003e0 <mknod>:
SYSCALL(mknod)
 3e0:	b8 11 00 00 00       	mov    $0x11,%eax
 3e5:	cd 40                	int    $0x40
 3e7:	c3                   	ret    

000003e8 <unlink>:
SYSCALL(unlink)
 3e8:	b8 12 00 00 00       	mov    $0x12,%eax
 3ed:	cd 40                	int    $0x40
 3ef:	c3                   	ret    

000003f0 <fstat>:
SYSCALL(fstat)
 3f0:	b8 08 00 00 00       	mov    $0x8,%eax
 3f5:	cd 40                	int    $0x40
 3f7:	c3                   	ret    

000003f8 <link>:
SYSCALL(link)
 3f8:	b8 13 00 00 00       	mov    $0x13,%eax
 3fd:	cd 40                	int    $0x40
 3ff:	c3                   	ret    

00000400 <mkdir>:
SYSCALL(mkdir)
 400:	b8 14 00 00 00       	mov    $0x14,%eax
 405:	cd 40                	int    $0x40
 407:	c3                   	ret    

00000408 <chdir>:
SYSCALL(chdir)
 408:	b8 09 00 00 00       	mov    $0x9,%eax
 40d:	cd 40                	int    $0x40
 40f:	c3                   	ret    

00000410 <dup>:
SYSCALL(dup)
 410:	b8 0a 00 00 00       	mov    $0xa,%eax
 415:	cd 40                	int    $0x40
 417:	c3                   	ret    

00000418 <getpid>:
SYSCALL(getpid)
 418:	b8 0b 00 00 00       	mov    $0xb,%eax
 41d:	cd 40                	int    $0x40
 41f:	c3                   	ret    

00000420 <sbrk>:
SYSCALL(sbrk)
 420:	b8 0c 00 00 00       	mov    $0xc,%eax
 425:	cd 40                	int    $0x40
 427:	c3                   	ret    

00000428 <sleep>:
SYSCALL(sleep)
 428:	b8 0d 00 00 00       	mov    $0xd,%eax
 42d:	cd 40                	int    $0x40
 42f:	c3                   	ret    

00000430 <uptime>:
SYSCALL(uptime)
 430:	b8 0e 00 00 00       	mov    $0xe,%eax
 435:	cd 40                	int    $0x40
 437:	c3                   	ret    

00000438 <hello>:
SYSCALL(hello)
 438:	b8 16 00 00 00       	mov    $0x16,%eax
 43d:	cd 40                	int    $0x40
 43f:	c3                   	ret    

00000440 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 440:	55                   	push   %ebp
 441:	89 e5                	mov    %esp,%ebp
 443:	57                   	push   %edi
 444:	89 cf                	mov    %ecx,%edi
 446:	56                   	push   %esi
 447:	89 c6                	mov    %eax,%esi
 449:	53                   	push   %ebx
 44a:	83 ec 4c             	sub    $0x4c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 44d:	8b 4d 08             	mov    0x8(%ebp),%ecx
 450:	85 c9                	test   %ecx,%ecx
 452:	74 04                	je     458 <printint+0x18>
 454:	85 d2                	test   %edx,%edx
 456:	78 68                	js     4c0 <printint+0x80>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 458:	89 d0                	mov    %edx,%eax
 45a:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 461:	31 c9                	xor    %ecx,%ecx
 463:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 466:	66 90                	xchg   %ax,%ax
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
 468:	31 d2                	xor    %edx,%edx
 46a:	f7 f7                	div    %edi
 46c:	0f b6 92 60 08 00 00 	movzbl 0x860(%edx),%edx
 473:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
 476:	83 c1 01             	add    $0x1,%ecx
  }while((x /= base) != 0);
 479:	85 c0                	test   %eax,%eax
 47b:	75 eb                	jne    468 <printint+0x28>
  if(neg)
 47d:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 480:	85 c0                	test   %eax,%eax
 482:	74 08                	je     48c <printint+0x4c>
    buf[i++] = '-';
 484:	c6 44 0d d7 2d       	movb   $0x2d,-0x29(%ebp,%ecx,1)
 489:	83 c1 01             	add    $0x1,%ecx

  while(--i >= 0)
 48c:	8d 79 ff             	lea    -0x1(%ecx),%edi
 48f:	90                   	nop
 490:	0f b6 04 3b          	movzbl (%ebx,%edi,1),%eax
 494:	83 ef 01             	sub    $0x1,%edi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 497:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 49e:	00 
 49f:	89 34 24             	mov    %esi,(%esp)
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 4a2:	88 45 e7             	mov    %al,-0x19(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 4a5:	8d 45 e7             	lea    -0x19(%ebp),%eax
 4a8:	89 44 24 04          	mov    %eax,0x4(%esp)
 4ac:	e8 07 ff ff ff       	call   3b8 <write>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 4b1:	83 ff ff             	cmp    $0xffffffff,%edi
 4b4:	75 da                	jne    490 <printint+0x50>
    putc(fd, buf[i]);
}
 4b6:	83 c4 4c             	add    $0x4c,%esp
 4b9:	5b                   	pop    %ebx
 4ba:	5e                   	pop    %esi
 4bb:	5f                   	pop    %edi
 4bc:	5d                   	pop    %ebp
 4bd:	c3                   	ret    
 4be:	66 90                	xchg   %ax,%ax
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 4c0:	89 d0                	mov    %edx,%eax
 4c2:	f7 d8                	neg    %eax
 4c4:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
 4cb:	eb 94                	jmp    461 <printint+0x21>
 4cd:	8d 76 00             	lea    0x0(%esi),%esi

000004d0 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 4d0:	55                   	push   %ebp
 4d1:	89 e5                	mov    %esp,%ebp
 4d3:	57                   	push   %edi
 4d4:	56                   	push   %esi
 4d5:	53                   	push   %ebx
 4d6:	83 ec 3c             	sub    $0x3c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 4d9:	8b 45 0c             	mov    0xc(%ebp),%eax
 4dc:	0f b6 10             	movzbl (%eax),%edx
 4df:	84 d2                	test   %dl,%dl
 4e1:	0f 84 c1 00 00 00    	je     5a8 <printf+0xd8>
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
 4e7:	8d 4d 10             	lea    0x10(%ebp),%ecx
 4ea:	31 ff                	xor    %edi,%edi
 4ec:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
 4ef:	31 db                	xor    %ebx,%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 4f1:	8d 75 e7             	lea    -0x19(%ebp),%esi
 4f4:	eb 1e                	jmp    514 <printf+0x44>
 4f6:	66 90                	xchg   %ax,%ax
  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 4f8:	83 fa 25             	cmp    $0x25,%edx
 4fb:	0f 85 af 00 00 00    	jne    5b0 <printf+0xe0>
 501:	66 bf 25 00          	mov    $0x25,%di
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 505:	83 c3 01             	add    $0x1,%ebx
 508:	0f b6 14 18          	movzbl (%eax,%ebx,1),%edx
 50c:	84 d2                	test   %dl,%dl
 50e:	0f 84 94 00 00 00    	je     5a8 <printf+0xd8>
    c = fmt[i] & 0xff;
    if(state == 0){
 514:	85 ff                	test   %edi,%edi
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
 516:	0f b6 d2             	movzbl %dl,%edx
    if(state == 0){
 519:	74 dd                	je     4f8 <printf+0x28>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 51b:	83 ff 25             	cmp    $0x25,%edi
 51e:	75 e5                	jne    505 <printf+0x35>
      if(c == 'd'){
 520:	83 fa 64             	cmp    $0x64,%edx
 523:	0f 84 3f 01 00 00    	je     668 <printf+0x198>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 529:	83 fa 70             	cmp    $0x70,%edx
 52c:	0f 84 a6 00 00 00    	je     5d8 <printf+0x108>
 532:	83 fa 78             	cmp    $0x78,%edx
 535:	0f 84 9d 00 00 00    	je     5d8 <printf+0x108>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 53b:	83 fa 73             	cmp    $0x73,%edx
 53e:	66 90                	xchg   %ax,%ax
 540:	0f 84 ba 00 00 00    	je     600 <printf+0x130>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 546:	83 fa 63             	cmp    $0x63,%edx
 549:	0f 84 41 01 00 00    	je     690 <printf+0x1c0>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 54f:	83 fa 25             	cmp    $0x25,%edx
 552:	0f 84 00 01 00 00    	je     658 <printf+0x188>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 558:	8b 4d 08             	mov    0x8(%ebp),%ecx
 55b:	89 55 cc             	mov    %edx,-0x34(%ebp)
 55e:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 562:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 569:	00 
 56a:	89 74 24 04          	mov    %esi,0x4(%esp)
 56e:	89 0c 24             	mov    %ecx,(%esp)
 571:	e8 42 fe ff ff       	call   3b8 <write>
 576:	8b 55 cc             	mov    -0x34(%ebp),%edx
 579:	88 55 e7             	mov    %dl,-0x19(%ebp)
 57c:	8b 45 08             	mov    0x8(%ebp),%eax
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 57f:	83 c3 01             	add    $0x1,%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 582:	31 ff                	xor    %edi,%edi
 584:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 58b:	00 
 58c:	89 74 24 04          	mov    %esi,0x4(%esp)
 590:	89 04 24             	mov    %eax,(%esp)
 593:	e8 20 fe ff ff       	call   3b8 <write>
 598:	8b 45 0c             	mov    0xc(%ebp),%eax
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 59b:	0f b6 14 18          	movzbl (%eax,%ebx,1),%edx
 59f:	84 d2                	test   %dl,%dl
 5a1:	0f 85 6d ff ff ff    	jne    514 <printf+0x44>
 5a7:	90                   	nop
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 5a8:	83 c4 3c             	add    $0x3c,%esp
 5ab:	5b                   	pop    %ebx
 5ac:	5e                   	pop    %esi
 5ad:	5f                   	pop    %edi
 5ae:	5d                   	pop    %ebp
 5af:	c3                   	ret    
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 5b0:	8b 45 08             	mov    0x8(%ebp),%eax
  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 5b3:	88 55 e7             	mov    %dl,-0x19(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 5b6:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 5bd:	00 
 5be:	89 74 24 04          	mov    %esi,0x4(%esp)
 5c2:	89 04 24             	mov    %eax,(%esp)
 5c5:	e8 ee fd ff ff       	call   3b8 <write>
 5ca:	8b 45 0c             	mov    0xc(%ebp),%eax
 5cd:	e9 33 ff ff ff       	jmp    505 <printf+0x35>
 5d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 5d8:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 5db:	b9 10 00 00 00       	mov    $0x10,%ecx
        ap++;
 5e0:	31 ff                	xor    %edi,%edi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 5e2:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 5e9:	8b 10                	mov    (%eax),%edx
 5eb:	8b 45 08             	mov    0x8(%ebp),%eax
 5ee:	e8 4d fe ff ff       	call   440 <printint>
 5f3:	8b 45 0c             	mov    0xc(%ebp),%eax
        ap++;
 5f6:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
 5fa:	e9 06 ff ff ff       	jmp    505 <printf+0x35>
 5ff:	90                   	nop
      } else if(c == 's'){
        s = (char*)*ap;
 600:	8b 55 d4             	mov    -0x2c(%ebp),%edx
        ap++;
        if(s == 0)
 603:	b9 59 08 00 00       	mov    $0x859,%ecx
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
        s = (char*)*ap;
 608:	8b 3a                	mov    (%edx),%edi
        ap++;
 60a:	83 c2 04             	add    $0x4,%edx
 60d:	89 55 d4             	mov    %edx,-0x2c(%ebp)
        if(s == 0)
 610:	85 ff                	test   %edi,%edi
 612:	0f 44 f9             	cmove  %ecx,%edi
          s = "(null)";
        while(*s != 0){
 615:	0f b6 17             	movzbl (%edi),%edx
 618:	84 d2                	test   %dl,%dl
 61a:	74 33                	je     64f <printf+0x17f>
 61c:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 61f:	8b 5d 08             	mov    0x8(%ebp),%ebx
 622:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
          putc(fd, *s);
          s++;
 628:	83 c7 01             	add    $0x1,%edi
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 62b:	88 55 e7             	mov    %dl,-0x19(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 62e:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 635:	00 
 636:	89 74 24 04          	mov    %esi,0x4(%esp)
 63a:	89 1c 24             	mov    %ebx,(%esp)
 63d:	e8 76 fd ff ff       	call   3b8 <write>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 642:	0f b6 17             	movzbl (%edi),%edx
 645:	84 d2                	test   %dl,%dl
 647:	75 df                	jne    628 <printf+0x158>
 649:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 64c:	8b 45 0c             	mov    0xc(%ebp),%eax
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 64f:	31 ff                	xor    %edi,%edi
 651:	e9 af fe ff ff       	jmp    505 <printf+0x35>
 656:	66 90                	xchg   %ax,%ax
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 658:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 65c:	e9 1b ff ff ff       	jmp    57c <printf+0xac>
 661:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 668:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 66b:	b9 0a 00 00 00       	mov    $0xa,%ecx
        ap++;
 670:	66 31 ff             	xor    %di,%di
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 673:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 67a:	8b 10                	mov    (%eax),%edx
 67c:	8b 45 08             	mov    0x8(%ebp),%eax
 67f:	e8 bc fd ff ff       	call   440 <printint>
 684:	8b 45 0c             	mov    0xc(%ebp),%eax
        ap++;
 687:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
 68b:	e9 75 fe ff ff       	jmp    505 <printf+0x35>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 690:	8b 55 d4             	mov    -0x2c(%ebp),%edx
        putc(fd, *ap);
        ap++;
 693:	31 ff                	xor    %edi,%edi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 695:	8b 4d 08             	mov    0x8(%ebp),%ecx
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 698:	8b 02                	mov    (%edx),%eax
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 69a:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 6a1:	00 
 6a2:	89 74 24 04          	mov    %esi,0x4(%esp)
 6a6:	89 0c 24             	mov    %ecx,(%esp)
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 6a9:	88 45 e7             	mov    %al,-0x19(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 6ac:	e8 07 fd ff ff       	call   3b8 <write>
 6b1:	8b 45 0c             	mov    0xc(%ebp),%eax
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
        ap++;
 6b4:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
 6b8:	e9 48 fe ff ff       	jmp    505 <printf+0x35>
 6bd:	90                   	nop
 6be:	90                   	nop
 6bf:	90                   	nop

000006c0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 6c0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6c1:	a1 7c 08 00 00       	mov    0x87c,%eax
static Header base;
static Header *freep;

void
free(void *ap)
{
 6c6:	89 e5                	mov    %esp,%ebp
 6c8:	57                   	push   %edi
 6c9:	56                   	push   %esi
 6ca:	53                   	push   %ebx
 6cb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
 6ce:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6d1:	39 c8                	cmp    %ecx,%eax
 6d3:	73 1d                	jae    6f2 <free+0x32>
 6d5:	8d 76 00             	lea    0x0(%esi),%esi
 6d8:	8b 10                	mov    (%eax),%edx
 6da:	39 d1                	cmp    %edx,%ecx
 6dc:	72 1a                	jb     6f8 <free+0x38>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6de:	39 d0                	cmp    %edx,%eax
 6e0:	72 08                	jb     6ea <free+0x2a>
 6e2:	39 c8                	cmp    %ecx,%eax
 6e4:	72 12                	jb     6f8 <free+0x38>
 6e6:	39 d1                	cmp    %edx,%ecx
 6e8:	72 0e                	jb     6f8 <free+0x38>
 6ea:	89 d0                	mov    %edx,%eax
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6ec:	39 c8                	cmp    %ecx,%eax
 6ee:	66 90                	xchg   %ax,%ax
 6f0:	72 e6                	jb     6d8 <free+0x18>
 6f2:	8b 10                	mov    (%eax),%edx
 6f4:	eb e8                	jmp    6de <free+0x1e>
 6f6:	66 90                	xchg   %ax,%ax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 6f8:	8b 71 04             	mov    0x4(%ecx),%esi
 6fb:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 6fe:	39 d7                	cmp    %edx,%edi
 700:	74 19                	je     71b <free+0x5b>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 702:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 705:	8b 50 04             	mov    0x4(%eax),%edx
 708:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 70b:	39 ce                	cmp    %ecx,%esi
 70d:	74 23                	je     732 <free+0x72>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 70f:	89 08                	mov    %ecx,(%eax)
  freep = p;
 711:	a3 7c 08 00 00       	mov    %eax,0x87c
}
 716:	5b                   	pop    %ebx
 717:	5e                   	pop    %esi
 718:	5f                   	pop    %edi
 719:	5d                   	pop    %ebp
 71a:	c3                   	ret    
  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 71b:	03 72 04             	add    0x4(%edx),%esi
 71e:	89 71 04             	mov    %esi,0x4(%ecx)
    bp->s.ptr = p->s.ptr->s.ptr;
 721:	8b 10                	mov    (%eax),%edx
 723:	8b 12                	mov    (%edx),%edx
 725:	89 53 f8             	mov    %edx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 728:	8b 50 04             	mov    0x4(%eax),%edx
 72b:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 72e:	39 ce                	cmp    %ecx,%esi
 730:	75 dd                	jne    70f <free+0x4f>
    p->s.size += bp->s.size;
 732:	03 51 04             	add    0x4(%ecx),%edx
 735:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 738:	8b 53 f8             	mov    -0x8(%ebx),%edx
 73b:	89 10                	mov    %edx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
 73d:	a3 7c 08 00 00       	mov    %eax,0x87c
}
 742:	5b                   	pop    %ebx
 743:	5e                   	pop    %esi
 744:	5f                   	pop    %edi
 745:	5d                   	pop    %ebp
 746:	c3                   	ret    
 747:	89 f6                	mov    %esi,%esi
 749:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000750 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 750:	55                   	push   %ebp
 751:	89 e5                	mov    %esp,%ebp
 753:	57                   	push   %edi
 754:	56                   	push   %esi
 755:	53                   	push   %ebx
 756:	83 ec 2c             	sub    $0x2c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 759:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if((prevp = freep) == 0){
 75c:	8b 0d 7c 08 00 00    	mov    0x87c,%ecx
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 762:	83 c3 07             	add    $0x7,%ebx
 765:	c1 eb 03             	shr    $0x3,%ebx
 768:	83 c3 01             	add    $0x1,%ebx
  if((prevp = freep) == 0){
 76b:	85 c9                	test   %ecx,%ecx
 76d:	0f 84 9b 00 00 00    	je     80e <malloc+0xbe>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 773:	8b 01                	mov    (%ecx),%eax
    if(p->s.size >= nunits){
 775:	8b 50 04             	mov    0x4(%eax),%edx
 778:	39 d3                	cmp    %edx,%ebx
 77a:	76 27                	jbe    7a3 <malloc+0x53>
        p->s.size -= nunits;
        p += p->s.size;
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
 77c:	8d 3c dd 00 00 00 00 	lea    0x0(,%ebx,8),%edi
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < 4096)
 783:	be 00 80 00 00       	mov    $0x8000,%esi
 788:	89 7d e4             	mov    %edi,-0x1c(%ebp)
 78b:	90                   	nop
 78c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 790:	3b 05 7c 08 00 00    	cmp    0x87c,%eax
 796:	74 30                	je     7c8 <malloc+0x78>
 798:	89 c1                	mov    %eax,%ecx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 79a:	8b 01                	mov    (%ecx),%eax
    if(p->s.size >= nunits){
 79c:	8b 50 04             	mov    0x4(%eax),%edx
 79f:	39 d3                	cmp    %edx,%ebx
 7a1:	77 ed                	ja     790 <malloc+0x40>
      if(p->s.size == nunits)
 7a3:	39 d3                	cmp    %edx,%ebx
 7a5:	74 61                	je     808 <malloc+0xb8>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 7a7:	29 da                	sub    %ebx,%edx
 7a9:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 7ac:	8d 04 d0             	lea    (%eax,%edx,8),%eax
        p->s.size = nunits;
 7af:	89 58 04             	mov    %ebx,0x4(%eax)
      }
      freep = prevp;
 7b2:	89 0d 7c 08 00 00    	mov    %ecx,0x87c
      return (void*)(p + 1);
 7b8:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 7bb:	83 c4 2c             	add    $0x2c,%esp
 7be:	5b                   	pop    %ebx
 7bf:	5e                   	pop    %esi
 7c0:	5f                   	pop    %edi
 7c1:	5d                   	pop    %ebp
 7c2:	c3                   	ret    
 7c3:	90                   	nop
 7c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < 4096)
 7c8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 7cb:	81 fb 00 10 00 00    	cmp    $0x1000,%ebx
 7d1:	bf 00 10 00 00       	mov    $0x1000,%edi
 7d6:	0f 43 fb             	cmovae %ebx,%edi
 7d9:	0f 42 c6             	cmovb  %esi,%eax
    nu = 4096;
  p = sbrk(nu * sizeof(Header));
 7dc:	89 04 24             	mov    %eax,(%esp)
 7df:	e8 3c fc ff ff       	call   420 <sbrk>
  if(p == (char*)-1)
 7e4:	83 f8 ff             	cmp    $0xffffffff,%eax
 7e7:	74 18                	je     801 <malloc+0xb1>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
 7e9:	89 78 04             	mov    %edi,0x4(%eax)
  free((void*)(hp + 1));
 7ec:	83 c0 08             	add    $0x8,%eax
 7ef:	89 04 24             	mov    %eax,(%esp)
 7f2:	e8 c9 fe ff ff       	call   6c0 <free>
  return freep;
 7f7:	8b 0d 7c 08 00 00    	mov    0x87c,%ecx
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
 7fd:	85 c9                	test   %ecx,%ecx
 7ff:	75 99                	jne    79a <malloc+0x4a>
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 801:	31 c0                	xor    %eax,%eax
 803:	eb b6                	jmp    7bb <malloc+0x6b>
 805:	8d 76 00             	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
 808:	8b 10                	mov    (%eax),%edx
 80a:	89 11                	mov    %edx,(%ecx)
 80c:	eb a4                	jmp    7b2 <malloc+0x62>
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 80e:	c7 05 7c 08 00 00 74 	movl   $0x874,0x87c
 815:	08 00 00 
    base.s.size = 0;
 818:	b9 74 08 00 00       	mov    $0x874,%ecx
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 81d:	c7 05 74 08 00 00 74 	movl   $0x874,0x874
 824:	08 00 00 
    base.s.size = 0;
 827:	c7 05 78 08 00 00 00 	movl   $0x0,0x878
 82e:	00 00 00 
 831:	e9 3d ff ff ff       	jmp    773 <malloc+0x23>
