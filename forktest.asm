
_forktest:     file format elf32-i386


Disassembly of section .text:

00001000 <printf>:

#define N  1000

void
printf(int fd, char *s, ...)
{
    1000:	55                   	push   %ebp
    1001:	89 e5                	mov    %esp,%ebp
    1003:	53                   	push   %ebx
    1004:	83 ec 14             	sub    $0x14,%esp
    1007:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  write(fd, s, strlen(s));
    100a:	89 1c 24             	mov    %ebx,(%esp)
    100d:	e8 ae 01 00 00       	call   11c0 <strlen>
    1012:	89 5c 24 04          	mov    %ebx,0x4(%esp)
    1016:	89 44 24 08          	mov    %eax,0x8(%esp)
    101a:	8b 45 08             	mov    0x8(%ebp),%eax
    101d:	89 04 24             	mov    %eax,(%esp)
    1020:	e8 63 03 00 00       	call   1388 <write>
}
    1025:	83 c4 14             	add    $0x14,%esp
    1028:	5b                   	pop    %ebx
    1029:	5d                   	pop    %ebp
    102a:	c3                   	ret    
    102b:	90                   	nop
    102c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00001030 <forktest>:

void
forktest(void)
{
    1030:	55                   	push   %ebp
    1031:	89 e5                	mov    %esp,%ebp
    1033:	56                   	push   %esi
    1034:	53                   	push   %ebx
  int n, pid, exit_status;

  printf(1, "fork test\n");
    1035:	31 db                	xor    %ebx,%ebx
  write(fd, s, strlen(s));
}

void
forktest(void)
{
    1037:	83 ec 20             	sub    $0x20,%esp
  int n, pid, exit_status;

  printf(1, "fork test\n");
    103a:	c7 44 24 04 28 14 00 	movl   $0x1428,0x4(%esp)
    1041:	00 
    1042:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1049:	e8 b2 ff ff ff       	call   1000 <printf>
    104e:	eb 0d                	jmp    105d <forktest+0x2d>

  for(n=0; n<N; n++){
    pid = fork();
    if(pid < 0)
      break;
    if(pid == 0)
    1050:	74 7a                	je     10cc <forktest+0x9c>
{
  int n, pid, exit_status;

  printf(1, "fork test\n");

  for(n=0; n<N; n++){
    1052:	83 c3 01             	add    $0x1,%ebx
    1055:	81 fb e8 03 00 00    	cmp    $0x3e8,%ebx
    105b:	74 53                	je     10b0 <forktest+0x80>
    pid = fork();
    105d:	e8 fe 02 00 00       	call   1360 <fork>
    if(pid < 0)
    1062:	83 f8 00             	cmp    $0x0,%eax
    1065:	7d e9                	jge    1050 <forktest+0x20>
  if(n == N){
    printf(1, "fork claimed to work N times!\n", N);
    exit(0);
  }

  for(; n > 0; n--){
    1067:	85 db                	test   %ebx,%ebx
    1069:	8d 75 f4             	lea    -0xc(%ebp),%esi
    106c:	74 13                	je     1081 <forktest+0x51>
    106e:	66 90                	xchg   %ax,%ax
    if(wait(&exit_status) < 0){
    1070:	89 34 24             	mov    %esi,(%esp)
    1073:	e8 f8 02 00 00       	call   1370 <wait>
    1078:	85 c0                	test   %eax,%eax
    107a:	78 5c                	js     10d8 <forktest+0xa8>
  if(n == N){
    printf(1, "fork claimed to work N times!\n", N);
    exit(0);
  }

  for(; n > 0; n--){
    107c:	83 eb 01             	sub    $0x1,%ebx
    107f:	75 ef                	jne    1070 <forktest+0x40>
      printf(1, "wait stopped early\n");
      exit(0);
    }
  }

  if(wait(&exit_status) != -1){
    1081:	89 34 24             	mov    %esi,(%esp)
    1084:	e8 e7 02 00 00       	call   1370 <wait>
    1089:	83 f8 ff             	cmp    $0xffffffff,%eax
    108c:	75 6a                	jne    10f8 <forktest+0xc8>
    printf(1, "wait got too many\n");
    exit(0);
  }

  printf(1, "fork test OK\n");
    108e:	c7 44 24 04 5a 14 00 	movl   $0x145a,0x4(%esp)
    1095:	00 
    1096:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    109d:	e8 5e ff ff ff       	call   1000 <printf>
}
    10a2:	83 c4 20             	add    $0x20,%esp
    10a5:	5b                   	pop    %ebx
    10a6:	5e                   	pop    %esi
    10a7:	5d                   	pop    %ebp
    10a8:	c3                   	ret    
    10a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(pid == 0)
      exit(0);
  }

  if(n == N){
    printf(1, "fork claimed to work N times!\n", N);
    10b0:	c7 44 24 08 e8 03 00 	movl   $0x3e8,0x8(%esp)
    10b7:	00 
    10b8:	c7 44 24 04 68 14 00 	movl   $0x1468,0x4(%esp)
    10bf:	00 
    10c0:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    10c7:	e8 34 ff ff ff       	call   1000 <printf>
    exit(0);
    10cc:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    10d3:	e8 90 02 00 00       	call   1368 <exit>
  }

  for(; n > 0; n--){
    if(wait(&exit_status) < 0){
      printf(1, "wait stopped early\n");
    10d8:	c7 44 24 04 33 14 00 	movl   $0x1433,0x4(%esp)
    10df:	00 
    10e0:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    10e7:	e8 14 ff ff ff       	call   1000 <printf>
      exit(0);
    10ec:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    10f3:	e8 70 02 00 00       	call   1368 <exit>
    }
  }

  if(wait(&exit_status) != -1){
    printf(1, "wait got too many\n");
    10f8:	c7 44 24 04 47 14 00 	movl   $0x1447,0x4(%esp)
    10ff:	00 
    1100:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1107:	e8 f4 fe ff ff       	call   1000 <printf>
    exit(0);
    110c:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1113:	e8 50 02 00 00       	call   1368 <exit>
    1118:	90                   	nop
    1119:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00001120 <main>:
  printf(1, "fork test OK\n");
}

int
main(void)
{
    1120:	55                   	push   %ebp
    1121:	89 e5                	mov    %esp,%ebp
    1123:	83 e4 f0             	and    $0xfffffff0,%esp
    1126:	83 ec 10             	sub    $0x10,%esp
  forktest();
    1129:	e8 02 ff ff ff       	call   1030 <forktest>
  exit(0);
    112e:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1135:	e8 2e 02 00 00       	call   1368 <exit>
    113a:	90                   	nop
    113b:	90                   	nop
    113c:	90                   	nop
    113d:	90                   	nop
    113e:	90                   	nop
    113f:	90                   	nop

00001140 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
    1140:	55                   	push   %ebp
    1141:	31 d2                	xor    %edx,%edx
    1143:	89 e5                	mov    %esp,%ebp
    1145:	8b 45 08             	mov    0x8(%ebp),%eax
    1148:	53                   	push   %ebx
    1149:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    114c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
    1150:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
    1154:	88 0c 10             	mov    %cl,(%eax,%edx,1)
    1157:	83 c2 01             	add    $0x1,%edx
    115a:	84 c9                	test   %cl,%cl
    115c:	75 f2                	jne    1150 <strcpy+0x10>
    ;
  return os;
}
    115e:	5b                   	pop    %ebx
    115f:	5d                   	pop    %ebp
    1160:	c3                   	ret    
    1161:	eb 0d                	jmp    1170 <strcmp>
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

00001170 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    1170:	55                   	push   %ebp
    1171:	89 e5                	mov    %esp,%ebp
    1173:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1176:	53                   	push   %ebx
    1177:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(*p && *p == *q)
    117a:	0f b6 01             	movzbl (%ecx),%eax
    117d:	84 c0                	test   %al,%al
    117f:	75 14                	jne    1195 <strcmp+0x25>
    1181:	eb 25                	jmp    11a8 <strcmp+0x38>
    1183:	90                   	nop
    1184:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    p++, q++;
    1188:	83 c1 01             	add    $0x1,%ecx
    118b:	83 c2 01             	add    $0x1,%edx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
    118e:	0f b6 01             	movzbl (%ecx),%eax
    1191:	84 c0                	test   %al,%al
    1193:	74 13                	je     11a8 <strcmp+0x38>
    1195:	0f b6 1a             	movzbl (%edx),%ebx
    1198:	38 d8                	cmp    %bl,%al
    119a:	74 ec                	je     1188 <strcmp+0x18>
    119c:	0f b6 db             	movzbl %bl,%ebx
    119f:	0f b6 c0             	movzbl %al,%eax
    11a2:	29 d8                	sub    %ebx,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
    11a4:	5b                   	pop    %ebx
    11a5:	5d                   	pop    %ebp
    11a6:	c3                   	ret    
    11a7:	90                   	nop
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
    11a8:	0f b6 1a             	movzbl (%edx),%ebx
    11ab:	31 c0                	xor    %eax,%eax
    11ad:	0f b6 db             	movzbl %bl,%ebx
    11b0:	29 d8                	sub    %ebx,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
    11b2:	5b                   	pop    %ebx
    11b3:	5d                   	pop    %ebp
    11b4:	c3                   	ret    
    11b5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    11b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000011c0 <strlen>:

uint
strlen(char *s)
{
    11c0:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
    11c1:	31 d2                	xor    %edx,%edx
  return (uchar)*p - (uchar)*q;
}

uint
strlen(char *s)
{
    11c3:	89 e5                	mov    %esp,%ebp
  int n;

  for(n = 0; s[n]; n++)
    11c5:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
}

uint
strlen(char *s)
{
    11c7:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
    11ca:	80 39 00             	cmpb   $0x0,(%ecx)
    11cd:	74 0c                	je     11db <strlen+0x1b>
    11cf:	90                   	nop
    11d0:	83 c2 01             	add    $0x1,%edx
    11d3:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
    11d7:	89 d0                	mov    %edx,%eax
    11d9:	75 f5                	jne    11d0 <strlen+0x10>
    ;
  return n;
}
    11db:	5d                   	pop    %ebp
    11dc:	c3                   	ret    
    11dd:	8d 76 00             	lea    0x0(%esi),%esi

000011e0 <memset>:

void*
memset(void *dst, int c, uint n)
{
    11e0:	55                   	push   %ebp
    11e1:	89 e5                	mov    %esp,%ebp
    11e3:	8b 55 08             	mov    0x8(%ebp),%edx
    11e6:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
    11e7:	8b 4d 10             	mov    0x10(%ebp),%ecx
    11ea:	8b 45 0c             	mov    0xc(%ebp),%eax
    11ed:	89 d7                	mov    %edx,%edi
    11ef:	fc                   	cld    
    11f0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
    11f2:	89 d0                	mov    %edx,%eax
    11f4:	5f                   	pop    %edi
    11f5:	5d                   	pop    %ebp
    11f6:	c3                   	ret    
    11f7:	89 f6                	mov    %esi,%esi
    11f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001200 <strchr>:

char*
strchr(const char *s, char c)
{
    1200:	55                   	push   %ebp
    1201:	89 e5                	mov    %esp,%ebp
    1203:	8b 45 08             	mov    0x8(%ebp),%eax
    1206:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
    120a:	0f b6 10             	movzbl (%eax),%edx
    120d:	84 d2                	test   %dl,%dl
    120f:	75 11                	jne    1222 <strchr+0x22>
    1211:	eb 15                	jmp    1228 <strchr+0x28>
    1213:	90                   	nop
    1214:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1218:	83 c0 01             	add    $0x1,%eax
    121b:	0f b6 10             	movzbl (%eax),%edx
    121e:	84 d2                	test   %dl,%dl
    1220:	74 06                	je     1228 <strchr+0x28>
    if(*s == c)
    1222:	38 ca                	cmp    %cl,%dl
    1224:	75 f2                	jne    1218 <strchr+0x18>
      return (char*)s;
  return 0;
}
    1226:	5d                   	pop    %ebp
    1227:	c3                   	ret    
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
    1228:	31 c0                	xor    %eax,%eax
    if(*s == c)
      return (char*)s;
  return 0;
}
    122a:	5d                   	pop    %ebp
    122b:	90                   	nop
    122c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1230:	c3                   	ret    
    1231:	eb 0d                	jmp    1240 <atoi>
    1233:	90                   	nop
    1234:	90                   	nop
    1235:	90                   	nop
    1236:	90                   	nop
    1237:	90                   	nop
    1238:	90                   	nop
    1239:	90                   	nop
    123a:	90                   	nop
    123b:	90                   	nop
    123c:	90                   	nop
    123d:	90                   	nop
    123e:	90                   	nop
    123f:	90                   	nop

00001240 <atoi>:
  return r;
}

int
atoi(const char *s)
{
    1240:	55                   	push   %ebp
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    1241:	31 c0                	xor    %eax,%eax
  return r;
}

int
atoi(const char *s)
{
    1243:	89 e5                	mov    %esp,%ebp
    1245:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1248:	53                   	push   %ebx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    1249:	0f b6 11             	movzbl (%ecx),%edx
    124c:	8d 5a d0             	lea    -0x30(%edx),%ebx
    124f:	80 fb 09             	cmp    $0x9,%bl
    1252:	77 1c                	ja     1270 <atoi+0x30>
    1254:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    n = n*10 + *s++ - '0';
    1258:	0f be d2             	movsbl %dl,%edx
    125b:	83 c1 01             	add    $0x1,%ecx
    125e:	8d 04 80             	lea    (%eax,%eax,4),%eax
    1261:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    1265:	0f b6 11             	movzbl (%ecx),%edx
    1268:	8d 5a d0             	lea    -0x30(%edx),%ebx
    126b:	80 fb 09             	cmp    $0x9,%bl
    126e:	76 e8                	jbe    1258 <atoi+0x18>
    n = n*10 + *s++ - '0';
  return n;
}
    1270:	5b                   	pop    %ebx
    1271:	5d                   	pop    %ebp
    1272:	c3                   	ret    
    1273:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    1279:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001280 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
    1280:	55                   	push   %ebp
    1281:	89 e5                	mov    %esp,%ebp
    1283:	56                   	push   %esi
    1284:	8b 45 08             	mov    0x8(%ebp),%eax
    1287:	53                   	push   %ebx
    1288:	8b 5d 10             	mov    0x10(%ebp),%ebx
    128b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    128e:	85 db                	test   %ebx,%ebx
    1290:	7e 14                	jle    12a6 <memmove+0x26>
    n = n*10 + *s++ - '0';
  return n;
}

void*
memmove(void *vdst, void *vsrc, int n)
    1292:	31 d2                	xor    %edx,%edx
    1294:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    *dst++ = *src++;
    1298:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
    129c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
    129f:	83 c2 01             	add    $0x1,%edx
{
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    12a2:	39 da                	cmp    %ebx,%edx
    12a4:	75 f2                	jne    1298 <memmove+0x18>
    *dst++ = *src++;
  return vdst;
}
    12a6:	5b                   	pop    %ebx
    12a7:	5e                   	pop    %esi
    12a8:	5d                   	pop    %ebp
    12a9:	c3                   	ret    
    12aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000012b0 <stat>:
  return buf;
}

int
stat(char *n, struct stat *st)
{
    12b0:	55                   	push   %ebp
    12b1:	89 e5                	mov    %esp,%ebp
    12b3:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    12b6:	8b 45 08             	mov    0x8(%ebp),%eax
  return buf;
}

int
stat(char *n, struct stat *st)
{
    12b9:	89 5d f8             	mov    %ebx,-0x8(%ebp)
    12bc:	89 75 fc             	mov    %esi,-0x4(%ebp)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    12bf:	be ff ff ff ff       	mov    $0xffffffff,%esi
stat(char *n, struct stat *st)
{
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    12c4:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    12cb:	00 
    12cc:	89 04 24             	mov    %eax,(%esp)
    12cf:	e8 d4 00 00 00       	call   13a8 <open>
  if(fd < 0)
    12d4:	85 c0                	test   %eax,%eax
stat(char *n, struct stat *st)
{
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    12d6:	89 c3                	mov    %eax,%ebx
  if(fd < 0)
    12d8:	78 19                	js     12f3 <stat+0x43>
    return -1;
  r = fstat(fd, st);
    12da:	8b 45 0c             	mov    0xc(%ebp),%eax
    12dd:	89 1c 24             	mov    %ebx,(%esp)
    12e0:	89 44 24 04          	mov    %eax,0x4(%esp)
    12e4:	e8 d7 00 00 00       	call   13c0 <fstat>
  close(fd);
    12e9:	89 1c 24             	mov    %ebx,(%esp)
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
  r = fstat(fd, st);
    12ec:	89 c6                	mov    %eax,%esi
  close(fd);
    12ee:	e8 9d 00 00 00       	call   1390 <close>
  return r;
}
    12f3:	89 f0                	mov    %esi,%eax
    12f5:	8b 5d f8             	mov    -0x8(%ebp),%ebx
    12f8:	8b 75 fc             	mov    -0x4(%ebp),%esi
    12fb:	89 ec                	mov    %ebp,%esp
    12fd:	5d                   	pop    %ebp
    12fe:	c3                   	ret    
    12ff:	90                   	nop

00001300 <gets>:
  return 0;
}

char*
gets(char *buf, int max)
{
    1300:	55                   	push   %ebp
    1301:	89 e5                	mov    %esp,%ebp
    1303:	57                   	push   %edi
    1304:	56                   	push   %esi
    1305:	31 f6                	xor    %esi,%esi
    1307:	53                   	push   %ebx
    1308:	83 ec 2c             	sub    $0x2c,%esp
    130b:	8b 7d 08             	mov    0x8(%ebp),%edi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    130e:	eb 06                	jmp    1316 <gets+0x16>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
    1310:	3c 0a                	cmp    $0xa,%al
    1312:	74 39                	je     134d <gets+0x4d>
    1314:	89 de                	mov    %ebx,%esi
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    1316:	8d 5e 01             	lea    0x1(%esi),%ebx
    1319:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
    131c:	7d 31                	jge    134f <gets+0x4f>
    cc = read(0, &c, 1);
    131e:	8d 45 e7             	lea    -0x19(%ebp),%eax
    1321:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    1328:	00 
    1329:	89 44 24 04          	mov    %eax,0x4(%esp)
    132d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1334:	e8 47 00 00 00       	call   1380 <read>
    if(cc < 1)
    1339:	85 c0                	test   %eax,%eax
    133b:	7e 12                	jle    134f <gets+0x4f>
      break;
    buf[i++] = c;
    133d:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
    1341:	88 44 1f ff          	mov    %al,-0x1(%edi,%ebx,1)
    if(c == '\n' || c == '\r')
    1345:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
    1349:	3c 0d                	cmp    $0xd,%al
    134b:	75 c3                	jne    1310 <gets+0x10>
    134d:	89 de                	mov    %ebx,%esi
      break;
  }
  buf[i] = '\0';
    134f:	c6 04 37 00          	movb   $0x0,(%edi,%esi,1)
  return buf;
}
    1353:	89 f8                	mov    %edi,%eax
    1355:	83 c4 2c             	add    $0x2c,%esp
    1358:	5b                   	pop    %ebx
    1359:	5e                   	pop    %esi
    135a:	5f                   	pop    %edi
    135b:	5d                   	pop    %ebp
    135c:	c3                   	ret    
    135d:	90                   	nop
    135e:	90                   	nop
    135f:	90                   	nop

00001360 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    1360:	b8 01 00 00 00       	mov    $0x1,%eax
    1365:	cd 40                	int    $0x40
    1367:	c3                   	ret    

00001368 <exit>:
SYSCALL(exit)
    1368:	b8 02 00 00 00       	mov    $0x2,%eax
    136d:	cd 40                	int    $0x40
    136f:	c3                   	ret    

00001370 <wait>:
SYSCALL(wait)
    1370:	b8 03 00 00 00       	mov    $0x3,%eax
    1375:	cd 40                	int    $0x40
    1377:	c3                   	ret    

00001378 <pipe>:
SYSCALL(pipe)
    1378:	b8 04 00 00 00       	mov    $0x4,%eax
    137d:	cd 40                	int    $0x40
    137f:	c3                   	ret    

00001380 <read>:
SYSCALL(read)
    1380:	b8 05 00 00 00       	mov    $0x5,%eax
    1385:	cd 40                	int    $0x40
    1387:	c3                   	ret    

00001388 <write>:
SYSCALL(write)
    1388:	b8 10 00 00 00       	mov    $0x10,%eax
    138d:	cd 40                	int    $0x40
    138f:	c3                   	ret    

00001390 <close>:
SYSCALL(close)
    1390:	b8 15 00 00 00       	mov    $0x15,%eax
    1395:	cd 40                	int    $0x40
    1397:	c3                   	ret    

00001398 <kill>:
SYSCALL(kill)
    1398:	b8 06 00 00 00       	mov    $0x6,%eax
    139d:	cd 40                	int    $0x40
    139f:	c3                   	ret    

000013a0 <exec>:
SYSCALL(exec)
    13a0:	b8 07 00 00 00       	mov    $0x7,%eax
    13a5:	cd 40                	int    $0x40
    13a7:	c3                   	ret    

000013a8 <open>:
SYSCALL(open)
    13a8:	b8 0f 00 00 00       	mov    $0xf,%eax
    13ad:	cd 40                	int    $0x40
    13af:	c3                   	ret    

000013b0 <mknod>:
SYSCALL(mknod)
    13b0:	b8 11 00 00 00       	mov    $0x11,%eax
    13b5:	cd 40                	int    $0x40
    13b7:	c3                   	ret    

000013b8 <unlink>:
SYSCALL(unlink)
    13b8:	b8 12 00 00 00       	mov    $0x12,%eax
    13bd:	cd 40                	int    $0x40
    13bf:	c3                   	ret    

000013c0 <fstat>:
SYSCALL(fstat)
    13c0:	b8 08 00 00 00       	mov    $0x8,%eax
    13c5:	cd 40                	int    $0x40
    13c7:	c3                   	ret    

000013c8 <link>:
SYSCALL(link)
    13c8:	b8 13 00 00 00       	mov    $0x13,%eax
    13cd:	cd 40                	int    $0x40
    13cf:	c3                   	ret    

000013d0 <mkdir>:
SYSCALL(mkdir)
    13d0:	b8 14 00 00 00       	mov    $0x14,%eax
    13d5:	cd 40                	int    $0x40
    13d7:	c3                   	ret    

000013d8 <chdir>:
SYSCALL(chdir)
    13d8:	b8 09 00 00 00       	mov    $0x9,%eax
    13dd:	cd 40                	int    $0x40
    13df:	c3                   	ret    

000013e0 <dup>:
SYSCALL(dup)
    13e0:	b8 0a 00 00 00       	mov    $0xa,%eax
    13e5:	cd 40                	int    $0x40
    13e7:	c3                   	ret    

000013e8 <getpid>:
SYSCALL(getpid)
    13e8:	b8 0b 00 00 00       	mov    $0xb,%eax
    13ed:	cd 40                	int    $0x40
    13ef:	c3                   	ret    

000013f0 <sbrk>:
SYSCALL(sbrk)
    13f0:	b8 0c 00 00 00       	mov    $0xc,%eax
    13f5:	cd 40                	int    $0x40
    13f7:	c3                   	ret    

000013f8 <sleep>:
SYSCALL(sleep)
    13f8:	b8 0d 00 00 00       	mov    $0xd,%eax
    13fd:	cd 40                	int    $0x40
    13ff:	c3                   	ret    

00001400 <uptime>:
SYSCALL(uptime)
    1400:	b8 0e 00 00 00       	mov    $0xe,%eax
    1405:	cd 40                	int    $0x40
    1407:	c3                   	ret    

00001408 <hello>:
SYSCALL(hello)
    1408:	b8 16 00 00 00       	mov    $0x16,%eax
    140d:	cd 40                	int    $0x40
    140f:	c3                   	ret    

00001410 <waitpid>:
SYSCALL(waitpid)
    1410:	b8 17 00 00 00       	mov    $0x17,%eax
    1415:	cd 40                	int    $0x40
    1417:	c3                   	ret    

00001418 <setpriority>:
SYSCALL(setpriority)
    1418:	b8 18 00 00 00       	mov    $0x18,%eax
    141d:	cd 40                	int    $0x40
    141f:	c3                   	ret    

00001420 <v2p>:
SYSCALL(v2p)
    1420:	b8 19 00 00 00       	mov    $0x19,%eax
    1425:	cd 40                	int    $0x40
    1427:	c3                   	ret    
