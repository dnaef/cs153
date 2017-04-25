
_cat:     file format elf32-i386


Disassembly of section .text:

00000000 <cat>:

char buf[512];

void
cat(int fd)
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	56                   	push   %esi
   4:	53                   	push   %ebx
   5:	83 ec 10             	sub    $0x10,%esp
   8:	8b 75 08             	mov    0x8(%ebp),%esi
  int n;

  while((n = read(fd, buf, sizeof(buf))) > 0) {
   b:	eb 1f                	jmp    2c <cat+0x2c>
   d:	8d 76 00             	lea    0x0(%esi),%esi
    if (write(1, buf, n) != n) {
  10:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  14:	c7 44 24 04 a0 08 00 	movl   $0x8a0,0x4(%esp)
  1b:	00 
  1c:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  23:	e8 70 03 00 00       	call   398 <write>
  28:	39 c3                	cmp    %eax,%ebx
  2a:	75 28                	jne    54 <cat+0x54>
void
cat(int fd)
{
  int n;

  while((n = read(fd, buf, sizeof(buf))) > 0) {
  2c:	c7 44 24 08 00 02 00 	movl   $0x200,0x8(%esp)
  33:	00 
  34:	c7 44 24 04 a0 08 00 	movl   $0x8a0,0x4(%esp)
  3b:	00 
  3c:	89 34 24             	mov    %esi,(%esp)
  3f:	e8 4c 03 00 00       	call   390 <read>
  44:	83 f8 00             	cmp    $0x0,%eax
  47:	89 c3                	mov    %eax,%ebx
  49:	7f c5                	jg     10 <cat+0x10>
    if (write(1, buf, n) != n) {
      printf(1, "cat: write error\n");
      exit(0);
    }
  }
  if(n < 0){
  4b:	75 27                	jne    74 <cat+0x74>
    printf(1, "cat: read error\n");
    exit(0);
  }
}
  4d:	83 c4 10             	add    $0x10,%esp
  50:	5b                   	pop    %ebx
  51:	5e                   	pop    %esi
  52:	5d                   	pop    %ebp
  53:	c3                   	ret    
{
  int n;

  while((n = read(fd, buf, sizeof(buf))) > 0) {
    if (write(1, buf, n) != n) {
      printf(1, "cat: write error\n");
  54:	c7 44 24 04 26 08 00 	movl   $0x826,0x4(%esp)
  5b:	00 
  5c:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  63:	e8 58 04 00 00       	call   4c0 <printf>
      exit(0);
  68:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  6f:	e8 04 03 00 00       	call   378 <exit>
    }
  }
  if(n < 0){
    printf(1, "cat: read error\n");
  74:	c7 44 24 04 38 08 00 	movl   $0x838,0x4(%esp)
  7b:	00 
  7c:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  83:	e8 38 04 00 00       	call   4c0 <printf>
    exit(0);
  88:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  8f:	e8 e4 02 00 00       	call   378 <exit>
  94:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  9a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000000a0 <main>:
  }
}

int
main(int argc, char *argv[])
{
  a0:	55                   	push   %ebp
  a1:	89 e5                	mov    %esp,%ebp
  a3:	83 e4 f0             	and    $0xfffffff0,%esp
  a6:	57                   	push   %edi
  a7:	56                   	push   %esi
  a8:	53                   	push   %ebx
  a9:	83 ec 24             	sub    $0x24,%esp
  ac:	8b 7d 08             	mov    0x8(%ebp),%edi
  int fd, i;

  if(argc <= 1){
  af:	83 ff 01             	cmp    $0x1,%edi
  b2:	7e 7c                	jle    130 <main+0x90>
    cat(0);
    exit(0);
  b4:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  b7:	be 01 00 00 00       	mov    $0x1,%esi
  bc:	83 c3 04             	add    $0x4,%ebx
  bf:	90                   	nop
  }

  for(i = 1; i < argc; i++){
    if((fd = open(argv[i], 0)) < 0){
  c0:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  c7:	00 
  c8:	8b 03                	mov    (%ebx),%eax
  ca:	89 04 24             	mov    %eax,(%esp)
  cd:	e8 e6 02 00 00       	call   3b8 <open>
  d2:	85 c0                	test   %eax,%eax
  d4:	78 32                	js     108 <main+0x68>
      printf(1, "cat: cannot open %s\n", argv[i]);
      exit(0);
    }
    cat(fd);
  d6:	89 04 24             	mov    %eax,(%esp)
  if(argc <= 1){
    cat(0);
    exit(0);
  }

  for(i = 1; i < argc; i++){
  d9:	83 c6 01             	add    $0x1,%esi
  dc:	83 c3 04             	add    $0x4,%ebx
    if((fd = open(argv[i], 0)) < 0){
      printf(1, "cat: cannot open %s\n", argv[i]);
      exit(0);
    }
    cat(fd);
  df:	89 44 24 1c          	mov    %eax,0x1c(%esp)
  e3:	e8 18 ff ff ff       	call   0 <cat>
    close(fd);
  e8:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  ec:	89 04 24             	mov    %eax,(%esp)
  ef:	e8 ac 02 00 00       	call   3a0 <close>
  if(argc <= 1){
    cat(0);
    exit(0);
  }

  for(i = 1; i < argc; i++){
  f4:	39 f7                	cmp    %esi,%edi
  f6:	7f c8                	jg     c0 <main+0x20>
      exit(0);
    }
    cat(fd);
    close(fd);
  }
  exit(0);
  f8:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  ff:	e8 74 02 00 00       	call   378 <exit>
 104:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    exit(0);
  }

  for(i = 1; i < argc; i++){
    if((fd = open(argv[i], 0)) < 0){
      printf(1, "cat: cannot open %s\n", argv[i]);
 108:	8b 03                	mov    (%ebx),%eax
 10a:	c7 44 24 04 49 08 00 	movl   $0x849,0x4(%esp)
 111:	00 
 112:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 119:	89 44 24 08          	mov    %eax,0x8(%esp)
 11d:	e8 9e 03 00 00       	call   4c0 <printf>
      exit(0);
 122:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 129:	e8 4a 02 00 00       	call   378 <exit>
 12e:	66 90                	xchg   %ax,%ax
main(int argc, char *argv[])
{
  int fd, i;

  if(argc <= 1){
    cat(0);
 130:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 137:	e8 c4 fe ff ff       	call   0 <cat>
    exit(0);
 13c:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 143:	e8 30 02 00 00       	call   378 <exit>
 148:	90                   	nop
 149:	90                   	nop
 14a:	90                   	nop
 14b:	90                   	nop
 14c:	90                   	nop
 14d:	90                   	nop
 14e:	90                   	nop
 14f:	90                   	nop

00000150 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 150:	55                   	push   %ebp
 151:	31 d2                	xor    %edx,%edx
 153:	89 e5                	mov    %esp,%ebp
 155:	8b 45 08             	mov    0x8(%ebp),%eax
 158:	53                   	push   %ebx
 159:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 15c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 160:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
 164:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 167:	83 c2 01             	add    $0x1,%edx
 16a:	84 c9                	test   %cl,%cl
 16c:	75 f2                	jne    160 <strcpy+0x10>
    ;
  return os;
}
 16e:	5b                   	pop    %ebx
 16f:	5d                   	pop    %ebp
 170:	c3                   	ret    
 171:	eb 0d                	jmp    180 <strcmp>
 173:	90                   	nop
 174:	90                   	nop
 175:	90                   	nop
 176:	90                   	nop
 177:	90                   	nop
 178:	90                   	nop
 179:	90                   	nop
 17a:	90                   	nop
 17b:	90                   	nop
 17c:	90                   	nop
 17d:	90                   	nop
 17e:	90                   	nop
 17f:	90                   	nop

00000180 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 180:	55                   	push   %ebp
 181:	89 e5                	mov    %esp,%ebp
 183:	8b 4d 08             	mov    0x8(%ebp),%ecx
 186:	53                   	push   %ebx
 187:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(*p && *p == *q)
 18a:	0f b6 01             	movzbl (%ecx),%eax
 18d:	84 c0                	test   %al,%al
 18f:	75 14                	jne    1a5 <strcmp+0x25>
 191:	eb 25                	jmp    1b8 <strcmp+0x38>
 193:	90                   	nop
 194:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    p++, q++;
 198:	83 c1 01             	add    $0x1,%ecx
 19b:	83 c2 01             	add    $0x1,%edx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 19e:	0f b6 01             	movzbl (%ecx),%eax
 1a1:	84 c0                	test   %al,%al
 1a3:	74 13                	je     1b8 <strcmp+0x38>
 1a5:	0f b6 1a             	movzbl (%edx),%ebx
 1a8:	38 d8                	cmp    %bl,%al
 1aa:	74 ec                	je     198 <strcmp+0x18>
 1ac:	0f b6 db             	movzbl %bl,%ebx
 1af:	0f b6 c0             	movzbl %al,%eax
 1b2:	29 d8                	sub    %ebx,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
 1b4:	5b                   	pop    %ebx
 1b5:	5d                   	pop    %ebp
 1b6:	c3                   	ret    
 1b7:	90                   	nop
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 1b8:	0f b6 1a             	movzbl (%edx),%ebx
 1bb:	31 c0                	xor    %eax,%eax
 1bd:	0f b6 db             	movzbl %bl,%ebx
 1c0:	29 d8                	sub    %ebx,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
 1c2:	5b                   	pop    %ebx
 1c3:	5d                   	pop    %ebp
 1c4:	c3                   	ret    
 1c5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 1c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000001d0 <strlen>:

uint
strlen(char *s)
{
 1d0:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
 1d1:	31 d2                	xor    %edx,%edx
  return (uchar)*p - (uchar)*q;
}

uint
strlen(char *s)
{
 1d3:	89 e5                	mov    %esp,%ebp
  int n;

  for(n = 0; s[n]; n++)
 1d5:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
}

uint
strlen(char *s)
{
 1d7:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 1da:	80 39 00             	cmpb   $0x0,(%ecx)
 1dd:	74 0c                	je     1eb <strlen+0x1b>
 1df:	90                   	nop
 1e0:	83 c2 01             	add    $0x1,%edx
 1e3:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 1e7:	89 d0                	mov    %edx,%eax
 1e9:	75 f5                	jne    1e0 <strlen+0x10>
    ;
  return n;
}
 1eb:	5d                   	pop    %ebp
 1ec:	c3                   	ret    
 1ed:	8d 76 00             	lea    0x0(%esi),%esi

000001f0 <memset>:

void*
memset(void *dst, int c, uint n)
{
 1f0:	55                   	push   %ebp
 1f1:	89 e5                	mov    %esp,%ebp
 1f3:	8b 55 08             	mov    0x8(%ebp),%edx
 1f6:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 1f7:	8b 4d 10             	mov    0x10(%ebp),%ecx
 1fa:	8b 45 0c             	mov    0xc(%ebp),%eax
 1fd:	89 d7                	mov    %edx,%edi
 1ff:	fc                   	cld    
 200:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 202:	89 d0                	mov    %edx,%eax
 204:	5f                   	pop    %edi
 205:	5d                   	pop    %ebp
 206:	c3                   	ret    
 207:	89 f6                	mov    %esi,%esi
 209:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000210 <strchr>:

char*
strchr(const char *s, char c)
{
 210:	55                   	push   %ebp
 211:	89 e5                	mov    %esp,%ebp
 213:	8b 45 08             	mov    0x8(%ebp),%eax
 216:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 21a:	0f b6 10             	movzbl (%eax),%edx
 21d:	84 d2                	test   %dl,%dl
 21f:	75 11                	jne    232 <strchr+0x22>
 221:	eb 15                	jmp    238 <strchr+0x28>
 223:	90                   	nop
 224:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 228:	83 c0 01             	add    $0x1,%eax
 22b:	0f b6 10             	movzbl (%eax),%edx
 22e:	84 d2                	test   %dl,%dl
 230:	74 06                	je     238 <strchr+0x28>
    if(*s == c)
 232:	38 ca                	cmp    %cl,%dl
 234:	75 f2                	jne    228 <strchr+0x18>
      return (char*)s;
  return 0;
}
 236:	5d                   	pop    %ebp
 237:	c3                   	ret    
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 238:	31 c0                	xor    %eax,%eax
    if(*s == c)
      return (char*)s;
  return 0;
}
 23a:	5d                   	pop    %ebp
 23b:	90                   	nop
 23c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 240:	c3                   	ret    
 241:	eb 0d                	jmp    250 <atoi>
 243:	90                   	nop
 244:	90                   	nop
 245:	90                   	nop
 246:	90                   	nop
 247:	90                   	nop
 248:	90                   	nop
 249:	90                   	nop
 24a:	90                   	nop
 24b:	90                   	nop
 24c:	90                   	nop
 24d:	90                   	nop
 24e:	90                   	nop
 24f:	90                   	nop

00000250 <atoi>:
  return r;
}

int
atoi(const char *s)
{
 250:	55                   	push   %ebp
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 251:	31 c0                	xor    %eax,%eax
  return r;
}

int
atoi(const char *s)
{
 253:	89 e5                	mov    %esp,%ebp
 255:	8b 4d 08             	mov    0x8(%ebp),%ecx
 258:	53                   	push   %ebx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 259:	0f b6 11             	movzbl (%ecx),%edx
 25c:	8d 5a d0             	lea    -0x30(%edx),%ebx
 25f:	80 fb 09             	cmp    $0x9,%bl
 262:	77 1c                	ja     280 <atoi+0x30>
 264:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    n = n*10 + *s++ - '0';
 268:	0f be d2             	movsbl %dl,%edx
 26b:	83 c1 01             	add    $0x1,%ecx
 26e:	8d 04 80             	lea    (%eax,%eax,4),%eax
 271:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 275:	0f b6 11             	movzbl (%ecx),%edx
 278:	8d 5a d0             	lea    -0x30(%edx),%ebx
 27b:	80 fb 09             	cmp    $0x9,%bl
 27e:	76 e8                	jbe    268 <atoi+0x18>
    n = n*10 + *s++ - '0';
  return n;
}
 280:	5b                   	pop    %ebx
 281:	5d                   	pop    %ebp
 282:	c3                   	ret    
 283:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 289:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000290 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 290:	55                   	push   %ebp
 291:	89 e5                	mov    %esp,%ebp
 293:	56                   	push   %esi
 294:	8b 45 08             	mov    0x8(%ebp),%eax
 297:	53                   	push   %ebx
 298:	8b 5d 10             	mov    0x10(%ebp),%ebx
 29b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 29e:	85 db                	test   %ebx,%ebx
 2a0:	7e 14                	jle    2b6 <memmove+0x26>
    n = n*10 + *s++ - '0';
  return n;
}

void*
memmove(void *vdst, void *vsrc, int n)
 2a2:	31 d2                	xor    %edx,%edx
 2a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    *dst++ = *src++;
 2a8:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 2ac:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 2af:	83 c2 01             	add    $0x1,%edx
{
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 2b2:	39 da                	cmp    %ebx,%edx
 2b4:	75 f2                	jne    2a8 <memmove+0x18>
    *dst++ = *src++;
  return vdst;
}
 2b6:	5b                   	pop    %ebx
 2b7:	5e                   	pop    %esi
 2b8:	5d                   	pop    %ebp
 2b9:	c3                   	ret    
 2ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000002c0 <stat>:
  return buf;
}

int
stat(char *n, struct stat *st)
{
 2c0:	55                   	push   %ebp
 2c1:	89 e5                	mov    %esp,%ebp
 2c3:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 2c6:	8b 45 08             	mov    0x8(%ebp),%eax
  return buf;
}

int
stat(char *n, struct stat *st)
{
 2c9:	89 5d f8             	mov    %ebx,-0x8(%ebp)
 2cc:	89 75 fc             	mov    %esi,-0x4(%ebp)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
 2cf:	be ff ff ff ff       	mov    $0xffffffff,%esi
stat(char *n, struct stat *st)
{
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 2d4:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 2db:	00 
 2dc:	89 04 24             	mov    %eax,(%esp)
 2df:	e8 d4 00 00 00       	call   3b8 <open>
  if(fd < 0)
 2e4:	85 c0                	test   %eax,%eax
stat(char *n, struct stat *st)
{
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 2e6:	89 c3                	mov    %eax,%ebx
  if(fd < 0)
 2e8:	78 19                	js     303 <stat+0x43>
    return -1;
  r = fstat(fd, st);
 2ea:	8b 45 0c             	mov    0xc(%ebp),%eax
 2ed:	89 1c 24             	mov    %ebx,(%esp)
 2f0:	89 44 24 04          	mov    %eax,0x4(%esp)
 2f4:	e8 d7 00 00 00       	call   3d0 <fstat>
  close(fd);
 2f9:	89 1c 24             	mov    %ebx,(%esp)
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
  r = fstat(fd, st);
 2fc:	89 c6                	mov    %eax,%esi
  close(fd);
 2fe:	e8 9d 00 00 00       	call   3a0 <close>
  return r;
}
 303:	89 f0                	mov    %esi,%eax
 305:	8b 5d f8             	mov    -0x8(%ebp),%ebx
 308:	8b 75 fc             	mov    -0x4(%ebp),%esi
 30b:	89 ec                	mov    %ebp,%esp
 30d:	5d                   	pop    %ebp
 30e:	c3                   	ret    
 30f:	90                   	nop

00000310 <gets>:
  return 0;
}

char*
gets(char *buf, int max)
{
 310:	55                   	push   %ebp
 311:	89 e5                	mov    %esp,%ebp
 313:	57                   	push   %edi
 314:	56                   	push   %esi
 315:	31 f6                	xor    %esi,%esi
 317:	53                   	push   %ebx
 318:	83 ec 2c             	sub    $0x2c,%esp
 31b:	8b 7d 08             	mov    0x8(%ebp),%edi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 31e:	eb 06                	jmp    326 <gets+0x16>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 320:	3c 0a                	cmp    $0xa,%al
 322:	74 39                	je     35d <gets+0x4d>
 324:	89 de                	mov    %ebx,%esi
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 326:	8d 5e 01             	lea    0x1(%esi),%ebx
 329:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 32c:	7d 31                	jge    35f <gets+0x4f>
    cc = read(0, &c, 1);
 32e:	8d 45 e7             	lea    -0x19(%ebp),%eax
 331:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 338:	00 
 339:	89 44 24 04          	mov    %eax,0x4(%esp)
 33d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 344:	e8 47 00 00 00       	call   390 <read>
    if(cc < 1)
 349:	85 c0                	test   %eax,%eax
 34b:	7e 12                	jle    35f <gets+0x4f>
      break;
    buf[i++] = c;
 34d:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 351:	88 44 1f ff          	mov    %al,-0x1(%edi,%ebx,1)
    if(c == '\n' || c == '\r')
 355:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 359:	3c 0d                	cmp    $0xd,%al
 35b:	75 c3                	jne    320 <gets+0x10>
 35d:	89 de                	mov    %ebx,%esi
      break;
  }
  buf[i] = '\0';
 35f:	c6 04 37 00          	movb   $0x0,(%edi,%esi,1)
  return buf;
}
 363:	89 f8                	mov    %edi,%eax
 365:	83 c4 2c             	add    $0x2c,%esp
 368:	5b                   	pop    %ebx
 369:	5e                   	pop    %esi
 36a:	5f                   	pop    %edi
 36b:	5d                   	pop    %ebp
 36c:	c3                   	ret    
 36d:	90                   	nop
 36e:	90                   	nop
 36f:	90                   	nop

00000370 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 370:	b8 01 00 00 00       	mov    $0x1,%eax
 375:	cd 40                	int    $0x40
 377:	c3                   	ret    

00000378 <exit>:
SYSCALL(exit)
 378:	b8 02 00 00 00       	mov    $0x2,%eax
 37d:	cd 40                	int    $0x40
 37f:	c3                   	ret    

00000380 <wait>:
SYSCALL(wait)
 380:	b8 03 00 00 00       	mov    $0x3,%eax
 385:	cd 40                	int    $0x40
 387:	c3                   	ret    

00000388 <pipe>:
SYSCALL(pipe)
 388:	b8 04 00 00 00       	mov    $0x4,%eax
 38d:	cd 40                	int    $0x40
 38f:	c3                   	ret    

00000390 <read>:
SYSCALL(read)
 390:	b8 05 00 00 00       	mov    $0x5,%eax
 395:	cd 40                	int    $0x40
 397:	c3                   	ret    

00000398 <write>:
SYSCALL(write)
 398:	b8 10 00 00 00       	mov    $0x10,%eax
 39d:	cd 40                	int    $0x40
 39f:	c3                   	ret    

000003a0 <close>:
SYSCALL(close)
 3a0:	b8 15 00 00 00       	mov    $0x15,%eax
 3a5:	cd 40                	int    $0x40
 3a7:	c3                   	ret    

000003a8 <kill>:
SYSCALL(kill)
 3a8:	b8 06 00 00 00       	mov    $0x6,%eax
 3ad:	cd 40                	int    $0x40
 3af:	c3                   	ret    

000003b0 <exec>:
SYSCALL(exec)
 3b0:	b8 07 00 00 00       	mov    $0x7,%eax
 3b5:	cd 40                	int    $0x40
 3b7:	c3                   	ret    

000003b8 <open>:
SYSCALL(open)
 3b8:	b8 0f 00 00 00       	mov    $0xf,%eax
 3bd:	cd 40                	int    $0x40
 3bf:	c3                   	ret    

000003c0 <mknod>:
SYSCALL(mknod)
 3c0:	b8 11 00 00 00       	mov    $0x11,%eax
 3c5:	cd 40                	int    $0x40
 3c7:	c3                   	ret    

000003c8 <unlink>:
SYSCALL(unlink)
 3c8:	b8 12 00 00 00       	mov    $0x12,%eax
 3cd:	cd 40                	int    $0x40
 3cf:	c3                   	ret    

000003d0 <fstat>:
SYSCALL(fstat)
 3d0:	b8 08 00 00 00       	mov    $0x8,%eax
 3d5:	cd 40                	int    $0x40
 3d7:	c3                   	ret    

000003d8 <link>:
SYSCALL(link)
 3d8:	b8 13 00 00 00       	mov    $0x13,%eax
 3dd:	cd 40                	int    $0x40
 3df:	c3                   	ret    

000003e0 <mkdir>:
SYSCALL(mkdir)
 3e0:	b8 14 00 00 00       	mov    $0x14,%eax
 3e5:	cd 40                	int    $0x40
 3e7:	c3                   	ret    

000003e8 <chdir>:
SYSCALL(chdir)
 3e8:	b8 09 00 00 00       	mov    $0x9,%eax
 3ed:	cd 40                	int    $0x40
 3ef:	c3                   	ret    

000003f0 <dup>:
SYSCALL(dup)
 3f0:	b8 0a 00 00 00       	mov    $0xa,%eax
 3f5:	cd 40                	int    $0x40
 3f7:	c3                   	ret    

000003f8 <getpid>:
SYSCALL(getpid)
 3f8:	b8 0b 00 00 00       	mov    $0xb,%eax
 3fd:	cd 40                	int    $0x40
 3ff:	c3                   	ret    

00000400 <sbrk>:
SYSCALL(sbrk)
 400:	b8 0c 00 00 00       	mov    $0xc,%eax
 405:	cd 40                	int    $0x40
 407:	c3                   	ret    

00000408 <sleep>:
SYSCALL(sleep)
 408:	b8 0d 00 00 00       	mov    $0xd,%eax
 40d:	cd 40                	int    $0x40
 40f:	c3                   	ret    

00000410 <uptime>:
SYSCALL(uptime)
 410:	b8 0e 00 00 00       	mov    $0xe,%eax
 415:	cd 40                	int    $0x40
 417:	c3                   	ret    

00000418 <hello>:
SYSCALL(hello) 			// added for Lab0
 418:	b8 16 00 00 00       	mov    $0x16,%eax
 41d:	cd 40                	int    $0x40
 41f:	c3                   	ret    

00000420 <waitpid>:
SYSCALL(waitpid) 		// lab1 part 1: c
 420:	b8 17 00 00 00       	mov    $0x17,%eax
 425:	cd 40                	int    $0x40
 427:	c3                   	ret    

00000428 <setpriority>:
SYSCALL(setpriority) 	// lab1 part 2: define syscall
 428:	b8 18 00 00 00       	mov    $0x18,%eax
 42d:	cd 40                	int    $0x40
 42f:	c3                   	ret    

00000430 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 430:	55                   	push   %ebp
 431:	89 e5                	mov    %esp,%ebp
 433:	57                   	push   %edi
 434:	89 cf                	mov    %ecx,%edi
 436:	56                   	push   %esi
 437:	89 c6                	mov    %eax,%esi
 439:	53                   	push   %ebx
 43a:	83 ec 4c             	sub    $0x4c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 43d:	8b 4d 08             	mov    0x8(%ebp),%ecx
 440:	85 c9                	test   %ecx,%ecx
 442:	74 04                	je     448 <printint+0x18>
 444:	85 d2                	test   %edx,%edx
 446:	78 68                	js     4b0 <printint+0x80>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 448:	89 d0                	mov    %edx,%eax
 44a:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 451:	31 c9                	xor    %ecx,%ecx
 453:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 456:	66 90                	xchg   %ax,%ax
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
 458:	31 d2                	xor    %edx,%edx
 45a:	f7 f7                	div    %edi
 45c:	0f b6 92 65 08 00 00 	movzbl 0x865(%edx),%edx
 463:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
 466:	83 c1 01             	add    $0x1,%ecx
  }while((x /= base) != 0);
 469:	85 c0                	test   %eax,%eax
 46b:	75 eb                	jne    458 <printint+0x28>
  if(neg)
 46d:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 470:	85 c0                	test   %eax,%eax
 472:	74 08                	je     47c <printint+0x4c>
    buf[i++] = '-';
 474:	c6 44 0d d7 2d       	movb   $0x2d,-0x29(%ebp,%ecx,1)
 479:	83 c1 01             	add    $0x1,%ecx

  while(--i >= 0)
 47c:	8d 79 ff             	lea    -0x1(%ecx),%edi
 47f:	90                   	nop
 480:	0f b6 04 3b          	movzbl (%ebx,%edi,1),%eax
 484:	83 ef 01             	sub    $0x1,%edi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 487:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 48e:	00 
 48f:	89 34 24             	mov    %esi,(%esp)
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 492:	88 45 e7             	mov    %al,-0x19(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 495:	8d 45 e7             	lea    -0x19(%ebp),%eax
 498:	89 44 24 04          	mov    %eax,0x4(%esp)
 49c:	e8 f7 fe ff ff       	call   398 <write>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 4a1:	83 ff ff             	cmp    $0xffffffff,%edi
 4a4:	75 da                	jne    480 <printint+0x50>
    putc(fd, buf[i]);
}
 4a6:	83 c4 4c             	add    $0x4c,%esp
 4a9:	5b                   	pop    %ebx
 4aa:	5e                   	pop    %esi
 4ab:	5f                   	pop    %edi
 4ac:	5d                   	pop    %ebp
 4ad:	c3                   	ret    
 4ae:	66 90                	xchg   %ax,%ax
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 4b0:	89 d0                	mov    %edx,%eax
 4b2:	f7 d8                	neg    %eax
 4b4:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
 4bb:	eb 94                	jmp    451 <printint+0x21>
 4bd:	8d 76 00             	lea    0x0(%esi),%esi

000004c0 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 4c0:	55                   	push   %ebp
 4c1:	89 e5                	mov    %esp,%ebp
 4c3:	57                   	push   %edi
 4c4:	56                   	push   %esi
 4c5:	53                   	push   %ebx
 4c6:	83 ec 3c             	sub    $0x3c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 4c9:	8b 45 0c             	mov    0xc(%ebp),%eax
 4cc:	0f b6 10             	movzbl (%eax),%edx
 4cf:	84 d2                	test   %dl,%dl
 4d1:	0f 84 c1 00 00 00    	je     598 <printf+0xd8>
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
 4d7:	8d 4d 10             	lea    0x10(%ebp),%ecx
 4da:	31 ff                	xor    %edi,%edi
 4dc:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
 4df:	31 db                	xor    %ebx,%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 4e1:	8d 75 e7             	lea    -0x19(%ebp),%esi
 4e4:	eb 1e                	jmp    504 <printf+0x44>
 4e6:	66 90                	xchg   %ax,%ax
  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 4e8:	83 fa 25             	cmp    $0x25,%edx
 4eb:	0f 85 af 00 00 00    	jne    5a0 <printf+0xe0>
 4f1:	66 bf 25 00          	mov    $0x25,%di
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 4f5:	83 c3 01             	add    $0x1,%ebx
 4f8:	0f b6 14 18          	movzbl (%eax,%ebx,1),%edx
 4fc:	84 d2                	test   %dl,%dl
 4fe:	0f 84 94 00 00 00    	je     598 <printf+0xd8>
    c = fmt[i] & 0xff;
    if(state == 0){
 504:	85 ff                	test   %edi,%edi
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
 506:	0f b6 d2             	movzbl %dl,%edx
    if(state == 0){
 509:	74 dd                	je     4e8 <printf+0x28>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 50b:	83 ff 25             	cmp    $0x25,%edi
 50e:	75 e5                	jne    4f5 <printf+0x35>
      if(c == 'd'){
 510:	83 fa 64             	cmp    $0x64,%edx
 513:	0f 84 3f 01 00 00    	je     658 <printf+0x198>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 519:	83 fa 70             	cmp    $0x70,%edx
 51c:	0f 84 a6 00 00 00    	je     5c8 <printf+0x108>
 522:	83 fa 78             	cmp    $0x78,%edx
 525:	0f 84 9d 00 00 00    	je     5c8 <printf+0x108>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 52b:	83 fa 73             	cmp    $0x73,%edx
 52e:	66 90                	xchg   %ax,%ax
 530:	0f 84 ba 00 00 00    	je     5f0 <printf+0x130>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 536:	83 fa 63             	cmp    $0x63,%edx
 539:	0f 84 41 01 00 00    	je     680 <printf+0x1c0>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 53f:	83 fa 25             	cmp    $0x25,%edx
 542:	0f 84 00 01 00 00    	je     648 <printf+0x188>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 548:	8b 4d 08             	mov    0x8(%ebp),%ecx
 54b:	89 55 cc             	mov    %edx,-0x34(%ebp)
 54e:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 552:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 559:	00 
 55a:	89 74 24 04          	mov    %esi,0x4(%esp)
 55e:	89 0c 24             	mov    %ecx,(%esp)
 561:	e8 32 fe ff ff       	call   398 <write>
 566:	8b 55 cc             	mov    -0x34(%ebp),%edx
 569:	88 55 e7             	mov    %dl,-0x19(%ebp)
 56c:	8b 45 08             	mov    0x8(%ebp),%eax
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 56f:	83 c3 01             	add    $0x1,%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 572:	31 ff                	xor    %edi,%edi
 574:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 57b:	00 
 57c:	89 74 24 04          	mov    %esi,0x4(%esp)
 580:	89 04 24             	mov    %eax,(%esp)
 583:	e8 10 fe ff ff       	call   398 <write>
 588:	8b 45 0c             	mov    0xc(%ebp),%eax
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 58b:	0f b6 14 18          	movzbl (%eax,%ebx,1),%edx
 58f:	84 d2                	test   %dl,%dl
 591:	0f 85 6d ff ff ff    	jne    504 <printf+0x44>
 597:	90                   	nop
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 598:	83 c4 3c             	add    $0x3c,%esp
 59b:	5b                   	pop    %ebx
 59c:	5e                   	pop    %esi
 59d:	5f                   	pop    %edi
 59e:	5d                   	pop    %ebp
 59f:	c3                   	ret    
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 5a0:	8b 45 08             	mov    0x8(%ebp),%eax
  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 5a3:	88 55 e7             	mov    %dl,-0x19(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 5a6:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 5ad:	00 
 5ae:	89 74 24 04          	mov    %esi,0x4(%esp)
 5b2:	89 04 24             	mov    %eax,(%esp)
 5b5:	e8 de fd ff ff       	call   398 <write>
 5ba:	8b 45 0c             	mov    0xc(%ebp),%eax
 5bd:	e9 33 ff ff ff       	jmp    4f5 <printf+0x35>
 5c2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 5c8:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 5cb:	b9 10 00 00 00       	mov    $0x10,%ecx
        ap++;
 5d0:	31 ff                	xor    %edi,%edi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 5d2:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 5d9:	8b 10                	mov    (%eax),%edx
 5db:	8b 45 08             	mov    0x8(%ebp),%eax
 5de:	e8 4d fe ff ff       	call   430 <printint>
 5e3:	8b 45 0c             	mov    0xc(%ebp),%eax
        ap++;
 5e6:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
 5ea:	e9 06 ff ff ff       	jmp    4f5 <printf+0x35>
 5ef:	90                   	nop
      } else if(c == 's'){
        s = (char*)*ap;
 5f0:	8b 55 d4             	mov    -0x2c(%ebp),%edx
        ap++;
        if(s == 0)
 5f3:	b9 5e 08 00 00       	mov    $0x85e,%ecx
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
        s = (char*)*ap;
 5f8:	8b 3a                	mov    (%edx),%edi
        ap++;
 5fa:	83 c2 04             	add    $0x4,%edx
 5fd:	89 55 d4             	mov    %edx,-0x2c(%ebp)
        if(s == 0)
 600:	85 ff                	test   %edi,%edi
 602:	0f 44 f9             	cmove  %ecx,%edi
          s = "(null)";
        while(*s != 0){
 605:	0f b6 17             	movzbl (%edi),%edx
 608:	84 d2                	test   %dl,%dl
 60a:	74 33                	je     63f <printf+0x17f>
 60c:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 60f:	8b 5d 08             	mov    0x8(%ebp),%ebx
 612:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
          putc(fd, *s);
          s++;
 618:	83 c7 01             	add    $0x1,%edi
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 61b:	88 55 e7             	mov    %dl,-0x19(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 61e:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 625:	00 
 626:	89 74 24 04          	mov    %esi,0x4(%esp)
 62a:	89 1c 24             	mov    %ebx,(%esp)
 62d:	e8 66 fd ff ff       	call   398 <write>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 632:	0f b6 17             	movzbl (%edi),%edx
 635:	84 d2                	test   %dl,%dl
 637:	75 df                	jne    618 <printf+0x158>
 639:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 63c:	8b 45 0c             	mov    0xc(%ebp),%eax
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 63f:	31 ff                	xor    %edi,%edi
 641:	e9 af fe ff ff       	jmp    4f5 <printf+0x35>
 646:	66 90                	xchg   %ax,%ax
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 648:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 64c:	e9 1b ff ff ff       	jmp    56c <printf+0xac>
 651:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 658:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 65b:	b9 0a 00 00 00       	mov    $0xa,%ecx
        ap++;
 660:	66 31 ff             	xor    %di,%di
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 663:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 66a:	8b 10                	mov    (%eax),%edx
 66c:	8b 45 08             	mov    0x8(%ebp),%eax
 66f:	e8 bc fd ff ff       	call   430 <printint>
 674:	8b 45 0c             	mov    0xc(%ebp),%eax
        ap++;
 677:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
 67b:	e9 75 fe ff ff       	jmp    4f5 <printf+0x35>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 680:	8b 55 d4             	mov    -0x2c(%ebp),%edx
        putc(fd, *ap);
        ap++;
 683:	31 ff                	xor    %edi,%edi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 685:	8b 4d 08             	mov    0x8(%ebp),%ecx
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 688:	8b 02                	mov    (%edx),%eax
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 68a:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 691:	00 
 692:	89 74 24 04          	mov    %esi,0x4(%esp)
 696:	89 0c 24             	mov    %ecx,(%esp)
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 699:	88 45 e7             	mov    %al,-0x19(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 69c:	e8 f7 fc ff ff       	call   398 <write>
 6a1:	8b 45 0c             	mov    0xc(%ebp),%eax
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
        ap++;
 6a4:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
 6a8:	e9 48 fe ff ff       	jmp    4f5 <printf+0x35>
 6ad:	90                   	nop
 6ae:	90                   	nop
 6af:	90                   	nop

000006b0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 6b0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6b1:	a1 88 08 00 00       	mov    0x888,%eax
static Header base;
static Header *freep;

void
free(void *ap)
{
 6b6:	89 e5                	mov    %esp,%ebp
 6b8:	57                   	push   %edi
 6b9:	56                   	push   %esi
 6ba:	53                   	push   %ebx
 6bb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
 6be:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6c1:	39 c8                	cmp    %ecx,%eax
 6c3:	73 1d                	jae    6e2 <free+0x32>
 6c5:	8d 76 00             	lea    0x0(%esi),%esi
 6c8:	8b 10                	mov    (%eax),%edx
 6ca:	39 d1                	cmp    %edx,%ecx
 6cc:	72 1a                	jb     6e8 <free+0x38>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6ce:	39 d0                	cmp    %edx,%eax
 6d0:	72 08                	jb     6da <free+0x2a>
 6d2:	39 c8                	cmp    %ecx,%eax
 6d4:	72 12                	jb     6e8 <free+0x38>
 6d6:	39 d1                	cmp    %edx,%ecx
 6d8:	72 0e                	jb     6e8 <free+0x38>
 6da:	89 d0                	mov    %edx,%eax
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6dc:	39 c8                	cmp    %ecx,%eax
 6de:	66 90                	xchg   %ax,%ax
 6e0:	72 e6                	jb     6c8 <free+0x18>
 6e2:	8b 10                	mov    (%eax),%edx
 6e4:	eb e8                	jmp    6ce <free+0x1e>
 6e6:	66 90                	xchg   %ax,%ax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 6e8:	8b 71 04             	mov    0x4(%ecx),%esi
 6eb:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 6ee:	39 d7                	cmp    %edx,%edi
 6f0:	74 19                	je     70b <free+0x5b>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 6f2:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 6f5:	8b 50 04             	mov    0x4(%eax),%edx
 6f8:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 6fb:	39 ce                	cmp    %ecx,%esi
 6fd:	74 23                	je     722 <free+0x72>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 6ff:	89 08                	mov    %ecx,(%eax)
  freep = p;
 701:	a3 88 08 00 00       	mov    %eax,0x888
}
 706:	5b                   	pop    %ebx
 707:	5e                   	pop    %esi
 708:	5f                   	pop    %edi
 709:	5d                   	pop    %ebp
 70a:	c3                   	ret    
  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 70b:	03 72 04             	add    0x4(%edx),%esi
 70e:	89 71 04             	mov    %esi,0x4(%ecx)
    bp->s.ptr = p->s.ptr->s.ptr;
 711:	8b 10                	mov    (%eax),%edx
 713:	8b 12                	mov    (%edx),%edx
 715:	89 53 f8             	mov    %edx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 718:	8b 50 04             	mov    0x4(%eax),%edx
 71b:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 71e:	39 ce                	cmp    %ecx,%esi
 720:	75 dd                	jne    6ff <free+0x4f>
    p->s.size += bp->s.size;
 722:	03 51 04             	add    0x4(%ecx),%edx
 725:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 728:	8b 53 f8             	mov    -0x8(%ebx),%edx
 72b:	89 10                	mov    %edx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
 72d:	a3 88 08 00 00       	mov    %eax,0x888
}
 732:	5b                   	pop    %ebx
 733:	5e                   	pop    %esi
 734:	5f                   	pop    %edi
 735:	5d                   	pop    %ebp
 736:	c3                   	ret    
 737:	89 f6                	mov    %esi,%esi
 739:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000740 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 740:	55                   	push   %ebp
 741:	89 e5                	mov    %esp,%ebp
 743:	57                   	push   %edi
 744:	56                   	push   %esi
 745:	53                   	push   %ebx
 746:	83 ec 2c             	sub    $0x2c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 749:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if((prevp = freep) == 0){
 74c:	8b 0d 88 08 00 00    	mov    0x888,%ecx
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 752:	83 c3 07             	add    $0x7,%ebx
 755:	c1 eb 03             	shr    $0x3,%ebx
 758:	83 c3 01             	add    $0x1,%ebx
  if((prevp = freep) == 0){
 75b:	85 c9                	test   %ecx,%ecx
 75d:	0f 84 9b 00 00 00    	je     7fe <malloc+0xbe>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 763:	8b 01                	mov    (%ecx),%eax
    if(p->s.size >= nunits){
 765:	8b 50 04             	mov    0x4(%eax),%edx
 768:	39 d3                	cmp    %edx,%ebx
 76a:	76 27                	jbe    793 <malloc+0x53>
        p->s.size -= nunits;
        p += p->s.size;
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
 76c:	8d 3c dd 00 00 00 00 	lea    0x0(,%ebx,8),%edi
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < 4096)
 773:	be 00 80 00 00       	mov    $0x8000,%esi
 778:	89 7d e4             	mov    %edi,-0x1c(%ebp)
 77b:	90                   	nop
 77c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 780:	3b 05 88 08 00 00    	cmp    0x888,%eax
 786:	74 30                	je     7b8 <malloc+0x78>
 788:	89 c1                	mov    %eax,%ecx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 78a:	8b 01                	mov    (%ecx),%eax
    if(p->s.size >= nunits){
 78c:	8b 50 04             	mov    0x4(%eax),%edx
 78f:	39 d3                	cmp    %edx,%ebx
 791:	77 ed                	ja     780 <malloc+0x40>
      if(p->s.size == nunits)
 793:	39 d3                	cmp    %edx,%ebx
 795:	74 61                	je     7f8 <malloc+0xb8>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 797:	29 da                	sub    %ebx,%edx
 799:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 79c:	8d 04 d0             	lea    (%eax,%edx,8),%eax
        p->s.size = nunits;
 79f:	89 58 04             	mov    %ebx,0x4(%eax)
      }
      freep = prevp;
 7a2:	89 0d 88 08 00 00    	mov    %ecx,0x888
      return (void*)(p + 1);
 7a8:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 7ab:	83 c4 2c             	add    $0x2c,%esp
 7ae:	5b                   	pop    %ebx
 7af:	5e                   	pop    %esi
 7b0:	5f                   	pop    %edi
 7b1:	5d                   	pop    %ebp
 7b2:	c3                   	ret    
 7b3:	90                   	nop
 7b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < 4096)
 7b8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 7bb:	81 fb 00 10 00 00    	cmp    $0x1000,%ebx
 7c1:	bf 00 10 00 00       	mov    $0x1000,%edi
 7c6:	0f 43 fb             	cmovae %ebx,%edi
 7c9:	0f 42 c6             	cmovb  %esi,%eax
    nu = 4096;
  p = sbrk(nu * sizeof(Header));
 7cc:	89 04 24             	mov    %eax,(%esp)
 7cf:	e8 2c fc ff ff       	call   400 <sbrk>
  if(p == (char*)-1)
 7d4:	83 f8 ff             	cmp    $0xffffffff,%eax
 7d7:	74 18                	je     7f1 <malloc+0xb1>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
 7d9:	89 78 04             	mov    %edi,0x4(%eax)
  free((void*)(hp + 1));
 7dc:	83 c0 08             	add    $0x8,%eax
 7df:	89 04 24             	mov    %eax,(%esp)
 7e2:	e8 c9 fe ff ff       	call   6b0 <free>
  return freep;
 7e7:	8b 0d 88 08 00 00    	mov    0x888,%ecx
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
 7ed:	85 c9                	test   %ecx,%ecx
 7ef:	75 99                	jne    78a <malloc+0x4a>
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 7f1:	31 c0                	xor    %eax,%eax
 7f3:	eb b6                	jmp    7ab <malloc+0x6b>
 7f5:	8d 76 00             	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
 7f8:	8b 10                	mov    (%eax),%edx
 7fa:	89 11                	mov    %edx,(%ecx)
 7fc:	eb a4                	jmp    7a2 <malloc+0x62>
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 7fe:	c7 05 88 08 00 00 80 	movl   $0x880,0x888
 805:	08 00 00 
    base.s.size = 0;
 808:	b9 80 08 00 00       	mov    $0x880,%ecx
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 80d:	c7 05 80 08 00 00 80 	movl   $0x880,0x880
 814:	08 00 00 
    base.s.size = 0;
 817:	c7 05 84 08 00 00 00 	movl   $0x0,0x884
 81e:	00 00 00 
 821:	e9 3d ff ff ff       	jmp    763 <malloc+0x23>
