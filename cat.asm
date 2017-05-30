
_cat:     file format elf32-i386


Disassembly of section .text:

00001000 <cat>:

char buf[512];

void
cat(int fd)
{
    1000:	55                   	push   %ebp
    1001:	89 e5                	mov    %esp,%ebp
    1003:	56                   	push   %esi
    1004:	53                   	push   %ebx
    1005:	83 ec 10             	sub    $0x10,%esp
    1008:	8b 75 08             	mov    0x8(%ebp),%esi
  int n;

  while((n = read(fd, buf, sizeof(buf))) > 0) {
    100b:	eb 1f                	jmp    102c <cat+0x2c>
    100d:	8d 76 00             	lea    0x0(%esi),%esi
    if (write(1, buf, n) != n) {
    1010:	89 5c 24 08          	mov    %ebx,0x8(%esp)
    1014:	c7 44 24 04 c0 18 00 	movl   $0x18c0,0x4(%esp)
    101b:	00 
    101c:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1023:	e8 70 03 00 00       	call   1398 <write>
    1028:	39 c3                	cmp    %eax,%ebx
    102a:	75 28                	jne    1054 <cat+0x54>
void
cat(int fd)
{
  int n;

  while((n = read(fd, buf, sizeof(buf))) > 0) {
    102c:	c7 44 24 08 00 02 00 	movl   $0x200,0x8(%esp)
    1033:	00 
    1034:	c7 44 24 04 c0 18 00 	movl   $0x18c0,0x4(%esp)
    103b:	00 
    103c:	89 34 24             	mov    %esi,(%esp)
    103f:	e8 4c 03 00 00       	call   1390 <read>
    1044:	83 f8 00             	cmp    $0x0,%eax
    1047:	89 c3                	mov    %eax,%ebx
    1049:	7f c5                	jg     1010 <cat+0x10>
    if (write(1, buf, n) != n) {
      printf(1, "cat: write error\n");
      exit(0);
    }
  }
  if(n < 0){
    104b:	75 27                	jne    1074 <cat+0x74>
    printf(1, "cat: read error\n");
    exit(0);
  }
}
    104d:	83 c4 10             	add    $0x10,%esp
    1050:	5b                   	pop    %ebx
    1051:	5e                   	pop    %esi
    1052:	5d                   	pop    %ebp
    1053:	c3                   	ret    
{
  int n;

  while((n = read(fd, buf, sizeof(buf))) > 0) {
    if (write(1, buf, n) != n) {
      printf(1, "cat: write error\n");
    1054:	c7 44 24 04 36 18 00 	movl   $0x1836,0x4(%esp)
    105b:	00 
    105c:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1063:	e8 68 04 00 00       	call   14d0 <printf>
      exit(0);
    1068:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    106f:	e8 04 03 00 00       	call   1378 <exit>
    }
  }
  if(n < 0){
    printf(1, "cat: read error\n");
    1074:	c7 44 24 04 48 18 00 	movl   $0x1848,0x4(%esp)
    107b:	00 
    107c:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1083:	e8 48 04 00 00       	call   14d0 <printf>
    exit(0);
    1088:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    108f:	e8 e4 02 00 00       	call   1378 <exit>
    1094:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    109a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000010a0 <main>:
  }
}

int
main(int argc, char *argv[])
{
    10a0:	55                   	push   %ebp
    10a1:	89 e5                	mov    %esp,%ebp
    10a3:	83 e4 f0             	and    $0xfffffff0,%esp
    10a6:	57                   	push   %edi
    10a7:	56                   	push   %esi
    10a8:	53                   	push   %ebx
    10a9:	83 ec 24             	sub    $0x24,%esp
    10ac:	8b 7d 08             	mov    0x8(%ebp),%edi
  int fd, i;

  if(argc <= 1){
    10af:	83 ff 01             	cmp    $0x1,%edi
    10b2:	7e 7c                	jle    1130 <main+0x90>
    cat(0);
    exit(0);
    10b4:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    10b7:	be 01 00 00 00       	mov    $0x1,%esi
    10bc:	83 c3 04             	add    $0x4,%ebx
    10bf:	90                   	nop
  }

  for(i = 1; i < argc; i++){
    if((fd = open(argv[i], 0)) < 0){
    10c0:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    10c7:	00 
    10c8:	8b 03                	mov    (%ebx),%eax
    10ca:	89 04 24             	mov    %eax,(%esp)
    10cd:	e8 e6 02 00 00       	call   13b8 <open>
    10d2:	85 c0                	test   %eax,%eax
    10d4:	78 32                	js     1108 <main+0x68>
      printf(1, "cat: cannot open %s\n", argv[i]);
      exit(0);
    }
    cat(fd);
    10d6:	89 04 24             	mov    %eax,(%esp)
  if(argc <= 1){
    cat(0);
    exit(0);
  }

  for(i = 1; i < argc; i++){
    10d9:	83 c6 01             	add    $0x1,%esi
    10dc:	83 c3 04             	add    $0x4,%ebx
    if((fd = open(argv[i], 0)) < 0){
      printf(1, "cat: cannot open %s\n", argv[i]);
      exit(0);
    }
    cat(fd);
    10df:	89 44 24 1c          	mov    %eax,0x1c(%esp)
    10e3:	e8 18 ff ff ff       	call   1000 <cat>
    close(fd);
    10e8:	8b 44 24 1c          	mov    0x1c(%esp),%eax
    10ec:	89 04 24             	mov    %eax,(%esp)
    10ef:	e8 ac 02 00 00       	call   13a0 <close>
  if(argc <= 1){
    cat(0);
    exit(0);
  }

  for(i = 1; i < argc; i++){
    10f4:	39 f7                	cmp    %esi,%edi
    10f6:	7f c8                	jg     10c0 <main+0x20>
      exit(0);
    }
    cat(fd);
    close(fd);
  }
  exit(0);
    10f8:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    10ff:	e8 74 02 00 00       	call   1378 <exit>
    1104:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    exit(0);
  }

  for(i = 1; i < argc; i++){
    if((fd = open(argv[i], 0)) < 0){
      printf(1, "cat: cannot open %s\n", argv[i]);
    1108:	8b 03                	mov    (%ebx),%eax
    110a:	c7 44 24 04 59 18 00 	movl   $0x1859,0x4(%esp)
    1111:	00 
    1112:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1119:	89 44 24 08          	mov    %eax,0x8(%esp)
    111d:	e8 ae 03 00 00       	call   14d0 <printf>
      exit(0);
    1122:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1129:	e8 4a 02 00 00       	call   1378 <exit>
    112e:	66 90                	xchg   %ax,%ax
main(int argc, char *argv[])
{
  int fd, i;

  if(argc <= 1){
    cat(0);
    1130:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1137:	e8 c4 fe ff ff       	call   1000 <cat>
    exit(0);
    113c:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1143:	e8 30 02 00 00       	call   1378 <exit>
    1148:	90                   	nop
    1149:	90                   	nop
    114a:	90                   	nop
    114b:	90                   	nop
    114c:	90                   	nop
    114d:	90                   	nop
    114e:	90                   	nop
    114f:	90                   	nop

00001150 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
    1150:	55                   	push   %ebp
    1151:	31 d2                	xor    %edx,%edx
    1153:	89 e5                	mov    %esp,%ebp
    1155:	8b 45 08             	mov    0x8(%ebp),%eax
    1158:	53                   	push   %ebx
    1159:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    115c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
    1160:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
    1164:	88 0c 10             	mov    %cl,(%eax,%edx,1)
    1167:	83 c2 01             	add    $0x1,%edx
    116a:	84 c9                	test   %cl,%cl
    116c:	75 f2                	jne    1160 <strcpy+0x10>
    ;
  return os;
}
    116e:	5b                   	pop    %ebx
    116f:	5d                   	pop    %ebp
    1170:	c3                   	ret    
    1171:	eb 0d                	jmp    1180 <strcmp>
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

00001180 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    1180:	55                   	push   %ebp
    1181:	89 e5                	mov    %esp,%ebp
    1183:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1186:	53                   	push   %ebx
    1187:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(*p && *p == *q)
    118a:	0f b6 01             	movzbl (%ecx),%eax
    118d:	84 c0                	test   %al,%al
    118f:	75 14                	jne    11a5 <strcmp+0x25>
    1191:	eb 25                	jmp    11b8 <strcmp+0x38>
    1193:	90                   	nop
    1194:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    p++, q++;
    1198:	83 c1 01             	add    $0x1,%ecx
    119b:	83 c2 01             	add    $0x1,%edx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
    119e:	0f b6 01             	movzbl (%ecx),%eax
    11a1:	84 c0                	test   %al,%al
    11a3:	74 13                	je     11b8 <strcmp+0x38>
    11a5:	0f b6 1a             	movzbl (%edx),%ebx
    11a8:	38 d8                	cmp    %bl,%al
    11aa:	74 ec                	je     1198 <strcmp+0x18>
    11ac:	0f b6 db             	movzbl %bl,%ebx
    11af:	0f b6 c0             	movzbl %al,%eax
    11b2:	29 d8                	sub    %ebx,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
    11b4:	5b                   	pop    %ebx
    11b5:	5d                   	pop    %ebp
    11b6:	c3                   	ret    
    11b7:	90                   	nop
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
    11b8:	0f b6 1a             	movzbl (%edx),%ebx
    11bb:	31 c0                	xor    %eax,%eax
    11bd:	0f b6 db             	movzbl %bl,%ebx
    11c0:	29 d8                	sub    %ebx,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
    11c2:	5b                   	pop    %ebx
    11c3:	5d                   	pop    %ebp
    11c4:	c3                   	ret    
    11c5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    11c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000011d0 <strlen>:

uint
strlen(char *s)
{
    11d0:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
    11d1:	31 d2                	xor    %edx,%edx
  return (uchar)*p - (uchar)*q;
}

uint
strlen(char *s)
{
    11d3:	89 e5                	mov    %esp,%ebp
  int n;

  for(n = 0; s[n]; n++)
    11d5:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
}

uint
strlen(char *s)
{
    11d7:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
    11da:	80 39 00             	cmpb   $0x0,(%ecx)
    11dd:	74 0c                	je     11eb <strlen+0x1b>
    11df:	90                   	nop
    11e0:	83 c2 01             	add    $0x1,%edx
    11e3:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
    11e7:	89 d0                	mov    %edx,%eax
    11e9:	75 f5                	jne    11e0 <strlen+0x10>
    ;
  return n;
}
    11eb:	5d                   	pop    %ebp
    11ec:	c3                   	ret    
    11ed:	8d 76 00             	lea    0x0(%esi),%esi

000011f0 <memset>:

void*
memset(void *dst, int c, uint n)
{
    11f0:	55                   	push   %ebp
    11f1:	89 e5                	mov    %esp,%ebp
    11f3:	8b 55 08             	mov    0x8(%ebp),%edx
    11f6:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
    11f7:	8b 4d 10             	mov    0x10(%ebp),%ecx
    11fa:	8b 45 0c             	mov    0xc(%ebp),%eax
    11fd:	89 d7                	mov    %edx,%edi
    11ff:	fc                   	cld    
    1200:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
    1202:	89 d0                	mov    %edx,%eax
    1204:	5f                   	pop    %edi
    1205:	5d                   	pop    %ebp
    1206:	c3                   	ret    
    1207:	89 f6                	mov    %esi,%esi
    1209:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001210 <strchr>:

char*
strchr(const char *s, char c)
{
    1210:	55                   	push   %ebp
    1211:	89 e5                	mov    %esp,%ebp
    1213:	8b 45 08             	mov    0x8(%ebp),%eax
    1216:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
    121a:	0f b6 10             	movzbl (%eax),%edx
    121d:	84 d2                	test   %dl,%dl
    121f:	75 11                	jne    1232 <strchr+0x22>
    1221:	eb 15                	jmp    1238 <strchr+0x28>
    1223:	90                   	nop
    1224:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1228:	83 c0 01             	add    $0x1,%eax
    122b:	0f b6 10             	movzbl (%eax),%edx
    122e:	84 d2                	test   %dl,%dl
    1230:	74 06                	je     1238 <strchr+0x28>
    if(*s == c)
    1232:	38 ca                	cmp    %cl,%dl
    1234:	75 f2                	jne    1228 <strchr+0x18>
      return (char*)s;
  return 0;
}
    1236:	5d                   	pop    %ebp
    1237:	c3                   	ret    
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
    1238:	31 c0                	xor    %eax,%eax
    if(*s == c)
      return (char*)s;
  return 0;
}
    123a:	5d                   	pop    %ebp
    123b:	90                   	nop
    123c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1240:	c3                   	ret    
    1241:	eb 0d                	jmp    1250 <atoi>
    1243:	90                   	nop
    1244:	90                   	nop
    1245:	90                   	nop
    1246:	90                   	nop
    1247:	90                   	nop
    1248:	90                   	nop
    1249:	90                   	nop
    124a:	90                   	nop
    124b:	90                   	nop
    124c:	90                   	nop
    124d:	90                   	nop
    124e:	90                   	nop
    124f:	90                   	nop

00001250 <atoi>:
  return r;
}

int
atoi(const char *s)
{
    1250:	55                   	push   %ebp
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    1251:	31 c0                	xor    %eax,%eax
  return r;
}

int
atoi(const char *s)
{
    1253:	89 e5                	mov    %esp,%ebp
    1255:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1258:	53                   	push   %ebx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    1259:	0f b6 11             	movzbl (%ecx),%edx
    125c:	8d 5a d0             	lea    -0x30(%edx),%ebx
    125f:	80 fb 09             	cmp    $0x9,%bl
    1262:	77 1c                	ja     1280 <atoi+0x30>
    1264:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    n = n*10 + *s++ - '0';
    1268:	0f be d2             	movsbl %dl,%edx
    126b:	83 c1 01             	add    $0x1,%ecx
    126e:	8d 04 80             	lea    (%eax,%eax,4),%eax
    1271:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    1275:	0f b6 11             	movzbl (%ecx),%edx
    1278:	8d 5a d0             	lea    -0x30(%edx),%ebx
    127b:	80 fb 09             	cmp    $0x9,%bl
    127e:	76 e8                	jbe    1268 <atoi+0x18>
    n = n*10 + *s++ - '0';
  return n;
}
    1280:	5b                   	pop    %ebx
    1281:	5d                   	pop    %ebp
    1282:	c3                   	ret    
    1283:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    1289:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001290 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
    1290:	55                   	push   %ebp
    1291:	89 e5                	mov    %esp,%ebp
    1293:	56                   	push   %esi
    1294:	8b 45 08             	mov    0x8(%ebp),%eax
    1297:	53                   	push   %ebx
    1298:	8b 5d 10             	mov    0x10(%ebp),%ebx
    129b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    129e:	85 db                	test   %ebx,%ebx
    12a0:	7e 14                	jle    12b6 <memmove+0x26>
    n = n*10 + *s++ - '0';
  return n;
}

void*
memmove(void *vdst, void *vsrc, int n)
    12a2:	31 d2                	xor    %edx,%edx
    12a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    *dst++ = *src++;
    12a8:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
    12ac:	88 0c 10             	mov    %cl,(%eax,%edx,1)
    12af:	83 c2 01             	add    $0x1,%edx
{
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    12b2:	39 da                	cmp    %ebx,%edx
    12b4:	75 f2                	jne    12a8 <memmove+0x18>
    *dst++ = *src++;
  return vdst;
}
    12b6:	5b                   	pop    %ebx
    12b7:	5e                   	pop    %esi
    12b8:	5d                   	pop    %ebp
    12b9:	c3                   	ret    
    12ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000012c0 <stat>:
  return buf;
}

int
stat(char *n, struct stat *st)
{
    12c0:	55                   	push   %ebp
    12c1:	89 e5                	mov    %esp,%ebp
    12c3:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    12c6:	8b 45 08             	mov    0x8(%ebp),%eax
  return buf;
}

int
stat(char *n, struct stat *st)
{
    12c9:	89 5d f8             	mov    %ebx,-0x8(%ebp)
    12cc:	89 75 fc             	mov    %esi,-0x4(%ebp)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    12cf:	be ff ff ff ff       	mov    $0xffffffff,%esi
stat(char *n, struct stat *st)
{
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    12d4:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    12db:	00 
    12dc:	89 04 24             	mov    %eax,(%esp)
    12df:	e8 d4 00 00 00       	call   13b8 <open>
  if(fd < 0)
    12e4:	85 c0                	test   %eax,%eax
stat(char *n, struct stat *st)
{
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    12e6:	89 c3                	mov    %eax,%ebx
  if(fd < 0)
    12e8:	78 19                	js     1303 <stat+0x43>
    return -1;
  r = fstat(fd, st);
    12ea:	8b 45 0c             	mov    0xc(%ebp),%eax
    12ed:	89 1c 24             	mov    %ebx,(%esp)
    12f0:	89 44 24 04          	mov    %eax,0x4(%esp)
    12f4:	e8 d7 00 00 00       	call   13d0 <fstat>
  close(fd);
    12f9:	89 1c 24             	mov    %ebx,(%esp)
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
  r = fstat(fd, st);
    12fc:	89 c6                	mov    %eax,%esi
  close(fd);
    12fe:	e8 9d 00 00 00       	call   13a0 <close>
  return r;
}
    1303:	89 f0                	mov    %esi,%eax
    1305:	8b 5d f8             	mov    -0x8(%ebp),%ebx
    1308:	8b 75 fc             	mov    -0x4(%ebp),%esi
    130b:	89 ec                	mov    %ebp,%esp
    130d:	5d                   	pop    %ebp
    130e:	c3                   	ret    
    130f:	90                   	nop

00001310 <gets>:
  return 0;
}

char*
gets(char *buf, int max)
{
    1310:	55                   	push   %ebp
    1311:	89 e5                	mov    %esp,%ebp
    1313:	57                   	push   %edi
    1314:	56                   	push   %esi
    1315:	31 f6                	xor    %esi,%esi
    1317:	53                   	push   %ebx
    1318:	83 ec 2c             	sub    $0x2c,%esp
    131b:	8b 7d 08             	mov    0x8(%ebp),%edi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    131e:	eb 06                	jmp    1326 <gets+0x16>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
    1320:	3c 0a                	cmp    $0xa,%al
    1322:	74 39                	je     135d <gets+0x4d>
    1324:	89 de                	mov    %ebx,%esi
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    1326:	8d 5e 01             	lea    0x1(%esi),%ebx
    1329:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
    132c:	7d 31                	jge    135f <gets+0x4f>
    cc = read(0, &c, 1);
    132e:	8d 45 e7             	lea    -0x19(%ebp),%eax
    1331:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    1338:	00 
    1339:	89 44 24 04          	mov    %eax,0x4(%esp)
    133d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1344:	e8 47 00 00 00       	call   1390 <read>
    if(cc < 1)
    1349:	85 c0                	test   %eax,%eax
    134b:	7e 12                	jle    135f <gets+0x4f>
      break;
    buf[i++] = c;
    134d:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
    1351:	88 44 1f ff          	mov    %al,-0x1(%edi,%ebx,1)
    if(c == '\n' || c == '\r')
    1355:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
    1359:	3c 0d                	cmp    $0xd,%al
    135b:	75 c3                	jne    1320 <gets+0x10>
    135d:	89 de                	mov    %ebx,%esi
      break;
  }
  buf[i] = '\0';
    135f:	c6 04 37 00          	movb   $0x0,(%edi,%esi,1)
  return buf;
}
    1363:	89 f8                	mov    %edi,%eax
    1365:	83 c4 2c             	add    $0x2c,%esp
    1368:	5b                   	pop    %ebx
    1369:	5e                   	pop    %esi
    136a:	5f                   	pop    %edi
    136b:	5d                   	pop    %ebp
    136c:	c3                   	ret    
    136d:	90                   	nop
    136e:	90                   	nop
    136f:	90                   	nop

00001370 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    1370:	b8 01 00 00 00       	mov    $0x1,%eax
    1375:	cd 40                	int    $0x40
    1377:	c3                   	ret    

00001378 <exit>:
SYSCALL(exit)
    1378:	b8 02 00 00 00       	mov    $0x2,%eax
    137d:	cd 40                	int    $0x40
    137f:	c3                   	ret    

00001380 <wait>:
SYSCALL(wait)
    1380:	b8 03 00 00 00       	mov    $0x3,%eax
    1385:	cd 40                	int    $0x40
    1387:	c3                   	ret    

00001388 <pipe>:
SYSCALL(pipe)
    1388:	b8 04 00 00 00       	mov    $0x4,%eax
    138d:	cd 40                	int    $0x40
    138f:	c3                   	ret    

00001390 <read>:
SYSCALL(read)
    1390:	b8 05 00 00 00       	mov    $0x5,%eax
    1395:	cd 40                	int    $0x40
    1397:	c3                   	ret    

00001398 <write>:
SYSCALL(write)
    1398:	b8 10 00 00 00       	mov    $0x10,%eax
    139d:	cd 40                	int    $0x40
    139f:	c3                   	ret    

000013a0 <close>:
SYSCALL(close)
    13a0:	b8 15 00 00 00       	mov    $0x15,%eax
    13a5:	cd 40                	int    $0x40
    13a7:	c3                   	ret    

000013a8 <kill>:
SYSCALL(kill)
    13a8:	b8 06 00 00 00       	mov    $0x6,%eax
    13ad:	cd 40                	int    $0x40
    13af:	c3                   	ret    

000013b0 <exec>:
SYSCALL(exec)
    13b0:	b8 07 00 00 00       	mov    $0x7,%eax
    13b5:	cd 40                	int    $0x40
    13b7:	c3                   	ret    

000013b8 <open>:
SYSCALL(open)
    13b8:	b8 0f 00 00 00       	mov    $0xf,%eax
    13bd:	cd 40                	int    $0x40
    13bf:	c3                   	ret    

000013c0 <mknod>:
SYSCALL(mknod)
    13c0:	b8 11 00 00 00       	mov    $0x11,%eax
    13c5:	cd 40                	int    $0x40
    13c7:	c3                   	ret    

000013c8 <unlink>:
SYSCALL(unlink)
    13c8:	b8 12 00 00 00       	mov    $0x12,%eax
    13cd:	cd 40                	int    $0x40
    13cf:	c3                   	ret    

000013d0 <fstat>:
SYSCALL(fstat)
    13d0:	b8 08 00 00 00       	mov    $0x8,%eax
    13d5:	cd 40                	int    $0x40
    13d7:	c3                   	ret    

000013d8 <link>:
SYSCALL(link)
    13d8:	b8 13 00 00 00       	mov    $0x13,%eax
    13dd:	cd 40                	int    $0x40
    13df:	c3                   	ret    

000013e0 <mkdir>:
SYSCALL(mkdir)
    13e0:	b8 14 00 00 00       	mov    $0x14,%eax
    13e5:	cd 40                	int    $0x40
    13e7:	c3                   	ret    

000013e8 <chdir>:
SYSCALL(chdir)
    13e8:	b8 09 00 00 00       	mov    $0x9,%eax
    13ed:	cd 40                	int    $0x40
    13ef:	c3                   	ret    

000013f0 <dup>:
SYSCALL(dup)
    13f0:	b8 0a 00 00 00       	mov    $0xa,%eax
    13f5:	cd 40                	int    $0x40
    13f7:	c3                   	ret    

000013f8 <getpid>:
SYSCALL(getpid)
    13f8:	b8 0b 00 00 00       	mov    $0xb,%eax
    13fd:	cd 40                	int    $0x40
    13ff:	c3                   	ret    

00001400 <sbrk>:
SYSCALL(sbrk)
    1400:	b8 0c 00 00 00       	mov    $0xc,%eax
    1405:	cd 40                	int    $0x40
    1407:	c3                   	ret    

00001408 <sleep>:
SYSCALL(sleep)
    1408:	b8 0d 00 00 00       	mov    $0xd,%eax
    140d:	cd 40                	int    $0x40
    140f:	c3                   	ret    

00001410 <uptime>:
SYSCALL(uptime)
    1410:	b8 0e 00 00 00       	mov    $0xe,%eax
    1415:	cd 40                	int    $0x40
    1417:	c3                   	ret    

00001418 <hello>:
SYSCALL(hello) 			// added for Lab0
    1418:	b8 16 00 00 00       	mov    $0x16,%eax
    141d:	cd 40                	int    $0x40
    141f:	c3                   	ret    

00001420 <waitpid>:
SYSCALL(waitpid) 		// lab1 part 1: c
    1420:	b8 17 00 00 00       	mov    $0x17,%eax
    1425:	cd 40                	int    $0x40
    1427:	c3                   	ret    

00001428 <setpriority>:
SYSCALL(setpriority) 	// lab1 part 2: define syscall
    1428:	b8 18 00 00 00       	mov    $0x18,%eax
    142d:	cd 40                	int    $0x40
    142f:	c3                   	ret    

00001430 <v2p>:
SYSCALL(v2p)			// lab2
    1430:	b8 19 00 00 00       	mov    $0x19,%eax
    1435:	cd 40                	int    $0x40
    1437:	c3                   	ret    
    1438:	90                   	nop
    1439:	90                   	nop
    143a:	90                   	nop
    143b:	90                   	nop
    143c:	90                   	nop
    143d:	90                   	nop
    143e:	90                   	nop
    143f:	90                   	nop

00001440 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
    1440:	55                   	push   %ebp
    1441:	89 e5                	mov    %esp,%ebp
    1443:	57                   	push   %edi
    1444:	89 cf                	mov    %ecx,%edi
    1446:	56                   	push   %esi
    1447:	89 c6                	mov    %eax,%esi
    1449:	53                   	push   %ebx
    144a:	83 ec 4c             	sub    $0x4c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    144d:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1450:	85 c9                	test   %ecx,%ecx
    1452:	74 04                	je     1458 <printint+0x18>
    1454:	85 d2                	test   %edx,%edx
    1456:	78 68                	js     14c0 <printint+0x80>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
    1458:	89 d0                	mov    %edx,%eax
    145a:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
    1461:	31 c9                	xor    %ecx,%ecx
    1463:	8d 5d d7             	lea    -0x29(%ebp),%ebx
    1466:	66 90                	xchg   %ax,%ax
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
    1468:	31 d2                	xor    %edx,%edx
    146a:	f7 f7                	div    %edi
    146c:	0f b6 92 75 18 00 00 	movzbl 0x1875(%edx),%edx
    1473:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
    1476:	83 c1 01             	add    $0x1,%ecx
  }while((x /= base) != 0);
    1479:	85 c0                	test   %eax,%eax
    147b:	75 eb                	jne    1468 <printint+0x28>
  if(neg)
    147d:	8b 45 c4             	mov    -0x3c(%ebp),%eax
    1480:	85 c0                	test   %eax,%eax
    1482:	74 08                	je     148c <printint+0x4c>
    buf[i++] = '-';
    1484:	c6 44 0d d7 2d       	movb   $0x2d,-0x29(%ebp,%ecx,1)
    1489:	83 c1 01             	add    $0x1,%ecx

  while(--i >= 0)
    148c:	8d 79 ff             	lea    -0x1(%ecx),%edi
    148f:	90                   	nop
    1490:	0f b6 04 3b          	movzbl (%ebx,%edi,1),%eax
    1494:	83 ef 01             	sub    $0x1,%edi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    1497:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    149e:	00 
    149f:	89 34 24             	mov    %esi,(%esp)
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
    14a2:	88 45 e7             	mov    %al,-0x19(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    14a5:	8d 45 e7             	lea    -0x19(%ebp),%eax
    14a8:	89 44 24 04          	mov    %eax,0x4(%esp)
    14ac:	e8 e7 fe ff ff       	call   1398 <write>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
    14b1:	83 ff ff             	cmp    $0xffffffff,%edi
    14b4:	75 da                	jne    1490 <printint+0x50>
    putc(fd, buf[i]);
}
    14b6:	83 c4 4c             	add    $0x4c,%esp
    14b9:	5b                   	pop    %ebx
    14ba:	5e                   	pop    %esi
    14bb:	5f                   	pop    %edi
    14bc:	5d                   	pop    %ebp
    14bd:	c3                   	ret    
    14be:	66 90                	xchg   %ax,%ax
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
    14c0:	89 d0                	mov    %edx,%eax
    14c2:	f7 d8                	neg    %eax
    14c4:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
    14cb:	eb 94                	jmp    1461 <printint+0x21>
    14cd:	8d 76 00             	lea    0x0(%esi),%esi

000014d0 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
    14d0:	55                   	push   %ebp
    14d1:	89 e5                	mov    %esp,%ebp
    14d3:	57                   	push   %edi
    14d4:	56                   	push   %esi
    14d5:	53                   	push   %ebx
    14d6:	83 ec 3c             	sub    $0x3c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    14d9:	8b 45 0c             	mov    0xc(%ebp),%eax
    14dc:	0f b6 10             	movzbl (%eax),%edx
    14df:	84 d2                	test   %dl,%dl
    14e1:	0f 84 c1 00 00 00    	je     15a8 <printf+0xd8>
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
    14e7:	8d 4d 10             	lea    0x10(%ebp),%ecx
    14ea:	31 ff                	xor    %edi,%edi
    14ec:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
    14ef:	31 db                	xor    %ebx,%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    14f1:	8d 75 e7             	lea    -0x19(%ebp),%esi
    14f4:	eb 1e                	jmp    1514 <printf+0x44>
    14f6:	66 90                	xchg   %ax,%ax
  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
    14f8:	83 fa 25             	cmp    $0x25,%edx
    14fb:	0f 85 af 00 00 00    	jne    15b0 <printf+0xe0>
    1501:	66 bf 25 00          	mov    $0x25,%di
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    1505:	83 c3 01             	add    $0x1,%ebx
    1508:	0f b6 14 18          	movzbl (%eax,%ebx,1),%edx
    150c:	84 d2                	test   %dl,%dl
    150e:	0f 84 94 00 00 00    	je     15a8 <printf+0xd8>
    c = fmt[i] & 0xff;
    if(state == 0){
    1514:	85 ff                	test   %edi,%edi
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    1516:	0f b6 d2             	movzbl %dl,%edx
    if(state == 0){
    1519:	74 dd                	je     14f8 <printf+0x28>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
    151b:	83 ff 25             	cmp    $0x25,%edi
    151e:	75 e5                	jne    1505 <printf+0x35>
      if(c == 'd'){
    1520:	83 fa 64             	cmp    $0x64,%edx
    1523:	0f 84 3f 01 00 00    	je     1668 <printf+0x198>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
    1529:	83 fa 70             	cmp    $0x70,%edx
    152c:	0f 84 a6 00 00 00    	je     15d8 <printf+0x108>
    1532:	83 fa 78             	cmp    $0x78,%edx
    1535:	0f 84 9d 00 00 00    	je     15d8 <printf+0x108>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
    153b:	83 fa 73             	cmp    $0x73,%edx
    153e:	66 90                	xchg   %ax,%ax
    1540:	0f 84 ba 00 00 00    	je     1600 <printf+0x130>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    1546:	83 fa 63             	cmp    $0x63,%edx
    1549:	0f 84 41 01 00 00    	je     1690 <printf+0x1c0>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
    154f:	83 fa 25             	cmp    $0x25,%edx
    1552:	0f 84 00 01 00 00    	je     1658 <printf+0x188>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    1558:	8b 4d 08             	mov    0x8(%ebp),%ecx
    155b:	89 55 cc             	mov    %edx,-0x34(%ebp)
    155e:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
    1562:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    1569:	00 
    156a:	89 74 24 04          	mov    %esi,0x4(%esp)
    156e:	89 0c 24             	mov    %ecx,(%esp)
    1571:	e8 22 fe ff ff       	call   1398 <write>
    1576:	8b 55 cc             	mov    -0x34(%ebp),%edx
    1579:	88 55 e7             	mov    %dl,-0x19(%ebp)
    157c:	8b 45 08             	mov    0x8(%ebp),%eax
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    157f:	83 c3 01             	add    $0x1,%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    1582:	31 ff                	xor    %edi,%edi
    1584:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    158b:	00 
    158c:	89 74 24 04          	mov    %esi,0x4(%esp)
    1590:	89 04 24             	mov    %eax,(%esp)
    1593:	e8 00 fe ff ff       	call   1398 <write>
    1598:	8b 45 0c             	mov    0xc(%ebp),%eax
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    159b:	0f b6 14 18          	movzbl (%eax,%ebx,1),%edx
    159f:	84 d2                	test   %dl,%dl
    15a1:	0f 85 6d ff ff ff    	jne    1514 <printf+0x44>
    15a7:	90                   	nop
        putc(fd, c);
      }
      state = 0;
    }
  }
}
    15a8:	83 c4 3c             	add    $0x3c,%esp
    15ab:	5b                   	pop    %ebx
    15ac:	5e                   	pop    %esi
    15ad:	5f                   	pop    %edi
    15ae:	5d                   	pop    %ebp
    15af:	c3                   	ret    
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    15b0:	8b 45 08             	mov    0x8(%ebp),%eax
  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
    15b3:	88 55 e7             	mov    %dl,-0x19(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    15b6:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    15bd:	00 
    15be:	89 74 24 04          	mov    %esi,0x4(%esp)
    15c2:	89 04 24             	mov    %eax,(%esp)
    15c5:	e8 ce fd ff ff       	call   1398 <write>
    15ca:	8b 45 0c             	mov    0xc(%ebp),%eax
    15cd:	e9 33 ff ff ff       	jmp    1505 <printf+0x35>
    15d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
    15d8:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    15db:	b9 10 00 00 00       	mov    $0x10,%ecx
        ap++;
    15e0:	31 ff                	xor    %edi,%edi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
    15e2:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    15e9:	8b 10                	mov    (%eax),%edx
    15eb:	8b 45 08             	mov    0x8(%ebp),%eax
    15ee:	e8 4d fe ff ff       	call   1440 <printint>
    15f3:	8b 45 0c             	mov    0xc(%ebp),%eax
        ap++;
    15f6:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
    15fa:	e9 06 ff ff ff       	jmp    1505 <printf+0x35>
    15ff:	90                   	nop
      } else if(c == 's'){
        s = (char*)*ap;
    1600:	8b 55 d4             	mov    -0x2c(%ebp),%edx
        ap++;
        if(s == 0)
    1603:	b9 6e 18 00 00       	mov    $0x186e,%ecx
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
        s = (char*)*ap;
    1608:	8b 3a                	mov    (%edx),%edi
        ap++;
    160a:	83 c2 04             	add    $0x4,%edx
    160d:	89 55 d4             	mov    %edx,-0x2c(%ebp)
        if(s == 0)
    1610:	85 ff                	test   %edi,%edi
    1612:	0f 44 f9             	cmove  %ecx,%edi
          s = "(null)";
        while(*s != 0){
    1615:	0f b6 17             	movzbl (%edi),%edx
    1618:	84 d2                	test   %dl,%dl
    161a:	74 33                	je     164f <printf+0x17f>
    161c:	89 5d d0             	mov    %ebx,-0x30(%ebp)
    161f:	8b 5d 08             	mov    0x8(%ebp),%ebx
    1622:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
          putc(fd, *s);
          s++;
    1628:	83 c7 01             	add    $0x1,%edi
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
    162b:	88 55 e7             	mov    %dl,-0x19(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    162e:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    1635:	00 
    1636:	89 74 24 04          	mov    %esi,0x4(%esp)
    163a:	89 1c 24             	mov    %ebx,(%esp)
    163d:	e8 56 fd ff ff       	call   1398 <write>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
    1642:	0f b6 17             	movzbl (%edi),%edx
    1645:	84 d2                	test   %dl,%dl
    1647:	75 df                	jne    1628 <printf+0x158>
    1649:	8b 5d d0             	mov    -0x30(%ebp),%ebx
    164c:	8b 45 0c             	mov    0xc(%ebp),%eax
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    164f:	31 ff                	xor    %edi,%edi
    1651:	e9 af fe ff ff       	jmp    1505 <printf+0x35>
    1656:	66 90                	xchg   %ax,%ax
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
    1658:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
    165c:	e9 1b ff ff ff       	jmp    157c <printf+0xac>
    1661:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
    1668:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    166b:	b9 0a 00 00 00       	mov    $0xa,%ecx
        ap++;
    1670:	66 31 ff             	xor    %di,%di
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
    1673:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    167a:	8b 10                	mov    (%eax),%edx
    167c:	8b 45 08             	mov    0x8(%ebp),%eax
    167f:	e8 bc fd ff ff       	call   1440 <printint>
    1684:	8b 45 0c             	mov    0xc(%ebp),%eax
        ap++;
    1687:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
    168b:	e9 75 fe ff ff       	jmp    1505 <printf+0x35>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    1690:	8b 55 d4             	mov    -0x2c(%ebp),%edx
        putc(fd, *ap);
        ap++;
    1693:	31 ff                	xor    %edi,%edi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    1695:	8b 4d 08             	mov    0x8(%ebp),%ecx
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    1698:	8b 02                	mov    (%edx),%eax
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    169a:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    16a1:	00 
    16a2:	89 74 24 04          	mov    %esi,0x4(%esp)
    16a6:	89 0c 24             	mov    %ecx,(%esp)
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    16a9:	88 45 e7             	mov    %al,-0x19(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    16ac:	e8 e7 fc ff ff       	call   1398 <write>
    16b1:	8b 45 0c             	mov    0xc(%ebp),%eax
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
        ap++;
    16b4:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
    16b8:	e9 48 fe ff ff       	jmp    1505 <printf+0x35>
    16bd:	90                   	nop
    16be:	90                   	nop
    16bf:	90                   	nop

000016c0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    16c0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    16c1:	a1 a8 18 00 00       	mov    0x18a8,%eax
static Header base;
static Header *freep;

void
free(void *ap)
{
    16c6:	89 e5                	mov    %esp,%ebp
    16c8:	57                   	push   %edi
    16c9:	56                   	push   %esi
    16ca:	53                   	push   %ebx
    16cb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
    16ce:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    16d1:	39 c8                	cmp    %ecx,%eax
    16d3:	73 1d                	jae    16f2 <free+0x32>
    16d5:	8d 76 00             	lea    0x0(%esi),%esi
    16d8:	8b 10                	mov    (%eax),%edx
    16da:	39 d1                	cmp    %edx,%ecx
    16dc:	72 1a                	jb     16f8 <free+0x38>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    16de:	39 d0                	cmp    %edx,%eax
    16e0:	72 08                	jb     16ea <free+0x2a>
    16e2:	39 c8                	cmp    %ecx,%eax
    16e4:	72 12                	jb     16f8 <free+0x38>
    16e6:	39 d1                	cmp    %edx,%ecx
    16e8:	72 0e                	jb     16f8 <free+0x38>
    16ea:	89 d0                	mov    %edx,%eax
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    16ec:	39 c8                	cmp    %ecx,%eax
    16ee:	66 90                	xchg   %ax,%ax
    16f0:	72 e6                	jb     16d8 <free+0x18>
    16f2:	8b 10                	mov    (%eax),%edx
    16f4:	eb e8                	jmp    16de <free+0x1e>
    16f6:	66 90                	xchg   %ax,%ax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    16f8:	8b 71 04             	mov    0x4(%ecx),%esi
    16fb:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    16fe:	39 d7                	cmp    %edx,%edi
    1700:	74 19                	je     171b <free+0x5b>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
    1702:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    1705:	8b 50 04             	mov    0x4(%eax),%edx
    1708:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    170b:	39 ce                	cmp    %ecx,%esi
    170d:	74 23                	je     1732 <free+0x72>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
    170f:	89 08                	mov    %ecx,(%eax)
  freep = p;
    1711:	a3 a8 18 00 00       	mov    %eax,0x18a8
}
    1716:	5b                   	pop    %ebx
    1717:	5e                   	pop    %esi
    1718:	5f                   	pop    %edi
    1719:	5d                   	pop    %ebp
    171a:	c3                   	ret    
  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
    171b:	03 72 04             	add    0x4(%edx),%esi
    171e:	89 71 04             	mov    %esi,0x4(%ecx)
    bp->s.ptr = p->s.ptr->s.ptr;
    1721:	8b 10                	mov    (%eax),%edx
    1723:	8b 12                	mov    (%edx),%edx
    1725:	89 53 f8             	mov    %edx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    1728:	8b 50 04             	mov    0x4(%eax),%edx
    172b:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    172e:	39 ce                	cmp    %ecx,%esi
    1730:	75 dd                	jne    170f <free+0x4f>
    p->s.size += bp->s.size;
    1732:	03 51 04             	add    0x4(%ecx),%edx
    1735:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    1738:	8b 53 f8             	mov    -0x8(%ebx),%edx
    173b:	89 10                	mov    %edx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
    173d:	a3 a8 18 00 00       	mov    %eax,0x18a8
}
    1742:	5b                   	pop    %ebx
    1743:	5e                   	pop    %esi
    1744:	5f                   	pop    %edi
    1745:	5d                   	pop    %ebp
    1746:	c3                   	ret    
    1747:	89 f6                	mov    %esi,%esi
    1749:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001750 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    1750:	55                   	push   %ebp
    1751:	89 e5                	mov    %esp,%ebp
    1753:	57                   	push   %edi
    1754:	56                   	push   %esi
    1755:	53                   	push   %ebx
    1756:	83 ec 2c             	sub    $0x2c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1759:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if((prevp = freep) == 0){
    175c:	8b 0d a8 18 00 00    	mov    0x18a8,%ecx
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1762:	83 c3 07             	add    $0x7,%ebx
    1765:	c1 eb 03             	shr    $0x3,%ebx
    1768:	83 c3 01             	add    $0x1,%ebx
  if((prevp = freep) == 0){
    176b:	85 c9                	test   %ecx,%ecx
    176d:	0f 84 9b 00 00 00    	je     180e <malloc+0xbe>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1773:	8b 01                	mov    (%ecx),%eax
    if(p->s.size >= nunits){
    1775:	8b 50 04             	mov    0x4(%eax),%edx
    1778:	39 d3                	cmp    %edx,%ebx
    177a:	76 27                	jbe    17a3 <malloc+0x53>
        p->s.size -= nunits;
        p += p->s.size;
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    177c:	8d 3c dd 00 00 00 00 	lea    0x0(,%ebx,8),%edi
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < 4096)
    1783:	be 00 80 00 00       	mov    $0x8000,%esi
    1788:	89 7d e4             	mov    %edi,-0x1c(%ebp)
    178b:	90                   	nop
    178c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    1790:	3b 05 a8 18 00 00    	cmp    0x18a8,%eax
    1796:	74 30                	je     17c8 <malloc+0x78>
    1798:	89 c1                	mov    %eax,%ecx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    179a:	8b 01                	mov    (%ecx),%eax
    if(p->s.size >= nunits){
    179c:	8b 50 04             	mov    0x4(%eax),%edx
    179f:	39 d3                	cmp    %edx,%ebx
    17a1:	77 ed                	ja     1790 <malloc+0x40>
      if(p->s.size == nunits)
    17a3:	39 d3                	cmp    %edx,%ebx
    17a5:	74 61                	je     1808 <malloc+0xb8>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
    17a7:	29 da                	sub    %ebx,%edx
    17a9:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
    17ac:	8d 04 d0             	lea    (%eax,%edx,8),%eax
        p->s.size = nunits;
    17af:	89 58 04             	mov    %ebx,0x4(%eax)
      }
      freep = prevp;
    17b2:	89 0d a8 18 00 00    	mov    %ecx,0x18a8
      return (void*)(p + 1);
    17b8:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
    17bb:	83 c4 2c             	add    $0x2c,%esp
    17be:	5b                   	pop    %ebx
    17bf:	5e                   	pop    %esi
    17c0:	5f                   	pop    %edi
    17c1:	5d                   	pop    %ebp
    17c2:	c3                   	ret    
    17c3:	90                   	nop
    17c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < 4096)
    17c8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    17cb:	81 fb 00 10 00 00    	cmp    $0x1000,%ebx
    17d1:	bf 00 10 00 00       	mov    $0x1000,%edi
    17d6:	0f 43 fb             	cmovae %ebx,%edi
    17d9:	0f 42 c6             	cmovb  %esi,%eax
    nu = 4096;
  p = sbrk(nu * sizeof(Header));
    17dc:	89 04 24             	mov    %eax,(%esp)
    17df:	e8 1c fc ff ff       	call   1400 <sbrk>
  if(p == (char*)-1)
    17e4:	83 f8 ff             	cmp    $0xffffffff,%eax
    17e7:	74 18                	je     1801 <malloc+0xb1>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
    17e9:	89 78 04             	mov    %edi,0x4(%eax)
  free((void*)(hp + 1));
    17ec:	83 c0 08             	add    $0x8,%eax
    17ef:	89 04 24             	mov    %eax,(%esp)
    17f2:	e8 c9 fe ff ff       	call   16c0 <free>
  return freep;
    17f7:	8b 0d a8 18 00 00    	mov    0x18a8,%ecx
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
    17fd:	85 c9                	test   %ecx,%ecx
    17ff:	75 99                	jne    179a <malloc+0x4a>
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
    1801:	31 c0                	xor    %eax,%eax
    1803:	eb b6                	jmp    17bb <malloc+0x6b>
    1805:	8d 76 00             	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
    1808:	8b 10                	mov    (%eax),%edx
    180a:	89 11                	mov    %edx,(%ecx)
    180c:	eb a4                	jmp    17b2 <malloc+0x62>
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    180e:	c7 05 a8 18 00 00 a0 	movl   $0x18a0,0x18a8
    1815:	18 00 00 
    base.s.size = 0;
    1818:	b9 a0 18 00 00       	mov    $0x18a0,%ecx
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    181d:	c7 05 a0 18 00 00 a0 	movl   $0x18a0,0x18a0
    1824:	18 00 00 
    base.s.size = 0;
    1827:	c7 05 a4 18 00 00 00 	movl   $0x0,0x18a4
    182e:	00 00 00 
    1831:	e9 3d ff ff ff       	jmp    1773 <malloc+0x23>
