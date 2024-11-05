
fs/mkdir:     file format elf64-x86-64


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

  if(argc < 2){
   f:	83 7d ec 01          	cmpl   $0x1,-0x14(%rbp)
  13:	7f 1b                	jg     30 <main+0x30>
    printf(2, "Usage: mkdir files...\n");
  15:	48 c7 c6 36 0d 00 00 	mov    $0xd36,%rsi
  1c:	bf 02 00 00 00       	mov    $0x2,%edi
  21:	b8 00 00 00 00       	mov    $0x0,%eax
  26:	e8 19 05 00 00       	call   544 <printf>
    exit();
  2b:	e8 62 03 00 00       	call   392 <exit>
  }

  for(i = 1; i < argc; i++){
  30:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%rbp)
  37:	eb 59                	jmp    92 <main+0x92>
    if(mkdir(argv[i]) < 0){
  39:	8b 45 fc             	mov    -0x4(%rbp),%eax
  3c:	48 98                	cltq
  3e:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
  45:	00 
  46:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  4a:	48 01 d0             	add    %rdx,%rax
  4d:	48 8b 00             	mov    (%rax),%rax
  50:	48 89 c7             	mov    %rax,%rdi
  53:	e8 a2 03 00 00       	call   3fa <mkdir>
  58:	85 c0                	test   %eax,%eax
  5a:	79 32                	jns    8e <main+0x8e>
      printf(2, "mkdir: %s failed to create\n", argv[i]);
  5c:	8b 45 fc             	mov    -0x4(%rbp),%eax
  5f:	48 98                	cltq
  61:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
  68:	00 
  69:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  6d:	48 01 d0             	add    %rdx,%rax
  70:	48 8b 00             	mov    (%rax),%rax
  73:	48 89 c2             	mov    %rax,%rdx
  76:	48 c7 c6 4d 0d 00 00 	mov    $0xd4d,%rsi
  7d:	bf 02 00 00 00       	mov    $0x2,%edi
  82:	b8 00 00 00 00       	mov    $0x0,%eax
  87:	e8 b8 04 00 00       	call   544 <printf>
      break;
  8c:	eb 0c                	jmp    9a <main+0x9a>
  for(i = 1; i < argc; i++){
  8e:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  92:	8b 45 fc             	mov    -0x4(%rbp),%eax
  95:	3b 45 ec             	cmp    -0x14(%rbp),%eax
  98:	7c 9f                	jl     39 <main+0x39>
    }
  }

  exit();
  9a:	e8 f3 02 00 00       	call   392 <exit>

000000000000009f <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
  9f:	55                   	push   %rbp
  a0:	48 89 e5             	mov    %rsp,%rbp
  a3:	48 83 ec 10          	sub    $0x10,%rsp
  a7:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  ab:	89 75 f4             	mov    %esi,-0xc(%rbp)
  ae:	89 55 f0             	mov    %edx,-0x10(%rbp)
  asm volatile("cld; rep stosb" :
  b1:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
  b5:	8b 55 f0             	mov    -0x10(%rbp),%edx
  b8:	8b 45 f4             	mov    -0xc(%rbp),%eax
  bb:	48 89 ce             	mov    %rcx,%rsi
  be:	48 89 f7             	mov    %rsi,%rdi
  c1:	89 d1                	mov    %edx,%ecx
  c3:	fc                   	cld
  c4:	f3 aa                	rep stos %al,%es:(%rdi)
  c6:	89 ca                	mov    %ecx,%edx
  c8:	48 89 fe             	mov    %rdi,%rsi
  cb:	48 89 75 f8          	mov    %rsi,-0x8(%rbp)
  cf:	89 55 f0             	mov    %edx,-0x10(%rbp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
  d2:	90                   	nop
  d3:	c9                   	leave
  d4:	c3                   	ret

00000000000000d5 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
  d5:	55                   	push   %rbp
  d6:	48 89 e5             	mov    %rsp,%rbp
  d9:	48 83 ec 20          	sub    $0x20,%rsp
  dd:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  e1:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  char *os;

  os = s;
  e5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  e9:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  while((*s++ = *t++) != 0)
  ed:	90                   	nop
  ee:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  f2:	48 8d 42 01          	lea    0x1(%rdx),%rax
  f6:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  fa:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  fe:	48 8d 48 01          	lea    0x1(%rax),%rcx
 102:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
 106:	0f b6 12             	movzbl (%rdx),%edx
 109:	88 10                	mov    %dl,(%rax)
 10b:	0f b6 00             	movzbl (%rax),%eax
 10e:	84 c0                	test   %al,%al
 110:	75 dc                	jne    ee <strcpy+0x19>
    ;
  return os;
 112:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
 116:	c9                   	leave
 117:	c3                   	ret

0000000000000118 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 118:	55                   	push   %rbp
 119:	48 89 e5             	mov    %rsp,%rbp
 11c:	48 83 ec 10          	sub    $0x10,%rsp
 120:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
 124:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  while(*p && *p == *q)
 128:	eb 0a                	jmp    134 <strcmp+0x1c>
    p++, q++;
 12a:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
 12f:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  while(*p && *p == *q)
 134:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 138:	0f b6 00             	movzbl (%rax),%eax
 13b:	84 c0                	test   %al,%al
 13d:	74 12                	je     151 <strcmp+0x39>
 13f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 143:	0f b6 10             	movzbl (%rax),%edx
 146:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 14a:	0f b6 00             	movzbl (%rax),%eax
 14d:	38 c2                	cmp    %al,%dl
 14f:	74 d9                	je     12a <strcmp+0x12>
  return (uchar)*p - (uchar)*q;
 151:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 155:	0f b6 00             	movzbl (%rax),%eax
 158:	0f b6 d0             	movzbl %al,%edx
 15b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 15f:	0f b6 00             	movzbl (%rax),%eax
 162:	0f b6 c0             	movzbl %al,%eax
 165:	29 c2                	sub    %eax,%edx
 167:	89 d0                	mov    %edx,%eax
}
 169:	c9                   	leave
 16a:	c3                   	ret

000000000000016b <strlen>:

uint
strlen(char *s)
{
 16b:	55                   	push   %rbp
 16c:	48 89 e5             	mov    %rsp,%rbp
 16f:	48 83 ec 18          	sub    $0x18,%rsp
 173:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  int n;

  for(n = 0; s[n]; n++)
 177:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
 17e:	eb 04                	jmp    184 <strlen+0x19>
 180:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
 184:	8b 45 fc             	mov    -0x4(%rbp),%eax
 187:	48 63 d0             	movslq %eax,%rdx
 18a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 18e:	48 01 d0             	add    %rdx,%rax
 191:	0f b6 00             	movzbl (%rax),%eax
 194:	84 c0                	test   %al,%al
 196:	75 e8                	jne    180 <strlen+0x15>
    ;
  return n;
 198:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
 19b:	c9                   	leave
 19c:	c3                   	ret

000000000000019d <memset>:

void*
memset(void *dst, int c, uint n)
{
 19d:	55                   	push   %rbp
 19e:	48 89 e5             	mov    %rsp,%rbp
 1a1:	48 83 ec 10          	sub    $0x10,%rsp
 1a5:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
 1a9:	89 75 f4             	mov    %esi,-0xc(%rbp)
 1ac:	89 55 f0             	mov    %edx,-0x10(%rbp)
  stosb(dst, c, n);
 1af:	8b 55 f0             	mov    -0x10(%rbp),%edx
 1b2:	8b 4d f4             	mov    -0xc(%rbp),%ecx
 1b5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 1b9:	89 ce                	mov    %ecx,%esi
 1bb:	48 89 c7             	mov    %rax,%rdi
 1be:	e8 dc fe ff ff       	call   9f <stosb>
  return dst;
 1c3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
 1c7:	c9                   	leave
 1c8:	c3                   	ret

00000000000001c9 <strchr>:

char*
strchr(const char *s, char c)
{
 1c9:	55                   	push   %rbp
 1ca:	48 89 e5             	mov    %rsp,%rbp
 1cd:	48 83 ec 10          	sub    $0x10,%rsp
 1d1:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
 1d5:	89 f0                	mov    %esi,%eax
 1d7:	88 45 f4             	mov    %al,-0xc(%rbp)
  for(; *s; s++)
 1da:	eb 17                	jmp    1f3 <strchr+0x2a>
    if(*s == c)
 1dc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 1e0:	0f b6 00             	movzbl (%rax),%eax
 1e3:	38 45 f4             	cmp    %al,-0xc(%rbp)
 1e6:	75 06                	jne    1ee <strchr+0x25>
      return (char*)s;
 1e8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 1ec:	eb 15                	jmp    203 <strchr+0x3a>
  for(; *s; s++)
 1ee:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
 1f3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 1f7:	0f b6 00             	movzbl (%rax),%eax
 1fa:	84 c0                	test   %al,%al
 1fc:	75 de                	jne    1dc <strchr+0x13>
  return 0;
 1fe:	b8 00 00 00 00       	mov    $0x0,%eax
}
 203:	c9                   	leave
 204:	c3                   	ret

0000000000000205 <gets>:

char*
gets(char *buf, int max)
{
 205:	55                   	push   %rbp
 206:	48 89 e5             	mov    %rsp,%rbp
 209:	48 83 ec 20          	sub    $0x20,%rsp
 20d:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
 211:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 214:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
 21b:	eb 48                	jmp    265 <gets+0x60>
    cc = read(0, &c, 1);
 21d:	48 8d 45 f7          	lea    -0x9(%rbp),%rax
 221:	ba 01 00 00 00       	mov    $0x1,%edx
 226:	48 89 c6             	mov    %rax,%rsi
 229:	bf 00 00 00 00       	mov    $0x0,%edi
 22e:	e8 77 01 00 00       	call   3aa <read>
 233:	89 45 f8             	mov    %eax,-0x8(%rbp)
    if(cc < 1)
 236:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
 23a:	7e 36                	jle    272 <gets+0x6d>
      break;
    buf[i++] = c;
 23c:	8b 45 fc             	mov    -0x4(%rbp),%eax
 23f:	8d 50 01             	lea    0x1(%rax),%edx
 242:	89 55 fc             	mov    %edx,-0x4(%rbp)
 245:	48 63 d0             	movslq %eax,%rdx
 248:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 24c:	48 01 c2             	add    %rax,%rdx
 24f:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
 253:	88 02                	mov    %al,(%rdx)
    if(c == '\n' || c == '\r')
 255:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
 259:	3c 0a                	cmp    $0xa,%al
 25b:	74 16                	je     273 <gets+0x6e>
 25d:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
 261:	3c 0d                	cmp    $0xd,%al
 263:	74 0e                	je     273 <gets+0x6e>
  for(i=0; i+1 < max; ){
 265:	8b 45 fc             	mov    -0x4(%rbp),%eax
 268:	83 c0 01             	add    $0x1,%eax
 26b:	39 45 e4             	cmp    %eax,-0x1c(%rbp)
 26e:	7f ad                	jg     21d <gets+0x18>
 270:	eb 01                	jmp    273 <gets+0x6e>
      break;
 272:	90                   	nop
      break;
  }
  buf[i] = '\0';
 273:	8b 45 fc             	mov    -0x4(%rbp),%eax
 276:	48 63 d0             	movslq %eax,%rdx
 279:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 27d:	48 01 d0             	add    %rdx,%rax
 280:	c6 00 00             	movb   $0x0,(%rax)
  return buf;
 283:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
 287:	c9                   	leave
 288:	c3                   	ret

0000000000000289 <stat>:

int
stat(char *n, struct stat *st)
{
 289:	55                   	push   %rbp
 28a:	48 89 e5             	mov    %rsp,%rbp
 28d:	48 83 ec 20          	sub    $0x20,%rsp
 291:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
 295:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 299:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 29d:	be 00 00 00 00       	mov    $0x0,%esi
 2a2:	48 89 c7             	mov    %rax,%rdi
 2a5:	e8 28 01 00 00       	call   3d2 <open>
 2aa:	89 45 fc             	mov    %eax,-0x4(%rbp)
  if(fd < 0)
 2ad:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
 2b1:	79 07                	jns    2ba <stat+0x31>
    return -1;
 2b3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 2b8:	eb 21                	jmp    2db <stat+0x52>
  r = fstat(fd, st);
 2ba:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
 2be:	8b 45 fc             	mov    -0x4(%rbp),%eax
 2c1:	48 89 d6             	mov    %rdx,%rsi
 2c4:	89 c7                	mov    %eax,%edi
 2c6:	e8 1f 01 00 00       	call   3ea <fstat>
 2cb:	89 45 f8             	mov    %eax,-0x8(%rbp)
  close(fd);
 2ce:	8b 45 fc             	mov    -0x4(%rbp),%eax
 2d1:	89 c7                	mov    %eax,%edi
 2d3:	e8 e2 00 00 00       	call   3ba <close>
  return r;
 2d8:	8b 45 f8             	mov    -0x8(%rbp),%eax
}
 2db:	c9                   	leave
 2dc:	c3                   	ret

00000000000002dd <atoi>:

int
atoi(const char *s)
{
 2dd:	55                   	push   %rbp
 2de:	48 89 e5             	mov    %rsp,%rbp
 2e1:	48 83 ec 18          	sub    $0x18,%rsp
 2e5:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  int n;

  n = 0;
 2e9:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  while('0' <= *s && *s <= '9')
 2f0:	eb 28                	jmp    31a <atoi+0x3d>
    n = n*10 + *s++ - '0';
 2f2:	8b 55 fc             	mov    -0x4(%rbp),%edx
 2f5:	89 d0                	mov    %edx,%eax
 2f7:	c1 e0 02             	shl    $0x2,%eax
 2fa:	01 d0                	add    %edx,%eax
 2fc:	01 c0                	add    %eax,%eax
 2fe:	89 c1                	mov    %eax,%ecx
 300:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 304:	48 8d 50 01          	lea    0x1(%rax),%rdx
 308:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
 30c:	0f b6 00             	movzbl (%rax),%eax
 30f:	0f be c0             	movsbl %al,%eax
 312:	01 c8                	add    %ecx,%eax
 314:	83 e8 30             	sub    $0x30,%eax
 317:	89 45 fc             	mov    %eax,-0x4(%rbp)
  while('0' <= *s && *s <= '9')
 31a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 31e:	0f b6 00             	movzbl (%rax),%eax
 321:	3c 2f                	cmp    $0x2f,%al
 323:	7e 0b                	jle    330 <atoi+0x53>
 325:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 329:	0f b6 00             	movzbl (%rax),%eax
 32c:	3c 39                	cmp    $0x39,%al
 32e:	7e c2                	jle    2f2 <atoi+0x15>
  return n;
 330:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
 333:	c9                   	leave
 334:	c3                   	ret

0000000000000335 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 335:	55                   	push   %rbp
 336:	48 89 e5             	mov    %rsp,%rbp
 339:	48 83 ec 28          	sub    $0x28,%rsp
 33d:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
 341:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
 345:	89 55 dc             	mov    %edx,-0x24(%rbp)
  char *dst, *src;
  
  dst = vdst;
 348:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 34c:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  src = vsrc;
 350:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
 354:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  while(n-- > 0)
 358:	eb 1d                	jmp    377 <memmove+0x42>
    *dst++ = *src++;
 35a:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
 35e:	48 8d 42 01          	lea    0x1(%rdx),%rax
 362:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
 366:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 36a:	48 8d 48 01          	lea    0x1(%rax),%rcx
 36e:	48 89 4d f8          	mov    %rcx,-0x8(%rbp)
 372:	0f b6 12             	movzbl (%rdx),%edx
 375:	88 10                	mov    %dl,(%rax)
  while(n-- > 0)
 377:	8b 45 dc             	mov    -0x24(%rbp),%eax
 37a:	8d 50 ff             	lea    -0x1(%rax),%edx
 37d:	89 55 dc             	mov    %edx,-0x24(%rbp)
 380:	85 c0                	test   %eax,%eax
 382:	7f d6                	jg     35a <memmove+0x25>
  return vdst;
 384:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
 388:	c9                   	leave
 389:	c3                   	ret

000000000000038a <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 38a:	b8 01 00 00 00       	mov    $0x1,%eax
 38f:	cd 40                	int    $0x40
 391:	c3                   	ret

0000000000000392 <exit>:
SYSCALL(exit)
 392:	b8 02 00 00 00       	mov    $0x2,%eax
 397:	cd 40                	int    $0x40
 399:	c3                   	ret

000000000000039a <wait>:
SYSCALL(wait)
 39a:	b8 03 00 00 00       	mov    $0x3,%eax
 39f:	cd 40                	int    $0x40
 3a1:	c3                   	ret

00000000000003a2 <pipe>:
SYSCALL(pipe)
 3a2:	b8 04 00 00 00       	mov    $0x4,%eax
 3a7:	cd 40                	int    $0x40
 3a9:	c3                   	ret

00000000000003aa <read>:
SYSCALL(read)
 3aa:	b8 05 00 00 00       	mov    $0x5,%eax
 3af:	cd 40                	int    $0x40
 3b1:	c3                   	ret

00000000000003b2 <write>:
SYSCALL(write)
 3b2:	b8 10 00 00 00       	mov    $0x10,%eax
 3b7:	cd 40                	int    $0x40
 3b9:	c3                   	ret

00000000000003ba <close>:
SYSCALL(close)
 3ba:	b8 15 00 00 00       	mov    $0x15,%eax
 3bf:	cd 40                	int    $0x40
 3c1:	c3                   	ret

00000000000003c2 <kill>:
SYSCALL(kill)
 3c2:	b8 06 00 00 00       	mov    $0x6,%eax
 3c7:	cd 40                	int    $0x40
 3c9:	c3                   	ret

00000000000003ca <exec>:
SYSCALL(exec)
 3ca:	b8 07 00 00 00       	mov    $0x7,%eax
 3cf:	cd 40                	int    $0x40
 3d1:	c3                   	ret

00000000000003d2 <open>:
SYSCALL(open)
 3d2:	b8 0f 00 00 00       	mov    $0xf,%eax
 3d7:	cd 40                	int    $0x40
 3d9:	c3                   	ret

00000000000003da <mknod>:
SYSCALL(mknod)
 3da:	b8 11 00 00 00       	mov    $0x11,%eax
 3df:	cd 40                	int    $0x40
 3e1:	c3                   	ret

00000000000003e2 <unlink>:
SYSCALL(unlink)
 3e2:	b8 12 00 00 00       	mov    $0x12,%eax
 3e7:	cd 40                	int    $0x40
 3e9:	c3                   	ret

00000000000003ea <fstat>:
SYSCALL(fstat)
 3ea:	b8 08 00 00 00       	mov    $0x8,%eax
 3ef:	cd 40                	int    $0x40
 3f1:	c3                   	ret

00000000000003f2 <link>:
SYSCALL(link)
 3f2:	b8 13 00 00 00       	mov    $0x13,%eax
 3f7:	cd 40                	int    $0x40
 3f9:	c3                   	ret

00000000000003fa <mkdir>:
SYSCALL(mkdir)
 3fa:	b8 14 00 00 00       	mov    $0x14,%eax
 3ff:	cd 40                	int    $0x40
 401:	c3                   	ret

0000000000000402 <chdir>:
SYSCALL(chdir)
 402:	b8 09 00 00 00       	mov    $0x9,%eax
 407:	cd 40                	int    $0x40
 409:	c3                   	ret

000000000000040a <dup>:
SYSCALL(dup)
 40a:	b8 0a 00 00 00       	mov    $0xa,%eax
 40f:	cd 40                	int    $0x40
 411:	c3                   	ret

0000000000000412 <getpid>:
SYSCALL(getpid)
 412:	b8 0b 00 00 00       	mov    $0xb,%eax
 417:	cd 40                	int    $0x40
 419:	c3                   	ret

000000000000041a <sbrk>:
SYSCALL(sbrk)
 41a:	b8 0c 00 00 00       	mov    $0xc,%eax
 41f:	cd 40                	int    $0x40
 421:	c3                   	ret

0000000000000422 <sleep>:
SYSCALL(sleep)
 422:	b8 0d 00 00 00       	mov    $0xd,%eax
 427:	cd 40                	int    $0x40
 429:	c3                   	ret

000000000000042a <uptime>:
SYSCALL(uptime)
 42a:	b8 0e 00 00 00       	mov    $0xe,%eax
 42f:	cd 40                	int    $0x40
 431:	c3                   	ret

0000000000000432 <getpinfo>:
SYSCALL(getpinfo)
 432:	b8 18 00 00 00       	mov    $0x18,%eax
 437:	cd 40                	int    $0x40
 439:	c3                   	ret

000000000000043a <getfavnum>:
SYSCALL(getfavnum)
 43a:	b8 19 00 00 00       	mov    $0x19,%eax
 43f:	cd 40                	int    $0x40
 441:	c3                   	ret

0000000000000442 <shutdown>:
SYSCALL(shutdown)
 442:	b8 1a 00 00 00       	mov    $0x1a,%eax
 447:	cd 40                	int    $0x40
 449:	c3                   	ret

000000000000044a <getcount>:
SYSCALL(getcount)
 44a:	b8 1b 00 00 00       	mov    $0x1b,%eax
 44f:	cd 40                	int    $0x40
 451:	c3                   	ret

0000000000000452 <killrandom>:
 452:	b8 1c 00 00 00       	mov    $0x1c,%eax
 457:	cd 40                	int    $0x40
 459:	c3                   	ret

000000000000045a <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 45a:	55                   	push   %rbp
 45b:	48 89 e5             	mov    %rsp,%rbp
 45e:	48 83 ec 10          	sub    $0x10,%rsp
 462:	89 7d fc             	mov    %edi,-0x4(%rbp)
 465:	89 f0                	mov    %esi,%eax
 467:	88 45 f8             	mov    %al,-0x8(%rbp)
  write(fd, &c, 1);
 46a:	48 8d 4d f8          	lea    -0x8(%rbp),%rcx
 46e:	8b 45 fc             	mov    -0x4(%rbp),%eax
 471:	ba 01 00 00 00       	mov    $0x1,%edx
 476:	48 89 ce             	mov    %rcx,%rsi
 479:	89 c7                	mov    %eax,%edi
 47b:	e8 32 ff ff ff       	call   3b2 <write>
}
 480:	90                   	nop
 481:	c9                   	leave
 482:	c3                   	ret

0000000000000483 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 483:	55                   	push   %rbp
 484:	48 89 e5             	mov    %rsp,%rbp
 487:	48 83 ec 30          	sub    $0x30,%rsp
 48b:	89 7d dc             	mov    %edi,-0x24(%rbp)
 48e:	89 75 d8             	mov    %esi,-0x28(%rbp)
 491:	89 55 d4             	mov    %edx,-0x2c(%rbp)
 494:	89 4d d0             	mov    %ecx,-0x30(%rbp)
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 497:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
  if(sgn && xx < 0){
 49e:	83 7d d0 00          	cmpl   $0x0,-0x30(%rbp)
 4a2:	74 17                	je     4bb <printint+0x38>
 4a4:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
 4a8:	79 11                	jns    4bb <printint+0x38>
    neg = 1;
 4aa:	c7 45 f8 01 00 00 00 	movl   $0x1,-0x8(%rbp)
    x = -xx;
 4b1:	8b 45 d8             	mov    -0x28(%rbp),%eax
 4b4:	f7 d8                	neg    %eax
 4b6:	89 45 f4             	mov    %eax,-0xc(%rbp)
 4b9:	eb 06                	jmp    4c1 <printint+0x3e>
  } else {
    x = xx;
 4bb:	8b 45 d8             	mov    -0x28(%rbp),%eax
 4be:	89 45 f4             	mov    %eax,-0xc(%rbp)
  }

  i = 0;
 4c1:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  do{
    buf[i++] = digits[x % base];
 4c8:	8b 4d d4             	mov    -0x2c(%rbp),%ecx
 4cb:	8b 45 f4             	mov    -0xc(%rbp),%eax
 4ce:	ba 00 00 00 00       	mov    $0x0,%edx
 4d3:	f7 f1                	div    %ecx
 4d5:	89 d1                	mov    %edx,%ecx
 4d7:	8b 45 fc             	mov    -0x4(%rbp),%eax
 4da:	8d 50 01             	lea    0x1(%rax),%edx
 4dd:	89 55 fc             	mov    %edx,-0x4(%rbp)
 4e0:	89 ca                	mov    %ecx,%edx
 4e2:	0f b6 92 50 10 00 00 	movzbl 0x1050(%rdx),%edx
 4e9:	48 98                	cltq
 4eb:	88 54 05 e0          	mov    %dl,-0x20(%rbp,%rax,1)
  }while((x /= base) != 0);
 4ef:	8b 75 d4             	mov    -0x2c(%rbp),%esi
 4f2:	8b 45 f4             	mov    -0xc(%rbp),%eax
 4f5:	ba 00 00 00 00       	mov    $0x0,%edx
 4fa:	f7 f6                	div    %esi
 4fc:	89 45 f4             	mov    %eax,-0xc(%rbp)
 4ff:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
 503:	75 c3                	jne    4c8 <printint+0x45>
  if(neg)
 505:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
 509:	74 2b                	je     536 <printint+0xb3>
    buf[i++] = '-';
 50b:	8b 45 fc             	mov    -0x4(%rbp),%eax
 50e:	8d 50 01             	lea    0x1(%rax),%edx
 511:	89 55 fc             	mov    %edx,-0x4(%rbp)
 514:	48 98                	cltq
 516:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%rbp,%rax,1)

  while(--i >= 0)
 51b:	eb 19                	jmp    536 <printint+0xb3>
    putc(fd, buf[i]);
 51d:	8b 45 fc             	mov    -0x4(%rbp),%eax
 520:	48 98                	cltq
 522:	0f b6 44 05 e0       	movzbl -0x20(%rbp,%rax,1),%eax
 527:	0f be d0             	movsbl %al,%edx
 52a:	8b 45 dc             	mov    -0x24(%rbp),%eax
 52d:	89 d6                	mov    %edx,%esi
 52f:	89 c7                	mov    %eax,%edi
 531:	e8 24 ff ff ff       	call   45a <putc>
  while(--i >= 0)
 536:	83 6d fc 01          	subl   $0x1,-0x4(%rbp)
 53a:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
 53e:	79 dd                	jns    51d <printint+0x9a>
}
 540:	90                   	nop
 541:	90                   	nop
 542:	c9                   	leave
 543:	c3                   	ret

0000000000000544 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 544:	55                   	push   %rbp
 545:	48 89 e5             	mov    %rsp,%rbp
 548:	48 81 ec f0 00 00 00 	sub    $0xf0,%rsp
 54f:	89 bd 1c ff ff ff    	mov    %edi,-0xe4(%rbp)
 555:	48 89 b5 10 ff ff ff 	mov    %rsi,-0xf0(%rbp)
 55c:	48 89 95 60 ff ff ff 	mov    %rdx,-0xa0(%rbp)
 563:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
 56a:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
 571:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
 578:	84 c0                	test   %al,%al
 57a:	74 20                	je     59c <printf+0x58>
 57c:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
 580:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
 584:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
 588:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
 58c:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
 590:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
 594:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
 598:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  va_list ap;
  char *s;
  int c, i, state;
  va_start(ap, fmt);
 59c:	c7 85 20 ff ff ff 10 	movl   $0x10,-0xe0(%rbp)
 5a3:	00 00 00 
 5a6:	c7 85 24 ff ff ff 30 	movl   $0x30,-0xdc(%rbp)
 5ad:	00 00 00 
 5b0:	48 8d 45 10          	lea    0x10(%rbp),%rax
 5b4:	48 89 85 28 ff ff ff 	mov    %rax,-0xd8(%rbp)
 5bb:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
 5c2:	48 89 85 30 ff ff ff 	mov    %rax,-0xd0(%rbp)

  state = 0;
 5c9:	c7 85 40 ff ff ff 00 	movl   $0x0,-0xc0(%rbp)
 5d0:	00 00 00 
  for(i = 0; fmt[i]; i++){
 5d3:	c7 85 44 ff ff ff 00 	movl   $0x0,-0xbc(%rbp)
 5da:	00 00 00 
 5dd:	e9 a8 02 00 00       	jmp    88a <printf+0x346>
    c = fmt[i] & 0xff;
 5e2:	8b 85 44 ff ff ff    	mov    -0xbc(%rbp),%eax
 5e8:	48 63 d0             	movslq %eax,%rdx
 5eb:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
 5f2:	48 01 d0             	add    %rdx,%rax
 5f5:	0f b6 00             	movzbl (%rax),%eax
 5f8:	0f be c0             	movsbl %al,%eax
 5fb:	25 ff 00 00 00       	and    $0xff,%eax
 600:	89 85 3c ff ff ff    	mov    %eax,-0xc4(%rbp)
    if(state == 0){
 606:	83 bd 40 ff ff ff 00 	cmpl   $0x0,-0xc0(%rbp)
 60d:	75 35                	jne    644 <printf+0x100>
      if(c == '%'){
 60f:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
 616:	75 0f                	jne    627 <printf+0xe3>
        state = '%';
 618:	c7 85 40 ff ff ff 25 	movl   $0x25,-0xc0(%rbp)
 61f:	00 00 00 
 622:	e9 5c 02 00 00       	jmp    883 <printf+0x33f>
      } else {
        putc(fd, c);
 627:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
 62d:	0f be d0             	movsbl %al,%edx
 630:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 636:	89 d6                	mov    %edx,%esi
 638:	89 c7                	mov    %eax,%edi
 63a:	e8 1b fe ff ff       	call   45a <putc>
 63f:	e9 3f 02 00 00       	jmp    883 <printf+0x33f>
      }
    } else if(state == '%'){
 644:	83 bd 40 ff ff ff 25 	cmpl   $0x25,-0xc0(%rbp)
 64b:	0f 85 32 02 00 00    	jne    883 <printf+0x33f>
      if(c == 'd'){
 651:	83 bd 3c ff ff ff 64 	cmpl   $0x64,-0xc4(%rbp)
 658:	75 5e                	jne    6b8 <printf+0x174>
        printint(fd, va_arg(ap, int), 10, 1);
 65a:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 660:	83 f8 2f             	cmp    $0x2f,%eax
 663:	77 23                	ja     688 <printf+0x144>
 665:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 66c:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 672:	89 d2                	mov    %edx,%edx
 674:	48 01 d0             	add    %rdx,%rax
 677:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 67d:	83 c2 08             	add    $0x8,%edx
 680:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 686:	eb 12                	jmp    69a <printf+0x156>
 688:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 68f:	48 8d 50 08          	lea    0x8(%rax),%rdx
 693:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 69a:	8b 30                	mov    (%rax),%esi
 69c:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 6a2:	b9 01 00 00 00       	mov    $0x1,%ecx
 6a7:	ba 0a 00 00 00       	mov    $0xa,%edx
 6ac:	89 c7                	mov    %eax,%edi
 6ae:	e8 d0 fd ff ff       	call   483 <printint>
 6b3:	e9 c1 01 00 00       	jmp    879 <printf+0x335>
      } else if(c == 'x' || c == 'p'){
 6b8:	83 bd 3c ff ff ff 78 	cmpl   $0x78,-0xc4(%rbp)
 6bf:	74 09                	je     6ca <printf+0x186>
 6c1:	83 bd 3c ff ff ff 70 	cmpl   $0x70,-0xc4(%rbp)
 6c8:	75 5e                	jne    728 <printf+0x1e4>
        printint(fd, va_arg(ap, int), 16, 0);
 6ca:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 6d0:	83 f8 2f             	cmp    $0x2f,%eax
 6d3:	77 23                	ja     6f8 <printf+0x1b4>
 6d5:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 6dc:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 6e2:	89 d2                	mov    %edx,%edx
 6e4:	48 01 d0             	add    %rdx,%rax
 6e7:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 6ed:	83 c2 08             	add    $0x8,%edx
 6f0:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 6f6:	eb 12                	jmp    70a <printf+0x1c6>
 6f8:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 6ff:	48 8d 50 08          	lea    0x8(%rax),%rdx
 703:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 70a:	8b 30                	mov    (%rax),%esi
 70c:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 712:	b9 00 00 00 00       	mov    $0x0,%ecx
 717:	ba 10 00 00 00       	mov    $0x10,%edx
 71c:	89 c7                	mov    %eax,%edi
 71e:	e8 60 fd ff ff       	call   483 <printint>
 723:	e9 51 01 00 00       	jmp    879 <printf+0x335>
      } else if(c == 's'){
 728:	83 bd 3c ff ff ff 73 	cmpl   $0x73,-0xc4(%rbp)
 72f:	0f 85 98 00 00 00    	jne    7cd <printf+0x289>
        s = va_arg(ap, char*);
 735:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 73b:	83 f8 2f             	cmp    $0x2f,%eax
 73e:	77 23                	ja     763 <printf+0x21f>
 740:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 747:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 74d:	89 d2                	mov    %edx,%edx
 74f:	48 01 d0             	add    %rdx,%rax
 752:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 758:	83 c2 08             	add    $0x8,%edx
 75b:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 761:	eb 12                	jmp    775 <printf+0x231>
 763:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 76a:	48 8d 50 08          	lea    0x8(%rax),%rdx
 76e:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 775:	48 8b 00             	mov    (%rax),%rax
 778:	48 89 85 48 ff ff ff 	mov    %rax,-0xb8(%rbp)
        if(s == 0)
 77f:	48 83 bd 48 ff ff ff 	cmpq   $0x0,-0xb8(%rbp)
 786:	00 
 787:	75 31                	jne    7ba <printf+0x276>
          s = "(null)";
 789:	48 c7 85 48 ff ff ff 	movq   $0xd69,-0xb8(%rbp)
 790:	69 0d 00 00 
        while(*s != 0){
 794:	eb 24                	jmp    7ba <printf+0x276>
          putc(fd, *s);
 796:	48 8b 85 48 ff ff ff 	mov    -0xb8(%rbp),%rax
 79d:	0f b6 00             	movzbl (%rax),%eax
 7a0:	0f be d0             	movsbl %al,%edx
 7a3:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 7a9:	89 d6                	mov    %edx,%esi
 7ab:	89 c7                	mov    %eax,%edi
 7ad:	e8 a8 fc ff ff       	call   45a <putc>
          s++;
 7b2:	48 83 85 48 ff ff ff 	addq   $0x1,-0xb8(%rbp)
 7b9:	01 
        while(*s != 0){
 7ba:	48 8b 85 48 ff ff ff 	mov    -0xb8(%rbp),%rax
 7c1:	0f b6 00             	movzbl (%rax),%eax
 7c4:	84 c0                	test   %al,%al
 7c6:	75 ce                	jne    796 <printf+0x252>
 7c8:	e9 ac 00 00 00       	jmp    879 <printf+0x335>
        }
      } else if(c == 'c'){
 7cd:	83 bd 3c ff ff ff 63 	cmpl   $0x63,-0xc4(%rbp)
 7d4:	75 56                	jne    82c <printf+0x2e8>
        putc(fd, va_arg(ap, uint));
 7d6:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 7dc:	83 f8 2f             	cmp    $0x2f,%eax
 7df:	77 23                	ja     804 <printf+0x2c0>
 7e1:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 7e8:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 7ee:	89 d2                	mov    %edx,%edx
 7f0:	48 01 d0             	add    %rdx,%rax
 7f3:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 7f9:	83 c2 08             	add    $0x8,%edx
 7fc:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 802:	eb 12                	jmp    816 <printf+0x2d2>
 804:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 80b:	48 8d 50 08          	lea    0x8(%rax),%rdx
 80f:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 816:	8b 00                	mov    (%rax),%eax
 818:	0f be d0             	movsbl %al,%edx
 81b:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 821:	89 d6                	mov    %edx,%esi
 823:	89 c7                	mov    %eax,%edi
 825:	e8 30 fc ff ff       	call   45a <putc>
 82a:	eb 4d                	jmp    879 <printf+0x335>
      } else if(c == '%'){
 82c:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
 833:	75 1a                	jne    84f <printf+0x30b>
        putc(fd, c);
 835:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
 83b:	0f be d0             	movsbl %al,%edx
 83e:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 844:	89 d6                	mov    %edx,%esi
 846:	89 c7                	mov    %eax,%edi
 848:	e8 0d fc ff ff       	call   45a <putc>
 84d:	eb 2a                	jmp    879 <printf+0x335>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 84f:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 855:	be 25 00 00 00       	mov    $0x25,%esi
 85a:	89 c7                	mov    %eax,%edi
 85c:	e8 f9 fb ff ff       	call   45a <putc>
        putc(fd, c);
 861:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
 867:	0f be d0             	movsbl %al,%edx
 86a:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 870:	89 d6                	mov    %edx,%esi
 872:	89 c7                	mov    %eax,%edi
 874:	e8 e1 fb ff ff       	call   45a <putc>
      }
      state = 0;
 879:	c7 85 40 ff ff ff 00 	movl   $0x0,-0xc0(%rbp)
 880:	00 00 00 
  for(i = 0; fmt[i]; i++){
 883:	83 85 44 ff ff ff 01 	addl   $0x1,-0xbc(%rbp)
 88a:	8b 85 44 ff ff ff    	mov    -0xbc(%rbp),%eax
 890:	48 63 d0             	movslq %eax,%rdx
 893:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
 89a:	48 01 d0             	add    %rdx,%rax
 89d:	0f b6 00             	movzbl (%rax),%eax
 8a0:	84 c0                	test   %al,%al
 8a2:	0f 85 3a fd ff ff    	jne    5e2 <printf+0x9e>
    }
  }
}
 8a8:	90                   	nop
 8a9:	90                   	nop
 8aa:	c9                   	leave
 8ab:	c3                   	ret

00000000000008ac <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 8ac:	55                   	push   %rbp
 8ad:	48 89 e5             	mov    %rsp,%rbp
 8b0:	48 83 ec 18          	sub    $0x18,%rsp
 8b4:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  Header *bp, *p;

  bp = (Header*)ap - 1;
 8b8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 8bc:	48 83 e8 10          	sub    $0x10,%rax
 8c0:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8c4:	48 8b 05 b5 07 00 00 	mov    0x7b5(%rip),%rax        # 1080 <freep>
 8cb:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 8cf:	eb 2f                	jmp    900 <free+0x54>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8d1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 8d5:	48 8b 00             	mov    (%rax),%rax
 8d8:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 8dc:	72 17                	jb     8f5 <free+0x49>
 8de:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 8e2:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 8e6:	72 2f                	jb     917 <free+0x6b>
 8e8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 8ec:	48 8b 00             	mov    (%rax),%rax
 8ef:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
 8f3:	72 22                	jb     917 <free+0x6b>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8f5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 8f9:	48 8b 00             	mov    (%rax),%rax
 8fc:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 900:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 904:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 908:	73 c7                	jae    8d1 <free+0x25>
 90a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 90e:	48 8b 00             	mov    (%rax),%rax
 911:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
 915:	73 ba                	jae    8d1 <free+0x25>
      break;
  if(bp + bp->s.size == p->s.ptr){
 917:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 91b:	8b 40 08             	mov    0x8(%rax),%eax
 91e:	89 c0                	mov    %eax,%eax
 920:	48 c1 e0 04          	shl    $0x4,%rax
 924:	48 89 c2             	mov    %rax,%rdx
 927:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 92b:	48 01 c2             	add    %rax,%rdx
 92e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 932:	48 8b 00             	mov    (%rax),%rax
 935:	48 39 c2             	cmp    %rax,%rdx
 938:	75 2d                	jne    967 <free+0xbb>
    bp->s.size += p->s.ptr->s.size;
 93a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 93e:	8b 50 08             	mov    0x8(%rax),%edx
 941:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 945:	48 8b 00             	mov    (%rax),%rax
 948:	8b 40 08             	mov    0x8(%rax),%eax
 94b:	01 c2                	add    %eax,%edx
 94d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 951:	89 50 08             	mov    %edx,0x8(%rax)
    bp->s.ptr = p->s.ptr->s.ptr;
 954:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 958:	48 8b 00             	mov    (%rax),%rax
 95b:	48 8b 10             	mov    (%rax),%rdx
 95e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 962:	48 89 10             	mov    %rdx,(%rax)
 965:	eb 0e                	jmp    975 <free+0xc9>
  } else
    bp->s.ptr = p->s.ptr;
 967:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 96b:	48 8b 10             	mov    (%rax),%rdx
 96e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 972:	48 89 10             	mov    %rdx,(%rax)
  if(p + p->s.size == bp){
 975:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 979:	8b 40 08             	mov    0x8(%rax),%eax
 97c:	89 c0                	mov    %eax,%eax
 97e:	48 c1 e0 04          	shl    $0x4,%rax
 982:	48 89 c2             	mov    %rax,%rdx
 985:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 989:	48 01 d0             	add    %rdx,%rax
 98c:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
 990:	75 27                	jne    9b9 <free+0x10d>
    p->s.size += bp->s.size;
 992:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 996:	8b 50 08             	mov    0x8(%rax),%edx
 999:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 99d:	8b 40 08             	mov    0x8(%rax),%eax
 9a0:	01 c2                	add    %eax,%edx
 9a2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 9a6:	89 50 08             	mov    %edx,0x8(%rax)
    p->s.ptr = bp->s.ptr;
 9a9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 9ad:	48 8b 10             	mov    (%rax),%rdx
 9b0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 9b4:	48 89 10             	mov    %rdx,(%rax)
 9b7:	eb 0b                	jmp    9c4 <free+0x118>
  } else
    p->s.ptr = bp;
 9b9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 9bd:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
 9c1:	48 89 10             	mov    %rdx,(%rax)
  freep = p;
 9c4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 9c8:	48 89 05 b1 06 00 00 	mov    %rax,0x6b1(%rip)        # 1080 <freep>
}
 9cf:	90                   	nop
 9d0:	c9                   	leave
 9d1:	c3                   	ret

00000000000009d2 <morecore>:

static Header*
morecore(uint nu)
{
 9d2:	55                   	push   %rbp
 9d3:	48 89 e5             	mov    %rsp,%rbp
 9d6:	48 83 ec 20          	sub    $0x20,%rsp
 9da:	89 7d ec             	mov    %edi,-0x14(%rbp)
  char *p;
  Header *hp;

  if(nu < 4096)
 9dd:	81 7d ec ff 0f 00 00 	cmpl   $0xfff,-0x14(%rbp)
 9e4:	77 07                	ja     9ed <morecore+0x1b>
    nu = 4096;
 9e6:	c7 45 ec 00 10 00 00 	movl   $0x1000,-0x14(%rbp)
  p = sbrk(nu * sizeof(Header));
 9ed:	8b 45 ec             	mov    -0x14(%rbp),%eax
 9f0:	c1 e0 04             	shl    $0x4,%eax
 9f3:	89 c7                	mov    %eax,%edi
 9f5:	e8 20 fa ff ff       	call   41a <sbrk>
 9fa:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  if(p == (char*)-1)
 9fe:	48 83 7d f8 ff       	cmpq   $0xffffffffffffffff,-0x8(%rbp)
 a03:	75 07                	jne    a0c <morecore+0x3a>
    return 0;
 a05:	b8 00 00 00 00       	mov    $0x0,%eax
 a0a:	eb 29                	jmp    a35 <morecore+0x63>
  hp = (Header*)p;
 a0c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a10:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  hp->s.size = nu;
 a14:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 a18:	8b 55 ec             	mov    -0x14(%rbp),%edx
 a1b:	89 50 08             	mov    %edx,0x8(%rax)
  free((void*)(hp + 1));
 a1e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 a22:	48 83 c0 10          	add    $0x10,%rax
 a26:	48 89 c7             	mov    %rax,%rdi
 a29:	e8 7e fe ff ff       	call   8ac <free>
  return freep;
 a2e:	48 8b 05 4b 06 00 00 	mov    0x64b(%rip),%rax        # 1080 <freep>
}
 a35:	c9                   	leave
 a36:	c3                   	ret

0000000000000a37 <malloc>:

void*
malloc(uint nbytes)
{
 a37:	55                   	push   %rbp
 a38:	48 89 e5             	mov    %rsp,%rbp
 a3b:	48 83 ec 30          	sub    $0x30,%rsp
 a3f:	89 7d dc             	mov    %edi,-0x24(%rbp)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 a42:	8b 45 dc             	mov    -0x24(%rbp),%eax
 a45:	48 83 c0 0f          	add    $0xf,%rax
 a49:	48 c1 e8 04          	shr    $0x4,%rax
 a4d:	83 c0 01             	add    $0x1,%eax
 a50:	89 45 ec             	mov    %eax,-0x14(%rbp)
  if((prevp = freep) == 0){
 a53:	48 8b 05 26 06 00 00 	mov    0x626(%rip),%rax        # 1080 <freep>
 a5a:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
 a5e:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
 a63:	75 2b                	jne    a90 <malloc+0x59>
    base.s.ptr = freep = prevp = &base;
 a65:	48 c7 45 f0 70 10 00 	movq   $0x1070,-0x10(%rbp)
 a6c:	00 
 a6d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 a71:	48 89 05 08 06 00 00 	mov    %rax,0x608(%rip)        # 1080 <freep>
 a78:	48 8b 05 01 06 00 00 	mov    0x601(%rip),%rax        # 1080 <freep>
 a7f:	48 89 05 ea 05 00 00 	mov    %rax,0x5ea(%rip)        # 1070 <base>
    base.s.size = 0;
 a86:	c7 05 e8 05 00 00 00 	movl   $0x0,0x5e8(%rip)        # 1078 <base+0x8>
 a8d:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a90:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 a94:	48 8b 00             	mov    (%rax),%rax
 a97:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
 a9b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a9f:	8b 40 08             	mov    0x8(%rax),%eax
 aa2:	3b 45 ec             	cmp    -0x14(%rbp),%eax
 aa5:	72 5f                	jb     b06 <malloc+0xcf>
      if(p->s.size == nunits)
 aa7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 aab:	8b 40 08             	mov    0x8(%rax),%eax
 aae:	39 45 ec             	cmp    %eax,-0x14(%rbp)
 ab1:	75 10                	jne    ac3 <malloc+0x8c>
        prevp->s.ptr = p->s.ptr;
 ab3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 ab7:	48 8b 10             	mov    (%rax),%rdx
 aba:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 abe:	48 89 10             	mov    %rdx,(%rax)
 ac1:	eb 2e                	jmp    af1 <malloc+0xba>
      else {
        p->s.size -= nunits;
 ac3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 ac7:	8b 40 08             	mov    0x8(%rax),%eax
 aca:	2b 45 ec             	sub    -0x14(%rbp),%eax
 acd:	89 c2                	mov    %eax,%edx
 acf:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 ad3:	89 50 08             	mov    %edx,0x8(%rax)
        p += p->s.size;
 ad6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 ada:	8b 40 08             	mov    0x8(%rax),%eax
 add:	89 c0                	mov    %eax,%eax
 adf:	48 c1 e0 04          	shl    $0x4,%rax
 ae3:	48 01 45 f8          	add    %rax,-0x8(%rbp)
        p->s.size = nunits;
 ae7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 aeb:	8b 55 ec             	mov    -0x14(%rbp),%edx
 aee:	89 50 08             	mov    %edx,0x8(%rax)
      }
      freep = prevp;
 af1:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 af5:	48 89 05 84 05 00 00 	mov    %rax,0x584(%rip)        # 1080 <freep>
      return (void*)(p + 1);
 afc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b00:	48 83 c0 10          	add    $0x10,%rax
 b04:	eb 41                	jmp    b47 <malloc+0x110>
    }
    if(p == freep)
 b06:	48 8b 05 73 05 00 00 	mov    0x573(%rip),%rax        # 1080 <freep>
 b0d:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 b11:	75 1c                	jne    b2f <malloc+0xf8>
      if((p = morecore(nunits)) == 0)
 b13:	8b 45 ec             	mov    -0x14(%rbp),%eax
 b16:	89 c7                	mov    %eax,%edi
 b18:	e8 b5 fe ff ff       	call   9d2 <morecore>
 b1d:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 b21:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
 b26:	75 07                	jne    b2f <malloc+0xf8>
        return 0;
 b28:	b8 00 00 00 00       	mov    $0x0,%eax
 b2d:	eb 18                	jmp    b47 <malloc+0x110>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 b2f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b33:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
 b37:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b3b:	48 8b 00             	mov    (%rax),%rax
 b3e:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
 b42:	e9 54 ff ff ff       	jmp    a9b <malloc+0x64>
  }
}
 b47:	c9                   	leave
 b48:	c3                   	ret

0000000000000b49 <createRoot>:
#include "set.h"
#include "user.h"

//TODO: Να μην είναι περιορισμένο σε int

Set* createRoot(){
 b49:	55                   	push   %rbp
 b4a:	48 89 e5             	mov    %rsp,%rbp
 b4d:	48 83 ec 10          	sub    $0x10,%rsp
    //Αρχικοποίηση του Set
    Set *set = malloc(sizeof(Set));
 b51:	bf 10 00 00 00       	mov    $0x10,%edi
 b56:	e8 dc fe ff ff       	call   a37 <malloc>
 b5b:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    set->size = 0;
 b5f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b63:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%rax)
    set->root = NULL;
 b6a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b6e:	48 c7 00 00 00 00 00 	movq   $0x0,(%rax)
    return set;
 b75:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
 b79:	c9                   	leave
 b7a:	c3                   	ret

0000000000000b7b <createNode>:

void createNode(int i, Set *set){
 b7b:	55                   	push   %rbp
 b7c:	48 89 e5             	mov    %rsp,%rbp
 b7f:	48 83 ec 20          	sub    $0x20,%rsp
 b83:	89 7d ec             	mov    %edi,-0x14(%rbp)
 b86:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    Η συνάρτηση αυτή δημιουργεί ένα νέο SetNode με την τιμή i και εφόσον δεν υπάρχει στο Set το προσθέτει στο τέλος του συνόλου.
    Σημείωση: Ίσως υπάρχει καλύτερος τρόπος για την υλοποίηση.
    */

    //Αρχικοποίηση του SetNode
    SetNode *temp = malloc(sizeof(SetNode));
 b8a:	bf 10 00 00 00       	mov    $0x10,%edi
 b8f:	e8 a3 fe ff ff       	call   a37 <malloc>
 b94:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    temp->i = i;
 b98:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 b9c:	8b 55 ec             	mov    -0x14(%rbp),%edx
 b9f:	89 10                	mov    %edx,(%rax)
    temp->next = NULL;
 ba1:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 ba5:	48 c7 40 08 00 00 00 	movq   $0x0,0x8(%rax)
 bac:	00 

    //Έλεγχος ύπαρξης του i
    SetNode *curr = set->root;//Ξεκινάει από την root
 bad:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
 bb1:	48 8b 00             	mov    (%rax),%rax
 bb4:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(curr != NULL) { //Εφόσον το Set δεν είναι άδειο
 bb8:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
 bbd:	74 34                	je     bf3 <createNode+0x78>
        while (curr->next != NULL){ //Εφόσον υπάρχει επόμενο node
 bbf:	eb 25                	jmp    be6 <createNode+0x6b>
            if (curr->i == i){ //Αν το i υπάρχει στο σύνολο
 bc1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 bc5:	8b 00                	mov    (%rax),%eax
 bc7:	39 45 ec             	cmp    %eax,-0x14(%rbp)
 bca:	75 0e                	jne    bda <createNode+0x5f>
                free(temp); 
 bcc:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 bd0:	48 89 c7             	mov    %rax,%rdi
 bd3:	e8 d4 fc ff ff       	call   8ac <free>
                return; //Δεν εκτελούμε την υπόλοιπη συνάρτηση
 bd8:	eb 4e                	jmp    c28 <createNode+0xad>
            }
            curr = curr->next; //Επόμενο SetNode
 bda:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 bde:	48 8b 40 08          	mov    0x8(%rax),%rax
 be2:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
        while (curr->next != NULL){ //Εφόσον υπάρχει επόμενο node
 be6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 bea:	48 8b 40 08          	mov    0x8(%rax),%rax
 bee:	48 85 c0             	test   %rax,%rax
 bf1:	75 ce                	jne    bc1 <createNode+0x46>
        }
    }
    /*
    Ο έλεγχος στην if είναι απαραίτητος για να ελεγχθεί το τελευταίο SetNode.
    */
    if (curr->i != i) attachNode(set, curr, temp); 
 bf3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 bf7:	8b 00                	mov    (%rax),%eax
 bf9:	39 45 ec             	cmp    %eax,-0x14(%rbp)
 bfc:	74 1e                	je     c1c <createNode+0xa1>
 bfe:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
 c02:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
 c06:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
 c0a:	48 89 ce             	mov    %rcx,%rsi
 c0d:	48 89 c7             	mov    %rax,%rdi
 c10:	b8 00 00 00 00       	mov    $0x0,%eax
 c15:	e8 10 00 00 00       	call   c2a <attachNode>
 c1a:	eb 0c                	jmp    c28 <createNode+0xad>
    else free(temp);
 c1c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 c20:	48 89 c7             	mov    %rax,%rdi
 c23:	e8 84 fc ff ff       	call   8ac <free>
}
 c28:	c9                   	leave
 c29:	c3                   	ret

0000000000000c2a <attachNode>:

void attachNode(Set *set, SetNode *curr, SetNode *temp){
 c2a:	55                   	push   %rbp
 c2b:	48 89 e5             	mov    %rsp,%rbp
 c2e:	48 83 ec 18          	sub    $0x18,%rsp
 c32:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
 c36:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
 c3a:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
    //Βάζουμε το temp στο τέλος του Set
    if(set->size == 0) set->root = temp;
 c3e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 c42:	8b 40 08             	mov    0x8(%rax),%eax
 c45:	85 c0                	test   %eax,%eax
 c47:	75 0d                	jne    c56 <attachNode+0x2c>
 c49:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 c4d:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
 c51:	48 89 10             	mov    %rdx,(%rax)
 c54:	eb 0c                	jmp    c62 <attachNode+0x38>
    else curr->next = temp;
 c56:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 c5a:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
 c5e:	48 89 50 08          	mov    %rdx,0x8(%rax)
    set->size += 1;
 c62:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 c66:	8b 40 08             	mov    0x8(%rax),%eax
 c69:	8d 50 01             	lea    0x1(%rax),%edx
 c6c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 c70:	89 50 08             	mov    %edx,0x8(%rax)
}
 c73:	90                   	nop
 c74:	c9                   	leave
 c75:	c3                   	ret

0000000000000c76 <deleteSet>:

void deleteSet(Set *set){
 c76:	55                   	push   %rbp
 c77:	48 89 e5             	mov    %rsp,%rbp
 c7a:	48 83 ec 20          	sub    $0x20,%rsp
 c7e:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    if (set == NULL) return; //Αν ο χρήστης είναι ΜΛΚ!
 c82:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
 c87:	74 42                	je     ccb <deleteSet+0x55>
    SetNode *temp;
    SetNode *curr = set->root; //Ξεκινάμε από το root
 c89:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 c8d:	48 8b 00             	mov    (%rax),%rax
 c90:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    while (curr != NULL){ 
 c94:	eb 20                	jmp    cb6 <deleteSet+0x40>
        temp = curr->next; //Αναφορά στο επόμενο SetNode
 c96:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 c9a:	48 8b 40 08          	mov    0x8(%rax),%rax
 c9e:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
        free(curr); //Απελευθέρωση της curr
 ca2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 ca6:	48 89 c7             	mov    %rax,%rdi
 ca9:	e8 fe fb ff ff       	call   8ac <free>
        curr = temp;
 cae:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 cb2:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    while (curr != NULL){ 
 cb6:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
 cbb:	75 d9                	jne    c96 <deleteSet+0x20>
    }
    free(set); //Διαγραφή του Set
 cbd:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 cc1:	48 89 c7             	mov    %rax,%rdi
 cc4:	e8 e3 fb ff ff       	call   8ac <free>
 cc9:	eb 01                	jmp    ccc <deleteSet+0x56>
    if (set == NULL) return; //Αν ο χρήστης είναι ΜΛΚ!
 ccb:	90                   	nop
}
 ccc:	c9                   	leave
 ccd:	c3                   	ret

0000000000000cce <getNodeAtPosition>:

SetNode* getNodeAtPosition(Set *set, int i){
 cce:	55                   	push   %rbp
 ccf:	48 89 e5             	mov    %rsp,%rbp
 cd2:	48 83 ec 20          	sub    $0x20,%rsp
 cd6:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
 cda:	89 75 e4             	mov    %esi,-0x1c(%rbp)
    if (set == NULL || set->root == NULL) return NULL; //Αν ο χρήστης είναι ΜΛΚ!
 cdd:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
 ce2:	74 0c                	je     cf0 <getNodeAtPosition+0x22>
 ce4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 ce8:	48 8b 00             	mov    (%rax),%rax
 ceb:	48 85 c0             	test   %rax,%rax
 cee:	75 07                	jne    cf7 <getNodeAtPosition+0x29>
 cf0:	b8 00 00 00 00       	mov    $0x0,%eax
 cf5:	eb 3d                	jmp    d34 <getNodeAtPosition+0x66>

    SetNode *curr = set->root;
 cf7:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 cfb:	48 8b 00             	mov    (%rax),%rax
 cfe:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    int n;

    for(n = 0; n<i && curr->next != NULL; n++) curr = curr->next; //Ο έλεγχος εδω είναι: n<i && curr->next != NULL
 d02:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
 d09:	eb 10                	jmp    d1b <getNodeAtPosition+0x4d>
 d0b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 d0f:	48 8b 40 08          	mov    0x8(%rax),%rax
 d13:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 d17:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
 d1b:	8b 45 f4             	mov    -0xc(%rbp),%eax
 d1e:	3b 45 e4             	cmp    -0x1c(%rbp),%eax
 d21:	7d 0d                	jge    d30 <getNodeAtPosition+0x62>
 d23:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 d27:	48 8b 40 08          	mov    0x8(%rax),%rax
 d2b:	48 85 c0             	test   %rax,%rax
 d2e:	75 db                	jne    d0b <getNodeAtPosition+0x3d>
    return curr;
 d30:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 d34:	c9                   	leave
 d35:	c3                   	ret
