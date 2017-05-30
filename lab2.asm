
_lab2:     file format elf32-i386


Disassembly of section .text:

00001000 <main>:
#include "types.h"
#include "user.h"

int main(int argc, char *argv[]){
    1000:	55                   	push   %ebp
    1001:	89 e5                	mov    %esp,%ebp
    1003:	83 e4 f0             	and    $0xfffffff0,%esp
    1006:	53                   	push   %ebx
    1007:	83 ec 2c             	sub    $0x2c,%esp

  int i = 500;
  int virtual =(int)&i;
    100a:	8d 5c 24 1c          	lea    0x1c(%esp),%ebx
#include "types.h"
#include "user.h"

int main(int argc, char *argv[]){

  int i = 500;
    100e:	c7 44 24 1c f4 01 00 	movl   $0x1f4,0x1c(%esp)
    1015:	00 
  int virtual =(int)&i;
    1016:	89 5c 24 18          	mov    %ebx,0x18(%esp)
  int physical=0;
    101a:	c7 44 24 14 00 00 00 	movl   $0x0,0x14(%esp)
    1021:	00 
  
  printf(1,"\n Testing Part 1: Memory translation system cal: \n system call v2p(int virtual, int *physical) \n\n");
    1022:	c7 44 24 04 78 18 00 	movl   $0x1878,0x4(%esp)
    1029:	00 
    102a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1031:	e8 da 04 00 00       	call   1510 <printf>
  
  if(v2p(&virtual, &physical))
    1036:	8d 44 24 14          	lea    0x14(%esp),%eax
    103a:	89 44 24 04          	mov    %eax,0x4(%esp)
    103e:	8d 44 24 18          	lea    0x18(%esp),%eax
    1042:	89 04 24             	mov    %eax,(%esp)
    1045:	e8 26 04 00 00       	call   1470 <v2p>
    104a:	85 c0                	test   %eax,%eax
    104c:	0f 84 16 01 00 00    	je     1168 <main+0x168>
	printf(1,"\n Virtual address 0x%x is mapped to physical address 0x%x \n",virtual, physical);
    1052:	8b 44 24 14          	mov    0x14(%esp),%eax
    1056:	c7 44 24 04 dc 18 00 	movl   $0x18dc,0x4(%esp)
    105d:	00 
    105e:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1065:	89 44 24 0c          	mov    %eax,0xc(%esp)
    1069:	8b 44 24 18          	mov    0x18(%esp),%eax
    106d:	89 44 24 08          	mov    %eax,0x8(%esp)
    1071:	e8 9a 04 00 00       	call   1510 <printf>
  else
	printf(2,"\n v2p system call faild! \n");
	
   printf(1,"\n An example of correct output:\n Virtual address 0x2FCC is mapped to physical address 0xDEDFFCC  \n");
    1076:	c7 44 24 04 18 19 00 	movl   $0x1918,0x4(%esp)
    107d:	00 
    107e:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1085:	e8 86 04 00 00       	call   1510 <printf>
   printf(1,"\n But it is not a guarantee that the system call is correct. The code will be checked! \n");
    108a:	c7 44 24 04 7c 19 00 	movl   $0x197c,0x4(%esp)
    1091:	00 
    1092:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1099:	e8 72 04 00 00       	call   1510 <printf>
  
  //____________________________________________________________________
  
   printf(1,"\n Testing Part 2: Null pointer dereference \n");
    109e:	c7 44 24 04 d8 19 00 	movl   $0x19d8,0x4(%esp)
    10a5:	00 
    10a6:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    10ad:	e8 5e 04 00 00       	call   1510 <printf>

   int *p;
   p = &i;
    10b2:	89 5c 24 10          	mov    %ebx,0x10(%esp)

   printf(1,"\n Now we will dereference a proper pointer, we should not get an error\n");
    10b6:	c7 44 24 04 08 1a 00 	movl   $0x1a08,0x4(%esp)
    10bd:	00 
    10be:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    10c5:	e8 46 04 00 00       	call   1510 <printf>

   printf(1,"\n the contents of the proper pointer are %d and it points to address:0x%x\n\n",*p,&p);
    10ca:	8d 44 24 10          	lea    0x10(%esp),%eax
    10ce:	89 44 24 0c          	mov    %eax,0xc(%esp)
    10d2:	8b 44 24 10          	mov    0x10(%esp),%eax
    10d6:	8b 00                	mov    (%eax),%eax
    10d8:	c7 44 24 04 50 1a 00 	movl   $0x1a50,0x4(%esp)
    10df:	00 
    10e0:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    10e7:	89 44 24 08          	mov    %eax,0x8(%esp)
    10eb:	e8 20 04 00 00       	call   1510 <printf>
   printf(1,"\n We are going to dereference the null pointer now\n");
    10f0:	c7 44 24 04 9c 1a 00 	movl   $0x1a9c,0x4(%esp)
    10f7:	00 
    10f8:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    10ff:	e8 0c 04 00 00       	call   1510 <printf>
   p = 0;
    1104:	c7 44 24 10 00 00 00 	movl   $0x0,0x10(%esp)
    110b:	00 
   printf(1,"\n Before fixing the null pointer problem we would get an output like this:\n the contents of the null pointer are 0x83E58955 and it points to address: 0x0\n");
    110c:	c7 44 24 04 d0 1a 00 	movl   $0x1ad0,0x4(%esp)
    1113:	00 
    1114:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    111b:	e8 f0 03 00 00       	call   1510 <printf>
   printf(1,"\n The correct output should be:\n pid 3 lab2: trap 14 err 4 on cpu 0 eip 0x10ba addr 0x0--kill proc \n\n");
    1120:	c7 44 24 04 6c 1b 00 	movl   $0x1b6c,0x4(%esp)
    1127:	00 
    1128:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    112f:	e8 dc 03 00 00       	call   1510 <printf>
   
   printf(1,"\n The contents of the null pointer are 0x%x and it points to address: 0x%x\n",*p,p);
    1134:	8b 44 24 10          	mov    0x10(%esp),%eax
    1138:	89 44 24 0c          	mov    %eax,0xc(%esp)
    113c:	8b 00                	mov    (%eax),%eax
    113e:	c7 44 24 04 d4 1b 00 	movl   $0x1bd4,0x4(%esp)
    1145:	00 
    1146:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    114d:	89 44 24 08          	mov    %eax,0x8(%esp)
    1151:	e8 ba 03 00 00       	call   1510 <printf>
  exit(0);
    1156:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    115d:	e8 56 02 00 00       	call   13b8 <exit>
    1162:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  printf(1,"\n Testing Part 1: Memory translation system cal: \n system call v2p(int virtual, int *physical) \n\n");
  
  if(v2p(&virtual, &physical))
	printf(1,"\n Virtual address 0x%x is mapped to physical address 0x%x \n",virtual, physical);
  else
	printf(2,"\n v2p system call faild! \n");
    1168:	c7 44 24 04 20 1c 00 	movl   $0x1c20,0x4(%esp)
    116f:	00 
    1170:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
    1177:	e8 94 03 00 00       	call   1510 <printf>
    117c:	e9 f5 fe ff ff       	jmp    1076 <main+0x76>
    1181:	90                   	nop
    1182:	90                   	nop
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

00001190 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
    1190:	55                   	push   %ebp
    1191:	31 d2                	xor    %edx,%edx
    1193:	89 e5                	mov    %esp,%ebp
    1195:	8b 45 08             	mov    0x8(%ebp),%eax
    1198:	53                   	push   %ebx
    1199:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    119c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
    11a0:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
    11a4:	88 0c 10             	mov    %cl,(%eax,%edx,1)
    11a7:	83 c2 01             	add    $0x1,%edx
    11aa:	84 c9                	test   %cl,%cl
    11ac:	75 f2                	jne    11a0 <strcpy+0x10>
    ;
  return os;
}
    11ae:	5b                   	pop    %ebx
    11af:	5d                   	pop    %ebp
    11b0:	c3                   	ret    
    11b1:	eb 0d                	jmp    11c0 <strcmp>
    11b3:	90                   	nop
    11b4:	90                   	nop
    11b5:	90                   	nop
    11b6:	90                   	nop
    11b7:	90                   	nop
    11b8:	90                   	nop
    11b9:	90                   	nop
    11ba:	90                   	nop
    11bb:	90                   	nop
    11bc:	90                   	nop
    11bd:	90                   	nop
    11be:	90                   	nop
    11bf:	90                   	nop

000011c0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    11c0:	55                   	push   %ebp
    11c1:	89 e5                	mov    %esp,%ebp
    11c3:	8b 4d 08             	mov    0x8(%ebp),%ecx
    11c6:	53                   	push   %ebx
    11c7:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(*p && *p == *q)
    11ca:	0f b6 01             	movzbl (%ecx),%eax
    11cd:	84 c0                	test   %al,%al
    11cf:	75 14                	jne    11e5 <strcmp+0x25>
    11d1:	eb 25                	jmp    11f8 <strcmp+0x38>
    11d3:	90                   	nop
    11d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    p++, q++;
    11d8:	83 c1 01             	add    $0x1,%ecx
    11db:	83 c2 01             	add    $0x1,%edx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
    11de:	0f b6 01             	movzbl (%ecx),%eax
    11e1:	84 c0                	test   %al,%al
    11e3:	74 13                	je     11f8 <strcmp+0x38>
    11e5:	0f b6 1a             	movzbl (%edx),%ebx
    11e8:	38 d8                	cmp    %bl,%al
    11ea:	74 ec                	je     11d8 <strcmp+0x18>
    11ec:	0f b6 db             	movzbl %bl,%ebx
    11ef:	0f b6 c0             	movzbl %al,%eax
    11f2:	29 d8                	sub    %ebx,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
    11f4:	5b                   	pop    %ebx
    11f5:	5d                   	pop    %ebp
    11f6:	c3                   	ret    
    11f7:	90                   	nop
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
    11f8:	0f b6 1a             	movzbl (%edx),%ebx
    11fb:	31 c0                	xor    %eax,%eax
    11fd:	0f b6 db             	movzbl %bl,%ebx
    1200:	29 d8                	sub    %ebx,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
    1202:	5b                   	pop    %ebx
    1203:	5d                   	pop    %ebp
    1204:	c3                   	ret    
    1205:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1209:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001210 <strlen>:

uint
strlen(char *s)
{
    1210:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
    1211:	31 d2                	xor    %edx,%edx
  return (uchar)*p - (uchar)*q;
}

uint
strlen(char *s)
{
    1213:	89 e5                	mov    %esp,%ebp
  int n;

  for(n = 0; s[n]; n++)
    1215:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
}

uint
strlen(char *s)
{
    1217:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
    121a:	80 39 00             	cmpb   $0x0,(%ecx)
    121d:	74 0c                	je     122b <strlen+0x1b>
    121f:	90                   	nop
    1220:	83 c2 01             	add    $0x1,%edx
    1223:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
    1227:	89 d0                	mov    %edx,%eax
    1229:	75 f5                	jne    1220 <strlen+0x10>
    ;
  return n;
}
    122b:	5d                   	pop    %ebp
    122c:	c3                   	ret    
    122d:	8d 76 00             	lea    0x0(%esi),%esi

00001230 <memset>:

void*
memset(void *dst, int c, uint n)
{
    1230:	55                   	push   %ebp
    1231:	89 e5                	mov    %esp,%ebp
    1233:	8b 55 08             	mov    0x8(%ebp),%edx
    1236:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
    1237:	8b 4d 10             	mov    0x10(%ebp),%ecx
    123a:	8b 45 0c             	mov    0xc(%ebp),%eax
    123d:	89 d7                	mov    %edx,%edi
    123f:	fc                   	cld    
    1240:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
    1242:	89 d0                	mov    %edx,%eax
    1244:	5f                   	pop    %edi
    1245:	5d                   	pop    %ebp
    1246:	c3                   	ret    
    1247:	89 f6                	mov    %esi,%esi
    1249:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001250 <strchr>:

char*
strchr(const char *s, char c)
{
    1250:	55                   	push   %ebp
    1251:	89 e5                	mov    %esp,%ebp
    1253:	8b 45 08             	mov    0x8(%ebp),%eax
    1256:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
    125a:	0f b6 10             	movzbl (%eax),%edx
    125d:	84 d2                	test   %dl,%dl
    125f:	75 11                	jne    1272 <strchr+0x22>
    1261:	eb 15                	jmp    1278 <strchr+0x28>
    1263:	90                   	nop
    1264:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1268:	83 c0 01             	add    $0x1,%eax
    126b:	0f b6 10             	movzbl (%eax),%edx
    126e:	84 d2                	test   %dl,%dl
    1270:	74 06                	je     1278 <strchr+0x28>
    if(*s == c)
    1272:	38 ca                	cmp    %cl,%dl
    1274:	75 f2                	jne    1268 <strchr+0x18>
      return (char*)s;
  return 0;
}
    1276:	5d                   	pop    %ebp
    1277:	c3                   	ret    
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
    1278:	31 c0                	xor    %eax,%eax
    if(*s == c)
      return (char*)s;
  return 0;
}
    127a:	5d                   	pop    %ebp
    127b:	90                   	nop
    127c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1280:	c3                   	ret    
    1281:	eb 0d                	jmp    1290 <atoi>
    1283:	90                   	nop
    1284:	90                   	nop
    1285:	90                   	nop
    1286:	90                   	nop
    1287:	90                   	nop
    1288:	90                   	nop
    1289:	90                   	nop
    128a:	90                   	nop
    128b:	90                   	nop
    128c:	90                   	nop
    128d:	90                   	nop
    128e:	90                   	nop
    128f:	90                   	nop

00001290 <atoi>:
  return r;
}

int
atoi(const char *s)
{
    1290:	55                   	push   %ebp
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    1291:	31 c0                	xor    %eax,%eax
  return r;
}

int
atoi(const char *s)
{
    1293:	89 e5                	mov    %esp,%ebp
    1295:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1298:	53                   	push   %ebx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    1299:	0f b6 11             	movzbl (%ecx),%edx
    129c:	8d 5a d0             	lea    -0x30(%edx),%ebx
    129f:	80 fb 09             	cmp    $0x9,%bl
    12a2:	77 1c                	ja     12c0 <atoi+0x30>
    12a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    n = n*10 + *s++ - '0';
    12a8:	0f be d2             	movsbl %dl,%edx
    12ab:	83 c1 01             	add    $0x1,%ecx
    12ae:	8d 04 80             	lea    (%eax,%eax,4),%eax
    12b1:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    12b5:	0f b6 11             	movzbl (%ecx),%edx
    12b8:	8d 5a d0             	lea    -0x30(%edx),%ebx
    12bb:	80 fb 09             	cmp    $0x9,%bl
    12be:	76 e8                	jbe    12a8 <atoi+0x18>
    n = n*10 + *s++ - '0';
  return n;
}
    12c0:	5b                   	pop    %ebx
    12c1:	5d                   	pop    %ebp
    12c2:	c3                   	ret    
    12c3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    12c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000012d0 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
    12d0:	55                   	push   %ebp
    12d1:	89 e5                	mov    %esp,%ebp
    12d3:	56                   	push   %esi
    12d4:	8b 45 08             	mov    0x8(%ebp),%eax
    12d7:	53                   	push   %ebx
    12d8:	8b 5d 10             	mov    0x10(%ebp),%ebx
    12db:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    12de:	85 db                	test   %ebx,%ebx
    12e0:	7e 14                	jle    12f6 <memmove+0x26>
    n = n*10 + *s++ - '0';
  return n;
}

void*
memmove(void *vdst, void *vsrc, int n)
    12e2:	31 d2                	xor    %edx,%edx
    12e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    *dst++ = *src++;
    12e8:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
    12ec:	88 0c 10             	mov    %cl,(%eax,%edx,1)
    12ef:	83 c2 01             	add    $0x1,%edx
{
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    12f2:	39 da                	cmp    %ebx,%edx
    12f4:	75 f2                	jne    12e8 <memmove+0x18>
    *dst++ = *src++;
  return vdst;
}
    12f6:	5b                   	pop    %ebx
    12f7:	5e                   	pop    %esi
    12f8:	5d                   	pop    %ebp
    12f9:	c3                   	ret    
    12fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00001300 <stat>:
  return buf;
}

int
stat(char *n, struct stat *st)
{
    1300:	55                   	push   %ebp
    1301:	89 e5                	mov    %esp,%ebp
    1303:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    1306:	8b 45 08             	mov    0x8(%ebp),%eax
  return buf;
}

int
stat(char *n, struct stat *st)
{
    1309:	89 5d f8             	mov    %ebx,-0x8(%ebp)
    130c:	89 75 fc             	mov    %esi,-0x4(%ebp)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    130f:	be ff ff ff ff       	mov    $0xffffffff,%esi
stat(char *n, struct stat *st)
{
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    1314:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    131b:	00 
    131c:	89 04 24             	mov    %eax,(%esp)
    131f:	e8 d4 00 00 00       	call   13f8 <open>
  if(fd < 0)
    1324:	85 c0                	test   %eax,%eax
stat(char *n, struct stat *st)
{
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    1326:	89 c3                	mov    %eax,%ebx
  if(fd < 0)
    1328:	78 19                	js     1343 <stat+0x43>
    return -1;
  r = fstat(fd, st);
    132a:	8b 45 0c             	mov    0xc(%ebp),%eax
    132d:	89 1c 24             	mov    %ebx,(%esp)
    1330:	89 44 24 04          	mov    %eax,0x4(%esp)
    1334:	e8 d7 00 00 00       	call   1410 <fstat>
  close(fd);
    1339:	89 1c 24             	mov    %ebx,(%esp)
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
  r = fstat(fd, st);
    133c:	89 c6                	mov    %eax,%esi
  close(fd);
    133e:	e8 9d 00 00 00       	call   13e0 <close>
  return r;
}
    1343:	89 f0                	mov    %esi,%eax
    1345:	8b 5d f8             	mov    -0x8(%ebp),%ebx
    1348:	8b 75 fc             	mov    -0x4(%ebp),%esi
    134b:	89 ec                	mov    %ebp,%esp
    134d:	5d                   	pop    %ebp
    134e:	c3                   	ret    
    134f:	90                   	nop

00001350 <gets>:
  return 0;
}

char*
gets(char *buf, int max)
{
    1350:	55                   	push   %ebp
    1351:	89 e5                	mov    %esp,%ebp
    1353:	57                   	push   %edi
    1354:	56                   	push   %esi
    1355:	31 f6                	xor    %esi,%esi
    1357:	53                   	push   %ebx
    1358:	83 ec 2c             	sub    $0x2c,%esp
    135b:	8b 7d 08             	mov    0x8(%ebp),%edi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    135e:	eb 06                	jmp    1366 <gets+0x16>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
    1360:	3c 0a                	cmp    $0xa,%al
    1362:	74 39                	je     139d <gets+0x4d>
    1364:	89 de                	mov    %ebx,%esi
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    1366:	8d 5e 01             	lea    0x1(%esi),%ebx
    1369:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
    136c:	7d 31                	jge    139f <gets+0x4f>
    cc = read(0, &c, 1);
    136e:	8d 45 e7             	lea    -0x19(%ebp),%eax
    1371:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    1378:	00 
    1379:	89 44 24 04          	mov    %eax,0x4(%esp)
    137d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1384:	e8 47 00 00 00       	call   13d0 <read>
    if(cc < 1)
    1389:	85 c0                	test   %eax,%eax
    138b:	7e 12                	jle    139f <gets+0x4f>
      break;
    buf[i++] = c;
    138d:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
    1391:	88 44 1f ff          	mov    %al,-0x1(%edi,%ebx,1)
    if(c == '\n' || c == '\r')
    1395:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
    1399:	3c 0d                	cmp    $0xd,%al
    139b:	75 c3                	jne    1360 <gets+0x10>
    139d:	89 de                	mov    %ebx,%esi
      break;
  }
  buf[i] = '\0';
    139f:	c6 04 37 00          	movb   $0x0,(%edi,%esi,1)
  return buf;
}
    13a3:	89 f8                	mov    %edi,%eax
    13a5:	83 c4 2c             	add    $0x2c,%esp
    13a8:	5b                   	pop    %ebx
    13a9:	5e                   	pop    %esi
    13aa:	5f                   	pop    %edi
    13ab:	5d                   	pop    %ebp
    13ac:	c3                   	ret    
    13ad:	90                   	nop
    13ae:	90                   	nop
    13af:	90                   	nop

000013b0 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    13b0:	b8 01 00 00 00       	mov    $0x1,%eax
    13b5:	cd 40                	int    $0x40
    13b7:	c3                   	ret    

000013b8 <exit>:
SYSCALL(exit)
    13b8:	b8 02 00 00 00       	mov    $0x2,%eax
    13bd:	cd 40                	int    $0x40
    13bf:	c3                   	ret    

000013c0 <wait>:
SYSCALL(wait)
    13c0:	b8 03 00 00 00       	mov    $0x3,%eax
    13c5:	cd 40                	int    $0x40
    13c7:	c3                   	ret    

000013c8 <pipe>:
SYSCALL(pipe)
    13c8:	b8 04 00 00 00       	mov    $0x4,%eax
    13cd:	cd 40                	int    $0x40
    13cf:	c3                   	ret    

000013d0 <read>:
SYSCALL(read)
    13d0:	b8 05 00 00 00       	mov    $0x5,%eax
    13d5:	cd 40                	int    $0x40
    13d7:	c3                   	ret    

000013d8 <write>:
SYSCALL(write)
    13d8:	b8 10 00 00 00       	mov    $0x10,%eax
    13dd:	cd 40                	int    $0x40
    13df:	c3                   	ret    

000013e0 <close>:
SYSCALL(close)
    13e0:	b8 15 00 00 00       	mov    $0x15,%eax
    13e5:	cd 40                	int    $0x40
    13e7:	c3                   	ret    

000013e8 <kill>:
SYSCALL(kill)
    13e8:	b8 06 00 00 00       	mov    $0x6,%eax
    13ed:	cd 40                	int    $0x40
    13ef:	c3                   	ret    

000013f0 <exec>:
SYSCALL(exec)
    13f0:	b8 07 00 00 00       	mov    $0x7,%eax
    13f5:	cd 40                	int    $0x40
    13f7:	c3                   	ret    

000013f8 <open>:
SYSCALL(open)
    13f8:	b8 0f 00 00 00       	mov    $0xf,%eax
    13fd:	cd 40                	int    $0x40
    13ff:	c3                   	ret    

00001400 <mknod>:
SYSCALL(mknod)
    1400:	b8 11 00 00 00       	mov    $0x11,%eax
    1405:	cd 40                	int    $0x40
    1407:	c3                   	ret    

00001408 <unlink>:
SYSCALL(unlink)
    1408:	b8 12 00 00 00       	mov    $0x12,%eax
    140d:	cd 40                	int    $0x40
    140f:	c3                   	ret    

00001410 <fstat>:
SYSCALL(fstat)
    1410:	b8 08 00 00 00       	mov    $0x8,%eax
    1415:	cd 40                	int    $0x40
    1417:	c3                   	ret    

00001418 <link>:
SYSCALL(link)
    1418:	b8 13 00 00 00       	mov    $0x13,%eax
    141d:	cd 40                	int    $0x40
    141f:	c3                   	ret    

00001420 <mkdir>:
SYSCALL(mkdir)
    1420:	b8 14 00 00 00       	mov    $0x14,%eax
    1425:	cd 40                	int    $0x40
    1427:	c3                   	ret    

00001428 <chdir>:
SYSCALL(chdir)
    1428:	b8 09 00 00 00       	mov    $0x9,%eax
    142d:	cd 40                	int    $0x40
    142f:	c3                   	ret    

00001430 <dup>:
SYSCALL(dup)
    1430:	b8 0a 00 00 00       	mov    $0xa,%eax
    1435:	cd 40                	int    $0x40
    1437:	c3                   	ret    

00001438 <getpid>:
SYSCALL(getpid)
    1438:	b8 0b 00 00 00       	mov    $0xb,%eax
    143d:	cd 40                	int    $0x40
    143f:	c3                   	ret    

00001440 <sbrk>:
SYSCALL(sbrk)
    1440:	b8 0c 00 00 00       	mov    $0xc,%eax
    1445:	cd 40                	int    $0x40
    1447:	c3                   	ret    

00001448 <sleep>:
SYSCALL(sleep)
    1448:	b8 0d 00 00 00       	mov    $0xd,%eax
    144d:	cd 40                	int    $0x40
    144f:	c3                   	ret    

00001450 <uptime>:
SYSCALL(uptime)
    1450:	b8 0e 00 00 00       	mov    $0xe,%eax
    1455:	cd 40                	int    $0x40
    1457:	c3                   	ret    

00001458 <hello>:
SYSCALL(hello) 			// added for Lab0
    1458:	b8 16 00 00 00       	mov    $0x16,%eax
    145d:	cd 40                	int    $0x40
    145f:	c3                   	ret    

00001460 <waitpid>:
SYSCALL(waitpid) 		// lab1 part 1: c
    1460:	b8 17 00 00 00       	mov    $0x17,%eax
    1465:	cd 40                	int    $0x40
    1467:	c3                   	ret    

00001468 <setpriority>:
SYSCALL(setpriority) 	// lab1 part 2: define syscall
    1468:	b8 18 00 00 00       	mov    $0x18,%eax
    146d:	cd 40                	int    $0x40
    146f:	c3                   	ret    

00001470 <v2p>:
SYSCALL(v2p)			// lab2
    1470:	b8 19 00 00 00       	mov    $0x19,%eax
    1475:	cd 40                	int    $0x40
    1477:	c3                   	ret    
    1478:	90                   	nop
    1479:	90                   	nop
    147a:	90                   	nop
    147b:	90                   	nop
    147c:	90                   	nop
    147d:	90                   	nop
    147e:	90                   	nop
    147f:	90                   	nop

00001480 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
    1480:	55                   	push   %ebp
    1481:	89 e5                	mov    %esp,%ebp
    1483:	57                   	push   %edi
    1484:	89 cf                	mov    %ecx,%edi
    1486:	56                   	push   %esi
    1487:	89 c6                	mov    %eax,%esi
    1489:	53                   	push   %ebx
    148a:	83 ec 4c             	sub    $0x4c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    148d:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1490:	85 c9                	test   %ecx,%ecx
    1492:	74 04                	je     1498 <printint+0x18>
    1494:	85 d2                	test   %edx,%edx
    1496:	78 68                	js     1500 <printint+0x80>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
    1498:	89 d0                	mov    %edx,%eax
    149a:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
    14a1:	31 c9                	xor    %ecx,%ecx
    14a3:	8d 5d d7             	lea    -0x29(%ebp),%ebx
    14a6:	66 90                	xchg   %ax,%ax
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
    14a8:	31 d2                	xor    %edx,%edx
    14aa:	f7 f7                	div    %edi
    14ac:	0f b6 92 42 1c 00 00 	movzbl 0x1c42(%edx),%edx
    14b3:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
    14b6:	83 c1 01             	add    $0x1,%ecx
  }while((x /= base) != 0);
    14b9:	85 c0                	test   %eax,%eax
    14bb:	75 eb                	jne    14a8 <printint+0x28>
  if(neg)
    14bd:	8b 45 c4             	mov    -0x3c(%ebp),%eax
    14c0:	85 c0                	test   %eax,%eax
    14c2:	74 08                	je     14cc <printint+0x4c>
    buf[i++] = '-';
    14c4:	c6 44 0d d7 2d       	movb   $0x2d,-0x29(%ebp,%ecx,1)
    14c9:	83 c1 01             	add    $0x1,%ecx

  while(--i >= 0)
    14cc:	8d 79 ff             	lea    -0x1(%ecx),%edi
    14cf:	90                   	nop
    14d0:	0f b6 04 3b          	movzbl (%ebx,%edi,1),%eax
    14d4:	83 ef 01             	sub    $0x1,%edi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    14d7:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    14de:	00 
    14df:	89 34 24             	mov    %esi,(%esp)
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
    14e2:	88 45 e7             	mov    %al,-0x19(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    14e5:	8d 45 e7             	lea    -0x19(%ebp),%eax
    14e8:	89 44 24 04          	mov    %eax,0x4(%esp)
    14ec:	e8 e7 fe ff ff       	call   13d8 <write>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
    14f1:	83 ff ff             	cmp    $0xffffffff,%edi
    14f4:	75 da                	jne    14d0 <printint+0x50>
    putc(fd, buf[i]);
}
    14f6:	83 c4 4c             	add    $0x4c,%esp
    14f9:	5b                   	pop    %ebx
    14fa:	5e                   	pop    %esi
    14fb:	5f                   	pop    %edi
    14fc:	5d                   	pop    %ebp
    14fd:	c3                   	ret    
    14fe:	66 90                	xchg   %ax,%ax
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
    1500:	89 d0                	mov    %edx,%eax
    1502:	f7 d8                	neg    %eax
    1504:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
    150b:	eb 94                	jmp    14a1 <printint+0x21>
    150d:	8d 76 00             	lea    0x0(%esi),%esi

00001510 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
    1510:	55                   	push   %ebp
    1511:	89 e5                	mov    %esp,%ebp
    1513:	57                   	push   %edi
    1514:	56                   	push   %esi
    1515:	53                   	push   %ebx
    1516:	83 ec 3c             	sub    $0x3c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    1519:	8b 45 0c             	mov    0xc(%ebp),%eax
    151c:	0f b6 10             	movzbl (%eax),%edx
    151f:	84 d2                	test   %dl,%dl
    1521:	0f 84 c1 00 00 00    	je     15e8 <printf+0xd8>
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
    1527:	8d 4d 10             	lea    0x10(%ebp),%ecx
    152a:	31 ff                	xor    %edi,%edi
    152c:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
    152f:	31 db                	xor    %ebx,%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    1531:	8d 75 e7             	lea    -0x19(%ebp),%esi
    1534:	eb 1e                	jmp    1554 <printf+0x44>
    1536:	66 90                	xchg   %ax,%ax
  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
    1538:	83 fa 25             	cmp    $0x25,%edx
    153b:	0f 85 af 00 00 00    	jne    15f0 <printf+0xe0>
    1541:	66 bf 25 00          	mov    $0x25,%di
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    1545:	83 c3 01             	add    $0x1,%ebx
    1548:	0f b6 14 18          	movzbl (%eax,%ebx,1),%edx
    154c:	84 d2                	test   %dl,%dl
    154e:	0f 84 94 00 00 00    	je     15e8 <printf+0xd8>
    c = fmt[i] & 0xff;
    if(state == 0){
    1554:	85 ff                	test   %edi,%edi
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    1556:	0f b6 d2             	movzbl %dl,%edx
    if(state == 0){
    1559:	74 dd                	je     1538 <printf+0x28>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
    155b:	83 ff 25             	cmp    $0x25,%edi
    155e:	75 e5                	jne    1545 <printf+0x35>
      if(c == 'd'){
    1560:	83 fa 64             	cmp    $0x64,%edx
    1563:	0f 84 3f 01 00 00    	je     16a8 <printf+0x198>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
    1569:	83 fa 70             	cmp    $0x70,%edx
    156c:	0f 84 a6 00 00 00    	je     1618 <printf+0x108>
    1572:	83 fa 78             	cmp    $0x78,%edx
    1575:	0f 84 9d 00 00 00    	je     1618 <printf+0x108>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
    157b:	83 fa 73             	cmp    $0x73,%edx
    157e:	66 90                	xchg   %ax,%ax
    1580:	0f 84 ba 00 00 00    	je     1640 <printf+0x130>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    1586:	83 fa 63             	cmp    $0x63,%edx
    1589:	0f 84 41 01 00 00    	je     16d0 <printf+0x1c0>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
    158f:	83 fa 25             	cmp    $0x25,%edx
    1592:	0f 84 00 01 00 00    	je     1698 <printf+0x188>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    1598:	8b 4d 08             	mov    0x8(%ebp),%ecx
    159b:	89 55 cc             	mov    %edx,-0x34(%ebp)
    159e:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
    15a2:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    15a9:	00 
    15aa:	89 74 24 04          	mov    %esi,0x4(%esp)
    15ae:	89 0c 24             	mov    %ecx,(%esp)
    15b1:	e8 22 fe ff ff       	call   13d8 <write>
    15b6:	8b 55 cc             	mov    -0x34(%ebp),%edx
    15b9:	88 55 e7             	mov    %dl,-0x19(%ebp)
    15bc:	8b 45 08             	mov    0x8(%ebp),%eax
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    15bf:	83 c3 01             	add    $0x1,%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    15c2:	31 ff                	xor    %edi,%edi
    15c4:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    15cb:	00 
    15cc:	89 74 24 04          	mov    %esi,0x4(%esp)
    15d0:	89 04 24             	mov    %eax,(%esp)
    15d3:	e8 00 fe ff ff       	call   13d8 <write>
    15d8:	8b 45 0c             	mov    0xc(%ebp),%eax
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    15db:	0f b6 14 18          	movzbl (%eax,%ebx,1),%edx
    15df:	84 d2                	test   %dl,%dl
    15e1:	0f 85 6d ff ff ff    	jne    1554 <printf+0x44>
    15e7:	90                   	nop
        putc(fd, c);
      }
      state = 0;
    }
  }
}
    15e8:	83 c4 3c             	add    $0x3c,%esp
    15eb:	5b                   	pop    %ebx
    15ec:	5e                   	pop    %esi
    15ed:	5f                   	pop    %edi
    15ee:	5d                   	pop    %ebp
    15ef:	c3                   	ret    
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    15f0:	8b 45 08             	mov    0x8(%ebp),%eax
  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
    15f3:	88 55 e7             	mov    %dl,-0x19(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    15f6:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    15fd:	00 
    15fe:	89 74 24 04          	mov    %esi,0x4(%esp)
    1602:	89 04 24             	mov    %eax,(%esp)
    1605:	e8 ce fd ff ff       	call   13d8 <write>
    160a:	8b 45 0c             	mov    0xc(%ebp),%eax
    160d:	e9 33 ff ff ff       	jmp    1545 <printf+0x35>
    1612:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
    1618:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    161b:	b9 10 00 00 00       	mov    $0x10,%ecx
        ap++;
    1620:	31 ff                	xor    %edi,%edi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
    1622:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1629:	8b 10                	mov    (%eax),%edx
    162b:	8b 45 08             	mov    0x8(%ebp),%eax
    162e:	e8 4d fe ff ff       	call   1480 <printint>
    1633:	8b 45 0c             	mov    0xc(%ebp),%eax
        ap++;
    1636:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
    163a:	e9 06 ff ff ff       	jmp    1545 <printf+0x35>
    163f:	90                   	nop
      } else if(c == 's'){
        s = (char*)*ap;
    1640:	8b 55 d4             	mov    -0x2c(%ebp),%edx
        ap++;
        if(s == 0)
    1643:	b9 3b 1c 00 00       	mov    $0x1c3b,%ecx
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
        s = (char*)*ap;
    1648:	8b 3a                	mov    (%edx),%edi
        ap++;
    164a:	83 c2 04             	add    $0x4,%edx
    164d:	89 55 d4             	mov    %edx,-0x2c(%ebp)
        if(s == 0)
    1650:	85 ff                	test   %edi,%edi
    1652:	0f 44 f9             	cmove  %ecx,%edi
          s = "(null)";
        while(*s != 0){
    1655:	0f b6 17             	movzbl (%edi),%edx
    1658:	84 d2                	test   %dl,%dl
    165a:	74 33                	je     168f <printf+0x17f>
    165c:	89 5d d0             	mov    %ebx,-0x30(%ebp)
    165f:	8b 5d 08             	mov    0x8(%ebp),%ebx
    1662:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
          putc(fd, *s);
          s++;
    1668:	83 c7 01             	add    $0x1,%edi
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
    166b:	88 55 e7             	mov    %dl,-0x19(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    166e:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    1675:	00 
    1676:	89 74 24 04          	mov    %esi,0x4(%esp)
    167a:	89 1c 24             	mov    %ebx,(%esp)
    167d:	e8 56 fd ff ff       	call   13d8 <write>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
    1682:	0f b6 17             	movzbl (%edi),%edx
    1685:	84 d2                	test   %dl,%dl
    1687:	75 df                	jne    1668 <printf+0x158>
    1689:	8b 5d d0             	mov    -0x30(%ebp),%ebx
    168c:	8b 45 0c             	mov    0xc(%ebp),%eax
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    168f:	31 ff                	xor    %edi,%edi
    1691:	e9 af fe ff ff       	jmp    1545 <printf+0x35>
    1696:	66 90                	xchg   %ax,%ax
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
    1698:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
    169c:	e9 1b ff ff ff       	jmp    15bc <printf+0xac>
    16a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
    16a8:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    16ab:	b9 0a 00 00 00       	mov    $0xa,%ecx
        ap++;
    16b0:	66 31 ff             	xor    %di,%di
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
    16b3:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    16ba:	8b 10                	mov    (%eax),%edx
    16bc:	8b 45 08             	mov    0x8(%ebp),%eax
    16bf:	e8 bc fd ff ff       	call   1480 <printint>
    16c4:	8b 45 0c             	mov    0xc(%ebp),%eax
        ap++;
    16c7:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
    16cb:	e9 75 fe ff ff       	jmp    1545 <printf+0x35>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    16d0:	8b 55 d4             	mov    -0x2c(%ebp),%edx
        putc(fd, *ap);
        ap++;
    16d3:	31 ff                	xor    %edi,%edi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    16d5:	8b 4d 08             	mov    0x8(%ebp),%ecx
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    16d8:	8b 02                	mov    (%edx),%eax
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    16da:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    16e1:	00 
    16e2:	89 74 24 04          	mov    %esi,0x4(%esp)
    16e6:	89 0c 24             	mov    %ecx,(%esp)
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    16e9:	88 45 e7             	mov    %al,-0x19(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    16ec:	e8 e7 fc ff ff       	call   13d8 <write>
    16f1:	8b 45 0c             	mov    0xc(%ebp),%eax
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
        ap++;
    16f4:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
    16f8:	e9 48 fe ff ff       	jmp    1545 <printf+0x35>
    16fd:	90                   	nop
    16fe:	90                   	nop
    16ff:	90                   	nop

00001700 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    1700:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1701:	a1 5c 1c 00 00       	mov    0x1c5c,%eax
static Header base;
static Header *freep;

void
free(void *ap)
{
    1706:	89 e5                	mov    %esp,%ebp
    1708:	57                   	push   %edi
    1709:	56                   	push   %esi
    170a:	53                   	push   %ebx
    170b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
    170e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1711:	39 c8                	cmp    %ecx,%eax
    1713:	73 1d                	jae    1732 <free+0x32>
    1715:	8d 76 00             	lea    0x0(%esi),%esi
    1718:	8b 10                	mov    (%eax),%edx
    171a:	39 d1                	cmp    %edx,%ecx
    171c:	72 1a                	jb     1738 <free+0x38>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    171e:	39 d0                	cmp    %edx,%eax
    1720:	72 08                	jb     172a <free+0x2a>
    1722:	39 c8                	cmp    %ecx,%eax
    1724:	72 12                	jb     1738 <free+0x38>
    1726:	39 d1                	cmp    %edx,%ecx
    1728:	72 0e                	jb     1738 <free+0x38>
    172a:	89 d0                	mov    %edx,%eax
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    172c:	39 c8                	cmp    %ecx,%eax
    172e:	66 90                	xchg   %ax,%ax
    1730:	72 e6                	jb     1718 <free+0x18>
    1732:	8b 10                	mov    (%eax),%edx
    1734:	eb e8                	jmp    171e <free+0x1e>
    1736:	66 90                	xchg   %ax,%ax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    1738:	8b 71 04             	mov    0x4(%ecx),%esi
    173b:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    173e:	39 d7                	cmp    %edx,%edi
    1740:	74 19                	je     175b <free+0x5b>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
    1742:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    1745:	8b 50 04             	mov    0x4(%eax),%edx
    1748:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    174b:	39 ce                	cmp    %ecx,%esi
    174d:	74 23                	je     1772 <free+0x72>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
    174f:	89 08                	mov    %ecx,(%eax)
  freep = p;
    1751:	a3 5c 1c 00 00       	mov    %eax,0x1c5c
}
    1756:	5b                   	pop    %ebx
    1757:	5e                   	pop    %esi
    1758:	5f                   	pop    %edi
    1759:	5d                   	pop    %ebp
    175a:	c3                   	ret    
  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
    175b:	03 72 04             	add    0x4(%edx),%esi
    175e:	89 71 04             	mov    %esi,0x4(%ecx)
    bp->s.ptr = p->s.ptr->s.ptr;
    1761:	8b 10                	mov    (%eax),%edx
    1763:	8b 12                	mov    (%edx),%edx
    1765:	89 53 f8             	mov    %edx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    1768:	8b 50 04             	mov    0x4(%eax),%edx
    176b:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    176e:	39 ce                	cmp    %ecx,%esi
    1770:	75 dd                	jne    174f <free+0x4f>
    p->s.size += bp->s.size;
    1772:	03 51 04             	add    0x4(%ecx),%edx
    1775:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    1778:	8b 53 f8             	mov    -0x8(%ebx),%edx
    177b:	89 10                	mov    %edx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
    177d:	a3 5c 1c 00 00       	mov    %eax,0x1c5c
}
    1782:	5b                   	pop    %ebx
    1783:	5e                   	pop    %esi
    1784:	5f                   	pop    %edi
    1785:	5d                   	pop    %ebp
    1786:	c3                   	ret    
    1787:	89 f6                	mov    %esi,%esi
    1789:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001790 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    1790:	55                   	push   %ebp
    1791:	89 e5                	mov    %esp,%ebp
    1793:	57                   	push   %edi
    1794:	56                   	push   %esi
    1795:	53                   	push   %ebx
    1796:	83 ec 2c             	sub    $0x2c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1799:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if((prevp = freep) == 0){
    179c:	8b 0d 5c 1c 00 00    	mov    0x1c5c,%ecx
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    17a2:	83 c3 07             	add    $0x7,%ebx
    17a5:	c1 eb 03             	shr    $0x3,%ebx
    17a8:	83 c3 01             	add    $0x1,%ebx
  if((prevp = freep) == 0){
    17ab:	85 c9                	test   %ecx,%ecx
    17ad:	0f 84 9b 00 00 00    	je     184e <malloc+0xbe>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    17b3:	8b 01                	mov    (%ecx),%eax
    if(p->s.size >= nunits){
    17b5:	8b 50 04             	mov    0x4(%eax),%edx
    17b8:	39 d3                	cmp    %edx,%ebx
    17ba:	76 27                	jbe    17e3 <malloc+0x53>
        p->s.size -= nunits;
        p += p->s.size;
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    17bc:	8d 3c dd 00 00 00 00 	lea    0x0(,%ebx,8),%edi
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < 4096)
    17c3:	be 00 80 00 00       	mov    $0x8000,%esi
    17c8:	89 7d e4             	mov    %edi,-0x1c(%ebp)
    17cb:	90                   	nop
    17cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    17d0:	3b 05 5c 1c 00 00    	cmp    0x1c5c,%eax
    17d6:	74 30                	je     1808 <malloc+0x78>
    17d8:	89 c1                	mov    %eax,%ecx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    17da:	8b 01                	mov    (%ecx),%eax
    if(p->s.size >= nunits){
    17dc:	8b 50 04             	mov    0x4(%eax),%edx
    17df:	39 d3                	cmp    %edx,%ebx
    17e1:	77 ed                	ja     17d0 <malloc+0x40>
      if(p->s.size == nunits)
    17e3:	39 d3                	cmp    %edx,%ebx
    17e5:	74 61                	je     1848 <malloc+0xb8>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
    17e7:	29 da                	sub    %ebx,%edx
    17e9:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
    17ec:	8d 04 d0             	lea    (%eax,%edx,8),%eax
        p->s.size = nunits;
    17ef:	89 58 04             	mov    %ebx,0x4(%eax)
      }
      freep = prevp;
    17f2:	89 0d 5c 1c 00 00    	mov    %ecx,0x1c5c
      return (void*)(p + 1);
    17f8:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
    17fb:	83 c4 2c             	add    $0x2c,%esp
    17fe:	5b                   	pop    %ebx
    17ff:	5e                   	pop    %esi
    1800:	5f                   	pop    %edi
    1801:	5d                   	pop    %ebp
    1802:	c3                   	ret    
    1803:	90                   	nop
    1804:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < 4096)
    1808:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    180b:	81 fb 00 10 00 00    	cmp    $0x1000,%ebx
    1811:	bf 00 10 00 00       	mov    $0x1000,%edi
    1816:	0f 43 fb             	cmovae %ebx,%edi
    1819:	0f 42 c6             	cmovb  %esi,%eax
    nu = 4096;
  p = sbrk(nu * sizeof(Header));
    181c:	89 04 24             	mov    %eax,(%esp)
    181f:	e8 1c fc ff ff       	call   1440 <sbrk>
  if(p == (char*)-1)
    1824:	83 f8 ff             	cmp    $0xffffffff,%eax
    1827:	74 18                	je     1841 <malloc+0xb1>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
    1829:	89 78 04             	mov    %edi,0x4(%eax)
  free((void*)(hp + 1));
    182c:	83 c0 08             	add    $0x8,%eax
    182f:	89 04 24             	mov    %eax,(%esp)
    1832:	e8 c9 fe ff ff       	call   1700 <free>
  return freep;
    1837:	8b 0d 5c 1c 00 00    	mov    0x1c5c,%ecx
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
    183d:	85 c9                	test   %ecx,%ecx
    183f:	75 99                	jne    17da <malloc+0x4a>
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
    1841:	31 c0                	xor    %eax,%eax
    1843:	eb b6                	jmp    17fb <malloc+0x6b>
    1845:	8d 76 00             	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
    1848:	8b 10                	mov    (%eax),%edx
    184a:	89 11                	mov    %edx,(%ecx)
    184c:	eb a4                	jmp    17f2 <malloc+0x62>
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    184e:	c7 05 5c 1c 00 00 54 	movl   $0x1c54,0x1c5c
    1855:	1c 00 00 
    base.s.size = 0;
    1858:	b9 54 1c 00 00       	mov    $0x1c54,%ecx
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    185d:	c7 05 54 1c 00 00 54 	movl   $0x1c54,0x1c54
    1864:	1c 00 00 
    base.s.size = 0;
    1867:	c7 05 58 1c 00 00 00 	movl   $0x0,0x1c58
    186e:	00 00 00 
    1871:	e9 3d ff ff ff       	jmp    17b3 <malloc+0x23>
