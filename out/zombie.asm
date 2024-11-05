
fs/zombie:     file format elf64-x86-64


Disassembly of section .text:

0000000000000000 <main>:
#include "stat.h"
#include "user.h"

int
main(void)
{
   0:	55                   	push   %rbp
   1:	48 89 e5             	mov    %rsp,%rbp
  if(fork() > 0)
   4:	e8 fe 02 00 00       	call   307 <fork>
   9:	85 c0                	test   %eax,%eax
   b:	7e 0a                	jle    17 <main+0x17>
    sleep(5);  // Let child exit before parent.
   d:	bf 05 00 00 00       	mov    $0x5,%edi
  12:	e8 88 03 00 00       	call   39f <sleep>
  exit();
  17:	e8 f3 02 00 00       	call   30f <exit>

000000000000001c <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
  1c:	55                   	push   %rbp
  1d:	48 89 e5             	mov    %rsp,%rbp
  20:	48 83 ec 10          	sub    $0x10,%rsp
  24:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  28:	89 75 f4             	mov    %esi,-0xc(%rbp)
  2b:	89 55 f0             	mov    %edx,-0x10(%rbp)
  asm volatile("cld; rep stosb" :
  2e:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
  32:	8b 55 f0             	mov    -0x10(%rbp),%edx
  35:	8b 45 f4             	mov    -0xc(%rbp),%eax
  38:	48 89 ce             	mov    %rcx,%rsi
  3b:	48 89 f7             	mov    %rsi,%rdi
  3e:	89 d1                	mov    %edx,%ecx
  40:	fc                   	cld
  41:	f3 aa                	rep stos %al,%es:(%rdi)
  43:	89 ca                	mov    %ecx,%edx
  45:	48 89 fe             	mov    %rdi,%rsi
  48:	48 89 75 f8          	mov    %rsi,-0x8(%rbp)
  4c:	89 55 f0             	mov    %edx,-0x10(%rbp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
  4f:	90                   	nop
  50:	c9                   	leave
  51:	c3                   	ret

0000000000000052 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
  52:	55                   	push   %rbp
  53:	48 89 e5             	mov    %rsp,%rbp
  56:	48 83 ec 20          	sub    $0x20,%rsp
  5a:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  5e:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  char *os;

  os = s;
  62:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  66:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  while((*s++ = *t++) != 0)
  6a:	90                   	nop
  6b:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  6f:	48 8d 42 01          	lea    0x1(%rdx),%rax
  73:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  77:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  7b:	48 8d 48 01          	lea    0x1(%rax),%rcx
  7f:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  83:	0f b6 12             	movzbl (%rdx),%edx
  86:	88 10                	mov    %dl,(%rax)
  88:	0f b6 00             	movzbl (%rax),%eax
  8b:	84 c0                	test   %al,%al
  8d:	75 dc                	jne    6b <strcpy+0x19>
    ;
  return os;
  8f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
  93:	c9                   	leave
  94:	c3                   	ret

0000000000000095 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  95:	55                   	push   %rbp
  96:	48 89 e5             	mov    %rsp,%rbp
  99:	48 83 ec 10          	sub    $0x10,%rsp
  9d:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  a1:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  while(*p && *p == *q)
  a5:	eb 0a                	jmp    b1 <strcmp+0x1c>
    p++, q++;
  a7:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  ac:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  while(*p && *p == *q)
  b1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  b5:	0f b6 00             	movzbl (%rax),%eax
  b8:	84 c0                	test   %al,%al
  ba:	74 12                	je     ce <strcmp+0x39>
  bc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  c0:	0f b6 10             	movzbl (%rax),%edx
  c3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  c7:	0f b6 00             	movzbl (%rax),%eax
  ca:	38 c2                	cmp    %al,%dl
  cc:	74 d9                	je     a7 <strcmp+0x12>
  return (uchar)*p - (uchar)*q;
  ce:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  d2:	0f b6 00             	movzbl (%rax),%eax
  d5:	0f b6 d0             	movzbl %al,%edx
  d8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  dc:	0f b6 00             	movzbl (%rax),%eax
  df:	0f b6 c0             	movzbl %al,%eax
  e2:	29 c2                	sub    %eax,%edx
  e4:	89 d0                	mov    %edx,%eax
}
  e6:	c9                   	leave
  e7:	c3                   	ret

00000000000000e8 <strlen>:

uint
strlen(char *s)
{
  e8:	55                   	push   %rbp
  e9:	48 89 e5             	mov    %rsp,%rbp
  ec:	48 83 ec 18          	sub    $0x18,%rsp
  f0:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  int n;

  for(n = 0; s[n]; n++)
  f4:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  fb:	eb 04                	jmp    101 <strlen+0x19>
  fd:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
 101:	8b 45 fc             	mov    -0x4(%rbp),%eax
 104:	48 63 d0             	movslq %eax,%rdx
 107:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 10b:	48 01 d0             	add    %rdx,%rax
 10e:	0f b6 00             	movzbl (%rax),%eax
 111:	84 c0                	test   %al,%al
 113:	75 e8                	jne    fd <strlen+0x15>
    ;
  return n;
 115:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
 118:	c9                   	leave
 119:	c3                   	ret

000000000000011a <memset>:

void*
memset(void *dst, int c, uint n)
{
 11a:	55                   	push   %rbp
 11b:	48 89 e5             	mov    %rsp,%rbp
 11e:	48 83 ec 10          	sub    $0x10,%rsp
 122:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
 126:	89 75 f4             	mov    %esi,-0xc(%rbp)
 129:	89 55 f0             	mov    %edx,-0x10(%rbp)
  stosb(dst, c, n);
 12c:	8b 55 f0             	mov    -0x10(%rbp),%edx
 12f:	8b 4d f4             	mov    -0xc(%rbp),%ecx
 132:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 136:	89 ce                	mov    %ecx,%esi
 138:	48 89 c7             	mov    %rax,%rdi
 13b:	e8 dc fe ff ff       	call   1c <stosb>
  return dst;
 140:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
 144:	c9                   	leave
 145:	c3                   	ret

0000000000000146 <strchr>:

char*
strchr(const char *s, char c)
{
 146:	55                   	push   %rbp
 147:	48 89 e5             	mov    %rsp,%rbp
 14a:	48 83 ec 10          	sub    $0x10,%rsp
 14e:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
 152:	89 f0                	mov    %esi,%eax
 154:	88 45 f4             	mov    %al,-0xc(%rbp)
  for(; *s; s++)
 157:	eb 17                	jmp    170 <strchr+0x2a>
    if(*s == c)
 159:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 15d:	0f b6 00             	movzbl (%rax),%eax
 160:	38 45 f4             	cmp    %al,-0xc(%rbp)
 163:	75 06                	jne    16b <strchr+0x25>
      return (char*)s;
 165:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 169:	eb 15                	jmp    180 <strchr+0x3a>
  for(; *s; s++)
 16b:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
 170:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 174:	0f b6 00             	movzbl (%rax),%eax
 177:	84 c0                	test   %al,%al
 179:	75 de                	jne    159 <strchr+0x13>
  return 0;
 17b:	b8 00 00 00 00       	mov    $0x0,%eax
}
 180:	c9                   	leave
 181:	c3                   	ret

0000000000000182 <gets>:

char*
gets(char *buf, int max)
{
 182:	55                   	push   %rbp
 183:	48 89 e5             	mov    %rsp,%rbp
 186:	48 83 ec 20          	sub    $0x20,%rsp
 18a:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
 18e:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 191:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
 198:	eb 48                	jmp    1e2 <gets+0x60>
    cc = read(0, &c, 1);
 19a:	48 8d 45 f7          	lea    -0x9(%rbp),%rax
 19e:	ba 01 00 00 00       	mov    $0x1,%edx
 1a3:	48 89 c6             	mov    %rax,%rsi
 1a6:	bf 00 00 00 00       	mov    $0x0,%edi
 1ab:	e8 77 01 00 00       	call   327 <read>
 1b0:	89 45 f8             	mov    %eax,-0x8(%rbp)
    if(cc < 1)
 1b3:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
 1b7:	7e 36                	jle    1ef <gets+0x6d>
      break;
    buf[i++] = c;
 1b9:	8b 45 fc             	mov    -0x4(%rbp),%eax
 1bc:	8d 50 01             	lea    0x1(%rax),%edx
 1bf:	89 55 fc             	mov    %edx,-0x4(%rbp)
 1c2:	48 63 d0             	movslq %eax,%rdx
 1c5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 1c9:	48 01 c2             	add    %rax,%rdx
 1cc:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
 1d0:	88 02                	mov    %al,(%rdx)
    if(c == '\n' || c == '\r')
 1d2:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
 1d6:	3c 0a                	cmp    $0xa,%al
 1d8:	74 16                	je     1f0 <gets+0x6e>
 1da:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
 1de:	3c 0d                	cmp    $0xd,%al
 1e0:	74 0e                	je     1f0 <gets+0x6e>
  for(i=0; i+1 < max; ){
 1e2:	8b 45 fc             	mov    -0x4(%rbp),%eax
 1e5:	83 c0 01             	add    $0x1,%eax
 1e8:	39 45 e4             	cmp    %eax,-0x1c(%rbp)
 1eb:	7f ad                	jg     19a <gets+0x18>
 1ed:	eb 01                	jmp    1f0 <gets+0x6e>
      break;
 1ef:	90                   	nop
      break;
  }
  buf[i] = '\0';
 1f0:	8b 45 fc             	mov    -0x4(%rbp),%eax
 1f3:	48 63 d0             	movslq %eax,%rdx
 1f6:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 1fa:	48 01 d0             	add    %rdx,%rax
 1fd:	c6 00 00             	movb   $0x0,(%rax)
  return buf;
 200:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
 204:	c9                   	leave
 205:	c3                   	ret

0000000000000206 <stat>:

int
stat(char *n, struct stat *st)
{
 206:	55                   	push   %rbp
 207:	48 89 e5             	mov    %rsp,%rbp
 20a:	48 83 ec 20          	sub    $0x20,%rsp
 20e:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
 212:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 216:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 21a:	be 00 00 00 00       	mov    $0x0,%esi
 21f:	48 89 c7             	mov    %rax,%rdi
 222:	e8 28 01 00 00       	call   34f <open>
 227:	89 45 fc             	mov    %eax,-0x4(%rbp)
  if(fd < 0)
 22a:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
 22e:	79 07                	jns    237 <stat+0x31>
    return -1;
 230:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 235:	eb 21                	jmp    258 <stat+0x52>
  r = fstat(fd, st);
 237:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
 23b:	8b 45 fc             	mov    -0x4(%rbp),%eax
 23e:	48 89 d6             	mov    %rdx,%rsi
 241:	89 c7                	mov    %eax,%edi
 243:	e8 1f 01 00 00       	call   367 <fstat>
 248:	89 45 f8             	mov    %eax,-0x8(%rbp)
  close(fd);
 24b:	8b 45 fc             	mov    -0x4(%rbp),%eax
 24e:	89 c7                	mov    %eax,%edi
 250:	e8 e2 00 00 00       	call   337 <close>
  return r;
 255:	8b 45 f8             	mov    -0x8(%rbp),%eax
}
 258:	c9                   	leave
 259:	c3                   	ret

000000000000025a <atoi>:

int
atoi(const char *s)
{
 25a:	55                   	push   %rbp
 25b:	48 89 e5             	mov    %rsp,%rbp
 25e:	48 83 ec 18          	sub    $0x18,%rsp
 262:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  int n;

  n = 0;
 266:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  while('0' <= *s && *s <= '9')
 26d:	eb 28                	jmp    297 <atoi+0x3d>
    n = n*10 + *s++ - '0';
 26f:	8b 55 fc             	mov    -0x4(%rbp),%edx
 272:	89 d0                	mov    %edx,%eax
 274:	c1 e0 02             	shl    $0x2,%eax
 277:	01 d0                	add    %edx,%eax
 279:	01 c0                	add    %eax,%eax
 27b:	89 c1                	mov    %eax,%ecx
 27d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 281:	48 8d 50 01          	lea    0x1(%rax),%rdx
 285:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
 289:	0f b6 00             	movzbl (%rax),%eax
 28c:	0f be c0             	movsbl %al,%eax
 28f:	01 c8                	add    %ecx,%eax
 291:	83 e8 30             	sub    $0x30,%eax
 294:	89 45 fc             	mov    %eax,-0x4(%rbp)
  while('0' <= *s && *s <= '9')
 297:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 29b:	0f b6 00             	movzbl (%rax),%eax
 29e:	3c 2f                	cmp    $0x2f,%al
 2a0:	7e 0b                	jle    2ad <atoi+0x53>
 2a2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 2a6:	0f b6 00             	movzbl (%rax),%eax
 2a9:	3c 39                	cmp    $0x39,%al
 2ab:	7e c2                	jle    26f <atoi+0x15>
  return n;
 2ad:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
 2b0:	c9                   	leave
 2b1:	c3                   	ret

00000000000002b2 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 2b2:	55                   	push   %rbp
 2b3:	48 89 e5             	mov    %rsp,%rbp
 2b6:	48 83 ec 28          	sub    $0x28,%rsp
 2ba:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
 2be:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
 2c2:	89 55 dc             	mov    %edx,-0x24(%rbp)
  char *dst, *src;
  
  dst = vdst;
 2c5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 2c9:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  src = vsrc;
 2cd:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
 2d1:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  while(n-- > 0)
 2d5:	eb 1d                	jmp    2f4 <memmove+0x42>
    *dst++ = *src++;
 2d7:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
 2db:	48 8d 42 01          	lea    0x1(%rdx),%rax
 2df:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
 2e3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 2e7:	48 8d 48 01          	lea    0x1(%rax),%rcx
 2eb:	48 89 4d f8          	mov    %rcx,-0x8(%rbp)
 2ef:	0f b6 12             	movzbl (%rdx),%edx
 2f2:	88 10                	mov    %dl,(%rax)
  while(n-- > 0)
 2f4:	8b 45 dc             	mov    -0x24(%rbp),%eax
 2f7:	8d 50 ff             	lea    -0x1(%rax),%edx
 2fa:	89 55 dc             	mov    %edx,-0x24(%rbp)
 2fd:	85 c0                	test   %eax,%eax
 2ff:	7f d6                	jg     2d7 <memmove+0x25>
  return vdst;
 301:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
 305:	c9                   	leave
 306:	c3                   	ret

0000000000000307 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 307:	b8 01 00 00 00       	mov    $0x1,%eax
 30c:	cd 40                	int    $0x40
 30e:	c3                   	ret

000000000000030f <exit>:
SYSCALL(exit)
 30f:	b8 02 00 00 00       	mov    $0x2,%eax
 314:	cd 40                	int    $0x40
 316:	c3                   	ret

0000000000000317 <wait>:
SYSCALL(wait)
 317:	b8 03 00 00 00       	mov    $0x3,%eax
 31c:	cd 40                	int    $0x40
 31e:	c3                   	ret

000000000000031f <pipe>:
SYSCALL(pipe)
 31f:	b8 04 00 00 00       	mov    $0x4,%eax
 324:	cd 40                	int    $0x40
 326:	c3                   	ret

0000000000000327 <read>:
SYSCALL(read)
 327:	b8 05 00 00 00       	mov    $0x5,%eax
 32c:	cd 40                	int    $0x40
 32e:	c3                   	ret

000000000000032f <write>:
SYSCALL(write)
 32f:	b8 10 00 00 00       	mov    $0x10,%eax
 334:	cd 40                	int    $0x40
 336:	c3                   	ret

0000000000000337 <close>:
SYSCALL(close)
 337:	b8 15 00 00 00       	mov    $0x15,%eax
 33c:	cd 40                	int    $0x40
 33e:	c3                   	ret

000000000000033f <kill>:
SYSCALL(kill)
 33f:	b8 06 00 00 00       	mov    $0x6,%eax
 344:	cd 40                	int    $0x40
 346:	c3                   	ret

0000000000000347 <exec>:
SYSCALL(exec)
 347:	b8 07 00 00 00       	mov    $0x7,%eax
 34c:	cd 40                	int    $0x40
 34e:	c3                   	ret

000000000000034f <open>:
SYSCALL(open)
 34f:	b8 0f 00 00 00       	mov    $0xf,%eax
 354:	cd 40                	int    $0x40
 356:	c3                   	ret

0000000000000357 <mknod>:
SYSCALL(mknod)
 357:	b8 11 00 00 00       	mov    $0x11,%eax
 35c:	cd 40                	int    $0x40
 35e:	c3                   	ret

000000000000035f <unlink>:
SYSCALL(unlink)
 35f:	b8 12 00 00 00       	mov    $0x12,%eax
 364:	cd 40                	int    $0x40
 366:	c3                   	ret

0000000000000367 <fstat>:
SYSCALL(fstat)
 367:	b8 08 00 00 00       	mov    $0x8,%eax
 36c:	cd 40                	int    $0x40
 36e:	c3                   	ret

000000000000036f <link>:
SYSCALL(link)
 36f:	b8 13 00 00 00       	mov    $0x13,%eax
 374:	cd 40                	int    $0x40
 376:	c3                   	ret

0000000000000377 <mkdir>:
SYSCALL(mkdir)
 377:	b8 14 00 00 00       	mov    $0x14,%eax
 37c:	cd 40                	int    $0x40
 37e:	c3                   	ret

000000000000037f <chdir>:
SYSCALL(chdir)
 37f:	b8 09 00 00 00       	mov    $0x9,%eax
 384:	cd 40                	int    $0x40
 386:	c3                   	ret

0000000000000387 <dup>:
SYSCALL(dup)
 387:	b8 0a 00 00 00       	mov    $0xa,%eax
 38c:	cd 40                	int    $0x40
 38e:	c3                   	ret

000000000000038f <getpid>:
SYSCALL(getpid)
 38f:	b8 0b 00 00 00       	mov    $0xb,%eax
 394:	cd 40                	int    $0x40
 396:	c3                   	ret

0000000000000397 <sbrk>:
SYSCALL(sbrk)
 397:	b8 0c 00 00 00       	mov    $0xc,%eax
 39c:	cd 40                	int    $0x40
 39e:	c3                   	ret

000000000000039f <sleep>:
SYSCALL(sleep)
 39f:	b8 0d 00 00 00       	mov    $0xd,%eax
 3a4:	cd 40                	int    $0x40
 3a6:	c3                   	ret

00000000000003a7 <uptime>:
SYSCALL(uptime)
 3a7:	b8 0e 00 00 00       	mov    $0xe,%eax
 3ac:	cd 40                	int    $0x40
 3ae:	c3                   	ret

00000000000003af <getpinfo>:
SYSCALL(getpinfo)
 3af:	b8 18 00 00 00       	mov    $0x18,%eax
 3b4:	cd 40                	int    $0x40
 3b6:	c3                   	ret

00000000000003b7 <getfavnum>:
SYSCALL(getfavnum)
 3b7:	b8 19 00 00 00       	mov    $0x19,%eax
 3bc:	cd 40                	int    $0x40
 3be:	c3                   	ret

00000000000003bf <shutdown>:
SYSCALL(shutdown)
 3bf:	b8 1a 00 00 00       	mov    $0x1a,%eax
 3c4:	cd 40                	int    $0x40
 3c6:	c3                   	ret

00000000000003c7 <getcount>:
SYSCALL(getcount)
 3c7:	b8 1b 00 00 00       	mov    $0x1b,%eax
 3cc:	cd 40                	int    $0x40
 3ce:	c3                   	ret

00000000000003cf <killrandom>:
 3cf:	b8 1c 00 00 00       	mov    $0x1c,%eax
 3d4:	cd 40                	int    $0x40
 3d6:	c3                   	ret

00000000000003d7 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 3d7:	55                   	push   %rbp
 3d8:	48 89 e5             	mov    %rsp,%rbp
 3db:	48 83 ec 10          	sub    $0x10,%rsp
 3df:	89 7d fc             	mov    %edi,-0x4(%rbp)
 3e2:	89 f0                	mov    %esi,%eax
 3e4:	88 45 f8             	mov    %al,-0x8(%rbp)
  write(fd, &c, 1);
 3e7:	48 8d 4d f8          	lea    -0x8(%rbp),%rcx
 3eb:	8b 45 fc             	mov    -0x4(%rbp),%eax
 3ee:	ba 01 00 00 00       	mov    $0x1,%edx
 3f3:	48 89 ce             	mov    %rcx,%rsi
 3f6:	89 c7                	mov    %eax,%edi
 3f8:	e8 32 ff ff ff       	call   32f <write>
}
 3fd:	90                   	nop
 3fe:	c9                   	leave
 3ff:	c3                   	ret

0000000000000400 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 400:	55                   	push   %rbp
 401:	48 89 e5             	mov    %rsp,%rbp
 404:	48 83 ec 30          	sub    $0x30,%rsp
 408:	89 7d dc             	mov    %edi,-0x24(%rbp)
 40b:	89 75 d8             	mov    %esi,-0x28(%rbp)
 40e:	89 55 d4             	mov    %edx,-0x2c(%rbp)
 411:	89 4d d0             	mov    %ecx,-0x30(%rbp)
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 414:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
  if(sgn && xx < 0){
 41b:	83 7d d0 00          	cmpl   $0x0,-0x30(%rbp)
 41f:	74 17                	je     438 <printint+0x38>
 421:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
 425:	79 11                	jns    438 <printint+0x38>
    neg = 1;
 427:	c7 45 f8 01 00 00 00 	movl   $0x1,-0x8(%rbp)
    x = -xx;
 42e:	8b 45 d8             	mov    -0x28(%rbp),%eax
 431:	f7 d8                	neg    %eax
 433:	89 45 f4             	mov    %eax,-0xc(%rbp)
 436:	eb 06                	jmp    43e <printint+0x3e>
  } else {
    x = xx;
 438:	8b 45 d8             	mov    -0x28(%rbp),%eax
 43b:	89 45 f4             	mov    %eax,-0xc(%rbp)
  }

  i = 0;
 43e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  do{
    buf[i++] = digits[x % base];
 445:	8b 4d d4             	mov    -0x2c(%rbp),%ecx
 448:	8b 45 f4             	mov    -0xc(%rbp),%eax
 44b:	ba 00 00 00 00       	mov    $0x0,%edx
 450:	f7 f1                	div    %ecx
 452:	89 d1                	mov    %edx,%ecx
 454:	8b 45 fc             	mov    -0x4(%rbp),%eax
 457:	8d 50 01             	lea    0x1(%rax),%edx
 45a:	89 55 fc             	mov    %edx,-0x4(%rbp)
 45d:	89 ca                	mov    %ecx,%edx
 45f:	0f b6 92 a0 0f 00 00 	movzbl 0xfa0(%rdx),%edx
 466:	48 98                	cltq
 468:	88 54 05 e0          	mov    %dl,-0x20(%rbp,%rax,1)
  }while((x /= base) != 0);
 46c:	8b 75 d4             	mov    -0x2c(%rbp),%esi
 46f:	8b 45 f4             	mov    -0xc(%rbp),%eax
 472:	ba 00 00 00 00       	mov    $0x0,%edx
 477:	f7 f6                	div    %esi
 479:	89 45 f4             	mov    %eax,-0xc(%rbp)
 47c:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
 480:	75 c3                	jne    445 <printint+0x45>
  if(neg)
 482:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
 486:	74 2b                	je     4b3 <printint+0xb3>
    buf[i++] = '-';
 488:	8b 45 fc             	mov    -0x4(%rbp),%eax
 48b:	8d 50 01             	lea    0x1(%rax),%edx
 48e:	89 55 fc             	mov    %edx,-0x4(%rbp)
 491:	48 98                	cltq
 493:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%rbp,%rax,1)

  while(--i >= 0)
 498:	eb 19                	jmp    4b3 <printint+0xb3>
    putc(fd, buf[i]);
 49a:	8b 45 fc             	mov    -0x4(%rbp),%eax
 49d:	48 98                	cltq
 49f:	0f b6 44 05 e0       	movzbl -0x20(%rbp,%rax,1),%eax
 4a4:	0f be d0             	movsbl %al,%edx
 4a7:	8b 45 dc             	mov    -0x24(%rbp),%eax
 4aa:	89 d6                	mov    %edx,%esi
 4ac:	89 c7                	mov    %eax,%edi
 4ae:	e8 24 ff ff ff       	call   3d7 <putc>
  while(--i >= 0)
 4b3:	83 6d fc 01          	subl   $0x1,-0x4(%rbp)
 4b7:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
 4bb:	79 dd                	jns    49a <printint+0x9a>
}
 4bd:	90                   	nop
 4be:	90                   	nop
 4bf:	c9                   	leave
 4c0:	c3                   	ret

00000000000004c1 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 4c1:	55                   	push   %rbp
 4c2:	48 89 e5             	mov    %rsp,%rbp
 4c5:	48 81 ec f0 00 00 00 	sub    $0xf0,%rsp
 4cc:	89 bd 1c ff ff ff    	mov    %edi,-0xe4(%rbp)
 4d2:	48 89 b5 10 ff ff ff 	mov    %rsi,-0xf0(%rbp)
 4d9:	48 89 95 60 ff ff ff 	mov    %rdx,-0xa0(%rbp)
 4e0:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
 4e7:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
 4ee:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
 4f5:	84 c0                	test   %al,%al
 4f7:	74 20                	je     519 <printf+0x58>
 4f9:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
 4fd:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
 501:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
 505:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
 509:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
 50d:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
 511:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
 515:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  va_list ap;
  char *s;
  int c, i, state;
  va_start(ap, fmt);
 519:	c7 85 20 ff ff ff 10 	movl   $0x10,-0xe0(%rbp)
 520:	00 00 00 
 523:	c7 85 24 ff ff ff 30 	movl   $0x30,-0xdc(%rbp)
 52a:	00 00 00 
 52d:	48 8d 45 10          	lea    0x10(%rbp),%rax
 531:	48 89 85 28 ff ff ff 	mov    %rax,-0xd8(%rbp)
 538:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
 53f:	48 89 85 30 ff ff ff 	mov    %rax,-0xd0(%rbp)

  state = 0;
 546:	c7 85 40 ff ff ff 00 	movl   $0x0,-0xc0(%rbp)
 54d:	00 00 00 
  for(i = 0; fmt[i]; i++){
 550:	c7 85 44 ff ff ff 00 	movl   $0x0,-0xbc(%rbp)
 557:	00 00 00 
 55a:	e9 a8 02 00 00       	jmp    807 <printf+0x346>
    c = fmt[i] & 0xff;
 55f:	8b 85 44 ff ff ff    	mov    -0xbc(%rbp),%eax
 565:	48 63 d0             	movslq %eax,%rdx
 568:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
 56f:	48 01 d0             	add    %rdx,%rax
 572:	0f b6 00             	movzbl (%rax),%eax
 575:	0f be c0             	movsbl %al,%eax
 578:	25 ff 00 00 00       	and    $0xff,%eax
 57d:	89 85 3c ff ff ff    	mov    %eax,-0xc4(%rbp)
    if(state == 0){
 583:	83 bd 40 ff ff ff 00 	cmpl   $0x0,-0xc0(%rbp)
 58a:	75 35                	jne    5c1 <printf+0x100>
      if(c == '%'){
 58c:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
 593:	75 0f                	jne    5a4 <printf+0xe3>
        state = '%';
 595:	c7 85 40 ff ff ff 25 	movl   $0x25,-0xc0(%rbp)
 59c:	00 00 00 
 59f:	e9 5c 02 00 00       	jmp    800 <printf+0x33f>
      } else {
        putc(fd, c);
 5a4:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
 5aa:	0f be d0             	movsbl %al,%edx
 5ad:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 5b3:	89 d6                	mov    %edx,%esi
 5b5:	89 c7                	mov    %eax,%edi
 5b7:	e8 1b fe ff ff       	call   3d7 <putc>
 5bc:	e9 3f 02 00 00       	jmp    800 <printf+0x33f>
      }
    } else if(state == '%'){
 5c1:	83 bd 40 ff ff ff 25 	cmpl   $0x25,-0xc0(%rbp)
 5c8:	0f 85 32 02 00 00    	jne    800 <printf+0x33f>
      if(c == 'd'){
 5ce:	83 bd 3c ff ff ff 64 	cmpl   $0x64,-0xc4(%rbp)
 5d5:	75 5e                	jne    635 <printf+0x174>
        printint(fd, va_arg(ap, int), 10, 1);
 5d7:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 5dd:	83 f8 2f             	cmp    $0x2f,%eax
 5e0:	77 23                	ja     605 <printf+0x144>
 5e2:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 5e9:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 5ef:	89 d2                	mov    %edx,%edx
 5f1:	48 01 d0             	add    %rdx,%rax
 5f4:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 5fa:	83 c2 08             	add    $0x8,%edx
 5fd:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 603:	eb 12                	jmp    617 <printf+0x156>
 605:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 60c:	48 8d 50 08          	lea    0x8(%rax),%rdx
 610:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 617:	8b 30                	mov    (%rax),%esi
 619:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 61f:	b9 01 00 00 00       	mov    $0x1,%ecx
 624:	ba 0a 00 00 00       	mov    $0xa,%edx
 629:	89 c7                	mov    %eax,%edi
 62b:	e8 d0 fd ff ff       	call   400 <printint>
 630:	e9 c1 01 00 00       	jmp    7f6 <printf+0x335>
      } else if(c == 'x' || c == 'p'){
 635:	83 bd 3c ff ff ff 78 	cmpl   $0x78,-0xc4(%rbp)
 63c:	74 09                	je     647 <printf+0x186>
 63e:	83 bd 3c ff ff ff 70 	cmpl   $0x70,-0xc4(%rbp)
 645:	75 5e                	jne    6a5 <printf+0x1e4>
        printint(fd, va_arg(ap, int), 16, 0);
 647:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 64d:	83 f8 2f             	cmp    $0x2f,%eax
 650:	77 23                	ja     675 <printf+0x1b4>
 652:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 659:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 65f:	89 d2                	mov    %edx,%edx
 661:	48 01 d0             	add    %rdx,%rax
 664:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 66a:	83 c2 08             	add    $0x8,%edx
 66d:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 673:	eb 12                	jmp    687 <printf+0x1c6>
 675:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 67c:	48 8d 50 08          	lea    0x8(%rax),%rdx
 680:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 687:	8b 30                	mov    (%rax),%esi
 689:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 68f:	b9 00 00 00 00       	mov    $0x0,%ecx
 694:	ba 10 00 00 00       	mov    $0x10,%edx
 699:	89 c7                	mov    %eax,%edi
 69b:	e8 60 fd ff ff       	call   400 <printint>
 6a0:	e9 51 01 00 00       	jmp    7f6 <printf+0x335>
      } else if(c == 's'){
 6a5:	83 bd 3c ff ff ff 73 	cmpl   $0x73,-0xc4(%rbp)
 6ac:	0f 85 98 00 00 00    	jne    74a <printf+0x289>
        s = va_arg(ap, char*);
 6b2:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 6b8:	83 f8 2f             	cmp    $0x2f,%eax
 6bb:	77 23                	ja     6e0 <printf+0x21f>
 6bd:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 6c4:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 6ca:	89 d2                	mov    %edx,%edx
 6cc:	48 01 d0             	add    %rdx,%rax
 6cf:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 6d5:	83 c2 08             	add    $0x8,%edx
 6d8:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 6de:	eb 12                	jmp    6f2 <printf+0x231>
 6e0:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 6e7:	48 8d 50 08          	lea    0x8(%rax),%rdx
 6eb:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 6f2:	48 8b 00             	mov    (%rax),%rax
 6f5:	48 89 85 48 ff ff ff 	mov    %rax,-0xb8(%rbp)
        if(s == 0)
 6fc:	48 83 bd 48 ff ff ff 	cmpq   $0x0,-0xb8(%rbp)
 703:	00 
 704:	75 31                	jne    737 <printf+0x276>
          s = "(null)";
 706:	48 c7 85 48 ff ff ff 	movq   $0xcb3,-0xb8(%rbp)
 70d:	b3 0c 00 00 
        while(*s != 0){
 711:	eb 24                	jmp    737 <printf+0x276>
          putc(fd, *s);
 713:	48 8b 85 48 ff ff ff 	mov    -0xb8(%rbp),%rax
 71a:	0f b6 00             	movzbl (%rax),%eax
 71d:	0f be d0             	movsbl %al,%edx
 720:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 726:	89 d6                	mov    %edx,%esi
 728:	89 c7                	mov    %eax,%edi
 72a:	e8 a8 fc ff ff       	call   3d7 <putc>
          s++;
 72f:	48 83 85 48 ff ff ff 	addq   $0x1,-0xb8(%rbp)
 736:	01 
        while(*s != 0){
 737:	48 8b 85 48 ff ff ff 	mov    -0xb8(%rbp),%rax
 73e:	0f b6 00             	movzbl (%rax),%eax
 741:	84 c0                	test   %al,%al
 743:	75 ce                	jne    713 <printf+0x252>
 745:	e9 ac 00 00 00       	jmp    7f6 <printf+0x335>
        }
      } else if(c == 'c'){
 74a:	83 bd 3c ff ff ff 63 	cmpl   $0x63,-0xc4(%rbp)
 751:	75 56                	jne    7a9 <printf+0x2e8>
        putc(fd, va_arg(ap, uint));
 753:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 759:	83 f8 2f             	cmp    $0x2f,%eax
 75c:	77 23                	ja     781 <printf+0x2c0>
 75e:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 765:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 76b:	89 d2                	mov    %edx,%edx
 76d:	48 01 d0             	add    %rdx,%rax
 770:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 776:	83 c2 08             	add    $0x8,%edx
 779:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 77f:	eb 12                	jmp    793 <printf+0x2d2>
 781:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 788:	48 8d 50 08          	lea    0x8(%rax),%rdx
 78c:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 793:	8b 00                	mov    (%rax),%eax
 795:	0f be d0             	movsbl %al,%edx
 798:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 79e:	89 d6                	mov    %edx,%esi
 7a0:	89 c7                	mov    %eax,%edi
 7a2:	e8 30 fc ff ff       	call   3d7 <putc>
 7a7:	eb 4d                	jmp    7f6 <printf+0x335>
      } else if(c == '%'){
 7a9:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
 7b0:	75 1a                	jne    7cc <printf+0x30b>
        putc(fd, c);
 7b2:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
 7b8:	0f be d0             	movsbl %al,%edx
 7bb:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 7c1:	89 d6                	mov    %edx,%esi
 7c3:	89 c7                	mov    %eax,%edi
 7c5:	e8 0d fc ff ff       	call   3d7 <putc>
 7ca:	eb 2a                	jmp    7f6 <printf+0x335>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 7cc:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 7d2:	be 25 00 00 00       	mov    $0x25,%esi
 7d7:	89 c7                	mov    %eax,%edi
 7d9:	e8 f9 fb ff ff       	call   3d7 <putc>
        putc(fd, c);
 7de:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
 7e4:	0f be d0             	movsbl %al,%edx
 7e7:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 7ed:	89 d6                	mov    %edx,%esi
 7ef:	89 c7                	mov    %eax,%edi
 7f1:	e8 e1 fb ff ff       	call   3d7 <putc>
      }
      state = 0;
 7f6:	c7 85 40 ff ff ff 00 	movl   $0x0,-0xc0(%rbp)
 7fd:	00 00 00 
  for(i = 0; fmt[i]; i++){
 800:	83 85 44 ff ff ff 01 	addl   $0x1,-0xbc(%rbp)
 807:	8b 85 44 ff ff ff    	mov    -0xbc(%rbp),%eax
 80d:	48 63 d0             	movslq %eax,%rdx
 810:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
 817:	48 01 d0             	add    %rdx,%rax
 81a:	0f b6 00             	movzbl (%rax),%eax
 81d:	84 c0                	test   %al,%al
 81f:	0f 85 3a fd ff ff    	jne    55f <printf+0x9e>
    }
  }
}
 825:	90                   	nop
 826:	90                   	nop
 827:	c9                   	leave
 828:	c3                   	ret

0000000000000829 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 829:	55                   	push   %rbp
 82a:	48 89 e5             	mov    %rsp,%rbp
 82d:	48 83 ec 18          	sub    $0x18,%rsp
 831:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  Header *bp, *p;

  bp = (Header*)ap - 1;
 835:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 839:	48 83 e8 10          	sub    $0x10,%rax
 83d:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 841:	48 8b 05 88 07 00 00 	mov    0x788(%rip),%rax        # fd0 <freep>
 848:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 84c:	eb 2f                	jmp    87d <free+0x54>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 84e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 852:	48 8b 00             	mov    (%rax),%rax
 855:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 859:	72 17                	jb     872 <free+0x49>
 85b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 85f:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 863:	72 2f                	jb     894 <free+0x6b>
 865:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 869:	48 8b 00             	mov    (%rax),%rax
 86c:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
 870:	72 22                	jb     894 <free+0x6b>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 872:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 876:	48 8b 00             	mov    (%rax),%rax
 879:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 87d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 881:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 885:	73 c7                	jae    84e <free+0x25>
 887:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 88b:	48 8b 00             	mov    (%rax),%rax
 88e:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
 892:	73 ba                	jae    84e <free+0x25>
      break;
  if(bp + bp->s.size == p->s.ptr){
 894:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 898:	8b 40 08             	mov    0x8(%rax),%eax
 89b:	89 c0                	mov    %eax,%eax
 89d:	48 c1 e0 04          	shl    $0x4,%rax
 8a1:	48 89 c2             	mov    %rax,%rdx
 8a4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 8a8:	48 01 c2             	add    %rax,%rdx
 8ab:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 8af:	48 8b 00             	mov    (%rax),%rax
 8b2:	48 39 c2             	cmp    %rax,%rdx
 8b5:	75 2d                	jne    8e4 <free+0xbb>
    bp->s.size += p->s.ptr->s.size;
 8b7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 8bb:	8b 50 08             	mov    0x8(%rax),%edx
 8be:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 8c2:	48 8b 00             	mov    (%rax),%rax
 8c5:	8b 40 08             	mov    0x8(%rax),%eax
 8c8:	01 c2                	add    %eax,%edx
 8ca:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 8ce:	89 50 08             	mov    %edx,0x8(%rax)
    bp->s.ptr = p->s.ptr->s.ptr;
 8d1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 8d5:	48 8b 00             	mov    (%rax),%rax
 8d8:	48 8b 10             	mov    (%rax),%rdx
 8db:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 8df:	48 89 10             	mov    %rdx,(%rax)
 8e2:	eb 0e                	jmp    8f2 <free+0xc9>
  } else
    bp->s.ptr = p->s.ptr;
 8e4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 8e8:	48 8b 10             	mov    (%rax),%rdx
 8eb:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 8ef:	48 89 10             	mov    %rdx,(%rax)
  if(p + p->s.size == bp){
 8f2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 8f6:	8b 40 08             	mov    0x8(%rax),%eax
 8f9:	89 c0                	mov    %eax,%eax
 8fb:	48 c1 e0 04          	shl    $0x4,%rax
 8ff:	48 89 c2             	mov    %rax,%rdx
 902:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 906:	48 01 d0             	add    %rdx,%rax
 909:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
 90d:	75 27                	jne    936 <free+0x10d>
    p->s.size += bp->s.size;
 90f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 913:	8b 50 08             	mov    0x8(%rax),%edx
 916:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 91a:	8b 40 08             	mov    0x8(%rax),%eax
 91d:	01 c2                	add    %eax,%edx
 91f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 923:	89 50 08             	mov    %edx,0x8(%rax)
    p->s.ptr = bp->s.ptr;
 926:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 92a:	48 8b 10             	mov    (%rax),%rdx
 92d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 931:	48 89 10             	mov    %rdx,(%rax)
 934:	eb 0b                	jmp    941 <free+0x118>
  } else
    p->s.ptr = bp;
 936:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 93a:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
 93e:	48 89 10             	mov    %rdx,(%rax)
  freep = p;
 941:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 945:	48 89 05 84 06 00 00 	mov    %rax,0x684(%rip)        # fd0 <freep>
}
 94c:	90                   	nop
 94d:	c9                   	leave
 94e:	c3                   	ret

000000000000094f <morecore>:

static Header*
morecore(uint nu)
{
 94f:	55                   	push   %rbp
 950:	48 89 e5             	mov    %rsp,%rbp
 953:	48 83 ec 20          	sub    $0x20,%rsp
 957:	89 7d ec             	mov    %edi,-0x14(%rbp)
  char *p;
  Header *hp;

  if(nu < 4096)
 95a:	81 7d ec ff 0f 00 00 	cmpl   $0xfff,-0x14(%rbp)
 961:	77 07                	ja     96a <morecore+0x1b>
    nu = 4096;
 963:	c7 45 ec 00 10 00 00 	movl   $0x1000,-0x14(%rbp)
  p = sbrk(nu * sizeof(Header));
 96a:	8b 45 ec             	mov    -0x14(%rbp),%eax
 96d:	c1 e0 04             	shl    $0x4,%eax
 970:	89 c7                	mov    %eax,%edi
 972:	e8 20 fa ff ff       	call   397 <sbrk>
 977:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  if(p == (char*)-1)
 97b:	48 83 7d f8 ff       	cmpq   $0xffffffffffffffff,-0x8(%rbp)
 980:	75 07                	jne    989 <morecore+0x3a>
    return 0;
 982:	b8 00 00 00 00       	mov    $0x0,%eax
 987:	eb 29                	jmp    9b2 <morecore+0x63>
  hp = (Header*)p;
 989:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 98d:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  hp->s.size = nu;
 991:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 995:	8b 55 ec             	mov    -0x14(%rbp),%edx
 998:	89 50 08             	mov    %edx,0x8(%rax)
  free((void*)(hp + 1));
 99b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 99f:	48 83 c0 10          	add    $0x10,%rax
 9a3:	48 89 c7             	mov    %rax,%rdi
 9a6:	e8 7e fe ff ff       	call   829 <free>
  return freep;
 9ab:	48 8b 05 1e 06 00 00 	mov    0x61e(%rip),%rax        # fd0 <freep>
}
 9b2:	c9                   	leave
 9b3:	c3                   	ret

00000000000009b4 <malloc>:

void*
malloc(uint nbytes)
{
 9b4:	55                   	push   %rbp
 9b5:	48 89 e5             	mov    %rsp,%rbp
 9b8:	48 83 ec 30          	sub    $0x30,%rsp
 9bc:	89 7d dc             	mov    %edi,-0x24(%rbp)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 9bf:	8b 45 dc             	mov    -0x24(%rbp),%eax
 9c2:	48 83 c0 0f          	add    $0xf,%rax
 9c6:	48 c1 e8 04          	shr    $0x4,%rax
 9ca:	83 c0 01             	add    $0x1,%eax
 9cd:	89 45 ec             	mov    %eax,-0x14(%rbp)
  if((prevp = freep) == 0){
 9d0:	48 8b 05 f9 05 00 00 	mov    0x5f9(%rip),%rax        # fd0 <freep>
 9d7:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
 9db:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
 9e0:	75 2b                	jne    a0d <malloc+0x59>
    base.s.ptr = freep = prevp = &base;
 9e2:	48 c7 45 f0 c0 0f 00 	movq   $0xfc0,-0x10(%rbp)
 9e9:	00 
 9ea:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 9ee:	48 89 05 db 05 00 00 	mov    %rax,0x5db(%rip)        # fd0 <freep>
 9f5:	48 8b 05 d4 05 00 00 	mov    0x5d4(%rip),%rax        # fd0 <freep>
 9fc:	48 89 05 bd 05 00 00 	mov    %rax,0x5bd(%rip)        # fc0 <base>
    base.s.size = 0;
 a03:	c7 05 bb 05 00 00 00 	movl   $0x0,0x5bb(%rip)        # fc8 <base+0x8>
 a0a:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a0d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 a11:	48 8b 00             	mov    (%rax),%rax
 a14:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
 a18:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a1c:	8b 40 08             	mov    0x8(%rax),%eax
 a1f:	3b 45 ec             	cmp    -0x14(%rbp),%eax
 a22:	72 5f                	jb     a83 <malloc+0xcf>
      if(p->s.size == nunits)
 a24:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a28:	8b 40 08             	mov    0x8(%rax),%eax
 a2b:	39 45 ec             	cmp    %eax,-0x14(%rbp)
 a2e:	75 10                	jne    a40 <malloc+0x8c>
        prevp->s.ptr = p->s.ptr;
 a30:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a34:	48 8b 10             	mov    (%rax),%rdx
 a37:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 a3b:	48 89 10             	mov    %rdx,(%rax)
 a3e:	eb 2e                	jmp    a6e <malloc+0xba>
      else {
        p->s.size -= nunits;
 a40:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a44:	8b 40 08             	mov    0x8(%rax),%eax
 a47:	2b 45 ec             	sub    -0x14(%rbp),%eax
 a4a:	89 c2                	mov    %eax,%edx
 a4c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a50:	89 50 08             	mov    %edx,0x8(%rax)
        p += p->s.size;
 a53:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a57:	8b 40 08             	mov    0x8(%rax),%eax
 a5a:	89 c0                	mov    %eax,%eax
 a5c:	48 c1 e0 04          	shl    $0x4,%rax
 a60:	48 01 45 f8          	add    %rax,-0x8(%rbp)
        p->s.size = nunits;
 a64:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a68:	8b 55 ec             	mov    -0x14(%rbp),%edx
 a6b:	89 50 08             	mov    %edx,0x8(%rax)
      }
      freep = prevp;
 a6e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 a72:	48 89 05 57 05 00 00 	mov    %rax,0x557(%rip)        # fd0 <freep>
      return (void*)(p + 1);
 a79:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a7d:	48 83 c0 10          	add    $0x10,%rax
 a81:	eb 41                	jmp    ac4 <malloc+0x110>
    }
    if(p == freep)
 a83:	48 8b 05 46 05 00 00 	mov    0x546(%rip),%rax        # fd0 <freep>
 a8a:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 a8e:	75 1c                	jne    aac <malloc+0xf8>
      if((p = morecore(nunits)) == 0)
 a90:	8b 45 ec             	mov    -0x14(%rbp),%eax
 a93:	89 c7                	mov    %eax,%edi
 a95:	e8 b5 fe ff ff       	call   94f <morecore>
 a9a:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 a9e:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
 aa3:	75 07                	jne    aac <malloc+0xf8>
        return 0;
 aa5:	b8 00 00 00 00       	mov    $0x0,%eax
 aaa:	eb 18                	jmp    ac4 <malloc+0x110>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 aac:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 ab0:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
 ab4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 ab8:	48 8b 00             	mov    (%rax),%rax
 abb:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
 abf:	e9 54 ff ff ff       	jmp    a18 <malloc+0x64>
  }
}
 ac4:	c9                   	leave
 ac5:	c3                   	ret

0000000000000ac6 <createRoot>:
#include "set.h"
#include "user.h"

//TODO: Να μην είναι περιορισμένο σε int

Set* createRoot(){
 ac6:	55                   	push   %rbp
 ac7:	48 89 e5             	mov    %rsp,%rbp
 aca:	48 83 ec 10          	sub    $0x10,%rsp
    //Αρχικοποίηση του Set
    Set *set = malloc(sizeof(Set));
 ace:	bf 10 00 00 00       	mov    $0x10,%edi
 ad3:	e8 dc fe ff ff       	call   9b4 <malloc>
 ad8:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    set->size = 0;
 adc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 ae0:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%rax)
    set->root = NULL;
 ae7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 aeb:	48 c7 00 00 00 00 00 	movq   $0x0,(%rax)
    return set;
 af2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
 af6:	c9                   	leave
 af7:	c3                   	ret

0000000000000af8 <createNode>:

void createNode(int i, Set *set){
 af8:	55                   	push   %rbp
 af9:	48 89 e5             	mov    %rsp,%rbp
 afc:	48 83 ec 20          	sub    $0x20,%rsp
 b00:	89 7d ec             	mov    %edi,-0x14(%rbp)
 b03:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    Η συνάρτηση αυτή δημιουργεί ένα νέο SetNode με την τιμή i και εφόσον δεν υπάρχει στο Set το προσθέτει στο τέλος του συνόλου.
    Σημείωση: Ίσως υπάρχει καλύτερος τρόπος για την υλοποίηση.
    */

    //Αρχικοποίηση του SetNode
    SetNode *temp = malloc(sizeof(SetNode));
 b07:	bf 10 00 00 00       	mov    $0x10,%edi
 b0c:	e8 a3 fe ff ff       	call   9b4 <malloc>
 b11:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    temp->i = i;
 b15:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 b19:	8b 55 ec             	mov    -0x14(%rbp),%edx
 b1c:	89 10                	mov    %edx,(%rax)
    temp->next = NULL;
 b1e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 b22:	48 c7 40 08 00 00 00 	movq   $0x0,0x8(%rax)
 b29:	00 

    //Έλεγχος ύπαρξης του i
    SetNode *curr = set->root;//Ξεκινάει από την root
 b2a:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
 b2e:	48 8b 00             	mov    (%rax),%rax
 b31:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(curr != NULL) { //Εφόσον το Set δεν είναι άδειο
 b35:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
 b3a:	74 34                	je     b70 <createNode+0x78>
        while (curr->next != NULL){ //Εφόσον υπάρχει επόμενο node
 b3c:	eb 25                	jmp    b63 <createNode+0x6b>
            if (curr->i == i){ //Αν το i υπάρχει στο σύνολο
 b3e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b42:	8b 00                	mov    (%rax),%eax
 b44:	39 45 ec             	cmp    %eax,-0x14(%rbp)
 b47:	75 0e                	jne    b57 <createNode+0x5f>
                free(temp); 
 b49:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 b4d:	48 89 c7             	mov    %rax,%rdi
 b50:	e8 d4 fc ff ff       	call   829 <free>
                return; //Δεν εκτελούμε την υπόλοιπη συνάρτηση
 b55:	eb 4e                	jmp    ba5 <createNode+0xad>
            }
            curr = curr->next; //Επόμενο SetNode
 b57:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b5b:	48 8b 40 08          	mov    0x8(%rax),%rax
 b5f:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
        while (curr->next != NULL){ //Εφόσον υπάρχει επόμενο node
 b63:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b67:	48 8b 40 08          	mov    0x8(%rax),%rax
 b6b:	48 85 c0             	test   %rax,%rax
 b6e:	75 ce                	jne    b3e <createNode+0x46>
        }
    }
    /*
    Ο έλεγχος στην if είναι απαραίτητος για να ελεγχθεί το τελευταίο SetNode.
    */
    if (curr->i != i) attachNode(set, curr, temp); 
 b70:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b74:	8b 00                	mov    (%rax),%eax
 b76:	39 45 ec             	cmp    %eax,-0x14(%rbp)
 b79:	74 1e                	je     b99 <createNode+0xa1>
 b7b:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
 b7f:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
 b83:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
 b87:	48 89 ce             	mov    %rcx,%rsi
 b8a:	48 89 c7             	mov    %rax,%rdi
 b8d:	b8 00 00 00 00       	mov    $0x0,%eax
 b92:	e8 10 00 00 00       	call   ba7 <attachNode>
 b97:	eb 0c                	jmp    ba5 <createNode+0xad>
    else free(temp);
 b99:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 b9d:	48 89 c7             	mov    %rax,%rdi
 ba0:	e8 84 fc ff ff       	call   829 <free>
}
 ba5:	c9                   	leave
 ba6:	c3                   	ret

0000000000000ba7 <attachNode>:

void attachNode(Set *set, SetNode *curr, SetNode *temp){
 ba7:	55                   	push   %rbp
 ba8:	48 89 e5             	mov    %rsp,%rbp
 bab:	48 83 ec 18          	sub    $0x18,%rsp
 baf:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
 bb3:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
 bb7:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
    //Βάζουμε το temp στο τέλος του Set
    if(set->size == 0) set->root = temp;
 bbb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 bbf:	8b 40 08             	mov    0x8(%rax),%eax
 bc2:	85 c0                	test   %eax,%eax
 bc4:	75 0d                	jne    bd3 <attachNode+0x2c>
 bc6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 bca:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
 bce:	48 89 10             	mov    %rdx,(%rax)
 bd1:	eb 0c                	jmp    bdf <attachNode+0x38>
    else curr->next = temp;
 bd3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 bd7:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
 bdb:	48 89 50 08          	mov    %rdx,0x8(%rax)
    set->size += 1;
 bdf:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 be3:	8b 40 08             	mov    0x8(%rax),%eax
 be6:	8d 50 01             	lea    0x1(%rax),%edx
 be9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 bed:	89 50 08             	mov    %edx,0x8(%rax)
}
 bf0:	90                   	nop
 bf1:	c9                   	leave
 bf2:	c3                   	ret

0000000000000bf3 <deleteSet>:

void deleteSet(Set *set){
 bf3:	55                   	push   %rbp
 bf4:	48 89 e5             	mov    %rsp,%rbp
 bf7:	48 83 ec 20          	sub    $0x20,%rsp
 bfb:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    if (set == NULL) return; //Αν ο χρήστης είναι ΜΛΚ!
 bff:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
 c04:	74 42                	je     c48 <deleteSet+0x55>
    SetNode *temp;
    SetNode *curr = set->root; //Ξεκινάμε από το root
 c06:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 c0a:	48 8b 00             	mov    (%rax),%rax
 c0d:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    while (curr != NULL){ 
 c11:	eb 20                	jmp    c33 <deleteSet+0x40>
        temp = curr->next; //Αναφορά στο επόμενο SetNode
 c13:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 c17:	48 8b 40 08          	mov    0x8(%rax),%rax
 c1b:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
        free(curr); //Απελευθέρωση της curr
 c1f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 c23:	48 89 c7             	mov    %rax,%rdi
 c26:	e8 fe fb ff ff       	call   829 <free>
        curr = temp;
 c2b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 c2f:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    while (curr != NULL){ 
 c33:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
 c38:	75 d9                	jne    c13 <deleteSet+0x20>
    }
    free(set); //Διαγραφή του Set
 c3a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 c3e:	48 89 c7             	mov    %rax,%rdi
 c41:	e8 e3 fb ff ff       	call   829 <free>
 c46:	eb 01                	jmp    c49 <deleteSet+0x56>
    if (set == NULL) return; //Αν ο χρήστης είναι ΜΛΚ!
 c48:	90                   	nop
}
 c49:	c9                   	leave
 c4a:	c3                   	ret

0000000000000c4b <getNodeAtPosition>:

SetNode* getNodeAtPosition(Set *set, int i){
 c4b:	55                   	push   %rbp
 c4c:	48 89 e5             	mov    %rsp,%rbp
 c4f:	48 83 ec 20          	sub    $0x20,%rsp
 c53:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
 c57:	89 75 e4             	mov    %esi,-0x1c(%rbp)
    if (set == NULL || set->root == NULL) return NULL; //Αν ο χρήστης είναι ΜΛΚ!
 c5a:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
 c5f:	74 0c                	je     c6d <getNodeAtPosition+0x22>
 c61:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 c65:	48 8b 00             	mov    (%rax),%rax
 c68:	48 85 c0             	test   %rax,%rax
 c6b:	75 07                	jne    c74 <getNodeAtPosition+0x29>
 c6d:	b8 00 00 00 00       	mov    $0x0,%eax
 c72:	eb 3d                	jmp    cb1 <getNodeAtPosition+0x66>

    SetNode *curr = set->root;
 c74:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 c78:	48 8b 00             	mov    (%rax),%rax
 c7b:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    int n;

    for(n = 0; n<i && curr->next != NULL; n++) curr = curr->next; //Ο έλεγχος εδω είναι: n<i && curr->next != NULL
 c7f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
 c86:	eb 10                	jmp    c98 <getNodeAtPosition+0x4d>
 c88:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 c8c:	48 8b 40 08          	mov    0x8(%rax),%rax
 c90:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 c94:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
 c98:	8b 45 f4             	mov    -0xc(%rbp),%eax
 c9b:	3b 45 e4             	cmp    -0x1c(%rbp),%eax
 c9e:	7d 0d                	jge    cad <getNodeAtPosition+0x62>
 ca0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 ca4:	48 8b 40 08          	mov    0x8(%rax),%rax
 ca8:	48 85 c0             	test   %rax,%rax
 cab:	75 db                	jne    c88 <getNodeAtPosition+0x3d>
    return curr;
 cad:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 cb1:	c9                   	leave
 cb2:	c3                   	ret
