
fs/cat:     file format elf64-x86-64


Disassembly of section .text:

0000000000000000 <cat>:

char buf[512];

void
cat(int fd)
{
   0:	55                   	push   %rbp
   1:	48 89 e5             	mov    %rsp,%rbp
   4:	48 83 ec 20          	sub    $0x20,%rsp
   8:	89 7d ec             	mov    %edi,-0x14(%rbp)
  int n;

  while((n = read(fd, buf, sizeof(buf))) > 0)
   b:	eb 16                	jmp    23 <cat+0x23>
    write(1, buf, n);
   d:	8b 45 fc             	mov    -0x4(%rbp),%eax
  10:	89 c2                	mov    %eax,%edx
  12:	48 c7 c6 00 11 00 00 	mov    $0x1100,%rsi
  19:	bf 01 00 00 00       	mov    $0x1,%edi
  1e:	e8 0e 04 00 00       	call   431 <write>
  while((n = read(fd, buf, sizeof(buf))) > 0)
  23:	8b 45 ec             	mov    -0x14(%rbp),%eax
  26:	ba 00 02 00 00       	mov    $0x200,%edx
  2b:	48 c7 c6 00 11 00 00 	mov    $0x1100,%rsi
  32:	89 c7                	mov    %eax,%edi
  34:	e8 f0 03 00 00       	call   429 <read>
  39:	89 45 fc             	mov    %eax,-0x4(%rbp)
  3c:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  40:	7f cb                	jg     d <cat+0xd>
  if(n < 0){
  42:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  46:	79 1b                	jns    63 <cat+0x63>
    printf(1, "cat: read error\n");
  48:	48 c7 c6 b5 0d 00 00 	mov    $0xdb5,%rsi
  4f:	bf 01 00 00 00       	mov    $0x1,%edi
  54:	b8 00 00 00 00       	mov    $0x0,%eax
  59:	e8 65 05 00 00       	call   5c3 <printf>
    exit();
  5e:	e8 ae 03 00 00       	call   411 <exit>
  }
}
  63:	90                   	nop
  64:	c9                   	leave
  65:	c3                   	ret

0000000000000066 <main>:

int
main(int argc, char *argv[])
{
  66:	55                   	push   %rbp
  67:	48 89 e5             	mov    %rsp,%rbp
  6a:	48 83 ec 20          	sub    $0x20,%rsp
  6e:	89 7d ec             	mov    %edi,-0x14(%rbp)
  71:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  int fd, i;

  if(argc <= 1){
  75:	83 7d ec 01          	cmpl   $0x1,-0x14(%rbp)
  79:	7f 0f                	jg     8a <main+0x24>
    cat(0);
  7b:	bf 00 00 00 00       	mov    $0x0,%edi
  80:	e8 7b ff ff ff       	call   0 <cat>
    exit();
  85:	e8 87 03 00 00       	call   411 <exit>
  }

  for(i = 1; i < argc; i++){
  8a:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%rbp)
  91:	eb 7a                	jmp    10d <main+0xa7>
    if((fd = open(argv[i], 0)) < 0){
  93:	8b 45 fc             	mov    -0x4(%rbp),%eax
  96:	48 98                	cltq
  98:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
  9f:	00 
  a0:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  a4:	48 01 d0             	add    %rdx,%rax
  a7:	48 8b 00             	mov    (%rax),%rax
  aa:	be 00 00 00 00       	mov    $0x0,%esi
  af:	48 89 c7             	mov    %rax,%rdi
  b2:	e8 9a 03 00 00       	call   451 <open>
  b7:	89 45 f8             	mov    %eax,-0x8(%rbp)
  ba:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
  be:	79 35                	jns    f5 <main+0x8f>
      printf(1, "cat: cannot open %s\n", argv[i]);
  c0:	8b 45 fc             	mov    -0x4(%rbp),%eax
  c3:	48 98                	cltq
  c5:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
  cc:	00 
  cd:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  d1:	48 01 d0             	add    %rdx,%rax
  d4:	48 8b 00             	mov    (%rax),%rax
  d7:	48 89 c2             	mov    %rax,%rdx
  da:	48 c7 c6 c6 0d 00 00 	mov    $0xdc6,%rsi
  e1:	bf 01 00 00 00       	mov    $0x1,%edi
  e6:	b8 00 00 00 00       	mov    $0x0,%eax
  eb:	e8 d3 04 00 00       	call   5c3 <printf>
      exit();
  f0:	e8 1c 03 00 00       	call   411 <exit>
    }
    cat(fd);
  f5:	8b 45 f8             	mov    -0x8(%rbp),%eax
  f8:	89 c7                	mov    %eax,%edi
  fa:	e8 01 ff ff ff       	call   0 <cat>
    close(fd);
  ff:	8b 45 f8             	mov    -0x8(%rbp),%eax
 102:	89 c7                	mov    %eax,%edi
 104:	e8 30 03 00 00       	call   439 <close>
  for(i = 1; i < argc; i++){
 109:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
 10d:	8b 45 fc             	mov    -0x4(%rbp),%eax
 110:	3b 45 ec             	cmp    -0x14(%rbp),%eax
 113:	0f 8c 7a ff ff ff    	jl     93 <main+0x2d>
  }
  exit();
 119:	e8 f3 02 00 00       	call   411 <exit>

000000000000011e <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
 11e:	55                   	push   %rbp
 11f:	48 89 e5             	mov    %rsp,%rbp
 122:	48 83 ec 10          	sub    $0x10,%rsp
 126:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
 12a:	89 75 f4             	mov    %esi,-0xc(%rbp)
 12d:	89 55 f0             	mov    %edx,-0x10(%rbp)
  asm volatile("cld; rep stosb" :
 130:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
 134:	8b 55 f0             	mov    -0x10(%rbp),%edx
 137:	8b 45 f4             	mov    -0xc(%rbp),%eax
 13a:	48 89 ce             	mov    %rcx,%rsi
 13d:	48 89 f7             	mov    %rsi,%rdi
 140:	89 d1                	mov    %edx,%ecx
 142:	fc                   	cld
 143:	f3 aa                	rep stos %al,%es:(%rdi)
 145:	89 ca                	mov    %ecx,%edx
 147:	48 89 fe             	mov    %rdi,%rsi
 14a:	48 89 75 f8          	mov    %rsi,-0x8(%rbp)
 14e:	89 55 f0             	mov    %edx,-0x10(%rbp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
 151:	90                   	nop
 152:	c9                   	leave
 153:	c3                   	ret

0000000000000154 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 154:	55                   	push   %rbp
 155:	48 89 e5             	mov    %rsp,%rbp
 158:	48 83 ec 20          	sub    $0x20,%rsp
 15c:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
 160:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  char *os;

  os = s;
 164:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 168:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  while((*s++ = *t++) != 0)
 16c:	90                   	nop
 16d:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
 171:	48 8d 42 01          	lea    0x1(%rdx),%rax
 175:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
 179:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 17d:	48 8d 48 01          	lea    0x1(%rax),%rcx
 181:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
 185:	0f b6 12             	movzbl (%rdx),%edx
 188:	88 10                	mov    %dl,(%rax)
 18a:	0f b6 00             	movzbl (%rax),%eax
 18d:	84 c0                	test   %al,%al
 18f:	75 dc                	jne    16d <strcpy+0x19>
    ;
  return os;
 191:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
 195:	c9                   	leave
 196:	c3                   	ret

0000000000000197 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 197:	55                   	push   %rbp
 198:	48 89 e5             	mov    %rsp,%rbp
 19b:	48 83 ec 10          	sub    $0x10,%rsp
 19f:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
 1a3:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  while(*p && *p == *q)
 1a7:	eb 0a                	jmp    1b3 <strcmp+0x1c>
    p++, q++;
 1a9:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
 1ae:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  while(*p && *p == *q)
 1b3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 1b7:	0f b6 00             	movzbl (%rax),%eax
 1ba:	84 c0                	test   %al,%al
 1bc:	74 12                	je     1d0 <strcmp+0x39>
 1be:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 1c2:	0f b6 10             	movzbl (%rax),%edx
 1c5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 1c9:	0f b6 00             	movzbl (%rax),%eax
 1cc:	38 c2                	cmp    %al,%dl
 1ce:	74 d9                	je     1a9 <strcmp+0x12>
  return (uchar)*p - (uchar)*q;
 1d0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 1d4:	0f b6 00             	movzbl (%rax),%eax
 1d7:	0f b6 d0             	movzbl %al,%edx
 1da:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 1de:	0f b6 00             	movzbl (%rax),%eax
 1e1:	0f b6 c0             	movzbl %al,%eax
 1e4:	29 c2                	sub    %eax,%edx
 1e6:	89 d0                	mov    %edx,%eax
}
 1e8:	c9                   	leave
 1e9:	c3                   	ret

00000000000001ea <strlen>:

uint
strlen(char *s)
{
 1ea:	55                   	push   %rbp
 1eb:	48 89 e5             	mov    %rsp,%rbp
 1ee:	48 83 ec 18          	sub    $0x18,%rsp
 1f2:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  int n;

  for(n = 0; s[n]; n++)
 1f6:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
 1fd:	eb 04                	jmp    203 <strlen+0x19>
 1ff:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
 203:	8b 45 fc             	mov    -0x4(%rbp),%eax
 206:	48 63 d0             	movslq %eax,%rdx
 209:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 20d:	48 01 d0             	add    %rdx,%rax
 210:	0f b6 00             	movzbl (%rax),%eax
 213:	84 c0                	test   %al,%al
 215:	75 e8                	jne    1ff <strlen+0x15>
    ;
  return n;
 217:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
 21a:	c9                   	leave
 21b:	c3                   	ret

000000000000021c <memset>:

void*
memset(void *dst, int c, uint n)
{
 21c:	55                   	push   %rbp
 21d:	48 89 e5             	mov    %rsp,%rbp
 220:	48 83 ec 10          	sub    $0x10,%rsp
 224:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
 228:	89 75 f4             	mov    %esi,-0xc(%rbp)
 22b:	89 55 f0             	mov    %edx,-0x10(%rbp)
  stosb(dst, c, n);
 22e:	8b 55 f0             	mov    -0x10(%rbp),%edx
 231:	8b 4d f4             	mov    -0xc(%rbp),%ecx
 234:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 238:	89 ce                	mov    %ecx,%esi
 23a:	48 89 c7             	mov    %rax,%rdi
 23d:	e8 dc fe ff ff       	call   11e <stosb>
  return dst;
 242:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
 246:	c9                   	leave
 247:	c3                   	ret

0000000000000248 <strchr>:

char*
strchr(const char *s, char c)
{
 248:	55                   	push   %rbp
 249:	48 89 e5             	mov    %rsp,%rbp
 24c:	48 83 ec 10          	sub    $0x10,%rsp
 250:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
 254:	89 f0                	mov    %esi,%eax
 256:	88 45 f4             	mov    %al,-0xc(%rbp)
  for(; *s; s++)
 259:	eb 17                	jmp    272 <strchr+0x2a>
    if(*s == c)
 25b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 25f:	0f b6 00             	movzbl (%rax),%eax
 262:	38 45 f4             	cmp    %al,-0xc(%rbp)
 265:	75 06                	jne    26d <strchr+0x25>
      return (char*)s;
 267:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 26b:	eb 15                	jmp    282 <strchr+0x3a>
  for(; *s; s++)
 26d:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
 272:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 276:	0f b6 00             	movzbl (%rax),%eax
 279:	84 c0                	test   %al,%al
 27b:	75 de                	jne    25b <strchr+0x13>
  return 0;
 27d:	b8 00 00 00 00       	mov    $0x0,%eax
}
 282:	c9                   	leave
 283:	c3                   	ret

0000000000000284 <gets>:

char*
gets(char *buf, int max)
{
 284:	55                   	push   %rbp
 285:	48 89 e5             	mov    %rsp,%rbp
 288:	48 83 ec 20          	sub    $0x20,%rsp
 28c:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
 290:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 293:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
 29a:	eb 48                	jmp    2e4 <gets+0x60>
    cc = read(0, &c, 1);
 29c:	48 8d 45 f7          	lea    -0x9(%rbp),%rax
 2a0:	ba 01 00 00 00       	mov    $0x1,%edx
 2a5:	48 89 c6             	mov    %rax,%rsi
 2a8:	bf 00 00 00 00       	mov    $0x0,%edi
 2ad:	e8 77 01 00 00       	call   429 <read>
 2b2:	89 45 f8             	mov    %eax,-0x8(%rbp)
    if(cc < 1)
 2b5:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
 2b9:	7e 36                	jle    2f1 <gets+0x6d>
      break;
    buf[i++] = c;
 2bb:	8b 45 fc             	mov    -0x4(%rbp),%eax
 2be:	8d 50 01             	lea    0x1(%rax),%edx
 2c1:	89 55 fc             	mov    %edx,-0x4(%rbp)
 2c4:	48 63 d0             	movslq %eax,%rdx
 2c7:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 2cb:	48 01 c2             	add    %rax,%rdx
 2ce:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
 2d2:	88 02                	mov    %al,(%rdx)
    if(c == '\n' || c == '\r')
 2d4:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
 2d8:	3c 0a                	cmp    $0xa,%al
 2da:	74 16                	je     2f2 <gets+0x6e>
 2dc:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
 2e0:	3c 0d                	cmp    $0xd,%al
 2e2:	74 0e                	je     2f2 <gets+0x6e>
  for(i=0; i+1 < max; ){
 2e4:	8b 45 fc             	mov    -0x4(%rbp),%eax
 2e7:	83 c0 01             	add    $0x1,%eax
 2ea:	39 45 e4             	cmp    %eax,-0x1c(%rbp)
 2ed:	7f ad                	jg     29c <gets+0x18>
 2ef:	eb 01                	jmp    2f2 <gets+0x6e>
      break;
 2f1:	90                   	nop
      break;
  }
  buf[i] = '\0';
 2f2:	8b 45 fc             	mov    -0x4(%rbp),%eax
 2f5:	48 63 d0             	movslq %eax,%rdx
 2f8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 2fc:	48 01 d0             	add    %rdx,%rax
 2ff:	c6 00 00             	movb   $0x0,(%rax)
  return buf;
 302:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
 306:	c9                   	leave
 307:	c3                   	ret

0000000000000308 <stat>:

int
stat(char *n, struct stat *st)
{
 308:	55                   	push   %rbp
 309:	48 89 e5             	mov    %rsp,%rbp
 30c:	48 83 ec 20          	sub    $0x20,%rsp
 310:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
 314:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 318:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 31c:	be 00 00 00 00       	mov    $0x0,%esi
 321:	48 89 c7             	mov    %rax,%rdi
 324:	e8 28 01 00 00       	call   451 <open>
 329:	89 45 fc             	mov    %eax,-0x4(%rbp)
  if(fd < 0)
 32c:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
 330:	79 07                	jns    339 <stat+0x31>
    return -1;
 332:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 337:	eb 21                	jmp    35a <stat+0x52>
  r = fstat(fd, st);
 339:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
 33d:	8b 45 fc             	mov    -0x4(%rbp),%eax
 340:	48 89 d6             	mov    %rdx,%rsi
 343:	89 c7                	mov    %eax,%edi
 345:	e8 1f 01 00 00       	call   469 <fstat>
 34a:	89 45 f8             	mov    %eax,-0x8(%rbp)
  close(fd);
 34d:	8b 45 fc             	mov    -0x4(%rbp),%eax
 350:	89 c7                	mov    %eax,%edi
 352:	e8 e2 00 00 00       	call   439 <close>
  return r;
 357:	8b 45 f8             	mov    -0x8(%rbp),%eax
}
 35a:	c9                   	leave
 35b:	c3                   	ret

000000000000035c <atoi>:

int
atoi(const char *s)
{
 35c:	55                   	push   %rbp
 35d:	48 89 e5             	mov    %rsp,%rbp
 360:	48 83 ec 18          	sub    $0x18,%rsp
 364:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  int n;

  n = 0;
 368:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  while('0' <= *s && *s <= '9')
 36f:	eb 28                	jmp    399 <atoi+0x3d>
    n = n*10 + *s++ - '0';
 371:	8b 55 fc             	mov    -0x4(%rbp),%edx
 374:	89 d0                	mov    %edx,%eax
 376:	c1 e0 02             	shl    $0x2,%eax
 379:	01 d0                	add    %edx,%eax
 37b:	01 c0                	add    %eax,%eax
 37d:	89 c1                	mov    %eax,%ecx
 37f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 383:	48 8d 50 01          	lea    0x1(%rax),%rdx
 387:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
 38b:	0f b6 00             	movzbl (%rax),%eax
 38e:	0f be c0             	movsbl %al,%eax
 391:	01 c8                	add    %ecx,%eax
 393:	83 e8 30             	sub    $0x30,%eax
 396:	89 45 fc             	mov    %eax,-0x4(%rbp)
  while('0' <= *s && *s <= '9')
 399:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 39d:	0f b6 00             	movzbl (%rax),%eax
 3a0:	3c 2f                	cmp    $0x2f,%al
 3a2:	7e 0b                	jle    3af <atoi+0x53>
 3a4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 3a8:	0f b6 00             	movzbl (%rax),%eax
 3ab:	3c 39                	cmp    $0x39,%al
 3ad:	7e c2                	jle    371 <atoi+0x15>
  return n;
 3af:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
 3b2:	c9                   	leave
 3b3:	c3                   	ret

00000000000003b4 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 3b4:	55                   	push   %rbp
 3b5:	48 89 e5             	mov    %rsp,%rbp
 3b8:	48 83 ec 28          	sub    $0x28,%rsp
 3bc:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
 3c0:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
 3c4:	89 55 dc             	mov    %edx,-0x24(%rbp)
  char *dst, *src;
  
  dst = vdst;
 3c7:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 3cb:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  src = vsrc;
 3cf:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
 3d3:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  while(n-- > 0)
 3d7:	eb 1d                	jmp    3f6 <memmove+0x42>
    *dst++ = *src++;
 3d9:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
 3dd:	48 8d 42 01          	lea    0x1(%rdx),%rax
 3e1:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
 3e5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 3e9:	48 8d 48 01          	lea    0x1(%rax),%rcx
 3ed:	48 89 4d f8          	mov    %rcx,-0x8(%rbp)
 3f1:	0f b6 12             	movzbl (%rdx),%edx
 3f4:	88 10                	mov    %dl,(%rax)
  while(n-- > 0)
 3f6:	8b 45 dc             	mov    -0x24(%rbp),%eax
 3f9:	8d 50 ff             	lea    -0x1(%rax),%edx
 3fc:	89 55 dc             	mov    %edx,-0x24(%rbp)
 3ff:	85 c0                	test   %eax,%eax
 401:	7f d6                	jg     3d9 <memmove+0x25>
  return vdst;
 403:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
 407:	c9                   	leave
 408:	c3                   	ret

0000000000000409 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 409:	b8 01 00 00 00       	mov    $0x1,%eax
 40e:	cd 40                	int    $0x40
 410:	c3                   	ret

0000000000000411 <exit>:
SYSCALL(exit)
 411:	b8 02 00 00 00       	mov    $0x2,%eax
 416:	cd 40                	int    $0x40
 418:	c3                   	ret

0000000000000419 <wait>:
SYSCALL(wait)
 419:	b8 03 00 00 00       	mov    $0x3,%eax
 41e:	cd 40                	int    $0x40
 420:	c3                   	ret

0000000000000421 <pipe>:
SYSCALL(pipe)
 421:	b8 04 00 00 00       	mov    $0x4,%eax
 426:	cd 40                	int    $0x40
 428:	c3                   	ret

0000000000000429 <read>:
SYSCALL(read)
 429:	b8 05 00 00 00       	mov    $0x5,%eax
 42e:	cd 40                	int    $0x40
 430:	c3                   	ret

0000000000000431 <write>:
SYSCALL(write)
 431:	b8 10 00 00 00       	mov    $0x10,%eax
 436:	cd 40                	int    $0x40
 438:	c3                   	ret

0000000000000439 <close>:
SYSCALL(close)
 439:	b8 15 00 00 00       	mov    $0x15,%eax
 43e:	cd 40                	int    $0x40
 440:	c3                   	ret

0000000000000441 <kill>:
SYSCALL(kill)
 441:	b8 06 00 00 00       	mov    $0x6,%eax
 446:	cd 40                	int    $0x40
 448:	c3                   	ret

0000000000000449 <exec>:
SYSCALL(exec)
 449:	b8 07 00 00 00       	mov    $0x7,%eax
 44e:	cd 40                	int    $0x40
 450:	c3                   	ret

0000000000000451 <open>:
SYSCALL(open)
 451:	b8 0f 00 00 00       	mov    $0xf,%eax
 456:	cd 40                	int    $0x40
 458:	c3                   	ret

0000000000000459 <mknod>:
SYSCALL(mknod)
 459:	b8 11 00 00 00       	mov    $0x11,%eax
 45e:	cd 40                	int    $0x40
 460:	c3                   	ret

0000000000000461 <unlink>:
SYSCALL(unlink)
 461:	b8 12 00 00 00       	mov    $0x12,%eax
 466:	cd 40                	int    $0x40
 468:	c3                   	ret

0000000000000469 <fstat>:
SYSCALL(fstat)
 469:	b8 08 00 00 00       	mov    $0x8,%eax
 46e:	cd 40                	int    $0x40
 470:	c3                   	ret

0000000000000471 <link>:
SYSCALL(link)
 471:	b8 13 00 00 00       	mov    $0x13,%eax
 476:	cd 40                	int    $0x40
 478:	c3                   	ret

0000000000000479 <mkdir>:
SYSCALL(mkdir)
 479:	b8 14 00 00 00       	mov    $0x14,%eax
 47e:	cd 40                	int    $0x40
 480:	c3                   	ret

0000000000000481 <chdir>:
SYSCALL(chdir)
 481:	b8 09 00 00 00       	mov    $0x9,%eax
 486:	cd 40                	int    $0x40
 488:	c3                   	ret

0000000000000489 <dup>:
SYSCALL(dup)
 489:	b8 0a 00 00 00       	mov    $0xa,%eax
 48e:	cd 40                	int    $0x40
 490:	c3                   	ret

0000000000000491 <getpid>:
SYSCALL(getpid)
 491:	b8 0b 00 00 00       	mov    $0xb,%eax
 496:	cd 40                	int    $0x40
 498:	c3                   	ret

0000000000000499 <sbrk>:
SYSCALL(sbrk)
 499:	b8 0c 00 00 00       	mov    $0xc,%eax
 49e:	cd 40                	int    $0x40
 4a0:	c3                   	ret

00000000000004a1 <sleep>:
SYSCALL(sleep)
 4a1:	b8 0d 00 00 00       	mov    $0xd,%eax
 4a6:	cd 40                	int    $0x40
 4a8:	c3                   	ret

00000000000004a9 <uptime>:
SYSCALL(uptime)
 4a9:	b8 0e 00 00 00       	mov    $0xe,%eax
 4ae:	cd 40                	int    $0x40
 4b0:	c3                   	ret

00000000000004b1 <getpinfo>:
SYSCALL(getpinfo)
 4b1:	b8 18 00 00 00       	mov    $0x18,%eax
 4b6:	cd 40                	int    $0x40
 4b8:	c3                   	ret

00000000000004b9 <getfavnum>:
SYSCALL(getfavnum)
 4b9:	b8 19 00 00 00       	mov    $0x19,%eax
 4be:	cd 40                	int    $0x40
 4c0:	c3                   	ret

00000000000004c1 <shutdown>:
SYSCALL(shutdown)
 4c1:	b8 1a 00 00 00       	mov    $0x1a,%eax
 4c6:	cd 40                	int    $0x40
 4c8:	c3                   	ret

00000000000004c9 <getcount>:
SYSCALL(getcount)
 4c9:	b8 1b 00 00 00       	mov    $0x1b,%eax
 4ce:	cd 40                	int    $0x40
 4d0:	c3                   	ret

00000000000004d1 <killrandom>:
 4d1:	b8 1c 00 00 00       	mov    $0x1c,%eax
 4d6:	cd 40                	int    $0x40
 4d8:	c3                   	ret

00000000000004d9 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 4d9:	55                   	push   %rbp
 4da:	48 89 e5             	mov    %rsp,%rbp
 4dd:	48 83 ec 10          	sub    $0x10,%rsp
 4e1:	89 7d fc             	mov    %edi,-0x4(%rbp)
 4e4:	89 f0                	mov    %esi,%eax
 4e6:	88 45 f8             	mov    %al,-0x8(%rbp)
  write(fd, &c, 1);
 4e9:	48 8d 4d f8          	lea    -0x8(%rbp),%rcx
 4ed:	8b 45 fc             	mov    -0x4(%rbp),%eax
 4f0:	ba 01 00 00 00       	mov    $0x1,%edx
 4f5:	48 89 ce             	mov    %rcx,%rsi
 4f8:	89 c7                	mov    %eax,%edi
 4fa:	e8 32 ff ff ff       	call   431 <write>
}
 4ff:	90                   	nop
 500:	c9                   	leave
 501:	c3                   	ret

0000000000000502 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 502:	55                   	push   %rbp
 503:	48 89 e5             	mov    %rsp,%rbp
 506:	48 83 ec 30          	sub    $0x30,%rsp
 50a:	89 7d dc             	mov    %edi,-0x24(%rbp)
 50d:	89 75 d8             	mov    %esi,-0x28(%rbp)
 510:	89 55 d4             	mov    %edx,-0x2c(%rbp)
 513:	89 4d d0             	mov    %ecx,-0x30(%rbp)
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 516:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
  if(sgn && xx < 0){
 51d:	83 7d d0 00          	cmpl   $0x0,-0x30(%rbp)
 521:	74 17                	je     53a <printint+0x38>
 523:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
 527:	79 11                	jns    53a <printint+0x38>
    neg = 1;
 529:	c7 45 f8 01 00 00 00 	movl   $0x1,-0x8(%rbp)
    x = -xx;
 530:	8b 45 d8             	mov    -0x28(%rbp),%eax
 533:	f7 d8                	neg    %eax
 535:	89 45 f4             	mov    %eax,-0xc(%rbp)
 538:	eb 06                	jmp    540 <printint+0x3e>
  } else {
    x = xx;
 53a:	8b 45 d8             	mov    -0x28(%rbp),%eax
 53d:	89 45 f4             	mov    %eax,-0xc(%rbp)
  }

  i = 0;
 540:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  do{
    buf[i++] = digits[x % base];
 547:	8b 4d d4             	mov    -0x2c(%rbp),%ecx
 54a:	8b 45 f4             	mov    -0xc(%rbp),%eax
 54d:	ba 00 00 00 00       	mov    $0x0,%edx
 552:	f7 f1                	div    %ecx
 554:	89 d1                	mov    %edx,%ecx
 556:	8b 45 fc             	mov    -0x4(%rbp),%eax
 559:	8d 50 01             	lea    0x1(%rax),%edx
 55c:	89 55 fc             	mov    %edx,-0x4(%rbp)
 55f:	89 ca                	mov    %ecx,%edx
 561:	0f b6 92 e0 10 00 00 	movzbl 0x10e0(%rdx),%edx
 568:	48 98                	cltq
 56a:	88 54 05 e0          	mov    %dl,-0x20(%rbp,%rax,1)
  }while((x /= base) != 0);
 56e:	8b 75 d4             	mov    -0x2c(%rbp),%esi
 571:	8b 45 f4             	mov    -0xc(%rbp),%eax
 574:	ba 00 00 00 00       	mov    $0x0,%edx
 579:	f7 f6                	div    %esi
 57b:	89 45 f4             	mov    %eax,-0xc(%rbp)
 57e:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
 582:	75 c3                	jne    547 <printint+0x45>
  if(neg)
 584:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
 588:	74 2b                	je     5b5 <printint+0xb3>
    buf[i++] = '-';
 58a:	8b 45 fc             	mov    -0x4(%rbp),%eax
 58d:	8d 50 01             	lea    0x1(%rax),%edx
 590:	89 55 fc             	mov    %edx,-0x4(%rbp)
 593:	48 98                	cltq
 595:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%rbp,%rax,1)

  while(--i >= 0)
 59a:	eb 19                	jmp    5b5 <printint+0xb3>
    putc(fd, buf[i]);
 59c:	8b 45 fc             	mov    -0x4(%rbp),%eax
 59f:	48 98                	cltq
 5a1:	0f b6 44 05 e0       	movzbl -0x20(%rbp,%rax,1),%eax
 5a6:	0f be d0             	movsbl %al,%edx
 5a9:	8b 45 dc             	mov    -0x24(%rbp),%eax
 5ac:	89 d6                	mov    %edx,%esi
 5ae:	89 c7                	mov    %eax,%edi
 5b0:	e8 24 ff ff ff       	call   4d9 <putc>
  while(--i >= 0)
 5b5:	83 6d fc 01          	subl   $0x1,-0x4(%rbp)
 5b9:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
 5bd:	79 dd                	jns    59c <printint+0x9a>
}
 5bf:	90                   	nop
 5c0:	90                   	nop
 5c1:	c9                   	leave
 5c2:	c3                   	ret

00000000000005c3 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 5c3:	55                   	push   %rbp
 5c4:	48 89 e5             	mov    %rsp,%rbp
 5c7:	48 81 ec f0 00 00 00 	sub    $0xf0,%rsp
 5ce:	89 bd 1c ff ff ff    	mov    %edi,-0xe4(%rbp)
 5d4:	48 89 b5 10 ff ff ff 	mov    %rsi,-0xf0(%rbp)
 5db:	48 89 95 60 ff ff ff 	mov    %rdx,-0xa0(%rbp)
 5e2:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
 5e9:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
 5f0:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
 5f7:	84 c0                	test   %al,%al
 5f9:	74 20                	je     61b <printf+0x58>
 5fb:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
 5ff:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
 603:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
 607:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
 60b:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
 60f:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
 613:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
 617:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  va_list ap;
  char *s;
  int c, i, state;
  va_start(ap, fmt);
 61b:	c7 85 20 ff ff ff 10 	movl   $0x10,-0xe0(%rbp)
 622:	00 00 00 
 625:	c7 85 24 ff ff ff 30 	movl   $0x30,-0xdc(%rbp)
 62c:	00 00 00 
 62f:	48 8d 45 10          	lea    0x10(%rbp),%rax
 633:	48 89 85 28 ff ff ff 	mov    %rax,-0xd8(%rbp)
 63a:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
 641:	48 89 85 30 ff ff ff 	mov    %rax,-0xd0(%rbp)

  state = 0;
 648:	c7 85 40 ff ff ff 00 	movl   $0x0,-0xc0(%rbp)
 64f:	00 00 00 
  for(i = 0; fmt[i]; i++){
 652:	c7 85 44 ff ff ff 00 	movl   $0x0,-0xbc(%rbp)
 659:	00 00 00 
 65c:	e9 a8 02 00 00       	jmp    909 <printf+0x346>
    c = fmt[i] & 0xff;
 661:	8b 85 44 ff ff ff    	mov    -0xbc(%rbp),%eax
 667:	48 63 d0             	movslq %eax,%rdx
 66a:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
 671:	48 01 d0             	add    %rdx,%rax
 674:	0f b6 00             	movzbl (%rax),%eax
 677:	0f be c0             	movsbl %al,%eax
 67a:	25 ff 00 00 00       	and    $0xff,%eax
 67f:	89 85 3c ff ff ff    	mov    %eax,-0xc4(%rbp)
    if(state == 0){
 685:	83 bd 40 ff ff ff 00 	cmpl   $0x0,-0xc0(%rbp)
 68c:	75 35                	jne    6c3 <printf+0x100>
      if(c == '%'){
 68e:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
 695:	75 0f                	jne    6a6 <printf+0xe3>
        state = '%';
 697:	c7 85 40 ff ff ff 25 	movl   $0x25,-0xc0(%rbp)
 69e:	00 00 00 
 6a1:	e9 5c 02 00 00       	jmp    902 <printf+0x33f>
      } else {
        putc(fd, c);
 6a6:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
 6ac:	0f be d0             	movsbl %al,%edx
 6af:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 6b5:	89 d6                	mov    %edx,%esi
 6b7:	89 c7                	mov    %eax,%edi
 6b9:	e8 1b fe ff ff       	call   4d9 <putc>
 6be:	e9 3f 02 00 00       	jmp    902 <printf+0x33f>
      }
    } else if(state == '%'){
 6c3:	83 bd 40 ff ff ff 25 	cmpl   $0x25,-0xc0(%rbp)
 6ca:	0f 85 32 02 00 00    	jne    902 <printf+0x33f>
      if(c == 'd'){
 6d0:	83 bd 3c ff ff ff 64 	cmpl   $0x64,-0xc4(%rbp)
 6d7:	75 5e                	jne    737 <printf+0x174>
        printint(fd, va_arg(ap, int), 10, 1);
 6d9:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 6df:	83 f8 2f             	cmp    $0x2f,%eax
 6e2:	77 23                	ja     707 <printf+0x144>
 6e4:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 6eb:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 6f1:	89 d2                	mov    %edx,%edx
 6f3:	48 01 d0             	add    %rdx,%rax
 6f6:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 6fc:	83 c2 08             	add    $0x8,%edx
 6ff:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 705:	eb 12                	jmp    719 <printf+0x156>
 707:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 70e:	48 8d 50 08          	lea    0x8(%rax),%rdx
 712:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 719:	8b 30                	mov    (%rax),%esi
 71b:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 721:	b9 01 00 00 00       	mov    $0x1,%ecx
 726:	ba 0a 00 00 00       	mov    $0xa,%edx
 72b:	89 c7                	mov    %eax,%edi
 72d:	e8 d0 fd ff ff       	call   502 <printint>
 732:	e9 c1 01 00 00       	jmp    8f8 <printf+0x335>
      } else if(c == 'x' || c == 'p'){
 737:	83 bd 3c ff ff ff 78 	cmpl   $0x78,-0xc4(%rbp)
 73e:	74 09                	je     749 <printf+0x186>
 740:	83 bd 3c ff ff ff 70 	cmpl   $0x70,-0xc4(%rbp)
 747:	75 5e                	jne    7a7 <printf+0x1e4>
        printint(fd, va_arg(ap, int), 16, 0);
 749:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 74f:	83 f8 2f             	cmp    $0x2f,%eax
 752:	77 23                	ja     777 <printf+0x1b4>
 754:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 75b:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 761:	89 d2                	mov    %edx,%edx
 763:	48 01 d0             	add    %rdx,%rax
 766:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 76c:	83 c2 08             	add    $0x8,%edx
 76f:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 775:	eb 12                	jmp    789 <printf+0x1c6>
 777:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 77e:	48 8d 50 08          	lea    0x8(%rax),%rdx
 782:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 789:	8b 30                	mov    (%rax),%esi
 78b:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 791:	b9 00 00 00 00       	mov    $0x0,%ecx
 796:	ba 10 00 00 00       	mov    $0x10,%edx
 79b:	89 c7                	mov    %eax,%edi
 79d:	e8 60 fd ff ff       	call   502 <printint>
 7a2:	e9 51 01 00 00       	jmp    8f8 <printf+0x335>
      } else if(c == 's'){
 7a7:	83 bd 3c ff ff ff 73 	cmpl   $0x73,-0xc4(%rbp)
 7ae:	0f 85 98 00 00 00    	jne    84c <printf+0x289>
        s = va_arg(ap, char*);
 7b4:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 7ba:	83 f8 2f             	cmp    $0x2f,%eax
 7bd:	77 23                	ja     7e2 <printf+0x21f>
 7bf:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 7c6:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 7cc:	89 d2                	mov    %edx,%edx
 7ce:	48 01 d0             	add    %rdx,%rax
 7d1:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 7d7:	83 c2 08             	add    $0x8,%edx
 7da:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 7e0:	eb 12                	jmp    7f4 <printf+0x231>
 7e2:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 7e9:	48 8d 50 08          	lea    0x8(%rax),%rdx
 7ed:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 7f4:	48 8b 00             	mov    (%rax),%rax
 7f7:	48 89 85 48 ff ff ff 	mov    %rax,-0xb8(%rbp)
        if(s == 0)
 7fe:	48 83 bd 48 ff ff ff 	cmpq   $0x0,-0xb8(%rbp)
 805:	00 
 806:	75 31                	jne    839 <printf+0x276>
          s = "(null)";
 808:	48 c7 85 48 ff ff ff 	movq   $0xddb,-0xb8(%rbp)
 80f:	db 0d 00 00 
        while(*s != 0){
 813:	eb 24                	jmp    839 <printf+0x276>
          putc(fd, *s);
 815:	48 8b 85 48 ff ff ff 	mov    -0xb8(%rbp),%rax
 81c:	0f b6 00             	movzbl (%rax),%eax
 81f:	0f be d0             	movsbl %al,%edx
 822:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 828:	89 d6                	mov    %edx,%esi
 82a:	89 c7                	mov    %eax,%edi
 82c:	e8 a8 fc ff ff       	call   4d9 <putc>
          s++;
 831:	48 83 85 48 ff ff ff 	addq   $0x1,-0xb8(%rbp)
 838:	01 
        while(*s != 0){
 839:	48 8b 85 48 ff ff ff 	mov    -0xb8(%rbp),%rax
 840:	0f b6 00             	movzbl (%rax),%eax
 843:	84 c0                	test   %al,%al
 845:	75 ce                	jne    815 <printf+0x252>
 847:	e9 ac 00 00 00       	jmp    8f8 <printf+0x335>
        }
      } else if(c == 'c'){
 84c:	83 bd 3c ff ff ff 63 	cmpl   $0x63,-0xc4(%rbp)
 853:	75 56                	jne    8ab <printf+0x2e8>
        putc(fd, va_arg(ap, uint));
 855:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 85b:	83 f8 2f             	cmp    $0x2f,%eax
 85e:	77 23                	ja     883 <printf+0x2c0>
 860:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 867:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 86d:	89 d2                	mov    %edx,%edx
 86f:	48 01 d0             	add    %rdx,%rax
 872:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 878:	83 c2 08             	add    $0x8,%edx
 87b:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 881:	eb 12                	jmp    895 <printf+0x2d2>
 883:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 88a:	48 8d 50 08          	lea    0x8(%rax),%rdx
 88e:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 895:	8b 00                	mov    (%rax),%eax
 897:	0f be d0             	movsbl %al,%edx
 89a:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 8a0:	89 d6                	mov    %edx,%esi
 8a2:	89 c7                	mov    %eax,%edi
 8a4:	e8 30 fc ff ff       	call   4d9 <putc>
 8a9:	eb 4d                	jmp    8f8 <printf+0x335>
      } else if(c == '%'){
 8ab:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
 8b2:	75 1a                	jne    8ce <printf+0x30b>
        putc(fd, c);
 8b4:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
 8ba:	0f be d0             	movsbl %al,%edx
 8bd:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 8c3:	89 d6                	mov    %edx,%esi
 8c5:	89 c7                	mov    %eax,%edi
 8c7:	e8 0d fc ff ff       	call   4d9 <putc>
 8cc:	eb 2a                	jmp    8f8 <printf+0x335>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 8ce:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 8d4:	be 25 00 00 00       	mov    $0x25,%esi
 8d9:	89 c7                	mov    %eax,%edi
 8db:	e8 f9 fb ff ff       	call   4d9 <putc>
        putc(fd, c);
 8e0:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
 8e6:	0f be d0             	movsbl %al,%edx
 8e9:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 8ef:	89 d6                	mov    %edx,%esi
 8f1:	89 c7                	mov    %eax,%edi
 8f3:	e8 e1 fb ff ff       	call   4d9 <putc>
      }
      state = 0;
 8f8:	c7 85 40 ff ff ff 00 	movl   $0x0,-0xc0(%rbp)
 8ff:	00 00 00 
  for(i = 0; fmt[i]; i++){
 902:	83 85 44 ff ff ff 01 	addl   $0x1,-0xbc(%rbp)
 909:	8b 85 44 ff ff ff    	mov    -0xbc(%rbp),%eax
 90f:	48 63 d0             	movslq %eax,%rdx
 912:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
 919:	48 01 d0             	add    %rdx,%rax
 91c:	0f b6 00             	movzbl (%rax),%eax
 91f:	84 c0                	test   %al,%al
 921:	0f 85 3a fd ff ff    	jne    661 <printf+0x9e>
    }
  }
}
 927:	90                   	nop
 928:	90                   	nop
 929:	c9                   	leave
 92a:	c3                   	ret

000000000000092b <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 92b:	55                   	push   %rbp
 92c:	48 89 e5             	mov    %rsp,%rbp
 92f:	48 83 ec 18          	sub    $0x18,%rsp
 933:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  Header *bp, *p;

  bp = (Header*)ap - 1;
 937:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 93b:	48 83 e8 10          	sub    $0x10,%rax
 93f:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 943:	48 8b 05 c6 09 00 00 	mov    0x9c6(%rip),%rax        # 1310 <freep>
 94a:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 94e:	eb 2f                	jmp    97f <free+0x54>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 950:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 954:	48 8b 00             	mov    (%rax),%rax
 957:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 95b:	72 17                	jb     974 <free+0x49>
 95d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 961:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 965:	72 2f                	jb     996 <free+0x6b>
 967:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 96b:	48 8b 00             	mov    (%rax),%rax
 96e:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
 972:	72 22                	jb     996 <free+0x6b>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 974:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 978:	48 8b 00             	mov    (%rax),%rax
 97b:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 97f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 983:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 987:	73 c7                	jae    950 <free+0x25>
 989:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 98d:	48 8b 00             	mov    (%rax),%rax
 990:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
 994:	73 ba                	jae    950 <free+0x25>
      break;
  if(bp + bp->s.size == p->s.ptr){
 996:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 99a:	8b 40 08             	mov    0x8(%rax),%eax
 99d:	89 c0                	mov    %eax,%eax
 99f:	48 c1 e0 04          	shl    $0x4,%rax
 9a3:	48 89 c2             	mov    %rax,%rdx
 9a6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 9aa:	48 01 c2             	add    %rax,%rdx
 9ad:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 9b1:	48 8b 00             	mov    (%rax),%rax
 9b4:	48 39 c2             	cmp    %rax,%rdx
 9b7:	75 2d                	jne    9e6 <free+0xbb>
    bp->s.size += p->s.ptr->s.size;
 9b9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 9bd:	8b 50 08             	mov    0x8(%rax),%edx
 9c0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 9c4:	48 8b 00             	mov    (%rax),%rax
 9c7:	8b 40 08             	mov    0x8(%rax),%eax
 9ca:	01 c2                	add    %eax,%edx
 9cc:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 9d0:	89 50 08             	mov    %edx,0x8(%rax)
    bp->s.ptr = p->s.ptr->s.ptr;
 9d3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 9d7:	48 8b 00             	mov    (%rax),%rax
 9da:	48 8b 10             	mov    (%rax),%rdx
 9dd:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 9e1:	48 89 10             	mov    %rdx,(%rax)
 9e4:	eb 0e                	jmp    9f4 <free+0xc9>
  } else
    bp->s.ptr = p->s.ptr;
 9e6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 9ea:	48 8b 10             	mov    (%rax),%rdx
 9ed:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 9f1:	48 89 10             	mov    %rdx,(%rax)
  if(p + p->s.size == bp){
 9f4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 9f8:	8b 40 08             	mov    0x8(%rax),%eax
 9fb:	89 c0                	mov    %eax,%eax
 9fd:	48 c1 e0 04          	shl    $0x4,%rax
 a01:	48 89 c2             	mov    %rax,%rdx
 a04:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a08:	48 01 d0             	add    %rdx,%rax
 a0b:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
 a0f:	75 27                	jne    a38 <free+0x10d>
    p->s.size += bp->s.size;
 a11:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a15:	8b 50 08             	mov    0x8(%rax),%edx
 a18:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 a1c:	8b 40 08             	mov    0x8(%rax),%eax
 a1f:	01 c2                	add    %eax,%edx
 a21:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a25:	89 50 08             	mov    %edx,0x8(%rax)
    p->s.ptr = bp->s.ptr;
 a28:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 a2c:	48 8b 10             	mov    (%rax),%rdx
 a2f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a33:	48 89 10             	mov    %rdx,(%rax)
 a36:	eb 0b                	jmp    a43 <free+0x118>
  } else
    p->s.ptr = bp;
 a38:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a3c:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
 a40:	48 89 10             	mov    %rdx,(%rax)
  freep = p;
 a43:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a47:	48 89 05 c2 08 00 00 	mov    %rax,0x8c2(%rip)        # 1310 <freep>
}
 a4e:	90                   	nop
 a4f:	c9                   	leave
 a50:	c3                   	ret

0000000000000a51 <morecore>:

static Header*
morecore(uint nu)
{
 a51:	55                   	push   %rbp
 a52:	48 89 e5             	mov    %rsp,%rbp
 a55:	48 83 ec 20          	sub    $0x20,%rsp
 a59:	89 7d ec             	mov    %edi,-0x14(%rbp)
  char *p;
  Header *hp;

  if(nu < 4096)
 a5c:	81 7d ec ff 0f 00 00 	cmpl   $0xfff,-0x14(%rbp)
 a63:	77 07                	ja     a6c <morecore+0x1b>
    nu = 4096;
 a65:	c7 45 ec 00 10 00 00 	movl   $0x1000,-0x14(%rbp)
  p = sbrk(nu * sizeof(Header));
 a6c:	8b 45 ec             	mov    -0x14(%rbp),%eax
 a6f:	c1 e0 04             	shl    $0x4,%eax
 a72:	89 c7                	mov    %eax,%edi
 a74:	e8 20 fa ff ff       	call   499 <sbrk>
 a79:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  if(p == (char*)-1)
 a7d:	48 83 7d f8 ff       	cmpq   $0xffffffffffffffff,-0x8(%rbp)
 a82:	75 07                	jne    a8b <morecore+0x3a>
    return 0;
 a84:	b8 00 00 00 00       	mov    $0x0,%eax
 a89:	eb 29                	jmp    ab4 <morecore+0x63>
  hp = (Header*)p;
 a8b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a8f:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  hp->s.size = nu;
 a93:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 a97:	8b 55 ec             	mov    -0x14(%rbp),%edx
 a9a:	89 50 08             	mov    %edx,0x8(%rax)
  free((void*)(hp + 1));
 a9d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 aa1:	48 83 c0 10          	add    $0x10,%rax
 aa5:	48 89 c7             	mov    %rax,%rdi
 aa8:	e8 7e fe ff ff       	call   92b <free>
  return freep;
 aad:	48 8b 05 5c 08 00 00 	mov    0x85c(%rip),%rax        # 1310 <freep>
}
 ab4:	c9                   	leave
 ab5:	c3                   	ret

0000000000000ab6 <malloc>:

void*
malloc(uint nbytes)
{
 ab6:	55                   	push   %rbp
 ab7:	48 89 e5             	mov    %rsp,%rbp
 aba:	48 83 ec 30          	sub    $0x30,%rsp
 abe:	89 7d dc             	mov    %edi,-0x24(%rbp)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 ac1:	8b 45 dc             	mov    -0x24(%rbp),%eax
 ac4:	48 83 c0 0f          	add    $0xf,%rax
 ac8:	48 c1 e8 04          	shr    $0x4,%rax
 acc:	83 c0 01             	add    $0x1,%eax
 acf:	89 45 ec             	mov    %eax,-0x14(%rbp)
  if((prevp = freep) == 0){
 ad2:	48 8b 05 37 08 00 00 	mov    0x837(%rip),%rax        # 1310 <freep>
 ad9:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
 add:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
 ae2:	75 2b                	jne    b0f <malloc+0x59>
    base.s.ptr = freep = prevp = &base;
 ae4:	48 c7 45 f0 00 13 00 	movq   $0x1300,-0x10(%rbp)
 aeb:	00 
 aec:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 af0:	48 89 05 19 08 00 00 	mov    %rax,0x819(%rip)        # 1310 <freep>
 af7:	48 8b 05 12 08 00 00 	mov    0x812(%rip),%rax        # 1310 <freep>
 afe:	48 89 05 fb 07 00 00 	mov    %rax,0x7fb(%rip)        # 1300 <base>
    base.s.size = 0;
 b05:	c7 05 f9 07 00 00 00 	movl   $0x0,0x7f9(%rip)        # 1308 <base+0x8>
 b0c:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 b0f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 b13:	48 8b 00             	mov    (%rax),%rax
 b16:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
 b1a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b1e:	8b 40 08             	mov    0x8(%rax),%eax
 b21:	3b 45 ec             	cmp    -0x14(%rbp),%eax
 b24:	72 5f                	jb     b85 <malloc+0xcf>
      if(p->s.size == nunits)
 b26:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b2a:	8b 40 08             	mov    0x8(%rax),%eax
 b2d:	39 45 ec             	cmp    %eax,-0x14(%rbp)
 b30:	75 10                	jne    b42 <malloc+0x8c>
        prevp->s.ptr = p->s.ptr;
 b32:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b36:	48 8b 10             	mov    (%rax),%rdx
 b39:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 b3d:	48 89 10             	mov    %rdx,(%rax)
 b40:	eb 2e                	jmp    b70 <malloc+0xba>
      else {
        p->s.size -= nunits;
 b42:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b46:	8b 40 08             	mov    0x8(%rax),%eax
 b49:	2b 45 ec             	sub    -0x14(%rbp),%eax
 b4c:	89 c2                	mov    %eax,%edx
 b4e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b52:	89 50 08             	mov    %edx,0x8(%rax)
        p += p->s.size;
 b55:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b59:	8b 40 08             	mov    0x8(%rax),%eax
 b5c:	89 c0                	mov    %eax,%eax
 b5e:	48 c1 e0 04          	shl    $0x4,%rax
 b62:	48 01 45 f8          	add    %rax,-0x8(%rbp)
        p->s.size = nunits;
 b66:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b6a:	8b 55 ec             	mov    -0x14(%rbp),%edx
 b6d:	89 50 08             	mov    %edx,0x8(%rax)
      }
      freep = prevp;
 b70:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 b74:	48 89 05 95 07 00 00 	mov    %rax,0x795(%rip)        # 1310 <freep>
      return (void*)(p + 1);
 b7b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b7f:	48 83 c0 10          	add    $0x10,%rax
 b83:	eb 41                	jmp    bc6 <malloc+0x110>
    }
    if(p == freep)
 b85:	48 8b 05 84 07 00 00 	mov    0x784(%rip),%rax        # 1310 <freep>
 b8c:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 b90:	75 1c                	jne    bae <malloc+0xf8>
      if((p = morecore(nunits)) == 0)
 b92:	8b 45 ec             	mov    -0x14(%rbp),%eax
 b95:	89 c7                	mov    %eax,%edi
 b97:	e8 b5 fe ff ff       	call   a51 <morecore>
 b9c:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 ba0:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
 ba5:	75 07                	jne    bae <malloc+0xf8>
        return 0;
 ba7:	b8 00 00 00 00       	mov    $0x0,%eax
 bac:	eb 18                	jmp    bc6 <malloc+0x110>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 bae:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 bb2:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
 bb6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 bba:	48 8b 00             	mov    (%rax),%rax
 bbd:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
 bc1:	e9 54 ff ff ff       	jmp    b1a <malloc+0x64>
  }
}
 bc6:	c9                   	leave
 bc7:	c3                   	ret

0000000000000bc8 <createRoot>:
#include "set.h"
#include "user.h"

//TODO: Να μην είναι περιορισμένο σε int

Set* createRoot(){
 bc8:	55                   	push   %rbp
 bc9:	48 89 e5             	mov    %rsp,%rbp
 bcc:	48 83 ec 10          	sub    $0x10,%rsp
    //Αρχικοποίηση του Set
    Set *set = malloc(sizeof(Set));
 bd0:	bf 10 00 00 00       	mov    $0x10,%edi
 bd5:	e8 dc fe ff ff       	call   ab6 <malloc>
 bda:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    set->size = 0;
 bde:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 be2:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%rax)
    set->root = NULL;
 be9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 bed:	48 c7 00 00 00 00 00 	movq   $0x0,(%rax)
    return set;
 bf4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
 bf8:	c9                   	leave
 bf9:	c3                   	ret

0000000000000bfa <createNode>:

void createNode(int i, Set *set){
 bfa:	55                   	push   %rbp
 bfb:	48 89 e5             	mov    %rsp,%rbp
 bfe:	48 83 ec 20          	sub    $0x20,%rsp
 c02:	89 7d ec             	mov    %edi,-0x14(%rbp)
 c05:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    Η συνάρτηση αυτή δημιουργεί ένα νέο SetNode με την τιμή i και εφόσον δεν υπάρχει στο Set το προσθέτει στο τέλος του συνόλου.
    Σημείωση: Ίσως υπάρχει καλύτερος τρόπος για την υλοποίηση.
    */

    //Αρχικοποίηση του SetNode
    SetNode *temp = malloc(sizeof(SetNode));
 c09:	bf 10 00 00 00       	mov    $0x10,%edi
 c0e:	e8 a3 fe ff ff       	call   ab6 <malloc>
 c13:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    temp->i = i;
 c17:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 c1b:	8b 55 ec             	mov    -0x14(%rbp),%edx
 c1e:	89 10                	mov    %edx,(%rax)
    temp->next = NULL;
 c20:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 c24:	48 c7 40 08 00 00 00 	movq   $0x0,0x8(%rax)
 c2b:	00 

    //Έλεγχος ύπαρξης του i
    SetNode *curr = set->root;//Ξεκινάει από την root
 c2c:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
 c30:	48 8b 00             	mov    (%rax),%rax
 c33:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(curr != NULL) { //Εφόσον το Set δεν είναι άδειο
 c37:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
 c3c:	74 34                	je     c72 <createNode+0x78>
        while (curr->next != NULL){ //Εφόσον υπάρχει επόμενο node
 c3e:	eb 25                	jmp    c65 <createNode+0x6b>
            if (curr->i == i){ //Αν το i υπάρχει στο σύνολο
 c40:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 c44:	8b 00                	mov    (%rax),%eax
 c46:	39 45 ec             	cmp    %eax,-0x14(%rbp)
 c49:	75 0e                	jne    c59 <createNode+0x5f>
                free(temp); 
 c4b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 c4f:	48 89 c7             	mov    %rax,%rdi
 c52:	e8 d4 fc ff ff       	call   92b <free>
                return; //Δεν εκτελούμε την υπόλοιπη συνάρτηση
 c57:	eb 4e                	jmp    ca7 <createNode+0xad>
            }
            curr = curr->next; //Επόμενο SetNode
 c59:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 c5d:	48 8b 40 08          	mov    0x8(%rax),%rax
 c61:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
        while (curr->next != NULL){ //Εφόσον υπάρχει επόμενο node
 c65:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 c69:	48 8b 40 08          	mov    0x8(%rax),%rax
 c6d:	48 85 c0             	test   %rax,%rax
 c70:	75 ce                	jne    c40 <createNode+0x46>
        }
    }
    /*
    Ο έλεγχος στην if είναι απαραίτητος για να ελεγχθεί το τελευταίο SetNode.
    */
    if (curr->i != i) attachNode(set, curr, temp); 
 c72:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 c76:	8b 00                	mov    (%rax),%eax
 c78:	39 45 ec             	cmp    %eax,-0x14(%rbp)
 c7b:	74 1e                	je     c9b <createNode+0xa1>
 c7d:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
 c81:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
 c85:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
 c89:	48 89 ce             	mov    %rcx,%rsi
 c8c:	48 89 c7             	mov    %rax,%rdi
 c8f:	b8 00 00 00 00       	mov    $0x0,%eax
 c94:	e8 10 00 00 00       	call   ca9 <attachNode>
 c99:	eb 0c                	jmp    ca7 <createNode+0xad>
    else free(temp);
 c9b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 c9f:	48 89 c7             	mov    %rax,%rdi
 ca2:	e8 84 fc ff ff       	call   92b <free>
}
 ca7:	c9                   	leave
 ca8:	c3                   	ret

0000000000000ca9 <attachNode>:

void attachNode(Set *set, SetNode *curr, SetNode *temp){
 ca9:	55                   	push   %rbp
 caa:	48 89 e5             	mov    %rsp,%rbp
 cad:	48 83 ec 18          	sub    $0x18,%rsp
 cb1:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
 cb5:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
 cb9:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
    //Βάζουμε το temp στο τέλος του Set
    if(set->size == 0) set->root = temp;
 cbd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 cc1:	8b 40 08             	mov    0x8(%rax),%eax
 cc4:	85 c0                	test   %eax,%eax
 cc6:	75 0d                	jne    cd5 <attachNode+0x2c>
 cc8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 ccc:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
 cd0:	48 89 10             	mov    %rdx,(%rax)
 cd3:	eb 0c                	jmp    ce1 <attachNode+0x38>
    else curr->next = temp;
 cd5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 cd9:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
 cdd:	48 89 50 08          	mov    %rdx,0x8(%rax)
    set->size += 1;
 ce1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 ce5:	8b 40 08             	mov    0x8(%rax),%eax
 ce8:	8d 50 01             	lea    0x1(%rax),%edx
 ceb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 cef:	89 50 08             	mov    %edx,0x8(%rax)
}
 cf2:	90                   	nop
 cf3:	c9                   	leave
 cf4:	c3                   	ret

0000000000000cf5 <deleteSet>:

void deleteSet(Set *set){
 cf5:	55                   	push   %rbp
 cf6:	48 89 e5             	mov    %rsp,%rbp
 cf9:	48 83 ec 20          	sub    $0x20,%rsp
 cfd:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    if (set == NULL) return; //Αν ο χρήστης είναι ΜΛΚ!
 d01:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
 d06:	74 42                	je     d4a <deleteSet+0x55>
    SetNode *temp;
    SetNode *curr = set->root; //Ξεκινάμε από το root
 d08:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 d0c:	48 8b 00             	mov    (%rax),%rax
 d0f:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    while (curr != NULL){ 
 d13:	eb 20                	jmp    d35 <deleteSet+0x40>
        temp = curr->next; //Αναφορά στο επόμενο SetNode
 d15:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 d19:	48 8b 40 08          	mov    0x8(%rax),%rax
 d1d:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
        free(curr); //Απελευθέρωση της curr
 d21:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 d25:	48 89 c7             	mov    %rax,%rdi
 d28:	e8 fe fb ff ff       	call   92b <free>
        curr = temp;
 d2d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 d31:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    while (curr != NULL){ 
 d35:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
 d3a:	75 d9                	jne    d15 <deleteSet+0x20>
    }
    free(set); //Διαγραφή του Set
 d3c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 d40:	48 89 c7             	mov    %rax,%rdi
 d43:	e8 e3 fb ff ff       	call   92b <free>
 d48:	eb 01                	jmp    d4b <deleteSet+0x56>
    if (set == NULL) return; //Αν ο χρήστης είναι ΜΛΚ!
 d4a:	90                   	nop
}
 d4b:	c9                   	leave
 d4c:	c3                   	ret

0000000000000d4d <getNodeAtPosition>:

SetNode* getNodeAtPosition(Set *set, int i){
 d4d:	55                   	push   %rbp
 d4e:	48 89 e5             	mov    %rsp,%rbp
 d51:	48 83 ec 20          	sub    $0x20,%rsp
 d55:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
 d59:	89 75 e4             	mov    %esi,-0x1c(%rbp)
    if (set == NULL || set->root == NULL) return NULL; //Αν ο χρήστης είναι ΜΛΚ!
 d5c:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
 d61:	74 0c                	je     d6f <getNodeAtPosition+0x22>
 d63:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 d67:	48 8b 00             	mov    (%rax),%rax
 d6a:	48 85 c0             	test   %rax,%rax
 d6d:	75 07                	jne    d76 <getNodeAtPosition+0x29>
 d6f:	b8 00 00 00 00       	mov    $0x0,%eax
 d74:	eb 3d                	jmp    db3 <getNodeAtPosition+0x66>

    SetNode *curr = set->root;
 d76:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 d7a:	48 8b 00             	mov    (%rax),%rax
 d7d:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    int n;

    for(n = 0; n<i && curr->next != NULL; n++) curr = curr->next; //Ο έλεγχος εδω είναι: n<i && curr->next != NULL
 d81:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
 d88:	eb 10                	jmp    d9a <getNodeAtPosition+0x4d>
 d8a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 d8e:	48 8b 40 08          	mov    0x8(%rax),%rax
 d92:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 d96:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
 d9a:	8b 45 f4             	mov    -0xc(%rbp),%eax
 d9d:	3b 45 e4             	cmp    -0x1c(%rbp),%eax
 da0:	7d 0d                	jge    daf <getNodeAtPosition+0x62>
 da2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 da6:	48 8b 40 08          	mov    0x8(%rax),%rax
 daa:	48 85 c0             	test   %rax,%rax
 dad:	75 db                	jne    d8a <getNodeAtPosition+0x3d>
    return curr;
 daf:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 db3:	c9                   	leave
 db4:	c3                   	ret
