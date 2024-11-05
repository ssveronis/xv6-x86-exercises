
fs/init:     file format elf64-x86-64


Disassembly of section .text:

0000000000000000 <main>:

char *argv[] = { "sh", 0 };

int
main(void)
{
   0:	55                   	push   %rbp
   1:	48 89 e5             	mov    %rsp,%rbp
   4:	48 83 ec 10          	sub    $0x10,%rsp
  int pid, wpid;

  if(open("console", O_RDWR) < 0){
   8:	be 02 00 00 00       	mov    $0x2,%esi
   d:	48 c7 c7 9a 0d 00 00 	mov    $0xd9a,%rdi
  14:	e8 1a 04 00 00       	call   433 <open>
  19:	85 c0                	test   %eax,%eax
  1b:	79 27                	jns    44 <main+0x44>
    mknod("console", 1, 1);
  1d:	ba 01 00 00 00       	mov    $0x1,%edx
  22:	be 01 00 00 00       	mov    $0x1,%esi
  27:	48 c7 c7 9a 0d 00 00 	mov    $0xd9a,%rdi
  2e:	e8 08 04 00 00       	call   43b <mknod>
    open("console", O_RDWR);
  33:	be 02 00 00 00       	mov    $0x2,%esi
  38:	48 c7 c7 9a 0d 00 00 	mov    $0xd9a,%rdi
  3f:	e8 ef 03 00 00       	call   433 <open>
  }
  dup(0);  // stdout
  44:	bf 00 00 00 00       	mov    $0x0,%edi
  49:	e8 1d 04 00 00       	call   46b <dup>
  dup(0);  // stderr
  4e:	bf 00 00 00 00       	mov    $0x0,%edi
  53:	e8 13 04 00 00       	call   46b <dup>

  for(;;){
    printf(1, "init: starting sh\n");
  58:	48 c7 c6 a2 0d 00 00 	mov    $0xda2,%rsi
  5f:	bf 01 00 00 00       	mov    $0x1,%edi
  64:	b8 00 00 00 00       	mov    $0x0,%eax
  69:	e8 37 05 00 00       	call   5a5 <printf>
    pid = fork();
  6e:	e8 78 03 00 00       	call   3eb <fork>
  73:	89 45 fc             	mov    %eax,-0x4(%rbp)
    if(pid < 0){
  76:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  7a:	79 1b                	jns    97 <main+0x97>
      printf(1, "init: fork failed\n");
  7c:	48 c7 c6 b5 0d 00 00 	mov    $0xdb5,%rsi
  83:	bf 01 00 00 00       	mov    $0x1,%edi
  88:	b8 00 00 00 00       	mov    $0x0,%eax
  8d:	e8 13 05 00 00       	call   5a5 <printf>
      exit();
  92:	e8 5c 03 00 00       	call   3f3 <exit>
    }
    if(pid == 0){
  97:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  9b:	75 44                	jne    e1 <main+0xe1>
      exec("sh", argv);
  9d:	48 c7 c6 d0 10 00 00 	mov    $0x10d0,%rsi
  a4:	48 c7 c7 97 0d 00 00 	mov    $0xd97,%rdi
  ab:	e8 7b 03 00 00       	call   42b <exec>
      printf(1, "init: exec sh failed\n");
  b0:	48 c7 c6 c8 0d 00 00 	mov    $0xdc8,%rsi
  b7:	bf 01 00 00 00       	mov    $0x1,%edi
  bc:	b8 00 00 00 00       	mov    $0x0,%eax
  c1:	e8 df 04 00 00       	call   5a5 <printf>
      exit();
  c6:	e8 28 03 00 00       	call   3f3 <exit>
    }
    while((wpid=wait()) >= 0 && wpid != pid)
      printf(1, "zombie!\n");
  cb:	48 c7 c6 de 0d 00 00 	mov    $0xdde,%rsi
  d2:	bf 01 00 00 00       	mov    $0x1,%edi
  d7:	b8 00 00 00 00       	mov    $0x0,%eax
  dc:	e8 c4 04 00 00       	call   5a5 <printf>
    while((wpid=wait()) >= 0 && wpid != pid)
  e1:	e8 15 03 00 00       	call   3fb <wait>
  e6:	89 45 f8             	mov    %eax,-0x8(%rbp)
  e9:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
  ed:	0f 88 65 ff ff ff    	js     58 <main+0x58>
  f3:	8b 45 f8             	mov    -0x8(%rbp),%eax
  f6:	3b 45 fc             	cmp    -0x4(%rbp),%eax
  f9:	75 d0                	jne    cb <main+0xcb>
    printf(1, "init: starting sh\n");
  fb:	e9 58 ff ff ff       	jmp    58 <main+0x58>

0000000000000100 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
 100:	55                   	push   %rbp
 101:	48 89 e5             	mov    %rsp,%rbp
 104:	48 83 ec 10          	sub    $0x10,%rsp
 108:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
 10c:	89 75 f4             	mov    %esi,-0xc(%rbp)
 10f:	89 55 f0             	mov    %edx,-0x10(%rbp)
  asm volatile("cld; rep stosb" :
 112:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
 116:	8b 55 f0             	mov    -0x10(%rbp),%edx
 119:	8b 45 f4             	mov    -0xc(%rbp),%eax
 11c:	48 89 ce             	mov    %rcx,%rsi
 11f:	48 89 f7             	mov    %rsi,%rdi
 122:	89 d1                	mov    %edx,%ecx
 124:	fc                   	cld
 125:	f3 aa                	rep stos %al,%es:(%rdi)
 127:	89 ca                	mov    %ecx,%edx
 129:	48 89 fe             	mov    %rdi,%rsi
 12c:	48 89 75 f8          	mov    %rsi,-0x8(%rbp)
 130:	89 55 f0             	mov    %edx,-0x10(%rbp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
 133:	90                   	nop
 134:	c9                   	leave
 135:	c3                   	ret

0000000000000136 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 136:	55                   	push   %rbp
 137:	48 89 e5             	mov    %rsp,%rbp
 13a:	48 83 ec 20          	sub    $0x20,%rsp
 13e:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
 142:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  char *os;

  os = s;
 146:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 14a:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  while((*s++ = *t++) != 0)
 14e:	90                   	nop
 14f:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
 153:	48 8d 42 01          	lea    0x1(%rdx),%rax
 157:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
 15b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 15f:	48 8d 48 01          	lea    0x1(%rax),%rcx
 163:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
 167:	0f b6 12             	movzbl (%rdx),%edx
 16a:	88 10                	mov    %dl,(%rax)
 16c:	0f b6 00             	movzbl (%rax),%eax
 16f:	84 c0                	test   %al,%al
 171:	75 dc                	jne    14f <strcpy+0x19>
    ;
  return os;
 173:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
 177:	c9                   	leave
 178:	c3                   	ret

0000000000000179 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 179:	55                   	push   %rbp
 17a:	48 89 e5             	mov    %rsp,%rbp
 17d:	48 83 ec 10          	sub    $0x10,%rsp
 181:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
 185:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  while(*p && *p == *q)
 189:	eb 0a                	jmp    195 <strcmp+0x1c>
    p++, q++;
 18b:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
 190:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  while(*p && *p == *q)
 195:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 199:	0f b6 00             	movzbl (%rax),%eax
 19c:	84 c0                	test   %al,%al
 19e:	74 12                	je     1b2 <strcmp+0x39>
 1a0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 1a4:	0f b6 10             	movzbl (%rax),%edx
 1a7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 1ab:	0f b6 00             	movzbl (%rax),%eax
 1ae:	38 c2                	cmp    %al,%dl
 1b0:	74 d9                	je     18b <strcmp+0x12>
  return (uchar)*p - (uchar)*q;
 1b2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 1b6:	0f b6 00             	movzbl (%rax),%eax
 1b9:	0f b6 d0             	movzbl %al,%edx
 1bc:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 1c0:	0f b6 00             	movzbl (%rax),%eax
 1c3:	0f b6 c0             	movzbl %al,%eax
 1c6:	29 c2                	sub    %eax,%edx
 1c8:	89 d0                	mov    %edx,%eax
}
 1ca:	c9                   	leave
 1cb:	c3                   	ret

00000000000001cc <strlen>:

uint
strlen(char *s)
{
 1cc:	55                   	push   %rbp
 1cd:	48 89 e5             	mov    %rsp,%rbp
 1d0:	48 83 ec 18          	sub    $0x18,%rsp
 1d4:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  int n;

  for(n = 0; s[n]; n++)
 1d8:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
 1df:	eb 04                	jmp    1e5 <strlen+0x19>
 1e1:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
 1e5:	8b 45 fc             	mov    -0x4(%rbp),%eax
 1e8:	48 63 d0             	movslq %eax,%rdx
 1eb:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 1ef:	48 01 d0             	add    %rdx,%rax
 1f2:	0f b6 00             	movzbl (%rax),%eax
 1f5:	84 c0                	test   %al,%al
 1f7:	75 e8                	jne    1e1 <strlen+0x15>
    ;
  return n;
 1f9:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
 1fc:	c9                   	leave
 1fd:	c3                   	ret

00000000000001fe <memset>:

void*
memset(void *dst, int c, uint n)
{
 1fe:	55                   	push   %rbp
 1ff:	48 89 e5             	mov    %rsp,%rbp
 202:	48 83 ec 10          	sub    $0x10,%rsp
 206:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
 20a:	89 75 f4             	mov    %esi,-0xc(%rbp)
 20d:	89 55 f0             	mov    %edx,-0x10(%rbp)
  stosb(dst, c, n);
 210:	8b 55 f0             	mov    -0x10(%rbp),%edx
 213:	8b 4d f4             	mov    -0xc(%rbp),%ecx
 216:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 21a:	89 ce                	mov    %ecx,%esi
 21c:	48 89 c7             	mov    %rax,%rdi
 21f:	e8 dc fe ff ff       	call   100 <stosb>
  return dst;
 224:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
 228:	c9                   	leave
 229:	c3                   	ret

000000000000022a <strchr>:

char*
strchr(const char *s, char c)
{
 22a:	55                   	push   %rbp
 22b:	48 89 e5             	mov    %rsp,%rbp
 22e:	48 83 ec 10          	sub    $0x10,%rsp
 232:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
 236:	89 f0                	mov    %esi,%eax
 238:	88 45 f4             	mov    %al,-0xc(%rbp)
  for(; *s; s++)
 23b:	eb 17                	jmp    254 <strchr+0x2a>
    if(*s == c)
 23d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 241:	0f b6 00             	movzbl (%rax),%eax
 244:	38 45 f4             	cmp    %al,-0xc(%rbp)
 247:	75 06                	jne    24f <strchr+0x25>
      return (char*)s;
 249:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 24d:	eb 15                	jmp    264 <strchr+0x3a>
  for(; *s; s++)
 24f:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
 254:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 258:	0f b6 00             	movzbl (%rax),%eax
 25b:	84 c0                	test   %al,%al
 25d:	75 de                	jne    23d <strchr+0x13>
  return 0;
 25f:	b8 00 00 00 00       	mov    $0x0,%eax
}
 264:	c9                   	leave
 265:	c3                   	ret

0000000000000266 <gets>:

char*
gets(char *buf, int max)
{
 266:	55                   	push   %rbp
 267:	48 89 e5             	mov    %rsp,%rbp
 26a:	48 83 ec 20          	sub    $0x20,%rsp
 26e:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
 272:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 275:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
 27c:	eb 48                	jmp    2c6 <gets+0x60>
    cc = read(0, &c, 1);
 27e:	48 8d 45 f7          	lea    -0x9(%rbp),%rax
 282:	ba 01 00 00 00       	mov    $0x1,%edx
 287:	48 89 c6             	mov    %rax,%rsi
 28a:	bf 00 00 00 00       	mov    $0x0,%edi
 28f:	e8 77 01 00 00       	call   40b <read>
 294:	89 45 f8             	mov    %eax,-0x8(%rbp)
    if(cc < 1)
 297:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
 29b:	7e 36                	jle    2d3 <gets+0x6d>
      break;
    buf[i++] = c;
 29d:	8b 45 fc             	mov    -0x4(%rbp),%eax
 2a0:	8d 50 01             	lea    0x1(%rax),%edx
 2a3:	89 55 fc             	mov    %edx,-0x4(%rbp)
 2a6:	48 63 d0             	movslq %eax,%rdx
 2a9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 2ad:	48 01 c2             	add    %rax,%rdx
 2b0:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
 2b4:	88 02                	mov    %al,(%rdx)
    if(c == '\n' || c == '\r')
 2b6:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
 2ba:	3c 0a                	cmp    $0xa,%al
 2bc:	74 16                	je     2d4 <gets+0x6e>
 2be:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
 2c2:	3c 0d                	cmp    $0xd,%al
 2c4:	74 0e                	je     2d4 <gets+0x6e>
  for(i=0; i+1 < max; ){
 2c6:	8b 45 fc             	mov    -0x4(%rbp),%eax
 2c9:	83 c0 01             	add    $0x1,%eax
 2cc:	39 45 e4             	cmp    %eax,-0x1c(%rbp)
 2cf:	7f ad                	jg     27e <gets+0x18>
 2d1:	eb 01                	jmp    2d4 <gets+0x6e>
      break;
 2d3:	90                   	nop
      break;
  }
  buf[i] = '\0';
 2d4:	8b 45 fc             	mov    -0x4(%rbp),%eax
 2d7:	48 63 d0             	movslq %eax,%rdx
 2da:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 2de:	48 01 d0             	add    %rdx,%rax
 2e1:	c6 00 00             	movb   $0x0,(%rax)
  return buf;
 2e4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
 2e8:	c9                   	leave
 2e9:	c3                   	ret

00000000000002ea <stat>:

int
stat(char *n, struct stat *st)
{
 2ea:	55                   	push   %rbp
 2eb:	48 89 e5             	mov    %rsp,%rbp
 2ee:	48 83 ec 20          	sub    $0x20,%rsp
 2f2:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
 2f6:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 2fa:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 2fe:	be 00 00 00 00       	mov    $0x0,%esi
 303:	48 89 c7             	mov    %rax,%rdi
 306:	e8 28 01 00 00       	call   433 <open>
 30b:	89 45 fc             	mov    %eax,-0x4(%rbp)
  if(fd < 0)
 30e:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
 312:	79 07                	jns    31b <stat+0x31>
    return -1;
 314:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 319:	eb 21                	jmp    33c <stat+0x52>
  r = fstat(fd, st);
 31b:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
 31f:	8b 45 fc             	mov    -0x4(%rbp),%eax
 322:	48 89 d6             	mov    %rdx,%rsi
 325:	89 c7                	mov    %eax,%edi
 327:	e8 1f 01 00 00       	call   44b <fstat>
 32c:	89 45 f8             	mov    %eax,-0x8(%rbp)
  close(fd);
 32f:	8b 45 fc             	mov    -0x4(%rbp),%eax
 332:	89 c7                	mov    %eax,%edi
 334:	e8 e2 00 00 00       	call   41b <close>
  return r;
 339:	8b 45 f8             	mov    -0x8(%rbp),%eax
}
 33c:	c9                   	leave
 33d:	c3                   	ret

000000000000033e <atoi>:

int
atoi(const char *s)
{
 33e:	55                   	push   %rbp
 33f:	48 89 e5             	mov    %rsp,%rbp
 342:	48 83 ec 18          	sub    $0x18,%rsp
 346:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  int n;

  n = 0;
 34a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  while('0' <= *s && *s <= '9')
 351:	eb 28                	jmp    37b <atoi+0x3d>
    n = n*10 + *s++ - '0';
 353:	8b 55 fc             	mov    -0x4(%rbp),%edx
 356:	89 d0                	mov    %edx,%eax
 358:	c1 e0 02             	shl    $0x2,%eax
 35b:	01 d0                	add    %edx,%eax
 35d:	01 c0                	add    %eax,%eax
 35f:	89 c1                	mov    %eax,%ecx
 361:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 365:	48 8d 50 01          	lea    0x1(%rax),%rdx
 369:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
 36d:	0f b6 00             	movzbl (%rax),%eax
 370:	0f be c0             	movsbl %al,%eax
 373:	01 c8                	add    %ecx,%eax
 375:	83 e8 30             	sub    $0x30,%eax
 378:	89 45 fc             	mov    %eax,-0x4(%rbp)
  while('0' <= *s && *s <= '9')
 37b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 37f:	0f b6 00             	movzbl (%rax),%eax
 382:	3c 2f                	cmp    $0x2f,%al
 384:	7e 0b                	jle    391 <atoi+0x53>
 386:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 38a:	0f b6 00             	movzbl (%rax),%eax
 38d:	3c 39                	cmp    $0x39,%al
 38f:	7e c2                	jle    353 <atoi+0x15>
  return n;
 391:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
 394:	c9                   	leave
 395:	c3                   	ret

0000000000000396 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 396:	55                   	push   %rbp
 397:	48 89 e5             	mov    %rsp,%rbp
 39a:	48 83 ec 28          	sub    $0x28,%rsp
 39e:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
 3a2:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
 3a6:	89 55 dc             	mov    %edx,-0x24(%rbp)
  char *dst, *src;
  
  dst = vdst;
 3a9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 3ad:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  src = vsrc;
 3b1:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
 3b5:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  while(n-- > 0)
 3b9:	eb 1d                	jmp    3d8 <memmove+0x42>
    *dst++ = *src++;
 3bb:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
 3bf:	48 8d 42 01          	lea    0x1(%rdx),%rax
 3c3:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
 3c7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 3cb:	48 8d 48 01          	lea    0x1(%rax),%rcx
 3cf:	48 89 4d f8          	mov    %rcx,-0x8(%rbp)
 3d3:	0f b6 12             	movzbl (%rdx),%edx
 3d6:	88 10                	mov    %dl,(%rax)
  while(n-- > 0)
 3d8:	8b 45 dc             	mov    -0x24(%rbp),%eax
 3db:	8d 50 ff             	lea    -0x1(%rax),%edx
 3de:	89 55 dc             	mov    %edx,-0x24(%rbp)
 3e1:	85 c0                	test   %eax,%eax
 3e3:	7f d6                	jg     3bb <memmove+0x25>
  return vdst;
 3e5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
 3e9:	c9                   	leave
 3ea:	c3                   	ret

00000000000003eb <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 3eb:	b8 01 00 00 00       	mov    $0x1,%eax
 3f0:	cd 40                	int    $0x40
 3f2:	c3                   	ret

00000000000003f3 <exit>:
SYSCALL(exit)
 3f3:	b8 02 00 00 00       	mov    $0x2,%eax
 3f8:	cd 40                	int    $0x40
 3fa:	c3                   	ret

00000000000003fb <wait>:
SYSCALL(wait)
 3fb:	b8 03 00 00 00       	mov    $0x3,%eax
 400:	cd 40                	int    $0x40
 402:	c3                   	ret

0000000000000403 <pipe>:
SYSCALL(pipe)
 403:	b8 04 00 00 00       	mov    $0x4,%eax
 408:	cd 40                	int    $0x40
 40a:	c3                   	ret

000000000000040b <read>:
SYSCALL(read)
 40b:	b8 05 00 00 00       	mov    $0x5,%eax
 410:	cd 40                	int    $0x40
 412:	c3                   	ret

0000000000000413 <write>:
SYSCALL(write)
 413:	b8 10 00 00 00       	mov    $0x10,%eax
 418:	cd 40                	int    $0x40
 41a:	c3                   	ret

000000000000041b <close>:
SYSCALL(close)
 41b:	b8 15 00 00 00       	mov    $0x15,%eax
 420:	cd 40                	int    $0x40
 422:	c3                   	ret

0000000000000423 <kill>:
SYSCALL(kill)
 423:	b8 06 00 00 00       	mov    $0x6,%eax
 428:	cd 40                	int    $0x40
 42a:	c3                   	ret

000000000000042b <exec>:
SYSCALL(exec)
 42b:	b8 07 00 00 00       	mov    $0x7,%eax
 430:	cd 40                	int    $0x40
 432:	c3                   	ret

0000000000000433 <open>:
SYSCALL(open)
 433:	b8 0f 00 00 00       	mov    $0xf,%eax
 438:	cd 40                	int    $0x40
 43a:	c3                   	ret

000000000000043b <mknod>:
SYSCALL(mknod)
 43b:	b8 11 00 00 00       	mov    $0x11,%eax
 440:	cd 40                	int    $0x40
 442:	c3                   	ret

0000000000000443 <unlink>:
SYSCALL(unlink)
 443:	b8 12 00 00 00       	mov    $0x12,%eax
 448:	cd 40                	int    $0x40
 44a:	c3                   	ret

000000000000044b <fstat>:
SYSCALL(fstat)
 44b:	b8 08 00 00 00       	mov    $0x8,%eax
 450:	cd 40                	int    $0x40
 452:	c3                   	ret

0000000000000453 <link>:
SYSCALL(link)
 453:	b8 13 00 00 00       	mov    $0x13,%eax
 458:	cd 40                	int    $0x40
 45a:	c3                   	ret

000000000000045b <mkdir>:
SYSCALL(mkdir)
 45b:	b8 14 00 00 00       	mov    $0x14,%eax
 460:	cd 40                	int    $0x40
 462:	c3                   	ret

0000000000000463 <chdir>:
SYSCALL(chdir)
 463:	b8 09 00 00 00       	mov    $0x9,%eax
 468:	cd 40                	int    $0x40
 46a:	c3                   	ret

000000000000046b <dup>:
SYSCALL(dup)
 46b:	b8 0a 00 00 00       	mov    $0xa,%eax
 470:	cd 40                	int    $0x40
 472:	c3                   	ret

0000000000000473 <getpid>:
SYSCALL(getpid)
 473:	b8 0b 00 00 00       	mov    $0xb,%eax
 478:	cd 40                	int    $0x40
 47a:	c3                   	ret

000000000000047b <sbrk>:
SYSCALL(sbrk)
 47b:	b8 0c 00 00 00       	mov    $0xc,%eax
 480:	cd 40                	int    $0x40
 482:	c3                   	ret

0000000000000483 <sleep>:
SYSCALL(sleep)
 483:	b8 0d 00 00 00       	mov    $0xd,%eax
 488:	cd 40                	int    $0x40
 48a:	c3                   	ret

000000000000048b <uptime>:
SYSCALL(uptime)
 48b:	b8 0e 00 00 00       	mov    $0xe,%eax
 490:	cd 40                	int    $0x40
 492:	c3                   	ret

0000000000000493 <getpinfo>:
SYSCALL(getpinfo)
 493:	b8 18 00 00 00       	mov    $0x18,%eax
 498:	cd 40                	int    $0x40
 49a:	c3                   	ret

000000000000049b <getfavnum>:
SYSCALL(getfavnum)
 49b:	b8 19 00 00 00       	mov    $0x19,%eax
 4a0:	cd 40                	int    $0x40
 4a2:	c3                   	ret

00000000000004a3 <shutdown>:
SYSCALL(shutdown)
 4a3:	b8 1a 00 00 00       	mov    $0x1a,%eax
 4a8:	cd 40                	int    $0x40
 4aa:	c3                   	ret

00000000000004ab <getcount>:
SYSCALL(getcount)
 4ab:	b8 1b 00 00 00       	mov    $0x1b,%eax
 4b0:	cd 40                	int    $0x40
 4b2:	c3                   	ret

00000000000004b3 <killrandom>:
 4b3:	b8 1c 00 00 00       	mov    $0x1c,%eax
 4b8:	cd 40                	int    $0x40
 4ba:	c3                   	ret

00000000000004bb <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 4bb:	55                   	push   %rbp
 4bc:	48 89 e5             	mov    %rsp,%rbp
 4bf:	48 83 ec 10          	sub    $0x10,%rsp
 4c3:	89 7d fc             	mov    %edi,-0x4(%rbp)
 4c6:	89 f0                	mov    %esi,%eax
 4c8:	88 45 f8             	mov    %al,-0x8(%rbp)
  write(fd, &c, 1);
 4cb:	48 8d 4d f8          	lea    -0x8(%rbp),%rcx
 4cf:	8b 45 fc             	mov    -0x4(%rbp),%eax
 4d2:	ba 01 00 00 00       	mov    $0x1,%edx
 4d7:	48 89 ce             	mov    %rcx,%rsi
 4da:	89 c7                	mov    %eax,%edi
 4dc:	e8 32 ff ff ff       	call   413 <write>
}
 4e1:	90                   	nop
 4e2:	c9                   	leave
 4e3:	c3                   	ret

00000000000004e4 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 4e4:	55                   	push   %rbp
 4e5:	48 89 e5             	mov    %rsp,%rbp
 4e8:	48 83 ec 30          	sub    $0x30,%rsp
 4ec:	89 7d dc             	mov    %edi,-0x24(%rbp)
 4ef:	89 75 d8             	mov    %esi,-0x28(%rbp)
 4f2:	89 55 d4             	mov    %edx,-0x2c(%rbp)
 4f5:	89 4d d0             	mov    %ecx,-0x30(%rbp)
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 4f8:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
  if(sgn && xx < 0){
 4ff:	83 7d d0 00          	cmpl   $0x0,-0x30(%rbp)
 503:	74 17                	je     51c <printint+0x38>
 505:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
 509:	79 11                	jns    51c <printint+0x38>
    neg = 1;
 50b:	c7 45 f8 01 00 00 00 	movl   $0x1,-0x8(%rbp)
    x = -xx;
 512:	8b 45 d8             	mov    -0x28(%rbp),%eax
 515:	f7 d8                	neg    %eax
 517:	89 45 f4             	mov    %eax,-0xc(%rbp)
 51a:	eb 06                	jmp    522 <printint+0x3e>
  } else {
    x = xx;
 51c:	8b 45 d8             	mov    -0x28(%rbp),%eax
 51f:	89 45 f4             	mov    %eax,-0xc(%rbp)
  }

  i = 0;
 522:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  do{
    buf[i++] = digits[x % base];
 529:	8b 4d d4             	mov    -0x2c(%rbp),%ecx
 52c:	8b 45 f4             	mov    -0xc(%rbp),%eax
 52f:	ba 00 00 00 00       	mov    $0x0,%edx
 534:	f7 f1                	div    %ecx
 536:	89 d1                	mov    %edx,%ecx
 538:	8b 45 fc             	mov    -0x4(%rbp),%eax
 53b:	8d 50 01             	lea    0x1(%rax),%edx
 53e:	89 55 fc             	mov    %edx,-0x4(%rbp)
 541:	89 ca                	mov    %ecx,%edx
 543:	0f b6 92 e0 10 00 00 	movzbl 0x10e0(%rdx),%edx
 54a:	48 98                	cltq
 54c:	88 54 05 e0          	mov    %dl,-0x20(%rbp,%rax,1)
  }while((x /= base) != 0);
 550:	8b 75 d4             	mov    -0x2c(%rbp),%esi
 553:	8b 45 f4             	mov    -0xc(%rbp),%eax
 556:	ba 00 00 00 00       	mov    $0x0,%edx
 55b:	f7 f6                	div    %esi
 55d:	89 45 f4             	mov    %eax,-0xc(%rbp)
 560:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
 564:	75 c3                	jne    529 <printint+0x45>
  if(neg)
 566:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
 56a:	74 2b                	je     597 <printint+0xb3>
    buf[i++] = '-';
 56c:	8b 45 fc             	mov    -0x4(%rbp),%eax
 56f:	8d 50 01             	lea    0x1(%rax),%edx
 572:	89 55 fc             	mov    %edx,-0x4(%rbp)
 575:	48 98                	cltq
 577:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%rbp,%rax,1)

  while(--i >= 0)
 57c:	eb 19                	jmp    597 <printint+0xb3>
    putc(fd, buf[i]);
 57e:	8b 45 fc             	mov    -0x4(%rbp),%eax
 581:	48 98                	cltq
 583:	0f b6 44 05 e0       	movzbl -0x20(%rbp,%rax,1),%eax
 588:	0f be d0             	movsbl %al,%edx
 58b:	8b 45 dc             	mov    -0x24(%rbp),%eax
 58e:	89 d6                	mov    %edx,%esi
 590:	89 c7                	mov    %eax,%edi
 592:	e8 24 ff ff ff       	call   4bb <putc>
  while(--i >= 0)
 597:	83 6d fc 01          	subl   $0x1,-0x4(%rbp)
 59b:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
 59f:	79 dd                	jns    57e <printint+0x9a>
}
 5a1:	90                   	nop
 5a2:	90                   	nop
 5a3:	c9                   	leave
 5a4:	c3                   	ret

00000000000005a5 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 5a5:	55                   	push   %rbp
 5a6:	48 89 e5             	mov    %rsp,%rbp
 5a9:	48 81 ec f0 00 00 00 	sub    $0xf0,%rsp
 5b0:	89 bd 1c ff ff ff    	mov    %edi,-0xe4(%rbp)
 5b6:	48 89 b5 10 ff ff ff 	mov    %rsi,-0xf0(%rbp)
 5bd:	48 89 95 60 ff ff ff 	mov    %rdx,-0xa0(%rbp)
 5c4:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
 5cb:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
 5d2:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
 5d9:	84 c0                	test   %al,%al
 5db:	74 20                	je     5fd <printf+0x58>
 5dd:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
 5e1:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
 5e5:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
 5e9:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
 5ed:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
 5f1:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
 5f5:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
 5f9:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  va_list ap;
  char *s;
  int c, i, state;
  va_start(ap, fmt);
 5fd:	c7 85 20 ff ff ff 10 	movl   $0x10,-0xe0(%rbp)
 604:	00 00 00 
 607:	c7 85 24 ff ff ff 30 	movl   $0x30,-0xdc(%rbp)
 60e:	00 00 00 
 611:	48 8d 45 10          	lea    0x10(%rbp),%rax
 615:	48 89 85 28 ff ff ff 	mov    %rax,-0xd8(%rbp)
 61c:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
 623:	48 89 85 30 ff ff ff 	mov    %rax,-0xd0(%rbp)

  state = 0;
 62a:	c7 85 40 ff ff ff 00 	movl   $0x0,-0xc0(%rbp)
 631:	00 00 00 
  for(i = 0; fmt[i]; i++){
 634:	c7 85 44 ff ff ff 00 	movl   $0x0,-0xbc(%rbp)
 63b:	00 00 00 
 63e:	e9 a8 02 00 00       	jmp    8eb <printf+0x346>
    c = fmt[i] & 0xff;
 643:	8b 85 44 ff ff ff    	mov    -0xbc(%rbp),%eax
 649:	48 63 d0             	movslq %eax,%rdx
 64c:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
 653:	48 01 d0             	add    %rdx,%rax
 656:	0f b6 00             	movzbl (%rax),%eax
 659:	0f be c0             	movsbl %al,%eax
 65c:	25 ff 00 00 00       	and    $0xff,%eax
 661:	89 85 3c ff ff ff    	mov    %eax,-0xc4(%rbp)
    if(state == 0){
 667:	83 bd 40 ff ff ff 00 	cmpl   $0x0,-0xc0(%rbp)
 66e:	75 35                	jne    6a5 <printf+0x100>
      if(c == '%'){
 670:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
 677:	75 0f                	jne    688 <printf+0xe3>
        state = '%';
 679:	c7 85 40 ff ff ff 25 	movl   $0x25,-0xc0(%rbp)
 680:	00 00 00 
 683:	e9 5c 02 00 00       	jmp    8e4 <printf+0x33f>
      } else {
        putc(fd, c);
 688:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
 68e:	0f be d0             	movsbl %al,%edx
 691:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 697:	89 d6                	mov    %edx,%esi
 699:	89 c7                	mov    %eax,%edi
 69b:	e8 1b fe ff ff       	call   4bb <putc>
 6a0:	e9 3f 02 00 00       	jmp    8e4 <printf+0x33f>
      }
    } else if(state == '%'){
 6a5:	83 bd 40 ff ff ff 25 	cmpl   $0x25,-0xc0(%rbp)
 6ac:	0f 85 32 02 00 00    	jne    8e4 <printf+0x33f>
      if(c == 'd'){
 6b2:	83 bd 3c ff ff ff 64 	cmpl   $0x64,-0xc4(%rbp)
 6b9:	75 5e                	jne    719 <printf+0x174>
        printint(fd, va_arg(ap, int), 10, 1);
 6bb:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 6c1:	83 f8 2f             	cmp    $0x2f,%eax
 6c4:	77 23                	ja     6e9 <printf+0x144>
 6c6:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 6cd:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 6d3:	89 d2                	mov    %edx,%edx
 6d5:	48 01 d0             	add    %rdx,%rax
 6d8:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 6de:	83 c2 08             	add    $0x8,%edx
 6e1:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 6e7:	eb 12                	jmp    6fb <printf+0x156>
 6e9:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 6f0:	48 8d 50 08          	lea    0x8(%rax),%rdx
 6f4:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 6fb:	8b 30                	mov    (%rax),%esi
 6fd:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 703:	b9 01 00 00 00       	mov    $0x1,%ecx
 708:	ba 0a 00 00 00       	mov    $0xa,%edx
 70d:	89 c7                	mov    %eax,%edi
 70f:	e8 d0 fd ff ff       	call   4e4 <printint>
 714:	e9 c1 01 00 00       	jmp    8da <printf+0x335>
      } else if(c == 'x' || c == 'p'){
 719:	83 bd 3c ff ff ff 78 	cmpl   $0x78,-0xc4(%rbp)
 720:	74 09                	je     72b <printf+0x186>
 722:	83 bd 3c ff ff ff 70 	cmpl   $0x70,-0xc4(%rbp)
 729:	75 5e                	jne    789 <printf+0x1e4>
        printint(fd, va_arg(ap, int), 16, 0);
 72b:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 731:	83 f8 2f             	cmp    $0x2f,%eax
 734:	77 23                	ja     759 <printf+0x1b4>
 736:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 73d:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 743:	89 d2                	mov    %edx,%edx
 745:	48 01 d0             	add    %rdx,%rax
 748:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 74e:	83 c2 08             	add    $0x8,%edx
 751:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 757:	eb 12                	jmp    76b <printf+0x1c6>
 759:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 760:	48 8d 50 08          	lea    0x8(%rax),%rdx
 764:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 76b:	8b 30                	mov    (%rax),%esi
 76d:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 773:	b9 00 00 00 00       	mov    $0x0,%ecx
 778:	ba 10 00 00 00       	mov    $0x10,%edx
 77d:	89 c7                	mov    %eax,%edi
 77f:	e8 60 fd ff ff       	call   4e4 <printint>
 784:	e9 51 01 00 00       	jmp    8da <printf+0x335>
      } else if(c == 's'){
 789:	83 bd 3c ff ff ff 73 	cmpl   $0x73,-0xc4(%rbp)
 790:	0f 85 98 00 00 00    	jne    82e <printf+0x289>
        s = va_arg(ap, char*);
 796:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 79c:	83 f8 2f             	cmp    $0x2f,%eax
 79f:	77 23                	ja     7c4 <printf+0x21f>
 7a1:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 7a8:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 7ae:	89 d2                	mov    %edx,%edx
 7b0:	48 01 d0             	add    %rdx,%rax
 7b3:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 7b9:	83 c2 08             	add    $0x8,%edx
 7bc:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 7c2:	eb 12                	jmp    7d6 <printf+0x231>
 7c4:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 7cb:	48 8d 50 08          	lea    0x8(%rax),%rdx
 7cf:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 7d6:	48 8b 00             	mov    (%rax),%rax
 7d9:	48 89 85 48 ff ff ff 	mov    %rax,-0xb8(%rbp)
        if(s == 0)
 7e0:	48 83 bd 48 ff ff ff 	cmpq   $0x0,-0xb8(%rbp)
 7e7:	00 
 7e8:	75 31                	jne    81b <printf+0x276>
          s = "(null)";
 7ea:	48 c7 85 48 ff ff ff 	movq   $0xde7,-0xb8(%rbp)
 7f1:	e7 0d 00 00 
        while(*s != 0){
 7f5:	eb 24                	jmp    81b <printf+0x276>
          putc(fd, *s);
 7f7:	48 8b 85 48 ff ff ff 	mov    -0xb8(%rbp),%rax
 7fe:	0f b6 00             	movzbl (%rax),%eax
 801:	0f be d0             	movsbl %al,%edx
 804:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 80a:	89 d6                	mov    %edx,%esi
 80c:	89 c7                	mov    %eax,%edi
 80e:	e8 a8 fc ff ff       	call   4bb <putc>
          s++;
 813:	48 83 85 48 ff ff ff 	addq   $0x1,-0xb8(%rbp)
 81a:	01 
        while(*s != 0){
 81b:	48 8b 85 48 ff ff ff 	mov    -0xb8(%rbp),%rax
 822:	0f b6 00             	movzbl (%rax),%eax
 825:	84 c0                	test   %al,%al
 827:	75 ce                	jne    7f7 <printf+0x252>
 829:	e9 ac 00 00 00       	jmp    8da <printf+0x335>
        }
      } else if(c == 'c'){
 82e:	83 bd 3c ff ff ff 63 	cmpl   $0x63,-0xc4(%rbp)
 835:	75 56                	jne    88d <printf+0x2e8>
        putc(fd, va_arg(ap, uint));
 837:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 83d:	83 f8 2f             	cmp    $0x2f,%eax
 840:	77 23                	ja     865 <printf+0x2c0>
 842:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 849:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 84f:	89 d2                	mov    %edx,%edx
 851:	48 01 d0             	add    %rdx,%rax
 854:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 85a:	83 c2 08             	add    $0x8,%edx
 85d:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 863:	eb 12                	jmp    877 <printf+0x2d2>
 865:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 86c:	48 8d 50 08          	lea    0x8(%rax),%rdx
 870:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 877:	8b 00                	mov    (%rax),%eax
 879:	0f be d0             	movsbl %al,%edx
 87c:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 882:	89 d6                	mov    %edx,%esi
 884:	89 c7                	mov    %eax,%edi
 886:	e8 30 fc ff ff       	call   4bb <putc>
 88b:	eb 4d                	jmp    8da <printf+0x335>
      } else if(c == '%'){
 88d:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
 894:	75 1a                	jne    8b0 <printf+0x30b>
        putc(fd, c);
 896:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
 89c:	0f be d0             	movsbl %al,%edx
 89f:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 8a5:	89 d6                	mov    %edx,%esi
 8a7:	89 c7                	mov    %eax,%edi
 8a9:	e8 0d fc ff ff       	call   4bb <putc>
 8ae:	eb 2a                	jmp    8da <printf+0x335>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 8b0:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 8b6:	be 25 00 00 00       	mov    $0x25,%esi
 8bb:	89 c7                	mov    %eax,%edi
 8bd:	e8 f9 fb ff ff       	call   4bb <putc>
        putc(fd, c);
 8c2:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
 8c8:	0f be d0             	movsbl %al,%edx
 8cb:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 8d1:	89 d6                	mov    %edx,%esi
 8d3:	89 c7                	mov    %eax,%edi
 8d5:	e8 e1 fb ff ff       	call   4bb <putc>
      }
      state = 0;
 8da:	c7 85 40 ff ff ff 00 	movl   $0x0,-0xc0(%rbp)
 8e1:	00 00 00 
  for(i = 0; fmt[i]; i++){
 8e4:	83 85 44 ff ff ff 01 	addl   $0x1,-0xbc(%rbp)
 8eb:	8b 85 44 ff ff ff    	mov    -0xbc(%rbp),%eax
 8f1:	48 63 d0             	movslq %eax,%rdx
 8f4:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
 8fb:	48 01 d0             	add    %rdx,%rax
 8fe:	0f b6 00             	movzbl (%rax),%eax
 901:	84 c0                	test   %al,%al
 903:	0f 85 3a fd ff ff    	jne    643 <printf+0x9e>
    }
  }
}
 909:	90                   	nop
 90a:	90                   	nop
 90b:	c9                   	leave
 90c:	c3                   	ret

000000000000090d <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 90d:	55                   	push   %rbp
 90e:	48 89 e5             	mov    %rsp,%rbp
 911:	48 83 ec 18          	sub    $0x18,%rsp
 915:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  Header *bp, *p;

  bp = (Header*)ap - 1;
 919:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 91d:	48 83 e8 10          	sub    $0x10,%rax
 921:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 925:	48 8b 05 e4 07 00 00 	mov    0x7e4(%rip),%rax        # 1110 <freep>
 92c:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 930:	eb 2f                	jmp    961 <free+0x54>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 932:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 936:	48 8b 00             	mov    (%rax),%rax
 939:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 93d:	72 17                	jb     956 <free+0x49>
 93f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 943:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 947:	72 2f                	jb     978 <free+0x6b>
 949:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 94d:	48 8b 00             	mov    (%rax),%rax
 950:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
 954:	72 22                	jb     978 <free+0x6b>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 956:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 95a:	48 8b 00             	mov    (%rax),%rax
 95d:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 961:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 965:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 969:	73 c7                	jae    932 <free+0x25>
 96b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 96f:	48 8b 00             	mov    (%rax),%rax
 972:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
 976:	73 ba                	jae    932 <free+0x25>
      break;
  if(bp + bp->s.size == p->s.ptr){
 978:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 97c:	8b 40 08             	mov    0x8(%rax),%eax
 97f:	89 c0                	mov    %eax,%eax
 981:	48 c1 e0 04          	shl    $0x4,%rax
 985:	48 89 c2             	mov    %rax,%rdx
 988:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 98c:	48 01 c2             	add    %rax,%rdx
 98f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 993:	48 8b 00             	mov    (%rax),%rax
 996:	48 39 c2             	cmp    %rax,%rdx
 999:	75 2d                	jne    9c8 <free+0xbb>
    bp->s.size += p->s.ptr->s.size;
 99b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 99f:	8b 50 08             	mov    0x8(%rax),%edx
 9a2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 9a6:	48 8b 00             	mov    (%rax),%rax
 9a9:	8b 40 08             	mov    0x8(%rax),%eax
 9ac:	01 c2                	add    %eax,%edx
 9ae:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 9b2:	89 50 08             	mov    %edx,0x8(%rax)
    bp->s.ptr = p->s.ptr->s.ptr;
 9b5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 9b9:	48 8b 00             	mov    (%rax),%rax
 9bc:	48 8b 10             	mov    (%rax),%rdx
 9bf:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 9c3:	48 89 10             	mov    %rdx,(%rax)
 9c6:	eb 0e                	jmp    9d6 <free+0xc9>
  } else
    bp->s.ptr = p->s.ptr;
 9c8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 9cc:	48 8b 10             	mov    (%rax),%rdx
 9cf:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 9d3:	48 89 10             	mov    %rdx,(%rax)
  if(p + p->s.size == bp){
 9d6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 9da:	8b 40 08             	mov    0x8(%rax),%eax
 9dd:	89 c0                	mov    %eax,%eax
 9df:	48 c1 e0 04          	shl    $0x4,%rax
 9e3:	48 89 c2             	mov    %rax,%rdx
 9e6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 9ea:	48 01 d0             	add    %rdx,%rax
 9ed:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
 9f1:	75 27                	jne    a1a <free+0x10d>
    p->s.size += bp->s.size;
 9f3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 9f7:	8b 50 08             	mov    0x8(%rax),%edx
 9fa:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 9fe:	8b 40 08             	mov    0x8(%rax),%eax
 a01:	01 c2                	add    %eax,%edx
 a03:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a07:	89 50 08             	mov    %edx,0x8(%rax)
    p->s.ptr = bp->s.ptr;
 a0a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 a0e:	48 8b 10             	mov    (%rax),%rdx
 a11:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a15:	48 89 10             	mov    %rdx,(%rax)
 a18:	eb 0b                	jmp    a25 <free+0x118>
  } else
    p->s.ptr = bp;
 a1a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a1e:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
 a22:	48 89 10             	mov    %rdx,(%rax)
  freep = p;
 a25:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a29:	48 89 05 e0 06 00 00 	mov    %rax,0x6e0(%rip)        # 1110 <freep>
}
 a30:	90                   	nop
 a31:	c9                   	leave
 a32:	c3                   	ret

0000000000000a33 <morecore>:

static Header*
morecore(uint nu)
{
 a33:	55                   	push   %rbp
 a34:	48 89 e5             	mov    %rsp,%rbp
 a37:	48 83 ec 20          	sub    $0x20,%rsp
 a3b:	89 7d ec             	mov    %edi,-0x14(%rbp)
  char *p;
  Header *hp;

  if(nu < 4096)
 a3e:	81 7d ec ff 0f 00 00 	cmpl   $0xfff,-0x14(%rbp)
 a45:	77 07                	ja     a4e <morecore+0x1b>
    nu = 4096;
 a47:	c7 45 ec 00 10 00 00 	movl   $0x1000,-0x14(%rbp)
  p = sbrk(nu * sizeof(Header));
 a4e:	8b 45 ec             	mov    -0x14(%rbp),%eax
 a51:	c1 e0 04             	shl    $0x4,%eax
 a54:	89 c7                	mov    %eax,%edi
 a56:	e8 20 fa ff ff       	call   47b <sbrk>
 a5b:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  if(p == (char*)-1)
 a5f:	48 83 7d f8 ff       	cmpq   $0xffffffffffffffff,-0x8(%rbp)
 a64:	75 07                	jne    a6d <morecore+0x3a>
    return 0;
 a66:	b8 00 00 00 00       	mov    $0x0,%eax
 a6b:	eb 29                	jmp    a96 <morecore+0x63>
  hp = (Header*)p;
 a6d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a71:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  hp->s.size = nu;
 a75:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 a79:	8b 55 ec             	mov    -0x14(%rbp),%edx
 a7c:	89 50 08             	mov    %edx,0x8(%rax)
  free((void*)(hp + 1));
 a7f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 a83:	48 83 c0 10          	add    $0x10,%rax
 a87:	48 89 c7             	mov    %rax,%rdi
 a8a:	e8 7e fe ff ff       	call   90d <free>
  return freep;
 a8f:	48 8b 05 7a 06 00 00 	mov    0x67a(%rip),%rax        # 1110 <freep>
}
 a96:	c9                   	leave
 a97:	c3                   	ret

0000000000000a98 <malloc>:

void*
malloc(uint nbytes)
{
 a98:	55                   	push   %rbp
 a99:	48 89 e5             	mov    %rsp,%rbp
 a9c:	48 83 ec 30          	sub    $0x30,%rsp
 aa0:	89 7d dc             	mov    %edi,-0x24(%rbp)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 aa3:	8b 45 dc             	mov    -0x24(%rbp),%eax
 aa6:	48 83 c0 0f          	add    $0xf,%rax
 aaa:	48 c1 e8 04          	shr    $0x4,%rax
 aae:	83 c0 01             	add    $0x1,%eax
 ab1:	89 45 ec             	mov    %eax,-0x14(%rbp)
  if((prevp = freep) == 0){
 ab4:	48 8b 05 55 06 00 00 	mov    0x655(%rip),%rax        # 1110 <freep>
 abb:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
 abf:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
 ac4:	75 2b                	jne    af1 <malloc+0x59>
    base.s.ptr = freep = prevp = &base;
 ac6:	48 c7 45 f0 00 11 00 	movq   $0x1100,-0x10(%rbp)
 acd:	00 
 ace:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 ad2:	48 89 05 37 06 00 00 	mov    %rax,0x637(%rip)        # 1110 <freep>
 ad9:	48 8b 05 30 06 00 00 	mov    0x630(%rip),%rax        # 1110 <freep>
 ae0:	48 89 05 19 06 00 00 	mov    %rax,0x619(%rip)        # 1100 <base>
    base.s.size = 0;
 ae7:	c7 05 17 06 00 00 00 	movl   $0x0,0x617(%rip)        # 1108 <base+0x8>
 aee:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 af1:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 af5:	48 8b 00             	mov    (%rax),%rax
 af8:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
 afc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b00:	8b 40 08             	mov    0x8(%rax),%eax
 b03:	3b 45 ec             	cmp    -0x14(%rbp),%eax
 b06:	72 5f                	jb     b67 <malloc+0xcf>
      if(p->s.size == nunits)
 b08:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b0c:	8b 40 08             	mov    0x8(%rax),%eax
 b0f:	39 45 ec             	cmp    %eax,-0x14(%rbp)
 b12:	75 10                	jne    b24 <malloc+0x8c>
        prevp->s.ptr = p->s.ptr;
 b14:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b18:	48 8b 10             	mov    (%rax),%rdx
 b1b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 b1f:	48 89 10             	mov    %rdx,(%rax)
 b22:	eb 2e                	jmp    b52 <malloc+0xba>
      else {
        p->s.size -= nunits;
 b24:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b28:	8b 40 08             	mov    0x8(%rax),%eax
 b2b:	2b 45 ec             	sub    -0x14(%rbp),%eax
 b2e:	89 c2                	mov    %eax,%edx
 b30:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b34:	89 50 08             	mov    %edx,0x8(%rax)
        p += p->s.size;
 b37:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b3b:	8b 40 08             	mov    0x8(%rax),%eax
 b3e:	89 c0                	mov    %eax,%eax
 b40:	48 c1 e0 04          	shl    $0x4,%rax
 b44:	48 01 45 f8          	add    %rax,-0x8(%rbp)
        p->s.size = nunits;
 b48:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b4c:	8b 55 ec             	mov    -0x14(%rbp),%edx
 b4f:	89 50 08             	mov    %edx,0x8(%rax)
      }
      freep = prevp;
 b52:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 b56:	48 89 05 b3 05 00 00 	mov    %rax,0x5b3(%rip)        # 1110 <freep>
      return (void*)(p + 1);
 b5d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b61:	48 83 c0 10          	add    $0x10,%rax
 b65:	eb 41                	jmp    ba8 <malloc+0x110>
    }
    if(p == freep)
 b67:	48 8b 05 a2 05 00 00 	mov    0x5a2(%rip),%rax        # 1110 <freep>
 b6e:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 b72:	75 1c                	jne    b90 <malloc+0xf8>
      if((p = morecore(nunits)) == 0)
 b74:	8b 45 ec             	mov    -0x14(%rbp),%eax
 b77:	89 c7                	mov    %eax,%edi
 b79:	e8 b5 fe ff ff       	call   a33 <morecore>
 b7e:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 b82:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
 b87:	75 07                	jne    b90 <malloc+0xf8>
        return 0;
 b89:	b8 00 00 00 00       	mov    $0x0,%eax
 b8e:	eb 18                	jmp    ba8 <malloc+0x110>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 b90:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b94:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
 b98:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b9c:	48 8b 00             	mov    (%rax),%rax
 b9f:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
 ba3:	e9 54 ff ff ff       	jmp    afc <malloc+0x64>
  }
}
 ba8:	c9                   	leave
 ba9:	c3                   	ret

0000000000000baa <createRoot>:
#include "set.h"
#include "user.h"

//TODO: Να μην είναι περιορισμένο σε int

Set* createRoot(){
 baa:	55                   	push   %rbp
 bab:	48 89 e5             	mov    %rsp,%rbp
 bae:	48 83 ec 10          	sub    $0x10,%rsp
    //Αρχικοποίηση του Set
    Set *set = malloc(sizeof(Set));
 bb2:	bf 10 00 00 00       	mov    $0x10,%edi
 bb7:	e8 dc fe ff ff       	call   a98 <malloc>
 bbc:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    set->size = 0;
 bc0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 bc4:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%rax)
    set->root = NULL;
 bcb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 bcf:	48 c7 00 00 00 00 00 	movq   $0x0,(%rax)
    return set;
 bd6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
 bda:	c9                   	leave
 bdb:	c3                   	ret

0000000000000bdc <createNode>:

void createNode(int i, Set *set){
 bdc:	55                   	push   %rbp
 bdd:	48 89 e5             	mov    %rsp,%rbp
 be0:	48 83 ec 20          	sub    $0x20,%rsp
 be4:	89 7d ec             	mov    %edi,-0x14(%rbp)
 be7:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    Η συνάρτηση αυτή δημιουργεί ένα νέο SetNode με την τιμή i και εφόσον δεν υπάρχει στο Set το προσθέτει στο τέλος του συνόλου.
    Σημείωση: Ίσως υπάρχει καλύτερος τρόπος για την υλοποίηση.
    */

    //Αρχικοποίηση του SetNode
    SetNode *temp = malloc(sizeof(SetNode));
 beb:	bf 10 00 00 00       	mov    $0x10,%edi
 bf0:	e8 a3 fe ff ff       	call   a98 <malloc>
 bf5:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    temp->i = i;
 bf9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 bfd:	8b 55 ec             	mov    -0x14(%rbp),%edx
 c00:	89 10                	mov    %edx,(%rax)
    temp->next = NULL;
 c02:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 c06:	48 c7 40 08 00 00 00 	movq   $0x0,0x8(%rax)
 c0d:	00 

    //Έλεγχος ύπαρξης του i
    SetNode *curr = set->root;//Ξεκινάει από την root
 c0e:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
 c12:	48 8b 00             	mov    (%rax),%rax
 c15:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(curr != NULL) { //Εφόσον το Set δεν είναι άδειο
 c19:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
 c1e:	74 34                	je     c54 <createNode+0x78>
        while (curr->next != NULL){ //Εφόσον υπάρχει επόμενο node
 c20:	eb 25                	jmp    c47 <createNode+0x6b>
            if (curr->i == i){ //Αν το i υπάρχει στο σύνολο
 c22:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 c26:	8b 00                	mov    (%rax),%eax
 c28:	39 45 ec             	cmp    %eax,-0x14(%rbp)
 c2b:	75 0e                	jne    c3b <createNode+0x5f>
                free(temp); 
 c2d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 c31:	48 89 c7             	mov    %rax,%rdi
 c34:	e8 d4 fc ff ff       	call   90d <free>
                return; //Δεν εκτελούμε την υπόλοιπη συνάρτηση
 c39:	eb 4e                	jmp    c89 <createNode+0xad>
            }
            curr = curr->next; //Επόμενο SetNode
 c3b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 c3f:	48 8b 40 08          	mov    0x8(%rax),%rax
 c43:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
        while (curr->next != NULL){ //Εφόσον υπάρχει επόμενο node
 c47:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 c4b:	48 8b 40 08          	mov    0x8(%rax),%rax
 c4f:	48 85 c0             	test   %rax,%rax
 c52:	75 ce                	jne    c22 <createNode+0x46>
        }
    }
    /*
    Ο έλεγχος στην if είναι απαραίτητος για να ελεγχθεί το τελευταίο SetNode.
    */
    if (curr->i != i) attachNode(set, curr, temp); 
 c54:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 c58:	8b 00                	mov    (%rax),%eax
 c5a:	39 45 ec             	cmp    %eax,-0x14(%rbp)
 c5d:	74 1e                	je     c7d <createNode+0xa1>
 c5f:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
 c63:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
 c67:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
 c6b:	48 89 ce             	mov    %rcx,%rsi
 c6e:	48 89 c7             	mov    %rax,%rdi
 c71:	b8 00 00 00 00       	mov    $0x0,%eax
 c76:	e8 10 00 00 00       	call   c8b <attachNode>
 c7b:	eb 0c                	jmp    c89 <createNode+0xad>
    else free(temp);
 c7d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 c81:	48 89 c7             	mov    %rax,%rdi
 c84:	e8 84 fc ff ff       	call   90d <free>
}
 c89:	c9                   	leave
 c8a:	c3                   	ret

0000000000000c8b <attachNode>:

void attachNode(Set *set, SetNode *curr, SetNode *temp){
 c8b:	55                   	push   %rbp
 c8c:	48 89 e5             	mov    %rsp,%rbp
 c8f:	48 83 ec 18          	sub    $0x18,%rsp
 c93:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
 c97:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
 c9b:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
    //Βάζουμε το temp στο τέλος του Set
    if(set->size == 0) set->root = temp;
 c9f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 ca3:	8b 40 08             	mov    0x8(%rax),%eax
 ca6:	85 c0                	test   %eax,%eax
 ca8:	75 0d                	jne    cb7 <attachNode+0x2c>
 caa:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 cae:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
 cb2:	48 89 10             	mov    %rdx,(%rax)
 cb5:	eb 0c                	jmp    cc3 <attachNode+0x38>
    else curr->next = temp;
 cb7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 cbb:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
 cbf:	48 89 50 08          	mov    %rdx,0x8(%rax)
    set->size += 1;
 cc3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 cc7:	8b 40 08             	mov    0x8(%rax),%eax
 cca:	8d 50 01             	lea    0x1(%rax),%edx
 ccd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 cd1:	89 50 08             	mov    %edx,0x8(%rax)
}
 cd4:	90                   	nop
 cd5:	c9                   	leave
 cd6:	c3                   	ret

0000000000000cd7 <deleteSet>:

void deleteSet(Set *set){
 cd7:	55                   	push   %rbp
 cd8:	48 89 e5             	mov    %rsp,%rbp
 cdb:	48 83 ec 20          	sub    $0x20,%rsp
 cdf:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    if (set == NULL) return; //Αν ο χρήστης είναι ΜΛΚ!
 ce3:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
 ce8:	74 42                	je     d2c <deleteSet+0x55>
    SetNode *temp;
    SetNode *curr = set->root; //Ξεκινάμε από το root
 cea:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 cee:	48 8b 00             	mov    (%rax),%rax
 cf1:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    while (curr != NULL){ 
 cf5:	eb 20                	jmp    d17 <deleteSet+0x40>
        temp = curr->next; //Αναφορά στο επόμενο SetNode
 cf7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 cfb:	48 8b 40 08          	mov    0x8(%rax),%rax
 cff:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
        free(curr); //Απελευθέρωση της curr
 d03:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 d07:	48 89 c7             	mov    %rax,%rdi
 d0a:	e8 fe fb ff ff       	call   90d <free>
        curr = temp;
 d0f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 d13:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    while (curr != NULL){ 
 d17:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
 d1c:	75 d9                	jne    cf7 <deleteSet+0x20>
    }
    free(set); //Διαγραφή του Set
 d1e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 d22:	48 89 c7             	mov    %rax,%rdi
 d25:	e8 e3 fb ff ff       	call   90d <free>
 d2a:	eb 01                	jmp    d2d <deleteSet+0x56>
    if (set == NULL) return; //Αν ο χρήστης είναι ΜΛΚ!
 d2c:	90                   	nop
}
 d2d:	c9                   	leave
 d2e:	c3                   	ret

0000000000000d2f <getNodeAtPosition>:

SetNode* getNodeAtPosition(Set *set, int i){
 d2f:	55                   	push   %rbp
 d30:	48 89 e5             	mov    %rsp,%rbp
 d33:	48 83 ec 20          	sub    $0x20,%rsp
 d37:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
 d3b:	89 75 e4             	mov    %esi,-0x1c(%rbp)
    if (set == NULL || set->root == NULL) return NULL; //Αν ο χρήστης είναι ΜΛΚ!
 d3e:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
 d43:	74 0c                	je     d51 <getNodeAtPosition+0x22>
 d45:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 d49:	48 8b 00             	mov    (%rax),%rax
 d4c:	48 85 c0             	test   %rax,%rax
 d4f:	75 07                	jne    d58 <getNodeAtPosition+0x29>
 d51:	b8 00 00 00 00       	mov    $0x0,%eax
 d56:	eb 3d                	jmp    d95 <getNodeAtPosition+0x66>

    SetNode *curr = set->root;
 d58:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 d5c:	48 8b 00             	mov    (%rax),%rax
 d5f:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    int n;

    for(n = 0; n<i && curr->next != NULL; n++) curr = curr->next; //Ο έλεγχος εδω είναι: n<i && curr->next != NULL
 d63:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
 d6a:	eb 10                	jmp    d7c <getNodeAtPosition+0x4d>
 d6c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 d70:	48 8b 40 08          	mov    0x8(%rax),%rax
 d74:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 d78:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
 d7c:	8b 45 f4             	mov    -0xc(%rbp),%eax
 d7f:	3b 45 e4             	cmp    -0x1c(%rbp),%eax
 d82:	7d 0d                	jge    d91 <getNodeAtPosition+0x62>
 d84:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 d88:	48 8b 40 08          	mov    0x8(%rax),%rax
 d8c:	48 85 c0             	test   %rax,%rax
 d8f:	75 db                	jne    d6c <getNodeAtPosition+0x3d>
    return curr;
 d91:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 d95:	c9                   	leave
 d96:	c3                   	ret
