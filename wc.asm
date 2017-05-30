
_wc:     file format elf32-i386


Disassembly of section .text:

00001000 <wc>:

char buf[512];

void
wc(int fd, char *name)
{
    1000:	55                   	push   %ebp
    1001:	89 e5                	mov    %esp,%ebp
    1003:	57                   	push   %edi
    1004:	31 ff                	xor    %edi,%edi
    1006:	56                   	push   %esi
    1007:	31 f6                	xor    %esi,%esi
    1009:	53                   	push   %ebx
    100a:	83 ec 3c             	sub    $0x3c,%esp
    100d:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
    1014:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    101b:	90                   	nop
    101c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  int i, n;
  int l, w, c, inword;

  l = w = c = 0;
  inword = 0;
  while((n = read(fd, buf, sizeof(buf))) > 0){
    1020:	8b 45 08             	mov    0x8(%ebp),%eax
    1023:	c7 44 24 08 00 02 00 	movl   $0x200,0x8(%esp)
    102a:	00 
    102b:	c7 44 24 04 20 19 00 	movl   $0x1920,0x4(%esp)
    1032:	00 
    1033:	89 04 24             	mov    %eax,(%esp)
    1036:	e8 b5 03 00 00       	call   13f0 <read>
    103b:	83 f8 00             	cmp    $0x0,%eax
    103e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    1041:	7e 4f                	jle    1092 <wc+0x92>
    1043:	31 db                	xor    %ebx,%ebx
    1045:	eb 0b                	jmp    1052 <wc+0x52>
    1047:	90                   	nop
    for(i=0; i<n; i++){
      c++;
      if(buf[i] == '\n')
        l++;
      if(strchr(" \r\t\n\v", buf[i]))
    1048:	31 ff                	xor    %edi,%edi
  int l, w, c, inword;

  l = w = c = 0;
  inword = 0;
  while((n = read(fd, buf, sizeof(buf))) > 0){
    for(i=0; i<n; i++){
    104a:	83 c3 01             	add    $0x1,%ebx
    104d:	39 5d e4             	cmp    %ebx,-0x1c(%ebp)
    1050:	7e 38                	jle    108a <wc+0x8a>
      c++;
      if(buf[i] == '\n')
    1052:	0f be 83 20 19 00 00 	movsbl 0x1920(%ebx),%eax
        l++;
    1059:	31 d2                	xor    %edx,%edx
      if(strchr(" \r\t\n\v", buf[i]))
    105b:	c7 04 24 96 18 00 00 	movl   $0x1896,(%esp)
  inword = 0;
  while((n = read(fd, buf, sizeof(buf))) > 0){
    for(i=0; i<n; i++){
      c++;
      if(buf[i] == '\n')
        l++;
    1062:	3c 0a                	cmp    $0xa,%al
    1064:	0f 94 c2             	sete   %dl
    1067:	01 d6                	add    %edx,%esi
      if(strchr(" \r\t\n\v", buf[i]))
    1069:	89 44 24 04          	mov    %eax,0x4(%esp)
    106d:	e8 fe 01 00 00       	call   1270 <strchr>
    1072:	85 c0                	test   %eax,%eax
    1074:	75 d2                	jne    1048 <wc+0x48>
        inword = 0;
      else if(!inword){
    1076:	85 ff                	test   %edi,%edi
    1078:	75 d0                	jne    104a <wc+0x4a>
        w++;
    107a:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
  int l, w, c, inword;

  l = w = c = 0;
  inword = 0;
  while((n = read(fd, buf, sizeof(buf))) > 0){
    for(i=0; i<n; i++){
    107e:	83 c3 01             	add    $0x1,%ebx
    1081:	39 5d e4             	cmp    %ebx,-0x1c(%ebp)
      if(buf[i] == '\n')
        l++;
      if(strchr(" \r\t\n\v", buf[i]))
        inword = 0;
      else if(!inword){
        w++;
    1084:	66 bf 01 00          	mov    $0x1,%di
  int l, w, c, inword;

  l = w = c = 0;
  inword = 0;
  while((n = read(fd, buf, sizeof(buf))) > 0){
    for(i=0; i<n; i++){
    1088:	7f c8                	jg     1052 <wc+0x52>
    108a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    108d:	01 45 dc             	add    %eax,-0x24(%ebp)
    1090:	eb 8e                	jmp    1020 <wc+0x20>
        w++;
        inword = 1;
      }
    }
  }
  if(n < 0){
    1092:	75 35                	jne    10c9 <wc+0xc9>
    printf(1, "wc: read error\n");
    exit(0);
  }
  printf(1, "%d %d %d %s\n", l, w, c, name);
    1094:	8b 45 0c             	mov    0xc(%ebp),%eax
    1097:	89 74 24 08          	mov    %esi,0x8(%esp)
    109b:	c7 44 24 04 ac 18 00 	movl   $0x18ac,0x4(%esp)
    10a2:	00 
    10a3:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    10aa:	89 44 24 14          	mov    %eax,0x14(%esp)
    10ae:	8b 45 dc             	mov    -0x24(%ebp),%eax
    10b1:	89 44 24 10          	mov    %eax,0x10(%esp)
    10b5:	8b 45 e0             	mov    -0x20(%ebp),%eax
    10b8:	89 44 24 0c          	mov    %eax,0xc(%esp)
    10bc:	e8 6f 04 00 00       	call   1530 <printf>
}
    10c1:	83 c4 3c             	add    $0x3c,%esp
    10c4:	5b                   	pop    %ebx
    10c5:	5e                   	pop    %esi
    10c6:	5f                   	pop    %edi
    10c7:	5d                   	pop    %ebp
    10c8:	c3                   	ret    
        inword = 1;
      }
    }
  }
  if(n < 0){
    printf(1, "wc: read error\n");
    10c9:	c7 44 24 04 9c 18 00 	movl   $0x189c,0x4(%esp)
    10d0:	00 
    10d1:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    10d8:	e8 53 04 00 00       	call   1530 <printf>
    exit(0);
    10dd:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    10e4:	e8 ef 02 00 00       	call   13d8 <exit>
    10e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000010f0 <main>:
  printf(1, "%d %d %d %s\n", l, w, c, name);
}

int
main(int argc, char *argv[])
{
    10f0:	55                   	push   %ebp
    10f1:	89 e5                	mov    %esp,%ebp
    10f3:	83 e4 f0             	and    $0xfffffff0,%esp
    10f6:	57                   	push   %edi
    10f7:	56                   	push   %esi
    10f8:	53                   	push   %ebx
    10f9:	83 ec 24             	sub    $0x24,%esp
    10fc:	8b 7d 08             	mov    0x8(%ebp),%edi
  int fd, i;

  if(argc <= 1){
    10ff:	83 ff 01             	cmp    $0x1,%edi
    1102:	0f 8e 88 00 00 00    	jle    1190 <main+0xa0>
    wc(0, "");
    exit(0);
    1108:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    110b:	be 01 00 00 00       	mov    $0x1,%esi
    1110:	83 c3 04             	add    $0x4,%ebx
    1113:	90                   	nop
    1114:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  }

  for(i = 1; i < argc; i++){
    if((fd = open(argv[i], 0)) < 0){
    1118:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    111f:	00 
    1120:	8b 03                	mov    (%ebx),%eax
    1122:	89 04 24             	mov    %eax,(%esp)
    1125:	e8 ee 02 00 00       	call   1418 <open>
    112a:	85 c0                	test   %eax,%eax
    112c:	78 3a                	js     1168 <main+0x78>
      printf(1, "wc: cannot open %s\n", argv[i]);
      exit(0);
    }
    wc(fd, argv[i]);
    112e:	8b 13                	mov    (%ebx),%edx
  if(argc <= 1){
    wc(0, "");
    exit(0);
  }

  for(i = 1; i < argc; i++){
    1130:	83 c6 01             	add    $0x1,%esi
    1133:	83 c3 04             	add    $0x4,%ebx
    if((fd = open(argv[i], 0)) < 0){
      printf(1, "wc: cannot open %s\n", argv[i]);
      exit(0);
    }
    wc(fd, argv[i]);
    1136:	89 04 24             	mov    %eax,(%esp)
    1139:	89 44 24 1c          	mov    %eax,0x1c(%esp)
    113d:	89 54 24 04          	mov    %edx,0x4(%esp)
    1141:	e8 ba fe ff ff       	call   1000 <wc>
    close(fd);
    1146:	8b 44 24 1c          	mov    0x1c(%esp),%eax
    114a:	89 04 24             	mov    %eax,(%esp)
    114d:	e8 ae 02 00 00       	call   1400 <close>
  if(argc <= 1){
    wc(0, "");
    exit(0);
  }

  for(i = 1; i < argc; i++){
    1152:	39 f7                	cmp    %esi,%edi
    1154:	7f c2                	jg     1118 <main+0x28>
      exit(0);
    }
    wc(fd, argv[i]);
    close(fd);
  }
  exit(0);
    1156:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    115d:	e8 76 02 00 00       	call   13d8 <exit>
    1162:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    exit(0);
  }

  for(i = 1; i < argc; i++){
    if((fd = open(argv[i], 0)) < 0){
      printf(1, "wc: cannot open %s\n", argv[i]);
    1168:	8b 03                	mov    (%ebx),%eax
    116a:	c7 44 24 04 b9 18 00 	movl   $0x18b9,0x4(%esp)
    1171:	00 
    1172:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1179:	89 44 24 08          	mov    %eax,0x8(%esp)
    117d:	e8 ae 03 00 00       	call   1530 <printf>
      exit(0);
    1182:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1189:	e8 4a 02 00 00       	call   13d8 <exit>
    118e:	66 90                	xchg   %ax,%ax
main(int argc, char *argv[])
{
  int fd, i;

  if(argc <= 1){
    wc(0, "");
    1190:	c7 44 24 04 ab 18 00 	movl   $0x18ab,0x4(%esp)
    1197:	00 
    1198:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    119f:	e8 5c fe ff ff       	call   1000 <wc>
    exit(0);
    11a4:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    11ab:	e8 28 02 00 00       	call   13d8 <exit>

000011b0 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
    11b0:	55                   	push   %ebp
    11b1:	31 d2                	xor    %edx,%edx
    11b3:	89 e5                	mov    %esp,%ebp
    11b5:	8b 45 08             	mov    0x8(%ebp),%eax
    11b8:	53                   	push   %ebx
    11b9:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    11bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
    11c0:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
    11c4:	88 0c 10             	mov    %cl,(%eax,%edx,1)
    11c7:	83 c2 01             	add    $0x1,%edx
    11ca:	84 c9                	test   %cl,%cl
    11cc:	75 f2                	jne    11c0 <strcpy+0x10>
    ;
  return os;
}
    11ce:	5b                   	pop    %ebx
    11cf:	5d                   	pop    %ebp
    11d0:	c3                   	ret    
    11d1:	eb 0d                	jmp    11e0 <strcmp>
    11d3:	90                   	nop
    11d4:	90                   	nop
    11d5:	90                   	nop
    11d6:	90                   	nop
    11d7:	90                   	nop
    11d8:	90                   	nop
    11d9:	90                   	nop
    11da:	90                   	nop
    11db:	90                   	nop
    11dc:	90                   	nop
    11dd:	90                   	nop
    11de:	90                   	nop
    11df:	90                   	nop

000011e0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    11e0:	55                   	push   %ebp
    11e1:	89 e5                	mov    %esp,%ebp
    11e3:	8b 4d 08             	mov    0x8(%ebp),%ecx
    11e6:	53                   	push   %ebx
    11e7:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(*p && *p == *q)
    11ea:	0f b6 01             	movzbl (%ecx),%eax
    11ed:	84 c0                	test   %al,%al
    11ef:	75 14                	jne    1205 <strcmp+0x25>
    11f1:	eb 25                	jmp    1218 <strcmp+0x38>
    11f3:	90                   	nop
    11f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    p++, q++;
    11f8:	83 c1 01             	add    $0x1,%ecx
    11fb:	83 c2 01             	add    $0x1,%edx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
    11fe:	0f b6 01             	movzbl (%ecx),%eax
    1201:	84 c0                	test   %al,%al
    1203:	74 13                	je     1218 <strcmp+0x38>
    1205:	0f b6 1a             	movzbl (%edx),%ebx
    1208:	38 d8                	cmp    %bl,%al
    120a:	74 ec                	je     11f8 <strcmp+0x18>
    120c:	0f b6 db             	movzbl %bl,%ebx
    120f:	0f b6 c0             	movzbl %al,%eax
    1212:	29 d8                	sub    %ebx,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
    1214:	5b                   	pop    %ebx
    1215:	5d                   	pop    %ebp
    1216:	c3                   	ret    
    1217:	90                   	nop
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
    1218:	0f b6 1a             	movzbl (%edx),%ebx
    121b:	31 c0                	xor    %eax,%eax
    121d:	0f b6 db             	movzbl %bl,%ebx
    1220:	29 d8                	sub    %ebx,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
    1222:	5b                   	pop    %ebx
    1223:	5d                   	pop    %ebp
    1224:	c3                   	ret    
    1225:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1229:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001230 <strlen>:

uint
strlen(char *s)
{
    1230:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
    1231:	31 d2                	xor    %edx,%edx
  return (uchar)*p - (uchar)*q;
}

uint
strlen(char *s)
{
    1233:	89 e5                	mov    %esp,%ebp
  int n;

  for(n = 0; s[n]; n++)
    1235:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
}

uint
strlen(char *s)
{
    1237:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
    123a:	80 39 00             	cmpb   $0x0,(%ecx)
    123d:	74 0c                	je     124b <strlen+0x1b>
    123f:	90                   	nop
    1240:	83 c2 01             	add    $0x1,%edx
    1243:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
    1247:	89 d0                	mov    %edx,%eax
    1249:	75 f5                	jne    1240 <strlen+0x10>
    ;
  return n;
}
    124b:	5d                   	pop    %ebp
    124c:	c3                   	ret    
    124d:	8d 76 00             	lea    0x0(%esi),%esi

00001250 <memset>:

void*
memset(void *dst, int c, uint n)
{
    1250:	55                   	push   %ebp
    1251:	89 e5                	mov    %esp,%ebp
    1253:	8b 55 08             	mov    0x8(%ebp),%edx
    1256:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
    1257:	8b 4d 10             	mov    0x10(%ebp),%ecx
    125a:	8b 45 0c             	mov    0xc(%ebp),%eax
    125d:	89 d7                	mov    %edx,%edi
    125f:	fc                   	cld    
    1260:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
    1262:	89 d0                	mov    %edx,%eax
    1264:	5f                   	pop    %edi
    1265:	5d                   	pop    %ebp
    1266:	c3                   	ret    
    1267:	89 f6                	mov    %esi,%esi
    1269:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001270 <strchr>:

char*
strchr(const char *s, char c)
{
    1270:	55                   	push   %ebp
    1271:	89 e5                	mov    %esp,%ebp
    1273:	8b 45 08             	mov    0x8(%ebp),%eax
    1276:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
    127a:	0f b6 10             	movzbl (%eax),%edx
    127d:	84 d2                	test   %dl,%dl
    127f:	75 11                	jne    1292 <strchr+0x22>
    1281:	eb 15                	jmp    1298 <strchr+0x28>
    1283:	90                   	nop
    1284:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1288:	83 c0 01             	add    $0x1,%eax
    128b:	0f b6 10             	movzbl (%eax),%edx
    128e:	84 d2                	test   %dl,%dl
    1290:	74 06                	je     1298 <strchr+0x28>
    if(*s == c)
    1292:	38 ca                	cmp    %cl,%dl
    1294:	75 f2                	jne    1288 <strchr+0x18>
      return (char*)s;
  return 0;
}
    1296:	5d                   	pop    %ebp
    1297:	c3                   	ret    
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
    1298:	31 c0                	xor    %eax,%eax
    if(*s == c)
      return (char*)s;
  return 0;
}
    129a:	5d                   	pop    %ebp
    129b:	90                   	nop
    129c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    12a0:	c3                   	ret    
    12a1:	eb 0d                	jmp    12b0 <atoi>
    12a3:	90                   	nop
    12a4:	90                   	nop
    12a5:	90                   	nop
    12a6:	90                   	nop
    12a7:	90                   	nop
    12a8:	90                   	nop
    12a9:	90                   	nop
    12aa:	90                   	nop
    12ab:	90                   	nop
    12ac:	90                   	nop
    12ad:	90                   	nop
    12ae:	90                   	nop
    12af:	90                   	nop

000012b0 <atoi>:
  return r;
}

int
atoi(const char *s)
{
    12b0:	55                   	push   %ebp
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    12b1:	31 c0                	xor    %eax,%eax
  return r;
}

int
atoi(const char *s)
{
    12b3:	89 e5                	mov    %esp,%ebp
    12b5:	8b 4d 08             	mov    0x8(%ebp),%ecx
    12b8:	53                   	push   %ebx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    12b9:	0f b6 11             	movzbl (%ecx),%edx
    12bc:	8d 5a d0             	lea    -0x30(%edx),%ebx
    12bf:	80 fb 09             	cmp    $0x9,%bl
    12c2:	77 1c                	ja     12e0 <atoi+0x30>
    12c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    n = n*10 + *s++ - '0';
    12c8:	0f be d2             	movsbl %dl,%edx
    12cb:	83 c1 01             	add    $0x1,%ecx
    12ce:	8d 04 80             	lea    (%eax,%eax,4),%eax
    12d1:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    12d5:	0f b6 11             	movzbl (%ecx),%edx
    12d8:	8d 5a d0             	lea    -0x30(%edx),%ebx
    12db:	80 fb 09             	cmp    $0x9,%bl
    12de:	76 e8                	jbe    12c8 <atoi+0x18>
    n = n*10 + *s++ - '0';
  return n;
}
    12e0:	5b                   	pop    %ebx
    12e1:	5d                   	pop    %ebp
    12e2:	c3                   	ret    
    12e3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    12e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000012f0 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
    12f0:	55                   	push   %ebp
    12f1:	89 e5                	mov    %esp,%ebp
    12f3:	56                   	push   %esi
    12f4:	8b 45 08             	mov    0x8(%ebp),%eax
    12f7:	53                   	push   %ebx
    12f8:	8b 5d 10             	mov    0x10(%ebp),%ebx
    12fb:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    12fe:	85 db                	test   %ebx,%ebx
    1300:	7e 14                	jle    1316 <memmove+0x26>
    n = n*10 + *s++ - '0';
  return n;
}

void*
memmove(void *vdst, void *vsrc, int n)
    1302:	31 d2                	xor    %edx,%edx
    1304:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    *dst++ = *src++;
    1308:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
    130c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
    130f:	83 c2 01             	add    $0x1,%edx
{
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    1312:	39 da                	cmp    %ebx,%edx
    1314:	75 f2                	jne    1308 <memmove+0x18>
    *dst++ = *src++;
  return vdst;
}
    1316:	5b                   	pop    %ebx
    1317:	5e                   	pop    %esi
    1318:	5d                   	pop    %ebp
    1319:	c3                   	ret    
    131a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00001320 <stat>:
  return buf;
}

int
stat(char *n, struct stat *st)
{
    1320:	55                   	push   %ebp
    1321:	89 e5                	mov    %esp,%ebp
    1323:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    1326:	8b 45 08             	mov    0x8(%ebp),%eax
  return buf;
}

int
stat(char *n, struct stat *st)
{
    1329:	89 5d f8             	mov    %ebx,-0x8(%ebp)
    132c:	89 75 fc             	mov    %esi,-0x4(%ebp)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    132f:	be ff ff ff ff       	mov    $0xffffffff,%esi
stat(char *n, struct stat *st)
{
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    1334:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    133b:	00 
    133c:	89 04 24             	mov    %eax,(%esp)
    133f:	e8 d4 00 00 00       	call   1418 <open>
  if(fd < 0)
    1344:	85 c0                	test   %eax,%eax
stat(char *n, struct stat *st)
{
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    1346:	89 c3                	mov    %eax,%ebx
  if(fd < 0)
    1348:	78 19                	js     1363 <stat+0x43>
    return -1;
  r = fstat(fd, st);
    134a:	8b 45 0c             	mov    0xc(%ebp),%eax
    134d:	89 1c 24             	mov    %ebx,(%esp)
    1350:	89 44 24 04          	mov    %eax,0x4(%esp)
    1354:	e8 d7 00 00 00       	call   1430 <fstat>
  close(fd);
    1359:	89 1c 24             	mov    %ebx,(%esp)
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
  r = fstat(fd, st);
    135c:	89 c6                	mov    %eax,%esi
  close(fd);
    135e:	e8 9d 00 00 00       	call   1400 <close>
  return r;
}
    1363:	89 f0                	mov    %esi,%eax
    1365:	8b 5d f8             	mov    -0x8(%ebp),%ebx
    1368:	8b 75 fc             	mov    -0x4(%ebp),%esi
    136b:	89 ec                	mov    %ebp,%esp
    136d:	5d                   	pop    %ebp
    136e:	c3                   	ret    
    136f:	90                   	nop

00001370 <gets>:
  return 0;
}

char*
gets(char *buf, int max)
{
    1370:	55                   	push   %ebp
    1371:	89 e5                	mov    %esp,%ebp
    1373:	57                   	push   %edi
    1374:	56                   	push   %esi
    1375:	31 f6                	xor    %esi,%esi
    1377:	53                   	push   %ebx
    1378:	83 ec 2c             	sub    $0x2c,%esp
    137b:	8b 7d 08             	mov    0x8(%ebp),%edi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    137e:	eb 06                	jmp    1386 <gets+0x16>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
    1380:	3c 0a                	cmp    $0xa,%al
    1382:	74 39                	je     13bd <gets+0x4d>
    1384:	89 de                	mov    %ebx,%esi
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    1386:	8d 5e 01             	lea    0x1(%esi),%ebx
    1389:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
    138c:	7d 31                	jge    13bf <gets+0x4f>
    cc = read(0, &c, 1);
    138e:	8d 45 e7             	lea    -0x19(%ebp),%eax
    1391:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    1398:	00 
    1399:	89 44 24 04          	mov    %eax,0x4(%esp)
    139d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    13a4:	e8 47 00 00 00       	call   13f0 <read>
    if(cc < 1)
    13a9:	85 c0                	test   %eax,%eax
    13ab:	7e 12                	jle    13bf <gets+0x4f>
      break;
    buf[i++] = c;
    13ad:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
    13b1:	88 44 1f ff          	mov    %al,-0x1(%edi,%ebx,1)
    if(c == '\n' || c == '\r')
    13b5:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
    13b9:	3c 0d                	cmp    $0xd,%al
    13bb:	75 c3                	jne    1380 <gets+0x10>
    13bd:	89 de                	mov    %ebx,%esi
      break;
  }
  buf[i] = '\0';
    13bf:	c6 04 37 00          	movb   $0x0,(%edi,%esi,1)
  return buf;
}
    13c3:	89 f8                	mov    %edi,%eax
    13c5:	83 c4 2c             	add    $0x2c,%esp
    13c8:	5b                   	pop    %ebx
    13c9:	5e                   	pop    %esi
    13ca:	5f                   	pop    %edi
    13cb:	5d                   	pop    %ebp
    13cc:	c3                   	ret    
    13cd:	90                   	nop
    13ce:	90                   	nop
    13cf:	90                   	nop

000013d0 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    13d0:	b8 01 00 00 00       	mov    $0x1,%eax
    13d5:	cd 40                	int    $0x40
    13d7:	c3                   	ret    

000013d8 <exit>:
SYSCALL(exit)
    13d8:	b8 02 00 00 00       	mov    $0x2,%eax
    13dd:	cd 40                	int    $0x40
    13df:	c3                   	ret    

000013e0 <wait>:
SYSCALL(wait)
    13e0:	b8 03 00 00 00       	mov    $0x3,%eax
    13e5:	cd 40                	int    $0x40
    13e7:	c3                   	ret    

000013e8 <pipe>:
SYSCALL(pipe)
    13e8:	b8 04 00 00 00       	mov    $0x4,%eax
    13ed:	cd 40                	int    $0x40
    13ef:	c3                   	ret    

000013f0 <read>:
SYSCALL(read)
    13f0:	b8 05 00 00 00       	mov    $0x5,%eax
    13f5:	cd 40                	int    $0x40
    13f7:	c3                   	ret    

000013f8 <write>:
SYSCALL(write)
    13f8:	b8 10 00 00 00       	mov    $0x10,%eax
    13fd:	cd 40                	int    $0x40
    13ff:	c3                   	ret    

00001400 <close>:
SYSCALL(close)
    1400:	b8 15 00 00 00       	mov    $0x15,%eax
    1405:	cd 40                	int    $0x40
    1407:	c3                   	ret    

00001408 <kill>:
SYSCALL(kill)
    1408:	b8 06 00 00 00       	mov    $0x6,%eax
    140d:	cd 40                	int    $0x40
    140f:	c3                   	ret    

00001410 <exec>:
SYSCALL(exec)
    1410:	b8 07 00 00 00       	mov    $0x7,%eax
    1415:	cd 40                	int    $0x40
    1417:	c3                   	ret    

00001418 <open>:
SYSCALL(open)
    1418:	b8 0f 00 00 00       	mov    $0xf,%eax
    141d:	cd 40                	int    $0x40
    141f:	c3                   	ret    

00001420 <mknod>:
SYSCALL(mknod)
    1420:	b8 11 00 00 00       	mov    $0x11,%eax
    1425:	cd 40                	int    $0x40
    1427:	c3                   	ret    

00001428 <unlink>:
SYSCALL(unlink)
    1428:	b8 12 00 00 00       	mov    $0x12,%eax
    142d:	cd 40                	int    $0x40
    142f:	c3                   	ret    

00001430 <fstat>:
SYSCALL(fstat)
    1430:	b8 08 00 00 00       	mov    $0x8,%eax
    1435:	cd 40                	int    $0x40
    1437:	c3                   	ret    

00001438 <link>:
SYSCALL(link)
    1438:	b8 13 00 00 00       	mov    $0x13,%eax
    143d:	cd 40                	int    $0x40
    143f:	c3                   	ret    

00001440 <mkdir>:
SYSCALL(mkdir)
    1440:	b8 14 00 00 00       	mov    $0x14,%eax
    1445:	cd 40                	int    $0x40
    1447:	c3                   	ret    

00001448 <chdir>:
SYSCALL(chdir)
    1448:	b8 09 00 00 00       	mov    $0x9,%eax
    144d:	cd 40                	int    $0x40
    144f:	c3                   	ret    

00001450 <dup>:
SYSCALL(dup)
    1450:	b8 0a 00 00 00       	mov    $0xa,%eax
    1455:	cd 40                	int    $0x40
    1457:	c3                   	ret    

00001458 <getpid>:
SYSCALL(getpid)
    1458:	b8 0b 00 00 00       	mov    $0xb,%eax
    145d:	cd 40                	int    $0x40
    145f:	c3                   	ret    

00001460 <sbrk>:
SYSCALL(sbrk)
    1460:	b8 0c 00 00 00       	mov    $0xc,%eax
    1465:	cd 40                	int    $0x40
    1467:	c3                   	ret    

00001468 <sleep>:
SYSCALL(sleep)
    1468:	b8 0d 00 00 00       	mov    $0xd,%eax
    146d:	cd 40                	int    $0x40
    146f:	c3                   	ret    

00001470 <uptime>:
SYSCALL(uptime)
    1470:	b8 0e 00 00 00       	mov    $0xe,%eax
    1475:	cd 40                	int    $0x40
    1477:	c3                   	ret    

00001478 <hello>:
SYSCALL(hello) 			// added for Lab0
    1478:	b8 16 00 00 00       	mov    $0x16,%eax
    147d:	cd 40                	int    $0x40
    147f:	c3                   	ret    

00001480 <waitpid>:
SYSCALL(waitpid) 		// lab1 part 1: c
    1480:	b8 17 00 00 00       	mov    $0x17,%eax
    1485:	cd 40                	int    $0x40
    1487:	c3                   	ret    

00001488 <setpriority>:
SYSCALL(setpriority) 	// lab1 part 2: define syscall
    1488:	b8 18 00 00 00       	mov    $0x18,%eax
    148d:	cd 40                	int    $0x40
    148f:	c3                   	ret    

00001490 <v2p>:
SYSCALL(v2p)			// lab2
    1490:	b8 19 00 00 00       	mov    $0x19,%eax
    1495:	cd 40                	int    $0x40
    1497:	c3                   	ret    
    1498:	90                   	nop
    1499:	90                   	nop
    149a:	90                   	nop
    149b:	90                   	nop
    149c:	90                   	nop
    149d:	90                   	nop
    149e:	90                   	nop
    149f:	90                   	nop

000014a0 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
    14a0:	55                   	push   %ebp
    14a1:	89 e5                	mov    %esp,%ebp
    14a3:	57                   	push   %edi
    14a4:	89 cf                	mov    %ecx,%edi
    14a6:	56                   	push   %esi
    14a7:	89 c6                	mov    %eax,%esi
    14a9:	53                   	push   %ebx
    14aa:	83 ec 4c             	sub    $0x4c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    14ad:	8b 4d 08             	mov    0x8(%ebp),%ecx
    14b0:	85 c9                	test   %ecx,%ecx
    14b2:	74 04                	je     14b8 <printint+0x18>
    14b4:	85 d2                	test   %edx,%edx
    14b6:	78 68                	js     1520 <printint+0x80>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
    14b8:	89 d0                	mov    %edx,%eax
    14ba:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
    14c1:	31 c9                	xor    %ecx,%ecx
    14c3:	8d 5d d7             	lea    -0x29(%ebp),%ebx
    14c6:	66 90                	xchg   %ax,%ax
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
    14c8:	31 d2                	xor    %edx,%edx
    14ca:	f7 f7                	div    %edi
    14cc:	0f b6 92 d4 18 00 00 	movzbl 0x18d4(%edx),%edx
    14d3:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
    14d6:	83 c1 01             	add    $0x1,%ecx
  }while((x /= base) != 0);
    14d9:	85 c0                	test   %eax,%eax
    14db:	75 eb                	jne    14c8 <printint+0x28>
  if(neg)
    14dd:	8b 45 c4             	mov    -0x3c(%ebp),%eax
    14e0:	85 c0                	test   %eax,%eax
    14e2:	74 08                	je     14ec <printint+0x4c>
    buf[i++] = '-';
    14e4:	c6 44 0d d7 2d       	movb   $0x2d,-0x29(%ebp,%ecx,1)
    14e9:	83 c1 01             	add    $0x1,%ecx

  while(--i >= 0)
    14ec:	8d 79 ff             	lea    -0x1(%ecx),%edi
    14ef:	90                   	nop
    14f0:	0f b6 04 3b          	movzbl (%ebx,%edi,1),%eax
    14f4:	83 ef 01             	sub    $0x1,%edi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    14f7:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    14fe:	00 
    14ff:	89 34 24             	mov    %esi,(%esp)
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
    1502:	88 45 e7             	mov    %al,-0x19(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    1505:	8d 45 e7             	lea    -0x19(%ebp),%eax
    1508:	89 44 24 04          	mov    %eax,0x4(%esp)
    150c:	e8 e7 fe ff ff       	call   13f8 <write>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
    1511:	83 ff ff             	cmp    $0xffffffff,%edi
    1514:	75 da                	jne    14f0 <printint+0x50>
    putc(fd, buf[i]);
}
    1516:	83 c4 4c             	add    $0x4c,%esp
    1519:	5b                   	pop    %ebx
    151a:	5e                   	pop    %esi
    151b:	5f                   	pop    %edi
    151c:	5d                   	pop    %ebp
    151d:	c3                   	ret    
    151e:	66 90                	xchg   %ax,%ax
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
    1520:	89 d0                	mov    %edx,%eax
    1522:	f7 d8                	neg    %eax
    1524:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
    152b:	eb 94                	jmp    14c1 <printint+0x21>
    152d:	8d 76 00             	lea    0x0(%esi),%esi

00001530 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
    1530:	55                   	push   %ebp
    1531:	89 e5                	mov    %esp,%ebp
    1533:	57                   	push   %edi
    1534:	56                   	push   %esi
    1535:	53                   	push   %ebx
    1536:	83 ec 3c             	sub    $0x3c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    1539:	8b 45 0c             	mov    0xc(%ebp),%eax
    153c:	0f b6 10             	movzbl (%eax),%edx
    153f:	84 d2                	test   %dl,%dl
    1541:	0f 84 c1 00 00 00    	je     1608 <printf+0xd8>
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
    1547:	8d 4d 10             	lea    0x10(%ebp),%ecx
    154a:	31 ff                	xor    %edi,%edi
    154c:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
    154f:	31 db                	xor    %ebx,%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    1551:	8d 75 e7             	lea    -0x19(%ebp),%esi
    1554:	eb 1e                	jmp    1574 <printf+0x44>
    1556:	66 90                	xchg   %ax,%ax
  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
    1558:	83 fa 25             	cmp    $0x25,%edx
    155b:	0f 85 af 00 00 00    	jne    1610 <printf+0xe0>
    1561:	66 bf 25 00          	mov    $0x25,%di
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    1565:	83 c3 01             	add    $0x1,%ebx
    1568:	0f b6 14 18          	movzbl (%eax,%ebx,1),%edx
    156c:	84 d2                	test   %dl,%dl
    156e:	0f 84 94 00 00 00    	je     1608 <printf+0xd8>
    c = fmt[i] & 0xff;
    if(state == 0){
    1574:	85 ff                	test   %edi,%edi
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    1576:	0f b6 d2             	movzbl %dl,%edx
    if(state == 0){
    1579:	74 dd                	je     1558 <printf+0x28>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
    157b:	83 ff 25             	cmp    $0x25,%edi
    157e:	75 e5                	jne    1565 <printf+0x35>
      if(c == 'd'){
    1580:	83 fa 64             	cmp    $0x64,%edx
    1583:	0f 84 3f 01 00 00    	je     16c8 <printf+0x198>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
    1589:	83 fa 70             	cmp    $0x70,%edx
    158c:	0f 84 a6 00 00 00    	je     1638 <printf+0x108>
    1592:	83 fa 78             	cmp    $0x78,%edx
    1595:	0f 84 9d 00 00 00    	je     1638 <printf+0x108>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
    159b:	83 fa 73             	cmp    $0x73,%edx
    159e:	66 90                	xchg   %ax,%ax
    15a0:	0f 84 ba 00 00 00    	je     1660 <printf+0x130>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    15a6:	83 fa 63             	cmp    $0x63,%edx
    15a9:	0f 84 41 01 00 00    	je     16f0 <printf+0x1c0>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
    15af:	83 fa 25             	cmp    $0x25,%edx
    15b2:	0f 84 00 01 00 00    	je     16b8 <printf+0x188>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    15b8:	8b 4d 08             	mov    0x8(%ebp),%ecx
    15bb:	89 55 cc             	mov    %edx,-0x34(%ebp)
    15be:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
    15c2:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    15c9:	00 
    15ca:	89 74 24 04          	mov    %esi,0x4(%esp)
    15ce:	89 0c 24             	mov    %ecx,(%esp)
    15d1:	e8 22 fe ff ff       	call   13f8 <write>
    15d6:	8b 55 cc             	mov    -0x34(%ebp),%edx
    15d9:	88 55 e7             	mov    %dl,-0x19(%ebp)
    15dc:	8b 45 08             	mov    0x8(%ebp),%eax
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    15df:	83 c3 01             	add    $0x1,%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    15e2:	31 ff                	xor    %edi,%edi
    15e4:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    15eb:	00 
    15ec:	89 74 24 04          	mov    %esi,0x4(%esp)
    15f0:	89 04 24             	mov    %eax,(%esp)
    15f3:	e8 00 fe ff ff       	call   13f8 <write>
    15f8:	8b 45 0c             	mov    0xc(%ebp),%eax
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    15fb:	0f b6 14 18          	movzbl (%eax,%ebx,1),%edx
    15ff:	84 d2                	test   %dl,%dl
    1601:	0f 85 6d ff ff ff    	jne    1574 <printf+0x44>
    1607:	90                   	nop
        putc(fd, c);
      }
      state = 0;
    }
  }
}
    1608:	83 c4 3c             	add    $0x3c,%esp
    160b:	5b                   	pop    %ebx
    160c:	5e                   	pop    %esi
    160d:	5f                   	pop    %edi
    160e:	5d                   	pop    %ebp
    160f:	c3                   	ret    
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    1610:	8b 45 08             	mov    0x8(%ebp),%eax
  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
    1613:	88 55 e7             	mov    %dl,-0x19(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    1616:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    161d:	00 
    161e:	89 74 24 04          	mov    %esi,0x4(%esp)
    1622:	89 04 24             	mov    %eax,(%esp)
    1625:	e8 ce fd ff ff       	call   13f8 <write>
    162a:	8b 45 0c             	mov    0xc(%ebp),%eax
    162d:	e9 33 ff ff ff       	jmp    1565 <printf+0x35>
    1632:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
    1638:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    163b:	b9 10 00 00 00       	mov    $0x10,%ecx
        ap++;
    1640:	31 ff                	xor    %edi,%edi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
    1642:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1649:	8b 10                	mov    (%eax),%edx
    164b:	8b 45 08             	mov    0x8(%ebp),%eax
    164e:	e8 4d fe ff ff       	call   14a0 <printint>
    1653:	8b 45 0c             	mov    0xc(%ebp),%eax
        ap++;
    1656:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
    165a:	e9 06 ff ff ff       	jmp    1565 <printf+0x35>
    165f:	90                   	nop
      } else if(c == 's'){
        s = (char*)*ap;
    1660:	8b 55 d4             	mov    -0x2c(%ebp),%edx
        ap++;
        if(s == 0)
    1663:	b9 cd 18 00 00       	mov    $0x18cd,%ecx
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
        s = (char*)*ap;
    1668:	8b 3a                	mov    (%edx),%edi
        ap++;
    166a:	83 c2 04             	add    $0x4,%edx
    166d:	89 55 d4             	mov    %edx,-0x2c(%ebp)
        if(s == 0)
    1670:	85 ff                	test   %edi,%edi
    1672:	0f 44 f9             	cmove  %ecx,%edi
          s = "(null)";
        while(*s != 0){
    1675:	0f b6 17             	movzbl (%edi),%edx
    1678:	84 d2                	test   %dl,%dl
    167a:	74 33                	je     16af <printf+0x17f>
    167c:	89 5d d0             	mov    %ebx,-0x30(%ebp)
    167f:	8b 5d 08             	mov    0x8(%ebp),%ebx
    1682:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
          putc(fd, *s);
          s++;
    1688:	83 c7 01             	add    $0x1,%edi
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
    168b:	88 55 e7             	mov    %dl,-0x19(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    168e:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    1695:	00 
    1696:	89 74 24 04          	mov    %esi,0x4(%esp)
    169a:	89 1c 24             	mov    %ebx,(%esp)
    169d:	e8 56 fd ff ff       	call   13f8 <write>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
    16a2:	0f b6 17             	movzbl (%edi),%edx
    16a5:	84 d2                	test   %dl,%dl
    16a7:	75 df                	jne    1688 <printf+0x158>
    16a9:	8b 5d d0             	mov    -0x30(%ebp),%ebx
    16ac:	8b 45 0c             	mov    0xc(%ebp),%eax
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    16af:	31 ff                	xor    %edi,%edi
    16b1:	e9 af fe ff ff       	jmp    1565 <printf+0x35>
    16b6:	66 90                	xchg   %ax,%ax
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
    16b8:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
    16bc:	e9 1b ff ff ff       	jmp    15dc <printf+0xac>
    16c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
    16c8:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    16cb:	b9 0a 00 00 00       	mov    $0xa,%ecx
        ap++;
    16d0:	66 31 ff             	xor    %di,%di
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
    16d3:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    16da:	8b 10                	mov    (%eax),%edx
    16dc:	8b 45 08             	mov    0x8(%ebp),%eax
    16df:	e8 bc fd ff ff       	call   14a0 <printint>
    16e4:	8b 45 0c             	mov    0xc(%ebp),%eax
        ap++;
    16e7:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
    16eb:	e9 75 fe ff ff       	jmp    1565 <printf+0x35>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    16f0:	8b 55 d4             	mov    -0x2c(%ebp),%edx
        putc(fd, *ap);
        ap++;
    16f3:	31 ff                	xor    %edi,%edi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    16f5:	8b 4d 08             	mov    0x8(%ebp),%ecx
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    16f8:	8b 02                	mov    (%edx),%eax
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    16fa:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    1701:	00 
    1702:	89 74 24 04          	mov    %esi,0x4(%esp)
    1706:	89 0c 24             	mov    %ecx,(%esp)
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    1709:	88 45 e7             	mov    %al,-0x19(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    170c:	e8 e7 fc ff ff       	call   13f8 <write>
    1711:	8b 45 0c             	mov    0xc(%ebp),%eax
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
        ap++;
    1714:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
    1718:	e9 48 fe ff ff       	jmp    1565 <printf+0x35>
    171d:	90                   	nop
    171e:	90                   	nop
    171f:	90                   	nop

00001720 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    1720:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1721:	a1 08 19 00 00       	mov    0x1908,%eax
static Header base;
static Header *freep;

void
free(void *ap)
{
    1726:	89 e5                	mov    %esp,%ebp
    1728:	57                   	push   %edi
    1729:	56                   	push   %esi
    172a:	53                   	push   %ebx
    172b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
    172e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1731:	39 c8                	cmp    %ecx,%eax
    1733:	73 1d                	jae    1752 <free+0x32>
    1735:	8d 76 00             	lea    0x0(%esi),%esi
    1738:	8b 10                	mov    (%eax),%edx
    173a:	39 d1                	cmp    %edx,%ecx
    173c:	72 1a                	jb     1758 <free+0x38>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    173e:	39 d0                	cmp    %edx,%eax
    1740:	72 08                	jb     174a <free+0x2a>
    1742:	39 c8                	cmp    %ecx,%eax
    1744:	72 12                	jb     1758 <free+0x38>
    1746:	39 d1                	cmp    %edx,%ecx
    1748:	72 0e                	jb     1758 <free+0x38>
    174a:	89 d0                	mov    %edx,%eax
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    174c:	39 c8                	cmp    %ecx,%eax
    174e:	66 90                	xchg   %ax,%ax
    1750:	72 e6                	jb     1738 <free+0x18>
    1752:	8b 10                	mov    (%eax),%edx
    1754:	eb e8                	jmp    173e <free+0x1e>
    1756:	66 90                	xchg   %ax,%ax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    1758:	8b 71 04             	mov    0x4(%ecx),%esi
    175b:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    175e:	39 d7                	cmp    %edx,%edi
    1760:	74 19                	je     177b <free+0x5b>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
    1762:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    1765:	8b 50 04             	mov    0x4(%eax),%edx
    1768:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    176b:	39 ce                	cmp    %ecx,%esi
    176d:	74 23                	je     1792 <free+0x72>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
    176f:	89 08                	mov    %ecx,(%eax)
  freep = p;
    1771:	a3 08 19 00 00       	mov    %eax,0x1908
}
    1776:	5b                   	pop    %ebx
    1777:	5e                   	pop    %esi
    1778:	5f                   	pop    %edi
    1779:	5d                   	pop    %ebp
    177a:	c3                   	ret    
  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
    177b:	03 72 04             	add    0x4(%edx),%esi
    177e:	89 71 04             	mov    %esi,0x4(%ecx)
    bp->s.ptr = p->s.ptr->s.ptr;
    1781:	8b 10                	mov    (%eax),%edx
    1783:	8b 12                	mov    (%edx),%edx
    1785:	89 53 f8             	mov    %edx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    1788:	8b 50 04             	mov    0x4(%eax),%edx
    178b:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    178e:	39 ce                	cmp    %ecx,%esi
    1790:	75 dd                	jne    176f <free+0x4f>
    p->s.size += bp->s.size;
    1792:	03 51 04             	add    0x4(%ecx),%edx
    1795:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    1798:	8b 53 f8             	mov    -0x8(%ebx),%edx
    179b:	89 10                	mov    %edx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
    179d:	a3 08 19 00 00       	mov    %eax,0x1908
}
    17a2:	5b                   	pop    %ebx
    17a3:	5e                   	pop    %esi
    17a4:	5f                   	pop    %edi
    17a5:	5d                   	pop    %ebp
    17a6:	c3                   	ret    
    17a7:	89 f6                	mov    %esi,%esi
    17a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000017b0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    17b0:	55                   	push   %ebp
    17b1:	89 e5                	mov    %esp,%ebp
    17b3:	57                   	push   %edi
    17b4:	56                   	push   %esi
    17b5:	53                   	push   %ebx
    17b6:	83 ec 2c             	sub    $0x2c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    17b9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if((prevp = freep) == 0){
    17bc:	8b 0d 08 19 00 00    	mov    0x1908,%ecx
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    17c2:	83 c3 07             	add    $0x7,%ebx
    17c5:	c1 eb 03             	shr    $0x3,%ebx
    17c8:	83 c3 01             	add    $0x1,%ebx
  if((prevp = freep) == 0){
    17cb:	85 c9                	test   %ecx,%ecx
    17cd:	0f 84 9b 00 00 00    	je     186e <malloc+0xbe>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    17d3:	8b 01                	mov    (%ecx),%eax
    if(p->s.size >= nunits){
    17d5:	8b 50 04             	mov    0x4(%eax),%edx
    17d8:	39 d3                	cmp    %edx,%ebx
    17da:	76 27                	jbe    1803 <malloc+0x53>
        p->s.size -= nunits;
        p += p->s.size;
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    17dc:	8d 3c dd 00 00 00 00 	lea    0x0(,%ebx,8),%edi
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < 4096)
    17e3:	be 00 80 00 00       	mov    $0x8000,%esi
    17e8:	89 7d e4             	mov    %edi,-0x1c(%ebp)
    17eb:	90                   	nop
    17ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    17f0:	3b 05 08 19 00 00    	cmp    0x1908,%eax
    17f6:	74 30                	je     1828 <malloc+0x78>
    17f8:	89 c1                	mov    %eax,%ecx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    17fa:	8b 01                	mov    (%ecx),%eax
    if(p->s.size >= nunits){
    17fc:	8b 50 04             	mov    0x4(%eax),%edx
    17ff:	39 d3                	cmp    %edx,%ebx
    1801:	77 ed                	ja     17f0 <malloc+0x40>
      if(p->s.size == nunits)
    1803:	39 d3                	cmp    %edx,%ebx
    1805:	74 61                	je     1868 <malloc+0xb8>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
    1807:	29 da                	sub    %ebx,%edx
    1809:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
    180c:	8d 04 d0             	lea    (%eax,%edx,8),%eax
        p->s.size = nunits;
    180f:	89 58 04             	mov    %ebx,0x4(%eax)
      }
      freep = prevp;
    1812:	89 0d 08 19 00 00    	mov    %ecx,0x1908
      return (void*)(p + 1);
    1818:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
    181b:	83 c4 2c             	add    $0x2c,%esp
    181e:	5b                   	pop    %ebx
    181f:	5e                   	pop    %esi
    1820:	5f                   	pop    %edi
    1821:	5d                   	pop    %ebp
    1822:	c3                   	ret    
    1823:	90                   	nop
    1824:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < 4096)
    1828:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    182b:	81 fb 00 10 00 00    	cmp    $0x1000,%ebx
    1831:	bf 00 10 00 00       	mov    $0x1000,%edi
    1836:	0f 43 fb             	cmovae %ebx,%edi
    1839:	0f 42 c6             	cmovb  %esi,%eax
    nu = 4096;
  p = sbrk(nu * sizeof(Header));
    183c:	89 04 24             	mov    %eax,(%esp)
    183f:	e8 1c fc ff ff       	call   1460 <sbrk>
  if(p == (char*)-1)
    1844:	83 f8 ff             	cmp    $0xffffffff,%eax
    1847:	74 18                	je     1861 <malloc+0xb1>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
    1849:	89 78 04             	mov    %edi,0x4(%eax)
  free((void*)(hp + 1));
    184c:	83 c0 08             	add    $0x8,%eax
    184f:	89 04 24             	mov    %eax,(%esp)
    1852:	e8 c9 fe ff ff       	call   1720 <free>
  return freep;
    1857:	8b 0d 08 19 00 00    	mov    0x1908,%ecx
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
    185d:	85 c9                	test   %ecx,%ecx
    185f:	75 99                	jne    17fa <malloc+0x4a>
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
    1861:	31 c0                	xor    %eax,%eax
    1863:	eb b6                	jmp    181b <malloc+0x6b>
    1865:	8d 76 00             	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
    1868:	8b 10                	mov    (%eax),%edx
    186a:	89 11                	mov    %edx,(%ecx)
    186c:	eb a4                	jmp    1812 <malloc+0x62>
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    186e:	c7 05 08 19 00 00 00 	movl   $0x1900,0x1908
    1875:	19 00 00 
    base.s.size = 0;
    1878:	b9 00 19 00 00       	mov    $0x1900,%ecx
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    187d:	c7 05 00 19 00 00 00 	movl   $0x1900,0x1900
    1884:	19 00 00 
    base.s.size = 0;
    1887:	c7 05 04 19 00 00 00 	movl   $0x0,0x1904
    188e:	00 00 00 
    1891:	e9 3d ff ff ff       	jmp    17d3 <malloc+0x23>
