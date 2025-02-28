
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
  15:	48 c7 c6 fa 0a 00 00 	mov    $0xafa,%rsi
  1c:	bf 02 00 00 00       	mov    $0x2,%edi
  21:	b8 00 00 00 00       	mov    $0x0,%eax
  26:	e8 ca 04 00 00       	call   4f5 <printf>
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

000000000000040b <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 40b:	55                   	push   %rbp
 40c:	48 89 e5             	mov    %rsp,%rbp
 40f:	48 83 ec 10          	sub    $0x10,%rsp
 413:	89 7d fc             	mov    %edi,-0x4(%rbp)
 416:	89 f0                	mov    %esi,%eax
 418:	88 45 f8             	mov    %al,-0x8(%rbp)
  write(fd, &c, 1);
 41b:	48 8d 4d f8          	lea    -0x8(%rbp),%rcx
 41f:	8b 45 fc             	mov    -0x4(%rbp),%eax
 422:	ba 01 00 00 00       	mov    $0x1,%edx
 427:	48 89 ce             	mov    %rcx,%rsi
 42a:	89 c7                	mov    %eax,%edi
 42c:	e8 52 ff ff ff       	call   383 <write>
}
 431:	90                   	nop
 432:	c9                   	leave
 433:	c3                   	ret

0000000000000434 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 434:	55                   	push   %rbp
 435:	48 89 e5             	mov    %rsp,%rbp
 438:	48 83 ec 30          	sub    $0x30,%rsp
 43c:	89 7d dc             	mov    %edi,-0x24(%rbp)
 43f:	89 75 d8             	mov    %esi,-0x28(%rbp)
 442:	89 55 d4             	mov    %edx,-0x2c(%rbp)
 445:	89 4d d0             	mov    %ecx,-0x30(%rbp)
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 448:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
  if(sgn && xx < 0){
 44f:	83 7d d0 00          	cmpl   $0x0,-0x30(%rbp)
 453:	74 17                	je     46c <printint+0x38>
 455:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
 459:	79 11                	jns    46c <printint+0x38>
    neg = 1;
 45b:	c7 45 f8 01 00 00 00 	movl   $0x1,-0x8(%rbp)
    x = -xx;
 462:	8b 45 d8             	mov    -0x28(%rbp),%eax
 465:	f7 d8                	neg    %eax
 467:	89 45 f4             	mov    %eax,-0xc(%rbp)
 46a:	eb 06                	jmp    472 <printint+0x3e>
  } else {
    x = xx;
 46c:	8b 45 d8             	mov    -0x28(%rbp),%eax
 46f:	89 45 f4             	mov    %eax,-0xc(%rbp)
  }

  i = 0;
 472:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  do{
    buf[i++] = digits[x % base];
 479:	8b 4d d4             	mov    -0x2c(%rbp),%ecx
 47c:	8b 45 f4             	mov    -0xc(%rbp),%eax
 47f:	ba 00 00 00 00       	mov    $0x0,%edx
 484:	f7 f1                	div    %ecx
 486:	89 d1                	mov    %edx,%ecx
 488:	8b 45 fc             	mov    -0x4(%rbp),%eax
 48b:	8d 50 01             	lea    0x1(%rax),%edx
 48e:	89 55 fc             	mov    %edx,-0x4(%rbp)
 491:	89 ca                	mov    %ecx,%edx
 493:	0f b6 92 50 0d 00 00 	movzbl 0xd50(%rdx),%edx
 49a:	48 98                	cltq
 49c:	88 54 05 e0          	mov    %dl,-0x20(%rbp,%rax,1)
  }while((x /= base) != 0);
 4a0:	8b 75 d4             	mov    -0x2c(%rbp),%esi
 4a3:	8b 45 f4             	mov    -0xc(%rbp),%eax
 4a6:	ba 00 00 00 00       	mov    $0x0,%edx
 4ab:	f7 f6                	div    %esi
 4ad:	89 45 f4             	mov    %eax,-0xc(%rbp)
 4b0:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
 4b4:	75 c3                	jne    479 <printint+0x45>
  if(neg)
 4b6:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
 4ba:	74 2b                	je     4e7 <printint+0xb3>
    buf[i++] = '-';
 4bc:	8b 45 fc             	mov    -0x4(%rbp),%eax
 4bf:	8d 50 01             	lea    0x1(%rax),%edx
 4c2:	89 55 fc             	mov    %edx,-0x4(%rbp)
 4c5:	48 98                	cltq
 4c7:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%rbp,%rax,1)

  while(--i >= 0)
 4cc:	eb 19                	jmp    4e7 <printint+0xb3>
    putc(fd, buf[i]);
 4ce:	8b 45 fc             	mov    -0x4(%rbp),%eax
 4d1:	48 98                	cltq
 4d3:	0f b6 44 05 e0       	movzbl -0x20(%rbp,%rax,1),%eax
 4d8:	0f be d0             	movsbl %al,%edx
 4db:	8b 45 dc             	mov    -0x24(%rbp),%eax
 4de:	89 d6                	mov    %edx,%esi
 4e0:	89 c7                	mov    %eax,%edi
 4e2:	e8 24 ff ff ff       	call   40b <putc>
  while(--i >= 0)
 4e7:	83 6d fc 01          	subl   $0x1,-0x4(%rbp)
 4eb:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
 4ef:	79 dd                	jns    4ce <printint+0x9a>
}
 4f1:	90                   	nop
 4f2:	90                   	nop
 4f3:	c9                   	leave
 4f4:	c3                   	ret

00000000000004f5 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 4f5:	55                   	push   %rbp
 4f6:	48 89 e5             	mov    %rsp,%rbp
 4f9:	48 81 ec f0 00 00 00 	sub    $0xf0,%rsp
 500:	89 bd 1c ff ff ff    	mov    %edi,-0xe4(%rbp)
 506:	48 89 b5 10 ff ff ff 	mov    %rsi,-0xf0(%rbp)
 50d:	48 89 95 60 ff ff ff 	mov    %rdx,-0xa0(%rbp)
 514:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
 51b:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
 522:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
 529:	84 c0                	test   %al,%al
 52b:	74 20                	je     54d <printf+0x58>
 52d:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
 531:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
 535:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
 539:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
 53d:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
 541:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
 545:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
 549:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  va_list ap;
  char *s;
  int c, i, state;
  va_start(ap, fmt);
 54d:	c7 85 20 ff ff ff 10 	movl   $0x10,-0xe0(%rbp)
 554:	00 00 00 
 557:	c7 85 24 ff ff ff 30 	movl   $0x30,-0xdc(%rbp)
 55e:	00 00 00 
 561:	48 8d 45 10          	lea    0x10(%rbp),%rax
 565:	48 89 85 28 ff ff ff 	mov    %rax,-0xd8(%rbp)
 56c:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
 573:	48 89 85 30 ff ff ff 	mov    %rax,-0xd0(%rbp)

  state = 0;
 57a:	c7 85 40 ff ff ff 00 	movl   $0x0,-0xc0(%rbp)
 581:	00 00 00 
  for(i = 0; fmt[i]; i++){
 584:	c7 85 44 ff ff ff 00 	movl   $0x0,-0xbc(%rbp)
 58b:	00 00 00 
 58e:	e9 a8 02 00 00       	jmp    83b <printf+0x346>
    c = fmt[i] & 0xff;
 593:	8b 85 44 ff ff ff    	mov    -0xbc(%rbp),%eax
 599:	48 63 d0             	movslq %eax,%rdx
 59c:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
 5a3:	48 01 d0             	add    %rdx,%rax
 5a6:	0f b6 00             	movzbl (%rax),%eax
 5a9:	0f be c0             	movsbl %al,%eax
 5ac:	25 ff 00 00 00       	and    $0xff,%eax
 5b1:	89 85 3c ff ff ff    	mov    %eax,-0xc4(%rbp)
    if(state == 0){
 5b7:	83 bd 40 ff ff ff 00 	cmpl   $0x0,-0xc0(%rbp)
 5be:	75 35                	jne    5f5 <printf+0x100>
      if(c == '%'){
 5c0:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
 5c7:	75 0f                	jne    5d8 <printf+0xe3>
        state = '%';
 5c9:	c7 85 40 ff ff ff 25 	movl   $0x25,-0xc0(%rbp)
 5d0:	00 00 00 
 5d3:	e9 5c 02 00 00       	jmp    834 <printf+0x33f>
      } else {
        putc(fd, c);
 5d8:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
 5de:	0f be d0             	movsbl %al,%edx
 5e1:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 5e7:	89 d6                	mov    %edx,%esi
 5e9:	89 c7                	mov    %eax,%edi
 5eb:	e8 1b fe ff ff       	call   40b <putc>
 5f0:	e9 3f 02 00 00       	jmp    834 <printf+0x33f>
      }
    } else if(state == '%'){
 5f5:	83 bd 40 ff ff ff 25 	cmpl   $0x25,-0xc0(%rbp)
 5fc:	0f 85 32 02 00 00    	jne    834 <printf+0x33f>
      if(c == 'd'){
 602:	83 bd 3c ff ff ff 64 	cmpl   $0x64,-0xc4(%rbp)
 609:	75 5e                	jne    669 <printf+0x174>
        printint(fd, va_arg(ap, int), 10, 1);
 60b:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 611:	83 f8 2f             	cmp    $0x2f,%eax
 614:	77 23                	ja     639 <printf+0x144>
 616:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 61d:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 623:	89 d2                	mov    %edx,%edx
 625:	48 01 d0             	add    %rdx,%rax
 628:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 62e:	83 c2 08             	add    $0x8,%edx
 631:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 637:	eb 12                	jmp    64b <printf+0x156>
 639:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 640:	48 8d 50 08          	lea    0x8(%rax),%rdx
 644:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 64b:	8b 30                	mov    (%rax),%esi
 64d:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 653:	b9 01 00 00 00       	mov    $0x1,%ecx
 658:	ba 0a 00 00 00       	mov    $0xa,%edx
 65d:	89 c7                	mov    %eax,%edi
 65f:	e8 d0 fd ff ff       	call   434 <printint>
 664:	e9 c1 01 00 00       	jmp    82a <printf+0x335>
      } else if(c == 'x' || c == 'p'){
 669:	83 bd 3c ff ff ff 78 	cmpl   $0x78,-0xc4(%rbp)
 670:	74 09                	je     67b <printf+0x186>
 672:	83 bd 3c ff ff ff 70 	cmpl   $0x70,-0xc4(%rbp)
 679:	75 5e                	jne    6d9 <printf+0x1e4>
        printint(fd, va_arg(ap, int), 16, 0);
 67b:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 681:	83 f8 2f             	cmp    $0x2f,%eax
 684:	77 23                	ja     6a9 <printf+0x1b4>
 686:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 68d:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 693:	89 d2                	mov    %edx,%edx
 695:	48 01 d0             	add    %rdx,%rax
 698:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 69e:	83 c2 08             	add    $0x8,%edx
 6a1:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 6a7:	eb 12                	jmp    6bb <printf+0x1c6>
 6a9:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 6b0:	48 8d 50 08          	lea    0x8(%rax),%rdx
 6b4:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 6bb:	8b 30                	mov    (%rax),%esi
 6bd:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 6c3:	b9 00 00 00 00       	mov    $0x0,%ecx
 6c8:	ba 10 00 00 00       	mov    $0x10,%edx
 6cd:	89 c7                	mov    %eax,%edi
 6cf:	e8 60 fd ff ff       	call   434 <printint>
 6d4:	e9 51 01 00 00       	jmp    82a <printf+0x335>
      } else if(c == 's'){
 6d9:	83 bd 3c ff ff ff 73 	cmpl   $0x73,-0xc4(%rbp)
 6e0:	0f 85 98 00 00 00    	jne    77e <printf+0x289>
        s = va_arg(ap, char*);
 6e6:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 6ec:	83 f8 2f             	cmp    $0x2f,%eax
 6ef:	77 23                	ja     714 <printf+0x21f>
 6f1:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 6f8:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 6fe:	89 d2                	mov    %edx,%edx
 700:	48 01 d0             	add    %rdx,%rax
 703:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 709:	83 c2 08             	add    $0x8,%edx
 70c:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 712:	eb 12                	jmp    726 <printf+0x231>
 714:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 71b:	48 8d 50 08          	lea    0x8(%rax),%rdx
 71f:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 726:	48 8b 00             	mov    (%rax),%rax
 729:	48 89 85 48 ff ff ff 	mov    %rax,-0xb8(%rbp)
        if(s == 0)
 730:	48 83 bd 48 ff ff ff 	cmpq   $0x0,-0xb8(%rbp)
 737:	00 
 738:	75 31                	jne    76b <printf+0x276>
          s = "(null)";
 73a:	48 c7 85 48 ff ff ff 	movq   $0xb0e,-0xb8(%rbp)
 741:	0e 0b 00 00 
        while(*s != 0){
 745:	eb 24                	jmp    76b <printf+0x276>
          putc(fd, *s);
 747:	48 8b 85 48 ff ff ff 	mov    -0xb8(%rbp),%rax
 74e:	0f b6 00             	movzbl (%rax),%eax
 751:	0f be d0             	movsbl %al,%edx
 754:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 75a:	89 d6                	mov    %edx,%esi
 75c:	89 c7                	mov    %eax,%edi
 75e:	e8 a8 fc ff ff       	call   40b <putc>
          s++;
 763:	48 83 85 48 ff ff ff 	addq   $0x1,-0xb8(%rbp)
 76a:	01 
        while(*s != 0){
 76b:	48 8b 85 48 ff ff ff 	mov    -0xb8(%rbp),%rax
 772:	0f b6 00             	movzbl (%rax),%eax
 775:	84 c0                	test   %al,%al
 777:	75 ce                	jne    747 <printf+0x252>
 779:	e9 ac 00 00 00       	jmp    82a <printf+0x335>
        }
      } else if(c == 'c'){
 77e:	83 bd 3c ff ff ff 63 	cmpl   $0x63,-0xc4(%rbp)
 785:	75 56                	jne    7dd <printf+0x2e8>
        putc(fd, va_arg(ap, uint));
 787:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 78d:	83 f8 2f             	cmp    $0x2f,%eax
 790:	77 23                	ja     7b5 <printf+0x2c0>
 792:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 799:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 79f:	89 d2                	mov    %edx,%edx
 7a1:	48 01 d0             	add    %rdx,%rax
 7a4:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 7aa:	83 c2 08             	add    $0x8,%edx
 7ad:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 7b3:	eb 12                	jmp    7c7 <printf+0x2d2>
 7b5:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 7bc:	48 8d 50 08          	lea    0x8(%rax),%rdx
 7c0:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 7c7:	8b 00                	mov    (%rax),%eax
 7c9:	0f be d0             	movsbl %al,%edx
 7cc:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 7d2:	89 d6                	mov    %edx,%esi
 7d4:	89 c7                	mov    %eax,%edi
 7d6:	e8 30 fc ff ff       	call   40b <putc>
 7db:	eb 4d                	jmp    82a <printf+0x335>
      } else if(c == '%'){
 7dd:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
 7e4:	75 1a                	jne    800 <printf+0x30b>
        putc(fd, c);
 7e6:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
 7ec:	0f be d0             	movsbl %al,%edx
 7ef:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 7f5:	89 d6                	mov    %edx,%esi
 7f7:	89 c7                	mov    %eax,%edi
 7f9:	e8 0d fc ff ff       	call   40b <putc>
 7fe:	eb 2a                	jmp    82a <printf+0x335>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 800:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 806:	be 25 00 00 00       	mov    $0x25,%esi
 80b:	89 c7                	mov    %eax,%edi
 80d:	e8 f9 fb ff ff       	call   40b <putc>
        putc(fd, c);
 812:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
 818:	0f be d0             	movsbl %al,%edx
 81b:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 821:	89 d6                	mov    %edx,%esi
 823:	89 c7                	mov    %eax,%edi
 825:	e8 e1 fb ff ff       	call   40b <putc>
      }
      state = 0;
 82a:	c7 85 40 ff ff ff 00 	movl   $0x0,-0xc0(%rbp)
 831:	00 00 00 
  for(i = 0; fmt[i]; i++){
 834:	83 85 44 ff ff ff 01 	addl   $0x1,-0xbc(%rbp)
 83b:	8b 85 44 ff ff ff    	mov    -0xbc(%rbp),%eax
 841:	48 63 d0             	movslq %eax,%rdx
 844:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
 84b:	48 01 d0             	add    %rdx,%rax
 84e:	0f b6 00             	movzbl (%rax),%eax
 851:	84 c0                	test   %al,%al
 853:	0f 85 3a fd ff ff    	jne    593 <printf+0x9e>
    }
  }
}
 859:	90                   	nop
 85a:	90                   	nop
 85b:	c9                   	leave
 85c:	c3                   	ret

000000000000085d <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 85d:	55                   	push   %rbp
 85e:	48 89 e5             	mov    %rsp,%rbp
 861:	48 83 ec 18          	sub    $0x18,%rsp
 865:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  Header *bp, *p;

  bp = (Header*)ap - 1;
 869:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 86d:	48 83 e8 10          	sub    $0x10,%rax
 871:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 875:	48 8b 05 04 05 00 00 	mov    0x504(%rip),%rax        # d80 <freep>
 87c:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 880:	eb 2f                	jmp    8b1 <free+0x54>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 882:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 886:	48 8b 00             	mov    (%rax),%rax
 889:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 88d:	72 17                	jb     8a6 <free+0x49>
 88f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 893:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 897:	72 2f                	jb     8c8 <free+0x6b>
 899:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 89d:	48 8b 00             	mov    (%rax),%rax
 8a0:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
 8a4:	72 22                	jb     8c8 <free+0x6b>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8a6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 8aa:	48 8b 00             	mov    (%rax),%rax
 8ad:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 8b1:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 8b5:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 8b9:	73 c7                	jae    882 <free+0x25>
 8bb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 8bf:	48 8b 00             	mov    (%rax),%rax
 8c2:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
 8c6:	73 ba                	jae    882 <free+0x25>
      break;
  if(bp + bp->s.size == p->s.ptr){
 8c8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 8cc:	8b 40 08             	mov    0x8(%rax),%eax
 8cf:	89 c0                	mov    %eax,%eax
 8d1:	48 c1 e0 04          	shl    $0x4,%rax
 8d5:	48 89 c2             	mov    %rax,%rdx
 8d8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 8dc:	48 01 c2             	add    %rax,%rdx
 8df:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 8e3:	48 8b 00             	mov    (%rax),%rax
 8e6:	48 39 c2             	cmp    %rax,%rdx
 8e9:	75 2d                	jne    918 <free+0xbb>
    bp->s.size += p->s.ptr->s.size;
 8eb:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 8ef:	8b 50 08             	mov    0x8(%rax),%edx
 8f2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 8f6:	48 8b 00             	mov    (%rax),%rax
 8f9:	8b 40 08             	mov    0x8(%rax),%eax
 8fc:	01 c2                	add    %eax,%edx
 8fe:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 902:	89 50 08             	mov    %edx,0x8(%rax)
    bp->s.ptr = p->s.ptr->s.ptr;
 905:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 909:	48 8b 00             	mov    (%rax),%rax
 90c:	48 8b 10             	mov    (%rax),%rdx
 90f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 913:	48 89 10             	mov    %rdx,(%rax)
 916:	eb 0e                	jmp    926 <free+0xc9>
  } else
    bp->s.ptr = p->s.ptr;
 918:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 91c:	48 8b 10             	mov    (%rax),%rdx
 91f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 923:	48 89 10             	mov    %rdx,(%rax)
  if(p + p->s.size == bp){
 926:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 92a:	8b 40 08             	mov    0x8(%rax),%eax
 92d:	89 c0                	mov    %eax,%eax
 92f:	48 c1 e0 04          	shl    $0x4,%rax
 933:	48 89 c2             	mov    %rax,%rdx
 936:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 93a:	48 01 d0             	add    %rdx,%rax
 93d:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
 941:	75 27                	jne    96a <free+0x10d>
    p->s.size += bp->s.size;
 943:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 947:	8b 50 08             	mov    0x8(%rax),%edx
 94a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 94e:	8b 40 08             	mov    0x8(%rax),%eax
 951:	01 c2                	add    %eax,%edx
 953:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 957:	89 50 08             	mov    %edx,0x8(%rax)
    p->s.ptr = bp->s.ptr;
 95a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 95e:	48 8b 10             	mov    (%rax),%rdx
 961:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 965:	48 89 10             	mov    %rdx,(%rax)
 968:	eb 0b                	jmp    975 <free+0x118>
  } else
    p->s.ptr = bp;
 96a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 96e:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
 972:	48 89 10             	mov    %rdx,(%rax)
  freep = p;
 975:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 979:	48 89 05 00 04 00 00 	mov    %rax,0x400(%rip)        # d80 <freep>
}
 980:	90                   	nop
 981:	c9                   	leave
 982:	c3                   	ret

0000000000000983 <morecore>:

static Header*
morecore(uint nu)
{
 983:	55                   	push   %rbp
 984:	48 89 e5             	mov    %rsp,%rbp
 987:	48 83 ec 20          	sub    $0x20,%rsp
 98b:	89 7d ec             	mov    %edi,-0x14(%rbp)
  char *p;
  Header *hp;

  if(nu < 4096)
 98e:	81 7d ec ff 0f 00 00 	cmpl   $0xfff,-0x14(%rbp)
 995:	77 07                	ja     99e <morecore+0x1b>
    nu = 4096;
 997:	c7 45 ec 00 10 00 00 	movl   $0x1000,-0x14(%rbp)
  p = sbrk(nu * sizeof(Header));
 99e:	8b 45 ec             	mov    -0x14(%rbp),%eax
 9a1:	c1 e0 04             	shl    $0x4,%eax
 9a4:	89 c7                	mov    %eax,%edi
 9a6:	e8 40 fa ff ff       	call   3eb <sbrk>
 9ab:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  if(p == (char*)-1)
 9af:	48 83 7d f8 ff       	cmpq   $0xffffffffffffffff,-0x8(%rbp)
 9b4:	75 07                	jne    9bd <morecore+0x3a>
    return 0;
 9b6:	b8 00 00 00 00       	mov    $0x0,%eax
 9bb:	eb 29                	jmp    9e6 <morecore+0x63>
  hp = (Header*)p;
 9bd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 9c1:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  hp->s.size = nu;
 9c5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 9c9:	8b 55 ec             	mov    -0x14(%rbp),%edx
 9cc:	89 50 08             	mov    %edx,0x8(%rax)
  free((void*)(hp + 1));
 9cf:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 9d3:	48 83 c0 10          	add    $0x10,%rax
 9d7:	48 89 c7             	mov    %rax,%rdi
 9da:	e8 7e fe ff ff       	call   85d <free>
  return freep;
 9df:	48 8b 05 9a 03 00 00 	mov    0x39a(%rip),%rax        # d80 <freep>
}
 9e6:	c9                   	leave
 9e7:	c3                   	ret

00000000000009e8 <malloc>:

void*
malloc(uint nbytes)
{
 9e8:	55                   	push   %rbp
 9e9:	48 89 e5             	mov    %rsp,%rbp
 9ec:	48 83 ec 30          	sub    $0x30,%rsp
 9f0:	89 7d dc             	mov    %edi,-0x24(%rbp)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 9f3:	8b 45 dc             	mov    -0x24(%rbp),%eax
 9f6:	48 83 c0 0f          	add    $0xf,%rax
 9fa:	48 c1 e8 04          	shr    $0x4,%rax
 9fe:	83 c0 01             	add    $0x1,%eax
 a01:	89 45 ec             	mov    %eax,-0x14(%rbp)
  if((prevp = freep) == 0){
 a04:	48 8b 05 75 03 00 00 	mov    0x375(%rip),%rax        # d80 <freep>
 a0b:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
 a0f:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
 a14:	75 2b                	jne    a41 <malloc+0x59>
    base.s.ptr = freep = prevp = &base;
 a16:	48 c7 45 f0 70 0d 00 	movq   $0xd70,-0x10(%rbp)
 a1d:	00 
 a1e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 a22:	48 89 05 57 03 00 00 	mov    %rax,0x357(%rip)        # d80 <freep>
 a29:	48 8b 05 50 03 00 00 	mov    0x350(%rip),%rax        # d80 <freep>
 a30:	48 89 05 39 03 00 00 	mov    %rax,0x339(%rip)        # d70 <base>
    base.s.size = 0;
 a37:	c7 05 37 03 00 00 00 	movl   $0x0,0x337(%rip)        # d78 <base+0x8>
 a3e:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a41:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 a45:	48 8b 00             	mov    (%rax),%rax
 a48:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
 a4c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a50:	8b 40 08             	mov    0x8(%rax),%eax
 a53:	3b 45 ec             	cmp    -0x14(%rbp),%eax
 a56:	72 5f                	jb     ab7 <malloc+0xcf>
      if(p->s.size == nunits)
 a58:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a5c:	8b 40 08             	mov    0x8(%rax),%eax
 a5f:	39 45 ec             	cmp    %eax,-0x14(%rbp)
 a62:	75 10                	jne    a74 <malloc+0x8c>
        prevp->s.ptr = p->s.ptr;
 a64:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a68:	48 8b 10             	mov    (%rax),%rdx
 a6b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 a6f:	48 89 10             	mov    %rdx,(%rax)
 a72:	eb 2e                	jmp    aa2 <malloc+0xba>
      else {
        p->s.size -= nunits;
 a74:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a78:	8b 40 08             	mov    0x8(%rax),%eax
 a7b:	2b 45 ec             	sub    -0x14(%rbp),%eax
 a7e:	89 c2                	mov    %eax,%edx
 a80:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a84:	89 50 08             	mov    %edx,0x8(%rax)
        p += p->s.size;
 a87:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a8b:	8b 40 08             	mov    0x8(%rax),%eax
 a8e:	89 c0                	mov    %eax,%eax
 a90:	48 c1 e0 04          	shl    $0x4,%rax
 a94:	48 01 45 f8          	add    %rax,-0x8(%rbp)
        p->s.size = nunits;
 a98:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a9c:	8b 55 ec             	mov    -0x14(%rbp),%edx
 a9f:	89 50 08             	mov    %edx,0x8(%rax)
      }
      freep = prevp;
 aa2:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 aa6:	48 89 05 d3 02 00 00 	mov    %rax,0x2d3(%rip)        # d80 <freep>
      return (void*)(p + 1);
 aad:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 ab1:	48 83 c0 10          	add    $0x10,%rax
 ab5:	eb 41                	jmp    af8 <malloc+0x110>
    }
    if(p == freep)
 ab7:	48 8b 05 c2 02 00 00 	mov    0x2c2(%rip),%rax        # d80 <freep>
 abe:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 ac2:	75 1c                	jne    ae0 <malloc+0xf8>
      if((p = morecore(nunits)) == 0)
 ac4:	8b 45 ec             	mov    -0x14(%rbp),%eax
 ac7:	89 c7                	mov    %eax,%edi
 ac9:	e8 b5 fe ff ff       	call   983 <morecore>
 ace:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 ad2:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
 ad7:	75 07                	jne    ae0 <malloc+0xf8>
        return 0;
 ad9:	b8 00 00 00 00       	mov    $0x0,%eax
 ade:	eb 18                	jmp    af8 <malloc+0x110>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 ae0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 ae4:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
 ae8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 aec:	48 8b 00             	mov    (%rax),%rax
 aef:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
 af3:	e9 54 ff ff ff       	jmp    a4c <malloc+0x64>
  }
}
 af8:	c9                   	leave
 af9:	c3                   	ret
