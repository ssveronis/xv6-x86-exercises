
fs/killrandom:     file format elf64-x86-64


Disassembly of section .text:

0000000000000000 <main>:
#include "types.h"
#include "user.h"

int main(int argc, char *argv[]){
   0:	55                   	push   %rbp
   1:	48 89 e5             	mov    %rsp,%rbp
   4:	48 83 ec 10          	sub    $0x10,%rsp
   8:	89 7d fc             	mov    %edi,-0x4(%rbp)
   b:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
    killrandom();
   f:	e8 b8 03 00 00       	call   3cc <killrandom>
    exit();
  14:	e8 f3 02 00 00       	call   30c <exit>

0000000000000019 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
  19:	55                   	push   %rbp
  1a:	48 89 e5             	mov    %rsp,%rbp
  1d:	48 83 ec 10          	sub    $0x10,%rsp
  21:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  25:	89 75 f4             	mov    %esi,-0xc(%rbp)
  28:	89 55 f0             	mov    %edx,-0x10(%rbp)
  asm volatile("cld; rep stosb" :
  2b:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
  2f:	8b 55 f0             	mov    -0x10(%rbp),%edx
  32:	8b 45 f4             	mov    -0xc(%rbp),%eax
  35:	48 89 ce             	mov    %rcx,%rsi
  38:	48 89 f7             	mov    %rsi,%rdi
  3b:	89 d1                	mov    %edx,%ecx
  3d:	fc                   	cld
  3e:	f3 aa                	rep stos %al,%es:(%rdi)
  40:	89 ca                	mov    %ecx,%edx
  42:	48 89 fe             	mov    %rdi,%rsi
  45:	48 89 75 f8          	mov    %rsi,-0x8(%rbp)
  49:	89 55 f0             	mov    %edx,-0x10(%rbp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
  4c:	90                   	nop
  4d:	c9                   	leave
  4e:	c3                   	ret

000000000000004f <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
  4f:	55                   	push   %rbp
  50:	48 89 e5             	mov    %rsp,%rbp
  53:	48 83 ec 20          	sub    $0x20,%rsp
  57:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  5b:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  char *os;

  os = s;
  5f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  63:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  while((*s++ = *t++) != 0)
  67:	90                   	nop
  68:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  6c:	48 8d 42 01          	lea    0x1(%rdx),%rax
  70:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  74:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  78:	48 8d 48 01          	lea    0x1(%rax),%rcx
  7c:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  80:	0f b6 12             	movzbl (%rdx),%edx
  83:	88 10                	mov    %dl,(%rax)
  85:	0f b6 00             	movzbl (%rax),%eax
  88:	84 c0                	test   %al,%al
  8a:	75 dc                	jne    68 <strcpy+0x19>
    ;
  return os;
  8c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
  90:	c9                   	leave
  91:	c3                   	ret

0000000000000092 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  92:	55                   	push   %rbp
  93:	48 89 e5             	mov    %rsp,%rbp
  96:	48 83 ec 10          	sub    $0x10,%rsp
  9a:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  9e:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  while(*p && *p == *q)
  a2:	eb 0a                	jmp    ae <strcmp+0x1c>
    p++, q++;
  a4:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  a9:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  while(*p && *p == *q)
  ae:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  b2:	0f b6 00             	movzbl (%rax),%eax
  b5:	84 c0                	test   %al,%al
  b7:	74 12                	je     cb <strcmp+0x39>
  b9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  bd:	0f b6 10             	movzbl (%rax),%edx
  c0:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  c4:	0f b6 00             	movzbl (%rax),%eax
  c7:	38 c2                	cmp    %al,%dl
  c9:	74 d9                	je     a4 <strcmp+0x12>
  return (uchar)*p - (uchar)*q;
  cb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  cf:	0f b6 00             	movzbl (%rax),%eax
  d2:	0f b6 d0             	movzbl %al,%edx
  d5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  d9:	0f b6 00             	movzbl (%rax),%eax
  dc:	0f b6 c0             	movzbl %al,%eax
  df:	29 c2                	sub    %eax,%edx
  e1:	89 d0                	mov    %edx,%eax
}
  e3:	c9                   	leave
  e4:	c3                   	ret

00000000000000e5 <strlen>:

uint
strlen(char *s)
{
  e5:	55                   	push   %rbp
  e6:	48 89 e5             	mov    %rsp,%rbp
  e9:	48 83 ec 18          	sub    $0x18,%rsp
  ed:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  int n;

  for(n = 0; s[n]; n++)
  f1:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  f8:	eb 04                	jmp    fe <strlen+0x19>
  fa:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  fe:	8b 45 fc             	mov    -0x4(%rbp),%eax
 101:	48 63 d0             	movslq %eax,%rdx
 104:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 108:	48 01 d0             	add    %rdx,%rax
 10b:	0f b6 00             	movzbl (%rax),%eax
 10e:	84 c0                	test   %al,%al
 110:	75 e8                	jne    fa <strlen+0x15>
    ;
  return n;
 112:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
 115:	c9                   	leave
 116:	c3                   	ret

0000000000000117 <memset>:

void*
memset(void *dst, int c, uint n)
{
 117:	55                   	push   %rbp
 118:	48 89 e5             	mov    %rsp,%rbp
 11b:	48 83 ec 10          	sub    $0x10,%rsp
 11f:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
 123:	89 75 f4             	mov    %esi,-0xc(%rbp)
 126:	89 55 f0             	mov    %edx,-0x10(%rbp)
  stosb(dst, c, n);
 129:	8b 55 f0             	mov    -0x10(%rbp),%edx
 12c:	8b 4d f4             	mov    -0xc(%rbp),%ecx
 12f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 133:	89 ce                	mov    %ecx,%esi
 135:	48 89 c7             	mov    %rax,%rdi
 138:	e8 dc fe ff ff       	call   19 <stosb>
  return dst;
 13d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
 141:	c9                   	leave
 142:	c3                   	ret

0000000000000143 <strchr>:

char*
strchr(const char *s, char c)
{
 143:	55                   	push   %rbp
 144:	48 89 e5             	mov    %rsp,%rbp
 147:	48 83 ec 10          	sub    $0x10,%rsp
 14b:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
 14f:	89 f0                	mov    %esi,%eax
 151:	88 45 f4             	mov    %al,-0xc(%rbp)
  for(; *s; s++)
 154:	eb 17                	jmp    16d <strchr+0x2a>
    if(*s == c)
 156:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 15a:	0f b6 00             	movzbl (%rax),%eax
 15d:	38 45 f4             	cmp    %al,-0xc(%rbp)
 160:	75 06                	jne    168 <strchr+0x25>
      return (char*)s;
 162:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 166:	eb 15                	jmp    17d <strchr+0x3a>
  for(; *s; s++)
 168:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
 16d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 171:	0f b6 00             	movzbl (%rax),%eax
 174:	84 c0                	test   %al,%al
 176:	75 de                	jne    156 <strchr+0x13>
  return 0;
 178:	b8 00 00 00 00       	mov    $0x0,%eax
}
 17d:	c9                   	leave
 17e:	c3                   	ret

000000000000017f <gets>:

char*
gets(char *buf, int max)
{
 17f:	55                   	push   %rbp
 180:	48 89 e5             	mov    %rsp,%rbp
 183:	48 83 ec 20          	sub    $0x20,%rsp
 187:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
 18b:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 18e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
 195:	eb 48                	jmp    1df <gets+0x60>
    cc = read(0, &c, 1);
 197:	48 8d 45 f7          	lea    -0x9(%rbp),%rax
 19b:	ba 01 00 00 00       	mov    $0x1,%edx
 1a0:	48 89 c6             	mov    %rax,%rsi
 1a3:	bf 00 00 00 00       	mov    $0x0,%edi
 1a8:	e8 77 01 00 00       	call   324 <read>
 1ad:	89 45 f8             	mov    %eax,-0x8(%rbp)
    if(cc < 1)
 1b0:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
 1b4:	7e 36                	jle    1ec <gets+0x6d>
      break;
    buf[i++] = c;
 1b6:	8b 45 fc             	mov    -0x4(%rbp),%eax
 1b9:	8d 50 01             	lea    0x1(%rax),%edx
 1bc:	89 55 fc             	mov    %edx,-0x4(%rbp)
 1bf:	48 63 d0             	movslq %eax,%rdx
 1c2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 1c6:	48 01 c2             	add    %rax,%rdx
 1c9:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
 1cd:	88 02                	mov    %al,(%rdx)
    if(c == '\n' || c == '\r')
 1cf:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
 1d3:	3c 0a                	cmp    $0xa,%al
 1d5:	74 16                	je     1ed <gets+0x6e>
 1d7:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
 1db:	3c 0d                	cmp    $0xd,%al
 1dd:	74 0e                	je     1ed <gets+0x6e>
  for(i=0; i+1 < max; ){
 1df:	8b 45 fc             	mov    -0x4(%rbp),%eax
 1e2:	83 c0 01             	add    $0x1,%eax
 1e5:	39 45 e4             	cmp    %eax,-0x1c(%rbp)
 1e8:	7f ad                	jg     197 <gets+0x18>
 1ea:	eb 01                	jmp    1ed <gets+0x6e>
      break;
 1ec:	90                   	nop
      break;
  }
  buf[i] = '\0';
 1ed:	8b 45 fc             	mov    -0x4(%rbp),%eax
 1f0:	48 63 d0             	movslq %eax,%rdx
 1f3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 1f7:	48 01 d0             	add    %rdx,%rax
 1fa:	c6 00 00             	movb   $0x0,(%rax)
  return buf;
 1fd:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
 201:	c9                   	leave
 202:	c3                   	ret

0000000000000203 <stat>:

int
stat(char *n, struct stat *st)
{
 203:	55                   	push   %rbp
 204:	48 89 e5             	mov    %rsp,%rbp
 207:	48 83 ec 20          	sub    $0x20,%rsp
 20b:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
 20f:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 213:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 217:	be 00 00 00 00       	mov    $0x0,%esi
 21c:	48 89 c7             	mov    %rax,%rdi
 21f:	e8 28 01 00 00       	call   34c <open>
 224:	89 45 fc             	mov    %eax,-0x4(%rbp)
  if(fd < 0)
 227:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
 22b:	79 07                	jns    234 <stat+0x31>
    return -1;
 22d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 232:	eb 21                	jmp    255 <stat+0x52>
  r = fstat(fd, st);
 234:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
 238:	8b 45 fc             	mov    -0x4(%rbp),%eax
 23b:	48 89 d6             	mov    %rdx,%rsi
 23e:	89 c7                	mov    %eax,%edi
 240:	e8 1f 01 00 00       	call   364 <fstat>
 245:	89 45 f8             	mov    %eax,-0x8(%rbp)
  close(fd);
 248:	8b 45 fc             	mov    -0x4(%rbp),%eax
 24b:	89 c7                	mov    %eax,%edi
 24d:	e8 e2 00 00 00       	call   334 <close>
  return r;
 252:	8b 45 f8             	mov    -0x8(%rbp),%eax
}
 255:	c9                   	leave
 256:	c3                   	ret

0000000000000257 <atoi>:

int
atoi(const char *s)
{
 257:	55                   	push   %rbp
 258:	48 89 e5             	mov    %rsp,%rbp
 25b:	48 83 ec 18          	sub    $0x18,%rsp
 25f:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  int n;

  n = 0;
 263:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  while('0' <= *s && *s <= '9')
 26a:	eb 28                	jmp    294 <atoi+0x3d>
    n = n*10 + *s++ - '0';
 26c:	8b 55 fc             	mov    -0x4(%rbp),%edx
 26f:	89 d0                	mov    %edx,%eax
 271:	c1 e0 02             	shl    $0x2,%eax
 274:	01 d0                	add    %edx,%eax
 276:	01 c0                	add    %eax,%eax
 278:	89 c1                	mov    %eax,%ecx
 27a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 27e:	48 8d 50 01          	lea    0x1(%rax),%rdx
 282:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
 286:	0f b6 00             	movzbl (%rax),%eax
 289:	0f be c0             	movsbl %al,%eax
 28c:	01 c8                	add    %ecx,%eax
 28e:	83 e8 30             	sub    $0x30,%eax
 291:	89 45 fc             	mov    %eax,-0x4(%rbp)
  while('0' <= *s && *s <= '9')
 294:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 298:	0f b6 00             	movzbl (%rax),%eax
 29b:	3c 2f                	cmp    $0x2f,%al
 29d:	7e 0b                	jle    2aa <atoi+0x53>
 29f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 2a3:	0f b6 00             	movzbl (%rax),%eax
 2a6:	3c 39                	cmp    $0x39,%al
 2a8:	7e c2                	jle    26c <atoi+0x15>
  return n;
 2aa:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
 2ad:	c9                   	leave
 2ae:	c3                   	ret

00000000000002af <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 2af:	55                   	push   %rbp
 2b0:	48 89 e5             	mov    %rsp,%rbp
 2b3:	48 83 ec 28          	sub    $0x28,%rsp
 2b7:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
 2bb:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
 2bf:	89 55 dc             	mov    %edx,-0x24(%rbp)
  char *dst, *src;
  
  dst = vdst;
 2c2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 2c6:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  src = vsrc;
 2ca:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
 2ce:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  while(n-- > 0)
 2d2:	eb 1d                	jmp    2f1 <memmove+0x42>
    *dst++ = *src++;
 2d4:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
 2d8:	48 8d 42 01          	lea    0x1(%rdx),%rax
 2dc:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
 2e0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 2e4:	48 8d 48 01          	lea    0x1(%rax),%rcx
 2e8:	48 89 4d f8          	mov    %rcx,-0x8(%rbp)
 2ec:	0f b6 12             	movzbl (%rdx),%edx
 2ef:	88 10                	mov    %dl,(%rax)
  while(n-- > 0)
 2f1:	8b 45 dc             	mov    -0x24(%rbp),%eax
 2f4:	8d 50 ff             	lea    -0x1(%rax),%edx
 2f7:	89 55 dc             	mov    %edx,-0x24(%rbp)
 2fa:	85 c0                	test   %eax,%eax
 2fc:	7f d6                	jg     2d4 <memmove+0x25>
  return vdst;
 2fe:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
 302:	c9                   	leave
 303:	c3                   	ret

0000000000000304 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 304:	b8 01 00 00 00       	mov    $0x1,%eax
 309:	cd 40                	int    $0x40
 30b:	c3                   	ret

000000000000030c <exit>:
SYSCALL(exit)
 30c:	b8 02 00 00 00       	mov    $0x2,%eax
 311:	cd 40                	int    $0x40
 313:	c3                   	ret

0000000000000314 <wait>:
SYSCALL(wait)
 314:	b8 03 00 00 00       	mov    $0x3,%eax
 319:	cd 40                	int    $0x40
 31b:	c3                   	ret

000000000000031c <pipe>:
SYSCALL(pipe)
 31c:	b8 04 00 00 00       	mov    $0x4,%eax
 321:	cd 40                	int    $0x40
 323:	c3                   	ret

0000000000000324 <read>:
SYSCALL(read)
 324:	b8 05 00 00 00       	mov    $0x5,%eax
 329:	cd 40                	int    $0x40
 32b:	c3                   	ret

000000000000032c <write>:
SYSCALL(write)
 32c:	b8 10 00 00 00       	mov    $0x10,%eax
 331:	cd 40                	int    $0x40
 333:	c3                   	ret

0000000000000334 <close>:
SYSCALL(close)
 334:	b8 15 00 00 00       	mov    $0x15,%eax
 339:	cd 40                	int    $0x40
 33b:	c3                   	ret

000000000000033c <kill>:
SYSCALL(kill)
 33c:	b8 06 00 00 00       	mov    $0x6,%eax
 341:	cd 40                	int    $0x40
 343:	c3                   	ret

0000000000000344 <exec>:
SYSCALL(exec)
 344:	b8 07 00 00 00       	mov    $0x7,%eax
 349:	cd 40                	int    $0x40
 34b:	c3                   	ret

000000000000034c <open>:
SYSCALL(open)
 34c:	b8 0f 00 00 00       	mov    $0xf,%eax
 351:	cd 40                	int    $0x40
 353:	c3                   	ret

0000000000000354 <mknod>:
SYSCALL(mknod)
 354:	b8 11 00 00 00       	mov    $0x11,%eax
 359:	cd 40                	int    $0x40
 35b:	c3                   	ret

000000000000035c <unlink>:
SYSCALL(unlink)
 35c:	b8 12 00 00 00       	mov    $0x12,%eax
 361:	cd 40                	int    $0x40
 363:	c3                   	ret

0000000000000364 <fstat>:
SYSCALL(fstat)
 364:	b8 08 00 00 00       	mov    $0x8,%eax
 369:	cd 40                	int    $0x40
 36b:	c3                   	ret

000000000000036c <link>:
SYSCALL(link)
 36c:	b8 13 00 00 00       	mov    $0x13,%eax
 371:	cd 40                	int    $0x40
 373:	c3                   	ret

0000000000000374 <mkdir>:
SYSCALL(mkdir)
 374:	b8 14 00 00 00       	mov    $0x14,%eax
 379:	cd 40                	int    $0x40
 37b:	c3                   	ret

000000000000037c <chdir>:
SYSCALL(chdir)
 37c:	b8 09 00 00 00       	mov    $0x9,%eax
 381:	cd 40                	int    $0x40
 383:	c3                   	ret

0000000000000384 <dup>:
SYSCALL(dup)
 384:	b8 0a 00 00 00       	mov    $0xa,%eax
 389:	cd 40                	int    $0x40
 38b:	c3                   	ret

000000000000038c <getpid>:
SYSCALL(getpid)
 38c:	b8 0b 00 00 00       	mov    $0xb,%eax
 391:	cd 40                	int    $0x40
 393:	c3                   	ret

0000000000000394 <sbrk>:
SYSCALL(sbrk)
 394:	b8 0c 00 00 00       	mov    $0xc,%eax
 399:	cd 40                	int    $0x40
 39b:	c3                   	ret

000000000000039c <sleep>:
SYSCALL(sleep)
 39c:	b8 0d 00 00 00       	mov    $0xd,%eax
 3a1:	cd 40                	int    $0x40
 3a3:	c3                   	ret

00000000000003a4 <uptime>:
SYSCALL(uptime)
 3a4:	b8 0e 00 00 00       	mov    $0xe,%eax
 3a9:	cd 40                	int    $0x40
 3ab:	c3                   	ret

00000000000003ac <getpinfo>:
SYSCALL(getpinfo)
 3ac:	b8 18 00 00 00       	mov    $0x18,%eax
 3b1:	cd 40                	int    $0x40
 3b3:	c3                   	ret

00000000000003b4 <getfavnum>:
SYSCALL(getfavnum)
 3b4:	b8 19 00 00 00       	mov    $0x19,%eax
 3b9:	cd 40                	int    $0x40
 3bb:	c3                   	ret

00000000000003bc <shutdown>:
SYSCALL(shutdown)
 3bc:	b8 1a 00 00 00       	mov    $0x1a,%eax
 3c1:	cd 40                	int    $0x40
 3c3:	c3                   	ret

00000000000003c4 <getcount>:
SYSCALL(getcount)
 3c4:	b8 1b 00 00 00       	mov    $0x1b,%eax
 3c9:	cd 40                	int    $0x40
 3cb:	c3                   	ret

00000000000003cc <killrandom>:
 3cc:	b8 1c 00 00 00       	mov    $0x1c,%eax
 3d1:	cd 40                	int    $0x40
 3d3:	c3                   	ret

00000000000003d4 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 3d4:	55                   	push   %rbp
 3d5:	48 89 e5             	mov    %rsp,%rbp
 3d8:	48 83 ec 10          	sub    $0x10,%rsp
 3dc:	89 7d fc             	mov    %edi,-0x4(%rbp)
 3df:	89 f0                	mov    %esi,%eax
 3e1:	88 45 f8             	mov    %al,-0x8(%rbp)
  write(fd, &c, 1);
 3e4:	48 8d 4d f8          	lea    -0x8(%rbp),%rcx
 3e8:	8b 45 fc             	mov    -0x4(%rbp),%eax
 3eb:	ba 01 00 00 00       	mov    $0x1,%edx
 3f0:	48 89 ce             	mov    %rcx,%rsi
 3f3:	89 c7                	mov    %eax,%edi
 3f5:	e8 32 ff ff ff       	call   32c <write>
}
 3fa:	90                   	nop
 3fb:	c9                   	leave
 3fc:	c3                   	ret

00000000000003fd <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 3fd:	55                   	push   %rbp
 3fe:	48 89 e5             	mov    %rsp,%rbp
 401:	48 83 ec 30          	sub    $0x30,%rsp
 405:	89 7d dc             	mov    %edi,-0x24(%rbp)
 408:	89 75 d8             	mov    %esi,-0x28(%rbp)
 40b:	89 55 d4             	mov    %edx,-0x2c(%rbp)
 40e:	89 4d d0             	mov    %ecx,-0x30(%rbp)
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 411:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
  if(sgn && xx < 0){
 418:	83 7d d0 00          	cmpl   $0x0,-0x30(%rbp)
 41c:	74 17                	je     435 <printint+0x38>
 41e:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
 422:	79 11                	jns    435 <printint+0x38>
    neg = 1;
 424:	c7 45 f8 01 00 00 00 	movl   $0x1,-0x8(%rbp)
    x = -xx;
 42b:	8b 45 d8             	mov    -0x28(%rbp),%eax
 42e:	f7 d8                	neg    %eax
 430:	89 45 f4             	mov    %eax,-0xc(%rbp)
 433:	eb 06                	jmp    43b <printint+0x3e>
  } else {
    x = xx;
 435:	8b 45 d8             	mov    -0x28(%rbp),%eax
 438:	89 45 f4             	mov    %eax,-0xc(%rbp)
  }

  i = 0;
 43b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  do{
    buf[i++] = digits[x % base];
 442:	8b 4d d4             	mov    -0x2c(%rbp),%ecx
 445:	8b 45 f4             	mov    -0xc(%rbp),%eax
 448:	ba 00 00 00 00       	mov    $0x0,%edx
 44d:	f7 f1                	div    %ecx
 44f:	89 d1                	mov    %edx,%ecx
 451:	8b 45 fc             	mov    -0x4(%rbp),%eax
 454:	8d 50 01             	lea    0x1(%rax),%edx
 457:	89 55 fc             	mov    %edx,-0x4(%rbp)
 45a:	89 ca                	mov    %ecx,%edx
 45c:	0f b6 92 90 0f 00 00 	movzbl 0xf90(%rdx),%edx
 463:	48 98                	cltq
 465:	88 54 05 e0          	mov    %dl,-0x20(%rbp,%rax,1)
  }while((x /= base) != 0);
 469:	8b 75 d4             	mov    -0x2c(%rbp),%esi
 46c:	8b 45 f4             	mov    -0xc(%rbp),%eax
 46f:	ba 00 00 00 00       	mov    $0x0,%edx
 474:	f7 f6                	div    %esi
 476:	89 45 f4             	mov    %eax,-0xc(%rbp)
 479:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
 47d:	75 c3                	jne    442 <printint+0x45>
  if(neg)
 47f:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
 483:	74 2b                	je     4b0 <printint+0xb3>
    buf[i++] = '-';
 485:	8b 45 fc             	mov    -0x4(%rbp),%eax
 488:	8d 50 01             	lea    0x1(%rax),%edx
 48b:	89 55 fc             	mov    %edx,-0x4(%rbp)
 48e:	48 98                	cltq
 490:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%rbp,%rax,1)

  while(--i >= 0)
 495:	eb 19                	jmp    4b0 <printint+0xb3>
    putc(fd, buf[i]);
 497:	8b 45 fc             	mov    -0x4(%rbp),%eax
 49a:	48 98                	cltq
 49c:	0f b6 44 05 e0       	movzbl -0x20(%rbp,%rax,1),%eax
 4a1:	0f be d0             	movsbl %al,%edx
 4a4:	8b 45 dc             	mov    -0x24(%rbp),%eax
 4a7:	89 d6                	mov    %edx,%esi
 4a9:	89 c7                	mov    %eax,%edi
 4ab:	e8 24 ff ff ff       	call   3d4 <putc>
  while(--i >= 0)
 4b0:	83 6d fc 01          	subl   $0x1,-0x4(%rbp)
 4b4:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
 4b8:	79 dd                	jns    497 <printint+0x9a>
}
 4ba:	90                   	nop
 4bb:	90                   	nop
 4bc:	c9                   	leave
 4bd:	c3                   	ret

00000000000004be <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 4be:	55                   	push   %rbp
 4bf:	48 89 e5             	mov    %rsp,%rbp
 4c2:	48 81 ec f0 00 00 00 	sub    $0xf0,%rsp
 4c9:	89 bd 1c ff ff ff    	mov    %edi,-0xe4(%rbp)
 4cf:	48 89 b5 10 ff ff ff 	mov    %rsi,-0xf0(%rbp)
 4d6:	48 89 95 60 ff ff ff 	mov    %rdx,-0xa0(%rbp)
 4dd:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
 4e4:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
 4eb:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
 4f2:	84 c0                	test   %al,%al
 4f4:	74 20                	je     516 <printf+0x58>
 4f6:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
 4fa:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
 4fe:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
 502:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
 506:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
 50a:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
 50e:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
 512:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  va_list ap;
  char *s;
  int c, i, state;
  va_start(ap, fmt);
 516:	c7 85 20 ff ff ff 10 	movl   $0x10,-0xe0(%rbp)
 51d:	00 00 00 
 520:	c7 85 24 ff ff ff 30 	movl   $0x30,-0xdc(%rbp)
 527:	00 00 00 
 52a:	48 8d 45 10          	lea    0x10(%rbp),%rax
 52e:	48 89 85 28 ff ff ff 	mov    %rax,-0xd8(%rbp)
 535:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
 53c:	48 89 85 30 ff ff ff 	mov    %rax,-0xd0(%rbp)

  state = 0;
 543:	c7 85 40 ff ff ff 00 	movl   $0x0,-0xc0(%rbp)
 54a:	00 00 00 
  for(i = 0; fmt[i]; i++){
 54d:	c7 85 44 ff ff ff 00 	movl   $0x0,-0xbc(%rbp)
 554:	00 00 00 
 557:	e9 a8 02 00 00       	jmp    804 <printf+0x346>
    c = fmt[i] & 0xff;
 55c:	8b 85 44 ff ff ff    	mov    -0xbc(%rbp),%eax
 562:	48 63 d0             	movslq %eax,%rdx
 565:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
 56c:	48 01 d0             	add    %rdx,%rax
 56f:	0f b6 00             	movzbl (%rax),%eax
 572:	0f be c0             	movsbl %al,%eax
 575:	25 ff 00 00 00       	and    $0xff,%eax
 57a:	89 85 3c ff ff ff    	mov    %eax,-0xc4(%rbp)
    if(state == 0){
 580:	83 bd 40 ff ff ff 00 	cmpl   $0x0,-0xc0(%rbp)
 587:	75 35                	jne    5be <printf+0x100>
      if(c == '%'){
 589:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
 590:	75 0f                	jne    5a1 <printf+0xe3>
        state = '%';
 592:	c7 85 40 ff ff ff 25 	movl   $0x25,-0xc0(%rbp)
 599:	00 00 00 
 59c:	e9 5c 02 00 00       	jmp    7fd <printf+0x33f>
      } else {
        putc(fd, c);
 5a1:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
 5a7:	0f be d0             	movsbl %al,%edx
 5aa:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 5b0:	89 d6                	mov    %edx,%esi
 5b2:	89 c7                	mov    %eax,%edi
 5b4:	e8 1b fe ff ff       	call   3d4 <putc>
 5b9:	e9 3f 02 00 00       	jmp    7fd <printf+0x33f>
      }
    } else if(state == '%'){
 5be:	83 bd 40 ff ff ff 25 	cmpl   $0x25,-0xc0(%rbp)
 5c5:	0f 85 32 02 00 00    	jne    7fd <printf+0x33f>
      if(c == 'd'){
 5cb:	83 bd 3c ff ff ff 64 	cmpl   $0x64,-0xc4(%rbp)
 5d2:	75 5e                	jne    632 <printf+0x174>
        printint(fd, va_arg(ap, int), 10, 1);
 5d4:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 5da:	83 f8 2f             	cmp    $0x2f,%eax
 5dd:	77 23                	ja     602 <printf+0x144>
 5df:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 5e6:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 5ec:	89 d2                	mov    %edx,%edx
 5ee:	48 01 d0             	add    %rdx,%rax
 5f1:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 5f7:	83 c2 08             	add    $0x8,%edx
 5fa:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 600:	eb 12                	jmp    614 <printf+0x156>
 602:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 609:	48 8d 50 08          	lea    0x8(%rax),%rdx
 60d:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 614:	8b 30                	mov    (%rax),%esi
 616:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 61c:	b9 01 00 00 00       	mov    $0x1,%ecx
 621:	ba 0a 00 00 00       	mov    $0xa,%edx
 626:	89 c7                	mov    %eax,%edi
 628:	e8 d0 fd ff ff       	call   3fd <printint>
 62d:	e9 c1 01 00 00       	jmp    7f3 <printf+0x335>
      } else if(c == 'x' || c == 'p'){
 632:	83 bd 3c ff ff ff 78 	cmpl   $0x78,-0xc4(%rbp)
 639:	74 09                	je     644 <printf+0x186>
 63b:	83 bd 3c ff ff ff 70 	cmpl   $0x70,-0xc4(%rbp)
 642:	75 5e                	jne    6a2 <printf+0x1e4>
        printint(fd, va_arg(ap, int), 16, 0);
 644:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 64a:	83 f8 2f             	cmp    $0x2f,%eax
 64d:	77 23                	ja     672 <printf+0x1b4>
 64f:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 656:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 65c:	89 d2                	mov    %edx,%edx
 65e:	48 01 d0             	add    %rdx,%rax
 661:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 667:	83 c2 08             	add    $0x8,%edx
 66a:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 670:	eb 12                	jmp    684 <printf+0x1c6>
 672:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 679:	48 8d 50 08          	lea    0x8(%rax),%rdx
 67d:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 684:	8b 30                	mov    (%rax),%esi
 686:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 68c:	b9 00 00 00 00       	mov    $0x0,%ecx
 691:	ba 10 00 00 00       	mov    $0x10,%edx
 696:	89 c7                	mov    %eax,%edi
 698:	e8 60 fd ff ff       	call   3fd <printint>
 69d:	e9 51 01 00 00       	jmp    7f3 <printf+0x335>
      } else if(c == 's'){
 6a2:	83 bd 3c ff ff ff 73 	cmpl   $0x73,-0xc4(%rbp)
 6a9:	0f 85 98 00 00 00    	jne    747 <printf+0x289>
        s = va_arg(ap, char*);
 6af:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 6b5:	83 f8 2f             	cmp    $0x2f,%eax
 6b8:	77 23                	ja     6dd <printf+0x21f>
 6ba:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 6c1:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 6c7:	89 d2                	mov    %edx,%edx
 6c9:	48 01 d0             	add    %rdx,%rax
 6cc:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 6d2:	83 c2 08             	add    $0x8,%edx
 6d5:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 6db:	eb 12                	jmp    6ef <printf+0x231>
 6dd:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 6e4:	48 8d 50 08          	lea    0x8(%rax),%rdx
 6e8:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 6ef:	48 8b 00             	mov    (%rax),%rax
 6f2:	48 89 85 48 ff ff ff 	mov    %rax,-0xb8(%rbp)
        if(s == 0)
 6f9:	48 83 bd 48 ff ff ff 	cmpq   $0x0,-0xb8(%rbp)
 700:	00 
 701:	75 31                	jne    734 <printf+0x276>
          s = "(null)";
 703:	48 c7 85 48 ff ff ff 	movq   $0xcb0,-0xb8(%rbp)
 70a:	b0 0c 00 00 
        while(*s != 0){
 70e:	eb 24                	jmp    734 <printf+0x276>
          putc(fd, *s);
 710:	48 8b 85 48 ff ff ff 	mov    -0xb8(%rbp),%rax
 717:	0f b6 00             	movzbl (%rax),%eax
 71a:	0f be d0             	movsbl %al,%edx
 71d:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 723:	89 d6                	mov    %edx,%esi
 725:	89 c7                	mov    %eax,%edi
 727:	e8 a8 fc ff ff       	call   3d4 <putc>
          s++;
 72c:	48 83 85 48 ff ff ff 	addq   $0x1,-0xb8(%rbp)
 733:	01 
        while(*s != 0){
 734:	48 8b 85 48 ff ff ff 	mov    -0xb8(%rbp),%rax
 73b:	0f b6 00             	movzbl (%rax),%eax
 73e:	84 c0                	test   %al,%al
 740:	75 ce                	jne    710 <printf+0x252>
 742:	e9 ac 00 00 00       	jmp    7f3 <printf+0x335>
        }
      } else if(c == 'c'){
 747:	83 bd 3c ff ff ff 63 	cmpl   $0x63,-0xc4(%rbp)
 74e:	75 56                	jne    7a6 <printf+0x2e8>
        putc(fd, va_arg(ap, uint));
 750:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 756:	83 f8 2f             	cmp    $0x2f,%eax
 759:	77 23                	ja     77e <printf+0x2c0>
 75b:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 762:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 768:	89 d2                	mov    %edx,%edx
 76a:	48 01 d0             	add    %rdx,%rax
 76d:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 773:	83 c2 08             	add    $0x8,%edx
 776:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 77c:	eb 12                	jmp    790 <printf+0x2d2>
 77e:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 785:	48 8d 50 08          	lea    0x8(%rax),%rdx
 789:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 790:	8b 00                	mov    (%rax),%eax
 792:	0f be d0             	movsbl %al,%edx
 795:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 79b:	89 d6                	mov    %edx,%esi
 79d:	89 c7                	mov    %eax,%edi
 79f:	e8 30 fc ff ff       	call   3d4 <putc>
 7a4:	eb 4d                	jmp    7f3 <printf+0x335>
      } else if(c == '%'){
 7a6:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
 7ad:	75 1a                	jne    7c9 <printf+0x30b>
        putc(fd, c);
 7af:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
 7b5:	0f be d0             	movsbl %al,%edx
 7b8:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 7be:	89 d6                	mov    %edx,%esi
 7c0:	89 c7                	mov    %eax,%edi
 7c2:	e8 0d fc ff ff       	call   3d4 <putc>
 7c7:	eb 2a                	jmp    7f3 <printf+0x335>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 7c9:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 7cf:	be 25 00 00 00       	mov    $0x25,%esi
 7d4:	89 c7                	mov    %eax,%edi
 7d6:	e8 f9 fb ff ff       	call   3d4 <putc>
        putc(fd, c);
 7db:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
 7e1:	0f be d0             	movsbl %al,%edx
 7e4:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 7ea:	89 d6                	mov    %edx,%esi
 7ec:	89 c7                	mov    %eax,%edi
 7ee:	e8 e1 fb ff ff       	call   3d4 <putc>
      }
      state = 0;
 7f3:	c7 85 40 ff ff ff 00 	movl   $0x0,-0xc0(%rbp)
 7fa:	00 00 00 
  for(i = 0; fmt[i]; i++){
 7fd:	83 85 44 ff ff ff 01 	addl   $0x1,-0xbc(%rbp)
 804:	8b 85 44 ff ff ff    	mov    -0xbc(%rbp),%eax
 80a:	48 63 d0             	movslq %eax,%rdx
 80d:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
 814:	48 01 d0             	add    %rdx,%rax
 817:	0f b6 00             	movzbl (%rax),%eax
 81a:	84 c0                	test   %al,%al
 81c:	0f 85 3a fd ff ff    	jne    55c <printf+0x9e>
    }
  }
}
 822:	90                   	nop
 823:	90                   	nop
 824:	c9                   	leave
 825:	c3                   	ret

0000000000000826 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 826:	55                   	push   %rbp
 827:	48 89 e5             	mov    %rsp,%rbp
 82a:	48 83 ec 18          	sub    $0x18,%rsp
 82e:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  Header *bp, *p;

  bp = (Header*)ap - 1;
 832:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 836:	48 83 e8 10          	sub    $0x10,%rax
 83a:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 83e:	48 8b 05 7b 07 00 00 	mov    0x77b(%rip),%rax        # fc0 <freep>
 845:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 849:	eb 2f                	jmp    87a <free+0x54>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 84b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 84f:	48 8b 00             	mov    (%rax),%rax
 852:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 856:	72 17                	jb     86f <free+0x49>
 858:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 85c:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 860:	72 2f                	jb     891 <free+0x6b>
 862:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 866:	48 8b 00             	mov    (%rax),%rax
 869:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
 86d:	72 22                	jb     891 <free+0x6b>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 86f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 873:	48 8b 00             	mov    (%rax),%rax
 876:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 87a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 87e:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 882:	73 c7                	jae    84b <free+0x25>
 884:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 888:	48 8b 00             	mov    (%rax),%rax
 88b:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
 88f:	73 ba                	jae    84b <free+0x25>
      break;
  if(bp + bp->s.size == p->s.ptr){
 891:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 895:	8b 40 08             	mov    0x8(%rax),%eax
 898:	89 c0                	mov    %eax,%eax
 89a:	48 c1 e0 04          	shl    $0x4,%rax
 89e:	48 89 c2             	mov    %rax,%rdx
 8a1:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 8a5:	48 01 c2             	add    %rax,%rdx
 8a8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 8ac:	48 8b 00             	mov    (%rax),%rax
 8af:	48 39 c2             	cmp    %rax,%rdx
 8b2:	75 2d                	jne    8e1 <free+0xbb>
    bp->s.size += p->s.ptr->s.size;
 8b4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 8b8:	8b 50 08             	mov    0x8(%rax),%edx
 8bb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 8bf:	48 8b 00             	mov    (%rax),%rax
 8c2:	8b 40 08             	mov    0x8(%rax),%eax
 8c5:	01 c2                	add    %eax,%edx
 8c7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 8cb:	89 50 08             	mov    %edx,0x8(%rax)
    bp->s.ptr = p->s.ptr->s.ptr;
 8ce:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 8d2:	48 8b 00             	mov    (%rax),%rax
 8d5:	48 8b 10             	mov    (%rax),%rdx
 8d8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 8dc:	48 89 10             	mov    %rdx,(%rax)
 8df:	eb 0e                	jmp    8ef <free+0xc9>
  } else
    bp->s.ptr = p->s.ptr;
 8e1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 8e5:	48 8b 10             	mov    (%rax),%rdx
 8e8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 8ec:	48 89 10             	mov    %rdx,(%rax)
  if(p + p->s.size == bp){
 8ef:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 8f3:	8b 40 08             	mov    0x8(%rax),%eax
 8f6:	89 c0                	mov    %eax,%eax
 8f8:	48 c1 e0 04          	shl    $0x4,%rax
 8fc:	48 89 c2             	mov    %rax,%rdx
 8ff:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 903:	48 01 d0             	add    %rdx,%rax
 906:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
 90a:	75 27                	jne    933 <free+0x10d>
    p->s.size += bp->s.size;
 90c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 910:	8b 50 08             	mov    0x8(%rax),%edx
 913:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 917:	8b 40 08             	mov    0x8(%rax),%eax
 91a:	01 c2                	add    %eax,%edx
 91c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 920:	89 50 08             	mov    %edx,0x8(%rax)
    p->s.ptr = bp->s.ptr;
 923:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 927:	48 8b 10             	mov    (%rax),%rdx
 92a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 92e:	48 89 10             	mov    %rdx,(%rax)
 931:	eb 0b                	jmp    93e <free+0x118>
  } else
    p->s.ptr = bp;
 933:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 937:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
 93b:	48 89 10             	mov    %rdx,(%rax)
  freep = p;
 93e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 942:	48 89 05 77 06 00 00 	mov    %rax,0x677(%rip)        # fc0 <freep>
}
 949:	90                   	nop
 94a:	c9                   	leave
 94b:	c3                   	ret

000000000000094c <morecore>:

static Header*
morecore(uint nu)
{
 94c:	55                   	push   %rbp
 94d:	48 89 e5             	mov    %rsp,%rbp
 950:	48 83 ec 20          	sub    $0x20,%rsp
 954:	89 7d ec             	mov    %edi,-0x14(%rbp)
  char *p;
  Header *hp;

  if(nu < 4096)
 957:	81 7d ec ff 0f 00 00 	cmpl   $0xfff,-0x14(%rbp)
 95e:	77 07                	ja     967 <morecore+0x1b>
    nu = 4096;
 960:	c7 45 ec 00 10 00 00 	movl   $0x1000,-0x14(%rbp)
  p = sbrk(nu * sizeof(Header));
 967:	8b 45 ec             	mov    -0x14(%rbp),%eax
 96a:	c1 e0 04             	shl    $0x4,%eax
 96d:	89 c7                	mov    %eax,%edi
 96f:	e8 20 fa ff ff       	call   394 <sbrk>
 974:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  if(p == (char*)-1)
 978:	48 83 7d f8 ff       	cmpq   $0xffffffffffffffff,-0x8(%rbp)
 97d:	75 07                	jne    986 <morecore+0x3a>
    return 0;
 97f:	b8 00 00 00 00       	mov    $0x0,%eax
 984:	eb 29                	jmp    9af <morecore+0x63>
  hp = (Header*)p;
 986:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 98a:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  hp->s.size = nu;
 98e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 992:	8b 55 ec             	mov    -0x14(%rbp),%edx
 995:	89 50 08             	mov    %edx,0x8(%rax)
  free((void*)(hp + 1));
 998:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 99c:	48 83 c0 10          	add    $0x10,%rax
 9a0:	48 89 c7             	mov    %rax,%rdi
 9a3:	e8 7e fe ff ff       	call   826 <free>
  return freep;
 9a8:	48 8b 05 11 06 00 00 	mov    0x611(%rip),%rax        # fc0 <freep>
}
 9af:	c9                   	leave
 9b0:	c3                   	ret

00000000000009b1 <malloc>:

void*
malloc(uint nbytes)
{
 9b1:	55                   	push   %rbp
 9b2:	48 89 e5             	mov    %rsp,%rbp
 9b5:	48 83 ec 30          	sub    $0x30,%rsp
 9b9:	89 7d dc             	mov    %edi,-0x24(%rbp)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 9bc:	8b 45 dc             	mov    -0x24(%rbp),%eax
 9bf:	48 83 c0 0f          	add    $0xf,%rax
 9c3:	48 c1 e8 04          	shr    $0x4,%rax
 9c7:	83 c0 01             	add    $0x1,%eax
 9ca:	89 45 ec             	mov    %eax,-0x14(%rbp)
  if((prevp = freep) == 0){
 9cd:	48 8b 05 ec 05 00 00 	mov    0x5ec(%rip),%rax        # fc0 <freep>
 9d4:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
 9d8:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
 9dd:	75 2b                	jne    a0a <malloc+0x59>
    base.s.ptr = freep = prevp = &base;
 9df:	48 c7 45 f0 b0 0f 00 	movq   $0xfb0,-0x10(%rbp)
 9e6:	00 
 9e7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 9eb:	48 89 05 ce 05 00 00 	mov    %rax,0x5ce(%rip)        # fc0 <freep>
 9f2:	48 8b 05 c7 05 00 00 	mov    0x5c7(%rip),%rax        # fc0 <freep>
 9f9:	48 89 05 b0 05 00 00 	mov    %rax,0x5b0(%rip)        # fb0 <base>
    base.s.size = 0;
 a00:	c7 05 ae 05 00 00 00 	movl   $0x0,0x5ae(%rip)        # fb8 <base+0x8>
 a07:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a0a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 a0e:	48 8b 00             	mov    (%rax),%rax
 a11:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
 a15:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a19:	8b 40 08             	mov    0x8(%rax),%eax
 a1c:	3b 45 ec             	cmp    -0x14(%rbp),%eax
 a1f:	72 5f                	jb     a80 <malloc+0xcf>
      if(p->s.size == nunits)
 a21:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a25:	8b 40 08             	mov    0x8(%rax),%eax
 a28:	39 45 ec             	cmp    %eax,-0x14(%rbp)
 a2b:	75 10                	jne    a3d <malloc+0x8c>
        prevp->s.ptr = p->s.ptr;
 a2d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a31:	48 8b 10             	mov    (%rax),%rdx
 a34:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 a38:	48 89 10             	mov    %rdx,(%rax)
 a3b:	eb 2e                	jmp    a6b <malloc+0xba>
      else {
        p->s.size -= nunits;
 a3d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a41:	8b 40 08             	mov    0x8(%rax),%eax
 a44:	2b 45 ec             	sub    -0x14(%rbp),%eax
 a47:	89 c2                	mov    %eax,%edx
 a49:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a4d:	89 50 08             	mov    %edx,0x8(%rax)
        p += p->s.size;
 a50:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a54:	8b 40 08             	mov    0x8(%rax),%eax
 a57:	89 c0                	mov    %eax,%eax
 a59:	48 c1 e0 04          	shl    $0x4,%rax
 a5d:	48 01 45 f8          	add    %rax,-0x8(%rbp)
        p->s.size = nunits;
 a61:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a65:	8b 55 ec             	mov    -0x14(%rbp),%edx
 a68:	89 50 08             	mov    %edx,0x8(%rax)
      }
      freep = prevp;
 a6b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 a6f:	48 89 05 4a 05 00 00 	mov    %rax,0x54a(%rip)        # fc0 <freep>
      return (void*)(p + 1);
 a76:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a7a:	48 83 c0 10          	add    $0x10,%rax
 a7e:	eb 41                	jmp    ac1 <malloc+0x110>
    }
    if(p == freep)
 a80:	48 8b 05 39 05 00 00 	mov    0x539(%rip),%rax        # fc0 <freep>
 a87:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 a8b:	75 1c                	jne    aa9 <malloc+0xf8>
      if((p = morecore(nunits)) == 0)
 a8d:	8b 45 ec             	mov    -0x14(%rbp),%eax
 a90:	89 c7                	mov    %eax,%edi
 a92:	e8 b5 fe ff ff       	call   94c <morecore>
 a97:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 a9b:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
 aa0:	75 07                	jne    aa9 <malloc+0xf8>
        return 0;
 aa2:	b8 00 00 00 00       	mov    $0x0,%eax
 aa7:	eb 18                	jmp    ac1 <malloc+0x110>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 aa9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 aad:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
 ab1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 ab5:	48 8b 00             	mov    (%rax),%rax
 ab8:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
 abc:	e9 54 ff ff ff       	jmp    a15 <malloc+0x64>
  }
}
 ac1:	c9                   	leave
 ac2:	c3                   	ret

0000000000000ac3 <createRoot>:
#include "set.h"
#include "user.h"

//TODO: Να μην είναι περιορισμένο σε int

Set* createRoot(){
 ac3:	55                   	push   %rbp
 ac4:	48 89 e5             	mov    %rsp,%rbp
 ac7:	48 83 ec 10          	sub    $0x10,%rsp
    //Αρχικοποίηση του Set
    Set *set = malloc(sizeof(Set));
 acb:	bf 10 00 00 00       	mov    $0x10,%edi
 ad0:	e8 dc fe ff ff       	call   9b1 <malloc>
 ad5:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    set->size = 0;
 ad9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 add:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%rax)
    set->root = NULL;
 ae4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 ae8:	48 c7 00 00 00 00 00 	movq   $0x0,(%rax)
    return set;
 aef:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
 af3:	c9                   	leave
 af4:	c3                   	ret

0000000000000af5 <createNode>:

void createNode(int i, Set *set){
 af5:	55                   	push   %rbp
 af6:	48 89 e5             	mov    %rsp,%rbp
 af9:	48 83 ec 20          	sub    $0x20,%rsp
 afd:	89 7d ec             	mov    %edi,-0x14(%rbp)
 b00:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    Η συνάρτηση αυτή δημιουργεί ένα νέο SetNode με την τιμή i και εφόσον δεν υπάρχει στο Set το προσθέτει στο τέλος του συνόλου.
    Σημείωση: Ίσως υπάρχει καλύτερος τρόπος για την υλοποίηση.
    */

    //Αρχικοποίηση του SetNode
    SetNode *temp = malloc(sizeof(SetNode));
 b04:	bf 10 00 00 00       	mov    $0x10,%edi
 b09:	e8 a3 fe ff ff       	call   9b1 <malloc>
 b0e:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    temp->i = i;
 b12:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 b16:	8b 55 ec             	mov    -0x14(%rbp),%edx
 b19:	89 10                	mov    %edx,(%rax)
    temp->next = NULL;
 b1b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 b1f:	48 c7 40 08 00 00 00 	movq   $0x0,0x8(%rax)
 b26:	00 

    //Έλεγχος ύπαρξης του i
    SetNode *curr = set->root;//Ξεκινάει από την root
 b27:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
 b2b:	48 8b 00             	mov    (%rax),%rax
 b2e:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(curr != NULL) { //Εφόσον το Set δεν είναι άδειο
 b32:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
 b37:	74 34                	je     b6d <createNode+0x78>
        while (curr->next != NULL){ //Εφόσον υπάρχει επόμενο node
 b39:	eb 25                	jmp    b60 <createNode+0x6b>
            if (curr->i == i){ //Αν το i υπάρχει στο σύνολο
 b3b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b3f:	8b 00                	mov    (%rax),%eax
 b41:	39 45 ec             	cmp    %eax,-0x14(%rbp)
 b44:	75 0e                	jne    b54 <createNode+0x5f>
                free(temp); 
 b46:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 b4a:	48 89 c7             	mov    %rax,%rdi
 b4d:	e8 d4 fc ff ff       	call   826 <free>
                return; //Δεν εκτελούμε την υπόλοιπη συνάρτηση
 b52:	eb 4e                	jmp    ba2 <createNode+0xad>
            }
            curr = curr->next; //Επόμενο SetNode
 b54:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b58:	48 8b 40 08          	mov    0x8(%rax),%rax
 b5c:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
        while (curr->next != NULL){ //Εφόσον υπάρχει επόμενο node
 b60:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b64:	48 8b 40 08          	mov    0x8(%rax),%rax
 b68:	48 85 c0             	test   %rax,%rax
 b6b:	75 ce                	jne    b3b <createNode+0x46>
        }
    }
    /*
    Ο έλεγχος στην if είναι απαραίτητος για να ελεγχθεί το τελευταίο SetNode.
    */
    if (curr->i != i) attachNode(set, curr, temp); 
 b6d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b71:	8b 00                	mov    (%rax),%eax
 b73:	39 45 ec             	cmp    %eax,-0x14(%rbp)
 b76:	74 1e                	je     b96 <createNode+0xa1>
 b78:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
 b7c:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
 b80:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
 b84:	48 89 ce             	mov    %rcx,%rsi
 b87:	48 89 c7             	mov    %rax,%rdi
 b8a:	b8 00 00 00 00       	mov    $0x0,%eax
 b8f:	e8 10 00 00 00       	call   ba4 <attachNode>
 b94:	eb 0c                	jmp    ba2 <createNode+0xad>
    else free(temp);
 b96:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 b9a:	48 89 c7             	mov    %rax,%rdi
 b9d:	e8 84 fc ff ff       	call   826 <free>
}
 ba2:	c9                   	leave
 ba3:	c3                   	ret

0000000000000ba4 <attachNode>:

void attachNode(Set *set, SetNode *curr, SetNode *temp){
 ba4:	55                   	push   %rbp
 ba5:	48 89 e5             	mov    %rsp,%rbp
 ba8:	48 83 ec 18          	sub    $0x18,%rsp
 bac:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
 bb0:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
 bb4:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
    //Βάζουμε το temp στο τέλος του Set
    if(set->size == 0) set->root = temp;
 bb8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 bbc:	8b 40 08             	mov    0x8(%rax),%eax
 bbf:	85 c0                	test   %eax,%eax
 bc1:	75 0d                	jne    bd0 <attachNode+0x2c>
 bc3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 bc7:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
 bcb:	48 89 10             	mov    %rdx,(%rax)
 bce:	eb 0c                	jmp    bdc <attachNode+0x38>
    else curr->next = temp;
 bd0:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 bd4:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
 bd8:	48 89 50 08          	mov    %rdx,0x8(%rax)
    set->size += 1;
 bdc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 be0:	8b 40 08             	mov    0x8(%rax),%eax
 be3:	8d 50 01             	lea    0x1(%rax),%edx
 be6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 bea:	89 50 08             	mov    %edx,0x8(%rax)
}
 bed:	90                   	nop
 bee:	c9                   	leave
 bef:	c3                   	ret

0000000000000bf0 <deleteSet>:

void deleteSet(Set *set){
 bf0:	55                   	push   %rbp
 bf1:	48 89 e5             	mov    %rsp,%rbp
 bf4:	48 83 ec 20          	sub    $0x20,%rsp
 bf8:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    if (set == NULL) return; //Αν ο χρήστης είναι ΜΛΚ!
 bfc:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
 c01:	74 42                	je     c45 <deleteSet+0x55>
    SetNode *temp;
    SetNode *curr = set->root; //Ξεκινάμε από το root
 c03:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 c07:	48 8b 00             	mov    (%rax),%rax
 c0a:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    while (curr != NULL){ 
 c0e:	eb 20                	jmp    c30 <deleteSet+0x40>
        temp = curr->next; //Αναφορά στο επόμενο SetNode
 c10:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 c14:	48 8b 40 08          	mov    0x8(%rax),%rax
 c18:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
        free(curr); //Απελευθέρωση της curr
 c1c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 c20:	48 89 c7             	mov    %rax,%rdi
 c23:	e8 fe fb ff ff       	call   826 <free>
        curr = temp;
 c28:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 c2c:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    while (curr != NULL){ 
 c30:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
 c35:	75 d9                	jne    c10 <deleteSet+0x20>
    }
    free(set); //Διαγραφή του Set
 c37:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 c3b:	48 89 c7             	mov    %rax,%rdi
 c3e:	e8 e3 fb ff ff       	call   826 <free>
 c43:	eb 01                	jmp    c46 <deleteSet+0x56>
    if (set == NULL) return; //Αν ο χρήστης είναι ΜΛΚ!
 c45:	90                   	nop
}
 c46:	c9                   	leave
 c47:	c3                   	ret

0000000000000c48 <getNodeAtPosition>:

SetNode* getNodeAtPosition(Set *set, int i){
 c48:	55                   	push   %rbp
 c49:	48 89 e5             	mov    %rsp,%rbp
 c4c:	48 83 ec 20          	sub    $0x20,%rsp
 c50:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
 c54:	89 75 e4             	mov    %esi,-0x1c(%rbp)
    if (set == NULL || set->root == NULL) return NULL; //Αν ο χρήστης είναι ΜΛΚ!
 c57:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
 c5c:	74 0c                	je     c6a <getNodeAtPosition+0x22>
 c5e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 c62:	48 8b 00             	mov    (%rax),%rax
 c65:	48 85 c0             	test   %rax,%rax
 c68:	75 07                	jne    c71 <getNodeAtPosition+0x29>
 c6a:	b8 00 00 00 00       	mov    $0x0,%eax
 c6f:	eb 3d                	jmp    cae <getNodeAtPosition+0x66>

    SetNode *curr = set->root;
 c71:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 c75:	48 8b 00             	mov    (%rax),%rax
 c78:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    int n;

    for(n = 0; n<i && curr->next != NULL; n++) curr = curr->next; //Ο έλεγχος εδω είναι: n<i && curr->next != NULL
 c7c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
 c83:	eb 10                	jmp    c95 <getNodeAtPosition+0x4d>
 c85:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 c89:	48 8b 40 08          	mov    0x8(%rax),%rax
 c8d:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 c91:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
 c95:	8b 45 f4             	mov    -0xc(%rbp),%eax
 c98:	3b 45 e4             	cmp    -0x1c(%rbp),%eax
 c9b:	7d 0d                	jge    caa <getNodeAtPosition+0x62>
 c9d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 ca1:	48 8b 40 08          	mov    0x8(%rax),%rax
 ca5:	48 85 c0             	test   %rax,%rax
 ca8:	75 db                	jne    c85 <getNodeAtPosition+0x3d>
    return curr;
 caa:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 cae:	c9                   	leave
 caf:	c3                   	ret
