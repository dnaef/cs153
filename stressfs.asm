
_stressfs:     file format elf32-i386


Disassembly of section .text:

00001000 <main>:
#include "fs.h"
#include "fcntl.h"

int
main(int argc, char *argv[])
{
    1000:	55                   	push   %ebp
    1001:	89 e5                	mov    %esp,%ebp
    1003:	83 e4 f0             	and    $0xfffffff0,%esp
    1006:	57                   	push   %edi
    1007:	56                   	push   %esi
    1008:	53                   	push   %ebx

  printf(1, "stressfs starting\n");
  memset(data, 'a', sizeof(data));

  for(i = 0; i < 4; i++)
    if(fork() > 0)
    1009:	31 db                	xor    %ebx,%ebx
#include "fs.h"
#include "fcntl.h"

int
main(int argc, char *argv[])
{
    100b:	81 ec 24 02 00 00    	sub    $0x224,%esp
  int fd, i, exit_status;
  char path[] = "stressfs0";
  char data[512];

  printf(1, "stressfs starting\n");
  memset(data, 'a', sizeof(data));
    1011:	8d 74 24 12          	lea    0x12(%esp),%esi

int
main(int argc, char *argv[])
{
  int fd, i, exit_status;
  char path[] = "stressfs0";
    1015:	c7 84 24 12 02 00 00 	movl   $0x65727473,0x212(%esp)
    101c:	73 74 72 65 
    1020:	c7 84 24 16 02 00 00 	movl   $0x73667373,0x216(%esp)
    1027:	73 73 66 73 
    102b:	66 c7 84 24 1a 02 00 	movw   $0x30,0x21a(%esp)
    1032:	00 30 00 
  char data[512];

  printf(1, "stressfs starting\n");
    1035:	c7 44 24 04 56 18 00 	movl   $0x1856,0x4(%esp)
    103c:	00 
    103d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1044:	e8 a7 04 00 00       	call   14f0 <printf>
  memset(data, 'a', sizeof(data));
    1049:	c7 44 24 08 00 02 00 	movl   $0x200,0x8(%esp)
    1050:	00 
    1051:	c7 44 24 04 61 00 00 	movl   $0x61,0x4(%esp)
    1058:	00 
    1059:	89 34 24             	mov    %esi,(%esp)
    105c:	e8 af 01 00 00       	call   1210 <memset>

  for(i = 0; i < 4; i++)
    if(fork() > 0)
    1061:	e8 2a 03 00 00       	call   1390 <fork>
    1066:	85 c0                	test   %eax,%eax
    1068:	7f 2b                	jg     1095 <main+0x95>
    106a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    1070:	e8 1b 03 00 00       	call   1390 <fork>
    1075:	b3 01                	mov    $0x1,%bl
    1077:	85 c0                	test   %eax,%eax
    1079:	7f 1a                	jg     1095 <main+0x95>
    107b:	e8 10 03 00 00       	call   1390 <fork>
    1080:	b3 02                	mov    $0x2,%bl
    1082:	85 c0                	test   %eax,%eax
    1084:	7f 0f                	jg     1095 <main+0x95>
    1086:	e8 05 03 00 00       	call   1390 <fork>
    108b:	31 db                	xor    %ebx,%ebx
    108d:	85 c0                	test   %eax,%eax
    108f:	0f 9e c3             	setle  %bl
    1092:	83 c3 03             	add    $0x3,%ebx
      break;

  printf(1, "write %d\n", i);
    1095:	89 5c 24 08          	mov    %ebx,0x8(%esp)
    1099:	c7 44 24 04 69 18 00 	movl   $0x1869,0x4(%esp)
    10a0:	00 
    10a1:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    10a8:	e8 43 04 00 00       	call   14f0 <printf>

  path[8] += i;
  fd = open(path, O_CREATE | O_RDWR);
    10ad:	8d 84 24 12 02 00 00 	lea    0x212(%esp),%eax
    if(fork() > 0)
      break;

  printf(1, "write %d\n", i);

  path[8] += i;
    10b4:	00 9c 24 1a 02 00 00 	add    %bl,0x21a(%esp)
  fd = open(path, O_CREATE | O_RDWR);
    10bb:	31 db                	xor    %ebx,%ebx
    10bd:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
    10c4:	00 
    10c5:	89 04 24             	mov    %eax,(%esp)
    10c8:	e8 0b 03 00 00       	call   13d8 <open>
    10cd:	89 c7                	mov    %eax,%edi
    10cf:	90                   	nop
  for(i = 0; i < 20; i++)
    10d0:	83 c3 01             	add    $0x1,%ebx
//    printf(fd, "%d\n", i);
    write(fd, data, sizeof(data));
    10d3:	c7 44 24 08 00 02 00 	movl   $0x200,0x8(%esp)
    10da:	00 
    10db:	89 74 24 04          	mov    %esi,0x4(%esp)
    10df:	89 3c 24             	mov    %edi,(%esp)
    10e2:	e8 d1 02 00 00       	call   13b8 <write>

  printf(1, "write %d\n", i);

  path[8] += i;
  fd = open(path, O_CREATE | O_RDWR);
  for(i = 0; i < 20; i++)
    10e7:	83 fb 14             	cmp    $0x14,%ebx
    10ea:	75 e4                	jne    10d0 <main+0xd0>
//    printf(fd, "%d\n", i);
    write(fd, data, sizeof(data));
  close(fd);
    10ec:	89 3c 24             	mov    %edi,(%esp)

  printf(1, "read\n");

  fd = open(path, O_RDONLY);
    10ef:	30 db                	xor    %bl,%bl
  path[8] += i;
  fd = open(path, O_CREATE | O_RDWR);
  for(i = 0; i < 20; i++)
//    printf(fd, "%d\n", i);
    write(fd, data, sizeof(data));
  close(fd);
    10f1:	e8 ca 02 00 00       	call   13c0 <close>

  printf(1, "read\n");
    10f6:	c7 44 24 04 73 18 00 	movl   $0x1873,0x4(%esp)
    10fd:	00 
    10fe:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1105:	e8 e6 03 00 00       	call   14f0 <printf>

  fd = open(path, O_RDONLY);
    110a:	8d 84 24 12 02 00 00 	lea    0x212(%esp),%eax
    1111:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1118:	00 
    1119:	89 04 24             	mov    %eax,(%esp)
    111c:	e8 b7 02 00 00       	call   13d8 <open>
    1121:	89 c7                	mov    %eax,%edi
    1123:	90                   	nop
    1124:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for (i = 0; i < 20; i++)
    1128:	83 c3 01             	add    $0x1,%ebx
    read(fd, data, sizeof(data));
    112b:	c7 44 24 08 00 02 00 	movl   $0x200,0x8(%esp)
    1132:	00 
    1133:	89 74 24 04          	mov    %esi,0x4(%esp)
    1137:	89 3c 24             	mov    %edi,(%esp)
    113a:	e8 71 02 00 00       	call   13b0 <read>
  close(fd);

  printf(1, "read\n");

  fd = open(path, O_RDONLY);
  for (i = 0; i < 20; i++)
    113f:	83 fb 14             	cmp    $0x14,%ebx
    1142:	75 e4                	jne    1128 <main+0x128>
    read(fd, data, sizeof(data));
  close(fd);
    1144:	89 3c 24             	mov    %edi,(%esp)
    1147:	e8 74 02 00 00       	call   13c0 <close>

  wait(&exit_status);
    114c:	8d 84 24 1c 02 00 00 	lea    0x21c(%esp),%eax
    1153:	89 04 24             	mov    %eax,(%esp)
    1156:	e8 45 02 00 00       	call   13a0 <wait>

  exit(0);
    115b:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1162:	e8 31 02 00 00       	call   1398 <exit>
    1167:	90                   	nop
    1168:	90                   	nop
    1169:	90                   	nop
    116a:	90                   	nop
    116b:	90                   	nop
    116c:	90                   	nop
    116d:	90                   	nop
    116e:	90                   	nop
    116f:	90                   	nop

00001170 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
    1170:	55                   	push   %ebp
    1171:	31 d2                	xor    %edx,%edx
    1173:	89 e5                	mov    %esp,%ebp
    1175:	8b 45 08             	mov    0x8(%ebp),%eax
    1178:	53                   	push   %ebx
    1179:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    117c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
    1180:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
    1184:	88 0c 10             	mov    %cl,(%eax,%edx,1)
    1187:	83 c2 01             	add    $0x1,%edx
    118a:	84 c9                	test   %cl,%cl
    118c:	75 f2                	jne    1180 <strcpy+0x10>
    ;
  return os;
}
    118e:	5b                   	pop    %ebx
    118f:	5d                   	pop    %ebp
    1190:	c3                   	ret    
    1191:	eb 0d                	jmp    11a0 <strcmp>
    1193:	90                   	nop
    1194:	90                   	nop
    1195:	90                   	nop
    1196:	90                   	nop
    1197:	90                   	nop
    1198:	90                   	nop
    1199:	90                   	nop
    119a:	90                   	nop
    119b:	90                   	nop
    119c:	90                   	nop
    119d:	90                   	nop
    119e:	90                   	nop
    119f:	90                   	nop

000011a0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    11a0:	55                   	push   %ebp
    11a1:	89 e5                	mov    %esp,%ebp
    11a3:	8b 4d 08             	mov    0x8(%ebp),%ecx
    11a6:	53                   	push   %ebx
    11a7:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(*p && *p == *q)
    11aa:	0f b6 01             	movzbl (%ecx),%eax
    11ad:	84 c0                	test   %al,%al
    11af:	75 14                	jne    11c5 <strcmp+0x25>
    11b1:	eb 25                	jmp    11d8 <strcmp+0x38>
    11b3:	90                   	nop
    11b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    p++, q++;
    11b8:	83 c1 01             	add    $0x1,%ecx
    11bb:	83 c2 01             	add    $0x1,%edx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
    11be:	0f b6 01             	movzbl (%ecx),%eax
    11c1:	84 c0                	test   %al,%al
    11c3:	74 13                	je     11d8 <strcmp+0x38>
    11c5:	0f b6 1a             	movzbl (%edx),%ebx
    11c8:	38 d8                	cmp    %bl,%al
    11ca:	74 ec                	je     11b8 <strcmp+0x18>
    11cc:	0f b6 db             	movzbl %bl,%ebx
    11cf:	0f b6 c0             	movzbl %al,%eax
    11d2:	29 d8                	sub    %ebx,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
    11d4:	5b                   	pop    %ebx
    11d5:	5d                   	pop    %ebp
    11d6:	c3                   	ret    
    11d7:	90                   	nop
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
    11d8:	0f b6 1a             	movzbl (%edx),%ebx
    11db:	31 c0                	xor    %eax,%eax
    11dd:	0f b6 db             	movzbl %bl,%ebx
    11e0:	29 d8                	sub    %ebx,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
    11e2:	5b                   	pop    %ebx
    11e3:	5d                   	pop    %ebp
    11e4:	c3                   	ret    
    11e5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    11e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000011f0 <strlen>:

uint
strlen(char *s)
{
    11f0:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
    11f1:	31 d2                	xor    %edx,%edx
  return (uchar)*p - (uchar)*q;
}

uint
strlen(char *s)
{
    11f3:	89 e5                	mov    %esp,%ebp
  int n;

  for(n = 0; s[n]; n++)
    11f5:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
}

uint
strlen(char *s)
{
    11f7:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
    11fa:	80 39 00             	cmpb   $0x0,(%ecx)
    11fd:	74 0c                	je     120b <strlen+0x1b>
    11ff:	90                   	nop
    1200:	83 c2 01             	add    $0x1,%edx
    1203:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
    1207:	89 d0                	mov    %edx,%eax
    1209:	75 f5                	jne    1200 <strlen+0x10>
    ;
  return n;
}
    120b:	5d                   	pop    %ebp
    120c:	c3                   	ret    
    120d:	8d 76 00             	lea    0x0(%esi),%esi

00001210 <memset>:

void*
memset(void *dst, int c, uint n)
{
    1210:	55                   	push   %ebp
    1211:	89 e5                	mov    %esp,%ebp
    1213:	8b 55 08             	mov    0x8(%ebp),%edx
    1216:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
    1217:	8b 4d 10             	mov    0x10(%ebp),%ecx
    121a:	8b 45 0c             	mov    0xc(%ebp),%eax
    121d:	89 d7                	mov    %edx,%edi
    121f:	fc                   	cld    
    1220:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
    1222:	89 d0                	mov    %edx,%eax
    1224:	5f                   	pop    %edi
    1225:	5d                   	pop    %ebp
    1226:	c3                   	ret    
    1227:	89 f6                	mov    %esi,%esi
    1229:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001230 <strchr>:

char*
strchr(const char *s, char c)
{
    1230:	55                   	push   %ebp
    1231:	89 e5                	mov    %esp,%ebp
    1233:	8b 45 08             	mov    0x8(%ebp),%eax
    1236:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
    123a:	0f b6 10             	movzbl (%eax),%edx
    123d:	84 d2                	test   %dl,%dl
    123f:	75 11                	jne    1252 <strchr+0x22>
    1241:	eb 15                	jmp    1258 <strchr+0x28>
    1243:	90                   	nop
    1244:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1248:	83 c0 01             	add    $0x1,%eax
    124b:	0f b6 10             	movzbl (%eax),%edx
    124e:	84 d2                	test   %dl,%dl
    1250:	74 06                	je     1258 <strchr+0x28>
    if(*s == c)
    1252:	38 ca                	cmp    %cl,%dl
    1254:	75 f2                	jne    1248 <strchr+0x18>
      return (char*)s;
  return 0;
}
    1256:	5d                   	pop    %ebp
    1257:	c3                   	ret    
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
    1258:	31 c0                	xor    %eax,%eax
    if(*s == c)
      return (char*)s;
  return 0;
}
    125a:	5d                   	pop    %ebp
    125b:	90                   	nop
    125c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1260:	c3                   	ret    
    1261:	eb 0d                	jmp    1270 <atoi>
    1263:	90                   	nop
    1264:	90                   	nop
    1265:	90                   	nop
    1266:	90                   	nop
    1267:	90                   	nop
    1268:	90                   	nop
    1269:	90                   	nop
    126a:	90                   	nop
    126b:	90                   	nop
    126c:	90                   	nop
    126d:	90                   	nop
    126e:	90                   	nop
    126f:	90                   	nop

00001270 <atoi>:
  return r;
}

int
atoi(const char *s)
{
    1270:	55                   	push   %ebp
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    1271:	31 c0                	xor    %eax,%eax
  return r;
}

int
atoi(const char *s)
{
    1273:	89 e5                	mov    %esp,%ebp
    1275:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1278:	53                   	push   %ebx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    1279:	0f b6 11             	movzbl (%ecx),%edx
    127c:	8d 5a d0             	lea    -0x30(%edx),%ebx
    127f:	80 fb 09             	cmp    $0x9,%bl
    1282:	77 1c                	ja     12a0 <atoi+0x30>
    1284:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    n = n*10 + *s++ - '0';
    1288:	0f be d2             	movsbl %dl,%edx
    128b:	83 c1 01             	add    $0x1,%ecx
    128e:	8d 04 80             	lea    (%eax,%eax,4),%eax
    1291:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    1295:	0f b6 11             	movzbl (%ecx),%edx
    1298:	8d 5a d0             	lea    -0x30(%edx),%ebx
    129b:	80 fb 09             	cmp    $0x9,%bl
    129e:	76 e8                	jbe    1288 <atoi+0x18>
    n = n*10 + *s++ - '0';
  return n;
}
    12a0:	5b                   	pop    %ebx
    12a1:	5d                   	pop    %ebp
    12a2:	c3                   	ret    
    12a3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    12a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000012b0 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
    12b0:	55                   	push   %ebp
    12b1:	89 e5                	mov    %esp,%ebp
    12b3:	56                   	push   %esi
    12b4:	8b 45 08             	mov    0x8(%ebp),%eax
    12b7:	53                   	push   %ebx
    12b8:	8b 5d 10             	mov    0x10(%ebp),%ebx
    12bb:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    12be:	85 db                	test   %ebx,%ebx
    12c0:	7e 14                	jle    12d6 <memmove+0x26>
    n = n*10 + *s++ - '0';
  return n;
}

void*
memmove(void *vdst, void *vsrc, int n)
    12c2:	31 d2                	xor    %edx,%edx
    12c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    *dst++ = *src++;
    12c8:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
    12cc:	88 0c 10             	mov    %cl,(%eax,%edx,1)
    12cf:	83 c2 01             	add    $0x1,%edx
{
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    12d2:	39 da                	cmp    %ebx,%edx
    12d4:	75 f2                	jne    12c8 <memmove+0x18>
    *dst++ = *src++;
  return vdst;
}
    12d6:	5b                   	pop    %ebx
    12d7:	5e                   	pop    %esi
    12d8:	5d                   	pop    %ebp
    12d9:	c3                   	ret    
    12da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000012e0 <stat>:
  return buf;
}

int
stat(char *n, struct stat *st)
{
    12e0:	55                   	push   %ebp
    12e1:	89 e5                	mov    %esp,%ebp
    12e3:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    12e6:	8b 45 08             	mov    0x8(%ebp),%eax
  return buf;
}

int
stat(char *n, struct stat *st)
{
    12e9:	89 5d f8             	mov    %ebx,-0x8(%ebp)
    12ec:	89 75 fc             	mov    %esi,-0x4(%ebp)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    12ef:	be ff ff ff ff       	mov    $0xffffffff,%esi
stat(char *n, struct stat *st)
{
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    12f4:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    12fb:	00 
    12fc:	89 04 24             	mov    %eax,(%esp)
    12ff:	e8 d4 00 00 00       	call   13d8 <open>
  if(fd < 0)
    1304:	85 c0                	test   %eax,%eax
stat(char *n, struct stat *st)
{
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    1306:	89 c3                	mov    %eax,%ebx
  if(fd < 0)
    1308:	78 19                	js     1323 <stat+0x43>
    return -1;
  r = fstat(fd, st);
    130a:	8b 45 0c             	mov    0xc(%ebp),%eax
    130d:	89 1c 24             	mov    %ebx,(%esp)
    1310:	89 44 24 04          	mov    %eax,0x4(%esp)
    1314:	e8 d7 00 00 00       	call   13f0 <fstat>
  close(fd);
    1319:	89 1c 24             	mov    %ebx,(%esp)
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
  r = fstat(fd, st);
    131c:	89 c6                	mov    %eax,%esi
  close(fd);
    131e:	e8 9d 00 00 00       	call   13c0 <close>
  return r;
}
    1323:	89 f0                	mov    %esi,%eax
    1325:	8b 5d f8             	mov    -0x8(%ebp),%ebx
    1328:	8b 75 fc             	mov    -0x4(%ebp),%esi
    132b:	89 ec                	mov    %ebp,%esp
    132d:	5d                   	pop    %ebp
    132e:	c3                   	ret    
    132f:	90                   	nop

00001330 <gets>:
  return 0;
}

char*
gets(char *buf, int max)
{
    1330:	55                   	push   %ebp
    1331:	89 e5                	mov    %esp,%ebp
    1333:	57                   	push   %edi
    1334:	56                   	push   %esi
    1335:	31 f6                	xor    %esi,%esi
    1337:	53                   	push   %ebx
    1338:	83 ec 2c             	sub    $0x2c,%esp
    133b:	8b 7d 08             	mov    0x8(%ebp),%edi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    133e:	eb 06                	jmp    1346 <gets+0x16>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
    1340:	3c 0a                	cmp    $0xa,%al
    1342:	74 39                	je     137d <gets+0x4d>
    1344:	89 de                	mov    %ebx,%esi
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    1346:	8d 5e 01             	lea    0x1(%esi),%ebx
    1349:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
    134c:	7d 31                	jge    137f <gets+0x4f>
    cc = read(0, &c, 1);
    134e:	8d 45 e7             	lea    -0x19(%ebp),%eax
    1351:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    1358:	00 
    1359:	89 44 24 04          	mov    %eax,0x4(%esp)
    135d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1364:	e8 47 00 00 00       	call   13b0 <read>
    if(cc < 1)
    1369:	85 c0                	test   %eax,%eax
    136b:	7e 12                	jle    137f <gets+0x4f>
      break;
    buf[i++] = c;
    136d:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
    1371:	88 44 1f ff          	mov    %al,-0x1(%edi,%ebx,1)
    if(c == '\n' || c == '\r')
    1375:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
    1379:	3c 0d                	cmp    $0xd,%al
    137b:	75 c3                	jne    1340 <gets+0x10>
    137d:	89 de                	mov    %ebx,%esi
      break;
  }
  buf[i] = '\0';
    137f:	c6 04 37 00          	movb   $0x0,(%edi,%esi,1)
  return buf;
}
    1383:	89 f8                	mov    %edi,%eax
    1385:	83 c4 2c             	add    $0x2c,%esp
    1388:	5b                   	pop    %ebx
    1389:	5e                   	pop    %esi
    138a:	5f                   	pop    %edi
    138b:	5d                   	pop    %ebp
    138c:	c3                   	ret    
    138d:	90                   	nop
    138e:	90                   	nop
    138f:	90                   	nop

00001390 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    1390:	b8 01 00 00 00       	mov    $0x1,%eax
    1395:	cd 40                	int    $0x40
    1397:	c3                   	ret    

00001398 <exit>:
SYSCALL(exit)
    1398:	b8 02 00 00 00       	mov    $0x2,%eax
    139d:	cd 40                	int    $0x40
    139f:	c3                   	ret    

000013a0 <wait>:
SYSCALL(wait)
    13a0:	b8 03 00 00 00       	mov    $0x3,%eax
    13a5:	cd 40                	int    $0x40
    13a7:	c3                   	ret    

000013a8 <pipe>:
SYSCALL(pipe)
    13a8:	b8 04 00 00 00       	mov    $0x4,%eax
    13ad:	cd 40                	int    $0x40
    13af:	c3                   	ret    

000013b0 <read>:
SYSCALL(read)
    13b0:	b8 05 00 00 00       	mov    $0x5,%eax
    13b5:	cd 40                	int    $0x40
    13b7:	c3                   	ret    

000013b8 <write>:
SYSCALL(write)
    13b8:	b8 10 00 00 00       	mov    $0x10,%eax
    13bd:	cd 40                	int    $0x40
    13bf:	c3                   	ret    

000013c0 <close>:
SYSCALL(close)
    13c0:	b8 15 00 00 00       	mov    $0x15,%eax
    13c5:	cd 40                	int    $0x40
    13c7:	c3                   	ret    

000013c8 <kill>:
SYSCALL(kill)
    13c8:	b8 06 00 00 00       	mov    $0x6,%eax
    13cd:	cd 40                	int    $0x40
    13cf:	c3                   	ret    

000013d0 <exec>:
SYSCALL(exec)
    13d0:	b8 07 00 00 00       	mov    $0x7,%eax
    13d5:	cd 40                	int    $0x40
    13d7:	c3                   	ret    

000013d8 <open>:
SYSCALL(open)
    13d8:	b8 0f 00 00 00       	mov    $0xf,%eax
    13dd:	cd 40                	int    $0x40
    13df:	c3                   	ret    

000013e0 <mknod>:
SYSCALL(mknod)
    13e0:	b8 11 00 00 00       	mov    $0x11,%eax
    13e5:	cd 40                	int    $0x40
    13e7:	c3                   	ret    

000013e8 <unlink>:
SYSCALL(unlink)
    13e8:	b8 12 00 00 00       	mov    $0x12,%eax
    13ed:	cd 40                	int    $0x40
    13ef:	c3                   	ret    

000013f0 <fstat>:
SYSCALL(fstat)
    13f0:	b8 08 00 00 00       	mov    $0x8,%eax
    13f5:	cd 40                	int    $0x40
    13f7:	c3                   	ret    

000013f8 <link>:
SYSCALL(link)
    13f8:	b8 13 00 00 00       	mov    $0x13,%eax
    13fd:	cd 40                	int    $0x40
    13ff:	c3                   	ret    

00001400 <mkdir>:
SYSCALL(mkdir)
    1400:	b8 14 00 00 00       	mov    $0x14,%eax
    1405:	cd 40                	int    $0x40
    1407:	c3                   	ret    

00001408 <chdir>:
SYSCALL(chdir)
    1408:	b8 09 00 00 00       	mov    $0x9,%eax
    140d:	cd 40                	int    $0x40
    140f:	c3                   	ret    

00001410 <dup>:
SYSCALL(dup)
    1410:	b8 0a 00 00 00       	mov    $0xa,%eax
    1415:	cd 40                	int    $0x40
    1417:	c3                   	ret    

00001418 <getpid>:
SYSCALL(getpid)
    1418:	b8 0b 00 00 00       	mov    $0xb,%eax
    141d:	cd 40                	int    $0x40
    141f:	c3                   	ret    

00001420 <sbrk>:
SYSCALL(sbrk)
    1420:	b8 0c 00 00 00       	mov    $0xc,%eax
    1425:	cd 40                	int    $0x40
    1427:	c3                   	ret    

00001428 <sleep>:
SYSCALL(sleep)
    1428:	b8 0d 00 00 00       	mov    $0xd,%eax
    142d:	cd 40                	int    $0x40
    142f:	c3                   	ret    

00001430 <uptime>:
SYSCALL(uptime)
    1430:	b8 0e 00 00 00       	mov    $0xe,%eax
    1435:	cd 40                	int    $0x40
    1437:	c3                   	ret    

00001438 <hello>:
SYSCALL(hello)
    1438:	b8 16 00 00 00       	mov    $0x16,%eax
    143d:	cd 40                	int    $0x40
    143f:	c3                   	ret    

00001440 <waitpid>:
SYSCALL(waitpid)
    1440:	b8 17 00 00 00       	mov    $0x17,%eax
    1445:	cd 40                	int    $0x40
    1447:	c3                   	ret    

00001448 <setpriority>:
SYSCALL(setpriority)
    1448:	b8 18 00 00 00       	mov    $0x18,%eax
    144d:	cd 40                	int    $0x40
    144f:	c3                   	ret    

00001450 <v2p>:
SYSCALL(v2p)
    1450:	b8 19 00 00 00       	mov    $0x19,%eax
    1455:	cd 40                	int    $0x40
    1457:	c3                   	ret    
    1458:	90                   	nop
    1459:	90                   	nop
    145a:	90                   	nop
    145b:	90                   	nop
    145c:	90                   	nop
    145d:	90                   	nop
    145e:	90                   	nop
    145f:	90                   	nop

00001460 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
    1460:	55                   	push   %ebp
    1461:	89 e5                	mov    %esp,%ebp
    1463:	57                   	push   %edi
    1464:	89 cf                	mov    %ecx,%edi
    1466:	56                   	push   %esi
    1467:	89 c6                	mov    %eax,%esi
    1469:	53                   	push   %ebx
    146a:	83 ec 4c             	sub    $0x4c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    146d:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1470:	85 c9                	test   %ecx,%ecx
    1472:	74 04                	je     1478 <printint+0x18>
    1474:	85 d2                	test   %edx,%edx
    1476:	78 68                	js     14e0 <printint+0x80>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
    1478:	89 d0                	mov    %edx,%eax
    147a:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
    1481:	31 c9                	xor    %ecx,%ecx
    1483:	8d 5d d7             	lea    -0x29(%ebp),%ebx
    1486:	66 90                	xchg   %ax,%ax
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
    1488:	31 d2                	xor    %edx,%edx
    148a:	f7 f7                	div    %edi
    148c:	0f b6 92 80 18 00 00 	movzbl 0x1880(%edx),%edx
    1493:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
    1496:	83 c1 01             	add    $0x1,%ecx
  }while((x /= base) != 0);
    1499:	85 c0                	test   %eax,%eax
    149b:	75 eb                	jne    1488 <printint+0x28>
  if(neg)
    149d:	8b 45 c4             	mov    -0x3c(%ebp),%eax
    14a0:	85 c0                	test   %eax,%eax
    14a2:	74 08                	je     14ac <printint+0x4c>
    buf[i++] = '-';
    14a4:	c6 44 0d d7 2d       	movb   $0x2d,-0x29(%ebp,%ecx,1)
    14a9:	83 c1 01             	add    $0x1,%ecx

  while(--i >= 0)
    14ac:	8d 79 ff             	lea    -0x1(%ecx),%edi
    14af:	90                   	nop
    14b0:	0f b6 04 3b          	movzbl (%ebx,%edi,1),%eax
    14b4:	83 ef 01             	sub    $0x1,%edi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    14b7:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    14be:	00 
    14bf:	89 34 24             	mov    %esi,(%esp)
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
    14c2:	88 45 e7             	mov    %al,-0x19(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    14c5:	8d 45 e7             	lea    -0x19(%ebp),%eax
    14c8:	89 44 24 04          	mov    %eax,0x4(%esp)
    14cc:	e8 e7 fe ff ff       	call   13b8 <write>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
    14d1:	83 ff ff             	cmp    $0xffffffff,%edi
    14d4:	75 da                	jne    14b0 <printint+0x50>
    putc(fd, buf[i]);
}
    14d6:	83 c4 4c             	add    $0x4c,%esp
    14d9:	5b                   	pop    %ebx
    14da:	5e                   	pop    %esi
    14db:	5f                   	pop    %edi
    14dc:	5d                   	pop    %ebp
    14dd:	c3                   	ret    
    14de:	66 90                	xchg   %ax,%ax
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
    14e0:	89 d0                	mov    %edx,%eax
    14e2:	f7 d8                	neg    %eax
    14e4:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
    14eb:	eb 94                	jmp    1481 <printint+0x21>
    14ed:	8d 76 00             	lea    0x0(%esi),%esi

000014f0 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
    14f0:	55                   	push   %ebp
    14f1:	89 e5                	mov    %esp,%ebp
    14f3:	57                   	push   %edi
    14f4:	56                   	push   %esi
    14f5:	53                   	push   %ebx
    14f6:	83 ec 3c             	sub    $0x3c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    14f9:	8b 45 0c             	mov    0xc(%ebp),%eax
    14fc:	0f b6 10             	movzbl (%eax),%edx
    14ff:	84 d2                	test   %dl,%dl
    1501:	0f 84 c1 00 00 00    	je     15c8 <printf+0xd8>
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
    1507:	8d 4d 10             	lea    0x10(%ebp),%ecx
    150a:	31 ff                	xor    %edi,%edi
    150c:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
    150f:	31 db                	xor    %ebx,%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    1511:	8d 75 e7             	lea    -0x19(%ebp),%esi
    1514:	eb 1e                	jmp    1534 <printf+0x44>
    1516:	66 90                	xchg   %ax,%ax
  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
    1518:	83 fa 25             	cmp    $0x25,%edx
    151b:	0f 85 af 00 00 00    	jne    15d0 <printf+0xe0>
    1521:	66 bf 25 00          	mov    $0x25,%di
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    1525:	83 c3 01             	add    $0x1,%ebx
    1528:	0f b6 14 18          	movzbl (%eax,%ebx,1),%edx
    152c:	84 d2                	test   %dl,%dl
    152e:	0f 84 94 00 00 00    	je     15c8 <printf+0xd8>
    c = fmt[i] & 0xff;
    if(state == 0){
    1534:	85 ff                	test   %edi,%edi
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    1536:	0f b6 d2             	movzbl %dl,%edx
    if(state == 0){
    1539:	74 dd                	je     1518 <printf+0x28>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
    153b:	83 ff 25             	cmp    $0x25,%edi
    153e:	75 e5                	jne    1525 <printf+0x35>
      if(c == 'd'){
    1540:	83 fa 64             	cmp    $0x64,%edx
    1543:	0f 84 3f 01 00 00    	je     1688 <printf+0x198>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
    1549:	83 fa 70             	cmp    $0x70,%edx
    154c:	0f 84 a6 00 00 00    	je     15f8 <printf+0x108>
    1552:	83 fa 78             	cmp    $0x78,%edx
    1555:	0f 84 9d 00 00 00    	je     15f8 <printf+0x108>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
    155b:	83 fa 73             	cmp    $0x73,%edx
    155e:	66 90                	xchg   %ax,%ax
    1560:	0f 84 ba 00 00 00    	je     1620 <printf+0x130>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    1566:	83 fa 63             	cmp    $0x63,%edx
    1569:	0f 84 41 01 00 00    	je     16b0 <printf+0x1c0>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
    156f:	83 fa 25             	cmp    $0x25,%edx
    1572:	0f 84 00 01 00 00    	je     1678 <printf+0x188>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    1578:	8b 4d 08             	mov    0x8(%ebp),%ecx
    157b:	89 55 cc             	mov    %edx,-0x34(%ebp)
    157e:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
    1582:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    1589:	00 
    158a:	89 74 24 04          	mov    %esi,0x4(%esp)
    158e:	89 0c 24             	mov    %ecx,(%esp)
    1591:	e8 22 fe ff ff       	call   13b8 <write>
    1596:	8b 55 cc             	mov    -0x34(%ebp),%edx
    1599:	88 55 e7             	mov    %dl,-0x19(%ebp)
    159c:	8b 45 08             	mov    0x8(%ebp),%eax
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    159f:	83 c3 01             	add    $0x1,%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    15a2:	31 ff                	xor    %edi,%edi
    15a4:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    15ab:	00 
    15ac:	89 74 24 04          	mov    %esi,0x4(%esp)
    15b0:	89 04 24             	mov    %eax,(%esp)
    15b3:	e8 00 fe ff ff       	call   13b8 <write>
    15b8:	8b 45 0c             	mov    0xc(%ebp),%eax
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    15bb:	0f b6 14 18          	movzbl (%eax,%ebx,1),%edx
    15bf:	84 d2                	test   %dl,%dl
    15c1:	0f 85 6d ff ff ff    	jne    1534 <printf+0x44>
    15c7:	90                   	nop
        putc(fd, c);
      }
      state = 0;
    }
  }
}
    15c8:	83 c4 3c             	add    $0x3c,%esp
    15cb:	5b                   	pop    %ebx
    15cc:	5e                   	pop    %esi
    15cd:	5f                   	pop    %edi
    15ce:	5d                   	pop    %ebp
    15cf:	c3                   	ret    
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    15d0:	8b 45 08             	mov    0x8(%ebp),%eax
  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
    15d3:	88 55 e7             	mov    %dl,-0x19(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    15d6:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    15dd:	00 
    15de:	89 74 24 04          	mov    %esi,0x4(%esp)
    15e2:	89 04 24             	mov    %eax,(%esp)
    15e5:	e8 ce fd ff ff       	call   13b8 <write>
    15ea:	8b 45 0c             	mov    0xc(%ebp),%eax
    15ed:	e9 33 ff ff ff       	jmp    1525 <printf+0x35>
    15f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
    15f8:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    15fb:	b9 10 00 00 00       	mov    $0x10,%ecx
        ap++;
    1600:	31 ff                	xor    %edi,%edi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
    1602:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1609:	8b 10                	mov    (%eax),%edx
    160b:	8b 45 08             	mov    0x8(%ebp),%eax
    160e:	e8 4d fe ff ff       	call   1460 <printint>
    1613:	8b 45 0c             	mov    0xc(%ebp),%eax
        ap++;
    1616:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
    161a:	e9 06 ff ff ff       	jmp    1525 <printf+0x35>
    161f:	90                   	nop
      } else if(c == 's'){
        s = (char*)*ap;
    1620:	8b 55 d4             	mov    -0x2c(%ebp),%edx
        ap++;
        if(s == 0)
    1623:	b9 79 18 00 00       	mov    $0x1879,%ecx
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
        s = (char*)*ap;
    1628:	8b 3a                	mov    (%edx),%edi
        ap++;
    162a:	83 c2 04             	add    $0x4,%edx
    162d:	89 55 d4             	mov    %edx,-0x2c(%ebp)
        if(s == 0)
    1630:	85 ff                	test   %edi,%edi
    1632:	0f 44 f9             	cmove  %ecx,%edi
          s = "(null)";
        while(*s != 0){
    1635:	0f b6 17             	movzbl (%edi),%edx
    1638:	84 d2                	test   %dl,%dl
    163a:	74 33                	je     166f <printf+0x17f>
    163c:	89 5d d0             	mov    %ebx,-0x30(%ebp)
    163f:	8b 5d 08             	mov    0x8(%ebp),%ebx
    1642:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
          putc(fd, *s);
          s++;
    1648:	83 c7 01             	add    $0x1,%edi
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
    164b:	88 55 e7             	mov    %dl,-0x19(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    164e:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    1655:	00 
    1656:	89 74 24 04          	mov    %esi,0x4(%esp)
    165a:	89 1c 24             	mov    %ebx,(%esp)
    165d:	e8 56 fd ff ff       	call   13b8 <write>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
    1662:	0f b6 17             	movzbl (%edi),%edx
    1665:	84 d2                	test   %dl,%dl
    1667:	75 df                	jne    1648 <printf+0x158>
    1669:	8b 5d d0             	mov    -0x30(%ebp),%ebx
    166c:	8b 45 0c             	mov    0xc(%ebp),%eax
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    166f:	31 ff                	xor    %edi,%edi
    1671:	e9 af fe ff ff       	jmp    1525 <printf+0x35>
    1676:	66 90                	xchg   %ax,%ax
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
    1678:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
    167c:	e9 1b ff ff ff       	jmp    159c <printf+0xac>
    1681:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
    1688:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    168b:	b9 0a 00 00 00       	mov    $0xa,%ecx
        ap++;
    1690:	66 31 ff             	xor    %di,%di
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
    1693:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    169a:	8b 10                	mov    (%eax),%edx
    169c:	8b 45 08             	mov    0x8(%ebp),%eax
    169f:	e8 bc fd ff ff       	call   1460 <printint>
    16a4:	8b 45 0c             	mov    0xc(%ebp),%eax
        ap++;
    16a7:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
    16ab:	e9 75 fe ff ff       	jmp    1525 <printf+0x35>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    16b0:	8b 55 d4             	mov    -0x2c(%ebp),%edx
        putc(fd, *ap);
        ap++;
    16b3:	31 ff                	xor    %edi,%edi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    16b5:	8b 4d 08             	mov    0x8(%ebp),%ecx
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    16b8:	8b 02                	mov    (%edx),%eax
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    16ba:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    16c1:	00 
    16c2:	89 74 24 04          	mov    %esi,0x4(%esp)
    16c6:	89 0c 24             	mov    %ecx,(%esp)
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    16c9:	88 45 e7             	mov    %al,-0x19(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    16cc:	e8 e7 fc ff ff       	call   13b8 <write>
    16d1:	8b 45 0c             	mov    0xc(%ebp),%eax
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
        ap++;
    16d4:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
    16d8:	e9 48 fe ff ff       	jmp    1525 <printf+0x35>
    16dd:	90                   	nop
    16de:	90                   	nop
    16df:	90                   	nop

000016e0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    16e0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    16e1:	a1 9c 18 00 00       	mov    0x189c,%eax
static Header base;
static Header *freep;

void
free(void *ap)
{
    16e6:	89 e5                	mov    %esp,%ebp
    16e8:	57                   	push   %edi
    16e9:	56                   	push   %esi
    16ea:	53                   	push   %ebx
    16eb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
    16ee:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    16f1:	39 c8                	cmp    %ecx,%eax
    16f3:	73 1d                	jae    1712 <free+0x32>
    16f5:	8d 76 00             	lea    0x0(%esi),%esi
    16f8:	8b 10                	mov    (%eax),%edx
    16fa:	39 d1                	cmp    %edx,%ecx
    16fc:	72 1a                	jb     1718 <free+0x38>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    16fe:	39 d0                	cmp    %edx,%eax
    1700:	72 08                	jb     170a <free+0x2a>
    1702:	39 c8                	cmp    %ecx,%eax
    1704:	72 12                	jb     1718 <free+0x38>
    1706:	39 d1                	cmp    %edx,%ecx
    1708:	72 0e                	jb     1718 <free+0x38>
    170a:	89 d0                	mov    %edx,%eax
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    170c:	39 c8                	cmp    %ecx,%eax
    170e:	66 90                	xchg   %ax,%ax
    1710:	72 e6                	jb     16f8 <free+0x18>
    1712:	8b 10                	mov    (%eax),%edx
    1714:	eb e8                	jmp    16fe <free+0x1e>
    1716:	66 90                	xchg   %ax,%ax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    1718:	8b 71 04             	mov    0x4(%ecx),%esi
    171b:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    171e:	39 d7                	cmp    %edx,%edi
    1720:	74 19                	je     173b <free+0x5b>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
    1722:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    1725:	8b 50 04             	mov    0x4(%eax),%edx
    1728:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    172b:	39 ce                	cmp    %ecx,%esi
    172d:	74 23                	je     1752 <free+0x72>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
    172f:	89 08                	mov    %ecx,(%eax)
  freep = p;
    1731:	a3 9c 18 00 00       	mov    %eax,0x189c
}
    1736:	5b                   	pop    %ebx
    1737:	5e                   	pop    %esi
    1738:	5f                   	pop    %edi
    1739:	5d                   	pop    %ebp
    173a:	c3                   	ret    
  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
    173b:	03 72 04             	add    0x4(%edx),%esi
    173e:	89 71 04             	mov    %esi,0x4(%ecx)
    bp->s.ptr = p->s.ptr->s.ptr;
    1741:	8b 10                	mov    (%eax),%edx
    1743:	8b 12                	mov    (%edx),%edx
    1745:	89 53 f8             	mov    %edx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    1748:	8b 50 04             	mov    0x4(%eax),%edx
    174b:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    174e:	39 ce                	cmp    %ecx,%esi
    1750:	75 dd                	jne    172f <free+0x4f>
    p->s.size += bp->s.size;
    1752:	03 51 04             	add    0x4(%ecx),%edx
    1755:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    1758:	8b 53 f8             	mov    -0x8(%ebx),%edx
    175b:	89 10                	mov    %edx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
    175d:	a3 9c 18 00 00       	mov    %eax,0x189c
}
    1762:	5b                   	pop    %ebx
    1763:	5e                   	pop    %esi
    1764:	5f                   	pop    %edi
    1765:	5d                   	pop    %ebp
    1766:	c3                   	ret    
    1767:	89 f6                	mov    %esi,%esi
    1769:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001770 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    1770:	55                   	push   %ebp
    1771:	89 e5                	mov    %esp,%ebp
    1773:	57                   	push   %edi
    1774:	56                   	push   %esi
    1775:	53                   	push   %ebx
    1776:	83 ec 2c             	sub    $0x2c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1779:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if((prevp = freep) == 0){
    177c:	8b 0d 9c 18 00 00    	mov    0x189c,%ecx
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1782:	83 c3 07             	add    $0x7,%ebx
    1785:	c1 eb 03             	shr    $0x3,%ebx
    1788:	83 c3 01             	add    $0x1,%ebx
  if((prevp = freep) == 0){
    178b:	85 c9                	test   %ecx,%ecx
    178d:	0f 84 9b 00 00 00    	je     182e <malloc+0xbe>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1793:	8b 01                	mov    (%ecx),%eax
    if(p->s.size >= nunits){
    1795:	8b 50 04             	mov    0x4(%eax),%edx
    1798:	39 d3                	cmp    %edx,%ebx
    179a:	76 27                	jbe    17c3 <malloc+0x53>
        p->s.size -= nunits;
        p += p->s.size;
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    179c:	8d 3c dd 00 00 00 00 	lea    0x0(,%ebx,8),%edi
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < 4096)
    17a3:	be 00 80 00 00       	mov    $0x8000,%esi
    17a8:	89 7d e4             	mov    %edi,-0x1c(%ebp)
    17ab:	90                   	nop
    17ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    17b0:	3b 05 9c 18 00 00    	cmp    0x189c,%eax
    17b6:	74 30                	je     17e8 <malloc+0x78>
    17b8:	89 c1                	mov    %eax,%ecx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    17ba:	8b 01                	mov    (%ecx),%eax
    if(p->s.size >= nunits){
    17bc:	8b 50 04             	mov    0x4(%eax),%edx
    17bf:	39 d3                	cmp    %edx,%ebx
    17c1:	77 ed                	ja     17b0 <malloc+0x40>
      if(p->s.size == nunits)
    17c3:	39 d3                	cmp    %edx,%ebx
    17c5:	74 61                	je     1828 <malloc+0xb8>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
    17c7:	29 da                	sub    %ebx,%edx
    17c9:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
    17cc:	8d 04 d0             	lea    (%eax,%edx,8),%eax
        p->s.size = nunits;
    17cf:	89 58 04             	mov    %ebx,0x4(%eax)
      }
      freep = prevp;
    17d2:	89 0d 9c 18 00 00    	mov    %ecx,0x189c
      return (void*)(p + 1);
    17d8:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
    17db:	83 c4 2c             	add    $0x2c,%esp
    17de:	5b                   	pop    %ebx
    17df:	5e                   	pop    %esi
    17e0:	5f                   	pop    %edi
    17e1:	5d                   	pop    %ebp
    17e2:	c3                   	ret    
    17e3:	90                   	nop
    17e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < 4096)
    17e8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    17eb:	81 fb 00 10 00 00    	cmp    $0x1000,%ebx
    17f1:	bf 00 10 00 00       	mov    $0x1000,%edi
    17f6:	0f 43 fb             	cmovae %ebx,%edi
    17f9:	0f 42 c6             	cmovb  %esi,%eax
    nu = 4096;
  p = sbrk(nu * sizeof(Header));
    17fc:	89 04 24             	mov    %eax,(%esp)
    17ff:	e8 1c fc ff ff       	call   1420 <sbrk>
  if(p == (char*)-1)
    1804:	83 f8 ff             	cmp    $0xffffffff,%eax
    1807:	74 18                	je     1821 <malloc+0xb1>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
    1809:	89 78 04             	mov    %edi,0x4(%eax)
  free((void*)(hp + 1));
    180c:	83 c0 08             	add    $0x8,%eax
    180f:	89 04 24             	mov    %eax,(%esp)
    1812:	e8 c9 fe ff ff       	call   16e0 <free>
  return freep;
    1817:	8b 0d 9c 18 00 00    	mov    0x189c,%ecx
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
    181d:	85 c9                	test   %ecx,%ecx
    181f:	75 99                	jne    17ba <malloc+0x4a>
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
    1821:	31 c0                	xor    %eax,%eax
    1823:	eb b6                	jmp    17db <malloc+0x6b>
    1825:	8d 76 00             	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
    1828:	8b 10                	mov    (%eax),%edx
    182a:	89 11                	mov    %edx,(%ecx)
    182c:	eb a4                	jmp    17d2 <malloc+0x62>
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    182e:	c7 05 9c 18 00 00 94 	movl   $0x1894,0x189c
    1835:	18 00 00 
    base.s.size = 0;
    1838:	b9 94 18 00 00       	mov    $0x1894,%ecx
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    183d:	c7 05 94 18 00 00 94 	movl   $0x1894,0x1894
    1844:	18 00 00 
    base.s.size = 0;
    1847:	c7 05 98 18 00 00 00 	movl   $0x0,0x1898
    184e:	00 00 00 
    1851:	e9 3d ff ff ff       	jmp    1793 <malloc+0x23>
