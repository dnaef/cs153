
_test:     file format elf32-i386


Disassembly of section .text:

00001000 <main>:
#include "types.h"
#include "stat.h"
#include "user.h"
int
main(int argc, char *argv[])
{
    1000:	55                   	push   %ebp
    1001:	89 e5                	mov    %esp,%ebp
    1003:	83 e4 f0             	and    $0xfffffff0,%esp
    1006:	83 ec 10             	sub    $0x10,%esp
	hello();
    1009:	e8 da 02 00 00       	call   12e8 <hello>
	exit(0);
    100e:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1015:	e8 2e 02 00 00       	call   1248 <exit>
    101a:	90                   	nop
    101b:	90                   	nop
    101c:	90                   	nop
    101d:	90                   	nop
    101e:	90                   	nop
    101f:	90                   	nop

00001020 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
    1020:	55                   	push   %ebp
    1021:	31 d2                	xor    %edx,%edx
    1023:	89 e5                	mov    %esp,%ebp
    1025:	8b 45 08             	mov    0x8(%ebp),%eax
    1028:	53                   	push   %ebx
    1029:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    102c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
    1030:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
    1034:	88 0c 10             	mov    %cl,(%eax,%edx,1)
    1037:	83 c2 01             	add    $0x1,%edx
    103a:	84 c9                	test   %cl,%cl
    103c:	75 f2                	jne    1030 <strcpy+0x10>
    ;
  return os;
}
    103e:	5b                   	pop    %ebx
    103f:	5d                   	pop    %ebp
    1040:	c3                   	ret    
    1041:	eb 0d                	jmp    1050 <strcmp>
    1043:	90                   	nop
    1044:	90                   	nop
    1045:	90                   	nop
    1046:	90                   	nop
    1047:	90                   	nop
    1048:	90                   	nop
    1049:	90                   	nop
    104a:	90                   	nop
    104b:	90                   	nop
    104c:	90                   	nop
    104d:	90                   	nop
    104e:	90                   	nop
    104f:	90                   	nop

00001050 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    1050:	55                   	push   %ebp
    1051:	89 e5                	mov    %esp,%ebp
    1053:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1056:	53                   	push   %ebx
    1057:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(*p && *p == *q)
    105a:	0f b6 01             	movzbl (%ecx),%eax
    105d:	84 c0                	test   %al,%al
    105f:	75 14                	jne    1075 <strcmp+0x25>
    1061:	eb 25                	jmp    1088 <strcmp+0x38>
    1063:	90                   	nop
    1064:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    p++, q++;
    1068:	83 c1 01             	add    $0x1,%ecx
    106b:	83 c2 01             	add    $0x1,%edx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
    106e:	0f b6 01             	movzbl (%ecx),%eax
    1071:	84 c0                	test   %al,%al
    1073:	74 13                	je     1088 <strcmp+0x38>
    1075:	0f b6 1a             	movzbl (%edx),%ebx
    1078:	38 d8                	cmp    %bl,%al
    107a:	74 ec                	je     1068 <strcmp+0x18>
    107c:	0f b6 db             	movzbl %bl,%ebx
    107f:	0f b6 c0             	movzbl %al,%eax
    1082:	29 d8                	sub    %ebx,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
    1084:	5b                   	pop    %ebx
    1085:	5d                   	pop    %ebp
    1086:	c3                   	ret    
    1087:	90                   	nop
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
    1088:	0f b6 1a             	movzbl (%edx),%ebx
    108b:	31 c0                	xor    %eax,%eax
    108d:	0f b6 db             	movzbl %bl,%ebx
    1090:	29 d8                	sub    %ebx,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
    1092:	5b                   	pop    %ebx
    1093:	5d                   	pop    %ebp
    1094:	c3                   	ret    
    1095:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1099:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000010a0 <strlen>:

uint
strlen(char *s)
{
    10a0:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
    10a1:	31 d2                	xor    %edx,%edx
  return (uchar)*p - (uchar)*q;
}

uint
strlen(char *s)
{
    10a3:	89 e5                	mov    %esp,%ebp
  int n;

  for(n = 0; s[n]; n++)
    10a5:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
}

uint
strlen(char *s)
{
    10a7:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
    10aa:	80 39 00             	cmpb   $0x0,(%ecx)
    10ad:	74 0c                	je     10bb <strlen+0x1b>
    10af:	90                   	nop
    10b0:	83 c2 01             	add    $0x1,%edx
    10b3:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
    10b7:	89 d0                	mov    %edx,%eax
    10b9:	75 f5                	jne    10b0 <strlen+0x10>
    ;
  return n;
}
    10bb:	5d                   	pop    %ebp
    10bc:	c3                   	ret    
    10bd:	8d 76 00             	lea    0x0(%esi),%esi

000010c0 <memset>:

void*
memset(void *dst, int c, uint n)
{
    10c0:	55                   	push   %ebp
    10c1:	89 e5                	mov    %esp,%ebp
    10c3:	8b 55 08             	mov    0x8(%ebp),%edx
    10c6:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
    10c7:	8b 4d 10             	mov    0x10(%ebp),%ecx
    10ca:	8b 45 0c             	mov    0xc(%ebp),%eax
    10cd:	89 d7                	mov    %edx,%edi
    10cf:	fc                   	cld    
    10d0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
    10d2:	89 d0                	mov    %edx,%eax
    10d4:	5f                   	pop    %edi
    10d5:	5d                   	pop    %ebp
    10d6:	c3                   	ret    
    10d7:	89 f6                	mov    %esi,%esi
    10d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000010e0 <strchr>:

char*
strchr(const char *s, char c)
{
    10e0:	55                   	push   %ebp
    10e1:	89 e5                	mov    %esp,%ebp
    10e3:	8b 45 08             	mov    0x8(%ebp),%eax
    10e6:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
    10ea:	0f b6 10             	movzbl (%eax),%edx
    10ed:	84 d2                	test   %dl,%dl
    10ef:	75 11                	jne    1102 <strchr+0x22>
    10f1:	eb 15                	jmp    1108 <strchr+0x28>
    10f3:	90                   	nop
    10f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    10f8:	83 c0 01             	add    $0x1,%eax
    10fb:	0f b6 10             	movzbl (%eax),%edx
    10fe:	84 d2                	test   %dl,%dl
    1100:	74 06                	je     1108 <strchr+0x28>
    if(*s == c)
    1102:	38 ca                	cmp    %cl,%dl
    1104:	75 f2                	jne    10f8 <strchr+0x18>
      return (char*)s;
  return 0;
}
    1106:	5d                   	pop    %ebp
    1107:	c3                   	ret    
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
    1108:	31 c0                	xor    %eax,%eax
    if(*s == c)
      return (char*)s;
  return 0;
}
    110a:	5d                   	pop    %ebp
    110b:	90                   	nop
    110c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1110:	c3                   	ret    
    1111:	eb 0d                	jmp    1120 <atoi>
    1113:	90                   	nop
    1114:	90                   	nop
    1115:	90                   	nop
    1116:	90                   	nop
    1117:	90                   	nop
    1118:	90                   	nop
    1119:	90                   	nop
    111a:	90                   	nop
    111b:	90                   	nop
    111c:	90                   	nop
    111d:	90                   	nop
    111e:	90                   	nop
    111f:	90                   	nop

00001120 <atoi>:
  return r;
}

int
atoi(const char *s)
{
    1120:	55                   	push   %ebp
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    1121:	31 c0                	xor    %eax,%eax
  return r;
}

int
atoi(const char *s)
{
    1123:	89 e5                	mov    %esp,%ebp
    1125:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1128:	53                   	push   %ebx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    1129:	0f b6 11             	movzbl (%ecx),%edx
    112c:	8d 5a d0             	lea    -0x30(%edx),%ebx
    112f:	80 fb 09             	cmp    $0x9,%bl
    1132:	77 1c                	ja     1150 <atoi+0x30>
    1134:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    n = n*10 + *s++ - '0';
    1138:	0f be d2             	movsbl %dl,%edx
    113b:	83 c1 01             	add    $0x1,%ecx
    113e:	8d 04 80             	lea    (%eax,%eax,4),%eax
    1141:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    1145:	0f b6 11             	movzbl (%ecx),%edx
    1148:	8d 5a d0             	lea    -0x30(%edx),%ebx
    114b:	80 fb 09             	cmp    $0x9,%bl
    114e:	76 e8                	jbe    1138 <atoi+0x18>
    n = n*10 + *s++ - '0';
  return n;
}
    1150:	5b                   	pop    %ebx
    1151:	5d                   	pop    %ebp
    1152:	c3                   	ret    
    1153:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    1159:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001160 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
    1160:	55                   	push   %ebp
    1161:	89 e5                	mov    %esp,%ebp
    1163:	56                   	push   %esi
    1164:	8b 45 08             	mov    0x8(%ebp),%eax
    1167:	53                   	push   %ebx
    1168:	8b 5d 10             	mov    0x10(%ebp),%ebx
    116b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    116e:	85 db                	test   %ebx,%ebx
    1170:	7e 14                	jle    1186 <memmove+0x26>
    n = n*10 + *s++ - '0';
  return n;
}

void*
memmove(void *vdst, void *vsrc, int n)
    1172:	31 d2                	xor    %edx,%edx
    1174:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    *dst++ = *src++;
    1178:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
    117c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
    117f:	83 c2 01             	add    $0x1,%edx
{
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    1182:	39 da                	cmp    %ebx,%edx
    1184:	75 f2                	jne    1178 <memmove+0x18>
    *dst++ = *src++;
  return vdst;
}
    1186:	5b                   	pop    %ebx
    1187:	5e                   	pop    %esi
    1188:	5d                   	pop    %ebp
    1189:	c3                   	ret    
    118a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00001190 <stat>:
  return buf;
}

int
stat(char *n, struct stat *st)
{
    1190:	55                   	push   %ebp
    1191:	89 e5                	mov    %esp,%ebp
    1193:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    1196:	8b 45 08             	mov    0x8(%ebp),%eax
  return buf;
}

int
stat(char *n, struct stat *st)
{
    1199:	89 5d f8             	mov    %ebx,-0x8(%ebp)
    119c:	89 75 fc             	mov    %esi,-0x4(%ebp)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    119f:	be ff ff ff ff       	mov    $0xffffffff,%esi
stat(char *n, struct stat *st)
{
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    11a4:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    11ab:	00 
    11ac:	89 04 24             	mov    %eax,(%esp)
    11af:	e8 d4 00 00 00       	call   1288 <open>
  if(fd < 0)
    11b4:	85 c0                	test   %eax,%eax
stat(char *n, struct stat *st)
{
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    11b6:	89 c3                	mov    %eax,%ebx
  if(fd < 0)
    11b8:	78 19                	js     11d3 <stat+0x43>
    return -1;
  r = fstat(fd, st);
    11ba:	8b 45 0c             	mov    0xc(%ebp),%eax
    11bd:	89 1c 24             	mov    %ebx,(%esp)
    11c0:	89 44 24 04          	mov    %eax,0x4(%esp)
    11c4:	e8 d7 00 00 00       	call   12a0 <fstat>
  close(fd);
    11c9:	89 1c 24             	mov    %ebx,(%esp)
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
  r = fstat(fd, st);
    11cc:	89 c6                	mov    %eax,%esi
  close(fd);
    11ce:	e8 9d 00 00 00       	call   1270 <close>
  return r;
}
    11d3:	89 f0                	mov    %esi,%eax
    11d5:	8b 5d f8             	mov    -0x8(%ebp),%ebx
    11d8:	8b 75 fc             	mov    -0x4(%ebp),%esi
    11db:	89 ec                	mov    %ebp,%esp
    11dd:	5d                   	pop    %ebp
    11de:	c3                   	ret    
    11df:	90                   	nop

000011e0 <gets>:
  return 0;
}

char*
gets(char *buf, int max)
{
    11e0:	55                   	push   %ebp
    11e1:	89 e5                	mov    %esp,%ebp
    11e3:	57                   	push   %edi
    11e4:	56                   	push   %esi
    11e5:	31 f6                	xor    %esi,%esi
    11e7:	53                   	push   %ebx
    11e8:	83 ec 2c             	sub    $0x2c,%esp
    11eb:	8b 7d 08             	mov    0x8(%ebp),%edi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    11ee:	eb 06                	jmp    11f6 <gets+0x16>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
    11f0:	3c 0a                	cmp    $0xa,%al
    11f2:	74 39                	je     122d <gets+0x4d>
    11f4:	89 de                	mov    %ebx,%esi
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    11f6:	8d 5e 01             	lea    0x1(%esi),%ebx
    11f9:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
    11fc:	7d 31                	jge    122f <gets+0x4f>
    cc = read(0, &c, 1);
    11fe:	8d 45 e7             	lea    -0x19(%ebp),%eax
    1201:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    1208:	00 
    1209:	89 44 24 04          	mov    %eax,0x4(%esp)
    120d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1214:	e8 47 00 00 00       	call   1260 <read>
    if(cc < 1)
    1219:	85 c0                	test   %eax,%eax
    121b:	7e 12                	jle    122f <gets+0x4f>
      break;
    buf[i++] = c;
    121d:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
    1221:	88 44 1f ff          	mov    %al,-0x1(%edi,%ebx,1)
    if(c == '\n' || c == '\r')
    1225:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
    1229:	3c 0d                	cmp    $0xd,%al
    122b:	75 c3                	jne    11f0 <gets+0x10>
    122d:	89 de                	mov    %ebx,%esi
      break;
  }
  buf[i] = '\0';
    122f:	c6 04 37 00          	movb   $0x0,(%edi,%esi,1)
  return buf;
}
    1233:	89 f8                	mov    %edi,%eax
    1235:	83 c4 2c             	add    $0x2c,%esp
    1238:	5b                   	pop    %ebx
    1239:	5e                   	pop    %esi
    123a:	5f                   	pop    %edi
    123b:	5d                   	pop    %ebp
    123c:	c3                   	ret    
    123d:	90                   	nop
    123e:	90                   	nop
    123f:	90                   	nop

00001240 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    1240:	b8 01 00 00 00       	mov    $0x1,%eax
    1245:	cd 40                	int    $0x40
    1247:	c3                   	ret    

00001248 <exit>:
SYSCALL(exit)
    1248:	b8 02 00 00 00       	mov    $0x2,%eax
    124d:	cd 40                	int    $0x40
    124f:	c3                   	ret    

00001250 <wait>:
SYSCALL(wait)
    1250:	b8 03 00 00 00       	mov    $0x3,%eax
    1255:	cd 40                	int    $0x40
    1257:	c3                   	ret    

00001258 <pipe>:
SYSCALL(pipe)
    1258:	b8 04 00 00 00       	mov    $0x4,%eax
    125d:	cd 40                	int    $0x40
    125f:	c3                   	ret    

00001260 <read>:
SYSCALL(read)
    1260:	b8 05 00 00 00       	mov    $0x5,%eax
    1265:	cd 40                	int    $0x40
    1267:	c3                   	ret    

00001268 <write>:
SYSCALL(write)
    1268:	b8 10 00 00 00       	mov    $0x10,%eax
    126d:	cd 40                	int    $0x40
    126f:	c3                   	ret    

00001270 <close>:
SYSCALL(close)
    1270:	b8 15 00 00 00       	mov    $0x15,%eax
    1275:	cd 40                	int    $0x40
    1277:	c3                   	ret    

00001278 <kill>:
SYSCALL(kill)
    1278:	b8 06 00 00 00       	mov    $0x6,%eax
    127d:	cd 40                	int    $0x40
    127f:	c3                   	ret    

00001280 <exec>:
SYSCALL(exec)
    1280:	b8 07 00 00 00       	mov    $0x7,%eax
    1285:	cd 40                	int    $0x40
    1287:	c3                   	ret    

00001288 <open>:
SYSCALL(open)
    1288:	b8 0f 00 00 00       	mov    $0xf,%eax
    128d:	cd 40                	int    $0x40
    128f:	c3                   	ret    

00001290 <mknod>:
SYSCALL(mknod)
    1290:	b8 11 00 00 00       	mov    $0x11,%eax
    1295:	cd 40                	int    $0x40
    1297:	c3                   	ret    

00001298 <unlink>:
SYSCALL(unlink)
    1298:	b8 12 00 00 00       	mov    $0x12,%eax
    129d:	cd 40                	int    $0x40
    129f:	c3                   	ret    

000012a0 <fstat>:
SYSCALL(fstat)
    12a0:	b8 08 00 00 00       	mov    $0x8,%eax
    12a5:	cd 40                	int    $0x40
    12a7:	c3                   	ret    

000012a8 <link>:
SYSCALL(link)
    12a8:	b8 13 00 00 00       	mov    $0x13,%eax
    12ad:	cd 40                	int    $0x40
    12af:	c3                   	ret    

000012b0 <mkdir>:
SYSCALL(mkdir)
    12b0:	b8 14 00 00 00       	mov    $0x14,%eax
    12b5:	cd 40                	int    $0x40
    12b7:	c3                   	ret    

000012b8 <chdir>:
SYSCALL(chdir)
    12b8:	b8 09 00 00 00       	mov    $0x9,%eax
    12bd:	cd 40                	int    $0x40
    12bf:	c3                   	ret    

000012c0 <dup>:
SYSCALL(dup)
    12c0:	b8 0a 00 00 00       	mov    $0xa,%eax
    12c5:	cd 40                	int    $0x40
    12c7:	c3                   	ret    

000012c8 <getpid>:
SYSCALL(getpid)
    12c8:	b8 0b 00 00 00       	mov    $0xb,%eax
    12cd:	cd 40                	int    $0x40
    12cf:	c3                   	ret    

000012d0 <sbrk>:
SYSCALL(sbrk)
    12d0:	b8 0c 00 00 00       	mov    $0xc,%eax
    12d5:	cd 40                	int    $0x40
    12d7:	c3                   	ret    

000012d8 <sleep>:
SYSCALL(sleep)
    12d8:	b8 0d 00 00 00       	mov    $0xd,%eax
    12dd:	cd 40                	int    $0x40
    12df:	c3                   	ret    

000012e0 <uptime>:
SYSCALL(uptime)
    12e0:	b8 0e 00 00 00       	mov    $0xe,%eax
    12e5:	cd 40                	int    $0x40
    12e7:	c3                   	ret    

000012e8 <hello>:
SYSCALL(hello) 			// added for Lab0
    12e8:	b8 16 00 00 00       	mov    $0x16,%eax
    12ed:	cd 40                	int    $0x40
    12ef:	c3                   	ret    

000012f0 <waitpid>:
SYSCALL(waitpid) 		// lab1 part 1: c
    12f0:	b8 17 00 00 00       	mov    $0x17,%eax
    12f5:	cd 40                	int    $0x40
    12f7:	c3                   	ret    

000012f8 <setpriority>:
SYSCALL(setpriority) 	// lab1 part 2: define syscall
    12f8:	b8 18 00 00 00       	mov    $0x18,%eax
    12fd:	cd 40                	int    $0x40
    12ff:	c3                   	ret    

00001300 <v2p>:
SYSCALL(v2p)			// lab2
    1300:	b8 19 00 00 00       	mov    $0x19,%eax
    1305:	cd 40                	int    $0x40
    1307:	c3                   	ret    
    1308:	90                   	nop
    1309:	90                   	nop
    130a:	90                   	nop
    130b:	90                   	nop
    130c:	90                   	nop
    130d:	90                   	nop
    130e:	90                   	nop
    130f:	90                   	nop

00001310 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
    1310:	55                   	push   %ebp
    1311:	89 e5                	mov    %esp,%ebp
    1313:	57                   	push   %edi
    1314:	89 cf                	mov    %ecx,%edi
    1316:	56                   	push   %esi
    1317:	89 c6                	mov    %eax,%esi
    1319:	53                   	push   %ebx
    131a:	83 ec 4c             	sub    $0x4c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    131d:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1320:	85 c9                	test   %ecx,%ecx
    1322:	74 04                	je     1328 <printint+0x18>
    1324:	85 d2                	test   %edx,%edx
    1326:	78 68                	js     1390 <printint+0x80>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
    1328:	89 d0                	mov    %edx,%eax
    132a:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
    1331:	31 c9                	xor    %ecx,%ecx
    1333:	8d 5d d7             	lea    -0x29(%ebp),%ebx
    1336:	66 90                	xchg   %ax,%ax
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
    1338:	31 d2                	xor    %edx,%edx
    133a:	f7 f7                	div    %edi
    133c:	0f b6 92 0d 17 00 00 	movzbl 0x170d(%edx),%edx
    1343:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
    1346:	83 c1 01             	add    $0x1,%ecx
  }while((x /= base) != 0);
    1349:	85 c0                	test   %eax,%eax
    134b:	75 eb                	jne    1338 <printint+0x28>
  if(neg)
    134d:	8b 45 c4             	mov    -0x3c(%ebp),%eax
    1350:	85 c0                	test   %eax,%eax
    1352:	74 08                	je     135c <printint+0x4c>
    buf[i++] = '-';
    1354:	c6 44 0d d7 2d       	movb   $0x2d,-0x29(%ebp,%ecx,1)
    1359:	83 c1 01             	add    $0x1,%ecx

  while(--i >= 0)
    135c:	8d 79 ff             	lea    -0x1(%ecx),%edi
    135f:	90                   	nop
    1360:	0f b6 04 3b          	movzbl (%ebx,%edi,1),%eax
    1364:	83 ef 01             	sub    $0x1,%edi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    1367:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    136e:	00 
    136f:	89 34 24             	mov    %esi,(%esp)
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
    1372:	88 45 e7             	mov    %al,-0x19(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    1375:	8d 45 e7             	lea    -0x19(%ebp),%eax
    1378:	89 44 24 04          	mov    %eax,0x4(%esp)
    137c:	e8 e7 fe ff ff       	call   1268 <write>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
    1381:	83 ff ff             	cmp    $0xffffffff,%edi
    1384:	75 da                	jne    1360 <printint+0x50>
    putc(fd, buf[i]);
}
    1386:	83 c4 4c             	add    $0x4c,%esp
    1389:	5b                   	pop    %ebx
    138a:	5e                   	pop    %esi
    138b:	5f                   	pop    %edi
    138c:	5d                   	pop    %ebp
    138d:	c3                   	ret    
    138e:	66 90                	xchg   %ax,%ax
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
    1390:	89 d0                	mov    %edx,%eax
    1392:	f7 d8                	neg    %eax
    1394:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
    139b:	eb 94                	jmp    1331 <printint+0x21>
    139d:	8d 76 00             	lea    0x0(%esi),%esi

000013a0 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
    13a0:	55                   	push   %ebp
    13a1:	89 e5                	mov    %esp,%ebp
    13a3:	57                   	push   %edi
    13a4:	56                   	push   %esi
    13a5:	53                   	push   %ebx
    13a6:	83 ec 3c             	sub    $0x3c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    13a9:	8b 45 0c             	mov    0xc(%ebp),%eax
    13ac:	0f b6 10             	movzbl (%eax),%edx
    13af:	84 d2                	test   %dl,%dl
    13b1:	0f 84 c1 00 00 00    	je     1478 <printf+0xd8>
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
    13b7:	8d 4d 10             	lea    0x10(%ebp),%ecx
    13ba:	31 ff                	xor    %edi,%edi
    13bc:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
    13bf:	31 db                	xor    %ebx,%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    13c1:	8d 75 e7             	lea    -0x19(%ebp),%esi
    13c4:	eb 1e                	jmp    13e4 <printf+0x44>
    13c6:	66 90                	xchg   %ax,%ax
  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
    13c8:	83 fa 25             	cmp    $0x25,%edx
    13cb:	0f 85 af 00 00 00    	jne    1480 <printf+0xe0>
    13d1:	66 bf 25 00          	mov    $0x25,%di
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    13d5:	83 c3 01             	add    $0x1,%ebx
    13d8:	0f b6 14 18          	movzbl (%eax,%ebx,1),%edx
    13dc:	84 d2                	test   %dl,%dl
    13de:	0f 84 94 00 00 00    	je     1478 <printf+0xd8>
    c = fmt[i] & 0xff;
    if(state == 0){
    13e4:	85 ff                	test   %edi,%edi
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    13e6:	0f b6 d2             	movzbl %dl,%edx
    if(state == 0){
    13e9:	74 dd                	je     13c8 <printf+0x28>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
    13eb:	83 ff 25             	cmp    $0x25,%edi
    13ee:	75 e5                	jne    13d5 <printf+0x35>
      if(c == 'd'){
    13f0:	83 fa 64             	cmp    $0x64,%edx
    13f3:	0f 84 3f 01 00 00    	je     1538 <printf+0x198>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
    13f9:	83 fa 70             	cmp    $0x70,%edx
    13fc:	0f 84 a6 00 00 00    	je     14a8 <printf+0x108>
    1402:	83 fa 78             	cmp    $0x78,%edx
    1405:	0f 84 9d 00 00 00    	je     14a8 <printf+0x108>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
    140b:	83 fa 73             	cmp    $0x73,%edx
    140e:	66 90                	xchg   %ax,%ax
    1410:	0f 84 ba 00 00 00    	je     14d0 <printf+0x130>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    1416:	83 fa 63             	cmp    $0x63,%edx
    1419:	0f 84 41 01 00 00    	je     1560 <printf+0x1c0>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
    141f:	83 fa 25             	cmp    $0x25,%edx
    1422:	0f 84 00 01 00 00    	je     1528 <printf+0x188>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    1428:	8b 4d 08             	mov    0x8(%ebp),%ecx
    142b:	89 55 cc             	mov    %edx,-0x34(%ebp)
    142e:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
    1432:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    1439:	00 
    143a:	89 74 24 04          	mov    %esi,0x4(%esp)
    143e:	89 0c 24             	mov    %ecx,(%esp)
    1441:	e8 22 fe ff ff       	call   1268 <write>
    1446:	8b 55 cc             	mov    -0x34(%ebp),%edx
    1449:	88 55 e7             	mov    %dl,-0x19(%ebp)
    144c:	8b 45 08             	mov    0x8(%ebp),%eax
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    144f:	83 c3 01             	add    $0x1,%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    1452:	31 ff                	xor    %edi,%edi
    1454:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    145b:	00 
    145c:	89 74 24 04          	mov    %esi,0x4(%esp)
    1460:	89 04 24             	mov    %eax,(%esp)
    1463:	e8 00 fe ff ff       	call   1268 <write>
    1468:	8b 45 0c             	mov    0xc(%ebp),%eax
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    146b:	0f b6 14 18          	movzbl (%eax,%ebx,1),%edx
    146f:	84 d2                	test   %dl,%dl
    1471:	0f 85 6d ff ff ff    	jne    13e4 <printf+0x44>
    1477:	90                   	nop
        putc(fd, c);
      }
      state = 0;
    }
  }
}
    1478:	83 c4 3c             	add    $0x3c,%esp
    147b:	5b                   	pop    %ebx
    147c:	5e                   	pop    %esi
    147d:	5f                   	pop    %edi
    147e:	5d                   	pop    %ebp
    147f:	c3                   	ret    
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    1480:	8b 45 08             	mov    0x8(%ebp),%eax
  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
    1483:	88 55 e7             	mov    %dl,-0x19(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    1486:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    148d:	00 
    148e:	89 74 24 04          	mov    %esi,0x4(%esp)
    1492:	89 04 24             	mov    %eax,(%esp)
    1495:	e8 ce fd ff ff       	call   1268 <write>
    149a:	8b 45 0c             	mov    0xc(%ebp),%eax
    149d:	e9 33 ff ff ff       	jmp    13d5 <printf+0x35>
    14a2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
    14a8:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    14ab:	b9 10 00 00 00       	mov    $0x10,%ecx
        ap++;
    14b0:	31 ff                	xor    %edi,%edi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
    14b2:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    14b9:	8b 10                	mov    (%eax),%edx
    14bb:	8b 45 08             	mov    0x8(%ebp),%eax
    14be:	e8 4d fe ff ff       	call   1310 <printint>
    14c3:	8b 45 0c             	mov    0xc(%ebp),%eax
        ap++;
    14c6:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
    14ca:	e9 06 ff ff ff       	jmp    13d5 <printf+0x35>
    14cf:	90                   	nop
      } else if(c == 's'){
        s = (char*)*ap;
    14d0:	8b 55 d4             	mov    -0x2c(%ebp),%edx
        ap++;
        if(s == 0)
    14d3:	b9 06 17 00 00       	mov    $0x1706,%ecx
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
        s = (char*)*ap;
    14d8:	8b 3a                	mov    (%edx),%edi
        ap++;
    14da:	83 c2 04             	add    $0x4,%edx
    14dd:	89 55 d4             	mov    %edx,-0x2c(%ebp)
        if(s == 0)
    14e0:	85 ff                	test   %edi,%edi
    14e2:	0f 44 f9             	cmove  %ecx,%edi
          s = "(null)";
        while(*s != 0){
    14e5:	0f b6 17             	movzbl (%edi),%edx
    14e8:	84 d2                	test   %dl,%dl
    14ea:	74 33                	je     151f <printf+0x17f>
    14ec:	89 5d d0             	mov    %ebx,-0x30(%ebp)
    14ef:	8b 5d 08             	mov    0x8(%ebp),%ebx
    14f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
          putc(fd, *s);
          s++;
    14f8:	83 c7 01             	add    $0x1,%edi
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
    14fb:	88 55 e7             	mov    %dl,-0x19(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    14fe:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    1505:	00 
    1506:	89 74 24 04          	mov    %esi,0x4(%esp)
    150a:	89 1c 24             	mov    %ebx,(%esp)
    150d:	e8 56 fd ff ff       	call   1268 <write>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
    1512:	0f b6 17             	movzbl (%edi),%edx
    1515:	84 d2                	test   %dl,%dl
    1517:	75 df                	jne    14f8 <printf+0x158>
    1519:	8b 5d d0             	mov    -0x30(%ebp),%ebx
    151c:	8b 45 0c             	mov    0xc(%ebp),%eax
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    151f:	31 ff                	xor    %edi,%edi
    1521:	e9 af fe ff ff       	jmp    13d5 <printf+0x35>
    1526:	66 90                	xchg   %ax,%ax
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
    1528:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
    152c:	e9 1b ff ff ff       	jmp    144c <printf+0xac>
    1531:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
    1538:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    153b:	b9 0a 00 00 00       	mov    $0xa,%ecx
        ap++;
    1540:	66 31 ff             	xor    %di,%di
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
    1543:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    154a:	8b 10                	mov    (%eax),%edx
    154c:	8b 45 08             	mov    0x8(%ebp),%eax
    154f:	e8 bc fd ff ff       	call   1310 <printint>
    1554:	8b 45 0c             	mov    0xc(%ebp),%eax
        ap++;
    1557:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
    155b:	e9 75 fe ff ff       	jmp    13d5 <printf+0x35>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    1560:	8b 55 d4             	mov    -0x2c(%ebp),%edx
        putc(fd, *ap);
        ap++;
    1563:	31 ff                	xor    %edi,%edi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    1565:	8b 4d 08             	mov    0x8(%ebp),%ecx
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    1568:	8b 02                	mov    (%edx),%eax
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    156a:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    1571:	00 
    1572:	89 74 24 04          	mov    %esi,0x4(%esp)
    1576:	89 0c 24             	mov    %ecx,(%esp)
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    1579:	88 45 e7             	mov    %al,-0x19(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    157c:	e8 e7 fc ff ff       	call   1268 <write>
    1581:	8b 45 0c             	mov    0xc(%ebp),%eax
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
        ap++;
    1584:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
    1588:	e9 48 fe ff ff       	jmp    13d5 <printf+0x35>
    158d:	90                   	nop
    158e:	90                   	nop
    158f:	90                   	nop

00001590 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    1590:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1591:	a1 28 17 00 00       	mov    0x1728,%eax
static Header base;
static Header *freep;

void
free(void *ap)
{
    1596:	89 e5                	mov    %esp,%ebp
    1598:	57                   	push   %edi
    1599:	56                   	push   %esi
    159a:	53                   	push   %ebx
    159b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
    159e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    15a1:	39 c8                	cmp    %ecx,%eax
    15a3:	73 1d                	jae    15c2 <free+0x32>
    15a5:	8d 76 00             	lea    0x0(%esi),%esi
    15a8:	8b 10                	mov    (%eax),%edx
    15aa:	39 d1                	cmp    %edx,%ecx
    15ac:	72 1a                	jb     15c8 <free+0x38>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    15ae:	39 d0                	cmp    %edx,%eax
    15b0:	72 08                	jb     15ba <free+0x2a>
    15b2:	39 c8                	cmp    %ecx,%eax
    15b4:	72 12                	jb     15c8 <free+0x38>
    15b6:	39 d1                	cmp    %edx,%ecx
    15b8:	72 0e                	jb     15c8 <free+0x38>
    15ba:	89 d0                	mov    %edx,%eax
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    15bc:	39 c8                	cmp    %ecx,%eax
    15be:	66 90                	xchg   %ax,%ax
    15c0:	72 e6                	jb     15a8 <free+0x18>
    15c2:	8b 10                	mov    (%eax),%edx
    15c4:	eb e8                	jmp    15ae <free+0x1e>
    15c6:	66 90                	xchg   %ax,%ax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    15c8:	8b 71 04             	mov    0x4(%ecx),%esi
    15cb:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    15ce:	39 d7                	cmp    %edx,%edi
    15d0:	74 19                	je     15eb <free+0x5b>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
    15d2:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    15d5:	8b 50 04             	mov    0x4(%eax),%edx
    15d8:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    15db:	39 ce                	cmp    %ecx,%esi
    15dd:	74 23                	je     1602 <free+0x72>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
    15df:	89 08                	mov    %ecx,(%eax)
  freep = p;
    15e1:	a3 28 17 00 00       	mov    %eax,0x1728
}
    15e6:	5b                   	pop    %ebx
    15e7:	5e                   	pop    %esi
    15e8:	5f                   	pop    %edi
    15e9:	5d                   	pop    %ebp
    15ea:	c3                   	ret    
  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
    15eb:	03 72 04             	add    0x4(%edx),%esi
    15ee:	89 71 04             	mov    %esi,0x4(%ecx)
    bp->s.ptr = p->s.ptr->s.ptr;
    15f1:	8b 10                	mov    (%eax),%edx
    15f3:	8b 12                	mov    (%edx),%edx
    15f5:	89 53 f8             	mov    %edx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    15f8:	8b 50 04             	mov    0x4(%eax),%edx
    15fb:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    15fe:	39 ce                	cmp    %ecx,%esi
    1600:	75 dd                	jne    15df <free+0x4f>
    p->s.size += bp->s.size;
    1602:	03 51 04             	add    0x4(%ecx),%edx
    1605:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    1608:	8b 53 f8             	mov    -0x8(%ebx),%edx
    160b:	89 10                	mov    %edx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
    160d:	a3 28 17 00 00       	mov    %eax,0x1728
}
    1612:	5b                   	pop    %ebx
    1613:	5e                   	pop    %esi
    1614:	5f                   	pop    %edi
    1615:	5d                   	pop    %ebp
    1616:	c3                   	ret    
    1617:	89 f6                	mov    %esi,%esi
    1619:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001620 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    1620:	55                   	push   %ebp
    1621:	89 e5                	mov    %esp,%ebp
    1623:	57                   	push   %edi
    1624:	56                   	push   %esi
    1625:	53                   	push   %ebx
    1626:	83 ec 2c             	sub    $0x2c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1629:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if((prevp = freep) == 0){
    162c:	8b 0d 28 17 00 00    	mov    0x1728,%ecx
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1632:	83 c3 07             	add    $0x7,%ebx
    1635:	c1 eb 03             	shr    $0x3,%ebx
    1638:	83 c3 01             	add    $0x1,%ebx
  if((prevp = freep) == 0){
    163b:	85 c9                	test   %ecx,%ecx
    163d:	0f 84 9b 00 00 00    	je     16de <malloc+0xbe>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1643:	8b 01                	mov    (%ecx),%eax
    if(p->s.size >= nunits){
    1645:	8b 50 04             	mov    0x4(%eax),%edx
    1648:	39 d3                	cmp    %edx,%ebx
    164a:	76 27                	jbe    1673 <malloc+0x53>
        p->s.size -= nunits;
        p += p->s.size;
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    164c:	8d 3c dd 00 00 00 00 	lea    0x0(,%ebx,8),%edi
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < 4096)
    1653:	be 00 80 00 00       	mov    $0x8000,%esi
    1658:	89 7d e4             	mov    %edi,-0x1c(%ebp)
    165b:	90                   	nop
    165c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    1660:	3b 05 28 17 00 00    	cmp    0x1728,%eax
    1666:	74 30                	je     1698 <malloc+0x78>
    1668:	89 c1                	mov    %eax,%ecx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    166a:	8b 01                	mov    (%ecx),%eax
    if(p->s.size >= nunits){
    166c:	8b 50 04             	mov    0x4(%eax),%edx
    166f:	39 d3                	cmp    %edx,%ebx
    1671:	77 ed                	ja     1660 <malloc+0x40>
      if(p->s.size == nunits)
    1673:	39 d3                	cmp    %edx,%ebx
    1675:	74 61                	je     16d8 <malloc+0xb8>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
    1677:	29 da                	sub    %ebx,%edx
    1679:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
    167c:	8d 04 d0             	lea    (%eax,%edx,8),%eax
        p->s.size = nunits;
    167f:	89 58 04             	mov    %ebx,0x4(%eax)
      }
      freep = prevp;
    1682:	89 0d 28 17 00 00    	mov    %ecx,0x1728
      return (void*)(p + 1);
    1688:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
    168b:	83 c4 2c             	add    $0x2c,%esp
    168e:	5b                   	pop    %ebx
    168f:	5e                   	pop    %esi
    1690:	5f                   	pop    %edi
    1691:	5d                   	pop    %ebp
    1692:	c3                   	ret    
    1693:	90                   	nop
    1694:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < 4096)
    1698:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    169b:	81 fb 00 10 00 00    	cmp    $0x1000,%ebx
    16a1:	bf 00 10 00 00       	mov    $0x1000,%edi
    16a6:	0f 43 fb             	cmovae %ebx,%edi
    16a9:	0f 42 c6             	cmovb  %esi,%eax
    nu = 4096;
  p = sbrk(nu * sizeof(Header));
    16ac:	89 04 24             	mov    %eax,(%esp)
    16af:	e8 1c fc ff ff       	call   12d0 <sbrk>
  if(p == (char*)-1)
    16b4:	83 f8 ff             	cmp    $0xffffffff,%eax
    16b7:	74 18                	je     16d1 <malloc+0xb1>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
    16b9:	89 78 04             	mov    %edi,0x4(%eax)
  free((void*)(hp + 1));
    16bc:	83 c0 08             	add    $0x8,%eax
    16bf:	89 04 24             	mov    %eax,(%esp)
    16c2:	e8 c9 fe ff ff       	call   1590 <free>
  return freep;
    16c7:	8b 0d 28 17 00 00    	mov    0x1728,%ecx
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
    16cd:	85 c9                	test   %ecx,%ecx
    16cf:	75 99                	jne    166a <malloc+0x4a>
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
    16d1:	31 c0                	xor    %eax,%eax
    16d3:	eb b6                	jmp    168b <malloc+0x6b>
    16d5:	8d 76 00             	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
    16d8:	8b 10                	mov    (%eax),%edx
    16da:	89 11                	mov    %edx,(%ecx)
    16dc:	eb a4                	jmp    1682 <malloc+0x62>
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    16de:	c7 05 28 17 00 00 20 	movl   $0x1720,0x1728
    16e5:	17 00 00 
    base.s.size = 0;
    16e8:	b9 20 17 00 00       	mov    $0x1720,%ecx
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    16ed:	c7 05 20 17 00 00 20 	movl   $0x1720,0x1720
    16f4:	17 00 00 
    base.s.size = 0;
    16f7:	c7 05 24 17 00 00 00 	movl   $0x0,0x1724
    16fe:	00 00 00 
    1701:	e9 3d ff ff ff       	jmp    1643 <malloc+0x23>
