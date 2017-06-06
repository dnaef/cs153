
_test:     file format elf32-i386


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
    100a:	c7 44 24 1c f4 01 00 	movl   $0x1f4,0x1c(%esp)
    1011:	00 
  int virtual =(int)&i;
    1012:	8d 5c 24 1c          	lea    0x1c(%esp),%ebx
  int physical=0;
    1016:	c7 44 24 18 00 00 00 	movl   $0x0,0x18(%esp)
    101d:	00 
  
  printf(1,"\n Testing Part 1: Memory translation system cal: \n system call v2p(int virtual, int *physical) \n\n");
    101e:	c7 44 24 04 68 18 00 	movl   $0x1868,0x4(%esp)
    1025:	00 
    1026:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    102d:	e8 ce 04 00 00       	call   1500 <printf>
  
  if(v2p(virtual, &physical))
    1032:	8d 44 24 18          	lea    0x18(%esp),%eax
    1036:	89 44 24 04          	mov    %eax,0x4(%esp)
    103a:	89 1c 24             	mov    %ebx,(%esp)
    103d:	e8 1e 04 00 00       	call   1460 <v2p>
    1042:	85 c0                	test   %eax,%eax
    1044:	0f 84 0e 01 00 00    	je     1158 <main+0x158>
	printf(1,"\n Virtual address 0x%x is mapped to physical address 0x%x \n",virtual, physical);
    104a:	8b 44 24 18          	mov    0x18(%esp),%eax
    104e:	89 5c 24 08          	mov    %ebx,0x8(%esp)
    1052:	c7 44 24 04 cc 18 00 	movl   $0x18cc,0x4(%esp)
    1059:	00 
    105a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1061:	89 44 24 0c          	mov    %eax,0xc(%esp)
    1065:	e8 96 04 00 00       	call   1500 <printf>
  else
	printf(2,"\n v2p system call faild! \n");
	
   printf(1,"\n An example of correct output:\n Virtual address 0x2FCC is mapped to physical address 0xDEDFFCC  \n");
    106a:	c7 44 24 04 08 19 00 	movl   $0x1908,0x4(%esp)
    1071:	00 
    1072:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1079:	e8 82 04 00 00       	call   1500 <printf>
   printf(1,"\n But it is not a guarantee that the system call is correct. The code will be checked! \n");
    107e:	c7 44 24 04 6c 19 00 	movl   $0x196c,0x4(%esp)
    1085:	00 
    1086:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    108d:	e8 6e 04 00 00       	call   1500 <printf>
  
  //____________________________________________________________________
  
   printf(1,"\n Testing Part 2: Null pointer dereference \n");
    1092:	c7 44 24 04 c8 19 00 	movl   $0x19c8,0x4(%esp)
    1099:	00 
    109a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    10a1:	e8 5a 04 00 00       	call   1500 <printf>

   int *p;
   p = &i;
    10a6:	89 5c 24 14          	mov    %ebx,0x14(%esp)

   printf(1,"\n Now we will dereference a proper pointer, we should not get an error\n");
    10aa:	c7 44 24 04 f8 19 00 	movl   $0x19f8,0x4(%esp)
    10b1:	00 
    10b2:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    10b9:	e8 42 04 00 00       	call   1500 <printf>

   printf(1,"\n the contents of the proper pointer are %d and it points to address:0x%x\n\n",*p,&p);
    10be:	8d 44 24 14          	lea    0x14(%esp),%eax
    10c2:	89 44 24 0c          	mov    %eax,0xc(%esp)
    10c6:	8b 44 24 14          	mov    0x14(%esp),%eax
    10ca:	8b 00                	mov    (%eax),%eax
    10cc:	c7 44 24 04 40 1a 00 	movl   $0x1a40,0x4(%esp)
    10d3:	00 
    10d4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    10db:	89 44 24 08          	mov    %eax,0x8(%esp)
    10df:	e8 1c 04 00 00       	call   1500 <printf>
   printf(1,"\n We are going to dereference the null pointer now\n");
    10e4:	c7 44 24 04 8c 1a 00 	movl   $0x1a8c,0x4(%esp)
    10eb:	00 
    10ec:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    10f3:	e8 08 04 00 00       	call   1500 <printf>
   p = 0;
    10f8:	c7 44 24 14 00 00 00 	movl   $0x0,0x14(%esp)
    10ff:	00 
   printf(1,"\n Before fixing the null pointer problem we would get an output like this:\n the contents of the null pointer are 0x83E58955 and it points to address: 0x0\n");
    1100:	c7 44 24 04 c0 1a 00 	movl   $0x1ac0,0x4(%esp)
    1107:	00 
    1108:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    110f:	e8 ec 03 00 00       	call   1500 <printf>
   printf(1,"\n The correct output should be:\n pid 3 lab2: trap 14 err 4 on cpu 0 eip 0x10ba addr 0x0--kill proc \n\n");
    1114:	c7 44 24 04 5c 1b 00 	movl   $0x1b5c,0x4(%esp)
    111b:	00 
    111c:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1123:	e8 d8 03 00 00       	call   1500 <printf>
   
   printf(1,"\n The contents of the null pointer are 0x%x and it points to address: 0x%x\n",*p,p);
    1128:	8b 44 24 14          	mov    0x14(%esp),%eax
    112c:	89 44 24 0c          	mov    %eax,0xc(%esp)
    1130:	8b 00                	mov    (%eax),%eax
    1132:	c7 44 24 04 c4 1b 00 	movl   $0x1bc4,0x4(%esp)
    1139:	00 
    113a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1141:	89 44 24 08          	mov    %eax,0x8(%esp)
    1145:	e8 b6 03 00 00       	call   1500 <printf>
  exit(0);
    114a:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1151:	e8 52 02 00 00       	call   13a8 <exit>
    1156:	66 90                	xchg   %ax,%ax
  printf(1,"\n Testing Part 1: Memory translation system cal: \n system call v2p(int virtual, int *physical) \n\n");
  
  if(v2p(virtual, &physical))
	printf(1,"\n Virtual address 0x%x is mapped to physical address 0x%x \n",virtual, physical);
  else
	printf(2,"\n v2p system call faild! \n");
    1158:	c7 44 24 04 10 1c 00 	movl   $0x1c10,0x4(%esp)
    115f:	00 
    1160:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
    1167:	e8 94 03 00 00       	call   1500 <printf>
    116c:	e9 f9 fe ff ff       	jmp    106a <main+0x6a>
    1171:	90                   	nop
    1172:	90                   	nop
    1173:	90                   	nop
    1174:	90                   	nop
    1175:	90                   	nop
    1176:	90                   	nop
    1177:	90                   	nop
    1178:	90                   	nop
    1179:	90                   	nop
    117a:	90                   	nop
    117b:	90                   	nop
    117c:	90                   	nop
    117d:	90                   	nop
    117e:	90                   	nop
    117f:	90                   	nop

00001180 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
    1180:	55                   	push   %ebp
    1181:	31 d2                	xor    %edx,%edx
    1183:	89 e5                	mov    %esp,%ebp
    1185:	8b 45 08             	mov    0x8(%ebp),%eax
    1188:	53                   	push   %ebx
    1189:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    118c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
    1190:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
    1194:	88 0c 10             	mov    %cl,(%eax,%edx,1)
    1197:	83 c2 01             	add    $0x1,%edx
    119a:	84 c9                	test   %cl,%cl
    119c:	75 f2                	jne    1190 <strcpy+0x10>
    ;
  return os;
}
    119e:	5b                   	pop    %ebx
    119f:	5d                   	pop    %ebp
    11a0:	c3                   	ret    
    11a1:	eb 0d                	jmp    11b0 <strcmp>
    11a3:	90                   	nop
    11a4:	90                   	nop
    11a5:	90                   	nop
    11a6:	90                   	nop
    11a7:	90                   	nop
    11a8:	90                   	nop
    11a9:	90                   	nop
    11aa:	90                   	nop
    11ab:	90                   	nop
    11ac:	90                   	nop
    11ad:	90                   	nop
    11ae:	90                   	nop
    11af:	90                   	nop

000011b0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    11b0:	55                   	push   %ebp
    11b1:	89 e5                	mov    %esp,%ebp
    11b3:	8b 4d 08             	mov    0x8(%ebp),%ecx
    11b6:	53                   	push   %ebx
    11b7:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(*p && *p == *q)
    11ba:	0f b6 01             	movzbl (%ecx),%eax
    11bd:	84 c0                	test   %al,%al
    11bf:	75 14                	jne    11d5 <strcmp+0x25>
    11c1:	eb 25                	jmp    11e8 <strcmp+0x38>
    11c3:	90                   	nop
    11c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    p++, q++;
    11c8:	83 c1 01             	add    $0x1,%ecx
    11cb:	83 c2 01             	add    $0x1,%edx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
    11ce:	0f b6 01             	movzbl (%ecx),%eax
    11d1:	84 c0                	test   %al,%al
    11d3:	74 13                	je     11e8 <strcmp+0x38>
    11d5:	0f b6 1a             	movzbl (%edx),%ebx
    11d8:	38 d8                	cmp    %bl,%al
    11da:	74 ec                	je     11c8 <strcmp+0x18>
    11dc:	0f b6 db             	movzbl %bl,%ebx
    11df:	0f b6 c0             	movzbl %al,%eax
    11e2:	29 d8                	sub    %ebx,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
    11e4:	5b                   	pop    %ebx
    11e5:	5d                   	pop    %ebp
    11e6:	c3                   	ret    
    11e7:	90                   	nop
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
    11e8:	0f b6 1a             	movzbl (%edx),%ebx
    11eb:	31 c0                	xor    %eax,%eax
    11ed:	0f b6 db             	movzbl %bl,%ebx
    11f0:	29 d8                	sub    %ebx,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
    11f2:	5b                   	pop    %ebx
    11f3:	5d                   	pop    %ebp
    11f4:	c3                   	ret    
    11f5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    11f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001200 <strlen>:

uint
strlen(char *s)
{
    1200:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
    1201:	31 d2                	xor    %edx,%edx
  return (uchar)*p - (uchar)*q;
}

uint
strlen(char *s)
{
    1203:	89 e5                	mov    %esp,%ebp
  int n;

  for(n = 0; s[n]; n++)
    1205:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
}

uint
strlen(char *s)
{
    1207:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
    120a:	80 39 00             	cmpb   $0x0,(%ecx)
    120d:	74 0c                	je     121b <strlen+0x1b>
    120f:	90                   	nop
    1210:	83 c2 01             	add    $0x1,%edx
    1213:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
    1217:	89 d0                	mov    %edx,%eax
    1219:	75 f5                	jne    1210 <strlen+0x10>
    ;
  return n;
}
    121b:	5d                   	pop    %ebp
    121c:	c3                   	ret    
    121d:	8d 76 00             	lea    0x0(%esi),%esi

00001220 <memset>:

void*
memset(void *dst, int c, uint n)
{
    1220:	55                   	push   %ebp
    1221:	89 e5                	mov    %esp,%ebp
    1223:	8b 55 08             	mov    0x8(%ebp),%edx
    1226:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
    1227:	8b 4d 10             	mov    0x10(%ebp),%ecx
    122a:	8b 45 0c             	mov    0xc(%ebp),%eax
    122d:	89 d7                	mov    %edx,%edi
    122f:	fc                   	cld    
    1230:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
    1232:	89 d0                	mov    %edx,%eax
    1234:	5f                   	pop    %edi
    1235:	5d                   	pop    %ebp
    1236:	c3                   	ret    
    1237:	89 f6                	mov    %esi,%esi
    1239:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001240 <strchr>:

char*
strchr(const char *s, char c)
{
    1240:	55                   	push   %ebp
    1241:	89 e5                	mov    %esp,%ebp
    1243:	8b 45 08             	mov    0x8(%ebp),%eax
    1246:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
    124a:	0f b6 10             	movzbl (%eax),%edx
    124d:	84 d2                	test   %dl,%dl
    124f:	75 11                	jne    1262 <strchr+0x22>
    1251:	eb 15                	jmp    1268 <strchr+0x28>
    1253:	90                   	nop
    1254:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1258:	83 c0 01             	add    $0x1,%eax
    125b:	0f b6 10             	movzbl (%eax),%edx
    125e:	84 d2                	test   %dl,%dl
    1260:	74 06                	je     1268 <strchr+0x28>
    if(*s == c)
    1262:	38 ca                	cmp    %cl,%dl
    1264:	75 f2                	jne    1258 <strchr+0x18>
      return (char*)s;
  return 0;
}
    1266:	5d                   	pop    %ebp
    1267:	c3                   	ret    
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
    1268:	31 c0                	xor    %eax,%eax
    if(*s == c)
      return (char*)s;
  return 0;
}
    126a:	5d                   	pop    %ebp
    126b:	90                   	nop
    126c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1270:	c3                   	ret    
    1271:	eb 0d                	jmp    1280 <atoi>
    1273:	90                   	nop
    1274:	90                   	nop
    1275:	90                   	nop
    1276:	90                   	nop
    1277:	90                   	nop
    1278:	90                   	nop
    1279:	90                   	nop
    127a:	90                   	nop
    127b:	90                   	nop
    127c:	90                   	nop
    127d:	90                   	nop
    127e:	90                   	nop
    127f:	90                   	nop

00001280 <atoi>:
  return r;
}

int
atoi(const char *s)
{
    1280:	55                   	push   %ebp
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    1281:	31 c0                	xor    %eax,%eax
  return r;
}

int
atoi(const char *s)
{
    1283:	89 e5                	mov    %esp,%ebp
    1285:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1288:	53                   	push   %ebx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    1289:	0f b6 11             	movzbl (%ecx),%edx
    128c:	8d 5a d0             	lea    -0x30(%edx),%ebx
    128f:	80 fb 09             	cmp    $0x9,%bl
    1292:	77 1c                	ja     12b0 <atoi+0x30>
    1294:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    n = n*10 + *s++ - '0';
    1298:	0f be d2             	movsbl %dl,%edx
    129b:	83 c1 01             	add    $0x1,%ecx
    129e:	8d 04 80             	lea    (%eax,%eax,4),%eax
    12a1:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    12a5:	0f b6 11             	movzbl (%ecx),%edx
    12a8:	8d 5a d0             	lea    -0x30(%edx),%ebx
    12ab:	80 fb 09             	cmp    $0x9,%bl
    12ae:	76 e8                	jbe    1298 <atoi+0x18>
    n = n*10 + *s++ - '0';
  return n;
}
    12b0:	5b                   	pop    %ebx
    12b1:	5d                   	pop    %ebp
    12b2:	c3                   	ret    
    12b3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    12b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000012c0 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
    12c0:	55                   	push   %ebp
    12c1:	89 e5                	mov    %esp,%ebp
    12c3:	56                   	push   %esi
    12c4:	8b 45 08             	mov    0x8(%ebp),%eax
    12c7:	53                   	push   %ebx
    12c8:	8b 5d 10             	mov    0x10(%ebp),%ebx
    12cb:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    12ce:	85 db                	test   %ebx,%ebx
    12d0:	7e 14                	jle    12e6 <memmove+0x26>
    n = n*10 + *s++ - '0';
  return n;
}

void*
memmove(void *vdst, void *vsrc, int n)
    12d2:	31 d2                	xor    %edx,%edx
    12d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    *dst++ = *src++;
    12d8:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
    12dc:	88 0c 10             	mov    %cl,(%eax,%edx,1)
    12df:	83 c2 01             	add    $0x1,%edx
{
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    12e2:	39 da                	cmp    %ebx,%edx
    12e4:	75 f2                	jne    12d8 <memmove+0x18>
    *dst++ = *src++;
  return vdst;
}
    12e6:	5b                   	pop    %ebx
    12e7:	5e                   	pop    %esi
    12e8:	5d                   	pop    %ebp
    12e9:	c3                   	ret    
    12ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000012f0 <stat>:
  return buf;
}

int
stat(char *n, struct stat *st)
{
    12f0:	55                   	push   %ebp
    12f1:	89 e5                	mov    %esp,%ebp
    12f3:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    12f6:	8b 45 08             	mov    0x8(%ebp),%eax
  return buf;
}

int
stat(char *n, struct stat *st)
{
    12f9:	89 5d f8             	mov    %ebx,-0x8(%ebp)
    12fc:	89 75 fc             	mov    %esi,-0x4(%ebp)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    12ff:	be ff ff ff ff       	mov    $0xffffffff,%esi
stat(char *n, struct stat *st)
{
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    1304:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    130b:	00 
    130c:	89 04 24             	mov    %eax,(%esp)
    130f:	e8 d4 00 00 00       	call   13e8 <open>
  if(fd < 0)
    1314:	85 c0                	test   %eax,%eax
stat(char *n, struct stat *st)
{
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    1316:	89 c3                	mov    %eax,%ebx
  if(fd < 0)
    1318:	78 19                	js     1333 <stat+0x43>
    return -1;
  r = fstat(fd, st);
    131a:	8b 45 0c             	mov    0xc(%ebp),%eax
    131d:	89 1c 24             	mov    %ebx,(%esp)
    1320:	89 44 24 04          	mov    %eax,0x4(%esp)
    1324:	e8 d7 00 00 00       	call   1400 <fstat>
  close(fd);
    1329:	89 1c 24             	mov    %ebx,(%esp)
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
  r = fstat(fd, st);
    132c:	89 c6                	mov    %eax,%esi
  close(fd);
    132e:	e8 9d 00 00 00       	call   13d0 <close>
  return r;
}
    1333:	89 f0                	mov    %esi,%eax
    1335:	8b 5d f8             	mov    -0x8(%ebp),%ebx
    1338:	8b 75 fc             	mov    -0x4(%ebp),%esi
    133b:	89 ec                	mov    %ebp,%esp
    133d:	5d                   	pop    %ebp
    133e:	c3                   	ret    
    133f:	90                   	nop

00001340 <gets>:
  return 0;
}

char*
gets(char *buf, int max)
{
    1340:	55                   	push   %ebp
    1341:	89 e5                	mov    %esp,%ebp
    1343:	57                   	push   %edi
    1344:	56                   	push   %esi
    1345:	31 f6                	xor    %esi,%esi
    1347:	53                   	push   %ebx
    1348:	83 ec 2c             	sub    $0x2c,%esp
    134b:	8b 7d 08             	mov    0x8(%ebp),%edi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    134e:	eb 06                	jmp    1356 <gets+0x16>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
    1350:	3c 0a                	cmp    $0xa,%al
    1352:	74 39                	je     138d <gets+0x4d>
    1354:	89 de                	mov    %ebx,%esi
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    1356:	8d 5e 01             	lea    0x1(%esi),%ebx
    1359:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
    135c:	7d 31                	jge    138f <gets+0x4f>
    cc = read(0, &c, 1);
    135e:	8d 45 e7             	lea    -0x19(%ebp),%eax
    1361:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    1368:	00 
    1369:	89 44 24 04          	mov    %eax,0x4(%esp)
    136d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1374:	e8 47 00 00 00       	call   13c0 <read>
    if(cc < 1)
    1379:	85 c0                	test   %eax,%eax
    137b:	7e 12                	jle    138f <gets+0x4f>
      break;
    buf[i++] = c;
    137d:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
    1381:	88 44 1f ff          	mov    %al,-0x1(%edi,%ebx,1)
    if(c == '\n' || c == '\r')
    1385:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
    1389:	3c 0d                	cmp    $0xd,%al
    138b:	75 c3                	jne    1350 <gets+0x10>
    138d:	89 de                	mov    %ebx,%esi
      break;
  }
  buf[i] = '\0';
    138f:	c6 04 37 00          	movb   $0x0,(%edi,%esi,1)
  return buf;
}
    1393:	89 f8                	mov    %edi,%eax
    1395:	83 c4 2c             	add    $0x2c,%esp
    1398:	5b                   	pop    %ebx
    1399:	5e                   	pop    %esi
    139a:	5f                   	pop    %edi
    139b:	5d                   	pop    %ebp
    139c:	c3                   	ret    
    139d:	90                   	nop
    139e:	90                   	nop
    139f:	90                   	nop

000013a0 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    13a0:	b8 01 00 00 00       	mov    $0x1,%eax
    13a5:	cd 40                	int    $0x40
    13a7:	c3                   	ret    

000013a8 <exit>:
SYSCALL(exit)
    13a8:	b8 02 00 00 00       	mov    $0x2,%eax
    13ad:	cd 40                	int    $0x40
    13af:	c3                   	ret    

000013b0 <wait>:
SYSCALL(wait)
    13b0:	b8 03 00 00 00       	mov    $0x3,%eax
    13b5:	cd 40                	int    $0x40
    13b7:	c3                   	ret    

000013b8 <pipe>:
SYSCALL(pipe)
    13b8:	b8 04 00 00 00       	mov    $0x4,%eax
    13bd:	cd 40                	int    $0x40
    13bf:	c3                   	ret    

000013c0 <read>:
SYSCALL(read)
    13c0:	b8 05 00 00 00       	mov    $0x5,%eax
    13c5:	cd 40                	int    $0x40
    13c7:	c3                   	ret    

000013c8 <write>:
SYSCALL(write)
    13c8:	b8 10 00 00 00       	mov    $0x10,%eax
    13cd:	cd 40                	int    $0x40
    13cf:	c3                   	ret    

000013d0 <close>:
SYSCALL(close)
    13d0:	b8 15 00 00 00       	mov    $0x15,%eax
    13d5:	cd 40                	int    $0x40
    13d7:	c3                   	ret    

000013d8 <kill>:
SYSCALL(kill)
    13d8:	b8 06 00 00 00       	mov    $0x6,%eax
    13dd:	cd 40                	int    $0x40
    13df:	c3                   	ret    

000013e0 <exec>:
SYSCALL(exec)
    13e0:	b8 07 00 00 00       	mov    $0x7,%eax
    13e5:	cd 40                	int    $0x40
    13e7:	c3                   	ret    

000013e8 <open>:
SYSCALL(open)
    13e8:	b8 0f 00 00 00       	mov    $0xf,%eax
    13ed:	cd 40                	int    $0x40
    13ef:	c3                   	ret    

000013f0 <mknod>:
SYSCALL(mknod)
    13f0:	b8 11 00 00 00       	mov    $0x11,%eax
    13f5:	cd 40                	int    $0x40
    13f7:	c3                   	ret    

000013f8 <unlink>:
SYSCALL(unlink)
    13f8:	b8 12 00 00 00       	mov    $0x12,%eax
    13fd:	cd 40                	int    $0x40
    13ff:	c3                   	ret    

00001400 <fstat>:
SYSCALL(fstat)
    1400:	b8 08 00 00 00       	mov    $0x8,%eax
    1405:	cd 40                	int    $0x40
    1407:	c3                   	ret    

00001408 <link>:
SYSCALL(link)
    1408:	b8 13 00 00 00       	mov    $0x13,%eax
    140d:	cd 40                	int    $0x40
    140f:	c3                   	ret    

00001410 <mkdir>:
SYSCALL(mkdir)
    1410:	b8 14 00 00 00       	mov    $0x14,%eax
    1415:	cd 40                	int    $0x40
    1417:	c3                   	ret    

00001418 <chdir>:
SYSCALL(chdir)
    1418:	b8 09 00 00 00       	mov    $0x9,%eax
    141d:	cd 40                	int    $0x40
    141f:	c3                   	ret    

00001420 <dup>:
SYSCALL(dup)
    1420:	b8 0a 00 00 00       	mov    $0xa,%eax
    1425:	cd 40                	int    $0x40
    1427:	c3                   	ret    

00001428 <getpid>:
SYSCALL(getpid)
    1428:	b8 0b 00 00 00       	mov    $0xb,%eax
    142d:	cd 40                	int    $0x40
    142f:	c3                   	ret    

00001430 <sbrk>:
SYSCALL(sbrk)
    1430:	b8 0c 00 00 00       	mov    $0xc,%eax
    1435:	cd 40                	int    $0x40
    1437:	c3                   	ret    

00001438 <sleep>:
SYSCALL(sleep)
    1438:	b8 0d 00 00 00       	mov    $0xd,%eax
    143d:	cd 40                	int    $0x40
    143f:	c3                   	ret    

00001440 <uptime>:
SYSCALL(uptime)
    1440:	b8 0e 00 00 00       	mov    $0xe,%eax
    1445:	cd 40                	int    $0x40
    1447:	c3                   	ret    

00001448 <hello>:
SYSCALL(hello)
    1448:	b8 16 00 00 00       	mov    $0x16,%eax
    144d:	cd 40                	int    $0x40
    144f:	c3                   	ret    

00001450 <waitpid>:
SYSCALL(waitpid)
    1450:	b8 17 00 00 00       	mov    $0x17,%eax
    1455:	cd 40                	int    $0x40
    1457:	c3                   	ret    

00001458 <setpriority>:
SYSCALL(setpriority)
    1458:	b8 18 00 00 00       	mov    $0x18,%eax
    145d:	cd 40                	int    $0x40
    145f:	c3                   	ret    

00001460 <v2p>:
SYSCALL(v2p)
    1460:	b8 19 00 00 00       	mov    $0x19,%eax
    1465:	cd 40                	int    $0x40
    1467:	c3                   	ret    
    1468:	90                   	nop
    1469:	90                   	nop
    146a:	90                   	nop
    146b:	90                   	nop
    146c:	90                   	nop
    146d:	90                   	nop
    146e:	90                   	nop
    146f:	90                   	nop

00001470 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
    1470:	55                   	push   %ebp
    1471:	89 e5                	mov    %esp,%ebp
    1473:	57                   	push   %edi
    1474:	89 cf                	mov    %ecx,%edi
    1476:	56                   	push   %esi
    1477:	89 c6                	mov    %eax,%esi
    1479:	53                   	push   %ebx
    147a:	83 ec 4c             	sub    $0x4c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    147d:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1480:	85 c9                	test   %ecx,%ecx
    1482:	74 04                	je     1488 <printint+0x18>
    1484:	85 d2                	test   %edx,%edx
    1486:	78 68                	js     14f0 <printint+0x80>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
    1488:	89 d0                	mov    %edx,%eax
    148a:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
    1491:	31 c9                	xor    %ecx,%ecx
    1493:	8d 5d d7             	lea    -0x29(%ebp),%ebx
    1496:	66 90                	xchg   %ax,%ax
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
    1498:	31 d2                	xor    %edx,%edx
    149a:	f7 f7                	div    %edi
    149c:	0f b6 92 32 1c 00 00 	movzbl 0x1c32(%edx),%edx
    14a3:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
    14a6:	83 c1 01             	add    $0x1,%ecx
  }while((x /= base) != 0);
    14a9:	85 c0                	test   %eax,%eax
    14ab:	75 eb                	jne    1498 <printint+0x28>
  if(neg)
    14ad:	8b 45 c4             	mov    -0x3c(%ebp),%eax
    14b0:	85 c0                	test   %eax,%eax
    14b2:	74 08                	je     14bc <printint+0x4c>
    buf[i++] = '-';
    14b4:	c6 44 0d d7 2d       	movb   $0x2d,-0x29(%ebp,%ecx,1)
    14b9:	83 c1 01             	add    $0x1,%ecx

  while(--i >= 0)
    14bc:	8d 79 ff             	lea    -0x1(%ecx),%edi
    14bf:	90                   	nop
    14c0:	0f b6 04 3b          	movzbl (%ebx,%edi,1),%eax
    14c4:	83 ef 01             	sub    $0x1,%edi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    14c7:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    14ce:	00 
    14cf:	89 34 24             	mov    %esi,(%esp)
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
    14d2:	88 45 e7             	mov    %al,-0x19(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    14d5:	8d 45 e7             	lea    -0x19(%ebp),%eax
    14d8:	89 44 24 04          	mov    %eax,0x4(%esp)
    14dc:	e8 e7 fe ff ff       	call   13c8 <write>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
    14e1:	83 ff ff             	cmp    $0xffffffff,%edi
    14e4:	75 da                	jne    14c0 <printint+0x50>
    putc(fd, buf[i]);
}
    14e6:	83 c4 4c             	add    $0x4c,%esp
    14e9:	5b                   	pop    %ebx
    14ea:	5e                   	pop    %esi
    14eb:	5f                   	pop    %edi
    14ec:	5d                   	pop    %ebp
    14ed:	c3                   	ret    
    14ee:	66 90                	xchg   %ax,%ax
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
    14f0:	89 d0                	mov    %edx,%eax
    14f2:	f7 d8                	neg    %eax
    14f4:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
    14fb:	eb 94                	jmp    1491 <printint+0x21>
    14fd:	8d 76 00             	lea    0x0(%esi),%esi

00001500 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
    1500:	55                   	push   %ebp
    1501:	89 e5                	mov    %esp,%ebp
    1503:	57                   	push   %edi
    1504:	56                   	push   %esi
    1505:	53                   	push   %ebx
    1506:	83 ec 3c             	sub    $0x3c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    1509:	8b 45 0c             	mov    0xc(%ebp),%eax
    150c:	0f b6 10             	movzbl (%eax),%edx
    150f:	84 d2                	test   %dl,%dl
    1511:	0f 84 c1 00 00 00    	je     15d8 <printf+0xd8>
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
    1517:	8d 4d 10             	lea    0x10(%ebp),%ecx
    151a:	31 ff                	xor    %edi,%edi
    151c:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
    151f:	31 db                	xor    %ebx,%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    1521:	8d 75 e7             	lea    -0x19(%ebp),%esi
    1524:	eb 1e                	jmp    1544 <printf+0x44>
    1526:	66 90                	xchg   %ax,%ax
  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
    1528:	83 fa 25             	cmp    $0x25,%edx
    152b:	0f 85 af 00 00 00    	jne    15e0 <printf+0xe0>
    1531:	66 bf 25 00          	mov    $0x25,%di
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    1535:	83 c3 01             	add    $0x1,%ebx
    1538:	0f b6 14 18          	movzbl (%eax,%ebx,1),%edx
    153c:	84 d2                	test   %dl,%dl
    153e:	0f 84 94 00 00 00    	je     15d8 <printf+0xd8>
    c = fmt[i] & 0xff;
    if(state == 0){
    1544:	85 ff                	test   %edi,%edi
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    1546:	0f b6 d2             	movzbl %dl,%edx
    if(state == 0){
    1549:	74 dd                	je     1528 <printf+0x28>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
    154b:	83 ff 25             	cmp    $0x25,%edi
    154e:	75 e5                	jne    1535 <printf+0x35>
      if(c == 'd'){
    1550:	83 fa 64             	cmp    $0x64,%edx
    1553:	0f 84 3f 01 00 00    	je     1698 <printf+0x198>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
    1559:	83 fa 70             	cmp    $0x70,%edx
    155c:	0f 84 a6 00 00 00    	je     1608 <printf+0x108>
    1562:	83 fa 78             	cmp    $0x78,%edx
    1565:	0f 84 9d 00 00 00    	je     1608 <printf+0x108>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
    156b:	83 fa 73             	cmp    $0x73,%edx
    156e:	66 90                	xchg   %ax,%ax
    1570:	0f 84 ba 00 00 00    	je     1630 <printf+0x130>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    1576:	83 fa 63             	cmp    $0x63,%edx
    1579:	0f 84 41 01 00 00    	je     16c0 <printf+0x1c0>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
    157f:	83 fa 25             	cmp    $0x25,%edx
    1582:	0f 84 00 01 00 00    	je     1688 <printf+0x188>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    1588:	8b 4d 08             	mov    0x8(%ebp),%ecx
    158b:	89 55 cc             	mov    %edx,-0x34(%ebp)
    158e:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
    1592:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    1599:	00 
    159a:	89 74 24 04          	mov    %esi,0x4(%esp)
    159e:	89 0c 24             	mov    %ecx,(%esp)
    15a1:	e8 22 fe ff ff       	call   13c8 <write>
    15a6:	8b 55 cc             	mov    -0x34(%ebp),%edx
    15a9:	88 55 e7             	mov    %dl,-0x19(%ebp)
    15ac:	8b 45 08             	mov    0x8(%ebp),%eax
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    15af:	83 c3 01             	add    $0x1,%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    15b2:	31 ff                	xor    %edi,%edi
    15b4:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    15bb:	00 
    15bc:	89 74 24 04          	mov    %esi,0x4(%esp)
    15c0:	89 04 24             	mov    %eax,(%esp)
    15c3:	e8 00 fe ff ff       	call   13c8 <write>
    15c8:	8b 45 0c             	mov    0xc(%ebp),%eax
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    15cb:	0f b6 14 18          	movzbl (%eax,%ebx,1),%edx
    15cf:	84 d2                	test   %dl,%dl
    15d1:	0f 85 6d ff ff ff    	jne    1544 <printf+0x44>
    15d7:	90                   	nop
        putc(fd, c);
      }
      state = 0;
    }
  }
}
    15d8:	83 c4 3c             	add    $0x3c,%esp
    15db:	5b                   	pop    %ebx
    15dc:	5e                   	pop    %esi
    15dd:	5f                   	pop    %edi
    15de:	5d                   	pop    %ebp
    15df:	c3                   	ret    
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    15e0:	8b 45 08             	mov    0x8(%ebp),%eax
  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
    15e3:	88 55 e7             	mov    %dl,-0x19(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    15e6:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    15ed:	00 
    15ee:	89 74 24 04          	mov    %esi,0x4(%esp)
    15f2:	89 04 24             	mov    %eax,(%esp)
    15f5:	e8 ce fd ff ff       	call   13c8 <write>
    15fa:	8b 45 0c             	mov    0xc(%ebp),%eax
    15fd:	e9 33 ff ff ff       	jmp    1535 <printf+0x35>
    1602:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
    1608:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    160b:	b9 10 00 00 00       	mov    $0x10,%ecx
        ap++;
    1610:	31 ff                	xor    %edi,%edi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
    1612:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1619:	8b 10                	mov    (%eax),%edx
    161b:	8b 45 08             	mov    0x8(%ebp),%eax
    161e:	e8 4d fe ff ff       	call   1470 <printint>
    1623:	8b 45 0c             	mov    0xc(%ebp),%eax
        ap++;
    1626:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
    162a:	e9 06 ff ff ff       	jmp    1535 <printf+0x35>
    162f:	90                   	nop
      } else if(c == 's'){
        s = (char*)*ap;
    1630:	8b 55 d4             	mov    -0x2c(%ebp),%edx
        ap++;
        if(s == 0)
    1633:	b9 2b 1c 00 00       	mov    $0x1c2b,%ecx
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
        s = (char*)*ap;
    1638:	8b 3a                	mov    (%edx),%edi
        ap++;
    163a:	83 c2 04             	add    $0x4,%edx
    163d:	89 55 d4             	mov    %edx,-0x2c(%ebp)
        if(s == 0)
    1640:	85 ff                	test   %edi,%edi
    1642:	0f 44 f9             	cmove  %ecx,%edi
          s = "(null)";
        while(*s != 0){
    1645:	0f b6 17             	movzbl (%edi),%edx
    1648:	84 d2                	test   %dl,%dl
    164a:	74 33                	je     167f <printf+0x17f>
    164c:	89 5d d0             	mov    %ebx,-0x30(%ebp)
    164f:	8b 5d 08             	mov    0x8(%ebp),%ebx
    1652:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
          putc(fd, *s);
          s++;
    1658:	83 c7 01             	add    $0x1,%edi
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
    165b:	88 55 e7             	mov    %dl,-0x19(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    165e:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    1665:	00 
    1666:	89 74 24 04          	mov    %esi,0x4(%esp)
    166a:	89 1c 24             	mov    %ebx,(%esp)
    166d:	e8 56 fd ff ff       	call   13c8 <write>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
    1672:	0f b6 17             	movzbl (%edi),%edx
    1675:	84 d2                	test   %dl,%dl
    1677:	75 df                	jne    1658 <printf+0x158>
    1679:	8b 5d d0             	mov    -0x30(%ebp),%ebx
    167c:	8b 45 0c             	mov    0xc(%ebp),%eax
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    167f:	31 ff                	xor    %edi,%edi
    1681:	e9 af fe ff ff       	jmp    1535 <printf+0x35>
    1686:	66 90                	xchg   %ax,%ax
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
    1688:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
    168c:	e9 1b ff ff ff       	jmp    15ac <printf+0xac>
    1691:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
    1698:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    169b:	b9 0a 00 00 00       	mov    $0xa,%ecx
        ap++;
    16a0:	66 31 ff             	xor    %di,%di
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
    16a3:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    16aa:	8b 10                	mov    (%eax),%edx
    16ac:	8b 45 08             	mov    0x8(%ebp),%eax
    16af:	e8 bc fd ff ff       	call   1470 <printint>
    16b4:	8b 45 0c             	mov    0xc(%ebp),%eax
        ap++;
    16b7:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
    16bb:	e9 75 fe ff ff       	jmp    1535 <printf+0x35>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    16c0:	8b 55 d4             	mov    -0x2c(%ebp),%edx
        putc(fd, *ap);
        ap++;
    16c3:	31 ff                	xor    %edi,%edi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    16c5:	8b 4d 08             	mov    0x8(%ebp),%ecx
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    16c8:	8b 02                	mov    (%edx),%eax
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    16ca:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    16d1:	00 
    16d2:	89 74 24 04          	mov    %esi,0x4(%esp)
    16d6:	89 0c 24             	mov    %ecx,(%esp)
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    16d9:	88 45 e7             	mov    %al,-0x19(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    16dc:	e8 e7 fc ff ff       	call   13c8 <write>
    16e1:	8b 45 0c             	mov    0xc(%ebp),%eax
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
        ap++;
    16e4:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
    16e8:	e9 48 fe ff ff       	jmp    1535 <printf+0x35>
    16ed:	90                   	nop
    16ee:	90                   	nop
    16ef:	90                   	nop

000016f0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    16f0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    16f1:	a1 4c 1c 00 00       	mov    0x1c4c,%eax
static Header base;
static Header *freep;

void
free(void *ap)
{
    16f6:	89 e5                	mov    %esp,%ebp
    16f8:	57                   	push   %edi
    16f9:	56                   	push   %esi
    16fa:	53                   	push   %ebx
    16fb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
    16fe:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1701:	39 c8                	cmp    %ecx,%eax
    1703:	73 1d                	jae    1722 <free+0x32>
    1705:	8d 76 00             	lea    0x0(%esi),%esi
    1708:	8b 10                	mov    (%eax),%edx
    170a:	39 d1                	cmp    %edx,%ecx
    170c:	72 1a                	jb     1728 <free+0x38>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    170e:	39 d0                	cmp    %edx,%eax
    1710:	72 08                	jb     171a <free+0x2a>
    1712:	39 c8                	cmp    %ecx,%eax
    1714:	72 12                	jb     1728 <free+0x38>
    1716:	39 d1                	cmp    %edx,%ecx
    1718:	72 0e                	jb     1728 <free+0x38>
    171a:	89 d0                	mov    %edx,%eax
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    171c:	39 c8                	cmp    %ecx,%eax
    171e:	66 90                	xchg   %ax,%ax
    1720:	72 e6                	jb     1708 <free+0x18>
    1722:	8b 10                	mov    (%eax),%edx
    1724:	eb e8                	jmp    170e <free+0x1e>
    1726:	66 90                	xchg   %ax,%ax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    1728:	8b 71 04             	mov    0x4(%ecx),%esi
    172b:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    172e:	39 d7                	cmp    %edx,%edi
    1730:	74 19                	je     174b <free+0x5b>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
    1732:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    1735:	8b 50 04             	mov    0x4(%eax),%edx
    1738:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    173b:	39 ce                	cmp    %ecx,%esi
    173d:	74 23                	je     1762 <free+0x72>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
    173f:	89 08                	mov    %ecx,(%eax)
  freep = p;
    1741:	a3 4c 1c 00 00       	mov    %eax,0x1c4c
}
    1746:	5b                   	pop    %ebx
    1747:	5e                   	pop    %esi
    1748:	5f                   	pop    %edi
    1749:	5d                   	pop    %ebp
    174a:	c3                   	ret    
  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
    174b:	03 72 04             	add    0x4(%edx),%esi
    174e:	89 71 04             	mov    %esi,0x4(%ecx)
    bp->s.ptr = p->s.ptr->s.ptr;
    1751:	8b 10                	mov    (%eax),%edx
    1753:	8b 12                	mov    (%edx),%edx
    1755:	89 53 f8             	mov    %edx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    1758:	8b 50 04             	mov    0x4(%eax),%edx
    175b:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    175e:	39 ce                	cmp    %ecx,%esi
    1760:	75 dd                	jne    173f <free+0x4f>
    p->s.size += bp->s.size;
    1762:	03 51 04             	add    0x4(%ecx),%edx
    1765:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    1768:	8b 53 f8             	mov    -0x8(%ebx),%edx
    176b:	89 10                	mov    %edx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
    176d:	a3 4c 1c 00 00       	mov    %eax,0x1c4c
}
    1772:	5b                   	pop    %ebx
    1773:	5e                   	pop    %esi
    1774:	5f                   	pop    %edi
    1775:	5d                   	pop    %ebp
    1776:	c3                   	ret    
    1777:	89 f6                	mov    %esi,%esi
    1779:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001780 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    1780:	55                   	push   %ebp
    1781:	89 e5                	mov    %esp,%ebp
    1783:	57                   	push   %edi
    1784:	56                   	push   %esi
    1785:	53                   	push   %ebx
    1786:	83 ec 2c             	sub    $0x2c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1789:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if((prevp = freep) == 0){
    178c:	8b 0d 4c 1c 00 00    	mov    0x1c4c,%ecx
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1792:	83 c3 07             	add    $0x7,%ebx
    1795:	c1 eb 03             	shr    $0x3,%ebx
    1798:	83 c3 01             	add    $0x1,%ebx
  if((prevp = freep) == 0){
    179b:	85 c9                	test   %ecx,%ecx
    179d:	0f 84 9b 00 00 00    	je     183e <malloc+0xbe>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    17a3:	8b 01                	mov    (%ecx),%eax
    if(p->s.size >= nunits){
    17a5:	8b 50 04             	mov    0x4(%eax),%edx
    17a8:	39 d3                	cmp    %edx,%ebx
    17aa:	76 27                	jbe    17d3 <malloc+0x53>
        p->s.size -= nunits;
        p += p->s.size;
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    17ac:	8d 3c dd 00 00 00 00 	lea    0x0(,%ebx,8),%edi
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < 4096)
    17b3:	be 00 80 00 00       	mov    $0x8000,%esi
    17b8:	89 7d e4             	mov    %edi,-0x1c(%ebp)
    17bb:	90                   	nop
    17bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    17c0:	3b 05 4c 1c 00 00    	cmp    0x1c4c,%eax
    17c6:	74 30                	je     17f8 <malloc+0x78>
    17c8:	89 c1                	mov    %eax,%ecx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    17ca:	8b 01                	mov    (%ecx),%eax
    if(p->s.size >= nunits){
    17cc:	8b 50 04             	mov    0x4(%eax),%edx
    17cf:	39 d3                	cmp    %edx,%ebx
    17d1:	77 ed                	ja     17c0 <malloc+0x40>
      if(p->s.size == nunits)
    17d3:	39 d3                	cmp    %edx,%ebx
    17d5:	74 61                	je     1838 <malloc+0xb8>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
    17d7:	29 da                	sub    %ebx,%edx
    17d9:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
    17dc:	8d 04 d0             	lea    (%eax,%edx,8),%eax
        p->s.size = nunits;
    17df:	89 58 04             	mov    %ebx,0x4(%eax)
      }
      freep = prevp;
    17e2:	89 0d 4c 1c 00 00    	mov    %ecx,0x1c4c
      return (void*)(p + 1);
    17e8:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
    17eb:	83 c4 2c             	add    $0x2c,%esp
    17ee:	5b                   	pop    %ebx
    17ef:	5e                   	pop    %esi
    17f0:	5f                   	pop    %edi
    17f1:	5d                   	pop    %ebp
    17f2:	c3                   	ret    
    17f3:	90                   	nop
    17f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < 4096)
    17f8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    17fb:	81 fb 00 10 00 00    	cmp    $0x1000,%ebx
    1801:	bf 00 10 00 00       	mov    $0x1000,%edi
    1806:	0f 43 fb             	cmovae %ebx,%edi
    1809:	0f 42 c6             	cmovb  %esi,%eax
    nu = 4096;
  p = sbrk(nu * sizeof(Header));
    180c:	89 04 24             	mov    %eax,(%esp)
    180f:	e8 1c fc ff ff       	call   1430 <sbrk>
  if(p == (char*)-1)
    1814:	83 f8 ff             	cmp    $0xffffffff,%eax
    1817:	74 18                	je     1831 <malloc+0xb1>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
    1819:	89 78 04             	mov    %edi,0x4(%eax)
  free((void*)(hp + 1));
    181c:	83 c0 08             	add    $0x8,%eax
    181f:	89 04 24             	mov    %eax,(%esp)
    1822:	e8 c9 fe ff ff       	call   16f0 <free>
  return freep;
    1827:	8b 0d 4c 1c 00 00    	mov    0x1c4c,%ecx
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
    182d:	85 c9                	test   %ecx,%ecx
    182f:	75 99                	jne    17ca <malloc+0x4a>
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
    1831:	31 c0                	xor    %eax,%eax
    1833:	eb b6                	jmp    17eb <malloc+0x6b>
    1835:	8d 76 00             	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
    1838:	8b 10                	mov    (%eax),%edx
    183a:	89 11                	mov    %edx,(%ecx)
    183c:	eb a4                	jmp    17e2 <malloc+0x62>
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    183e:	c7 05 4c 1c 00 00 44 	movl   $0x1c44,0x1c4c
    1845:	1c 00 00 
    base.s.size = 0;
    1848:	b9 44 1c 00 00       	mov    $0x1c44,%ecx
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    184d:	c7 05 44 1c 00 00 44 	movl   $0x1c44,0x1c44
    1854:	1c 00 00 
    base.s.size = 0;
    1857:	c7 05 48 1c 00 00 00 	movl   $0x0,0x1c48
    185e:	00 00 00 
    1861:	e9 3d ff ff ff       	jmp    17a3 <malloc+0x23>
