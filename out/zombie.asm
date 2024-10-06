
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

00000000000003b7 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 3b7:	55                   	push   %rbp
 3b8:	48 89 e5             	mov    %rsp,%rbp
 3bb:	48 83 ec 10          	sub    $0x10,%rsp
 3bf:	89 7d fc             	mov    %edi,-0x4(%rbp)
 3c2:	89 f0                	mov    %esi,%eax
 3c4:	88 45 f8             	mov    %al,-0x8(%rbp)
  write(fd, &c, 1);
 3c7:	48 8d 4d f8          	lea    -0x8(%rbp),%rcx
 3cb:	8b 45 fc             	mov    -0x4(%rbp),%eax
 3ce:	ba 01 00 00 00       	mov    $0x1,%edx
 3d3:	48 89 ce             	mov    %rcx,%rsi
 3d6:	89 c7                	mov    %eax,%edi
 3d8:	e8 52 ff ff ff       	call   32f <write>
}
 3dd:	90                   	nop
 3de:	c9                   	leave
 3df:	c3                   	ret

00000000000003e0 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 3e0:	55                   	push   %rbp
 3e1:	48 89 e5             	mov    %rsp,%rbp
 3e4:	48 83 ec 30          	sub    $0x30,%rsp
 3e8:	89 7d dc             	mov    %edi,-0x24(%rbp)
 3eb:	89 75 d8             	mov    %esi,-0x28(%rbp)
 3ee:	89 55 d4             	mov    %edx,-0x2c(%rbp)
 3f1:	89 4d d0             	mov    %ecx,-0x30(%rbp)
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 3f4:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
  if(sgn && xx < 0){
 3fb:	83 7d d0 00          	cmpl   $0x0,-0x30(%rbp)
 3ff:	74 17                	je     418 <printint+0x38>
 401:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
 405:	79 11                	jns    418 <printint+0x38>
    neg = 1;
 407:	c7 45 f8 01 00 00 00 	movl   $0x1,-0x8(%rbp)
    x = -xx;
 40e:	8b 45 d8             	mov    -0x28(%rbp),%eax
 411:	f7 d8                	neg    %eax
 413:	89 45 f4             	mov    %eax,-0xc(%rbp)
 416:	eb 06                	jmp    41e <printint+0x3e>
  } else {
    x = xx;
 418:	8b 45 d8             	mov    -0x28(%rbp),%eax
 41b:	89 45 f4             	mov    %eax,-0xc(%rbp)
  }

  i = 0;
 41e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  do{
    buf[i++] = digits[x % base];
 425:	8b 4d d4             	mov    -0x2c(%rbp),%ecx
 428:	8b 45 f4             	mov    -0xc(%rbp),%eax
 42b:	ba 00 00 00 00       	mov    $0x0,%edx
 430:	f7 f1                	div    %ecx
 432:	89 d1                	mov    %edx,%ecx
 434:	8b 45 fc             	mov    -0x4(%rbp),%eax
 437:	8d 50 01             	lea    0x1(%rax),%edx
 43a:	89 55 fc             	mov    %edx,-0x4(%rbp)
 43d:	89 ca                	mov    %ecx,%edx
 43f:	0f b6 92 f0 0c 00 00 	movzbl 0xcf0(%rdx),%edx
 446:	48 98                	cltq
 448:	88 54 05 e0          	mov    %dl,-0x20(%rbp,%rax,1)
  }while((x /= base) != 0);
 44c:	8b 75 d4             	mov    -0x2c(%rbp),%esi
 44f:	8b 45 f4             	mov    -0xc(%rbp),%eax
 452:	ba 00 00 00 00       	mov    $0x0,%edx
 457:	f7 f6                	div    %esi
 459:	89 45 f4             	mov    %eax,-0xc(%rbp)
 45c:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
 460:	75 c3                	jne    425 <printint+0x45>
  if(neg)
 462:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
 466:	74 2b                	je     493 <printint+0xb3>
    buf[i++] = '-';
 468:	8b 45 fc             	mov    -0x4(%rbp),%eax
 46b:	8d 50 01             	lea    0x1(%rax),%edx
 46e:	89 55 fc             	mov    %edx,-0x4(%rbp)
 471:	48 98                	cltq
 473:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%rbp,%rax,1)

  while(--i >= 0)
 478:	eb 19                	jmp    493 <printint+0xb3>
    putc(fd, buf[i]);
 47a:	8b 45 fc             	mov    -0x4(%rbp),%eax
 47d:	48 98                	cltq
 47f:	0f b6 44 05 e0       	movzbl -0x20(%rbp,%rax,1),%eax
 484:	0f be d0             	movsbl %al,%edx
 487:	8b 45 dc             	mov    -0x24(%rbp),%eax
 48a:	89 d6                	mov    %edx,%esi
 48c:	89 c7                	mov    %eax,%edi
 48e:	e8 24 ff ff ff       	call   3b7 <putc>
  while(--i >= 0)
 493:	83 6d fc 01          	subl   $0x1,-0x4(%rbp)
 497:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
 49b:	79 dd                	jns    47a <printint+0x9a>
}
 49d:	90                   	nop
 49e:	90                   	nop
 49f:	c9                   	leave
 4a0:	c3                   	ret

00000000000004a1 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 4a1:	55                   	push   %rbp
 4a2:	48 89 e5             	mov    %rsp,%rbp
 4a5:	48 81 ec f0 00 00 00 	sub    $0xf0,%rsp
 4ac:	89 bd 1c ff ff ff    	mov    %edi,-0xe4(%rbp)
 4b2:	48 89 b5 10 ff ff ff 	mov    %rsi,-0xf0(%rbp)
 4b9:	48 89 95 60 ff ff ff 	mov    %rdx,-0xa0(%rbp)
 4c0:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
 4c7:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
 4ce:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
 4d5:	84 c0                	test   %al,%al
 4d7:	74 20                	je     4f9 <printf+0x58>
 4d9:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
 4dd:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
 4e1:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
 4e5:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
 4e9:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
 4ed:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
 4f1:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
 4f5:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  va_list ap;
  char *s;
  int c, i, state;
  va_start(ap, fmt);
 4f9:	c7 85 20 ff ff ff 10 	movl   $0x10,-0xe0(%rbp)
 500:	00 00 00 
 503:	c7 85 24 ff ff ff 30 	movl   $0x30,-0xdc(%rbp)
 50a:	00 00 00 
 50d:	48 8d 45 10          	lea    0x10(%rbp),%rax
 511:	48 89 85 28 ff ff ff 	mov    %rax,-0xd8(%rbp)
 518:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
 51f:	48 89 85 30 ff ff ff 	mov    %rax,-0xd0(%rbp)

  state = 0;
 526:	c7 85 40 ff ff ff 00 	movl   $0x0,-0xc0(%rbp)
 52d:	00 00 00 
  for(i = 0; fmt[i]; i++){
 530:	c7 85 44 ff ff ff 00 	movl   $0x0,-0xbc(%rbp)
 537:	00 00 00 
 53a:	e9 a8 02 00 00       	jmp    7e7 <printf+0x346>
    c = fmt[i] & 0xff;
 53f:	8b 85 44 ff ff ff    	mov    -0xbc(%rbp),%eax
 545:	48 63 d0             	movslq %eax,%rdx
 548:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
 54f:	48 01 d0             	add    %rdx,%rax
 552:	0f b6 00             	movzbl (%rax),%eax
 555:	0f be c0             	movsbl %al,%eax
 558:	25 ff 00 00 00       	and    $0xff,%eax
 55d:	89 85 3c ff ff ff    	mov    %eax,-0xc4(%rbp)
    if(state == 0){
 563:	83 bd 40 ff ff ff 00 	cmpl   $0x0,-0xc0(%rbp)
 56a:	75 35                	jne    5a1 <printf+0x100>
      if(c == '%'){
 56c:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
 573:	75 0f                	jne    584 <printf+0xe3>
        state = '%';
 575:	c7 85 40 ff ff ff 25 	movl   $0x25,-0xc0(%rbp)
 57c:	00 00 00 
 57f:	e9 5c 02 00 00       	jmp    7e0 <printf+0x33f>
      } else {
        putc(fd, c);
 584:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
 58a:	0f be d0             	movsbl %al,%edx
 58d:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 593:	89 d6                	mov    %edx,%esi
 595:	89 c7                	mov    %eax,%edi
 597:	e8 1b fe ff ff       	call   3b7 <putc>
 59c:	e9 3f 02 00 00       	jmp    7e0 <printf+0x33f>
      }
    } else if(state == '%'){
 5a1:	83 bd 40 ff ff ff 25 	cmpl   $0x25,-0xc0(%rbp)
 5a8:	0f 85 32 02 00 00    	jne    7e0 <printf+0x33f>
      if(c == 'd'){
 5ae:	83 bd 3c ff ff ff 64 	cmpl   $0x64,-0xc4(%rbp)
 5b5:	75 5e                	jne    615 <printf+0x174>
        printint(fd, va_arg(ap, int), 10, 1);
 5b7:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 5bd:	83 f8 2f             	cmp    $0x2f,%eax
 5c0:	77 23                	ja     5e5 <printf+0x144>
 5c2:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 5c9:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 5cf:	89 d2                	mov    %edx,%edx
 5d1:	48 01 d0             	add    %rdx,%rax
 5d4:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 5da:	83 c2 08             	add    $0x8,%edx
 5dd:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 5e3:	eb 12                	jmp    5f7 <printf+0x156>
 5e5:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 5ec:	48 8d 50 08          	lea    0x8(%rax),%rdx
 5f0:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 5f7:	8b 30                	mov    (%rax),%esi
 5f9:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 5ff:	b9 01 00 00 00       	mov    $0x1,%ecx
 604:	ba 0a 00 00 00       	mov    $0xa,%edx
 609:	89 c7                	mov    %eax,%edi
 60b:	e8 d0 fd ff ff       	call   3e0 <printint>
 610:	e9 c1 01 00 00       	jmp    7d6 <printf+0x335>
      } else if(c == 'x' || c == 'p'){
 615:	83 bd 3c ff ff ff 78 	cmpl   $0x78,-0xc4(%rbp)
 61c:	74 09                	je     627 <printf+0x186>
 61e:	83 bd 3c ff ff ff 70 	cmpl   $0x70,-0xc4(%rbp)
 625:	75 5e                	jne    685 <printf+0x1e4>
        printint(fd, va_arg(ap, int), 16, 0);
 627:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 62d:	83 f8 2f             	cmp    $0x2f,%eax
 630:	77 23                	ja     655 <printf+0x1b4>
 632:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 639:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 63f:	89 d2                	mov    %edx,%edx
 641:	48 01 d0             	add    %rdx,%rax
 644:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 64a:	83 c2 08             	add    $0x8,%edx
 64d:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 653:	eb 12                	jmp    667 <printf+0x1c6>
 655:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 65c:	48 8d 50 08          	lea    0x8(%rax),%rdx
 660:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 667:	8b 30                	mov    (%rax),%esi
 669:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 66f:	b9 00 00 00 00       	mov    $0x0,%ecx
 674:	ba 10 00 00 00       	mov    $0x10,%edx
 679:	89 c7                	mov    %eax,%edi
 67b:	e8 60 fd ff ff       	call   3e0 <printint>
 680:	e9 51 01 00 00       	jmp    7d6 <printf+0x335>
      } else if(c == 's'){
 685:	83 bd 3c ff ff ff 73 	cmpl   $0x73,-0xc4(%rbp)
 68c:	0f 85 98 00 00 00    	jne    72a <printf+0x289>
        s = va_arg(ap, char*);
 692:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 698:	83 f8 2f             	cmp    $0x2f,%eax
 69b:	77 23                	ja     6c0 <printf+0x21f>
 69d:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 6a4:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 6aa:	89 d2                	mov    %edx,%edx
 6ac:	48 01 d0             	add    %rdx,%rax
 6af:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 6b5:	83 c2 08             	add    $0x8,%edx
 6b8:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 6be:	eb 12                	jmp    6d2 <printf+0x231>
 6c0:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 6c7:	48 8d 50 08          	lea    0x8(%rax),%rdx
 6cb:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 6d2:	48 8b 00             	mov    (%rax),%rax
 6d5:	48 89 85 48 ff ff ff 	mov    %rax,-0xb8(%rbp)
        if(s == 0)
 6dc:	48 83 bd 48 ff ff ff 	cmpq   $0x0,-0xb8(%rbp)
 6e3:	00 
 6e4:	75 31                	jne    717 <printf+0x276>
          s = "(null)";
 6e6:	48 c7 85 48 ff ff ff 	movq   $0xaa6,-0xb8(%rbp)
 6ed:	a6 0a 00 00 
        while(*s != 0){
 6f1:	eb 24                	jmp    717 <printf+0x276>
          putc(fd, *s);
 6f3:	48 8b 85 48 ff ff ff 	mov    -0xb8(%rbp),%rax
 6fa:	0f b6 00             	movzbl (%rax),%eax
 6fd:	0f be d0             	movsbl %al,%edx
 700:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 706:	89 d6                	mov    %edx,%esi
 708:	89 c7                	mov    %eax,%edi
 70a:	e8 a8 fc ff ff       	call   3b7 <putc>
          s++;
 70f:	48 83 85 48 ff ff ff 	addq   $0x1,-0xb8(%rbp)
 716:	01 
        while(*s != 0){
 717:	48 8b 85 48 ff ff ff 	mov    -0xb8(%rbp),%rax
 71e:	0f b6 00             	movzbl (%rax),%eax
 721:	84 c0                	test   %al,%al
 723:	75 ce                	jne    6f3 <printf+0x252>
 725:	e9 ac 00 00 00       	jmp    7d6 <printf+0x335>
        }
      } else if(c == 'c'){
 72a:	83 bd 3c ff ff ff 63 	cmpl   $0x63,-0xc4(%rbp)
 731:	75 56                	jne    789 <printf+0x2e8>
        putc(fd, va_arg(ap, uint));
 733:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 739:	83 f8 2f             	cmp    $0x2f,%eax
 73c:	77 23                	ja     761 <printf+0x2c0>
 73e:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 745:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 74b:	89 d2                	mov    %edx,%edx
 74d:	48 01 d0             	add    %rdx,%rax
 750:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 756:	83 c2 08             	add    $0x8,%edx
 759:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 75f:	eb 12                	jmp    773 <printf+0x2d2>
 761:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 768:	48 8d 50 08          	lea    0x8(%rax),%rdx
 76c:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 773:	8b 00                	mov    (%rax),%eax
 775:	0f be d0             	movsbl %al,%edx
 778:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 77e:	89 d6                	mov    %edx,%esi
 780:	89 c7                	mov    %eax,%edi
 782:	e8 30 fc ff ff       	call   3b7 <putc>
 787:	eb 4d                	jmp    7d6 <printf+0x335>
      } else if(c == '%'){
 789:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
 790:	75 1a                	jne    7ac <printf+0x30b>
        putc(fd, c);
 792:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
 798:	0f be d0             	movsbl %al,%edx
 79b:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 7a1:	89 d6                	mov    %edx,%esi
 7a3:	89 c7                	mov    %eax,%edi
 7a5:	e8 0d fc ff ff       	call   3b7 <putc>
 7aa:	eb 2a                	jmp    7d6 <printf+0x335>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 7ac:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 7b2:	be 25 00 00 00       	mov    $0x25,%esi
 7b7:	89 c7                	mov    %eax,%edi
 7b9:	e8 f9 fb ff ff       	call   3b7 <putc>
        putc(fd, c);
 7be:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
 7c4:	0f be d0             	movsbl %al,%edx
 7c7:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 7cd:	89 d6                	mov    %edx,%esi
 7cf:	89 c7                	mov    %eax,%edi
 7d1:	e8 e1 fb ff ff       	call   3b7 <putc>
      }
      state = 0;
 7d6:	c7 85 40 ff ff ff 00 	movl   $0x0,-0xc0(%rbp)
 7dd:	00 00 00 
  for(i = 0; fmt[i]; i++){
 7e0:	83 85 44 ff ff ff 01 	addl   $0x1,-0xbc(%rbp)
 7e7:	8b 85 44 ff ff ff    	mov    -0xbc(%rbp),%eax
 7ed:	48 63 d0             	movslq %eax,%rdx
 7f0:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
 7f7:	48 01 d0             	add    %rdx,%rax
 7fa:	0f b6 00             	movzbl (%rax),%eax
 7fd:	84 c0                	test   %al,%al
 7ff:	0f 85 3a fd ff ff    	jne    53f <printf+0x9e>
    }
  }
}
 805:	90                   	nop
 806:	90                   	nop
 807:	c9                   	leave
 808:	c3                   	ret

0000000000000809 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 809:	55                   	push   %rbp
 80a:	48 89 e5             	mov    %rsp,%rbp
 80d:	48 83 ec 18          	sub    $0x18,%rsp
 811:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  Header *bp, *p;

  bp = (Header*)ap - 1;
 815:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 819:	48 83 e8 10          	sub    $0x10,%rax
 81d:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 821:	48 8b 05 f8 04 00 00 	mov    0x4f8(%rip),%rax        # d20 <freep>
 828:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 82c:	eb 2f                	jmp    85d <free+0x54>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 82e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 832:	48 8b 00             	mov    (%rax),%rax
 835:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 839:	72 17                	jb     852 <free+0x49>
 83b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 83f:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 843:	72 2f                	jb     874 <free+0x6b>
 845:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 849:	48 8b 00             	mov    (%rax),%rax
 84c:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
 850:	72 22                	jb     874 <free+0x6b>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 852:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 856:	48 8b 00             	mov    (%rax),%rax
 859:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 85d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 861:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 865:	73 c7                	jae    82e <free+0x25>
 867:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 86b:	48 8b 00             	mov    (%rax),%rax
 86e:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
 872:	73 ba                	jae    82e <free+0x25>
      break;
  if(bp + bp->s.size == p->s.ptr){
 874:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 878:	8b 40 08             	mov    0x8(%rax),%eax
 87b:	89 c0                	mov    %eax,%eax
 87d:	48 c1 e0 04          	shl    $0x4,%rax
 881:	48 89 c2             	mov    %rax,%rdx
 884:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 888:	48 01 c2             	add    %rax,%rdx
 88b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 88f:	48 8b 00             	mov    (%rax),%rax
 892:	48 39 c2             	cmp    %rax,%rdx
 895:	75 2d                	jne    8c4 <free+0xbb>
    bp->s.size += p->s.ptr->s.size;
 897:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 89b:	8b 50 08             	mov    0x8(%rax),%edx
 89e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 8a2:	48 8b 00             	mov    (%rax),%rax
 8a5:	8b 40 08             	mov    0x8(%rax),%eax
 8a8:	01 c2                	add    %eax,%edx
 8aa:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 8ae:	89 50 08             	mov    %edx,0x8(%rax)
    bp->s.ptr = p->s.ptr->s.ptr;
 8b1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 8b5:	48 8b 00             	mov    (%rax),%rax
 8b8:	48 8b 10             	mov    (%rax),%rdx
 8bb:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 8bf:	48 89 10             	mov    %rdx,(%rax)
 8c2:	eb 0e                	jmp    8d2 <free+0xc9>
  } else
    bp->s.ptr = p->s.ptr;
 8c4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 8c8:	48 8b 10             	mov    (%rax),%rdx
 8cb:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 8cf:	48 89 10             	mov    %rdx,(%rax)
  if(p + p->s.size == bp){
 8d2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 8d6:	8b 40 08             	mov    0x8(%rax),%eax
 8d9:	89 c0                	mov    %eax,%eax
 8db:	48 c1 e0 04          	shl    $0x4,%rax
 8df:	48 89 c2             	mov    %rax,%rdx
 8e2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 8e6:	48 01 d0             	add    %rdx,%rax
 8e9:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
 8ed:	75 27                	jne    916 <free+0x10d>
    p->s.size += bp->s.size;
 8ef:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 8f3:	8b 50 08             	mov    0x8(%rax),%edx
 8f6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 8fa:	8b 40 08             	mov    0x8(%rax),%eax
 8fd:	01 c2                	add    %eax,%edx
 8ff:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 903:	89 50 08             	mov    %edx,0x8(%rax)
    p->s.ptr = bp->s.ptr;
 906:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 90a:	48 8b 10             	mov    (%rax),%rdx
 90d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 911:	48 89 10             	mov    %rdx,(%rax)
 914:	eb 0b                	jmp    921 <free+0x118>
  } else
    p->s.ptr = bp;
 916:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 91a:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
 91e:	48 89 10             	mov    %rdx,(%rax)
  freep = p;
 921:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 925:	48 89 05 f4 03 00 00 	mov    %rax,0x3f4(%rip)        # d20 <freep>
}
 92c:	90                   	nop
 92d:	c9                   	leave
 92e:	c3                   	ret

000000000000092f <morecore>:

static Header*
morecore(uint nu)
{
 92f:	55                   	push   %rbp
 930:	48 89 e5             	mov    %rsp,%rbp
 933:	48 83 ec 20          	sub    $0x20,%rsp
 937:	89 7d ec             	mov    %edi,-0x14(%rbp)
  char *p;
  Header *hp;

  if(nu < 4096)
 93a:	81 7d ec ff 0f 00 00 	cmpl   $0xfff,-0x14(%rbp)
 941:	77 07                	ja     94a <morecore+0x1b>
    nu = 4096;
 943:	c7 45 ec 00 10 00 00 	movl   $0x1000,-0x14(%rbp)
  p = sbrk(nu * sizeof(Header));
 94a:	8b 45 ec             	mov    -0x14(%rbp),%eax
 94d:	c1 e0 04             	shl    $0x4,%eax
 950:	89 c7                	mov    %eax,%edi
 952:	e8 40 fa ff ff       	call   397 <sbrk>
 957:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  if(p == (char*)-1)
 95b:	48 83 7d f8 ff       	cmpq   $0xffffffffffffffff,-0x8(%rbp)
 960:	75 07                	jne    969 <morecore+0x3a>
    return 0;
 962:	b8 00 00 00 00       	mov    $0x0,%eax
 967:	eb 29                	jmp    992 <morecore+0x63>
  hp = (Header*)p;
 969:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 96d:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  hp->s.size = nu;
 971:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 975:	8b 55 ec             	mov    -0x14(%rbp),%edx
 978:	89 50 08             	mov    %edx,0x8(%rax)
  free((void*)(hp + 1));
 97b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 97f:	48 83 c0 10          	add    $0x10,%rax
 983:	48 89 c7             	mov    %rax,%rdi
 986:	e8 7e fe ff ff       	call   809 <free>
  return freep;
 98b:	48 8b 05 8e 03 00 00 	mov    0x38e(%rip),%rax        # d20 <freep>
}
 992:	c9                   	leave
 993:	c3                   	ret

0000000000000994 <malloc>:

void*
malloc(uint nbytes)
{
 994:	55                   	push   %rbp
 995:	48 89 e5             	mov    %rsp,%rbp
 998:	48 83 ec 30          	sub    $0x30,%rsp
 99c:	89 7d dc             	mov    %edi,-0x24(%rbp)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 99f:	8b 45 dc             	mov    -0x24(%rbp),%eax
 9a2:	48 83 c0 0f          	add    $0xf,%rax
 9a6:	48 c1 e8 04          	shr    $0x4,%rax
 9aa:	83 c0 01             	add    $0x1,%eax
 9ad:	89 45 ec             	mov    %eax,-0x14(%rbp)
  if((prevp = freep) == 0){
 9b0:	48 8b 05 69 03 00 00 	mov    0x369(%rip),%rax        # d20 <freep>
 9b7:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
 9bb:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
 9c0:	75 2b                	jne    9ed <malloc+0x59>
    base.s.ptr = freep = prevp = &base;
 9c2:	48 c7 45 f0 10 0d 00 	movq   $0xd10,-0x10(%rbp)
 9c9:	00 
 9ca:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 9ce:	48 89 05 4b 03 00 00 	mov    %rax,0x34b(%rip)        # d20 <freep>
 9d5:	48 8b 05 44 03 00 00 	mov    0x344(%rip),%rax        # d20 <freep>
 9dc:	48 89 05 2d 03 00 00 	mov    %rax,0x32d(%rip)        # d10 <base>
    base.s.size = 0;
 9e3:	c7 05 2b 03 00 00 00 	movl   $0x0,0x32b(%rip)        # d18 <base+0x8>
 9ea:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 9ed:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 9f1:	48 8b 00             	mov    (%rax),%rax
 9f4:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
 9f8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 9fc:	8b 40 08             	mov    0x8(%rax),%eax
 9ff:	3b 45 ec             	cmp    -0x14(%rbp),%eax
 a02:	72 5f                	jb     a63 <malloc+0xcf>
      if(p->s.size == nunits)
 a04:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a08:	8b 40 08             	mov    0x8(%rax),%eax
 a0b:	39 45 ec             	cmp    %eax,-0x14(%rbp)
 a0e:	75 10                	jne    a20 <malloc+0x8c>
        prevp->s.ptr = p->s.ptr;
 a10:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a14:	48 8b 10             	mov    (%rax),%rdx
 a17:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 a1b:	48 89 10             	mov    %rdx,(%rax)
 a1e:	eb 2e                	jmp    a4e <malloc+0xba>
      else {
        p->s.size -= nunits;
 a20:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a24:	8b 40 08             	mov    0x8(%rax),%eax
 a27:	2b 45 ec             	sub    -0x14(%rbp),%eax
 a2a:	89 c2                	mov    %eax,%edx
 a2c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a30:	89 50 08             	mov    %edx,0x8(%rax)
        p += p->s.size;
 a33:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a37:	8b 40 08             	mov    0x8(%rax),%eax
 a3a:	89 c0                	mov    %eax,%eax
 a3c:	48 c1 e0 04          	shl    $0x4,%rax
 a40:	48 01 45 f8          	add    %rax,-0x8(%rbp)
        p->s.size = nunits;
 a44:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a48:	8b 55 ec             	mov    -0x14(%rbp),%edx
 a4b:	89 50 08             	mov    %edx,0x8(%rax)
      }
      freep = prevp;
 a4e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 a52:	48 89 05 c7 02 00 00 	mov    %rax,0x2c7(%rip)        # d20 <freep>
      return (void*)(p + 1);
 a59:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a5d:	48 83 c0 10          	add    $0x10,%rax
 a61:	eb 41                	jmp    aa4 <malloc+0x110>
    }
    if(p == freep)
 a63:	48 8b 05 b6 02 00 00 	mov    0x2b6(%rip),%rax        # d20 <freep>
 a6a:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 a6e:	75 1c                	jne    a8c <malloc+0xf8>
      if((p = morecore(nunits)) == 0)
 a70:	8b 45 ec             	mov    -0x14(%rbp),%eax
 a73:	89 c7                	mov    %eax,%edi
 a75:	e8 b5 fe ff ff       	call   92f <morecore>
 a7a:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 a7e:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
 a83:	75 07                	jne    a8c <malloc+0xf8>
        return 0;
 a85:	b8 00 00 00 00       	mov    $0x0,%eax
 a8a:	eb 18                	jmp    aa4 <malloc+0x110>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a8c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a90:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
 a94:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a98:	48 8b 00             	mov    (%rax),%rax
 a9b:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
 a9f:	e9 54 ff ff ff       	jmp    9f8 <malloc+0x64>
  }
}
 aa4:	c9                   	leave
 aa5:	c3                   	ret
