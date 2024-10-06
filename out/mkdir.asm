
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
  15:	48 c7 c6 29 0b 00 00 	mov    $0xb29,%rsi
  1c:	bf 02 00 00 00       	mov    $0x2,%edi
  21:	b8 00 00 00 00       	mov    $0x0,%eax
  26:	e8 f9 04 00 00       	call   524 <printf>
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
  76:	48 c7 c6 40 0b 00 00 	mov    $0xb40,%rsi
  7d:	bf 02 00 00 00       	mov    $0x2,%edi
  82:	b8 00 00 00 00       	mov    $0x0,%eax
  87:	e8 98 04 00 00       	call   524 <printf>
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

000000000000043a <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 43a:	55                   	push   %rbp
 43b:	48 89 e5             	mov    %rsp,%rbp
 43e:	48 83 ec 10          	sub    $0x10,%rsp
 442:	89 7d fc             	mov    %edi,-0x4(%rbp)
 445:	89 f0                	mov    %esi,%eax
 447:	88 45 f8             	mov    %al,-0x8(%rbp)
  write(fd, &c, 1);
 44a:	48 8d 4d f8          	lea    -0x8(%rbp),%rcx
 44e:	8b 45 fc             	mov    -0x4(%rbp),%eax
 451:	ba 01 00 00 00       	mov    $0x1,%edx
 456:	48 89 ce             	mov    %rcx,%rsi
 459:	89 c7                	mov    %eax,%edi
 45b:	e8 52 ff ff ff       	call   3b2 <write>
}
 460:	90                   	nop
 461:	c9                   	leave
 462:	c3                   	ret

0000000000000463 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 463:	55                   	push   %rbp
 464:	48 89 e5             	mov    %rsp,%rbp
 467:	48 83 ec 30          	sub    $0x30,%rsp
 46b:	89 7d dc             	mov    %edi,-0x24(%rbp)
 46e:	89 75 d8             	mov    %esi,-0x28(%rbp)
 471:	89 55 d4             	mov    %edx,-0x2c(%rbp)
 474:	89 4d d0             	mov    %ecx,-0x30(%rbp)
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 477:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
  if(sgn && xx < 0){
 47e:	83 7d d0 00          	cmpl   $0x0,-0x30(%rbp)
 482:	74 17                	je     49b <printint+0x38>
 484:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
 488:	79 11                	jns    49b <printint+0x38>
    neg = 1;
 48a:	c7 45 f8 01 00 00 00 	movl   $0x1,-0x8(%rbp)
    x = -xx;
 491:	8b 45 d8             	mov    -0x28(%rbp),%eax
 494:	f7 d8                	neg    %eax
 496:	89 45 f4             	mov    %eax,-0xc(%rbp)
 499:	eb 06                	jmp    4a1 <printint+0x3e>
  } else {
    x = xx;
 49b:	8b 45 d8             	mov    -0x28(%rbp),%eax
 49e:	89 45 f4             	mov    %eax,-0xc(%rbp)
  }

  i = 0;
 4a1:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  do{
    buf[i++] = digits[x % base];
 4a8:	8b 4d d4             	mov    -0x2c(%rbp),%ecx
 4ab:	8b 45 f4             	mov    -0xc(%rbp),%eax
 4ae:	ba 00 00 00 00       	mov    $0x0,%edx
 4b3:	f7 f1                	div    %ecx
 4b5:	89 d1                	mov    %edx,%ecx
 4b7:	8b 45 fc             	mov    -0x4(%rbp),%eax
 4ba:	8d 50 01             	lea    0x1(%rax),%edx
 4bd:	89 55 fc             	mov    %edx,-0x4(%rbp)
 4c0:	89 ca                	mov    %ecx,%edx
 4c2:	0f b6 92 a0 0d 00 00 	movzbl 0xda0(%rdx),%edx
 4c9:	48 98                	cltq
 4cb:	88 54 05 e0          	mov    %dl,-0x20(%rbp,%rax,1)
  }while((x /= base) != 0);
 4cf:	8b 75 d4             	mov    -0x2c(%rbp),%esi
 4d2:	8b 45 f4             	mov    -0xc(%rbp),%eax
 4d5:	ba 00 00 00 00       	mov    $0x0,%edx
 4da:	f7 f6                	div    %esi
 4dc:	89 45 f4             	mov    %eax,-0xc(%rbp)
 4df:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
 4e3:	75 c3                	jne    4a8 <printint+0x45>
  if(neg)
 4e5:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
 4e9:	74 2b                	je     516 <printint+0xb3>
    buf[i++] = '-';
 4eb:	8b 45 fc             	mov    -0x4(%rbp),%eax
 4ee:	8d 50 01             	lea    0x1(%rax),%edx
 4f1:	89 55 fc             	mov    %edx,-0x4(%rbp)
 4f4:	48 98                	cltq
 4f6:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%rbp,%rax,1)

  while(--i >= 0)
 4fb:	eb 19                	jmp    516 <printint+0xb3>
    putc(fd, buf[i]);
 4fd:	8b 45 fc             	mov    -0x4(%rbp),%eax
 500:	48 98                	cltq
 502:	0f b6 44 05 e0       	movzbl -0x20(%rbp,%rax,1),%eax
 507:	0f be d0             	movsbl %al,%edx
 50a:	8b 45 dc             	mov    -0x24(%rbp),%eax
 50d:	89 d6                	mov    %edx,%esi
 50f:	89 c7                	mov    %eax,%edi
 511:	e8 24 ff ff ff       	call   43a <putc>
  while(--i >= 0)
 516:	83 6d fc 01          	subl   $0x1,-0x4(%rbp)
 51a:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
 51e:	79 dd                	jns    4fd <printint+0x9a>
}
 520:	90                   	nop
 521:	90                   	nop
 522:	c9                   	leave
 523:	c3                   	ret

0000000000000524 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 524:	55                   	push   %rbp
 525:	48 89 e5             	mov    %rsp,%rbp
 528:	48 81 ec f0 00 00 00 	sub    $0xf0,%rsp
 52f:	89 bd 1c ff ff ff    	mov    %edi,-0xe4(%rbp)
 535:	48 89 b5 10 ff ff ff 	mov    %rsi,-0xf0(%rbp)
 53c:	48 89 95 60 ff ff ff 	mov    %rdx,-0xa0(%rbp)
 543:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
 54a:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
 551:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
 558:	84 c0                	test   %al,%al
 55a:	74 20                	je     57c <printf+0x58>
 55c:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
 560:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
 564:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
 568:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
 56c:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
 570:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
 574:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
 578:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  va_list ap;
  char *s;
  int c, i, state;
  va_start(ap, fmt);
 57c:	c7 85 20 ff ff ff 10 	movl   $0x10,-0xe0(%rbp)
 583:	00 00 00 
 586:	c7 85 24 ff ff ff 30 	movl   $0x30,-0xdc(%rbp)
 58d:	00 00 00 
 590:	48 8d 45 10          	lea    0x10(%rbp),%rax
 594:	48 89 85 28 ff ff ff 	mov    %rax,-0xd8(%rbp)
 59b:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
 5a2:	48 89 85 30 ff ff ff 	mov    %rax,-0xd0(%rbp)

  state = 0;
 5a9:	c7 85 40 ff ff ff 00 	movl   $0x0,-0xc0(%rbp)
 5b0:	00 00 00 
  for(i = 0; fmt[i]; i++){
 5b3:	c7 85 44 ff ff ff 00 	movl   $0x0,-0xbc(%rbp)
 5ba:	00 00 00 
 5bd:	e9 a8 02 00 00       	jmp    86a <printf+0x346>
    c = fmt[i] & 0xff;
 5c2:	8b 85 44 ff ff ff    	mov    -0xbc(%rbp),%eax
 5c8:	48 63 d0             	movslq %eax,%rdx
 5cb:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
 5d2:	48 01 d0             	add    %rdx,%rax
 5d5:	0f b6 00             	movzbl (%rax),%eax
 5d8:	0f be c0             	movsbl %al,%eax
 5db:	25 ff 00 00 00       	and    $0xff,%eax
 5e0:	89 85 3c ff ff ff    	mov    %eax,-0xc4(%rbp)
    if(state == 0){
 5e6:	83 bd 40 ff ff ff 00 	cmpl   $0x0,-0xc0(%rbp)
 5ed:	75 35                	jne    624 <printf+0x100>
      if(c == '%'){
 5ef:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
 5f6:	75 0f                	jne    607 <printf+0xe3>
        state = '%';
 5f8:	c7 85 40 ff ff ff 25 	movl   $0x25,-0xc0(%rbp)
 5ff:	00 00 00 
 602:	e9 5c 02 00 00       	jmp    863 <printf+0x33f>
      } else {
        putc(fd, c);
 607:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
 60d:	0f be d0             	movsbl %al,%edx
 610:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 616:	89 d6                	mov    %edx,%esi
 618:	89 c7                	mov    %eax,%edi
 61a:	e8 1b fe ff ff       	call   43a <putc>
 61f:	e9 3f 02 00 00       	jmp    863 <printf+0x33f>
      }
    } else if(state == '%'){
 624:	83 bd 40 ff ff ff 25 	cmpl   $0x25,-0xc0(%rbp)
 62b:	0f 85 32 02 00 00    	jne    863 <printf+0x33f>
      if(c == 'd'){
 631:	83 bd 3c ff ff ff 64 	cmpl   $0x64,-0xc4(%rbp)
 638:	75 5e                	jne    698 <printf+0x174>
        printint(fd, va_arg(ap, int), 10, 1);
 63a:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 640:	83 f8 2f             	cmp    $0x2f,%eax
 643:	77 23                	ja     668 <printf+0x144>
 645:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 64c:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 652:	89 d2                	mov    %edx,%edx
 654:	48 01 d0             	add    %rdx,%rax
 657:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 65d:	83 c2 08             	add    $0x8,%edx
 660:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 666:	eb 12                	jmp    67a <printf+0x156>
 668:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 66f:	48 8d 50 08          	lea    0x8(%rax),%rdx
 673:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 67a:	8b 30                	mov    (%rax),%esi
 67c:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 682:	b9 01 00 00 00       	mov    $0x1,%ecx
 687:	ba 0a 00 00 00       	mov    $0xa,%edx
 68c:	89 c7                	mov    %eax,%edi
 68e:	e8 d0 fd ff ff       	call   463 <printint>
 693:	e9 c1 01 00 00       	jmp    859 <printf+0x335>
      } else if(c == 'x' || c == 'p'){
 698:	83 bd 3c ff ff ff 78 	cmpl   $0x78,-0xc4(%rbp)
 69f:	74 09                	je     6aa <printf+0x186>
 6a1:	83 bd 3c ff ff ff 70 	cmpl   $0x70,-0xc4(%rbp)
 6a8:	75 5e                	jne    708 <printf+0x1e4>
        printint(fd, va_arg(ap, int), 16, 0);
 6aa:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 6b0:	83 f8 2f             	cmp    $0x2f,%eax
 6b3:	77 23                	ja     6d8 <printf+0x1b4>
 6b5:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 6bc:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 6c2:	89 d2                	mov    %edx,%edx
 6c4:	48 01 d0             	add    %rdx,%rax
 6c7:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 6cd:	83 c2 08             	add    $0x8,%edx
 6d0:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 6d6:	eb 12                	jmp    6ea <printf+0x1c6>
 6d8:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 6df:	48 8d 50 08          	lea    0x8(%rax),%rdx
 6e3:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 6ea:	8b 30                	mov    (%rax),%esi
 6ec:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 6f2:	b9 00 00 00 00       	mov    $0x0,%ecx
 6f7:	ba 10 00 00 00       	mov    $0x10,%edx
 6fc:	89 c7                	mov    %eax,%edi
 6fe:	e8 60 fd ff ff       	call   463 <printint>
 703:	e9 51 01 00 00       	jmp    859 <printf+0x335>
      } else if(c == 's'){
 708:	83 bd 3c ff ff ff 73 	cmpl   $0x73,-0xc4(%rbp)
 70f:	0f 85 98 00 00 00    	jne    7ad <printf+0x289>
        s = va_arg(ap, char*);
 715:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 71b:	83 f8 2f             	cmp    $0x2f,%eax
 71e:	77 23                	ja     743 <printf+0x21f>
 720:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 727:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 72d:	89 d2                	mov    %edx,%edx
 72f:	48 01 d0             	add    %rdx,%rax
 732:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 738:	83 c2 08             	add    $0x8,%edx
 73b:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 741:	eb 12                	jmp    755 <printf+0x231>
 743:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 74a:	48 8d 50 08          	lea    0x8(%rax),%rdx
 74e:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 755:	48 8b 00             	mov    (%rax),%rax
 758:	48 89 85 48 ff ff ff 	mov    %rax,-0xb8(%rbp)
        if(s == 0)
 75f:	48 83 bd 48 ff ff ff 	cmpq   $0x0,-0xb8(%rbp)
 766:	00 
 767:	75 31                	jne    79a <printf+0x276>
          s = "(null)";
 769:	48 c7 85 48 ff ff ff 	movq   $0xb5c,-0xb8(%rbp)
 770:	5c 0b 00 00 
        while(*s != 0){
 774:	eb 24                	jmp    79a <printf+0x276>
          putc(fd, *s);
 776:	48 8b 85 48 ff ff ff 	mov    -0xb8(%rbp),%rax
 77d:	0f b6 00             	movzbl (%rax),%eax
 780:	0f be d0             	movsbl %al,%edx
 783:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 789:	89 d6                	mov    %edx,%esi
 78b:	89 c7                	mov    %eax,%edi
 78d:	e8 a8 fc ff ff       	call   43a <putc>
          s++;
 792:	48 83 85 48 ff ff ff 	addq   $0x1,-0xb8(%rbp)
 799:	01 
        while(*s != 0){
 79a:	48 8b 85 48 ff ff ff 	mov    -0xb8(%rbp),%rax
 7a1:	0f b6 00             	movzbl (%rax),%eax
 7a4:	84 c0                	test   %al,%al
 7a6:	75 ce                	jne    776 <printf+0x252>
 7a8:	e9 ac 00 00 00       	jmp    859 <printf+0x335>
        }
      } else if(c == 'c'){
 7ad:	83 bd 3c ff ff ff 63 	cmpl   $0x63,-0xc4(%rbp)
 7b4:	75 56                	jne    80c <printf+0x2e8>
        putc(fd, va_arg(ap, uint));
 7b6:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 7bc:	83 f8 2f             	cmp    $0x2f,%eax
 7bf:	77 23                	ja     7e4 <printf+0x2c0>
 7c1:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 7c8:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 7ce:	89 d2                	mov    %edx,%edx
 7d0:	48 01 d0             	add    %rdx,%rax
 7d3:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 7d9:	83 c2 08             	add    $0x8,%edx
 7dc:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 7e2:	eb 12                	jmp    7f6 <printf+0x2d2>
 7e4:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 7eb:	48 8d 50 08          	lea    0x8(%rax),%rdx
 7ef:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 7f6:	8b 00                	mov    (%rax),%eax
 7f8:	0f be d0             	movsbl %al,%edx
 7fb:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 801:	89 d6                	mov    %edx,%esi
 803:	89 c7                	mov    %eax,%edi
 805:	e8 30 fc ff ff       	call   43a <putc>
 80a:	eb 4d                	jmp    859 <printf+0x335>
      } else if(c == '%'){
 80c:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
 813:	75 1a                	jne    82f <printf+0x30b>
        putc(fd, c);
 815:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
 81b:	0f be d0             	movsbl %al,%edx
 81e:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 824:	89 d6                	mov    %edx,%esi
 826:	89 c7                	mov    %eax,%edi
 828:	e8 0d fc ff ff       	call   43a <putc>
 82d:	eb 2a                	jmp    859 <printf+0x335>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 82f:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 835:	be 25 00 00 00       	mov    $0x25,%esi
 83a:	89 c7                	mov    %eax,%edi
 83c:	e8 f9 fb ff ff       	call   43a <putc>
        putc(fd, c);
 841:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
 847:	0f be d0             	movsbl %al,%edx
 84a:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 850:	89 d6                	mov    %edx,%esi
 852:	89 c7                	mov    %eax,%edi
 854:	e8 e1 fb ff ff       	call   43a <putc>
      }
      state = 0;
 859:	c7 85 40 ff ff ff 00 	movl   $0x0,-0xc0(%rbp)
 860:	00 00 00 
  for(i = 0; fmt[i]; i++){
 863:	83 85 44 ff ff ff 01 	addl   $0x1,-0xbc(%rbp)
 86a:	8b 85 44 ff ff ff    	mov    -0xbc(%rbp),%eax
 870:	48 63 d0             	movslq %eax,%rdx
 873:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
 87a:	48 01 d0             	add    %rdx,%rax
 87d:	0f b6 00             	movzbl (%rax),%eax
 880:	84 c0                	test   %al,%al
 882:	0f 85 3a fd ff ff    	jne    5c2 <printf+0x9e>
    }
  }
}
 888:	90                   	nop
 889:	90                   	nop
 88a:	c9                   	leave
 88b:	c3                   	ret

000000000000088c <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 88c:	55                   	push   %rbp
 88d:	48 89 e5             	mov    %rsp,%rbp
 890:	48 83 ec 18          	sub    $0x18,%rsp
 894:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  Header *bp, *p;

  bp = (Header*)ap - 1;
 898:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 89c:	48 83 e8 10          	sub    $0x10,%rax
 8a0:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8a4:	48 8b 05 25 05 00 00 	mov    0x525(%rip),%rax        # dd0 <freep>
 8ab:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 8af:	eb 2f                	jmp    8e0 <free+0x54>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8b1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 8b5:	48 8b 00             	mov    (%rax),%rax
 8b8:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 8bc:	72 17                	jb     8d5 <free+0x49>
 8be:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 8c2:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 8c6:	72 2f                	jb     8f7 <free+0x6b>
 8c8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 8cc:	48 8b 00             	mov    (%rax),%rax
 8cf:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
 8d3:	72 22                	jb     8f7 <free+0x6b>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8d5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 8d9:	48 8b 00             	mov    (%rax),%rax
 8dc:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 8e0:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 8e4:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 8e8:	73 c7                	jae    8b1 <free+0x25>
 8ea:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 8ee:	48 8b 00             	mov    (%rax),%rax
 8f1:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
 8f5:	73 ba                	jae    8b1 <free+0x25>
      break;
  if(bp + bp->s.size == p->s.ptr){
 8f7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 8fb:	8b 40 08             	mov    0x8(%rax),%eax
 8fe:	89 c0                	mov    %eax,%eax
 900:	48 c1 e0 04          	shl    $0x4,%rax
 904:	48 89 c2             	mov    %rax,%rdx
 907:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 90b:	48 01 c2             	add    %rax,%rdx
 90e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 912:	48 8b 00             	mov    (%rax),%rax
 915:	48 39 c2             	cmp    %rax,%rdx
 918:	75 2d                	jne    947 <free+0xbb>
    bp->s.size += p->s.ptr->s.size;
 91a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 91e:	8b 50 08             	mov    0x8(%rax),%edx
 921:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 925:	48 8b 00             	mov    (%rax),%rax
 928:	8b 40 08             	mov    0x8(%rax),%eax
 92b:	01 c2                	add    %eax,%edx
 92d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 931:	89 50 08             	mov    %edx,0x8(%rax)
    bp->s.ptr = p->s.ptr->s.ptr;
 934:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 938:	48 8b 00             	mov    (%rax),%rax
 93b:	48 8b 10             	mov    (%rax),%rdx
 93e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 942:	48 89 10             	mov    %rdx,(%rax)
 945:	eb 0e                	jmp    955 <free+0xc9>
  } else
    bp->s.ptr = p->s.ptr;
 947:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 94b:	48 8b 10             	mov    (%rax),%rdx
 94e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 952:	48 89 10             	mov    %rdx,(%rax)
  if(p + p->s.size == bp){
 955:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 959:	8b 40 08             	mov    0x8(%rax),%eax
 95c:	89 c0                	mov    %eax,%eax
 95e:	48 c1 e0 04          	shl    $0x4,%rax
 962:	48 89 c2             	mov    %rax,%rdx
 965:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 969:	48 01 d0             	add    %rdx,%rax
 96c:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
 970:	75 27                	jne    999 <free+0x10d>
    p->s.size += bp->s.size;
 972:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 976:	8b 50 08             	mov    0x8(%rax),%edx
 979:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 97d:	8b 40 08             	mov    0x8(%rax),%eax
 980:	01 c2                	add    %eax,%edx
 982:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 986:	89 50 08             	mov    %edx,0x8(%rax)
    p->s.ptr = bp->s.ptr;
 989:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 98d:	48 8b 10             	mov    (%rax),%rdx
 990:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 994:	48 89 10             	mov    %rdx,(%rax)
 997:	eb 0b                	jmp    9a4 <free+0x118>
  } else
    p->s.ptr = bp;
 999:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 99d:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
 9a1:	48 89 10             	mov    %rdx,(%rax)
  freep = p;
 9a4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 9a8:	48 89 05 21 04 00 00 	mov    %rax,0x421(%rip)        # dd0 <freep>
}
 9af:	90                   	nop
 9b0:	c9                   	leave
 9b1:	c3                   	ret

00000000000009b2 <morecore>:

static Header*
morecore(uint nu)
{
 9b2:	55                   	push   %rbp
 9b3:	48 89 e5             	mov    %rsp,%rbp
 9b6:	48 83 ec 20          	sub    $0x20,%rsp
 9ba:	89 7d ec             	mov    %edi,-0x14(%rbp)
  char *p;
  Header *hp;

  if(nu < 4096)
 9bd:	81 7d ec ff 0f 00 00 	cmpl   $0xfff,-0x14(%rbp)
 9c4:	77 07                	ja     9cd <morecore+0x1b>
    nu = 4096;
 9c6:	c7 45 ec 00 10 00 00 	movl   $0x1000,-0x14(%rbp)
  p = sbrk(nu * sizeof(Header));
 9cd:	8b 45 ec             	mov    -0x14(%rbp),%eax
 9d0:	c1 e0 04             	shl    $0x4,%eax
 9d3:	89 c7                	mov    %eax,%edi
 9d5:	e8 40 fa ff ff       	call   41a <sbrk>
 9da:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  if(p == (char*)-1)
 9de:	48 83 7d f8 ff       	cmpq   $0xffffffffffffffff,-0x8(%rbp)
 9e3:	75 07                	jne    9ec <morecore+0x3a>
    return 0;
 9e5:	b8 00 00 00 00       	mov    $0x0,%eax
 9ea:	eb 29                	jmp    a15 <morecore+0x63>
  hp = (Header*)p;
 9ec:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 9f0:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  hp->s.size = nu;
 9f4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 9f8:	8b 55 ec             	mov    -0x14(%rbp),%edx
 9fb:	89 50 08             	mov    %edx,0x8(%rax)
  free((void*)(hp + 1));
 9fe:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 a02:	48 83 c0 10          	add    $0x10,%rax
 a06:	48 89 c7             	mov    %rax,%rdi
 a09:	e8 7e fe ff ff       	call   88c <free>
  return freep;
 a0e:	48 8b 05 bb 03 00 00 	mov    0x3bb(%rip),%rax        # dd0 <freep>
}
 a15:	c9                   	leave
 a16:	c3                   	ret

0000000000000a17 <malloc>:

void*
malloc(uint nbytes)
{
 a17:	55                   	push   %rbp
 a18:	48 89 e5             	mov    %rsp,%rbp
 a1b:	48 83 ec 30          	sub    $0x30,%rsp
 a1f:	89 7d dc             	mov    %edi,-0x24(%rbp)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 a22:	8b 45 dc             	mov    -0x24(%rbp),%eax
 a25:	48 83 c0 0f          	add    $0xf,%rax
 a29:	48 c1 e8 04          	shr    $0x4,%rax
 a2d:	83 c0 01             	add    $0x1,%eax
 a30:	89 45 ec             	mov    %eax,-0x14(%rbp)
  if((prevp = freep) == 0){
 a33:	48 8b 05 96 03 00 00 	mov    0x396(%rip),%rax        # dd0 <freep>
 a3a:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
 a3e:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
 a43:	75 2b                	jne    a70 <malloc+0x59>
    base.s.ptr = freep = prevp = &base;
 a45:	48 c7 45 f0 c0 0d 00 	movq   $0xdc0,-0x10(%rbp)
 a4c:	00 
 a4d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 a51:	48 89 05 78 03 00 00 	mov    %rax,0x378(%rip)        # dd0 <freep>
 a58:	48 8b 05 71 03 00 00 	mov    0x371(%rip),%rax        # dd0 <freep>
 a5f:	48 89 05 5a 03 00 00 	mov    %rax,0x35a(%rip)        # dc0 <base>
    base.s.size = 0;
 a66:	c7 05 58 03 00 00 00 	movl   $0x0,0x358(%rip)        # dc8 <base+0x8>
 a6d:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a70:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 a74:	48 8b 00             	mov    (%rax),%rax
 a77:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
 a7b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a7f:	8b 40 08             	mov    0x8(%rax),%eax
 a82:	3b 45 ec             	cmp    -0x14(%rbp),%eax
 a85:	72 5f                	jb     ae6 <malloc+0xcf>
      if(p->s.size == nunits)
 a87:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a8b:	8b 40 08             	mov    0x8(%rax),%eax
 a8e:	39 45 ec             	cmp    %eax,-0x14(%rbp)
 a91:	75 10                	jne    aa3 <malloc+0x8c>
        prevp->s.ptr = p->s.ptr;
 a93:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a97:	48 8b 10             	mov    (%rax),%rdx
 a9a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 a9e:	48 89 10             	mov    %rdx,(%rax)
 aa1:	eb 2e                	jmp    ad1 <malloc+0xba>
      else {
        p->s.size -= nunits;
 aa3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 aa7:	8b 40 08             	mov    0x8(%rax),%eax
 aaa:	2b 45 ec             	sub    -0x14(%rbp),%eax
 aad:	89 c2                	mov    %eax,%edx
 aaf:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 ab3:	89 50 08             	mov    %edx,0x8(%rax)
        p += p->s.size;
 ab6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 aba:	8b 40 08             	mov    0x8(%rax),%eax
 abd:	89 c0                	mov    %eax,%eax
 abf:	48 c1 e0 04          	shl    $0x4,%rax
 ac3:	48 01 45 f8          	add    %rax,-0x8(%rbp)
        p->s.size = nunits;
 ac7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 acb:	8b 55 ec             	mov    -0x14(%rbp),%edx
 ace:	89 50 08             	mov    %edx,0x8(%rax)
      }
      freep = prevp;
 ad1:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 ad5:	48 89 05 f4 02 00 00 	mov    %rax,0x2f4(%rip)        # dd0 <freep>
      return (void*)(p + 1);
 adc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 ae0:	48 83 c0 10          	add    $0x10,%rax
 ae4:	eb 41                	jmp    b27 <malloc+0x110>
    }
    if(p == freep)
 ae6:	48 8b 05 e3 02 00 00 	mov    0x2e3(%rip),%rax        # dd0 <freep>
 aed:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 af1:	75 1c                	jne    b0f <malloc+0xf8>
      if((p = morecore(nunits)) == 0)
 af3:	8b 45 ec             	mov    -0x14(%rbp),%eax
 af6:	89 c7                	mov    %eax,%edi
 af8:	e8 b5 fe ff ff       	call   9b2 <morecore>
 afd:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 b01:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
 b06:	75 07                	jne    b0f <malloc+0xf8>
        return 0;
 b08:	b8 00 00 00 00       	mov    $0x0,%eax
 b0d:	eb 18                	jmp    b27 <malloc+0x110>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 b0f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b13:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
 b17:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b1b:	48 8b 00             	mov    (%rax),%rax
 b1e:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
 b22:	e9 54 ff ff ff       	jmp    a7b <malloc+0x64>
  }
}
 b27:	c9                   	leave
 b28:	c3                   	ret
