
_init:     file format elf32-i386


Disassembly of section .text:

00001000 <main>:

char *argv[] = { "sh", 0 };

int
main(void)
{
    1000:	55                   	push   %ebp
    1001:	89 e5                	mov    %esp,%ebp
    1003:	83 e4 f0             	and    $0xfffffff0,%esp
    1006:	53                   	push   %ebx
    1007:	83 ec 1c             	sub    $0x1c,%esp
  int pid, wpid;

  if(open("console", O_RDWR) < 0){
    100a:	c7 44 24 04 02 00 00 	movl   $0x2,0x4(%esp)
    1011:	00 
    1012:	c7 04 24 06 18 00 00 	movl   $0x1806,(%esp)
    1019:	e8 6a 03 00 00       	call   1388 <open>
    101e:	85 c0                	test   %eax,%eax
    1020:	0f 88 be 00 00 00    	js     10e4 <main+0xe4>
    mknod("console", 1, 1);
    open("console", O_RDWR);
  }
  dup(0);  // stdout
    1026:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    102d:	e8 8e 03 00 00       	call   13c0 <dup>
  dup(0);  // stderr
    1032:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1039:	e8 82 03 00 00       	call   13c0 <dup>
    103e:	66 90                	xchg   %ax,%ax

  for(;;){
    printf(1, "init: starting sh\n");
    1040:	c7 44 24 04 0e 18 00 	movl   $0x180e,0x4(%esp)
    1047:	00 
    1048:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    104f:	e8 4c 04 00 00       	call   14a0 <printf>
    pid = fork();
    1054:	e8 e7 02 00 00       	call   1340 <fork>
    if(pid < 0){
    1059:	83 f8 00             	cmp    $0x0,%eax
  dup(0);  // stdout
  dup(0);  // stderr

  for(;;){
    printf(1, "init: starting sh\n");
    pid = fork();
    105c:	89 c3                	mov    %eax,%ebx
    if(pid < 0){
    105e:	7c 30                	jl     1090 <main+0x90>
      printf(1, "init: fork failed\n");
      exit(0);
    }
    if(pid == 0){
    1060:	74 4e                	je     10b0 <main+0xb0>
      exec("sh", argv);
      printf(1, "init: exec sh failed\n");
      exit(0);
    }
    while((wpid=wait(0)) >= 0 && wpid != pid)
    1062:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1069:	e8 e2 02 00 00       	call   1350 <wait>
    106e:	85 c0                	test   %eax,%eax
    1070:	78 ce                	js     1040 <main+0x40>
    1072:	39 c3                	cmp    %eax,%ebx
    1074:	74 ca                	je     1040 <main+0x40>
      printf(1, "zombie!\n");
    1076:	c7 44 24 04 4d 18 00 	movl   $0x184d,0x4(%esp)
    107d:	00 
    107e:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1085:	e8 16 04 00 00       	call   14a0 <printf>
    108a:	eb d6                	jmp    1062 <main+0x62>
    108c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  for(;;){
    printf(1, "init: starting sh\n");
    pid = fork();
    if(pid < 0){
      printf(1, "init: fork failed\n");
    1090:	c7 44 24 04 21 18 00 	movl   $0x1821,0x4(%esp)
    1097:	00 
    1098:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    109f:	e8 fc 03 00 00       	call   14a0 <printf>
      exit(0);
    10a4:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    10ab:	e8 98 02 00 00       	call   1348 <exit>
    }
    if(pid == 0){
      exec("sh", argv);
    10b0:	c7 44 24 04 70 18 00 	movl   $0x1870,0x4(%esp)
    10b7:	00 
    10b8:	c7 04 24 34 18 00 00 	movl   $0x1834,(%esp)
    10bf:	e8 bc 02 00 00       	call   1380 <exec>
      printf(1, "init: exec sh failed\n");
    10c4:	c7 44 24 04 37 18 00 	movl   $0x1837,0x4(%esp)
    10cb:	00 
    10cc:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    10d3:	e8 c8 03 00 00       	call   14a0 <printf>
      exit(0);
    10d8:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    10df:	e8 64 02 00 00       	call   1348 <exit>
main(void)
{
  int pid, wpid;

  if(open("console", O_RDWR) < 0){
    mknod("console", 1, 1);
    10e4:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    10eb:	00 
    10ec:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
    10f3:	00 
    10f4:	c7 04 24 06 18 00 00 	movl   $0x1806,(%esp)
    10fb:	e8 90 02 00 00       	call   1390 <mknod>
    open("console", O_RDWR);
    1100:	c7 44 24 04 02 00 00 	movl   $0x2,0x4(%esp)
    1107:	00 
    1108:	c7 04 24 06 18 00 00 	movl   $0x1806,(%esp)
    110f:	e8 74 02 00 00       	call   1388 <open>
    1114:	e9 0d ff ff ff       	jmp    1026 <main+0x26>
    1119:	90                   	nop
    111a:	90                   	nop
    111b:	90                   	nop
    111c:	90                   	nop
    111d:	90                   	nop
    111e:	90                   	nop
    111f:	90                   	nop

00001120 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
    1120:	55                   	push   %ebp
    1121:	31 d2                	xor    %edx,%edx
    1123:	89 e5                	mov    %esp,%ebp
    1125:	8b 45 08             	mov    0x8(%ebp),%eax
    1128:	53                   	push   %ebx
    1129:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    112c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
    1130:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
    1134:	88 0c 10             	mov    %cl,(%eax,%edx,1)
    1137:	83 c2 01             	add    $0x1,%edx
    113a:	84 c9                	test   %cl,%cl
    113c:	75 f2                	jne    1130 <strcpy+0x10>
    ;
  return os;
}
    113e:	5b                   	pop    %ebx
    113f:	5d                   	pop    %ebp
    1140:	c3                   	ret    
    1141:	eb 0d                	jmp    1150 <strcmp>
    1143:	90                   	nop
    1144:	90                   	nop
    1145:	90                   	nop
    1146:	90                   	nop
    1147:	90                   	nop
    1148:	90                   	nop
    1149:	90                   	nop
    114a:	90                   	nop
    114b:	90                   	nop
    114c:	90                   	nop
    114d:	90                   	nop
    114e:	90                   	nop
    114f:	90                   	nop

00001150 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    1150:	55                   	push   %ebp
    1151:	89 e5                	mov    %esp,%ebp
    1153:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1156:	53                   	push   %ebx
    1157:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(*p && *p == *q)
    115a:	0f b6 01             	movzbl (%ecx),%eax
    115d:	84 c0                	test   %al,%al
    115f:	75 14                	jne    1175 <strcmp+0x25>
    1161:	eb 25                	jmp    1188 <strcmp+0x38>
    1163:	90                   	nop
    1164:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    p++, q++;
    1168:	83 c1 01             	add    $0x1,%ecx
    116b:	83 c2 01             	add    $0x1,%edx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
    116e:	0f b6 01             	movzbl (%ecx),%eax
    1171:	84 c0                	test   %al,%al
    1173:	74 13                	je     1188 <strcmp+0x38>
    1175:	0f b6 1a             	movzbl (%edx),%ebx
    1178:	38 d8                	cmp    %bl,%al
    117a:	74 ec                	je     1168 <strcmp+0x18>
    117c:	0f b6 db             	movzbl %bl,%ebx
    117f:	0f b6 c0             	movzbl %al,%eax
    1182:	29 d8                	sub    %ebx,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
    1184:	5b                   	pop    %ebx
    1185:	5d                   	pop    %ebp
    1186:	c3                   	ret    
    1187:	90                   	nop
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
    1188:	0f b6 1a             	movzbl (%edx),%ebx
    118b:	31 c0                	xor    %eax,%eax
    118d:	0f b6 db             	movzbl %bl,%ebx
    1190:	29 d8                	sub    %ebx,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
    1192:	5b                   	pop    %ebx
    1193:	5d                   	pop    %ebp
    1194:	c3                   	ret    
    1195:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1199:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000011a0 <strlen>:

uint
strlen(char *s)
{
    11a0:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
    11a1:	31 d2                	xor    %edx,%edx
  return (uchar)*p - (uchar)*q;
}

uint
strlen(char *s)
{
    11a3:	89 e5                	mov    %esp,%ebp
  int n;

  for(n = 0; s[n]; n++)
    11a5:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
}

uint
strlen(char *s)
{
    11a7:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
    11aa:	80 39 00             	cmpb   $0x0,(%ecx)
    11ad:	74 0c                	je     11bb <strlen+0x1b>
    11af:	90                   	nop
    11b0:	83 c2 01             	add    $0x1,%edx
    11b3:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
    11b7:	89 d0                	mov    %edx,%eax
    11b9:	75 f5                	jne    11b0 <strlen+0x10>
    ;
  return n;
}
    11bb:	5d                   	pop    %ebp
    11bc:	c3                   	ret    
    11bd:	8d 76 00             	lea    0x0(%esi),%esi

000011c0 <memset>:

void*
memset(void *dst, int c, uint n)
{
    11c0:	55                   	push   %ebp
    11c1:	89 e5                	mov    %esp,%ebp
    11c3:	8b 55 08             	mov    0x8(%ebp),%edx
    11c6:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
    11c7:	8b 4d 10             	mov    0x10(%ebp),%ecx
    11ca:	8b 45 0c             	mov    0xc(%ebp),%eax
    11cd:	89 d7                	mov    %edx,%edi
    11cf:	fc                   	cld    
    11d0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
    11d2:	89 d0                	mov    %edx,%eax
    11d4:	5f                   	pop    %edi
    11d5:	5d                   	pop    %ebp
    11d6:	c3                   	ret    
    11d7:	89 f6                	mov    %esi,%esi
    11d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000011e0 <strchr>:

char*
strchr(const char *s, char c)
{
    11e0:	55                   	push   %ebp
    11e1:	89 e5                	mov    %esp,%ebp
    11e3:	8b 45 08             	mov    0x8(%ebp),%eax
    11e6:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
    11ea:	0f b6 10             	movzbl (%eax),%edx
    11ed:	84 d2                	test   %dl,%dl
    11ef:	75 11                	jne    1202 <strchr+0x22>
    11f1:	eb 15                	jmp    1208 <strchr+0x28>
    11f3:	90                   	nop
    11f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    11f8:	83 c0 01             	add    $0x1,%eax
    11fb:	0f b6 10             	movzbl (%eax),%edx
    11fe:	84 d2                	test   %dl,%dl
    1200:	74 06                	je     1208 <strchr+0x28>
    if(*s == c)
    1202:	38 ca                	cmp    %cl,%dl
    1204:	75 f2                	jne    11f8 <strchr+0x18>
      return (char*)s;
  return 0;
}
    1206:	5d                   	pop    %ebp
    1207:	c3                   	ret    
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
    1208:	31 c0                	xor    %eax,%eax
    if(*s == c)
      return (char*)s;
  return 0;
}
    120a:	5d                   	pop    %ebp
    120b:	90                   	nop
    120c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1210:	c3                   	ret    
    1211:	eb 0d                	jmp    1220 <atoi>
    1213:	90                   	nop
    1214:	90                   	nop
    1215:	90                   	nop
    1216:	90                   	nop
    1217:	90                   	nop
    1218:	90                   	nop
    1219:	90                   	nop
    121a:	90                   	nop
    121b:	90                   	nop
    121c:	90                   	nop
    121d:	90                   	nop
    121e:	90                   	nop
    121f:	90                   	nop

00001220 <atoi>:
  return r;
}

int
atoi(const char *s)
{
    1220:	55                   	push   %ebp
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    1221:	31 c0                	xor    %eax,%eax
  return r;
}

int
atoi(const char *s)
{
    1223:	89 e5                	mov    %esp,%ebp
    1225:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1228:	53                   	push   %ebx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    1229:	0f b6 11             	movzbl (%ecx),%edx
    122c:	8d 5a d0             	lea    -0x30(%edx),%ebx
    122f:	80 fb 09             	cmp    $0x9,%bl
    1232:	77 1c                	ja     1250 <atoi+0x30>
    1234:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    n = n*10 + *s++ - '0';
    1238:	0f be d2             	movsbl %dl,%edx
    123b:	83 c1 01             	add    $0x1,%ecx
    123e:	8d 04 80             	lea    (%eax,%eax,4),%eax
    1241:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    1245:	0f b6 11             	movzbl (%ecx),%edx
    1248:	8d 5a d0             	lea    -0x30(%edx),%ebx
    124b:	80 fb 09             	cmp    $0x9,%bl
    124e:	76 e8                	jbe    1238 <atoi+0x18>
    n = n*10 + *s++ - '0';
  return n;
}
    1250:	5b                   	pop    %ebx
    1251:	5d                   	pop    %ebp
    1252:	c3                   	ret    
    1253:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    1259:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001260 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
    1260:	55                   	push   %ebp
    1261:	89 e5                	mov    %esp,%ebp
    1263:	56                   	push   %esi
    1264:	8b 45 08             	mov    0x8(%ebp),%eax
    1267:	53                   	push   %ebx
    1268:	8b 5d 10             	mov    0x10(%ebp),%ebx
    126b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    126e:	85 db                	test   %ebx,%ebx
    1270:	7e 14                	jle    1286 <memmove+0x26>
    n = n*10 + *s++ - '0';
  return n;
}

void*
memmove(void *vdst, void *vsrc, int n)
    1272:	31 d2                	xor    %edx,%edx
    1274:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    *dst++ = *src++;
    1278:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
    127c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
    127f:	83 c2 01             	add    $0x1,%edx
{
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    1282:	39 da                	cmp    %ebx,%edx
    1284:	75 f2                	jne    1278 <memmove+0x18>
    *dst++ = *src++;
  return vdst;
}
    1286:	5b                   	pop    %ebx
    1287:	5e                   	pop    %esi
    1288:	5d                   	pop    %ebp
    1289:	c3                   	ret    
    128a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00001290 <stat>:
  return buf;
}

int
stat(char *n, struct stat *st)
{
    1290:	55                   	push   %ebp
    1291:	89 e5                	mov    %esp,%ebp
    1293:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    1296:	8b 45 08             	mov    0x8(%ebp),%eax
  return buf;
}

int
stat(char *n, struct stat *st)
{
    1299:	89 5d f8             	mov    %ebx,-0x8(%ebp)
    129c:	89 75 fc             	mov    %esi,-0x4(%ebp)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    129f:	be ff ff ff ff       	mov    $0xffffffff,%esi
stat(char *n, struct stat *st)
{
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    12a4:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    12ab:	00 
    12ac:	89 04 24             	mov    %eax,(%esp)
    12af:	e8 d4 00 00 00       	call   1388 <open>
  if(fd < 0)
    12b4:	85 c0                	test   %eax,%eax
stat(char *n, struct stat *st)
{
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    12b6:	89 c3                	mov    %eax,%ebx
  if(fd < 0)
    12b8:	78 19                	js     12d3 <stat+0x43>
    return -1;
  r = fstat(fd, st);
    12ba:	8b 45 0c             	mov    0xc(%ebp),%eax
    12bd:	89 1c 24             	mov    %ebx,(%esp)
    12c0:	89 44 24 04          	mov    %eax,0x4(%esp)
    12c4:	e8 d7 00 00 00       	call   13a0 <fstat>
  close(fd);
    12c9:	89 1c 24             	mov    %ebx,(%esp)
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
  r = fstat(fd, st);
    12cc:	89 c6                	mov    %eax,%esi
  close(fd);
    12ce:	e8 9d 00 00 00       	call   1370 <close>
  return r;
}
    12d3:	89 f0                	mov    %esi,%eax
    12d5:	8b 5d f8             	mov    -0x8(%ebp),%ebx
    12d8:	8b 75 fc             	mov    -0x4(%ebp),%esi
    12db:	89 ec                	mov    %ebp,%esp
    12dd:	5d                   	pop    %ebp
    12de:	c3                   	ret    
    12df:	90                   	nop

000012e0 <gets>:
  return 0;
}

char*
gets(char *buf, int max)
{
    12e0:	55                   	push   %ebp
    12e1:	89 e5                	mov    %esp,%ebp
    12e3:	57                   	push   %edi
    12e4:	56                   	push   %esi
    12e5:	31 f6                	xor    %esi,%esi
    12e7:	53                   	push   %ebx
    12e8:	83 ec 2c             	sub    $0x2c,%esp
    12eb:	8b 7d 08             	mov    0x8(%ebp),%edi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    12ee:	eb 06                	jmp    12f6 <gets+0x16>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
    12f0:	3c 0a                	cmp    $0xa,%al
    12f2:	74 39                	je     132d <gets+0x4d>
    12f4:	89 de                	mov    %ebx,%esi
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    12f6:	8d 5e 01             	lea    0x1(%esi),%ebx
    12f9:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
    12fc:	7d 31                	jge    132f <gets+0x4f>
    cc = read(0, &c, 1);
    12fe:	8d 45 e7             	lea    -0x19(%ebp),%eax
    1301:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    1308:	00 
    1309:	89 44 24 04          	mov    %eax,0x4(%esp)
    130d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1314:	e8 47 00 00 00       	call   1360 <read>
    if(cc < 1)
    1319:	85 c0                	test   %eax,%eax
    131b:	7e 12                	jle    132f <gets+0x4f>
      break;
    buf[i++] = c;
    131d:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
    1321:	88 44 1f ff          	mov    %al,-0x1(%edi,%ebx,1)
    if(c == '\n' || c == '\r')
    1325:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
    1329:	3c 0d                	cmp    $0xd,%al
    132b:	75 c3                	jne    12f0 <gets+0x10>
    132d:	89 de                	mov    %ebx,%esi
      break;
  }
  buf[i] = '\0';
    132f:	c6 04 37 00          	movb   $0x0,(%edi,%esi,1)
  return buf;
}
    1333:	89 f8                	mov    %edi,%eax
    1335:	83 c4 2c             	add    $0x2c,%esp
    1338:	5b                   	pop    %ebx
    1339:	5e                   	pop    %esi
    133a:	5f                   	pop    %edi
    133b:	5d                   	pop    %ebp
    133c:	c3                   	ret    
    133d:	90                   	nop
    133e:	90                   	nop
    133f:	90                   	nop

00001340 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    1340:	b8 01 00 00 00       	mov    $0x1,%eax
    1345:	cd 40                	int    $0x40
    1347:	c3                   	ret    

00001348 <exit>:
SYSCALL(exit)
    1348:	b8 02 00 00 00       	mov    $0x2,%eax
    134d:	cd 40                	int    $0x40
    134f:	c3                   	ret    

00001350 <wait>:
SYSCALL(wait)
    1350:	b8 03 00 00 00       	mov    $0x3,%eax
    1355:	cd 40                	int    $0x40
    1357:	c3                   	ret    

00001358 <pipe>:
SYSCALL(pipe)
    1358:	b8 04 00 00 00       	mov    $0x4,%eax
    135d:	cd 40                	int    $0x40
    135f:	c3                   	ret    

00001360 <read>:
SYSCALL(read)
    1360:	b8 05 00 00 00       	mov    $0x5,%eax
    1365:	cd 40                	int    $0x40
    1367:	c3                   	ret    

00001368 <write>:
SYSCALL(write)
    1368:	b8 10 00 00 00       	mov    $0x10,%eax
    136d:	cd 40                	int    $0x40
    136f:	c3                   	ret    

00001370 <close>:
SYSCALL(close)
    1370:	b8 15 00 00 00       	mov    $0x15,%eax
    1375:	cd 40                	int    $0x40
    1377:	c3                   	ret    

00001378 <kill>:
SYSCALL(kill)
    1378:	b8 06 00 00 00       	mov    $0x6,%eax
    137d:	cd 40                	int    $0x40
    137f:	c3                   	ret    

00001380 <exec>:
SYSCALL(exec)
    1380:	b8 07 00 00 00       	mov    $0x7,%eax
    1385:	cd 40                	int    $0x40
    1387:	c3                   	ret    

00001388 <open>:
SYSCALL(open)
    1388:	b8 0f 00 00 00       	mov    $0xf,%eax
    138d:	cd 40                	int    $0x40
    138f:	c3                   	ret    

00001390 <mknod>:
SYSCALL(mknod)
    1390:	b8 11 00 00 00       	mov    $0x11,%eax
    1395:	cd 40                	int    $0x40
    1397:	c3                   	ret    

00001398 <unlink>:
SYSCALL(unlink)
    1398:	b8 12 00 00 00       	mov    $0x12,%eax
    139d:	cd 40                	int    $0x40
    139f:	c3                   	ret    

000013a0 <fstat>:
SYSCALL(fstat)
    13a0:	b8 08 00 00 00       	mov    $0x8,%eax
    13a5:	cd 40                	int    $0x40
    13a7:	c3                   	ret    

000013a8 <link>:
SYSCALL(link)
    13a8:	b8 13 00 00 00       	mov    $0x13,%eax
    13ad:	cd 40                	int    $0x40
    13af:	c3                   	ret    

000013b0 <mkdir>:
SYSCALL(mkdir)
    13b0:	b8 14 00 00 00       	mov    $0x14,%eax
    13b5:	cd 40                	int    $0x40
    13b7:	c3                   	ret    

000013b8 <chdir>:
SYSCALL(chdir)
    13b8:	b8 09 00 00 00       	mov    $0x9,%eax
    13bd:	cd 40                	int    $0x40
    13bf:	c3                   	ret    

000013c0 <dup>:
SYSCALL(dup)
    13c0:	b8 0a 00 00 00       	mov    $0xa,%eax
    13c5:	cd 40                	int    $0x40
    13c7:	c3                   	ret    

000013c8 <getpid>:
SYSCALL(getpid)
    13c8:	b8 0b 00 00 00       	mov    $0xb,%eax
    13cd:	cd 40                	int    $0x40
    13cf:	c3                   	ret    

000013d0 <sbrk>:
SYSCALL(sbrk)
    13d0:	b8 0c 00 00 00       	mov    $0xc,%eax
    13d5:	cd 40                	int    $0x40
    13d7:	c3                   	ret    

000013d8 <sleep>:
SYSCALL(sleep)
    13d8:	b8 0d 00 00 00       	mov    $0xd,%eax
    13dd:	cd 40                	int    $0x40
    13df:	c3                   	ret    

000013e0 <uptime>:
SYSCALL(uptime)
    13e0:	b8 0e 00 00 00       	mov    $0xe,%eax
    13e5:	cd 40                	int    $0x40
    13e7:	c3                   	ret    

000013e8 <hello>:
SYSCALL(hello) 			// added for Lab0
    13e8:	b8 16 00 00 00       	mov    $0x16,%eax
    13ed:	cd 40                	int    $0x40
    13ef:	c3                   	ret    

000013f0 <waitpid>:
SYSCALL(waitpid) 		// lab1 part 1: c
    13f0:	b8 17 00 00 00       	mov    $0x17,%eax
    13f5:	cd 40                	int    $0x40
    13f7:	c3                   	ret    

000013f8 <setpriority>:
SYSCALL(setpriority) 	// lab1 part 2: define syscall
    13f8:	b8 18 00 00 00       	mov    $0x18,%eax
    13fd:	cd 40                	int    $0x40
    13ff:	c3                   	ret    

00001400 <v2p>:
SYSCALL(v2p)			// lab2
    1400:	b8 19 00 00 00       	mov    $0x19,%eax
    1405:	cd 40                	int    $0x40
    1407:	c3                   	ret    
    1408:	90                   	nop
    1409:	90                   	nop
    140a:	90                   	nop
    140b:	90                   	nop
    140c:	90                   	nop
    140d:	90                   	nop
    140e:	90                   	nop
    140f:	90                   	nop

00001410 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
    1410:	55                   	push   %ebp
    1411:	89 e5                	mov    %esp,%ebp
    1413:	57                   	push   %edi
    1414:	89 cf                	mov    %ecx,%edi
    1416:	56                   	push   %esi
    1417:	89 c6                	mov    %eax,%esi
    1419:	53                   	push   %ebx
    141a:	83 ec 4c             	sub    $0x4c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    141d:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1420:	85 c9                	test   %ecx,%ecx
    1422:	74 04                	je     1428 <printint+0x18>
    1424:	85 d2                	test   %edx,%edx
    1426:	78 68                	js     1490 <printint+0x80>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
    1428:	89 d0                	mov    %edx,%eax
    142a:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
    1431:	31 c9                	xor    %ecx,%ecx
    1433:	8d 5d d7             	lea    -0x29(%ebp),%ebx
    1436:	66 90                	xchg   %ax,%ax
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
    1438:	31 d2                	xor    %edx,%edx
    143a:	f7 f7                	div    %edi
    143c:	0f b6 92 5d 18 00 00 	movzbl 0x185d(%edx),%edx
    1443:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
    1446:	83 c1 01             	add    $0x1,%ecx
  }while((x /= base) != 0);
    1449:	85 c0                	test   %eax,%eax
    144b:	75 eb                	jne    1438 <printint+0x28>
  if(neg)
    144d:	8b 45 c4             	mov    -0x3c(%ebp),%eax
    1450:	85 c0                	test   %eax,%eax
    1452:	74 08                	je     145c <printint+0x4c>
    buf[i++] = '-';
    1454:	c6 44 0d d7 2d       	movb   $0x2d,-0x29(%ebp,%ecx,1)
    1459:	83 c1 01             	add    $0x1,%ecx

  while(--i >= 0)
    145c:	8d 79 ff             	lea    -0x1(%ecx),%edi
    145f:	90                   	nop
    1460:	0f b6 04 3b          	movzbl (%ebx,%edi,1),%eax
    1464:	83 ef 01             	sub    $0x1,%edi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    1467:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    146e:	00 
    146f:	89 34 24             	mov    %esi,(%esp)
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
    1472:	88 45 e7             	mov    %al,-0x19(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    1475:	8d 45 e7             	lea    -0x19(%ebp),%eax
    1478:	89 44 24 04          	mov    %eax,0x4(%esp)
    147c:	e8 e7 fe ff ff       	call   1368 <write>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
    1481:	83 ff ff             	cmp    $0xffffffff,%edi
    1484:	75 da                	jne    1460 <printint+0x50>
    putc(fd, buf[i]);
}
    1486:	83 c4 4c             	add    $0x4c,%esp
    1489:	5b                   	pop    %ebx
    148a:	5e                   	pop    %esi
    148b:	5f                   	pop    %edi
    148c:	5d                   	pop    %ebp
    148d:	c3                   	ret    
    148e:	66 90                	xchg   %ax,%ax
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
    1490:	89 d0                	mov    %edx,%eax
    1492:	f7 d8                	neg    %eax
    1494:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
    149b:	eb 94                	jmp    1431 <printint+0x21>
    149d:	8d 76 00             	lea    0x0(%esi),%esi

000014a0 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
    14a0:	55                   	push   %ebp
    14a1:	89 e5                	mov    %esp,%ebp
    14a3:	57                   	push   %edi
    14a4:	56                   	push   %esi
    14a5:	53                   	push   %ebx
    14a6:	83 ec 3c             	sub    $0x3c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    14a9:	8b 45 0c             	mov    0xc(%ebp),%eax
    14ac:	0f b6 10             	movzbl (%eax),%edx
    14af:	84 d2                	test   %dl,%dl
    14b1:	0f 84 c1 00 00 00    	je     1578 <printf+0xd8>
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
    14b7:	8d 4d 10             	lea    0x10(%ebp),%ecx
    14ba:	31 ff                	xor    %edi,%edi
    14bc:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
    14bf:	31 db                	xor    %ebx,%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    14c1:	8d 75 e7             	lea    -0x19(%ebp),%esi
    14c4:	eb 1e                	jmp    14e4 <printf+0x44>
    14c6:	66 90                	xchg   %ax,%ax
  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
    14c8:	83 fa 25             	cmp    $0x25,%edx
    14cb:	0f 85 af 00 00 00    	jne    1580 <printf+0xe0>
    14d1:	66 bf 25 00          	mov    $0x25,%di
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    14d5:	83 c3 01             	add    $0x1,%ebx
    14d8:	0f b6 14 18          	movzbl (%eax,%ebx,1),%edx
    14dc:	84 d2                	test   %dl,%dl
    14de:	0f 84 94 00 00 00    	je     1578 <printf+0xd8>
    c = fmt[i] & 0xff;
    if(state == 0){
    14e4:	85 ff                	test   %edi,%edi
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    14e6:	0f b6 d2             	movzbl %dl,%edx
    if(state == 0){
    14e9:	74 dd                	je     14c8 <printf+0x28>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
    14eb:	83 ff 25             	cmp    $0x25,%edi
    14ee:	75 e5                	jne    14d5 <printf+0x35>
      if(c == 'd'){
    14f0:	83 fa 64             	cmp    $0x64,%edx
    14f3:	0f 84 3f 01 00 00    	je     1638 <printf+0x198>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
    14f9:	83 fa 70             	cmp    $0x70,%edx
    14fc:	0f 84 a6 00 00 00    	je     15a8 <printf+0x108>
    1502:	83 fa 78             	cmp    $0x78,%edx
    1505:	0f 84 9d 00 00 00    	je     15a8 <printf+0x108>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
    150b:	83 fa 73             	cmp    $0x73,%edx
    150e:	66 90                	xchg   %ax,%ax
    1510:	0f 84 ba 00 00 00    	je     15d0 <printf+0x130>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    1516:	83 fa 63             	cmp    $0x63,%edx
    1519:	0f 84 41 01 00 00    	je     1660 <printf+0x1c0>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
    151f:	83 fa 25             	cmp    $0x25,%edx
    1522:	0f 84 00 01 00 00    	je     1628 <printf+0x188>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    1528:	8b 4d 08             	mov    0x8(%ebp),%ecx
    152b:	89 55 cc             	mov    %edx,-0x34(%ebp)
    152e:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
    1532:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    1539:	00 
    153a:	89 74 24 04          	mov    %esi,0x4(%esp)
    153e:	89 0c 24             	mov    %ecx,(%esp)
    1541:	e8 22 fe ff ff       	call   1368 <write>
    1546:	8b 55 cc             	mov    -0x34(%ebp),%edx
    1549:	88 55 e7             	mov    %dl,-0x19(%ebp)
    154c:	8b 45 08             	mov    0x8(%ebp),%eax
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    154f:	83 c3 01             	add    $0x1,%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    1552:	31 ff                	xor    %edi,%edi
    1554:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    155b:	00 
    155c:	89 74 24 04          	mov    %esi,0x4(%esp)
    1560:	89 04 24             	mov    %eax,(%esp)
    1563:	e8 00 fe ff ff       	call   1368 <write>
    1568:	8b 45 0c             	mov    0xc(%ebp),%eax
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    156b:	0f b6 14 18          	movzbl (%eax,%ebx,1),%edx
    156f:	84 d2                	test   %dl,%dl
    1571:	0f 85 6d ff ff ff    	jne    14e4 <printf+0x44>
    1577:	90                   	nop
        putc(fd, c);
      }
      state = 0;
    }
  }
}
    1578:	83 c4 3c             	add    $0x3c,%esp
    157b:	5b                   	pop    %ebx
    157c:	5e                   	pop    %esi
    157d:	5f                   	pop    %edi
    157e:	5d                   	pop    %ebp
    157f:	c3                   	ret    
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    1580:	8b 45 08             	mov    0x8(%ebp),%eax
  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
    1583:	88 55 e7             	mov    %dl,-0x19(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    1586:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    158d:	00 
    158e:	89 74 24 04          	mov    %esi,0x4(%esp)
    1592:	89 04 24             	mov    %eax,(%esp)
    1595:	e8 ce fd ff ff       	call   1368 <write>
    159a:	8b 45 0c             	mov    0xc(%ebp),%eax
    159d:	e9 33 ff ff ff       	jmp    14d5 <printf+0x35>
    15a2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
    15a8:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    15ab:	b9 10 00 00 00       	mov    $0x10,%ecx
        ap++;
    15b0:	31 ff                	xor    %edi,%edi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
    15b2:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    15b9:	8b 10                	mov    (%eax),%edx
    15bb:	8b 45 08             	mov    0x8(%ebp),%eax
    15be:	e8 4d fe ff ff       	call   1410 <printint>
    15c3:	8b 45 0c             	mov    0xc(%ebp),%eax
        ap++;
    15c6:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
    15ca:	e9 06 ff ff ff       	jmp    14d5 <printf+0x35>
    15cf:	90                   	nop
      } else if(c == 's'){
        s = (char*)*ap;
    15d0:	8b 55 d4             	mov    -0x2c(%ebp),%edx
        ap++;
        if(s == 0)
    15d3:	b9 56 18 00 00       	mov    $0x1856,%ecx
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
        s = (char*)*ap;
    15d8:	8b 3a                	mov    (%edx),%edi
        ap++;
    15da:	83 c2 04             	add    $0x4,%edx
    15dd:	89 55 d4             	mov    %edx,-0x2c(%ebp)
        if(s == 0)
    15e0:	85 ff                	test   %edi,%edi
    15e2:	0f 44 f9             	cmove  %ecx,%edi
          s = "(null)";
        while(*s != 0){
    15e5:	0f b6 17             	movzbl (%edi),%edx
    15e8:	84 d2                	test   %dl,%dl
    15ea:	74 33                	je     161f <printf+0x17f>
    15ec:	89 5d d0             	mov    %ebx,-0x30(%ebp)
    15ef:	8b 5d 08             	mov    0x8(%ebp),%ebx
    15f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
          putc(fd, *s);
          s++;
    15f8:	83 c7 01             	add    $0x1,%edi
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
    15fb:	88 55 e7             	mov    %dl,-0x19(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    15fe:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    1605:	00 
    1606:	89 74 24 04          	mov    %esi,0x4(%esp)
    160a:	89 1c 24             	mov    %ebx,(%esp)
    160d:	e8 56 fd ff ff       	call   1368 <write>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
    1612:	0f b6 17             	movzbl (%edi),%edx
    1615:	84 d2                	test   %dl,%dl
    1617:	75 df                	jne    15f8 <printf+0x158>
    1619:	8b 5d d0             	mov    -0x30(%ebp),%ebx
    161c:	8b 45 0c             	mov    0xc(%ebp),%eax
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    161f:	31 ff                	xor    %edi,%edi
    1621:	e9 af fe ff ff       	jmp    14d5 <printf+0x35>
    1626:	66 90                	xchg   %ax,%ax
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
    1628:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
    162c:	e9 1b ff ff ff       	jmp    154c <printf+0xac>
    1631:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
    1638:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    163b:	b9 0a 00 00 00       	mov    $0xa,%ecx
        ap++;
    1640:	66 31 ff             	xor    %di,%di
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
    1643:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    164a:	8b 10                	mov    (%eax),%edx
    164c:	8b 45 08             	mov    0x8(%ebp),%eax
    164f:	e8 bc fd ff ff       	call   1410 <printint>
    1654:	8b 45 0c             	mov    0xc(%ebp),%eax
        ap++;
    1657:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
    165b:	e9 75 fe ff ff       	jmp    14d5 <printf+0x35>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    1660:	8b 55 d4             	mov    -0x2c(%ebp),%edx
        putc(fd, *ap);
        ap++;
    1663:	31 ff                	xor    %edi,%edi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    1665:	8b 4d 08             	mov    0x8(%ebp),%ecx
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    1668:	8b 02                	mov    (%edx),%eax
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    166a:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    1671:	00 
    1672:	89 74 24 04          	mov    %esi,0x4(%esp)
    1676:	89 0c 24             	mov    %ecx,(%esp)
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    1679:	88 45 e7             	mov    %al,-0x19(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    167c:	e8 e7 fc ff ff       	call   1368 <write>
    1681:	8b 45 0c             	mov    0xc(%ebp),%eax
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
        ap++;
    1684:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
    1688:	e9 48 fe ff ff       	jmp    14d5 <printf+0x35>
    168d:	90                   	nop
    168e:	90                   	nop
    168f:	90                   	nop

00001690 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    1690:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1691:	a1 80 18 00 00       	mov    0x1880,%eax
static Header base;
static Header *freep;

void
free(void *ap)
{
    1696:	89 e5                	mov    %esp,%ebp
    1698:	57                   	push   %edi
    1699:	56                   	push   %esi
    169a:	53                   	push   %ebx
    169b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
    169e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    16a1:	39 c8                	cmp    %ecx,%eax
    16a3:	73 1d                	jae    16c2 <free+0x32>
    16a5:	8d 76 00             	lea    0x0(%esi),%esi
    16a8:	8b 10                	mov    (%eax),%edx
    16aa:	39 d1                	cmp    %edx,%ecx
    16ac:	72 1a                	jb     16c8 <free+0x38>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    16ae:	39 d0                	cmp    %edx,%eax
    16b0:	72 08                	jb     16ba <free+0x2a>
    16b2:	39 c8                	cmp    %ecx,%eax
    16b4:	72 12                	jb     16c8 <free+0x38>
    16b6:	39 d1                	cmp    %edx,%ecx
    16b8:	72 0e                	jb     16c8 <free+0x38>
    16ba:	89 d0                	mov    %edx,%eax
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    16bc:	39 c8                	cmp    %ecx,%eax
    16be:	66 90                	xchg   %ax,%ax
    16c0:	72 e6                	jb     16a8 <free+0x18>
    16c2:	8b 10                	mov    (%eax),%edx
    16c4:	eb e8                	jmp    16ae <free+0x1e>
    16c6:	66 90                	xchg   %ax,%ax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    16c8:	8b 71 04             	mov    0x4(%ecx),%esi
    16cb:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    16ce:	39 d7                	cmp    %edx,%edi
    16d0:	74 19                	je     16eb <free+0x5b>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
    16d2:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    16d5:	8b 50 04             	mov    0x4(%eax),%edx
    16d8:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    16db:	39 ce                	cmp    %ecx,%esi
    16dd:	74 23                	je     1702 <free+0x72>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
    16df:	89 08                	mov    %ecx,(%eax)
  freep = p;
    16e1:	a3 80 18 00 00       	mov    %eax,0x1880
}
    16e6:	5b                   	pop    %ebx
    16e7:	5e                   	pop    %esi
    16e8:	5f                   	pop    %edi
    16e9:	5d                   	pop    %ebp
    16ea:	c3                   	ret    
  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
    16eb:	03 72 04             	add    0x4(%edx),%esi
    16ee:	89 71 04             	mov    %esi,0x4(%ecx)
    bp->s.ptr = p->s.ptr->s.ptr;
    16f1:	8b 10                	mov    (%eax),%edx
    16f3:	8b 12                	mov    (%edx),%edx
    16f5:	89 53 f8             	mov    %edx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    16f8:	8b 50 04             	mov    0x4(%eax),%edx
    16fb:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    16fe:	39 ce                	cmp    %ecx,%esi
    1700:	75 dd                	jne    16df <free+0x4f>
    p->s.size += bp->s.size;
    1702:	03 51 04             	add    0x4(%ecx),%edx
    1705:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    1708:	8b 53 f8             	mov    -0x8(%ebx),%edx
    170b:	89 10                	mov    %edx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
    170d:	a3 80 18 00 00       	mov    %eax,0x1880
}
    1712:	5b                   	pop    %ebx
    1713:	5e                   	pop    %esi
    1714:	5f                   	pop    %edi
    1715:	5d                   	pop    %ebp
    1716:	c3                   	ret    
    1717:	89 f6                	mov    %esi,%esi
    1719:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001720 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    1720:	55                   	push   %ebp
    1721:	89 e5                	mov    %esp,%ebp
    1723:	57                   	push   %edi
    1724:	56                   	push   %esi
    1725:	53                   	push   %ebx
    1726:	83 ec 2c             	sub    $0x2c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1729:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if((prevp = freep) == 0){
    172c:	8b 0d 80 18 00 00    	mov    0x1880,%ecx
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1732:	83 c3 07             	add    $0x7,%ebx
    1735:	c1 eb 03             	shr    $0x3,%ebx
    1738:	83 c3 01             	add    $0x1,%ebx
  if((prevp = freep) == 0){
    173b:	85 c9                	test   %ecx,%ecx
    173d:	0f 84 9b 00 00 00    	je     17de <malloc+0xbe>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1743:	8b 01                	mov    (%ecx),%eax
    if(p->s.size >= nunits){
    1745:	8b 50 04             	mov    0x4(%eax),%edx
    1748:	39 d3                	cmp    %edx,%ebx
    174a:	76 27                	jbe    1773 <malloc+0x53>
        p->s.size -= nunits;
        p += p->s.size;
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    174c:	8d 3c dd 00 00 00 00 	lea    0x0(,%ebx,8),%edi
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < 4096)
    1753:	be 00 80 00 00       	mov    $0x8000,%esi
    1758:	89 7d e4             	mov    %edi,-0x1c(%ebp)
    175b:	90                   	nop
    175c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    1760:	3b 05 80 18 00 00    	cmp    0x1880,%eax
    1766:	74 30                	je     1798 <malloc+0x78>
    1768:	89 c1                	mov    %eax,%ecx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    176a:	8b 01                	mov    (%ecx),%eax
    if(p->s.size >= nunits){
    176c:	8b 50 04             	mov    0x4(%eax),%edx
    176f:	39 d3                	cmp    %edx,%ebx
    1771:	77 ed                	ja     1760 <malloc+0x40>
      if(p->s.size == nunits)
    1773:	39 d3                	cmp    %edx,%ebx
    1775:	74 61                	je     17d8 <malloc+0xb8>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
    1777:	29 da                	sub    %ebx,%edx
    1779:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
    177c:	8d 04 d0             	lea    (%eax,%edx,8),%eax
        p->s.size = nunits;
    177f:	89 58 04             	mov    %ebx,0x4(%eax)
      }
      freep = prevp;
    1782:	89 0d 80 18 00 00    	mov    %ecx,0x1880
      return (void*)(p + 1);
    1788:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
    178b:	83 c4 2c             	add    $0x2c,%esp
    178e:	5b                   	pop    %ebx
    178f:	5e                   	pop    %esi
    1790:	5f                   	pop    %edi
    1791:	5d                   	pop    %ebp
    1792:	c3                   	ret    
    1793:	90                   	nop
    1794:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < 4096)
    1798:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    179b:	81 fb 00 10 00 00    	cmp    $0x1000,%ebx
    17a1:	bf 00 10 00 00       	mov    $0x1000,%edi
    17a6:	0f 43 fb             	cmovae %ebx,%edi
    17a9:	0f 42 c6             	cmovb  %esi,%eax
    nu = 4096;
  p = sbrk(nu * sizeof(Header));
    17ac:	89 04 24             	mov    %eax,(%esp)
    17af:	e8 1c fc ff ff       	call   13d0 <sbrk>
  if(p == (char*)-1)
    17b4:	83 f8 ff             	cmp    $0xffffffff,%eax
    17b7:	74 18                	je     17d1 <malloc+0xb1>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
    17b9:	89 78 04             	mov    %edi,0x4(%eax)
  free((void*)(hp + 1));
    17bc:	83 c0 08             	add    $0x8,%eax
    17bf:	89 04 24             	mov    %eax,(%esp)
    17c2:	e8 c9 fe ff ff       	call   1690 <free>
  return freep;
    17c7:	8b 0d 80 18 00 00    	mov    0x1880,%ecx
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
    17cd:	85 c9                	test   %ecx,%ecx
    17cf:	75 99                	jne    176a <malloc+0x4a>
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
    17d1:	31 c0                	xor    %eax,%eax
    17d3:	eb b6                	jmp    178b <malloc+0x6b>
    17d5:	8d 76 00             	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
    17d8:	8b 10                	mov    (%eax),%edx
    17da:	89 11                	mov    %edx,(%ecx)
    17dc:	eb a4                	jmp    1782 <malloc+0x62>
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    17de:	c7 05 80 18 00 00 78 	movl   $0x1878,0x1880
    17e5:	18 00 00 
    base.s.size = 0;
    17e8:	b9 78 18 00 00       	mov    $0x1878,%ecx
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    17ed:	c7 05 78 18 00 00 78 	movl   $0x1878,0x1878
    17f4:	18 00 00 
    base.s.size = 0;
    17f7:	c7 05 7c 18 00 00 00 	movl   $0x0,0x187c
    17fe:	00 00 00 
    1801:	e9 3d ff ff ff       	jmp    1743 <malloc+0x23>
