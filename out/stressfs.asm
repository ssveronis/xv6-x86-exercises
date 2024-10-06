
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
  2c:	48 c7 c6 e1 0b 00 00 	mov    $0xbe1,%rsi
  33:	bf 01 00 00 00       	mov    $0x1,%edi
  38:	b8 00 00 00 00       	mov    $0x0,%eax
  3d:	e8 9a 05 00 00       	call   5dc <printf>
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
  7f:	48 c7 c6 f4 0b 00 00 	mov    $0xbf4,%rsi
  86:	bf 01 00 00 00       	mov    $0x1,%edi
  8b:	b8 00 00 00 00       	mov    $0x0,%eax
  90:	e8 47 05 00 00       	call   5dc <printf>

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
  ed:	48 c7 c6 fe 0b 00 00 	mov    $0xbfe,%rsi
  f4:	bf 01 00 00 00       	mov    $0x1,%edi
  f9:	b8 00 00 00 00       	mov    $0x0,%eax
  fe:	e8 d9 04 00 00       	call   5dc <printf>

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

00000000000004f2 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 4f2:	55                   	push   %rbp
 4f3:	48 89 e5             	mov    %rsp,%rbp
 4f6:	48 83 ec 10          	sub    $0x10,%rsp
 4fa:	89 7d fc             	mov    %edi,-0x4(%rbp)
 4fd:	89 f0                	mov    %esi,%eax
 4ff:	88 45 f8             	mov    %al,-0x8(%rbp)
  write(fd, &c, 1);
 502:	48 8d 4d f8          	lea    -0x8(%rbp),%rcx
 506:	8b 45 fc             	mov    -0x4(%rbp),%eax
 509:	ba 01 00 00 00       	mov    $0x1,%edx
 50e:	48 89 ce             	mov    %rcx,%rsi
 511:	89 c7                	mov    %eax,%edi
 513:	e8 52 ff ff ff       	call   46a <write>
}
 518:	90                   	nop
 519:	c9                   	leave
 51a:	c3                   	ret

000000000000051b <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 51b:	55                   	push   %rbp
 51c:	48 89 e5             	mov    %rsp,%rbp
 51f:	48 83 ec 30          	sub    $0x30,%rsp
 523:	89 7d dc             	mov    %edi,-0x24(%rbp)
 526:	89 75 d8             	mov    %esi,-0x28(%rbp)
 529:	89 55 d4             	mov    %edx,-0x2c(%rbp)
 52c:	89 4d d0             	mov    %ecx,-0x30(%rbp)
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 52f:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
  if(sgn && xx < 0){
 536:	83 7d d0 00          	cmpl   $0x0,-0x30(%rbp)
 53a:	74 17                	je     553 <printint+0x38>
 53c:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
 540:	79 11                	jns    553 <printint+0x38>
    neg = 1;
 542:	c7 45 f8 01 00 00 00 	movl   $0x1,-0x8(%rbp)
    x = -xx;
 549:	8b 45 d8             	mov    -0x28(%rbp),%eax
 54c:	f7 d8                	neg    %eax
 54e:	89 45 f4             	mov    %eax,-0xc(%rbp)
 551:	eb 06                	jmp    559 <printint+0x3e>
  } else {
    x = xx;
 553:	8b 45 d8             	mov    -0x28(%rbp),%eax
 556:	89 45 f4             	mov    %eax,-0xc(%rbp)
  }

  i = 0;
 559:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  do{
    buf[i++] = digits[x % base];
 560:	8b 4d d4             	mov    -0x2c(%rbp),%ecx
 563:	8b 45 f4             	mov    -0xc(%rbp),%eax
 566:	ba 00 00 00 00       	mov    $0x0,%edx
 56b:	f7 f1                	div    %ecx
 56d:	89 d1                	mov    %edx,%ecx
 56f:	8b 45 fc             	mov    -0x4(%rbp),%eax
 572:	8d 50 01             	lea    0x1(%rax),%edx
 575:	89 55 fc             	mov    %edx,-0x4(%rbp)
 578:	89 ca                	mov    %ecx,%edx
 57a:	0f b6 92 50 0e 00 00 	movzbl 0xe50(%rdx),%edx
 581:	48 98                	cltq
 583:	88 54 05 e0          	mov    %dl,-0x20(%rbp,%rax,1)
  }while((x /= base) != 0);
 587:	8b 75 d4             	mov    -0x2c(%rbp),%esi
 58a:	8b 45 f4             	mov    -0xc(%rbp),%eax
 58d:	ba 00 00 00 00       	mov    $0x0,%edx
 592:	f7 f6                	div    %esi
 594:	89 45 f4             	mov    %eax,-0xc(%rbp)
 597:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
 59b:	75 c3                	jne    560 <printint+0x45>
  if(neg)
 59d:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
 5a1:	74 2b                	je     5ce <printint+0xb3>
    buf[i++] = '-';
 5a3:	8b 45 fc             	mov    -0x4(%rbp),%eax
 5a6:	8d 50 01             	lea    0x1(%rax),%edx
 5a9:	89 55 fc             	mov    %edx,-0x4(%rbp)
 5ac:	48 98                	cltq
 5ae:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%rbp,%rax,1)

  while(--i >= 0)
 5b3:	eb 19                	jmp    5ce <printint+0xb3>
    putc(fd, buf[i]);
 5b5:	8b 45 fc             	mov    -0x4(%rbp),%eax
 5b8:	48 98                	cltq
 5ba:	0f b6 44 05 e0       	movzbl -0x20(%rbp,%rax,1),%eax
 5bf:	0f be d0             	movsbl %al,%edx
 5c2:	8b 45 dc             	mov    -0x24(%rbp),%eax
 5c5:	89 d6                	mov    %edx,%esi
 5c7:	89 c7                	mov    %eax,%edi
 5c9:	e8 24 ff ff ff       	call   4f2 <putc>
  while(--i >= 0)
 5ce:	83 6d fc 01          	subl   $0x1,-0x4(%rbp)
 5d2:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
 5d6:	79 dd                	jns    5b5 <printint+0x9a>
}
 5d8:	90                   	nop
 5d9:	90                   	nop
 5da:	c9                   	leave
 5db:	c3                   	ret

00000000000005dc <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 5dc:	55                   	push   %rbp
 5dd:	48 89 e5             	mov    %rsp,%rbp
 5e0:	48 81 ec f0 00 00 00 	sub    $0xf0,%rsp
 5e7:	89 bd 1c ff ff ff    	mov    %edi,-0xe4(%rbp)
 5ed:	48 89 b5 10 ff ff ff 	mov    %rsi,-0xf0(%rbp)
 5f4:	48 89 95 60 ff ff ff 	mov    %rdx,-0xa0(%rbp)
 5fb:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
 602:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
 609:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
 610:	84 c0                	test   %al,%al
 612:	74 20                	je     634 <printf+0x58>
 614:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
 618:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
 61c:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
 620:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
 624:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
 628:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
 62c:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
 630:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  va_list ap;
  char *s;
  int c, i, state;
  va_start(ap, fmt);
 634:	c7 85 20 ff ff ff 10 	movl   $0x10,-0xe0(%rbp)
 63b:	00 00 00 
 63e:	c7 85 24 ff ff ff 30 	movl   $0x30,-0xdc(%rbp)
 645:	00 00 00 
 648:	48 8d 45 10          	lea    0x10(%rbp),%rax
 64c:	48 89 85 28 ff ff ff 	mov    %rax,-0xd8(%rbp)
 653:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
 65a:	48 89 85 30 ff ff ff 	mov    %rax,-0xd0(%rbp)

  state = 0;
 661:	c7 85 40 ff ff ff 00 	movl   $0x0,-0xc0(%rbp)
 668:	00 00 00 
  for(i = 0; fmt[i]; i++){
 66b:	c7 85 44 ff ff ff 00 	movl   $0x0,-0xbc(%rbp)
 672:	00 00 00 
 675:	e9 a8 02 00 00       	jmp    922 <printf+0x346>
    c = fmt[i] & 0xff;
 67a:	8b 85 44 ff ff ff    	mov    -0xbc(%rbp),%eax
 680:	48 63 d0             	movslq %eax,%rdx
 683:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
 68a:	48 01 d0             	add    %rdx,%rax
 68d:	0f b6 00             	movzbl (%rax),%eax
 690:	0f be c0             	movsbl %al,%eax
 693:	25 ff 00 00 00       	and    $0xff,%eax
 698:	89 85 3c ff ff ff    	mov    %eax,-0xc4(%rbp)
    if(state == 0){
 69e:	83 bd 40 ff ff ff 00 	cmpl   $0x0,-0xc0(%rbp)
 6a5:	75 35                	jne    6dc <printf+0x100>
      if(c == '%'){
 6a7:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
 6ae:	75 0f                	jne    6bf <printf+0xe3>
        state = '%';
 6b0:	c7 85 40 ff ff ff 25 	movl   $0x25,-0xc0(%rbp)
 6b7:	00 00 00 
 6ba:	e9 5c 02 00 00       	jmp    91b <printf+0x33f>
      } else {
        putc(fd, c);
 6bf:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
 6c5:	0f be d0             	movsbl %al,%edx
 6c8:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 6ce:	89 d6                	mov    %edx,%esi
 6d0:	89 c7                	mov    %eax,%edi
 6d2:	e8 1b fe ff ff       	call   4f2 <putc>
 6d7:	e9 3f 02 00 00       	jmp    91b <printf+0x33f>
      }
    } else if(state == '%'){
 6dc:	83 bd 40 ff ff ff 25 	cmpl   $0x25,-0xc0(%rbp)
 6e3:	0f 85 32 02 00 00    	jne    91b <printf+0x33f>
      if(c == 'd'){
 6e9:	83 bd 3c ff ff ff 64 	cmpl   $0x64,-0xc4(%rbp)
 6f0:	75 5e                	jne    750 <printf+0x174>
        printint(fd, va_arg(ap, int), 10, 1);
 6f2:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 6f8:	83 f8 2f             	cmp    $0x2f,%eax
 6fb:	77 23                	ja     720 <printf+0x144>
 6fd:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 704:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 70a:	89 d2                	mov    %edx,%edx
 70c:	48 01 d0             	add    %rdx,%rax
 70f:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 715:	83 c2 08             	add    $0x8,%edx
 718:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 71e:	eb 12                	jmp    732 <printf+0x156>
 720:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 727:	48 8d 50 08          	lea    0x8(%rax),%rdx
 72b:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 732:	8b 30                	mov    (%rax),%esi
 734:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 73a:	b9 01 00 00 00       	mov    $0x1,%ecx
 73f:	ba 0a 00 00 00       	mov    $0xa,%edx
 744:	89 c7                	mov    %eax,%edi
 746:	e8 d0 fd ff ff       	call   51b <printint>
 74b:	e9 c1 01 00 00       	jmp    911 <printf+0x335>
      } else if(c == 'x' || c == 'p'){
 750:	83 bd 3c ff ff ff 78 	cmpl   $0x78,-0xc4(%rbp)
 757:	74 09                	je     762 <printf+0x186>
 759:	83 bd 3c ff ff ff 70 	cmpl   $0x70,-0xc4(%rbp)
 760:	75 5e                	jne    7c0 <printf+0x1e4>
        printint(fd, va_arg(ap, int), 16, 0);
 762:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 768:	83 f8 2f             	cmp    $0x2f,%eax
 76b:	77 23                	ja     790 <printf+0x1b4>
 76d:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 774:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 77a:	89 d2                	mov    %edx,%edx
 77c:	48 01 d0             	add    %rdx,%rax
 77f:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 785:	83 c2 08             	add    $0x8,%edx
 788:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 78e:	eb 12                	jmp    7a2 <printf+0x1c6>
 790:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 797:	48 8d 50 08          	lea    0x8(%rax),%rdx
 79b:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 7a2:	8b 30                	mov    (%rax),%esi
 7a4:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 7aa:	b9 00 00 00 00       	mov    $0x0,%ecx
 7af:	ba 10 00 00 00       	mov    $0x10,%edx
 7b4:	89 c7                	mov    %eax,%edi
 7b6:	e8 60 fd ff ff       	call   51b <printint>
 7bb:	e9 51 01 00 00       	jmp    911 <printf+0x335>
      } else if(c == 's'){
 7c0:	83 bd 3c ff ff ff 73 	cmpl   $0x73,-0xc4(%rbp)
 7c7:	0f 85 98 00 00 00    	jne    865 <printf+0x289>
        s = va_arg(ap, char*);
 7cd:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 7d3:	83 f8 2f             	cmp    $0x2f,%eax
 7d6:	77 23                	ja     7fb <printf+0x21f>
 7d8:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 7df:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 7e5:	89 d2                	mov    %edx,%edx
 7e7:	48 01 d0             	add    %rdx,%rax
 7ea:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 7f0:	83 c2 08             	add    $0x8,%edx
 7f3:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 7f9:	eb 12                	jmp    80d <printf+0x231>
 7fb:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 802:	48 8d 50 08          	lea    0x8(%rax),%rdx
 806:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 80d:	48 8b 00             	mov    (%rax),%rax
 810:	48 89 85 48 ff ff ff 	mov    %rax,-0xb8(%rbp)
        if(s == 0)
 817:	48 83 bd 48 ff ff ff 	cmpq   $0x0,-0xb8(%rbp)
 81e:	00 
 81f:	75 31                	jne    852 <printf+0x276>
          s = "(null)";
 821:	48 c7 85 48 ff ff ff 	movq   $0xc04,-0xb8(%rbp)
 828:	04 0c 00 00 
        while(*s != 0){
 82c:	eb 24                	jmp    852 <printf+0x276>
          putc(fd, *s);
 82e:	48 8b 85 48 ff ff ff 	mov    -0xb8(%rbp),%rax
 835:	0f b6 00             	movzbl (%rax),%eax
 838:	0f be d0             	movsbl %al,%edx
 83b:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 841:	89 d6                	mov    %edx,%esi
 843:	89 c7                	mov    %eax,%edi
 845:	e8 a8 fc ff ff       	call   4f2 <putc>
          s++;
 84a:	48 83 85 48 ff ff ff 	addq   $0x1,-0xb8(%rbp)
 851:	01 
        while(*s != 0){
 852:	48 8b 85 48 ff ff ff 	mov    -0xb8(%rbp),%rax
 859:	0f b6 00             	movzbl (%rax),%eax
 85c:	84 c0                	test   %al,%al
 85e:	75 ce                	jne    82e <printf+0x252>
 860:	e9 ac 00 00 00       	jmp    911 <printf+0x335>
        }
      } else if(c == 'c'){
 865:	83 bd 3c ff ff ff 63 	cmpl   $0x63,-0xc4(%rbp)
 86c:	75 56                	jne    8c4 <printf+0x2e8>
        putc(fd, va_arg(ap, uint));
 86e:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 874:	83 f8 2f             	cmp    $0x2f,%eax
 877:	77 23                	ja     89c <printf+0x2c0>
 879:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 880:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 886:	89 d2                	mov    %edx,%edx
 888:	48 01 d0             	add    %rdx,%rax
 88b:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 891:	83 c2 08             	add    $0x8,%edx
 894:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 89a:	eb 12                	jmp    8ae <printf+0x2d2>
 89c:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 8a3:	48 8d 50 08          	lea    0x8(%rax),%rdx
 8a7:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 8ae:	8b 00                	mov    (%rax),%eax
 8b0:	0f be d0             	movsbl %al,%edx
 8b3:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 8b9:	89 d6                	mov    %edx,%esi
 8bb:	89 c7                	mov    %eax,%edi
 8bd:	e8 30 fc ff ff       	call   4f2 <putc>
 8c2:	eb 4d                	jmp    911 <printf+0x335>
      } else if(c == '%'){
 8c4:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
 8cb:	75 1a                	jne    8e7 <printf+0x30b>
        putc(fd, c);
 8cd:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
 8d3:	0f be d0             	movsbl %al,%edx
 8d6:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 8dc:	89 d6                	mov    %edx,%esi
 8de:	89 c7                	mov    %eax,%edi
 8e0:	e8 0d fc ff ff       	call   4f2 <putc>
 8e5:	eb 2a                	jmp    911 <printf+0x335>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 8e7:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 8ed:	be 25 00 00 00       	mov    $0x25,%esi
 8f2:	89 c7                	mov    %eax,%edi
 8f4:	e8 f9 fb ff ff       	call   4f2 <putc>
        putc(fd, c);
 8f9:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
 8ff:	0f be d0             	movsbl %al,%edx
 902:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 908:	89 d6                	mov    %edx,%esi
 90a:	89 c7                	mov    %eax,%edi
 90c:	e8 e1 fb ff ff       	call   4f2 <putc>
      }
      state = 0;
 911:	c7 85 40 ff ff ff 00 	movl   $0x0,-0xc0(%rbp)
 918:	00 00 00 
  for(i = 0; fmt[i]; i++){
 91b:	83 85 44 ff ff ff 01 	addl   $0x1,-0xbc(%rbp)
 922:	8b 85 44 ff ff ff    	mov    -0xbc(%rbp),%eax
 928:	48 63 d0             	movslq %eax,%rdx
 92b:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
 932:	48 01 d0             	add    %rdx,%rax
 935:	0f b6 00             	movzbl (%rax),%eax
 938:	84 c0                	test   %al,%al
 93a:	0f 85 3a fd ff ff    	jne    67a <printf+0x9e>
    }
  }
}
 940:	90                   	nop
 941:	90                   	nop
 942:	c9                   	leave
 943:	c3                   	ret

0000000000000944 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 944:	55                   	push   %rbp
 945:	48 89 e5             	mov    %rsp,%rbp
 948:	48 83 ec 18          	sub    $0x18,%rsp
 94c:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  Header *bp, *p;

  bp = (Header*)ap - 1;
 950:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 954:	48 83 e8 10          	sub    $0x10,%rax
 958:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 95c:	48 8b 05 1d 05 00 00 	mov    0x51d(%rip),%rax        # e80 <freep>
 963:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 967:	eb 2f                	jmp    998 <free+0x54>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 969:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 96d:	48 8b 00             	mov    (%rax),%rax
 970:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 974:	72 17                	jb     98d <free+0x49>
 976:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 97a:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 97e:	72 2f                	jb     9af <free+0x6b>
 980:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 984:	48 8b 00             	mov    (%rax),%rax
 987:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
 98b:	72 22                	jb     9af <free+0x6b>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 98d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 991:	48 8b 00             	mov    (%rax),%rax
 994:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 998:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 99c:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 9a0:	73 c7                	jae    969 <free+0x25>
 9a2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 9a6:	48 8b 00             	mov    (%rax),%rax
 9a9:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
 9ad:	73 ba                	jae    969 <free+0x25>
      break;
  if(bp + bp->s.size == p->s.ptr){
 9af:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 9b3:	8b 40 08             	mov    0x8(%rax),%eax
 9b6:	89 c0                	mov    %eax,%eax
 9b8:	48 c1 e0 04          	shl    $0x4,%rax
 9bc:	48 89 c2             	mov    %rax,%rdx
 9bf:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 9c3:	48 01 c2             	add    %rax,%rdx
 9c6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 9ca:	48 8b 00             	mov    (%rax),%rax
 9cd:	48 39 c2             	cmp    %rax,%rdx
 9d0:	75 2d                	jne    9ff <free+0xbb>
    bp->s.size += p->s.ptr->s.size;
 9d2:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 9d6:	8b 50 08             	mov    0x8(%rax),%edx
 9d9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 9dd:	48 8b 00             	mov    (%rax),%rax
 9e0:	8b 40 08             	mov    0x8(%rax),%eax
 9e3:	01 c2                	add    %eax,%edx
 9e5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 9e9:	89 50 08             	mov    %edx,0x8(%rax)
    bp->s.ptr = p->s.ptr->s.ptr;
 9ec:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 9f0:	48 8b 00             	mov    (%rax),%rax
 9f3:	48 8b 10             	mov    (%rax),%rdx
 9f6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 9fa:	48 89 10             	mov    %rdx,(%rax)
 9fd:	eb 0e                	jmp    a0d <free+0xc9>
  } else
    bp->s.ptr = p->s.ptr;
 9ff:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a03:	48 8b 10             	mov    (%rax),%rdx
 a06:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 a0a:	48 89 10             	mov    %rdx,(%rax)
  if(p + p->s.size == bp){
 a0d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a11:	8b 40 08             	mov    0x8(%rax),%eax
 a14:	89 c0                	mov    %eax,%eax
 a16:	48 c1 e0 04          	shl    $0x4,%rax
 a1a:	48 89 c2             	mov    %rax,%rdx
 a1d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a21:	48 01 d0             	add    %rdx,%rax
 a24:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
 a28:	75 27                	jne    a51 <free+0x10d>
    p->s.size += bp->s.size;
 a2a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a2e:	8b 50 08             	mov    0x8(%rax),%edx
 a31:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 a35:	8b 40 08             	mov    0x8(%rax),%eax
 a38:	01 c2                	add    %eax,%edx
 a3a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a3e:	89 50 08             	mov    %edx,0x8(%rax)
    p->s.ptr = bp->s.ptr;
 a41:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 a45:	48 8b 10             	mov    (%rax),%rdx
 a48:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a4c:	48 89 10             	mov    %rdx,(%rax)
 a4f:	eb 0b                	jmp    a5c <free+0x118>
  } else
    p->s.ptr = bp;
 a51:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a55:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
 a59:	48 89 10             	mov    %rdx,(%rax)
  freep = p;
 a5c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a60:	48 89 05 19 04 00 00 	mov    %rax,0x419(%rip)        # e80 <freep>
}
 a67:	90                   	nop
 a68:	c9                   	leave
 a69:	c3                   	ret

0000000000000a6a <morecore>:

static Header*
morecore(uint nu)
{
 a6a:	55                   	push   %rbp
 a6b:	48 89 e5             	mov    %rsp,%rbp
 a6e:	48 83 ec 20          	sub    $0x20,%rsp
 a72:	89 7d ec             	mov    %edi,-0x14(%rbp)
  char *p;
  Header *hp;

  if(nu < 4096)
 a75:	81 7d ec ff 0f 00 00 	cmpl   $0xfff,-0x14(%rbp)
 a7c:	77 07                	ja     a85 <morecore+0x1b>
    nu = 4096;
 a7e:	c7 45 ec 00 10 00 00 	movl   $0x1000,-0x14(%rbp)
  p = sbrk(nu * sizeof(Header));
 a85:	8b 45 ec             	mov    -0x14(%rbp),%eax
 a88:	c1 e0 04             	shl    $0x4,%eax
 a8b:	89 c7                	mov    %eax,%edi
 a8d:	e8 40 fa ff ff       	call   4d2 <sbrk>
 a92:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  if(p == (char*)-1)
 a96:	48 83 7d f8 ff       	cmpq   $0xffffffffffffffff,-0x8(%rbp)
 a9b:	75 07                	jne    aa4 <morecore+0x3a>
    return 0;
 a9d:	b8 00 00 00 00       	mov    $0x0,%eax
 aa2:	eb 29                	jmp    acd <morecore+0x63>
  hp = (Header*)p;
 aa4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 aa8:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  hp->s.size = nu;
 aac:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 ab0:	8b 55 ec             	mov    -0x14(%rbp),%edx
 ab3:	89 50 08             	mov    %edx,0x8(%rax)
  free((void*)(hp + 1));
 ab6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 aba:	48 83 c0 10          	add    $0x10,%rax
 abe:	48 89 c7             	mov    %rax,%rdi
 ac1:	e8 7e fe ff ff       	call   944 <free>
  return freep;
 ac6:	48 8b 05 b3 03 00 00 	mov    0x3b3(%rip),%rax        # e80 <freep>
}
 acd:	c9                   	leave
 ace:	c3                   	ret

0000000000000acf <malloc>:

void*
malloc(uint nbytes)
{
 acf:	55                   	push   %rbp
 ad0:	48 89 e5             	mov    %rsp,%rbp
 ad3:	48 83 ec 30          	sub    $0x30,%rsp
 ad7:	89 7d dc             	mov    %edi,-0x24(%rbp)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 ada:	8b 45 dc             	mov    -0x24(%rbp),%eax
 add:	48 83 c0 0f          	add    $0xf,%rax
 ae1:	48 c1 e8 04          	shr    $0x4,%rax
 ae5:	83 c0 01             	add    $0x1,%eax
 ae8:	89 45 ec             	mov    %eax,-0x14(%rbp)
  if((prevp = freep) == 0){
 aeb:	48 8b 05 8e 03 00 00 	mov    0x38e(%rip),%rax        # e80 <freep>
 af2:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
 af6:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
 afb:	75 2b                	jne    b28 <malloc+0x59>
    base.s.ptr = freep = prevp = &base;
 afd:	48 c7 45 f0 70 0e 00 	movq   $0xe70,-0x10(%rbp)
 b04:	00 
 b05:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 b09:	48 89 05 70 03 00 00 	mov    %rax,0x370(%rip)        # e80 <freep>
 b10:	48 8b 05 69 03 00 00 	mov    0x369(%rip),%rax        # e80 <freep>
 b17:	48 89 05 52 03 00 00 	mov    %rax,0x352(%rip)        # e70 <base>
    base.s.size = 0;
 b1e:	c7 05 50 03 00 00 00 	movl   $0x0,0x350(%rip)        # e78 <base+0x8>
 b25:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 b28:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 b2c:	48 8b 00             	mov    (%rax),%rax
 b2f:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
 b33:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b37:	8b 40 08             	mov    0x8(%rax),%eax
 b3a:	3b 45 ec             	cmp    -0x14(%rbp),%eax
 b3d:	72 5f                	jb     b9e <malloc+0xcf>
      if(p->s.size == nunits)
 b3f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b43:	8b 40 08             	mov    0x8(%rax),%eax
 b46:	39 45 ec             	cmp    %eax,-0x14(%rbp)
 b49:	75 10                	jne    b5b <malloc+0x8c>
        prevp->s.ptr = p->s.ptr;
 b4b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b4f:	48 8b 10             	mov    (%rax),%rdx
 b52:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 b56:	48 89 10             	mov    %rdx,(%rax)
 b59:	eb 2e                	jmp    b89 <malloc+0xba>
      else {
        p->s.size -= nunits;
 b5b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b5f:	8b 40 08             	mov    0x8(%rax),%eax
 b62:	2b 45 ec             	sub    -0x14(%rbp),%eax
 b65:	89 c2                	mov    %eax,%edx
 b67:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b6b:	89 50 08             	mov    %edx,0x8(%rax)
        p += p->s.size;
 b6e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b72:	8b 40 08             	mov    0x8(%rax),%eax
 b75:	89 c0                	mov    %eax,%eax
 b77:	48 c1 e0 04          	shl    $0x4,%rax
 b7b:	48 01 45 f8          	add    %rax,-0x8(%rbp)
        p->s.size = nunits;
 b7f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b83:	8b 55 ec             	mov    -0x14(%rbp),%edx
 b86:	89 50 08             	mov    %edx,0x8(%rax)
      }
      freep = prevp;
 b89:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 b8d:	48 89 05 ec 02 00 00 	mov    %rax,0x2ec(%rip)        # e80 <freep>
      return (void*)(p + 1);
 b94:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b98:	48 83 c0 10          	add    $0x10,%rax
 b9c:	eb 41                	jmp    bdf <malloc+0x110>
    }
    if(p == freep)
 b9e:	48 8b 05 db 02 00 00 	mov    0x2db(%rip),%rax        # e80 <freep>
 ba5:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 ba9:	75 1c                	jne    bc7 <malloc+0xf8>
      if((p = morecore(nunits)) == 0)
 bab:	8b 45 ec             	mov    -0x14(%rbp),%eax
 bae:	89 c7                	mov    %eax,%edi
 bb0:	e8 b5 fe ff ff       	call   a6a <morecore>
 bb5:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 bb9:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
 bbe:	75 07                	jne    bc7 <malloc+0xf8>
        return 0;
 bc0:	b8 00 00 00 00       	mov    $0x0,%eax
 bc5:	eb 18                	jmp    bdf <malloc+0x110>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 bc7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 bcb:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
 bcf:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 bd3:	48 8b 00             	mov    (%rax),%rax
 bd6:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
 bda:	e9 54 ff ff ff       	jmp    b33 <malloc+0x64>
  }
}
 bdf:	c9                   	leave
 be0:	c3                   	ret
