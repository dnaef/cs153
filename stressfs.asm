
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
  35:	c7 44 24 04 46 08 00 	movl   $0x846,0x4(%esp)
  3c:	00 
  3d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  44:	e8 97 04 00 00       	call   4e0 <printf>
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
  99:	c7 44 24 04 59 08 00 	movl   $0x859,0x4(%esp)
  a0:	00 
  a1:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  a8:	e8 33 04 00 00       	call   4e0 <printf>

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
  f6:	c7 44 24 04 63 08 00 	movl   $0x863,0x4(%esp)
  fd:	00 
  fe:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 105:	e8 d6 03 00 00       	call   4e0 <printf>

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
SYSCALL(hello) 			// added for Lab0
 438:	b8 16 00 00 00       	mov    $0x16,%eax
 43d:	cd 40                	int    $0x40
 43f:	c3                   	ret    

00000440 <waitpid>:
SYSCALL(waitpid) 		// lab1 part 1: c
 440:	b8 17 00 00 00       	mov    $0x17,%eax
 445:	cd 40                	int    $0x40
 447:	c3                   	ret    

00000448 <setpriority>:
SYSCALL(setpriority) 	// lab1 part 2: define syscall
 448:	b8 18 00 00 00       	mov    $0x18,%eax
 44d:	cd 40                	int    $0x40
 44f:	c3                   	ret    

00000450 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 450:	55                   	push   %ebp
 451:	89 e5                	mov    %esp,%ebp
 453:	57                   	push   %edi
 454:	89 cf                	mov    %ecx,%edi
 456:	56                   	push   %esi
 457:	89 c6                	mov    %eax,%esi
 459:	53                   	push   %ebx
 45a:	83 ec 4c             	sub    $0x4c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 45d:	8b 4d 08             	mov    0x8(%ebp),%ecx
 460:	85 c9                	test   %ecx,%ecx
 462:	74 04                	je     468 <printint+0x18>
 464:	85 d2                	test   %edx,%edx
 466:	78 68                	js     4d0 <printint+0x80>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 468:	89 d0                	mov    %edx,%eax
 46a:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 471:	31 c9                	xor    %ecx,%ecx
 473:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 476:	66 90                	xchg   %ax,%ax
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
 478:	31 d2                	xor    %edx,%edx
 47a:	f7 f7                	div    %edi
 47c:	0f b6 92 70 08 00 00 	movzbl 0x870(%edx),%edx
 483:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
 486:	83 c1 01             	add    $0x1,%ecx
  }while((x /= base) != 0);
 489:	85 c0                	test   %eax,%eax
 48b:	75 eb                	jne    478 <printint+0x28>
  if(neg)
 48d:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 490:	85 c0                	test   %eax,%eax
 492:	74 08                	je     49c <printint+0x4c>
    buf[i++] = '-';
 494:	c6 44 0d d7 2d       	movb   $0x2d,-0x29(%ebp,%ecx,1)
 499:	83 c1 01             	add    $0x1,%ecx

  while(--i >= 0)
 49c:	8d 79 ff             	lea    -0x1(%ecx),%edi
 49f:	90                   	nop
 4a0:	0f b6 04 3b          	movzbl (%ebx,%edi,1),%eax
 4a4:	83 ef 01             	sub    $0x1,%edi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 4a7:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 4ae:	00 
 4af:	89 34 24             	mov    %esi,(%esp)
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 4b2:	88 45 e7             	mov    %al,-0x19(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 4b5:	8d 45 e7             	lea    -0x19(%ebp),%eax
 4b8:	89 44 24 04          	mov    %eax,0x4(%esp)
 4bc:	e8 f7 fe ff ff       	call   3b8 <write>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 4c1:	83 ff ff             	cmp    $0xffffffff,%edi
 4c4:	75 da                	jne    4a0 <printint+0x50>
    putc(fd, buf[i]);
}
 4c6:	83 c4 4c             	add    $0x4c,%esp
 4c9:	5b                   	pop    %ebx
 4ca:	5e                   	pop    %esi
 4cb:	5f                   	pop    %edi
 4cc:	5d                   	pop    %ebp
 4cd:	c3                   	ret    
 4ce:	66 90                	xchg   %ax,%ax
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 4d0:	89 d0                	mov    %edx,%eax
 4d2:	f7 d8                	neg    %eax
 4d4:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
 4db:	eb 94                	jmp    471 <printint+0x21>
 4dd:	8d 76 00             	lea    0x0(%esi),%esi

000004e0 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 4e0:	55                   	push   %ebp
 4e1:	89 e5                	mov    %esp,%ebp
 4e3:	57                   	push   %edi
 4e4:	56                   	push   %esi
 4e5:	53                   	push   %ebx
 4e6:	83 ec 3c             	sub    $0x3c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 4e9:	8b 45 0c             	mov    0xc(%ebp),%eax
 4ec:	0f b6 10             	movzbl (%eax),%edx
 4ef:	84 d2                	test   %dl,%dl
 4f1:	0f 84 c1 00 00 00    	je     5b8 <printf+0xd8>
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
 4f7:	8d 4d 10             	lea    0x10(%ebp),%ecx
 4fa:	31 ff                	xor    %edi,%edi
 4fc:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
 4ff:	31 db                	xor    %ebx,%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 501:	8d 75 e7             	lea    -0x19(%ebp),%esi
 504:	eb 1e                	jmp    524 <printf+0x44>
 506:	66 90                	xchg   %ax,%ax
  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 508:	83 fa 25             	cmp    $0x25,%edx
 50b:	0f 85 af 00 00 00    	jne    5c0 <printf+0xe0>
 511:	66 bf 25 00          	mov    $0x25,%di
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 515:	83 c3 01             	add    $0x1,%ebx
 518:	0f b6 14 18          	movzbl (%eax,%ebx,1),%edx
 51c:	84 d2                	test   %dl,%dl
 51e:	0f 84 94 00 00 00    	je     5b8 <printf+0xd8>
    c = fmt[i] & 0xff;
    if(state == 0){
 524:	85 ff                	test   %edi,%edi
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
 526:	0f b6 d2             	movzbl %dl,%edx
    if(state == 0){
 529:	74 dd                	je     508 <printf+0x28>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 52b:	83 ff 25             	cmp    $0x25,%edi
 52e:	75 e5                	jne    515 <printf+0x35>
      if(c == 'd'){
 530:	83 fa 64             	cmp    $0x64,%edx
 533:	0f 84 3f 01 00 00    	je     678 <printf+0x198>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 539:	83 fa 70             	cmp    $0x70,%edx
 53c:	0f 84 a6 00 00 00    	je     5e8 <printf+0x108>
 542:	83 fa 78             	cmp    $0x78,%edx
 545:	0f 84 9d 00 00 00    	je     5e8 <printf+0x108>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 54b:	83 fa 73             	cmp    $0x73,%edx
 54e:	66 90                	xchg   %ax,%ax
 550:	0f 84 ba 00 00 00    	je     610 <printf+0x130>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 556:	83 fa 63             	cmp    $0x63,%edx
 559:	0f 84 41 01 00 00    	je     6a0 <printf+0x1c0>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 55f:	83 fa 25             	cmp    $0x25,%edx
 562:	0f 84 00 01 00 00    	je     668 <printf+0x188>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 568:	8b 4d 08             	mov    0x8(%ebp),%ecx
 56b:	89 55 cc             	mov    %edx,-0x34(%ebp)
 56e:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 572:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 579:	00 
 57a:	89 74 24 04          	mov    %esi,0x4(%esp)
 57e:	89 0c 24             	mov    %ecx,(%esp)
 581:	e8 32 fe ff ff       	call   3b8 <write>
 586:	8b 55 cc             	mov    -0x34(%ebp),%edx
 589:	88 55 e7             	mov    %dl,-0x19(%ebp)
 58c:	8b 45 08             	mov    0x8(%ebp),%eax
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 58f:	83 c3 01             	add    $0x1,%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 592:	31 ff                	xor    %edi,%edi
 594:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 59b:	00 
 59c:	89 74 24 04          	mov    %esi,0x4(%esp)
 5a0:	89 04 24             	mov    %eax,(%esp)
 5a3:	e8 10 fe ff ff       	call   3b8 <write>
 5a8:	8b 45 0c             	mov    0xc(%ebp),%eax
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 5ab:	0f b6 14 18          	movzbl (%eax,%ebx,1),%edx
 5af:	84 d2                	test   %dl,%dl
 5b1:	0f 85 6d ff ff ff    	jne    524 <printf+0x44>
 5b7:	90                   	nop
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 5b8:	83 c4 3c             	add    $0x3c,%esp
 5bb:	5b                   	pop    %ebx
 5bc:	5e                   	pop    %esi
 5bd:	5f                   	pop    %edi
 5be:	5d                   	pop    %ebp
 5bf:	c3                   	ret    
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 5c0:	8b 45 08             	mov    0x8(%ebp),%eax
  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 5c3:	88 55 e7             	mov    %dl,-0x19(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 5c6:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 5cd:	00 
 5ce:	89 74 24 04          	mov    %esi,0x4(%esp)
 5d2:	89 04 24             	mov    %eax,(%esp)
 5d5:	e8 de fd ff ff       	call   3b8 <write>
 5da:	8b 45 0c             	mov    0xc(%ebp),%eax
 5dd:	e9 33 ff ff ff       	jmp    515 <printf+0x35>
 5e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 5e8:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 5eb:	b9 10 00 00 00       	mov    $0x10,%ecx
        ap++;
 5f0:	31 ff                	xor    %edi,%edi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 5f2:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 5f9:	8b 10                	mov    (%eax),%edx
 5fb:	8b 45 08             	mov    0x8(%ebp),%eax
 5fe:	e8 4d fe ff ff       	call   450 <printint>
 603:	8b 45 0c             	mov    0xc(%ebp),%eax
        ap++;
 606:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
 60a:	e9 06 ff ff ff       	jmp    515 <printf+0x35>
 60f:	90                   	nop
      } else if(c == 's'){
        s = (char*)*ap;
 610:	8b 55 d4             	mov    -0x2c(%ebp),%edx
        ap++;
        if(s == 0)
 613:	b9 69 08 00 00       	mov    $0x869,%ecx
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
        s = (char*)*ap;
 618:	8b 3a                	mov    (%edx),%edi
        ap++;
 61a:	83 c2 04             	add    $0x4,%edx
 61d:	89 55 d4             	mov    %edx,-0x2c(%ebp)
        if(s == 0)
 620:	85 ff                	test   %edi,%edi
 622:	0f 44 f9             	cmove  %ecx,%edi
          s = "(null)";
        while(*s != 0){
 625:	0f b6 17             	movzbl (%edi),%edx
 628:	84 d2                	test   %dl,%dl
 62a:	74 33                	je     65f <printf+0x17f>
 62c:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 62f:	8b 5d 08             	mov    0x8(%ebp),%ebx
 632:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
          putc(fd, *s);
          s++;
 638:	83 c7 01             	add    $0x1,%edi
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 63b:	88 55 e7             	mov    %dl,-0x19(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 63e:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 645:	00 
 646:	89 74 24 04          	mov    %esi,0x4(%esp)
 64a:	89 1c 24             	mov    %ebx,(%esp)
 64d:	e8 66 fd ff ff       	call   3b8 <write>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 652:	0f b6 17             	movzbl (%edi),%edx
 655:	84 d2                	test   %dl,%dl
 657:	75 df                	jne    638 <printf+0x158>
 659:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 65c:	8b 45 0c             	mov    0xc(%ebp),%eax
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 65f:	31 ff                	xor    %edi,%edi
 661:	e9 af fe ff ff       	jmp    515 <printf+0x35>
 666:	66 90                	xchg   %ax,%ax
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 668:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 66c:	e9 1b ff ff ff       	jmp    58c <printf+0xac>
 671:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 678:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 67b:	b9 0a 00 00 00       	mov    $0xa,%ecx
        ap++;
 680:	66 31 ff             	xor    %di,%di
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 683:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 68a:	8b 10                	mov    (%eax),%edx
 68c:	8b 45 08             	mov    0x8(%ebp),%eax
 68f:	e8 bc fd ff ff       	call   450 <printint>
 694:	8b 45 0c             	mov    0xc(%ebp),%eax
        ap++;
 697:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
 69b:	e9 75 fe ff ff       	jmp    515 <printf+0x35>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 6a0:	8b 55 d4             	mov    -0x2c(%ebp),%edx
        putc(fd, *ap);
        ap++;
 6a3:	31 ff                	xor    %edi,%edi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 6a5:	8b 4d 08             	mov    0x8(%ebp),%ecx
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 6a8:	8b 02                	mov    (%edx),%eax
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 6aa:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 6b1:	00 
 6b2:	89 74 24 04          	mov    %esi,0x4(%esp)
 6b6:	89 0c 24             	mov    %ecx,(%esp)
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 6b9:	88 45 e7             	mov    %al,-0x19(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 6bc:	e8 f7 fc ff ff       	call   3b8 <write>
 6c1:	8b 45 0c             	mov    0xc(%ebp),%eax
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
        ap++;
 6c4:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
 6c8:	e9 48 fe ff ff       	jmp    515 <printf+0x35>
 6cd:	90                   	nop
 6ce:	90                   	nop
 6cf:	90                   	nop

000006d0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 6d0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6d1:	a1 8c 08 00 00       	mov    0x88c,%eax
static Header base;
static Header *freep;

void
free(void *ap)
{
 6d6:	89 e5                	mov    %esp,%ebp
 6d8:	57                   	push   %edi
 6d9:	56                   	push   %esi
 6da:	53                   	push   %ebx
 6db:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
 6de:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6e1:	39 c8                	cmp    %ecx,%eax
 6e3:	73 1d                	jae    702 <free+0x32>
 6e5:	8d 76 00             	lea    0x0(%esi),%esi
 6e8:	8b 10                	mov    (%eax),%edx
 6ea:	39 d1                	cmp    %edx,%ecx
 6ec:	72 1a                	jb     708 <free+0x38>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6ee:	39 d0                	cmp    %edx,%eax
 6f0:	72 08                	jb     6fa <free+0x2a>
 6f2:	39 c8                	cmp    %ecx,%eax
 6f4:	72 12                	jb     708 <free+0x38>
 6f6:	39 d1                	cmp    %edx,%ecx
 6f8:	72 0e                	jb     708 <free+0x38>
 6fa:	89 d0                	mov    %edx,%eax
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6fc:	39 c8                	cmp    %ecx,%eax
 6fe:	66 90                	xchg   %ax,%ax
 700:	72 e6                	jb     6e8 <free+0x18>
 702:	8b 10                	mov    (%eax),%edx
 704:	eb e8                	jmp    6ee <free+0x1e>
 706:	66 90                	xchg   %ax,%ax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 708:	8b 71 04             	mov    0x4(%ecx),%esi
 70b:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 70e:	39 d7                	cmp    %edx,%edi
 710:	74 19                	je     72b <free+0x5b>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 712:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 715:	8b 50 04             	mov    0x4(%eax),%edx
 718:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 71b:	39 ce                	cmp    %ecx,%esi
 71d:	74 23                	je     742 <free+0x72>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 71f:	89 08                	mov    %ecx,(%eax)
  freep = p;
 721:	a3 8c 08 00 00       	mov    %eax,0x88c
}
 726:	5b                   	pop    %ebx
 727:	5e                   	pop    %esi
 728:	5f                   	pop    %edi
 729:	5d                   	pop    %ebp
 72a:	c3                   	ret    
  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 72b:	03 72 04             	add    0x4(%edx),%esi
 72e:	89 71 04             	mov    %esi,0x4(%ecx)
    bp->s.ptr = p->s.ptr->s.ptr;
 731:	8b 10                	mov    (%eax),%edx
 733:	8b 12                	mov    (%edx),%edx
 735:	89 53 f8             	mov    %edx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 738:	8b 50 04             	mov    0x4(%eax),%edx
 73b:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 73e:	39 ce                	cmp    %ecx,%esi
 740:	75 dd                	jne    71f <free+0x4f>
    p->s.size += bp->s.size;
 742:	03 51 04             	add    0x4(%ecx),%edx
 745:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 748:	8b 53 f8             	mov    -0x8(%ebx),%edx
 74b:	89 10                	mov    %edx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
 74d:	a3 8c 08 00 00       	mov    %eax,0x88c
}
 752:	5b                   	pop    %ebx
 753:	5e                   	pop    %esi
 754:	5f                   	pop    %edi
 755:	5d                   	pop    %ebp
 756:	c3                   	ret    
 757:	89 f6                	mov    %esi,%esi
 759:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000760 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 760:	55                   	push   %ebp
 761:	89 e5                	mov    %esp,%ebp
 763:	57                   	push   %edi
 764:	56                   	push   %esi
 765:	53                   	push   %ebx
 766:	83 ec 2c             	sub    $0x2c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 769:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if((prevp = freep) == 0){
 76c:	8b 0d 8c 08 00 00    	mov    0x88c,%ecx
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 772:	83 c3 07             	add    $0x7,%ebx
 775:	c1 eb 03             	shr    $0x3,%ebx
 778:	83 c3 01             	add    $0x1,%ebx
  if((prevp = freep) == 0){
 77b:	85 c9                	test   %ecx,%ecx
 77d:	0f 84 9b 00 00 00    	je     81e <malloc+0xbe>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 783:	8b 01                	mov    (%ecx),%eax
    if(p->s.size >= nunits){
 785:	8b 50 04             	mov    0x4(%eax),%edx
 788:	39 d3                	cmp    %edx,%ebx
 78a:	76 27                	jbe    7b3 <malloc+0x53>
        p->s.size -= nunits;
        p += p->s.size;
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
 78c:	8d 3c dd 00 00 00 00 	lea    0x0(,%ebx,8),%edi
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < 4096)
 793:	be 00 80 00 00       	mov    $0x8000,%esi
 798:	89 7d e4             	mov    %edi,-0x1c(%ebp)
 79b:	90                   	nop
 79c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 7a0:	3b 05 8c 08 00 00    	cmp    0x88c,%eax
 7a6:	74 30                	je     7d8 <malloc+0x78>
 7a8:	89 c1                	mov    %eax,%ecx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7aa:	8b 01                	mov    (%ecx),%eax
    if(p->s.size >= nunits){
 7ac:	8b 50 04             	mov    0x4(%eax),%edx
 7af:	39 d3                	cmp    %edx,%ebx
 7b1:	77 ed                	ja     7a0 <malloc+0x40>
      if(p->s.size == nunits)
 7b3:	39 d3                	cmp    %edx,%ebx
 7b5:	74 61                	je     818 <malloc+0xb8>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 7b7:	29 da                	sub    %ebx,%edx
 7b9:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 7bc:	8d 04 d0             	lea    (%eax,%edx,8),%eax
        p->s.size = nunits;
 7bf:	89 58 04             	mov    %ebx,0x4(%eax)
      }
      freep = prevp;
 7c2:	89 0d 8c 08 00 00    	mov    %ecx,0x88c
      return (void*)(p + 1);
 7c8:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 7cb:	83 c4 2c             	add    $0x2c,%esp
 7ce:	5b                   	pop    %ebx
 7cf:	5e                   	pop    %esi
 7d0:	5f                   	pop    %edi
 7d1:	5d                   	pop    %ebp
 7d2:	c3                   	ret    
 7d3:	90                   	nop
 7d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < 4096)
 7d8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 7db:	81 fb 00 10 00 00    	cmp    $0x1000,%ebx
 7e1:	bf 00 10 00 00       	mov    $0x1000,%edi
 7e6:	0f 43 fb             	cmovae %ebx,%edi
 7e9:	0f 42 c6             	cmovb  %esi,%eax
    nu = 4096;
  p = sbrk(nu * sizeof(Header));
 7ec:	89 04 24             	mov    %eax,(%esp)
 7ef:	e8 2c fc ff ff       	call   420 <sbrk>
  if(p == (char*)-1)
 7f4:	83 f8 ff             	cmp    $0xffffffff,%eax
 7f7:	74 18                	je     811 <malloc+0xb1>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
 7f9:	89 78 04             	mov    %edi,0x4(%eax)
  free((void*)(hp + 1));
 7fc:	83 c0 08             	add    $0x8,%eax
 7ff:	89 04 24             	mov    %eax,(%esp)
 802:	e8 c9 fe ff ff       	call   6d0 <free>
  return freep;
 807:	8b 0d 8c 08 00 00    	mov    0x88c,%ecx
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
 80d:	85 c9                	test   %ecx,%ecx
 80f:	75 99                	jne    7aa <malloc+0x4a>
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 811:	31 c0                	xor    %eax,%eax
 813:	eb b6                	jmp    7cb <malloc+0x6b>
 815:	8d 76 00             	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
 818:	8b 10                	mov    (%eax),%edx
 81a:	89 11                	mov    %edx,(%ecx)
 81c:	eb a4                	jmp    7c2 <malloc+0x62>
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 81e:	c7 05 8c 08 00 00 84 	movl   $0x884,0x88c
 825:	08 00 00 
    base.s.size = 0;
 828:	b9 84 08 00 00       	mov    $0x884,%ecx
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 82d:	c7 05 84 08 00 00 84 	movl   $0x884,0x884
 834:	08 00 00 
    base.s.size = 0;
 837:	c7 05 88 08 00 00 00 	movl   $0x0,0x888
 83e:	00 00 00 
 841:	e9 3d ff ff ff       	jmp    783 <malloc+0x23>
