
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
  23:	48 c7 c1 fe 0a 00 00 	mov    $0xafe,%rcx
  2a:	eb 07                	jmp    33 <main+0x33>
  2c:	48 c7 c1 00 0b 00 00 	mov    $0xb00,%rcx
  33:	8b 45 fc             	mov    -0x4(%rbp),%eax
  36:	48 98                	cltq
  38:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
  3f:	00 
  40:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  44:	48 01 d0             	add    %rdx,%rax
  47:	48 8b 00             	mov    (%rax),%rax
  4a:	48 89 c2             	mov    %rax,%rdx
  4d:	48 c7 c6 02 0b 00 00 	mov    $0xb02,%rsi
  54:	bf 01 00 00 00       	mov    $0x1,%edi
  59:	b8 00 00 00 00       	mov    $0x0,%eax
  5e:	e8 96 04 00 00       	call   4f9 <printf>
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

000000000000040f <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 40f:	55                   	push   %rbp
 410:	48 89 e5             	mov    %rsp,%rbp
 413:	48 83 ec 10          	sub    $0x10,%rsp
 417:	89 7d fc             	mov    %edi,-0x4(%rbp)
 41a:	89 f0                	mov    %esi,%eax
 41c:	88 45 f8             	mov    %al,-0x8(%rbp)
  write(fd, &c, 1);
 41f:	48 8d 4d f8          	lea    -0x8(%rbp),%rcx
 423:	8b 45 fc             	mov    -0x4(%rbp),%eax
 426:	ba 01 00 00 00       	mov    $0x1,%edx
 42b:	48 89 ce             	mov    %rcx,%rsi
 42e:	89 c7                	mov    %eax,%edi
 430:	e8 52 ff ff ff       	call   387 <write>
}
 435:	90                   	nop
 436:	c9                   	leave
 437:	c3                   	ret

0000000000000438 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 438:	55                   	push   %rbp
 439:	48 89 e5             	mov    %rsp,%rbp
 43c:	48 83 ec 30          	sub    $0x30,%rsp
 440:	89 7d dc             	mov    %edi,-0x24(%rbp)
 443:	89 75 d8             	mov    %esi,-0x28(%rbp)
 446:	89 55 d4             	mov    %edx,-0x2c(%rbp)
 449:	89 4d d0             	mov    %ecx,-0x30(%rbp)
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 44c:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
  if(sgn && xx < 0){
 453:	83 7d d0 00          	cmpl   $0x0,-0x30(%rbp)
 457:	74 17                	je     470 <printint+0x38>
 459:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
 45d:	79 11                	jns    470 <printint+0x38>
    neg = 1;
 45f:	c7 45 f8 01 00 00 00 	movl   $0x1,-0x8(%rbp)
    x = -xx;
 466:	8b 45 d8             	mov    -0x28(%rbp),%eax
 469:	f7 d8                	neg    %eax
 46b:	89 45 f4             	mov    %eax,-0xc(%rbp)
 46e:	eb 06                	jmp    476 <printint+0x3e>
  } else {
    x = xx;
 470:	8b 45 d8             	mov    -0x28(%rbp),%eax
 473:	89 45 f4             	mov    %eax,-0xc(%rbp)
  }

  i = 0;
 476:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  do{
    buf[i++] = digits[x % base];
 47d:	8b 4d d4             	mov    -0x2c(%rbp),%ecx
 480:	8b 45 f4             	mov    -0xc(%rbp),%eax
 483:	ba 00 00 00 00       	mov    $0x0,%edx
 488:	f7 f1                	div    %ecx
 48a:	89 d1                	mov    %edx,%ecx
 48c:	8b 45 fc             	mov    -0x4(%rbp),%eax
 48f:	8d 50 01             	lea    0x1(%rax),%edx
 492:	89 55 fc             	mov    %edx,-0x4(%rbp)
 495:	89 ca                	mov    %ecx,%edx
 497:	0f b6 92 50 0d 00 00 	movzbl 0xd50(%rdx),%edx
 49e:	48 98                	cltq
 4a0:	88 54 05 e0          	mov    %dl,-0x20(%rbp,%rax,1)
  }while((x /= base) != 0);
 4a4:	8b 75 d4             	mov    -0x2c(%rbp),%esi
 4a7:	8b 45 f4             	mov    -0xc(%rbp),%eax
 4aa:	ba 00 00 00 00       	mov    $0x0,%edx
 4af:	f7 f6                	div    %esi
 4b1:	89 45 f4             	mov    %eax,-0xc(%rbp)
 4b4:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
 4b8:	75 c3                	jne    47d <printint+0x45>
  if(neg)
 4ba:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
 4be:	74 2b                	je     4eb <printint+0xb3>
    buf[i++] = '-';
 4c0:	8b 45 fc             	mov    -0x4(%rbp),%eax
 4c3:	8d 50 01             	lea    0x1(%rax),%edx
 4c6:	89 55 fc             	mov    %edx,-0x4(%rbp)
 4c9:	48 98                	cltq
 4cb:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%rbp,%rax,1)

  while(--i >= 0)
 4d0:	eb 19                	jmp    4eb <printint+0xb3>
    putc(fd, buf[i]);
 4d2:	8b 45 fc             	mov    -0x4(%rbp),%eax
 4d5:	48 98                	cltq
 4d7:	0f b6 44 05 e0       	movzbl -0x20(%rbp,%rax,1),%eax
 4dc:	0f be d0             	movsbl %al,%edx
 4df:	8b 45 dc             	mov    -0x24(%rbp),%eax
 4e2:	89 d6                	mov    %edx,%esi
 4e4:	89 c7                	mov    %eax,%edi
 4e6:	e8 24 ff ff ff       	call   40f <putc>
  while(--i >= 0)
 4eb:	83 6d fc 01          	subl   $0x1,-0x4(%rbp)
 4ef:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
 4f3:	79 dd                	jns    4d2 <printint+0x9a>
}
 4f5:	90                   	nop
 4f6:	90                   	nop
 4f7:	c9                   	leave
 4f8:	c3                   	ret

00000000000004f9 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 4f9:	55                   	push   %rbp
 4fa:	48 89 e5             	mov    %rsp,%rbp
 4fd:	48 81 ec f0 00 00 00 	sub    $0xf0,%rsp
 504:	89 bd 1c ff ff ff    	mov    %edi,-0xe4(%rbp)
 50a:	48 89 b5 10 ff ff ff 	mov    %rsi,-0xf0(%rbp)
 511:	48 89 95 60 ff ff ff 	mov    %rdx,-0xa0(%rbp)
 518:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
 51f:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
 526:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
 52d:	84 c0                	test   %al,%al
 52f:	74 20                	je     551 <printf+0x58>
 531:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
 535:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
 539:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
 53d:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
 541:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
 545:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
 549:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
 54d:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  va_list ap;
  char *s;
  int c, i, state;
  va_start(ap, fmt);
 551:	c7 85 20 ff ff ff 10 	movl   $0x10,-0xe0(%rbp)
 558:	00 00 00 
 55b:	c7 85 24 ff ff ff 30 	movl   $0x30,-0xdc(%rbp)
 562:	00 00 00 
 565:	48 8d 45 10          	lea    0x10(%rbp),%rax
 569:	48 89 85 28 ff ff ff 	mov    %rax,-0xd8(%rbp)
 570:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
 577:	48 89 85 30 ff ff ff 	mov    %rax,-0xd0(%rbp)

  state = 0;
 57e:	c7 85 40 ff ff ff 00 	movl   $0x0,-0xc0(%rbp)
 585:	00 00 00 
  for(i = 0; fmt[i]; i++){
 588:	c7 85 44 ff ff ff 00 	movl   $0x0,-0xbc(%rbp)
 58f:	00 00 00 
 592:	e9 a8 02 00 00       	jmp    83f <printf+0x346>
    c = fmt[i] & 0xff;
 597:	8b 85 44 ff ff ff    	mov    -0xbc(%rbp),%eax
 59d:	48 63 d0             	movslq %eax,%rdx
 5a0:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
 5a7:	48 01 d0             	add    %rdx,%rax
 5aa:	0f b6 00             	movzbl (%rax),%eax
 5ad:	0f be c0             	movsbl %al,%eax
 5b0:	25 ff 00 00 00       	and    $0xff,%eax
 5b5:	89 85 3c ff ff ff    	mov    %eax,-0xc4(%rbp)
    if(state == 0){
 5bb:	83 bd 40 ff ff ff 00 	cmpl   $0x0,-0xc0(%rbp)
 5c2:	75 35                	jne    5f9 <printf+0x100>
      if(c == '%'){
 5c4:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
 5cb:	75 0f                	jne    5dc <printf+0xe3>
        state = '%';
 5cd:	c7 85 40 ff ff ff 25 	movl   $0x25,-0xc0(%rbp)
 5d4:	00 00 00 
 5d7:	e9 5c 02 00 00       	jmp    838 <printf+0x33f>
      } else {
        putc(fd, c);
 5dc:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
 5e2:	0f be d0             	movsbl %al,%edx
 5e5:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 5eb:	89 d6                	mov    %edx,%esi
 5ed:	89 c7                	mov    %eax,%edi
 5ef:	e8 1b fe ff ff       	call   40f <putc>
 5f4:	e9 3f 02 00 00       	jmp    838 <printf+0x33f>
      }
    } else if(state == '%'){
 5f9:	83 bd 40 ff ff ff 25 	cmpl   $0x25,-0xc0(%rbp)
 600:	0f 85 32 02 00 00    	jne    838 <printf+0x33f>
      if(c == 'd'){
 606:	83 bd 3c ff ff ff 64 	cmpl   $0x64,-0xc4(%rbp)
 60d:	75 5e                	jne    66d <printf+0x174>
        printint(fd, va_arg(ap, int), 10, 1);
 60f:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 615:	83 f8 2f             	cmp    $0x2f,%eax
 618:	77 23                	ja     63d <printf+0x144>
 61a:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 621:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 627:	89 d2                	mov    %edx,%edx
 629:	48 01 d0             	add    %rdx,%rax
 62c:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 632:	83 c2 08             	add    $0x8,%edx
 635:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 63b:	eb 12                	jmp    64f <printf+0x156>
 63d:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 644:	48 8d 50 08          	lea    0x8(%rax),%rdx
 648:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 64f:	8b 30                	mov    (%rax),%esi
 651:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 657:	b9 01 00 00 00       	mov    $0x1,%ecx
 65c:	ba 0a 00 00 00       	mov    $0xa,%edx
 661:	89 c7                	mov    %eax,%edi
 663:	e8 d0 fd ff ff       	call   438 <printint>
 668:	e9 c1 01 00 00       	jmp    82e <printf+0x335>
      } else if(c == 'x' || c == 'p'){
 66d:	83 bd 3c ff ff ff 78 	cmpl   $0x78,-0xc4(%rbp)
 674:	74 09                	je     67f <printf+0x186>
 676:	83 bd 3c ff ff ff 70 	cmpl   $0x70,-0xc4(%rbp)
 67d:	75 5e                	jne    6dd <printf+0x1e4>
        printint(fd, va_arg(ap, int), 16, 0);
 67f:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 685:	83 f8 2f             	cmp    $0x2f,%eax
 688:	77 23                	ja     6ad <printf+0x1b4>
 68a:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 691:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 697:	89 d2                	mov    %edx,%edx
 699:	48 01 d0             	add    %rdx,%rax
 69c:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 6a2:	83 c2 08             	add    $0x8,%edx
 6a5:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 6ab:	eb 12                	jmp    6bf <printf+0x1c6>
 6ad:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 6b4:	48 8d 50 08          	lea    0x8(%rax),%rdx
 6b8:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 6bf:	8b 30                	mov    (%rax),%esi
 6c1:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 6c7:	b9 00 00 00 00       	mov    $0x0,%ecx
 6cc:	ba 10 00 00 00       	mov    $0x10,%edx
 6d1:	89 c7                	mov    %eax,%edi
 6d3:	e8 60 fd ff ff       	call   438 <printint>
 6d8:	e9 51 01 00 00       	jmp    82e <printf+0x335>
      } else if(c == 's'){
 6dd:	83 bd 3c ff ff ff 73 	cmpl   $0x73,-0xc4(%rbp)
 6e4:	0f 85 98 00 00 00    	jne    782 <printf+0x289>
        s = va_arg(ap, char*);
 6ea:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 6f0:	83 f8 2f             	cmp    $0x2f,%eax
 6f3:	77 23                	ja     718 <printf+0x21f>
 6f5:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 6fc:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 702:	89 d2                	mov    %edx,%edx
 704:	48 01 d0             	add    %rdx,%rax
 707:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 70d:	83 c2 08             	add    $0x8,%edx
 710:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 716:	eb 12                	jmp    72a <printf+0x231>
 718:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 71f:	48 8d 50 08          	lea    0x8(%rax),%rdx
 723:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 72a:	48 8b 00             	mov    (%rax),%rax
 72d:	48 89 85 48 ff ff ff 	mov    %rax,-0xb8(%rbp)
        if(s == 0)
 734:	48 83 bd 48 ff ff ff 	cmpq   $0x0,-0xb8(%rbp)
 73b:	00 
 73c:	75 31                	jne    76f <printf+0x276>
          s = "(null)";
 73e:	48 c7 85 48 ff ff ff 	movq   $0xb07,-0xb8(%rbp)
 745:	07 0b 00 00 
        while(*s != 0){
 749:	eb 24                	jmp    76f <printf+0x276>
          putc(fd, *s);
 74b:	48 8b 85 48 ff ff ff 	mov    -0xb8(%rbp),%rax
 752:	0f b6 00             	movzbl (%rax),%eax
 755:	0f be d0             	movsbl %al,%edx
 758:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 75e:	89 d6                	mov    %edx,%esi
 760:	89 c7                	mov    %eax,%edi
 762:	e8 a8 fc ff ff       	call   40f <putc>
          s++;
 767:	48 83 85 48 ff ff ff 	addq   $0x1,-0xb8(%rbp)
 76e:	01 
        while(*s != 0){
 76f:	48 8b 85 48 ff ff ff 	mov    -0xb8(%rbp),%rax
 776:	0f b6 00             	movzbl (%rax),%eax
 779:	84 c0                	test   %al,%al
 77b:	75 ce                	jne    74b <printf+0x252>
 77d:	e9 ac 00 00 00       	jmp    82e <printf+0x335>
        }
      } else if(c == 'c'){
 782:	83 bd 3c ff ff ff 63 	cmpl   $0x63,-0xc4(%rbp)
 789:	75 56                	jne    7e1 <printf+0x2e8>
        putc(fd, va_arg(ap, uint));
 78b:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 791:	83 f8 2f             	cmp    $0x2f,%eax
 794:	77 23                	ja     7b9 <printf+0x2c0>
 796:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 79d:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 7a3:	89 d2                	mov    %edx,%edx
 7a5:	48 01 d0             	add    %rdx,%rax
 7a8:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 7ae:	83 c2 08             	add    $0x8,%edx
 7b1:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 7b7:	eb 12                	jmp    7cb <printf+0x2d2>
 7b9:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 7c0:	48 8d 50 08          	lea    0x8(%rax),%rdx
 7c4:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 7cb:	8b 00                	mov    (%rax),%eax
 7cd:	0f be d0             	movsbl %al,%edx
 7d0:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 7d6:	89 d6                	mov    %edx,%esi
 7d8:	89 c7                	mov    %eax,%edi
 7da:	e8 30 fc ff ff       	call   40f <putc>
 7df:	eb 4d                	jmp    82e <printf+0x335>
      } else if(c == '%'){
 7e1:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
 7e8:	75 1a                	jne    804 <printf+0x30b>
        putc(fd, c);
 7ea:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
 7f0:	0f be d0             	movsbl %al,%edx
 7f3:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 7f9:	89 d6                	mov    %edx,%esi
 7fb:	89 c7                	mov    %eax,%edi
 7fd:	e8 0d fc ff ff       	call   40f <putc>
 802:	eb 2a                	jmp    82e <printf+0x335>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 804:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 80a:	be 25 00 00 00       	mov    $0x25,%esi
 80f:	89 c7                	mov    %eax,%edi
 811:	e8 f9 fb ff ff       	call   40f <putc>
        putc(fd, c);
 816:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
 81c:	0f be d0             	movsbl %al,%edx
 81f:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 825:	89 d6                	mov    %edx,%esi
 827:	89 c7                	mov    %eax,%edi
 829:	e8 e1 fb ff ff       	call   40f <putc>
      }
      state = 0;
 82e:	c7 85 40 ff ff ff 00 	movl   $0x0,-0xc0(%rbp)
 835:	00 00 00 
  for(i = 0; fmt[i]; i++){
 838:	83 85 44 ff ff ff 01 	addl   $0x1,-0xbc(%rbp)
 83f:	8b 85 44 ff ff ff    	mov    -0xbc(%rbp),%eax
 845:	48 63 d0             	movslq %eax,%rdx
 848:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
 84f:	48 01 d0             	add    %rdx,%rax
 852:	0f b6 00             	movzbl (%rax),%eax
 855:	84 c0                	test   %al,%al
 857:	0f 85 3a fd ff ff    	jne    597 <printf+0x9e>
    }
  }
}
 85d:	90                   	nop
 85e:	90                   	nop
 85f:	c9                   	leave
 860:	c3                   	ret

0000000000000861 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 861:	55                   	push   %rbp
 862:	48 89 e5             	mov    %rsp,%rbp
 865:	48 83 ec 18          	sub    $0x18,%rsp
 869:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  Header *bp, *p;

  bp = (Header*)ap - 1;
 86d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 871:	48 83 e8 10          	sub    $0x10,%rax
 875:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 879:	48 8b 05 00 05 00 00 	mov    0x500(%rip),%rax        # d80 <freep>
 880:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 884:	eb 2f                	jmp    8b5 <free+0x54>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 886:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 88a:	48 8b 00             	mov    (%rax),%rax
 88d:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 891:	72 17                	jb     8aa <free+0x49>
 893:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 897:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 89b:	72 2f                	jb     8cc <free+0x6b>
 89d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 8a1:	48 8b 00             	mov    (%rax),%rax
 8a4:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
 8a8:	72 22                	jb     8cc <free+0x6b>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8aa:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 8ae:	48 8b 00             	mov    (%rax),%rax
 8b1:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 8b5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 8b9:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 8bd:	73 c7                	jae    886 <free+0x25>
 8bf:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 8c3:	48 8b 00             	mov    (%rax),%rax
 8c6:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
 8ca:	73 ba                	jae    886 <free+0x25>
      break;
  if(bp + bp->s.size == p->s.ptr){
 8cc:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 8d0:	8b 40 08             	mov    0x8(%rax),%eax
 8d3:	89 c0                	mov    %eax,%eax
 8d5:	48 c1 e0 04          	shl    $0x4,%rax
 8d9:	48 89 c2             	mov    %rax,%rdx
 8dc:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 8e0:	48 01 c2             	add    %rax,%rdx
 8e3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 8e7:	48 8b 00             	mov    (%rax),%rax
 8ea:	48 39 c2             	cmp    %rax,%rdx
 8ed:	75 2d                	jne    91c <free+0xbb>
    bp->s.size += p->s.ptr->s.size;
 8ef:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 8f3:	8b 50 08             	mov    0x8(%rax),%edx
 8f6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 8fa:	48 8b 00             	mov    (%rax),%rax
 8fd:	8b 40 08             	mov    0x8(%rax),%eax
 900:	01 c2                	add    %eax,%edx
 902:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 906:	89 50 08             	mov    %edx,0x8(%rax)
    bp->s.ptr = p->s.ptr->s.ptr;
 909:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 90d:	48 8b 00             	mov    (%rax),%rax
 910:	48 8b 10             	mov    (%rax),%rdx
 913:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 917:	48 89 10             	mov    %rdx,(%rax)
 91a:	eb 0e                	jmp    92a <free+0xc9>
  } else
    bp->s.ptr = p->s.ptr;
 91c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 920:	48 8b 10             	mov    (%rax),%rdx
 923:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 927:	48 89 10             	mov    %rdx,(%rax)
  if(p + p->s.size == bp){
 92a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 92e:	8b 40 08             	mov    0x8(%rax),%eax
 931:	89 c0                	mov    %eax,%eax
 933:	48 c1 e0 04          	shl    $0x4,%rax
 937:	48 89 c2             	mov    %rax,%rdx
 93a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 93e:	48 01 d0             	add    %rdx,%rax
 941:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
 945:	75 27                	jne    96e <free+0x10d>
    p->s.size += bp->s.size;
 947:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 94b:	8b 50 08             	mov    0x8(%rax),%edx
 94e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 952:	8b 40 08             	mov    0x8(%rax),%eax
 955:	01 c2                	add    %eax,%edx
 957:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 95b:	89 50 08             	mov    %edx,0x8(%rax)
    p->s.ptr = bp->s.ptr;
 95e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 962:	48 8b 10             	mov    (%rax),%rdx
 965:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 969:	48 89 10             	mov    %rdx,(%rax)
 96c:	eb 0b                	jmp    979 <free+0x118>
  } else
    p->s.ptr = bp;
 96e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 972:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
 976:	48 89 10             	mov    %rdx,(%rax)
  freep = p;
 979:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 97d:	48 89 05 fc 03 00 00 	mov    %rax,0x3fc(%rip)        # d80 <freep>
}
 984:	90                   	nop
 985:	c9                   	leave
 986:	c3                   	ret

0000000000000987 <morecore>:

static Header*
morecore(uint nu)
{
 987:	55                   	push   %rbp
 988:	48 89 e5             	mov    %rsp,%rbp
 98b:	48 83 ec 20          	sub    $0x20,%rsp
 98f:	89 7d ec             	mov    %edi,-0x14(%rbp)
  char *p;
  Header *hp;

  if(nu < 4096)
 992:	81 7d ec ff 0f 00 00 	cmpl   $0xfff,-0x14(%rbp)
 999:	77 07                	ja     9a2 <morecore+0x1b>
    nu = 4096;
 99b:	c7 45 ec 00 10 00 00 	movl   $0x1000,-0x14(%rbp)
  p = sbrk(nu * sizeof(Header));
 9a2:	8b 45 ec             	mov    -0x14(%rbp),%eax
 9a5:	c1 e0 04             	shl    $0x4,%eax
 9a8:	89 c7                	mov    %eax,%edi
 9aa:	e8 40 fa ff ff       	call   3ef <sbrk>
 9af:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  if(p == (char*)-1)
 9b3:	48 83 7d f8 ff       	cmpq   $0xffffffffffffffff,-0x8(%rbp)
 9b8:	75 07                	jne    9c1 <morecore+0x3a>
    return 0;
 9ba:	b8 00 00 00 00       	mov    $0x0,%eax
 9bf:	eb 29                	jmp    9ea <morecore+0x63>
  hp = (Header*)p;
 9c1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 9c5:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  hp->s.size = nu;
 9c9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 9cd:	8b 55 ec             	mov    -0x14(%rbp),%edx
 9d0:	89 50 08             	mov    %edx,0x8(%rax)
  free((void*)(hp + 1));
 9d3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 9d7:	48 83 c0 10          	add    $0x10,%rax
 9db:	48 89 c7             	mov    %rax,%rdi
 9de:	e8 7e fe ff ff       	call   861 <free>
  return freep;
 9e3:	48 8b 05 96 03 00 00 	mov    0x396(%rip),%rax        # d80 <freep>
}
 9ea:	c9                   	leave
 9eb:	c3                   	ret

00000000000009ec <malloc>:

void*
malloc(uint nbytes)
{
 9ec:	55                   	push   %rbp
 9ed:	48 89 e5             	mov    %rsp,%rbp
 9f0:	48 83 ec 30          	sub    $0x30,%rsp
 9f4:	89 7d dc             	mov    %edi,-0x24(%rbp)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 9f7:	8b 45 dc             	mov    -0x24(%rbp),%eax
 9fa:	48 83 c0 0f          	add    $0xf,%rax
 9fe:	48 c1 e8 04          	shr    $0x4,%rax
 a02:	83 c0 01             	add    $0x1,%eax
 a05:	89 45 ec             	mov    %eax,-0x14(%rbp)
  if((prevp = freep) == 0){
 a08:	48 8b 05 71 03 00 00 	mov    0x371(%rip),%rax        # d80 <freep>
 a0f:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
 a13:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
 a18:	75 2b                	jne    a45 <malloc+0x59>
    base.s.ptr = freep = prevp = &base;
 a1a:	48 c7 45 f0 70 0d 00 	movq   $0xd70,-0x10(%rbp)
 a21:	00 
 a22:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 a26:	48 89 05 53 03 00 00 	mov    %rax,0x353(%rip)        # d80 <freep>
 a2d:	48 8b 05 4c 03 00 00 	mov    0x34c(%rip),%rax        # d80 <freep>
 a34:	48 89 05 35 03 00 00 	mov    %rax,0x335(%rip)        # d70 <base>
    base.s.size = 0;
 a3b:	c7 05 33 03 00 00 00 	movl   $0x0,0x333(%rip)        # d78 <base+0x8>
 a42:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a45:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 a49:	48 8b 00             	mov    (%rax),%rax
 a4c:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
 a50:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a54:	8b 40 08             	mov    0x8(%rax),%eax
 a57:	3b 45 ec             	cmp    -0x14(%rbp),%eax
 a5a:	72 5f                	jb     abb <malloc+0xcf>
      if(p->s.size == nunits)
 a5c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a60:	8b 40 08             	mov    0x8(%rax),%eax
 a63:	39 45 ec             	cmp    %eax,-0x14(%rbp)
 a66:	75 10                	jne    a78 <malloc+0x8c>
        prevp->s.ptr = p->s.ptr;
 a68:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a6c:	48 8b 10             	mov    (%rax),%rdx
 a6f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 a73:	48 89 10             	mov    %rdx,(%rax)
 a76:	eb 2e                	jmp    aa6 <malloc+0xba>
      else {
        p->s.size -= nunits;
 a78:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a7c:	8b 40 08             	mov    0x8(%rax),%eax
 a7f:	2b 45 ec             	sub    -0x14(%rbp),%eax
 a82:	89 c2                	mov    %eax,%edx
 a84:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a88:	89 50 08             	mov    %edx,0x8(%rax)
        p += p->s.size;
 a8b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a8f:	8b 40 08             	mov    0x8(%rax),%eax
 a92:	89 c0                	mov    %eax,%eax
 a94:	48 c1 e0 04          	shl    $0x4,%rax
 a98:	48 01 45 f8          	add    %rax,-0x8(%rbp)
        p->s.size = nunits;
 a9c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 aa0:	8b 55 ec             	mov    -0x14(%rbp),%edx
 aa3:	89 50 08             	mov    %edx,0x8(%rax)
      }
      freep = prevp;
 aa6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 aaa:	48 89 05 cf 02 00 00 	mov    %rax,0x2cf(%rip)        # d80 <freep>
      return (void*)(p + 1);
 ab1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 ab5:	48 83 c0 10          	add    $0x10,%rax
 ab9:	eb 41                	jmp    afc <malloc+0x110>
    }
    if(p == freep)
 abb:	48 8b 05 be 02 00 00 	mov    0x2be(%rip),%rax        # d80 <freep>
 ac2:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 ac6:	75 1c                	jne    ae4 <malloc+0xf8>
      if((p = morecore(nunits)) == 0)
 ac8:	8b 45 ec             	mov    -0x14(%rbp),%eax
 acb:	89 c7                	mov    %eax,%edi
 acd:	e8 b5 fe ff ff       	call   987 <morecore>
 ad2:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 ad6:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
 adb:	75 07                	jne    ae4 <malloc+0xf8>
        return 0;
 add:	b8 00 00 00 00       	mov    $0x0,%eax
 ae2:	eb 18                	jmp    afc <malloc+0x110>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 ae4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 ae8:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
 aec:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 af0:	48 8b 00             	mov    (%rax),%rax
 af3:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
 af7:	e9 54 ff ff ff       	jmp    a50 <malloc+0x64>
  }
}
 afc:	c9                   	leave
 afd:	c3                   	ret
