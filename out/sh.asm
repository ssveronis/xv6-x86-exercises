
fs/sh:     file format elf64-x86-64


Disassembly of section .text:

0000000000000000 <runcmd>:
struct cmd *parsecmd(char*);

// Execute cmd.  Never returns.
void
runcmd(struct cmd *cmd)
{
       0:	55                   	push   %rbp
       1:	48 89 e5             	mov    %rsp,%rbp
       4:	48 83 ec 40          	sub    $0x40,%rsp
       8:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
  struct execcmd *ecmd;
  struct listcmd *lcmd;
  struct pipecmd *pcmd;
  struct redircmd *rcmd;

  if(cmd == 0)
       c:	48 83 7d c8 00       	cmpq   $0x0,-0x38(%rbp)
      11:	75 05                	jne    18 <runcmd+0x18>
    exit();
      13:	e8 d7 10 00 00       	call   10ef <exit>
  
  switch(cmd->type){
      18:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
      1c:	8b 00                	mov    (%rax),%eax
      1e:	83 f8 05             	cmp    $0x5,%eax
      21:	77 0c                	ja     2f <runcmd+0x2f>
      23:	89 c0                	mov    %eax,%eax
      25:	48 8b 04 c5 b8 18 00 	mov    0x18b8(,%rax,8),%rax
      2c:	00 
      2d:	ff e0                	jmp    *%rax
  default:
    panic("runcmd");
      2f:	48 c7 c7 88 18 00 00 	mov    $0x1888,%rdi
      36:	e8 40 03 00 00       	call   37b <panic>

  case EXEC:
    ecmd = (struct execcmd*)cmd;
      3b:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
      3f:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
    if(ecmd->argv[0] == 0)
      43:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
      47:	48 8b 40 08          	mov    0x8(%rax),%rax
      4b:	48 85 c0             	test   %rax,%rax
      4e:	75 05                	jne    55 <runcmd+0x55>
      exit();
      50:	e8 9a 10 00 00       	call   10ef <exit>
    exec(ecmd->argv[0], ecmd->argv);
      55:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
      59:	48 8d 50 08          	lea    0x8(%rax),%rdx
      5d:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
      61:	48 8b 40 08          	mov    0x8(%rax),%rax
      65:	48 89 d6             	mov    %rdx,%rsi
      68:	48 89 c7             	mov    %rax,%rdi
      6b:	e8 b7 10 00 00       	call   1127 <exec>
    printf(2, "exec %s failed\n", ecmd->argv[0]);
      70:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
      74:	48 8b 40 08          	mov    0x8(%rax),%rax
      78:	48 89 c2             	mov    %rax,%rdx
      7b:	48 c7 c6 8f 18 00 00 	mov    $0x188f,%rsi
      82:	bf 02 00 00 00       	mov    $0x2,%edi
      87:	b8 00 00 00 00       	mov    $0x0,%eax
      8c:	e8 f0 11 00 00       	call   1281 <printf>
    break;
      91:	e9 91 01 00 00       	jmp    227 <runcmd+0x227>

  case REDIR:
    rcmd = (struct redircmd*)cmd;
      96:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
      9a:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    close(rcmd->fd);
      9e:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
      a2:	8b 40 24             	mov    0x24(%rax),%eax
      a5:	89 c7                	mov    %eax,%edi
      a7:	e8 6b 10 00 00       	call   1117 <close>
    if(open(rcmd->file, rcmd->mode) < 0){
      ac:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
      b0:	8b 50 20             	mov    0x20(%rax),%edx
      b3:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
      b7:	48 8b 40 10          	mov    0x10(%rax),%rax
      bb:	89 d6                	mov    %edx,%esi
      bd:	48 89 c7             	mov    %rax,%rdi
      c0:	e8 6a 10 00 00       	call   112f <open>
      c5:	85 c0                	test   %eax,%eax
      c7:	79 26                	jns    ef <runcmd+0xef>
      printf(2, "open %s failed\n", rcmd->file);
      c9:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
      cd:	48 8b 40 10          	mov    0x10(%rax),%rax
      d1:	48 89 c2             	mov    %rax,%rdx
      d4:	48 c7 c6 9f 18 00 00 	mov    $0x189f,%rsi
      db:	bf 02 00 00 00       	mov    $0x2,%edi
      e0:	b8 00 00 00 00       	mov    $0x0,%eax
      e5:	e8 97 11 00 00       	call   1281 <printf>
      exit();
      ea:	e8 00 10 00 00       	call   10ef <exit>
    }
    runcmd(rcmd->cmd);
      ef:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
      f3:	48 8b 40 08          	mov    0x8(%rax),%rax
      f7:	48 89 c7             	mov    %rax,%rdi
      fa:	e8 01 ff ff ff       	call   0 <runcmd>
    break;
      ff:	e9 23 01 00 00       	jmp    227 <runcmd+0x227>

  case LIST:
    lcmd = (struct listcmd*)cmd;
     104:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
     108:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if(fork1() == 0)
     10c:	e8 98 02 00 00       	call   3a9 <fork1>
     111:	85 c0                	test   %eax,%eax
     113:	75 10                	jne    125 <runcmd+0x125>
      runcmd(lcmd->left);
     115:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
     119:	48 8b 40 08          	mov    0x8(%rax),%rax
     11d:	48 89 c7             	mov    %rax,%rdi
     120:	e8 db fe ff ff       	call   0 <runcmd>
    wait();
     125:	e8 cd 0f 00 00       	call   10f7 <wait>
    runcmd(lcmd->right);
     12a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
     12e:	48 8b 40 10          	mov    0x10(%rax),%rax
     132:	48 89 c7             	mov    %rax,%rdi
     135:	e8 c6 fe ff ff       	call   0 <runcmd>
    break;
     13a:	e9 e8 00 00 00       	jmp    227 <runcmd+0x227>

  case PIPE:
    pcmd = (struct pipecmd*)cmd;
     13f:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
     143:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    if(pipe(p) < 0)
     147:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
     14b:	48 89 c7             	mov    %rax,%rdi
     14e:	e8 ac 0f 00 00       	call   10ff <pipe>
     153:	85 c0                	test   %eax,%eax
     155:	79 0c                	jns    163 <runcmd+0x163>
      panic("pipe");
     157:	48 c7 c7 af 18 00 00 	mov    $0x18af,%rdi
     15e:	e8 18 02 00 00       	call   37b <panic>
    if(fork1() == 0){
     163:	e8 41 02 00 00       	call   3a9 <fork1>
     168:	85 c0                	test   %eax,%eax
     16a:	75 38                	jne    1a4 <runcmd+0x1a4>
      close(1);
     16c:	bf 01 00 00 00       	mov    $0x1,%edi
     171:	e8 a1 0f 00 00       	call   1117 <close>
      dup(p[1]);
     176:	8b 45 d4             	mov    -0x2c(%rbp),%eax
     179:	89 c7                	mov    %eax,%edi
     17b:	e8 e7 0f 00 00       	call   1167 <dup>
      close(p[0]);
     180:	8b 45 d0             	mov    -0x30(%rbp),%eax
     183:	89 c7                	mov    %eax,%edi
     185:	e8 8d 0f 00 00       	call   1117 <close>
      close(p[1]);
     18a:	8b 45 d4             	mov    -0x2c(%rbp),%eax
     18d:	89 c7                	mov    %eax,%edi
     18f:	e8 83 0f 00 00       	call   1117 <close>
      runcmd(pcmd->left);
     194:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
     198:	48 8b 40 08          	mov    0x8(%rax),%rax
     19c:	48 89 c7             	mov    %rax,%rdi
     19f:	e8 5c fe ff ff       	call   0 <runcmd>
    }
    if(fork1() == 0){
     1a4:	e8 00 02 00 00       	call   3a9 <fork1>
     1a9:	85 c0                	test   %eax,%eax
     1ab:	75 38                	jne    1e5 <runcmd+0x1e5>
      close(0);
     1ad:	bf 00 00 00 00       	mov    $0x0,%edi
     1b2:	e8 60 0f 00 00       	call   1117 <close>
      dup(p[0]);
     1b7:	8b 45 d0             	mov    -0x30(%rbp),%eax
     1ba:	89 c7                	mov    %eax,%edi
     1bc:	e8 a6 0f 00 00       	call   1167 <dup>
      close(p[0]);
     1c1:	8b 45 d0             	mov    -0x30(%rbp),%eax
     1c4:	89 c7                	mov    %eax,%edi
     1c6:	e8 4c 0f 00 00       	call   1117 <close>
      close(p[1]);
     1cb:	8b 45 d4             	mov    -0x2c(%rbp),%eax
     1ce:	89 c7                	mov    %eax,%edi
     1d0:	e8 42 0f 00 00       	call   1117 <close>
      runcmd(pcmd->right);
     1d5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
     1d9:	48 8b 40 10          	mov    0x10(%rax),%rax
     1dd:	48 89 c7             	mov    %rax,%rdi
     1e0:	e8 1b fe ff ff       	call   0 <runcmd>
    }
    close(p[0]);
     1e5:	8b 45 d0             	mov    -0x30(%rbp),%eax
     1e8:	89 c7                	mov    %eax,%edi
     1ea:	e8 28 0f 00 00       	call   1117 <close>
    close(p[1]);
     1ef:	8b 45 d4             	mov    -0x2c(%rbp),%eax
     1f2:	89 c7                	mov    %eax,%edi
     1f4:	e8 1e 0f 00 00       	call   1117 <close>
    wait();
     1f9:	e8 f9 0e 00 00       	call   10f7 <wait>
    wait();
     1fe:	e8 f4 0e 00 00       	call   10f7 <wait>
    break;
     203:	eb 22                	jmp    227 <runcmd+0x227>
    
  case BACK:
    bcmd = (struct backcmd*)cmd;
     205:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
     209:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(fork1() == 0)
     20d:	e8 97 01 00 00       	call   3a9 <fork1>
     212:	85 c0                	test   %eax,%eax
     214:	75 10                	jne    226 <runcmd+0x226>
      runcmd(bcmd->cmd);
     216:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     21a:	48 8b 40 08          	mov    0x8(%rax),%rax
     21e:	48 89 c7             	mov    %rax,%rdi
     221:	e8 da fd ff ff       	call   0 <runcmd>
    break;
     226:	90                   	nop
  }
  exit();
     227:	e8 c3 0e 00 00       	call   10ef <exit>

000000000000022c <getcmd>:
}

int
getcmd(char *buf, int nbuf)
{
     22c:	55                   	push   %rbp
     22d:	48 89 e5             	mov    %rsp,%rbp
     230:	48 83 ec 10          	sub    $0x10,%rsp
     234:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
     238:	89 75 f4             	mov    %esi,-0xc(%rbp)
  printf(2, "$ ");
     23b:	48 c7 c6 e8 18 00 00 	mov    $0x18e8,%rsi
     242:	bf 02 00 00 00       	mov    $0x2,%edi
     247:	b8 00 00 00 00       	mov    $0x0,%eax
     24c:	e8 30 10 00 00       	call   1281 <printf>
  memset(buf, 0, nbuf);
     251:	8b 55 f4             	mov    -0xc(%rbp),%edx
     254:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     258:	be 00 00 00 00       	mov    $0x0,%esi
     25d:	48 89 c7             	mov    %rax,%rdi
     260:	e8 95 0c 00 00       	call   efa <memset>
  gets(buf, nbuf);
     265:	8b 55 f4             	mov    -0xc(%rbp),%edx
     268:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     26c:	89 d6                	mov    %edx,%esi
     26e:	48 89 c7             	mov    %rax,%rdi
     271:	e8 ec 0c 00 00       	call   f62 <gets>
  if(buf[0] == 0) // EOF
     276:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     27a:	0f b6 00             	movzbl (%rax),%eax
     27d:	84 c0                	test   %al,%al
     27f:	75 07                	jne    288 <getcmd+0x5c>
    return -1;
     281:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     286:	eb 05                	jmp    28d <getcmd+0x61>
  return 0;
     288:	b8 00 00 00 00       	mov    $0x0,%eax
}
     28d:	c9                   	leave
     28e:	c3                   	ret

000000000000028f <main>:

int
main(void)
{
     28f:	55                   	push   %rbp
     290:	48 89 e5             	mov    %rsp,%rbp
     293:	48 83 ec 10          	sub    $0x10,%rsp
  static char buf[100];
  int fd;
  
  // Assumes three file descriptors open.
  while((fd = open("console", O_RDWR)) >= 0){
     297:	eb 12                	jmp    2ab <main+0x1c>
    if(fd >= 3){
     299:	83 7d fc 02          	cmpl   $0x2,-0x4(%rbp)
     29d:	7e 0c                	jle    2ab <main+0x1c>
      close(fd);
     29f:	8b 45 fc             	mov    -0x4(%rbp),%eax
     2a2:	89 c7                	mov    %eax,%edi
     2a4:	e8 6e 0e 00 00       	call   1117 <close>
      break;
     2a9:	eb 1a                	jmp    2c5 <main+0x36>
  while((fd = open("console", O_RDWR)) >= 0){
     2ab:	be 02 00 00 00       	mov    $0x2,%esi
     2b0:	48 c7 c7 eb 18 00 00 	mov    $0x18eb,%rdi
     2b7:	e8 73 0e 00 00       	call   112f <open>
     2bc:	89 45 fc             	mov    %eax,-0x4(%rbp)
     2bf:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
     2c3:	79 d4                	jns    299 <main+0xa>
    }
  }
  
  // Read and run input commands.
  while(getcmd(buf, sizeof(buf)) >= 0){
     2c5:	e9 93 00 00 00       	jmp    35d <main+0xce>
    if(buf[0] == 'c' && buf[1] == 'd' && buf[2] == ' '){
     2ca:	0f b6 05 8f 1b 00 00 	movzbl 0x1b8f(%rip),%eax        # 1e60 <buf.0>
     2d1:	3c 63                	cmp    $0x63,%al
     2d3:	75 63                	jne    338 <main+0xa9>
     2d5:	0f b6 05 85 1b 00 00 	movzbl 0x1b85(%rip),%eax        # 1e61 <buf.0+0x1>
     2dc:	3c 64                	cmp    $0x64,%al
     2de:	75 58                	jne    338 <main+0xa9>
     2e0:	0f b6 05 7b 1b 00 00 	movzbl 0x1b7b(%rip),%eax        # 1e62 <buf.0+0x2>
     2e7:	3c 20                	cmp    $0x20,%al
     2e9:	75 4d                	jne    338 <main+0xa9>
      // Clumsy but will have to do for now.
      // Chdir has no effect on the parent if run in the child.
      buf[strlen(buf)-1] = 0;  // chop \n
     2eb:	48 c7 c7 60 1e 00 00 	mov    $0x1e60,%rdi
     2f2:	e8 d1 0b 00 00       	call   ec8 <strlen>
     2f7:	83 e8 01             	sub    $0x1,%eax
     2fa:	89 c0                	mov    %eax,%eax
     2fc:	c6 80 60 1e 00 00 00 	movb   $0x0,0x1e60(%rax)
      if(chdir(buf+3) < 0)
     303:	48 c7 c0 63 1e 00 00 	mov    $0x1e63,%rax
     30a:	48 89 c7             	mov    %rax,%rdi
     30d:	e8 4d 0e 00 00       	call   115f <chdir>
     312:	85 c0                	test   %eax,%eax
     314:	79 46                	jns    35c <main+0xcd>
        printf(2, "cannot cd %s\n", buf+3);
     316:	48 c7 c0 63 1e 00 00 	mov    $0x1e63,%rax
     31d:	48 89 c2             	mov    %rax,%rdx
     320:	48 c7 c6 f3 18 00 00 	mov    $0x18f3,%rsi
     327:	bf 02 00 00 00       	mov    $0x2,%edi
     32c:	b8 00 00 00 00       	mov    $0x0,%eax
     331:	e8 4b 0f 00 00       	call   1281 <printf>
      continue;
     336:	eb 24                	jmp    35c <main+0xcd>
    }
    if(fork1() == 0)
     338:	e8 6c 00 00 00       	call   3a9 <fork1>
     33d:	85 c0                	test   %eax,%eax
     33f:	75 14                	jne    355 <main+0xc6>
      runcmd(parsecmd(buf));
     341:	48 c7 c7 60 1e 00 00 	mov    $0x1e60,%rdi
     348:	e8 53 04 00 00       	call   7a0 <parsecmd>
     34d:	48 89 c7             	mov    %rax,%rdi
     350:	e8 ab fc ff ff       	call   0 <runcmd>
    wait();
     355:	e8 9d 0d 00 00       	call   10f7 <wait>
     35a:	eb 01                	jmp    35d <main+0xce>
      continue;
     35c:	90                   	nop
  while(getcmd(buf, sizeof(buf)) >= 0){
     35d:	be 64 00 00 00       	mov    $0x64,%esi
     362:	48 c7 c7 60 1e 00 00 	mov    $0x1e60,%rdi
     369:	e8 be fe ff ff       	call   22c <getcmd>
     36e:	85 c0                	test   %eax,%eax
     370:	0f 89 54 ff ff ff    	jns    2ca <main+0x3b>
  }
  exit();
     376:	e8 74 0d 00 00       	call   10ef <exit>

000000000000037b <panic>:
}

void
panic(char *s)
{
     37b:	55                   	push   %rbp
     37c:	48 89 e5             	mov    %rsp,%rbp
     37f:	48 83 ec 10          	sub    $0x10,%rsp
     383:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  printf(2, "%s\n", s);
     387:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     38b:	48 89 c2             	mov    %rax,%rdx
     38e:	48 c7 c6 01 19 00 00 	mov    $0x1901,%rsi
     395:	bf 02 00 00 00       	mov    $0x2,%edi
     39a:	b8 00 00 00 00       	mov    $0x0,%eax
     39f:	e8 dd 0e 00 00       	call   1281 <printf>
  exit();
     3a4:	e8 46 0d 00 00       	call   10ef <exit>

00000000000003a9 <fork1>:
}

int
fork1(void)
{
     3a9:	55                   	push   %rbp
     3aa:	48 89 e5             	mov    %rsp,%rbp
     3ad:	48 83 ec 10          	sub    $0x10,%rsp
  int pid;
  
  pid = fork();
     3b1:	e8 31 0d 00 00       	call   10e7 <fork>
     3b6:	89 45 fc             	mov    %eax,-0x4(%rbp)
  if(pid == -1)
     3b9:	83 7d fc ff          	cmpl   $0xffffffff,-0x4(%rbp)
     3bd:	75 0c                	jne    3cb <fork1+0x22>
    panic("fork");
     3bf:	48 c7 c7 05 19 00 00 	mov    $0x1905,%rdi
     3c6:	e8 b0 ff ff ff       	call   37b <panic>
  return pid;
     3cb:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
     3ce:	c9                   	leave
     3cf:	c3                   	ret

00000000000003d0 <execcmd>:
//PAGEBREAK!
// Constructors

struct cmd*
execcmd(void)
{
     3d0:	55                   	push   %rbp
     3d1:	48 89 e5             	mov    %rsp,%rbp
     3d4:	48 83 ec 10          	sub    $0x10,%rsp
  struct execcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     3d8:	bf a8 00 00 00       	mov    $0xa8,%edi
     3dd:	e8 92 13 00 00       	call   1774 <malloc>
     3e2:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  memset(cmd, 0, sizeof(*cmd));
     3e6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     3ea:	ba a8 00 00 00       	mov    $0xa8,%edx
     3ef:	be 00 00 00 00       	mov    $0x0,%esi
     3f4:	48 89 c7             	mov    %rax,%rdi
     3f7:	e8 fe 0a 00 00       	call   efa <memset>
  cmd->type = EXEC;
     3fc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     400:	c7 00 01 00 00 00    	movl   $0x1,(%rax)
  return (struct cmd*)cmd;
     406:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
     40a:	c9                   	leave
     40b:	c3                   	ret

000000000000040c <redircmd>:

struct cmd*
redircmd(struct cmd *subcmd, char *file, char *efile, int mode, int fd)
{
     40c:	55                   	push   %rbp
     40d:	48 89 e5             	mov    %rsp,%rbp
     410:	48 83 ec 30          	sub    $0x30,%rsp
     414:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
     418:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
     41c:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
     420:	89 4d d4             	mov    %ecx,-0x2c(%rbp)
     423:	44 89 45 d0          	mov    %r8d,-0x30(%rbp)
  struct redircmd *cmd;

  cmd = malloc(sizeof(*cmd));
     427:	bf 28 00 00 00       	mov    $0x28,%edi
     42c:	e8 43 13 00 00       	call   1774 <malloc>
     431:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  memset(cmd, 0, sizeof(*cmd));
     435:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     439:	ba 28 00 00 00       	mov    $0x28,%edx
     43e:	be 00 00 00 00       	mov    $0x0,%esi
     443:	48 89 c7             	mov    %rax,%rdi
     446:	e8 af 0a 00 00       	call   efa <memset>
  cmd->type = REDIR;
     44b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     44f:	c7 00 02 00 00 00    	movl   $0x2,(%rax)
  cmd->cmd = subcmd;
     455:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     459:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
     45d:	48 89 50 08          	mov    %rdx,0x8(%rax)
  cmd->file = file;
     461:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     465:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
     469:	48 89 50 10          	mov    %rdx,0x10(%rax)
  cmd->efile = efile;
     46d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     471:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
     475:	48 89 50 18          	mov    %rdx,0x18(%rax)
  cmd->mode = mode;
     479:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     47d:	8b 55 d4             	mov    -0x2c(%rbp),%edx
     480:	89 50 20             	mov    %edx,0x20(%rax)
  cmd->fd = fd;
     483:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     487:	8b 55 d0             	mov    -0x30(%rbp),%edx
     48a:	89 50 24             	mov    %edx,0x24(%rax)
  return (struct cmd*)cmd;
     48d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
     491:	c9                   	leave
     492:	c3                   	ret

0000000000000493 <pipecmd>:

struct cmd*
pipecmd(struct cmd *left, struct cmd *right)
{
     493:	55                   	push   %rbp
     494:	48 89 e5             	mov    %rsp,%rbp
     497:	48 83 ec 20          	sub    $0x20,%rsp
     49b:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
     49f:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  struct pipecmd *cmd;

  cmd = malloc(sizeof(*cmd));
     4a3:	bf 18 00 00 00       	mov    $0x18,%edi
     4a8:	e8 c7 12 00 00       	call   1774 <malloc>
     4ad:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  memset(cmd, 0, sizeof(*cmd));
     4b1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     4b5:	ba 18 00 00 00       	mov    $0x18,%edx
     4ba:	be 00 00 00 00       	mov    $0x0,%esi
     4bf:	48 89 c7             	mov    %rax,%rdi
     4c2:	e8 33 0a 00 00       	call   efa <memset>
  cmd->type = PIPE;
     4c7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     4cb:	c7 00 03 00 00 00    	movl   $0x3,(%rax)
  cmd->left = left;
     4d1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     4d5:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
     4d9:	48 89 50 08          	mov    %rdx,0x8(%rax)
  cmd->right = right;
     4dd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     4e1:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
     4e5:	48 89 50 10          	mov    %rdx,0x10(%rax)
  return (struct cmd*)cmd;
     4e9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
     4ed:	c9                   	leave
     4ee:	c3                   	ret

00000000000004ef <listcmd>:

struct cmd*
listcmd(struct cmd *left, struct cmd *right)
{
     4ef:	55                   	push   %rbp
     4f0:	48 89 e5             	mov    %rsp,%rbp
     4f3:	48 83 ec 20          	sub    $0x20,%rsp
     4f7:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
     4fb:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  struct listcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     4ff:	bf 18 00 00 00       	mov    $0x18,%edi
     504:	e8 6b 12 00 00       	call   1774 <malloc>
     509:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  memset(cmd, 0, sizeof(*cmd));
     50d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     511:	ba 18 00 00 00       	mov    $0x18,%edx
     516:	be 00 00 00 00       	mov    $0x0,%esi
     51b:	48 89 c7             	mov    %rax,%rdi
     51e:	e8 d7 09 00 00       	call   efa <memset>
  cmd->type = LIST;
     523:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     527:	c7 00 04 00 00 00    	movl   $0x4,(%rax)
  cmd->left = left;
     52d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     531:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
     535:	48 89 50 08          	mov    %rdx,0x8(%rax)
  cmd->right = right;
     539:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     53d:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
     541:	48 89 50 10          	mov    %rdx,0x10(%rax)
  return (struct cmd*)cmd;
     545:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
     549:	c9                   	leave
     54a:	c3                   	ret

000000000000054b <backcmd>:

struct cmd*
backcmd(struct cmd *subcmd)
{
     54b:	55                   	push   %rbp
     54c:	48 89 e5             	mov    %rsp,%rbp
     54f:	48 83 ec 20          	sub    $0x20,%rsp
     553:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  struct backcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     557:	bf 10 00 00 00       	mov    $0x10,%edi
     55c:	e8 13 12 00 00       	call   1774 <malloc>
     561:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  memset(cmd, 0, sizeof(*cmd));
     565:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     569:	ba 10 00 00 00       	mov    $0x10,%edx
     56e:	be 00 00 00 00       	mov    $0x0,%esi
     573:	48 89 c7             	mov    %rax,%rdi
     576:	e8 7f 09 00 00       	call   efa <memset>
  cmd->type = BACK;
     57b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     57f:	c7 00 05 00 00 00    	movl   $0x5,(%rax)
  cmd->cmd = subcmd;
     585:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     589:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
     58d:	48 89 50 08          	mov    %rdx,0x8(%rax)
  return (struct cmd*)cmd;
     591:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
     595:	c9                   	leave
     596:	c3                   	ret

0000000000000597 <gettoken>:
char whitespace[] = " \t\r\n\v";
char symbols[] = "<|>&;()";

int
gettoken(char **ps, char *es, char **q, char **eq)
{
     597:	55                   	push   %rbp
     598:	48 89 e5             	mov    %rsp,%rbp
     59b:	48 83 ec 30          	sub    $0x30,%rsp
     59f:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
     5a3:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
     5a7:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
     5ab:	48 89 4d d0          	mov    %rcx,-0x30(%rbp)
  char *s;
  int ret;
  
  s = *ps;
     5af:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
     5b3:	48 8b 00             	mov    (%rax),%rax
     5b6:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  while(s < es && strchr(whitespace, *s))
     5ba:	eb 05                	jmp    5c1 <gettoken+0x2a>
    s++;
     5bc:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  while(s < es && strchr(whitespace, *s))
     5c1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     5c5:	48 3b 45 e0          	cmp    -0x20(%rbp),%rax
     5c9:	73 1d                	jae    5e8 <gettoken+0x51>
     5cb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     5cf:	0f b6 00             	movzbl (%rax),%eax
     5d2:	0f be c0             	movsbl %al,%eax
     5d5:	89 c6                	mov    %eax,%esi
     5d7:	48 c7 c7 30 1e 00 00 	mov    $0x1e30,%rdi
     5de:	e8 43 09 00 00       	call   f26 <strchr>
     5e3:	48 85 c0             	test   %rax,%rax
     5e6:	75 d4                	jne    5bc <gettoken+0x25>
  if(q)
     5e8:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
     5ed:	74 0b                	je     5fa <gettoken+0x63>
    *q = s;
     5ef:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
     5f3:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
     5f7:	48 89 10             	mov    %rdx,(%rax)
  ret = *s;
     5fa:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     5fe:	0f b6 00             	movzbl (%rax),%eax
     601:	0f be c0             	movsbl %al,%eax
     604:	89 45 f4             	mov    %eax,-0xc(%rbp)
  switch(*s){
     607:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     60b:	0f b6 00             	movzbl (%rax),%eax
     60e:	0f be c0             	movsbl %al,%eax
     611:	83 f8 7c             	cmp    $0x7c,%eax
     614:	74 2c                	je     642 <gettoken+0xab>
     616:	83 f8 7c             	cmp    $0x7c,%eax
     619:	7f 4c                	jg     667 <gettoken+0xd0>
     61b:	83 f8 3e             	cmp    $0x3e,%eax
     61e:	74 29                	je     649 <gettoken+0xb2>
     620:	83 f8 3e             	cmp    $0x3e,%eax
     623:	7f 42                	jg     667 <gettoken+0xd0>
     625:	83 f8 3c             	cmp    $0x3c,%eax
     628:	7f 3d                	jg     667 <gettoken+0xd0>
     62a:	83 f8 3b             	cmp    $0x3b,%eax
     62d:	7d 13                	jge    642 <gettoken+0xab>
     62f:	83 f8 29             	cmp    $0x29,%eax
     632:	7f 33                	jg     667 <gettoken+0xd0>
     634:	83 f8 28             	cmp    $0x28,%eax
     637:	7d 09                	jge    642 <gettoken+0xab>
     639:	85 c0                	test   %eax,%eax
     63b:	74 7e                	je     6bb <gettoken+0x124>
     63d:	83 f8 26             	cmp    $0x26,%eax
     640:	75 25                	jne    667 <gettoken+0xd0>
  case '(':
  case ')':
  case ';':
  case '&':
  case '<':
    s++;
     642:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    break;
     647:	eb 79                	jmp    6c2 <gettoken+0x12b>
  case '>':
    s++;
     649:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    if(*s == '>'){
     64e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     652:	0f b6 00             	movzbl (%rax),%eax
     655:	3c 3e                	cmp    $0x3e,%al
     657:	75 65                	jne    6be <gettoken+0x127>
      ret = '+';
     659:	c7 45 f4 2b 00 00 00 	movl   $0x2b,-0xc(%rbp)
      s++;
     660:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    }
    break;
     665:	eb 57                	jmp    6be <gettoken+0x127>
  default:
    ret = 'a';
     667:	c7 45 f4 61 00 00 00 	movl   $0x61,-0xc(%rbp)
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     66e:	eb 05                	jmp    675 <gettoken+0xde>
      s++;
     670:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     675:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     679:	48 3b 45 e0          	cmp    -0x20(%rbp),%rax
     67d:	73 42                	jae    6c1 <gettoken+0x12a>
     67f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     683:	0f b6 00             	movzbl (%rax),%eax
     686:	0f be c0             	movsbl %al,%eax
     689:	89 c6                	mov    %eax,%esi
     68b:	48 c7 c7 30 1e 00 00 	mov    $0x1e30,%rdi
     692:	e8 8f 08 00 00       	call   f26 <strchr>
     697:	48 85 c0             	test   %rax,%rax
     69a:	75 25                	jne    6c1 <gettoken+0x12a>
     69c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     6a0:	0f b6 00             	movzbl (%rax),%eax
     6a3:	0f be c0             	movsbl %al,%eax
     6a6:	89 c6                	mov    %eax,%esi
     6a8:	48 c7 c7 38 1e 00 00 	mov    $0x1e38,%rdi
     6af:	e8 72 08 00 00       	call   f26 <strchr>
     6b4:	48 85 c0             	test   %rax,%rax
     6b7:	74 b7                	je     670 <gettoken+0xd9>
    break;
     6b9:	eb 06                	jmp    6c1 <gettoken+0x12a>
    break;
     6bb:	90                   	nop
     6bc:	eb 04                	jmp    6c2 <gettoken+0x12b>
    break;
     6be:	90                   	nop
     6bf:	eb 01                	jmp    6c2 <gettoken+0x12b>
    break;
     6c1:	90                   	nop
  }
  if(eq)
     6c2:	48 83 7d d0 00       	cmpq   $0x0,-0x30(%rbp)
     6c7:	74 12                	je     6db <gettoken+0x144>
    *eq = s;
     6c9:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
     6cd:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
     6d1:	48 89 10             	mov    %rdx,(%rax)
  
  while(s < es && strchr(whitespace, *s))
     6d4:	eb 05                	jmp    6db <gettoken+0x144>
    s++;
     6d6:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  while(s < es && strchr(whitespace, *s))
     6db:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     6df:	48 3b 45 e0          	cmp    -0x20(%rbp),%rax
     6e3:	73 1d                	jae    702 <gettoken+0x16b>
     6e5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     6e9:	0f b6 00             	movzbl (%rax),%eax
     6ec:	0f be c0             	movsbl %al,%eax
     6ef:	89 c6                	mov    %eax,%esi
     6f1:	48 c7 c7 30 1e 00 00 	mov    $0x1e30,%rdi
     6f8:	e8 29 08 00 00       	call   f26 <strchr>
     6fd:	48 85 c0             	test   %rax,%rax
     700:	75 d4                	jne    6d6 <gettoken+0x13f>
  *ps = s;
     702:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
     706:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
     70a:	48 89 10             	mov    %rdx,(%rax)
  return ret;
     70d:	8b 45 f4             	mov    -0xc(%rbp),%eax
}
     710:	c9                   	leave
     711:	c3                   	ret

0000000000000712 <peek>:

int
peek(char **ps, char *es, char *toks)
{
     712:	55                   	push   %rbp
     713:	48 89 e5             	mov    %rsp,%rbp
     716:	48 83 ec 30          	sub    $0x30,%rsp
     71a:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
     71e:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
     722:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  char *s;
  
  s = *ps;
     726:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
     72a:	48 8b 00             	mov    (%rax),%rax
     72d:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  while(s < es && strchr(whitespace, *s))
     731:	eb 05                	jmp    738 <peek+0x26>
    s++;
     733:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  while(s < es && strchr(whitespace, *s))
     738:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     73c:	48 3b 45 e0          	cmp    -0x20(%rbp),%rax
     740:	73 1d                	jae    75f <peek+0x4d>
     742:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     746:	0f b6 00             	movzbl (%rax),%eax
     749:	0f be c0             	movsbl %al,%eax
     74c:	89 c6                	mov    %eax,%esi
     74e:	48 c7 c7 30 1e 00 00 	mov    $0x1e30,%rdi
     755:	e8 cc 07 00 00       	call   f26 <strchr>
     75a:	48 85 c0             	test   %rax,%rax
     75d:	75 d4                	jne    733 <peek+0x21>
  *ps = s;
     75f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
     763:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
     767:	48 89 10             	mov    %rdx,(%rax)
  return *s && strchr(toks, *s);
     76a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     76e:	0f b6 00             	movzbl (%rax),%eax
     771:	84 c0                	test   %al,%al
     773:	74 24                	je     799 <peek+0x87>
     775:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     779:	0f b6 00             	movzbl (%rax),%eax
     77c:	0f be d0             	movsbl %al,%edx
     77f:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
     783:	89 d6                	mov    %edx,%esi
     785:	48 89 c7             	mov    %rax,%rdi
     788:	e8 99 07 00 00       	call   f26 <strchr>
     78d:	48 85 c0             	test   %rax,%rax
     790:	74 07                	je     799 <peek+0x87>
     792:	b8 01 00 00 00       	mov    $0x1,%eax
     797:	eb 05                	jmp    79e <peek+0x8c>
     799:	b8 00 00 00 00       	mov    $0x0,%eax
}
     79e:	c9                   	leave
     79f:	c3                   	ret

00000000000007a0 <parsecmd>:
struct cmd *parseexec(char**, char*);
struct cmd *nulterminate(struct cmd*);

struct cmd*
parsecmd(char *s)
{
     7a0:	55                   	push   %rbp
     7a1:	48 89 e5             	mov    %rsp,%rbp
     7a4:	53                   	push   %rbx
     7a5:	48 83 ec 28          	sub    $0x28,%rsp
     7a9:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  char *es;
  struct cmd *cmd;

  es = s + strlen(s);
     7ad:	48 8b 5d d8          	mov    -0x28(%rbp),%rbx
     7b1:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
     7b5:	48 89 c7             	mov    %rax,%rdi
     7b8:	e8 0b 07 00 00       	call   ec8 <strlen>
     7bd:	89 c0                	mov    %eax,%eax
     7bf:	48 01 d8             	add    %rbx,%rax
     7c2:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  cmd = parseline(&s, es);
     7c6:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
     7ca:	48 8d 45 d8          	lea    -0x28(%rbp),%rax
     7ce:	48 89 d6             	mov    %rdx,%rsi
     7d1:	48 89 c7             	mov    %rax,%rdi
     7d4:	e8 67 00 00 00       	call   840 <parseline>
     7d9:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  peek(&s, es, "");
     7dd:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
     7e1:	48 8d 45 d8          	lea    -0x28(%rbp),%rax
     7e5:	48 c7 c2 0a 19 00 00 	mov    $0x190a,%rdx
     7ec:	48 89 ce             	mov    %rcx,%rsi
     7ef:	48 89 c7             	mov    %rax,%rdi
     7f2:	e8 1b ff ff ff       	call   712 <peek>
  if(s != es){
     7f7:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
     7fb:	48 39 45 e8          	cmp    %rax,-0x18(%rbp)
     7ff:	74 29                	je     82a <parsecmd+0x8a>
    printf(2, "leftovers: %s\n", s);
     801:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
     805:	48 89 c2             	mov    %rax,%rdx
     808:	48 c7 c6 0b 19 00 00 	mov    $0x190b,%rsi
     80f:	bf 02 00 00 00       	mov    $0x2,%edi
     814:	b8 00 00 00 00       	mov    $0x0,%eax
     819:	e8 63 0a 00 00       	call   1281 <printf>
    panic("syntax");
     81e:	48 c7 c7 1a 19 00 00 	mov    $0x191a,%rdi
     825:	e8 51 fb ff ff       	call   37b <panic>
  }
  nulterminate(cmd);
     82a:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
     82e:	48 89 c7             	mov    %rax,%rdi
     831:	e8 b2 04 00 00       	call   ce8 <nulterminate>
  return cmd;
     836:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
}
     83a:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
     83e:	c9                   	leave
     83f:	c3                   	ret

0000000000000840 <parseline>:

struct cmd*
parseline(char **ps, char *es)
{
     840:	55                   	push   %rbp
     841:	48 89 e5             	mov    %rsp,%rbp
     844:	48 83 ec 20          	sub    $0x20,%rsp
     848:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
     84c:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  struct cmd *cmd;

  cmd = parsepipe(ps, es);
     850:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
     854:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
     858:	48 89 d6             	mov    %rdx,%rsi
     85b:	48 89 c7             	mov    %rax,%rdi
     85e:	e8 b5 00 00 00       	call   918 <parsepipe>
     863:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  while(peek(ps, es, "&")){
     867:	eb 2a                	jmp    893 <parseline+0x53>
    gettoken(ps, es, 0, 0);
     869:	48 8b 75 e0          	mov    -0x20(%rbp),%rsi
     86d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
     871:	b9 00 00 00 00       	mov    $0x0,%ecx
     876:	ba 00 00 00 00       	mov    $0x0,%edx
     87b:	48 89 c7             	mov    %rax,%rdi
     87e:	e8 14 fd ff ff       	call   597 <gettoken>
    cmd = backcmd(cmd);
     883:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     887:	48 89 c7             	mov    %rax,%rdi
     88a:	e8 bc fc ff ff       	call   54b <backcmd>
     88f:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  while(peek(ps, es, "&")){
     893:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
     897:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
     89b:	48 c7 c2 21 19 00 00 	mov    $0x1921,%rdx
     8a2:	48 89 ce             	mov    %rcx,%rsi
     8a5:	48 89 c7             	mov    %rax,%rdi
     8a8:	e8 65 fe ff ff       	call   712 <peek>
     8ad:	85 c0                	test   %eax,%eax
     8af:	75 b8                	jne    869 <parseline+0x29>
  }
  if(peek(ps, es, ";")){
     8b1:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
     8b5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
     8b9:	48 c7 c2 23 19 00 00 	mov    $0x1923,%rdx
     8c0:	48 89 ce             	mov    %rcx,%rsi
     8c3:	48 89 c7             	mov    %rax,%rdi
     8c6:	e8 47 fe ff ff       	call   712 <peek>
     8cb:	85 c0                	test   %eax,%eax
     8cd:	74 43                	je     912 <parseline+0xd2>
    gettoken(ps, es, 0, 0);
     8cf:	48 8b 75 e0          	mov    -0x20(%rbp),%rsi
     8d3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
     8d7:	b9 00 00 00 00       	mov    $0x0,%ecx
     8dc:	ba 00 00 00 00       	mov    $0x0,%edx
     8e1:	48 89 c7             	mov    %rax,%rdi
     8e4:	e8 ae fc ff ff       	call   597 <gettoken>
    cmd = listcmd(cmd, parseline(ps, es));
     8e9:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
     8ed:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
     8f1:	48 89 d6             	mov    %rdx,%rsi
     8f4:	48 89 c7             	mov    %rax,%rdi
     8f7:	e8 44 ff ff ff       	call   840 <parseline>
     8fc:	48 89 c2             	mov    %rax,%rdx
     8ff:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     903:	48 89 d6             	mov    %rdx,%rsi
     906:	48 89 c7             	mov    %rax,%rdi
     909:	e8 e1 fb ff ff       	call   4ef <listcmd>
     90e:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  }
  return cmd;
     912:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
     916:	c9                   	leave
     917:	c3                   	ret

0000000000000918 <parsepipe>:

struct cmd*
parsepipe(char **ps, char *es)
{
     918:	55                   	push   %rbp
     919:	48 89 e5             	mov    %rsp,%rbp
     91c:	48 83 ec 20          	sub    $0x20,%rsp
     920:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
     924:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  struct cmd *cmd;

  cmd = parseexec(ps, es);
     928:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
     92c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
     930:	48 89 d6             	mov    %rdx,%rsi
     933:	48 89 c7             	mov    %rax,%rdi
     936:	e8 48 02 00 00       	call   b83 <parseexec>
     93b:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  if(peek(ps, es, "|")){
     93f:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
     943:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
     947:	48 c7 c2 25 19 00 00 	mov    $0x1925,%rdx
     94e:	48 89 ce             	mov    %rcx,%rsi
     951:	48 89 c7             	mov    %rax,%rdi
     954:	e8 b9 fd ff ff       	call   712 <peek>
     959:	85 c0                	test   %eax,%eax
     95b:	74 43                	je     9a0 <parsepipe+0x88>
    gettoken(ps, es, 0, 0);
     95d:	48 8b 75 e0          	mov    -0x20(%rbp),%rsi
     961:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
     965:	b9 00 00 00 00       	mov    $0x0,%ecx
     96a:	ba 00 00 00 00       	mov    $0x0,%edx
     96f:	48 89 c7             	mov    %rax,%rdi
     972:	e8 20 fc ff ff       	call   597 <gettoken>
    cmd = pipecmd(cmd, parsepipe(ps, es));
     977:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
     97b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
     97f:	48 89 d6             	mov    %rdx,%rsi
     982:	48 89 c7             	mov    %rax,%rdi
     985:	e8 8e ff ff ff       	call   918 <parsepipe>
     98a:	48 89 c2             	mov    %rax,%rdx
     98d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     991:	48 89 d6             	mov    %rdx,%rsi
     994:	48 89 c7             	mov    %rax,%rdi
     997:	e8 f7 fa ff ff       	call   493 <pipecmd>
     99c:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  }
  return cmd;
     9a0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
     9a4:	c9                   	leave
     9a5:	c3                   	ret

00000000000009a6 <parseredirs>:

struct cmd*
parseredirs(struct cmd *cmd, char **ps, char *es)
{
     9a6:	55                   	push   %rbp
     9a7:	48 89 e5             	mov    %rsp,%rbp
     9aa:	48 83 ec 40          	sub    $0x40,%rsp
     9ae:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
     9b2:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
     9b6:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  int tok;
  char *q, *eq;

  while(peek(ps, es, "<>")){
     9ba:	e9 cc 00 00 00       	jmp    a8b <parseredirs+0xe5>
    tok = gettoken(ps, es, 0, 0);
     9bf:	48 8b 75 c8          	mov    -0x38(%rbp),%rsi
     9c3:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
     9c7:	b9 00 00 00 00       	mov    $0x0,%ecx
     9cc:	ba 00 00 00 00       	mov    $0x0,%edx
     9d1:	48 89 c7             	mov    %rax,%rdi
     9d4:	e8 be fb ff ff       	call   597 <gettoken>
     9d9:	89 45 fc             	mov    %eax,-0x4(%rbp)
    if(gettoken(ps, es, &q, &eq) != 'a')
     9dc:	48 8d 4d e8          	lea    -0x18(%rbp),%rcx
     9e0:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
     9e4:	48 8b 75 c8          	mov    -0x38(%rbp),%rsi
     9e8:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
     9ec:	48 89 c7             	mov    %rax,%rdi
     9ef:	e8 a3 fb ff ff       	call   597 <gettoken>
     9f4:	83 f8 61             	cmp    $0x61,%eax
     9f7:	74 0c                	je     a05 <parseredirs+0x5f>
      panic("missing file for redirection");
     9f9:	48 c7 c7 27 19 00 00 	mov    $0x1927,%rdi
     a00:	e8 76 f9 ff ff       	call   37b <panic>
    switch(tok){
     a05:	83 7d fc 3e          	cmpl   $0x3e,-0x4(%rbp)
     a09:	74 37                	je     a42 <parseredirs+0x9c>
     a0b:	83 7d fc 3e          	cmpl   $0x3e,-0x4(%rbp)
     a0f:	7f 7a                	jg     a8b <parseredirs+0xe5>
     a11:	83 7d fc 2b          	cmpl   $0x2b,-0x4(%rbp)
     a15:	74 50                	je     a67 <parseredirs+0xc1>
     a17:	83 7d fc 3c          	cmpl   $0x3c,-0x4(%rbp)
     a1b:	75 6e                	jne    a8b <parseredirs+0xe5>
    case '<':
      cmd = redircmd(cmd, q, eq, O_RDONLY, 0);
     a1d:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
     a21:	48 8b 75 f0          	mov    -0x10(%rbp),%rsi
     a25:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
     a29:	41 b8 00 00 00 00    	mov    $0x0,%r8d
     a2f:	b9 00 00 00 00       	mov    $0x0,%ecx
     a34:	48 89 c7             	mov    %rax,%rdi
     a37:	e8 d0 f9 ff ff       	call   40c <redircmd>
     a3c:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
      break;
     a40:	eb 49                	jmp    a8b <parseredirs+0xe5>
    case '>':
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
     a42:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
     a46:	48 8b 75 f0          	mov    -0x10(%rbp),%rsi
     a4a:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
     a4e:	41 b8 01 00 00 00    	mov    $0x1,%r8d
     a54:	b9 01 02 00 00       	mov    $0x201,%ecx
     a59:	48 89 c7             	mov    %rax,%rdi
     a5c:	e8 ab f9 ff ff       	call   40c <redircmd>
     a61:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
      break;
     a65:	eb 24                	jmp    a8b <parseredirs+0xe5>
    case '+':  // >>
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
     a67:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
     a6b:	48 8b 75 f0          	mov    -0x10(%rbp),%rsi
     a6f:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
     a73:	41 b8 01 00 00 00    	mov    $0x1,%r8d
     a79:	b9 01 02 00 00       	mov    $0x201,%ecx
     a7e:	48 89 c7             	mov    %rax,%rdi
     a81:	e8 86 f9 ff ff       	call   40c <redircmd>
     a86:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
      break;
     a8a:	90                   	nop
  while(peek(ps, es, "<>")){
     a8b:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
     a8f:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
     a93:	48 c7 c2 44 19 00 00 	mov    $0x1944,%rdx
     a9a:	48 89 ce             	mov    %rcx,%rsi
     a9d:	48 89 c7             	mov    %rax,%rdi
     aa0:	e8 6d fc ff ff       	call   712 <peek>
     aa5:	85 c0                	test   %eax,%eax
     aa7:	0f 85 12 ff ff ff    	jne    9bf <parseredirs+0x19>
    }
  }
  return cmd;
     aad:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
}
     ab1:	c9                   	leave
     ab2:	c3                   	ret

0000000000000ab3 <parseblock>:

struct cmd*
parseblock(char **ps, char *es)
{
     ab3:	55                   	push   %rbp
     ab4:	48 89 e5             	mov    %rsp,%rbp
     ab7:	48 83 ec 20          	sub    $0x20,%rsp
     abb:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
     abf:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  struct cmd *cmd;

  if(!peek(ps, es, "("))
     ac3:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
     ac7:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
     acb:	48 c7 c2 47 19 00 00 	mov    $0x1947,%rdx
     ad2:	48 89 ce             	mov    %rcx,%rsi
     ad5:	48 89 c7             	mov    %rax,%rdi
     ad8:	e8 35 fc ff ff       	call   712 <peek>
     add:	85 c0                	test   %eax,%eax
     adf:	75 0c                	jne    aed <parseblock+0x3a>
    panic("parseblock");
     ae1:	48 c7 c7 49 19 00 00 	mov    $0x1949,%rdi
     ae8:	e8 8e f8 ff ff       	call   37b <panic>
  gettoken(ps, es, 0, 0);
     aed:	48 8b 75 e0          	mov    -0x20(%rbp),%rsi
     af1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
     af5:	b9 00 00 00 00       	mov    $0x0,%ecx
     afa:	ba 00 00 00 00       	mov    $0x0,%edx
     aff:	48 89 c7             	mov    %rax,%rdi
     b02:	e8 90 fa ff ff       	call   597 <gettoken>
  cmd = parseline(ps, es);
     b07:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
     b0b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
     b0f:	48 89 d6             	mov    %rdx,%rsi
     b12:	48 89 c7             	mov    %rax,%rdi
     b15:	e8 26 fd ff ff       	call   840 <parseline>
     b1a:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  if(!peek(ps, es, ")"))
     b1e:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
     b22:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
     b26:	48 c7 c2 54 19 00 00 	mov    $0x1954,%rdx
     b2d:	48 89 ce             	mov    %rcx,%rsi
     b30:	48 89 c7             	mov    %rax,%rdi
     b33:	e8 da fb ff ff       	call   712 <peek>
     b38:	85 c0                	test   %eax,%eax
     b3a:	75 0c                	jne    b48 <parseblock+0x95>
    panic("syntax - missing )");
     b3c:	48 c7 c7 56 19 00 00 	mov    $0x1956,%rdi
     b43:	e8 33 f8 ff ff       	call   37b <panic>
  gettoken(ps, es, 0, 0);
     b48:	48 8b 75 e0          	mov    -0x20(%rbp),%rsi
     b4c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
     b50:	b9 00 00 00 00       	mov    $0x0,%ecx
     b55:	ba 00 00 00 00       	mov    $0x0,%edx
     b5a:	48 89 c7             	mov    %rax,%rdi
     b5d:	e8 35 fa ff ff       	call   597 <gettoken>
  cmd = parseredirs(cmd, ps, es);
     b62:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
     b66:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
     b6a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     b6e:	48 89 ce             	mov    %rcx,%rsi
     b71:	48 89 c7             	mov    %rax,%rdi
     b74:	e8 2d fe ff ff       	call   9a6 <parseredirs>
     b79:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  return cmd;
     b7d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
     b81:	c9                   	leave
     b82:	c3                   	ret

0000000000000b83 <parseexec>:

struct cmd*
parseexec(char **ps, char *es)
{
     b83:	55                   	push   %rbp
     b84:	48 89 e5             	mov    %rsp,%rbp
     b87:	48 83 ec 40          	sub    $0x40,%rsp
     b8b:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
     b8f:	48 89 75 c0          	mov    %rsi,-0x40(%rbp)
  char *q, *eq;
  int tok, argc;
  struct execcmd *cmd;
  struct cmd *ret;
  
  if(peek(ps, es, "("))
     b93:	48 8b 4d c0          	mov    -0x40(%rbp),%rcx
     b97:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
     b9b:	48 c7 c2 47 19 00 00 	mov    $0x1947,%rdx
     ba2:	48 89 ce             	mov    %rcx,%rsi
     ba5:	48 89 c7             	mov    %rax,%rdi
     ba8:	e8 65 fb ff ff       	call   712 <peek>
     bad:	85 c0                	test   %eax,%eax
     baf:	74 18                	je     bc9 <parseexec+0x46>
    return parseblock(ps, es);
     bb1:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
     bb5:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
     bb9:	48 89 d6             	mov    %rdx,%rsi
     bbc:	48 89 c7             	mov    %rax,%rdi
     bbf:	e8 ef fe ff ff       	call   ab3 <parseblock>
     bc4:	e9 1d 01 00 00       	jmp    ce6 <parseexec+0x163>

  ret = execcmd();
     bc9:	e8 02 f8 ff ff       	call   3d0 <execcmd>
     bce:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  cmd = (struct execcmd*)ret;
     bd2:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
     bd6:	48 89 45 e8          	mov    %rax,-0x18(%rbp)

  argc = 0;
     bda:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  ret = parseredirs(ret, ps, es);
     be1:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
     be5:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
     be9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
     bed:	48 89 ce             	mov    %rcx,%rsi
     bf0:	48 89 c7             	mov    %rax,%rdi
     bf3:	e8 ae fd ff ff       	call   9a6 <parseredirs>
     bf8:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  while(!peek(ps, es, "|)&;")){
     bfc:	e9 92 00 00 00       	jmp    c93 <parseexec+0x110>
    if((tok=gettoken(ps, es, &q, &eq)) == 0)
     c01:	48 8d 4d d0          	lea    -0x30(%rbp),%rcx
     c05:	48 8d 55 d8          	lea    -0x28(%rbp),%rdx
     c09:	48 8b 75 c0          	mov    -0x40(%rbp),%rsi
     c0d:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
     c11:	48 89 c7             	mov    %rax,%rdi
     c14:	e8 7e f9 ff ff       	call   597 <gettoken>
     c19:	89 45 e4             	mov    %eax,-0x1c(%rbp)
     c1c:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
     c20:	0f 84 91 00 00 00    	je     cb7 <parseexec+0x134>
      break;
    if(tok != 'a')
     c26:	83 7d e4 61          	cmpl   $0x61,-0x1c(%rbp)
     c2a:	74 0c                	je     c38 <parseexec+0xb5>
      panic("syntax");
     c2c:	48 c7 c7 1a 19 00 00 	mov    $0x191a,%rdi
     c33:	e8 43 f7 ff ff       	call   37b <panic>
    cmd->argv[argc] = q;
     c38:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
     c3c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
     c40:	8b 55 fc             	mov    -0x4(%rbp),%edx
     c43:	48 63 d2             	movslq %edx,%rdx
     c46:	48 89 4c d0 08       	mov    %rcx,0x8(%rax,%rdx,8)
    cmd->eargv[argc] = eq;
     c4b:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
     c4f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
     c53:	8b 4d fc             	mov    -0x4(%rbp),%ecx
     c56:	48 63 c9             	movslq %ecx,%rcx
     c59:	48 83 c1 0a          	add    $0xa,%rcx
     c5d:	48 89 54 c8 08       	mov    %rdx,0x8(%rax,%rcx,8)
    argc++;
     c62:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    if(argc >= MAXARGS)
     c66:	83 7d fc 09          	cmpl   $0x9,-0x4(%rbp)
     c6a:	7e 0c                	jle    c78 <parseexec+0xf5>
      panic("too many args");
     c6c:	48 c7 c7 69 19 00 00 	mov    $0x1969,%rdi
     c73:	e8 03 f7 ff ff       	call   37b <panic>
    ret = parseredirs(ret, ps, es);
     c78:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
     c7c:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
     c80:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
     c84:	48 89 ce             	mov    %rcx,%rsi
     c87:	48 89 c7             	mov    %rax,%rdi
     c8a:	e8 17 fd ff ff       	call   9a6 <parseredirs>
     c8f:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  while(!peek(ps, es, "|)&;")){
     c93:	48 8b 4d c0          	mov    -0x40(%rbp),%rcx
     c97:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
     c9b:	48 c7 c2 77 19 00 00 	mov    $0x1977,%rdx
     ca2:	48 89 ce             	mov    %rcx,%rsi
     ca5:	48 89 c7             	mov    %rax,%rdi
     ca8:	e8 65 fa ff ff       	call   712 <peek>
     cad:	85 c0                	test   %eax,%eax
     caf:	0f 84 4c ff ff ff    	je     c01 <parseexec+0x7e>
     cb5:	eb 01                	jmp    cb8 <parseexec+0x135>
      break;
     cb7:	90                   	nop
  }
  cmd->argv[argc] = 0;
     cb8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
     cbc:	8b 55 fc             	mov    -0x4(%rbp),%edx
     cbf:	48 63 d2             	movslq %edx,%rdx
     cc2:	48 c7 44 d0 08 00 00 	movq   $0x0,0x8(%rax,%rdx,8)
     cc9:	00 00 
  cmd->eargv[argc] = 0;
     ccb:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
     ccf:	8b 55 fc             	mov    -0x4(%rbp),%edx
     cd2:	48 63 d2             	movslq %edx,%rdx
     cd5:	48 83 c2 0a          	add    $0xa,%rdx
     cd9:	48 c7 44 d0 08 00 00 	movq   $0x0,0x8(%rax,%rdx,8)
     ce0:	00 00 
  return ret;
     ce2:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
}
     ce6:	c9                   	leave
     ce7:	c3                   	ret

0000000000000ce8 <nulterminate>:

// NUL-terminate all the counted strings.
struct cmd*
nulterminate(struct cmd *cmd)
{
     ce8:	55                   	push   %rbp
     ce9:	48 89 e5             	mov    %rsp,%rbp
     cec:	48 83 ec 40          	sub    $0x40,%rsp
     cf0:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
  struct execcmd *ecmd;
  struct listcmd *lcmd;
  struct pipecmd *pcmd;
  struct redircmd *rcmd;

  if(cmd == 0)
     cf4:	48 83 7d c8 00       	cmpq   $0x0,-0x38(%rbp)
     cf9:	75 0a                	jne    d05 <nulterminate+0x1d>
    return 0;
     cfb:	b8 00 00 00 00       	mov    $0x0,%eax
     d00:	e9 f5 00 00 00       	jmp    dfa <nulterminate+0x112>
  
  switch(cmd->type){
     d05:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
     d09:	8b 00                	mov    (%rax),%eax
     d0b:	83 f8 05             	cmp    $0x5,%eax
     d0e:	0f 87 e2 00 00 00    	ja     df6 <nulterminate+0x10e>
     d14:	89 c0                	mov    %eax,%eax
     d16:	48 8b 04 c5 80 19 00 	mov    0x1980(,%rax,8),%rax
     d1d:	00 
     d1e:	ff e0                	jmp    *%rax
  case EXEC:
    ecmd = (struct execcmd*)cmd;
     d20:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
     d24:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
    for(i=0; ecmd->argv[i]; i++)
     d28:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
     d2f:	eb 1a                	jmp    d4b <nulterminate+0x63>
      *ecmd->eargv[i] = 0;
     d31:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
     d35:	8b 55 fc             	mov    -0x4(%rbp),%edx
     d38:	48 63 d2             	movslq %edx,%rdx
     d3b:	48 83 c2 0a          	add    $0xa,%rdx
     d3f:	48 8b 44 d0 08       	mov    0x8(%rax,%rdx,8),%rax
     d44:	c6 00 00             	movb   $0x0,(%rax)
    for(i=0; ecmd->argv[i]; i++)
     d47:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
     d4b:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
     d4f:	8b 55 fc             	mov    -0x4(%rbp),%edx
     d52:	48 63 d2             	movslq %edx,%rdx
     d55:	48 8b 44 d0 08       	mov    0x8(%rax,%rdx,8),%rax
     d5a:	48 85 c0             	test   %rax,%rax
     d5d:	75 d2                	jne    d31 <nulterminate+0x49>
    break;
     d5f:	e9 92 00 00 00       	jmp    df6 <nulterminate+0x10e>

  case REDIR:
    rcmd = (struct redircmd*)cmd;
     d64:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
     d68:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
    nulterminate(rcmd->cmd);
     d6c:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
     d70:	48 8b 40 08          	mov    0x8(%rax),%rax
     d74:	48 89 c7             	mov    %rax,%rdi
     d77:	e8 6c ff ff ff       	call   ce8 <nulterminate>
    *rcmd->efile = 0;
     d7c:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
     d80:	48 8b 40 18          	mov    0x18(%rax),%rax
     d84:	c6 00 00             	movb   $0x0,(%rax)
    break;
     d87:	eb 6d                	jmp    df6 <nulterminate+0x10e>

  case PIPE:
    pcmd = (struct pipecmd*)cmd;
     d89:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
     d8d:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    nulterminate(pcmd->left);
     d91:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
     d95:	48 8b 40 08          	mov    0x8(%rax),%rax
     d99:	48 89 c7             	mov    %rax,%rdi
     d9c:	e8 47 ff ff ff       	call   ce8 <nulterminate>
    nulterminate(pcmd->right);
     da1:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
     da5:	48 8b 40 10          	mov    0x10(%rax),%rax
     da9:	48 89 c7             	mov    %rax,%rdi
     dac:	e8 37 ff ff ff       	call   ce8 <nulterminate>
    break;
     db1:	eb 43                	jmp    df6 <nulterminate+0x10e>
    
  case LIST:
    lcmd = (struct listcmd*)cmd;
     db3:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
     db7:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    nulterminate(lcmd->left);
     dbb:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
     dbf:	48 8b 40 08          	mov    0x8(%rax),%rax
     dc3:	48 89 c7             	mov    %rax,%rdi
     dc6:	e8 1d ff ff ff       	call   ce8 <nulterminate>
    nulterminate(lcmd->right);
     dcb:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
     dcf:	48 8b 40 10          	mov    0x10(%rax),%rax
     dd3:	48 89 c7             	mov    %rax,%rdi
     dd6:	e8 0d ff ff ff       	call   ce8 <nulterminate>
    break;
     ddb:	eb 19                	jmp    df6 <nulterminate+0x10e>

  case BACK:
    bcmd = (struct backcmd*)cmd;
     ddd:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
     de1:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    nulterminate(bcmd->cmd);
     de5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
     de9:	48 8b 40 08          	mov    0x8(%rax),%rax
     ded:	48 89 c7             	mov    %rax,%rdi
     df0:	e8 f3 fe ff ff       	call   ce8 <nulterminate>
    break;
     df5:	90                   	nop
  }
  return cmd;
     df6:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
}
     dfa:	c9                   	leave
     dfb:	c3                   	ret

0000000000000dfc <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
     dfc:	55                   	push   %rbp
     dfd:	48 89 e5             	mov    %rsp,%rbp
     e00:	48 83 ec 10          	sub    $0x10,%rsp
     e04:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
     e08:	89 75 f4             	mov    %esi,-0xc(%rbp)
     e0b:	89 55 f0             	mov    %edx,-0x10(%rbp)
  asm volatile("cld; rep stosb" :
     e0e:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
     e12:	8b 55 f0             	mov    -0x10(%rbp),%edx
     e15:	8b 45 f4             	mov    -0xc(%rbp),%eax
     e18:	48 89 ce             	mov    %rcx,%rsi
     e1b:	48 89 f7             	mov    %rsi,%rdi
     e1e:	89 d1                	mov    %edx,%ecx
     e20:	fc                   	cld
     e21:	f3 aa                	rep stos %al,%es:(%rdi)
     e23:	89 ca                	mov    %ecx,%edx
     e25:	48 89 fe             	mov    %rdi,%rsi
     e28:	48 89 75 f8          	mov    %rsi,-0x8(%rbp)
     e2c:	89 55 f0             	mov    %edx,-0x10(%rbp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
     e2f:	90                   	nop
     e30:	c9                   	leave
     e31:	c3                   	ret

0000000000000e32 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
     e32:	55                   	push   %rbp
     e33:	48 89 e5             	mov    %rsp,%rbp
     e36:	48 83 ec 20          	sub    $0x20,%rsp
     e3a:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
     e3e:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  char *os;

  os = s;
     e42:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
     e46:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  while((*s++ = *t++) != 0)
     e4a:	90                   	nop
     e4b:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
     e4f:	48 8d 42 01          	lea    0x1(%rdx),%rax
     e53:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
     e57:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
     e5b:	48 8d 48 01          	lea    0x1(%rax),%rcx
     e5f:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
     e63:	0f b6 12             	movzbl (%rdx),%edx
     e66:	88 10                	mov    %dl,(%rax)
     e68:	0f b6 00             	movzbl (%rax),%eax
     e6b:	84 c0                	test   %al,%al
     e6d:	75 dc                	jne    e4b <strcpy+0x19>
    ;
  return os;
     e6f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
     e73:	c9                   	leave
     e74:	c3                   	ret

0000000000000e75 <strcmp>:

int
strcmp(const char *p, const char *q)
{
     e75:	55                   	push   %rbp
     e76:	48 89 e5             	mov    %rsp,%rbp
     e79:	48 83 ec 10          	sub    $0x10,%rsp
     e7d:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
     e81:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  while(*p && *p == *q)
     e85:	eb 0a                	jmp    e91 <strcmp+0x1c>
    p++, q++;
     e87:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
     e8c:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  while(*p && *p == *q)
     e91:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     e95:	0f b6 00             	movzbl (%rax),%eax
     e98:	84 c0                	test   %al,%al
     e9a:	74 12                	je     eae <strcmp+0x39>
     e9c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     ea0:	0f b6 10             	movzbl (%rax),%edx
     ea3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
     ea7:	0f b6 00             	movzbl (%rax),%eax
     eaa:	38 c2                	cmp    %al,%dl
     eac:	74 d9                	je     e87 <strcmp+0x12>
  return (uchar)*p - (uchar)*q;
     eae:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     eb2:	0f b6 00             	movzbl (%rax),%eax
     eb5:	0f b6 d0             	movzbl %al,%edx
     eb8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
     ebc:	0f b6 00             	movzbl (%rax),%eax
     ebf:	0f b6 c0             	movzbl %al,%eax
     ec2:	29 c2                	sub    %eax,%edx
     ec4:	89 d0                	mov    %edx,%eax
}
     ec6:	c9                   	leave
     ec7:	c3                   	ret

0000000000000ec8 <strlen>:

uint
strlen(char *s)
{
     ec8:	55                   	push   %rbp
     ec9:	48 89 e5             	mov    %rsp,%rbp
     ecc:	48 83 ec 18          	sub    $0x18,%rsp
     ed0:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  int n;

  for(n = 0; s[n]; n++)
     ed4:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
     edb:	eb 04                	jmp    ee1 <strlen+0x19>
     edd:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
     ee1:	8b 45 fc             	mov    -0x4(%rbp),%eax
     ee4:	48 63 d0             	movslq %eax,%rdx
     ee7:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
     eeb:	48 01 d0             	add    %rdx,%rax
     eee:	0f b6 00             	movzbl (%rax),%eax
     ef1:	84 c0                	test   %al,%al
     ef3:	75 e8                	jne    edd <strlen+0x15>
    ;
  return n;
     ef5:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
     ef8:	c9                   	leave
     ef9:	c3                   	ret

0000000000000efa <memset>:

void*
memset(void *dst, int c, uint n)
{
     efa:	55                   	push   %rbp
     efb:	48 89 e5             	mov    %rsp,%rbp
     efe:	48 83 ec 10          	sub    $0x10,%rsp
     f02:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
     f06:	89 75 f4             	mov    %esi,-0xc(%rbp)
     f09:	89 55 f0             	mov    %edx,-0x10(%rbp)
  stosb(dst, c, n);
     f0c:	8b 55 f0             	mov    -0x10(%rbp),%edx
     f0f:	8b 4d f4             	mov    -0xc(%rbp),%ecx
     f12:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     f16:	89 ce                	mov    %ecx,%esi
     f18:	48 89 c7             	mov    %rax,%rdi
     f1b:	e8 dc fe ff ff       	call   dfc <stosb>
  return dst;
     f20:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
     f24:	c9                   	leave
     f25:	c3                   	ret

0000000000000f26 <strchr>:

char*
strchr(const char *s, char c)
{
     f26:	55                   	push   %rbp
     f27:	48 89 e5             	mov    %rsp,%rbp
     f2a:	48 83 ec 10          	sub    $0x10,%rsp
     f2e:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
     f32:	89 f0                	mov    %esi,%eax
     f34:	88 45 f4             	mov    %al,-0xc(%rbp)
  for(; *s; s++)
     f37:	eb 17                	jmp    f50 <strchr+0x2a>
    if(*s == c)
     f39:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     f3d:	0f b6 00             	movzbl (%rax),%eax
     f40:	38 45 f4             	cmp    %al,-0xc(%rbp)
     f43:	75 06                	jne    f4b <strchr+0x25>
      return (char*)s;
     f45:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     f49:	eb 15                	jmp    f60 <strchr+0x3a>
  for(; *s; s++)
     f4b:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
     f50:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     f54:	0f b6 00             	movzbl (%rax),%eax
     f57:	84 c0                	test   %al,%al
     f59:	75 de                	jne    f39 <strchr+0x13>
  return 0;
     f5b:	b8 00 00 00 00       	mov    $0x0,%eax
}
     f60:	c9                   	leave
     f61:	c3                   	ret

0000000000000f62 <gets>:

char*
gets(char *buf, int max)
{
     f62:	55                   	push   %rbp
     f63:	48 89 e5             	mov    %rsp,%rbp
     f66:	48 83 ec 20          	sub    $0x20,%rsp
     f6a:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
     f6e:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     f71:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
     f78:	eb 48                	jmp    fc2 <gets+0x60>
    cc = read(0, &c, 1);
     f7a:	48 8d 45 f7          	lea    -0x9(%rbp),%rax
     f7e:	ba 01 00 00 00       	mov    $0x1,%edx
     f83:	48 89 c6             	mov    %rax,%rsi
     f86:	bf 00 00 00 00       	mov    $0x0,%edi
     f8b:	e8 77 01 00 00       	call   1107 <read>
     f90:	89 45 f8             	mov    %eax,-0x8(%rbp)
    if(cc < 1)
     f93:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
     f97:	7e 36                	jle    fcf <gets+0x6d>
      break;
    buf[i++] = c;
     f99:	8b 45 fc             	mov    -0x4(%rbp),%eax
     f9c:	8d 50 01             	lea    0x1(%rax),%edx
     f9f:	89 55 fc             	mov    %edx,-0x4(%rbp)
     fa2:	48 63 d0             	movslq %eax,%rdx
     fa5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
     fa9:	48 01 c2             	add    %rax,%rdx
     fac:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
     fb0:	88 02                	mov    %al,(%rdx)
    if(c == '\n' || c == '\r')
     fb2:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
     fb6:	3c 0a                	cmp    $0xa,%al
     fb8:	74 16                	je     fd0 <gets+0x6e>
     fba:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
     fbe:	3c 0d                	cmp    $0xd,%al
     fc0:	74 0e                	je     fd0 <gets+0x6e>
  for(i=0; i+1 < max; ){
     fc2:	8b 45 fc             	mov    -0x4(%rbp),%eax
     fc5:	83 c0 01             	add    $0x1,%eax
     fc8:	39 45 e4             	cmp    %eax,-0x1c(%rbp)
     fcb:	7f ad                	jg     f7a <gets+0x18>
     fcd:	eb 01                	jmp    fd0 <gets+0x6e>
      break;
     fcf:	90                   	nop
      break;
  }
  buf[i] = '\0';
     fd0:	8b 45 fc             	mov    -0x4(%rbp),%eax
     fd3:	48 63 d0             	movslq %eax,%rdx
     fd6:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
     fda:	48 01 d0             	add    %rdx,%rax
     fdd:	c6 00 00             	movb   $0x0,(%rax)
  return buf;
     fe0:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
     fe4:	c9                   	leave
     fe5:	c3                   	ret

0000000000000fe6 <stat>:

int
stat(char *n, struct stat *st)
{
     fe6:	55                   	push   %rbp
     fe7:	48 89 e5             	mov    %rsp,%rbp
     fea:	48 83 ec 20          	sub    $0x20,%rsp
     fee:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
     ff2:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     ff6:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
     ffa:	be 00 00 00 00       	mov    $0x0,%esi
     fff:	48 89 c7             	mov    %rax,%rdi
    1002:	e8 28 01 00 00       	call   112f <open>
    1007:	89 45 fc             	mov    %eax,-0x4(%rbp)
  if(fd < 0)
    100a:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    100e:	79 07                	jns    1017 <stat+0x31>
    return -1;
    1010:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    1015:	eb 21                	jmp    1038 <stat+0x52>
  r = fstat(fd, st);
    1017:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
    101b:	8b 45 fc             	mov    -0x4(%rbp),%eax
    101e:	48 89 d6             	mov    %rdx,%rsi
    1021:	89 c7                	mov    %eax,%edi
    1023:	e8 1f 01 00 00       	call   1147 <fstat>
    1028:	89 45 f8             	mov    %eax,-0x8(%rbp)
  close(fd);
    102b:	8b 45 fc             	mov    -0x4(%rbp),%eax
    102e:	89 c7                	mov    %eax,%edi
    1030:	e8 e2 00 00 00       	call   1117 <close>
  return r;
    1035:	8b 45 f8             	mov    -0x8(%rbp),%eax
}
    1038:	c9                   	leave
    1039:	c3                   	ret

000000000000103a <atoi>:

int
atoi(const char *s)
{
    103a:	55                   	push   %rbp
    103b:	48 89 e5             	mov    %rsp,%rbp
    103e:	48 83 ec 18          	sub    $0x18,%rsp
    1042:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  int n;

  n = 0;
    1046:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  while('0' <= *s && *s <= '9')
    104d:	eb 28                	jmp    1077 <atoi+0x3d>
    n = n*10 + *s++ - '0';
    104f:	8b 55 fc             	mov    -0x4(%rbp),%edx
    1052:	89 d0                	mov    %edx,%eax
    1054:	c1 e0 02             	shl    $0x2,%eax
    1057:	01 d0                	add    %edx,%eax
    1059:	01 c0                	add    %eax,%eax
    105b:	89 c1                	mov    %eax,%ecx
    105d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1061:	48 8d 50 01          	lea    0x1(%rax),%rdx
    1065:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
    1069:	0f b6 00             	movzbl (%rax),%eax
    106c:	0f be c0             	movsbl %al,%eax
    106f:	01 c8                	add    %ecx,%eax
    1071:	83 e8 30             	sub    $0x30,%eax
    1074:	89 45 fc             	mov    %eax,-0x4(%rbp)
  while('0' <= *s && *s <= '9')
    1077:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    107b:	0f b6 00             	movzbl (%rax),%eax
    107e:	3c 2f                	cmp    $0x2f,%al
    1080:	7e 0b                	jle    108d <atoi+0x53>
    1082:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1086:	0f b6 00             	movzbl (%rax),%eax
    1089:	3c 39                	cmp    $0x39,%al
    108b:	7e c2                	jle    104f <atoi+0x15>
  return n;
    108d:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
    1090:	c9                   	leave
    1091:	c3                   	ret

0000000000001092 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
    1092:	55                   	push   %rbp
    1093:	48 89 e5             	mov    %rsp,%rbp
    1096:	48 83 ec 28          	sub    $0x28,%rsp
    109a:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    109e:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    10a2:	89 55 dc             	mov    %edx,-0x24(%rbp)
  char *dst, *src;
  
  dst = vdst;
    10a5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    10a9:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  src = vsrc;
    10ad:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
    10b1:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  while(n-- > 0)
    10b5:	eb 1d                	jmp    10d4 <memmove+0x42>
    *dst++ = *src++;
    10b7:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
    10bb:	48 8d 42 01          	lea    0x1(%rdx),%rax
    10bf:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    10c3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    10c7:	48 8d 48 01          	lea    0x1(%rax),%rcx
    10cb:	48 89 4d f8          	mov    %rcx,-0x8(%rbp)
    10cf:	0f b6 12             	movzbl (%rdx),%edx
    10d2:	88 10                	mov    %dl,(%rax)
  while(n-- > 0)
    10d4:	8b 45 dc             	mov    -0x24(%rbp),%eax
    10d7:	8d 50 ff             	lea    -0x1(%rax),%edx
    10da:	89 55 dc             	mov    %edx,-0x24(%rbp)
    10dd:	85 c0                	test   %eax,%eax
    10df:	7f d6                	jg     10b7 <memmove+0x25>
  return vdst;
    10e1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
    10e5:	c9                   	leave
    10e6:	c3                   	ret

00000000000010e7 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    10e7:	b8 01 00 00 00       	mov    $0x1,%eax
    10ec:	cd 40                	int    $0x40
    10ee:	c3                   	ret

00000000000010ef <exit>:
SYSCALL(exit)
    10ef:	b8 02 00 00 00       	mov    $0x2,%eax
    10f4:	cd 40                	int    $0x40
    10f6:	c3                   	ret

00000000000010f7 <wait>:
SYSCALL(wait)
    10f7:	b8 03 00 00 00       	mov    $0x3,%eax
    10fc:	cd 40                	int    $0x40
    10fe:	c3                   	ret

00000000000010ff <pipe>:
SYSCALL(pipe)
    10ff:	b8 04 00 00 00       	mov    $0x4,%eax
    1104:	cd 40                	int    $0x40
    1106:	c3                   	ret

0000000000001107 <read>:
SYSCALL(read)
    1107:	b8 05 00 00 00       	mov    $0x5,%eax
    110c:	cd 40                	int    $0x40
    110e:	c3                   	ret

000000000000110f <write>:
SYSCALL(write)
    110f:	b8 10 00 00 00       	mov    $0x10,%eax
    1114:	cd 40                	int    $0x40
    1116:	c3                   	ret

0000000000001117 <close>:
SYSCALL(close)
    1117:	b8 15 00 00 00       	mov    $0x15,%eax
    111c:	cd 40                	int    $0x40
    111e:	c3                   	ret

000000000000111f <kill>:
SYSCALL(kill)
    111f:	b8 06 00 00 00       	mov    $0x6,%eax
    1124:	cd 40                	int    $0x40
    1126:	c3                   	ret

0000000000001127 <exec>:
SYSCALL(exec)
    1127:	b8 07 00 00 00       	mov    $0x7,%eax
    112c:	cd 40                	int    $0x40
    112e:	c3                   	ret

000000000000112f <open>:
SYSCALL(open)
    112f:	b8 0f 00 00 00       	mov    $0xf,%eax
    1134:	cd 40                	int    $0x40
    1136:	c3                   	ret

0000000000001137 <mknod>:
SYSCALL(mknod)
    1137:	b8 11 00 00 00       	mov    $0x11,%eax
    113c:	cd 40                	int    $0x40
    113e:	c3                   	ret

000000000000113f <unlink>:
SYSCALL(unlink)
    113f:	b8 12 00 00 00       	mov    $0x12,%eax
    1144:	cd 40                	int    $0x40
    1146:	c3                   	ret

0000000000001147 <fstat>:
SYSCALL(fstat)
    1147:	b8 08 00 00 00       	mov    $0x8,%eax
    114c:	cd 40                	int    $0x40
    114e:	c3                   	ret

000000000000114f <link>:
SYSCALL(link)
    114f:	b8 13 00 00 00       	mov    $0x13,%eax
    1154:	cd 40                	int    $0x40
    1156:	c3                   	ret

0000000000001157 <mkdir>:
SYSCALL(mkdir)
    1157:	b8 14 00 00 00       	mov    $0x14,%eax
    115c:	cd 40                	int    $0x40
    115e:	c3                   	ret

000000000000115f <chdir>:
SYSCALL(chdir)
    115f:	b8 09 00 00 00       	mov    $0x9,%eax
    1164:	cd 40                	int    $0x40
    1166:	c3                   	ret

0000000000001167 <dup>:
SYSCALL(dup)
    1167:	b8 0a 00 00 00       	mov    $0xa,%eax
    116c:	cd 40                	int    $0x40
    116e:	c3                   	ret

000000000000116f <getpid>:
SYSCALL(getpid)
    116f:	b8 0b 00 00 00       	mov    $0xb,%eax
    1174:	cd 40                	int    $0x40
    1176:	c3                   	ret

0000000000001177 <sbrk>:
SYSCALL(sbrk)
    1177:	b8 0c 00 00 00       	mov    $0xc,%eax
    117c:	cd 40                	int    $0x40
    117e:	c3                   	ret

000000000000117f <sleep>:
SYSCALL(sleep)
    117f:	b8 0d 00 00 00       	mov    $0xd,%eax
    1184:	cd 40                	int    $0x40
    1186:	c3                   	ret

0000000000001187 <uptime>:
SYSCALL(uptime)
    1187:	b8 0e 00 00 00       	mov    $0xe,%eax
    118c:	cd 40                	int    $0x40
    118e:	c3                   	ret

000000000000118f <getpinfo>:
SYSCALL(getpinfo)
    118f:	b8 18 00 00 00       	mov    $0x18,%eax
    1194:	cd 40                	int    $0x40
    1196:	c3                   	ret

0000000000001197 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
    1197:	55                   	push   %rbp
    1198:	48 89 e5             	mov    %rsp,%rbp
    119b:	48 83 ec 10          	sub    $0x10,%rsp
    119f:	89 7d fc             	mov    %edi,-0x4(%rbp)
    11a2:	89 f0                	mov    %esi,%eax
    11a4:	88 45 f8             	mov    %al,-0x8(%rbp)
  write(fd, &c, 1);
    11a7:	48 8d 4d f8          	lea    -0x8(%rbp),%rcx
    11ab:	8b 45 fc             	mov    -0x4(%rbp),%eax
    11ae:	ba 01 00 00 00       	mov    $0x1,%edx
    11b3:	48 89 ce             	mov    %rcx,%rsi
    11b6:	89 c7                	mov    %eax,%edi
    11b8:	e8 52 ff ff ff       	call   110f <write>
}
    11bd:	90                   	nop
    11be:	c9                   	leave
    11bf:	c3                   	ret

00000000000011c0 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    11c0:	55                   	push   %rbp
    11c1:	48 89 e5             	mov    %rsp,%rbp
    11c4:	48 83 ec 30          	sub    $0x30,%rsp
    11c8:	89 7d dc             	mov    %edi,-0x24(%rbp)
    11cb:	89 75 d8             	mov    %esi,-0x28(%rbp)
    11ce:	89 55 d4             	mov    %edx,-0x2c(%rbp)
    11d1:	89 4d d0             	mov    %ecx,-0x30(%rbp)
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
    11d4:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
  if(sgn && xx < 0){
    11db:	83 7d d0 00          	cmpl   $0x0,-0x30(%rbp)
    11df:	74 17                	je     11f8 <printint+0x38>
    11e1:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
    11e5:	79 11                	jns    11f8 <printint+0x38>
    neg = 1;
    11e7:	c7 45 f8 01 00 00 00 	movl   $0x1,-0x8(%rbp)
    x = -xx;
    11ee:	8b 45 d8             	mov    -0x28(%rbp),%eax
    11f1:	f7 d8                	neg    %eax
    11f3:	89 45 f4             	mov    %eax,-0xc(%rbp)
    11f6:	eb 06                	jmp    11fe <printint+0x3e>
  } else {
    x = xx;
    11f8:	8b 45 d8             	mov    -0x28(%rbp),%eax
    11fb:	89 45 f4             	mov    %eax,-0xc(%rbp)
  }

  i = 0;
    11fe:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  do{
    buf[i++] = digits[x % base];
    1205:	8b 4d d4             	mov    -0x2c(%rbp),%ecx
    1208:	8b 45 f4             	mov    -0xc(%rbp),%eax
    120b:	ba 00 00 00 00       	mov    $0x0,%edx
    1210:	f7 f1                	div    %ecx
    1212:	89 d1                	mov    %edx,%ecx
    1214:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1217:	8d 50 01             	lea    0x1(%rax),%edx
    121a:	89 55 fc             	mov    %edx,-0x4(%rbp)
    121d:	89 ca                	mov    %ecx,%edx
    121f:	0f b6 92 40 1e 00 00 	movzbl 0x1e40(%rdx),%edx
    1226:	48 98                	cltq
    1228:	88 54 05 e0          	mov    %dl,-0x20(%rbp,%rax,1)
  }while((x /= base) != 0);
    122c:	8b 75 d4             	mov    -0x2c(%rbp),%esi
    122f:	8b 45 f4             	mov    -0xc(%rbp),%eax
    1232:	ba 00 00 00 00       	mov    $0x0,%edx
    1237:	f7 f6                	div    %esi
    1239:	89 45 f4             	mov    %eax,-0xc(%rbp)
    123c:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
    1240:	75 c3                	jne    1205 <printint+0x45>
  if(neg)
    1242:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
    1246:	74 2b                	je     1273 <printint+0xb3>
    buf[i++] = '-';
    1248:	8b 45 fc             	mov    -0x4(%rbp),%eax
    124b:	8d 50 01             	lea    0x1(%rax),%edx
    124e:	89 55 fc             	mov    %edx,-0x4(%rbp)
    1251:	48 98                	cltq
    1253:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%rbp,%rax,1)

  while(--i >= 0)
    1258:	eb 19                	jmp    1273 <printint+0xb3>
    putc(fd, buf[i]);
    125a:	8b 45 fc             	mov    -0x4(%rbp),%eax
    125d:	48 98                	cltq
    125f:	0f b6 44 05 e0       	movzbl -0x20(%rbp,%rax,1),%eax
    1264:	0f be d0             	movsbl %al,%edx
    1267:	8b 45 dc             	mov    -0x24(%rbp),%eax
    126a:	89 d6                	mov    %edx,%esi
    126c:	89 c7                	mov    %eax,%edi
    126e:	e8 24 ff ff ff       	call   1197 <putc>
  while(--i >= 0)
    1273:	83 6d fc 01          	subl   $0x1,-0x4(%rbp)
    1277:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    127b:	79 dd                	jns    125a <printint+0x9a>
}
    127d:	90                   	nop
    127e:	90                   	nop
    127f:	c9                   	leave
    1280:	c3                   	ret

0000000000001281 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
    1281:	55                   	push   %rbp
    1282:	48 89 e5             	mov    %rsp,%rbp
    1285:	48 81 ec f0 00 00 00 	sub    $0xf0,%rsp
    128c:	89 bd 1c ff ff ff    	mov    %edi,-0xe4(%rbp)
    1292:	48 89 b5 10 ff ff ff 	mov    %rsi,-0xf0(%rbp)
    1299:	48 89 95 60 ff ff ff 	mov    %rdx,-0xa0(%rbp)
    12a0:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
    12a7:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
    12ae:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
    12b5:	84 c0                	test   %al,%al
    12b7:	74 20                	je     12d9 <printf+0x58>
    12b9:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
    12bd:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
    12c1:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
    12c5:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
    12c9:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
    12cd:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
    12d1:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
    12d5:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  va_list ap;
  char *s;
  int c, i, state;
  va_start(ap, fmt);
    12d9:	c7 85 20 ff ff ff 10 	movl   $0x10,-0xe0(%rbp)
    12e0:	00 00 00 
    12e3:	c7 85 24 ff ff ff 30 	movl   $0x30,-0xdc(%rbp)
    12ea:	00 00 00 
    12ed:	48 8d 45 10          	lea    0x10(%rbp),%rax
    12f1:	48 89 85 28 ff ff ff 	mov    %rax,-0xd8(%rbp)
    12f8:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
    12ff:	48 89 85 30 ff ff ff 	mov    %rax,-0xd0(%rbp)

  state = 0;
    1306:	c7 85 40 ff ff ff 00 	movl   $0x0,-0xc0(%rbp)
    130d:	00 00 00 
  for(i = 0; fmt[i]; i++){
    1310:	c7 85 44 ff ff ff 00 	movl   $0x0,-0xbc(%rbp)
    1317:	00 00 00 
    131a:	e9 a8 02 00 00       	jmp    15c7 <printf+0x346>
    c = fmt[i] & 0xff;
    131f:	8b 85 44 ff ff ff    	mov    -0xbc(%rbp),%eax
    1325:	48 63 d0             	movslq %eax,%rdx
    1328:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
    132f:	48 01 d0             	add    %rdx,%rax
    1332:	0f b6 00             	movzbl (%rax),%eax
    1335:	0f be c0             	movsbl %al,%eax
    1338:	25 ff 00 00 00       	and    $0xff,%eax
    133d:	89 85 3c ff ff ff    	mov    %eax,-0xc4(%rbp)
    if(state == 0){
    1343:	83 bd 40 ff ff ff 00 	cmpl   $0x0,-0xc0(%rbp)
    134a:	75 35                	jne    1381 <printf+0x100>
      if(c == '%'){
    134c:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
    1353:	75 0f                	jne    1364 <printf+0xe3>
        state = '%';
    1355:	c7 85 40 ff ff ff 25 	movl   $0x25,-0xc0(%rbp)
    135c:	00 00 00 
    135f:	e9 5c 02 00 00       	jmp    15c0 <printf+0x33f>
      } else {
        putc(fd, c);
    1364:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
    136a:	0f be d0             	movsbl %al,%edx
    136d:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1373:	89 d6                	mov    %edx,%esi
    1375:	89 c7                	mov    %eax,%edi
    1377:	e8 1b fe ff ff       	call   1197 <putc>
    137c:	e9 3f 02 00 00       	jmp    15c0 <printf+0x33f>
      }
    } else if(state == '%'){
    1381:	83 bd 40 ff ff ff 25 	cmpl   $0x25,-0xc0(%rbp)
    1388:	0f 85 32 02 00 00    	jne    15c0 <printf+0x33f>
      if(c == 'd'){
    138e:	83 bd 3c ff ff ff 64 	cmpl   $0x64,-0xc4(%rbp)
    1395:	75 5e                	jne    13f5 <printf+0x174>
        printint(fd, va_arg(ap, int), 10, 1);
    1397:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    139d:	83 f8 2f             	cmp    $0x2f,%eax
    13a0:	77 23                	ja     13c5 <printf+0x144>
    13a2:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    13a9:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    13af:	89 d2                	mov    %edx,%edx
    13b1:	48 01 d0             	add    %rdx,%rax
    13b4:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    13ba:	83 c2 08             	add    $0x8,%edx
    13bd:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    13c3:	eb 12                	jmp    13d7 <printf+0x156>
    13c5:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    13cc:	48 8d 50 08          	lea    0x8(%rax),%rdx
    13d0:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    13d7:	8b 30                	mov    (%rax),%esi
    13d9:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    13df:	b9 01 00 00 00       	mov    $0x1,%ecx
    13e4:	ba 0a 00 00 00       	mov    $0xa,%edx
    13e9:	89 c7                	mov    %eax,%edi
    13eb:	e8 d0 fd ff ff       	call   11c0 <printint>
    13f0:	e9 c1 01 00 00       	jmp    15b6 <printf+0x335>
      } else if(c == 'x' || c == 'p'){
    13f5:	83 bd 3c ff ff ff 78 	cmpl   $0x78,-0xc4(%rbp)
    13fc:	74 09                	je     1407 <printf+0x186>
    13fe:	83 bd 3c ff ff ff 70 	cmpl   $0x70,-0xc4(%rbp)
    1405:	75 5e                	jne    1465 <printf+0x1e4>
        printint(fd, va_arg(ap, int), 16, 0);
    1407:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    140d:	83 f8 2f             	cmp    $0x2f,%eax
    1410:	77 23                	ja     1435 <printf+0x1b4>
    1412:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    1419:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    141f:	89 d2                	mov    %edx,%edx
    1421:	48 01 d0             	add    %rdx,%rax
    1424:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    142a:	83 c2 08             	add    $0x8,%edx
    142d:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    1433:	eb 12                	jmp    1447 <printf+0x1c6>
    1435:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    143c:	48 8d 50 08          	lea    0x8(%rax),%rdx
    1440:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    1447:	8b 30                	mov    (%rax),%esi
    1449:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    144f:	b9 00 00 00 00       	mov    $0x0,%ecx
    1454:	ba 10 00 00 00       	mov    $0x10,%edx
    1459:	89 c7                	mov    %eax,%edi
    145b:	e8 60 fd ff ff       	call   11c0 <printint>
    1460:	e9 51 01 00 00       	jmp    15b6 <printf+0x335>
      } else if(c == 's'){
    1465:	83 bd 3c ff ff ff 73 	cmpl   $0x73,-0xc4(%rbp)
    146c:	0f 85 98 00 00 00    	jne    150a <printf+0x289>
        s = va_arg(ap, char*);
    1472:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    1478:	83 f8 2f             	cmp    $0x2f,%eax
    147b:	77 23                	ja     14a0 <printf+0x21f>
    147d:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    1484:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    148a:	89 d2                	mov    %edx,%edx
    148c:	48 01 d0             	add    %rdx,%rax
    148f:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1495:	83 c2 08             	add    $0x8,%edx
    1498:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    149e:	eb 12                	jmp    14b2 <printf+0x231>
    14a0:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    14a7:	48 8d 50 08          	lea    0x8(%rax),%rdx
    14ab:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    14b2:	48 8b 00             	mov    (%rax),%rax
    14b5:	48 89 85 48 ff ff ff 	mov    %rax,-0xb8(%rbp)
        if(s == 0)
    14bc:	48 83 bd 48 ff ff ff 	cmpq   $0x0,-0xb8(%rbp)
    14c3:	00 
    14c4:	75 31                	jne    14f7 <printf+0x276>
          s = "(null)";
    14c6:	48 c7 85 48 ff ff ff 	movq   $0x19b0,-0xb8(%rbp)
    14cd:	b0 19 00 00 
        while(*s != 0){
    14d1:	eb 24                	jmp    14f7 <printf+0x276>
          putc(fd, *s);
    14d3:	48 8b 85 48 ff ff ff 	mov    -0xb8(%rbp),%rax
    14da:	0f b6 00             	movzbl (%rax),%eax
    14dd:	0f be d0             	movsbl %al,%edx
    14e0:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    14e6:	89 d6                	mov    %edx,%esi
    14e8:	89 c7                	mov    %eax,%edi
    14ea:	e8 a8 fc ff ff       	call   1197 <putc>
          s++;
    14ef:	48 83 85 48 ff ff ff 	addq   $0x1,-0xb8(%rbp)
    14f6:	01 
        while(*s != 0){
    14f7:	48 8b 85 48 ff ff ff 	mov    -0xb8(%rbp),%rax
    14fe:	0f b6 00             	movzbl (%rax),%eax
    1501:	84 c0                	test   %al,%al
    1503:	75 ce                	jne    14d3 <printf+0x252>
    1505:	e9 ac 00 00 00       	jmp    15b6 <printf+0x335>
        }
      } else if(c == 'c'){
    150a:	83 bd 3c ff ff ff 63 	cmpl   $0x63,-0xc4(%rbp)
    1511:	75 56                	jne    1569 <printf+0x2e8>
        putc(fd, va_arg(ap, uint));
    1513:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    1519:	83 f8 2f             	cmp    $0x2f,%eax
    151c:	77 23                	ja     1541 <printf+0x2c0>
    151e:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    1525:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    152b:	89 d2                	mov    %edx,%edx
    152d:	48 01 d0             	add    %rdx,%rax
    1530:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1536:	83 c2 08             	add    $0x8,%edx
    1539:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    153f:	eb 12                	jmp    1553 <printf+0x2d2>
    1541:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    1548:	48 8d 50 08          	lea    0x8(%rax),%rdx
    154c:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    1553:	8b 00                	mov    (%rax),%eax
    1555:	0f be d0             	movsbl %al,%edx
    1558:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    155e:	89 d6                	mov    %edx,%esi
    1560:	89 c7                	mov    %eax,%edi
    1562:	e8 30 fc ff ff       	call   1197 <putc>
    1567:	eb 4d                	jmp    15b6 <printf+0x335>
      } else if(c == '%'){
    1569:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
    1570:	75 1a                	jne    158c <printf+0x30b>
        putc(fd, c);
    1572:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
    1578:	0f be d0             	movsbl %al,%edx
    157b:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1581:	89 d6                	mov    %edx,%esi
    1583:	89 c7                	mov    %eax,%edi
    1585:	e8 0d fc ff ff       	call   1197 <putc>
    158a:	eb 2a                	jmp    15b6 <printf+0x335>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    158c:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1592:	be 25 00 00 00       	mov    $0x25,%esi
    1597:	89 c7                	mov    %eax,%edi
    1599:	e8 f9 fb ff ff       	call   1197 <putc>
        putc(fd, c);
    159e:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
    15a4:	0f be d0             	movsbl %al,%edx
    15a7:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    15ad:	89 d6                	mov    %edx,%esi
    15af:	89 c7                	mov    %eax,%edi
    15b1:	e8 e1 fb ff ff       	call   1197 <putc>
      }
      state = 0;
    15b6:	c7 85 40 ff ff ff 00 	movl   $0x0,-0xc0(%rbp)
    15bd:	00 00 00 
  for(i = 0; fmt[i]; i++){
    15c0:	83 85 44 ff ff ff 01 	addl   $0x1,-0xbc(%rbp)
    15c7:	8b 85 44 ff ff ff    	mov    -0xbc(%rbp),%eax
    15cd:	48 63 d0             	movslq %eax,%rdx
    15d0:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
    15d7:	48 01 d0             	add    %rdx,%rax
    15da:	0f b6 00             	movzbl (%rax),%eax
    15dd:	84 c0                	test   %al,%al
    15df:	0f 85 3a fd ff ff    	jne    131f <printf+0x9e>
    }
  }
}
    15e5:	90                   	nop
    15e6:	90                   	nop
    15e7:	c9                   	leave
    15e8:	c3                   	ret

00000000000015e9 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    15e9:	55                   	push   %rbp
    15ea:	48 89 e5             	mov    %rsp,%rbp
    15ed:	48 83 ec 18          	sub    $0x18,%rsp
    15f1:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  Header *bp, *p;

  bp = (Header*)ap - 1;
    15f5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    15f9:	48 83 e8 10          	sub    $0x10,%rax
    15fd:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1601:	48 8b 05 d8 08 00 00 	mov    0x8d8(%rip),%rax        # 1ee0 <freep>
    1608:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    160c:	eb 2f                	jmp    163d <free+0x54>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    160e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1612:	48 8b 00             	mov    (%rax),%rax
    1615:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    1619:	72 17                	jb     1632 <free+0x49>
    161b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    161f:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    1623:	72 2f                	jb     1654 <free+0x6b>
    1625:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1629:	48 8b 00             	mov    (%rax),%rax
    162c:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
    1630:	72 22                	jb     1654 <free+0x6b>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1632:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1636:	48 8b 00             	mov    (%rax),%rax
    1639:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    163d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1641:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    1645:	73 c7                	jae    160e <free+0x25>
    1647:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    164b:	48 8b 00             	mov    (%rax),%rax
    164e:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
    1652:	73 ba                	jae    160e <free+0x25>
      break;
  if(bp + bp->s.size == p->s.ptr){
    1654:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1658:	8b 40 08             	mov    0x8(%rax),%eax
    165b:	89 c0                	mov    %eax,%eax
    165d:	48 c1 e0 04          	shl    $0x4,%rax
    1661:	48 89 c2             	mov    %rax,%rdx
    1664:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1668:	48 01 c2             	add    %rax,%rdx
    166b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    166f:	48 8b 00             	mov    (%rax),%rax
    1672:	48 39 c2             	cmp    %rax,%rdx
    1675:	75 2d                	jne    16a4 <free+0xbb>
    bp->s.size += p->s.ptr->s.size;
    1677:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    167b:	8b 50 08             	mov    0x8(%rax),%edx
    167e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1682:	48 8b 00             	mov    (%rax),%rax
    1685:	8b 40 08             	mov    0x8(%rax),%eax
    1688:	01 c2                	add    %eax,%edx
    168a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    168e:	89 50 08             	mov    %edx,0x8(%rax)
    bp->s.ptr = p->s.ptr->s.ptr;
    1691:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1695:	48 8b 00             	mov    (%rax),%rax
    1698:	48 8b 10             	mov    (%rax),%rdx
    169b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    169f:	48 89 10             	mov    %rdx,(%rax)
    16a2:	eb 0e                	jmp    16b2 <free+0xc9>
  } else
    bp->s.ptr = p->s.ptr;
    16a4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    16a8:	48 8b 10             	mov    (%rax),%rdx
    16ab:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    16af:	48 89 10             	mov    %rdx,(%rax)
  if(p + p->s.size == bp){
    16b2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    16b6:	8b 40 08             	mov    0x8(%rax),%eax
    16b9:	89 c0                	mov    %eax,%eax
    16bb:	48 c1 e0 04          	shl    $0x4,%rax
    16bf:	48 89 c2             	mov    %rax,%rdx
    16c2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    16c6:	48 01 d0             	add    %rdx,%rax
    16c9:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
    16cd:	75 27                	jne    16f6 <free+0x10d>
    p->s.size += bp->s.size;
    16cf:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    16d3:	8b 50 08             	mov    0x8(%rax),%edx
    16d6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    16da:	8b 40 08             	mov    0x8(%rax),%eax
    16dd:	01 c2                	add    %eax,%edx
    16df:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    16e3:	89 50 08             	mov    %edx,0x8(%rax)
    p->s.ptr = bp->s.ptr;
    16e6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    16ea:	48 8b 10             	mov    (%rax),%rdx
    16ed:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    16f1:	48 89 10             	mov    %rdx,(%rax)
    16f4:	eb 0b                	jmp    1701 <free+0x118>
  } else
    p->s.ptr = bp;
    16f6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    16fa:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
    16fe:	48 89 10             	mov    %rdx,(%rax)
  freep = p;
    1701:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1705:	48 89 05 d4 07 00 00 	mov    %rax,0x7d4(%rip)        # 1ee0 <freep>
}
    170c:	90                   	nop
    170d:	c9                   	leave
    170e:	c3                   	ret

000000000000170f <morecore>:

static Header*
morecore(uint nu)
{
    170f:	55                   	push   %rbp
    1710:	48 89 e5             	mov    %rsp,%rbp
    1713:	48 83 ec 20          	sub    $0x20,%rsp
    1717:	89 7d ec             	mov    %edi,-0x14(%rbp)
  char *p;
  Header *hp;

  if(nu < 4096)
    171a:	81 7d ec ff 0f 00 00 	cmpl   $0xfff,-0x14(%rbp)
    1721:	77 07                	ja     172a <morecore+0x1b>
    nu = 4096;
    1723:	c7 45 ec 00 10 00 00 	movl   $0x1000,-0x14(%rbp)
  p = sbrk(nu * sizeof(Header));
    172a:	8b 45 ec             	mov    -0x14(%rbp),%eax
    172d:	c1 e0 04             	shl    $0x4,%eax
    1730:	89 c7                	mov    %eax,%edi
    1732:	e8 40 fa ff ff       	call   1177 <sbrk>
    1737:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  if(p == (char*)-1)
    173b:	48 83 7d f8 ff       	cmpq   $0xffffffffffffffff,-0x8(%rbp)
    1740:	75 07                	jne    1749 <morecore+0x3a>
    return 0;
    1742:	b8 00 00 00 00       	mov    $0x0,%eax
    1747:	eb 29                	jmp    1772 <morecore+0x63>
  hp = (Header*)p;
    1749:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    174d:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  hp->s.size = nu;
    1751:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1755:	8b 55 ec             	mov    -0x14(%rbp),%edx
    1758:	89 50 08             	mov    %edx,0x8(%rax)
  free((void*)(hp + 1));
    175b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    175f:	48 83 c0 10          	add    $0x10,%rax
    1763:	48 89 c7             	mov    %rax,%rdi
    1766:	e8 7e fe ff ff       	call   15e9 <free>
  return freep;
    176b:	48 8b 05 6e 07 00 00 	mov    0x76e(%rip),%rax        # 1ee0 <freep>
}
    1772:	c9                   	leave
    1773:	c3                   	ret

0000000000001774 <malloc>:

void*
malloc(uint nbytes)
{
    1774:	55                   	push   %rbp
    1775:	48 89 e5             	mov    %rsp,%rbp
    1778:	48 83 ec 30          	sub    $0x30,%rsp
    177c:	89 7d dc             	mov    %edi,-0x24(%rbp)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    177f:	8b 45 dc             	mov    -0x24(%rbp),%eax
    1782:	48 83 c0 0f          	add    $0xf,%rax
    1786:	48 c1 e8 04          	shr    $0x4,%rax
    178a:	83 c0 01             	add    $0x1,%eax
    178d:	89 45 ec             	mov    %eax,-0x14(%rbp)
  if((prevp = freep) == 0){
    1790:	48 8b 05 49 07 00 00 	mov    0x749(%rip),%rax        # 1ee0 <freep>
    1797:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    179b:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
    17a0:	75 2b                	jne    17cd <malloc+0x59>
    base.s.ptr = freep = prevp = &base;
    17a2:	48 c7 45 f0 d0 1e 00 	movq   $0x1ed0,-0x10(%rbp)
    17a9:	00 
    17aa:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    17ae:	48 89 05 2b 07 00 00 	mov    %rax,0x72b(%rip)        # 1ee0 <freep>
    17b5:	48 8b 05 24 07 00 00 	mov    0x724(%rip),%rax        # 1ee0 <freep>
    17bc:	48 89 05 0d 07 00 00 	mov    %rax,0x70d(%rip)        # 1ed0 <base>
    base.s.size = 0;
    17c3:	c7 05 0b 07 00 00 00 	movl   $0x0,0x70b(%rip)        # 1ed8 <base+0x8>
    17ca:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    17cd:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    17d1:	48 8b 00             	mov    (%rax),%rax
    17d4:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
    17d8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    17dc:	8b 40 08             	mov    0x8(%rax),%eax
    17df:	3b 45 ec             	cmp    -0x14(%rbp),%eax
    17e2:	72 5f                	jb     1843 <malloc+0xcf>
      if(p->s.size == nunits)
    17e4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    17e8:	8b 40 08             	mov    0x8(%rax),%eax
    17eb:	39 45 ec             	cmp    %eax,-0x14(%rbp)
    17ee:	75 10                	jne    1800 <malloc+0x8c>
        prevp->s.ptr = p->s.ptr;
    17f0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    17f4:	48 8b 10             	mov    (%rax),%rdx
    17f7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    17fb:	48 89 10             	mov    %rdx,(%rax)
    17fe:	eb 2e                	jmp    182e <malloc+0xba>
      else {
        p->s.size -= nunits;
    1800:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1804:	8b 40 08             	mov    0x8(%rax),%eax
    1807:	2b 45 ec             	sub    -0x14(%rbp),%eax
    180a:	89 c2                	mov    %eax,%edx
    180c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1810:	89 50 08             	mov    %edx,0x8(%rax)
        p += p->s.size;
    1813:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1817:	8b 40 08             	mov    0x8(%rax),%eax
    181a:	89 c0                	mov    %eax,%eax
    181c:	48 c1 e0 04          	shl    $0x4,%rax
    1820:	48 01 45 f8          	add    %rax,-0x8(%rbp)
        p->s.size = nunits;
    1824:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1828:	8b 55 ec             	mov    -0x14(%rbp),%edx
    182b:	89 50 08             	mov    %edx,0x8(%rax)
      }
      freep = prevp;
    182e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1832:	48 89 05 a7 06 00 00 	mov    %rax,0x6a7(%rip)        # 1ee0 <freep>
      return (void*)(p + 1);
    1839:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    183d:	48 83 c0 10          	add    $0x10,%rax
    1841:	eb 41                	jmp    1884 <malloc+0x110>
    }
    if(p == freep)
    1843:	48 8b 05 96 06 00 00 	mov    0x696(%rip),%rax        # 1ee0 <freep>
    184a:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    184e:	75 1c                	jne    186c <malloc+0xf8>
      if((p = morecore(nunits)) == 0)
    1850:	8b 45 ec             	mov    -0x14(%rbp),%eax
    1853:	89 c7                	mov    %eax,%edi
    1855:	e8 b5 fe ff ff       	call   170f <morecore>
    185a:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    185e:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
    1863:	75 07                	jne    186c <malloc+0xf8>
        return 0;
    1865:	b8 00 00 00 00       	mov    $0x0,%eax
    186a:	eb 18                	jmp    1884 <malloc+0x110>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    186c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1870:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    1874:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1878:	48 8b 00             	mov    (%rax),%rax
    187b:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
    187f:	e9 54 ff ff ff       	jmp    17d8 <malloc+0x64>
  }
}
    1884:	c9                   	leave
    1885:	c3                   	ret
