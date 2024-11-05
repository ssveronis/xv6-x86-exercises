
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
      af:	48 c7 c6 45 10 00 00 	mov    $0x1045,%rsi
      b6:	bf 01 00 00 00       	mov    $0x1,%edi
      bb:	b8 00 00 00 00       	mov    $0x0,%eax
      c0:	e8 8e 07 00 00       	call   853 <printf>

    if (pstat->inuse[j] == 1) 
      c5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
      c9:	8b 55 f4             	mov    -0xc(%rbp),%edx
      cc:	48 63 d2             	movslq %edx,%rdx
      cf:	8b 04 90             	mov    (%rax,%rdx,4),%eax
      d2:	83 f8 01             	cmp    $0x1,%eax
      d5:	75 18                	jne    ef <print_info+0x78>
    {
        printf(1, "YES");
      d7:	48 c7 c6 4c 10 00 00 	mov    $0x104c,%rsi
      de:	bf 01 00 00 00       	mov    $0x1,%edi
      e3:	b8 00 00 00 00       	mov    $0x0,%eax
      e8:	e8 66 07 00 00       	call   853 <printf>
      ed:	eb 16                	jmp    105 <print_info+0x8e>
    }
    else 
    {
        printf(1, "NO");
      ef:	48 c7 c6 50 10 00 00 	mov    $0x1050,%rsi
      f6:	bf 01 00 00 00       	mov    $0x1,%edi
      fb:	b8 00 00 00 00       	mov    $0x0,%eax
     100:	e8 4e 07 00 00       	call   853 <printf>
    }

    printf(1, "\n");
     105:	48 c7 c6 53 10 00 00 	mov    $0x1053,%rsi
     10c:	bf 01 00 00 00       	mov    $0x1,%edi
     111:	b8 00 00 00 00       	mov    $0x0,%eax
     116:	e8 38 07 00 00       	call   853 <printf>
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
     1e3:	48 c7 c6 55 10 00 00 	mov    $0x1055,%rsi
     1ea:	bf 01 00 00 00       	mov    $0x1,%edi
     1ef:	b8 00 00 00 00       	mov    $0x0,%eax
     1f4:	e8 5a 06 00 00       	call   853 <printf>
    for (i = 0; i < N_C_PROCS; i++) 
     1f9:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
     200:	eb 25                	jmp    227 <main+0xc5>
    {
        printf(1, "- pid %d\n", pid_chds[i]);
     202:	8b 45 fc             	mov    -0x4(%rbp),%eax
     205:	48 98                	cltq
     207:	8b 44 85 d8          	mov    -0x28(%rbp,%rax,4),%eax
     20b:	89 c2                	mov    %eax,%edx
     20d:	48 c7 c6 6f 10 00 00 	mov    $0x106f,%rsi
     214:	bf 01 00 00 00       	mov    $0x1,%edi
     219:	b8 00 00 00 00       	mov    $0x0,%eax
     21e:	e8 30 06 00 00       	call   853 <printf>
    for (i = 0; i < N_C_PROCS; i++) 
     223:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
     227:	83 7d fc 02          	cmpl   $0x2,-0x4(%rbp)
     22b:	7e d5                	jle    202 <main+0xa0>
    }
    printf(1, "\n");
     22d:	48 c7 c6 53 10 00 00 	mov    $0x1053,%rsi
     234:	bf 01 00 00 00       	mov    $0x1,%edi
     239:	b8 00 00 00 00       	mov    $0x0,%eax
     23e:	e8 10 06 00 00       	call   853 <printf>

    printf(1, "PID\tTICKS\tIN USE\n");
     243:	48 c7 c6 79 10 00 00 	mov    $0x1079,%rsi
     24a:	bf 01 00 00 00       	mov    $0x1,%edi
     24f:	b8 00 00 00 00       	mov    $0x0,%eax
     254:	e8 fa 05 00 00       	call   853 <printf>
    
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
     282:	48 c7 c6 8b 10 00 00 	mov    $0x108b,%rsi
     289:	bf 01 00 00 00       	mov    $0x1,%edi
     28e:	b8 00 00 00 00       	mov    $0x0,%eax
     293:	e8 bb 05 00 00       	call   853 <printf>
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
     349:	48 c7 c6 53 10 00 00 	mov    $0x1053,%rsi
     350:	bf 01 00 00 00       	mov    $0x1,%edi
     355:	b8 00 00 00 00       	mov    $0x0,%eax
     35a:	e8 f4 04 00 00       	call   853 <printf>
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

0000000000000749 <getfavnum>:
SYSCALL(getfavnum)
     749:	b8 19 00 00 00       	mov    $0x19,%eax
     74e:	cd 40                	int    $0x40
     750:	c3                   	ret

0000000000000751 <shutdown>:
SYSCALL(shutdown)
     751:	b8 1a 00 00 00       	mov    $0x1a,%eax
     756:	cd 40                	int    $0x40
     758:	c3                   	ret

0000000000000759 <getcount>:
SYSCALL(getcount)
     759:	b8 1b 00 00 00       	mov    $0x1b,%eax
     75e:	cd 40                	int    $0x40
     760:	c3                   	ret

0000000000000761 <killrandom>:
     761:	b8 1c 00 00 00       	mov    $0x1c,%eax
     766:	cd 40                	int    $0x40
     768:	c3                   	ret

0000000000000769 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
     769:	55                   	push   %rbp
     76a:	48 89 e5             	mov    %rsp,%rbp
     76d:	48 83 ec 10          	sub    $0x10,%rsp
     771:	89 7d fc             	mov    %edi,-0x4(%rbp)
     774:	89 f0                	mov    %esi,%eax
     776:	88 45 f8             	mov    %al,-0x8(%rbp)
  write(fd, &c, 1);
     779:	48 8d 4d f8          	lea    -0x8(%rbp),%rcx
     77d:	8b 45 fc             	mov    -0x4(%rbp),%eax
     780:	ba 01 00 00 00       	mov    $0x1,%edx
     785:	48 89 ce             	mov    %rcx,%rsi
     788:	89 c7                	mov    %eax,%edi
     78a:	e8 32 ff ff ff       	call   6c1 <write>
}
     78f:	90                   	nop
     790:	c9                   	leave
     791:	c3                   	ret

0000000000000792 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     792:	55                   	push   %rbp
     793:	48 89 e5             	mov    %rsp,%rbp
     796:	48 83 ec 30          	sub    $0x30,%rsp
     79a:	89 7d dc             	mov    %edi,-0x24(%rbp)
     79d:	89 75 d8             	mov    %esi,-0x28(%rbp)
     7a0:	89 55 d4             	mov    %edx,-0x2c(%rbp)
     7a3:	89 4d d0             	mov    %ecx,-0x30(%rbp)
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
     7a6:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
  if(sgn && xx < 0){
     7ad:	83 7d d0 00          	cmpl   $0x0,-0x30(%rbp)
     7b1:	74 17                	je     7ca <printint+0x38>
     7b3:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
     7b7:	79 11                	jns    7ca <printint+0x38>
    neg = 1;
     7b9:	c7 45 f8 01 00 00 00 	movl   $0x1,-0x8(%rbp)
    x = -xx;
     7c0:	8b 45 d8             	mov    -0x28(%rbp),%eax
     7c3:	f7 d8                	neg    %eax
     7c5:	89 45 f4             	mov    %eax,-0xc(%rbp)
     7c8:	eb 06                	jmp    7d0 <printint+0x3e>
  } else {
    x = xx;
     7ca:	8b 45 d8             	mov    -0x28(%rbp),%eax
     7cd:	89 45 f4             	mov    %eax,-0xc(%rbp)
  }

  i = 0;
     7d0:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  do{
    buf[i++] = digits[x % base];
     7d7:	8b 4d d4             	mov    -0x2c(%rbp),%ecx
     7da:	8b 45 f4             	mov    -0xc(%rbp),%eax
     7dd:	ba 00 00 00 00       	mov    $0x0,%edx
     7e2:	f7 f1                	div    %ecx
     7e4:	89 d1                	mov    %edx,%ecx
     7e6:	8b 45 fc             	mov    -0x4(%rbp),%eax
     7e9:	8d 50 01             	lea    0x1(%rax),%edx
     7ec:	89 55 fc             	mov    %edx,-0x4(%rbp)
     7ef:	89 ca                	mov    %ecx,%edx
     7f1:	0f b6 92 e0 13 00 00 	movzbl 0x13e0(%rdx),%edx
     7f8:	48 98                	cltq
     7fa:	88 54 05 e0          	mov    %dl,-0x20(%rbp,%rax,1)
  }while((x /= base) != 0);
     7fe:	8b 75 d4             	mov    -0x2c(%rbp),%esi
     801:	8b 45 f4             	mov    -0xc(%rbp),%eax
     804:	ba 00 00 00 00       	mov    $0x0,%edx
     809:	f7 f6                	div    %esi
     80b:	89 45 f4             	mov    %eax,-0xc(%rbp)
     80e:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
     812:	75 c3                	jne    7d7 <printint+0x45>
  if(neg)
     814:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
     818:	74 2b                	je     845 <printint+0xb3>
    buf[i++] = '-';
     81a:	8b 45 fc             	mov    -0x4(%rbp),%eax
     81d:	8d 50 01             	lea    0x1(%rax),%edx
     820:	89 55 fc             	mov    %edx,-0x4(%rbp)
     823:	48 98                	cltq
     825:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%rbp,%rax,1)

  while(--i >= 0)
     82a:	eb 19                	jmp    845 <printint+0xb3>
    putc(fd, buf[i]);
     82c:	8b 45 fc             	mov    -0x4(%rbp),%eax
     82f:	48 98                	cltq
     831:	0f b6 44 05 e0       	movzbl -0x20(%rbp,%rax,1),%eax
     836:	0f be d0             	movsbl %al,%edx
     839:	8b 45 dc             	mov    -0x24(%rbp),%eax
     83c:	89 d6                	mov    %edx,%esi
     83e:	89 c7                	mov    %eax,%edi
     840:	e8 24 ff ff ff       	call   769 <putc>
  while(--i >= 0)
     845:	83 6d fc 01          	subl   $0x1,-0x4(%rbp)
     849:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
     84d:	79 dd                	jns    82c <printint+0x9a>
}
     84f:	90                   	nop
     850:	90                   	nop
     851:	c9                   	leave
     852:	c3                   	ret

0000000000000853 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
     853:	55                   	push   %rbp
     854:	48 89 e5             	mov    %rsp,%rbp
     857:	48 81 ec f0 00 00 00 	sub    $0xf0,%rsp
     85e:	89 bd 1c ff ff ff    	mov    %edi,-0xe4(%rbp)
     864:	48 89 b5 10 ff ff ff 	mov    %rsi,-0xf0(%rbp)
     86b:	48 89 95 60 ff ff ff 	mov    %rdx,-0xa0(%rbp)
     872:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
     879:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
     880:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
     887:	84 c0                	test   %al,%al
     889:	74 20                	je     8ab <printf+0x58>
     88b:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
     88f:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
     893:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
     897:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
     89b:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
     89f:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
     8a3:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
     8a7:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  va_list ap;
  char *s;
  int c, i, state;
  va_start(ap, fmt);
     8ab:	c7 85 20 ff ff ff 10 	movl   $0x10,-0xe0(%rbp)
     8b2:	00 00 00 
     8b5:	c7 85 24 ff ff ff 30 	movl   $0x30,-0xdc(%rbp)
     8bc:	00 00 00 
     8bf:	48 8d 45 10          	lea    0x10(%rbp),%rax
     8c3:	48 89 85 28 ff ff ff 	mov    %rax,-0xd8(%rbp)
     8ca:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
     8d1:	48 89 85 30 ff ff ff 	mov    %rax,-0xd0(%rbp)

  state = 0;
     8d8:	c7 85 40 ff ff ff 00 	movl   $0x0,-0xc0(%rbp)
     8df:	00 00 00 
  for(i = 0; fmt[i]; i++){
     8e2:	c7 85 44 ff ff ff 00 	movl   $0x0,-0xbc(%rbp)
     8e9:	00 00 00 
     8ec:	e9 a8 02 00 00       	jmp    b99 <printf+0x346>
    c = fmt[i] & 0xff;
     8f1:	8b 85 44 ff ff ff    	mov    -0xbc(%rbp),%eax
     8f7:	48 63 d0             	movslq %eax,%rdx
     8fa:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
     901:	48 01 d0             	add    %rdx,%rax
     904:	0f b6 00             	movzbl (%rax),%eax
     907:	0f be c0             	movsbl %al,%eax
     90a:	25 ff 00 00 00       	and    $0xff,%eax
     90f:	89 85 3c ff ff ff    	mov    %eax,-0xc4(%rbp)
    if(state == 0){
     915:	83 bd 40 ff ff ff 00 	cmpl   $0x0,-0xc0(%rbp)
     91c:	75 35                	jne    953 <printf+0x100>
      if(c == '%'){
     91e:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
     925:	75 0f                	jne    936 <printf+0xe3>
        state = '%';
     927:	c7 85 40 ff ff ff 25 	movl   $0x25,-0xc0(%rbp)
     92e:	00 00 00 
     931:	e9 5c 02 00 00       	jmp    b92 <printf+0x33f>
      } else {
        putc(fd, c);
     936:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
     93c:	0f be d0             	movsbl %al,%edx
     93f:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
     945:	89 d6                	mov    %edx,%esi
     947:	89 c7                	mov    %eax,%edi
     949:	e8 1b fe ff ff       	call   769 <putc>
     94e:	e9 3f 02 00 00       	jmp    b92 <printf+0x33f>
      }
    } else if(state == '%'){
     953:	83 bd 40 ff ff ff 25 	cmpl   $0x25,-0xc0(%rbp)
     95a:	0f 85 32 02 00 00    	jne    b92 <printf+0x33f>
      if(c == 'd'){
     960:	83 bd 3c ff ff ff 64 	cmpl   $0x64,-0xc4(%rbp)
     967:	75 5e                	jne    9c7 <printf+0x174>
        printint(fd, va_arg(ap, int), 10, 1);
     969:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
     96f:	83 f8 2f             	cmp    $0x2f,%eax
     972:	77 23                	ja     997 <printf+0x144>
     974:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
     97b:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
     981:	89 d2                	mov    %edx,%edx
     983:	48 01 d0             	add    %rdx,%rax
     986:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
     98c:	83 c2 08             	add    $0x8,%edx
     98f:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
     995:	eb 12                	jmp    9a9 <printf+0x156>
     997:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
     99e:	48 8d 50 08          	lea    0x8(%rax),%rdx
     9a2:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
     9a9:	8b 30                	mov    (%rax),%esi
     9ab:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
     9b1:	b9 01 00 00 00       	mov    $0x1,%ecx
     9b6:	ba 0a 00 00 00       	mov    $0xa,%edx
     9bb:	89 c7                	mov    %eax,%edi
     9bd:	e8 d0 fd ff ff       	call   792 <printint>
     9c2:	e9 c1 01 00 00       	jmp    b88 <printf+0x335>
      } else if(c == 'x' || c == 'p'){
     9c7:	83 bd 3c ff ff ff 78 	cmpl   $0x78,-0xc4(%rbp)
     9ce:	74 09                	je     9d9 <printf+0x186>
     9d0:	83 bd 3c ff ff ff 70 	cmpl   $0x70,-0xc4(%rbp)
     9d7:	75 5e                	jne    a37 <printf+0x1e4>
        printint(fd, va_arg(ap, int), 16, 0);
     9d9:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
     9df:	83 f8 2f             	cmp    $0x2f,%eax
     9e2:	77 23                	ja     a07 <printf+0x1b4>
     9e4:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
     9eb:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
     9f1:	89 d2                	mov    %edx,%edx
     9f3:	48 01 d0             	add    %rdx,%rax
     9f6:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
     9fc:	83 c2 08             	add    $0x8,%edx
     9ff:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
     a05:	eb 12                	jmp    a19 <printf+0x1c6>
     a07:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
     a0e:	48 8d 50 08          	lea    0x8(%rax),%rdx
     a12:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
     a19:	8b 30                	mov    (%rax),%esi
     a1b:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
     a21:	b9 00 00 00 00       	mov    $0x0,%ecx
     a26:	ba 10 00 00 00       	mov    $0x10,%edx
     a2b:	89 c7                	mov    %eax,%edi
     a2d:	e8 60 fd ff ff       	call   792 <printint>
     a32:	e9 51 01 00 00       	jmp    b88 <printf+0x335>
      } else if(c == 's'){
     a37:	83 bd 3c ff ff ff 73 	cmpl   $0x73,-0xc4(%rbp)
     a3e:	0f 85 98 00 00 00    	jne    adc <printf+0x289>
        s = va_arg(ap, char*);
     a44:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
     a4a:	83 f8 2f             	cmp    $0x2f,%eax
     a4d:	77 23                	ja     a72 <printf+0x21f>
     a4f:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
     a56:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
     a5c:	89 d2                	mov    %edx,%edx
     a5e:	48 01 d0             	add    %rdx,%rax
     a61:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
     a67:	83 c2 08             	add    $0x8,%edx
     a6a:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
     a70:	eb 12                	jmp    a84 <printf+0x231>
     a72:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
     a79:	48 8d 50 08          	lea    0x8(%rax),%rdx
     a7d:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
     a84:	48 8b 00             	mov    (%rax),%rax
     a87:	48 89 85 48 ff ff ff 	mov    %rax,-0xb8(%rbp)
        if(s == 0)
     a8e:	48 83 bd 48 ff ff ff 	cmpq   $0x0,-0xb8(%rbp)
     a95:	00 
     a96:	75 31                	jne    ac9 <printf+0x276>
          s = "(null)";
     a98:	48 c7 85 48 ff ff ff 	movq   $0x109c,-0xb8(%rbp)
     a9f:	9c 10 00 00 
        while(*s != 0){
     aa3:	eb 24                	jmp    ac9 <printf+0x276>
          putc(fd, *s);
     aa5:	48 8b 85 48 ff ff ff 	mov    -0xb8(%rbp),%rax
     aac:	0f b6 00             	movzbl (%rax),%eax
     aaf:	0f be d0             	movsbl %al,%edx
     ab2:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
     ab8:	89 d6                	mov    %edx,%esi
     aba:	89 c7                	mov    %eax,%edi
     abc:	e8 a8 fc ff ff       	call   769 <putc>
          s++;
     ac1:	48 83 85 48 ff ff ff 	addq   $0x1,-0xb8(%rbp)
     ac8:	01 
        while(*s != 0){
     ac9:	48 8b 85 48 ff ff ff 	mov    -0xb8(%rbp),%rax
     ad0:	0f b6 00             	movzbl (%rax),%eax
     ad3:	84 c0                	test   %al,%al
     ad5:	75 ce                	jne    aa5 <printf+0x252>
     ad7:	e9 ac 00 00 00       	jmp    b88 <printf+0x335>
        }
      } else if(c == 'c'){
     adc:	83 bd 3c ff ff ff 63 	cmpl   $0x63,-0xc4(%rbp)
     ae3:	75 56                	jne    b3b <printf+0x2e8>
        putc(fd, va_arg(ap, uint));
     ae5:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
     aeb:	83 f8 2f             	cmp    $0x2f,%eax
     aee:	77 23                	ja     b13 <printf+0x2c0>
     af0:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
     af7:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
     afd:	89 d2                	mov    %edx,%edx
     aff:	48 01 d0             	add    %rdx,%rax
     b02:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
     b08:	83 c2 08             	add    $0x8,%edx
     b0b:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
     b11:	eb 12                	jmp    b25 <printf+0x2d2>
     b13:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
     b1a:	48 8d 50 08          	lea    0x8(%rax),%rdx
     b1e:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
     b25:	8b 00                	mov    (%rax),%eax
     b27:	0f be d0             	movsbl %al,%edx
     b2a:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
     b30:	89 d6                	mov    %edx,%esi
     b32:	89 c7                	mov    %eax,%edi
     b34:	e8 30 fc ff ff       	call   769 <putc>
     b39:	eb 4d                	jmp    b88 <printf+0x335>
      } else if(c == '%'){
     b3b:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
     b42:	75 1a                	jne    b5e <printf+0x30b>
        putc(fd, c);
     b44:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
     b4a:	0f be d0             	movsbl %al,%edx
     b4d:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
     b53:	89 d6                	mov    %edx,%esi
     b55:	89 c7                	mov    %eax,%edi
     b57:	e8 0d fc ff ff       	call   769 <putc>
     b5c:	eb 2a                	jmp    b88 <printf+0x335>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
     b5e:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
     b64:	be 25 00 00 00       	mov    $0x25,%esi
     b69:	89 c7                	mov    %eax,%edi
     b6b:	e8 f9 fb ff ff       	call   769 <putc>
        putc(fd, c);
     b70:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
     b76:	0f be d0             	movsbl %al,%edx
     b79:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
     b7f:	89 d6                	mov    %edx,%esi
     b81:	89 c7                	mov    %eax,%edi
     b83:	e8 e1 fb ff ff       	call   769 <putc>
      }
      state = 0;
     b88:	c7 85 40 ff ff ff 00 	movl   $0x0,-0xc0(%rbp)
     b8f:	00 00 00 
  for(i = 0; fmt[i]; i++){
     b92:	83 85 44 ff ff ff 01 	addl   $0x1,-0xbc(%rbp)
     b99:	8b 85 44 ff ff ff    	mov    -0xbc(%rbp),%eax
     b9f:	48 63 d0             	movslq %eax,%rdx
     ba2:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
     ba9:	48 01 d0             	add    %rdx,%rax
     bac:	0f b6 00             	movzbl (%rax),%eax
     baf:	84 c0                	test   %al,%al
     bb1:	0f 85 3a fd ff ff    	jne    8f1 <printf+0x9e>
    }
  }
}
     bb7:	90                   	nop
     bb8:	90                   	nop
     bb9:	c9                   	leave
     bba:	c3                   	ret

0000000000000bbb <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
     bbb:	55                   	push   %rbp
     bbc:	48 89 e5             	mov    %rsp,%rbp
     bbf:	48 83 ec 18          	sub    $0x18,%rsp
     bc3:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  Header *bp, *p;

  bp = (Header*)ap - 1;
     bc7:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
     bcb:	48 83 e8 10          	sub    $0x10,%rax
     bcf:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     bd3:	48 8b 05 36 08 00 00 	mov    0x836(%rip),%rax        # 1410 <freep>
     bda:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
     bde:	eb 2f                	jmp    c0f <free+0x54>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     be0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     be4:	48 8b 00             	mov    (%rax),%rax
     be7:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
     beb:	72 17                	jb     c04 <free+0x49>
     bed:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
     bf1:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
     bf5:	72 2f                	jb     c26 <free+0x6b>
     bf7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     bfb:	48 8b 00             	mov    (%rax),%rax
     bfe:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
     c02:	72 22                	jb     c26 <free+0x6b>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     c04:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     c08:	48 8b 00             	mov    (%rax),%rax
     c0b:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
     c0f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
     c13:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
     c17:	73 c7                	jae    be0 <free+0x25>
     c19:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     c1d:	48 8b 00             	mov    (%rax),%rax
     c20:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
     c24:	73 ba                	jae    be0 <free+0x25>
      break;
  if(bp + bp->s.size == p->s.ptr){
     c26:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
     c2a:	8b 40 08             	mov    0x8(%rax),%eax
     c2d:	89 c0                	mov    %eax,%eax
     c2f:	48 c1 e0 04          	shl    $0x4,%rax
     c33:	48 89 c2             	mov    %rax,%rdx
     c36:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
     c3a:	48 01 c2             	add    %rax,%rdx
     c3d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     c41:	48 8b 00             	mov    (%rax),%rax
     c44:	48 39 c2             	cmp    %rax,%rdx
     c47:	75 2d                	jne    c76 <free+0xbb>
    bp->s.size += p->s.ptr->s.size;
     c49:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
     c4d:	8b 50 08             	mov    0x8(%rax),%edx
     c50:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     c54:	48 8b 00             	mov    (%rax),%rax
     c57:	8b 40 08             	mov    0x8(%rax),%eax
     c5a:	01 c2                	add    %eax,%edx
     c5c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
     c60:	89 50 08             	mov    %edx,0x8(%rax)
    bp->s.ptr = p->s.ptr->s.ptr;
     c63:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     c67:	48 8b 00             	mov    (%rax),%rax
     c6a:	48 8b 10             	mov    (%rax),%rdx
     c6d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
     c71:	48 89 10             	mov    %rdx,(%rax)
     c74:	eb 0e                	jmp    c84 <free+0xc9>
  } else
    bp->s.ptr = p->s.ptr;
     c76:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     c7a:	48 8b 10             	mov    (%rax),%rdx
     c7d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
     c81:	48 89 10             	mov    %rdx,(%rax)
  if(p + p->s.size == bp){
     c84:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     c88:	8b 40 08             	mov    0x8(%rax),%eax
     c8b:	89 c0                	mov    %eax,%eax
     c8d:	48 c1 e0 04          	shl    $0x4,%rax
     c91:	48 89 c2             	mov    %rax,%rdx
     c94:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     c98:	48 01 d0             	add    %rdx,%rax
     c9b:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
     c9f:	75 27                	jne    cc8 <free+0x10d>
    p->s.size += bp->s.size;
     ca1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     ca5:	8b 50 08             	mov    0x8(%rax),%edx
     ca8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
     cac:	8b 40 08             	mov    0x8(%rax),%eax
     caf:	01 c2                	add    %eax,%edx
     cb1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     cb5:	89 50 08             	mov    %edx,0x8(%rax)
    p->s.ptr = bp->s.ptr;
     cb8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
     cbc:	48 8b 10             	mov    (%rax),%rdx
     cbf:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     cc3:	48 89 10             	mov    %rdx,(%rax)
     cc6:	eb 0b                	jmp    cd3 <free+0x118>
  } else
    p->s.ptr = bp;
     cc8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     ccc:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
     cd0:	48 89 10             	mov    %rdx,(%rax)
  freep = p;
     cd3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     cd7:	48 89 05 32 07 00 00 	mov    %rax,0x732(%rip)        # 1410 <freep>
}
     cde:	90                   	nop
     cdf:	c9                   	leave
     ce0:	c3                   	ret

0000000000000ce1 <morecore>:

static Header*
morecore(uint nu)
{
     ce1:	55                   	push   %rbp
     ce2:	48 89 e5             	mov    %rsp,%rbp
     ce5:	48 83 ec 20          	sub    $0x20,%rsp
     ce9:	89 7d ec             	mov    %edi,-0x14(%rbp)
  char *p;
  Header *hp;

  if(nu < 4096)
     cec:	81 7d ec ff 0f 00 00 	cmpl   $0xfff,-0x14(%rbp)
     cf3:	77 07                	ja     cfc <morecore+0x1b>
    nu = 4096;
     cf5:	c7 45 ec 00 10 00 00 	movl   $0x1000,-0x14(%rbp)
  p = sbrk(nu * sizeof(Header));
     cfc:	8b 45 ec             	mov    -0x14(%rbp),%eax
     cff:	c1 e0 04             	shl    $0x4,%eax
     d02:	89 c7                	mov    %eax,%edi
     d04:	e8 20 fa ff ff       	call   729 <sbrk>
     d09:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  if(p == (char*)-1)
     d0d:	48 83 7d f8 ff       	cmpq   $0xffffffffffffffff,-0x8(%rbp)
     d12:	75 07                	jne    d1b <morecore+0x3a>
    return 0;
     d14:	b8 00 00 00 00       	mov    $0x0,%eax
     d19:	eb 29                	jmp    d44 <morecore+0x63>
  hp = (Header*)p;
     d1b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     d1f:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  hp->s.size = nu;
     d23:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
     d27:	8b 55 ec             	mov    -0x14(%rbp),%edx
     d2a:	89 50 08             	mov    %edx,0x8(%rax)
  free((void*)(hp + 1));
     d2d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
     d31:	48 83 c0 10          	add    $0x10,%rax
     d35:	48 89 c7             	mov    %rax,%rdi
     d38:	e8 7e fe ff ff       	call   bbb <free>
  return freep;
     d3d:	48 8b 05 cc 06 00 00 	mov    0x6cc(%rip),%rax        # 1410 <freep>
}
     d44:	c9                   	leave
     d45:	c3                   	ret

0000000000000d46 <malloc>:

void*
malloc(uint nbytes)
{
     d46:	55                   	push   %rbp
     d47:	48 89 e5             	mov    %rsp,%rbp
     d4a:	48 83 ec 30          	sub    $0x30,%rsp
     d4e:	89 7d dc             	mov    %edi,-0x24(%rbp)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
     d51:	8b 45 dc             	mov    -0x24(%rbp),%eax
     d54:	48 83 c0 0f          	add    $0xf,%rax
     d58:	48 c1 e8 04          	shr    $0x4,%rax
     d5c:	83 c0 01             	add    $0x1,%eax
     d5f:	89 45 ec             	mov    %eax,-0x14(%rbp)
  if((prevp = freep) == 0){
     d62:	48 8b 05 a7 06 00 00 	mov    0x6a7(%rip),%rax        # 1410 <freep>
     d69:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
     d6d:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
     d72:	75 2b                	jne    d9f <malloc+0x59>
    base.s.ptr = freep = prevp = &base;
     d74:	48 c7 45 f0 00 14 00 	movq   $0x1400,-0x10(%rbp)
     d7b:	00 
     d7c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
     d80:	48 89 05 89 06 00 00 	mov    %rax,0x689(%rip)        # 1410 <freep>
     d87:	48 8b 05 82 06 00 00 	mov    0x682(%rip),%rax        # 1410 <freep>
     d8e:	48 89 05 6b 06 00 00 	mov    %rax,0x66b(%rip)        # 1400 <base>
    base.s.size = 0;
     d95:	c7 05 69 06 00 00 00 	movl   $0x0,0x669(%rip)        # 1408 <base+0x8>
     d9c:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     d9f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
     da3:	48 8b 00             	mov    (%rax),%rax
     da6:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
     daa:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     dae:	8b 40 08             	mov    0x8(%rax),%eax
     db1:	3b 45 ec             	cmp    -0x14(%rbp),%eax
     db4:	72 5f                	jb     e15 <malloc+0xcf>
      if(p->s.size == nunits)
     db6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     dba:	8b 40 08             	mov    0x8(%rax),%eax
     dbd:	39 45 ec             	cmp    %eax,-0x14(%rbp)
     dc0:	75 10                	jne    dd2 <malloc+0x8c>
        prevp->s.ptr = p->s.ptr;
     dc2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     dc6:	48 8b 10             	mov    (%rax),%rdx
     dc9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
     dcd:	48 89 10             	mov    %rdx,(%rax)
     dd0:	eb 2e                	jmp    e00 <malloc+0xba>
      else {
        p->s.size -= nunits;
     dd2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     dd6:	8b 40 08             	mov    0x8(%rax),%eax
     dd9:	2b 45 ec             	sub    -0x14(%rbp),%eax
     ddc:	89 c2                	mov    %eax,%edx
     dde:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     de2:	89 50 08             	mov    %edx,0x8(%rax)
        p += p->s.size;
     de5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     de9:	8b 40 08             	mov    0x8(%rax),%eax
     dec:	89 c0                	mov    %eax,%eax
     dee:	48 c1 e0 04          	shl    $0x4,%rax
     df2:	48 01 45 f8          	add    %rax,-0x8(%rbp)
        p->s.size = nunits;
     df6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     dfa:	8b 55 ec             	mov    -0x14(%rbp),%edx
     dfd:	89 50 08             	mov    %edx,0x8(%rax)
      }
      freep = prevp;
     e00:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
     e04:	48 89 05 05 06 00 00 	mov    %rax,0x605(%rip)        # 1410 <freep>
      return (void*)(p + 1);
     e0b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     e0f:	48 83 c0 10          	add    $0x10,%rax
     e13:	eb 41                	jmp    e56 <malloc+0x110>
    }
    if(p == freep)
     e15:	48 8b 05 f4 05 00 00 	mov    0x5f4(%rip),%rax        # 1410 <freep>
     e1c:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
     e20:	75 1c                	jne    e3e <malloc+0xf8>
      if((p = morecore(nunits)) == 0)
     e22:	8b 45 ec             	mov    -0x14(%rbp),%eax
     e25:	89 c7                	mov    %eax,%edi
     e27:	e8 b5 fe ff ff       	call   ce1 <morecore>
     e2c:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
     e30:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
     e35:	75 07                	jne    e3e <malloc+0xf8>
        return 0;
     e37:	b8 00 00 00 00       	mov    $0x0,%eax
     e3c:	eb 18                	jmp    e56 <malloc+0x110>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     e3e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     e42:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
     e46:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     e4a:	48 8b 00             	mov    (%rax),%rax
     e4d:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
     e51:	e9 54 ff ff ff       	jmp    daa <malloc+0x64>
  }
}
     e56:	c9                   	leave
     e57:	c3                   	ret

0000000000000e58 <createRoot>:
#include "set.h"
#include "user.h"

//TODO: Να μην είναι περιορισμένο σε int

Set* createRoot(){
     e58:	55                   	push   %rbp
     e59:	48 89 e5             	mov    %rsp,%rbp
     e5c:	48 83 ec 10          	sub    $0x10,%rsp
    //Αρχικοποίηση του Set
    Set *set = malloc(sizeof(Set));
     e60:	bf 10 00 00 00       	mov    $0x10,%edi
     e65:	e8 dc fe ff ff       	call   d46 <malloc>
     e6a:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    set->size = 0;
     e6e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     e72:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%rax)
    set->root = NULL;
     e79:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     e7d:	48 c7 00 00 00 00 00 	movq   $0x0,(%rax)
    return set;
     e84:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
     e88:	c9                   	leave
     e89:	c3                   	ret

0000000000000e8a <createNode>:

void createNode(int i, Set *set){
     e8a:	55                   	push   %rbp
     e8b:	48 89 e5             	mov    %rsp,%rbp
     e8e:	48 83 ec 20          	sub    $0x20,%rsp
     e92:	89 7d ec             	mov    %edi,-0x14(%rbp)
     e95:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    Η συνάρτηση αυτή δημιουργεί ένα νέο SetNode με την τιμή i και εφόσον δεν υπάρχει στο Set το προσθέτει στο τέλος του συνόλου.
    Σημείωση: Ίσως υπάρχει καλύτερος τρόπος για την υλοποίηση.
    */

    //Αρχικοποίηση του SetNode
    SetNode *temp = malloc(sizeof(SetNode));
     e99:	bf 10 00 00 00       	mov    $0x10,%edi
     e9e:	e8 a3 fe ff ff       	call   d46 <malloc>
     ea3:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    temp->i = i;
     ea7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
     eab:	8b 55 ec             	mov    -0x14(%rbp),%edx
     eae:	89 10                	mov    %edx,(%rax)
    temp->next = NULL;
     eb0:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
     eb4:	48 c7 40 08 00 00 00 	movq   $0x0,0x8(%rax)
     ebb:	00 

    //Έλεγχος ύπαρξης του i
    SetNode *curr = set->root;//Ξεκινάει από την root
     ebc:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
     ec0:	48 8b 00             	mov    (%rax),%rax
     ec3:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(curr != NULL) { //Εφόσον το Set δεν είναι άδειο
     ec7:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
     ecc:	74 34                	je     f02 <createNode+0x78>
        while (curr->next != NULL){ //Εφόσον υπάρχει επόμενο node
     ece:	eb 25                	jmp    ef5 <createNode+0x6b>
            if (curr->i == i){ //Αν το i υπάρχει στο σύνολο
     ed0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     ed4:	8b 00                	mov    (%rax),%eax
     ed6:	39 45 ec             	cmp    %eax,-0x14(%rbp)
     ed9:	75 0e                	jne    ee9 <createNode+0x5f>
                free(temp); 
     edb:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
     edf:	48 89 c7             	mov    %rax,%rdi
     ee2:	e8 d4 fc ff ff       	call   bbb <free>
                return; //Δεν εκτελούμε την υπόλοιπη συνάρτηση
     ee7:	eb 4e                	jmp    f37 <createNode+0xad>
            }
            curr = curr->next; //Επόμενο SetNode
     ee9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     eed:	48 8b 40 08          	mov    0x8(%rax),%rax
     ef1:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
        while (curr->next != NULL){ //Εφόσον υπάρχει επόμενο node
     ef5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     ef9:	48 8b 40 08          	mov    0x8(%rax),%rax
     efd:	48 85 c0             	test   %rax,%rax
     f00:	75 ce                	jne    ed0 <createNode+0x46>
        }
    }
    /*
    Ο έλεγχος στην if είναι απαραίτητος για να ελεγχθεί το τελευταίο SetNode.
    */
    if (curr->i != i) attachNode(set, curr, temp); 
     f02:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     f06:	8b 00                	mov    (%rax),%eax
     f08:	39 45 ec             	cmp    %eax,-0x14(%rbp)
     f0b:	74 1e                	je     f2b <createNode+0xa1>
     f0d:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
     f11:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
     f15:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
     f19:	48 89 ce             	mov    %rcx,%rsi
     f1c:	48 89 c7             	mov    %rax,%rdi
     f1f:	b8 00 00 00 00       	mov    $0x0,%eax
     f24:	e8 10 00 00 00       	call   f39 <attachNode>
     f29:	eb 0c                	jmp    f37 <createNode+0xad>
    else free(temp);
     f2b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
     f2f:	48 89 c7             	mov    %rax,%rdi
     f32:	e8 84 fc ff ff       	call   bbb <free>
}
     f37:	c9                   	leave
     f38:	c3                   	ret

0000000000000f39 <attachNode>:

void attachNode(Set *set, SetNode *curr, SetNode *temp){
     f39:	55                   	push   %rbp
     f3a:	48 89 e5             	mov    %rsp,%rbp
     f3d:	48 83 ec 18          	sub    $0x18,%rsp
     f41:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
     f45:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
     f49:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
    //Βάζουμε το temp στο τέλος του Set
    if(set->size == 0) set->root = temp;
     f4d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     f51:	8b 40 08             	mov    0x8(%rax),%eax
     f54:	85 c0                	test   %eax,%eax
     f56:	75 0d                	jne    f65 <attachNode+0x2c>
     f58:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     f5c:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
     f60:	48 89 10             	mov    %rdx,(%rax)
     f63:	eb 0c                	jmp    f71 <attachNode+0x38>
    else curr->next = temp;
     f65:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
     f69:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
     f6d:	48 89 50 08          	mov    %rdx,0x8(%rax)
    set->size += 1;
     f71:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     f75:	8b 40 08             	mov    0x8(%rax),%eax
     f78:	8d 50 01             	lea    0x1(%rax),%edx
     f7b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     f7f:	89 50 08             	mov    %edx,0x8(%rax)
}
     f82:	90                   	nop
     f83:	c9                   	leave
     f84:	c3                   	ret

0000000000000f85 <deleteSet>:

void deleteSet(Set *set){
     f85:	55                   	push   %rbp
     f86:	48 89 e5             	mov    %rsp,%rbp
     f89:	48 83 ec 20          	sub    $0x20,%rsp
     f8d:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    if (set == NULL) return; //Αν ο χρήστης είναι ΜΛΚ!
     f91:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
     f96:	74 42                	je     fda <deleteSet+0x55>
    SetNode *temp;
    SetNode *curr = set->root; //Ξεκινάμε από το root
     f98:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
     f9c:	48 8b 00             	mov    (%rax),%rax
     f9f:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    while (curr != NULL){ 
     fa3:	eb 20                	jmp    fc5 <deleteSet+0x40>
        temp = curr->next; //Αναφορά στο επόμενο SetNode
     fa5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     fa9:	48 8b 40 08          	mov    0x8(%rax),%rax
     fad:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
        free(curr); //Απελευθέρωση της curr
     fb1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
     fb5:	48 89 c7             	mov    %rax,%rdi
     fb8:	e8 fe fb ff ff       	call   bbb <free>
        curr = temp;
     fbd:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
     fc1:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    while (curr != NULL){ 
     fc5:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
     fca:	75 d9                	jne    fa5 <deleteSet+0x20>
    }
    free(set); //Διαγραφή του Set
     fcc:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
     fd0:	48 89 c7             	mov    %rax,%rdi
     fd3:	e8 e3 fb ff ff       	call   bbb <free>
     fd8:	eb 01                	jmp    fdb <deleteSet+0x56>
    if (set == NULL) return; //Αν ο χρήστης είναι ΜΛΚ!
     fda:	90                   	nop
}
     fdb:	c9                   	leave
     fdc:	c3                   	ret

0000000000000fdd <getNodeAtPosition>:

SetNode* getNodeAtPosition(Set *set, int i){
     fdd:	55                   	push   %rbp
     fde:	48 89 e5             	mov    %rsp,%rbp
     fe1:	48 83 ec 20          	sub    $0x20,%rsp
     fe5:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
     fe9:	89 75 e4             	mov    %esi,-0x1c(%rbp)
    if (set == NULL || set->root == NULL) return NULL; //Αν ο χρήστης είναι ΜΛΚ!
     fec:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
     ff1:	74 0c                	je     fff <getNodeAtPosition+0x22>
     ff3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
     ff7:	48 8b 00             	mov    (%rax),%rax
     ffa:	48 85 c0             	test   %rax,%rax
     ffd:	75 07                	jne    1006 <getNodeAtPosition+0x29>
     fff:	b8 00 00 00 00       	mov    $0x0,%eax
    1004:	eb 3d                	jmp    1043 <getNodeAtPosition+0x66>

    SetNode *curr = set->root;
    1006:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    100a:	48 8b 00             	mov    (%rax),%rax
    100d:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    int n;

    for(n = 0; n<i && curr->next != NULL; n++) curr = curr->next; //Ο έλεγχος εδω είναι: n<i && curr->next != NULL
    1011:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
    1018:	eb 10                	jmp    102a <getNodeAtPosition+0x4d>
    101a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    101e:	48 8b 40 08          	mov    0x8(%rax),%rax
    1022:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    1026:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
    102a:	8b 45 f4             	mov    -0xc(%rbp),%eax
    102d:	3b 45 e4             	cmp    -0x1c(%rbp),%eax
    1030:	7d 0d                	jge    103f <getNodeAtPosition+0x62>
    1032:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1036:	48 8b 40 08          	mov    0x8(%rax),%rax
    103a:	48 85 c0             	test   %rax,%rax
    103d:	75 db                	jne    101a <getNodeAtPosition+0x3d>
    return curr;
    103f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1043:	c9                   	leave
    1044:	c3                   	ret
