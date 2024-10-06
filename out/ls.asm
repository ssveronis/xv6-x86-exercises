
fs/ls:     file format elf64-x86-64


Disassembly of section .text:

0000000000000000 <fmtname>:
#include "user.h"
#include "fs.h"

char*
fmtname(char *path)
{
   0:	55                   	push   %rbp
   1:	48 89 e5             	mov    %rsp,%rbp
   4:	53                   	push   %rbx
   5:	48 83 ec 28          	sub    $0x28,%rsp
   9:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  static char buf[DIRSIZ+1];
  char *p;
  
  // Find first character after last slash.
  for(p=path+strlen(path); p >= path && *p != '/'; p--)
   d:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  11:	48 89 c7             	mov    %rax,%rdi
  14:	e8 58 04 00 00       	call   471 <strlen>
  19:	89 c2                	mov    %eax,%edx
  1b:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  1f:	48 01 d0             	add    %rdx,%rax
  22:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  26:	eb 05                	jmp    2d <fmtname+0x2d>
  28:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
  2d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  31:	48 3b 45 d8          	cmp    -0x28(%rbp),%rax
  35:	72 0b                	jb     42 <fmtname+0x42>
  37:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  3b:	0f b6 00             	movzbl (%rax),%eax
  3e:	3c 2f                	cmp    $0x2f,%al
  40:	75 e6                	jne    28 <fmtname+0x28>
    ;
  p++;
  42:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  
  // Return blank-padded name.
  if(strlen(p) >= DIRSIZ)
  47:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  4b:	48 89 c7             	mov    %rax,%rdi
  4e:	e8 1e 04 00 00       	call   471 <strlen>
  53:	83 f8 0d             	cmp    $0xd,%eax
  56:	76 06                	jbe    5e <fmtname+0x5e>
    return p;
  58:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  5c:	eb 60                	jmp    be <fmtname+0xbe>
  memmove(buf, p, strlen(p));
  5e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  62:	48 89 c7             	mov    %rax,%rdi
  65:	e8 07 04 00 00       	call   471 <strlen>
  6a:	89 c2                	mov    %eax,%edx
  6c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  70:	48 89 c6             	mov    %rax,%rsi
  73:	48 c7 c7 30 11 00 00 	mov    $0x1130,%rdi
  7a:	e8 bc 05 00 00       	call   63b <memmove>
  memset(buf+strlen(p), ' ', DIRSIZ-strlen(p));
  7f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  83:	48 89 c7             	mov    %rax,%rdi
  86:	e8 e6 03 00 00       	call   471 <strlen>
  8b:	ba 0e 00 00 00       	mov    $0xe,%edx
  90:	89 d3                	mov    %edx,%ebx
  92:	29 c3                	sub    %eax,%ebx
  94:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  98:	48 89 c7             	mov    %rax,%rdi
  9b:	e8 d1 03 00 00       	call   471 <strlen>
  a0:	89 c0                	mov    %eax,%eax
  a2:	48 05 30 11 00 00    	add    $0x1130,%rax
  a8:	89 da                	mov    %ebx,%edx
  aa:	be 20 00 00 00       	mov    $0x20,%esi
  af:	48 89 c7             	mov    %rax,%rdi
  b2:	e8 ec 03 00 00       	call   4a3 <memset>
  return buf;
  b7:	48 c7 c0 30 11 00 00 	mov    $0x1130,%rax
}
  be:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
  c2:	c9                   	leave
  c3:	c3                   	ret

00000000000000c4 <ls>:

void
ls(char *path)
{
  c4:	55                   	push   %rbp
  c5:	48 89 e5             	mov    %rsp,%rbp
  c8:	41 55                	push   %r13
  ca:	41 54                	push   %r12
  cc:	53                   	push   %rbx
  cd:	48 81 ec 58 02 00 00 	sub    $0x258,%rsp
  d4:	48 89 bd 98 fd ff ff 	mov    %rdi,-0x268(%rbp)
  char buf[512], *p;
  int fd;
  struct dirent de;
  struct stat st;
  
  if((fd = open(path, 0)) < 0){
  db:	48 8b 85 98 fd ff ff 	mov    -0x268(%rbp),%rax
  e2:	be 00 00 00 00       	mov    $0x0,%esi
  e7:	48 89 c7             	mov    %rax,%rdi
  ea:	e8 e9 05 00 00       	call   6d8 <open>
  ef:	89 45 dc             	mov    %eax,-0x24(%rbp)
  f2:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
  f6:	79 25                	jns    11d <ls+0x59>
    printf(2, "ls: cannot open %s\n", path);
  f8:	48 8b 85 98 fd ff ff 	mov    -0x268(%rbp),%rax
  ff:	48 89 c2             	mov    %rax,%rdx
 102:	48 c7 c6 2f 0e 00 00 	mov    $0xe2f,%rsi
 109:	bf 02 00 00 00       	mov    $0x2,%edi
 10e:	b8 00 00 00 00       	mov    $0x0,%eax
 113:	e8 12 07 00 00       	call   82a <printf>
    return;
 118:	e9 1b 02 00 00       	jmp    338 <ls+0x274>
  }
  
  if(fstat(fd, &st) < 0){
 11d:	48 8d 95 a0 fd ff ff 	lea    -0x260(%rbp),%rdx
 124:	8b 45 dc             	mov    -0x24(%rbp),%eax
 127:	48 89 d6             	mov    %rdx,%rsi
 12a:	89 c7                	mov    %eax,%edi
 12c:	e8 bf 05 00 00       	call   6f0 <fstat>
 131:	85 c0                	test   %eax,%eax
 133:	79 2f                	jns    164 <ls+0xa0>
    printf(2, "ls: cannot stat %s\n", path);
 135:	48 8b 85 98 fd ff ff 	mov    -0x268(%rbp),%rax
 13c:	48 89 c2             	mov    %rax,%rdx
 13f:	48 c7 c6 43 0e 00 00 	mov    $0xe43,%rsi
 146:	bf 02 00 00 00       	mov    $0x2,%edi
 14b:	b8 00 00 00 00       	mov    $0x0,%eax
 150:	e8 d5 06 00 00       	call   82a <printf>
    close(fd);
 155:	8b 45 dc             	mov    -0x24(%rbp),%eax
 158:	89 c7                	mov    %eax,%edi
 15a:	e8 61 05 00 00       	call   6c0 <close>
    return;
 15f:	e9 d4 01 00 00       	jmp    338 <ls+0x274>
  }
  
  switch(st.type){
 164:	0f b7 85 a0 fd ff ff 	movzwl -0x260(%rbp),%eax
 16b:	98                   	cwtl
 16c:	83 f8 01             	cmp    $0x1,%eax
 16f:	74 56                	je     1c7 <ls+0x103>
 171:	83 f8 02             	cmp    $0x2,%eax
 174:	0f 85 b4 01 00 00    	jne    32e <ls+0x26a>
  case T_FILE:
    printf(1, "%s %d %d %d\n", fmtname(path), st.type, st.ino, st.size);
 17a:	44 8b ad b0 fd ff ff 	mov    -0x250(%rbp),%r13d
 181:	44 8b a5 a8 fd ff ff 	mov    -0x258(%rbp),%r12d
 188:	0f b7 85 a0 fd ff ff 	movzwl -0x260(%rbp),%eax
 18f:	0f bf d8             	movswl %ax,%ebx
 192:	48 8b 85 98 fd ff ff 	mov    -0x268(%rbp),%rax
 199:	48 89 c7             	mov    %rax,%rdi
 19c:	e8 5f fe ff ff       	call   0 <fmtname>
 1a1:	45 89 e9             	mov    %r13d,%r9d
 1a4:	45 89 e0             	mov    %r12d,%r8d
 1a7:	89 d9                	mov    %ebx,%ecx
 1a9:	48 89 c2             	mov    %rax,%rdx
 1ac:	48 c7 c6 57 0e 00 00 	mov    $0xe57,%rsi
 1b3:	bf 01 00 00 00       	mov    $0x1,%edi
 1b8:	b8 00 00 00 00       	mov    $0x0,%eax
 1bd:	e8 68 06 00 00       	call   82a <printf>
    break;
 1c2:	e9 67 01 00 00       	jmp    32e <ls+0x26a>
  
  case T_DIR:
    if(strlen(path) + 1 + DIRSIZ + 1 > sizeof buf){
 1c7:	48 8b 85 98 fd ff ff 	mov    -0x268(%rbp),%rax
 1ce:	48 89 c7             	mov    %rax,%rdi
 1d1:	e8 9b 02 00 00       	call   471 <strlen>
 1d6:	83 c0 10             	add    $0x10,%eax
 1d9:	3d 00 02 00 00       	cmp    $0x200,%eax
 1de:	76 1b                	jbe    1fb <ls+0x137>
      printf(1, "ls: path too long\n");
 1e0:	48 c7 c6 64 0e 00 00 	mov    $0xe64,%rsi
 1e7:	bf 01 00 00 00       	mov    $0x1,%edi
 1ec:	b8 00 00 00 00       	mov    $0x0,%eax
 1f1:	e8 34 06 00 00       	call   82a <printf>
      break;
 1f6:	e9 33 01 00 00       	jmp    32e <ls+0x26a>
    }
    strcpy(buf, path);
 1fb:	48 8b 95 98 fd ff ff 	mov    -0x268(%rbp),%rdx
 202:	48 8d 85 d0 fd ff ff 	lea    -0x230(%rbp),%rax
 209:	48 89 d6             	mov    %rdx,%rsi
 20c:	48 89 c7             	mov    %rax,%rdi
 20f:	e8 c7 01 00 00       	call   3db <strcpy>
    p = buf+strlen(buf);
 214:	48 8d 85 d0 fd ff ff 	lea    -0x230(%rbp),%rax
 21b:	48 89 c7             	mov    %rax,%rdi
 21e:	e8 4e 02 00 00       	call   471 <strlen>
 223:	89 c2                	mov    %eax,%edx
 225:	48 8d 85 d0 fd ff ff 	lea    -0x230(%rbp),%rax
 22c:	48 01 d0             	add    %rdx,%rax
 22f:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
    *p++ = '/';
 233:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
 237:	48 8d 50 01          	lea    0x1(%rax),%rdx
 23b:	48 89 55 d0          	mov    %rdx,-0x30(%rbp)
 23f:	c6 00 2f             	movb   $0x2f,(%rax)
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
 242:	e9 c4 00 00 00       	jmp    30b <ls+0x247>
      if(de.inum == 0)
 247:	0f b7 85 c0 fd ff ff 	movzwl -0x240(%rbp),%eax
 24e:	66 85 c0             	test   %ax,%ax
 251:	0f 84 b3 00 00 00    	je     30a <ls+0x246>
        continue;
      memmove(p, de.name, DIRSIZ);
 257:	48 8d 85 c0 fd ff ff 	lea    -0x240(%rbp),%rax
 25e:	48 8d 48 02          	lea    0x2(%rax),%rcx
 262:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
 266:	ba 0e 00 00 00       	mov    $0xe,%edx
 26b:	48 89 ce             	mov    %rcx,%rsi
 26e:	48 89 c7             	mov    %rax,%rdi
 271:	e8 c5 03 00 00       	call   63b <memmove>
      p[DIRSIZ] = 0;
 276:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
 27a:	48 83 c0 0e          	add    $0xe,%rax
 27e:	c6 00 00             	movb   $0x0,(%rax)
      if(stat(buf, &st) < 0){
 281:	48 8d 95 a0 fd ff ff 	lea    -0x260(%rbp),%rdx
 288:	48 8d 85 d0 fd ff ff 	lea    -0x230(%rbp),%rax
 28f:	48 89 d6             	mov    %rdx,%rsi
 292:	48 89 c7             	mov    %rax,%rdi
 295:	e8 f5 02 00 00       	call   58f <stat>
 29a:	85 c0                	test   %eax,%eax
 29c:	79 22                	jns    2c0 <ls+0x1fc>
        printf(1, "ls: cannot stat %s\n", buf);
 29e:	48 8d 85 d0 fd ff ff 	lea    -0x230(%rbp),%rax
 2a5:	48 89 c2             	mov    %rax,%rdx
 2a8:	48 c7 c6 43 0e 00 00 	mov    $0xe43,%rsi
 2af:	bf 01 00 00 00       	mov    $0x1,%edi
 2b4:	b8 00 00 00 00       	mov    $0x0,%eax
 2b9:	e8 6c 05 00 00       	call   82a <printf>
        continue;
 2be:	eb 4b                	jmp    30b <ls+0x247>
      }
      printf(1, "%s %d %d %d\n", fmtname(buf), st.type, st.ino, st.size);
 2c0:	44 8b ad b0 fd ff ff 	mov    -0x250(%rbp),%r13d
 2c7:	44 8b a5 a8 fd ff ff 	mov    -0x258(%rbp),%r12d
 2ce:	0f b7 85 a0 fd ff ff 	movzwl -0x260(%rbp),%eax
 2d5:	0f bf d8             	movswl %ax,%ebx
 2d8:	48 8d 85 d0 fd ff ff 	lea    -0x230(%rbp),%rax
 2df:	48 89 c7             	mov    %rax,%rdi
 2e2:	e8 19 fd ff ff       	call   0 <fmtname>
 2e7:	45 89 e9             	mov    %r13d,%r9d
 2ea:	45 89 e0             	mov    %r12d,%r8d
 2ed:	89 d9                	mov    %ebx,%ecx
 2ef:	48 89 c2             	mov    %rax,%rdx
 2f2:	48 c7 c6 57 0e 00 00 	mov    $0xe57,%rsi
 2f9:	bf 01 00 00 00       	mov    $0x1,%edi
 2fe:	b8 00 00 00 00       	mov    $0x0,%eax
 303:	e8 22 05 00 00       	call   82a <printf>
 308:	eb 01                	jmp    30b <ls+0x247>
        continue;
 30a:	90                   	nop
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
 30b:	48 8d 8d c0 fd ff ff 	lea    -0x240(%rbp),%rcx
 312:	8b 45 dc             	mov    -0x24(%rbp),%eax
 315:	ba 10 00 00 00       	mov    $0x10,%edx
 31a:	48 89 ce             	mov    %rcx,%rsi
 31d:	89 c7                	mov    %eax,%edi
 31f:	e8 8c 03 00 00       	call   6b0 <read>
 324:	83 f8 10             	cmp    $0x10,%eax
 327:	0f 84 1a ff ff ff    	je     247 <ls+0x183>
    }
    break;
 32d:	90                   	nop
  }
  close(fd);
 32e:	8b 45 dc             	mov    -0x24(%rbp),%eax
 331:	89 c7                	mov    %eax,%edi
 333:	e8 88 03 00 00       	call   6c0 <close>
}
 338:	48 81 c4 58 02 00 00 	add    $0x258,%rsp
 33f:	5b                   	pop    %rbx
 340:	41 5c                	pop    %r12
 342:	41 5d                	pop    %r13
 344:	5d                   	pop    %rbp
 345:	c3                   	ret

0000000000000346 <main>:

int
main(int argc, char *argv[])
{
 346:	55                   	push   %rbp
 347:	48 89 e5             	mov    %rsp,%rbp
 34a:	48 83 ec 20          	sub    $0x20,%rsp
 34e:	89 7d ec             	mov    %edi,-0x14(%rbp)
 351:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  int i;

  if(argc < 2){
 355:	83 7d ec 01          	cmpl   $0x1,-0x14(%rbp)
 359:	7f 11                	jg     36c <main+0x26>
    ls(".");
 35b:	48 c7 c7 77 0e 00 00 	mov    $0xe77,%rdi
 362:	e8 5d fd ff ff       	call   c4 <ls>
    exit();
 367:	e8 2c 03 00 00       	call   698 <exit>
  }
  for(i=1; i<argc; i++)
 36c:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%rbp)
 373:	eb 23                	jmp    398 <main+0x52>
    ls(argv[i]);
 375:	8b 45 fc             	mov    -0x4(%rbp),%eax
 378:	48 98                	cltq
 37a:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
 381:	00 
 382:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
 386:	48 01 d0             	add    %rdx,%rax
 389:	48 8b 00             	mov    (%rax),%rax
 38c:	48 89 c7             	mov    %rax,%rdi
 38f:	e8 30 fd ff ff       	call   c4 <ls>
  for(i=1; i<argc; i++)
 394:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
 398:	8b 45 fc             	mov    -0x4(%rbp),%eax
 39b:	3b 45 ec             	cmp    -0x14(%rbp),%eax
 39e:	7c d5                	jl     375 <main+0x2f>
  exit();
 3a0:	e8 f3 02 00 00       	call   698 <exit>

00000000000003a5 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
 3a5:	55                   	push   %rbp
 3a6:	48 89 e5             	mov    %rsp,%rbp
 3a9:	48 83 ec 10          	sub    $0x10,%rsp
 3ad:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
 3b1:	89 75 f4             	mov    %esi,-0xc(%rbp)
 3b4:	89 55 f0             	mov    %edx,-0x10(%rbp)
  asm volatile("cld; rep stosb" :
 3b7:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
 3bb:	8b 55 f0             	mov    -0x10(%rbp),%edx
 3be:	8b 45 f4             	mov    -0xc(%rbp),%eax
 3c1:	48 89 ce             	mov    %rcx,%rsi
 3c4:	48 89 f7             	mov    %rsi,%rdi
 3c7:	89 d1                	mov    %edx,%ecx
 3c9:	fc                   	cld
 3ca:	f3 aa                	rep stos %al,%es:(%rdi)
 3cc:	89 ca                	mov    %ecx,%edx
 3ce:	48 89 fe             	mov    %rdi,%rsi
 3d1:	48 89 75 f8          	mov    %rsi,-0x8(%rbp)
 3d5:	89 55 f0             	mov    %edx,-0x10(%rbp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
 3d8:	90                   	nop
 3d9:	c9                   	leave
 3da:	c3                   	ret

00000000000003db <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 3db:	55                   	push   %rbp
 3dc:	48 89 e5             	mov    %rsp,%rbp
 3df:	48 83 ec 20          	sub    $0x20,%rsp
 3e3:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
 3e7:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  char *os;

  os = s;
 3eb:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 3ef:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  while((*s++ = *t++) != 0)
 3f3:	90                   	nop
 3f4:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
 3f8:	48 8d 42 01          	lea    0x1(%rdx),%rax
 3fc:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
 400:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 404:	48 8d 48 01          	lea    0x1(%rax),%rcx
 408:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
 40c:	0f b6 12             	movzbl (%rdx),%edx
 40f:	88 10                	mov    %dl,(%rax)
 411:	0f b6 00             	movzbl (%rax),%eax
 414:	84 c0                	test   %al,%al
 416:	75 dc                	jne    3f4 <strcpy+0x19>
    ;
  return os;
 418:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
 41c:	c9                   	leave
 41d:	c3                   	ret

000000000000041e <strcmp>:

int
strcmp(const char *p, const char *q)
{
 41e:	55                   	push   %rbp
 41f:	48 89 e5             	mov    %rsp,%rbp
 422:	48 83 ec 10          	sub    $0x10,%rsp
 426:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
 42a:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  while(*p && *p == *q)
 42e:	eb 0a                	jmp    43a <strcmp+0x1c>
    p++, q++;
 430:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
 435:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  while(*p && *p == *q)
 43a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 43e:	0f b6 00             	movzbl (%rax),%eax
 441:	84 c0                	test   %al,%al
 443:	74 12                	je     457 <strcmp+0x39>
 445:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 449:	0f b6 10             	movzbl (%rax),%edx
 44c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 450:	0f b6 00             	movzbl (%rax),%eax
 453:	38 c2                	cmp    %al,%dl
 455:	74 d9                	je     430 <strcmp+0x12>
  return (uchar)*p - (uchar)*q;
 457:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 45b:	0f b6 00             	movzbl (%rax),%eax
 45e:	0f b6 d0             	movzbl %al,%edx
 461:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 465:	0f b6 00             	movzbl (%rax),%eax
 468:	0f b6 c0             	movzbl %al,%eax
 46b:	29 c2                	sub    %eax,%edx
 46d:	89 d0                	mov    %edx,%eax
}
 46f:	c9                   	leave
 470:	c3                   	ret

0000000000000471 <strlen>:

uint
strlen(char *s)
{
 471:	55                   	push   %rbp
 472:	48 89 e5             	mov    %rsp,%rbp
 475:	48 83 ec 18          	sub    $0x18,%rsp
 479:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  int n;

  for(n = 0; s[n]; n++)
 47d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
 484:	eb 04                	jmp    48a <strlen+0x19>
 486:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
 48a:	8b 45 fc             	mov    -0x4(%rbp),%eax
 48d:	48 63 d0             	movslq %eax,%rdx
 490:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 494:	48 01 d0             	add    %rdx,%rax
 497:	0f b6 00             	movzbl (%rax),%eax
 49a:	84 c0                	test   %al,%al
 49c:	75 e8                	jne    486 <strlen+0x15>
    ;
  return n;
 49e:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
 4a1:	c9                   	leave
 4a2:	c3                   	ret

00000000000004a3 <memset>:

void*
memset(void *dst, int c, uint n)
{
 4a3:	55                   	push   %rbp
 4a4:	48 89 e5             	mov    %rsp,%rbp
 4a7:	48 83 ec 10          	sub    $0x10,%rsp
 4ab:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
 4af:	89 75 f4             	mov    %esi,-0xc(%rbp)
 4b2:	89 55 f0             	mov    %edx,-0x10(%rbp)
  stosb(dst, c, n);
 4b5:	8b 55 f0             	mov    -0x10(%rbp),%edx
 4b8:	8b 4d f4             	mov    -0xc(%rbp),%ecx
 4bb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 4bf:	89 ce                	mov    %ecx,%esi
 4c1:	48 89 c7             	mov    %rax,%rdi
 4c4:	e8 dc fe ff ff       	call   3a5 <stosb>
  return dst;
 4c9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
 4cd:	c9                   	leave
 4ce:	c3                   	ret

00000000000004cf <strchr>:

char*
strchr(const char *s, char c)
{
 4cf:	55                   	push   %rbp
 4d0:	48 89 e5             	mov    %rsp,%rbp
 4d3:	48 83 ec 10          	sub    $0x10,%rsp
 4d7:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
 4db:	89 f0                	mov    %esi,%eax
 4dd:	88 45 f4             	mov    %al,-0xc(%rbp)
  for(; *s; s++)
 4e0:	eb 17                	jmp    4f9 <strchr+0x2a>
    if(*s == c)
 4e2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 4e6:	0f b6 00             	movzbl (%rax),%eax
 4e9:	38 45 f4             	cmp    %al,-0xc(%rbp)
 4ec:	75 06                	jne    4f4 <strchr+0x25>
      return (char*)s;
 4ee:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 4f2:	eb 15                	jmp    509 <strchr+0x3a>
  for(; *s; s++)
 4f4:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
 4f9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 4fd:	0f b6 00             	movzbl (%rax),%eax
 500:	84 c0                	test   %al,%al
 502:	75 de                	jne    4e2 <strchr+0x13>
  return 0;
 504:	b8 00 00 00 00       	mov    $0x0,%eax
}
 509:	c9                   	leave
 50a:	c3                   	ret

000000000000050b <gets>:

char*
gets(char *buf, int max)
{
 50b:	55                   	push   %rbp
 50c:	48 89 e5             	mov    %rsp,%rbp
 50f:	48 83 ec 20          	sub    $0x20,%rsp
 513:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
 517:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 51a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
 521:	eb 48                	jmp    56b <gets+0x60>
    cc = read(0, &c, 1);
 523:	48 8d 45 f7          	lea    -0x9(%rbp),%rax
 527:	ba 01 00 00 00       	mov    $0x1,%edx
 52c:	48 89 c6             	mov    %rax,%rsi
 52f:	bf 00 00 00 00       	mov    $0x0,%edi
 534:	e8 77 01 00 00       	call   6b0 <read>
 539:	89 45 f8             	mov    %eax,-0x8(%rbp)
    if(cc < 1)
 53c:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
 540:	7e 36                	jle    578 <gets+0x6d>
      break;
    buf[i++] = c;
 542:	8b 45 fc             	mov    -0x4(%rbp),%eax
 545:	8d 50 01             	lea    0x1(%rax),%edx
 548:	89 55 fc             	mov    %edx,-0x4(%rbp)
 54b:	48 63 d0             	movslq %eax,%rdx
 54e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 552:	48 01 c2             	add    %rax,%rdx
 555:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
 559:	88 02                	mov    %al,(%rdx)
    if(c == '\n' || c == '\r')
 55b:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
 55f:	3c 0a                	cmp    $0xa,%al
 561:	74 16                	je     579 <gets+0x6e>
 563:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
 567:	3c 0d                	cmp    $0xd,%al
 569:	74 0e                	je     579 <gets+0x6e>
  for(i=0; i+1 < max; ){
 56b:	8b 45 fc             	mov    -0x4(%rbp),%eax
 56e:	83 c0 01             	add    $0x1,%eax
 571:	39 45 e4             	cmp    %eax,-0x1c(%rbp)
 574:	7f ad                	jg     523 <gets+0x18>
 576:	eb 01                	jmp    579 <gets+0x6e>
      break;
 578:	90                   	nop
      break;
  }
  buf[i] = '\0';
 579:	8b 45 fc             	mov    -0x4(%rbp),%eax
 57c:	48 63 d0             	movslq %eax,%rdx
 57f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 583:	48 01 d0             	add    %rdx,%rax
 586:	c6 00 00             	movb   $0x0,(%rax)
  return buf;
 589:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
 58d:	c9                   	leave
 58e:	c3                   	ret

000000000000058f <stat>:

int
stat(char *n, struct stat *st)
{
 58f:	55                   	push   %rbp
 590:	48 89 e5             	mov    %rsp,%rbp
 593:	48 83 ec 20          	sub    $0x20,%rsp
 597:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
 59b:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 59f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 5a3:	be 00 00 00 00       	mov    $0x0,%esi
 5a8:	48 89 c7             	mov    %rax,%rdi
 5ab:	e8 28 01 00 00       	call   6d8 <open>
 5b0:	89 45 fc             	mov    %eax,-0x4(%rbp)
  if(fd < 0)
 5b3:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
 5b7:	79 07                	jns    5c0 <stat+0x31>
    return -1;
 5b9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 5be:	eb 21                	jmp    5e1 <stat+0x52>
  r = fstat(fd, st);
 5c0:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
 5c4:	8b 45 fc             	mov    -0x4(%rbp),%eax
 5c7:	48 89 d6             	mov    %rdx,%rsi
 5ca:	89 c7                	mov    %eax,%edi
 5cc:	e8 1f 01 00 00       	call   6f0 <fstat>
 5d1:	89 45 f8             	mov    %eax,-0x8(%rbp)
  close(fd);
 5d4:	8b 45 fc             	mov    -0x4(%rbp),%eax
 5d7:	89 c7                	mov    %eax,%edi
 5d9:	e8 e2 00 00 00       	call   6c0 <close>
  return r;
 5de:	8b 45 f8             	mov    -0x8(%rbp),%eax
}
 5e1:	c9                   	leave
 5e2:	c3                   	ret

00000000000005e3 <atoi>:

int
atoi(const char *s)
{
 5e3:	55                   	push   %rbp
 5e4:	48 89 e5             	mov    %rsp,%rbp
 5e7:	48 83 ec 18          	sub    $0x18,%rsp
 5eb:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  int n;

  n = 0;
 5ef:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  while('0' <= *s && *s <= '9')
 5f6:	eb 28                	jmp    620 <atoi+0x3d>
    n = n*10 + *s++ - '0';
 5f8:	8b 55 fc             	mov    -0x4(%rbp),%edx
 5fb:	89 d0                	mov    %edx,%eax
 5fd:	c1 e0 02             	shl    $0x2,%eax
 600:	01 d0                	add    %edx,%eax
 602:	01 c0                	add    %eax,%eax
 604:	89 c1                	mov    %eax,%ecx
 606:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 60a:	48 8d 50 01          	lea    0x1(%rax),%rdx
 60e:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
 612:	0f b6 00             	movzbl (%rax),%eax
 615:	0f be c0             	movsbl %al,%eax
 618:	01 c8                	add    %ecx,%eax
 61a:	83 e8 30             	sub    $0x30,%eax
 61d:	89 45 fc             	mov    %eax,-0x4(%rbp)
  while('0' <= *s && *s <= '9')
 620:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 624:	0f b6 00             	movzbl (%rax),%eax
 627:	3c 2f                	cmp    $0x2f,%al
 629:	7e 0b                	jle    636 <atoi+0x53>
 62b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 62f:	0f b6 00             	movzbl (%rax),%eax
 632:	3c 39                	cmp    $0x39,%al
 634:	7e c2                	jle    5f8 <atoi+0x15>
  return n;
 636:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
 639:	c9                   	leave
 63a:	c3                   	ret

000000000000063b <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 63b:	55                   	push   %rbp
 63c:	48 89 e5             	mov    %rsp,%rbp
 63f:	48 83 ec 28          	sub    $0x28,%rsp
 643:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
 647:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
 64b:	89 55 dc             	mov    %edx,-0x24(%rbp)
  char *dst, *src;
  
  dst = vdst;
 64e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 652:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  src = vsrc;
 656:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
 65a:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  while(n-- > 0)
 65e:	eb 1d                	jmp    67d <memmove+0x42>
    *dst++ = *src++;
 660:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
 664:	48 8d 42 01          	lea    0x1(%rdx),%rax
 668:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
 66c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 670:	48 8d 48 01          	lea    0x1(%rax),%rcx
 674:	48 89 4d f8          	mov    %rcx,-0x8(%rbp)
 678:	0f b6 12             	movzbl (%rdx),%edx
 67b:	88 10                	mov    %dl,(%rax)
  while(n-- > 0)
 67d:	8b 45 dc             	mov    -0x24(%rbp),%eax
 680:	8d 50 ff             	lea    -0x1(%rax),%edx
 683:	89 55 dc             	mov    %edx,-0x24(%rbp)
 686:	85 c0                	test   %eax,%eax
 688:	7f d6                	jg     660 <memmove+0x25>
  return vdst;
 68a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
 68e:	c9                   	leave
 68f:	c3                   	ret

0000000000000690 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 690:	b8 01 00 00 00       	mov    $0x1,%eax
 695:	cd 40                	int    $0x40
 697:	c3                   	ret

0000000000000698 <exit>:
SYSCALL(exit)
 698:	b8 02 00 00 00       	mov    $0x2,%eax
 69d:	cd 40                	int    $0x40
 69f:	c3                   	ret

00000000000006a0 <wait>:
SYSCALL(wait)
 6a0:	b8 03 00 00 00       	mov    $0x3,%eax
 6a5:	cd 40                	int    $0x40
 6a7:	c3                   	ret

00000000000006a8 <pipe>:
SYSCALL(pipe)
 6a8:	b8 04 00 00 00       	mov    $0x4,%eax
 6ad:	cd 40                	int    $0x40
 6af:	c3                   	ret

00000000000006b0 <read>:
SYSCALL(read)
 6b0:	b8 05 00 00 00       	mov    $0x5,%eax
 6b5:	cd 40                	int    $0x40
 6b7:	c3                   	ret

00000000000006b8 <write>:
SYSCALL(write)
 6b8:	b8 10 00 00 00       	mov    $0x10,%eax
 6bd:	cd 40                	int    $0x40
 6bf:	c3                   	ret

00000000000006c0 <close>:
SYSCALL(close)
 6c0:	b8 15 00 00 00       	mov    $0x15,%eax
 6c5:	cd 40                	int    $0x40
 6c7:	c3                   	ret

00000000000006c8 <kill>:
SYSCALL(kill)
 6c8:	b8 06 00 00 00       	mov    $0x6,%eax
 6cd:	cd 40                	int    $0x40
 6cf:	c3                   	ret

00000000000006d0 <exec>:
SYSCALL(exec)
 6d0:	b8 07 00 00 00       	mov    $0x7,%eax
 6d5:	cd 40                	int    $0x40
 6d7:	c3                   	ret

00000000000006d8 <open>:
SYSCALL(open)
 6d8:	b8 0f 00 00 00       	mov    $0xf,%eax
 6dd:	cd 40                	int    $0x40
 6df:	c3                   	ret

00000000000006e0 <mknod>:
SYSCALL(mknod)
 6e0:	b8 11 00 00 00       	mov    $0x11,%eax
 6e5:	cd 40                	int    $0x40
 6e7:	c3                   	ret

00000000000006e8 <unlink>:
SYSCALL(unlink)
 6e8:	b8 12 00 00 00       	mov    $0x12,%eax
 6ed:	cd 40                	int    $0x40
 6ef:	c3                   	ret

00000000000006f0 <fstat>:
SYSCALL(fstat)
 6f0:	b8 08 00 00 00       	mov    $0x8,%eax
 6f5:	cd 40                	int    $0x40
 6f7:	c3                   	ret

00000000000006f8 <link>:
SYSCALL(link)
 6f8:	b8 13 00 00 00       	mov    $0x13,%eax
 6fd:	cd 40                	int    $0x40
 6ff:	c3                   	ret

0000000000000700 <mkdir>:
SYSCALL(mkdir)
 700:	b8 14 00 00 00       	mov    $0x14,%eax
 705:	cd 40                	int    $0x40
 707:	c3                   	ret

0000000000000708 <chdir>:
SYSCALL(chdir)
 708:	b8 09 00 00 00       	mov    $0x9,%eax
 70d:	cd 40                	int    $0x40
 70f:	c3                   	ret

0000000000000710 <dup>:
SYSCALL(dup)
 710:	b8 0a 00 00 00       	mov    $0xa,%eax
 715:	cd 40                	int    $0x40
 717:	c3                   	ret

0000000000000718 <getpid>:
SYSCALL(getpid)
 718:	b8 0b 00 00 00       	mov    $0xb,%eax
 71d:	cd 40                	int    $0x40
 71f:	c3                   	ret

0000000000000720 <sbrk>:
SYSCALL(sbrk)
 720:	b8 0c 00 00 00       	mov    $0xc,%eax
 725:	cd 40                	int    $0x40
 727:	c3                   	ret

0000000000000728 <sleep>:
SYSCALL(sleep)
 728:	b8 0d 00 00 00       	mov    $0xd,%eax
 72d:	cd 40                	int    $0x40
 72f:	c3                   	ret

0000000000000730 <uptime>:
SYSCALL(uptime)
 730:	b8 0e 00 00 00       	mov    $0xe,%eax
 735:	cd 40                	int    $0x40
 737:	c3                   	ret

0000000000000738 <getpinfo>:
SYSCALL(getpinfo)
 738:	b8 18 00 00 00       	mov    $0x18,%eax
 73d:	cd 40                	int    $0x40
 73f:	c3                   	ret

0000000000000740 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 740:	55                   	push   %rbp
 741:	48 89 e5             	mov    %rsp,%rbp
 744:	48 83 ec 10          	sub    $0x10,%rsp
 748:	89 7d fc             	mov    %edi,-0x4(%rbp)
 74b:	89 f0                	mov    %esi,%eax
 74d:	88 45 f8             	mov    %al,-0x8(%rbp)
  write(fd, &c, 1);
 750:	48 8d 4d f8          	lea    -0x8(%rbp),%rcx
 754:	8b 45 fc             	mov    -0x4(%rbp),%eax
 757:	ba 01 00 00 00       	mov    $0x1,%edx
 75c:	48 89 ce             	mov    %rcx,%rsi
 75f:	89 c7                	mov    %eax,%edi
 761:	e8 52 ff ff ff       	call   6b8 <write>
}
 766:	90                   	nop
 767:	c9                   	leave
 768:	c3                   	ret

0000000000000769 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 769:	55                   	push   %rbp
 76a:	48 89 e5             	mov    %rsp,%rbp
 76d:	48 83 ec 30          	sub    $0x30,%rsp
 771:	89 7d dc             	mov    %edi,-0x24(%rbp)
 774:	89 75 d8             	mov    %esi,-0x28(%rbp)
 777:	89 55 d4             	mov    %edx,-0x2c(%rbp)
 77a:	89 4d d0             	mov    %ecx,-0x30(%rbp)
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 77d:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
  if(sgn && xx < 0){
 784:	83 7d d0 00          	cmpl   $0x0,-0x30(%rbp)
 788:	74 17                	je     7a1 <printint+0x38>
 78a:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
 78e:	79 11                	jns    7a1 <printint+0x38>
    neg = 1;
 790:	c7 45 f8 01 00 00 00 	movl   $0x1,-0x8(%rbp)
    x = -xx;
 797:	8b 45 d8             	mov    -0x28(%rbp),%eax
 79a:	f7 d8                	neg    %eax
 79c:	89 45 f4             	mov    %eax,-0xc(%rbp)
 79f:	eb 06                	jmp    7a7 <printint+0x3e>
  } else {
    x = xx;
 7a1:	8b 45 d8             	mov    -0x28(%rbp),%eax
 7a4:	89 45 f4             	mov    %eax,-0xc(%rbp)
  }

  i = 0;
 7a7:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  do{
    buf[i++] = digits[x % base];
 7ae:	8b 4d d4             	mov    -0x2c(%rbp),%ecx
 7b1:	8b 45 f4             	mov    -0xc(%rbp),%eax
 7b4:	ba 00 00 00 00       	mov    $0x0,%edx
 7b9:	f7 f1                	div    %ecx
 7bb:	89 d1                	mov    %edx,%ecx
 7bd:	8b 45 fc             	mov    -0x4(%rbp),%eax
 7c0:	8d 50 01             	lea    0x1(%rax),%edx
 7c3:	89 55 fc             	mov    %edx,-0x4(%rbp)
 7c6:	89 ca                	mov    %ecx,%edx
 7c8:	0f b6 92 10 11 00 00 	movzbl 0x1110(%rdx),%edx
 7cf:	48 98                	cltq
 7d1:	88 54 05 e0          	mov    %dl,-0x20(%rbp,%rax,1)
  }while((x /= base) != 0);
 7d5:	8b 75 d4             	mov    -0x2c(%rbp),%esi
 7d8:	8b 45 f4             	mov    -0xc(%rbp),%eax
 7db:	ba 00 00 00 00       	mov    $0x0,%edx
 7e0:	f7 f6                	div    %esi
 7e2:	89 45 f4             	mov    %eax,-0xc(%rbp)
 7e5:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
 7e9:	75 c3                	jne    7ae <printint+0x45>
  if(neg)
 7eb:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
 7ef:	74 2b                	je     81c <printint+0xb3>
    buf[i++] = '-';
 7f1:	8b 45 fc             	mov    -0x4(%rbp),%eax
 7f4:	8d 50 01             	lea    0x1(%rax),%edx
 7f7:	89 55 fc             	mov    %edx,-0x4(%rbp)
 7fa:	48 98                	cltq
 7fc:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%rbp,%rax,1)

  while(--i >= 0)
 801:	eb 19                	jmp    81c <printint+0xb3>
    putc(fd, buf[i]);
 803:	8b 45 fc             	mov    -0x4(%rbp),%eax
 806:	48 98                	cltq
 808:	0f b6 44 05 e0       	movzbl -0x20(%rbp,%rax,1),%eax
 80d:	0f be d0             	movsbl %al,%edx
 810:	8b 45 dc             	mov    -0x24(%rbp),%eax
 813:	89 d6                	mov    %edx,%esi
 815:	89 c7                	mov    %eax,%edi
 817:	e8 24 ff ff ff       	call   740 <putc>
  while(--i >= 0)
 81c:	83 6d fc 01          	subl   $0x1,-0x4(%rbp)
 820:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
 824:	79 dd                	jns    803 <printint+0x9a>
}
 826:	90                   	nop
 827:	90                   	nop
 828:	c9                   	leave
 829:	c3                   	ret

000000000000082a <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 82a:	55                   	push   %rbp
 82b:	48 89 e5             	mov    %rsp,%rbp
 82e:	48 81 ec f0 00 00 00 	sub    $0xf0,%rsp
 835:	89 bd 1c ff ff ff    	mov    %edi,-0xe4(%rbp)
 83b:	48 89 b5 10 ff ff ff 	mov    %rsi,-0xf0(%rbp)
 842:	48 89 95 60 ff ff ff 	mov    %rdx,-0xa0(%rbp)
 849:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
 850:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
 857:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
 85e:	84 c0                	test   %al,%al
 860:	74 20                	je     882 <printf+0x58>
 862:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
 866:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
 86a:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
 86e:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
 872:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
 876:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
 87a:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
 87e:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  va_list ap;
  char *s;
  int c, i, state;
  va_start(ap, fmt);
 882:	c7 85 20 ff ff ff 10 	movl   $0x10,-0xe0(%rbp)
 889:	00 00 00 
 88c:	c7 85 24 ff ff ff 30 	movl   $0x30,-0xdc(%rbp)
 893:	00 00 00 
 896:	48 8d 45 10          	lea    0x10(%rbp),%rax
 89a:	48 89 85 28 ff ff ff 	mov    %rax,-0xd8(%rbp)
 8a1:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
 8a8:	48 89 85 30 ff ff ff 	mov    %rax,-0xd0(%rbp)

  state = 0;
 8af:	c7 85 40 ff ff ff 00 	movl   $0x0,-0xc0(%rbp)
 8b6:	00 00 00 
  for(i = 0; fmt[i]; i++){
 8b9:	c7 85 44 ff ff ff 00 	movl   $0x0,-0xbc(%rbp)
 8c0:	00 00 00 
 8c3:	e9 a8 02 00 00       	jmp    b70 <printf+0x346>
    c = fmt[i] & 0xff;
 8c8:	8b 85 44 ff ff ff    	mov    -0xbc(%rbp),%eax
 8ce:	48 63 d0             	movslq %eax,%rdx
 8d1:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
 8d8:	48 01 d0             	add    %rdx,%rax
 8db:	0f b6 00             	movzbl (%rax),%eax
 8de:	0f be c0             	movsbl %al,%eax
 8e1:	25 ff 00 00 00       	and    $0xff,%eax
 8e6:	89 85 3c ff ff ff    	mov    %eax,-0xc4(%rbp)
    if(state == 0){
 8ec:	83 bd 40 ff ff ff 00 	cmpl   $0x0,-0xc0(%rbp)
 8f3:	75 35                	jne    92a <printf+0x100>
      if(c == '%'){
 8f5:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
 8fc:	75 0f                	jne    90d <printf+0xe3>
        state = '%';
 8fe:	c7 85 40 ff ff ff 25 	movl   $0x25,-0xc0(%rbp)
 905:	00 00 00 
 908:	e9 5c 02 00 00       	jmp    b69 <printf+0x33f>
      } else {
        putc(fd, c);
 90d:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
 913:	0f be d0             	movsbl %al,%edx
 916:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 91c:	89 d6                	mov    %edx,%esi
 91e:	89 c7                	mov    %eax,%edi
 920:	e8 1b fe ff ff       	call   740 <putc>
 925:	e9 3f 02 00 00       	jmp    b69 <printf+0x33f>
      }
    } else if(state == '%'){
 92a:	83 bd 40 ff ff ff 25 	cmpl   $0x25,-0xc0(%rbp)
 931:	0f 85 32 02 00 00    	jne    b69 <printf+0x33f>
      if(c == 'd'){
 937:	83 bd 3c ff ff ff 64 	cmpl   $0x64,-0xc4(%rbp)
 93e:	75 5e                	jne    99e <printf+0x174>
        printint(fd, va_arg(ap, int), 10, 1);
 940:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 946:	83 f8 2f             	cmp    $0x2f,%eax
 949:	77 23                	ja     96e <printf+0x144>
 94b:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 952:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 958:	89 d2                	mov    %edx,%edx
 95a:	48 01 d0             	add    %rdx,%rax
 95d:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 963:	83 c2 08             	add    $0x8,%edx
 966:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 96c:	eb 12                	jmp    980 <printf+0x156>
 96e:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 975:	48 8d 50 08          	lea    0x8(%rax),%rdx
 979:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 980:	8b 30                	mov    (%rax),%esi
 982:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 988:	b9 01 00 00 00       	mov    $0x1,%ecx
 98d:	ba 0a 00 00 00       	mov    $0xa,%edx
 992:	89 c7                	mov    %eax,%edi
 994:	e8 d0 fd ff ff       	call   769 <printint>
 999:	e9 c1 01 00 00       	jmp    b5f <printf+0x335>
      } else if(c == 'x' || c == 'p'){
 99e:	83 bd 3c ff ff ff 78 	cmpl   $0x78,-0xc4(%rbp)
 9a5:	74 09                	je     9b0 <printf+0x186>
 9a7:	83 bd 3c ff ff ff 70 	cmpl   $0x70,-0xc4(%rbp)
 9ae:	75 5e                	jne    a0e <printf+0x1e4>
        printint(fd, va_arg(ap, int), 16, 0);
 9b0:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 9b6:	83 f8 2f             	cmp    $0x2f,%eax
 9b9:	77 23                	ja     9de <printf+0x1b4>
 9bb:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 9c2:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 9c8:	89 d2                	mov    %edx,%edx
 9ca:	48 01 d0             	add    %rdx,%rax
 9cd:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 9d3:	83 c2 08             	add    $0x8,%edx
 9d6:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 9dc:	eb 12                	jmp    9f0 <printf+0x1c6>
 9de:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 9e5:	48 8d 50 08          	lea    0x8(%rax),%rdx
 9e9:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 9f0:	8b 30                	mov    (%rax),%esi
 9f2:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 9f8:	b9 00 00 00 00       	mov    $0x0,%ecx
 9fd:	ba 10 00 00 00       	mov    $0x10,%edx
 a02:	89 c7                	mov    %eax,%edi
 a04:	e8 60 fd ff ff       	call   769 <printint>
 a09:	e9 51 01 00 00       	jmp    b5f <printf+0x335>
      } else if(c == 's'){
 a0e:	83 bd 3c ff ff ff 73 	cmpl   $0x73,-0xc4(%rbp)
 a15:	0f 85 98 00 00 00    	jne    ab3 <printf+0x289>
        s = va_arg(ap, char*);
 a1b:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 a21:	83 f8 2f             	cmp    $0x2f,%eax
 a24:	77 23                	ja     a49 <printf+0x21f>
 a26:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 a2d:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 a33:	89 d2                	mov    %edx,%edx
 a35:	48 01 d0             	add    %rdx,%rax
 a38:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 a3e:	83 c2 08             	add    $0x8,%edx
 a41:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 a47:	eb 12                	jmp    a5b <printf+0x231>
 a49:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 a50:	48 8d 50 08          	lea    0x8(%rax),%rdx
 a54:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 a5b:	48 8b 00             	mov    (%rax),%rax
 a5e:	48 89 85 48 ff ff ff 	mov    %rax,-0xb8(%rbp)
        if(s == 0)
 a65:	48 83 bd 48 ff ff ff 	cmpq   $0x0,-0xb8(%rbp)
 a6c:	00 
 a6d:	75 31                	jne    aa0 <printf+0x276>
          s = "(null)";
 a6f:	48 c7 85 48 ff ff ff 	movq   $0xe79,-0xb8(%rbp)
 a76:	79 0e 00 00 
        while(*s != 0){
 a7a:	eb 24                	jmp    aa0 <printf+0x276>
          putc(fd, *s);
 a7c:	48 8b 85 48 ff ff ff 	mov    -0xb8(%rbp),%rax
 a83:	0f b6 00             	movzbl (%rax),%eax
 a86:	0f be d0             	movsbl %al,%edx
 a89:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 a8f:	89 d6                	mov    %edx,%esi
 a91:	89 c7                	mov    %eax,%edi
 a93:	e8 a8 fc ff ff       	call   740 <putc>
          s++;
 a98:	48 83 85 48 ff ff ff 	addq   $0x1,-0xb8(%rbp)
 a9f:	01 
        while(*s != 0){
 aa0:	48 8b 85 48 ff ff ff 	mov    -0xb8(%rbp),%rax
 aa7:	0f b6 00             	movzbl (%rax),%eax
 aaa:	84 c0                	test   %al,%al
 aac:	75 ce                	jne    a7c <printf+0x252>
 aae:	e9 ac 00 00 00       	jmp    b5f <printf+0x335>
        }
      } else if(c == 'c'){
 ab3:	83 bd 3c ff ff ff 63 	cmpl   $0x63,-0xc4(%rbp)
 aba:	75 56                	jne    b12 <printf+0x2e8>
        putc(fd, va_arg(ap, uint));
 abc:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 ac2:	83 f8 2f             	cmp    $0x2f,%eax
 ac5:	77 23                	ja     aea <printf+0x2c0>
 ac7:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 ace:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 ad4:	89 d2                	mov    %edx,%edx
 ad6:	48 01 d0             	add    %rdx,%rax
 ad9:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 adf:	83 c2 08             	add    $0x8,%edx
 ae2:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 ae8:	eb 12                	jmp    afc <printf+0x2d2>
 aea:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 af1:	48 8d 50 08          	lea    0x8(%rax),%rdx
 af5:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 afc:	8b 00                	mov    (%rax),%eax
 afe:	0f be d0             	movsbl %al,%edx
 b01:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 b07:	89 d6                	mov    %edx,%esi
 b09:	89 c7                	mov    %eax,%edi
 b0b:	e8 30 fc ff ff       	call   740 <putc>
 b10:	eb 4d                	jmp    b5f <printf+0x335>
      } else if(c == '%'){
 b12:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
 b19:	75 1a                	jne    b35 <printf+0x30b>
        putc(fd, c);
 b1b:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
 b21:	0f be d0             	movsbl %al,%edx
 b24:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 b2a:	89 d6                	mov    %edx,%esi
 b2c:	89 c7                	mov    %eax,%edi
 b2e:	e8 0d fc ff ff       	call   740 <putc>
 b33:	eb 2a                	jmp    b5f <printf+0x335>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 b35:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 b3b:	be 25 00 00 00       	mov    $0x25,%esi
 b40:	89 c7                	mov    %eax,%edi
 b42:	e8 f9 fb ff ff       	call   740 <putc>
        putc(fd, c);
 b47:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
 b4d:	0f be d0             	movsbl %al,%edx
 b50:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 b56:	89 d6                	mov    %edx,%esi
 b58:	89 c7                	mov    %eax,%edi
 b5a:	e8 e1 fb ff ff       	call   740 <putc>
      }
      state = 0;
 b5f:	c7 85 40 ff ff ff 00 	movl   $0x0,-0xc0(%rbp)
 b66:	00 00 00 
  for(i = 0; fmt[i]; i++){
 b69:	83 85 44 ff ff ff 01 	addl   $0x1,-0xbc(%rbp)
 b70:	8b 85 44 ff ff ff    	mov    -0xbc(%rbp),%eax
 b76:	48 63 d0             	movslq %eax,%rdx
 b79:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
 b80:	48 01 d0             	add    %rdx,%rax
 b83:	0f b6 00             	movzbl (%rax),%eax
 b86:	84 c0                	test   %al,%al
 b88:	0f 85 3a fd ff ff    	jne    8c8 <printf+0x9e>
    }
  }
}
 b8e:	90                   	nop
 b8f:	90                   	nop
 b90:	c9                   	leave
 b91:	c3                   	ret

0000000000000b92 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 b92:	55                   	push   %rbp
 b93:	48 89 e5             	mov    %rsp,%rbp
 b96:	48 83 ec 18          	sub    $0x18,%rsp
 b9a:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  Header *bp, *p;

  bp = (Header*)ap - 1;
 b9e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 ba2:	48 83 e8 10          	sub    $0x10,%rax
 ba6:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 baa:	48 8b 05 9f 05 00 00 	mov    0x59f(%rip),%rax        # 1150 <freep>
 bb1:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 bb5:	eb 2f                	jmp    be6 <free+0x54>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 bb7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 bbb:	48 8b 00             	mov    (%rax),%rax
 bbe:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 bc2:	72 17                	jb     bdb <free+0x49>
 bc4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 bc8:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 bcc:	72 2f                	jb     bfd <free+0x6b>
 bce:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 bd2:	48 8b 00             	mov    (%rax),%rax
 bd5:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
 bd9:	72 22                	jb     bfd <free+0x6b>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 bdb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 bdf:	48 8b 00             	mov    (%rax),%rax
 be2:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 be6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 bea:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 bee:	73 c7                	jae    bb7 <free+0x25>
 bf0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 bf4:	48 8b 00             	mov    (%rax),%rax
 bf7:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
 bfb:	73 ba                	jae    bb7 <free+0x25>
      break;
  if(bp + bp->s.size == p->s.ptr){
 bfd:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 c01:	8b 40 08             	mov    0x8(%rax),%eax
 c04:	89 c0                	mov    %eax,%eax
 c06:	48 c1 e0 04          	shl    $0x4,%rax
 c0a:	48 89 c2             	mov    %rax,%rdx
 c0d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 c11:	48 01 c2             	add    %rax,%rdx
 c14:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 c18:	48 8b 00             	mov    (%rax),%rax
 c1b:	48 39 c2             	cmp    %rax,%rdx
 c1e:	75 2d                	jne    c4d <free+0xbb>
    bp->s.size += p->s.ptr->s.size;
 c20:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 c24:	8b 50 08             	mov    0x8(%rax),%edx
 c27:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 c2b:	48 8b 00             	mov    (%rax),%rax
 c2e:	8b 40 08             	mov    0x8(%rax),%eax
 c31:	01 c2                	add    %eax,%edx
 c33:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 c37:	89 50 08             	mov    %edx,0x8(%rax)
    bp->s.ptr = p->s.ptr->s.ptr;
 c3a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 c3e:	48 8b 00             	mov    (%rax),%rax
 c41:	48 8b 10             	mov    (%rax),%rdx
 c44:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 c48:	48 89 10             	mov    %rdx,(%rax)
 c4b:	eb 0e                	jmp    c5b <free+0xc9>
  } else
    bp->s.ptr = p->s.ptr;
 c4d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 c51:	48 8b 10             	mov    (%rax),%rdx
 c54:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 c58:	48 89 10             	mov    %rdx,(%rax)
  if(p + p->s.size == bp){
 c5b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 c5f:	8b 40 08             	mov    0x8(%rax),%eax
 c62:	89 c0                	mov    %eax,%eax
 c64:	48 c1 e0 04          	shl    $0x4,%rax
 c68:	48 89 c2             	mov    %rax,%rdx
 c6b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 c6f:	48 01 d0             	add    %rdx,%rax
 c72:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
 c76:	75 27                	jne    c9f <free+0x10d>
    p->s.size += bp->s.size;
 c78:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 c7c:	8b 50 08             	mov    0x8(%rax),%edx
 c7f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 c83:	8b 40 08             	mov    0x8(%rax),%eax
 c86:	01 c2                	add    %eax,%edx
 c88:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 c8c:	89 50 08             	mov    %edx,0x8(%rax)
    p->s.ptr = bp->s.ptr;
 c8f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 c93:	48 8b 10             	mov    (%rax),%rdx
 c96:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 c9a:	48 89 10             	mov    %rdx,(%rax)
 c9d:	eb 0b                	jmp    caa <free+0x118>
  } else
    p->s.ptr = bp;
 c9f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 ca3:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
 ca7:	48 89 10             	mov    %rdx,(%rax)
  freep = p;
 caa:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 cae:	48 89 05 9b 04 00 00 	mov    %rax,0x49b(%rip)        # 1150 <freep>
}
 cb5:	90                   	nop
 cb6:	c9                   	leave
 cb7:	c3                   	ret

0000000000000cb8 <morecore>:

static Header*
morecore(uint nu)
{
 cb8:	55                   	push   %rbp
 cb9:	48 89 e5             	mov    %rsp,%rbp
 cbc:	48 83 ec 20          	sub    $0x20,%rsp
 cc0:	89 7d ec             	mov    %edi,-0x14(%rbp)
  char *p;
  Header *hp;

  if(nu < 4096)
 cc3:	81 7d ec ff 0f 00 00 	cmpl   $0xfff,-0x14(%rbp)
 cca:	77 07                	ja     cd3 <morecore+0x1b>
    nu = 4096;
 ccc:	c7 45 ec 00 10 00 00 	movl   $0x1000,-0x14(%rbp)
  p = sbrk(nu * sizeof(Header));
 cd3:	8b 45 ec             	mov    -0x14(%rbp),%eax
 cd6:	c1 e0 04             	shl    $0x4,%eax
 cd9:	89 c7                	mov    %eax,%edi
 cdb:	e8 40 fa ff ff       	call   720 <sbrk>
 ce0:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  if(p == (char*)-1)
 ce4:	48 83 7d f8 ff       	cmpq   $0xffffffffffffffff,-0x8(%rbp)
 ce9:	75 07                	jne    cf2 <morecore+0x3a>
    return 0;
 ceb:	b8 00 00 00 00       	mov    $0x0,%eax
 cf0:	eb 29                	jmp    d1b <morecore+0x63>
  hp = (Header*)p;
 cf2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 cf6:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  hp->s.size = nu;
 cfa:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 cfe:	8b 55 ec             	mov    -0x14(%rbp),%edx
 d01:	89 50 08             	mov    %edx,0x8(%rax)
  free((void*)(hp + 1));
 d04:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 d08:	48 83 c0 10          	add    $0x10,%rax
 d0c:	48 89 c7             	mov    %rax,%rdi
 d0f:	e8 7e fe ff ff       	call   b92 <free>
  return freep;
 d14:	48 8b 05 35 04 00 00 	mov    0x435(%rip),%rax        # 1150 <freep>
}
 d1b:	c9                   	leave
 d1c:	c3                   	ret

0000000000000d1d <malloc>:

void*
malloc(uint nbytes)
{
 d1d:	55                   	push   %rbp
 d1e:	48 89 e5             	mov    %rsp,%rbp
 d21:	48 83 ec 30          	sub    $0x30,%rsp
 d25:	89 7d dc             	mov    %edi,-0x24(%rbp)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 d28:	8b 45 dc             	mov    -0x24(%rbp),%eax
 d2b:	48 83 c0 0f          	add    $0xf,%rax
 d2f:	48 c1 e8 04          	shr    $0x4,%rax
 d33:	83 c0 01             	add    $0x1,%eax
 d36:	89 45 ec             	mov    %eax,-0x14(%rbp)
  if((prevp = freep) == 0){
 d39:	48 8b 05 10 04 00 00 	mov    0x410(%rip),%rax        # 1150 <freep>
 d40:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
 d44:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
 d49:	75 2b                	jne    d76 <malloc+0x59>
    base.s.ptr = freep = prevp = &base;
 d4b:	48 c7 45 f0 40 11 00 	movq   $0x1140,-0x10(%rbp)
 d52:	00 
 d53:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 d57:	48 89 05 f2 03 00 00 	mov    %rax,0x3f2(%rip)        # 1150 <freep>
 d5e:	48 8b 05 eb 03 00 00 	mov    0x3eb(%rip),%rax        # 1150 <freep>
 d65:	48 89 05 d4 03 00 00 	mov    %rax,0x3d4(%rip)        # 1140 <base>
    base.s.size = 0;
 d6c:	c7 05 d2 03 00 00 00 	movl   $0x0,0x3d2(%rip)        # 1148 <base+0x8>
 d73:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 d76:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 d7a:	48 8b 00             	mov    (%rax),%rax
 d7d:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
 d81:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 d85:	8b 40 08             	mov    0x8(%rax),%eax
 d88:	3b 45 ec             	cmp    -0x14(%rbp),%eax
 d8b:	72 5f                	jb     dec <malloc+0xcf>
      if(p->s.size == nunits)
 d8d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 d91:	8b 40 08             	mov    0x8(%rax),%eax
 d94:	39 45 ec             	cmp    %eax,-0x14(%rbp)
 d97:	75 10                	jne    da9 <malloc+0x8c>
        prevp->s.ptr = p->s.ptr;
 d99:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 d9d:	48 8b 10             	mov    (%rax),%rdx
 da0:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 da4:	48 89 10             	mov    %rdx,(%rax)
 da7:	eb 2e                	jmp    dd7 <malloc+0xba>
      else {
        p->s.size -= nunits;
 da9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 dad:	8b 40 08             	mov    0x8(%rax),%eax
 db0:	2b 45 ec             	sub    -0x14(%rbp),%eax
 db3:	89 c2                	mov    %eax,%edx
 db5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 db9:	89 50 08             	mov    %edx,0x8(%rax)
        p += p->s.size;
 dbc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 dc0:	8b 40 08             	mov    0x8(%rax),%eax
 dc3:	89 c0                	mov    %eax,%eax
 dc5:	48 c1 e0 04          	shl    $0x4,%rax
 dc9:	48 01 45 f8          	add    %rax,-0x8(%rbp)
        p->s.size = nunits;
 dcd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 dd1:	8b 55 ec             	mov    -0x14(%rbp),%edx
 dd4:	89 50 08             	mov    %edx,0x8(%rax)
      }
      freep = prevp;
 dd7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 ddb:	48 89 05 6e 03 00 00 	mov    %rax,0x36e(%rip)        # 1150 <freep>
      return (void*)(p + 1);
 de2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 de6:	48 83 c0 10          	add    $0x10,%rax
 dea:	eb 41                	jmp    e2d <malloc+0x110>
    }
    if(p == freep)
 dec:	48 8b 05 5d 03 00 00 	mov    0x35d(%rip),%rax        # 1150 <freep>
 df3:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 df7:	75 1c                	jne    e15 <malloc+0xf8>
      if((p = morecore(nunits)) == 0)
 df9:	8b 45 ec             	mov    -0x14(%rbp),%eax
 dfc:	89 c7                	mov    %eax,%edi
 dfe:	e8 b5 fe ff ff       	call   cb8 <morecore>
 e03:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 e07:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
 e0c:	75 07                	jne    e15 <malloc+0xf8>
        return 0;
 e0e:	b8 00 00 00 00       	mov    $0x0,%eax
 e13:	eb 18                	jmp    e2d <malloc+0x110>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 e15:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 e19:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
 e1d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 e21:	48 8b 00             	mov    (%rax),%rax
 e24:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
 e28:	e9 54 ff ff ff       	jmp    d81 <malloc+0x64>
  }
}
 e2d:	c9                   	leave
 e2e:	c3                   	ret
