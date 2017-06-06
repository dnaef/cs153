
_ls:     file format elf32-i386


Disassembly of section .text:

00001000 <fmtname>:
#include "user.h"
#include "fs.h"

char*
fmtname(char *path)
{
    1000:	55                   	push   %ebp
    1001:	89 e5                	mov    %esp,%ebp
    1003:	56                   	push   %esi
    1004:	53                   	push   %ebx
    1005:	83 ec 10             	sub    $0x10,%esp
    1008:	8b 5d 08             	mov    0x8(%ebp),%ebx
  static char buf[DIRSIZ+1];
  char *p;

  // Find first character after last slash.
  for(p=path+strlen(path); p >= path && *p != '/'; p--)
    100b:	89 1c 24             	mov    %ebx,(%esp)
    100e:	e8 dd 03 00 00       	call   13f0 <strlen>
    1013:	01 d8                	add    %ebx,%eax
    1015:	73 10                	jae    1027 <fmtname+0x27>
    1017:	eb 13                	jmp    102c <fmtname+0x2c>
    1019:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    1020:	83 e8 01             	sub    $0x1,%eax
    1023:	39 c3                	cmp    %eax,%ebx
    1025:	77 05                	ja     102c <fmtname+0x2c>
    1027:	80 38 2f             	cmpb   $0x2f,(%eax)
    102a:	75 f4                	jne    1020 <fmtname+0x20>
    ;
  p++;
    102c:	8d 58 01             	lea    0x1(%eax),%ebx

  // Return blank-padded name.
  if(strlen(p) >= DIRSIZ)
    102f:	89 1c 24             	mov    %ebx,(%esp)
    1032:	e8 b9 03 00 00       	call   13f0 <strlen>
    1037:	83 f8 0d             	cmp    $0xd,%eax
    103a:	77 53                	ja     108f <fmtname+0x8f>
    return p;
  memmove(buf, p, strlen(p));
    103c:	89 1c 24             	mov    %ebx,(%esp)
    103f:	e8 ac 03 00 00       	call   13f0 <strlen>
    1044:	89 5c 24 04          	mov    %ebx,0x4(%esp)
    1048:	c7 04 24 b8 1a 00 00 	movl   $0x1ab8,(%esp)
    104f:	89 44 24 08          	mov    %eax,0x8(%esp)
    1053:	e8 58 04 00 00       	call   14b0 <memmove>
  memset(buf+strlen(p), ' ', DIRSIZ-strlen(p));
    1058:	89 1c 24             	mov    %ebx,(%esp)
    105b:	e8 90 03 00 00       	call   13f0 <strlen>
    1060:	89 1c 24             	mov    %ebx,(%esp)
    1063:	bb b8 1a 00 00       	mov    $0x1ab8,%ebx
    1068:	89 c6                	mov    %eax,%esi
    106a:	e8 81 03 00 00       	call   13f0 <strlen>
    106f:	ba 0e 00 00 00       	mov    $0xe,%edx
    1074:	29 f2                	sub    %esi,%edx
    1076:	89 54 24 08          	mov    %edx,0x8(%esp)
    107a:	c7 44 24 04 20 00 00 	movl   $0x20,0x4(%esp)
    1081:	00 
    1082:	05 b8 1a 00 00       	add    $0x1ab8,%eax
    1087:	89 04 24             	mov    %eax,(%esp)
    108a:	e8 81 03 00 00       	call   1410 <memset>
  return buf;
}
    108f:	83 c4 10             	add    $0x10,%esp
    1092:	89 d8                	mov    %ebx,%eax
    1094:	5b                   	pop    %ebx
    1095:	5e                   	pop    %esi
    1096:	5d                   	pop    %ebp
    1097:	c3                   	ret    
    1098:	90                   	nop
    1099:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000010a0 <ls>:

void
ls(char *path)
{
    10a0:	55                   	push   %ebp
    10a1:	89 e5                	mov    %esp,%ebp
    10a3:	57                   	push   %edi
    10a4:	56                   	push   %esi
    10a5:	53                   	push   %ebx
    10a6:	81 ec 6c 02 00 00    	sub    $0x26c,%esp
    10ac:	8b 7d 08             	mov    0x8(%ebp),%edi
  char buf[512], *p;
  int fd;
  struct dirent de;
  struct stat st;

  if((fd = open(path, 0)) < 0){
    10af:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    10b6:	00 
    10b7:	89 3c 24             	mov    %edi,(%esp)
    10ba:	e8 19 05 00 00       	call   15d8 <open>
    10bf:	85 c0                	test   %eax,%eax
    10c1:	89 c3                	mov    %eax,%ebx
    10c3:	0f 88 c7 01 00 00    	js     1290 <ls+0x1f0>
    printf(2, "ls: cannot open %s\n", path);
    return;
  }

  if(fstat(fd, &st) < 0){
    10c9:	8d 75 c4             	lea    -0x3c(%ebp),%esi
    10cc:	89 74 24 04          	mov    %esi,0x4(%esp)
    10d0:	89 04 24             	mov    %eax,(%esp)
    10d3:	e8 18 05 00 00       	call   15f0 <fstat>
    10d8:	85 c0                	test   %eax,%eax
    10da:	0f 88 00 02 00 00    	js     12e0 <ls+0x240>
    printf(2, "ls: cannot stat %s\n", path);
    close(fd);
    return;
  }

  switch(st.type){
    10e0:	0f b7 45 c4          	movzwl -0x3c(%ebp),%eax
    10e4:	66 83 f8 01          	cmp    $0x1,%ax
    10e8:	74 66                	je     1150 <ls+0xb0>
    10ea:	66 83 f8 02          	cmp    $0x2,%ax
    10ee:	74 18                	je     1108 <ls+0x68>
      }
      printf(1, "%s %d %d %d\n", fmtname(buf), st.type, st.ino, st.size);
    }
    break;
  }
  close(fd);
    10f0:	89 1c 24             	mov    %ebx,(%esp)
    10f3:	e8 c8 04 00 00       	call   15c0 <close>
}
    10f8:	81 c4 6c 02 00 00    	add    $0x26c,%esp
    10fe:	5b                   	pop    %ebx
    10ff:	5e                   	pop    %esi
    1100:	5f                   	pop    %edi
    1101:	5d                   	pop    %ebp
    1102:	c3                   	ret    
    1103:	90                   	nop
    1104:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return;
  }

  switch(st.type){
  case T_FILE:
    printf(1, "%s %d %d %d\n", fmtname(path), st.type, st.ino, st.size);
    1108:	8b 55 d4             	mov    -0x2c(%ebp),%edx
    110b:	8b 75 cc             	mov    -0x34(%ebp),%esi
    110e:	89 3c 24             	mov    %edi,(%esp)
    1111:	89 95 ac fd ff ff    	mov    %edx,-0x254(%ebp)
    1117:	e8 e4 fe ff ff       	call   1000 <fmtname>
    111c:	8b 95 ac fd ff ff    	mov    -0x254(%ebp),%edx
    1122:	89 74 24 10          	mov    %esi,0x10(%esp)
    1126:	c7 44 24 0c 02 00 00 	movl   $0x2,0xc(%esp)
    112d:	00 
    112e:	c7 44 24 04 7e 1a 00 	movl   $0x1a7e,0x4(%esp)
    1135:	00 
    1136:	89 54 24 14          	mov    %edx,0x14(%esp)
    113a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1141:	89 44 24 08          	mov    %eax,0x8(%esp)
    1145:	e8 a6 05 00 00       	call   16f0 <printf>
    break;
    114a:	eb a4                	jmp    10f0 <ls+0x50>
    114c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  case T_DIR:
    if(strlen(path) + 1 + DIRSIZ + 1 > sizeof buf){
    1150:	89 3c 24             	mov    %edi,(%esp)
    1153:	e8 98 02 00 00       	call   13f0 <strlen>
    1158:	83 c0 10             	add    $0x10,%eax
    115b:	3d 00 02 00 00       	cmp    $0x200,%eax
    1160:	0f 87 0a 01 00 00    	ja     1270 <ls+0x1d0>
      printf(1, "ls: path too long\n");
      break;
    }
    strcpy(buf, path);
    1166:	8d 85 c4 fd ff ff    	lea    -0x23c(%ebp),%eax
    116c:	89 7c 24 04          	mov    %edi,0x4(%esp)
    1170:	8d 7d d8             	lea    -0x28(%ebp),%edi
    1173:	89 04 24             	mov    %eax,(%esp)
    1176:	e8 f5 01 00 00       	call   1370 <strcpy>
    p = buf+strlen(buf);
    117b:	8d 95 c4 fd ff ff    	lea    -0x23c(%ebp),%edx
    1181:	89 14 24             	mov    %edx,(%esp)
    1184:	e8 67 02 00 00       	call   13f0 <strlen>
    1189:	8d 95 c4 fd ff ff    	lea    -0x23c(%ebp),%edx
    118f:	8d 04 02             	lea    (%edx,%eax,1),%eax
    *p++ = '/';
    1192:	c6 00 2f             	movb   $0x2f,(%eax)
    1195:	83 c0 01             	add    $0x1,%eax
    1198:	89 85 b4 fd ff ff    	mov    %eax,-0x24c(%ebp)
    119e:	66 90                	xchg   %ax,%ax
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
    11a0:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
    11a7:	00 
    11a8:	89 7c 24 04          	mov    %edi,0x4(%esp)
    11ac:	89 1c 24             	mov    %ebx,(%esp)
    11af:	e8 fc 03 00 00       	call   15b0 <read>
    11b4:	83 f8 10             	cmp    $0x10,%eax
    11b7:	0f 85 33 ff ff ff    	jne    10f0 <ls+0x50>
      if(de.inum == 0)
    11bd:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
    11c2:	74 dc                	je     11a0 <ls+0x100>
        continue;
      memmove(p, de.name, DIRSIZ);
    11c4:	8b 95 b4 fd ff ff    	mov    -0x24c(%ebp),%edx
    11ca:	8d 45 da             	lea    -0x26(%ebp),%eax
    11cd:	c7 44 24 08 0e 00 00 	movl   $0xe,0x8(%esp)
    11d4:	00 
    11d5:	89 44 24 04          	mov    %eax,0x4(%esp)
    11d9:	89 14 24             	mov    %edx,(%esp)
    11dc:	e8 cf 02 00 00       	call   14b0 <memmove>
      p[DIRSIZ] = 0;
    11e1:	8b 85 b4 fd ff ff    	mov    -0x24c(%ebp),%eax
      if(stat(buf, &st) < 0){
    11e7:	8d 95 c4 fd ff ff    	lea    -0x23c(%ebp),%edx
    *p++ = '/';
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
      if(de.inum == 0)
        continue;
      memmove(p, de.name, DIRSIZ);
      p[DIRSIZ] = 0;
    11ed:	c6 40 0e 00          	movb   $0x0,0xe(%eax)
      if(stat(buf, &st) < 0){
    11f1:	89 74 24 04          	mov    %esi,0x4(%esp)
    11f5:	89 14 24             	mov    %edx,(%esp)
    11f8:	e8 e3 02 00 00       	call   14e0 <stat>
    11fd:	85 c0                	test   %eax,%eax
    11ff:	0f 88 b3 00 00 00    	js     12b8 <ls+0x218>
        printf(1, "ls: cannot stat %s\n", buf);
        continue;
      }
      printf(1, "%s %d %d %d\n", fmtname(buf), st.type, st.ino, st.size);
    1205:	0f bf 45 c4          	movswl -0x3c(%ebp),%eax
    1209:	8b 55 d4             	mov    -0x2c(%ebp),%edx
    120c:	8b 4d cc             	mov    -0x34(%ebp),%ecx
    120f:	89 85 b0 fd ff ff    	mov    %eax,-0x250(%ebp)
    1215:	8d 85 c4 fd ff ff    	lea    -0x23c(%ebp),%eax
    121b:	89 95 ac fd ff ff    	mov    %edx,-0x254(%ebp)
    1221:	89 8d a8 fd ff ff    	mov    %ecx,-0x258(%ebp)
    1227:	89 04 24             	mov    %eax,(%esp)
    122a:	e8 d1 fd ff ff       	call   1000 <fmtname>
    122f:	8b 95 ac fd ff ff    	mov    -0x254(%ebp),%edx
    1235:	8b 8d a8 fd ff ff    	mov    -0x258(%ebp),%ecx
    123b:	c7 44 24 04 7e 1a 00 	movl   $0x1a7e,0x4(%esp)
    1242:	00 
    1243:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    124a:	89 54 24 14          	mov    %edx,0x14(%esp)
    124e:	8b 95 b0 fd ff ff    	mov    -0x250(%ebp),%edx
    1254:	89 4c 24 10          	mov    %ecx,0x10(%esp)
    1258:	89 44 24 08          	mov    %eax,0x8(%esp)
    125c:	89 54 24 0c          	mov    %edx,0xc(%esp)
    1260:	e8 8b 04 00 00       	call   16f0 <printf>
    1265:	e9 36 ff ff ff       	jmp    11a0 <ls+0x100>
    126a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    printf(1, "%s %d %d %d\n", fmtname(path), st.type, st.ino, st.size);
    break;

  case T_DIR:
    if(strlen(path) + 1 + DIRSIZ + 1 > sizeof buf){
      printf(1, "ls: path too long\n");
    1270:	c7 44 24 04 8b 1a 00 	movl   $0x1a8b,0x4(%esp)
    1277:	00 
    1278:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    127f:	e8 6c 04 00 00       	call   16f0 <printf>
      break;
    1284:	e9 67 fe ff ff       	jmp    10f0 <ls+0x50>
    1289:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  int fd;
  struct dirent de;
  struct stat st;

  if((fd = open(path, 0)) < 0){
    printf(2, "ls: cannot open %s\n", path);
    1290:	89 7c 24 08          	mov    %edi,0x8(%esp)
    1294:	c7 44 24 04 56 1a 00 	movl   $0x1a56,0x4(%esp)
    129b:	00 
    129c:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
    12a3:	e8 48 04 00 00       	call   16f0 <printf>
      printf(1, "%s %d %d %d\n", fmtname(buf), st.type, st.ino, st.size);
    }
    break;
  }
  close(fd);
}
    12a8:	81 c4 6c 02 00 00    	add    $0x26c,%esp
    12ae:	5b                   	pop    %ebx
    12af:	5e                   	pop    %esi
    12b0:	5f                   	pop    %edi
    12b1:	5d                   	pop    %ebp
    12b2:	c3                   	ret    
    12b3:	90                   	nop
    12b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      if(de.inum == 0)
        continue;
      memmove(p, de.name, DIRSIZ);
      p[DIRSIZ] = 0;
      if(stat(buf, &st) < 0){
        printf(1, "ls: cannot stat %s\n", buf);
    12b8:	8d 85 c4 fd ff ff    	lea    -0x23c(%ebp),%eax
    12be:	89 44 24 08          	mov    %eax,0x8(%esp)
    12c2:	c7 44 24 04 6a 1a 00 	movl   $0x1a6a,0x4(%esp)
    12c9:	00 
    12ca:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    12d1:	e8 1a 04 00 00       	call   16f0 <printf>
        continue;
    12d6:	e9 c5 fe ff ff       	jmp    11a0 <ls+0x100>
    12db:	90                   	nop
    12dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    printf(2, "ls: cannot open %s\n", path);
    return;
  }

  if(fstat(fd, &st) < 0){
    printf(2, "ls: cannot stat %s\n", path);
    12e0:	89 7c 24 08          	mov    %edi,0x8(%esp)
    12e4:	c7 44 24 04 6a 1a 00 	movl   $0x1a6a,0x4(%esp)
    12eb:	00 
    12ec:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
    12f3:	e8 f8 03 00 00       	call   16f0 <printf>
    close(fd);
    12f8:	89 1c 24             	mov    %ebx,(%esp)
    12fb:	e8 c0 02 00 00       	call   15c0 <close>
    return;
    1300:	e9 f3 fd ff ff       	jmp    10f8 <ls+0x58>
    1305:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1309:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001310 <main>:
  close(fd);
}

int
main(int argc, char *argv[])
{
    1310:	55                   	push   %ebp
    1311:	89 e5                	mov    %esp,%ebp
    1313:	83 e4 f0             	and    $0xfffffff0,%esp
    1316:	57                   	push   %edi
    1317:	56                   	push   %esi
    1318:	53                   	push   %ebx
  int i;

  if(argc < 2){
    ls(".");
    exit(0);
    1319:	bb 01 00 00 00       	mov    $0x1,%ebx
  close(fd);
}

int
main(int argc, char *argv[])
{
    131e:	83 ec 14             	sub    $0x14,%esp
    1321:	8b 75 08             	mov    0x8(%ebp),%esi
    1324:	8b 7d 0c             	mov    0xc(%ebp),%edi
  int i;

  if(argc < 2){
    1327:	83 fe 01             	cmp    $0x1,%esi
    132a:	7e 24                	jle    1350 <main+0x40>
    132c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    ls(".");
    exit(0);
  }
  for(i=1; i<argc; i++)
    ls(argv[i]);
    1330:	8b 04 9f             	mov    (%edi,%ebx,4),%eax

  if(argc < 2){
    ls(".");
    exit(0);
  }
  for(i=1; i<argc; i++)
    1333:	83 c3 01             	add    $0x1,%ebx
    ls(argv[i]);
    1336:	89 04 24             	mov    %eax,(%esp)
    1339:	e8 62 fd ff ff       	call   10a0 <ls>

  if(argc < 2){
    ls(".");
    exit(0);
  }
  for(i=1; i<argc; i++)
    133e:	39 de                	cmp    %ebx,%esi
    1340:	7f ee                	jg     1330 <main+0x20>
    ls(argv[i]);
  exit(0);
    1342:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1349:	e8 4a 02 00 00       	call   1598 <exit>
    134e:	66 90                	xchg   %ax,%ax
main(int argc, char *argv[])
{
  int i;

  if(argc < 2){
    ls(".");
    1350:	c7 04 24 9e 1a 00 00 	movl   $0x1a9e,(%esp)
    1357:	e8 44 fd ff ff       	call   10a0 <ls>
    exit(0);
    135c:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1363:	e8 30 02 00 00       	call   1598 <exit>
    1368:	90                   	nop
    1369:	90                   	nop
    136a:	90                   	nop
    136b:	90                   	nop
    136c:	90                   	nop
    136d:	90                   	nop
    136e:	90                   	nop
    136f:	90                   	nop

00001370 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
    1370:	55                   	push   %ebp
    1371:	31 d2                	xor    %edx,%edx
    1373:	89 e5                	mov    %esp,%ebp
    1375:	8b 45 08             	mov    0x8(%ebp),%eax
    1378:	53                   	push   %ebx
    1379:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    137c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
    1380:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
    1384:	88 0c 10             	mov    %cl,(%eax,%edx,1)
    1387:	83 c2 01             	add    $0x1,%edx
    138a:	84 c9                	test   %cl,%cl
    138c:	75 f2                	jne    1380 <strcpy+0x10>
    ;
  return os;
}
    138e:	5b                   	pop    %ebx
    138f:	5d                   	pop    %ebp
    1390:	c3                   	ret    
    1391:	eb 0d                	jmp    13a0 <strcmp>
    1393:	90                   	nop
    1394:	90                   	nop
    1395:	90                   	nop
    1396:	90                   	nop
    1397:	90                   	nop
    1398:	90                   	nop
    1399:	90                   	nop
    139a:	90                   	nop
    139b:	90                   	nop
    139c:	90                   	nop
    139d:	90                   	nop
    139e:	90                   	nop
    139f:	90                   	nop

000013a0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    13a0:	55                   	push   %ebp
    13a1:	89 e5                	mov    %esp,%ebp
    13a3:	8b 4d 08             	mov    0x8(%ebp),%ecx
    13a6:	53                   	push   %ebx
    13a7:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(*p && *p == *q)
    13aa:	0f b6 01             	movzbl (%ecx),%eax
    13ad:	84 c0                	test   %al,%al
    13af:	75 14                	jne    13c5 <strcmp+0x25>
    13b1:	eb 25                	jmp    13d8 <strcmp+0x38>
    13b3:	90                   	nop
    13b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    p++, q++;
    13b8:	83 c1 01             	add    $0x1,%ecx
    13bb:	83 c2 01             	add    $0x1,%edx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
    13be:	0f b6 01             	movzbl (%ecx),%eax
    13c1:	84 c0                	test   %al,%al
    13c3:	74 13                	je     13d8 <strcmp+0x38>
    13c5:	0f b6 1a             	movzbl (%edx),%ebx
    13c8:	38 d8                	cmp    %bl,%al
    13ca:	74 ec                	je     13b8 <strcmp+0x18>
    13cc:	0f b6 db             	movzbl %bl,%ebx
    13cf:	0f b6 c0             	movzbl %al,%eax
    13d2:	29 d8                	sub    %ebx,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
    13d4:	5b                   	pop    %ebx
    13d5:	5d                   	pop    %ebp
    13d6:	c3                   	ret    
    13d7:	90                   	nop
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
    13d8:	0f b6 1a             	movzbl (%edx),%ebx
    13db:	31 c0                	xor    %eax,%eax
    13dd:	0f b6 db             	movzbl %bl,%ebx
    13e0:	29 d8                	sub    %ebx,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
    13e2:	5b                   	pop    %ebx
    13e3:	5d                   	pop    %ebp
    13e4:	c3                   	ret    
    13e5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    13e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000013f0 <strlen>:

uint
strlen(char *s)
{
    13f0:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
    13f1:	31 d2                	xor    %edx,%edx
  return (uchar)*p - (uchar)*q;
}

uint
strlen(char *s)
{
    13f3:	89 e5                	mov    %esp,%ebp
  int n;

  for(n = 0; s[n]; n++)
    13f5:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
}

uint
strlen(char *s)
{
    13f7:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
    13fa:	80 39 00             	cmpb   $0x0,(%ecx)
    13fd:	74 0c                	je     140b <strlen+0x1b>
    13ff:	90                   	nop
    1400:	83 c2 01             	add    $0x1,%edx
    1403:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
    1407:	89 d0                	mov    %edx,%eax
    1409:	75 f5                	jne    1400 <strlen+0x10>
    ;
  return n;
}
    140b:	5d                   	pop    %ebp
    140c:	c3                   	ret    
    140d:	8d 76 00             	lea    0x0(%esi),%esi

00001410 <memset>:

void*
memset(void *dst, int c, uint n)
{
    1410:	55                   	push   %ebp
    1411:	89 e5                	mov    %esp,%ebp
    1413:	8b 55 08             	mov    0x8(%ebp),%edx
    1416:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
    1417:	8b 4d 10             	mov    0x10(%ebp),%ecx
    141a:	8b 45 0c             	mov    0xc(%ebp),%eax
    141d:	89 d7                	mov    %edx,%edi
    141f:	fc                   	cld    
    1420:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
    1422:	89 d0                	mov    %edx,%eax
    1424:	5f                   	pop    %edi
    1425:	5d                   	pop    %ebp
    1426:	c3                   	ret    
    1427:	89 f6                	mov    %esi,%esi
    1429:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001430 <strchr>:

char*
strchr(const char *s, char c)
{
    1430:	55                   	push   %ebp
    1431:	89 e5                	mov    %esp,%ebp
    1433:	8b 45 08             	mov    0x8(%ebp),%eax
    1436:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
    143a:	0f b6 10             	movzbl (%eax),%edx
    143d:	84 d2                	test   %dl,%dl
    143f:	75 11                	jne    1452 <strchr+0x22>
    1441:	eb 15                	jmp    1458 <strchr+0x28>
    1443:	90                   	nop
    1444:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1448:	83 c0 01             	add    $0x1,%eax
    144b:	0f b6 10             	movzbl (%eax),%edx
    144e:	84 d2                	test   %dl,%dl
    1450:	74 06                	je     1458 <strchr+0x28>
    if(*s == c)
    1452:	38 ca                	cmp    %cl,%dl
    1454:	75 f2                	jne    1448 <strchr+0x18>
      return (char*)s;
  return 0;
}
    1456:	5d                   	pop    %ebp
    1457:	c3                   	ret    
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
    1458:	31 c0                	xor    %eax,%eax
    if(*s == c)
      return (char*)s;
  return 0;
}
    145a:	5d                   	pop    %ebp
    145b:	90                   	nop
    145c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1460:	c3                   	ret    
    1461:	eb 0d                	jmp    1470 <atoi>
    1463:	90                   	nop
    1464:	90                   	nop
    1465:	90                   	nop
    1466:	90                   	nop
    1467:	90                   	nop
    1468:	90                   	nop
    1469:	90                   	nop
    146a:	90                   	nop
    146b:	90                   	nop
    146c:	90                   	nop
    146d:	90                   	nop
    146e:	90                   	nop
    146f:	90                   	nop

00001470 <atoi>:
  return r;
}

int
atoi(const char *s)
{
    1470:	55                   	push   %ebp
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    1471:	31 c0                	xor    %eax,%eax
  return r;
}

int
atoi(const char *s)
{
    1473:	89 e5                	mov    %esp,%ebp
    1475:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1478:	53                   	push   %ebx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    1479:	0f b6 11             	movzbl (%ecx),%edx
    147c:	8d 5a d0             	lea    -0x30(%edx),%ebx
    147f:	80 fb 09             	cmp    $0x9,%bl
    1482:	77 1c                	ja     14a0 <atoi+0x30>
    1484:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    n = n*10 + *s++ - '0';
    1488:	0f be d2             	movsbl %dl,%edx
    148b:	83 c1 01             	add    $0x1,%ecx
    148e:	8d 04 80             	lea    (%eax,%eax,4),%eax
    1491:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    1495:	0f b6 11             	movzbl (%ecx),%edx
    1498:	8d 5a d0             	lea    -0x30(%edx),%ebx
    149b:	80 fb 09             	cmp    $0x9,%bl
    149e:	76 e8                	jbe    1488 <atoi+0x18>
    n = n*10 + *s++ - '0';
  return n;
}
    14a0:	5b                   	pop    %ebx
    14a1:	5d                   	pop    %ebp
    14a2:	c3                   	ret    
    14a3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    14a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000014b0 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
    14b0:	55                   	push   %ebp
    14b1:	89 e5                	mov    %esp,%ebp
    14b3:	56                   	push   %esi
    14b4:	8b 45 08             	mov    0x8(%ebp),%eax
    14b7:	53                   	push   %ebx
    14b8:	8b 5d 10             	mov    0x10(%ebp),%ebx
    14bb:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    14be:	85 db                	test   %ebx,%ebx
    14c0:	7e 14                	jle    14d6 <memmove+0x26>
    n = n*10 + *s++ - '0';
  return n;
}

void*
memmove(void *vdst, void *vsrc, int n)
    14c2:	31 d2                	xor    %edx,%edx
    14c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    *dst++ = *src++;
    14c8:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
    14cc:	88 0c 10             	mov    %cl,(%eax,%edx,1)
    14cf:	83 c2 01             	add    $0x1,%edx
{
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    14d2:	39 da                	cmp    %ebx,%edx
    14d4:	75 f2                	jne    14c8 <memmove+0x18>
    *dst++ = *src++;
  return vdst;
}
    14d6:	5b                   	pop    %ebx
    14d7:	5e                   	pop    %esi
    14d8:	5d                   	pop    %ebp
    14d9:	c3                   	ret    
    14da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000014e0 <stat>:
  return buf;
}

int
stat(char *n, struct stat *st)
{
    14e0:	55                   	push   %ebp
    14e1:	89 e5                	mov    %esp,%ebp
    14e3:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    14e6:	8b 45 08             	mov    0x8(%ebp),%eax
  return buf;
}

int
stat(char *n, struct stat *st)
{
    14e9:	89 5d f8             	mov    %ebx,-0x8(%ebp)
    14ec:	89 75 fc             	mov    %esi,-0x4(%ebp)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    14ef:	be ff ff ff ff       	mov    $0xffffffff,%esi
stat(char *n, struct stat *st)
{
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    14f4:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    14fb:	00 
    14fc:	89 04 24             	mov    %eax,(%esp)
    14ff:	e8 d4 00 00 00       	call   15d8 <open>
  if(fd < 0)
    1504:	85 c0                	test   %eax,%eax
stat(char *n, struct stat *st)
{
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    1506:	89 c3                	mov    %eax,%ebx
  if(fd < 0)
    1508:	78 19                	js     1523 <stat+0x43>
    return -1;
  r = fstat(fd, st);
    150a:	8b 45 0c             	mov    0xc(%ebp),%eax
    150d:	89 1c 24             	mov    %ebx,(%esp)
    1510:	89 44 24 04          	mov    %eax,0x4(%esp)
    1514:	e8 d7 00 00 00       	call   15f0 <fstat>
  close(fd);
    1519:	89 1c 24             	mov    %ebx,(%esp)
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
  r = fstat(fd, st);
    151c:	89 c6                	mov    %eax,%esi
  close(fd);
    151e:	e8 9d 00 00 00       	call   15c0 <close>
  return r;
}
    1523:	89 f0                	mov    %esi,%eax
    1525:	8b 5d f8             	mov    -0x8(%ebp),%ebx
    1528:	8b 75 fc             	mov    -0x4(%ebp),%esi
    152b:	89 ec                	mov    %ebp,%esp
    152d:	5d                   	pop    %ebp
    152e:	c3                   	ret    
    152f:	90                   	nop

00001530 <gets>:
  return 0;
}

char*
gets(char *buf, int max)
{
    1530:	55                   	push   %ebp
    1531:	89 e5                	mov    %esp,%ebp
    1533:	57                   	push   %edi
    1534:	56                   	push   %esi
    1535:	31 f6                	xor    %esi,%esi
    1537:	53                   	push   %ebx
    1538:	83 ec 2c             	sub    $0x2c,%esp
    153b:	8b 7d 08             	mov    0x8(%ebp),%edi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    153e:	eb 06                	jmp    1546 <gets+0x16>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
    1540:	3c 0a                	cmp    $0xa,%al
    1542:	74 39                	je     157d <gets+0x4d>
    1544:	89 de                	mov    %ebx,%esi
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    1546:	8d 5e 01             	lea    0x1(%esi),%ebx
    1549:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
    154c:	7d 31                	jge    157f <gets+0x4f>
    cc = read(0, &c, 1);
    154e:	8d 45 e7             	lea    -0x19(%ebp),%eax
    1551:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    1558:	00 
    1559:	89 44 24 04          	mov    %eax,0x4(%esp)
    155d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1564:	e8 47 00 00 00       	call   15b0 <read>
    if(cc < 1)
    1569:	85 c0                	test   %eax,%eax
    156b:	7e 12                	jle    157f <gets+0x4f>
      break;
    buf[i++] = c;
    156d:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
    1571:	88 44 1f ff          	mov    %al,-0x1(%edi,%ebx,1)
    if(c == '\n' || c == '\r')
    1575:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
    1579:	3c 0d                	cmp    $0xd,%al
    157b:	75 c3                	jne    1540 <gets+0x10>
    157d:	89 de                	mov    %ebx,%esi
      break;
  }
  buf[i] = '\0';
    157f:	c6 04 37 00          	movb   $0x0,(%edi,%esi,1)
  return buf;
}
    1583:	89 f8                	mov    %edi,%eax
    1585:	83 c4 2c             	add    $0x2c,%esp
    1588:	5b                   	pop    %ebx
    1589:	5e                   	pop    %esi
    158a:	5f                   	pop    %edi
    158b:	5d                   	pop    %ebp
    158c:	c3                   	ret    
    158d:	90                   	nop
    158e:	90                   	nop
    158f:	90                   	nop

00001590 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    1590:	b8 01 00 00 00       	mov    $0x1,%eax
    1595:	cd 40                	int    $0x40
    1597:	c3                   	ret    

00001598 <exit>:
SYSCALL(exit)
    1598:	b8 02 00 00 00       	mov    $0x2,%eax
    159d:	cd 40                	int    $0x40
    159f:	c3                   	ret    

000015a0 <wait>:
SYSCALL(wait)
    15a0:	b8 03 00 00 00       	mov    $0x3,%eax
    15a5:	cd 40                	int    $0x40
    15a7:	c3                   	ret    

000015a8 <pipe>:
SYSCALL(pipe)
    15a8:	b8 04 00 00 00       	mov    $0x4,%eax
    15ad:	cd 40                	int    $0x40
    15af:	c3                   	ret    

000015b0 <read>:
SYSCALL(read)
    15b0:	b8 05 00 00 00       	mov    $0x5,%eax
    15b5:	cd 40                	int    $0x40
    15b7:	c3                   	ret    

000015b8 <write>:
SYSCALL(write)
    15b8:	b8 10 00 00 00       	mov    $0x10,%eax
    15bd:	cd 40                	int    $0x40
    15bf:	c3                   	ret    

000015c0 <close>:
SYSCALL(close)
    15c0:	b8 15 00 00 00       	mov    $0x15,%eax
    15c5:	cd 40                	int    $0x40
    15c7:	c3                   	ret    

000015c8 <kill>:
SYSCALL(kill)
    15c8:	b8 06 00 00 00       	mov    $0x6,%eax
    15cd:	cd 40                	int    $0x40
    15cf:	c3                   	ret    

000015d0 <exec>:
SYSCALL(exec)
    15d0:	b8 07 00 00 00       	mov    $0x7,%eax
    15d5:	cd 40                	int    $0x40
    15d7:	c3                   	ret    

000015d8 <open>:
SYSCALL(open)
    15d8:	b8 0f 00 00 00       	mov    $0xf,%eax
    15dd:	cd 40                	int    $0x40
    15df:	c3                   	ret    

000015e0 <mknod>:
SYSCALL(mknod)
    15e0:	b8 11 00 00 00       	mov    $0x11,%eax
    15e5:	cd 40                	int    $0x40
    15e7:	c3                   	ret    

000015e8 <unlink>:
SYSCALL(unlink)
    15e8:	b8 12 00 00 00       	mov    $0x12,%eax
    15ed:	cd 40                	int    $0x40
    15ef:	c3                   	ret    

000015f0 <fstat>:
SYSCALL(fstat)
    15f0:	b8 08 00 00 00       	mov    $0x8,%eax
    15f5:	cd 40                	int    $0x40
    15f7:	c3                   	ret    

000015f8 <link>:
SYSCALL(link)
    15f8:	b8 13 00 00 00       	mov    $0x13,%eax
    15fd:	cd 40                	int    $0x40
    15ff:	c3                   	ret    

00001600 <mkdir>:
SYSCALL(mkdir)
    1600:	b8 14 00 00 00       	mov    $0x14,%eax
    1605:	cd 40                	int    $0x40
    1607:	c3                   	ret    

00001608 <chdir>:
SYSCALL(chdir)
    1608:	b8 09 00 00 00       	mov    $0x9,%eax
    160d:	cd 40                	int    $0x40
    160f:	c3                   	ret    

00001610 <dup>:
SYSCALL(dup)
    1610:	b8 0a 00 00 00       	mov    $0xa,%eax
    1615:	cd 40                	int    $0x40
    1617:	c3                   	ret    

00001618 <getpid>:
SYSCALL(getpid)
    1618:	b8 0b 00 00 00       	mov    $0xb,%eax
    161d:	cd 40                	int    $0x40
    161f:	c3                   	ret    

00001620 <sbrk>:
SYSCALL(sbrk)
    1620:	b8 0c 00 00 00       	mov    $0xc,%eax
    1625:	cd 40                	int    $0x40
    1627:	c3                   	ret    

00001628 <sleep>:
SYSCALL(sleep)
    1628:	b8 0d 00 00 00       	mov    $0xd,%eax
    162d:	cd 40                	int    $0x40
    162f:	c3                   	ret    

00001630 <uptime>:
SYSCALL(uptime)
    1630:	b8 0e 00 00 00       	mov    $0xe,%eax
    1635:	cd 40                	int    $0x40
    1637:	c3                   	ret    

00001638 <hello>:
SYSCALL(hello)
    1638:	b8 16 00 00 00       	mov    $0x16,%eax
    163d:	cd 40                	int    $0x40
    163f:	c3                   	ret    

00001640 <waitpid>:
SYSCALL(waitpid)
    1640:	b8 17 00 00 00       	mov    $0x17,%eax
    1645:	cd 40                	int    $0x40
    1647:	c3                   	ret    

00001648 <setpriority>:
SYSCALL(setpriority)
    1648:	b8 18 00 00 00       	mov    $0x18,%eax
    164d:	cd 40                	int    $0x40
    164f:	c3                   	ret    

00001650 <v2p>:
SYSCALL(v2p)
    1650:	b8 19 00 00 00       	mov    $0x19,%eax
    1655:	cd 40                	int    $0x40
    1657:	c3                   	ret    
    1658:	90                   	nop
    1659:	90                   	nop
    165a:	90                   	nop
    165b:	90                   	nop
    165c:	90                   	nop
    165d:	90                   	nop
    165e:	90                   	nop
    165f:	90                   	nop

00001660 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
    1660:	55                   	push   %ebp
    1661:	89 e5                	mov    %esp,%ebp
    1663:	57                   	push   %edi
    1664:	89 cf                	mov    %ecx,%edi
    1666:	56                   	push   %esi
    1667:	89 c6                	mov    %eax,%esi
    1669:	53                   	push   %ebx
    166a:	83 ec 4c             	sub    $0x4c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    166d:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1670:	85 c9                	test   %ecx,%ecx
    1672:	74 04                	je     1678 <printint+0x18>
    1674:	85 d2                	test   %edx,%edx
    1676:	78 68                	js     16e0 <printint+0x80>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
    1678:	89 d0                	mov    %edx,%eax
    167a:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
    1681:	31 c9                	xor    %ecx,%ecx
    1683:	8d 5d d7             	lea    -0x29(%ebp),%ebx
    1686:	66 90                	xchg   %ax,%ax
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
    1688:	31 d2                	xor    %edx,%edx
    168a:	f7 f7                	div    %edi
    168c:	0f b6 92 a7 1a 00 00 	movzbl 0x1aa7(%edx),%edx
    1693:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
    1696:	83 c1 01             	add    $0x1,%ecx
  }while((x /= base) != 0);
    1699:	85 c0                	test   %eax,%eax
    169b:	75 eb                	jne    1688 <printint+0x28>
  if(neg)
    169d:	8b 45 c4             	mov    -0x3c(%ebp),%eax
    16a0:	85 c0                	test   %eax,%eax
    16a2:	74 08                	je     16ac <printint+0x4c>
    buf[i++] = '-';
    16a4:	c6 44 0d d7 2d       	movb   $0x2d,-0x29(%ebp,%ecx,1)
    16a9:	83 c1 01             	add    $0x1,%ecx

  while(--i >= 0)
    16ac:	8d 79 ff             	lea    -0x1(%ecx),%edi
    16af:	90                   	nop
    16b0:	0f b6 04 3b          	movzbl (%ebx,%edi,1),%eax
    16b4:	83 ef 01             	sub    $0x1,%edi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    16b7:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    16be:	00 
    16bf:	89 34 24             	mov    %esi,(%esp)
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
    16c2:	88 45 e7             	mov    %al,-0x19(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    16c5:	8d 45 e7             	lea    -0x19(%ebp),%eax
    16c8:	89 44 24 04          	mov    %eax,0x4(%esp)
    16cc:	e8 e7 fe ff ff       	call   15b8 <write>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
    16d1:	83 ff ff             	cmp    $0xffffffff,%edi
    16d4:	75 da                	jne    16b0 <printint+0x50>
    putc(fd, buf[i]);
}
    16d6:	83 c4 4c             	add    $0x4c,%esp
    16d9:	5b                   	pop    %ebx
    16da:	5e                   	pop    %esi
    16db:	5f                   	pop    %edi
    16dc:	5d                   	pop    %ebp
    16dd:	c3                   	ret    
    16de:	66 90                	xchg   %ax,%ax
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
    16e0:	89 d0                	mov    %edx,%eax
    16e2:	f7 d8                	neg    %eax
    16e4:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
    16eb:	eb 94                	jmp    1681 <printint+0x21>
    16ed:	8d 76 00             	lea    0x0(%esi),%esi

000016f0 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
    16f0:	55                   	push   %ebp
    16f1:	89 e5                	mov    %esp,%ebp
    16f3:	57                   	push   %edi
    16f4:	56                   	push   %esi
    16f5:	53                   	push   %ebx
    16f6:	83 ec 3c             	sub    $0x3c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    16f9:	8b 45 0c             	mov    0xc(%ebp),%eax
    16fc:	0f b6 10             	movzbl (%eax),%edx
    16ff:	84 d2                	test   %dl,%dl
    1701:	0f 84 c1 00 00 00    	je     17c8 <printf+0xd8>
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
    1707:	8d 4d 10             	lea    0x10(%ebp),%ecx
    170a:	31 ff                	xor    %edi,%edi
    170c:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
    170f:	31 db                	xor    %ebx,%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    1711:	8d 75 e7             	lea    -0x19(%ebp),%esi
    1714:	eb 1e                	jmp    1734 <printf+0x44>
    1716:	66 90                	xchg   %ax,%ax
  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
    1718:	83 fa 25             	cmp    $0x25,%edx
    171b:	0f 85 af 00 00 00    	jne    17d0 <printf+0xe0>
    1721:	66 bf 25 00          	mov    $0x25,%di
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    1725:	83 c3 01             	add    $0x1,%ebx
    1728:	0f b6 14 18          	movzbl (%eax,%ebx,1),%edx
    172c:	84 d2                	test   %dl,%dl
    172e:	0f 84 94 00 00 00    	je     17c8 <printf+0xd8>
    c = fmt[i] & 0xff;
    if(state == 0){
    1734:	85 ff                	test   %edi,%edi
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    1736:	0f b6 d2             	movzbl %dl,%edx
    if(state == 0){
    1739:	74 dd                	je     1718 <printf+0x28>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
    173b:	83 ff 25             	cmp    $0x25,%edi
    173e:	75 e5                	jne    1725 <printf+0x35>
      if(c == 'd'){
    1740:	83 fa 64             	cmp    $0x64,%edx
    1743:	0f 84 3f 01 00 00    	je     1888 <printf+0x198>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
    1749:	83 fa 70             	cmp    $0x70,%edx
    174c:	0f 84 a6 00 00 00    	je     17f8 <printf+0x108>
    1752:	83 fa 78             	cmp    $0x78,%edx
    1755:	0f 84 9d 00 00 00    	je     17f8 <printf+0x108>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
    175b:	83 fa 73             	cmp    $0x73,%edx
    175e:	66 90                	xchg   %ax,%ax
    1760:	0f 84 ba 00 00 00    	je     1820 <printf+0x130>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    1766:	83 fa 63             	cmp    $0x63,%edx
    1769:	0f 84 41 01 00 00    	je     18b0 <printf+0x1c0>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
    176f:	83 fa 25             	cmp    $0x25,%edx
    1772:	0f 84 00 01 00 00    	je     1878 <printf+0x188>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    1778:	8b 4d 08             	mov    0x8(%ebp),%ecx
    177b:	89 55 cc             	mov    %edx,-0x34(%ebp)
    177e:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
    1782:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    1789:	00 
    178a:	89 74 24 04          	mov    %esi,0x4(%esp)
    178e:	89 0c 24             	mov    %ecx,(%esp)
    1791:	e8 22 fe ff ff       	call   15b8 <write>
    1796:	8b 55 cc             	mov    -0x34(%ebp),%edx
    1799:	88 55 e7             	mov    %dl,-0x19(%ebp)
    179c:	8b 45 08             	mov    0x8(%ebp),%eax
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    179f:	83 c3 01             	add    $0x1,%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    17a2:	31 ff                	xor    %edi,%edi
    17a4:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    17ab:	00 
    17ac:	89 74 24 04          	mov    %esi,0x4(%esp)
    17b0:	89 04 24             	mov    %eax,(%esp)
    17b3:	e8 00 fe ff ff       	call   15b8 <write>
    17b8:	8b 45 0c             	mov    0xc(%ebp),%eax
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    17bb:	0f b6 14 18          	movzbl (%eax,%ebx,1),%edx
    17bf:	84 d2                	test   %dl,%dl
    17c1:	0f 85 6d ff ff ff    	jne    1734 <printf+0x44>
    17c7:	90                   	nop
        putc(fd, c);
      }
      state = 0;
    }
  }
}
    17c8:	83 c4 3c             	add    $0x3c,%esp
    17cb:	5b                   	pop    %ebx
    17cc:	5e                   	pop    %esi
    17cd:	5f                   	pop    %edi
    17ce:	5d                   	pop    %ebp
    17cf:	c3                   	ret    
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    17d0:	8b 45 08             	mov    0x8(%ebp),%eax
  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
    17d3:	88 55 e7             	mov    %dl,-0x19(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    17d6:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    17dd:	00 
    17de:	89 74 24 04          	mov    %esi,0x4(%esp)
    17e2:	89 04 24             	mov    %eax,(%esp)
    17e5:	e8 ce fd ff ff       	call   15b8 <write>
    17ea:	8b 45 0c             	mov    0xc(%ebp),%eax
    17ed:	e9 33 ff ff ff       	jmp    1725 <printf+0x35>
    17f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
    17f8:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    17fb:	b9 10 00 00 00       	mov    $0x10,%ecx
        ap++;
    1800:	31 ff                	xor    %edi,%edi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
    1802:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1809:	8b 10                	mov    (%eax),%edx
    180b:	8b 45 08             	mov    0x8(%ebp),%eax
    180e:	e8 4d fe ff ff       	call   1660 <printint>
    1813:	8b 45 0c             	mov    0xc(%ebp),%eax
        ap++;
    1816:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
    181a:	e9 06 ff ff ff       	jmp    1725 <printf+0x35>
    181f:	90                   	nop
      } else if(c == 's'){
        s = (char*)*ap;
    1820:	8b 55 d4             	mov    -0x2c(%ebp),%edx
        ap++;
        if(s == 0)
    1823:	b9 a0 1a 00 00       	mov    $0x1aa0,%ecx
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
        s = (char*)*ap;
    1828:	8b 3a                	mov    (%edx),%edi
        ap++;
    182a:	83 c2 04             	add    $0x4,%edx
    182d:	89 55 d4             	mov    %edx,-0x2c(%ebp)
        if(s == 0)
    1830:	85 ff                	test   %edi,%edi
    1832:	0f 44 f9             	cmove  %ecx,%edi
          s = "(null)";
        while(*s != 0){
    1835:	0f b6 17             	movzbl (%edi),%edx
    1838:	84 d2                	test   %dl,%dl
    183a:	74 33                	je     186f <printf+0x17f>
    183c:	89 5d d0             	mov    %ebx,-0x30(%ebp)
    183f:	8b 5d 08             	mov    0x8(%ebp),%ebx
    1842:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
          putc(fd, *s);
          s++;
    1848:	83 c7 01             	add    $0x1,%edi
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
    184b:	88 55 e7             	mov    %dl,-0x19(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    184e:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    1855:	00 
    1856:	89 74 24 04          	mov    %esi,0x4(%esp)
    185a:	89 1c 24             	mov    %ebx,(%esp)
    185d:	e8 56 fd ff ff       	call   15b8 <write>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
    1862:	0f b6 17             	movzbl (%edi),%edx
    1865:	84 d2                	test   %dl,%dl
    1867:	75 df                	jne    1848 <printf+0x158>
    1869:	8b 5d d0             	mov    -0x30(%ebp),%ebx
    186c:	8b 45 0c             	mov    0xc(%ebp),%eax
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    186f:	31 ff                	xor    %edi,%edi
    1871:	e9 af fe ff ff       	jmp    1725 <printf+0x35>
    1876:	66 90                	xchg   %ax,%ax
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
    1878:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
    187c:	e9 1b ff ff ff       	jmp    179c <printf+0xac>
    1881:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
    1888:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    188b:	b9 0a 00 00 00       	mov    $0xa,%ecx
        ap++;
    1890:	66 31 ff             	xor    %di,%di
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
    1893:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    189a:	8b 10                	mov    (%eax),%edx
    189c:	8b 45 08             	mov    0x8(%ebp),%eax
    189f:	e8 bc fd ff ff       	call   1660 <printint>
    18a4:	8b 45 0c             	mov    0xc(%ebp),%eax
        ap++;
    18a7:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
    18ab:	e9 75 fe ff ff       	jmp    1725 <printf+0x35>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    18b0:	8b 55 d4             	mov    -0x2c(%ebp),%edx
        putc(fd, *ap);
        ap++;
    18b3:	31 ff                	xor    %edi,%edi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    18b5:	8b 4d 08             	mov    0x8(%ebp),%ecx
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    18b8:	8b 02                	mov    (%edx),%eax
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    18ba:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    18c1:	00 
    18c2:	89 74 24 04          	mov    %esi,0x4(%esp)
    18c6:	89 0c 24             	mov    %ecx,(%esp)
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    18c9:	88 45 e7             	mov    %al,-0x19(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    18cc:	e8 e7 fc ff ff       	call   15b8 <write>
    18d1:	8b 45 0c             	mov    0xc(%ebp),%eax
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
        ap++;
    18d4:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
    18d8:	e9 48 fe ff ff       	jmp    1725 <printf+0x35>
    18dd:	90                   	nop
    18de:	90                   	nop
    18df:	90                   	nop

000018e0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    18e0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    18e1:	a1 d0 1a 00 00       	mov    0x1ad0,%eax
static Header base;
static Header *freep;

void
free(void *ap)
{
    18e6:	89 e5                	mov    %esp,%ebp
    18e8:	57                   	push   %edi
    18e9:	56                   	push   %esi
    18ea:	53                   	push   %ebx
    18eb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
    18ee:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    18f1:	39 c8                	cmp    %ecx,%eax
    18f3:	73 1d                	jae    1912 <free+0x32>
    18f5:	8d 76 00             	lea    0x0(%esi),%esi
    18f8:	8b 10                	mov    (%eax),%edx
    18fa:	39 d1                	cmp    %edx,%ecx
    18fc:	72 1a                	jb     1918 <free+0x38>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    18fe:	39 d0                	cmp    %edx,%eax
    1900:	72 08                	jb     190a <free+0x2a>
    1902:	39 c8                	cmp    %ecx,%eax
    1904:	72 12                	jb     1918 <free+0x38>
    1906:	39 d1                	cmp    %edx,%ecx
    1908:	72 0e                	jb     1918 <free+0x38>
    190a:	89 d0                	mov    %edx,%eax
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    190c:	39 c8                	cmp    %ecx,%eax
    190e:	66 90                	xchg   %ax,%ax
    1910:	72 e6                	jb     18f8 <free+0x18>
    1912:	8b 10                	mov    (%eax),%edx
    1914:	eb e8                	jmp    18fe <free+0x1e>
    1916:	66 90                	xchg   %ax,%ax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    1918:	8b 71 04             	mov    0x4(%ecx),%esi
    191b:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    191e:	39 d7                	cmp    %edx,%edi
    1920:	74 19                	je     193b <free+0x5b>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
    1922:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    1925:	8b 50 04             	mov    0x4(%eax),%edx
    1928:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    192b:	39 ce                	cmp    %ecx,%esi
    192d:	74 23                	je     1952 <free+0x72>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
    192f:	89 08                	mov    %ecx,(%eax)
  freep = p;
    1931:	a3 d0 1a 00 00       	mov    %eax,0x1ad0
}
    1936:	5b                   	pop    %ebx
    1937:	5e                   	pop    %esi
    1938:	5f                   	pop    %edi
    1939:	5d                   	pop    %ebp
    193a:	c3                   	ret    
  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
    193b:	03 72 04             	add    0x4(%edx),%esi
    193e:	89 71 04             	mov    %esi,0x4(%ecx)
    bp->s.ptr = p->s.ptr->s.ptr;
    1941:	8b 10                	mov    (%eax),%edx
    1943:	8b 12                	mov    (%edx),%edx
    1945:	89 53 f8             	mov    %edx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    1948:	8b 50 04             	mov    0x4(%eax),%edx
    194b:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    194e:	39 ce                	cmp    %ecx,%esi
    1950:	75 dd                	jne    192f <free+0x4f>
    p->s.size += bp->s.size;
    1952:	03 51 04             	add    0x4(%ecx),%edx
    1955:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    1958:	8b 53 f8             	mov    -0x8(%ebx),%edx
    195b:	89 10                	mov    %edx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
    195d:	a3 d0 1a 00 00       	mov    %eax,0x1ad0
}
    1962:	5b                   	pop    %ebx
    1963:	5e                   	pop    %esi
    1964:	5f                   	pop    %edi
    1965:	5d                   	pop    %ebp
    1966:	c3                   	ret    
    1967:	89 f6                	mov    %esi,%esi
    1969:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001970 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    1970:	55                   	push   %ebp
    1971:	89 e5                	mov    %esp,%ebp
    1973:	57                   	push   %edi
    1974:	56                   	push   %esi
    1975:	53                   	push   %ebx
    1976:	83 ec 2c             	sub    $0x2c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1979:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if((prevp = freep) == 0){
    197c:	8b 0d d0 1a 00 00    	mov    0x1ad0,%ecx
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1982:	83 c3 07             	add    $0x7,%ebx
    1985:	c1 eb 03             	shr    $0x3,%ebx
    1988:	83 c3 01             	add    $0x1,%ebx
  if((prevp = freep) == 0){
    198b:	85 c9                	test   %ecx,%ecx
    198d:	0f 84 9b 00 00 00    	je     1a2e <malloc+0xbe>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1993:	8b 01                	mov    (%ecx),%eax
    if(p->s.size >= nunits){
    1995:	8b 50 04             	mov    0x4(%eax),%edx
    1998:	39 d3                	cmp    %edx,%ebx
    199a:	76 27                	jbe    19c3 <malloc+0x53>
        p->s.size -= nunits;
        p += p->s.size;
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    199c:	8d 3c dd 00 00 00 00 	lea    0x0(,%ebx,8),%edi
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < 4096)
    19a3:	be 00 80 00 00       	mov    $0x8000,%esi
    19a8:	89 7d e4             	mov    %edi,-0x1c(%ebp)
    19ab:	90                   	nop
    19ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    19b0:	3b 05 d0 1a 00 00    	cmp    0x1ad0,%eax
    19b6:	74 30                	je     19e8 <malloc+0x78>
    19b8:	89 c1                	mov    %eax,%ecx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    19ba:	8b 01                	mov    (%ecx),%eax
    if(p->s.size >= nunits){
    19bc:	8b 50 04             	mov    0x4(%eax),%edx
    19bf:	39 d3                	cmp    %edx,%ebx
    19c1:	77 ed                	ja     19b0 <malloc+0x40>
      if(p->s.size == nunits)
    19c3:	39 d3                	cmp    %edx,%ebx
    19c5:	74 61                	je     1a28 <malloc+0xb8>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
    19c7:	29 da                	sub    %ebx,%edx
    19c9:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
    19cc:	8d 04 d0             	lea    (%eax,%edx,8),%eax
        p->s.size = nunits;
    19cf:	89 58 04             	mov    %ebx,0x4(%eax)
      }
      freep = prevp;
    19d2:	89 0d d0 1a 00 00    	mov    %ecx,0x1ad0
      return (void*)(p + 1);
    19d8:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
    19db:	83 c4 2c             	add    $0x2c,%esp
    19de:	5b                   	pop    %ebx
    19df:	5e                   	pop    %esi
    19e0:	5f                   	pop    %edi
    19e1:	5d                   	pop    %ebp
    19e2:	c3                   	ret    
    19e3:	90                   	nop
    19e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < 4096)
    19e8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    19eb:	81 fb 00 10 00 00    	cmp    $0x1000,%ebx
    19f1:	bf 00 10 00 00       	mov    $0x1000,%edi
    19f6:	0f 43 fb             	cmovae %ebx,%edi
    19f9:	0f 42 c6             	cmovb  %esi,%eax
    nu = 4096;
  p = sbrk(nu * sizeof(Header));
    19fc:	89 04 24             	mov    %eax,(%esp)
    19ff:	e8 1c fc ff ff       	call   1620 <sbrk>
  if(p == (char*)-1)
    1a04:	83 f8 ff             	cmp    $0xffffffff,%eax
    1a07:	74 18                	je     1a21 <malloc+0xb1>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
    1a09:	89 78 04             	mov    %edi,0x4(%eax)
  free((void*)(hp + 1));
    1a0c:	83 c0 08             	add    $0x8,%eax
    1a0f:	89 04 24             	mov    %eax,(%esp)
    1a12:	e8 c9 fe ff ff       	call   18e0 <free>
  return freep;
    1a17:	8b 0d d0 1a 00 00    	mov    0x1ad0,%ecx
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
    1a1d:	85 c9                	test   %ecx,%ecx
    1a1f:	75 99                	jne    19ba <malloc+0x4a>
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
    1a21:	31 c0                	xor    %eax,%eax
    1a23:	eb b6                	jmp    19db <malloc+0x6b>
    1a25:	8d 76 00             	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
    1a28:	8b 10                	mov    (%eax),%edx
    1a2a:	89 11                	mov    %edx,(%ecx)
    1a2c:	eb a4                	jmp    19d2 <malloc+0x62>
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    1a2e:	c7 05 d0 1a 00 00 c8 	movl   $0x1ac8,0x1ad0
    1a35:	1a 00 00 
    base.s.size = 0;
    1a38:	b9 c8 1a 00 00       	mov    $0x1ac8,%ecx
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    1a3d:	c7 05 c8 1a 00 00 c8 	movl   $0x1ac8,0x1ac8
    1a44:	1a 00 00 
    base.s.size = 0;
    1a47:	c7 05 cc 1a 00 00 00 	movl   $0x0,0x1acc
    1a4e:	00 00 00 
    1a51:	e9 3d ff ff ff       	jmp    1993 <malloc+0x23>
