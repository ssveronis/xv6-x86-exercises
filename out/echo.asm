
fs/echo:     file format elf64-x86-64


Disassembly of section .text:

0000000000000000 <main>:
#include "stat.h"
#include "user.h"

int
main(int argc, char *argv[])
{
   0:	55                   	push   %rbp
   1:	48 89 e5             	mov    %rsp,%rbp
   4:	48 83 ec 20          	sub    $0x20,%rsp
   8:	89 7d ec             	mov    %edi,-0x14(%rbp)
   b:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  int i;

  for(i = 1; i < argc; i++)
   f:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%rbp)
  16:	eb 4f                	jmp    67 <main+0x67>
    printf(1, "%s%s", argv[i], i+1 < argc ? " " : "\n");
  18:	8b 45 fc             	mov    -0x4(%rbp),%eax
  1b:	83 c0 01             	add    $0x1,%eax
  1e:	39 45 ec             	cmp    %eax,-0x14(%rbp)
  21:	7e 09                	jle    2c <main+0x2c>
  23:	48 c7 c1 0b 0d 00 00 	mov    $0xd0b,%rcx
  2a:	eb 07                	jmp    33 <main+0x33>
  2c:	48 c7 c1 0d 0d 00 00 	mov    $0xd0d,%rcx
  33:	8b 45 fc             	mov    -0x4(%rbp),%eax
  36:	48 98                	cltq
  38:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
  3f:	00 
  40:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  44:	48 01 d0             	add    %rdx,%rax
  47:	48 8b 00             	mov    (%rax),%rax
  4a:	48 89 c2             	mov    %rax,%rdx
  4d:	48 c7 c6 0f 0d 00 00 	mov    $0xd0f,%rsi
  54:	bf 01 00 00 00       	mov    $0x1,%edi
  59:	b8 00 00 00 00       	mov    $0x0,%eax
  5e:	e8 b6 04 00 00       	call   519 <printf>
  for(i = 1; i < argc; i++)
  63:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  67:	8b 45 fc             	mov    -0x4(%rbp),%eax
  6a:	3b 45 ec             	cmp    -0x14(%rbp),%eax
  6d:	7c a9                	jl     18 <main+0x18>
  exit();
  6f:	e8 f3 02 00 00       	call   367 <exit>

0000000000000074 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
  74:	55                   	push   %rbp
  75:	48 89 e5             	mov    %rsp,%rbp
  78:	48 83 ec 10          	sub    $0x10,%rsp
  7c:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  80:	89 75 f4             	mov    %esi,-0xc(%rbp)
  83:	89 55 f0             	mov    %edx,-0x10(%rbp)
  asm volatile("cld; rep stosb" :
  86:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
  8a:	8b 55 f0             	mov    -0x10(%rbp),%edx
  8d:	8b 45 f4             	mov    -0xc(%rbp),%eax
  90:	48 89 ce             	mov    %rcx,%rsi
  93:	48 89 f7             	mov    %rsi,%rdi
  96:	89 d1                	mov    %edx,%ecx
  98:	fc                   	cld
  99:	f3 aa                	rep stos %al,%es:(%rdi)
  9b:	89 ca                	mov    %ecx,%edx
  9d:	48 89 fe             	mov    %rdi,%rsi
  a0:	48 89 75 f8          	mov    %rsi,-0x8(%rbp)
  a4:	89 55 f0             	mov    %edx,-0x10(%rbp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
  a7:	90                   	nop
  a8:	c9                   	leave
  a9:	c3                   	ret

00000000000000aa <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
  aa:	55                   	push   %rbp
  ab:	48 89 e5             	mov    %rsp,%rbp
  ae:	48 83 ec 20          	sub    $0x20,%rsp
  b2:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  b6:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  char *os;

  os = s;
  ba:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  be:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  while((*s++ = *t++) != 0)
  c2:	90                   	nop
  c3:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  c7:	48 8d 42 01          	lea    0x1(%rdx),%rax
  cb:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  cf:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  d3:	48 8d 48 01          	lea    0x1(%rax),%rcx
  d7:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  db:	0f b6 12             	movzbl (%rdx),%edx
  de:	88 10                	mov    %dl,(%rax)
  e0:	0f b6 00             	movzbl (%rax),%eax
  e3:	84 c0                	test   %al,%al
  e5:	75 dc                	jne    c3 <strcpy+0x19>
    ;
  return os;
  e7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
  eb:	c9                   	leave
  ec:	c3                   	ret

00000000000000ed <strcmp>:

int
strcmp(const char *p, const char *q)
{
  ed:	55                   	push   %rbp
  ee:	48 89 e5             	mov    %rsp,%rbp
  f1:	48 83 ec 10          	sub    $0x10,%rsp
  f5:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  f9:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  while(*p && *p == *q)
  fd:	eb 0a                	jmp    109 <strcmp+0x1c>
    p++, q++;
  ff:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
 104:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  while(*p && *p == *q)
 109:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 10d:	0f b6 00             	movzbl (%rax),%eax
 110:	84 c0                	test   %al,%al
 112:	74 12                	je     126 <strcmp+0x39>
 114:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 118:	0f b6 10             	movzbl (%rax),%edx
 11b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 11f:	0f b6 00             	movzbl (%rax),%eax
 122:	38 c2                	cmp    %al,%dl
 124:	74 d9                	je     ff <strcmp+0x12>
  return (uchar)*p - (uchar)*q;
 126:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 12a:	0f b6 00             	movzbl (%rax),%eax
 12d:	0f b6 d0             	movzbl %al,%edx
 130:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 134:	0f b6 00             	movzbl (%rax),%eax
 137:	0f b6 c0             	movzbl %al,%eax
 13a:	29 c2                	sub    %eax,%edx
 13c:	89 d0                	mov    %edx,%eax
}
 13e:	c9                   	leave
 13f:	c3                   	ret

0000000000000140 <strlen>:

uint
strlen(char *s)
{
 140:	55                   	push   %rbp
 141:	48 89 e5             	mov    %rsp,%rbp
 144:	48 83 ec 18          	sub    $0x18,%rsp
 148:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  int n;

  for(n = 0; s[n]; n++)
 14c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
 153:	eb 04                	jmp    159 <strlen+0x19>
 155:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
 159:	8b 45 fc             	mov    -0x4(%rbp),%eax
 15c:	48 63 d0             	movslq %eax,%rdx
 15f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 163:	48 01 d0             	add    %rdx,%rax
 166:	0f b6 00             	movzbl (%rax),%eax
 169:	84 c0                	test   %al,%al
 16b:	75 e8                	jne    155 <strlen+0x15>
    ;
  return n;
 16d:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
 170:	c9                   	leave
 171:	c3                   	ret

0000000000000172 <memset>:

void*
memset(void *dst, int c, uint n)
{
 172:	55                   	push   %rbp
 173:	48 89 e5             	mov    %rsp,%rbp
 176:	48 83 ec 10          	sub    $0x10,%rsp
 17a:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
 17e:	89 75 f4             	mov    %esi,-0xc(%rbp)
 181:	89 55 f0             	mov    %edx,-0x10(%rbp)
  stosb(dst, c, n);
 184:	8b 55 f0             	mov    -0x10(%rbp),%edx
 187:	8b 4d f4             	mov    -0xc(%rbp),%ecx
 18a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 18e:	89 ce                	mov    %ecx,%esi
 190:	48 89 c7             	mov    %rax,%rdi
 193:	e8 dc fe ff ff       	call   74 <stosb>
  return dst;
 198:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
 19c:	c9                   	leave
 19d:	c3                   	ret

000000000000019e <strchr>:

char*
strchr(const char *s, char c)
{
 19e:	55                   	push   %rbp
 19f:	48 89 e5             	mov    %rsp,%rbp
 1a2:	48 83 ec 10          	sub    $0x10,%rsp
 1a6:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
 1aa:	89 f0                	mov    %esi,%eax
 1ac:	88 45 f4             	mov    %al,-0xc(%rbp)
  for(; *s; s++)
 1af:	eb 17                	jmp    1c8 <strchr+0x2a>
    if(*s == c)
 1b1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 1b5:	0f b6 00             	movzbl (%rax),%eax
 1b8:	38 45 f4             	cmp    %al,-0xc(%rbp)
 1bb:	75 06                	jne    1c3 <strchr+0x25>
      return (char*)s;
 1bd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 1c1:	eb 15                	jmp    1d8 <strchr+0x3a>
  for(; *s; s++)
 1c3:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
 1c8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 1cc:	0f b6 00             	movzbl (%rax),%eax
 1cf:	84 c0                	test   %al,%al
 1d1:	75 de                	jne    1b1 <strchr+0x13>
  return 0;
 1d3:	b8 00 00 00 00       	mov    $0x0,%eax
}
 1d8:	c9                   	leave
 1d9:	c3                   	ret

00000000000001da <gets>:

char*
gets(char *buf, int max)
{
 1da:	55                   	push   %rbp
 1db:	48 89 e5             	mov    %rsp,%rbp
 1de:	48 83 ec 20          	sub    $0x20,%rsp
 1e2:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
 1e6:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1e9:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
 1f0:	eb 48                	jmp    23a <gets+0x60>
    cc = read(0, &c, 1);
 1f2:	48 8d 45 f7          	lea    -0x9(%rbp),%rax
 1f6:	ba 01 00 00 00       	mov    $0x1,%edx
 1fb:	48 89 c6             	mov    %rax,%rsi
 1fe:	bf 00 00 00 00       	mov    $0x0,%edi
 203:	e8 77 01 00 00       	call   37f <read>
 208:	89 45 f8             	mov    %eax,-0x8(%rbp)
    if(cc < 1)
 20b:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
 20f:	7e 36                	jle    247 <gets+0x6d>
      break;
    buf[i++] = c;
 211:	8b 45 fc             	mov    -0x4(%rbp),%eax
 214:	8d 50 01             	lea    0x1(%rax),%edx
 217:	89 55 fc             	mov    %edx,-0x4(%rbp)
 21a:	48 63 d0             	movslq %eax,%rdx
 21d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 221:	48 01 c2             	add    %rax,%rdx
 224:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
 228:	88 02                	mov    %al,(%rdx)
    if(c == '\n' || c == '\r')
 22a:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
 22e:	3c 0a                	cmp    $0xa,%al
 230:	74 16                	je     248 <gets+0x6e>
 232:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
 236:	3c 0d                	cmp    $0xd,%al
 238:	74 0e                	je     248 <gets+0x6e>
  for(i=0; i+1 < max; ){
 23a:	8b 45 fc             	mov    -0x4(%rbp),%eax
 23d:	83 c0 01             	add    $0x1,%eax
 240:	39 45 e4             	cmp    %eax,-0x1c(%rbp)
 243:	7f ad                	jg     1f2 <gets+0x18>
 245:	eb 01                	jmp    248 <gets+0x6e>
      break;
 247:	90                   	nop
      break;
  }
  buf[i] = '\0';
 248:	8b 45 fc             	mov    -0x4(%rbp),%eax
 24b:	48 63 d0             	movslq %eax,%rdx
 24e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 252:	48 01 d0             	add    %rdx,%rax
 255:	c6 00 00             	movb   $0x0,(%rax)
  return buf;
 258:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
 25c:	c9                   	leave
 25d:	c3                   	ret

000000000000025e <stat>:

int
stat(char *n, struct stat *st)
{
 25e:	55                   	push   %rbp
 25f:	48 89 e5             	mov    %rsp,%rbp
 262:	48 83 ec 20          	sub    $0x20,%rsp
 266:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
 26a:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 26e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 272:	be 00 00 00 00       	mov    $0x0,%esi
 277:	48 89 c7             	mov    %rax,%rdi
 27a:	e8 28 01 00 00       	call   3a7 <open>
 27f:	89 45 fc             	mov    %eax,-0x4(%rbp)
  if(fd < 0)
 282:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
 286:	79 07                	jns    28f <stat+0x31>
    return -1;
 288:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 28d:	eb 21                	jmp    2b0 <stat+0x52>
  r = fstat(fd, st);
 28f:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
 293:	8b 45 fc             	mov    -0x4(%rbp),%eax
 296:	48 89 d6             	mov    %rdx,%rsi
 299:	89 c7                	mov    %eax,%edi
 29b:	e8 1f 01 00 00       	call   3bf <fstat>
 2a0:	89 45 f8             	mov    %eax,-0x8(%rbp)
  close(fd);
 2a3:	8b 45 fc             	mov    -0x4(%rbp),%eax
 2a6:	89 c7                	mov    %eax,%edi
 2a8:	e8 e2 00 00 00       	call   38f <close>
  return r;
 2ad:	8b 45 f8             	mov    -0x8(%rbp),%eax
}
 2b0:	c9                   	leave
 2b1:	c3                   	ret

00000000000002b2 <atoi>:

int
atoi(const char *s)
{
 2b2:	55                   	push   %rbp
 2b3:	48 89 e5             	mov    %rsp,%rbp
 2b6:	48 83 ec 18          	sub    $0x18,%rsp
 2ba:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  int n;

  n = 0;
 2be:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  while('0' <= *s && *s <= '9')
 2c5:	eb 28                	jmp    2ef <atoi+0x3d>
    n = n*10 + *s++ - '0';
 2c7:	8b 55 fc             	mov    -0x4(%rbp),%edx
 2ca:	89 d0                	mov    %edx,%eax
 2cc:	c1 e0 02             	shl    $0x2,%eax
 2cf:	01 d0                	add    %edx,%eax
 2d1:	01 c0                	add    %eax,%eax
 2d3:	89 c1                	mov    %eax,%ecx
 2d5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 2d9:	48 8d 50 01          	lea    0x1(%rax),%rdx
 2dd:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
 2e1:	0f b6 00             	movzbl (%rax),%eax
 2e4:	0f be c0             	movsbl %al,%eax
 2e7:	01 c8                	add    %ecx,%eax
 2e9:	83 e8 30             	sub    $0x30,%eax
 2ec:	89 45 fc             	mov    %eax,-0x4(%rbp)
  while('0' <= *s && *s <= '9')
 2ef:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 2f3:	0f b6 00             	movzbl (%rax),%eax
 2f6:	3c 2f                	cmp    $0x2f,%al
 2f8:	7e 0b                	jle    305 <atoi+0x53>
 2fa:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 2fe:	0f b6 00             	movzbl (%rax),%eax
 301:	3c 39                	cmp    $0x39,%al
 303:	7e c2                	jle    2c7 <atoi+0x15>
  return n;
 305:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
 308:	c9                   	leave
 309:	c3                   	ret

000000000000030a <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 30a:	55                   	push   %rbp
 30b:	48 89 e5             	mov    %rsp,%rbp
 30e:	48 83 ec 28          	sub    $0x28,%rsp
 312:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
 316:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
 31a:	89 55 dc             	mov    %edx,-0x24(%rbp)
  char *dst, *src;
  
  dst = vdst;
 31d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 321:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  src = vsrc;
 325:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
 329:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  while(n-- > 0)
 32d:	eb 1d                	jmp    34c <memmove+0x42>
    *dst++ = *src++;
 32f:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
 333:	48 8d 42 01          	lea    0x1(%rdx),%rax
 337:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
 33b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 33f:	48 8d 48 01          	lea    0x1(%rax),%rcx
 343:	48 89 4d f8          	mov    %rcx,-0x8(%rbp)
 347:	0f b6 12             	movzbl (%rdx),%edx
 34a:	88 10                	mov    %dl,(%rax)
  while(n-- > 0)
 34c:	8b 45 dc             	mov    -0x24(%rbp),%eax
 34f:	8d 50 ff             	lea    -0x1(%rax),%edx
 352:	89 55 dc             	mov    %edx,-0x24(%rbp)
 355:	85 c0                	test   %eax,%eax
 357:	7f d6                	jg     32f <memmove+0x25>
  return vdst;
 359:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
 35d:	c9                   	leave
 35e:	c3                   	ret

000000000000035f <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 35f:	b8 01 00 00 00       	mov    $0x1,%eax
 364:	cd 40                	int    $0x40
 366:	c3                   	ret

0000000000000367 <exit>:
SYSCALL(exit)
 367:	b8 02 00 00 00       	mov    $0x2,%eax
 36c:	cd 40                	int    $0x40
 36e:	c3                   	ret

000000000000036f <wait>:
SYSCALL(wait)
 36f:	b8 03 00 00 00       	mov    $0x3,%eax
 374:	cd 40                	int    $0x40
 376:	c3                   	ret

0000000000000377 <pipe>:
SYSCALL(pipe)
 377:	b8 04 00 00 00       	mov    $0x4,%eax
 37c:	cd 40                	int    $0x40
 37e:	c3                   	ret

000000000000037f <read>:
SYSCALL(read)
 37f:	b8 05 00 00 00       	mov    $0x5,%eax
 384:	cd 40                	int    $0x40
 386:	c3                   	ret

0000000000000387 <write>:
SYSCALL(write)
 387:	b8 10 00 00 00       	mov    $0x10,%eax
 38c:	cd 40                	int    $0x40
 38e:	c3                   	ret

000000000000038f <close>:
SYSCALL(close)
 38f:	b8 15 00 00 00       	mov    $0x15,%eax
 394:	cd 40                	int    $0x40
 396:	c3                   	ret

0000000000000397 <kill>:
SYSCALL(kill)
 397:	b8 06 00 00 00       	mov    $0x6,%eax
 39c:	cd 40                	int    $0x40
 39e:	c3                   	ret

000000000000039f <exec>:
SYSCALL(exec)
 39f:	b8 07 00 00 00       	mov    $0x7,%eax
 3a4:	cd 40                	int    $0x40
 3a6:	c3                   	ret

00000000000003a7 <open>:
SYSCALL(open)
 3a7:	b8 0f 00 00 00       	mov    $0xf,%eax
 3ac:	cd 40                	int    $0x40
 3ae:	c3                   	ret

00000000000003af <mknod>:
SYSCALL(mknod)
 3af:	b8 11 00 00 00       	mov    $0x11,%eax
 3b4:	cd 40                	int    $0x40
 3b6:	c3                   	ret

00000000000003b7 <unlink>:
SYSCALL(unlink)
 3b7:	b8 12 00 00 00       	mov    $0x12,%eax
 3bc:	cd 40                	int    $0x40
 3be:	c3                   	ret

00000000000003bf <fstat>:
SYSCALL(fstat)
 3bf:	b8 08 00 00 00       	mov    $0x8,%eax
 3c4:	cd 40                	int    $0x40
 3c6:	c3                   	ret

00000000000003c7 <link>:
SYSCALL(link)
 3c7:	b8 13 00 00 00       	mov    $0x13,%eax
 3cc:	cd 40                	int    $0x40
 3ce:	c3                   	ret

00000000000003cf <mkdir>:
SYSCALL(mkdir)
 3cf:	b8 14 00 00 00       	mov    $0x14,%eax
 3d4:	cd 40                	int    $0x40
 3d6:	c3                   	ret

00000000000003d7 <chdir>:
SYSCALL(chdir)
 3d7:	b8 09 00 00 00       	mov    $0x9,%eax
 3dc:	cd 40                	int    $0x40
 3de:	c3                   	ret

00000000000003df <dup>:
SYSCALL(dup)
 3df:	b8 0a 00 00 00       	mov    $0xa,%eax
 3e4:	cd 40                	int    $0x40
 3e6:	c3                   	ret

00000000000003e7 <getpid>:
SYSCALL(getpid)
 3e7:	b8 0b 00 00 00       	mov    $0xb,%eax
 3ec:	cd 40                	int    $0x40
 3ee:	c3                   	ret

00000000000003ef <sbrk>:
SYSCALL(sbrk)
 3ef:	b8 0c 00 00 00       	mov    $0xc,%eax
 3f4:	cd 40                	int    $0x40
 3f6:	c3                   	ret

00000000000003f7 <sleep>:
SYSCALL(sleep)
 3f7:	b8 0d 00 00 00       	mov    $0xd,%eax
 3fc:	cd 40                	int    $0x40
 3fe:	c3                   	ret

00000000000003ff <uptime>:
SYSCALL(uptime)
 3ff:	b8 0e 00 00 00       	mov    $0xe,%eax
 404:	cd 40                	int    $0x40
 406:	c3                   	ret

0000000000000407 <getpinfo>:
SYSCALL(getpinfo)
 407:	b8 18 00 00 00       	mov    $0x18,%eax
 40c:	cd 40                	int    $0x40
 40e:	c3                   	ret

000000000000040f <getfavnum>:
SYSCALL(getfavnum)
 40f:	b8 19 00 00 00       	mov    $0x19,%eax
 414:	cd 40                	int    $0x40
 416:	c3                   	ret

0000000000000417 <shutdown>:
SYSCALL(shutdown)
 417:	b8 1a 00 00 00       	mov    $0x1a,%eax
 41c:	cd 40                	int    $0x40
 41e:	c3                   	ret

000000000000041f <getcount>:
SYSCALL(getcount)
 41f:	b8 1b 00 00 00       	mov    $0x1b,%eax
 424:	cd 40                	int    $0x40
 426:	c3                   	ret

0000000000000427 <killrandom>:
 427:	b8 1c 00 00 00       	mov    $0x1c,%eax
 42c:	cd 40                	int    $0x40
 42e:	c3                   	ret

000000000000042f <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 42f:	55                   	push   %rbp
 430:	48 89 e5             	mov    %rsp,%rbp
 433:	48 83 ec 10          	sub    $0x10,%rsp
 437:	89 7d fc             	mov    %edi,-0x4(%rbp)
 43a:	89 f0                	mov    %esi,%eax
 43c:	88 45 f8             	mov    %al,-0x8(%rbp)
  write(fd, &c, 1);
 43f:	48 8d 4d f8          	lea    -0x8(%rbp),%rcx
 443:	8b 45 fc             	mov    -0x4(%rbp),%eax
 446:	ba 01 00 00 00       	mov    $0x1,%edx
 44b:	48 89 ce             	mov    %rcx,%rsi
 44e:	89 c7                	mov    %eax,%edi
 450:	e8 32 ff ff ff       	call   387 <write>
}
 455:	90                   	nop
 456:	c9                   	leave
 457:	c3                   	ret

0000000000000458 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 458:	55                   	push   %rbp
 459:	48 89 e5             	mov    %rsp,%rbp
 45c:	48 83 ec 30          	sub    $0x30,%rsp
 460:	89 7d dc             	mov    %edi,-0x24(%rbp)
 463:	89 75 d8             	mov    %esi,-0x28(%rbp)
 466:	89 55 d4             	mov    %edx,-0x2c(%rbp)
 469:	89 4d d0             	mov    %ecx,-0x30(%rbp)
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 46c:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
  if(sgn && xx < 0){
 473:	83 7d d0 00          	cmpl   $0x0,-0x30(%rbp)
 477:	74 17                	je     490 <printint+0x38>
 479:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
 47d:	79 11                	jns    490 <printint+0x38>
    neg = 1;
 47f:	c7 45 f8 01 00 00 00 	movl   $0x1,-0x8(%rbp)
    x = -xx;
 486:	8b 45 d8             	mov    -0x28(%rbp),%eax
 489:	f7 d8                	neg    %eax
 48b:	89 45 f4             	mov    %eax,-0xc(%rbp)
 48e:	eb 06                	jmp    496 <printint+0x3e>
  } else {
    x = xx;
 490:	8b 45 d8             	mov    -0x28(%rbp),%eax
 493:	89 45 f4             	mov    %eax,-0xc(%rbp)
  }

  i = 0;
 496:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  do{
    buf[i++] = digits[x % base];
 49d:	8b 4d d4             	mov    -0x2c(%rbp),%ecx
 4a0:	8b 45 f4             	mov    -0xc(%rbp),%eax
 4a3:	ba 00 00 00 00       	mov    $0x0,%edx
 4a8:	f7 f1                	div    %ecx
 4aa:	89 d1                	mov    %edx,%ecx
 4ac:	8b 45 fc             	mov    -0x4(%rbp),%eax
 4af:	8d 50 01             	lea    0x1(%rax),%edx
 4b2:	89 55 fc             	mov    %edx,-0x4(%rbp)
 4b5:	89 ca                	mov    %ecx,%edx
 4b7:	0f b6 92 00 10 00 00 	movzbl 0x1000(%rdx),%edx
 4be:	48 98                	cltq
 4c0:	88 54 05 e0          	mov    %dl,-0x20(%rbp,%rax,1)
  }while((x /= base) != 0);
 4c4:	8b 75 d4             	mov    -0x2c(%rbp),%esi
 4c7:	8b 45 f4             	mov    -0xc(%rbp),%eax
 4ca:	ba 00 00 00 00       	mov    $0x0,%edx
 4cf:	f7 f6                	div    %esi
 4d1:	89 45 f4             	mov    %eax,-0xc(%rbp)
 4d4:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
 4d8:	75 c3                	jne    49d <printint+0x45>
  if(neg)
 4da:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
 4de:	74 2b                	je     50b <printint+0xb3>
    buf[i++] = '-';
 4e0:	8b 45 fc             	mov    -0x4(%rbp),%eax
 4e3:	8d 50 01             	lea    0x1(%rax),%edx
 4e6:	89 55 fc             	mov    %edx,-0x4(%rbp)
 4e9:	48 98                	cltq
 4eb:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%rbp,%rax,1)

  while(--i >= 0)
 4f0:	eb 19                	jmp    50b <printint+0xb3>
    putc(fd, buf[i]);
 4f2:	8b 45 fc             	mov    -0x4(%rbp),%eax
 4f5:	48 98                	cltq
 4f7:	0f b6 44 05 e0       	movzbl -0x20(%rbp,%rax,1),%eax
 4fc:	0f be d0             	movsbl %al,%edx
 4ff:	8b 45 dc             	mov    -0x24(%rbp),%eax
 502:	89 d6                	mov    %edx,%esi
 504:	89 c7                	mov    %eax,%edi
 506:	e8 24 ff ff ff       	call   42f <putc>
  while(--i >= 0)
 50b:	83 6d fc 01          	subl   $0x1,-0x4(%rbp)
 50f:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
 513:	79 dd                	jns    4f2 <printint+0x9a>
}
 515:	90                   	nop
 516:	90                   	nop
 517:	c9                   	leave
 518:	c3                   	ret

0000000000000519 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 519:	55                   	push   %rbp
 51a:	48 89 e5             	mov    %rsp,%rbp
 51d:	48 81 ec f0 00 00 00 	sub    $0xf0,%rsp
 524:	89 bd 1c ff ff ff    	mov    %edi,-0xe4(%rbp)
 52a:	48 89 b5 10 ff ff ff 	mov    %rsi,-0xf0(%rbp)
 531:	48 89 95 60 ff ff ff 	mov    %rdx,-0xa0(%rbp)
 538:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
 53f:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
 546:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
 54d:	84 c0                	test   %al,%al
 54f:	74 20                	je     571 <printf+0x58>
 551:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
 555:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
 559:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
 55d:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
 561:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
 565:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
 569:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
 56d:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  va_list ap;
  char *s;
  int c, i, state;
  va_start(ap, fmt);
 571:	c7 85 20 ff ff ff 10 	movl   $0x10,-0xe0(%rbp)
 578:	00 00 00 
 57b:	c7 85 24 ff ff ff 30 	movl   $0x30,-0xdc(%rbp)
 582:	00 00 00 
 585:	48 8d 45 10          	lea    0x10(%rbp),%rax
 589:	48 89 85 28 ff ff ff 	mov    %rax,-0xd8(%rbp)
 590:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
 597:	48 89 85 30 ff ff ff 	mov    %rax,-0xd0(%rbp)

  state = 0;
 59e:	c7 85 40 ff ff ff 00 	movl   $0x0,-0xc0(%rbp)
 5a5:	00 00 00 
  for(i = 0; fmt[i]; i++){
 5a8:	c7 85 44 ff ff ff 00 	movl   $0x0,-0xbc(%rbp)
 5af:	00 00 00 
 5b2:	e9 a8 02 00 00       	jmp    85f <printf+0x346>
    c = fmt[i] & 0xff;
 5b7:	8b 85 44 ff ff ff    	mov    -0xbc(%rbp),%eax
 5bd:	48 63 d0             	movslq %eax,%rdx
 5c0:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
 5c7:	48 01 d0             	add    %rdx,%rax
 5ca:	0f b6 00             	movzbl (%rax),%eax
 5cd:	0f be c0             	movsbl %al,%eax
 5d0:	25 ff 00 00 00       	and    $0xff,%eax
 5d5:	89 85 3c ff ff ff    	mov    %eax,-0xc4(%rbp)
    if(state == 0){
 5db:	83 bd 40 ff ff ff 00 	cmpl   $0x0,-0xc0(%rbp)
 5e2:	75 35                	jne    619 <printf+0x100>
      if(c == '%'){
 5e4:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
 5eb:	75 0f                	jne    5fc <printf+0xe3>
        state = '%';
 5ed:	c7 85 40 ff ff ff 25 	movl   $0x25,-0xc0(%rbp)
 5f4:	00 00 00 
 5f7:	e9 5c 02 00 00       	jmp    858 <printf+0x33f>
      } else {
        putc(fd, c);
 5fc:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
 602:	0f be d0             	movsbl %al,%edx
 605:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 60b:	89 d6                	mov    %edx,%esi
 60d:	89 c7                	mov    %eax,%edi
 60f:	e8 1b fe ff ff       	call   42f <putc>
 614:	e9 3f 02 00 00       	jmp    858 <printf+0x33f>
      }
    } else if(state == '%'){
 619:	83 bd 40 ff ff ff 25 	cmpl   $0x25,-0xc0(%rbp)
 620:	0f 85 32 02 00 00    	jne    858 <printf+0x33f>
      if(c == 'd'){
 626:	83 bd 3c ff ff ff 64 	cmpl   $0x64,-0xc4(%rbp)
 62d:	75 5e                	jne    68d <printf+0x174>
        printint(fd, va_arg(ap, int), 10, 1);
 62f:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 635:	83 f8 2f             	cmp    $0x2f,%eax
 638:	77 23                	ja     65d <printf+0x144>
 63a:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 641:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 647:	89 d2                	mov    %edx,%edx
 649:	48 01 d0             	add    %rdx,%rax
 64c:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 652:	83 c2 08             	add    $0x8,%edx
 655:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 65b:	eb 12                	jmp    66f <printf+0x156>
 65d:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 664:	48 8d 50 08          	lea    0x8(%rax),%rdx
 668:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 66f:	8b 30                	mov    (%rax),%esi
 671:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 677:	b9 01 00 00 00       	mov    $0x1,%ecx
 67c:	ba 0a 00 00 00       	mov    $0xa,%edx
 681:	89 c7                	mov    %eax,%edi
 683:	e8 d0 fd ff ff       	call   458 <printint>
 688:	e9 c1 01 00 00       	jmp    84e <printf+0x335>
      } else if(c == 'x' || c == 'p'){
 68d:	83 bd 3c ff ff ff 78 	cmpl   $0x78,-0xc4(%rbp)
 694:	74 09                	je     69f <printf+0x186>
 696:	83 bd 3c ff ff ff 70 	cmpl   $0x70,-0xc4(%rbp)
 69d:	75 5e                	jne    6fd <printf+0x1e4>
        printint(fd, va_arg(ap, int), 16, 0);
 69f:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 6a5:	83 f8 2f             	cmp    $0x2f,%eax
 6a8:	77 23                	ja     6cd <printf+0x1b4>
 6aa:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 6b1:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 6b7:	89 d2                	mov    %edx,%edx
 6b9:	48 01 d0             	add    %rdx,%rax
 6bc:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 6c2:	83 c2 08             	add    $0x8,%edx
 6c5:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 6cb:	eb 12                	jmp    6df <printf+0x1c6>
 6cd:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 6d4:	48 8d 50 08          	lea    0x8(%rax),%rdx
 6d8:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 6df:	8b 30                	mov    (%rax),%esi
 6e1:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 6e7:	b9 00 00 00 00       	mov    $0x0,%ecx
 6ec:	ba 10 00 00 00       	mov    $0x10,%edx
 6f1:	89 c7                	mov    %eax,%edi
 6f3:	e8 60 fd ff ff       	call   458 <printint>
 6f8:	e9 51 01 00 00       	jmp    84e <printf+0x335>
      } else if(c == 's'){
 6fd:	83 bd 3c ff ff ff 73 	cmpl   $0x73,-0xc4(%rbp)
 704:	0f 85 98 00 00 00    	jne    7a2 <printf+0x289>
        s = va_arg(ap, char*);
 70a:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 710:	83 f8 2f             	cmp    $0x2f,%eax
 713:	77 23                	ja     738 <printf+0x21f>
 715:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 71c:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 722:	89 d2                	mov    %edx,%edx
 724:	48 01 d0             	add    %rdx,%rax
 727:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 72d:	83 c2 08             	add    $0x8,%edx
 730:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 736:	eb 12                	jmp    74a <printf+0x231>
 738:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 73f:	48 8d 50 08          	lea    0x8(%rax),%rdx
 743:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 74a:	48 8b 00             	mov    (%rax),%rax
 74d:	48 89 85 48 ff ff ff 	mov    %rax,-0xb8(%rbp)
        if(s == 0)
 754:	48 83 bd 48 ff ff ff 	cmpq   $0x0,-0xb8(%rbp)
 75b:	00 
 75c:	75 31                	jne    78f <printf+0x276>
          s = "(null)";
 75e:	48 c7 85 48 ff ff ff 	movq   $0xd14,-0xb8(%rbp)
 765:	14 0d 00 00 
        while(*s != 0){
 769:	eb 24                	jmp    78f <printf+0x276>
          putc(fd, *s);
 76b:	48 8b 85 48 ff ff ff 	mov    -0xb8(%rbp),%rax
 772:	0f b6 00             	movzbl (%rax),%eax
 775:	0f be d0             	movsbl %al,%edx
 778:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 77e:	89 d6                	mov    %edx,%esi
 780:	89 c7                	mov    %eax,%edi
 782:	e8 a8 fc ff ff       	call   42f <putc>
          s++;
 787:	48 83 85 48 ff ff ff 	addq   $0x1,-0xb8(%rbp)
 78e:	01 
        while(*s != 0){
 78f:	48 8b 85 48 ff ff ff 	mov    -0xb8(%rbp),%rax
 796:	0f b6 00             	movzbl (%rax),%eax
 799:	84 c0                	test   %al,%al
 79b:	75 ce                	jne    76b <printf+0x252>
 79d:	e9 ac 00 00 00       	jmp    84e <printf+0x335>
        }
      } else if(c == 'c'){
 7a2:	83 bd 3c ff ff ff 63 	cmpl   $0x63,-0xc4(%rbp)
 7a9:	75 56                	jne    801 <printf+0x2e8>
        putc(fd, va_arg(ap, uint));
 7ab:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 7b1:	83 f8 2f             	cmp    $0x2f,%eax
 7b4:	77 23                	ja     7d9 <printf+0x2c0>
 7b6:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 7bd:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 7c3:	89 d2                	mov    %edx,%edx
 7c5:	48 01 d0             	add    %rdx,%rax
 7c8:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 7ce:	83 c2 08             	add    $0x8,%edx
 7d1:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 7d7:	eb 12                	jmp    7eb <printf+0x2d2>
 7d9:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 7e0:	48 8d 50 08          	lea    0x8(%rax),%rdx
 7e4:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 7eb:	8b 00                	mov    (%rax),%eax
 7ed:	0f be d0             	movsbl %al,%edx
 7f0:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 7f6:	89 d6                	mov    %edx,%esi
 7f8:	89 c7                	mov    %eax,%edi
 7fa:	e8 30 fc ff ff       	call   42f <putc>
 7ff:	eb 4d                	jmp    84e <printf+0x335>
      } else if(c == '%'){
 801:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
 808:	75 1a                	jne    824 <printf+0x30b>
        putc(fd, c);
 80a:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
 810:	0f be d0             	movsbl %al,%edx
 813:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 819:	89 d6                	mov    %edx,%esi
 81b:	89 c7                	mov    %eax,%edi
 81d:	e8 0d fc ff ff       	call   42f <putc>
 822:	eb 2a                	jmp    84e <printf+0x335>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 824:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 82a:	be 25 00 00 00       	mov    $0x25,%esi
 82f:	89 c7                	mov    %eax,%edi
 831:	e8 f9 fb ff ff       	call   42f <putc>
        putc(fd, c);
 836:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
 83c:	0f be d0             	movsbl %al,%edx
 83f:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 845:	89 d6                	mov    %edx,%esi
 847:	89 c7                	mov    %eax,%edi
 849:	e8 e1 fb ff ff       	call   42f <putc>
      }
      state = 0;
 84e:	c7 85 40 ff ff ff 00 	movl   $0x0,-0xc0(%rbp)
 855:	00 00 00 
  for(i = 0; fmt[i]; i++){
 858:	83 85 44 ff ff ff 01 	addl   $0x1,-0xbc(%rbp)
 85f:	8b 85 44 ff ff ff    	mov    -0xbc(%rbp),%eax
 865:	48 63 d0             	movslq %eax,%rdx
 868:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
 86f:	48 01 d0             	add    %rdx,%rax
 872:	0f b6 00             	movzbl (%rax),%eax
 875:	84 c0                	test   %al,%al
 877:	0f 85 3a fd ff ff    	jne    5b7 <printf+0x9e>
    }
  }
}
 87d:	90                   	nop
 87e:	90                   	nop
 87f:	c9                   	leave
 880:	c3                   	ret

0000000000000881 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 881:	55                   	push   %rbp
 882:	48 89 e5             	mov    %rsp,%rbp
 885:	48 83 ec 18          	sub    $0x18,%rsp
 889:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  Header *bp, *p;

  bp = (Header*)ap - 1;
 88d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 891:	48 83 e8 10          	sub    $0x10,%rax
 895:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 899:	48 8b 05 90 07 00 00 	mov    0x790(%rip),%rax        # 1030 <freep>
 8a0:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 8a4:	eb 2f                	jmp    8d5 <free+0x54>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8a6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 8aa:	48 8b 00             	mov    (%rax),%rax
 8ad:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 8b1:	72 17                	jb     8ca <free+0x49>
 8b3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 8b7:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 8bb:	72 2f                	jb     8ec <free+0x6b>
 8bd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 8c1:	48 8b 00             	mov    (%rax),%rax
 8c4:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
 8c8:	72 22                	jb     8ec <free+0x6b>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8ca:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 8ce:	48 8b 00             	mov    (%rax),%rax
 8d1:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 8d5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 8d9:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 8dd:	73 c7                	jae    8a6 <free+0x25>
 8df:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 8e3:	48 8b 00             	mov    (%rax),%rax
 8e6:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
 8ea:	73 ba                	jae    8a6 <free+0x25>
      break;
  if(bp + bp->s.size == p->s.ptr){
 8ec:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 8f0:	8b 40 08             	mov    0x8(%rax),%eax
 8f3:	89 c0                	mov    %eax,%eax
 8f5:	48 c1 e0 04          	shl    $0x4,%rax
 8f9:	48 89 c2             	mov    %rax,%rdx
 8fc:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 900:	48 01 c2             	add    %rax,%rdx
 903:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 907:	48 8b 00             	mov    (%rax),%rax
 90a:	48 39 c2             	cmp    %rax,%rdx
 90d:	75 2d                	jne    93c <free+0xbb>
    bp->s.size += p->s.ptr->s.size;
 90f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 913:	8b 50 08             	mov    0x8(%rax),%edx
 916:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 91a:	48 8b 00             	mov    (%rax),%rax
 91d:	8b 40 08             	mov    0x8(%rax),%eax
 920:	01 c2                	add    %eax,%edx
 922:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 926:	89 50 08             	mov    %edx,0x8(%rax)
    bp->s.ptr = p->s.ptr->s.ptr;
 929:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 92d:	48 8b 00             	mov    (%rax),%rax
 930:	48 8b 10             	mov    (%rax),%rdx
 933:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 937:	48 89 10             	mov    %rdx,(%rax)
 93a:	eb 0e                	jmp    94a <free+0xc9>
  } else
    bp->s.ptr = p->s.ptr;
 93c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 940:	48 8b 10             	mov    (%rax),%rdx
 943:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 947:	48 89 10             	mov    %rdx,(%rax)
  if(p + p->s.size == bp){
 94a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 94e:	8b 40 08             	mov    0x8(%rax),%eax
 951:	89 c0                	mov    %eax,%eax
 953:	48 c1 e0 04          	shl    $0x4,%rax
 957:	48 89 c2             	mov    %rax,%rdx
 95a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 95e:	48 01 d0             	add    %rdx,%rax
 961:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
 965:	75 27                	jne    98e <free+0x10d>
    p->s.size += bp->s.size;
 967:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 96b:	8b 50 08             	mov    0x8(%rax),%edx
 96e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 972:	8b 40 08             	mov    0x8(%rax),%eax
 975:	01 c2                	add    %eax,%edx
 977:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 97b:	89 50 08             	mov    %edx,0x8(%rax)
    p->s.ptr = bp->s.ptr;
 97e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 982:	48 8b 10             	mov    (%rax),%rdx
 985:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 989:	48 89 10             	mov    %rdx,(%rax)
 98c:	eb 0b                	jmp    999 <free+0x118>
  } else
    p->s.ptr = bp;
 98e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 992:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
 996:	48 89 10             	mov    %rdx,(%rax)
  freep = p;
 999:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 99d:	48 89 05 8c 06 00 00 	mov    %rax,0x68c(%rip)        # 1030 <freep>
}
 9a4:	90                   	nop
 9a5:	c9                   	leave
 9a6:	c3                   	ret

00000000000009a7 <morecore>:

static Header*
morecore(uint nu)
{
 9a7:	55                   	push   %rbp
 9a8:	48 89 e5             	mov    %rsp,%rbp
 9ab:	48 83 ec 20          	sub    $0x20,%rsp
 9af:	89 7d ec             	mov    %edi,-0x14(%rbp)
  char *p;
  Header *hp;

  if(nu < 4096)
 9b2:	81 7d ec ff 0f 00 00 	cmpl   $0xfff,-0x14(%rbp)
 9b9:	77 07                	ja     9c2 <morecore+0x1b>
    nu = 4096;
 9bb:	c7 45 ec 00 10 00 00 	movl   $0x1000,-0x14(%rbp)
  p = sbrk(nu * sizeof(Header));
 9c2:	8b 45 ec             	mov    -0x14(%rbp),%eax
 9c5:	c1 e0 04             	shl    $0x4,%eax
 9c8:	89 c7                	mov    %eax,%edi
 9ca:	e8 20 fa ff ff       	call   3ef <sbrk>
 9cf:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  if(p == (char*)-1)
 9d3:	48 83 7d f8 ff       	cmpq   $0xffffffffffffffff,-0x8(%rbp)
 9d8:	75 07                	jne    9e1 <morecore+0x3a>
    return 0;
 9da:	b8 00 00 00 00       	mov    $0x0,%eax
 9df:	eb 29                	jmp    a0a <morecore+0x63>
  hp = (Header*)p;
 9e1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 9e5:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  hp->s.size = nu;
 9e9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 9ed:	8b 55 ec             	mov    -0x14(%rbp),%edx
 9f0:	89 50 08             	mov    %edx,0x8(%rax)
  free((void*)(hp + 1));
 9f3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 9f7:	48 83 c0 10          	add    $0x10,%rax
 9fb:	48 89 c7             	mov    %rax,%rdi
 9fe:	e8 7e fe ff ff       	call   881 <free>
  return freep;
 a03:	48 8b 05 26 06 00 00 	mov    0x626(%rip),%rax        # 1030 <freep>
}
 a0a:	c9                   	leave
 a0b:	c3                   	ret

0000000000000a0c <malloc>:

void*
malloc(uint nbytes)
{
 a0c:	55                   	push   %rbp
 a0d:	48 89 e5             	mov    %rsp,%rbp
 a10:	48 83 ec 30          	sub    $0x30,%rsp
 a14:	89 7d dc             	mov    %edi,-0x24(%rbp)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 a17:	8b 45 dc             	mov    -0x24(%rbp),%eax
 a1a:	48 83 c0 0f          	add    $0xf,%rax
 a1e:	48 c1 e8 04          	shr    $0x4,%rax
 a22:	83 c0 01             	add    $0x1,%eax
 a25:	89 45 ec             	mov    %eax,-0x14(%rbp)
  if((prevp = freep) == 0){
 a28:	48 8b 05 01 06 00 00 	mov    0x601(%rip),%rax        # 1030 <freep>
 a2f:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
 a33:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
 a38:	75 2b                	jne    a65 <malloc+0x59>
    base.s.ptr = freep = prevp = &base;
 a3a:	48 c7 45 f0 20 10 00 	movq   $0x1020,-0x10(%rbp)
 a41:	00 
 a42:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 a46:	48 89 05 e3 05 00 00 	mov    %rax,0x5e3(%rip)        # 1030 <freep>
 a4d:	48 8b 05 dc 05 00 00 	mov    0x5dc(%rip),%rax        # 1030 <freep>
 a54:	48 89 05 c5 05 00 00 	mov    %rax,0x5c5(%rip)        # 1020 <base>
    base.s.size = 0;
 a5b:	c7 05 c3 05 00 00 00 	movl   $0x0,0x5c3(%rip)        # 1028 <base+0x8>
 a62:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a65:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 a69:	48 8b 00             	mov    (%rax),%rax
 a6c:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
 a70:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a74:	8b 40 08             	mov    0x8(%rax),%eax
 a77:	3b 45 ec             	cmp    -0x14(%rbp),%eax
 a7a:	72 5f                	jb     adb <malloc+0xcf>
      if(p->s.size == nunits)
 a7c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a80:	8b 40 08             	mov    0x8(%rax),%eax
 a83:	39 45 ec             	cmp    %eax,-0x14(%rbp)
 a86:	75 10                	jne    a98 <malloc+0x8c>
        prevp->s.ptr = p->s.ptr;
 a88:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a8c:	48 8b 10             	mov    (%rax),%rdx
 a8f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 a93:	48 89 10             	mov    %rdx,(%rax)
 a96:	eb 2e                	jmp    ac6 <malloc+0xba>
      else {
        p->s.size -= nunits;
 a98:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a9c:	8b 40 08             	mov    0x8(%rax),%eax
 a9f:	2b 45 ec             	sub    -0x14(%rbp),%eax
 aa2:	89 c2                	mov    %eax,%edx
 aa4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 aa8:	89 50 08             	mov    %edx,0x8(%rax)
        p += p->s.size;
 aab:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 aaf:	8b 40 08             	mov    0x8(%rax),%eax
 ab2:	89 c0                	mov    %eax,%eax
 ab4:	48 c1 e0 04          	shl    $0x4,%rax
 ab8:	48 01 45 f8          	add    %rax,-0x8(%rbp)
        p->s.size = nunits;
 abc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 ac0:	8b 55 ec             	mov    -0x14(%rbp),%edx
 ac3:	89 50 08             	mov    %edx,0x8(%rax)
      }
      freep = prevp;
 ac6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 aca:	48 89 05 5f 05 00 00 	mov    %rax,0x55f(%rip)        # 1030 <freep>
      return (void*)(p + 1);
 ad1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 ad5:	48 83 c0 10          	add    $0x10,%rax
 ad9:	eb 41                	jmp    b1c <malloc+0x110>
    }
    if(p == freep)
 adb:	48 8b 05 4e 05 00 00 	mov    0x54e(%rip),%rax        # 1030 <freep>
 ae2:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 ae6:	75 1c                	jne    b04 <malloc+0xf8>
      if((p = morecore(nunits)) == 0)
 ae8:	8b 45 ec             	mov    -0x14(%rbp),%eax
 aeb:	89 c7                	mov    %eax,%edi
 aed:	e8 b5 fe ff ff       	call   9a7 <morecore>
 af2:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 af6:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
 afb:	75 07                	jne    b04 <malloc+0xf8>
        return 0;
 afd:	b8 00 00 00 00       	mov    $0x0,%eax
 b02:	eb 18                	jmp    b1c <malloc+0x110>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 b04:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b08:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
 b0c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b10:	48 8b 00             	mov    (%rax),%rax
 b13:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
 b17:	e9 54 ff ff ff       	jmp    a70 <malloc+0x64>
  }
}
 b1c:	c9                   	leave
 b1d:	c3                   	ret

0000000000000b1e <createRoot>:
#include "set.h"
#include "user.h"

//TODO: Να μην είναι περιορισμένο σε int

Set* createRoot(){
 b1e:	55                   	push   %rbp
 b1f:	48 89 e5             	mov    %rsp,%rbp
 b22:	48 83 ec 10          	sub    $0x10,%rsp
    //Αρχικοποίηση του Set
    Set *set = malloc(sizeof(Set));
 b26:	bf 10 00 00 00       	mov    $0x10,%edi
 b2b:	e8 dc fe ff ff       	call   a0c <malloc>
 b30:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    set->size = 0;
 b34:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b38:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%rax)
    set->root = NULL;
 b3f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b43:	48 c7 00 00 00 00 00 	movq   $0x0,(%rax)
    return set;
 b4a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
 b4e:	c9                   	leave
 b4f:	c3                   	ret

0000000000000b50 <createNode>:

void createNode(int i, Set *set){
 b50:	55                   	push   %rbp
 b51:	48 89 e5             	mov    %rsp,%rbp
 b54:	48 83 ec 20          	sub    $0x20,%rsp
 b58:	89 7d ec             	mov    %edi,-0x14(%rbp)
 b5b:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    Η συνάρτηση αυτή δημιουργεί ένα νέο SetNode με την τιμή i και εφόσον δεν υπάρχει στο Set το προσθέτει στο τέλος του συνόλου.
    Σημείωση: Ίσως υπάρχει καλύτερος τρόπος για την υλοποίηση.
    */

    //Αρχικοποίηση του SetNode
    SetNode *temp = malloc(sizeof(SetNode));
 b5f:	bf 10 00 00 00       	mov    $0x10,%edi
 b64:	e8 a3 fe ff ff       	call   a0c <malloc>
 b69:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    temp->i = i;
 b6d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 b71:	8b 55 ec             	mov    -0x14(%rbp),%edx
 b74:	89 10                	mov    %edx,(%rax)
    temp->next = NULL;
 b76:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 b7a:	48 c7 40 08 00 00 00 	movq   $0x0,0x8(%rax)
 b81:	00 

    //Έλεγχος ύπαρξης του i
    SetNode *curr = set->root;//Ξεκινάει από την root
 b82:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
 b86:	48 8b 00             	mov    (%rax),%rax
 b89:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(curr != NULL) { //Εφόσον το Set δεν είναι άδειο
 b8d:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
 b92:	74 34                	je     bc8 <createNode+0x78>
        while (curr->next != NULL){ //Εφόσον υπάρχει επόμενο node
 b94:	eb 25                	jmp    bbb <createNode+0x6b>
            if (curr->i == i){ //Αν το i υπάρχει στο σύνολο
 b96:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b9a:	8b 00                	mov    (%rax),%eax
 b9c:	39 45 ec             	cmp    %eax,-0x14(%rbp)
 b9f:	75 0e                	jne    baf <createNode+0x5f>
                free(temp); 
 ba1:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 ba5:	48 89 c7             	mov    %rax,%rdi
 ba8:	e8 d4 fc ff ff       	call   881 <free>
                return; //Δεν εκτελούμε την υπόλοιπη συνάρτηση
 bad:	eb 4e                	jmp    bfd <createNode+0xad>
            }
            curr = curr->next; //Επόμενο SetNode
 baf:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 bb3:	48 8b 40 08          	mov    0x8(%rax),%rax
 bb7:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
        while (curr->next != NULL){ //Εφόσον υπάρχει επόμενο node
 bbb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 bbf:	48 8b 40 08          	mov    0x8(%rax),%rax
 bc3:	48 85 c0             	test   %rax,%rax
 bc6:	75 ce                	jne    b96 <createNode+0x46>
        }
    }
    /*
    Ο έλεγχος στην if είναι απαραίτητος για να ελεγχθεί το τελευταίο SetNode.
    */
    if (curr->i != i) attachNode(set, curr, temp); 
 bc8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 bcc:	8b 00                	mov    (%rax),%eax
 bce:	39 45 ec             	cmp    %eax,-0x14(%rbp)
 bd1:	74 1e                	je     bf1 <createNode+0xa1>
 bd3:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
 bd7:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
 bdb:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
 bdf:	48 89 ce             	mov    %rcx,%rsi
 be2:	48 89 c7             	mov    %rax,%rdi
 be5:	b8 00 00 00 00       	mov    $0x0,%eax
 bea:	e8 10 00 00 00       	call   bff <attachNode>
 bef:	eb 0c                	jmp    bfd <createNode+0xad>
    else free(temp);
 bf1:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 bf5:	48 89 c7             	mov    %rax,%rdi
 bf8:	e8 84 fc ff ff       	call   881 <free>
}
 bfd:	c9                   	leave
 bfe:	c3                   	ret

0000000000000bff <attachNode>:

void attachNode(Set *set, SetNode *curr, SetNode *temp){
 bff:	55                   	push   %rbp
 c00:	48 89 e5             	mov    %rsp,%rbp
 c03:	48 83 ec 18          	sub    $0x18,%rsp
 c07:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
 c0b:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
 c0f:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
    //Βάζουμε το temp στο τέλος του Set
    if(set->size == 0) set->root = temp;
 c13:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 c17:	8b 40 08             	mov    0x8(%rax),%eax
 c1a:	85 c0                	test   %eax,%eax
 c1c:	75 0d                	jne    c2b <attachNode+0x2c>
 c1e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 c22:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
 c26:	48 89 10             	mov    %rdx,(%rax)
 c29:	eb 0c                	jmp    c37 <attachNode+0x38>
    else curr->next = temp;
 c2b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 c2f:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
 c33:	48 89 50 08          	mov    %rdx,0x8(%rax)
    set->size += 1;
 c37:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 c3b:	8b 40 08             	mov    0x8(%rax),%eax
 c3e:	8d 50 01             	lea    0x1(%rax),%edx
 c41:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 c45:	89 50 08             	mov    %edx,0x8(%rax)
}
 c48:	90                   	nop
 c49:	c9                   	leave
 c4a:	c3                   	ret

0000000000000c4b <deleteSet>:

void deleteSet(Set *set){
 c4b:	55                   	push   %rbp
 c4c:	48 89 e5             	mov    %rsp,%rbp
 c4f:	48 83 ec 20          	sub    $0x20,%rsp
 c53:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    if (set == NULL) return; //Αν ο χρήστης είναι ΜΛΚ!
 c57:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
 c5c:	74 42                	je     ca0 <deleteSet+0x55>
    SetNode *temp;
    SetNode *curr = set->root; //Ξεκινάμε από το root
 c5e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 c62:	48 8b 00             	mov    (%rax),%rax
 c65:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    while (curr != NULL){ 
 c69:	eb 20                	jmp    c8b <deleteSet+0x40>
        temp = curr->next; //Αναφορά στο επόμενο SetNode
 c6b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 c6f:	48 8b 40 08          	mov    0x8(%rax),%rax
 c73:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
        free(curr); //Απελευθέρωση της curr
 c77:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 c7b:	48 89 c7             	mov    %rax,%rdi
 c7e:	e8 fe fb ff ff       	call   881 <free>
        curr = temp;
 c83:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 c87:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    while (curr != NULL){ 
 c8b:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
 c90:	75 d9                	jne    c6b <deleteSet+0x20>
    }
    free(set); //Διαγραφή του Set
 c92:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 c96:	48 89 c7             	mov    %rax,%rdi
 c99:	e8 e3 fb ff ff       	call   881 <free>
 c9e:	eb 01                	jmp    ca1 <deleteSet+0x56>
    if (set == NULL) return; //Αν ο χρήστης είναι ΜΛΚ!
 ca0:	90                   	nop
}
 ca1:	c9                   	leave
 ca2:	c3                   	ret

0000000000000ca3 <getNodeAtPosition>:

SetNode* getNodeAtPosition(Set *set, int i){
 ca3:	55                   	push   %rbp
 ca4:	48 89 e5             	mov    %rsp,%rbp
 ca7:	48 83 ec 20          	sub    $0x20,%rsp
 cab:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
 caf:	89 75 e4             	mov    %esi,-0x1c(%rbp)
    if (set == NULL || set->root == NULL) return NULL; //Αν ο χρήστης είναι ΜΛΚ!
 cb2:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
 cb7:	74 0c                	je     cc5 <getNodeAtPosition+0x22>
 cb9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 cbd:	48 8b 00             	mov    (%rax),%rax
 cc0:	48 85 c0             	test   %rax,%rax
 cc3:	75 07                	jne    ccc <getNodeAtPosition+0x29>
 cc5:	b8 00 00 00 00       	mov    $0x0,%eax
 cca:	eb 3d                	jmp    d09 <getNodeAtPosition+0x66>

    SetNode *curr = set->root;
 ccc:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 cd0:	48 8b 00             	mov    (%rax),%rax
 cd3:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    int n;

    for(n = 0; n<i && curr->next != NULL; n++) curr = curr->next; //Ο έλεγχος εδω είναι: n<i && curr->next != NULL
 cd7:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
 cde:	eb 10                	jmp    cf0 <getNodeAtPosition+0x4d>
 ce0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 ce4:	48 8b 40 08          	mov    0x8(%rax),%rax
 ce8:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 cec:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
 cf0:	8b 45 f4             	mov    -0xc(%rbp),%eax
 cf3:	3b 45 e4             	cmp    -0x1c(%rbp),%eax
 cf6:	7d 0d                	jge    d05 <getNodeAtPosition+0x62>
 cf8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 cfc:	48 8b 40 08          	mov    0x8(%rax),%rax
 d00:	48 85 c0             	test   %rax,%rax
 d03:	75 db                	jne    ce0 <getNodeAtPosition+0x3d>
    return curr;
 d05:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 d09:	c9                   	leave
 d0a:	c3                   	ret
