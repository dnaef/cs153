
_kill:     file format elf32-i386


Disassembly of section .text:

00001000 <main>:
#include "stat.h"
#include "user.h"

int
main(int argc, char **argv)
{
    1000:	55                   	push   %ebp
    1001:	89 e5                	mov    %esp,%ebp
    1003:	83 e4 f0             	and    $0xfffffff0,%esp
    1006:	57                   	push   %edi
    1007:	56                   	push   %esi
    1008:	53                   	push   %ebx
  int i;

  if(argc < 2){
    printf(2, "usage: kill pid...\n");
    exit(0);
    1009:	bb 01 00 00 00       	mov    $0x1,%ebx
#include "stat.h"
#include "user.h"

int
main(int argc, char **argv)
{
    100e:	83 ec 14             	sub    $0x14,%esp
    1011:	8b 75 08             	mov    0x8(%ebp),%esi
    1014:	8b 7d 0c             	mov    0xc(%ebp),%edi
  int i;

  if(argc < 2){
    1017:	83 fe 01             	cmp    $0x1,%esi
    101a:	7e 2c                	jle    1048 <main+0x48>
    101c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    printf(2, "usage: kill pid...\n");
    exit(0);
  }
  for(i=1; i<argc; i++)
    kill(atoi(argv[i]));
    1020:	8b 04 9f             	mov    (%edi,%ebx,4),%eax

  if(argc < 2){
    printf(2, "usage: kill pid...\n");
    exit(0);
  }
  for(i=1; i<argc; i++)
    1023:	83 c3 01             	add    $0x1,%ebx
    kill(atoi(argv[i]));
    1026:	89 04 24             	mov    %eax,(%esp)
    1029:	e8 42 01 00 00       	call   1170 <atoi>
    102e:	89 04 24             	mov    %eax,(%esp)
    1031:	e8 92 02 00 00       	call   12c8 <kill>

  if(argc < 2){
    printf(2, "usage: kill pid...\n");
    exit(0);
  }
  for(i=1; i<argc; i++)
    1036:	39 de                	cmp    %ebx,%esi
    1038:	7f e6                	jg     1020 <main+0x20>
    kill(atoi(argv[i]));
  exit(0);
    103a:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1041:	e8 52 02 00 00       	call   1298 <exit>
    1046:	66 90                	xchg   %ax,%ax
main(int argc, char **argv)
{
  int i;

  if(argc < 2){
    printf(2, "usage: kill pid...\n");
    1048:	c7 44 24 04 56 17 00 	movl   $0x1756,0x4(%esp)
    104f:	00 
    1050:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
    1057:	e8 94 03 00 00       	call   13f0 <printf>
    exit(0);
    105c:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1063:	e8 30 02 00 00       	call   1298 <exit>
    1068:	90                   	nop
    1069:	90                   	nop
    106a:	90                   	nop
    106b:	90                   	nop
    106c:	90                   	nop
    106d:	90                   	nop
    106e:	90                   	nop
    106f:	90                   	nop

00001070 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
    1070:	55                   	push   %ebp
    1071:	31 d2                	xor    %edx,%edx
    1073:	89 e5                	mov    %esp,%ebp
    1075:	8b 45 08             	mov    0x8(%ebp),%eax
    1078:	53                   	push   %ebx
    1079:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    107c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
    1080:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
    1084:	88 0c 10             	mov    %cl,(%eax,%edx,1)
    1087:	83 c2 01             	add    $0x1,%edx
    108a:	84 c9                	test   %cl,%cl
    108c:	75 f2                	jne    1080 <strcpy+0x10>
    ;
  return os;
}
    108e:	5b                   	pop    %ebx
    108f:	5d                   	pop    %ebp
    1090:	c3                   	ret    
    1091:	eb 0d                	jmp    10a0 <strcmp>
    1093:	90                   	nop
    1094:	90                   	nop
    1095:	90                   	nop
    1096:	90                   	nop
    1097:	90                   	nop
    1098:	90                   	nop
    1099:	90                   	nop
    109a:	90                   	nop
    109b:	90                   	nop
    109c:	90                   	nop
    109d:	90                   	nop
    109e:	90                   	nop
    109f:	90                   	nop

000010a0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    10a0:	55                   	push   %ebp
    10a1:	89 e5                	mov    %esp,%ebp
    10a3:	8b 4d 08             	mov    0x8(%ebp),%ecx
    10a6:	53                   	push   %ebx
    10a7:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(*p && *p == *q)
    10aa:	0f b6 01             	movzbl (%ecx),%eax
    10ad:	84 c0                	test   %al,%al
    10af:	75 14                	jne    10c5 <strcmp+0x25>
    10b1:	eb 25                	jmp    10d8 <strcmp+0x38>
    10b3:	90                   	nop
    10b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    p++, q++;
    10b8:	83 c1 01             	add    $0x1,%ecx
    10bb:	83 c2 01             	add    $0x1,%edx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
    10be:	0f b6 01             	movzbl (%ecx),%eax
    10c1:	84 c0                	test   %al,%al
    10c3:	74 13                	je     10d8 <strcmp+0x38>
    10c5:	0f b6 1a             	movzbl (%edx),%ebx
    10c8:	38 d8                	cmp    %bl,%al
    10ca:	74 ec                	je     10b8 <strcmp+0x18>
    10cc:	0f b6 db             	movzbl %bl,%ebx
    10cf:	0f b6 c0             	movzbl %al,%eax
    10d2:	29 d8                	sub    %ebx,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
    10d4:	5b                   	pop    %ebx
    10d5:	5d                   	pop    %ebp
    10d6:	c3                   	ret    
    10d7:	90                   	nop
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
    10d8:	0f b6 1a             	movzbl (%edx),%ebx
    10db:	31 c0                	xor    %eax,%eax
    10dd:	0f b6 db             	movzbl %bl,%ebx
    10e0:	29 d8                	sub    %ebx,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
    10e2:	5b                   	pop    %ebx
    10e3:	5d                   	pop    %ebp
    10e4:	c3                   	ret    
    10e5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    10e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000010f0 <strlen>:

uint
strlen(char *s)
{
    10f0:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
    10f1:	31 d2                	xor    %edx,%edx
  return (uchar)*p - (uchar)*q;
}

uint
strlen(char *s)
{
    10f3:	89 e5                	mov    %esp,%ebp
  int n;

  for(n = 0; s[n]; n++)
    10f5:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
}

uint
strlen(char *s)
{
    10f7:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
    10fa:	80 39 00             	cmpb   $0x0,(%ecx)
    10fd:	74 0c                	je     110b <strlen+0x1b>
    10ff:	90                   	nop
    1100:	83 c2 01             	add    $0x1,%edx
    1103:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
    1107:	89 d0                	mov    %edx,%eax
    1109:	75 f5                	jne    1100 <strlen+0x10>
    ;
  return n;
}
    110b:	5d                   	pop    %ebp
    110c:	c3                   	ret    
    110d:	8d 76 00             	lea    0x0(%esi),%esi

00001110 <memset>:

void*
memset(void *dst, int c, uint n)
{
    1110:	55                   	push   %ebp
    1111:	89 e5                	mov    %esp,%ebp
    1113:	8b 55 08             	mov    0x8(%ebp),%edx
    1116:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
    1117:	8b 4d 10             	mov    0x10(%ebp),%ecx
    111a:	8b 45 0c             	mov    0xc(%ebp),%eax
    111d:	89 d7                	mov    %edx,%edi
    111f:	fc                   	cld    
    1120:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
    1122:	89 d0                	mov    %edx,%eax
    1124:	5f                   	pop    %edi
    1125:	5d                   	pop    %ebp
    1126:	c3                   	ret    
    1127:	89 f6                	mov    %esi,%esi
    1129:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001130 <strchr>:

char*
strchr(const char *s, char c)
{
    1130:	55                   	push   %ebp
    1131:	89 e5                	mov    %esp,%ebp
    1133:	8b 45 08             	mov    0x8(%ebp),%eax
    1136:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
    113a:	0f b6 10             	movzbl (%eax),%edx
    113d:	84 d2                	test   %dl,%dl
    113f:	75 11                	jne    1152 <strchr+0x22>
    1141:	eb 15                	jmp    1158 <strchr+0x28>
    1143:	90                   	nop
    1144:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1148:	83 c0 01             	add    $0x1,%eax
    114b:	0f b6 10             	movzbl (%eax),%edx
    114e:	84 d2                	test   %dl,%dl
    1150:	74 06                	je     1158 <strchr+0x28>
    if(*s == c)
    1152:	38 ca                	cmp    %cl,%dl
    1154:	75 f2                	jne    1148 <strchr+0x18>
      return (char*)s;
  return 0;
}
    1156:	5d                   	pop    %ebp
    1157:	c3                   	ret    
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
    1158:	31 c0                	xor    %eax,%eax
    if(*s == c)
      return (char*)s;
  return 0;
}
    115a:	5d                   	pop    %ebp
    115b:	90                   	nop
    115c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1160:	c3                   	ret    
    1161:	eb 0d                	jmp    1170 <atoi>
    1163:	90                   	nop
    1164:	90                   	nop
    1165:	90                   	nop
    1166:	90                   	nop
    1167:	90                   	nop
    1168:	90                   	nop
    1169:	90                   	nop
    116a:	90                   	nop
    116b:	90                   	nop
    116c:	90                   	nop
    116d:	90                   	nop
    116e:	90                   	nop
    116f:	90                   	nop

00001170 <atoi>:
  return r;
}

int
atoi(const char *s)
{
    1170:	55                   	push   %ebp
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    1171:	31 c0                	xor    %eax,%eax
  return r;
}

int
atoi(const char *s)
{
    1173:	89 e5                	mov    %esp,%ebp
    1175:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1178:	53                   	push   %ebx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    1179:	0f b6 11             	movzbl (%ecx),%edx
    117c:	8d 5a d0             	lea    -0x30(%edx),%ebx
    117f:	80 fb 09             	cmp    $0x9,%bl
    1182:	77 1c                	ja     11a0 <atoi+0x30>
    1184:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    n = n*10 + *s++ - '0';
    1188:	0f be d2             	movsbl %dl,%edx
    118b:	83 c1 01             	add    $0x1,%ecx
    118e:	8d 04 80             	lea    (%eax,%eax,4),%eax
    1191:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    1195:	0f b6 11             	movzbl (%ecx),%edx
    1198:	8d 5a d0             	lea    -0x30(%edx),%ebx
    119b:	80 fb 09             	cmp    $0x9,%bl
    119e:	76 e8                	jbe    1188 <atoi+0x18>
    n = n*10 + *s++ - '0';
  return n;
}
    11a0:	5b                   	pop    %ebx
    11a1:	5d                   	pop    %ebp
    11a2:	c3                   	ret    
    11a3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    11a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000011b0 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
    11b0:	55                   	push   %ebp
    11b1:	89 e5                	mov    %esp,%ebp
    11b3:	56                   	push   %esi
    11b4:	8b 45 08             	mov    0x8(%ebp),%eax
    11b7:	53                   	push   %ebx
    11b8:	8b 5d 10             	mov    0x10(%ebp),%ebx
    11bb:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    11be:	85 db                	test   %ebx,%ebx
    11c0:	7e 14                	jle    11d6 <memmove+0x26>
    n = n*10 + *s++ - '0';
  return n;
}

void*
memmove(void *vdst, void *vsrc, int n)
    11c2:	31 d2                	xor    %edx,%edx
    11c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    *dst++ = *src++;
    11c8:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
    11cc:	88 0c 10             	mov    %cl,(%eax,%edx,1)
    11cf:	83 c2 01             	add    $0x1,%edx
{
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    11d2:	39 da                	cmp    %ebx,%edx
    11d4:	75 f2                	jne    11c8 <memmove+0x18>
    *dst++ = *src++;
  return vdst;
}
    11d6:	5b                   	pop    %ebx
    11d7:	5e                   	pop    %esi
    11d8:	5d                   	pop    %ebp
    11d9:	c3                   	ret    
    11da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000011e0 <stat>:
  return buf;
}

int
stat(char *n, struct stat *st)
{
    11e0:	55                   	push   %ebp
    11e1:	89 e5                	mov    %esp,%ebp
    11e3:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    11e6:	8b 45 08             	mov    0x8(%ebp),%eax
  return buf;
}

int
stat(char *n, struct stat *st)
{
    11e9:	89 5d f8             	mov    %ebx,-0x8(%ebp)
    11ec:	89 75 fc             	mov    %esi,-0x4(%ebp)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    11ef:	be ff ff ff ff       	mov    $0xffffffff,%esi
stat(char *n, struct stat *st)
{
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    11f4:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    11fb:	00 
    11fc:	89 04 24             	mov    %eax,(%esp)
    11ff:	e8 d4 00 00 00       	call   12d8 <open>
  if(fd < 0)
    1204:	85 c0                	test   %eax,%eax
stat(char *n, struct stat *st)
{
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    1206:	89 c3                	mov    %eax,%ebx
  if(fd < 0)
    1208:	78 19                	js     1223 <stat+0x43>
    return -1;
  r = fstat(fd, st);
    120a:	8b 45 0c             	mov    0xc(%ebp),%eax
    120d:	89 1c 24             	mov    %ebx,(%esp)
    1210:	89 44 24 04          	mov    %eax,0x4(%esp)
    1214:	e8 d7 00 00 00       	call   12f0 <fstat>
  close(fd);
    1219:	89 1c 24             	mov    %ebx,(%esp)
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
  r = fstat(fd, st);
    121c:	89 c6                	mov    %eax,%esi
  close(fd);
    121e:	e8 9d 00 00 00       	call   12c0 <close>
  return r;
}
    1223:	89 f0                	mov    %esi,%eax
    1225:	8b 5d f8             	mov    -0x8(%ebp),%ebx
    1228:	8b 75 fc             	mov    -0x4(%ebp),%esi
    122b:	89 ec                	mov    %ebp,%esp
    122d:	5d                   	pop    %ebp
    122e:	c3                   	ret    
    122f:	90                   	nop

00001230 <gets>:
  return 0;
}

char*
gets(char *buf, int max)
{
    1230:	55                   	push   %ebp
    1231:	89 e5                	mov    %esp,%ebp
    1233:	57                   	push   %edi
    1234:	56                   	push   %esi
    1235:	31 f6                	xor    %esi,%esi
    1237:	53                   	push   %ebx
    1238:	83 ec 2c             	sub    $0x2c,%esp
    123b:	8b 7d 08             	mov    0x8(%ebp),%edi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    123e:	eb 06                	jmp    1246 <gets+0x16>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
    1240:	3c 0a                	cmp    $0xa,%al
    1242:	74 39                	je     127d <gets+0x4d>
    1244:	89 de                	mov    %ebx,%esi
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    1246:	8d 5e 01             	lea    0x1(%esi),%ebx
    1249:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
    124c:	7d 31                	jge    127f <gets+0x4f>
    cc = read(0, &c, 1);
    124e:	8d 45 e7             	lea    -0x19(%ebp),%eax
    1251:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    1258:	00 
    1259:	89 44 24 04          	mov    %eax,0x4(%esp)
    125d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1264:	e8 47 00 00 00       	call   12b0 <read>
    if(cc < 1)
    1269:	85 c0                	test   %eax,%eax
    126b:	7e 12                	jle    127f <gets+0x4f>
      break;
    buf[i++] = c;
    126d:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
    1271:	88 44 1f ff          	mov    %al,-0x1(%edi,%ebx,1)
    if(c == '\n' || c == '\r')
    1275:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
    1279:	3c 0d                	cmp    $0xd,%al
    127b:	75 c3                	jne    1240 <gets+0x10>
    127d:	89 de                	mov    %ebx,%esi
      break;
  }
  buf[i] = '\0';
    127f:	c6 04 37 00          	movb   $0x0,(%edi,%esi,1)
  return buf;
}
    1283:	89 f8                	mov    %edi,%eax
    1285:	83 c4 2c             	add    $0x2c,%esp
    1288:	5b                   	pop    %ebx
    1289:	5e                   	pop    %esi
    128a:	5f                   	pop    %edi
    128b:	5d                   	pop    %ebp
    128c:	c3                   	ret    
    128d:	90                   	nop
    128e:	90                   	nop
    128f:	90                   	nop

00001290 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    1290:	b8 01 00 00 00       	mov    $0x1,%eax
    1295:	cd 40                	int    $0x40
    1297:	c3                   	ret    

00001298 <exit>:
SYSCALL(exit)
    1298:	b8 02 00 00 00       	mov    $0x2,%eax
    129d:	cd 40                	int    $0x40
    129f:	c3                   	ret    

000012a0 <wait>:
SYSCALL(wait)
    12a0:	b8 03 00 00 00       	mov    $0x3,%eax
    12a5:	cd 40                	int    $0x40
    12a7:	c3                   	ret    

000012a8 <pipe>:
SYSCALL(pipe)
    12a8:	b8 04 00 00 00       	mov    $0x4,%eax
    12ad:	cd 40                	int    $0x40
    12af:	c3                   	ret    

000012b0 <read>:
SYSCALL(read)
    12b0:	b8 05 00 00 00       	mov    $0x5,%eax
    12b5:	cd 40                	int    $0x40
    12b7:	c3                   	ret    

000012b8 <write>:
SYSCALL(write)
    12b8:	b8 10 00 00 00       	mov    $0x10,%eax
    12bd:	cd 40                	int    $0x40
    12bf:	c3                   	ret    

000012c0 <close>:
SYSCALL(close)
    12c0:	b8 15 00 00 00       	mov    $0x15,%eax
    12c5:	cd 40                	int    $0x40
    12c7:	c3                   	ret    

000012c8 <kill>:
SYSCALL(kill)
    12c8:	b8 06 00 00 00       	mov    $0x6,%eax
    12cd:	cd 40                	int    $0x40
    12cf:	c3                   	ret    

000012d0 <exec>:
SYSCALL(exec)
    12d0:	b8 07 00 00 00       	mov    $0x7,%eax
    12d5:	cd 40                	int    $0x40
    12d7:	c3                   	ret    

000012d8 <open>:
SYSCALL(open)
    12d8:	b8 0f 00 00 00       	mov    $0xf,%eax
    12dd:	cd 40                	int    $0x40
    12df:	c3                   	ret    

000012e0 <mknod>:
SYSCALL(mknod)
    12e0:	b8 11 00 00 00       	mov    $0x11,%eax
    12e5:	cd 40                	int    $0x40
    12e7:	c3                   	ret    

000012e8 <unlink>:
SYSCALL(unlink)
    12e8:	b8 12 00 00 00       	mov    $0x12,%eax
    12ed:	cd 40                	int    $0x40
    12ef:	c3                   	ret    

000012f0 <fstat>:
SYSCALL(fstat)
    12f0:	b8 08 00 00 00       	mov    $0x8,%eax
    12f5:	cd 40                	int    $0x40
    12f7:	c3                   	ret    

000012f8 <link>:
SYSCALL(link)
    12f8:	b8 13 00 00 00       	mov    $0x13,%eax
    12fd:	cd 40                	int    $0x40
    12ff:	c3                   	ret    

00001300 <mkdir>:
SYSCALL(mkdir)
    1300:	b8 14 00 00 00       	mov    $0x14,%eax
    1305:	cd 40                	int    $0x40
    1307:	c3                   	ret    

00001308 <chdir>:
SYSCALL(chdir)
    1308:	b8 09 00 00 00       	mov    $0x9,%eax
    130d:	cd 40                	int    $0x40
    130f:	c3                   	ret    

00001310 <dup>:
SYSCALL(dup)
    1310:	b8 0a 00 00 00       	mov    $0xa,%eax
    1315:	cd 40                	int    $0x40
    1317:	c3                   	ret    

00001318 <getpid>:
SYSCALL(getpid)
    1318:	b8 0b 00 00 00       	mov    $0xb,%eax
    131d:	cd 40                	int    $0x40
    131f:	c3                   	ret    

00001320 <sbrk>:
SYSCALL(sbrk)
    1320:	b8 0c 00 00 00       	mov    $0xc,%eax
    1325:	cd 40                	int    $0x40
    1327:	c3                   	ret    

00001328 <sleep>:
SYSCALL(sleep)
    1328:	b8 0d 00 00 00       	mov    $0xd,%eax
    132d:	cd 40                	int    $0x40
    132f:	c3                   	ret    

00001330 <uptime>:
SYSCALL(uptime)
    1330:	b8 0e 00 00 00       	mov    $0xe,%eax
    1335:	cd 40                	int    $0x40
    1337:	c3                   	ret    

00001338 <hello>:
SYSCALL(hello)
    1338:	b8 16 00 00 00       	mov    $0x16,%eax
    133d:	cd 40                	int    $0x40
    133f:	c3                   	ret    

00001340 <waitpid>:
SYSCALL(waitpid)
    1340:	b8 17 00 00 00       	mov    $0x17,%eax
    1345:	cd 40                	int    $0x40
    1347:	c3                   	ret    

00001348 <setpriority>:
SYSCALL(setpriority)
    1348:	b8 18 00 00 00       	mov    $0x18,%eax
    134d:	cd 40                	int    $0x40
    134f:	c3                   	ret    

00001350 <v2p>:
SYSCALL(v2p)
    1350:	b8 19 00 00 00       	mov    $0x19,%eax
    1355:	cd 40                	int    $0x40
    1357:	c3                   	ret    
    1358:	90                   	nop
    1359:	90                   	nop
    135a:	90                   	nop
    135b:	90                   	nop
    135c:	90                   	nop
    135d:	90                   	nop
    135e:	90                   	nop
    135f:	90                   	nop

00001360 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
    1360:	55                   	push   %ebp
    1361:	89 e5                	mov    %esp,%ebp
    1363:	57                   	push   %edi
    1364:	89 cf                	mov    %ecx,%edi
    1366:	56                   	push   %esi
    1367:	89 c6                	mov    %eax,%esi
    1369:	53                   	push   %ebx
    136a:	83 ec 4c             	sub    $0x4c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    136d:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1370:	85 c9                	test   %ecx,%ecx
    1372:	74 04                	je     1378 <printint+0x18>
    1374:	85 d2                	test   %edx,%edx
    1376:	78 68                	js     13e0 <printint+0x80>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
    1378:	89 d0                	mov    %edx,%eax
    137a:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
    1381:	31 c9                	xor    %ecx,%ecx
    1383:	8d 5d d7             	lea    -0x29(%ebp),%ebx
    1386:	66 90                	xchg   %ax,%ax
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
    1388:	31 d2                	xor    %edx,%edx
    138a:	f7 f7                	div    %edi
    138c:	0f b6 92 71 17 00 00 	movzbl 0x1771(%edx),%edx
    1393:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
    1396:	83 c1 01             	add    $0x1,%ecx
  }while((x /= base) != 0);
    1399:	85 c0                	test   %eax,%eax
    139b:	75 eb                	jne    1388 <printint+0x28>
  if(neg)
    139d:	8b 45 c4             	mov    -0x3c(%ebp),%eax
    13a0:	85 c0                	test   %eax,%eax
    13a2:	74 08                	je     13ac <printint+0x4c>
    buf[i++] = '-';
    13a4:	c6 44 0d d7 2d       	movb   $0x2d,-0x29(%ebp,%ecx,1)
    13a9:	83 c1 01             	add    $0x1,%ecx

  while(--i >= 0)
    13ac:	8d 79 ff             	lea    -0x1(%ecx),%edi
    13af:	90                   	nop
    13b0:	0f b6 04 3b          	movzbl (%ebx,%edi,1),%eax
    13b4:	83 ef 01             	sub    $0x1,%edi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    13b7:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    13be:	00 
    13bf:	89 34 24             	mov    %esi,(%esp)
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
    13c2:	88 45 e7             	mov    %al,-0x19(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    13c5:	8d 45 e7             	lea    -0x19(%ebp),%eax
    13c8:	89 44 24 04          	mov    %eax,0x4(%esp)
    13cc:	e8 e7 fe ff ff       	call   12b8 <write>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
    13d1:	83 ff ff             	cmp    $0xffffffff,%edi
    13d4:	75 da                	jne    13b0 <printint+0x50>
    putc(fd, buf[i]);
}
    13d6:	83 c4 4c             	add    $0x4c,%esp
    13d9:	5b                   	pop    %ebx
    13da:	5e                   	pop    %esi
    13db:	5f                   	pop    %edi
    13dc:	5d                   	pop    %ebp
    13dd:	c3                   	ret    
    13de:	66 90                	xchg   %ax,%ax
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
    13e0:	89 d0                	mov    %edx,%eax
    13e2:	f7 d8                	neg    %eax
    13e4:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
    13eb:	eb 94                	jmp    1381 <printint+0x21>
    13ed:	8d 76 00             	lea    0x0(%esi),%esi

000013f0 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
    13f0:	55                   	push   %ebp
    13f1:	89 e5                	mov    %esp,%ebp
    13f3:	57                   	push   %edi
    13f4:	56                   	push   %esi
    13f5:	53                   	push   %ebx
    13f6:	83 ec 3c             	sub    $0x3c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    13f9:	8b 45 0c             	mov    0xc(%ebp),%eax
    13fc:	0f b6 10             	movzbl (%eax),%edx
    13ff:	84 d2                	test   %dl,%dl
    1401:	0f 84 c1 00 00 00    	je     14c8 <printf+0xd8>
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
    1407:	8d 4d 10             	lea    0x10(%ebp),%ecx
    140a:	31 ff                	xor    %edi,%edi
    140c:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
    140f:	31 db                	xor    %ebx,%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    1411:	8d 75 e7             	lea    -0x19(%ebp),%esi
    1414:	eb 1e                	jmp    1434 <printf+0x44>
    1416:	66 90                	xchg   %ax,%ax
  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
    1418:	83 fa 25             	cmp    $0x25,%edx
    141b:	0f 85 af 00 00 00    	jne    14d0 <printf+0xe0>
    1421:	66 bf 25 00          	mov    $0x25,%di
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    1425:	83 c3 01             	add    $0x1,%ebx
    1428:	0f b6 14 18          	movzbl (%eax,%ebx,1),%edx
    142c:	84 d2                	test   %dl,%dl
    142e:	0f 84 94 00 00 00    	je     14c8 <printf+0xd8>
    c = fmt[i] & 0xff;
    if(state == 0){
    1434:	85 ff                	test   %edi,%edi
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    1436:	0f b6 d2             	movzbl %dl,%edx
    if(state == 0){
    1439:	74 dd                	je     1418 <printf+0x28>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
    143b:	83 ff 25             	cmp    $0x25,%edi
    143e:	75 e5                	jne    1425 <printf+0x35>
      if(c == 'd'){
    1440:	83 fa 64             	cmp    $0x64,%edx
    1443:	0f 84 3f 01 00 00    	je     1588 <printf+0x198>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
    1449:	83 fa 70             	cmp    $0x70,%edx
    144c:	0f 84 a6 00 00 00    	je     14f8 <printf+0x108>
    1452:	83 fa 78             	cmp    $0x78,%edx
    1455:	0f 84 9d 00 00 00    	je     14f8 <printf+0x108>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
    145b:	83 fa 73             	cmp    $0x73,%edx
    145e:	66 90                	xchg   %ax,%ax
    1460:	0f 84 ba 00 00 00    	je     1520 <printf+0x130>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    1466:	83 fa 63             	cmp    $0x63,%edx
    1469:	0f 84 41 01 00 00    	je     15b0 <printf+0x1c0>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
    146f:	83 fa 25             	cmp    $0x25,%edx
    1472:	0f 84 00 01 00 00    	je     1578 <printf+0x188>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    1478:	8b 4d 08             	mov    0x8(%ebp),%ecx
    147b:	89 55 cc             	mov    %edx,-0x34(%ebp)
    147e:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
    1482:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    1489:	00 
    148a:	89 74 24 04          	mov    %esi,0x4(%esp)
    148e:	89 0c 24             	mov    %ecx,(%esp)
    1491:	e8 22 fe ff ff       	call   12b8 <write>
    1496:	8b 55 cc             	mov    -0x34(%ebp),%edx
    1499:	88 55 e7             	mov    %dl,-0x19(%ebp)
    149c:	8b 45 08             	mov    0x8(%ebp),%eax
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    149f:	83 c3 01             	add    $0x1,%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    14a2:	31 ff                	xor    %edi,%edi
    14a4:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    14ab:	00 
    14ac:	89 74 24 04          	mov    %esi,0x4(%esp)
    14b0:	89 04 24             	mov    %eax,(%esp)
    14b3:	e8 00 fe ff ff       	call   12b8 <write>
    14b8:	8b 45 0c             	mov    0xc(%ebp),%eax
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    14bb:	0f b6 14 18          	movzbl (%eax,%ebx,1),%edx
    14bf:	84 d2                	test   %dl,%dl
    14c1:	0f 85 6d ff ff ff    	jne    1434 <printf+0x44>
    14c7:	90                   	nop
        putc(fd, c);
      }
      state = 0;
    }
  }
}
    14c8:	83 c4 3c             	add    $0x3c,%esp
    14cb:	5b                   	pop    %ebx
    14cc:	5e                   	pop    %esi
    14cd:	5f                   	pop    %edi
    14ce:	5d                   	pop    %ebp
    14cf:	c3                   	ret    
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    14d0:	8b 45 08             	mov    0x8(%ebp),%eax
  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
    14d3:	88 55 e7             	mov    %dl,-0x19(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    14d6:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    14dd:	00 
    14de:	89 74 24 04          	mov    %esi,0x4(%esp)
    14e2:	89 04 24             	mov    %eax,(%esp)
    14e5:	e8 ce fd ff ff       	call   12b8 <write>
    14ea:	8b 45 0c             	mov    0xc(%ebp),%eax
    14ed:	e9 33 ff ff ff       	jmp    1425 <printf+0x35>
    14f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
    14f8:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    14fb:	b9 10 00 00 00       	mov    $0x10,%ecx
        ap++;
    1500:	31 ff                	xor    %edi,%edi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
    1502:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1509:	8b 10                	mov    (%eax),%edx
    150b:	8b 45 08             	mov    0x8(%ebp),%eax
    150e:	e8 4d fe ff ff       	call   1360 <printint>
    1513:	8b 45 0c             	mov    0xc(%ebp),%eax
        ap++;
    1516:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
    151a:	e9 06 ff ff ff       	jmp    1425 <printf+0x35>
    151f:	90                   	nop
      } else if(c == 's'){
        s = (char*)*ap;
    1520:	8b 55 d4             	mov    -0x2c(%ebp),%edx
        ap++;
        if(s == 0)
    1523:	b9 6a 17 00 00       	mov    $0x176a,%ecx
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
        s = (char*)*ap;
    1528:	8b 3a                	mov    (%edx),%edi
        ap++;
    152a:	83 c2 04             	add    $0x4,%edx
    152d:	89 55 d4             	mov    %edx,-0x2c(%ebp)
        if(s == 0)
    1530:	85 ff                	test   %edi,%edi
    1532:	0f 44 f9             	cmove  %ecx,%edi
          s = "(null)";
        while(*s != 0){
    1535:	0f b6 17             	movzbl (%edi),%edx
    1538:	84 d2                	test   %dl,%dl
    153a:	74 33                	je     156f <printf+0x17f>
    153c:	89 5d d0             	mov    %ebx,-0x30(%ebp)
    153f:	8b 5d 08             	mov    0x8(%ebp),%ebx
    1542:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
          putc(fd, *s);
          s++;
    1548:	83 c7 01             	add    $0x1,%edi
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
    154b:	88 55 e7             	mov    %dl,-0x19(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    154e:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    1555:	00 
    1556:	89 74 24 04          	mov    %esi,0x4(%esp)
    155a:	89 1c 24             	mov    %ebx,(%esp)
    155d:	e8 56 fd ff ff       	call   12b8 <write>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
    1562:	0f b6 17             	movzbl (%edi),%edx
    1565:	84 d2                	test   %dl,%dl
    1567:	75 df                	jne    1548 <printf+0x158>
    1569:	8b 5d d0             	mov    -0x30(%ebp),%ebx
    156c:	8b 45 0c             	mov    0xc(%ebp),%eax
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    156f:	31 ff                	xor    %edi,%edi
    1571:	e9 af fe ff ff       	jmp    1425 <printf+0x35>
    1576:	66 90                	xchg   %ax,%ax
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
    1578:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
    157c:	e9 1b ff ff ff       	jmp    149c <printf+0xac>
    1581:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
    1588:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    158b:	b9 0a 00 00 00       	mov    $0xa,%ecx
        ap++;
    1590:	66 31 ff             	xor    %di,%di
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
    1593:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    159a:	8b 10                	mov    (%eax),%edx
    159c:	8b 45 08             	mov    0x8(%ebp),%eax
    159f:	e8 bc fd ff ff       	call   1360 <printint>
    15a4:	8b 45 0c             	mov    0xc(%ebp),%eax
        ap++;
    15a7:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
    15ab:	e9 75 fe ff ff       	jmp    1425 <printf+0x35>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    15b0:	8b 55 d4             	mov    -0x2c(%ebp),%edx
        putc(fd, *ap);
        ap++;
    15b3:	31 ff                	xor    %edi,%edi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    15b5:	8b 4d 08             	mov    0x8(%ebp),%ecx
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    15b8:	8b 02                	mov    (%edx),%eax
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    15ba:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    15c1:	00 
    15c2:	89 74 24 04          	mov    %esi,0x4(%esp)
    15c6:	89 0c 24             	mov    %ecx,(%esp)
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    15c9:	88 45 e7             	mov    %al,-0x19(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    15cc:	e8 e7 fc ff ff       	call   12b8 <write>
    15d1:	8b 45 0c             	mov    0xc(%ebp),%eax
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
        ap++;
    15d4:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
    15d8:	e9 48 fe ff ff       	jmp    1425 <printf+0x35>
    15dd:	90                   	nop
    15de:	90                   	nop
    15df:	90                   	nop

000015e0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    15e0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    15e1:	a1 8c 17 00 00       	mov    0x178c,%eax
static Header base;
static Header *freep;

void
free(void *ap)
{
    15e6:	89 e5                	mov    %esp,%ebp
    15e8:	57                   	push   %edi
    15e9:	56                   	push   %esi
    15ea:	53                   	push   %ebx
    15eb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
    15ee:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    15f1:	39 c8                	cmp    %ecx,%eax
    15f3:	73 1d                	jae    1612 <free+0x32>
    15f5:	8d 76 00             	lea    0x0(%esi),%esi
    15f8:	8b 10                	mov    (%eax),%edx
    15fa:	39 d1                	cmp    %edx,%ecx
    15fc:	72 1a                	jb     1618 <free+0x38>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    15fe:	39 d0                	cmp    %edx,%eax
    1600:	72 08                	jb     160a <free+0x2a>
    1602:	39 c8                	cmp    %ecx,%eax
    1604:	72 12                	jb     1618 <free+0x38>
    1606:	39 d1                	cmp    %edx,%ecx
    1608:	72 0e                	jb     1618 <free+0x38>
    160a:	89 d0                	mov    %edx,%eax
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    160c:	39 c8                	cmp    %ecx,%eax
    160e:	66 90                	xchg   %ax,%ax
    1610:	72 e6                	jb     15f8 <free+0x18>
    1612:	8b 10                	mov    (%eax),%edx
    1614:	eb e8                	jmp    15fe <free+0x1e>
    1616:	66 90                	xchg   %ax,%ax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    1618:	8b 71 04             	mov    0x4(%ecx),%esi
    161b:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    161e:	39 d7                	cmp    %edx,%edi
    1620:	74 19                	je     163b <free+0x5b>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
    1622:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    1625:	8b 50 04             	mov    0x4(%eax),%edx
    1628:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    162b:	39 ce                	cmp    %ecx,%esi
    162d:	74 23                	je     1652 <free+0x72>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
    162f:	89 08                	mov    %ecx,(%eax)
  freep = p;
    1631:	a3 8c 17 00 00       	mov    %eax,0x178c
}
    1636:	5b                   	pop    %ebx
    1637:	5e                   	pop    %esi
    1638:	5f                   	pop    %edi
    1639:	5d                   	pop    %ebp
    163a:	c3                   	ret    
  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
    163b:	03 72 04             	add    0x4(%edx),%esi
    163e:	89 71 04             	mov    %esi,0x4(%ecx)
    bp->s.ptr = p->s.ptr->s.ptr;
    1641:	8b 10                	mov    (%eax),%edx
    1643:	8b 12                	mov    (%edx),%edx
    1645:	89 53 f8             	mov    %edx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    1648:	8b 50 04             	mov    0x4(%eax),%edx
    164b:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    164e:	39 ce                	cmp    %ecx,%esi
    1650:	75 dd                	jne    162f <free+0x4f>
    p->s.size += bp->s.size;
    1652:	03 51 04             	add    0x4(%ecx),%edx
    1655:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    1658:	8b 53 f8             	mov    -0x8(%ebx),%edx
    165b:	89 10                	mov    %edx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
    165d:	a3 8c 17 00 00       	mov    %eax,0x178c
}
    1662:	5b                   	pop    %ebx
    1663:	5e                   	pop    %esi
    1664:	5f                   	pop    %edi
    1665:	5d                   	pop    %ebp
    1666:	c3                   	ret    
    1667:	89 f6                	mov    %esi,%esi
    1669:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001670 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    1670:	55                   	push   %ebp
    1671:	89 e5                	mov    %esp,%ebp
    1673:	57                   	push   %edi
    1674:	56                   	push   %esi
    1675:	53                   	push   %ebx
    1676:	83 ec 2c             	sub    $0x2c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1679:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if((prevp = freep) == 0){
    167c:	8b 0d 8c 17 00 00    	mov    0x178c,%ecx
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1682:	83 c3 07             	add    $0x7,%ebx
    1685:	c1 eb 03             	shr    $0x3,%ebx
    1688:	83 c3 01             	add    $0x1,%ebx
  if((prevp = freep) == 0){
    168b:	85 c9                	test   %ecx,%ecx
    168d:	0f 84 9b 00 00 00    	je     172e <malloc+0xbe>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1693:	8b 01                	mov    (%ecx),%eax
    if(p->s.size >= nunits){
    1695:	8b 50 04             	mov    0x4(%eax),%edx
    1698:	39 d3                	cmp    %edx,%ebx
    169a:	76 27                	jbe    16c3 <malloc+0x53>
        p->s.size -= nunits;
        p += p->s.size;
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    169c:	8d 3c dd 00 00 00 00 	lea    0x0(,%ebx,8),%edi
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < 4096)
    16a3:	be 00 80 00 00       	mov    $0x8000,%esi
    16a8:	89 7d e4             	mov    %edi,-0x1c(%ebp)
    16ab:	90                   	nop
    16ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    16b0:	3b 05 8c 17 00 00    	cmp    0x178c,%eax
    16b6:	74 30                	je     16e8 <malloc+0x78>
    16b8:	89 c1                	mov    %eax,%ecx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    16ba:	8b 01                	mov    (%ecx),%eax
    if(p->s.size >= nunits){
    16bc:	8b 50 04             	mov    0x4(%eax),%edx
    16bf:	39 d3                	cmp    %edx,%ebx
    16c1:	77 ed                	ja     16b0 <malloc+0x40>
      if(p->s.size == nunits)
    16c3:	39 d3                	cmp    %edx,%ebx
    16c5:	74 61                	je     1728 <malloc+0xb8>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
    16c7:	29 da                	sub    %ebx,%edx
    16c9:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
    16cc:	8d 04 d0             	lea    (%eax,%edx,8),%eax
        p->s.size = nunits;
    16cf:	89 58 04             	mov    %ebx,0x4(%eax)
      }
      freep = prevp;
    16d2:	89 0d 8c 17 00 00    	mov    %ecx,0x178c
      return (void*)(p + 1);
    16d8:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
    16db:	83 c4 2c             	add    $0x2c,%esp
    16de:	5b                   	pop    %ebx
    16df:	5e                   	pop    %esi
    16e0:	5f                   	pop    %edi
    16e1:	5d                   	pop    %ebp
    16e2:	c3                   	ret    
    16e3:	90                   	nop
    16e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < 4096)
    16e8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    16eb:	81 fb 00 10 00 00    	cmp    $0x1000,%ebx
    16f1:	bf 00 10 00 00       	mov    $0x1000,%edi
    16f6:	0f 43 fb             	cmovae %ebx,%edi
    16f9:	0f 42 c6             	cmovb  %esi,%eax
    nu = 4096;
  p = sbrk(nu * sizeof(Header));
    16fc:	89 04 24             	mov    %eax,(%esp)
    16ff:	e8 1c fc ff ff       	call   1320 <sbrk>
  if(p == (char*)-1)
    1704:	83 f8 ff             	cmp    $0xffffffff,%eax
    1707:	74 18                	je     1721 <malloc+0xb1>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
    1709:	89 78 04             	mov    %edi,0x4(%eax)
  free((void*)(hp + 1));
    170c:	83 c0 08             	add    $0x8,%eax
    170f:	89 04 24             	mov    %eax,(%esp)
    1712:	e8 c9 fe ff ff       	call   15e0 <free>
  return freep;
    1717:	8b 0d 8c 17 00 00    	mov    0x178c,%ecx
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
    171d:	85 c9                	test   %ecx,%ecx
    171f:	75 99                	jne    16ba <malloc+0x4a>
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
    1721:	31 c0                	xor    %eax,%eax
    1723:	eb b6                	jmp    16db <malloc+0x6b>
    1725:	8d 76 00             	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
    1728:	8b 10                	mov    (%eax),%edx
    172a:	89 11                	mov    %edx,(%ecx)
    172c:	eb a4                	jmp    16d2 <malloc+0x62>
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    172e:	c7 05 8c 17 00 00 84 	movl   $0x1784,0x178c
    1735:	17 00 00 
    base.s.size = 0;
    1738:	b9 84 17 00 00       	mov    $0x1784,%ecx
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    173d:	c7 05 84 17 00 00 84 	movl   $0x1784,0x1784
    1744:	17 00 00 
    base.s.size = 0;
    1747:	c7 05 88 17 00 00 00 	movl   $0x0,0x1788
    174e:	00 00 00 
    1751:	e9 3d ff ff ff       	jmp    1693 <malloc+0x23>
