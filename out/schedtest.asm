
fs/schedtest:     file format elf64-x86-64


Disassembly of section .text:

0000000000000000 <spin>:
#define LTICKS(x) (x * 1000000)

/* A function to spend some CPU cycles on */
void 
spin(int J)
{
   0:	55                   	push   %rbp
   1:	48 89 e5             	mov    %rsp,%rbp
   4:	48 83 ec 18          	sub    $0x18,%rsp
   8:	89 7d ec             	mov    %edi,-0x14(%rbp)
    int i = 0;
   b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    int j = 0;
  12:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
    int k = 0;
  19:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
    for (i = 0; i < 50; i++) 
  20:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  27:	eb 44                	jmp    6d <spin+0x6d>
    {
        for (j = 0; j < J; j++) 
  29:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
  30:	eb 2f                	jmp    61 <spin+0x61>
        {
            k = j % 10;
  32:	8b 55 f8             	mov    -0x8(%rbp),%edx
  35:	48 63 c2             	movslq %edx,%rax
  38:	48 69 c0 67 66 66 66 	imul   $0x66666667,%rax,%rax
  3f:	48 c1 e8 20          	shr    $0x20,%rax
  43:	89 c1                	mov    %eax,%ecx
  45:	c1 f9 02             	sar    $0x2,%ecx
  48:	89 d0                	mov    %edx,%eax
  4a:	c1 f8 1f             	sar    $0x1f,%eax
  4d:	29 c1                	sub    %eax,%ecx
  4f:	89 c8                	mov    %ecx,%eax
  51:	c1 e0 02             	shl    $0x2,%eax
  54:	01 c8                	add    %ecx,%eax
  56:	01 c0                	add    %eax,%eax
  58:	29 c2                	sub    %eax,%edx
  5a:	89 55 f4             	mov    %edx,-0xc(%rbp)
        for (j = 0; j < J; j++) 
  5d:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
  61:	8b 45 f8             	mov    -0x8(%rbp),%eax
  64:	3b 45 ec             	cmp    -0x14(%rbp),%eax
  67:	7c c9                	jl     32 <spin+0x32>
    for (i = 0; i < 50; i++) 
  69:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  6d:	83 7d fc 31          	cmpl   $0x31,-0x4(%rbp)
  71:	7e b6                	jle    29 <spin+0x29>
        }
    }

    (void)k; /* unused variable is unused :) */
}
  73:	90                   	nop
  74:	90                   	nop
  75:	c9                   	leave
  76:	c3                   	ret

0000000000000077 <print_info>:

/* Print information about each of the running processes */

void
print_info(struct pstat *pstat, int j)
{
  77:	55                   	push   %rbp
  78:	48 89 e5             	mov    %rsp,%rbp
  7b:	48 83 ec 10          	sub    $0x10,%rsp
  7f:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  83:	89 75 f4             	mov    %esi,-0xc(%rbp)
    printf(1, "%d\t%d\t", pstat->pid[j], pstat->ticks[j]);
  86:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  8a:	8b 55 f4             	mov    -0xc(%rbp),%edx
  8d:	48 63 d2             	movslq %edx,%rdx
  90:	48 81 c2 c0 00 00 00 	add    $0xc0,%rdx
  97:	8b 14 90             	mov    (%rax,%rdx,4),%edx
  9a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  9e:	8b 4d f4             	mov    -0xc(%rbp),%ecx
  a1:	48 63 c9             	movslq %ecx,%rcx
  a4:	48 83 e9 80          	sub    $0xffffffffffffff80,%rcx
  a8:	8b 04 88             	mov    (%rax,%rcx,4),%eax
  ab:	89 d1                	mov    %edx,%ecx
  ad:	89 c2                	mov    %eax,%edx
  af:	48 c7 c6 38 0e 00 00 	mov    $0xe38,%rsi
  b6:	bf 01 00 00 00       	mov    $0x1,%edi
  bb:	b8 00 00 00 00       	mov    $0x0,%eax
  c0:	e8 6e 07 00 00       	call   833 <printf>

    if (pstat->inuse[j] == 1) 
  c5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  c9:	8b 55 f4             	mov    -0xc(%rbp),%edx
  cc:	48 63 d2             	movslq %edx,%rdx
  cf:	8b 04 90             	mov    (%rax,%rdx,4),%eax
  d2:	83 f8 01             	cmp    $0x1,%eax
  d5:	75 18                	jne    ef <print_info+0x78>
    {
        printf(1, "YES");
  d7:	48 c7 c6 3f 0e 00 00 	mov    $0xe3f,%rsi
  de:	bf 01 00 00 00       	mov    $0x1,%edi
  e3:	b8 00 00 00 00       	mov    $0x0,%eax
  e8:	e8 46 07 00 00       	call   833 <printf>
  ed:	eb 16                	jmp    105 <print_info+0x8e>
    }
    else 
    {
        printf(1, "NO");
  ef:	48 c7 c6 43 0e 00 00 	mov    $0xe43,%rsi
  f6:	bf 01 00 00 00       	mov    $0x1,%edi
  fb:	b8 00 00 00 00       	mov    $0x0,%eax
 100:	e8 2e 07 00 00       	call   833 <printf>
    }

    printf(1, "\n");
 105:	48 c7 c6 46 0e 00 00 	mov    $0xe46,%rsi
 10c:	bf 01 00 00 00       	mov    $0x1,%edi
 111:	b8 00 00 00 00       	mov    $0x0,%eax
 116:	e8 18 07 00 00       	call   833 <printf>
}
 11b:	90                   	nop
 11c:	c9                   	leave
 11d:	c3                   	ret

000000000000011e <find_pid>:

/* Return the index of a process inside the pstat array */
int
find_pid(struct pstat *pstat, int pid)
{
 11e:	55                   	push   %rbp
 11f:	48 89 e5             	mov    %rsp,%rbp
 122:	48 83 ec 20          	sub    $0x20,%rsp
 126:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
 12a:	89 75 e4             	mov    %esi,-0x1c(%rbp)
    int i;
    for (i = 0; i < NPROC; i++)
 12d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
 134:	eb 1f                	jmp    155 <find_pid+0x37>
    {
        if (pstat->pid[i] == pid) 
 136:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 13a:	8b 55 fc             	mov    -0x4(%rbp),%edx
 13d:	48 63 d2             	movslq %edx,%rdx
 140:	48 83 ea 80          	sub    $0xffffffffffffff80,%rdx
 144:	8b 04 90             	mov    (%rax,%rdx,4),%eax
 147:	39 45 e4             	cmp    %eax,-0x1c(%rbp)
 14a:	75 05                	jne    151 <find_pid+0x33>
        {
            return i;
 14c:	8b 45 fc             	mov    -0x4(%rbp),%eax
 14f:	eb 0f                	jmp    160 <find_pid+0x42>
    for (i = 0; i < NPROC; i++)
 151:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
 155:	83 7d fc 3f          	cmpl   $0x3f,-0x4(%rbp)
 159:	7e db                	jle    136 <find_pid+0x18>
        }
    }
    return -1;
 15b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
 160:	c9                   	leave
 161:	c3                   	ret

0000000000000162 <main>:
// Uncomment the below line after you've implemented the "settickets" system call
// #define TICKETS 

int
main(int argc, char *argv[])
{
 162:	55                   	push   %rbp
 163:	48 89 e5             	mov    %rsp,%rbp
 166:	48 81 ec 50 04 00 00 	sub    $0x450,%rsp
 16d:	89 bd bc fb ff ff    	mov    %edi,-0x444(%rbp)
 173:	48 89 b5 b0 fb ff ff 	mov    %rsi,-0x450(%rbp)

    int pid_chds[N_C_PROCS];

    int n_tickets[N_C_PROCS]={2,1,300};
 17a:	c7 45 cc 02 00 00 00 	movl   $0x2,-0x34(%rbp)
 181:	c7 45 d0 01 00 00 00 	movl   $0x1,-0x30(%rbp)
 188:	c7 45 d4 2c 01 00 00 	movl   $0x12c,-0x2c(%rbp)
    pid_chds[0] = getpid();
 18f:	e8 8d 05 00 00       	call   721 <getpid>
 194:	89 45 d8             	mov    %eax,-0x28(%rbp)
#ifdef TICKETS
    settickets(n_tickets[0]);
#endif

    int i; 
    for (i = 1; i < N_C_PROCS; i++) 
 197:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%rbp)
 19e:	eb 36                	jmp    1d6 <main+0x74>
    {
        if ((pid_chds[i] = fork()) == 0) 
 1a0:	e8 f4 04 00 00       	call   699 <fork>
 1a5:	8b 55 fc             	mov    -0x4(%rbp),%edx
 1a8:	48 63 d2             	movslq %edx,%rdx
 1ab:	89 44 95 d8          	mov    %eax,-0x28(%rbp,%rdx,4)
 1af:	8b 45 fc             	mov    -0x4(%rbp),%eax
 1b2:	48 98                	cltq
 1b4:	8b 44 85 d8          	mov    -0x28(%rbp,%rax,4),%eax
 1b8:	85 c0                	test   %eax,%eax
 1ba:	75 16                	jne    1d2 <main+0x70>
        {
#ifdef TICKETS
            settickets(n_tickets[i]);
#endif
            int n_spin = LTICKS(5);
 1bc:	c7 45 e4 40 4b 4c 00 	movl   $0x4c4b40,-0x1c(%rbp)
            spin(n_spin);
 1c3:	8b 45 e4             	mov    -0x1c(%rbp),%eax
 1c6:	89 c7                	mov    %eax,%edi
 1c8:	e8 33 fe ff ff       	call   0 <spin>
            exit();
 1cd:	e8 cf 04 00 00       	call   6a1 <exit>
    for (i = 1; i < N_C_PROCS; i++) 
 1d2:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
 1d6:	83 7d fc 02          	cmpl   $0x2,-0x4(%rbp)
 1da:	7e c4                	jle    1a0 <main+0x3e>
        }
    }

    struct pstat pstat;
    int t = 0;
 1dc:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)

    printf(1, "PIDs of child processes:\n");
 1e3:	48 c7 c6 48 0e 00 00 	mov    $0xe48,%rsi
 1ea:	bf 01 00 00 00       	mov    $0x1,%edi
 1ef:	b8 00 00 00 00       	mov    $0x0,%eax
 1f4:	e8 3a 06 00 00       	call   833 <printf>
    for (i = 0; i < N_C_PROCS; i++) 
 1f9:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
 200:	eb 25                	jmp    227 <main+0xc5>
    {
        printf(1, "- pid %d\n", pid_chds[i]);
 202:	8b 45 fc             	mov    -0x4(%rbp),%eax
 205:	48 98                	cltq
 207:	8b 44 85 d8          	mov    -0x28(%rbp,%rax,4),%eax
 20b:	89 c2                	mov    %eax,%edx
 20d:	48 c7 c6 62 0e 00 00 	mov    $0xe62,%rsi
 214:	bf 01 00 00 00       	mov    $0x1,%edi
 219:	b8 00 00 00 00       	mov    $0x0,%eax
 21e:	e8 10 06 00 00       	call   833 <printf>
    for (i = 0; i < N_C_PROCS; i++) 
 223:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
 227:	83 7d fc 02          	cmpl   $0x2,-0x4(%rbp)
 22b:	7e d5                	jle    202 <main+0xa0>
    }
    printf(1, "\n");
 22d:	48 c7 c6 46 0e 00 00 	mov    $0xe46,%rsi
 234:	bf 01 00 00 00       	mov    $0x1,%edi
 239:	b8 00 00 00 00       	mov    $0x0,%eax
 23e:	e8 f0 05 00 00       	call   833 <printf>

    printf(1, "PID\tTICKS\tIN USE\n");
 243:	48 c7 c6 6c 0e 00 00 	mov    $0xe6c,%rsi
 24a:	bf 01 00 00 00       	mov    $0x1,%edi
 24f:	b8 00 00 00 00       	mov    $0x0,%eax
 254:	e8 da 05 00 00       	call   833 <printf>
    
    // int n_time = atoi(argv[1]); /* You can pass the number of time-steps as a command line argument if you uncomment this. Hard-coded for now. */
    int n_time = TIMESTEPS;
 259:	c7 45 f0 64 00 00 00 	movl   $0x64,-0x10(%rbp)

    spin(LTICKS(1));
 260:	bf 40 42 0f 00       	mov    $0xf4240,%edi
 265:	e8 96 fd ff ff       	call   0 <spin>

    /* Every few seconds, print the process information. */
    while (t < n_time) 
 26a:	e9 f0 00 00 00       	jmp    35f <main+0x1fd>
    {
        
        if (getpinfo(&pstat) != 0) 
 26f:	48 8d 85 c0 fb ff ff 	lea    -0x440(%rbp),%rax
 276:	48 89 c7             	mov    %rax,%rdi
 279:	e8 c3 04 00 00       	call   741 <getpinfo>
 27e:	85 c0                	test   %eax,%eax
 280:	74 1b                	je     29d <main+0x13b>
        {
            printf(1, "getpinfo failed\n");
 282:	48 c7 c6 7e 0e 00 00 	mov    $0xe7e,%rsi
 289:	bf 01 00 00 00       	mov    $0x1,%edi
 28e:	b8 00 00 00 00       	mov    $0x0,%eax
 293:	e8 9b 05 00 00       	call   833 <printf>
            goto exit;
 298:	e9 d1 00 00 00       	jmp    36e <main+0x20c>
        }

        int j; int pid;
        for (i = 0; i < N_C_PROCS; i++)
 29d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
 2a4:	eb 3b                	jmp    2e1 <main+0x17f>
        {
            pid = pid_chds[i];
 2a6:	8b 45 fc             	mov    -0x4(%rbp),%eax
 2a9:	48 98                	cltq
 2ab:	8b 44 85 d8          	mov    -0x28(%rbp,%rax,4),%eax
 2af:	89 45 e8             	mov    %eax,-0x18(%rbp)
            j = find_pid(&pstat, pid);
 2b2:	8b 55 e8             	mov    -0x18(%rbp),%edx
 2b5:	48 8d 85 c0 fb ff ff 	lea    -0x440(%rbp),%rax
 2bc:	89 d6                	mov    %edx,%esi
 2be:	48 89 c7             	mov    %rax,%rdi
 2c1:	e8 58 fe ff ff       	call   11e <find_pid>
 2c6:	89 45 ec             	mov    %eax,-0x14(%rbp)
            print_info(&pstat, j);
 2c9:	8b 55 ec             	mov    -0x14(%rbp),%edx
 2cc:	48 8d 85 c0 fb ff ff 	lea    -0x440(%rbp),%rax
 2d3:	89 d6                	mov    %edx,%esi
 2d5:	48 89 c7             	mov    %rax,%rdi
 2d8:	e8 9a fd ff ff       	call   77 <print_info>
        for (i = 0; i < N_C_PROCS; i++)
 2dd:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
 2e1:	83 7d fc 02          	cmpl   $0x2,-0x4(%rbp)
 2e5:	7e bf                	jle    2a6 <main+0x144>
        }

        int all_done = 1;
 2e7:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%rbp)
        for (i = 1; i < N_C_PROCS; i++)
 2ee:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%rbp)
 2f5:	eb 38                	jmp    32f <main+0x1cd>
        {
            j = find_pid(&pstat, pid_chds[i]);
 2f7:	8b 45 fc             	mov    -0x4(%rbp),%eax
 2fa:	48 98                	cltq
 2fc:	8b 54 85 d8          	mov    -0x28(%rbp,%rax,4),%edx
 300:	48 8d 85 c0 fb ff ff 	lea    -0x440(%rbp),%rax
 307:	89 d6                	mov    %edx,%esi
 309:	48 89 c7             	mov    %rax,%rdi
 30c:	e8 0d fe ff ff       	call   11e <find_pid>
 311:	89 45 ec             	mov    %eax,-0x14(%rbp)
            all_done &= !pstat.inuse[j];
 314:	8b 45 ec             	mov    -0x14(%rbp),%eax
 317:	48 98                	cltq
 319:	8b 84 85 c0 fb ff ff 	mov    -0x440(%rbp,%rax,4),%eax
 320:	85 c0                	test   %eax,%eax
 322:	0f 94 c0             	sete   %al
 325:	0f b6 c0             	movzbl %al,%eax
 328:	21 45 f4             	and    %eax,-0xc(%rbp)
        for (i = 1; i < N_C_PROCS; i++)
 32b:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
 32f:	83 7d fc 02          	cmpl   $0x2,-0x4(%rbp)
 333:	7e c2                	jle    2f7 <main+0x195>
        }
        if (all_done) break;
 335:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
 339:	75 32                	jne    36d <main+0x20b>

        spin(LTICKS(1));
 33b:	bf 40 42 0f 00       	mov    $0xf4240,%edi
 340:	e8 bb fc ff ff       	call   0 <spin>
        t++;
 345:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
        printf(1, "\n");
 349:	48 c7 c6 46 0e 00 00 	mov    $0xe46,%rsi
 350:	bf 01 00 00 00       	mov    $0x1,%edi
 355:	b8 00 00 00 00       	mov    $0x0,%eax
 35a:	e8 d4 04 00 00       	call   833 <printf>
    while (t < n_time) 
 35f:	8b 45 f8             	mov    -0x8(%rbp),%eax
 362:	3b 45 f0             	cmp    -0x10(%rbp),%eax
 365:	0f 8c 04 ff ff ff    	jl     26f <main+0x10d>
    }

    /* Finally, kill all child processes. */
exit:
 36b:	eb 01                	jmp    36e <main+0x20c>
        if (all_done) break;
 36d:	90                   	nop
    for (i = 1; pid_chds[i] > 0 && i < N_C_PROCS; i++) 
 36e:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%rbp)
 375:	eb 14                	jmp    38b <main+0x229>
    {
        kill(pid_chds[i]);
 377:	8b 45 fc             	mov    -0x4(%rbp),%eax
 37a:	48 98                	cltq
 37c:	8b 44 85 d8          	mov    -0x28(%rbp,%rax,4),%eax
 380:	89 c7                	mov    %eax,%edi
 382:	e8 4a 03 00 00       	call   6d1 <kill>
    for (i = 1; pid_chds[i] > 0 && i < N_C_PROCS; i++) 
 387:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
 38b:	8b 45 fc             	mov    -0x4(%rbp),%eax
 38e:	48 98                	cltq
 390:	8b 44 85 d8          	mov    -0x28(%rbp,%rax,4),%eax
 394:	85 c0                	test   %eax,%eax
 396:	7e 06                	jle    39e <main+0x23c>
 398:	83 7d fc 02          	cmpl   $0x2,-0x4(%rbp)
 39c:	7e d9                	jle    377 <main+0x215>
    }
    while(wait() != -1);
 39e:	90                   	nop
 39f:	e8 05 03 00 00       	call   6a9 <wait>
 3a4:	83 f8 ff             	cmp    $0xffffffff,%eax
 3a7:	75 f6                	jne    39f <main+0x23d>

    exit();
 3a9:	e8 f3 02 00 00       	call   6a1 <exit>

00000000000003ae <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
 3ae:	55                   	push   %rbp
 3af:	48 89 e5             	mov    %rsp,%rbp
 3b2:	48 83 ec 10          	sub    $0x10,%rsp
 3b6:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
 3ba:	89 75 f4             	mov    %esi,-0xc(%rbp)
 3bd:	89 55 f0             	mov    %edx,-0x10(%rbp)
  asm volatile("cld; rep stosb" :
 3c0:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
 3c4:	8b 55 f0             	mov    -0x10(%rbp),%edx
 3c7:	8b 45 f4             	mov    -0xc(%rbp),%eax
 3ca:	48 89 ce             	mov    %rcx,%rsi
 3cd:	48 89 f7             	mov    %rsi,%rdi
 3d0:	89 d1                	mov    %edx,%ecx
 3d2:	fc                   	cld
 3d3:	f3 aa                	rep stos %al,%es:(%rdi)
 3d5:	89 ca                	mov    %ecx,%edx
 3d7:	48 89 fe             	mov    %rdi,%rsi
 3da:	48 89 75 f8          	mov    %rsi,-0x8(%rbp)
 3de:	89 55 f0             	mov    %edx,-0x10(%rbp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
 3e1:	90                   	nop
 3e2:	c9                   	leave
 3e3:	c3                   	ret

00000000000003e4 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 3e4:	55                   	push   %rbp
 3e5:	48 89 e5             	mov    %rsp,%rbp
 3e8:	48 83 ec 20          	sub    $0x20,%rsp
 3ec:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
 3f0:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  char *os;

  os = s;
 3f4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 3f8:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  while((*s++ = *t++) != 0)
 3fc:	90                   	nop
 3fd:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
 401:	48 8d 42 01          	lea    0x1(%rdx),%rax
 405:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
 409:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 40d:	48 8d 48 01          	lea    0x1(%rax),%rcx
 411:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
 415:	0f b6 12             	movzbl (%rdx),%edx
 418:	88 10                	mov    %dl,(%rax)
 41a:	0f b6 00             	movzbl (%rax),%eax
 41d:	84 c0                	test   %al,%al
 41f:	75 dc                	jne    3fd <strcpy+0x19>
    ;
  return os;
 421:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
 425:	c9                   	leave
 426:	c3                   	ret

0000000000000427 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 427:	55                   	push   %rbp
 428:	48 89 e5             	mov    %rsp,%rbp
 42b:	48 83 ec 10          	sub    $0x10,%rsp
 42f:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
 433:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  while(*p && *p == *q)
 437:	eb 0a                	jmp    443 <strcmp+0x1c>
    p++, q++;
 439:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
 43e:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  while(*p && *p == *q)
 443:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 447:	0f b6 00             	movzbl (%rax),%eax
 44a:	84 c0                	test   %al,%al
 44c:	74 12                	je     460 <strcmp+0x39>
 44e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 452:	0f b6 10             	movzbl (%rax),%edx
 455:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 459:	0f b6 00             	movzbl (%rax),%eax
 45c:	38 c2                	cmp    %al,%dl
 45e:	74 d9                	je     439 <strcmp+0x12>
  return (uchar)*p - (uchar)*q;
 460:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 464:	0f b6 00             	movzbl (%rax),%eax
 467:	0f b6 d0             	movzbl %al,%edx
 46a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 46e:	0f b6 00             	movzbl (%rax),%eax
 471:	0f b6 c0             	movzbl %al,%eax
 474:	29 c2                	sub    %eax,%edx
 476:	89 d0                	mov    %edx,%eax
}
 478:	c9                   	leave
 479:	c3                   	ret

000000000000047a <strlen>:

uint
strlen(char *s)
{
 47a:	55                   	push   %rbp
 47b:	48 89 e5             	mov    %rsp,%rbp
 47e:	48 83 ec 18          	sub    $0x18,%rsp
 482:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  int n;

  for(n = 0; s[n]; n++)
 486:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
 48d:	eb 04                	jmp    493 <strlen+0x19>
 48f:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
 493:	8b 45 fc             	mov    -0x4(%rbp),%eax
 496:	48 63 d0             	movslq %eax,%rdx
 499:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 49d:	48 01 d0             	add    %rdx,%rax
 4a0:	0f b6 00             	movzbl (%rax),%eax
 4a3:	84 c0                	test   %al,%al
 4a5:	75 e8                	jne    48f <strlen+0x15>
    ;
  return n;
 4a7:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
 4aa:	c9                   	leave
 4ab:	c3                   	ret

00000000000004ac <memset>:

void*
memset(void *dst, int c, uint n)
{
 4ac:	55                   	push   %rbp
 4ad:	48 89 e5             	mov    %rsp,%rbp
 4b0:	48 83 ec 10          	sub    $0x10,%rsp
 4b4:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
 4b8:	89 75 f4             	mov    %esi,-0xc(%rbp)
 4bb:	89 55 f0             	mov    %edx,-0x10(%rbp)
  stosb(dst, c, n);
 4be:	8b 55 f0             	mov    -0x10(%rbp),%edx
 4c1:	8b 4d f4             	mov    -0xc(%rbp),%ecx
 4c4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 4c8:	89 ce                	mov    %ecx,%esi
 4ca:	48 89 c7             	mov    %rax,%rdi
 4cd:	e8 dc fe ff ff       	call   3ae <stosb>
  return dst;
 4d2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
 4d6:	c9                   	leave
 4d7:	c3                   	ret

00000000000004d8 <strchr>:

char*
strchr(const char *s, char c)
{
 4d8:	55                   	push   %rbp
 4d9:	48 89 e5             	mov    %rsp,%rbp
 4dc:	48 83 ec 10          	sub    $0x10,%rsp
 4e0:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
 4e4:	89 f0                	mov    %esi,%eax
 4e6:	88 45 f4             	mov    %al,-0xc(%rbp)
  for(; *s; s++)
 4e9:	eb 17                	jmp    502 <strchr+0x2a>
    if(*s == c)
 4eb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 4ef:	0f b6 00             	movzbl (%rax),%eax
 4f2:	38 45 f4             	cmp    %al,-0xc(%rbp)
 4f5:	75 06                	jne    4fd <strchr+0x25>
      return (char*)s;
 4f7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 4fb:	eb 15                	jmp    512 <strchr+0x3a>
  for(; *s; s++)
 4fd:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
 502:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 506:	0f b6 00             	movzbl (%rax),%eax
 509:	84 c0                	test   %al,%al
 50b:	75 de                	jne    4eb <strchr+0x13>
  return 0;
 50d:	b8 00 00 00 00       	mov    $0x0,%eax
}
 512:	c9                   	leave
 513:	c3                   	ret

0000000000000514 <gets>:

char*
gets(char *buf, int max)
{
 514:	55                   	push   %rbp
 515:	48 89 e5             	mov    %rsp,%rbp
 518:	48 83 ec 20          	sub    $0x20,%rsp
 51c:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
 520:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 523:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
 52a:	eb 48                	jmp    574 <gets+0x60>
    cc = read(0, &c, 1);
 52c:	48 8d 45 f7          	lea    -0x9(%rbp),%rax
 530:	ba 01 00 00 00       	mov    $0x1,%edx
 535:	48 89 c6             	mov    %rax,%rsi
 538:	bf 00 00 00 00       	mov    $0x0,%edi
 53d:	e8 77 01 00 00       	call   6b9 <read>
 542:	89 45 f8             	mov    %eax,-0x8(%rbp)
    if(cc < 1)
 545:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
 549:	7e 36                	jle    581 <gets+0x6d>
      break;
    buf[i++] = c;
 54b:	8b 45 fc             	mov    -0x4(%rbp),%eax
 54e:	8d 50 01             	lea    0x1(%rax),%edx
 551:	89 55 fc             	mov    %edx,-0x4(%rbp)
 554:	48 63 d0             	movslq %eax,%rdx
 557:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 55b:	48 01 c2             	add    %rax,%rdx
 55e:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
 562:	88 02                	mov    %al,(%rdx)
    if(c == '\n' || c == '\r')
 564:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
 568:	3c 0a                	cmp    $0xa,%al
 56a:	74 16                	je     582 <gets+0x6e>
 56c:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
 570:	3c 0d                	cmp    $0xd,%al
 572:	74 0e                	je     582 <gets+0x6e>
  for(i=0; i+1 < max; ){
 574:	8b 45 fc             	mov    -0x4(%rbp),%eax
 577:	83 c0 01             	add    $0x1,%eax
 57a:	39 45 e4             	cmp    %eax,-0x1c(%rbp)
 57d:	7f ad                	jg     52c <gets+0x18>
 57f:	eb 01                	jmp    582 <gets+0x6e>
      break;
 581:	90                   	nop
      break;
  }
  buf[i] = '\0';
 582:	8b 45 fc             	mov    -0x4(%rbp),%eax
 585:	48 63 d0             	movslq %eax,%rdx
 588:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 58c:	48 01 d0             	add    %rdx,%rax
 58f:	c6 00 00             	movb   $0x0,(%rax)
  return buf;
 592:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
 596:	c9                   	leave
 597:	c3                   	ret

0000000000000598 <stat>:

int
stat(char *n, struct stat *st)
{
 598:	55                   	push   %rbp
 599:	48 89 e5             	mov    %rsp,%rbp
 59c:	48 83 ec 20          	sub    $0x20,%rsp
 5a0:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
 5a4:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 5a8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 5ac:	be 00 00 00 00       	mov    $0x0,%esi
 5b1:	48 89 c7             	mov    %rax,%rdi
 5b4:	e8 28 01 00 00       	call   6e1 <open>
 5b9:	89 45 fc             	mov    %eax,-0x4(%rbp)
  if(fd < 0)
 5bc:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
 5c0:	79 07                	jns    5c9 <stat+0x31>
    return -1;
 5c2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 5c7:	eb 21                	jmp    5ea <stat+0x52>
  r = fstat(fd, st);
 5c9:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
 5cd:	8b 45 fc             	mov    -0x4(%rbp),%eax
 5d0:	48 89 d6             	mov    %rdx,%rsi
 5d3:	89 c7                	mov    %eax,%edi
 5d5:	e8 1f 01 00 00       	call   6f9 <fstat>
 5da:	89 45 f8             	mov    %eax,-0x8(%rbp)
  close(fd);
 5dd:	8b 45 fc             	mov    -0x4(%rbp),%eax
 5e0:	89 c7                	mov    %eax,%edi
 5e2:	e8 e2 00 00 00       	call   6c9 <close>
  return r;
 5e7:	8b 45 f8             	mov    -0x8(%rbp),%eax
}
 5ea:	c9                   	leave
 5eb:	c3                   	ret

00000000000005ec <atoi>:

int
atoi(const char *s)
{
 5ec:	55                   	push   %rbp
 5ed:	48 89 e5             	mov    %rsp,%rbp
 5f0:	48 83 ec 18          	sub    $0x18,%rsp
 5f4:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  int n;

  n = 0;
 5f8:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  while('0' <= *s && *s <= '9')
 5ff:	eb 28                	jmp    629 <atoi+0x3d>
    n = n*10 + *s++ - '0';
 601:	8b 55 fc             	mov    -0x4(%rbp),%edx
 604:	89 d0                	mov    %edx,%eax
 606:	c1 e0 02             	shl    $0x2,%eax
 609:	01 d0                	add    %edx,%eax
 60b:	01 c0                	add    %eax,%eax
 60d:	89 c1                	mov    %eax,%ecx
 60f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 613:	48 8d 50 01          	lea    0x1(%rax),%rdx
 617:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
 61b:	0f b6 00             	movzbl (%rax),%eax
 61e:	0f be c0             	movsbl %al,%eax
 621:	01 c8                	add    %ecx,%eax
 623:	83 e8 30             	sub    $0x30,%eax
 626:	89 45 fc             	mov    %eax,-0x4(%rbp)
  while('0' <= *s && *s <= '9')
 629:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 62d:	0f b6 00             	movzbl (%rax),%eax
 630:	3c 2f                	cmp    $0x2f,%al
 632:	7e 0b                	jle    63f <atoi+0x53>
 634:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 638:	0f b6 00             	movzbl (%rax),%eax
 63b:	3c 39                	cmp    $0x39,%al
 63d:	7e c2                	jle    601 <atoi+0x15>
  return n;
 63f:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
 642:	c9                   	leave
 643:	c3                   	ret

0000000000000644 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 644:	55                   	push   %rbp
 645:	48 89 e5             	mov    %rsp,%rbp
 648:	48 83 ec 28          	sub    $0x28,%rsp
 64c:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
 650:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
 654:	89 55 dc             	mov    %edx,-0x24(%rbp)
  char *dst, *src;
  
  dst = vdst;
 657:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 65b:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  src = vsrc;
 65f:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
 663:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  while(n-- > 0)
 667:	eb 1d                	jmp    686 <memmove+0x42>
    *dst++ = *src++;
 669:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
 66d:	48 8d 42 01          	lea    0x1(%rdx),%rax
 671:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
 675:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 679:	48 8d 48 01          	lea    0x1(%rax),%rcx
 67d:	48 89 4d f8          	mov    %rcx,-0x8(%rbp)
 681:	0f b6 12             	movzbl (%rdx),%edx
 684:	88 10                	mov    %dl,(%rax)
  while(n-- > 0)
 686:	8b 45 dc             	mov    -0x24(%rbp),%eax
 689:	8d 50 ff             	lea    -0x1(%rax),%edx
 68c:	89 55 dc             	mov    %edx,-0x24(%rbp)
 68f:	85 c0                	test   %eax,%eax
 691:	7f d6                	jg     669 <memmove+0x25>
  return vdst;
 693:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
 697:	c9                   	leave
 698:	c3                   	ret

0000000000000699 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 699:	b8 01 00 00 00       	mov    $0x1,%eax
 69e:	cd 40                	int    $0x40
 6a0:	c3                   	ret

00000000000006a1 <exit>:
SYSCALL(exit)
 6a1:	b8 02 00 00 00       	mov    $0x2,%eax
 6a6:	cd 40                	int    $0x40
 6a8:	c3                   	ret

00000000000006a9 <wait>:
SYSCALL(wait)
 6a9:	b8 03 00 00 00       	mov    $0x3,%eax
 6ae:	cd 40                	int    $0x40
 6b0:	c3                   	ret

00000000000006b1 <pipe>:
SYSCALL(pipe)
 6b1:	b8 04 00 00 00       	mov    $0x4,%eax
 6b6:	cd 40                	int    $0x40
 6b8:	c3                   	ret

00000000000006b9 <read>:
SYSCALL(read)
 6b9:	b8 05 00 00 00       	mov    $0x5,%eax
 6be:	cd 40                	int    $0x40
 6c0:	c3                   	ret

00000000000006c1 <write>:
SYSCALL(write)
 6c1:	b8 10 00 00 00       	mov    $0x10,%eax
 6c6:	cd 40                	int    $0x40
 6c8:	c3                   	ret

00000000000006c9 <close>:
SYSCALL(close)
 6c9:	b8 15 00 00 00       	mov    $0x15,%eax
 6ce:	cd 40                	int    $0x40
 6d0:	c3                   	ret

00000000000006d1 <kill>:
SYSCALL(kill)
 6d1:	b8 06 00 00 00       	mov    $0x6,%eax
 6d6:	cd 40                	int    $0x40
 6d8:	c3                   	ret

00000000000006d9 <exec>:
SYSCALL(exec)
 6d9:	b8 07 00 00 00       	mov    $0x7,%eax
 6de:	cd 40                	int    $0x40
 6e0:	c3                   	ret

00000000000006e1 <open>:
SYSCALL(open)
 6e1:	b8 0f 00 00 00       	mov    $0xf,%eax
 6e6:	cd 40                	int    $0x40
 6e8:	c3                   	ret

00000000000006e9 <mknod>:
SYSCALL(mknod)
 6e9:	b8 11 00 00 00       	mov    $0x11,%eax
 6ee:	cd 40                	int    $0x40
 6f0:	c3                   	ret

00000000000006f1 <unlink>:
SYSCALL(unlink)
 6f1:	b8 12 00 00 00       	mov    $0x12,%eax
 6f6:	cd 40                	int    $0x40
 6f8:	c3                   	ret

00000000000006f9 <fstat>:
SYSCALL(fstat)
 6f9:	b8 08 00 00 00       	mov    $0x8,%eax
 6fe:	cd 40                	int    $0x40
 700:	c3                   	ret

0000000000000701 <link>:
SYSCALL(link)
 701:	b8 13 00 00 00       	mov    $0x13,%eax
 706:	cd 40                	int    $0x40
 708:	c3                   	ret

0000000000000709 <mkdir>:
SYSCALL(mkdir)
 709:	b8 14 00 00 00       	mov    $0x14,%eax
 70e:	cd 40                	int    $0x40
 710:	c3                   	ret

0000000000000711 <chdir>:
SYSCALL(chdir)
 711:	b8 09 00 00 00       	mov    $0x9,%eax
 716:	cd 40                	int    $0x40
 718:	c3                   	ret

0000000000000719 <dup>:
SYSCALL(dup)
 719:	b8 0a 00 00 00       	mov    $0xa,%eax
 71e:	cd 40                	int    $0x40
 720:	c3                   	ret

0000000000000721 <getpid>:
SYSCALL(getpid)
 721:	b8 0b 00 00 00       	mov    $0xb,%eax
 726:	cd 40                	int    $0x40
 728:	c3                   	ret

0000000000000729 <sbrk>:
SYSCALL(sbrk)
 729:	b8 0c 00 00 00       	mov    $0xc,%eax
 72e:	cd 40                	int    $0x40
 730:	c3                   	ret

0000000000000731 <sleep>:
SYSCALL(sleep)
 731:	b8 0d 00 00 00       	mov    $0xd,%eax
 736:	cd 40                	int    $0x40
 738:	c3                   	ret

0000000000000739 <uptime>:
SYSCALL(uptime)
 739:	b8 0e 00 00 00       	mov    $0xe,%eax
 73e:	cd 40                	int    $0x40
 740:	c3                   	ret

0000000000000741 <getpinfo>:
SYSCALL(getpinfo)
 741:	b8 18 00 00 00       	mov    $0x18,%eax
 746:	cd 40                	int    $0x40
 748:	c3                   	ret

0000000000000749 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 749:	55                   	push   %rbp
 74a:	48 89 e5             	mov    %rsp,%rbp
 74d:	48 83 ec 10          	sub    $0x10,%rsp
 751:	89 7d fc             	mov    %edi,-0x4(%rbp)
 754:	89 f0                	mov    %esi,%eax
 756:	88 45 f8             	mov    %al,-0x8(%rbp)
  write(fd, &c, 1);
 759:	48 8d 4d f8          	lea    -0x8(%rbp),%rcx
 75d:	8b 45 fc             	mov    -0x4(%rbp),%eax
 760:	ba 01 00 00 00       	mov    $0x1,%edx
 765:	48 89 ce             	mov    %rcx,%rsi
 768:	89 c7                	mov    %eax,%edi
 76a:	e8 52 ff ff ff       	call   6c1 <write>
}
 76f:	90                   	nop
 770:	c9                   	leave
 771:	c3                   	ret

0000000000000772 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 772:	55                   	push   %rbp
 773:	48 89 e5             	mov    %rsp,%rbp
 776:	48 83 ec 30          	sub    $0x30,%rsp
 77a:	89 7d dc             	mov    %edi,-0x24(%rbp)
 77d:	89 75 d8             	mov    %esi,-0x28(%rbp)
 780:	89 55 d4             	mov    %edx,-0x2c(%rbp)
 783:	89 4d d0             	mov    %ecx,-0x30(%rbp)
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 786:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
  if(sgn && xx < 0){
 78d:	83 7d d0 00          	cmpl   $0x0,-0x30(%rbp)
 791:	74 17                	je     7aa <printint+0x38>
 793:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
 797:	79 11                	jns    7aa <printint+0x38>
    neg = 1;
 799:	c7 45 f8 01 00 00 00 	movl   $0x1,-0x8(%rbp)
    x = -xx;
 7a0:	8b 45 d8             	mov    -0x28(%rbp),%eax
 7a3:	f7 d8                	neg    %eax
 7a5:	89 45 f4             	mov    %eax,-0xc(%rbp)
 7a8:	eb 06                	jmp    7b0 <printint+0x3e>
  } else {
    x = xx;
 7aa:	8b 45 d8             	mov    -0x28(%rbp),%eax
 7ad:	89 45 f4             	mov    %eax,-0xc(%rbp)
  }

  i = 0;
 7b0:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  do{
    buf[i++] = digits[x % base];
 7b7:	8b 4d d4             	mov    -0x2c(%rbp),%ecx
 7ba:	8b 45 f4             	mov    -0xc(%rbp),%eax
 7bd:	ba 00 00 00 00       	mov    $0x0,%edx
 7c2:	f7 f1                	div    %ecx
 7c4:	89 d1                	mov    %edx,%ecx
 7c6:	8b 45 fc             	mov    -0x4(%rbp),%eax
 7c9:	8d 50 01             	lea    0x1(%rax),%edx
 7cc:	89 55 fc             	mov    %edx,-0x4(%rbp)
 7cf:	89 ca                	mov    %ecx,%edx
 7d1:	0f b6 92 30 11 00 00 	movzbl 0x1130(%rdx),%edx
 7d8:	48 98                	cltq
 7da:	88 54 05 e0          	mov    %dl,-0x20(%rbp,%rax,1)
  }while((x /= base) != 0);
 7de:	8b 75 d4             	mov    -0x2c(%rbp),%esi
 7e1:	8b 45 f4             	mov    -0xc(%rbp),%eax
 7e4:	ba 00 00 00 00       	mov    $0x0,%edx
 7e9:	f7 f6                	div    %esi
 7eb:	89 45 f4             	mov    %eax,-0xc(%rbp)
 7ee:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
 7f2:	75 c3                	jne    7b7 <printint+0x45>
  if(neg)
 7f4:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
 7f8:	74 2b                	je     825 <printint+0xb3>
    buf[i++] = '-';
 7fa:	8b 45 fc             	mov    -0x4(%rbp),%eax
 7fd:	8d 50 01             	lea    0x1(%rax),%edx
 800:	89 55 fc             	mov    %edx,-0x4(%rbp)
 803:	48 98                	cltq
 805:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%rbp,%rax,1)

  while(--i >= 0)
 80a:	eb 19                	jmp    825 <printint+0xb3>
    putc(fd, buf[i]);
 80c:	8b 45 fc             	mov    -0x4(%rbp),%eax
 80f:	48 98                	cltq
 811:	0f b6 44 05 e0       	movzbl -0x20(%rbp,%rax,1),%eax
 816:	0f be d0             	movsbl %al,%edx
 819:	8b 45 dc             	mov    -0x24(%rbp),%eax
 81c:	89 d6                	mov    %edx,%esi
 81e:	89 c7                	mov    %eax,%edi
 820:	e8 24 ff ff ff       	call   749 <putc>
  while(--i >= 0)
 825:	83 6d fc 01          	subl   $0x1,-0x4(%rbp)
 829:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
 82d:	79 dd                	jns    80c <printint+0x9a>
}
 82f:	90                   	nop
 830:	90                   	nop
 831:	c9                   	leave
 832:	c3                   	ret

0000000000000833 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 833:	55                   	push   %rbp
 834:	48 89 e5             	mov    %rsp,%rbp
 837:	48 81 ec f0 00 00 00 	sub    $0xf0,%rsp
 83e:	89 bd 1c ff ff ff    	mov    %edi,-0xe4(%rbp)
 844:	48 89 b5 10 ff ff ff 	mov    %rsi,-0xf0(%rbp)
 84b:	48 89 95 60 ff ff ff 	mov    %rdx,-0xa0(%rbp)
 852:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
 859:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
 860:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
 867:	84 c0                	test   %al,%al
 869:	74 20                	je     88b <printf+0x58>
 86b:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
 86f:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
 873:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
 877:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
 87b:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
 87f:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
 883:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
 887:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  va_list ap;
  char *s;
  int c, i, state;
  va_start(ap, fmt);
 88b:	c7 85 20 ff ff ff 10 	movl   $0x10,-0xe0(%rbp)
 892:	00 00 00 
 895:	c7 85 24 ff ff ff 30 	movl   $0x30,-0xdc(%rbp)
 89c:	00 00 00 
 89f:	48 8d 45 10          	lea    0x10(%rbp),%rax
 8a3:	48 89 85 28 ff ff ff 	mov    %rax,-0xd8(%rbp)
 8aa:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
 8b1:	48 89 85 30 ff ff ff 	mov    %rax,-0xd0(%rbp)

  state = 0;
 8b8:	c7 85 40 ff ff ff 00 	movl   $0x0,-0xc0(%rbp)
 8bf:	00 00 00 
  for(i = 0; fmt[i]; i++){
 8c2:	c7 85 44 ff ff ff 00 	movl   $0x0,-0xbc(%rbp)
 8c9:	00 00 00 
 8cc:	e9 a8 02 00 00       	jmp    b79 <printf+0x346>
    c = fmt[i] & 0xff;
 8d1:	8b 85 44 ff ff ff    	mov    -0xbc(%rbp),%eax
 8d7:	48 63 d0             	movslq %eax,%rdx
 8da:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
 8e1:	48 01 d0             	add    %rdx,%rax
 8e4:	0f b6 00             	movzbl (%rax),%eax
 8e7:	0f be c0             	movsbl %al,%eax
 8ea:	25 ff 00 00 00       	and    $0xff,%eax
 8ef:	89 85 3c ff ff ff    	mov    %eax,-0xc4(%rbp)
    if(state == 0){
 8f5:	83 bd 40 ff ff ff 00 	cmpl   $0x0,-0xc0(%rbp)
 8fc:	75 35                	jne    933 <printf+0x100>
      if(c == '%'){
 8fe:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
 905:	75 0f                	jne    916 <printf+0xe3>
        state = '%';
 907:	c7 85 40 ff ff ff 25 	movl   $0x25,-0xc0(%rbp)
 90e:	00 00 00 
 911:	e9 5c 02 00 00       	jmp    b72 <printf+0x33f>
      } else {
        putc(fd, c);
 916:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
 91c:	0f be d0             	movsbl %al,%edx
 91f:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 925:	89 d6                	mov    %edx,%esi
 927:	89 c7                	mov    %eax,%edi
 929:	e8 1b fe ff ff       	call   749 <putc>
 92e:	e9 3f 02 00 00       	jmp    b72 <printf+0x33f>
      }
    } else if(state == '%'){
 933:	83 bd 40 ff ff ff 25 	cmpl   $0x25,-0xc0(%rbp)
 93a:	0f 85 32 02 00 00    	jne    b72 <printf+0x33f>
      if(c == 'd'){
 940:	83 bd 3c ff ff ff 64 	cmpl   $0x64,-0xc4(%rbp)
 947:	75 5e                	jne    9a7 <printf+0x174>
        printint(fd, va_arg(ap, int), 10, 1);
 949:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 94f:	83 f8 2f             	cmp    $0x2f,%eax
 952:	77 23                	ja     977 <printf+0x144>
 954:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 95b:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 961:	89 d2                	mov    %edx,%edx
 963:	48 01 d0             	add    %rdx,%rax
 966:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 96c:	83 c2 08             	add    $0x8,%edx
 96f:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 975:	eb 12                	jmp    989 <printf+0x156>
 977:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 97e:	48 8d 50 08          	lea    0x8(%rax),%rdx
 982:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 989:	8b 30                	mov    (%rax),%esi
 98b:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 991:	b9 01 00 00 00       	mov    $0x1,%ecx
 996:	ba 0a 00 00 00       	mov    $0xa,%edx
 99b:	89 c7                	mov    %eax,%edi
 99d:	e8 d0 fd ff ff       	call   772 <printint>
 9a2:	e9 c1 01 00 00       	jmp    b68 <printf+0x335>
      } else if(c == 'x' || c == 'p'){
 9a7:	83 bd 3c ff ff ff 78 	cmpl   $0x78,-0xc4(%rbp)
 9ae:	74 09                	je     9b9 <printf+0x186>
 9b0:	83 bd 3c ff ff ff 70 	cmpl   $0x70,-0xc4(%rbp)
 9b7:	75 5e                	jne    a17 <printf+0x1e4>
        printint(fd, va_arg(ap, int), 16, 0);
 9b9:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 9bf:	83 f8 2f             	cmp    $0x2f,%eax
 9c2:	77 23                	ja     9e7 <printf+0x1b4>
 9c4:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 9cb:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 9d1:	89 d2                	mov    %edx,%edx
 9d3:	48 01 d0             	add    %rdx,%rax
 9d6:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 9dc:	83 c2 08             	add    $0x8,%edx
 9df:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 9e5:	eb 12                	jmp    9f9 <printf+0x1c6>
 9e7:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 9ee:	48 8d 50 08          	lea    0x8(%rax),%rdx
 9f2:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 9f9:	8b 30                	mov    (%rax),%esi
 9fb:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 a01:	b9 00 00 00 00       	mov    $0x0,%ecx
 a06:	ba 10 00 00 00       	mov    $0x10,%edx
 a0b:	89 c7                	mov    %eax,%edi
 a0d:	e8 60 fd ff ff       	call   772 <printint>
 a12:	e9 51 01 00 00       	jmp    b68 <printf+0x335>
      } else if(c == 's'){
 a17:	83 bd 3c ff ff ff 73 	cmpl   $0x73,-0xc4(%rbp)
 a1e:	0f 85 98 00 00 00    	jne    abc <printf+0x289>
        s = va_arg(ap, char*);
 a24:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 a2a:	83 f8 2f             	cmp    $0x2f,%eax
 a2d:	77 23                	ja     a52 <printf+0x21f>
 a2f:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 a36:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 a3c:	89 d2                	mov    %edx,%edx
 a3e:	48 01 d0             	add    %rdx,%rax
 a41:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 a47:	83 c2 08             	add    $0x8,%edx
 a4a:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 a50:	eb 12                	jmp    a64 <printf+0x231>
 a52:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 a59:	48 8d 50 08          	lea    0x8(%rax),%rdx
 a5d:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 a64:	48 8b 00             	mov    (%rax),%rax
 a67:	48 89 85 48 ff ff ff 	mov    %rax,-0xb8(%rbp)
        if(s == 0)
 a6e:	48 83 bd 48 ff ff ff 	cmpq   $0x0,-0xb8(%rbp)
 a75:	00 
 a76:	75 31                	jne    aa9 <printf+0x276>
          s = "(null)";
 a78:	48 c7 85 48 ff ff ff 	movq   $0xe8f,-0xb8(%rbp)
 a7f:	8f 0e 00 00 
        while(*s != 0){
 a83:	eb 24                	jmp    aa9 <printf+0x276>
          putc(fd, *s);
 a85:	48 8b 85 48 ff ff ff 	mov    -0xb8(%rbp),%rax
 a8c:	0f b6 00             	movzbl (%rax),%eax
 a8f:	0f be d0             	movsbl %al,%edx
 a92:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 a98:	89 d6                	mov    %edx,%esi
 a9a:	89 c7                	mov    %eax,%edi
 a9c:	e8 a8 fc ff ff       	call   749 <putc>
          s++;
 aa1:	48 83 85 48 ff ff ff 	addq   $0x1,-0xb8(%rbp)
 aa8:	01 
        while(*s != 0){
 aa9:	48 8b 85 48 ff ff ff 	mov    -0xb8(%rbp),%rax
 ab0:	0f b6 00             	movzbl (%rax),%eax
 ab3:	84 c0                	test   %al,%al
 ab5:	75 ce                	jne    a85 <printf+0x252>
 ab7:	e9 ac 00 00 00       	jmp    b68 <printf+0x335>
        }
      } else if(c == 'c'){
 abc:	83 bd 3c ff ff ff 63 	cmpl   $0x63,-0xc4(%rbp)
 ac3:	75 56                	jne    b1b <printf+0x2e8>
        putc(fd, va_arg(ap, uint));
 ac5:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 acb:	83 f8 2f             	cmp    $0x2f,%eax
 ace:	77 23                	ja     af3 <printf+0x2c0>
 ad0:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
 ad7:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 add:	89 d2                	mov    %edx,%edx
 adf:	48 01 d0             	add    %rdx,%rax
 ae2:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
 ae8:	83 c2 08             	add    $0x8,%edx
 aeb:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
 af1:	eb 12                	jmp    b05 <printf+0x2d2>
 af3:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
 afa:	48 8d 50 08          	lea    0x8(%rax),%rdx
 afe:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
 b05:	8b 00                	mov    (%rax),%eax
 b07:	0f be d0             	movsbl %al,%edx
 b0a:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 b10:	89 d6                	mov    %edx,%esi
 b12:	89 c7                	mov    %eax,%edi
 b14:	e8 30 fc ff ff       	call   749 <putc>
 b19:	eb 4d                	jmp    b68 <printf+0x335>
      } else if(c == '%'){
 b1b:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
 b22:	75 1a                	jne    b3e <printf+0x30b>
        putc(fd, c);
 b24:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
 b2a:	0f be d0             	movsbl %al,%edx
 b2d:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 b33:	89 d6                	mov    %edx,%esi
 b35:	89 c7                	mov    %eax,%edi
 b37:	e8 0d fc ff ff       	call   749 <putc>
 b3c:	eb 2a                	jmp    b68 <printf+0x335>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 b3e:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 b44:	be 25 00 00 00       	mov    $0x25,%esi
 b49:	89 c7                	mov    %eax,%edi
 b4b:	e8 f9 fb ff ff       	call   749 <putc>
        putc(fd, c);
 b50:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
 b56:	0f be d0             	movsbl %al,%edx
 b59:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
 b5f:	89 d6                	mov    %edx,%esi
 b61:	89 c7                	mov    %eax,%edi
 b63:	e8 e1 fb ff ff       	call   749 <putc>
      }
      state = 0;
 b68:	c7 85 40 ff ff ff 00 	movl   $0x0,-0xc0(%rbp)
 b6f:	00 00 00 
  for(i = 0; fmt[i]; i++){
 b72:	83 85 44 ff ff ff 01 	addl   $0x1,-0xbc(%rbp)
 b79:	8b 85 44 ff ff ff    	mov    -0xbc(%rbp),%eax
 b7f:	48 63 d0             	movslq %eax,%rdx
 b82:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
 b89:	48 01 d0             	add    %rdx,%rax
 b8c:	0f b6 00             	movzbl (%rax),%eax
 b8f:	84 c0                	test   %al,%al
 b91:	0f 85 3a fd ff ff    	jne    8d1 <printf+0x9e>
    }
  }
}
 b97:	90                   	nop
 b98:	90                   	nop
 b99:	c9                   	leave
 b9a:	c3                   	ret

0000000000000b9b <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 b9b:	55                   	push   %rbp
 b9c:	48 89 e5             	mov    %rsp,%rbp
 b9f:	48 83 ec 18          	sub    $0x18,%rsp
 ba3:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  Header *bp, *p;

  bp = (Header*)ap - 1;
 ba7:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 bab:	48 83 e8 10          	sub    $0x10,%rax
 baf:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 bb3:	48 8b 05 a6 05 00 00 	mov    0x5a6(%rip),%rax        # 1160 <freep>
 bba:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 bbe:	eb 2f                	jmp    bef <free+0x54>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 bc0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 bc4:	48 8b 00             	mov    (%rax),%rax
 bc7:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 bcb:	72 17                	jb     be4 <free+0x49>
 bcd:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 bd1:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 bd5:	72 2f                	jb     c06 <free+0x6b>
 bd7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 bdb:	48 8b 00             	mov    (%rax),%rax
 bde:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
 be2:	72 22                	jb     c06 <free+0x6b>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 be4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 be8:	48 8b 00             	mov    (%rax),%rax
 beb:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 bef:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 bf3:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 bf7:	73 c7                	jae    bc0 <free+0x25>
 bf9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 bfd:	48 8b 00             	mov    (%rax),%rax
 c00:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
 c04:	73 ba                	jae    bc0 <free+0x25>
      break;
  if(bp + bp->s.size == p->s.ptr){
 c06:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 c0a:	8b 40 08             	mov    0x8(%rax),%eax
 c0d:	89 c0                	mov    %eax,%eax
 c0f:	48 c1 e0 04          	shl    $0x4,%rax
 c13:	48 89 c2             	mov    %rax,%rdx
 c16:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 c1a:	48 01 c2             	add    %rax,%rdx
 c1d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 c21:	48 8b 00             	mov    (%rax),%rax
 c24:	48 39 c2             	cmp    %rax,%rdx
 c27:	75 2d                	jne    c56 <free+0xbb>
    bp->s.size += p->s.ptr->s.size;
 c29:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 c2d:	8b 50 08             	mov    0x8(%rax),%edx
 c30:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 c34:	48 8b 00             	mov    (%rax),%rax
 c37:	8b 40 08             	mov    0x8(%rax),%eax
 c3a:	01 c2                	add    %eax,%edx
 c3c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 c40:	89 50 08             	mov    %edx,0x8(%rax)
    bp->s.ptr = p->s.ptr->s.ptr;
 c43:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 c47:	48 8b 00             	mov    (%rax),%rax
 c4a:	48 8b 10             	mov    (%rax),%rdx
 c4d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 c51:	48 89 10             	mov    %rdx,(%rax)
 c54:	eb 0e                	jmp    c64 <free+0xc9>
  } else
    bp->s.ptr = p->s.ptr;
 c56:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 c5a:	48 8b 10             	mov    (%rax),%rdx
 c5d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 c61:	48 89 10             	mov    %rdx,(%rax)
  if(p + p->s.size == bp){
 c64:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 c68:	8b 40 08             	mov    0x8(%rax),%eax
 c6b:	89 c0                	mov    %eax,%eax
 c6d:	48 c1 e0 04          	shl    $0x4,%rax
 c71:	48 89 c2             	mov    %rax,%rdx
 c74:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 c78:	48 01 d0             	add    %rdx,%rax
 c7b:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
 c7f:	75 27                	jne    ca8 <free+0x10d>
    p->s.size += bp->s.size;
 c81:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 c85:	8b 50 08             	mov    0x8(%rax),%edx
 c88:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 c8c:	8b 40 08             	mov    0x8(%rax),%eax
 c8f:	01 c2                	add    %eax,%edx
 c91:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 c95:	89 50 08             	mov    %edx,0x8(%rax)
    p->s.ptr = bp->s.ptr;
 c98:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 c9c:	48 8b 10             	mov    (%rax),%rdx
 c9f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 ca3:	48 89 10             	mov    %rdx,(%rax)
 ca6:	eb 0b                	jmp    cb3 <free+0x118>
  } else
    p->s.ptr = bp;
 ca8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 cac:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
 cb0:	48 89 10             	mov    %rdx,(%rax)
  freep = p;
 cb3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 cb7:	48 89 05 a2 04 00 00 	mov    %rax,0x4a2(%rip)        # 1160 <freep>
}
 cbe:	90                   	nop
 cbf:	c9                   	leave
 cc0:	c3                   	ret

0000000000000cc1 <morecore>:

static Header*
morecore(uint nu)
{
 cc1:	55                   	push   %rbp
 cc2:	48 89 e5             	mov    %rsp,%rbp
 cc5:	48 83 ec 20          	sub    $0x20,%rsp
 cc9:	89 7d ec             	mov    %edi,-0x14(%rbp)
  char *p;
  Header *hp;

  if(nu < 4096)
 ccc:	81 7d ec ff 0f 00 00 	cmpl   $0xfff,-0x14(%rbp)
 cd3:	77 07                	ja     cdc <morecore+0x1b>
    nu = 4096;
 cd5:	c7 45 ec 00 10 00 00 	movl   $0x1000,-0x14(%rbp)
  p = sbrk(nu * sizeof(Header));
 cdc:	8b 45 ec             	mov    -0x14(%rbp),%eax
 cdf:	c1 e0 04             	shl    $0x4,%eax
 ce2:	89 c7                	mov    %eax,%edi
 ce4:	e8 40 fa ff ff       	call   729 <sbrk>
 ce9:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  if(p == (char*)-1)
 ced:	48 83 7d f8 ff       	cmpq   $0xffffffffffffffff,-0x8(%rbp)
 cf2:	75 07                	jne    cfb <morecore+0x3a>
    return 0;
 cf4:	b8 00 00 00 00       	mov    $0x0,%eax
 cf9:	eb 29                	jmp    d24 <morecore+0x63>
  hp = (Header*)p;
 cfb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 cff:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  hp->s.size = nu;
 d03:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 d07:	8b 55 ec             	mov    -0x14(%rbp),%edx
 d0a:	89 50 08             	mov    %edx,0x8(%rax)
  free((void*)(hp + 1));
 d0d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 d11:	48 83 c0 10          	add    $0x10,%rax
 d15:	48 89 c7             	mov    %rax,%rdi
 d18:	e8 7e fe ff ff       	call   b9b <free>
  return freep;
 d1d:	48 8b 05 3c 04 00 00 	mov    0x43c(%rip),%rax        # 1160 <freep>
}
 d24:	c9                   	leave
 d25:	c3                   	ret

0000000000000d26 <malloc>:

void*
malloc(uint nbytes)
{
 d26:	55                   	push   %rbp
 d27:	48 89 e5             	mov    %rsp,%rbp
 d2a:	48 83 ec 30          	sub    $0x30,%rsp
 d2e:	89 7d dc             	mov    %edi,-0x24(%rbp)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 d31:	8b 45 dc             	mov    -0x24(%rbp),%eax
 d34:	48 83 c0 0f          	add    $0xf,%rax
 d38:	48 c1 e8 04          	shr    $0x4,%rax
 d3c:	83 c0 01             	add    $0x1,%eax
 d3f:	89 45 ec             	mov    %eax,-0x14(%rbp)
  if((prevp = freep) == 0){
 d42:	48 8b 05 17 04 00 00 	mov    0x417(%rip),%rax        # 1160 <freep>
 d49:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
 d4d:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
 d52:	75 2b                	jne    d7f <malloc+0x59>
    base.s.ptr = freep = prevp = &base;
 d54:	48 c7 45 f0 50 11 00 	movq   $0x1150,-0x10(%rbp)
 d5b:	00 
 d5c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 d60:	48 89 05 f9 03 00 00 	mov    %rax,0x3f9(%rip)        # 1160 <freep>
 d67:	48 8b 05 f2 03 00 00 	mov    0x3f2(%rip),%rax        # 1160 <freep>
 d6e:	48 89 05 db 03 00 00 	mov    %rax,0x3db(%rip)        # 1150 <base>
    base.s.size = 0;
 d75:	c7 05 d9 03 00 00 00 	movl   $0x0,0x3d9(%rip)        # 1158 <base+0x8>
 d7c:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 d7f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 d83:	48 8b 00             	mov    (%rax),%rax
 d86:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
 d8a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 d8e:	8b 40 08             	mov    0x8(%rax),%eax
 d91:	3b 45 ec             	cmp    -0x14(%rbp),%eax
 d94:	72 5f                	jb     df5 <malloc+0xcf>
      if(p->s.size == nunits)
 d96:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 d9a:	8b 40 08             	mov    0x8(%rax),%eax
 d9d:	39 45 ec             	cmp    %eax,-0x14(%rbp)
 da0:	75 10                	jne    db2 <malloc+0x8c>
        prevp->s.ptr = p->s.ptr;
 da2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 da6:	48 8b 10             	mov    (%rax),%rdx
 da9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 dad:	48 89 10             	mov    %rdx,(%rax)
 db0:	eb 2e                	jmp    de0 <malloc+0xba>
      else {
        p->s.size -= nunits;
 db2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 db6:	8b 40 08             	mov    0x8(%rax),%eax
 db9:	2b 45 ec             	sub    -0x14(%rbp),%eax
 dbc:	89 c2                	mov    %eax,%edx
 dbe:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 dc2:	89 50 08             	mov    %edx,0x8(%rax)
        p += p->s.size;
 dc5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 dc9:	8b 40 08             	mov    0x8(%rax),%eax
 dcc:	89 c0                	mov    %eax,%eax
 dce:	48 c1 e0 04          	shl    $0x4,%rax
 dd2:	48 01 45 f8          	add    %rax,-0x8(%rbp)
        p->s.size = nunits;
 dd6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 dda:	8b 55 ec             	mov    -0x14(%rbp),%edx
 ddd:	89 50 08             	mov    %edx,0x8(%rax)
      }
      freep = prevp;
 de0:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 de4:	48 89 05 75 03 00 00 	mov    %rax,0x375(%rip)        # 1160 <freep>
      return (void*)(p + 1);
 deb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 def:	48 83 c0 10          	add    $0x10,%rax
 df3:	eb 41                	jmp    e36 <malloc+0x110>
    }
    if(p == freep)
 df5:	48 8b 05 64 03 00 00 	mov    0x364(%rip),%rax        # 1160 <freep>
 dfc:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 e00:	75 1c                	jne    e1e <malloc+0xf8>
      if((p = morecore(nunits)) == 0)
 e02:	8b 45 ec             	mov    -0x14(%rbp),%eax
 e05:	89 c7                	mov    %eax,%edi
 e07:	e8 b5 fe ff ff       	call   cc1 <morecore>
 e0c:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 e10:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
 e15:	75 07                	jne    e1e <malloc+0xf8>
        return 0;
 e17:	b8 00 00 00 00       	mov    $0x0,%eax
 e1c:	eb 18                	jmp    e36 <malloc+0x110>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 e1e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 e22:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
 e26:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 e2a:	48 8b 00             	mov    (%rax),%rax
 e2d:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
 e31:	e9 54 ff ff ff       	jmp    d8a <malloc+0x64>
  }
}
 e36:	c9                   	leave
 e37:	c3                   	ret
