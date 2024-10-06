
fs/usertests:     file format elf64-x86-64


Disassembly of section .text:

0000000000000000 <opentest>:

// simple file system tests

void
opentest(void)
{
       0:	55                   	push   %rbp
       1:	48 89 e5             	mov    %rsp,%rbp
       4:	48 83 ec 10          	sub    $0x10,%rsp
  int fd;

  printf(stdout, "open test\n");
       8:	8b 05 1a 63 00 00    	mov    0x631a(%rip),%eax        # 6328 <stdout>
       e:	48 c7 c6 b6 45 00 00 	mov    $0x45b6,%rsi
      15:	89 c7                	mov    %eax,%edi
      17:	b8 00 00 00 00       	mov    $0x0,%eax
      1c:	e8 75 3f 00 00       	call   3f96 <printf>
  fd = open("echo", 0);
      21:	be 00 00 00 00       	mov    $0x0,%esi
      26:	48 c7 c7 a0 45 00 00 	mov    $0x45a0,%rdi
      2d:	e8 12 3e 00 00       	call   3e44 <open>
      32:	89 45 fc             	mov    %eax,-0x4(%rbp)
  if(fd < 0){
      35:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
      39:	79 1e                	jns    59 <opentest+0x59>
    printf(stdout, "open echo failed!\n");
      3b:	8b 05 e7 62 00 00    	mov    0x62e7(%rip),%eax        # 6328 <stdout>
      41:	48 c7 c6 c1 45 00 00 	mov    $0x45c1,%rsi
      48:	89 c7                	mov    %eax,%edi
      4a:	b8 00 00 00 00       	mov    $0x0,%eax
      4f:	e8 42 3f 00 00       	call   3f96 <printf>
    exit();
      54:	e8 ab 3d 00 00       	call   3e04 <exit>
  }
  close(fd);
      59:	8b 45 fc             	mov    -0x4(%rbp),%eax
      5c:	89 c7                	mov    %eax,%edi
      5e:	e8 c9 3d 00 00       	call   3e2c <close>
  fd = open("doesnotexist", 0);
      63:	be 00 00 00 00       	mov    $0x0,%esi
      68:	48 c7 c7 d4 45 00 00 	mov    $0x45d4,%rdi
      6f:	e8 d0 3d 00 00       	call   3e44 <open>
      74:	89 45 fc             	mov    %eax,-0x4(%rbp)
  if(fd >= 0){
      77:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
      7b:	78 1e                	js     9b <opentest+0x9b>
    printf(stdout, "open doesnotexist succeeded!\n");
      7d:	8b 05 a5 62 00 00    	mov    0x62a5(%rip),%eax        # 6328 <stdout>
      83:	48 c7 c6 e1 45 00 00 	mov    $0x45e1,%rsi
      8a:	89 c7                	mov    %eax,%edi
      8c:	b8 00 00 00 00       	mov    $0x0,%eax
      91:	e8 00 3f 00 00       	call   3f96 <printf>
    exit();
      96:	e8 69 3d 00 00       	call   3e04 <exit>
  }
  printf(stdout, "open test ok\n");
      9b:	8b 05 87 62 00 00    	mov    0x6287(%rip),%eax        # 6328 <stdout>
      a1:	48 c7 c6 ff 45 00 00 	mov    $0x45ff,%rsi
      a8:	89 c7                	mov    %eax,%edi
      aa:	b8 00 00 00 00       	mov    $0x0,%eax
      af:	e8 e2 3e 00 00       	call   3f96 <printf>
}
      b4:	90                   	nop
      b5:	c9                   	leave
      b6:	c3                   	ret

00000000000000b7 <writetest>:

void
writetest(void)
{
      b7:	55                   	push   %rbp
      b8:	48 89 e5             	mov    %rsp,%rbp
      bb:	48 83 ec 10          	sub    $0x10,%rsp
  int fd;
  int i;

  printf(stdout, "small file test\n");
      bf:	8b 05 63 62 00 00    	mov    0x6263(%rip),%eax        # 6328 <stdout>
      c5:	48 c7 c6 0d 46 00 00 	mov    $0x460d,%rsi
      cc:	89 c7                	mov    %eax,%edi
      ce:	b8 00 00 00 00       	mov    $0x0,%eax
      d3:	e8 be 3e 00 00       	call   3f96 <printf>
  fd = open("small", O_CREATE|O_RDWR);
      d8:	be 02 02 00 00       	mov    $0x202,%esi
      dd:	48 c7 c7 1e 46 00 00 	mov    $0x461e,%rdi
      e4:	e8 5b 3d 00 00       	call   3e44 <open>
      e9:	89 45 f8             	mov    %eax,-0x8(%rbp)
  if(fd >= 0){
      ec:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
      f0:	78 25                	js     117 <writetest+0x60>
    printf(stdout, "creat small succeeded; ok\n");
      f2:	8b 05 30 62 00 00    	mov    0x6230(%rip),%eax        # 6328 <stdout>
      f8:	48 c7 c6 24 46 00 00 	mov    $0x4624,%rsi
      ff:	89 c7                	mov    %eax,%edi
     101:	b8 00 00 00 00       	mov    $0x0,%eax
     106:	e8 8b 3e 00 00       	call   3f96 <printf>
  } else {
    printf(stdout, "error: creat small failed!\n");
    exit();
  }
  for(i = 0; i < 100; i++){
     10b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
     112:	e9 9a 00 00 00       	jmp    1b1 <writetest+0xfa>
    printf(stdout, "error: creat small failed!\n");
     117:	8b 05 0b 62 00 00    	mov    0x620b(%rip),%eax        # 6328 <stdout>
     11d:	48 c7 c6 3f 46 00 00 	mov    $0x463f,%rsi
     124:	89 c7                	mov    %eax,%edi
     126:	b8 00 00 00 00       	mov    $0x0,%eax
     12b:	e8 66 3e 00 00       	call   3f96 <printf>
    exit();
     130:	e8 cf 3c 00 00       	call   3e04 <exit>
    if(write(fd, "aaaaaaaaaa", 10) != 10){
     135:	8b 45 f8             	mov    -0x8(%rbp),%eax
     138:	ba 0a 00 00 00       	mov    $0xa,%edx
     13d:	48 c7 c6 5b 46 00 00 	mov    $0x465b,%rsi
     144:	89 c7                	mov    %eax,%edi
     146:	e8 d9 3c 00 00       	call   3e24 <write>
     14b:	83 f8 0a             	cmp    $0xa,%eax
     14e:	74 21                	je     171 <writetest+0xba>
      printf(stdout, "error: write aa %d new file failed\n", i);
     150:	8b 05 d2 61 00 00    	mov    0x61d2(%rip),%eax        # 6328 <stdout>
     156:	8b 55 fc             	mov    -0x4(%rbp),%edx
     159:	48 c7 c6 68 46 00 00 	mov    $0x4668,%rsi
     160:	89 c7                	mov    %eax,%edi
     162:	b8 00 00 00 00       	mov    $0x0,%eax
     167:	e8 2a 3e 00 00       	call   3f96 <printf>
      exit();
     16c:	e8 93 3c 00 00       	call   3e04 <exit>
    }
    if(write(fd, "bbbbbbbbbb", 10) != 10){
     171:	8b 45 f8             	mov    -0x8(%rbp),%eax
     174:	ba 0a 00 00 00       	mov    $0xa,%edx
     179:	48 c7 c6 8c 46 00 00 	mov    $0x468c,%rsi
     180:	89 c7                	mov    %eax,%edi
     182:	e8 9d 3c 00 00       	call   3e24 <write>
     187:	83 f8 0a             	cmp    $0xa,%eax
     18a:	74 21                	je     1ad <writetest+0xf6>
      printf(stdout, "error: write bb %d new file failed\n", i);
     18c:	8b 05 96 61 00 00    	mov    0x6196(%rip),%eax        # 6328 <stdout>
     192:	8b 55 fc             	mov    -0x4(%rbp),%edx
     195:	48 c7 c6 98 46 00 00 	mov    $0x4698,%rsi
     19c:	89 c7                	mov    %eax,%edi
     19e:	b8 00 00 00 00       	mov    $0x0,%eax
     1a3:	e8 ee 3d 00 00       	call   3f96 <printf>
      exit();
     1a8:	e8 57 3c 00 00       	call   3e04 <exit>
  for(i = 0; i < 100; i++){
     1ad:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
     1b1:	83 7d fc 63          	cmpl   $0x63,-0x4(%rbp)
     1b5:	0f 8e 7a ff ff ff    	jle    135 <writetest+0x7e>
    }
  }
  printf(stdout, "writes ok\n");
     1bb:	8b 05 67 61 00 00    	mov    0x6167(%rip),%eax        # 6328 <stdout>
     1c1:	48 c7 c6 bc 46 00 00 	mov    $0x46bc,%rsi
     1c8:	89 c7                	mov    %eax,%edi
     1ca:	b8 00 00 00 00       	mov    $0x0,%eax
     1cf:	e8 c2 3d 00 00       	call   3f96 <printf>
  close(fd);
     1d4:	8b 45 f8             	mov    -0x8(%rbp),%eax
     1d7:	89 c7                	mov    %eax,%edi
     1d9:	e8 4e 3c 00 00       	call   3e2c <close>
  fd = open("small", O_RDONLY);
     1de:	be 00 00 00 00       	mov    $0x0,%esi
     1e3:	48 c7 c7 1e 46 00 00 	mov    $0x461e,%rdi
     1ea:	e8 55 3c 00 00       	call   3e44 <open>
     1ef:	89 45 f8             	mov    %eax,-0x8(%rbp)
  if(fd >= 0){
     1f2:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
     1f6:	78 3d                	js     235 <writetest+0x17e>
    printf(stdout, "open small succeeded ok\n");
     1f8:	8b 05 2a 61 00 00    	mov    0x612a(%rip),%eax        # 6328 <stdout>
     1fe:	48 c7 c6 c7 46 00 00 	mov    $0x46c7,%rsi
     205:	89 c7                	mov    %eax,%edi
     207:	b8 00 00 00 00       	mov    $0x0,%eax
     20c:	e8 85 3d 00 00       	call   3f96 <printf>
  } else {
    printf(stdout, "error: open small failed!\n");
    exit();
  }
  i = read(fd, buf, 2000);
     211:	8b 45 f8             	mov    -0x8(%rbp),%eax
     214:	ba d0 07 00 00       	mov    $0x7d0,%edx
     219:	48 c7 c6 60 63 00 00 	mov    $0x6360,%rsi
     220:	89 c7                	mov    %eax,%edi
     222:	e8 f5 3b 00 00       	call   3e1c <read>
     227:	89 45 fc             	mov    %eax,-0x4(%rbp)
  if(i == 2000){
     22a:	81 7d fc d0 07 00 00 	cmpl   $0x7d0,-0x4(%rbp)
     231:	75 55                	jne    288 <writetest+0x1d1>
     233:	eb 1e                	jmp    253 <writetest+0x19c>
    printf(stdout, "error: open small failed!\n");
     235:	8b 05 ed 60 00 00    	mov    0x60ed(%rip),%eax        # 6328 <stdout>
     23b:	48 c7 c6 e0 46 00 00 	mov    $0x46e0,%rsi
     242:	89 c7                	mov    %eax,%edi
     244:	b8 00 00 00 00       	mov    $0x0,%eax
     249:	e8 48 3d 00 00       	call   3f96 <printf>
    exit();
     24e:	e8 b1 3b 00 00       	call   3e04 <exit>
    printf(stdout, "read succeeded ok\n");
     253:	8b 05 cf 60 00 00    	mov    0x60cf(%rip),%eax        # 6328 <stdout>
     259:	48 c7 c6 fb 46 00 00 	mov    $0x46fb,%rsi
     260:	89 c7                	mov    %eax,%edi
     262:	b8 00 00 00 00       	mov    $0x0,%eax
     267:	e8 2a 3d 00 00       	call   3f96 <printf>
  } else {
    printf(stdout, "read failed\n");
    exit();
  }
  close(fd);
     26c:	8b 45 f8             	mov    -0x8(%rbp),%eax
     26f:	89 c7                	mov    %eax,%edi
     271:	e8 b6 3b 00 00       	call   3e2c <close>

  if(unlink("small") < 0){
     276:	48 c7 c7 1e 46 00 00 	mov    $0x461e,%rdi
     27d:	e8 d2 3b 00 00       	call   3e54 <unlink>
     282:	85 c0                	test   %eax,%eax
     284:	79 3e                	jns    2c4 <writetest+0x20d>
     286:	eb 1e                	jmp    2a6 <writetest+0x1ef>
    printf(stdout, "read failed\n");
     288:	8b 05 9a 60 00 00    	mov    0x609a(%rip),%eax        # 6328 <stdout>
     28e:	48 c7 c6 0e 47 00 00 	mov    $0x470e,%rsi
     295:	89 c7                	mov    %eax,%edi
     297:	b8 00 00 00 00       	mov    $0x0,%eax
     29c:	e8 f5 3c 00 00       	call   3f96 <printf>
    exit();
     2a1:	e8 5e 3b 00 00       	call   3e04 <exit>
    printf(stdout, "unlink small failed\n");
     2a6:	8b 05 7c 60 00 00    	mov    0x607c(%rip),%eax        # 6328 <stdout>
     2ac:	48 c7 c6 1b 47 00 00 	mov    $0x471b,%rsi
     2b3:	89 c7                	mov    %eax,%edi
     2b5:	b8 00 00 00 00       	mov    $0x0,%eax
     2ba:	e8 d7 3c 00 00       	call   3f96 <printf>
    exit();
     2bf:	e8 40 3b 00 00       	call   3e04 <exit>
  }
  printf(stdout, "small file test ok\n");
     2c4:	8b 05 5e 60 00 00    	mov    0x605e(%rip),%eax        # 6328 <stdout>
     2ca:	48 c7 c6 30 47 00 00 	mov    $0x4730,%rsi
     2d1:	89 c7                	mov    %eax,%edi
     2d3:	b8 00 00 00 00       	mov    $0x0,%eax
     2d8:	e8 b9 3c 00 00       	call   3f96 <printf>
}
     2dd:	90                   	nop
     2de:	c9                   	leave
     2df:	c3                   	ret

00000000000002e0 <writetest1>:

void
writetest1(void)
{
     2e0:	55                   	push   %rbp
     2e1:	48 89 e5             	mov    %rsp,%rbp
     2e4:	48 83 ec 10          	sub    $0x10,%rsp
  int i, fd, n;

  printf(stdout, "big files test\n");
     2e8:	8b 05 3a 60 00 00    	mov    0x603a(%rip),%eax        # 6328 <stdout>
     2ee:	48 c7 c6 44 47 00 00 	mov    $0x4744,%rsi
     2f5:	89 c7                	mov    %eax,%edi
     2f7:	b8 00 00 00 00       	mov    $0x0,%eax
     2fc:	e8 95 3c 00 00       	call   3f96 <printf>

  fd = open("big", O_CREATE|O_RDWR);
     301:	be 02 02 00 00       	mov    $0x202,%esi
     306:	48 c7 c7 54 47 00 00 	mov    $0x4754,%rdi
     30d:	e8 32 3b 00 00       	call   3e44 <open>
     312:	89 45 f4             	mov    %eax,-0xc(%rbp)
  if(fd < 0){
     315:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
     319:	79 1e                	jns    339 <writetest1+0x59>
    printf(stdout, "error: creat big failed!\n");
     31b:	8b 05 07 60 00 00    	mov    0x6007(%rip),%eax        # 6328 <stdout>
     321:	48 c7 c6 58 47 00 00 	mov    $0x4758,%rsi
     328:	89 c7                	mov    %eax,%edi
     32a:	b8 00 00 00 00       	mov    $0x0,%eax
     32f:	e8 62 3c 00 00       	call   3f96 <printf>
    exit();
     334:	e8 cb 3a 00 00       	call   3e04 <exit>
  }

  for(i = 0; i < MAXFILE; i++){
     339:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
     340:	eb 4e                	jmp    390 <writetest1+0xb0>
    ((int*)buf)[0] = i;
     342:	48 c7 c2 60 63 00 00 	mov    $0x6360,%rdx
     349:	8b 45 fc             	mov    -0x4(%rbp),%eax
     34c:	89 02                	mov    %eax,(%rdx)
    if(write(fd, buf, 512) != 512){
     34e:	8b 45 f4             	mov    -0xc(%rbp),%eax
     351:	ba 00 02 00 00       	mov    $0x200,%edx
     356:	48 c7 c6 60 63 00 00 	mov    $0x6360,%rsi
     35d:	89 c7                	mov    %eax,%edi
     35f:	e8 c0 3a 00 00       	call   3e24 <write>
     364:	3d 00 02 00 00       	cmp    $0x200,%eax
     369:	74 21                	je     38c <writetest1+0xac>
      printf(stdout, "error: write big file failed\n", i);
     36b:	8b 05 b7 5f 00 00    	mov    0x5fb7(%rip),%eax        # 6328 <stdout>
     371:	8b 55 fc             	mov    -0x4(%rbp),%edx
     374:	48 c7 c6 72 47 00 00 	mov    $0x4772,%rsi
     37b:	89 c7                	mov    %eax,%edi
     37d:	b8 00 00 00 00       	mov    $0x0,%eax
     382:	e8 0f 3c 00 00       	call   3f96 <printf>
      exit();
     387:	e8 78 3a 00 00       	call   3e04 <exit>
  for(i = 0; i < MAXFILE; i++){
     38c:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
     390:	8b 45 fc             	mov    -0x4(%rbp),%eax
     393:	3d 8b 00 00 00       	cmp    $0x8b,%eax
     398:	76 a8                	jbe    342 <writetest1+0x62>
    }
  }

  close(fd);
     39a:	8b 45 f4             	mov    -0xc(%rbp),%eax
     39d:	89 c7                	mov    %eax,%edi
     39f:	e8 88 3a 00 00       	call   3e2c <close>

  fd = open("big", O_RDONLY);
     3a4:	be 00 00 00 00       	mov    $0x0,%esi
     3a9:	48 c7 c7 54 47 00 00 	mov    $0x4754,%rdi
     3b0:	e8 8f 3a 00 00       	call   3e44 <open>
     3b5:	89 45 f4             	mov    %eax,-0xc(%rbp)
  if(fd < 0){
     3b8:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
     3bc:	79 1e                	jns    3dc <writetest1+0xfc>
    printf(stdout, "error: open big failed!\n");
     3be:	8b 05 64 5f 00 00    	mov    0x5f64(%rip),%eax        # 6328 <stdout>
     3c4:	48 c7 c6 90 47 00 00 	mov    $0x4790,%rsi
     3cb:	89 c7                	mov    %eax,%edi
     3cd:	b8 00 00 00 00       	mov    $0x0,%eax
     3d2:	e8 bf 3b 00 00       	call   3f96 <printf>
    exit();
     3d7:	e8 28 3a 00 00       	call   3e04 <exit>
  }

  n = 0;
     3dc:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
  for(;;){
    i = read(fd, buf, 512);
     3e3:	8b 45 f4             	mov    -0xc(%rbp),%eax
     3e6:	ba 00 02 00 00       	mov    $0x200,%edx
     3eb:	48 c7 c6 60 63 00 00 	mov    $0x6360,%rsi
     3f2:	89 c7                	mov    %eax,%edi
     3f4:	e8 23 3a 00 00       	call   3e1c <read>
     3f9:	89 45 fc             	mov    %eax,-0x4(%rbp)
    if(i == 0){
     3fc:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
     400:	75 2e                	jne    430 <writetest1+0x150>
      if(n == MAXFILE - 1){
     402:	81 7d f8 8b 00 00 00 	cmpl   $0x8b,-0x8(%rbp)
     409:	0f 85 8c 00 00 00    	jne    49b <writetest1+0x1bb>
        printf(stdout, "read only %d blocks from big", n);
     40f:	8b 05 13 5f 00 00    	mov    0x5f13(%rip),%eax        # 6328 <stdout>
     415:	8b 55 f8             	mov    -0x8(%rbp),%edx
     418:	48 c7 c6 a9 47 00 00 	mov    $0x47a9,%rsi
     41f:	89 c7                	mov    %eax,%edi
     421:	b8 00 00 00 00       	mov    $0x0,%eax
     426:	e8 6b 3b 00 00       	call   3f96 <printf>
        exit();
     42b:	e8 d4 39 00 00       	call   3e04 <exit>
      }
      break;
    } else if(i != 512){
     430:	81 7d fc 00 02 00 00 	cmpl   $0x200,-0x4(%rbp)
     437:	74 21                	je     45a <writetest1+0x17a>
      printf(stdout, "read failed %d\n", i);
     439:	8b 05 e9 5e 00 00    	mov    0x5ee9(%rip),%eax        # 6328 <stdout>
     43f:	8b 55 fc             	mov    -0x4(%rbp),%edx
     442:	48 c7 c6 c6 47 00 00 	mov    $0x47c6,%rsi
     449:	89 c7                	mov    %eax,%edi
     44b:	b8 00 00 00 00       	mov    $0x0,%eax
     450:	e8 41 3b 00 00       	call   3f96 <printf>
      exit();
     455:	e8 aa 39 00 00       	call   3e04 <exit>
    }
    if(((int*)buf)[0] != n){
     45a:	48 c7 c0 60 63 00 00 	mov    $0x6360,%rax
     461:	8b 00                	mov    (%rax),%eax
     463:	39 45 f8             	cmp    %eax,-0x8(%rbp)
     466:	74 2a                	je     492 <writetest1+0x1b2>
      printf(stdout, "read content of block %d is %d\n",
             n, ((int*)buf)[0]);
     468:	48 c7 c0 60 63 00 00 	mov    $0x6360,%rax
      printf(stdout, "read content of block %d is %d\n",
     46f:	8b 08                	mov    (%rax),%ecx
     471:	8b 05 b1 5e 00 00    	mov    0x5eb1(%rip),%eax        # 6328 <stdout>
     477:	8b 55 f8             	mov    -0x8(%rbp),%edx
     47a:	48 c7 c6 d8 47 00 00 	mov    $0x47d8,%rsi
     481:	89 c7                	mov    %eax,%edi
     483:	b8 00 00 00 00       	mov    $0x0,%eax
     488:	e8 09 3b 00 00       	call   3f96 <printf>
      exit();
     48d:	e8 72 39 00 00       	call   3e04 <exit>
    }
    n++;
     492:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
    i = read(fd, buf, 512);
     496:	e9 48 ff ff ff       	jmp    3e3 <writetest1+0x103>
      break;
     49b:	90                   	nop
  }
  close(fd);
     49c:	8b 45 f4             	mov    -0xc(%rbp),%eax
     49f:	89 c7                	mov    %eax,%edi
     4a1:	e8 86 39 00 00       	call   3e2c <close>
  if(unlink("big") < 0){
     4a6:	48 c7 c7 54 47 00 00 	mov    $0x4754,%rdi
     4ad:	e8 a2 39 00 00       	call   3e54 <unlink>
     4b2:	85 c0                	test   %eax,%eax
     4b4:	79 1e                	jns    4d4 <writetest1+0x1f4>
    printf(stdout, "unlink big failed\n");
     4b6:	8b 05 6c 5e 00 00    	mov    0x5e6c(%rip),%eax        # 6328 <stdout>
     4bc:	48 c7 c6 f8 47 00 00 	mov    $0x47f8,%rsi
     4c3:	89 c7                	mov    %eax,%edi
     4c5:	b8 00 00 00 00       	mov    $0x0,%eax
     4ca:	e8 c7 3a 00 00       	call   3f96 <printf>
    exit();
     4cf:	e8 30 39 00 00       	call   3e04 <exit>
  }
  printf(stdout, "big files ok\n");
     4d4:	8b 05 4e 5e 00 00    	mov    0x5e4e(%rip),%eax        # 6328 <stdout>
     4da:	48 c7 c6 0b 48 00 00 	mov    $0x480b,%rsi
     4e1:	89 c7                	mov    %eax,%edi
     4e3:	b8 00 00 00 00       	mov    $0x0,%eax
     4e8:	e8 a9 3a 00 00       	call   3f96 <printf>
}
     4ed:	90                   	nop
     4ee:	c9                   	leave
     4ef:	c3                   	ret

00000000000004f0 <createtest>:

void
createtest(void)
{
     4f0:	55                   	push   %rbp
     4f1:	48 89 e5             	mov    %rsp,%rbp
     4f4:	48 83 ec 10          	sub    $0x10,%rsp
  int i, fd;

  printf(stdout, "many creates, followed by unlink test\n");
     4f8:	8b 05 2a 5e 00 00    	mov    0x5e2a(%rip),%eax        # 6328 <stdout>
     4fe:	48 c7 c6 20 48 00 00 	mov    $0x4820,%rsi
     505:	89 c7                	mov    %eax,%edi
     507:	b8 00 00 00 00       	mov    $0x0,%eax
     50c:	e8 85 3a 00 00       	call   3f96 <printf>

  name[0] = 'a';
     511:	c6 05 48 7e 00 00 61 	movb   $0x61,0x7e48(%rip)        # 8360 <name>
  name[2] = '\0';
     518:	c6 05 43 7e 00 00 00 	movb   $0x0,0x7e43(%rip)        # 8362 <name+0x2>
  for(i = 0; i < 52; i++){
     51f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
     526:	eb 2e                	jmp    556 <createtest+0x66>
    name[1] = '0' + i;
     528:	8b 45 fc             	mov    -0x4(%rbp),%eax
     52b:	83 c0 30             	add    $0x30,%eax
     52e:	88 05 2d 7e 00 00    	mov    %al,0x7e2d(%rip)        # 8361 <name+0x1>
    fd = open(name, O_CREATE|O_RDWR);
     534:	be 02 02 00 00       	mov    $0x202,%esi
     539:	48 c7 c7 60 83 00 00 	mov    $0x8360,%rdi
     540:	e8 ff 38 00 00       	call   3e44 <open>
     545:	89 45 f8             	mov    %eax,-0x8(%rbp)
    close(fd);
     548:	8b 45 f8             	mov    -0x8(%rbp),%eax
     54b:	89 c7                	mov    %eax,%edi
     54d:	e8 da 38 00 00       	call   3e2c <close>
  for(i = 0; i < 52; i++){
     552:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
     556:	83 7d fc 33          	cmpl   $0x33,-0x4(%rbp)
     55a:	7e cc                	jle    528 <createtest+0x38>
  }
  name[0] = 'a';
     55c:	c6 05 fd 7d 00 00 61 	movb   $0x61,0x7dfd(%rip)        # 8360 <name>
  name[2] = '\0';
     563:	c6 05 f8 7d 00 00 00 	movb   $0x0,0x7df8(%rip)        # 8362 <name+0x2>
  for(i = 0; i < 52; i++){
     56a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
     571:	eb 1c                	jmp    58f <createtest+0x9f>
    name[1] = '0' + i;
     573:	8b 45 fc             	mov    -0x4(%rbp),%eax
     576:	83 c0 30             	add    $0x30,%eax
     579:	88 05 e2 7d 00 00    	mov    %al,0x7de2(%rip)        # 8361 <name+0x1>
    unlink(name);
     57f:	48 c7 c7 60 83 00 00 	mov    $0x8360,%rdi
     586:	e8 c9 38 00 00       	call   3e54 <unlink>
  for(i = 0; i < 52; i++){
     58b:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
     58f:	83 7d fc 33          	cmpl   $0x33,-0x4(%rbp)
     593:	7e de                	jle    573 <createtest+0x83>
  }
  printf(stdout, "many creates, followed by unlink; ok\n");
     595:	8b 05 8d 5d 00 00    	mov    0x5d8d(%rip),%eax        # 6328 <stdout>
     59b:	48 c7 c6 48 48 00 00 	mov    $0x4848,%rsi
     5a2:	89 c7                	mov    %eax,%edi
     5a4:	b8 00 00 00 00       	mov    $0x0,%eax
     5a9:	e8 e8 39 00 00       	call   3f96 <printf>
}
     5ae:	90                   	nop
     5af:	c9                   	leave
     5b0:	c3                   	ret

00000000000005b1 <dirtest>:

void dirtest(void)
{
     5b1:	55                   	push   %rbp
     5b2:	48 89 e5             	mov    %rsp,%rbp
  printf(stdout, "mkdir test\n");
     5b5:	8b 05 6d 5d 00 00    	mov    0x5d6d(%rip),%eax        # 6328 <stdout>
     5bb:	48 c7 c6 6e 48 00 00 	mov    $0x486e,%rsi
     5c2:	89 c7                	mov    %eax,%edi
     5c4:	b8 00 00 00 00       	mov    $0x0,%eax
     5c9:	e8 c8 39 00 00       	call   3f96 <printf>

  if(mkdir("dir0") < 0){
     5ce:	48 c7 c7 7a 48 00 00 	mov    $0x487a,%rdi
     5d5:	e8 92 38 00 00       	call   3e6c <mkdir>
     5da:	85 c0                	test   %eax,%eax
     5dc:	79 1e                	jns    5fc <dirtest+0x4b>
    printf(stdout, "mkdir failed\n");
     5de:	8b 05 44 5d 00 00    	mov    0x5d44(%rip),%eax        # 6328 <stdout>
     5e4:	48 c7 c6 7f 48 00 00 	mov    $0x487f,%rsi
     5eb:	89 c7                	mov    %eax,%edi
     5ed:	b8 00 00 00 00       	mov    $0x0,%eax
     5f2:	e8 9f 39 00 00       	call   3f96 <printf>
    exit();
     5f7:	e8 08 38 00 00       	call   3e04 <exit>
  }

  if(chdir("dir0") < 0){
     5fc:	48 c7 c7 7a 48 00 00 	mov    $0x487a,%rdi
     603:	e8 6c 38 00 00       	call   3e74 <chdir>
     608:	85 c0                	test   %eax,%eax
     60a:	79 1e                	jns    62a <dirtest+0x79>
    printf(stdout, "chdir dir0 failed\n");
     60c:	8b 05 16 5d 00 00    	mov    0x5d16(%rip),%eax        # 6328 <stdout>
     612:	48 c7 c6 8d 48 00 00 	mov    $0x488d,%rsi
     619:	89 c7                	mov    %eax,%edi
     61b:	b8 00 00 00 00       	mov    $0x0,%eax
     620:	e8 71 39 00 00       	call   3f96 <printf>
    exit();
     625:	e8 da 37 00 00       	call   3e04 <exit>
  }

  if(chdir("..") < 0){
     62a:	48 c7 c7 a0 48 00 00 	mov    $0x48a0,%rdi
     631:	e8 3e 38 00 00       	call   3e74 <chdir>
     636:	85 c0                	test   %eax,%eax
     638:	79 1e                	jns    658 <dirtest+0xa7>
    printf(stdout, "chdir .. failed\n");
     63a:	8b 05 e8 5c 00 00    	mov    0x5ce8(%rip),%eax        # 6328 <stdout>
     640:	48 c7 c6 a3 48 00 00 	mov    $0x48a3,%rsi
     647:	89 c7                	mov    %eax,%edi
     649:	b8 00 00 00 00       	mov    $0x0,%eax
     64e:	e8 43 39 00 00       	call   3f96 <printf>
    exit();
     653:	e8 ac 37 00 00       	call   3e04 <exit>
  }

  if(unlink("dir0") < 0){
     658:	48 c7 c7 7a 48 00 00 	mov    $0x487a,%rdi
     65f:	e8 f0 37 00 00       	call   3e54 <unlink>
     664:	85 c0                	test   %eax,%eax
     666:	79 1e                	jns    686 <dirtest+0xd5>
    printf(stdout, "unlink dir0 failed\n");
     668:	8b 05 ba 5c 00 00    	mov    0x5cba(%rip),%eax        # 6328 <stdout>
     66e:	48 c7 c6 b4 48 00 00 	mov    $0x48b4,%rsi
     675:	89 c7                	mov    %eax,%edi
     677:	b8 00 00 00 00       	mov    $0x0,%eax
     67c:	e8 15 39 00 00       	call   3f96 <printf>
    exit();
     681:	e8 7e 37 00 00       	call   3e04 <exit>
  }
  printf(stdout, "mkdir test\n");
     686:	8b 05 9c 5c 00 00    	mov    0x5c9c(%rip),%eax        # 6328 <stdout>
     68c:	48 c7 c6 6e 48 00 00 	mov    $0x486e,%rsi
     693:	89 c7                	mov    %eax,%edi
     695:	b8 00 00 00 00       	mov    $0x0,%eax
     69a:	e8 f7 38 00 00       	call   3f96 <printf>
}
     69f:	90                   	nop
     6a0:	5d                   	pop    %rbp
     6a1:	c3                   	ret

00000000000006a2 <exectest>:

void
exectest(void)
{
     6a2:	55                   	push   %rbp
     6a3:	48 89 e5             	mov    %rsp,%rbp
  printf(stdout, "exec test\n");
     6a6:	8b 05 7c 5c 00 00    	mov    0x5c7c(%rip),%eax        # 6328 <stdout>
     6ac:	48 c7 c6 c8 48 00 00 	mov    $0x48c8,%rsi
     6b3:	89 c7                	mov    %eax,%edi
     6b5:	b8 00 00 00 00       	mov    $0x0,%eax
     6ba:	e8 d7 38 00 00       	call   3f96 <printf>
  if(exec("echo", echoargv) < 0){
     6bf:	48 c7 c6 00 63 00 00 	mov    $0x6300,%rsi
     6c6:	48 c7 c7 a0 45 00 00 	mov    $0x45a0,%rdi
     6cd:	e8 6a 37 00 00       	call   3e3c <exec>
     6d2:	85 c0                	test   %eax,%eax
     6d4:	79 1e                	jns    6f4 <exectest+0x52>
    printf(stdout, "exec echo failed\n");
     6d6:	8b 05 4c 5c 00 00    	mov    0x5c4c(%rip),%eax        # 6328 <stdout>
     6dc:	48 c7 c6 d3 48 00 00 	mov    $0x48d3,%rsi
     6e3:	89 c7                	mov    %eax,%edi
     6e5:	b8 00 00 00 00       	mov    $0x0,%eax
     6ea:	e8 a7 38 00 00       	call   3f96 <printf>
    exit();
     6ef:	e8 10 37 00 00       	call   3e04 <exit>
  }
}
     6f4:	90                   	nop
     6f5:	5d                   	pop    %rbp
     6f6:	c3                   	ret

00000000000006f7 <pipe1>:

// simple fork and pipe read/write

void
pipe1(void)
{
     6f7:	55                   	push   %rbp
     6f8:	48 89 e5             	mov    %rsp,%rbp
     6fb:	48 83 ec 20          	sub    $0x20,%rsp
  int fds[2], pid;
  int seq, i, n, cc, total;

  if(pipe(fds) != 0){
     6ff:	48 8d 45 e0          	lea    -0x20(%rbp),%rax
     703:	48 89 c7             	mov    %rax,%rdi
     706:	e8 09 37 00 00       	call   3e14 <pipe>
     70b:	85 c0                	test   %eax,%eax
     70d:	74 1b                	je     72a <pipe1+0x33>
    printf(1, "pipe() failed\n");
     70f:	48 c7 c6 e5 48 00 00 	mov    $0x48e5,%rsi
     716:	bf 01 00 00 00       	mov    $0x1,%edi
     71b:	b8 00 00 00 00       	mov    $0x0,%eax
     720:	e8 71 38 00 00       	call   3f96 <printf>
    exit();
     725:	e8 da 36 00 00       	call   3e04 <exit>
  }
  pid = fork();
     72a:	e8 cd 36 00 00       	call   3dfc <fork>
     72f:	89 45 e8             	mov    %eax,-0x18(%rbp)
  seq = 0;
     732:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  if(pid == 0){
     739:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
     73d:	0f 85 86 00 00 00    	jne    7c9 <pipe1+0xd2>
    close(fds[0]);
     743:	8b 45 e0             	mov    -0x20(%rbp),%eax
     746:	89 c7                	mov    %eax,%edi
     748:	e8 df 36 00 00       	call   3e2c <close>
    for(n = 0; n < 5; n++){
     74d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
     754:	eb 68                	jmp    7be <pipe1+0xc7>
      for(i = 0; i < 1033; i++)
     756:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
     75d:	eb 1a                	jmp    779 <pipe1+0x82>
        buf[i] = seq++;
     75f:	8b 45 fc             	mov    -0x4(%rbp),%eax
     762:	8d 50 01             	lea    0x1(%rax),%edx
     765:	89 55 fc             	mov    %edx,-0x4(%rbp)
     768:	89 c2                	mov    %eax,%edx
     76a:	8b 45 f8             	mov    -0x8(%rbp),%eax
     76d:	48 98                	cltq
     76f:	88 90 60 63 00 00    	mov    %dl,0x6360(%rax)
      for(i = 0; i < 1033; i++)
     775:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
     779:	81 7d f8 08 04 00 00 	cmpl   $0x408,-0x8(%rbp)
     780:	7e dd                	jle    75f <pipe1+0x68>
      if(write(fds[1], buf, 1033) != 1033){
     782:	8b 45 e4             	mov    -0x1c(%rbp),%eax
     785:	ba 09 04 00 00       	mov    $0x409,%edx
     78a:	48 c7 c6 60 63 00 00 	mov    $0x6360,%rsi
     791:	89 c7                	mov    %eax,%edi
     793:	e8 8c 36 00 00       	call   3e24 <write>
     798:	3d 09 04 00 00       	cmp    $0x409,%eax
     79d:	74 1b                	je     7ba <pipe1+0xc3>
        printf(1, "pipe1 oops 1\n");
     79f:	48 c7 c6 f4 48 00 00 	mov    $0x48f4,%rsi
     7a6:	bf 01 00 00 00       	mov    $0x1,%edi
     7ab:	b8 00 00 00 00       	mov    $0x0,%eax
     7b0:	e8 e1 37 00 00       	call   3f96 <printf>
        exit();
     7b5:	e8 4a 36 00 00       	call   3e04 <exit>
    for(n = 0; n < 5; n++){
     7ba:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
     7be:	83 7d f4 04          	cmpl   $0x4,-0xc(%rbp)
     7c2:	7e 92                	jle    756 <pipe1+0x5f>
      }
    }
    exit();
     7c4:	e8 3b 36 00 00       	call   3e04 <exit>
  } else if(pid > 0){
     7c9:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
     7cd:	0f 8e f6 00 00 00    	jle    8c9 <pipe1+0x1d2>
    close(fds[1]);
     7d3:	8b 45 e4             	mov    -0x1c(%rbp),%eax
     7d6:	89 c7                	mov    %eax,%edi
     7d8:	e8 4f 36 00 00       	call   3e2c <close>
    total = 0;
     7dd:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
    cc = 1;
     7e4:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%rbp)
    while((n = read(fds[0], buf, cc)) > 0){
     7eb:	eb 6b                	jmp    858 <pipe1+0x161>
      for(i = 0; i < n; i++){
     7ed:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
     7f4:	eb 40                	jmp    836 <pipe1+0x13f>
        if((buf[i] & 0xff) != (seq++ & 0xff)){
     7f6:	8b 45 f8             	mov    -0x8(%rbp),%eax
     7f9:	48 98                	cltq
     7fb:	0f b6 80 60 63 00 00 	movzbl 0x6360(%rax),%eax
     802:	0f be c8             	movsbl %al,%ecx
     805:	8b 45 fc             	mov    -0x4(%rbp),%eax
     808:	8d 50 01             	lea    0x1(%rax),%edx
     80b:	89 55 fc             	mov    %edx,-0x4(%rbp)
     80e:	31 c8                	xor    %ecx,%eax
     810:	0f b6 c0             	movzbl %al,%eax
     813:	85 c0                	test   %eax,%eax
     815:	74 1b                	je     832 <pipe1+0x13b>
          printf(1, "pipe1 oops 2\n");
     817:	48 c7 c6 02 49 00 00 	mov    $0x4902,%rsi
     81e:	bf 01 00 00 00       	mov    $0x1,%edi
     823:	b8 00 00 00 00       	mov    $0x0,%eax
     828:	e8 69 37 00 00       	call   3f96 <printf>
     82d:	e9 b2 00 00 00       	jmp    8e4 <pipe1+0x1ed>
      for(i = 0; i < n; i++){
     832:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
     836:	8b 45 f8             	mov    -0x8(%rbp),%eax
     839:	3b 45 f4             	cmp    -0xc(%rbp),%eax
     83c:	7c b8                	jl     7f6 <pipe1+0xff>
          return;
        }
      }
      total += n;
     83e:	8b 45 f4             	mov    -0xc(%rbp),%eax
     841:	01 45 ec             	add    %eax,-0x14(%rbp)
      cc = cc * 2;
     844:	d1 65 f0             	shll   -0x10(%rbp)
      if(cc > sizeof(buf))
     847:	8b 45 f0             	mov    -0x10(%rbp),%eax
     84a:	3d 00 20 00 00       	cmp    $0x2000,%eax
     84f:	76 07                	jbe    858 <pipe1+0x161>
        cc = sizeof(buf);
     851:	c7 45 f0 00 20 00 00 	movl   $0x2000,-0x10(%rbp)
    while((n = read(fds[0], buf, cc)) > 0){
     858:	8b 45 e0             	mov    -0x20(%rbp),%eax
     85b:	8b 55 f0             	mov    -0x10(%rbp),%edx
     85e:	48 c7 c6 60 63 00 00 	mov    $0x6360,%rsi
     865:	89 c7                	mov    %eax,%edi
     867:	e8 b0 35 00 00       	call   3e1c <read>
     86c:	89 45 f4             	mov    %eax,-0xc(%rbp)
     86f:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
     873:	0f 8f 74 ff ff ff    	jg     7ed <pipe1+0xf6>
    }
    if(total != 5 * 1033){
     879:	81 7d ec 2d 14 00 00 	cmpl   $0x142d,-0x14(%rbp)
     880:	74 20                	je     8a2 <pipe1+0x1ab>
      printf(1, "pipe1 oops 3 total %d\n", total);
     882:	8b 45 ec             	mov    -0x14(%rbp),%eax
     885:	89 c2                	mov    %eax,%edx
     887:	48 c7 c6 10 49 00 00 	mov    $0x4910,%rsi
     88e:	bf 01 00 00 00       	mov    $0x1,%edi
     893:	b8 00 00 00 00       	mov    $0x0,%eax
     898:	e8 f9 36 00 00       	call   3f96 <printf>
      exit();
     89d:	e8 62 35 00 00       	call   3e04 <exit>
    }
    close(fds[0]);
     8a2:	8b 45 e0             	mov    -0x20(%rbp),%eax
     8a5:	89 c7                	mov    %eax,%edi
     8a7:	e8 80 35 00 00       	call   3e2c <close>
    wait();
     8ac:	e8 5b 35 00 00       	call   3e0c <wait>
  } else {
    printf(1, "fork() failed\n");
    exit();
  }
  printf(1, "pipe1 ok\n");
     8b1:	48 c7 c6 36 49 00 00 	mov    $0x4936,%rsi
     8b8:	bf 01 00 00 00       	mov    $0x1,%edi
     8bd:	b8 00 00 00 00       	mov    $0x0,%eax
     8c2:	e8 cf 36 00 00       	call   3f96 <printf>
     8c7:	eb 1b                	jmp    8e4 <pipe1+0x1ed>
    printf(1, "fork() failed\n");
     8c9:	48 c7 c6 27 49 00 00 	mov    $0x4927,%rsi
     8d0:	bf 01 00 00 00       	mov    $0x1,%edi
     8d5:	b8 00 00 00 00       	mov    $0x0,%eax
     8da:	e8 b7 36 00 00       	call   3f96 <printf>
    exit();
     8df:	e8 20 35 00 00       	call   3e04 <exit>
}
     8e4:	c9                   	leave
     8e5:	c3                   	ret

00000000000008e6 <preempt>:

// meant to be run w/ at most two CPUs
void
preempt(void)
{
     8e6:	55                   	push   %rbp
     8e7:	48 89 e5             	mov    %rsp,%rbp
     8ea:	48 83 ec 20          	sub    $0x20,%rsp
  int pid1, pid2, pid3;
  int pfds[2];

  printf(1, "preempt: ");
     8ee:	48 c7 c6 40 49 00 00 	mov    $0x4940,%rsi
     8f5:	bf 01 00 00 00       	mov    $0x1,%edi
     8fa:	b8 00 00 00 00       	mov    $0x0,%eax
     8ff:	e8 92 36 00 00       	call   3f96 <printf>
  pid1 = fork();
     904:	e8 f3 34 00 00       	call   3dfc <fork>
     909:	89 45 fc             	mov    %eax,-0x4(%rbp)
  if(pid1 == 0)
     90c:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
     910:	75 03                	jne    915 <preempt+0x2f>
    for(;;)
     912:	90                   	nop
     913:	eb fd                	jmp    912 <preempt+0x2c>
      ;

  pid2 = fork();
     915:	e8 e2 34 00 00       	call   3dfc <fork>
     91a:	89 45 f8             	mov    %eax,-0x8(%rbp)
  if(pid2 == 0)
     91d:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
     921:	75 03                	jne    926 <preempt+0x40>
    for(;;)
     923:	90                   	nop
     924:	eb fd                	jmp    923 <preempt+0x3d>
      ;

  pipe(pfds);
     926:	48 8d 45 ec          	lea    -0x14(%rbp),%rax
     92a:	48 89 c7             	mov    %rax,%rdi
     92d:	e8 e2 34 00 00       	call   3e14 <pipe>
  pid3 = fork();
     932:	e8 c5 34 00 00       	call   3dfc <fork>
     937:	89 45 f4             	mov    %eax,-0xc(%rbp)
  if(pid3 == 0){
     93a:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
     93e:	75 48                	jne    988 <preempt+0xa2>
    close(pfds[0]);
     940:	8b 45 ec             	mov    -0x14(%rbp),%eax
     943:	89 c7                	mov    %eax,%edi
     945:	e8 e2 34 00 00       	call   3e2c <close>
    if(write(pfds[1], "x", 1) != 1)
     94a:	8b 45 f0             	mov    -0x10(%rbp),%eax
     94d:	ba 01 00 00 00       	mov    $0x1,%edx
     952:	48 c7 c6 4a 49 00 00 	mov    $0x494a,%rsi
     959:	89 c7                	mov    %eax,%edi
     95b:	e8 c4 34 00 00       	call   3e24 <write>
     960:	83 f8 01             	cmp    $0x1,%eax
     963:	74 16                	je     97b <preempt+0x95>
      printf(1, "preempt write error");
     965:	48 c7 c6 4c 49 00 00 	mov    $0x494c,%rsi
     96c:	bf 01 00 00 00       	mov    $0x1,%edi
     971:	b8 00 00 00 00       	mov    $0x0,%eax
     976:	e8 1b 36 00 00       	call   3f96 <printf>
    close(pfds[1]);
     97b:	8b 45 f0             	mov    -0x10(%rbp),%eax
     97e:	89 c7                	mov    %eax,%edi
     980:	e8 a7 34 00 00       	call   3e2c <close>
    for(;;)
     985:	90                   	nop
     986:	eb fd                	jmp    985 <preempt+0x9f>
      ;
  }

  close(pfds[1]);
     988:	8b 45 f0             	mov    -0x10(%rbp),%eax
     98b:	89 c7                	mov    %eax,%edi
     98d:	e8 9a 34 00 00       	call   3e2c <close>
  if(read(pfds[0], buf, sizeof(buf)) != 1){
     992:	8b 45 ec             	mov    -0x14(%rbp),%eax
     995:	ba 00 20 00 00       	mov    $0x2000,%edx
     99a:	48 c7 c6 60 63 00 00 	mov    $0x6360,%rsi
     9a1:	89 c7                	mov    %eax,%edi
     9a3:	e8 74 34 00 00       	call   3e1c <read>
     9a8:	83 f8 01             	cmp    $0x1,%eax
     9ab:	74 18                	je     9c5 <preempt+0xdf>
    printf(1, "preempt read error");
     9ad:	48 c7 c6 60 49 00 00 	mov    $0x4960,%rsi
     9b4:	bf 01 00 00 00       	mov    $0x1,%edi
     9b9:	b8 00 00 00 00       	mov    $0x0,%eax
     9be:	e8 d3 35 00 00       	call   3f96 <printf>
     9c3:	eb 79                	jmp    a3e <preempt+0x158>
    return;
  }
  close(pfds[0]);
     9c5:	8b 45 ec             	mov    -0x14(%rbp),%eax
     9c8:	89 c7                	mov    %eax,%edi
     9ca:	e8 5d 34 00 00       	call   3e2c <close>
  printf(1, "kill... ");
     9cf:	48 c7 c6 73 49 00 00 	mov    $0x4973,%rsi
     9d6:	bf 01 00 00 00       	mov    $0x1,%edi
     9db:	b8 00 00 00 00       	mov    $0x0,%eax
     9e0:	e8 b1 35 00 00       	call   3f96 <printf>
  kill(pid1);
     9e5:	8b 45 fc             	mov    -0x4(%rbp),%eax
     9e8:	89 c7                	mov    %eax,%edi
     9ea:	e8 45 34 00 00       	call   3e34 <kill>
  kill(pid2);
     9ef:	8b 45 f8             	mov    -0x8(%rbp),%eax
     9f2:	89 c7                	mov    %eax,%edi
     9f4:	e8 3b 34 00 00       	call   3e34 <kill>
  kill(pid3);
     9f9:	8b 45 f4             	mov    -0xc(%rbp),%eax
     9fc:	89 c7                	mov    %eax,%edi
     9fe:	e8 31 34 00 00       	call   3e34 <kill>
  printf(1, "wait... ");
     a03:	48 c7 c6 7c 49 00 00 	mov    $0x497c,%rsi
     a0a:	bf 01 00 00 00       	mov    $0x1,%edi
     a0f:	b8 00 00 00 00       	mov    $0x0,%eax
     a14:	e8 7d 35 00 00       	call   3f96 <printf>
  wait();
     a19:	e8 ee 33 00 00       	call   3e0c <wait>
  wait();
     a1e:	e8 e9 33 00 00       	call   3e0c <wait>
  wait();
     a23:	e8 e4 33 00 00       	call   3e0c <wait>
  printf(1, "preempt ok\n");
     a28:	48 c7 c6 85 49 00 00 	mov    $0x4985,%rsi
     a2f:	bf 01 00 00 00       	mov    $0x1,%edi
     a34:	b8 00 00 00 00       	mov    $0x0,%eax
     a39:	e8 58 35 00 00       	call   3f96 <printf>
}
     a3e:	c9                   	leave
     a3f:	c3                   	ret

0000000000000a40 <exitwait>:

// try to find any races between exit and wait
void
exitwait(void)
{
     a40:	55                   	push   %rbp
     a41:	48 89 e5             	mov    %rsp,%rbp
     a44:	48 83 ec 10          	sub    $0x10,%rsp
  int i, pid;

  for(i = 0; i < 100; i++){
     a48:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
     a4f:	eb 57                	jmp    aa8 <exitwait+0x68>
    pid = fork();
     a51:	e8 a6 33 00 00       	call   3dfc <fork>
     a56:	89 45 f8             	mov    %eax,-0x8(%rbp)
    if(pid < 0){
     a59:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
     a5d:	79 18                	jns    a77 <exitwait+0x37>
      printf(1, "fork failed\n");
     a5f:	48 c7 c6 91 49 00 00 	mov    $0x4991,%rsi
     a66:	bf 01 00 00 00       	mov    $0x1,%edi
     a6b:	b8 00 00 00 00       	mov    $0x0,%eax
     a70:	e8 21 35 00 00       	call   3f96 <printf>
      return;
     a75:	eb 4d                	jmp    ac4 <exitwait+0x84>
    }
    if(pid){
     a77:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
     a7b:	74 22                	je     a9f <exitwait+0x5f>
      if(wait() != pid){
     a7d:	e8 8a 33 00 00       	call   3e0c <wait>
     a82:	39 45 f8             	cmp    %eax,-0x8(%rbp)
     a85:	74 1d                	je     aa4 <exitwait+0x64>
        printf(1, "wait wrong pid\n");
     a87:	48 c7 c6 9e 49 00 00 	mov    $0x499e,%rsi
     a8e:	bf 01 00 00 00       	mov    $0x1,%edi
     a93:	b8 00 00 00 00       	mov    $0x0,%eax
     a98:	e8 f9 34 00 00       	call   3f96 <printf>
        return;
     a9d:	eb 25                	jmp    ac4 <exitwait+0x84>
      }
    } else {
      exit();
     a9f:	e8 60 33 00 00       	call   3e04 <exit>
  for(i = 0; i < 100; i++){
     aa4:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
     aa8:	83 7d fc 63          	cmpl   $0x63,-0x4(%rbp)
     aac:	7e a3                	jle    a51 <exitwait+0x11>
    }
  }
  printf(1, "exitwait ok\n");
     aae:	48 c7 c6 ae 49 00 00 	mov    $0x49ae,%rsi
     ab5:	bf 01 00 00 00       	mov    $0x1,%edi
     aba:	b8 00 00 00 00       	mov    $0x0,%eax
     abf:	e8 d2 34 00 00       	call   3f96 <printf>
}
     ac4:	c9                   	leave
     ac5:	c3                   	ret

0000000000000ac6 <mem>:

void
mem(void)
{
     ac6:	55                   	push   %rbp
     ac7:	48 89 e5             	mov    %rsp,%rbp
     aca:	48 83 ec 20          	sub    $0x20,%rsp
  void *m1, *m2;
  int pid, ppid;

  printf(1, "mem test\n");
     ace:	48 c7 c6 bb 49 00 00 	mov    $0x49bb,%rsi
     ad5:	bf 01 00 00 00       	mov    $0x1,%edi
     ada:	b8 00 00 00 00       	mov    $0x0,%eax
     adf:	e8 b2 34 00 00       	call   3f96 <printf>
  ppid = getpid();
     ae4:	e8 9b 33 00 00       	call   3e84 <getpid>
     ae9:	89 45 f4             	mov    %eax,-0xc(%rbp)
  if((pid = fork()) == 0){
     aec:	e8 0b 33 00 00       	call   3dfc <fork>
     af1:	89 45 f0             	mov    %eax,-0x10(%rbp)
     af4:	83 7d f0 00          	cmpl   $0x0,-0x10(%rbp)
     af8:	0f 85 bb 00 00 00    	jne    bb9 <mem+0xf3>
    m1 = 0;
     afe:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
     b05:	00 
    while((m2 = malloc(10001)) != 0){
     b06:	eb 13                	jmp    b1b <mem+0x55>
      *(char**)m2 = m1;
     b08:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
     b0c:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
     b10:	48 89 10             	mov    %rdx,(%rax)
      m1 = m2;
     b13:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
     b17:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    while((m2 = malloc(10001)) != 0){
     b1b:	bf 11 27 00 00       	mov    $0x2711,%edi
     b20:	e8 64 39 00 00       	call   4489 <malloc>
     b25:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
     b29:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
     b2e:	75 d8                	jne    b08 <mem+0x42>
    }
    while(m1){
     b30:	eb 1f                	jmp    b51 <mem+0x8b>
      m2 = *(char**)m1;
     b32:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     b36:	48 8b 00             	mov    (%rax),%rax
     b39:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
      free(m1);
     b3d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     b41:	48 89 c7             	mov    %rax,%rdi
     b44:	e8 b5 37 00 00       	call   42fe <free>
      m1 = m2;
     b49:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
     b4d:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    while(m1){
     b51:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
     b56:	75 da                	jne    b32 <mem+0x6c>
    }
    m1 = malloc(1024*20);
     b58:	bf 00 50 00 00       	mov    $0x5000,%edi
     b5d:	e8 27 39 00 00       	call   4489 <malloc>
     b62:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(m1 == 0){
     b66:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
     b6b:	75 25                	jne    b92 <mem+0xcc>
      printf(1, "couldn't allocate mem?!!\n");
     b6d:	48 c7 c6 c5 49 00 00 	mov    $0x49c5,%rsi
     b74:	bf 01 00 00 00       	mov    $0x1,%edi
     b79:	b8 00 00 00 00       	mov    $0x0,%eax
     b7e:	e8 13 34 00 00       	call   3f96 <printf>
      kill(ppid);
     b83:	8b 45 f4             	mov    -0xc(%rbp),%eax
     b86:	89 c7                	mov    %eax,%edi
     b88:	e8 a7 32 00 00       	call   3e34 <kill>
      exit();
     b8d:	e8 72 32 00 00       	call   3e04 <exit>
    }
    free(m1);
     b92:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     b96:	48 89 c7             	mov    %rax,%rdi
     b99:	e8 60 37 00 00       	call   42fe <free>
    printf(1, "mem ok\n");
     b9e:	48 c7 c6 df 49 00 00 	mov    $0x49df,%rsi
     ba5:	bf 01 00 00 00       	mov    $0x1,%edi
     baa:	b8 00 00 00 00       	mov    $0x0,%eax
     baf:	e8 e2 33 00 00       	call   3f96 <printf>
    exit();
     bb4:	e8 4b 32 00 00       	call   3e04 <exit>
  } else {
    wait();
     bb9:	e8 4e 32 00 00       	call   3e0c <wait>
  }
}
     bbe:	90                   	nop
     bbf:	c9                   	leave
     bc0:	c3                   	ret

0000000000000bc1 <sharedfd>:

// two processes write to the same file descriptor
// is the offset shared? does inode locking work?
void
sharedfd(void)
{
     bc1:	55                   	push   %rbp
     bc2:	48 89 e5             	mov    %rsp,%rbp
     bc5:	48 83 ec 30          	sub    $0x30,%rsp
  int fd, pid, i, n, nc, np;
  char buf[10];

  printf(1, "sharedfd test\n");
     bc9:	48 c7 c6 e7 49 00 00 	mov    $0x49e7,%rsi
     bd0:	bf 01 00 00 00       	mov    $0x1,%edi
     bd5:	b8 00 00 00 00       	mov    $0x0,%eax
     bda:	e8 b7 33 00 00       	call   3f96 <printf>

  unlink("sharedfd");
     bdf:	48 c7 c7 f6 49 00 00 	mov    $0x49f6,%rdi
     be6:	e8 69 32 00 00       	call   3e54 <unlink>
  fd = open("sharedfd", O_CREATE|O_RDWR);
     beb:	be 02 02 00 00       	mov    $0x202,%esi
     bf0:	48 c7 c7 f6 49 00 00 	mov    $0x49f6,%rdi
     bf7:	e8 48 32 00 00       	call   3e44 <open>
     bfc:	89 45 f0             	mov    %eax,-0x10(%rbp)
  if(fd < 0){
     bff:	83 7d f0 00          	cmpl   $0x0,-0x10(%rbp)
     c03:	79 1b                	jns    c20 <sharedfd+0x5f>
    printf(1, "fstests: cannot open sharedfd for writing");
     c05:	48 c7 c6 00 4a 00 00 	mov    $0x4a00,%rsi
     c0c:	bf 01 00 00 00       	mov    $0x1,%edi
     c11:	b8 00 00 00 00       	mov    $0x0,%eax
     c16:	e8 7b 33 00 00       	call   3f96 <printf>
    return;
     c1b:	e9 91 01 00 00       	jmp    db1 <sharedfd+0x1f0>
  }
  pid = fork();
     c20:	e8 d7 31 00 00       	call   3dfc <fork>
     c25:	89 45 ec             	mov    %eax,-0x14(%rbp)
  memset(buf, pid==0?'c':'p', sizeof(buf));
     c28:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
     c2c:	75 07                	jne    c35 <sharedfd+0x74>
     c2e:	b9 63 00 00 00       	mov    $0x63,%ecx
     c33:	eb 05                	jmp    c3a <sharedfd+0x79>
     c35:	b9 70 00 00 00       	mov    $0x70,%ecx
     c3a:	48 8d 45 de          	lea    -0x22(%rbp),%rax
     c3e:	ba 0a 00 00 00       	mov    $0xa,%edx
     c43:	89 ce                	mov    %ecx,%esi
     c45:	48 89 c7             	mov    %rax,%rdi
     c48:	e8 c2 2f 00 00       	call   3c0f <memset>
  for(i = 0; i < 1000; i++){
     c4d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
     c54:	eb 37                	jmp    c8d <sharedfd+0xcc>
    if(write(fd, buf, sizeof(buf)) != sizeof(buf)){
     c56:	48 8d 4d de          	lea    -0x22(%rbp),%rcx
     c5a:	8b 45 f0             	mov    -0x10(%rbp),%eax
     c5d:	ba 0a 00 00 00       	mov    $0xa,%edx
     c62:	48 89 ce             	mov    %rcx,%rsi
     c65:	89 c7                	mov    %eax,%edi
     c67:	e8 b8 31 00 00       	call   3e24 <write>
     c6c:	83 f8 0a             	cmp    $0xa,%eax
     c6f:	74 18                	je     c89 <sharedfd+0xc8>
      printf(1, "fstests: write sharedfd failed\n");
     c71:	48 c7 c6 30 4a 00 00 	mov    $0x4a30,%rsi
     c78:	bf 01 00 00 00       	mov    $0x1,%edi
     c7d:	b8 00 00 00 00       	mov    $0x0,%eax
     c82:	e8 0f 33 00 00       	call   3f96 <printf>
      break;
     c87:	eb 0d                	jmp    c96 <sharedfd+0xd5>
  for(i = 0; i < 1000; i++){
     c89:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
     c8d:	81 7d fc e7 03 00 00 	cmpl   $0x3e7,-0x4(%rbp)
     c94:	7e c0                	jle    c56 <sharedfd+0x95>
    }
  }
  if(pid == 0)
     c96:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
     c9a:	75 05                	jne    ca1 <sharedfd+0xe0>
    exit();
     c9c:	e8 63 31 00 00       	call   3e04 <exit>
  else
    wait();
     ca1:	e8 66 31 00 00       	call   3e0c <wait>
  close(fd);
     ca6:	8b 45 f0             	mov    -0x10(%rbp),%eax
     ca9:	89 c7                	mov    %eax,%edi
     cab:	e8 7c 31 00 00       	call   3e2c <close>
  fd = open("sharedfd", 0);
     cb0:	be 00 00 00 00       	mov    $0x0,%esi
     cb5:	48 c7 c7 f6 49 00 00 	mov    $0x49f6,%rdi
     cbc:	e8 83 31 00 00       	call   3e44 <open>
     cc1:	89 45 f0             	mov    %eax,-0x10(%rbp)
  if(fd < 0){
     cc4:	83 7d f0 00          	cmpl   $0x0,-0x10(%rbp)
     cc8:	79 1b                	jns    ce5 <sharedfd+0x124>
    printf(1, "fstests: cannot open sharedfd for reading\n");
     cca:	48 c7 c6 50 4a 00 00 	mov    $0x4a50,%rsi
     cd1:	bf 01 00 00 00       	mov    $0x1,%edi
     cd6:	b8 00 00 00 00       	mov    $0x0,%eax
     cdb:	e8 b6 32 00 00       	call   3f96 <printf>
    return;
     ce0:	e9 cc 00 00 00       	jmp    db1 <sharedfd+0x1f0>
  }
  nc = np = 0;
     ce5:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
     cec:	8b 45 f4             	mov    -0xc(%rbp),%eax
     cef:	89 45 f8             	mov    %eax,-0x8(%rbp)
  while((n = read(fd, buf, sizeof(buf))) > 0){
     cf2:	eb 39                	jmp    d2d <sharedfd+0x16c>
    for(i = 0; i < sizeof(buf); i++){
     cf4:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
     cfb:	eb 28                	jmp    d25 <sharedfd+0x164>
      if(buf[i] == 'c')
     cfd:	8b 45 fc             	mov    -0x4(%rbp),%eax
     d00:	48 98                	cltq
     d02:	0f b6 44 05 de       	movzbl -0x22(%rbp,%rax,1),%eax
     d07:	3c 63                	cmp    $0x63,%al
     d09:	75 04                	jne    d0f <sharedfd+0x14e>
        nc++;
     d0b:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
      if(buf[i] == 'p')
     d0f:	8b 45 fc             	mov    -0x4(%rbp),%eax
     d12:	48 98                	cltq
     d14:	0f b6 44 05 de       	movzbl -0x22(%rbp,%rax,1),%eax
     d19:	3c 70                	cmp    $0x70,%al
     d1b:	75 04                	jne    d21 <sharedfd+0x160>
        np++;
     d1d:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
    for(i = 0; i < sizeof(buf); i++){
     d21:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
     d25:	8b 45 fc             	mov    -0x4(%rbp),%eax
     d28:	83 f8 09             	cmp    $0x9,%eax
     d2b:	76 d0                	jbe    cfd <sharedfd+0x13c>
  while((n = read(fd, buf, sizeof(buf))) > 0){
     d2d:	48 8d 4d de          	lea    -0x22(%rbp),%rcx
     d31:	8b 45 f0             	mov    -0x10(%rbp),%eax
     d34:	ba 0a 00 00 00       	mov    $0xa,%edx
     d39:	48 89 ce             	mov    %rcx,%rsi
     d3c:	89 c7                	mov    %eax,%edi
     d3e:	e8 d9 30 00 00       	call   3e1c <read>
     d43:	89 45 e8             	mov    %eax,-0x18(%rbp)
     d46:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
     d4a:	7f a8                	jg     cf4 <sharedfd+0x133>
    }
  }
  close(fd);
     d4c:	8b 45 f0             	mov    -0x10(%rbp),%eax
     d4f:	89 c7                	mov    %eax,%edi
     d51:	e8 d6 30 00 00       	call   3e2c <close>
  unlink("sharedfd");
     d56:	48 c7 c7 f6 49 00 00 	mov    $0x49f6,%rdi
     d5d:	e8 f2 30 00 00       	call   3e54 <unlink>
  if(nc == 10000 && np == 10000){
     d62:	81 7d f8 10 27 00 00 	cmpl   $0x2710,-0x8(%rbp)
     d69:	75 21                	jne    d8c <sharedfd+0x1cb>
     d6b:	81 7d f4 10 27 00 00 	cmpl   $0x2710,-0xc(%rbp)
     d72:	75 18                	jne    d8c <sharedfd+0x1cb>
    printf(1, "sharedfd ok\n");
     d74:	48 c7 c6 7b 4a 00 00 	mov    $0x4a7b,%rsi
     d7b:	bf 01 00 00 00       	mov    $0x1,%edi
     d80:	b8 00 00 00 00       	mov    $0x0,%eax
     d85:	e8 0c 32 00 00       	call   3f96 <printf>
     d8a:	eb 25                	jmp    db1 <sharedfd+0x1f0>
  } else {
    printf(1, "sharedfd oops %d %d\n", nc, np);
     d8c:	8b 55 f4             	mov    -0xc(%rbp),%edx
     d8f:	8b 45 f8             	mov    -0x8(%rbp),%eax
     d92:	89 d1                	mov    %edx,%ecx
     d94:	89 c2                	mov    %eax,%edx
     d96:	48 c7 c6 88 4a 00 00 	mov    $0x4a88,%rsi
     d9d:	bf 01 00 00 00       	mov    $0x1,%edi
     da2:	b8 00 00 00 00       	mov    $0x0,%eax
     da7:	e8 ea 31 00 00       	call   3f96 <printf>
    exit();
     dac:	e8 53 30 00 00       	call   3e04 <exit>
  }
}
     db1:	c9                   	leave
     db2:	c3                   	ret

0000000000000db3 <twofiles>:

// two processes write two different files at the same
// time, to test block allocation.
void
twofiles(void)
{
     db3:	55                   	push   %rbp
     db4:	48 89 e5             	mov    %rsp,%rbp
     db7:	48 83 ec 20          	sub    $0x20,%rsp
  int fd, pid, i, j, n, total;
  char *fname;

  printf(1, "twofiles test\n");
     dbb:	48 c7 c6 9d 4a 00 00 	mov    $0x4a9d,%rsi
     dc2:	bf 01 00 00 00       	mov    $0x1,%edi
     dc7:	b8 00 00 00 00       	mov    $0x0,%eax
     dcc:	e8 c5 31 00 00       	call   3f96 <printf>

  unlink("f1");
     dd1:	48 c7 c7 ac 4a 00 00 	mov    $0x4aac,%rdi
     dd8:	e8 77 30 00 00       	call   3e54 <unlink>
  unlink("f2");
     ddd:	48 c7 c7 af 4a 00 00 	mov    $0x4aaf,%rdi
     de4:	e8 6b 30 00 00       	call   3e54 <unlink>

  pid = fork();
     de9:	e8 0e 30 00 00       	call   3dfc <fork>
     dee:	89 45 f0             	mov    %eax,-0x10(%rbp)
  if(pid < 0){
     df1:	83 7d f0 00          	cmpl   $0x0,-0x10(%rbp)
     df5:	79 1b                	jns    e12 <twofiles+0x5f>
    printf(1, "fork failed\n");
     df7:	48 c7 c6 91 49 00 00 	mov    $0x4991,%rsi
     dfe:	bf 01 00 00 00       	mov    $0x1,%edi
     e03:	b8 00 00 00 00       	mov    $0x0,%eax
     e08:	e8 89 31 00 00       	call   3f96 <printf>
    exit();
     e0d:	e8 f2 2f 00 00       	call   3e04 <exit>
  }

  fname = pid ? "f1" : "f2";
     e12:	83 7d f0 00          	cmpl   $0x0,-0x10(%rbp)
     e16:	74 09                	je     e21 <twofiles+0x6e>
     e18:	48 c7 c0 ac 4a 00 00 	mov    $0x4aac,%rax
     e1f:	eb 07                	jmp    e28 <twofiles+0x75>
     e21:	48 c7 c0 af 4a 00 00 	mov    $0x4aaf,%rax
     e28:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  fd = open(fname, O_CREATE | O_RDWR);
     e2c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
     e30:	be 02 02 00 00       	mov    $0x202,%esi
     e35:	48 89 c7             	mov    %rax,%rdi
     e38:	e8 07 30 00 00       	call   3e44 <open>
     e3d:	89 45 e4             	mov    %eax,-0x1c(%rbp)
  if(fd < 0){
     e40:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
     e44:	79 1b                	jns    e61 <twofiles+0xae>
    printf(1, "create failed\n");
     e46:	48 c7 c6 b2 4a 00 00 	mov    $0x4ab2,%rsi
     e4d:	bf 01 00 00 00       	mov    $0x1,%edi
     e52:	b8 00 00 00 00       	mov    $0x0,%eax
     e57:	e8 3a 31 00 00       	call   3f96 <printf>
    exit();
     e5c:	e8 a3 2f 00 00       	call   3e04 <exit>
  }

  memset(buf, pid?'p':'c', 512);
     e61:	83 7d f0 00          	cmpl   $0x0,-0x10(%rbp)
     e65:	74 07                	je     e6e <twofiles+0xbb>
     e67:	b8 70 00 00 00       	mov    $0x70,%eax
     e6c:	eb 05                	jmp    e73 <twofiles+0xc0>
     e6e:	b8 63 00 00 00       	mov    $0x63,%eax
     e73:	ba 00 02 00 00       	mov    $0x200,%edx
     e78:	89 c6                	mov    %eax,%esi
     e7a:	48 c7 c7 60 63 00 00 	mov    $0x6360,%rdi
     e81:	e8 89 2d 00 00       	call   3c0f <memset>
  for(i = 0; i < 12; i++){
     e86:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
     e8d:	eb 46                	jmp    ed5 <twofiles+0x122>
    if((n = write(fd, buf, 500)) != 500){
     e8f:	8b 45 e4             	mov    -0x1c(%rbp),%eax
     e92:	ba f4 01 00 00       	mov    $0x1f4,%edx
     e97:	48 c7 c6 60 63 00 00 	mov    $0x6360,%rsi
     e9e:	89 c7                	mov    %eax,%edi
     ea0:	e8 7f 2f 00 00       	call   3e24 <write>
     ea5:	89 45 e0             	mov    %eax,-0x20(%rbp)
     ea8:	81 7d e0 f4 01 00 00 	cmpl   $0x1f4,-0x20(%rbp)
     eaf:	74 20                	je     ed1 <twofiles+0x11e>
      printf(1, "write failed %d\n", n);
     eb1:	8b 45 e0             	mov    -0x20(%rbp),%eax
     eb4:	89 c2                	mov    %eax,%edx
     eb6:	48 c7 c6 c1 4a 00 00 	mov    $0x4ac1,%rsi
     ebd:	bf 01 00 00 00       	mov    $0x1,%edi
     ec2:	b8 00 00 00 00       	mov    $0x0,%eax
     ec7:	e8 ca 30 00 00       	call   3f96 <printf>
      exit();
     ecc:	e8 33 2f 00 00       	call   3e04 <exit>
  for(i = 0; i < 12; i++){
     ed1:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
     ed5:	83 7d fc 0b          	cmpl   $0xb,-0x4(%rbp)
     ed9:	7e b4                	jle    e8f <twofiles+0xdc>
    }
  }
  close(fd);
     edb:	8b 45 e4             	mov    -0x1c(%rbp),%eax
     ede:	89 c7                	mov    %eax,%edi
     ee0:	e8 47 2f 00 00       	call   3e2c <close>
  if(pid)
     ee5:	83 7d f0 00          	cmpl   $0x0,-0x10(%rbp)
     ee9:	74 11                	je     efc <twofiles+0x149>
    wait();
     eeb:	e8 1c 2f 00 00       	call   3e0c <wait>
  else
    exit();

  for(i = 0; i < 2; i++){
     ef0:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
     ef7:	e9 e5 00 00 00       	jmp    fe1 <twofiles+0x22e>
    exit();
     efc:	e8 03 2f 00 00       	call   3e04 <exit>
    fd = open(i?"f1":"f2", 0);
     f01:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
     f05:	74 09                	je     f10 <twofiles+0x15d>
     f07:	48 c7 c0 ac 4a 00 00 	mov    $0x4aac,%rax
     f0e:	eb 07                	jmp    f17 <twofiles+0x164>
     f10:	48 c7 c0 af 4a 00 00 	mov    $0x4aaf,%rax
     f17:	be 00 00 00 00       	mov    $0x0,%esi
     f1c:	48 89 c7             	mov    %rax,%rdi
     f1f:	e8 20 2f 00 00       	call   3e44 <open>
     f24:	89 45 e4             	mov    %eax,-0x1c(%rbp)
    total = 0;
     f27:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
    while((n = read(fd, buf, sizeof(buf))) > 0){
     f2e:	eb 5b                	jmp    f8b <twofiles+0x1d8>
      for(j = 0; j < n; j++){
     f30:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
     f37:	eb 44                	jmp    f7d <twofiles+0x1ca>
        if(buf[j] != (i?'p':'c')){
     f39:	8b 45 f8             	mov    -0x8(%rbp),%eax
     f3c:	48 98                	cltq
     f3e:	0f b6 80 60 63 00 00 	movzbl 0x6360(%rax),%eax
     f45:	0f be c0             	movsbl %al,%eax
     f48:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
     f4c:	74 07                	je     f55 <twofiles+0x1a2>
     f4e:	ba 70 00 00 00       	mov    $0x70,%edx
     f53:	eb 05                	jmp    f5a <twofiles+0x1a7>
     f55:	ba 63 00 00 00       	mov    $0x63,%edx
     f5a:	39 c2                	cmp    %eax,%edx
     f5c:	74 1b                	je     f79 <twofiles+0x1c6>
          printf(1, "wrong char\n");
     f5e:	48 c7 c6 d2 4a 00 00 	mov    $0x4ad2,%rsi
     f65:	bf 01 00 00 00       	mov    $0x1,%edi
     f6a:	b8 00 00 00 00       	mov    $0x0,%eax
     f6f:	e8 22 30 00 00       	call   3f96 <printf>
          exit();
     f74:	e8 8b 2e 00 00       	call   3e04 <exit>
      for(j = 0; j < n; j++){
     f79:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
     f7d:	8b 45 f8             	mov    -0x8(%rbp),%eax
     f80:	3b 45 e0             	cmp    -0x20(%rbp),%eax
     f83:	7c b4                	jl     f39 <twofiles+0x186>
        }
      }
      total += n;
     f85:	8b 45 e0             	mov    -0x20(%rbp),%eax
     f88:	01 45 f4             	add    %eax,-0xc(%rbp)
    while((n = read(fd, buf, sizeof(buf))) > 0){
     f8b:	8b 45 e4             	mov    -0x1c(%rbp),%eax
     f8e:	ba 00 20 00 00       	mov    $0x2000,%edx
     f93:	48 c7 c6 60 63 00 00 	mov    $0x6360,%rsi
     f9a:	89 c7                	mov    %eax,%edi
     f9c:	e8 7b 2e 00 00       	call   3e1c <read>
     fa1:	89 45 e0             	mov    %eax,-0x20(%rbp)
     fa4:	83 7d e0 00          	cmpl   $0x0,-0x20(%rbp)
     fa8:	7f 86                	jg     f30 <twofiles+0x17d>
    }
    close(fd);
     faa:	8b 45 e4             	mov    -0x1c(%rbp),%eax
     fad:	89 c7                	mov    %eax,%edi
     faf:	e8 78 2e 00 00       	call   3e2c <close>
    if(total != 12*500){
     fb4:	81 7d f4 70 17 00 00 	cmpl   $0x1770,-0xc(%rbp)
     fbb:	74 20                	je     fdd <twofiles+0x22a>
      printf(1, "wrong length %d\n", total);
     fbd:	8b 45 f4             	mov    -0xc(%rbp),%eax
     fc0:	89 c2                	mov    %eax,%edx
     fc2:	48 c7 c6 de 4a 00 00 	mov    $0x4ade,%rsi
     fc9:	bf 01 00 00 00       	mov    $0x1,%edi
     fce:	b8 00 00 00 00       	mov    $0x0,%eax
     fd3:	e8 be 2f 00 00       	call   3f96 <printf>
      exit();
     fd8:	e8 27 2e 00 00       	call   3e04 <exit>
  for(i = 0; i < 2; i++){
     fdd:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
     fe1:	83 7d fc 01          	cmpl   $0x1,-0x4(%rbp)
     fe5:	0f 8e 16 ff ff ff    	jle    f01 <twofiles+0x14e>
    }
  }

  unlink("f1");
     feb:	48 c7 c7 ac 4a 00 00 	mov    $0x4aac,%rdi
     ff2:	e8 5d 2e 00 00       	call   3e54 <unlink>
  unlink("f2");
     ff7:	48 c7 c7 af 4a 00 00 	mov    $0x4aaf,%rdi
     ffe:	e8 51 2e 00 00       	call   3e54 <unlink>

  printf(1, "twofiles ok\n");
    1003:	48 c7 c6 ef 4a 00 00 	mov    $0x4aef,%rsi
    100a:	bf 01 00 00 00       	mov    $0x1,%edi
    100f:	b8 00 00 00 00       	mov    $0x0,%eax
    1014:	e8 7d 2f 00 00       	call   3f96 <printf>
}
    1019:	90                   	nop
    101a:	c9                   	leave
    101b:	c3                   	ret

000000000000101c <createdelete>:

// two processes create and delete different files in same directory
void
createdelete(void)
{
    101c:	55                   	push   %rbp
    101d:	48 89 e5             	mov    %rsp,%rbp
    1020:	48 83 ec 30          	sub    $0x30,%rsp
  enum { N = 20 };
  int pid, i, fd;
  char name[32];

  printf(1, "createdelete test\n");
    1024:	48 c7 c6 fc 4a 00 00 	mov    $0x4afc,%rsi
    102b:	bf 01 00 00 00       	mov    $0x1,%edi
    1030:	b8 00 00 00 00       	mov    $0x0,%eax
    1035:	e8 5c 2f 00 00       	call   3f96 <printf>
  pid = fork();
    103a:	e8 bd 2d 00 00       	call   3dfc <fork>
    103f:	89 45 f8             	mov    %eax,-0x8(%rbp)
  if(pid < 0){
    1042:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
    1046:	79 1b                	jns    1063 <createdelete+0x47>
    printf(1, "fork failed\n");
    1048:	48 c7 c6 91 49 00 00 	mov    $0x4991,%rsi
    104f:	bf 01 00 00 00       	mov    $0x1,%edi
    1054:	b8 00 00 00 00       	mov    $0x0,%eax
    1059:	e8 38 2f 00 00       	call   3f96 <printf>
    exit();
    105e:	e8 a1 2d 00 00       	call   3e04 <exit>
  }

  name[0] = pid ? 'p' : 'c';
    1063:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
    1067:	74 07                	je     1070 <createdelete+0x54>
    1069:	b8 70 00 00 00       	mov    $0x70,%eax
    106e:	eb 05                	jmp    1075 <createdelete+0x59>
    1070:	b8 63 00 00 00       	mov    $0x63,%eax
    1075:	88 45 d0             	mov    %al,-0x30(%rbp)
  name[2] = '\0';
    1078:	c6 45 d2 00          	movb   $0x0,-0x2e(%rbp)
  for(i = 0; i < N; i++){
    107c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    1083:	e9 99 00 00 00       	jmp    1121 <createdelete+0x105>
    name[1] = '0' + i;
    1088:	8b 45 fc             	mov    -0x4(%rbp),%eax
    108b:	83 c0 30             	add    $0x30,%eax
    108e:	88 45 d1             	mov    %al,-0x2f(%rbp)
    fd = open(name, O_CREATE | O_RDWR);
    1091:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
    1095:	be 02 02 00 00       	mov    $0x202,%esi
    109a:	48 89 c7             	mov    %rax,%rdi
    109d:	e8 a2 2d 00 00       	call   3e44 <open>
    10a2:	89 45 f4             	mov    %eax,-0xc(%rbp)
    if(fd < 0){
    10a5:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
    10a9:	79 1b                	jns    10c6 <createdelete+0xaa>
      printf(1, "create failed\n");
    10ab:	48 c7 c6 b2 4a 00 00 	mov    $0x4ab2,%rsi
    10b2:	bf 01 00 00 00       	mov    $0x1,%edi
    10b7:	b8 00 00 00 00       	mov    $0x0,%eax
    10bc:	e8 d5 2e 00 00       	call   3f96 <printf>
      exit();
    10c1:	e8 3e 2d 00 00       	call   3e04 <exit>
    }
    close(fd);
    10c6:	8b 45 f4             	mov    -0xc(%rbp),%eax
    10c9:	89 c7                	mov    %eax,%edi
    10cb:	e8 5c 2d 00 00       	call   3e2c <close>
    if(i > 0 && (i % 2 ) == 0){
    10d0:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    10d4:	7e 47                	jle    111d <createdelete+0x101>
    10d6:	8b 45 fc             	mov    -0x4(%rbp),%eax
    10d9:	83 e0 01             	and    $0x1,%eax
    10dc:	85 c0                	test   %eax,%eax
    10de:	75 3d                	jne    111d <createdelete+0x101>
      name[1] = '0' + (i / 2);
    10e0:	8b 45 fc             	mov    -0x4(%rbp),%eax
    10e3:	89 c2                	mov    %eax,%edx
    10e5:	c1 ea 1f             	shr    $0x1f,%edx
    10e8:	01 d0                	add    %edx,%eax
    10ea:	d1 f8                	sar    %eax
    10ec:	83 c0 30             	add    $0x30,%eax
    10ef:	88 45 d1             	mov    %al,-0x2f(%rbp)
      if(unlink(name) < 0){
    10f2:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
    10f6:	48 89 c7             	mov    %rax,%rdi
    10f9:	e8 56 2d 00 00       	call   3e54 <unlink>
    10fe:	85 c0                	test   %eax,%eax
    1100:	79 1b                	jns    111d <createdelete+0x101>
        printf(1, "unlink failed\n");
    1102:	48 c7 c6 0f 4b 00 00 	mov    $0x4b0f,%rsi
    1109:	bf 01 00 00 00       	mov    $0x1,%edi
    110e:	b8 00 00 00 00       	mov    $0x0,%eax
    1113:	e8 7e 2e 00 00       	call   3f96 <printf>
        exit();
    1118:	e8 e7 2c 00 00       	call   3e04 <exit>
  for(i = 0; i < N; i++){
    111d:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    1121:	83 7d fc 13          	cmpl   $0x13,-0x4(%rbp)
    1125:	0f 8e 5d ff ff ff    	jle    1088 <createdelete+0x6c>
      }
    }
  }

  if(pid==0)
    112b:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
    112f:	75 05                	jne    1136 <createdelete+0x11a>
    exit();
    1131:	e8 ce 2c 00 00       	call   3e04 <exit>
  else
    wait();
    1136:	e8 d1 2c 00 00       	call   3e0c <wait>

  for(i = 0; i < N; i++){
    113b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    1142:	e9 36 01 00 00       	jmp    127d <createdelete+0x261>
    name[0] = 'p';
    1147:	c6 45 d0 70          	movb   $0x70,-0x30(%rbp)
    name[1] = '0' + i;
    114b:	8b 45 fc             	mov    -0x4(%rbp),%eax
    114e:	83 c0 30             	add    $0x30,%eax
    1151:	88 45 d1             	mov    %al,-0x2f(%rbp)
    fd = open(name, 0);
    1154:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
    1158:	be 00 00 00 00       	mov    $0x0,%esi
    115d:	48 89 c7             	mov    %rax,%rdi
    1160:	e8 df 2c 00 00       	call   3e44 <open>
    1165:	89 45 f4             	mov    %eax,-0xc(%rbp)
    if((i == 0 || i >= N/2) && fd < 0){
    1168:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    116c:	74 06                	je     1174 <createdelete+0x158>
    116e:	83 7d fc 09          	cmpl   $0x9,-0x4(%rbp)
    1172:	7e 28                	jle    119c <createdelete+0x180>
    1174:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
    1178:	79 22                	jns    119c <createdelete+0x180>
      printf(1, "oops createdelete %s didn't exist\n", name);
    117a:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
    117e:	48 89 c2             	mov    %rax,%rdx
    1181:	48 c7 c6 20 4b 00 00 	mov    $0x4b20,%rsi
    1188:	bf 01 00 00 00       	mov    $0x1,%edi
    118d:	b8 00 00 00 00       	mov    $0x0,%eax
    1192:	e8 ff 2d 00 00       	call   3f96 <printf>
      exit();
    1197:	e8 68 2c 00 00       	call   3e04 <exit>
    } else if((i >= 1 && i < N/2) && fd >= 0){
    119c:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    11a0:	7e 2e                	jle    11d0 <createdelete+0x1b4>
    11a2:	83 7d fc 09          	cmpl   $0x9,-0x4(%rbp)
    11a6:	7f 28                	jg     11d0 <createdelete+0x1b4>
    11a8:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
    11ac:	78 22                	js     11d0 <createdelete+0x1b4>
      printf(1, "oops createdelete %s did exist\n", name);
    11ae:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
    11b2:	48 89 c2             	mov    %rax,%rdx
    11b5:	48 c7 c6 48 4b 00 00 	mov    $0x4b48,%rsi
    11bc:	bf 01 00 00 00       	mov    $0x1,%edi
    11c1:	b8 00 00 00 00       	mov    $0x0,%eax
    11c6:	e8 cb 2d 00 00       	call   3f96 <printf>
      exit();
    11cb:	e8 34 2c 00 00       	call   3e04 <exit>
    }
    if(fd >= 0)
    11d0:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
    11d4:	78 0a                	js     11e0 <createdelete+0x1c4>
      close(fd);
    11d6:	8b 45 f4             	mov    -0xc(%rbp),%eax
    11d9:	89 c7                	mov    %eax,%edi
    11db:	e8 4c 2c 00 00       	call   3e2c <close>

    name[0] = 'c';
    11e0:	c6 45 d0 63          	movb   $0x63,-0x30(%rbp)
    name[1] = '0' + i;
    11e4:	8b 45 fc             	mov    -0x4(%rbp),%eax
    11e7:	83 c0 30             	add    $0x30,%eax
    11ea:	88 45 d1             	mov    %al,-0x2f(%rbp)
    fd = open(name, 0);
    11ed:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
    11f1:	be 00 00 00 00       	mov    $0x0,%esi
    11f6:	48 89 c7             	mov    %rax,%rdi
    11f9:	e8 46 2c 00 00       	call   3e44 <open>
    11fe:	89 45 f4             	mov    %eax,-0xc(%rbp)
    if((i == 0 || i >= N/2) && fd < 0){
    1201:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    1205:	74 06                	je     120d <createdelete+0x1f1>
    1207:	83 7d fc 09          	cmpl   $0x9,-0x4(%rbp)
    120b:	7e 28                	jle    1235 <createdelete+0x219>
    120d:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
    1211:	79 22                	jns    1235 <createdelete+0x219>
      printf(1, "oops createdelete %s didn't exist\n", name);
    1213:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
    1217:	48 89 c2             	mov    %rax,%rdx
    121a:	48 c7 c6 20 4b 00 00 	mov    $0x4b20,%rsi
    1221:	bf 01 00 00 00       	mov    $0x1,%edi
    1226:	b8 00 00 00 00       	mov    $0x0,%eax
    122b:	e8 66 2d 00 00       	call   3f96 <printf>
      exit();
    1230:	e8 cf 2b 00 00       	call   3e04 <exit>
    } else if((i >= 1 && i < N/2) && fd >= 0){
    1235:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    1239:	7e 2e                	jle    1269 <createdelete+0x24d>
    123b:	83 7d fc 09          	cmpl   $0x9,-0x4(%rbp)
    123f:	7f 28                	jg     1269 <createdelete+0x24d>
    1241:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
    1245:	78 22                	js     1269 <createdelete+0x24d>
      printf(1, "oops createdelete %s did exist\n", name);
    1247:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
    124b:	48 89 c2             	mov    %rax,%rdx
    124e:	48 c7 c6 48 4b 00 00 	mov    $0x4b48,%rsi
    1255:	bf 01 00 00 00       	mov    $0x1,%edi
    125a:	b8 00 00 00 00       	mov    $0x0,%eax
    125f:	e8 32 2d 00 00       	call   3f96 <printf>
      exit();
    1264:	e8 9b 2b 00 00       	call   3e04 <exit>
    }
    if(fd >= 0)
    1269:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
    126d:	78 0a                	js     1279 <createdelete+0x25d>
      close(fd);
    126f:	8b 45 f4             	mov    -0xc(%rbp),%eax
    1272:	89 c7                	mov    %eax,%edi
    1274:	e8 b3 2b 00 00       	call   3e2c <close>
  for(i = 0; i < N; i++){
    1279:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    127d:	83 7d fc 13          	cmpl   $0x13,-0x4(%rbp)
    1281:	0f 8e c0 fe ff ff    	jle    1147 <createdelete+0x12b>
  }

  for(i = 0; i < N; i++){
    1287:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    128e:	eb 2d                	jmp    12bd <createdelete+0x2a1>
    name[0] = 'p';
    1290:	c6 45 d0 70          	movb   $0x70,-0x30(%rbp)
    name[1] = '0' + i;
    1294:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1297:	83 c0 30             	add    $0x30,%eax
    129a:	88 45 d1             	mov    %al,-0x2f(%rbp)
    unlink(name);
    129d:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
    12a1:	48 89 c7             	mov    %rax,%rdi
    12a4:	e8 ab 2b 00 00       	call   3e54 <unlink>
    name[0] = 'c';
    12a9:	c6 45 d0 63          	movb   $0x63,-0x30(%rbp)
    unlink(name);
    12ad:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
    12b1:	48 89 c7             	mov    %rax,%rdi
    12b4:	e8 9b 2b 00 00       	call   3e54 <unlink>
  for(i = 0; i < N; i++){
    12b9:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    12bd:	83 7d fc 13          	cmpl   $0x13,-0x4(%rbp)
    12c1:	7e cd                	jle    1290 <createdelete+0x274>
  }

  printf(1, "createdelete ok\n");
    12c3:	48 c7 c6 68 4b 00 00 	mov    $0x4b68,%rsi
    12ca:	bf 01 00 00 00       	mov    $0x1,%edi
    12cf:	b8 00 00 00 00       	mov    $0x0,%eax
    12d4:	e8 bd 2c 00 00       	call   3f96 <printf>
}
    12d9:	90                   	nop
    12da:	c9                   	leave
    12db:	c3                   	ret

00000000000012dc <unlinkread>:

// can I unlink a file and still read it?
void
unlinkread(void)
{
    12dc:	55                   	push   %rbp
    12dd:	48 89 e5             	mov    %rsp,%rbp
    12e0:	48 83 ec 10          	sub    $0x10,%rsp
  int fd, fd1;

  printf(1, "unlinkread test\n");
    12e4:	48 c7 c6 79 4b 00 00 	mov    $0x4b79,%rsi
    12eb:	bf 01 00 00 00       	mov    $0x1,%edi
    12f0:	b8 00 00 00 00       	mov    $0x0,%eax
    12f5:	e8 9c 2c 00 00       	call   3f96 <printf>
  fd = open("unlinkread", O_CREATE | O_RDWR);
    12fa:	be 02 02 00 00       	mov    $0x202,%esi
    12ff:	48 c7 c7 8a 4b 00 00 	mov    $0x4b8a,%rdi
    1306:	e8 39 2b 00 00       	call   3e44 <open>
    130b:	89 45 fc             	mov    %eax,-0x4(%rbp)
  if(fd < 0){
    130e:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    1312:	79 1b                	jns    132f <unlinkread+0x53>
    printf(1, "create unlinkread failed\n");
    1314:	48 c7 c6 95 4b 00 00 	mov    $0x4b95,%rsi
    131b:	bf 01 00 00 00       	mov    $0x1,%edi
    1320:	b8 00 00 00 00       	mov    $0x0,%eax
    1325:	e8 6c 2c 00 00       	call   3f96 <printf>
    exit();
    132a:	e8 d5 2a 00 00       	call   3e04 <exit>
  }
  write(fd, "hello", 5);
    132f:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1332:	ba 05 00 00 00       	mov    $0x5,%edx
    1337:	48 c7 c6 af 4b 00 00 	mov    $0x4baf,%rsi
    133e:	89 c7                	mov    %eax,%edi
    1340:	e8 df 2a 00 00       	call   3e24 <write>
  close(fd);
    1345:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1348:	89 c7                	mov    %eax,%edi
    134a:	e8 dd 2a 00 00       	call   3e2c <close>

  fd = open("unlinkread", O_RDWR);
    134f:	be 02 00 00 00       	mov    $0x2,%esi
    1354:	48 c7 c7 8a 4b 00 00 	mov    $0x4b8a,%rdi
    135b:	e8 e4 2a 00 00       	call   3e44 <open>
    1360:	89 45 fc             	mov    %eax,-0x4(%rbp)
  if(fd < 0){
    1363:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    1367:	79 1b                	jns    1384 <unlinkread+0xa8>
    printf(1, "open unlinkread failed\n");
    1369:	48 c7 c6 b5 4b 00 00 	mov    $0x4bb5,%rsi
    1370:	bf 01 00 00 00       	mov    $0x1,%edi
    1375:	b8 00 00 00 00       	mov    $0x0,%eax
    137a:	e8 17 2c 00 00       	call   3f96 <printf>
    exit();
    137f:	e8 80 2a 00 00       	call   3e04 <exit>
  }
  if(unlink("unlinkread") != 0){
    1384:	48 c7 c7 8a 4b 00 00 	mov    $0x4b8a,%rdi
    138b:	e8 c4 2a 00 00       	call   3e54 <unlink>
    1390:	85 c0                	test   %eax,%eax
    1392:	74 1b                	je     13af <unlinkread+0xd3>
    printf(1, "unlink unlinkread failed\n");
    1394:	48 c7 c6 cd 4b 00 00 	mov    $0x4bcd,%rsi
    139b:	bf 01 00 00 00       	mov    $0x1,%edi
    13a0:	b8 00 00 00 00       	mov    $0x0,%eax
    13a5:	e8 ec 2b 00 00       	call   3f96 <printf>
    exit();
    13aa:	e8 55 2a 00 00       	call   3e04 <exit>
  }

  fd1 = open("unlinkread", O_CREATE | O_RDWR);
    13af:	be 02 02 00 00       	mov    $0x202,%esi
    13b4:	48 c7 c7 8a 4b 00 00 	mov    $0x4b8a,%rdi
    13bb:	e8 84 2a 00 00       	call   3e44 <open>
    13c0:	89 45 f8             	mov    %eax,-0x8(%rbp)
  write(fd1, "yyy", 3);
    13c3:	8b 45 f8             	mov    -0x8(%rbp),%eax
    13c6:	ba 03 00 00 00       	mov    $0x3,%edx
    13cb:	48 c7 c6 e7 4b 00 00 	mov    $0x4be7,%rsi
    13d2:	89 c7                	mov    %eax,%edi
    13d4:	e8 4b 2a 00 00       	call   3e24 <write>
  close(fd1);
    13d9:	8b 45 f8             	mov    -0x8(%rbp),%eax
    13dc:	89 c7                	mov    %eax,%edi
    13de:	e8 49 2a 00 00       	call   3e2c <close>

  if(read(fd, buf, sizeof(buf)) != 5){
    13e3:	8b 45 fc             	mov    -0x4(%rbp),%eax
    13e6:	ba 00 20 00 00       	mov    $0x2000,%edx
    13eb:	48 c7 c6 60 63 00 00 	mov    $0x6360,%rsi
    13f2:	89 c7                	mov    %eax,%edi
    13f4:	e8 23 2a 00 00       	call   3e1c <read>
    13f9:	83 f8 05             	cmp    $0x5,%eax
    13fc:	74 1b                	je     1419 <unlinkread+0x13d>
    printf(1, "unlinkread read failed");
    13fe:	48 c7 c6 eb 4b 00 00 	mov    $0x4beb,%rsi
    1405:	bf 01 00 00 00       	mov    $0x1,%edi
    140a:	b8 00 00 00 00       	mov    $0x0,%eax
    140f:	e8 82 2b 00 00       	call   3f96 <printf>
    exit();
    1414:	e8 eb 29 00 00       	call   3e04 <exit>
  }
  if(buf[0] != 'h'){
    1419:	0f b6 05 40 4f 00 00 	movzbl 0x4f40(%rip),%eax        # 6360 <buf>
    1420:	3c 68                	cmp    $0x68,%al
    1422:	74 1b                	je     143f <unlinkread+0x163>
    printf(1, "unlinkread wrong data\n");
    1424:	48 c7 c6 02 4c 00 00 	mov    $0x4c02,%rsi
    142b:	bf 01 00 00 00       	mov    $0x1,%edi
    1430:	b8 00 00 00 00       	mov    $0x0,%eax
    1435:	e8 5c 2b 00 00       	call   3f96 <printf>
    exit();
    143a:	e8 c5 29 00 00       	call   3e04 <exit>
  }
  if(write(fd, buf, 10) != 10){
    143f:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1442:	ba 0a 00 00 00       	mov    $0xa,%edx
    1447:	48 c7 c6 60 63 00 00 	mov    $0x6360,%rsi
    144e:	89 c7                	mov    %eax,%edi
    1450:	e8 cf 29 00 00       	call   3e24 <write>
    1455:	83 f8 0a             	cmp    $0xa,%eax
    1458:	74 1b                	je     1475 <unlinkread+0x199>
    printf(1, "unlinkread write failed\n");
    145a:	48 c7 c6 19 4c 00 00 	mov    $0x4c19,%rsi
    1461:	bf 01 00 00 00       	mov    $0x1,%edi
    1466:	b8 00 00 00 00       	mov    $0x0,%eax
    146b:	e8 26 2b 00 00       	call   3f96 <printf>
    exit();
    1470:	e8 8f 29 00 00       	call   3e04 <exit>
  }
  close(fd);
    1475:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1478:	89 c7                	mov    %eax,%edi
    147a:	e8 ad 29 00 00       	call   3e2c <close>
  unlink("unlinkread");
    147f:	48 c7 c7 8a 4b 00 00 	mov    $0x4b8a,%rdi
    1486:	e8 c9 29 00 00       	call   3e54 <unlink>
  printf(1, "unlinkread ok\n");
    148b:	48 c7 c6 32 4c 00 00 	mov    $0x4c32,%rsi
    1492:	bf 01 00 00 00       	mov    $0x1,%edi
    1497:	b8 00 00 00 00       	mov    $0x0,%eax
    149c:	e8 f5 2a 00 00       	call   3f96 <printf>
}
    14a1:	90                   	nop
    14a2:	c9                   	leave
    14a3:	c3                   	ret

00000000000014a4 <linktest>:

void
linktest(void)
{
    14a4:	55                   	push   %rbp
    14a5:	48 89 e5             	mov    %rsp,%rbp
    14a8:	48 83 ec 10          	sub    $0x10,%rsp
  int fd;

  printf(1, "linktest\n");
    14ac:	48 c7 c6 41 4c 00 00 	mov    $0x4c41,%rsi
    14b3:	bf 01 00 00 00       	mov    $0x1,%edi
    14b8:	b8 00 00 00 00       	mov    $0x0,%eax
    14bd:	e8 d4 2a 00 00       	call   3f96 <printf>

  unlink("lf1");
    14c2:	48 c7 c7 4b 4c 00 00 	mov    $0x4c4b,%rdi
    14c9:	e8 86 29 00 00       	call   3e54 <unlink>
  unlink("lf2");
    14ce:	48 c7 c7 4f 4c 00 00 	mov    $0x4c4f,%rdi
    14d5:	e8 7a 29 00 00       	call   3e54 <unlink>

  fd = open("lf1", O_CREATE|O_RDWR);
    14da:	be 02 02 00 00       	mov    $0x202,%esi
    14df:	48 c7 c7 4b 4c 00 00 	mov    $0x4c4b,%rdi
    14e6:	e8 59 29 00 00       	call   3e44 <open>
    14eb:	89 45 fc             	mov    %eax,-0x4(%rbp)
  if(fd < 0){
    14ee:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    14f2:	79 1b                	jns    150f <linktest+0x6b>
    printf(1, "create lf1 failed\n");
    14f4:	48 c7 c6 53 4c 00 00 	mov    $0x4c53,%rsi
    14fb:	bf 01 00 00 00       	mov    $0x1,%edi
    1500:	b8 00 00 00 00       	mov    $0x0,%eax
    1505:	e8 8c 2a 00 00       	call   3f96 <printf>
    exit();
    150a:	e8 f5 28 00 00       	call   3e04 <exit>
  }
  if(write(fd, "hello", 5) != 5){
    150f:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1512:	ba 05 00 00 00       	mov    $0x5,%edx
    1517:	48 c7 c6 af 4b 00 00 	mov    $0x4baf,%rsi
    151e:	89 c7                	mov    %eax,%edi
    1520:	e8 ff 28 00 00       	call   3e24 <write>
    1525:	83 f8 05             	cmp    $0x5,%eax
    1528:	74 1b                	je     1545 <linktest+0xa1>
    printf(1, "write lf1 failed\n");
    152a:	48 c7 c6 66 4c 00 00 	mov    $0x4c66,%rsi
    1531:	bf 01 00 00 00       	mov    $0x1,%edi
    1536:	b8 00 00 00 00       	mov    $0x0,%eax
    153b:	e8 56 2a 00 00       	call   3f96 <printf>
    exit();
    1540:	e8 bf 28 00 00       	call   3e04 <exit>
  }
  close(fd);
    1545:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1548:	89 c7                	mov    %eax,%edi
    154a:	e8 dd 28 00 00       	call   3e2c <close>

  if(link("lf1", "lf2") < 0){
    154f:	48 c7 c6 4f 4c 00 00 	mov    $0x4c4f,%rsi
    1556:	48 c7 c7 4b 4c 00 00 	mov    $0x4c4b,%rdi
    155d:	e8 02 29 00 00       	call   3e64 <link>
    1562:	85 c0                	test   %eax,%eax
    1564:	79 1b                	jns    1581 <linktest+0xdd>
    printf(1, "link lf1 lf2 failed\n");
    1566:	48 c7 c6 78 4c 00 00 	mov    $0x4c78,%rsi
    156d:	bf 01 00 00 00       	mov    $0x1,%edi
    1572:	b8 00 00 00 00       	mov    $0x0,%eax
    1577:	e8 1a 2a 00 00       	call   3f96 <printf>
    exit();
    157c:	e8 83 28 00 00       	call   3e04 <exit>
  }
  unlink("lf1");
    1581:	48 c7 c7 4b 4c 00 00 	mov    $0x4c4b,%rdi
    1588:	e8 c7 28 00 00       	call   3e54 <unlink>

  if(open("lf1", 0) >= 0){
    158d:	be 00 00 00 00       	mov    $0x0,%esi
    1592:	48 c7 c7 4b 4c 00 00 	mov    $0x4c4b,%rdi
    1599:	e8 a6 28 00 00       	call   3e44 <open>
    159e:	85 c0                	test   %eax,%eax
    15a0:	78 1b                	js     15bd <linktest+0x119>
    printf(1, "unlinked lf1 but it is still there!\n");
    15a2:	48 c7 c6 90 4c 00 00 	mov    $0x4c90,%rsi
    15a9:	bf 01 00 00 00       	mov    $0x1,%edi
    15ae:	b8 00 00 00 00       	mov    $0x0,%eax
    15b3:	e8 de 29 00 00       	call   3f96 <printf>
    exit();
    15b8:	e8 47 28 00 00       	call   3e04 <exit>
  }

  fd = open("lf2", 0);
    15bd:	be 00 00 00 00       	mov    $0x0,%esi
    15c2:	48 c7 c7 4f 4c 00 00 	mov    $0x4c4f,%rdi
    15c9:	e8 76 28 00 00       	call   3e44 <open>
    15ce:	89 45 fc             	mov    %eax,-0x4(%rbp)
  if(fd < 0){
    15d1:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    15d5:	79 1b                	jns    15f2 <linktest+0x14e>
    printf(1, "open lf2 failed\n");
    15d7:	48 c7 c6 b5 4c 00 00 	mov    $0x4cb5,%rsi
    15de:	bf 01 00 00 00       	mov    $0x1,%edi
    15e3:	b8 00 00 00 00       	mov    $0x0,%eax
    15e8:	e8 a9 29 00 00       	call   3f96 <printf>
    exit();
    15ed:	e8 12 28 00 00       	call   3e04 <exit>
  }
  if(read(fd, buf, sizeof(buf)) != 5){
    15f2:	8b 45 fc             	mov    -0x4(%rbp),%eax
    15f5:	ba 00 20 00 00       	mov    $0x2000,%edx
    15fa:	48 c7 c6 60 63 00 00 	mov    $0x6360,%rsi
    1601:	89 c7                	mov    %eax,%edi
    1603:	e8 14 28 00 00       	call   3e1c <read>
    1608:	83 f8 05             	cmp    $0x5,%eax
    160b:	74 1b                	je     1628 <linktest+0x184>
    printf(1, "read lf2 failed\n");
    160d:	48 c7 c6 c6 4c 00 00 	mov    $0x4cc6,%rsi
    1614:	bf 01 00 00 00       	mov    $0x1,%edi
    1619:	b8 00 00 00 00       	mov    $0x0,%eax
    161e:	e8 73 29 00 00       	call   3f96 <printf>
    exit();
    1623:	e8 dc 27 00 00       	call   3e04 <exit>
  }
  close(fd);
    1628:	8b 45 fc             	mov    -0x4(%rbp),%eax
    162b:	89 c7                	mov    %eax,%edi
    162d:	e8 fa 27 00 00       	call   3e2c <close>

  if(link("lf2", "lf2") >= 0){
    1632:	48 c7 c6 4f 4c 00 00 	mov    $0x4c4f,%rsi
    1639:	48 c7 c7 4f 4c 00 00 	mov    $0x4c4f,%rdi
    1640:	e8 1f 28 00 00       	call   3e64 <link>
    1645:	85 c0                	test   %eax,%eax
    1647:	78 1b                	js     1664 <linktest+0x1c0>
    printf(1, "link lf2 lf2 succeeded! oops\n");
    1649:	48 c7 c6 d7 4c 00 00 	mov    $0x4cd7,%rsi
    1650:	bf 01 00 00 00       	mov    $0x1,%edi
    1655:	b8 00 00 00 00       	mov    $0x0,%eax
    165a:	e8 37 29 00 00       	call   3f96 <printf>
    exit();
    165f:	e8 a0 27 00 00       	call   3e04 <exit>
  }

  unlink("lf2");
    1664:	48 c7 c7 4f 4c 00 00 	mov    $0x4c4f,%rdi
    166b:	e8 e4 27 00 00       	call   3e54 <unlink>
  if(link("lf2", "lf1") >= 0){
    1670:	48 c7 c6 4b 4c 00 00 	mov    $0x4c4b,%rsi
    1677:	48 c7 c7 4f 4c 00 00 	mov    $0x4c4f,%rdi
    167e:	e8 e1 27 00 00       	call   3e64 <link>
    1683:	85 c0                	test   %eax,%eax
    1685:	78 1b                	js     16a2 <linktest+0x1fe>
    printf(1, "link non-existant succeeded! oops\n");
    1687:	48 c7 c6 f8 4c 00 00 	mov    $0x4cf8,%rsi
    168e:	bf 01 00 00 00       	mov    $0x1,%edi
    1693:	b8 00 00 00 00       	mov    $0x0,%eax
    1698:	e8 f9 28 00 00       	call   3f96 <printf>
    exit();
    169d:	e8 62 27 00 00       	call   3e04 <exit>
  }

  if(link(".", "lf1") >= 0){
    16a2:	48 c7 c6 4b 4c 00 00 	mov    $0x4c4b,%rsi
    16a9:	48 c7 c7 1b 4d 00 00 	mov    $0x4d1b,%rdi
    16b0:	e8 af 27 00 00       	call   3e64 <link>
    16b5:	85 c0                	test   %eax,%eax
    16b7:	78 1b                	js     16d4 <linktest+0x230>
    printf(1, "link . lf1 succeeded! oops\n");
    16b9:	48 c7 c6 1d 4d 00 00 	mov    $0x4d1d,%rsi
    16c0:	bf 01 00 00 00       	mov    $0x1,%edi
    16c5:	b8 00 00 00 00       	mov    $0x0,%eax
    16ca:	e8 c7 28 00 00       	call   3f96 <printf>
    exit();
    16cf:	e8 30 27 00 00       	call   3e04 <exit>
  }

  printf(1, "linktest ok\n");
    16d4:	48 c7 c6 39 4d 00 00 	mov    $0x4d39,%rsi
    16db:	bf 01 00 00 00       	mov    $0x1,%edi
    16e0:	b8 00 00 00 00       	mov    $0x0,%eax
    16e5:	e8 ac 28 00 00       	call   3f96 <printf>
}
    16ea:	90                   	nop
    16eb:	c9                   	leave
    16ec:	c3                   	ret

00000000000016ed <concreate>:

// test concurrent create/link/unlink of the same file
void
concreate(void)
{
    16ed:	55                   	push   %rbp
    16ee:	48 89 e5             	mov    %rsp,%rbp
    16f1:	48 83 ec 50          	sub    $0x50,%rsp
  struct {
    ushort inum;
    char name[14];
  } de;

  printf(1, "concreate test\n");
    16f5:	48 c7 c6 46 4d 00 00 	mov    $0x4d46,%rsi
    16fc:	bf 01 00 00 00       	mov    $0x1,%edi
    1701:	b8 00 00 00 00       	mov    $0x0,%eax
    1706:	e8 8b 28 00 00       	call   3f96 <printf>
  file[0] = 'C';
    170b:	c6 45 ed 43          	movb   $0x43,-0x13(%rbp)
  file[2] = '\0';
    170f:	c6 45 ef 00          	movb   $0x0,-0x11(%rbp)
  for(i = 0; i < 40; i++){
    1713:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    171a:	e9 06 01 00 00       	jmp    1825 <concreate+0x138>
    file[1] = '0' + i;
    171f:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1722:	83 c0 30             	add    $0x30,%eax
    1725:	88 45 ee             	mov    %al,-0x12(%rbp)
    unlink(file);
    1728:	48 8d 45 ed          	lea    -0x13(%rbp),%rax
    172c:	48 89 c7             	mov    %rax,%rdi
    172f:	e8 20 27 00 00       	call   3e54 <unlink>
    pid = fork();
    1734:	e8 c3 26 00 00       	call   3dfc <fork>
    1739:	89 45 f0             	mov    %eax,-0x10(%rbp)
    if(pid && (i % 3) == 1){
    173c:	83 7d f0 00          	cmpl   $0x0,-0x10(%rbp)
    1740:	74 42                	je     1784 <concreate+0x97>
    1742:	8b 4d fc             	mov    -0x4(%rbp),%ecx
    1745:	48 63 c1             	movslq %ecx,%rax
    1748:	48 69 c0 56 55 55 55 	imul   $0x55555556,%rax,%rax
    174f:	48 c1 e8 20          	shr    $0x20,%rax
    1753:	48 89 c2             	mov    %rax,%rdx
    1756:	89 c8                	mov    %ecx,%eax
    1758:	c1 f8 1f             	sar    $0x1f,%eax
    175b:	29 c2                	sub    %eax,%edx
    175d:	89 d0                	mov    %edx,%eax
    175f:	01 c0                	add    %eax,%eax
    1761:	01 d0                	add    %edx,%eax
    1763:	29 c1                	sub    %eax,%ecx
    1765:	89 ca                	mov    %ecx,%edx
    1767:	83 fa 01             	cmp    $0x1,%edx
    176a:	75 18                	jne    1784 <concreate+0x97>
      link("C0", file);
    176c:	48 8d 45 ed          	lea    -0x13(%rbp),%rax
    1770:	48 89 c6             	mov    %rax,%rsi
    1773:	48 c7 c7 56 4d 00 00 	mov    $0x4d56,%rdi
    177a:	e8 e5 26 00 00       	call   3e64 <link>
    177f:	e9 8d 00 00 00       	jmp    1811 <concreate+0x124>
    } else if(pid == 0 && (i % 5) == 1){
    1784:	83 7d f0 00          	cmpl   $0x0,-0x10(%rbp)
    1788:	75 41                	jne    17cb <concreate+0xde>
    178a:	8b 4d fc             	mov    -0x4(%rbp),%ecx
    178d:	48 63 c1             	movslq %ecx,%rax
    1790:	48 69 c0 67 66 66 66 	imul   $0x66666667,%rax,%rax
    1797:	48 c1 e8 20          	shr    $0x20,%rax
    179b:	89 c2                	mov    %eax,%edx
    179d:	d1 fa                	sar    %edx
    179f:	89 c8                	mov    %ecx,%eax
    17a1:	c1 f8 1f             	sar    $0x1f,%eax
    17a4:	29 c2                	sub    %eax,%edx
    17a6:	89 d0                	mov    %edx,%eax
    17a8:	c1 e0 02             	shl    $0x2,%eax
    17ab:	01 d0                	add    %edx,%eax
    17ad:	29 c1                	sub    %eax,%ecx
    17af:	89 ca                	mov    %ecx,%edx
    17b1:	83 fa 01             	cmp    $0x1,%edx
    17b4:	75 15                	jne    17cb <concreate+0xde>
      link("C0", file);
    17b6:	48 8d 45 ed          	lea    -0x13(%rbp),%rax
    17ba:	48 89 c6             	mov    %rax,%rsi
    17bd:	48 c7 c7 56 4d 00 00 	mov    $0x4d56,%rdi
    17c4:	e8 9b 26 00 00       	call   3e64 <link>
    17c9:	eb 46                	jmp    1811 <concreate+0x124>
    } else {
      fd = open(file, O_CREATE | O_RDWR);
    17cb:	48 8d 45 ed          	lea    -0x13(%rbp),%rax
    17cf:	be 02 02 00 00       	mov    $0x202,%esi
    17d4:	48 89 c7             	mov    %rax,%rdi
    17d7:	e8 68 26 00 00       	call   3e44 <open>
    17dc:	89 45 f4             	mov    %eax,-0xc(%rbp)
      if(fd < 0){
    17df:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
    17e3:	79 22                	jns    1807 <concreate+0x11a>
        printf(1, "concreate create %s failed\n", file);
    17e5:	48 8d 45 ed          	lea    -0x13(%rbp),%rax
    17e9:	48 89 c2             	mov    %rax,%rdx
    17ec:	48 c7 c6 59 4d 00 00 	mov    $0x4d59,%rsi
    17f3:	bf 01 00 00 00       	mov    $0x1,%edi
    17f8:	b8 00 00 00 00       	mov    $0x0,%eax
    17fd:	e8 94 27 00 00       	call   3f96 <printf>
        exit();
    1802:	e8 fd 25 00 00       	call   3e04 <exit>
      }
      close(fd);
    1807:	8b 45 f4             	mov    -0xc(%rbp),%eax
    180a:	89 c7                	mov    %eax,%edi
    180c:	e8 1b 26 00 00       	call   3e2c <close>
    }
    if(pid == 0)
    1811:	83 7d f0 00          	cmpl   $0x0,-0x10(%rbp)
    1815:	75 05                	jne    181c <concreate+0x12f>
      exit();
    1817:	e8 e8 25 00 00       	call   3e04 <exit>
    else
      wait();
    181c:	e8 eb 25 00 00       	call   3e0c <wait>
  for(i = 0; i < 40; i++){
    1821:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    1825:	83 7d fc 27          	cmpl   $0x27,-0x4(%rbp)
    1829:	0f 8e f0 fe ff ff    	jle    171f <concreate+0x32>
  }

  memset(fa, 0, sizeof(fa));
    182f:	48 8d 45 c0          	lea    -0x40(%rbp),%rax
    1833:	ba 28 00 00 00       	mov    $0x28,%edx
    1838:	be 00 00 00 00       	mov    $0x0,%esi
    183d:	48 89 c7             	mov    %rax,%rdi
    1840:	e8 ca 23 00 00       	call   3c0f <memset>
  fd = open(".", 0);
    1845:	be 00 00 00 00       	mov    $0x0,%esi
    184a:	48 c7 c7 1b 4d 00 00 	mov    $0x4d1b,%rdi
    1851:	e8 ee 25 00 00       	call   3e44 <open>
    1856:	89 45 f4             	mov    %eax,-0xc(%rbp)
  n = 0;
    1859:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
  while(read(fd, &de, sizeof(de)) > 0){
    1860:	e9 ab 00 00 00       	jmp    1910 <concreate+0x223>
    if(de.inum == 0)
    1865:	0f b7 45 b0          	movzwl -0x50(%rbp),%eax
    1869:	66 85 c0             	test   %ax,%ax
    186c:	0f 84 9d 00 00 00    	je     190f <concreate+0x222>
      continue;
    if(de.name[0] == 'C' && de.name[2] == '\0'){
    1872:	0f b6 45 b2          	movzbl -0x4e(%rbp),%eax
    1876:	3c 43                	cmp    $0x43,%al
    1878:	0f 85 92 00 00 00    	jne    1910 <concreate+0x223>
    187e:	0f b6 45 b4          	movzbl -0x4c(%rbp),%eax
    1882:	84 c0                	test   %al,%al
    1884:	0f 85 86 00 00 00    	jne    1910 <concreate+0x223>
      i = de.name[1] - '0';
    188a:	0f b6 45 b3          	movzbl -0x4d(%rbp),%eax
    188e:	0f be c0             	movsbl %al,%eax
    1891:	83 e8 30             	sub    $0x30,%eax
    1894:	89 45 fc             	mov    %eax,-0x4(%rbp)
      if(i < 0 || i >= sizeof(fa)){
    1897:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    189b:	78 08                	js     18a5 <concreate+0x1b8>
    189d:	8b 45 fc             	mov    -0x4(%rbp),%eax
    18a0:	83 f8 27             	cmp    $0x27,%eax
    18a3:	76 26                	jbe    18cb <concreate+0x1de>
        printf(1, "concreate weird file %s\n", de.name);
    18a5:	48 8d 45 b0          	lea    -0x50(%rbp),%rax
    18a9:	48 83 c0 02          	add    $0x2,%rax
    18ad:	48 89 c2             	mov    %rax,%rdx
    18b0:	48 c7 c6 75 4d 00 00 	mov    $0x4d75,%rsi
    18b7:	bf 01 00 00 00       	mov    $0x1,%edi
    18bc:	b8 00 00 00 00       	mov    $0x0,%eax
    18c1:	e8 d0 26 00 00       	call   3f96 <printf>
        exit();
    18c6:	e8 39 25 00 00       	call   3e04 <exit>
      }
      if(fa[i]){
    18cb:	8b 45 fc             	mov    -0x4(%rbp),%eax
    18ce:	48 98                	cltq
    18d0:	0f b6 44 05 c0       	movzbl -0x40(%rbp,%rax,1),%eax
    18d5:	84 c0                	test   %al,%al
    18d7:	74 26                	je     18ff <concreate+0x212>
        printf(1, "concreate duplicate file %s\n", de.name);
    18d9:	48 8d 45 b0          	lea    -0x50(%rbp),%rax
    18dd:	48 83 c0 02          	add    $0x2,%rax
    18e1:	48 89 c2             	mov    %rax,%rdx
    18e4:	48 c7 c6 8e 4d 00 00 	mov    $0x4d8e,%rsi
    18eb:	bf 01 00 00 00       	mov    $0x1,%edi
    18f0:	b8 00 00 00 00       	mov    $0x0,%eax
    18f5:	e8 9c 26 00 00       	call   3f96 <printf>
        exit();
    18fa:	e8 05 25 00 00       	call   3e04 <exit>
      }
      fa[i] = 1;
    18ff:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1902:	48 98                	cltq
    1904:	c6 44 05 c0 01       	movb   $0x1,-0x40(%rbp,%rax,1)
      n++;
    1909:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
    190d:	eb 01                	jmp    1910 <concreate+0x223>
      continue;
    190f:	90                   	nop
  while(read(fd, &de, sizeof(de)) > 0){
    1910:	48 8d 4d b0          	lea    -0x50(%rbp),%rcx
    1914:	8b 45 f4             	mov    -0xc(%rbp),%eax
    1917:	ba 10 00 00 00       	mov    $0x10,%edx
    191c:	48 89 ce             	mov    %rcx,%rsi
    191f:	89 c7                	mov    %eax,%edi
    1921:	e8 f6 24 00 00       	call   3e1c <read>
    1926:	85 c0                	test   %eax,%eax
    1928:	0f 8f 37 ff ff ff    	jg     1865 <concreate+0x178>
    }
  }
  close(fd);
    192e:	8b 45 f4             	mov    -0xc(%rbp),%eax
    1931:	89 c7                	mov    %eax,%edi
    1933:	e8 f4 24 00 00       	call   3e2c <close>

  if(n != 40){
    1938:	83 7d f8 28          	cmpl   $0x28,-0x8(%rbp)
    193c:	74 1b                	je     1959 <concreate+0x26c>
    printf(1, "concreate not enough files in directory listing\n");
    193e:	48 c7 c6 b0 4d 00 00 	mov    $0x4db0,%rsi
    1945:	bf 01 00 00 00       	mov    $0x1,%edi
    194a:	b8 00 00 00 00       	mov    $0x0,%eax
    194f:	e8 42 26 00 00       	call   3f96 <printf>
    exit();
    1954:	e8 ab 24 00 00       	call   3e04 <exit>
  }

  for(i = 0; i < 40; i++){
    1959:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    1960:	e9 37 01 00 00       	jmp    1a9c <concreate+0x3af>
    file[1] = '0' + i;
    1965:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1968:	83 c0 30             	add    $0x30,%eax
    196b:	88 45 ee             	mov    %al,-0x12(%rbp)
    pid = fork();
    196e:	e8 89 24 00 00       	call   3dfc <fork>
    1973:	89 45 f0             	mov    %eax,-0x10(%rbp)
    if(pid < 0){
    1976:	83 7d f0 00          	cmpl   $0x0,-0x10(%rbp)
    197a:	79 1b                	jns    1997 <concreate+0x2aa>
      printf(1, "fork failed\n");
    197c:	48 c7 c6 91 49 00 00 	mov    $0x4991,%rsi
    1983:	bf 01 00 00 00       	mov    $0x1,%edi
    1988:	b8 00 00 00 00       	mov    $0x0,%eax
    198d:	e8 04 26 00 00       	call   3f96 <printf>
      exit();
    1992:	e8 6d 24 00 00       	call   3e04 <exit>
    }
    if(((i % 3) == 0 && pid == 0) ||
    1997:	8b 4d fc             	mov    -0x4(%rbp),%ecx
    199a:	48 63 c1             	movslq %ecx,%rax
    199d:	48 69 c0 56 55 55 55 	imul   $0x55555556,%rax,%rax
    19a4:	48 c1 e8 20          	shr    $0x20,%rax
    19a8:	48 89 c2             	mov    %rax,%rdx
    19ab:	89 c8                	mov    %ecx,%eax
    19ad:	c1 f8 1f             	sar    $0x1f,%eax
    19b0:	29 c2                	sub    %eax,%edx
    19b2:	89 d0                	mov    %edx,%eax
    19b4:	01 c0                	add    %eax,%eax
    19b6:	01 d0                	add    %edx,%eax
    19b8:	29 c1                	sub    %eax,%ecx
    19ba:	89 ca                	mov    %ecx,%edx
    19bc:	85 d2                	test   %edx,%edx
    19be:	75 06                	jne    19c6 <concreate+0x2d9>
    19c0:	83 7d f0 00          	cmpl   $0x0,-0x10(%rbp)
    19c4:	74 30                	je     19f6 <concreate+0x309>
       ((i % 3) == 1 && pid != 0)){
    19c6:	8b 4d fc             	mov    -0x4(%rbp),%ecx
    19c9:	48 63 c1             	movslq %ecx,%rax
    19cc:	48 69 c0 56 55 55 55 	imul   $0x55555556,%rax,%rax
    19d3:	48 c1 e8 20          	shr    $0x20,%rax
    19d7:	48 89 c2             	mov    %rax,%rdx
    19da:	89 c8                	mov    %ecx,%eax
    19dc:	c1 f8 1f             	sar    $0x1f,%eax
    19df:	29 c2                	sub    %eax,%edx
    19e1:	89 d0                	mov    %edx,%eax
    19e3:	01 c0                	add    %eax,%eax
    19e5:	01 d0                	add    %edx,%eax
    19e7:	29 c1                	sub    %eax,%ecx
    19e9:	89 ca                	mov    %ecx,%edx
    if(((i % 3) == 0 && pid == 0) ||
    19eb:	83 fa 01             	cmp    $0x1,%edx
    19ee:	75 68                	jne    1a58 <concreate+0x36b>
       ((i % 3) == 1 && pid != 0)){
    19f0:	83 7d f0 00          	cmpl   $0x0,-0x10(%rbp)
    19f4:	74 62                	je     1a58 <concreate+0x36b>
      close(open(file, 0));
    19f6:	48 8d 45 ed          	lea    -0x13(%rbp),%rax
    19fa:	be 00 00 00 00       	mov    $0x0,%esi
    19ff:	48 89 c7             	mov    %rax,%rdi
    1a02:	e8 3d 24 00 00       	call   3e44 <open>
    1a07:	89 c7                	mov    %eax,%edi
    1a09:	e8 1e 24 00 00       	call   3e2c <close>
      close(open(file, 0));
    1a0e:	48 8d 45 ed          	lea    -0x13(%rbp),%rax
    1a12:	be 00 00 00 00       	mov    $0x0,%esi
    1a17:	48 89 c7             	mov    %rax,%rdi
    1a1a:	e8 25 24 00 00       	call   3e44 <open>
    1a1f:	89 c7                	mov    %eax,%edi
    1a21:	e8 06 24 00 00       	call   3e2c <close>
      close(open(file, 0));
    1a26:	48 8d 45 ed          	lea    -0x13(%rbp),%rax
    1a2a:	be 00 00 00 00       	mov    $0x0,%esi
    1a2f:	48 89 c7             	mov    %rax,%rdi
    1a32:	e8 0d 24 00 00       	call   3e44 <open>
    1a37:	89 c7                	mov    %eax,%edi
    1a39:	e8 ee 23 00 00       	call   3e2c <close>
      close(open(file, 0));
    1a3e:	48 8d 45 ed          	lea    -0x13(%rbp),%rax
    1a42:	be 00 00 00 00       	mov    $0x0,%esi
    1a47:	48 89 c7             	mov    %rax,%rdi
    1a4a:	e8 f5 23 00 00       	call   3e44 <open>
    1a4f:	89 c7                	mov    %eax,%edi
    1a51:	e8 d6 23 00 00       	call   3e2c <close>
    1a56:	eb 30                	jmp    1a88 <concreate+0x39b>
    } else {
      unlink(file);
    1a58:	48 8d 45 ed          	lea    -0x13(%rbp),%rax
    1a5c:	48 89 c7             	mov    %rax,%rdi
    1a5f:	e8 f0 23 00 00       	call   3e54 <unlink>
      unlink(file);
    1a64:	48 8d 45 ed          	lea    -0x13(%rbp),%rax
    1a68:	48 89 c7             	mov    %rax,%rdi
    1a6b:	e8 e4 23 00 00       	call   3e54 <unlink>
      unlink(file);
    1a70:	48 8d 45 ed          	lea    -0x13(%rbp),%rax
    1a74:	48 89 c7             	mov    %rax,%rdi
    1a77:	e8 d8 23 00 00       	call   3e54 <unlink>
      unlink(file);
    1a7c:	48 8d 45 ed          	lea    -0x13(%rbp),%rax
    1a80:	48 89 c7             	mov    %rax,%rdi
    1a83:	e8 cc 23 00 00       	call   3e54 <unlink>
    }
    if(pid == 0)
    1a88:	83 7d f0 00          	cmpl   $0x0,-0x10(%rbp)
    1a8c:	75 05                	jne    1a93 <concreate+0x3a6>
      exit();
    1a8e:	e8 71 23 00 00       	call   3e04 <exit>
    else
      wait();
    1a93:	e8 74 23 00 00       	call   3e0c <wait>
  for(i = 0; i < 40; i++){
    1a98:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    1a9c:	83 7d fc 27          	cmpl   $0x27,-0x4(%rbp)
    1aa0:	0f 8e bf fe ff ff    	jle    1965 <concreate+0x278>
  }

  printf(1, "concreate ok\n");
    1aa6:	48 c7 c6 e1 4d 00 00 	mov    $0x4de1,%rsi
    1aad:	bf 01 00 00 00       	mov    $0x1,%edi
    1ab2:	b8 00 00 00 00       	mov    $0x0,%eax
    1ab7:	e8 da 24 00 00       	call   3f96 <printf>
}
    1abc:	90                   	nop
    1abd:	c9                   	leave
    1abe:	c3                   	ret

0000000000001abf <linkunlink>:

// another concurrent link/unlink/create test,
// to look for deadlocks.
void
linkunlink()
{
    1abf:	55                   	push   %rbp
    1ac0:	48 89 e5             	mov    %rsp,%rbp
    1ac3:	48 83 ec 10          	sub    $0x10,%rsp
  int pid, i;

  printf(1, "linkunlink test\n");
    1ac7:	48 c7 c6 ef 4d 00 00 	mov    $0x4def,%rsi
    1ace:	bf 01 00 00 00       	mov    $0x1,%edi
    1ad3:	b8 00 00 00 00       	mov    $0x0,%eax
    1ad8:	e8 b9 24 00 00       	call   3f96 <printf>

  unlink("x");
    1add:	48 c7 c7 4a 49 00 00 	mov    $0x494a,%rdi
    1ae4:	e8 6b 23 00 00       	call   3e54 <unlink>
  pid = fork();
    1ae9:	e8 0e 23 00 00       	call   3dfc <fork>
    1aee:	89 45 f4             	mov    %eax,-0xc(%rbp)
  if(pid < 0){
    1af1:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
    1af5:	79 1b                	jns    1b12 <linkunlink+0x53>
    printf(1, "fork failed\n");
    1af7:	48 c7 c6 91 49 00 00 	mov    $0x4991,%rsi
    1afe:	bf 01 00 00 00       	mov    $0x1,%edi
    1b03:	b8 00 00 00 00       	mov    $0x0,%eax
    1b08:	e8 89 24 00 00       	call   3f96 <printf>
    exit();
    1b0d:	e8 f2 22 00 00       	call   3e04 <exit>
  }

  unsigned int x = (pid ? 1 : 97);
    1b12:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
    1b16:	74 07                	je     1b1f <linkunlink+0x60>
    1b18:	b8 01 00 00 00       	mov    $0x1,%eax
    1b1d:	eb 05                	jmp    1b24 <linkunlink+0x65>
    1b1f:	b8 61 00 00 00       	mov    $0x61,%eax
    1b24:	89 45 f8             	mov    %eax,-0x8(%rbp)
  for(i = 0; i < 100; i++){
    1b27:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    1b2e:	e9 99 00 00 00       	jmp    1bcc <linkunlink+0x10d>
    x = x * 1103515245 + 12345;
    1b33:	8b 45 f8             	mov    -0x8(%rbp),%eax
    1b36:	69 c0 6d 4e c6 41    	imul   $0x41c64e6d,%eax,%eax
    1b3c:	05 39 30 00 00       	add    $0x3039,%eax
    1b41:	89 45 f8             	mov    %eax,-0x8(%rbp)
    if((x % 3) == 0){
    1b44:	8b 4d f8             	mov    -0x8(%rbp),%ecx
    1b47:	89 ca                	mov    %ecx,%edx
    1b49:	b8 ab aa aa aa       	mov    $0xaaaaaaab,%eax
    1b4e:	48 0f af c2          	imul   %rdx,%rax
    1b52:	48 c1 e8 20          	shr    $0x20,%rax
    1b56:	89 c2                	mov    %eax,%edx
    1b58:	d1 ea                	shr    %edx
    1b5a:	89 d0                	mov    %edx,%eax
    1b5c:	01 c0                	add    %eax,%eax
    1b5e:	01 d0                	add    %edx,%eax
    1b60:	29 c1                	sub    %eax,%ecx
    1b62:	89 ca                	mov    %ecx,%edx
    1b64:	85 d2                	test   %edx,%edx
    1b66:	75 1a                	jne    1b82 <linkunlink+0xc3>
      close(open("x", O_RDWR | O_CREATE));
    1b68:	be 02 02 00 00       	mov    $0x202,%esi
    1b6d:	48 c7 c7 4a 49 00 00 	mov    $0x494a,%rdi
    1b74:	e8 cb 22 00 00       	call   3e44 <open>
    1b79:	89 c7                	mov    %eax,%edi
    1b7b:	e8 ac 22 00 00       	call   3e2c <close>
    1b80:	eb 46                	jmp    1bc8 <linkunlink+0x109>
    } else if((x % 3) == 1){
    1b82:	8b 4d f8             	mov    -0x8(%rbp),%ecx
    1b85:	89 ca                	mov    %ecx,%edx
    1b87:	b8 ab aa aa aa       	mov    $0xaaaaaaab,%eax
    1b8c:	48 0f af c2          	imul   %rdx,%rax
    1b90:	48 c1 e8 20          	shr    $0x20,%rax
    1b94:	89 c2                	mov    %eax,%edx
    1b96:	d1 ea                	shr    %edx
    1b98:	89 d0                	mov    %edx,%eax
    1b9a:	01 c0                	add    %eax,%eax
    1b9c:	01 d0                	add    %edx,%eax
    1b9e:	29 c1                	sub    %eax,%ecx
    1ba0:	89 ca                	mov    %ecx,%edx
    1ba2:	83 fa 01             	cmp    $0x1,%edx
    1ba5:	75 15                	jne    1bbc <linkunlink+0xfd>
      link("cat", "x");
    1ba7:	48 c7 c6 4a 49 00 00 	mov    $0x494a,%rsi
    1bae:	48 c7 c7 00 4e 00 00 	mov    $0x4e00,%rdi
    1bb5:	e8 aa 22 00 00       	call   3e64 <link>
    1bba:	eb 0c                	jmp    1bc8 <linkunlink+0x109>
    } else {
      unlink("x");
    1bbc:	48 c7 c7 4a 49 00 00 	mov    $0x494a,%rdi
    1bc3:	e8 8c 22 00 00       	call   3e54 <unlink>
  for(i = 0; i < 100; i++){
    1bc8:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    1bcc:	83 7d fc 63          	cmpl   $0x63,-0x4(%rbp)
    1bd0:	0f 8e 5d ff ff ff    	jle    1b33 <linkunlink+0x74>
    }
  }

  if(pid)
    1bd6:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
    1bda:	74 07                	je     1be3 <linkunlink+0x124>
    wait();
    1bdc:	e8 2b 22 00 00       	call   3e0c <wait>
    1be1:	eb 05                	jmp    1be8 <linkunlink+0x129>
  else 
    exit();
    1be3:	e8 1c 22 00 00       	call   3e04 <exit>

  printf(1, "linkunlink ok\n");
    1be8:	48 c7 c6 04 4e 00 00 	mov    $0x4e04,%rsi
    1bef:	bf 01 00 00 00       	mov    $0x1,%edi
    1bf4:	b8 00 00 00 00       	mov    $0x0,%eax
    1bf9:	e8 98 23 00 00       	call   3f96 <printf>
}
    1bfe:	90                   	nop
    1bff:	c9                   	leave
    1c00:	c3                   	ret

0000000000001c01 <bigdir>:

// directory that uses indirect blocks
void
bigdir(void)
{
    1c01:	55                   	push   %rbp
    1c02:	48 89 e5             	mov    %rsp,%rbp
    1c05:	48 83 ec 20          	sub    $0x20,%rsp
  int i, fd;
  char name[10];

  printf(1, "bigdir test\n");
    1c09:	48 c7 c6 13 4e 00 00 	mov    $0x4e13,%rsi
    1c10:	bf 01 00 00 00       	mov    $0x1,%edi
    1c15:	b8 00 00 00 00       	mov    $0x0,%eax
    1c1a:	e8 77 23 00 00       	call   3f96 <printf>
  unlink("bd");
    1c1f:	48 c7 c7 20 4e 00 00 	mov    $0x4e20,%rdi
    1c26:	e8 29 22 00 00       	call   3e54 <unlink>

  fd = open("bd", O_CREATE);
    1c2b:	be 00 02 00 00       	mov    $0x200,%esi
    1c30:	48 c7 c7 20 4e 00 00 	mov    $0x4e20,%rdi
    1c37:	e8 08 22 00 00       	call   3e44 <open>
    1c3c:	89 45 f8             	mov    %eax,-0x8(%rbp)
  if(fd < 0){
    1c3f:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
    1c43:	79 1b                	jns    1c60 <bigdir+0x5f>
    printf(1, "bigdir create failed\n");
    1c45:	48 c7 c6 23 4e 00 00 	mov    $0x4e23,%rsi
    1c4c:	bf 01 00 00 00       	mov    $0x1,%edi
    1c51:	b8 00 00 00 00       	mov    $0x0,%eax
    1c56:	e8 3b 23 00 00       	call   3f96 <printf>
    exit();
    1c5b:	e8 a4 21 00 00       	call   3e04 <exit>
  }
  close(fd);
    1c60:	8b 45 f8             	mov    -0x8(%rbp),%eax
    1c63:	89 c7                	mov    %eax,%edi
    1c65:	e8 c2 21 00 00       	call   3e2c <close>

  for(i = 0; i < 500; i++){
    1c6a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    1c71:	eb 6c                	jmp    1cdf <bigdir+0xde>
    name[0] = 'x';
    1c73:	c6 45 ee 78          	movb   $0x78,-0x12(%rbp)
    name[1] = '0' + (i / 64);
    1c77:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1c7a:	8d 50 3f             	lea    0x3f(%rax),%edx
    1c7d:	85 c0                	test   %eax,%eax
    1c7f:	0f 48 c2             	cmovs  %edx,%eax
    1c82:	c1 f8 06             	sar    $0x6,%eax
    1c85:	83 c0 30             	add    $0x30,%eax
    1c88:	88 45 ef             	mov    %al,-0x11(%rbp)
    name[2] = '0' + (i % 64);
    1c8b:	8b 55 fc             	mov    -0x4(%rbp),%edx
    1c8e:	89 d0                	mov    %edx,%eax
    1c90:	c1 f8 1f             	sar    $0x1f,%eax
    1c93:	c1 e8 1a             	shr    $0x1a,%eax
    1c96:	01 c2                	add    %eax,%edx
    1c98:	83 e2 3f             	and    $0x3f,%edx
    1c9b:	29 c2                	sub    %eax,%edx
    1c9d:	89 d0                	mov    %edx,%eax
    1c9f:	83 c0 30             	add    $0x30,%eax
    1ca2:	88 45 f0             	mov    %al,-0x10(%rbp)
    name[3] = '\0';
    1ca5:	c6 45 f1 00          	movb   $0x0,-0xf(%rbp)
    if(link("bd", name) != 0){
    1ca9:	48 8d 45 ee          	lea    -0x12(%rbp),%rax
    1cad:	48 89 c6             	mov    %rax,%rsi
    1cb0:	48 c7 c7 20 4e 00 00 	mov    $0x4e20,%rdi
    1cb7:	e8 a8 21 00 00       	call   3e64 <link>
    1cbc:	85 c0                	test   %eax,%eax
    1cbe:	74 1b                	je     1cdb <bigdir+0xda>
      printf(1, "bigdir link failed\n");
    1cc0:	48 c7 c6 39 4e 00 00 	mov    $0x4e39,%rsi
    1cc7:	bf 01 00 00 00       	mov    $0x1,%edi
    1ccc:	b8 00 00 00 00       	mov    $0x0,%eax
    1cd1:	e8 c0 22 00 00       	call   3f96 <printf>
      exit();
    1cd6:	e8 29 21 00 00       	call   3e04 <exit>
  for(i = 0; i < 500; i++){
    1cdb:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    1cdf:	81 7d fc f3 01 00 00 	cmpl   $0x1f3,-0x4(%rbp)
    1ce6:	7e 8b                	jle    1c73 <bigdir+0x72>
    }
  }

  unlink("bd");
    1ce8:	48 c7 c7 20 4e 00 00 	mov    $0x4e20,%rdi
    1cef:	e8 60 21 00 00       	call   3e54 <unlink>
  for(i = 0; i < 500; i++){
    1cf4:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    1cfb:	eb 65                	jmp    1d62 <bigdir+0x161>
    name[0] = 'x';
    1cfd:	c6 45 ee 78          	movb   $0x78,-0x12(%rbp)
    name[1] = '0' + (i / 64);
    1d01:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1d04:	8d 50 3f             	lea    0x3f(%rax),%edx
    1d07:	85 c0                	test   %eax,%eax
    1d09:	0f 48 c2             	cmovs  %edx,%eax
    1d0c:	c1 f8 06             	sar    $0x6,%eax
    1d0f:	83 c0 30             	add    $0x30,%eax
    1d12:	88 45 ef             	mov    %al,-0x11(%rbp)
    name[2] = '0' + (i % 64);
    1d15:	8b 55 fc             	mov    -0x4(%rbp),%edx
    1d18:	89 d0                	mov    %edx,%eax
    1d1a:	c1 f8 1f             	sar    $0x1f,%eax
    1d1d:	c1 e8 1a             	shr    $0x1a,%eax
    1d20:	01 c2                	add    %eax,%edx
    1d22:	83 e2 3f             	and    $0x3f,%edx
    1d25:	29 c2                	sub    %eax,%edx
    1d27:	89 d0                	mov    %edx,%eax
    1d29:	83 c0 30             	add    $0x30,%eax
    1d2c:	88 45 f0             	mov    %al,-0x10(%rbp)
    name[3] = '\0';
    1d2f:	c6 45 f1 00          	movb   $0x0,-0xf(%rbp)
    if(unlink(name) != 0){
    1d33:	48 8d 45 ee          	lea    -0x12(%rbp),%rax
    1d37:	48 89 c7             	mov    %rax,%rdi
    1d3a:	e8 15 21 00 00       	call   3e54 <unlink>
    1d3f:	85 c0                	test   %eax,%eax
    1d41:	74 1b                	je     1d5e <bigdir+0x15d>
      printf(1, "bigdir unlink failed");
    1d43:	48 c7 c6 4d 4e 00 00 	mov    $0x4e4d,%rsi
    1d4a:	bf 01 00 00 00       	mov    $0x1,%edi
    1d4f:	b8 00 00 00 00       	mov    $0x0,%eax
    1d54:	e8 3d 22 00 00       	call   3f96 <printf>
      exit();
    1d59:	e8 a6 20 00 00       	call   3e04 <exit>
  for(i = 0; i < 500; i++){
    1d5e:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    1d62:	81 7d fc f3 01 00 00 	cmpl   $0x1f3,-0x4(%rbp)
    1d69:	7e 92                	jle    1cfd <bigdir+0xfc>
    }
  }

  printf(1, "bigdir ok\n");
    1d6b:	48 c7 c6 62 4e 00 00 	mov    $0x4e62,%rsi
    1d72:	bf 01 00 00 00       	mov    $0x1,%edi
    1d77:	b8 00 00 00 00       	mov    $0x0,%eax
    1d7c:	e8 15 22 00 00       	call   3f96 <printf>
}
    1d81:	90                   	nop
    1d82:	c9                   	leave
    1d83:	c3                   	ret

0000000000001d84 <subdir>:

void
subdir(void)
{
    1d84:	55                   	push   %rbp
    1d85:	48 89 e5             	mov    %rsp,%rbp
    1d88:	48 83 ec 10          	sub    $0x10,%rsp
  int fd, cc;

  printf(1, "subdir test\n");
    1d8c:	48 c7 c6 6d 4e 00 00 	mov    $0x4e6d,%rsi
    1d93:	bf 01 00 00 00       	mov    $0x1,%edi
    1d98:	b8 00 00 00 00       	mov    $0x0,%eax
    1d9d:	e8 f4 21 00 00       	call   3f96 <printf>

  unlink("ff");
    1da2:	48 c7 c7 7a 4e 00 00 	mov    $0x4e7a,%rdi
    1da9:	e8 a6 20 00 00       	call   3e54 <unlink>
  if(mkdir("dd") != 0){
    1dae:	48 c7 c7 7d 4e 00 00 	mov    $0x4e7d,%rdi
    1db5:	e8 b2 20 00 00       	call   3e6c <mkdir>
    1dba:	85 c0                	test   %eax,%eax
    1dbc:	74 1b                	je     1dd9 <subdir+0x55>
    printf(1, "subdir mkdir dd failed\n");
    1dbe:	48 c7 c6 80 4e 00 00 	mov    $0x4e80,%rsi
    1dc5:	bf 01 00 00 00       	mov    $0x1,%edi
    1dca:	b8 00 00 00 00       	mov    $0x0,%eax
    1dcf:	e8 c2 21 00 00       	call   3f96 <printf>
    exit();
    1dd4:	e8 2b 20 00 00       	call   3e04 <exit>
  }

  fd = open("dd/ff", O_CREATE | O_RDWR);
    1dd9:	be 02 02 00 00       	mov    $0x202,%esi
    1dde:	48 c7 c7 98 4e 00 00 	mov    $0x4e98,%rdi
    1de5:	e8 5a 20 00 00       	call   3e44 <open>
    1dea:	89 45 fc             	mov    %eax,-0x4(%rbp)
  if(fd < 0){
    1ded:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    1df1:	79 1b                	jns    1e0e <subdir+0x8a>
    printf(1, "create dd/ff failed\n");
    1df3:	48 c7 c6 9e 4e 00 00 	mov    $0x4e9e,%rsi
    1dfa:	bf 01 00 00 00       	mov    $0x1,%edi
    1dff:	b8 00 00 00 00       	mov    $0x0,%eax
    1e04:	e8 8d 21 00 00       	call   3f96 <printf>
    exit();
    1e09:	e8 f6 1f 00 00       	call   3e04 <exit>
  }
  write(fd, "ff", 2);
    1e0e:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1e11:	ba 02 00 00 00       	mov    $0x2,%edx
    1e16:	48 c7 c6 7a 4e 00 00 	mov    $0x4e7a,%rsi
    1e1d:	89 c7                	mov    %eax,%edi
    1e1f:	e8 00 20 00 00       	call   3e24 <write>
  close(fd);
    1e24:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1e27:	89 c7                	mov    %eax,%edi
    1e29:	e8 fe 1f 00 00       	call   3e2c <close>
  
  if(unlink("dd") >= 0){
    1e2e:	48 c7 c7 7d 4e 00 00 	mov    $0x4e7d,%rdi
    1e35:	e8 1a 20 00 00       	call   3e54 <unlink>
    1e3a:	85 c0                	test   %eax,%eax
    1e3c:	78 1b                	js     1e59 <subdir+0xd5>
    printf(1, "unlink dd (non-empty dir) succeeded!\n");
    1e3e:	48 c7 c6 b8 4e 00 00 	mov    $0x4eb8,%rsi
    1e45:	bf 01 00 00 00       	mov    $0x1,%edi
    1e4a:	b8 00 00 00 00       	mov    $0x0,%eax
    1e4f:	e8 42 21 00 00       	call   3f96 <printf>
    exit();
    1e54:	e8 ab 1f 00 00       	call   3e04 <exit>
  }

  if(mkdir("/dd/dd") != 0){
    1e59:	48 c7 c7 de 4e 00 00 	mov    $0x4ede,%rdi
    1e60:	e8 07 20 00 00       	call   3e6c <mkdir>
    1e65:	85 c0                	test   %eax,%eax
    1e67:	74 1b                	je     1e84 <subdir+0x100>
    printf(1, "subdir mkdir dd/dd failed\n");
    1e69:	48 c7 c6 e5 4e 00 00 	mov    $0x4ee5,%rsi
    1e70:	bf 01 00 00 00       	mov    $0x1,%edi
    1e75:	b8 00 00 00 00       	mov    $0x0,%eax
    1e7a:	e8 17 21 00 00       	call   3f96 <printf>
    exit();
    1e7f:	e8 80 1f 00 00       	call   3e04 <exit>
  }

  fd = open("dd/dd/ff", O_CREATE | O_RDWR);
    1e84:	be 02 02 00 00       	mov    $0x202,%esi
    1e89:	48 c7 c7 00 4f 00 00 	mov    $0x4f00,%rdi
    1e90:	e8 af 1f 00 00       	call   3e44 <open>
    1e95:	89 45 fc             	mov    %eax,-0x4(%rbp)
  if(fd < 0){
    1e98:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    1e9c:	79 1b                	jns    1eb9 <subdir+0x135>
    printf(1, "create dd/dd/ff failed\n");
    1e9e:	48 c7 c6 09 4f 00 00 	mov    $0x4f09,%rsi
    1ea5:	bf 01 00 00 00       	mov    $0x1,%edi
    1eaa:	b8 00 00 00 00       	mov    $0x0,%eax
    1eaf:	e8 e2 20 00 00       	call   3f96 <printf>
    exit();
    1eb4:	e8 4b 1f 00 00       	call   3e04 <exit>
  }
  write(fd, "FF", 2);
    1eb9:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1ebc:	ba 02 00 00 00       	mov    $0x2,%edx
    1ec1:	48 c7 c6 21 4f 00 00 	mov    $0x4f21,%rsi
    1ec8:	89 c7                	mov    %eax,%edi
    1eca:	e8 55 1f 00 00       	call   3e24 <write>
  close(fd);
    1ecf:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1ed2:	89 c7                	mov    %eax,%edi
    1ed4:	e8 53 1f 00 00       	call   3e2c <close>

  fd = open("dd/dd/../ff", 0);
    1ed9:	be 00 00 00 00       	mov    $0x0,%esi
    1ede:	48 c7 c7 24 4f 00 00 	mov    $0x4f24,%rdi
    1ee5:	e8 5a 1f 00 00       	call   3e44 <open>
    1eea:	89 45 fc             	mov    %eax,-0x4(%rbp)
  if(fd < 0){
    1eed:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    1ef1:	79 1b                	jns    1f0e <subdir+0x18a>
    printf(1, "open dd/dd/../ff failed\n");
    1ef3:	48 c7 c6 30 4f 00 00 	mov    $0x4f30,%rsi
    1efa:	bf 01 00 00 00       	mov    $0x1,%edi
    1eff:	b8 00 00 00 00       	mov    $0x0,%eax
    1f04:	e8 8d 20 00 00       	call   3f96 <printf>
    exit();
    1f09:	e8 f6 1e 00 00       	call   3e04 <exit>
  }
  cc = read(fd, buf, sizeof(buf));
    1f0e:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1f11:	ba 00 20 00 00       	mov    $0x2000,%edx
    1f16:	48 c7 c6 60 63 00 00 	mov    $0x6360,%rsi
    1f1d:	89 c7                	mov    %eax,%edi
    1f1f:	e8 f8 1e 00 00       	call   3e1c <read>
    1f24:	89 45 f8             	mov    %eax,-0x8(%rbp)
  if(cc != 2 || buf[0] != 'f'){
    1f27:	83 7d f8 02          	cmpl   $0x2,-0x8(%rbp)
    1f2b:	75 0b                	jne    1f38 <subdir+0x1b4>
    1f2d:	0f b6 05 2c 44 00 00 	movzbl 0x442c(%rip),%eax        # 6360 <buf>
    1f34:	3c 66                	cmp    $0x66,%al
    1f36:	74 1b                	je     1f53 <subdir+0x1cf>
    printf(1, "dd/dd/../ff wrong content\n");
    1f38:	48 c7 c6 49 4f 00 00 	mov    $0x4f49,%rsi
    1f3f:	bf 01 00 00 00       	mov    $0x1,%edi
    1f44:	b8 00 00 00 00       	mov    $0x0,%eax
    1f49:	e8 48 20 00 00       	call   3f96 <printf>
    exit();
    1f4e:	e8 b1 1e 00 00       	call   3e04 <exit>
  }
  close(fd);
    1f53:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1f56:	89 c7                	mov    %eax,%edi
    1f58:	e8 cf 1e 00 00       	call   3e2c <close>

  if(link("dd/dd/ff", "dd/dd/ffff") != 0){
    1f5d:	48 c7 c6 64 4f 00 00 	mov    $0x4f64,%rsi
    1f64:	48 c7 c7 00 4f 00 00 	mov    $0x4f00,%rdi
    1f6b:	e8 f4 1e 00 00       	call   3e64 <link>
    1f70:	85 c0                	test   %eax,%eax
    1f72:	74 1b                	je     1f8f <subdir+0x20b>
    printf(1, "link dd/dd/ff dd/dd/ffff failed\n");
    1f74:	48 c7 c6 70 4f 00 00 	mov    $0x4f70,%rsi
    1f7b:	bf 01 00 00 00       	mov    $0x1,%edi
    1f80:	b8 00 00 00 00       	mov    $0x0,%eax
    1f85:	e8 0c 20 00 00       	call   3f96 <printf>
    exit();
    1f8a:	e8 75 1e 00 00       	call   3e04 <exit>
  }

  if(unlink("dd/dd/ff") != 0){
    1f8f:	48 c7 c7 00 4f 00 00 	mov    $0x4f00,%rdi
    1f96:	e8 b9 1e 00 00       	call   3e54 <unlink>
    1f9b:	85 c0                	test   %eax,%eax
    1f9d:	74 1b                	je     1fba <subdir+0x236>
    printf(1, "unlink dd/dd/ff failed\n");
    1f9f:	48 c7 c6 91 4f 00 00 	mov    $0x4f91,%rsi
    1fa6:	bf 01 00 00 00       	mov    $0x1,%edi
    1fab:	b8 00 00 00 00       	mov    $0x0,%eax
    1fb0:	e8 e1 1f 00 00       	call   3f96 <printf>
    exit();
    1fb5:	e8 4a 1e 00 00       	call   3e04 <exit>
  }
  if(open("dd/dd/ff", O_RDONLY) >= 0){
    1fba:	be 00 00 00 00       	mov    $0x0,%esi
    1fbf:	48 c7 c7 00 4f 00 00 	mov    $0x4f00,%rdi
    1fc6:	e8 79 1e 00 00       	call   3e44 <open>
    1fcb:	85 c0                	test   %eax,%eax
    1fcd:	78 1b                	js     1fea <subdir+0x266>
    printf(1, "open (unlinked) dd/dd/ff succeeded\n");
    1fcf:	48 c7 c6 b0 4f 00 00 	mov    $0x4fb0,%rsi
    1fd6:	bf 01 00 00 00       	mov    $0x1,%edi
    1fdb:	b8 00 00 00 00       	mov    $0x0,%eax
    1fe0:	e8 b1 1f 00 00       	call   3f96 <printf>
    exit();
    1fe5:	e8 1a 1e 00 00       	call   3e04 <exit>
  }

  if(chdir("dd") != 0){
    1fea:	48 c7 c7 7d 4e 00 00 	mov    $0x4e7d,%rdi
    1ff1:	e8 7e 1e 00 00       	call   3e74 <chdir>
    1ff6:	85 c0                	test   %eax,%eax
    1ff8:	74 1b                	je     2015 <subdir+0x291>
    printf(1, "chdir dd failed\n");
    1ffa:	48 c7 c6 d4 4f 00 00 	mov    $0x4fd4,%rsi
    2001:	bf 01 00 00 00       	mov    $0x1,%edi
    2006:	b8 00 00 00 00       	mov    $0x0,%eax
    200b:	e8 86 1f 00 00       	call   3f96 <printf>
    exit();
    2010:	e8 ef 1d 00 00       	call   3e04 <exit>
  }
  if(chdir("dd/../../dd") != 0){
    2015:	48 c7 c7 e5 4f 00 00 	mov    $0x4fe5,%rdi
    201c:	e8 53 1e 00 00       	call   3e74 <chdir>
    2021:	85 c0                	test   %eax,%eax
    2023:	74 1b                	je     2040 <subdir+0x2bc>
    printf(1, "chdir dd/../../dd failed\n");
    2025:	48 c7 c6 f1 4f 00 00 	mov    $0x4ff1,%rsi
    202c:	bf 01 00 00 00       	mov    $0x1,%edi
    2031:	b8 00 00 00 00       	mov    $0x0,%eax
    2036:	e8 5b 1f 00 00       	call   3f96 <printf>
    exit();
    203b:	e8 c4 1d 00 00       	call   3e04 <exit>
  }
  if(chdir("dd/../../../dd") != 0){
    2040:	48 c7 c7 0b 50 00 00 	mov    $0x500b,%rdi
    2047:	e8 28 1e 00 00       	call   3e74 <chdir>
    204c:	85 c0                	test   %eax,%eax
    204e:	74 1b                	je     206b <subdir+0x2e7>
    printf(1, "chdir dd/../../dd failed\n");
    2050:	48 c7 c6 f1 4f 00 00 	mov    $0x4ff1,%rsi
    2057:	bf 01 00 00 00       	mov    $0x1,%edi
    205c:	b8 00 00 00 00       	mov    $0x0,%eax
    2061:	e8 30 1f 00 00       	call   3f96 <printf>
    exit();
    2066:	e8 99 1d 00 00       	call   3e04 <exit>
  }
  if(chdir("./..") != 0){
    206b:	48 c7 c7 1a 50 00 00 	mov    $0x501a,%rdi
    2072:	e8 fd 1d 00 00       	call   3e74 <chdir>
    2077:	85 c0                	test   %eax,%eax
    2079:	74 1b                	je     2096 <subdir+0x312>
    printf(1, "chdir ./.. failed\n");
    207b:	48 c7 c6 1f 50 00 00 	mov    $0x501f,%rsi
    2082:	bf 01 00 00 00       	mov    $0x1,%edi
    2087:	b8 00 00 00 00       	mov    $0x0,%eax
    208c:	e8 05 1f 00 00       	call   3f96 <printf>
    exit();
    2091:	e8 6e 1d 00 00       	call   3e04 <exit>
  }

  fd = open("dd/dd/ffff", 0);
    2096:	be 00 00 00 00       	mov    $0x0,%esi
    209b:	48 c7 c7 64 4f 00 00 	mov    $0x4f64,%rdi
    20a2:	e8 9d 1d 00 00       	call   3e44 <open>
    20a7:	89 45 fc             	mov    %eax,-0x4(%rbp)
  if(fd < 0){
    20aa:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    20ae:	79 1b                	jns    20cb <subdir+0x347>
    printf(1, "open dd/dd/ffff failed\n");
    20b0:	48 c7 c6 32 50 00 00 	mov    $0x5032,%rsi
    20b7:	bf 01 00 00 00       	mov    $0x1,%edi
    20bc:	b8 00 00 00 00       	mov    $0x0,%eax
    20c1:	e8 d0 1e 00 00       	call   3f96 <printf>
    exit();
    20c6:	e8 39 1d 00 00       	call   3e04 <exit>
  }
  if(read(fd, buf, sizeof(buf)) != 2){
    20cb:	8b 45 fc             	mov    -0x4(%rbp),%eax
    20ce:	ba 00 20 00 00       	mov    $0x2000,%edx
    20d3:	48 c7 c6 60 63 00 00 	mov    $0x6360,%rsi
    20da:	89 c7                	mov    %eax,%edi
    20dc:	e8 3b 1d 00 00       	call   3e1c <read>
    20e1:	83 f8 02             	cmp    $0x2,%eax
    20e4:	74 1b                	je     2101 <subdir+0x37d>
    printf(1, "read dd/dd/ffff wrong len\n");
    20e6:	48 c7 c6 4a 50 00 00 	mov    $0x504a,%rsi
    20ed:	bf 01 00 00 00       	mov    $0x1,%edi
    20f2:	b8 00 00 00 00       	mov    $0x0,%eax
    20f7:	e8 9a 1e 00 00       	call   3f96 <printf>
    exit();
    20fc:	e8 03 1d 00 00       	call   3e04 <exit>
  }
  close(fd);
    2101:	8b 45 fc             	mov    -0x4(%rbp),%eax
    2104:	89 c7                	mov    %eax,%edi
    2106:	e8 21 1d 00 00       	call   3e2c <close>

  if(open("dd/dd/ff", O_RDONLY) >= 0){
    210b:	be 00 00 00 00       	mov    $0x0,%esi
    2110:	48 c7 c7 00 4f 00 00 	mov    $0x4f00,%rdi
    2117:	e8 28 1d 00 00       	call   3e44 <open>
    211c:	85 c0                	test   %eax,%eax
    211e:	78 1b                	js     213b <subdir+0x3b7>
    printf(1, "open (unlinked) dd/dd/ff succeeded!\n");
    2120:	48 c7 c6 68 50 00 00 	mov    $0x5068,%rsi
    2127:	bf 01 00 00 00       	mov    $0x1,%edi
    212c:	b8 00 00 00 00       	mov    $0x0,%eax
    2131:	e8 60 1e 00 00       	call   3f96 <printf>
    exit();
    2136:	e8 c9 1c 00 00       	call   3e04 <exit>
  }

  if(open("dd/ff/ff", O_CREATE|O_RDWR) >= 0){
    213b:	be 02 02 00 00       	mov    $0x202,%esi
    2140:	48 c7 c7 8d 50 00 00 	mov    $0x508d,%rdi
    2147:	e8 f8 1c 00 00       	call   3e44 <open>
    214c:	85 c0                	test   %eax,%eax
    214e:	78 1b                	js     216b <subdir+0x3e7>
    printf(1, "create dd/ff/ff succeeded!\n");
    2150:	48 c7 c6 96 50 00 00 	mov    $0x5096,%rsi
    2157:	bf 01 00 00 00       	mov    $0x1,%edi
    215c:	b8 00 00 00 00       	mov    $0x0,%eax
    2161:	e8 30 1e 00 00       	call   3f96 <printf>
    exit();
    2166:	e8 99 1c 00 00       	call   3e04 <exit>
  }
  if(open("dd/xx/ff", O_CREATE|O_RDWR) >= 0){
    216b:	be 02 02 00 00       	mov    $0x202,%esi
    2170:	48 c7 c7 b2 50 00 00 	mov    $0x50b2,%rdi
    2177:	e8 c8 1c 00 00       	call   3e44 <open>
    217c:	85 c0                	test   %eax,%eax
    217e:	78 1b                	js     219b <subdir+0x417>
    printf(1, "create dd/xx/ff succeeded!\n");
    2180:	48 c7 c6 bb 50 00 00 	mov    $0x50bb,%rsi
    2187:	bf 01 00 00 00       	mov    $0x1,%edi
    218c:	b8 00 00 00 00       	mov    $0x0,%eax
    2191:	e8 00 1e 00 00       	call   3f96 <printf>
    exit();
    2196:	e8 69 1c 00 00       	call   3e04 <exit>
  }
  if(open("dd", O_CREATE) >= 0){
    219b:	be 00 02 00 00       	mov    $0x200,%esi
    21a0:	48 c7 c7 7d 4e 00 00 	mov    $0x4e7d,%rdi
    21a7:	e8 98 1c 00 00       	call   3e44 <open>
    21ac:	85 c0                	test   %eax,%eax
    21ae:	78 1b                	js     21cb <subdir+0x447>
    printf(1, "create dd succeeded!\n");
    21b0:	48 c7 c6 d7 50 00 00 	mov    $0x50d7,%rsi
    21b7:	bf 01 00 00 00       	mov    $0x1,%edi
    21bc:	b8 00 00 00 00       	mov    $0x0,%eax
    21c1:	e8 d0 1d 00 00       	call   3f96 <printf>
    exit();
    21c6:	e8 39 1c 00 00       	call   3e04 <exit>
  }
  if(open("dd", O_RDWR) >= 0){
    21cb:	be 02 00 00 00       	mov    $0x2,%esi
    21d0:	48 c7 c7 7d 4e 00 00 	mov    $0x4e7d,%rdi
    21d7:	e8 68 1c 00 00       	call   3e44 <open>
    21dc:	85 c0                	test   %eax,%eax
    21de:	78 1b                	js     21fb <subdir+0x477>
    printf(1, "open dd rdwr succeeded!\n");
    21e0:	48 c7 c6 ed 50 00 00 	mov    $0x50ed,%rsi
    21e7:	bf 01 00 00 00       	mov    $0x1,%edi
    21ec:	b8 00 00 00 00       	mov    $0x0,%eax
    21f1:	e8 a0 1d 00 00       	call   3f96 <printf>
    exit();
    21f6:	e8 09 1c 00 00       	call   3e04 <exit>
  }
  if(open("dd", O_WRONLY) >= 0){
    21fb:	be 01 00 00 00       	mov    $0x1,%esi
    2200:	48 c7 c7 7d 4e 00 00 	mov    $0x4e7d,%rdi
    2207:	e8 38 1c 00 00       	call   3e44 <open>
    220c:	85 c0                	test   %eax,%eax
    220e:	78 1b                	js     222b <subdir+0x4a7>
    printf(1, "open dd wronly succeeded!\n");
    2210:	48 c7 c6 06 51 00 00 	mov    $0x5106,%rsi
    2217:	bf 01 00 00 00       	mov    $0x1,%edi
    221c:	b8 00 00 00 00       	mov    $0x0,%eax
    2221:	e8 70 1d 00 00       	call   3f96 <printf>
    exit();
    2226:	e8 d9 1b 00 00       	call   3e04 <exit>
  }
  if(link("dd/ff/ff", "dd/dd/xx") == 0){
    222b:	48 c7 c6 21 51 00 00 	mov    $0x5121,%rsi
    2232:	48 c7 c7 8d 50 00 00 	mov    $0x508d,%rdi
    2239:	e8 26 1c 00 00       	call   3e64 <link>
    223e:	85 c0                	test   %eax,%eax
    2240:	75 1b                	jne    225d <subdir+0x4d9>
    printf(1, "link dd/ff/ff dd/dd/xx succeeded!\n");
    2242:	48 c7 c6 30 51 00 00 	mov    $0x5130,%rsi
    2249:	bf 01 00 00 00       	mov    $0x1,%edi
    224e:	b8 00 00 00 00       	mov    $0x0,%eax
    2253:	e8 3e 1d 00 00       	call   3f96 <printf>
    exit();
    2258:	e8 a7 1b 00 00       	call   3e04 <exit>
  }
  if(link("dd/xx/ff", "dd/dd/xx") == 0){
    225d:	48 c7 c6 21 51 00 00 	mov    $0x5121,%rsi
    2264:	48 c7 c7 b2 50 00 00 	mov    $0x50b2,%rdi
    226b:	e8 f4 1b 00 00       	call   3e64 <link>
    2270:	85 c0                	test   %eax,%eax
    2272:	75 1b                	jne    228f <subdir+0x50b>
    printf(1, "link dd/xx/ff dd/dd/xx succeeded!\n");
    2274:	48 c7 c6 58 51 00 00 	mov    $0x5158,%rsi
    227b:	bf 01 00 00 00       	mov    $0x1,%edi
    2280:	b8 00 00 00 00       	mov    $0x0,%eax
    2285:	e8 0c 1d 00 00       	call   3f96 <printf>
    exit();
    228a:	e8 75 1b 00 00       	call   3e04 <exit>
  }
  if(link("dd/ff", "dd/dd/ffff") == 0){
    228f:	48 c7 c6 64 4f 00 00 	mov    $0x4f64,%rsi
    2296:	48 c7 c7 98 4e 00 00 	mov    $0x4e98,%rdi
    229d:	e8 c2 1b 00 00       	call   3e64 <link>
    22a2:	85 c0                	test   %eax,%eax
    22a4:	75 1b                	jne    22c1 <subdir+0x53d>
    printf(1, "link dd/ff dd/dd/ffff succeeded!\n");
    22a6:	48 c7 c6 80 51 00 00 	mov    $0x5180,%rsi
    22ad:	bf 01 00 00 00       	mov    $0x1,%edi
    22b2:	b8 00 00 00 00       	mov    $0x0,%eax
    22b7:	e8 da 1c 00 00       	call   3f96 <printf>
    exit();
    22bc:	e8 43 1b 00 00       	call   3e04 <exit>
  }
  if(mkdir("dd/ff/ff") == 0){
    22c1:	48 c7 c7 8d 50 00 00 	mov    $0x508d,%rdi
    22c8:	e8 9f 1b 00 00       	call   3e6c <mkdir>
    22cd:	85 c0                	test   %eax,%eax
    22cf:	75 1b                	jne    22ec <subdir+0x568>
    printf(1, "mkdir dd/ff/ff succeeded!\n");
    22d1:	48 c7 c6 a2 51 00 00 	mov    $0x51a2,%rsi
    22d8:	bf 01 00 00 00       	mov    $0x1,%edi
    22dd:	b8 00 00 00 00       	mov    $0x0,%eax
    22e2:	e8 af 1c 00 00       	call   3f96 <printf>
    exit();
    22e7:	e8 18 1b 00 00       	call   3e04 <exit>
  }
  if(mkdir("dd/xx/ff") == 0){
    22ec:	48 c7 c7 b2 50 00 00 	mov    $0x50b2,%rdi
    22f3:	e8 74 1b 00 00       	call   3e6c <mkdir>
    22f8:	85 c0                	test   %eax,%eax
    22fa:	75 1b                	jne    2317 <subdir+0x593>
    printf(1, "mkdir dd/xx/ff succeeded!\n");
    22fc:	48 c7 c6 bd 51 00 00 	mov    $0x51bd,%rsi
    2303:	bf 01 00 00 00       	mov    $0x1,%edi
    2308:	b8 00 00 00 00       	mov    $0x0,%eax
    230d:	e8 84 1c 00 00       	call   3f96 <printf>
    exit();
    2312:	e8 ed 1a 00 00       	call   3e04 <exit>
  }
  if(mkdir("dd/dd/ffff") == 0){
    2317:	48 c7 c7 64 4f 00 00 	mov    $0x4f64,%rdi
    231e:	e8 49 1b 00 00       	call   3e6c <mkdir>
    2323:	85 c0                	test   %eax,%eax
    2325:	75 1b                	jne    2342 <subdir+0x5be>
    printf(1, "mkdir dd/dd/ffff succeeded!\n");
    2327:	48 c7 c6 d8 51 00 00 	mov    $0x51d8,%rsi
    232e:	bf 01 00 00 00       	mov    $0x1,%edi
    2333:	b8 00 00 00 00       	mov    $0x0,%eax
    2338:	e8 59 1c 00 00       	call   3f96 <printf>
    exit();
    233d:	e8 c2 1a 00 00       	call   3e04 <exit>
  }
  if(unlink("dd/xx/ff") == 0){
    2342:	48 c7 c7 b2 50 00 00 	mov    $0x50b2,%rdi
    2349:	e8 06 1b 00 00       	call   3e54 <unlink>
    234e:	85 c0                	test   %eax,%eax
    2350:	75 1b                	jne    236d <subdir+0x5e9>
    printf(1, "unlink dd/xx/ff succeeded!\n");
    2352:	48 c7 c6 f5 51 00 00 	mov    $0x51f5,%rsi
    2359:	bf 01 00 00 00       	mov    $0x1,%edi
    235e:	b8 00 00 00 00       	mov    $0x0,%eax
    2363:	e8 2e 1c 00 00       	call   3f96 <printf>
    exit();
    2368:	e8 97 1a 00 00       	call   3e04 <exit>
  }
  if(unlink("dd/ff/ff") == 0){
    236d:	48 c7 c7 8d 50 00 00 	mov    $0x508d,%rdi
    2374:	e8 db 1a 00 00       	call   3e54 <unlink>
    2379:	85 c0                	test   %eax,%eax
    237b:	75 1b                	jne    2398 <subdir+0x614>
    printf(1, "unlink dd/ff/ff succeeded!\n");
    237d:	48 c7 c6 11 52 00 00 	mov    $0x5211,%rsi
    2384:	bf 01 00 00 00       	mov    $0x1,%edi
    2389:	b8 00 00 00 00       	mov    $0x0,%eax
    238e:	e8 03 1c 00 00       	call   3f96 <printf>
    exit();
    2393:	e8 6c 1a 00 00       	call   3e04 <exit>
  }
  if(chdir("dd/ff") == 0){
    2398:	48 c7 c7 98 4e 00 00 	mov    $0x4e98,%rdi
    239f:	e8 d0 1a 00 00       	call   3e74 <chdir>
    23a4:	85 c0                	test   %eax,%eax
    23a6:	75 1b                	jne    23c3 <subdir+0x63f>
    printf(1, "chdir dd/ff succeeded!\n");
    23a8:	48 c7 c6 2d 52 00 00 	mov    $0x522d,%rsi
    23af:	bf 01 00 00 00       	mov    $0x1,%edi
    23b4:	b8 00 00 00 00       	mov    $0x0,%eax
    23b9:	e8 d8 1b 00 00       	call   3f96 <printf>
    exit();
    23be:	e8 41 1a 00 00       	call   3e04 <exit>
  }
  if(chdir("dd/xx") == 0){
    23c3:	48 c7 c7 45 52 00 00 	mov    $0x5245,%rdi
    23ca:	e8 a5 1a 00 00       	call   3e74 <chdir>
    23cf:	85 c0                	test   %eax,%eax
    23d1:	75 1b                	jne    23ee <subdir+0x66a>
    printf(1, "chdir dd/xx succeeded!\n");
    23d3:	48 c7 c6 4b 52 00 00 	mov    $0x524b,%rsi
    23da:	bf 01 00 00 00       	mov    $0x1,%edi
    23df:	b8 00 00 00 00       	mov    $0x0,%eax
    23e4:	e8 ad 1b 00 00       	call   3f96 <printf>
    exit();
    23e9:	e8 16 1a 00 00       	call   3e04 <exit>
  }

  if(unlink("dd/dd/ffff") != 0){
    23ee:	48 c7 c7 64 4f 00 00 	mov    $0x4f64,%rdi
    23f5:	e8 5a 1a 00 00       	call   3e54 <unlink>
    23fa:	85 c0                	test   %eax,%eax
    23fc:	74 1b                	je     2419 <subdir+0x695>
    printf(1, "unlink dd/dd/ff failed\n");
    23fe:	48 c7 c6 91 4f 00 00 	mov    $0x4f91,%rsi
    2405:	bf 01 00 00 00       	mov    $0x1,%edi
    240a:	b8 00 00 00 00       	mov    $0x0,%eax
    240f:	e8 82 1b 00 00       	call   3f96 <printf>
    exit();
    2414:	e8 eb 19 00 00       	call   3e04 <exit>
  }
  if(unlink("dd/ff") != 0){
    2419:	48 c7 c7 98 4e 00 00 	mov    $0x4e98,%rdi
    2420:	e8 2f 1a 00 00       	call   3e54 <unlink>
    2425:	85 c0                	test   %eax,%eax
    2427:	74 1b                	je     2444 <subdir+0x6c0>
    printf(1, "unlink dd/ff failed\n");
    2429:	48 c7 c6 63 52 00 00 	mov    $0x5263,%rsi
    2430:	bf 01 00 00 00       	mov    $0x1,%edi
    2435:	b8 00 00 00 00       	mov    $0x0,%eax
    243a:	e8 57 1b 00 00       	call   3f96 <printf>
    exit();
    243f:	e8 c0 19 00 00       	call   3e04 <exit>
  }
  if(unlink("dd") == 0){
    2444:	48 c7 c7 7d 4e 00 00 	mov    $0x4e7d,%rdi
    244b:	e8 04 1a 00 00       	call   3e54 <unlink>
    2450:	85 c0                	test   %eax,%eax
    2452:	75 1b                	jne    246f <subdir+0x6eb>
    printf(1, "unlink non-empty dd succeeded!\n");
    2454:	48 c7 c6 78 52 00 00 	mov    $0x5278,%rsi
    245b:	bf 01 00 00 00       	mov    $0x1,%edi
    2460:	b8 00 00 00 00       	mov    $0x0,%eax
    2465:	e8 2c 1b 00 00       	call   3f96 <printf>
    exit();
    246a:	e8 95 19 00 00       	call   3e04 <exit>
  }
  if(unlink("dd/dd") < 0){
    246f:	48 c7 c7 98 52 00 00 	mov    $0x5298,%rdi
    2476:	e8 d9 19 00 00       	call   3e54 <unlink>
    247b:	85 c0                	test   %eax,%eax
    247d:	79 1b                	jns    249a <subdir+0x716>
    printf(1, "unlink dd/dd failed\n");
    247f:	48 c7 c6 9e 52 00 00 	mov    $0x529e,%rsi
    2486:	bf 01 00 00 00       	mov    $0x1,%edi
    248b:	b8 00 00 00 00       	mov    $0x0,%eax
    2490:	e8 01 1b 00 00       	call   3f96 <printf>
    exit();
    2495:	e8 6a 19 00 00       	call   3e04 <exit>
  }
  if(unlink("dd") < 0){
    249a:	48 c7 c7 7d 4e 00 00 	mov    $0x4e7d,%rdi
    24a1:	e8 ae 19 00 00       	call   3e54 <unlink>
    24a6:	85 c0                	test   %eax,%eax
    24a8:	79 1b                	jns    24c5 <subdir+0x741>
    printf(1, "unlink dd failed\n");
    24aa:	48 c7 c6 b3 52 00 00 	mov    $0x52b3,%rsi
    24b1:	bf 01 00 00 00       	mov    $0x1,%edi
    24b6:	b8 00 00 00 00       	mov    $0x0,%eax
    24bb:	e8 d6 1a 00 00       	call   3f96 <printf>
    exit();
    24c0:	e8 3f 19 00 00       	call   3e04 <exit>
  }

  printf(1, "subdir ok\n");
    24c5:	48 c7 c6 c5 52 00 00 	mov    $0x52c5,%rsi
    24cc:	bf 01 00 00 00       	mov    $0x1,%edi
    24d1:	b8 00 00 00 00       	mov    $0x0,%eax
    24d6:	e8 bb 1a 00 00       	call   3f96 <printf>
}
    24db:	90                   	nop
    24dc:	c9                   	leave
    24dd:	c3                   	ret

00000000000024de <bigwrite>:

// test writes that are larger than the log.
void
bigwrite(void)
{
    24de:	55                   	push   %rbp
    24df:	48 89 e5             	mov    %rsp,%rbp
    24e2:	48 83 ec 10          	sub    $0x10,%rsp
  int fd, sz;

  printf(1, "bigwrite test\n");
    24e6:	48 c7 c6 d0 52 00 00 	mov    $0x52d0,%rsi
    24ed:	bf 01 00 00 00       	mov    $0x1,%edi
    24f2:	b8 00 00 00 00       	mov    $0x0,%eax
    24f7:	e8 9a 1a 00 00       	call   3f96 <printf>

  unlink("bigwrite");
    24fc:	48 c7 c7 df 52 00 00 	mov    $0x52df,%rdi
    2503:	e8 4c 19 00 00       	call   3e54 <unlink>
  for(sz = 499; sz < 12*512; sz += 471){
    2508:	c7 45 fc f3 01 00 00 	movl   $0x1f3,-0x4(%rbp)
    250f:	e9 a9 00 00 00       	jmp    25bd <bigwrite+0xdf>
    fd = open("bigwrite", O_CREATE | O_RDWR);
    2514:	be 02 02 00 00       	mov    $0x202,%esi
    2519:	48 c7 c7 df 52 00 00 	mov    $0x52df,%rdi
    2520:	e8 1f 19 00 00       	call   3e44 <open>
    2525:	89 45 f4             	mov    %eax,-0xc(%rbp)
    if(fd < 0){
    2528:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
    252c:	79 1b                	jns    2549 <bigwrite+0x6b>
      printf(1, "cannot create bigwrite\n");
    252e:	48 c7 c6 e8 52 00 00 	mov    $0x52e8,%rsi
    2535:	bf 01 00 00 00       	mov    $0x1,%edi
    253a:	b8 00 00 00 00       	mov    $0x0,%eax
    253f:	e8 52 1a 00 00       	call   3f96 <printf>
      exit();
    2544:	e8 bb 18 00 00       	call   3e04 <exit>
    }
    int i;
    for(i = 0; i < 2; i++){
    2549:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
    2550:	eb 48                	jmp    259a <bigwrite+0xbc>
      int cc = write(fd, buf, sz);
    2552:	8b 55 fc             	mov    -0x4(%rbp),%edx
    2555:	8b 45 f4             	mov    -0xc(%rbp),%eax
    2558:	48 c7 c6 60 63 00 00 	mov    $0x6360,%rsi
    255f:	89 c7                	mov    %eax,%edi
    2561:	e8 be 18 00 00       	call   3e24 <write>
    2566:	89 45 f0             	mov    %eax,-0x10(%rbp)
      if(cc != sz){
    2569:	8b 45 f0             	mov    -0x10(%rbp),%eax
    256c:	3b 45 fc             	cmp    -0x4(%rbp),%eax
    256f:	74 25                	je     2596 <bigwrite+0xb8>
        printf(1, "write(%d) ret %d\n", sz, cc);
    2571:	8b 55 f0             	mov    -0x10(%rbp),%edx
    2574:	8b 45 fc             	mov    -0x4(%rbp),%eax
    2577:	89 d1                	mov    %edx,%ecx
    2579:	89 c2                	mov    %eax,%edx
    257b:	48 c7 c6 00 53 00 00 	mov    $0x5300,%rsi
    2582:	bf 01 00 00 00       	mov    $0x1,%edi
    2587:	b8 00 00 00 00       	mov    $0x0,%eax
    258c:	e8 05 1a 00 00       	call   3f96 <printf>
        exit();
    2591:	e8 6e 18 00 00       	call   3e04 <exit>
    for(i = 0; i < 2; i++){
    2596:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
    259a:	83 7d f8 01          	cmpl   $0x1,-0x8(%rbp)
    259e:	7e b2                	jle    2552 <bigwrite+0x74>
      }
    }
    close(fd);
    25a0:	8b 45 f4             	mov    -0xc(%rbp),%eax
    25a3:	89 c7                	mov    %eax,%edi
    25a5:	e8 82 18 00 00       	call   3e2c <close>
    unlink("bigwrite");
    25aa:	48 c7 c7 df 52 00 00 	mov    $0x52df,%rdi
    25b1:	e8 9e 18 00 00       	call   3e54 <unlink>
  for(sz = 499; sz < 12*512; sz += 471){
    25b6:	81 45 fc d7 01 00 00 	addl   $0x1d7,-0x4(%rbp)
    25bd:	81 7d fc ff 17 00 00 	cmpl   $0x17ff,-0x4(%rbp)
    25c4:	0f 8e 4a ff ff ff    	jle    2514 <bigwrite+0x36>
  }

  printf(1, "bigwrite ok\n");
    25ca:	48 c7 c6 12 53 00 00 	mov    $0x5312,%rsi
    25d1:	bf 01 00 00 00       	mov    $0x1,%edi
    25d6:	b8 00 00 00 00       	mov    $0x0,%eax
    25db:	e8 b6 19 00 00       	call   3f96 <printf>
}
    25e0:	90                   	nop
    25e1:	c9                   	leave
    25e2:	c3                   	ret

00000000000025e3 <bigfile>:

void
bigfile(void)
{
    25e3:	55                   	push   %rbp
    25e4:	48 89 e5             	mov    %rsp,%rbp
    25e7:	48 83 ec 10          	sub    $0x10,%rsp
  int fd, i, total, cc;

  printf(1, "bigfile test\n");
    25eb:	48 c7 c6 1f 53 00 00 	mov    $0x531f,%rsi
    25f2:	bf 01 00 00 00       	mov    $0x1,%edi
    25f7:	b8 00 00 00 00       	mov    $0x0,%eax
    25fc:	e8 95 19 00 00       	call   3f96 <printf>

  unlink("bigfile");
    2601:	48 c7 c7 2d 53 00 00 	mov    $0x532d,%rdi
    2608:	e8 47 18 00 00       	call   3e54 <unlink>
  fd = open("bigfile", O_CREATE | O_RDWR);
    260d:	be 02 02 00 00       	mov    $0x202,%esi
    2612:	48 c7 c7 2d 53 00 00 	mov    $0x532d,%rdi
    2619:	e8 26 18 00 00       	call   3e44 <open>
    261e:	89 45 f4             	mov    %eax,-0xc(%rbp)
  if(fd < 0){
    2621:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
    2625:	79 1b                	jns    2642 <bigfile+0x5f>
    printf(1, "cannot create bigfile");
    2627:	48 c7 c6 35 53 00 00 	mov    $0x5335,%rsi
    262e:	bf 01 00 00 00       	mov    $0x1,%edi
    2633:	b8 00 00 00 00       	mov    $0x0,%eax
    2638:	e8 59 19 00 00       	call   3f96 <printf>
    exit();
    263d:	e8 c2 17 00 00       	call   3e04 <exit>
  }
  for(i = 0; i < 20; i++){
    2642:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    2649:	eb 52                	jmp    269d <bigfile+0xba>
    memset(buf, i, 600);
    264b:	8b 45 fc             	mov    -0x4(%rbp),%eax
    264e:	ba 58 02 00 00       	mov    $0x258,%edx
    2653:	89 c6                	mov    %eax,%esi
    2655:	48 c7 c7 60 63 00 00 	mov    $0x6360,%rdi
    265c:	e8 ae 15 00 00       	call   3c0f <memset>
    if(write(fd, buf, 600) != 600){
    2661:	8b 45 f4             	mov    -0xc(%rbp),%eax
    2664:	ba 58 02 00 00       	mov    $0x258,%edx
    2669:	48 c7 c6 60 63 00 00 	mov    $0x6360,%rsi
    2670:	89 c7                	mov    %eax,%edi
    2672:	e8 ad 17 00 00       	call   3e24 <write>
    2677:	3d 58 02 00 00       	cmp    $0x258,%eax
    267c:	74 1b                	je     2699 <bigfile+0xb6>
      printf(1, "write bigfile failed\n");
    267e:	48 c7 c6 4b 53 00 00 	mov    $0x534b,%rsi
    2685:	bf 01 00 00 00       	mov    $0x1,%edi
    268a:	b8 00 00 00 00       	mov    $0x0,%eax
    268f:	e8 02 19 00 00       	call   3f96 <printf>
      exit();
    2694:	e8 6b 17 00 00       	call   3e04 <exit>
  for(i = 0; i < 20; i++){
    2699:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    269d:	83 7d fc 13          	cmpl   $0x13,-0x4(%rbp)
    26a1:	7e a8                	jle    264b <bigfile+0x68>
    }
  }
  close(fd);
    26a3:	8b 45 f4             	mov    -0xc(%rbp),%eax
    26a6:	89 c7                	mov    %eax,%edi
    26a8:	e8 7f 17 00 00       	call   3e2c <close>

  fd = open("bigfile", 0);
    26ad:	be 00 00 00 00       	mov    $0x0,%esi
    26b2:	48 c7 c7 2d 53 00 00 	mov    $0x532d,%rdi
    26b9:	e8 86 17 00 00       	call   3e44 <open>
    26be:	89 45 f4             	mov    %eax,-0xc(%rbp)
  if(fd < 0){
    26c1:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
    26c5:	79 1b                	jns    26e2 <bigfile+0xff>
    printf(1, "cannot open bigfile\n");
    26c7:	48 c7 c6 61 53 00 00 	mov    $0x5361,%rsi
    26ce:	bf 01 00 00 00       	mov    $0x1,%edi
    26d3:	b8 00 00 00 00       	mov    $0x0,%eax
    26d8:	e8 b9 18 00 00       	call   3f96 <printf>
    exit();
    26dd:	e8 22 17 00 00       	call   3e04 <exit>
  }
  total = 0;
    26e2:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
  for(i = 0; ; i++){
    26e9:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    cc = read(fd, buf, 300);
    26f0:	8b 45 f4             	mov    -0xc(%rbp),%eax
    26f3:	ba 2c 01 00 00       	mov    $0x12c,%edx
    26f8:	48 c7 c6 60 63 00 00 	mov    $0x6360,%rsi
    26ff:	89 c7                	mov    %eax,%edi
    2701:	e8 16 17 00 00       	call   3e1c <read>
    2706:	89 45 f0             	mov    %eax,-0x10(%rbp)
    if(cc < 0){
    2709:	83 7d f0 00          	cmpl   $0x0,-0x10(%rbp)
    270d:	79 1b                	jns    272a <bigfile+0x147>
      printf(1, "read bigfile failed\n");
    270f:	48 c7 c6 76 53 00 00 	mov    $0x5376,%rsi
    2716:	bf 01 00 00 00       	mov    $0x1,%edi
    271b:	b8 00 00 00 00       	mov    $0x0,%eax
    2720:	e8 71 18 00 00       	call   3f96 <printf>
      exit();
    2725:	e8 da 16 00 00       	call   3e04 <exit>
    }
    if(cc == 0)
    272a:	83 7d f0 00          	cmpl   $0x0,-0x10(%rbp)
    272e:	0f 84 82 00 00 00    	je     27b6 <bigfile+0x1d3>
      break;
    if(cc != 300){
    2734:	81 7d f0 2c 01 00 00 	cmpl   $0x12c,-0x10(%rbp)
    273b:	74 1b                	je     2758 <bigfile+0x175>
      printf(1, "short read bigfile\n");
    273d:	48 c7 c6 8b 53 00 00 	mov    $0x538b,%rsi
    2744:	bf 01 00 00 00       	mov    $0x1,%edi
    2749:	b8 00 00 00 00       	mov    $0x0,%eax
    274e:	e8 43 18 00 00       	call   3f96 <printf>
      exit();
    2753:	e8 ac 16 00 00       	call   3e04 <exit>
    }
    if(buf[0] != i/2 || buf[299] != i/2){
    2758:	0f b6 05 01 3c 00 00 	movzbl 0x3c01(%rip),%eax        # 6360 <buf>
    275f:	0f be d0             	movsbl %al,%edx
    2762:	8b 45 fc             	mov    -0x4(%rbp),%eax
    2765:	89 c1                	mov    %eax,%ecx
    2767:	c1 e9 1f             	shr    $0x1f,%ecx
    276a:	01 c8                	add    %ecx,%eax
    276c:	d1 f8                	sar    %eax
    276e:	39 c2                	cmp    %eax,%edx
    2770:	75 1a                	jne    278c <bigfile+0x1a9>
    2772:	0f b6 05 12 3d 00 00 	movzbl 0x3d12(%rip),%eax        # 648b <buf+0x12b>
    2779:	0f be d0             	movsbl %al,%edx
    277c:	8b 45 fc             	mov    -0x4(%rbp),%eax
    277f:	89 c1                	mov    %eax,%ecx
    2781:	c1 e9 1f             	shr    $0x1f,%ecx
    2784:	01 c8                	add    %ecx,%eax
    2786:	d1 f8                	sar    %eax
    2788:	39 c2                	cmp    %eax,%edx
    278a:	74 1b                	je     27a7 <bigfile+0x1c4>
      printf(1, "read bigfile wrong data\n");
    278c:	48 c7 c6 9f 53 00 00 	mov    $0x539f,%rsi
    2793:	bf 01 00 00 00       	mov    $0x1,%edi
    2798:	b8 00 00 00 00       	mov    $0x0,%eax
    279d:	e8 f4 17 00 00       	call   3f96 <printf>
      exit();
    27a2:	e8 5d 16 00 00       	call   3e04 <exit>
    }
    total += cc;
    27a7:	8b 45 f0             	mov    -0x10(%rbp),%eax
    27aa:	01 45 f8             	add    %eax,-0x8(%rbp)
  for(i = 0; ; i++){
    27ad:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    cc = read(fd, buf, 300);
    27b1:	e9 3a ff ff ff       	jmp    26f0 <bigfile+0x10d>
      break;
    27b6:	90                   	nop
  }
  close(fd);
    27b7:	8b 45 f4             	mov    -0xc(%rbp),%eax
    27ba:	89 c7                	mov    %eax,%edi
    27bc:	e8 6b 16 00 00       	call   3e2c <close>
  if(total != 20*600){
    27c1:	81 7d f8 e0 2e 00 00 	cmpl   $0x2ee0,-0x8(%rbp)
    27c8:	74 1b                	je     27e5 <bigfile+0x202>
    printf(1, "read bigfile wrong total\n");
    27ca:	48 c7 c6 b8 53 00 00 	mov    $0x53b8,%rsi
    27d1:	bf 01 00 00 00       	mov    $0x1,%edi
    27d6:	b8 00 00 00 00       	mov    $0x0,%eax
    27db:	e8 b6 17 00 00       	call   3f96 <printf>
    exit();
    27e0:	e8 1f 16 00 00       	call   3e04 <exit>
  }
  unlink("bigfile");
    27e5:	48 c7 c7 2d 53 00 00 	mov    $0x532d,%rdi
    27ec:	e8 63 16 00 00       	call   3e54 <unlink>

  printf(1, "bigfile test ok\n");
    27f1:	48 c7 c6 d2 53 00 00 	mov    $0x53d2,%rsi
    27f8:	bf 01 00 00 00       	mov    $0x1,%edi
    27fd:	b8 00 00 00 00       	mov    $0x0,%eax
    2802:	e8 8f 17 00 00       	call   3f96 <printf>
}
    2807:	90                   	nop
    2808:	c9                   	leave
    2809:	c3                   	ret

000000000000280a <fourteen>:

void
fourteen(void)
{
    280a:	55                   	push   %rbp
    280b:	48 89 e5             	mov    %rsp,%rbp
    280e:	48 83 ec 10          	sub    $0x10,%rsp
  int fd;

  // DIRSIZ is 14.
  printf(1, "fourteen test\n");
    2812:	48 c7 c6 e3 53 00 00 	mov    $0x53e3,%rsi
    2819:	bf 01 00 00 00       	mov    $0x1,%edi
    281e:	b8 00 00 00 00       	mov    $0x0,%eax
    2823:	e8 6e 17 00 00       	call   3f96 <printf>

  if(mkdir("12345678901234") != 0){
    2828:	48 c7 c7 f2 53 00 00 	mov    $0x53f2,%rdi
    282f:	e8 38 16 00 00       	call   3e6c <mkdir>
    2834:	85 c0                	test   %eax,%eax
    2836:	74 1b                	je     2853 <fourteen+0x49>
    printf(1, "mkdir 12345678901234 failed\n");
    2838:	48 c7 c6 01 54 00 00 	mov    $0x5401,%rsi
    283f:	bf 01 00 00 00       	mov    $0x1,%edi
    2844:	b8 00 00 00 00       	mov    $0x0,%eax
    2849:	e8 48 17 00 00       	call   3f96 <printf>
    exit();
    284e:	e8 b1 15 00 00       	call   3e04 <exit>
  }
  if(mkdir("12345678901234/123456789012345") != 0){
    2853:	48 c7 c7 20 54 00 00 	mov    $0x5420,%rdi
    285a:	e8 0d 16 00 00       	call   3e6c <mkdir>
    285f:	85 c0                	test   %eax,%eax
    2861:	74 1b                	je     287e <fourteen+0x74>
    printf(1, "mkdir 12345678901234/123456789012345 failed\n");
    2863:	48 c7 c6 40 54 00 00 	mov    $0x5440,%rsi
    286a:	bf 01 00 00 00       	mov    $0x1,%edi
    286f:	b8 00 00 00 00       	mov    $0x0,%eax
    2874:	e8 1d 17 00 00       	call   3f96 <printf>
    exit();
    2879:	e8 86 15 00 00       	call   3e04 <exit>
  }
  fd = open("123456789012345/123456789012345/123456789012345", O_CREATE);
    287e:	be 00 02 00 00       	mov    $0x200,%esi
    2883:	48 c7 c7 70 54 00 00 	mov    $0x5470,%rdi
    288a:	e8 b5 15 00 00       	call   3e44 <open>
    288f:	89 45 fc             	mov    %eax,-0x4(%rbp)
  if(fd < 0){
    2892:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    2896:	79 1b                	jns    28b3 <fourteen+0xa9>
    printf(1, "create 123456789012345/123456789012345/123456789012345 failed\n");
    2898:	48 c7 c6 a0 54 00 00 	mov    $0x54a0,%rsi
    289f:	bf 01 00 00 00       	mov    $0x1,%edi
    28a4:	b8 00 00 00 00       	mov    $0x0,%eax
    28a9:	e8 e8 16 00 00       	call   3f96 <printf>
    exit();
    28ae:	e8 51 15 00 00       	call   3e04 <exit>
  }
  close(fd);
    28b3:	8b 45 fc             	mov    -0x4(%rbp),%eax
    28b6:	89 c7                	mov    %eax,%edi
    28b8:	e8 6f 15 00 00       	call   3e2c <close>
  fd = open("12345678901234/12345678901234/12345678901234", 0);
    28bd:	be 00 00 00 00       	mov    $0x0,%esi
    28c2:	48 c7 c7 e0 54 00 00 	mov    $0x54e0,%rdi
    28c9:	e8 76 15 00 00       	call   3e44 <open>
    28ce:	89 45 fc             	mov    %eax,-0x4(%rbp)
  if(fd < 0){
    28d1:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    28d5:	79 1b                	jns    28f2 <fourteen+0xe8>
    printf(1, "open 12345678901234/12345678901234/12345678901234 failed\n");
    28d7:	48 c7 c6 10 55 00 00 	mov    $0x5510,%rsi
    28de:	bf 01 00 00 00       	mov    $0x1,%edi
    28e3:	b8 00 00 00 00       	mov    $0x0,%eax
    28e8:	e8 a9 16 00 00       	call   3f96 <printf>
    exit();
    28ed:	e8 12 15 00 00       	call   3e04 <exit>
  }
  close(fd);
    28f2:	8b 45 fc             	mov    -0x4(%rbp),%eax
    28f5:	89 c7                	mov    %eax,%edi
    28f7:	e8 30 15 00 00       	call   3e2c <close>

  if(mkdir("12345678901234/12345678901234") == 0){
    28fc:	48 c7 c7 4a 55 00 00 	mov    $0x554a,%rdi
    2903:	e8 64 15 00 00       	call   3e6c <mkdir>
    2908:	85 c0                	test   %eax,%eax
    290a:	75 1b                	jne    2927 <fourteen+0x11d>
    printf(1, "mkdir 12345678901234/12345678901234 succeeded!\n");
    290c:	48 c7 c6 68 55 00 00 	mov    $0x5568,%rsi
    2913:	bf 01 00 00 00       	mov    $0x1,%edi
    2918:	b8 00 00 00 00       	mov    $0x0,%eax
    291d:	e8 74 16 00 00       	call   3f96 <printf>
    exit();
    2922:	e8 dd 14 00 00       	call   3e04 <exit>
  }
  if(mkdir("123456789012345/12345678901234") == 0){
    2927:	48 c7 c7 98 55 00 00 	mov    $0x5598,%rdi
    292e:	e8 39 15 00 00       	call   3e6c <mkdir>
    2933:	85 c0                	test   %eax,%eax
    2935:	75 1b                	jne    2952 <fourteen+0x148>
    printf(1, "mkdir 12345678901234/123456789012345 succeeded!\n");
    2937:	48 c7 c6 b8 55 00 00 	mov    $0x55b8,%rsi
    293e:	bf 01 00 00 00       	mov    $0x1,%edi
    2943:	b8 00 00 00 00       	mov    $0x0,%eax
    2948:	e8 49 16 00 00       	call   3f96 <printf>
    exit();
    294d:	e8 b2 14 00 00       	call   3e04 <exit>
  }

  printf(1, "fourteen ok\n");
    2952:	48 c7 c6 e9 55 00 00 	mov    $0x55e9,%rsi
    2959:	bf 01 00 00 00       	mov    $0x1,%edi
    295e:	b8 00 00 00 00       	mov    $0x0,%eax
    2963:	e8 2e 16 00 00       	call   3f96 <printf>
}
    2968:	90                   	nop
    2969:	c9                   	leave
    296a:	c3                   	ret

000000000000296b <rmdot>:

void
rmdot(void)
{
    296b:	55                   	push   %rbp
    296c:	48 89 e5             	mov    %rsp,%rbp
  printf(1, "rmdot test\n");
    296f:	48 c7 c6 f6 55 00 00 	mov    $0x55f6,%rsi
    2976:	bf 01 00 00 00       	mov    $0x1,%edi
    297b:	b8 00 00 00 00       	mov    $0x0,%eax
    2980:	e8 11 16 00 00       	call   3f96 <printf>
  if(mkdir("dots") != 0){
    2985:	48 c7 c7 02 56 00 00 	mov    $0x5602,%rdi
    298c:	e8 db 14 00 00       	call   3e6c <mkdir>
    2991:	85 c0                	test   %eax,%eax
    2993:	74 1b                	je     29b0 <rmdot+0x45>
    printf(1, "mkdir dots failed\n");
    2995:	48 c7 c6 07 56 00 00 	mov    $0x5607,%rsi
    299c:	bf 01 00 00 00       	mov    $0x1,%edi
    29a1:	b8 00 00 00 00       	mov    $0x0,%eax
    29a6:	e8 eb 15 00 00       	call   3f96 <printf>
    exit();
    29ab:	e8 54 14 00 00       	call   3e04 <exit>
  }
  if(chdir("dots") != 0){
    29b0:	48 c7 c7 02 56 00 00 	mov    $0x5602,%rdi
    29b7:	e8 b8 14 00 00       	call   3e74 <chdir>
    29bc:	85 c0                	test   %eax,%eax
    29be:	74 1b                	je     29db <rmdot+0x70>
    printf(1, "chdir dots failed\n");
    29c0:	48 c7 c6 1a 56 00 00 	mov    $0x561a,%rsi
    29c7:	bf 01 00 00 00       	mov    $0x1,%edi
    29cc:	b8 00 00 00 00       	mov    $0x0,%eax
    29d1:	e8 c0 15 00 00       	call   3f96 <printf>
    exit();
    29d6:	e8 29 14 00 00       	call   3e04 <exit>
  }
  if(unlink(".") == 0){
    29db:	48 c7 c7 1b 4d 00 00 	mov    $0x4d1b,%rdi
    29e2:	e8 6d 14 00 00       	call   3e54 <unlink>
    29e7:	85 c0                	test   %eax,%eax
    29e9:	75 1b                	jne    2a06 <rmdot+0x9b>
    printf(1, "rm . worked!\n");
    29eb:	48 c7 c6 2d 56 00 00 	mov    $0x562d,%rsi
    29f2:	bf 01 00 00 00       	mov    $0x1,%edi
    29f7:	b8 00 00 00 00       	mov    $0x0,%eax
    29fc:	e8 95 15 00 00       	call   3f96 <printf>
    exit();
    2a01:	e8 fe 13 00 00       	call   3e04 <exit>
  }
  if(unlink("..") == 0){
    2a06:	48 c7 c7 a0 48 00 00 	mov    $0x48a0,%rdi
    2a0d:	e8 42 14 00 00       	call   3e54 <unlink>
    2a12:	85 c0                	test   %eax,%eax
    2a14:	75 1b                	jne    2a31 <rmdot+0xc6>
    printf(1, "rm .. worked!\n");
    2a16:	48 c7 c6 3b 56 00 00 	mov    $0x563b,%rsi
    2a1d:	bf 01 00 00 00       	mov    $0x1,%edi
    2a22:	b8 00 00 00 00       	mov    $0x0,%eax
    2a27:	e8 6a 15 00 00       	call   3f96 <printf>
    exit();
    2a2c:	e8 d3 13 00 00       	call   3e04 <exit>
  }
  if(chdir("/") != 0){
    2a31:	48 c7 c7 4a 56 00 00 	mov    $0x564a,%rdi
    2a38:	e8 37 14 00 00       	call   3e74 <chdir>
    2a3d:	85 c0                	test   %eax,%eax
    2a3f:	74 1b                	je     2a5c <rmdot+0xf1>
    printf(1, "chdir / failed\n");
    2a41:	48 c7 c6 4c 56 00 00 	mov    $0x564c,%rsi
    2a48:	bf 01 00 00 00       	mov    $0x1,%edi
    2a4d:	b8 00 00 00 00       	mov    $0x0,%eax
    2a52:	e8 3f 15 00 00       	call   3f96 <printf>
    exit();
    2a57:	e8 a8 13 00 00       	call   3e04 <exit>
  }
  if(unlink("dots/.") == 0){
    2a5c:	48 c7 c7 5c 56 00 00 	mov    $0x565c,%rdi
    2a63:	e8 ec 13 00 00       	call   3e54 <unlink>
    2a68:	85 c0                	test   %eax,%eax
    2a6a:	75 1b                	jne    2a87 <rmdot+0x11c>
    printf(1, "unlink dots/. worked!\n");
    2a6c:	48 c7 c6 63 56 00 00 	mov    $0x5663,%rsi
    2a73:	bf 01 00 00 00       	mov    $0x1,%edi
    2a78:	b8 00 00 00 00       	mov    $0x0,%eax
    2a7d:	e8 14 15 00 00       	call   3f96 <printf>
    exit();
    2a82:	e8 7d 13 00 00       	call   3e04 <exit>
  }
  if(unlink("dots/..") == 0){
    2a87:	48 c7 c7 7a 56 00 00 	mov    $0x567a,%rdi
    2a8e:	e8 c1 13 00 00       	call   3e54 <unlink>
    2a93:	85 c0                	test   %eax,%eax
    2a95:	75 1b                	jne    2ab2 <rmdot+0x147>
    printf(1, "unlink dots/.. worked!\n");
    2a97:	48 c7 c6 82 56 00 00 	mov    $0x5682,%rsi
    2a9e:	bf 01 00 00 00       	mov    $0x1,%edi
    2aa3:	b8 00 00 00 00       	mov    $0x0,%eax
    2aa8:	e8 e9 14 00 00       	call   3f96 <printf>
    exit();
    2aad:	e8 52 13 00 00       	call   3e04 <exit>
  }
  if(unlink("dots") != 0){
    2ab2:	48 c7 c7 02 56 00 00 	mov    $0x5602,%rdi
    2ab9:	e8 96 13 00 00       	call   3e54 <unlink>
    2abe:	85 c0                	test   %eax,%eax
    2ac0:	74 1b                	je     2add <rmdot+0x172>
    printf(1, "unlink dots failed!\n");
    2ac2:	48 c7 c6 9a 56 00 00 	mov    $0x569a,%rsi
    2ac9:	bf 01 00 00 00       	mov    $0x1,%edi
    2ace:	b8 00 00 00 00       	mov    $0x0,%eax
    2ad3:	e8 be 14 00 00       	call   3f96 <printf>
    exit();
    2ad8:	e8 27 13 00 00       	call   3e04 <exit>
  }
  printf(1, "rmdot ok\n");
    2add:	48 c7 c6 af 56 00 00 	mov    $0x56af,%rsi
    2ae4:	bf 01 00 00 00       	mov    $0x1,%edi
    2ae9:	b8 00 00 00 00       	mov    $0x0,%eax
    2aee:	e8 a3 14 00 00       	call   3f96 <printf>
}
    2af3:	90                   	nop
    2af4:	5d                   	pop    %rbp
    2af5:	c3                   	ret

0000000000002af6 <dirfile>:

void
dirfile(void)
{
    2af6:	55                   	push   %rbp
    2af7:	48 89 e5             	mov    %rsp,%rbp
    2afa:	48 83 ec 10          	sub    $0x10,%rsp
  int fd;

  printf(1, "dir vs file\n");
    2afe:	48 c7 c6 b9 56 00 00 	mov    $0x56b9,%rsi
    2b05:	bf 01 00 00 00       	mov    $0x1,%edi
    2b0a:	b8 00 00 00 00       	mov    $0x0,%eax
    2b0f:	e8 82 14 00 00       	call   3f96 <printf>

  fd = open("dirfile", O_CREATE);
    2b14:	be 00 02 00 00       	mov    $0x200,%esi
    2b19:	48 c7 c7 c6 56 00 00 	mov    $0x56c6,%rdi
    2b20:	e8 1f 13 00 00       	call   3e44 <open>
    2b25:	89 45 fc             	mov    %eax,-0x4(%rbp)
  if(fd < 0){
    2b28:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    2b2c:	79 1b                	jns    2b49 <dirfile+0x53>
    printf(1, "create dirfile failed\n");
    2b2e:	48 c7 c6 ce 56 00 00 	mov    $0x56ce,%rsi
    2b35:	bf 01 00 00 00       	mov    $0x1,%edi
    2b3a:	b8 00 00 00 00       	mov    $0x0,%eax
    2b3f:	e8 52 14 00 00       	call   3f96 <printf>
    exit();
    2b44:	e8 bb 12 00 00       	call   3e04 <exit>
  }
  close(fd);
    2b49:	8b 45 fc             	mov    -0x4(%rbp),%eax
    2b4c:	89 c7                	mov    %eax,%edi
    2b4e:	e8 d9 12 00 00       	call   3e2c <close>
  if(chdir("dirfile") == 0){
    2b53:	48 c7 c7 c6 56 00 00 	mov    $0x56c6,%rdi
    2b5a:	e8 15 13 00 00       	call   3e74 <chdir>
    2b5f:	85 c0                	test   %eax,%eax
    2b61:	75 1b                	jne    2b7e <dirfile+0x88>
    printf(1, "chdir dirfile succeeded!\n");
    2b63:	48 c7 c6 e5 56 00 00 	mov    $0x56e5,%rsi
    2b6a:	bf 01 00 00 00       	mov    $0x1,%edi
    2b6f:	b8 00 00 00 00       	mov    $0x0,%eax
    2b74:	e8 1d 14 00 00       	call   3f96 <printf>
    exit();
    2b79:	e8 86 12 00 00       	call   3e04 <exit>
  }
  fd = open("dirfile/xx", 0);
    2b7e:	be 00 00 00 00       	mov    $0x0,%esi
    2b83:	48 c7 c7 ff 56 00 00 	mov    $0x56ff,%rdi
    2b8a:	e8 b5 12 00 00       	call   3e44 <open>
    2b8f:	89 45 fc             	mov    %eax,-0x4(%rbp)
  if(fd >= 0){
    2b92:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    2b96:	78 1b                	js     2bb3 <dirfile+0xbd>
    printf(1, "create dirfile/xx succeeded!\n");
    2b98:	48 c7 c6 0a 57 00 00 	mov    $0x570a,%rsi
    2b9f:	bf 01 00 00 00       	mov    $0x1,%edi
    2ba4:	b8 00 00 00 00       	mov    $0x0,%eax
    2ba9:	e8 e8 13 00 00       	call   3f96 <printf>
    exit();
    2bae:	e8 51 12 00 00       	call   3e04 <exit>
  }
  fd = open("dirfile/xx", O_CREATE);
    2bb3:	be 00 02 00 00       	mov    $0x200,%esi
    2bb8:	48 c7 c7 ff 56 00 00 	mov    $0x56ff,%rdi
    2bbf:	e8 80 12 00 00       	call   3e44 <open>
    2bc4:	89 45 fc             	mov    %eax,-0x4(%rbp)
  if(fd >= 0){
    2bc7:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    2bcb:	78 1b                	js     2be8 <dirfile+0xf2>
    printf(1, "create dirfile/xx succeeded!\n");
    2bcd:	48 c7 c6 0a 57 00 00 	mov    $0x570a,%rsi
    2bd4:	bf 01 00 00 00       	mov    $0x1,%edi
    2bd9:	b8 00 00 00 00       	mov    $0x0,%eax
    2bde:	e8 b3 13 00 00       	call   3f96 <printf>
    exit();
    2be3:	e8 1c 12 00 00       	call   3e04 <exit>
  }
  if(mkdir("dirfile/xx") == 0){
    2be8:	48 c7 c7 ff 56 00 00 	mov    $0x56ff,%rdi
    2bef:	e8 78 12 00 00       	call   3e6c <mkdir>
    2bf4:	85 c0                	test   %eax,%eax
    2bf6:	75 1b                	jne    2c13 <dirfile+0x11d>
    printf(1, "mkdir dirfile/xx succeeded!\n");
    2bf8:	48 c7 c6 28 57 00 00 	mov    $0x5728,%rsi
    2bff:	bf 01 00 00 00       	mov    $0x1,%edi
    2c04:	b8 00 00 00 00       	mov    $0x0,%eax
    2c09:	e8 88 13 00 00       	call   3f96 <printf>
    exit();
    2c0e:	e8 f1 11 00 00       	call   3e04 <exit>
  }
  if(unlink("dirfile/xx") == 0){
    2c13:	48 c7 c7 ff 56 00 00 	mov    $0x56ff,%rdi
    2c1a:	e8 35 12 00 00       	call   3e54 <unlink>
    2c1f:	85 c0                	test   %eax,%eax
    2c21:	75 1b                	jne    2c3e <dirfile+0x148>
    printf(1, "unlink dirfile/xx succeeded!\n");
    2c23:	48 c7 c6 45 57 00 00 	mov    $0x5745,%rsi
    2c2a:	bf 01 00 00 00       	mov    $0x1,%edi
    2c2f:	b8 00 00 00 00       	mov    $0x0,%eax
    2c34:	e8 5d 13 00 00       	call   3f96 <printf>
    exit();
    2c39:	e8 c6 11 00 00       	call   3e04 <exit>
  }
  if(link("README", "dirfile/xx") == 0){
    2c3e:	48 c7 c6 ff 56 00 00 	mov    $0x56ff,%rsi
    2c45:	48 c7 c7 63 57 00 00 	mov    $0x5763,%rdi
    2c4c:	e8 13 12 00 00       	call   3e64 <link>
    2c51:	85 c0                	test   %eax,%eax
    2c53:	75 1b                	jne    2c70 <dirfile+0x17a>
    printf(1, "link to dirfile/xx succeeded!\n");
    2c55:	48 c7 c6 70 57 00 00 	mov    $0x5770,%rsi
    2c5c:	bf 01 00 00 00       	mov    $0x1,%edi
    2c61:	b8 00 00 00 00       	mov    $0x0,%eax
    2c66:	e8 2b 13 00 00       	call   3f96 <printf>
    exit();
    2c6b:	e8 94 11 00 00       	call   3e04 <exit>
  }
  if(unlink("dirfile") != 0){
    2c70:	48 c7 c7 c6 56 00 00 	mov    $0x56c6,%rdi
    2c77:	e8 d8 11 00 00       	call   3e54 <unlink>
    2c7c:	85 c0                	test   %eax,%eax
    2c7e:	74 1b                	je     2c9b <dirfile+0x1a5>
    printf(1, "unlink dirfile failed!\n");
    2c80:	48 c7 c6 8f 57 00 00 	mov    $0x578f,%rsi
    2c87:	bf 01 00 00 00       	mov    $0x1,%edi
    2c8c:	b8 00 00 00 00       	mov    $0x0,%eax
    2c91:	e8 00 13 00 00       	call   3f96 <printf>
    exit();
    2c96:	e8 69 11 00 00       	call   3e04 <exit>
  }

  fd = open(".", O_RDWR);
    2c9b:	be 02 00 00 00       	mov    $0x2,%esi
    2ca0:	48 c7 c7 1b 4d 00 00 	mov    $0x4d1b,%rdi
    2ca7:	e8 98 11 00 00       	call   3e44 <open>
    2cac:	89 45 fc             	mov    %eax,-0x4(%rbp)
  if(fd >= 0){
    2caf:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    2cb3:	78 1b                	js     2cd0 <dirfile+0x1da>
    printf(1, "open . for writing succeeded!\n");
    2cb5:	48 c7 c6 a8 57 00 00 	mov    $0x57a8,%rsi
    2cbc:	bf 01 00 00 00       	mov    $0x1,%edi
    2cc1:	b8 00 00 00 00       	mov    $0x0,%eax
    2cc6:	e8 cb 12 00 00       	call   3f96 <printf>
    exit();
    2ccb:	e8 34 11 00 00       	call   3e04 <exit>
  }
  fd = open(".", 0);
    2cd0:	be 00 00 00 00       	mov    $0x0,%esi
    2cd5:	48 c7 c7 1b 4d 00 00 	mov    $0x4d1b,%rdi
    2cdc:	e8 63 11 00 00       	call   3e44 <open>
    2ce1:	89 45 fc             	mov    %eax,-0x4(%rbp)
  if(write(fd, "x", 1) > 0){
    2ce4:	8b 45 fc             	mov    -0x4(%rbp),%eax
    2ce7:	ba 01 00 00 00       	mov    $0x1,%edx
    2cec:	48 c7 c6 4a 49 00 00 	mov    $0x494a,%rsi
    2cf3:	89 c7                	mov    %eax,%edi
    2cf5:	e8 2a 11 00 00       	call   3e24 <write>
    2cfa:	85 c0                	test   %eax,%eax
    2cfc:	7e 1b                	jle    2d19 <dirfile+0x223>
    printf(1, "write . succeeded!\n");
    2cfe:	48 c7 c6 c7 57 00 00 	mov    $0x57c7,%rsi
    2d05:	bf 01 00 00 00       	mov    $0x1,%edi
    2d0a:	b8 00 00 00 00       	mov    $0x0,%eax
    2d0f:	e8 82 12 00 00       	call   3f96 <printf>
    exit();
    2d14:	e8 eb 10 00 00       	call   3e04 <exit>
  }
  close(fd);
    2d19:	8b 45 fc             	mov    -0x4(%rbp),%eax
    2d1c:	89 c7                	mov    %eax,%edi
    2d1e:	e8 09 11 00 00       	call   3e2c <close>

  printf(1, "dir vs file OK\n");
    2d23:	48 c7 c6 db 57 00 00 	mov    $0x57db,%rsi
    2d2a:	bf 01 00 00 00       	mov    $0x1,%edi
    2d2f:	b8 00 00 00 00       	mov    $0x0,%eax
    2d34:	e8 5d 12 00 00       	call   3f96 <printf>
}
    2d39:	90                   	nop
    2d3a:	c9                   	leave
    2d3b:	c3                   	ret

0000000000002d3c <iref>:

// test that iput() is called at the end of _namei()
void
iref(void)
{
    2d3c:	55                   	push   %rbp
    2d3d:	48 89 e5             	mov    %rsp,%rbp
    2d40:	48 83 ec 10          	sub    $0x10,%rsp
  int i, fd;

  printf(1, "empty file name\n");
    2d44:	48 c7 c6 eb 57 00 00 	mov    $0x57eb,%rsi
    2d4b:	bf 01 00 00 00       	mov    $0x1,%edi
    2d50:	b8 00 00 00 00       	mov    $0x0,%eax
    2d55:	e8 3c 12 00 00       	call   3f96 <printf>

  // the 50 is NINODE
  for(i = 0; i < 50 + 1; i++){
    2d5a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    2d61:	e9 cd 00 00 00       	jmp    2e33 <iref+0xf7>
    if(mkdir("irefd") != 0){
    2d66:	48 c7 c7 fc 57 00 00 	mov    $0x57fc,%rdi
    2d6d:	e8 fa 10 00 00       	call   3e6c <mkdir>
    2d72:	85 c0                	test   %eax,%eax
    2d74:	74 1b                	je     2d91 <iref+0x55>
      printf(1, "mkdir irefd failed\n");
    2d76:	48 c7 c6 02 58 00 00 	mov    $0x5802,%rsi
    2d7d:	bf 01 00 00 00       	mov    $0x1,%edi
    2d82:	b8 00 00 00 00       	mov    $0x0,%eax
    2d87:	e8 0a 12 00 00       	call   3f96 <printf>
      exit();
    2d8c:	e8 73 10 00 00       	call   3e04 <exit>
    }
    if(chdir("irefd") != 0){
    2d91:	48 c7 c7 fc 57 00 00 	mov    $0x57fc,%rdi
    2d98:	e8 d7 10 00 00       	call   3e74 <chdir>
    2d9d:	85 c0                	test   %eax,%eax
    2d9f:	74 1b                	je     2dbc <iref+0x80>
      printf(1, "chdir irefd failed\n");
    2da1:	48 c7 c6 16 58 00 00 	mov    $0x5816,%rsi
    2da8:	bf 01 00 00 00       	mov    $0x1,%edi
    2dad:	b8 00 00 00 00       	mov    $0x0,%eax
    2db2:	e8 df 11 00 00       	call   3f96 <printf>
      exit();
    2db7:	e8 48 10 00 00       	call   3e04 <exit>
    }

    mkdir("");
    2dbc:	48 c7 c7 2a 58 00 00 	mov    $0x582a,%rdi
    2dc3:	e8 a4 10 00 00       	call   3e6c <mkdir>
    link("README", "");
    2dc8:	48 c7 c6 2a 58 00 00 	mov    $0x582a,%rsi
    2dcf:	48 c7 c7 63 57 00 00 	mov    $0x5763,%rdi
    2dd6:	e8 89 10 00 00       	call   3e64 <link>
    fd = open("", O_CREATE);
    2ddb:	be 00 02 00 00       	mov    $0x200,%esi
    2de0:	48 c7 c7 2a 58 00 00 	mov    $0x582a,%rdi
    2de7:	e8 58 10 00 00       	call   3e44 <open>
    2dec:	89 45 f8             	mov    %eax,-0x8(%rbp)
    if(fd >= 0)
    2def:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
    2df3:	78 0a                	js     2dff <iref+0xc3>
      close(fd);
    2df5:	8b 45 f8             	mov    -0x8(%rbp),%eax
    2df8:	89 c7                	mov    %eax,%edi
    2dfa:	e8 2d 10 00 00       	call   3e2c <close>
    fd = open("xx", O_CREATE);
    2dff:	be 00 02 00 00       	mov    $0x200,%esi
    2e04:	48 c7 c7 2b 58 00 00 	mov    $0x582b,%rdi
    2e0b:	e8 34 10 00 00       	call   3e44 <open>
    2e10:	89 45 f8             	mov    %eax,-0x8(%rbp)
    if(fd >= 0)
    2e13:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
    2e17:	78 0a                	js     2e23 <iref+0xe7>
      close(fd);
    2e19:	8b 45 f8             	mov    -0x8(%rbp),%eax
    2e1c:	89 c7                	mov    %eax,%edi
    2e1e:	e8 09 10 00 00       	call   3e2c <close>
    unlink("xx");
    2e23:	48 c7 c7 2b 58 00 00 	mov    $0x582b,%rdi
    2e2a:	e8 25 10 00 00       	call   3e54 <unlink>
  for(i = 0; i < 50 + 1; i++){
    2e2f:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    2e33:	83 7d fc 32          	cmpl   $0x32,-0x4(%rbp)
    2e37:	0f 8e 29 ff ff ff    	jle    2d66 <iref+0x2a>
  }

  chdir("/");
    2e3d:	48 c7 c7 4a 56 00 00 	mov    $0x564a,%rdi
    2e44:	e8 2b 10 00 00       	call   3e74 <chdir>
  printf(1, "empty file name OK\n");
    2e49:	48 c7 c6 2e 58 00 00 	mov    $0x582e,%rsi
    2e50:	bf 01 00 00 00       	mov    $0x1,%edi
    2e55:	b8 00 00 00 00       	mov    $0x0,%eax
    2e5a:	e8 37 11 00 00       	call   3f96 <printf>
}
    2e5f:	90                   	nop
    2e60:	c9                   	leave
    2e61:	c3                   	ret

0000000000002e62 <forktest>:
// test that fork fails gracefully
// the forktest binary also does this, but it runs out of proc entries first.
// inside the bigger usertests binary, we run out of memory first.
void
forktest(void)
{
    2e62:	55                   	push   %rbp
    2e63:	48 89 e5             	mov    %rsp,%rbp
    2e66:	48 83 ec 10          	sub    $0x10,%rsp
  int n, pid;

  printf(1, "fork test\n");
    2e6a:	48 c7 c6 42 58 00 00 	mov    $0x5842,%rsi
    2e71:	bf 01 00 00 00       	mov    $0x1,%edi
    2e76:	b8 00 00 00 00       	mov    $0x0,%eax
    2e7b:	e8 16 11 00 00       	call   3f96 <printf>

  for(n=0; n<1000; n++){
    2e80:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    2e87:	eb 1d                	jmp    2ea6 <forktest+0x44>
    pid = fork();
    2e89:	e8 6e 0f 00 00       	call   3dfc <fork>
    2e8e:	89 45 f8             	mov    %eax,-0x8(%rbp)
    if(pid < 0)
    2e91:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
    2e95:	78 1a                	js     2eb1 <forktest+0x4f>
      break;
    if(pid == 0)
    2e97:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
    2e9b:	75 05                	jne    2ea2 <forktest+0x40>
      exit();
    2e9d:	e8 62 0f 00 00       	call   3e04 <exit>
  for(n=0; n<1000; n++){
    2ea2:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    2ea6:	81 7d fc e7 03 00 00 	cmpl   $0x3e7,-0x4(%rbp)
    2ead:	7e da                	jle    2e89 <forktest+0x27>
    2eaf:	eb 01                	jmp    2eb2 <forktest+0x50>
      break;
    2eb1:	90                   	nop
  }
  
  if(n == 1000){
    2eb2:	81 7d fc e8 03 00 00 	cmpl   $0x3e8,-0x4(%rbp)
    2eb9:	75 43                	jne    2efe <forktest+0x9c>
    printf(1, "fork claimed to work 1000 times!\n");
    2ebb:	48 c7 c6 50 58 00 00 	mov    $0x5850,%rsi
    2ec2:	bf 01 00 00 00       	mov    $0x1,%edi
    2ec7:	b8 00 00 00 00       	mov    $0x0,%eax
    2ecc:	e8 c5 10 00 00       	call   3f96 <printf>
    exit();
    2ed1:	e8 2e 0f 00 00       	call   3e04 <exit>
  }
  
  for(; n > 0; n--){
    if(wait() < 0){
    2ed6:	e8 31 0f 00 00       	call   3e0c <wait>
    2edb:	85 c0                	test   %eax,%eax
    2edd:	79 1b                	jns    2efa <forktest+0x98>
      printf(1, "wait stopped early\n");
    2edf:	48 c7 c6 72 58 00 00 	mov    $0x5872,%rsi
    2ee6:	bf 01 00 00 00       	mov    $0x1,%edi
    2eeb:	b8 00 00 00 00       	mov    $0x0,%eax
    2ef0:	e8 a1 10 00 00       	call   3f96 <printf>
      exit();
    2ef5:	e8 0a 0f 00 00       	call   3e04 <exit>
  for(; n > 0; n--){
    2efa:	83 6d fc 01          	subl   $0x1,-0x4(%rbp)
    2efe:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    2f02:	7f d2                	jg     2ed6 <forktest+0x74>
    }
  }
  
  if(wait() != -1){
    2f04:	e8 03 0f 00 00       	call   3e0c <wait>
    2f09:	83 f8 ff             	cmp    $0xffffffff,%eax
    2f0c:	74 1b                	je     2f29 <forktest+0xc7>
    printf(1, "wait got too many\n");
    2f0e:	48 c7 c6 86 58 00 00 	mov    $0x5886,%rsi
    2f15:	bf 01 00 00 00       	mov    $0x1,%edi
    2f1a:	b8 00 00 00 00       	mov    $0x0,%eax
    2f1f:	e8 72 10 00 00       	call   3f96 <printf>
    exit();
    2f24:	e8 db 0e 00 00       	call   3e04 <exit>
  }
  
  printf(1, "fork test OK\n");
    2f29:	48 c7 c6 99 58 00 00 	mov    $0x5899,%rsi
    2f30:	bf 01 00 00 00       	mov    $0x1,%edi
    2f35:	b8 00 00 00 00       	mov    $0x0,%eax
    2f3a:	e8 57 10 00 00       	call   3f96 <printf>
}
    2f3f:	90                   	nop
    2f40:	c9                   	leave
    2f41:	c3                   	ret

0000000000002f42 <sbrktest>:

void
sbrktest(void)
{
    2f42:	55                   	push   %rbp
    2f43:	48 89 e5             	mov    %rsp,%rbp
    2f46:	48 81 ec 90 00 00 00 	sub    $0x90,%rsp
  int fds[2], pid, pids[10], ppid;
  char *a, *b, *c, *lastaddr, *oldbrk, *p, scratch;
  uint amt;

  printf(stdout, "sbrk test\n");
    2f4d:	8b 05 d5 33 00 00    	mov    0x33d5(%rip),%eax        # 6328 <stdout>
    2f53:	48 c7 c6 a7 58 00 00 	mov    $0x58a7,%rsi
    2f5a:	89 c7                	mov    %eax,%edi
    2f5c:	b8 00 00 00 00       	mov    $0x0,%eax
    2f61:	e8 30 10 00 00       	call   3f96 <printf>
  oldbrk = sbrk(0);
    2f66:	bf 00 00 00 00       	mov    $0x0,%edi
    2f6b:	e8 1c 0f 00 00       	call   3e8c <sbrk>
    2f70:	48 89 45 e8          	mov    %rax,-0x18(%rbp)

  // can one sbrk() less than a page?
  a = sbrk(0);
    2f74:	bf 00 00 00 00       	mov    $0x0,%edi
    2f79:	e8 0e 0f 00 00       	call   3e8c <sbrk>
    2f7e:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  int i;
  for(i = 0; i < 5000; i++){ 
    2f82:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
    2f89:	eb 5b                	jmp    2fe6 <sbrktest+0xa4>
    b = sbrk(1);
    2f8b:	bf 01 00 00 00       	mov    $0x1,%edi
    2f90:	e8 f7 0e 00 00       	call   3e8c <sbrk>
    2f95:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
    if(b != a){
    2f99:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
    2f9d:	48 3b 45 f8          	cmp    -0x8(%rbp),%rax
    2fa1:	74 2c                	je     2fcf <sbrktest+0x8d>
      printf(stdout, "sbrk test failed %d %x %x\n", i, a, b);
    2fa3:	8b 05 7f 33 00 00    	mov    0x337f(%rip),%eax        # 6328 <stdout>
    2fa9:	48 8b 75 b0          	mov    -0x50(%rbp),%rsi
    2fad:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
    2fb1:	8b 55 f4             	mov    -0xc(%rbp),%edx
    2fb4:	49 89 f0             	mov    %rsi,%r8
    2fb7:	48 c7 c6 b2 58 00 00 	mov    $0x58b2,%rsi
    2fbe:	89 c7                	mov    %eax,%edi
    2fc0:	b8 00 00 00 00       	mov    $0x0,%eax
    2fc5:	e8 cc 0f 00 00       	call   3f96 <printf>
      exit();
    2fca:	e8 35 0e 00 00       	call   3e04 <exit>
    }
    *b = 1;
    2fcf:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
    2fd3:	c6 00 01             	movb   $0x1,(%rax)
    a = b + 1;
    2fd6:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
    2fda:	48 83 c0 01          	add    $0x1,%rax
    2fde:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  for(i = 0; i < 5000; i++){ 
    2fe2:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
    2fe6:	81 7d f4 87 13 00 00 	cmpl   $0x1387,-0xc(%rbp)
    2fed:	7e 9c                	jle    2f8b <sbrktest+0x49>
  }
  pid = fork();
    2fef:	e8 08 0e 00 00       	call   3dfc <fork>
    2ff4:	89 45 e4             	mov    %eax,-0x1c(%rbp)
  if(pid < 0){
    2ff7:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
    2ffb:	79 1e                	jns    301b <sbrktest+0xd9>
    printf(stdout, "sbrk test fork failed\n");
    2ffd:	8b 05 25 33 00 00    	mov    0x3325(%rip),%eax        # 6328 <stdout>
    3003:	48 c7 c6 cd 58 00 00 	mov    $0x58cd,%rsi
    300a:	89 c7                	mov    %eax,%edi
    300c:	b8 00 00 00 00       	mov    $0x0,%eax
    3011:	e8 80 0f 00 00       	call   3f96 <printf>
    exit();
    3016:	e8 e9 0d 00 00       	call   3e04 <exit>
  }
  c = sbrk(1);
    301b:	bf 01 00 00 00       	mov    $0x1,%edi
    3020:	e8 67 0e 00 00       	call   3e8c <sbrk>
    3025:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
  c = sbrk(1);
    3029:	bf 01 00 00 00       	mov    $0x1,%edi
    302e:	e8 59 0e 00 00       	call   3e8c <sbrk>
    3033:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
  if(c != a + 1){
    3037:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    303b:	48 83 c0 01          	add    $0x1,%rax
    303f:	48 39 45 d8          	cmp    %rax,-0x28(%rbp)
    3043:	74 1e                	je     3063 <sbrktest+0x121>
    printf(stdout, "sbrk test failed post-fork\n");
    3045:	8b 05 dd 32 00 00    	mov    0x32dd(%rip),%eax        # 6328 <stdout>
    304b:	48 c7 c6 e4 58 00 00 	mov    $0x58e4,%rsi
    3052:	89 c7                	mov    %eax,%edi
    3054:	b8 00 00 00 00       	mov    $0x0,%eax
    3059:	e8 38 0f 00 00       	call   3f96 <printf>
    exit();
    305e:	e8 a1 0d 00 00       	call   3e04 <exit>
  }
  if(pid == 0)
    3063:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
    3067:	75 05                	jne    306e <sbrktest+0x12c>
    exit();
    3069:	e8 96 0d 00 00       	call   3e04 <exit>
  wait();
    306e:	e8 99 0d 00 00       	call   3e0c <wait>

  // can one grow address space to something big?
#define BIG (100*1024*1024)
  a = sbrk(0);
    3073:	bf 00 00 00 00       	mov    $0x0,%edi
    3078:	e8 0f 0e 00 00       	call   3e8c <sbrk>
    307d:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  amt = (BIG) - (uint)a;
    3081:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    3085:	89 c2                	mov    %eax,%edx
    3087:	b8 00 00 40 06       	mov    $0x6400000,%eax
    308c:	29 d0                	sub    %edx,%eax
    308e:	89 45 d4             	mov    %eax,-0x2c(%rbp)
  p = sbrk(amt);
    3091:	8b 45 d4             	mov    -0x2c(%rbp),%eax
    3094:	89 c7                	mov    %eax,%edi
    3096:	e8 f1 0d 00 00       	call   3e8c <sbrk>
    309b:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
  if (p != a) { 
    309f:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
    30a3:	48 3b 45 f8          	cmp    -0x8(%rbp),%rax
    30a7:	74 1e                	je     30c7 <sbrktest+0x185>
    printf(stdout, "sbrk test failed to grow big address space; enough phys mem?\n");
    30a9:	8b 05 79 32 00 00    	mov    0x3279(%rip),%eax        # 6328 <stdout>
    30af:	48 c7 c6 00 59 00 00 	mov    $0x5900,%rsi
    30b6:	89 c7                	mov    %eax,%edi
    30b8:	b8 00 00 00 00       	mov    $0x0,%eax
    30bd:	e8 d4 0e 00 00       	call   3f96 <printf>
    exit();
    30c2:	e8 3d 0d 00 00       	call   3e04 <exit>
  }
  lastaddr = (char*) (BIG-1);
    30c7:	48 c7 45 c0 ff ff 3f 	movq   $0x63fffff,-0x40(%rbp)
    30ce:	06 
  *lastaddr = 99;
    30cf:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
    30d3:	c6 00 63             	movb   $0x63,(%rax)

  // can one de-allocate?
  a = sbrk(0);
    30d6:	bf 00 00 00 00       	mov    $0x0,%edi
    30db:	e8 ac 0d 00 00       	call   3e8c <sbrk>
    30e0:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  c = sbrk(-4096);
    30e4:	bf 00 f0 ff ff       	mov    $0xfffff000,%edi
    30e9:	e8 9e 0d 00 00       	call   3e8c <sbrk>
    30ee:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
  if(c == (char*)0xffffffff){
    30f2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    30f7:	48 39 45 d8          	cmp    %rax,-0x28(%rbp)
    30fb:	75 1e                	jne    311b <sbrktest+0x1d9>
    printf(stdout, "sbrk could not deallocate\n");
    30fd:	8b 05 25 32 00 00    	mov    0x3225(%rip),%eax        # 6328 <stdout>
    3103:	48 c7 c6 3e 59 00 00 	mov    $0x593e,%rsi
    310a:	89 c7                	mov    %eax,%edi
    310c:	b8 00 00 00 00       	mov    $0x0,%eax
    3111:	e8 80 0e 00 00       	call   3f96 <printf>
    exit();
    3116:	e8 e9 0c 00 00       	call   3e04 <exit>
  }
  c = sbrk(0);
    311b:	bf 00 00 00 00       	mov    $0x0,%edi
    3120:	e8 67 0d 00 00       	call   3e8c <sbrk>
    3125:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
  if(c != a - 4096){
    3129:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    312d:	48 2d 00 10 00 00    	sub    $0x1000,%rax
    3133:	48 39 45 d8          	cmp    %rax,-0x28(%rbp)
    3137:	74 26                	je     315f <sbrktest+0x21d>
    printf(stdout, "sbrk deallocation produced wrong address, a %x c %x\n", a, c);
    3139:	8b 05 e9 31 00 00    	mov    0x31e9(%rip),%eax        # 6328 <stdout>
    313f:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
    3143:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
    3147:	48 c7 c6 60 59 00 00 	mov    $0x5960,%rsi
    314e:	89 c7                	mov    %eax,%edi
    3150:	b8 00 00 00 00       	mov    $0x0,%eax
    3155:	e8 3c 0e 00 00       	call   3f96 <printf>
    exit();
    315a:	e8 a5 0c 00 00       	call   3e04 <exit>
  }

  // can one re-allocate that page?
  a = sbrk(0);
    315f:	bf 00 00 00 00       	mov    $0x0,%edi
    3164:	e8 23 0d 00 00       	call   3e8c <sbrk>
    3169:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  c = sbrk(4096);
    316d:	bf 00 10 00 00       	mov    $0x1000,%edi
    3172:	e8 15 0d 00 00       	call   3e8c <sbrk>
    3177:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
  if(c != a || sbrk(0) != a + 4096){
    317b:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
    317f:	48 3b 45 f8          	cmp    -0x8(%rbp),%rax
    3183:	75 1a                	jne    319f <sbrktest+0x25d>
    3185:	bf 00 00 00 00       	mov    $0x0,%edi
    318a:	e8 fd 0c 00 00       	call   3e8c <sbrk>
    318f:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
    3193:	48 81 c2 00 10 00 00 	add    $0x1000,%rdx
    319a:	48 39 d0             	cmp    %rdx,%rax
    319d:	74 26                	je     31c5 <sbrktest+0x283>
    printf(stdout, "sbrk re-allocation failed, a %x c %x\n", a, c);
    319f:	8b 05 83 31 00 00    	mov    0x3183(%rip),%eax        # 6328 <stdout>
    31a5:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
    31a9:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
    31ad:	48 c7 c6 98 59 00 00 	mov    $0x5998,%rsi
    31b4:	89 c7                	mov    %eax,%edi
    31b6:	b8 00 00 00 00       	mov    $0x0,%eax
    31bb:	e8 d6 0d 00 00       	call   3f96 <printf>
    exit();
    31c0:	e8 3f 0c 00 00       	call   3e04 <exit>
  }
  if(*lastaddr == 99){
    31c5:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
    31c9:	0f b6 00             	movzbl (%rax),%eax
    31cc:	3c 63                	cmp    $0x63,%al
    31ce:	75 1e                	jne    31ee <sbrktest+0x2ac>
    // should be zero
    printf(stdout, "sbrk de-allocation didn't really deallocate\n");
    31d0:	8b 05 52 31 00 00    	mov    0x3152(%rip),%eax        # 6328 <stdout>
    31d6:	48 c7 c6 c0 59 00 00 	mov    $0x59c0,%rsi
    31dd:	89 c7                	mov    %eax,%edi
    31df:	b8 00 00 00 00       	mov    $0x0,%eax
    31e4:	e8 ad 0d 00 00       	call   3f96 <printf>
    exit();
    31e9:	e8 16 0c 00 00       	call   3e04 <exit>
  }

  a = sbrk(0);
    31ee:	bf 00 00 00 00       	mov    $0x0,%edi
    31f3:	e8 94 0c 00 00       	call   3e8c <sbrk>
    31f8:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  c = sbrk(-(sbrk(0) - oldbrk));
    31fc:	bf 00 00 00 00       	mov    $0x0,%edi
    3201:	e8 86 0c 00 00       	call   3e8c <sbrk>
    3206:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
    320a:	48 29 c2             	sub    %rax,%rdx
    320d:	89 d0                	mov    %edx,%eax
    320f:	89 c7                	mov    %eax,%edi
    3211:	e8 76 0c 00 00       	call   3e8c <sbrk>
    3216:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
  if(c != a){
    321a:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
    321e:	48 3b 45 f8          	cmp    -0x8(%rbp),%rax
    3222:	74 26                	je     324a <sbrktest+0x308>
    printf(stdout, "sbrk downsize failed, a %x c %x\n", a, c);
    3224:	8b 05 fe 30 00 00    	mov    0x30fe(%rip),%eax        # 6328 <stdout>
    322a:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
    322e:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
    3232:	48 c7 c6 f0 59 00 00 	mov    $0x59f0,%rsi
    3239:	89 c7                	mov    %eax,%edi
    323b:	b8 00 00 00 00       	mov    $0x0,%eax
    3240:	e8 51 0d 00 00       	call   3f96 <printf>
    exit();
    3245:	e8 ba 0b 00 00       	call   3e04 <exit>
  }
  
  // can we read the kernel's memory?
  for(a = (char*)(KERNBASE); a < (char*) (KERNBASE+2000000); a += 50000){
    324a:	48 c7 45 f8 00 00 00 	movq   $0xffffffff80000000,-0x8(%rbp)
    3251:	80 
    3252:	eb 7d                	jmp    32d1 <sbrktest+0x38f>
    ppid = getpid();
    3254:	e8 2b 0c 00 00       	call   3e84 <getpid>
    3259:	89 45 bc             	mov    %eax,-0x44(%rbp)
    pid = fork();
    325c:	e8 9b 0b 00 00       	call   3dfc <fork>
    3261:	89 45 e4             	mov    %eax,-0x1c(%rbp)
    if(pid < 0){
    3264:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
    3268:	79 1e                	jns    3288 <sbrktest+0x346>
      printf(stdout, "fork failed\n");
    326a:	8b 05 b8 30 00 00    	mov    0x30b8(%rip),%eax        # 6328 <stdout>
    3270:	48 c7 c6 91 49 00 00 	mov    $0x4991,%rsi
    3277:	89 c7                	mov    %eax,%edi
    3279:	b8 00 00 00 00       	mov    $0x0,%eax
    327e:	e8 13 0d 00 00       	call   3f96 <printf>
      exit();
    3283:	e8 7c 0b 00 00       	call   3e04 <exit>
    }
    if(pid == 0){
    3288:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
    328c:	75 36                	jne    32c4 <sbrktest+0x382>
      printf(stdout, "oops could read %x = %x\n", a, *a);
    328e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    3292:	0f b6 00             	movzbl (%rax),%eax
    3295:	0f be c8             	movsbl %al,%ecx
    3298:	8b 05 8a 30 00 00    	mov    0x308a(%rip),%eax        # 6328 <stdout>
    329e:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
    32a2:	48 c7 c6 11 5a 00 00 	mov    $0x5a11,%rsi
    32a9:	89 c7                	mov    %eax,%edi
    32ab:	b8 00 00 00 00       	mov    $0x0,%eax
    32b0:	e8 e1 0c 00 00       	call   3f96 <printf>
      kill(ppid);
    32b5:	8b 45 bc             	mov    -0x44(%rbp),%eax
    32b8:	89 c7                	mov    %eax,%edi
    32ba:	e8 75 0b 00 00       	call   3e34 <kill>
      exit();
    32bf:	e8 40 0b 00 00       	call   3e04 <exit>
    }
    wait();
    32c4:	e8 43 0b 00 00       	call   3e0c <wait>
  for(a = (char*)(KERNBASE); a < (char*) (KERNBASE+2000000); a += 50000){
    32c9:	48 81 45 f8 50 c3 00 	addq   $0xc350,-0x8(%rbp)
    32d0:	00 
    32d1:	48 81 7d f8 7f 84 1e 	cmpq   $0xffffffff801e847f,-0x8(%rbp)
    32d8:	80 
    32d9:	0f 86 75 ff ff ff    	jbe    3254 <sbrktest+0x312>
  }

  // if we run the system out of memory, does it clean up the last
  // failed allocation?
  if(pipe(fds) != 0){
    32df:	48 8d 45 a8          	lea    -0x58(%rbp),%rax
    32e3:	48 89 c7             	mov    %rax,%rdi
    32e6:	e8 29 0b 00 00       	call   3e14 <pipe>
    32eb:	85 c0                	test   %eax,%eax
    32ed:	74 1b                	je     330a <sbrktest+0x3c8>
    printf(1, "pipe() failed\n");
    32ef:	48 c7 c6 e5 48 00 00 	mov    $0x48e5,%rsi
    32f6:	bf 01 00 00 00       	mov    $0x1,%edi
    32fb:	b8 00 00 00 00       	mov    $0x0,%eax
    3300:	e8 91 0c 00 00       	call   3f96 <printf>
    exit();
    3305:	e8 fa 0a 00 00       	call   3e04 <exit>
  }
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    330a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
    3311:	e9 83 00 00 00       	jmp    3399 <sbrktest+0x457>
    if((pids[i] = fork()) == 0){
    3316:	e8 e1 0a 00 00       	call   3dfc <fork>
    331b:	8b 55 f4             	mov    -0xc(%rbp),%edx
    331e:	48 63 d2             	movslq %edx,%rdx
    3321:	89 44 95 80          	mov    %eax,-0x80(%rbp,%rdx,4)
    3325:	8b 45 f4             	mov    -0xc(%rbp),%eax
    3328:	48 98                	cltq
    332a:	8b 44 85 80          	mov    -0x80(%rbp,%rax,4),%eax
    332e:	85 c0                	test   %eax,%eax
    3330:	75 3c                	jne    336e <sbrktest+0x42c>
      // allocate a lot of memory
      sbrk(BIG - (uint)sbrk(0));
    3332:	bf 00 00 00 00       	mov    $0x0,%edi
    3337:	e8 50 0b 00 00       	call   3e8c <sbrk>
    333c:	89 c2                	mov    %eax,%edx
    333e:	b8 00 00 40 06       	mov    $0x6400000,%eax
    3343:	29 d0                	sub    %edx,%eax
    3345:	89 c7                	mov    %eax,%edi
    3347:	e8 40 0b 00 00       	call   3e8c <sbrk>
      write(fds[1], "x", 1);
    334c:	8b 45 ac             	mov    -0x54(%rbp),%eax
    334f:	ba 01 00 00 00       	mov    $0x1,%edx
    3354:	48 c7 c6 4a 49 00 00 	mov    $0x494a,%rsi
    335b:	89 c7                	mov    %eax,%edi
    335d:	e8 c2 0a 00 00       	call   3e24 <write>
      // sit around until killed
      for(;;) sleep(1000);
    3362:	bf e8 03 00 00       	mov    $0x3e8,%edi
    3367:	e8 28 0b 00 00       	call   3e94 <sleep>
    336c:	eb f4                	jmp    3362 <sbrktest+0x420>
    }
    if(pids[i] != -1)
    336e:	8b 45 f4             	mov    -0xc(%rbp),%eax
    3371:	48 98                	cltq
    3373:	8b 44 85 80          	mov    -0x80(%rbp,%rax,4),%eax
    3377:	83 f8 ff             	cmp    $0xffffffff,%eax
    337a:	74 19                	je     3395 <sbrktest+0x453>
      read(fds[0], &scratch, 1);
    337c:	8b 45 a8             	mov    -0x58(%rbp),%eax
    337f:	48 8d 8d 7f ff ff ff 	lea    -0x81(%rbp),%rcx
    3386:	ba 01 00 00 00       	mov    $0x1,%edx
    338b:	48 89 ce             	mov    %rcx,%rsi
    338e:	89 c7                	mov    %eax,%edi
    3390:	e8 87 0a 00 00       	call   3e1c <read>
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    3395:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
    3399:	8b 45 f4             	mov    -0xc(%rbp),%eax
    339c:	83 f8 09             	cmp    $0x9,%eax
    339f:	0f 86 71 ff ff ff    	jbe    3316 <sbrktest+0x3d4>
  }
  // if those failed allocations freed up the pages they did allocate,
  // we'll be able to allocate here
  c = sbrk(4096);
    33a5:	bf 00 10 00 00       	mov    $0x1000,%edi
    33aa:	e8 dd 0a 00 00       	call   3e8c <sbrk>
    33af:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    33b3:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
    33ba:	eb 2a                	jmp    33e6 <sbrktest+0x4a4>
    if(pids[i] == -1)
    33bc:	8b 45 f4             	mov    -0xc(%rbp),%eax
    33bf:	48 98                	cltq
    33c1:	8b 44 85 80          	mov    -0x80(%rbp,%rax,4),%eax
    33c5:	83 f8 ff             	cmp    $0xffffffff,%eax
    33c8:	74 17                	je     33e1 <sbrktest+0x49f>
      continue;
    kill(pids[i]);
    33ca:	8b 45 f4             	mov    -0xc(%rbp),%eax
    33cd:	48 98                	cltq
    33cf:	8b 44 85 80          	mov    -0x80(%rbp,%rax,4),%eax
    33d3:	89 c7                	mov    %eax,%edi
    33d5:	e8 5a 0a 00 00       	call   3e34 <kill>
    wait();
    33da:	e8 2d 0a 00 00       	call   3e0c <wait>
    33df:	eb 01                	jmp    33e2 <sbrktest+0x4a0>
      continue;
    33e1:	90                   	nop
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    33e2:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
    33e6:	8b 45 f4             	mov    -0xc(%rbp),%eax
    33e9:	83 f8 09             	cmp    $0x9,%eax
    33ec:	76 ce                	jbe    33bc <sbrktest+0x47a>
  }
  if(c == (char*)0xffffffff){
    33ee:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    33f3:	48 39 45 d8          	cmp    %rax,-0x28(%rbp)
    33f7:	75 1e                	jne    3417 <sbrktest+0x4d5>
    printf(stdout, "failed sbrk leaked memory\n");
    33f9:	8b 05 29 2f 00 00    	mov    0x2f29(%rip),%eax        # 6328 <stdout>
    33ff:	48 c7 c6 2a 5a 00 00 	mov    $0x5a2a,%rsi
    3406:	89 c7                	mov    %eax,%edi
    3408:	b8 00 00 00 00       	mov    $0x0,%eax
    340d:	e8 84 0b 00 00       	call   3f96 <printf>
    exit();
    3412:	e8 ed 09 00 00       	call   3e04 <exit>
  }

  if(sbrk(0) > oldbrk)
    3417:	bf 00 00 00 00       	mov    $0x0,%edi
    341c:	e8 6b 0a 00 00       	call   3e8c <sbrk>
    3421:	48 39 45 e8          	cmp    %rax,-0x18(%rbp)
    3425:	73 1a                	jae    3441 <sbrktest+0x4ff>
    sbrk(-(sbrk(0) - oldbrk));
    3427:	bf 00 00 00 00       	mov    $0x0,%edi
    342c:	e8 5b 0a 00 00       	call   3e8c <sbrk>
    3431:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
    3435:	48 29 c2             	sub    %rax,%rdx
    3438:	89 d0                	mov    %edx,%eax
    343a:	89 c7                	mov    %eax,%edi
    343c:	e8 4b 0a 00 00       	call   3e8c <sbrk>

  printf(stdout, "sbrk test OK\n");
    3441:	8b 05 e1 2e 00 00    	mov    0x2ee1(%rip),%eax        # 6328 <stdout>
    3447:	48 c7 c6 45 5a 00 00 	mov    $0x5a45,%rsi
    344e:	89 c7                	mov    %eax,%edi
    3450:	b8 00 00 00 00       	mov    $0x0,%eax
    3455:	e8 3c 0b 00 00       	call   3f96 <printf>
}
    345a:	90                   	nop
    345b:	c9                   	leave
    345c:	c3                   	ret

000000000000345d <validateint>:

void
validateint(int *p)
{
    345d:	55                   	push   %rbp
    345e:	48 89 e5             	mov    %rsp,%rbp
    3461:	48 83 ec 08          	sub    $0x8,%rsp
    3465:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
      "mov %%ebx, %%esp" :
      "=a" (res) :
      "a" (SYS_sleep), "n" (T_SYSCALL), "c" (p) :
      "ebx");
#endif
}
    3469:	90                   	nop
    346a:	c9                   	leave
    346b:	c3                   	ret

000000000000346c <validatetest>:

void
validatetest(void)
{
    346c:	55                   	push   %rbp
    346d:	48 89 e5             	mov    %rsp,%rbp
    3470:	48 83 ec 10          	sub    $0x10,%rsp
  int hi, pid;
  uint p;

  printf(stdout, "validate test\n");
    3474:	8b 05 ae 2e 00 00    	mov    0x2eae(%rip),%eax        # 6328 <stdout>
    347a:	48 c7 c6 53 5a 00 00 	mov    $0x5a53,%rsi
    3481:	89 c7                	mov    %eax,%edi
    3483:	b8 00 00 00 00       	mov    $0x0,%eax
    3488:	e8 09 0b 00 00       	call   3f96 <printf>
  hi = 1100*1024;
    348d:	c7 45 f8 00 30 11 00 	movl   $0x113000,-0x8(%rbp)

  for(p = 0; p <= (uint)hi; p += 4096){
    3494:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    349b:	eb 7d                	jmp    351a <validatetest+0xae>
    if((pid = fork()) == 0){
    349d:	e8 5a 09 00 00       	call   3dfc <fork>
    34a2:	89 45 f4             	mov    %eax,-0xc(%rbp)
    34a5:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
    34a9:	75 10                	jne    34bb <validatetest+0x4f>
      // try to crash the kernel by passing in a badly placed integer
      validateint((int*)p);
    34ab:	8b 45 fc             	mov    -0x4(%rbp),%eax
    34ae:	48 89 c7             	mov    %rax,%rdi
    34b1:	e8 a7 ff ff ff       	call   345d <validateint>
      exit();
    34b6:	e8 49 09 00 00       	call   3e04 <exit>
    }
    sleep(0);
    34bb:	bf 00 00 00 00       	mov    $0x0,%edi
    34c0:	e8 cf 09 00 00       	call   3e94 <sleep>
    sleep(0);
    34c5:	bf 00 00 00 00       	mov    $0x0,%edi
    34ca:	e8 c5 09 00 00       	call   3e94 <sleep>
    kill(pid);
    34cf:	8b 45 f4             	mov    -0xc(%rbp),%eax
    34d2:	89 c7                	mov    %eax,%edi
    34d4:	e8 5b 09 00 00       	call   3e34 <kill>
    wait();
    34d9:	e8 2e 09 00 00       	call   3e0c <wait>

    // try to crash the kernel by passing in a bad string pointer
    if(link("nosuchfile", (char*)p) != -1){
    34de:	8b 45 fc             	mov    -0x4(%rbp),%eax
    34e1:	48 89 c6             	mov    %rax,%rsi
    34e4:	48 c7 c7 62 5a 00 00 	mov    $0x5a62,%rdi
    34eb:	e8 74 09 00 00       	call   3e64 <link>
    34f0:	83 f8 ff             	cmp    $0xffffffff,%eax
    34f3:	74 1e                	je     3513 <validatetest+0xa7>
      printf(stdout, "link should not succeed\n");
    34f5:	8b 05 2d 2e 00 00    	mov    0x2e2d(%rip),%eax        # 6328 <stdout>
    34fb:	48 c7 c6 6d 5a 00 00 	mov    $0x5a6d,%rsi
    3502:	89 c7                	mov    %eax,%edi
    3504:	b8 00 00 00 00       	mov    $0x0,%eax
    3509:	e8 88 0a 00 00       	call   3f96 <printf>
      exit();
    350e:	e8 f1 08 00 00       	call   3e04 <exit>
  for(p = 0; p <= (uint)hi; p += 4096){
    3513:	81 45 fc 00 10 00 00 	addl   $0x1000,-0x4(%rbp)
    351a:	8b 45 f8             	mov    -0x8(%rbp),%eax
    351d:	3b 45 fc             	cmp    -0x4(%rbp),%eax
    3520:	0f 83 77 ff ff ff    	jae    349d <validatetest+0x31>
    }
  }

  printf(stdout, "validate ok\n");
    3526:	8b 05 fc 2d 00 00    	mov    0x2dfc(%rip),%eax        # 6328 <stdout>
    352c:	48 c7 c6 86 5a 00 00 	mov    $0x5a86,%rsi
    3533:	89 c7                	mov    %eax,%edi
    3535:	b8 00 00 00 00       	mov    $0x0,%eax
    353a:	e8 57 0a 00 00       	call   3f96 <printf>
}
    353f:	90                   	nop
    3540:	c9                   	leave
    3541:	c3                   	ret

0000000000003542 <bsstest>:

// does unintialized data start out zero?
char uninit[10000];
void
bsstest(void)
{
    3542:	55                   	push   %rbp
    3543:	48 89 e5             	mov    %rsp,%rbp
    3546:	48 83 ec 10          	sub    $0x10,%rsp
  int i;

  printf(stdout, "bss test\n");
    354a:	8b 05 d8 2d 00 00    	mov    0x2dd8(%rip),%eax        # 6328 <stdout>
    3550:	48 c7 c6 93 5a 00 00 	mov    $0x5a93,%rsi
    3557:	89 c7                	mov    %eax,%edi
    3559:	b8 00 00 00 00       	mov    $0x0,%eax
    355e:	e8 33 0a 00 00       	call   3f96 <printf>
  for(i = 0; i < sizeof(uninit); i++){
    3563:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    356a:	eb 32                	jmp    359e <bsstest+0x5c>
    if(uninit[i] != '\0'){
    356c:	8b 45 fc             	mov    -0x4(%rbp),%eax
    356f:	48 98                	cltq
    3571:	0f b6 80 80 83 00 00 	movzbl 0x8380(%rax),%eax
    3578:	84 c0                	test   %al,%al
    357a:	74 1e                	je     359a <bsstest+0x58>
      printf(stdout, "bss test failed\n");
    357c:	8b 05 a6 2d 00 00    	mov    0x2da6(%rip),%eax        # 6328 <stdout>
    3582:	48 c7 c6 9d 5a 00 00 	mov    $0x5a9d,%rsi
    3589:	89 c7                	mov    %eax,%edi
    358b:	b8 00 00 00 00       	mov    $0x0,%eax
    3590:	e8 01 0a 00 00       	call   3f96 <printf>
      exit();
    3595:	e8 6a 08 00 00       	call   3e04 <exit>
  for(i = 0; i < sizeof(uninit); i++){
    359a:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    359e:	8b 45 fc             	mov    -0x4(%rbp),%eax
    35a1:	3d 0f 27 00 00       	cmp    $0x270f,%eax
    35a6:	76 c4                	jbe    356c <bsstest+0x2a>
    }
  }
  printf(stdout, "bss test ok\n");
    35a8:	8b 05 7a 2d 00 00    	mov    0x2d7a(%rip),%eax        # 6328 <stdout>
    35ae:	48 c7 c6 ae 5a 00 00 	mov    $0x5aae,%rsi
    35b5:	89 c7                	mov    %eax,%edi
    35b7:	b8 00 00 00 00       	mov    $0x0,%eax
    35bc:	e8 d5 09 00 00       	call   3f96 <printf>
}
    35c1:	90                   	nop
    35c2:	c9                   	leave
    35c3:	c3                   	ret

00000000000035c4 <bigargtest>:
// does exec return an error if the arguments
// are larger than a page? or does it write
// below the stack and wreck the instructions/data?
void
bigargtest(void)
{
    35c4:	55                   	push   %rbp
    35c5:	48 89 e5             	mov    %rsp,%rbp
    35c8:	48 83 ec 10          	sub    $0x10,%rsp
  int pid, fd;

  unlink("bigarg-ok");
    35cc:	48 c7 c7 bb 5a 00 00 	mov    $0x5abb,%rdi
    35d3:	e8 7c 08 00 00       	call   3e54 <unlink>
  pid = fork();
    35d8:	e8 1f 08 00 00       	call   3dfc <fork>
    35dd:	89 45 f8             	mov    %eax,-0x8(%rbp)
  if(pid == 0){
    35e0:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
    35e4:	0f 85 97 00 00 00    	jne    3681 <bigargtest+0xbd>
    static char *args[MAXARG];
    int i;
    for(i = 0; i < MAXARG-1; i++)
    35ea:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    35f1:	eb 15                	jmp    3608 <bigargtest+0x44>
      args[i] = "bigargs test: failed\n                                                                                                                                                                                                       ";
    35f3:	8b 45 fc             	mov    -0x4(%rbp),%eax
    35f6:	48 98                	cltq
    35f8:	48 c7 04 c5 a0 aa 00 	movq   $0x5ac8,0xaaa0(,%rax,8)
    35ff:	00 c8 5a 00 00 
    for(i = 0; i < MAXARG-1; i++)
    3604:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    3608:	83 7d fc 1e          	cmpl   $0x1e,-0x4(%rbp)
    360c:	7e e5                	jle    35f3 <bigargtest+0x2f>
    args[MAXARG-1] = 0;
    360e:	48 c7 05 7f 75 00 00 	movq   $0x0,0x757f(%rip)        # ab98 <args.0+0xf8>
    3615:	00 00 00 00 
    printf(stdout, "bigarg test\n");
    3619:	8b 05 09 2d 00 00    	mov    0x2d09(%rip),%eax        # 6328 <stdout>
    361f:	48 c7 c6 a5 5b 00 00 	mov    $0x5ba5,%rsi
    3626:	89 c7                	mov    %eax,%edi
    3628:	b8 00 00 00 00       	mov    $0x0,%eax
    362d:	e8 64 09 00 00       	call   3f96 <printf>
    exec("echo", args);
    3632:	48 c7 c6 a0 aa 00 00 	mov    $0xaaa0,%rsi
    3639:	48 c7 c7 a0 45 00 00 	mov    $0x45a0,%rdi
    3640:	e8 f7 07 00 00       	call   3e3c <exec>
    printf(stdout, "bigarg test ok\n");
    3645:	8b 05 dd 2c 00 00    	mov    0x2cdd(%rip),%eax        # 6328 <stdout>
    364b:	48 c7 c6 b2 5b 00 00 	mov    $0x5bb2,%rsi
    3652:	89 c7                	mov    %eax,%edi
    3654:	b8 00 00 00 00       	mov    $0x0,%eax
    3659:	e8 38 09 00 00       	call   3f96 <printf>
    fd = open("bigarg-ok", O_CREATE);
    365e:	be 00 02 00 00       	mov    $0x200,%esi
    3663:	48 c7 c7 bb 5a 00 00 	mov    $0x5abb,%rdi
    366a:	e8 d5 07 00 00       	call   3e44 <open>
    366f:	89 45 f4             	mov    %eax,-0xc(%rbp)
    close(fd);
    3672:	8b 45 f4             	mov    -0xc(%rbp),%eax
    3675:	89 c7                	mov    %eax,%edi
    3677:	e8 b0 07 00 00       	call   3e2c <close>
    exit();
    367c:	e8 83 07 00 00       	call   3e04 <exit>
  } else if(pid < 0){
    3681:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
    3685:	79 1e                	jns    36a5 <bigargtest+0xe1>
    printf(stdout, "bigargtest: fork failed\n");
    3687:	8b 05 9b 2c 00 00    	mov    0x2c9b(%rip),%eax        # 6328 <stdout>
    368d:	48 c7 c6 c2 5b 00 00 	mov    $0x5bc2,%rsi
    3694:	89 c7                	mov    %eax,%edi
    3696:	b8 00 00 00 00       	mov    $0x0,%eax
    369b:	e8 f6 08 00 00       	call   3f96 <printf>
    exit();
    36a0:	e8 5f 07 00 00       	call   3e04 <exit>
  }
  wait();
    36a5:	e8 62 07 00 00       	call   3e0c <wait>
  fd = open("bigarg-ok", 0);
    36aa:	be 00 00 00 00       	mov    $0x0,%esi
    36af:	48 c7 c7 bb 5a 00 00 	mov    $0x5abb,%rdi
    36b6:	e8 89 07 00 00       	call   3e44 <open>
    36bb:	89 45 f4             	mov    %eax,-0xc(%rbp)
  if(fd < 0){
    36be:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
    36c2:	79 1e                	jns    36e2 <bigargtest+0x11e>
    printf(stdout, "bigarg test failed!\n");
    36c4:	8b 05 5e 2c 00 00    	mov    0x2c5e(%rip),%eax        # 6328 <stdout>
    36ca:	48 c7 c6 db 5b 00 00 	mov    $0x5bdb,%rsi
    36d1:	89 c7                	mov    %eax,%edi
    36d3:	b8 00 00 00 00       	mov    $0x0,%eax
    36d8:	e8 b9 08 00 00       	call   3f96 <printf>
    exit();
    36dd:	e8 22 07 00 00       	call   3e04 <exit>
  }
  close(fd);
    36e2:	8b 45 f4             	mov    -0xc(%rbp),%eax
    36e5:	89 c7                	mov    %eax,%edi
    36e7:	e8 40 07 00 00       	call   3e2c <close>
  unlink("bigarg-ok");
    36ec:	48 c7 c7 bb 5a 00 00 	mov    $0x5abb,%rdi
    36f3:	e8 5c 07 00 00       	call   3e54 <unlink>
}
    36f8:	90                   	nop
    36f9:	c9                   	leave
    36fa:	c3                   	ret

00000000000036fb <fsfull>:

// what happens when the file system runs out of blocks?
// answer: balloc panics, so this test is not useful.
void
fsfull()
{
    36fb:	55                   	push   %rbp
    36fc:	48 89 e5             	mov    %rsp,%rbp
    36ff:	48 83 ec 60          	sub    $0x60,%rsp
  int nfiles;
  int fsblocks = 0;
    3703:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)

  printf(1, "fsfull test\n");
    370a:	48 c7 c6 f0 5b 00 00 	mov    $0x5bf0,%rsi
    3711:	bf 01 00 00 00       	mov    $0x1,%edi
    3716:	b8 00 00 00 00       	mov    $0x0,%eax
    371b:	e8 76 08 00 00       	call   3f96 <printf>

  for(nfiles = 0; ; nfiles++){
    3720:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    char name[64];
    name[0] = 'f';
    3727:	c6 45 a0 66          	movb   $0x66,-0x60(%rbp)
    name[1] = '0' + nfiles / 1000;
    372b:	8b 45 fc             	mov    -0x4(%rbp),%eax
    372e:	48 63 d0             	movslq %eax,%rdx
    3731:	48 69 d2 d3 4d 62 10 	imul   $0x10624dd3,%rdx,%rdx
    3738:	48 c1 ea 20          	shr    $0x20,%rdx
    373c:	c1 fa 06             	sar    $0x6,%edx
    373f:	c1 f8 1f             	sar    $0x1f,%eax
    3742:	29 c2                	sub    %eax,%edx
    3744:	89 d0                	mov    %edx,%eax
    3746:	83 c0 30             	add    $0x30,%eax
    3749:	88 45 a1             	mov    %al,-0x5f(%rbp)
    name[2] = '0' + (nfiles % 1000) / 100;
    374c:	8b 55 fc             	mov    -0x4(%rbp),%edx
    374f:	48 63 c2             	movslq %edx,%rax
    3752:	48 69 c0 d3 4d 62 10 	imul   $0x10624dd3,%rax,%rax
    3759:	48 c1 e8 20          	shr    $0x20,%rax
    375d:	c1 f8 06             	sar    $0x6,%eax
    3760:	89 d1                	mov    %edx,%ecx
    3762:	c1 f9 1f             	sar    $0x1f,%ecx
    3765:	29 c8                	sub    %ecx,%eax
    3767:	69 c8 e8 03 00 00    	imul   $0x3e8,%eax,%ecx
    376d:	89 d0                	mov    %edx,%eax
    376f:	29 c8                	sub    %ecx,%eax
    3771:	48 63 d0             	movslq %eax,%rdx
    3774:	48 69 d2 1f 85 eb 51 	imul   $0x51eb851f,%rdx,%rdx
    377b:	48 c1 ea 20          	shr    $0x20,%rdx
    377f:	c1 fa 05             	sar    $0x5,%edx
    3782:	c1 f8 1f             	sar    $0x1f,%eax
    3785:	29 c2                	sub    %eax,%edx
    3787:	89 d0                	mov    %edx,%eax
    3789:	83 c0 30             	add    $0x30,%eax
    378c:	88 45 a2             	mov    %al,-0x5e(%rbp)
    name[3] = '0' + (nfiles % 100) / 10;
    378f:	8b 55 fc             	mov    -0x4(%rbp),%edx
    3792:	48 63 c2             	movslq %edx,%rax
    3795:	48 69 c0 1f 85 eb 51 	imul   $0x51eb851f,%rax,%rax
    379c:	48 c1 e8 20          	shr    $0x20,%rax
    37a0:	c1 f8 05             	sar    $0x5,%eax
    37a3:	89 d1                	mov    %edx,%ecx
    37a5:	c1 f9 1f             	sar    $0x1f,%ecx
    37a8:	29 c8                	sub    %ecx,%eax
    37aa:	6b c8 64             	imul   $0x64,%eax,%ecx
    37ad:	89 d0                	mov    %edx,%eax
    37af:	29 c8                	sub    %ecx,%eax
    37b1:	48 63 d0             	movslq %eax,%rdx
    37b4:	48 69 d2 67 66 66 66 	imul   $0x66666667,%rdx,%rdx
    37bb:	48 c1 ea 20          	shr    $0x20,%rdx
    37bf:	c1 fa 02             	sar    $0x2,%edx
    37c2:	c1 f8 1f             	sar    $0x1f,%eax
    37c5:	29 c2                	sub    %eax,%edx
    37c7:	89 d0                	mov    %edx,%eax
    37c9:	83 c0 30             	add    $0x30,%eax
    37cc:	88 45 a3             	mov    %al,-0x5d(%rbp)
    name[4] = '0' + (nfiles % 10);
    37cf:	8b 4d fc             	mov    -0x4(%rbp),%ecx
    37d2:	48 63 c1             	movslq %ecx,%rax
    37d5:	48 69 c0 67 66 66 66 	imul   $0x66666667,%rax,%rax
    37dc:	48 c1 e8 20          	shr    $0x20,%rax
    37e0:	89 c2                	mov    %eax,%edx
    37e2:	c1 fa 02             	sar    $0x2,%edx
    37e5:	89 c8                	mov    %ecx,%eax
    37e7:	c1 f8 1f             	sar    $0x1f,%eax
    37ea:	29 c2                	sub    %eax,%edx
    37ec:	89 d0                	mov    %edx,%eax
    37ee:	c1 e0 02             	shl    $0x2,%eax
    37f1:	01 d0                	add    %edx,%eax
    37f3:	01 c0                	add    %eax,%eax
    37f5:	29 c1                	sub    %eax,%ecx
    37f7:	89 ca                	mov    %ecx,%edx
    37f9:	89 d0                	mov    %edx,%eax
    37fb:	83 c0 30             	add    $0x30,%eax
    37fe:	88 45 a4             	mov    %al,-0x5c(%rbp)
    name[5] = '\0';
    3801:	c6 45 a5 00          	movb   $0x0,-0x5b(%rbp)
    printf(1, "writing %s\n", name);
    3805:	48 8d 45 a0          	lea    -0x60(%rbp),%rax
    3809:	48 89 c2             	mov    %rax,%rdx
    380c:	48 c7 c6 fd 5b 00 00 	mov    $0x5bfd,%rsi
    3813:	bf 01 00 00 00       	mov    $0x1,%edi
    3818:	b8 00 00 00 00       	mov    $0x0,%eax
    381d:	e8 74 07 00 00       	call   3f96 <printf>
    int fd = open(name, O_CREATE|O_RDWR);
    3822:	48 8d 45 a0          	lea    -0x60(%rbp),%rax
    3826:	be 02 02 00 00       	mov    $0x202,%esi
    382b:	48 89 c7             	mov    %rax,%rdi
    382e:	e8 11 06 00 00       	call   3e44 <open>
    3833:	89 45 f0             	mov    %eax,-0x10(%rbp)
    if(fd < 0){
    3836:	83 7d f0 00          	cmpl   $0x0,-0x10(%rbp)
    383a:	79 1f                	jns    385b <fsfull+0x160>
      printf(1, "open %s failed\n", name);
    383c:	48 8d 45 a0          	lea    -0x60(%rbp),%rax
    3840:	48 89 c2             	mov    %rax,%rdx
    3843:	48 c7 c6 09 5c 00 00 	mov    $0x5c09,%rsi
    384a:	bf 01 00 00 00       	mov    $0x1,%edi
    384f:	b8 00 00 00 00       	mov    $0x0,%eax
    3854:	e8 3d 07 00 00       	call   3f96 <printf>
      break;
    3859:	eb 6b                	jmp    38c6 <fsfull+0x1cb>
    }
    int total = 0;
    385b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
    while(1){
      int cc = write(fd, buf, 512);
    3862:	8b 45 f0             	mov    -0x10(%rbp),%eax
    3865:	ba 00 02 00 00       	mov    $0x200,%edx
    386a:	48 c7 c6 60 63 00 00 	mov    $0x6360,%rsi
    3871:	89 c7                	mov    %eax,%edi
    3873:	e8 ac 05 00 00       	call   3e24 <write>
    3878:	89 45 ec             	mov    %eax,-0x14(%rbp)
      if(cc < 512)
    387b:	81 7d ec ff 01 00 00 	cmpl   $0x1ff,-0x14(%rbp)
    3882:	7e 0c                	jle    3890 <fsfull+0x195>
        break;
      total += cc;
    3884:	8b 45 ec             	mov    -0x14(%rbp),%eax
    3887:	01 45 f4             	add    %eax,-0xc(%rbp)
      fsblocks++;
    388a:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
    while(1){
    388e:	eb d2                	jmp    3862 <fsfull+0x167>
        break;
    3890:	90                   	nop
    }
    printf(1, "wrote %d bytes\n", total);
    3891:	8b 45 f4             	mov    -0xc(%rbp),%eax
    3894:	89 c2                	mov    %eax,%edx
    3896:	48 c7 c6 19 5c 00 00 	mov    $0x5c19,%rsi
    389d:	bf 01 00 00 00       	mov    $0x1,%edi
    38a2:	b8 00 00 00 00       	mov    $0x0,%eax
    38a7:	e8 ea 06 00 00       	call   3f96 <printf>
    close(fd);
    38ac:	8b 45 f0             	mov    -0x10(%rbp),%eax
    38af:	89 c7                	mov    %eax,%edi
    38b1:	e8 76 05 00 00       	call   3e2c <close>
    if(total == 0)
    38b6:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
    38ba:	74 09                	je     38c5 <fsfull+0x1ca>
  for(nfiles = 0; ; nfiles++){
    38bc:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    38c0:	e9 62 fe ff ff       	jmp    3727 <fsfull+0x2c>
      break;
    38c5:	90                   	nop
  }

  while(nfiles >= 0){
    38c6:	e9 ee 00 00 00       	jmp    39b9 <fsfull+0x2be>
    char name[64];
    name[0] = 'f';
    38cb:	c6 45 a0 66          	movb   $0x66,-0x60(%rbp)
    name[1] = '0' + nfiles / 1000;
    38cf:	8b 45 fc             	mov    -0x4(%rbp),%eax
    38d2:	48 63 d0             	movslq %eax,%rdx
    38d5:	48 69 d2 d3 4d 62 10 	imul   $0x10624dd3,%rdx,%rdx
    38dc:	48 c1 ea 20          	shr    $0x20,%rdx
    38e0:	c1 fa 06             	sar    $0x6,%edx
    38e3:	c1 f8 1f             	sar    $0x1f,%eax
    38e6:	29 c2                	sub    %eax,%edx
    38e8:	89 d0                	mov    %edx,%eax
    38ea:	83 c0 30             	add    $0x30,%eax
    38ed:	88 45 a1             	mov    %al,-0x5f(%rbp)
    name[2] = '0' + (nfiles % 1000) / 100;
    38f0:	8b 55 fc             	mov    -0x4(%rbp),%edx
    38f3:	48 63 c2             	movslq %edx,%rax
    38f6:	48 69 c0 d3 4d 62 10 	imul   $0x10624dd3,%rax,%rax
    38fd:	48 c1 e8 20          	shr    $0x20,%rax
    3901:	c1 f8 06             	sar    $0x6,%eax
    3904:	89 d1                	mov    %edx,%ecx
    3906:	c1 f9 1f             	sar    $0x1f,%ecx
    3909:	29 c8                	sub    %ecx,%eax
    390b:	69 c8 e8 03 00 00    	imul   $0x3e8,%eax,%ecx
    3911:	89 d0                	mov    %edx,%eax
    3913:	29 c8                	sub    %ecx,%eax
    3915:	48 63 d0             	movslq %eax,%rdx
    3918:	48 69 d2 1f 85 eb 51 	imul   $0x51eb851f,%rdx,%rdx
    391f:	48 c1 ea 20          	shr    $0x20,%rdx
    3923:	c1 fa 05             	sar    $0x5,%edx
    3926:	c1 f8 1f             	sar    $0x1f,%eax
    3929:	29 c2                	sub    %eax,%edx
    392b:	89 d0                	mov    %edx,%eax
    392d:	83 c0 30             	add    $0x30,%eax
    3930:	88 45 a2             	mov    %al,-0x5e(%rbp)
    name[3] = '0' + (nfiles % 100) / 10;
    3933:	8b 55 fc             	mov    -0x4(%rbp),%edx
    3936:	48 63 c2             	movslq %edx,%rax
    3939:	48 69 c0 1f 85 eb 51 	imul   $0x51eb851f,%rax,%rax
    3940:	48 c1 e8 20          	shr    $0x20,%rax
    3944:	c1 f8 05             	sar    $0x5,%eax
    3947:	89 d1                	mov    %edx,%ecx
    3949:	c1 f9 1f             	sar    $0x1f,%ecx
    394c:	29 c8                	sub    %ecx,%eax
    394e:	6b c8 64             	imul   $0x64,%eax,%ecx
    3951:	89 d0                	mov    %edx,%eax
    3953:	29 c8                	sub    %ecx,%eax
    3955:	48 63 d0             	movslq %eax,%rdx
    3958:	48 69 d2 67 66 66 66 	imul   $0x66666667,%rdx,%rdx
    395f:	48 c1 ea 20          	shr    $0x20,%rdx
    3963:	c1 fa 02             	sar    $0x2,%edx
    3966:	c1 f8 1f             	sar    $0x1f,%eax
    3969:	29 c2                	sub    %eax,%edx
    396b:	89 d0                	mov    %edx,%eax
    396d:	83 c0 30             	add    $0x30,%eax
    3970:	88 45 a3             	mov    %al,-0x5d(%rbp)
    name[4] = '0' + (nfiles % 10);
    3973:	8b 4d fc             	mov    -0x4(%rbp),%ecx
    3976:	48 63 c1             	movslq %ecx,%rax
    3979:	48 69 c0 67 66 66 66 	imul   $0x66666667,%rax,%rax
    3980:	48 c1 e8 20          	shr    $0x20,%rax
    3984:	89 c2                	mov    %eax,%edx
    3986:	c1 fa 02             	sar    $0x2,%edx
    3989:	89 c8                	mov    %ecx,%eax
    398b:	c1 f8 1f             	sar    $0x1f,%eax
    398e:	29 c2                	sub    %eax,%edx
    3990:	89 d0                	mov    %edx,%eax
    3992:	c1 e0 02             	shl    $0x2,%eax
    3995:	01 d0                	add    %edx,%eax
    3997:	01 c0                	add    %eax,%eax
    3999:	29 c1                	sub    %eax,%ecx
    399b:	89 ca                	mov    %ecx,%edx
    399d:	89 d0                	mov    %edx,%eax
    399f:	83 c0 30             	add    $0x30,%eax
    39a2:	88 45 a4             	mov    %al,-0x5c(%rbp)
    name[5] = '\0';
    39a5:	c6 45 a5 00          	movb   $0x0,-0x5b(%rbp)
    unlink(name);
    39a9:	48 8d 45 a0          	lea    -0x60(%rbp),%rax
    39ad:	48 89 c7             	mov    %rax,%rdi
    39b0:	e8 9f 04 00 00       	call   3e54 <unlink>
    nfiles--;
    39b5:	83 6d fc 01          	subl   $0x1,-0x4(%rbp)
  while(nfiles >= 0){
    39b9:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    39bd:	0f 89 08 ff ff ff    	jns    38cb <fsfull+0x1d0>
  }

  printf(1, "fsfull test finished\n");
    39c3:	48 c7 c6 29 5c 00 00 	mov    $0x5c29,%rsi
    39ca:	bf 01 00 00 00       	mov    $0x1,%edi
    39cf:	b8 00 00 00 00       	mov    $0x0,%eax
    39d4:	e8 bd 05 00 00       	call   3f96 <printf>
}
    39d9:	90                   	nop
    39da:	c9                   	leave
    39db:	c3                   	ret

00000000000039dc <rand>:

unsigned long randstate = 1;
unsigned int
rand()
{
    39dc:	55                   	push   %rbp
    39dd:	48 89 e5             	mov    %rsp,%rbp
  randstate = randstate * 1664525 + 1013904223;
    39e0:	48 8b 05 49 29 00 00 	mov    0x2949(%rip),%rax        # 6330 <randstate>
    39e7:	48 69 c0 0d 66 19 00 	imul   $0x19660d,%rax,%rax
    39ee:	48 05 5f f3 6e 3c    	add    $0x3c6ef35f,%rax
    39f4:	48 89 05 35 29 00 00 	mov    %rax,0x2935(%rip)        # 6330 <randstate>
  return randstate;
    39fb:	48 8b 05 2e 29 00 00 	mov    0x292e(%rip),%rax        # 6330 <randstate>
}
    3a02:	5d                   	pop    %rbp
    3a03:	c3                   	ret

0000000000003a04 <main>:

int
main(int argc, char *argv[])
{
    3a04:	55                   	push   %rbp
    3a05:	48 89 e5             	mov    %rsp,%rbp
    3a08:	48 83 ec 10          	sub    $0x10,%rsp
    3a0c:	89 7d fc             	mov    %edi,-0x4(%rbp)
    3a0f:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  printf(1, "usertests starting\n");
    3a13:	48 c7 c6 3f 5c 00 00 	mov    $0x5c3f,%rsi
    3a1a:	bf 01 00 00 00       	mov    $0x1,%edi
    3a1f:	b8 00 00 00 00       	mov    $0x0,%eax
    3a24:	e8 6d 05 00 00       	call   3f96 <printf>

  if(open("usertests.ran", 0) >= 0){
    3a29:	be 00 00 00 00       	mov    $0x0,%esi
    3a2e:	48 c7 c7 53 5c 00 00 	mov    $0x5c53,%rdi
    3a35:	e8 0a 04 00 00       	call   3e44 <open>
    3a3a:	85 c0                	test   %eax,%eax
    3a3c:	78 1b                	js     3a59 <main+0x55>
    printf(1, "already ran user tests -- rebuild fs.img\n");
    3a3e:	48 c7 c6 68 5c 00 00 	mov    $0x5c68,%rsi
    3a45:	bf 01 00 00 00       	mov    $0x1,%edi
    3a4a:	b8 00 00 00 00       	mov    $0x0,%eax
    3a4f:	e8 42 05 00 00       	call   3f96 <printf>
    exit();
    3a54:	e8 ab 03 00 00       	call   3e04 <exit>
  }
  close(open("usertests.ran", O_CREATE));
    3a59:	be 00 02 00 00       	mov    $0x200,%esi
    3a5e:	48 c7 c7 53 5c 00 00 	mov    $0x5c53,%rdi
    3a65:	e8 da 03 00 00       	call   3e44 <open>
    3a6a:	89 c7                	mov    %eax,%edi
    3a6c:	e8 bb 03 00 00       	call   3e2c <close>

  bigargtest();
    3a71:	e8 4e fb ff ff       	call   35c4 <bigargtest>
  bigwrite();
    3a76:	e8 63 ea ff ff       	call   24de <bigwrite>
  bigargtest();
    3a7b:	e8 44 fb ff ff       	call   35c4 <bigargtest>
  bsstest();
    3a80:	e8 bd fa ff ff       	call   3542 <bsstest>
  sbrktest();
    3a85:	e8 b8 f4 ff ff       	call   2f42 <sbrktest>
  validatetest();
    3a8a:	e8 dd f9 ff ff       	call   346c <validatetest>

  opentest();
    3a8f:	e8 6c c5 ff ff       	call   0 <opentest>
  writetest();
    3a94:	e8 1e c6 ff ff       	call   b7 <writetest>
  writetest1();
    3a99:	e8 42 c8 ff ff       	call   2e0 <writetest1>
  createtest();
    3a9e:	e8 4d ca ff ff       	call   4f0 <createtest>

  mem();
    3aa3:	e8 1e d0 ff ff       	call   ac6 <mem>
  pipe1();
    3aa8:	e8 4a cc ff ff       	call   6f7 <pipe1>
  preempt();
    3aad:	e8 34 ce ff ff       	call   8e6 <preempt>
  exitwait();
    3ab2:	e8 89 cf ff ff       	call   a40 <exitwait>

  rmdot();
    3ab7:	e8 af ee ff ff       	call   296b <rmdot>
  fourteen();
    3abc:	e8 49 ed ff ff       	call   280a <fourteen>
  bigfile();
    3ac1:	e8 1d eb ff ff       	call   25e3 <bigfile>
  subdir();
    3ac6:	e8 b9 e2 ff ff       	call   1d84 <subdir>
  concreate();
    3acb:	e8 1d dc ff ff       	call   16ed <concreate>
  linkunlink();
    3ad0:	b8 00 00 00 00       	mov    $0x0,%eax
    3ad5:	e8 e5 df ff ff       	call   1abf <linkunlink>
  linktest();
    3ada:	e8 c5 d9 ff ff       	call   14a4 <linktest>
  unlinkread();
    3adf:	e8 f8 d7 ff ff       	call   12dc <unlinkread>
  createdelete();
    3ae4:	e8 33 d5 ff ff       	call   101c <createdelete>
  twofiles();
    3ae9:	e8 c5 d2 ff ff       	call   db3 <twofiles>
  sharedfd();
    3aee:	e8 ce d0 ff ff       	call   bc1 <sharedfd>
  dirfile();
    3af3:	e8 fe ef ff ff       	call   2af6 <dirfile>
  iref();
    3af8:	e8 3f f2 ff ff       	call   2d3c <iref>
  forktest();
    3afd:	e8 60 f3 ff ff       	call   2e62 <forktest>
  bigdir(); // slow
    3b02:	e8 fa e0 ff ff       	call   1c01 <bigdir>

  exectest();
    3b07:	e8 96 cb ff ff       	call   6a2 <exectest>

  exit();
    3b0c:	e8 f3 02 00 00       	call   3e04 <exit>

0000000000003b11 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
    3b11:	55                   	push   %rbp
    3b12:	48 89 e5             	mov    %rsp,%rbp
    3b15:	48 83 ec 10          	sub    $0x10,%rsp
    3b19:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    3b1d:	89 75 f4             	mov    %esi,-0xc(%rbp)
    3b20:	89 55 f0             	mov    %edx,-0x10(%rbp)
  asm volatile("cld; rep stosb" :
    3b23:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
    3b27:	8b 55 f0             	mov    -0x10(%rbp),%edx
    3b2a:	8b 45 f4             	mov    -0xc(%rbp),%eax
    3b2d:	48 89 ce             	mov    %rcx,%rsi
    3b30:	48 89 f7             	mov    %rsi,%rdi
    3b33:	89 d1                	mov    %edx,%ecx
    3b35:	fc                   	cld
    3b36:	f3 aa                	rep stos %al,%es:(%rdi)
    3b38:	89 ca                	mov    %ecx,%edx
    3b3a:	48 89 fe             	mov    %rdi,%rsi
    3b3d:	48 89 75 f8          	mov    %rsi,-0x8(%rbp)
    3b41:	89 55 f0             	mov    %edx,-0x10(%rbp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
    3b44:	90                   	nop
    3b45:	c9                   	leave
    3b46:	c3                   	ret

0000000000003b47 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
    3b47:	55                   	push   %rbp
    3b48:	48 89 e5             	mov    %rsp,%rbp
    3b4b:	48 83 ec 20          	sub    $0x20,%rsp
    3b4f:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    3b53:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  char *os;

  os = s;
    3b57:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    3b5b:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  while((*s++ = *t++) != 0)
    3b5f:	90                   	nop
    3b60:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
    3b64:	48 8d 42 01          	lea    0x1(%rdx),%rax
    3b68:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    3b6c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    3b70:	48 8d 48 01          	lea    0x1(%rax),%rcx
    3b74:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
    3b78:	0f b6 12             	movzbl (%rdx),%edx
    3b7b:	88 10                	mov    %dl,(%rax)
    3b7d:	0f b6 00             	movzbl (%rax),%eax
    3b80:	84 c0                	test   %al,%al
    3b82:	75 dc                	jne    3b60 <strcpy+0x19>
    ;
  return os;
    3b84:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
    3b88:	c9                   	leave
    3b89:	c3                   	ret

0000000000003b8a <strcmp>:

int
strcmp(const char *p, const char *q)
{
    3b8a:	55                   	push   %rbp
    3b8b:	48 89 e5             	mov    %rsp,%rbp
    3b8e:	48 83 ec 10          	sub    $0x10,%rsp
    3b92:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    3b96:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  while(*p && *p == *q)
    3b9a:	eb 0a                	jmp    3ba6 <strcmp+0x1c>
    p++, q++;
    3b9c:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    3ba1:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  while(*p && *p == *q)
    3ba6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    3baa:	0f b6 00             	movzbl (%rax),%eax
    3bad:	84 c0                	test   %al,%al
    3baf:	74 12                	je     3bc3 <strcmp+0x39>
    3bb1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    3bb5:	0f b6 10             	movzbl (%rax),%edx
    3bb8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    3bbc:	0f b6 00             	movzbl (%rax),%eax
    3bbf:	38 c2                	cmp    %al,%dl
    3bc1:	74 d9                	je     3b9c <strcmp+0x12>
  return (uchar)*p - (uchar)*q;
    3bc3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    3bc7:	0f b6 00             	movzbl (%rax),%eax
    3bca:	0f b6 d0             	movzbl %al,%edx
    3bcd:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    3bd1:	0f b6 00             	movzbl (%rax),%eax
    3bd4:	0f b6 c0             	movzbl %al,%eax
    3bd7:	29 c2                	sub    %eax,%edx
    3bd9:	89 d0                	mov    %edx,%eax
}
    3bdb:	c9                   	leave
    3bdc:	c3                   	ret

0000000000003bdd <strlen>:

uint
strlen(char *s)
{
    3bdd:	55                   	push   %rbp
    3bde:	48 89 e5             	mov    %rsp,%rbp
    3be1:	48 83 ec 18          	sub    $0x18,%rsp
    3be5:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  int n;

  for(n = 0; s[n]; n++)
    3be9:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    3bf0:	eb 04                	jmp    3bf6 <strlen+0x19>
    3bf2:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    3bf6:	8b 45 fc             	mov    -0x4(%rbp),%eax
    3bf9:	48 63 d0             	movslq %eax,%rdx
    3bfc:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    3c00:	48 01 d0             	add    %rdx,%rax
    3c03:	0f b6 00             	movzbl (%rax),%eax
    3c06:	84 c0                	test   %al,%al
    3c08:	75 e8                	jne    3bf2 <strlen+0x15>
    ;
  return n;
    3c0a:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
    3c0d:	c9                   	leave
    3c0e:	c3                   	ret

0000000000003c0f <memset>:

void*
memset(void *dst, int c, uint n)
{
    3c0f:	55                   	push   %rbp
    3c10:	48 89 e5             	mov    %rsp,%rbp
    3c13:	48 83 ec 10          	sub    $0x10,%rsp
    3c17:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    3c1b:	89 75 f4             	mov    %esi,-0xc(%rbp)
    3c1e:	89 55 f0             	mov    %edx,-0x10(%rbp)
  stosb(dst, c, n);
    3c21:	8b 55 f0             	mov    -0x10(%rbp),%edx
    3c24:	8b 4d f4             	mov    -0xc(%rbp),%ecx
    3c27:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    3c2b:	89 ce                	mov    %ecx,%esi
    3c2d:	48 89 c7             	mov    %rax,%rdi
    3c30:	e8 dc fe ff ff       	call   3b11 <stosb>
  return dst;
    3c35:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
    3c39:	c9                   	leave
    3c3a:	c3                   	ret

0000000000003c3b <strchr>:

char*
strchr(const char *s, char c)
{
    3c3b:	55                   	push   %rbp
    3c3c:	48 89 e5             	mov    %rsp,%rbp
    3c3f:	48 83 ec 10          	sub    $0x10,%rsp
    3c43:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    3c47:	89 f0                	mov    %esi,%eax
    3c49:	88 45 f4             	mov    %al,-0xc(%rbp)
  for(; *s; s++)
    3c4c:	eb 17                	jmp    3c65 <strchr+0x2a>
    if(*s == c)
    3c4e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    3c52:	0f b6 00             	movzbl (%rax),%eax
    3c55:	38 45 f4             	cmp    %al,-0xc(%rbp)
    3c58:	75 06                	jne    3c60 <strchr+0x25>
      return (char*)s;
    3c5a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    3c5e:	eb 15                	jmp    3c75 <strchr+0x3a>
  for(; *s; s++)
    3c60:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    3c65:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    3c69:	0f b6 00             	movzbl (%rax),%eax
    3c6c:	84 c0                	test   %al,%al
    3c6e:	75 de                	jne    3c4e <strchr+0x13>
  return 0;
    3c70:	b8 00 00 00 00       	mov    $0x0,%eax
}
    3c75:	c9                   	leave
    3c76:	c3                   	ret

0000000000003c77 <gets>:

char*
gets(char *buf, int max)
{
    3c77:	55                   	push   %rbp
    3c78:	48 89 e5             	mov    %rsp,%rbp
    3c7b:	48 83 ec 20          	sub    $0x20,%rsp
    3c7f:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    3c83:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    3c86:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    3c8d:	eb 48                	jmp    3cd7 <gets+0x60>
    cc = read(0, &c, 1);
    3c8f:	48 8d 45 f7          	lea    -0x9(%rbp),%rax
    3c93:	ba 01 00 00 00       	mov    $0x1,%edx
    3c98:	48 89 c6             	mov    %rax,%rsi
    3c9b:	bf 00 00 00 00       	mov    $0x0,%edi
    3ca0:	e8 77 01 00 00       	call   3e1c <read>
    3ca5:	89 45 f8             	mov    %eax,-0x8(%rbp)
    if(cc < 1)
    3ca8:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
    3cac:	7e 36                	jle    3ce4 <gets+0x6d>
      break;
    buf[i++] = c;
    3cae:	8b 45 fc             	mov    -0x4(%rbp),%eax
    3cb1:	8d 50 01             	lea    0x1(%rax),%edx
    3cb4:	89 55 fc             	mov    %edx,-0x4(%rbp)
    3cb7:	48 63 d0             	movslq %eax,%rdx
    3cba:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    3cbe:	48 01 c2             	add    %rax,%rdx
    3cc1:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
    3cc5:	88 02                	mov    %al,(%rdx)
    if(c == '\n' || c == '\r')
    3cc7:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
    3ccb:	3c 0a                	cmp    $0xa,%al
    3ccd:	74 16                	je     3ce5 <gets+0x6e>
    3ccf:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
    3cd3:	3c 0d                	cmp    $0xd,%al
    3cd5:	74 0e                	je     3ce5 <gets+0x6e>
  for(i=0; i+1 < max; ){
    3cd7:	8b 45 fc             	mov    -0x4(%rbp),%eax
    3cda:	83 c0 01             	add    $0x1,%eax
    3cdd:	39 45 e4             	cmp    %eax,-0x1c(%rbp)
    3ce0:	7f ad                	jg     3c8f <gets+0x18>
    3ce2:	eb 01                	jmp    3ce5 <gets+0x6e>
      break;
    3ce4:	90                   	nop
      break;
  }
  buf[i] = '\0';
    3ce5:	8b 45 fc             	mov    -0x4(%rbp),%eax
    3ce8:	48 63 d0             	movslq %eax,%rdx
    3ceb:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    3cef:	48 01 d0             	add    %rdx,%rax
    3cf2:	c6 00 00             	movb   $0x0,(%rax)
  return buf;
    3cf5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
    3cf9:	c9                   	leave
    3cfa:	c3                   	ret

0000000000003cfb <stat>:

int
stat(char *n, struct stat *st)
{
    3cfb:	55                   	push   %rbp
    3cfc:	48 89 e5             	mov    %rsp,%rbp
    3cff:	48 83 ec 20          	sub    $0x20,%rsp
    3d03:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    3d07:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    3d0b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    3d0f:	be 00 00 00 00       	mov    $0x0,%esi
    3d14:	48 89 c7             	mov    %rax,%rdi
    3d17:	e8 28 01 00 00       	call   3e44 <open>
    3d1c:	89 45 fc             	mov    %eax,-0x4(%rbp)
  if(fd < 0)
    3d1f:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    3d23:	79 07                	jns    3d2c <stat+0x31>
    return -1;
    3d25:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    3d2a:	eb 21                	jmp    3d4d <stat+0x52>
  r = fstat(fd, st);
    3d2c:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
    3d30:	8b 45 fc             	mov    -0x4(%rbp),%eax
    3d33:	48 89 d6             	mov    %rdx,%rsi
    3d36:	89 c7                	mov    %eax,%edi
    3d38:	e8 1f 01 00 00       	call   3e5c <fstat>
    3d3d:	89 45 f8             	mov    %eax,-0x8(%rbp)
  close(fd);
    3d40:	8b 45 fc             	mov    -0x4(%rbp),%eax
    3d43:	89 c7                	mov    %eax,%edi
    3d45:	e8 e2 00 00 00       	call   3e2c <close>
  return r;
    3d4a:	8b 45 f8             	mov    -0x8(%rbp),%eax
}
    3d4d:	c9                   	leave
    3d4e:	c3                   	ret

0000000000003d4f <atoi>:

int
atoi(const char *s)
{
    3d4f:	55                   	push   %rbp
    3d50:	48 89 e5             	mov    %rsp,%rbp
    3d53:	48 83 ec 18          	sub    $0x18,%rsp
    3d57:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  int n;

  n = 0;
    3d5b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  while('0' <= *s && *s <= '9')
    3d62:	eb 28                	jmp    3d8c <atoi+0x3d>
    n = n*10 + *s++ - '0';
    3d64:	8b 55 fc             	mov    -0x4(%rbp),%edx
    3d67:	89 d0                	mov    %edx,%eax
    3d69:	c1 e0 02             	shl    $0x2,%eax
    3d6c:	01 d0                	add    %edx,%eax
    3d6e:	01 c0                	add    %eax,%eax
    3d70:	89 c1                	mov    %eax,%ecx
    3d72:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    3d76:	48 8d 50 01          	lea    0x1(%rax),%rdx
    3d7a:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
    3d7e:	0f b6 00             	movzbl (%rax),%eax
    3d81:	0f be c0             	movsbl %al,%eax
    3d84:	01 c8                	add    %ecx,%eax
    3d86:	83 e8 30             	sub    $0x30,%eax
    3d89:	89 45 fc             	mov    %eax,-0x4(%rbp)
  while('0' <= *s && *s <= '9')
    3d8c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    3d90:	0f b6 00             	movzbl (%rax),%eax
    3d93:	3c 2f                	cmp    $0x2f,%al
    3d95:	7e 0b                	jle    3da2 <atoi+0x53>
    3d97:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    3d9b:	0f b6 00             	movzbl (%rax),%eax
    3d9e:	3c 39                	cmp    $0x39,%al
    3da0:	7e c2                	jle    3d64 <atoi+0x15>
  return n;
    3da2:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
    3da5:	c9                   	leave
    3da6:	c3                   	ret

0000000000003da7 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
    3da7:	55                   	push   %rbp
    3da8:	48 89 e5             	mov    %rsp,%rbp
    3dab:	48 83 ec 28          	sub    $0x28,%rsp
    3daf:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    3db3:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    3db7:	89 55 dc             	mov    %edx,-0x24(%rbp)
  char *dst, *src;
  
  dst = vdst;
    3dba:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    3dbe:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  src = vsrc;
    3dc2:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
    3dc6:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  while(n-- > 0)
    3dca:	eb 1d                	jmp    3de9 <memmove+0x42>
    *dst++ = *src++;
    3dcc:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
    3dd0:	48 8d 42 01          	lea    0x1(%rdx),%rax
    3dd4:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    3dd8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    3ddc:	48 8d 48 01          	lea    0x1(%rax),%rcx
    3de0:	48 89 4d f8          	mov    %rcx,-0x8(%rbp)
    3de4:	0f b6 12             	movzbl (%rdx),%edx
    3de7:	88 10                	mov    %dl,(%rax)
  while(n-- > 0)
    3de9:	8b 45 dc             	mov    -0x24(%rbp),%eax
    3dec:	8d 50 ff             	lea    -0x1(%rax),%edx
    3def:	89 55 dc             	mov    %edx,-0x24(%rbp)
    3df2:	85 c0                	test   %eax,%eax
    3df4:	7f d6                	jg     3dcc <memmove+0x25>
  return vdst;
    3df6:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
    3dfa:	c9                   	leave
    3dfb:	c3                   	ret

0000000000003dfc <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    3dfc:	b8 01 00 00 00       	mov    $0x1,%eax
    3e01:	cd 40                	int    $0x40
    3e03:	c3                   	ret

0000000000003e04 <exit>:
SYSCALL(exit)
    3e04:	b8 02 00 00 00       	mov    $0x2,%eax
    3e09:	cd 40                	int    $0x40
    3e0b:	c3                   	ret

0000000000003e0c <wait>:
SYSCALL(wait)
    3e0c:	b8 03 00 00 00       	mov    $0x3,%eax
    3e11:	cd 40                	int    $0x40
    3e13:	c3                   	ret

0000000000003e14 <pipe>:
SYSCALL(pipe)
    3e14:	b8 04 00 00 00       	mov    $0x4,%eax
    3e19:	cd 40                	int    $0x40
    3e1b:	c3                   	ret

0000000000003e1c <read>:
SYSCALL(read)
    3e1c:	b8 05 00 00 00       	mov    $0x5,%eax
    3e21:	cd 40                	int    $0x40
    3e23:	c3                   	ret

0000000000003e24 <write>:
SYSCALL(write)
    3e24:	b8 10 00 00 00       	mov    $0x10,%eax
    3e29:	cd 40                	int    $0x40
    3e2b:	c3                   	ret

0000000000003e2c <close>:
SYSCALL(close)
    3e2c:	b8 15 00 00 00       	mov    $0x15,%eax
    3e31:	cd 40                	int    $0x40
    3e33:	c3                   	ret

0000000000003e34 <kill>:
SYSCALL(kill)
    3e34:	b8 06 00 00 00       	mov    $0x6,%eax
    3e39:	cd 40                	int    $0x40
    3e3b:	c3                   	ret

0000000000003e3c <exec>:
SYSCALL(exec)
    3e3c:	b8 07 00 00 00       	mov    $0x7,%eax
    3e41:	cd 40                	int    $0x40
    3e43:	c3                   	ret

0000000000003e44 <open>:
SYSCALL(open)
    3e44:	b8 0f 00 00 00       	mov    $0xf,%eax
    3e49:	cd 40                	int    $0x40
    3e4b:	c3                   	ret

0000000000003e4c <mknod>:
SYSCALL(mknod)
    3e4c:	b8 11 00 00 00       	mov    $0x11,%eax
    3e51:	cd 40                	int    $0x40
    3e53:	c3                   	ret

0000000000003e54 <unlink>:
SYSCALL(unlink)
    3e54:	b8 12 00 00 00       	mov    $0x12,%eax
    3e59:	cd 40                	int    $0x40
    3e5b:	c3                   	ret

0000000000003e5c <fstat>:
SYSCALL(fstat)
    3e5c:	b8 08 00 00 00       	mov    $0x8,%eax
    3e61:	cd 40                	int    $0x40
    3e63:	c3                   	ret

0000000000003e64 <link>:
SYSCALL(link)
    3e64:	b8 13 00 00 00       	mov    $0x13,%eax
    3e69:	cd 40                	int    $0x40
    3e6b:	c3                   	ret

0000000000003e6c <mkdir>:
SYSCALL(mkdir)
    3e6c:	b8 14 00 00 00       	mov    $0x14,%eax
    3e71:	cd 40                	int    $0x40
    3e73:	c3                   	ret

0000000000003e74 <chdir>:
SYSCALL(chdir)
    3e74:	b8 09 00 00 00       	mov    $0x9,%eax
    3e79:	cd 40                	int    $0x40
    3e7b:	c3                   	ret

0000000000003e7c <dup>:
SYSCALL(dup)
    3e7c:	b8 0a 00 00 00       	mov    $0xa,%eax
    3e81:	cd 40                	int    $0x40
    3e83:	c3                   	ret

0000000000003e84 <getpid>:
SYSCALL(getpid)
    3e84:	b8 0b 00 00 00       	mov    $0xb,%eax
    3e89:	cd 40                	int    $0x40
    3e8b:	c3                   	ret

0000000000003e8c <sbrk>:
SYSCALL(sbrk)
    3e8c:	b8 0c 00 00 00       	mov    $0xc,%eax
    3e91:	cd 40                	int    $0x40
    3e93:	c3                   	ret

0000000000003e94 <sleep>:
SYSCALL(sleep)
    3e94:	b8 0d 00 00 00       	mov    $0xd,%eax
    3e99:	cd 40                	int    $0x40
    3e9b:	c3                   	ret

0000000000003e9c <uptime>:
SYSCALL(uptime)
    3e9c:	b8 0e 00 00 00       	mov    $0xe,%eax
    3ea1:	cd 40                	int    $0x40
    3ea3:	c3                   	ret

0000000000003ea4 <getpinfo>:
SYSCALL(getpinfo)
    3ea4:	b8 18 00 00 00       	mov    $0x18,%eax
    3ea9:	cd 40                	int    $0x40
    3eab:	c3                   	ret

0000000000003eac <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
    3eac:	55                   	push   %rbp
    3ead:	48 89 e5             	mov    %rsp,%rbp
    3eb0:	48 83 ec 10          	sub    $0x10,%rsp
    3eb4:	89 7d fc             	mov    %edi,-0x4(%rbp)
    3eb7:	89 f0                	mov    %esi,%eax
    3eb9:	88 45 f8             	mov    %al,-0x8(%rbp)
  write(fd, &c, 1);
    3ebc:	48 8d 4d f8          	lea    -0x8(%rbp),%rcx
    3ec0:	8b 45 fc             	mov    -0x4(%rbp),%eax
    3ec3:	ba 01 00 00 00       	mov    $0x1,%edx
    3ec8:	48 89 ce             	mov    %rcx,%rsi
    3ecb:	89 c7                	mov    %eax,%edi
    3ecd:	e8 52 ff ff ff       	call   3e24 <write>
}
    3ed2:	90                   	nop
    3ed3:	c9                   	leave
    3ed4:	c3                   	ret

0000000000003ed5 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    3ed5:	55                   	push   %rbp
    3ed6:	48 89 e5             	mov    %rsp,%rbp
    3ed9:	48 83 ec 30          	sub    $0x30,%rsp
    3edd:	89 7d dc             	mov    %edi,-0x24(%rbp)
    3ee0:	89 75 d8             	mov    %esi,-0x28(%rbp)
    3ee3:	89 55 d4             	mov    %edx,-0x2c(%rbp)
    3ee6:	89 4d d0             	mov    %ecx,-0x30(%rbp)
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
    3ee9:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
  if(sgn && xx < 0){
    3ef0:	83 7d d0 00          	cmpl   $0x0,-0x30(%rbp)
    3ef4:	74 17                	je     3f0d <printint+0x38>
    3ef6:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
    3efa:	79 11                	jns    3f0d <printint+0x38>
    neg = 1;
    3efc:	c7 45 f8 01 00 00 00 	movl   $0x1,-0x8(%rbp)
    x = -xx;
    3f03:	8b 45 d8             	mov    -0x28(%rbp),%eax
    3f06:	f7 d8                	neg    %eax
    3f08:	89 45 f4             	mov    %eax,-0xc(%rbp)
    3f0b:	eb 06                	jmp    3f13 <printint+0x3e>
  } else {
    x = xx;
    3f0d:	8b 45 d8             	mov    -0x28(%rbp),%eax
    3f10:	89 45 f4             	mov    %eax,-0xc(%rbp)
  }

  i = 0;
    3f13:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  do{
    buf[i++] = digits[x % base];
    3f1a:	8b 4d d4             	mov    -0x2c(%rbp),%ecx
    3f1d:	8b 45 f4             	mov    -0xc(%rbp),%eax
    3f20:	ba 00 00 00 00       	mov    $0x0,%edx
    3f25:	f7 f1                	div    %ecx
    3f27:	89 d1                	mov    %edx,%ecx
    3f29:	8b 45 fc             	mov    -0x4(%rbp),%eax
    3f2c:	8d 50 01             	lea    0x1(%rax),%edx
    3f2f:	89 55 fc             	mov    %edx,-0x4(%rbp)
    3f32:	89 ca                	mov    %ecx,%edx
    3f34:	0f b6 92 40 63 00 00 	movzbl 0x6340(%rdx),%edx
    3f3b:	48 98                	cltq
    3f3d:	88 54 05 e0          	mov    %dl,-0x20(%rbp,%rax,1)
  }while((x /= base) != 0);
    3f41:	8b 75 d4             	mov    -0x2c(%rbp),%esi
    3f44:	8b 45 f4             	mov    -0xc(%rbp),%eax
    3f47:	ba 00 00 00 00       	mov    $0x0,%edx
    3f4c:	f7 f6                	div    %esi
    3f4e:	89 45 f4             	mov    %eax,-0xc(%rbp)
    3f51:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
    3f55:	75 c3                	jne    3f1a <printint+0x45>
  if(neg)
    3f57:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
    3f5b:	74 2b                	je     3f88 <printint+0xb3>
    buf[i++] = '-';
    3f5d:	8b 45 fc             	mov    -0x4(%rbp),%eax
    3f60:	8d 50 01             	lea    0x1(%rax),%edx
    3f63:	89 55 fc             	mov    %edx,-0x4(%rbp)
    3f66:	48 98                	cltq
    3f68:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%rbp,%rax,1)

  while(--i >= 0)
    3f6d:	eb 19                	jmp    3f88 <printint+0xb3>
    putc(fd, buf[i]);
    3f6f:	8b 45 fc             	mov    -0x4(%rbp),%eax
    3f72:	48 98                	cltq
    3f74:	0f b6 44 05 e0       	movzbl -0x20(%rbp,%rax,1),%eax
    3f79:	0f be d0             	movsbl %al,%edx
    3f7c:	8b 45 dc             	mov    -0x24(%rbp),%eax
    3f7f:	89 d6                	mov    %edx,%esi
    3f81:	89 c7                	mov    %eax,%edi
    3f83:	e8 24 ff ff ff       	call   3eac <putc>
  while(--i >= 0)
    3f88:	83 6d fc 01          	subl   $0x1,-0x4(%rbp)
    3f8c:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    3f90:	79 dd                	jns    3f6f <printint+0x9a>
}
    3f92:	90                   	nop
    3f93:	90                   	nop
    3f94:	c9                   	leave
    3f95:	c3                   	ret

0000000000003f96 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
    3f96:	55                   	push   %rbp
    3f97:	48 89 e5             	mov    %rsp,%rbp
    3f9a:	48 81 ec f0 00 00 00 	sub    $0xf0,%rsp
    3fa1:	89 bd 1c ff ff ff    	mov    %edi,-0xe4(%rbp)
    3fa7:	48 89 b5 10 ff ff ff 	mov    %rsi,-0xf0(%rbp)
    3fae:	48 89 95 60 ff ff ff 	mov    %rdx,-0xa0(%rbp)
    3fb5:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
    3fbc:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
    3fc3:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
    3fca:	84 c0                	test   %al,%al
    3fcc:	74 20                	je     3fee <printf+0x58>
    3fce:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
    3fd2:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
    3fd6:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
    3fda:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
    3fde:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
    3fe2:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
    3fe6:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
    3fea:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  va_list ap;
  char *s;
  int c, i, state;
  va_start(ap, fmt);
    3fee:	c7 85 20 ff ff ff 10 	movl   $0x10,-0xe0(%rbp)
    3ff5:	00 00 00 
    3ff8:	c7 85 24 ff ff ff 30 	movl   $0x30,-0xdc(%rbp)
    3fff:	00 00 00 
    4002:	48 8d 45 10          	lea    0x10(%rbp),%rax
    4006:	48 89 85 28 ff ff ff 	mov    %rax,-0xd8(%rbp)
    400d:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
    4014:	48 89 85 30 ff ff ff 	mov    %rax,-0xd0(%rbp)

  state = 0;
    401b:	c7 85 40 ff ff ff 00 	movl   $0x0,-0xc0(%rbp)
    4022:	00 00 00 
  for(i = 0; fmt[i]; i++){
    4025:	c7 85 44 ff ff ff 00 	movl   $0x0,-0xbc(%rbp)
    402c:	00 00 00 
    402f:	e9 a8 02 00 00       	jmp    42dc <printf+0x346>
    c = fmt[i] & 0xff;
    4034:	8b 85 44 ff ff ff    	mov    -0xbc(%rbp),%eax
    403a:	48 63 d0             	movslq %eax,%rdx
    403d:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
    4044:	48 01 d0             	add    %rdx,%rax
    4047:	0f b6 00             	movzbl (%rax),%eax
    404a:	0f be c0             	movsbl %al,%eax
    404d:	25 ff 00 00 00       	and    $0xff,%eax
    4052:	89 85 3c ff ff ff    	mov    %eax,-0xc4(%rbp)
    if(state == 0){
    4058:	83 bd 40 ff ff ff 00 	cmpl   $0x0,-0xc0(%rbp)
    405f:	75 35                	jne    4096 <printf+0x100>
      if(c == '%'){
    4061:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
    4068:	75 0f                	jne    4079 <printf+0xe3>
        state = '%';
    406a:	c7 85 40 ff ff ff 25 	movl   $0x25,-0xc0(%rbp)
    4071:	00 00 00 
    4074:	e9 5c 02 00 00       	jmp    42d5 <printf+0x33f>
      } else {
        putc(fd, c);
    4079:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
    407f:	0f be d0             	movsbl %al,%edx
    4082:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    4088:	89 d6                	mov    %edx,%esi
    408a:	89 c7                	mov    %eax,%edi
    408c:	e8 1b fe ff ff       	call   3eac <putc>
    4091:	e9 3f 02 00 00       	jmp    42d5 <printf+0x33f>
      }
    } else if(state == '%'){
    4096:	83 bd 40 ff ff ff 25 	cmpl   $0x25,-0xc0(%rbp)
    409d:	0f 85 32 02 00 00    	jne    42d5 <printf+0x33f>
      if(c == 'd'){
    40a3:	83 bd 3c ff ff ff 64 	cmpl   $0x64,-0xc4(%rbp)
    40aa:	75 5e                	jne    410a <printf+0x174>
        printint(fd, va_arg(ap, int), 10, 1);
    40ac:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    40b2:	83 f8 2f             	cmp    $0x2f,%eax
    40b5:	77 23                	ja     40da <printf+0x144>
    40b7:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    40be:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    40c4:	89 d2                	mov    %edx,%edx
    40c6:	48 01 d0             	add    %rdx,%rax
    40c9:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    40cf:	83 c2 08             	add    $0x8,%edx
    40d2:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    40d8:	eb 12                	jmp    40ec <printf+0x156>
    40da:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    40e1:	48 8d 50 08          	lea    0x8(%rax),%rdx
    40e5:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    40ec:	8b 30                	mov    (%rax),%esi
    40ee:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    40f4:	b9 01 00 00 00       	mov    $0x1,%ecx
    40f9:	ba 0a 00 00 00       	mov    $0xa,%edx
    40fe:	89 c7                	mov    %eax,%edi
    4100:	e8 d0 fd ff ff       	call   3ed5 <printint>
    4105:	e9 c1 01 00 00       	jmp    42cb <printf+0x335>
      } else if(c == 'x' || c == 'p'){
    410a:	83 bd 3c ff ff ff 78 	cmpl   $0x78,-0xc4(%rbp)
    4111:	74 09                	je     411c <printf+0x186>
    4113:	83 bd 3c ff ff ff 70 	cmpl   $0x70,-0xc4(%rbp)
    411a:	75 5e                	jne    417a <printf+0x1e4>
        printint(fd, va_arg(ap, int), 16, 0);
    411c:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    4122:	83 f8 2f             	cmp    $0x2f,%eax
    4125:	77 23                	ja     414a <printf+0x1b4>
    4127:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    412e:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    4134:	89 d2                	mov    %edx,%edx
    4136:	48 01 d0             	add    %rdx,%rax
    4139:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    413f:	83 c2 08             	add    $0x8,%edx
    4142:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    4148:	eb 12                	jmp    415c <printf+0x1c6>
    414a:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    4151:	48 8d 50 08          	lea    0x8(%rax),%rdx
    4155:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    415c:	8b 30                	mov    (%rax),%esi
    415e:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    4164:	b9 00 00 00 00       	mov    $0x0,%ecx
    4169:	ba 10 00 00 00       	mov    $0x10,%edx
    416e:	89 c7                	mov    %eax,%edi
    4170:	e8 60 fd ff ff       	call   3ed5 <printint>
    4175:	e9 51 01 00 00       	jmp    42cb <printf+0x335>
      } else if(c == 's'){
    417a:	83 bd 3c ff ff ff 73 	cmpl   $0x73,-0xc4(%rbp)
    4181:	0f 85 98 00 00 00    	jne    421f <printf+0x289>
        s = va_arg(ap, char*);
    4187:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    418d:	83 f8 2f             	cmp    $0x2f,%eax
    4190:	77 23                	ja     41b5 <printf+0x21f>
    4192:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    4199:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    419f:	89 d2                	mov    %edx,%edx
    41a1:	48 01 d0             	add    %rdx,%rax
    41a4:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    41aa:	83 c2 08             	add    $0x8,%edx
    41ad:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    41b3:	eb 12                	jmp    41c7 <printf+0x231>
    41b5:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    41bc:	48 8d 50 08          	lea    0x8(%rax),%rdx
    41c0:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    41c7:	48 8b 00             	mov    (%rax),%rax
    41ca:	48 89 85 48 ff ff ff 	mov    %rax,-0xb8(%rbp)
        if(s == 0)
    41d1:	48 83 bd 48 ff ff ff 	cmpq   $0x0,-0xb8(%rbp)
    41d8:	00 
    41d9:	75 31                	jne    420c <printf+0x276>
          s = "(null)";
    41db:	48 c7 85 48 ff ff ff 	movq   $0x5c92,-0xb8(%rbp)
    41e2:	92 5c 00 00 
        while(*s != 0){
    41e6:	eb 24                	jmp    420c <printf+0x276>
          putc(fd, *s);
    41e8:	48 8b 85 48 ff ff ff 	mov    -0xb8(%rbp),%rax
    41ef:	0f b6 00             	movzbl (%rax),%eax
    41f2:	0f be d0             	movsbl %al,%edx
    41f5:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    41fb:	89 d6                	mov    %edx,%esi
    41fd:	89 c7                	mov    %eax,%edi
    41ff:	e8 a8 fc ff ff       	call   3eac <putc>
          s++;
    4204:	48 83 85 48 ff ff ff 	addq   $0x1,-0xb8(%rbp)
    420b:	01 
        while(*s != 0){
    420c:	48 8b 85 48 ff ff ff 	mov    -0xb8(%rbp),%rax
    4213:	0f b6 00             	movzbl (%rax),%eax
    4216:	84 c0                	test   %al,%al
    4218:	75 ce                	jne    41e8 <printf+0x252>
    421a:	e9 ac 00 00 00       	jmp    42cb <printf+0x335>
        }
      } else if(c == 'c'){
    421f:	83 bd 3c ff ff ff 63 	cmpl   $0x63,-0xc4(%rbp)
    4226:	75 56                	jne    427e <printf+0x2e8>
        putc(fd, va_arg(ap, uint));
    4228:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    422e:	83 f8 2f             	cmp    $0x2f,%eax
    4231:	77 23                	ja     4256 <printf+0x2c0>
    4233:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    423a:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    4240:	89 d2                	mov    %edx,%edx
    4242:	48 01 d0             	add    %rdx,%rax
    4245:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    424b:	83 c2 08             	add    $0x8,%edx
    424e:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    4254:	eb 12                	jmp    4268 <printf+0x2d2>
    4256:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    425d:	48 8d 50 08          	lea    0x8(%rax),%rdx
    4261:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    4268:	8b 00                	mov    (%rax),%eax
    426a:	0f be d0             	movsbl %al,%edx
    426d:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    4273:	89 d6                	mov    %edx,%esi
    4275:	89 c7                	mov    %eax,%edi
    4277:	e8 30 fc ff ff       	call   3eac <putc>
    427c:	eb 4d                	jmp    42cb <printf+0x335>
      } else if(c == '%'){
    427e:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
    4285:	75 1a                	jne    42a1 <printf+0x30b>
        putc(fd, c);
    4287:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
    428d:	0f be d0             	movsbl %al,%edx
    4290:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    4296:	89 d6                	mov    %edx,%esi
    4298:	89 c7                	mov    %eax,%edi
    429a:	e8 0d fc ff ff       	call   3eac <putc>
    429f:	eb 2a                	jmp    42cb <printf+0x335>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    42a1:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    42a7:	be 25 00 00 00       	mov    $0x25,%esi
    42ac:	89 c7                	mov    %eax,%edi
    42ae:	e8 f9 fb ff ff       	call   3eac <putc>
        putc(fd, c);
    42b3:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
    42b9:	0f be d0             	movsbl %al,%edx
    42bc:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    42c2:	89 d6                	mov    %edx,%esi
    42c4:	89 c7                	mov    %eax,%edi
    42c6:	e8 e1 fb ff ff       	call   3eac <putc>
      }
      state = 0;
    42cb:	c7 85 40 ff ff ff 00 	movl   $0x0,-0xc0(%rbp)
    42d2:	00 00 00 
  for(i = 0; fmt[i]; i++){
    42d5:	83 85 44 ff ff ff 01 	addl   $0x1,-0xbc(%rbp)
    42dc:	8b 85 44 ff ff ff    	mov    -0xbc(%rbp),%eax
    42e2:	48 63 d0             	movslq %eax,%rdx
    42e5:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
    42ec:	48 01 d0             	add    %rdx,%rax
    42ef:	0f b6 00             	movzbl (%rax),%eax
    42f2:	84 c0                	test   %al,%al
    42f4:	0f 85 3a fd ff ff    	jne    4034 <printf+0x9e>
    }
  }
}
    42fa:	90                   	nop
    42fb:	90                   	nop
    42fc:	c9                   	leave
    42fd:	c3                   	ret

00000000000042fe <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    42fe:	55                   	push   %rbp
    42ff:	48 89 e5             	mov    %rsp,%rbp
    4302:	48 83 ec 18          	sub    $0x18,%rsp
    4306:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  Header *bp, *p;

  bp = (Header*)ap - 1;
    430a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    430e:	48 83 e8 10          	sub    $0x10,%rax
    4312:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    4316:	48 8b 05 93 68 00 00 	mov    0x6893(%rip),%rax        # abb0 <freep>
    431d:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    4321:	eb 2f                	jmp    4352 <free+0x54>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    4323:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    4327:	48 8b 00             	mov    (%rax),%rax
    432a:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    432e:	72 17                	jb     4347 <free+0x49>
    4330:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    4334:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    4338:	72 2f                	jb     4369 <free+0x6b>
    433a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    433e:	48 8b 00             	mov    (%rax),%rax
    4341:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
    4345:	72 22                	jb     4369 <free+0x6b>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    4347:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    434b:	48 8b 00             	mov    (%rax),%rax
    434e:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    4352:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    4356:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    435a:	73 c7                	jae    4323 <free+0x25>
    435c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    4360:	48 8b 00             	mov    (%rax),%rax
    4363:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
    4367:	73 ba                	jae    4323 <free+0x25>
      break;
  if(bp + bp->s.size == p->s.ptr){
    4369:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    436d:	8b 40 08             	mov    0x8(%rax),%eax
    4370:	89 c0                	mov    %eax,%eax
    4372:	48 c1 e0 04          	shl    $0x4,%rax
    4376:	48 89 c2             	mov    %rax,%rdx
    4379:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    437d:	48 01 c2             	add    %rax,%rdx
    4380:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    4384:	48 8b 00             	mov    (%rax),%rax
    4387:	48 39 c2             	cmp    %rax,%rdx
    438a:	75 2d                	jne    43b9 <free+0xbb>
    bp->s.size += p->s.ptr->s.size;
    438c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    4390:	8b 50 08             	mov    0x8(%rax),%edx
    4393:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    4397:	48 8b 00             	mov    (%rax),%rax
    439a:	8b 40 08             	mov    0x8(%rax),%eax
    439d:	01 c2                	add    %eax,%edx
    439f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    43a3:	89 50 08             	mov    %edx,0x8(%rax)
    bp->s.ptr = p->s.ptr->s.ptr;
    43a6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    43aa:	48 8b 00             	mov    (%rax),%rax
    43ad:	48 8b 10             	mov    (%rax),%rdx
    43b0:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    43b4:	48 89 10             	mov    %rdx,(%rax)
    43b7:	eb 0e                	jmp    43c7 <free+0xc9>
  } else
    bp->s.ptr = p->s.ptr;
    43b9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    43bd:	48 8b 10             	mov    (%rax),%rdx
    43c0:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    43c4:	48 89 10             	mov    %rdx,(%rax)
  if(p + p->s.size == bp){
    43c7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    43cb:	8b 40 08             	mov    0x8(%rax),%eax
    43ce:	89 c0                	mov    %eax,%eax
    43d0:	48 c1 e0 04          	shl    $0x4,%rax
    43d4:	48 89 c2             	mov    %rax,%rdx
    43d7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    43db:	48 01 d0             	add    %rdx,%rax
    43de:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
    43e2:	75 27                	jne    440b <free+0x10d>
    p->s.size += bp->s.size;
    43e4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    43e8:	8b 50 08             	mov    0x8(%rax),%edx
    43eb:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    43ef:	8b 40 08             	mov    0x8(%rax),%eax
    43f2:	01 c2                	add    %eax,%edx
    43f4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    43f8:	89 50 08             	mov    %edx,0x8(%rax)
    p->s.ptr = bp->s.ptr;
    43fb:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    43ff:	48 8b 10             	mov    (%rax),%rdx
    4402:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    4406:	48 89 10             	mov    %rdx,(%rax)
    4409:	eb 0b                	jmp    4416 <free+0x118>
  } else
    p->s.ptr = bp;
    440b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    440f:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
    4413:	48 89 10             	mov    %rdx,(%rax)
  freep = p;
    4416:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    441a:	48 89 05 8f 67 00 00 	mov    %rax,0x678f(%rip)        # abb0 <freep>
}
    4421:	90                   	nop
    4422:	c9                   	leave
    4423:	c3                   	ret

0000000000004424 <morecore>:

static Header*
morecore(uint nu)
{
    4424:	55                   	push   %rbp
    4425:	48 89 e5             	mov    %rsp,%rbp
    4428:	48 83 ec 20          	sub    $0x20,%rsp
    442c:	89 7d ec             	mov    %edi,-0x14(%rbp)
  char *p;
  Header *hp;

  if(nu < 4096)
    442f:	81 7d ec ff 0f 00 00 	cmpl   $0xfff,-0x14(%rbp)
    4436:	77 07                	ja     443f <morecore+0x1b>
    nu = 4096;
    4438:	c7 45 ec 00 10 00 00 	movl   $0x1000,-0x14(%rbp)
  p = sbrk(nu * sizeof(Header));
    443f:	8b 45 ec             	mov    -0x14(%rbp),%eax
    4442:	c1 e0 04             	shl    $0x4,%eax
    4445:	89 c7                	mov    %eax,%edi
    4447:	e8 40 fa ff ff       	call   3e8c <sbrk>
    444c:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  if(p == (char*)-1)
    4450:	48 83 7d f8 ff       	cmpq   $0xffffffffffffffff,-0x8(%rbp)
    4455:	75 07                	jne    445e <morecore+0x3a>
    return 0;
    4457:	b8 00 00 00 00       	mov    $0x0,%eax
    445c:	eb 29                	jmp    4487 <morecore+0x63>
  hp = (Header*)p;
    445e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    4462:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  hp->s.size = nu;
    4466:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    446a:	8b 55 ec             	mov    -0x14(%rbp),%edx
    446d:	89 50 08             	mov    %edx,0x8(%rax)
  free((void*)(hp + 1));
    4470:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    4474:	48 83 c0 10          	add    $0x10,%rax
    4478:	48 89 c7             	mov    %rax,%rdi
    447b:	e8 7e fe ff ff       	call   42fe <free>
  return freep;
    4480:	48 8b 05 29 67 00 00 	mov    0x6729(%rip),%rax        # abb0 <freep>
}
    4487:	c9                   	leave
    4488:	c3                   	ret

0000000000004489 <malloc>:

void*
malloc(uint nbytes)
{
    4489:	55                   	push   %rbp
    448a:	48 89 e5             	mov    %rsp,%rbp
    448d:	48 83 ec 30          	sub    $0x30,%rsp
    4491:	89 7d dc             	mov    %edi,-0x24(%rbp)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    4494:	8b 45 dc             	mov    -0x24(%rbp),%eax
    4497:	48 83 c0 0f          	add    $0xf,%rax
    449b:	48 c1 e8 04          	shr    $0x4,%rax
    449f:	83 c0 01             	add    $0x1,%eax
    44a2:	89 45 ec             	mov    %eax,-0x14(%rbp)
  if((prevp = freep) == 0){
    44a5:	48 8b 05 04 67 00 00 	mov    0x6704(%rip),%rax        # abb0 <freep>
    44ac:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    44b0:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
    44b5:	75 2b                	jne    44e2 <malloc+0x59>
    base.s.ptr = freep = prevp = &base;
    44b7:	48 c7 45 f0 a0 ab 00 	movq   $0xaba0,-0x10(%rbp)
    44be:	00 
    44bf:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    44c3:	48 89 05 e6 66 00 00 	mov    %rax,0x66e6(%rip)        # abb0 <freep>
    44ca:	48 8b 05 df 66 00 00 	mov    0x66df(%rip),%rax        # abb0 <freep>
    44d1:	48 89 05 c8 66 00 00 	mov    %rax,0x66c8(%rip)        # aba0 <base>
    base.s.size = 0;
    44d8:	c7 05 c6 66 00 00 00 	movl   $0x0,0x66c6(%rip)        # aba8 <base+0x8>
    44df:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    44e2:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    44e6:	48 8b 00             	mov    (%rax),%rax
    44e9:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
    44ed:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    44f1:	8b 40 08             	mov    0x8(%rax),%eax
    44f4:	3b 45 ec             	cmp    -0x14(%rbp),%eax
    44f7:	72 5f                	jb     4558 <malloc+0xcf>
      if(p->s.size == nunits)
    44f9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    44fd:	8b 40 08             	mov    0x8(%rax),%eax
    4500:	39 45 ec             	cmp    %eax,-0x14(%rbp)
    4503:	75 10                	jne    4515 <malloc+0x8c>
        prevp->s.ptr = p->s.ptr;
    4505:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    4509:	48 8b 10             	mov    (%rax),%rdx
    450c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    4510:	48 89 10             	mov    %rdx,(%rax)
    4513:	eb 2e                	jmp    4543 <malloc+0xba>
      else {
        p->s.size -= nunits;
    4515:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    4519:	8b 40 08             	mov    0x8(%rax),%eax
    451c:	2b 45 ec             	sub    -0x14(%rbp),%eax
    451f:	89 c2                	mov    %eax,%edx
    4521:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    4525:	89 50 08             	mov    %edx,0x8(%rax)
        p += p->s.size;
    4528:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    452c:	8b 40 08             	mov    0x8(%rax),%eax
    452f:	89 c0                	mov    %eax,%eax
    4531:	48 c1 e0 04          	shl    $0x4,%rax
    4535:	48 01 45 f8          	add    %rax,-0x8(%rbp)
        p->s.size = nunits;
    4539:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    453d:	8b 55 ec             	mov    -0x14(%rbp),%edx
    4540:	89 50 08             	mov    %edx,0x8(%rax)
      }
      freep = prevp;
    4543:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    4547:	48 89 05 62 66 00 00 	mov    %rax,0x6662(%rip)        # abb0 <freep>
      return (void*)(p + 1);
    454e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    4552:	48 83 c0 10          	add    $0x10,%rax
    4556:	eb 41                	jmp    4599 <malloc+0x110>
    }
    if(p == freep)
    4558:	48 8b 05 51 66 00 00 	mov    0x6651(%rip),%rax        # abb0 <freep>
    455f:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    4563:	75 1c                	jne    4581 <malloc+0xf8>
      if((p = morecore(nunits)) == 0)
    4565:	8b 45 ec             	mov    -0x14(%rbp),%eax
    4568:	89 c7                	mov    %eax,%edi
    456a:	e8 b5 fe ff ff       	call   4424 <morecore>
    456f:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    4573:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
    4578:	75 07                	jne    4581 <malloc+0xf8>
        return 0;
    457a:	b8 00 00 00 00       	mov    $0x0,%eax
    457f:	eb 18                	jmp    4599 <malloc+0x110>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    4581:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    4585:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    4589:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    458d:	48 8b 00             	mov    (%rax),%rax
    4590:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
    4594:	e9 54 ff ff ff       	jmp    44ed <malloc+0x64>
  }
}
    4599:	c9                   	leave
    459a:	c3                   	ret
