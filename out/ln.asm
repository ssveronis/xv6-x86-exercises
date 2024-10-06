
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
  15:	48 c7 c6 16 0b 00 00 	mov    $0xb16,%rsi
  1c:	bf 02 00 00 00       	mov    $0x2,%edi
  21:	b8 00 00 00 00       	mov    $0x0,%eax
  26:	e8 e6 04 00 00       	call   511 <printf>
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
  71:	48 c7 c6 29 0b 00 00 	mov    $0xb29,%rsi
  78:	bf 02 00 00 00       	mov    $0x2,%edi
  7d:	b8 00 00 00 00       	mov    $0x0,%eax
  82:	e8 8a 04 00 00       	call   511 <printf>
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

0000000000000427 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 427:	55                   	push   %rbp
 428:	48 89 e5             	mov    %rsp,%rbp
 42b:	48 83 ec 10          	sub    $0x10,%rsp
 42f:	89 7d fc             	mov    %edi,-0x4(%rbp)
 432:	89 f0                	mov    %esi,%eax
 434:	88 45 f8             	mov    %al,-0x8(%rbp)
  write(fd, &c, 1);
 437:	48 8d 4d f8          	lea    -0x8(%rbp),%rcx
 43b:	8b 45 fc             	mov    -0x4(%rbp),%eax
 43e:	ba 01 00 00 00       	mov    $0x1,%edx
 443:	48 89 ce             	mov    %rcx,%rsi
 446:	89 c7                	mov    %eax,%edi
 448:	e8 52 ff ff ff       	call   39f <write>
}
 44d:	90                   	nop
 44e:	c9                   	leave
 44f:	c3                   	ret

0000000000000450 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 450:	55                   	push   %rbp
 451:	48 89 e5             	mov    %rsp,%rbp
 454:	48 83 ec 30          	sub    $0x30,%rsp
 458:	89 7d dc             	mov    %edi,-0x24(%rbp)
 45b:	89 75 d8             	mov    %esi,-0x28(%rbp)
 45e:	89 55 d4             	mov    %edx,-0x2c(%rbp)
 461:	89 4d d0             	mov    %ecx,-0x30(%rbp)
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 464:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
  if(sgn && xx < 0){
 46b:	83 7d d0 00          	cmpl   $0x0,-0x30(%rbp)
 46f:	74 17                	je     488 <printint+0x38>
 471:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
 475:	79 11                	jns    488 <printint+0x38>
    neg = 1;
 477:	c7 45 f8 01 00 00 00 	movl   $0x1,-0x8(%rbp)
    x = -xx;
 47e:	8b 45 d8             	mov    -0x28(%rbp),%eax
 481:	f7 d8                	neg    %eax
 483:	89 45 f4             	mov    %eax,-0xc(%rbp)
 486:	eb 06                	jmp    48e <printint+0x3e>
  } else {
    x = xx;
 488:	8b 45 d8             	mov    -0x28(%rbp),%eax
 48b:	89 45 f4             	mov    %eax,-0xc(%rbp)
  }

  i = 0;
 48e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  do{
    buf[i++] = digits[x % base];
 495:	8b 4d d4             	mov    -0x2c(%rbp),%ecx
 498:	8b 45 f4             	mov    -0xc(%rbp),%eax
 49b:	ba 00 00 00 00       	mov    $0x0,%edx
 4a0:	f7 f1                	div    %ecx
 4a2:	89 d1                	mov    %edx,%ecx
 4a4:	8b 45 fc             	mov    -0x4(%rbp),%eax
 4a7:	8d 50 01             	lea    0x1(%rax),%edx
 4aa:	89 55 fc             	mov    %edx,-0x4(%rbp)
 4ad:	89 ca                	mov    %ecx,%edx
 4af:	0f b6 92 80 0d 00 00 	movzbl 0xd80(%rdx),%edx
 4b6:	48 98                	cltq
 4b8:	88 54 05 e0          	mov    %dl,-0x20(%rbp,%rax,1)
  }while((x /= base) != 0);
 4bc:	8b 75 d4             	mov    -0x2c(%rbp),%esi
 4bf:	8b 45 f4             	mov    -0xc(%rbp),%eax
 4c2:	ba 00 00 00 00       	mov    $0x0,%edx
 4c7:	f7 f6                	div    %esi
 4c9:	89 45 f4             	mov    %eax,-0xc(%rbp)
 4cc:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
 4d0:	75 c3                	jne    495 <printint+0x45>
  if(neg)
 4d2:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
 4d6:	74 2b                	je     503 <printint+0xb3>
    buf[i++] = '-';
 4d8:	8b 45 fc             	mov    -0x4(%rbp),%eax
 4db:	8d 50 01             	lea    0x1(%rax),%edx
 4de:	89 55 fc             	mov    %edx,-0x4(%rbp)
 4e1:	48 98                	cltq
 4e3:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%rbp,%rax,1)

  while(--i >= 0)
 4e8:	eb 19                	jmp    503 <printint+0xb3>
    putc(fd, buf[i]);
 4ea:	8b 45 fc             	mov    -0x4(%rbp),%eax
 4ed:	48 98                	cltq
 4ef:	0f b6 44 05 e0       	movzbl -0x20(%rbp,%rax,1),%eax
 4f4:	0f be d0             	movsbl %al,%edx
 4f7:	8b 45 dc             	mov    -0x24(%rbp),%eax
 4fa:	89 d6                	mov    %edx,%esi
 4fc:	89 c7                	mov    %eax,%edi
 4fe:	e8 24 ff ff ff       	call   427 <putc>
  while(--i >= 0)
 503:	83 6d fc 01          	subl   $0x1,-0x4(%rbp)
 507:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
 50b:	79 dd                	jns    4ea <printint+0x9a>
}
 50d:	90                   	nop
 50e:	90                   	nop
 50f:	c9                   	leave
 510:	c3                   	ret

0000000000000511 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 511:	55                   	push   %rbp
 512:	48 89 e5             	mov    %rsp,%rbp
 515:	48 81 ec f0 00 00 00 	sub    $0xf0,%rsp
 51c:	89 bd 1c ff ff ff    	mov    %edi,-0xe4(%rbp)
 522:	48 89 b5 10 ff ff ff 	mov    %rsi,-0xf0(%rbp)
 529:	48 89 95 60 ff ff ff 	mov    %rdx,-0xa0(%rbp)
 530:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
 537:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
 53e:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
 545:	84 c0                	test   %al,%al
 547:	74 20                	je     569 <printf+0x58>
 549:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
 54d:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
 551:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
 555:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
 559:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
 55d:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
 561:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
 565:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  va_list ap;
  char *s;
  int c, i, state;
  va_start(ap, fmt);
 569:	c7 85 20 ff ff ff 10 	movl   $0x10,-0xe0(%rbp)
 570:	00 00 00 
 573:	c7 85 24 ff ff ff 30 	movl   $0x30,-0xdc(%rbp)
 57a:	00 00 00 
 57d:	48 8d 45 10          	lea    0x10(%rbp),%rax
 581:	48 89 85 28 ff ff ff 	mov    %rax,-0xd8(%rbp)
 588:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
 58f:	48 89 85 30 ff ff ff 	mov    %rax,-0xd0(%rbp)

  state = 0;
 596:	c7 85 40 ff ff ff 00 	movl   $0x0,-0xc0(%rbp)
 59d:	00 00 00 
  for(i = 0; fmt[i]; i++){
 5a0:	c7 85 44 ff ff ff 00 	movl   $0x0,-0xbc(%rbp)
 5a7:	00 00 00 
 5aa:	e9 a8 02 00 00       	jmp    857 <printf+0x346>
    c = fmt[i] & 0xff;
 5af:	8b 85 44 ff ff ff    	mov    -0xbc(%rbp),%eax
 5b5:	48 63 d0             	movslq %eax,%rdx
 5b8:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
 5bf:	48 01 d0             	add    %rdx,%rax
 5c2:	0f b6 00             	movzbl (%rax),%eax
 5c5:	0f be c0             	movsbl %al,%eax
 5c8:	25 ff 00 00 00       	and    $0xff,%eax
 5cd:	89 85 3c ff ff ff    	mov    %eax,-0xc4(%rbp)
    if(state == 0){
 5d3:	83 bd 40 ff ff ff 00 	cmpl   $0x0,-0xc0(%rbp)
 5da:	75 35                	jne    611 <printf+0x100>
      if(c == '%'){
 5dc:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
 5e3:	75 0f                	jne    5f4 <printf+0xe3>
        state = '%';
 5e5:	c7 85 40 ff ff ff 25 	movl   $0x25,-0xc0(%rbp)
 5ec:	00 00 00 
 5ef:	e9 5c 02 00 00       	jmp    850 <printf+0x33f>
      } else {
        putc(fd, c);
 5f4:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
 5fa:	0f be d0             	movsbl %al,%edx
 5fd:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 603:	89 d6                	mov    %edx,%esi
 605:	89 c7                	mov    %eax,%edi
 607:	e8 1b fe ff ff       	call   427 <putc>
 60c:	e9 3f 02 00 00       	jmp    850 <printf+0x33f>
      }
    } else if(state == '%'){
 611:	83 bd 40 ff ff ff 25 	cmpl   $0x25,-0xc0(%rbp)
 618:	0f 85 32 02 00 00    	jne    850 <printf+0x33f>
      if(c == 'd'){
 61e:	83 bd 3c ff ff ff 64 	cmpl   $0x64,-0xc4(%rbp)
 625:	75 5e                	jne    685 <printf+0x174>
        printint(fd, va_arg(ap, int), 10, 1);
 627:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 62d:	83 f8 2f             	cmp    $0x2f,%eax
 630:	77 23                	ja     655 <printf+0x144>
 632:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 639:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 63f:	89 d2                	mov    %edx,%edx
 641:	48 01 d0             	add    %rdx,%rax
 644:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 64a:	83 c2 08             	add    $0x8,%edx
 64d:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 653:	eb 12                	jmp    667 <printf+0x156>
 655:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 65c:	48 8d 50 08          	lea    0x8(%rax),%rdx
 660:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 667:	8b 30                	mov    (%rax),%esi
 669:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 66f:	b9 01 00 00 00       	mov    $0x1,%ecx
 674:	ba 0a 00 00 00       	mov    $0xa,%edx
 679:	89 c7                	mov    %eax,%edi
 67b:	e8 d0 fd ff ff       	call   450 <printint>
 680:	e9 c1 01 00 00       	jmp    846 <printf+0x335>
      } else if(c == 'x' || c == 'p'){
 685:	83 bd 3c ff ff ff 78 	cmpl   $0x78,-0xc4(%rbp)
 68c:	74 09                	je     697 <printf+0x186>
 68e:	83 bd 3c ff ff ff 70 	cmpl   $0x70,-0xc4(%rbp)
 695:	75 5e                	jne    6f5 <printf+0x1e4>
        printint(fd, va_arg(ap, int), 16, 0);
 697:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 69d:	83 f8 2f             	cmp    $0x2f,%eax
 6a0:	77 23                	ja     6c5 <printf+0x1b4>
 6a2:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 6a9:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 6af:	89 d2                	mov    %edx,%edx
 6b1:	48 01 d0             	add    %rdx,%rax
 6b4:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 6ba:	83 c2 08             	add    $0x8,%edx
 6bd:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 6c3:	eb 12                	jmp    6d7 <printf+0x1c6>
 6c5:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 6cc:	48 8d 50 08          	lea    0x8(%rax),%rdx
 6d0:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 6d7:	8b 30                	mov    (%rax),%esi
 6d9:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 6df:	b9 00 00 00 00       	mov    $0x0,%ecx
 6e4:	ba 10 00 00 00       	mov    $0x10,%edx
 6e9:	89 c7                	mov    %eax,%edi
 6eb:	e8 60 fd ff ff       	call   450 <printint>
 6f0:	e9 51 01 00 00       	jmp    846 <printf+0x335>
      } else if(c == 's'){
 6f5:	83 bd 3c ff ff ff 73 	cmpl   $0x73,-0xc4(%rbp)
 6fc:	0f 85 98 00 00 00    	jne    79a <printf+0x289>
        s = va_arg(ap, char*);
 702:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 708:	83 f8 2f             	cmp    $0x2f,%eax
 70b:	77 23                	ja     730 <printf+0x21f>
 70d:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 714:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 71a:	89 d2                	mov    %edx,%edx
 71c:	48 01 d0             	add    %rdx,%rax
 71f:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 725:	83 c2 08             	add    $0x8,%edx
 728:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 72e:	eb 12                	jmp    742 <printf+0x231>
 730:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 737:	48 8d 50 08          	lea    0x8(%rax),%rdx
 73b:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 742:	48 8b 00             	mov    (%rax),%rax
 745:	48 89 85 48 ff ff ff 	mov    %rax,-0xb8(%rbp)
        if(s == 0)
 74c:	48 83 bd 48 ff ff ff 	cmpq   $0x0,-0xb8(%rbp)
 753:	00 
 754:	75 31                	jne    787 <printf+0x276>
          s = "(null)";
 756:	48 c7 85 48 ff ff ff 	movq   $0xb3d,-0xb8(%rbp)
 75d:	3d 0b 00 00 
        while(*s != 0){
 761:	eb 24                	jmp    787 <printf+0x276>
          putc(fd, *s);
 763:	48 8b 85 48 ff ff ff 	mov    -0xb8(%rbp),%rax
 76a:	0f b6 00             	movzbl (%rax),%eax
 76d:	0f be d0             	movsbl %al,%edx
 770:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 776:	89 d6                	mov    %edx,%esi
 778:	89 c7                	mov    %eax,%edi
 77a:	e8 a8 fc ff ff       	call   427 <putc>
          s++;
 77f:	48 83 85 48 ff ff ff 	addq   $0x1,-0xb8(%rbp)
 786:	01 
        while(*s != 0){
 787:	48 8b 85 48 ff ff ff 	mov    -0xb8(%rbp),%rax
 78e:	0f b6 00             	movzbl (%rax),%eax
 791:	84 c0                	test   %al,%al
 793:	75 ce                	jne    763 <printf+0x252>
 795:	e9 ac 00 00 00       	jmp    846 <printf+0x335>
        }
      } else if(c == 'c'){
 79a:	83 bd 3c ff ff ff 63 	cmpl   $0x63,-0xc4(%rbp)
 7a1:	75 56                	jne    7f9 <printf+0x2e8>
        putc(fd, va_arg(ap, uint));
 7a3:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 7a9:	83 f8 2f             	cmp    $0x2f,%eax
 7ac:	77 23                	ja     7d1 <printf+0x2c0>
 7ae:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 7b5:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 7bb:	89 d2                	mov    %edx,%edx
 7bd:	48 01 d0             	add    %rdx,%rax
 7c0:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 7c6:	83 c2 08             	add    $0x8,%edx
 7c9:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 7cf:	eb 12                	jmp    7e3 <printf+0x2d2>
 7d1:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 7d8:	48 8d 50 08          	lea    0x8(%rax),%rdx
 7dc:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 7e3:	8b 00                	mov    (%rax),%eax
 7e5:	0f be d0             	movsbl %al,%edx
 7e8:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 7ee:	89 d6                	mov    %edx,%esi
 7f0:	89 c7                	mov    %eax,%edi
 7f2:	e8 30 fc ff ff       	call   427 <putc>
 7f7:	eb 4d                	jmp    846 <printf+0x335>
      } else if(c == '%'){
 7f9:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
 800:	75 1a                	jne    81c <printf+0x30b>
        putc(fd, c);
 802:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
 808:	0f be d0             	movsbl %al,%edx
 80b:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 811:	89 d6                	mov    %edx,%esi
 813:	89 c7                	mov    %eax,%edi
 815:	e8 0d fc ff ff       	call   427 <putc>
 81a:	eb 2a                	jmp    846 <printf+0x335>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 81c:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 822:	be 25 00 00 00       	mov    $0x25,%esi
 827:	89 c7                	mov    %eax,%edi
 829:	e8 f9 fb ff ff       	call   427 <putc>
        putc(fd, c);
 82e:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
 834:	0f be d0             	movsbl %al,%edx
 837:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 83d:	89 d6                	mov    %edx,%esi
 83f:	89 c7                	mov    %eax,%edi
 841:	e8 e1 fb ff ff       	call   427 <putc>
      }
      state = 0;
 846:	c7 85 40 ff ff ff 00 	movl   $0x0,-0xc0(%rbp)
 84d:	00 00 00 
  for(i = 0; fmt[i]; i++){
 850:	83 85 44 ff ff ff 01 	addl   $0x1,-0xbc(%rbp)
 857:	8b 85 44 ff ff ff    	mov    -0xbc(%rbp),%eax
 85d:	48 63 d0             	movslq %eax,%rdx
 860:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
 867:	48 01 d0             	add    %rdx,%rax
 86a:	0f b6 00             	movzbl (%rax),%eax
 86d:	84 c0                	test   %al,%al
 86f:	0f 85 3a fd ff ff    	jne    5af <printf+0x9e>
    }
  }
}
 875:	90                   	nop
 876:	90                   	nop
 877:	c9                   	leave
 878:	c3                   	ret

0000000000000879 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 879:	55                   	push   %rbp
 87a:	48 89 e5             	mov    %rsp,%rbp
 87d:	48 83 ec 18          	sub    $0x18,%rsp
 881:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  Header *bp, *p;

  bp = (Header*)ap - 1;
 885:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 889:	48 83 e8 10          	sub    $0x10,%rax
 88d:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 891:	48 8b 05 18 05 00 00 	mov    0x518(%rip),%rax        # db0 <freep>
 898:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 89c:	eb 2f                	jmp    8cd <free+0x54>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 89e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 8a2:	48 8b 00             	mov    (%rax),%rax
 8a5:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 8a9:	72 17                	jb     8c2 <free+0x49>
 8ab:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 8af:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 8b3:	72 2f                	jb     8e4 <free+0x6b>
 8b5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 8b9:	48 8b 00             	mov    (%rax),%rax
 8bc:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
 8c0:	72 22                	jb     8e4 <free+0x6b>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8c2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 8c6:	48 8b 00             	mov    (%rax),%rax
 8c9:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 8cd:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 8d1:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 8d5:	73 c7                	jae    89e <free+0x25>
 8d7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 8db:	48 8b 00             	mov    (%rax),%rax
 8de:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
 8e2:	73 ba                	jae    89e <free+0x25>
      break;
  if(bp + bp->s.size == p->s.ptr){
 8e4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 8e8:	8b 40 08             	mov    0x8(%rax),%eax
 8eb:	89 c0                	mov    %eax,%eax
 8ed:	48 c1 e0 04          	shl    $0x4,%rax
 8f1:	48 89 c2             	mov    %rax,%rdx
 8f4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 8f8:	48 01 c2             	add    %rax,%rdx
 8fb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 8ff:	48 8b 00             	mov    (%rax),%rax
 902:	48 39 c2             	cmp    %rax,%rdx
 905:	75 2d                	jne    934 <free+0xbb>
    bp->s.size += p->s.ptr->s.size;
 907:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 90b:	8b 50 08             	mov    0x8(%rax),%edx
 90e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 912:	48 8b 00             	mov    (%rax),%rax
 915:	8b 40 08             	mov    0x8(%rax),%eax
 918:	01 c2                	add    %eax,%edx
 91a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 91e:	89 50 08             	mov    %edx,0x8(%rax)
    bp->s.ptr = p->s.ptr->s.ptr;
 921:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 925:	48 8b 00             	mov    (%rax),%rax
 928:	48 8b 10             	mov    (%rax),%rdx
 92b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 92f:	48 89 10             	mov    %rdx,(%rax)
 932:	eb 0e                	jmp    942 <free+0xc9>
  } else
    bp->s.ptr = p->s.ptr;
 934:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 938:	48 8b 10             	mov    (%rax),%rdx
 93b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 93f:	48 89 10             	mov    %rdx,(%rax)
  if(p + p->s.size == bp){
 942:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 946:	8b 40 08             	mov    0x8(%rax),%eax
 949:	89 c0                	mov    %eax,%eax
 94b:	48 c1 e0 04          	shl    $0x4,%rax
 94f:	48 89 c2             	mov    %rax,%rdx
 952:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 956:	48 01 d0             	add    %rdx,%rax
 959:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
 95d:	75 27                	jne    986 <free+0x10d>
    p->s.size += bp->s.size;
 95f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 963:	8b 50 08             	mov    0x8(%rax),%edx
 966:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 96a:	8b 40 08             	mov    0x8(%rax),%eax
 96d:	01 c2                	add    %eax,%edx
 96f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 973:	89 50 08             	mov    %edx,0x8(%rax)
    p->s.ptr = bp->s.ptr;
 976:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 97a:	48 8b 10             	mov    (%rax),%rdx
 97d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 981:	48 89 10             	mov    %rdx,(%rax)
 984:	eb 0b                	jmp    991 <free+0x118>
  } else
    p->s.ptr = bp;
 986:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 98a:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
 98e:	48 89 10             	mov    %rdx,(%rax)
  freep = p;
 991:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 995:	48 89 05 14 04 00 00 	mov    %rax,0x414(%rip)        # db0 <freep>
}
 99c:	90                   	nop
 99d:	c9                   	leave
 99e:	c3                   	ret

000000000000099f <morecore>:

static Header*
morecore(uint nu)
{
 99f:	55                   	push   %rbp
 9a0:	48 89 e5             	mov    %rsp,%rbp
 9a3:	48 83 ec 20          	sub    $0x20,%rsp
 9a7:	89 7d ec             	mov    %edi,-0x14(%rbp)
  char *p;
  Header *hp;

  if(nu < 4096)
 9aa:	81 7d ec ff 0f 00 00 	cmpl   $0xfff,-0x14(%rbp)
 9b1:	77 07                	ja     9ba <morecore+0x1b>
    nu = 4096;
 9b3:	c7 45 ec 00 10 00 00 	movl   $0x1000,-0x14(%rbp)
  p = sbrk(nu * sizeof(Header));
 9ba:	8b 45 ec             	mov    -0x14(%rbp),%eax
 9bd:	c1 e0 04             	shl    $0x4,%eax
 9c0:	89 c7                	mov    %eax,%edi
 9c2:	e8 40 fa ff ff       	call   407 <sbrk>
 9c7:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  if(p == (char*)-1)
 9cb:	48 83 7d f8 ff       	cmpq   $0xffffffffffffffff,-0x8(%rbp)
 9d0:	75 07                	jne    9d9 <morecore+0x3a>
    return 0;
 9d2:	b8 00 00 00 00       	mov    $0x0,%eax
 9d7:	eb 29                	jmp    a02 <morecore+0x63>
  hp = (Header*)p;
 9d9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 9dd:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  hp->s.size = nu;
 9e1:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 9e5:	8b 55 ec             	mov    -0x14(%rbp),%edx
 9e8:	89 50 08             	mov    %edx,0x8(%rax)
  free((void*)(hp + 1));
 9eb:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 9ef:	48 83 c0 10          	add    $0x10,%rax
 9f3:	48 89 c7             	mov    %rax,%rdi
 9f6:	e8 7e fe ff ff       	call   879 <free>
  return freep;
 9fb:	48 8b 05 ae 03 00 00 	mov    0x3ae(%rip),%rax        # db0 <freep>
}
 a02:	c9                   	leave
 a03:	c3                   	ret

0000000000000a04 <malloc>:

void*
malloc(uint nbytes)
{
 a04:	55                   	push   %rbp
 a05:	48 89 e5             	mov    %rsp,%rbp
 a08:	48 83 ec 30          	sub    $0x30,%rsp
 a0c:	89 7d dc             	mov    %edi,-0x24(%rbp)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 a0f:	8b 45 dc             	mov    -0x24(%rbp),%eax
 a12:	48 83 c0 0f          	add    $0xf,%rax
 a16:	48 c1 e8 04          	shr    $0x4,%rax
 a1a:	83 c0 01             	add    $0x1,%eax
 a1d:	89 45 ec             	mov    %eax,-0x14(%rbp)
  if((prevp = freep) == 0){
 a20:	48 8b 05 89 03 00 00 	mov    0x389(%rip),%rax        # db0 <freep>
 a27:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
 a2b:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
 a30:	75 2b                	jne    a5d <malloc+0x59>
    base.s.ptr = freep = prevp = &base;
 a32:	48 c7 45 f0 a0 0d 00 	movq   $0xda0,-0x10(%rbp)
 a39:	00 
 a3a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 a3e:	48 89 05 6b 03 00 00 	mov    %rax,0x36b(%rip)        # db0 <freep>
 a45:	48 8b 05 64 03 00 00 	mov    0x364(%rip),%rax        # db0 <freep>
 a4c:	48 89 05 4d 03 00 00 	mov    %rax,0x34d(%rip)        # da0 <base>
    base.s.size = 0;
 a53:	c7 05 4b 03 00 00 00 	movl   $0x0,0x34b(%rip)        # da8 <base+0x8>
 a5a:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a5d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 a61:	48 8b 00             	mov    (%rax),%rax
 a64:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
 a68:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a6c:	8b 40 08             	mov    0x8(%rax),%eax
 a6f:	3b 45 ec             	cmp    -0x14(%rbp),%eax
 a72:	72 5f                	jb     ad3 <malloc+0xcf>
      if(p->s.size == nunits)
 a74:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a78:	8b 40 08             	mov    0x8(%rax),%eax
 a7b:	39 45 ec             	cmp    %eax,-0x14(%rbp)
 a7e:	75 10                	jne    a90 <malloc+0x8c>
        prevp->s.ptr = p->s.ptr;
 a80:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a84:	48 8b 10             	mov    (%rax),%rdx
 a87:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 a8b:	48 89 10             	mov    %rdx,(%rax)
 a8e:	eb 2e                	jmp    abe <malloc+0xba>
      else {
        p->s.size -= nunits;
 a90:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a94:	8b 40 08             	mov    0x8(%rax),%eax
 a97:	2b 45 ec             	sub    -0x14(%rbp),%eax
 a9a:	89 c2                	mov    %eax,%edx
 a9c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 aa0:	89 50 08             	mov    %edx,0x8(%rax)
        p += p->s.size;
 aa3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 aa7:	8b 40 08             	mov    0x8(%rax),%eax
 aaa:	89 c0                	mov    %eax,%eax
 aac:	48 c1 e0 04          	shl    $0x4,%rax
 ab0:	48 01 45 f8          	add    %rax,-0x8(%rbp)
        p->s.size = nunits;
 ab4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 ab8:	8b 55 ec             	mov    -0x14(%rbp),%edx
 abb:	89 50 08             	mov    %edx,0x8(%rax)
      }
      freep = prevp;
 abe:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 ac2:	48 89 05 e7 02 00 00 	mov    %rax,0x2e7(%rip)        # db0 <freep>
      return (void*)(p + 1);
 ac9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 acd:	48 83 c0 10          	add    $0x10,%rax
 ad1:	eb 41                	jmp    b14 <malloc+0x110>
    }
    if(p == freep)
 ad3:	48 8b 05 d6 02 00 00 	mov    0x2d6(%rip),%rax        # db0 <freep>
 ada:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 ade:	75 1c                	jne    afc <malloc+0xf8>
      if((p = morecore(nunits)) == 0)
 ae0:	8b 45 ec             	mov    -0x14(%rbp),%eax
 ae3:	89 c7                	mov    %eax,%edi
 ae5:	e8 b5 fe ff ff       	call   99f <morecore>
 aea:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 aee:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
 af3:	75 07                	jne    afc <malloc+0xf8>
        return 0;
 af5:	b8 00 00 00 00       	mov    $0x0,%eax
 afa:	eb 18                	jmp    b14 <malloc+0x110>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 afc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b00:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
 b04:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b08:	48 8b 00             	mov    (%rax),%rax
 b0b:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
 b0f:	e9 54 ff ff ff       	jmp    a68 <malloc+0x64>
  }
}
 b14:	c9                   	leave
 b15:	c3                   	ret
