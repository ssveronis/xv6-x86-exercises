
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
  21:	48 c7 45 f0 40 11 00 	movq   $0x1140,-0x10(%rbp)
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
  97:	48 81 7d f0 40 11 00 	cmpq   $0x1140,-0x10(%rbp)
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
  b5:	48 81 ea 40 11 00 00 	sub    $0x1140,%rdx
  bc:	29 d0                	sub    %edx,%eax
  be:	89 45 fc             	mov    %eax,-0x4(%rbp)
      memmove(buf, p, m);
  c1:	8b 55 fc             	mov    -0x4(%rbp),%edx
  c4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  c8:	48 89 c6             	mov    %rax,%rsi
  cb:	48 c7 c7 40 11 00 00 	mov    $0x1140,%rdi
  d2:	e8 59 05 00 00       	call   630 <memmove>
  while((n = read(fd, buf+m, sizeof(buf)-m)) > 0){
  d7:	8b 45 fc             	mov    -0x4(%rbp),%eax
  da:	ba 00 04 00 00       	mov    $0x400,%edx
  df:	29 c2                	sub    %eax,%edx
  e1:	8b 45 fc             	mov    -0x4(%rbp),%eax
  e4:	48 98                	cltq
  e6:	48 8d 88 40 11 00 00 	lea    0x1140(%rax),%rcx
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
 120:	48 c7 c6 28 0e 00 00 	mov    $0xe28,%rsi
 127:	bf 02 00 00 00       	mov    $0x2,%edi
 12c:	b8 00 00 00 00       	mov    $0x0,%eax
 131:	e8 e9 06 00 00       	call   81f <printf>
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
 1b6:	48 c7 c6 48 0e 00 00 	mov    $0xe48,%rsi
 1bd:	bf 01 00 00 00       	mov    $0x1,%edi
 1c2:	b8 00 00 00 00       	mov    $0x0,%eax
 1c7:	e8 53 06 00 00       	call   81f <printf>
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

0000000000000735 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 735:	55                   	push   %rbp
 736:	48 89 e5             	mov    %rsp,%rbp
 739:	48 83 ec 10          	sub    $0x10,%rsp
 73d:	89 7d fc             	mov    %edi,-0x4(%rbp)
 740:	89 f0                	mov    %esi,%eax
 742:	88 45 f8             	mov    %al,-0x8(%rbp)
  write(fd, &c, 1);
 745:	48 8d 4d f8          	lea    -0x8(%rbp),%rcx
 749:	8b 45 fc             	mov    -0x4(%rbp),%eax
 74c:	ba 01 00 00 00       	mov    $0x1,%edx
 751:	48 89 ce             	mov    %rcx,%rsi
 754:	89 c7                	mov    %eax,%edi
 756:	e8 52 ff ff ff       	call   6ad <write>
}
 75b:	90                   	nop
 75c:	c9                   	leave
 75d:	c3                   	ret

000000000000075e <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 75e:	55                   	push   %rbp
 75f:	48 89 e5             	mov    %rsp,%rbp
 762:	48 83 ec 30          	sub    $0x30,%rsp
 766:	89 7d dc             	mov    %edi,-0x24(%rbp)
 769:	89 75 d8             	mov    %esi,-0x28(%rbp)
 76c:	89 55 d4             	mov    %edx,-0x2c(%rbp)
 76f:	89 4d d0             	mov    %ecx,-0x30(%rbp)
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 772:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
  if(sgn && xx < 0){
 779:	83 7d d0 00          	cmpl   $0x0,-0x30(%rbp)
 77d:	74 17                	je     796 <printint+0x38>
 77f:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
 783:	79 11                	jns    796 <printint+0x38>
    neg = 1;
 785:	c7 45 f8 01 00 00 00 	movl   $0x1,-0x8(%rbp)
    x = -xx;
 78c:	8b 45 d8             	mov    -0x28(%rbp),%eax
 78f:	f7 d8                	neg    %eax
 791:	89 45 f4             	mov    %eax,-0xc(%rbp)
 794:	eb 06                	jmp    79c <printint+0x3e>
  } else {
    x = xx;
 796:	8b 45 d8             	mov    -0x28(%rbp),%eax
 799:	89 45 f4             	mov    %eax,-0xc(%rbp)
  }

  i = 0;
 79c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  do{
    buf[i++] = digits[x % base];
 7a3:	8b 4d d4             	mov    -0x2c(%rbp),%ecx
 7a6:	8b 45 f4             	mov    -0xc(%rbp),%eax
 7a9:	ba 00 00 00 00       	mov    $0x0,%edx
 7ae:	f7 f1                	div    %ecx
 7b0:	89 d1                	mov    %edx,%ecx
 7b2:	8b 45 fc             	mov    -0x4(%rbp),%eax
 7b5:	8d 50 01             	lea    0x1(%rax),%edx
 7b8:	89 55 fc             	mov    %edx,-0x4(%rbp)
 7bb:	89 ca                	mov    %ecx,%edx
 7bd:	0f b6 92 20 11 00 00 	movzbl 0x1120(%rdx),%edx
 7c4:	48 98                	cltq
 7c6:	88 54 05 e0          	mov    %dl,-0x20(%rbp,%rax,1)
  }while((x /= base) != 0);
 7ca:	8b 75 d4             	mov    -0x2c(%rbp),%esi
 7cd:	8b 45 f4             	mov    -0xc(%rbp),%eax
 7d0:	ba 00 00 00 00       	mov    $0x0,%edx
 7d5:	f7 f6                	div    %esi
 7d7:	89 45 f4             	mov    %eax,-0xc(%rbp)
 7da:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
 7de:	75 c3                	jne    7a3 <printint+0x45>
  if(neg)
 7e0:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
 7e4:	74 2b                	je     811 <printint+0xb3>
    buf[i++] = '-';
 7e6:	8b 45 fc             	mov    -0x4(%rbp),%eax
 7e9:	8d 50 01             	lea    0x1(%rax),%edx
 7ec:	89 55 fc             	mov    %edx,-0x4(%rbp)
 7ef:	48 98                	cltq
 7f1:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%rbp,%rax,1)

  while(--i >= 0)
 7f6:	eb 19                	jmp    811 <printint+0xb3>
    putc(fd, buf[i]);
 7f8:	8b 45 fc             	mov    -0x4(%rbp),%eax
 7fb:	48 98                	cltq
 7fd:	0f b6 44 05 e0       	movzbl -0x20(%rbp,%rax,1),%eax
 802:	0f be d0             	movsbl %al,%edx
 805:	8b 45 dc             	mov    -0x24(%rbp),%eax
 808:	89 d6                	mov    %edx,%esi
 80a:	89 c7                	mov    %eax,%edi
 80c:	e8 24 ff ff ff       	call   735 <putc>
  while(--i >= 0)
 811:	83 6d fc 01          	subl   $0x1,-0x4(%rbp)
 815:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
 819:	79 dd                	jns    7f8 <printint+0x9a>
}
 81b:	90                   	nop
 81c:	90                   	nop
 81d:	c9                   	leave
 81e:	c3                   	ret

000000000000081f <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 81f:	55                   	push   %rbp
 820:	48 89 e5             	mov    %rsp,%rbp
 823:	48 81 ec f0 00 00 00 	sub    $0xf0,%rsp
 82a:	89 bd 1c ff ff ff    	mov    %edi,-0xe4(%rbp)
 830:	48 89 b5 10 ff ff ff 	mov    %rsi,-0xf0(%rbp)
 837:	48 89 95 60 ff ff ff 	mov    %rdx,-0xa0(%rbp)
 83e:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
 845:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
 84c:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
 853:	84 c0                	test   %al,%al
 855:	74 20                	je     877 <printf+0x58>
 857:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
 85b:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
 85f:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
 863:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
 867:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
 86b:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
 86f:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
 873:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  va_list ap;
  char *s;
  int c, i, state;
  va_start(ap, fmt);
 877:	c7 85 20 ff ff ff 10 	movl   $0x10,-0xe0(%rbp)
 87e:	00 00 00 
 881:	c7 85 24 ff ff ff 30 	movl   $0x30,-0xdc(%rbp)
 888:	00 00 00 
 88b:	48 8d 45 10          	lea    0x10(%rbp),%rax
 88f:	48 89 85 28 ff ff ff 	mov    %rax,-0xd8(%rbp)
 896:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
 89d:	48 89 85 30 ff ff ff 	mov    %rax,-0xd0(%rbp)

  state = 0;
 8a4:	c7 85 40 ff ff ff 00 	movl   $0x0,-0xc0(%rbp)
 8ab:	00 00 00 
  for(i = 0; fmt[i]; i++){
 8ae:	c7 85 44 ff ff ff 00 	movl   $0x0,-0xbc(%rbp)
 8b5:	00 00 00 
 8b8:	e9 a8 02 00 00       	jmp    b65 <printf+0x346>
    c = fmt[i] & 0xff;
 8bd:	8b 85 44 ff ff ff    	mov    -0xbc(%rbp),%eax
 8c3:	48 63 d0             	movslq %eax,%rdx
 8c6:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
 8cd:	48 01 d0             	add    %rdx,%rax
 8d0:	0f b6 00             	movzbl (%rax),%eax
 8d3:	0f be c0             	movsbl %al,%eax
 8d6:	25 ff 00 00 00       	and    $0xff,%eax
 8db:	89 85 3c ff ff ff    	mov    %eax,-0xc4(%rbp)
    if(state == 0){
 8e1:	83 bd 40 ff ff ff 00 	cmpl   $0x0,-0xc0(%rbp)
 8e8:	75 35                	jne    91f <printf+0x100>
      if(c == '%'){
 8ea:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
 8f1:	75 0f                	jne    902 <printf+0xe3>
        state = '%';
 8f3:	c7 85 40 ff ff ff 25 	movl   $0x25,-0xc0(%rbp)
 8fa:	00 00 00 
 8fd:	e9 5c 02 00 00       	jmp    b5e <printf+0x33f>
      } else {
        putc(fd, c);
 902:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
 908:	0f be d0             	movsbl %al,%edx
 90b:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 911:	89 d6                	mov    %edx,%esi
 913:	89 c7                	mov    %eax,%edi
 915:	e8 1b fe ff ff       	call   735 <putc>
 91a:	e9 3f 02 00 00       	jmp    b5e <printf+0x33f>
      }
    } else if(state == '%'){
 91f:	83 bd 40 ff ff ff 25 	cmpl   $0x25,-0xc0(%rbp)
 926:	0f 85 32 02 00 00    	jne    b5e <printf+0x33f>
      if(c == 'd'){
 92c:	83 bd 3c ff ff ff 64 	cmpl   $0x64,-0xc4(%rbp)
 933:	75 5e                	jne    993 <printf+0x174>
        printint(fd, va_arg(ap, int), 10, 1);
 935:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 93b:	83 f8 2f             	cmp    $0x2f,%eax
 93e:	77 23                	ja     963 <printf+0x144>
 940:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 947:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 94d:	89 d2                	mov    %edx,%edx
 94f:	48 01 d0             	add    %rdx,%rax
 952:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 958:	83 c2 08             	add    $0x8,%edx
 95b:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 961:	eb 12                	jmp    975 <printf+0x156>
 963:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 96a:	48 8d 50 08          	lea    0x8(%rax),%rdx
 96e:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 975:	8b 30                	mov    (%rax),%esi
 977:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 97d:	b9 01 00 00 00       	mov    $0x1,%ecx
 982:	ba 0a 00 00 00       	mov    $0xa,%edx
 987:	89 c7                	mov    %eax,%edi
 989:	e8 d0 fd ff ff       	call   75e <printint>
 98e:	e9 c1 01 00 00       	jmp    b54 <printf+0x335>
      } else if(c == 'x' || c == 'p'){
 993:	83 bd 3c ff ff ff 78 	cmpl   $0x78,-0xc4(%rbp)
 99a:	74 09                	je     9a5 <printf+0x186>
 99c:	83 bd 3c ff ff ff 70 	cmpl   $0x70,-0xc4(%rbp)
 9a3:	75 5e                	jne    a03 <printf+0x1e4>
        printint(fd, va_arg(ap, int), 16, 0);
 9a5:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 9ab:	83 f8 2f             	cmp    $0x2f,%eax
 9ae:	77 23                	ja     9d3 <printf+0x1b4>
 9b0:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 9b7:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 9bd:	89 d2                	mov    %edx,%edx
 9bf:	48 01 d0             	add    %rdx,%rax
 9c2:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 9c8:	83 c2 08             	add    $0x8,%edx
 9cb:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 9d1:	eb 12                	jmp    9e5 <printf+0x1c6>
 9d3:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 9da:	48 8d 50 08          	lea    0x8(%rax),%rdx
 9de:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 9e5:	8b 30                	mov    (%rax),%esi
 9e7:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 9ed:	b9 00 00 00 00       	mov    $0x0,%ecx
 9f2:	ba 10 00 00 00       	mov    $0x10,%edx
 9f7:	89 c7                	mov    %eax,%edi
 9f9:	e8 60 fd ff ff       	call   75e <printint>
 9fe:	e9 51 01 00 00       	jmp    b54 <printf+0x335>
      } else if(c == 's'){
 a03:	83 bd 3c ff ff ff 73 	cmpl   $0x73,-0xc4(%rbp)
 a0a:	0f 85 98 00 00 00    	jne    aa8 <printf+0x289>
        s = va_arg(ap, char*);
 a10:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 a16:	83 f8 2f             	cmp    $0x2f,%eax
 a19:	77 23                	ja     a3e <printf+0x21f>
 a1b:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 a22:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 a28:	89 d2                	mov    %edx,%edx
 a2a:	48 01 d0             	add    %rdx,%rax
 a2d:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 a33:	83 c2 08             	add    $0x8,%edx
 a36:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 a3c:	eb 12                	jmp    a50 <printf+0x231>
 a3e:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 a45:	48 8d 50 08          	lea    0x8(%rax),%rdx
 a49:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 a50:	48 8b 00             	mov    (%rax),%rax
 a53:	48 89 85 48 ff ff ff 	mov    %rax,-0xb8(%rbp)
        if(s == 0)
 a5a:	48 83 bd 48 ff ff ff 	cmpq   $0x0,-0xb8(%rbp)
 a61:	00 
 a62:	75 31                	jne    a95 <printf+0x276>
          s = "(null)";
 a64:	48 c7 85 48 ff ff ff 	movq   $0xe5e,-0xb8(%rbp)
 a6b:	5e 0e 00 00 
        while(*s != 0){
 a6f:	eb 24                	jmp    a95 <printf+0x276>
          putc(fd, *s);
 a71:	48 8b 85 48 ff ff ff 	mov    -0xb8(%rbp),%rax
 a78:	0f b6 00             	movzbl (%rax),%eax
 a7b:	0f be d0             	movsbl %al,%edx
 a7e:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 a84:	89 d6                	mov    %edx,%esi
 a86:	89 c7                	mov    %eax,%edi
 a88:	e8 a8 fc ff ff       	call   735 <putc>
          s++;
 a8d:	48 83 85 48 ff ff ff 	addq   $0x1,-0xb8(%rbp)
 a94:	01 
        while(*s != 0){
 a95:	48 8b 85 48 ff ff ff 	mov    -0xb8(%rbp),%rax
 a9c:	0f b6 00             	movzbl (%rax),%eax
 a9f:	84 c0                	test   %al,%al
 aa1:	75 ce                	jne    a71 <printf+0x252>
 aa3:	e9 ac 00 00 00       	jmp    b54 <printf+0x335>
        }
      } else if(c == 'c'){
 aa8:	83 bd 3c ff ff ff 63 	cmpl   $0x63,-0xc4(%rbp)
 aaf:	75 56                	jne    b07 <printf+0x2e8>
        putc(fd, va_arg(ap, uint));
 ab1:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 ab7:	83 f8 2f             	cmp    $0x2f,%eax
 aba:	77 23                	ja     adf <printf+0x2c0>
 abc:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 ac3:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 ac9:	89 d2                	mov    %edx,%edx
 acb:	48 01 d0             	add    %rdx,%rax
 ace:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 ad4:	83 c2 08             	add    $0x8,%edx
 ad7:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 add:	eb 12                	jmp    af1 <printf+0x2d2>
 adf:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 ae6:	48 8d 50 08          	lea    0x8(%rax),%rdx
 aea:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 af1:	8b 00                	mov    (%rax),%eax
 af3:	0f be d0             	movsbl %al,%edx
 af6:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 afc:	89 d6                	mov    %edx,%esi
 afe:	89 c7                	mov    %eax,%edi
 b00:	e8 30 fc ff ff       	call   735 <putc>
 b05:	eb 4d                	jmp    b54 <printf+0x335>
      } else if(c == '%'){
 b07:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
 b0e:	75 1a                	jne    b2a <printf+0x30b>
        putc(fd, c);
 b10:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
 b16:	0f be d0             	movsbl %al,%edx
 b19:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 b1f:	89 d6                	mov    %edx,%esi
 b21:	89 c7                	mov    %eax,%edi
 b23:	e8 0d fc ff ff       	call   735 <putc>
 b28:	eb 2a                	jmp    b54 <printf+0x335>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 b2a:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 b30:	be 25 00 00 00       	mov    $0x25,%esi
 b35:	89 c7                	mov    %eax,%edi
 b37:	e8 f9 fb ff ff       	call   735 <putc>
        putc(fd, c);
 b3c:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
 b42:	0f be d0             	movsbl %al,%edx
 b45:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 b4b:	89 d6                	mov    %edx,%esi
 b4d:	89 c7                	mov    %eax,%edi
 b4f:	e8 e1 fb ff ff       	call   735 <putc>
      }
      state = 0;
 b54:	c7 85 40 ff ff ff 00 	movl   $0x0,-0xc0(%rbp)
 b5b:	00 00 00 
  for(i = 0; fmt[i]; i++){
 b5e:	83 85 44 ff ff ff 01 	addl   $0x1,-0xbc(%rbp)
 b65:	8b 85 44 ff ff ff    	mov    -0xbc(%rbp),%eax
 b6b:	48 63 d0             	movslq %eax,%rdx
 b6e:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
 b75:	48 01 d0             	add    %rdx,%rax
 b78:	0f b6 00             	movzbl (%rax),%eax
 b7b:	84 c0                	test   %al,%al
 b7d:	0f 85 3a fd ff ff    	jne    8bd <printf+0x9e>
    }
  }
}
 b83:	90                   	nop
 b84:	90                   	nop
 b85:	c9                   	leave
 b86:	c3                   	ret

0000000000000b87 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 b87:	55                   	push   %rbp
 b88:	48 89 e5             	mov    %rsp,%rbp
 b8b:	48 83 ec 18          	sub    $0x18,%rsp
 b8f:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  Header *bp, *p;

  bp = (Header*)ap - 1;
 b93:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 b97:	48 83 e8 10          	sub    $0x10,%rax
 b9b:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 b9f:	48 8b 05 aa 09 00 00 	mov    0x9aa(%rip),%rax        # 1550 <freep>
 ba6:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 baa:	eb 2f                	jmp    bdb <free+0x54>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 bac:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 bb0:	48 8b 00             	mov    (%rax),%rax
 bb3:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 bb7:	72 17                	jb     bd0 <free+0x49>
 bb9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 bbd:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 bc1:	72 2f                	jb     bf2 <free+0x6b>
 bc3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 bc7:	48 8b 00             	mov    (%rax),%rax
 bca:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
 bce:	72 22                	jb     bf2 <free+0x6b>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 bd0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 bd4:	48 8b 00             	mov    (%rax),%rax
 bd7:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 bdb:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 bdf:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 be3:	73 c7                	jae    bac <free+0x25>
 be5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 be9:	48 8b 00             	mov    (%rax),%rax
 bec:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
 bf0:	73 ba                	jae    bac <free+0x25>
      break;
  if(bp + bp->s.size == p->s.ptr){
 bf2:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 bf6:	8b 40 08             	mov    0x8(%rax),%eax
 bf9:	89 c0                	mov    %eax,%eax
 bfb:	48 c1 e0 04          	shl    $0x4,%rax
 bff:	48 89 c2             	mov    %rax,%rdx
 c02:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 c06:	48 01 c2             	add    %rax,%rdx
 c09:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 c0d:	48 8b 00             	mov    (%rax),%rax
 c10:	48 39 c2             	cmp    %rax,%rdx
 c13:	75 2d                	jne    c42 <free+0xbb>
    bp->s.size += p->s.ptr->s.size;
 c15:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 c19:	8b 50 08             	mov    0x8(%rax),%edx
 c1c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 c20:	48 8b 00             	mov    (%rax),%rax
 c23:	8b 40 08             	mov    0x8(%rax),%eax
 c26:	01 c2                	add    %eax,%edx
 c28:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 c2c:	89 50 08             	mov    %edx,0x8(%rax)
    bp->s.ptr = p->s.ptr->s.ptr;
 c2f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 c33:	48 8b 00             	mov    (%rax),%rax
 c36:	48 8b 10             	mov    (%rax),%rdx
 c39:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 c3d:	48 89 10             	mov    %rdx,(%rax)
 c40:	eb 0e                	jmp    c50 <free+0xc9>
  } else
    bp->s.ptr = p->s.ptr;
 c42:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 c46:	48 8b 10             	mov    (%rax),%rdx
 c49:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 c4d:	48 89 10             	mov    %rdx,(%rax)
  if(p + p->s.size == bp){
 c50:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 c54:	8b 40 08             	mov    0x8(%rax),%eax
 c57:	89 c0                	mov    %eax,%eax
 c59:	48 c1 e0 04          	shl    $0x4,%rax
 c5d:	48 89 c2             	mov    %rax,%rdx
 c60:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 c64:	48 01 d0             	add    %rdx,%rax
 c67:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
 c6b:	75 27                	jne    c94 <free+0x10d>
    p->s.size += bp->s.size;
 c6d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 c71:	8b 50 08             	mov    0x8(%rax),%edx
 c74:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 c78:	8b 40 08             	mov    0x8(%rax),%eax
 c7b:	01 c2                	add    %eax,%edx
 c7d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 c81:	89 50 08             	mov    %edx,0x8(%rax)
    p->s.ptr = bp->s.ptr;
 c84:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 c88:	48 8b 10             	mov    (%rax),%rdx
 c8b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 c8f:	48 89 10             	mov    %rdx,(%rax)
 c92:	eb 0b                	jmp    c9f <free+0x118>
  } else
    p->s.ptr = bp;
 c94:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 c98:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
 c9c:	48 89 10             	mov    %rdx,(%rax)
  freep = p;
 c9f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 ca3:	48 89 05 a6 08 00 00 	mov    %rax,0x8a6(%rip)        # 1550 <freep>
}
 caa:	90                   	nop
 cab:	c9                   	leave
 cac:	c3                   	ret

0000000000000cad <morecore>:

static Header*
morecore(uint nu)
{
 cad:	55                   	push   %rbp
 cae:	48 89 e5             	mov    %rsp,%rbp
 cb1:	48 83 ec 20          	sub    $0x20,%rsp
 cb5:	89 7d ec             	mov    %edi,-0x14(%rbp)
  char *p;
  Header *hp;

  if(nu < 4096)
 cb8:	81 7d ec ff 0f 00 00 	cmpl   $0xfff,-0x14(%rbp)
 cbf:	77 07                	ja     cc8 <morecore+0x1b>
    nu = 4096;
 cc1:	c7 45 ec 00 10 00 00 	movl   $0x1000,-0x14(%rbp)
  p = sbrk(nu * sizeof(Header));
 cc8:	8b 45 ec             	mov    -0x14(%rbp),%eax
 ccb:	c1 e0 04             	shl    $0x4,%eax
 cce:	89 c7                	mov    %eax,%edi
 cd0:	e8 40 fa ff ff       	call   715 <sbrk>
 cd5:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  if(p == (char*)-1)
 cd9:	48 83 7d f8 ff       	cmpq   $0xffffffffffffffff,-0x8(%rbp)
 cde:	75 07                	jne    ce7 <morecore+0x3a>
    return 0;
 ce0:	b8 00 00 00 00       	mov    $0x0,%eax
 ce5:	eb 29                	jmp    d10 <morecore+0x63>
  hp = (Header*)p;
 ce7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 ceb:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  hp->s.size = nu;
 cef:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 cf3:	8b 55 ec             	mov    -0x14(%rbp),%edx
 cf6:	89 50 08             	mov    %edx,0x8(%rax)
  free((void*)(hp + 1));
 cf9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 cfd:	48 83 c0 10          	add    $0x10,%rax
 d01:	48 89 c7             	mov    %rax,%rdi
 d04:	e8 7e fe ff ff       	call   b87 <free>
  return freep;
 d09:	48 8b 05 40 08 00 00 	mov    0x840(%rip),%rax        # 1550 <freep>
}
 d10:	c9                   	leave
 d11:	c3                   	ret

0000000000000d12 <malloc>:

void*
malloc(uint nbytes)
{
 d12:	55                   	push   %rbp
 d13:	48 89 e5             	mov    %rsp,%rbp
 d16:	48 83 ec 30          	sub    $0x30,%rsp
 d1a:	89 7d dc             	mov    %edi,-0x24(%rbp)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 d1d:	8b 45 dc             	mov    -0x24(%rbp),%eax
 d20:	48 83 c0 0f          	add    $0xf,%rax
 d24:	48 c1 e8 04          	shr    $0x4,%rax
 d28:	83 c0 01             	add    $0x1,%eax
 d2b:	89 45 ec             	mov    %eax,-0x14(%rbp)
  if((prevp = freep) == 0){
 d2e:	48 8b 05 1b 08 00 00 	mov    0x81b(%rip),%rax        # 1550 <freep>
 d35:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
 d39:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
 d3e:	75 2b                	jne    d6b <malloc+0x59>
    base.s.ptr = freep = prevp = &base;
 d40:	48 c7 45 f0 40 15 00 	movq   $0x1540,-0x10(%rbp)
 d47:	00 
 d48:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 d4c:	48 89 05 fd 07 00 00 	mov    %rax,0x7fd(%rip)        # 1550 <freep>
 d53:	48 8b 05 f6 07 00 00 	mov    0x7f6(%rip),%rax        # 1550 <freep>
 d5a:	48 89 05 df 07 00 00 	mov    %rax,0x7df(%rip)        # 1540 <base>
    base.s.size = 0;
 d61:	c7 05 dd 07 00 00 00 	movl   $0x0,0x7dd(%rip)        # 1548 <base+0x8>
 d68:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 d6b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 d6f:	48 8b 00             	mov    (%rax),%rax
 d72:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
 d76:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 d7a:	8b 40 08             	mov    0x8(%rax),%eax
 d7d:	3b 45 ec             	cmp    -0x14(%rbp),%eax
 d80:	72 5f                	jb     de1 <malloc+0xcf>
      if(p->s.size == nunits)
 d82:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 d86:	8b 40 08             	mov    0x8(%rax),%eax
 d89:	39 45 ec             	cmp    %eax,-0x14(%rbp)
 d8c:	75 10                	jne    d9e <malloc+0x8c>
        prevp->s.ptr = p->s.ptr;
 d8e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 d92:	48 8b 10             	mov    (%rax),%rdx
 d95:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 d99:	48 89 10             	mov    %rdx,(%rax)
 d9c:	eb 2e                	jmp    dcc <malloc+0xba>
      else {
        p->s.size -= nunits;
 d9e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 da2:	8b 40 08             	mov    0x8(%rax),%eax
 da5:	2b 45 ec             	sub    -0x14(%rbp),%eax
 da8:	89 c2                	mov    %eax,%edx
 daa:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 dae:	89 50 08             	mov    %edx,0x8(%rax)
        p += p->s.size;
 db1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 db5:	8b 40 08             	mov    0x8(%rax),%eax
 db8:	89 c0                	mov    %eax,%eax
 dba:	48 c1 e0 04          	shl    $0x4,%rax
 dbe:	48 01 45 f8          	add    %rax,-0x8(%rbp)
        p->s.size = nunits;
 dc2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 dc6:	8b 55 ec             	mov    -0x14(%rbp),%edx
 dc9:	89 50 08             	mov    %edx,0x8(%rax)
      }
      freep = prevp;
 dcc:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 dd0:	48 89 05 79 07 00 00 	mov    %rax,0x779(%rip)        # 1550 <freep>
      return (void*)(p + 1);
 dd7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 ddb:	48 83 c0 10          	add    $0x10,%rax
 ddf:	eb 41                	jmp    e22 <malloc+0x110>
    }
    if(p == freep)
 de1:	48 8b 05 68 07 00 00 	mov    0x768(%rip),%rax        # 1550 <freep>
 de8:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 dec:	75 1c                	jne    e0a <malloc+0xf8>
      if((p = morecore(nunits)) == 0)
 dee:	8b 45 ec             	mov    -0x14(%rbp),%eax
 df1:	89 c7                	mov    %eax,%edi
 df3:	e8 b5 fe ff ff       	call   cad <morecore>
 df8:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 dfc:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
 e01:	75 07                	jne    e0a <malloc+0xf8>
        return 0;
 e03:	b8 00 00 00 00       	mov    $0x0,%eax
 e08:	eb 18                	jmp    e22 <malloc+0x110>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 e0a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 e0e:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
 e12:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 e16:	48 8b 00             	mov    (%rax),%rax
 e19:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
 e1d:	e9 54 ff ff ff       	jmp    d76 <malloc+0x64>
  }
}
 e22:	c9                   	leave
 e23:	c3                   	ret
