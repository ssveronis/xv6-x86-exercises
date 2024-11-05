
fs/wc:     file format elf64-x86-64


Disassembly of section .text:

0000000000000000 <wc>:

char buf[512];

void
wc(int fd, char *name)
{
   0:	55                   	push   %rbp
   1:	48 89 e5             	mov    %rsp,%rbp
   4:	48 83 ec 30          	sub    $0x30,%rsp
   8:	89 7d dc             	mov    %edi,-0x24(%rbp)
   b:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  int i, n;
  int l, w, c, inword;

  l = w = c = 0;
   f:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%rbp)
  16:	8b 45 f0             	mov    -0x10(%rbp),%eax
  19:	89 45 f4             	mov    %eax,-0xc(%rbp)
  1c:	8b 45 f4             	mov    -0xc(%rbp),%eax
  1f:	89 45 f8             	mov    %eax,-0x8(%rbp)
  inword = 0;
  22:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
  while((n = read(fd, buf, sizeof(buf))) > 0){
  29:	eb 69                	jmp    94 <wc+0x94>
    for(i=0; i<n; i++){
  2b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  32:	eb 58                	jmp    8c <wc+0x8c>
      c++;
  34:	83 45 f0 01          	addl   $0x1,-0x10(%rbp)
      if(buf[i] == '\n')
  38:	8b 45 fc             	mov    -0x4(%rbp),%eax
  3b:	48 98                	cltq
  3d:	0f b6 80 e0 11 00 00 	movzbl 0x11e0(%rax),%eax
  44:	3c 0a                	cmp    $0xa,%al
  46:	75 04                	jne    4c <wc+0x4c>
        l++;
  48:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
      if(strchr(" \r\t\n\v", buf[i]))
  4c:	8b 45 fc             	mov    -0x4(%rbp),%eax
  4f:	48 98                	cltq
  51:	0f b6 80 e0 11 00 00 	movzbl 0x11e0(%rax),%eax
  58:	0f be c0             	movsbl %al,%eax
  5b:	89 c6                	mov    %eax,%esi
  5d:	48 c7 c7 7b 0e 00 00 	mov    $0xe7b,%rdi
  64:	e8 a5 02 00 00       	call   30e <strchr>
  69:	48 85 c0             	test   %rax,%rax
  6c:	74 09                	je     77 <wc+0x77>
        inword = 0;
  6e:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
  75:	eb 11                	jmp    88 <wc+0x88>
      else if(!inword){
  77:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  7b:	75 0b                	jne    88 <wc+0x88>
        w++;
  7d:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
        inword = 1;
  81:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%rbp)
    for(i=0; i<n; i++){
  88:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  8c:	8b 45 fc             	mov    -0x4(%rbp),%eax
  8f:	3b 45 e8             	cmp    -0x18(%rbp),%eax
  92:	7c a0                	jl     34 <wc+0x34>
  while((n = read(fd, buf, sizeof(buf))) > 0){
  94:	8b 45 dc             	mov    -0x24(%rbp),%eax
  97:	ba 00 02 00 00       	mov    $0x200,%edx
  9c:	48 c7 c6 e0 11 00 00 	mov    $0x11e0,%rsi
  a3:	89 c7                	mov    %eax,%edi
  a5:	e8 45 04 00 00       	call   4ef <read>
  aa:	89 45 e8             	mov    %eax,-0x18(%rbp)
  ad:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  b1:	0f 8f 74 ff ff ff    	jg     2b <wc+0x2b>
      }
    }
  }
  if(n < 0){
  b7:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  bb:	79 1b                	jns    d8 <wc+0xd8>
    printf(1, "wc: read error\n");
  bd:	48 c7 c6 81 0e 00 00 	mov    $0xe81,%rsi
  c4:	bf 01 00 00 00       	mov    $0x1,%edi
  c9:	b8 00 00 00 00       	mov    $0x0,%eax
  ce:	e8 b6 05 00 00       	call   689 <printf>
    exit();
  d3:	e8 ff 03 00 00       	call   4d7 <exit>
  }
  printf(1, "%d %d %d %s\n", l, w, c, name);
  d8:	48 8b 75 d0          	mov    -0x30(%rbp),%rsi
  dc:	8b 4d f0             	mov    -0x10(%rbp),%ecx
  df:	8b 55 f4             	mov    -0xc(%rbp),%edx
  e2:	8b 45 f8             	mov    -0x8(%rbp),%eax
  e5:	49 89 f1             	mov    %rsi,%r9
  e8:	41 89 c8             	mov    %ecx,%r8d
  eb:	89 d1                	mov    %edx,%ecx
  ed:	89 c2                	mov    %eax,%edx
  ef:	48 c7 c6 91 0e 00 00 	mov    $0xe91,%rsi
  f6:	bf 01 00 00 00       	mov    $0x1,%edi
  fb:	b8 00 00 00 00       	mov    $0x0,%eax
 100:	e8 84 05 00 00       	call   689 <printf>
}
 105:	90                   	nop
 106:	c9                   	leave
 107:	c3                   	ret

0000000000000108 <main>:

int
main(int argc, char *argv[])
{
 108:	55                   	push   %rbp
 109:	48 89 e5             	mov    %rsp,%rbp
 10c:	48 83 ec 20          	sub    $0x20,%rsp
 110:	89 7d ec             	mov    %edi,-0x14(%rbp)
 113:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  int fd, i;

  if(argc <= 1){
 117:	83 7d ec 01          	cmpl   $0x1,-0x14(%rbp)
 11b:	7f 16                	jg     133 <main+0x2b>
    wc(0, "");
 11d:	48 c7 c6 9e 0e 00 00 	mov    $0xe9e,%rsi
 124:	bf 00 00 00 00       	mov    $0x0,%edi
 129:	e8 d2 fe ff ff       	call   0 <wc>
    exit();
 12e:	e8 a4 03 00 00       	call   4d7 <exit>
  }

  for(i = 1; i < argc; i++){
 133:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%rbp)
 13a:	e9 94 00 00 00       	jmp    1d3 <main+0xcb>
    if((fd = open(argv[i], 0)) < 0){
 13f:	8b 45 fc             	mov    -0x4(%rbp),%eax
 142:	48 98                	cltq
 144:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
 14b:	00 
 14c:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
 150:	48 01 d0             	add    %rdx,%rax
 153:	48 8b 00             	mov    (%rax),%rax
 156:	be 00 00 00 00       	mov    $0x0,%esi
 15b:	48 89 c7             	mov    %rax,%rdi
 15e:	e8 b4 03 00 00       	call   517 <open>
 163:	89 45 f8             	mov    %eax,-0x8(%rbp)
 166:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
 16a:	79 35                	jns    1a1 <main+0x99>
      printf(1, "wc: cannot open %s\n", argv[i]);
 16c:	8b 45 fc             	mov    -0x4(%rbp),%eax
 16f:	48 98                	cltq
 171:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
 178:	00 
 179:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
 17d:	48 01 d0             	add    %rdx,%rax
 180:	48 8b 00             	mov    (%rax),%rax
 183:	48 89 c2             	mov    %rax,%rdx
 186:	48 c7 c6 9f 0e 00 00 	mov    $0xe9f,%rsi
 18d:	bf 01 00 00 00       	mov    $0x1,%edi
 192:	b8 00 00 00 00       	mov    $0x0,%eax
 197:	e8 ed 04 00 00       	call   689 <printf>
      exit();
 19c:	e8 36 03 00 00       	call   4d7 <exit>
    }
    wc(fd, argv[i]);
 1a1:	8b 45 fc             	mov    -0x4(%rbp),%eax
 1a4:	48 98                	cltq
 1a6:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
 1ad:	00 
 1ae:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
 1b2:	48 01 d0             	add    %rdx,%rax
 1b5:	48 8b 10             	mov    (%rax),%rdx
 1b8:	8b 45 f8             	mov    -0x8(%rbp),%eax
 1bb:	48 89 d6             	mov    %rdx,%rsi
 1be:	89 c7                	mov    %eax,%edi
 1c0:	e8 3b fe ff ff       	call   0 <wc>
    close(fd);
 1c5:	8b 45 f8             	mov    -0x8(%rbp),%eax
 1c8:	89 c7                	mov    %eax,%edi
 1ca:	e8 30 03 00 00       	call   4ff <close>
  for(i = 1; i < argc; i++){
 1cf:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
 1d3:	8b 45 fc             	mov    -0x4(%rbp),%eax
 1d6:	3b 45 ec             	cmp    -0x14(%rbp),%eax
 1d9:	0f 8c 60 ff ff ff    	jl     13f <main+0x37>
  }
  exit();
 1df:	e8 f3 02 00 00       	call   4d7 <exit>

00000000000001e4 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
 1e4:	55                   	push   %rbp
 1e5:	48 89 e5             	mov    %rsp,%rbp
 1e8:	48 83 ec 10          	sub    $0x10,%rsp
 1ec:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
 1f0:	89 75 f4             	mov    %esi,-0xc(%rbp)
 1f3:	89 55 f0             	mov    %edx,-0x10(%rbp)
  asm volatile("cld; rep stosb" :
 1f6:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
 1fa:	8b 55 f0             	mov    -0x10(%rbp),%edx
 1fd:	8b 45 f4             	mov    -0xc(%rbp),%eax
 200:	48 89 ce             	mov    %rcx,%rsi
 203:	48 89 f7             	mov    %rsi,%rdi
 206:	89 d1                	mov    %edx,%ecx
 208:	fc                   	cld
 209:	f3 aa                	rep stos %al,%es:(%rdi)
 20b:	89 ca                	mov    %ecx,%edx
 20d:	48 89 fe             	mov    %rdi,%rsi
 210:	48 89 75 f8          	mov    %rsi,-0x8(%rbp)
 214:	89 55 f0             	mov    %edx,-0x10(%rbp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
 217:	90                   	nop
 218:	c9                   	leave
 219:	c3                   	ret

000000000000021a <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 21a:	55                   	push   %rbp
 21b:	48 89 e5             	mov    %rsp,%rbp
 21e:	48 83 ec 20          	sub    $0x20,%rsp
 222:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
 226:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  char *os;

  os = s;
 22a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 22e:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  while((*s++ = *t++) != 0)
 232:	90                   	nop
 233:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
 237:	48 8d 42 01          	lea    0x1(%rdx),%rax
 23b:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
 23f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 243:	48 8d 48 01          	lea    0x1(%rax),%rcx
 247:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
 24b:	0f b6 12             	movzbl (%rdx),%edx
 24e:	88 10                	mov    %dl,(%rax)
 250:	0f b6 00             	movzbl (%rax),%eax
 253:	84 c0                	test   %al,%al
 255:	75 dc                	jne    233 <strcpy+0x19>
    ;
  return os;
 257:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
 25b:	c9                   	leave
 25c:	c3                   	ret

000000000000025d <strcmp>:

int
strcmp(const char *p, const char *q)
{
 25d:	55                   	push   %rbp
 25e:	48 89 e5             	mov    %rsp,%rbp
 261:	48 83 ec 10          	sub    $0x10,%rsp
 265:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
 269:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  while(*p && *p == *q)
 26d:	eb 0a                	jmp    279 <strcmp+0x1c>
    p++, q++;
 26f:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
 274:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  while(*p && *p == *q)
 279:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 27d:	0f b6 00             	movzbl (%rax),%eax
 280:	84 c0                	test   %al,%al
 282:	74 12                	je     296 <strcmp+0x39>
 284:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 288:	0f b6 10             	movzbl (%rax),%edx
 28b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 28f:	0f b6 00             	movzbl (%rax),%eax
 292:	38 c2                	cmp    %al,%dl
 294:	74 d9                	je     26f <strcmp+0x12>
  return (uchar)*p - (uchar)*q;
 296:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 29a:	0f b6 00             	movzbl (%rax),%eax
 29d:	0f b6 d0             	movzbl %al,%edx
 2a0:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 2a4:	0f b6 00             	movzbl (%rax),%eax
 2a7:	0f b6 c0             	movzbl %al,%eax
 2aa:	29 c2                	sub    %eax,%edx
 2ac:	89 d0                	mov    %edx,%eax
}
 2ae:	c9                   	leave
 2af:	c3                   	ret

00000000000002b0 <strlen>:

uint
strlen(char *s)
{
 2b0:	55                   	push   %rbp
 2b1:	48 89 e5             	mov    %rsp,%rbp
 2b4:	48 83 ec 18          	sub    $0x18,%rsp
 2b8:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  int n;

  for(n = 0; s[n]; n++)
 2bc:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
 2c3:	eb 04                	jmp    2c9 <strlen+0x19>
 2c5:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
 2c9:	8b 45 fc             	mov    -0x4(%rbp),%eax
 2cc:	48 63 d0             	movslq %eax,%rdx
 2cf:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 2d3:	48 01 d0             	add    %rdx,%rax
 2d6:	0f b6 00             	movzbl (%rax),%eax
 2d9:	84 c0                	test   %al,%al
 2db:	75 e8                	jne    2c5 <strlen+0x15>
    ;
  return n;
 2dd:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
 2e0:	c9                   	leave
 2e1:	c3                   	ret

00000000000002e2 <memset>:

void*
memset(void *dst, int c, uint n)
{
 2e2:	55                   	push   %rbp
 2e3:	48 89 e5             	mov    %rsp,%rbp
 2e6:	48 83 ec 10          	sub    $0x10,%rsp
 2ea:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
 2ee:	89 75 f4             	mov    %esi,-0xc(%rbp)
 2f1:	89 55 f0             	mov    %edx,-0x10(%rbp)
  stosb(dst, c, n);
 2f4:	8b 55 f0             	mov    -0x10(%rbp),%edx
 2f7:	8b 4d f4             	mov    -0xc(%rbp),%ecx
 2fa:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 2fe:	89 ce                	mov    %ecx,%esi
 300:	48 89 c7             	mov    %rax,%rdi
 303:	e8 dc fe ff ff       	call   1e4 <stosb>
  return dst;
 308:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
 30c:	c9                   	leave
 30d:	c3                   	ret

000000000000030e <strchr>:

char*
strchr(const char *s, char c)
{
 30e:	55                   	push   %rbp
 30f:	48 89 e5             	mov    %rsp,%rbp
 312:	48 83 ec 10          	sub    $0x10,%rsp
 316:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
 31a:	89 f0                	mov    %esi,%eax
 31c:	88 45 f4             	mov    %al,-0xc(%rbp)
  for(; *s; s++)
 31f:	eb 17                	jmp    338 <strchr+0x2a>
    if(*s == c)
 321:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 325:	0f b6 00             	movzbl (%rax),%eax
 328:	38 45 f4             	cmp    %al,-0xc(%rbp)
 32b:	75 06                	jne    333 <strchr+0x25>
      return (char*)s;
 32d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 331:	eb 15                	jmp    348 <strchr+0x3a>
  for(; *s; s++)
 333:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
 338:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 33c:	0f b6 00             	movzbl (%rax),%eax
 33f:	84 c0                	test   %al,%al
 341:	75 de                	jne    321 <strchr+0x13>
  return 0;
 343:	b8 00 00 00 00       	mov    $0x0,%eax
}
 348:	c9                   	leave
 349:	c3                   	ret

000000000000034a <gets>:

char*
gets(char *buf, int max)
{
 34a:	55                   	push   %rbp
 34b:	48 89 e5             	mov    %rsp,%rbp
 34e:	48 83 ec 20          	sub    $0x20,%rsp
 352:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
 356:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 359:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
 360:	eb 48                	jmp    3aa <gets+0x60>
    cc = read(0, &c, 1);
 362:	48 8d 45 f7          	lea    -0x9(%rbp),%rax
 366:	ba 01 00 00 00       	mov    $0x1,%edx
 36b:	48 89 c6             	mov    %rax,%rsi
 36e:	bf 00 00 00 00       	mov    $0x0,%edi
 373:	e8 77 01 00 00       	call   4ef <read>
 378:	89 45 f8             	mov    %eax,-0x8(%rbp)
    if(cc < 1)
 37b:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
 37f:	7e 36                	jle    3b7 <gets+0x6d>
      break;
    buf[i++] = c;
 381:	8b 45 fc             	mov    -0x4(%rbp),%eax
 384:	8d 50 01             	lea    0x1(%rax),%edx
 387:	89 55 fc             	mov    %edx,-0x4(%rbp)
 38a:	48 63 d0             	movslq %eax,%rdx
 38d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 391:	48 01 c2             	add    %rax,%rdx
 394:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
 398:	88 02                	mov    %al,(%rdx)
    if(c == '\n' || c == '\r')
 39a:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
 39e:	3c 0a                	cmp    $0xa,%al
 3a0:	74 16                	je     3b8 <gets+0x6e>
 3a2:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
 3a6:	3c 0d                	cmp    $0xd,%al
 3a8:	74 0e                	je     3b8 <gets+0x6e>
  for(i=0; i+1 < max; ){
 3aa:	8b 45 fc             	mov    -0x4(%rbp),%eax
 3ad:	83 c0 01             	add    $0x1,%eax
 3b0:	39 45 e4             	cmp    %eax,-0x1c(%rbp)
 3b3:	7f ad                	jg     362 <gets+0x18>
 3b5:	eb 01                	jmp    3b8 <gets+0x6e>
      break;
 3b7:	90                   	nop
      break;
  }
  buf[i] = '\0';
 3b8:	8b 45 fc             	mov    -0x4(%rbp),%eax
 3bb:	48 63 d0             	movslq %eax,%rdx
 3be:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 3c2:	48 01 d0             	add    %rdx,%rax
 3c5:	c6 00 00             	movb   $0x0,(%rax)
  return buf;
 3c8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
 3cc:	c9                   	leave
 3cd:	c3                   	ret

00000000000003ce <stat>:

int
stat(char *n, struct stat *st)
{
 3ce:	55                   	push   %rbp
 3cf:	48 89 e5             	mov    %rsp,%rbp
 3d2:	48 83 ec 20          	sub    $0x20,%rsp
 3d6:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
 3da:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 3de:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 3e2:	be 00 00 00 00       	mov    $0x0,%esi
 3e7:	48 89 c7             	mov    %rax,%rdi
 3ea:	e8 28 01 00 00       	call   517 <open>
 3ef:	89 45 fc             	mov    %eax,-0x4(%rbp)
  if(fd < 0)
 3f2:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
 3f6:	79 07                	jns    3ff <stat+0x31>
    return -1;
 3f8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 3fd:	eb 21                	jmp    420 <stat+0x52>
  r = fstat(fd, st);
 3ff:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
 403:	8b 45 fc             	mov    -0x4(%rbp),%eax
 406:	48 89 d6             	mov    %rdx,%rsi
 409:	89 c7                	mov    %eax,%edi
 40b:	e8 1f 01 00 00       	call   52f <fstat>
 410:	89 45 f8             	mov    %eax,-0x8(%rbp)
  close(fd);
 413:	8b 45 fc             	mov    -0x4(%rbp),%eax
 416:	89 c7                	mov    %eax,%edi
 418:	e8 e2 00 00 00       	call   4ff <close>
  return r;
 41d:	8b 45 f8             	mov    -0x8(%rbp),%eax
}
 420:	c9                   	leave
 421:	c3                   	ret

0000000000000422 <atoi>:

int
atoi(const char *s)
{
 422:	55                   	push   %rbp
 423:	48 89 e5             	mov    %rsp,%rbp
 426:	48 83 ec 18          	sub    $0x18,%rsp
 42a:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  int n;

  n = 0;
 42e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  while('0' <= *s && *s <= '9')
 435:	eb 28                	jmp    45f <atoi+0x3d>
    n = n*10 + *s++ - '0';
 437:	8b 55 fc             	mov    -0x4(%rbp),%edx
 43a:	89 d0                	mov    %edx,%eax
 43c:	c1 e0 02             	shl    $0x2,%eax
 43f:	01 d0                	add    %edx,%eax
 441:	01 c0                	add    %eax,%eax
 443:	89 c1                	mov    %eax,%ecx
 445:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 449:	48 8d 50 01          	lea    0x1(%rax),%rdx
 44d:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
 451:	0f b6 00             	movzbl (%rax),%eax
 454:	0f be c0             	movsbl %al,%eax
 457:	01 c8                	add    %ecx,%eax
 459:	83 e8 30             	sub    $0x30,%eax
 45c:	89 45 fc             	mov    %eax,-0x4(%rbp)
  while('0' <= *s && *s <= '9')
 45f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 463:	0f b6 00             	movzbl (%rax),%eax
 466:	3c 2f                	cmp    $0x2f,%al
 468:	7e 0b                	jle    475 <atoi+0x53>
 46a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 46e:	0f b6 00             	movzbl (%rax),%eax
 471:	3c 39                	cmp    $0x39,%al
 473:	7e c2                	jle    437 <atoi+0x15>
  return n;
 475:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
 478:	c9                   	leave
 479:	c3                   	ret

000000000000047a <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 47a:	55                   	push   %rbp
 47b:	48 89 e5             	mov    %rsp,%rbp
 47e:	48 83 ec 28          	sub    $0x28,%rsp
 482:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
 486:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
 48a:	89 55 dc             	mov    %edx,-0x24(%rbp)
  char *dst, *src;
  
  dst = vdst;
 48d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 491:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  src = vsrc;
 495:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
 499:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  while(n-- > 0)
 49d:	eb 1d                	jmp    4bc <memmove+0x42>
    *dst++ = *src++;
 49f:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
 4a3:	48 8d 42 01          	lea    0x1(%rdx),%rax
 4a7:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
 4ab:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 4af:	48 8d 48 01          	lea    0x1(%rax),%rcx
 4b3:	48 89 4d f8          	mov    %rcx,-0x8(%rbp)
 4b7:	0f b6 12             	movzbl (%rdx),%edx
 4ba:	88 10                	mov    %dl,(%rax)
  while(n-- > 0)
 4bc:	8b 45 dc             	mov    -0x24(%rbp),%eax
 4bf:	8d 50 ff             	lea    -0x1(%rax),%edx
 4c2:	89 55 dc             	mov    %edx,-0x24(%rbp)
 4c5:	85 c0                	test   %eax,%eax
 4c7:	7f d6                	jg     49f <memmove+0x25>
  return vdst;
 4c9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
 4cd:	c9                   	leave
 4ce:	c3                   	ret

00000000000004cf <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 4cf:	b8 01 00 00 00       	mov    $0x1,%eax
 4d4:	cd 40                	int    $0x40
 4d6:	c3                   	ret

00000000000004d7 <exit>:
SYSCALL(exit)
 4d7:	b8 02 00 00 00       	mov    $0x2,%eax
 4dc:	cd 40                	int    $0x40
 4de:	c3                   	ret

00000000000004df <wait>:
SYSCALL(wait)
 4df:	b8 03 00 00 00       	mov    $0x3,%eax
 4e4:	cd 40                	int    $0x40
 4e6:	c3                   	ret

00000000000004e7 <pipe>:
SYSCALL(pipe)
 4e7:	b8 04 00 00 00       	mov    $0x4,%eax
 4ec:	cd 40                	int    $0x40
 4ee:	c3                   	ret

00000000000004ef <read>:
SYSCALL(read)
 4ef:	b8 05 00 00 00       	mov    $0x5,%eax
 4f4:	cd 40                	int    $0x40
 4f6:	c3                   	ret

00000000000004f7 <write>:
SYSCALL(write)
 4f7:	b8 10 00 00 00       	mov    $0x10,%eax
 4fc:	cd 40                	int    $0x40
 4fe:	c3                   	ret

00000000000004ff <close>:
SYSCALL(close)
 4ff:	b8 15 00 00 00       	mov    $0x15,%eax
 504:	cd 40                	int    $0x40
 506:	c3                   	ret

0000000000000507 <kill>:
SYSCALL(kill)
 507:	b8 06 00 00 00       	mov    $0x6,%eax
 50c:	cd 40                	int    $0x40
 50e:	c3                   	ret

000000000000050f <exec>:
SYSCALL(exec)
 50f:	b8 07 00 00 00       	mov    $0x7,%eax
 514:	cd 40                	int    $0x40
 516:	c3                   	ret

0000000000000517 <open>:
SYSCALL(open)
 517:	b8 0f 00 00 00       	mov    $0xf,%eax
 51c:	cd 40                	int    $0x40
 51e:	c3                   	ret

000000000000051f <mknod>:
SYSCALL(mknod)
 51f:	b8 11 00 00 00       	mov    $0x11,%eax
 524:	cd 40                	int    $0x40
 526:	c3                   	ret

0000000000000527 <unlink>:
SYSCALL(unlink)
 527:	b8 12 00 00 00       	mov    $0x12,%eax
 52c:	cd 40                	int    $0x40
 52e:	c3                   	ret

000000000000052f <fstat>:
SYSCALL(fstat)
 52f:	b8 08 00 00 00       	mov    $0x8,%eax
 534:	cd 40                	int    $0x40
 536:	c3                   	ret

0000000000000537 <link>:
SYSCALL(link)
 537:	b8 13 00 00 00       	mov    $0x13,%eax
 53c:	cd 40                	int    $0x40
 53e:	c3                   	ret

000000000000053f <mkdir>:
SYSCALL(mkdir)
 53f:	b8 14 00 00 00       	mov    $0x14,%eax
 544:	cd 40                	int    $0x40
 546:	c3                   	ret

0000000000000547 <chdir>:
SYSCALL(chdir)
 547:	b8 09 00 00 00       	mov    $0x9,%eax
 54c:	cd 40                	int    $0x40
 54e:	c3                   	ret

000000000000054f <dup>:
SYSCALL(dup)
 54f:	b8 0a 00 00 00       	mov    $0xa,%eax
 554:	cd 40                	int    $0x40
 556:	c3                   	ret

0000000000000557 <getpid>:
SYSCALL(getpid)
 557:	b8 0b 00 00 00       	mov    $0xb,%eax
 55c:	cd 40                	int    $0x40
 55e:	c3                   	ret

000000000000055f <sbrk>:
SYSCALL(sbrk)
 55f:	b8 0c 00 00 00       	mov    $0xc,%eax
 564:	cd 40                	int    $0x40
 566:	c3                   	ret

0000000000000567 <sleep>:
SYSCALL(sleep)
 567:	b8 0d 00 00 00       	mov    $0xd,%eax
 56c:	cd 40                	int    $0x40
 56e:	c3                   	ret

000000000000056f <uptime>:
SYSCALL(uptime)
 56f:	b8 0e 00 00 00       	mov    $0xe,%eax
 574:	cd 40                	int    $0x40
 576:	c3                   	ret

0000000000000577 <getpinfo>:
SYSCALL(getpinfo)
 577:	b8 18 00 00 00       	mov    $0x18,%eax
 57c:	cd 40                	int    $0x40
 57e:	c3                   	ret

000000000000057f <getfavnum>:
SYSCALL(getfavnum)
 57f:	b8 19 00 00 00       	mov    $0x19,%eax
 584:	cd 40                	int    $0x40
 586:	c3                   	ret

0000000000000587 <shutdown>:
SYSCALL(shutdown)
 587:	b8 1a 00 00 00       	mov    $0x1a,%eax
 58c:	cd 40                	int    $0x40
 58e:	c3                   	ret

000000000000058f <getcount>:
SYSCALL(getcount)
 58f:	b8 1b 00 00 00       	mov    $0x1b,%eax
 594:	cd 40                	int    $0x40
 596:	c3                   	ret

0000000000000597 <killrandom>:
 597:	b8 1c 00 00 00       	mov    $0x1c,%eax
 59c:	cd 40                	int    $0x40
 59e:	c3                   	ret

000000000000059f <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 59f:	55                   	push   %rbp
 5a0:	48 89 e5             	mov    %rsp,%rbp
 5a3:	48 83 ec 10          	sub    $0x10,%rsp
 5a7:	89 7d fc             	mov    %edi,-0x4(%rbp)
 5aa:	89 f0                	mov    %esi,%eax
 5ac:	88 45 f8             	mov    %al,-0x8(%rbp)
  write(fd, &c, 1);
 5af:	48 8d 4d f8          	lea    -0x8(%rbp),%rcx
 5b3:	8b 45 fc             	mov    -0x4(%rbp),%eax
 5b6:	ba 01 00 00 00       	mov    $0x1,%edx
 5bb:	48 89 ce             	mov    %rcx,%rsi
 5be:	89 c7                	mov    %eax,%edi
 5c0:	e8 32 ff ff ff       	call   4f7 <write>
}
 5c5:	90                   	nop
 5c6:	c9                   	leave
 5c7:	c3                   	ret

00000000000005c8 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 5c8:	55                   	push   %rbp
 5c9:	48 89 e5             	mov    %rsp,%rbp
 5cc:	48 83 ec 30          	sub    $0x30,%rsp
 5d0:	89 7d dc             	mov    %edi,-0x24(%rbp)
 5d3:	89 75 d8             	mov    %esi,-0x28(%rbp)
 5d6:	89 55 d4             	mov    %edx,-0x2c(%rbp)
 5d9:	89 4d d0             	mov    %ecx,-0x30(%rbp)
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 5dc:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
  if(sgn && xx < 0){
 5e3:	83 7d d0 00          	cmpl   $0x0,-0x30(%rbp)
 5e7:	74 17                	je     600 <printint+0x38>
 5e9:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
 5ed:	79 11                	jns    600 <printint+0x38>
    neg = 1;
 5ef:	c7 45 f8 01 00 00 00 	movl   $0x1,-0x8(%rbp)
    x = -xx;
 5f6:	8b 45 d8             	mov    -0x28(%rbp),%eax
 5f9:	f7 d8                	neg    %eax
 5fb:	89 45 f4             	mov    %eax,-0xc(%rbp)
 5fe:	eb 06                	jmp    606 <printint+0x3e>
  } else {
    x = xx;
 600:	8b 45 d8             	mov    -0x28(%rbp),%eax
 603:	89 45 f4             	mov    %eax,-0xc(%rbp)
  }

  i = 0;
 606:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  do{
    buf[i++] = digits[x % base];
 60d:	8b 4d d4             	mov    -0x2c(%rbp),%ecx
 610:	8b 45 f4             	mov    -0xc(%rbp),%eax
 613:	ba 00 00 00 00       	mov    $0x0,%edx
 618:	f7 f1                	div    %ecx
 61a:	89 d1                	mov    %edx,%ecx
 61c:	8b 45 fc             	mov    -0x4(%rbp),%eax
 61f:	8d 50 01             	lea    0x1(%rax),%edx
 622:	89 55 fc             	mov    %edx,-0x4(%rbp)
 625:	89 ca                	mov    %ecx,%edx
 627:	0f b6 92 c0 11 00 00 	movzbl 0x11c0(%rdx),%edx
 62e:	48 98                	cltq
 630:	88 54 05 e0          	mov    %dl,-0x20(%rbp,%rax,1)
  }while((x /= base) != 0);
 634:	8b 75 d4             	mov    -0x2c(%rbp),%esi
 637:	8b 45 f4             	mov    -0xc(%rbp),%eax
 63a:	ba 00 00 00 00       	mov    $0x0,%edx
 63f:	f7 f6                	div    %esi
 641:	89 45 f4             	mov    %eax,-0xc(%rbp)
 644:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
 648:	75 c3                	jne    60d <printint+0x45>
  if(neg)
 64a:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
 64e:	74 2b                	je     67b <printint+0xb3>
    buf[i++] = '-';
 650:	8b 45 fc             	mov    -0x4(%rbp),%eax
 653:	8d 50 01             	lea    0x1(%rax),%edx
 656:	89 55 fc             	mov    %edx,-0x4(%rbp)
 659:	48 98                	cltq
 65b:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%rbp,%rax,1)

  while(--i >= 0)
 660:	eb 19                	jmp    67b <printint+0xb3>
    putc(fd, buf[i]);
 662:	8b 45 fc             	mov    -0x4(%rbp),%eax
 665:	48 98                	cltq
 667:	0f b6 44 05 e0       	movzbl -0x20(%rbp,%rax,1),%eax
 66c:	0f be d0             	movsbl %al,%edx
 66f:	8b 45 dc             	mov    -0x24(%rbp),%eax
 672:	89 d6                	mov    %edx,%esi
 674:	89 c7                	mov    %eax,%edi
 676:	e8 24 ff ff ff       	call   59f <putc>
  while(--i >= 0)
 67b:	83 6d fc 01          	subl   $0x1,-0x4(%rbp)
 67f:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
 683:	79 dd                	jns    662 <printint+0x9a>
}
 685:	90                   	nop
 686:	90                   	nop
 687:	c9                   	leave
 688:	c3                   	ret

0000000000000689 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 689:	55                   	push   %rbp
 68a:	48 89 e5             	mov    %rsp,%rbp
 68d:	48 81 ec f0 00 00 00 	sub    $0xf0,%rsp
 694:	89 bd 1c ff ff ff    	mov    %edi,-0xe4(%rbp)
 69a:	48 89 b5 10 ff ff ff 	mov    %rsi,-0xf0(%rbp)
 6a1:	48 89 95 60 ff ff ff 	mov    %rdx,-0xa0(%rbp)
 6a8:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
 6af:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
 6b6:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
 6bd:	84 c0                	test   %al,%al
 6bf:	74 20                	je     6e1 <printf+0x58>
 6c1:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
 6c5:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
 6c9:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
 6cd:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
 6d1:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
 6d5:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
 6d9:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
 6dd:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  va_list ap;
  char *s;
  int c, i, state;
  va_start(ap, fmt);
 6e1:	c7 85 20 ff ff ff 10 	movl   $0x10,-0xe0(%rbp)
 6e8:	00 00 00 
 6eb:	c7 85 24 ff ff ff 30 	movl   $0x30,-0xdc(%rbp)
 6f2:	00 00 00 
 6f5:	48 8d 45 10          	lea    0x10(%rbp),%rax
 6f9:	48 89 85 28 ff ff ff 	mov    %rax,-0xd8(%rbp)
 700:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
 707:	48 89 85 30 ff ff ff 	mov    %rax,-0xd0(%rbp)

  state = 0;
 70e:	c7 85 40 ff ff ff 00 	movl   $0x0,-0xc0(%rbp)
 715:	00 00 00 
  for(i = 0; fmt[i]; i++){
 718:	c7 85 44 ff ff ff 00 	movl   $0x0,-0xbc(%rbp)
 71f:	00 00 00 
 722:	e9 a8 02 00 00       	jmp    9cf <printf+0x346>
    c = fmt[i] & 0xff;
 727:	8b 85 44 ff ff ff    	mov    -0xbc(%rbp),%eax
 72d:	48 63 d0             	movslq %eax,%rdx
 730:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
 737:	48 01 d0             	add    %rdx,%rax
 73a:	0f b6 00             	movzbl (%rax),%eax
 73d:	0f be c0             	movsbl %al,%eax
 740:	25 ff 00 00 00       	and    $0xff,%eax
 745:	89 85 3c ff ff ff    	mov    %eax,-0xc4(%rbp)
    if(state == 0){
 74b:	83 bd 40 ff ff ff 00 	cmpl   $0x0,-0xc0(%rbp)
 752:	75 35                	jne    789 <printf+0x100>
      if(c == '%'){
 754:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
 75b:	75 0f                	jne    76c <printf+0xe3>
        state = '%';
 75d:	c7 85 40 ff ff ff 25 	movl   $0x25,-0xc0(%rbp)
 764:	00 00 00 
 767:	e9 5c 02 00 00       	jmp    9c8 <printf+0x33f>
      } else {
        putc(fd, c);
 76c:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
 772:	0f be d0             	movsbl %al,%edx
 775:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 77b:	89 d6                	mov    %edx,%esi
 77d:	89 c7                	mov    %eax,%edi
 77f:	e8 1b fe ff ff       	call   59f <putc>
 784:	e9 3f 02 00 00       	jmp    9c8 <printf+0x33f>
      }
    } else if(state == '%'){
 789:	83 bd 40 ff ff ff 25 	cmpl   $0x25,-0xc0(%rbp)
 790:	0f 85 32 02 00 00    	jne    9c8 <printf+0x33f>
      if(c == 'd'){
 796:	83 bd 3c ff ff ff 64 	cmpl   $0x64,-0xc4(%rbp)
 79d:	75 5e                	jne    7fd <printf+0x174>
        printint(fd, va_arg(ap, int), 10, 1);
 79f:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 7a5:	83 f8 2f             	cmp    $0x2f,%eax
 7a8:	77 23                	ja     7cd <printf+0x144>
 7aa:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 7b1:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 7b7:	89 d2                	mov    %edx,%edx
 7b9:	48 01 d0             	add    %rdx,%rax
 7bc:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 7c2:	83 c2 08             	add    $0x8,%edx
 7c5:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 7cb:	eb 12                	jmp    7df <printf+0x156>
 7cd:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 7d4:	48 8d 50 08          	lea    0x8(%rax),%rdx
 7d8:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 7df:	8b 30                	mov    (%rax),%esi
 7e1:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 7e7:	b9 01 00 00 00       	mov    $0x1,%ecx
 7ec:	ba 0a 00 00 00       	mov    $0xa,%edx
 7f1:	89 c7                	mov    %eax,%edi
 7f3:	e8 d0 fd ff ff       	call   5c8 <printint>
 7f8:	e9 c1 01 00 00       	jmp    9be <printf+0x335>
      } else if(c == 'x' || c == 'p'){
 7fd:	83 bd 3c ff ff ff 78 	cmpl   $0x78,-0xc4(%rbp)
 804:	74 09                	je     80f <printf+0x186>
 806:	83 bd 3c ff ff ff 70 	cmpl   $0x70,-0xc4(%rbp)
 80d:	75 5e                	jne    86d <printf+0x1e4>
        printint(fd, va_arg(ap, int), 16, 0);
 80f:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 815:	83 f8 2f             	cmp    $0x2f,%eax
 818:	77 23                	ja     83d <printf+0x1b4>
 81a:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 821:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 827:	89 d2                	mov    %edx,%edx
 829:	48 01 d0             	add    %rdx,%rax
 82c:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 832:	83 c2 08             	add    $0x8,%edx
 835:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 83b:	eb 12                	jmp    84f <printf+0x1c6>
 83d:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 844:	48 8d 50 08          	lea    0x8(%rax),%rdx
 848:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 84f:	8b 30                	mov    (%rax),%esi
 851:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 857:	b9 00 00 00 00       	mov    $0x0,%ecx
 85c:	ba 10 00 00 00       	mov    $0x10,%edx
 861:	89 c7                	mov    %eax,%edi
 863:	e8 60 fd ff ff       	call   5c8 <printint>
 868:	e9 51 01 00 00       	jmp    9be <printf+0x335>
      } else if(c == 's'){
 86d:	83 bd 3c ff ff ff 73 	cmpl   $0x73,-0xc4(%rbp)
 874:	0f 85 98 00 00 00    	jne    912 <printf+0x289>
        s = va_arg(ap, char*);
 87a:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 880:	83 f8 2f             	cmp    $0x2f,%eax
 883:	77 23                	ja     8a8 <printf+0x21f>
 885:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 88c:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 892:	89 d2                	mov    %edx,%edx
 894:	48 01 d0             	add    %rdx,%rax
 897:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 89d:	83 c2 08             	add    $0x8,%edx
 8a0:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 8a6:	eb 12                	jmp    8ba <printf+0x231>
 8a8:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 8af:	48 8d 50 08          	lea    0x8(%rax),%rdx
 8b3:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 8ba:	48 8b 00             	mov    (%rax),%rax
 8bd:	48 89 85 48 ff ff ff 	mov    %rax,-0xb8(%rbp)
        if(s == 0)
 8c4:	48 83 bd 48 ff ff ff 	cmpq   $0x0,-0xb8(%rbp)
 8cb:	00 
 8cc:	75 31                	jne    8ff <printf+0x276>
          s = "(null)";
 8ce:	48 c7 85 48 ff ff ff 	movq   $0xeb3,-0xb8(%rbp)
 8d5:	b3 0e 00 00 
        while(*s != 0){
 8d9:	eb 24                	jmp    8ff <printf+0x276>
          putc(fd, *s);
 8db:	48 8b 85 48 ff ff ff 	mov    -0xb8(%rbp),%rax
 8e2:	0f b6 00             	movzbl (%rax),%eax
 8e5:	0f be d0             	movsbl %al,%edx
 8e8:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 8ee:	89 d6                	mov    %edx,%esi
 8f0:	89 c7                	mov    %eax,%edi
 8f2:	e8 a8 fc ff ff       	call   59f <putc>
          s++;
 8f7:	48 83 85 48 ff ff ff 	addq   $0x1,-0xb8(%rbp)
 8fe:	01 
        while(*s != 0){
 8ff:	48 8b 85 48 ff ff ff 	mov    -0xb8(%rbp),%rax
 906:	0f b6 00             	movzbl (%rax),%eax
 909:	84 c0                	test   %al,%al
 90b:	75 ce                	jne    8db <printf+0x252>
 90d:	e9 ac 00 00 00       	jmp    9be <printf+0x335>
        }
      } else if(c == 'c'){
 912:	83 bd 3c ff ff ff 63 	cmpl   $0x63,-0xc4(%rbp)
 919:	75 56                	jne    971 <printf+0x2e8>
        putc(fd, va_arg(ap, uint));
 91b:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 921:	83 f8 2f             	cmp    $0x2f,%eax
 924:	77 23                	ja     949 <printf+0x2c0>
 926:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 92d:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 933:	89 d2                	mov    %edx,%edx
 935:	48 01 d0             	add    %rdx,%rax
 938:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 93e:	83 c2 08             	add    $0x8,%edx
 941:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 947:	eb 12                	jmp    95b <printf+0x2d2>
 949:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 950:	48 8d 50 08          	lea    0x8(%rax),%rdx
 954:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 95b:	8b 00                	mov    (%rax),%eax
 95d:	0f be d0             	movsbl %al,%edx
 960:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 966:	89 d6                	mov    %edx,%esi
 968:	89 c7                	mov    %eax,%edi
 96a:	e8 30 fc ff ff       	call   59f <putc>
 96f:	eb 4d                	jmp    9be <printf+0x335>
      } else if(c == '%'){
 971:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
 978:	75 1a                	jne    994 <printf+0x30b>
        putc(fd, c);
 97a:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
 980:	0f be d0             	movsbl %al,%edx
 983:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 989:	89 d6                	mov    %edx,%esi
 98b:	89 c7                	mov    %eax,%edi
 98d:	e8 0d fc ff ff       	call   59f <putc>
 992:	eb 2a                	jmp    9be <printf+0x335>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 994:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 99a:	be 25 00 00 00       	mov    $0x25,%esi
 99f:	89 c7                	mov    %eax,%edi
 9a1:	e8 f9 fb ff ff       	call   59f <putc>
        putc(fd, c);
 9a6:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
 9ac:	0f be d0             	movsbl %al,%edx
 9af:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 9b5:	89 d6                	mov    %edx,%esi
 9b7:	89 c7                	mov    %eax,%edi
 9b9:	e8 e1 fb ff ff       	call   59f <putc>
      }
      state = 0;
 9be:	c7 85 40 ff ff ff 00 	movl   $0x0,-0xc0(%rbp)
 9c5:	00 00 00 
  for(i = 0; fmt[i]; i++){
 9c8:	83 85 44 ff ff ff 01 	addl   $0x1,-0xbc(%rbp)
 9cf:	8b 85 44 ff ff ff    	mov    -0xbc(%rbp),%eax
 9d5:	48 63 d0             	movslq %eax,%rdx
 9d8:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
 9df:	48 01 d0             	add    %rdx,%rax
 9e2:	0f b6 00             	movzbl (%rax),%eax
 9e5:	84 c0                	test   %al,%al
 9e7:	0f 85 3a fd ff ff    	jne    727 <printf+0x9e>
    }
  }
}
 9ed:	90                   	nop
 9ee:	90                   	nop
 9ef:	c9                   	leave
 9f0:	c3                   	ret

00000000000009f1 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 9f1:	55                   	push   %rbp
 9f2:	48 89 e5             	mov    %rsp,%rbp
 9f5:	48 83 ec 18          	sub    $0x18,%rsp
 9f9:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  Header *bp, *p;

  bp = (Header*)ap - 1;
 9fd:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 a01:	48 83 e8 10          	sub    $0x10,%rax
 a05:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 a09:	48 8b 05 e0 09 00 00 	mov    0x9e0(%rip),%rax        # 13f0 <freep>
 a10:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 a14:	eb 2f                	jmp    a45 <free+0x54>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 a16:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a1a:	48 8b 00             	mov    (%rax),%rax
 a1d:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 a21:	72 17                	jb     a3a <free+0x49>
 a23:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 a27:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 a2b:	72 2f                	jb     a5c <free+0x6b>
 a2d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a31:	48 8b 00             	mov    (%rax),%rax
 a34:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
 a38:	72 22                	jb     a5c <free+0x6b>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 a3a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a3e:	48 8b 00             	mov    (%rax),%rax
 a41:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 a45:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 a49:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 a4d:	73 c7                	jae    a16 <free+0x25>
 a4f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a53:	48 8b 00             	mov    (%rax),%rax
 a56:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
 a5a:	73 ba                	jae    a16 <free+0x25>
      break;
  if(bp + bp->s.size == p->s.ptr){
 a5c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 a60:	8b 40 08             	mov    0x8(%rax),%eax
 a63:	89 c0                	mov    %eax,%eax
 a65:	48 c1 e0 04          	shl    $0x4,%rax
 a69:	48 89 c2             	mov    %rax,%rdx
 a6c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 a70:	48 01 c2             	add    %rax,%rdx
 a73:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a77:	48 8b 00             	mov    (%rax),%rax
 a7a:	48 39 c2             	cmp    %rax,%rdx
 a7d:	75 2d                	jne    aac <free+0xbb>
    bp->s.size += p->s.ptr->s.size;
 a7f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 a83:	8b 50 08             	mov    0x8(%rax),%edx
 a86:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a8a:	48 8b 00             	mov    (%rax),%rax
 a8d:	8b 40 08             	mov    0x8(%rax),%eax
 a90:	01 c2                	add    %eax,%edx
 a92:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 a96:	89 50 08             	mov    %edx,0x8(%rax)
    bp->s.ptr = p->s.ptr->s.ptr;
 a99:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a9d:	48 8b 00             	mov    (%rax),%rax
 aa0:	48 8b 10             	mov    (%rax),%rdx
 aa3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 aa7:	48 89 10             	mov    %rdx,(%rax)
 aaa:	eb 0e                	jmp    aba <free+0xc9>
  } else
    bp->s.ptr = p->s.ptr;
 aac:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 ab0:	48 8b 10             	mov    (%rax),%rdx
 ab3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 ab7:	48 89 10             	mov    %rdx,(%rax)
  if(p + p->s.size == bp){
 aba:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 abe:	8b 40 08             	mov    0x8(%rax),%eax
 ac1:	89 c0                	mov    %eax,%eax
 ac3:	48 c1 e0 04          	shl    $0x4,%rax
 ac7:	48 89 c2             	mov    %rax,%rdx
 aca:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 ace:	48 01 d0             	add    %rdx,%rax
 ad1:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
 ad5:	75 27                	jne    afe <free+0x10d>
    p->s.size += bp->s.size;
 ad7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 adb:	8b 50 08             	mov    0x8(%rax),%edx
 ade:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 ae2:	8b 40 08             	mov    0x8(%rax),%eax
 ae5:	01 c2                	add    %eax,%edx
 ae7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 aeb:	89 50 08             	mov    %edx,0x8(%rax)
    p->s.ptr = bp->s.ptr;
 aee:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 af2:	48 8b 10             	mov    (%rax),%rdx
 af5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 af9:	48 89 10             	mov    %rdx,(%rax)
 afc:	eb 0b                	jmp    b09 <free+0x118>
  } else
    p->s.ptr = bp;
 afe:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b02:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
 b06:	48 89 10             	mov    %rdx,(%rax)
  freep = p;
 b09:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b0d:	48 89 05 dc 08 00 00 	mov    %rax,0x8dc(%rip)        # 13f0 <freep>
}
 b14:	90                   	nop
 b15:	c9                   	leave
 b16:	c3                   	ret

0000000000000b17 <morecore>:

static Header*
morecore(uint nu)
{
 b17:	55                   	push   %rbp
 b18:	48 89 e5             	mov    %rsp,%rbp
 b1b:	48 83 ec 20          	sub    $0x20,%rsp
 b1f:	89 7d ec             	mov    %edi,-0x14(%rbp)
  char *p;
  Header *hp;

  if(nu < 4096)
 b22:	81 7d ec ff 0f 00 00 	cmpl   $0xfff,-0x14(%rbp)
 b29:	77 07                	ja     b32 <morecore+0x1b>
    nu = 4096;
 b2b:	c7 45 ec 00 10 00 00 	movl   $0x1000,-0x14(%rbp)
  p = sbrk(nu * sizeof(Header));
 b32:	8b 45 ec             	mov    -0x14(%rbp),%eax
 b35:	c1 e0 04             	shl    $0x4,%eax
 b38:	89 c7                	mov    %eax,%edi
 b3a:	e8 20 fa ff ff       	call   55f <sbrk>
 b3f:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  if(p == (char*)-1)
 b43:	48 83 7d f8 ff       	cmpq   $0xffffffffffffffff,-0x8(%rbp)
 b48:	75 07                	jne    b51 <morecore+0x3a>
    return 0;
 b4a:	b8 00 00 00 00       	mov    $0x0,%eax
 b4f:	eb 29                	jmp    b7a <morecore+0x63>
  hp = (Header*)p;
 b51:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b55:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  hp->s.size = nu;
 b59:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 b5d:	8b 55 ec             	mov    -0x14(%rbp),%edx
 b60:	89 50 08             	mov    %edx,0x8(%rax)
  free((void*)(hp + 1));
 b63:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 b67:	48 83 c0 10          	add    $0x10,%rax
 b6b:	48 89 c7             	mov    %rax,%rdi
 b6e:	e8 7e fe ff ff       	call   9f1 <free>
  return freep;
 b73:	48 8b 05 76 08 00 00 	mov    0x876(%rip),%rax        # 13f0 <freep>
}
 b7a:	c9                   	leave
 b7b:	c3                   	ret

0000000000000b7c <malloc>:

void*
malloc(uint nbytes)
{
 b7c:	55                   	push   %rbp
 b7d:	48 89 e5             	mov    %rsp,%rbp
 b80:	48 83 ec 30          	sub    $0x30,%rsp
 b84:	89 7d dc             	mov    %edi,-0x24(%rbp)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 b87:	8b 45 dc             	mov    -0x24(%rbp),%eax
 b8a:	48 83 c0 0f          	add    $0xf,%rax
 b8e:	48 c1 e8 04          	shr    $0x4,%rax
 b92:	83 c0 01             	add    $0x1,%eax
 b95:	89 45 ec             	mov    %eax,-0x14(%rbp)
  if((prevp = freep) == 0){
 b98:	48 8b 05 51 08 00 00 	mov    0x851(%rip),%rax        # 13f0 <freep>
 b9f:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
 ba3:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
 ba8:	75 2b                	jne    bd5 <malloc+0x59>
    base.s.ptr = freep = prevp = &base;
 baa:	48 c7 45 f0 e0 13 00 	movq   $0x13e0,-0x10(%rbp)
 bb1:	00 
 bb2:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 bb6:	48 89 05 33 08 00 00 	mov    %rax,0x833(%rip)        # 13f0 <freep>
 bbd:	48 8b 05 2c 08 00 00 	mov    0x82c(%rip),%rax        # 13f0 <freep>
 bc4:	48 89 05 15 08 00 00 	mov    %rax,0x815(%rip)        # 13e0 <base>
    base.s.size = 0;
 bcb:	c7 05 13 08 00 00 00 	movl   $0x0,0x813(%rip)        # 13e8 <base+0x8>
 bd2:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 bd5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 bd9:	48 8b 00             	mov    (%rax),%rax
 bdc:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
 be0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 be4:	8b 40 08             	mov    0x8(%rax),%eax
 be7:	3b 45 ec             	cmp    -0x14(%rbp),%eax
 bea:	72 5f                	jb     c4b <malloc+0xcf>
      if(p->s.size == nunits)
 bec:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 bf0:	8b 40 08             	mov    0x8(%rax),%eax
 bf3:	39 45 ec             	cmp    %eax,-0x14(%rbp)
 bf6:	75 10                	jne    c08 <malloc+0x8c>
        prevp->s.ptr = p->s.ptr;
 bf8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 bfc:	48 8b 10             	mov    (%rax),%rdx
 bff:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 c03:	48 89 10             	mov    %rdx,(%rax)
 c06:	eb 2e                	jmp    c36 <malloc+0xba>
      else {
        p->s.size -= nunits;
 c08:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 c0c:	8b 40 08             	mov    0x8(%rax),%eax
 c0f:	2b 45 ec             	sub    -0x14(%rbp),%eax
 c12:	89 c2                	mov    %eax,%edx
 c14:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 c18:	89 50 08             	mov    %edx,0x8(%rax)
        p += p->s.size;
 c1b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 c1f:	8b 40 08             	mov    0x8(%rax),%eax
 c22:	89 c0                	mov    %eax,%eax
 c24:	48 c1 e0 04          	shl    $0x4,%rax
 c28:	48 01 45 f8          	add    %rax,-0x8(%rbp)
        p->s.size = nunits;
 c2c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 c30:	8b 55 ec             	mov    -0x14(%rbp),%edx
 c33:	89 50 08             	mov    %edx,0x8(%rax)
      }
      freep = prevp;
 c36:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 c3a:	48 89 05 af 07 00 00 	mov    %rax,0x7af(%rip)        # 13f0 <freep>
      return (void*)(p + 1);
 c41:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 c45:	48 83 c0 10          	add    $0x10,%rax
 c49:	eb 41                	jmp    c8c <malloc+0x110>
    }
    if(p == freep)
 c4b:	48 8b 05 9e 07 00 00 	mov    0x79e(%rip),%rax        # 13f0 <freep>
 c52:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 c56:	75 1c                	jne    c74 <malloc+0xf8>
      if((p = morecore(nunits)) == 0)
 c58:	8b 45 ec             	mov    -0x14(%rbp),%eax
 c5b:	89 c7                	mov    %eax,%edi
 c5d:	e8 b5 fe ff ff       	call   b17 <morecore>
 c62:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 c66:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
 c6b:	75 07                	jne    c74 <malloc+0xf8>
        return 0;
 c6d:	b8 00 00 00 00       	mov    $0x0,%eax
 c72:	eb 18                	jmp    c8c <malloc+0x110>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 c74:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 c78:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
 c7c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 c80:	48 8b 00             	mov    (%rax),%rax
 c83:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
 c87:	e9 54 ff ff ff       	jmp    be0 <malloc+0x64>
  }
}
 c8c:	c9                   	leave
 c8d:	c3                   	ret

0000000000000c8e <createRoot>:
#include "set.h"
#include "user.h"

//TODO: Να μην είναι περιορισμένο σε int

Set* createRoot(){
 c8e:	55                   	push   %rbp
 c8f:	48 89 e5             	mov    %rsp,%rbp
 c92:	48 83 ec 10          	sub    $0x10,%rsp
    //Αρχικοποίηση του Set
    Set *set = malloc(sizeof(Set));
 c96:	bf 10 00 00 00       	mov    $0x10,%edi
 c9b:	e8 dc fe ff ff       	call   b7c <malloc>
 ca0:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    set->size = 0;
 ca4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 ca8:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%rax)
    set->root = NULL;
 caf:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 cb3:	48 c7 00 00 00 00 00 	movq   $0x0,(%rax)
    return set;
 cba:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
 cbe:	c9                   	leave
 cbf:	c3                   	ret

0000000000000cc0 <createNode>:

void createNode(int i, Set *set){
 cc0:	55                   	push   %rbp
 cc1:	48 89 e5             	mov    %rsp,%rbp
 cc4:	48 83 ec 20          	sub    $0x20,%rsp
 cc8:	89 7d ec             	mov    %edi,-0x14(%rbp)
 ccb:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    Η συνάρτηση αυτή δημιουργεί ένα νέο SetNode με την τιμή i και εφόσον δεν υπάρχει στο Set το προσθέτει στο τέλος του συνόλου.
    Σημείωση: Ίσως υπάρχει καλύτερος τρόπος για την υλοποίηση.
    */

    //Αρχικοποίηση του SetNode
    SetNode *temp = malloc(sizeof(SetNode));
 ccf:	bf 10 00 00 00       	mov    $0x10,%edi
 cd4:	e8 a3 fe ff ff       	call   b7c <malloc>
 cd9:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    temp->i = i;
 cdd:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 ce1:	8b 55 ec             	mov    -0x14(%rbp),%edx
 ce4:	89 10                	mov    %edx,(%rax)
    temp->next = NULL;
 ce6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 cea:	48 c7 40 08 00 00 00 	movq   $0x0,0x8(%rax)
 cf1:	00 

    //Έλεγχος ύπαρξης του i
    SetNode *curr = set->root;//Ξεκινάει από την root
 cf2:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
 cf6:	48 8b 00             	mov    (%rax),%rax
 cf9:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(curr != NULL) { //Εφόσον το Set δεν είναι άδειο
 cfd:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
 d02:	74 34                	je     d38 <createNode+0x78>
        while (curr->next != NULL){ //Εφόσον υπάρχει επόμενο node
 d04:	eb 25                	jmp    d2b <createNode+0x6b>
            if (curr->i == i){ //Αν το i υπάρχει στο σύνολο
 d06:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 d0a:	8b 00                	mov    (%rax),%eax
 d0c:	39 45 ec             	cmp    %eax,-0x14(%rbp)
 d0f:	75 0e                	jne    d1f <createNode+0x5f>
                free(temp); 
 d11:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 d15:	48 89 c7             	mov    %rax,%rdi
 d18:	e8 d4 fc ff ff       	call   9f1 <free>
                return; //Δεν εκτελούμε την υπόλοιπη συνάρτηση
 d1d:	eb 4e                	jmp    d6d <createNode+0xad>
            }
            curr = curr->next; //Επόμενο SetNode
 d1f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 d23:	48 8b 40 08          	mov    0x8(%rax),%rax
 d27:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
        while (curr->next != NULL){ //Εφόσον υπάρχει επόμενο node
 d2b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 d2f:	48 8b 40 08          	mov    0x8(%rax),%rax
 d33:	48 85 c0             	test   %rax,%rax
 d36:	75 ce                	jne    d06 <createNode+0x46>
        }
    }
    /*
    Ο έλεγχος στην if είναι απαραίτητος για να ελεγχθεί το τελευταίο SetNode.
    */
    if (curr->i != i) attachNode(set, curr, temp); 
 d38:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 d3c:	8b 00                	mov    (%rax),%eax
 d3e:	39 45 ec             	cmp    %eax,-0x14(%rbp)
 d41:	74 1e                	je     d61 <createNode+0xa1>
 d43:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
 d47:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
 d4b:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
 d4f:	48 89 ce             	mov    %rcx,%rsi
 d52:	48 89 c7             	mov    %rax,%rdi
 d55:	b8 00 00 00 00       	mov    $0x0,%eax
 d5a:	e8 10 00 00 00       	call   d6f <attachNode>
 d5f:	eb 0c                	jmp    d6d <createNode+0xad>
    else free(temp);
 d61:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 d65:	48 89 c7             	mov    %rax,%rdi
 d68:	e8 84 fc ff ff       	call   9f1 <free>
}
 d6d:	c9                   	leave
 d6e:	c3                   	ret

0000000000000d6f <attachNode>:

void attachNode(Set *set, SetNode *curr, SetNode *temp){
 d6f:	55                   	push   %rbp
 d70:	48 89 e5             	mov    %rsp,%rbp
 d73:	48 83 ec 18          	sub    $0x18,%rsp
 d77:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
 d7b:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
 d7f:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
    //Βάζουμε το temp στο τέλος του Set
    if(set->size == 0) set->root = temp;
 d83:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 d87:	8b 40 08             	mov    0x8(%rax),%eax
 d8a:	85 c0                	test   %eax,%eax
 d8c:	75 0d                	jne    d9b <attachNode+0x2c>
 d8e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 d92:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
 d96:	48 89 10             	mov    %rdx,(%rax)
 d99:	eb 0c                	jmp    da7 <attachNode+0x38>
    else curr->next = temp;
 d9b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 d9f:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
 da3:	48 89 50 08          	mov    %rdx,0x8(%rax)
    set->size += 1;
 da7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 dab:	8b 40 08             	mov    0x8(%rax),%eax
 dae:	8d 50 01             	lea    0x1(%rax),%edx
 db1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 db5:	89 50 08             	mov    %edx,0x8(%rax)
}
 db8:	90                   	nop
 db9:	c9                   	leave
 dba:	c3                   	ret

0000000000000dbb <deleteSet>:

void deleteSet(Set *set){
 dbb:	55                   	push   %rbp
 dbc:	48 89 e5             	mov    %rsp,%rbp
 dbf:	48 83 ec 20          	sub    $0x20,%rsp
 dc3:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    if (set == NULL) return; //Αν ο χρήστης είναι ΜΛΚ!
 dc7:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
 dcc:	74 42                	je     e10 <deleteSet+0x55>
    SetNode *temp;
    SetNode *curr = set->root; //Ξεκινάμε από το root
 dce:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 dd2:	48 8b 00             	mov    (%rax),%rax
 dd5:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    while (curr != NULL){ 
 dd9:	eb 20                	jmp    dfb <deleteSet+0x40>
        temp = curr->next; //Αναφορά στο επόμενο SetNode
 ddb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 ddf:	48 8b 40 08          	mov    0x8(%rax),%rax
 de3:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
        free(curr); //Απελευθέρωση της curr
 de7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 deb:	48 89 c7             	mov    %rax,%rdi
 dee:	e8 fe fb ff ff       	call   9f1 <free>
        curr = temp;
 df3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 df7:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    while (curr != NULL){ 
 dfb:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
 e00:	75 d9                	jne    ddb <deleteSet+0x20>
    }
    free(set); //Διαγραφή του Set
 e02:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 e06:	48 89 c7             	mov    %rax,%rdi
 e09:	e8 e3 fb ff ff       	call   9f1 <free>
 e0e:	eb 01                	jmp    e11 <deleteSet+0x56>
    if (set == NULL) return; //Αν ο χρήστης είναι ΜΛΚ!
 e10:	90                   	nop
}
 e11:	c9                   	leave
 e12:	c3                   	ret

0000000000000e13 <getNodeAtPosition>:

SetNode* getNodeAtPosition(Set *set, int i){
 e13:	55                   	push   %rbp
 e14:	48 89 e5             	mov    %rsp,%rbp
 e17:	48 83 ec 20          	sub    $0x20,%rsp
 e1b:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
 e1f:	89 75 e4             	mov    %esi,-0x1c(%rbp)
    if (set == NULL || set->root == NULL) return NULL; //Αν ο χρήστης είναι ΜΛΚ!
 e22:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
 e27:	74 0c                	je     e35 <getNodeAtPosition+0x22>
 e29:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 e2d:	48 8b 00             	mov    (%rax),%rax
 e30:	48 85 c0             	test   %rax,%rax
 e33:	75 07                	jne    e3c <getNodeAtPosition+0x29>
 e35:	b8 00 00 00 00       	mov    $0x0,%eax
 e3a:	eb 3d                	jmp    e79 <getNodeAtPosition+0x66>

    SetNode *curr = set->root;
 e3c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 e40:	48 8b 00             	mov    (%rax),%rax
 e43:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    int n;

    for(n = 0; n<i && curr->next != NULL; n++) curr = curr->next; //Ο έλεγχος εδω είναι: n<i && curr->next != NULL
 e47:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
 e4e:	eb 10                	jmp    e60 <getNodeAtPosition+0x4d>
 e50:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 e54:	48 8b 40 08          	mov    0x8(%rax),%rax
 e58:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 e5c:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
 e60:	8b 45 f4             	mov    -0xc(%rbp),%eax
 e63:	3b 45 e4             	cmp    -0x1c(%rbp),%eax
 e66:	7d 0d                	jge    e75 <getNodeAtPosition+0x62>
 e68:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 e6c:	48 8b 40 08          	mov    0x8(%rax),%rax
 e70:	48 85 c0             	test   %rax,%rax
 e73:	75 db                	jne    e50 <getNodeAtPosition+0x3d>
    return curr;
 e75:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 e79:	c9                   	leave
 e7a:	c3                   	ret
