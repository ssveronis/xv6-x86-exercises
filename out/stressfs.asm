
fs/stressfs:     file format elf64-x86-64


Disassembly of section .text:

0000000000000000 <main>:
#include "fs.h"
#include "fcntl.h"

int
main(int argc, char *argv[])
{
   0:	55                   	push   %rbp
   1:	48 89 e5             	mov    %rsp,%rbp
   4:	48 81 ec 30 02 00 00 	sub    $0x230,%rsp
   b:	89 bd dc fd ff ff    	mov    %edi,-0x224(%rbp)
  11:	48 89 b5 d0 fd ff ff 	mov    %rsi,-0x230(%rbp)
  int fd, i;
  char path[] = "stressfs0";
  18:	48 b8 73 74 72 65 73 	movabs $0x7366737365727473,%rax
  1f:	73 66 73 
  22:	48 89 45 ee          	mov    %rax,-0x12(%rbp)
  26:	66 c7 45 f6 30 00    	movw   $0x30,-0xa(%rbp)
  char data[512];

  printf(1, "stressfs starting\n");
  2c:	48 c7 c6 ee 0d 00 00 	mov    $0xdee,%rsi
  33:	bf 01 00 00 00       	mov    $0x1,%edi
  38:	b8 00 00 00 00       	mov    $0x0,%eax
  3d:	e8 ba 05 00 00       	call   5fc <printf>
  memset(data, 'a', sizeof(data));
  42:	48 8d 85 e0 fd ff ff 	lea    -0x220(%rbp),%rax
  49:	ba 00 02 00 00       	mov    $0x200,%edx
  4e:	be 61 00 00 00       	mov    $0x61,%esi
  53:	48 89 c7             	mov    %rax,%rdi
  56:	e8 fa 01 00 00       	call   255 <memset>

  for(i = 0; i < 4; i++)
  5b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  62:	eb 0d                	jmp    71 <main+0x71>
    if(fork() > 0)
  64:	e8 d9 03 00 00       	call   442 <fork>
  69:	85 c0                	test   %eax,%eax
  6b:	7f 0c                	jg     79 <main+0x79>
  for(i = 0; i < 4; i++)
  6d:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  71:	83 7d fc 03          	cmpl   $0x3,-0x4(%rbp)
  75:	7e ed                	jle    64 <main+0x64>
  77:	eb 01                	jmp    7a <main+0x7a>
      break;
  79:	90                   	nop

  printf(1, "write %d\n", i);
  7a:	8b 45 fc             	mov    -0x4(%rbp),%eax
  7d:	89 c2                	mov    %eax,%edx
  7f:	48 c7 c6 01 0e 00 00 	mov    $0xe01,%rsi
  86:	bf 01 00 00 00       	mov    $0x1,%edi
  8b:	b8 00 00 00 00       	mov    $0x0,%eax
  90:	e8 67 05 00 00       	call   5fc <printf>

  path[8] += i;
  95:	0f b6 45 f6          	movzbl -0xa(%rbp),%eax
  99:	89 c2                	mov    %eax,%edx
  9b:	8b 45 fc             	mov    -0x4(%rbp),%eax
  9e:	01 d0                	add    %edx,%eax
  a0:	88 45 f6             	mov    %al,-0xa(%rbp)
  fd = open(path, O_CREATE | O_RDWR);
  a3:	48 8d 45 ee          	lea    -0x12(%rbp),%rax
  a7:	be 02 02 00 00       	mov    $0x202,%esi
  ac:	48 89 c7             	mov    %rax,%rdi
  af:	e8 d6 03 00 00       	call   48a <open>
  b4:	89 45 f8             	mov    %eax,-0x8(%rbp)
  for(i = 0; i < 20; i++)
  b7:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  be:	eb 1d                	jmp    dd <main+0xdd>
//    printf(fd, "%d\n", i);
    write(fd, data, sizeof(data));
  c0:	48 8d 8d e0 fd ff ff 	lea    -0x220(%rbp),%rcx
  c7:	8b 45 f8             	mov    -0x8(%rbp),%eax
  ca:	ba 00 02 00 00       	mov    $0x200,%edx
  cf:	48 89 ce             	mov    %rcx,%rsi
  d2:	89 c7                	mov    %eax,%edi
  d4:	e8 91 03 00 00       	call   46a <write>
  for(i = 0; i < 20; i++)
  d9:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  dd:	83 7d fc 13          	cmpl   $0x13,-0x4(%rbp)
  e1:	7e dd                	jle    c0 <main+0xc0>
  close(fd);
  e3:	8b 45 f8             	mov    -0x8(%rbp),%eax
  e6:	89 c7                	mov    %eax,%edi
  e8:	e8 85 03 00 00       	call   472 <close>

  printf(1, "read\n");
  ed:	48 c7 c6 0b 0e 00 00 	mov    $0xe0b,%rsi
  f4:	bf 01 00 00 00       	mov    $0x1,%edi
  f9:	b8 00 00 00 00       	mov    $0x0,%eax
  fe:	e8 f9 04 00 00       	call   5fc <printf>

  fd = open(path, O_RDONLY);
 103:	48 8d 45 ee          	lea    -0x12(%rbp),%rax
 107:	be 00 00 00 00       	mov    $0x0,%esi
 10c:	48 89 c7             	mov    %rax,%rdi
 10f:	e8 76 03 00 00       	call   48a <open>
 114:	89 45 f8             	mov    %eax,-0x8(%rbp)
  for (i = 0; i < 20; i++)
 117:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
 11e:	eb 1d                	jmp    13d <main+0x13d>
    read(fd, data, sizeof(data));
 120:	48 8d 8d e0 fd ff ff 	lea    -0x220(%rbp),%rcx
 127:	8b 45 f8             	mov    -0x8(%rbp),%eax
 12a:	ba 00 02 00 00       	mov    $0x200,%edx
 12f:	48 89 ce             	mov    %rcx,%rsi
 132:	89 c7                	mov    %eax,%edi
 134:	e8 29 03 00 00       	call   462 <read>
  for (i = 0; i < 20; i++)
 139:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
 13d:	83 7d fc 13          	cmpl   $0x13,-0x4(%rbp)
 141:	7e dd                	jle    120 <main+0x120>
  close(fd);
 143:	8b 45 f8             	mov    -0x8(%rbp),%eax
 146:	89 c7                	mov    %eax,%edi
 148:	e8 25 03 00 00       	call   472 <close>

  wait();
 14d:	e8 00 03 00 00       	call   452 <wait>
  
  exit();
 152:	e8 f3 02 00 00       	call   44a <exit>

0000000000000157 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
 157:	55                   	push   %rbp
 158:	48 89 e5             	mov    %rsp,%rbp
 15b:	48 83 ec 10          	sub    $0x10,%rsp
 15f:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
 163:	89 75 f4             	mov    %esi,-0xc(%rbp)
 166:	89 55 f0             	mov    %edx,-0x10(%rbp)
  asm volatile("cld; rep stosb" :
 169:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
 16d:	8b 55 f0             	mov    -0x10(%rbp),%edx
 170:	8b 45 f4             	mov    -0xc(%rbp),%eax
 173:	48 89 ce             	mov    %rcx,%rsi
 176:	48 89 f7             	mov    %rsi,%rdi
 179:	89 d1                	mov    %edx,%ecx
 17b:	fc                   	cld
 17c:	f3 aa                	rep stos %al,%es:(%rdi)
 17e:	89 ca                	mov    %ecx,%edx
 180:	48 89 fe             	mov    %rdi,%rsi
 183:	48 89 75 f8          	mov    %rsi,-0x8(%rbp)
 187:	89 55 f0             	mov    %edx,-0x10(%rbp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
 18a:	90                   	nop
 18b:	c9                   	leave
 18c:	c3                   	ret

000000000000018d <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 18d:	55                   	push   %rbp
 18e:	48 89 e5             	mov    %rsp,%rbp
 191:	48 83 ec 20          	sub    $0x20,%rsp
 195:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
 199:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  char *os;

  os = s;
 19d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 1a1:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  while((*s++ = *t++) != 0)
 1a5:	90                   	nop
 1a6:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
 1aa:	48 8d 42 01          	lea    0x1(%rdx),%rax
 1ae:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
 1b2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 1b6:	48 8d 48 01          	lea    0x1(%rax),%rcx
 1ba:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
 1be:	0f b6 12             	movzbl (%rdx),%edx
 1c1:	88 10                	mov    %dl,(%rax)
 1c3:	0f b6 00             	movzbl (%rax),%eax
 1c6:	84 c0                	test   %al,%al
 1c8:	75 dc                	jne    1a6 <strcpy+0x19>
    ;
  return os;
 1ca:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
 1ce:	c9                   	leave
 1cf:	c3                   	ret

00000000000001d0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 1d0:	55                   	push   %rbp
 1d1:	48 89 e5             	mov    %rsp,%rbp
 1d4:	48 83 ec 10          	sub    $0x10,%rsp
 1d8:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
 1dc:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  while(*p && *p == *q)
 1e0:	eb 0a                	jmp    1ec <strcmp+0x1c>
    p++, q++;
 1e2:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
 1e7:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  while(*p && *p == *q)
 1ec:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 1f0:	0f b6 00             	movzbl (%rax),%eax
 1f3:	84 c0                	test   %al,%al
 1f5:	74 12                	je     209 <strcmp+0x39>
 1f7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 1fb:	0f b6 10             	movzbl (%rax),%edx
 1fe:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 202:	0f b6 00             	movzbl (%rax),%eax
 205:	38 c2                	cmp    %al,%dl
 207:	74 d9                	je     1e2 <strcmp+0x12>
  return (uchar)*p - (uchar)*q;
 209:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 20d:	0f b6 00             	movzbl (%rax),%eax
 210:	0f b6 d0             	movzbl %al,%edx
 213:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 217:	0f b6 00             	movzbl (%rax),%eax
 21a:	0f b6 c0             	movzbl %al,%eax
 21d:	29 c2                	sub    %eax,%edx
 21f:	89 d0                	mov    %edx,%eax
}
 221:	c9                   	leave
 222:	c3                   	ret

0000000000000223 <strlen>:

uint
strlen(char *s)
{
 223:	55                   	push   %rbp
 224:	48 89 e5             	mov    %rsp,%rbp
 227:	48 83 ec 18          	sub    $0x18,%rsp
 22b:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  int n;

  for(n = 0; s[n]; n++)
 22f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
 236:	eb 04                	jmp    23c <strlen+0x19>
 238:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
 23c:	8b 45 fc             	mov    -0x4(%rbp),%eax
 23f:	48 63 d0             	movslq %eax,%rdx
 242:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 246:	48 01 d0             	add    %rdx,%rax
 249:	0f b6 00             	movzbl (%rax),%eax
 24c:	84 c0                	test   %al,%al
 24e:	75 e8                	jne    238 <strlen+0x15>
    ;
  return n;
 250:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
 253:	c9                   	leave
 254:	c3                   	ret

0000000000000255 <memset>:

void*
memset(void *dst, int c, uint n)
{
 255:	55                   	push   %rbp
 256:	48 89 e5             	mov    %rsp,%rbp
 259:	48 83 ec 10          	sub    $0x10,%rsp
 25d:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
 261:	89 75 f4             	mov    %esi,-0xc(%rbp)
 264:	89 55 f0             	mov    %edx,-0x10(%rbp)
  stosb(dst, c, n);
 267:	8b 55 f0             	mov    -0x10(%rbp),%edx
 26a:	8b 4d f4             	mov    -0xc(%rbp),%ecx
 26d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 271:	89 ce                	mov    %ecx,%esi
 273:	48 89 c7             	mov    %rax,%rdi
 276:	e8 dc fe ff ff       	call   157 <stosb>
  return dst;
 27b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
 27f:	c9                   	leave
 280:	c3                   	ret

0000000000000281 <strchr>:

char*
strchr(const char *s, char c)
{
 281:	55                   	push   %rbp
 282:	48 89 e5             	mov    %rsp,%rbp
 285:	48 83 ec 10          	sub    $0x10,%rsp
 289:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
 28d:	89 f0                	mov    %esi,%eax
 28f:	88 45 f4             	mov    %al,-0xc(%rbp)
  for(; *s; s++)
 292:	eb 17                	jmp    2ab <strchr+0x2a>
    if(*s == c)
 294:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 298:	0f b6 00             	movzbl (%rax),%eax
 29b:	38 45 f4             	cmp    %al,-0xc(%rbp)
 29e:	75 06                	jne    2a6 <strchr+0x25>
      return (char*)s;
 2a0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 2a4:	eb 15                	jmp    2bb <strchr+0x3a>
  for(; *s; s++)
 2a6:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
 2ab:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 2af:	0f b6 00             	movzbl (%rax),%eax
 2b2:	84 c0                	test   %al,%al
 2b4:	75 de                	jne    294 <strchr+0x13>
  return 0;
 2b6:	b8 00 00 00 00       	mov    $0x0,%eax
}
 2bb:	c9                   	leave
 2bc:	c3                   	ret

00000000000002bd <gets>:

char*
gets(char *buf, int max)
{
 2bd:	55                   	push   %rbp
 2be:	48 89 e5             	mov    %rsp,%rbp
 2c1:	48 83 ec 20          	sub    $0x20,%rsp
 2c5:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
 2c9:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 2cc:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
 2d3:	eb 48                	jmp    31d <gets+0x60>
    cc = read(0, &c, 1);
 2d5:	48 8d 45 f7          	lea    -0x9(%rbp),%rax
 2d9:	ba 01 00 00 00       	mov    $0x1,%edx
 2de:	48 89 c6             	mov    %rax,%rsi
 2e1:	bf 00 00 00 00       	mov    $0x0,%edi
 2e6:	e8 77 01 00 00       	call   462 <read>
 2eb:	89 45 f8             	mov    %eax,-0x8(%rbp)
    if(cc < 1)
 2ee:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
 2f2:	7e 36                	jle    32a <gets+0x6d>
      break;
    buf[i++] = c;
 2f4:	8b 45 fc             	mov    -0x4(%rbp),%eax
 2f7:	8d 50 01             	lea    0x1(%rax),%edx
 2fa:	89 55 fc             	mov    %edx,-0x4(%rbp)
 2fd:	48 63 d0             	movslq %eax,%rdx
 300:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 304:	48 01 c2             	add    %rax,%rdx
 307:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
 30b:	88 02                	mov    %al,(%rdx)
    if(c == '\n' || c == '\r')
 30d:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
 311:	3c 0a                	cmp    $0xa,%al
 313:	74 16                	je     32b <gets+0x6e>
 315:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
 319:	3c 0d                	cmp    $0xd,%al
 31b:	74 0e                	je     32b <gets+0x6e>
  for(i=0; i+1 < max; ){
 31d:	8b 45 fc             	mov    -0x4(%rbp),%eax
 320:	83 c0 01             	add    $0x1,%eax
 323:	39 45 e4             	cmp    %eax,-0x1c(%rbp)
 326:	7f ad                	jg     2d5 <gets+0x18>
 328:	eb 01                	jmp    32b <gets+0x6e>
      break;
 32a:	90                   	nop
      break;
  }
  buf[i] = '\0';
 32b:	8b 45 fc             	mov    -0x4(%rbp),%eax
 32e:	48 63 d0             	movslq %eax,%rdx
 331:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 335:	48 01 d0             	add    %rdx,%rax
 338:	c6 00 00             	movb   $0x0,(%rax)
  return buf;
 33b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
 33f:	c9                   	leave
 340:	c3                   	ret

0000000000000341 <stat>:

int
stat(char *n, struct stat *st)
{
 341:	55                   	push   %rbp
 342:	48 89 e5             	mov    %rsp,%rbp
 345:	48 83 ec 20          	sub    $0x20,%rsp
 349:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
 34d:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 351:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 355:	be 00 00 00 00       	mov    $0x0,%esi
 35a:	48 89 c7             	mov    %rax,%rdi
 35d:	e8 28 01 00 00       	call   48a <open>
 362:	89 45 fc             	mov    %eax,-0x4(%rbp)
  if(fd < 0)
 365:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
 369:	79 07                	jns    372 <stat+0x31>
    return -1;
 36b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 370:	eb 21                	jmp    393 <stat+0x52>
  r = fstat(fd, st);
 372:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
 376:	8b 45 fc             	mov    -0x4(%rbp),%eax
 379:	48 89 d6             	mov    %rdx,%rsi
 37c:	89 c7                	mov    %eax,%edi
 37e:	e8 1f 01 00 00       	call   4a2 <fstat>
 383:	89 45 f8             	mov    %eax,-0x8(%rbp)
  close(fd);
 386:	8b 45 fc             	mov    -0x4(%rbp),%eax
 389:	89 c7                	mov    %eax,%edi
 38b:	e8 e2 00 00 00       	call   472 <close>
  return r;
 390:	8b 45 f8             	mov    -0x8(%rbp),%eax
}
 393:	c9                   	leave
 394:	c3                   	ret

0000000000000395 <atoi>:

int
atoi(const char *s)
{
 395:	55                   	push   %rbp
 396:	48 89 e5             	mov    %rsp,%rbp
 399:	48 83 ec 18          	sub    $0x18,%rsp
 39d:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  int n;

  n = 0;
 3a1:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  while('0' <= *s && *s <= '9')
 3a8:	eb 28                	jmp    3d2 <atoi+0x3d>
    n = n*10 + *s++ - '0';
 3aa:	8b 55 fc             	mov    -0x4(%rbp),%edx
 3ad:	89 d0                	mov    %edx,%eax
 3af:	c1 e0 02             	shl    $0x2,%eax
 3b2:	01 d0                	add    %edx,%eax
 3b4:	01 c0                	add    %eax,%eax
 3b6:	89 c1                	mov    %eax,%ecx
 3b8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 3bc:	48 8d 50 01          	lea    0x1(%rax),%rdx
 3c0:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
 3c4:	0f b6 00             	movzbl (%rax),%eax
 3c7:	0f be c0             	movsbl %al,%eax
 3ca:	01 c8                	add    %ecx,%eax
 3cc:	83 e8 30             	sub    $0x30,%eax
 3cf:	89 45 fc             	mov    %eax,-0x4(%rbp)
  while('0' <= *s && *s <= '9')
 3d2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 3d6:	0f b6 00             	movzbl (%rax),%eax
 3d9:	3c 2f                	cmp    $0x2f,%al
 3db:	7e 0b                	jle    3e8 <atoi+0x53>
 3dd:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 3e1:	0f b6 00             	movzbl (%rax),%eax
 3e4:	3c 39                	cmp    $0x39,%al
 3e6:	7e c2                	jle    3aa <atoi+0x15>
  return n;
 3e8:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
 3eb:	c9                   	leave
 3ec:	c3                   	ret

00000000000003ed <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 3ed:	55                   	push   %rbp
 3ee:	48 89 e5             	mov    %rsp,%rbp
 3f1:	48 83 ec 28          	sub    $0x28,%rsp
 3f5:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
 3f9:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
 3fd:	89 55 dc             	mov    %edx,-0x24(%rbp)
  char *dst, *src;
  
  dst = vdst;
 400:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 404:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  src = vsrc;
 408:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
 40c:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  while(n-- > 0)
 410:	eb 1d                	jmp    42f <memmove+0x42>
    *dst++ = *src++;
 412:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
 416:	48 8d 42 01          	lea    0x1(%rdx),%rax
 41a:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
 41e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 422:	48 8d 48 01          	lea    0x1(%rax),%rcx
 426:	48 89 4d f8          	mov    %rcx,-0x8(%rbp)
 42a:	0f b6 12             	movzbl (%rdx),%edx
 42d:	88 10                	mov    %dl,(%rax)
  while(n-- > 0)
 42f:	8b 45 dc             	mov    -0x24(%rbp),%eax
 432:	8d 50 ff             	lea    -0x1(%rax),%edx
 435:	89 55 dc             	mov    %edx,-0x24(%rbp)
 438:	85 c0                	test   %eax,%eax
 43a:	7f d6                	jg     412 <memmove+0x25>
  return vdst;
 43c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
 440:	c9                   	leave
 441:	c3                   	ret

0000000000000442 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 442:	b8 01 00 00 00       	mov    $0x1,%eax
 447:	cd 40                	int    $0x40
 449:	c3                   	ret

000000000000044a <exit>:
SYSCALL(exit)
 44a:	b8 02 00 00 00       	mov    $0x2,%eax
 44f:	cd 40                	int    $0x40
 451:	c3                   	ret

0000000000000452 <wait>:
SYSCALL(wait)
 452:	b8 03 00 00 00       	mov    $0x3,%eax
 457:	cd 40                	int    $0x40
 459:	c3                   	ret

000000000000045a <pipe>:
SYSCALL(pipe)
 45a:	b8 04 00 00 00       	mov    $0x4,%eax
 45f:	cd 40                	int    $0x40
 461:	c3                   	ret

0000000000000462 <read>:
SYSCALL(read)
 462:	b8 05 00 00 00       	mov    $0x5,%eax
 467:	cd 40                	int    $0x40
 469:	c3                   	ret

000000000000046a <write>:
SYSCALL(write)
 46a:	b8 10 00 00 00       	mov    $0x10,%eax
 46f:	cd 40                	int    $0x40
 471:	c3                   	ret

0000000000000472 <close>:
SYSCALL(close)
 472:	b8 15 00 00 00       	mov    $0x15,%eax
 477:	cd 40                	int    $0x40
 479:	c3                   	ret

000000000000047a <kill>:
SYSCALL(kill)
 47a:	b8 06 00 00 00       	mov    $0x6,%eax
 47f:	cd 40                	int    $0x40
 481:	c3                   	ret

0000000000000482 <exec>:
SYSCALL(exec)
 482:	b8 07 00 00 00       	mov    $0x7,%eax
 487:	cd 40                	int    $0x40
 489:	c3                   	ret

000000000000048a <open>:
SYSCALL(open)
 48a:	b8 0f 00 00 00       	mov    $0xf,%eax
 48f:	cd 40                	int    $0x40
 491:	c3                   	ret

0000000000000492 <mknod>:
SYSCALL(mknod)
 492:	b8 11 00 00 00       	mov    $0x11,%eax
 497:	cd 40                	int    $0x40
 499:	c3                   	ret

000000000000049a <unlink>:
SYSCALL(unlink)
 49a:	b8 12 00 00 00       	mov    $0x12,%eax
 49f:	cd 40                	int    $0x40
 4a1:	c3                   	ret

00000000000004a2 <fstat>:
SYSCALL(fstat)
 4a2:	b8 08 00 00 00       	mov    $0x8,%eax
 4a7:	cd 40                	int    $0x40
 4a9:	c3                   	ret

00000000000004aa <link>:
SYSCALL(link)
 4aa:	b8 13 00 00 00       	mov    $0x13,%eax
 4af:	cd 40                	int    $0x40
 4b1:	c3                   	ret

00000000000004b2 <mkdir>:
SYSCALL(mkdir)
 4b2:	b8 14 00 00 00       	mov    $0x14,%eax
 4b7:	cd 40                	int    $0x40
 4b9:	c3                   	ret

00000000000004ba <chdir>:
SYSCALL(chdir)
 4ba:	b8 09 00 00 00       	mov    $0x9,%eax
 4bf:	cd 40                	int    $0x40
 4c1:	c3                   	ret

00000000000004c2 <dup>:
SYSCALL(dup)
 4c2:	b8 0a 00 00 00       	mov    $0xa,%eax
 4c7:	cd 40                	int    $0x40
 4c9:	c3                   	ret

00000000000004ca <getpid>:
SYSCALL(getpid)
 4ca:	b8 0b 00 00 00       	mov    $0xb,%eax
 4cf:	cd 40                	int    $0x40
 4d1:	c3                   	ret

00000000000004d2 <sbrk>:
SYSCALL(sbrk)
 4d2:	b8 0c 00 00 00       	mov    $0xc,%eax
 4d7:	cd 40                	int    $0x40
 4d9:	c3                   	ret

00000000000004da <sleep>:
SYSCALL(sleep)
 4da:	b8 0d 00 00 00       	mov    $0xd,%eax
 4df:	cd 40                	int    $0x40
 4e1:	c3                   	ret

00000000000004e2 <uptime>:
SYSCALL(uptime)
 4e2:	b8 0e 00 00 00       	mov    $0xe,%eax
 4e7:	cd 40                	int    $0x40
 4e9:	c3                   	ret

00000000000004ea <getpinfo>:
SYSCALL(getpinfo)
 4ea:	b8 18 00 00 00       	mov    $0x18,%eax
 4ef:	cd 40                	int    $0x40
 4f1:	c3                   	ret

00000000000004f2 <getfavnum>:
SYSCALL(getfavnum)
 4f2:	b8 19 00 00 00       	mov    $0x19,%eax
 4f7:	cd 40                	int    $0x40
 4f9:	c3                   	ret

00000000000004fa <shutdown>:
SYSCALL(shutdown)
 4fa:	b8 1a 00 00 00       	mov    $0x1a,%eax
 4ff:	cd 40                	int    $0x40
 501:	c3                   	ret

0000000000000502 <getcount>:
SYSCALL(getcount)
 502:	b8 1b 00 00 00       	mov    $0x1b,%eax
 507:	cd 40                	int    $0x40
 509:	c3                   	ret

000000000000050a <killrandom>:
 50a:	b8 1c 00 00 00       	mov    $0x1c,%eax
 50f:	cd 40                	int    $0x40
 511:	c3                   	ret

0000000000000512 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 512:	55                   	push   %rbp
 513:	48 89 e5             	mov    %rsp,%rbp
 516:	48 83 ec 10          	sub    $0x10,%rsp
 51a:	89 7d fc             	mov    %edi,-0x4(%rbp)
 51d:	89 f0                	mov    %esi,%eax
 51f:	88 45 f8             	mov    %al,-0x8(%rbp)
  write(fd, &c, 1);
 522:	48 8d 4d f8          	lea    -0x8(%rbp),%rcx
 526:	8b 45 fc             	mov    -0x4(%rbp),%eax
 529:	ba 01 00 00 00       	mov    $0x1,%edx
 52e:	48 89 ce             	mov    %rcx,%rsi
 531:	89 c7                	mov    %eax,%edi
 533:	e8 32 ff ff ff       	call   46a <write>
}
 538:	90                   	nop
 539:	c9                   	leave
 53a:	c3                   	ret

000000000000053b <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 53b:	55                   	push   %rbp
 53c:	48 89 e5             	mov    %rsp,%rbp
 53f:	48 83 ec 30          	sub    $0x30,%rsp
 543:	89 7d dc             	mov    %edi,-0x24(%rbp)
 546:	89 75 d8             	mov    %esi,-0x28(%rbp)
 549:	89 55 d4             	mov    %edx,-0x2c(%rbp)
 54c:	89 4d d0             	mov    %ecx,-0x30(%rbp)
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 54f:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
  if(sgn && xx < 0){
 556:	83 7d d0 00          	cmpl   $0x0,-0x30(%rbp)
 55a:	74 17                	je     573 <printint+0x38>
 55c:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
 560:	79 11                	jns    573 <printint+0x38>
    neg = 1;
 562:	c7 45 f8 01 00 00 00 	movl   $0x1,-0x8(%rbp)
    x = -xx;
 569:	8b 45 d8             	mov    -0x28(%rbp),%eax
 56c:	f7 d8                	neg    %eax
 56e:	89 45 f4             	mov    %eax,-0xc(%rbp)
 571:	eb 06                	jmp    579 <printint+0x3e>
  } else {
    x = xx;
 573:	8b 45 d8             	mov    -0x28(%rbp),%eax
 576:	89 45 f4             	mov    %eax,-0xc(%rbp)
  }

  i = 0;
 579:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  do{
    buf[i++] = digits[x % base];
 580:	8b 4d d4             	mov    -0x2c(%rbp),%ecx
 583:	8b 45 f4             	mov    -0xc(%rbp),%eax
 586:	ba 00 00 00 00       	mov    $0x0,%edx
 58b:	f7 f1                	div    %ecx
 58d:	89 d1                	mov    %edx,%ecx
 58f:	8b 45 fc             	mov    -0x4(%rbp),%eax
 592:	8d 50 01             	lea    0x1(%rax),%edx
 595:	89 55 fc             	mov    %edx,-0x4(%rbp)
 598:	89 ca                	mov    %ecx,%edx
 59a:	0f b6 92 f0 10 00 00 	movzbl 0x10f0(%rdx),%edx
 5a1:	48 98                	cltq
 5a3:	88 54 05 e0          	mov    %dl,-0x20(%rbp,%rax,1)
  }while((x /= base) != 0);
 5a7:	8b 75 d4             	mov    -0x2c(%rbp),%esi
 5aa:	8b 45 f4             	mov    -0xc(%rbp),%eax
 5ad:	ba 00 00 00 00       	mov    $0x0,%edx
 5b2:	f7 f6                	div    %esi
 5b4:	89 45 f4             	mov    %eax,-0xc(%rbp)
 5b7:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
 5bb:	75 c3                	jne    580 <printint+0x45>
  if(neg)
 5bd:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
 5c1:	74 2b                	je     5ee <printint+0xb3>
    buf[i++] = '-';
 5c3:	8b 45 fc             	mov    -0x4(%rbp),%eax
 5c6:	8d 50 01             	lea    0x1(%rax),%edx
 5c9:	89 55 fc             	mov    %edx,-0x4(%rbp)
 5cc:	48 98                	cltq
 5ce:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%rbp,%rax,1)

  while(--i >= 0)
 5d3:	eb 19                	jmp    5ee <printint+0xb3>
    putc(fd, buf[i]);
 5d5:	8b 45 fc             	mov    -0x4(%rbp),%eax
 5d8:	48 98                	cltq
 5da:	0f b6 44 05 e0       	movzbl -0x20(%rbp,%rax,1),%eax
 5df:	0f be d0             	movsbl %al,%edx
 5e2:	8b 45 dc             	mov    -0x24(%rbp),%eax
 5e5:	89 d6                	mov    %edx,%esi
 5e7:	89 c7                	mov    %eax,%edi
 5e9:	e8 24 ff ff ff       	call   512 <putc>
  while(--i >= 0)
 5ee:	83 6d fc 01          	subl   $0x1,-0x4(%rbp)
 5f2:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
 5f6:	79 dd                	jns    5d5 <printint+0x9a>
}
 5f8:	90                   	nop
 5f9:	90                   	nop
 5fa:	c9                   	leave
 5fb:	c3                   	ret

00000000000005fc <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 5fc:	55                   	push   %rbp
 5fd:	48 89 e5             	mov    %rsp,%rbp
 600:	48 81 ec f0 00 00 00 	sub    $0xf0,%rsp
 607:	89 bd 1c ff ff ff    	mov    %edi,-0xe4(%rbp)
 60d:	48 89 b5 10 ff ff ff 	mov    %rsi,-0xf0(%rbp)
 614:	48 89 95 60 ff ff ff 	mov    %rdx,-0xa0(%rbp)
 61b:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
 622:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
 629:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
 630:	84 c0                	test   %al,%al
 632:	74 20                	je     654 <printf+0x58>
 634:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
 638:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
 63c:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
 640:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
 644:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
 648:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
 64c:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
 650:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  va_list ap;
  char *s;
  int c, i, state;
  va_start(ap, fmt);
 654:	c7 85 20 ff ff ff 10 	movl   $0x10,-0xe0(%rbp)
 65b:	00 00 00 
 65e:	c7 85 24 ff ff ff 30 	movl   $0x30,-0xdc(%rbp)
 665:	00 00 00 
 668:	48 8d 45 10          	lea    0x10(%rbp),%rax
 66c:	48 89 85 28 ff ff ff 	mov    %rax,-0xd8(%rbp)
 673:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
 67a:	48 89 85 30 ff ff ff 	mov    %rax,-0xd0(%rbp)

  state = 0;
 681:	c7 85 40 ff ff ff 00 	movl   $0x0,-0xc0(%rbp)
 688:	00 00 00 
  for(i = 0; fmt[i]; i++){
 68b:	c7 85 44 ff ff ff 00 	movl   $0x0,-0xbc(%rbp)
 692:	00 00 00 
 695:	e9 a8 02 00 00       	jmp    942 <printf+0x346>
    c = fmt[i] & 0xff;
 69a:	8b 85 44 ff ff ff    	mov    -0xbc(%rbp),%eax
 6a0:	48 63 d0             	movslq %eax,%rdx
 6a3:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
 6aa:	48 01 d0             	add    %rdx,%rax
 6ad:	0f b6 00             	movzbl (%rax),%eax
 6b0:	0f be c0             	movsbl %al,%eax
 6b3:	25 ff 00 00 00       	and    $0xff,%eax
 6b8:	89 85 3c ff ff ff    	mov    %eax,-0xc4(%rbp)
    if(state == 0){
 6be:	83 bd 40 ff ff ff 00 	cmpl   $0x0,-0xc0(%rbp)
 6c5:	75 35                	jne    6fc <printf+0x100>
      if(c == '%'){
 6c7:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
 6ce:	75 0f                	jne    6df <printf+0xe3>
        state = '%';
 6d0:	c7 85 40 ff ff ff 25 	movl   $0x25,-0xc0(%rbp)
 6d7:	00 00 00 
 6da:	e9 5c 02 00 00       	jmp    93b <printf+0x33f>
      } else {
        putc(fd, c);
 6df:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
 6e5:	0f be d0             	movsbl %al,%edx
 6e8:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 6ee:	89 d6                	mov    %edx,%esi
 6f0:	89 c7                	mov    %eax,%edi
 6f2:	e8 1b fe ff ff       	call   512 <putc>
 6f7:	e9 3f 02 00 00       	jmp    93b <printf+0x33f>
      }
    } else if(state == '%'){
 6fc:	83 bd 40 ff ff ff 25 	cmpl   $0x25,-0xc0(%rbp)
 703:	0f 85 32 02 00 00    	jne    93b <printf+0x33f>
      if(c == 'd'){
 709:	83 bd 3c ff ff ff 64 	cmpl   $0x64,-0xc4(%rbp)
 710:	75 5e                	jne    770 <printf+0x174>
        printint(fd, va_arg(ap, int), 10, 1);
 712:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 718:	83 f8 2f             	cmp    $0x2f,%eax
 71b:	77 23                	ja     740 <printf+0x144>
 71d:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 724:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 72a:	89 d2                	mov    %edx,%edx
 72c:	48 01 d0             	add    %rdx,%rax
 72f:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 735:	83 c2 08             	add    $0x8,%edx
 738:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 73e:	eb 12                	jmp    752 <printf+0x156>
 740:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 747:	48 8d 50 08          	lea    0x8(%rax),%rdx
 74b:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 752:	8b 30                	mov    (%rax),%esi
 754:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 75a:	b9 01 00 00 00       	mov    $0x1,%ecx
 75f:	ba 0a 00 00 00       	mov    $0xa,%edx
 764:	89 c7                	mov    %eax,%edi
 766:	e8 d0 fd ff ff       	call   53b <printint>
 76b:	e9 c1 01 00 00       	jmp    931 <printf+0x335>
      } else if(c == 'x' || c == 'p'){
 770:	83 bd 3c ff ff ff 78 	cmpl   $0x78,-0xc4(%rbp)
 777:	74 09                	je     782 <printf+0x186>
 779:	83 bd 3c ff ff ff 70 	cmpl   $0x70,-0xc4(%rbp)
 780:	75 5e                	jne    7e0 <printf+0x1e4>
        printint(fd, va_arg(ap, int), 16, 0);
 782:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 788:	83 f8 2f             	cmp    $0x2f,%eax
 78b:	77 23                	ja     7b0 <printf+0x1b4>
 78d:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 794:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 79a:	89 d2                	mov    %edx,%edx
 79c:	48 01 d0             	add    %rdx,%rax
 79f:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 7a5:	83 c2 08             	add    $0x8,%edx
 7a8:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 7ae:	eb 12                	jmp    7c2 <printf+0x1c6>
 7b0:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 7b7:	48 8d 50 08          	lea    0x8(%rax),%rdx
 7bb:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 7c2:	8b 30                	mov    (%rax),%esi
 7c4:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 7ca:	b9 00 00 00 00       	mov    $0x0,%ecx
 7cf:	ba 10 00 00 00       	mov    $0x10,%edx
 7d4:	89 c7                	mov    %eax,%edi
 7d6:	e8 60 fd ff ff       	call   53b <printint>
 7db:	e9 51 01 00 00       	jmp    931 <printf+0x335>
      } else if(c == 's'){
 7e0:	83 bd 3c ff ff ff 73 	cmpl   $0x73,-0xc4(%rbp)
 7e7:	0f 85 98 00 00 00    	jne    885 <printf+0x289>
        s = va_arg(ap, char*);
 7ed:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 7f3:	83 f8 2f             	cmp    $0x2f,%eax
 7f6:	77 23                	ja     81b <printf+0x21f>
 7f8:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 7ff:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 805:	89 d2                	mov    %edx,%edx
 807:	48 01 d0             	add    %rdx,%rax
 80a:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 810:	83 c2 08             	add    $0x8,%edx
 813:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 819:	eb 12                	jmp    82d <printf+0x231>
 81b:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 822:	48 8d 50 08          	lea    0x8(%rax),%rdx
 826:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 82d:	48 8b 00             	mov    (%rax),%rax
 830:	48 89 85 48 ff ff ff 	mov    %rax,-0xb8(%rbp)
        if(s == 0)
 837:	48 83 bd 48 ff ff ff 	cmpq   $0x0,-0xb8(%rbp)
 83e:	00 
 83f:	75 31                	jne    872 <printf+0x276>
          s = "(null)";
 841:	48 c7 85 48 ff ff ff 	movq   $0xe11,-0xb8(%rbp)
 848:	11 0e 00 00 
        while(*s != 0){
 84c:	eb 24                	jmp    872 <printf+0x276>
          putc(fd, *s);
 84e:	48 8b 85 48 ff ff ff 	mov    -0xb8(%rbp),%rax
 855:	0f b6 00             	movzbl (%rax),%eax
 858:	0f be d0             	movsbl %al,%edx
 85b:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 861:	89 d6                	mov    %edx,%esi
 863:	89 c7                	mov    %eax,%edi
 865:	e8 a8 fc ff ff       	call   512 <putc>
          s++;
 86a:	48 83 85 48 ff ff ff 	addq   $0x1,-0xb8(%rbp)
 871:	01 
        while(*s != 0){
 872:	48 8b 85 48 ff ff ff 	mov    -0xb8(%rbp),%rax
 879:	0f b6 00             	movzbl (%rax),%eax
 87c:	84 c0                	test   %al,%al
 87e:	75 ce                	jne    84e <printf+0x252>
 880:	e9 ac 00 00 00       	jmp    931 <printf+0x335>
        }
      } else if(c == 'c'){
 885:	83 bd 3c ff ff ff 63 	cmpl   $0x63,-0xc4(%rbp)
 88c:	75 56                	jne    8e4 <printf+0x2e8>
        putc(fd, va_arg(ap, uint));
 88e:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 894:	83 f8 2f             	cmp    $0x2f,%eax
 897:	77 23                	ja     8bc <printf+0x2c0>
 899:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 8a0:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 8a6:	89 d2                	mov    %edx,%edx
 8a8:	48 01 d0             	add    %rdx,%rax
 8ab:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 8b1:	83 c2 08             	add    $0x8,%edx
 8b4:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 8ba:	eb 12                	jmp    8ce <printf+0x2d2>
 8bc:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 8c3:	48 8d 50 08          	lea    0x8(%rax),%rdx
 8c7:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 8ce:	8b 00                	mov    (%rax),%eax
 8d0:	0f be d0             	movsbl %al,%edx
 8d3:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 8d9:	89 d6                	mov    %edx,%esi
 8db:	89 c7                	mov    %eax,%edi
 8dd:	e8 30 fc ff ff       	call   512 <putc>
 8e2:	eb 4d                	jmp    931 <printf+0x335>
      } else if(c == '%'){
 8e4:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
 8eb:	75 1a                	jne    907 <printf+0x30b>
        putc(fd, c);
 8ed:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
 8f3:	0f be d0             	movsbl %al,%edx
 8f6:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 8fc:	89 d6                	mov    %edx,%esi
 8fe:	89 c7                	mov    %eax,%edi
 900:	e8 0d fc ff ff       	call   512 <putc>
 905:	eb 2a                	jmp    931 <printf+0x335>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 907:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 90d:	be 25 00 00 00       	mov    $0x25,%esi
 912:	89 c7                	mov    %eax,%edi
 914:	e8 f9 fb ff ff       	call   512 <putc>
        putc(fd, c);
 919:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
 91f:	0f be d0             	movsbl %al,%edx
 922:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 928:	89 d6                	mov    %edx,%esi
 92a:	89 c7                	mov    %eax,%edi
 92c:	e8 e1 fb ff ff       	call   512 <putc>
      }
      state = 0;
 931:	c7 85 40 ff ff ff 00 	movl   $0x0,-0xc0(%rbp)
 938:	00 00 00 
  for(i = 0; fmt[i]; i++){
 93b:	83 85 44 ff ff ff 01 	addl   $0x1,-0xbc(%rbp)
 942:	8b 85 44 ff ff ff    	mov    -0xbc(%rbp),%eax
 948:	48 63 d0             	movslq %eax,%rdx
 94b:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
 952:	48 01 d0             	add    %rdx,%rax
 955:	0f b6 00             	movzbl (%rax),%eax
 958:	84 c0                	test   %al,%al
 95a:	0f 85 3a fd ff ff    	jne    69a <printf+0x9e>
    }
  }
}
 960:	90                   	nop
 961:	90                   	nop
 962:	c9                   	leave
 963:	c3                   	ret

0000000000000964 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 964:	55                   	push   %rbp
 965:	48 89 e5             	mov    %rsp,%rbp
 968:	48 83 ec 18          	sub    $0x18,%rsp
 96c:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  Header *bp, *p;

  bp = (Header*)ap - 1;
 970:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 974:	48 83 e8 10          	sub    $0x10,%rax
 978:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 97c:	48 8b 05 9d 07 00 00 	mov    0x79d(%rip),%rax        # 1120 <freep>
 983:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 987:	eb 2f                	jmp    9b8 <free+0x54>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 989:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 98d:	48 8b 00             	mov    (%rax),%rax
 990:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 994:	72 17                	jb     9ad <free+0x49>
 996:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 99a:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 99e:	72 2f                	jb     9cf <free+0x6b>
 9a0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 9a4:	48 8b 00             	mov    (%rax),%rax
 9a7:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
 9ab:	72 22                	jb     9cf <free+0x6b>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 9ad:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 9b1:	48 8b 00             	mov    (%rax),%rax
 9b4:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 9b8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 9bc:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 9c0:	73 c7                	jae    989 <free+0x25>
 9c2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 9c6:	48 8b 00             	mov    (%rax),%rax
 9c9:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
 9cd:	73 ba                	jae    989 <free+0x25>
      break;
  if(bp + bp->s.size == p->s.ptr){
 9cf:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 9d3:	8b 40 08             	mov    0x8(%rax),%eax
 9d6:	89 c0                	mov    %eax,%eax
 9d8:	48 c1 e0 04          	shl    $0x4,%rax
 9dc:	48 89 c2             	mov    %rax,%rdx
 9df:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 9e3:	48 01 c2             	add    %rax,%rdx
 9e6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 9ea:	48 8b 00             	mov    (%rax),%rax
 9ed:	48 39 c2             	cmp    %rax,%rdx
 9f0:	75 2d                	jne    a1f <free+0xbb>
    bp->s.size += p->s.ptr->s.size;
 9f2:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 9f6:	8b 50 08             	mov    0x8(%rax),%edx
 9f9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 9fd:	48 8b 00             	mov    (%rax),%rax
 a00:	8b 40 08             	mov    0x8(%rax),%eax
 a03:	01 c2                	add    %eax,%edx
 a05:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 a09:	89 50 08             	mov    %edx,0x8(%rax)
    bp->s.ptr = p->s.ptr->s.ptr;
 a0c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a10:	48 8b 00             	mov    (%rax),%rax
 a13:	48 8b 10             	mov    (%rax),%rdx
 a16:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 a1a:	48 89 10             	mov    %rdx,(%rax)
 a1d:	eb 0e                	jmp    a2d <free+0xc9>
  } else
    bp->s.ptr = p->s.ptr;
 a1f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a23:	48 8b 10             	mov    (%rax),%rdx
 a26:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 a2a:	48 89 10             	mov    %rdx,(%rax)
  if(p + p->s.size == bp){
 a2d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a31:	8b 40 08             	mov    0x8(%rax),%eax
 a34:	89 c0                	mov    %eax,%eax
 a36:	48 c1 e0 04          	shl    $0x4,%rax
 a3a:	48 89 c2             	mov    %rax,%rdx
 a3d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a41:	48 01 d0             	add    %rdx,%rax
 a44:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
 a48:	75 27                	jne    a71 <free+0x10d>
    p->s.size += bp->s.size;
 a4a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a4e:	8b 50 08             	mov    0x8(%rax),%edx
 a51:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 a55:	8b 40 08             	mov    0x8(%rax),%eax
 a58:	01 c2                	add    %eax,%edx
 a5a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a5e:	89 50 08             	mov    %edx,0x8(%rax)
    p->s.ptr = bp->s.ptr;
 a61:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 a65:	48 8b 10             	mov    (%rax),%rdx
 a68:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a6c:	48 89 10             	mov    %rdx,(%rax)
 a6f:	eb 0b                	jmp    a7c <free+0x118>
  } else
    p->s.ptr = bp;
 a71:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a75:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
 a79:	48 89 10             	mov    %rdx,(%rax)
  freep = p;
 a7c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a80:	48 89 05 99 06 00 00 	mov    %rax,0x699(%rip)        # 1120 <freep>
}
 a87:	90                   	nop
 a88:	c9                   	leave
 a89:	c3                   	ret

0000000000000a8a <morecore>:

static Header*
morecore(uint nu)
{
 a8a:	55                   	push   %rbp
 a8b:	48 89 e5             	mov    %rsp,%rbp
 a8e:	48 83 ec 20          	sub    $0x20,%rsp
 a92:	89 7d ec             	mov    %edi,-0x14(%rbp)
  char *p;
  Header *hp;

  if(nu < 4096)
 a95:	81 7d ec ff 0f 00 00 	cmpl   $0xfff,-0x14(%rbp)
 a9c:	77 07                	ja     aa5 <morecore+0x1b>
    nu = 4096;
 a9e:	c7 45 ec 00 10 00 00 	movl   $0x1000,-0x14(%rbp)
  p = sbrk(nu * sizeof(Header));
 aa5:	8b 45 ec             	mov    -0x14(%rbp),%eax
 aa8:	c1 e0 04             	shl    $0x4,%eax
 aab:	89 c7                	mov    %eax,%edi
 aad:	e8 20 fa ff ff       	call   4d2 <sbrk>
 ab2:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  if(p == (char*)-1)
 ab6:	48 83 7d f8 ff       	cmpq   $0xffffffffffffffff,-0x8(%rbp)
 abb:	75 07                	jne    ac4 <morecore+0x3a>
    return 0;
 abd:	b8 00 00 00 00       	mov    $0x0,%eax
 ac2:	eb 29                	jmp    aed <morecore+0x63>
  hp = (Header*)p;
 ac4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 ac8:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  hp->s.size = nu;
 acc:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 ad0:	8b 55 ec             	mov    -0x14(%rbp),%edx
 ad3:	89 50 08             	mov    %edx,0x8(%rax)
  free((void*)(hp + 1));
 ad6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 ada:	48 83 c0 10          	add    $0x10,%rax
 ade:	48 89 c7             	mov    %rax,%rdi
 ae1:	e8 7e fe ff ff       	call   964 <free>
  return freep;
 ae6:	48 8b 05 33 06 00 00 	mov    0x633(%rip),%rax        # 1120 <freep>
}
 aed:	c9                   	leave
 aee:	c3                   	ret

0000000000000aef <malloc>:

void*
malloc(uint nbytes)
{
 aef:	55                   	push   %rbp
 af0:	48 89 e5             	mov    %rsp,%rbp
 af3:	48 83 ec 30          	sub    $0x30,%rsp
 af7:	89 7d dc             	mov    %edi,-0x24(%rbp)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 afa:	8b 45 dc             	mov    -0x24(%rbp),%eax
 afd:	48 83 c0 0f          	add    $0xf,%rax
 b01:	48 c1 e8 04          	shr    $0x4,%rax
 b05:	83 c0 01             	add    $0x1,%eax
 b08:	89 45 ec             	mov    %eax,-0x14(%rbp)
  if((prevp = freep) == 0){
 b0b:	48 8b 05 0e 06 00 00 	mov    0x60e(%rip),%rax        # 1120 <freep>
 b12:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
 b16:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
 b1b:	75 2b                	jne    b48 <malloc+0x59>
    base.s.ptr = freep = prevp = &base;
 b1d:	48 c7 45 f0 10 11 00 	movq   $0x1110,-0x10(%rbp)
 b24:	00 
 b25:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 b29:	48 89 05 f0 05 00 00 	mov    %rax,0x5f0(%rip)        # 1120 <freep>
 b30:	48 8b 05 e9 05 00 00 	mov    0x5e9(%rip),%rax        # 1120 <freep>
 b37:	48 89 05 d2 05 00 00 	mov    %rax,0x5d2(%rip)        # 1110 <base>
    base.s.size = 0;
 b3e:	c7 05 d0 05 00 00 00 	movl   $0x0,0x5d0(%rip)        # 1118 <base+0x8>
 b45:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 b48:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 b4c:	48 8b 00             	mov    (%rax),%rax
 b4f:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
 b53:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b57:	8b 40 08             	mov    0x8(%rax),%eax
 b5a:	3b 45 ec             	cmp    -0x14(%rbp),%eax
 b5d:	72 5f                	jb     bbe <malloc+0xcf>
      if(p->s.size == nunits)
 b5f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b63:	8b 40 08             	mov    0x8(%rax),%eax
 b66:	39 45 ec             	cmp    %eax,-0x14(%rbp)
 b69:	75 10                	jne    b7b <malloc+0x8c>
        prevp->s.ptr = p->s.ptr;
 b6b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b6f:	48 8b 10             	mov    (%rax),%rdx
 b72:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 b76:	48 89 10             	mov    %rdx,(%rax)
 b79:	eb 2e                	jmp    ba9 <malloc+0xba>
      else {
        p->s.size -= nunits;
 b7b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b7f:	8b 40 08             	mov    0x8(%rax),%eax
 b82:	2b 45 ec             	sub    -0x14(%rbp),%eax
 b85:	89 c2                	mov    %eax,%edx
 b87:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b8b:	89 50 08             	mov    %edx,0x8(%rax)
        p += p->s.size;
 b8e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b92:	8b 40 08             	mov    0x8(%rax),%eax
 b95:	89 c0                	mov    %eax,%eax
 b97:	48 c1 e0 04          	shl    $0x4,%rax
 b9b:	48 01 45 f8          	add    %rax,-0x8(%rbp)
        p->s.size = nunits;
 b9f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 ba3:	8b 55 ec             	mov    -0x14(%rbp),%edx
 ba6:	89 50 08             	mov    %edx,0x8(%rax)
      }
      freep = prevp;
 ba9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 bad:	48 89 05 6c 05 00 00 	mov    %rax,0x56c(%rip)        # 1120 <freep>
      return (void*)(p + 1);
 bb4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 bb8:	48 83 c0 10          	add    $0x10,%rax
 bbc:	eb 41                	jmp    bff <malloc+0x110>
    }
    if(p == freep)
 bbe:	48 8b 05 5b 05 00 00 	mov    0x55b(%rip),%rax        # 1120 <freep>
 bc5:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 bc9:	75 1c                	jne    be7 <malloc+0xf8>
      if((p = morecore(nunits)) == 0)
 bcb:	8b 45 ec             	mov    -0x14(%rbp),%eax
 bce:	89 c7                	mov    %eax,%edi
 bd0:	e8 b5 fe ff ff       	call   a8a <morecore>
 bd5:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 bd9:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
 bde:	75 07                	jne    be7 <malloc+0xf8>
        return 0;
 be0:	b8 00 00 00 00       	mov    $0x0,%eax
 be5:	eb 18                	jmp    bff <malloc+0x110>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 be7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 beb:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
 bef:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 bf3:	48 8b 00             	mov    (%rax),%rax
 bf6:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
 bfa:	e9 54 ff ff ff       	jmp    b53 <malloc+0x64>
  }
}
 bff:	c9                   	leave
 c00:	c3                   	ret

0000000000000c01 <createRoot>:
#include "set.h"
#include "user.h"

//TODO: Να μην είναι περιορισμένο σε int

Set* createRoot(){
 c01:	55                   	push   %rbp
 c02:	48 89 e5             	mov    %rsp,%rbp
 c05:	48 83 ec 10          	sub    $0x10,%rsp
    //Αρχικοποίηση του Set
    Set *set = malloc(sizeof(Set));
 c09:	bf 10 00 00 00       	mov    $0x10,%edi
 c0e:	e8 dc fe ff ff       	call   aef <malloc>
 c13:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    set->size = 0;
 c17:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 c1b:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%rax)
    set->root = NULL;
 c22:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 c26:	48 c7 00 00 00 00 00 	movq   $0x0,(%rax)
    return set;
 c2d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
 c31:	c9                   	leave
 c32:	c3                   	ret

0000000000000c33 <createNode>:

void createNode(int i, Set *set){
 c33:	55                   	push   %rbp
 c34:	48 89 e5             	mov    %rsp,%rbp
 c37:	48 83 ec 20          	sub    $0x20,%rsp
 c3b:	89 7d ec             	mov    %edi,-0x14(%rbp)
 c3e:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    Η συνάρτηση αυτή δημιουργεί ένα νέο SetNode με την τιμή i και εφόσον δεν υπάρχει στο Set το προσθέτει στο τέλος του συνόλου.
    Σημείωση: Ίσως υπάρχει καλύτερος τρόπος για την υλοποίηση.
    */

    //Αρχικοποίηση του SetNode
    SetNode *temp = malloc(sizeof(SetNode));
 c42:	bf 10 00 00 00       	mov    $0x10,%edi
 c47:	e8 a3 fe ff ff       	call   aef <malloc>
 c4c:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    temp->i = i;
 c50:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 c54:	8b 55 ec             	mov    -0x14(%rbp),%edx
 c57:	89 10                	mov    %edx,(%rax)
    temp->next = NULL;
 c59:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 c5d:	48 c7 40 08 00 00 00 	movq   $0x0,0x8(%rax)
 c64:	00 

    //Έλεγχος ύπαρξης του i
    SetNode *curr = set->root;//Ξεκινάει από την root
 c65:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
 c69:	48 8b 00             	mov    (%rax),%rax
 c6c:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(curr != NULL) { //Εφόσον το Set δεν είναι άδειο
 c70:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
 c75:	74 34                	je     cab <createNode+0x78>
        while (curr->next != NULL){ //Εφόσον υπάρχει επόμενο node
 c77:	eb 25                	jmp    c9e <createNode+0x6b>
            if (curr->i == i){ //Αν το i υπάρχει στο σύνολο
 c79:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 c7d:	8b 00                	mov    (%rax),%eax
 c7f:	39 45 ec             	cmp    %eax,-0x14(%rbp)
 c82:	75 0e                	jne    c92 <createNode+0x5f>
                free(temp); 
 c84:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 c88:	48 89 c7             	mov    %rax,%rdi
 c8b:	e8 d4 fc ff ff       	call   964 <free>
                return; //Δεν εκτελούμε την υπόλοιπη συνάρτηση
 c90:	eb 4e                	jmp    ce0 <createNode+0xad>
            }
            curr = curr->next; //Επόμενο SetNode
 c92:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 c96:	48 8b 40 08          	mov    0x8(%rax),%rax
 c9a:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
        while (curr->next != NULL){ //Εφόσον υπάρχει επόμενο node
 c9e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 ca2:	48 8b 40 08          	mov    0x8(%rax),%rax
 ca6:	48 85 c0             	test   %rax,%rax
 ca9:	75 ce                	jne    c79 <createNode+0x46>
        }
    }
    /*
    Ο έλεγχος στην if είναι απαραίτητος για να ελεγχθεί το τελευταίο SetNode.
    */
    if (curr->i != i) attachNode(set, curr, temp); 
 cab:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 caf:	8b 00                	mov    (%rax),%eax
 cb1:	39 45 ec             	cmp    %eax,-0x14(%rbp)
 cb4:	74 1e                	je     cd4 <createNode+0xa1>
 cb6:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
 cba:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
 cbe:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
 cc2:	48 89 ce             	mov    %rcx,%rsi
 cc5:	48 89 c7             	mov    %rax,%rdi
 cc8:	b8 00 00 00 00       	mov    $0x0,%eax
 ccd:	e8 10 00 00 00       	call   ce2 <attachNode>
 cd2:	eb 0c                	jmp    ce0 <createNode+0xad>
    else free(temp);
 cd4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 cd8:	48 89 c7             	mov    %rax,%rdi
 cdb:	e8 84 fc ff ff       	call   964 <free>
}
 ce0:	c9                   	leave
 ce1:	c3                   	ret

0000000000000ce2 <attachNode>:

void attachNode(Set *set, SetNode *curr, SetNode *temp){
 ce2:	55                   	push   %rbp
 ce3:	48 89 e5             	mov    %rsp,%rbp
 ce6:	48 83 ec 18          	sub    $0x18,%rsp
 cea:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
 cee:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
 cf2:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
    //Βάζουμε το temp στο τέλος του Set
    if(set->size == 0) set->root = temp;
 cf6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 cfa:	8b 40 08             	mov    0x8(%rax),%eax
 cfd:	85 c0                	test   %eax,%eax
 cff:	75 0d                	jne    d0e <attachNode+0x2c>
 d01:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 d05:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
 d09:	48 89 10             	mov    %rdx,(%rax)
 d0c:	eb 0c                	jmp    d1a <attachNode+0x38>
    else curr->next = temp;
 d0e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 d12:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
 d16:	48 89 50 08          	mov    %rdx,0x8(%rax)
    set->size += 1;
 d1a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 d1e:	8b 40 08             	mov    0x8(%rax),%eax
 d21:	8d 50 01             	lea    0x1(%rax),%edx
 d24:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 d28:	89 50 08             	mov    %edx,0x8(%rax)
}
 d2b:	90                   	nop
 d2c:	c9                   	leave
 d2d:	c3                   	ret

0000000000000d2e <deleteSet>:

void deleteSet(Set *set){
 d2e:	55                   	push   %rbp
 d2f:	48 89 e5             	mov    %rsp,%rbp
 d32:	48 83 ec 20          	sub    $0x20,%rsp
 d36:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    if (set == NULL) return; //Αν ο χρήστης είναι ΜΛΚ!
 d3a:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
 d3f:	74 42                	je     d83 <deleteSet+0x55>
    SetNode *temp;
    SetNode *curr = set->root; //Ξεκινάμε από το root
 d41:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 d45:	48 8b 00             	mov    (%rax),%rax
 d48:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    while (curr != NULL){ 
 d4c:	eb 20                	jmp    d6e <deleteSet+0x40>
        temp = curr->next; //Αναφορά στο επόμενο SetNode
 d4e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 d52:	48 8b 40 08          	mov    0x8(%rax),%rax
 d56:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
        free(curr); //Απελευθέρωση της curr
 d5a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 d5e:	48 89 c7             	mov    %rax,%rdi
 d61:	e8 fe fb ff ff       	call   964 <free>
        curr = temp;
 d66:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 d6a:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    while (curr != NULL){ 
 d6e:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
 d73:	75 d9                	jne    d4e <deleteSet+0x20>
    }
    free(set); //Διαγραφή του Set
 d75:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 d79:	48 89 c7             	mov    %rax,%rdi
 d7c:	e8 e3 fb ff ff       	call   964 <free>
 d81:	eb 01                	jmp    d84 <deleteSet+0x56>
    if (set == NULL) return; //Αν ο χρήστης είναι ΜΛΚ!
 d83:	90                   	nop
}
 d84:	c9                   	leave
 d85:	c3                   	ret

0000000000000d86 <getNodeAtPosition>:

SetNode* getNodeAtPosition(Set *set, int i){
 d86:	55                   	push   %rbp
 d87:	48 89 e5             	mov    %rsp,%rbp
 d8a:	48 83 ec 20          	sub    $0x20,%rsp
 d8e:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
 d92:	89 75 e4             	mov    %esi,-0x1c(%rbp)
    if (set == NULL || set->root == NULL) return NULL; //Αν ο χρήστης είναι ΜΛΚ!
 d95:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
 d9a:	74 0c                	je     da8 <getNodeAtPosition+0x22>
 d9c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 da0:	48 8b 00             	mov    (%rax),%rax
 da3:	48 85 c0             	test   %rax,%rax
 da6:	75 07                	jne    daf <getNodeAtPosition+0x29>
 da8:	b8 00 00 00 00       	mov    $0x0,%eax
 dad:	eb 3d                	jmp    dec <getNodeAtPosition+0x66>

    SetNode *curr = set->root;
 daf:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 db3:	48 8b 00             	mov    (%rax),%rax
 db6:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    int n;

    for(n = 0; n<i && curr->next != NULL; n++) curr = curr->next; //Ο έλεγχος εδω είναι: n<i && curr->next != NULL
 dba:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
 dc1:	eb 10                	jmp    dd3 <getNodeAtPosition+0x4d>
 dc3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 dc7:	48 8b 40 08          	mov    0x8(%rax),%rax
 dcb:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 dcf:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
 dd3:	8b 45 f4             	mov    -0xc(%rbp),%eax
 dd6:	3b 45 e4             	cmp    -0x1c(%rbp),%eax
 dd9:	7d 0d                	jge    de8 <getNodeAtPosition+0x62>
 ddb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 ddf:	48 8b 40 08          	mov    0x8(%rax),%rax
 de3:	48 85 c0             	test   %rax,%rax
 de6:	75 db                	jne    dc3 <getNodeAtPosition+0x3d>
    return curr;
 de8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 dec:	c9                   	leave
 ded:	c3                   	ret
