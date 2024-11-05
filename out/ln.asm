
fs/ln:     file format elf64-x86-64


Disassembly of section .text:

0000000000000000 <main>:
#include "stat.h"
#include "user.h"

int
main(int argc, char *argv[])
{
   0:	55                   	push   %rbp
   1:	48 89 e5             	mov    %rsp,%rbp
   4:	48 83 ec 10          	sub    $0x10,%rsp
   8:	89 7d fc             	mov    %edi,-0x4(%rbp)
   b:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  if(argc != 3){
   f:	83 7d fc 03          	cmpl   $0x3,-0x4(%rbp)
  13:	74 1b                	je     30 <main+0x30>
    printf(2, "Usage: ln old new\n");
  15:	48 c7 c6 23 0d 00 00 	mov    $0xd23,%rsi
  1c:	bf 02 00 00 00       	mov    $0x2,%edi
  21:	b8 00 00 00 00       	mov    $0x0,%eax
  26:	e8 06 05 00 00       	call   531 <printf>
    exit();
  2b:	e8 4f 03 00 00       	call   37f <exit>
  }
  if(link(argv[1], argv[2]) < 0)
  30:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  34:	48 83 c0 10          	add    $0x10,%rax
  38:	48 8b 10             	mov    (%rax),%rdx
  3b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  3f:	48 83 c0 08          	add    $0x8,%rax
  43:	48 8b 00             	mov    (%rax),%rax
  46:	48 89 d6             	mov    %rdx,%rsi
  49:	48 89 c7             	mov    %rax,%rdi
  4c:	e8 8e 03 00 00       	call   3df <link>
  51:	85 c0                	test   %eax,%eax
  53:	79 32                	jns    87 <main+0x87>
    printf(2, "link %s %s: failed\n", argv[1], argv[2]);
  55:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  59:	48 83 c0 10          	add    $0x10,%rax
  5d:	48 8b 10             	mov    (%rax),%rdx
  60:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  64:	48 83 c0 08          	add    $0x8,%rax
  68:	48 8b 00             	mov    (%rax),%rax
  6b:	48 89 d1             	mov    %rdx,%rcx
  6e:	48 89 c2             	mov    %rax,%rdx
  71:	48 c7 c6 36 0d 00 00 	mov    $0xd36,%rsi
  78:	bf 02 00 00 00       	mov    $0x2,%edi
  7d:	b8 00 00 00 00       	mov    $0x0,%eax
  82:	e8 aa 04 00 00       	call   531 <printf>
  exit();
  87:	e8 f3 02 00 00       	call   37f <exit>

000000000000008c <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
  8c:	55                   	push   %rbp
  8d:	48 89 e5             	mov    %rsp,%rbp
  90:	48 83 ec 10          	sub    $0x10,%rsp
  94:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  98:	89 75 f4             	mov    %esi,-0xc(%rbp)
  9b:	89 55 f0             	mov    %edx,-0x10(%rbp)
  asm volatile("cld; rep stosb" :
  9e:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
  a2:	8b 55 f0             	mov    -0x10(%rbp),%edx
  a5:	8b 45 f4             	mov    -0xc(%rbp),%eax
  a8:	48 89 ce             	mov    %rcx,%rsi
  ab:	48 89 f7             	mov    %rsi,%rdi
  ae:	89 d1                	mov    %edx,%ecx
  b0:	fc                   	cld
  b1:	f3 aa                	rep stos %al,%es:(%rdi)
  b3:	89 ca                	mov    %ecx,%edx
  b5:	48 89 fe             	mov    %rdi,%rsi
  b8:	48 89 75 f8          	mov    %rsi,-0x8(%rbp)
  bc:	89 55 f0             	mov    %edx,-0x10(%rbp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
  bf:	90                   	nop
  c0:	c9                   	leave
  c1:	c3                   	ret

00000000000000c2 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
  c2:	55                   	push   %rbp
  c3:	48 89 e5             	mov    %rsp,%rbp
  c6:	48 83 ec 20          	sub    $0x20,%rsp
  ca:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  ce:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  char *os;

  os = s;
  d2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  d6:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  while((*s++ = *t++) != 0)
  da:	90                   	nop
  db:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  df:	48 8d 42 01          	lea    0x1(%rdx),%rax
  e3:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  e7:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  eb:	48 8d 48 01          	lea    0x1(%rax),%rcx
  ef:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  f3:	0f b6 12             	movzbl (%rdx),%edx
  f6:	88 10                	mov    %dl,(%rax)
  f8:	0f b6 00             	movzbl (%rax),%eax
  fb:	84 c0                	test   %al,%al
  fd:	75 dc                	jne    db <strcpy+0x19>
    ;
  return os;
  ff:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
 103:	c9                   	leave
 104:	c3                   	ret

0000000000000105 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 105:	55                   	push   %rbp
 106:	48 89 e5             	mov    %rsp,%rbp
 109:	48 83 ec 10          	sub    $0x10,%rsp
 10d:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
 111:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  while(*p && *p == *q)
 115:	eb 0a                	jmp    121 <strcmp+0x1c>
    p++, q++;
 117:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
 11c:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  while(*p && *p == *q)
 121:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 125:	0f b6 00             	movzbl (%rax),%eax
 128:	84 c0                	test   %al,%al
 12a:	74 12                	je     13e <strcmp+0x39>
 12c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 130:	0f b6 10             	movzbl (%rax),%edx
 133:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 137:	0f b6 00             	movzbl (%rax),%eax
 13a:	38 c2                	cmp    %al,%dl
 13c:	74 d9                	je     117 <strcmp+0x12>
  return (uchar)*p - (uchar)*q;
 13e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 142:	0f b6 00             	movzbl (%rax),%eax
 145:	0f b6 d0             	movzbl %al,%edx
 148:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 14c:	0f b6 00             	movzbl (%rax),%eax
 14f:	0f b6 c0             	movzbl %al,%eax
 152:	29 c2                	sub    %eax,%edx
 154:	89 d0                	mov    %edx,%eax
}
 156:	c9                   	leave
 157:	c3                   	ret

0000000000000158 <strlen>:

uint
strlen(char *s)
{
 158:	55                   	push   %rbp
 159:	48 89 e5             	mov    %rsp,%rbp
 15c:	48 83 ec 18          	sub    $0x18,%rsp
 160:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  int n;

  for(n = 0; s[n]; n++)
 164:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
 16b:	eb 04                	jmp    171 <strlen+0x19>
 16d:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
 171:	8b 45 fc             	mov    -0x4(%rbp),%eax
 174:	48 63 d0             	movslq %eax,%rdx
 177:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 17b:	48 01 d0             	add    %rdx,%rax
 17e:	0f b6 00             	movzbl (%rax),%eax
 181:	84 c0                	test   %al,%al
 183:	75 e8                	jne    16d <strlen+0x15>
    ;
  return n;
 185:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
 188:	c9                   	leave
 189:	c3                   	ret

000000000000018a <memset>:

void*
memset(void *dst, int c, uint n)
{
 18a:	55                   	push   %rbp
 18b:	48 89 e5             	mov    %rsp,%rbp
 18e:	48 83 ec 10          	sub    $0x10,%rsp
 192:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
 196:	89 75 f4             	mov    %esi,-0xc(%rbp)
 199:	89 55 f0             	mov    %edx,-0x10(%rbp)
  stosb(dst, c, n);
 19c:	8b 55 f0             	mov    -0x10(%rbp),%edx
 19f:	8b 4d f4             	mov    -0xc(%rbp),%ecx
 1a2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 1a6:	89 ce                	mov    %ecx,%esi
 1a8:	48 89 c7             	mov    %rax,%rdi
 1ab:	e8 dc fe ff ff       	call   8c <stosb>
  return dst;
 1b0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
 1b4:	c9                   	leave
 1b5:	c3                   	ret

00000000000001b6 <strchr>:

char*
strchr(const char *s, char c)
{
 1b6:	55                   	push   %rbp
 1b7:	48 89 e5             	mov    %rsp,%rbp
 1ba:	48 83 ec 10          	sub    $0x10,%rsp
 1be:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
 1c2:	89 f0                	mov    %esi,%eax
 1c4:	88 45 f4             	mov    %al,-0xc(%rbp)
  for(; *s; s++)
 1c7:	eb 17                	jmp    1e0 <strchr+0x2a>
    if(*s == c)
 1c9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 1cd:	0f b6 00             	movzbl (%rax),%eax
 1d0:	38 45 f4             	cmp    %al,-0xc(%rbp)
 1d3:	75 06                	jne    1db <strchr+0x25>
      return (char*)s;
 1d5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 1d9:	eb 15                	jmp    1f0 <strchr+0x3a>
  for(; *s; s++)
 1db:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
 1e0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 1e4:	0f b6 00             	movzbl (%rax),%eax
 1e7:	84 c0                	test   %al,%al
 1e9:	75 de                	jne    1c9 <strchr+0x13>
  return 0;
 1eb:	b8 00 00 00 00       	mov    $0x0,%eax
}
 1f0:	c9                   	leave
 1f1:	c3                   	ret

00000000000001f2 <gets>:

char*
gets(char *buf, int max)
{
 1f2:	55                   	push   %rbp
 1f3:	48 89 e5             	mov    %rsp,%rbp
 1f6:	48 83 ec 20          	sub    $0x20,%rsp
 1fa:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
 1fe:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 201:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
 208:	eb 48                	jmp    252 <gets+0x60>
    cc = read(0, &c, 1);
 20a:	48 8d 45 f7          	lea    -0x9(%rbp),%rax
 20e:	ba 01 00 00 00       	mov    $0x1,%edx
 213:	48 89 c6             	mov    %rax,%rsi
 216:	bf 00 00 00 00       	mov    $0x0,%edi
 21b:	e8 77 01 00 00       	call   397 <read>
 220:	89 45 f8             	mov    %eax,-0x8(%rbp)
    if(cc < 1)
 223:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
 227:	7e 36                	jle    25f <gets+0x6d>
      break;
    buf[i++] = c;
 229:	8b 45 fc             	mov    -0x4(%rbp),%eax
 22c:	8d 50 01             	lea    0x1(%rax),%edx
 22f:	89 55 fc             	mov    %edx,-0x4(%rbp)
 232:	48 63 d0             	movslq %eax,%rdx
 235:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 239:	48 01 c2             	add    %rax,%rdx
 23c:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
 240:	88 02                	mov    %al,(%rdx)
    if(c == '\n' || c == '\r')
 242:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
 246:	3c 0a                	cmp    $0xa,%al
 248:	74 16                	je     260 <gets+0x6e>
 24a:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
 24e:	3c 0d                	cmp    $0xd,%al
 250:	74 0e                	je     260 <gets+0x6e>
  for(i=0; i+1 < max; ){
 252:	8b 45 fc             	mov    -0x4(%rbp),%eax
 255:	83 c0 01             	add    $0x1,%eax
 258:	39 45 e4             	cmp    %eax,-0x1c(%rbp)
 25b:	7f ad                	jg     20a <gets+0x18>
 25d:	eb 01                	jmp    260 <gets+0x6e>
      break;
 25f:	90                   	nop
      break;
  }
  buf[i] = '\0';
 260:	8b 45 fc             	mov    -0x4(%rbp),%eax
 263:	48 63 d0             	movslq %eax,%rdx
 266:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 26a:	48 01 d0             	add    %rdx,%rax
 26d:	c6 00 00             	movb   $0x0,(%rax)
  return buf;
 270:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
 274:	c9                   	leave
 275:	c3                   	ret

0000000000000276 <stat>:

int
stat(char *n, struct stat *st)
{
 276:	55                   	push   %rbp
 277:	48 89 e5             	mov    %rsp,%rbp
 27a:	48 83 ec 20          	sub    $0x20,%rsp
 27e:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
 282:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 286:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 28a:	be 00 00 00 00       	mov    $0x0,%esi
 28f:	48 89 c7             	mov    %rax,%rdi
 292:	e8 28 01 00 00       	call   3bf <open>
 297:	89 45 fc             	mov    %eax,-0x4(%rbp)
  if(fd < 0)
 29a:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
 29e:	79 07                	jns    2a7 <stat+0x31>
    return -1;
 2a0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 2a5:	eb 21                	jmp    2c8 <stat+0x52>
  r = fstat(fd, st);
 2a7:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
 2ab:	8b 45 fc             	mov    -0x4(%rbp),%eax
 2ae:	48 89 d6             	mov    %rdx,%rsi
 2b1:	89 c7                	mov    %eax,%edi
 2b3:	e8 1f 01 00 00       	call   3d7 <fstat>
 2b8:	89 45 f8             	mov    %eax,-0x8(%rbp)
  close(fd);
 2bb:	8b 45 fc             	mov    -0x4(%rbp),%eax
 2be:	89 c7                	mov    %eax,%edi
 2c0:	e8 e2 00 00 00       	call   3a7 <close>
  return r;
 2c5:	8b 45 f8             	mov    -0x8(%rbp),%eax
}
 2c8:	c9                   	leave
 2c9:	c3                   	ret

00000000000002ca <atoi>:

int
atoi(const char *s)
{
 2ca:	55                   	push   %rbp
 2cb:	48 89 e5             	mov    %rsp,%rbp
 2ce:	48 83 ec 18          	sub    $0x18,%rsp
 2d2:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  int n;

  n = 0;
 2d6:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  while('0' <= *s && *s <= '9')
 2dd:	eb 28                	jmp    307 <atoi+0x3d>
    n = n*10 + *s++ - '0';
 2df:	8b 55 fc             	mov    -0x4(%rbp),%edx
 2e2:	89 d0                	mov    %edx,%eax
 2e4:	c1 e0 02             	shl    $0x2,%eax
 2e7:	01 d0                	add    %edx,%eax
 2e9:	01 c0                	add    %eax,%eax
 2eb:	89 c1                	mov    %eax,%ecx
 2ed:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 2f1:	48 8d 50 01          	lea    0x1(%rax),%rdx
 2f5:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
 2f9:	0f b6 00             	movzbl (%rax),%eax
 2fc:	0f be c0             	movsbl %al,%eax
 2ff:	01 c8                	add    %ecx,%eax
 301:	83 e8 30             	sub    $0x30,%eax
 304:	89 45 fc             	mov    %eax,-0x4(%rbp)
  while('0' <= *s && *s <= '9')
 307:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 30b:	0f b6 00             	movzbl (%rax),%eax
 30e:	3c 2f                	cmp    $0x2f,%al
 310:	7e 0b                	jle    31d <atoi+0x53>
 312:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 316:	0f b6 00             	movzbl (%rax),%eax
 319:	3c 39                	cmp    $0x39,%al
 31b:	7e c2                	jle    2df <atoi+0x15>
  return n;
 31d:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
 320:	c9                   	leave
 321:	c3                   	ret

0000000000000322 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 322:	55                   	push   %rbp
 323:	48 89 e5             	mov    %rsp,%rbp
 326:	48 83 ec 28          	sub    $0x28,%rsp
 32a:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
 32e:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
 332:	89 55 dc             	mov    %edx,-0x24(%rbp)
  char *dst, *src;
  
  dst = vdst;
 335:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 339:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  src = vsrc;
 33d:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
 341:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  while(n-- > 0)
 345:	eb 1d                	jmp    364 <memmove+0x42>
    *dst++ = *src++;
 347:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
 34b:	48 8d 42 01          	lea    0x1(%rdx),%rax
 34f:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
 353:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 357:	48 8d 48 01          	lea    0x1(%rax),%rcx
 35b:	48 89 4d f8          	mov    %rcx,-0x8(%rbp)
 35f:	0f b6 12             	movzbl (%rdx),%edx
 362:	88 10                	mov    %dl,(%rax)
  while(n-- > 0)
 364:	8b 45 dc             	mov    -0x24(%rbp),%eax
 367:	8d 50 ff             	lea    -0x1(%rax),%edx
 36a:	89 55 dc             	mov    %edx,-0x24(%rbp)
 36d:	85 c0                	test   %eax,%eax
 36f:	7f d6                	jg     347 <memmove+0x25>
  return vdst;
 371:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
 375:	c9                   	leave
 376:	c3                   	ret

0000000000000377 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 377:	b8 01 00 00 00       	mov    $0x1,%eax
 37c:	cd 40                	int    $0x40
 37e:	c3                   	ret

000000000000037f <exit>:
SYSCALL(exit)
 37f:	b8 02 00 00 00       	mov    $0x2,%eax
 384:	cd 40                	int    $0x40
 386:	c3                   	ret

0000000000000387 <wait>:
SYSCALL(wait)
 387:	b8 03 00 00 00       	mov    $0x3,%eax
 38c:	cd 40                	int    $0x40
 38e:	c3                   	ret

000000000000038f <pipe>:
SYSCALL(pipe)
 38f:	b8 04 00 00 00       	mov    $0x4,%eax
 394:	cd 40                	int    $0x40
 396:	c3                   	ret

0000000000000397 <read>:
SYSCALL(read)
 397:	b8 05 00 00 00       	mov    $0x5,%eax
 39c:	cd 40                	int    $0x40
 39e:	c3                   	ret

000000000000039f <write>:
SYSCALL(write)
 39f:	b8 10 00 00 00       	mov    $0x10,%eax
 3a4:	cd 40                	int    $0x40
 3a6:	c3                   	ret

00000000000003a7 <close>:
SYSCALL(close)
 3a7:	b8 15 00 00 00       	mov    $0x15,%eax
 3ac:	cd 40                	int    $0x40
 3ae:	c3                   	ret

00000000000003af <kill>:
SYSCALL(kill)
 3af:	b8 06 00 00 00       	mov    $0x6,%eax
 3b4:	cd 40                	int    $0x40
 3b6:	c3                   	ret

00000000000003b7 <exec>:
SYSCALL(exec)
 3b7:	b8 07 00 00 00       	mov    $0x7,%eax
 3bc:	cd 40                	int    $0x40
 3be:	c3                   	ret

00000000000003bf <open>:
SYSCALL(open)
 3bf:	b8 0f 00 00 00       	mov    $0xf,%eax
 3c4:	cd 40                	int    $0x40
 3c6:	c3                   	ret

00000000000003c7 <mknod>:
SYSCALL(mknod)
 3c7:	b8 11 00 00 00       	mov    $0x11,%eax
 3cc:	cd 40                	int    $0x40
 3ce:	c3                   	ret

00000000000003cf <unlink>:
SYSCALL(unlink)
 3cf:	b8 12 00 00 00       	mov    $0x12,%eax
 3d4:	cd 40                	int    $0x40
 3d6:	c3                   	ret

00000000000003d7 <fstat>:
SYSCALL(fstat)
 3d7:	b8 08 00 00 00       	mov    $0x8,%eax
 3dc:	cd 40                	int    $0x40
 3de:	c3                   	ret

00000000000003df <link>:
SYSCALL(link)
 3df:	b8 13 00 00 00       	mov    $0x13,%eax
 3e4:	cd 40                	int    $0x40
 3e6:	c3                   	ret

00000000000003e7 <mkdir>:
SYSCALL(mkdir)
 3e7:	b8 14 00 00 00       	mov    $0x14,%eax
 3ec:	cd 40                	int    $0x40
 3ee:	c3                   	ret

00000000000003ef <chdir>:
SYSCALL(chdir)
 3ef:	b8 09 00 00 00       	mov    $0x9,%eax
 3f4:	cd 40                	int    $0x40
 3f6:	c3                   	ret

00000000000003f7 <dup>:
SYSCALL(dup)
 3f7:	b8 0a 00 00 00       	mov    $0xa,%eax
 3fc:	cd 40                	int    $0x40
 3fe:	c3                   	ret

00000000000003ff <getpid>:
SYSCALL(getpid)
 3ff:	b8 0b 00 00 00       	mov    $0xb,%eax
 404:	cd 40                	int    $0x40
 406:	c3                   	ret

0000000000000407 <sbrk>:
SYSCALL(sbrk)
 407:	b8 0c 00 00 00       	mov    $0xc,%eax
 40c:	cd 40                	int    $0x40
 40e:	c3                   	ret

000000000000040f <sleep>:
SYSCALL(sleep)
 40f:	b8 0d 00 00 00       	mov    $0xd,%eax
 414:	cd 40                	int    $0x40
 416:	c3                   	ret

0000000000000417 <uptime>:
SYSCALL(uptime)
 417:	b8 0e 00 00 00       	mov    $0xe,%eax
 41c:	cd 40                	int    $0x40
 41e:	c3                   	ret

000000000000041f <getpinfo>:
SYSCALL(getpinfo)
 41f:	b8 18 00 00 00       	mov    $0x18,%eax
 424:	cd 40                	int    $0x40
 426:	c3                   	ret

0000000000000427 <getfavnum>:
SYSCALL(getfavnum)
 427:	b8 19 00 00 00       	mov    $0x19,%eax
 42c:	cd 40                	int    $0x40
 42e:	c3                   	ret

000000000000042f <shutdown>:
SYSCALL(shutdown)
 42f:	b8 1a 00 00 00       	mov    $0x1a,%eax
 434:	cd 40                	int    $0x40
 436:	c3                   	ret

0000000000000437 <getcount>:
SYSCALL(getcount)
 437:	b8 1b 00 00 00       	mov    $0x1b,%eax
 43c:	cd 40                	int    $0x40
 43e:	c3                   	ret

000000000000043f <killrandom>:
 43f:	b8 1c 00 00 00       	mov    $0x1c,%eax
 444:	cd 40                	int    $0x40
 446:	c3                   	ret

0000000000000447 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 447:	55                   	push   %rbp
 448:	48 89 e5             	mov    %rsp,%rbp
 44b:	48 83 ec 10          	sub    $0x10,%rsp
 44f:	89 7d fc             	mov    %edi,-0x4(%rbp)
 452:	89 f0                	mov    %esi,%eax
 454:	88 45 f8             	mov    %al,-0x8(%rbp)
  write(fd, &c, 1);
 457:	48 8d 4d f8          	lea    -0x8(%rbp),%rcx
 45b:	8b 45 fc             	mov    -0x4(%rbp),%eax
 45e:	ba 01 00 00 00       	mov    $0x1,%edx
 463:	48 89 ce             	mov    %rcx,%rsi
 466:	89 c7                	mov    %eax,%edi
 468:	e8 32 ff ff ff       	call   39f <write>
}
 46d:	90                   	nop
 46e:	c9                   	leave
 46f:	c3                   	ret

0000000000000470 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 470:	55                   	push   %rbp
 471:	48 89 e5             	mov    %rsp,%rbp
 474:	48 83 ec 30          	sub    $0x30,%rsp
 478:	89 7d dc             	mov    %edi,-0x24(%rbp)
 47b:	89 75 d8             	mov    %esi,-0x28(%rbp)
 47e:	89 55 d4             	mov    %edx,-0x2c(%rbp)
 481:	89 4d d0             	mov    %ecx,-0x30(%rbp)
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 484:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
  if(sgn && xx < 0){
 48b:	83 7d d0 00          	cmpl   $0x0,-0x30(%rbp)
 48f:	74 17                	je     4a8 <printint+0x38>
 491:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
 495:	79 11                	jns    4a8 <printint+0x38>
    neg = 1;
 497:	c7 45 f8 01 00 00 00 	movl   $0x1,-0x8(%rbp)
    x = -xx;
 49e:	8b 45 d8             	mov    -0x28(%rbp),%eax
 4a1:	f7 d8                	neg    %eax
 4a3:	89 45 f4             	mov    %eax,-0xc(%rbp)
 4a6:	eb 06                	jmp    4ae <printint+0x3e>
  } else {
    x = xx;
 4a8:	8b 45 d8             	mov    -0x28(%rbp),%eax
 4ab:	89 45 f4             	mov    %eax,-0xc(%rbp)
  }

  i = 0;
 4ae:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  do{
    buf[i++] = digits[x % base];
 4b5:	8b 4d d4             	mov    -0x2c(%rbp),%ecx
 4b8:	8b 45 f4             	mov    -0xc(%rbp),%eax
 4bb:	ba 00 00 00 00       	mov    $0x0,%edx
 4c0:	f7 f1                	div    %ecx
 4c2:	89 d1                	mov    %edx,%ecx
 4c4:	8b 45 fc             	mov    -0x4(%rbp),%eax
 4c7:	8d 50 01             	lea    0x1(%rax),%edx
 4ca:	89 55 fc             	mov    %edx,-0x4(%rbp)
 4cd:	89 ca                	mov    %ecx,%edx
 4cf:	0f b6 92 30 10 00 00 	movzbl 0x1030(%rdx),%edx
 4d6:	48 98                	cltq
 4d8:	88 54 05 e0          	mov    %dl,-0x20(%rbp,%rax,1)
  }while((x /= base) != 0);
 4dc:	8b 75 d4             	mov    -0x2c(%rbp),%esi
 4df:	8b 45 f4             	mov    -0xc(%rbp),%eax
 4e2:	ba 00 00 00 00       	mov    $0x0,%edx
 4e7:	f7 f6                	div    %esi
 4e9:	89 45 f4             	mov    %eax,-0xc(%rbp)
 4ec:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
 4f0:	75 c3                	jne    4b5 <printint+0x45>
  if(neg)
 4f2:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
 4f6:	74 2b                	je     523 <printint+0xb3>
    buf[i++] = '-';
 4f8:	8b 45 fc             	mov    -0x4(%rbp),%eax
 4fb:	8d 50 01             	lea    0x1(%rax),%edx
 4fe:	89 55 fc             	mov    %edx,-0x4(%rbp)
 501:	48 98                	cltq
 503:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%rbp,%rax,1)

  while(--i >= 0)
 508:	eb 19                	jmp    523 <printint+0xb3>
    putc(fd, buf[i]);
 50a:	8b 45 fc             	mov    -0x4(%rbp),%eax
 50d:	48 98                	cltq
 50f:	0f b6 44 05 e0       	movzbl -0x20(%rbp,%rax,1),%eax
 514:	0f be d0             	movsbl %al,%edx
 517:	8b 45 dc             	mov    -0x24(%rbp),%eax
 51a:	89 d6                	mov    %edx,%esi
 51c:	89 c7                	mov    %eax,%edi
 51e:	e8 24 ff ff ff       	call   447 <putc>
  while(--i >= 0)
 523:	83 6d fc 01          	subl   $0x1,-0x4(%rbp)
 527:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
 52b:	79 dd                	jns    50a <printint+0x9a>
}
 52d:	90                   	nop
 52e:	90                   	nop
 52f:	c9                   	leave
 530:	c3                   	ret

0000000000000531 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 531:	55                   	push   %rbp
 532:	48 89 e5             	mov    %rsp,%rbp
 535:	48 81 ec f0 00 00 00 	sub    $0xf0,%rsp
 53c:	89 bd 1c ff ff ff    	mov    %edi,-0xe4(%rbp)
 542:	48 89 b5 10 ff ff ff 	mov    %rsi,-0xf0(%rbp)
 549:	48 89 95 60 ff ff ff 	mov    %rdx,-0xa0(%rbp)
 550:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
 557:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
 55e:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
 565:	84 c0                	test   %al,%al
 567:	74 20                	je     589 <printf+0x58>
 569:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
 56d:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
 571:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
 575:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
 579:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
 57d:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
 581:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
 585:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  va_list ap;
  char *s;
  int c, i, state;
  va_start(ap, fmt);
 589:	c7 85 20 ff ff ff 10 	movl   $0x10,-0xe0(%rbp)
 590:	00 00 00 
 593:	c7 85 24 ff ff ff 30 	movl   $0x30,-0xdc(%rbp)
 59a:	00 00 00 
 59d:	48 8d 45 10          	lea    0x10(%rbp),%rax
 5a1:	48 89 85 28 ff ff ff 	mov    %rax,-0xd8(%rbp)
 5a8:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
 5af:	48 89 85 30 ff ff ff 	mov    %rax,-0xd0(%rbp)

  state = 0;
 5b6:	c7 85 40 ff ff ff 00 	movl   $0x0,-0xc0(%rbp)
 5bd:	00 00 00 
  for(i = 0; fmt[i]; i++){
 5c0:	c7 85 44 ff ff ff 00 	movl   $0x0,-0xbc(%rbp)
 5c7:	00 00 00 
 5ca:	e9 a8 02 00 00       	jmp    877 <printf+0x346>
    c = fmt[i] & 0xff;
 5cf:	8b 85 44 ff ff ff    	mov    -0xbc(%rbp),%eax
 5d5:	48 63 d0             	movslq %eax,%rdx
 5d8:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
 5df:	48 01 d0             	add    %rdx,%rax
 5e2:	0f b6 00             	movzbl (%rax),%eax
 5e5:	0f be c0             	movsbl %al,%eax
 5e8:	25 ff 00 00 00       	and    $0xff,%eax
 5ed:	89 85 3c ff ff ff    	mov    %eax,-0xc4(%rbp)
    if(state == 0){
 5f3:	83 bd 40 ff ff ff 00 	cmpl   $0x0,-0xc0(%rbp)
 5fa:	75 35                	jne    631 <printf+0x100>
      if(c == '%'){
 5fc:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
 603:	75 0f                	jne    614 <printf+0xe3>
        state = '%';
 605:	c7 85 40 ff ff ff 25 	movl   $0x25,-0xc0(%rbp)
 60c:	00 00 00 
 60f:	e9 5c 02 00 00       	jmp    870 <printf+0x33f>
      } else {
        putc(fd, c);
 614:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
 61a:	0f be d0             	movsbl %al,%edx
 61d:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 623:	89 d6                	mov    %edx,%esi
 625:	89 c7                	mov    %eax,%edi
 627:	e8 1b fe ff ff       	call   447 <putc>
 62c:	e9 3f 02 00 00       	jmp    870 <printf+0x33f>
      }
    } else if(state == '%'){
 631:	83 bd 40 ff ff ff 25 	cmpl   $0x25,-0xc0(%rbp)
 638:	0f 85 32 02 00 00    	jne    870 <printf+0x33f>
      if(c == 'd'){
 63e:	83 bd 3c ff ff ff 64 	cmpl   $0x64,-0xc4(%rbp)
 645:	75 5e                	jne    6a5 <printf+0x174>
        printint(fd, va_arg(ap, int), 10, 1);
 647:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 64d:	83 f8 2f             	cmp    $0x2f,%eax
 650:	77 23                	ja     675 <printf+0x144>
 652:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 659:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 65f:	89 d2                	mov    %edx,%edx
 661:	48 01 d0             	add    %rdx,%rax
 664:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 66a:	83 c2 08             	add    $0x8,%edx
 66d:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 673:	eb 12                	jmp    687 <printf+0x156>
 675:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 67c:	48 8d 50 08          	lea    0x8(%rax),%rdx
 680:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 687:	8b 30                	mov    (%rax),%esi
 689:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 68f:	b9 01 00 00 00       	mov    $0x1,%ecx
 694:	ba 0a 00 00 00       	mov    $0xa,%edx
 699:	89 c7                	mov    %eax,%edi
 69b:	e8 d0 fd ff ff       	call   470 <printint>
 6a0:	e9 c1 01 00 00       	jmp    866 <printf+0x335>
      } else if(c == 'x' || c == 'p'){
 6a5:	83 bd 3c ff ff ff 78 	cmpl   $0x78,-0xc4(%rbp)
 6ac:	74 09                	je     6b7 <printf+0x186>
 6ae:	83 bd 3c ff ff ff 70 	cmpl   $0x70,-0xc4(%rbp)
 6b5:	75 5e                	jne    715 <printf+0x1e4>
        printint(fd, va_arg(ap, int), 16, 0);
 6b7:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 6bd:	83 f8 2f             	cmp    $0x2f,%eax
 6c0:	77 23                	ja     6e5 <printf+0x1b4>
 6c2:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 6c9:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 6cf:	89 d2                	mov    %edx,%edx
 6d1:	48 01 d0             	add    %rdx,%rax
 6d4:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 6da:	83 c2 08             	add    $0x8,%edx
 6dd:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 6e3:	eb 12                	jmp    6f7 <printf+0x1c6>
 6e5:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 6ec:	48 8d 50 08          	lea    0x8(%rax),%rdx
 6f0:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 6f7:	8b 30                	mov    (%rax),%esi
 6f9:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 6ff:	b9 00 00 00 00       	mov    $0x0,%ecx
 704:	ba 10 00 00 00       	mov    $0x10,%edx
 709:	89 c7                	mov    %eax,%edi
 70b:	e8 60 fd ff ff       	call   470 <printint>
 710:	e9 51 01 00 00       	jmp    866 <printf+0x335>
      } else if(c == 's'){
 715:	83 bd 3c ff ff ff 73 	cmpl   $0x73,-0xc4(%rbp)
 71c:	0f 85 98 00 00 00    	jne    7ba <printf+0x289>
        s = va_arg(ap, char*);
 722:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 728:	83 f8 2f             	cmp    $0x2f,%eax
 72b:	77 23                	ja     750 <printf+0x21f>
 72d:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 734:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 73a:	89 d2                	mov    %edx,%edx
 73c:	48 01 d0             	add    %rdx,%rax
 73f:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 745:	83 c2 08             	add    $0x8,%edx
 748:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 74e:	eb 12                	jmp    762 <printf+0x231>
 750:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 757:	48 8d 50 08          	lea    0x8(%rax),%rdx
 75b:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 762:	48 8b 00             	mov    (%rax),%rax
 765:	48 89 85 48 ff ff ff 	mov    %rax,-0xb8(%rbp)
        if(s == 0)
 76c:	48 83 bd 48 ff ff ff 	cmpq   $0x0,-0xb8(%rbp)
 773:	00 
 774:	75 31                	jne    7a7 <printf+0x276>
          s = "(null)";
 776:	48 c7 85 48 ff ff ff 	movq   $0xd4a,-0xb8(%rbp)
 77d:	4a 0d 00 00 
        while(*s != 0){
 781:	eb 24                	jmp    7a7 <printf+0x276>
          putc(fd, *s);
 783:	48 8b 85 48 ff ff ff 	mov    -0xb8(%rbp),%rax
 78a:	0f b6 00             	movzbl (%rax),%eax
 78d:	0f be d0             	movsbl %al,%edx
 790:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 796:	89 d6                	mov    %edx,%esi
 798:	89 c7                	mov    %eax,%edi
 79a:	e8 a8 fc ff ff       	call   447 <putc>
          s++;
 79f:	48 83 85 48 ff ff ff 	addq   $0x1,-0xb8(%rbp)
 7a6:	01 
        while(*s != 0){
 7a7:	48 8b 85 48 ff ff ff 	mov    -0xb8(%rbp),%rax
 7ae:	0f b6 00             	movzbl (%rax),%eax
 7b1:	84 c0                	test   %al,%al
 7b3:	75 ce                	jne    783 <printf+0x252>
 7b5:	e9 ac 00 00 00       	jmp    866 <printf+0x335>
        }
      } else if(c == 'c'){
 7ba:	83 bd 3c ff ff ff 63 	cmpl   $0x63,-0xc4(%rbp)
 7c1:	75 56                	jne    819 <printf+0x2e8>
        putc(fd, va_arg(ap, uint));
 7c3:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 7c9:	83 f8 2f             	cmp    $0x2f,%eax
 7cc:	77 23                	ja     7f1 <printf+0x2c0>
 7ce:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 7d5:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 7db:	89 d2                	mov    %edx,%edx
 7dd:	48 01 d0             	add    %rdx,%rax
 7e0:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 7e6:	83 c2 08             	add    $0x8,%edx
 7e9:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 7ef:	eb 12                	jmp    803 <printf+0x2d2>
 7f1:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 7f8:	48 8d 50 08          	lea    0x8(%rax),%rdx
 7fc:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 803:	8b 00                	mov    (%rax),%eax
 805:	0f be d0             	movsbl %al,%edx
 808:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 80e:	89 d6                	mov    %edx,%esi
 810:	89 c7                	mov    %eax,%edi
 812:	e8 30 fc ff ff       	call   447 <putc>
 817:	eb 4d                	jmp    866 <printf+0x335>
      } else if(c == '%'){
 819:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
 820:	75 1a                	jne    83c <printf+0x30b>
        putc(fd, c);
 822:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
 828:	0f be d0             	movsbl %al,%edx
 82b:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 831:	89 d6                	mov    %edx,%esi
 833:	89 c7                	mov    %eax,%edi
 835:	e8 0d fc ff ff       	call   447 <putc>
 83a:	eb 2a                	jmp    866 <printf+0x335>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 83c:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 842:	be 25 00 00 00       	mov    $0x25,%esi
 847:	89 c7                	mov    %eax,%edi
 849:	e8 f9 fb ff ff       	call   447 <putc>
        putc(fd, c);
 84e:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
 854:	0f be d0             	movsbl %al,%edx
 857:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 85d:	89 d6                	mov    %edx,%esi
 85f:	89 c7                	mov    %eax,%edi
 861:	e8 e1 fb ff ff       	call   447 <putc>
      }
      state = 0;
 866:	c7 85 40 ff ff ff 00 	movl   $0x0,-0xc0(%rbp)
 86d:	00 00 00 
  for(i = 0; fmt[i]; i++){
 870:	83 85 44 ff ff ff 01 	addl   $0x1,-0xbc(%rbp)
 877:	8b 85 44 ff ff ff    	mov    -0xbc(%rbp),%eax
 87d:	48 63 d0             	movslq %eax,%rdx
 880:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
 887:	48 01 d0             	add    %rdx,%rax
 88a:	0f b6 00             	movzbl (%rax),%eax
 88d:	84 c0                	test   %al,%al
 88f:	0f 85 3a fd ff ff    	jne    5cf <printf+0x9e>
    }
  }
}
 895:	90                   	nop
 896:	90                   	nop
 897:	c9                   	leave
 898:	c3                   	ret

0000000000000899 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 899:	55                   	push   %rbp
 89a:	48 89 e5             	mov    %rsp,%rbp
 89d:	48 83 ec 18          	sub    $0x18,%rsp
 8a1:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  Header *bp, *p;

  bp = (Header*)ap - 1;
 8a5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 8a9:	48 83 e8 10          	sub    $0x10,%rax
 8ad:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8b1:	48 8b 05 a8 07 00 00 	mov    0x7a8(%rip),%rax        # 1060 <freep>
 8b8:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 8bc:	eb 2f                	jmp    8ed <free+0x54>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8be:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 8c2:	48 8b 00             	mov    (%rax),%rax
 8c5:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 8c9:	72 17                	jb     8e2 <free+0x49>
 8cb:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 8cf:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 8d3:	72 2f                	jb     904 <free+0x6b>
 8d5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 8d9:	48 8b 00             	mov    (%rax),%rax
 8dc:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
 8e0:	72 22                	jb     904 <free+0x6b>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8e2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 8e6:	48 8b 00             	mov    (%rax),%rax
 8e9:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 8ed:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 8f1:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 8f5:	73 c7                	jae    8be <free+0x25>
 8f7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 8fb:	48 8b 00             	mov    (%rax),%rax
 8fe:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
 902:	73 ba                	jae    8be <free+0x25>
      break;
  if(bp + bp->s.size == p->s.ptr){
 904:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 908:	8b 40 08             	mov    0x8(%rax),%eax
 90b:	89 c0                	mov    %eax,%eax
 90d:	48 c1 e0 04          	shl    $0x4,%rax
 911:	48 89 c2             	mov    %rax,%rdx
 914:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 918:	48 01 c2             	add    %rax,%rdx
 91b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 91f:	48 8b 00             	mov    (%rax),%rax
 922:	48 39 c2             	cmp    %rax,%rdx
 925:	75 2d                	jne    954 <free+0xbb>
    bp->s.size += p->s.ptr->s.size;
 927:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 92b:	8b 50 08             	mov    0x8(%rax),%edx
 92e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 932:	48 8b 00             	mov    (%rax),%rax
 935:	8b 40 08             	mov    0x8(%rax),%eax
 938:	01 c2                	add    %eax,%edx
 93a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 93e:	89 50 08             	mov    %edx,0x8(%rax)
    bp->s.ptr = p->s.ptr->s.ptr;
 941:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 945:	48 8b 00             	mov    (%rax),%rax
 948:	48 8b 10             	mov    (%rax),%rdx
 94b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 94f:	48 89 10             	mov    %rdx,(%rax)
 952:	eb 0e                	jmp    962 <free+0xc9>
  } else
    bp->s.ptr = p->s.ptr;
 954:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 958:	48 8b 10             	mov    (%rax),%rdx
 95b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 95f:	48 89 10             	mov    %rdx,(%rax)
  if(p + p->s.size == bp){
 962:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 966:	8b 40 08             	mov    0x8(%rax),%eax
 969:	89 c0                	mov    %eax,%eax
 96b:	48 c1 e0 04          	shl    $0x4,%rax
 96f:	48 89 c2             	mov    %rax,%rdx
 972:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 976:	48 01 d0             	add    %rdx,%rax
 979:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
 97d:	75 27                	jne    9a6 <free+0x10d>
    p->s.size += bp->s.size;
 97f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 983:	8b 50 08             	mov    0x8(%rax),%edx
 986:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 98a:	8b 40 08             	mov    0x8(%rax),%eax
 98d:	01 c2                	add    %eax,%edx
 98f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 993:	89 50 08             	mov    %edx,0x8(%rax)
    p->s.ptr = bp->s.ptr;
 996:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 99a:	48 8b 10             	mov    (%rax),%rdx
 99d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 9a1:	48 89 10             	mov    %rdx,(%rax)
 9a4:	eb 0b                	jmp    9b1 <free+0x118>
  } else
    p->s.ptr = bp;
 9a6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 9aa:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
 9ae:	48 89 10             	mov    %rdx,(%rax)
  freep = p;
 9b1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 9b5:	48 89 05 a4 06 00 00 	mov    %rax,0x6a4(%rip)        # 1060 <freep>
}
 9bc:	90                   	nop
 9bd:	c9                   	leave
 9be:	c3                   	ret

00000000000009bf <morecore>:

static Header*
morecore(uint nu)
{
 9bf:	55                   	push   %rbp
 9c0:	48 89 e5             	mov    %rsp,%rbp
 9c3:	48 83 ec 20          	sub    $0x20,%rsp
 9c7:	89 7d ec             	mov    %edi,-0x14(%rbp)
  char *p;
  Header *hp;

  if(nu < 4096)
 9ca:	81 7d ec ff 0f 00 00 	cmpl   $0xfff,-0x14(%rbp)
 9d1:	77 07                	ja     9da <morecore+0x1b>
    nu = 4096;
 9d3:	c7 45 ec 00 10 00 00 	movl   $0x1000,-0x14(%rbp)
  p = sbrk(nu * sizeof(Header));
 9da:	8b 45 ec             	mov    -0x14(%rbp),%eax
 9dd:	c1 e0 04             	shl    $0x4,%eax
 9e0:	89 c7                	mov    %eax,%edi
 9e2:	e8 20 fa ff ff       	call   407 <sbrk>
 9e7:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  if(p == (char*)-1)
 9eb:	48 83 7d f8 ff       	cmpq   $0xffffffffffffffff,-0x8(%rbp)
 9f0:	75 07                	jne    9f9 <morecore+0x3a>
    return 0;
 9f2:	b8 00 00 00 00       	mov    $0x0,%eax
 9f7:	eb 29                	jmp    a22 <morecore+0x63>
  hp = (Header*)p;
 9f9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 9fd:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  hp->s.size = nu;
 a01:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 a05:	8b 55 ec             	mov    -0x14(%rbp),%edx
 a08:	89 50 08             	mov    %edx,0x8(%rax)
  free((void*)(hp + 1));
 a0b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 a0f:	48 83 c0 10          	add    $0x10,%rax
 a13:	48 89 c7             	mov    %rax,%rdi
 a16:	e8 7e fe ff ff       	call   899 <free>
  return freep;
 a1b:	48 8b 05 3e 06 00 00 	mov    0x63e(%rip),%rax        # 1060 <freep>
}
 a22:	c9                   	leave
 a23:	c3                   	ret

0000000000000a24 <malloc>:

void*
malloc(uint nbytes)
{
 a24:	55                   	push   %rbp
 a25:	48 89 e5             	mov    %rsp,%rbp
 a28:	48 83 ec 30          	sub    $0x30,%rsp
 a2c:	89 7d dc             	mov    %edi,-0x24(%rbp)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 a2f:	8b 45 dc             	mov    -0x24(%rbp),%eax
 a32:	48 83 c0 0f          	add    $0xf,%rax
 a36:	48 c1 e8 04          	shr    $0x4,%rax
 a3a:	83 c0 01             	add    $0x1,%eax
 a3d:	89 45 ec             	mov    %eax,-0x14(%rbp)
  if((prevp = freep) == 0){
 a40:	48 8b 05 19 06 00 00 	mov    0x619(%rip),%rax        # 1060 <freep>
 a47:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
 a4b:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
 a50:	75 2b                	jne    a7d <malloc+0x59>
    base.s.ptr = freep = prevp = &base;
 a52:	48 c7 45 f0 50 10 00 	movq   $0x1050,-0x10(%rbp)
 a59:	00 
 a5a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 a5e:	48 89 05 fb 05 00 00 	mov    %rax,0x5fb(%rip)        # 1060 <freep>
 a65:	48 8b 05 f4 05 00 00 	mov    0x5f4(%rip),%rax        # 1060 <freep>
 a6c:	48 89 05 dd 05 00 00 	mov    %rax,0x5dd(%rip)        # 1050 <base>
    base.s.size = 0;
 a73:	c7 05 db 05 00 00 00 	movl   $0x0,0x5db(%rip)        # 1058 <base+0x8>
 a7a:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a7d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 a81:	48 8b 00             	mov    (%rax),%rax
 a84:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
 a88:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a8c:	8b 40 08             	mov    0x8(%rax),%eax
 a8f:	3b 45 ec             	cmp    -0x14(%rbp),%eax
 a92:	72 5f                	jb     af3 <malloc+0xcf>
      if(p->s.size == nunits)
 a94:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a98:	8b 40 08             	mov    0x8(%rax),%eax
 a9b:	39 45 ec             	cmp    %eax,-0x14(%rbp)
 a9e:	75 10                	jne    ab0 <malloc+0x8c>
        prevp->s.ptr = p->s.ptr;
 aa0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 aa4:	48 8b 10             	mov    (%rax),%rdx
 aa7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 aab:	48 89 10             	mov    %rdx,(%rax)
 aae:	eb 2e                	jmp    ade <malloc+0xba>
      else {
        p->s.size -= nunits;
 ab0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 ab4:	8b 40 08             	mov    0x8(%rax),%eax
 ab7:	2b 45 ec             	sub    -0x14(%rbp),%eax
 aba:	89 c2                	mov    %eax,%edx
 abc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 ac0:	89 50 08             	mov    %edx,0x8(%rax)
        p += p->s.size;
 ac3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 ac7:	8b 40 08             	mov    0x8(%rax),%eax
 aca:	89 c0                	mov    %eax,%eax
 acc:	48 c1 e0 04          	shl    $0x4,%rax
 ad0:	48 01 45 f8          	add    %rax,-0x8(%rbp)
        p->s.size = nunits;
 ad4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 ad8:	8b 55 ec             	mov    -0x14(%rbp),%edx
 adb:	89 50 08             	mov    %edx,0x8(%rax)
      }
      freep = prevp;
 ade:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 ae2:	48 89 05 77 05 00 00 	mov    %rax,0x577(%rip)        # 1060 <freep>
      return (void*)(p + 1);
 ae9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 aed:	48 83 c0 10          	add    $0x10,%rax
 af1:	eb 41                	jmp    b34 <malloc+0x110>
    }
    if(p == freep)
 af3:	48 8b 05 66 05 00 00 	mov    0x566(%rip),%rax        # 1060 <freep>
 afa:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 afe:	75 1c                	jne    b1c <malloc+0xf8>
      if((p = morecore(nunits)) == 0)
 b00:	8b 45 ec             	mov    -0x14(%rbp),%eax
 b03:	89 c7                	mov    %eax,%edi
 b05:	e8 b5 fe ff ff       	call   9bf <morecore>
 b0a:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 b0e:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
 b13:	75 07                	jne    b1c <malloc+0xf8>
        return 0;
 b15:	b8 00 00 00 00       	mov    $0x0,%eax
 b1a:	eb 18                	jmp    b34 <malloc+0x110>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 b1c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b20:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
 b24:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b28:	48 8b 00             	mov    (%rax),%rax
 b2b:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
 b2f:	e9 54 ff ff ff       	jmp    a88 <malloc+0x64>
  }
}
 b34:	c9                   	leave
 b35:	c3                   	ret

0000000000000b36 <createRoot>:
#include "set.h"
#include "user.h"

//TODO: Να μην είναι περιορισμένο σε int

Set* createRoot(){
 b36:	55                   	push   %rbp
 b37:	48 89 e5             	mov    %rsp,%rbp
 b3a:	48 83 ec 10          	sub    $0x10,%rsp
    //Αρχικοποίηση του Set
    Set *set = malloc(sizeof(Set));
 b3e:	bf 10 00 00 00       	mov    $0x10,%edi
 b43:	e8 dc fe ff ff       	call   a24 <malloc>
 b48:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    set->size = 0;
 b4c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b50:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%rax)
    set->root = NULL;
 b57:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b5b:	48 c7 00 00 00 00 00 	movq   $0x0,(%rax)
    return set;
 b62:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
 b66:	c9                   	leave
 b67:	c3                   	ret

0000000000000b68 <createNode>:

void createNode(int i, Set *set){
 b68:	55                   	push   %rbp
 b69:	48 89 e5             	mov    %rsp,%rbp
 b6c:	48 83 ec 20          	sub    $0x20,%rsp
 b70:	89 7d ec             	mov    %edi,-0x14(%rbp)
 b73:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    Η συνάρτηση αυτή δημιουργεί ένα νέο SetNode με την τιμή i και εφόσον δεν υπάρχει στο Set το προσθέτει στο τέλος του συνόλου.
    Σημείωση: Ίσως υπάρχει καλύτερος τρόπος για την υλοποίηση.
    */

    //Αρχικοποίηση του SetNode
    SetNode *temp = malloc(sizeof(SetNode));
 b77:	bf 10 00 00 00       	mov    $0x10,%edi
 b7c:	e8 a3 fe ff ff       	call   a24 <malloc>
 b81:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    temp->i = i;
 b85:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 b89:	8b 55 ec             	mov    -0x14(%rbp),%edx
 b8c:	89 10                	mov    %edx,(%rax)
    temp->next = NULL;
 b8e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 b92:	48 c7 40 08 00 00 00 	movq   $0x0,0x8(%rax)
 b99:	00 

    //Έλεγχος ύπαρξης του i
    SetNode *curr = set->root;//Ξεκινάει από την root
 b9a:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
 b9e:	48 8b 00             	mov    (%rax),%rax
 ba1:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(curr != NULL) { //Εφόσον το Set δεν είναι άδειο
 ba5:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
 baa:	74 34                	je     be0 <createNode+0x78>
        while (curr->next != NULL){ //Εφόσον υπάρχει επόμενο node
 bac:	eb 25                	jmp    bd3 <createNode+0x6b>
            if (curr->i == i){ //Αν το i υπάρχει στο σύνολο
 bae:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 bb2:	8b 00                	mov    (%rax),%eax
 bb4:	39 45 ec             	cmp    %eax,-0x14(%rbp)
 bb7:	75 0e                	jne    bc7 <createNode+0x5f>
                free(temp); 
 bb9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 bbd:	48 89 c7             	mov    %rax,%rdi
 bc0:	e8 d4 fc ff ff       	call   899 <free>
                return; //Δεν εκτελούμε την υπόλοιπη συνάρτηση
 bc5:	eb 4e                	jmp    c15 <createNode+0xad>
            }
            curr = curr->next; //Επόμενο SetNode
 bc7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 bcb:	48 8b 40 08          	mov    0x8(%rax),%rax
 bcf:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
        while (curr->next != NULL){ //Εφόσον υπάρχει επόμενο node
 bd3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 bd7:	48 8b 40 08          	mov    0x8(%rax),%rax
 bdb:	48 85 c0             	test   %rax,%rax
 bde:	75 ce                	jne    bae <createNode+0x46>
        }
    }
    /*
    Ο έλεγχος στην if είναι απαραίτητος για να ελεγχθεί το τελευταίο SetNode.
    */
    if (curr->i != i) attachNode(set, curr, temp); 
 be0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 be4:	8b 00                	mov    (%rax),%eax
 be6:	39 45 ec             	cmp    %eax,-0x14(%rbp)
 be9:	74 1e                	je     c09 <createNode+0xa1>
 beb:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
 bef:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
 bf3:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
 bf7:	48 89 ce             	mov    %rcx,%rsi
 bfa:	48 89 c7             	mov    %rax,%rdi
 bfd:	b8 00 00 00 00       	mov    $0x0,%eax
 c02:	e8 10 00 00 00       	call   c17 <attachNode>
 c07:	eb 0c                	jmp    c15 <createNode+0xad>
    else free(temp);
 c09:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 c0d:	48 89 c7             	mov    %rax,%rdi
 c10:	e8 84 fc ff ff       	call   899 <free>
}
 c15:	c9                   	leave
 c16:	c3                   	ret

0000000000000c17 <attachNode>:

void attachNode(Set *set, SetNode *curr, SetNode *temp){
 c17:	55                   	push   %rbp
 c18:	48 89 e5             	mov    %rsp,%rbp
 c1b:	48 83 ec 18          	sub    $0x18,%rsp
 c1f:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
 c23:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
 c27:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
    //Βάζουμε το temp στο τέλος του Set
    if(set->size == 0) set->root = temp;
 c2b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 c2f:	8b 40 08             	mov    0x8(%rax),%eax
 c32:	85 c0                	test   %eax,%eax
 c34:	75 0d                	jne    c43 <attachNode+0x2c>
 c36:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 c3a:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
 c3e:	48 89 10             	mov    %rdx,(%rax)
 c41:	eb 0c                	jmp    c4f <attachNode+0x38>
    else curr->next = temp;
 c43:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 c47:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
 c4b:	48 89 50 08          	mov    %rdx,0x8(%rax)
    set->size += 1;
 c4f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 c53:	8b 40 08             	mov    0x8(%rax),%eax
 c56:	8d 50 01             	lea    0x1(%rax),%edx
 c59:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 c5d:	89 50 08             	mov    %edx,0x8(%rax)
}
 c60:	90                   	nop
 c61:	c9                   	leave
 c62:	c3                   	ret

0000000000000c63 <deleteSet>:

void deleteSet(Set *set){
 c63:	55                   	push   %rbp
 c64:	48 89 e5             	mov    %rsp,%rbp
 c67:	48 83 ec 20          	sub    $0x20,%rsp
 c6b:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    if (set == NULL) return; //Αν ο χρήστης είναι ΜΛΚ!
 c6f:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
 c74:	74 42                	je     cb8 <deleteSet+0x55>
    SetNode *temp;
    SetNode *curr = set->root; //Ξεκινάμε από το root
 c76:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 c7a:	48 8b 00             	mov    (%rax),%rax
 c7d:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    while (curr != NULL){ 
 c81:	eb 20                	jmp    ca3 <deleteSet+0x40>
        temp = curr->next; //Αναφορά στο επόμενο SetNode
 c83:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 c87:	48 8b 40 08          	mov    0x8(%rax),%rax
 c8b:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
        free(curr); //Απελευθέρωση της curr
 c8f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 c93:	48 89 c7             	mov    %rax,%rdi
 c96:	e8 fe fb ff ff       	call   899 <free>
        curr = temp;
 c9b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 c9f:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    while (curr != NULL){ 
 ca3:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
 ca8:	75 d9                	jne    c83 <deleteSet+0x20>
    }
    free(set); //Διαγραφή του Set
 caa:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 cae:	48 89 c7             	mov    %rax,%rdi
 cb1:	e8 e3 fb ff ff       	call   899 <free>
 cb6:	eb 01                	jmp    cb9 <deleteSet+0x56>
    if (set == NULL) return; //Αν ο χρήστης είναι ΜΛΚ!
 cb8:	90                   	nop
}
 cb9:	c9                   	leave
 cba:	c3                   	ret

0000000000000cbb <getNodeAtPosition>:

SetNode* getNodeAtPosition(Set *set, int i){
 cbb:	55                   	push   %rbp
 cbc:	48 89 e5             	mov    %rsp,%rbp
 cbf:	48 83 ec 20          	sub    $0x20,%rsp
 cc3:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
 cc7:	89 75 e4             	mov    %esi,-0x1c(%rbp)
    if (set == NULL || set->root == NULL) return NULL; //Αν ο χρήστης είναι ΜΛΚ!
 cca:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
 ccf:	74 0c                	je     cdd <getNodeAtPosition+0x22>
 cd1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 cd5:	48 8b 00             	mov    (%rax),%rax
 cd8:	48 85 c0             	test   %rax,%rax
 cdb:	75 07                	jne    ce4 <getNodeAtPosition+0x29>
 cdd:	b8 00 00 00 00       	mov    $0x0,%eax
 ce2:	eb 3d                	jmp    d21 <getNodeAtPosition+0x66>

    SetNode *curr = set->root;
 ce4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 ce8:	48 8b 00             	mov    (%rax),%rax
 ceb:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    int n;

    for(n = 0; n<i && curr->next != NULL; n++) curr = curr->next; //Ο έλεγχος εδω είναι: n<i && curr->next != NULL
 cef:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
 cf6:	eb 10                	jmp    d08 <getNodeAtPosition+0x4d>
 cf8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 cfc:	48 8b 40 08          	mov    0x8(%rax),%rax
 d00:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 d04:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
 d08:	8b 45 f4             	mov    -0xc(%rbp),%eax
 d0b:	3b 45 e4             	cmp    -0x1c(%rbp),%eax
 d0e:	7d 0d                	jge    d1d <getNodeAtPosition+0x62>
 d10:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 d14:	48 8b 40 08          	mov    0x8(%rax),%rax
 d18:	48 85 c0             	test   %rax,%rax
 d1b:	75 db                	jne    cf8 <getNodeAtPosition+0x3d>
    return curr;
 d1d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 d21:	c9                   	leave
 d22:	c3                   	ret
