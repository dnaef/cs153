
_sh:     file format elf32-i386


Disassembly of section .text:

00001000 <nulterminate>:
}

// NUL-terminate all the counted strings.
struct cmd*
nulterminate(struct cmd *cmd)
{
    1000:	55                   	push   %ebp
    1001:	89 e5                	mov    %esp,%ebp
    1003:	53                   	push   %ebx
    1004:	83 ec 14             	sub    $0x14,%esp
    1007:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct execcmd *ecmd;
  struct listcmd *lcmd;
  struct pipecmd *pcmd;
  struct redircmd *rcmd;

  if(cmd == 0)
    100a:	85 db                	test   %ebx,%ebx
    100c:	74 05                	je     1013 <nulterminate+0x13>
    return 0;

  switch(cmd->type){
    100e:	83 3b 05             	cmpl   $0x5,(%ebx)
    1011:	76 0d                	jbe    1020 <nulterminate+0x20>
    bcmd = (struct backcmd*)cmd;
    nulterminate(bcmd->cmd);
    break;
  }
  return cmd;
}
    1013:	89 d8                	mov    %ebx,%eax
    1015:	83 c4 14             	add    $0x14,%esp
    1018:	5b                   	pop    %ebx
    1019:	5d                   	pop    %ebp
    101a:	c3                   	ret    
    101b:	90                   	nop
    101c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  struct redircmd *rcmd;

  if(cmd == 0)
    return 0;

  switch(cmd->type){
    1020:	8b 03                	mov    (%ebx),%eax
    1022:	ff 24 85 88 23 00 00 	jmp    *0x2388(,%eax,4)
    1029:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    nulterminate(pcmd->right);
    break;

  case LIST:
    lcmd = (struct listcmd*)cmd;
    nulterminate(lcmd->left);
    1030:	8b 43 04             	mov    0x4(%ebx),%eax
    1033:	89 04 24             	mov    %eax,(%esp)
    1036:	e8 c5 ff ff ff       	call   1000 <nulterminate>
    nulterminate(lcmd->right);
    103b:	8b 43 08             	mov    0x8(%ebx),%eax
    103e:	89 04 24             	mov    %eax,(%esp)
    1041:	e8 ba ff ff ff       	call   1000 <nulterminate>
    bcmd = (struct backcmd*)cmd;
    nulterminate(bcmd->cmd);
    break;
  }
  return cmd;
}
    1046:	89 d8                	mov    %ebx,%eax
    1048:	83 c4 14             	add    $0x14,%esp
    104b:	5b                   	pop    %ebx
    104c:	5d                   	pop    %ebp
    104d:	c3                   	ret    
    104e:	66 90                	xchg   %ax,%ax
    nulterminate(lcmd->right);
    break;

  case BACK:
    bcmd = (struct backcmd*)cmd;
    nulterminate(bcmd->cmd);
    1050:	8b 43 04             	mov    0x4(%ebx),%eax
    1053:	89 04 24             	mov    %eax,(%esp)
    1056:	e8 a5 ff ff ff       	call   1000 <nulterminate>
    break;
  }
  return cmd;
}
    105b:	89 d8                	mov    %ebx,%eax
    105d:	83 c4 14             	add    $0x14,%esp
    1060:	5b                   	pop    %ebx
    1061:	5d                   	pop    %ebp
    1062:	c3                   	ret    
    1063:	90                   	nop
    1064:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      *ecmd->eargv[i] = 0;
    break;

  case REDIR:
    rcmd = (struct redircmd*)cmd;
    nulterminate(rcmd->cmd);
    1068:	8b 43 04             	mov    0x4(%ebx),%eax
    106b:	89 04 24             	mov    %eax,(%esp)
    106e:	e8 8d ff ff ff       	call   1000 <nulterminate>
    *rcmd->efile = 0;
    1073:	8b 43 0c             	mov    0xc(%ebx),%eax
    1076:	c6 00 00             	movb   $0x0,(%eax)
    bcmd = (struct backcmd*)cmd;
    nulterminate(bcmd->cmd);
    break;
  }
  return cmd;
}
    1079:	89 d8                	mov    %ebx,%eax
    107b:	83 c4 14             	add    $0x14,%esp
    107e:	5b                   	pop    %ebx
    107f:	5d                   	pop    %ebp
    1080:	c3                   	ret    
    1081:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return 0;

  switch(cmd->type){
  case EXEC:
    ecmd = (struct execcmd*)cmd;
    for(i=0; ecmd->argv[i]; i++)
    1088:	8b 43 04             	mov    0x4(%ebx),%eax
    108b:	85 c0                	test   %eax,%eax
    108d:	74 84                	je     1013 <nulterminate+0x13>
    108f:	89 d8                	mov    %ebx,%eax
    1091:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      *ecmd->eargv[i] = 0;
    1098:	8b 50 2c             	mov    0x2c(%eax),%edx
    109b:	c6 02 00             	movb   $0x0,(%edx)
    return 0;

  switch(cmd->type){
  case EXEC:
    ecmd = (struct execcmd*)cmd;
    for(i=0; ecmd->argv[i]; i++)
    109e:	8b 50 08             	mov    0x8(%eax),%edx
    10a1:	83 c0 04             	add    $0x4,%eax
    10a4:	85 d2                	test   %edx,%edx
    10a6:	75 f0                	jne    1098 <nulterminate+0x98>
    bcmd = (struct backcmd*)cmd;
    nulterminate(bcmd->cmd);
    break;
  }
  return cmd;
}
    10a8:	89 d8                	mov    %ebx,%eax
    10aa:	83 c4 14             	add    $0x14,%esp
    10ad:	5b                   	pop    %ebx
    10ae:	5d                   	pop    %ebp
    10af:	c3                   	ret    

000010b0 <peek>:
  return ret;
}

int
peek(char **ps, char *es, char *toks)
{
    10b0:	55                   	push   %ebp
    10b1:	89 e5                	mov    %esp,%ebp
    10b3:	57                   	push   %edi
    10b4:	56                   	push   %esi
    10b5:	53                   	push   %ebx
    10b6:	83 ec 1c             	sub    $0x1c,%esp
    10b9:	8b 7d 08             	mov    0x8(%ebp),%edi
    10bc:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *s;

  s = *ps;
    10bf:	8b 1f                	mov    (%edi),%ebx
  while(s < es && strchr(whitespace, *s))
    10c1:	39 f3                	cmp    %esi,%ebx
    10c3:	72 0a                	jb     10cf <peek+0x1f>
    10c5:	eb 1f                	jmp    10e6 <peek+0x36>
    10c7:	90                   	nop
    s++;
    10c8:	83 c3 01             	add    $0x1,%ebx
peek(char **ps, char *es, char *toks)
{
  char *s;

  s = *ps;
  while(s < es && strchr(whitespace, *s))
    10cb:	39 de                	cmp    %ebx,%esi
    10cd:	76 17                	jbe    10e6 <peek+0x36>
    10cf:	0f be 03             	movsbl (%ebx),%eax
    10d2:	c7 04 24 88 24 00 00 	movl   $0x2488,(%esp)
    10d9:	89 44 24 04          	mov    %eax,0x4(%esp)
    10dd:	e8 7e 0c 00 00       	call   1d60 <strchr>
    10e2:	85 c0                	test   %eax,%eax
    10e4:	75 e2                	jne    10c8 <peek+0x18>
    s++;
  *ps = s;
    10e6:	89 1f                	mov    %ebx,(%edi)
  return *s && strchr(toks, *s);
    10e8:	0f b6 13             	movzbl (%ebx),%edx
    10eb:	31 c0                	xor    %eax,%eax
    10ed:	84 d2                	test   %dl,%dl
    10ef:	75 0f                	jne    1100 <peek+0x50>
}
    10f1:	83 c4 1c             	add    $0x1c,%esp
    10f4:	5b                   	pop    %ebx
    10f5:	5e                   	pop    %esi
    10f6:	5f                   	pop    %edi
    10f7:	5d                   	pop    %ebp
    10f8:	c3                   	ret    
    10f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

  s = *ps;
  while(s < es && strchr(whitespace, *s))
    s++;
  *ps = s;
  return *s && strchr(toks, *s);
    1100:	8b 45 10             	mov    0x10(%ebp),%eax
    1103:	0f be d2             	movsbl %dl,%edx
    1106:	89 54 24 04          	mov    %edx,0x4(%esp)
    110a:	89 04 24             	mov    %eax,(%esp)
    110d:	e8 4e 0c 00 00       	call   1d60 <strchr>
    1112:	85 c0                	test   %eax,%eax
    1114:	0f 95 c0             	setne  %al
}
    1117:	83 c4 1c             	add    $0x1c,%esp

  s = *ps;
  while(s < es && strchr(whitespace, *s))
    s++;
  *ps = s;
  return *s && strchr(toks, *s);
    111a:	0f b6 c0             	movzbl %al,%eax
}
    111d:	5b                   	pop    %ebx
    111e:	5e                   	pop    %esi
    111f:	5f                   	pop    %edi
    1120:	5d                   	pop    %ebp
    1121:	c3                   	ret    
    1122:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    1129:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001130 <gettoken>:
char whitespace[] = " \t\r\n\v";
char symbols[] = "<|>&;()";

int
gettoken(char **ps, char *es, char **q, char **eq)
{
    1130:	55                   	push   %ebp
    1131:	89 e5                	mov    %esp,%ebp
    1133:	57                   	push   %edi
    1134:	56                   	push   %esi
    1135:	53                   	push   %ebx
    1136:	83 ec 1c             	sub    $0x1c,%esp
  char *s;
  int ret;

  s = *ps;
    1139:	8b 45 08             	mov    0x8(%ebp),%eax
char whitespace[] = " \t\r\n\v";
char symbols[] = "<|>&;()";

int
gettoken(char **ps, char *es, char **q, char **eq)
{
    113c:	8b 75 0c             	mov    0xc(%ebp),%esi
    113f:	8b 7d 10             	mov    0x10(%ebp),%edi
  char *s;
  int ret;

  s = *ps;
    1142:	8b 18                	mov    (%eax),%ebx
  while(s < es && strchr(whitespace, *s))
    1144:	39 f3                	cmp    %esi,%ebx
    1146:	72 0f                	jb     1157 <gettoken+0x27>
    1148:	eb 24                	jmp    116e <gettoken+0x3e>
    114a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    s++;
    1150:	83 c3 01             	add    $0x1,%ebx
{
  char *s;
  int ret;

  s = *ps;
  while(s < es && strchr(whitespace, *s))
    1153:	39 de                	cmp    %ebx,%esi
    1155:	76 17                	jbe    116e <gettoken+0x3e>
    1157:	0f be 03             	movsbl (%ebx),%eax
    115a:	c7 04 24 88 24 00 00 	movl   $0x2488,(%esp)
    1161:	89 44 24 04          	mov    %eax,0x4(%esp)
    1165:	e8 f6 0b 00 00       	call   1d60 <strchr>
    116a:	85 c0                	test   %eax,%eax
    116c:	75 e2                	jne    1150 <gettoken+0x20>
    s++;
  if(q)
    116e:	85 ff                	test   %edi,%edi
    1170:	74 02                	je     1174 <gettoken+0x44>
    *q = s;
    1172:	89 1f                	mov    %ebx,(%edi)
  ret = *s;
    1174:	0f b6 13             	movzbl (%ebx),%edx
    1177:	0f be fa             	movsbl %dl,%edi
  switch(*s){
    117a:	80 fa 3c             	cmp    $0x3c,%dl
  s = *ps;
  while(s < es && strchr(whitespace, *s))
    s++;
  if(q)
    *q = s;
  ret = *s;
    117d:	89 f8                	mov    %edi,%eax
  switch(*s){
    117f:	7f 4f                	jg     11d0 <gettoken+0xa0>
    1181:	80 fa 3b             	cmp    $0x3b,%dl
    1184:	0f 8c 9e 00 00 00    	jl     1228 <gettoken+0xf8>
  case '(':
  case ')':
  case ';':
  case '&':
  case '<':
    s++;
    118a:	83 c3 01             	add    $0x1,%ebx
    ret = 'a';
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
      s++;
    break;
  }
  if(eq)
    118d:	8b 55 14             	mov    0x14(%ebp),%edx
    1190:	85 d2                	test   %edx,%edx
    1192:	74 05                	je     1199 <gettoken+0x69>
    *eq = s;
    1194:	8b 45 14             	mov    0x14(%ebp),%eax
    1197:	89 18                	mov    %ebx,(%eax)

  while(s < es && strchr(whitespace, *s))
    1199:	39 f3                	cmp    %esi,%ebx
    119b:	72 0a                	jb     11a7 <gettoken+0x77>
    119d:	eb 1f                	jmp    11be <gettoken+0x8e>
    119f:	90                   	nop
    s++;
    11a0:	83 c3 01             	add    $0x1,%ebx
    break;
  }
  if(eq)
    *eq = s;

  while(s < es && strchr(whitespace, *s))
    11a3:	39 de                	cmp    %ebx,%esi
    11a5:	76 17                	jbe    11be <gettoken+0x8e>
    11a7:	0f be 03             	movsbl (%ebx),%eax
    11aa:	c7 04 24 88 24 00 00 	movl   $0x2488,(%esp)
    11b1:	89 44 24 04          	mov    %eax,0x4(%esp)
    11b5:	e8 a6 0b 00 00       	call   1d60 <strchr>
    11ba:	85 c0                	test   %eax,%eax
    11bc:	75 e2                	jne    11a0 <gettoken+0x70>
    s++;
  *ps = s;
    11be:	8b 45 08             	mov    0x8(%ebp),%eax
    11c1:	89 18                	mov    %ebx,(%eax)
  return ret;
}
    11c3:	83 c4 1c             	add    $0x1c,%esp
    11c6:	89 f8                	mov    %edi,%eax
    11c8:	5b                   	pop    %ebx
    11c9:	5e                   	pop    %esi
    11ca:	5f                   	pop    %edi
    11cb:	5d                   	pop    %ebp
    11cc:	c3                   	ret    
    11cd:	8d 76 00             	lea    0x0(%esi),%esi
  while(s < es && strchr(whitespace, *s))
    s++;
  if(q)
    *q = s;
  ret = *s;
  switch(*s){
    11d0:	80 fa 3e             	cmp    $0x3e,%dl
    11d3:	74 73                	je     1248 <gettoken+0x118>
    11d5:	80 fa 7c             	cmp    $0x7c,%dl
    11d8:	74 b0                	je     118a <gettoken+0x5a>
      s++;
    }
    break;
  default:
    ret = 'a';
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
    11da:	39 de                	cmp    %ebx,%esi
    11dc:	77 2b                	ja     1209 <gettoken+0xd9>
    11de:	66 90                	xchg   %ax,%ax
    11e0:	eb 3b                	jmp    121d <gettoken+0xed>
    11e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    11e8:	0f be 03             	movsbl (%ebx),%eax
    11eb:	c7 04 24 8e 24 00 00 	movl   $0x248e,(%esp)
    11f2:	89 44 24 04          	mov    %eax,0x4(%esp)
    11f6:	e8 65 0b 00 00       	call   1d60 <strchr>
    11fb:	85 c0                	test   %eax,%eax
    11fd:	75 1e                	jne    121d <gettoken+0xed>
      s++;
    11ff:	83 c3 01             	add    $0x1,%ebx
      s++;
    }
    break;
  default:
    ret = 'a';
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
    1202:	39 de                	cmp    %ebx,%esi
    1204:	76 17                	jbe    121d <gettoken+0xed>
    1206:	0f be 03             	movsbl (%ebx),%eax
    1209:	89 44 24 04          	mov    %eax,0x4(%esp)
    120d:	c7 04 24 88 24 00 00 	movl   $0x2488,(%esp)
    1214:	e8 47 0b 00 00       	call   1d60 <strchr>
    1219:	85 c0                	test   %eax,%eax
    121b:	74 cb                	je     11e8 <gettoken+0xb8>
    121d:	bf 61 00 00 00       	mov    $0x61,%edi
    1222:	e9 66 ff ff ff       	jmp    118d <gettoken+0x5d>
    1227:	90                   	nop
  while(s < es && strchr(whitespace, *s))
    s++;
  if(q)
    *q = s;
  ret = *s;
  switch(*s){
    1228:	80 fa 29             	cmp    $0x29,%dl
    122b:	7f ad                	jg     11da <gettoken+0xaa>
    122d:	80 fa 28             	cmp    $0x28,%dl
    1230:	0f 8d 54 ff ff ff    	jge    118a <gettoken+0x5a>
    1236:	84 d2                	test   %dl,%dl
    1238:	0f 84 4f ff ff ff    	je     118d <gettoken+0x5d>
    123e:	80 fa 26             	cmp    $0x26,%dl
    1241:	75 97                	jne    11da <gettoken+0xaa>
    1243:	e9 42 ff ff ff       	jmp    118a <gettoken+0x5a>
  case '&':
  case '<':
    s++;
    break;
  case '>':
    s++;
    1248:	83 c3 01             	add    $0x1,%ebx
    if(*s == '>'){
    124b:	80 3b 3e             	cmpb   $0x3e,(%ebx)
    124e:	66 90                	xchg   %ax,%ax
    1250:	0f 85 37 ff ff ff    	jne    118d <gettoken+0x5d>
      ret = '+';
      s++;
    1256:	83 c3 01             	add    $0x1,%ebx
    1259:	bf 2b 00 00 00       	mov    $0x2b,%edi
    125e:	e9 2a ff ff ff       	jmp    118d <gettoken+0x5d>
    1263:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    1269:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001270 <backcmd>:
  return (struct cmd*)cmd;
}

struct cmd*
backcmd(struct cmd *subcmd)
{
    1270:	55                   	push   %ebp
    1271:	89 e5                	mov    %esp,%ebp
    1273:	53                   	push   %ebx
    1274:	83 ec 14             	sub    $0x14,%esp
  struct backcmd *cmd;

  cmd = malloc(sizeof(*cmd));
    1277:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
    127e:	e8 1d 10 00 00       	call   22a0 <malloc>
  memset(cmd, 0, sizeof(*cmd));
    1283:	c7 44 24 08 08 00 00 	movl   $0x8,0x8(%esp)
    128a:	00 
    128b:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1292:	00 
struct cmd*
backcmd(struct cmd *subcmd)
{
  struct backcmd *cmd;

  cmd = malloc(sizeof(*cmd));
    1293:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
    1295:	89 04 24             	mov    %eax,(%esp)
    1298:	e8 a3 0a 00 00       	call   1d40 <memset>
  cmd->type = BACK;
    129d:	c7 03 05 00 00 00    	movl   $0x5,(%ebx)
  cmd->cmd = subcmd;
    12a3:	8b 45 08             	mov    0x8(%ebp),%eax
    12a6:	89 43 04             	mov    %eax,0x4(%ebx)
  return (struct cmd*)cmd;
}
    12a9:	89 d8                	mov    %ebx,%eax
    12ab:	83 c4 14             	add    $0x14,%esp
    12ae:	5b                   	pop    %ebx
    12af:	5d                   	pop    %ebp
    12b0:	c3                   	ret    
    12b1:	eb 0d                	jmp    12c0 <listcmd>
    12b3:	90                   	nop
    12b4:	90                   	nop
    12b5:	90                   	nop
    12b6:	90                   	nop
    12b7:	90                   	nop
    12b8:	90                   	nop
    12b9:	90                   	nop
    12ba:	90                   	nop
    12bb:	90                   	nop
    12bc:	90                   	nop
    12bd:	90                   	nop
    12be:	90                   	nop
    12bf:	90                   	nop

000012c0 <listcmd>:
  return (struct cmd*)cmd;
}

struct cmd*
listcmd(struct cmd *left, struct cmd *right)
{
    12c0:	55                   	push   %ebp
    12c1:	89 e5                	mov    %esp,%ebp
    12c3:	53                   	push   %ebx
    12c4:	83 ec 14             	sub    $0x14,%esp
  struct listcmd *cmd;

  cmd = malloc(sizeof(*cmd));
    12c7:	c7 04 24 0c 00 00 00 	movl   $0xc,(%esp)
    12ce:	e8 cd 0f 00 00       	call   22a0 <malloc>
  memset(cmd, 0, sizeof(*cmd));
    12d3:	c7 44 24 08 0c 00 00 	movl   $0xc,0x8(%esp)
    12da:	00 
    12db:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    12e2:	00 
struct cmd*
listcmd(struct cmd *left, struct cmd *right)
{
  struct listcmd *cmd;

  cmd = malloc(sizeof(*cmd));
    12e3:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
    12e5:	89 04 24             	mov    %eax,(%esp)
    12e8:	e8 53 0a 00 00       	call   1d40 <memset>
  cmd->type = LIST;
    12ed:	c7 03 04 00 00 00    	movl   $0x4,(%ebx)
  cmd->left = left;
    12f3:	8b 45 08             	mov    0x8(%ebp),%eax
    12f6:	89 43 04             	mov    %eax,0x4(%ebx)
  cmd->right = right;
    12f9:	8b 45 0c             	mov    0xc(%ebp),%eax
    12fc:	89 43 08             	mov    %eax,0x8(%ebx)
  return (struct cmd*)cmd;
}
    12ff:	89 d8                	mov    %ebx,%eax
    1301:	83 c4 14             	add    $0x14,%esp
    1304:	5b                   	pop    %ebx
    1305:	5d                   	pop    %ebp
    1306:	c3                   	ret    
    1307:	89 f6                	mov    %esi,%esi
    1309:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001310 <pipecmd>:
  return (struct cmd*)cmd;
}

struct cmd*
pipecmd(struct cmd *left, struct cmd *right)
{
    1310:	55                   	push   %ebp
    1311:	89 e5                	mov    %esp,%ebp
    1313:	53                   	push   %ebx
    1314:	83 ec 14             	sub    $0x14,%esp
  struct pipecmd *cmd;

  cmd = malloc(sizeof(*cmd));
    1317:	c7 04 24 0c 00 00 00 	movl   $0xc,(%esp)
    131e:	e8 7d 0f 00 00       	call   22a0 <malloc>
  memset(cmd, 0, sizeof(*cmd));
    1323:	c7 44 24 08 0c 00 00 	movl   $0xc,0x8(%esp)
    132a:	00 
    132b:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1332:	00 
struct cmd*
pipecmd(struct cmd *left, struct cmd *right)
{
  struct pipecmd *cmd;

  cmd = malloc(sizeof(*cmd));
    1333:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
    1335:	89 04 24             	mov    %eax,(%esp)
    1338:	e8 03 0a 00 00       	call   1d40 <memset>
  cmd->type = PIPE;
    133d:	c7 03 03 00 00 00    	movl   $0x3,(%ebx)
  cmd->left = left;
    1343:	8b 45 08             	mov    0x8(%ebp),%eax
    1346:	89 43 04             	mov    %eax,0x4(%ebx)
  cmd->right = right;
    1349:	8b 45 0c             	mov    0xc(%ebp),%eax
    134c:	89 43 08             	mov    %eax,0x8(%ebx)
  return (struct cmd*)cmd;
}
    134f:	89 d8                	mov    %ebx,%eax
    1351:	83 c4 14             	add    $0x14,%esp
    1354:	5b                   	pop    %ebx
    1355:	5d                   	pop    %ebp
    1356:	c3                   	ret    
    1357:	89 f6                	mov    %esi,%esi
    1359:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001360 <redircmd>:
  return (struct cmd*)cmd;
}

struct cmd*
redircmd(struct cmd *subcmd, char *file, char *efile, int mode, int fd)
{
    1360:	55                   	push   %ebp
    1361:	89 e5                	mov    %esp,%ebp
    1363:	53                   	push   %ebx
    1364:	83 ec 14             	sub    $0x14,%esp
  struct redircmd *cmd;

  cmd = malloc(sizeof(*cmd));
    1367:	c7 04 24 18 00 00 00 	movl   $0x18,(%esp)
    136e:	e8 2d 0f 00 00       	call   22a0 <malloc>
  memset(cmd, 0, sizeof(*cmd));
    1373:	c7 44 24 08 18 00 00 	movl   $0x18,0x8(%esp)
    137a:	00 
    137b:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1382:	00 
struct cmd*
redircmd(struct cmd *subcmd, char *file, char *efile, int mode, int fd)
{
  struct redircmd *cmd;

  cmd = malloc(sizeof(*cmd));
    1383:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
    1385:	89 04 24             	mov    %eax,(%esp)
    1388:	e8 b3 09 00 00       	call   1d40 <memset>
  cmd->type = REDIR;
    138d:	c7 03 02 00 00 00    	movl   $0x2,(%ebx)
  cmd->cmd = subcmd;
    1393:	8b 45 08             	mov    0x8(%ebp),%eax
    1396:	89 43 04             	mov    %eax,0x4(%ebx)
  cmd->file = file;
    1399:	8b 45 0c             	mov    0xc(%ebp),%eax
    139c:	89 43 08             	mov    %eax,0x8(%ebx)
  cmd->efile = efile;
    139f:	8b 45 10             	mov    0x10(%ebp),%eax
    13a2:	89 43 0c             	mov    %eax,0xc(%ebx)
  cmd->mode = mode;
    13a5:	8b 45 14             	mov    0x14(%ebp),%eax
    13a8:	89 43 10             	mov    %eax,0x10(%ebx)
  cmd->fd = fd;
    13ab:	8b 45 18             	mov    0x18(%ebp),%eax
    13ae:	89 43 14             	mov    %eax,0x14(%ebx)
  return (struct cmd*)cmd;
}
    13b1:	89 d8                	mov    %ebx,%eax
    13b3:	83 c4 14             	add    $0x14,%esp
    13b6:	5b                   	pop    %ebx
    13b7:	5d                   	pop    %ebp
    13b8:	c3                   	ret    
    13b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000013c0 <execcmd>:
//PAGEBREAK!
// Constructors

struct cmd*
execcmd(void)
{
    13c0:	55                   	push   %ebp
    13c1:	89 e5                	mov    %esp,%ebp
    13c3:	53                   	push   %ebx
    13c4:	83 ec 14             	sub    $0x14,%esp
  struct execcmd *cmd;

  cmd = malloc(sizeof(*cmd));
    13c7:	c7 04 24 54 00 00 00 	movl   $0x54,(%esp)
    13ce:	e8 cd 0e 00 00       	call   22a0 <malloc>
  memset(cmd, 0, sizeof(*cmd));
    13d3:	c7 44 24 08 54 00 00 	movl   $0x54,0x8(%esp)
    13da:	00 
    13db:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    13e2:	00 
struct cmd*
execcmd(void)
{
  struct execcmd *cmd;

  cmd = malloc(sizeof(*cmd));
    13e3:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
    13e5:	89 04 24             	mov    %eax,(%esp)
    13e8:	e8 53 09 00 00       	call   1d40 <memset>
  cmd->type = EXEC;
  return (struct cmd*)cmd;
}
    13ed:	89 d8                	mov    %ebx,%eax
{
  struct execcmd *cmd;

  cmd = malloc(sizeof(*cmd));
  memset(cmd, 0, sizeof(*cmd));
  cmd->type = EXEC;
    13ef:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  return (struct cmd*)cmd;
}
    13f5:	83 c4 14             	add    $0x14,%esp
    13f8:	5b                   	pop    %ebx
    13f9:	5d                   	pop    %ebp
    13fa:	c3                   	ret    
    13fb:	90                   	nop
    13fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00001400 <panic>:
  exit(0);
}

void
panic(char *s)
{
    1400:	55                   	push   %ebp
    1401:	89 e5                	mov    %esp,%ebp
    1403:	83 ec 18             	sub    $0x18,%esp
  printf(2, "%s\n", s);
    1406:	8b 45 08             	mov    0x8(%ebp),%eax
    1409:	c7 44 24 04 21 24 00 	movl   $0x2421,0x4(%esp)
    1410:	00 
    1411:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
    1418:	89 44 24 08          	mov    %eax,0x8(%esp)
    141c:	e8 ff 0b 00 00       	call   2020 <printf>
  exit(0);
    1421:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1428:	e8 9b 0a 00 00       	call   1ec8 <exit>
    142d:	8d 76 00             	lea    0x0(%esi),%esi

00001430 <parseredirs>:
  return cmd;
}

struct cmd*
parseredirs(struct cmd *cmd, char **ps, char *es)
{
    1430:	55                   	push   %ebp
    1431:	89 e5                	mov    %esp,%ebp
    1433:	57                   	push   %edi
    1434:	56                   	push   %esi
    1435:	53                   	push   %ebx
    1436:	83 ec 3c             	sub    $0x3c,%esp
    1439:	8b 7d 0c             	mov    0xc(%ebp),%edi
    143c:	8b 75 10             	mov    0x10(%ebp),%esi
    143f:	90                   	nop
  int tok;
  char *q, *eq;

  while(peek(ps, es, "<>")){
    1440:	c7 44 24 08 d5 23 00 	movl   $0x23d5,0x8(%esp)
    1447:	00 
    1448:	89 74 24 04          	mov    %esi,0x4(%esp)
    144c:	89 3c 24             	mov    %edi,(%esp)
    144f:	e8 5c fc ff ff       	call   10b0 <peek>
    1454:	85 c0                	test   %eax,%eax
    1456:	0f 84 a4 00 00 00    	je     1500 <parseredirs+0xd0>
    tok = gettoken(ps, es, 0, 0);
    145c:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
    1463:	00 
    1464:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
    146b:	00 
    146c:	89 74 24 04          	mov    %esi,0x4(%esp)
    1470:	89 3c 24             	mov    %edi,(%esp)
    1473:	e8 b8 fc ff ff       	call   1130 <gettoken>
    if(gettoken(ps, es, &q, &eq) != 'a')
    1478:	89 74 24 04          	mov    %esi,0x4(%esp)
    147c:	89 3c 24             	mov    %edi,(%esp)
{
  int tok;
  char *q, *eq;

  while(peek(ps, es, "<>")){
    tok = gettoken(ps, es, 0, 0);
    147f:	89 c3                	mov    %eax,%ebx
    if(gettoken(ps, es, &q, &eq) != 'a')
    1481:	8d 45 e0             	lea    -0x20(%ebp),%eax
    1484:	89 44 24 0c          	mov    %eax,0xc(%esp)
    1488:	8d 45 e4             	lea    -0x1c(%ebp),%eax
    148b:	89 44 24 08          	mov    %eax,0x8(%esp)
    148f:	e8 9c fc ff ff       	call   1130 <gettoken>
    1494:	83 f8 61             	cmp    $0x61,%eax
    1497:	74 0c                	je     14a5 <parseredirs+0x75>
      panic("missing file for redirection");
    1499:	c7 04 24 b8 23 00 00 	movl   $0x23b8,(%esp)
    14a0:	e8 5b ff ff ff       	call   1400 <panic>
    switch(tok){
    14a5:	83 fb 3c             	cmp    $0x3c,%ebx
    14a8:	74 3e                	je     14e8 <parseredirs+0xb8>
    14aa:	83 fb 3e             	cmp    $0x3e,%ebx
    14ad:	74 05                	je     14b4 <parseredirs+0x84>
    14af:	83 fb 2b             	cmp    $0x2b,%ebx
    14b2:	75 8c                	jne    1440 <parseredirs+0x10>
      break;
    case '>':
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
      break;
    case '+':  // >>
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
    14b4:	c7 44 24 10 01 00 00 	movl   $0x1,0x10(%esp)
    14bb:	00 
    14bc:	c7 44 24 0c 01 02 00 	movl   $0x201,0xc(%esp)
    14c3:	00 
    14c4:	8b 45 e0             	mov    -0x20(%ebp),%eax
    14c7:	89 44 24 08          	mov    %eax,0x8(%esp)
    14cb:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    14ce:	89 44 24 04          	mov    %eax,0x4(%esp)
    14d2:	8b 45 08             	mov    0x8(%ebp),%eax
    14d5:	89 04 24             	mov    %eax,(%esp)
    14d8:	e8 83 fe ff ff       	call   1360 <redircmd>
    14dd:	89 45 08             	mov    %eax,0x8(%ebp)
    14e0:	e9 5b ff ff ff       	jmp    1440 <parseredirs+0x10>
    14e5:	8d 76 00             	lea    0x0(%esi),%esi
    tok = gettoken(ps, es, 0, 0);
    if(gettoken(ps, es, &q, &eq) != 'a')
      panic("missing file for redirection");
    switch(tok){
    case '<':
      cmd = redircmd(cmd, q, eq, O_RDONLY, 0);
    14e8:	c7 44 24 10 00 00 00 	movl   $0x0,0x10(%esp)
    14ef:	00 
    14f0:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
    14f7:	00 
    14f8:	eb ca                	jmp    14c4 <parseredirs+0x94>
    14fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
      break;
    }
  }
  return cmd;
}
    1500:	8b 45 08             	mov    0x8(%ebp),%eax
    1503:	83 c4 3c             	add    $0x3c,%esp
    1506:	5b                   	pop    %ebx
    1507:	5e                   	pop    %esi
    1508:	5f                   	pop    %edi
    1509:	5d                   	pop    %ebp
    150a:	c3                   	ret    
    150b:	90                   	nop
    150c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00001510 <parseexec>:
  return cmd;
}

struct cmd*
parseexec(char **ps, char *es)
{
    1510:	55                   	push   %ebp
    1511:	89 e5                	mov    %esp,%ebp
    1513:	57                   	push   %edi
    1514:	56                   	push   %esi
    1515:	53                   	push   %ebx
    1516:	83 ec 3c             	sub    $0x3c,%esp
    1519:	8b 75 08             	mov    0x8(%ebp),%esi
    151c:	8b 7d 0c             	mov    0xc(%ebp),%edi
  char *q, *eq;
  int tok, argc;
  struct execcmd *cmd;
  struct cmd *ret;

  if(peek(ps, es, "("))
    151f:	c7 44 24 08 d8 23 00 	movl   $0x23d8,0x8(%esp)
    1526:	00 
    1527:	89 34 24             	mov    %esi,(%esp)
    152a:	89 7c 24 04          	mov    %edi,0x4(%esp)
    152e:	e8 7d fb ff ff       	call   10b0 <peek>
    1533:	85 c0                	test   %eax,%eax
    1535:	0f 85 cd 00 00 00    	jne    1608 <parseexec+0xf8>
    return parseblock(ps, es);

  ret = execcmd();
    153b:	e8 80 fe ff ff       	call   13c0 <execcmd>
  cmd = (struct execcmd*)ret;

  argc = 0;
  ret = parseredirs(ret, ps, es);
    1540:	31 db                	xor    %ebx,%ebx
    1542:	89 7c 24 08          	mov    %edi,0x8(%esp)
    1546:	89 74 24 04          	mov    %esi,0x4(%esp)
  struct cmd *ret;

  if(peek(ps, es, "("))
    return parseblock(ps, es);

  ret = execcmd();
    154a:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  cmd = (struct execcmd*)ret;

  argc = 0;
  ret = parseredirs(ret, ps, es);
    154d:	89 04 24             	mov    %eax,(%esp)
    1550:	e8 db fe ff ff       	call   1430 <parseredirs>
    1555:	89 45 d0             	mov    %eax,-0x30(%ebp)
  while(!peek(ps, es, "|)&;")){
    1558:	eb 1c                	jmp    1576 <parseexec+0x66>
    155a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    cmd->argv[argc] = q;
    cmd->eargv[argc] = eq;
    argc++;
    if(argc >= MAXARGS)
      panic("too many args");
    ret = parseredirs(ret, ps, es);
    1560:	8b 45 d0             	mov    -0x30(%ebp),%eax
    1563:	89 7c 24 08          	mov    %edi,0x8(%esp)
    1567:	89 74 24 04          	mov    %esi,0x4(%esp)
    156b:	89 04 24             	mov    %eax,(%esp)
    156e:	e8 bd fe ff ff       	call   1430 <parseredirs>
    1573:	89 45 d0             	mov    %eax,-0x30(%ebp)
  ret = execcmd();
  cmd = (struct execcmd*)ret;

  argc = 0;
  ret = parseredirs(ret, ps, es);
  while(!peek(ps, es, "|)&;")){
    1576:	c7 44 24 08 ef 23 00 	movl   $0x23ef,0x8(%esp)
    157d:	00 
    157e:	89 7c 24 04          	mov    %edi,0x4(%esp)
    1582:	89 34 24             	mov    %esi,(%esp)
    1585:	e8 26 fb ff ff       	call   10b0 <peek>
    158a:	85 c0                	test   %eax,%eax
    158c:	75 5a                	jne    15e8 <parseexec+0xd8>
    if((tok=gettoken(ps, es, &q, &eq)) == 0)
    158e:	8d 45 e0             	lea    -0x20(%ebp),%eax
    1591:	8d 55 e4             	lea    -0x1c(%ebp),%edx
    1594:	89 44 24 0c          	mov    %eax,0xc(%esp)
    1598:	89 54 24 08          	mov    %edx,0x8(%esp)
    159c:	89 7c 24 04          	mov    %edi,0x4(%esp)
    15a0:	89 34 24             	mov    %esi,(%esp)
    15a3:	e8 88 fb ff ff       	call   1130 <gettoken>
    15a8:	85 c0                	test   %eax,%eax
    15aa:	74 3c                	je     15e8 <parseexec+0xd8>
      break;
    if(tok != 'a')
    15ac:	83 f8 61             	cmp    $0x61,%eax
    15af:	74 0c                	je     15bd <parseexec+0xad>
      panic("syntax");
    15b1:	c7 04 24 da 23 00 00 	movl   $0x23da,(%esp)
    15b8:	e8 43 fe ff ff       	call   1400 <panic>
    cmd->argv[argc] = q;
    15bd:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    15c0:	8b 55 d4             	mov    -0x2c(%ebp),%edx
    15c3:	89 44 9a 04          	mov    %eax,0x4(%edx,%ebx,4)
    cmd->eargv[argc] = eq;
    15c7:	8b 45 e0             	mov    -0x20(%ebp),%eax
    15ca:	89 44 9a 2c          	mov    %eax,0x2c(%edx,%ebx,4)
    argc++;
    15ce:	83 c3 01             	add    $0x1,%ebx
    if(argc >= MAXARGS)
    15d1:	83 fb 09             	cmp    $0x9,%ebx
    15d4:	7e 8a                	jle    1560 <parseexec+0x50>
      panic("too many args");
    15d6:	c7 04 24 e1 23 00 00 	movl   $0x23e1,(%esp)
    15dd:	e8 1e fe ff ff       	call   1400 <panic>
    15e2:	e9 79 ff ff ff       	jmp    1560 <parseexec+0x50>
    15e7:	90                   	nop
    ret = parseredirs(ret, ps, es);
  }
  cmd->argv[argc] = 0;
    15e8:	8b 55 d4             	mov    -0x2c(%ebp),%edx
    15eb:	c7 44 9a 04 00 00 00 	movl   $0x0,0x4(%edx,%ebx,4)
    15f2:	00 
  cmd->eargv[argc] = 0;
    15f3:	c7 44 9a 2c 00 00 00 	movl   $0x0,0x2c(%edx,%ebx,4)
    15fa:	00 
  return ret;
}
    15fb:	8b 45 d0             	mov    -0x30(%ebp),%eax
    15fe:	83 c4 3c             	add    $0x3c,%esp
    1601:	5b                   	pop    %ebx
    1602:	5e                   	pop    %esi
    1603:	5f                   	pop    %edi
    1604:	5d                   	pop    %ebp
    1605:	c3                   	ret    
    1606:	66 90                	xchg   %ax,%ax
  int tok, argc;
  struct execcmd *cmd;
  struct cmd *ret;

  if(peek(ps, es, "("))
    return parseblock(ps, es);
    1608:	89 7c 24 04          	mov    %edi,0x4(%esp)
    160c:	89 34 24             	mov    %esi,(%esp)
    160f:	e8 6c 01 00 00       	call   1780 <parseblock>
    1614:	89 45 d0             	mov    %eax,-0x30(%ebp)
    ret = parseredirs(ret, ps, es);
  }
  cmd->argv[argc] = 0;
  cmd->eargv[argc] = 0;
  return ret;
}
    1617:	8b 45 d0             	mov    -0x30(%ebp),%eax
    161a:	83 c4 3c             	add    $0x3c,%esp
    161d:	5b                   	pop    %ebx
    161e:	5e                   	pop    %esi
    161f:	5f                   	pop    %edi
    1620:	5d                   	pop    %ebp
    1621:	c3                   	ret    
    1622:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    1629:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001630 <parsepipe>:
  return cmd;
}

struct cmd*
parsepipe(char **ps, char *es)
{
    1630:	55                   	push   %ebp
    1631:	89 e5                	mov    %esp,%ebp
    1633:	83 ec 28             	sub    $0x28,%esp
    1636:	89 5d f4             	mov    %ebx,-0xc(%ebp)
    1639:	8b 5d 08             	mov    0x8(%ebp),%ebx
    163c:	89 75 f8             	mov    %esi,-0x8(%ebp)
    163f:	8b 75 0c             	mov    0xc(%ebp),%esi
    1642:	89 7d fc             	mov    %edi,-0x4(%ebp)
  struct cmd *cmd;

  cmd = parseexec(ps, es);
    1645:	89 1c 24             	mov    %ebx,(%esp)
    1648:	89 74 24 04          	mov    %esi,0x4(%esp)
    164c:	e8 bf fe ff ff       	call   1510 <parseexec>
  if(peek(ps, es, "|")){
    1651:	c7 44 24 08 f4 23 00 	movl   $0x23f4,0x8(%esp)
    1658:	00 
    1659:	89 74 24 04          	mov    %esi,0x4(%esp)
    165d:	89 1c 24             	mov    %ebx,(%esp)
struct cmd*
parsepipe(char **ps, char *es)
{
  struct cmd *cmd;

  cmd = parseexec(ps, es);
    1660:	89 c7                	mov    %eax,%edi
  if(peek(ps, es, "|")){
    1662:	e8 49 fa ff ff       	call   10b0 <peek>
    1667:	85 c0                	test   %eax,%eax
    1669:	75 15                	jne    1680 <parsepipe+0x50>
    gettoken(ps, es, 0, 0);
    cmd = pipecmd(cmd, parsepipe(ps, es));
  }
  return cmd;
}
    166b:	89 f8                	mov    %edi,%eax
    166d:	8b 5d f4             	mov    -0xc(%ebp),%ebx
    1670:	8b 75 f8             	mov    -0x8(%ebp),%esi
    1673:	8b 7d fc             	mov    -0x4(%ebp),%edi
    1676:	89 ec                	mov    %ebp,%esp
    1678:	5d                   	pop    %ebp
    1679:	c3                   	ret    
    167a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
{
  struct cmd *cmd;

  cmd = parseexec(ps, es);
  if(peek(ps, es, "|")){
    gettoken(ps, es, 0, 0);
    1680:	89 74 24 04          	mov    %esi,0x4(%esp)
    1684:	89 1c 24             	mov    %ebx,(%esp)
    1687:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
    168e:	00 
    168f:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
    1696:	00 
    1697:	e8 94 fa ff ff       	call   1130 <gettoken>
    cmd = pipecmd(cmd, parsepipe(ps, es));
    169c:	89 74 24 04          	mov    %esi,0x4(%esp)
    16a0:	89 1c 24             	mov    %ebx,(%esp)
    16a3:	e8 88 ff ff ff       	call   1630 <parsepipe>
  }
  return cmd;
}
    16a8:	8b 5d f4             	mov    -0xc(%ebp),%ebx
  struct cmd *cmd;

  cmd = parseexec(ps, es);
  if(peek(ps, es, "|")){
    gettoken(ps, es, 0, 0);
    cmd = pipecmd(cmd, parsepipe(ps, es));
    16ab:	89 7d 08             	mov    %edi,0x8(%ebp)
  }
  return cmd;
}
    16ae:	8b 75 f8             	mov    -0x8(%ebp),%esi
    16b1:	8b 7d fc             	mov    -0x4(%ebp),%edi
  struct cmd *cmd;

  cmd = parseexec(ps, es);
  if(peek(ps, es, "|")){
    gettoken(ps, es, 0, 0);
    cmd = pipecmd(cmd, parsepipe(ps, es));
    16b4:	89 45 0c             	mov    %eax,0xc(%ebp)
  }
  return cmd;
}
    16b7:	89 ec                	mov    %ebp,%esp
    16b9:	5d                   	pop    %ebp
  struct cmd *cmd;

  cmd = parseexec(ps, es);
  if(peek(ps, es, "|")){
    gettoken(ps, es, 0, 0);
    cmd = pipecmd(cmd, parsepipe(ps, es));
    16ba:	e9 51 fc ff ff       	jmp    1310 <pipecmd>
    16bf:	90                   	nop

000016c0 <parseline>:
  return cmd;
}

struct cmd*
parseline(char **ps, char *es)
{
    16c0:	55                   	push   %ebp
    16c1:	89 e5                	mov    %esp,%ebp
    16c3:	57                   	push   %edi
    16c4:	56                   	push   %esi
    16c5:	53                   	push   %ebx
    16c6:	83 ec 1c             	sub    $0x1c,%esp
    16c9:	8b 5d 08             	mov    0x8(%ebp),%ebx
    16cc:	8b 75 0c             	mov    0xc(%ebp),%esi
  struct cmd *cmd;

  cmd = parsepipe(ps, es);
    16cf:	89 1c 24             	mov    %ebx,(%esp)
    16d2:	89 74 24 04          	mov    %esi,0x4(%esp)
    16d6:	e8 55 ff ff ff       	call   1630 <parsepipe>
    16db:	89 c7                	mov    %eax,%edi
  while(peek(ps, es, "&")){
    16dd:	eb 27                	jmp    1706 <parseline+0x46>
    16df:	90                   	nop
    gettoken(ps, es, 0, 0);
    16e0:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
    16e7:	00 
    16e8:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
    16ef:	00 
    16f0:	89 74 24 04          	mov    %esi,0x4(%esp)
    16f4:	89 1c 24             	mov    %ebx,(%esp)
    16f7:	e8 34 fa ff ff       	call   1130 <gettoken>
    cmd = backcmd(cmd);
    16fc:	89 3c 24             	mov    %edi,(%esp)
    16ff:	e8 6c fb ff ff       	call   1270 <backcmd>
    1704:	89 c7                	mov    %eax,%edi
parseline(char **ps, char *es)
{
  struct cmd *cmd;

  cmd = parsepipe(ps, es);
  while(peek(ps, es, "&")){
    1706:	c7 44 24 08 f6 23 00 	movl   $0x23f6,0x8(%esp)
    170d:	00 
    170e:	89 74 24 04          	mov    %esi,0x4(%esp)
    1712:	89 1c 24             	mov    %ebx,(%esp)
    1715:	e8 96 f9 ff ff       	call   10b0 <peek>
    171a:	85 c0                	test   %eax,%eax
    171c:	75 c2                	jne    16e0 <parseline+0x20>
    gettoken(ps, es, 0, 0);
    cmd = backcmd(cmd);
  }
  if(peek(ps, es, ";")){
    171e:	c7 44 24 08 f2 23 00 	movl   $0x23f2,0x8(%esp)
    1725:	00 
    1726:	89 74 24 04          	mov    %esi,0x4(%esp)
    172a:	89 1c 24             	mov    %ebx,(%esp)
    172d:	e8 7e f9 ff ff       	call   10b0 <peek>
    1732:	85 c0                	test   %eax,%eax
    1734:	75 0a                	jne    1740 <parseline+0x80>
    gettoken(ps, es, 0, 0);
    cmd = listcmd(cmd, parseline(ps, es));
  }
  return cmd;
}
    1736:	83 c4 1c             	add    $0x1c,%esp
    1739:	89 f8                	mov    %edi,%eax
    173b:	5b                   	pop    %ebx
    173c:	5e                   	pop    %esi
    173d:	5f                   	pop    %edi
    173e:	5d                   	pop    %ebp
    173f:	c3                   	ret    
  while(peek(ps, es, "&")){
    gettoken(ps, es, 0, 0);
    cmd = backcmd(cmd);
  }
  if(peek(ps, es, ";")){
    gettoken(ps, es, 0, 0);
    1740:	89 74 24 04          	mov    %esi,0x4(%esp)
    1744:	89 1c 24             	mov    %ebx,(%esp)
    1747:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
    174e:	00 
    174f:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
    1756:	00 
    1757:	e8 d4 f9 ff ff       	call   1130 <gettoken>
    cmd = listcmd(cmd, parseline(ps, es));
    175c:	89 74 24 04          	mov    %esi,0x4(%esp)
    1760:	89 1c 24             	mov    %ebx,(%esp)
    1763:	e8 58 ff ff ff       	call   16c0 <parseline>
    1768:	89 7d 08             	mov    %edi,0x8(%ebp)
    176b:	89 45 0c             	mov    %eax,0xc(%ebp)
  }
  return cmd;
}
    176e:	83 c4 1c             	add    $0x1c,%esp
    1771:	5b                   	pop    %ebx
    1772:	5e                   	pop    %esi
    1773:	5f                   	pop    %edi
    1774:	5d                   	pop    %ebp
    gettoken(ps, es, 0, 0);
    cmd = backcmd(cmd);
  }
  if(peek(ps, es, ";")){
    gettoken(ps, es, 0, 0);
    cmd = listcmd(cmd, parseline(ps, es));
    1775:	e9 46 fb ff ff       	jmp    12c0 <listcmd>
    177a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00001780 <parseblock>:
  return cmd;
}

struct cmd*
parseblock(char **ps, char *es)
{
    1780:	55                   	push   %ebp
    1781:	89 e5                	mov    %esp,%ebp
    1783:	83 ec 28             	sub    $0x28,%esp
    1786:	89 5d f4             	mov    %ebx,-0xc(%ebp)
    1789:	8b 5d 08             	mov    0x8(%ebp),%ebx
    178c:	89 75 f8             	mov    %esi,-0x8(%ebp)
    178f:	8b 75 0c             	mov    0xc(%ebp),%esi
    1792:	89 7d fc             	mov    %edi,-0x4(%ebp)
  struct cmd *cmd;

  if(!peek(ps, es, "("))
    1795:	c7 44 24 08 d8 23 00 	movl   $0x23d8,0x8(%esp)
    179c:	00 
    179d:	89 1c 24             	mov    %ebx,(%esp)
    17a0:	89 74 24 04          	mov    %esi,0x4(%esp)
    17a4:	e8 07 f9 ff ff       	call   10b0 <peek>
    17a9:	85 c0                	test   %eax,%eax
    17ab:	0f 84 87 00 00 00    	je     1838 <parseblock+0xb8>
    panic("parseblock");
  gettoken(ps, es, 0, 0);
    17b1:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
    17b8:	00 
    17b9:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
    17c0:	00 
    17c1:	89 74 24 04          	mov    %esi,0x4(%esp)
    17c5:	89 1c 24             	mov    %ebx,(%esp)
    17c8:	e8 63 f9 ff ff       	call   1130 <gettoken>
  cmd = parseline(ps, es);
    17cd:	89 74 24 04          	mov    %esi,0x4(%esp)
    17d1:	89 1c 24             	mov    %ebx,(%esp)
    17d4:	e8 e7 fe ff ff       	call   16c0 <parseline>
  if(!peek(ps, es, ")"))
    17d9:	c7 44 24 08 14 24 00 	movl   $0x2414,0x8(%esp)
    17e0:	00 
    17e1:	89 74 24 04          	mov    %esi,0x4(%esp)
    17e5:	89 1c 24             	mov    %ebx,(%esp)
  struct cmd *cmd;

  if(!peek(ps, es, "("))
    panic("parseblock");
  gettoken(ps, es, 0, 0);
  cmd = parseline(ps, es);
    17e8:	89 c7                	mov    %eax,%edi
  if(!peek(ps, es, ")"))
    17ea:	e8 c1 f8 ff ff       	call   10b0 <peek>
    17ef:	85 c0                	test   %eax,%eax
    17f1:	75 0c                	jne    17ff <parseblock+0x7f>
    panic("syntax - missing )");
    17f3:	c7 04 24 03 24 00 00 	movl   $0x2403,(%esp)
    17fa:	e8 01 fc ff ff       	call   1400 <panic>
  gettoken(ps, es, 0, 0);
    17ff:	89 74 24 04          	mov    %esi,0x4(%esp)
    1803:	89 1c 24             	mov    %ebx,(%esp)
    1806:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
    180d:	00 
    180e:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
    1815:	00 
    1816:	e8 15 f9 ff ff       	call   1130 <gettoken>
  cmd = parseredirs(cmd, ps, es);
    181b:	89 74 24 08          	mov    %esi,0x8(%esp)
    181f:	89 5c 24 04          	mov    %ebx,0x4(%esp)
    1823:	89 3c 24             	mov    %edi,(%esp)
    1826:	e8 05 fc ff ff       	call   1430 <parseredirs>
  return cmd;
}
    182b:	8b 5d f4             	mov    -0xc(%ebp),%ebx
    182e:	8b 75 f8             	mov    -0x8(%ebp),%esi
    1831:	8b 7d fc             	mov    -0x4(%ebp),%edi
    1834:	89 ec                	mov    %ebp,%esp
    1836:	5d                   	pop    %ebp
    1837:	c3                   	ret    
parseblock(char **ps, char *es)
{
  struct cmd *cmd;

  if(!peek(ps, es, "("))
    panic("parseblock");
    1838:	c7 04 24 f8 23 00 00 	movl   $0x23f8,(%esp)
    183f:	e8 bc fb ff ff       	call   1400 <panic>
    1844:	e9 68 ff ff ff       	jmp    17b1 <parseblock+0x31>
    1849:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00001850 <parsecmd>:
struct cmd *parseexec(char**, char*);
struct cmd *nulterminate(struct cmd*);

struct cmd*
parsecmd(char *s)
{
    1850:	55                   	push   %ebp
    1851:	89 e5                	mov    %esp,%ebp
    1853:	56                   	push   %esi
    1854:	53                   	push   %ebx
    1855:	83 ec 10             	sub    $0x10,%esp
  char *es;
  struct cmd *cmd;

  es = s + strlen(s);
    1858:	8b 5d 08             	mov    0x8(%ebp),%ebx
    185b:	89 1c 24             	mov    %ebx,(%esp)
    185e:	e8 bd 04 00 00       	call   1d20 <strlen>
    1863:	01 c3                	add    %eax,%ebx
  cmd = parseline(&s, es);
    1865:	8d 45 08             	lea    0x8(%ebp),%eax
    1868:	89 5c 24 04          	mov    %ebx,0x4(%esp)
    186c:	89 04 24             	mov    %eax,(%esp)
    186f:	e8 4c fe ff ff       	call   16c0 <parseline>
  peek(&s, es, "");
    1874:	c7 44 24 08 43 24 00 	movl   $0x2443,0x8(%esp)
    187b:	00 
    187c:	89 5c 24 04          	mov    %ebx,0x4(%esp)
{
  char *es;
  struct cmd *cmd;

  es = s + strlen(s);
  cmd = parseline(&s, es);
    1880:	89 c6                	mov    %eax,%esi
  peek(&s, es, "");
    1882:	8d 45 08             	lea    0x8(%ebp),%eax
    1885:	89 04 24             	mov    %eax,(%esp)
    1888:	e8 23 f8 ff ff       	call   10b0 <peek>
  if(s != es){
    188d:	8b 45 08             	mov    0x8(%ebp),%eax
    1890:	39 d8                	cmp    %ebx,%eax
    1892:	74 24                	je     18b8 <parsecmd+0x68>
    printf(2, "leftovers: %s\n", s);
    1894:	89 44 24 08          	mov    %eax,0x8(%esp)
    1898:	c7 44 24 04 16 24 00 	movl   $0x2416,0x4(%esp)
    189f:	00 
    18a0:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
    18a7:	e8 74 07 00 00       	call   2020 <printf>
    panic("syntax");
    18ac:	c7 04 24 da 23 00 00 	movl   $0x23da,(%esp)
    18b3:	e8 48 fb ff ff       	call   1400 <panic>
  }
  nulterminate(cmd);
    18b8:	89 34 24             	mov    %esi,(%esp)
    18bb:	e8 40 f7 ff ff       	call   1000 <nulterminate>
  return cmd;
}
    18c0:	83 c4 10             	add    $0x10,%esp
    18c3:	89 f0                	mov    %esi,%eax
    18c5:	5b                   	pop    %ebx
    18c6:	5e                   	pop    %esi
    18c7:	5d                   	pop    %ebp
    18c8:	c3                   	ret    
    18c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000018d0 <fork1>:
  exit(0);
}

int
fork1(void)
{
    18d0:	55                   	push   %ebp
    18d1:	89 e5                	mov    %esp,%ebp
    18d3:	83 ec 28             	sub    $0x28,%esp
  int pid;

  pid = fork();
    18d6:	e8 e5 05 00 00       	call   1ec0 <fork>
  if(pid == -1)
    18db:	83 f8 ff             	cmp    $0xffffffff,%eax
    18de:	74 08                	je     18e8 <fork1+0x18>
    panic("fork");
  return pid;
}
    18e0:	c9                   	leave  
    18e1:	c3                   	ret    
    18e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
{
  int pid;

  pid = fork();
  if(pid == -1)
    panic("fork");
    18e8:	89 45 f4             	mov    %eax,-0xc(%ebp)
    18eb:	c7 04 24 25 24 00 00 	movl   $0x2425,(%esp)
    18f2:	e8 09 fb ff ff       	call   1400 <panic>
    18f7:	8b 45 f4             	mov    -0xc(%ebp),%eax
  return pid;
}
    18fa:	c9                   	leave  
    18fb:	c3                   	ret    
    18fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00001900 <getcmd>:
  exit(0);
}

int
getcmd(char *buf, int nbuf)
{
    1900:	55                   	push   %ebp
    1901:	89 e5                	mov    %esp,%ebp
    1903:	83 ec 18             	sub    $0x18,%esp
    1906:	89 5d f8             	mov    %ebx,-0x8(%ebp)
    1909:	8b 5d 08             	mov    0x8(%ebp),%ebx
    190c:	89 75 fc             	mov    %esi,-0x4(%ebp)
    190f:	8b 75 0c             	mov    0xc(%ebp),%esi
  printf(2, "$ ");
    1912:	c7 44 24 04 2a 24 00 	movl   $0x242a,0x4(%esp)
    1919:	00 
    191a:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
    1921:	e8 fa 06 00 00       	call   2020 <printf>
  memset(buf, 0, nbuf);
    1926:	89 74 24 08          	mov    %esi,0x8(%esp)
    192a:	89 1c 24             	mov    %ebx,(%esp)
    192d:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1934:	00 
    1935:	e8 06 04 00 00       	call   1d40 <memset>
  gets(buf, nbuf);
    193a:	89 74 24 04          	mov    %esi,0x4(%esp)
    193e:	89 1c 24             	mov    %ebx,(%esp)
    1941:	e8 1a 05 00 00       	call   1e60 <gets>
  if(buf[0] == 0) // EOF
    return -1;
  return 0;
}
    1946:	8b 75 fc             	mov    -0x4(%ebp),%esi
getcmd(char *buf, int nbuf)
{
  printf(2, "$ ");
  memset(buf, 0, nbuf);
  gets(buf, nbuf);
  if(buf[0] == 0) // EOF
    1949:	80 3b 01             	cmpb   $0x1,(%ebx)
    return -1;
  return 0;
}
    194c:	8b 5d f8             	mov    -0x8(%ebp),%ebx
getcmd(char *buf, int nbuf)
{
  printf(2, "$ ");
  memset(buf, 0, nbuf);
  gets(buf, nbuf);
  if(buf[0] == 0) // EOF
    194f:	19 c0                	sbb    %eax,%eax
    return -1;
  return 0;
}
    1951:	89 ec                	mov    %ebp,%esp
    1953:	5d                   	pop    %ebp
    1954:	c3                   	ret    
    1955:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1959:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001960 <runcmd>:
struct cmd *parsecmd(char*);

// Execute cmd.  Never returns.
void
runcmd(struct cmd *cmd)
{
    1960:	55                   	push   %ebp
    1961:	89 e5                	mov    %esp,%ebp
    1963:	53                   	push   %ebx
    1964:	83 ec 24             	sub    $0x24,%esp
    1967:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct execcmd *ecmd;
  struct listcmd *lcmd;
  struct pipecmd *pcmd;
  struct redircmd *rcmd;

  if(cmd == 0)
    196a:	85 db                	test   %ebx,%ebx
    196c:	74 42                	je     19b0 <runcmd+0x50>
    exit(0);

  switch(cmd->type){
    196e:	83 3b 05             	cmpl   $0x5,(%ebx)
    1971:	76 4d                	jbe    19c0 <runcmd+0x60>
  default:
    panic("runcmd");
    1973:	c7 04 24 2d 24 00 00 	movl   $0x242d,(%esp)
    197a:	e8 81 fa ff ff       	call   1400 <panic>

  case EXEC:
    ecmd = (struct execcmd*)cmd;
    if(ecmd->argv[0] == 0)
    197f:	8b 43 04             	mov    0x4(%ebx),%eax
    1982:	85 c0                	test   %eax,%eax
    1984:	74 2a                	je     19b0 <runcmd+0x50>
      exit(0);
    exec(ecmd->argv[0], ecmd->argv);
    1986:	8d 53 04             	lea    0x4(%ebx),%edx
    1989:	89 54 24 04          	mov    %edx,0x4(%esp)
    198d:	89 04 24             	mov    %eax,(%esp)
    1990:	e8 6b 05 00 00       	call   1f00 <exec>
    printf(2, "exec %s failed\n", ecmd->argv[0]);
    1995:	8b 43 04             	mov    0x4(%ebx),%eax
    1998:	c7 44 24 04 34 24 00 	movl   $0x2434,0x4(%esp)
    199f:	00 
    19a0:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
    19a7:	89 44 24 08          	mov    %eax,0x8(%esp)
    19ab:	e8 70 06 00 00       	call   2020 <printf>
    bcmd = (struct backcmd*)cmd;
    if(fork1() == 0)
      runcmd(bcmd->cmd);
    break;
  }
  exit(0);
    19b0:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    19b7:	e8 0c 05 00 00       	call   1ec8 <exit>
    19bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  struct redircmd *rcmd;

  if(cmd == 0)
    exit(0);

  switch(cmd->type){
    19c0:	8b 03                	mov    (%ebx),%eax
    19c2:	ff 24 85 a0 23 00 00 	jmp    *0x23a0(,%eax,4)
    19c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    wait(&exit_status);
    break;

  case BACK:
    bcmd = (struct backcmd*)cmd;
    if(fork1() == 0)
    19d0:	e8 fb fe ff ff       	call   18d0 <fork1>
    19d5:	85 c0                	test   %eax,%eax
    19d7:	0f 84 d0 00 00 00    	je     1aad <runcmd+0x14d>
      runcmd(bcmd->cmd);
    break;
  }
  exit(0);
    19dd:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    19e4:	e8 df 04 00 00       	call   1ec8 <exit>
    19e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    runcmd(rcmd->cmd);
    break;

  case LIST:
    lcmd = (struct listcmd*)cmd;
    if(fork1() == 0)
    19f0:	e8 db fe ff ff       	call   18d0 <fork1>
    19f5:	85 c0                	test   %eax,%eax
    19f7:	0f 84 cb 00 00 00    	je     1ac8 <runcmd+0x168>
      runcmd(lcmd->left);
    wait(&exit_status);
    19fd:	8d 45 f4             	lea    -0xc(%ebp),%eax
    1a00:	89 04 24             	mov    %eax,(%esp)
    1a03:	e8 c8 04 00 00       	call   1ed0 <wait>
    runcmd(lcmd->right);
    1a08:	8b 43 08             	mov    0x8(%ebx),%eax
    1a0b:	89 04 24             	mov    %eax,(%esp)
    1a0e:	e8 4d ff ff ff       	call   1960 <runcmd>
    bcmd = (struct backcmd*)cmd;
    if(fork1() == 0)
      runcmd(bcmd->cmd);
    break;
  }
  exit(0);
    1a13:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1a1a:	e8 a9 04 00 00       	call   1ec8 <exit>
    1a1f:	90                   	nop
    runcmd(lcmd->right);
    break;

  case PIPE:
    pcmd = (struct pipecmd*)cmd;
    if(pipe(p) < 0)
    1a20:	8d 45 ec             	lea    -0x14(%ebp),%eax
    1a23:	89 04 24             	mov    %eax,(%esp)
    1a26:	e8 ad 04 00 00       	call   1ed8 <pipe>
    1a2b:	85 c0                	test   %eax,%eax
    1a2d:	0f 88 4d 01 00 00    	js     1b80 <runcmd+0x220>
      panic("pipe");
    if(fork1() == 0){
    1a33:	e8 98 fe ff ff       	call   18d0 <fork1>
    1a38:	85 c0                	test   %eax,%eax
    1a3a:	0f 84 d8 00 00 00    	je     1b18 <runcmd+0x1b8>
      dup(p[1]);
      close(p[0]);
      close(p[1]);
      runcmd(pcmd->left);
    }
    if(fork1() == 0){
    1a40:	e8 8b fe ff ff       	call   18d0 <fork1>
    1a45:	85 c0                	test   %eax,%eax
    1a47:	0f 84 8b 00 00 00    	je     1ad8 <runcmd+0x178>
      dup(p[0]);
      close(p[0]);
      close(p[1]);
      runcmd(pcmd->right);
    }
    close(p[0]);
    1a4d:	8b 45 ec             	mov    -0x14(%ebp),%eax
    close(p[1]);
    wait(&exit_status);
    1a50:	8d 5d f4             	lea    -0xc(%ebp),%ebx
      dup(p[0]);
      close(p[0]);
      close(p[1]);
      runcmd(pcmd->right);
    }
    close(p[0]);
    1a53:	89 04 24             	mov    %eax,(%esp)
    1a56:	e8 95 04 00 00       	call   1ef0 <close>
    close(p[1]);
    1a5b:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1a5e:	89 04 24             	mov    %eax,(%esp)
    1a61:	e8 8a 04 00 00       	call   1ef0 <close>
    wait(&exit_status);
    1a66:	89 1c 24             	mov    %ebx,(%esp)
    1a69:	e8 62 04 00 00       	call   1ed0 <wait>
    wait(&exit_status);
    1a6e:	89 1c 24             	mov    %ebx,(%esp)
    1a71:	e8 5a 04 00 00       	call   1ed0 <wait>
    bcmd = (struct backcmd*)cmd;
    if(fork1() == 0)
      runcmd(bcmd->cmd);
    break;
  }
  exit(0);
    1a76:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1a7d:	e8 46 04 00 00       	call   1ec8 <exit>
    1a82:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    printf(2, "exec %s failed\n", ecmd->argv[0]);
    break;

  case REDIR:
    rcmd = (struct redircmd*)cmd;
    close(rcmd->fd);
    1a88:	8b 43 14             	mov    0x14(%ebx),%eax
    1a8b:	89 04 24             	mov    %eax,(%esp)
    1a8e:	e8 5d 04 00 00       	call   1ef0 <close>
    if(open(rcmd->file, rcmd->mode) < 0){
    1a93:	8b 43 10             	mov    0x10(%ebx),%eax
    1a96:	89 44 24 04          	mov    %eax,0x4(%esp)
    1a9a:	8b 43 08             	mov    0x8(%ebx),%eax
    1a9d:	89 04 24             	mov    %eax,(%esp)
    1aa0:	e8 63 04 00 00       	call   1f08 <open>
    1aa5:	85 c0                	test   %eax,%eax
    1aa7:	0f 88 ab 00 00 00    	js     1b58 <runcmd+0x1f8>
    break;

  case BACK:
    bcmd = (struct backcmd*)cmd;
    if(fork1() == 0)
      runcmd(bcmd->cmd);
    1aad:	8b 43 04             	mov    0x4(%ebx),%eax
    1ab0:	89 04 24             	mov    %eax,(%esp)
    1ab3:	e8 a8 fe ff ff       	call   1960 <runcmd>
    break;
  }
  exit(0);
    1ab8:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1abf:	e8 04 04 00 00       	call   1ec8 <exit>
    1ac4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    break;

  case LIST:
    lcmd = (struct listcmd*)cmd;
    if(fork1() == 0)
      runcmd(lcmd->left);
    1ac8:	8b 43 04             	mov    0x4(%ebx),%eax
    1acb:	89 04 24             	mov    %eax,(%esp)
    1ace:	e8 8d fe ff ff       	call   1960 <runcmd>
    1ad3:	e9 25 ff ff ff       	jmp    19fd <runcmd+0x9d>
      close(p[0]);
      close(p[1]);
      runcmd(pcmd->left);
    }
    if(fork1() == 0){
      close(0);
    1ad8:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1adf:	e8 0c 04 00 00       	call   1ef0 <close>
      dup(p[0]);
    1ae4:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1ae7:	89 04 24             	mov    %eax,(%esp)
    1aea:	e8 51 04 00 00       	call   1f40 <dup>
      close(p[0]);
    1aef:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1af2:	89 04 24             	mov    %eax,(%esp)
    1af5:	e8 f6 03 00 00       	call   1ef0 <close>
      close(p[1]);
    1afa:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1afd:	89 04 24             	mov    %eax,(%esp)
    1b00:	e8 eb 03 00 00       	call   1ef0 <close>
      runcmd(pcmd->right);
    1b05:	8b 43 08             	mov    0x8(%ebx),%eax
    1b08:	89 04 24             	mov    %eax,(%esp)
    1b0b:	e8 50 fe ff ff       	call   1960 <runcmd>
    1b10:	e9 38 ff ff ff       	jmp    1a4d <runcmd+0xed>
    1b15:	8d 76 00             	lea    0x0(%esi),%esi
  case PIPE:
    pcmd = (struct pipecmd*)cmd;
    if(pipe(p) < 0)
      panic("pipe");
    if(fork1() == 0){
      close(1);
    1b18:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1b1f:	e8 cc 03 00 00       	call   1ef0 <close>
      dup(p[1]);
    1b24:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1b27:	89 04 24             	mov    %eax,(%esp)
    1b2a:	e8 11 04 00 00       	call   1f40 <dup>
      close(p[0]);
    1b2f:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1b32:	89 04 24             	mov    %eax,(%esp)
    1b35:	e8 b6 03 00 00       	call   1ef0 <close>
      close(p[1]);
    1b3a:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1b3d:	89 04 24             	mov    %eax,(%esp)
    1b40:	e8 ab 03 00 00       	call   1ef0 <close>
      runcmd(pcmd->left);
    1b45:	8b 43 04             	mov    0x4(%ebx),%eax
    1b48:	89 04 24             	mov    %eax,(%esp)
    1b4b:	e8 10 fe ff ff       	call   1960 <runcmd>
    1b50:	e9 eb fe ff ff       	jmp    1a40 <runcmd+0xe0>
    1b55:	8d 76 00             	lea    0x0(%esi),%esi

  case REDIR:
    rcmd = (struct redircmd*)cmd;
    close(rcmd->fd);
    if(open(rcmd->file, rcmd->mode) < 0){
      printf(2, "open %s failed\n", rcmd->file);
    1b58:	8b 43 08             	mov    0x8(%ebx),%eax
    1b5b:	c7 44 24 04 44 24 00 	movl   $0x2444,0x4(%esp)
    1b62:	00 
    1b63:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
    1b6a:	89 44 24 08          	mov    %eax,0x8(%esp)
    1b6e:	e8 ad 04 00 00       	call   2020 <printf>
      exit(0);
    1b73:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1b7a:	e8 49 03 00 00       	call   1ec8 <exit>
    1b7f:	90                   	nop
    break;

  case PIPE:
    pcmd = (struct pipecmd*)cmd;
    if(pipe(p) < 0)
      panic("pipe");
    1b80:	c7 04 24 54 24 00 00 	movl   $0x2454,(%esp)
    1b87:	e8 74 f8 ff ff       	call   1400 <panic>
    1b8c:	e9 a2 fe ff ff       	jmp    1a33 <runcmd+0xd3>
    1b91:	eb 0d                	jmp    1ba0 <main>
    1b93:	90                   	nop
    1b94:	90                   	nop
    1b95:	90                   	nop
    1b96:	90                   	nop
    1b97:	90                   	nop
    1b98:	90                   	nop
    1b99:	90                   	nop
    1b9a:	90                   	nop
    1b9b:	90                   	nop
    1b9c:	90                   	nop
    1b9d:	90                   	nop
    1b9e:	90                   	nop
    1b9f:	90                   	nop

00001ba0 <main>:
  return 0;
}

int
main(void)
{
    1ba0:	55                   	push   %ebp
    1ba1:	89 e5                	mov    %esp,%ebp
    1ba3:	83 e4 f0             	and    $0xfffffff0,%esp
    1ba6:	53                   	push   %ebx
    1ba7:	83 ec 2c             	sub    $0x2c,%esp
    1baa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  static char buf[100];
  int fd, exit_status;

  // Ensure that three file descriptors are open.
  while((fd = open("console", O_RDWR)) >= 0){
    1bb0:	c7 44 24 04 02 00 00 	movl   $0x2,0x4(%esp)
    1bb7:	00 
    1bb8:	c7 04 24 59 24 00 00 	movl   $0x2459,(%esp)
    1bbf:	e8 44 03 00 00       	call   1f08 <open>
    1bc4:	85 c0                	test   %eax,%eax
    1bc6:	78 0d                	js     1bd5 <main+0x35>
    if(fd >= 3){
    1bc8:	83 f8 02             	cmp    $0x2,%eax
    1bcb:	7e e3                	jle    1bb0 <main+0x10>
      close(fd);
    1bcd:	89 04 24             	mov    %eax,(%esp)
    1bd0:	e8 1b 03 00 00       	call   1ef0 <close>
        printf(2, "cannot cd %s\n", buf+3);
      continue;
    }
    if(fork1() == 0)
      runcmd(parsecmd(buf));
    wait(&exit_status);
    1bd5:	8d 5c 24 1c          	lea    0x1c(%esp),%ebx
    1bd9:	eb 0d                	jmp    1be8 <main+0x48>
    1bdb:	90                   	nop
    1bdc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1be0:	89 1c 24             	mov    %ebx,(%esp)
    1be3:	e8 e8 02 00 00       	call   1ed0 <wait>
      break;
    }
  }

  // Read and run input commands.
  while(getcmd(buf, sizeof(buf)) >= 0){
    1be8:	c7 44 24 04 64 00 00 	movl   $0x64,0x4(%esp)
    1bef:	00 
    1bf0:	c7 04 24 a0 24 00 00 	movl   $0x24a0,(%esp)
    1bf7:	e8 04 fd ff ff       	call   1900 <getcmd>
    1bfc:	85 c0                	test   %eax,%eax
    1bfe:	0f 88 84 00 00 00    	js     1c88 <main+0xe8>
    if(buf[0] == 'c' && buf[1] == 'd' && buf[2] == ' '){
    1c04:	80 3d a0 24 00 00 63 	cmpb   $0x63,0x24a0
    1c0b:	75 09                	jne    1c16 <main+0x76>
    1c0d:	80 3d a1 24 00 00 64 	cmpb   $0x64,0x24a1
    1c14:	74 22                	je     1c38 <main+0x98>
      buf[strlen(buf)-1] = 0;  // chop \n
      if(chdir(buf+3) < 0)
        printf(2, "cannot cd %s\n", buf+3);
      continue;
    }
    if(fork1() == 0)
    1c16:	e8 b5 fc ff ff       	call   18d0 <fork1>
    1c1b:	85 c0                	test   %eax,%eax
    1c1d:	75 c1                	jne    1be0 <main+0x40>
      runcmd(parsecmd(buf));
    1c1f:	c7 04 24 a0 24 00 00 	movl   $0x24a0,(%esp)
    1c26:	e8 25 fc ff ff       	call   1850 <parsecmd>
    1c2b:	89 04 24             	mov    %eax,(%esp)
    1c2e:	e8 2d fd ff ff       	call   1960 <runcmd>
    1c33:	eb ab                	jmp    1be0 <main+0x40>
    1c35:	8d 76 00             	lea    0x0(%esi),%esi
    }
  }

  // Read and run input commands.
  while(getcmd(buf, sizeof(buf)) >= 0){
    if(buf[0] == 'c' && buf[1] == 'd' && buf[2] == ' '){
    1c38:	80 3d a2 24 00 00 20 	cmpb   $0x20,0x24a2
    1c3f:	75 d5                	jne    1c16 <main+0x76>
      // Chdir must be called by the parent, not the child.
      buf[strlen(buf)-1] = 0;  // chop \n
    1c41:	c7 04 24 a0 24 00 00 	movl   $0x24a0,(%esp)
    1c48:	e8 d3 00 00 00       	call   1d20 <strlen>
      if(chdir(buf+3) < 0)
    1c4d:	c7 04 24 a3 24 00 00 	movl   $0x24a3,(%esp)

  // Read and run input commands.
  while(getcmd(buf, sizeof(buf)) >= 0){
    if(buf[0] == 'c' && buf[1] == 'd' && buf[2] == ' '){
      // Chdir must be called by the parent, not the child.
      buf[strlen(buf)-1] = 0;  // chop \n
    1c54:	c6 80 9f 24 00 00 00 	movb   $0x0,0x249f(%eax)
      if(chdir(buf+3) < 0)
    1c5b:	e8 d8 02 00 00       	call   1f38 <chdir>
    1c60:	85 c0                	test   %eax,%eax
    1c62:	79 84                	jns    1be8 <main+0x48>
        printf(2, "cannot cd %s\n", buf+3);
    1c64:	c7 44 24 08 a3 24 00 	movl   $0x24a3,0x8(%esp)
    1c6b:	00 
    1c6c:	c7 44 24 04 61 24 00 	movl   $0x2461,0x4(%esp)
    1c73:	00 
    1c74:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
    1c7b:	e8 a0 03 00 00       	call   2020 <printf>
    1c80:	e9 63 ff ff ff       	jmp    1be8 <main+0x48>
    1c85:	8d 76 00             	lea    0x0(%esi),%esi
    }
    if(fork1() == 0)
      runcmd(parsecmd(buf));
    wait(&exit_status);
  }
  exit(0);
    1c88:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1c8f:	e8 34 02 00 00       	call   1ec8 <exit>
    1c94:	90                   	nop
    1c95:	90                   	nop
    1c96:	90                   	nop
    1c97:	90                   	nop
    1c98:	90                   	nop
    1c99:	90                   	nop
    1c9a:	90                   	nop
    1c9b:	90                   	nop
    1c9c:	90                   	nop
    1c9d:	90                   	nop
    1c9e:	90                   	nop
    1c9f:	90                   	nop

00001ca0 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
    1ca0:	55                   	push   %ebp
    1ca1:	31 d2                	xor    %edx,%edx
    1ca3:	89 e5                	mov    %esp,%ebp
    1ca5:	8b 45 08             	mov    0x8(%ebp),%eax
    1ca8:	53                   	push   %ebx
    1ca9:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    1cac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
    1cb0:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
    1cb4:	88 0c 10             	mov    %cl,(%eax,%edx,1)
    1cb7:	83 c2 01             	add    $0x1,%edx
    1cba:	84 c9                	test   %cl,%cl
    1cbc:	75 f2                	jne    1cb0 <strcpy+0x10>
    ;
  return os;
}
    1cbe:	5b                   	pop    %ebx
    1cbf:	5d                   	pop    %ebp
    1cc0:	c3                   	ret    
    1cc1:	eb 0d                	jmp    1cd0 <strcmp>
    1cc3:	90                   	nop
    1cc4:	90                   	nop
    1cc5:	90                   	nop
    1cc6:	90                   	nop
    1cc7:	90                   	nop
    1cc8:	90                   	nop
    1cc9:	90                   	nop
    1cca:	90                   	nop
    1ccb:	90                   	nop
    1ccc:	90                   	nop
    1ccd:	90                   	nop
    1cce:	90                   	nop
    1ccf:	90                   	nop

00001cd0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    1cd0:	55                   	push   %ebp
    1cd1:	89 e5                	mov    %esp,%ebp
    1cd3:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1cd6:	53                   	push   %ebx
    1cd7:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(*p && *p == *q)
    1cda:	0f b6 01             	movzbl (%ecx),%eax
    1cdd:	84 c0                	test   %al,%al
    1cdf:	75 14                	jne    1cf5 <strcmp+0x25>
    1ce1:	eb 25                	jmp    1d08 <strcmp+0x38>
    1ce3:	90                   	nop
    1ce4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    p++, q++;
    1ce8:	83 c1 01             	add    $0x1,%ecx
    1ceb:	83 c2 01             	add    $0x1,%edx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
    1cee:	0f b6 01             	movzbl (%ecx),%eax
    1cf1:	84 c0                	test   %al,%al
    1cf3:	74 13                	je     1d08 <strcmp+0x38>
    1cf5:	0f b6 1a             	movzbl (%edx),%ebx
    1cf8:	38 d8                	cmp    %bl,%al
    1cfa:	74 ec                	je     1ce8 <strcmp+0x18>
    1cfc:	0f b6 db             	movzbl %bl,%ebx
    1cff:	0f b6 c0             	movzbl %al,%eax
    1d02:	29 d8                	sub    %ebx,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
    1d04:	5b                   	pop    %ebx
    1d05:	5d                   	pop    %ebp
    1d06:	c3                   	ret    
    1d07:	90                   	nop
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
    1d08:	0f b6 1a             	movzbl (%edx),%ebx
    1d0b:	31 c0                	xor    %eax,%eax
    1d0d:	0f b6 db             	movzbl %bl,%ebx
    1d10:	29 d8                	sub    %ebx,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
    1d12:	5b                   	pop    %ebx
    1d13:	5d                   	pop    %ebp
    1d14:	c3                   	ret    
    1d15:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1d19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001d20 <strlen>:

uint
strlen(char *s)
{
    1d20:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
    1d21:	31 d2                	xor    %edx,%edx
  return (uchar)*p - (uchar)*q;
}

uint
strlen(char *s)
{
    1d23:	89 e5                	mov    %esp,%ebp
  int n;

  for(n = 0; s[n]; n++)
    1d25:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
}

uint
strlen(char *s)
{
    1d27:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
    1d2a:	80 39 00             	cmpb   $0x0,(%ecx)
    1d2d:	74 0c                	je     1d3b <strlen+0x1b>
    1d2f:	90                   	nop
    1d30:	83 c2 01             	add    $0x1,%edx
    1d33:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
    1d37:	89 d0                	mov    %edx,%eax
    1d39:	75 f5                	jne    1d30 <strlen+0x10>
    ;
  return n;
}
    1d3b:	5d                   	pop    %ebp
    1d3c:	c3                   	ret    
    1d3d:	8d 76 00             	lea    0x0(%esi),%esi

00001d40 <memset>:

void*
memset(void *dst, int c, uint n)
{
    1d40:	55                   	push   %ebp
    1d41:	89 e5                	mov    %esp,%ebp
    1d43:	8b 55 08             	mov    0x8(%ebp),%edx
    1d46:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
    1d47:	8b 4d 10             	mov    0x10(%ebp),%ecx
    1d4a:	8b 45 0c             	mov    0xc(%ebp),%eax
    1d4d:	89 d7                	mov    %edx,%edi
    1d4f:	fc                   	cld    
    1d50:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
    1d52:	89 d0                	mov    %edx,%eax
    1d54:	5f                   	pop    %edi
    1d55:	5d                   	pop    %ebp
    1d56:	c3                   	ret    
    1d57:	89 f6                	mov    %esi,%esi
    1d59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001d60 <strchr>:

char*
strchr(const char *s, char c)
{
    1d60:	55                   	push   %ebp
    1d61:	89 e5                	mov    %esp,%ebp
    1d63:	8b 45 08             	mov    0x8(%ebp),%eax
    1d66:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
    1d6a:	0f b6 10             	movzbl (%eax),%edx
    1d6d:	84 d2                	test   %dl,%dl
    1d6f:	75 11                	jne    1d82 <strchr+0x22>
    1d71:	eb 15                	jmp    1d88 <strchr+0x28>
    1d73:	90                   	nop
    1d74:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1d78:	83 c0 01             	add    $0x1,%eax
    1d7b:	0f b6 10             	movzbl (%eax),%edx
    1d7e:	84 d2                	test   %dl,%dl
    1d80:	74 06                	je     1d88 <strchr+0x28>
    if(*s == c)
    1d82:	38 ca                	cmp    %cl,%dl
    1d84:	75 f2                	jne    1d78 <strchr+0x18>
      return (char*)s;
  return 0;
}
    1d86:	5d                   	pop    %ebp
    1d87:	c3                   	ret    
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
    1d88:	31 c0                	xor    %eax,%eax
    if(*s == c)
      return (char*)s;
  return 0;
}
    1d8a:	5d                   	pop    %ebp
    1d8b:	90                   	nop
    1d8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1d90:	c3                   	ret    
    1d91:	eb 0d                	jmp    1da0 <atoi>
    1d93:	90                   	nop
    1d94:	90                   	nop
    1d95:	90                   	nop
    1d96:	90                   	nop
    1d97:	90                   	nop
    1d98:	90                   	nop
    1d99:	90                   	nop
    1d9a:	90                   	nop
    1d9b:	90                   	nop
    1d9c:	90                   	nop
    1d9d:	90                   	nop
    1d9e:	90                   	nop
    1d9f:	90                   	nop

00001da0 <atoi>:
  return r;
}

int
atoi(const char *s)
{
    1da0:	55                   	push   %ebp
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    1da1:	31 c0                	xor    %eax,%eax
  return r;
}

int
atoi(const char *s)
{
    1da3:	89 e5                	mov    %esp,%ebp
    1da5:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1da8:	53                   	push   %ebx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    1da9:	0f b6 11             	movzbl (%ecx),%edx
    1dac:	8d 5a d0             	lea    -0x30(%edx),%ebx
    1daf:	80 fb 09             	cmp    $0x9,%bl
    1db2:	77 1c                	ja     1dd0 <atoi+0x30>
    1db4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    n = n*10 + *s++ - '0';
    1db8:	0f be d2             	movsbl %dl,%edx
    1dbb:	83 c1 01             	add    $0x1,%ecx
    1dbe:	8d 04 80             	lea    (%eax,%eax,4),%eax
    1dc1:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    1dc5:	0f b6 11             	movzbl (%ecx),%edx
    1dc8:	8d 5a d0             	lea    -0x30(%edx),%ebx
    1dcb:	80 fb 09             	cmp    $0x9,%bl
    1dce:	76 e8                	jbe    1db8 <atoi+0x18>
    n = n*10 + *s++ - '0';
  return n;
}
    1dd0:	5b                   	pop    %ebx
    1dd1:	5d                   	pop    %ebp
    1dd2:	c3                   	ret    
    1dd3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    1dd9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001de0 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
    1de0:	55                   	push   %ebp
    1de1:	89 e5                	mov    %esp,%ebp
    1de3:	56                   	push   %esi
    1de4:	8b 45 08             	mov    0x8(%ebp),%eax
    1de7:	53                   	push   %ebx
    1de8:	8b 5d 10             	mov    0x10(%ebp),%ebx
    1deb:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    1dee:	85 db                	test   %ebx,%ebx
    1df0:	7e 14                	jle    1e06 <memmove+0x26>
    n = n*10 + *s++ - '0';
  return n;
}

void*
memmove(void *vdst, void *vsrc, int n)
    1df2:	31 d2                	xor    %edx,%edx
    1df4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    *dst++ = *src++;
    1df8:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
    1dfc:	88 0c 10             	mov    %cl,(%eax,%edx,1)
    1dff:	83 c2 01             	add    $0x1,%edx
{
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    1e02:	39 da                	cmp    %ebx,%edx
    1e04:	75 f2                	jne    1df8 <memmove+0x18>
    *dst++ = *src++;
  return vdst;
}
    1e06:	5b                   	pop    %ebx
    1e07:	5e                   	pop    %esi
    1e08:	5d                   	pop    %ebp
    1e09:	c3                   	ret    
    1e0a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00001e10 <stat>:
  return buf;
}

int
stat(char *n, struct stat *st)
{
    1e10:	55                   	push   %ebp
    1e11:	89 e5                	mov    %esp,%ebp
    1e13:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    1e16:	8b 45 08             	mov    0x8(%ebp),%eax
  return buf;
}

int
stat(char *n, struct stat *st)
{
    1e19:	89 5d f8             	mov    %ebx,-0x8(%ebp)
    1e1c:	89 75 fc             	mov    %esi,-0x4(%ebp)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    1e1f:	be ff ff ff ff       	mov    $0xffffffff,%esi
stat(char *n, struct stat *st)
{
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    1e24:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1e2b:	00 
    1e2c:	89 04 24             	mov    %eax,(%esp)
    1e2f:	e8 d4 00 00 00       	call   1f08 <open>
  if(fd < 0)
    1e34:	85 c0                	test   %eax,%eax
stat(char *n, struct stat *st)
{
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    1e36:	89 c3                	mov    %eax,%ebx
  if(fd < 0)
    1e38:	78 19                	js     1e53 <stat+0x43>
    return -1;
  r = fstat(fd, st);
    1e3a:	8b 45 0c             	mov    0xc(%ebp),%eax
    1e3d:	89 1c 24             	mov    %ebx,(%esp)
    1e40:	89 44 24 04          	mov    %eax,0x4(%esp)
    1e44:	e8 d7 00 00 00       	call   1f20 <fstat>
  close(fd);
    1e49:	89 1c 24             	mov    %ebx,(%esp)
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
  r = fstat(fd, st);
    1e4c:	89 c6                	mov    %eax,%esi
  close(fd);
    1e4e:	e8 9d 00 00 00       	call   1ef0 <close>
  return r;
}
    1e53:	89 f0                	mov    %esi,%eax
    1e55:	8b 5d f8             	mov    -0x8(%ebp),%ebx
    1e58:	8b 75 fc             	mov    -0x4(%ebp),%esi
    1e5b:	89 ec                	mov    %ebp,%esp
    1e5d:	5d                   	pop    %ebp
    1e5e:	c3                   	ret    
    1e5f:	90                   	nop

00001e60 <gets>:
  return 0;
}

char*
gets(char *buf, int max)
{
    1e60:	55                   	push   %ebp
    1e61:	89 e5                	mov    %esp,%ebp
    1e63:	57                   	push   %edi
    1e64:	56                   	push   %esi
    1e65:	31 f6                	xor    %esi,%esi
    1e67:	53                   	push   %ebx
    1e68:	83 ec 2c             	sub    $0x2c,%esp
    1e6b:	8b 7d 08             	mov    0x8(%ebp),%edi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    1e6e:	eb 06                	jmp    1e76 <gets+0x16>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
    1e70:	3c 0a                	cmp    $0xa,%al
    1e72:	74 39                	je     1ead <gets+0x4d>
    1e74:	89 de                	mov    %ebx,%esi
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    1e76:	8d 5e 01             	lea    0x1(%esi),%ebx
    1e79:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
    1e7c:	7d 31                	jge    1eaf <gets+0x4f>
    cc = read(0, &c, 1);
    1e7e:	8d 45 e7             	lea    -0x19(%ebp),%eax
    1e81:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    1e88:	00 
    1e89:	89 44 24 04          	mov    %eax,0x4(%esp)
    1e8d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1e94:	e8 47 00 00 00       	call   1ee0 <read>
    if(cc < 1)
    1e99:	85 c0                	test   %eax,%eax
    1e9b:	7e 12                	jle    1eaf <gets+0x4f>
      break;
    buf[i++] = c;
    1e9d:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
    1ea1:	88 44 1f ff          	mov    %al,-0x1(%edi,%ebx,1)
    if(c == '\n' || c == '\r')
    1ea5:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
    1ea9:	3c 0d                	cmp    $0xd,%al
    1eab:	75 c3                	jne    1e70 <gets+0x10>
    1ead:	89 de                	mov    %ebx,%esi
      break;
  }
  buf[i] = '\0';
    1eaf:	c6 04 37 00          	movb   $0x0,(%edi,%esi,1)
  return buf;
}
    1eb3:	89 f8                	mov    %edi,%eax
    1eb5:	83 c4 2c             	add    $0x2c,%esp
    1eb8:	5b                   	pop    %ebx
    1eb9:	5e                   	pop    %esi
    1eba:	5f                   	pop    %edi
    1ebb:	5d                   	pop    %ebp
    1ebc:	c3                   	ret    
    1ebd:	90                   	nop
    1ebe:	90                   	nop
    1ebf:	90                   	nop

00001ec0 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    1ec0:	b8 01 00 00 00       	mov    $0x1,%eax
    1ec5:	cd 40                	int    $0x40
    1ec7:	c3                   	ret    

00001ec8 <exit>:
SYSCALL(exit)
    1ec8:	b8 02 00 00 00       	mov    $0x2,%eax
    1ecd:	cd 40                	int    $0x40
    1ecf:	c3                   	ret    

00001ed0 <wait>:
SYSCALL(wait)
    1ed0:	b8 03 00 00 00       	mov    $0x3,%eax
    1ed5:	cd 40                	int    $0x40
    1ed7:	c3                   	ret    

00001ed8 <pipe>:
SYSCALL(pipe)
    1ed8:	b8 04 00 00 00       	mov    $0x4,%eax
    1edd:	cd 40                	int    $0x40
    1edf:	c3                   	ret    

00001ee0 <read>:
SYSCALL(read)
    1ee0:	b8 05 00 00 00       	mov    $0x5,%eax
    1ee5:	cd 40                	int    $0x40
    1ee7:	c3                   	ret    

00001ee8 <write>:
SYSCALL(write)
    1ee8:	b8 10 00 00 00       	mov    $0x10,%eax
    1eed:	cd 40                	int    $0x40
    1eef:	c3                   	ret    

00001ef0 <close>:
SYSCALL(close)
    1ef0:	b8 15 00 00 00       	mov    $0x15,%eax
    1ef5:	cd 40                	int    $0x40
    1ef7:	c3                   	ret    

00001ef8 <kill>:
SYSCALL(kill)
    1ef8:	b8 06 00 00 00       	mov    $0x6,%eax
    1efd:	cd 40                	int    $0x40
    1eff:	c3                   	ret    

00001f00 <exec>:
SYSCALL(exec)
    1f00:	b8 07 00 00 00       	mov    $0x7,%eax
    1f05:	cd 40                	int    $0x40
    1f07:	c3                   	ret    

00001f08 <open>:
SYSCALL(open)
    1f08:	b8 0f 00 00 00       	mov    $0xf,%eax
    1f0d:	cd 40                	int    $0x40
    1f0f:	c3                   	ret    

00001f10 <mknod>:
SYSCALL(mknod)
    1f10:	b8 11 00 00 00       	mov    $0x11,%eax
    1f15:	cd 40                	int    $0x40
    1f17:	c3                   	ret    

00001f18 <unlink>:
SYSCALL(unlink)
    1f18:	b8 12 00 00 00       	mov    $0x12,%eax
    1f1d:	cd 40                	int    $0x40
    1f1f:	c3                   	ret    

00001f20 <fstat>:
SYSCALL(fstat)
    1f20:	b8 08 00 00 00       	mov    $0x8,%eax
    1f25:	cd 40                	int    $0x40
    1f27:	c3                   	ret    

00001f28 <link>:
SYSCALL(link)
    1f28:	b8 13 00 00 00       	mov    $0x13,%eax
    1f2d:	cd 40                	int    $0x40
    1f2f:	c3                   	ret    

00001f30 <mkdir>:
SYSCALL(mkdir)
    1f30:	b8 14 00 00 00       	mov    $0x14,%eax
    1f35:	cd 40                	int    $0x40
    1f37:	c3                   	ret    

00001f38 <chdir>:
SYSCALL(chdir)
    1f38:	b8 09 00 00 00       	mov    $0x9,%eax
    1f3d:	cd 40                	int    $0x40
    1f3f:	c3                   	ret    

00001f40 <dup>:
SYSCALL(dup)
    1f40:	b8 0a 00 00 00       	mov    $0xa,%eax
    1f45:	cd 40                	int    $0x40
    1f47:	c3                   	ret    

00001f48 <getpid>:
SYSCALL(getpid)
    1f48:	b8 0b 00 00 00       	mov    $0xb,%eax
    1f4d:	cd 40                	int    $0x40
    1f4f:	c3                   	ret    

00001f50 <sbrk>:
SYSCALL(sbrk)
    1f50:	b8 0c 00 00 00       	mov    $0xc,%eax
    1f55:	cd 40                	int    $0x40
    1f57:	c3                   	ret    

00001f58 <sleep>:
SYSCALL(sleep)
    1f58:	b8 0d 00 00 00       	mov    $0xd,%eax
    1f5d:	cd 40                	int    $0x40
    1f5f:	c3                   	ret    

00001f60 <uptime>:
SYSCALL(uptime)
    1f60:	b8 0e 00 00 00       	mov    $0xe,%eax
    1f65:	cd 40                	int    $0x40
    1f67:	c3                   	ret    

00001f68 <hello>:
SYSCALL(hello)
    1f68:	b8 16 00 00 00       	mov    $0x16,%eax
    1f6d:	cd 40                	int    $0x40
    1f6f:	c3                   	ret    

00001f70 <waitpid>:
SYSCALL(waitpid)
    1f70:	b8 17 00 00 00       	mov    $0x17,%eax
    1f75:	cd 40                	int    $0x40
    1f77:	c3                   	ret    

00001f78 <setpriority>:
SYSCALL(setpriority)
    1f78:	b8 18 00 00 00       	mov    $0x18,%eax
    1f7d:	cd 40                	int    $0x40
    1f7f:	c3                   	ret    

00001f80 <v2p>:
SYSCALL(v2p)
    1f80:	b8 19 00 00 00       	mov    $0x19,%eax
    1f85:	cd 40                	int    $0x40
    1f87:	c3                   	ret    
    1f88:	90                   	nop
    1f89:	90                   	nop
    1f8a:	90                   	nop
    1f8b:	90                   	nop
    1f8c:	90                   	nop
    1f8d:	90                   	nop
    1f8e:	90                   	nop
    1f8f:	90                   	nop

00001f90 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
    1f90:	55                   	push   %ebp
    1f91:	89 e5                	mov    %esp,%ebp
    1f93:	57                   	push   %edi
    1f94:	89 cf                	mov    %ecx,%edi
    1f96:	56                   	push   %esi
    1f97:	89 c6                	mov    %eax,%esi
    1f99:	53                   	push   %ebx
    1f9a:	83 ec 4c             	sub    $0x4c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    1f9d:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1fa0:	85 c9                	test   %ecx,%ecx
    1fa2:	74 04                	je     1fa8 <printint+0x18>
    1fa4:	85 d2                	test   %edx,%edx
    1fa6:	78 68                	js     2010 <printint+0x80>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
    1fa8:	89 d0                	mov    %edx,%eax
    1faa:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
    1fb1:	31 c9                	xor    %ecx,%ecx
    1fb3:	8d 5d d7             	lea    -0x29(%ebp),%ebx
    1fb6:	66 90                	xchg   %ax,%ax
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
    1fb8:	31 d2                	xor    %edx,%edx
    1fba:	f7 f7                	div    %edi
    1fbc:	0f b6 92 76 24 00 00 	movzbl 0x2476(%edx),%edx
    1fc3:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
    1fc6:	83 c1 01             	add    $0x1,%ecx
  }while((x /= base) != 0);
    1fc9:	85 c0                	test   %eax,%eax
    1fcb:	75 eb                	jne    1fb8 <printint+0x28>
  if(neg)
    1fcd:	8b 45 c4             	mov    -0x3c(%ebp),%eax
    1fd0:	85 c0                	test   %eax,%eax
    1fd2:	74 08                	je     1fdc <printint+0x4c>
    buf[i++] = '-';
    1fd4:	c6 44 0d d7 2d       	movb   $0x2d,-0x29(%ebp,%ecx,1)
    1fd9:	83 c1 01             	add    $0x1,%ecx

  while(--i >= 0)
    1fdc:	8d 79 ff             	lea    -0x1(%ecx),%edi
    1fdf:	90                   	nop
    1fe0:	0f b6 04 3b          	movzbl (%ebx,%edi,1),%eax
    1fe4:	83 ef 01             	sub    $0x1,%edi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    1fe7:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    1fee:	00 
    1fef:	89 34 24             	mov    %esi,(%esp)
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
    1ff2:	88 45 e7             	mov    %al,-0x19(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    1ff5:	8d 45 e7             	lea    -0x19(%ebp),%eax
    1ff8:	89 44 24 04          	mov    %eax,0x4(%esp)
    1ffc:	e8 e7 fe ff ff       	call   1ee8 <write>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
    2001:	83 ff ff             	cmp    $0xffffffff,%edi
    2004:	75 da                	jne    1fe0 <printint+0x50>
    putc(fd, buf[i]);
}
    2006:	83 c4 4c             	add    $0x4c,%esp
    2009:	5b                   	pop    %ebx
    200a:	5e                   	pop    %esi
    200b:	5f                   	pop    %edi
    200c:	5d                   	pop    %ebp
    200d:	c3                   	ret    
    200e:	66 90                	xchg   %ax,%ax
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
    2010:	89 d0                	mov    %edx,%eax
    2012:	f7 d8                	neg    %eax
    2014:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
    201b:	eb 94                	jmp    1fb1 <printint+0x21>
    201d:	8d 76 00             	lea    0x0(%esi),%esi

00002020 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
    2020:	55                   	push   %ebp
    2021:	89 e5                	mov    %esp,%ebp
    2023:	57                   	push   %edi
    2024:	56                   	push   %esi
    2025:	53                   	push   %ebx
    2026:	83 ec 3c             	sub    $0x3c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    2029:	8b 45 0c             	mov    0xc(%ebp),%eax
    202c:	0f b6 10             	movzbl (%eax),%edx
    202f:	84 d2                	test   %dl,%dl
    2031:	0f 84 c1 00 00 00    	je     20f8 <printf+0xd8>
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
    2037:	8d 4d 10             	lea    0x10(%ebp),%ecx
    203a:	31 ff                	xor    %edi,%edi
    203c:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
    203f:	31 db                	xor    %ebx,%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    2041:	8d 75 e7             	lea    -0x19(%ebp),%esi
    2044:	eb 1e                	jmp    2064 <printf+0x44>
    2046:	66 90                	xchg   %ax,%ax
  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
    2048:	83 fa 25             	cmp    $0x25,%edx
    204b:	0f 85 af 00 00 00    	jne    2100 <printf+0xe0>
    2051:	66 bf 25 00          	mov    $0x25,%di
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    2055:	83 c3 01             	add    $0x1,%ebx
    2058:	0f b6 14 18          	movzbl (%eax,%ebx,1),%edx
    205c:	84 d2                	test   %dl,%dl
    205e:	0f 84 94 00 00 00    	je     20f8 <printf+0xd8>
    c = fmt[i] & 0xff;
    if(state == 0){
    2064:	85 ff                	test   %edi,%edi
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    2066:	0f b6 d2             	movzbl %dl,%edx
    if(state == 0){
    2069:	74 dd                	je     2048 <printf+0x28>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
    206b:	83 ff 25             	cmp    $0x25,%edi
    206e:	75 e5                	jne    2055 <printf+0x35>
      if(c == 'd'){
    2070:	83 fa 64             	cmp    $0x64,%edx
    2073:	0f 84 3f 01 00 00    	je     21b8 <printf+0x198>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
    2079:	83 fa 70             	cmp    $0x70,%edx
    207c:	0f 84 a6 00 00 00    	je     2128 <printf+0x108>
    2082:	83 fa 78             	cmp    $0x78,%edx
    2085:	0f 84 9d 00 00 00    	je     2128 <printf+0x108>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
    208b:	83 fa 73             	cmp    $0x73,%edx
    208e:	66 90                	xchg   %ax,%ax
    2090:	0f 84 ba 00 00 00    	je     2150 <printf+0x130>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    2096:	83 fa 63             	cmp    $0x63,%edx
    2099:	0f 84 41 01 00 00    	je     21e0 <printf+0x1c0>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
    209f:	83 fa 25             	cmp    $0x25,%edx
    20a2:	0f 84 00 01 00 00    	je     21a8 <printf+0x188>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    20a8:	8b 4d 08             	mov    0x8(%ebp),%ecx
    20ab:	89 55 cc             	mov    %edx,-0x34(%ebp)
    20ae:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
    20b2:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    20b9:	00 
    20ba:	89 74 24 04          	mov    %esi,0x4(%esp)
    20be:	89 0c 24             	mov    %ecx,(%esp)
    20c1:	e8 22 fe ff ff       	call   1ee8 <write>
    20c6:	8b 55 cc             	mov    -0x34(%ebp),%edx
    20c9:	88 55 e7             	mov    %dl,-0x19(%ebp)
    20cc:	8b 45 08             	mov    0x8(%ebp),%eax
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    20cf:	83 c3 01             	add    $0x1,%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    20d2:	31 ff                	xor    %edi,%edi
    20d4:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    20db:	00 
    20dc:	89 74 24 04          	mov    %esi,0x4(%esp)
    20e0:	89 04 24             	mov    %eax,(%esp)
    20e3:	e8 00 fe ff ff       	call   1ee8 <write>
    20e8:	8b 45 0c             	mov    0xc(%ebp),%eax
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    20eb:	0f b6 14 18          	movzbl (%eax,%ebx,1),%edx
    20ef:	84 d2                	test   %dl,%dl
    20f1:	0f 85 6d ff ff ff    	jne    2064 <printf+0x44>
    20f7:	90                   	nop
        putc(fd, c);
      }
      state = 0;
    }
  }
}
    20f8:	83 c4 3c             	add    $0x3c,%esp
    20fb:	5b                   	pop    %ebx
    20fc:	5e                   	pop    %esi
    20fd:	5f                   	pop    %edi
    20fe:	5d                   	pop    %ebp
    20ff:	c3                   	ret    
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    2100:	8b 45 08             	mov    0x8(%ebp),%eax
  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
    2103:	88 55 e7             	mov    %dl,-0x19(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    2106:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    210d:	00 
    210e:	89 74 24 04          	mov    %esi,0x4(%esp)
    2112:	89 04 24             	mov    %eax,(%esp)
    2115:	e8 ce fd ff ff       	call   1ee8 <write>
    211a:	8b 45 0c             	mov    0xc(%ebp),%eax
    211d:	e9 33 ff ff ff       	jmp    2055 <printf+0x35>
    2122:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
    2128:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    212b:	b9 10 00 00 00       	mov    $0x10,%ecx
        ap++;
    2130:	31 ff                	xor    %edi,%edi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
    2132:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2139:	8b 10                	mov    (%eax),%edx
    213b:	8b 45 08             	mov    0x8(%ebp),%eax
    213e:	e8 4d fe ff ff       	call   1f90 <printint>
    2143:	8b 45 0c             	mov    0xc(%ebp),%eax
        ap++;
    2146:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
    214a:	e9 06 ff ff ff       	jmp    2055 <printf+0x35>
    214f:	90                   	nop
      } else if(c == 's'){
        s = (char*)*ap;
    2150:	8b 55 d4             	mov    -0x2c(%ebp),%edx
        ap++;
        if(s == 0)
    2153:	b9 6f 24 00 00       	mov    $0x246f,%ecx
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
        s = (char*)*ap;
    2158:	8b 3a                	mov    (%edx),%edi
        ap++;
    215a:	83 c2 04             	add    $0x4,%edx
    215d:	89 55 d4             	mov    %edx,-0x2c(%ebp)
        if(s == 0)
    2160:	85 ff                	test   %edi,%edi
    2162:	0f 44 f9             	cmove  %ecx,%edi
          s = "(null)";
        while(*s != 0){
    2165:	0f b6 17             	movzbl (%edi),%edx
    2168:	84 d2                	test   %dl,%dl
    216a:	74 33                	je     219f <printf+0x17f>
    216c:	89 5d d0             	mov    %ebx,-0x30(%ebp)
    216f:	8b 5d 08             	mov    0x8(%ebp),%ebx
    2172:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
          putc(fd, *s);
          s++;
    2178:	83 c7 01             	add    $0x1,%edi
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
    217b:	88 55 e7             	mov    %dl,-0x19(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    217e:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    2185:	00 
    2186:	89 74 24 04          	mov    %esi,0x4(%esp)
    218a:	89 1c 24             	mov    %ebx,(%esp)
    218d:	e8 56 fd ff ff       	call   1ee8 <write>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
    2192:	0f b6 17             	movzbl (%edi),%edx
    2195:	84 d2                	test   %dl,%dl
    2197:	75 df                	jne    2178 <printf+0x158>
    2199:	8b 5d d0             	mov    -0x30(%ebp),%ebx
    219c:	8b 45 0c             	mov    0xc(%ebp),%eax
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    219f:	31 ff                	xor    %edi,%edi
    21a1:	e9 af fe ff ff       	jmp    2055 <printf+0x35>
    21a6:	66 90                	xchg   %ax,%ax
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
    21a8:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
    21ac:	e9 1b ff ff ff       	jmp    20cc <printf+0xac>
    21b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
    21b8:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    21bb:	b9 0a 00 00 00       	mov    $0xa,%ecx
        ap++;
    21c0:	66 31 ff             	xor    %di,%di
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
    21c3:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    21ca:	8b 10                	mov    (%eax),%edx
    21cc:	8b 45 08             	mov    0x8(%ebp),%eax
    21cf:	e8 bc fd ff ff       	call   1f90 <printint>
    21d4:	8b 45 0c             	mov    0xc(%ebp),%eax
        ap++;
    21d7:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
    21db:	e9 75 fe ff ff       	jmp    2055 <printf+0x35>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    21e0:	8b 55 d4             	mov    -0x2c(%ebp),%edx
        putc(fd, *ap);
        ap++;
    21e3:	31 ff                	xor    %edi,%edi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    21e5:	8b 4d 08             	mov    0x8(%ebp),%ecx
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    21e8:	8b 02                	mov    (%edx),%eax
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    21ea:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    21f1:	00 
    21f2:	89 74 24 04          	mov    %esi,0x4(%esp)
    21f6:	89 0c 24             	mov    %ecx,(%esp)
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    21f9:	88 45 e7             	mov    %al,-0x19(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    21fc:	e8 e7 fc ff ff       	call   1ee8 <write>
    2201:	8b 45 0c             	mov    0xc(%ebp),%eax
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
        ap++;
    2204:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
    2208:	e9 48 fe ff ff       	jmp    2055 <printf+0x35>
    220d:	90                   	nop
    220e:	90                   	nop
    220f:	90                   	nop

00002210 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    2210:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    2211:	a1 0c 25 00 00       	mov    0x250c,%eax
static Header base;
static Header *freep;

void
free(void *ap)
{
    2216:	89 e5                	mov    %esp,%ebp
    2218:	57                   	push   %edi
    2219:	56                   	push   %esi
    221a:	53                   	push   %ebx
    221b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
    221e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    2221:	39 c8                	cmp    %ecx,%eax
    2223:	73 1d                	jae    2242 <free+0x32>
    2225:	8d 76 00             	lea    0x0(%esi),%esi
    2228:	8b 10                	mov    (%eax),%edx
    222a:	39 d1                	cmp    %edx,%ecx
    222c:	72 1a                	jb     2248 <free+0x38>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    222e:	39 d0                	cmp    %edx,%eax
    2230:	72 08                	jb     223a <free+0x2a>
    2232:	39 c8                	cmp    %ecx,%eax
    2234:	72 12                	jb     2248 <free+0x38>
    2236:	39 d1                	cmp    %edx,%ecx
    2238:	72 0e                	jb     2248 <free+0x38>
    223a:	89 d0                	mov    %edx,%eax
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    223c:	39 c8                	cmp    %ecx,%eax
    223e:	66 90                	xchg   %ax,%ax
    2240:	72 e6                	jb     2228 <free+0x18>
    2242:	8b 10                	mov    (%eax),%edx
    2244:	eb e8                	jmp    222e <free+0x1e>
    2246:	66 90                	xchg   %ax,%ax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    2248:	8b 71 04             	mov    0x4(%ecx),%esi
    224b:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    224e:	39 d7                	cmp    %edx,%edi
    2250:	74 19                	je     226b <free+0x5b>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
    2252:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    2255:	8b 50 04             	mov    0x4(%eax),%edx
    2258:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    225b:	39 ce                	cmp    %ecx,%esi
    225d:	74 23                	je     2282 <free+0x72>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
    225f:	89 08                	mov    %ecx,(%eax)
  freep = p;
    2261:	a3 0c 25 00 00       	mov    %eax,0x250c
}
    2266:	5b                   	pop    %ebx
    2267:	5e                   	pop    %esi
    2268:	5f                   	pop    %edi
    2269:	5d                   	pop    %ebp
    226a:	c3                   	ret    
  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
    226b:	03 72 04             	add    0x4(%edx),%esi
    226e:	89 71 04             	mov    %esi,0x4(%ecx)
    bp->s.ptr = p->s.ptr->s.ptr;
    2271:	8b 10                	mov    (%eax),%edx
    2273:	8b 12                	mov    (%edx),%edx
    2275:	89 53 f8             	mov    %edx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    2278:	8b 50 04             	mov    0x4(%eax),%edx
    227b:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    227e:	39 ce                	cmp    %ecx,%esi
    2280:	75 dd                	jne    225f <free+0x4f>
    p->s.size += bp->s.size;
    2282:	03 51 04             	add    0x4(%ecx),%edx
    2285:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    2288:	8b 53 f8             	mov    -0x8(%ebx),%edx
    228b:	89 10                	mov    %edx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
    228d:	a3 0c 25 00 00       	mov    %eax,0x250c
}
    2292:	5b                   	pop    %ebx
    2293:	5e                   	pop    %esi
    2294:	5f                   	pop    %edi
    2295:	5d                   	pop    %ebp
    2296:	c3                   	ret    
    2297:	89 f6                	mov    %esi,%esi
    2299:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000022a0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    22a0:	55                   	push   %ebp
    22a1:	89 e5                	mov    %esp,%ebp
    22a3:	57                   	push   %edi
    22a4:	56                   	push   %esi
    22a5:	53                   	push   %ebx
    22a6:	83 ec 2c             	sub    $0x2c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    22a9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if((prevp = freep) == 0){
    22ac:	8b 0d 0c 25 00 00    	mov    0x250c,%ecx
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    22b2:	83 c3 07             	add    $0x7,%ebx
    22b5:	c1 eb 03             	shr    $0x3,%ebx
    22b8:	83 c3 01             	add    $0x1,%ebx
  if((prevp = freep) == 0){
    22bb:	85 c9                	test   %ecx,%ecx
    22bd:	0f 84 9b 00 00 00    	je     235e <malloc+0xbe>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    22c3:	8b 01                	mov    (%ecx),%eax
    if(p->s.size >= nunits){
    22c5:	8b 50 04             	mov    0x4(%eax),%edx
    22c8:	39 d3                	cmp    %edx,%ebx
    22ca:	76 27                	jbe    22f3 <malloc+0x53>
        p->s.size -= nunits;
        p += p->s.size;
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    22cc:	8d 3c dd 00 00 00 00 	lea    0x0(,%ebx,8),%edi
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < 4096)
    22d3:	be 00 80 00 00       	mov    $0x8000,%esi
    22d8:	89 7d e4             	mov    %edi,-0x1c(%ebp)
    22db:	90                   	nop
    22dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    22e0:	3b 05 0c 25 00 00    	cmp    0x250c,%eax
    22e6:	74 30                	je     2318 <malloc+0x78>
    22e8:	89 c1                	mov    %eax,%ecx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    22ea:	8b 01                	mov    (%ecx),%eax
    if(p->s.size >= nunits){
    22ec:	8b 50 04             	mov    0x4(%eax),%edx
    22ef:	39 d3                	cmp    %edx,%ebx
    22f1:	77 ed                	ja     22e0 <malloc+0x40>
      if(p->s.size == nunits)
    22f3:	39 d3                	cmp    %edx,%ebx
    22f5:	74 61                	je     2358 <malloc+0xb8>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
    22f7:	29 da                	sub    %ebx,%edx
    22f9:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
    22fc:	8d 04 d0             	lea    (%eax,%edx,8),%eax
        p->s.size = nunits;
    22ff:	89 58 04             	mov    %ebx,0x4(%eax)
      }
      freep = prevp;
    2302:	89 0d 0c 25 00 00    	mov    %ecx,0x250c
      return (void*)(p + 1);
    2308:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
    230b:	83 c4 2c             	add    $0x2c,%esp
    230e:	5b                   	pop    %ebx
    230f:	5e                   	pop    %esi
    2310:	5f                   	pop    %edi
    2311:	5d                   	pop    %ebp
    2312:	c3                   	ret    
    2313:	90                   	nop
    2314:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < 4096)
    2318:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    231b:	81 fb 00 10 00 00    	cmp    $0x1000,%ebx
    2321:	bf 00 10 00 00       	mov    $0x1000,%edi
    2326:	0f 43 fb             	cmovae %ebx,%edi
    2329:	0f 42 c6             	cmovb  %esi,%eax
    nu = 4096;
  p = sbrk(nu * sizeof(Header));
    232c:	89 04 24             	mov    %eax,(%esp)
    232f:	e8 1c fc ff ff       	call   1f50 <sbrk>
  if(p == (char*)-1)
    2334:	83 f8 ff             	cmp    $0xffffffff,%eax
    2337:	74 18                	je     2351 <malloc+0xb1>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
    2339:	89 78 04             	mov    %edi,0x4(%eax)
  free((void*)(hp + 1));
    233c:	83 c0 08             	add    $0x8,%eax
    233f:	89 04 24             	mov    %eax,(%esp)
    2342:	e8 c9 fe ff ff       	call   2210 <free>
  return freep;
    2347:	8b 0d 0c 25 00 00    	mov    0x250c,%ecx
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
    234d:	85 c9                	test   %ecx,%ecx
    234f:	75 99                	jne    22ea <malloc+0x4a>
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
    2351:	31 c0                	xor    %eax,%eax
    2353:	eb b6                	jmp    230b <malloc+0x6b>
    2355:	8d 76 00             	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
    2358:	8b 10                	mov    (%eax),%edx
    235a:	89 11                	mov    %edx,(%ecx)
    235c:	eb a4                	jmp    2302 <malloc+0x62>
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    235e:	c7 05 0c 25 00 00 04 	movl   $0x2504,0x250c
    2365:	25 00 00 
    base.s.size = 0;
    2368:	b9 04 25 00 00       	mov    $0x2504,%ecx
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    236d:	c7 05 04 25 00 00 04 	movl   $0x2504,0x2504
    2374:	25 00 00 
    base.s.size = 0;
    2377:	c7 05 08 25 00 00 00 	movl   $0x0,0x2508
    237e:	00 00 00 
    2381:	e9 3d ff ff ff       	jmp    22c3 <malloc+0x23>
