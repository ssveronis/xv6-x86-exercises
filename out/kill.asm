
fs/kill:     file format elf64-x86-64


Disassembly of section .text:

0000000000000000 <main>:
#include "stat.h"
#include "user.h"

int
main(int argc, char **argv)
{
   0:	55                   	push   %rbp
   1:	48 89 e5             	mov    %rsp,%rbp
   4:	48 83 ec 20          	sub    $0x20,%rsp
   8:	89 7d ec             	mov    %edi,-0x14(%rbp)
   b:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  int i;

  if(argc < 1){
   f:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  13:	7f 1b                	jg     30 <main+0x30>
    printf(2, "usage: kill pid...\n");
  15:	48 c7 c6 07 0d 00 00 	mov    $0xd07,%rsi
  1c:	bf 02 00 00 00       	mov    $0x2,%edi
  21:	b8 00 00 00 00       	mov    $0x0,%eax
  26:	e8 ea 04 00 00       	call   515 <printf>
    exit();
  2b:	e8 33 03 00 00       	call   363 <exit>
  }
  for(i=1; i<argc; i++)
  30:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%rbp)
  37:	eb 2a                	jmp    63 <main+0x63>
    kill(atoi(argv[i]));
  39:	8b 45 fc             	mov    -0x4(%rbp),%eax
  3c:	48 98                	cltq
  3e:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
  45:	00 
  46:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  4a:	48 01 d0             	add    %rdx,%rax
  4d:	48 8b 00             	mov    (%rax),%rax
  50:	48 89 c7             	mov    %rax,%rdi
  53:	e8 56 02 00 00       	call   2ae <atoi>
  58:	89 c7                	mov    %eax,%edi
  5a:	e8 34 03 00 00       	call   393 <kill>
  for(i=1; i<argc; i++)
  5f:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  63:	8b 45 fc             	mov    -0x4(%rbp),%eax
  66:	3b 45 ec             	cmp    -0x14(%rbp),%eax
  69:	7c ce                	jl     39 <main+0x39>
  exit();
  6b:	e8 f3 02 00 00       	call   363 <exit>

0000000000000070 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
  70:	55                   	push   %rbp
  71:	48 89 e5             	mov    %rsp,%rbp
  74:	48 83 ec 10          	sub    $0x10,%rsp
  78:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  7c:	89 75 f4             	mov    %esi,-0xc(%rbp)
  7f:	89 55 f0             	mov    %edx,-0x10(%rbp)
  asm volatile("cld; rep stosb" :
  82:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
  86:	8b 55 f0             	mov    -0x10(%rbp),%edx
  89:	8b 45 f4             	mov    -0xc(%rbp),%eax
  8c:	48 89 ce             	mov    %rcx,%rsi
  8f:	48 89 f7             	mov    %rsi,%rdi
  92:	89 d1                	mov    %edx,%ecx
  94:	fc                   	cld
  95:	f3 aa                	rep stos %al,%es:(%rdi)
  97:	89 ca                	mov    %ecx,%edx
  99:	48 89 fe             	mov    %rdi,%rsi
  9c:	48 89 75 f8          	mov    %rsi,-0x8(%rbp)
  a0:	89 55 f0             	mov    %edx,-0x10(%rbp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
  a3:	90                   	nop
  a4:	c9                   	leave
  a5:	c3                   	ret

00000000000000a6 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
  a6:	55                   	push   %rbp
  a7:	48 89 e5             	mov    %rsp,%rbp
  aa:	48 83 ec 20          	sub    $0x20,%rsp
  ae:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  b2:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  char *os;

  os = s;
  b6:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  ba:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  while((*s++ = *t++) != 0)
  be:	90                   	nop
  bf:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  c3:	48 8d 42 01          	lea    0x1(%rdx),%rax
  c7:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  cb:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  cf:	48 8d 48 01          	lea    0x1(%rax),%rcx
  d3:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  d7:	0f b6 12             	movzbl (%rdx),%edx
  da:	88 10                	mov    %dl,(%rax)
  dc:	0f b6 00             	movzbl (%rax),%eax
  df:	84 c0                	test   %al,%al
  e1:	75 dc                	jne    bf <strcpy+0x19>
    ;
  return os;
  e3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
  e7:	c9                   	leave
  e8:	c3                   	ret

00000000000000e9 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  e9:	55                   	push   %rbp
  ea:	48 89 e5             	mov    %rsp,%rbp
  ed:	48 83 ec 10          	sub    $0x10,%rsp
  f1:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  f5:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  while(*p && *p == *q)
  f9:	eb 0a                	jmp    105 <strcmp+0x1c>
    p++, q++;
  fb:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
 100:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  while(*p && *p == *q)
 105:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 109:	0f b6 00             	movzbl (%rax),%eax
 10c:	84 c0                	test   %al,%al
 10e:	74 12                	je     122 <strcmp+0x39>
 110:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 114:	0f b6 10             	movzbl (%rax),%edx
 117:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 11b:	0f b6 00             	movzbl (%rax),%eax
 11e:	38 c2                	cmp    %al,%dl
 120:	74 d9                	je     fb <strcmp+0x12>
  return (uchar)*p - (uchar)*q;
 122:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 126:	0f b6 00             	movzbl (%rax),%eax
 129:	0f b6 d0             	movzbl %al,%edx
 12c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 130:	0f b6 00             	movzbl (%rax),%eax
 133:	0f b6 c0             	movzbl %al,%eax
 136:	29 c2                	sub    %eax,%edx
 138:	89 d0                	mov    %edx,%eax
}
 13a:	c9                   	leave
 13b:	c3                   	ret

000000000000013c <strlen>:

uint
strlen(char *s)
{
 13c:	55                   	push   %rbp
 13d:	48 89 e5             	mov    %rsp,%rbp
 140:	48 83 ec 18          	sub    $0x18,%rsp
 144:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  int n;

  for(n = 0; s[n]; n++)
 148:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
 14f:	eb 04                	jmp    155 <strlen+0x19>
 151:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
 155:	8b 45 fc             	mov    -0x4(%rbp),%eax
 158:	48 63 d0             	movslq %eax,%rdx
 15b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 15f:	48 01 d0             	add    %rdx,%rax
 162:	0f b6 00             	movzbl (%rax),%eax
 165:	84 c0                	test   %al,%al
 167:	75 e8                	jne    151 <strlen+0x15>
    ;
  return n;
 169:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
 16c:	c9                   	leave
 16d:	c3                   	ret

000000000000016e <memset>:

void*
memset(void *dst, int c, uint n)
{
 16e:	55                   	push   %rbp
 16f:	48 89 e5             	mov    %rsp,%rbp
 172:	48 83 ec 10          	sub    $0x10,%rsp
 176:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
 17a:	89 75 f4             	mov    %esi,-0xc(%rbp)
 17d:	89 55 f0             	mov    %edx,-0x10(%rbp)
  stosb(dst, c, n);
 180:	8b 55 f0             	mov    -0x10(%rbp),%edx
 183:	8b 4d f4             	mov    -0xc(%rbp),%ecx
 186:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 18a:	89 ce                	mov    %ecx,%esi
 18c:	48 89 c7             	mov    %rax,%rdi
 18f:	e8 dc fe ff ff       	call   70 <stosb>
  return dst;
 194:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
 198:	c9                   	leave
 199:	c3                   	ret

000000000000019a <strchr>:

char*
strchr(const char *s, char c)
{
 19a:	55                   	push   %rbp
 19b:	48 89 e5             	mov    %rsp,%rbp
 19e:	48 83 ec 10          	sub    $0x10,%rsp
 1a2:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
 1a6:	89 f0                	mov    %esi,%eax
 1a8:	88 45 f4             	mov    %al,-0xc(%rbp)
  for(; *s; s++)
 1ab:	eb 17                	jmp    1c4 <strchr+0x2a>
    if(*s == c)
 1ad:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 1b1:	0f b6 00             	movzbl (%rax),%eax
 1b4:	38 45 f4             	cmp    %al,-0xc(%rbp)
 1b7:	75 06                	jne    1bf <strchr+0x25>
      return (char*)s;
 1b9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 1bd:	eb 15                	jmp    1d4 <strchr+0x3a>
  for(; *s; s++)
 1bf:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
 1c4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 1c8:	0f b6 00             	movzbl (%rax),%eax
 1cb:	84 c0                	test   %al,%al
 1cd:	75 de                	jne    1ad <strchr+0x13>
  return 0;
 1cf:	b8 00 00 00 00       	mov    $0x0,%eax
}
 1d4:	c9                   	leave
 1d5:	c3                   	ret

00000000000001d6 <gets>:

char*
gets(char *buf, int max)
{
 1d6:	55                   	push   %rbp
 1d7:	48 89 e5             	mov    %rsp,%rbp
 1da:	48 83 ec 20          	sub    $0x20,%rsp
 1de:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
 1e2:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1e5:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
 1ec:	eb 48                	jmp    236 <gets+0x60>
    cc = read(0, &c, 1);
 1ee:	48 8d 45 f7          	lea    -0x9(%rbp),%rax
 1f2:	ba 01 00 00 00       	mov    $0x1,%edx
 1f7:	48 89 c6             	mov    %rax,%rsi
 1fa:	bf 00 00 00 00       	mov    $0x0,%edi
 1ff:	e8 77 01 00 00       	call   37b <read>
 204:	89 45 f8             	mov    %eax,-0x8(%rbp)
    if(cc < 1)
 207:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
 20b:	7e 36                	jle    243 <gets+0x6d>
      break;
    buf[i++] = c;
 20d:	8b 45 fc             	mov    -0x4(%rbp),%eax
 210:	8d 50 01             	lea    0x1(%rax),%edx
 213:	89 55 fc             	mov    %edx,-0x4(%rbp)
 216:	48 63 d0             	movslq %eax,%rdx
 219:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 21d:	48 01 c2             	add    %rax,%rdx
 220:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
 224:	88 02                	mov    %al,(%rdx)
    if(c == '\n' || c == '\r')
 226:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
 22a:	3c 0a                	cmp    $0xa,%al
 22c:	74 16                	je     244 <gets+0x6e>
 22e:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
 232:	3c 0d                	cmp    $0xd,%al
 234:	74 0e                	je     244 <gets+0x6e>
  for(i=0; i+1 < max; ){
 236:	8b 45 fc             	mov    -0x4(%rbp),%eax
 239:	83 c0 01             	add    $0x1,%eax
 23c:	39 45 e4             	cmp    %eax,-0x1c(%rbp)
 23f:	7f ad                	jg     1ee <gets+0x18>
 241:	eb 01                	jmp    244 <gets+0x6e>
      break;
 243:	90                   	nop
      break;
  }
  buf[i] = '\0';
 244:	8b 45 fc             	mov    -0x4(%rbp),%eax
 247:	48 63 d0             	movslq %eax,%rdx
 24a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 24e:	48 01 d0             	add    %rdx,%rax
 251:	c6 00 00             	movb   $0x0,(%rax)
  return buf;
 254:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
 258:	c9                   	leave
 259:	c3                   	ret

000000000000025a <stat>:

int
stat(char *n, struct stat *st)
{
 25a:	55                   	push   %rbp
 25b:	48 89 e5             	mov    %rsp,%rbp
 25e:	48 83 ec 20          	sub    $0x20,%rsp
 262:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
 266:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 26a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 26e:	be 00 00 00 00       	mov    $0x0,%esi
 273:	48 89 c7             	mov    %rax,%rdi
 276:	e8 28 01 00 00       	call   3a3 <open>
 27b:	89 45 fc             	mov    %eax,-0x4(%rbp)
  if(fd < 0)
 27e:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
 282:	79 07                	jns    28b <stat+0x31>
    return -1;
 284:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 289:	eb 21                	jmp    2ac <stat+0x52>
  r = fstat(fd, st);
 28b:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
 28f:	8b 45 fc             	mov    -0x4(%rbp),%eax
 292:	48 89 d6             	mov    %rdx,%rsi
 295:	89 c7                	mov    %eax,%edi
 297:	e8 1f 01 00 00       	call   3bb <fstat>
 29c:	89 45 f8             	mov    %eax,-0x8(%rbp)
  close(fd);
 29f:	8b 45 fc             	mov    -0x4(%rbp),%eax
 2a2:	89 c7                	mov    %eax,%edi
 2a4:	e8 e2 00 00 00       	call   38b <close>
  return r;
 2a9:	8b 45 f8             	mov    -0x8(%rbp),%eax
}
 2ac:	c9                   	leave
 2ad:	c3                   	ret

00000000000002ae <atoi>:

int
atoi(const char *s)
{
 2ae:	55                   	push   %rbp
 2af:	48 89 e5             	mov    %rsp,%rbp
 2b2:	48 83 ec 18          	sub    $0x18,%rsp
 2b6:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  int n;

  n = 0;
 2ba:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  while('0' <= *s && *s <= '9')
 2c1:	eb 28                	jmp    2eb <atoi+0x3d>
    n = n*10 + *s++ - '0';
 2c3:	8b 55 fc             	mov    -0x4(%rbp),%edx
 2c6:	89 d0                	mov    %edx,%eax
 2c8:	c1 e0 02             	shl    $0x2,%eax
 2cb:	01 d0                	add    %edx,%eax
 2cd:	01 c0                	add    %eax,%eax
 2cf:	89 c1                	mov    %eax,%ecx
 2d1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 2d5:	48 8d 50 01          	lea    0x1(%rax),%rdx
 2d9:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
 2dd:	0f b6 00             	movzbl (%rax),%eax
 2e0:	0f be c0             	movsbl %al,%eax
 2e3:	01 c8                	add    %ecx,%eax
 2e5:	83 e8 30             	sub    $0x30,%eax
 2e8:	89 45 fc             	mov    %eax,-0x4(%rbp)
  while('0' <= *s && *s <= '9')
 2eb:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 2ef:	0f b6 00             	movzbl (%rax),%eax
 2f2:	3c 2f                	cmp    $0x2f,%al
 2f4:	7e 0b                	jle    301 <atoi+0x53>
 2f6:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 2fa:	0f b6 00             	movzbl (%rax),%eax
 2fd:	3c 39                	cmp    $0x39,%al
 2ff:	7e c2                	jle    2c3 <atoi+0x15>
  return n;
 301:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
 304:	c9                   	leave
 305:	c3                   	ret

0000000000000306 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 306:	55                   	push   %rbp
 307:	48 89 e5             	mov    %rsp,%rbp
 30a:	48 83 ec 28          	sub    $0x28,%rsp
 30e:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
 312:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
 316:	89 55 dc             	mov    %edx,-0x24(%rbp)
  char *dst, *src;
  
  dst = vdst;
 319:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 31d:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  src = vsrc;
 321:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
 325:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  while(n-- > 0)
 329:	eb 1d                	jmp    348 <memmove+0x42>
    *dst++ = *src++;
 32b:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
 32f:	48 8d 42 01          	lea    0x1(%rdx),%rax
 333:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
 337:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 33b:	48 8d 48 01          	lea    0x1(%rax),%rcx
 33f:	48 89 4d f8          	mov    %rcx,-0x8(%rbp)
 343:	0f b6 12             	movzbl (%rdx),%edx
 346:	88 10                	mov    %dl,(%rax)
  while(n-- > 0)
 348:	8b 45 dc             	mov    -0x24(%rbp),%eax
 34b:	8d 50 ff             	lea    -0x1(%rax),%edx
 34e:	89 55 dc             	mov    %edx,-0x24(%rbp)
 351:	85 c0                	test   %eax,%eax
 353:	7f d6                	jg     32b <memmove+0x25>
  return vdst;
 355:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
 359:	c9                   	leave
 35a:	c3                   	ret

000000000000035b <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 35b:	b8 01 00 00 00       	mov    $0x1,%eax
 360:	cd 40                	int    $0x40
 362:	c3                   	ret

0000000000000363 <exit>:
SYSCALL(exit)
 363:	b8 02 00 00 00       	mov    $0x2,%eax
 368:	cd 40                	int    $0x40
 36a:	c3                   	ret

000000000000036b <wait>:
SYSCALL(wait)
 36b:	b8 03 00 00 00       	mov    $0x3,%eax
 370:	cd 40                	int    $0x40
 372:	c3                   	ret

0000000000000373 <pipe>:
SYSCALL(pipe)
 373:	b8 04 00 00 00       	mov    $0x4,%eax
 378:	cd 40                	int    $0x40
 37a:	c3                   	ret

000000000000037b <read>:
SYSCALL(read)
 37b:	b8 05 00 00 00       	mov    $0x5,%eax
 380:	cd 40                	int    $0x40
 382:	c3                   	ret

0000000000000383 <write>:
SYSCALL(write)
 383:	b8 10 00 00 00       	mov    $0x10,%eax
 388:	cd 40                	int    $0x40
 38a:	c3                   	ret

000000000000038b <close>:
SYSCALL(close)
 38b:	b8 15 00 00 00       	mov    $0x15,%eax
 390:	cd 40                	int    $0x40
 392:	c3                   	ret

0000000000000393 <kill>:
SYSCALL(kill)
 393:	b8 06 00 00 00       	mov    $0x6,%eax
 398:	cd 40                	int    $0x40
 39a:	c3                   	ret

000000000000039b <exec>:
SYSCALL(exec)
 39b:	b8 07 00 00 00       	mov    $0x7,%eax
 3a0:	cd 40                	int    $0x40
 3a2:	c3                   	ret

00000000000003a3 <open>:
SYSCALL(open)
 3a3:	b8 0f 00 00 00       	mov    $0xf,%eax
 3a8:	cd 40                	int    $0x40
 3aa:	c3                   	ret

00000000000003ab <mknod>:
SYSCALL(mknod)
 3ab:	b8 11 00 00 00       	mov    $0x11,%eax
 3b0:	cd 40                	int    $0x40
 3b2:	c3                   	ret

00000000000003b3 <unlink>:
SYSCALL(unlink)
 3b3:	b8 12 00 00 00       	mov    $0x12,%eax
 3b8:	cd 40                	int    $0x40
 3ba:	c3                   	ret

00000000000003bb <fstat>:
SYSCALL(fstat)
 3bb:	b8 08 00 00 00       	mov    $0x8,%eax
 3c0:	cd 40                	int    $0x40
 3c2:	c3                   	ret

00000000000003c3 <link>:
SYSCALL(link)
 3c3:	b8 13 00 00 00       	mov    $0x13,%eax
 3c8:	cd 40                	int    $0x40
 3ca:	c3                   	ret

00000000000003cb <mkdir>:
SYSCALL(mkdir)
 3cb:	b8 14 00 00 00       	mov    $0x14,%eax
 3d0:	cd 40                	int    $0x40
 3d2:	c3                   	ret

00000000000003d3 <chdir>:
SYSCALL(chdir)
 3d3:	b8 09 00 00 00       	mov    $0x9,%eax
 3d8:	cd 40                	int    $0x40
 3da:	c3                   	ret

00000000000003db <dup>:
SYSCALL(dup)
 3db:	b8 0a 00 00 00       	mov    $0xa,%eax
 3e0:	cd 40                	int    $0x40
 3e2:	c3                   	ret

00000000000003e3 <getpid>:
SYSCALL(getpid)
 3e3:	b8 0b 00 00 00       	mov    $0xb,%eax
 3e8:	cd 40                	int    $0x40
 3ea:	c3                   	ret

00000000000003eb <sbrk>:
SYSCALL(sbrk)
 3eb:	b8 0c 00 00 00       	mov    $0xc,%eax
 3f0:	cd 40                	int    $0x40
 3f2:	c3                   	ret

00000000000003f3 <sleep>:
SYSCALL(sleep)
 3f3:	b8 0d 00 00 00       	mov    $0xd,%eax
 3f8:	cd 40                	int    $0x40
 3fa:	c3                   	ret

00000000000003fb <uptime>:
SYSCALL(uptime)
 3fb:	b8 0e 00 00 00       	mov    $0xe,%eax
 400:	cd 40                	int    $0x40
 402:	c3                   	ret

0000000000000403 <getpinfo>:
SYSCALL(getpinfo)
 403:	b8 18 00 00 00       	mov    $0x18,%eax
 408:	cd 40                	int    $0x40
 40a:	c3                   	ret

000000000000040b <getfavnum>:
SYSCALL(getfavnum)
 40b:	b8 19 00 00 00       	mov    $0x19,%eax
 410:	cd 40                	int    $0x40
 412:	c3                   	ret

0000000000000413 <shutdown>:
SYSCALL(shutdown)
 413:	b8 1a 00 00 00       	mov    $0x1a,%eax
 418:	cd 40                	int    $0x40
 41a:	c3                   	ret

000000000000041b <getcount>:
SYSCALL(getcount)
 41b:	b8 1b 00 00 00       	mov    $0x1b,%eax
 420:	cd 40                	int    $0x40
 422:	c3                   	ret

0000000000000423 <killrandom>:
 423:	b8 1c 00 00 00       	mov    $0x1c,%eax
 428:	cd 40                	int    $0x40
 42a:	c3                   	ret

000000000000042b <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 42b:	55                   	push   %rbp
 42c:	48 89 e5             	mov    %rsp,%rbp
 42f:	48 83 ec 10          	sub    $0x10,%rsp
 433:	89 7d fc             	mov    %edi,-0x4(%rbp)
 436:	89 f0                	mov    %esi,%eax
 438:	88 45 f8             	mov    %al,-0x8(%rbp)
  write(fd, &c, 1);
 43b:	48 8d 4d f8          	lea    -0x8(%rbp),%rcx
 43f:	8b 45 fc             	mov    -0x4(%rbp),%eax
 442:	ba 01 00 00 00       	mov    $0x1,%edx
 447:	48 89 ce             	mov    %rcx,%rsi
 44a:	89 c7                	mov    %eax,%edi
 44c:	e8 32 ff ff ff       	call   383 <write>
}
 451:	90                   	nop
 452:	c9                   	leave
 453:	c3                   	ret

0000000000000454 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 454:	55                   	push   %rbp
 455:	48 89 e5             	mov    %rsp,%rbp
 458:	48 83 ec 30          	sub    $0x30,%rsp
 45c:	89 7d dc             	mov    %edi,-0x24(%rbp)
 45f:	89 75 d8             	mov    %esi,-0x28(%rbp)
 462:	89 55 d4             	mov    %edx,-0x2c(%rbp)
 465:	89 4d d0             	mov    %ecx,-0x30(%rbp)
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 468:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
  if(sgn && xx < 0){
 46f:	83 7d d0 00          	cmpl   $0x0,-0x30(%rbp)
 473:	74 17                	je     48c <printint+0x38>
 475:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
 479:	79 11                	jns    48c <printint+0x38>
    neg = 1;
 47b:	c7 45 f8 01 00 00 00 	movl   $0x1,-0x8(%rbp)
    x = -xx;
 482:	8b 45 d8             	mov    -0x28(%rbp),%eax
 485:	f7 d8                	neg    %eax
 487:	89 45 f4             	mov    %eax,-0xc(%rbp)
 48a:	eb 06                	jmp    492 <printint+0x3e>
  } else {
    x = xx;
 48c:	8b 45 d8             	mov    -0x28(%rbp),%eax
 48f:	89 45 f4             	mov    %eax,-0xc(%rbp)
  }

  i = 0;
 492:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  do{
    buf[i++] = digits[x % base];
 499:	8b 4d d4             	mov    -0x2c(%rbp),%ecx
 49c:	8b 45 f4             	mov    -0xc(%rbp),%eax
 49f:	ba 00 00 00 00       	mov    $0x0,%edx
 4a4:	f7 f1                	div    %ecx
 4a6:	89 d1                	mov    %edx,%ecx
 4a8:	8b 45 fc             	mov    -0x4(%rbp),%eax
 4ab:	8d 50 01             	lea    0x1(%rax),%edx
 4ae:	89 55 fc             	mov    %edx,-0x4(%rbp)
 4b1:	89 ca                	mov    %ecx,%edx
 4b3:	0f b6 92 00 10 00 00 	movzbl 0x1000(%rdx),%edx
 4ba:	48 98                	cltq
 4bc:	88 54 05 e0          	mov    %dl,-0x20(%rbp,%rax,1)
  }while((x /= base) != 0);
 4c0:	8b 75 d4             	mov    -0x2c(%rbp),%esi
 4c3:	8b 45 f4             	mov    -0xc(%rbp),%eax
 4c6:	ba 00 00 00 00       	mov    $0x0,%edx
 4cb:	f7 f6                	div    %esi
 4cd:	89 45 f4             	mov    %eax,-0xc(%rbp)
 4d0:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
 4d4:	75 c3                	jne    499 <printint+0x45>
  if(neg)
 4d6:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
 4da:	74 2b                	je     507 <printint+0xb3>
    buf[i++] = '-';
 4dc:	8b 45 fc             	mov    -0x4(%rbp),%eax
 4df:	8d 50 01             	lea    0x1(%rax),%edx
 4e2:	89 55 fc             	mov    %edx,-0x4(%rbp)
 4e5:	48 98                	cltq
 4e7:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%rbp,%rax,1)

  while(--i >= 0)
 4ec:	eb 19                	jmp    507 <printint+0xb3>
    putc(fd, buf[i]);
 4ee:	8b 45 fc             	mov    -0x4(%rbp),%eax
 4f1:	48 98                	cltq
 4f3:	0f b6 44 05 e0       	movzbl -0x20(%rbp,%rax,1),%eax
 4f8:	0f be d0             	movsbl %al,%edx
 4fb:	8b 45 dc             	mov    -0x24(%rbp),%eax
 4fe:	89 d6                	mov    %edx,%esi
 500:	89 c7                	mov    %eax,%edi
 502:	e8 24 ff ff ff       	call   42b <putc>
  while(--i >= 0)
 507:	83 6d fc 01          	subl   $0x1,-0x4(%rbp)
 50b:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
 50f:	79 dd                	jns    4ee <printint+0x9a>
}
 511:	90                   	nop
 512:	90                   	nop
 513:	c9                   	leave
 514:	c3                   	ret

0000000000000515 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 515:	55                   	push   %rbp
 516:	48 89 e5             	mov    %rsp,%rbp
 519:	48 81 ec f0 00 00 00 	sub    $0xf0,%rsp
 520:	89 bd 1c ff ff ff    	mov    %edi,-0xe4(%rbp)
 526:	48 89 b5 10 ff ff ff 	mov    %rsi,-0xf0(%rbp)
 52d:	48 89 95 60 ff ff ff 	mov    %rdx,-0xa0(%rbp)
 534:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
 53b:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
 542:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
 549:	84 c0                	test   %al,%al
 54b:	74 20                	je     56d <printf+0x58>
 54d:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
 551:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
 555:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
 559:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
 55d:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
 561:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
 565:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
 569:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  va_list ap;
  char *s;
  int c, i, state;
  va_start(ap, fmt);
 56d:	c7 85 20 ff ff ff 10 	movl   $0x10,-0xe0(%rbp)
 574:	00 00 00 
 577:	c7 85 24 ff ff ff 30 	movl   $0x30,-0xdc(%rbp)
 57e:	00 00 00 
 581:	48 8d 45 10          	lea    0x10(%rbp),%rax
 585:	48 89 85 28 ff ff ff 	mov    %rax,-0xd8(%rbp)
 58c:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
 593:	48 89 85 30 ff ff ff 	mov    %rax,-0xd0(%rbp)

  state = 0;
 59a:	c7 85 40 ff ff ff 00 	movl   $0x0,-0xc0(%rbp)
 5a1:	00 00 00 
  for(i = 0; fmt[i]; i++){
 5a4:	c7 85 44 ff ff ff 00 	movl   $0x0,-0xbc(%rbp)
 5ab:	00 00 00 
 5ae:	e9 a8 02 00 00       	jmp    85b <printf+0x346>
    c = fmt[i] & 0xff;
 5b3:	8b 85 44 ff ff ff    	mov    -0xbc(%rbp),%eax
 5b9:	48 63 d0             	movslq %eax,%rdx
 5bc:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
 5c3:	48 01 d0             	add    %rdx,%rax
 5c6:	0f b6 00             	movzbl (%rax),%eax
 5c9:	0f be c0             	movsbl %al,%eax
 5cc:	25 ff 00 00 00       	and    $0xff,%eax
 5d1:	89 85 3c ff ff ff    	mov    %eax,-0xc4(%rbp)
    if(state == 0){
 5d7:	83 bd 40 ff ff ff 00 	cmpl   $0x0,-0xc0(%rbp)
 5de:	75 35                	jne    615 <printf+0x100>
      if(c == '%'){
 5e0:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
 5e7:	75 0f                	jne    5f8 <printf+0xe3>
        state = '%';
 5e9:	c7 85 40 ff ff ff 25 	movl   $0x25,-0xc0(%rbp)
 5f0:	00 00 00 
 5f3:	e9 5c 02 00 00       	jmp    854 <printf+0x33f>
      } else {
        putc(fd, c);
 5f8:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
 5fe:	0f be d0             	movsbl %al,%edx
 601:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 607:	89 d6                	mov    %edx,%esi
 609:	89 c7                	mov    %eax,%edi
 60b:	e8 1b fe ff ff       	call   42b <putc>
 610:	e9 3f 02 00 00       	jmp    854 <printf+0x33f>
      }
    } else if(state == '%'){
 615:	83 bd 40 ff ff ff 25 	cmpl   $0x25,-0xc0(%rbp)
 61c:	0f 85 32 02 00 00    	jne    854 <printf+0x33f>
      if(c == 'd'){
 622:	83 bd 3c ff ff ff 64 	cmpl   $0x64,-0xc4(%rbp)
 629:	75 5e                	jne    689 <printf+0x174>
        printint(fd, va_arg(ap, int), 10, 1);
 62b:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 631:	83 f8 2f             	cmp    $0x2f,%eax
 634:	77 23                	ja     659 <printf+0x144>
 636:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 63d:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 643:	89 d2                	mov    %edx,%edx
 645:	48 01 d0             	add    %rdx,%rax
 648:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 64e:	83 c2 08             	add    $0x8,%edx
 651:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 657:	eb 12                	jmp    66b <printf+0x156>
 659:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 660:	48 8d 50 08          	lea    0x8(%rax),%rdx
 664:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 66b:	8b 30                	mov    (%rax),%esi
 66d:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 673:	b9 01 00 00 00       	mov    $0x1,%ecx
 678:	ba 0a 00 00 00       	mov    $0xa,%edx
 67d:	89 c7                	mov    %eax,%edi
 67f:	e8 d0 fd ff ff       	call   454 <printint>
 684:	e9 c1 01 00 00       	jmp    84a <printf+0x335>
      } else if(c == 'x' || c == 'p'){
 689:	83 bd 3c ff ff ff 78 	cmpl   $0x78,-0xc4(%rbp)
 690:	74 09                	je     69b <printf+0x186>
 692:	83 bd 3c ff ff ff 70 	cmpl   $0x70,-0xc4(%rbp)
 699:	75 5e                	jne    6f9 <printf+0x1e4>
        printint(fd, va_arg(ap, int), 16, 0);
 69b:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 6a1:	83 f8 2f             	cmp    $0x2f,%eax
 6a4:	77 23                	ja     6c9 <printf+0x1b4>
 6a6:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 6ad:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 6b3:	89 d2                	mov    %edx,%edx
 6b5:	48 01 d0             	add    %rdx,%rax
 6b8:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 6be:	83 c2 08             	add    $0x8,%edx
 6c1:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 6c7:	eb 12                	jmp    6db <printf+0x1c6>
 6c9:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 6d0:	48 8d 50 08          	lea    0x8(%rax),%rdx
 6d4:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 6db:	8b 30                	mov    (%rax),%esi
 6dd:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 6e3:	b9 00 00 00 00       	mov    $0x0,%ecx
 6e8:	ba 10 00 00 00       	mov    $0x10,%edx
 6ed:	89 c7                	mov    %eax,%edi
 6ef:	e8 60 fd ff ff       	call   454 <printint>
 6f4:	e9 51 01 00 00       	jmp    84a <printf+0x335>
      } else if(c == 's'){
 6f9:	83 bd 3c ff ff ff 73 	cmpl   $0x73,-0xc4(%rbp)
 700:	0f 85 98 00 00 00    	jne    79e <printf+0x289>
        s = va_arg(ap, char*);
 706:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 70c:	83 f8 2f             	cmp    $0x2f,%eax
 70f:	77 23                	ja     734 <printf+0x21f>
 711:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 718:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 71e:	89 d2                	mov    %edx,%edx
 720:	48 01 d0             	add    %rdx,%rax
 723:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 729:	83 c2 08             	add    $0x8,%edx
 72c:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 732:	eb 12                	jmp    746 <printf+0x231>
 734:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 73b:	48 8d 50 08          	lea    0x8(%rax),%rdx
 73f:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 746:	48 8b 00             	mov    (%rax),%rax
 749:	48 89 85 48 ff ff ff 	mov    %rax,-0xb8(%rbp)
        if(s == 0)
 750:	48 83 bd 48 ff ff ff 	cmpq   $0x0,-0xb8(%rbp)
 757:	00 
 758:	75 31                	jne    78b <printf+0x276>
          s = "(null)";
 75a:	48 c7 85 48 ff ff ff 	movq   $0xd1b,-0xb8(%rbp)
 761:	1b 0d 00 00 
        while(*s != 0){
 765:	eb 24                	jmp    78b <printf+0x276>
          putc(fd, *s);
 767:	48 8b 85 48 ff ff ff 	mov    -0xb8(%rbp),%rax
 76e:	0f b6 00             	movzbl (%rax),%eax
 771:	0f be d0             	movsbl %al,%edx
 774:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 77a:	89 d6                	mov    %edx,%esi
 77c:	89 c7                	mov    %eax,%edi
 77e:	e8 a8 fc ff ff       	call   42b <putc>
          s++;
 783:	48 83 85 48 ff ff ff 	addq   $0x1,-0xb8(%rbp)
 78a:	01 
        while(*s != 0){
 78b:	48 8b 85 48 ff ff ff 	mov    -0xb8(%rbp),%rax
 792:	0f b6 00             	movzbl (%rax),%eax
 795:	84 c0                	test   %al,%al
 797:	75 ce                	jne    767 <printf+0x252>
 799:	e9 ac 00 00 00       	jmp    84a <printf+0x335>
        }
      } else if(c == 'c'){
 79e:	83 bd 3c ff ff ff 63 	cmpl   $0x63,-0xc4(%rbp)
 7a5:	75 56                	jne    7fd <printf+0x2e8>
        putc(fd, va_arg(ap, uint));
 7a7:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 7ad:	83 f8 2f             	cmp    $0x2f,%eax
 7b0:	77 23                	ja     7d5 <printf+0x2c0>
 7b2:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 7b9:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 7bf:	89 d2                	mov    %edx,%edx
 7c1:	48 01 d0             	add    %rdx,%rax
 7c4:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 7ca:	83 c2 08             	add    $0x8,%edx
 7cd:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 7d3:	eb 12                	jmp    7e7 <printf+0x2d2>
 7d5:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 7dc:	48 8d 50 08          	lea    0x8(%rax),%rdx
 7e0:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 7e7:	8b 00                	mov    (%rax),%eax
 7e9:	0f be d0             	movsbl %al,%edx
 7ec:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 7f2:	89 d6                	mov    %edx,%esi
 7f4:	89 c7                	mov    %eax,%edi
 7f6:	e8 30 fc ff ff       	call   42b <putc>
 7fb:	eb 4d                	jmp    84a <printf+0x335>
      } else if(c == '%'){
 7fd:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
 804:	75 1a                	jne    820 <printf+0x30b>
        putc(fd, c);
 806:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
 80c:	0f be d0             	movsbl %al,%edx
 80f:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 815:	89 d6                	mov    %edx,%esi
 817:	89 c7                	mov    %eax,%edi
 819:	e8 0d fc ff ff       	call   42b <putc>
 81e:	eb 2a                	jmp    84a <printf+0x335>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 820:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 826:	be 25 00 00 00       	mov    $0x25,%esi
 82b:	89 c7                	mov    %eax,%edi
 82d:	e8 f9 fb ff ff       	call   42b <putc>
        putc(fd, c);
 832:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
 838:	0f be d0             	movsbl %al,%edx
 83b:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 841:	89 d6                	mov    %edx,%esi
 843:	89 c7                	mov    %eax,%edi
 845:	e8 e1 fb ff ff       	call   42b <putc>
      }
      state = 0;
 84a:	c7 85 40 ff ff ff 00 	movl   $0x0,-0xc0(%rbp)
 851:	00 00 00 
  for(i = 0; fmt[i]; i++){
 854:	83 85 44 ff ff ff 01 	addl   $0x1,-0xbc(%rbp)
 85b:	8b 85 44 ff ff ff    	mov    -0xbc(%rbp),%eax
 861:	48 63 d0             	movslq %eax,%rdx
 864:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
 86b:	48 01 d0             	add    %rdx,%rax
 86e:	0f b6 00             	movzbl (%rax),%eax
 871:	84 c0                	test   %al,%al
 873:	0f 85 3a fd ff ff    	jne    5b3 <printf+0x9e>
    }
  }
}
 879:	90                   	nop
 87a:	90                   	nop
 87b:	c9                   	leave
 87c:	c3                   	ret

000000000000087d <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 87d:	55                   	push   %rbp
 87e:	48 89 e5             	mov    %rsp,%rbp
 881:	48 83 ec 18          	sub    $0x18,%rsp
 885:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  Header *bp, *p;

  bp = (Header*)ap - 1;
 889:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 88d:	48 83 e8 10          	sub    $0x10,%rax
 891:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 895:	48 8b 05 94 07 00 00 	mov    0x794(%rip),%rax        # 1030 <freep>
 89c:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 8a0:	eb 2f                	jmp    8d1 <free+0x54>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8a2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 8a6:	48 8b 00             	mov    (%rax),%rax
 8a9:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 8ad:	72 17                	jb     8c6 <free+0x49>
 8af:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 8b3:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 8b7:	72 2f                	jb     8e8 <free+0x6b>
 8b9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 8bd:	48 8b 00             	mov    (%rax),%rax
 8c0:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
 8c4:	72 22                	jb     8e8 <free+0x6b>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8c6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 8ca:	48 8b 00             	mov    (%rax),%rax
 8cd:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 8d1:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 8d5:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 8d9:	73 c7                	jae    8a2 <free+0x25>
 8db:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 8df:	48 8b 00             	mov    (%rax),%rax
 8e2:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
 8e6:	73 ba                	jae    8a2 <free+0x25>
      break;
  if(bp + bp->s.size == p->s.ptr){
 8e8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 8ec:	8b 40 08             	mov    0x8(%rax),%eax
 8ef:	89 c0                	mov    %eax,%eax
 8f1:	48 c1 e0 04          	shl    $0x4,%rax
 8f5:	48 89 c2             	mov    %rax,%rdx
 8f8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 8fc:	48 01 c2             	add    %rax,%rdx
 8ff:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 903:	48 8b 00             	mov    (%rax),%rax
 906:	48 39 c2             	cmp    %rax,%rdx
 909:	75 2d                	jne    938 <free+0xbb>
    bp->s.size += p->s.ptr->s.size;
 90b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 90f:	8b 50 08             	mov    0x8(%rax),%edx
 912:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 916:	48 8b 00             	mov    (%rax),%rax
 919:	8b 40 08             	mov    0x8(%rax),%eax
 91c:	01 c2                	add    %eax,%edx
 91e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 922:	89 50 08             	mov    %edx,0x8(%rax)
    bp->s.ptr = p->s.ptr->s.ptr;
 925:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 929:	48 8b 00             	mov    (%rax),%rax
 92c:	48 8b 10             	mov    (%rax),%rdx
 92f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 933:	48 89 10             	mov    %rdx,(%rax)
 936:	eb 0e                	jmp    946 <free+0xc9>
  } else
    bp->s.ptr = p->s.ptr;
 938:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 93c:	48 8b 10             	mov    (%rax),%rdx
 93f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 943:	48 89 10             	mov    %rdx,(%rax)
  if(p + p->s.size == bp){
 946:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 94a:	8b 40 08             	mov    0x8(%rax),%eax
 94d:	89 c0                	mov    %eax,%eax
 94f:	48 c1 e0 04          	shl    $0x4,%rax
 953:	48 89 c2             	mov    %rax,%rdx
 956:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 95a:	48 01 d0             	add    %rdx,%rax
 95d:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
 961:	75 27                	jne    98a <free+0x10d>
    p->s.size += bp->s.size;
 963:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 967:	8b 50 08             	mov    0x8(%rax),%edx
 96a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 96e:	8b 40 08             	mov    0x8(%rax),%eax
 971:	01 c2                	add    %eax,%edx
 973:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 977:	89 50 08             	mov    %edx,0x8(%rax)
    p->s.ptr = bp->s.ptr;
 97a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 97e:	48 8b 10             	mov    (%rax),%rdx
 981:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 985:	48 89 10             	mov    %rdx,(%rax)
 988:	eb 0b                	jmp    995 <free+0x118>
  } else
    p->s.ptr = bp;
 98a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 98e:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
 992:	48 89 10             	mov    %rdx,(%rax)
  freep = p;
 995:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 999:	48 89 05 90 06 00 00 	mov    %rax,0x690(%rip)        # 1030 <freep>
}
 9a0:	90                   	nop
 9a1:	c9                   	leave
 9a2:	c3                   	ret

00000000000009a3 <morecore>:

static Header*
morecore(uint nu)
{
 9a3:	55                   	push   %rbp
 9a4:	48 89 e5             	mov    %rsp,%rbp
 9a7:	48 83 ec 20          	sub    $0x20,%rsp
 9ab:	89 7d ec             	mov    %edi,-0x14(%rbp)
  char *p;
  Header *hp;

  if(nu < 4096)
 9ae:	81 7d ec ff 0f 00 00 	cmpl   $0xfff,-0x14(%rbp)
 9b5:	77 07                	ja     9be <morecore+0x1b>
    nu = 4096;
 9b7:	c7 45 ec 00 10 00 00 	movl   $0x1000,-0x14(%rbp)
  p = sbrk(nu * sizeof(Header));
 9be:	8b 45 ec             	mov    -0x14(%rbp),%eax
 9c1:	c1 e0 04             	shl    $0x4,%eax
 9c4:	89 c7                	mov    %eax,%edi
 9c6:	e8 20 fa ff ff       	call   3eb <sbrk>
 9cb:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  if(p == (char*)-1)
 9cf:	48 83 7d f8 ff       	cmpq   $0xffffffffffffffff,-0x8(%rbp)
 9d4:	75 07                	jne    9dd <morecore+0x3a>
    return 0;
 9d6:	b8 00 00 00 00       	mov    $0x0,%eax
 9db:	eb 29                	jmp    a06 <morecore+0x63>
  hp = (Header*)p;
 9dd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 9e1:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  hp->s.size = nu;
 9e5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 9e9:	8b 55 ec             	mov    -0x14(%rbp),%edx
 9ec:	89 50 08             	mov    %edx,0x8(%rax)
  free((void*)(hp + 1));
 9ef:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 9f3:	48 83 c0 10          	add    $0x10,%rax
 9f7:	48 89 c7             	mov    %rax,%rdi
 9fa:	e8 7e fe ff ff       	call   87d <free>
  return freep;
 9ff:	48 8b 05 2a 06 00 00 	mov    0x62a(%rip),%rax        # 1030 <freep>
}
 a06:	c9                   	leave
 a07:	c3                   	ret

0000000000000a08 <malloc>:

void*
malloc(uint nbytes)
{
 a08:	55                   	push   %rbp
 a09:	48 89 e5             	mov    %rsp,%rbp
 a0c:	48 83 ec 30          	sub    $0x30,%rsp
 a10:	89 7d dc             	mov    %edi,-0x24(%rbp)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 a13:	8b 45 dc             	mov    -0x24(%rbp),%eax
 a16:	48 83 c0 0f          	add    $0xf,%rax
 a1a:	48 c1 e8 04          	shr    $0x4,%rax
 a1e:	83 c0 01             	add    $0x1,%eax
 a21:	89 45 ec             	mov    %eax,-0x14(%rbp)
  if((prevp = freep) == 0){
 a24:	48 8b 05 05 06 00 00 	mov    0x605(%rip),%rax        # 1030 <freep>
 a2b:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
 a2f:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
 a34:	75 2b                	jne    a61 <malloc+0x59>
    base.s.ptr = freep = prevp = &base;
 a36:	48 c7 45 f0 20 10 00 	movq   $0x1020,-0x10(%rbp)
 a3d:	00 
 a3e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 a42:	48 89 05 e7 05 00 00 	mov    %rax,0x5e7(%rip)        # 1030 <freep>
 a49:	48 8b 05 e0 05 00 00 	mov    0x5e0(%rip),%rax        # 1030 <freep>
 a50:	48 89 05 c9 05 00 00 	mov    %rax,0x5c9(%rip)        # 1020 <base>
    base.s.size = 0;
 a57:	c7 05 c7 05 00 00 00 	movl   $0x0,0x5c7(%rip)        # 1028 <base+0x8>
 a5e:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a61:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 a65:	48 8b 00             	mov    (%rax),%rax
 a68:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
 a6c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a70:	8b 40 08             	mov    0x8(%rax),%eax
 a73:	3b 45 ec             	cmp    -0x14(%rbp),%eax
 a76:	72 5f                	jb     ad7 <malloc+0xcf>
      if(p->s.size == nunits)
 a78:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a7c:	8b 40 08             	mov    0x8(%rax),%eax
 a7f:	39 45 ec             	cmp    %eax,-0x14(%rbp)
 a82:	75 10                	jne    a94 <malloc+0x8c>
        prevp->s.ptr = p->s.ptr;
 a84:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a88:	48 8b 10             	mov    (%rax),%rdx
 a8b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 a8f:	48 89 10             	mov    %rdx,(%rax)
 a92:	eb 2e                	jmp    ac2 <malloc+0xba>
      else {
        p->s.size -= nunits;
 a94:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a98:	8b 40 08             	mov    0x8(%rax),%eax
 a9b:	2b 45 ec             	sub    -0x14(%rbp),%eax
 a9e:	89 c2                	mov    %eax,%edx
 aa0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 aa4:	89 50 08             	mov    %edx,0x8(%rax)
        p += p->s.size;
 aa7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 aab:	8b 40 08             	mov    0x8(%rax),%eax
 aae:	89 c0                	mov    %eax,%eax
 ab0:	48 c1 e0 04          	shl    $0x4,%rax
 ab4:	48 01 45 f8          	add    %rax,-0x8(%rbp)
        p->s.size = nunits;
 ab8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 abc:	8b 55 ec             	mov    -0x14(%rbp),%edx
 abf:	89 50 08             	mov    %edx,0x8(%rax)
      }
      freep = prevp;
 ac2:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 ac6:	48 89 05 63 05 00 00 	mov    %rax,0x563(%rip)        # 1030 <freep>
      return (void*)(p + 1);
 acd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 ad1:	48 83 c0 10          	add    $0x10,%rax
 ad5:	eb 41                	jmp    b18 <malloc+0x110>
    }
    if(p == freep)
 ad7:	48 8b 05 52 05 00 00 	mov    0x552(%rip),%rax        # 1030 <freep>
 ade:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 ae2:	75 1c                	jne    b00 <malloc+0xf8>
      if((p = morecore(nunits)) == 0)
 ae4:	8b 45 ec             	mov    -0x14(%rbp),%eax
 ae7:	89 c7                	mov    %eax,%edi
 ae9:	e8 b5 fe ff ff       	call   9a3 <morecore>
 aee:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 af2:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
 af7:	75 07                	jne    b00 <malloc+0xf8>
        return 0;
 af9:	b8 00 00 00 00       	mov    $0x0,%eax
 afe:	eb 18                	jmp    b18 <malloc+0x110>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 b00:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b04:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
 b08:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b0c:	48 8b 00             	mov    (%rax),%rax
 b0f:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
 b13:	e9 54 ff ff ff       	jmp    a6c <malloc+0x64>
  }
}
 b18:	c9                   	leave
 b19:	c3                   	ret

0000000000000b1a <createRoot>:
#include "set.h"
#include "user.h"

//TODO: Να μην είναι περιορισμένο σε int

Set* createRoot(){
 b1a:	55                   	push   %rbp
 b1b:	48 89 e5             	mov    %rsp,%rbp
 b1e:	48 83 ec 10          	sub    $0x10,%rsp
    //Αρχικοποίηση του Set
    Set *set = malloc(sizeof(Set));
 b22:	bf 10 00 00 00       	mov    $0x10,%edi
 b27:	e8 dc fe ff ff       	call   a08 <malloc>
 b2c:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    set->size = 0;
 b30:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b34:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%rax)
    set->root = NULL;
 b3b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b3f:	48 c7 00 00 00 00 00 	movq   $0x0,(%rax)
    return set;
 b46:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
 b4a:	c9                   	leave
 b4b:	c3                   	ret

0000000000000b4c <createNode>:

void createNode(int i, Set *set){
 b4c:	55                   	push   %rbp
 b4d:	48 89 e5             	mov    %rsp,%rbp
 b50:	48 83 ec 20          	sub    $0x20,%rsp
 b54:	89 7d ec             	mov    %edi,-0x14(%rbp)
 b57:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    Η συνάρτηση αυτή δημιουργεί ένα νέο SetNode με την τιμή i και εφόσον δεν υπάρχει στο Set το προσθέτει στο τέλος του συνόλου.
    Σημείωση: Ίσως υπάρχει καλύτερος τρόπος για την υλοποίηση.
    */

    //Αρχικοποίηση του SetNode
    SetNode *temp = malloc(sizeof(SetNode));
 b5b:	bf 10 00 00 00       	mov    $0x10,%edi
 b60:	e8 a3 fe ff ff       	call   a08 <malloc>
 b65:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    temp->i = i;
 b69:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 b6d:	8b 55 ec             	mov    -0x14(%rbp),%edx
 b70:	89 10                	mov    %edx,(%rax)
    temp->next = NULL;
 b72:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 b76:	48 c7 40 08 00 00 00 	movq   $0x0,0x8(%rax)
 b7d:	00 

    //Έλεγχος ύπαρξης του i
    SetNode *curr = set->root;//Ξεκινάει από την root
 b7e:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
 b82:	48 8b 00             	mov    (%rax),%rax
 b85:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(curr != NULL) { //Εφόσον το Set δεν είναι άδειο
 b89:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
 b8e:	74 34                	je     bc4 <createNode+0x78>
        while (curr->next != NULL){ //Εφόσον υπάρχει επόμενο node
 b90:	eb 25                	jmp    bb7 <createNode+0x6b>
            if (curr->i == i){ //Αν το i υπάρχει στο σύνολο
 b92:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b96:	8b 00                	mov    (%rax),%eax
 b98:	39 45 ec             	cmp    %eax,-0x14(%rbp)
 b9b:	75 0e                	jne    bab <createNode+0x5f>
                free(temp); 
 b9d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 ba1:	48 89 c7             	mov    %rax,%rdi
 ba4:	e8 d4 fc ff ff       	call   87d <free>
                return; //Δεν εκτελούμε την υπόλοιπη συνάρτηση
 ba9:	eb 4e                	jmp    bf9 <createNode+0xad>
            }
            curr = curr->next; //Επόμενο SetNode
 bab:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 baf:	48 8b 40 08          	mov    0x8(%rax),%rax
 bb3:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
        while (curr->next != NULL){ //Εφόσον υπάρχει επόμενο node
 bb7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 bbb:	48 8b 40 08          	mov    0x8(%rax),%rax
 bbf:	48 85 c0             	test   %rax,%rax
 bc2:	75 ce                	jne    b92 <createNode+0x46>
        }
    }
    /*
    Ο έλεγχος στην if είναι απαραίτητος για να ελεγχθεί το τελευταίο SetNode.
    */
    if (curr->i != i) attachNode(set, curr, temp); 
 bc4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 bc8:	8b 00                	mov    (%rax),%eax
 bca:	39 45 ec             	cmp    %eax,-0x14(%rbp)
 bcd:	74 1e                	je     bed <createNode+0xa1>
 bcf:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
 bd3:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
 bd7:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
 bdb:	48 89 ce             	mov    %rcx,%rsi
 bde:	48 89 c7             	mov    %rax,%rdi
 be1:	b8 00 00 00 00       	mov    $0x0,%eax
 be6:	e8 10 00 00 00       	call   bfb <attachNode>
 beb:	eb 0c                	jmp    bf9 <createNode+0xad>
    else free(temp);
 bed:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 bf1:	48 89 c7             	mov    %rax,%rdi
 bf4:	e8 84 fc ff ff       	call   87d <free>
}
 bf9:	c9                   	leave
 bfa:	c3                   	ret

0000000000000bfb <attachNode>:

void attachNode(Set *set, SetNode *curr, SetNode *temp){
 bfb:	55                   	push   %rbp
 bfc:	48 89 e5             	mov    %rsp,%rbp
 bff:	48 83 ec 18          	sub    $0x18,%rsp
 c03:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
 c07:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
 c0b:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
    //Βάζουμε το temp στο τέλος του Set
    if(set->size == 0) set->root = temp;
 c0f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 c13:	8b 40 08             	mov    0x8(%rax),%eax
 c16:	85 c0                	test   %eax,%eax
 c18:	75 0d                	jne    c27 <attachNode+0x2c>
 c1a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 c1e:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
 c22:	48 89 10             	mov    %rdx,(%rax)
 c25:	eb 0c                	jmp    c33 <attachNode+0x38>
    else curr->next = temp;
 c27:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 c2b:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
 c2f:	48 89 50 08          	mov    %rdx,0x8(%rax)
    set->size += 1;
 c33:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 c37:	8b 40 08             	mov    0x8(%rax),%eax
 c3a:	8d 50 01             	lea    0x1(%rax),%edx
 c3d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 c41:	89 50 08             	mov    %edx,0x8(%rax)
}
 c44:	90                   	nop
 c45:	c9                   	leave
 c46:	c3                   	ret

0000000000000c47 <deleteSet>:

void deleteSet(Set *set){
 c47:	55                   	push   %rbp
 c48:	48 89 e5             	mov    %rsp,%rbp
 c4b:	48 83 ec 20          	sub    $0x20,%rsp
 c4f:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    if (set == NULL) return; //Αν ο χρήστης είναι ΜΛΚ!
 c53:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
 c58:	74 42                	je     c9c <deleteSet+0x55>
    SetNode *temp;
    SetNode *curr = set->root; //Ξεκινάμε από το root
 c5a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 c5e:	48 8b 00             	mov    (%rax),%rax
 c61:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    while (curr != NULL){ 
 c65:	eb 20                	jmp    c87 <deleteSet+0x40>
        temp = curr->next; //Αναφορά στο επόμενο SetNode
 c67:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 c6b:	48 8b 40 08          	mov    0x8(%rax),%rax
 c6f:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
        free(curr); //Απελευθέρωση της curr
 c73:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 c77:	48 89 c7             	mov    %rax,%rdi
 c7a:	e8 fe fb ff ff       	call   87d <free>
        curr = temp;
 c7f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 c83:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    while (curr != NULL){ 
 c87:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
 c8c:	75 d9                	jne    c67 <deleteSet+0x20>
    }
    free(set); //Διαγραφή του Set
 c8e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 c92:	48 89 c7             	mov    %rax,%rdi
 c95:	e8 e3 fb ff ff       	call   87d <free>
 c9a:	eb 01                	jmp    c9d <deleteSet+0x56>
    if (set == NULL) return; //Αν ο χρήστης είναι ΜΛΚ!
 c9c:	90                   	nop
}
 c9d:	c9                   	leave
 c9e:	c3                   	ret

0000000000000c9f <getNodeAtPosition>:

SetNode* getNodeAtPosition(Set *set, int i){
 c9f:	55                   	push   %rbp
 ca0:	48 89 e5             	mov    %rsp,%rbp
 ca3:	48 83 ec 20          	sub    $0x20,%rsp
 ca7:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
 cab:	89 75 e4             	mov    %esi,-0x1c(%rbp)
    if (set == NULL || set->root == NULL) return NULL; //Αν ο χρήστης είναι ΜΛΚ!
 cae:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
 cb3:	74 0c                	je     cc1 <getNodeAtPosition+0x22>
 cb5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 cb9:	48 8b 00             	mov    (%rax),%rax
 cbc:	48 85 c0             	test   %rax,%rax
 cbf:	75 07                	jne    cc8 <getNodeAtPosition+0x29>
 cc1:	b8 00 00 00 00       	mov    $0x0,%eax
 cc6:	eb 3d                	jmp    d05 <getNodeAtPosition+0x66>

    SetNode *curr = set->root;
 cc8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 ccc:	48 8b 00             	mov    (%rax),%rax
 ccf:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    int n;

    for(n = 0; n<i && curr->next != NULL; n++) curr = curr->next; //Ο έλεγχος εδω είναι: n<i && curr->next != NULL
 cd3:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
 cda:	eb 10                	jmp    cec <getNodeAtPosition+0x4d>
 cdc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 ce0:	48 8b 40 08          	mov    0x8(%rax),%rax
 ce4:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 ce8:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
 cec:	8b 45 f4             	mov    -0xc(%rbp),%eax
 cef:	3b 45 e4             	cmp    -0x1c(%rbp),%eax
 cf2:	7d 0d                	jge    d01 <getNodeAtPosition+0x62>
 cf4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 cf8:	48 8b 40 08          	mov    0x8(%rax),%rax
 cfc:	48 85 c0             	test   %rax,%rax
 cff:	75 db                	jne    cdc <getNodeAtPosition+0x3d>
    return curr;
 d01:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 d05:	c9                   	leave
 d06:	c3                   	ret
