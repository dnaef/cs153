
_zombie:     file format elf32-i386


Disassembly of section .text:

00001000 <main>:
#include "stat.h"
#include "user.h"

int
main(void)
{
    1000:	55                   	push   %ebp
    1001:	89 e5                	mov    %esp,%ebp
    1003:	83 e4 f0             	and    $0xfffffff0,%esp
    1006:	83 ec 10             	sub    $0x10,%esp
  if(fork() > 0)
    1009:	e8 42 02 00 00       	call   1250 <fork>
    100e:	85 c0                	test   %eax,%eax
    1010:	7e 0c                	jle    101e <main+0x1e>
    sleep(5);  // Let child exit before parent.
    1012:	c7 04 24 05 00 00 00 	movl   $0x5,(%esp)
    1019:	e8 ca 02 00 00       	call   12e8 <sleep>
  exit(0);
    101e:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1025:	e8 2e 02 00 00       	call   1258 <exit>
    102a:	90                   	nop
    102b:	90                   	nop
    102c:	90                   	nop
    102d:	90                   	nop
    102e:	90                   	nop
    102f:	90                   	nop

00001030 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
    1030:	55                   	push   %ebp
    1031:	31 d2                	xor    %edx,%edx
    1033:	89 e5                	mov    %esp,%ebp
    1035:	8b 45 08             	mov    0x8(%ebp),%eax
    1038:	53                   	push   %ebx
    1039:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    103c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
    1040:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
    1044:	88 0c 10             	mov    %cl,(%eax,%edx,1)
    1047:	83 c2 01             	add    $0x1,%edx
    104a:	84 c9                	test   %cl,%cl
    104c:	75 f2                	jne    1040 <strcpy+0x10>
    ;
  return os;
}
    104e:	5b                   	pop    %ebx
    104f:	5d                   	pop    %ebp
    1050:	c3                   	ret    
    1051:	eb 0d                	jmp    1060 <strcmp>
    1053:	90                   	nop
    1054:	90                   	nop
    1055:	90                   	nop
    1056:	90                   	nop
    1057:	90                   	nop
    1058:	90                   	nop
    1059:	90                   	nop
    105a:	90                   	nop
    105b:	90                   	nop
    105c:	90                   	nop
    105d:	90                   	nop
    105e:	90                   	nop
    105f:	90                   	nop

00001060 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    1060:	55                   	push   %ebp
    1061:	89 e5                	mov    %esp,%ebp
    1063:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1066:	53                   	push   %ebx
    1067:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(*p && *p == *q)
    106a:	0f b6 01             	movzbl (%ecx),%eax
    106d:	84 c0                	test   %al,%al
    106f:	75 14                	jne    1085 <strcmp+0x25>
    1071:	eb 25                	jmp    1098 <strcmp+0x38>
    1073:	90                   	nop
    1074:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    p++, q++;
    1078:	83 c1 01             	add    $0x1,%ecx
    107b:	83 c2 01             	add    $0x1,%edx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
    107e:	0f b6 01             	movzbl (%ecx),%eax
    1081:	84 c0                	test   %al,%al
    1083:	74 13                	je     1098 <strcmp+0x38>
    1085:	0f b6 1a             	movzbl (%edx),%ebx
    1088:	38 d8                	cmp    %bl,%al
    108a:	74 ec                	je     1078 <strcmp+0x18>
    108c:	0f b6 db             	movzbl %bl,%ebx
    108f:	0f b6 c0             	movzbl %al,%eax
    1092:	29 d8                	sub    %ebx,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
    1094:	5b                   	pop    %ebx
    1095:	5d                   	pop    %ebp
    1096:	c3                   	ret    
    1097:	90                   	nop
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
    1098:	0f b6 1a             	movzbl (%edx),%ebx
    109b:	31 c0                	xor    %eax,%eax
    109d:	0f b6 db             	movzbl %bl,%ebx
    10a0:	29 d8                	sub    %ebx,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
    10a2:	5b                   	pop    %ebx
    10a3:	5d                   	pop    %ebp
    10a4:	c3                   	ret    
    10a5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    10a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000010b0 <strlen>:

uint
strlen(char *s)
{
    10b0:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
    10b1:	31 d2                	xor    %edx,%edx
  return (uchar)*p - (uchar)*q;
}

uint
strlen(char *s)
{
    10b3:	89 e5                	mov    %esp,%ebp
  int n;

  for(n = 0; s[n]; n++)
    10b5:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
}

uint
strlen(char *s)
{
    10b7:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
    10ba:	80 39 00             	cmpb   $0x0,(%ecx)
    10bd:	74 0c                	je     10cb <strlen+0x1b>
    10bf:	90                   	nop
    10c0:	83 c2 01             	add    $0x1,%edx
    10c3:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
    10c7:	89 d0                	mov    %edx,%eax
    10c9:	75 f5                	jne    10c0 <strlen+0x10>
    ;
  return n;
}
    10cb:	5d                   	pop    %ebp
    10cc:	c3                   	ret    
    10cd:	8d 76 00             	lea    0x0(%esi),%esi

000010d0 <memset>:

void*
memset(void *dst, int c, uint n)
{
    10d0:	55                   	push   %ebp
    10d1:	89 e5                	mov    %esp,%ebp
    10d3:	8b 55 08             	mov    0x8(%ebp),%edx
    10d6:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
    10d7:	8b 4d 10             	mov    0x10(%ebp),%ecx
    10da:	8b 45 0c             	mov    0xc(%ebp),%eax
    10dd:	89 d7                	mov    %edx,%edi
    10df:	fc                   	cld    
    10e0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
    10e2:	89 d0                	mov    %edx,%eax
    10e4:	5f                   	pop    %edi
    10e5:	5d                   	pop    %ebp
    10e6:	c3                   	ret    
    10e7:	89 f6                	mov    %esi,%esi
    10e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000010f0 <strchr>:

char*
strchr(const char *s, char c)
{
    10f0:	55                   	push   %ebp
    10f1:	89 e5                	mov    %esp,%ebp
    10f3:	8b 45 08             	mov    0x8(%ebp),%eax
    10f6:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
    10fa:	0f b6 10             	movzbl (%eax),%edx
    10fd:	84 d2                	test   %dl,%dl
    10ff:	75 11                	jne    1112 <strchr+0x22>
    1101:	eb 15                	jmp    1118 <strchr+0x28>
    1103:	90                   	nop
    1104:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1108:	83 c0 01             	add    $0x1,%eax
    110b:	0f b6 10             	movzbl (%eax),%edx
    110e:	84 d2                	test   %dl,%dl
    1110:	74 06                	je     1118 <strchr+0x28>
    if(*s == c)
    1112:	38 ca                	cmp    %cl,%dl
    1114:	75 f2                	jne    1108 <strchr+0x18>
      return (char*)s;
  return 0;
}
    1116:	5d                   	pop    %ebp
    1117:	c3                   	ret    
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
    1118:	31 c0                	xor    %eax,%eax
    if(*s == c)
      return (char*)s;
  return 0;
}
    111a:	5d                   	pop    %ebp
    111b:	90                   	nop
    111c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1120:	c3                   	ret    
    1121:	eb 0d                	jmp    1130 <atoi>
    1123:	90                   	nop
    1124:	90                   	nop
    1125:	90                   	nop
    1126:	90                   	nop
    1127:	90                   	nop
    1128:	90                   	nop
    1129:	90                   	nop
    112a:	90                   	nop
    112b:	90                   	nop
    112c:	90                   	nop
    112d:	90                   	nop
    112e:	90                   	nop
    112f:	90                   	nop

00001130 <atoi>:
  return r;
}

int
atoi(const char *s)
{
    1130:	55                   	push   %ebp
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    1131:	31 c0                	xor    %eax,%eax
  return r;
}

int
atoi(const char *s)
{
    1133:	89 e5                	mov    %esp,%ebp
    1135:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1138:	53                   	push   %ebx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    1139:	0f b6 11             	movzbl (%ecx),%edx
    113c:	8d 5a d0             	lea    -0x30(%edx),%ebx
    113f:	80 fb 09             	cmp    $0x9,%bl
    1142:	77 1c                	ja     1160 <atoi+0x30>
    1144:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    n = n*10 + *s++ - '0';
    1148:	0f be d2             	movsbl %dl,%edx
    114b:	83 c1 01             	add    $0x1,%ecx
    114e:	8d 04 80             	lea    (%eax,%eax,4),%eax
    1151:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    1155:	0f b6 11             	movzbl (%ecx),%edx
    1158:	8d 5a d0             	lea    -0x30(%edx),%ebx
    115b:	80 fb 09             	cmp    $0x9,%bl
    115e:	76 e8                	jbe    1148 <atoi+0x18>
    n = n*10 + *s++ - '0';
  return n;
}
    1160:	5b                   	pop    %ebx
    1161:	5d                   	pop    %ebp
    1162:	c3                   	ret    
    1163:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    1169:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001170 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
    1170:	55                   	push   %ebp
    1171:	89 e5                	mov    %esp,%ebp
    1173:	56                   	push   %esi
    1174:	8b 45 08             	mov    0x8(%ebp),%eax
    1177:	53                   	push   %ebx
    1178:	8b 5d 10             	mov    0x10(%ebp),%ebx
    117b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    117e:	85 db                	test   %ebx,%ebx
    1180:	7e 14                	jle    1196 <memmove+0x26>
    n = n*10 + *s++ - '0';
  return n;
}

void*
memmove(void *vdst, void *vsrc, int n)
    1182:	31 d2                	xor    %edx,%edx
    1184:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    *dst++ = *src++;
    1188:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
    118c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
    118f:	83 c2 01             	add    $0x1,%edx
{
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    1192:	39 da                	cmp    %ebx,%edx
    1194:	75 f2                	jne    1188 <memmove+0x18>
    *dst++ = *src++;
  return vdst;
}
    1196:	5b                   	pop    %ebx
    1197:	5e                   	pop    %esi
    1198:	5d                   	pop    %ebp
    1199:	c3                   	ret    
    119a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000011a0 <stat>:
  return buf;
}

int
stat(char *n, struct stat *st)
{
    11a0:	55                   	push   %ebp
    11a1:	89 e5                	mov    %esp,%ebp
    11a3:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    11a6:	8b 45 08             	mov    0x8(%ebp),%eax
  return buf;
}

int
stat(char *n, struct stat *st)
{
    11a9:	89 5d f8             	mov    %ebx,-0x8(%ebp)
    11ac:	89 75 fc             	mov    %esi,-0x4(%ebp)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    11af:	be ff ff ff ff       	mov    $0xffffffff,%esi
stat(char *n, struct stat *st)
{
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    11b4:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    11bb:	00 
    11bc:	89 04 24             	mov    %eax,(%esp)
    11bf:	e8 d4 00 00 00       	call   1298 <open>
  if(fd < 0)
    11c4:	85 c0                	test   %eax,%eax
stat(char *n, struct stat *st)
{
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    11c6:	89 c3                	mov    %eax,%ebx
  if(fd < 0)
    11c8:	78 19                	js     11e3 <stat+0x43>
    return -1;
  r = fstat(fd, st);
    11ca:	8b 45 0c             	mov    0xc(%ebp),%eax
    11cd:	89 1c 24             	mov    %ebx,(%esp)
    11d0:	89 44 24 04          	mov    %eax,0x4(%esp)
    11d4:	e8 d7 00 00 00       	call   12b0 <fstat>
  close(fd);
    11d9:	89 1c 24             	mov    %ebx,(%esp)
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
  r = fstat(fd, st);
    11dc:	89 c6                	mov    %eax,%esi
  close(fd);
    11de:	e8 9d 00 00 00       	call   1280 <close>
  return r;
}
    11e3:	89 f0                	mov    %esi,%eax
    11e5:	8b 5d f8             	mov    -0x8(%ebp),%ebx
    11e8:	8b 75 fc             	mov    -0x4(%ebp),%esi
    11eb:	89 ec                	mov    %ebp,%esp
    11ed:	5d                   	pop    %ebp
    11ee:	c3                   	ret    
    11ef:	90                   	nop

000011f0 <gets>:
  return 0;
}

char*
gets(char *buf, int max)
{
    11f0:	55                   	push   %ebp
    11f1:	89 e5                	mov    %esp,%ebp
    11f3:	57                   	push   %edi
    11f4:	56                   	push   %esi
    11f5:	31 f6                	xor    %esi,%esi
    11f7:	53                   	push   %ebx
    11f8:	83 ec 2c             	sub    $0x2c,%esp
    11fb:	8b 7d 08             	mov    0x8(%ebp),%edi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    11fe:	eb 06                	jmp    1206 <gets+0x16>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
    1200:	3c 0a                	cmp    $0xa,%al
    1202:	74 39                	je     123d <gets+0x4d>
    1204:	89 de                	mov    %ebx,%esi
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    1206:	8d 5e 01             	lea    0x1(%esi),%ebx
    1209:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
    120c:	7d 31                	jge    123f <gets+0x4f>
    cc = read(0, &c, 1);
    120e:	8d 45 e7             	lea    -0x19(%ebp),%eax
    1211:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    1218:	00 
    1219:	89 44 24 04          	mov    %eax,0x4(%esp)
    121d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1224:	e8 47 00 00 00       	call   1270 <read>
    if(cc < 1)
    1229:	85 c0                	test   %eax,%eax
    122b:	7e 12                	jle    123f <gets+0x4f>
      break;
    buf[i++] = c;
    122d:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
    1231:	88 44 1f ff          	mov    %al,-0x1(%edi,%ebx,1)
    if(c == '\n' || c == '\r')
    1235:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
    1239:	3c 0d                	cmp    $0xd,%al
    123b:	75 c3                	jne    1200 <gets+0x10>
    123d:	89 de                	mov    %ebx,%esi
      break;
  }
  buf[i] = '\0';
    123f:	c6 04 37 00          	movb   $0x0,(%edi,%esi,1)
  return buf;
}
    1243:	89 f8                	mov    %edi,%eax
    1245:	83 c4 2c             	add    $0x2c,%esp
    1248:	5b                   	pop    %ebx
    1249:	5e                   	pop    %esi
    124a:	5f                   	pop    %edi
    124b:	5d                   	pop    %ebp
    124c:	c3                   	ret    
    124d:	90                   	nop
    124e:	90                   	nop
    124f:	90                   	nop

00001250 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    1250:	b8 01 00 00 00       	mov    $0x1,%eax
    1255:	cd 40                	int    $0x40
    1257:	c3                   	ret    

00001258 <exit>:
SYSCALL(exit)
    1258:	b8 02 00 00 00       	mov    $0x2,%eax
    125d:	cd 40                	int    $0x40
    125f:	c3                   	ret    

00001260 <wait>:
SYSCALL(wait)
    1260:	b8 03 00 00 00       	mov    $0x3,%eax
    1265:	cd 40                	int    $0x40
    1267:	c3                   	ret    

00001268 <pipe>:
SYSCALL(pipe)
    1268:	b8 04 00 00 00       	mov    $0x4,%eax
    126d:	cd 40                	int    $0x40
    126f:	c3                   	ret    

00001270 <read>:
SYSCALL(read)
    1270:	b8 05 00 00 00       	mov    $0x5,%eax
    1275:	cd 40                	int    $0x40
    1277:	c3                   	ret    

00001278 <write>:
SYSCALL(write)
    1278:	b8 10 00 00 00       	mov    $0x10,%eax
    127d:	cd 40                	int    $0x40
    127f:	c3                   	ret    

00001280 <close>:
SYSCALL(close)
    1280:	b8 15 00 00 00       	mov    $0x15,%eax
    1285:	cd 40                	int    $0x40
    1287:	c3                   	ret    

00001288 <kill>:
SYSCALL(kill)
    1288:	b8 06 00 00 00       	mov    $0x6,%eax
    128d:	cd 40                	int    $0x40
    128f:	c3                   	ret    

00001290 <exec>:
SYSCALL(exec)
    1290:	b8 07 00 00 00       	mov    $0x7,%eax
    1295:	cd 40                	int    $0x40
    1297:	c3                   	ret    

00001298 <open>:
SYSCALL(open)
    1298:	b8 0f 00 00 00       	mov    $0xf,%eax
    129d:	cd 40                	int    $0x40
    129f:	c3                   	ret    

000012a0 <mknod>:
SYSCALL(mknod)
    12a0:	b8 11 00 00 00       	mov    $0x11,%eax
    12a5:	cd 40                	int    $0x40
    12a7:	c3                   	ret    

000012a8 <unlink>:
SYSCALL(unlink)
    12a8:	b8 12 00 00 00       	mov    $0x12,%eax
    12ad:	cd 40                	int    $0x40
    12af:	c3                   	ret    

000012b0 <fstat>:
SYSCALL(fstat)
    12b0:	b8 08 00 00 00       	mov    $0x8,%eax
    12b5:	cd 40                	int    $0x40
    12b7:	c3                   	ret    

000012b8 <link>:
SYSCALL(link)
    12b8:	b8 13 00 00 00       	mov    $0x13,%eax
    12bd:	cd 40                	int    $0x40
    12bf:	c3                   	ret    

000012c0 <mkdir>:
SYSCALL(mkdir)
    12c0:	b8 14 00 00 00       	mov    $0x14,%eax
    12c5:	cd 40                	int    $0x40
    12c7:	c3                   	ret    

000012c8 <chdir>:
SYSCALL(chdir)
    12c8:	b8 09 00 00 00       	mov    $0x9,%eax
    12cd:	cd 40                	int    $0x40
    12cf:	c3                   	ret    

000012d0 <dup>:
SYSCALL(dup)
    12d0:	b8 0a 00 00 00       	mov    $0xa,%eax
    12d5:	cd 40                	int    $0x40
    12d7:	c3                   	ret    

000012d8 <getpid>:
SYSCALL(getpid)
    12d8:	b8 0b 00 00 00       	mov    $0xb,%eax
    12dd:	cd 40                	int    $0x40
    12df:	c3                   	ret    

000012e0 <sbrk>:
SYSCALL(sbrk)
    12e0:	b8 0c 00 00 00       	mov    $0xc,%eax
    12e5:	cd 40                	int    $0x40
    12e7:	c3                   	ret    

000012e8 <sleep>:
SYSCALL(sleep)
    12e8:	b8 0d 00 00 00       	mov    $0xd,%eax
    12ed:	cd 40                	int    $0x40
    12ef:	c3                   	ret    

000012f0 <uptime>:
SYSCALL(uptime)
    12f0:	b8 0e 00 00 00       	mov    $0xe,%eax
    12f5:	cd 40                	int    $0x40
    12f7:	c3                   	ret    

000012f8 <hello>:
SYSCALL(hello) 			// added for Lab0
    12f8:	b8 16 00 00 00       	mov    $0x16,%eax
    12fd:	cd 40                	int    $0x40
    12ff:	c3                   	ret    

00001300 <waitpid>:
SYSCALL(waitpid) 		// lab1 part 1: c
    1300:	b8 17 00 00 00       	mov    $0x17,%eax
    1305:	cd 40                	int    $0x40
    1307:	c3                   	ret    

00001308 <setpriority>:
SYSCALL(setpriority) 	// lab1 part 2: define syscall
    1308:	b8 18 00 00 00       	mov    $0x18,%eax
    130d:	cd 40                	int    $0x40
    130f:	c3                   	ret    

00001310 <v2p>:
SYSCALL(v2p)			// lab2
    1310:	b8 19 00 00 00       	mov    $0x19,%eax
    1315:	cd 40                	int    $0x40
    1317:	c3                   	ret    
    1318:	90                   	nop
    1319:	90                   	nop
    131a:	90                   	nop
    131b:	90                   	nop
    131c:	90                   	nop
    131d:	90                   	nop
    131e:	90                   	nop
    131f:	90                   	nop

00001320 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
    1320:	55                   	push   %ebp
    1321:	89 e5                	mov    %esp,%ebp
    1323:	57                   	push   %edi
    1324:	89 cf                	mov    %ecx,%edi
    1326:	56                   	push   %esi
    1327:	89 c6                	mov    %eax,%esi
    1329:	53                   	push   %ebx
    132a:	83 ec 4c             	sub    $0x4c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    132d:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1330:	85 c9                	test   %ecx,%ecx
    1332:	74 04                	je     1338 <printint+0x18>
    1334:	85 d2                	test   %edx,%edx
    1336:	78 68                	js     13a0 <printint+0x80>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
    1338:	89 d0                	mov    %edx,%eax
    133a:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
    1341:	31 c9                	xor    %ecx,%ecx
    1343:	8d 5d d7             	lea    -0x29(%ebp),%ebx
    1346:	66 90                	xchg   %ax,%ax
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
    1348:	31 d2                	xor    %edx,%edx
    134a:	f7 f7                	div    %edi
    134c:	0f b6 92 1d 17 00 00 	movzbl 0x171d(%edx),%edx
    1353:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
    1356:	83 c1 01             	add    $0x1,%ecx
  }while((x /= base) != 0);
    1359:	85 c0                	test   %eax,%eax
    135b:	75 eb                	jne    1348 <printint+0x28>
  if(neg)
    135d:	8b 45 c4             	mov    -0x3c(%ebp),%eax
    1360:	85 c0                	test   %eax,%eax
    1362:	74 08                	je     136c <printint+0x4c>
    buf[i++] = '-';
    1364:	c6 44 0d d7 2d       	movb   $0x2d,-0x29(%ebp,%ecx,1)
    1369:	83 c1 01             	add    $0x1,%ecx

  while(--i >= 0)
    136c:	8d 79 ff             	lea    -0x1(%ecx),%edi
    136f:	90                   	nop
    1370:	0f b6 04 3b          	movzbl (%ebx,%edi,1),%eax
    1374:	83 ef 01             	sub    $0x1,%edi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    1377:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    137e:	00 
    137f:	89 34 24             	mov    %esi,(%esp)
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
    1382:	88 45 e7             	mov    %al,-0x19(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    1385:	8d 45 e7             	lea    -0x19(%ebp),%eax
    1388:	89 44 24 04          	mov    %eax,0x4(%esp)
    138c:	e8 e7 fe ff ff       	call   1278 <write>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
    1391:	83 ff ff             	cmp    $0xffffffff,%edi
    1394:	75 da                	jne    1370 <printint+0x50>
    putc(fd, buf[i]);
}
    1396:	83 c4 4c             	add    $0x4c,%esp
    1399:	5b                   	pop    %ebx
    139a:	5e                   	pop    %esi
    139b:	5f                   	pop    %edi
    139c:	5d                   	pop    %ebp
    139d:	c3                   	ret    
    139e:	66 90                	xchg   %ax,%ax
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
    13a0:	89 d0                	mov    %edx,%eax
    13a2:	f7 d8                	neg    %eax
    13a4:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
    13ab:	eb 94                	jmp    1341 <printint+0x21>
    13ad:	8d 76 00             	lea    0x0(%esi),%esi

000013b0 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
    13b0:	55                   	push   %ebp
    13b1:	89 e5                	mov    %esp,%ebp
    13b3:	57                   	push   %edi
    13b4:	56                   	push   %esi
    13b5:	53                   	push   %ebx
    13b6:	83 ec 3c             	sub    $0x3c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    13b9:	8b 45 0c             	mov    0xc(%ebp),%eax
    13bc:	0f b6 10             	movzbl (%eax),%edx
    13bf:	84 d2                	test   %dl,%dl
    13c1:	0f 84 c1 00 00 00    	je     1488 <printf+0xd8>
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
    13c7:	8d 4d 10             	lea    0x10(%ebp),%ecx
    13ca:	31 ff                	xor    %edi,%edi
    13cc:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
    13cf:	31 db                	xor    %ebx,%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    13d1:	8d 75 e7             	lea    -0x19(%ebp),%esi
    13d4:	eb 1e                	jmp    13f4 <printf+0x44>
    13d6:	66 90                	xchg   %ax,%ax
  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
    13d8:	83 fa 25             	cmp    $0x25,%edx
    13db:	0f 85 af 00 00 00    	jne    1490 <printf+0xe0>
    13e1:	66 bf 25 00          	mov    $0x25,%di
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    13e5:	83 c3 01             	add    $0x1,%ebx
    13e8:	0f b6 14 18          	movzbl (%eax,%ebx,1),%edx
    13ec:	84 d2                	test   %dl,%dl
    13ee:	0f 84 94 00 00 00    	je     1488 <printf+0xd8>
    c = fmt[i] & 0xff;
    if(state == 0){
    13f4:	85 ff                	test   %edi,%edi
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    13f6:	0f b6 d2             	movzbl %dl,%edx
    if(state == 0){
    13f9:	74 dd                	je     13d8 <printf+0x28>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
    13fb:	83 ff 25             	cmp    $0x25,%edi
    13fe:	75 e5                	jne    13e5 <printf+0x35>
      if(c == 'd'){
    1400:	83 fa 64             	cmp    $0x64,%edx
    1403:	0f 84 3f 01 00 00    	je     1548 <printf+0x198>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
    1409:	83 fa 70             	cmp    $0x70,%edx
    140c:	0f 84 a6 00 00 00    	je     14b8 <printf+0x108>
    1412:	83 fa 78             	cmp    $0x78,%edx
    1415:	0f 84 9d 00 00 00    	je     14b8 <printf+0x108>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
    141b:	83 fa 73             	cmp    $0x73,%edx
    141e:	66 90                	xchg   %ax,%ax
    1420:	0f 84 ba 00 00 00    	je     14e0 <printf+0x130>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    1426:	83 fa 63             	cmp    $0x63,%edx
    1429:	0f 84 41 01 00 00    	je     1570 <printf+0x1c0>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
    142f:	83 fa 25             	cmp    $0x25,%edx
    1432:	0f 84 00 01 00 00    	je     1538 <printf+0x188>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    1438:	8b 4d 08             	mov    0x8(%ebp),%ecx
    143b:	89 55 cc             	mov    %edx,-0x34(%ebp)
    143e:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
    1442:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    1449:	00 
    144a:	89 74 24 04          	mov    %esi,0x4(%esp)
    144e:	89 0c 24             	mov    %ecx,(%esp)
    1451:	e8 22 fe ff ff       	call   1278 <write>
    1456:	8b 55 cc             	mov    -0x34(%ebp),%edx
    1459:	88 55 e7             	mov    %dl,-0x19(%ebp)
    145c:	8b 45 08             	mov    0x8(%ebp),%eax
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    145f:	83 c3 01             	add    $0x1,%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    1462:	31 ff                	xor    %edi,%edi
    1464:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    146b:	00 
    146c:	89 74 24 04          	mov    %esi,0x4(%esp)
    1470:	89 04 24             	mov    %eax,(%esp)
    1473:	e8 00 fe ff ff       	call   1278 <write>
    1478:	8b 45 0c             	mov    0xc(%ebp),%eax
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    147b:	0f b6 14 18          	movzbl (%eax,%ebx,1),%edx
    147f:	84 d2                	test   %dl,%dl
    1481:	0f 85 6d ff ff ff    	jne    13f4 <printf+0x44>
    1487:	90                   	nop
        putc(fd, c);
      }
      state = 0;
    }
  }
}
    1488:	83 c4 3c             	add    $0x3c,%esp
    148b:	5b                   	pop    %ebx
    148c:	5e                   	pop    %esi
    148d:	5f                   	pop    %edi
    148e:	5d                   	pop    %ebp
    148f:	c3                   	ret    
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    1490:	8b 45 08             	mov    0x8(%ebp),%eax
  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
    1493:	88 55 e7             	mov    %dl,-0x19(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    1496:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    149d:	00 
    149e:	89 74 24 04          	mov    %esi,0x4(%esp)
    14a2:	89 04 24             	mov    %eax,(%esp)
    14a5:	e8 ce fd ff ff       	call   1278 <write>
    14aa:	8b 45 0c             	mov    0xc(%ebp),%eax
    14ad:	e9 33 ff ff ff       	jmp    13e5 <printf+0x35>
    14b2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
    14b8:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    14bb:	b9 10 00 00 00       	mov    $0x10,%ecx
        ap++;
    14c0:	31 ff                	xor    %edi,%edi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
    14c2:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    14c9:	8b 10                	mov    (%eax),%edx
    14cb:	8b 45 08             	mov    0x8(%ebp),%eax
    14ce:	e8 4d fe ff ff       	call   1320 <printint>
    14d3:	8b 45 0c             	mov    0xc(%ebp),%eax
        ap++;
    14d6:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
    14da:	e9 06 ff ff ff       	jmp    13e5 <printf+0x35>
    14df:	90                   	nop
      } else if(c == 's'){
        s = (char*)*ap;
    14e0:	8b 55 d4             	mov    -0x2c(%ebp),%edx
        ap++;
        if(s == 0)
    14e3:	b9 16 17 00 00       	mov    $0x1716,%ecx
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
        s = (char*)*ap;
    14e8:	8b 3a                	mov    (%edx),%edi
        ap++;
    14ea:	83 c2 04             	add    $0x4,%edx
    14ed:	89 55 d4             	mov    %edx,-0x2c(%ebp)
        if(s == 0)
    14f0:	85 ff                	test   %edi,%edi
    14f2:	0f 44 f9             	cmove  %ecx,%edi
          s = "(null)";
        while(*s != 0){
    14f5:	0f b6 17             	movzbl (%edi),%edx
    14f8:	84 d2                	test   %dl,%dl
    14fa:	74 33                	je     152f <printf+0x17f>
    14fc:	89 5d d0             	mov    %ebx,-0x30(%ebp)
    14ff:	8b 5d 08             	mov    0x8(%ebp),%ebx
    1502:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
          putc(fd, *s);
          s++;
    1508:	83 c7 01             	add    $0x1,%edi
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
    150b:	88 55 e7             	mov    %dl,-0x19(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    150e:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    1515:	00 
    1516:	89 74 24 04          	mov    %esi,0x4(%esp)
    151a:	89 1c 24             	mov    %ebx,(%esp)
    151d:	e8 56 fd ff ff       	call   1278 <write>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
    1522:	0f b6 17             	movzbl (%edi),%edx
    1525:	84 d2                	test   %dl,%dl
    1527:	75 df                	jne    1508 <printf+0x158>
    1529:	8b 5d d0             	mov    -0x30(%ebp),%ebx
    152c:	8b 45 0c             	mov    0xc(%ebp),%eax
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    152f:	31 ff                	xor    %edi,%edi
    1531:	e9 af fe ff ff       	jmp    13e5 <printf+0x35>
    1536:	66 90                	xchg   %ax,%ax
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
    1538:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
    153c:	e9 1b ff ff ff       	jmp    145c <printf+0xac>
    1541:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
    1548:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    154b:	b9 0a 00 00 00       	mov    $0xa,%ecx
        ap++;
    1550:	66 31 ff             	xor    %di,%di
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
    1553:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    155a:	8b 10                	mov    (%eax),%edx
    155c:	8b 45 08             	mov    0x8(%ebp),%eax
    155f:	e8 bc fd ff ff       	call   1320 <printint>
    1564:	8b 45 0c             	mov    0xc(%ebp),%eax
        ap++;
    1567:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
    156b:	e9 75 fe ff ff       	jmp    13e5 <printf+0x35>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    1570:	8b 55 d4             	mov    -0x2c(%ebp),%edx
        putc(fd, *ap);
        ap++;
    1573:	31 ff                	xor    %edi,%edi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    1575:	8b 4d 08             	mov    0x8(%ebp),%ecx
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    1578:	8b 02                	mov    (%edx),%eax
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    157a:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    1581:	00 
    1582:	89 74 24 04          	mov    %esi,0x4(%esp)
    1586:	89 0c 24             	mov    %ecx,(%esp)
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    1589:	88 45 e7             	mov    %al,-0x19(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    158c:	e8 e7 fc ff ff       	call   1278 <write>
    1591:	8b 45 0c             	mov    0xc(%ebp),%eax
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
        ap++;
    1594:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
    1598:	e9 48 fe ff ff       	jmp    13e5 <printf+0x35>
    159d:	90                   	nop
    159e:	90                   	nop
    159f:	90                   	nop

000015a0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    15a0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    15a1:	a1 38 17 00 00       	mov    0x1738,%eax
static Header base;
static Header *freep;

void
free(void *ap)
{
    15a6:	89 e5                	mov    %esp,%ebp
    15a8:	57                   	push   %edi
    15a9:	56                   	push   %esi
    15aa:	53                   	push   %ebx
    15ab:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
    15ae:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    15b1:	39 c8                	cmp    %ecx,%eax
    15b3:	73 1d                	jae    15d2 <free+0x32>
    15b5:	8d 76 00             	lea    0x0(%esi),%esi
    15b8:	8b 10                	mov    (%eax),%edx
    15ba:	39 d1                	cmp    %edx,%ecx
    15bc:	72 1a                	jb     15d8 <free+0x38>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    15be:	39 d0                	cmp    %edx,%eax
    15c0:	72 08                	jb     15ca <free+0x2a>
    15c2:	39 c8                	cmp    %ecx,%eax
    15c4:	72 12                	jb     15d8 <free+0x38>
    15c6:	39 d1                	cmp    %edx,%ecx
    15c8:	72 0e                	jb     15d8 <free+0x38>
    15ca:	89 d0                	mov    %edx,%eax
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    15cc:	39 c8                	cmp    %ecx,%eax
    15ce:	66 90                	xchg   %ax,%ax
    15d0:	72 e6                	jb     15b8 <free+0x18>
    15d2:	8b 10                	mov    (%eax),%edx
    15d4:	eb e8                	jmp    15be <free+0x1e>
    15d6:	66 90                	xchg   %ax,%ax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    15d8:	8b 71 04             	mov    0x4(%ecx),%esi
    15db:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    15de:	39 d7                	cmp    %edx,%edi
    15e0:	74 19                	je     15fb <free+0x5b>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
    15e2:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    15e5:	8b 50 04             	mov    0x4(%eax),%edx
    15e8:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    15eb:	39 ce                	cmp    %ecx,%esi
    15ed:	74 23                	je     1612 <free+0x72>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
    15ef:	89 08                	mov    %ecx,(%eax)
  freep = p;
    15f1:	a3 38 17 00 00       	mov    %eax,0x1738
}
    15f6:	5b                   	pop    %ebx
    15f7:	5e                   	pop    %esi
    15f8:	5f                   	pop    %edi
    15f9:	5d                   	pop    %ebp
    15fa:	c3                   	ret    
  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
    15fb:	03 72 04             	add    0x4(%edx),%esi
    15fe:	89 71 04             	mov    %esi,0x4(%ecx)
    bp->s.ptr = p->s.ptr->s.ptr;
    1601:	8b 10                	mov    (%eax),%edx
    1603:	8b 12                	mov    (%edx),%edx
    1605:	89 53 f8             	mov    %edx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    1608:	8b 50 04             	mov    0x4(%eax),%edx
    160b:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    160e:	39 ce                	cmp    %ecx,%esi
    1610:	75 dd                	jne    15ef <free+0x4f>
    p->s.size += bp->s.size;
    1612:	03 51 04             	add    0x4(%ecx),%edx
    1615:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    1618:	8b 53 f8             	mov    -0x8(%ebx),%edx
    161b:	89 10                	mov    %edx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
    161d:	a3 38 17 00 00       	mov    %eax,0x1738
}
    1622:	5b                   	pop    %ebx
    1623:	5e                   	pop    %esi
    1624:	5f                   	pop    %edi
    1625:	5d                   	pop    %ebp
    1626:	c3                   	ret    
    1627:	89 f6                	mov    %esi,%esi
    1629:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001630 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    1630:	55                   	push   %ebp
    1631:	89 e5                	mov    %esp,%ebp
    1633:	57                   	push   %edi
    1634:	56                   	push   %esi
    1635:	53                   	push   %ebx
    1636:	83 ec 2c             	sub    $0x2c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1639:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if((prevp = freep) == 0){
    163c:	8b 0d 38 17 00 00    	mov    0x1738,%ecx
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1642:	83 c3 07             	add    $0x7,%ebx
    1645:	c1 eb 03             	shr    $0x3,%ebx
    1648:	83 c3 01             	add    $0x1,%ebx
  if((prevp = freep) == 0){
    164b:	85 c9                	test   %ecx,%ecx
    164d:	0f 84 9b 00 00 00    	je     16ee <malloc+0xbe>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1653:	8b 01                	mov    (%ecx),%eax
    if(p->s.size >= nunits){
    1655:	8b 50 04             	mov    0x4(%eax),%edx
    1658:	39 d3                	cmp    %edx,%ebx
    165a:	76 27                	jbe    1683 <malloc+0x53>
        p->s.size -= nunits;
        p += p->s.size;
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    165c:	8d 3c dd 00 00 00 00 	lea    0x0(,%ebx,8),%edi
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < 4096)
    1663:	be 00 80 00 00       	mov    $0x8000,%esi
    1668:	89 7d e4             	mov    %edi,-0x1c(%ebp)
    166b:	90                   	nop
    166c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    1670:	3b 05 38 17 00 00    	cmp    0x1738,%eax
    1676:	74 30                	je     16a8 <malloc+0x78>
    1678:	89 c1                	mov    %eax,%ecx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    167a:	8b 01                	mov    (%ecx),%eax
    if(p->s.size >= nunits){
    167c:	8b 50 04             	mov    0x4(%eax),%edx
    167f:	39 d3                	cmp    %edx,%ebx
    1681:	77 ed                	ja     1670 <malloc+0x40>
      if(p->s.size == nunits)
    1683:	39 d3                	cmp    %edx,%ebx
    1685:	74 61                	je     16e8 <malloc+0xb8>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
    1687:	29 da                	sub    %ebx,%edx
    1689:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
    168c:	8d 04 d0             	lea    (%eax,%edx,8),%eax
        p->s.size = nunits;
    168f:	89 58 04             	mov    %ebx,0x4(%eax)
      }
      freep = prevp;
    1692:	89 0d 38 17 00 00    	mov    %ecx,0x1738
      return (void*)(p + 1);
    1698:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
    169b:	83 c4 2c             	add    $0x2c,%esp
    169e:	5b                   	pop    %ebx
    169f:	5e                   	pop    %esi
    16a0:	5f                   	pop    %edi
    16a1:	5d                   	pop    %ebp
    16a2:	c3                   	ret    
    16a3:	90                   	nop
    16a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < 4096)
    16a8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    16ab:	81 fb 00 10 00 00    	cmp    $0x1000,%ebx
    16b1:	bf 00 10 00 00       	mov    $0x1000,%edi
    16b6:	0f 43 fb             	cmovae %ebx,%edi
    16b9:	0f 42 c6             	cmovb  %esi,%eax
    nu = 4096;
  p = sbrk(nu * sizeof(Header));
    16bc:	89 04 24             	mov    %eax,(%esp)
    16bf:	e8 1c fc ff ff       	call   12e0 <sbrk>
  if(p == (char*)-1)
    16c4:	83 f8 ff             	cmp    $0xffffffff,%eax
    16c7:	74 18                	je     16e1 <malloc+0xb1>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
    16c9:	89 78 04             	mov    %edi,0x4(%eax)
  free((void*)(hp + 1));
    16cc:	83 c0 08             	add    $0x8,%eax
    16cf:	89 04 24             	mov    %eax,(%esp)
    16d2:	e8 c9 fe ff ff       	call   15a0 <free>
  return freep;
    16d7:	8b 0d 38 17 00 00    	mov    0x1738,%ecx
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
    16dd:	85 c9                	test   %ecx,%ecx
    16df:	75 99                	jne    167a <malloc+0x4a>
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
    16e1:	31 c0                	xor    %eax,%eax
    16e3:	eb b6                	jmp    169b <malloc+0x6b>
    16e5:	8d 76 00             	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
    16e8:	8b 10                	mov    (%eax),%edx
    16ea:	89 11                	mov    %edx,(%ecx)
    16ec:	eb a4                	jmp    1692 <malloc+0x62>
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    16ee:	c7 05 38 17 00 00 30 	movl   $0x1730,0x1738
    16f5:	17 00 00 
    base.s.size = 0;
    16f8:	b9 30 17 00 00       	mov    $0x1730,%ecx
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    16fd:	c7 05 30 17 00 00 30 	movl   $0x1730,0x1730
    1704:	17 00 00 
    base.s.size = 0;
    1707:	c7 05 34 17 00 00 00 	movl   $0x0,0x1734
    170e:	00 00 00 
    1711:	e9 3d ff ff ff       	jmp    1653 <malloc+0x23>
