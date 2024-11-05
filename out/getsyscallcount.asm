
fs/getsyscallcount:     file format elf64-x86-64


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
    if (argc != 2){
   f:	83 7d fc 02          	cmpl   $0x2,-0x4(%rbp)
  13:	74 1b                	je     30 <main+0x30>
        printf(1, "getsyscallcount: Unexpected input");
  15:	48 c7 c6 e8 0c 00 00 	mov    $0xce8,%rsi
  1c:	bf 01 00 00 00       	mov    $0x1,%edi
  21:	b8 00 00 00 00       	mov    $0x0,%eax
  26:	e8 c9 04 00 00       	call   4f4 <printf>
        exit();
  2b:	e8 12 03 00 00       	call   342 <exit>
        /*
        atoi("25")->25
        atoi("abc")->¯\_(ツ)_/¯
        Δεν έχει error handling
        */
            argv[1] //SYSCALL number
  30:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  34:	48 83 c0 08          	add    $0x8,%rax
    getcount(
  38:	48 8b 00             	mov    (%rax),%rax
  3b:	48 89 c7             	mov    %rax,%rdi
  3e:	e8 4a 02 00 00       	call   28d <atoi>
  43:	89 c7                	mov    %eax,%edi
  45:	e8 b0 03 00 00       	call   3fa <getcount>
            )
            );
    exit();
  4a:	e8 f3 02 00 00       	call   342 <exit>

000000000000004f <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
  4f:	55                   	push   %rbp
  50:	48 89 e5             	mov    %rsp,%rbp
  53:	48 83 ec 10          	sub    $0x10,%rsp
  57:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  5b:	89 75 f4             	mov    %esi,-0xc(%rbp)
  5e:	89 55 f0             	mov    %edx,-0x10(%rbp)
  asm volatile("cld; rep stosb" :
  61:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
  65:	8b 55 f0             	mov    -0x10(%rbp),%edx
  68:	8b 45 f4             	mov    -0xc(%rbp),%eax
  6b:	48 89 ce             	mov    %rcx,%rsi
  6e:	48 89 f7             	mov    %rsi,%rdi
  71:	89 d1                	mov    %edx,%ecx
  73:	fc                   	cld
  74:	f3 aa                	rep stos %al,%es:(%rdi)
  76:	89 ca                	mov    %ecx,%edx
  78:	48 89 fe             	mov    %rdi,%rsi
  7b:	48 89 75 f8          	mov    %rsi,-0x8(%rbp)
  7f:	89 55 f0             	mov    %edx,-0x10(%rbp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
  82:	90                   	nop
  83:	c9                   	leave
  84:	c3                   	ret

0000000000000085 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
  85:	55                   	push   %rbp
  86:	48 89 e5             	mov    %rsp,%rbp
  89:	48 83 ec 20          	sub    $0x20,%rsp
  8d:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  91:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  char *os;

  os = s;
  95:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  99:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  while((*s++ = *t++) != 0)
  9d:	90                   	nop
  9e:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  a2:	48 8d 42 01          	lea    0x1(%rdx),%rax
  a6:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  aa:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  ae:	48 8d 48 01          	lea    0x1(%rax),%rcx
  b2:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  b6:	0f b6 12             	movzbl (%rdx),%edx
  b9:	88 10                	mov    %dl,(%rax)
  bb:	0f b6 00             	movzbl (%rax),%eax
  be:	84 c0                	test   %al,%al
  c0:	75 dc                	jne    9e <strcpy+0x19>
    ;
  return os;
  c2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
  c6:	c9                   	leave
  c7:	c3                   	ret

00000000000000c8 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  c8:	55                   	push   %rbp
  c9:	48 89 e5             	mov    %rsp,%rbp
  cc:	48 83 ec 10          	sub    $0x10,%rsp
  d0:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  d4:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  while(*p && *p == *q)
  d8:	eb 0a                	jmp    e4 <strcmp+0x1c>
    p++, q++;
  da:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  df:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  while(*p && *p == *q)
  e4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  e8:	0f b6 00             	movzbl (%rax),%eax
  eb:	84 c0                	test   %al,%al
  ed:	74 12                	je     101 <strcmp+0x39>
  ef:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  f3:	0f b6 10             	movzbl (%rax),%edx
  f6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  fa:	0f b6 00             	movzbl (%rax),%eax
  fd:	38 c2                	cmp    %al,%dl
  ff:	74 d9                	je     da <strcmp+0x12>
  return (uchar)*p - (uchar)*q;
 101:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 105:	0f b6 00             	movzbl (%rax),%eax
 108:	0f b6 d0             	movzbl %al,%edx
 10b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 10f:	0f b6 00             	movzbl (%rax),%eax
 112:	0f b6 c0             	movzbl %al,%eax
 115:	29 c2                	sub    %eax,%edx
 117:	89 d0                	mov    %edx,%eax
}
 119:	c9                   	leave
 11a:	c3                   	ret

000000000000011b <strlen>:

uint
strlen(char *s)
{
 11b:	55                   	push   %rbp
 11c:	48 89 e5             	mov    %rsp,%rbp
 11f:	48 83 ec 18          	sub    $0x18,%rsp
 123:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  int n;

  for(n = 0; s[n]; n++)
 127:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
 12e:	eb 04                	jmp    134 <strlen+0x19>
 130:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
 134:	8b 45 fc             	mov    -0x4(%rbp),%eax
 137:	48 63 d0             	movslq %eax,%rdx
 13a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 13e:	48 01 d0             	add    %rdx,%rax
 141:	0f b6 00             	movzbl (%rax),%eax
 144:	84 c0                	test   %al,%al
 146:	75 e8                	jne    130 <strlen+0x15>
    ;
  return n;
 148:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
 14b:	c9                   	leave
 14c:	c3                   	ret

000000000000014d <memset>:

void*
memset(void *dst, int c, uint n)
{
 14d:	55                   	push   %rbp
 14e:	48 89 e5             	mov    %rsp,%rbp
 151:	48 83 ec 10          	sub    $0x10,%rsp
 155:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
 159:	89 75 f4             	mov    %esi,-0xc(%rbp)
 15c:	89 55 f0             	mov    %edx,-0x10(%rbp)
  stosb(dst, c, n);
 15f:	8b 55 f0             	mov    -0x10(%rbp),%edx
 162:	8b 4d f4             	mov    -0xc(%rbp),%ecx
 165:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 169:	89 ce                	mov    %ecx,%esi
 16b:	48 89 c7             	mov    %rax,%rdi
 16e:	e8 dc fe ff ff       	call   4f <stosb>
  return dst;
 173:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
 177:	c9                   	leave
 178:	c3                   	ret

0000000000000179 <strchr>:

char*
strchr(const char *s, char c)
{
 179:	55                   	push   %rbp
 17a:	48 89 e5             	mov    %rsp,%rbp
 17d:	48 83 ec 10          	sub    $0x10,%rsp
 181:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
 185:	89 f0                	mov    %esi,%eax
 187:	88 45 f4             	mov    %al,-0xc(%rbp)
  for(; *s; s++)
 18a:	eb 17                	jmp    1a3 <strchr+0x2a>
    if(*s == c)
 18c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 190:	0f b6 00             	movzbl (%rax),%eax
 193:	38 45 f4             	cmp    %al,-0xc(%rbp)
 196:	75 06                	jne    19e <strchr+0x25>
      return (char*)s;
 198:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 19c:	eb 15                	jmp    1b3 <strchr+0x3a>
  for(; *s; s++)
 19e:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
 1a3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 1a7:	0f b6 00             	movzbl (%rax),%eax
 1aa:	84 c0                	test   %al,%al
 1ac:	75 de                	jne    18c <strchr+0x13>
  return 0;
 1ae:	b8 00 00 00 00       	mov    $0x0,%eax
}
 1b3:	c9                   	leave
 1b4:	c3                   	ret

00000000000001b5 <gets>:

char*
gets(char *buf, int max)
{
 1b5:	55                   	push   %rbp
 1b6:	48 89 e5             	mov    %rsp,%rbp
 1b9:	48 83 ec 20          	sub    $0x20,%rsp
 1bd:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
 1c1:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1c4:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
 1cb:	eb 48                	jmp    215 <gets+0x60>
    cc = read(0, &c, 1);
 1cd:	48 8d 45 f7          	lea    -0x9(%rbp),%rax
 1d1:	ba 01 00 00 00       	mov    $0x1,%edx
 1d6:	48 89 c6             	mov    %rax,%rsi
 1d9:	bf 00 00 00 00       	mov    $0x0,%edi
 1de:	e8 77 01 00 00       	call   35a <read>
 1e3:	89 45 f8             	mov    %eax,-0x8(%rbp)
    if(cc < 1)
 1e6:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
 1ea:	7e 36                	jle    222 <gets+0x6d>
      break;
    buf[i++] = c;
 1ec:	8b 45 fc             	mov    -0x4(%rbp),%eax
 1ef:	8d 50 01             	lea    0x1(%rax),%edx
 1f2:	89 55 fc             	mov    %edx,-0x4(%rbp)
 1f5:	48 63 d0             	movslq %eax,%rdx
 1f8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 1fc:	48 01 c2             	add    %rax,%rdx
 1ff:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
 203:	88 02                	mov    %al,(%rdx)
    if(c == '\n' || c == '\r')
 205:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
 209:	3c 0a                	cmp    $0xa,%al
 20b:	74 16                	je     223 <gets+0x6e>
 20d:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
 211:	3c 0d                	cmp    $0xd,%al
 213:	74 0e                	je     223 <gets+0x6e>
  for(i=0; i+1 < max; ){
 215:	8b 45 fc             	mov    -0x4(%rbp),%eax
 218:	83 c0 01             	add    $0x1,%eax
 21b:	39 45 e4             	cmp    %eax,-0x1c(%rbp)
 21e:	7f ad                	jg     1cd <gets+0x18>
 220:	eb 01                	jmp    223 <gets+0x6e>
      break;
 222:	90                   	nop
      break;
  }
  buf[i] = '\0';
 223:	8b 45 fc             	mov    -0x4(%rbp),%eax
 226:	48 63 d0             	movslq %eax,%rdx
 229:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 22d:	48 01 d0             	add    %rdx,%rax
 230:	c6 00 00             	movb   $0x0,(%rax)
  return buf;
 233:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
 237:	c9                   	leave
 238:	c3                   	ret

0000000000000239 <stat>:

int
stat(char *n, struct stat *st)
{
 239:	55                   	push   %rbp
 23a:	48 89 e5             	mov    %rsp,%rbp
 23d:	48 83 ec 20          	sub    $0x20,%rsp
 241:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
 245:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 249:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 24d:	be 00 00 00 00       	mov    $0x0,%esi
 252:	48 89 c7             	mov    %rax,%rdi
 255:	e8 28 01 00 00       	call   382 <open>
 25a:	89 45 fc             	mov    %eax,-0x4(%rbp)
  if(fd < 0)
 25d:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
 261:	79 07                	jns    26a <stat+0x31>
    return -1;
 263:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 268:	eb 21                	jmp    28b <stat+0x52>
  r = fstat(fd, st);
 26a:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
 26e:	8b 45 fc             	mov    -0x4(%rbp),%eax
 271:	48 89 d6             	mov    %rdx,%rsi
 274:	89 c7                	mov    %eax,%edi
 276:	e8 1f 01 00 00       	call   39a <fstat>
 27b:	89 45 f8             	mov    %eax,-0x8(%rbp)
  close(fd);
 27e:	8b 45 fc             	mov    -0x4(%rbp),%eax
 281:	89 c7                	mov    %eax,%edi
 283:	e8 e2 00 00 00       	call   36a <close>
  return r;
 288:	8b 45 f8             	mov    -0x8(%rbp),%eax
}
 28b:	c9                   	leave
 28c:	c3                   	ret

000000000000028d <atoi>:

int
atoi(const char *s)
{
 28d:	55                   	push   %rbp
 28e:	48 89 e5             	mov    %rsp,%rbp
 291:	48 83 ec 18          	sub    $0x18,%rsp
 295:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  int n;

  n = 0;
 299:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  while('0' <= *s && *s <= '9')
 2a0:	eb 28                	jmp    2ca <atoi+0x3d>
    n = n*10 + *s++ - '0';
 2a2:	8b 55 fc             	mov    -0x4(%rbp),%edx
 2a5:	89 d0                	mov    %edx,%eax
 2a7:	c1 e0 02             	shl    $0x2,%eax
 2aa:	01 d0                	add    %edx,%eax
 2ac:	01 c0                	add    %eax,%eax
 2ae:	89 c1                	mov    %eax,%ecx
 2b0:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 2b4:	48 8d 50 01          	lea    0x1(%rax),%rdx
 2b8:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
 2bc:	0f b6 00             	movzbl (%rax),%eax
 2bf:	0f be c0             	movsbl %al,%eax
 2c2:	01 c8                	add    %ecx,%eax
 2c4:	83 e8 30             	sub    $0x30,%eax
 2c7:	89 45 fc             	mov    %eax,-0x4(%rbp)
  while('0' <= *s && *s <= '9')
 2ca:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 2ce:	0f b6 00             	movzbl (%rax),%eax
 2d1:	3c 2f                	cmp    $0x2f,%al
 2d3:	7e 0b                	jle    2e0 <atoi+0x53>
 2d5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 2d9:	0f b6 00             	movzbl (%rax),%eax
 2dc:	3c 39                	cmp    $0x39,%al
 2de:	7e c2                	jle    2a2 <atoi+0x15>
  return n;
 2e0:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
 2e3:	c9                   	leave
 2e4:	c3                   	ret

00000000000002e5 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 2e5:	55                   	push   %rbp
 2e6:	48 89 e5             	mov    %rsp,%rbp
 2e9:	48 83 ec 28          	sub    $0x28,%rsp
 2ed:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
 2f1:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
 2f5:	89 55 dc             	mov    %edx,-0x24(%rbp)
  char *dst, *src;
  
  dst = vdst;
 2f8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 2fc:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  src = vsrc;
 300:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
 304:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  while(n-- > 0)
 308:	eb 1d                	jmp    327 <memmove+0x42>
    *dst++ = *src++;
 30a:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
 30e:	48 8d 42 01          	lea    0x1(%rdx),%rax
 312:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
 316:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 31a:	48 8d 48 01          	lea    0x1(%rax),%rcx
 31e:	48 89 4d f8          	mov    %rcx,-0x8(%rbp)
 322:	0f b6 12             	movzbl (%rdx),%edx
 325:	88 10                	mov    %dl,(%rax)
  while(n-- > 0)
 327:	8b 45 dc             	mov    -0x24(%rbp),%eax
 32a:	8d 50 ff             	lea    -0x1(%rax),%edx
 32d:	89 55 dc             	mov    %edx,-0x24(%rbp)
 330:	85 c0                	test   %eax,%eax
 332:	7f d6                	jg     30a <memmove+0x25>
  return vdst;
 334:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
 338:	c9                   	leave
 339:	c3                   	ret

000000000000033a <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 33a:	b8 01 00 00 00       	mov    $0x1,%eax
 33f:	cd 40                	int    $0x40
 341:	c3                   	ret

0000000000000342 <exit>:
SYSCALL(exit)
 342:	b8 02 00 00 00       	mov    $0x2,%eax
 347:	cd 40                	int    $0x40
 349:	c3                   	ret

000000000000034a <wait>:
SYSCALL(wait)
 34a:	b8 03 00 00 00       	mov    $0x3,%eax
 34f:	cd 40                	int    $0x40
 351:	c3                   	ret

0000000000000352 <pipe>:
SYSCALL(pipe)
 352:	b8 04 00 00 00       	mov    $0x4,%eax
 357:	cd 40                	int    $0x40
 359:	c3                   	ret

000000000000035a <read>:
SYSCALL(read)
 35a:	b8 05 00 00 00       	mov    $0x5,%eax
 35f:	cd 40                	int    $0x40
 361:	c3                   	ret

0000000000000362 <write>:
SYSCALL(write)
 362:	b8 10 00 00 00       	mov    $0x10,%eax
 367:	cd 40                	int    $0x40
 369:	c3                   	ret

000000000000036a <close>:
SYSCALL(close)
 36a:	b8 15 00 00 00       	mov    $0x15,%eax
 36f:	cd 40                	int    $0x40
 371:	c3                   	ret

0000000000000372 <kill>:
SYSCALL(kill)
 372:	b8 06 00 00 00       	mov    $0x6,%eax
 377:	cd 40                	int    $0x40
 379:	c3                   	ret

000000000000037a <exec>:
SYSCALL(exec)
 37a:	b8 07 00 00 00       	mov    $0x7,%eax
 37f:	cd 40                	int    $0x40
 381:	c3                   	ret

0000000000000382 <open>:
SYSCALL(open)
 382:	b8 0f 00 00 00       	mov    $0xf,%eax
 387:	cd 40                	int    $0x40
 389:	c3                   	ret

000000000000038a <mknod>:
SYSCALL(mknod)
 38a:	b8 11 00 00 00       	mov    $0x11,%eax
 38f:	cd 40                	int    $0x40
 391:	c3                   	ret

0000000000000392 <unlink>:
SYSCALL(unlink)
 392:	b8 12 00 00 00       	mov    $0x12,%eax
 397:	cd 40                	int    $0x40
 399:	c3                   	ret

000000000000039a <fstat>:
SYSCALL(fstat)
 39a:	b8 08 00 00 00       	mov    $0x8,%eax
 39f:	cd 40                	int    $0x40
 3a1:	c3                   	ret

00000000000003a2 <link>:
SYSCALL(link)
 3a2:	b8 13 00 00 00       	mov    $0x13,%eax
 3a7:	cd 40                	int    $0x40
 3a9:	c3                   	ret

00000000000003aa <mkdir>:
SYSCALL(mkdir)
 3aa:	b8 14 00 00 00       	mov    $0x14,%eax
 3af:	cd 40                	int    $0x40
 3b1:	c3                   	ret

00000000000003b2 <chdir>:
SYSCALL(chdir)
 3b2:	b8 09 00 00 00       	mov    $0x9,%eax
 3b7:	cd 40                	int    $0x40
 3b9:	c3                   	ret

00000000000003ba <dup>:
SYSCALL(dup)
 3ba:	b8 0a 00 00 00       	mov    $0xa,%eax
 3bf:	cd 40                	int    $0x40
 3c1:	c3                   	ret

00000000000003c2 <getpid>:
SYSCALL(getpid)
 3c2:	b8 0b 00 00 00       	mov    $0xb,%eax
 3c7:	cd 40                	int    $0x40
 3c9:	c3                   	ret

00000000000003ca <sbrk>:
SYSCALL(sbrk)
 3ca:	b8 0c 00 00 00       	mov    $0xc,%eax
 3cf:	cd 40                	int    $0x40
 3d1:	c3                   	ret

00000000000003d2 <sleep>:
SYSCALL(sleep)
 3d2:	b8 0d 00 00 00       	mov    $0xd,%eax
 3d7:	cd 40                	int    $0x40
 3d9:	c3                   	ret

00000000000003da <uptime>:
SYSCALL(uptime)
 3da:	b8 0e 00 00 00       	mov    $0xe,%eax
 3df:	cd 40                	int    $0x40
 3e1:	c3                   	ret

00000000000003e2 <getpinfo>:
SYSCALL(getpinfo)
 3e2:	b8 18 00 00 00       	mov    $0x18,%eax
 3e7:	cd 40                	int    $0x40
 3e9:	c3                   	ret

00000000000003ea <getfavnum>:
SYSCALL(getfavnum)
 3ea:	b8 19 00 00 00       	mov    $0x19,%eax
 3ef:	cd 40                	int    $0x40
 3f1:	c3                   	ret

00000000000003f2 <shutdown>:
SYSCALL(shutdown)
 3f2:	b8 1a 00 00 00       	mov    $0x1a,%eax
 3f7:	cd 40                	int    $0x40
 3f9:	c3                   	ret

00000000000003fa <getcount>:
SYSCALL(getcount)
 3fa:	b8 1b 00 00 00       	mov    $0x1b,%eax
 3ff:	cd 40                	int    $0x40
 401:	c3                   	ret

0000000000000402 <killrandom>:
 402:	b8 1c 00 00 00       	mov    $0x1c,%eax
 407:	cd 40                	int    $0x40
 409:	c3                   	ret

000000000000040a <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 40a:	55                   	push   %rbp
 40b:	48 89 e5             	mov    %rsp,%rbp
 40e:	48 83 ec 10          	sub    $0x10,%rsp
 412:	89 7d fc             	mov    %edi,-0x4(%rbp)
 415:	89 f0                	mov    %esi,%eax
 417:	88 45 f8             	mov    %al,-0x8(%rbp)
  write(fd, &c, 1);
 41a:	48 8d 4d f8          	lea    -0x8(%rbp),%rcx
 41e:	8b 45 fc             	mov    -0x4(%rbp),%eax
 421:	ba 01 00 00 00       	mov    $0x1,%edx
 426:	48 89 ce             	mov    %rcx,%rsi
 429:	89 c7                	mov    %eax,%edi
 42b:	e8 32 ff ff ff       	call   362 <write>
}
 430:	90                   	nop
 431:	c9                   	leave
 432:	c3                   	ret

0000000000000433 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 433:	55                   	push   %rbp
 434:	48 89 e5             	mov    %rsp,%rbp
 437:	48 83 ec 30          	sub    $0x30,%rsp
 43b:	89 7d dc             	mov    %edi,-0x24(%rbp)
 43e:	89 75 d8             	mov    %esi,-0x28(%rbp)
 441:	89 55 d4             	mov    %edx,-0x2c(%rbp)
 444:	89 4d d0             	mov    %ecx,-0x30(%rbp)
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 447:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
  if(sgn && xx < 0){
 44e:	83 7d d0 00          	cmpl   $0x0,-0x30(%rbp)
 452:	74 17                	je     46b <printint+0x38>
 454:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
 458:	79 11                	jns    46b <printint+0x38>
    neg = 1;
 45a:	c7 45 f8 01 00 00 00 	movl   $0x1,-0x8(%rbp)
    x = -xx;
 461:	8b 45 d8             	mov    -0x28(%rbp),%eax
 464:	f7 d8                	neg    %eax
 466:	89 45 f4             	mov    %eax,-0xc(%rbp)
 469:	eb 06                	jmp    471 <printint+0x3e>
  } else {
    x = xx;
 46b:	8b 45 d8             	mov    -0x28(%rbp),%eax
 46e:	89 45 f4             	mov    %eax,-0xc(%rbp)
  }

  i = 0;
 471:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  do{
    buf[i++] = digits[x % base];
 478:	8b 4d d4             	mov    -0x2c(%rbp),%ecx
 47b:	8b 45 f4             	mov    -0xc(%rbp),%eax
 47e:	ba 00 00 00 00       	mov    $0x0,%edx
 483:	f7 f1                	div    %ecx
 485:	89 d1                	mov    %edx,%ecx
 487:	8b 45 fc             	mov    -0x4(%rbp),%eax
 48a:	8d 50 01             	lea    0x1(%rax),%edx
 48d:	89 55 fc             	mov    %edx,-0x4(%rbp)
 490:	89 ca                	mov    %ecx,%edx
 492:	0f b6 92 f0 0f 00 00 	movzbl 0xff0(%rdx),%edx
 499:	48 98                	cltq
 49b:	88 54 05 e0          	mov    %dl,-0x20(%rbp,%rax,1)
  }while((x /= base) != 0);
 49f:	8b 75 d4             	mov    -0x2c(%rbp),%esi
 4a2:	8b 45 f4             	mov    -0xc(%rbp),%eax
 4a5:	ba 00 00 00 00       	mov    $0x0,%edx
 4aa:	f7 f6                	div    %esi
 4ac:	89 45 f4             	mov    %eax,-0xc(%rbp)
 4af:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
 4b3:	75 c3                	jne    478 <printint+0x45>
  if(neg)
 4b5:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
 4b9:	74 2b                	je     4e6 <printint+0xb3>
    buf[i++] = '-';
 4bb:	8b 45 fc             	mov    -0x4(%rbp),%eax
 4be:	8d 50 01             	lea    0x1(%rax),%edx
 4c1:	89 55 fc             	mov    %edx,-0x4(%rbp)
 4c4:	48 98                	cltq
 4c6:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%rbp,%rax,1)

  while(--i >= 0)
 4cb:	eb 19                	jmp    4e6 <printint+0xb3>
    putc(fd, buf[i]);
 4cd:	8b 45 fc             	mov    -0x4(%rbp),%eax
 4d0:	48 98                	cltq
 4d2:	0f b6 44 05 e0       	movzbl -0x20(%rbp,%rax,1),%eax
 4d7:	0f be d0             	movsbl %al,%edx
 4da:	8b 45 dc             	mov    -0x24(%rbp),%eax
 4dd:	89 d6                	mov    %edx,%esi
 4df:	89 c7                	mov    %eax,%edi
 4e1:	e8 24 ff ff ff       	call   40a <putc>
  while(--i >= 0)
 4e6:	83 6d fc 01          	subl   $0x1,-0x4(%rbp)
 4ea:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
 4ee:	79 dd                	jns    4cd <printint+0x9a>
}
 4f0:	90                   	nop
 4f1:	90                   	nop
 4f2:	c9                   	leave
 4f3:	c3                   	ret

00000000000004f4 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 4f4:	55                   	push   %rbp
 4f5:	48 89 e5             	mov    %rsp,%rbp
 4f8:	48 81 ec f0 00 00 00 	sub    $0xf0,%rsp
 4ff:	89 bd 1c ff ff ff    	mov    %edi,-0xe4(%rbp)
 505:	48 89 b5 10 ff ff ff 	mov    %rsi,-0xf0(%rbp)
 50c:	48 89 95 60 ff ff ff 	mov    %rdx,-0xa0(%rbp)
 513:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
 51a:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
 521:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
 528:	84 c0                	test   %al,%al
 52a:	74 20                	je     54c <printf+0x58>
 52c:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
 530:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
 534:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
 538:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
 53c:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
 540:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
 544:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
 548:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  va_list ap;
  char *s;
  int c, i, state;
  va_start(ap, fmt);
 54c:	c7 85 20 ff ff ff 10 	movl   $0x10,-0xe0(%rbp)
 553:	00 00 00 
 556:	c7 85 24 ff ff ff 30 	movl   $0x30,-0xdc(%rbp)
 55d:	00 00 00 
 560:	48 8d 45 10          	lea    0x10(%rbp),%rax
 564:	48 89 85 28 ff ff ff 	mov    %rax,-0xd8(%rbp)
 56b:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
 572:	48 89 85 30 ff ff ff 	mov    %rax,-0xd0(%rbp)

  state = 0;
 579:	c7 85 40 ff ff ff 00 	movl   $0x0,-0xc0(%rbp)
 580:	00 00 00 
  for(i = 0; fmt[i]; i++){
 583:	c7 85 44 ff ff ff 00 	movl   $0x0,-0xbc(%rbp)
 58a:	00 00 00 
 58d:	e9 a8 02 00 00       	jmp    83a <printf+0x346>
    c = fmt[i] & 0xff;
 592:	8b 85 44 ff ff ff    	mov    -0xbc(%rbp),%eax
 598:	48 63 d0             	movslq %eax,%rdx
 59b:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
 5a2:	48 01 d0             	add    %rdx,%rax
 5a5:	0f b6 00             	movzbl (%rax),%eax
 5a8:	0f be c0             	movsbl %al,%eax
 5ab:	25 ff 00 00 00       	and    $0xff,%eax
 5b0:	89 85 3c ff ff ff    	mov    %eax,-0xc4(%rbp)
    if(state == 0){
 5b6:	83 bd 40 ff ff ff 00 	cmpl   $0x0,-0xc0(%rbp)
 5bd:	75 35                	jne    5f4 <printf+0x100>
      if(c == '%'){
 5bf:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
 5c6:	75 0f                	jne    5d7 <printf+0xe3>
        state = '%';
 5c8:	c7 85 40 ff ff ff 25 	movl   $0x25,-0xc0(%rbp)
 5cf:	00 00 00 
 5d2:	e9 5c 02 00 00       	jmp    833 <printf+0x33f>
      } else {
        putc(fd, c);
 5d7:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
 5dd:	0f be d0             	movsbl %al,%edx
 5e0:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 5e6:	89 d6                	mov    %edx,%esi
 5e8:	89 c7                	mov    %eax,%edi
 5ea:	e8 1b fe ff ff       	call   40a <putc>
 5ef:	e9 3f 02 00 00       	jmp    833 <printf+0x33f>
      }
    } else if(state == '%'){
 5f4:	83 bd 40 ff ff ff 25 	cmpl   $0x25,-0xc0(%rbp)
 5fb:	0f 85 32 02 00 00    	jne    833 <printf+0x33f>
      if(c == 'd'){
 601:	83 bd 3c ff ff ff 64 	cmpl   $0x64,-0xc4(%rbp)
 608:	75 5e                	jne    668 <printf+0x174>
        printint(fd, va_arg(ap, int), 10, 1);
 60a:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 610:	83 f8 2f             	cmp    $0x2f,%eax
 613:	77 23                	ja     638 <printf+0x144>
 615:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 61c:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 622:	89 d2                	mov    %edx,%edx
 624:	48 01 d0             	add    %rdx,%rax
 627:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 62d:	83 c2 08             	add    $0x8,%edx
 630:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 636:	eb 12                	jmp    64a <printf+0x156>
 638:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 63f:	48 8d 50 08          	lea    0x8(%rax),%rdx
 643:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 64a:	8b 30                	mov    (%rax),%esi
 64c:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 652:	b9 01 00 00 00       	mov    $0x1,%ecx
 657:	ba 0a 00 00 00       	mov    $0xa,%edx
 65c:	89 c7                	mov    %eax,%edi
 65e:	e8 d0 fd ff ff       	call   433 <printint>
 663:	e9 c1 01 00 00       	jmp    829 <printf+0x335>
      } else if(c == 'x' || c == 'p'){
 668:	83 bd 3c ff ff ff 78 	cmpl   $0x78,-0xc4(%rbp)
 66f:	74 09                	je     67a <printf+0x186>
 671:	83 bd 3c ff ff ff 70 	cmpl   $0x70,-0xc4(%rbp)
 678:	75 5e                	jne    6d8 <printf+0x1e4>
        printint(fd, va_arg(ap, int), 16, 0);
 67a:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 680:	83 f8 2f             	cmp    $0x2f,%eax
 683:	77 23                	ja     6a8 <printf+0x1b4>
 685:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 68c:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 692:	89 d2                	mov    %edx,%edx
 694:	48 01 d0             	add    %rdx,%rax
 697:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 69d:	83 c2 08             	add    $0x8,%edx
 6a0:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 6a6:	eb 12                	jmp    6ba <printf+0x1c6>
 6a8:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 6af:	48 8d 50 08          	lea    0x8(%rax),%rdx
 6b3:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 6ba:	8b 30                	mov    (%rax),%esi
 6bc:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 6c2:	b9 00 00 00 00       	mov    $0x0,%ecx
 6c7:	ba 10 00 00 00       	mov    $0x10,%edx
 6cc:	89 c7                	mov    %eax,%edi
 6ce:	e8 60 fd ff ff       	call   433 <printint>
 6d3:	e9 51 01 00 00       	jmp    829 <printf+0x335>
      } else if(c == 's'){
 6d8:	83 bd 3c ff ff ff 73 	cmpl   $0x73,-0xc4(%rbp)
 6df:	0f 85 98 00 00 00    	jne    77d <printf+0x289>
        s = va_arg(ap, char*);
 6e5:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 6eb:	83 f8 2f             	cmp    $0x2f,%eax
 6ee:	77 23                	ja     713 <printf+0x21f>
 6f0:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 6f7:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 6fd:	89 d2                	mov    %edx,%edx
 6ff:	48 01 d0             	add    %rdx,%rax
 702:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 708:	83 c2 08             	add    $0x8,%edx
 70b:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 711:	eb 12                	jmp    725 <printf+0x231>
 713:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 71a:	48 8d 50 08          	lea    0x8(%rax),%rdx
 71e:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 725:	48 8b 00             	mov    (%rax),%rax
 728:	48 89 85 48 ff ff ff 	mov    %rax,-0xb8(%rbp)
        if(s == 0)
 72f:	48 83 bd 48 ff ff ff 	cmpq   $0x0,-0xb8(%rbp)
 736:	00 
 737:	75 31                	jne    76a <printf+0x276>
          s = "(null)";
 739:	48 c7 85 48 ff ff ff 	movq   $0xd0a,-0xb8(%rbp)
 740:	0a 0d 00 00 
        while(*s != 0){
 744:	eb 24                	jmp    76a <printf+0x276>
          putc(fd, *s);
 746:	48 8b 85 48 ff ff ff 	mov    -0xb8(%rbp),%rax
 74d:	0f b6 00             	movzbl (%rax),%eax
 750:	0f be d0             	movsbl %al,%edx
 753:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 759:	89 d6                	mov    %edx,%esi
 75b:	89 c7                	mov    %eax,%edi
 75d:	e8 a8 fc ff ff       	call   40a <putc>
          s++;
 762:	48 83 85 48 ff ff ff 	addq   $0x1,-0xb8(%rbp)
 769:	01 
        while(*s != 0){
 76a:	48 8b 85 48 ff ff ff 	mov    -0xb8(%rbp),%rax
 771:	0f b6 00             	movzbl (%rax),%eax
 774:	84 c0                	test   %al,%al
 776:	75 ce                	jne    746 <printf+0x252>
 778:	e9 ac 00 00 00       	jmp    829 <printf+0x335>
        }
      } else if(c == 'c'){
 77d:	83 bd 3c ff ff ff 63 	cmpl   $0x63,-0xc4(%rbp)
 784:	75 56                	jne    7dc <printf+0x2e8>
        putc(fd, va_arg(ap, uint));
 786:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 78c:	83 f8 2f             	cmp    $0x2f,%eax
 78f:	77 23                	ja     7b4 <printf+0x2c0>
 791:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 798:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 79e:	89 d2                	mov    %edx,%edx
 7a0:	48 01 d0             	add    %rdx,%rax
 7a3:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 7a9:	83 c2 08             	add    $0x8,%edx
 7ac:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 7b2:	eb 12                	jmp    7c6 <printf+0x2d2>
 7b4:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 7bb:	48 8d 50 08          	lea    0x8(%rax),%rdx
 7bf:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 7c6:	8b 00                	mov    (%rax),%eax
 7c8:	0f be d0             	movsbl %al,%edx
 7cb:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 7d1:	89 d6                	mov    %edx,%esi
 7d3:	89 c7                	mov    %eax,%edi
 7d5:	e8 30 fc ff ff       	call   40a <putc>
 7da:	eb 4d                	jmp    829 <printf+0x335>
      } else if(c == '%'){
 7dc:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
 7e3:	75 1a                	jne    7ff <printf+0x30b>
        putc(fd, c);
 7e5:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
 7eb:	0f be d0             	movsbl %al,%edx
 7ee:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 7f4:	89 d6                	mov    %edx,%esi
 7f6:	89 c7                	mov    %eax,%edi
 7f8:	e8 0d fc ff ff       	call   40a <putc>
 7fd:	eb 2a                	jmp    829 <printf+0x335>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 7ff:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 805:	be 25 00 00 00       	mov    $0x25,%esi
 80a:	89 c7                	mov    %eax,%edi
 80c:	e8 f9 fb ff ff       	call   40a <putc>
        putc(fd, c);
 811:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
 817:	0f be d0             	movsbl %al,%edx
 81a:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 820:	89 d6                	mov    %edx,%esi
 822:	89 c7                	mov    %eax,%edi
 824:	e8 e1 fb ff ff       	call   40a <putc>
      }
      state = 0;
 829:	c7 85 40 ff ff ff 00 	movl   $0x0,-0xc0(%rbp)
 830:	00 00 00 
  for(i = 0; fmt[i]; i++){
 833:	83 85 44 ff ff ff 01 	addl   $0x1,-0xbc(%rbp)
 83a:	8b 85 44 ff ff ff    	mov    -0xbc(%rbp),%eax
 840:	48 63 d0             	movslq %eax,%rdx
 843:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
 84a:	48 01 d0             	add    %rdx,%rax
 84d:	0f b6 00             	movzbl (%rax),%eax
 850:	84 c0                	test   %al,%al
 852:	0f 85 3a fd ff ff    	jne    592 <printf+0x9e>
    }
  }
}
 858:	90                   	nop
 859:	90                   	nop
 85a:	c9                   	leave
 85b:	c3                   	ret

000000000000085c <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 85c:	55                   	push   %rbp
 85d:	48 89 e5             	mov    %rsp,%rbp
 860:	48 83 ec 18          	sub    $0x18,%rsp
 864:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  Header *bp, *p;

  bp = (Header*)ap - 1;
 868:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 86c:	48 83 e8 10          	sub    $0x10,%rax
 870:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 874:	48 8b 05 a5 07 00 00 	mov    0x7a5(%rip),%rax        # 1020 <freep>
 87b:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 87f:	eb 2f                	jmp    8b0 <free+0x54>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 881:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 885:	48 8b 00             	mov    (%rax),%rax
 888:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 88c:	72 17                	jb     8a5 <free+0x49>
 88e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 892:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 896:	72 2f                	jb     8c7 <free+0x6b>
 898:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 89c:	48 8b 00             	mov    (%rax),%rax
 89f:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
 8a3:	72 22                	jb     8c7 <free+0x6b>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8a5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 8a9:	48 8b 00             	mov    (%rax),%rax
 8ac:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 8b0:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 8b4:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 8b8:	73 c7                	jae    881 <free+0x25>
 8ba:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 8be:	48 8b 00             	mov    (%rax),%rax
 8c1:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
 8c5:	73 ba                	jae    881 <free+0x25>
      break;
  if(bp + bp->s.size == p->s.ptr){
 8c7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 8cb:	8b 40 08             	mov    0x8(%rax),%eax
 8ce:	89 c0                	mov    %eax,%eax
 8d0:	48 c1 e0 04          	shl    $0x4,%rax
 8d4:	48 89 c2             	mov    %rax,%rdx
 8d7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 8db:	48 01 c2             	add    %rax,%rdx
 8de:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 8e2:	48 8b 00             	mov    (%rax),%rax
 8e5:	48 39 c2             	cmp    %rax,%rdx
 8e8:	75 2d                	jne    917 <free+0xbb>
    bp->s.size += p->s.ptr->s.size;
 8ea:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 8ee:	8b 50 08             	mov    0x8(%rax),%edx
 8f1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 8f5:	48 8b 00             	mov    (%rax),%rax
 8f8:	8b 40 08             	mov    0x8(%rax),%eax
 8fb:	01 c2                	add    %eax,%edx
 8fd:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 901:	89 50 08             	mov    %edx,0x8(%rax)
    bp->s.ptr = p->s.ptr->s.ptr;
 904:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 908:	48 8b 00             	mov    (%rax),%rax
 90b:	48 8b 10             	mov    (%rax),%rdx
 90e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 912:	48 89 10             	mov    %rdx,(%rax)
 915:	eb 0e                	jmp    925 <free+0xc9>
  } else
    bp->s.ptr = p->s.ptr;
 917:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 91b:	48 8b 10             	mov    (%rax),%rdx
 91e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 922:	48 89 10             	mov    %rdx,(%rax)
  if(p + p->s.size == bp){
 925:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 929:	8b 40 08             	mov    0x8(%rax),%eax
 92c:	89 c0                	mov    %eax,%eax
 92e:	48 c1 e0 04          	shl    $0x4,%rax
 932:	48 89 c2             	mov    %rax,%rdx
 935:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 939:	48 01 d0             	add    %rdx,%rax
 93c:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
 940:	75 27                	jne    969 <free+0x10d>
    p->s.size += bp->s.size;
 942:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 946:	8b 50 08             	mov    0x8(%rax),%edx
 949:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 94d:	8b 40 08             	mov    0x8(%rax),%eax
 950:	01 c2                	add    %eax,%edx
 952:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 956:	89 50 08             	mov    %edx,0x8(%rax)
    p->s.ptr = bp->s.ptr;
 959:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 95d:	48 8b 10             	mov    (%rax),%rdx
 960:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 964:	48 89 10             	mov    %rdx,(%rax)
 967:	eb 0b                	jmp    974 <free+0x118>
  } else
    p->s.ptr = bp;
 969:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 96d:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
 971:	48 89 10             	mov    %rdx,(%rax)
  freep = p;
 974:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 978:	48 89 05 a1 06 00 00 	mov    %rax,0x6a1(%rip)        # 1020 <freep>
}
 97f:	90                   	nop
 980:	c9                   	leave
 981:	c3                   	ret

0000000000000982 <morecore>:

static Header*
morecore(uint nu)
{
 982:	55                   	push   %rbp
 983:	48 89 e5             	mov    %rsp,%rbp
 986:	48 83 ec 20          	sub    $0x20,%rsp
 98a:	89 7d ec             	mov    %edi,-0x14(%rbp)
  char *p;
  Header *hp;

  if(nu < 4096)
 98d:	81 7d ec ff 0f 00 00 	cmpl   $0xfff,-0x14(%rbp)
 994:	77 07                	ja     99d <morecore+0x1b>
    nu = 4096;
 996:	c7 45 ec 00 10 00 00 	movl   $0x1000,-0x14(%rbp)
  p = sbrk(nu * sizeof(Header));
 99d:	8b 45 ec             	mov    -0x14(%rbp),%eax
 9a0:	c1 e0 04             	shl    $0x4,%eax
 9a3:	89 c7                	mov    %eax,%edi
 9a5:	e8 20 fa ff ff       	call   3ca <sbrk>
 9aa:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  if(p == (char*)-1)
 9ae:	48 83 7d f8 ff       	cmpq   $0xffffffffffffffff,-0x8(%rbp)
 9b3:	75 07                	jne    9bc <morecore+0x3a>
    return 0;
 9b5:	b8 00 00 00 00       	mov    $0x0,%eax
 9ba:	eb 29                	jmp    9e5 <morecore+0x63>
  hp = (Header*)p;
 9bc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 9c0:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  hp->s.size = nu;
 9c4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 9c8:	8b 55 ec             	mov    -0x14(%rbp),%edx
 9cb:	89 50 08             	mov    %edx,0x8(%rax)
  free((void*)(hp + 1));
 9ce:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 9d2:	48 83 c0 10          	add    $0x10,%rax
 9d6:	48 89 c7             	mov    %rax,%rdi
 9d9:	e8 7e fe ff ff       	call   85c <free>
  return freep;
 9de:	48 8b 05 3b 06 00 00 	mov    0x63b(%rip),%rax        # 1020 <freep>
}
 9e5:	c9                   	leave
 9e6:	c3                   	ret

00000000000009e7 <malloc>:

void*
malloc(uint nbytes)
{
 9e7:	55                   	push   %rbp
 9e8:	48 89 e5             	mov    %rsp,%rbp
 9eb:	48 83 ec 30          	sub    $0x30,%rsp
 9ef:	89 7d dc             	mov    %edi,-0x24(%rbp)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 9f2:	8b 45 dc             	mov    -0x24(%rbp),%eax
 9f5:	48 83 c0 0f          	add    $0xf,%rax
 9f9:	48 c1 e8 04          	shr    $0x4,%rax
 9fd:	83 c0 01             	add    $0x1,%eax
 a00:	89 45 ec             	mov    %eax,-0x14(%rbp)
  if((prevp = freep) == 0){
 a03:	48 8b 05 16 06 00 00 	mov    0x616(%rip),%rax        # 1020 <freep>
 a0a:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
 a0e:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
 a13:	75 2b                	jne    a40 <malloc+0x59>
    base.s.ptr = freep = prevp = &base;
 a15:	48 c7 45 f0 10 10 00 	movq   $0x1010,-0x10(%rbp)
 a1c:	00 
 a1d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 a21:	48 89 05 f8 05 00 00 	mov    %rax,0x5f8(%rip)        # 1020 <freep>
 a28:	48 8b 05 f1 05 00 00 	mov    0x5f1(%rip),%rax        # 1020 <freep>
 a2f:	48 89 05 da 05 00 00 	mov    %rax,0x5da(%rip)        # 1010 <base>
    base.s.size = 0;
 a36:	c7 05 d8 05 00 00 00 	movl   $0x0,0x5d8(%rip)        # 1018 <base+0x8>
 a3d:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a40:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 a44:	48 8b 00             	mov    (%rax),%rax
 a47:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
 a4b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a4f:	8b 40 08             	mov    0x8(%rax),%eax
 a52:	3b 45 ec             	cmp    -0x14(%rbp),%eax
 a55:	72 5f                	jb     ab6 <malloc+0xcf>
      if(p->s.size == nunits)
 a57:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a5b:	8b 40 08             	mov    0x8(%rax),%eax
 a5e:	39 45 ec             	cmp    %eax,-0x14(%rbp)
 a61:	75 10                	jne    a73 <malloc+0x8c>
        prevp->s.ptr = p->s.ptr;
 a63:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a67:	48 8b 10             	mov    (%rax),%rdx
 a6a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 a6e:	48 89 10             	mov    %rdx,(%rax)
 a71:	eb 2e                	jmp    aa1 <malloc+0xba>
      else {
        p->s.size -= nunits;
 a73:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a77:	8b 40 08             	mov    0x8(%rax),%eax
 a7a:	2b 45 ec             	sub    -0x14(%rbp),%eax
 a7d:	89 c2                	mov    %eax,%edx
 a7f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a83:	89 50 08             	mov    %edx,0x8(%rax)
        p += p->s.size;
 a86:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a8a:	8b 40 08             	mov    0x8(%rax),%eax
 a8d:	89 c0                	mov    %eax,%eax
 a8f:	48 c1 e0 04          	shl    $0x4,%rax
 a93:	48 01 45 f8          	add    %rax,-0x8(%rbp)
        p->s.size = nunits;
 a97:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a9b:	8b 55 ec             	mov    -0x14(%rbp),%edx
 a9e:	89 50 08             	mov    %edx,0x8(%rax)
      }
      freep = prevp;
 aa1:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 aa5:	48 89 05 74 05 00 00 	mov    %rax,0x574(%rip)        # 1020 <freep>
      return (void*)(p + 1);
 aac:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 ab0:	48 83 c0 10          	add    $0x10,%rax
 ab4:	eb 41                	jmp    af7 <malloc+0x110>
    }
    if(p == freep)
 ab6:	48 8b 05 63 05 00 00 	mov    0x563(%rip),%rax        # 1020 <freep>
 abd:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 ac1:	75 1c                	jne    adf <malloc+0xf8>
      if((p = morecore(nunits)) == 0)
 ac3:	8b 45 ec             	mov    -0x14(%rbp),%eax
 ac6:	89 c7                	mov    %eax,%edi
 ac8:	e8 b5 fe ff ff       	call   982 <morecore>
 acd:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 ad1:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
 ad6:	75 07                	jne    adf <malloc+0xf8>
        return 0;
 ad8:	b8 00 00 00 00       	mov    $0x0,%eax
 add:	eb 18                	jmp    af7 <malloc+0x110>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 adf:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 ae3:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
 ae7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 aeb:	48 8b 00             	mov    (%rax),%rax
 aee:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
 af2:	e9 54 ff ff ff       	jmp    a4b <malloc+0x64>
  }
}
 af7:	c9                   	leave
 af8:	c3                   	ret

0000000000000af9 <createRoot>:
#include "set.h"
#include "user.h"

//TODO: Να μην είναι περιορισμένο σε int

Set* createRoot(){
 af9:	55                   	push   %rbp
 afa:	48 89 e5             	mov    %rsp,%rbp
 afd:	48 83 ec 10          	sub    $0x10,%rsp
    //Αρχικοποίηση του Set
    Set *set = malloc(sizeof(Set));
 b01:	bf 10 00 00 00       	mov    $0x10,%edi
 b06:	e8 dc fe ff ff       	call   9e7 <malloc>
 b0b:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    set->size = 0;
 b0f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b13:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%rax)
    set->root = NULL;
 b1a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b1e:	48 c7 00 00 00 00 00 	movq   $0x0,(%rax)
    return set;
 b25:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
 b29:	c9                   	leave
 b2a:	c3                   	ret

0000000000000b2b <createNode>:

void createNode(int i, Set *set){
 b2b:	55                   	push   %rbp
 b2c:	48 89 e5             	mov    %rsp,%rbp
 b2f:	48 83 ec 20          	sub    $0x20,%rsp
 b33:	89 7d ec             	mov    %edi,-0x14(%rbp)
 b36:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    Η συνάρτηση αυτή δημιουργεί ένα νέο SetNode με την τιμή i και εφόσον δεν υπάρχει στο Set το προσθέτει στο τέλος του συνόλου.
    Σημείωση: Ίσως υπάρχει καλύτερος τρόπος για την υλοποίηση.
    */

    //Αρχικοποίηση του SetNode
    SetNode *temp = malloc(sizeof(SetNode));
 b3a:	bf 10 00 00 00       	mov    $0x10,%edi
 b3f:	e8 a3 fe ff ff       	call   9e7 <malloc>
 b44:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    temp->i = i;
 b48:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 b4c:	8b 55 ec             	mov    -0x14(%rbp),%edx
 b4f:	89 10                	mov    %edx,(%rax)
    temp->next = NULL;
 b51:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 b55:	48 c7 40 08 00 00 00 	movq   $0x0,0x8(%rax)
 b5c:	00 

    //Έλεγχος ύπαρξης του i
    SetNode *curr = set->root;//Ξεκινάει από την root
 b5d:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
 b61:	48 8b 00             	mov    (%rax),%rax
 b64:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(curr != NULL) { //Εφόσον το Set δεν είναι άδειο
 b68:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
 b6d:	74 34                	je     ba3 <createNode+0x78>
        while (curr->next != NULL){ //Εφόσον υπάρχει επόμενο node
 b6f:	eb 25                	jmp    b96 <createNode+0x6b>
            if (curr->i == i){ //Αν το i υπάρχει στο σύνολο
 b71:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b75:	8b 00                	mov    (%rax),%eax
 b77:	39 45 ec             	cmp    %eax,-0x14(%rbp)
 b7a:	75 0e                	jne    b8a <createNode+0x5f>
                free(temp); 
 b7c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 b80:	48 89 c7             	mov    %rax,%rdi
 b83:	e8 d4 fc ff ff       	call   85c <free>
                return; //Δεν εκτελούμε την υπόλοιπη συνάρτηση
 b88:	eb 4e                	jmp    bd8 <createNode+0xad>
            }
            curr = curr->next; //Επόμενο SetNode
 b8a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b8e:	48 8b 40 08          	mov    0x8(%rax),%rax
 b92:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
        while (curr->next != NULL){ //Εφόσον υπάρχει επόμενο node
 b96:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b9a:	48 8b 40 08          	mov    0x8(%rax),%rax
 b9e:	48 85 c0             	test   %rax,%rax
 ba1:	75 ce                	jne    b71 <createNode+0x46>
        }
    }
    /*
    Ο έλεγχος στην if είναι απαραίτητος για να ελεγχθεί το τελευταίο SetNode.
    */
    if (curr->i != i) attachNode(set, curr, temp); 
 ba3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 ba7:	8b 00                	mov    (%rax),%eax
 ba9:	39 45 ec             	cmp    %eax,-0x14(%rbp)
 bac:	74 1e                	je     bcc <createNode+0xa1>
 bae:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
 bb2:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
 bb6:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
 bba:	48 89 ce             	mov    %rcx,%rsi
 bbd:	48 89 c7             	mov    %rax,%rdi
 bc0:	b8 00 00 00 00       	mov    $0x0,%eax
 bc5:	e8 10 00 00 00       	call   bda <attachNode>
 bca:	eb 0c                	jmp    bd8 <createNode+0xad>
    else free(temp);
 bcc:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 bd0:	48 89 c7             	mov    %rax,%rdi
 bd3:	e8 84 fc ff ff       	call   85c <free>
}
 bd8:	c9                   	leave
 bd9:	c3                   	ret

0000000000000bda <attachNode>:

void attachNode(Set *set, SetNode *curr, SetNode *temp){
 bda:	55                   	push   %rbp
 bdb:	48 89 e5             	mov    %rsp,%rbp
 bde:	48 83 ec 18          	sub    $0x18,%rsp
 be2:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
 be6:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
 bea:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
    //Βάζουμε το temp στο τέλος του Set
    if(set->size == 0) set->root = temp;
 bee:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 bf2:	8b 40 08             	mov    0x8(%rax),%eax
 bf5:	85 c0                	test   %eax,%eax
 bf7:	75 0d                	jne    c06 <attachNode+0x2c>
 bf9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 bfd:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
 c01:	48 89 10             	mov    %rdx,(%rax)
 c04:	eb 0c                	jmp    c12 <attachNode+0x38>
    else curr->next = temp;
 c06:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 c0a:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
 c0e:	48 89 50 08          	mov    %rdx,0x8(%rax)
    set->size += 1;
 c12:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 c16:	8b 40 08             	mov    0x8(%rax),%eax
 c19:	8d 50 01             	lea    0x1(%rax),%edx
 c1c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 c20:	89 50 08             	mov    %edx,0x8(%rax)
}
 c23:	90                   	nop
 c24:	c9                   	leave
 c25:	c3                   	ret

0000000000000c26 <deleteSet>:

void deleteSet(Set *set){
 c26:	55                   	push   %rbp
 c27:	48 89 e5             	mov    %rsp,%rbp
 c2a:	48 83 ec 20          	sub    $0x20,%rsp
 c2e:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    if (set == NULL) return; //Αν ο χρήστης είναι ΜΛΚ!
 c32:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
 c37:	74 42                	je     c7b <deleteSet+0x55>
    SetNode *temp;
    SetNode *curr = set->root; //Ξεκινάμε από το root
 c39:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 c3d:	48 8b 00             	mov    (%rax),%rax
 c40:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    while (curr != NULL){ 
 c44:	eb 20                	jmp    c66 <deleteSet+0x40>
        temp = curr->next; //Αναφορά στο επόμενο SetNode
 c46:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 c4a:	48 8b 40 08          	mov    0x8(%rax),%rax
 c4e:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
        free(curr); //Απελευθέρωση της curr
 c52:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 c56:	48 89 c7             	mov    %rax,%rdi
 c59:	e8 fe fb ff ff       	call   85c <free>
        curr = temp;
 c5e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 c62:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    while (curr != NULL){ 
 c66:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
 c6b:	75 d9                	jne    c46 <deleteSet+0x20>
    }
    free(set); //Διαγραφή του Set
 c6d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 c71:	48 89 c7             	mov    %rax,%rdi
 c74:	e8 e3 fb ff ff       	call   85c <free>
 c79:	eb 01                	jmp    c7c <deleteSet+0x56>
    if (set == NULL) return; //Αν ο χρήστης είναι ΜΛΚ!
 c7b:	90                   	nop
}
 c7c:	c9                   	leave
 c7d:	c3                   	ret

0000000000000c7e <getNodeAtPosition>:

SetNode* getNodeAtPosition(Set *set, int i){
 c7e:	55                   	push   %rbp
 c7f:	48 89 e5             	mov    %rsp,%rbp
 c82:	48 83 ec 20          	sub    $0x20,%rsp
 c86:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
 c8a:	89 75 e4             	mov    %esi,-0x1c(%rbp)
    if (set == NULL || set->root == NULL) return NULL; //Αν ο χρήστης είναι ΜΛΚ!
 c8d:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
 c92:	74 0c                	je     ca0 <getNodeAtPosition+0x22>
 c94:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 c98:	48 8b 00             	mov    (%rax),%rax
 c9b:	48 85 c0             	test   %rax,%rax
 c9e:	75 07                	jne    ca7 <getNodeAtPosition+0x29>
 ca0:	b8 00 00 00 00       	mov    $0x0,%eax
 ca5:	eb 3d                	jmp    ce4 <getNodeAtPosition+0x66>

    SetNode *curr = set->root;
 ca7:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 cab:	48 8b 00             	mov    (%rax),%rax
 cae:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    int n;

    for(n = 0; n<i && curr->next != NULL; n++) curr = curr->next; //Ο έλεγχος εδω είναι: n<i && curr->next != NULL
 cb2:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
 cb9:	eb 10                	jmp    ccb <getNodeAtPosition+0x4d>
 cbb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 cbf:	48 8b 40 08          	mov    0x8(%rax),%rax
 cc3:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 cc7:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
 ccb:	8b 45 f4             	mov    -0xc(%rbp),%eax
 cce:	3b 45 e4             	cmp    -0x1c(%rbp),%eax
 cd1:	7d 0d                	jge    ce0 <getNodeAtPosition+0x62>
 cd3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 cd7:	48 8b 40 08          	mov    0x8(%rax),%rax
 cdb:	48 85 c0             	test   %rax,%rax
 cde:	75 db                	jne    cbb <getNodeAtPosition+0x3d>
    return curr;
 ce0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 ce4:	c9                   	leave
 ce5:	c3                   	ret
