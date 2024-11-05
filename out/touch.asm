
fs/touch:     file format elf64-x86-64


Disassembly of section .text:

0000000000000000 <main>:
char* getFileName(char *argv[]);
char* manageFileNameInput(char* argv[]);
int getFlagInt(char *flag);
void cFlagHandler(char* filename, char *argv[], int i);

int main(int argc, char *argv[]){
   0:	55                   	push   %rbp
   1:	48 89 e5             	mov    %rsp,%rbp
   4:	48 83 ec 20          	sub    $0x20,%rsp
   8:	89 7d ec             	mov    %edi,-0x14(%rbp)
   b:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    char* filename;

    if (argc <= 1) { //Αν δεν υπάρχει όνομα για το αρχείο
   f:	83 7d ec 01          	cmpl   $0x1,-0x14(%rbp)
  13:	7f 1b                	jg     30 <main+0x30>
        printf(1, "touch: file name not defined\n");
  15:	48 c7 c6 2c 0e 00 00 	mov    $0xe2c,%rsi
  1c:	bf 01 00 00 00       	mov    $0x1,%edi
  21:	b8 00 00 00 00       	mov    $0x0,%eax
  26:	e8 0f 06 00 00       	call   63a <printf>
        exit();
  2b:	e8 58 04 00 00       	call   488 <exit>
    }
    filename = manageFileNameInput(argv); //Validate το όνομα του αρχείου
  30:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  34:	48 89 c7             	mov    %rax,%rdi
  37:	e8 2b 00 00 00       	call   67 <manageFileNameInput>
  3c:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    mknod(filename, 0, 0); // Δημηουργία του αρχείου
  40:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  44:	ba 00 00 00 00       	mov    $0x0,%edx
  49:	be 00 00 00 00       	mov    $0x0,%esi
  4e:	48 89 c7             	mov    %rax,%rdi
  51:	e8 7a 04 00 00       	call   4d0 <mknod>
    free(filename);
  56:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  5a:	48 89 c7             	mov    %rax,%rdi
  5d:	e8 40 09 00 00       	call   9a2 <free>
    exit();
  62:	e8 21 04 00 00       	call   488 <exit>

0000000000000067 <manageFileNameInput>:
}

char* manageFileNameInput(char* argv[]){
  67:	55                   	push   %rbp
  68:	48 89 e5             	mov    %rsp,%rbp
  6b:	48 83 ec 20          	sub    $0x20,%rsp
  6f:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    char* filename = getFileName(argv);
  73:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  77:	48 89 c7             	mov    %rax,%rdi
  7a:	e8 35 00 00 00       	call   b4 <getFileName>
  7f:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(validateFileName(filename) == 0){ //Input validation fail
  83:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  87:	48 89 c7             	mov    %rax,%rdi
  8a:	e8 72 00 00 00       	call   101 <validateFileName>
  8f:	85 c0                	test   %eax,%eax
  91:	75 1b                	jne    ae <manageFileNameInput+0x47>
        printf(1, "touch: file name invalid\n");
  93:	48 c7 c6 4a 0e 00 00 	mov    $0xe4a,%rsi
  9a:	bf 01 00 00 00       	mov    $0x1,%edi
  9f:	b8 00 00 00 00       	mov    $0x0,%eax
  a4:	e8 91 05 00 00       	call   63a <printf>
        exit();
  a9:	e8 da 03 00 00       	call   488 <exit>
    }
    return filename;
  ae:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
  b2:	c9                   	leave
  b3:	c3                   	ret

00000000000000b4 <getFileName>:

char* getFileName(char *argv[]){
  b4:	55                   	push   %rbp
  b5:	48 89 e5             	mov    %rsp,%rbp
  b8:	48 83 ec 20          	sub    $0x20,%rsp
  bc:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    char* filename = malloc(strlen(argv[1])+1); //Δεσμεύουμε μνήμη για το όνομα του αρχείο
  c0:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  c4:	48 83 c0 08          	add    $0x8,%rax
  c8:	48 8b 00             	mov    (%rax),%rax
  cb:	48 89 c7             	mov    %rax,%rdi
  ce:	e8 8e 01 00 00       	call   261 <strlen>
  d3:	83 c0 01             	add    $0x1,%eax
  d6:	89 c7                	mov    %eax,%edi
  d8:	e8 50 0a 00 00       	call   b2d <malloc>
  dd:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    strcpy(filename, argv[1]); //Αντιγρφή του ονόματος στη θέση μνήμης της filename
  e1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  e5:	48 83 c0 08          	add    $0x8,%rax
  e9:	48 8b 10             	mov    (%rax),%rdx
  ec:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  f0:	48 89 d6             	mov    %rdx,%rsi
  f3:	48 89 c7             	mov    %rax,%rdi
  f6:	e8 d0 00 00 00       	call   1cb <strcpy>
    return filename;
  fb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
  ff:	c9                   	leave
 100:	c3                   	ret

0000000000000101 <validateFileName>:

int validateFileName(char* s){
 101:	55                   	push   %rbp
 102:	48 89 e5             	mov    %rsp,%rbp
 105:	48 83 ec 18          	sub    $0x18,%rsp
 109:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    int i, match = 1;
 10d:	c7 45 f8 01 00 00 00 	movl   $0x1,-0x8(%rbp)
    for(i=0; s[i] != '\0'; i++){ //Για κάθε χαρακτήρα του ονόματος
 114:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
 11b:	eb 5f                	jmp    17c <validateFileName+0x7b>
        int d = (unsigned char) s[i]; //ASCII code
 11d:	8b 45 fc             	mov    -0x4(%rbp),%eax
 120:	48 63 d0             	movslq %eax,%rdx
 123:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 127:	48 01 d0             	add    %rdx,%rax
 12a:	0f b6 00             	movzbl (%rax),%eax
 12d:	0f b6 c0             	movzbl %al,%eax
 130:	89 45 f4             	mov    %eax,-0xc(%rbp)
        int charmatch = ((d >= ASCII_a && d <= ASCII_z) || //validation
                         (d >= ASCII_A && d <= ASCII_Z) ||
                         (d >= ASCII_0 && d <= ASCII_9) ||
                          d == ASCII__ || d == ASCII_DOT);
 133:	83 7d f4 60          	cmpl   $0x60,-0xc(%rbp)
 137:	7e 06                	jle    13f <validateFileName+0x3e>
        int charmatch = ((d >= ASCII_a && d <= ASCII_z) || //validation
 139:	83 7d f4 7a          	cmpl   $0x7a,-0xc(%rbp)
 13d:	7e 24                	jle    163 <validateFileName+0x62>
 13f:	83 7d f4 40          	cmpl   $0x40,-0xc(%rbp)
 143:	7e 06                	jle    14b <validateFileName+0x4a>
                         (d >= ASCII_A && d <= ASCII_Z) ||
 145:	83 7d f4 5a          	cmpl   $0x5a,-0xc(%rbp)
 149:	7e 18                	jle    163 <validateFileName+0x62>
 14b:	83 7d f4 2f          	cmpl   $0x2f,-0xc(%rbp)
 14f:	7e 06                	jle    157 <validateFileName+0x56>
                         (d >= ASCII_0 && d <= ASCII_9) ||
 151:	83 7d f4 39          	cmpl   $0x39,-0xc(%rbp)
 155:	7e 0c                	jle    163 <validateFileName+0x62>
 157:	83 7d f4 5f          	cmpl   $0x5f,-0xc(%rbp)
 15b:	74 06                	je     163 <validateFileName+0x62>
                          d == ASCII__ || d == ASCII_DOT);
 15d:	83 7d f4 2e          	cmpl   $0x2e,-0xc(%rbp)
 161:	75 07                	jne    16a <validateFileName+0x69>
 163:	b8 01 00 00 00       	mov    $0x1,%eax
 168:	eb 05                	jmp    16f <validateFileName+0x6e>
 16a:	b8 00 00 00 00       	mov    $0x0,%eax
        int charmatch = ((d >= ASCII_a && d <= ASCII_z) || //validation
 16f:	89 45 f0             	mov    %eax,-0x10(%rbp)
        match = match & charmatch; // bitwise AND
 172:	8b 45 f0             	mov    -0x10(%rbp),%eax
 175:	21 45 f8             	and    %eax,-0x8(%rbp)
    for(i=0; s[i] != '\0'; i++){ //Για κάθε χαρακτήρα του ονόματος
 178:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
 17c:	8b 45 fc             	mov    -0x4(%rbp),%eax
 17f:	48 63 d0             	movslq %eax,%rdx
 182:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 186:	48 01 d0             	add    %rdx,%rax
 189:	0f b6 00             	movzbl (%rax),%eax
 18c:	84 c0                	test   %al,%al
 18e:	75 8d                	jne    11d <validateFileName+0x1c>
    }
    return match;
 190:	8b 45 f8             	mov    -0x8(%rbp),%eax
}
 193:	c9                   	leave
 194:	c3                   	ret

0000000000000195 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
 195:	55                   	push   %rbp
 196:	48 89 e5             	mov    %rsp,%rbp
 199:	48 83 ec 10          	sub    $0x10,%rsp
 19d:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
 1a1:	89 75 f4             	mov    %esi,-0xc(%rbp)
 1a4:	89 55 f0             	mov    %edx,-0x10(%rbp)
  asm volatile("cld; rep stosb" :
 1a7:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
 1ab:	8b 55 f0             	mov    -0x10(%rbp),%edx
 1ae:	8b 45 f4             	mov    -0xc(%rbp),%eax
 1b1:	48 89 ce             	mov    %rcx,%rsi
 1b4:	48 89 f7             	mov    %rsi,%rdi
 1b7:	89 d1                	mov    %edx,%ecx
 1b9:	fc                   	cld
 1ba:	f3 aa                	rep stos %al,%es:(%rdi)
 1bc:	89 ca                	mov    %ecx,%edx
 1be:	48 89 fe             	mov    %rdi,%rsi
 1c1:	48 89 75 f8          	mov    %rsi,-0x8(%rbp)
 1c5:	89 55 f0             	mov    %edx,-0x10(%rbp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
 1c8:	90                   	nop
 1c9:	c9                   	leave
 1ca:	c3                   	ret

00000000000001cb <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 1cb:	55                   	push   %rbp
 1cc:	48 89 e5             	mov    %rsp,%rbp
 1cf:	48 83 ec 20          	sub    $0x20,%rsp
 1d3:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
 1d7:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  char *os;

  os = s;
 1db:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 1df:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  while((*s++ = *t++) != 0)
 1e3:	90                   	nop
 1e4:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
 1e8:	48 8d 42 01          	lea    0x1(%rdx),%rax
 1ec:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
 1f0:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 1f4:	48 8d 48 01          	lea    0x1(%rax),%rcx
 1f8:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
 1fc:	0f b6 12             	movzbl (%rdx),%edx
 1ff:	88 10                	mov    %dl,(%rax)
 201:	0f b6 00             	movzbl (%rax),%eax
 204:	84 c0                	test   %al,%al
 206:	75 dc                	jne    1e4 <strcpy+0x19>
    ;
  return os;
 208:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
 20c:	c9                   	leave
 20d:	c3                   	ret

000000000000020e <strcmp>:

int
strcmp(const char *p, const char *q)
{
 20e:	55                   	push   %rbp
 20f:	48 89 e5             	mov    %rsp,%rbp
 212:	48 83 ec 10          	sub    $0x10,%rsp
 216:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
 21a:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  while(*p && *p == *q)
 21e:	eb 0a                	jmp    22a <strcmp+0x1c>
    p++, q++;
 220:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
 225:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  while(*p && *p == *q)
 22a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 22e:	0f b6 00             	movzbl (%rax),%eax
 231:	84 c0                	test   %al,%al
 233:	74 12                	je     247 <strcmp+0x39>
 235:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 239:	0f b6 10             	movzbl (%rax),%edx
 23c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 240:	0f b6 00             	movzbl (%rax),%eax
 243:	38 c2                	cmp    %al,%dl
 245:	74 d9                	je     220 <strcmp+0x12>
  return (uchar)*p - (uchar)*q;
 247:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 24b:	0f b6 00             	movzbl (%rax),%eax
 24e:	0f b6 d0             	movzbl %al,%edx
 251:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 255:	0f b6 00             	movzbl (%rax),%eax
 258:	0f b6 c0             	movzbl %al,%eax
 25b:	29 c2                	sub    %eax,%edx
 25d:	89 d0                	mov    %edx,%eax
}
 25f:	c9                   	leave
 260:	c3                   	ret

0000000000000261 <strlen>:

uint
strlen(char *s)
{
 261:	55                   	push   %rbp
 262:	48 89 e5             	mov    %rsp,%rbp
 265:	48 83 ec 18          	sub    $0x18,%rsp
 269:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  int n;

  for(n = 0; s[n]; n++)
 26d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
 274:	eb 04                	jmp    27a <strlen+0x19>
 276:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
 27a:	8b 45 fc             	mov    -0x4(%rbp),%eax
 27d:	48 63 d0             	movslq %eax,%rdx
 280:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 284:	48 01 d0             	add    %rdx,%rax
 287:	0f b6 00             	movzbl (%rax),%eax
 28a:	84 c0                	test   %al,%al
 28c:	75 e8                	jne    276 <strlen+0x15>
    ;
  return n;
 28e:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
 291:	c9                   	leave
 292:	c3                   	ret

0000000000000293 <memset>:

void*
memset(void *dst, int c, uint n)
{
 293:	55                   	push   %rbp
 294:	48 89 e5             	mov    %rsp,%rbp
 297:	48 83 ec 10          	sub    $0x10,%rsp
 29b:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
 29f:	89 75 f4             	mov    %esi,-0xc(%rbp)
 2a2:	89 55 f0             	mov    %edx,-0x10(%rbp)
  stosb(dst, c, n);
 2a5:	8b 55 f0             	mov    -0x10(%rbp),%edx
 2a8:	8b 4d f4             	mov    -0xc(%rbp),%ecx
 2ab:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 2af:	89 ce                	mov    %ecx,%esi
 2b1:	48 89 c7             	mov    %rax,%rdi
 2b4:	e8 dc fe ff ff       	call   195 <stosb>
  return dst;
 2b9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
 2bd:	c9                   	leave
 2be:	c3                   	ret

00000000000002bf <strchr>:

char*
strchr(const char *s, char c)
{
 2bf:	55                   	push   %rbp
 2c0:	48 89 e5             	mov    %rsp,%rbp
 2c3:	48 83 ec 10          	sub    $0x10,%rsp
 2c7:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
 2cb:	89 f0                	mov    %esi,%eax
 2cd:	88 45 f4             	mov    %al,-0xc(%rbp)
  for(; *s; s++)
 2d0:	eb 17                	jmp    2e9 <strchr+0x2a>
    if(*s == c)
 2d2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 2d6:	0f b6 00             	movzbl (%rax),%eax
 2d9:	38 45 f4             	cmp    %al,-0xc(%rbp)
 2dc:	75 06                	jne    2e4 <strchr+0x25>
      return (char*)s;
 2de:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 2e2:	eb 15                	jmp    2f9 <strchr+0x3a>
  for(; *s; s++)
 2e4:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
 2e9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 2ed:	0f b6 00             	movzbl (%rax),%eax
 2f0:	84 c0                	test   %al,%al
 2f2:	75 de                	jne    2d2 <strchr+0x13>
  return 0;
 2f4:	b8 00 00 00 00       	mov    $0x0,%eax
}
 2f9:	c9                   	leave
 2fa:	c3                   	ret

00000000000002fb <gets>:

char*
gets(char *buf, int max)
{
 2fb:	55                   	push   %rbp
 2fc:	48 89 e5             	mov    %rsp,%rbp
 2ff:	48 83 ec 20          	sub    $0x20,%rsp
 303:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
 307:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 30a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
 311:	eb 48                	jmp    35b <gets+0x60>
    cc = read(0, &c, 1);
 313:	48 8d 45 f7          	lea    -0x9(%rbp),%rax
 317:	ba 01 00 00 00       	mov    $0x1,%edx
 31c:	48 89 c6             	mov    %rax,%rsi
 31f:	bf 00 00 00 00       	mov    $0x0,%edi
 324:	e8 77 01 00 00       	call   4a0 <read>
 329:	89 45 f8             	mov    %eax,-0x8(%rbp)
    if(cc < 1)
 32c:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
 330:	7e 36                	jle    368 <gets+0x6d>
      break;
    buf[i++] = c;
 332:	8b 45 fc             	mov    -0x4(%rbp),%eax
 335:	8d 50 01             	lea    0x1(%rax),%edx
 338:	89 55 fc             	mov    %edx,-0x4(%rbp)
 33b:	48 63 d0             	movslq %eax,%rdx
 33e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 342:	48 01 c2             	add    %rax,%rdx
 345:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
 349:	88 02                	mov    %al,(%rdx)
    if(c == '\n' || c == '\r')
 34b:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
 34f:	3c 0a                	cmp    $0xa,%al
 351:	74 16                	je     369 <gets+0x6e>
 353:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
 357:	3c 0d                	cmp    $0xd,%al
 359:	74 0e                	je     369 <gets+0x6e>
  for(i=0; i+1 < max; ){
 35b:	8b 45 fc             	mov    -0x4(%rbp),%eax
 35e:	83 c0 01             	add    $0x1,%eax
 361:	39 45 e4             	cmp    %eax,-0x1c(%rbp)
 364:	7f ad                	jg     313 <gets+0x18>
 366:	eb 01                	jmp    369 <gets+0x6e>
      break;
 368:	90                   	nop
      break;
  }
  buf[i] = '\0';
 369:	8b 45 fc             	mov    -0x4(%rbp),%eax
 36c:	48 63 d0             	movslq %eax,%rdx
 36f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 373:	48 01 d0             	add    %rdx,%rax
 376:	c6 00 00             	movb   $0x0,(%rax)
  return buf;
 379:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
 37d:	c9                   	leave
 37e:	c3                   	ret

000000000000037f <stat>:

int
stat(char *n, struct stat *st)
{
 37f:	55                   	push   %rbp
 380:	48 89 e5             	mov    %rsp,%rbp
 383:	48 83 ec 20          	sub    $0x20,%rsp
 387:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
 38b:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 38f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 393:	be 00 00 00 00       	mov    $0x0,%esi
 398:	48 89 c7             	mov    %rax,%rdi
 39b:	e8 28 01 00 00       	call   4c8 <open>
 3a0:	89 45 fc             	mov    %eax,-0x4(%rbp)
  if(fd < 0)
 3a3:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
 3a7:	79 07                	jns    3b0 <stat+0x31>
    return -1;
 3a9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 3ae:	eb 21                	jmp    3d1 <stat+0x52>
  r = fstat(fd, st);
 3b0:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
 3b4:	8b 45 fc             	mov    -0x4(%rbp),%eax
 3b7:	48 89 d6             	mov    %rdx,%rsi
 3ba:	89 c7                	mov    %eax,%edi
 3bc:	e8 1f 01 00 00       	call   4e0 <fstat>
 3c1:	89 45 f8             	mov    %eax,-0x8(%rbp)
  close(fd);
 3c4:	8b 45 fc             	mov    -0x4(%rbp),%eax
 3c7:	89 c7                	mov    %eax,%edi
 3c9:	e8 e2 00 00 00       	call   4b0 <close>
  return r;
 3ce:	8b 45 f8             	mov    -0x8(%rbp),%eax
}
 3d1:	c9                   	leave
 3d2:	c3                   	ret

00000000000003d3 <atoi>:

int
atoi(const char *s)
{
 3d3:	55                   	push   %rbp
 3d4:	48 89 e5             	mov    %rsp,%rbp
 3d7:	48 83 ec 18          	sub    $0x18,%rsp
 3db:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  int n;

  n = 0;
 3df:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  while('0' <= *s && *s <= '9')
 3e6:	eb 28                	jmp    410 <atoi+0x3d>
    n = n*10 + *s++ - '0';
 3e8:	8b 55 fc             	mov    -0x4(%rbp),%edx
 3eb:	89 d0                	mov    %edx,%eax
 3ed:	c1 e0 02             	shl    $0x2,%eax
 3f0:	01 d0                	add    %edx,%eax
 3f2:	01 c0                	add    %eax,%eax
 3f4:	89 c1                	mov    %eax,%ecx
 3f6:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 3fa:	48 8d 50 01          	lea    0x1(%rax),%rdx
 3fe:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
 402:	0f b6 00             	movzbl (%rax),%eax
 405:	0f be c0             	movsbl %al,%eax
 408:	01 c8                	add    %ecx,%eax
 40a:	83 e8 30             	sub    $0x30,%eax
 40d:	89 45 fc             	mov    %eax,-0x4(%rbp)
  while('0' <= *s && *s <= '9')
 410:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 414:	0f b6 00             	movzbl (%rax),%eax
 417:	3c 2f                	cmp    $0x2f,%al
 419:	7e 0b                	jle    426 <atoi+0x53>
 41b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 41f:	0f b6 00             	movzbl (%rax),%eax
 422:	3c 39                	cmp    $0x39,%al
 424:	7e c2                	jle    3e8 <atoi+0x15>
  return n;
 426:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
 429:	c9                   	leave
 42a:	c3                   	ret

000000000000042b <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 42b:	55                   	push   %rbp
 42c:	48 89 e5             	mov    %rsp,%rbp
 42f:	48 83 ec 28          	sub    $0x28,%rsp
 433:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
 437:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
 43b:	89 55 dc             	mov    %edx,-0x24(%rbp)
  char *dst, *src;
  
  dst = vdst;
 43e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 442:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  src = vsrc;
 446:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
 44a:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  while(n-- > 0)
 44e:	eb 1d                	jmp    46d <memmove+0x42>
    *dst++ = *src++;
 450:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
 454:	48 8d 42 01          	lea    0x1(%rdx),%rax
 458:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
 45c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 460:	48 8d 48 01          	lea    0x1(%rax),%rcx
 464:	48 89 4d f8          	mov    %rcx,-0x8(%rbp)
 468:	0f b6 12             	movzbl (%rdx),%edx
 46b:	88 10                	mov    %dl,(%rax)
  while(n-- > 0)
 46d:	8b 45 dc             	mov    -0x24(%rbp),%eax
 470:	8d 50 ff             	lea    -0x1(%rax),%edx
 473:	89 55 dc             	mov    %edx,-0x24(%rbp)
 476:	85 c0                	test   %eax,%eax
 478:	7f d6                	jg     450 <memmove+0x25>
  return vdst;
 47a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
 47e:	c9                   	leave
 47f:	c3                   	ret

0000000000000480 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 480:	b8 01 00 00 00       	mov    $0x1,%eax
 485:	cd 40                	int    $0x40
 487:	c3                   	ret

0000000000000488 <exit>:
SYSCALL(exit)
 488:	b8 02 00 00 00       	mov    $0x2,%eax
 48d:	cd 40                	int    $0x40
 48f:	c3                   	ret

0000000000000490 <wait>:
SYSCALL(wait)
 490:	b8 03 00 00 00       	mov    $0x3,%eax
 495:	cd 40                	int    $0x40
 497:	c3                   	ret

0000000000000498 <pipe>:
SYSCALL(pipe)
 498:	b8 04 00 00 00       	mov    $0x4,%eax
 49d:	cd 40                	int    $0x40
 49f:	c3                   	ret

00000000000004a0 <read>:
SYSCALL(read)
 4a0:	b8 05 00 00 00       	mov    $0x5,%eax
 4a5:	cd 40                	int    $0x40
 4a7:	c3                   	ret

00000000000004a8 <write>:
SYSCALL(write)
 4a8:	b8 10 00 00 00       	mov    $0x10,%eax
 4ad:	cd 40                	int    $0x40
 4af:	c3                   	ret

00000000000004b0 <close>:
SYSCALL(close)
 4b0:	b8 15 00 00 00       	mov    $0x15,%eax
 4b5:	cd 40                	int    $0x40
 4b7:	c3                   	ret

00000000000004b8 <kill>:
SYSCALL(kill)
 4b8:	b8 06 00 00 00       	mov    $0x6,%eax
 4bd:	cd 40                	int    $0x40
 4bf:	c3                   	ret

00000000000004c0 <exec>:
SYSCALL(exec)
 4c0:	b8 07 00 00 00       	mov    $0x7,%eax
 4c5:	cd 40                	int    $0x40
 4c7:	c3                   	ret

00000000000004c8 <open>:
SYSCALL(open)
 4c8:	b8 0f 00 00 00       	mov    $0xf,%eax
 4cd:	cd 40                	int    $0x40
 4cf:	c3                   	ret

00000000000004d0 <mknod>:
SYSCALL(mknod)
 4d0:	b8 11 00 00 00       	mov    $0x11,%eax
 4d5:	cd 40                	int    $0x40
 4d7:	c3                   	ret

00000000000004d8 <unlink>:
SYSCALL(unlink)
 4d8:	b8 12 00 00 00       	mov    $0x12,%eax
 4dd:	cd 40                	int    $0x40
 4df:	c3                   	ret

00000000000004e0 <fstat>:
SYSCALL(fstat)
 4e0:	b8 08 00 00 00       	mov    $0x8,%eax
 4e5:	cd 40                	int    $0x40
 4e7:	c3                   	ret

00000000000004e8 <link>:
SYSCALL(link)
 4e8:	b8 13 00 00 00       	mov    $0x13,%eax
 4ed:	cd 40                	int    $0x40
 4ef:	c3                   	ret

00000000000004f0 <mkdir>:
SYSCALL(mkdir)
 4f0:	b8 14 00 00 00       	mov    $0x14,%eax
 4f5:	cd 40                	int    $0x40
 4f7:	c3                   	ret

00000000000004f8 <chdir>:
SYSCALL(chdir)
 4f8:	b8 09 00 00 00       	mov    $0x9,%eax
 4fd:	cd 40                	int    $0x40
 4ff:	c3                   	ret

0000000000000500 <dup>:
SYSCALL(dup)
 500:	b8 0a 00 00 00       	mov    $0xa,%eax
 505:	cd 40                	int    $0x40
 507:	c3                   	ret

0000000000000508 <getpid>:
SYSCALL(getpid)
 508:	b8 0b 00 00 00       	mov    $0xb,%eax
 50d:	cd 40                	int    $0x40
 50f:	c3                   	ret

0000000000000510 <sbrk>:
SYSCALL(sbrk)
 510:	b8 0c 00 00 00       	mov    $0xc,%eax
 515:	cd 40                	int    $0x40
 517:	c3                   	ret

0000000000000518 <sleep>:
SYSCALL(sleep)
 518:	b8 0d 00 00 00       	mov    $0xd,%eax
 51d:	cd 40                	int    $0x40
 51f:	c3                   	ret

0000000000000520 <uptime>:
SYSCALL(uptime)
 520:	b8 0e 00 00 00       	mov    $0xe,%eax
 525:	cd 40                	int    $0x40
 527:	c3                   	ret

0000000000000528 <getpinfo>:
SYSCALL(getpinfo)
 528:	b8 18 00 00 00       	mov    $0x18,%eax
 52d:	cd 40                	int    $0x40
 52f:	c3                   	ret

0000000000000530 <getfavnum>:
SYSCALL(getfavnum)
 530:	b8 19 00 00 00       	mov    $0x19,%eax
 535:	cd 40                	int    $0x40
 537:	c3                   	ret

0000000000000538 <shutdown>:
SYSCALL(shutdown)
 538:	b8 1a 00 00 00       	mov    $0x1a,%eax
 53d:	cd 40                	int    $0x40
 53f:	c3                   	ret

0000000000000540 <getcount>:
SYSCALL(getcount)
 540:	b8 1b 00 00 00       	mov    $0x1b,%eax
 545:	cd 40                	int    $0x40
 547:	c3                   	ret

0000000000000548 <killrandom>:
 548:	b8 1c 00 00 00       	mov    $0x1c,%eax
 54d:	cd 40                	int    $0x40
 54f:	c3                   	ret

0000000000000550 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 550:	55                   	push   %rbp
 551:	48 89 e5             	mov    %rsp,%rbp
 554:	48 83 ec 10          	sub    $0x10,%rsp
 558:	89 7d fc             	mov    %edi,-0x4(%rbp)
 55b:	89 f0                	mov    %esi,%eax
 55d:	88 45 f8             	mov    %al,-0x8(%rbp)
  write(fd, &c, 1);
 560:	48 8d 4d f8          	lea    -0x8(%rbp),%rcx
 564:	8b 45 fc             	mov    -0x4(%rbp),%eax
 567:	ba 01 00 00 00       	mov    $0x1,%edx
 56c:	48 89 ce             	mov    %rcx,%rsi
 56f:	89 c7                	mov    %eax,%edi
 571:	e8 32 ff ff ff       	call   4a8 <write>
}
 576:	90                   	nop
 577:	c9                   	leave
 578:	c3                   	ret

0000000000000579 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 579:	55                   	push   %rbp
 57a:	48 89 e5             	mov    %rsp,%rbp
 57d:	48 83 ec 30          	sub    $0x30,%rsp
 581:	89 7d dc             	mov    %edi,-0x24(%rbp)
 584:	89 75 d8             	mov    %esi,-0x28(%rbp)
 587:	89 55 d4             	mov    %edx,-0x2c(%rbp)
 58a:	89 4d d0             	mov    %ecx,-0x30(%rbp)
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 58d:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
  if(sgn && xx < 0){
 594:	83 7d d0 00          	cmpl   $0x0,-0x30(%rbp)
 598:	74 17                	je     5b1 <printint+0x38>
 59a:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
 59e:	79 11                	jns    5b1 <printint+0x38>
    neg = 1;
 5a0:	c7 45 f8 01 00 00 00 	movl   $0x1,-0x8(%rbp)
    x = -xx;
 5a7:	8b 45 d8             	mov    -0x28(%rbp),%eax
 5aa:	f7 d8                	neg    %eax
 5ac:	89 45 f4             	mov    %eax,-0xc(%rbp)
 5af:	eb 06                	jmp    5b7 <printint+0x3e>
  } else {
    x = xx;
 5b1:	8b 45 d8             	mov    -0x28(%rbp),%eax
 5b4:	89 45 f4             	mov    %eax,-0xc(%rbp)
  }

  i = 0;
 5b7:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  do{
    buf[i++] = digits[x % base];
 5be:	8b 4d d4             	mov    -0x2c(%rbp),%ecx
 5c1:	8b 45 f4             	mov    -0xc(%rbp),%eax
 5c4:	ba 00 00 00 00       	mov    $0x0,%edx
 5c9:	f7 f1                	div    %ecx
 5cb:	89 d1                	mov    %edx,%ecx
 5cd:	8b 45 fc             	mov    -0x4(%rbp),%eax
 5d0:	8d 50 01             	lea    0x1(%rax),%edx
 5d3:	89 55 fc             	mov    %edx,-0x4(%rbp)
 5d6:	89 ca                	mov    %ecx,%edx
 5d8:	0f b6 92 b0 11 00 00 	movzbl 0x11b0(%rdx),%edx
 5df:	48 98                	cltq
 5e1:	88 54 05 e0          	mov    %dl,-0x20(%rbp,%rax,1)
  }while((x /= base) != 0);
 5e5:	8b 75 d4             	mov    -0x2c(%rbp),%esi
 5e8:	8b 45 f4             	mov    -0xc(%rbp),%eax
 5eb:	ba 00 00 00 00       	mov    $0x0,%edx
 5f0:	f7 f6                	div    %esi
 5f2:	89 45 f4             	mov    %eax,-0xc(%rbp)
 5f5:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
 5f9:	75 c3                	jne    5be <printint+0x45>
  if(neg)
 5fb:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
 5ff:	74 2b                	je     62c <printint+0xb3>
    buf[i++] = '-';
 601:	8b 45 fc             	mov    -0x4(%rbp),%eax
 604:	8d 50 01             	lea    0x1(%rax),%edx
 607:	89 55 fc             	mov    %edx,-0x4(%rbp)
 60a:	48 98                	cltq
 60c:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%rbp,%rax,1)

  while(--i >= 0)
 611:	eb 19                	jmp    62c <printint+0xb3>
    putc(fd, buf[i]);
 613:	8b 45 fc             	mov    -0x4(%rbp),%eax
 616:	48 98                	cltq
 618:	0f b6 44 05 e0       	movzbl -0x20(%rbp,%rax,1),%eax
 61d:	0f be d0             	movsbl %al,%edx
 620:	8b 45 dc             	mov    -0x24(%rbp),%eax
 623:	89 d6                	mov    %edx,%esi
 625:	89 c7                	mov    %eax,%edi
 627:	e8 24 ff ff ff       	call   550 <putc>
  while(--i >= 0)
 62c:	83 6d fc 01          	subl   $0x1,-0x4(%rbp)
 630:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
 634:	79 dd                	jns    613 <printint+0x9a>
}
 636:	90                   	nop
 637:	90                   	nop
 638:	c9                   	leave
 639:	c3                   	ret

000000000000063a <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 63a:	55                   	push   %rbp
 63b:	48 89 e5             	mov    %rsp,%rbp
 63e:	48 81 ec f0 00 00 00 	sub    $0xf0,%rsp
 645:	89 bd 1c ff ff ff    	mov    %edi,-0xe4(%rbp)
 64b:	48 89 b5 10 ff ff ff 	mov    %rsi,-0xf0(%rbp)
 652:	48 89 95 60 ff ff ff 	mov    %rdx,-0xa0(%rbp)
 659:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
 660:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
 667:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
 66e:	84 c0                	test   %al,%al
 670:	74 20                	je     692 <printf+0x58>
 672:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
 676:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
 67a:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
 67e:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
 682:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
 686:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
 68a:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
 68e:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  va_list ap;
  char *s;
  int c, i, state;
  va_start(ap, fmt);
 692:	c7 85 20 ff ff ff 10 	movl   $0x10,-0xe0(%rbp)
 699:	00 00 00 
 69c:	c7 85 24 ff ff ff 30 	movl   $0x30,-0xdc(%rbp)
 6a3:	00 00 00 
 6a6:	48 8d 45 10          	lea    0x10(%rbp),%rax
 6aa:	48 89 85 28 ff ff ff 	mov    %rax,-0xd8(%rbp)
 6b1:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
 6b8:	48 89 85 30 ff ff ff 	mov    %rax,-0xd0(%rbp)

  state = 0;
 6bf:	c7 85 40 ff ff ff 00 	movl   $0x0,-0xc0(%rbp)
 6c6:	00 00 00 
  for(i = 0; fmt[i]; i++){
 6c9:	c7 85 44 ff ff ff 00 	movl   $0x0,-0xbc(%rbp)
 6d0:	00 00 00 
 6d3:	e9 a8 02 00 00       	jmp    980 <printf+0x346>
    c = fmt[i] & 0xff;
 6d8:	8b 85 44 ff ff ff    	mov    -0xbc(%rbp),%eax
 6de:	48 63 d0             	movslq %eax,%rdx
 6e1:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
 6e8:	48 01 d0             	add    %rdx,%rax
 6eb:	0f b6 00             	movzbl (%rax),%eax
 6ee:	0f be c0             	movsbl %al,%eax
 6f1:	25 ff 00 00 00       	and    $0xff,%eax
 6f6:	89 85 3c ff ff ff    	mov    %eax,-0xc4(%rbp)
    if(state == 0){
 6fc:	83 bd 40 ff ff ff 00 	cmpl   $0x0,-0xc0(%rbp)
 703:	75 35                	jne    73a <printf+0x100>
      if(c == '%'){
 705:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
 70c:	75 0f                	jne    71d <printf+0xe3>
        state = '%';
 70e:	c7 85 40 ff ff ff 25 	movl   $0x25,-0xc0(%rbp)
 715:	00 00 00 
 718:	e9 5c 02 00 00       	jmp    979 <printf+0x33f>
      } else {
        putc(fd, c);
 71d:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
 723:	0f be d0             	movsbl %al,%edx
 726:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 72c:	89 d6                	mov    %edx,%esi
 72e:	89 c7                	mov    %eax,%edi
 730:	e8 1b fe ff ff       	call   550 <putc>
 735:	e9 3f 02 00 00       	jmp    979 <printf+0x33f>
      }
    } else if(state == '%'){
 73a:	83 bd 40 ff ff ff 25 	cmpl   $0x25,-0xc0(%rbp)
 741:	0f 85 32 02 00 00    	jne    979 <printf+0x33f>
      if(c == 'd'){
 747:	83 bd 3c ff ff ff 64 	cmpl   $0x64,-0xc4(%rbp)
 74e:	75 5e                	jne    7ae <printf+0x174>
        printint(fd, va_arg(ap, int), 10, 1);
 750:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 756:	83 f8 2f             	cmp    $0x2f,%eax
 759:	77 23                	ja     77e <printf+0x144>
 75b:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 762:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 768:	89 d2                	mov    %edx,%edx
 76a:	48 01 d0             	add    %rdx,%rax
 76d:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 773:	83 c2 08             	add    $0x8,%edx
 776:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 77c:	eb 12                	jmp    790 <printf+0x156>
 77e:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 785:	48 8d 50 08          	lea    0x8(%rax),%rdx
 789:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 790:	8b 30                	mov    (%rax),%esi
 792:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 798:	b9 01 00 00 00       	mov    $0x1,%ecx
 79d:	ba 0a 00 00 00       	mov    $0xa,%edx
 7a2:	89 c7                	mov    %eax,%edi
 7a4:	e8 d0 fd ff ff       	call   579 <printint>
 7a9:	e9 c1 01 00 00       	jmp    96f <printf+0x335>
      } else if(c == 'x' || c == 'p'){
 7ae:	83 bd 3c ff ff ff 78 	cmpl   $0x78,-0xc4(%rbp)
 7b5:	74 09                	je     7c0 <printf+0x186>
 7b7:	83 bd 3c ff ff ff 70 	cmpl   $0x70,-0xc4(%rbp)
 7be:	75 5e                	jne    81e <printf+0x1e4>
        printint(fd, va_arg(ap, int), 16, 0);
 7c0:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 7c6:	83 f8 2f             	cmp    $0x2f,%eax
 7c9:	77 23                	ja     7ee <printf+0x1b4>
 7cb:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 7d2:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 7d8:	89 d2                	mov    %edx,%edx
 7da:	48 01 d0             	add    %rdx,%rax
 7dd:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 7e3:	83 c2 08             	add    $0x8,%edx
 7e6:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 7ec:	eb 12                	jmp    800 <printf+0x1c6>
 7ee:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 7f5:	48 8d 50 08          	lea    0x8(%rax),%rdx
 7f9:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 800:	8b 30                	mov    (%rax),%esi
 802:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 808:	b9 00 00 00 00       	mov    $0x0,%ecx
 80d:	ba 10 00 00 00       	mov    $0x10,%edx
 812:	89 c7                	mov    %eax,%edi
 814:	e8 60 fd ff ff       	call   579 <printint>
 819:	e9 51 01 00 00       	jmp    96f <printf+0x335>
      } else if(c == 's'){
 81e:	83 bd 3c ff ff ff 73 	cmpl   $0x73,-0xc4(%rbp)
 825:	0f 85 98 00 00 00    	jne    8c3 <printf+0x289>
        s = va_arg(ap, char*);
 82b:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 831:	83 f8 2f             	cmp    $0x2f,%eax
 834:	77 23                	ja     859 <printf+0x21f>
 836:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 83d:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 843:	89 d2                	mov    %edx,%edx
 845:	48 01 d0             	add    %rdx,%rax
 848:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 84e:	83 c2 08             	add    $0x8,%edx
 851:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 857:	eb 12                	jmp    86b <printf+0x231>
 859:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 860:	48 8d 50 08          	lea    0x8(%rax),%rdx
 864:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 86b:	48 8b 00             	mov    (%rax),%rax
 86e:	48 89 85 48 ff ff ff 	mov    %rax,-0xb8(%rbp)
        if(s == 0)
 875:	48 83 bd 48 ff ff ff 	cmpq   $0x0,-0xb8(%rbp)
 87c:	00 
 87d:	75 31                	jne    8b0 <printf+0x276>
          s = "(null)";
 87f:	48 c7 85 48 ff ff ff 	movq   $0xe64,-0xb8(%rbp)
 886:	64 0e 00 00 
        while(*s != 0){
 88a:	eb 24                	jmp    8b0 <printf+0x276>
          putc(fd, *s);
 88c:	48 8b 85 48 ff ff ff 	mov    -0xb8(%rbp),%rax
 893:	0f b6 00             	movzbl (%rax),%eax
 896:	0f be d0             	movsbl %al,%edx
 899:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 89f:	89 d6                	mov    %edx,%esi
 8a1:	89 c7                	mov    %eax,%edi
 8a3:	e8 a8 fc ff ff       	call   550 <putc>
          s++;
 8a8:	48 83 85 48 ff ff ff 	addq   $0x1,-0xb8(%rbp)
 8af:	01 
        while(*s != 0){
 8b0:	48 8b 85 48 ff ff ff 	mov    -0xb8(%rbp),%rax
 8b7:	0f b6 00             	movzbl (%rax),%eax
 8ba:	84 c0                	test   %al,%al
 8bc:	75 ce                	jne    88c <printf+0x252>
 8be:	e9 ac 00 00 00       	jmp    96f <printf+0x335>
        }
      } else if(c == 'c'){
 8c3:	83 bd 3c ff ff ff 63 	cmpl   $0x63,-0xc4(%rbp)
 8ca:	75 56                	jne    922 <printf+0x2e8>
        putc(fd, va_arg(ap, uint));
 8cc:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 8d2:	83 f8 2f             	cmp    $0x2f,%eax
 8d5:	77 23                	ja     8fa <printf+0x2c0>
 8d7:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 8de:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 8e4:	89 d2                	mov    %edx,%edx
 8e6:	48 01 d0             	add    %rdx,%rax
 8e9:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 8ef:	83 c2 08             	add    $0x8,%edx
 8f2:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 8f8:	eb 12                	jmp    90c <printf+0x2d2>
 8fa:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 901:	48 8d 50 08          	lea    0x8(%rax),%rdx
 905:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 90c:	8b 00                	mov    (%rax),%eax
 90e:	0f be d0             	movsbl %al,%edx
 911:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 917:	89 d6                	mov    %edx,%esi
 919:	89 c7                	mov    %eax,%edi
 91b:	e8 30 fc ff ff       	call   550 <putc>
 920:	eb 4d                	jmp    96f <printf+0x335>
      } else if(c == '%'){
 922:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
 929:	75 1a                	jne    945 <printf+0x30b>
        putc(fd, c);
 92b:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
 931:	0f be d0             	movsbl %al,%edx
 934:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 93a:	89 d6                	mov    %edx,%esi
 93c:	89 c7                	mov    %eax,%edi
 93e:	e8 0d fc ff ff       	call   550 <putc>
 943:	eb 2a                	jmp    96f <printf+0x335>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 945:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 94b:	be 25 00 00 00       	mov    $0x25,%esi
 950:	89 c7                	mov    %eax,%edi
 952:	e8 f9 fb ff ff       	call   550 <putc>
        putc(fd, c);
 957:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
 95d:	0f be d0             	movsbl %al,%edx
 960:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 966:	89 d6                	mov    %edx,%esi
 968:	89 c7                	mov    %eax,%edi
 96a:	e8 e1 fb ff ff       	call   550 <putc>
      }
      state = 0;
 96f:	c7 85 40 ff ff ff 00 	movl   $0x0,-0xc0(%rbp)
 976:	00 00 00 
  for(i = 0; fmt[i]; i++){
 979:	83 85 44 ff ff ff 01 	addl   $0x1,-0xbc(%rbp)
 980:	8b 85 44 ff ff ff    	mov    -0xbc(%rbp),%eax
 986:	48 63 d0             	movslq %eax,%rdx
 989:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
 990:	48 01 d0             	add    %rdx,%rax
 993:	0f b6 00             	movzbl (%rax),%eax
 996:	84 c0                	test   %al,%al
 998:	0f 85 3a fd ff ff    	jne    6d8 <printf+0x9e>
    }
  }
}
 99e:	90                   	nop
 99f:	90                   	nop
 9a0:	c9                   	leave
 9a1:	c3                   	ret

00000000000009a2 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 9a2:	55                   	push   %rbp
 9a3:	48 89 e5             	mov    %rsp,%rbp
 9a6:	48 83 ec 18          	sub    $0x18,%rsp
 9aa:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  Header *bp, *p;

  bp = (Header*)ap - 1;
 9ae:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 9b2:	48 83 e8 10          	sub    $0x10,%rax
 9b6:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 9ba:	48 8b 05 1f 08 00 00 	mov    0x81f(%rip),%rax        # 11e0 <freep>
 9c1:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 9c5:	eb 2f                	jmp    9f6 <free+0x54>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 9c7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 9cb:	48 8b 00             	mov    (%rax),%rax
 9ce:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 9d2:	72 17                	jb     9eb <free+0x49>
 9d4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 9d8:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 9dc:	72 2f                	jb     a0d <free+0x6b>
 9de:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 9e2:	48 8b 00             	mov    (%rax),%rax
 9e5:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
 9e9:	72 22                	jb     a0d <free+0x6b>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 9eb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 9ef:	48 8b 00             	mov    (%rax),%rax
 9f2:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 9f6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 9fa:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 9fe:	73 c7                	jae    9c7 <free+0x25>
 a00:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a04:	48 8b 00             	mov    (%rax),%rax
 a07:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
 a0b:	73 ba                	jae    9c7 <free+0x25>
      break;
  if(bp + bp->s.size == p->s.ptr){
 a0d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 a11:	8b 40 08             	mov    0x8(%rax),%eax
 a14:	89 c0                	mov    %eax,%eax
 a16:	48 c1 e0 04          	shl    $0x4,%rax
 a1a:	48 89 c2             	mov    %rax,%rdx
 a1d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 a21:	48 01 c2             	add    %rax,%rdx
 a24:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a28:	48 8b 00             	mov    (%rax),%rax
 a2b:	48 39 c2             	cmp    %rax,%rdx
 a2e:	75 2d                	jne    a5d <free+0xbb>
    bp->s.size += p->s.ptr->s.size;
 a30:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 a34:	8b 50 08             	mov    0x8(%rax),%edx
 a37:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a3b:	48 8b 00             	mov    (%rax),%rax
 a3e:	8b 40 08             	mov    0x8(%rax),%eax
 a41:	01 c2                	add    %eax,%edx
 a43:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 a47:	89 50 08             	mov    %edx,0x8(%rax)
    bp->s.ptr = p->s.ptr->s.ptr;
 a4a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a4e:	48 8b 00             	mov    (%rax),%rax
 a51:	48 8b 10             	mov    (%rax),%rdx
 a54:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 a58:	48 89 10             	mov    %rdx,(%rax)
 a5b:	eb 0e                	jmp    a6b <free+0xc9>
  } else
    bp->s.ptr = p->s.ptr;
 a5d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a61:	48 8b 10             	mov    (%rax),%rdx
 a64:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 a68:	48 89 10             	mov    %rdx,(%rax)
  if(p + p->s.size == bp){
 a6b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a6f:	8b 40 08             	mov    0x8(%rax),%eax
 a72:	89 c0                	mov    %eax,%eax
 a74:	48 c1 e0 04          	shl    $0x4,%rax
 a78:	48 89 c2             	mov    %rax,%rdx
 a7b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a7f:	48 01 d0             	add    %rdx,%rax
 a82:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
 a86:	75 27                	jne    aaf <free+0x10d>
    p->s.size += bp->s.size;
 a88:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a8c:	8b 50 08             	mov    0x8(%rax),%edx
 a8f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 a93:	8b 40 08             	mov    0x8(%rax),%eax
 a96:	01 c2                	add    %eax,%edx
 a98:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 a9c:	89 50 08             	mov    %edx,0x8(%rax)
    p->s.ptr = bp->s.ptr;
 a9f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 aa3:	48 8b 10             	mov    (%rax),%rdx
 aa6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 aaa:	48 89 10             	mov    %rdx,(%rax)
 aad:	eb 0b                	jmp    aba <free+0x118>
  } else
    p->s.ptr = bp;
 aaf:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 ab3:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
 ab7:	48 89 10             	mov    %rdx,(%rax)
  freep = p;
 aba:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 abe:	48 89 05 1b 07 00 00 	mov    %rax,0x71b(%rip)        # 11e0 <freep>
}
 ac5:	90                   	nop
 ac6:	c9                   	leave
 ac7:	c3                   	ret

0000000000000ac8 <morecore>:

static Header*
morecore(uint nu)
{
 ac8:	55                   	push   %rbp
 ac9:	48 89 e5             	mov    %rsp,%rbp
 acc:	48 83 ec 20          	sub    $0x20,%rsp
 ad0:	89 7d ec             	mov    %edi,-0x14(%rbp)
  char *p;
  Header *hp;

  if(nu < 4096)
 ad3:	81 7d ec ff 0f 00 00 	cmpl   $0xfff,-0x14(%rbp)
 ada:	77 07                	ja     ae3 <morecore+0x1b>
    nu = 4096;
 adc:	c7 45 ec 00 10 00 00 	movl   $0x1000,-0x14(%rbp)
  p = sbrk(nu * sizeof(Header));
 ae3:	8b 45 ec             	mov    -0x14(%rbp),%eax
 ae6:	c1 e0 04             	shl    $0x4,%eax
 ae9:	89 c7                	mov    %eax,%edi
 aeb:	e8 20 fa ff ff       	call   510 <sbrk>
 af0:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  if(p == (char*)-1)
 af4:	48 83 7d f8 ff       	cmpq   $0xffffffffffffffff,-0x8(%rbp)
 af9:	75 07                	jne    b02 <morecore+0x3a>
    return 0;
 afb:	b8 00 00 00 00       	mov    $0x0,%eax
 b00:	eb 29                	jmp    b2b <morecore+0x63>
  hp = (Header*)p;
 b02:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b06:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  hp->s.size = nu;
 b0a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 b0e:	8b 55 ec             	mov    -0x14(%rbp),%edx
 b11:	89 50 08             	mov    %edx,0x8(%rax)
  free((void*)(hp + 1));
 b14:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 b18:	48 83 c0 10          	add    $0x10,%rax
 b1c:	48 89 c7             	mov    %rax,%rdi
 b1f:	e8 7e fe ff ff       	call   9a2 <free>
  return freep;
 b24:	48 8b 05 b5 06 00 00 	mov    0x6b5(%rip),%rax        # 11e0 <freep>
}
 b2b:	c9                   	leave
 b2c:	c3                   	ret

0000000000000b2d <malloc>:

void*
malloc(uint nbytes)
{
 b2d:	55                   	push   %rbp
 b2e:	48 89 e5             	mov    %rsp,%rbp
 b31:	48 83 ec 30          	sub    $0x30,%rsp
 b35:	89 7d dc             	mov    %edi,-0x24(%rbp)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 b38:	8b 45 dc             	mov    -0x24(%rbp),%eax
 b3b:	48 83 c0 0f          	add    $0xf,%rax
 b3f:	48 c1 e8 04          	shr    $0x4,%rax
 b43:	83 c0 01             	add    $0x1,%eax
 b46:	89 45 ec             	mov    %eax,-0x14(%rbp)
  if((prevp = freep) == 0){
 b49:	48 8b 05 90 06 00 00 	mov    0x690(%rip),%rax        # 11e0 <freep>
 b50:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
 b54:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
 b59:	75 2b                	jne    b86 <malloc+0x59>
    base.s.ptr = freep = prevp = &base;
 b5b:	48 c7 45 f0 d0 11 00 	movq   $0x11d0,-0x10(%rbp)
 b62:	00 
 b63:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 b67:	48 89 05 72 06 00 00 	mov    %rax,0x672(%rip)        # 11e0 <freep>
 b6e:	48 8b 05 6b 06 00 00 	mov    0x66b(%rip),%rax        # 11e0 <freep>
 b75:	48 89 05 54 06 00 00 	mov    %rax,0x654(%rip)        # 11d0 <base>
    base.s.size = 0;
 b7c:	c7 05 52 06 00 00 00 	movl   $0x0,0x652(%rip)        # 11d8 <base+0x8>
 b83:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 b86:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 b8a:	48 8b 00             	mov    (%rax),%rax
 b8d:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
 b91:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 b95:	8b 40 08             	mov    0x8(%rax),%eax
 b98:	3b 45 ec             	cmp    -0x14(%rbp),%eax
 b9b:	72 5f                	jb     bfc <malloc+0xcf>
      if(p->s.size == nunits)
 b9d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 ba1:	8b 40 08             	mov    0x8(%rax),%eax
 ba4:	39 45 ec             	cmp    %eax,-0x14(%rbp)
 ba7:	75 10                	jne    bb9 <malloc+0x8c>
        prevp->s.ptr = p->s.ptr;
 ba9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 bad:	48 8b 10             	mov    (%rax),%rdx
 bb0:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 bb4:	48 89 10             	mov    %rdx,(%rax)
 bb7:	eb 2e                	jmp    be7 <malloc+0xba>
      else {
        p->s.size -= nunits;
 bb9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 bbd:	8b 40 08             	mov    0x8(%rax),%eax
 bc0:	2b 45 ec             	sub    -0x14(%rbp),%eax
 bc3:	89 c2                	mov    %eax,%edx
 bc5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 bc9:	89 50 08             	mov    %edx,0x8(%rax)
        p += p->s.size;
 bcc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 bd0:	8b 40 08             	mov    0x8(%rax),%eax
 bd3:	89 c0                	mov    %eax,%eax
 bd5:	48 c1 e0 04          	shl    $0x4,%rax
 bd9:	48 01 45 f8          	add    %rax,-0x8(%rbp)
        p->s.size = nunits;
 bdd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 be1:	8b 55 ec             	mov    -0x14(%rbp),%edx
 be4:	89 50 08             	mov    %edx,0x8(%rax)
      }
      freep = prevp;
 be7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 beb:	48 89 05 ee 05 00 00 	mov    %rax,0x5ee(%rip)        # 11e0 <freep>
      return (void*)(p + 1);
 bf2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 bf6:	48 83 c0 10          	add    $0x10,%rax
 bfa:	eb 41                	jmp    c3d <malloc+0x110>
    }
    if(p == freep)
 bfc:	48 8b 05 dd 05 00 00 	mov    0x5dd(%rip),%rax        # 11e0 <freep>
 c03:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 c07:	75 1c                	jne    c25 <malloc+0xf8>
      if((p = morecore(nunits)) == 0)
 c09:	8b 45 ec             	mov    -0x14(%rbp),%eax
 c0c:	89 c7                	mov    %eax,%edi
 c0e:	e8 b5 fe ff ff       	call   ac8 <morecore>
 c13:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 c17:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
 c1c:	75 07                	jne    c25 <malloc+0xf8>
        return 0;
 c1e:	b8 00 00 00 00       	mov    $0x0,%eax
 c23:	eb 18                	jmp    c3d <malloc+0x110>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 c25:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 c29:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
 c2d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 c31:	48 8b 00             	mov    (%rax),%rax
 c34:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
 c38:	e9 54 ff ff ff       	jmp    b91 <malloc+0x64>
  }
}
 c3d:	c9                   	leave
 c3e:	c3                   	ret

0000000000000c3f <createRoot>:
#include "set.h"
#include "user.h"

//TODO: Να μην είναι περιορισμένο σε int

Set* createRoot(){
 c3f:	55                   	push   %rbp
 c40:	48 89 e5             	mov    %rsp,%rbp
 c43:	48 83 ec 10          	sub    $0x10,%rsp
    //Αρχικοποίηση του Set
    Set *set = malloc(sizeof(Set));
 c47:	bf 10 00 00 00       	mov    $0x10,%edi
 c4c:	e8 dc fe ff ff       	call   b2d <malloc>
 c51:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    set->size = 0;
 c55:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 c59:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%rax)
    set->root = NULL;
 c60:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 c64:	48 c7 00 00 00 00 00 	movq   $0x0,(%rax)
    return set;
 c6b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
 c6f:	c9                   	leave
 c70:	c3                   	ret

0000000000000c71 <createNode>:

void createNode(int i, Set *set){
 c71:	55                   	push   %rbp
 c72:	48 89 e5             	mov    %rsp,%rbp
 c75:	48 83 ec 20          	sub    $0x20,%rsp
 c79:	89 7d ec             	mov    %edi,-0x14(%rbp)
 c7c:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    Η συνάρτηση αυτή δημιουργεί ένα νέο SetNode με την τιμή i και εφόσον δεν υπάρχει στο Set το προσθέτει στο τέλος του συνόλου.
    Σημείωση: Ίσως υπάρχει καλύτερος τρόπος για την υλοποίηση.
    */

    //Αρχικοποίηση του SetNode
    SetNode *temp = malloc(sizeof(SetNode));
 c80:	bf 10 00 00 00       	mov    $0x10,%edi
 c85:	e8 a3 fe ff ff       	call   b2d <malloc>
 c8a:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    temp->i = i;
 c8e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 c92:	8b 55 ec             	mov    -0x14(%rbp),%edx
 c95:	89 10                	mov    %edx,(%rax)
    temp->next = NULL;
 c97:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 c9b:	48 c7 40 08 00 00 00 	movq   $0x0,0x8(%rax)
 ca2:	00 

    //Έλεγχος ύπαρξης του i
    SetNode *curr = set->root;//Ξεκινάει από την root
 ca3:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
 ca7:	48 8b 00             	mov    (%rax),%rax
 caa:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(curr != NULL) { //Εφόσον το Set δεν είναι άδειο
 cae:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
 cb3:	74 34                	je     ce9 <createNode+0x78>
        while (curr->next != NULL){ //Εφόσον υπάρχει επόμενο node
 cb5:	eb 25                	jmp    cdc <createNode+0x6b>
            if (curr->i == i){ //Αν το i υπάρχει στο σύνολο
 cb7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 cbb:	8b 00                	mov    (%rax),%eax
 cbd:	39 45 ec             	cmp    %eax,-0x14(%rbp)
 cc0:	75 0e                	jne    cd0 <createNode+0x5f>
                free(temp); 
 cc2:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 cc6:	48 89 c7             	mov    %rax,%rdi
 cc9:	e8 d4 fc ff ff       	call   9a2 <free>
                return; //Δεν εκτελούμε την υπόλοιπη συνάρτηση
 cce:	eb 4e                	jmp    d1e <createNode+0xad>
            }
            curr = curr->next; //Επόμενο SetNode
 cd0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 cd4:	48 8b 40 08          	mov    0x8(%rax),%rax
 cd8:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
        while (curr->next != NULL){ //Εφόσον υπάρχει επόμενο node
 cdc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 ce0:	48 8b 40 08          	mov    0x8(%rax),%rax
 ce4:	48 85 c0             	test   %rax,%rax
 ce7:	75 ce                	jne    cb7 <createNode+0x46>
        }
    }
    /*
    Ο έλεγχος στην if είναι απαραίτητος για να ελεγχθεί το τελευταίο SetNode.
    */
    if (curr->i != i) attachNode(set, curr, temp); 
 ce9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 ced:	8b 00                	mov    (%rax),%eax
 cef:	39 45 ec             	cmp    %eax,-0x14(%rbp)
 cf2:	74 1e                	je     d12 <createNode+0xa1>
 cf4:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
 cf8:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
 cfc:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
 d00:	48 89 ce             	mov    %rcx,%rsi
 d03:	48 89 c7             	mov    %rax,%rdi
 d06:	b8 00 00 00 00       	mov    $0x0,%eax
 d0b:	e8 10 00 00 00       	call   d20 <attachNode>
 d10:	eb 0c                	jmp    d1e <createNode+0xad>
    else free(temp);
 d12:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 d16:	48 89 c7             	mov    %rax,%rdi
 d19:	e8 84 fc ff ff       	call   9a2 <free>
}
 d1e:	c9                   	leave
 d1f:	c3                   	ret

0000000000000d20 <attachNode>:

void attachNode(Set *set, SetNode *curr, SetNode *temp){
 d20:	55                   	push   %rbp
 d21:	48 89 e5             	mov    %rsp,%rbp
 d24:	48 83 ec 18          	sub    $0x18,%rsp
 d28:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
 d2c:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
 d30:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
    //Βάζουμε το temp στο τέλος του Set
    if(set->size == 0) set->root = temp;
 d34:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 d38:	8b 40 08             	mov    0x8(%rax),%eax
 d3b:	85 c0                	test   %eax,%eax
 d3d:	75 0d                	jne    d4c <attachNode+0x2c>
 d3f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 d43:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
 d47:	48 89 10             	mov    %rdx,(%rax)
 d4a:	eb 0c                	jmp    d58 <attachNode+0x38>
    else curr->next = temp;
 d4c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 d50:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
 d54:	48 89 50 08          	mov    %rdx,0x8(%rax)
    set->size += 1;
 d58:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 d5c:	8b 40 08             	mov    0x8(%rax),%eax
 d5f:	8d 50 01             	lea    0x1(%rax),%edx
 d62:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 d66:	89 50 08             	mov    %edx,0x8(%rax)
}
 d69:	90                   	nop
 d6a:	c9                   	leave
 d6b:	c3                   	ret

0000000000000d6c <deleteSet>:

void deleteSet(Set *set){
 d6c:	55                   	push   %rbp
 d6d:	48 89 e5             	mov    %rsp,%rbp
 d70:	48 83 ec 20          	sub    $0x20,%rsp
 d74:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    if (set == NULL) return; //Αν ο χρήστης είναι ΜΛΚ!
 d78:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
 d7d:	74 42                	je     dc1 <deleteSet+0x55>
    SetNode *temp;
    SetNode *curr = set->root; //Ξεκινάμε από το root
 d7f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 d83:	48 8b 00             	mov    (%rax),%rax
 d86:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    while (curr != NULL){ 
 d8a:	eb 20                	jmp    dac <deleteSet+0x40>
        temp = curr->next; //Αναφορά στο επόμενο SetNode
 d8c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 d90:	48 8b 40 08          	mov    0x8(%rax),%rax
 d94:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
        free(curr); //Απελευθέρωση της curr
 d98:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 d9c:	48 89 c7             	mov    %rax,%rdi
 d9f:	e8 fe fb ff ff       	call   9a2 <free>
        curr = temp;
 da4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 da8:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    while (curr != NULL){ 
 dac:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
 db1:	75 d9                	jne    d8c <deleteSet+0x20>
    }
    free(set); //Διαγραφή του Set
 db3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 db7:	48 89 c7             	mov    %rax,%rdi
 dba:	e8 e3 fb ff ff       	call   9a2 <free>
 dbf:	eb 01                	jmp    dc2 <deleteSet+0x56>
    if (set == NULL) return; //Αν ο χρήστης είναι ΜΛΚ!
 dc1:	90                   	nop
}
 dc2:	c9                   	leave
 dc3:	c3                   	ret

0000000000000dc4 <getNodeAtPosition>:

SetNode* getNodeAtPosition(Set *set, int i){
 dc4:	55                   	push   %rbp
 dc5:	48 89 e5             	mov    %rsp,%rbp
 dc8:	48 83 ec 20          	sub    $0x20,%rsp
 dcc:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
 dd0:	89 75 e4             	mov    %esi,-0x1c(%rbp)
    if (set == NULL || set->root == NULL) return NULL; //Αν ο χρήστης είναι ΜΛΚ!
 dd3:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
 dd8:	74 0c                	je     de6 <getNodeAtPosition+0x22>
 dda:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 dde:	48 8b 00             	mov    (%rax),%rax
 de1:	48 85 c0             	test   %rax,%rax
 de4:	75 07                	jne    ded <getNodeAtPosition+0x29>
 de6:	b8 00 00 00 00       	mov    $0x0,%eax
 deb:	eb 3d                	jmp    e2a <getNodeAtPosition+0x66>

    SetNode *curr = set->root;
 ded:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 df1:	48 8b 00             	mov    (%rax),%rax
 df4:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    int n;

    for(n = 0; n<i && curr->next != NULL; n++) curr = curr->next; //Ο έλεγχος εδω είναι: n<i && curr->next != NULL
 df8:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
 dff:	eb 10                	jmp    e11 <getNodeAtPosition+0x4d>
 e01:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 e05:	48 8b 40 08          	mov    0x8(%rax),%rax
 e09:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 e0d:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
 e11:	8b 45 f4             	mov    -0xc(%rbp),%eax
 e14:	3b 45 e4             	cmp    -0x1c(%rbp),%eax
 e17:	7d 0d                	jge    e26 <getNodeAtPosition+0x62>
 e19:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 e1d:	48 8b 40 08          	mov    0x8(%rax),%rax
 e21:	48 85 c0             	test   %rax,%rax
 e24:	75 db                	jne    e01 <getNodeAtPosition+0x3d>
    return curr;
 e26:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 e2a:	c9                   	leave
 e2b:	c3                   	ret
