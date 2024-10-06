
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
   d:	48 c7 c7 8d 0b 00 00 	mov    $0xb8d,%rdi
  14:	e8 1a 04 00 00       	call   433 <open>
  19:	85 c0                	test   %eax,%eax
  1b:	79 27                	jns    44 <main+0x44>
    mknod("console", 1, 1);
  1d:	ba 01 00 00 00       	mov    $0x1,%edx
  22:	be 01 00 00 00       	mov    $0x1,%esi
  27:	48 c7 c7 8d 0b 00 00 	mov    $0xb8d,%rdi
  2e:	e8 08 04 00 00       	call   43b <mknod>
    open("console", O_RDWR);
  33:	be 02 00 00 00       	mov    $0x2,%esi
  38:	48 c7 c7 8d 0b 00 00 	mov    $0xb8d,%rdi
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
  58:	48 c7 c6 95 0b 00 00 	mov    $0xb95,%rsi
  5f:	bf 01 00 00 00       	mov    $0x1,%edi
  64:	b8 00 00 00 00       	mov    $0x0,%eax
  69:	e8 17 05 00 00       	call   585 <printf>
    pid = fork();
  6e:	e8 78 03 00 00       	call   3eb <fork>
  73:	89 45 fc             	mov    %eax,-0x4(%rbp)
    if(pid < 0){
  76:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  7a:	79 1b                	jns    97 <main+0x97>
      printf(1, "init: fork failed\n");
  7c:	48 c7 c6 a8 0b 00 00 	mov    $0xba8,%rsi
  83:	bf 01 00 00 00       	mov    $0x1,%edi
  88:	b8 00 00 00 00       	mov    $0x0,%eax
  8d:	e8 f3 04 00 00       	call   585 <printf>
      exit();
  92:	e8 5c 03 00 00       	call   3f3 <exit>
    }
    if(pid == 0){
  97:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  9b:	75 44                	jne    e1 <main+0xe1>
      exec("sh", argv);
  9d:	48 c7 c6 20 0e 00 00 	mov    $0xe20,%rsi
  a4:	48 c7 c7 8a 0b 00 00 	mov    $0xb8a,%rdi
  ab:	e8 7b 03 00 00       	call   42b <exec>
      printf(1, "init: exec sh failed\n");
  b0:	48 c7 c6 bb 0b 00 00 	mov    $0xbbb,%rsi
  b7:	bf 01 00 00 00       	mov    $0x1,%edi
  bc:	b8 00 00 00 00       	mov    $0x0,%eax
  c1:	e8 bf 04 00 00       	call   585 <printf>
      exit();
  c6:	e8 28 03 00 00       	call   3f3 <exit>
    }
    while((wpid=wait()) >= 0 && wpid != pid)
      printf(1, "zombie!\n");
  cb:	48 c7 c6 d1 0b 00 00 	mov    $0xbd1,%rsi
  d2:	bf 01 00 00 00       	mov    $0x1,%edi
  d7:	b8 00 00 00 00       	mov    $0x0,%eax
  dc:	e8 a4 04 00 00       	call   585 <printf>
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

000000000000049b <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 49b:	55                   	push   %rbp
 49c:	48 89 e5             	mov    %rsp,%rbp
 49f:	48 83 ec 10          	sub    $0x10,%rsp
 4a3:	89 7d fc             	mov    %edi,-0x4(%rbp)
 4a6:	89 f0                	mov    %esi,%eax
 4a8:	88 45 f8             	mov    %al,-0x8(%rbp)
  write(fd, &c, 1);
 4ab:	48 8d 4d f8          	lea    -0x8(%rbp),%rcx
 4af:	8b 45 fc             	mov    -0x4(%rbp),%eax
 4b2:	ba 01 00 00 00       	mov    $0x1,%edx
 4b7:	48 89 ce             	mov    %rcx,%rsi
 4ba:	89 c7                	mov    %eax,%edi
 4bc:	e8 52 ff ff ff       	call   413 <write>
}
 4c1:	90                   	nop
 4c2:	c9                   	leave
 4c3:	c3                   	ret

00000000000004c4 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 4c4:	55                   	push   %rbp
 4c5:	48 89 e5             	mov    %rsp,%rbp
 4c8:	48 83 ec 30          	sub    $0x30,%rsp
 4cc:	89 7d dc             	mov    %edi,-0x24(%rbp)
 4cf:	89 75 d8             	mov    %esi,-0x28(%rbp)
 4d2:	89 55 d4             	mov    %edx,-0x2c(%rbp)
 4d5:	89 4d d0             	mov    %ecx,-0x30(%rbp)
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 4d8:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
  if(sgn && xx < 0){
 4df:	83 7d d0 00          	cmpl   $0x0,-0x30(%rbp)
 4e3:	74 17                	je     4fc <printint+0x38>
 4e5:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
 4e9:	79 11                	jns    4fc <printint+0x38>
    neg = 1;
 4eb:	c7 45 f8 01 00 00 00 	movl   $0x1,-0x8(%rbp)
    x = -xx;
 4f2:	8b 45 d8             	mov    -0x28(%rbp),%eax
 4f5:	f7 d8                	neg    %eax
 4f7:	89 45 f4             	mov    %eax,-0xc(%rbp)
 4fa:	eb 06                	jmp    502 <printint+0x3e>
  } else {
    x = xx;
 4fc:	8b 45 d8             	mov    -0x28(%rbp),%eax
 4ff:	89 45 f4             	mov    %eax,-0xc(%rbp)
  }

  i = 0;
 502:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  do{
    buf[i++] = digits[x % base];
 509:	8b 4d d4             	mov    -0x2c(%rbp),%ecx
 50c:	8b 45 f4             	mov    -0xc(%rbp),%eax
 50f:	ba 00 00 00 00       	mov    $0x0,%edx
 514:	f7 f1                	div    %ecx
 516:	89 d1                	mov    %edx,%ecx
 518:	8b 45 fc             	mov    -0x4(%rbp),%eax
 51b:	8d 50 01             	lea    0x1(%rax),%edx
 51e:	89 55 fc             	mov    %edx,-0x4(%rbp)
 521:	89 ca                	mov    %ecx,%edx
 523:	0f b6 92 30 0e 00 00 	movzbl 0xe30(%rdx),%edx
 52a:	48 98                	cltq
 52c:	88 54 05 e0          	mov    %dl,-0x20(%rbp,%rax,1)
  }while((x /= base) != 0);
 530:	8b 75 d4             	mov    -0x2c(%rbp),%esi
 533:	8b 45 f4             	mov    -0xc(%rbp),%eax
 536:	ba 00 00 00 00       	mov    $0x0,%edx
 53b:	f7 f6                	div    %esi
 53d:	89 45 f4             	mov    %eax,-0xc(%rbp)
 540:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
 544:	75 c3                	jne    509 <printint+0x45>
  if(neg)
 546:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
 54a:	74 2b                	je     577 <printint+0xb3>
    buf[i++] = '-';
 54c:	8b 45 fc             	mov    -0x4(%rbp),%eax
 54f:	8d 50 01             	lea    0x1(%rax),%edx
 552:	89 55 fc             	mov    %edx,-0x4(%rbp)
 555:	48 98                	cltq
 557:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%rbp,%rax,1)

  while(--i >= 0)
 55c:	eb 19                	jmp    577 <printint+0xb3>
    putc(fd, buf[i]);
 55e:	8b 45 fc             	mov    -0x4(%rbp),%eax
 561:	48 98                	cltq
 563:	0f b6 44 05 e0       	movzbl -0x20(%rbp,%rax,1),%eax
 568:	0f be d0             	movsbl %al,%edx
 56b:	8b 45 dc             	mov    -0x24(%rbp),%eax
 56e:	89 d6                	mov    %edx,%esi
 570:	89 c7                	mov    %eax,%edi
 572:	e8 24 ff ff ff       	call   49b <putc>
  while(--i >= 0)
 577:	83 6d fc 01          	subl   $0x1,-0x4(%rbp)
 57b:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
 57f:	79 dd                	jns    55e <printint+0x9a>
}
 581:	90                   	nop
 582:	90                   	nop
 583:	c9                   	leave
 584:	c3                   	ret

0000000000000585 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 585:	55                   	push   %rbp
 586:	48 89 e5             	mov    %rsp,%rbp
 589:	48 81 ec f0 00 00 00 	sub    $0xf0,%rsp
 590:	89 bd 1c ff ff ff    	mov    %edi,-0xe4(%rbp)
 596:	48 89 b5 10 ff ff ff 	mov    %rsi,-0xf0(%rbp)
 59d:	48 89 95 60 ff ff ff 	mov    %rdx,-0xa0(%rbp)
 5a4:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
 5ab:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
 5b2:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
 5b9:	84 c0                	test   %al,%al
 5bb:	74 20                	je     5dd <printf+0x58>
 5bd:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
 5c1:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
 5c5:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
 5c9:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
 5cd:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
 5d1:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
 5d5:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
 5d9:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  va_list ap;
  char *s;
  int c, i, state;
  va_start(ap, fmt);
 5dd:	c7 85 20 ff ff ff 10 	movl   $0x10,-0xe0(%rbp)
 5e4:	00 00 00 
 5e7:	c7 85 24 ff ff ff 30 	movl   $0x30,-0xdc(%rbp)
 5ee:	00 00 00 
 5f1:	48 8d 45 10          	lea    0x10(%rbp),%rax
 5f5:	48 89 85 28 ff ff ff 	mov    %rax,-0xd8(%rbp)
 5fc:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
 603:	48 89 85 30 ff ff ff 	mov    %rax,-0xd0(%rbp)

  state = 0;
 60a:	c7 85 40 ff ff ff 00 	movl   $0x0,-0xc0(%rbp)
 611:	00 00 00 
  for(i = 0; fmt[i]; i++){
 614:	c7 85 44 ff ff ff 00 	movl   $0x0,-0xbc(%rbp)
 61b:	00 00 00 
 61e:	e9 a8 02 00 00       	jmp    8cb <printf+0x346>
    c = fmt[i] & 0xff;
 623:	8b 85 44 ff ff ff    	mov    -0xbc(%rbp),%eax
 629:	48 63 d0             	movslq %eax,%rdx
 62c:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
 633:	48 01 d0             	add    %rdx,%rax
 636:	0f b6 00             	movzbl (%rax),%eax
 639:	0f be c0             	movsbl %al,%eax
 63c:	25 ff 00 00 00       	and    $0xff,%eax
 641:	89 85 3c ff ff ff    	mov    %eax,-0xc4(%rbp)
    if(state == 0){
 647:	83 bd 40 ff ff ff 00 	cmpl   $0x0,-0xc0(%rbp)
 64e:	75 35                	jne    685 <printf+0x100>
      if(c == '%'){
 650:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
 657:	75 0f                	jne    668 <printf+0xe3>
        state = '%';
 659:	c7 85 40 ff ff ff 25 	movl   $0x25,-0xc0(%rbp)
 660:	00 00 00 
 663:	e9 5c 02 00 00       	jmp    8c4 <printf+0x33f>
      } else {
        putc(fd, c);
 668:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
 66e:	0f be d0             	movsbl %al,%edx
 671:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 677:	89 d6                	mov    %edx,%esi
 679:	89 c7                	mov    %eax,%edi
 67b:	e8 1b fe ff ff       	call   49b <putc>
 680:	e9 3f 02 00 00       	jmp    8c4 <printf+0x33f>
      }
    } else if(state == '%'){
 685:	83 bd 40 ff ff ff 25 	cmpl   $0x25,-0xc0(%rbp)
 68c:	0f 85 32 02 00 00    	jne    8c4 <printf+0x33f>
      if(c == 'd'){
 692:	83 bd 3c ff ff ff 64 	cmpl   $0x64,-0xc4(%rbp)
 699:	75 5e                	jne    6f9 <printf+0x174>
        printint(fd, va_arg(ap, int), 10, 1);
 69b:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 6a1:	83 f8 2f             	cmp    $0x2f,%eax
 6a4:	77 23                	ja     6c9 <printf+0x144>
 6a6:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 6ad:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 6b3:	89 d2                	mov    %edx,%edx
 6b5:	48 01 d0             	add    %rdx,%rax
 6b8:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 6be:	83 c2 08             	add    $0x8,%edx
 6c1:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 6c7:	eb 12                	jmp    6db <printf+0x156>
 6c9:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 6d0:	48 8d 50 08          	lea    0x8(%rax),%rdx
 6d4:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 6db:	8b 30                	mov    (%rax),%esi
 6dd:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 6e3:	b9 01 00 00 00       	mov    $0x1,%ecx
 6e8:	ba 0a 00 00 00       	mov    $0xa,%edx
 6ed:	89 c7                	mov    %eax,%edi
 6ef:	e8 d0 fd ff ff       	call   4c4 <printint>
 6f4:	e9 c1 01 00 00       	jmp    8ba <printf+0x335>
      } else if(c == 'x' || c == 'p'){
 6f9:	83 bd 3c ff ff ff 78 	cmpl   $0x78,-0xc4(%rbp)
 700:	74 09                	je     70b <printf+0x186>
 702:	83 bd 3c ff ff ff 70 	cmpl   $0x70,-0xc4(%rbp)
 709:	75 5e                	jne    769 <printf+0x1e4>
        printint(fd, va_arg(ap, int), 16, 0);
 70b:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 711:	83 f8 2f             	cmp    $0x2f,%eax
 714:	77 23                	ja     739 <printf+0x1b4>
 716:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 71d:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 723:	89 d2                	mov    %edx,%edx
 725:	48 01 d0             	add    %rdx,%rax
 728:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 72e:	83 c2 08             	add    $0x8,%edx
 731:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 737:	eb 12                	jmp    74b <printf+0x1c6>
 739:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 740:	48 8d 50 08          	lea    0x8(%rax),%rdx
 744:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 74b:	8b 30                	mov    (%rax),%esi
 74d:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 753:	b9 00 00 00 00       	mov    $0x0,%ecx
 758:	ba 10 00 00 00       	mov    $0x10,%edx
 75d:	89 c7                	mov    %eax,%edi
 75f:	e8 60 fd ff ff       	call   4c4 <printint>
 764:	e9 51 01 00 00       	jmp    8ba <printf+0x335>
      } else if(c == 's'){
 769:	83 bd 3c ff ff ff 73 	cmpl   $0x73,-0xc4(%rbp)
 770:	0f 85 98 00 00 00    	jne    80e <printf+0x289>
        s = va_arg(ap, char*);
 776:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 77c:	83 f8 2f             	cmp    $0x2f,%eax
 77f:	77 23                	ja     7a4 <printf+0x21f>
 781:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 788:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 78e:	89 d2                	mov    %edx,%edx
 790:	48 01 d0             	add    %rdx,%rax
 793:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 799:	83 c2 08             	add    $0x8,%edx
 79c:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 7a2:	eb 12                	jmp    7b6 <printf+0x231>
 7a4:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 7ab:	48 8d 50 08          	lea    0x8(%rax),%rdx
 7af:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 7b6:	48 8b 00             	mov    (%rax),%rax
 7b9:	48 89 85 48 ff ff ff 	mov    %rax,-0xb8(%rbp)
        if(s == 0)
 7c0:	48 83 bd 48 ff ff ff 	cmpq   $0x0,-0xb8(%rbp)
 7c7:	00 
 7c8:	75 31                	jne    7fb <printf+0x276>
          s = "(null)";
 7ca:	48 c7 85 48 ff ff ff 	movq   $0xbda,-0xb8(%rbp)
 7d1:	da 0b 00 00 
        while(*s != 0){
 7d5:	eb 24                	jmp    7fb <printf+0x276>
          putc(fd, *s);
 7d7:	48 8b 85 48 ff ff ff 	mov    -0xb8(%rbp),%rax
 7de:	0f b6 00             	movzbl (%rax),%eax
 7e1:	0f be d0             	movsbl %al,%edx
 7e4:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 7ea:	89 d6                	mov    %edx,%esi
 7ec:	89 c7                	mov    %eax,%edi
 7ee:	e8 a8 fc ff ff       	call   49b <putc>
          s++;
 7f3:	48 83 85 48 ff ff ff 	addq   $0x1,-0xb8(%rbp)
 7fa:	01 
        while(*s != 0){
 7fb:	48 8b 85 48 ff ff ff 	mov    -0xb8(%rbp),%rax
 802:	0f b6 00             	movzbl (%rax),%eax
 805:	84 c0                	test   %al,%al
 807:	75 ce                	jne    7d7 <printf+0x252>
 809:	e9 ac 00 00 00       	jmp    8ba <printf+0x335>
        }
      } else if(c == 'c'){
 80e:	83 bd 3c ff ff ff 63 	cmpl   $0x63,-0xc4(%rbp)
 815:	75 56                	jne    86d <printf+0x2e8>
        putc(fd, va_arg(ap, uint));
 817:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 81d:	83 f8 2f             	cmp    $0x2f,%eax
 820:	77 23                	ja     845 <printf+0x2c0>
 822:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 829:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 82f:	89 d2                	mov    %edx,%edx
 831:	48 01 d0             	add    %rdx,%rax
 834:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 83a:	83 c2 08             	add    $0x8,%edx
 83d:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 843:	eb 12                	jmp    857 <printf+0x2d2>
 845:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 84c:	48 8d 50 08          	lea    0x8(%rax),%rdx
 850:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 857:	8b 00                	mov    (%rax),%eax
 859:	0f be d0             	movsbl %al,%edx
 85c:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 862:	89 d6                	mov    %edx,%esi
 864:	89 c7                	mov    %eax,%edi
 866:	e8 30 fc ff ff       	call   49b <putc>
 86b:	eb 4d                	jmp    8ba <printf+0x335>
      } else if(c == '%'){
 86d:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
 874:	75 1a                	jne    890 <printf+0x30b>
        putc(fd, c);
 876:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
 87c:	0f be d0             	movsbl %al,%edx
 87f:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 885:	89 d6                	mov    %edx,%esi
 887:	89 c7                	mov    %eax,%edi
 889:	e8 0d fc ff ff       	call   49b <putc>
 88e:	eb 2a                	jmp    8ba <printf+0x335>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 890:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 896:	be 25 00 00 00       	mov    $0x25,%esi
 89b:	89 c7                	mov    %eax,%edi
 89d:	e8 f9 fb ff ff       	call   49b <putc>
        putc(fd, c);
 8a2:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
 8a8:	0f be d0             	movsbl %al,%edx
 8ab:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 8b1:	89 d6                	mov    %edx,%esi
 8b3:	89 c7                	mov    %eax,%edi
 8b5:	e8 e1 fb ff ff       	call   49b <putc>
      }
      state = 0;
 8ba:	c7 85 40 ff ff ff 00 	movl   $0x0,-0xc0(%rbp)
 8c1:	00 00 00 
  for(i = 0; fmt[i]; i++){
 8c4:	83 85 44 ff ff ff 01 	addl   $0x1,-0xbc(%rbp)
 8cb:	8b 85 44 ff ff ff    	mov    -0xbc(%rbp),%eax
 8d1:	48 63 d0             	movslq %eax,%rdx
 8d4:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
 8db:	48 01 d0             	add    %rdx,%rax
 8de:	0f b6 00             	movzbl (%rax),%eax
 8e1:	84 c0                	test   %al,%al
 8e3:	0f 85 3a fd ff ff    	jne    623 <printf+0x9e>
    }
  }
}
 8e9:	90                   	nop
 8ea:	90                   	nop
 8eb:	c9                   	leave
 8ec:	c3                   	ret

00000000000008ed <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 8ed:	55                   	push   %rbp
 8ee:	48 89 e5             	mov    %rsp,%rbp
 8f1:	48 83 ec 18          	sub    $0x18,%rsp
 8f5:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  Header *bp, *p;

  bp = (Header*)ap - 1;
 8f9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 8fd:	48 83 e8 10          	sub    $0x10,%rax
 901:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 905:	48 8b 05 54 05 00 00 	mov    0x554(%rip),%rax        # e60 <freep>
 90c:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 910:	eb 2f                	jmp    941 <free+0x54>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 912:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 916:	48 8b 00             	mov    (%rax),%rax
 919:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 91d:	72 17                	jb     936 <free+0x49>
 91f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 923:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 927:	72 2f                	jb     958 <free+0x6b>
 929:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 92d:	48 8b 00             	mov    (%rax),%rax
 930:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
 934:	72 22                	jb     958 <free+0x6b>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 936:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 93a:	48 8b 00             	mov    (%rax),%rax
 93d:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 941:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 945:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 949:	73 c7                	jae    912 <free+0x25>
 94b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 94f:	48 8b 00             	mov    (%rax),%rax
 952:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
 956:	73 ba                	jae    912 <free+0x25>
      break;
  if(bp + bp->s.size == p->s.ptr){
 958:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 95c:	8b 40 08             	mov    0x8(%rax),%eax
 95f:	89 c0                	mov    %eax,%eax
 961:	48 c1 e0 04          	shl    $0x4,%rax
 965:	48 89 c2             	mov    %rax,%rdx
 968:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 96c:	48 01 c2             	add    %rax,%rdx
 96f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 973:	48 8b 00             	mov    (%rax),%rax
 976:	48 39 c2             	cmp    %rax,%rdx
 979:	75 2d                	jne    9a8 <free+0xbb>
    bp->s.size += p->s.ptr->s.size;
 97b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 97f:	8b 50 08             	mov    0x8(%rax),%edx
 982:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 986:	48 8b 00             	mov    (%rax),%rax
 989:	8b 40 08             	mov    0x8(%rax),%eax
 98c:	01 c2                	add    %eax,%edx
 98e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 992:	89 50 08             	mov    %edx,0x8(%rax)
    bp->s.ptr = p->s.ptr->s.ptr;
 995:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 999:	48 8b 00             	mov    (%rax),%rax
 99c:	48 8b 10             	mov    (%rax),%rdx
 99f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 9a3:	48 89 10             	mov    %rdx,(%rax)
 9a6:	eb 0e                	jmp    9b6 <free+0xc9>
  } else
    bp->s.ptr = p->s.ptr;
 9a8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 9ac:	48 8b 10             	mov    (%rax),%rdx
 9af:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 9b3:	48 89 10             	mov    %rdx,(%rax)
  if(p + p->s.size == bp){
 9b6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 9ba:	8b 40 08             	mov    0x8(%rax),%eax
 9bd:	89 c0                	mov    %eax,%eax
 9bf:	48 c1 e0 04          	shl    $0x4,%rax
 9c3:	48 89 c2             	mov    %rax,%rdx
 9c6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 9ca:	48 01 d0             	add    %rdx,%rax
 9cd:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
 9d1:	75 27                	jne    9fa <free+0x10d>
    p->s.size += bp->s.size;
 9d3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 9d7:	8b 50 08             	mov    0x8(%rax),%edx
 9da:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 9de:	8b 40 08             	mov    0x8(%rax),%eax
 9e1:	01 c2                	add    %eax,%edx
 9e3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 9e7:	89 50 08             	mov    %edx,0x8(%rax)
    p->s.ptr = bp->s.ptr;
 9ea:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 9ee:	48 8b 10             	mov    (%rax),%rdx
 9f1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 9f5:	48 89 10             	mov    %rdx,(%rax)
 9f8:	eb 0b                	jmp    a05 <free+0x118>
  } else
    p->s.ptr = bp;
 9fa:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 9fe:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
 a02:	48 89 10             	mov    %rdx,(%rax)
  freep = p;
 a05:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a09:	48 89 05 50 04 00 00 	mov    %rax,0x450(%rip)        # e60 <freep>
}
 a10:	90                   	nop
 a11:	c9                   	leave
 a12:	c3                   	ret

0000000000000a13 <morecore>:

static Header*
morecore(uint nu)
{
 a13:	55                   	push   %rbp
 a14:	48 89 e5             	mov    %rsp,%rbp
 a17:	48 83 ec 20          	sub    $0x20,%rsp
 a1b:	89 7d ec             	mov    %edi,-0x14(%rbp)
  char *p;
  Header *hp;

  if(nu < 4096)
 a1e:	81 7d ec ff 0f 00 00 	cmpl   $0xfff,-0x14(%rbp)
 a25:	77 07                	ja     a2e <morecore+0x1b>
    nu = 4096;
 a27:	c7 45 ec 00 10 00 00 	movl   $0x1000,-0x14(%rbp)
  p = sbrk(nu * sizeof(Header));
 a2e:	8b 45 ec             	mov    -0x14(%rbp),%eax
 a31:	c1 e0 04             	shl    $0x4,%eax
 a34:	89 c7                	mov    %eax,%edi
 a36:	e8 40 fa ff ff       	call   47b <sbrk>
 a3b:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  if(p == (char*)-1)
 a3f:	48 83 7d f8 ff       	cmpq   $0xffffffffffffffff,-0x8(%rbp)
 a44:	75 07                	jne    a4d <morecore+0x3a>
    return 0;
 a46:	b8 00 00 00 00       	mov    $0x0,%eax
 a4b:	eb 29                	jmp    a76 <morecore+0x63>
  hp = (Header*)p;
 a4d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a51:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  hp->s.size = nu;
 a55:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 a59:	8b 55 ec             	mov    -0x14(%rbp),%edx
 a5c:	89 50 08             	mov    %edx,0x8(%rax)
  free((void*)(hp + 1));
 a5f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 a63:	48 83 c0 10          	add    $0x10,%rax
 a67:	48 89 c7             	mov    %rax,%rdi
 a6a:	e8 7e fe ff ff       	call   8ed <free>
  return freep;
 a6f:	48 8b 05 ea 03 00 00 	mov    0x3ea(%rip),%rax        # e60 <freep>
}
 a76:	c9                   	leave
 a77:	c3                   	ret

0000000000000a78 <malloc>:

void*
malloc(uint nbytes)
{
 a78:	55                   	push   %rbp
 a79:	48 89 e5             	mov    %rsp,%rbp
 a7c:	48 83 ec 30          	sub    $0x30,%rsp
 a80:	89 7d dc             	mov    %edi,-0x24(%rbp)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 a83:	8b 45 dc             	mov    -0x24(%rbp),%eax
 a86:	48 83 c0 0f          	add    $0xf,%rax
 a8a:	48 c1 e8 04          	shr    $0x4,%rax
 a8e:	83 c0 01             	add    $0x1,%eax
 a91:	89 45 ec             	mov    %eax,-0x14(%rbp)
  if((prevp = freep) == 0){
 a94:	48 8b 05 c5 03 00 00 	mov    0x3c5(%rip),%rax        # e60 <freep>
 a9b:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
 a9f:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
 aa4:	75 2b                	jne    ad1 <malloc+0x59>
    base.s.ptr = freep = prevp = &base;
 aa6:	48 c7 45 f0 50 0e 00 	movq   $0xe50,-0x10(%rbp)
 aad:	00 
 aae:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 ab2:	48 89 05 a7 03 00 00 	mov    %rax,0x3a7(%rip)        # e60 <freep>
 ab9:	48 8b 05 a0 03 00 00 	mov    0x3a0(%rip),%rax        # e60 <freep>
 ac0:	48 89 05 89 03 00 00 	mov    %rax,0x389(%rip)        # e50 <base>
    base.s.size = 0;
 ac7:	c7 05 87 03 00 00 00 	movl   $0x0,0x387(%rip)        # e58 <base+0x8>
 ace:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 ad1:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 ad5:	48 8b 00             	mov    (%rax),%rax
 ad8:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
 adc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 ae0:	8b 40 08             	mov    0x8(%rax),%eax
 ae3:	3b 45 ec             	cmp    -0x14(%rbp),%eax
 ae6:	72 5f                	jb     b47 <malloc+0xcf>
      if(p->s.size == nunits)
 ae8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 aec:	8b 40 08             	mov    0x8(%rax),%eax
 aef:	39 45 ec             	cmp    %eax,-0x14(%rbp)
 af2:	75 10                	jne    b04 <malloc+0x8c>
        prevp->s.ptr = p->s.ptr;
 af4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 af8:	48 8b 10             	mov    (%rax),%rdx
 afb:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 aff:	48 89 10             	mov    %rdx,(%rax)
 b02:	eb 2e                	jmp    b32 <malloc+0xba>
      else {
        p->s.size -= nunits;
 b04:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b08:	8b 40 08             	mov    0x8(%rax),%eax
 b0b:	2b 45 ec             	sub    -0x14(%rbp),%eax
 b0e:	89 c2                	mov    %eax,%edx
 b10:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b14:	89 50 08             	mov    %edx,0x8(%rax)
        p += p->s.size;
 b17:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b1b:	8b 40 08             	mov    0x8(%rax),%eax
 b1e:	89 c0                	mov    %eax,%eax
 b20:	48 c1 e0 04          	shl    $0x4,%rax
 b24:	48 01 45 f8          	add    %rax,-0x8(%rbp)
        p->s.size = nunits;
 b28:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b2c:	8b 55 ec             	mov    -0x14(%rbp),%edx
 b2f:	89 50 08             	mov    %edx,0x8(%rax)
      }
      freep = prevp;
 b32:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 b36:	48 89 05 23 03 00 00 	mov    %rax,0x323(%rip)        # e60 <freep>
      return (void*)(p + 1);
 b3d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b41:	48 83 c0 10          	add    $0x10,%rax
 b45:	eb 41                	jmp    b88 <malloc+0x110>
    }
    if(p == freep)
 b47:	48 8b 05 12 03 00 00 	mov    0x312(%rip),%rax        # e60 <freep>
 b4e:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 b52:	75 1c                	jne    b70 <malloc+0xf8>
      if((p = morecore(nunits)) == 0)
 b54:	8b 45 ec             	mov    -0x14(%rbp),%eax
 b57:	89 c7                	mov    %eax,%edi
 b59:	e8 b5 fe ff ff       	call   a13 <morecore>
 b5e:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 b62:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
 b67:	75 07                	jne    b70 <malloc+0xf8>
        return 0;
 b69:	b8 00 00 00 00       	mov    $0x0,%eax
 b6e:	eb 18                	jmp    b88 <malloc+0x110>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 b70:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b74:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
 b78:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b7c:	48 8b 00             	mov    (%rax),%rax
 b7f:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
 b83:	e9 54 ff ff ff       	jmp    adc <malloc+0x64>
  }
}
 b88:	c9                   	leave
 b89:	c3                   	ret
