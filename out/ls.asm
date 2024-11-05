
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
      73:	48 c7 c7 e0 13 00 00 	mov    $0x13e0,%rdi
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
      a2:	48 05 e0 13 00 00    	add    $0x13e0,%rax
      a8:	89 da                	mov    %ebx,%edx
      aa:	be 20 00 00 00       	mov    $0x20,%esi
      af:	48 89 c7             	mov    %rax,%rdi
      b2:	e8 ec 03 00 00       	call   4a3 <memset>
  return buf;
      b7:	48 c7 c0 e0 13 00 00 	mov    $0x13e0,%rax
}
      be:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
      c2:	c9                   	leave
      c3:	c3                   	ret

00000000000000c4 <ls>:

void ls(char *path) {
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
     102:	48 c7 c6 3c 10 00 00 	mov    $0x103c,%rsi
     109:	bf 02 00 00 00       	mov    $0x2,%edi
     10e:	b8 00 00 00 00       	mov    $0x0,%eax
     113:	e8 32 07 00 00       	call   84a <printf>
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
     13f:	48 c7 c6 50 10 00 00 	mov    $0x1050,%rsi
     146:	bf 02 00 00 00       	mov    $0x2,%edi
     14b:	b8 00 00 00 00       	mov    $0x0,%eax
     150:	e8 f5 06 00 00       	call   84a <printf>
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
     1ac:	48 c7 c6 64 10 00 00 	mov    $0x1064,%rsi
     1b3:	bf 01 00 00 00       	mov    $0x1,%edi
     1b8:	b8 00 00 00 00       	mov    $0x0,%eax
     1bd:	e8 88 06 00 00       	call   84a <printf>
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
     1e0:	48 c7 c6 71 10 00 00 	mov    $0x1071,%rsi
     1e7:	bf 01 00 00 00       	mov    $0x1,%edi
     1ec:	b8 00 00 00 00       	mov    $0x0,%eax
     1f1:	e8 54 06 00 00       	call   84a <printf>
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
     2a8:	48 c7 c6 50 10 00 00 	mov    $0x1050,%rsi
     2af:	bf 01 00 00 00       	mov    $0x1,%edi
     2b4:	b8 00 00 00 00       	mov    $0x0,%eax
     2b9:	e8 8c 05 00 00       	call   84a <printf>
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
     2f2:	48 c7 c6 64 10 00 00 	mov    $0x1064,%rsi
     2f9:	bf 01 00 00 00       	mov    $0x1,%edi
     2fe:	b8 00 00 00 00       	mov    $0x0,%eax
     303:	e8 42 05 00 00       	call   84a <printf>
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
     35b:	48 c7 c7 84 10 00 00 	mov    $0x1084,%rdi
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

0000000000000740 <getfavnum>:
SYSCALL(getfavnum)
     740:	b8 19 00 00 00       	mov    $0x19,%eax
     745:	cd 40                	int    $0x40
     747:	c3                   	ret

0000000000000748 <shutdown>:
SYSCALL(shutdown)
     748:	b8 1a 00 00 00       	mov    $0x1a,%eax
     74d:	cd 40                	int    $0x40
     74f:	c3                   	ret

0000000000000750 <getcount>:
SYSCALL(getcount)
     750:	b8 1b 00 00 00       	mov    $0x1b,%eax
     755:	cd 40                	int    $0x40
     757:	c3                   	ret

0000000000000758 <killrandom>:
     758:	b8 1c 00 00 00       	mov    $0x1c,%eax
     75d:	cd 40                	int    $0x40
     75f:	c3                   	ret

0000000000000760 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
     760:	55                   	push   %rbp
     761:	48 89 e5             	mov    %rsp,%rbp
     764:	48 83 ec 10          	sub    $0x10,%rsp
     768:	89 7d fc             	mov    %edi,-0x4(%rbp)
     76b:	89 f0                	mov    %esi,%eax
     76d:	88 45 f8             	mov    %al,-0x8(%rbp)
  write(fd, &c, 1);
     770:	48 8d 4d f8          	lea    -0x8(%rbp),%rcx
     774:	8b 45 fc             	mov    -0x4(%rbp),%eax
     777:	ba 01 00 00 00       	mov    $0x1,%edx
     77c:	48 89 ce             	mov    %rcx,%rsi
     77f:	89 c7                	mov    %eax,%edi
     781:	e8 32 ff ff ff       	call   6b8 <write>
}
     786:	90                   	nop
     787:	c9                   	leave
     788:	c3                   	ret

0000000000000789 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     789:	55                   	push   %rbp
     78a:	48 89 e5             	mov    %rsp,%rbp
     78d:	48 83 ec 30          	sub    $0x30,%rsp
     791:	89 7d dc             	mov    %edi,-0x24(%rbp)
     794:	89 75 d8             	mov    %esi,-0x28(%rbp)
     797:	89 55 d4             	mov    %edx,-0x2c(%rbp)
     79a:	89 4d d0             	mov    %ecx,-0x30(%rbp)
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
     79d:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
  if(sgn && xx < 0){
     7a4:	83 7d d0 00          	cmpl   $0x0,-0x30(%rbp)
     7a8:	74 17                	je     7c1 <printint+0x38>
     7aa:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
     7ae:	79 11                	jns    7c1 <printint+0x38>
    neg = 1;
     7b0:	c7 45 f8 01 00 00 00 	movl   $0x1,-0x8(%rbp)
    x = -xx;
     7b7:	8b 45 d8             	mov    -0x28(%rbp),%eax
     7ba:	f7 d8                	neg    %eax
     7bc:	89 45 f4             	mov    %eax,-0xc(%rbp)
     7bf:	eb 06                	jmp    7c7 <printint+0x3e>
  } else {
    x = xx;
     7c1:	8b 45 d8             	mov    -0x28(%rbp),%eax
     7c4:	89 45 f4             	mov    %eax,-0xc(%rbp)
  }

  i = 0;
     7c7:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  do{
    buf[i++] = digits[x % base];
     7ce:	8b 4d d4             	mov    -0x2c(%rbp),%ecx
     7d1:	8b 45 f4             	mov    -0xc(%rbp),%eax
     7d4:	ba 00 00 00 00       	mov    $0x0,%edx
     7d9:	f7 f1                	div    %ecx
     7db:	89 d1                	mov    %edx,%ecx
     7dd:	8b 45 fc             	mov    -0x4(%rbp),%eax
     7e0:	8d 50 01             	lea    0x1(%rax),%edx
     7e3:	89 55 fc             	mov    %edx,-0x4(%rbp)
     7e6:	89 ca                	mov    %ecx,%edx
     7e8:	0f b6 92 c0 13 00 00 	movzbl 0x13c0(%rdx),%edx
     7ef:	48 98                	cltq
     7f1:	88 54 05 e0          	mov    %dl,-0x20(%rbp,%rax,1)
  }while((x /= base) != 0);
     7f5:	8b 75 d4             	mov    -0x2c(%rbp),%esi
     7f8:	8b 45 f4             	mov    -0xc(%rbp),%eax
     7fb:	ba 00 00 00 00       	mov    $0x0,%edx
     800:	f7 f6                	div    %esi
     802:	89 45 f4             	mov    %eax,-0xc(%rbp)
     805:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
     809:	75 c3                	jne    7ce <printint+0x45>
  if(neg)
     80b:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
     80f:	74 2b                	je     83c <printint+0xb3>
    buf[i++] = '-';
     811:	8b 45 fc             	mov    -0x4(%rbp),%eax
     814:	8d 50 01             	lea    0x1(%rax),%edx
     817:	89 55 fc             	mov    %edx,-0x4(%rbp)
     81a:	48 98                	cltq
     81c:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%rbp,%rax,1)

  while(--i >= 0)
     821:	eb 19                	jmp    83c <printint+0xb3>
    putc(fd, buf[i]);
     823:	8b 45 fc             	mov    -0x4(%rbp),%eax
     826:	48 98                	cltq
     828:	0f b6 44 05 e0       	movzbl -0x20(%rbp,%rax,1),%eax
     82d:	0f be d0             	movsbl %al,%edx
     830:	8b 45 dc             	mov    -0x24(%rbp),%eax
     833:	89 d6                	mov    %edx,%esi
     835:	89 c7                	mov    %eax,%edi
     837:	e8 24 ff ff ff       	call   760 <putc>
  while(--i >= 0)
     83c:	83 6d fc 01          	subl   $0x1,-0x4(%rbp)
     840:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
     844:	79 dd                	jns    823 <printint+0x9a>
}
     846:	90                   	nop
     847:	90                   	nop
     848:	c9                   	leave
     849:	c3                   	ret

000000000000084a <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
     84a:	55                   	push   %rbp
     84b:	48 89 e5             	mov    %rsp,%rbp
     84e:	48 81 ec f0 00 00 00 	sub    $0xf0,%rsp
     855:	89 bd 1c ff ff ff    	mov    %edi,-0xe4(%rbp)
     85b:	48 89 b5 10 ff ff ff 	mov    %rsi,-0xf0(%rbp)
     862:	48 89 95 60 ff ff ff 	mov    %rdx,-0xa0(%rbp)
     869:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
     870:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
     877:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
     87e:	84 c0                	test   %al,%al
     880:	74 20                	je     8a2 <printf+0x58>
     882:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
     886:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
     88a:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
     88e:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
     892:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
     896:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
     89a:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
     89e:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  va_list ap;
  char *s;
  int c, i, state;
  va_start(ap, fmt);
     8a2:	c7 85 20 ff ff ff 10 	movl   $0x10,-0xe0(%rbp)
     8a9:	00 00 00 
     8ac:	c7 85 24 ff ff ff 30 	movl   $0x30,-0xdc(%rbp)
     8b3:	00 00 00 
     8b6:	48 8d 45 10          	lea    0x10(%rbp),%rax
     8ba:	48 89 85 28 ff ff ff 	mov    %rax,-0xd8(%rbp)
     8c1:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
     8c8:	48 89 85 30 ff ff ff 	mov    %rax,-0xd0(%rbp)

  state = 0;
     8cf:	c7 85 40 ff ff ff 00 	movl   $0x0,-0xc0(%rbp)
     8d6:	00 00 00 
  for(i = 0; fmt[i]; i++){
     8d9:	c7 85 44 ff ff ff 00 	movl   $0x0,-0xbc(%rbp)
     8e0:	00 00 00 
     8e3:	e9 a8 02 00 00       	jmp    b90 <printf+0x346>
    c = fmt[i] & 0xff;
     8e8:	8b 85 44 ff ff ff    	mov    -0xbc(%rbp),%eax
     8ee:	48 63 d0             	movslq %eax,%rdx
     8f1:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
     8f8:	48 01 d0             	add    %rdx,%rax
     8fb:	0f b6 00             	movzbl (%rax),%eax
     8fe:	0f be c0             	movsbl %al,%eax
     901:	25 ff 00 00 00       	and    $0xff,%eax
     906:	89 85 3c ff ff ff    	mov    %eax,-0xc4(%rbp)
    if(state == 0){
     90c:	83 bd 40 ff ff ff 00 	cmpl   $0x0,-0xc0(%rbp)
     913:	75 35                	jne    94a <printf+0x100>
      if(c == '%'){
     915:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
     91c:	75 0f                	jne    92d <printf+0xe3>
        state = '%';
     91e:	c7 85 40 ff ff ff 25 	movl   $0x25,-0xc0(%rbp)
     925:	00 00 00 
     928:	e9 5c 02 00 00       	jmp    b89 <printf+0x33f>
      } else {
        putc(fd, c);
     92d:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
     933:	0f be d0             	movsbl %al,%edx
     936:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
     93c:	89 d6                	mov    %edx,%esi
     93e:	89 c7                	mov    %eax,%edi
     940:	e8 1b fe ff ff       	call   760 <putc>
     945:	e9 3f 02 00 00       	jmp    b89 <printf+0x33f>
      }
    } else if(state == '%'){
     94a:	83 bd 40 ff ff ff 25 	cmpl   $0x25,-0xc0(%rbp)
     951:	0f 85 32 02 00 00    	jne    b89 <printf+0x33f>
      if(c == 'd'){
     957:	83 bd 3c ff ff ff 64 	cmpl   $0x64,-0xc4(%rbp)
     95e:	75 5e                	jne    9be <printf+0x174>
        printint(fd, va_arg(ap, int), 10, 1);
     960:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
     966:	83 f8 2f             	cmp    $0x2f,%eax
     969:	77 23                	ja     98e <printf+0x144>
     96b:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
     972:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
     978:	89 d2                	mov    %edx,%edx
     97a:	48 01 d0             	add    %rdx,%rax
     97d:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
     983:	83 c2 08             	add    $0x8,%edx
     986:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
     98c:	eb 12                	jmp    9a0 <printf+0x156>
     98e:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
     995:	48 8d 50 08          	lea    0x8(%rax),%rdx
     999:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
     9a0:	8b 30                	mov    (%rax),%esi
     9a2:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
     9a8:	b9 01 00 00 00       	mov    $0x1,%ecx
     9ad:	ba 0a 00 00 00       	mov    $0xa,%edx
     9b2:	89 c7                	mov    %eax,%edi
     9b4:	e8 d0 fd ff ff       	call   789 <printint>
     9b9:	e9 c1 01 00 00       	jmp    b7f <printf+0x335>
      } else if(c == 'x' || c == 'p'){
     9be:	83 bd 3c ff ff ff 78 	cmpl   $0x78,-0xc4(%rbp)
     9c5:	74 09                	je     9d0 <printf+0x186>
     9c7:	83 bd 3c ff ff ff 70 	cmpl   $0x70,-0xc4(%rbp)
     9ce:	75 5e                	jne    a2e <printf+0x1e4>
        printint(fd, va_arg(ap, int), 16, 0);
     9d0:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
     9d6:	83 f8 2f             	cmp    $0x2f,%eax
     9d9:	77 23                	ja     9fe <printf+0x1b4>
     9db:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
     9e2:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
     9e8:	89 d2                	mov    %edx,%edx
     9ea:	48 01 d0             	add    %rdx,%rax
     9ed:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
     9f3:	83 c2 08             	add    $0x8,%edx
     9f6:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
     9fc:	eb 12                	jmp    a10 <printf+0x1c6>
     9fe:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
     a05:	48 8d 50 08          	lea    0x8(%rax),%rdx
     a09:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
     a10:	8b 30                	mov    (%rax),%esi
     a12:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
     a18:	b9 00 00 00 00       	mov    $0x0,%ecx
     a1d:	ba 10 00 00 00       	mov    $0x10,%edx
     a22:	89 c7                	mov    %eax,%edi
     a24:	e8 60 fd ff ff       	call   789 <printint>
     a29:	e9 51 01 00 00       	jmp    b7f <printf+0x335>
      } else if(c == 's'){
     a2e:	83 bd 3c ff ff ff 73 	cmpl   $0x73,-0xc4(%rbp)
     a35:	0f 85 98 00 00 00    	jne    ad3 <printf+0x289>
        s = va_arg(ap, char*);
     a3b:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
     a41:	83 f8 2f             	cmp    $0x2f,%eax
     a44:	77 23                	ja     a69 <printf+0x21f>
     a46:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
     a4d:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
     a53:	89 d2                	mov    %edx,%edx
     a55:	48 01 d0             	add    %rdx,%rax
     a58:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
     a5e:	83 c2 08             	add    $0x8,%edx
     a61:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
     a67:	eb 12                	jmp    a7b <printf+0x231>
     a69:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
     a70:	48 8d 50 08          	lea    0x8(%rax),%rdx
     a74:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
     a7b:	48 8b 00             	mov    (%rax),%rax
     a7e:	48 89 85 48 ff ff ff 	mov    %rax,-0xb8(%rbp)
        if(s == 0)
     a85:	48 83 bd 48 ff ff ff 	cmpq   $0x0,-0xb8(%rbp)
     a8c:	00 
     a8d:	75 31                	jne    ac0 <printf+0x276>
          s = "(null)";
     a8f:	48 c7 85 48 ff ff ff 	movq   $0x1086,-0xb8(%rbp)
     a96:	86 10 00 00 
        while(*s != 0){
     a9a:	eb 24                	jmp    ac0 <printf+0x276>
          putc(fd, *s);
     a9c:	48 8b 85 48 ff ff ff 	mov    -0xb8(%rbp),%rax
     aa3:	0f b6 00             	movzbl (%rax),%eax
     aa6:	0f be d0             	movsbl %al,%edx
     aa9:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
     aaf:	89 d6                	mov    %edx,%esi
     ab1:	89 c7                	mov    %eax,%edi
     ab3:	e8 a8 fc ff ff       	call   760 <putc>
          s++;
     ab8:	48 83 85 48 ff ff ff 	addq   $0x1,-0xb8(%rbp)
     abf:	01 
        while(*s != 0){
     ac0:	48 8b 85 48 ff ff ff 	mov    -0xb8(%rbp),%rax
     ac7:	0f b6 00             	movzbl (%rax),%eax
     aca:	84 c0                	test   %al,%al
     acc:	75 ce                	jne    a9c <printf+0x252>
     ace:	e9 ac 00 00 00       	jmp    b7f <printf+0x335>
        }
      } else if(c == 'c'){
     ad3:	83 bd 3c ff ff ff 63 	cmpl   $0x63,-0xc4(%rbp)
     ada:	75 56                	jne    b32 <printf+0x2e8>
        putc(fd, va_arg(ap, uint));
     adc:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
     ae2:	83 f8 2f             	cmp    $0x2f,%eax
     ae5:	77 23                	ja     b0a <printf+0x2c0>
     ae7:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
     aee:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
     af4:	89 d2                	mov    %edx,%edx
     af6:	48 01 d0             	add    %rdx,%rax
     af9:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
     aff:	83 c2 08             	add    $0x8,%edx
     b02:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
     b08:	eb 12                	jmp    b1c <printf+0x2d2>
     b0a:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
     b11:	48 8d 50 08          	lea    0x8(%rax),%rdx
     b15:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
     b1c:	8b 00                	mov    (%rax),%eax
     b1e:	0f be d0             	movsbl %al,%edx
     b21:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
     b27:	89 d6                	mov    %edx,%esi
     b29:	89 c7                	mov    %eax,%edi
     b2b:	e8 30 fc ff ff       	call   760 <putc>
     b30:	eb 4d                	jmp    b7f <printf+0x335>
      } else if(c == '%'){
     b32:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
     b39:	75 1a                	jne    b55 <printf+0x30b>
        putc(fd, c);
     b3b:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
     b41:	0f be d0             	movsbl %al,%edx
     b44:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
     b4a:	89 d6                	mov    %edx,%esi
     b4c:	89 c7                	mov    %eax,%edi
     b4e:	e8 0d fc ff ff       	call   760 <putc>
     b53:	eb 2a                	jmp    b7f <printf+0x335>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
     b55:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
     b5b:	be 25 00 00 00       	mov    $0x25,%esi
     b60:	89 c7                	mov    %eax,%edi
     b62:	e8 f9 fb ff ff       	call   760 <putc>
        putc(fd, c);
     b67:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
     b6d:	0f be d0             	movsbl %al,%edx
     b70:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
     b76:	89 d6                	mov    %edx,%esi
     b78:	89 c7                	mov    %eax,%edi
     b7a:	e8 e1 fb ff ff       	call   760 <putc>
      }
      state = 0;
     b7f:	c7 85 40 ff ff ff 00 	movl   $0x0,-0xc0(%rbp)
     b86:	00 00 00 
  for(i = 0; fmt[i]; i++){
     b89:	83 85 44 ff ff ff 01 	addl   $0x1,-0xbc(%rbp)
     b90:	8b 85 44 ff ff ff    	mov    -0xbc(%rbp),%eax
     b96:	48 63 d0             	movslq %eax,%rdx
     b99:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
     ba0:	48 01 d0             	add    %rdx,%rax
     ba3:	0f b6 00             	movzbl (%rax),%eax
     ba6:	84 c0                	test   %al,%al
     ba8:	0f 85 3a fd ff ff    	jne    8e8 <printf+0x9e>
    }
  }
}
     bae:	90                   	nop
     baf:	90                   	nop
     bb0:	c9                   	leave
     bb1:	c3                   	ret

0000000000000bb2 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
     bb2:	55                   	push   %rbp
     bb3:	48 89 e5             	mov    %rsp,%rbp
     bb6:	48 83 ec 18          	sub    $0x18,%rsp
     bba:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  Header *bp, *p;

  bp = (Header*)ap - 1;
     bbe:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
     bc2:	48 83 e8 10          	sub    $0x10,%rax
     bc6:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     bca:	48 8b 05 2f 08 00 00 	mov    0x82f(%rip),%rax        # 1400 <freep>
     bd1:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
     bd5:	eb 2f                	jmp    c06 <free+0x54>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     bd7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     bdb:	48 8b 00             	mov    (%rax),%rax
     bde:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
     be2:	72 17                	jb     bfb <free+0x49>
     be4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
     be8:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
     bec:	72 2f                	jb     c1d <free+0x6b>
     bee:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     bf2:	48 8b 00             	mov    (%rax),%rax
     bf5:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
     bf9:	72 22                	jb     c1d <free+0x6b>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     bfb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     bff:	48 8b 00             	mov    (%rax),%rax
     c02:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
     c06:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
     c0a:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
     c0e:	73 c7                	jae    bd7 <free+0x25>
     c10:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     c14:	48 8b 00             	mov    (%rax),%rax
     c17:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
     c1b:	73 ba                	jae    bd7 <free+0x25>
      break;
  if(bp + bp->s.size == p->s.ptr){
     c1d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
     c21:	8b 40 08             	mov    0x8(%rax),%eax
     c24:	89 c0                	mov    %eax,%eax
     c26:	48 c1 e0 04          	shl    $0x4,%rax
     c2a:	48 89 c2             	mov    %rax,%rdx
     c2d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
     c31:	48 01 c2             	add    %rax,%rdx
     c34:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     c38:	48 8b 00             	mov    (%rax),%rax
     c3b:	48 39 c2             	cmp    %rax,%rdx
     c3e:	75 2d                	jne    c6d <free+0xbb>
    bp->s.size += p->s.ptr->s.size;
     c40:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
     c44:	8b 50 08             	mov    0x8(%rax),%edx
     c47:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     c4b:	48 8b 00             	mov    (%rax),%rax
     c4e:	8b 40 08             	mov    0x8(%rax),%eax
     c51:	01 c2                	add    %eax,%edx
     c53:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
     c57:	89 50 08             	mov    %edx,0x8(%rax)
    bp->s.ptr = p->s.ptr->s.ptr;
     c5a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     c5e:	48 8b 00             	mov    (%rax),%rax
     c61:	48 8b 10             	mov    (%rax),%rdx
     c64:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
     c68:	48 89 10             	mov    %rdx,(%rax)
     c6b:	eb 0e                	jmp    c7b <free+0xc9>
  } else
    bp->s.ptr = p->s.ptr;
     c6d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     c71:	48 8b 10             	mov    (%rax),%rdx
     c74:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
     c78:	48 89 10             	mov    %rdx,(%rax)
  if(p + p->s.size == bp){
     c7b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     c7f:	8b 40 08             	mov    0x8(%rax),%eax
     c82:	89 c0                	mov    %eax,%eax
     c84:	48 c1 e0 04          	shl    $0x4,%rax
     c88:	48 89 c2             	mov    %rax,%rdx
     c8b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     c8f:	48 01 d0             	add    %rdx,%rax
     c92:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
     c96:	75 27                	jne    cbf <free+0x10d>
    p->s.size += bp->s.size;
     c98:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     c9c:	8b 50 08             	mov    0x8(%rax),%edx
     c9f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
     ca3:	8b 40 08             	mov    0x8(%rax),%eax
     ca6:	01 c2                	add    %eax,%edx
     ca8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     cac:	89 50 08             	mov    %edx,0x8(%rax)
    p->s.ptr = bp->s.ptr;
     caf:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
     cb3:	48 8b 10             	mov    (%rax),%rdx
     cb6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     cba:	48 89 10             	mov    %rdx,(%rax)
     cbd:	eb 0b                	jmp    cca <free+0x118>
  } else
    p->s.ptr = bp;
     cbf:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     cc3:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
     cc7:	48 89 10             	mov    %rdx,(%rax)
  freep = p;
     cca:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     cce:	48 89 05 2b 07 00 00 	mov    %rax,0x72b(%rip)        # 1400 <freep>
}
     cd5:	90                   	nop
     cd6:	c9                   	leave
     cd7:	c3                   	ret

0000000000000cd8 <morecore>:

static Header*
morecore(uint nu)
{
     cd8:	55                   	push   %rbp
     cd9:	48 89 e5             	mov    %rsp,%rbp
     cdc:	48 83 ec 20          	sub    $0x20,%rsp
     ce0:	89 7d ec             	mov    %edi,-0x14(%rbp)
  char *p;
  Header *hp;

  if(nu < 4096)
     ce3:	81 7d ec ff 0f 00 00 	cmpl   $0xfff,-0x14(%rbp)
     cea:	77 07                	ja     cf3 <morecore+0x1b>
    nu = 4096;
     cec:	c7 45 ec 00 10 00 00 	movl   $0x1000,-0x14(%rbp)
  p = sbrk(nu * sizeof(Header));
     cf3:	8b 45 ec             	mov    -0x14(%rbp),%eax
     cf6:	c1 e0 04             	shl    $0x4,%eax
     cf9:	89 c7                	mov    %eax,%edi
     cfb:	e8 20 fa ff ff       	call   720 <sbrk>
     d00:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  if(p == (char*)-1)
     d04:	48 83 7d f8 ff       	cmpq   $0xffffffffffffffff,-0x8(%rbp)
     d09:	75 07                	jne    d12 <morecore+0x3a>
    return 0;
     d0b:	b8 00 00 00 00       	mov    $0x0,%eax
     d10:	eb 29                	jmp    d3b <morecore+0x63>
  hp = (Header*)p;
     d12:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     d16:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  hp->s.size = nu;
     d1a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
     d1e:	8b 55 ec             	mov    -0x14(%rbp),%edx
     d21:	89 50 08             	mov    %edx,0x8(%rax)
  free((void*)(hp + 1));
     d24:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
     d28:	48 83 c0 10          	add    $0x10,%rax
     d2c:	48 89 c7             	mov    %rax,%rdi
     d2f:	e8 7e fe ff ff       	call   bb2 <free>
  return freep;
     d34:	48 8b 05 c5 06 00 00 	mov    0x6c5(%rip),%rax        # 1400 <freep>
}
     d3b:	c9                   	leave
     d3c:	c3                   	ret

0000000000000d3d <malloc>:

void*
malloc(uint nbytes)
{
     d3d:	55                   	push   %rbp
     d3e:	48 89 e5             	mov    %rsp,%rbp
     d41:	48 83 ec 30          	sub    $0x30,%rsp
     d45:	89 7d dc             	mov    %edi,-0x24(%rbp)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
     d48:	8b 45 dc             	mov    -0x24(%rbp),%eax
     d4b:	48 83 c0 0f          	add    $0xf,%rax
     d4f:	48 c1 e8 04          	shr    $0x4,%rax
     d53:	83 c0 01             	add    $0x1,%eax
     d56:	89 45 ec             	mov    %eax,-0x14(%rbp)
  if((prevp = freep) == 0){
     d59:	48 8b 05 a0 06 00 00 	mov    0x6a0(%rip),%rax        # 1400 <freep>
     d60:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
     d64:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
     d69:	75 2b                	jne    d96 <malloc+0x59>
    base.s.ptr = freep = prevp = &base;
     d6b:	48 c7 45 f0 f0 13 00 	movq   $0x13f0,-0x10(%rbp)
     d72:	00 
     d73:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
     d77:	48 89 05 82 06 00 00 	mov    %rax,0x682(%rip)        # 1400 <freep>
     d7e:	48 8b 05 7b 06 00 00 	mov    0x67b(%rip),%rax        # 1400 <freep>
     d85:	48 89 05 64 06 00 00 	mov    %rax,0x664(%rip)        # 13f0 <base>
    base.s.size = 0;
     d8c:	c7 05 62 06 00 00 00 	movl   $0x0,0x662(%rip)        # 13f8 <base+0x8>
     d93:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     d96:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
     d9a:	48 8b 00             	mov    (%rax),%rax
     d9d:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
     da1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     da5:	8b 40 08             	mov    0x8(%rax),%eax
     da8:	3b 45 ec             	cmp    -0x14(%rbp),%eax
     dab:	72 5f                	jb     e0c <malloc+0xcf>
      if(p->s.size == nunits)
     dad:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     db1:	8b 40 08             	mov    0x8(%rax),%eax
     db4:	39 45 ec             	cmp    %eax,-0x14(%rbp)
     db7:	75 10                	jne    dc9 <malloc+0x8c>
        prevp->s.ptr = p->s.ptr;
     db9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     dbd:	48 8b 10             	mov    (%rax),%rdx
     dc0:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
     dc4:	48 89 10             	mov    %rdx,(%rax)
     dc7:	eb 2e                	jmp    df7 <malloc+0xba>
      else {
        p->s.size -= nunits;
     dc9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     dcd:	8b 40 08             	mov    0x8(%rax),%eax
     dd0:	2b 45 ec             	sub    -0x14(%rbp),%eax
     dd3:	89 c2                	mov    %eax,%edx
     dd5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     dd9:	89 50 08             	mov    %edx,0x8(%rax)
        p += p->s.size;
     ddc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     de0:	8b 40 08             	mov    0x8(%rax),%eax
     de3:	89 c0                	mov    %eax,%eax
     de5:	48 c1 e0 04          	shl    $0x4,%rax
     de9:	48 01 45 f8          	add    %rax,-0x8(%rbp)
        p->s.size = nunits;
     ded:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     df1:	8b 55 ec             	mov    -0x14(%rbp),%edx
     df4:	89 50 08             	mov    %edx,0x8(%rax)
      }
      freep = prevp;
     df7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
     dfb:	48 89 05 fe 05 00 00 	mov    %rax,0x5fe(%rip)        # 1400 <freep>
      return (void*)(p + 1);
     e02:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     e06:	48 83 c0 10          	add    $0x10,%rax
     e0a:	eb 41                	jmp    e4d <malloc+0x110>
    }
    if(p == freep)
     e0c:	48 8b 05 ed 05 00 00 	mov    0x5ed(%rip),%rax        # 1400 <freep>
     e13:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
     e17:	75 1c                	jne    e35 <malloc+0xf8>
      if((p = morecore(nunits)) == 0)
     e19:	8b 45 ec             	mov    -0x14(%rbp),%eax
     e1c:	89 c7                	mov    %eax,%edi
     e1e:	e8 b5 fe ff ff       	call   cd8 <morecore>
     e23:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
     e27:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
     e2c:	75 07                	jne    e35 <malloc+0xf8>
        return 0;
     e2e:	b8 00 00 00 00       	mov    $0x0,%eax
     e33:	eb 18                	jmp    e4d <malloc+0x110>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     e35:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     e39:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
     e3d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     e41:	48 8b 00             	mov    (%rax),%rax
     e44:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
     e48:	e9 54 ff ff ff       	jmp    da1 <malloc+0x64>
  }
}
     e4d:	c9                   	leave
     e4e:	c3                   	ret

0000000000000e4f <createRoot>:
#include "set.h"
#include "user.h"

//TODO: Να μην είναι περιορισμένο σε int

Set* createRoot(){
     e4f:	55                   	push   %rbp
     e50:	48 89 e5             	mov    %rsp,%rbp
     e53:	48 83 ec 10          	sub    $0x10,%rsp
    //Αρχικοποίηση του Set
    Set *set = malloc(sizeof(Set));
     e57:	bf 10 00 00 00       	mov    $0x10,%edi
     e5c:	e8 dc fe ff ff       	call   d3d <malloc>
     e61:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    set->size = 0;
     e65:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     e69:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%rax)
    set->root = NULL;
     e70:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     e74:	48 c7 00 00 00 00 00 	movq   $0x0,(%rax)
    return set;
     e7b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
     e7f:	c9                   	leave
     e80:	c3                   	ret

0000000000000e81 <createNode>:

void createNode(int i, Set *set){
     e81:	55                   	push   %rbp
     e82:	48 89 e5             	mov    %rsp,%rbp
     e85:	48 83 ec 20          	sub    $0x20,%rsp
     e89:	89 7d ec             	mov    %edi,-0x14(%rbp)
     e8c:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    Η συνάρτηση αυτή δημιουργεί ένα νέο SetNode με την τιμή i και εφόσον δεν υπάρχει στο Set το προσθέτει στο τέλος του συνόλου.
    Σημείωση: Ίσως υπάρχει καλύτερος τρόπος για την υλοποίηση.
    */

    //Αρχικοποίηση του SetNode
    SetNode *temp = malloc(sizeof(SetNode));
     e90:	bf 10 00 00 00       	mov    $0x10,%edi
     e95:	e8 a3 fe ff ff       	call   d3d <malloc>
     e9a:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    temp->i = i;
     e9e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
     ea2:	8b 55 ec             	mov    -0x14(%rbp),%edx
     ea5:	89 10                	mov    %edx,(%rax)
    temp->next = NULL;
     ea7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
     eab:	48 c7 40 08 00 00 00 	movq   $0x0,0x8(%rax)
     eb2:	00 

    //Έλεγχος ύπαρξης του i
    SetNode *curr = set->root;//Ξεκινάει από την root
     eb3:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
     eb7:	48 8b 00             	mov    (%rax),%rax
     eba:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(curr != NULL) { //Εφόσον το Set δεν είναι άδειο
     ebe:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
     ec3:	74 34                	je     ef9 <createNode+0x78>
        while (curr->next != NULL){ //Εφόσον υπάρχει επόμενο node
     ec5:	eb 25                	jmp    eec <createNode+0x6b>
            if (curr->i == i){ //Αν το i υπάρχει στο σύνολο
     ec7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     ecb:	8b 00                	mov    (%rax),%eax
     ecd:	39 45 ec             	cmp    %eax,-0x14(%rbp)
     ed0:	75 0e                	jne    ee0 <createNode+0x5f>
                free(temp); 
     ed2:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
     ed6:	48 89 c7             	mov    %rax,%rdi
     ed9:	e8 d4 fc ff ff       	call   bb2 <free>
                return; //Δεν εκτελούμε την υπόλοιπη συνάρτηση
     ede:	eb 4e                	jmp    f2e <createNode+0xad>
            }
            curr = curr->next; //Επόμενο SetNode
     ee0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     ee4:	48 8b 40 08          	mov    0x8(%rax),%rax
     ee8:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
        while (curr->next != NULL){ //Εφόσον υπάρχει επόμενο node
     eec:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     ef0:	48 8b 40 08          	mov    0x8(%rax),%rax
     ef4:	48 85 c0             	test   %rax,%rax
     ef7:	75 ce                	jne    ec7 <createNode+0x46>
        }
    }
    /*
    Ο έλεγχος στην if είναι απαραίτητος για να ελεγχθεί το τελευταίο SetNode.
    */
    if (curr->i != i) attachNode(set, curr, temp); 
     ef9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     efd:	8b 00                	mov    (%rax),%eax
     eff:	39 45 ec             	cmp    %eax,-0x14(%rbp)
     f02:	74 1e                	je     f22 <createNode+0xa1>
     f04:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
     f08:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
     f0c:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
     f10:	48 89 ce             	mov    %rcx,%rsi
     f13:	48 89 c7             	mov    %rax,%rdi
     f16:	b8 00 00 00 00       	mov    $0x0,%eax
     f1b:	e8 10 00 00 00       	call   f30 <attachNode>
     f20:	eb 0c                	jmp    f2e <createNode+0xad>
    else free(temp);
     f22:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
     f26:	48 89 c7             	mov    %rax,%rdi
     f29:	e8 84 fc ff ff       	call   bb2 <free>
}
     f2e:	c9                   	leave
     f2f:	c3                   	ret

0000000000000f30 <attachNode>:

void attachNode(Set *set, SetNode *curr, SetNode *temp){
     f30:	55                   	push   %rbp
     f31:	48 89 e5             	mov    %rsp,%rbp
     f34:	48 83 ec 18          	sub    $0x18,%rsp
     f38:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
     f3c:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
     f40:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
    //Βάζουμε το temp στο τέλος του Set
    if(set->size == 0) set->root = temp;
     f44:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     f48:	8b 40 08             	mov    0x8(%rax),%eax
     f4b:	85 c0                	test   %eax,%eax
     f4d:	75 0d                	jne    f5c <attachNode+0x2c>
     f4f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     f53:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
     f57:	48 89 10             	mov    %rdx,(%rax)
     f5a:	eb 0c                	jmp    f68 <attachNode+0x38>
    else curr->next = temp;
     f5c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
     f60:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
     f64:	48 89 50 08          	mov    %rdx,0x8(%rax)
    set->size += 1;
     f68:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     f6c:	8b 40 08             	mov    0x8(%rax),%eax
     f6f:	8d 50 01             	lea    0x1(%rax),%edx
     f72:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     f76:	89 50 08             	mov    %edx,0x8(%rax)
}
     f79:	90                   	nop
     f7a:	c9                   	leave
     f7b:	c3                   	ret

0000000000000f7c <deleteSet>:

void deleteSet(Set *set){
     f7c:	55                   	push   %rbp
     f7d:	48 89 e5             	mov    %rsp,%rbp
     f80:	48 83 ec 20          	sub    $0x20,%rsp
     f84:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    if (set == NULL) return; //Αν ο χρήστης είναι ΜΛΚ!
     f88:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
     f8d:	74 42                	je     fd1 <deleteSet+0x55>
    SetNode *temp;
    SetNode *curr = set->root; //Ξεκινάμε από το root
     f8f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
     f93:	48 8b 00             	mov    (%rax),%rax
     f96:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    while (curr != NULL){ 
     f9a:	eb 20                	jmp    fbc <deleteSet+0x40>
        temp = curr->next; //Αναφορά στο επόμενο SetNode
     f9c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     fa0:	48 8b 40 08          	mov    0x8(%rax),%rax
     fa4:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
        free(curr); //Απελευθέρωση της curr
     fa8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     fac:	48 89 c7             	mov    %rax,%rdi
     faf:	e8 fe fb ff ff       	call   bb2 <free>
        curr = temp;
     fb4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
     fb8:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    while (curr != NULL){ 
     fbc:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
     fc1:	75 d9                	jne    f9c <deleteSet+0x20>
    }
    free(set); //Διαγραφή του Set
     fc3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
     fc7:	48 89 c7             	mov    %rax,%rdi
     fca:	e8 e3 fb ff ff       	call   bb2 <free>
     fcf:	eb 01                	jmp    fd2 <deleteSet+0x56>
    if (set == NULL) return; //Αν ο χρήστης είναι ΜΛΚ!
     fd1:	90                   	nop
}
     fd2:	c9                   	leave
     fd3:	c3                   	ret

0000000000000fd4 <getNodeAtPosition>:

SetNode* getNodeAtPosition(Set *set, int i){
     fd4:	55                   	push   %rbp
     fd5:	48 89 e5             	mov    %rsp,%rbp
     fd8:	48 83 ec 20          	sub    $0x20,%rsp
     fdc:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
     fe0:	89 75 e4             	mov    %esi,-0x1c(%rbp)
    if (set == NULL || set->root == NULL) return NULL; //Αν ο χρήστης είναι ΜΛΚ!
     fe3:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
     fe8:	74 0c                	je     ff6 <getNodeAtPosition+0x22>
     fea:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
     fee:	48 8b 00             	mov    (%rax),%rax
     ff1:	48 85 c0             	test   %rax,%rax
     ff4:	75 07                	jne    ffd <getNodeAtPosition+0x29>
     ff6:	b8 00 00 00 00       	mov    $0x0,%eax
     ffb:	eb 3d                	jmp    103a <getNodeAtPosition+0x66>

    SetNode *curr = set->root;
     ffd:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1001:	48 8b 00             	mov    (%rax),%rax
    1004:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    int n;

    for(n = 0; n<i && curr->next != NULL; n++) curr = curr->next; //Ο έλεγχος εδω είναι: n<i && curr->next != NULL
    1008:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
    100f:	eb 10                	jmp    1021 <getNodeAtPosition+0x4d>
    1011:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1015:	48 8b 40 08          	mov    0x8(%rax),%rax
    1019:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    101d:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
    1021:	8b 45 f4             	mov    -0xc(%rbp),%eax
    1024:	3b 45 e4             	cmp    -0x1c(%rbp),%eax
    1027:	7d 0d                	jge    1036 <getNodeAtPosition+0x62>
    1029:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    102d:	48 8b 40 08          	mov    0x8(%rax),%rax
    1031:	48 85 c0             	test   %rax,%rax
    1034:	75 db                	jne    1011 <getNodeAtPosition+0x3d>
    return curr;
    1036:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    103a:	c9                   	leave
    103b:	c3                   	ret
