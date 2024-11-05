
fs/getfavnum:     file format elf64-x86-64


Disassembly of section .text:

0000000000000000 <main>:
#include "types.h"
#include "stat.h"
#include "user.h"


int main(int argc, char *argv[]){
   0:	55                   	push   %rbp
   1:	48 89 e5             	mov    %rsp,%rbp
   4:	48 83 ec 10          	sub    $0x10,%rsp
   8:	89 7d fc             	mov    %edi,-0x4(%rbp)
   b:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
    printf(1, "%d\n", getfavnum());
   f:	e8 b8 03 00 00       	call   3cc <getfavnum>
  14:	89 c2                	mov    %eax,%edx
  16:	48 c7 c6 c8 0c 00 00 	mov    $0xcc8,%rsi
  1d:	bf 01 00 00 00       	mov    $0x1,%edi
  22:	b8 00 00 00 00       	mov    $0x0,%eax
  27:	e8 aa 04 00 00       	call   4d6 <printf>
    exit();
  2c:	e8 f3 02 00 00       	call   324 <exit>

0000000000000031 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
  31:	55                   	push   %rbp
  32:	48 89 e5             	mov    %rsp,%rbp
  35:	48 83 ec 10          	sub    $0x10,%rsp
  39:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  3d:	89 75 f4             	mov    %esi,-0xc(%rbp)
  40:	89 55 f0             	mov    %edx,-0x10(%rbp)
  asm volatile("cld; rep stosb" :
  43:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
  47:	8b 55 f0             	mov    -0x10(%rbp),%edx
  4a:	8b 45 f4             	mov    -0xc(%rbp),%eax
  4d:	48 89 ce             	mov    %rcx,%rsi
  50:	48 89 f7             	mov    %rsi,%rdi
  53:	89 d1                	mov    %edx,%ecx
  55:	fc                   	cld
  56:	f3 aa                	rep stos %al,%es:(%rdi)
  58:	89 ca                	mov    %ecx,%edx
  5a:	48 89 fe             	mov    %rdi,%rsi
  5d:	48 89 75 f8          	mov    %rsi,-0x8(%rbp)
  61:	89 55 f0             	mov    %edx,-0x10(%rbp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
  64:	90                   	nop
  65:	c9                   	leave
  66:	c3                   	ret

0000000000000067 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
  67:	55                   	push   %rbp
  68:	48 89 e5             	mov    %rsp,%rbp
  6b:	48 83 ec 20          	sub    $0x20,%rsp
  6f:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  73:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  char *os;

  os = s;
  77:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  7b:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  while((*s++ = *t++) != 0)
  7f:	90                   	nop
  80:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  84:	48 8d 42 01          	lea    0x1(%rdx),%rax
  88:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  8c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  90:	48 8d 48 01          	lea    0x1(%rax),%rcx
  94:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  98:	0f b6 12             	movzbl (%rdx),%edx
  9b:	88 10                	mov    %dl,(%rax)
  9d:	0f b6 00             	movzbl (%rax),%eax
  a0:	84 c0                	test   %al,%al
  a2:	75 dc                	jne    80 <strcpy+0x19>
    ;
  return os;
  a4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
  a8:	c9                   	leave
  a9:	c3                   	ret

00000000000000aa <strcmp>:

int
strcmp(const char *p, const char *q)
{
  aa:	55                   	push   %rbp
  ab:	48 89 e5             	mov    %rsp,%rbp
  ae:	48 83 ec 10          	sub    $0x10,%rsp
  b2:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  b6:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  while(*p && *p == *q)
  ba:	eb 0a                	jmp    c6 <strcmp+0x1c>
    p++, q++;
  bc:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  c1:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  while(*p && *p == *q)
  c6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  ca:	0f b6 00             	movzbl (%rax),%eax
  cd:	84 c0                	test   %al,%al
  cf:	74 12                	je     e3 <strcmp+0x39>
  d1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  d5:	0f b6 10             	movzbl (%rax),%edx
  d8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  dc:	0f b6 00             	movzbl (%rax),%eax
  df:	38 c2                	cmp    %al,%dl
  e1:	74 d9                	je     bc <strcmp+0x12>
  return (uchar)*p - (uchar)*q;
  e3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  e7:	0f b6 00             	movzbl (%rax),%eax
  ea:	0f b6 d0             	movzbl %al,%edx
  ed:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  f1:	0f b6 00             	movzbl (%rax),%eax
  f4:	0f b6 c0             	movzbl %al,%eax
  f7:	29 c2                	sub    %eax,%edx
  f9:	89 d0                	mov    %edx,%eax
}
  fb:	c9                   	leave
  fc:	c3                   	ret

00000000000000fd <strlen>:

uint
strlen(char *s)
{
  fd:	55                   	push   %rbp
  fe:	48 89 e5             	mov    %rsp,%rbp
 101:	48 83 ec 18          	sub    $0x18,%rsp
 105:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  int n;

  for(n = 0; s[n]; n++)
 109:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
 110:	eb 04                	jmp    116 <strlen+0x19>
 112:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
 116:	8b 45 fc             	mov    -0x4(%rbp),%eax
 119:	48 63 d0             	movslq %eax,%rdx
 11c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 120:	48 01 d0             	add    %rdx,%rax
 123:	0f b6 00             	movzbl (%rax),%eax
 126:	84 c0                	test   %al,%al
 128:	75 e8                	jne    112 <strlen+0x15>
    ;
  return n;
 12a:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
 12d:	c9                   	leave
 12e:	c3                   	ret

000000000000012f <memset>:

void*
memset(void *dst, int c, uint n)
{
 12f:	55                   	push   %rbp
 130:	48 89 e5             	mov    %rsp,%rbp
 133:	48 83 ec 10          	sub    $0x10,%rsp
 137:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
 13b:	89 75 f4             	mov    %esi,-0xc(%rbp)
 13e:	89 55 f0             	mov    %edx,-0x10(%rbp)
  stosb(dst, c, n);
 141:	8b 55 f0             	mov    -0x10(%rbp),%edx
 144:	8b 4d f4             	mov    -0xc(%rbp),%ecx
 147:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 14b:	89 ce                	mov    %ecx,%esi
 14d:	48 89 c7             	mov    %rax,%rdi
 150:	e8 dc fe ff ff       	call   31 <stosb>
  return dst;
 155:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
 159:	c9                   	leave
 15a:	c3                   	ret

000000000000015b <strchr>:

char*
strchr(const char *s, char c)
{
 15b:	55                   	push   %rbp
 15c:	48 89 e5             	mov    %rsp,%rbp
 15f:	48 83 ec 10          	sub    $0x10,%rsp
 163:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
 167:	89 f0                	mov    %esi,%eax
 169:	88 45 f4             	mov    %al,-0xc(%rbp)
  for(; *s; s++)
 16c:	eb 17                	jmp    185 <strchr+0x2a>
    if(*s == c)
 16e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 172:	0f b6 00             	movzbl (%rax),%eax
 175:	38 45 f4             	cmp    %al,-0xc(%rbp)
 178:	75 06                	jne    180 <strchr+0x25>
      return (char*)s;
 17a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 17e:	eb 15                	jmp    195 <strchr+0x3a>
  for(; *s; s++)
 180:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
 185:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 189:	0f b6 00             	movzbl (%rax),%eax
 18c:	84 c0                	test   %al,%al
 18e:	75 de                	jne    16e <strchr+0x13>
  return 0;
 190:	b8 00 00 00 00       	mov    $0x0,%eax
}
 195:	c9                   	leave
 196:	c3                   	ret

0000000000000197 <gets>:

char*
gets(char *buf, int max)
{
 197:	55                   	push   %rbp
 198:	48 89 e5             	mov    %rsp,%rbp
 19b:	48 83 ec 20          	sub    $0x20,%rsp
 19f:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
 1a3:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1a6:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
 1ad:	eb 48                	jmp    1f7 <gets+0x60>
    cc = read(0, &c, 1);
 1af:	48 8d 45 f7          	lea    -0x9(%rbp),%rax
 1b3:	ba 01 00 00 00       	mov    $0x1,%edx
 1b8:	48 89 c6             	mov    %rax,%rsi
 1bb:	bf 00 00 00 00       	mov    $0x0,%edi
 1c0:	e8 77 01 00 00       	call   33c <read>
 1c5:	89 45 f8             	mov    %eax,-0x8(%rbp)
    if(cc < 1)
 1c8:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
 1cc:	7e 36                	jle    204 <gets+0x6d>
      break;
    buf[i++] = c;
 1ce:	8b 45 fc             	mov    -0x4(%rbp),%eax
 1d1:	8d 50 01             	lea    0x1(%rax),%edx
 1d4:	89 55 fc             	mov    %edx,-0x4(%rbp)
 1d7:	48 63 d0             	movslq %eax,%rdx
 1da:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 1de:	48 01 c2             	add    %rax,%rdx
 1e1:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
 1e5:	88 02                	mov    %al,(%rdx)
    if(c == '\n' || c == '\r')
 1e7:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
 1eb:	3c 0a                	cmp    $0xa,%al
 1ed:	74 16                	je     205 <gets+0x6e>
 1ef:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
 1f3:	3c 0d                	cmp    $0xd,%al
 1f5:	74 0e                	je     205 <gets+0x6e>
  for(i=0; i+1 < max; ){
 1f7:	8b 45 fc             	mov    -0x4(%rbp),%eax
 1fa:	83 c0 01             	add    $0x1,%eax
 1fd:	39 45 e4             	cmp    %eax,-0x1c(%rbp)
 200:	7f ad                	jg     1af <gets+0x18>
 202:	eb 01                	jmp    205 <gets+0x6e>
      break;
 204:	90                   	nop
      break;
  }
  buf[i] = '\0';
 205:	8b 45 fc             	mov    -0x4(%rbp),%eax
 208:	48 63 d0             	movslq %eax,%rdx
 20b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 20f:	48 01 d0             	add    %rdx,%rax
 212:	c6 00 00             	movb   $0x0,(%rax)
  return buf;
 215:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
 219:	c9                   	leave
 21a:	c3                   	ret

000000000000021b <stat>:

int
stat(char *n, struct stat *st)
{
 21b:	55                   	push   %rbp
 21c:	48 89 e5             	mov    %rsp,%rbp
 21f:	48 83 ec 20          	sub    $0x20,%rsp
 223:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
 227:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 22b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 22f:	be 00 00 00 00       	mov    $0x0,%esi
 234:	48 89 c7             	mov    %rax,%rdi
 237:	e8 28 01 00 00       	call   364 <open>
 23c:	89 45 fc             	mov    %eax,-0x4(%rbp)
  if(fd < 0)
 23f:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
 243:	79 07                	jns    24c <stat+0x31>
    return -1;
 245:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 24a:	eb 21                	jmp    26d <stat+0x52>
  r = fstat(fd, st);
 24c:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
 250:	8b 45 fc             	mov    -0x4(%rbp),%eax
 253:	48 89 d6             	mov    %rdx,%rsi
 256:	89 c7                	mov    %eax,%edi
 258:	e8 1f 01 00 00       	call   37c <fstat>
 25d:	89 45 f8             	mov    %eax,-0x8(%rbp)
  close(fd);
 260:	8b 45 fc             	mov    -0x4(%rbp),%eax
 263:	89 c7                	mov    %eax,%edi
 265:	e8 e2 00 00 00       	call   34c <close>
  return r;
 26a:	8b 45 f8             	mov    -0x8(%rbp),%eax
}
 26d:	c9                   	leave
 26e:	c3                   	ret

000000000000026f <atoi>:

int
atoi(const char *s)
{
 26f:	55                   	push   %rbp
 270:	48 89 e5             	mov    %rsp,%rbp
 273:	48 83 ec 18          	sub    $0x18,%rsp
 277:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  int n;

  n = 0;
 27b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  while('0' <= *s && *s <= '9')
 282:	eb 28                	jmp    2ac <atoi+0x3d>
    n = n*10 + *s++ - '0';
 284:	8b 55 fc             	mov    -0x4(%rbp),%edx
 287:	89 d0                	mov    %edx,%eax
 289:	c1 e0 02             	shl    $0x2,%eax
 28c:	01 d0                	add    %edx,%eax
 28e:	01 c0                	add    %eax,%eax
 290:	89 c1                	mov    %eax,%ecx
 292:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 296:	48 8d 50 01          	lea    0x1(%rax),%rdx
 29a:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
 29e:	0f b6 00             	movzbl (%rax),%eax
 2a1:	0f be c0             	movsbl %al,%eax
 2a4:	01 c8                	add    %ecx,%eax
 2a6:	83 e8 30             	sub    $0x30,%eax
 2a9:	89 45 fc             	mov    %eax,-0x4(%rbp)
  while('0' <= *s && *s <= '9')
 2ac:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 2b0:	0f b6 00             	movzbl (%rax),%eax
 2b3:	3c 2f                	cmp    $0x2f,%al
 2b5:	7e 0b                	jle    2c2 <atoi+0x53>
 2b7:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 2bb:	0f b6 00             	movzbl (%rax),%eax
 2be:	3c 39                	cmp    $0x39,%al
 2c0:	7e c2                	jle    284 <atoi+0x15>
  return n;
 2c2:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
 2c5:	c9                   	leave
 2c6:	c3                   	ret

00000000000002c7 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 2c7:	55                   	push   %rbp
 2c8:	48 89 e5             	mov    %rsp,%rbp
 2cb:	48 83 ec 28          	sub    $0x28,%rsp
 2cf:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
 2d3:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
 2d7:	89 55 dc             	mov    %edx,-0x24(%rbp)
  char *dst, *src;
  
  dst = vdst;
 2da:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 2de:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  src = vsrc;
 2e2:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
 2e6:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  while(n-- > 0)
 2ea:	eb 1d                	jmp    309 <memmove+0x42>
    *dst++ = *src++;
 2ec:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
 2f0:	48 8d 42 01          	lea    0x1(%rdx),%rax
 2f4:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
 2f8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 2fc:	48 8d 48 01          	lea    0x1(%rax),%rcx
 300:	48 89 4d f8          	mov    %rcx,-0x8(%rbp)
 304:	0f b6 12             	movzbl (%rdx),%edx
 307:	88 10                	mov    %dl,(%rax)
  while(n-- > 0)
 309:	8b 45 dc             	mov    -0x24(%rbp),%eax
 30c:	8d 50 ff             	lea    -0x1(%rax),%edx
 30f:	89 55 dc             	mov    %edx,-0x24(%rbp)
 312:	85 c0                	test   %eax,%eax
 314:	7f d6                	jg     2ec <memmove+0x25>
  return vdst;
 316:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
 31a:	c9                   	leave
 31b:	c3                   	ret

000000000000031c <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 31c:	b8 01 00 00 00       	mov    $0x1,%eax
 321:	cd 40                	int    $0x40
 323:	c3                   	ret

0000000000000324 <exit>:
SYSCALL(exit)
 324:	b8 02 00 00 00       	mov    $0x2,%eax
 329:	cd 40                	int    $0x40
 32b:	c3                   	ret

000000000000032c <wait>:
SYSCALL(wait)
 32c:	b8 03 00 00 00       	mov    $0x3,%eax
 331:	cd 40                	int    $0x40
 333:	c3                   	ret

0000000000000334 <pipe>:
SYSCALL(pipe)
 334:	b8 04 00 00 00       	mov    $0x4,%eax
 339:	cd 40                	int    $0x40
 33b:	c3                   	ret

000000000000033c <read>:
SYSCALL(read)
 33c:	b8 05 00 00 00       	mov    $0x5,%eax
 341:	cd 40                	int    $0x40
 343:	c3                   	ret

0000000000000344 <write>:
SYSCALL(write)
 344:	b8 10 00 00 00       	mov    $0x10,%eax
 349:	cd 40                	int    $0x40
 34b:	c3                   	ret

000000000000034c <close>:
SYSCALL(close)
 34c:	b8 15 00 00 00       	mov    $0x15,%eax
 351:	cd 40                	int    $0x40
 353:	c3                   	ret

0000000000000354 <kill>:
SYSCALL(kill)
 354:	b8 06 00 00 00       	mov    $0x6,%eax
 359:	cd 40                	int    $0x40
 35b:	c3                   	ret

000000000000035c <exec>:
SYSCALL(exec)
 35c:	b8 07 00 00 00       	mov    $0x7,%eax
 361:	cd 40                	int    $0x40
 363:	c3                   	ret

0000000000000364 <open>:
SYSCALL(open)
 364:	b8 0f 00 00 00       	mov    $0xf,%eax
 369:	cd 40                	int    $0x40
 36b:	c3                   	ret

000000000000036c <mknod>:
SYSCALL(mknod)
 36c:	b8 11 00 00 00       	mov    $0x11,%eax
 371:	cd 40                	int    $0x40
 373:	c3                   	ret

0000000000000374 <unlink>:
SYSCALL(unlink)
 374:	b8 12 00 00 00       	mov    $0x12,%eax
 379:	cd 40                	int    $0x40
 37b:	c3                   	ret

000000000000037c <fstat>:
SYSCALL(fstat)
 37c:	b8 08 00 00 00       	mov    $0x8,%eax
 381:	cd 40                	int    $0x40
 383:	c3                   	ret

0000000000000384 <link>:
SYSCALL(link)
 384:	b8 13 00 00 00       	mov    $0x13,%eax
 389:	cd 40                	int    $0x40
 38b:	c3                   	ret

000000000000038c <mkdir>:
SYSCALL(mkdir)
 38c:	b8 14 00 00 00       	mov    $0x14,%eax
 391:	cd 40                	int    $0x40
 393:	c3                   	ret

0000000000000394 <chdir>:
SYSCALL(chdir)
 394:	b8 09 00 00 00       	mov    $0x9,%eax
 399:	cd 40                	int    $0x40
 39b:	c3                   	ret

000000000000039c <dup>:
SYSCALL(dup)
 39c:	b8 0a 00 00 00       	mov    $0xa,%eax
 3a1:	cd 40                	int    $0x40
 3a3:	c3                   	ret

00000000000003a4 <getpid>:
SYSCALL(getpid)
 3a4:	b8 0b 00 00 00       	mov    $0xb,%eax
 3a9:	cd 40                	int    $0x40
 3ab:	c3                   	ret

00000000000003ac <sbrk>:
SYSCALL(sbrk)
 3ac:	b8 0c 00 00 00       	mov    $0xc,%eax
 3b1:	cd 40                	int    $0x40
 3b3:	c3                   	ret

00000000000003b4 <sleep>:
SYSCALL(sleep)
 3b4:	b8 0d 00 00 00       	mov    $0xd,%eax
 3b9:	cd 40                	int    $0x40
 3bb:	c3                   	ret

00000000000003bc <uptime>:
SYSCALL(uptime)
 3bc:	b8 0e 00 00 00       	mov    $0xe,%eax
 3c1:	cd 40                	int    $0x40
 3c3:	c3                   	ret

00000000000003c4 <getpinfo>:
SYSCALL(getpinfo)
 3c4:	b8 18 00 00 00       	mov    $0x18,%eax
 3c9:	cd 40                	int    $0x40
 3cb:	c3                   	ret

00000000000003cc <getfavnum>:
SYSCALL(getfavnum)
 3cc:	b8 19 00 00 00       	mov    $0x19,%eax
 3d1:	cd 40                	int    $0x40
 3d3:	c3                   	ret

00000000000003d4 <shutdown>:
SYSCALL(shutdown)
 3d4:	b8 1a 00 00 00       	mov    $0x1a,%eax
 3d9:	cd 40                	int    $0x40
 3db:	c3                   	ret

00000000000003dc <getcount>:
SYSCALL(getcount)
 3dc:	b8 1b 00 00 00       	mov    $0x1b,%eax
 3e1:	cd 40                	int    $0x40
 3e3:	c3                   	ret

00000000000003e4 <killrandom>:
 3e4:	b8 1c 00 00 00       	mov    $0x1c,%eax
 3e9:	cd 40                	int    $0x40
 3eb:	c3                   	ret

00000000000003ec <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 3ec:	55                   	push   %rbp
 3ed:	48 89 e5             	mov    %rsp,%rbp
 3f0:	48 83 ec 10          	sub    $0x10,%rsp
 3f4:	89 7d fc             	mov    %edi,-0x4(%rbp)
 3f7:	89 f0                	mov    %esi,%eax
 3f9:	88 45 f8             	mov    %al,-0x8(%rbp)
  write(fd, &c, 1);
 3fc:	48 8d 4d f8          	lea    -0x8(%rbp),%rcx
 400:	8b 45 fc             	mov    -0x4(%rbp),%eax
 403:	ba 01 00 00 00       	mov    $0x1,%edx
 408:	48 89 ce             	mov    %rcx,%rsi
 40b:	89 c7                	mov    %eax,%edi
 40d:	e8 32 ff ff ff       	call   344 <write>
}
 412:	90                   	nop
 413:	c9                   	leave
 414:	c3                   	ret

0000000000000415 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 415:	55                   	push   %rbp
 416:	48 89 e5             	mov    %rsp,%rbp
 419:	48 83 ec 30          	sub    $0x30,%rsp
 41d:	89 7d dc             	mov    %edi,-0x24(%rbp)
 420:	89 75 d8             	mov    %esi,-0x28(%rbp)
 423:	89 55 d4             	mov    %edx,-0x2c(%rbp)
 426:	89 4d d0             	mov    %ecx,-0x30(%rbp)
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 429:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
  if(sgn && xx < 0){
 430:	83 7d d0 00          	cmpl   $0x0,-0x30(%rbp)
 434:	74 17                	je     44d <printint+0x38>
 436:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
 43a:	79 11                	jns    44d <printint+0x38>
    neg = 1;
 43c:	c7 45 f8 01 00 00 00 	movl   $0x1,-0x8(%rbp)
    x = -xx;
 443:	8b 45 d8             	mov    -0x28(%rbp),%eax
 446:	f7 d8                	neg    %eax
 448:	89 45 f4             	mov    %eax,-0xc(%rbp)
 44b:	eb 06                	jmp    453 <printint+0x3e>
  } else {
    x = xx;
 44d:	8b 45 d8             	mov    -0x28(%rbp),%eax
 450:	89 45 f4             	mov    %eax,-0xc(%rbp)
  }

  i = 0;
 453:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  do{
    buf[i++] = digits[x % base];
 45a:	8b 4d d4             	mov    -0x2c(%rbp),%ecx
 45d:	8b 45 f4             	mov    -0xc(%rbp),%eax
 460:	ba 00 00 00 00       	mov    $0x0,%edx
 465:	f7 f1                	div    %ecx
 467:	89 d1                	mov    %edx,%ecx
 469:	8b 45 fc             	mov    -0x4(%rbp),%eax
 46c:	8d 50 01             	lea    0x1(%rax),%edx
 46f:	89 55 fc             	mov    %edx,-0x4(%rbp)
 472:	89 ca                	mov    %ecx,%edx
 474:	0f b6 92 b0 0f 00 00 	movzbl 0xfb0(%rdx),%edx
 47b:	48 98                	cltq
 47d:	88 54 05 e0          	mov    %dl,-0x20(%rbp,%rax,1)
  }while((x /= base) != 0);
 481:	8b 75 d4             	mov    -0x2c(%rbp),%esi
 484:	8b 45 f4             	mov    -0xc(%rbp),%eax
 487:	ba 00 00 00 00       	mov    $0x0,%edx
 48c:	f7 f6                	div    %esi
 48e:	89 45 f4             	mov    %eax,-0xc(%rbp)
 491:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
 495:	75 c3                	jne    45a <printint+0x45>
  if(neg)
 497:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
 49b:	74 2b                	je     4c8 <printint+0xb3>
    buf[i++] = '-';
 49d:	8b 45 fc             	mov    -0x4(%rbp),%eax
 4a0:	8d 50 01             	lea    0x1(%rax),%edx
 4a3:	89 55 fc             	mov    %edx,-0x4(%rbp)
 4a6:	48 98                	cltq
 4a8:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%rbp,%rax,1)

  while(--i >= 0)
 4ad:	eb 19                	jmp    4c8 <printint+0xb3>
    putc(fd, buf[i]);
 4af:	8b 45 fc             	mov    -0x4(%rbp),%eax
 4b2:	48 98                	cltq
 4b4:	0f b6 44 05 e0       	movzbl -0x20(%rbp,%rax,1),%eax
 4b9:	0f be d0             	movsbl %al,%edx
 4bc:	8b 45 dc             	mov    -0x24(%rbp),%eax
 4bf:	89 d6                	mov    %edx,%esi
 4c1:	89 c7                	mov    %eax,%edi
 4c3:	e8 24 ff ff ff       	call   3ec <putc>
  while(--i >= 0)
 4c8:	83 6d fc 01          	subl   $0x1,-0x4(%rbp)
 4cc:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
 4d0:	79 dd                	jns    4af <printint+0x9a>
}
 4d2:	90                   	nop
 4d3:	90                   	nop
 4d4:	c9                   	leave
 4d5:	c3                   	ret

00000000000004d6 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 4d6:	55                   	push   %rbp
 4d7:	48 89 e5             	mov    %rsp,%rbp
 4da:	48 81 ec f0 00 00 00 	sub    $0xf0,%rsp
 4e1:	89 bd 1c ff ff ff    	mov    %edi,-0xe4(%rbp)
 4e7:	48 89 b5 10 ff ff ff 	mov    %rsi,-0xf0(%rbp)
 4ee:	48 89 95 60 ff ff ff 	mov    %rdx,-0xa0(%rbp)
 4f5:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
 4fc:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
 503:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
 50a:	84 c0                	test   %al,%al
 50c:	74 20                	je     52e <printf+0x58>
 50e:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
 512:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
 516:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
 51a:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
 51e:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
 522:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
 526:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
 52a:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  va_list ap;
  char *s;
  int c, i, state;
  va_start(ap, fmt);
 52e:	c7 85 20 ff ff ff 10 	movl   $0x10,-0xe0(%rbp)
 535:	00 00 00 
 538:	c7 85 24 ff ff ff 30 	movl   $0x30,-0xdc(%rbp)
 53f:	00 00 00 
 542:	48 8d 45 10          	lea    0x10(%rbp),%rax
 546:	48 89 85 28 ff ff ff 	mov    %rax,-0xd8(%rbp)
 54d:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
 554:	48 89 85 30 ff ff ff 	mov    %rax,-0xd0(%rbp)

  state = 0;
 55b:	c7 85 40 ff ff ff 00 	movl   $0x0,-0xc0(%rbp)
 562:	00 00 00 
  for(i = 0; fmt[i]; i++){
 565:	c7 85 44 ff ff ff 00 	movl   $0x0,-0xbc(%rbp)
 56c:	00 00 00 
 56f:	e9 a8 02 00 00       	jmp    81c <printf+0x346>
    c = fmt[i] & 0xff;
 574:	8b 85 44 ff ff ff    	mov    -0xbc(%rbp),%eax
 57a:	48 63 d0             	movslq %eax,%rdx
 57d:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
 584:	48 01 d0             	add    %rdx,%rax
 587:	0f b6 00             	movzbl (%rax),%eax
 58a:	0f be c0             	movsbl %al,%eax
 58d:	25 ff 00 00 00       	and    $0xff,%eax
 592:	89 85 3c ff ff ff    	mov    %eax,-0xc4(%rbp)
    if(state == 0){
 598:	83 bd 40 ff ff ff 00 	cmpl   $0x0,-0xc0(%rbp)
 59f:	75 35                	jne    5d6 <printf+0x100>
      if(c == '%'){
 5a1:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
 5a8:	75 0f                	jne    5b9 <printf+0xe3>
        state = '%';
 5aa:	c7 85 40 ff ff ff 25 	movl   $0x25,-0xc0(%rbp)
 5b1:	00 00 00 
 5b4:	e9 5c 02 00 00       	jmp    815 <printf+0x33f>
      } else {
        putc(fd, c);
 5b9:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
 5bf:	0f be d0             	movsbl %al,%edx
 5c2:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 5c8:	89 d6                	mov    %edx,%esi
 5ca:	89 c7                	mov    %eax,%edi
 5cc:	e8 1b fe ff ff       	call   3ec <putc>
 5d1:	e9 3f 02 00 00       	jmp    815 <printf+0x33f>
      }
    } else if(state == '%'){
 5d6:	83 bd 40 ff ff ff 25 	cmpl   $0x25,-0xc0(%rbp)
 5dd:	0f 85 32 02 00 00    	jne    815 <printf+0x33f>
      if(c == 'd'){
 5e3:	83 bd 3c ff ff ff 64 	cmpl   $0x64,-0xc4(%rbp)
 5ea:	75 5e                	jne    64a <printf+0x174>
        printint(fd, va_arg(ap, int), 10, 1);
 5ec:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 5f2:	83 f8 2f             	cmp    $0x2f,%eax
 5f5:	77 23                	ja     61a <printf+0x144>
 5f7:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 5fe:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 604:	89 d2                	mov    %edx,%edx
 606:	48 01 d0             	add    %rdx,%rax
 609:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 60f:	83 c2 08             	add    $0x8,%edx
 612:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 618:	eb 12                	jmp    62c <printf+0x156>
 61a:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 621:	48 8d 50 08          	lea    0x8(%rax),%rdx
 625:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 62c:	8b 30                	mov    (%rax),%esi
 62e:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 634:	b9 01 00 00 00       	mov    $0x1,%ecx
 639:	ba 0a 00 00 00       	mov    $0xa,%edx
 63e:	89 c7                	mov    %eax,%edi
 640:	e8 d0 fd ff ff       	call   415 <printint>
 645:	e9 c1 01 00 00       	jmp    80b <printf+0x335>
      } else if(c == 'x' || c == 'p'){
 64a:	83 bd 3c ff ff ff 78 	cmpl   $0x78,-0xc4(%rbp)
 651:	74 09                	je     65c <printf+0x186>
 653:	83 bd 3c ff ff ff 70 	cmpl   $0x70,-0xc4(%rbp)
 65a:	75 5e                	jne    6ba <printf+0x1e4>
        printint(fd, va_arg(ap, int), 16, 0);
 65c:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 662:	83 f8 2f             	cmp    $0x2f,%eax
 665:	77 23                	ja     68a <printf+0x1b4>
 667:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 66e:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 674:	89 d2                	mov    %edx,%edx
 676:	48 01 d0             	add    %rdx,%rax
 679:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 67f:	83 c2 08             	add    $0x8,%edx
 682:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 688:	eb 12                	jmp    69c <printf+0x1c6>
 68a:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 691:	48 8d 50 08          	lea    0x8(%rax),%rdx
 695:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 69c:	8b 30                	mov    (%rax),%esi
 69e:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 6a4:	b9 00 00 00 00       	mov    $0x0,%ecx
 6a9:	ba 10 00 00 00       	mov    $0x10,%edx
 6ae:	89 c7                	mov    %eax,%edi
 6b0:	e8 60 fd ff ff       	call   415 <printint>
 6b5:	e9 51 01 00 00       	jmp    80b <printf+0x335>
      } else if(c == 's'){
 6ba:	83 bd 3c ff ff ff 73 	cmpl   $0x73,-0xc4(%rbp)
 6c1:	0f 85 98 00 00 00    	jne    75f <printf+0x289>
        s = va_arg(ap, char*);
 6c7:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 6cd:	83 f8 2f             	cmp    $0x2f,%eax
 6d0:	77 23                	ja     6f5 <printf+0x21f>
 6d2:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 6d9:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 6df:	89 d2                	mov    %edx,%edx
 6e1:	48 01 d0             	add    %rdx,%rax
 6e4:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 6ea:	83 c2 08             	add    $0x8,%edx
 6ed:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 6f3:	eb 12                	jmp    707 <printf+0x231>
 6f5:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 6fc:	48 8d 50 08          	lea    0x8(%rax),%rdx
 700:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 707:	48 8b 00             	mov    (%rax),%rax
 70a:	48 89 85 48 ff ff ff 	mov    %rax,-0xb8(%rbp)
        if(s == 0)
 711:	48 83 bd 48 ff ff ff 	cmpq   $0x0,-0xb8(%rbp)
 718:	00 
 719:	75 31                	jne    74c <printf+0x276>
          s = "(null)";
 71b:	48 c7 85 48 ff ff ff 	movq   $0xccc,-0xb8(%rbp)
 722:	cc 0c 00 00 
        while(*s != 0){
 726:	eb 24                	jmp    74c <printf+0x276>
          putc(fd, *s);
 728:	48 8b 85 48 ff ff ff 	mov    -0xb8(%rbp),%rax
 72f:	0f b6 00             	movzbl (%rax),%eax
 732:	0f be d0             	movsbl %al,%edx
 735:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 73b:	89 d6                	mov    %edx,%esi
 73d:	89 c7                	mov    %eax,%edi
 73f:	e8 a8 fc ff ff       	call   3ec <putc>
          s++;
 744:	48 83 85 48 ff ff ff 	addq   $0x1,-0xb8(%rbp)
 74b:	01 
        while(*s != 0){
 74c:	48 8b 85 48 ff ff ff 	mov    -0xb8(%rbp),%rax
 753:	0f b6 00             	movzbl (%rax),%eax
 756:	84 c0                	test   %al,%al
 758:	75 ce                	jne    728 <printf+0x252>
 75a:	e9 ac 00 00 00       	jmp    80b <printf+0x335>
        }
      } else if(c == 'c'){
 75f:	83 bd 3c ff ff ff 63 	cmpl   $0x63,-0xc4(%rbp)
 766:	75 56                	jne    7be <printf+0x2e8>
        putc(fd, va_arg(ap, uint));
 768:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 76e:	83 f8 2f             	cmp    $0x2f,%eax
 771:	77 23                	ja     796 <printf+0x2c0>
 773:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 77a:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 780:	89 d2                	mov    %edx,%edx
 782:	48 01 d0             	add    %rdx,%rax
 785:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 78b:	83 c2 08             	add    $0x8,%edx
 78e:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 794:	eb 12                	jmp    7a8 <printf+0x2d2>
 796:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 79d:	48 8d 50 08          	lea    0x8(%rax),%rdx
 7a1:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 7a8:	8b 00                	mov    (%rax),%eax
 7aa:	0f be d0             	movsbl %al,%edx
 7ad:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 7b3:	89 d6                	mov    %edx,%esi
 7b5:	89 c7                	mov    %eax,%edi
 7b7:	e8 30 fc ff ff       	call   3ec <putc>
 7bc:	eb 4d                	jmp    80b <printf+0x335>
      } else if(c == '%'){
 7be:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
 7c5:	75 1a                	jne    7e1 <printf+0x30b>
        putc(fd, c);
 7c7:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
 7cd:	0f be d0             	movsbl %al,%edx
 7d0:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 7d6:	89 d6                	mov    %edx,%esi
 7d8:	89 c7                	mov    %eax,%edi
 7da:	e8 0d fc ff ff       	call   3ec <putc>
 7df:	eb 2a                	jmp    80b <printf+0x335>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 7e1:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 7e7:	be 25 00 00 00       	mov    $0x25,%esi
 7ec:	89 c7                	mov    %eax,%edi
 7ee:	e8 f9 fb ff ff       	call   3ec <putc>
        putc(fd, c);
 7f3:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
 7f9:	0f be d0             	movsbl %al,%edx
 7fc:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 802:	89 d6                	mov    %edx,%esi
 804:	89 c7                	mov    %eax,%edi
 806:	e8 e1 fb ff ff       	call   3ec <putc>
      }
      state = 0;
 80b:	c7 85 40 ff ff ff 00 	movl   $0x0,-0xc0(%rbp)
 812:	00 00 00 
  for(i = 0; fmt[i]; i++){
 815:	83 85 44 ff ff ff 01 	addl   $0x1,-0xbc(%rbp)
 81c:	8b 85 44 ff ff ff    	mov    -0xbc(%rbp),%eax
 822:	48 63 d0             	movslq %eax,%rdx
 825:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
 82c:	48 01 d0             	add    %rdx,%rax
 82f:	0f b6 00             	movzbl (%rax),%eax
 832:	84 c0                	test   %al,%al
 834:	0f 85 3a fd ff ff    	jne    574 <printf+0x9e>
    }
  }
}
 83a:	90                   	nop
 83b:	90                   	nop
 83c:	c9                   	leave
 83d:	c3                   	ret

000000000000083e <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 83e:	55                   	push   %rbp
 83f:	48 89 e5             	mov    %rsp,%rbp
 842:	48 83 ec 18          	sub    $0x18,%rsp
 846:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  Header *bp, *p;

  bp = (Header*)ap - 1;
 84a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 84e:	48 83 e8 10          	sub    $0x10,%rax
 852:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 856:	48 8b 05 83 07 00 00 	mov    0x783(%rip),%rax        # fe0 <freep>
 85d:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 861:	eb 2f                	jmp    892 <free+0x54>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 863:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 867:	48 8b 00             	mov    (%rax),%rax
 86a:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 86e:	72 17                	jb     887 <free+0x49>
 870:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 874:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 878:	72 2f                	jb     8a9 <free+0x6b>
 87a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 87e:	48 8b 00             	mov    (%rax),%rax
 881:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
 885:	72 22                	jb     8a9 <free+0x6b>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 887:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 88b:	48 8b 00             	mov    (%rax),%rax
 88e:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 892:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 896:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 89a:	73 c7                	jae    863 <free+0x25>
 89c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 8a0:	48 8b 00             	mov    (%rax),%rax
 8a3:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
 8a7:	73 ba                	jae    863 <free+0x25>
      break;
  if(bp + bp->s.size == p->s.ptr){
 8a9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 8ad:	8b 40 08             	mov    0x8(%rax),%eax
 8b0:	89 c0                	mov    %eax,%eax
 8b2:	48 c1 e0 04          	shl    $0x4,%rax
 8b6:	48 89 c2             	mov    %rax,%rdx
 8b9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 8bd:	48 01 c2             	add    %rax,%rdx
 8c0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 8c4:	48 8b 00             	mov    (%rax),%rax
 8c7:	48 39 c2             	cmp    %rax,%rdx
 8ca:	75 2d                	jne    8f9 <free+0xbb>
    bp->s.size += p->s.ptr->s.size;
 8cc:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 8d0:	8b 50 08             	mov    0x8(%rax),%edx
 8d3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 8d7:	48 8b 00             	mov    (%rax),%rax
 8da:	8b 40 08             	mov    0x8(%rax),%eax
 8dd:	01 c2                	add    %eax,%edx
 8df:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 8e3:	89 50 08             	mov    %edx,0x8(%rax)
    bp->s.ptr = p->s.ptr->s.ptr;
 8e6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 8ea:	48 8b 00             	mov    (%rax),%rax
 8ed:	48 8b 10             	mov    (%rax),%rdx
 8f0:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 8f4:	48 89 10             	mov    %rdx,(%rax)
 8f7:	eb 0e                	jmp    907 <free+0xc9>
  } else
    bp->s.ptr = p->s.ptr;
 8f9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 8fd:	48 8b 10             	mov    (%rax),%rdx
 900:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 904:	48 89 10             	mov    %rdx,(%rax)
  if(p + p->s.size == bp){
 907:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 90b:	8b 40 08             	mov    0x8(%rax),%eax
 90e:	89 c0                	mov    %eax,%eax
 910:	48 c1 e0 04          	shl    $0x4,%rax
 914:	48 89 c2             	mov    %rax,%rdx
 917:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 91b:	48 01 d0             	add    %rdx,%rax
 91e:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
 922:	75 27                	jne    94b <free+0x10d>
    p->s.size += bp->s.size;
 924:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 928:	8b 50 08             	mov    0x8(%rax),%edx
 92b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 92f:	8b 40 08             	mov    0x8(%rax),%eax
 932:	01 c2                	add    %eax,%edx
 934:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 938:	89 50 08             	mov    %edx,0x8(%rax)
    p->s.ptr = bp->s.ptr;
 93b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 93f:	48 8b 10             	mov    (%rax),%rdx
 942:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 946:	48 89 10             	mov    %rdx,(%rax)
 949:	eb 0b                	jmp    956 <free+0x118>
  } else
    p->s.ptr = bp;
 94b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 94f:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
 953:	48 89 10             	mov    %rdx,(%rax)
  freep = p;
 956:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 95a:	48 89 05 7f 06 00 00 	mov    %rax,0x67f(%rip)        # fe0 <freep>
}
 961:	90                   	nop
 962:	c9                   	leave
 963:	c3                   	ret

0000000000000964 <morecore>:

static Header*
morecore(uint nu)
{
 964:	55                   	push   %rbp
 965:	48 89 e5             	mov    %rsp,%rbp
 968:	48 83 ec 20          	sub    $0x20,%rsp
 96c:	89 7d ec             	mov    %edi,-0x14(%rbp)
  char *p;
  Header *hp;

  if(nu < 4096)
 96f:	81 7d ec ff 0f 00 00 	cmpl   $0xfff,-0x14(%rbp)
 976:	77 07                	ja     97f <morecore+0x1b>
    nu = 4096;
 978:	c7 45 ec 00 10 00 00 	movl   $0x1000,-0x14(%rbp)
  p = sbrk(nu * sizeof(Header));
 97f:	8b 45 ec             	mov    -0x14(%rbp),%eax
 982:	c1 e0 04             	shl    $0x4,%eax
 985:	89 c7                	mov    %eax,%edi
 987:	e8 20 fa ff ff       	call   3ac <sbrk>
 98c:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  if(p == (char*)-1)
 990:	48 83 7d f8 ff       	cmpq   $0xffffffffffffffff,-0x8(%rbp)
 995:	75 07                	jne    99e <morecore+0x3a>
    return 0;
 997:	b8 00 00 00 00       	mov    $0x0,%eax
 99c:	eb 29                	jmp    9c7 <morecore+0x63>
  hp = (Header*)p;
 99e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 9a2:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  hp->s.size = nu;
 9a6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 9aa:	8b 55 ec             	mov    -0x14(%rbp),%edx
 9ad:	89 50 08             	mov    %edx,0x8(%rax)
  free((void*)(hp + 1));
 9b0:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 9b4:	48 83 c0 10          	add    $0x10,%rax
 9b8:	48 89 c7             	mov    %rax,%rdi
 9bb:	e8 7e fe ff ff       	call   83e <free>
  return freep;
 9c0:	48 8b 05 19 06 00 00 	mov    0x619(%rip),%rax        # fe0 <freep>
}
 9c7:	c9                   	leave
 9c8:	c3                   	ret

00000000000009c9 <malloc>:

void*
malloc(uint nbytes)
{
 9c9:	55                   	push   %rbp
 9ca:	48 89 e5             	mov    %rsp,%rbp
 9cd:	48 83 ec 30          	sub    $0x30,%rsp
 9d1:	89 7d dc             	mov    %edi,-0x24(%rbp)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 9d4:	8b 45 dc             	mov    -0x24(%rbp),%eax
 9d7:	48 83 c0 0f          	add    $0xf,%rax
 9db:	48 c1 e8 04          	shr    $0x4,%rax
 9df:	83 c0 01             	add    $0x1,%eax
 9e2:	89 45 ec             	mov    %eax,-0x14(%rbp)
  if((prevp = freep) == 0){
 9e5:	48 8b 05 f4 05 00 00 	mov    0x5f4(%rip),%rax        # fe0 <freep>
 9ec:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
 9f0:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
 9f5:	75 2b                	jne    a22 <malloc+0x59>
    base.s.ptr = freep = prevp = &base;
 9f7:	48 c7 45 f0 d0 0f 00 	movq   $0xfd0,-0x10(%rbp)
 9fe:	00 
 9ff:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 a03:	48 89 05 d6 05 00 00 	mov    %rax,0x5d6(%rip)        # fe0 <freep>
 a0a:	48 8b 05 cf 05 00 00 	mov    0x5cf(%rip),%rax        # fe0 <freep>
 a11:	48 89 05 b8 05 00 00 	mov    %rax,0x5b8(%rip)        # fd0 <base>
    base.s.size = 0;
 a18:	c7 05 b6 05 00 00 00 	movl   $0x0,0x5b6(%rip)        # fd8 <base+0x8>
 a1f:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a22:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 a26:	48 8b 00             	mov    (%rax),%rax
 a29:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
 a2d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a31:	8b 40 08             	mov    0x8(%rax),%eax
 a34:	3b 45 ec             	cmp    -0x14(%rbp),%eax
 a37:	72 5f                	jb     a98 <malloc+0xcf>
      if(p->s.size == nunits)
 a39:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a3d:	8b 40 08             	mov    0x8(%rax),%eax
 a40:	39 45 ec             	cmp    %eax,-0x14(%rbp)
 a43:	75 10                	jne    a55 <malloc+0x8c>
        prevp->s.ptr = p->s.ptr;
 a45:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a49:	48 8b 10             	mov    (%rax),%rdx
 a4c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 a50:	48 89 10             	mov    %rdx,(%rax)
 a53:	eb 2e                	jmp    a83 <malloc+0xba>
      else {
        p->s.size -= nunits;
 a55:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a59:	8b 40 08             	mov    0x8(%rax),%eax
 a5c:	2b 45 ec             	sub    -0x14(%rbp),%eax
 a5f:	89 c2                	mov    %eax,%edx
 a61:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a65:	89 50 08             	mov    %edx,0x8(%rax)
        p += p->s.size;
 a68:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a6c:	8b 40 08             	mov    0x8(%rax),%eax
 a6f:	89 c0                	mov    %eax,%eax
 a71:	48 c1 e0 04          	shl    $0x4,%rax
 a75:	48 01 45 f8          	add    %rax,-0x8(%rbp)
        p->s.size = nunits;
 a79:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a7d:	8b 55 ec             	mov    -0x14(%rbp),%edx
 a80:	89 50 08             	mov    %edx,0x8(%rax)
      }
      freep = prevp;
 a83:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 a87:	48 89 05 52 05 00 00 	mov    %rax,0x552(%rip)        # fe0 <freep>
      return (void*)(p + 1);
 a8e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a92:	48 83 c0 10          	add    $0x10,%rax
 a96:	eb 41                	jmp    ad9 <malloc+0x110>
    }
    if(p == freep)
 a98:	48 8b 05 41 05 00 00 	mov    0x541(%rip),%rax        # fe0 <freep>
 a9f:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 aa3:	75 1c                	jne    ac1 <malloc+0xf8>
      if((p = morecore(nunits)) == 0)
 aa5:	8b 45 ec             	mov    -0x14(%rbp),%eax
 aa8:	89 c7                	mov    %eax,%edi
 aaa:	e8 b5 fe ff ff       	call   964 <morecore>
 aaf:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 ab3:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
 ab8:	75 07                	jne    ac1 <malloc+0xf8>
        return 0;
 aba:	b8 00 00 00 00       	mov    $0x0,%eax
 abf:	eb 18                	jmp    ad9 <malloc+0x110>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 ac1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 ac5:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
 ac9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 acd:	48 8b 00             	mov    (%rax),%rax
 ad0:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
 ad4:	e9 54 ff ff ff       	jmp    a2d <malloc+0x64>
  }
}
 ad9:	c9                   	leave
 ada:	c3                   	ret

0000000000000adb <createRoot>:
#include "set.h"
#include "user.h"

//TODO: Να μην είναι περιορισμένο σε int

Set* createRoot(){
 adb:	55                   	push   %rbp
 adc:	48 89 e5             	mov    %rsp,%rbp
 adf:	48 83 ec 10          	sub    $0x10,%rsp
    //Αρχικοποίηση του Set
    Set *set = malloc(sizeof(Set));
 ae3:	bf 10 00 00 00       	mov    $0x10,%edi
 ae8:	e8 dc fe ff ff       	call   9c9 <malloc>
 aed:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    set->size = 0;
 af1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 af5:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%rax)
    set->root = NULL;
 afc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b00:	48 c7 00 00 00 00 00 	movq   $0x0,(%rax)
    return set;
 b07:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
 b0b:	c9                   	leave
 b0c:	c3                   	ret

0000000000000b0d <createNode>:

void createNode(int i, Set *set){
 b0d:	55                   	push   %rbp
 b0e:	48 89 e5             	mov    %rsp,%rbp
 b11:	48 83 ec 20          	sub    $0x20,%rsp
 b15:	89 7d ec             	mov    %edi,-0x14(%rbp)
 b18:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    Η συνάρτηση αυτή δημιουργεί ένα νέο SetNode με την τιμή i και εφόσον δεν υπάρχει στο Set το προσθέτει στο τέλος του συνόλου.
    Σημείωση: Ίσως υπάρχει καλύτερος τρόπος για την υλοποίηση.
    */

    //Αρχικοποίηση του SetNode
    SetNode *temp = malloc(sizeof(SetNode));
 b1c:	bf 10 00 00 00       	mov    $0x10,%edi
 b21:	e8 a3 fe ff ff       	call   9c9 <malloc>
 b26:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    temp->i = i;
 b2a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 b2e:	8b 55 ec             	mov    -0x14(%rbp),%edx
 b31:	89 10                	mov    %edx,(%rax)
    temp->next = NULL;
 b33:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 b37:	48 c7 40 08 00 00 00 	movq   $0x0,0x8(%rax)
 b3e:	00 

    //Έλεγχος ύπαρξης του i
    SetNode *curr = set->root;//Ξεκινάει από την root
 b3f:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
 b43:	48 8b 00             	mov    (%rax),%rax
 b46:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(curr != NULL) { //Εφόσον το Set δεν είναι άδειο
 b4a:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
 b4f:	74 34                	je     b85 <createNode+0x78>
        while (curr->next != NULL){ //Εφόσον υπάρχει επόμενο node
 b51:	eb 25                	jmp    b78 <createNode+0x6b>
            if (curr->i == i){ //Αν το i υπάρχει στο σύνολο
 b53:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b57:	8b 00                	mov    (%rax),%eax
 b59:	39 45 ec             	cmp    %eax,-0x14(%rbp)
 b5c:	75 0e                	jne    b6c <createNode+0x5f>
                free(temp); 
 b5e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 b62:	48 89 c7             	mov    %rax,%rdi
 b65:	e8 d4 fc ff ff       	call   83e <free>
                return; //Δεν εκτελούμε την υπόλοιπη συνάρτηση
 b6a:	eb 4e                	jmp    bba <createNode+0xad>
            }
            curr = curr->next; //Επόμενο SetNode
 b6c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b70:	48 8b 40 08          	mov    0x8(%rax),%rax
 b74:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
        while (curr->next != NULL){ //Εφόσον υπάρχει επόμενο node
 b78:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b7c:	48 8b 40 08          	mov    0x8(%rax),%rax
 b80:	48 85 c0             	test   %rax,%rax
 b83:	75 ce                	jne    b53 <createNode+0x46>
        }
    }
    /*
    Ο έλεγχος στην if είναι απαραίτητος για να ελεγχθεί το τελευταίο SetNode.
    */
    if (curr->i != i) attachNode(set, curr, temp); 
 b85:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b89:	8b 00                	mov    (%rax),%eax
 b8b:	39 45 ec             	cmp    %eax,-0x14(%rbp)
 b8e:	74 1e                	je     bae <createNode+0xa1>
 b90:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
 b94:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
 b98:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
 b9c:	48 89 ce             	mov    %rcx,%rsi
 b9f:	48 89 c7             	mov    %rax,%rdi
 ba2:	b8 00 00 00 00       	mov    $0x0,%eax
 ba7:	e8 10 00 00 00       	call   bbc <attachNode>
 bac:	eb 0c                	jmp    bba <createNode+0xad>
    else free(temp);
 bae:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 bb2:	48 89 c7             	mov    %rax,%rdi
 bb5:	e8 84 fc ff ff       	call   83e <free>
}
 bba:	c9                   	leave
 bbb:	c3                   	ret

0000000000000bbc <attachNode>:

void attachNode(Set *set, SetNode *curr, SetNode *temp){
 bbc:	55                   	push   %rbp
 bbd:	48 89 e5             	mov    %rsp,%rbp
 bc0:	48 83 ec 18          	sub    $0x18,%rsp
 bc4:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
 bc8:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
 bcc:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
    //Βάζουμε το temp στο τέλος του Set
    if(set->size == 0) set->root = temp;
 bd0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 bd4:	8b 40 08             	mov    0x8(%rax),%eax
 bd7:	85 c0                	test   %eax,%eax
 bd9:	75 0d                	jne    be8 <attachNode+0x2c>
 bdb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 bdf:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
 be3:	48 89 10             	mov    %rdx,(%rax)
 be6:	eb 0c                	jmp    bf4 <attachNode+0x38>
    else curr->next = temp;
 be8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 bec:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
 bf0:	48 89 50 08          	mov    %rdx,0x8(%rax)
    set->size += 1;
 bf4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 bf8:	8b 40 08             	mov    0x8(%rax),%eax
 bfb:	8d 50 01             	lea    0x1(%rax),%edx
 bfe:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 c02:	89 50 08             	mov    %edx,0x8(%rax)
}
 c05:	90                   	nop
 c06:	c9                   	leave
 c07:	c3                   	ret

0000000000000c08 <deleteSet>:

void deleteSet(Set *set){
 c08:	55                   	push   %rbp
 c09:	48 89 e5             	mov    %rsp,%rbp
 c0c:	48 83 ec 20          	sub    $0x20,%rsp
 c10:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    if (set == NULL) return; //Αν ο χρήστης είναι ΜΛΚ!
 c14:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
 c19:	74 42                	je     c5d <deleteSet+0x55>
    SetNode *temp;
    SetNode *curr = set->root; //Ξεκινάμε από το root
 c1b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 c1f:	48 8b 00             	mov    (%rax),%rax
 c22:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    while (curr != NULL){ 
 c26:	eb 20                	jmp    c48 <deleteSet+0x40>
        temp = curr->next; //Αναφορά στο επόμενο SetNode
 c28:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 c2c:	48 8b 40 08          	mov    0x8(%rax),%rax
 c30:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
        free(curr); //Απελευθέρωση της curr
 c34:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 c38:	48 89 c7             	mov    %rax,%rdi
 c3b:	e8 fe fb ff ff       	call   83e <free>
        curr = temp;
 c40:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 c44:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    while (curr != NULL){ 
 c48:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
 c4d:	75 d9                	jne    c28 <deleteSet+0x20>
    }
    free(set); //Διαγραφή του Set
 c4f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 c53:	48 89 c7             	mov    %rax,%rdi
 c56:	e8 e3 fb ff ff       	call   83e <free>
 c5b:	eb 01                	jmp    c5e <deleteSet+0x56>
    if (set == NULL) return; //Αν ο χρήστης είναι ΜΛΚ!
 c5d:	90                   	nop
}
 c5e:	c9                   	leave
 c5f:	c3                   	ret

0000000000000c60 <getNodeAtPosition>:

SetNode* getNodeAtPosition(Set *set, int i){
 c60:	55                   	push   %rbp
 c61:	48 89 e5             	mov    %rsp,%rbp
 c64:	48 83 ec 20          	sub    $0x20,%rsp
 c68:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
 c6c:	89 75 e4             	mov    %esi,-0x1c(%rbp)
    if (set == NULL || set->root == NULL) return NULL; //Αν ο χρήστης είναι ΜΛΚ!
 c6f:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
 c74:	74 0c                	je     c82 <getNodeAtPosition+0x22>
 c76:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 c7a:	48 8b 00             	mov    (%rax),%rax
 c7d:	48 85 c0             	test   %rax,%rax
 c80:	75 07                	jne    c89 <getNodeAtPosition+0x29>
 c82:	b8 00 00 00 00       	mov    $0x0,%eax
 c87:	eb 3d                	jmp    cc6 <getNodeAtPosition+0x66>

    SetNode *curr = set->root;
 c89:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 c8d:	48 8b 00             	mov    (%rax),%rax
 c90:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    int n;

    for(n = 0; n<i && curr->next != NULL; n++) curr = curr->next; //Ο έλεγχος εδω είναι: n<i && curr->next != NULL
 c94:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
 c9b:	eb 10                	jmp    cad <getNodeAtPosition+0x4d>
 c9d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 ca1:	48 8b 40 08          	mov    0x8(%rax),%rax
 ca5:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 ca9:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
 cad:	8b 45 f4             	mov    -0xc(%rbp),%eax
 cb0:	3b 45 e4             	cmp    -0x1c(%rbp),%eax
 cb3:	7d 0d                	jge    cc2 <getNodeAtPosition+0x62>
 cb5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 cb9:	48 8b 40 08          	mov    0x8(%rax),%rax
 cbd:	48 85 c0             	test   %rax,%rax
 cc0:	75 db                	jne    c9d <getNodeAtPosition+0x3d>
    return curr;
 cc2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 cc6:	c9                   	leave
 cc7:	c3                   	ret
