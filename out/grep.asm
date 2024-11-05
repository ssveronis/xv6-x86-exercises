
fs/grep:     file format elf64-x86-64


Disassembly of section .text:

0000000000000000 <grep>:
char buf[1024];
int match(char*, char*);

void
grep(char *pattern, int fd)
{
       0:	55                   	push   %rbp
       1:	48 89 e5             	mov    %rsp,%rbp
       4:	48 83 ec 30          	sub    $0x30,%rsp
       8:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
       c:	89 75 d4             	mov    %esi,-0x2c(%rbp)
  int n, m;
  char *p, *q;
  
  m = 0;
       f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  while((n = read(fd, buf+m, sizeof(buf)-m)) > 0){
      16:	e9 bc 00 00 00       	jmp    d7 <grep+0xd7>
    m += n;
      1b:	8b 45 ec             	mov    -0x14(%rbp),%eax
      1e:	01 45 fc             	add    %eax,-0x4(%rbp)
    p = buf;
      21:	48 c7 45 f0 00 14 00 	movq   $0x1400,-0x10(%rbp)
      28:	00 
    while((q = strchr(p, '\n')) != 0){
      29:	eb 50                	jmp    7b <grep+0x7b>
      *q = 0;
      2b:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
      2f:	c6 00 00             	movb   $0x0,(%rax)
      if(match(pattern, p)){
      32:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
      36:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
      3a:	48 89 d6             	mov    %rdx,%rsi
      3d:	48 89 c7             	mov    %rax,%rdi
      40:	e8 bc 01 00 00       	call   201 <match>
      45:	85 c0                	test   %eax,%eax
      47:	74 26                	je     6f <grep+0x6f>
        *q = '\n';
      49:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
      4d:	c6 00 0a             	movb   $0xa,(%rax)
        write(1, p, q+1 - p);
      50:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
      54:	48 83 c0 01          	add    $0x1,%rax
      58:	48 2b 45 f0          	sub    -0x10(%rbp),%rax
      5c:	89 c2                	mov    %eax,%edx
      5e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
      62:	48 89 c6             	mov    %rax,%rsi
      65:	bf 01 00 00 00       	mov    $0x1,%edi
      6a:	e8 3e 06 00 00       	call   6ad <write>
      }
      p = q+1;
      6f:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
      73:	48 83 c0 01          	add    $0x1,%rax
      77:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    while((q = strchr(p, '\n')) != 0){
      7b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
      7f:	be 0a 00 00 00       	mov    $0xa,%esi
      84:	48 89 c7             	mov    %rax,%rdi
      87:	e8 38 04 00 00       	call   4c4 <strchr>
      8c:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
      90:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
      95:	75 94                	jne    2b <grep+0x2b>
    }
    if(p == buf)
      97:	48 81 7d f0 00 14 00 	cmpq   $0x1400,-0x10(%rbp)
      9e:	00 
      9f:	75 07                	jne    a8 <grep+0xa8>
      m = 0;
      a1:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    if(m > 0){
      a8:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
      ac:	7e 29                	jle    d7 <grep+0xd7>
      m -= p - buf;
      ae:	8b 45 fc             	mov    -0x4(%rbp),%eax
      b1:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
      b5:	48 81 ea 00 14 00 00 	sub    $0x1400,%rdx
      bc:	29 d0                	sub    %edx,%eax
      be:	89 45 fc             	mov    %eax,-0x4(%rbp)
      memmove(buf, p, m);
      c1:	8b 55 fc             	mov    -0x4(%rbp),%edx
      c4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
      c8:	48 89 c6             	mov    %rax,%rsi
      cb:	48 c7 c7 00 14 00 00 	mov    $0x1400,%rdi
      d2:	e8 59 05 00 00       	call   630 <memmove>
  while((n = read(fd, buf+m, sizeof(buf)-m)) > 0){
      d7:	8b 45 fc             	mov    -0x4(%rbp),%eax
      da:	ba 00 04 00 00       	mov    $0x400,%edx
      df:	29 c2                	sub    %eax,%edx
      e1:	8b 45 fc             	mov    -0x4(%rbp),%eax
      e4:	48 98                	cltq
      e6:	48 8d 88 00 14 00 00 	lea    0x1400(%rax),%rcx
      ed:	8b 45 d4             	mov    -0x2c(%rbp),%eax
      f0:	48 89 ce             	mov    %rcx,%rsi
      f3:	89 c7                	mov    %eax,%edi
      f5:	e8 ab 05 00 00       	call   6a5 <read>
      fa:	89 45 ec             	mov    %eax,-0x14(%rbp)
      fd:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
     101:	0f 8f 14 ff ff ff    	jg     1b <grep+0x1b>
    }
  }
}
     107:	90                   	nop
     108:	90                   	nop
     109:	c9                   	leave
     10a:	c3                   	ret

000000000000010b <main>:

int
main(int argc, char *argv[])
{
     10b:	55                   	push   %rbp
     10c:	48 89 e5             	mov    %rsp,%rbp
     10f:	48 83 ec 30          	sub    $0x30,%rsp
     113:	89 7d dc             	mov    %edi,-0x24(%rbp)
     116:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  int fd, i;
  char *pattern;
  
  if(argc <= 1){
     11a:	83 7d dc 01          	cmpl   $0x1,-0x24(%rbp)
     11e:	7f 1b                	jg     13b <main+0x30>
    printf(2, "usage: grep pattern [file ...]\n");
     120:	48 c7 c6 38 10 00 00 	mov    $0x1038,%rsi
     127:	bf 02 00 00 00       	mov    $0x2,%edi
     12c:	b8 00 00 00 00       	mov    $0x0,%eax
     131:	e8 09 07 00 00       	call   83f <printf>
    exit();
     136:	e8 52 05 00 00       	call   68d <exit>
  }
  pattern = argv[1];
     13b:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
     13f:	48 8b 40 08          	mov    0x8(%rax),%rax
     143:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  
  if(argc <= 2){
     147:	83 7d dc 02          	cmpl   $0x2,-0x24(%rbp)
     14b:	7f 16                	jg     163 <main+0x58>
    grep(pattern, 0);
     14d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
     151:	be 00 00 00 00       	mov    $0x0,%esi
     156:	48 89 c7             	mov    %rax,%rdi
     159:	e8 a2 fe ff ff       	call   0 <grep>
    exit();
     15e:	e8 2a 05 00 00       	call   68d <exit>
  }

  for(i = 2; i < argc; i++){
     163:	c7 45 fc 02 00 00 00 	movl   $0x2,-0x4(%rbp)
     16a:	e9 81 00 00 00       	jmp    1f0 <main+0xe5>
    if((fd = open(argv[i], 0)) < 0){
     16f:	8b 45 fc             	mov    -0x4(%rbp),%eax
     172:	48 98                	cltq
     174:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
     17b:	00 
     17c:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
     180:	48 01 d0             	add    %rdx,%rax
     183:	48 8b 00             	mov    (%rax),%rax
     186:	be 00 00 00 00       	mov    $0x0,%esi
     18b:	48 89 c7             	mov    %rax,%rdi
     18e:	e8 3a 05 00 00       	call   6cd <open>
     193:	89 45 ec             	mov    %eax,-0x14(%rbp)
     196:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
     19a:	79 35                	jns    1d1 <main+0xc6>
      printf(1, "grep: cannot open %s\n", argv[i]);
     19c:	8b 45 fc             	mov    -0x4(%rbp),%eax
     19f:	48 98                	cltq
     1a1:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
     1a8:	00 
     1a9:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
     1ad:	48 01 d0             	add    %rdx,%rax
     1b0:	48 8b 00             	mov    (%rax),%rax
     1b3:	48 89 c2             	mov    %rax,%rdx
     1b6:	48 c7 c6 58 10 00 00 	mov    $0x1058,%rsi
     1bd:	bf 01 00 00 00       	mov    $0x1,%edi
     1c2:	b8 00 00 00 00       	mov    $0x0,%eax
     1c7:	e8 73 06 00 00       	call   83f <printf>
      exit();
     1cc:	e8 bc 04 00 00       	call   68d <exit>
    }
    grep(pattern, fd);
     1d1:	8b 55 ec             	mov    -0x14(%rbp),%edx
     1d4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
     1d8:	89 d6                	mov    %edx,%esi
     1da:	48 89 c7             	mov    %rax,%rdi
     1dd:	e8 1e fe ff ff       	call   0 <grep>
    close(fd);
     1e2:	8b 45 ec             	mov    -0x14(%rbp),%eax
     1e5:	89 c7                	mov    %eax,%edi
     1e7:	e8 c9 04 00 00       	call   6b5 <close>
  for(i = 2; i < argc; i++){
     1ec:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
     1f0:	8b 45 fc             	mov    -0x4(%rbp),%eax
     1f3:	3b 45 dc             	cmp    -0x24(%rbp),%eax
     1f6:	0f 8c 73 ff ff ff    	jl     16f <main+0x64>
  }
  exit();
     1fc:	e8 8c 04 00 00       	call   68d <exit>

0000000000000201 <match>:
int matchhere(char*, char*);
int matchstar(int, char*, char*);

int
match(char *re, char *text)
{
     201:	55                   	push   %rbp
     202:	48 89 e5             	mov    %rsp,%rbp
     205:	48 83 ec 10          	sub    $0x10,%rsp
     209:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
     20d:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  if(re[0] == '^')
     211:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     215:	0f b6 00             	movzbl (%rax),%eax
     218:	3c 5e                	cmp    $0x5e,%al
     21a:	75 19                	jne    235 <match+0x34>
    return matchhere(re+1, text);
     21c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     220:	48 8d 50 01          	lea    0x1(%rax),%rdx
     224:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
     228:	48 89 c6             	mov    %rax,%rsi
     22b:	48 89 d7             	mov    %rdx,%rdi
     22e:	e8 3a 00 00 00       	call   26d <matchhere>
     233:	eb 36                	jmp    26b <match+0x6a>
  do{  // must look at empty string
    if(matchhere(re, text))
     235:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
     239:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     23d:	48 89 d6             	mov    %rdx,%rsi
     240:	48 89 c7             	mov    %rax,%rdi
     243:	e8 25 00 00 00       	call   26d <matchhere>
     248:	85 c0                	test   %eax,%eax
     24a:	74 07                	je     253 <match+0x52>
      return 1;
     24c:	b8 01 00 00 00       	mov    $0x1,%eax
     251:	eb 18                	jmp    26b <match+0x6a>
  }while(*text++ != '\0');
     253:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
     257:	48 8d 50 01          	lea    0x1(%rax),%rdx
     25b:	48 89 55 f0          	mov    %rdx,-0x10(%rbp)
     25f:	0f b6 00             	movzbl (%rax),%eax
     262:	84 c0                	test   %al,%al
     264:	75 cf                	jne    235 <match+0x34>
  return 0;
     266:	b8 00 00 00 00       	mov    $0x0,%eax
}
     26b:	c9                   	leave
     26c:	c3                   	ret

000000000000026d <matchhere>:

// matchhere: search for re at beginning of text
int matchhere(char *re, char *text)
{
     26d:	55                   	push   %rbp
     26e:	48 89 e5             	mov    %rsp,%rbp
     271:	48 83 ec 10          	sub    $0x10,%rsp
     275:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
     279:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  if(re[0] == '\0')
     27d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     281:	0f b6 00             	movzbl (%rax),%eax
     284:	84 c0                	test   %al,%al
     286:	75 0a                	jne    292 <matchhere+0x25>
    return 1;
     288:	b8 01 00 00 00       	mov    $0x1,%eax
     28d:	e9 a6 00 00 00       	jmp    338 <matchhere+0xcb>
  if(re[1] == '*')
     292:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     296:	48 83 c0 01          	add    $0x1,%rax
     29a:	0f b6 00             	movzbl (%rax),%eax
     29d:	3c 2a                	cmp    $0x2a,%al
     29f:	75 22                	jne    2c3 <matchhere+0x56>
    return matchstar(re[0], re+2, text);
     2a1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     2a5:	48 8d 48 02          	lea    0x2(%rax),%rcx
     2a9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     2ad:	0f b6 00             	movzbl (%rax),%eax
     2b0:	0f be c0             	movsbl %al,%eax
     2b3:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
     2b7:	48 89 ce             	mov    %rcx,%rsi
     2ba:	89 c7                	mov    %eax,%edi
     2bc:	e8 79 00 00 00       	call   33a <matchstar>
     2c1:	eb 75                	jmp    338 <matchhere+0xcb>
  if(re[0] == '$' && re[1] == '\0')
     2c3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     2c7:	0f b6 00             	movzbl (%rax),%eax
     2ca:	3c 24                	cmp    $0x24,%al
     2cc:	75 20                	jne    2ee <matchhere+0x81>
     2ce:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     2d2:	48 83 c0 01          	add    $0x1,%rax
     2d6:	0f b6 00             	movzbl (%rax),%eax
     2d9:	84 c0                	test   %al,%al
     2db:	75 11                	jne    2ee <matchhere+0x81>
    return *text == '\0';
     2dd:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
     2e1:	0f b6 00             	movzbl (%rax),%eax
     2e4:	84 c0                	test   %al,%al
     2e6:	0f 94 c0             	sete   %al
     2e9:	0f b6 c0             	movzbl %al,%eax
     2ec:	eb 4a                	jmp    338 <matchhere+0xcb>
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
     2ee:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
     2f2:	0f b6 00             	movzbl (%rax),%eax
     2f5:	84 c0                	test   %al,%al
     2f7:	74 3a                	je     333 <matchhere+0xc6>
     2f9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     2fd:	0f b6 00             	movzbl (%rax),%eax
     300:	3c 2e                	cmp    $0x2e,%al
     302:	74 12                	je     316 <matchhere+0xa9>
     304:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     308:	0f b6 10             	movzbl (%rax),%edx
     30b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
     30f:	0f b6 00             	movzbl (%rax),%eax
     312:	38 c2                	cmp    %al,%dl
     314:	75 1d                	jne    333 <matchhere+0xc6>
    return matchhere(re+1, text+1);
     316:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
     31a:	48 8d 50 01          	lea    0x1(%rax),%rdx
     31e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     322:	48 83 c0 01          	add    $0x1,%rax
     326:	48 89 d6             	mov    %rdx,%rsi
     329:	48 89 c7             	mov    %rax,%rdi
     32c:	e8 3c ff ff ff       	call   26d <matchhere>
     331:	eb 05                	jmp    338 <matchhere+0xcb>
  return 0;
     333:	b8 00 00 00 00       	mov    $0x0,%eax
}
     338:	c9                   	leave
     339:	c3                   	ret

000000000000033a <matchstar>:

// matchstar: search for c*re at beginning of text
int matchstar(int c, char *re, char *text)
{
     33a:	55                   	push   %rbp
     33b:	48 89 e5             	mov    %rsp,%rbp
     33e:	48 83 ec 20          	sub    $0x20,%rsp
     342:	89 7d fc             	mov    %edi,-0x4(%rbp)
     345:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
     349:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  do{  // a * matches zero or more instances
    if(matchhere(re, text))
     34d:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
     351:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
     355:	48 89 d6             	mov    %rdx,%rsi
     358:	48 89 c7             	mov    %rax,%rdi
     35b:	e8 0d ff ff ff       	call   26d <matchhere>
     360:	85 c0                	test   %eax,%eax
     362:	74 07                	je     36b <matchstar+0x31>
      return 1;
     364:	b8 01 00 00 00       	mov    $0x1,%eax
     369:	eb 2d                	jmp    398 <matchstar+0x5e>
  }while(*text!='\0' && (*text++==c || c=='.'));
     36b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
     36f:	0f b6 00             	movzbl (%rax),%eax
     372:	84 c0                	test   %al,%al
     374:	74 1d                	je     393 <matchstar+0x59>
     376:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
     37a:	48 8d 50 01          	lea    0x1(%rax),%rdx
     37e:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
     382:	0f b6 00             	movzbl (%rax),%eax
     385:	0f be c0             	movsbl %al,%eax
     388:	39 45 fc             	cmp    %eax,-0x4(%rbp)
     38b:	74 c0                	je     34d <matchstar+0x13>
     38d:	83 7d fc 2e          	cmpl   $0x2e,-0x4(%rbp)
     391:	74 ba                	je     34d <matchstar+0x13>
  return 0;
     393:	b8 00 00 00 00       	mov    $0x0,%eax
}
     398:	c9                   	leave
     399:	c3                   	ret

000000000000039a <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
     39a:	55                   	push   %rbp
     39b:	48 89 e5             	mov    %rsp,%rbp
     39e:	48 83 ec 10          	sub    $0x10,%rsp
     3a2:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
     3a6:	89 75 f4             	mov    %esi,-0xc(%rbp)
     3a9:	89 55 f0             	mov    %edx,-0x10(%rbp)
  asm volatile("cld; rep stosb" :
     3ac:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
     3b0:	8b 55 f0             	mov    -0x10(%rbp),%edx
     3b3:	8b 45 f4             	mov    -0xc(%rbp),%eax
     3b6:	48 89 ce             	mov    %rcx,%rsi
     3b9:	48 89 f7             	mov    %rsi,%rdi
     3bc:	89 d1                	mov    %edx,%ecx
     3be:	fc                   	cld
     3bf:	f3 aa                	rep stos %al,%es:(%rdi)
     3c1:	89 ca                	mov    %ecx,%edx
     3c3:	48 89 fe             	mov    %rdi,%rsi
     3c6:	48 89 75 f8          	mov    %rsi,-0x8(%rbp)
     3ca:	89 55 f0             	mov    %edx,-0x10(%rbp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
     3cd:	90                   	nop
     3ce:	c9                   	leave
     3cf:	c3                   	ret

00000000000003d0 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
     3d0:	55                   	push   %rbp
     3d1:	48 89 e5             	mov    %rsp,%rbp
     3d4:	48 83 ec 20          	sub    $0x20,%rsp
     3d8:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
     3dc:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  char *os;

  os = s;
     3e0:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
     3e4:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  while((*s++ = *t++) != 0)
     3e8:	90                   	nop
     3e9:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
     3ed:	48 8d 42 01          	lea    0x1(%rdx),%rax
     3f1:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
     3f5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
     3f9:	48 8d 48 01          	lea    0x1(%rax),%rcx
     3fd:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
     401:	0f b6 12             	movzbl (%rdx),%edx
     404:	88 10                	mov    %dl,(%rax)
     406:	0f b6 00             	movzbl (%rax),%eax
     409:	84 c0                	test   %al,%al
     40b:	75 dc                	jne    3e9 <strcpy+0x19>
    ;
  return os;
     40d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
     411:	c9                   	leave
     412:	c3                   	ret

0000000000000413 <strcmp>:

int
strcmp(const char *p, const char *q)
{
     413:	55                   	push   %rbp
     414:	48 89 e5             	mov    %rsp,%rbp
     417:	48 83 ec 10          	sub    $0x10,%rsp
     41b:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
     41f:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  while(*p && *p == *q)
     423:	eb 0a                	jmp    42f <strcmp+0x1c>
    p++, q++;
     425:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
     42a:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  while(*p && *p == *q)
     42f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     433:	0f b6 00             	movzbl (%rax),%eax
     436:	84 c0                	test   %al,%al
     438:	74 12                	je     44c <strcmp+0x39>
     43a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     43e:	0f b6 10             	movzbl (%rax),%edx
     441:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
     445:	0f b6 00             	movzbl (%rax),%eax
     448:	38 c2                	cmp    %al,%dl
     44a:	74 d9                	je     425 <strcmp+0x12>
  return (uchar)*p - (uchar)*q;
     44c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     450:	0f b6 00             	movzbl (%rax),%eax
     453:	0f b6 d0             	movzbl %al,%edx
     456:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
     45a:	0f b6 00             	movzbl (%rax),%eax
     45d:	0f b6 c0             	movzbl %al,%eax
     460:	29 c2                	sub    %eax,%edx
     462:	89 d0                	mov    %edx,%eax
}
     464:	c9                   	leave
     465:	c3                   	ret

0000000000000466 <strlen>:

uint
strlen(char *s)
{
     466:	55                   	push   %rbp
     467:	48 89 e5             	mov    %rsp,%rbp
     46a:	48 83 ec 18          	sub    $0x18,%rsp
     46e:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  int n;

  for(n = 0; s[n]; n++)
     472:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
     479:	eb 04                	jmp    47f <strlen+0x19>
     47b:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
     47f:	8b 45 fc             	mov    -0x4(%rbp),%eax
     482:	48 63 d0             	movslq %eax,%rdx
     485:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
     489:	48 01 d0             	add    %rdx,%rax
     48c:	0f b6 00             	movzbl (%rax),%eax
     48f:	84 c0                	test   %al,%al
     491:	75 e8                	jne    47b <strlen+0x15>
    ;
  return n;
     493:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
     496:	c9                   	leave
     497:	c3                   	ret

0000000000000498 <memset>:

void*
memset(void *dst, int c, uint n)
{
     498:	55                   	push   %rbp
     499:	48 89 e5             	mov    %rsp,%rbp
     49c:	48 83 ec 10          	sub    $0x10,%rsp
     4a0:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
     4a4:	89 75 f4             	mov    %esi,-0xc(%rbp)
     4a7:	89 55 f0             	mov    %edx,-0x10(%rbp)
  stosb(dst, c, n);
     4aa:	8b 55 f0             	mov    -0x10(%rbp),%edx
     4ad:	8b 4d f4             	mov    -0xc(%rbp),%ecx
     4b0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     4b4:	89 ce                	mov    %ecx,%esi
     4b6:	48 89 c7             	mov    %rax,%rdi
     4b9:	e8 dc fe ff ff       	call   39a <stosb>
  return dst;
     4be:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
     4c2:	c9                   	leave
     4c3:	c3                   	ret

00000000000004c4 <strchr>:

char*
strchr(const char *s, char c)
{
     4c4:	55                   	push   %rbp
     4c5:	48 89 e5             	mov    %rsp,%rbp
     4c8:	48 83 ec 10          	sub    $0x10,%rsp
     4cc:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
     4d0:	89 f0                	mov    %esi,%eax
     4d2:	88 45 f4             	mov    %al,-0xc(%rbp)
  for(; *s; s++)
     4d5:	eb 17                	jmp    4ee <strchr+0x2a>
    if(*s == c)
     4d7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     4db:	0f b6 00             	movzbl (%rax),%eax
     4de:	38 45 f4             	cmp    %al,-0xc(%rbp)
     4e1:	75 06                	jne    4e9 <strchr+0x25>
      return (char*)s;
     4e3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     4e7:	eb 15                	jmp    4fe <strchr+0x3a>
  for(; *s; s++)
     4e9:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
     4ee:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     4f2:	0f b6 00             	movzbl (%rax),%eax
     4f5:	84 c0                	test   %al,%al
     4f7:	75 de                	jne    4d7 <strchr+0x13>
  return 0;
     4f9:	b8 00 00 00 00       	mov    $0x0,%eax
}
     4fe:	c9                   	leave
     4ff:	c3                   	ret

0000000000000500 <gets>:

char*
gets(char *buf, int max)
{
     500:	55                   	push   %rbp
     501:	48 89 e5             	mov    %rsp,%rbp
     504:	48 83 ec 20          	sub    $0x20,%rsp
     508:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
     50c:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     50f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
     516:	eb 48                	jmp    560 <gets+0x60>
    cc = read(0, &c, 1);
     518:	48 8d 45 f7          	lea    -0x9(%rbp),%rax
     51c:	ba 01 00 00 00       	mov    $0x1,%edx
     521:	48 89 c6             	mov    %rax,%rsi
     524:	bf 00 00 00 00       	mov    $0x0,%edi
     529:	e8 77 01 00 00       	call   6a5 <read>
     52e:	89 45 f8             	mov    %eax,-0x8(%rbp)
    if(cc < 1)
     531:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
     535:	7e 36                	jle    56d <gets+0x6d>
      break;
    buf[i++] = c;
     537:	8b 45 fc             	mov    -0x4(%rbp),%eax
     53a:	8d 50 01             	lea    0x1(%rax),%edx
     53d:	89 55 fc             	mov    %edx,-0x4(%rbp)
     540:	48 63 d0             	movslq %eax,%rdx
     543:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
     547:	48 01 c2             	add    %rax,%rdx
     54a:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
     54e:	88 02                	mov    %al,(%rdx)
    if(c == '\n' || c == '\r')
     550:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
     554:	3c 0a                	cmp    $0xa,%al
     556:	74 16                	je     56e <gets+0x6e>
     558:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
     55c:	3c 0d                	cmp    $0xd,%al
     55e:	74 0e                	je     56e <gets+0x6e>
  for(i=0; i+1 < max; ){
     560:	8b 45 fc             	mov    -0x4(%rbp),%eax
     563:	83 c0 01             	add    $0x1,%eax
     566:	39 45 e4             	cmp    %eax,-0x1c(%rbp)
     569:	7f ad                	jg     518 <gets+0x18>
     56b:	eb 01                	jmp    56e <gets+0x6e>
      break;
     56d:	90                   	nop
      break;
  }
  buf[i] = '\0';
     56e:	8b 45 fc             	mov    -0x4(%rbp),%eax
     571:	48 63 d0             	movslq %eax,%rdx
     574:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
     578:	48 01 d0             	add    %rdx,%rax
     57b:	c6 00 00             	movb   $0x0,(%rax)
  return buf;
     57e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
     582:	c9                   	leave
     583:	c3                   	ret

0000000000000584 <stat>:

int
stat(char *n, struct stat *st)
{
     584:	55                   	push   %rbp
     585:	48 89 e5             	mov    %rsp,%rbp
     588:	48 83 ec 20          	sub    $0x20,%rsp
     58c:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
     590:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     594:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
     598:	be 00 00 00 00       	mov    $0x0,%esi
     59d:	48 89 c7             	mov    %rax,%rdi
     5a0:	e8 28 01 00 00       	call   6cd <open>
     5a5:	89 45 fc             	mov    %eax,-0x4(%rbp)
  if(fd < 0)
     5a8:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
     5ac:	79 07                	jns    5b5 <stat+0x31>
    return -1;
     5ae:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     5b3:	eb 21                	jmp    5d6 <stat+0x52>
  r = fstat(fd, st);
     5b5:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
     5b9:	8b 45 fc             	mov    -0x4(%rbp),%eax
     5bc:	48 89 d6             	mov    %rdx,%rsi
     5bf:	89 c7                	mov    %eax,%edi
     5c1:	e8 1f 01 00 00       	call   6e5 <fstat>
     5c6:	89 45 f8             	mov    %eax,-0x8(%rbp)
  close(fd);
     5c9:	8b 45 fc             	mov    -0x4(%rbp),%eax
     5cc:	89 c7                	mov    %eax,%edi
     5ce:	e8 e2 00 00 00       	call   6b5 <close>
  return r;
     5d3:	8b 45 f8             	mov    -0x8(%rbp),%eax
}
     5d6:	c9                   	leave
     5d7:	c3                   	ret

00000000000005d8 <atoi>:

int
atoi(const char *s)
{
     5d8:	55                   	push   %rbp
     5d9:	48 89 e5             	mov    %rsp,%rbp
     5dc:	48 83 ec 18          	sub    $0x18,%rsp
     5e0:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  int n;

  n = 0;
     5e4:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  while('0' <= *s && *s <= '9')
     5eb:	eb 28                	jmp    615 <atoi+0x3d>
    n = n*10 + *s++ - '0';
     5ed:	8b 55 fc             	mov    -0x4(%rbp),%edx
     5f0:	89 d0                	mov    %edx,%eax
     5f2:	c1 e0 02             	shl    $0x2,%eax
     5f5:	01 d0                	add    %edx,%eax
     5f7:	01 c0                	add    %eax,%eax
     5f9:	89 c1                	mov    %eax,%ecx
     5fb:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
     5ff:	48 8d 50 01          	lea    0x1(%rax),%rdx
     603:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
     607:	0f b6 00             	movzbl (%rax),%eax
     60a:	0f be c0             	movsbl %al,%eax
     60d:	01 c8                	add    %ecx,%eax
     60f:	83 e8 30             	sub    $0x30,%eax
     612:	89 45 fc             	mov    %eax,-0x4(%rbp)
  while('0' <= *s && *s <= '9')
     615:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
     619:	0f b6 00             	movzbl (%rax),%eax
     61c:	3c 2f                	cmp    $0x2f,%al
     61e:	7e 0b                	jle    62b <atoi+0x53>
     620:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
     624:	0f b6 00             	movzbl (%rax),%eax
     627:	3c 39                	cmp    $0x39,%al
     629:	7e c2                	jle    5ed <atoi+0x15>
  return n;
     62b:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
     62e:	c9                   	leave
     62f:	c3                   	ret

0000000000000630 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
     630:	55                   	push   %rbp
     631:	48 89 e5             	mov    %rsp,%rbp
     634:	48 83 ec 28          	sub    $0x28,%rsp
     638:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
     63c:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
     640:	89 55 dc             	mov    %edx,-0x24(%rbp)
  char *dst, *src;
  
  dst = vdst;
     643:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
     647:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  src = vsrc;
     64b:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
     64f:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  while(n-- > 0)
     653:	eb 1d                	jmp    672 <memmove+0x42>
    *dst++ = *src++;
     655:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
     659:	48 8d 42 01          	lea    0x1(%rdx),%rax
     65d:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
     661:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     665:	48 8d 48 01          	lea    0x1(%rax),%rcx
     669:	48 89 4d f8          	mov    %rcx,-0x8(%rbp)
     66d:	0f b6 12             	movzbl (%rdx),%edx
     670:	88 10                	mov    %dl,(%rax)
  while(n-- > 0)
     672:	8b 45 dc             	mov    -0x24(%rbp),%eax
     675:	8d 50 ff             	lea    -0x1(%rax),%edx
     678:	89 55 dc             	mov    %edx,-0x24(%rbp)
     67b:	85 c0                	test   %eax,%eax
     67d:	7f d6                	jg     655 <memmove+0x25>
  return vdst;
     67f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
     683:	c9                   	leave
     684:	c3                   	ret

0000000000000685 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
     685:	b8 01 00 00 00       	mov    $0x1,%eax
     68a:	cd 40                	int    $0x40
     68c:	c3                   	ret

000000000000068d <exit>:
SYSCALL(exit)
     68d:	b8 02 00 00 00       	mov    $0x2,%eax
     692:	cd 40                	int    $0x40
     694:	c3                   	ret

0000000000000695 <wait>:
SYSCALL(wait)
     695:	b8 03 00 00 00       	mov    $0x3,%eax
     69a:	cd 40                	int    $0x40
     69c:	c3                   	ret

000000000000069d <pipe>:
SYSCALL(pipe)
     69d:	b8 04 00 00 00       	mov    $0x4,%eax
     6a2:	cd 40                	int    $0x40
     6a4:	c3                   	ret

00000000000006a5 <read>:
SYSCALL(read)
     6a5:	b8 05 00 00 00       	mov    $0x5,%eax
     6aa:	cd 40                	int    $0x40
     6ac:	c3                   	ret

00000000000006ad <write>:
SYSCALL(write)
     6ad:	b8 10 00 00 00       	mov    $0x10,%eax
     6b2:	cd 40                	int    $0x40
     6b4:	c3                   	ret

00000000000006b5 <close>:
SYSCALL(close)
     6b5:	b8 15 00 00 00       	mov    $0x15,%eax
     6ba:	cd 40                	int    $0x40
     6bc:	c3                   	ret

00000000000006bd <kill>:
SYSCALL(kill)
     6bd:	b8 06 00 00 00       	mov    $0x6,%eax
     6c2:	cd 40                	int    $0x40
     6c4:	c3                   	ret

00000000000006c5 <exec>:
SYSCALL(exec)
     6c5:	b8 07 00 00 00       	mov    $0x7,%eax
     6ca:	cd 40                	int    $0x40
     6cc:	c3                   	ret

00000000000006cd <open>:
SYSCALL(open)
     6cd:	b8 0f 00 00 00       	mov    $0xf,%eax
     6d2:	cd 40                	int    $0x40
     6d4:	c3                   	ret

00000000000006d5 <mknod>:
SYSCALL(mknod)
     6d5:	b8 11 00 00 00       	mov    $0x11,%eax
     6da:	cd 40                	int    $0x40
     6dc:	c3                   	ret

00000000000006dd <unlink>:
SYSCALL(unlink)
     6dd:	b8 12 00 00 00       	mov    $0x12,%eax
     6e2:	cd 40                	int    $0x40
     6e4:	c3                   	ret

00000000000006e5 <fstat>:
SYSCALL(fstat)
     6e5:	b8 08 00 00 00       	mov    $0x8,%eax
     6ea:	cd 40                	int    $0x40
     6ec:	c3                   	ret

00000000000006ed <link>:
SYSCALL(link)
     6ed:	b8 13 00 00 00       	mov    $0x13,%eax
     6f2:	cd 40                	int    $0x40
     6f4:	c3                   	ret

00000000000006f5 <mkdir>:
SYSCALL(mkdir)
     6f5:	b8 14 00 00 00       	mov    $0x14,%eax
     6fa:	cd 40                	int    $0x40
     6fc:	c3                   	ret

00000000000006fd <chdir>:
SYSCALL(chdir)
     6fd:	b8 09 00 00 00       	mov    $0x9,%eax
     702:	cd 40                	int    $0x40
     704:	c3                   	ret

0000000000000705 <dup>:
SYSCALL(dup)
     705:	b8 0a 00 00 00       	mov    $0xa,%eax
     70a:	cd 40                	int    $0x40
     70c:	c3                   	ret

000000000000070d <getpid>:
SYSCALL(getpid)
     70d:	b8 0b 00 00 00       	mov    $0xb,%eax
     712:	cd 40                	int    $0x40
     714:	c3                   	ret

0000000000000715 <sbrk>:
SYSCALL(sbrk)
     715:	b8 0c 00 00 00       	mov    $0xc,%eax
     71a:	cd 40                	int    $0x40
     71c:	c3                   	ret

000000000000071d <sleep>:
SYSCALL(sleep)
     71d:	b8 0d 00 00 00       	mov    $0xd,%eax
     722:	cd 40                	int    $0x40
     724:	c3                   	ret

0000000000000725 <uptime>:
SYSCALL(uptime)
     725:	b8 0e 00 00 00       	mov    $0xe,%eax
     72a:	cd 40                	int    $0x40
     72c:	c3                   	ret

000000000000072d <getpinfo>:
SYSCALL(getpinfo)
     72d:	b8 18 00 00 00       	mov    $0x18,%eax
     732:	cd 40                	int    $0x40
     734:	c3                   	ret

0000000000000735 <getfavnum>:
SYSCALL(getfavnum)
     735:	b8 19 00 00 00       	mov    $0x19,%eax
     73a:	cd 40                	int    $0x40
     73c:	c3                   	ret

000000000000073d <shutdown>:
SYSCALL(shutdown)
     73d:	b8 1a 00 00 00       	mov    $0x1a,%eax
     742:	cd 40                	int    $0x40
     744:	c3                   	ret

0000000000000745 <getcount>:
SYSCALL(getcount)
     745:	b8 1b 00 00 00       	mov    $0x1b,%eax
     74a:	cd 40                	int    $0x40
     74c:	c3                   	ret

000000000000074d <killrandom>:
     74d:	b8 1c 00 00 00       	mov    $0x1c,%eax
     752:	cd 40                	int    $0x40
     754:	c3                   	ret

0000000000000755 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
     755:	55                   	push   %rbp
     756:	48 89 e5             	mov    %rsp,%rbp
     759:	48 83 ec 10          	sub    $0x10,%rsp
     75d:	89 7d fc             	mov    %edi,-0x4(%rbp)
     760:	89 f0                	mov    %esi,%eax
     762:	88 45 f8             	mov    %al,-0x8(%rbp)
  write(fd, &c, 1);
     765:	48 8d 4d f8          	lea    -0x8(%rbp),%rcx
     769:	8b 45 fc             	mov    -0x4(%rbp),%eax
     76c:	ba 01 00 00 00       	mov    $0x1,%edx
     771:	48 89 ce             	mov    %rcx,%rsi
     774:	89 c7                	mov    %eax,%edi
     776:	e8 32 ff ff ff       	call   6ad <write>
}
     77b:	90                   	nop
     77c:	c9                   	leave
     77d:	c3                   	ret

000000000000077e <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     77e:	55                   	push   %rbp
     77f:	48 89 e5             	mov    %rsp,%rbp
     782:	48 83 ec 30          	sub    $0x30,%rsp
     786:	89 7d dc             	mov    %edi,-0x24(%rbp)
     789:	89 75 d8             	mov    %esi,-0x28(%rbp)
     78c:	89 55 d4             	mov    %edx,-0x2c(%rbp)
     78f:	89 4d d0             	mov    %ecx,-0x30(%rbp)
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
     792:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
  if(sgn && xx < 0){
     799:	83 7d d0 00          	cmpl   $0x0,-0x30(%rbp)
     79d:	74 17                	je     7b6 <printint+0x38>
     79f:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
     7a3:	79 11                	jns    7b6 <printint+0x38>
    neg = 1;
     7a5:	c7 45 f8 01 00 00 00 	movl   $0x1,-0x8(%rbp)
    x = -xx;
     7ac:	8b 45 d8             	mov    -0x28(%rbp),%eax
     7af:	f7 d8                	neg    %eax
     7b1:	89 45 f4             	mov    %eax,-0xc(%rbp)
     7b4:	eb 06                	jmp    7bc <printint+0x3e>
  } else {
    x = xx;
     7b6:	8b 45 d8             	mov    -0x28(%rbp),%eax
     7b9:	89 45 f4             	mov    %eax,-0xc(%rbp)
  }

  i = 0;
     7bc:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  do{
    buf[i++] = digits[x % base];
     7c3:	8b 4d d4             	mov    -0x2c(%rbp),%ecx
     7c6:	8b 45 f4             	mov    -0xc(%rbp),%eax
     7c9:	ba 00 00 00 00       	mov    $0x0,%edx
     7ce:	f7 f1                	div    %ecx
     7d0:	89 d1                	mov    %edx,%ecx
     7d2:	8b 45 fc             	mov    -0x4(%rbp),%eax
     7d5:	8d 50 01             	lea    0x1(%rax),%edx
     7d8:	89 55 fc             	mov    %edx,-0x4(%rbp)
     7db:	89 ca                	mov    %ecx,%edx
     7dd:	0f b6 92 d0 13 00 00 	movzbl 0x13d0(%rdx),%edx
     7e4:	48 98                	cltq
     7e6:	88 54 05 e0          	mov    %dl,-0x20(%rbp,%rax,1)
  }while((x /= base) != 0);
     7ea:	8b 75 d4             	mov    -0x2c(%rbp),%esi
     7ed:	8b 45 f4             	mov    -0xc(%rbp),%eax
     7f0:	ba 00 00 00 00       	mov    $0x0,%edx
     7f5:	f7 f6                	div    %esi
     7f7:	89 45 f4             	mov    %eax,-0xc(%rbp)
     7fa:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
     7fe:	75 c3                	jne    7c3 <printint+0x45>
  if(neg)
     800:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
     804:	74 2b                	je     831 <printint+0xb3>
    buf[i++] = '-';
     806:	8b 45 fc             	mov    -0x4(%rbp),%eax
     809:	8d 50 01             	lea    0x1(%rax),%edx
     80c:	89 55 fc             	mov    %edx,-0x4(%rbp)
     80f:	48 98                	cltq
     811:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%rbp,%rax,1)

  while(--i >= 0)
     816:	eb 19                	jmp    831 <printint+0xb3>
    putc(fd, buf[i]);
     818:	8b 45 fc             	mov    -0x4(%rbp),%eax
     81b:	48 98                	cltq
     81d:	0f b6 44 05 e0       	movzbl -0x20(%rbp,%rax,1),%eax
     822:	0f be d0             	movsbl %al,%edx
     825:	8b 45 dc             	mov    -0x24(%rbp),%eax
     828:	89 d6                	mov    %edx,%esi
     82a:	89 c7                	mov    %eax,%edi
     82c:	e8 24 ff ff ff       	call   755 <putc>
  while(--i >= 0)
     831:	83 6d fc 01          	subl   $0x1,-0x4(%rbp)
     835:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
     839:	79 dd                	jns    818 <printint+0x9a>
}
     83b:	90                   	nop
     83c:	90                   	nop
     83d:	c9                   	leave
     83e:	c3                   	ret

000000000000083f <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
     83f:	55                   	push   %rbp
     840:	48 89 e5             	mov    %rsp,%rbp
     843:	48 81 ec f0 00 00 00 	sub    $0xf0,%rsp
     84a:	89 bd 1c ff ff ff    	mov    %edi,-0xe4(%rbp)
     850:	48 89 b5 10 ff ff ff 	mov    %rsi,-0xf0(%rbp)
     857:	48 89 95 60 ff ff ff 	mov    %rdx,-0xa0(%rbp)
     85e:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
     865:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
     86c:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
     873:	84 c0                	test   %al,%al
     875:	74 20                	je     897 <printf+0x58>
     877:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
     87b:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
     87f:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
     883:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
     887:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
     88b:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
     88f:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
     893:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  va_list ap;
  char *s;
  int c, i, state;
  va_start(ap, fmt);
     897:	c7 85 20 ff ff ff 10 	movl   $0x10,-0xe0(%rbp)
     89e:	00 00 00 
     8a1:	c7 85 24 ff ff ff 30 	movl   $0x30,-0xdc(%rbp)
     8a8:	00 00 00 
     8ab:	48 8d 45 10          	lea    0x10(%rbp),%rax
     8af:	48 89 85 28 ff ff ff 	mov    %rax,-0xd8(%rbp)
     8b6:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
     8bd:	48 89 85 30 ff ff ff 	mov    %rax,-0xd0(%rbp)

  state = 0;
     8c4:	c7 85 40 ff ff ff 00 	movl   $0x0,-0xc0(%rbp)
     8cb:	00 00 00 
  for(i = 0; fmt[i]; i++){
     8ce:	c7 85 44 ff ff ff 00 	movl   $0x0,-0xbc(%rbp)
     8d5:	00 00 00 
     8d8:	e9 a8 02 00 00       	jmp    b85 <printf+0x346>
    c = fmt[i] & 0xff;
     8dd:	8b 85 44 ff ff ff    	mov    -0xbc(%rbp),%eax
     8e3:	48 63 d0             	movslq %eax,%rdx
     8e6:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
     8ed:	48 01 d0             	add    %rdx,%rax
     8f0:	0f b6 00             	movzbl (%rax),%eax
     8f3:	0f be c0             	movsbl %al,%eax
     8f6:	25 ff 00 00 00       	and    $0xff,%eax
     8fb:	89 85 3c ff ff ff    	mov    %eax,-0xc4(%rbp)
    if(state == 0){
     901:	83 bd 40 ff ff ff 00 	cmpl   $0x0,-0xc0(%rbp)
     908:	75 35                	jne    93f <printf+0x100>
      if(c == '%'){
     90a:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
     911:	75 0f                	jne    922 <printf+0xe3>
        state = '%';
     913:	c7 85 40 ff ff ff 25 	movl   $0x25,-0xc0(%rbp)
     91a:	00 00 00 
     91d:	e9 5c 02 00 00       	jmp    b7e <printf+0x33f>
      } else {
        putc(fd, c);
     922:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
     928:	0f be d0             	movsbl %al,%edx
     92b:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
     931:	89 d6                	mov    %edx,%esi
     933:	89 c7                	mov    %eax,%edi
     935:	e8 1b fe ff ff       	call   755 <putc>
     93a:	e9 3f 02 00 00       	jmp    b7e <printf+0x33f>
      }
    } else if(state == '%'){
     93f:	83 bd 40 ff ff ff 25 	cmpl   $0x25,-0xc0(%rbp)
     946:	0f 85 32 02 00 00    	jne    b7e <printf+0x33f>
      if(c == 'd'){
     94c:	83 bd 3c ff ff ff 64 	cmpl   $0x64,-0xc4(%rbp)
     953:	75 5e                	jne    9b3 <printf+0x174>
        printint(fd, va_arg(ap, int), 10, 1);
     955:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
     95b:	83 f8 2f             	cmp    $0x2f,%eax
     95e:	77 23                	ja     983 <printf+0x144>
     960:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
     967:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
     96d:	89 d2                	mov    %edx,%edx
     96f:	48 01 d0             	add    %rdx,%rax
     972:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
     978:	83 c2 08             	add    $0x8,%edx
     97b:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
     981:	eb 12                	jmp    995 <printf+0x156>
     983:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
     98a:	48 8d 50 08          	lea    0x8(%rax),%rdx
     98e:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
     995:	8b 30                	mov    (%rax),%esi
     997:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
     99d:	b9 01 00 00 00       	mov    $0x1,%ecx
     9a2:	ba 0a 00 00 00       	mov    $0xa,%edx
     9a7:	89 c7                	mov    %eax,%edi
     9a9:	e8 d0 fd ff ff       	call   77e <printint>
     9ae:	e9 c1 01 00 00       	jmp    b74 <printf+0x335>
      } else if(c == 'x' || c == 'p'){
     9b3:	83 bd 3c ff ff ff 78 	cmpl   $0x78,-0xc4(%rbp)
     9ba:	74 09                	je     9c5 <printf+0x186>
     9bc:	83 bd 3c ff ff ff 70 	cmpl   $0x70,-0xc4(%rbp)
     9c3:	75 5e                	jne    a23 <printf+0x1e4>
        printint(fd, va_arg(ap, int), 16, 0);
     9c5:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
     9cb:	83 f8 2f             	cmp    $0x2f,%eax
     9ce:	77 23                	ja     9f3 <printf+0x1b4>
     9d0:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
     9d7:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
     9dd:	89 d2                	mov    %edx,%edx
     9df:	48 01 d0             	add    %rdx,%rax
     9e2:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
     9e8:	83 c2 08             	add    $0x8,%edx
     9eb:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
     9f1:	eb 12                	jmp    a05 <printf+0x1c6>
     9f3:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
     9fa:	48 8d 50 08          	lea    0x8(%rax),%rdx
     9fe:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
     a05:	8b 30                	mov    (%rax),%esi
     a07:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
     a0d:	b9 00 00 00 00       	mov    $0x0,%ecx
     a12:	ba 10 00 00 00       	mov    $0x10,%edx
     a17:	89 c7                	mov    %eax,%edi
     a19:	e8 60 fd ff ff       	call   77e <printint>
     a1e:	e9 51 01 00 00       	jmp    b74 <printf+0x335>
      } else if(c == 's'){
     a23:	83 bd 3c ff ff ff 73 	cmpl   $0x73,-0xc4(%rbp)
     a2a:	0f 85 98 00 00 00    	jne    ac8 <printf+0x289>
        s = va_arg(ap, char*);
     a30:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
     a36:	83 f8 2f             	cmp    $0x2f,%eax
     a39:	77 23                	ja     a5e <printf+0x21f>
     a3b:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
     a42:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
     a48:	89 d2                	mov    %edx,%edx
     a4a:	48 01 d0             	add    %rdx,%rax
     a4d:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
     a53:	83 c2 08             	add    $0x8,%edx
     a56:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
     a5c:	eb 12                	jmp    a70 <printf+0x231>
     a5e:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
     a65:	48 8d 50 08          	lea    0x8(%rax),%rdx
     a69:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
     a70:	48 8b 00             	mov    (%rax),%rax
     a73:	48 89 85 48 ff ff ff 	mov    %rax,-0xb8(%rbp)
        if(s == 0)
     a7a:	48 83 bd 48 ff ff ff 	cmpq   $0x0,-0xb8(%rbp)
     a81:	00 
     a82:	75 31                	jne    ab5 <printf+0x276>
          s = "(null)";
     a84:	48 c7 85 48 ff ff ff 	movq   $0x106e,-0xb8(%rbp)
     a8b:	6e 10 00 00 
        while(*s != 0){
     a8f:	eb 24                	jmp    ab5 <printf+0x276>
          putc(fd, *s);
     a91:	48 8b 85 48 ff ff ff 	mov    -0xb8(%rbp),%rax
     a98:	0f b6 00             	movzbl (%rax),%eax
     a9b:	0f be d0             	movsbl %al,%edx
     a9e:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
     aa4:	89 d6                	mov    %edx,%esi
     aa6:	89 c7                	mov    %eax,%edi
     aa8:	e8 a8 fc ff ff       	call   755 <putc>
          s++;
     aad:	48 83 85 48 ff ff ff 	addq   $0x1,-0xb8(%rbp)
     ab4:	01 
        while(*s != 0){
     ab5:	48 8b 85 48 ff ff ff 	mov    -0xb8(%rbp),%rax
     abc:	0f b6 00             	movzbl (%rax),%eax
     abf:	84 c0                	test   %al,%al
     ac1:	75 ce                	jne    a91 <printf+0x252>
     ac3:	e9 ac 00 00 00       	jmp    b74 <printf+0x335>
        }
      } else if(c == 'c'){
     ac8:	83 bd 3c ff ff ff 63 	cmpl   $0x63,-0xc4(%rbp)
     acf:	75 56                	jne    b27 <printf+0x2e8>
        putc(fd, va_arg(ap, uint));
     ad1:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
     ad7:	83 f8 2f             	cmp    $0x2f,%eax
     ada:	77 23                	ja     aff <printf+0x2c0>
     adc:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
     ae3:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
     ae9:	89 d2                	mov    %edx,%edx
     aeb:	48 01 d0             	add    %rdx,%rax
     aee:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
     af4:	83 c2 08             	add    $0x8,%edx
     af7:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
     afd:	eb 12                	jmp    b11 <printf+0x2d2>
     aff:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
     b06:	48 8d 50 08          	lea    0x8(%rax),%rdx
     b0a:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
     b11:	8b 00                	mov    (%rax),%eax
     b13:	0f be d0             	movsbl %al,%edx
     b16:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
     b1c:	89 d6                	mov    %edx,%esi
     b1e:	89 c7                	mov    %eax,%edi
     b20:	e8 30 fc ff ff       	call   755 <putc>
     b25:	eb 4d                	jmp    b74 <printf+0x335>
      } else if(c == '%'){
     b27:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
     b2e:	75 1a                	jne    b4a <printf+0x30b>
        putc(fd, c);
     b30:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
     b36:	0f be d0             	movsbl %al,%edx
     b39:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
     b3f:	89 d6                	mov    %edx,%esi
     b41:	89 c7                	mov    %eax,%edi
     b43:	e8 0d fc ff ff       	call   755 <putc>
     b48:	eb 2a                	jmp    b74 <printf+0x335>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
     b4a:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
     b50:	be 25 00 00 00       	mov    $0x25,%esi
     b55:	89 c7                	mov    %eax,%edi
     b57:	e8 f9 fb ff ff       	call   755 <putc>
        putc(fd, c);
     b5c:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
     b62:	0f be d0             	movsbl %al,%edx
     b65:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
     b6b:	89 d6                	mov    %edx,%esi
     b6d:	89 c7                	mov    %eax,%edi
     b6f:	e8 e1 fb ff ff       	call   755 <putc>
      }
      state = 0;
     b74:	c7 85 40 ff ff ff 00 	movl   $0x0,-0xc0(%rbp)
     b7b:	00 00 00 
  for(i = 0; fmt[i]; i++){
     b7e:	83 85 44 ff ff ff 01 	addl   $0x1,-0xbc(%rbp)
     b85:	8b 85 44 ff ff ff    	mov    -0xbc(%rbp),%eax
     b8b:	48 63 d0             	movslq %eax,%rdx
     b8e:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
     b95:	48 01 d0             	add    %rdx,%rax
     b98:	0f b6 00             	movzbl (%rax),%eax
     b9b:	84 c0                	test   %al,%al
     b9d:	0f 85 3a fd ff ff    	jne    8dd <printf+0x9e>
    }
  }
}
     ba3:	90                   	nop
     ba4:	90                   	nop
     ba5:	c9                   	leave
     ba6:	c3                   	ret

0000000000000ba7 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
     ba7:	55                   	push   %rbp
     ba8:	48 89 e5             	mov    %rsp,%rbp
     bab:	48 83 ec 18          	sub    $0x18,%rsp
     baf:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  Header *bp, *p;

  bp = (Header*)ap - 1;
     bb3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
     bb7:	48 83 e8 10          	sub    $0x10,%rax
     bbb:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     bbf:	48 8b 05 4a 0c 00 00 	mov    0xc4a(%rip),%rax        # 1810 <freep>
     bc6:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
     bca:	eb 2f                	jmp    bfb <free+0x54>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     bcc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     bd0:	48 8b 00             	mov    (%rax),%rax
     bd3:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
     bd7:	72 17                	jb     bf0 <free+0x49>
     bd9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
     bdd:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
     be1:	72 2f                	jb     c12 <free+0x6b>
     be3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     be7:	48 8b 00             	mov    (%rax),%rax
     bea:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
     bee:	72 22                	jb     c12 <free+0x6b>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     bf0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     bf4:	48 8b 00             	mov    (%rax),%rax
     bf7:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
     bfb:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
     bff:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
     c03:	73 c7                	jae    bcc <free+0x25>
     c05:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     c09:	48 8b 00             	mov    (%rax),%rax
     c0c:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
     c10:	73 ba                	jae    bcc <free+0x25>
      break;
  if(bp + bp->s.size == p->s.ptr){
     c12:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
     c16:	8b 40 08             	mov    0x8(%rax),%eax
     c19:	89 c0                	mov    %eax,%eax
     c1b:	48 c1 e0 04          	shl    $0x4,%rax
     c1f:	48 89 c2             	mov    %rax,%rdx
     c22:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
     c26:	48 01 c2             	add    %rax,%rdx
     c29:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     c2d:	48 8b 00             	mov    (%rax),%rax
     c30:	48 39 c2             	cmp    %rax,%rdx
     c33:	75 2d                	jne    c62 <free+0xbb>
    bp->s.size += p->s.ptr->s.size;
     c35:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
     c39:	8b 50 08             	mov    0x8(%rax),%edx
     c3c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     c40:	48 8b 00             	mov    (%rax),%rax
     c43:	8b 40 08             	mov    0x8(%rax),%eax
     c46:	01 c2                	add    %eax,%edx
     c48:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
     c4c:	89 50 08             	mov    %edx,0x8(%rax)
    bp->s.ptr = p->s.ptr->s.ptr;
     c4f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     c53:	48 8b 00             	mov    (%rax),%rax
     c56:	48 8b 10             	mov    (%rax),%rdx
     c59:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
     c5d:	48 89 10             	mov    %rdx,(%rax)
     c60:	eb 0e                	jmp    c70 <free+0xc9>
  } else
    bp->s.ptr = p->s.ptr;
     c62:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     c66:	48 8b 10             	mov    (%rax),%rdx
     c69:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
     c6d:	48 89 10             	mov    %rdx,(%rax)
  if(p + p->s.size == bp){
     c70:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     c74:	8b 40 08             	mov    0x8(%rax),%eax
     c77:	89 c0                	mov    %eax,%eax
     c79:	48 c1 e0 04          	shl    $0x4,%rax
     c7d:	48 89 c2             	mov    %rax,%rdx
     c80:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     c84:	48 01 d0             	add    %rdx,%rax
     c87:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
     c8b:	75 27                	jne    cb4 <free+0x10d>
    p->s.size += bp->s.size;
     c8d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     c91:	8b 50 08             	mov    0x8(%rax),%edx
     c94:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
     c98:	8b 40 08             	mov    0x8(%rax),%eax
     c9b:	01 c2                	add    %eax,%edx
     c9d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     ca1:	89 50 08             	mov    %edx,0x8(%rax)
    p->s.ptr = bp->s.ptr;
     ca4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
     ca8:	48 8b 10             	mov    (%rax),%rdx
     cab:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     caf:	48 89 10             	mov    %rdx,(%rax)
     cb2:	eb 0b                	jmp    cbf <free+0x118>
  } else
    p->s.ptr = bp;
     cb4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     cb8:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
     cbc:	48 89 10             	mov    %rdx,(%rax)
  freep = p;
     cbf:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     cc3:	48 89 05 46 0b 00 00 	mov    %rax,0xb46(%rip)        # 1810 <freep>
}
     cca:	90                   	nop
     ccb:	c9                   	leave
     ccc:	c3                   	ret

0000000000000ccd <morecore>:

static Header*
morecore(uint nu)
{
     ccd:	55                   	push   %rbp
     cce:	48 89 e5             	mov    %rsp,%rbp
     cd1:	48 83 ec 20          	sub    $0x20,%rsp
     cd5:	89 7d ec             	mov    %edi,-0x14(%rbp)
  char *p;
  Header *hp;

  if(nu < 4096)
     cd8:	81 7d ec ff 0f 00 00 	cmpl   $0xfff,-0x14(%rbp)
     cdf:	77 07                	ja     ce8 <morecore+0x1b>
    nu = 4096;
     ce1:	c7 45 ec 00 10 00 00 	movl   $0x1000,-0x14(%rbp)
  p = sbrk(nu * sizeof(Header));
     ce8:	8b 45 ec             	mov    -0x14(%rbp),%eax
     ceb:	c1 e0 04             	shl    $0x4,%eax
     cee:	89 c7                	mov    %eax,%edi
     cf0:	e8 20 fa ff ff       	call   715 <sbrk>
     cf5:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  if(p == (char*)-1)
     cf9:	48 83 7d f8 ff       	cmpq   $0xffffffffffffffff,-0x8(%rbp)
     cfe:	75 07                	jne    d07 <morecore+0x3a>
    return 0;
     d00:	b8 00 00 00 00       	mov    $0x0,%eax
     d05:	eb 29                	jmp    d30 <morecore+0x63>
  hp = (Header*)p;
     d07:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     d0b:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  hp->s.size = nu;
     d0f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
     d13:	8b 55 ec             	mov    -0x14(%rbp),%edx
     d16:	89 50 08             	mov    %edx,0x8(%rax)
  free((void*)(hp + 1));
     d19:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
     d1d:	48 83 c0 10          	add    $0x10,%rax
     d21:	48 89 c7             	mov    %rax,%rdi
     d24:	e8 7e fe ff ff       	call   ba7 <free>
  return freep;
     d29:	48 8b 05 e0 0a 00 00 	mov    0xae0(%rip),%rax        # 1810 <freep>
}
     d30:	c9                   	leave
     d31:	c3                   	ret

0000000000000d32 <malloc>:

void*
malloc(uint nbytes)
{
     d32:	55                   	push   %rbp
     d33:	48 89 e5             	mov    %rsp,%rbp
     d36:	48 83 ec 30          	sub    $0x30,%rsp
     d3a:	89 7d dc             	mov    %edi,-0x24(%rbp)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
     d3d:	8b 45 dc             	mov    -0x24(%rbp),%eax
     d40:	48 83 c0 0f          	add    $0xf,%rax
     d44:	48 c1 e8 04          	shr    $0x4,%rax
     d48:	83 c0 01             	add    $0x1,%eax
     d4b:	89 45 ec             	mov    %eax,-0x14(%rbp)
  if((prevp = freep) == 0){
     d4e:	48 8b 05 bb 0a 00 00 	mov    0xabb(%rip),%rax        # 1810 <freep>
     d55:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
     d59:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
     d5e:	75 2b                	jne    d8b <malloc+0x59>
    base.s.ptr = freep = prevp = &base;
     d60:	48 c7 45 f0 00 18 00 	movq   $0x1800,-0x10(%rbp)
     d67:	00 
     d68:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
     d6c:	48 89 05 9d 0a 00 00 	mov    %rax,0xa9d(%rip)        # 1810 <freep>
     d73:	48 8b 05 96 0a 00 00 	mov    0xa96(%rip),%rax        # 1810 <freep>
     d7a:	48 89 05 7f 0a 00 00 	mov    %rax,0xa7f(%rip)        # 1800 <base>
    base.s.size = 0;
     d81:	c7 05 7d 0a 00 00 00 	movl   $0x0,0xa7d(%rip)        # 1808 <base+0x8>
     d88:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     d8b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
     d8f:	48 8b 00             	mov    (%rax),%rax
     d92:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
     d96:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     d9a:	8b 40 08             	mov    0x8(%rax),%eax
     d9d:	3b 45 ec             	cmp    -0x14(%rbp),%eax
     da0:	72 5f                	jb     e01 <malloc+0xcf>
      if(p->s.size == nunits)
     da2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     da6:	8b 40 08             	mov    0x8(%rax),%eax
     da9:	39 45 ec             	cmp    %eax,-0x14(%rbp)
     dac:	75 10                	jne    dbe <malloc+0x8c>
        prevp->s.ptr = p->s.ptr;
     dae:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     db2:	48 8b 10             	mov    (%rax),%rdx
     db5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
     db9:	48 89 10             	mov    %rdx,(%rax)
     dbc:	eb 2e                	jmp    dec <malloc+0xba>
      else {
        p->s.size -= nunits;
     dbe:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     dc2:	8b 40 08             	mov    0x8(%rax),%eax
     dc5:	2b 45 ec             	sub    -0x14(%rbp),%eax
     dc8:	89 c2                	mov    %eax,%edx
     dca:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     dce:	89 50 08             	mov    %edx,0x8(%rax)
        p += p->s.size;
     dd1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     dd5:	8b 40 08             	mov    0x8(%rax),%eax
     dd8:	89 c0                	mov    %eax,%eax
     dda:	48 c1 e0 04          	shl    $0x4,%rax
     dde:	48 01 45 f8          	add    %rax,-0x8(%rbp)
        p->s.size = nunits;
     de2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     de6:	8b 55 ec             	mov    -0x14(%rbp),%edx
     de9:	89 50 08             	mov    %edx,0x8(%rax)
      }
      freep = prevp;
     dec:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
     df0:	48 89 05 19 0a 00 00 	mov    %rax,0xa19(%rip)        # 1810 <freep>
      return (void*)(p + 1);
     df7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     dfb:	48 83 c0 10          	add    $0x10,%rax
     dff:	eb 41                	jmp    e42 <malloc+0x110>
    }
    if(p == freep)
     e01:	48 8b 05 08 0a 00 00 	mov    0xa08(%rip),%rax        # 1810 <freep>
     e08:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
     e0c:	75 1c                	jne    e2a <malloc+0xf8>
      if((p = morecore(nunits)) == 0)
     e0e:	8b 45 ec             	mov    -0x14(%rbp),%eax
     e11:	89 c7                	mov    %eax,%edi
     e13:	e8 b5 fe ff ff       	call   ccd <morecore>
     e18:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
     e1c:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
     e21:	75 07                	jne    e2a <malloc+0xf8>
        return 0;
     e23:	b8 00 00 00 00       	mov    $0x0,%eax
     e28:	eb 18                	jmp    e42 <malloc+0x110>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     e2a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     e2e:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
     e32:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     e36:	48 8b 00             	mov    (%rax),%rax
     e39:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
     e3d:	e9 54 ff ff ff       	jmp    d96 <malloc+0x64>
  }
}
     e42:	c9                   	leave
     e43:	c3                   	ret

0000000000000e44 <createRoot>:
#include "set.h"
#include "user.h"

//TODO: Να μην είναι περιορισμένο σε int

Set* createRoot(){
     e44:	55                   	push   %rbp
     e45:	48 89 e5             	mov    %rsp,%rbp
     e48:	48 83 ec 10          	sub    $0x10,%rsp
    //Αρχικοποίηση του Set
    Set *set = malloc(sizeof(Set));
     e4c:	bf 10 00 00 00       	mov    $0x10,%edi
     e51:	e8 dc fe ff ff       	call   d32 <malloc>
     e56:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    set->size = 0;
     e5a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     e5e:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%rax)
    set->root = NULL;
     e65:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     e69:	48 c7 00 00 00 00 00 	movq   $0x0,(%rax)
    return set;
     e70:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
     e74:	c9                   	leave
     e75:	c3                   	ret

0000000000000e76 <createNode>:

void createNode(int i, Set *set){
     e76:	55                   	push   %rbp
     e77:	48 89 e5             	mov    %rsp,%rbp
     e7a:	48 83 ec 20          	sub    $0x20,%rsp
     e7e:	89 7d ec             	mov    %edi,-0x14(%rbp)
     e81:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    Η συνάρτηση αυτή δημιουργεί ένα νέο SetNode με την τιμή i και εφόσον δεν υπάρχει στο Set το προσθέτει στο τέλος του συνόλου.
    Σημείωση: Ίσως υπάρχει καλύτερος τρόπος για την υλοποίηση.
    */

    //Αρχικοποίηση του SetNode
    SetNode *temp = malloc(sizeof(SetNode));
     e85:	bf 10 00 00 00       	mov    $0x10,%edi
     e8a:	e8 a3 fe ff ff       	call   d32 <malloc>
     e8f:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    temp->i = i;
     e93:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
     e97:	8b 55 ec             	mov    -0x14(%rbp),%edx
     e9a:	89 10                	mov    %edx,(%rax)
    temp->next = NULL;
     e9c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
     ea0:	48 c7 40 08 00 00 00 	movq   $0x0,0x8(%rax)
     ea7:	00 

    //Έλεγχος ύπαρξης του i
    SetNode *curr = set->root;//Ξεκινάει από την root
     ea8:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
     eac:	48 8b 00             	mov    (%rax),%rax
     eaf:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(curr != NULL) { //Εφόσον το Set δεν είναι άδειο
     eb3:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
     eb8:	74 34                	je     eee <createNode+0x78>
        while (curr->next != NULL){ //Εφόσον υπάρχει επόμενο node
     eba:	eb 25                	jmp    ee1 <createNode+0x6b>
            if (curr->i == i){ //Αν το i υπάρχει στο σύνολο
     ebc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     ec0:	8b 00                	mov    (%rax),%eax
     ec2:	39 45 ec             	cmp    %eax,-0x14(%rbp)
     ec5:	75 0e                	jne    ed5 <createNode+0x5f>
                free(temp); 
     ec7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
     ecb:	48 89 c7             	mov    %rax,%rdi
     ece:	e8 d4 fc ff ff       	call   ba7 <free>
                return; //Δεν εκτελούμε την υπόλοιπη συνάρτηση
     ed3:	eb 4e                	jmp    f23 <createNode+0xad>
            }
            curr = curr->next; //Επόμενο SetNode
     ed5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     ed9:	48 8b 40 08          	mov    0x8(%rax),%rax
     edd:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
        while (curr->next != NULL){ //Εφόσον υπάρχει επόμενο node
     ee1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     ee5:	48 8b 40 08          	mov    0x8(%rax),%rax
     ee9:	48 85 c0             	test   %rax,%rax
     eec:	75 ce                	jne    ebc <createNode+0x46>
        }
    }
    /*
    Ο έλεγχος στην if είναι απαραίτητος για να ελεγχθεί το τελευταίο SetNode.
    */
    if (curr->i != i) attachNode(set, curr, temp); 
     eee:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     ef2:	8b 00                	mov    (%rax),%eax
     ef4:	39 45 ec             	cmp    %eax,-0x14(%rbp)
     ef7:	74 1e                	je     f17 <createNode+0xa1>
     ef9:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
     efd:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
     f01:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
     f05:	48 89 ce             	mov    %rcx,%rsi
     f08:	48 89 c7             	mov    %rax,%rdi
     f0b:	b8 00 00 00 00       	mov    $0x0,%eax
     f10:	e8 10 00 00 00       	call   f25 <attachNode>
     f15:	eb 0c                	jmp    f23 <createNode+0xad>
    else free(temp);
     f17:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
     f1b:	48 89 c7             	mov    %rax,%rdi
     f1e:	e8 84 fc ff ff       	call   ba7 <free>
}
     f23:	c9                   	leave
     f24:	c3                   	ret

0000000000000f25 <attachNode>:

void attachNode(Set *set, SetNode *curr, SetNode *temp){
     f25:	55                   	push   %rbp
     f26:	48 89 e5             	mov    %rsp,%rbp
     f29:	48 83 ec 18          	sub    $0x18,%rsp
     f2d:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
     f31:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
     f35:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
    //Βάζουμε το temp στο τέλος του Set
    if(set->size == 0) set->root = temp;
     f39:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     f3d:	8b 40 08             	mov    0x8(%rax),%eax
     f40:	85 c0                	test   %eax,%eax
     f42:	75 0d                	jne    f51 <attachNode+0x2c>
     f44:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     f48:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
     f4c:	48 89 10             	mov    %rdx,(%rax)
     f4f:	eb 0c                	jmp    f5d <attachNode+0x38>
    else curr->next = temp;
     f51:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
     f55:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
     f59:	48 89 50 08          	mov    %rdx,0x8(%rax)
    set->size += 1;
     f5d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     f61:	8b 40 08             	mov    0x8(%rax),%eax
     f64:	8d 50 01             	lea    0x1(%rax),%edx
     f67:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     f6b:	89 50 08             	mov    %edx,0x8(%rax)
}
     f6e:	90                   	nop
     f6f:	c9                   	leave
     f70:	c3                   	ret

0000000000000f71 <deleteSet>:

void deleteSet(Set *set){
     f71:	55                   	push   %rbp
     f72:	48 89 e5             	mov    %rsp,%rbp
     f75:	48 83 ec 20          	sub    $0x20,%rsp
     f79:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    if (set == NULL) return; //Αν ο χρήστης είναι ΜΛΚ!
     f7d:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
     f82:	74 42                	je     fc6 <deleteSet+0x55>
    SetNode *temp;
    SetNode *curr = set->root; //Ξεκινάμε από το root
     f84:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
     f88:	48 8b 00             	mov    (%rax),%rax
     f8b:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    while (curr != NULL){ 
     f8f:	eb 20                	jmp    fb1 <deleteSet+0x40>
        temp = curr->next; //Αναφορά στο επόμενο SetNode
     f91:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     f95:	48 8b 40 08          	mov    0x8(%rax),%rax
     f99:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
        free(curr); //Απελευθέρωση της curr
     f9d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     fa1:	48 89 c7             	mov    %rax,%rdi
     fa4:	e8 fe fb ff ff       	call   ba7 <free>
        curr = temp;
     fa9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
     fad:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    while (curr != NULL){ 
     fb1:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
     fb6:	75 d9                	jne    f91 <deleteSet+0x20>
    }
    free(set); //Διαγραφή του Set
     fb8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
     fbc:	48 89 c7             	mov    %rax,%rdi
     fbf:	e8 e3 fb ff ff       	call   ba7 <free>
     fc4:	eb 01                	jmp    fc7 <deleteSet+0x56>
    if (set == NULL) return; //Αν ο χρήστης είναι ΜΛΚ!
     fc6:	90                   	nop
}
     fc7:	c9                   	leave
     fc8:	c3                   	ret

0000000000000fc9 <getNodeAtPosition>:

SetNode* getNodeAtPosition(Set *set, int i){
     fc9:	55                   	push   %rbp
     fca:	48 89 e5             	mov    %rsp,%rbp
     fcd:	48 83 ec 20          	sub    $0x20,%rsp
     fd1:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
     fd5:	89 75 e4             	mov    %esi,-0x1c(%rbp)
    if (set == NULL || set->root == NULL) return NULL; //Αν ο χρήστης είναι ΜΛΚ!
     fd8:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
     fdd:	74 0c                	je     feb <getNodeAtPosition+0x22>
     fdf:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
     fe3:	48 8b 00             	mov    (%rax),%rax
     fe6:	48 85 c0             	test   %rax,%rax
     fe9:	75 07                	jne    ff2 <getNodeAtPosition+0x29>
     feb:	b8 00 00 00 00       	mov    $0x0,%eax
     ff0:	eb 3d                	jmp    102f <getNodeAtPosition+0x66>

    SetNode *curr = set->root;
     ff2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
     ff6:	48 8b 00             	mov    (%rax),%rax
     ff9:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    int n;

    for(n = 0; n<i && curr->next != NULL; n++) curr = curr->next; //Ο έλεγχος εδω είναι: n<i && curr->next != NULL
     ffd:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
    1004:	eb 10                	jmp    1016 <getNodeAtPosition+0x4d>
    1006:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    100a:	48 8b 40 08          	mov    0x8(%rax),%rax
    100e:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    1012:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
    1016:	8b 45 f4             	mov    -0xc(%rbp),%eax
    1019:	3b 45 e4             	cmp    -0x1c(%rbp),%eax
    101c:	7d 0d                	jge    102b <getNodeAtPosition+0x62>
    101e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1022:	48 8b 40 08          	mov    0x8(%rax),%rax
    1026:	48 85 c0             	test   %rax,%rax
    1029:	75 db                	jne    1006 <getNodeAtPosition+0x3d>
    return curr;
    102b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    102f:	c9                   	leave
    1030:	c3                   	ret
