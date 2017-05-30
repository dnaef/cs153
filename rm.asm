
_rm:     file format elf32-i386


Disassembly of section .text:

00001000 <main>:
#include "stat.h"
#include "user.h"

int
main(int argc, char *argv[])
{
    1000:	55                   	push   %ebp
    1001:	89 e5                	mov    %esp,%ebp
    1003:	83 e4 f0             	and    $0xfffffff0,%esp
    1006:	57                   	push   %edi
    1007:	56                   	push   %esi
    1008:	53                   	push   %ebx
    1009:	83 ec 14             	sub    $0x14,%esp
    100c:	8b 7d 08             	mov    0x8(%ebp),%edi
  int i;

  if(argc < 2){
    100f:	83 ff 01             	cmp    $0x1,%edi
    1012:	7e 5c                	jle    1070 <main+0x70>
    printf(2, "Usage: rm files...\n");
    exit(0);
    1014:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    1017:	be 01 00 00 00       	mov    $0x1,%esi
    101c:	83 c3 04             	add    $0x4,%ebx
    101f:	90                   	nop
  }

  for(i = 1; i < argc; i++){
    if(unlink(argv[i]) < 0){
    1020:	8b 03                	mov    (%ebx),%eax
    1022:	89 04 24             	mov    %eax,(%esp)
    1025:	e8 de 02 00 00       	call   1308 <unlink>
    102a:	85 c0                	test   %eax,%eax
    102c:	78 1a                	js     1048 <main+0x48>
  if(argc < 2){
    printf(2, "Usage: rm files...\n");
    exit(0);
  }

  for(i = 1; i < argc; i++){
    102e:	83 c6 01             	add    $0x1,%esi
    1031:	83 c3 04             	add    $0x4,%ebx
    1034:	39 f7                	cmp    %esi,%edi
    1036:	7f e8                	jg     1020 <main+0x20>
      printf(2, "rm: %s failed to delete\n", argv[i]);
      break;
    }
  }

  exit(0);
    1038:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    103f:	e8 74 02 00 00       	call   12b8 <exit>
    1044:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    exit(0);
  }

  for(i = 1; i < argc; i++){
    if(unlink(argv[i]) < 0){
      printf(2, "rm: %s failed to delete\n", argv[i]);
    1048:	8b 03                	mov    (%ebx),%eax
    104a:	c7 44 24 04 8a 17 00 	movl   $0x178a,0x4(%esp)
    1051:	00 
    1052:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
    1059:	89 44 24 08          	mov    %eax,0x8(%esp)
    105d:	e8 ae 03 00 00       	call   1410 <printf>
      break;
    }
  }

  exit(0);
    1062:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1069:	e8 4a 02 00 00       	call   12b8 <exit>
    106e:	66 90                	xchg   %ax,%ax
main(int argc, char *argv[])
{
  int i;

  if(argc < 2){
    printf(2, "Usage: rm files...\n");
    1070:	c7 44 24 04 76 17 00 	movl   $0x1776,0x4(%esp)
    1077:	00 
    1078:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
    107f:	e8 8c 03 00 00       	call   1410 <printf>
    exit(0);
    1084:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    108b:	e8 28 02 00 00       	call   12b8 <exit>

00001090 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
    1090:	55                   	push   %ebp
    1091:	31 d2                	xor    %edx,%edx
    1093:	89 e5                	mov    %esp,%ebp
    1095:	8b 45 08             	mov    0x8(%ebp),%eax
    1098:	53                   	push   %ebx
    1099:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    109c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
    10a0:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
    10a4:	88 0c 10             	mov    %cl,(%eax,%edx,1)
    10a7:	83 c2 01             	add    $0x1,%edx
    10aa:	84 c9                	test   %cl,%cl
    10ac:	75 f2                	jne    10a0 <strcpy+0x10>
    ;
  return os;
}
    10ae:	5b                   	pop    %ebx
    10af:	5d                   	pop    %ebp
    10b0:	c3                   	ret    
    10b1:	eb 0d                	jmp    10c0 <strcmp>
    10b3:	90                   	nop
    10b4:	90                   	nop
    10b5:	90                   	nop
    10b6:	90                   	nop
    10b7:	90                   	nop
    10b8:	90                   	nop
    10b9:	90                   	nop
    10ba:	90                   	nop
    10bb:	90                   	nop
    10bc:	90                   	nop
    10bd:	90                   	nop
    10be:	90                   	nop
    10bf:	90                   	nop

000010c0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    10c0:	55                   	push   %ebp
    10c1:	89 e5                	mov    %esp,%ebp
    10c3:	8b 4d 08             	mov    0x8(%ebp),%ecx
    10c6:	53                   	push   %ebx
    10c7:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(*p && *p == *q)
    10ca:	0f b6 01             	movzbl (%ecx),%eax
    10cd:	84 c0                	test   %al,%al
    10cf:	75 14                	jne    10e5 <strcmp+0x25>
    10d1:	eb 25                	jmp    10f8 <strcmp+0x38>
    10d3:	90                   	nop
    10d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    p++, q++;
    10d8:	83 c1 01             	add    $0x1,%ecx
    10db:	83 c2 01             	add    $0x1,%edx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
    10de:	0f b6 01             	movzbl (%ecx),%eax
    10e1:	84 c0                	test   %al,%al
    10e3:	74 13                	je     10f8 <strcmp+0x38>
    10e5:	0f b6 1a             	movzbl (%edx),%ebx
    10e8:	38 d8                	cmp    %bl,%al
    10ea:	74 ec                	je     10d8 <strcmp+0x18>
    10ec:	0f b6 db             	movzbl %bl,%ebx
    10ef:	0f b6 c0             	movzbl %al,%eax
    10f2:	29 d8                	sub    %ebx,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
    10f4:	5b                   	pop    %ebx
    10f5:	5d                   	pop    %ebp
    10f6:	c3                   	ret    
    10f7:	90                   	nop
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
    10f8:	0f b6 1a             	movzbl (%edx),%ebx
    10fb:	31 c0                	xor    %eax,%eax
    10fd:	0f b6 db             	movzbl %bl,%ebx
    1100:	29 d8                	sub    %ebx,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
    1102:	5b                   	pop    %ebx
    1103:	5d                   	pop    %ebp
    1104:	c3                   	ret    
    1105:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1109:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001110 <strlen>:

uint
strlen(char *s)
{
    1110:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
    1111:	31 d2                	xor    %edx,%edx
  return (uchar)*p - (uchar)*q;
}

uint
strlen(char *s)
{
    1113:	89 e5                	mov    %esp,%ebp
  int n;

  for(n = 0; s[n]; n++)
    1115:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
}

uint
strlen(char *s)
{
    1117:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
    111a:	80 39 00             	cmpb   $0x0,(%ecx)
    111d:	74 0c                	je     112b <strlen+0x1b>
    111f:	90                   	nop
    1120:	83 c2 01             	add    $0x1,%edx
    1123:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
    1127:	89 d0                	mov    %edx,%eax
    1129:	75 f5                	jne    1120 <strlen+0x10>
    ;
  return n;
}
    112b:	5d                   	pop    %ebp
    112c:	c3                   	ret    
    112d:	8d 76 00             	lea    0x0(%esi),%esi

00001130 <memset>:

void*
memset(void *dst, int c, uint n)
{
    1130:	55                   	push   %ebp
    1131:	89 e5                	mov    %esp,%ebp
    1133:	8b 55 08             	mov    0x8(%ebp),%edx
    1136:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
    1137:	8b 4d 10             	mov    0x10(%ebp),%ecx
    113a:	8b 45 0c             	mov    0xc(%ebp),%eax
    113d:	89 d7                	mov    %edx,%edi
    113f:	fc                   	cld    
    1140:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
    1142:	89 d0                	mov    %edx,%eax
    1144:	5f                   	pop    %edi
    1145:	5d                   	pop    %ebp
    1146:	c3                   	ret    
    1147:	89 f6                	mov    %esi,%esi
    1149:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001150 <strchr>:

char*
strchr(const char *s, char c)
{
    1150:	55                   	push   %ebp
    1151:	89 e5                	mov    %esp,%ebp
    1153:	8b 45 08             	mov    0x8(%ebp),%eax
    1156:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
    115a:	0f b6 10             	movzbl (%eax),%edx
    115d:	84 d2                	test   %dl,%dl
    115f:	75 11                	jne    1172 <strchr+0x22>
    1161:	eb 15                	jmp    1178 <strchr+0x28>
    1163:	90                   	nop
    1164:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1168:	83 c0 01             	add    $0x1,%eax
    116b:	0f b6 10             	movzbl (%eax),%edx
    116e:	84 d2                	test   %dl,%dl
    1170:	74 06                	je     1178 <strchr+0x28>
    if(*s == c)
    1172:	38 ca                	cmp    %cl,%dl
    1174:	75 f2                	jne    1168 <strchr+0x18>
      return (char*)s;
  return 0;
}
    1176:	5d                   	pop    %ebp
    1177:	c3                   	ret    
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
    1178:	31 c0                	xor    %eax,%eax
    if(*s == c)
      return (char*)s;
  return 0;
}
    117a:	5d                   	pop    %ebp
    117b:	90                   	nop
    117c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1180:	c3                   	ret    
    1181:	eb 0d                	jmp    1190 <atoi>
    1183:	90                   	nop
    1184:	90                   	nop
    1185:	90                   	nop
    1186:	90                   	nop
    1187:	90                   	nop
    1188:	90                   	nop
    1189:	90                   	nop
    118a:	90                   	nop
    118b:	90                   	nop
    118c:	90                   	nop
    118d:	90                   	nop
    118e:	90                   	nop
    118f:	90                   	nop

00001190 <atoi>:
  return r;
}

int
atoi(const char *s)
{
    1190:	55                   	push   %ebp
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    1191:	31 c0                	xor    %eax,%eax
  return r;
}

int
atoi(const char *s)
{
    1193:	89 e5                	mov    %esp,%ebp
    1195:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1198:	53                   	push   %ebx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    1199:	0f b6 11             	movzbl (%ecx),%edx
    119c:	8d 5a d0             	lea    -0x30(%edx),%ebx
    119f:	80 fb 09             	cmp    $0x9,%bl
    11a2:	77 1c                	ja     11c0 <atoi+0x30>
    11a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    n = n*10 + *s++ - '0';
    11a8:	0f be d2             	movsbl %dl,%edx
    11ab:	83 c1 01             	add    $0x1,%ecx
    11ae:	8d 04 80             	lea    (%eax,%eax,4),%eax
    11b1:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    11b5:	0f b6 11             	movzbl (%ecx),%edx
    11b8:	8d 5a d0             	lea    -0x30(%edx),%ebx
    11bb:	80 fb 09             	cmp    $0x9,%bl
    11be:	76 e8                	jbe    11a8 <atoi+0x18>
    n = n*10 + *s++ - '0';
  return n;
}
    11c0:	5b                   	pop    %ebx
    11c1:	5d                   	pop    %ebp
    11c2:	c3                   	ret    
    11c3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    11c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000011d0 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
    11d0:	55                   	push   %ebp
    11d1:	89 e5                	mov    %esp,%ebp
    11d3:	56                   	push   %esi
    11d4:	8b 45 08             	mov    0x8(%ebp),%eax
    11d7:	53                   	push   %ebx
    11d8:	8b 5d 10             	mov    0x10(%ebp),%ebx
    11db:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    11de:	85 db                	test   %ebx,%ebx
    11e0:	7e 14                	jle    11f6 <memmove+0x26>
    n = n*10 + *s++ - '0';
  return n;
}

void*
memmove(void *vdst, void *vsrc, int n)
    11e2:	31 d2                	xor    %edx,%edx
    11e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    *dst++ = *src++;
    11e8:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
    11ec:	88 0c 10             	mov    %cl,(%eax,%edx,1)
    11ef:	83 c2 01             	add    $0x1,%edx
{
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    11f2:	39 da                	cmp    %ebx,%edx
    11f4:	75 f2                	jne    11e8 <memmove+0x18>
    *dst++ = *src++;
  return vdst;
}
    11f6:	5b                   	pop    %ebx
    11f7:	5e                   	pop    %esi
    11f8:	5d                   	pop    %ebp
    11f9:	c3                   	ret    
    11fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00001200 <stat>:
  return buf;
}

int
stat(char *n, struct stat *st)
{
    1200:	55                   	push   %ebp
    1201:	89 e5                	mov    %esp,%ebp
    1203:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    1206:	8b 45 08             	mov    0x8(%ebp),%eax
  return buf;
}

int
stat(char *n, struct stat *st)
{
    1209:	89 5d f8             	mov    %ebx,-0x8(%ebp)
    120c:	89 75 fc             	mov    %esi,-0x4(%ebp)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    120f:	be ff ff ff ff       	mov    $0xffffffff,%esi
stat(char *n, struct stat *st)
{
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    1214:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    121b:	00 
    121c:	89 04 24             	mov    %eax,(%esp)
    121f:	e8 d4 00 00 00       	call   12f8 <open>
  if(fd < 0)
    1224:	85 c0                	test   %eax,%eax
stat(char *n, struct stat *st)
{
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    1226:	89 c3                	mov    %eax,%ebx
  if(fd < 0)
    1228:	78 19                	js     1243 <stat+0x43>
    return -1;
  r = fstat(fd, st);
    122a:	8b 45 0c             	mov    0xc(%ebp),%eax
    122d:	89 1c 24             	mov    %ebx,(%esp)
    1230:	89 44 24 04          	mov    %eax,0x4(%esp)
    1234:	e8 d7 00 00 00       	call   1310 <fstat>
  close(fd);
    1239:	89 1c 24             	mov    %ebx,(%esp)
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
  r = fstat(fd, st);
    123c:	89 c6                	mov    %eax,%esi
  close(fd);
    123e:	e8 9d 00 00 00       	call   12e0 <close>
  return r;
}
    1243:	89 f0                	mov    %esi,%eax
    1245:	8b 5d f8             	mov    -0x8(%ebp),%ebx
    1248:	8b 75 fc             	mov    -0x4(%ebp),%esi
    124b:	89 ec                	mov    %ebp,%esp
    124d:	5d                   	pop    %ebp
    124e:	c3                   	ret    
    124f:	90                   	nop

00001250 <gets>:
  return 0;
}

char*
gets(char *buf, int max)
{
    1250:	55                   	push   %ebp
    1251:	89 e5                	mov    %esp,%ebp
    1253:	57                   	push   %edi
    1254:	56                   	push   %esi
    1255:	31 f6                	xor    %esi,%esi
    1257:	53                   	push   %ebx
    1258:	83 ec 2c             	sub    $0x2c,%esp
    125b:	8b 7d 08             	mov    0x8(%ebp),%edi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    125e:	eb 06                	jmp    1266 <gets+0x16>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
    1260:	3c 0a                	cmp    $0xa,%al
    1262:	74 39                	je     129d <gets+0x4d>
    1264:	89 de                	mov    %ebx,%esi
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    1266:	8d 5e 01             	lea    0x1(%esi),%ebx
    1269:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
    126c:	7d 31                	jge    129f <gets+0x4f>
    cc = read(0, &c, 1);
    126e:	8d 45 e7             	lea    -0x19(%ebp),%eax
    1271:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    1278:	00 
    1279:	89 44 24 04          	mov    %eax,0x4(%esp)
    127d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1284:	e8 47 00 00 00       	call   12d0 <read>
    if(cc < 1)
    1289:	85 c0                	test   %eax,%eax
    128b:	7e 12                	jle    129f <gets+0x4f>
      break;
    buf[i++] = c;
    128d:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
    1291:	88 44 1f ff          	mov    %al,-0x1(%edi,%ebx,1)
    if(c == '\n' || c == '\r')
    1295:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
    1299:	3c 0d                	cmp    $0xd,%al
    129b:	75 c3                	jne    1260 <gets+0x10>
    129d:	89 de                	mov    %ebx,%esi
      break;
  }
  buf[i] = '\0';
    129f:	c6 04 37 00          	movb   $0x0,(%edi,%esi,1)
  return buf;
}
    12a3:	89 f8                	mov    %edi,%eax
    12a5:	83 c4 2c             	add    $0x2c,%esp
    12a8:	5b                   	pop    %ebx
    12a9:	5e                   	pop    %esi
    12aa:	5f                   	pop    %edi
    12ab:	5d                   	pop    %ebp
    12ac:	c3                   	ret    
    12ad:	90                   	nop
    12ae:	90                   	nop
    12af:	90                   	nop

000012b0 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    12b0:	b8 01 00 00 00       	mov    $0x1,%eax
    12b5:	cd 40                	int    $0x40
    12b7:	c3                   	ret    

000012b8 <exit>:
SYSCALL(exit)
    12b8:	b8 02 00 00 00       	mov    $0x2,%eax
    12bd:	cd 40                	int    $0x40
    12bf:	c3                   	ret    

000012c0 <wait>:
SYSCALL(wait)
    12c0:	b8 03 00 00 00       	mov    $0x3,%eax
    12c5:	cd 40                	int    $0x40
    12c7:	c3                   	ret    

000012c8 <pipe>:
SYSCALL(pipe)
    12c8:	b8 04 00 00 00       	mov    $0x4,%eax
    12cd:	cd 40                	int    $0x40
    12cf:	c3                   	ret    

000012d0 <read>:
SYSCALL(read)
    12d0:	b8 05 00 00 00       	mov    $0x5,%eax
    12d5:	cd 40                	int    $0x40
    12d7:	c3                   	ret    

000012d8 <write>:
SYSCALL(write)
    12d8:	b8 10 00 00 00       	mov    $0x10,%eax
    12dd:	cd 40                	int    $0x40
    12df:	c3                   	ret    

000012e0 <close>:
SYSCALL(close)
    12e0:	b8 15 00 00 00       	mov    $0x15,%eax
    12e5:	cd 40                	int    $0x40
    12e7:	c3                   	ret    

000012e8 <kill>:
SYSCALL(kill)
    12e8:	b8 06 00 00 00       	mov    $0x6,%eax
    12ed:	cd 40                	int    $0x40
    12ef:	c3                   	ret    

000012f0 <exec>:
SYSCALL(exec)
    12f0:	b8 07 00 00 00       	mov    $0x7,%eax
    12f5:	cd 40                	int    $0x40
    12f7:	c3                   	ret    

000012f8 <open>:
SYSCALL(open)
    12f8:	b8 0f 00 00 00       	mov    $0xf,%eax
    12fd:	cd 40                	int    $0x40
    12ff:	c3                   	ret    

00001300 <mknod>:
SYSCALL(mknod)
    1300:	b8 11 00 00 00       	mov    $0x11,%eax
    1305:	cd 40                	int    $0x40
    1307:	c3                   	ret    

00001308 <unlink>:
SYSCALL(unlink)
    1308:	b8 12 00 00 00       	mov    $0x12,%eax
    130d:	cd 40                	int    $0x40
    130f:	c3                   	ret    

00001310 <fstat>:
SYSCALL(fstat)
    1310:	b8 08 00 00 00       	mov    $0x8,%eax
    1315:	cd 40                	int    $0x40
    1317:	c3                   	ret    

00001318 <link>:
SYSCALL(link)
    1318:	b8 13 00 00 00       	mov    $0x13,%eax
    131d:	cd 40                	int    $0x40
    131f:	c3                   	ret    

00001320 <mkdir>:
SYSCALL(mkdir)
    1320:	b8 14 00 00 00       	mov    $0x14,%eax
    1325:	cd 40                	int    $0x40
    1327:	c3                   	ret    

00001328 <chdir>:
SYSCALL(chdir)
    1328:	b8 09 00 00 00       	mov    $0x9,%eax
    132d:	cd 40                	int    $0x40
    132f:	c3                   	ret    

00001330 <dup>:
SYSCALL(dup)
    1330:	b8 0a 00 00 00       	mov    $0xa,%eax
    1335:	cd 40                	int    $0x40
    1337:	c3                   	ret    

00001338 <getpid>:
SYSCALL(getpid)
    1338:	b8 0b 00 00 00       	mov    $0xb,%eax
    133d:	cd 40                	int    $0x40
    133f:	c3                   	ret    

00001340 <sbrk>:
SYSCALL(sbrk)
    1340:	b8 0c 00 00 00       	mov    $0xc,%eax
    1345:	cd 40                	int    $0x40
    1347:	c3                   	ret    

00001348 <sleep>:
SYSCALL(sleep)
    1348:	b8 0d 00 00 00       	mov    $0xd,%eax
    134d:	cd 40                	int    $0x40
    134f:	c3                   	ret    

00001350 <uptime>:
SYSCALL(uptime)
    1350:	b8 0e 00 00 00       	mov    $0xe,%eax
    1355:	cd 40                	int    $0x40
    1357:	c3                   	ret    

00001358 <hello>:
SYSCALL(hello) 			// added for Lab0
    1358:	b8 16 00 00 00       	mov    $0x16,%eax
    135d:	cd 40                	int    $0x40
    135f:	c3                   	ret    

00001360 <waitpid>:
SYSCALL(waitpid) 		// lab1 part 1: c
    1360:	b8 17 00 00 00       	mov    $0x17,%eax
    1365:	cd 40                	int    $0x40
    1367:	c3                   	ret    

00001368 <setpriority>:
SYSCALL(setpriority) 	// lab1 part 2: define syscall
    1368:	b8 18 00 00 00       	mov    $0x18,%eax
    136d:	cd 40                	int    $0x40
    136f:	c3                   	ret    

00001370 <v2p>:
SYSCALL(v2p)			// lab2
    1370:	b8 19 00 00 00       	mov    $0x19,%eax
    1375:	cd 40                	int    $0x40
    1377:	c3                   	ret    
    1378:	90                   	nop
    1379:	90                   	nop
    137a:	90                   	nop
    137b:	90                   	nop
    137c:	90                   	nop
    137d:	90                   	nop
    137e:	90                   	nop
    137f:	90                   	nop

00001380 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
    1380:	55                   	push   %ebp
    1381:	89 e5                	mov    %esp,%ebp
    1383:	57                   	push   %edi
    1384:	89 cf                	mov    %ecx,%edi
    1386:	56                   	push   %esi
    1387:	89 c6                	mov    %eax,%esi
    1389:	53                   	push   %ebx
    138a:	83 ec 4c             	sub    $0x4c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    138d:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1390:	85 c9                	test   %ecx,%ecx
    1392:	74 04                	je     1398 <printint+0x18>
    1394:	85 d2                	test   %edx,%edx
    1396:	78 68                	js     1400 <printint+0x80>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
    1398:	89 d0                	mov    %edx,%eax
    139a:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
    13a1:	31 c9                	xor    %ecx,%ecx
    13a3:	8d 5d d7             	lea    -0x29(%ebp),%ebx
    13a6:	66 90                	xchg   %ax,%ax
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
    13a8:	31 d2                	xor    %edx,%edx
    13aa:	f7 f7                	div    %edi
    13ac:	0f b6 92 aa 17 00 00 	movzbl 0x17aa(%edx),%edx
    13b3:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
    13b6:	83 c1 01             	add    $0x1,%ecx
  }while((x /= base) != 0);
    13b9:	85 c0                	test   %eax,%eax
    13bb:	75 eb                	jne    13a8 <printint+0x28>
  if(neg)
    13bd:	8b 45 c4             	mov    -0x3c(%ebp),%eax
    13c0:	85 c0                	test   %eax,%eax
    13c2:	74 08                	je     13cc <printint+0x4c>
    buf[i++] = '-';
    13c4:	c6 44 0d d7 2d       	movb   $0x2d,-0x29(%ebp,%ecx,1)
    13c9:	83 c1 01             	add    $0x1,%ecx

  while(--i >= 0)
    13cc:	8d 79 ff             	lea    -0x1(%ecx),%edi
    13cf:	90                   	nop
    13d0:	0f b6 04 3b          	movzbl (%ebx,%edi,1),%eax
    13d4:	83 ef 01             	sub    $0x1,%edi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    13d7:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    13de:	00 
    13df:	89 34 24             	mov    %esi,(%esp)
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
    13e2:	88 45 e7             	mov    %al,-0x19(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    13e5:	8d 45 e7             	lea    -0x19(%ebp),%eax
    13e8:	89 44 24 04          	mov    %eax,0x4(%esp)
    13ec:	e8 e7 fe ff ff       	call   12d8 <write>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
    13f1:	83 ff ff             	cmp    $0xffffffff,%edi
    13f4:	75 da                	jne    13d0 <printint+0x50>
    putc(fd, buf[i]);
}
    13f6:	83 c4 4c             	add    $0x4c,%esp
    13f9:	5b                   	pop    %ebx
    13fa:	5e                   	pop    %esi
    13fb:	5f                   	pop    %edi
    13fc:	5d                   	pop    %ebp
    13fd:	c3                   	ret    
    13fe:	66 90                	xchg   %ax,%ax
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
    1400:	89 d0                	mov    %edx,%eax
    1402:	f7 d8                	neg    %eax
    1404:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
    140b:	eb 94                	jmp    13a1 <printint+0x21>
    140d:	8d 76 00             	lea    0x0(%esi),%esi

00001410 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
    1410:	55                   	push   %ebp
    1411:	89 e5                	mov    %esp,%ebp
    1413:	57                   	push   %edi
    1414:	56                   	push   %esi
    1415:	53                   	push   %ebx
    1416:	83 ec 3c             	sub    $0x3c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    1419:	8b 45 0c             	mov    0xc(%ebp),%eax
    141c:	0f b6 10             	movzbl (%eax),%edx
    141f:	84 d2                	test   %dl,%dl
    1421:	0f 84 c1 00 00 00    	je     14e8 <printf+0xd8>
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
    1427:	8d 4d 10             	lea    0x10(%ebp),%ecx
    142a:	31 ff                	xor    %edi,%edi
    142c:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
    142f:	31 db                	xor    %ebx,%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    1431:	8d 75 e7             	lea    -0x19(%ebp),%esi
    1434:	eb 1e                	jmp    1454 <printf+0x44>
    1436:	66 90                	xchg   %ax,%ax
  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
    1438:	83 fa 25             	cmp    $0x25,%edx
    143b:	0f 85 af 00 00 00    	jne    14f0 <printf+0xe0>
    1441:	66 bf 25 00          	mov    $0x25,%di
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    1445:	83 c3 01             	add    $0x1,%ebx
    1448:	0f b6 14 18          	movzbl (%eax,%ebx,1),%edx
    144c:	84 d2                	test   %dl,%dl
    144e:	0f 84 94 00 00 00    	je     14e8 <printf+0xd8>
    c = fmt[i] & 0xff;
    if(state == 0){
    1454:	85 ff                	test   %edi,%edi
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    1456:	0f b6 d2             	movzbl %dl,%edx
    if(state == 0){
    1459:	74 dd                	je     1438 <printf+0x28>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
    145b:	83 ff 25             	cmp    $0x25,%edi
    145e:	75 e5                	jne    1445 <printf+0x35>
      if(c == 'd'){
    1460:	83 fa 64             	cmp    $0x64,%edx
    1463:	0f 84 3f 01 00 00    	je     15a8 <printf+0x198>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
    1469:	83 fa 70             	cmp    $0x70,%edx
    146c:	0f 84 a6 00 00 00    	je     1518 <printf+0x108>
    1472:	83 fa 78             	cmp    $0x78,%edx
    1475:	0f 84 9d 00 00 00    	je     1518 <printf+0x108>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
    147b:	83 fa 73             	cmp    $0x73,%edx
    147e:	66 90                	xchg   %ax,%ax
    1480:	0f 84 ba 00 00 00    	je     1540 <printf+0x130>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    1486:	83 fa 63             	cmp    $0x63,%edx
    1489:	0f 84 41 01 00 00    	je     15d0 <printf+0x1c0>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
    148f:	83 fa 25             	cmp    $0x25,%edx
    1492:	0f 84 00 01 00 00    	je     1598 <printf+0x188>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    1498:	8b 4d 08             	mov    0x8(%ebp),%ecx
    149b:	89 55 cc             	mov    %edx,-0x34(%ebp)
    149e:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
    14a2:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    14a9:	00 
    14aa:	89 74 24 04          	mov    %esi,0x4(%esp)
    14ae:	89 0c 24             	mov    %ecx,(%esp)
    14b1:	e8 22 fe ff ff       	call   12d8 <write>
    14b6:	8b 55 cc             	mov    -0x34(%ebp),%edx
    14b9:	88 55 e7             	mov    %dl,-0x19(%ebp)
    14bc:	8b 45 08             	mov    0x8(%ebp),%eax
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    14bf:	83 c3 01             	add    $0x1,%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    14c2:	31 ff                	xor    %edi,%edi
    14c4:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    14cb:	00 
    14cc:	89 74 24 04          	mov    %esi,0x4(%esp)
    14d0:	89 04 24             	mov    %eax,(%esp)
    14d3:	e8 00 fe ff ff       	call   12d8 <write>
    14d8:	8b 45 0c             	mov    0xc(%ebp),%eax
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    14db:	0f b6 14 18          	movzbl (%eax,%ebx,1),%edx
    14df:	84 d2                	test   %dl,%dl
    14e1:	0f 85 6d ff ff ff    	jne    1454 <printf+0x44>
    14e7:	90                   	nop
        putc(fd, c);
      }
      state = 0;
    }
  }
}
    14e8:	83 c4 3c             	add    $0x3c,%esp
    14eb:	5b                   	pop    %ebx
    14ec:	5e                   	pop    %esi
    14ed:	5f                   	pop    %edi
    14ee:	5d                   	pop    %ebp
    14ef:	c3                   	ret    
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    14f0:	8b 45 08             	mov    0x8(%ebp),%eax
  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
    14f3:	88 55 e7             	mov    %dl,-0x19(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    14f6:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    14fd:	00 
    14fe:	89 74 24 04          	mov    %esi,0x4(%esp)
    1502:	89 04 24             	mov    %eax,(%esp)
    1505:	e8 ce fd ff ff       	call   12d8 <write>
    150a:	8b 45 0c             	mov    0xc(%ebp),%eax
    150d:	e9 33 ff ff ff       	jmp    1445 <printf+0x35>
    1512:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
    1518:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    151b:	b9 10 00 00 00       	mov    $0x10,%ecx
        ap++;
    1520:	31 ff                	xor    %edi,%edi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
    1522:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1529:	8b 10                	mov    (%eax),%edx
    152b:	8b 45 08             	mov    0x8(%ebp),%eax
    152e:	e8 4d fe ff ff       	call   1380 <printint>
    1533:	8b 45 0c             	mov    0xc(%ebp),%eax
        ap++;
    1536:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
    153a:	e9 06 ff ff ff       	jmp    1445 <printf+0x35>
    153f:	90                   	nop
      } else if(c == 's'){
        s = (char*)*ap;
    1540:	8b 55 d4             	mov    -0x2c(%ebp),%edx
        ap++;
        if(s == 0)
    1543:	b9 a3 17 00 00       	mov    $0x17a3,%ecx
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
        s = (char*)*ap;
    1548:	8b 3a                	mov    (%edx),%edi
        ap++;
    154a:	83 c2 04             	add    $0x4,%edx
    154d:	89 55 d4             	mov    %edx,-0x2c(%ebp)
        if(s == 0)
    1550:	85 ff                	test   %edi,%edi
    1552:	0f 44 f9             	cmove  %ecx,%edi
          s = "(null)";
        while(*s != 0){
    1555:	0f b6 17             	movzbl (%edi),%edx
    1558:	84 d2                	test   %dl,%dl
    155a:	74 33                	je     158f <printf+0x17f>
    155c:	89 5d d0             	mov    %ebx,-0x30(%ebp)
    155f:	8b 5d 08             	mov    0x8(%ebp),%ebx
    1562:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
          putc(fd, *s);
          s++;
    1568:	83 c7 01             	add    $0x1,%edi
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
    156b:	88 55 e7             	mov    %dl,-0x19(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    156e:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    1575:	00 
    1576:	89 74 24 04          	mov    %esi,0x4(%esp)
    157a:	89 1c 24             	mov    %ebx,(%esp)
    157d:	e8 56 fd ff ff       	call   12d8 <write>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
    1582:	0f b6 17             	movzbl (%edi),%edx
    1585:	84 d2                	test   %dl,%dl
    1587:	75 df                	jne    1568 <printf+0x158>
    1589:	8b 5d d0             	mov    -0x30(%ebp),%ebx
    158c:	8b 45 0c             	mov    0xc(%ebp),%eax
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    158f:	31 ff                	xor    %edi,%edi
    1591:	e9 af fe ff ff       	jmp    1445 <printf+0x35>
    1596:	66 90                	xchg   %ax,%ax
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
    1598:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
    159c:	e9 1b ff ff ff       	jmp    14bc <printf+0xac>
    15a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
    15a8:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    15ab:	b9 0a 00 00 00       	mov    $0xa,%ecx
        ap++;
    15b0:	66 31 ff             	xor    %di,%di
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
    15b3:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    15ba:	8b 10                	mov    (%eax),%edx
    15bc:	8b 45 08             	mov    0x8(%ebp),%eax
    15bf:	e8 bc fd ff ff       	call   1380 <printint>
    15c4:	8b 45 0c             	mov    0xc(%ebp),%eax
        ap++;
    15c7:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
    15cb:	e9 75 fe ff ff       	jmp    1445 <printf+0x35>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    15d0:	8b 55 d4             	mov    -0x2c(%ebp),%edx
        putc(fd, *ap);
        ap++;
    15d3:	31 ff                	xor    %edi,%edi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    15d5:	8b 4d 08             	mov    0x8(%ebp),%ecx
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    15d8:	8b 02                	mov    (%edx),%eax
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    15da:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    15e1:	00 
    15e2:	89 74 24 04          	mov    %esi,0x4(%esp)
    15e6:	89 0c 24             	mov    %ecx,(%esp)
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    15e9:	88 45 e7             	mov    %al,-0x19(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    15ec:	e8 e7 fc ff ff       	call   12d8 <write>
    15f1:	8b 45 0c             	mov    0xc(%ebp),%eax
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
        ap++;
    15f4:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
    15f8:	e9 48 fe ff ff       	jmp    1445 <printf+0x35>
    15fd:	90                   	nop
    15fe:	90                   	nop
    15ff:	90                   	nop

00001600 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    1600:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1601:	a1 c4 17 00 00       	mov    0x17c4,%eax
static Header base;
static Header *freep;

void
free(void *ap)
{
    1606:	89 e5                	mov    %esp,%ebp
    1608:	57                   	push   %edi
    1609:	56                   	push   %esi
    160a:	53                   	push   %ebx
    160b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
    160e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1611:	39 c8                	cmp    %ecx,%eax
    1613:	73 1d                	jae    1632 <free+0x32>
    1615:	8d 76 00             	lea    0x0(%esi),%esi
    1618:	8b 10                	mov    (%eax),%edx
    161a:	39 d1                	cmp    %edx,%ecx
    161c:	72 1a                	jb     1638 <free+0x38>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    161e:	39 d0                	cmp    %edx,%eax
    1620:	72 08                	jb     162a <free+0x2a>
    1622:	39 c8                	cmp    %ecx,%eax
    1624:	72 12                	jb     1638 <free+0x38>
    1626:	39 d1                	cmp    %edx,%ecx
    1628:	72 0e                	jb     1638 <free+0x38>
    162a:	89 d0                	mov    %edx,%eax
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    162c:	39 c8                	cmp    %ecx,%eax
    162e:	66 90                	xchg   %ax,%ax
    1630:	72 e6                	jb     1618 <free+0x18>
    1632:	8b 10                	mov    (%eax),%edx
    1634:	eb e8                	jmp    161e <free+0x1e>
    1636:	66 90                	xchg   %ax,%ax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    1638:	8b 71 04             	mov    0x4(%ecx),%esi
    163b:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    163e:	39 d7                	cmp    %edx,%edi
    1640:	74 19                	je     165b <free+0x5b>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
    1642:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    1645:	8b 50 04             	mov    0x4(%eax),%edx
    1648:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    164b:	39 ce                	cmp    %ecx,%esi
    164d:	74 23                	je     1672 <free+0x72>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
    164f:	89 08                	mov    %ecx,(%eax)
  freep = p;
    1651:	a3 c4 17 00 00       	mov    %eax,0x17c4
}
    1656:	5b                   	pop    %ebx
    1657:	5e                   	pop    %esi
    1658:	5f                   	pop    %edi
    1659:	5d                   	pop    %ebp
    165a:	c3                   	ret    
  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
    165b:	03 72 04             	add    0x4(%edx),%esi
    165e:	89 71 04             	mov    %esi,0x4(%ecx)
    bp->s.ptr = p->s.ptr->s.ptr;
    1661:	8b 10                	mov    (%eax),%edx
    1663:	8b 12                	mov    (%edx),%edx
    1665:	89 53 f8             	mov    %edx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    1668:	8b 50 04             	mov    0x4(%eax),%edx
    166b:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    166e:	39 ce                	cmp    %ecx,%esi
    1670:	75 dd                	jne    164f <free+0x4f>
    p->s.size += bp->s.size;
    1672:	03 51 04             	add    0x4(%ecx),%edx
    1675:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    1678:	8b 53 f8             	mov    -0x8(%ebx),%edx
    167b:	89 10                	mov    %edx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
    167d:	a3 c4 17 00 00       	mov    %eax,0x17c4
}
    1682:	5b                   	pop    %ebx
    1683:	5e                   	pop    %esi
    1684:	5f                   	pop    %edi
    1685:	5d                   	pop    %ebp
    1686:	c3                   	ret    
    1687:	89 f6                	mov    %esi,%esi
    1689:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001690 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    1690:	55                   	push   %ebp
    1691:	89 e5                	mov    %esp,%ebp
    1693:	57                   	push   %edi
    1694:	56                   	push   %esi
    1695:	53                   	push   %ebx
    1696:	83 ec 2c             	sub    $0x2c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1699:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if((prevp = freep) == 0){
    169c:	8b 0d c4 17 00 00    	mov    0x17c4,%ecx
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    16a2:	83 c3 07             	add    $0x7,%ebx
    16a5:	c1 eb 03             	shr    $0x3,%ebx
    16a8:	83 c3 01             	add    $0x1,%ebx
  if((prevp = freep) == 0){
    16ab:	85 c9                	test   %ecx,%ecx
    16ad:	0f 84 9b 00 00 00    	je     174e <malloc+0xbe>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    16b3:	8b 01                	mov    (%ecx),%eax
    if(p->s.size >= nunits){
    16b5:	8b 50 04             	mov    0x4(%eax),%edx
    16b8:	39 d3                	cmp    %edx,%ebx
    16ba:	76 27                	jbe    16e3 <malloc+0x53>
        p->s.size -= nunits;
        p += p->s.size;
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    16bc:	8d 3c dd 00 00 00 00 	lea    0x0(,%ebx,8),%edi
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < 4096)
    16c3:	be 00 80 00 00       	mov    $0x8000,%esi
    16c8:	89 7d e4             	mov    %edi,-0x1c(%ebp)
    16cb:	90                   	nop
    16cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    16d0:	3b 05 c4 17 00 00    	cmp    0x17c4,%eax
    16d6:	74 30                	je     1708 <malloc+0x78>
    16d8:	89 c1                	mov    %eax,%ecx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    16da:	8b 01                	mov    (%ecx),%eax
    if(p->s.size >= nunits){
    16dc:	8b 50 04             	mov    0x4(%eax),%edx
    16df:	39 d3                	cmp    %edx,%ebx
    16e1:	77 ed                	ja     16d0 <malloc+0x40>
      if(p->s.size == nunits)
    16e3:	39 d3                	cmp    %edx,%ebx
    16e5:	74 61                	je     1748 <malloc+0xb8>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
    16e7:	29 da                	sub    %ebx,%edx
    16e9:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
    16ec:	8d 04 d0             	lea    (%eax,%edx,8),%eax
        p->s.size = nunits;
    16ef:	89 58 04             	mov    %ebx,0x4(%eax)
      }
      freep = prevp;
    16f2:	89 0d c4 17 00 00    	mov    %ecx,0x17c4
      return (void*)(p + 1);
    16f8:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
    16fb:	83 c4 2c             	add    $0x2c,%esp
    16fe:	5b                   	pop    %ebx
    16ff:	5e                   	pop    %esi
    1700:	5f                   	pop    %edi
    1701:	5d                   	pop    %ebp
    1702:	c3                   	ret    
    1703:	90                   	nop
    1704:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < 4096)
    1708:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    170b:	81 fb 00 10 00 00    	cmp    $0x1000,%ebx
    1711:	bf 00 10 00 00       	mov    $0x1000,%edi
    1716:	0f 43 fb             	cmovae %ebx,%edi
    1719:	0f 42 c6             	cmovb  %esi,%eax
    nu = 4096;
  p = sbrk(nu * sizeof(Header));
    171c:	89 04 24             	mov    %eax,(%esp)
    171f:	e8 1c fc ff ff       	call   1340 <sbrk>
  if(p == (char*)-1)
    1724:	83 f8 ff             	cmp    $0xffffffff,%eax
    1727:	74 18                	je     1741 <malloc+0xb1>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
    1729:	89 78 04             	mov    %edi,0x4(%eax)
  free((void*)(hp + 1));
    172c:	83 c0 08             	add    $0x8,%eax
    172f:	89 04 24             	mov    %eax,(%esp)
    1732:	e8 c9 fe ff ff       	call   1600 <free>
  return freep;
    1737:	8b 0d c4 17 00 00    	mov    0x17c4,%ecx
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
    173d:	85 c9                	test   %ecx,%ecx
    173f:	75 99                	jne    16da <malloc+0x4a>
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
    1741:	31 c0                	xor    %eax,%eax
    1743:	eb b6                	jmp    16fb <malloc+0x6b>
    1745:	8d 76 00             	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
    1748:	8b 10                	mov    (%eax),%edx
    174a:	89 11                	mov    %edx,(%ecx)
    174c:	eb a4                	jmp    16f2 <malloc+0x62>
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    174e:	c7 05 c4 17 00 00 bc 	movl   $0x17bc,0x17c4
    1755:	17 00 00 
    base.s.size = 0;
    1758:	b9 bc 17 00 00       	mov    $0x17bc,%ecx
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    175d:	c7 05 bc 17 00 00 bc 	movl   $0x17bc,0x17bc
    1764:	17 00 00 
    base.s.size = 0;
    1767:	c7 05 c0 17 00 00 00 	movl   $0x0,0x17c0
    176e:	00 00 00 
    1771:	e9 3d ff ff ff       	jmp    16b3 <malloc+0x23>
