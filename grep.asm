
_grep:     file format elf32-i386


Disassembly of section .text:

00001000 <matchstar>:
  return 0;
}

// matchstar: search for c*re at beginning of text
int matchstar(int c, char *re, char *text)
{
    1000:	55                   	push   %ebp
    1001:	89 e5                	mov    %esp,%ebp
    1003:	57                   	push   %edi
    1004:	56                   	push   %esi
    1005:	53                   	push   %ebx
    1006:	83 ec 1c             	sub    $0x1c,%esp
    1009:	8b 75 08             	mov    0x8(%ebp),%esi
    100c:	8b 7d 0c             	mov    0xc(%ebp),%edi
    100f:	8b 5d 10             	mov    0x10(%ebp),%ebx
    1012:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  do{  // a * matches zero or more instances
    if(matchhere(re, text))
    1018:	89 5c 24 04          	mov    %ebx,0x4(%esp)
    101c:	89 3c 24             	mov    %edi,(%esp)
    101f:	e8 3c 00 00 00       	call   1060 <matchhere>
    1024:	85 c0                	test   %eax,%eax
    1026:	75 20                	jne    1048 <matchstar+0x48>
      return 1;
  }while(*text!='\0' && (*text++==c || c=='.'));
    1028:	0f b6 03             	movzbl (%ebx),%eax
    102b:	84 c0                	test   %al,%al
    102d:	74 0f                	je     103e <matchstar+0x3e>
    102f:	0f be c0             	movsbl %al,%eax
    1032:	83 c3 01             	add    $0x1,%ebx
    1035:	39 f0                	cmp    %esi,%eax
    1037:	74 df                	je     1018 <matchstar+0x18>
    1039:	83 fe 2e             	cmp    $0x2e,%esi
    103c:	74 da                	je     1018 <matchstar+0x18>
  return 0;
}
    103e:	83 c4 1c             	add    $0x1c,%esp
int matchstar(int c, char *re, char *text)
{
  do{  // a * matches zero or more instances
    if(matchhere(re, text))
      return 1;
  }while(*text!='\0' && (*text++==c || c=='.'));
    1041:	31 c0                	xor    %eax,%eax
  return 0;
}
    1043:	5b                   	pop    %ebx
    1044:	5e                   	pop    %esi
    1045:	5f                   	pop    %edi
    1046:	5d                   	pop    %ebp
    1047:	c3                   	ret    
    1048:	83 c4 1c             	add    $0x1c,%esp

// matchstar: search for c*re at beginning of text
int matchstar(int c, char *re, char *text)
{
  do{  // a * matches zero or more instances
    if(matchhere(re, text))
    104b:	b8 01 00 00 00       	mov    $0x1,%eax
      return 1;
  }while(*text!='\0' && (*text++==c || c=='.'));
  return 0;
}
    1050:	5b                   	pop    %ebx
    1051:	5e                   	pop    %esi
    1052:	5f                   	pop    %edi
    1053:	5d                   	pop    %ebp
    1054:	c3                   	ret    
    1055:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1059:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001060 <matchhere>:
  return 0;
}

// matchhere: search for re at beginning of text
int matchhere(char *re, char *text)
{
    1060:	55                   	push   %ebp
    1061:	89 e5                	mov    %esp,%ebp
    1063:	56                   	push   %esi
    1064:	53                   	push   %ebx
    1065:	83 ec 10             	sub    $0x10,%esp
    1068:	8b 55 08             	mov    0x8(%ebp),%edx
    106b:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  if(re[0] == '\0')
    106e:	0f b6 02             	movzbl (%edx),%eax
    1071:	84 c0                	test   %al,%al
    1073:	75 1c                	jne    1091 <matchhere+0x31>
    1075:	eb 51                	jmp    10c8 <matchhere+0x68>
    1077:	90                   	nop
    return 1;
  if(re[1] == '*')
    return matchstar(re[0], re+2, text);
  if(re[0] == '$' && re[1] == '\0')
    return *text == '\0';
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
    1078:	0f b6 19             	movzbl (%ecx),%ebx
    107b:	84 db                	test   %bl,%bl
    107d:	74 39                	je     10b8 <matchhere+0x58>
    107f:	3c 2e                	cmp    $0x2e,%al
    1081:	74 04                	je     1087 <matchhere+0x27>
    1083:	38 d8                	cmp    %bl,%al
    1085:	75 31                	jne    10b8 <matchhere+0x58>
}

// matchhere: search for re at beginning of text
int matchhere(char *re, char *text)
{
  if(re[0] == '\0')
    1087:	0f b6 02             	movzbl (%edx),%eax
    108a:	84 c0                	test   %al,%al
    108c:	74 3a                	je     10c8 <matchhere+0x68>
  if(re[1] == '*')
    return matchstar(re[0], re+2, text);
  if(re[0] == '$' && re[1] == '\0')
    return *text == '\0';
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
    return matchhere(re+1, text+1);
    108e:	83 c1 01             	add    $0x1,%ecx
// matchhere: search for re at beginning of text
int matchhere(char *re, char *text)
{
  if(re[0] == '\0')
    return 1;
  if(re[1] == '*')
    1091:	0f b6 5a 01          	movzbl 0x1(%edx),%ebx
    1095:	8d 72 01             	lea    0x1(%edx),%esi
    1098:	80 fb 2a             	cmp    $0x2a,%bl
    109b:	74 3b                	je     10d8 <matchhere+0x78>
    return matchstar(re[0], re+2, text);
  if(re[0] == '$' && re[1] == '\0')
    109d:	3c 24                	cmp    $0x24,%al
int matchhere(char *re, char *text)
{
  if(re[0] == '\0')
    return 1;
  if(re[1] == '*')
    return matchstar(re[0], re+2, text);
    109f:	89 f2                	mov    %esi,%edx
  if(re[0] == '$' && re[1] == '\0')
    10a1:	75 d5                	jne    1078 <matchhere+0x18>
    10a3:	84 db                	test   %bl,%bl
    10a5:	75 d1                	jne    1078 <matchhere+0x18>
    return *text == '\0';
    10a7:	31 c0                	xor    %eax,%eax
    10a9:	80 39 00             	cmpb   $0x0,(%ecx)
    10ac:	0f 94 c0             	sete   %al
    10af:	eb 09                	jmp    10ba <matchhere+0x5a>
    10b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
}

// matchhere: search for re at beginning of text
int matchhere(char *re, char *text)
{
  if(re[0] == '\0')
    10b8:	31 c0                	xor    %eax,%eax
  if(re[0] == '$' && re[1] == '\0')
    return *text == '\0';
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
    return matchhere(re+1, text+1);
  return 0;
}
    10ba:	83 c4 10             	add    $0x10,%esp
    10bd:	5b                   	pop    %ebx
    10be:	5e                   	pop    %esi
    10bf:	5d                   	pop    %ebp
    10c0:	c3                   	ret    
    10c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    10c8:	83 c4 10             	add    $0x10,%esp
}

// matchhere: search for re at beginning of text
int matchhere(char *re, char *text)
{
  if(re[0] == '\0')
    10cb:	b8 01 00 00 00       	mov    $0x1,%eax
  if(re[0] == '$' && re[1] == '\0')
    return *text == '\0';
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
    return matchhere(re+1, text+1);
  return 0;
}
    10d0:	5b                   	pop    %ebx
    10d1:	5e                   	pop    %esi
    10d2:	5d                   	pop    %ebp
    10d3:	c3                   	ret    
    10d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
int matchhere(char *re, char *text)
{
  if(re[0] == '\0')
    return 1;
  if(re[1] == '*')
    return matchstar(re[0], re+2, text);
    10d8:	83 c2 02             	add    $0x2,%edx
    10db:	0f be c0             	movsbl %al,%eax
    10de:	89 4c 24 08          	mov    %ecx,0x8(%esp)
    10e2:	89 54 24 04          	mov    %edx,0x4(%esp)
    10e6:	89 04 24             	mov    %eax,(%esp)
    10e9:	e8 12 ff ff ff       	call   1000 <matchstar>
  if(re[0] == '$' && re[1] == '\0')
    return *text == '\0';
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
    return matchhere(re+1, text+1);
  return 0;
}
    10ee:	83 c4 10             	add    $0x10,%esp
    10f1:	5b                   	pop    %ebx
    10f2:	5e                   	pop    %esi
    10f3:	5d                   	pop    %ebp
    10f4:	c3                   	ret    
    10f5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    10f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001100 <match>:
int matchhere(char*, char*);
int matchstar(int, char*, char*);

int
match(char *re, char *text)
{
    1100:	55                   	push   %ebp
    1101:	89 e5                	mov    %esp,%ebp
    1103:	56                   	push   %esi
    1104:	53                   	push   %ebx
    1105:	83 ec 10             	sub    $0x10,%esp
    1108:	8b 75 08             	mov    0x8(%ebp),%esi
    110b:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  if(re[0] == '^')
    110e:	80 3e 5e             	cmpb   $0x5e,(%esi)
    1111:	75 08                	jne    111b <match+0x1b>
    1113:	eb 2f                	jmp    1144 <match+0x44>
    1115:	8d 76 00             	lea    0x0(%esi),%esi
    return matchhere(re+1, text);
  do{  // must look at empty string
    if(matchhere(re, text))
      return 1;
  }while(*text++ != '\0');
    1118:	83 c3 01             	add    $0x1,%ebx
match(char *re, char *text)
{
  if(re[0] == '^')
    return matchhere(re+1, text);
  do{  // must look at empty string
    if(matchhere(re, text))
    111b:	89 5c 24 04          	mov    %ebx,0x4(%esp)
    111f:	89 34 24             	mov    %esi,(%esp)
    1122:	e8 39 ff ff ff       	call   1060 <matchhere>
    1127:	85 c0                	test   %eax,%eax
    1129:	75 0d                	jne    1138 <match+0x38>
      return 1;
  }while(*text++ != '\0');
    112b:	80 3b 00             	cmpb   $0x0,(%ebx)
    112e:	75 e8                	jne    1118 <match+0x18>
  return 0;
}
    1130:	83 c4 10             	add    $0x10,%esp
    1133:	5b                   	pop    %ebx
    1134:	5e                   	pop    %esi
    1135:	5d                   	pop    %ebp
    1136:	c3                   	ret    
    1137:	90                   	nop
    1138:	83 c4 10             	add    $0x10,%esp
  if(re[0] == '^')
    return matchhere(re+1, text);
  do{  // must look at empty string
    if(matchhere(re, text))
      return 1;
  }while(*text++ != '\0');
    113b:	b8 01 00 00 00       	mov    $0x1,%eax
  return 0;
}
    1140:	5b                   	pop    %ebx
    1141:	5e                   	pop    %esi
    1142:	5d                   	pop    %ebp
    1143:	c3                   	ret    

int
match(char *re, char *text)
{
  if(re[0] == '^')
    return matchhere(re+1, text);
    1144:	83 c6 01             	add    $0x1,%esi
    1147:	89 75 08             	mov    %esi,0x8(%ebp)
  do{  // must look at empty string
    if(matchhere(re, text))
      return 1;
  }while(*text++ != '\0');
  return 0;
}
    114a:	83 c4 10             	add    $0x10,%esp
    114d:	5b                   	pop    %ebx
    114e:	5e                   	pop    %esi
    114f:	5d                   	pop    %ebp

int
match(char *re, char *text)
{
  if(re[0] == '^')
    return matchhere(re+1, text);
    1150:	e9 0b ff ff ff       	jmp    1060 <matchhere>
    1155:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1159:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001160 <grep>:
char buf[1024];
int match(char*, char*);

void
grep(char *pattern, int fd)
{
    1160:	55                   	push   %ebp
    1161:	89 e5                	mov    %esp,%ebp
    1163:	57                   	push   %edi
    1164:	56                   	push   %esi
    1165:	53                   	push   %ebx
    1166:	83 ec 2c             	sub    $0x2c,%esp
    1169:	8b 7d 08             	mov    0x8(%ebp),%edi
    116c:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    1173:	90                   	nop
    1174:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  int n, m;
  char *p, *q;

  m = 0;
  while((n = read(fd, buf+m, sizeof(buf)-m-1)) > 0){
    1178:	b8 ff 03 00 00       	mov    $0x3ff,%eax
    117d:	2b 45 e4             	sub    -0x1c(%ebp),%eax
    1180:	89 44 24 08          	mov    %eax,0x8(%esp)
    1184:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1187:	05 c0 1a 00 00       	add    $0x1ac0,%eax
    118c:	89 44 24 04          	mov    %eax,0x4(%esp)
    1190:	8b 45 0c             	mov    0xc(%ebp),%eax
    1193:	89 04 24             	mov    %eax,(%esp)
    1196:	e8 05 04 00 00       	call   15a0 <read>
    119b:	85 c0                	test   %eax,%eax
    119d:	0f 8e b9 00 00 00    	jle    125c <grep+0xfc>
    m += n;
    11a3:	01 45 e4             	add    %eax,-0x1c(%ebp)
    buf[m] = '\0';
    11a6:	be c0 1a 00 00       	mov    $0x1ac0,%esi
    11ab:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    11ae:	c6 80 c0 1a 00 00 00 	movb   $0x0,0x1ac0(%eax)
    11b5:	8d 76 00             	lea    0x0(%esi),%esi
    p = buf;
    while((q = strchr(p, '\n')) != 0){
    11b8:	c7 44 24 04 0a 00 00 	movl   $0xa,0x4(%esp)
    11bf:	00 
    11c0:	89 34 24             	mov    %esi,(%esp)
    11c3:	e8 58 02 00 00       	call   1420 <strchr>
    11c8:	85 c0                	test   %eax,%eax
    11ca:	89 c3                	mov    %eax,%ebx
    11cc:	74 42                	je     1210 <grep+0xb0>
      *q = 0;
    11ce:	c6 03 00             	movb   $0x0,(%ebx)
      if(match(pattern, p)){
    11d1:	89 74 24 04          	mov    %esi,0x4(%esp)
    11d5:	89 3c 24             	mov    %edi,(%esp)
    11d8:	e8 23 ff ff ff       	call   1100 <match>
    11dd:	85 c0                	test   %eax,%eax
    11df:	75 07                	jne    11e8 <grep+0x88>
    11e1:	83 c3 01             	add    $0x1,%ebx
        *q = '\n';
        write(1, p, q+1 - p);
    11e4:	89 de                	mov    %ebx,%esi
    11e6:	eb d0                	jmp    11b8 <grep+0x58>
    buf[m] = '\0';
    p = buf;
    while((q = strchr(p, '\n')) != 0){
      *q = 0;
      if(match(pattern, p)){
        *q = '\n';
    11e8:	c6 03 0a             	movb   $0xa,(%ebx)
        write(1, p, q+1 - p);
    11eb:	83 c3 01             	add    $0x1,%ebx
    11ee:	89 d8                	mov    %ebx,%eax
    11f0:	29 f0                	sub    %esi,%eax
    11f2:	89 74 24 04          	mov    %esi,0x4(%esp)
    11f6:	89 de                	mov    %ebx,%esi
    11f8:	89 44 24 08          	mov    %eax,0x8(%esp)
    11fc:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1203:	e8 a0 03 00 00       	call   15a8 <write>
    1208:	eb ae                	jmp    11b8 <grep+0x58>
    120a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      }
      p = q+1;
    }
    if(p == buf)
    1210:	81 fe c0 1a 00 00    	cmp    $0x1ac0,%esi
    1216:	74 38                	je     1250 <grep+0xf0>
      m = 0;
    if(m > 0){
    1218:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    121b:	85 c0                	test   %eax,%eax
    121d:	0f 8e 55 ff ff ff    	jle    1178 <grep+0x18>
      m -= p - buf;
    1223:	81 45 e4 c0 1a 00 00 	addl   $0x1ac0,-0x1c(%ebp)
    122a:	29 75 e4             	sub    %esi,-0x1c(%ebp)
      memmove(buf, p, m);
    122d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1230:	89 74 24 04          	mov    %esi,0x4(%esp)
    1234:	c7 04 24 c0 1a 00 00 	movl   $0x1ac0,(%esp)
    123b:	89 44 24 08          	mov    %eax,0x8(%esp)
    123f:	e8 5c 02 00 00       	call   14a0 <memmove>
    1244:	e9 2f ff ff ff       	jmp    1178 <grep+0x18>
    1249:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    1250:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    1257:	e9 1c ff ff ff       	jmp    1178 <grep+0x18>
    }
  }
}
    125c:	83 c4 2c             	add    $0x2c,%esp
    125f:	5b                   	pop    %ebx
    1260:	5e                   	pop    %esi
    1261:	5f                   	pop    %edi
    1262:	5d                   	pop    %ebp
    1263:	c3                   	ret    
    1264:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    126a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00001270 <main>:

int
main(int argc, char *argv[])
{
    1270:	55                   	push   %ebp
    1271:	89 e5                	mov    %esp,%ebp
    1273:	83 e4 f0             	and    $0xfffffff0,%esp
    1276:	57                   	push   %edi
    1277:	56                   	push   %esi
    1278:	53                   	push   %ebx
    1279:	83 ec 24             	sub    $0x24,%esp
    127c:	8b 7d 08             	mov    0x8(%ebp),%edi
    127f:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  int fd, i;
  char *pattern;

  if(argc <= 1){
    1282:	83 ff 01             	cmp    $0x1,%edi
    1285:	0f 8e b5 00 00 00    	jle    1340 <main+0xd0>
    printf(2, "usage: grep pattern [file ...]\n");
    exit(0);
  }
  pattern = argv[1];
    128b:	8b 43 04             	mov    0x4(%ebx),%eax

  if(argc <= 2){
    128e:	83 ff 02             	cmp    $0x2,%edi

  if(argc <= 1){
    printf(2, "usage: grep pattern [file ...]\n");
    exit(0);
  }
  pattern = argv[1];
    1291:	89 44 24 1c          	mov    %eax,0x1c(%esp)

  if(argc <= 2){
    1295:	0f 84 85 00 00 00    	je     1320 <main+0xb0>
    grep(pattern, 0);
    exit(0);
    129b:	83 c3 08             	add    $0x8,%ebx
    129e:	be 02 00 00 00       	mov    $0x2,%esi
    12a3:	90                   	nop
    12a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  }

  for(i = 2; i < argc; i++){
    if((fd = open(argv[i], 0)) < 0){
    12a8:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    12af:	00 
    12b0:	8b 03                	mov    (%ebx),%eax
    12b2:	89 04 24             	mov    %eax,(%esp)
    12b5:	e8 0e 03 00 00       	call   15c8 <open>
    12ba:	85 c0                	test   %eax,%eax
    12bc:	78 3a                	js     12f8 <main+0x88>
      printf(1, "grep: cannot open %s\n", argv[i]);
      exit(0);
    }
    grep(pattern, fd);
    12be:	8b 54 24 1c          	mov    0x1c(%esp),%edx
  if(argc <= 2){
    grep(pattern, 0);
    exit(0);
  }

  for(i = 2; i < argc; i++){
    12c2:	83 c6 01             	add    $0x1,%esi
    12c5:	83 c3 04             	add    $0x4,%ebx
    if((fd = open(argv[i], 0)) < 0){
      printf(1, "grep: cannot open %s\n", argv[i]);
      exit(0);
    }
    grep(pattern, fd);
    12c8:	89 44 24 04          	mov    %eax,0x4(%esp)
    12cc:	89 44 24 18          	mov    %eax,0x18(%esp)
    12d0:	89 14 24             	mov    %edx,(%esp)
    12d3:	e8 88 fe ff ff       	call   1160 <grep>
    close(fd);
    12d8:	8b 44 24 18          	mov    0x18(%esp),%eax
    12dc:	89 04 24             	mov    %eax,(%esp)
    12df:	e8 cc 02 00 00       	call   15b0 <close>
  if(argc <= 2){
    grep(pattern, 0);
    exit(0);
  }

  for(i = 2; i < argc; i++){
    12e4:	39 f7                	cmp    %esi,%edi
    12e6:	7f c0                	jg     12a8 <main+0x38>
      exit(0);
    }
    grep(pattern, fd);
    close(fd);
  }
  exit(0);
    12e8:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    12ef:	e8 94 02 00 00       	call   1588 <exit>
    12f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    exit(0);
  }

  for(i = 2; i < argc; i++){
    if((fd = open(argv[i], 0)) < 0){
      printf(1, "grep: cannot open %s\n", argv[i]);
    12f8:	8b 03                	mov    (%ebx),%eax
    12fa:	c7 44 24 04 68 1a 00 	movl   $0x1a68,0x4(%esp)
    1301:	00 
    1302:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1309:	89 44 24 08          	mov    %eax,0x8(%esp)
    130d:	e8 ce 03 00 00       	call   16e0 <printf>
      exit(0);
    1312:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1319:	e8 6a 02 00 00       	call   1588 <exit>
    131e:	66 90                	xchg   %ax,%ax
    exit(0);
  }
  pattern = argv[1];

  if(argc <= 2){
    grep(pattern, 0);
    1320:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1327:	00 
    1328:	89 04 24             	mov    %eax,(%esp)
    132b:	e8 30 fe ff ff       	call   1160 <grep>
    exit(0);
    1330:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1337:	e8 4c 02 00 00       	call   1588 <exit>
    133c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
{
  int fd, i;
  char *pattern;

  if(argc <= 1){
    printf(2, "usage: grep pattern [file ...]\n");
    1340:	c7 44 24 04 48 1a 00 	movl   $0x1a48,0x4(%esp)
    1347:	00 
    1348:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
    134f:	e8 8c 03 00 00       	call   16e0 <printf>
    exit(0);
    1354:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    135b:	e8 28 02 00 00       	call   1588 <exit>

00001360 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
    1360:	55                   	push   %ebp
    1361:	31 d2                	xor    %edx,%edx
    1363:	89 e5                	mov    %esp,%ebp
    1365:	8b 45 08             	mov    0x8(%ebp),%eax
    1368:	53                   	push   %ebx
    1369:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    136c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
    1370:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
    1374:	88 0c 10             	mov    %cl,(%eax,%edx,1)
    1377:	83 c2 01             	add    $0x1,%edx
    137a:	84 c9                	test   %cl,%cl
    137c:	75 f2                	jne    1370 <strcpy+0x10>
    ;
  return os;
}
    137e:	5b                   	pop    %ebx
    137f:	5d                   	pop    %ebp
    1380:	c3                   	ret    
    1381:	eb 0d                	jmp    1390 <strcmp>
    1383:	90                   	nop
    1384:	90                   	nop
    1385:	90                   	nop
    1386:	90                   	nop
    1387:	90                   	nop
    1388:	90                   	nop
    1389:	90                   	nop
    138a:	90                   	nop
    138b:	90                   	nop
    138c:	90                   	nop
    138d:	90                   	nop
    138e:	90                   	nop
    138f:	90                   	nop

00001390 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    1390:	55                   	push   %ebp
    1391:	89 e5                	mov    %esp,%ebp
    1393:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1396:	53                   	push   %ebx
    1397:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(*p && *p == *q)
    139a:	0f b6 01             	movzbl (%ecx),%eax
    139d:	84 c0                	test   %al,%al
    139f:	75 14                	jne    13b5 <strcmp+0x25>
    13a1:	eb 25                	jmp    13c8 <strcmp+0x38>
    13a3:	90                   	nop
    13a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    p++, q++;
    13a8:	83 c1 01             	add    $0x1,%ecx
    13ab:	83 c2 01             	add    $0x1,%edx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
    13ae:	0f b6 01             	movzbl (%ecx),%eax
    13b1:	84 c0                	test   %al,%al
    13b3:	74 13                	je     13c8 <strcmp+0x38>
    13b5:	0f b6 1a             	movzbl (%edx),%ebx
    13b8:	38 d8                	cmp    %bl,%al
    13ba:	74 ec                	je     13a8 <strcmp+0x18>
    13bc:	0f b6 db             	movzbl %bl,%ebx
    13bf:	0f b6 c0             	movzbl %al,%eax
    13c2:	29 d8                	sub    %ebx,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
    13c4:	5b                   	pop    %ebx
    13c5:	5d                   	pop    %ebp
    13c6:	c3                   	ret    
    13c7:	90                   	nop
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
    13c8:	0f b6 1a             	movzbl (%edx),%ebx
    13cb:	31 c0                	xor    %eax,%eax
    13cd:	0f b6 db             	movzbl %bl,%ebx
    13d0:	29 d8                	sub    %ebx,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
    13d2:	5b                   	pop    %ebx
    13d3:	5d                   	pop    %ebp
    13d4:	c3                   	ret    
    13d5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    13d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000013e0 <strlen>:

uint
strlen(char *s)
{
    13e0:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
    13e1:	31 d2                	xor    %edx,%edx
  return (uchar)*p - (uchar)*q;
}

uint
strlen(char *s)
{
    13e3:	89 e5                	mov    %esp,%ebp
  int n;

  for(n = 0; s[n]; n++)
    13e5:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
}

uint
strlen(char *s)
{
    13e7:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
    13ea:	80 39 00             	cmpb   $0x0,(%ecx)
    13ed:	74 0c                	je     13fb <strlen+0x1b>
    13ef:	90                   	nop
    13f0:	83 c2 01             	add    $0x1,%edx
    13f3:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
    13f7:	89 d0                	mov    %edx,%eax
    13f9:	75 f5                	jne    13f0 <strlen+0x10>
    ;
  return n;
}
    13fb:	5d                   	pop    %ebp
    13fc:	c3                   	ret    
    13fd:	8d 76 00             	lea    0x0(%esi),%esi

00001400 <memset>:

void*
memset(void *dst, int c, uint n)
{
    1400:	55                   	push   %ebp
    1401:	89 e5                	mov    %esp,%ebp
    1403:	8b 55 08             	mov    0x8(%ebp),%edx
    1406:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
    1407:	8b 4d 10             	mov    0x10(%ebp),%ecx
    140a:	8b 45 0c             	mov    0xc(%ebp),%eax
    140d:	89 d7                	mov    %edx,%edi
    140f:	fc                   	cld    
    1410:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
    1412:	89 d0                	mov    %edx,%eax
    1414:	5f                   	pop    %edi
    1415:	5d                   	pop    %ebp
    1416:	c3                   	ret    
    1417:	89 f6                	mov    %esi,%esi
    1419:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001420 <strchr>:

char*
strchr(const char *s, char c)
{
    1420:	55                   	push   %ebp
    1421:	89 e5                	mov    %esp,%ebp
    1423:	8b 45 08             	mov    0x8(%ebp),%eax
    1426:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
    142a:	0f b6 10             	movzbl (%eax),%edx
    142d:	84 d2                	test   %dl,%dl
    142f:	75 11                	jne    1442 <strchr+0x22>
    1431:	eb 15                	jmp    1448 <strchr+0x28>
    1433:	90                   	nop
    1434:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1438:	83 c0 01             	add    $0x1,%eax
    143b:	0f b6 10             	movzbl (%eax),%edx
    143e:	84 d2                	test   %dl,%dl
    1440:	74 06                	je     1448 <strchr+0x28>
    if(*s == c)
    1442:	38 ca                	cmp    %cl,%dl
    1444:	75 f2                	jne    1438 <strchr+0x18>
      return (char*)s;
  return 0;
}
    1446:	5d                   	pop    %ebp
    1447:	c3                   	ret    
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
    1448:	31 c0                	xor    %eax,%eax
    if(*s == c)
      return (char*)s;
  return 0;
}
    144a:	5d                   	pop    %ebp
    144b:	90                   	nop
    144c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1450:	c3                   	ret    
    1451:	eb 0d                	jmp    1460 <atoi>
    1453:	90                   	nop
    1454:	90                   	nop
    1455:	90                   	nop
    1456:	90                   	nop
    1457:	90                   	nop
    1458:	90                   	nop
    1459:	90                   	nop
    145a:	90                   	nop
    145b:	90                   	nop
    145c:	90                   	nop
    145d:	90                   	nop
    145e:	90                   	nop
    145f:	90                   	nop

00001460 <atoi>:
  return r;
}

int
atoi(const char *s)
{
    1460:	55                   	push   %ebp
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    1461:	31 c0                	xor    %eax,%eax
  return r;
}

int
atoi(const char *s)
{
    1463:	89 e5                	mov    %esp,%ebp
    1465:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1468:	53                   	push   %ebx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    1469:	0f b6 11             	movzbl (%ecx),%edx
    146c:	8d 5a d0             	lea    -0x30(%edx),%ebx
    146f:	80 fb 09             	cmp    $0x9,%bl
    1472:	77 1c                	ja     1490 <atoi+0x30>
    1474:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    n = n*10 + *s++ - '0';
    1478:	0f be d2             	movsbl %dl,%edx
    147b:	83 c1 01             	add    $0x1,%ecx
    147e:	8d 04 80             	lea    (%eax,%eax,4),%eax
    1481:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    1485:	0f b6 11             	movzbl (%ecx),%edx
    1488:	8d 5a d0             	lea    -0x30(%edx),%ebx
    148b:	80 fb 09             	cmp    $0x9,%bl
    148e:	76 e8                	jbe    1478 <atoi+0x18>
    n = n*10 + *s++ - '0';
  return n;
}
    1490:	5b                   	pop    %ebx
    1491:	5d                   	pop    %ebp
    1492:	c3                   	ret    
    1493:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    1499:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000014a0 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
    14a0:	55                   	push   %ebp
    14a1:	89 e5                	mov    %esp,%ebp
    14a3:	56                   	push   %esi
    14a4:	8b 45 08             	mov    0x8(%ebp),%eax
    14a7:	53                   	push   %ebx
    14a8:	8b 5d 10             	mov    0x10(%ebp),%ebx
    14ab:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    14ae:	85 db                	test   %ebx,%ebx
    14b0:	7e 14                	jle    14c6 <memmove+0x26>
    n = n*10 + *s++ - '0';
  return n;
}

void*
memmove(void *vdst, void *vsrc, int n)
    14b2:	31 d2                	xor    %edx,%edx
    14b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    *dst++ = *src++;
    14b8:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
    14bc:	88 0c 10             	mov    %cl,(%eax,%edx,1)
    14bf:	83 c2 01             	add    $0x1,%edx
{
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    14c2:	39 da                	cmp    %ebx,%edx
    14c4:	75 f2                	jne    14b8 <memmove+0x18>
    *dst++ = *src++;
  return vdst;
}
    14c6:	5b                   	pop    %ebx
    14c7:	5e                   	pop    %esi
    14c8:	5d                   	pop    %ebp
    14c9:	c3                   	ret    
    14ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000014d0 <stat>:
  return buf;
}

int
stat(char *n, struct stat *st)
{
    14d0:	55                   	push   %ebp
    14d1:	89 e5                	mov    %esp,%ebp
    14d3:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    14d6:	8b 45 08             	mov    0x8(%ebp),%eax
  return buf;
}

int
stat(char *n, struct stat *st)
{
    14d9:	89 5d f8             	mov    %ebx,-0x8(%ebp)
    14dc:	89 75 fc             	mov    %esi,-0x4(%ebp)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    14df:	be ff ff ff ff       	mov    $0xffffffff,%esi
stat(char *n, struct stat *st)
{
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    14e4:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    14eb:	00 
    14ec:	89 04 24             	mov    %eax,(%esp)
    14ef:	e8 d4 00 00 00       	call   15c8 <open>
  if(fd < 0)
    14f4:	85 c0                	test   %eax,%eax
stat(char *n, struct stat *st)
{
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    14f6:	89 c3                	mov    %eax,%ebx
  if(fd < 0)
    14f8:	78 19                	js     1513 <stat+0x43>
    return -1;
  r = fstat(fd, st);
    14fa:	8b 45 0c             	mov    0xc(%ebp),%eax
    14fd:	89 1c 24             	mov    %ebx,(%esp)
    1500:	89 44 24 04          	mov    %eax,0x4(%esp)
    1504:	e8 d7 00 00 00       	call   15e0 <fstat>
  close(fd);
    1509:	89 1c 24             	mov    %ebx,(%esp)
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
  r = fstat(fd, st);
    150c:	89 c6                	mov    %eax,%esi
  close(fd);
    150e:	e8 9d 00 00 00       	call   15b0 <close>
  return r;
}
    1513:	89 f0                	mov    %esi,%eax
    1515:	8b 5d f8             	mov    -0x8(%ebp),%ebx
    1518:	8b 75 fc             	mov    -0x4(%ebp),%esi
    151b:	89 ec                	mov    %ebp,%esp
    151d:	5d                   	pop    %ebp
    151e:	c3                   	ret    
    151f:	90                   	nop

00001520 <gets>:
  return 0;
}

char*
gets(char *buf, int max)
{
    1520:	55                   	push   %ebp
    1521:	89 e5                	mov    %esp,%ebp
    1523:	57                   	push   %edi
    1524:	56                   	push   %esi
    1525:	31 f6                	xor    %esi,%esi
    1527:	53                   	push   %ebx
    1528:	83 ec 2c             	sub    $0x2c,%esp
    152b:	8b 7d 08             	mov    0x8(%ebp),%edi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    152e:	eb 06                	jmp    1536 <gets+0x16>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
    1530:	3c 0a                	cmp    $0xa,%al
    1532:	74 39                	je     156d <gets+0x4d>
    1534:	89 de                	mov    %ebx,%esi
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    1536:	8d 5e 01             	lea    0x1(%esi),%ebx
    1539:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
    153c:	7d 31                	jge    156f <gets+0x4f>
    cc = read(0, &c, 1);
    153e:	8d 45 e7             	lea    -0x19(%ebp),%eax
    1541:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    1548:	00 
    1549:	89 44 24 04          	mov    %eax,0x4(%esp)
    154d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1554:	e8 47 00 00 00       	call   15a0 <read>
    if(cc < 1)
    1559:	85 c0                	test   %eax,%eax
    155b:	7e 12                	jle    156f <gets+0x4f>
      break;
    buf[i++] = c;
    155d:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
    1561:	88 44 1f ff          	mov    %al,-0x1(%edi,%ebx,1)
    if(c == '\n' || c == '\r')
    1565:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
    1569:	3c 0d                	cmp    $0xd,%al
    156b:	75 c3                	jne    1530 <gets+0x10>
    156d:	89 de                	mov    %ebx,%esi
      break;
  }
  buf[i] = '\0';
    156f:	c6 04 37 00          	movb   $0x0,(%edi,%esi,1)
  return buf;
}
    1573:	89 f8                	mov    %edi,%eax
    1575:	83 c4 2c             	add    $0x2c,%esp
    1578:	5b                   	pop    %ebx
    1579:	5e                   	pop    %esi
    157a:	5f                   	pop    %edi
    157b:	5d                   	pop    %ebp
    157c:	c3                   	ret    
    157d:	90                   	nop
    157e:	90                   	nop
    157f:	90                   	nop

00001580 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    1580:	b8 01 00 00 00       	mov    $0x1,%eax
    1585:	cd 40                	int    $0x40
    1587:	c3                   	ret    

00001588 <exit>:
SYSCALL(exit)
    1588:	b8 02 00 00 00       	mov    $0x2,%eax
    158d:	cd 40                	int    $0x40
    158f:	c3                   	ret    

00001590 <wait>:
SYSCALL(wait)
    1590:	b8 03 00 00 00       	mov    $0x3,%eax
    1595:	cd 40                	int    $0x40
    1597:	c3                   	ret    

00001598 <pipe>:
SYSCALL(pipe)
    1598:	b8 04 00 00 00       	mov    $0x4,%eax
    159d:	cd 40                	int    $0x40
    159f:	c3                   	ret    

000015a0 <read>:
SYSCALL(read)
    15a0:	b8 05 00 00 00       	mov    $0x5,%eax
    15a5:	cd 40                	int    $0x40
    15a7:	c3                   	ret    

000015a8 <write>:
SYSCALL(write)
    15a8:	b8 10 00 00 00       	mov    $0x10,%eax
    15ad:	cd 40                	int    $0x40
    15af:	c3                   	ret    

000015b0 <close>:
SYSCALL(close)
    15b0:	b8 15 00 00 00       	mov    $0x15,%eax
    15b5:	cd 40                	int    $0x40
    15b7:	c3                   	ret    

000015b8 <kill>:
SYSCALL(kill)
    15b8:	b8 06 00 00 00       	mov    $0x6,%eax
    15bd:	cd 40                	int    $0x40
    15bf:	c3                   	ret    

000015c0 <exec>:
SYSCALL(exec)
    15c0:	b8 07 00 00 00       	mov    $0x7,%eax
    15c5:	cd 40                	int    $0x40
    15c7:	c3                   	ret    

000015c8 <open>:
SYSCALL(open)
    15c8:	b8 0f 00 00 00       	mov    $0xf,%eax
    15cd:	cd 40                	int    $0x40
    15cf:	c3                   	ret    

000015d0 <mknod>:
SYSCALL(mknod)
    15d0:	b8 11 00 00 00       	mov    $0x11,%eax
    15d5:	cd 40                	int    $0x40
    15d7:	c3                   	ret    

000015d8 <unlink>:
SYSCALL(unlink)
    15d8:	b8 12 00 00 00       	mov    $0x12,%eax
    15dd:	cd 40                	int    $0x40
    15df:	c3                   	ret    

000015e0 <fstat>:
SYSCALL(fstat)
    15e0:	b8 08 00 00 00       	mov    $0x8,%eax
    15e5:	cd 40                	int    $0x40
    15e7:	c3                   	ret    

000015e8 <link>:
SYSCALL(link)
    15e8:	b8 13 00 00 00       	mov    $0x13,%eax
    15ed:	cd 40                	int    $0x40
    15ef:	c3                   	ret    

000015f0 <mkdir>:
SYSCALL(mkdir)
    15f0:	b8 14 00 00 00       	mov    $0x14,%eax
    15f5:	cd 40                	int    $0x40
    15f7:	c3                   	ret    

000015f8 <chdir>:
SYSCALL(chdir)
    15f8:	b8 09 00 00 00       	mov    $0x9,%eax
    15fd:	cd 40                	int    $0x40
    15ff:	c3                   	ret    

00001600 <dup>:
SYSCALL(dup)
    1600:	b8 0a 00 00 00       	mov    $0xa,%eax
    1605:	cd 40                	int    $0x40
    1607:	c3                   	ret    

00001608 <getpid>:
SYSCALL(getpid)
    1608:	b8 0b 00 00 00       	mov    $0xb,%eax
    160d:	cd 40                	int    $0x40
    160f:	c3                   	ret    

00001610 <sbrk>:
SYSCALL(sbrk)
    1610:	b8 0c 00 00 00       	mov    $0xc,%eax
    1615:	cd 40                	int    $0x40
    1617:	c3                   	ret    

00001618 <sleep>:
SYSCALL(sleep)
    1618:	b8 0d 00 00 00       	mov    $0xd,%eax
    161d:	cd 40                	int    $0x40
    161f:	c3                   	ret    

00001620 <uptime>:
SYSCALL(uptime)
    1620:	b8 0e 00 00 00       	mov    $0xe,%eax
    1625:	cd 40                	int    $0x40
    1627:	c3                   	ret    

00001628 <hello>:
SYSCALL(hello)
    1628:	b8 16 00 00 00       	mov    $0x16,%eax
    162d:	cd 40                	int    $0x40
    162f:	c3                   	ret    

00001630 <waitpid>:
SYSCALL(waitpid)
    1630:	b8 17 00 00 00       	mov    $0x17,%eax
    1635:	cd 40                	int    $0x40
    1637:	c3                   	ret    

00001638 <setpriority>:
SYSCALL(setpriority)
    1638:	b8 18 00 00 00       	mov    $0x18,%eax
    163d:	cd 40                	int    $0x40
    163f:	c3                   	ret    

00001640 <v2p>:
SYSCALL(v2p)
    1640:	b8 19 00 00 00       	mov    $0x19,%eax
    1645:	cd 40                	int    $0x40
    1647:	c3                   	ret    
    1648:	90                   	nop
    1649:	90                   	nop
    164a:	90                   	nop
    164b:	90                   	nop
    164c:	90                   	nop
    164d:	90                   	nop
    164e:	90                   	nop
    164f:	90                   	nop

00001650 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
    1650:	55                   	push   %ebp
    1651:	89 e5                	mov    %esp,%ebp
    1653:	57                   	push   %edi
    1654:	89 cf                	mov    %ecx,%edi
    1656:	56                   	push   %esi
    1657:	89 c6                	mov    %eax,%esi
    1659:	53                   	push   %ebx
    165a:	83 ec 4c             	sub    $0x4c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    165d:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1660:	85 c9                	test   %ecx,%ecx
    1662:	74 04                	je     1668 <printint+0x18>
    1664:	85 d2                	test   %edx,%edx
    1666:	78 68                	js     16d0 <printint+0x80>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
    1668:	89 d0                	mov    %edx,%eax
    166a:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
    1671:	31 c9                	xor    %ecx,%ecx
    1673:	8d 5d d7             	lea    -0x29(%ebp),%ebx
    1676:	66 90                	xchg   %ax,%ax
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
    1678:	31 d2                	xor    %edx,%edx
    167a:	f7 f7                	div    %edi
    167c:	0f b6 92 85 1a 00 00 	movzbl 0x1a85(%edx),%edx
    1683:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
    1686:	83 c1 01             	add    $0x1,%ecx
  }while((x /= base) != 0);
    1689:	85 c0                	test   %eax,%eax
    168b:	75 eb                	jne    1678 <printint+0x28>
  if(neg)
    168d:	8b 45 c4             	mov    -0x3c(%ebp),%eax
    1690:	85 c0                	test   %eax,%eax
    1692:	74 08                	je     169c <printint+0x4c>
    buf[i++] = '-';
    1694:	c6 44 0d d7 2d       	movb   $0x2d,-0x29(%ebp,%ecx,1)
    1699:	83 c1 01             	add    $0x1,%ecx

  while(--i >= 0)
    169c:	8d 79 ff             	lea    -0x1(%ecx),%edi
    169f:	90                   	nop
    16a0:	0f b6 04 3b          	movzbl (%ebx,%edi,1),%eax
    16a4:	83 ef 01             	sub    $0x1,%edi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    16a7:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    16ae:	00 
    16af:	89 34 24             	mov    %esi,(%esp)
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
    16b2:	88 45 e7             	mov    %al,-0x19(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    16b5:	8d 45 e7             	lea    -0x19(%ebp),%eax
    16b8:	89 44 24 04          	mov    %eax,0x4(%esp)
    16bc:	e8 e7 fe ff ff       	call   15a8 <write>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
    16c1:	83 ff ff             	cmp    $0xffffffff,%edi
    16c4:	75 da                	jne    16a0 <printint+0x50>
    putc(fd, buf[i]);
}
    16c6:	83 c4 4c             	add    $0x4c,%esp
    16c9:	5b                   	pop    %ebx
    16ca:	5e                   	pop    %esi
    16cb:	5f                   	pop    %edi
    16cc:	5d                   	pop    %ebp
    16cd:	c3                   	ret    
    16ce:	66 90                	xchg   %ax,%ax
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
    16d0:	89 d0                	mov    %edx,%eax
    16d2:	f7 d8                	neg    %eax
    16d4:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
    16db:	eb 94                	jmp    1671 <printint+0x21>
    16dd:	8d 76 00             	lea    0x0(%esi),%esi

000016e0 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
    16e0:	55                   	push   %ebp
    16e1:	89 e5                	mov    %esp,%ebp
    16e3:	57                   	push   %edi
    16e4:	56                   	push   %esi
    16e5:	53                   	push   %ebx
    16e6:	83 ec 3c             	sub    $0x3c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    16e9:	8b 45 0c             	mov    0xc(%ebp),%eax
    16ec:	0f b6 10             	movzbl (%eax),%edx
    16ef:	84 d2                	test   %dl,%dl
    16f1:	0f 84 c1 00 00 00    	je     17b8 <printf+0xd8>
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
    16f7:	8d 4d 10             	lea    0x10(%ebp),%ecx
    16fa:	31 ff                	xor    %edi,%edi
    16fc:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
    16ff:	31 db                	xor    %ebx,%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    1701:	8d 75 e7             	lea    -0x19(%ebp),%esi
    1704:	eb 1e                	jmp    1724 <printf+0x44>
    1706:	66 90                	xchg   %ax,%ax
  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
    1708:	83 fa 25             	cmp    $0x25,%edx
    170b:	0f 85 af 00 00 00    	jne    17c0 <printf+0xe0>
    1711:	66 bf 25 00          	mov    $0x25,%di
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    1715:	83 c3 01             	add    $0x1,%ebx
    1718:	0f b6 14 18          	movzbl (%eax,%ebx,1),%edx
    171c:	84 d2                	test   %dl,%dl
    171e:	0f 84 94 00 00 00    	je     17b8 <printf+0xd8>
    c = fmt[i] & 0xff;
    if(state == 0){
    1724:	85 ff                	test   %edi,%edi
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    1726:	0f b6 d2             	movzbl %dl,%edx
    if(state == 0){
    1729:	74 dd                	je     1708 <printf+0x28>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
    172b:	83 ff 25             	cmp    $0x25,%edi
    172e:	75 e5                	jne    1715 <printf+0x35>
      if(c == 'd'){
    1730:	83 fa 64             	cmp    $0x64,%edx
    1733:	0f 84 3f 01 00 00    	je     1878 <printf+0x198>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
    1739:	83 fa 70             	cmp    $0x70,%edx
    173c:	0f 84 a6 00 00 00    	je     17e8 <printf+0x108>
    1742:	83 fa 78             	cmp    $0x78,%edx
    1745:	0f 84 9d 00 00 00    	je     17e8 <printf+0x108>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
    174b:	83 fa 73             	cmp    $0x73,%edx
    174e:	66 90                	xchg   %ax,%ax
    1750:	0f 84 ba 00 00 00    	je     1810 <printf+0x130>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    1756:	83 fa 63             	cmp    $0x63,%edx
    1759:	0f 84 41 01 00 00    	je     18a0 <printf+0x1c0>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
    175f:	83 fa 25             	cmp    $0x25,%edx
    1762:	0f 84 00 01 00 00    	je     1868 <printf+0x188>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    1768:	8b 4d 08             	mov    0x8(%ebp),%ecx
    176b:	89 55 cc             	mov    %edx,-0x34(%ebp)
    176e:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
    1772:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    1779:	00 
    177a:	89 74 24 04          	mov    %esi,0x4(%esp)
    177e:	89 0c 24             	mov    %ecx,(%esp)
    1781:	e8 22 fe ff ff       	call   15a8 <write>
    1786:	8b 55 cc             	mov    -0x34(%ebp),%edx
    1789:	88 55 e7             	mov    %dl,-0x19(%ebp)
    178c:	8b 45 08             	mov    0x8(%ebp),%eax
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    178f:	83 c3 01             	add    $0x1,%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    1792:	31 ff                	xor    %edi,%edi
    1794:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    179b:	00 
    179c:	89 74 24 04          	mov    %esi,0x4(%esp)
    17a0:	89 04 24             	mov    %eax,(%esp)
    17a3:	e8 00 fe ff ff       	call   15a8 <write>
    17a8:	8b 45 0c             	mov    0xc(%ebp),%eax
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    17ab:	0f b6 14 18          	movzbl (%eax,%ebx,1),%edx
    17af:	84 d2                	test   %dl,%dl
    17b1:	0f 85 6d ff ff ff    	jne    1724 <printf+0x44>
    17b7:	90                   	nop
        putc(fd, c);
      }
      state = 0;
    }
  }
}
    17b8:	83 c4 3c             	add    $0x3c,%esp
    17bb:	5b                   	pop    %ebx
    17bc:	5e                   	pop    %esi
    17bd:	5f                   	pop    %edi
    17be:	5d                   	pop    %ebp
    17bf:	c3                   	ret    
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    17c0:	8b 45 08             	mov    0x8(%ebp),%eax
  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
    17c3:	88 55 e7             	mov    %dl,-0x19(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    17c6:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    17cd:	00 
    17ce:	89 74 24 04          	mov    %esi,0x4(%esp)
    17d2:	89 04 24             	mov    %eax,(%esp)
    17d5:	e8 ce fd ff ff       	call   15a8 <write>
    17da:	8b 45 0c             	mov    0xc(%ebp),%eax
    17dd:	e9 33 ff ff ff       	jmp    1715 <printf+0x35>
    17e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
    17e8:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    17eb:	b9 10 00 00 00       	mov    $0x10,%ecx
        ap++;
    17f0:	31 ff                	xor    %edi,%edi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
    17f2:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    17f9:	8b 10                	mov    (%eax),%edx
    17fb:	8b 45 08             	mov    0x8(%ebp),%eax
    17fe:	e8 4d fe ff ff       	call   1650 <printint>
    1803:	8b 45 0c             	mov    0xc(%ebp),%eax
        ap++;
    1806:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
    180a:	e9 06 ff ff ff       	jmp    1715 <printf+0x35>
    180f:	90                   	nop
      } else if(c == 's'){
        s = (char*)*ap;
    1810:	8b 55 d4             	mov    -0x2c(%ebp),%edx
        ap++;
        if(s == 0)
    1813:	b9 7e 1a 00 00       	mov    $0x1a7e,%ecx
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
        s = (char*)*ap;
    1818:	8b 3a                	mov    (%edx),%edi
        ap++;
    181a:	83 c2 04             	add    $0x4,%edx
    181d:	89 55 d4             	mov    %edx,-0x2c(%ebp)
        if(s == 0)
    1820:	85 ff                	test   %edi,%edi
    1822:	0f 44 f9             	cmove  %ecx,%edi
          s = "(null)";
        while(*s != 0){
    1825:	0f b6 17             	movzbl (%edi),%edx
    1828:	84 d2                	test   %dl,%dl
    182a:	74 33                	je     185f <printf+0x17f>
    182c:	89 5d d0             	mov    %ebx,-0x30(%ebp)
    182f:	8b 5d 08             	mov    0x8(%ebp),%ebx
    1832:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
          putc(fd, *s);
          s++;
    1838:	83 c7 01             	add    $0x1,%edi
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
    183b:	88 55 e7             	mov    %dl,-0x19(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    183e:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    1845:	00 
    1846:	89 74 24 04          	mov    %esi,0x4(%esp)
    184a:	89 1c 24             	mov    %ebx,(%esp)
    184d:	e8 56 fd ff ff       	call   15a8 <write>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
    1852:	0f b6 17             	movzbl (%edi),%edx
    1855:	84 d2                	test   %dl,%dl
    1857:	75 df                	jne    1838 <printf+0x158>
    1859:	8b 5d d0             	mov    -0x30(%ebp),%ebx
    185c:	8b 45 0c             	mov    0xc(%ebp),%eax
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    185f:	31 ff                	xor    %edi,%edi
    1861:	e9 af fe ff ff       	jmp    1715 <printf+0x35>
    1866:	66 90                	xchg   %ax,%ax
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
    1868:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
    186c:	e9 1b ff ff ff       	jmp    178c <printf+0xac>
    1871:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
    1878:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    187b:	b9 0a 00 00 00       	mov    $0xa,%ecx
        ap++;
    1880:	66 31 ff             	xor    %di,%di
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
    1883:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    188a:	8b 10                	mov    (%eax),%edx
    188c:	8b 45 08             	mov    0x8(%ebp),%eax
    188f:	e8 bc fd ff ff       	call   1650 <printint>
    1894:	8b 45 0c             	mov    0xc(%ebp),%eax
        ap++;
    1897:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
    189b:	e9 75 fe ff ff       	jmp    1715 <printf+0x35>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    18a0:	8b 55 d4             	mov    -0x2c(%ebp),%edx
        putc(fd, *ap);
        ap++;
    18a3:	31 ff                	xor    %edi,%edi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    18a5:	8b 4d 08             	mov    0x8(%ebp),%ecx
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    18a8:	8b 02                	mov    (%edx),%eax
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    18aa:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    18b1:	00 
    18b2:	89 74 24 04          	mov    %esi,0x4(%esp)
    18b6:	89 0c 24             	mov    %ecx,(%esp)
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    18b9:	88 45 e7             	mov    %al,-0x19(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    18bc:	e8 e7 fc ff ff       	call   15a8 <write>
    18c1:	8b 45 0c             	mov    0xc(%ebp),%eax
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
        ap++;
    18c4:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
    18c8:	e9 48 fe ff ff       	jmp    1715 <printf+0x35>
    18cd:	90                   	nop
    18ce:	90                   	nop
    18cf:	90                   	nop

000018d0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    18d0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    18d1:	a1 a8 1a 00 00       	mov    0x1aa8,%eax
static Header base;
static Header *freep;

void
free(void *ap)
{
    18d6:	89 e5                	mov    %esp,%ebp
    18d8:	57                   	push   %edi
    18d9:	56                   	push   %esi
    18da:	53                   	push   %ebx
    18db:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
    18de:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    18e1:	39 c8                	cmp    %ecx,%eax
    18e3:	73 1d                	jae    1902 <free+0x32>
    18e5:	8d 76 00             	lea    0x0(%esi),%esi
    18e8:	8b 10                	mov    (%eax),%edx
    18ea:	39 d1                	cmp    %edx,%ecx
    18ec:	72 1a                	jb     1908 <free+0x38>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    18ee:	39 d0                	cmp    %edx,%eax
    18f0:	72 08                	jb     18fa <free+0x2a>
    18f2:	39 c8                	cmp    %ecx,%eax
    18f4:	72 12                	jb     1908 <free+0x38>
    18f6:	39 d1                	cmp    %edx,%ecx
    18f8:	72 0e                	jb     1908 <free+0x38>
    18fa:	89 d0                	mov    %edx,%eax
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    18fc:	39 c8                	cmp    %ecx,%eax
    18fe:	66 90                	xchg   %ax,%ax
    1900:	72 e6                	jb     18e8 <free+0x18>
    1902:	8b 10                	mov    (%eax),%edx
    1904:	eb e8                	jmp    18ee <free+0x1e>
    1906:	66 90                	xchg   %ax,%ax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    1908:	8b 71 04             	mov    0x4(%ecx),%esi
    190b:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    190e:	39 d7                	cmp    %edx,%edi
    1910:	74 19                	je     192b <free+0x5b>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
    1912:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    1915:	8b 50 04             	mov    0x4(%eax),%edx
    1918:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    191b:	39 ce                	cmp    %ecx,%esi
    191d:	74 23                	je     1942 <free+0x72>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
    191f:	89 08                	mov    %ecx,(%eax)
  freep = p;
    1921:	a3 a8 1a 00 00       	mov    %eax,0x1aa8
}
    1926:	5b                   	pop    %ebx
    1927:	5e                   	pop    %esi
    1928:	5f                   	pop    %edi
    1929:	5d                   	pop    %ebp
    192a:	c3                   	ret    
  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
    192b:	03 72 04             	add    0x4(%edx),%esi
    192e:	89 71 04             	mov    %esi,0x4(%ecx)
    bp->s.ptr = p->s.ptr->s.ptr;
    1931:	8b 10                	mov    (%eax),%edx
    1933:	8b 12                	mov    (%edx),%edx
    1935:	89 53 f8             	mov    %edx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    1938:	8b 50 04             	mov    0x4(%eax),%edx
    193b:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    193e:	39 ce                	cmp    %ecx,%esi
    1940:	75 dd                	jne    191f <free+0x4f>
    p->s.size += bp->s.size;
    1942:	03 51 04             	add    0x4(%ecx),%edx
    1945:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    1948:	8b 53 f8             	mov    -0x8(%ebx),%edx
    194b:	89 10                	mov    %edx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
    194d:	a3 a8 1a 00 00       	mov    %eax,0x1aa8
}
    1952:	5b                   	pop    %ebx
    1953:	5e                   	pop    %esi
    1954:	5f                   	pop    %edi
    1955:	5d                   	pop    %ebp
    1956:	c3                   	ret    
    1957:	89 f6                	mov    %esi,%esi
    1959:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001960 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    1960:	55                   	push   %ebp
    1961:	89 e5                	mov    %esp,%ebp
    1963:	57                   	push   %edi
    1964:	56                   	push   %esi
    1965:	53                   	push   %ebx
    1966:	83 ec 2c             	sub    $0x2c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1969:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if((prevp = freep) == 0){
    196c:	8b 0d a8 1a 00 00    	mov    0x1aa8,%ecx
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1972:	83 c3 07             	add    $0x7,%ebx
    1975:	c1 eb 03             	shr    $0x3,%ebx
    1978:	83 c3 01             	add    $0x1,%ebx
  if((prevp = freep) == 0){
    197b:	85 c9                	test   %ecx,%ecx
    197d:	0f 84 9b 00 00 00    	je     1a1e <malloc+0xbe>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1983:	8b 01                	mov    (%ecx),%eax
    if(p->s.size >= nunits){
    1985:	8b 50 04             	mov    0x4(%eax),%edx
    1988:	39 d3                	cmp    %edx,%ebx
    198a:	76 27                	jbe    19b3 <malloc+0x53>
        p->s.size -= nunits;
        p += p->s.size;
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    198c:	8d 3c dd 00 00 00 00 	lea    0x0(,%ebx,8),%edi
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < 4096)
    1993:	be 00 80 00 00       	mov    $0x8000,%esi
    1998:	89 7d e4             	mov    %edi,-0x1c(%ebp)
    199b:	90                   	nop
    199c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    19a0:	3b 05 a8 1a 00 00    	cmp    0x1aa8,%eax
    19a6:	74 30                	je     19d8 <malloc+0x78>
    19a8:	89 c1                	mov    %eax,%ecx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    19aa:	8b 01                	mov    (%ecx),%eax
    if(p->s.size >= nunits){
    19ac:	8b 50 04             	mov    0x4(%eax),%edx
    19af:	39 d3                	cmp    %edx,%ebx
    19b1:	77 ed                	ja     19a0 <malloc+0x40>
      if(p->s.size == nunits)
    19b3:	39 d3                	cmp    %edx,%ebx
    19b5:	74 61                	je     1a18 <malloc+0xb8>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
    19b7:	29 da                	sub    %ebx,%edx
    19b9:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
    19bc:	8d 04 d0             	lea    (%eax,%edx,8),%eax
        p->s.size = nunits;
    19bf:	89 58 04             	mov    %ebx,0x4(%eax)
      }
      freep = prevp;
    19c2:	89 0d a8 1a 00 00    	mov    %ecx,0x1aa8
      return (void*)(p + 1);
    19c8:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
    19cb:	83 c4 2c             	add    $0x2c,%esp
    19ce:	5b                   	pop    %ebx
    19cf:	5e                   	pop    %esi
    19d0:	5f                   	pop    %edi
    19d1:	5d                   	pop    %ebp
    19d2:	c3                   	ret    
    19d3:	90                   	nop
    19d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < 4096)
    19d8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    19db:	81 fb 00 10 00 00    	cmp    $0x1000,%ebx
    19e1:	bf 00 10 00 00       	mov    $0x1000,%edi
    19e6:	0f 43 fb             	cmovae %ebx,%edi
    19e9:	0f 42 c6             	cmovb  %esi,%eax
    nu = 4096;
  p = sbrk(nu * sizeof(Header));
    19ec:	89 04 24             	mov    %eax,(%esp)
    19ef:	e8 1c fc ff ff       	call   1610 <sbrk>
  if(p == (char*)-1)
    19f4:	83 f8 ff             	cmp    $0xffffffff,%eax
    19f7:	74 18                	je     1a11 <malloc+0xb1>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
    19f9:	89 78 04             	mov    %edi,0x4(%eax)
  free((void*)(hp + 1));
    19fc:	83 c0 08             	add    $0x8,%eax
    19ff:	89 04 24             	mov    %eax,(%esp)
    1a02:	e8 c9 fe ff ff       	call   18d0 <free>
  return freep;
    1a07:	8b 0d a8 1a 00 00    	mov    0x1aa8,%ecx
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
    1a0d:	85 c9                	test   %ecx,%ecx
    1a0f:	75 99                	jne    19aa <malloc+0x4a>
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
    1a11:	31 c0                	xor    %eax,%eax
    1a13:	eb b6                	jmp    19cb <malloc+0x6b>
    1a15:	8d 76 00             	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
    1a18:	8b 10                	mov    (%eax),%edx
    1a1a:	89 11                	mov    %edx,(%ecx)
    1a1c:	eb a4                	jmp    19c2 <malloc+0x62>
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    1a1e:	c7 05 a8 1a 00 00 a0 	movl   $0x1aa0,0x1aa8
    1a25:	1a 00 00 
    base.s.size = 0;
    1a28:	b9 a0 1a 00 00       	mov    $0x1aa0,%ecx
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    1a2d:	c7 05 a0 1a 00 00 a0 	movl   $0x1aa0,0x1aa0
    1a34:	1a 00 00 
    base.s.size = 0;
    1a37:	c7 05 a4 1a 00 00 00 	movl   $0x0,0x1aa4
    1a3e:	00 00 00 
    1a41:	e9 3d ff ff ff       	jmp    1983 <malloc+0x23>
