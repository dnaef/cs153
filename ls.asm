
_ls:     file format elf32-i386


Disassembly of section .text:

00000000 <fmtname>:
#include "user.h"
#include "fs.h"

char*
fmtname(char *path)
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	56                   	push   %esi
   4:	53                   	push   %ebx
   5:	83 ec 10             	sub    $0x10,%esp
   8:	8b 5d 08             	mov    0x8(%ebp),%ebx
  static char buf[DIRSIZ+1];
  char *p;

  // Find first character after last slash.
  for(p=path+strlen(path); p >= path && *p != '/'; p--)
   b:	89 1c 24             	mov    %ebx,(%esp)
   e:	e8 dd 03 00 00       	call   3f0 <strlen>
  13:	01 d8                	add    %ebx,%eax
  15:	73 10                	jae    27 <fmtname+0x27>
  17:	eb 13                	jmp    2c <fmtname+0x2c>
  19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  20:	83 e8 01             	sub    $0x1,%eax
  23:	39 c3                	cmp    %eax,%ebx
  25:	77 05                	ja     2c <fmtname+0x2c>
  27:	80 38 2f             	cmpb   $0x2f,(%eax)
  2a:	75 f4                	jne    20 <fmtname+0x20>
    ;
  p++;
  2c:	8d 58 01             	lea    0x1(%eax),%ebx

  // Return blank-padded name.
  if(strlen(p) >= DIRSIZ)
  2f:	89 1c 24             	mov    %ebx,(%esp)
  32:	e8 b9 03 00 00       	call   3f0 <strlen>
  37:	83 f8 0d             	cmp    $0xd,%eax
  3a:	77 53                	ja     8f <fmtname+0x8f>
    return p;
  memmove(buf, p, strlen(p));
  3c:	89 1c 24             	mov    %ebx,(%esp)
  3f:	e8 ac 03 00 00       	call   3f0 <strlen>
  44:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  48:	c7 04 24 a8 0a 00 00 	movl   $0xaa8,(%esp)
  4f:	89 44 24 08          	mov    %eax,0x8(%esp)
  53:	e8 58 04 00 00       	call   4b0 <memmove>
  memset(buf+strlen(p), ' ', DIRSIZ-strlen(p));
  58:	89 1c 24             	mov    %ebx,(%esp)
  5b:	e8 90 03 00 00       	call   3f0 <strlen>
  60:	89 1c 24             	mov    %ebx,(%esp)
  63:	bb a8 0a 00 00       	mov    $0xaa8,%ebx
  68:	89 c6                	mov    %eax,%esi
  6a:	e8 81 03 00 00       	call   3f0 <strlen>
  6f:	ba 0e 00 00 00       	mov    $0xe,%edx
  74:	29 f2                	sub    %esi,%edx
  76:	89 54 24 08          	mov    %edx,0x8(%esp)
  7a:	c7 44 24 04 20 00 00 	movl   $0x20,0x4(%esp)
  81:	00 
  82:	05 a8 0a 00 00       	add    $0xaa8,%eax
  87:	89 04 24             	mov    %eax,(%esp)
  8a:	e8 81 03 00 00       	call   410 <memset>
  return buf;
}
  8f:	83 c4 10             	add    $0x10,%esp
  92:	89 d8                	mov    %ebx,%eax
  94:	5b                   	pop    %ebx
  95:	5e                   	pop    %esi
  96:	5d                   	pop    %ebp
  97:	c3                   	ret    
  98:	90                   	nop
  99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000000a0 <ls>:

void
ls(char *path)
{
  a0:	55                   	push   %ebp
  a1:	89 e5                	mov    %esp,%ebp
  a3:	57                   	push   %edi
  a4:	56                   	push   %esi
  a5:	53                   	push   %ebx
  a6:	81 ec 6c 02 00 00    	sub    $0x26c,%esp
  ac:	8b 7d 08             	mov    0x8(%ebp),%edi
  char buf[512], *p;
  int fd;
  struct dirent de;
  struct stat st;

  if((fd = open(path, 0)) < 0){
  af:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  b6:	00 
  b7:	89 3c 24             	mov    %edi,(%esp)
  ba:	e8 19 05 00 00       	call   5d8 <open>
  bf:	85 c0                	test   %eax,%eax
  c1:	89 c3                	mov    %eax,%ebx
  c3:	0f 88 c7 01 00 00    	js     290 <ls+0x1f0>
    printf(2, "ls: cannot open %s\n", path);
    return;
  }

  if(fstat(fd, &st) < 0){
  c9:	8d 75 c4             	lea    -0x3c(%ebp),%esi
  cc:	89 74 24 04          	mov    %esi,0x4(%esp)
  d0:	89 04 24             	mov    %eax,(%esp)
  d3:	e8 18 05 00 00       	call   5f0 <fstat>
  d8:	85 c0                	test   %eax,%eax
  da:	0f 88 00 02 00 00    	js     2e0 <ls+0x240>
    printf(2, "ls: cannot stat %s\n", path);
    close(fd);
    return;
  }

  switch(st.type){
  e0:	0f b7 45 c4          	movzwl -0x3c(%ebp),%eax
  e4:	66 83 f8 01          	cmp    $0x1,%ax
  e8:	74 66                	je     150 <ls+0xb0>
  ea:	66 83 f8 02          	cmp    $0x2,%ax
  ee:	74 18                	je     108 <ls+0x68>
      }
      printf(1, "%s %d %d %d\n", fmtname(buf), st.type, st.ino, st.size);
    }
    break;
  }
  close(fd);
  f0:	89 1c 24             	mov    %ebx,(%esp)
  f3:	e8 c8 04 00 00       	call   5c0 <close>
}
  f8:	81 c4 6c 02 00 00    	add    $0x26c,%esp
  fe:	5b                   	pop    %ebx
  ff:	5e                   	pop    %esi
 100:	5f                   	pop    %edi
 101:	5d                   	pop    %ebp
 102:	c3                   	ret    
 103:	90                   	nop
 104:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return;
  }

  switch(st.type){
  case T_FILE:
    printf(1, "%s %d %d %d\n", fmtname(path), st.type, st.ino, st.size);
 108:	8b 55 d4             	mov    -0x2c(%ebp),%edx
 10b:	8b 75 cc             	mov    -0x34(%ebp),%esi
 10e:	89 3c 24             	mov    %edi,(%esp)
 111:	89 95 ac fd ff ff    	mov    %edx,-0x254(%ebp)
 117:	e8 e4 fe ff ff       	call   0 <fmtname>
 11c:	8b 95 ac fd ff ff    	mov    -0x254(%ebp),%edx
 122:	89 74 24 10          	mov    %esi,0x10(%esp)
 126:	c7 44 24 0c 02 00 00 	movl   $0x2,0xc(%esp)
 12d:	00 
 12e:	c7 44 24 04 6e 0a 00 	movl   $0xa6e,0x4(%esp)
 135:	00 
 136:	89 54 24 14          	mov    %edx,0x14(%esp)
 13a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 141:	89 44 24 08          	mov    %eax,0x8(%esp)
 145:	e8 96 05 00 00       	call   6e0 <printf>
    break;
 14a:	eb a4                	jmp    f0 <ls+0x50>
 14c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  case T_DIR:
    if(strlen(path) + 1 + DIRSIZ + 1 > sizeof buf){
 150:	89 3c 24             	mov    %edi,(%esp)
 153:	e8 98 02 00 00       	call   3f0 <strlen>
 158:	83 c0 10             	add    $0x10,%eax
 15b:	3d 00 02 00 00       	cmp    $0x200,%eax
 160:	0f 87 0a 01 00 00    	ja     270 <ls+0x1d0>
      printf(1, "ls: path too long\n");
      break;
    }
    strcpy(buf, path);
 166:	8d 85 c4 fd ff ff    	lea    -0x23c(%ebp),%eax
 16c:	89 7c 24 04          	mov    %edi,0x4(%esp)
 170:	8d 7d d8             	lea    -0x28(%ebp),%edi
 173:	89 04 24             	mov    %eax,(%esp)
 176:	e8 f5 01 00 00       	call   370 <strcpy>
    p = buf+strlen(buf);
 17b:	8d 95 c4 fd ff ff    	lea    -0x23c(%ebp),%edx
 181:	89 14 24             	mov    %edx,(%esp)
 184:	e8 67 02 00 00       	call   3f0 <strlen>
 189:	8d 95 c4 fd ff ff    	lea    -0x23c(%ebp),%edx
 18f:	8d 04 02             	lea    (%edx,%eax,1),%eax
    *p++ = '/';
 192:	c6 00 2f             	movb   $0x2f,(%eax)
 195:	83 c0 01             	add    $0x1,%eax
 198:	89 85 b4 fd ff ff    	mov    %eax,-0x24c(%ebp)
 19e:	66 90                	xchg   %ax,%ax
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
 1a0:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
 1a7:	00 
 1a8:	89 7c 24 04          	mov    %edi,0x4(%esp)
 1ac:	89 1c 24             	mov    %ebx,(%esp)
 1af:	e8 fc 03 00 00       	call   5b0 <read>
 1b4:	83 f8 10             	cmp    $0x10,%eax
 1b7:	0f 85 33 ff ff ff    	jne    f0 <ls+0x50>
      if(de.inum == 0)
 1bd:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
 1c2:	74 dc                	je     1a0 <ls+0x100>
        continue;
      memmove(p, de.name, DIRSIZ);
 1c4:	8b 95 b4 fd ff ff    	mov    -0x24c(%ebp),%edx
 1ca:	8d 45 da             	lea    -0x26(%ebp),%eax
 1cd:	c7 44 24 08 0e 00 00 	movl   $0xe,0x8(%esp)
 1d4:	00 
 1d5:	89 44 24 04          	mov    %eax,0x4(%esp)
 1d9:	89 14 24             	mov    %edx,(%esp)
 1dc:	e8 cf 02 00 00       	call   4b0 <memmove>
      p[DIRSIZ] = 0;
 1e1:	8b 85 b4 fd ff ff    	mov    -0x24c(%ebp),%eax
      if(stat(buf, &st) < 0){
 1e7:	8d 95 c4 fd ff ff    	lea    -0x23c(%ebp),%edx
    *p++ = '/';
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
      if(de.inum == 0)
        continue;
      memmove(p, de.name, DIRSIZ);
      p[DIRSIZ] = 0;
 1ed:	c6 40 0e 00          	movb   $0x0,0xe(%eax)
      if(stat(buf, &st) < 0){
 1f1:	89 74 24 04          	mov    %esi,0x4(%esp)
 1f5:	89 14 24             	mov    %edx,(%esp)
 1f8:	e8 e3 02 00 00       	call   4e0 <stat>
 1fd:	85 c0                	test   %eax,%eax
 1ff:	0f 88 b3 00 00 00    	js     2b8 <ls+0x218>
        printf(1, "ls: cannot stat %s\n", buf);
        continue;
      }
      printf(1, "%s %d %d %d\n", fmtname(buf), st.type, st.ino, st.size);
 205:	0f bf 45 c4          	movswl -0x3c(%ebp),%eax
 209:	8b 55 d4             	mov    -0x2c(%ebp),%edx
 20c:	8b 4d cc             	mov    -0x34(%ebp),%ecx
 20f:	89 85 b0 fd ff ff    	mov    %eax,-0x250(%ebp)
 215:	8d 85 c4 fd ff ff    	lea    -0x23c(%ebp),%eax
 21b:	89 95 ac fd ff ff    	mov    %edx,-0x254(%ebp)
 221:	89 8d a8 fd ff ff    	mov    %ecx,-0x258(%ebp)
 227:	89 04 24             	mov    %eax,(%esp)
 22a:	e8 d1 fd ff ff       	call   0 <fmtname>
 22f:	8b 95 ac fd ff ff    	mov    -0x254(%ebp),%edx
 235:	8b 8d a8 fd ff ff    	mov    -0x258(%ebp),%ecx
 23b:	c7 44 24 04 6e 0a 00 	movl   $0xa6e,0x4(%esp)
 242:	00 
 243:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 24a:	89 54 24 14          	mov    %edx,0x14(%esp)
 24e:	8b 95 b0 fd ff ff    	mov    -0x250(%ebp),%edx
 254:	89 4c 24 10          	mov    %ecx,0x10(%esp)
 258:	89 44 24 08          	mov    %eax,0x8(%esp)
 25c:	89 54 24 0c          	mov    %edx,0xc(%esp)
 260:	e8 7b 04 00 00       	call   6e0 <printf>
 265:	e9 36 ff ff ff       	jmp    1a0 <ls+0x100>
 26a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    printf(1, "%s %d %d %d\n", fmtname(path), st.type, st.ino, st.size);
    break;

  case T_DIR:
    if(strlen(path) + 1 + DIRSIZ + 1 > sizeof buf){
      printf(1, "ls: path too long\n");
 270:	c7 44 24 04 7b 0a 00 	movl   $0xa7b,0x4(%esp)
 277:	00 
 278:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 27f:	e8 5c 04 00 00       	call   6e0 <printf>
      break;
 284:	e9 67 fe ff ff       	jmp    f0 <ls+0x50>
 289:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  int fd;
  struct dirent de;
  struct stat st;

  if((fd = open(path, 0)) < 0){
    printf(2, "ls: cannot open %s\n", path);
 290:	89 7c 24 08          	mov    %edi,0x8(%esp)
 294:	c7 44 24 04 46 0a 00 	movl   $0xa46,0x4(%esp)
 29b:	00 
 29c:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
 2a3:	e8 38 04 00 00       	call   6e0 <printf>
      printf(1, "%s %d %d %d\n", fmtname(buf), st.type, st.ino, st.size);
    }
    break;
  }
  close(fd);
}
 2a8:	81 c4 6c 02 00 00    	add    $0x26c,%esp
 2ae:	5b                   	pop    %ebx
 2af:	5e                   	pop    %esi
 2b0:	5f                   	pop    %edi
 2b1:	5d                   	pop    %ebp
 2b2:	c3                   	ret    
 2b3:	90                   	nop
 2b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      if(de.inum == 0)
        continue;
      memmove(p, de.name, DIRSIZ);
      p[DIRSIZ] = 0;
      if(stat(buf, &st) < 0){
        printf(1, "ls: cannot stat %s\n", buf);
 2b8:	8d 85 c4 fd ff ff    	lea    -0x23c(%ebp),%eax
 2be:	89 44 24 08          	mov    %eax,0x8(%esp)
 2c2:	c7 44 24 04 5a 0a 00 	movl   $0xa5a,0x4(%esp)
 2c9:	00 
 2ca:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 2d1:	e8 0a 04 00 00       	call   6e0 <printf>
        continue;
 2d6:	e9 c5 fe ff ff       	jmp    1a0 <ls+0x100>
 2db:	90                   	nop
 2dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    printf(2, "ls: cannot open %s\n", path);
    return;
  }

  if(fstat(fd, &st) < 0){
    printf(2, "ls: cannot stat %s\n", path);
 2e0:	89 7c 24 08          	mov    %edi,0x8(%esp)
 2e4:	c7 44 24 04 5a 0a 00 	movl   $0xa5a,0x4(%esp)
 2eb:	00 
 2ec:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
 2f3:	e8 e8 03 00 00       	call   6e0 <printf>
    close(fd);
 2f8:	89 1c 24             	mov    %ebx,(%esp)
 2fb:	e8 c0 02 00 00       	call   5c0 <close>
    return;
 300:	e9 f3 fd ff ff       	jmp    f8 <ls+0x58>
 305:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 309:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000310 <main>:
  close(fd);
}

int
main(int argc, char *argv[])
{
 310:	55                   	push   %ebp
 311:	89 e5                	mov    %esp,%ebp
 313:	83 e4 f0             	and    $0xfffffff0,%esp
 316:	57                   	push   %edi
 317:	56                   	push   %esi
 318:	53                   	push   %ebx
  int i;

  if(argc < 2){
    ls(".");
    exit(0);
 319:	bb 01 00 00 00       	mov    $0x1,%ebx
  close(fd);
}

int
main(int argc, char *argv[])
{
 31e:	83 ec 14             	sub    $0x14,%esp
 321:	8b 75 08             	mov    0x8(%ebp),%esi
 324:	8b 7d 0c             	mov    0xc(%ebp),%edi
  int i;

  if(argc < 2){
 327:	83 fe 01             	cmp    $0x1,%esi
 32a:	7e 24                	jle    350 <main+0x40>
 32c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    ls(".");
    exit(0);
  }
  for(i=1; i<argc; i++)
    ls(argv[i]);
 330:	8b 04 9f             	mov    (%edi,%ebx,4),%eax

  if(argc < 2){
    ls(".");
    exit(0);
  }
  for(i=1; i<argc; i++)
 333:	83 c3 01             	add    $0x1,%ebx
    ls(argv[i]);
 336:	89 04 24             	mov    %eax,(%esp)
 339:	e8 62 fd ff ff       	call   a0 <ls>

  if(argc < 2){
    ls(".");
    exit(0);
  }
  for(i=1; i<argc; i++)
 33e:	39 de                	cmp    %ebx,%esi
 340:	7f ee                	jg     330 <main+0x20>
    ls(argv[i]);
  exit(0);
 342:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 349:	e8 4a 02 00 00       	call   598 <exit>
 34e:	66 90                	xchg   %ax,%ax
main(int argc, char *argv[])
{
  int i;

  if(argc < 2){
    ls(".");
 350:	c7 04 24 8e 0a 00 00 	movl   $0xa8e,(%esp)
 357:	e8 44 fd ff ff       	call   a0 <ls>
    exit(0);
 35c:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 363:	e8 30 02 00 00       	call   598 <exit>
 368:	90                   	nop
 369:	90                   	nop
 36a:	90                   	nop
 36b:	90                   	nop
 36c:	90                   	nop
 36d:	90                   	nop
 36e:	90                   	nop
 36f:	90                   	nop

00000370 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 370:	55                   	push   %ebp
 371:	31 d2                	xor    %edx,%edx
 373:	89 e5                	mov    %esp,%ebp
 375:	8b 45 08             	mov    0x8(%ebp),%eax
 378:	53                   	push   %ebx
 379:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 37c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 380:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
 384:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 387:	83 c2 01             	add    $0x1,%edx
 38a:	84 c9                	test   %cl,%cl
 38c:	75 f2                	jne    380 <strcpy+0x10>
    ;
  return os;
}
 38e:	5b                   	pop    %ebx
 38f:	5d                   	pop    %ebp
 390:	c3                   	ret    
 391:	eb 0d                	jmp    3a0 <strcmp>
 393:	90                   	nop
 394:	90                   	nop
 395:	90                   	nop
 396:	90                   	nop
 397:	90                   	nop
 398:	90                   	nop
 399:	90                   	nop
 39a:	90                   	nop
 39b:	90                   	nop
 39c:	90                   	nop
 39d:	90                   	nop
 39e:	90                   	nop
 39f:	90                   	nop

000003a0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 3a0:	55                   	push   %ebp
 3a1:	89 e5                	mov    %esp,%ebp
 3a3:	8b 4d 08             	mov    0x8(%ebp),%ecx
 3a6:	53                   	push   %ebx
 3a7:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(*p && *p == *q)
 3aa:	0f b6 01             	movzbl (%ecx),%eax
 3ad:	84 c0                	test   %al,%al
 3af:	75 14                	jne    3c5 <strcmp+0x25>
 3b1:	eb 25                	jmp    3d8 <strcmp+0x38>
 3b3:	90                   	nop
 3b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    p++, q++;
 3b8:	83 c1 01             	add    $0x1,%ecx
 3bb:	83 c2 01             	add    $0x1,%edx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 3be:	0f b6 01             	movzbl (%ecx),%eax
 3c1:	84 c0                	test   %al,%al
 3c3:	74 13                	je     3d8 <strcmp+0x38>
 3c5:	0f b6 1a             	movzbl (%edx),%ebx
 3c8:	38 d8                	cmp    %bl,%al
 3ca:	74 ec                	je     3b8 <strcmp+0x18>
 3cc:	0f b6 db             	movzbl %bl,%ebx
 3cf:	0f b6 c0             	movzbl %al,%eax
 3d2:	29 d8                	sub    %ebx,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
 3d4:	5b                   	pop    %ebx
 3d5:	5d                   	pop    %ebp
 3d6:	c3                   	ret    
 3d7:	90                   	nop
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 3d8:	0f b6 1a             	movzbl (%edx),%ebx
 3db:	31 c0                	xor    %eax,%eax
 3dd:	0f b6 db             	movzbl %bl,%ebx
 3e0:	29 d8                	sub    %ebx,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
 3e2:	5b                   	pop    %ebx
 3e3:	5d                   	pop    %ebp
 3e4:	c3                   	ret    
 3e5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 3e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000003f0 <strlen>:

uint
strlen(char *s)
{
 3f0:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
 3f1:	31 d2                	xor    %edx,%edx
  return (uchar)*p - (uchar)*q;
}

uint
strlen(char *s)
{
 3f3:	89 e5                	mov    %esp,%ebp
  int n;

  for(n = 0; s[n]; n++)
 3f5:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
}

uint
strlen(char *s)
{
 3f7:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 3fa:	80 39 00             	cmpb   $0x0,(%ecx)
 3fd:	74 0c                	je     40b <strlen+0x1b>
 3ff:	90                   	nop
 400:	83 c2 01             	add    $0x1,%edx
 403:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 407:	89 d0                	mov    %edx,%eax
 409:	75 f5                	jne    400 <strlen+0x10>
    ;
  return n;
}
 40b:	5d                   	pop    %ebp
 40c:	c3                   	ret    
 40d:	8d 76 00             	lea    0x0(%esi),%esi

00000410 <memset>:

void*
memset(void *dst, int c, uint n)
{
 410:	55                   	push   %ebp
 411:	89 e5                	mov    %esp,%ebp
 413:	8b 55 08             	mov    0x8(%ebp),%edx
 416:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 417:	8b 4d 10             	mov    0x10(%ebp),%ecx
 41a:	8b 45 0c             	mov    0xc(%ebp),%eax
 41d:	89 d7                	mov    %edx,%edi
 41f:	fc                   	cld    
 420:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 422:	89 d0                	mov    %edx,%eax
 424:	5f                   	pop    %edi
 425:	5d                   	pop    %ebp
 426:	c3                   	ret    
 427:	89 f6                	mov    %esi,%esi
 429:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000430 <strchr>:

char*
strchr(const char *s, char c)
{
 430:	55                   	push   %ebp
 431:	89 e5                	mov    %esp,%ebp
 433:	8b 45 08             	mov    0x8(%ebp),%eax
 436:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 43a:	0f b6 10             	movzbl (%eax),%edx
 43d:	84 d2                	test   %dl,%dl
 43f:	75 11                	jne    452 <strchr+0x22>
 441:	eb 15                	jmp    458 <strchr+0x28>
 443:	90                   	nop
 444:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 448:	83 c0 01             	add    $0x1,%eax
 44b:	0f b6 10             	movzbl (%eax),%edx
 44e:	84 d2                	test   %dl,%dl
 450:	74 06                	je     458 <strchr+0x28>
    if(*s == c)
 452:	38 ca                	cmp    %cl,%dl
 454:	75 f2                	jne    448 <strchr+0x18>
      return (char*)s;
  return 0;
}
 456:	5d                   	pop    %ebp
 457:	c3                   	ret    
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 458:	31 c0                	xor    %eax,%eax
    if(*s == c)
      return (char*)s;
  return 0;
}
 45a:	5d                   	pop    %ebp
 45b:	90                   	nop
 45c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 460:	c3                   	ret    
 461:	eb 0d                	jmp    470 <atoi>
 463:	90                   	nop
 464:	90                   	nop
 465:	90                   	nop
 466:	90                   	nop
 467:	90                   	nop
 468:	90                   	nop
 469:	90                   	nop
 46a:	90                   	nop
 46b:	90                   	nop
 46c:	90                   	nop
 46d:	90                   	nop
 46e:	90                   	nop
 46f:	90                   	nop

00000470 <atoi>:
  return r;
}

int
atoi(const char *s)
{
 470:	55                   	push   %ebp
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 471:	31 c0                	xor    %eax,%eax
  return r;
}

int
atoi(const char *s)
{
 473:	89 e5                	mov    %esp,%ebp
 475:	8b 4d 08             	mov    0x8(%ebp),%ecx
 478:	53                   	push   %ebx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 479:	0f b6 11             	movzbl (%ecx),%edx
 47c:	8d 5a d0             	lea    -0x30(%edx),%ebx
 47f:	80 fb 09             	cmp    $0x9,%bl
 482:	77 1c                	ja     4a0 <atoi+0x30>
 484:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    n = n*10 + *s++ - '0';
 488:	0f be d2             	movsbl %dl,%edx
 48b:	83 c1 01             	add    $0x1,%ecx
 48e:	8d 04 80             	lea    (%eax,%eax,4),%eax
 491:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 495:	0f b6 11             	movzbl (%ecx),%edx
 498:	8d 5a d0             	lea    -0x30(%edx),%ebx
 49b:	80 fb 09             	cmp    $0x9,%bl
 49e:	76 e8                	jbe    488 <atoi+0x18>
    n = n*10 + *s++ - '0';
  return n;
}
 4a0:	5b                   	pop    %ebx
 4a1:	5d                   	pop    %ebp
 4a2:	c3                   	ret    
 4a3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 4a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000004b0 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 4b0:	55                   	push   %ebp
 4b1:	89 e5                	mov    %esp,%ebp
 4b3:	56                   	push   %esi
 4b4:	8b 45 08             	mov    0x8(%ebp),%eax
 4b7:	53                   	push   %ebx
 4b8:	8b 5d 10             	mov    0x10(%ebp),%ebx
 4bb:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 4be:	85 db                	test   %ebx,%ebx
 4c0:	7e 14                	jle    4d6 <memmove+0x26>
    n = n*10 + *s++ - '0';
  return n;
}

void*
memmove(void *vdst, void *vsrc, int n)
 4c2:	31 d2                	xor    %edx,%edx
 4c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    *dst++ = *src++;
 4c8:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 4cc:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 4cf:	83 c2 01             	add    $0x1,%edx
{
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 4d2:	39 da                	cmp    %ebx,%edx
 4d4:	75 f2                	jne    4c8 <memmove+0x18>
    *dst++ = *src++;
  return vdst;
}
 4d6:	5b                   	pop    %ebx
 4d7:	5e                   	pop    %esi
 4d8:	5d                   	pop    %ebp
 4d9:	c3                   	ret    
 4da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000004e0 <stat>:
  return buf;
}

int
stat(char *n, struct stat *st)
{
 4e0:	55                   	push   %ebp
 4e1:	89 e5                	mov    %esp,%ebp
 4e3:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 4e6:	8b 45 08             	mov    0x8(%ebp),%eax
  return buf;
}

int
stat(char *n, struct stat *st)
{
 4e9:	89 5d f8             	mov    %ebx,-0x8(%ebp)
 4ec:	89 75 fc             	mov    %esi,-0x4(%ebp)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
 4ef:	be ff ff ff ff       	mov    $0xffffffff,%esi
stat(char *n, struct stat *st)
{
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 4f4:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 4fb:	00 
 4fc:	89 04 24             	mov    %eax,(%esp)
 4ff:	e8 d4 00 00 00       	call   5d8 <open>
  if(fd < 0)
 504:	85 c0                	test   %eax,%eax
stat(char *n, struct stat *st)
{
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 506:	89 c3                	mov    %eax,%ebx
  if(fd < 0)
 508:	78 19                	js     523 <stat+0x43>
    return -1;
  r = fstat(fd, st);
 50a:	8b 45 0c             	mov    0xc(%ebp),%eax
 50d:	89 1c 24             	mov    %ebx,(%esp)
 510:	89 44 24 04          	mov    %eax,0x4(%esp)
 514:	e8 d7 00 00 00       	call   5f0 <fstat>
  close(fd);
 519:	89 1c 24             	mov    %ebx,(%esp)
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
  r = fstat(fd, st);
 51c:	89 c6                	mov    %eax,%esi
  close(fd);
 51e:	e8 9d 00 00 00       	call   5c0 <close>
  return r;
}
 523:	89 f0                	mov    %esi,%eax
 525:	8b 5d f8             	mov    -0x8(%ebp),%ebx
 528:	8b 75 fc             	mov    -0x4(%ebp),%esi
 52b:	89 ec                	mov    %ebp,%esp
 52d:	5d                   	pop    %ebp
 52e:	c3                   	ret    
 52f:	90                   	nop

00000530 <gets>:
  return 0;
}

char*
gets(char *buf, int max)
{
 530:	55                   	push   %ebp
 531:	89 e5                	mov    %esp,%ebp
 533:	57                   	push   %edi
 534:	56                   	push   %esi
 535:	31 f6                	xor    %esi,%esi
 537:	53                   	push   %ebx
 538:	83 ec 2c             	sub    $0x2c,%esp
 53b:	8b 7d 08             	mov    0x8(%ebp),%edi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 53e:	eb 06                	jmp    546 <gets+0x16>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 540:	3c 0a                	cmp    $0xa,%al
 542:	74 39                	je     57d <gets+0x4d>
 544:	89 de                	mov    %ebx,%esi
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 546:	8d 5e 01             	lea    0x1(%esi),%ebx
 549:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 54c:	7d 31                	jge    57f <gets+0x4f>
    cc = read(0, &c, 1);
 54e:	8d 45 e7             	lea    -0x19(%ebp),%eax
 551:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 558:	00 
 559:	89 44 24 04          	mov    %eax,0x4(%esp)
 55d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 564:	e8 47 00 00 00       	call   5b0 <read>
    if(cc < 1)
 569:	85 c0                	test   %eax,%eax
 56b:	7e 12                	jle    57f <gets+0x4f>
      break;
    buf[i++] = c;
 56d:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 571:	88 44 1f ff          	mov    %al,-0x1(%edi,%ebx,1)
    if(c == '\n' || c == '\r')
 575:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 579:	3c 0d                	cmp    $0xd,%al
 57b:	75 c3                	jne    540 <gets+0x10>
 57d:	89 de                	mov    %ebx,%esi
      break;
  }
  buf[i] = '\0';
 57f:	c6 04 37 00          	movb   $0x0,(%edi,%esi,1)
  return buf;
}
 583:	89 f8                	mov    %edi,%eax
 585:	83 c4 2c             	add    $0x2c,%esp
 588:	5b                   	pop    %ebx
 589:	5e                   	pop    %esi
 58a:	5f                   	pop    %edi
 58b:	5d                   	pop    %ebp
 58c:	c3                   	ret    
 58d:	90                   	nop
 58e:	90                   	nop
 58f:	90                   	nop

00000590 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 590:	b8 01 00 00 00       	mov    $0x1,%eax
 595:	cd 40                	int    $0x40
 597:	c3                   	ret    

00000598 <exit>:
SYSCALL(exit)
 598:	b8 02 00 00 00       	mov    $0x2,%eax
 59d:	cd 40                	int    $0x40
 59f:	c3                   	ret    

000005a0 <wait>:
SYSCALL(wait)
 5a0:	b8 03 00 00 00       	mov    $0x3,%eax
 5a5:	cd 40                	int    $0x40
 5a7:	c3                   	ret    

000005a8 <pipe>:
SYSCALL(pipe)
 5a8:	b8 04 00 00 00       	mov    $0x4,%eax
 5ad:	cd 40                	int    $0x40
 5af:	c3                   	ret    

000005b0 <read>:
SYSCALL(read)
 5b0:	b8 05 00 00 00       	mov    $0x5,%eax
 5b5:	cd 40                	int    $0x40
 5b7:	c3                   	ret    

000005b8 <write>:
SYSCALL(write)
 5b8:	b8 10 00 00 00       	mov    $0x10,%eax
 5bd:	cd 40                	int    $0x40
 5bf:	c3                   	ret    

000005c0 <close>:
SYSCALL(close)
 5c0:	b8 15 00 00 00       	mov    $0x15,%eax
 5c5:	cd 40                	int    $0x40
 5c7:	c3                   	ret    

000005c8 <kill>:
SYSCALL(kill)
 5c8:	b8 06 00 00 00       	mov    $0x6,%eax
 5cd:	cd 40                	int    $0x40
 5cf:	c3                   	ret    

000005d0 <exec>:
SYSCALL(exec)
 5d0:	b8 07 00 00 00       	mov    $0x7,%eax
 5d5:	cd 40                	int    $0x40
 5d7:	c3                   	ret    

000005d8 <open>:
SYSCALL(open)
 5d8:	b8 0f 00 00 00       	mov    $0xf,%eax
 5dd:	cd 40                	int    $0x40
 5df:	c3                   	ret    

000005e0 <mknod>:
SYSCALL(mknod)
 5e0:	b8 11 00 00 00       	mov    $0x11,%eax
 5e5:	cd 40                	int    $0x40
 5e7:	c3                   	ret    

000005e8 <unlink>:
SYSCALL(unlink)
 5e8:	b8 12 00 00 00       	mov    $0x12,%eax
 5ed:	cd 40                	int    $0x40
 5ef:	c3                   	ret    

000005f0 <fstat>:
SYSCALL(fstat)
 5f0:	b8 08 00 00 00       	mov    $0x8,%eax
 5f5:	cd 40                	int    $0x40
 5f7:	c3                   	ret    

000005f8 <link>:
SYSCALL(link)
 5f8:	b8 13 00 00 00       	mov    $0x13,%eax
 5fd:	cd 40                	int    $0x40
 5ff:	c3                   	ret    

00000600 <mkdir>:
SYSCALL(mkdir)
 600:	b8 14 00 00 00       	mov    $0x14,%eax
 605:	cd 40                	int    $0x40
 607:	c3                   	ret    

00000608 <chdir>:
SYSCALL(chdir)
 608:	b8 09 00 00 00       	mov    $0x9,%eax
 60d:	cd 40                	int    $0x40
 60f:	c3                   	ret    

00000610 <dup>:
SYSCALL(dup)
 610:	b8 0a 00 00 00       	mov    $0xa,%eax
 615:	cd 40                	int    $0x40
 617:	c3                   	ret    

00000618 <getpid>:
SYSCALL(getpid)
 618:	b8 0b 00 00 00       	mov    $0xb,%eax
 61d:	cd 40                	int    $0x40
 61f:	c3                   	ret    

00000620 <sbrk>:
SYSCALL(sbrk)
 620:	b8 0c 00 00 00       	mov    $0xc,%eax
 625:	cd 40                	int    $0x40
 627:	c3                   	ret    

00000628 <sleep>:
SYSCALL(sleep)
 628:	b8 0d 00 00 00       	mov    $0xd,%eax
 62d:	cd 40                	int    $0x40
 62f:	c3                   	ret    

00000630 <uptime>:
SYSCALL(uptime)
 630:	b8 0e 00 00 00       	mov    $0xe,%eax
 635:	cd 40                	int    $0x40
 637:	c3                   	ret    

00000638 <hello>:
SYSCALL(hello) 			// added for Lab0
 638:	b8 16 00 00 00       	mov    $0x16,%eax
 63d:	cd 40                	int    $0x40
 63f:	c3                   	ret    

00000640 <waitpid>:
SYSCALL(waitpid) 		// lab1 part 1: c
 640:	b8 17 00 00 00       	mov    $0x17,%eax
 645:	cd 40                	int    $0x40
 647:	c3                   	ret    

00000648 <setpriority>:
SYSCALL(setpriority) 	// lab1 part 2: define syscall
 648:	b8 18 00 00 00       	mov    $0x18,%eax
 64d:	cd 40                	int    $0x40
 64f:	c3                   	ret    

00000650 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 650:	55                   	push   %ebp
 651:	89 e5                	mov    %esp,%ebp
 653:	57                   	push   %edi
 654:	89 cf                	mov    %ecx,%edi
 656:	56                   	push   %esi
 657:	89 c6                	mov    %eax,%esi
 659:	53                   	push   %ebx
 65a:	83 ec 4c             	sub    $0x4c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 65d:	8b 4d 08             	mov    0x8(%ebp),%ecx
 660:	85 c9                	test   %ecx,%ecx
 662:	74 04                	je     668 <printint+0x18>
 664:	85 d2                	test   %edx,%edx
 666:	78 68                	js     6d0 <printint+0x80>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 668:	89 d0                	mov    %edx,%eax
 66a:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 671:	31 c9                	xor    %ecx,%ecx
 673:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 676:	66 90                	xchg   %ax,%ax
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
 678:	31 d2                	xor    %edx,%edx
 67a:	f7 f7                	div    %edi
 67c:	0f b6 92 97 0a 00 00 	movzbl 0xa97(%edx),%edx
 683:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
 686:	83 c1 01             	add    $0x1,%ecx
  }while((x /= base) != 0);
 689:	85 c0                	test   %eax,%eax
 68b:	75 eb                	jne    678 <printint+0x28>
  if(neg)
 68d:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 690:	85 c0                	test   %eax,%eax
 692:	74 08                	je     69c <printint+0x4c>
    buf[i++] = '-';
 694:	c6 44 0d d7 2d       	movb   $0x2d,-0x29(%ebp,%ecx,1)
 699:	83 c1 01             	add    $0x1,%ecx

  while(--i >= 0)
 69c:	8d 79 ff             	lea    -0x1(%ecx),%edi
 69f:	90                   	nop
 6a0:	0f b6 04 3b          	movzbl (%ebx,%edi,1),%eax
 6a4:	83 ef 01             	sub    $0x1,%edi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 6a7:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 6ae:	00 
 6af:	89 34 24             	mov    %esi,(%esp)
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 6b2:	88 45 e7             	mov    %al,-0x19(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 6b5:	8d 45 e7             	lea    -0x19(%ebp),%eax
 6b8:	89 44 24 04          	mov    %eax,0x4(%esp)
 6bc:	e8 f7 fe ff ff       	call   5b8 <write>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 6c1:	83 ff ff             	cmp    $0xffffffff,%edi
 6c4:	75 da                	jne    6a0 <printint+0x50>
    putc(fd, buf[i]);
}
 6c6:	83 c4 4c             	add    $0x4c,%esp
 6c9:	5b                   	pop    %ebx
 6ca:	5e                   	pop    %esi
 6cb:	5f                   	pop    %edi
 6cc:	5d                   	pop    %ebp
 6cd:	c3                   	ret    
 6ce:	66 90                	xchg   %ax,%ax
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 6d0:	89 d0                	mov    %edx,%eax
 6d2:	f7 d8                	neg    %eax
 6d4:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
 6db:	eb 94                	jmp    671 <printint+0x21>
 6dd:	8d 76 00             	lea    0x0(%esi),%esi

000006e0 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 6e0:	55                   	push   %ebp
 6e1:	89 e5                	mov    %esp,%ebp
 6e3:	57                   	push   %edi
 6e4:	56                   	push   %esi
 6e5:	53                   	push   %ebx
 6e6:	83 ec 3c             	sub    $0x3c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 6e9:	8b 45 0c             	mov    0xc(%ebp),%eax
 6ec:	0f b6 10             	movzbl (%eax),%edx
 6ef:	84 d2                	test   %dl,%dl
 6f1:	0f 84 c1 00 00 00    	je     7b8 <printf+0xd8>
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
 6f7:	8d 4d 10             	lea    0x10(%ebp),%ecx
 6fa:	31 ff                	xor    %edi,%edi
 6fc:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
 6ff:	31 db                	xor    %ebx,%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 701:	8d 75 e7             	lea    -0x19(%ebp),%esi
 704:	eb 1e                	jmp    724 <printf+0x44>
 706:	66 90                	xchg   %ax,%ax
  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 708:	83 fa 25             	cmp    $0x25,%edx
 70b:	0f 85 af 00 00 00    	jne    7c0 <printf+0xe0>
 711:	66 bf 25 00          	mov    $0x25,%di
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 715:	83 c3 01             	add    $0x1,%ebx
 718:	0f b6 14 18          	movzbl (%eax,%ebx,1),%edx
 71c:	84 d2                	test   %dl,%dl
 71e:	0f 84 94 00 00 00    	je     7b8 <printf+0xd8>
    c = fmt[i] & 0xff;
    if(state == 0){
 724:	85 ff                	test   %edi,%edi
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
 726:	0f b6 d2             	movzbl %dl,%edx
    if(state == 0){
 729:	74 dd                	je     708 <printf+0x28>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 72b:	83 ff 25             	cmp    $0x25,%edi
 72e:	75 e5                	jne    715 <printf+0x35>
      if(c == 'd'){
 730:	83 fa 64             	cmp    $0x64,%edx
 733:	0f 84 3f 01 00 00    	je     878 <printf+0x198>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 739:	83 fa 70             	cmp    $0x70,%edx
 73c:	0f 84 a6 00 00 00    	je     7e8 <printf+0x108>
 742:	83 fa 78             	cmp    $0x78,%edx
 745:	0f 84 9d 00 00 00    	je     7e8 <printf+0x108>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 74b:	83 fa 73             	cmp    $0x73,%edx
 74e:	66 90                	xchg   %ax,%ax
 750:	0f 84 ba 00 00 00    	je     810 <printf+0x130>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 756:	83 fa 63             	cmp    $0x63,%edx
 759:	0f 84 41 01 00 00    	je     8a0 <printf+0x1c0>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 75f:	83 fa 25             	cmp    $0x25,%edx
 762:	0f 84 00 01 00 00    	je     868 <printf+0x188>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 768:	8b 4d 08             	mov    0x8(%ebp),%ecx
 76b:	89 55 cc             	mov    %edx,-0x34(%ebp)
 76e:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 772:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 779:	00 
 77a:	89 74 24 04          	mov    %esi,0x4(%esp)
 77e:	89 0c 24             	mov    %ecx,(%esp)
 781:	e8 32 fe ff ff       	call   5b8 <write>
 786:	8b 55 cc             	mov    -0x34(%ebp),%edx
 789:	88 55 e7             	mov    %dl,-0x19(%ebp)
 78c:	8b 45 08             	mov    0x8(%ebp),%eax
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 78f:	83 c3 01             	add    $0x1,%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 792:	31 ff                	xor    %edi,%edi
 794:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 79b:	00 
 79c:	89 74 24 04          	mov    %esi,0x4(%esp)
 7a0:	89 04 24             	mov    %eax,(%esp)
 7a3:	e8 10 fe ff ff       	call   5b8 <write>
 7a8:	8b 45 0c             	mov    0xc(%ebp),%eax
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 7ab:	0f b6 14 18          	movzbl (%eax,%ebx,1),%edx
 7af:	84 d2                	test   %dl,%dl
 7b1:	0f 85 6d ff ff ff    	jne    724 <printf+0x44>
 7b7:	90                   	nop
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 7b8:	83 c4 3c             	add    $0x3c,%esp
 7bb:	5b                   	pop    %ebx
 7bc:	5e                   	pop    %esi
 7bd:	5f                   	pop    %edi
 7be:	5d                   	pop    %ebp
 7bf:	c3                   	ret    
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 7c0:	8b 45 08             	mov    0x8(%ebp),%eax
  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 7c3:	88 55 e7             	mov    %dl,-0x19(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 7c6:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 7cd:	00 
 7ce:	89 74 24 04          	mov    %esi,0x4(%esp)
 7d2:	89 04 24             	mov    %eax,(%esp)
 7d5:	e8 de fd ff ff       	call   5b8 <write>
 7da:	8b 45 0c             	mov    0xc(%ebp),%eax
 7dd:	e9 33 ff ff ff       	jmp    715 <printf+0x35>
 7e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 7e8:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 7eb:	b9 10 00 00 00       	mov    $0x10,%ecx
        ap++;
 7f0:	31 ff                	xor    %edi,%edi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 7f2:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 7f9:	8b 10                	mov    (%eax),%edx
 7fb:	8b 45 08             	mov    0x8(%ebp),%eax
 7fe:	e8 4d fe ff ff       	call   650 <printint>
 803:	8b 45 0c             	mov    0xc(%ebp),%eax
        ap++;
 806:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
 80a:	e9 06 ff ff ff       	jmp    715 <printf+0x35>
 80f:	90                   	nop
      } else if(c == 's'){
        s = (char*)*ap;
 810:	8b 55 d4             	mov    -0x2c(%ebp),%edx
        ap++;
        if(s == 0)
 813:	b9 90 0a 00 00       	mov    $0xa90,%ecx
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
        s = (char*)*ap;
 818:	8b 3a                	mov    (%edx),%edi
        ap++;
 81a:	83 c2 04             	add    $0x4,%edx
 81d:	89 55 d4             	mov    %edx,-0x2c(%ebp)
        if(s == 0)
 820:	85 ff                	test   %edi,%edi
 822:	0f 44 f9             	cmove  %ecx,%edi
          s = "(null)";
        while(*s != 0){
 825:	0f b6 17             	movzbl (%edi),%edx
 828:	84 d2                	test   %dl,%dl
 82a:	74 33                	je     85f <printf+0x17f>
 82c:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 82f:	8b 5d 08             	mov    0x8(%ebp),%ebx
 832:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
          putc(fd, *s);
          s++;
 838:	83 c7 01             	add    $0x1,%edi
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 83b:	88 55 e7             	mov    %dl,-0x19(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 83e:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 845:	00 
 846:	89 74 24 04          	mov    %esi,0x4(%esp)
 84a:	89 1c 24             	mov    %ebx,(%esp)
 84d:	e8 66 fd ff ff       	call   5b8 <write>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 852:	0f b6 17             	movzbl (%edi),%edx
 855:	84 d2                	test   %dl,%dl
 857:	75 df                	jne    838 <printf+0x158>
 859:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 85c:	8b 45 0c             	mov    0xc(%ebp),%eax
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 85f:	31 ff                	xor    %edi,%edi
 861:	e9 af fe ff ff       	jmp    715 <printf+0x35>
 866:	66 90                	xchg   %ax,%ax
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 868:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 86c:	e9 1b ff ff ff       	jmp    78c <printf+0xac>
 871:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 878:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 87b:	b9 0a 00 00 00       	mov    $0xa,%ecx
        ap++;
 880:	66 31 ff             	xor    %di,%di
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 883:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 88a:	8b 10                	mov    (%eax),%edx
 88c:	8b 45 08             	mov    0x8(%ebp),%eax
 88f:	e8 bc fd ff ff       	call   650 <printint>
 894:	8b 45 0c             	mov    0xc(%ebp),%eax
        ap++;
 897:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
 89b:	e9 75 fe ff ff       	jmp    715 <printf+0x35>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 8a0:	8b 55 d4             	mov    -0x2c(%ebp),%edx
        putc(fd, *ap);
        ap++;
 8a3:	31 ff                	xor    %edi,%edi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 8a5:	8b 4d 08             	mov    0x8(%ebp),%ecx
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 8a8:	8b 02                	mov    (%edx),%eax
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 8aa:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 8b1:	00 
 8b2:	89 74 24 04          	mov    %esi,0x4(%esp)
 8b6:	89 0c 24             	mov    %ecx,(%esp)
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 8b9:	88 45 e7             	mov    %al,-0x19(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 8bc:	e8 f7 fc ff ff       	call   5b8 <write>
 8c1:	8b 45 0c             	mov    0xc(%ebp),%eax
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
        ap++;
 8c4:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
 8c8:	e9 48 fe ff ff       	jmp    715 <printf+0x35>
 8cd:	90                   	nop
 8ce:	90                   	nop
 8cf:	90                   	nop

000008d0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 8d0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8d1:	a1 c0 0a 00 00       	mov    0xac0,%eax
static Header base;
static Header *freep;

void
free(void *ap)
{
 8d6:	89 e5                	mov    %esp,%ebp
 8d8:	57                   	push   %edi
 8d9:	56                   	push   %esi
 8da:	53                   	push   %ebx
 8db:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
 8de:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8e1:	39 c8                	cmp    %ecx,%eax
 8e3:	73 1d                	jae    902 <free+0x32>
 8e5:	8d 76 00             	lea    0x0(%esi),%esi
 8e8:	8b 10                	mov    (%eax),%edx
 8ea:	39 d1                	cmp    %edx,%ecx
 8ec:	72 1a                	jb     908 <free+0x38>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8ee:	39 d0                	cmp    %edx,%eax
 8f0:	72 08                	jb     8fa <free+0x2a>
 8f2:	39 c8                	cmp    %ecx,%eax
 8f4:	72 12                	jb     908 <free+0x38>
 8f6:	39 d1                	cmp    %edx,%ecx
 8f8:	72 0e                	jb     908 <free+0x38>
 8fa:	89 d0                	mov    %edx,%eax
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8fc:	39 c8                	cmp    %ecx,%eax
 8fe:	66 90                	xchg   %ax,%ax
 900:	72 e6                	jb     8e8 <free+0x18>
 902:	8b 10                	mov    (%eax),%edx
 904:	eb e8                	jmp    8ee <free+0x1e>
 906:	66 90                	xchg   %ax,%ax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 908:	8b 71 04             	mov    0x4(%ecx),%esi
 90b:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 90e:	39 d7                	cmp    %edx,%edi
 910:	74 19                	je     92b <free+0x5b>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 912:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 915:	8b 50 04             	mov    0x4(%eax),%edx
 918:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 91b:	39 ce                	cmp    %ecx,%esi
 91d:	74 23                	je     942 <free+0x72>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 91f:	89 08                	mov    %ecx,(%eax)
  freep = p;
 921:	a3 c0 0a 00 00       	mov    %eax,0xac0
}
 926:	5b                   	pop    %ebx
 927:	5e                   	pop    %esi
 928:	5f                   	pop    %edi
 929:	5d                   	pop    %ebp
 92a:	c3                   	ret    
  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 92b:	03 72 04             	add    0x4(%edx),%esi
 92e:	89 71 04             	mov    %esi,0x4(%ecx)
    bp->s.ptr = p->s.ptr->s.ptr;
 931:	8b 10                	mov    (%eax),%edx
 933:	8b 12                	mov    (%edx),%edx
 935:	89 53 f8             	mov    %edx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 938:	8b 50 04             	mov    0x4(%eax),%edx
 93b:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 93e:	39 ce                	cmp    %ecx,%esi
 940:	75 dd                	jne    91f <free+0x4f>
    p->s.size += bp->s.size;
 942:	03 51 04             	add    0x4(%ecx),%edx
 945:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 948:	8b 53 f8             	mov    -0x8(%ebx),%edx
 94b:	89 10                	mov    %edx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
 94d:	a3 c0 0a 00 00       	mov    %eax,0xac0
}
 952:	5b                   	pop    %ebx
 953:	5e                   	pop    %esi
 954:	5f                   	pop    %edi
 955:	5d                   	pop    %ebp
 956:	c3                   	ret    
 957:	89 f6                	mov    %esi,%esi
 959:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000960 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 960:	55                   	push   %ebp
 961:	89 e5                	mov    %esp,%ebp
 963:	57                   	push   %edi
 964:	56                   	push   %esi
 965:	53                   	push   %ebx
 966:	83 ec 2c             	sub    $0x2c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 969:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if((prevp = freep) == 0){
 96c:	8b 0d c0 0a 00 00    	mov    0xac0,%ecx
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 972:	83 c3 07             	add    $0x7,%ebx
 975:	c1 eb 03             	shr    $0x3,%ebx
 978:	83 c3 01             	add    $0x1,%ebx
  if((prevp = freep) == 0){
 97b:	85 c9                	test   %ecx,%ecx
 97d:	0f 84 9b 00 00 00    	je     a1e <malloc+0xbe>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 983:	8b 01                	mov    (%ecx),%eax
    if(p->s.size >= nunits){
 985:	8b 50 04             	mov    0x4(%eax),%edx
 988:	39 d3                	cmp    %edx,%ebx
 98a:	76 27                	jbe    9b3 <malloc+0x53>
        p->s.size -= nunits;
        p += p->s.size;
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
 98c:	8d 3c dd 00 00 00 00 	lea    0x0(,%ebx,8),%edi
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < 4096)
 993:	be 00 80 00 00       	mov    $0x8000,%esi
 998:	89 7d e4             	mov    %edi,-0x1c(%ebp)
 99b:	90                   	nop
 99c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 9a0:	3b 05 c0 0a 00 00    	cmp    0xac0,%eax
 9a6:	74 30                	je     9d8 <malloc+0x78>
 9a8:	89 c1                	mov    %eax,%ecx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 9aa:	8b 01                	mov    (%ecx),%eax
    if(p->s.size >= nunits){
 9ac:	8b 50 04             	mov    0x4(%eax),%edx
 9af:	39 d3                	cmp    %edx,%ebx
 9b1:	77 ed                	ja     9a0 <malloc+0x40>
      if(p->s.size == nunits)
 9b3:	39 d3                	cmp    %edx,%ebx
 9b5:	74 61                	je     a18 <malloc+0xb8>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 9b7:	29 da                	sub    %ebx,%edx
 9b9:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 9bc:	8d 04 d0             	lea    (%eax,%edx,8),%eax
        p->s.size = nunits;
 9bf:	89 58 04             	mov    %ebx,0x4(%eax)
      }
      freep = prevp;
 9c2:	89 0d c0 0a 00 00    	mov    %ecx,0xac0
      return (void*)(p + 1);
 9c8:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 9cb:	83 c4 2c             	add    $0x2c,%esp
 9ce:	5b                   	pop    %ebx
 9cf:	5e                   	pop    %esi
 9d0:	5f                   	pop    %edi
 9d1:	5d                   	pop    %ebp
 9d2:	c3                   	ret    
 9d3:	90                   	nop
 9d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < 4096)
 9d8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 9db:	81 fb 00 10 00 00    	cmp    $0x1000,%ebx
 9e1:	bf 00 10 00 00       	mov    $0x1000,%edi
 9e6:	0f 43 fb             	cmovae %ebx,%edi
 9e9:	0f 42 c6             	cmovb  %esi,%eax
    nu = 4096;
  p = sbrk(nu * sizeof(Header));
 9ec:	89 04 24             	mov    %eax,(%esp)
 9ef:	e8 2c fc ff ff       	call   620 <sbrk>
  if(p == (char*)-1)
 9f4:	83 f8 ff             	cmp    $0xffffffff,%eax
 9f7:	74 18                	je     a11 <malloc+0xb1>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
 9f9:	89 78 04             	mov    %edi,0x4(%eax)
  free((void*)(hp + 1));
 9fc:	83 c0 08             	add    $0x8,%eax
 9ff:	89 04 24             	mov    %eax,(%esp)
 a02:	e8 c9 fe ff ff       	call   8d0 <free>
  return freep;
 a07:	8b 0d c0 0a 00 00    	mov    0xac0,%ecx
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
 a0d:	85 c9                	test   %ecx,%ecx
 a0f:	75 99                	jne    9aa <malloc+0x4a>
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 a11:	31 c0                	xor    %eax,%eax
 a13:	eb b6                	jmp    9cb <malloc+0x6b>
 a15:	8d 76 00             	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
 a18:	8b 10                	mov    (%eax),%edx
 a1a:	89 11                	mov    %edx,(%ecx)
 a1c:	eb a4                	jmp    9c2 <malloc+0x62>
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 a1e:	c7 05 c0 0a 00 00 b8 	movl   $0xab8,0xac0
 a25:	0a 00 00 
    base.s.size = 0;
 a28:	b9 b8 0a 00 00       	mov    $0xab8,%ecx
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 a2d:	c7 05 b8 0a 00 00 b8 	movl   $0xab8,0xab8
 a34:	0a 00 00 
    base.s.size = 0;
 a37:	c7 05 bc 0a 00 00 00 	movl   $0x0,0xabc
 a3e:	00 00 00 
 a41:	e9 3d ff ff ff       	jmp    983 <malloc+0x23>
